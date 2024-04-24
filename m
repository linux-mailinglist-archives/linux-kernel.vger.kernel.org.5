Return-Path: <linux-kernel+bounces-156340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 827218B0181
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40141C214C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA692156C5B;
	Wed, 24 Apr 2024 06:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ayCZNf++"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3443D15696D;
	Wed, 24 Apr 2024 06:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713938807; cv=none; b=Ybf7p0s0P0vh7jT/E3Yac9SRT1egQrlkVUODFHH7Tr/3FF3AlomzKt5hoTipnB7pLCYTulXipp30obIbqSrnaWLxE9iDMJsmT5WopsFTeh7gLpB/jZnlhUpyIBjBB+1/DbeOGKCGjAXwtxT8fy0dcDgCydId/S36i/1OXjDbMVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713938807; c=relaxed/simple;
	bh=j1+muzAkVHfWGaUVDfWnppU1cbHnW27Ru5LKk7vTw1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=DX5Vaw5gv7X8jRb/RrWcB36g9NHej7FZ489W8XPMDVZYhhhoeDvYNg/AEZZgHpB++PVpifjb6zqfgQNkRw/fZA9rkIZJldPVNJbFKSlzHWDnQ0jq+G/o8x/H2fxj4Djo+770RvNv14Vv0hNWrOLLYbWxPNi54qw7+qeS+SFzkFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ayCZNf++; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Cc:From:References:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=BjWj3bvgshQkX0ic9F8zq8at9TWgUDpFINVtQ3l7b5c=;
	t=1713938805; x=1714370805; b=ayCZNf++3DexYoMawSOlruJ1XI9KWtWkFEa1OsAMKFXCap6
	Is6IJSYfF2OuLPcInqOvVmWM4JQGjKw3QL+nOCp4Bme7Wjy6vCBBAMYyWl7FRTWwSUyQNGUrqMSoe
	lwhTPmte3J4S6gdGlmRFMlgAfbgX2aglUrA4Hxc/bP64A5hviYFYITdIdKxtqP9rwHebej1aLlWzn
	dcZhi5QM0qpiW80Z8z1JWtu0O5Yr/olFLbUy4I3k5DUZk0+fBrF0s0D0Du4Lk9jClOAlDKxcF4HKR
	0OrgV+jSMn1Kx0LJCZMU8/NSaxYgG3Z+cJysgxNOnFSOco2oKG5u5p2hVdxgghUw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rzVm7-0006ig-5J; Wed, 24 Apr 2024 08:06:35 +0200
Message-ID: <3b983390-110e-4c68-a825-6e811de78919@leemhuis.info>
Date: Wed, 24 Apr 2024 08:06:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: BT_RAM_CODE_MT7961_1a_2_hdr.bin is missing in the firmware tree
To: "Artem S. Tashkinov" <aros@gmx.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 chris.lu@mediatek.com, deren.wu@mediatek.com,
 Peter Tsao <peter.tsao@mediatek.com>
References: <6574fc0f-8a24-4aff-8a1b-dbf960b6375d@gmx.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 linux-mediatek <linux-mediatek@lists.infradead.org>
In-Reply-To: <6574fc0f-8a24-4aff-8a1b-dbf960b6375d@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1713938805;e32e74d3;
X-HE-SMSGID: 1rzVm7-0006ig-5J

On 23.04.24 12:23, Artem S. Tashkinov wrote:
> 
> Could you please push this firmware ASAP?
> 
> It's been reported to be missing:
> https://bugzilla.kernel.org/show_bug.cgi?id=218757

FWIW, that can't be the only solution for that problem, as
Documentation/driver-api/firmware/firmware-usage-guidelines.rst clearly
states:

"""
Users switching to a newer kernel should *not* have to install newer
firmware files to keep their hardware working.
"""

Could anyone from mediatek please confirm that this rule is adhered?

Side note: I wonder if Peter's patch
https://lore.kernel.org/all/20240415141922.25055-1-peter.tsao@mediatek.com/
("Bluetooth: btusb: Fix the patch for MT7920 the affected to MT7921") is
relevant for this.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

