Return-Path: <linux-kernel+bounces-145998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D27198A5E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887A4284C60
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DF8158D9B;
	Mon, 15 Apr 2024 23:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="WEjfpgX1"
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C078F15887C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.211.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713222996; cv=none; b=u1OjGp4Y0m4PUiCkbt3AG/nddbZ102qK9w1ds7cEgU0vDe55vV0R6uIwFdN53gPaJJ+DCC+na5/FESPJk4lkA22oVeBE5SZtwFNAvv2niiun7544owYYb+yMLEOnfF9pOGu4YEu3vRiA4OTzMyyMHHHLTCtRt2gjmFk+1Srl2JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713222996; c=relaxed/simple;
	bh=cjNzCOCAgp7wk5rP3LcGF3i1psOeuFAFhFvE4h5tBg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mnwS+Rbp6J/4Zhp+Eu5PgCC/POCdZmzRii4eY+xyKgp+0oGvJj+Kc4psiEBMIdx3ChOCEojxtp7hgmHDv8Fwz36jrdp776qOy/Aw2hvWYQGZ+MtdOY3Z+582nxluX4oeg08P8g4H1md9fsTXI/3COkYWgT39o9GA8rlo8E36gpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=WEjfpgX1; arc=none smtp.client-ip=51.81.211.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=default; t=1713222994;
	bh=cjNzCOCAgp7wk5rP3LcGF3i1psOeuFAFhFvE4h5tBg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WEjfpgX1F2yN0XkjeYIL+so1/ETNefmWXraEdqEQsxdDlO2Z9grew7e9HzfUgpuVe
	 LUEMWe4zZQ/N5fxZ0Yau7U8QyKvuF9EplR/Nz6x8W7rsTpo/hyIUWmN0jW9/b2/yDL
	 sy5jgt3xBQ5kixjXqc45T/MHZHv6LINi3oqUuwdj2oMtzNs7k3mBVVCrgKtSajYw44
	 miAMXNsZwS6oVMMM80v4qLuTyTzLc0XdqUHmW8Is07gctAvDZqLP82WwndKU0iPoSH
	 lqYSeH9mZz8M3baKif4GIXquMh1fYfMv1+Q8IQAy9DVYDIn3NrtxPHZOS7ZbHpieFW
	 m42XbkLJU4t2A==
Received: from localhost.localdomain (unknown [182.253.126.243])
	by gnuweeb.org (Postfix) with ESMTPSA id 0E3B624AE2E;
	Tue, 16 Apr 2024 06:16:30 +0700 (WIB)
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>,
	Memet Zx <zxce3@gnuweeb.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	LLVM Mailing List <llvm@lists.linux.dev>,
	GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: Compile Error in Linux 6.9-rc4 with Clang 17.0.6
Date: Tue, 16 Apr 2024 06:16:22 +0700
Message-Id: <555ac4427590d16c@cgk003-biznet-home.gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415220626.GA77369@dev-arch.thelio-3990X>
References: <20240415193152.61118-1-zxce3@gnuweeb.org> <20240415220626.GA77369@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Apr 2024 15:06:26 -0700, Nathan Chancellor wrote:
> Thanks for the report. Unfortunately, I cannot reproduce this with your
> configuration on 6.9-rc4 with either kernel.org LLVM 17.0.6 [1] or
> Debian LLVM 17.0.6 [2]. Is this completely reproducible on your side? Is
> this something that just started happening with the 6.9 cycle? What is
> your build command, as I might just be missing something?
> 
> [1]: https://mirrors.edge.kernel.org/pub/tools/llvm/
> [2]: ++20231208085813+6009708b4367-1~exp1~20231208085906.81, should be
>      the same source version and configuration you are using.

Hi,

Thank you for your response!

I am here to respond on behalf of Memet Zx.

I was following Memet's build before he reported this issue. I tried
to reproduce the error on my server, but I couldn't reproduce it as
well. It seems the error is specific to Memet's environment.

FWIW, my build commands are as follows:
```
  wget https://apt.llvm.org/llvm.sh -O /tmp/llvm.sh;
  sudo bash /tmp/llvm.sh 17;
  sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-17 400;
  sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-17 400;

  export LLVM=-17;
  export LLVM_IAS=1;

  # Fill .config file with Memet's config file.

  make -j$(nproc) olddefconfig;
  make -j$(nproc) bindeb-pkg;
```

The steps above are the same as Memet's, but I didn't face the issue.
So yeah, it seems to be specific to Memet's environment. I'll discuss
this further with Memet off-list.

My server survived in the OBJCOPY step, unlike Memet's, and it
finished the debian packaging without fatal errors (despite it shows
warnings):

```
    GEN     .tmp_initcalls.lds
    LD      vmlinux.o
  ld.lld-17: warning: lib/maple_tree.c:4162:0: stack frame size (1040) exceeds limit (1024) in function 'mas_wr_modify'
  ld.lld-17: warning: arch/x86/kvm/hyperv.c:2002:0: stack frame size (1320) exceeds limit (1024) in function 'kvm_hv_flush_tlb'
  ld.lld-17: warning: drivers/infiniband/sw/siw/siw_qp_tx.c:1019:0: stack frame size (1192) exceeds limit (1024) in function 'siw_qp_sq_process'
  ld.lld-17: warning: fs/select.c:976:0: stack frame size (1080) exceeds limit (1024) in function 'do_sys_poll'
  ld.lld-17: warning: drivers/net/wireless/ath/ath9k/ar9003_paprd.c:918:0: stack frame size (1064) exceeds limit (1024) in function 'ar9003_paprd_create_curve'
  ld.lld-17: warning: drivers/net/wireguard/allowedips.c:259:0: stack frame size (1128) exceeds limit (1024) in function 'wg_allowedips_free'
  ld.lld-17: warning: drivers/net/wireguard/allowedips.c:57:0: stack frame size (1080) exceeds limit (1024) in function 'root_free_rcu'
  ld.lld-17: warning: drivers/gpu/drm/radeon/radeon_cs.c:670:0: stack frame size (1152) exceeds limit (1024) in function 'radeon_cs_ioctl'
  ld.lld-17: warning: drivers/edac/sb_edac.c:3078:0: stack frame size (1032) exceeds limit (1024) in function 'sbridge_mce_output_error'
  ld.lld-17: warning: drivers/crypto/ccp/ccp-ops.c:633:0: stack frame size (1032) exceeds limit (1024) in function 'ccp_run_aes_gcm_cmd'
  ld.lld-17: warning: drivers/virtio/virtio_balloon.c:493:0: stack frame size (1064) exceeds limit (1024) in function 'update_balloon_stats_func'
  ld.lld-17: warning: drivers/virtio/virtio_balloon.c:530:0: stack frame size (1224) exceeds limit (1024) in function 'init_vqs'
  ld.lld-17: warning: lib/zstd/compress/huf_compress.c:219:0: stack frame size (1336) exceeds limit (1024) in function 'HUF_readCTable'
  ld.lld-17: warning: drivers/xen/gntdev.c:991:0: stack frame size (1048) exceeds limit (1024) in function 'gntdev_ioctl'
  ld.lld-17: warning: drivers/mtd/nftlcore.c:675:0: stack frame size (1064) exceeds limit (1024) in function 'nftl_writeblock'
  vmlinux.o: warning: objtool: __svm_vcpu_run+0x13c: BP used as a scratch register
  vmlinux.o: warning: objtool: __svm_sev_es_vcpu_run+0x32: BP used as a scratch register
  vmlinux.o: warning: objtool: ip_vs_protocol_init() falls through to next function __initstub__kmod_ip_vs_rr__969_123_ip_vs_rr_init6()
  vmlinux.o: warning: objtool: .text.jffs2_erase_pending_blocks: unexpected end of section
  vmlinux.o: warning: objtool: .text.ocfs2_validate_and_adjust_move_goal: unexpected end of section
  vmlinux.o: warning: objtool: .text.__ocfs2_move_extents_range: unexpected end of section
  vmlinux.o: warning: objtool: .text.csio_ln_fdmi_rhba_cbfn: unexpected end of section
  vmlinux.o: warning: objtool: .text.jme_check_link: unexpected end of section
  vmlinux.o: warning: objtool: .text.vhci_coredump_hdr: unexpected end of section
    OBJCOPY modules.builtin.modinfo
    GEN     modules.builtin
    MODPOST vmlinux.symvers
    UPD     include/generated/utsversion.h
    CC      init/version-timestamp.o
    LD      .tmp_vmlinux.kallsyms1
    NM      .tmp_vmlinux.kallsyms1.syms
    KSYMS   .tmp_vmlinux.kallsyms1.S
    AS      .tmp_vmlinux.kallsyms1.S
    LD      .tmp_vmlinux.kallsyms2
    NM      .tmp_vmlinux.kallsyms2.syms
    KSYMS   .tmp_vmlinux.kallsyms2.S
    AS      .tmp_vmlinux.kallsyms2.S
    LD      vmlinux
```

We will send a follow up if we find that it's related to LLVM. But for
now let's assume something is wrong with Memet's server environment.

Thank you!

-- 
Ammar Faizi

