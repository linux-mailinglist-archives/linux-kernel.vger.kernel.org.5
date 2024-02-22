Return-Path: <linux-kernel+bounces-76924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE7085FEBE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480B41F2906B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A726154C0D;
	Thu, 22 Feb 2024 17:08:50 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4737F154455;
	Thu, 22 Feb 2024 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621728; cv=none; b=Pu2PElUqJ/9bohn9VwldQaVt3MWaJiaF12A1uS1GYAw5Dkpbg7UEJe1nUgTmpSi4lBvMWVO3v04EeIJ/jBWmi1SQw0jfysy4syTTEffT3kXiZFT7KICS4gY7jSiGHg+8xrAWGJJJDpjPpvnGy7ghALdWIcPEGGK8BmyiIpxJ2jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621728; c=relaxed/simple;
	bh=b1EsNE3xzFfmxoZDfe8dxaRfz9mX/z37davNYlJv/F8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrdDMuJ0wxspLeNtaiMmuxslRokxDPWEKLTL44BEo+tYCJVTC4vVyf4Ihzt7BML8bV418CJlJghfWvAKeNwfgSl3YuG70wjgQ4SFTkci8i8sjt2ihddHR2PT/vfF0A0PfI7twDxJ1ExpDPqOi4HPyPWqP6dv3oZH8V5NHQXOoD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso1431819a12.0;
        Thu, 22 Feb 2024 09:08:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708621725; x=1709226525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JclqIcw1F/fMLL4TiX3BuTcOc5/MkakDm3FxHn1LPVg=;
        b=GHJDah+XmEGsGzhfoSfbxoj3xyOL4KojYLSqh+0mubL/2xQP8sxWuNIIl/+iQcxTQe
         54O+8fj6+XzHzINkz5V+sWXL5ktgHsRFqpTC9Ma7+wizNeDrBsxruZGDEtcaCea5W12y
         VWCVlCptbMUZLMoSRmr0/rUfPsm8bF76xBhA1cL2lCBUh91AsykrrwiR4Wc3f7v76Erh
         IGt3+8VKCzwbDMbxiNyTejNhDtdg6Lb/cdTXBHzCABxzl1zqWs5xqIGGKPMupqayzu0/
         qn4E/n7X7J4Tqwk6bHMaqdELmiJJzFDQliOxJdLuBLwgF9v2KLAeyCvpVyboMsTJeMEs
         zHsw==
X-Forwarded-Encrypted: i=1; AJvYcCV08jBk+FdbJaj5OkBwey7LmeLr8bHcGZlZnXAPiZOFkPc7J7OlSo6toWpgFXjcWUndpu2W6sQRFahNDg9uXnYctnxumT6CpjBnkoO4GCC0MS0MG+JvaI3G+Mnh1oTh/vYgM5tpjGXYqXGaFpIPM2UFLPO/mUSRobAT+QUaDTx+kJs/0MOD/R3L8okmwQ==
X-Gm-Message-State: AOJu0Yw94+ySoesf27Xa+oHkr+bRrKltREkkYcAHGkumqZ2X2EV1PWma
	po4jP2Qgt2Xh7bJ2/OTMT3EnXkZhfcWBni5BW6T8jiJCqlLpFtMRHAJfLyOKkEeYsB9DTYfb4pn
	+z2wN4EhpOpk3zT1YlccHKj2tx+U=
X-Google-Smtp-Source: AGHT+IGziKoN4Y3Hl7YA59Xdbb4DJSR00IPqcG4VahEr9oFJtzTVNTQ5zznkAfasvmBFVkE/GUdFpQ4IoZyoFsGNJg0=
X-Received: by 2002:a17:90a:fc83:b0:299:bb08:e83a with SMTP id
 ci3-20020a17090afc8300b00299bb08e83amr9826069pjb.28.1708621725090; Thu, 22
 Feb 2024 09:08:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221134201.2656908-1-masahiroy@kernel.org>
In-Reply-To: <20240221134201.2656908-1-masahiroy@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 22 Feb 2024 09:08:33 -0800
Message-ID: <CAM9d7cjQ0wbPu9NWcg_Rj66jcJ=6HoNMcTnfR4wvjaJ47FDVQA@mail.gmail.com>
Subject: Re: [PATCH] treewide: remove meaningless assignments in Makefiles
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Feb 21, 2024 at 5:42=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> In Makefiles, $(error ), $(warning ), and $(info ) expand to the empty
> string, as explained in the GNU Make manual [1]:
>  "The result of the expansion of this function is the empty string."
>
> Therefore, they are no-op except for logging purposes.
>
> $(shell ...) expands to the output of the command. It expands to the
> empty string when the command does not print anything to stdout.
> Hence, $(shell mkdir ...) is no-op except for creating the directory.
>
> Remove meaningless assignments.
>
> [1]: https://www.gnu.org/software/make/manual/make.html#Make-Control-Func=
tions
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> This is a treewide cleanup, but in practice, this is touching mostly
> perf Makefiles. I am sending this to perf subsystem.

How do you want to route this?  I can take it to perf tree if you're ok.

Thanks,
Namhyung

>
>
>  tools/perf/Makefile.config           | 90 ++++++++++++++--------------
>  tools/perf/Makefile.perf             |  4 +-
>  tools/perf/arch/arm64/Makefile       |  2 +-
>  tools/perf/arch/loongarch/Makefile   |  2 +-
>  tools/perf/arch/mips/Makefile        |  2 +-
>  tools/perf/arch/powerpc/Makefile     |  2 +-
>  tools/perf/arch/s390/Makefile        |  2 +-
>  tools/perf/arch/x86/Makefile         |  2 +-
>  tools/scripts/Makefile.include       |  2 +-
>  tools/testing/selftests/kvm/Makefile |  4 +-
>  10 files changed, 56 insertions(+), 56 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index aa55850fbc21..6edf9916d41c 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -209,11 +209,11 @@ endif
>  include $(srctree)/tools/scripts/utilities.mak
>
>  ifeq ($(call get-executable,$(FLEX)),)
> -  dummy :=3D $(error Error: $(FLEX) is missing on this system, please in=
stall it)
> +  $(error Error: $(FLEX) is missing on this system, please install it)
>  endif
>
>  ifeq ($(call get-executable,$(BISON)),)
> -  dummy :=3D $(error Error: $(BISON) is missing on this system, please i=
nstall it)
> +  $(error Error: $(BISON) is missing on this system, please install it)
>  endif
>
>  ifneq ($(OUTPUT),)
> @@ -438,46 +438,46 @@ else
>        LIBC_SUPPORT :=3D 1
>      endif
>      ifeq ($(LIBC_SUPPORT),1)
> -      msg :=3D $(error ERROR: No libelf found. Disables 'probe' tool, jv=
mti and BPF support. Please install libelf-dev, libelf-devel, elfutils-libe=
lf-devel or build with NO_LIBELF=3D1.)
> +      $(error ERROR: No libelf found. Disables 'probe' tool, jvmti and B=
PF support. Please install libelf-dev, libelf-devel, elfutils-libelf-devel =
or build with NO_LIBELF=3D1.)
>      else
>        ifneq ($(filter s% -fsanitize=3Daddress%,$(EXTRA_CFLAGS),),)
>          ifneq ($(shell ldconfig -p | grep libasan >/dev/null 2>&1; echo =
$$?), 0)
> -          msg :=3D $(error No libasan found, please install libasan);
> +          $(error No libasan found, please install libasan)
>          endif
>        endif
>
>        ifneq ($(filter s% -fsanitize=3Dundefined%,$(EXTRA_CFLAGS),),)
>          ifneq ($(shell ldconfig -p | grep libubsan >/dev/null 2>&1; echo=
 $$?), 0)
> -          msg :=3D $(error No libubsan found, please install libubsan);
> +          $(error No libubsan found, please install libubsan)
>          endif
>        endif
>
>        ifneq ($(filter s% -static%,$(LDFLAGS),),)
> -        msg :=3D $(error No static glibc found, please install glibc-sta=
tic);
> +        $(error No static glibc found, please install glibc-static)
>        else
> -        msg :=3D $(error No gnu/libc-version.h found, please install gli=
bc-dev[el]);
> +        $(error No gnu/libc-version.h found, please install glibc-dev[el=
])
>        endif
>      endif
>    else
>      ifndef NO_LIBDW_DWARF_UNWIND
>        ifneq ($(feature-libdw-dwarf-unwind),1)
>          NO_LIBDW_DWARF_UNWIND :=3D 1
> -        msg :=3D $(warning No libdw DWARF unwind found, Please install e=
lfutils-devel/libdw-dev >=3D 0.158 and/or set LIBDW_DIR);
> +        $(warning No libdw DWARF unwind found, Please install elfutils-d=
evel/libdw-dev >=3D 0.158 and/or set LIBDW_DIR)
>        endif
>      endif
>      ifneq ($(feature-dwarf), 1)
>        ifndef NO_DWARF
> -        msg :=3D $(warning No libdw.h found or old libdw.h found or elfu=
tils is older than 0.138, disables dwarf support. Please install new elfuti=
ls-devel/libdw-dev);
> +        $(warning No libdw.h found or old libdw.h found or elfutils is o=
lder than 0.138, disables dwarf support. Please install new elfutils-devel/=
libdw-dev)
>          NO_DWARF :=3D 1
>        endif
>      else
>        ifneq ($(feature-dwarf_getlocations), 1)
> -        msg :=3D $(warning Old libdw.h, finding variables at given 'perf=
 probe' point will not work, install elfutils-devel/libdw-dev >=3D 0.157);
> +        $(warning Old libdw.h, finding variables at given 'perf probe' p=
oint will not work, install elfutils-devel/libdw-dev >=3D 0.157)
>        else
>          CFLAGS +=3D -DHAVE_DWARF_GETLOCATIONS_SUPPORT
>        endif # dwarf_getlocations
>        ifneq ($(feature-dwarf_getcfi), 1)
> -        msg :=3D $(warning Old libdw.h, finding variables at given 'perf=
 probe' point will not work, install elfutils-devel/libdw-dev >=3D 0.142);
> +        $(warning Old libdw.h, finding variables at given 'perf probe' p=
oint will not work, install elfutils-devel/libdw-dev >=3D 0.142)
>        else
>          CFLAGS +=3D -DHAVE_DWARF_CFI_SUPPORT
>        endif # dwarf_getcfi
> @@ -525,7 +525,7 @@ ifdef CORESIGHT
>        endif
>      endif
>    else
> -    dummy :=3D $(error Error: No libopencsd library found or the version=
 is not up-to-date. Please install recent libopencsd to build with CORESIGH=
T=3D1)
> +    $(error Error: No libopencsd library found or the version is not up-=
to-date. Please install recent libopencsd to build with CORESIGHT=3D1)
>    endif
>  endif
>
> @@ -551,7 +551,7 @@ ifndef NO_LIBELF
>    ifeq ($(feature-libelf-gelf_getnote), 1)
>      CFLAGS +=3D -DHAVE_GELF_GETNOTE_SUPPORT
>    else
> -    msg :=3D $(warning gelf_getnote() not found on libelf, SDT support d=
isabled);
> +    $(warning gelf_getnote() not found on libelf, SDT support disabled)
>    endif
>
>    ifeq ($(feature-libelf-getshdrstrndx), 1)
> @@ -568,7 +568,7 @@ ifndef NO_LIBELF
>
>    ifndef NO_DWARF
>      ifeq ($(origin PERF_HAVE_DWARF_REGS), undefined)
> -      msg :=3D $(warning DWARF register mappings have not been defined f=
or architecture $(SRCARCH), DWARF support disabled);
> +      $(warning DWARF register mappings have not been defined for archit=
ecture $(SRCARCH), DWARF support disabled)
>        NO_DWARF :=3D 1
>      else
>        CFLAGS +=3D -DHAVE_DWARF_SUPPORT $(LIBDW_CFLAGS)
> @@ -590,11 +590,11 @@ ifndef NO_LIBELF
>            $(call detected,CONFIG_LIBBPF)
>            $(call detected,CONFIG_LIBBPF_DYNAMIC)
>          else
> -          dummy :=3D $(error Error: No libbpf devel library found or old=
er than v1.0, please install/update libbpf-devel);
> +          $(error Error: No libbpf devel library found or older than v1.=
0, please install/update libbpf-devel)
>          endif
>        else
>          ifeq ($(NO_ZLIB), 1)
> -          dummy :=3D $(warning Warning: Statically building libbpf not p=
ossible as zlib is missing)
> +          $(warning Warning: Statically building libbpf not possible as =
zlib is missing)
>            NO_LIBBPF :=3D 1
>          else
>            # Libbpf will be built as a static library from tools/lib/bpf.
> @@ -609,7 +609,7 @@ endif # NO_LIBELF
>
>  ifndef NO_SDT
>    ifneq ($(feature-sdt), 1)
> -    msg :=3D $(warning No sys/sdt.h found, no SDT events are defined, pl=
ease install systemtap-sdt-devel or systemtap-sdt-dev);
> +    $(warning No sys/sdt.h found, no SDT events are defined, please inst=
all systemtap-sdt-devel or systemtap-sdt-dev)
>      NO_SDT :=3D 1;
>    else
>      CFLAGS +=3D -DHAVE_SDT_EVENT
> @@ -651,13 +651,13 @@ ifndef NO_LIBUNWIND
>      have_libunwind =3D 1
>      $(call feature_check,libunwind-debug-frame-aarch64)
>      ifneq ($(feature-libunwind-debug-frame-aarch64), 1)
> -      msg :=3D $(warning No debug_frame support found in libunwind-aarch=
64);
> +      $(warning No debug_frame support found in libunwind-aarch64)
>        CFLAGS +=3D -DNO_LIBUNWIND_DEBUG_FRAME_AARCH64
>      endif
>    endif
>
>    ifneq ($(feature-libunwind), 1)
> -    msg :=3D $(warning No libunwind found. Please install libunwind-dev[=
el] >=3D 1.1 and/or set LIBUNWIND_DIR);
> +    $(warning No libunwind found. Please install libunwind-dev[el] >=3D =
1.1 and/or set LIBUNWIND_DIR)
>      NO_LOCAL_LIBUNWIND :=3D 1
>    else
>      have_libunwind :=3D 1
> @@ -673,7 +673,7 @@ endif
>
>  ifndef NO_LIBBPF
>    ifneq ($(feature-bpf), 1)
> -    msg :=3D $(warning BPF API too old. Please install recent kernel hea=
ders. BPF support in 'perf record' is disabled.)
> +    $(warning BPF API too old. Please install recent kernel headers. BPF=
 support in 'perf record' is disabled.)
>      NO_LIBBPF :=3D 1
>    endif
>  endif
> @@ -686,28 +686,28 @@ endif
>
>  ifeq ($(BUILD_BPF_SKEL),1)
>    ifeq ($(filter -DHAVE_LIBELF_SUPPORT, $(CFLAGS)),)
> -    dummy :=3D $(warning Warning: Disabled BPF skeletons as libelf is re=
quired by bpftool)
> +    $(warning Warning: Disabled BPF skeletons as libelf is required by b=
pftool)
>      BUILD_BPF_SKEL :=3D 0
>    else ifeq ($(filter -DHAVE_ZLIB_SUPPORT, $(CFLAGS)),)
> -    dummy :=3D $(warning Warning: Disabled BPF skeletons as zlib is requ=
ired by bpftool)
> +    $(warning Warning: Disabled BPF skeletons as zlib is required by bpf=
tool)
>      BUILD_BPF_SKEL :=3D 0
>    else ifeq ($(filter -DHAVE_LIBBPF_SUPPORT, $(CFLAGS)),)
> -    dummy :=3D $(warning Warning: Disabled BPF skeletons as libbpf is re=
quired)
> +    $(warning Warning: Disabled BPF skeletons as libbpf is required)
>      BUILD_BPF_SKEL :=3D 0
>    else ifeq ($(call get-executable,$(CLANG)),)
> -    dummy :=3D $(warning Warning: Disabled BPF skeletons as clang ($(CLA=
NG)) is missing)
> +    $(warning Warning: Disabled BPF skeletons as clang ($(CLANG)) is mis=
sing)
>      BUILD_BPF_SKEL :=3D 0
>    else
>      CLANG_VERSION :=3D $(shell $(CLANG) --version | head -1 | sed 's/.*c=
lang version \([[:digit:]]\+.[[:digit:]]\+.[[:digit:]]\+\).*/\1/g')
>      ifeq ($(call version-lt3,$(CLANG_VERSION),12.0.1),1)
> -      dummy :=3D $(warning Warning: Disabled BPF skeletons as reliable B=
TF generation needs at least $(CLANG) version 12.0.1)
> +      $(warning Warning: Disabled BPF skeletons as reliable BTF generati=
on needs at least $(CLANG) version 12.0.1)
>        BUILD_BPF_SKEL :=3D 0
>      endif
>    endif
>    ifeq ($(BUILD_BPF_SKEL),1)
>      $(call feature_check,clang-bpf-co-re)
>      ifeq ($(feature-clang-bpf-co-re), 0)
> -      dummy :=3D $(warning Warning: Disabled BPF skeletons as clang is t=
oo old)
> +      $(warning Warning: Disabled BPF skeletons as clang is too old)
>        BUILD_BPF_SKEL :=3D 0
>      endif
>    endif
> @@ -727,7 +727,7 @@ dwarf-post-unwind-text :=3D BUG
>  # setup DWARF post unwinder
>  ifdef NO_LIBUNWIND
>    ifdef NO_LIBDW_DWARF_UNWIND
> -    msg :=3D $(warning Disabling post unwind, no support found.);
> +    $(warning Disabling post unwind, no support found.)
>      dwarf-post-unwind :=3D 0
>    else
>      dwarf-post-unwind-text :=3D libdw
> @@ -753,7 +753,7 @@ ifndef NO_LOCAL_LIBUNWIND
>    ifeq ($(SRCARCH),$(filter $(SRCARCH),arm arm64))
>      $(call feature_check,libunwind-debug-frame)
>      ifneq ($(feature-libunwind-debug-frame), 1)
> -      msg :=3D $(warning No debug_frame support found in libunwind);
> +      $(warning No debug_frame support found in libunwind)
>        CFLAGS +=3D -DNO_LIBUNWIND_DEBUG_FRAME
>      endif
>    else
> @@ -782,7 +782,7 @@ ifneq ($(NO_LIBTRACEEVENT),1)
>      ifndef NO_LIBAUDIT
>        $(call feature_check,libaudit)
>        ifneq ($(feature-libaudit), 1)
> -        msg :=3D $(warning No libaudit.h found, disables 'trace' tool, p=
lease install audit-libs-devel or libaudit-dev);
> +        $(warning No libaudit.h found, disables 'trace' tool, please ins=
tall audit-libs-devel or libaudit-dev)
>          NO_LIBAUDIT :=3D 1
>        else
>          CFLAGS +=3D -DHAVE_LIBAUDIT_SUPPORT
> @@ -795,7 +795,7 @@ endif
>
>  ifndef NO_LIBCRYPTO
>    ifneq ($(feature-libcrypto), 1)
> -    msg :=3D $(warning No libcrypto.h found, disables jitted code inject=
ion, please install openssl-devel or libssl-dev);
> +    $(warning No libcrypto.h found, disables jitted code injection, plea=
se install openssl-devel or libssl-dev)
>      NO_LIBCRYPTO :=3D 1
>    else
>      CFLAGS +=3D -DHAVE_LIBCRYPTO_SUPPORT
> @@ -807,7 +807,7 @@ endif
>  ifndef NO_SLANG
>    ifneq ($(feature-libslang), 1)
>      ifneq ($(feature-libslang-include-subdir), 1)
> -      msg :=3D $(warning slang not found, disables TUI support. Please i=
nstall slang-devel, libslang-dev or libslang2-dev);
> +      $(warning slang not found, disables TUI support. Please install sl=
ang-devel, libslang-dev or libslang2-dev)
>        NO_SLANG :=3D 1
>      else
>        CFLAGS +=3D -DHAVE_SLANG_INCLUDE_SUBDIR
> @@ -825,7 +825,7 @@ ifdef GTK2
>    FLAGS_GTK2=3D$(CFLAGS) $(LDFLAGS) $(EXTLIBS) $(shell $(PKG_CONFIG) --l=
ibs --cflags gtk+-2.0 2>/dev/null)
>    $(call feature_check,gtk2)
>    ifneq ($(feature-gtk2), 1)
> -    msg :=3D $(warning GTK2 not found, disables GTK2 support. Please ins=
tall gtk2-devel or libgtk2.0-dev);
> +    $(warning GTK2 not found, disables GTK2 support. Please install gtk2=
-devel or libgtk2.0-dev)
>      NO_GTK2 :=3D 1
>    else
>      $(call feature_check,gtk2-infobar)
> @@ -854,7 +854,7 @@ else
>    ifneq ($(feature-libperl), 1)
>      CFLAGS +=3D -DNO_LIBPERL
>      NO_LIBPERL :=3D 1
> -    msg :=3D $(warning Missing perl devel files. Disabling perl scriptin=
g support, please install perl-ExtUtils-Embed/libperl-dev);
> +    $(warning Missing perl devel files. Disabling perl scripting support=
, please install perl-ExtUtils-Embed/libperl-dev)
>    else
>      LDFLAGS +=3D $(PERL_EMBED_LDFLAGS)
>      EXTLIBS +=3D $(PERL_EMBED_LIBADD)
> @@ -869,7 +869,7 @@ endif
>  ifeq ($(feature-timerfd), 1)
>    CFLAGS +=3D -DHAVE_TIMERFD_SUPPORT
>  else
> -  msg :=3D $(warning No timerfd support. Disables 'perf kvm stat live');
> +  $(warning No timerfd support. Disables 'perf kvm stat live')
>  endif
>
>  disable-python =3D $(eval $(disable-python_code))
> @@ -903,7 +903,7 @@ else
>             PYTHON_EXTENSION_SUFFIX :=3D $(shell $(PYTHON) -c 'from impor=
tlib import machinery; print(machinery.EXTENSION_SUFFIXES[0])')
>             LANG_BINDINGS +=3D $(obj-perf)python/perf$(PYTHON_EXTENSION_S=
UFFIX)
>          else
> -           msg :=3D $(warning Missing python setuptools, the python bind=
ing won't be built, please install python3-setuptools or equivalent);
> +           $(warning Missing python setuptools, the python binding won't=
 be built, please install python3-setuptools or equivalent)
>           endif
>           CFLAGS +=3D -DHAVE_LIBPYTHON_SUPPORT
>           $(call detected,CONFIG_LIBPYTHON)
> @@ -962,7 +962,7 @@ ifdef BUILD_NONDISTRO
>    ifeq ($(feature-libbfd-buildid), 1)
>      CFLAGS +=3D -DHAVE_LIBBFD_BUILDID_SUPPORT
>    else
> -    msg :=3D $(warning Old version of libbfd/binutils things like PE exe=
cutable profiling will not be available);
> +    $(warning Old version of libbfd/binutils things like PE executable p=
rofiling will not be available)
>    endif
>  endif
>
> @@ -994,7 +994,7 @@ ifndef NO_LZMA
>      EXTLIBS +=3D -llzma
>      $(call detected,CONFIG_LZMA)
>    else
> -    msg :=3D $(warning No liblzma found, disables xz kernel module decom=
pression, please install xz-devel/liblzma-dev);
> +    $(warning No liblzma found, disables xz kernel module decompression,=
 please install xz-devel/liblzma-dev)
>      NO_LZMA :=3D 1
>    endif
>  endif
> @@ -1007,7 +1007,7 @@ ifndef NO_LIBZSTD
>      EXTLIBS +=3D -lzstd
>      $(call detected,CONFIG_ZSTD)
>    else
> -    msg :=3D $(warning No libzstd found, disables trace compression, ple=
ase install libzstd-dev[el] and/or set LIBZSTD_DIR);
> +    $(warning No libzstd found, disables trace compression, please insta=
ll libzstd-dev[el] and/or set LIBZSTD_DIR)
>      NO_LIBZSTD :=3D 1
>    endif
>  endif
> @@ -1018,7 +1018,7 @@ ifndef NO_LIBCAP
>      EXTLIBS +=3D -lcap
>      $(call detected,CONFIG_LIBCAP)
>    else
> -    msg :=3D $(warning No libcap found, disables capability support, ple=
ase install libcap-devel/libcap-dev);
> +    $(warning No libcap found, disables capability support, please insta=
ll libcap-devel/libcap-dev)
>      NO_LIBCAP :=3D 1
>    endif
>  endif
> @@ -1031,11 +1031,11 @@ endif
>
>  ifndef NO_LIBNUMA
>    ifeq ($(feature-libnuma), 0)
> -    msg :=3D $(warning No numa.h found, disables 'perf bench numa mem' b=
enchmark, please install numactl-devel/libnuma-devel/libnuma-dev);
> +    $(warning No numa.h found, disables 'perf bench numa mem' benchmark,=
 please install numactl-devel/libnuma-devel/libnuma-dev)
>      NO_LIBNUMA :=3D 1
>    else
>      ifeq ($(feature-numa_num_possible_cpus), 0)
> -      msg :=3D $(warning Old numa library found, disables 'perf bench nu=
ma mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev >=
=3D 2.0.8);
> +      $(warning Old numa library found, disables 'perf bench numa mem' b=
enchmark, please install numactl-devel/libnuma-devel/libnuma-dev >=3D 2.0.8=
)
>        NO_LIBNUMA :=3D 1
>      else
>        CFLAGS +=3D -DHAVE_LIBNUMA_SUPPORT
> @@ -1090,14 +1090,14 @@ ifndef NO_LIBBABELTRACE
>      EXTLIBS +=3D -lbabeltrace-ctf
>      $(call detected,CONFIG_LIBBABELTRACE)
>    else
> -    msg :=3D $(warning No libbabeltrace found, disables 'perf data' CTF =
format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev)=
;
> +    $(warning No libbabeltrace found, disables 'perf data' CTF format su=
pport, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev)
>    endif
>  endif
>
>  ifndef NO_AUXTRACE
>    ifeq ($(SRCARCH),x86)
>      ifeq ($(feature-get_cpuid), 0)
> -      msg :=3D $(warning Your gcc lacks the __get_cpuid() builtin, disab=
les support for auxtrace/Intel PT, please install a newer gcc);
> +      $(warning Your gcc lacks the __get_cpuid() builtin, disables suppo=
rt for auxtrace/Intel PT, please install a newer gcc)
>        NO_AUXTRACE :=3D 1
>      endif
>    endif
> @@ -1155,7 +1155,7 @@ ifndef NO_LIBPFM4
>      ASCIIDOC_EXTRA =3D -aHAVE_LIBPFM=3D1
>      $(call detected,CONFIG_LIBPFM4)
>    else
> -    msg :=3D $(warning libpfm4 not found, disables libpfm4 support. Plea=
se install libpfm4-dev);
> +    $(warning libpfm4 not found, disables libpfm4 support. Please instal=
l libpfm4-dev)
>    endif
>  endif
>
> @@ -1173,7 +1173,7 @@ ifneq ($(NO_LIBTRACEEVENT),1)
>      CFLAGS +=3D -DLIBTRACEEVENT_VERSION=3D$(LIBTRACEEVENT_VERSION_CPP)
>      $(call detected,CONFIG_LIBTRACEEVENT)
>    else
> -    dummy :=3D $(error ERROR: libtraceevent is missing. Please install l=
ibtraceevent-dev/libtraceevent-devel or build with NO_LIBTRACEEVENT=3D1)
> +    $(error ERROR: libtraceevent is missing. Please install libtraceeven=
t-dev/libtraceevent-devel or build with NO_LIBTRACEEVENT=3D1)
>    endif
>
>    $(call feature_check,libtracefs)
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index f8774a9b1377..3707fed8dfde 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -482,7 +482,7 @@ drm_hdr_dir :=3D $(srctree)/tools/include/uapi/drm
>  drm_ioctl_tbl :=3D $(srctree)/tools/perf/trace/beauty/drm_ioctl.sh
>
>  # Create output directory if not already present
> -_dummy :=3D $(shell [ -d '$(beauty_ioctl_outdir)' ] || mkdir -p '$(beaut=
y_ioctl_outdir)')
> +$(shell [ -d '$(beauty_ioctl_outdir)' ] || mkdir -p '$(beauty_ioctl_outd=
ir)')
>
>  $(drm_ioctl_array): $(drm_hdr_dir)/drm.h $(drm_hdr_dir)/i915_drm.h $(drm=
_ioctl_tbl)
>         $(Q)$(SHELL) '$(drm_ioctl_tbl)' $(drm_hdr_dir) > $@
> @@ -672,7 +672,7 @@ tests-coresight-targets-clean:
>  all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_P=
ROGRAMS) tests-coresight-targets
>
>  # Create python binding output directory if not already present
> -_dummy :=3D $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)pytho=
n')
> +$(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
>
>  $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): $(PYTHON_EXT_SRCS) $(PYT=
HON_EXT_DEPS) $(LIBPERF) $(LIBSUBCMD)
>         $(QUIET_GEN)LDSHARED=3D"$(CC) -pthread -shared" \
> diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makef=
ile
> index fab3095fb5d0..5735ed4479bb 100644
> --- a/tools/perf/arch/arm64/Makefile
> +++ b/tools/perf/arch/arm64/Makefile
> @@ -18,7 +18,7 @@ sysprf :=3D $(srctree)/tools/perf/arch/arm64/entry/sysc=
alls/
>  systbl :=3D $(sysprf)/mksyscalltbl
>
>  # Create output directory if not already present
> -_dummy :=3D $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
> +$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
>
>  $(header): $(sysdef) $(systbl)
>         $(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(incpath) $(sysdef)=
 > $@
> diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loongar=
ch/Makefile
> index c392e7af4743..3992a67a87d9 100644
> --- a/tools/perf/arch/loongarch/Makefile
> +++ b/tools/perf/arch/loongarch/Makefile
> @@ -17,7 +17,7 @@ sysprf :=3D $(srctree)/tools/perf/arch/loongarch/entry/=
syscalls/
>  systbl :=3D $(sysprf)/mksyscalltbl
>
>  # Create output directory if not already present
> -_dummy :=3D $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
> +$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
>
>  $(header): $(sysdef) $(systbl)
>         $(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(incpath) $(sysdef)=
 > $@
> diff --git a/tools/perf/arch/mips/Makefile b/tools/perf/arch/mips/Makefil=
e
> index 8bc09072e3d6..cd0b011b3be5 100644
> --- a/tools/perf/arch/mips/Makefile
> +++ b/tools/perf/arch/mips/Makefile
> @@ -11,7 +11,7 @@ sysdef :=3D $(sysprf)/syscall_n64.tbl
>  systbl :=3D $(sysprf)/mksyscalltbl
>
>  # Create output directory if not already present
> -_dummy :=3D $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
> +$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
>
>  $(header): $(sysdef) $(systbl)
>         $(Q)$(SHELL) '$(systbl)' $(sysdef) > $@
> diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/M=
akefile
> index 840ea0e59287..bf6d323574f6 100644
> --- a/tools/perf/arch/powerpc/Makefile
> +++ b/tools/perf/arch/powerpc/Makefile
> @@ -19,7 +19,7 @@ sysdef :=3D $(sysprf)/syscall.tbl
>  systbl :=3D $(sysprf)/mksyscalltbl
>
>  # Create output directory if not already present
> -_dummy :=3D $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
> +$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
>
>  $(header64): $(sysdef) $(systbl)
>         $(Q)$(SHELL) '$(systbl)' '64' $(sysdef) > $@
> diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefil=
e
> index 74bffbea03e2..56994e63b43a 100644
> --- a/tools/perf/arch/s390/Makefile
> +++ b/tools/perf/arch/s390/Makefile
> @@ -17,7 +17,7 @@ sysdef :=3D $(sysprf)/syscall.tbl
>  systbl :=3D $(sysprf)/mksyscalltbl
>
>  # Create output directory if not already present
> -_dummy :=3D $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
> +$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
>
>  $(header): $(sysdef) $(systbl)
>         $(Q)$(SHELL) '$(systbl)' $(sysdef) > $@
> diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
> index 5a9f9a7bf07d..8952e00f9b60 100644
> --- a/tools/perf/arch/x86/Makefile
> +++ b/tools/perf/arch/x86/Makefile
> @@ -17,7 +17,7 @@ sys       :=3D $(srctree)/tools/perf/arch/x86/entry/sys=
calls
>  systbl    :=3D $(sys)/syscalltbl.sh
>
>  # Create output directory if not already present
> -_dummy :=3D $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
> +$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
>
>  $(header): $(sys)/syscall_64.tbl $(systbl)
>         $(Q)$(SHELL) '$(systbl)' $(sys)/syscall_64.tbl 'x86_64' > $@
> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.incl=
ude
> index 6fba29f3222d..0aa4005017c7 100644
> --- a/tools/scripts/Makefile.include
> +++ b/tools/scripts/Makefile.include
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  ifneq ($(O),)
>  ifeq ($(origin O), command line)
> -       dummy :=3D $(if $(shell cd $(PWD); test -d $(O) || echo $(O)),$(e=
rror O=3D$(O) does not exist),)
> +        $(if $(shell cd $(PWD); test -d $(O) || echo $(O)),$(error O=3D$=
(O) does not exist),)
>         ABSOLUTE_O :=3D $(shell cd $(PWD); cd $(O) ; pwd)
>         OUTPUT :=3D $(ABSOLUTE_O)/$(if $(subdir),$(subdir)/)
>         COMMAND_O :=3D O=3D$(ABSOLUTE_O)
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftes=
ts/kvm/Makefile
> index 492e937fab00..14684aeb4b55 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -285,7 +285,7 @@ EXTRA_CLEAN +=3D $(GEN_HDRS) \
>                $(TEST_GEN_OBJ) \
>                cscope.*
>
> -x :=3D $(shell mkdir -p $(sort $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
> +$(shell mkdir -p $(sort $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
>  $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c $(GEN_HDRS)
>         $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
>
> @@ -298,7 +298,7 @@ $(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(GEN_HDRS)
>  $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
>         $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -=
o $@
>
> -x :=3D $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
> +$(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
>  $(SPLIT_TESTS_OBJS): $(GEN_HDRS)
>  $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
>  $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
> --
> 2.40.1
>

