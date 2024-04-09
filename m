Return-Path: <linux-kernel+bounces-137250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4298589DF7A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D736E1F2165A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFA913B2A4;
	Tue,  9 Apr 2024 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e1IHAFPW"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A70D13A275;
	Tue,  9 Apr 2024 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677310; cv=none; b=fYawH/BdhV9p2olEuLPauxTbU05kiA9mZT6ClFw1oxn2HcDN2aaor/fqFT3DrDTxjNvE2L13peZqtAz6R4DIDF+z/iNjRPPSoMoNLm29UG4gMHpT7DW7Z1f1OhZP0XUhFkMuLKlwr9dAUAM1ru/qL+xtIsEdPHKxUWOl3CnGz8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677310; c=relaxed/simple;
	bh=hU8CbjeCVQ/KTmATBPDlklumAOoUvo7TYj2qC4NSoP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgGc1XM5jqIzcOJ/4LQjNPwa/UjS+0jQLalNFCSLR0SGKKPeeZTaaNgR2tXqG24V86zKXH6wpEtnpyIYc0RP5e6Eel3C8Fe6kpGqVvfhLEwEjMN6lA4z7si7EEJ/Qqq6FdR0/rcYSNkE3a6UV7/H5+PaRQJ38boPVHgRcUJtkFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e1IHAFPW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712677306;
	bh=hU8CbjeCVQ/KTmATBPDlklumAOoUvo7TYj2qC4NSoP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e1IHAFPWRx25op5CE12Fp8/khLbdxEH5ppYWqP835pkW9TApEU6PaZcAT+8ph7Q3Y
	 6GZKGEexwxC+9uhcIEVi6y0rjoadJ0l9I55YWlQJ2E5EW+u6LHeqqANcbk9NzGBST+
	 uYsZjOx7nnCwRrtugObo0LxNuLYm76E4GypNsseL2Abimxf85gEY7LdzWU1oLEEWJE
	 lH8ZnMKT5SqWQ4sQuSLmZFhDYl/qaeijQrXFSnmRJ2VNTo/1/s60q93IzgoWlFkzRp
	 Lizj5nEys1ZJWgLbjoXX+bkonwn/rQ+uzMbPeZuDbGObjbHVK9kn7obaNzcUyuOY+H
	 b+HobMB7rhARQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 97B2637813CA;
	Tue,  9 Apr 2024 15:41:44 +0000 (UTC)
Message-ID: <8600acf8-7b51-456b-8a81-4233cfd6f121@collabora.com>
Date: Tue, 9 Apr 2024 17:41:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: display: mediatek: Add OF graph
 support for board path
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: chunkuang.hu@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 matthias.bgg@gmail.com, shawn.sung@mediatek.com, yu-chang.lee@mediatek.com,
 ck.hu@mediatek.com, jitao.shi@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 wenst@chromium.org, kernel@collabora.com
References: <20240409120211.321153-1-angelogioacchino.delregno@collabora.com>
 <20240409120211.321153-2-angelogioacchino.delregno@collabora.com>
 <oe75tx35rd27r2a24ofdxfaqwr53tylfp5fwz3nrwc2uz6nmrs@vwc2krbpy3fh>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <oe75tx35rd27r2a24ofdxfaqwr53tylfp5fwz3nrwc2uz6nmrs@vwc2krbpy3fh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/04/24 17:20, Dmitry Baryshkov ha scritto:
> On Tue, Apr 09, 2024 at 02:02:09PM +0200, AngeloGioacchino Del Regno wrote:
>> The display IPs in MediaTek SoCs support being interconnected with
>> different instances of DDP IPs (for example, merge0 or merge1) and/or
>> with different DDP IPs (for example, rdma can be connected with either
>> color, dpi, dsi, merge, etc), forming a full Display Data Path that
>> ends with an actual display.
>>
>> The final display pipeline is effectively board specific, as it does
>> depend on the display that is attached to it, and eventually on the
>> sensors supported by the board (for example, Adaptive Ambient Light
>> would need an Ambient Light Sensor, otherwise it's pointless!), other
>> than the output type.
> 
> With the color and gamma being in play, should the configuration be
> board-driver or rather use-case driven with the driver being able to
> reroute some of the blocks at runtime?
> 

The driver can already set some blocks to "BYPASS MODE" at runtime, meaning
that those will work as simple pass-through, performing *no* processing at
all, so that's addressed from the very beginning.

This doesn't mean that a specific pipeline must always support the "DISP_GAMMA"
or the "DISP_CCOLOR" block(s) alone, or together, or in combination with another
specific block.

For any other question, clarification, etc, I'm here :-)

Cheers!

>>
>> Add support for OF graphs to most of the MediaTek DDP (display) bindings
>> to add flexibility to build custom hardware paths, hence enabling board
>> specific configuration of the display pipeline and allowing to finally
>> migrate away from using hardcoded paths.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 


