Return-Path: <linux-kernel+bounces-42431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2454C840150
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47882836A0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A7754FB2;
	Mon, 29 Jan 2024 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="GFpy6ZkM"
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9248554FA2;
	Mon, 29 Jan 2024 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520160; cv=none; b=RtEzMbUEmcUIj1pGyEC+MIHz0O+Iv7Tf78wXwteKLBUlqCwlJHwEe+l6PDkK5bjeqFZeizRB+8NhgFlmqrIer6R6azQEUPlTiyayQybBJYNTB0nYlyZmQdTBT/jVkl5NQdFom1+BATtwW5+w99Ek5IOCLPXWYwZpUMbWOnJOKro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520160; c=relaxed/simple;
	bh=saNzpDFTnfGb5XkJveOYQXgjCciMpu5Xo90TKLpK70Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMAdjaHKP8FjlXNgD/Gx9ClZR0Qt8M1GJa2pk5Oc1A5AahtPw2JpDXWfB8mSGvkrbUGldzDrUJW89KIQNVlTO+z5AM8gJlHTXW0wnzoSjhFmUkKUKcW/QJuH52gV2GAmtrtBDyqTiQ1rZjaj65Qii7YGLIBQ6617MiK3zvEtif0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=GFpy6ZkM; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1706520147; bh=saNzpDFTnfGb5XkJveOYQXgjCciMpu5Xo90TKLpK70Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GFpy6ZkMRcP522pW+2jfMeztuxoxmZ+UUITr6vfGWtYbHx8kjqs+ZiTvAxOOP4at7
	 ROrWfMb7qCxthvFkPszDUY8lDzoIZDD9a1Bb8w1/+6i2ABiGJp4pXY9uK9MCZTEMDs
	 pRtiTmp1oRQ8pVdxxYTn8ieaOPBRG4zqnmTHrVgM=
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon, 29 Jan 2024 10:22:27 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 499F38024A;
	Mon, 29 Jan 2024 10:22:27 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id 34589180E6F; Mon, 29 Jan 2024 10:22:27 +0100 (CET)
Date: Mon, 29 Jan 2024 10:22:27 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Will McVicker <willmcvicker@google.com>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kbuild@vger.kernel.org, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] checkpatch: allow build files to reference other
 build files
Message-ID: <ZbduU15kw5R42awj@buildd.core.avm.de>
Mail-Followup-To: Will McVicker <willmcvicker@google.com>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kbuild@vger.kernel.org, kernel-team@android.com,
	linux-kernel@vger.kernel.org
References: <20240112221947.1950503-1-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240112221947.1950503-1-willmcvicker@google.com>
Organization: AVM GmbH
X-purgate-ID: 149429::1706520147-42E053B3-F49B2F8E/0/0
X-purgate-type: clean
X-purgate-size: 1650
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Fri, Jan 12, 2024 at 02:19:46PM -0800, Will McVicker wrote:
> Add an exception to the EMBEDDED_FILENAME warning for build files. This

As far as I can see, your patch fixes only the checkpatch warnings for
top-level Makefile and Kconfig (and leaving out top-level Kbuild).
Other build files are not affected, right?

Kind regards,
Nicolas


> fixes the below warnings where the Kconfig and Makefile files reference
> other similarly named build files.
> 
>   WARNING:EMBEDDED_FILENAME: It's generally not useful to have the filename in the file
>   #24: FILE: Kconfig:34:
>   +source "drivers/willmcvicker/Kconfig"
> 
>   WARNING:EMBEDDED_FILENAME: It's generally not useful to have the filename in the file
>   #36: FILE: Makefile:667:
>   +	} > Makefile
> 
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> v2:
> - Unwrap commit message lines
> - Align and update regex
> 
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index f8343b34a28b..c2869803e545 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3785,7 +3785,8 @@ sub process {
>  		}
>  
>  # check for embedded filenames
> -		if ($rawline =~ /^\+.*\b\Q$realfile\E\b/) {
> +		if ($rawline =~ /^\+.*\b\Q$realfile\E\b/ &&
> +		    $realfile !~ /(?:Kconfig|Makefile)/) {
>  			WARN("EMBEDDED_FILENAME",
>  			     "It's generally not useful to have the filename in the file\n" . $herecurr);
>  		}
> 
> base-commit: 70d201a40823acba23899342d62bc2644051ad2e
> -- 
> 2.43.0.275.g3460e3d667-goog
> 

