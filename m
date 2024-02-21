Return-Path: <linux-kernel+bounces-74814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8E885DB88
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12ACF1C22E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085BA77A03;
	Wed, 21 Feb 2024 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTIpJEmh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931678B4A;
	Wed, 21 Feb 2024 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522928; cv=none; b=q+G1HYyzjleUgIKbxKnw20nhemVDoGZbJP6AIhchsuR0kG/M3RxSkY0C73Kw1blEBarhuFwA4ljBH1QcWoqSAmGyiavP+sTDeYWElAIRY2ja6YmjToqX/wvbXGKPdSzUoYZtahexCE+NNaN9SIHs4GmM2PRjN1+VHTQbq60gCO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522928; c=relaxed/simple;
	bh=5Pg6e+SQR9HR3X/bH/d9JVFts+QBkx4A0Cr0pXVKVJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g5QN4SHusHJ5StOq6qN9QiV6hYbCGBH1Vs/a0NVkXoZscGbbHadOvtbU8oVuAa948ZUrHXSdAPZzmtXKNi9O2t3vEFASgivDACog+e5K82rSWtCSe2q48p0nQeRvJNN8ASeDRLCNomL1oKmqhv8d/lmcU/tYmLDtqAPv+rMX75o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTIpJEmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18A9C43394;
	Wed, 21 Feb 2024 13:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708522928;
	bh=5Pg6e+SQR9HR3X/bH/d9JVFts+QBkx4A0Cr0pXVKVJ8=;
	h=From:To:Cc:Subject:Date:From;
	b=lTIpJEmhMmeQ6zTh0BPe9zXs1CcFWxB3ryZvNszFuYclZdMsikm+FoKrj6sqzT8VT
	 qIlo7tD7A120NaBRJHy1rYroCFwp1NY1eF4AC/w+57OIgaUABN9MAex1U9N8DSl8Sl
	 ekaE9zRW4h0l4u7wCnjcKZaGNDlXbC8m9flTC+el4siYaLBjKy1s186rpskNveP5zx
	 rahu8QbYF5KJD4s1qcbj2ar+su1MJMTNG1WVyqbG3IOFcqttgw47wxWt3qZzD++xxF
	 44yXi1SejlQK2CyHXlFAm5qV3TBNTvRsc9oBjIWGgcAHEcADtjdY+K1WaHe5LrhbyN
	 kZUQlcB74S0aA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] treewide: remove meaningless assignments in Makefiles
Date: Wed, 21 Feb 2024 22:42:01 +0900
Message-Id: <20240221134201.2656908-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In Makefiles, $(error ), $(warning ), and $(info ) expand to the empty
string, as explained in the GNU Make manual [1]:
 "The result of the expansion of this function is the empty string."

Therefore, they are no-op except for logging purposes.

$(shell ...) expands to the output of the command. It expands to the
empty string when the command does not print anything to stdout.
Hence, $(shell mkdir ...) is no-op except for creating the directory.

Remove meaningless assignments.

[1]: https://www.gnu.org/software/make/manual/make.html#Make-Control-Functions

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

This is a treewide cleanup, but in practice, this is touching mostly
perf Makefiles. I am sending this to perf subsystem.


 tools/perf/Makefile.config           | 90 ++++++++++++++--------------
 tools/perf/Makefile.perf             |  4 +-
 tools/perf/arch/arm64/Makefile       |  2 +-
 tools/perf/arch/loongarch/Makefile   |  2 +-
 tools/perf/arch/mips/Makefile        |  2 +-
 tools/perf/arch/powerpc/Makefile     |  2 +-
 tools/perf/arch/s390/Makefile        |  2 +-
 tools/perf/arch/x86/Makefile         |  2 +-
 tools/scripts/Makefile.include       |  2 +-
 tools/testing/selftests/kvm/Makefile |  4 +-
 10 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index aa55850fbc21..6edf9916d41c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -209,11 +209,11 @@ endif
 include $(srctree)/tools/scripts/utilities.mak
 
 ifeq ($(call get-executable,$(FLEX)),)
-  dummy := $(error Error: $(FLEX) is missing on this system, please install it)
+  $(error Error: $(FLEX) is missing on this system, please install it)
 endif
 
 ifeq ($(call get-executable,$(BISON)),)
-  dummy := $(error Error: $(BISON) is missing on this system, please install it)
+  $(error Error: $(BISON) is missing on this system, please install it)
 endif
 
 ifneq ($(OUTPUT),)
@@ -438,46 +438,46 @@ else
       LIBC_SUPPORT := 1
     endif
     ifeq ($(LIBC_SUPPORT),1)
-      msg := $(error ERROR: No libelf found. Disables 'probe' tool, jvmti and BPF support. Please install libelf-dev, libelf-devel, elfutils-libelf-devel or build with NO_LIBELF=1.)
+      $(error ERROR: No libelf found. Disables 'probe' tool, jvmti and BPF support. Please install libelf-dev, libelf-devel, elfutils-libelf-devel or build with NO_LIBELF=1.)
     else
       ifneq ($(filter s% -fsanitize=address%,$(EXTRA_CFLAGS),),)
         ifneq ($(shell ldconfig -p | grep libasan >/dev/null 2>&1; echo $$?), 0)
-          msg := $(error No libasan found, please install libasan);
+          $(error No libasan found, please install libasan)
         endif
       endif
 
       ifneq ($(filter s% -fsanitize=undefined%,$(EXTRA_CFLAGS),),)
         ifneq ($(shell ldconfig -p | grep libubsan >/dev/null 2>&1; echo $$?), 0)
-          msg := $(error No libubsan found, please install libubsan);
+          $(error No libubsan found, please install libubsan)
         endif
       endif
 
       ifneq ($(filter s% -static%,$(LDFLAGS),),)
-        msg := $(error No static glibc found, please install glibc-static);
+        $(error No static glibc found, please install glibc-static)
       else
-        msg := $(error No gnu/libc-version.h found, please install glibc-dev[el]);
+        $(error No gnu/libc-version.h found, please install glibc-dev[el])
       endif
     endif
   else
     ifndef NO_LIBDW_DWARF_UNWIND
       ifneq ($(feature-libdw-dwarf-unwind),1)
         NO_LIBDW_DWARF_UNWIND := 1
-        msg := $(warning No libdw DWARF unwind found, Please install elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR);
+        $(warning No libdw DWARF unwind found, Please install elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR)
       endif
     endif
     ifneq ($(feature-dwarf), 1)
       ifndef NO_DWARF
-        msg := $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.138, disables dwarf support. Please install new elfutils-devel/libdw-dev);
+        $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.138, disables dwarf support. Please install new elfutils-devel/libdw-dev)
         NO_DWARF := 1
       endif
     else
       ifneq ($(feature-dwarf_getlocations), 1)
-        msg := $(warning Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.157);
+        $(warning Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.157)
       else
         CFLAGS += -DHAVE_DWARF_GETLOCATIONS_SUPPORT
       endif # dwarf_getlocations
       ifneq ($(feature-dwarf_getcfi), 1)
-        msg := $(warning Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.142);
+        $(warning Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.142)
       else
         CFLAGS += -DHAVE_DWARF_CFI_SUPPORT
       endif # dwarf_getcfi
@@ -525,7 +525,7 @@ ifdef CORESIGHT
       endif
     endif
   else
-    dummy := $(error Error: No libopencsd library found or the version is not up-to-date. Please install recent libopencsd to build with CORESIGHT=1)
+    $(error Error: No libopencsd library found or the version is not up-to-date. Please install recent libopencsd to build with CORESIGHT=1)
   endif
 endif
 
@@ -551,7 +551,7 @@ ifndef NO_LIBELF
   ifeq ($(feature-libelf-gelf_getnote), 1)
     CFLAGS += -DHAVE_GELF_GETNOTE_SUPPORT
   else
-    msg := $(warning gelf_getnote() not found on libelf, SDT support disabled);
+    $(warning gelf_getnote() not found on libelf, SDT support disabled)
   endif
 
   ifeq ($(feature-libelf-getshdrstrndx), 1)
@@ -568,7 +568,7 @@ ifndef NO_LIBELF
 
   ifndef NO_DWARF
     ifeq ($(origin PERF_HAVE_DWARF_REGS), undefined)
-      msg := $(warning DWARF register mappings have not been defined for architecture $(SRCARCH), DWARF support disabled);
+      $(warning DWARF register mappings have not been defined for architecture $(SRCARCH), DWARF support disabled)
       NO_DWARF := 1
     else
       CFLAGS += -DHAVE_DWARF_SUPPORT $(LIBDW_CFLAGS)
@@ -590,11 +590,11 @@ ifndef NO_LIBELF
           $(call detected,CONFIG_LIBBPF)
           $(call detected,CONFIG_LIBBPF_DYNAMIC)
         else
-          dummy := $(error Error: No libbpf devel library found or older than v1.0, please install/update libbpf-devel);
+          $(error Error: No libbpf devel library found or older than v1.0, please install/update libbpf-devel)
         endif
       else
         ifeq ($(NO_ZLIB), 1)
-          dummy := $(warning Warning: Statically building libbpf not possible as zlib is missing)
+          $(warning Warning: Statically building libbpf not possible as zlib is missing)
           NO_LIBBPF := 1
         else
           # Libbpf will be built as a static library from tools/lib/bpf.
@@ -609,7 +609,7 @@ endif # NO_LIBELF
 
 ifndef NO_SDT
   ifneq ($(feature-sdt), 1)
-    msg := $(warning No sys/sdt.h found, no SDT events are defined, please install systemtap-sdt-devel or systemtap-sdt-dev);
+    $(warning No sys/sdt.h found, no SDT events are defined, please install systemtap-sdt-devel or systemtap-sdt-dev)
     NO_SDT := 1;
   else
     CFLAGS += -DHAVE_SDT_EVENT
@@ -651,13 +651,13 @@ ifndef NO_LIBUNWIND
     have_libunwind = 1
     $(call feature_check,libunwind-debug-frame-aarch64)
     ifneq ($(feature-libunwind-debug-frame-aarch64), 1)
-      msg := $(warning No debug_frame support found in libunwind-aarch64);
+      $(warning No debug_frame support found in libunwind-aarch64)
       CFLAGS += -DNO_LIBUNWIND_DEBUG_FRAME_AARCH64
     endif
   endif
 
   ifneq ($(feature-libunwind), 1)
-    msg := $(warning No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR);
+    $(warning No libunwind found. Please install libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR)
     NO_LOCAL_LIBUNWIND := 1
   else
     have_libunwind := 1
@@ -673,7 +673,7 @@ endif
 
 ifndef NO_LIBBPF
   ifneq ($(feature-bpf), 1)
-    msg := $(warning BPF API too old. Please install recent kernel headers. BPF support in 'perf record' is disabled.)
+    $(warning BPF API too old. Please install recent kernel headers. BPF support in 'perf record' is disabled.)
     NO_LIBBPF := 1
   endif
 endif
@@ -686,28 +686,28 @@ endif
 
 ifeq ($(BUILD_BPF_SKEL),1)
   ifeq ($(filter -DHAVE_LIBELF_SUPPORT, $(CFLAGS)),)
-    dummy := $(warning Warning: Disabled BPF skeletons as libelf is required by bpftool)
+    $(warning Warning: Disabled BPF skeletons as libelf is required by bpftool)
     BUILD_BPF_SKEL := 0
   else ifeq ($(filter -DHAVE_ZLIB_SUPPORT, $(CFLAGS)),)
-    dummy := $(warning Warning: Disabled BPF skeletons as zlib is required by bpftool)
+    $(warning Warning: Disabled BPF skeletons as zlib is required by bpftool)
     BUILD_BPF_SKEL := 0
   else ifeq ($(filter -DHAVE_LIBBPF_SUPPORT, $(CFLAGS)),)
-    dummy := $(warning Warning: Disabled BPF skeletons as libbpf is required)
+    $(warning Warning: Disabled BPF skeletons as libbpf is required)
     BUILD_BPF_SKEL := 0
   else ifeq ($(call get-executable,$(CLANG)),)
-    dummy := $(warning Warning: Disabled BPF skeletons as clang ($(CLANG)) is missing)
+    $(warning Warning: Disabled BPF skeletons as clang ($(CLANG)) is missing)
     BUILD_BPF_SKEL := 0
   else
     CLANG_VERSION := $(shell $(CLANG) --version | head -1 | sed 's/.*clang version \([[:digit:]]\+.[[:digit:]]\+.[[:digit:]]\+\).*/\1/g')
     ifeq ($(call version-lt3,$(CLANG_VERSION),12.0.1),1)
-      dummy := $(warning Warning: Disabled BPF skeletons as reliable BTF generation needs at least $(CLANG) version 12.0.1)
+      $(warning Warning: Disabled BPF skeletons as reliable BTF generation needs at least $(CLANG) version 12.0.1)
       BUILD_BPF_SKEL := 0
     endif
   endif
   ifeq ($(BUILD_BPF_SKEL),1)
     $(call feature_check,clang-bpf-co-re)
     ifeq ($(feature-clang-bpf-co-re), 0)
-      dummy := $(warning Warning: Disabled BPF skeletons as clang is too old)
+      $(warning Warning: Disabled BPF skeletons as clang is too old)
       BUILD_BPF_SKEL := 0
     endif
   endif
@@ -727,7 +727,7 @@ dwarf-post-unwind-text := BUG
 # setup DWARF post unwinder
 ifdef NO_LIBUNWIND
   ifdef NO_LIBDW_DWARF_UNWIND
-    msg := $(warning Disabling post unwind, no support found.);
+    $(warning Disabling post unwind, no support found.)
     dwarf-post-unwind := 0
   else
     dwarf-post-unwind-text := libdw
@@ -753,7 +753,7 @@ ifndef NO_LOCAL_LIBUNWIND
   ifeq ($(SRCARCH),$(filter $(SRCARCH),arm arm64))
     $(call feature_check,libunwind-debug-frame)
     ifneq ($(feature-libunwind-debug-frame), 1)
-      msg := $(warning No debug_frame support found in libunwind);
+      $(warning No debug_frame support found in libunwind)
       CFLAGS += -DNO_LIBUNWIND_DEBUG_FRAME
     endif
   else
@@ -782,7 +782,7 @@ ifneq ($(NO_LIBTRACEEVENT),1)
     ifndef NO_LIBAUDIT
       $(call feature_check,libaudit)
       ifneq ($(feature-libaudit), 1)
-        msg := $(warning No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev);
+        $(warning No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev)
         NO_LIBAUDIT := 1
       else
         CFLAGS += -DHAVE_LIBAUDIT_SUPPORT
@@ -795,7 +795,7 @@ endif
 
 ifndef NO_LIBCRYPTO
   ifneq ($(feature-libcrypto), 1)
-    msg := $(warning No libcrypto.h found, disables jitted code injection, please install openssl-devel or libssl-dev);
+    $(warning No libcrypto.h found, disables jitted code injection, please install openssl-devel or libssl-dev)
     NO_LIBCRYPTO := 1
   else
     CFLAGS += -DHAVE_LIBCRYPTO_SUPPORT
@@ -807,7 +807,7 @@ endif
 ifndef NO_SLANG
   ifneq ($(feature-libslang), 1)
     ifneq ($(feature-libslang-include-subdir), 1)
-      msg := $(warning slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev);
+      $(warning slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev)
       NO_SLANG := 1
     else
       CFLAGS += -DHAVE_SLANG_INCLUDE_SUBDIR
@@ -825,7 +825,7 @@ ifdef GTK2
   FLAGS_GTK2=$(CFLAGS) $(LDFLAGS) $(EXTLIBS) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null)
   $(call feature_check,gtk2)
   ifneq ($(feature-gtk2), 1)
-    msg := $(warning GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev);
+    $(warning GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev)
     NO_GTK2 := 1
   else
     $(call feature_check,gtk2-infobar)
@@ -854,7 +854,7 @@ else
   ifneq ($(feature-libperl), 1)
     CFLAGS += -DNO_LIBPERL
     NO_LIBPERL := 1
-    msg := $(warning Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev);
+    $(warning Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev)
   else
     LDFLAGS += $(PERL_EMBED_LDFLAGS)
     EXTLIBS += $(PERL_EMBED_LIBADD)
@@ -869,7 +869,7 @@ endif
 ifeq ($(feature-timerfd), 1)
   CFLAGS += -DHAVE_TIMERFD_SUPPORT
 else
-  msg := $(warning No timerfd support. Disables 'perf kvm stat live');
+  $(warning No timerfd support. Disables 'perf kvm stat live')
 endif
 
 disable-python = $(eval $(disable-python_code))
@@ -903,7 +903,7 @@ else
            PYTHON_EXTENSION_SUFFIX := $(shell $(PYTHON) -c 'from importlib import machinery; print(machinery.EXTENSION_SUFFIXES[0])')
            LANG_BINDINGS += $(obj-perf)python/perf$(PYTHON_EXTENSION_SUFFIX)
 	 else
-           msg := $(warning Missing python setuptools, the python binding won't be built, please install python3-setuptools or equivalent);
+           $(warning Missing python setuptools, the python binding won't be built, please install python3-setuptools or equivalent)
          endif
          CFLAGS += -DHAVE_LIBPYTHON_SUPPORT
          $(call detected,CONFIG_LIBPYTHON)
@@ -962,7 +962,7 @@ ifdef BUILD_NONDISTRO
   ifeq ($(feature-libbfd-buildid), 1)
     CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
   else
-    msg := $(warning Old version of libbfd/binutils things like PE executable profiling will not be available);
+    $(warning Old version of libbfd/binutils things like PE executable profiling will not be available)
   endif
 endif
 
@@ -994,7 +994,7 @@ ifndef NO_LZMA
     EXTLIBS += -llzma
     $(call detected,CONFIG_LZMA)
   else
-    msg := $(warning No liblzma found, disables xz kernel module decompression, please install xz-devel/liblzma-dev);
+    $(warning No liblzma found, disables xz kernel module decompression, please install xz-devel/liblzma-dev)
     NO_LZMA := 1
   endif
 endif
@@ -1007,7 +1007,7 @@ ifndef NO_LIBZSTD
     EXTLIBS += -lzstd
     $(call detected,CONFIG_ZSTD)
   else
-    msg := $(warning No libzstd found, disables trace compression, please install libzstd-dev[el] and/or set LIBZSTD_DIR);
+    $(warning No libzstd found, disables trace compression, please install libzstd-dev[el] and/or set LIBZSTD_DIR)
     NO_LIBZSTD := 1
   endif
 endif
@@ -1018,7 +1018,7 @@ ifndef NO_LIBCAP
     EXTLIBS += -lcap
     $(call detected,CONFIG_LIBCAP)
   else
-    msg := $(warning No libcap found, disables capability support, please install libcap-devel/libcap-dev);
+    $(warning No libcap found, disables capability support, please install libcap-devel/libcap-dev)
     NO_LIBCAP := 1
   endif
 endif
@@ -1031,11 +1031,11 @@ endif
 
 ifndef NO_LIBNUMA
   ifeq ($(feature-libnuma), 0)
-    msg := $(warning No numa.h found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev);
+    $(warning No numa.h found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev)
     NO_LIBNUMA := 1
   else
     ifeq ($(feature-numa_num_possible_cpus), 0)
-      msg := $(warning Old numa library found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev >= 2.0.8);
+      $(warning Old numa library found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev >= 2.0.8)
       NO_LIBNUMA := 1
     else
       CFLAGS += -DHAVE_LIBNUMA_SUPPORT
@@ -1090,14 +1090,14 @@ ifndef NO_LIBBABELTRACE
     EXTLIBS += -lbabeltrace-ctf
     $(call detected,CONFIG_LIBBABELTRACE)
   else
-    msg := $(warning No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev);
+    $(warning No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev)
   endif
 endif
 
 ifndef NO_AUXTRACE
   ifeq ($(SRCARCH),x86)
     ifeq ($(feature-get_cpuid), 0)
-      msg := $(warning Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc);
+      $(warning Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc)
       NO_AUXTRACE := 1
     endif
   endif
@@ -1155,7 +1155,7 @@ ifndef NO_LIBPFM4
     ASCIIDOC_EXTRA = -aHAVE_LIBPFM=1
     $(call detected,CONFIG_LIBPFM4)
   else
-    msg := $(warning libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev);
+    $(warning libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev)
   endif
 endif
 
@@ -1173,7 +1173,7 @@ ifneq ($(NO_LIBTRACEEVENT),1)
     CFLAGS += -DLIBTRACEEVENT_VERSION=$(LIBTRACEEVENT_VERSION_CPP)
     $(call detected,CONFIG_LIBTRACEEVENT)
   else
-    dummy := $(error ERROR: libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel or build with NO_LIBTRACEEVENT=1)
+    $(error ERROR: libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel or build with NO_LIBTRACEEVENT=1)
   endif
 
   $(call feature_check,libtracefs)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f8774a9b1377..3707fed8dfde 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -482,7 +482,7 @@ drm_hdr_dir := $(srctree)/tools/include/uapi/drm
 drm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/drm_ioctl.sh
 
 # Create output directory if not already present
-_dummy := $(shell [ -d '$(beauty_ioctl_outdir)' ] || mkdir -p '$(beauty_ioctl_outdir)')
+$(shell [ -d '$(beauty_ioctl_outdir)' ] || mkdir -p '$(beauty_ioctl_outdir)')
 
 $(drm_ioctl_array): $(drm_hdr_dir)/drm.h $(drm_hdr_dir)/i915_drm.h $(drm_ioctl_tbl)
 	$(Q)$(SHELL) '$(drm_ioctl_tbl)' $(drm_hdr_dir) > $@
@@ -672,7 +672,7 @@ tests-coresight-targets-clean:
 all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS) tests-coresight-targets
 
 # Create python binding output directory if not already present
-_dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
+$(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
 
 $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBPERF) $(LIBSUBCMD)
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index fab3095fb5d0..5735ed4479bb 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -18,7 +18,7 @@ sysprf := $(srctree)/tools/perf/arch/arm64/entry/syscalls/
 systbl := $(sysprf)/mksyscalltbl
 
 # Create output directory if not already present
-_dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
+$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 
 $(header): $(sysdef) $(systbl)
 	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(incpath) $(sysdef) > $@
diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loongarch/Makefile
index c392e7af4743..3992a67a87d9 100644
--- a/tools/perf/arch/loongarch/Makefile
+++ b/tools/perf/arch/loongarch/Makefile
@@ -17,7 +17,7 @@ sysprf := $(srctree)/tools/perf/arch/loongarch/entry/syscalls/
 systbl := $(sysprf)/mksyscalltbl
 
 # Create output directory if not already present
-_dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
+$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 
 $(header): $(sysdef) $(systbl)
 	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(incpath) $(sysdef) > $@
diff --git a/tools/perf/arch/mips/Makefile b/tools/perf/arch/mips/Makefile
index 8bc09072e3d6..cd0b011b3be5 100644
--- a/tools/perf/arch/mips/Makefile
+++ b/tools/perf/arch/mips/Makefile
@@ -11,7 +11,7 @@ sysdef := $(sysprf)/syscall_n64.tbl
 systbl := $(sysprf)/mksyscalltbl
 
 # Create output directory if not already present
-_dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
+$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 
 $(header): $(sysdef) $(systbl)
 	$(Q)$(SHELL) '$(systbl)' $(sysdef) > $@
diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index 840ea0e59287..bf6d323574f6 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -19,7 +19,7 @@ sysdef := $(sysprf)/syscall.tbl
 systbl := $(sysprf)/mksyscalltbl
 
 # Create output directory if not already present
-_dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
+$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 
 $(header64): $(sysdef) $(systbl)
 	$(Q)$(SHELL) '$(systbl)' '64' $(sysdef) > $@
diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
index 74bffbea03e2..56994e63b43a 100644
--- a/tools/perf/arch/s390/Makefile
+++ b/tools/perf/arch/s390/Makefile
@@ -17,7 +17,7 @@ sysdef := $(sysprf)/syscall.tbl
 systbl := $(sysprf)/mksyscalltbl
 
 # Create output directory if not already present
-_dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
+$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 
 $(header): $(sysdef) $(systbl)
 	$(Q)$(SHELL) '$(systbl)' $(sysdef) > $@
diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
index 5a9f9a7bf07d..8952e00f9b60 100644
--- a/tools/perf/arch/x86/Makefile
+++ b/tools/perf/arch/x86/Makefile
@@ -17,7 +17,7 @@ sys       := $(srctree)/tools/perf/arch/x86/entry/syscalls
 systbl    := $(sys)/syscalltbl.sh
 
 # Create output directory if not already present
-_dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
+$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 
 $(header): $(sys)/syscall_64.tbl $(systbl)
 	$(Q)$(SHELL) '$(systbl)' $(sys)/syscall_64.tbl 'x86_64' > $@
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 6fba29f3222d..0aa4005017c7 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 ifneq ($(O),)
 ifeq ($(origin O), command line)
-	dummy := $(if $(shell cd $(PWD); test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
+        $(if $(shell cd $(PWD); test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
 	ABSOLUTE_O := $(shell cd $(PWD); cd $(O) ; pwd)
 	OUTPUT := $(ABSOLUTE_O)/$(if $(subdir),$(subdir)/)
 	COMMAND_O := O=$(ABSOLUTE_O)
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 492e937fab00..14684aeb4b55 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -285,7 +285,7 @@ EXTRA_CLEAN += $(GEN_HDRS) \
 	       $(TEST_GEN_OBJ) \
 	       cscope.*
 
-x := $(shell mkdir -p $(sort $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
+$(shell mkdir -p $(sort $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
 $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c $(GEN_HDRS)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
@@ -298,7 +298,7 @@ $(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(GEN_HDRS)
 $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
 
-x := $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
+$(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
 $(SPLIT_TESTS_OBJS): $(GEN_HDRS)
 $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
 $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
-- 
2.40.1


