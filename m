Return-Path: <linux-kernel+bounces-164605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DE28B7FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 407ABB23D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CF6199EA0;
	Tue, 30 Apr 2024 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJiZ6DwC"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE6A190667
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714502451; cv=none; b=h5ZpMUVDA5iD3IvkaiHN1VQoZ7YYvBAgdaEGnt5M9BMqpGjAyJ021UGE2U9yLWl4XoCrpsXQKR6lAoT7idhytWrPFrMlBPWC1fRoWBaraj33d+WLIxfo58Wp6CZwOBTaxYNKaj7A533ECZQwhT76wb5EpdlN3PdShoWUaw1tD3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714502451; c=relaxed/simple;
	bh=Ffbg7WoTC8IzhJQ1hvnDnhKn4Y9a4Jx99g8Jfv72qhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbgNTYAZqDnaBrBFQv7zxXypklDKepIycIugno5Kq/mzCDIgXVJ7L/wQ6/D0dpaWYrUItY26+0HgtrCS03CuLcTfQwt/cy1j/hY5lKHpIdVnG68IGgFGBS+Fu5KgwLYKuXXof1ygvBMjEAorHfoors0uTCK/igitPf9LjwG/HnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJiZ6DwC; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so4112120a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714502449; x=1715107249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2suPCR+cMhZMHV/oEQ4BEenfWnmM4twKxp8OHpzJwg=;
        b=aJiZ6DwC1YYTs5yMrEU/GlwsPdttbgAdJ/3LTCiLHmpCZ+3DrgHaxPdYnZ25g8eHLD
         8joGBeVv/AYlnYXDCGFHMXWeQj4j3lcpCSerPaWeeTjYzprD0WTm+Ov/QzvShPWMV/wS
         YhwnI4zVg+Dl569jrraMg914tK6V7smIO3mIyxSF8s98jwSx1u5hGCd28BTeXmI1ZRpB
         xLcZMcsjjGJTWwqMhsSeolxd5Nmqh6Trelq9pPHokooJmu2rZOLUMJDZJ/RCvazCjfZF
         A6B8pE/TyJauuRKcXLGaF1KaTK3lpHO7iDo+425K+vle10U7o/hRVj+JIPqc4gxAoAmp
         GaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714502449; x=1715107249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2suPCR+cMhZMHV/oEQ4BEenfWnmM4twKxp8OHpzJwg=;
        b=abVn/V5t0m5sEyNopFvMBhjb4VqUNCgLp9qiR3eX3BDBxSo5kHIJeFUSIro12ovNLy
         5lUDcw3j83n7p8acVyMZ+WifQY6kZGexEGHIdoS9JrtY5aRcJC20sBYm5hWPHKzORBcA
         EFhIJMqNq/dByVNyqTxrN0RFPa7NbIZHp6xKB+M5nfJpHri0IgdbnMJmz6mghOs6wA7/
         heUty4GMGbADYZD+82CRiwR/DWe8c8jUKrDzh1inp6k8cTKEhcpY4z2jtKudhG3x9FB5
         L8Hfz9VquJ20F3Gyzko2veoqC/dZ/UnZLbgXyA/9fq49usqW0XEEsEroFL/7/EouE0/C
         I+OA==
X-Gm-Message-State: AOJu0YxFOLk5IRJbAphyagOm4VcnIrXYD0ZCksbJpVkvJchwarRNJ//8
	Iz4Ro1tFJmAKZ0k6UbR9xNP/GBR5GFBxuJN3tYEdlTWoJED1cl9LUq2BXg==
X-Google-Smtp-Source: AGHT+IECvwrpw/vjqVJ8bNQHU8PrBxLJl0loVDO6R1DSXeU9jawmL9CwzbZAw+QVvk9xuu4ZY2U0ag==
X-Received: by 2002:a17:90a:c590:b0:2af:3ff7:4a81 with SMTP id l16-20020a17090ac59000b002af3ff74a81mr296907pjt.31.1714502449166;
        Tue, 30 Apr 2024 11:40:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id qb13-20020a17090b280d00b002b1581a0fccsm5043895pjb.44.2024.04.30.11.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 11:40:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 30 Apr 2024 11:40:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.9-rc6
Message-ID: <a432941d-8c78-41d4-89bc-71c8cdc0da2e@roeck-us.net>
References: <CAHk-=witYatGg+jW1kVu2Moq6yF2JNFe3wn7G0sMNhE=H=9voA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=witYatGg+jW1kVu2Moq6yF2JNFe3wn7G0sMNhE=H=9voA@mail.gmail.com>

On Sun, Apr 28, 2024 at 01:58:54PM -0700, Linus Torvalds wrote:
> Things continue to look pretty normal, and nothing here really stands
> out. The biggest single change that stands out in the diffstat is
> literally a documentation update, everything else looks pretty small
> and spread out.
> 
> We have the usual driver updates (mainly networking and gpu but some
> updates elsewhere), some filesystem updates (mainly smb, bcachefs,
> nfsd reverts, and some ntfs compat updates), and misc other fixes all
> over - wifi fixes, arm dts fixlets, yadda yadda.
> 
> Nothing looks particularly big or bad. Shortlog appended for details,
> please do keep testing,
> 

Build results:
	total: 158 pass: 157 fail: 1
Failed builds:
	xtensa:allmodconfig
Qemu test results:
	total: 537 pass: 537 fail: 0
Unit test results:
	pass: 213087 fail: 63
Failed unit tests:
	sh:rts7751r2dplus_defconfig:checksum
	sheb:rts7751r2dplus_defconfig:checksum
	i386:pc:test_next_pointer
	i386:pc:slub_test
	x86_64:q35:test_next_pointer
	x86_64:q35:slub_test

Fixes to address the problems seen in my tests are:

  da7bf52309b2 usb: ohci: Prevent missed ohci interrupts
  6314201f467f mm/slub, kunit: Use inverted data to corrupt kmem cache
  db4ade1cccf9 m68k: fix spinlock race in kernel thread creation
  9ea544ad0f56 net: dev_addr_lists: move locking out of init/exit in kunit
x c2ea0ff8714f ext4: implement filesystem specific alloc_inode in unit test
  7692d5469f1f Revert "sh: Handle calling csum_partial with misaligned data"
x 2a1de3ca9cb6 xtensa: remove redundant flush_dcache_page and ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros

The patches are in the 'fixes' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
in case anyone is interested in details. Note that the SHAs may change
since the branch is rebased on a regular basis.

Only patches marked with 'x' are regressions introduced in this release
cycle. The other patches fix long-standing issues. Some of the unit tests
fixed with the above patches are not included in the test results; for
example, running ext4 unit tests without the fix results in memory
corruptions. The m68k and usb patches fix spurious problems.

Thanks,
Guenter

