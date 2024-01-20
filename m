Return-Path: <linux-kernel+bounces-31848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E63B783356B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 18:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FEE828426B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 17:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178C112B91;
	Sat, 20 Jan 2024 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJAW4Og1"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B31E1172D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705770039; cv=none; b=YAsB8SpUOrKRBZLaIfOA4VFzuFL/REkXPgMbsJivX/LfAdcBuloBLMJLH585Ui0qEdBdJS7oCwDV/41y8tyMFLRIM+eeMrM5Rp0YXvMTbLBQ62hNP76a78RvmHsZtOCB9eU18iDaFA9fJ3FadcR6B9hEXSjvcWCoLXOZVpC0Dsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705770039; c=relaxed/simple;
	bh=PKK6HYadXAwZCSYg1nzBG0fYqkoKTKlf+PEjvpx9m6I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsZ7Ekf4J5GHuMdVhnxD8hBUYgugan5dpSZGlkyp7BFQTObi3VJi+uouKcRjBKUX9H+/HAj8vJsxGtBzbdYuWVw9aQxuK/Lo1Fa3uE/dXmHoGqr72J31NQBZgrNH8I8Kboygz7Nh9EO2TimihSgC2kTf1jMWKDplCQcXXbD8jgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJAW4Og1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33922b66bd7so1008362f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 09:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705770036; x=1706374836; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XyVOGkOkVTm86r/oRSP+lx+TJBopO7lwL7TLREoXTNI=;
        b=YJAW4Og1tr7LUCMJi6au+y80KjHpsbIFgS7PK5dKAGFPA2KGCWvDEFYaHIiqURmLSu
         3nnHSgqUC5byd0kR26/9TNNVbNXiI57irzA74oUfeDVlVqMIh7QGo5WAGM1Ye6KBFTxz
         +61SyTtRhae8aeyFOGDDcc/sUkGy1ir6gUVKwanSpvwgn7VL9DHFAzXPXORXpyaGJHfB
         e0ndVwzKzbYgj1lIxhUcpFXQRc6XwvURlAqyO2N4COeyt1bHlYafhfUwrassp8zN3V79
         n+tIfNUz2NvKdf0Ve6qeeW/Tp6IYugzQokhKtvfQEo8g+oQC3dNftUZj7VTw6kxtU7LE
         82ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705770036; x=1706374836;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XyVOGkOkVTm86r/oRSP+lx+TJBopO7lwL7TLREoXTNI=;
        b=RLfqcCqh3CUIqAO5RwRvFXc/yGXcE0O/UYxj8oS2teFhbrk8HHo79tJzBIwVjzIYp3
         4YJXcmeaEVzxibVndyXp99lxYpxdIl0P/RlWuG/6pWm51Du5J3JWVnOhg2yuQiDFA2di
         GpyAn9/n/UJulPPDrUfgswr0bKPLdmstwRVt6Dk54U9vWCsSwp8TnjtdtIc1lNFDe8Ph
         BWS/KN9NWfZm1A1JlHnVNJ9ddtQP8iJIcti4Bc2ir7am7i/dq034v7d7N/6Ljo1CSXRQ
         /S/Qu8HjWbHBweS0xPWl4hHmw0FFyie8alguXkYpBp1sAsFD06CHSlMHBmj8hGKFCAdn
         0htw==
X-Gm-Message-State: AOJu0Yxj8hPDRbBldrN8WgHVp6qNxMl6YjV17ZXkGDOKKRn8/GW/lQnr
	0LizTMJEnCA2oGkPhm4T6cbq8FdE/62YDliL12RXUxMlajrxt4VS
X-Google-Smtp-Source: AGHT+IHLy4gpnmo78d749VFJKFbfRCmTRpdtbiW7GiLL3n28JxQvUf8w3AUDWzpxCwoH+TRNaXR9Sw==
X-Received: by 2002:adf:cd0d:0:b0:337:51c6:8f09 with SMTP id w13-20020adfcd0d000000b0033751c68f09mr734147wrm.109.1705770036119;
        Sat, 20 Jan 2024 09:00:36 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id x8-20020adfdd88000000b003392ae3aee8sm1567523wrl.97.2024.01.20.09.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 09:00:35 -0800 (PST)
Message-ID: <65abfc33.df0a0220.65bf1.4e35@mx.google.com>
X-Google-Original-Message-ID: <Zav8MF5mLvcBiHhp@Ansuel-xps.>
Date: Sat, 20 Jan 2024 18:00:32 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Kees Cook <keescook@chromium.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH 2/2] ARM: decompressor: add option to ignore MEM ATAGs
References: <20240119201356.7903-1-ansuelsmth@gmail.com>
 <20240119201356.7903-3-ansuelsmth@gmail.com>
 <CACRpkdaR_gtW6VmenfV5=xounqV18-kZyNprJUtLWkpgXUnkvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaR_gtW6VmenfV5=xounqV18-kZyNprJUtLWkpgXUnkvA@mail.gmail.com>

On Sat, Jan 20, 2024 at 12:52:33PM +0100, Linus Walleij wrote:
> On Fri, Jan 19, 2024 at 9:14 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> 
> > +#if defined(CONFIG_ARM_ATAG_DTB_COMPAT_IGNORE_MEM)
> > +#define do_ignore_mem 1
> > +#else
> > +#define do_ignore_mem 0
> > +#endif
> 
> Is there a reason why you can't just use:
> 
> if (IS_ENABLED(CONFIG_ARM_ATAG_DTB_COMPAT_IGNORE_MEM))
> in the code?
> 

Was following the pattern, yes I can totally do this change... Will send
a v2 with this changed.

Since the first patch has to be regression tested, is it ok to add the
Tag in v2 or I should wait that to send v2?

-- 
	Ansuel

