Return-Path: <linux-kernel+bounces-112639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F99887C5A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 11:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828921C20AFD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 10:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DC3175A6;
	Sun, 24 Mar 2024 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXafart0"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8B614A9F
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711277591; cv=none; b=rxcifttFbnZgxENCQq+qW6jbrBdR4mNoIC/BgPXdT3ermg0yQeDy3Y5qXE+n8STgoVtz3mCEy44VAbNpHCZwujFx8GXLgihwu+26WqTteh6gFanYk7Bt+ipC87kXaXDg077EKWSYji6KY86HEAbfs2fZXreTq/MejlGAWDQhsw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711277591; c=relaxed/simple;
	bh=02WFYjo3q+zmPDTqG8ER5AOJxcz5y2480Wjg+uakbbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9i8prR+UZhOUouu5mrOntJ7NukncyH+PmeRgobHtaWCl+yauJnv3TAhZK3cy810W/yHdlaetk3hg5IizMk7Rzg2iwXiL0eD1N28RMuG3DCW5M+w6cxgZ5kIRAjDIl83xZ91EkBGAl7Gf3AMkE+vQD8+HbXQCW7+ztLqj1lcQmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXafart0; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4749eecff7so86850266b.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 03:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711277588; x=1711882388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gVqbMOBJCwkWCoUW3W6SMDJpvngi0h9TYOykTnB/N8Q=;
        b=UXafart04GiA9ykkjcwyv+X5qKooDiPu7ACirgeRCM3pRnEzwlgnCsJ2RQVzaDyZTm
         Yp7NVJ6GQ87GNrSOC37ac1uSX303mYRpV5asS+K5pGN1DBVKuz/f9hMHDTU5yLXJY3Vi
         QOb/2JVn23dh6yoHUgc8Km9m8EW/0T1Rffu3jp/lNyGYO0FQtFj5+spEYkRgc2boUHxM
         YEMAQdn8cAmNOHhtkQ7p57u9gRlF3AXPc8dfivRD+S361WV1sezsIo7iEbiEUxwuSOXK
         QCYOS+hTHKMkKgxq6KKx+0dlvbxX32D0Qj5IHin62yb5ZF0au7WoCXfnBQtCzJ15wlrc
         24gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711277588; x=1711882388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVqbMOBJCwkWCoUW3W6SMDJpvngi0h9TYOykTnB/N8Q=;
        b=j6Gm9DsV84lYna37Okut0V1x89WbM1uLPTw9kMYUtUraGu07ouEII9+A7efiI55SDA
         c7+MxdmAUVusOe4R8uk1qpEAc2KFxl4muUQfmiU87mU9Ry40sY2JcIsYViEfmjEPSg/e
         h58xKT6IgBZ9L3tcC9uBAzgRTmwqaMMY02BcvXiy30p4mRPyXnh9VeJFrFIiikNdDbbF
         dsKT12Mq5A9KYA7XGH/0A/9G0nGQ5m1cJzqTEgArcapKShhndlj9Xl4l9UdZimf2Wksm
         J/2qNFF5g/50Gjm3BRYDcoIR58pCckFbiJcsdysg10z1Qx1mTjZ17pgWmNemGJiebMe1
         pH2g==
X-Forwarded-Encrypted: i=1; AJvYcCWgx8+JHTw8xXS18ooLiM8TrtON2T2po6IAgqbMhQgRnIIyNkkiMBw7rXNxPuaDxEB4484bI1ahFxSYEoOMxDw/WypQlX7KlgEMcWJv
X-Gm-Message-State: AOJu0YwC9L6Ik9kKkQXUxnNlRFZnF32PIAtwNggx0W1JUTTUQb+EHc9l
	I+kPZiogmo0RR7oZgAZQteV2fQ8fB+Jnn8XvKka+Qrj6+0Jx/P4W
X-Google-Smtp-Source: AGHT+IHj7Ov7VvZxAAqJfJSGbkcMamcU8+I1PST+PAaQCn7sbt8xQ7Njfz9js9NGAA5H291ALH5HJw==
X-Received: by 2002:a17:906:1808:b0:a47:3c27:74ba with SMTP id v8-20020a170906180800b00a473c2774bamr2762515eje.3.1711277588026;
        Sun, 24 Mar 2024 03:53:08 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id bu24-20020a170906a15800b00a46a2779475sm1850355ejb.101.2024.03.24.03.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 03:53:07 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 24 Mar 2024 11:53:05 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	David.Laight@aculab.com,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 00/16] x86-64: Stack protector and percpu improvements
Message-ID: <ZgAGEcmrWZyDrO50@gmail.com>
References: <20240322165233.71698-1-brgerst@gmail.com>
 <CAFULd4bCufzKjaUyOcJ5MfsPBcVTj1zQiP3+FFCGo6SbxTpK2A@mail.gmail.com>
 <Zf+PIYP4TyF6ZRVy@gmail.com>
 <CAMzpN2htOit94c-M+zHqEcLcGPOU2zTS6wM-r7xWwd9Ku8h3-Q@mail.gmail.com>
 <Zf+mjy49dG5ly9ka@gmail.com>
 <CAMzpN2go9mmyWRb9vsg7O1aAtSKrW=HqcZYmddkq7eZQQHuM1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMzpN2go9mmyWRb9vsg7O1aAtSKrW=HqcZYmddkq7eZQQHuM1Q@mail.gmail.com>


* Brian Gerst <brgerst@gmail.com> wrote:

> On Sun, Mar 24, 2024 at 12:05 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Brian Gerst <brgerst@gmail.com> wrote:
> >
> > > On Sat, Mar 23, 2024 at 10:25 PM Ingo Molnar <mingo@kernel.org> wrote:
> > > >
> > > >
> > > > * Uros Bizjak <ubizjak@gmail.com> wrote:
> > > >
> > > > > On Fri, Mar 22, 2024 at 5:52 PM Brian Gerst <brgerst@gmail.com> wrote:
> > > > > >
> > > > > > Currently, x86-64 uses an unusual percpu layout, where the percpu section
> > > > > > is linked at absolute address 0.  The reason behind this is that older GCC
> > > > > > versions placed the stack protector (if enabled) at a fixed offset from the
> > > > > > GS segment base.  Since the GS segement is also used for percpu variables,
> > > > > > this forced the current layout.
> > > > > >
> > > > > > GCC since version 8.1 supports a configurable location for the stack
> > > > > > protector value, which allows removal of the restriction on how the percpu
> > > > > > section is linked.  This allows the percpu section to be linked normally,
> > > > > > like other architectures.  In turn, this allows removal of code that was
> > > > > > needed to support the zero-based percpu section.
> > > > >
> > > > > The number of simplifications throughout the code, enabled by this
> > > > > patch set, is really impressive, and it reflects the number of
> > > > > workarounds to enable the feature that was originally not designed for
> > > > > the kernel usage. As noted above, this issue was recognized in the GCC
> > > > > compiler and the stack protector support was generalized by adding
> > > > > configurable location for the stack protector value [1,2].
> > > > >
> > > > > The improved stack protector support was implemented in gcc-8.1,
> > > > > released on May 2, 2018, when linux 4.17 was in development. In light
> > > > > of this fact, and 5 (soon 6) GCC major releases later, I'd like to ask
> > > > > if the objtool support to fixup earlier compilers is really necessary.
> > > > > Please note that years ago x86_32 simply dropped stack protector
> > > > > support with earlier compilers and IMO, we should follow this example
> > > > > also with x86_64, because:
> > > >
> > > > Ack on raising the minimum version requirement for x86-64
> > > > stackprotector to 8.1 or so - this causes no real pain on the distro
> > > > side: when *this* new kernel of ours is picked by a distro, it almost
> > > > always goes hand in hand with a compiler version upgrade.
> > > >
> > > > We should be careful with fixes marked for -stable backport, but other
> > > > than that, new improvements like Brian's series are a fair game to
> > > > tweak compiler version requirements.
> > > >
> > > > But please emit a (single) prominent build-time warning if a feature is
> > > > disabled though, even if there are no functional side-effects, such as
> > > > for hardening features.
> > >
> > > Disabled for any reason or only if the compiler lacks support?
> >
> > Only if the user desires to have it enabled, but it's not possible due
> > to compiler (or other build environment) reasons. Ie. if something
> > unexpected happens from the user's perspective.
> >
> > The .config option is preserved even if the compiler doesn't support
> > it, right?
> >
> > I suspect this should also cover features that get select-ed by a
> > feature that the user enables. (Not sure about architecture level
> > select-ed options.)
> >
> > Thanks,
> >
> >         Ingo
> 
> I could add something like:
> 
> comment "Stack protector is not supported by the architecture or compiler"
>        depends on !HAVE_STACKPROTECTOR
> 
> But, "make oldconfig" will still silently disable stack protector if 
> the compiler doesn't support the new options.  It does put the 
> comment into the .config file though, so that may be enough.

So I was thinking more along the lines of emitting an actual warning to 
the build log, every time the compiler check is executed and fails to 
detect [certain] essential or good-to-have compiler features.

A bit like the red '[ OFF ]' build lines during the perf build:

Auto-detecting system features:

..                                   dwarf: [ on  ]
..                      dwarf_getlocations: [ on  ]
..                                   glibc: [ on  ]
..                                  libbfd: [ on  ]
..                          libbfd-buildid: [ on  ]
..                                  libcap: [ on  ]
..                                  libelf: [ on  ]
..                                 libnuma: [ on  ]
..                  numa_num_possible_cpus: [ on  ]
..                                 libperl: [ on  ]
..                               libpython: [ on  ]
..                               libcrypto: [ on  ]
..                               libunwind: [ on  ]
..                      libdw-dwarf-unwind: [ on  ]
..                             libcapstone: [ OFF ]  <========
..                                    zlib: [ on  ]
..                                    lzma: [ on  ]
..                               get_cpuid: [ on  ]
..                                     bpf: [ on  ]
..                                  libaio: [ on  ]
..                                 libzstd: [ on  ]

.. or something like that.

Thanks,

	Ingo

