Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8A57B0B27
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjI0RgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjI0RgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:36:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746B7F5;
        Wed, 27 Sep 2023 10:36:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so10684068a12.1;
        Wed, 27 Sep 2023 10:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695836169; x=1696440969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WQMrQ/I2lg+8HqtQDqL/mC01SHg1joNuwF5PSGwhyjA=;
        b=ZKQHW1MllgLHGvCrXVP719U9m1RD0x6CDfBqQysZF9npHRLpVJUi9asMYJGh0G1zyX
         BGazdkI9bpSZSZJmqcXYZ7JIhhQiT00JlEC4cRAnMUjl52ccVpP3NXp1OhqD5a/IJ398
         f1e+1G8DS10tVxmWN7YNqli5QySGJMluyAHqXTVRoh+bHjxhMwB5dbhdkesHnDDIv+60
         UF0bw/za5tzirfpOsnvCAo0nrwi3gWbTLAupSUshBvUm1bV7plcHjMZEOKgmOCmgWKZa
         tHn/JC6RQ1f+fN53vyuyd/WZ2cajBBV//AKS6mwn01qLMgT+fNampOdeuO6Bb1V7sdGN
         e09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695836169; x=1696440969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQMrQ/I2lg+8HqtQDqL/mC01SHg1joNuwF5PSGwhyjA=;
        b=RG/VjvHqi9T5F0jAc6JKA7wNGrsk4byUN7atJMqBtH5b4QG4Pa+hBWX/IkJ2hvZEbs
         H9TNnTbuo5TFd346Hz2Pz2HkxmefmcEKaCqanisV8y+JRqCAC4Z1Wrsr2JZGYn8EVI7s
         2GkxEu0a8Vo/Q045bmKDO5iF1gVB/+4har+4OfRHBl7J27huDVfNX2cltV6drx5VzhbH
         GzumWkkgqIqAmdwVIusldK5uIkX6r+Nd7SusbdM9t/sL5dsFXNW0/2aLAAF9oZvP/C0D
         j+RakPM/I+hDabxB7NEXqKk76tniwAR16a6ansfDBk+mUGj9dazO+lzrosdBSCVNO3NT
         GdTA==
X-Gm-Message-State: AOJu0Yx7qaOVfhA3C1SBBbswojRRgtB6QsV84Zc3Tol7oR7gaAL0toAB
        On/whb9fHWPc+tTm5uxtnSI=
X-Google-Smtp-Source: AGHT+IEspx+3M8l/uz7ued47HBXwKTl1r7g1ZYg1OTzwaZxo/hzAWBacCyOWJPJZ4YbxAKR1IObkPA==
X-Received: by 2002:aa7:c3c6:0:b0:52b:c8d9:1d66 with SMTP id l6-20020aa7c3c6000000b0052bc8d91d66mr2061608edr.42.1695836168495;
        Wed, 27 Sep 2023 10:36:08 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.googlemail.com with ESMTPSA id dy6-20020a05640231e600b0052718577668sm8414828edb.11.2023.09.27.10.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:36:08 -0700 (PDT)
From:   "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        Kris Van Hees <kris.van.hees@oracle.com>,
        Eugene Loh <eugene.loh@oracle.com>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Viktor Malik <vmalik@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Alessandro Carminati <alessandro.carminati@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5] scripts/link-vmlinux.sh: Add alias to duplicate symbols for kallsyms
Date:   Wed, 27 Sep 2023 17:35:16 +0000
Message-Id: <20230927173516.1456594-1-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not uncommon for drivers or modules related to similar peripherals
to have symbols with the exact same name.
While this is not a problem for the kernel's binary itself, it becomes an
issue when attempting to trace or probe specific functions using
infrastructure like ftrace or kprobe.

The tracing subsystem relies on the `nm -n vmlinux` output, which provides
symbol information from the kernel's ELF binary. However, when multiple
symbols share the same name, the standard nm output does not differentiate
between them. This can lead to confusion and difficulty when trying to
probe the intended symbol.

 ~ # cat /proc/kallsyms | grep " name_show"
 ffffffff8c4f76d0 t name_show
 ffffffff8c9cccb0 t name_show
 ffffffff8cb0ac20 t name_show
 ffffffff8cc728c0 t name_show
 ffffffff8ce0efd0 t name_show
 ffffffff8ce126c0 t name_show
 ffffffff8ce1dd20 t name_show
 ffffffff8ce24e70 t name_show
 ffffffff8d1104c0 t name_show
 ffffffff8d1fe480 t name_show

kas_alias addresses this challenge by enhancing symbol names with
meaningful suffixes generated from the source file and line number
during the kernel build process.
These newly generated aliases provide tracers with the ability to
comprehend the symbols they are interacting with when utilizing the
ftracefs interface.
This approach may also allow for the probing by name of previously
inaccessible symbols.

 ~ # cat /proc/kallsyms | grep gic_mask_irq
 ffffd15671e505ac t gic_mask_irq
 ffffd15671e505ac t gic_mask_irq@drivers_irqchip_irq_gic_c_167
 ffffd15671e532a4 t gic_mask_irq
 ffffd15671e532a4 t gic_mask_irq@drivers_irqchip_irq_gic_v3_c_407
 ~ #

Changes from v1:
- Integrated changes requested by Masami to exclude symbols with prefixes
  "_cfi" and "_pfx".
- Introduced a small framework to handle patterns that need to be excluded
  from the alias production.
- Excluded other symbols using the framework.
- Introduced the ability to discriminate between text and data symbols.
- Added two new config symbols in this version: CONFIG_KALLSYMS_ALIAS_DATA,
  which allows data for data, and CONFIG_KALLSYMS_ALIAS_DATA_ALL, which
  excludes all filters and provides an alias for each duplicated symbol.

https://lore.kernel.org/all/20230711151925.1092080-1-alessandro.carminati@gmail.com/

Changes from v2:
- Alias tags are created by querying DWARF information from the vmlinux.
- The filename + line number is normalized and appended to the original
  name.
- The tag begins with '@' to indicate the symbol source.
- Not a change, but worth mentioning, since the alias is added to the
  existing list, the old duplicated name is preserved, and the livepatch
  way of dealing with duplicates is maintained.
- Acknowledging the existence of scenarios where inlined functions
  declared in header files may result in multiple copies due to compiler
  behavior, though it is not actionable as it does not pose an operational
  issue.
- Highlighting a single exception where the same name refers to different
  functions: the case of "compat_binfmt_elf.c," which directly includes
  "binfmt_elf.c" producing identical function copies in two separate
  modules.

https://lore.kernel.org/all/20230714150326.1152359-1-alessandro.carminati@gmail.com/

Changes from v3:
- kas_alias was rewritten in Python to create a more concise and
  maintainable codebase.
- The previous automation process used by kas_alias to locate the vmlinux
  and the addr2line has been replaced with an explicit command-line switch
  for specifying these requirements.
- addr2line has been added into the main Makefile.
- A new command-line switch has been introduced, enabling users to extend
  the alias to global data names.

https://lore.kernel.org/all/20230828080423.3539686-1-alessandro.carminati@gmail.com/

Changes from v4:
- Fixed the O=<build dir> build issue
- The tool halts execution upon encountering major issues, thereby ensuring
  the pipeline is interrupted.
- A cmdline option to specify the source directory added.
- Minor code adjusments.
- Tested on mips32 and i386

https://lore.kernel.org/all/20230919193948.465340-1-alessandro.carminati@gmail.com/

NOTE:
About the symbols name duplication that happens as consequence of the
inclusion compat_binfmt_elf.c does, it is evident that this corner is
inherently challenging the addr2line approach.
Attempting to conceal this limitation would be counterproductive.

compat_binfmt_elf.c includes directly binfmt_elf.c, addr2line can't help
but report all functions and data declared by that file, coming from
binfmt_elf.c.

My position is that, rather than producing a more complicated pipeline
to handle this corner case, it is better to fix the compat_binfmt_elf.c
anomaly.

This patch does not deal with the two potentially problematic symbols
defined by compat_binfmt_elf.c

Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
---
 Makefile                |   4 +-
 init/Kconfig            |  22 +++++++
 scripts/kas_alias.py    | 136 ++++++++++++++++++++++++++++++++++++++++
 scripts/link-vmlinux.sh |  21 ++++++-
 4 files changed, 180 insertions(+), 3 deletions(-)
 create mode 100755 scripts/kas_alias.py

diff --git a/Makefile b/Makefile
index 4f283d915e54..f33c179f4cc3 100644
--- a/Makefile
+++ b/Makefile
@@ -488,6 +488,7 @@ OBJCOPY		= $(LLVM_PREFIX)llvm-objcopy$(LLVM_SUFFIX)
 OBJDUMP		= $(LLVM_PREFIX)llvm-objdump$(LLVM_SUFFIX)
 READELF		= $(LLVM_PREFIX)llvm-readelf$(LLVM_SUFFIX)
 STRIP		= $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)
+ADDR2LINE	= $(LLVM_PREFIX)llvm-addr2line$(LLVM_SUFFIX)
 else
 CC		= $(CROSS_COMPILE)gcc
 LD		= $(CROSS_COMPILE)ld
@@ -497,6 +498,7 @@ OBJCOPY		= $(CROSS_COMPILE)objcopy
 OBJDUMP		= $(CROSS_COMPILE)objdump
 READELF		= $(CROSS_COMPILE)readelf
 STRIP		= $(CROSS_COMPILE)strip
+ADDR2LINE	= $(CROSS_COMPILE)addr2line
 endif
 RUSTC		= rustc
 RUSTDOC		= rustdoc
@@ -611,7 +613,7 @@ export RUSTC_BOOTSTRAP := 1
 export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC HOSTPKG_CONFIG
 export RUSTC RUSTDOC RUSTFMT RUSTC_OR_CLIPPY_QUIET RUSTC_OR_CLIPPY BINDGEN CARGO
 export HOSTRUSTC KBUILD_HOSTRUSTFLAGS
-export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL
+export CPP AR NM STRIP OBJCOPY OBJDUMP READELF ADDR2LINE PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL
 export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
 export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
 export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
diff --git a/init/Kconfig b/init/Kconfig
index 6d35728b94b2..d45dd423e1ec 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1738,6 +1738,28 @@ config KALLSYMS_BASE_RELATIVE
 	  time constants, and no relocation pass is required at runtime to fix
 	  up the entries based on the runtime load address of the kernel.
 
+config KALLSYMS_ALIAS_SRCLINE
+	bool "Produces alias for duplicated text symbols" if EXPERT
+	depends on KALLSYMS && DEBUG_INFO && !DEBUG_INFO_SPLIT
+	help
+	  It is not uncommon for drivers or modules related to similar
+	  peripherals to have symbols with the exact same name.
+	  While this is not a problem for the kernel's binary itself, it
+	  becomes an issue when attempting to trace or probe specific
+	  functions using infrastructure like ftrace or kprobe.
+
+	  This option addresses this challenge, producing alias for text
+	  symbol names that include the file name and line where the symbols
+	  are defined in the source code.
+
+config KALLSYMS_ALIAS_SRCLINE_DATA
+	bool "Produces alias also for global variables names"
+	depends on KALLSYMS_ALIAS_SRCLINE
+	help
+	  Sometimes it can be useful to refer to global vars by name. Since
+	  they suffer the same issue as text symbols, this config option
+	  allows having aliases for global variables names too.
+
 # end of the "standard kernel features (expert users)" menu
 
 # syscall, maps, verifier
diff --git a/scripts/kas_alias.py b/scripts/kas_alias.py
new file mode 100755
index 000000000000..7c6b7045081c
--- /dev/null
+++ b/scripts/kas_alias.py
@@ -0,0 +1,136 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2023 Red Hat, Inc. Alessandro Carminati <alessandro.carminati@gmail.com>
+#
+# kas_alias: Adds alias to duplicate symbols in the kallsyms output.
+
+import subprocess
+import sys
+import os
+import argparse
+import re
+from collections import namedtuple
+
+regex_filter = [
+        "^__compound_literal\\.[0-9]+$",
+        "^__[wm]*key\\.[0-9]+$",
+        "^_*TRACE_SYSTEM.*$",
+        "^__already_done\\.[0-9]+$",
+        "^__msg\\.[0-9]+$",
+        "^__func__\\.[0-9]+$",
+        "^CSWTCH\\.[0-9]+$",
+        "^_rs\\.[0-9]+$",
+        "^___tp_str\\.[0-9]+$",
+        "^__flags\\.[0-9]+$",
+        "^___done\\.[0-9]+$",
+        "^__print_once\\.[0-9]+$",
+        "^___once_key\\.[0-9]+$",
+        "^__pfx_.*$",
+        "^__cfi_.*$"
+        ]
+
+class SeparatorType:
+    def __call__(self, separator):
+        if len(separator) != 1:
+            raise argparse.ArgumentTypeError("Separator must be a single character")
+        return separator
+
+Line = namedtuple('Line', ['address', 'type', 'name'])
+
+def parse_file(filename):
+    symbol_list = []
+    name_occurrences = {}
+
+    with open(filename, 'r') as file:
+        for line in file:
+            fields = line.strip().split()
+
+            if len(fields) >= 3:
+                address, type, name = fields[0], fields[1], ' '.join(fields[2:])
+                symbol_list.append(Line(address, type, name))
+                name_occurrences[name] = name_occurrences.get(name, 0) + 1
+
+    return symbol_list, name_occurrences
+
+def find_duplicate(symbol_list, name_occurrences):
+    name_to_lines = {}
+    duplicate_lines = []
+
+    for line in symbol_list:
+        if line.name in name_to_lines:
+            first_occurrence = name_to_lines[line.name]
+            duplicate_lines.extend([first_occurrence, line])
+        else:
+            name_to_lines[line.name] = line
+
+    return duplicate_lines
+
+def start_addr2line_process(binary_file, addr2line_file):
+    try:
+        addr2line_process = subprocess.Popen([addr2line_file, '-fe', binary_file],
+                                             stdin=subprocess.PIPE,
+                                             stdout=subprocess.PIPE,
+                                             stderr=subprocess.PIPE,
+                                             text=True)
+        return addr2line_process
+    except Exception as e:
+        print(f"Error starting addr2line process: {str(e)}")
+        sys.exit(1)
+
+def addr2line_fetch_address(addr2line_process, address):
+    try:
+        addr2line_process.stdin.write(address + '\n')
+        addr2line_process.stdin.flush()
+        addr2line_process.stdout.readline().strip()
+        output = addr2line_process.stdout.readline().strip()
+
+        return os.path.normpath(output)
+    except Exception as e:
+        print(f"Error communicating with addr2line: {str(e)}")
+        sys.exit(1)
+
+def process_line(obj, config):
+    if config:
+        return not (any(re.match(regex, obj.name) for regex in regex_filter))
+    else:
+        return obj.type in {"T", "t"}
+
+if __name__ == "__main__":
+    parser = argparse.ArgumentParser(description='Add alias to multiple occurring symbols name in kallsyms')
+    parser.add_argument('-a', "--addr2line", dest="addr2line_file", required=True)
+    parser.add_argument('-v', "--vmlinux", dest="vmlinux_file", required=True)
+    parser.add_argument('-o', "--outfile", dest="output_file", required=True)
+    parser.add_argument('-n', "--nmdata", dest="nm_data_file", required=True)
+    parser.add_argument('-b', "--basedir", dest="linux_base_dir", required=True)
+    parser.add_argument('-s', "--separator", dest="separator", required=False, default="@", type=SeparatorType())
+    parser.add_argument('-d', "--data", dest="include_data", required=False, action='store_true')
+    config = parser.parse_args()
+
+    try:
+        config.linux_base_dir = os.path.normpath(os.getcwd() + "/" + config.linux_base_dir) + "/"
+        symbol_list, name_occurrences = parse_file(config.nm_data_file)
+        addr2line_process = start_addr2line_process(config.vmlinux_file, config.addr2line_file)
+
+        with open(config.output_file, 'w') as file:
+            for obj in symbol_list:
+                file.write(f"{obj.address} {obj.type} {obj.name}\n")
+                if (name_occurrences[obj.name] > 1) and process_line(obj, config.include_data) :
+                    output = addr2line_fetch_address(addr2line_process, obj.address)
+                    decoration = config.separator + "".join(
+                        "_" if not c.isalnum() else c for c in output.replace(config.linux_base_dir, "")
+                    )
+                    # The addr2line can emit the special string "?:??" when addr2line can not find the
+                    # specified address in the DWARF section that after normalization it becomes "____".
+                    # In such cases, emitting an alias wouldn't make sense, so it is skipped.
+                    if decoration != config.separator + "____":
+                        file.write(f"{obj.address} {obj.type} {obj.name + decoration}\n")
+
+        addr2line_process.stdin.close()
+        addr2line_process.stdout.close()
+        addr2line_process.stderr.close()
+        addr2line_process.wait()
+
+    except Exception as e:
+        print(f"An error occurred: {str(e)}")
+        raise SystemExit("Script terminated due to an error")
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index a432b171be82..c110b0f58a19 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -91,7 +91,12 @@ vmlinux_link()
 
 	# The kallsyms linking does not need debug symbols included.
 	if [ "$output" != "${output#.tmp_vmlinux.kallsyms}" ] ; then
-		ldflags="${ldflags} ${wl}--strip-debug"
+		# The kallsyms linking does not need debug symbols included,
+		# unless the KALLSYMS_ALIAS_SRCLINE.
+		if ! is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE && \
+		   [ "$output" != "${output#.tmp_vmlinux.kallsyms}" ] ; then
+			ldflags="${ldflags} ${wl}--strip-debug"
+		fi
 	fi
 
 	if is_enabled CONFIG_VMLINUX_MAP; then
@@ -161,7 +166,19 @@ kallsyms()
 	fi
 
 	info KSYMS ${2}
-	scripts/kallsyms ${kallsymopt} ${1} > ${2}
+	ALIAS=""
+	KAS_DATA=""
+	if is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE_DATA; then
+		KAS_DATA="--data"
+	fi
+	if is_enabled CONFIG_KALLSYMS_ALIAS_SRCLINE; then
+		ALIAS=".alias"
+		${srctree}/scripts/kas_alias.py \
+			--addr2line ${ADDR2LINE} --vmlinux ${kallsyms_vmlinux} \
+			--nmdata ${1} --outfile ${1}${ALIAS} \
+			--basedir ${srctree} --separator @ ${KAS_DATA}
+	fi
+	scripts/kallsyms ${kallsymopt} ${1}${ALIAS} > ${2}
 }
 
 # Perform one step in kallsyms generation, including temporary linking of
-- 
2.34.1

