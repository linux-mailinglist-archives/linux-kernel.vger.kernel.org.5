Return-Path: <linux-kernel+bounces-160697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FDA8B413E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0641E1F22143
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721783613E;
	Fri, 26 Apr 2024 21:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1rC8vS3K"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E63D2D03D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714167177; cv=none; b=FapX19inS6gI8LZc3pvPML6ypkAfqZ56+84iA3hs25reZKr43KKcqQwWOZ0OqgqtIU05RWPwVOz9zPKb02sMMRm8rhN5tJasyjERC7ZHYNQDYb36kCyB6B2smMA6qpE8TYBDk1ztFXGgHgNyWLmr6vRXAUOVdsehp2P2/ZyV6Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714167177; c=relaxed/simple;
	bh=5yVvzpp+oJSa4jitf6n/YGYnKEChJkRzzuJlcPCJLSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDQoOAx/6n4OhkgRy898ihhTJ925IVcBTWDP7CnVFCUHwCjr5rP1m0ZK5yQBNx5AUlno0s7Wqf47JXezLaD85KzQYLJmfXLvwocUYvYfvjstd9Xvoe58VYiO/LNY5YzrPguaChWElhWON9psw1Hkdpr5EUOtAQlCLnm+AsXYIhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1rC8vS3K; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7da1d81d042so107838539f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714167175; x=1714771975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XapD3Vo/MqdiQRWrwhL6vAMNi8r75ljjq7FJu80J9ZI=;
        b=1rC8vS3KljB6I2aoHNlx3zyjrbJWGFKK1ZNREj6m13Id+83V+Ry6sjYxruzibz7DKw
         If572zAqvVbgZuYvyAfe398jcTDO7oEgoXLGLKw5DAfjPth3fDeBo52ESByDnIc525Ou
         ukX0ROs6YKbymATl/RkmkY5d4Br6h0afmBoNsGqlp93PyoKEi/FsX1Hgy2/bDW273qam
         dbl1VggfKuq0La8IdSi44JsjBAqIIvtIzzt1yWUZ3BhTzT+UkDZqFDsqxTkrpHuvEYFM
         YhsG2Q+YBvh9Wa0GIFCYsDVdIKxVhlXz124EMF3ZTJU0lOqgTxrLcLb5NeaKSk1RQ9oG
         LWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714167175; x=1714771975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XapD3Vo/MqdiQRWrwhL6vAMNi8r75ljjq7FJu80J9ZI=;
        b=q7VHYirOjoUkc0imwBXz+g7PtHC2wOg9Gou550TxZUFw68egGMye7OoW2RAxjB+2mL
         buHr2rcxwA4CtiRGCnJLu4bIc+Y3wfP4HrtCKkka10SHPuX72sM0BRxCqGUA9znD0i3f
         Osn0buipcdNDJQhMBB3A5ED188mPmllsHChhY1X5ZDtoHxmJCEPZDPq5xVvtwWqD0wjE
         luTdelYrzWQi3Yk3/yy5vpNEYxQoNUVEyrdAXH93s0bb5X38YDhFMdrUtq5a0AzTNSh8
         UuTEn+JeJCtFxnuwRRttss1cmQ2g+Svc6tg3xDqHDdftFcwOdQBtlio7ArUaTEkaUHiJ
         ltbA==
X-Forwarded-Encrypted: i=1; AJvYcCWd66q/SudX5n9+sxmmL8YeoH0BKlYErDwNJ3W79jeG5lo9APzZ5v1aMiP1cYjYDHuBjCOgY2VrYCnWOQOavSKTgF6w3Ke16B+EUi0z
X-Gm-Message-State: AOJu0Yx2noh167G9TLU6FfiWdhwXjn3kAUyLiNtgdNIRe/VgzwQ4Yvu8
	itn5/pxUMWL47u6H840NyTV6sJdPt90qiA6BFLlhWlKSAe44Z+Sg8ljirb6oiA==
X-Google-Smtp-Source: AGHT+IFoiCg3OWmOf8Xqm+Gm5428k85SPoCpAbrANz2kTgoAcSMf8TRwNrwGQKHHoyB814lzfQGPTw==
X-Received: by 2002:a5d:8d16:0:b0:7da:1896:9e7b with SMTP id p22-20020a5d8d16000000b007da18969e7bmr3901716ioj.20.1714167175399;
        Fri, 26 Apr 2024 14:32:55 -0700 (PDT)
Received: from google.com (195.121.66.34.bc.googleusercontent.com. [34.66.121.195])
        by smtp.gmail.com with ESMTPSA id g3-20020a05660226c300b007deaecfe190sm369755ioo.7.2024.04.26.14.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 14:32:54 -0700 (PDT)
Date: Fri, 26 Apr 2024 21:32:52 +0000
From: Justin Stitt <justinstitt@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, 
	Bill Wendling <morbo@google.com>, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [RFC PATCH 2/9] x86/purgatory: Simplify stack handling
Message-ID: <pgsqflimo7d2ozhpmdrmscx25mxs5lypcvwq6mgjs7uixsxvsl@5papnq46mwbs>
References: <20240424155309.1719454-11-ardb+git@google.com>
 <20240424155309.1719454-13-ardb+git@google.com>
 <20240424182659.GA2126602@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424182659.GA2126602@dev-arch.thelio-3990X>

Hi,

On Wed, Apr 24, 2024 at 11:26:59AM -0700, Nathan Chancellor wrote:
> On Wed, Apr 24, 2024 at 05:53:12PM +0200, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> > 
> > The x86 purgatory, which does little more than verify a SHA-256 hash of
> > the loaded segments, currently uses three different stacks:
> > - one in .bss that is used to call the purgatory C code
> > - one in .rodata that is only used to switch to an updated code segment
> >   descriptor in the GDT
> > - one in .data, which allows it to be prepopulated from the kexec loader
> >   in theory, but this is not actually being taken advantage of.
> > 
> > Simplify this, by dropping the latter two stacks, as well as the loader
> > logic that programs RSP.
> > 
> > Both the stacks in .bss and .data are 4k aligned, but 16 byte alignment
> > is more than sufficient.
> > 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/include/asm/kexec.h      |  1 -
> >  arch/x86/kernel/kexec-bzimage64.c |  8 --------
> >  arch/x86/purgatory/entry64.S      |  8 --------
> >  arch/x86/purgatory/setup-x86_64.S |  2 +-
> >  arch/x86/purgatory/stack.S        | 18 ------------------
> 
> This needs a small fix up to build.
> 
>   make[6]: *** No rule to make target 'arch/x86/purgatory/stack.o', needed by 'arch/x86/purgatory/purgatory.ro'.
> 

I was trying to reproduce this build failure, but to no avail. I am
curious what your build target / build command was.

It is clear that stack.S has been removed so your change makes sense, I
don't doubt that -- I just cannot get that specific error message you
encountered (what is a .ro file supposed to be, anyway?).

> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index acc09799af2a..2b6b2fb033d6 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  OBJECT_FILES_NON_STANDARD := y
>  
> -purgatory-y := purgatory.o stack.o setup-x86_$(BITS).o sha256.o entry64.o string.o
> +purgatory-y := purgatory.o setup-x86_$(BITS).o sha256.o entry64.o string.o
>  
>  targets += $(purgatory-y)
>  PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))

Thanks
Justin

