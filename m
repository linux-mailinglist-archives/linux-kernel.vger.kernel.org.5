Return-Path: <linux-kernel+bounces-90563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 036A2870125
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9328DB21C46
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87253BB4C;
	Mon,  4 Mar 2024 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="VUZDVgRT"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3983B193;
	Mon,  4 Mar 2024 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709554935; cv=none; b=mEfA1SYzM6Os6cMTSUL8262bl8/e6g0HqNgUxLuVa8p2upQ1k1b8woHf8NJi9u5pb+MkStNwCiUMt2vI9kSO8T1OipaSSM8xpxY7fQ9plS5kJaFbjobGCuliWWw0vR8AX1vYORiMR7ZqCg3eoR682Dal0PQh7DSj653tN6TpIXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709554935; c=relaxed/simple;
	bh=iaLvMkscTu22PMg6EbbOG8ddmaxyYkSqojzFu2hcZX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9MmoIoZIO2zARG3Wvvfwxzv/71yIjcAfwUIBfK9GhwltIoFhW5F4mdj/xer4reak7ZmltIkpGWnGzv1XqQzCwUFxqU2FqUK3dGiQ3MHIbWRGcebpextf89+K8e8KHIWYUCM40cjozGkmV9AGwiPDloyOGXaUhNaf6xzSxZ/4vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=VUZDVgRT; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=hMCkIUe+XyHaUa+80k/WKyK1Rur9pNDUNUE4O40OC+0=;
	t=1709554933; x=1709986933; b=VUZDVgRT1+M0EH0E91TBKm6loP2eLABA0m3HGiuRtQeBMqh
	EX/vKimGSMJpjuJiyN3zjcfIpdLVW5v5r9lXrymuyI1VKyaRwTEnjCRdd1Jj2wx88w/YPkRwZz0bm
	5+h4YG5dg5p5dbvuFjl9YcH5w8nmUInSodYnyPE6xoeJJ01ul4BplBYJX1+ySHTKdvjYWSWpGKcZ3
	XmIUPq6h5GOSj40ym7IbiCNfIMZ+QIa39Phu415iaZnD/Klei/LF/pwiL0nnvp7NylsXNKEm2gGMV
	os68EQa3PyhX3bZxnxG+7HcqDp2d9B7ZBmdvljdqHL53fUr8gTKt/A7RN0WkOxIg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rh7KW-0008UW-Bd; Mon, 04 Mar 2024 13:22:04 +0100
Message-ID: <aaf7a195-e726-4bcb-a63a-4e75c09608ef@leemhuis.info>
Date: Mon, 4 Mar 2024 13:22:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: new text on bisecting which also covers bug
 validation
Content-Language: en-US, de-DE
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>, =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?=
 <petr@tesarici.cz>, Vegard Nossum <vegard.nossum@oracle.com>,
 Jani Nikula <jani.nikula@linux.intel.com>
References: <02b084a06de4ad61ac4ecd92b9265d4df4d03d71.1709282441.git.linux@leemhuis.info>
 <6d282271-25fa-4ed9-9748-df3705f9d5fb@leemhuis.info>
 <878r2zz5n7.fsf@meer.lwn.net>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <878r2zz5n7.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709554933;f4826097;
X-HE-SMSGID: 1rh7KW-0008UW-Bd

On 03.03.24 16:39, Jonathan Corbet wrote:
> "Linux regression tracking (Thorsten Leemhuis)"
> <regressions@leemhuis.info> writes:
> 
>> On 01.03.24 09:41, Thorsten Leemhuis wrote:
>>> Add a second document on bisecting regressions explaining the whole
>>> process from beginning to end -- while also describing how to validate
>>> if a problem is still present in mainline.  This "two in one" approach
>>> is possible, as checking whenever a bug is in mainline is one of the
>>> first steps before performing a bisection anyway and thus needs to be
>>> described. Due to this approach the text also works quite nicely in
>>> conjunction with Documentation/admin-guide/reporting-issues.rst, as it
>>> covers all typical cases where users will need to build a kernel in
>>> exactly the same order.
>>> [...]
>>> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
>>> index ed8a629e59c86a..c53bb6e36291b8 100644
>>> --- a/Documentation/admin-guide/index.rst
>>> +++ b/Documentation/admin-guide/index.rst
>>> @@ -1,4 +1,3 @@
>>> -=================================================
>>
>> Just saw that, that line obviously was not meant to be removed. Sorry.
>>
>> Jonathan, in case you consider merging this "soon", as suggested
>> yesterday by  Vegard, could you please fix this up? Otherwise I'll fix
>> this with v3.
> 
> I've applied the patch and undone the little change, no need for a v3.

Great, thx and thx!

FWIW, I received some feedback from a user who among others also noticed
a bug. Will send a follow-up patch in a few days when the dust settled
and a few details are fully ironed out.

Thx again for merging it. Ciao, Thorsten

