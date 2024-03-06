Return-Path: <linux-kernel+bounces-93514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E046F8730E4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973382818AA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC9B5D910;
	Wed,  6 Mar 2024 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ZogQy2Hp"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906515D48E;
	Wed,  6 Mar 2024 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714304; cv=none; b=WwTKcpaQbEqRRBywFrT7lnzxrlIn2ViyxLSkRMzMU4DxPZaFTWxD4BH9SMJbadVVtEfrRLVH6R22sAtyV8x9sM94GHFp2iUOHwPGmliql0vhFIqYsYGYnRdAPLtYmslrMrbu8vdG2D2UKgoICnBmFDU0SH/m/5yvVe0I9E/VqEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714304; c=relaxed/simple;
	bh=INVur/i/2/DnqgH4GT7WzVy7FSpV2dn4I1Y4wqIez2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSjHjU24bhibT98DdeHAUfhbXFij+DXUrBwmwccyLvpgKDOZnRa/5ha603oonHo/UYMSOBHmJtxhXp1r6Vf2ApqF9GXQ/jrN8ufA4PdeMFEkRP9RGNeapSYW5dOeU/VswU43uqHI+9NJdBpY7HthG14xAEuiL3ec9sHCIrofiLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ZogQy2Hp; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=INVur/i/2/DnqgH4GT7WzVy7FSpV2dn4I1Y4wqIez2U=;
	t=1709714302; x=1710146302; b=ZogQy2HpFkX3F0HNQcmnquu/XVJMOewSj1tOwKqIydcuh4v
	Utv1m3VBl+I1xf0/K9yjb2qYoE9S7rdsNW32aEZ31sjgMyzgqIzJMJ9zQibhajuI4R3yxCOmfcr8H
	6PwE6OIFzhE4GwB8ZQiLntBfosqXd3QJg5eopOTdOsPJ1FmgXont3mQMUho7qwYm0ZbICiTRPUepf
	tanfMOWbIcaCyRHUAQW7p4GcNMsJUX1Als/RL3vlGQuojPMpzX1bxZ+GlRoikIU3n6l9JSMR+I6TL
	VJjiUqKg60zFOsvYya5ZjCAHZ2CmKII3oBGiEDQ2QRri9np0/XvmVz4sEShpjq4Q==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rhmn4-0004eJ-Kv; Wed, 06 Mar 2024 09:38:18 +0100
Message-ID: <1d3ed2b9-a44e-45f9-a523-d219c141ea5a@leemhuis.info>
Date: Wed, 6 Mar 2024 09:38:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
Content-Language: en-US, de-DE
To: Song Liu <song@kernel.org>, Dan Moulding <dan@danm.net>
Cc: junxiao.bi@oracle.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org
References: <739634c3-3e21-44dd-abb1-356cf54e54fd@oracle.com>
 <20240301231222.20120-1-dan@danm.net>
 <CAPhsuW73WZRekVSEFPgL7R-KNtd2DuhDo7oUNmjZN4Hr7w0dhg@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAPhsuW73WZRekVSEFPgL7R-KNtd2DuhDo7oUNmjZN4Hr7w0dhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709714302;fc871cb1;
X-HE-SMSGID: 1rhmn4-0004eJ-Kv

On 02.03.24 01:05, Song Liu wrote:
> On Fri, Mar 1, 2024 at 3:12 PM Dan Moulding <dan@danm.net> wrote:
>>
>>> 5. Looks like the block layer or underlying(scsi/virtio-scsi) may have
>>> some issue which leading to the io request from md layer stayed in a
>>> partial complete statue. I can't see how this can be related with the
>>> commit bed9e27baf52 ("Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in
>>> raid5d"")
>>
>> There is no question that the above mentioned commit makes this
>> problem appear. While it may be that ultimately the root cause lies
>> outside the md/raid5 code (I'm not able to make such an assessment), I
>> can tell you that change is what turned it into a runtime
>> regression. Prior to that change, I cannot reproduce the problem. One
>> of my RAID-5 arrays has been running on every kernel version since
>> 4.8, without issue. Then kernel 6.7.1 the problem appeared within
>> hours of running the new code and affected not just one but two
>> different machines with RAID-5 arrays. With that change reverted, the
>> problem is not reproducible. Then when I recently upgraded to 6.8-rc5
>> I immediately hit the problem again (because it hadn't been reverted
>> in the mainline yet). I'm now running 6.8.0-rc5 on one of my affected
>> machines without issue after reverting that commit on top of it.
> [...]
> I also tried again to reproduce the issue, but haven't got luck. While
> I will continue try to repro the issue, I will also send the revert to 6.8
> kernel.

Is that revert on the way meanwhile? I'm asking because Linus might
release 6.8 on Sunday.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

