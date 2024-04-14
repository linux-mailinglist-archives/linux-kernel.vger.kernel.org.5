Return-Path: <linux-kernel+bounces-144057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFB78A4158
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529C61F21286
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173A7224F6;
	Sun, 14 Apr 2024 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IILAy9SM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2A8442F;
	Sun, 14 Apr 2024 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713084542; cv=none; b=KUvX6vxfbzhq7SlwikmQvC3ybr3aZbG7OxOHwjye/kqk/P56i9UTA482R9orGyTbHPI2bJ2MFRSEdOLKoWnfr9CFN1pZYoBrpnVl1z+eU3YmY7dyUNKtPpXvgZpPgKSDNBvblf5Whve6ZZ/81XtMNJjwSGiHFT5DXy0hUJwdHNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713084542; c=relaxed/simple;
	bh=WA4Z5y4LzUg1wHvgxOr562MTNIGpCk9DcL/aFmv8r7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISiWUbzG5jAdyt3FC2Q9Tl1Zi+R4f/qKJuk3YQ2VqudVtuGtDcU8p5ttqIHQErBd5GiwxStV30qIKowrazfowxrNHewf9ThGMGvIDU+WsjAEJwDeHvQQ1K9sORrF70T1fatEB5+KAcBLjZwATOxzcn1jPhGQVtdjcGkGWgPIuas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IILAy9SM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7ABC4AF08;
	Sun, 14 Apr 2024 08:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713084541;
	bh=WA4Z5y4LzUg1wHvgxOr562MTNIGpCk9DcL/aFmv8r7s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IILAy9SMbVFryjOp1yaDSBTcXqEp6F1G6uFaPUq/p2iNPnpUgweQkot9YK5ckFodO
	 +54tZEVIKpkB6iZ2VeceNGfv0+nuV82qYYNoVT3/53Ceqd0lOk+vSIYU5Zrjmk4tyz
	 L4q/2lBG93rXYXI5yra3YIGh0e3IX64h1f6e0MRE7EazTxN1p/HJeLFVro/5XzSf1/
	 1LBqcmd3F4cz9cG2pd6OOw+Pc1tXlTc0Txr2nfDzrmvX5JLgK9IZa4hpEcPPrNb3O8
	 0naa/IgMDgqCVXwcW4P+r+q4B5MSnPFt1yXgIwO5CWMKlZdf7QrjEvXXJpHZnd4CV/
	 W4V6wn1fl+nLw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d47a92cfefso27037331fa.1;
        Sun, 14 Apr 2024 01:49:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWps8bp8nJ8vbAx91HG0LDlYGoCEKgByj8zgMzwB5WY0BvZ9UTagUWCmVmhB2eOdDnDiZP1uAwnjigFAcGpTzf+Gq0FcqnWxqtFTV9HyKFCVofFpPRfY+mD7xSLbwQtzrSBhjhlriWa2ecOeYAi78DYxZgmAnmzE3ylq6hsph1jz0mhbIem
X-Gm-Message-State: AOJu0YwOFdam0GAGQJmyVP+y3tC7TNEb0eKS5GGwWe99JjP4v0tajPIi
	4MUw2FIo7kySh75v7Jpb9du78gPOrFW34Opj20y87MFLNYtQZLR+L0j+n+40GlpbxwETGkKGT+V
	SnTHlK/FS/XZmKQcIIkWYhbP3XlU=
X-Google-Smtp-Source: AGHT+IEgpOQI7bc9N8P85ZOSzlsU+QPBBv57blvXTmes/zs5XTE8cam7YyEYUKDCrpT4dy9CWt5ks9lNisbeKp32K7o=
X-Received: by 2002:a2e:8012:0:b0:2d8:d23a:f440 with SMTP id
 j18-20020a2e8012000000b002d8d23af440mr3946646ljg.6.1713084540184; Sun, 14 Apr
 2024 01:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405165610.1537698-1-vchernou@cisco.com> <ZhfLrGrED-ls6i5V@buildd.core.avm.de>
 <ZhgdjpE+yl3IYSzl@goliath> <Zhg5L2xO_lT4lLwp@fjasle.eu> <DS0PR11MB77652A4C98FCB671F5E5F3EEDE042@DS0PR11MB7765.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB77652A4C98FCB671F5E5F3EEDE042@DS0PR11MB7765.namprd11.prod.outlook.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 14 Apr 2024 17:48:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNASYjbMdq=R5hpgrGH3LFMhNKaEK4BEQOe3XoHDMrEaaDQ@mail.gmail.com>
Message-ID: <CAK7LNASYjbMdq=R5hpgrGH3LFMhNKaEK4BEQOe3XoHDMrEaaDQ@mail.gmail.com>
Subject: Re: [PATCH v3] Add MO(mod objs) variable to process ext modules with subdirs
To: "Valerii Chernous -X (vchernou - GLOBALLOGIC INC at Cisco)" <vchernou@cisco.com>
Cc: Nicolas Schier <nicolas@fjasle.eu>, "Daniel Walker (danielwa)" <danielwa@cisco.com>, 
	Nicolas Schier <n.schier@avm.de>, Nathan Chancellor <nathan@kernel.org>, 
	"xe-linux-external(mailer list)" <xe-linux-external@cisco.com>, Jonathan Corbet <corbet@lwn.net>, 
	"linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

The workaround described in the commit message
(overwrite 'src') is different from what I know.


As I explained to Daniel before, the point is,
O= refers to the kernel output directory, and
M= specifies a relative path to your downstream
module directory.


Say, you have a linux source tree and external modules
under ~/my-project-src/, and you want to output all
build artifacts under ~/my-build-dir/.


my-project-src
|-- linux
\-- my-modules




masahiro@zoe:~/my-project-src/my-modules$ tree
.
|-- Kbuild
|-- dir1
|   |-- Kbuild
|   |-- bar.c
|   `-- dir2
|       |-- Kbuild
|       `-- baz.c
`-- foo.c

3 directories, 6 files


masahiro@zoe:~/my-project-src/my-modules$ cat Kbuild
obj-m += foo.o
obj-m += dir1/

masahiro@zoe:~/my-project-src/my-modules$ cat dir1/Kbuild
obj-m += bar.o
obj-m += dir2/

masahiro@zoe:~/my-project-src/my-modules$ cat dir1/dir2/Kbuild
obj-m += baz.o



First, build the kernel and external modules
in separate output directories.

masahiro@zoe:~/my-project-src/linux$ make O=~/my-build-dir/linux defconfig all
[ snip ]


masahiro@zoe:~/my-project-src/linux$ make O=~/my-build-dir/linux M=../my-modules
make[1]: Entering directory '/home/masahiro/my-build-dir/linux'
  CC [M]  ../my-modules/dir1/dir2/baz.o
  CC [M]  ../my-modules/dir1/bar.o
  CC [M]  ../my-modules/foo.o
  MODPOST ../my-modules/Module.symvers
  CC [M]  ../my-modules/foo.mod.o
  LD [M]  ../my-modules/foo.ko
  CC [M]  ../my-modules/dir1/bar.mod.o
  LD [M]  ../my-modules/dir1/bar.ko
  CC [M]  ../my-modules/dir1/dir2/baz.mod.o
  LD [M]  ../my-modules/dir1/dir2/baz.ko
make[1]: Leaving directory '/home/masahiro/my-build-dir/linux'


masahiro@zoe:~/my-build-dir/my-modules$ tree
.
|-- Module.symvers
|-- dir1
|   |-- bar.ko
|   |-- bar.mod
|   |-- bar.mod.c
|   |-- bar.mod.o
|   |-- bar.o
|   |-- dir2
|   |   |-- baz.ko
|   |   |-- baz.mod
|   |   |-- baz.mod.c
|   |   |-- baz.mod.o
|   |   |-- baz.o
|   |   `-- modules.order
|   `-- modules.order
|-- foo.ko
|-- foo.mod
|-- foo.mod.c
|-- foo.mod.o
|-- foo.o
`-- modules.order

3 directories, 19 files


I saw this before somewhere.
I believe it is a well-known workaround
that works with recursion.






This patch submission is not helpful.


Kbuild does not support the external module builds
in a separate output directory.
Most people know this limitation for a long time.
You are not the first person to discover it.


Second, anybody can write a patch like yours
in several minutes.


There already exists a similar (but more correct) patch:

  https://lore.kernel.org/linux-kbuild/e58cba84c90c40108ac678500f33655e@xiaomi.com/


That one works more correctly than yours, because modpost
works with no error, and 'make clean' works too.


I am not suggesting to fix scripts/{Makefile.modpost,Makefile.clean}.


If such a patch had been acceptable,
it would have been accepted many years before.


Things are, the decision is postponed until
we are confident about a solution.
I must avoid a situation where a bad solution
is upstreamed as official.
That is worse than nothing.

And, I am pretty sure that your patch is not
the right solution.








--
Best Regards


Masahiro Yamada

