Return-Path: <linux-kernel+bounces-98892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0359C8780C0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BFD3B20C70
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F073DB89;
	Mon, 11 Mar 2024 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="wgMpo1af"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBBF22064;
	Mon, 11 Mar 2024 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164395; cv=none; b=or2Mc3p3SQnrZCbWPYA8oZdNk45TnYJiVitVOO8hdhIsS0Z8oLD9YR6+6M3vZ92vo8lIIULgnPbym0oEg90S1FKS3PCZoH6lDJ+M31wenJfIwvGZ4ivh8zxSB2V+cNDAu4/N52b4PAJl7psifH5L4DSkPBjF3rGRSIswObF6C50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164395; c=relaxed/simple;
	bh=SEEjQagVJJYIXoK3Q+z+Gy4Jtn5En5vzFh8nYszbxjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFtU0AtUDg9NOdVAzGClmyvcwYeO2X9fd1dw7wmz5srpdEpfpnJcVtWT1x19Pp3gooHvo7h6OuwfxPquLu04txutQyHiR//2cbwK7aGD61xs28NLd5Cm9N0g+uVBSI4t0p63got+xGHNuRp07BPdUoNe9mnMJji4yxhIulwqRTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=wgMpo1af; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=KBYkYC7Q3Vs3PYXioBEI+v+74ZYf4zGI6NQfn8C50kY=; t=1710164393;
	x=1710596393; b=wgMpo1afu1C27tRgT78ad+Q25fPDKENd+HVMTlPI6lxBVrfcejp+HZPSGAL/U
	IIPkRxOU3k4GFM0VgjEnqKY/E4PF6RRayBX4UaLzCQURbNj81xnzUMsmQ/tuPbfMJb7gn/ZRZFptv
	hUqMNYfKADtifF67B8snOsfXaMUNB2U3fBW1U4wmAtxxy2OlaN6wgJ5OfWpcPWy80zELNK/KdNNsM
	CUijPD4PpGsw+bvB2feUrAwMVLFmLhEGNJQl94Pz7PYyUUp3+nh1hVbYqcAg1PXmP7ojuid70YsHi
	Mz3hDF+yHgeeW1umCrkZ/dwBPtfswGpNNrkVMnq8Q0OyxbIfXw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rjfsY-0007K8-KI; Mon, 11 Mar 2024 14:39:46 +0100
Message-ID: <82cf3fba-fdfa-4185-b2b9-c8ed8d123136@leemhuis.info>
Date: Mon, 11 Mar 2024 14:39:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] docs: *-regressions.rst: Use collon after regzbot
 introduced command
Content-Language: en-US, de-DE
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: kernel@collabora.com, regressions@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org
References: <20240308-regzbot-fixes-v1-0-577a4fe16e12@collabora.com>
 <20240308-regzbot-fixes-v1-1-577a4fe16e12@collabora.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20240308-regzbot-fixes-v1-1-577a4fe16e12@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1710164393;2d3a856a;
X-HE-SMSGID: 1rjfsY-0007K8-KI

Thx for this!

On 08.03.24 15:09, Nícolas F. R. A. Prado wrote:
> All the examples in the reference documentation for regzbot have a
> collon

s/collon/colon/ here and a few lines below as well. And in the subject
as well. Speaking of which: something like "docs: *-regressions.rst:
add colon to regzbot commands" might be better.

> after the "introduced" command, while on the kernel documentation
> some have and others don't. This suggests both are acceptable,

Yup.

> but in
> order to avoid confusion, add collons after all the commands to match
> the reference docs.

Yeah, good idea. I likely would have done this myself soon while doing a
few other changes I plan, but whatever. :-D

> Link: https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

With the changes above:

Reviewed-by: Thorsten Leemhuis <linux@leemhuis.info>

Side note: I wonder if the commit message could come a bit quicker to
the point (something along the lines of "Use colons as command
terminator everywhere for consistency, even if it not strictly
necessary. That way it will also match regzbot's reference
documentation.". But not really important I guess. Up to John.

Ciao, Thorsten

> ---
>  Documentation/admin-guide/reporting-regressions.rst |  2 +-
>  Documentation/process/handling-regressions.rst      | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/reporting-regressions.rst b/Documentation/admin-guide/reporting-regressions.rst
> index d8adccdae23f..76b246ecf21b 100644
> --- a/Documentation/admin-guide/reporting-regressions.rst
> +++ b/Documentation/admin-guide/reporting-regressions.rst
> @@ -31,7 +31,7 @@ The important bits (aka "TL;DR")
>     Linux kernel regression tracking bot "regzbot" track the issue by specifying
>     when the regression started like this::
>  
> -       #regzbot introduced v5.13..v5.14-rc1
> +       #regzbot introduced: v5.13..v5.14-rc1
>  
>  
>  All the details on Linux kernel regressions relevant for users
> diff --git a/Documentation/process/handling-regressions.rst b/Documentation/process/handling-regressions.rst
> index 5d3c3de3f4ec..42b13f77b019 100644
> --- a/Documentation/process/handling-regressions.rst
> +++ b/Documentation/process/handling-regressions.rst
> @@ -27,11 +27,11 @@ The important bits (aka "The TL;DR")
>     is optional, but recommended):
>  
>      * For mailed reports, check if the reporter included a line like ``#regzbot
> -      introduced v5.13..v5.14-rc1``. If not, send a reply (with the regressions
> +      introduced: v5.13..v5.14-rc1``. If not, send a reply (with the regressions
>        list in CC) containing a paragraph like the following, which tells regzbot
>        when the issue started to happen::
>  
> -       #regzbot ^introduced 1f2e3d4c5b6a
> +       #regzbot ^introduced: 1f2e3d4c5b6a
>  
>      * When forwarding reports from a bug tracker to the regressions list (see
>        above), include a paragraph like the following::
> @@ -79,7 +79,7 @@ When doing either, consider making the Linux kernel regression tracking bot
>  "regzbot" immediately start tracking the issue:
>  
>   * For mailed reports, check if the reporter included a "regzbot command" like
> -   ``#regzbot introduced 1f2e3d4c5b6a``. If not, send a reply (with the
> +   ``#regzbot introduced: 1f2e3d4c5b6a``. If not, send a reply (with the
>     regressions list in CC) with a paragraph like the following:::
>  
>         #regzbot ^introduced: v5.13..v5.14-rc1
> @@ -398,9 +398,9 @@ By using a 'regzbot command' in a direct or indirect reply to the mail with the
>  regression report. These commands need to be in their own paragraph (IOW: they
>  need to be separated from the rest of the mail using blank lines).
>  
> -One such command is ``#regzbot introduced <version or commit>``, which makes
> +One such command is ``#regzbot introduced: <version or commit>``, which makes
>  regzbot consider your mail as a regressions report added to the tracking, as
> -already described above; ``#regzbot ^introduced <version or commit>`` is another
> +already described above; ``#regzbot ^introduced: <version or commit>`` is another
>  such command, which makes regzbot consider the parent mail as a report for a
>  regression which it starts to track.
>  
> 

