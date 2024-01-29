Return-Path: <linux-kernel+bounces-43422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D768413A3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 397A0B20F91
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B8E657A8;
	Mon, 29 Jan 2024 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXCcQN3t"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F52D179AB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706557154; cv=none; b=EWhJhJ0vXoYA/ZKXqVBMhUPqN+JtvBXx/QBxWkMm/rA4i/Zb7MAJpwf3A6/WT+DNSfPgZ6Kc2UDRmltlvG7WcpzHrOwZ3CwAl8pW3obmOgebZ6n1NKcj1N3VRrXk1fePd6J4x5Oy8qp1XNTwRz4BANDBwX0fldiG0XPWQ3qFcF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706557154; c=relaxed/simple;
	bh=mL2tzIHpwTGnMMxmGiuq0q30mV6TIVHr/Lce9e7xlSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9S1LuzKt4JwnKbj+qIgjOphnNAvMveFuIqZiFcawwz23fNlIz/w2K1Q8jfFeyBfv1inHwVc9Y+5MjcppFJMrNJO3GEO3h9EK0gqcbFNQCxjm7rW8XJhIyhCxsOR3UofQS08h9u1xboBBaS+JEyCKF9qOooNnSPpyI2ZRAFi+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXCcQN3t; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d8cea8bb3bso6740365ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706557152; x=1707161952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4lXCL3S6CSdQsQEYMFWPvruoBxoEV/op8o7vtJIAQ4=;
        b=cXCcQN3txdxmUmRdyttqFXcGp7RM30NnUfpSWfBNIBDyUop7Zzp9BoAdYvQtmzHPBO
         YGMuSPIFhkkwqnmaFCPpVP5b1qUMnb3vWTTcl8dcf31TBqyXDl4EyX8q90FXO05yQbSx
         UyDInld0hcKi9N8Z8/JPY1wvaA/u/jg660LdOIj9B44SDHcVwKfqxstrZv/7QPSaZuHn
         W9ZFwrEbgfcwV8NiQUgCeKAcdpWqnscGurD5+9UAXULyFJbR5SxeA6Ro9cNRkQ6amY9m
         ryajHR2oAGrL9TrViYwNJkMYwcuGpIxXkXsqY7PzvzqHkhAcxDEZVFQisG0ZDhId8oha
         9eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706557152; x=1707161952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4lXCL3S6CSdQsQEYMFWPvruoBxoEV/op8o7vtJIAQ4=;
        b=g1AjX3lIzM2Pb+C/HAR2cHOGZ1pMmlx6Vaq41Bzx+vyPw5vgSN/cHn3RXUcr0HD44q
         Y8vEn7+/Z37SxSVDD/v61a6HLhaq8wXHo3QUZzMd6nKej8mRspeAyrTGUlfs5G28isEi
         q56GxfKFmJvf6+1hjDVpqKdux0mq6BEVHZTUahfIgfjLuCk22Jibov1EmXacBE/ZXaCg
         dufdx4/i0qn9HPEqRmI3/eUv0wZLFHXhC79jl1AyXagFdbG+FgFvW4lL7MzPeIoU5+Lw
         oOQ8weQ2e71y2L1RWyZZUaQh9tPG4xxjr0j/iSxX2cZOIuGflVFolzd2GVM3ejiF05sV
         J+bQ==
X-Gm-Message-State: AOJu0Yz4fzpha9T9qcyudhnjFlnyQ4DLi1UQGR32ZU6MtnQTlH3kBSYt
	j833qj306Jja8SjFEoqRWKZJYIuTg5+MI5r1tKpxTcEAVagRd48rf0uYh7/t
X-Google-Smtp-Source: AGHT+IEXcNZ990ewvuXvyAyAS8xXLy1MiNJ0QGQ77FvaahQ8wWW/kFUh0bHXm+r6Fc3+NNXuGcRbVQ==
X-Received: by 2002:a17:903:48b:b0:1d8:e372:4306 with SMTP id jj11-20020a170903048b00b001d8e3724306mr2011962plb.50.1706557151825;
        Mon, 29 Jan 2024 11:39:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ju4-20020a170903428400b001d8cc3bfee8sm3075603plb.273.2024.01.29.11.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 11:39:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 29 Jan 2024 11:39:09 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.8-rc2
Message-ID: <39472f63-bb70-4ae6-b9cc-a95eee4c781d@roeck-us.net>
References: <CAHk-=wgxzm+Oc1ywuNGxb1R1=ZEC85LJi776R2QEpk6=_2Qfdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgxzm+Oc1ywuNGxb1R1=ZEC85LJi776R2QEpk6=_2Qfdw@mail.gmail.com>

On Sun, Jan 28, 2024 at 05:13:03PM -0800, Linus Torvalds wrote:
> So we had a number of small annoying issues in rc1, including an
> amdgpu scheduling bug that could cause a hung desktop (that would
> *eventually* recover, but after a long enough timeout that most people
> probably ended up rebooting instead. That one seems to have hit a fair
> number of people.
> 
> There was also a btrfs bug wrt zstd-compressed inline extents,
> although (somewhat) happily that wasn't in rc1 and got noticed and
> reverted fairly quickly, so hopefully it didn't hit very many people.
> It did me.
> 
> Anyway, I hope that with rc2, we're now in the more stable part of the
> release cycle, with those kinds of problems that might affect a lot of
> testers sorted out. So hopefully the fixes will be more subtle and not
> affect common core setups.
> 
> So go out and test. It's safe now. You trust me, right?
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 549 pass: 548 fail: 1
Failed tests:
	arm:mps2-an385:mps2_defconfig:mps2-an385:initrd

Caveats:
- I disabled CONFIG_WERROR for alpha, openrisc, sh, and sparc64 builds.
  This is because commit 0fcb70851fbf ("Makefile.extrawarn: turn on
  missing-prototypes globally") causes test builds on those architectures
  to fail if CONFIG_WERROR is enabled, and I really don't want to act as
  missing-prototypes police.

- I disabled CONFIG_FRAME_WARN entirely.
  The warning was just getting annoying, to a large part because people
  just keep adding functions with large stack frames. On top of that,
  the warning very much depends very much on the compiler and compiler
  version. Finally, most of the "fixes" I have seen over the years don't
  really solve the problem but just split affected functions into multiple
  sub-functions, with the overall stack frame being just as large or
  even larger than before. In my opinion that defeats the purpose of the
  warning, making it useless.

The mps2-an385 boot failure is due to commit 6f4c45cbcb00 ("kunit: Add
tests for csum_ipv6_magic and ip_fast_csum") which is buggy. Oddly enough,
I have only seen it with my mps2-an385 (arm nommu) boot test. A fix is
available at
https://lore.kernel.org/lkml/20240124-fix_sparse_errors_checksum_tests-v4-0-bc2b8d23a35c@rivosinc.com/

There is a new warning seen in various boot tests:

BUG: sleeping function called from invalid context at drivers/gpio/gpiolib.c:3749

This is exposed by commit 5d5dfc50e5689 ("gpiolib: remove extra_checks"),
which unconditionally enables the check. The underlying problem is that
sdhci_check_ro() disables interrupts but then (directly or indirectly)
calls mmc_gpio_get_ro() which calls gpiod_get_value_cansleep(). I am not
aware of a pending fix or how a fix should look like. Obviously, commit
5d5dfc50e5689 should not be reverted since it only exposes the problem
and did not cause it. Related discussion is at
https://lore.kernel.org/lkml/19dca2a9-36e1-4a6b-9b65-db4c0a163d56@roeck-us.net/

On top of that, there is at least one selftest failure.

    Expected handshake_req_destroy_test == req, but
        handshake_req_destroy_test == 00000000
        req == c3300da0
    not ok 11 req_destroy works
# Handshake API tests: pass:10 fail:1 skip:0 total:11

My system is not (yet) set up to track such failues (I only happened to
notice when browsing through logs), so I don't know if this is the only
selftest failure. I do see this in v6.6.y and v6.7.y, so it is not a
new problem. I don't know (and didn't check) if anyone is aware of it.

Guenter

