Return-Path: <linux-kernel+bounces-90559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A5587011D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847C11C219AF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC083BB3E;
	Mon,  4 Mar 2024 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="d0UfJP/k"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8303BB3C;
	Mon,  4 Mar 2024 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709554694; cv=none; b=RqzkKbQEA+8iMS5rUmhCeOribCcdIfA0CxG44Cyjc0/zdgyRfMcatiYrnJO/em1fSwpKBY1qyc1268BjPDQK12M4tmJYP7ADI1h6O46aOBVW8oBVhM91e9ZRCKKkSzTIZ+b5f2Ww4KGu/au7whaBCuZvUxlGniUG0ePBR5N7EbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709554694; c=relaxed/simple;
	bh=N2W3mE8rnw2SVp2I4OlDvkJ1azlDiC+mHB23aFxRlX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLXgPC+cbAOkUw0axWbn6VhpihAVtS2Zz/ZmfvZ5ifJfp2wiQpOwzxU5nUAluCuzCZJhno00sPmyTrOsK2kIMBKtvbU6I93pkLkgQAZ+Tmd/btItFmWrzihhHOiHWVdtutWnqUQaOEJYLpguVhP3zsGVhC2JDhYCAt+ZFqJ0Mxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=d0UfJP/k; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=uf9/2sCOY3v4S1nCPA6rsbwBK7yGOrOwP1YZD759F5Y=;
	t=1709554692; x=1709986692; b=d0UfJP/kksHG+VFWhn/EsuBO+7Y9Ua442cnflhjdTKVbT/Q
	1n5sqokjgSGlNhrTvffgquEiM3FkIsONWDVXt6Ee2DCgzPYa3iJ4xfK29mBemBAxtebDfwd5SmjtG
	+etbL+zopIKaqnHLzpYxoVSd65uDeaouhUyFcdomVWOnyEzWVA3UoMcYuUW6DDRollfx20ATbI/y4
	us314FSyoN0C5BXt7dvq8BNJPI+ZUCD4gDTIKh01yml9XBdJ09cc15Vk0udEag5SMfF2zj0J2WqmG
	vQQXCJhcKqFg2ySOxTbC1yYHmfT+3vWvSfWnulJHnIuusafoTgJN3UEfzHfeaiAg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rh7Gj-0007ZK-Aw; Mon, 04 Mar 2024 13:18:09 +0100
Message-ID: <ab9d758c-3ce9-42f6-99af-877055a589e6@leemhuis.info>
Date: Mon, 4 Mar 2024 13:18:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Missing bcm5974 touchpad on Macbooks
Content-Language: en-US, de-DE
To: regressions@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <87sf161jjc.wl-tiwai@suse.de>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <87sf161jjc.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709554692;3519abd2;
X-HE-SMSGID: 1rh7Gj-0007ZK-Aw

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 04.03.24 09:35, Takashi Iwai wrote:
> 
> we've received a few regression reports for openSUSE Leap about the
> missing touchpad on Macbooks.  After debugging, this turned out to be
> the backport of the commit 2b9c3eb32a699acdd4784d6b93743271b4970899
>     Input: bcm5974 - check endpoint type before starting traffic
> 
> And, the same regression was confirmed on the upstream 6.8-rc6
> kernel.
> 
> Reverting the commit above fixes the problem, the touchpad reappears.
> 
> The detailed hardware info is found at:
>   https://bugzilla.suse.com/show_bug.cgi?id=1220030

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 2b9c3eb32a699ac
#regzbot title Input: missing bcm5974 touchpad on Macbooks
#regzbot duplicate: https://bugzilla.suse.com/show_bug.cgi?id=1220030
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

