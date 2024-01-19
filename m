Return-Path: <linux-kernel+bounces-30940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 786C9832655
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181251F23A2B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34524288DF;
	Fri, 19 Jan 2024 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="z3P4C5rp"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D99288CE;
	Fri, 19 Jan 2024 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705655532; cv=none; b=Ie7iCQRIeQtNd1PoyOOxY6EgaRTWIcXHOGA7WtVW1CGkcM3rLvBa75g6Uo4zJDyQxZ+d/Jp1oFi0EkLpnblzY+SLD1GqbbnjsZhFeGPaI7v5/sUEnI/rIsefbBQGURsaCMkNEpaI47Pj1gbEVAWgd2aXMGVKRpWjdi89jnD0eIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705655532; c=relaxed/simple;
	bh=eNiJDJdYOUFmY5BTiqxpKfPXrwPImnQUYyFSWE2ZSJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xflol//8rya1nkfqxS16TN4Oajd3vOxDGkkLQ1DvmkWlXkR+gYztNGV0yzKEdXbZSW5bR2PqCKua2d/V7j+MfrBVV3eqsHCKjrfgk/RsLG7lXFniXB5pq3q6VuGygErAp43gFswTGB4CTwExmqIZlfjoF8i8CmFgK3LdCO8zpto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=z3P4C5rp; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705655528;
	bh=eNiJDJdYOUFmY5BTiqxpKfPXrwPImnQUYyFSWE2ZSJU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=z3P4C5rpP4oH8MIrinLyBrZZZVLTwMNTKhUsEGxFrEAxX+qZsgt5wWovv3/SVw2fJ
	 53XvZEQw3il/d9gtLpvQSnizwlBvKTmsszvqKYNG83lTWXA6MrWTUyyjVKlAArjymv
	 yO8ffqW/6ynmiRhzqgVKPkPGtNvckK4eclAEexsP6mERqMYFkBEEWy1kejIJzeu22i
	 RNpIa3zUaqQ7Ey8iWdTTVqueKPYTtEDWHEZWJPcsXvtBdFWWogxjKerYn+99eleMix
	 e9og5Y4g/y6kVL+iLJVQScKWbw69vm1urU+qXOw/NNkLLgF203sYOqQl7hIv1MRFsn
	 5SrxTe6HPTWGA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 419BA3781182;
	Fri, 19 Jan 2024 09:12:08 +0000 (UTC)
Message-ID: <064935d8-fbda-4eda-b013-8c8fc63b561c@collabora.com>
Date: Fri, 19 Jan 2024 10:12:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Probe failure of usb controller @11290000 on MT8195 after
 next-20231221
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com, Macpaul Lin <macpaul.lin@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>
References: <9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 18/01/24 19:36, Nícolas F. R. A. Prado ha scritto:
> Hi,
> 
> KernelCI has identified a failure in the probe of one of the USB controllers on
> the MT8195-Tomato Chromebook [1]:
> 
> [   16.336840] xhci-mtk 11290000.usb: uwk - reg:0x400, version:104
> [   16.337081] xhci-mtk 11290000.usb: xHCI Host Controller
> [   16.337093] xhci-mtk 11290000.usb: new USB bus registered, assigned bus number 5
> [   16.357114] xhci-mtk 11290000.usb: clocks are not stable (0x1003d0f)
> [   16.357119] xhci-mtk 11290000.usb: can't setup: -110
> [   16.357128] xhci-mtk 11290000.usb: USB bus 5 deregistered
> [   16.359484] xhci-mtk: probe of 11290000.usb failed with error -110
> 
> A previous message [2] suggests that a force-mode phy property that has been
> merged might help with addressing the issue, however it's not clear to me how,
> given that the controller at 1129000 uses a USB2 phy and the phy driver patch
> only looks for the property on USB3 phys.
> 
> Worth noting that the issue doesn't always happen. For instance the test did
> pass for next-20240110 and then failed again on today's next [3]. But it does
> seem that the issue was introduced, or at least became much more likely, between
> next-20231221 and next-20240103, given that it never happened out of 10 runs
> before, and after that has happened 5 out of 7 times.
> 
> Note: On the Tomato Chromebook specifically this USB controller is not connected
> to anything.
> 
> [1] https://linux.kernelci.org/test/case/id/659ce3506673076a8c52a428/
> [2] https://lore.kernel.org/all/239def9b-437b-9211-7844-af4332651df0@mediatek.com/
> [3] https://linux.kernelci.org/test/case/id/65a8c66ee89acb56ac52a405/
> 
> Thanks,
> Nícolas

Hey Nícolas,

I wonder if this is happening because of async probe... I have seen those happening
once in a (long) while on MT8186 as well with the same kind of flakiness and I am
not even able to reproduce anymore.

For MT8195 Tomato, I guess we can simply disable that controller without any side
effects but, at the same time, I'm not sure that this would be the right thing to
do in this case.

Besides, the controller at 11290000 is the only one that doesn't live behind MTU3,
but I don't know if that can ring any bell....

Cheers,
Angelo

