Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D167E10D0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 20:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjKDTmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 15:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjKDTmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 15:42:36 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4E6D47
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 12:42:32 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7a67b9cd230so115988739f.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 12:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699126952; x=1699731752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SJMC+YwLpaY0RKexevOXF6QTYL/zFjGR4wGfi7HoDk=;
        b=MXkFv9I4roJVRp8LJsrD+OU3Nt7GeVls5oASqZiyEjYzOwjdhICev2d/TMlYnCgtRr
         aGewM58zfkfUbHxn/MnwQtHrOJ8z5dJ5Xsmkx3hrEyZ/mmgviemiGDvJkssDQo+P30C/
         AnxGYpDuwHtZfntVlJnSRvpVEfte1+37CE2VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699126952; x=1699731752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SJMC+YwLpaY0RKexevOXF6QTYL/zFjGR4wGfi7HoDk=;
        b=b9SydrI9WyeQj7BEh0rM027LfEbopzKHTWfIt4MLykfZgIGfaS9MVaMCGRlQhVGaKQ
         pLCMsGofLVcup/KLDvIkVS/BSlPaiCmUU/66G++E6PnI6BQaCQqRROn7MLGrwVZ1gL6f
         3zX4ZT7fe5oNxzNmcUjMp3VMEJEO0CSvu5m9lkgjJUsgevrWijg49SVXGZLY2K68UmRu
         upZrAv8wQpe2Z+8Zxi9iKrqB0vHXqLVcgTMhwZ5+Bd7+p2FN5NIi3o7wqEdIg3TxCBWo
         DiADrO4BJSLLqWG5e3CUhZPoPgdib9WtWoow0hFhTfUBzaYbEvquDAIW7yU/YkoI2R4N
         rcqg==
X-Gm-Message-State: AOJu0YwFrL6z3KHxbmEqXOjOmEQUT03zw93kJhb1qlYD63ETc3MVrh11
        8tNQbwRHm9opdwA+78h5jZ49Sq7yvIr4Zp9VQr/HmA==
X-Google-Smtp-Source: AGHT+IFvhOl12gzXmP7jrxrOQ8u539ZMMxe6yhfQ/4pr2w4Tzr3NGD/QoZx0IRW86EzECxxPyKGG1w==
X-Received: by 2002:a6b:1414:0:b0:7ac:cb6b:616c with SMTP id 20-20020a6b1414000000b007accb6b616cmr13764740iou.17.1699126952043;
        Sat, 04 Nov 2023 12:42:32 -0700 (PDT)
Received: from sjg1.united_club.lax.united.com (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id o4-20020a6b5a04000000b0079fbb834232sm1293318iob.19.2023.11.04.12.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 12:42:31 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Simon Glass <sjg@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: boot: Support Flat Image Tree
Date:   Sat,  4 Nov 2023 13:42:04 -0600
Message-ID: <20231104194207.3370542-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231104194207.3370542-1-sjg@chromium.org>
References: <20231104194207.3370542-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a script which produces a Flat Image Tree (FIT), a single file
containing the built kernel and associated devicetree files.
Compression defaults to gzip which gives a good balance of size and
performance.

The files compress from about 86MB to 24MB using this approach.

The FIT can be used by bootloaders which support it, such as U-Boot
and Linuxboot. It permits automatic selection of the correct
devicetree, matching the compatible string of the running board with
the closest compatible string in the FIT. There is no need for
filenames or other workarounds.

Add a 'make image.fit' build target for arm64, as well.

The FIT can be examined using 'dumpimage -l'.

This features requires pylibfdt (use 'pip install libfdt'). It also
requires compression utilities for the algorithm being used. Supported
compression options are the same as the Image.xxx files. For now there
is no way to change the compression other than by editing the rule for
$(obj)/image.fit

While FIT supports a ramdisk / initrd, no attempt is made to support
this here, since it must be built separately from the Linux build.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Drop patch previously applied
- Add .gitignore file
- Move fit rule to Makefile.lib using an intermediate file
- Drop dependency on CONFIG_EFI_ZBOOT
- Pick up .dtb files separately from the kernel
- Correct pylint to-many-args warning for write_kernel()
- Include the kernel image in the file count
- Add a pointer to the FIT spec and mention of its wide industry usage
- Mention the kernel version in the FIT description

 MAINTAINERS                |   7 +
 arch/arm64/Makefile        |   3 +-
 arch/arm64/boot/.gitignore |   2 +
 arch/arm64/boot/Makefile   |   9 +-
 scripts/Makefile.lib       |  18 ++-
 scripts/make_fit.py        | 288 +++++++++++++++++++++++++++++++++++++
 6 files changed, 324 insertions(+), 3 deletions(-)
 create mode 100755 scripts/make_fit.py

diff --git a/MAINTAINERS b/MAINTAINERS
index b98b87d8e424..bcbececf4b43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1577,6 +1577,13 @@ F:	Documentation/process/maintainer-soc*.rst
 F:	arch/arm/boot/dts/Makefile
 F:	arch/arm64/boot/dts/Makefile
 
+ARM64 FIT SUPPORT
+M:	Simon Glass <sjg@chromium.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm64/boot/Makefile
+F:	scripts/make_fit.py
+
 ARM ARCHITECTED TIMER DRIVER
 M:	Mark Rutland <mark.rutland@arm.com>
 M:	Marc Zyngier <maz@kernel.org>
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 7b77b63e978f..d8290dcab6b6 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -150,7 +150,7 @@ libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 # Default target when executing plain make
 boot		:= arch/arm64/boot
 
-BOOT_TARGETS	:= Image.gz vmlinuz.efi
+BOOT_TARGETS	:= Image.gz vmlinuz.efi image.fit
 
 PHONY += $(BOOT_TARGETS)
 
@@ -215,6 +215,7 @@ virtconfig:
 define archhelp
   echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Image.gz)'
   echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
+$(if $(CONFIG_EFI_ZBOOT),,echo  '  image.fit     - Flat Image Tree (arch/$(ARCH)/boot/image.fit)')
   echo  '  install       - Install uncompressed kernel'
   echo  '  zinstall      - Install compressed kernel'
   echo  '                  Install using (your) ~/bin/installkernel or'
diff --git a/arch/arm64/boot/.gitignore b/arch/arm64/boot/.gitignore
index af5dc61f8b43..f84a7073dbcd 100644
--- a/arch/arm64/boot/.gitignore
+++ b/arch/arm64/boot/.gitignore
@@ -2,3 +2,5 @@
 Image
 Image.gz
 vmlinuz*
+image.itk
+image.fit
diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index 1761f5972443..2681f54cd2c8 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -16,7 +16,8 @@
 
 OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 
-targets := Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo Image.zst
+targets := Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo \
+	Image.zst image.fit
 
 $(obj)/Image: vmlinux FORCE
 	$(call if_changed,objcopy)
@@ -39,6 +40,10 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
 $(obj)/Image.zst: $(obj)/Image FORCE
 	$(call if_changed,zstd)
 
+# Provide the kernel for the FIT
+$(obj)/image.itk: $(obj)/Image FORCE
+	$(call if_changed,copy)
+
 EFI_ZBOOT_PAYLOAD	:= Image
 EFI_ZBOOT_BFD_TARGET	:= elf64-littleaarch64
 EFI_ZBOOT_MACH_TYPE	:= ARM64
@@ -48,3 +53,5 @@ EFI_ZBOOT_OBJCOPY_FLAGS	= --add-symbol zboot_code_size=0x$(shell \
 				$(NM) vmlinux|grep _kernel_codesize|cut -d' ' -f1)
 
 include $(srctree)/drivers/firmware/efi/libstub/Makefile.zboot
+
+clean-files := image.itk
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 03e79e319293..1427dba4f0f9 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -494,7 +494,23 @@ quiet_cmd_uimage = UIMAGE  $@
 			-C $(UIMAGE_COMPRESSION) $(UIMAGE_OPTS-y) \
 			-T $(UIMAGE_TYPE) \
 			-a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR) \
-			-n $(UIMAGE_NAME) -d $< $@
+			-n "$(UIMAGE_NAME)" -d $< $@
+
+# Flat Image Tree (FIT)
+# This allows for packaging of a kernel and all devicetrees files, using
+# compression.
+# ---------------------------------------------------------------------------
+
+MAKE_FIT := $(srctree)/scripts/make_fit.py
+
+quiet_cmd_fit = FIT     $@
+      cmd_fit = $(MAKE_FIT) -f $@ --arch $(UIMAGE_ARCH) --os linux \
+			--name "$(UIMAGE_NAME)" \
+			--compress $(UIMAGE_COMPRESSION) -k $< \
+			$(dir $<)/dts
+
+$(obj)/%.fit: $(obj)/%.itk $(MAKE_FIT) FORCE
+	$(call if_changed,fit,gzip)
 
 # XZ
 # ---------------------------------------------------------------------------
diff --git a/scripts/make_fit.py b/scripts/make_fit.py
new file mode 100755
index 000000000000..ee33fb54c6d4
--- /dev/null
+++ b/scripts/make_fit.py
@@ -0,0 +1,288 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2023 Google LLC
+# Written by Simon Glass <sjg@chromium.org>
+#
+
+"""Build a FIT containing a lot of devicetree files
+
+Usage:
+    make_fit.py -A arm64 -n 'Linux-6.6' -O linux
+        -f arch/arm64/boot/image.fit -k /tmp/kern/arch/arm64/boot/image.itk
+        /tmp/kern/arch/arm64/boot/dts/ -E -c gzip
+
+Creates a FIT containing the supplied kernel and a directory containing the
+devicetree files.
+
+Use -E to generate an external FIT (where the data is placed after the
+FIT data structure). This allows parsing of the data without loading
+the entire FIT.
+
+Use -c to compress the data, using bzip2, gzip, lz4, lzma, lzo and
+zstd
+
+The resulting FIT can be booted by bootloaders which support FIT, such
+as U-Boot, Linuxboot, Tianocore, etc.
+
+Note that this tool does not yet support adding a ramdisk / initrd.
+"""
+
+import argparse
+import collections
+import os
+import subprocess
+import sys
+import tempfile
+import time
+
+import libfdt
+
+
+# Tool extension and the name of the command-line tools
+CompTool = collections.namedtuple('CompTool', 'ext,tools')
+
+COMP_TOOLS = {
+    'bzip2': CompTool('.bz2', 'bzip2'),
+    'gzip': CompTool('.gz', 'pigz,gzip'),
+    'lz4': CompTool('.lz4', 'lz4'),
+    'lzma': CompTool('.lzma', 'lzma'),
+    'lzo': CompTool('.lzo', 'lzop'),
+    'zstd': CompTool('.zstd', 'zstd'),
+}
+
+def parse_args():
+    """Parse the program ArgumentParser
+
+    Returns:
+        Namespace object containing the arguments
+    """
+    epilog = 'Build a FIT from a directory tree containing .dtb files'
+    parser = argparse.ArgumentParser(epilog=epilog)
+    parser.add_argument('-A', '--arch', type=str, required=True,
+          help='Specifies the architecture')
+    parser.add_argument('-c', '--compress', type=str, default='none',
+          help='Specifies the compression')
+    parser.add_argument('-E', '--external', action='store_true',
+          help='Convert the FIT to use external data')
+    parser.add_argument('-n', '--name', type=str, required=True,
+          help='Specifies the name')
+    parser.add_argument('-O', '--os', type=str, required=True,
+          help='Specifies the operating system')
+    parser.add_argument('-f', '--fit', type=str, required=True,
+          help='Specifies the output file (.fit)')
+    parser.add_argument('-k', '--kernel', type=str, required=True,
+          help='Specifies the (uncompressed) kernel input file (.itk)')
+    parser.add_argument('srcdir', type=str, nargs='*',
+          help='Specifies the directory tree that contains .dtb files')
+
+    return parser.parse_args()
+
+def setup_fit(fsw, name):
+    """Make a start on writing the FIT
+
+    Outputs the root properties and the 'images' node
+
+    Args:
+        fsw (libfdt.FdtSw): Object to use for writing
+        name (str): Name of kernel image
+    """
+    fsw.INC_SIZE = 65536
+    fsw.finish_reservemap()
+    fsw.begin_node('')
+    fsw.property_string('description', f'{name} with devicetree set')
+    fsw.property_u32('#address-cells', 1)
+
+    fsw.property_u32('timestamp', int(time.time()))
+    fsw.begin_node('images')
+
+
+def write_kernel(fsw, data, args):
+    """Write out the kernel image
+
+    Writes a kernel node along with the required properties
+
+    Args:
+        fsw (libfdt.FdtSw): Object to use for writing
+        data (bytes): Data to write (possibly compressed)
+        args (Namespace): Contains necessary strings:
+            arch: FIT architecture, e.g. 'arm64'
+            fit_os: Operating Systems, e.g. 'linux'
+            name: Name of OS, e.g. 'Linux-6.6.0-rc7'
+            compress: Compression algorithm to use, e.g. 'gzip'
+    """
+    with fsw.add_node('kernel'):
+        fsw.property_string('description', args.name)
+        fsw.property_string('type', 'kernel_noload')
+        fsw.property_string('arch', args.arch)
+        fsw.property_string('os', args.os)
+        fsw.property_string('compression', args.compress)
+        fsw.property('data', data)
+        fsw.property_u32('load', 0)
+        fsw.property_u32('entry', 0)
+
+
+def finish_fit(fsw, entries):
+    """Finish the FIT ready for use
+
+    Writes the /configurations node and subnodes
+
+    Args:
+        fsw (libfdt.FdtSw): Object to use for writing
+        entries (list of tuple): List of configurations:
+            str: Description of model
+            str: Compatible stringlist
+    """
+    fsw.end_node()
+    seq = 0
+    with fsw.add_node('configurations'):
+        for model, compat in entries:
+            seq += 1
+            with fsw.add_node(f'conf-{seq}'):
+                fsw.property('compatible', bytes(compat))
+                fsw.property_string('description', model)
+                fsw.property_string('fdt', f'fdt-{seq}')
+                fsw.property_string('kernel', 'kernel')
+    fsw.end_node()
+
+
+def compress_data(inf, compress):
+    """Compress data using a selected algorithm
+
+    Args:
+        inf (IOBase): Filename containing the data to compress
+        compress (str): Compression algorithm, e.g. 'gzip'
+
+    Return:
+        bytes: Compressed data
+    """
+    if compress == 'none':
+        return inf.read()
+
+    comp = COMP_TOOLS.get(compress)
+    if not comp:
+        raise ValueError(f"Unknown compression algorithm '{compress}'")
+
+    with tempfile.NamedTemporaryFile() as comp_fname:
+        with open(comp_fname.name, 'wb') as outf:
+            done = False
+            for tool in comp.tools.split(','):
+                try:
+                    subprocess.call([tool, '-c'], stdin=inf, stdout=outf)
+                    done = True
+                    break
+                except FileNotFoundError:
+                    pass
+            if not done:
+                raise ValueError(f'Missing tool(s): {comp.tools}\n')
+            with open(comp_fname.name, 'rb') as compf:
+                comp_data = compf.read()
+    return comp_data
+
+
+def output_dtb(fsw, seq, fname, compress):
+    """Write out a single devicetree to the FIT
+
+    Args:
+        fsw (libfdt.FdtSw): Object to use for writing
+        seq (int): Sequence number (1 for first)
+        fmame (str): Filename containing the DTB
+        compress (str): Compressed algorithm, e.g. 'gzip'
+
+    Returns:
+        tuple:
+            str: Model name
+            bytes: Compatible stringlist
+    """
+    with fsw.add_node(f'fdt-{seq}'):
+        # Get the compatible / model information
+        with open(fname, 'rb') as inf:
+            data = inf.read()
+        fdt = libfdt.FdtRo(data)
+        model = fdt.getprop(0, 'model').as_str()
+        compat = fdt.getprop(0, 'compatible')
+
+        fsw.property_string('description', model)
+        fsw.property_string('type', 'flat_dt')
+        fsw.property_string('arch', 'arm64')
+        fsw.property_string('compression', compress)
+        fsw.property('compatible', bytes(compat))
+
+        with open(fname, 'rb') as inf:
+            compressed = compress_data(inf, compress)
+        fsw.property('data', compressed)
+    return model, compat
+
+
+def build_fit(args):
+    """Build the FIT from the provided files and arguments
+
+    Args:
+        args (Namespace): Program arguments
+
+    Returns:
+        tuple:
+            bytes: FIT data
+            int: Number of configurations generated
+            size: Total uncompressed size of data
+    """
+    fsw = libfdt.FdtSw()
+    setup_fit(fsw, args.name)
+    seq = 0
+    size = 0
+    entries = []
+
+    # Handle the kernel
+    with open(args.kernel, 'rb') as inf:
+        comp_data = compress_data(inf, args.compress)
+    size += os.path.getsize(args.kernel)
+    write_kernel(fsw, comp_data, args)
+
+    for path in args.srcdir:
+        # Handle devicetree files
+        if os.path.isdir(path):
+            for dirpath, _, fnames in os.walk(path):
+                for fname in fnames:
+                    if os.path.splitext(fname)[1] != '.dtb':
+                        continue
+                    pathname = os.path.join(dirpath, fname)
+                    seq += 1
+                    size += os.path.getsize(pathname)
+                    model, compat = output_dtb(fsw, seq, pathname,
+                                               args.compress)
+                    entries.append([model, compat])
+
+    finish_fit(fsw, entries)
+
+    # Include the kernel itself in the returned file count
+    return fsw.as_fdt().as_bytearray(), seq + 1, size
+
+
+def run_make_fit():
+    """Run the tool's main logic"""
+    args = parse_args()
+
+    out_data, count, size = build_fit(args)
+    with open(args.fit, 'wb') as outf:
+        outf.write(out_data)
+
+    ext_fit_size = None
+    if args.external:
+        mkimage = os.environ.get('MKIMAGE', 'mkimage')
+        subprocess.check_call([mkimage, '-E', '-F', args.fit],
+                              stdout=subprocess.DEVNULL)
+
+        with open(args.fit, 'rb') as inf:
+            data = inf.read()
+        ext_fit = libfdt.FdtRo(data)
+        ext_fit_size = ext_fit.totalsize()
+
+    comp_size = len(out_data)
+    print(f'FIT size {comp_size:#x}/{comp_size / 1024 / 1024:.1f} MB', end='')
+    if ext_fit_size:
+        print(f', header {ext_fit_size:#x}/{ext_fit_size / 1024:.1f} KB', end='')
+    print(f', {count} files, uncompressed {size / 1024 / 1024:.1f} MB')
+
+
+if __name__ == "__main__":
+    sys.exit(run_make_fit())
-- 
2.42.0.869.gea05f2083d-goog

