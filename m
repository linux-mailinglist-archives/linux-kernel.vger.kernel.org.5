Return-Path: <linux-kernel+bounces-16300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65321823C72
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751221C24903
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5961DDF6;
	Thu,  4 Jan 2024 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhouGKDJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D843E1DDF5;
	Thu,  4 Jan 2024 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbdc52f2359so185994276.3;
        Wed, 03 Jan 2024 23:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704351876; x=1704956676; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2NwTt2NbWw4Kkm247MtnJ9iKfzRad5J8SoV+QQUR7iI=;
        b=EhouGKDJJph5GyvY1/yGmi51hHBai3qmrSuV2y6HN5NHd0vpn/XhKVXiwqZnV1x7Ni
         FN6QjbrCF+f8Dw0aYqleFGwRqhNXj5C9LlYa5crbhh7mUn+rCe2TWkOYMCi7cX0UsZar
         FX2nSwHCkudajG6g/B68iPU+5kggtVxleRpkKDDI7oZtsKgZMQyG0ft7Lz9bGv5jS5Jp
         NYCEvpbAHLLeXJ7nkTv5wLV/HCLgQf7c23T1yu/3SYBUFYkVr8T5hKVMWeM6eVz9JHWQ
         WN9L4c97cJyFXdvAbumTtsmjMccM92B2rbOwXBIsOjoSrZqXicMj08sseXGWYZdeLMmW
         c7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704351876; x=1704956676;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2NwTt2NbWw4Kkm247MtnJ9iKfzRad5J8SoV+QQUR7iI=;
        b=WSlZAv7Yzmqd+r981glhoiVoOYTo98eK7brl9Av3DH9Rq8yxEiPrF6gc3A1lAhY48A
         9qBp75+IOkD8iCXB4N2xC5UcgJBovAiGGj2BuK8XFZ2FdaKCJBU6WoaJKZyd0/kVVWin
         PU1Y0w77xSIANt9ZAGAw4s938Ydszqhr+GafR9Ad9l0q8ue/Y9YyGw5QGLxwUL1ctvsw
         xSdrIt7LFF2OCgxbKG1V7e0ZOYOhbHU1YYMUgzTnm1gHawZJYnuhctxmNUdrsBeQGJbx
         hjPAm0DTFYjiquFnYqSBkGImBInQGQk33bHfZv2d7kAWudLYjDIjz+ikdGO5huE7Sgl7
         iZyQ==
X-Gm-Message-State: AOJu0Yz3wETNcpgoI31wwD0TlKpbjbYrC+WqDCiJ2AQ/mB6E7PUqhLD1
	DulFjNbUnShyXCXPZ7gkWx4=
X-Google-Smtp-Source: AGHT+IGbegY83fgKKzFeWc2YFv4/nG75WpO1zAqC2X0tCMLQfCIPutl+hGh0BkbcTMhilBM9hvDqLA==
X-Received: by 2002:a25:8d02:0:b0:db7:dad0:76dd with SMTP id n2-20020a258d02000000b00db7dad076ddmr139208ybl.121.1704351875683;
        Wed, 03 Jan 2024 23:04:35 -0800 (PST)
Received: from [10.8.0.9] ([185.215.181.24])
        by smtp.gmail.com with ESMTPSA id 123-20020a250c81000000b00dbdaf5980cesm6729650ybm.35.2024.01.03.23.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 23:04:35 -0800 (PST)
Date: Thu, 4 Jan 2024 02:04:21 -0500 (EST)
From: Kevin Martin <kevinmbecause@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>
cc: Kevin Martin <kevinmbecause@gmail.com>, 
    Nathan Chancellor <nathan@kernel.org>, 
    Nick Desaulniers <ndesaulniers@google.com>, 
    Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kbuild: Enable decompression for use by EXTRA_FIRMWARE
 The build system can currently only compress files. This patch adds the
 functionality to decompress files. Decompression is needed for building
 firmware files into the kernel if those files are compressed on the filesystem.
 Compressed firmware files are in use by Gentoo, Fedora, Arch, and others.
In-Reply-To: <CAK7LNAQX+h-a3yBEOqXG2_7mw+6bS5NmJ=UYAEt=oghQvi4W2Q@mail.gmail.com>
Message-ID: <d5989a0b-f46f-fb49-8d44-1822d69bc4cf@gmail.com>
References: <cover.1703042081.git.kevinmbecause@gmail.com> <941a566eb114701685dc44f708f81891b3bd085b.1703042082.git.kevinmbecause@gmail.com> <CAK7LNAQX+h-a3yBEOqXG2_7mw+6bS5NmJ=UYAEt=oghQvi4W2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463794175-1496103403-1704351862=:10791"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463794175-1496103403-1704351862=:10791
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Wed, 3 Jan 2024, Masahiro Yamada wrote:

> On Wed, Dec 20, 2023 at 7:26 PM Kevin Martin <kevinmbecause@gmail.com> wrote:
> >
> > Signed-off-by: Kevin Martin <kevinmbecause@gmail.com>
> > ---
> >  scripts/Makefile.lib | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 1a965fe68..d043be3dc 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -523,6 +523,9 @@ quiet_cmd_xzkern_with_size = XZKERN  $@
> >  quiet_cmd_xzmisc = XZMISC  $@
> >        cmd_xzmisc = cat $(real-prereqs) | $(XZ) --check=crc32 --lzma2=dict=1MiB > $@
> >
> > +quiet_cmd_xzdec = XZDEC   $@
> > +      cmd_xzdec = cat $(real-prereqs) | $(XZ) --decompress > $@
> > +
> 
> 
> 
> Please do not fork the meaningless 'cat' process.
> 
> This should be a single process to take just one input file.
> 
>     cmd_xzdec = $(XZ) --decompress --stdout $< > $@
> 
> 
> 
> 
> Commit d3dd3b5a29bb9582957451531fed461628dfc834
> was a very bad commit.
> 
> The 'cat' and compression/decompression must be
> separate rules.
> 
> We should not repeat the mistake in the past.
> 

Would it be preferable to change all of the compression rules or just the 
new decompression rules?

I could change just the new ones and then begin working on a different 
patch to clean up the 'cat' processes in the compression rules.

> 
> 
> >  # ZSTD
> >  # ---------------------------------------------------------------------------
> >  # Appends the uncompressed size of the data using size_append. The .zst
> > @@ -548,6 +551,9 @@ quiet_cmd_zstd22 = ZSTD22  $@
> >  quiet_cmd_zstd22_with_size = ZSTD22  $@
> >        cmd_zstd22_with_size = { cat $(real-prereqs) | $(ZSTD) -22 --ultra; $(size_append); } > $@
> >
> > +quiet_cmd_zstddec = ZSTDDEC $@
> > +      cmd_zstddec = cat $(real-prereqs) | $(ZSTD) --decompress > $@
> > +
> 
> 
> Same here.
> Please make this a single process:
> 
>    cmd_zstddec = $(ZSTD) --decompress --force --output=$@ $<
> 
> 
> 
> 
> 
> 
> One small concern in the future is, if we end up with adding
> quiet_cmd_bzip2dec, we will run out of the 7-column of the short log.
> 
>  quiet_cmd_bzip2dec = BZIP2DEC$@
> 
> We can increase the column size if needed, so I do not think
> it is a big issue.
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> >  # ASM offsets
> >  # ---------------------------------------------------------------------------
> >
> > --
> > 2.41.0
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
> 
---1463794175-1496103403-1704351862=:10791--

