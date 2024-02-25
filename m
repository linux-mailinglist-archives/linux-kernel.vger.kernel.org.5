Return-Path: <linux-kernel+bounces-80029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DA18629E2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 10:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139BD1C20A72
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 09:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D4CEED5;
	Sun, 25 Feb 2024 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="RTuZimLD"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1FEC8C4
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708854748; cv=none; b=utlvfw/V2tAUctb4BWoZmJhTuTKNKi7DwbgeiHgTmquxnFLJ8vWahe5Oeu/b3zCU2xQM/tyZOdjP9lkoQEaUG4AgFit0L/QE8CZ5xAXL5JzVO7pi1D148eWfTMvAWslwttFlzy44KydPwkX+jffgG5+YrHwk7oJ3V5B2pbNhUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708854748; c=relaxed/simple;
	bh=+Y/Fvt+IAnPbl3/L5nkRo+CVGZJkpOEu7LbIGkbFp1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXaOqCz79cznND1uIVeJv/bqtYEipbgF+k9JSA/W9v6PX2xXvPEVT3WkYrSJ8YWD4jkUWcrsWR9tPAj970Pr1wPBjD6n2sE2iTcB2Jsj8hTLSzt4R+9ag7m6dNTQ9y/lVzYUGzjBKrzvdH8zVl459UXGNg5IeKiSikvVUB+oKxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=RTuZimLD; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=C8Vnb5dhGHEkK7LfR6Bpr359LyIu9LMqi05VCVsfsKY=; t=1708854746;
	x=1709286746; b=RTuZimLDZGKS5lI3q9XW2kjHEE0HmHzTaKRmDkeU5HTea0XSW3d/VfkIN+1yu
	wKit43gzz6NGYitJk8jDlqIxf9qlqgcke52sskzSJcperK6AjLH/fQqscKqtDCclE40D3fu185RCS
	aiNVSRSuveXjuUPiAP8GLZVCHd1KOH4QwxLKs3hsjIr4U2SBV4iGo7ucbCtuK0v3Izc2YMGzCAGpW
	CnKBQ/eN25ChLaI/bacEAy9oJQuKVcRthVrc2zLoZLDODh2W/P06GGUissFdhiaGmQI29b6Hthhxx
	o1PW3st4TAkmXpgbjGy2ZhKG4//I/LzcPy5gKxDx5zawiOY1TQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1reBBI-0000x2-BL; Sun, 25 Feb 2024 10:52:24 +0100
Message-ID: <4c82dd8b-aa66-4edb-afbd-cfff6afc39dc@leemhuis.info>
Date: Sun, 25 Feb 2024 10:52:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2024-26602: sched/membarrier: reduce the ability to hammer on
 sys_membarrier
Content-Language: en-US, de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
References: <2024022414-CVE-2024-26602-5e76@gregkh>
 <22f42e54-d791-42aa-88f3-172f616b8316@leemhuis.info>
 <2024022510-goofy-entering-12e3@gregkh>
From: Thorsten Leemhuis <linux@leemhuis.info>
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <2024022510-goofy-entering-12e3@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1708854746;6b02fc35;
X-HE-SMSGID: 1reBBI-0000x2-BL

On 25.02.24 10:47, Greg Kroah-Hartman wrote:
> On Sun, Feb 25, 2024 at 10:31:19AM +0100, Thorsten Leemhuis wrote:
>> On 24.02.24 15:57, Greg Kroah-Hartman wrote:
> [...]
>>> Affected and fixed versions
>>> ===========================
>>>
>>> 	Issue introduced in 4.14 with commit c5f58bd58f43 and fixed in 4.19.307 with commit 3cd139875e9a
>>> 	Issue introduced in 4.14 with commit c5f58bd58f43 and fixed in 5.4.269 with commit 2441a64070b8
>>> 	Issue introduced in 4.14 with commit c5f58bd58f43 and fixed in 5.10.210 with commit db896bbe4a9c
>>> 	Issue introduced in 4.14 with commit c5f58bd58f43 and fixed in 5.15.149 with commit 50fb4e17df31
>>> 	Issue introduced in 4.14 with commit c5f58bd58f43 and fixed in 6.1.79 with commit 24ec7504a08a
>>> 	Issue introduced in 4.14 with commit c5f58bd58f43 and fixed in 6.6.18 with commit b6a2a9cbb675
>>> 	Issue introduced in 4.14 with commit c5f58bd58f43 and fixed in 6.7.6 with commit c5b2063c65d0
>>>
>>> Please see [...]
>> Greg, JFYI, I noticed that this announcement did not refer to the fix in
>> mainline (944d5fe50f3f03 ("sched/membarrier: reduce the ability to
>> hammer on sys_membarrier")) while most of the others do that. I don't
>> care at all, just noticed this by chance and wanted to let you know in
>> case it's due to a bug in a script or something. I hope there is not a
>> good reason for that difference I just failed to spot... (if that's the
>> case: apologies in advance for the noise!).
> 
> The json entry will be updated when the commit shows up in a tagged
> release (i.e. the next -rc release), and then when the real release
> happens from Linus (i.e. 6.8), it will be updated then as well.
> 
> But for now, the mainline commit is not in any "real" release so we
> can't reference it here in the message or in the json record as per the
> rules from CVE.

Ohh, interesting and somewhat understandable.

Thx for your answer!

Ciao, Thorsten

