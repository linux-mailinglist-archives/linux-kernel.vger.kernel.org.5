Return-Path: <linux-kernel+bounces-91319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4D4870E3B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393101F22C11
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B5478B47;
	Mon,  4 Mar 2024 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlsfXtNa"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E60F8F58;
	Mon,  4 Mar 2024 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588516; cv=none; b=IITcqiQCifLWT2RcungOBmFH8TvrDt3oTwsihwIbMRtB+nLM1oOuz4syYMZnmwNiCv/mmJSN7AY4RwLC2IU2HXCvWHDXeQNYKNvd+lJ2xSKYqCIqYdiLLHhvtF/9+8gCyk+g7NVL93xuFqyFDPWNV8x+f1vPK/2Od8foATH5xwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588516; c=relaxed/simple;
	bh=9SEv1fZ/gQAqY+O/ktRXWn4grnSoNnUcFBAN3ld0CVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKqAK3LoleGoklQyM0FFBiXpBUtVP2WuKGOuaAz4LZGQMe3diFmxnTHTpmLHHBcajFD+Xn7xlyxvYHzzMilspqWV8kEsRDzXyhbAqa4qf/NcjVA03QsQCyMwCTH9WbiTpca+yqtLksxPdp40ql6L3f4wwkASW+faUPZSdUgpKAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlsfXtNa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412e84e87e6so6354105e9.2;
        Mon, 04 Mar 2024 13:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709588513; x=1710193313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rGrlaWOqHwE4QKgjxl7U7FEwFsj916aCtQXG9iXn0EY=;
        b=AlsfXtNa+qoWgiFTFPcMzZJbeab8PXZt6zNuq5NaRlfKxuFaV4HJHlnsIGNwtzeGda
         aDK50iaBZq2KLy4neyYyt3mK+zvnZ1NRAuhyMdruN/XlHTGO8c4hWBpY/hrNtA81a0ET
         E5T43Da8ZucJQRc0/QdmXG3/EcmNt5MZnrQYBidVRJ5KmiNWjJvgSN3Wq42iCW/R/Nyb
         fEHr4sMePBVHqde0FydQtHy5G03VtCKuTkbML27f0draIiZBMH/purgXFBFFBOfmhASw
         1le0kydqt2fCTINuEqKXkDYqqm94jW2VJqzDC3kDPVgKwlLS0MDcoFw/1w2WYV4znLOH
         Nc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709588513; x=1710193313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGrlaWOqHwE4QKgjxl7U7FEwFsj916aCtQXG9iXn0EY=;
        b=WhMPIDz7j0tqihPrMIFAdC3U0jOa1zr2DZX0Bq+VQ+1jd7zJd0yr1vAI7mZcbVOttR
         LVVkhQDDRqb9ciGiRLQ1tm+3zoYC6T/ajyi9zfw7gIZAJ9f1JoKjocd6KKyr1EoBtVhU
         VXz2/5kJgrbZxsa7wfeaEgwmCw+6Qo++crzLKmj1MLH3HPaNsi9hsj93eQdm7K1Lw7YF
         4u86CJhpLiH9kR0KNyeU/gTMgIsPdMpJJ+AW7VkxmtHkR6N+mIVMzT9Qx/7kZxw9Hx3K
         JoVxgnkiJLYJvbJkKudE15XVQWkmfpP3hK2TMyWhguAYSeyurKu5+iiM1FanJcnzEBqb
         100g==
X-Forwarded-Encrypted: i=1; AJvYcCU/QVdN+gVSeiglTnOamNZtxdCGqL//2YXZ64t+YPc+68Gwd8YrS8KDMIDi1dZnGnkiusLOBvHkKZQnKUcbyGJmzjlKQ9aYgCirKq14k9Zo8EIJqNlbetrdkueBNjmW8yAnvXktSTjLMjwf6uiI+DFk7D0WBTtmf1k/d72C235U
X-Gm-Message-State: AOJu0Yy/arK37bLKdu9EQLkfbaWtlYoBjUVwTkcyTgi32ZdzobkJd0Bh
	HX5vYeIDC78jK4P9XRTvkD9QRxKr9Wn6P7o/l9EXdVd/6xI6j35Y
X-Google-Smtp-Source: AGHT+IHS4Ph0K17h5ybJ4yv/Ax/dRUFfDIaeA86vo6DSHkFXwpvHydlfr7H15a+V+WFlSgowjooCuQ==
X-Received: by 2002:a05:600c:468a:b0:412:bcc9:32dc with SMTP id p10-20020a05600c468a00b00412bcc932dcmr8364626wmo.31.1709588512525;
        Mon, 04 Mar 2024 13:41:52 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id o17-20020a05600c4fd100b00412d68dbf75sm8769968wmq.35.2024.03.04.13.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 13:41:50 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 14349BE2EE8; Mon,  4 Mar 2024 22:41:50 +0100 (CET)
Date: Mon, 4 Mar 2024 22:41:50 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Srivastava <yashsri421@gmail.com>, 1064035@bugs.debian.org
Subject: Re: [regression 5.10.y] linux-doc builds: Global symbol "$args"
 requires explicit package name (did you forget to declare "my $args"?) at
 ./scripts/kernel-doc line 1236.
Message-ID: <ZeZAHnzlmZoAhkqW@eldamar.lan>
References: <ZeHKjjPGoyv_b2Tg@eldamar.lan>
 <877ciiw1yp.fsf@meer.lwn.net>
 <ZeYoZNJaZ4ejONTZ@eldamar.lan>
 <874jdlsqyy.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AtnHYYbjYt9cf90c"
Content-Disposition: inline
In-Reply-To: <874jdlsqyy.fsf@meer.lwn.net>


--AtnHYYbjYt9cf90c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Mar 04, 2024 at 01:05:09PM -0700, Jonathan Corbet wrote:
> Salvatore Bonaccorso <carnil@debian.org> writes:
> 
> > Ok. In the sprit of the stable series rules we might try the later and
> > if it's not feasible pick the first variant?
> 
> Well, "the spirit of the stable series" is one of Greg's titles, and he
> said either was good...:)

here we go. Please let me know if you need anything changed in the
commit message to describe the situation better.

Greg, in the Fixes tag I added the 5.10.y commit as the issue is
specific to the 5.10.y series. Is this the correct form to note this?

Regards,
Salvatore

--AtnHYYbjYt9cf90c
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-scripts-kernel-doc-Fix-syntax-error-due-to-undeclare.patch"

From ccddb9f4915f0dbf28fb72b6ff4c04977978ed3d Mon Sep 17 00:00:00 2001
From: Salvatore Bonaccorso <carnil@debian.org>
Date: Mon, 4 Mar 2024 22:24:12 +0100
Subject: [PATCH] scripts: kernel-doc: Fix syntax error due to undeclared args
 variable

The backport of commit 3080ea5553cc ("stddef: Introduce
DECLARE_FLEX_ARRAY() helper") to 5.10.y (as a prerequisite of another
fix) modified scripts/kernel-doc and introduced a syntax error:

Global symbol "$args" requires explicit package name (did you forget to declare "my $args"?) at ./scripts/kernel-doc line 1236.
Global symbol "$args" requires explicit package name (did you forget to declare "my $args"?) at ./scripts/kernel-doc line 1236.
Execution of ./scripts/kernel-doc aborted due to compilation errors.

Note: The issue could be fixed in the 5.10.y series as well by
backporting e86bdb24375a ("scripts: kernel-doc: reduce repeated regex
expressions into variables") but just replacing the undeclared args back
to ([^,)]+) was the most straightforward approach. The issue is specific
to the backport to the 5.10.y series. Thus there is as well no upstream
commit for this change.

Fixes: 443b16ee3d9c ("stddef: Introduce DECLARE_FLEX_ARRAY() helper") # 5.10.y
Reported-by: Ben Hutchings <ben@decadent.org.uk>
Link: https://lore.kernel.org/regressions/ZeHKjjPGoyv_b2Tg@eldamar.lan/T/#u
Link: https://bugs.debian.org/1064035
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 scripts/kernel-doc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 7a04d4c05326..8e3257f1ea2c 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1233,7 +1233,7 @@ sub dump_struct($$) {
 	# replace DECLARE_KFIFO_PTR
 	$members =~ s/DECLARE_KFIFO_PTR\s*\(([^,)]+),\s*([^,)]+)\)/$2 \*$1/gos;
 	# replace DECLARE_FLEX_ARRAY
-	$members =~ s/(?:__)?DECLARE_FLEX_ARRAY\s*\($args,\s*$args\)/$1 $2\[\]/gos;
+	$members =~ s/(?:__)?DECLARE_FLEX_ARRAY\s*\(([^,)]+),\s*([^,)]+)\)/$1 $2\[\]/gos;
 	my $declaration = $members;
 
 	# Split nested struct/union elements as newer ones
-- 
2.43.0


--AtnHYYbjYt9cf90c--

