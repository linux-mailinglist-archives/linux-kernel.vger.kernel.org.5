Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8119080A28F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjLHLtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjLHLtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:49:07 -0500
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA1B1720
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:49:11 -0800 (PST)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Fri,  8 Dec 2023 12:49:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1702036145; bh=QDC9oYWjuB6KTXuwmqSB7KkvaGCSQjZklY+CC/P09ZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9yr/H7/CahZ42LQCEETisU6lfczk6yLfclbVeAPn8B2H9gtvFy90r3FT/MdHLT0w
         BBds7RMca1Ov7rstbSUHsE3wOKyj7MEeOLpVuzdiUP5qH4DHp7JhALT8O0hkKKnEFG
         8adrYaE+sOSkm+/8bfQ7mByK1UaxjZhopXmHTk/k=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id 6609A806A5;
        Fri,  8 Dec 2023 12:49:05 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 5F44318165F; Fri,  8 Dec 2023 12:49:05 +0100 (CET)
Date:   Fri, 8 Dec 2023 12:49:05 +0100
From:   Nicolas Schier <n.schier@avm.de>
To:     Simon Glass <sjg@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Will Deacon <will@kernel.org>,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
Message-ID: <ZXMCsRgYbXXMTyHA@buildd.core.avm.de>
Mail-Followup-To: Simon Glass <sjg@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Will Deacon <will@kernel.org>,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, workflows@vger.kernel.org
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FxqKBDP88WqRN8br"
Content-Disposition: inline
In-Reply-To: <20231202035511.487946-3-sjg@chromium.org>
X-purgate-ID: 149429::1702036145-26DE19E9-C0D45053/0/0
X-purgate-type: clean
X-purgate-size: 21705
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLACK autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FxqKBDP88WqRN8br
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 8 Dec 2023 12:49:05 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Simon Glass <sjg@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	U-Boot Mailing List <u-boot@lists.denx.de>,
	Tom Rini <trini@konsulko.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Terrell <terrelln@fb.com>, Will Deacon <will@kernel.org>,
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree

On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
> Add a script which produces a Flat Image Tree (FIT), a single file
> containing the built kernel and associated devicetree files.
> Compression defaults to gzip which gives a good balance of size and
> performance.
>=20
> The files compress from about 86MB to 24MB using this approach.
>=20
> The FIT can be used by bootloaders which support it, such as U-Boot
> and Linuxboot. It permits automatic selection of the correct
> devicetree, matching the compatible string of the running board with
> the closest compatible string in the FIT. There is no need for
> filenames or other workarounds.
>=20
> Add a 'make image.fit' build target for arm64, as well. Use
> FIT_COMPRESSION to select a different algorithm.
>=20
> The FIT can be examined using 'dumpimage -l'.
>=20
> This features requires pylibfdt (use 'pip install libfdt'). It also
> requires compression utilities for the algorithm being used. Supported
> compression options are the same as the Image.xxx files. For now there
> is no way to change the compression other than by editing the rule for
> $(obj)/image.fit
>=20
> While FIT supports a ramdisk / initrd, no attempt is made to support
> this here, since it must be built separately from the Linux build.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---

for the kbuild parts:

Reviewed-by: Nicolas Schier <n.schier@avm.de>



> Changes in v9:
> - Move the compression control into Makefile.lib
>=20
> Changes in v8:
> - Drop compatible string in FDT node
> - Correct sorting of MAINTAINERS to before ARM64 PORT
> - Turn compress part of the make_fit.py comment in to a sentence
> - Add two blank lines before parse_args() and setup_fit()
> - Use 'image.fit: dtbs' instead of BUILD_DTBS var
> - Use '$(<D)/dts' instead of '$(dir $<)dts'
> - Add 'mkimage' details Documentation/process/changes.rst
> - Allow changing the compression used
> - Tweak cover letter since there is only one clean-up patch
>=20
> Changes in v7:
> - Add Image as a dependency of image.fit
> - Drop kbuild tag
> - Add dependency on dtbs
> - Drop unnecessary path separator for dtbs
> - Rebase to -next
>=20
> Changes in v5:
> - Drop patch previously applied
> - Correct compression rule which was broken in v4
>=20
> Changes in v4:
> - Use single quotes for UIMAGE_NAME
>=20
> Changes in v3:
> - Drop temporary file image.itk
> - Drop patch 'Use double quotes for image name'
> - Drop double quotes in use of UIMAGE_NAME
> - Drop unnecessary CONFIG_EFI_ZBOOT condition for help
> - Avoid hard-coding "arm64" for the DT architecture
>=20
> Changes in v2:
> - Drop patch previously applied
> - Add .gitignore file
> - Move fit rule to Makefile.lib using an intermediate file
> - Drop dependency on CONFIG_EFI_ZBOOT
> - Pick up .dtb files separately from the kernel
> - Correct pylint too-many-args warning for write_kernel()
> - Include the kernel image in the file count
> - Add a pointer to the FIT spec and mention of its wide industry usage
> - Mention the kernel version in the FIT description
>=20
>  Documentation/process/changes.rst |   9 +
>  MAINTAINERS                       |   7 +
>  arch/arm64/Makefile               |   7 +-
>  arch/arm64/boot/.gitignore        |   1 +
>  arch/arm64/boot/Makefile          |   6 +-
>  scripts/Makefile.lib              |  16 ++
>  scripts/make_fit.py               | 291 ++++++++++++++++++++++++++++++
>  7 files changed, 334 insertions(+), 3 deletions(-)
>  create mode 100755 scripts/make_fit.py
>=20
> diff --git a/Documentation/process/changes.rst b/Documentation/process/ch=
anges.rst
> index bb96ca0f774b..cad51bd5bd62 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -62,6 +62,7 @@ Sphinx\ [#f1]_         1.7              sphinx-build --=
version
>  cpio                   any              cpio --version
>  GNU tar                1.28             tar --version
>  gtags (optional)       6.6.5            gtags --version
> +mkimage (optional)     2017.01          mkimage --version
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> =20
>  .. [#f1] Sphinx is needed only to build the Kernel documentation
> @@ -189,6 +190,14 @@ The kernel build requires GNU GLOBAL version 6.6.5 o=
r later to generate
>  tag files through ``make gtags``.  This is due to its use of the gtags
>  ``-C (--directory)`` flag.
> =20
> +mkimage
> +-------
> +
> +This tool is used when building a Flat Image Tree (FIT), commonly used o=
n ARM
> +platforms. The tool is available via the ``u-boot-tools`` package or can=
 be
> +built from the U-Boot source code. See the instructions at
> +https://docs.u-boot.org/en/latest/build/tools.html#building-tools-for-li=
nux
> +
>  System utilities
>  ****************
> =20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d46229fe21b..d2d17f0d6e64 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3037,6 +3037,13 @@ F:	drivers/mmc/host/sdhci-of-arasan.c
>  N:	zynq
>  N:	xilinx
> =20
> +ARM64 FIT SUPPORT
> +M:	Simon Glass <sjg@chromium.org>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	arch/arm64/boot/Makefile
> +F:	scripts/make_fit.py
> +
>  ARM64 PORT (AARCH64 ARCHITECTURE)
>  M:	Catalin Marinas <catalin.marinas@arm.com>
>  M:	Will Deacon <will@kernel.org>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 1bd4fae6e806..6b893dc454b7 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -150,7 +150,7 @@ libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmw=
are/efi/libstub/lib.a
>  # Default target when executing plain make
>  boot		:=3D arch/arm64/boot
> =20
> -BOOT_TARGETS	:=3D Image vmlinuz.efi
> +BOOT_TARGETS	:=3D Image vmlinuz.efi image.fit
> =20
>  PHONY +=3D $(BOOT_TARGETS)
> =20
> @@ -162,7 +162,9 @@ endif
> =20
>  all:	$(notdir $(KBUILD_IMAGE))
> =20
> -vmlinuz.efi: Image
> +image.fit: dtbs
> +
> +vmlinuz.efi image.fit: Image
>  $(BOOT_TARGETS): vmlinux
>  	$(Q)$(MAKE) $(build)=3D$(boot) $(boot)/$@
> =20
> @@ -215,6 +217,7 @@ virtconfig:
>  define archhelp
>    echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Im=
age.gz)'
>    echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/=
Image)'
> +  echo  '  image.fit     - Flat Image Tree (arch/$(ARCH)/boot/image.fit)'
>    echo  '  install       - Install uncompressed kernel'
>    echo  '  zinstall      - Install compressed kernel'
>    echo  '                  Install using (your) ~/bin/installkernel or'
> diff --git a/arch/arm64/boot/.gitignore b/arch/arm64/boot/.gitignore
> index af5dc61f8b43..abaae9de1bdd 100644
> --- a/arch/arm64/boot/.gitignore
> +++ b/arch/arm64/boot/.gitignore
> @@ -2,3 +2,4 @@
>  Image
>  Image.gz
>  vmlinuz*
> +image.fit
> diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
> index 1761f5972443..b835c0880d1c 100644
> --- a/arch/arm64/boot/Makefile
> +++ b/arch/arm64/boot/Makefile
> @@ -16,7 +16,8 @@
> =20
>  OBJCOPYFLAGS_Image :=3D-O binary -R .note -R .note.gnu.build-id -R .comm=
ent -S
> =20
> -targets :=3D Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo Ima=
ge.zst
> +targets :=3D Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo \
> +	Image.zst image.fit
> =20
>  $(obj)/Image: vmlinux FORCE
>  	$(call if_changed,objcopy)
> @@ -39,6 +40,9 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
>  $(obj)/Image.zst: $(obj)/Image FORCE
>  	$(call if_changed,zstd)
> =20
> +$(obj)/image.fit: $(obj)/Image FORCE
> +	$(call cmd,fit)
> +
>  EFI_ZBOOT_PAYLOAD	:=3D Image
>  EFI_ZBOOT_BFD_TARGET	:=3D elf64-littleaarch64
>  EFI_ZBOOT_MACH_TYPE	:=3D ARM64
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 1a965fe68e01..1c60d594932c 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -496,6 +496,22 @@ quiet_cmd_uimage =3D UIMAGE  $@
>  			-a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR) \
>  			-n '$(UIMAGE_NAME)' -d $< $@
> =20
> +# Flat Image Tree (FIT)
> +# This allows for packaging of a kernel and all devicetrees files, using
> +# compression.
> +# ----------------------------------------------------------------------=
-----
> +
> +MAKE_FIT :=3D $(srctree)/scripts/make_fit.py
> +
> +# Use this to override the compression algorithm
> +FIT_COMPRESSION ?=3D gzip
> +
> +quiet_cmd_fit =3D FIT     $@
> +      cmd_fit =3D $(MAKE_FIT) -f $@ --arch $(UIMAGE_ARCH) --os linux \
> +			--name '$(UIMAGE_NAME)' \
> +			--compress $(FIT_COMPRESSION) -k $< \
> +			$(<D)/dts
> +
>  # XZ
>  # ----------------------------------------------------------------------=
-----
>  # Use xzkern to compress the kernel image and xzmisc to compress other t=
hings.
> diff --git a/scripts/make_fit.py b/scripts/make_fit.py
> new file mode 100755
> index 000000000000..e616b0d7a84a
> --- /dev/null
> +++ b/scripts/make_fit.py
> @@ -0,0 +1,291 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright 2023 Google LLC
> +# Written by Simon Glass <sjg@chromium.org>
> +#
> +
> +"""Build a FIT containing a lot of devicetree files
> +
> +Usage:
> +    make_fit.py -A arm64 -n 'Linux-6.6' -O linux
> +        -f arch/arm64/boot/image.fit -k /tmp/kern/arch/arm64/boot/image.=
itk
> +        /tmp/kern/arch/arm64/boot/dts/ -E -c gzip
> +
> +Creates a FIT containing the supplied kernel and a directory containing =
the
> +devicetree files.
> +
> +Use -E to generate an external FIT (where the data is placed after the
> +FIT data structure). This allows parsing of the data without loading
> +the entire FIT.
> +
> +Use -c to compress the data, using bzip2, gzip, lz4, lzma, lzo and
> +zstd algorithms.
> +
> +The resulting FIT can be booted by bootloaders which support FIT, such
> +as U-Boot, Linuxboot, Tianocore, etc.
> +
> +Note that this tool does not yet support adding a ramdisk / initrd.
> +"""
> +
> +import argparse
> +import collections
> +import os
> +import subprocess
> +import sys
> +import tempfile
> +import time
> +
> +import libfdt
> +
> +
> +# Tool extension and the name of the command-line tools
> +CompTool =3D collections.namedtuple('CompTool', 'ext,tools')
> +
> +COMP_TOOLS =3D {
> +    'bzip2': CompTool('.bz2', 'bzip2'),
> +    'gzip': CompTool('.gz', 'pigz,gzip'),
> +    'lz4': CompTool('.lz4', 'lz4'),
> +    'lzma': CompTool('.lzma', 'lzma'),
> +    'lzo': CompTool('.lzo', 'lzop'),
> +    'zstd': CompTool('.zstd', 'zstd'),
> +}
> +
> +
> +def parse_args():
> +    """Parse the program ArgumentParser
> +
> +    Returns:
> +        Namespace object containing the arguments
> +    """
> +    epilog =3D 'Build a FIT from a directory tree containing .dtb files'
> +    parser =3D argparse.ArgumentParser(epilog=3Depilog)
> +    parser.add_argument('-A', '--arch', type=3Dstr, required=3DTrue,
> +          help=3D'Specifies the architecture')
> +    parser.add_argument('-c', '--compress', type=3Dstr, default=3D'none',
> +          help=3D'Specifies the compression')
> +    parser.add_argument('-E', '--external', action=3D'store_true',
> +          help=3D'Convert the FIT to use external data')
> +    parser.add_argument('-n', '--name', type=3Dstr, required=3DTrue,
> +          help=3D'Specifies the name')
> +    parser.add_argument('-O', '--os', type=3Dstr, required=3DTrue,
> +          help=3D'Specifies the operating system')
> +    parser.add_argument('-f', '--fit', type=3Dstr, required=3DTrue,
> +          help=3D'Specifies the output file (.fit)')
> +    parser.add_argument('-k', '--kernel', type=3Dstr, required=3DTrue,
> +          help=3D'Specifies the (uncompressed) kernel input file (.itk)')
> +    parser.add_argument('srcdir', type=3Dstr, nargs=3D'*',
> +          help=3D'Specifies the directory tree that contains .dtb files')
> +
> +    return parser.parse_args()
> +
> +
> +def setup_fit(fsw, name):
> +    """Make a start on writing the FIT
> +
> +    Outputs the root properties and the 'images' node
> +
> +    Args:
> +        fsw (libfdt.FdtSw): Object to use for writing
> +        name (str): Name of kernel image
> +    """
> +    fsw.INC_SIZE =3D 65536
> +    fsw.finish_reservemap()
> +    fsw.begin_node('')
> +    fsw.property_string('description', f'{name} with devicetree set')
> +    fsw.property_u32('#address-cells', 1)
> +
> +    fsw.property_u32('timestamp', int(time.time()))
> +    fsw.begin_node('images')
> +
> +
> +def write_kernel(fsw, data, args):
> +    """Write out the kernel image
> +
> +    Writes a kernel node along with the required properties
> +
> +    Args:
> +        fsw (libfdt.FdtSw): Object to use for writing
> +        data (bytes): Data to write (possibly compressed)
> +        args (Namespace): Contains necessary strings:
> +            arch: FIT architecture, e.g. 'arm64'
> +            fit_os: Operating Systems, e.g. 'linux'
> +            name: Name of OS, e.g. 'Linux-6.6.0-rc7'
> +            compress: Compression algorithm to use, e.g. 'gzip'
> +    """
> +    with fsw.add_node('kernel'):
> +        fsw.property_string('description', args.name)
> +        fsw.property_string('type', 'kernel_noload')
> +        fsw.property_string('arch', args.arch)
> +        fsw.property_string('os', args.os)
> +        fsw.property_string('compression', args.compress)
> +        fsw.property('data', data)
> +        fsw.property_u32('load', 0)
> +        fsw.property_u32('entry', 0)
> +
> +
> +def finish_fit(fsw, entries):
> +    """Finish the FIT ready for use
> +
> +    Writes the /configurations node and subnodes
> +
> +    Args:
> +        fsw (libfdt.FdtSw): Object to use for writing
> +        entries (list of tuple): List of configurations:
> +            str: Description of model
> +            str: Compatible stringlist
> +    """
> +    fsw.end_node()
> +    seq =3D 0
> +    with fsw.add_node('configurations'):
> +        for model, compat in entries:
> +            seq +=3D 1
> +            with fsw.add_node(f'conf-{seq}'):
> +                fsw.property('compatible', bytes(compat))
> +                fsw.property_string('description', model)
> +                fsw.property_string('fdt', f'fdt-{seq}')
> +                fsw.property_string('kernel', 'kernel')
> +    fsw.end_node()
> +
> +
> +def compress_data(inf, compress):
> +    """Compress data using a selected algorithm
> +
> +    Args:
> +        inf (IOBase): Filename containing the data to compress
> +        compress (str): Compression algorithm, e.g. 'gzip'
> +
> +    Return:
> +        bytes: Compressed data
> +    """
> +    if compress =3D=3D 'none':
> +        return inf.read()
> +
> +    comp =3D COMP_TOOLS.get(compress)
> +    if not comp:
> +        raise ValueError(f"Unknown compression algorithm '{compress}'")
> +
> +    with tempfile.NamedTemporaryFile() as comp_fname:
> +        with open(comp_fname.name, 'wb') as outf:
> +            done =3D False
> +            for tool in comp.tools.split(','):
> +                try:
> +                    subprocess.call([tool, '-c'], stdin=3Dinf, stdout=3D=
outf)
> +                    done =3D True
> +                    break
> +                except FileNotFoundError:
> +                    pass
> +            if not done:
> +                raise ValueError(f'Missing tool(s): {comp.tools}\n')
> +            with open(comp_fname.name, 'rb') as compf:
> +                comp_data =3D compf.read()
> +    return comp_data
> +
> +
> +def output_dtb(fsw, seq, fname, arch, compress):
> +    """Write out a single devicetree to the FIT
> +
> +    Args:
> +        fsw (libfdt.FdtSw): Object to use for writing
> +        seq (int): Sequence number (1 for first)
> +        fmame (str): Filename containing the DTB
> +        arch: FIT architecture, e.g. 'arm64'
> +        compress (str): Compressed algorithm, e.g. 'gzip'
> +
> +    Returns:
> +        tuple:
> +            str: Model name
> +            bytes: Compatible stringlist
> +    """
> +    with fsw.add_node(f'fdt-{seq}'):
> +        # Get the compatible / model information
> +        with open(fname, 'rb') as inf:
> +            data =3D inf.read()
> +        fdt =3D libfdt.FdtRo(data)
> +        model =3D fdt.getprop(0, 'model').as_str()
> +        compat =3D fdt.getprop(0, 'compatible')
> +
> +        fsw.property_string('description', model)
> +        fsw.property_string('type', 'flat_dt')
> +        fsw.property_string('arch', arch)
> +        fsw.property_string('compression', compress)
> +        fsw.property('compatible', bytes(compat))
> +
> +        with open(fname, 'rb') as inf:
> +            compressed =3D compress_data(inf, compress)
> +        fsw.property('data', compressed)
> +    return model, compat
> +
> +
> +def build_fit(args):
> +    """Build the FIT from the provided files and arguments
> +
> +    Args:
> +        args (Namespace): Program arguments
> +
> +    Returns:
> +        tuple:
> +            bytes: FIT data
> +            int: Number of configurations generated
> +            size: Total uncompressed size of data
> +    """
> +    fsw =3D libfdt.FdtSw()
> +    setup_fit(fsw, args.name)
> +    seq =3D 0
> +    size =3D 0
> +    entries =3D []
> +
> +    # Handle the kernel
> +    with open(args.kernel, 'rb') as inf:
> +        comp_data =3D compress_data(inf, args.compress)
> +    size +=3D os.path.getsize(args.kernel)
> +    write_kernel(fsw, comp_data, args)
> +
> +    for path in args.srcdir:
> +        # Handle devicetree files
> +        if os.path.isdir(path):
> +            for dirpath, _, fnames in os.walk(path):
> +                for fname in fnames:
> +                    if os.path.splitext(fname)[1] !=3D '.dtb':
> +                        continue
> +                    pathname =3D os.path.join(dirpath, fname)
> +                    seq +=3D 1
> +                    size +=3D os.path.getsize(pathname)
> +                    model, compat =3D output_dtb(fsw, seq, pathname,
> +                                               args.arch, args.compress)
> +                    entries.append([model, compat])
> +
> +    finish_fit(fsw, entries)
> +
> +    # Include the kernel itself in the returned file count
> +    return fsw.as_fdt().as_bytearray(), seq + 1, size
> +
> +
> +def run_make_fit():
> +    """Run the tool's main logic"""
> +    args =3D parse_args()
> +
> +    out_data, count, size =3D build_fit(args)
> +    with open(args.fit, 'wb') as outf:
> +        outf.write(out_data)
> +
> +    ext_fit_size =3D None
> +    if args.external:
> +        mkimage =3D os.environ.get('MKIMAGE', 'mkimage')
> +        subprocess.check_call([mkimage, '-E', '-F', args.fit],
> +                              stdout=3Dsubprocess.DEVNULL)
> +
> +        with open(args.fit, 'rb') as inf:
> +            data =3D inf.read()
> +        ext_fit =3D libfdt.FdtRo(data)
> +        ext_fit_size =3D ext_fit.totalsize()
> +
> +    comp_size =3D len(out_data)
> +    print(f'FIT size {comp_size:#x}/{comp_size / 1024 / 1024:.1f} MB', e=
nd=3D'')
> +    if ext_fit_size:
> +        print(f', header {ext_fit_size:#x}/{ext_fit_size / 1024:.1f} KB'=
, end=3D'')
> +    print(f', {count} files, uncompressed {size / 1024 / 1024:.1f} MB')
> +
> +
> +if __name__ =3D=3D "__main__":
> +    sys.exit(run_make_fit())
> --=20
> 2.43.0.rc2.451.g8631bc7472-goog
>=20

--FxqKBDP88WqRN8br
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmVzArEACgkQiMa8nIia
bbgjLBAAnBwud5jQIP9G7Agm4dMf0m6PKEWobyZCoJPugU9vRwie93Fk/sH4HNgb
1v/mYZYaQBug3HLwt8N9tbnHm0yMGmOjefJS0MIBdQfwXD/sIG8jgqMOnO2c1cMs
dv+DUR5+CVzq1LKma0R5y1E/gOyxnqX5FVbKLEj5pkXV9v4Hpm6VxJA00416guKc
A9U7CDzCHboP+QIVPbNa8GslwG9d3mWEU/LAUwcpx18qYadPEzZajizo09uMHIPO
0eZ8uoGMo8EjFspzV1r36i6B47fqwIoWCupCvpCH10qq6eCpl+RGyqH8by/FhiIq
vZYJwyP8C7/FPaRS1cD2vEyV1X0MVkRQ8bAupY2H8UncD2t921yrFmW7AFirXXhN
C54/3/Dqavbttn9YKmULFomiIflmJjPbwIcViQfXvL7jSVIntsEX9ZqR/1KDLZic
xfgN0XHcZ3GDZluBEPreh6LMKzTKrBOYuxp9A31uPbwPSpjHnwAD/bNiVs5IAuE2
j2sQDgRQALa4cgtCAw7oxV5ksT+Jgg26GW7FfMfp8sC/dC3zKcDM7TQWn+Pom80i
UHN7wYNa8G3r6MTOSMgkecA8xUKWJNCedfmyb6UDdhHQK2vcx5pzqY4qOt24qRsk
pXdABOeEsKuwDWSimsP4GDH4G8l/2W3Fffjjl2OO6YzQJga+gJs=
=xzdM
-----END PGP SIGNATURE-----

--FxqKBDP88WqRN8br--
