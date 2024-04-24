Return-Path: <linux-kernel+bounces-156861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB608B095D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91610289229
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF0815D5B3;
	Wed, 24 Apr 2024 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="sKyi2idq"
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FE915ADAD;
	Wed, 24 Apr 2024 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961470; cv=none; b=HgqLL3BiTVgG2FGDg4TCJahQazNn9D6gCKhFvaKXwlFcuxiwP3KphkU3HYIKlBsfN2/tQ+7m9y0WtIwCEzDEc6FjvZgBaHoH1vTGJ2ETQQAsxKztj7zp7MCwLS3pz+XSqznVGyHv9LSTlYurydiKtBebVXABUHPg/5wDNzwx6LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961470; c=relaxed/simple;
	bh=bfQI4Yq0CyiT7iayneJPtPZ0mu3Owe3QmD6Ot4PZCd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1LAI6oBGmkB1bzh5qTozZo1yCPFTzwoPj5jjMteLWw3dpEWmPdjpa5XUQFaNEqyw5S2XOLMjY6j/aRxFguqLbFE0s6PRUSTLfP0QNDsfqLYsf53xfuNDYXXns3FpXXADzjN3dtUnsOc+5j6i9d3N8qn78kPA/Kj3AhcICVRlDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=sKyi2idq; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1713961443; bh=bfQI4Yq0CyiT7iayneJPtPZ0mu3Owe3QmD6Ot4PZCd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sKyi2idqZcDH+tgmc9hbaskD5ctWLBkt7vnl7pbMPq181SHLSEWfh50lFb3m8bv0I
	 hPcJ7413r8l6dYZa2TLhNcZPF4620HYDJbVClbs9OOZgYum7QfQUV6cSw3Yu9Ou85t
	 v8VF7LBwTbiJDLW4PVyFumgdxgFdnRyOUESnTDco=
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed, 24 Apr 2024 14:24:03 +0200 (CEST)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 1BD9780472;
	Wed, 24 Apr 2024 14:24:03 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id 101DA18334E; Wed, 24 Apr 2024 14:24:03 +0200 (CEST)
Date: Wed, 24 Apr 2024 14:24:03 +0200
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] kconfig: remove 'optional' property support
Message-ID: <Zij545f6JVmmbcoj@buildd.core.avm.de>
References: <20240422164104.2869507-1-masahiroy@kernel.org>
 <20240422164104.2869507-3-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240422164104.2869507-3-masahiroy@kernel.org>
X-purgate-ID: 149429::1713961443-BD53ED52-146531E8/0/0
X-purgate-type: clean
X-purgate-size: 2753
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Tue, Apr 23, 2024 at 01:41:04AM +0900, Masahiro Yamada wrote:
> The 'choice' statement is primarily used to exclusively select one
> option, but the 'optional' property allows all entries to be disabled.
> 
> In the following example, both A and B can be disabled simultaneously:
> 
>     choice
>             prompt "choose A, B, or nothing"
>             optional
> 
>     config A
>             bool "A"
> 
>     config B
>             bool "B"
> 
>     endchoice
> 
> You can achieve the equivalent outcome by other means.
> 
> A common solution is to add another option to guard the choice block.
> In the following example, you can set ENABLE_A_B_CHOICE=n to disable
> the entire choice block:
> 
>     choice
>             prompt "choose A or B"
>             depends on ENABLE_A_B_CHOICE
> 
>     config A
>             bool "A"
> 
>     config B
>             bool "B"
> 
>     endchoice
> 
> Another approach is to insert one more entry as a place-holder:
> 
>     choice
>             prompt "choose A, B, or disable both"
> 
>     config A
>             bool "A"
> 
>     config B
>             bool "B"
> 
>     config DISABLE_A_AND_B
>             bool "choose this to disable both A and B"
> 
>     endchoice
> 
> Some real examples are DEBUG_INFO_NONE, INITRAMFS_COMPRESSION_NONE,
> LTO_NONE, etc.
> 
> The 'optional' property is even more unnecessary for a tristate choice.
> 
> Without the 'optional' property, you can disable A and B; you can set
> 'm' in the choice prompt, and disable A and B individually:
> 
>     choice
>             prompt "choose one built-in or make them modular"
> 
>     config A
>             tristate "A"
> 
>     config B
>             tristate "B"
> 
>     endchoice
> 
> In conclusion, the 'optional' property was unneeded.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> (no changes since v1)

thanks for the patch!

I found just one small remnant that probably should be removed as well:

diff --git a/scripts/kconfig/tests/choice/__init__.py b/scripts/kconfig/tests/choice/__init__.py
index 4318fce05912f..05e162220085c 100644
--- a/scripts/kconfig/tests/choice/__init__.py
+++ b/scripts/kconfig/tests/choice/__init__.py
@@ -8,4 +8,2 @@ The behavior of 'y' choice is intuitive.  If choice values are tristate,
 the choice can be 'm' where each value can be enabled independently.
-Also, if a choice is marked as 'optional', the whole choice can be
-invisible.
 """

Reviewed-by: Nicolas Schier <n.schier@avm.de>

Kind regards,
Nicolas


PS: For other reviewers, this patch (set) depends on
https://lore.kernel.org/linux-kbuild/20240422161054.2867285-1-masahiroy@kernel.org/

