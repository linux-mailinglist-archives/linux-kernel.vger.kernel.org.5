Return-Path: <linux-kernel+bounces-151120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3564E8AA95D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9129B217A0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0562646452;
	Fri, 19 Apr 2024 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gOCiSZp7"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09B91DFC5;
	Fri, 19 Apr 2024 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713512428; cv=none; b=vAKocTZmamBk3pwkzJtwpx6Q+qSZIeO49vCjldUGCEaRtd3FDSm4oXoPdr9iiPxKB/DWTjHDZgbHIPDNPS0p5dP69GwGBBekYoz1grSk2p0sA9U22M6dLB4+tKj0e+5DpsLluqIAStZaKl7Qh0RZnemqpH1/I+1gEYBi8y+Xer8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713512428; c=relaxed/simple;
	bh=W/wi9e5UBK+Wu+Dsx1s02GeUnADp2GIoRZR8c6T4osA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsN0165UY0Ywa4JlMiu0JURitcB4ChxVkWT2rpl8W3PDBF4E9uPDI9xPn1581E78SQ4qHZMNsvs6mJSN49lS3wgygf7hoCEOQ8VbNkwZ/WZhBI3+MIfFwEM2NjH9qUVi8QVqq/yrMPVrhg/BBRSJM9o3BvGuoUEVScpK9bJVJ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gOCiSZp7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713512424;
	bh=W/wi9e5UBK+Wu+Dsx1s02GeUnADp2GIoRZR8c6T4osA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gOCiSZp74yYzUrOFKOX2tlJw04+WM/R4MfrvttLuUnU7i+tzNH5NAA0E142iiSwAS
	 pFmOu0dGZdFfKJuubuHztaVs98IxsKPfLwfKNJPP/LmW7RpaEqhqQ3HhGRZFPU9BAS
	 cYDtio0y+GRc/Oi5z0V6+df5sVLitmBMAjoDNe1Fsv/1SfYfJGIq0wYlhYTaWzqSSi
	 cfu9ew/ROizc1XomMH7DR7aNbG0o8/X+s3r0vuh/hf4LyGdbNzG+BQMuforbTQr8zJ
	 t02M4jwW6blvnRXg0VCBMiHkrzE/+oc4ArbG5CFPl0qMB4MsY6pbFpj41SXoxUoT/X
	 fJPHvQpuvaf+Q==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 86D0A3782149;
	Fri, 19 Apr 2024 07:40:23 +0000 (UTC)
Message-ID: <28b0eeff-55ed-4e30-ac0b-a7bcac276fe9@collabora.com>
Date: Fri, 19 Apr 2024 09:40:22 +0200
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
 <8600acf8-7b51-456b-8a81-4233cfd6f121@collabora.com>
 <CAA8EJpo68f=9ZyNnVY=+q+drHu9xJMSGk1kNCBa=HM442Jth8g@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAA8EJpo68f=9ZyNnVY=+q+drHu9xJMSGk1kNCBa=HM442Jth8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/04/24 17:45, Dmitry Baryshkov ha scritto:
> On Tue, 9 Apr 2024 at 18:41, AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 09/04/24 17:20, Dmitry Baryshkov ha scritto:
>>> On Tue, Apr 09, 2024 at 02:02:09PM +0200, AngeloGioacchino Del Regno wrote:
>>>> The display IPs in MediaTek SoCs support being interconnected with
>>>> different instances of DDP IPs (for example, merge0 or merge1) and/or
>>>> with different DDP IPs (for example, rdma can be connected with either
>>>> color, dpi, dsi, merge, etc), forming a full Display Data Path that
>>>> ends with an actual display.
>>>>
>>>> The final display pipeline is effectively board specific, as it does
>>>> depend on the display that is attached to it, and eventually on the
>>>> sensors supported by the board (for example, Adaptive Ambient Light
>>>> would need an Ambient Light Sensor, otherwise it's pointless!), other
>>>> than the output type.
>>>
>>> With the color and gamma being in play, should the configuration be
>>> board-driver or rather use-case driven with the driver being able to
>>> reroute some of the blocks at runtime?
>>>
>>
>> The driver can already set some blocks to "BYPASS MODE" at runtime, meaning
>> that those will work as simple pass-through, performing *no* processing at
>> all, so that's addressed from the very beginning.
>>
>> This doesn't mean that a specific pipeline must always support the "DISP_GAMMA"
>> or the "DISP_CCOLOR" block(s) alone, or together, or in combination with another
>> specific block.
> 
> I was thinking about slightly different case: do you have enough
> colour blocks to drive all outputs or do you have to select them for
> the particular output only?

Sorry for the very very very very .. very late reply, your email slipped through
the cracks and I just noticed it.

That depends on the SoC, but generally... no, you have to select them for the
particular output.

There is a restricted set of outputs that support this block, but between this
set, there are still not enough blocks for all of them.

> 
> (excuse me, I didn't check the platform details).

You (and me, and everyone else) can't really invest hours of time to check on
how each and every SoC on the planet works - that's normal.

No worries ;-)

Cheers,
Angelo

> 
>> For any other question, clarification, etc, I'm here :-)
>>
>> Cheers!
>>
>>>>
>>>> Add support for OF graphs to most of the MediaTek DDP (display) bindings
>>>> to add flexibility to build custom hardware paths, hence enabling board
>>>> specific configuration of the display pipeline and allowing to finally
>>>> migrate away from using hardcoded paths.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>
>>
> 
> 



