Return-Path: <linux-kernel+bounces-44233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02399841F2E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2715E1C24692
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC995DF1E;
	Tue, 30 Jan 2024 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LI6damsW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34915F849;
	Tue, 30 Jan 2024 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606214; cv=none; b=XvbbbBv4BdN96/6qNjjvBLQnacO7PJrWZfhkwJ15QCMoS3YC8pnX4RH7SWYvqI77i3v+2n+PmX61Vncnn89qiuJY/gyJV8O0uijEXNQDXM3ZLcpsl6vxL5YWQXqtdzrwlN1st22V+aX9K0WZKM57YwSE0z2XuTX21yhvd6ivqeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606214; c=relaxed/simple;
	bh=tTAS6UztStpo0SYXx14eTSJP+yk4zMdR6h+ep2k7+s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6Ij615pRaliq8G9j4eYMggyg+tJ4g4nwtkHMHnHomHeyq0fFIK8HnjL8dWRdTv9r6rjrwUzu7CQMsQHtKGc4TYIJC0rQlxHpkdvk/XopndELc1/xvDaqdnnVSHkQVwxQGH/huqO+UqQ4zPwQLnhNsNfeQ9YjLokPogi9qpB75I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LI6damsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF54C433F1;
	Tue, 30 Jan 2024 09:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706606213;
	bh=tTAS6UztStpo0SYXx14eTSJP+yk4zMdR6h+ep2k7+s4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LI6damsWx45gi0EMf45wHMGUnuXtIwsTNZogYgpI5h5B+rgxfpc9gOdVtrqGbUGIa
	 +UJujQrtAIFMXyzaUjuM7PEaxxWUP74kPpmpKFg8eOblA6UPD2Qxxj3yNhQBPFgJ3k
	 MbNuoA8jnneE4CH3xGTInz1nauTv8RJPLKlT5zdGGHxDfg6IaugG4MhiDtWg3QT4KK
	 /ZXHpgr2oaaQR6EZsIFKSr5FraPB+3mSJ24KuNOGt3q6NF4QEfzDSQpOZtwEAyiCWq
	 KgB6ZslNcjIPKDZK/dxqlRF8woq2Z5ITZ93fjHEGquF2SV0m9hq476FEnmeITe8JZ7
	 izDIdpR4+sdDw==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-210ce33ea1aso1917683fac.0;
        Tue, 30 Jan 2024 01:16:53 -0800 (PST)
X-Gm-Message-State: AOJu0Yww8nKGiBtIzUIVR9O2YbCT0ZoP9wDTRjuamPzZyktJW8ftps2T
	cGn2fuSjeLZDNtEC+f2smapa0sNMaai2MbjBOTiEeg5lqWoLgaST/p/9WOLUaO2ChfO32BwawwA
	RVWcxXNSYrexTNZtk+h84hlSKRjc=
X-Google-Smtp-Source: AGHT+IEZ5HgcZiwMnOtdPH0wJzLQI3BAbDfeft5qApbQhSwGWUprF5hwqNIGW5fDJY9ewFd9/U2oFc9Fzwd4QPxuasc=
X-Received: by 2002:a05:6870:b684:b0:214:ff12:3dda with SMTP id
 cy4-20020a056870b68400b00214ff123ddamr7405022oab.2.1706606212712; Tue, 30 Jan
 2024 01:16:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org> <20231202035511.487946-3-sjg@chromium.org>
 <20231213121353.GA31326@willie-the-truck> <CAFLszTjfmSx1YMqzb2TsQf7sP4KrcQB=X7DY_HxRQp0J5HAppQ@mail.gmail.com>
 <CAK7LNAQRCDC03e=TVO=k4FuD2a2RdTy7yLr3UptQjVCX7pM1CA@mail.gmail.com>
 <20240109143349.GR1610741@bill-the-cat> <CAFLszTjwhy24UiT6kUJABMC1Xn0h9Q1q9fYpZZJg9DX8Vss9cA@mail.gmail.com>
 <CAFLszTjPAHd6RdO1mvatXC=yRS+h=sgJ_pMdyEnkROTx7yRpog@mail.gmail.com>
In-Reply-To: <CAFLszTjPAHd6RdO1mvatXC=yRS+h=sgJ_pMdyEnkROTx7yRpog@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 30 Jan 2024 18:16:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNARsY6-rrx=sNFq6oFqpqf0s5S_=3DrUsCOS7zF0BXcoTg@mail.gmail.com>
Message-ID: <CAK7LNARsY6-rrx=sNFq6oFqpqf0s5S_=3DrUsCOS7zF0BXcoTg@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
	U-Boot Mailing List <u-boot@lists.denx.de>, Nicolas Schier <nicolas@fjasle.eu>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	workflows@vger.kernel.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 1:04=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi,
>
> On Wed, 17 Jan 2024 at 06:14, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Masahiro, Tom,
> >
> > On Tue, 9 Jan 2024 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Jan 09, 2024 at 11:01:42PM +0900, Masahiro Yamada wrote:
> > > > Hi Simon,
> > > >
> > > >
> > > > On Wed, Jan 3, 2024 at 8:47=E2=80=AFAM Simon Glass <sjg@chromium.or=
g> wrote:
> > > > >
> > > > > Hi Masahiro,
> > > > >
> > > > > On Wed, Dec 13, 2023 at 5:14=E2=80=AFAM Will Deacon <will@kernel.=
org> wrote:
> > > > > >
> > > > > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
> > > > > > > Add a script which produces a Flat Image Tree (FIT), a single=
 file
> > > > > > > containing the built kernel and associated devicetree files.
> > > > > > > Compression defaults to gzip which gives a good balance of si=
ze and
> > > > > > > performance.
> > > > > > >
> > > > > > > The files compress from about 86MB to 24MB using this approac=
h.
> > > > > > >
> > > > > > > The FIT can be used by bootloaders which support it, such as =
U-Boot
> > > > > > > and Linuxboot. It permits automatic selection of the correct
> > > > > > > devicetree, matching the compatible string of the running boa=
rd with
> > > > > > > the closest compatible string in the FIT. There is no need fo=
r
> > > > > > > filenames or other workarounds.
> > > > > > >
> > > > > > > Add a 'make image.fit' build target for arm64, as well. Use
> > > > > > > FIT_COMPRESSION to select a different algorithm.
> > > > > > >
> > > > > > > The FIT can be examined using 'dumpimage -l'.
> > > > > > >
> > > > > > > This features requires pylibfdt (use 'pip install libfdt'). I=
t also
> > > > > > > requires compression utilities for the algorithm being used. =
Supported
> > > > > > > compression options are the same as the Image.xxx files. For =
now there
> > > > > > > is no way to change the compression other than by editing the=
 rule for
> > > > > > > $(obj)/image.fit
> > > > > > >
> > > > > > > While FIT supports a ramdisk / initrd, no attempt is made to =
support
> > > > > > > this here, since it must be built separately from the Linux b=
uild.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes in v9:
> > > > > > > - Move the compression control into Makefile.lib
> > > > > > >
> > > > > > > Changes in v8:
> > > > > > > - Drop compatible string in FDT node
> > > > > > > - Correct sorting of MAINTAINERS to before ARM64 PORT
> > > > > > > - Turn compress part of the make_fit.py comment in to a sente=
nce
> > > > > > > - Add two blank lines before parse_args() and setup_fit()
> > > > > > > - Use 'image.fit: dtbs' instead of BUILD_DTBS var
> > > > > > > - Use '$(<D)/dts' instead of '$(dir $<)dts'
> > > > > > > - Add 'mkimage' details Documentation/process/changes.rst
> > > > > > > - Allow changing the compression used
> > > > > > > - Tweak cover letter since there is only one clean-up patch
> > > > > > >
> > > > > > > Changes in v7:
> > > > > > > - Add Image as a dependency of image.fit
> > > > > > > - Drop kbuild tag
> > > > > > > - Add dependency on dtbs
> > > > > > > - Drop unnecessary path separator for dtbs
> > > > > > > - Rebase to -next
> > > > > > >
> > > > > > > Changes in v5:
> > > > > > > - Drop patch previously applied
> > > > > > > - Correct compression rule which was broken in v4
> > > > > > >
> > > > > > > Changes in v4:
> > > > > > > - Use single quotes for UIMAGE_NAME
> > > > > > >
> > > > > > > Changes in v3:
> > > > > > > - Drop temporary file image.itk
> > > > > > > - Drop patch 'Use double quotes for image name'
> > > > > > > - Drop double quotes in use of UIMAGE_NAME
> > > > > > > - Drop unnecessary CONFIG_EFI_ZBOOT condition for help
> > > > > > > - Avoid hard-coding "arm64" for the DT architecture
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > - Drop patch previously applied
> > > > > > > - Add .gitignore file
> > > > > > > - Move fit rule to Makefile.lib using an intermediate file
> > > > > > > - Drop dependency on CONFIG_EFI_ZBOOT
> > > > > > > - Pick up .dtb files separately from the kernel
> > > > > > > - Correct pylint too-many-args warning for write_kernel()
> > > > > > > - Include the kernel image in the file count
> > > > > > > - Add a pointer to the FIT spec and mention of its wide indus=
try usage
> > > > > > > - Mention the kernel version in the FIT description
> > > > > > >
> > > > > > >  Documentation/process/changes.rst |   9 +
> > > > > > >  MAINTAINERS                       |   7 +
> > > > > > >  arch/arm64/Makefile               |   7 +-
> > > > > > >  arch/arm64/boot/.gitignore        |   1 +
> > > > > > >  arch/arm64/boot/Makefile          |   6 +-
> > > > > > >  scripts/Makefile.lib              |  16 ++
> > > > > > >  scripts/make_fit.py               | 291 ++++++++++++++++++++=
++++++++++
> > > > > > >  7 files changed, 334 insertions(+), 3 deletions(-)
> > > > > > >  create mode 100755 scripts/make_fit.py
> > > > > >
> > > > > > I'll need Masahiro's Ack on the scripts/ changes before I can t=
ake this
> > > > > > one.
> > > > >
> > > > > Any thoughts on this request, please?
> > > > >
> > > > > Regards,
> > > > > Simon
> > > > >
> > > >
> > > >
> > > >
> > > > As I mentioned before, I am concerned with having
> > > > the same "compatible" entries, with different contents,
> > > > as you use the "compatible" string as an ID to selecting
> > > > the target config node, right?
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > $ fdtdump  arch/arm64/boot/image.fit
> > > >
> > > >         ...
> > > >
> > > >         conf-10 {
> > > >             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> > > > "tq,am642-tqma6442l", "ti,am642";
> > > >             description =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL c=
arrier board";
> > > >             fdt =3D "fdt-10";
> > > >             kernel =3D "kernel";
> > > >         };
> > > >
> > > >         ...
> > > >
> > > >         conf-25 {
> > > >             compatible =3D "tq,am642-tqma6442l-mbax4xxl",
> > > > "tq,am642-tqma6442l", "ti,am642";
> > > >             description =3D "TQ-Systems TQMa64xxL SoM on MBax4xxL c=
arrier board";
> > > >             fdt =3D "fdt-25";
> > > >             kernel =3D "kernel";
> > > >         };
> > >
> > > I had asked Rob a while ago about if having the same compatible for t=
wo
> > > functionally different machines is a feature, or a bug, and I don't
> > > think either of us fully agreed either way. I'd be leaning towards
> > > saying the above example is a bug in the dts files, it's just not bee=
n a
> > > bug people have worried about before due to (sadly) how little the
> > > top-level compatible has been used.
> >
> > Yes I believe this is a bug in the files.
> >
> > What should the script do in this case? Print a warning, perhaps?
>
> Is there anything I should do here? Would a warning be helpful, or
> just confusing?



I do not think it is useful.
You would almost always get a warning, and there is no way to fix it.



With arm64 defconfig, image.fit will include a thousand DTBs.


The config node of my board was listed 214th.
(I found it by fdtdump)


Then, I learned

  >  bootm  ${loadaddr}#conf-214

is the correct command to boot my board.


Of course, the "214" will be different in the future.

The node names, conf-*, are useless.



Only the useful way is to enable CONFIG_FIT_BEST_MATCH in U-Boot,
but this relies on the uniqueness of a compatible string,
which is not true.

(I do not know how to do it in barebox)





I think using the file name as a config node
mitigates the issue because a file name is
considered unique.


For example, with composite DTBs:

imx8mm-venice-gw72xx-0x-imx219-dtbs :=3D imx8mm-venice-gw72xx-0x.dtb
imx8mm-venice-gw72xx-0x-imx219.dtbo
imx8mm-venice-gw72xx-0x-rpidsi-dtbs :=3D imx8mm-venice-gw72xx-0x.dtb
imx8mm-venice-gw72xx-0x-rpidsi.dtbo




configurations {
      imx8mm-venice-gw72xx-0x-imx219 {
            ...
      };

      imx8mm-venice-gw72xx-0x-rpidsi {
            ...
      }
};



Then, we can distinguish them by node, even if they have
the same compatible string.
At least we can do

  > bootm  ${loadaddr}#imx8mm-venice-gw72xx-0x-imx219




For the issue including stale DTBs, you can use my patch:
[PATCH 1/4] kbuild: create a list of all built DTB files
(https://lore.kernel.org/linux-kbuild/CAK7LNASOxi-gzve+_d-sCW9z_eEJ5TMMnzPE=
vN2Nj2AwgVjF9g@mail.gmail.com/T/#ma3595627a96a04554a78cbbd22056831e13db260)


You can change scripts/make_fit.py to take
the DTB files instead of the directory to search.

Optionally, you can support '@' syntax to
take command arguments from a file.


scripts/make_fit.py ... @arch/$(SRCARCH)/boot/dts/dtbs-list






For the separate base and overlays support,
you can use my patch as a base:
[PATCH 3/4] kbuild: create a list of base and overlays for each DTB
(https://lore.kernel.org/linux-kbuild/CAK7LNASOxi-gzve+_d-sCW9z_eEJ5TMMnzPE=
vN2Nj2AwgVjF9g@mail.gmail.com/T/#m32c5bdde9098901b7c7776b932827493a05c82d5)





Lastly, you do not need to require mkimage for
args.external.
You can simply concatenate files.







--
Best Regards
Masahiro Yamada

