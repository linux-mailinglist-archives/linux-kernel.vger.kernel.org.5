Return-Path: <linux-kernel+bounces-125608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A950892992
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 07:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE081F21CD7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 06:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B095063CB;
	Sat, 30 Mar 2024 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="IOfhLqrZ"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4A315CE;
	Sat, 30 Mar 2024 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711781680; cv=none; b=HEGhAd5B/shieFcMg+Jus8J5n0dYiRs/yT8jtpORp50DOIgKfSY1K/ieM7pF9n9krqP8Bf31Dq86ea9fauhiFYRJjI7CEcWSP156VaZUXAGo5WWs3M2J4WuA2R4P9mgfkgSKnPxBB9hAdlnryhNxbEqFjaIseq5xytjJfnFQ2ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711781680; c=relaxed/simple;
	bh=+ou0jJukvfoQwr+mDiPl4YAYu4nw/6Sg7nRXHQldpJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmL5NhqOT75vvtOGpH6Cuc/7dTt/0ulDjQjszhQ17HRrHSpBPepSUoKoDoqjpnSq0cjJA4TYmceH8dyM20ffsLfoXl3AGSS9HHdq2xZUm89tu7P+auQFDd6umEsCQ62aVDuo1O215hVRMkhMsiR/LUABxc4l4RQ5UpXMBp0m5+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=IOfhLqrZ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=syQUrvl2dgCvGtizdT7QEDmhkcbW3zS6mu/xuvhkvtM=;
	t=1711781677; x=1712213677; b=IOfhLqrZA72NhvaODwms+j/TUGDaktmxl7rIt5SzvR9XJCu
	pRmxQdkS7iBWhBHdsqirH7B62wh+zyJbfyCTeYXSH/SeojvRfPpFrru+4GsB//utXfPcjT9/N1FA7
	zo0/Lmfj9wohTFvOGOnoI3hLjuQVS/21I/N/8iZSgJruzG36OQxyqjTaz++t6zKwzHWNoqc2cgwVI
	sQqwRDwHGGpb5NoEIaqb5UKkzDG7WLqRqKmHoRKgkKJZsGiv2huHdgtlRQAbw+az5z1RXLND21MOw
	YlJxmuaerWzn/5POOGYp3reviF933SCDJA4b31uLO07v3FIHCfHniBxCmeGnLQTA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rqSbo-00030o-V8; Sat, 30 Mar 2024 07:54:33 +0100
Message-ID: <29abd2f6-2de5-4a69-9113-61042c52f6bc@leemhuis.info>
Date: Sat, 30 Mar 2024 07:54:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] platform/x86/intel/hid: Don't wake on 5-button
 releases
To: David McFarland <corngood@gmail.com>
Cc: Chris Feng <chris.feng@mediatek.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Alex Hung <alexhung@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
References: <20240318191153.6978-1-corngood@gmail.com>
 <20240318191153.6978-2-corngood@gmail.com>
 <1198933e-bf89-4237-a6e8-f7daeeebf885@leemhuis.info>
 <87bk6wlxpp.fsf@gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <87bk6wlxpp.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711781677;ddeb3204;
X-HE-SMSGID: 1rqSbo-00030o-V8

On 29.03.24 19:06, David McFarland wrote:
> "Linux regression tracking (Thorsten Leemhuis)"
> <regressions@leemhuis.info> writes:
> 
>> David, from here is looks like this is stalled for ten days now. Or was
>> there some progress and I just missed it?
> No, I've not seen any emails since your last.

Thx for confirming.

>> From the cover letter[1] is sounds a lot like a "Fixes: 0c4cae1bc00d31
>> ("PM: hibernate: Avoid missing wakeup events during hibernation")" would
>> be appropriate here.
> 
> The specific behaviour I encountered (failure to hibernate) started with
> that commit, but I think it just exposed the underlying behaviour (wake
> on button release), which probably dates to when the driver was
> introduced.

Well, it depends on the maintainer in question (so you might better want
to ignore this advice!), but I'd say: mention that in the patch
description and add Fixes: tag, to ensure people pick it up when the
change that exposed the problem is backported.

This is hinted at in submitting-patches: "This tag also assists the
stable kernel team in determining which stable kernel versions should
receive your fix.". Maybe that text should mention scenario.

Ciao, Thorsten

