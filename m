Return-Path: <linux-kernel+bounces-154669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8568ADF91
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 289FBB25439
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFC74F8BC;
	Tue, 23 Apr 2024 08:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="JfIv657S"
Received: from msa.smtpout.orange.fr (msa-211.smtpout.orange.fr [193.252.23.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E3C2B9CA;
	Tue, 23 Apr 2024 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713860306; cv=none; b=kGJgXGpNtvzq+tkJ3ST9DN8lhrLV7fB34BuWOX/t/QY74y5HhMez+5Dmvn5TTOXUiJh/StviInMJSnkRWIQ+GlZ+tCLiXItwpWoQVq95VKCtLJWqzlPJWiYE64owzdGPD/IcjY9HRwxwu2Ca95Kk7/E6kR168BeIg2PmVMhjibE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713860306; c=relaxed/simple;
	bh=xtv4BPwGy3ZyqEsmZOD2D5Ii5lu5tCcCxDspMWBzbkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWzpKWaa83QSAHohR+Q8TmtBqZR+wkF83D0tlnNQsrYvNhzQMtUrmqLkp8/OlVxCuDtS/doiuKE1Y8H3SLcBZ7bWR5Amnp4Hz3x+Sr4tUnqvC159HvoSw9kMot1in1ijqky4XloNYZeJ3quZJZ3FfC/q7PxnpGnQ+Cp7+AiF6dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=JfIv657S; arc=none smtp.client-ip=193.252.23.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id zBKvrN5EReDY4zBKvrdaV6; Tue, 23 Apr 2024 10:17:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713860231;
	bh=f/VsrIrGMARLF7VxqFkpnHr/IAHwcjt8sUjQE+/j5as=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=JfIv657SnHdT/BHZ1u8q7jpA+0EQq2HvogX+eDqGqiUIxZJENxnjEtSvbW02gPq5C
	 NYXt8aHMpZ83zcuTfnZkWc7wwRsuKP9CovoovVMqFvJUAvmmNfhO+Syu7dN6OqQX0v
	 m/NOkkT6+/9YX41PxtIDhAzHYHRLhUavEnh1NK/kPZlN39W3NXIW76t9CrmKDw9daA
	 RQ932dljQxjd1zzqK7UuxPcOAlyUiVSBUkrd800i2vdd4CwQ0NnD3k8/dIq91dfGXl
	 8IQO0mvpFf+3dHw/I4B+jyepaydB3fV0Tpe/yqVWakcvo/3vHoei8r/yX34XaeY53F
	 0+VOt9e3trZNA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 23 Apr 2024 10:17:11 +0200
X-ME-IP: 86.243.17.157
Message-ID: <c0aac58a-1164-49ff-ad6c-060cd883a133@wanadoo.fr>
Date: Tue, 23 Apr 2024 10:17:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] checkpatch: add check for snprintf to scnprintf
To: Justin Stitt <justinstitt@google.com>, Andy Whitcroft
 <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
 linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 Finn Thain <fthain@linux-m68k.org>
References: <20240422-snprintf-checkpatch-v5-1-f1e90bf7164e@google.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240422-snprintf-checkpatch-v5-1-f1e90bf7164e@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 22/04/2024 à 23:33, Justin Stitt a écrit :
> I am going to quote Lee Jones who has been doing some snprintf ->
> scnprintf refactorings:
> 
> "There is a general misunderstanding amongst engineers that
> {v}snprintf() returns the length of the data *actually* encoded into the
> destination array.  However, as per the C99 standard {v}snprintf()
> really returns the length of the data that *would have been* written if
> there were enough space for it.  This misunderstanding has led to
> buffer-overruns in the past.  It's generally considered safer to use the
> {v}scnprintf() variants in their place (or even sprintf() in simple
> cases).  So let's do that."
> 
> To help prevent new instances of snprintf() from popping up, let's add a
> check to checkpatch.pl.
> 
> Suggested-by: Finn Thain <fthain@linux-m68k.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v5:
> - use capture groups to let the user know which variation they used
> - Link to v4: https://lore.kernel.org/r/20240408-snprintf-checkpatch-v4-1-8697c96ac94b@google.com
> 
> Changes in v4:
> - also check for vsnprintf variant (thanks Bill)
> - Link to v3: https://lore.kernel.org/r/20240315-snprintf-checkpatch-v3-1-a451e7664306@google.com
> 
> Changes in v3:
> - fix indentation
> - add reference link (https://github.com/KSPP/linux/issues/105) (thanks Joe)
> - Link to v2: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v2-1-9baeb59dae30@google.com
> 
> Changes in v2:
> - Had a vim moment and deleted a character before sending the patch.
> - Replaced the character :)
> - Link to v1: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v1-1-3ac5025b5961@google.com
> ---
>  From a discussion here [1].
> 
> [1]: https://lore.kernel.org/all/0f9c95f9-2c14-eee6-7faf-635880edcea4@linux-m68k.org/
> ---
>   scripts/checkpatch.pl | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9c4c4a61bc83..b7404e53c554 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7012,6 +7012,12 @@ sub process {
>   			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
>   		}
>   
> +# {v}snprintf uses that should likely be {v}scnprintf
> +		if ($line =~ /\b((v|)snprintf\s*\()/) {

Nit: I think that /\b((v|)snprintf)\s*\(/) would be nice.
Otherwise, <spaces>( would be added to the message.

CJ

> +			WARN("SNPRINTF",
> +			     "Prefer ${2}scnprintf over $1 - see: https://github.com/KSPP/linux/issues/105\n" . $herecurr);
> +		}
> +
>   # ethtool_sprintf uses that should likely be ethtool_puts
>   		if ($line =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*\)/) {
>   			if (WARN("PREFER_ETHTOOL_PUTS",
> 
> ---
> base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
> change-id: 20240221-snprintf-checkpatch-a864ed67ebd0
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 
> 


