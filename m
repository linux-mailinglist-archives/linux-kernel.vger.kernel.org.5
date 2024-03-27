Return-Path: <linux-kernel+bounces-121487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631F588E8BD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94FB31C30164
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B409413C3D7;
	Wed, 27 Mar 2024 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xjdniq+W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E632A13BC25;
	Wed, 27 Mar 2024 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552576; cv=none; b=lU6Ly4AfGGz8YQbEHvkvwzZi4jc5ZDVV/rftP9Fbjq4DjV2h8bWQmEpGM+otDY4uv1Gynt3ie8N1HekB+4MofZIOpyC1ncsgPtN/1Y+DoBfcneON8RnNSa7Qy2HDm6HHsH5kaY8rOoOVeRPkbcSFSJBryyFJG3D19eIFWFjhw4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552576; c=relaxed/simple;
	bh=3mjqSFARTqJWeXDaQOm2tUVu0IHBSuFehHS5Hx4/O2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrUtkw5g/i1HTzLEqUKP1aJZSAXlsje9N4JGEa96dHiVe1DI4JE3+pr9CK/26Qoclrr0W27MMMUHWwXZlDksnWHFmYf9cva6iKfWpD33AmRwLwiTgFuyKgCj3pFinLejdc2Kjxc3AUEYUhpSALUAFbfKwSba36su5WQjQwh5iSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xjdniq+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE84C433C7;
	Wed, 27 Mar 2024 15:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711552575;
	bh=3mjqSFARTqJWeXDaQOm2tUVu0IHBSuFehHS5Hx4/O2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xjdniq+WJyCdYl8RowcIqwQ+T6OKOC/ulCvVN9gyybhgXcn86gpxQbusTXDQ3EY2U
	 l0sJhJymwqZsW+4//00COrtoR+EQjGupyH9/kRDW3LY7ec+/vvm6oWrP3oYHh2EbRu
	 8ovFliBkwALW0cngJy36sVFunwwca1mC+J7VLbtJhZM7CBHzBYinh2Fd4/W9trBrc3
	 1EOJlqIqKEyrWRpt0yogqJlSghIRJ4E8Tptj0GFagIY6OIR4AGTkzQ6kNs+Mo+voGh
	 3jb9txE1vb4iHsWrcRZT44FWAqVPD3+QW+QVADCgWLWJOuPWpNpf5eBwTz0gGWOrbO
	 R3dmQRj6Ct5eA==
Date: Wed, 27 Mar 2024 08:16:13 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: FAILED: Patch "powerpc: xor_vmx: Add '-mhard-float' to CFLAGS"
 failed to apply to 5.10-stable tree
Message-ID: <20240327151613.GA1153323@dev-arch.thelio-3990X>
References: <20240327122007.2835763-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YKLJLOt2Iod++WF+"
Content-Disposition: inline
In-Reply-To: <20240327122007.2835763-1-sashal@kernel.org>


--YKLJLOt2Iod++WF+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2024 at 08:20:07AM -0400, Sasha Levin wrote:
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
..
> ------------------ original commit in Linus's tree ------------------
> 
> From 35f20786c481d5ced9283ff42de5c69b65e5ed13 Mon Sep 17 00:00:00 2001
> From: Nathan Chancellor <nathan@kernel.org>
> Date: Sat, 27 Jan 2024 11:07:43 -0700
> Subject: [PATCH] powerpc: xor_vmx: Add '-mhard-float' to CFLAGS

I have attached a backport that will work for 5.15 and earlier. I think
you worked around this conflict in 5.15 by taking 04e85bbf71c9 but I am
not sure that is a smart idea. I think it might just be better to drop
that dependency and apply this version in 5.15.

Cheers,
Nathan

--YKLJLOt2Iod++WF+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-powerpc-xor_vmx-Add-mhard-float-to-CFLAGS.patch"

From c6cb80d94871cbb4ff151f7eb2586cadeb364ef7 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 27 Jan 2024 11:07:43 -0700
Subject: [PATCH 4.19 to 5.15] powerpc: xor_vmx: Add '-mhard-float' to CFLAGS

commit 35f20786c481d5ced9283ff42de5c69b65e5ed13 upstream.

arch/powerpc/lib/xor_vmx.o is built with '-msoft-float' (from the main
powerpc Makefile) and '-maltivec' (from its CFLAGS), which causes an
error when building with clang after a recent change in main:

  error: option '-msoft-float' cannot be specified with '-maltivec'
  make[6]: *** [scripts/Makefile.build:243: arch/powerpc/lib/xor_vmx.o] Error 1

Explicitly add '-mhard-float' before '-maltivec' in xor_vmx.o's CFLAGS
to override the previous inclusion of '-msoft-float' (as the last option
wins), which matches how other areas of the kernel use '-maltivec', such
as AMDGPU.

Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/1986
Link: https://github.com/llvm/llvm-project/commit/4792f912b232141ecba4cbae538873be3c28556c
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240127-ppc-xor_vmx-drop-msoft-float-v1-1-f24140e81376@kernel.org
[nathan: Fixed conflicts due to lack of 04e85bbf71c9 in older trees]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/powerpc/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 321cab5c3ea0..bd5012aa94e3 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -67,6 +67,6 @@ obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
 obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
 
 obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o xor_vmx_glue.o
-CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec)
+CFLAGS_xor_vmx.o += -mhard-float -maltivec $(call cc-option,-mabi=altivec)
 
 obj-$(CONFIG_PPC64) += $(obj64-y)
-- 
2.44.0


--YKLJLOt2Iod++WF+--

