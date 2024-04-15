Return-Path: <linux-kernel+bounces-145693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D94988A599B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C551F22E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67A813A86A;
	Mon, 15 Apr 2024 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kw3L+7A8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8D8248E;
	Mon, 15 Apr 2024 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713204877; cv=none; b=Ia8Yxcfb4SZBOUPe/6RMaAzQftrcw5M6nrRdIcdtj8rAXNyNriic3l0rElSh91ut58qCStoTV4PDDAUuV1VMjaBhthScDkSScsLTixb6ZzrjcXOCt+tAz4Wm7cjmSaJnJyAYKDLINzSOqEG3L38aI3s0B9haom5th/mgGDCDF2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713204877; c=relaxed/simple;
	bh=g2Lpo8FKduyQu73LiNi2mlkrNK6J/F4psawHqBenncU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctZ4rb0N53JinCfRFM79p/F7TXo+7D1wJ2dKpaFPf9IceYkv+l3CWqP4y+fIj+r/m8JBMvyXEzqgSUR3+o4YLLSZlCkT/AGuzokGCOX30x5Fnp5DualsMQl6+uHx6lYo6ZEvhxs3Q2gYH594CB8sJgTGsTsC0GMY+IDZcPLj6mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kw3L+7A8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F3BC113CC;
	Mon, 15 Apr 2024 18:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713204877;
	bh=g2Lpo8FKduyQu73LiNi2mlkrNK6J/F4psawHqBenncU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kw3L+7A8tCUQ4PitEt6DYpmVWFLBbnnV+XHvdKBDSwsOoIty53YMTQ8enjMSX+Yzv
	 O8C5XY1bG8kHpwW01eGr2GtwQvOi1Gf3PRkgAVolPNL0VaRacmEiE1nEEPr3N29w9r
	 Jh4G9OgJjXleXoPMy0ZaCND9eKic08jroalq/ijIDnixIY/r74eSlWhra0BverB/Iw
	 OS2Z1CeyioCmSdTxJ1NQvFaBQW/Co8ThCIYKyQMs9DheVtuf0TfFemPlVe2cg4arZy
	 NwJ/0w10NyiveoMqo82CsTH8BF2xMZ9KFrl9ylTa0HJ4z4/w5wz4k22TMssM0fioeY
	 wjk41jjnig5vw==
Date: Mon, 15 Apr 2024 11:14:34 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Sami Tolvanen <samitolvanen@google.com>
Subject: Re: WARNING: modpost: vmlinux: section mismatch in reference:
 __apply_fineibt+0x566 (section: .text) -> poison_endbr (section: .init.text)
Message-ID: <20240415181434.GA3926358@dev-arch.thelio-3990X>
References: <202404151042.vATlNGmU-lkp@intel.com>
 <202404151010.75DC9B8@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404151010.75DC9B8@keescook>

On Mon, Apr 15, 2024 at 10:14:03AM -0700, Kees Cook wrote:
> On Mon, Apr 15, 2024 at 10:15:48AM +0800, kernel test robot wrote:
> > Hi Peter,
> > 
> > FYI, the error/warning still remains.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   0bbac3facb5d6cc0171c45c9873a2dc96bea9680
> > commit: 04505bbbbb15da950ea0239e328a76a3ad2376e0 x86/fineibt: Poison ENDBR at +0
> > date:   9 months ago
> > config: x86_64-buildonly-randconfig-001-20240415 (https://download.01.org/0day-ci/archive/20240415/202404151042.vATlNGmU-lkp@intel.com/config)
> > compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240415/202404151042.vATlNGmU-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202404151042.vATlNGmU-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > 
> > WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
> > WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x12e (section: .text) -> text_poke_early (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x1f2 (section: .text) -> text_poke_early (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x2e6 (section: .text) -> text_poke_early (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x381 (section: .text) -> text_poke_early (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x3a4 (section: .text) -> text_poke_early (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x44d (section: .text) -> text_poke_early (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x50d (section: .text) -> text_poke_early (section: .init.text)
> > WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x532 (section: .text) -> text_poke_early (section: .init.text)
> > >> WARNING: modpost: vmlinux: section mismatch in reference: __apply_fineibt+0x566 (section: .text) -> poison_endbr (section: .init.text)
> 
> test_poke_early() already marked __init_or_module, so shouldn't these
> warnings not happen? (I assume the same is for true poison_endbr)

Hmmm, how so? __init_or_module is __init when CONFIG_MODULES is not set
(which is true for this configuration), which means text_poke_early() is
__init while __apply_fineibt() is not.

$ curl -LSs https://download.01.org/0day-ci/archive/20240415/202404151042.vATlNGmU-lkp@intel.com/config | rg CONFIG_MODULES
CONFIG_MODULES_USE_ELF_RELA=y
# CONFIG_MODULES is not set

Looking further into it though, I think that marking apply_fineibt() and
__apply_fineibt() as __init_or_module as well would resolve this?

__apply_fineibt() is called from two places: alternative_instructions()
(which is __init) and apply_fineibt(). Looking at apply_fineibt(), it is
only called from module_finalize() in arch/x86/kernel/module.c, which is
only included when CONFIG_MODULES=y. As a result, __apply_fineibt() is
only ever called from __init code when CONFIG_MODULES is not set but it
is called from module code so it should not be discarded with
CONFIG_MODULES=y, as it currently is.

In other words, the following diff works for me.

Cheers,
Nathan

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 45a280f2161c..1f6a29048a95 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1262,8 +1262,9 @@ static int cfi_rewrite_callers(s32 *start, s32 *end)
 	return 0;
 }
 
-static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
-			    s32 *start_cfi, s32 *end_cfi, bool builtin)
+static __init_or_module void __apply_fineibt(s32 *start_retpoline,
+					     s32 *end_retpoline, s32 *start_cfi,
+					     s32 *end_cfi, bool builtin)
 {
 	int ret;
 
@@ -1391,8 +1392,8 @@ static void poison_cfi(void *addr) { }
 
 #endif
 
-void apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
-		   s32 *start_cfi, s32 *end_cfi)
+__init_or_module void apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
+				    s32 *start_cfi, s32 *end_cfi)
 {
 	return __apply_fineibt(start_retpoline, end_retpoline,
 			       start_cfi, end_cfi,

