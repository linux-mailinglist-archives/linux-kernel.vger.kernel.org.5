Return-Path: <linux-kernel+bounces-81070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E620B866FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239BB1C25BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEA35E3AF;
	Mon, 26 Feb 2024 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbMYM2N5"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4315E206
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940367; cv=none; b=VdsS4gbsJ+Yqha3RorUuXfxfahPoU3waZc/vZLEgTP1c58M9KMu+U5Z9bpPIuOy2g/5tZYqWE0/IpUOnBhIm/Aw+y7KaJqPqMXKwUm6B9n8yin81MRZNenX290WcFfmITvlbrGNSgrZj9L2wt0OCEOEk1GWKQ121VgoEJL/Teto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940367; c=relaxed/simple;
	bh=IavIG0g1v8LmPORHMED6UWZGFdjAHpVcXibOsPkq//0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qSpZoGlT2qEfNhWJZGxGKtUT72hJk9+MgV8KVyE+QtZQKKgphw2TeZBW3JcuhQ1+tsruhYhC3e0rDDADYcUdHTqYK9FLhQpo0wJkGr4V0zX9aPCN0bbAlmfIlg0BI5cLJMRJdqxyzWo2DyXKqqETpDnjF2Y13shx48Wt8t7EAs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbMYM2N5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2997cb49711so1121014a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708940365; x=1709545165; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IavIG0g1v8LmPORHMED6UWZGFdjAHpVcXibOsPkq//0=;
        b=bbMYM2N5m7N91QbkIPtt6+VCmAR5hiIFGyh8goG7mT8OHqBdr3z/Ji5nPvbgU9POGT
         KSNzF038y53x9/JWQsnLpKHxsqZNYpkTbztxc68zY1gU0fKbGW1AiQPwPd45vXY8+q+f
         oncy0RfoKNPE6G4ZL+z4KyImowTGmHnq72xgVlIr73brFeuw/T4dLaJvQxXlgkaXDiJr
         68C8QR02kc0k6BH2vBNRUAHpzipp1nwJC0tYWMjgycoburwhXjNPOf/HycAaRG+w1G2y
         lOJE1pllU/qOAgCd9e+u/I+VCvieFYTZ09ABWBiciiP+v95Q3772PMNYIU1iOWfqr9bW
         znUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940365; x=1709545165;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IavIG0g1v8LmPORHMED6UWZGFdjAHpVcXibOsPkq//0=;
        b=MEswVj3gka5nZdu0IxXRW31bk0Y+XPXEI9u1ko5gp7wCn9dJNFcVwom2qj4Y3ODJ9u
         lYc3f1IFG7loHL6Cl/Zgyqg5K3b1E/zpuSa4ZuBjoF9N5avgtHefLWAUl5ICA2FBkfuF
         hzwmCGZjQTE8cELrX7VrgD2GLzr67Yo/TBrQUG3Warvs+pGMgtJbeSrsaMy9J4Qyi6en
         hAGg/aNYMc3XjMkZMQ50c+0PPEOlen32CdoS9Kff96bHq2jq/FQQ03bdHbHwP5fEkflb
         fmLaQzzOL/tLVA1/THOxcBjsXJIiQv9KJzz8Roy88s7GpKveyWfv8mFO+ucoVevMXWyA
         fuWA==
X-Gm-Message-State: AOJu0Yy1kRqGGjfEEQEnpyeA7PBPLoBp8qk7IW3777cJgtp/up15Q03a
	DVbcGS+Opod/oFDX+xMRSLZGgj4q6qgV+YMuOoXpS9p0Q7fqk4o7ZC5kQomChUaZXVxTJ48pmV+
	atU3neY4IE/ZbSlGAbpgOHqEZBDSwym9jaAA=
X-Google-Smtp-Source: AGHT+IEws3hDtdZtbDHpFD5c9NKO+7CVMKsJv97LOGyQ4yxs4i0XemmE/7jQfUkuf86LJcbzE7qESE6BsP+O+2IELao=
X-Received: by 2002:a17:90a:7448:b0:29a:60bc:ae07 with SMTP id
 o8-20020a17090a744800b0029a60bcae07mr4431757pjk.35.1708940365194; Mon, 26 Feb
 2024 01:39:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Edwards <mutazilah@gmail.com>
Date: Mon, 26 Feb 2024 17:39:12 +0800
Message-ID: <CAMi4NxYC-YBss0g7LkCVSz0=f8TSV2KnOGecr7KOqczGZOgZZA@mail.gmail.com>
Subject: non-zero O_TEXT for open syscall for Linux binaries (not source)
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

(I would like to be cced to email if possible)

Hello.

I would like to construct some custom Linux (not other-system)
binaries that are intended to run on both a genuine Linux x86
system and a non-Linux system where CRLF is used for line
endings of text (not binary) files. When the Linux binary is run
on a genuine Linux system, the line ending is expected to be
just LF - as now.

I believe I have everything in place to begin the construction
of the non-Linux system.

The non-Linux system is not intended to claim POSIX-compliance,
and will just run certain carefully-constructed Linux binaries that
do direct syscalls (no shared libraries are used). I have control
of a C library that will do this. There are other ways to kludge
conditional execution, but the neatest solution is an official
O_TEXT (for the same reason that Cygwin created one -
giving prior art).

I can actually go ahead and do this myself by just defining
O_TEXT to 0x8000 0000 - and it will be a long time - if
ever - before Linux uses this bit for an open flag for
something else.

Another option would be to define O_TEXT to the same as
O_NOATIME as I don't care if my text files (only) on Linux
don't get the access time set, but the binary ones all do.
The non-Linux system would in turn be forever unable to
do anything with the access time - but that doesn't bother me
much. Another flag could be used instead though, that has
even less impact (any suggestions?).

But the neatest option is to get an official flag for Linux.

It's not enough to get POSIX updated either, as Linux can
simply set O_TEXT to 0 to satisfy the POSIX requirements.

So it is Linux that matters.

Any suggestions before I go ahead with proof of concept?

Thanks. Paul.

