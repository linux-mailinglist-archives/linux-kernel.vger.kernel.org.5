Return-Path: <linux-kernel+bounces-145962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 261FB8A5D97
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96B71F22C05
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DCE157A45;
	Mon, 15 Apr 2024 22:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3Xdl/3B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325CF25601;
	Mon, 15 Apr 2024 22:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713218789; cv=none; b=dyrSPZYZ0idggUCwdQSaf0R3CisfSrie7uk0Tiu83/z00m1AcVvh7tiYVfN2yEgaDG9j2s8h/q2hJQ8XlfeN3cAWW+VEnlM4zADDEKVL3LWEym2AUcSQBbdvsiy9Xjp5Me6RoSXuE0TnlbreuQcl/YbtyA6mx8+xaxSfZdfliXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713218789; c=relaxed/simple;
	bh=OicLi7OIUIM8R5E7YLSXlX9bsxcGZ0l3ZMvEOcBn8MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG3QanZXoRe1BLyZ4ugSkUMjHF9RWoxMGWiFgv66WPFaLQCdWECUeBXD/02K0Q8WG71ZYicNrwu9DkJWq6mnvTK1SZvh/r4Ks6fUP5ja4jAW2oY6xoHxjYLxJlX3X/9h46saVTcIk8nFFIyERgOGUTN3enu61y6bTvdZOLJm9yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3Xdl/3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B09C113CC;
	Mon, 15 Apr 2024 22:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713218788;
	bh=OicLi7OIUIM8R5E7YLSXlX9bsxcGZ0l3ZMvEOcBn8MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A3Xdl/3BDbRNH9AZ56dL3z76qMGj4skVu3V0hJBQzT7mdqtPHAbWr88C+aelbS1Jy
	 YAiHhf2fltGwn/nXfe2xs9nDsd0UQ40/Q9HnHxzRDWhPxu3p59SxI86xJFHDZeW/T/
	 IMGSdT0M5eJPrv7IzY7VCvuAF87yPUZMgbs+UlqZyLUFJY9rEa1cQSFSI5T3y/xlOX
	 4eWzEd9URwma4zQkYVv1AwjXGF2+Qn+YFN6VPeO1Bakd4Rx18ZWrhLudWF3BGBUlBH
	 97YHI9vTqA+kZNZHY+FRw3YfFtjAlFymBx894xqrKj0FvnuSVFaetF/HL4Nk1DMtNp
	 ag/8BwcYDbaSg==
Date: Mon, 15 Apr 2024 15:06:26 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Memet Zx <zxce3@gnuweeb.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	LLVM Mailing List <llvm@lists.linux.dev>,
	GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: Compile Error in Linux 6.9-rc4 with Clang 17.0.6
Message-ID: <20240415220626.GA77369@dev-arch.thelio-3990X>
References: <20240415193152.61118-1-zxce3@gnuweeb.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415193152.61118-1-zxce3@gnuweeb.org>

On Tue, Apr 16, 2024 at 02:31:52AM +0700, Memet Zx wrote:
> Hello,
> 
> I am writing to report a compile error that I encountered while
> building the latest Linux kernel (6.9-rc4) with Clang version 17.0.6.
> The error message is as follows:
> 
> ```
>   LD      vmlinux.o
> vmlinux.o: warning: objtool: __svm_vcpu_run+0x13c: BP used as a scratch register
> vmlinux.o: warning: objtool: __svm_sev_es_vcpu_run+0x32: BP used as a scratch register
> vmlinux.o: warning: objtool: ip_vs_protocol_init() falls through to next function __initstub__kmod_ip_vs_rr__969_123_ip_vs_rr_init6()
> vmlinux.o: warning: objtool: .text.jffs2_erase_pending_blocks: unexpected end of section
> vmlinux.o: warning: objtool: .text.ocfs2_validate_and_adjust_move_goal: unexpected end of section
> vmlinux.o: warning: objtool: .text.__ocfs2_move_extents_range: unexpected end of section
> vmlinux.o: warning: objtool: .text.csio_ln_fdmi_rhba_cbfn: unexpected end of section
> vmlinux.o: warning: objtool: .text.jme_check_link: unexpected end of section
> vmlinux.o: warning: objtool: .text.vhci_coredump_hdr: unexpected end of section
>   OBJCOPY modules.builtin.modinfo
> llvm-objcopy-17: error: SHT_STRTAB string table section [index 1173270] is non-null terminated
> make[5]: *** [scripts/Makefile.vmlinux_o:73: modules.builtin.modinfo] Error 1
> make[4]: *** [Makefile:1141: vmlinux_o] Error 2
> make[3]: *** [debian/rules:74: build-arch] Error 2
> dpkg-buildpackage: error: make -f debian/rules binary subprocess returned exit status 2
> make[2]: *** [scripts/Makefile.package:121: bindeb-pkg] Error 2
> make[1]: *** [/workspaces/greentea/linux/Makefile:1541: bindeb-pkg] Error 2
> make: *** [Makefile:240: __sub-make] Error 2
> ```
> 
> The build process was terminated with the above error message.
> I have also noticed several warnings related to objtool,
> which may be related to the issue.
> 
> The compiler version I used:
> 
> ```
> Ubuntu clang version 17.0.6 (++20231208085846+6009708b4367-1~exp1~20231208085949.74)
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
> ```
> 
> The commit I used is:
> 
> ```
> commit 0bbac3facb5d6cc0171c45c9873a2dc96bea9680 (grafted, HEAD -> master, origin/master, origin/HEAD)
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Apr 14 13:38:39 2024 -0700
> 
>     Linux 6.9-rc4
> ```
> 
> And the .config is attached at the end of this email.
> 
> I would appreciate it if you could look into this issue and provide
> a fix or workaround.
> 
> Thank you for your attention to this matter.

Thanks for the report. Unfortunately, I cannot reproduce this with your
configuration on 6.9-rc4 with either kernel.org LLVM 17.0.6 [1] or
Debian LLVM 17.0.6 [2]. Is this completely reproducible on your side? Is
this something that just started happening with the 6.9 cycle? What is
your build command, as I might just be missing something?

[1]: https://mirrors.edge.kernel.org/pub/tools/llvm/
[2]: ++20231208085813+6009708b4367-1~exp1~20231208085906.81, should be
     the same source version and configuration you are using.

Cheers,
Nathan

