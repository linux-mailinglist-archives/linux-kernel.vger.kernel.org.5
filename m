Return-Path: <linux-kernel+bounces-111152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63C6886866
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EF8AB20C65
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7041F18629;
	Fri, 22 Mar 2024 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbaKmzLl"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20418F4FA;
	Fri, 22 Mar 2024 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097119; cv=none; b=p4GIwa6GYYRWO5fdaETkqJNt132AJQXiyywbmSqvaC3PqvhNU/gIAXBXEOxbsSGzr+9m4NcjxqcsDy9szMEcbjqv4s8hpnMfTB5HlbezSyFTODQIRZ6gNWRVJ68Q1b1p15pnITlcn7nrHC1DgCLsZcxjhFWAGfiTRmJ5+cPEp8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097119; c=relaxed/simple;
	bh=ffZPhfs8D27xRgmcskKdyiYjUqpVTZr1aOvEyUA6vso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPqoFgbadgTpsyCfzDiRfy9itdwePWPDr53GpGXCETUN59JSAD2GuPA7yBU2eckCyXs4C31bmcpB2peClaJ7uYGsLxkgU6HCsbLhl99A3lULiO0+Ugma/wMKa+kjWCdSOy2QKqa/8ZZNHV1IODiVYUPTH9tzjcV/71OXRXt9GOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbaKmzLl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41468f6d584so13689865e9.0;
        Fri, 22 Mar 2024 01:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711097116; x=1711701916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aB/vJcbosEWR8zB5L3DEigEI/JurQaOSkuKB+JwQ5ns=;
        b=lbaKmzLlg2nu0ustifOqbb41eN4HhadLsNURw5rct8JP0Y4iM0/+mlAPI/XDSrm04N
         uMzAFClP3s5Meuesrk4MTsbBUc9hRu03my5izW2KQ9LachCZq8V9fh2ChAvqkdOOh8DZ
         rkQrfCR8mUFperhhyrngtOw/zY11yqEpCYp9jOr2pvXWnWiCxpV3gqqw47YL0E6+xugJ
         51Ol8pIMg2GDEifFqRu0lYta41D5DjPvyrDdBAZM5u7xCSFVG/Hm1IlY4xsfS+gkt27u
         UggpdkwlbaVYEs2odsgmDoD+BvXSVWV6AVm0XUG0bA6A1XJAhnOWgGd2u1JJ19r8jeGG
         jhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711097116; x=1711701916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aB/vJcbosEWR8zB5L3DEigEI/JurQaOSkuKB+JwQ5ns=;
        b=I2VXxpuF40cbIeHSRTOqxDJt1RRmsiAWftMdkLX/arsZ/Ek0BKW//5FHoLoPd6ZlDY
         kDzg0P3Kg4GRwZaRm/L2zRlTEHiewYsLKYMgKzSMUe69uyhCPHvkFeKZfzsAeys4gwYJ
         K5dYBpULQDveZVZflU1YTVdc5kxrkULXbR8AkqN+M0HlJwSPXoG9Ud3lEOBS+B+oyl4u
         BrERqSsE1fG76olCcDzQlQwLBtPNMK+qMQ7eif5nlmAlo3bs28PfUIdjvfnEqQj5dB2E
         xSpcA5L3p6CaSgNRLwYAbtrrvkpIP/EXhTuSlJNykWAbZO6QPd2EfspQ4rGysgCm3NEU
         hGzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs170dzwEu5HXuqziu+f6nWrit+qUug+woGg6koKqycoz1bR+n4znoOELmf0bBPgJ7TuXHZGuRn7x2E6uz8OXrnSDbYOFI8EerwyCUdS4XyeIHpTWRSz8uuOJ5C4Cbu87ahO39k1Vn2IxVzCsV
X-Gm-Message-State: AOJu0YwAcGIJ1gS/+Vq9jegl9suKf7j3uZcU1cZifuUz5MmHpWDbQNeM
	N2PHDu5SHtNIt+x6R6CFRMw837usECRYc2/rsHBAY6V2XDz1JEjB
X-Google-Smtp-Source: AGHT+IGNWGu79l5+n6UgalfjdRlSwKK4IUXhGbq63EVCwDx1ijXrLMW6zfg8Zyp7LMklbqsnyP5bpw==
X-Received: by 2002:a05:600c:3ca8:b0:413:fea7:bd19 with SMTP id bg40-20020a05600c3ca800b00413fea7bd19mr1024404wmb.15.1711097115824;
        Fri, 22 Mar 2024 01:45:15 -0700 (PDT)
Received: from gmail.com (1F2EF04C.nat.pool.telekom.hu. [31.46.240.76])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b00414038b4d64sm2387878wmq.27.2024.03.22.01.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 01:45:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 22 Mar 2024 09:45:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: tglx@linutronix.de, Guixiong Wei <weiguixiong@bytedance.com>,
	jgross@suse.com, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	peterz@infradead.org, gregkh@linuxfoundation.org,
	tony.luck@intel.com, adobriyan@gmail.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86, relocs: Ignore relocations in .notes section on
 walk_relocs
Message-ID: <Zf1FGI6E3wStJSQT@gmail.com>
References: <20240317150547.24910-1-weiguixiong@bytedance.com>
 <171079804927.224083.15609364452504732018.b4-ty@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171079804927.224083.15609364452504732018.b4-ty@chromium.org>


* Kees Cook <keescook@chromium.org> wrote:

> On Sun, 17 Mar 2024 23:05:47 +0800, Guixiong Wei wrote:
> > The commit aaa8736370db ("x86, relocs: Ignore relocations in
> > .notes section") only ignore .note section on print_absolute_relocs,
> > but it also need to add on walk_relocs to avoid relocations in .note
> > section.
> > 
> > 
> 
> Applied to for-next/hardening, thanks!
> 
> [1/1] x86, relocs: Ignore relocations in .notes section on walk_relocs
>       https://git.kernel.org/kees/c/6ba438a29b5d

Please don't - these are x86 patches, plus it contains an eyesore - see 
below ...

Thanks,

	Ingo

 relocs.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
Index: tip/arch/x86/tools/relocs.c
===================================================================
--- tip.orig/arch/x86/tools/relocs.c
+++ tip/arch/x86/tools/relocs.c
@@ -752,9 +752,8 @@ static void walk_relocs(int (*process)(s
 		 * values there are meant for pre-boot consumption (e.g.
 		 * startup_xen).
 		 */
-		if (sec_applies->shdr.sh_type == SHT_NOTE) {
+		if (sec_applies->shdr.sh_type == SHT_NOTE)
 			continue;
-		}
 
 		sh_symtab = sec_symtab->symtab;
 		sym_strtab = sec_symtab->link->strtab;

