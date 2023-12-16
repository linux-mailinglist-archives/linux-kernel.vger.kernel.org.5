Return-Path: <linux-kernel+bounces-1926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52778155F2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18972871FC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D8B110E;
	Sat, 16 Dec 2023 01:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KroAWxM3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CD310EE;
	Sat, 16 Dec 2023 01:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7B9C433CB;
	Sat, 16 Dec 2023 01:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702689922;
	bh=occtvWUQzDAQVVpXxNZtIid/3QZhQJ78ogsGIb239N4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KroAWxM3X8tRxn5qSsu8U09GCAvrF0XKdNmvVDazPxGWnrchrR2veYaURK4PjN4dT
	 KQFeMeldFE1eepTnrf4fXWbcEJ2zkxuwJifA9/yJ5B9GtFhEr2MDpI3WZ1CNWXskgI
	 44TiKf00Jw4bgtyhIsN0kgme4x3L0YiOSQNK8lGA5j20KXmLBEymTNBjpf2wt+j2VQ
	 bm9XL76B7SJTtIUhgov6qYjMcJb/xxQol4ujRVD0T4znhfHZwTZZYxn01HdI4lN135
	 jHMqeyya/b0aqCJFSL+vLil0M0T/jBiF1qGkBGRFCHxGrUWoJ2GnycoRGdqW6v6gSD
	 turdbQtvOyLXQ==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1f060e059a3so897418fac.1;
        Fri, 15 Dec 2023 17:25:22 -0800 (PST)
X-Gm-Message-State: AOJu0YzjZOw1fLQbGez6IPeh12V5dyMS739dRnXB3onm75TE4PFhcyl5
	3FwEWB0AxqYgez6WFw8ur9Ta2jNZqT8+EQz0u00=
X-Google-Smtp-Source: AGHT+IGGGj9AnbZRwr5dFn5RXaIzH8exesKrfIxJKQbGZqbqr21EF37H60vyWCsoEvrJrZ8uINpXhjw7Cgn3K3CvBq8=
X-Received: by 2002:a05:6870:b605:b0:1fa:fcd5:9bb6 with SMTP id
 cm5-20020a056870b60500b001fafcd59bb6mr15146364oab.22.1702689921925; Fri, 15
 Dec 2023 17:25:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXthQYablvopq0su@eldamar.lan> <ZXtieLq1kTs4pIbL@eldamar.lan>
In-Reply-To: <ZXtieLq1kTs4pIbL@eldamar.lan>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 16 Dec 2023 10:24:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT9bQhYtuCWN=avwWxOwKO563g0tK1AgRBhRknzMB+6aQ@mail.gmail.com>
Message-ID: <CAK7LNAT9bQhYtuCWN=avwWxOwKO563g0tK1AgRBhRknzMB+6aQ@mail.gmail.com>
Subject: Re: make deb-pkg: Does not strip debug symbols when compressing modules
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>, 
	Bastian Blank <waldi@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 5:16=E2=80=AFAM Salvatore Bonaccorso <carnil@debian=
.org> wrote:
>
> Hi,
>
> On Thu, Dec 14, 2023 at 09:10:41PM +0100, Salvatore Bonaccorso wrote:
> > Hi
> >
> > When using (only tested with XZ compression, but the others should
> > behave similarly) CONFIG_MODULE_COMPRESS_XZ=3Dy to compress the modules=
,
> > it looks that the debug symbols are not striped.
> >
> > Building with the attached test configuration results in packages:
> >
> > -rw-r--r-- 1 build build  8.9M Dec 14 20:47 linux-headers-6.7.0-rc5+_6.=
7.0-rc5-00042-g88035e5694a8-1_amd64.deb
> > -rw-r--r-- 1 build build   75M Dec 14 20:48 linux-image-6.7.0-rc5+-dbg_=
6.7.0-rc5-00042-g88035e5694a8-1_amd64.deb
> > -rw-r--r-- 1 build build 1014M Dec 14 20:47 linux-image-6.7.0-rc5+_6.7.=
0-rc5-00042-g88035e5694a8-1_amd64.deb
> > -rw-r--r-- 1 build build  1.3M Dec 14 20:47 linux-libc-dev_6.7.0-rc5-00=
042-g88035e5694a8-1_amd64.deb
> >
> > This is odd, the linux-image-6.7.0-rc5+ package has a size of almost
> > 1G and the modules are not stripped.
> >
> > Switching the values instread to
> >
> > CONFIG_MODULE_COMPRESS_NONE=3Dy
> > # CONFIG_MODULE_COMPRESS_XZ is not set
> >
> > the packages are again produced correctly:
> >
> > -rw-r--r-- 1 build build 8.9M Dec 14 20:59 linux-headers-6.7.0-rc5+_6.7=
.0-rc5-00042-g88035e5694a8-2_amd64.deb
> > -rw-r--r-- 1 build build 819M Dec 14 21:00 linux-image-6.7.0-rc5+-dbg_6=
.7.0-rc5-00042-g88035e5694a8-2_amd64.deb
> > -rw-r--r-- 1 build build  73M Dec 14 20:59 linux-image-6.7.0-rc5+_6.7.0=
-rc5-00042-g88035e5694a8-2_amd64.deb
> > -rw-r--r-- 1 build build 1.3M Dec 14 20:59 linux-libc-dev_6.7.0-rc5-000=
42-g88035e5694a8-2_amd64.deb
>
> and the classical one. Missed to attach the promised attachement. The
> used config is now here.
>
> Regards,
> Salvatore



The debug package never compiled properly with module compression.

The suffix of modules is .ko.xz instead of .ko in your case.



The following line in scripts/package/builddeb does not match anything.


   for module in $(find ${image_pdir}/lib/modules/ -name *.ko -printf
'%P\n'); do


So, nothing is copied to linux-image-dbg, nothing is stripped from linux-im=
age.



Debian kernel does similar, and it was OK because
Debian does not enable CONFIG_MODULE_COMPRESS_*.



Recently, the following commit was applied.  [1]



commit de26137e2a9f847ce65e370d4bf61745f75a4e5d
Author:     Bastian Blank <waldi@debian.org>
AuthorDate: Wed Dec 14 09:52:23 2022 +0100
Commit:     Bastian Blank <waldi@debian.org>
CommitDate: Sun Oct 8 10:29:38 2023 +0200

    Drop not needed extra step to add debug links

    The build step already includes a sufficient GNU debug link section
    containing a build ID in the kernel modules.  This means we don't have
    to manually create one later, so remove the code that does it.





Perhaps, upstream kernel can do similar things to make the code simpler.
('make module_install INSTALL_MOD_STRIP=3D1' for linux-image,
'make modules_install' for linux-image-dbg)



I CCed Ben and Bastian.



[1] https://salsa.debian.org/kernel-team/linux/-/commit/de26137e2a9f847ce65=
e370d4bf61745f75a4e5d








--=20
Best Regards
Masahiro Yamada

