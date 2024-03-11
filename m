Return-Path: <linux-kernel+bounces-98576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A52C877C41
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B8828222F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC72713AE8;
	Mon, 11 Mar 2024 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="F3gbBwhr"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B4E12E58;
	Mon, 11 Mar 2024 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710147926; cv=none; b=SEVhujvuayoNqOATniou2vjtcMyWy6F8ya/snA28kgVh59zjoSZr/Jy0MVdh0iyPt5HwZ86jA8r38WNd6VpbkaxEvOY7eYoI6IWZWQov73zwLd4qfdp+XeVNJRkUMTAC3pYL/I2pwMSHZ9l70wQq8SO6n2SBsN+iBaHW8VNXeag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710147926; c=relaxed/simple;
	bh=LXDSRxlCG5CCneQuaLmC2tK3UwO3onm86dAkvFUIKWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fx1dXZvXDUQ812+RVjKrzbYTDcVY7JKKmNnCXZrgIvE0j0Gf2roLA3zMf3LxdyeCXV2REfHypLpNo/aiaZqBdf/fxDlNgy6e6OtNgtUshPKUo4pg5ouJUg0puXK1jR/ThoZ0nECxN8lMZ4lOtuUEbBUtoGNCoAti7SKlvlX9nMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=F3gbBwhr; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710147404;
	bh=LXDSRxlCG5CCneQuaLmC2tK3UwO3onm86dAkvFUIKWQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F3gbBwhrhfInMUCcHzDvlAviU2qW0BhsNaWhd4AciDCfigP6s49NtcSLChisuolP1
	 yRcwSCW3dcoWBlWr5pHM7+IstmJ7fvjmD1vZ4/Tcg31pRhtJUi4dpn0NdrD927/M3c
	 n1x8GEY+ulYCLd0TfAi2WANCJUjZcpy96YAMBkfvnxB3XujRXIzW3zxYvExmMCTZuz
	 yVdIKu9LydYr/kVSUX9PTGT0Tpbsl/dWOUUf7YkFdsDy645n/s2ZZ/5epYf8VV7Kdb
	 wbIPwB04Wd0yl2Dq53EAhZG4v8IeQCfnBmZlfP8OPXNTHysWgiKtIgiijkaR22GFby
	 37/lqySviz8KA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 790EE3780C21;
	Mon, 11 Mar 2024 08:56:43 +0000 (UTC)
Message-ID: <f7fb18dc-817e-4d93-94a8-a4b7493cc8a6@collabora.com>
Date: Mon, 11 Mar 2024 09:56:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: pllfh: Don't log error for missing fhctl
 node
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Johnson Wang <johnson.wang@mediatek.com>,
 Edward-JW Yang <edward-jw.yang@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240308-mtk-fhctl-no-node-error-v1-1-51e446eb149a@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240308-mtk-fhctl-no-node-error-v1-1-51e446eb149a@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 08/03/24 21:29, Nícolas F. R. A. Prado ha scritto:
> Support for fhctl clocks in apmixedsys was introduced at a later point
> and to this moment only one mt6795 based platform has a fhctl DT node
> present. Therefore the fhctl support in apmixedsys should be seen as
> optional and not cause an error when it is missing.
> 
> Change the message's log level to warning. The warning level is chosen
> so that it will still alert the fact that fhctl support might be
> unintentionally missing, but without implying that this is necessarily
> an issue.
> 
> Even if the FHCTL DT nodes are added to all current platforms moving
> forward, since those changes won't be backported, this ensures stable
> kernel releases won't have live with this error.
> 
> Fixes: d7964de8a8ea ("clk: mediatek: Add new clock driver to handle FHCTL hardware")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



