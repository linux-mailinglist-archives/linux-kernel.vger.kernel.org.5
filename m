Return-Path: <linux-kernel+bounces-133233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DFB89A0F4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50EA1C235CA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCF216FF3F;
	Fri,  5 Apr 2024 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="JNhKaCGk"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C690816FF32;
	Fri,  5 Apr 2024 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330468; cv=none; b=OCcqRo0Q0QZD5n/+qLpZkTkfZKkLMvUPHNebdHPgMgMf6jrjIkImQbbKEqRPjnhhlLo/shXEDZABXXyaiuCAn7isajiaxz6ekJCLbKmGxYrav+WDqzzV/4p0EB11ed6maFdDGfed663GadDF71VsxCzYBsW7fnR9OWahU5ujWO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330468; c=relaxed/simple;
	bh=X6XGUm6JZsKq6Bbf/V28UbuXZ15PV3XG3X+8BEf6k+A=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Cc:Content-Type; b=XoXN/idxczbvda//DrW6G4Z6XlqVlSDwcX6gydJbEG6pgClIf/0fRZ5U+OCKLk4r7XuEme9Czpe4f6Crkjd+6POB8Ghp+9yqMynF7uTHmt+u/ZN4J+9/DaU7TIzrrvHZCf0zldCNerzPWTQzdh1gROjh/QL/0lR3yvGvQsOyYUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=JNhKaCGk; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:Cc:Subject:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To
	:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=v+qNG8sMUH5bGX+DRd6ZrkCiAd3Pu96BpQB8qRYZ0u8=; t=1712330466;
	x=1712762466; b=JNhKaCGks6Ki/21xuIkSJgSjtV4ew9AwXk7AkkePp35/SD46QhNIC53V99JpL
	+QlLXAxsYqtNN5VlvKa4HtKtHu8snRPec9pvRDmAnDdaKO71hbIJ5MYoRldSMTb2cQ0hhi4xpxK0x
	QiPyEAdyeJvAVOO7Y25qHPzVkRVc23u9i4Co3D67KL8OLzCX/G76S0INmfasbURVgpDu5IlT7QzAT
	ycinjlaOUcObl2pVjqPeSTbN0QjFBdoQsNd2NYWddDYVtyAP09QV4eSS0k8kAY5H+LvK6FXAQycvB
	mwDJvOnX0rVtYSboiERpk2LYUH04uj+Tr4Jl9z2bCUTNsmRpLQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rslNI-0005aJ-0J; Fri, 05 Apr 2024 17:21:04 +0200
Message-ID: <19851b9b-c3ff-4781-8292-4ce5999747d3@leemhuis.info>
Date: Fri, 5 Apr 2024 17:21:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [regression] opp issues on devices with multiple power-domains
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712330466;6f3db7fd;
X-HE-SMSGID: 1rslNI-0005aJ-0J

Hi, Thorsten here, the Linux kernel's regression tracker.

Viresh Kumar, I noticed a report about a regression in
bugzilla.kernel.org that appears to be caused by a change of yours
(e37440e7e2c276 ("OPP: Call dev_pm_opp_set_opp() for required OPPs")
[v6.8-rc1]). As many (most?) kernel developers don't keep an eye on it,
I decided to forward it by mail.

Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218682 :

> Created attachment 306086 [details]
> Dmesg from xiaomi-onclite
> 
> Devices with multiple power-domains has issues with required_opps is
> pointing to wrong opp table because it lazily just uses dt node to find it.
> But every genpd device has its own table.
> 
> The issue was fixed downstream with this commit:
> https://github.com/msm8953-mainline/linux/commit/6afec1ea2cf1cdb968d646c45d1d1a80f6cb5fb2

See the ticket for more details. Note, you have to use bugzilla to reach
the reporter, as I sadly[1] can not CCed them in mails like this.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

[1] because bugzilla.kernel.org tells users upon registration their
"email address will never be displayed to logged out users"

P.S.: let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: e37440e7e2c2760475d60c5556b59c8880a7fd63
#regzbot title: OPP: issues on devices with multiple power-domains
#regzbot from: Barnabás Czémán
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=218682
#regzbot ignore-activity

