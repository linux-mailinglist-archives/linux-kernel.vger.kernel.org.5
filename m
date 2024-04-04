Return-Path: <linux-kernel+bounces-132122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B418E898FEB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA1E1F24DEA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D075713B280;
	Thu,  4 Apr 2024 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=o2.pl header.i=@o2.pl header.b="bL/Jy/KE"
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF0C21353
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.222.135.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265135; cv=none; b=f2O4HeoVTqZq6Kbsuo3zTIGhpg8QZlRwQUmcFaBHJx/dT2EabEbS2+1y1jbc3W4ZGdxTPPsscL+8HkhQn4UidavH1tolxExECk/P70v7dpN5YPPmFkNlTs1113KEnwxmHoMFXWZYbg5q2FZ7cFyvds099ePEGrQiQpTEL/5aX5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265135; c=relaxed/simple;
	bh=qSHrbVUuH3RpnStcVOAX85alNRhQ+L7vmT9vMlOfAHU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=IPje6v5S7AFW9cbKY2tthDDoPL4uAwWqroDDevhVjBpIkfZSB2zDHO1rbXitSI28yPIsnFYeuOghEnNufs0rgZabMmynnn3HPVFcRJpg8ciEZHrEoEs7b94zQpigMwwhTdAEvPNa3MuQI/nyeIiwEpnidaD1RJwtfSU4lviCY+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl; spf=pass smtp.mailfrom=o2.pl; dkim=pass (1024-bit key) header.d=o2.pl header.i=@o2.pl header.b=bL/Jy/KE; arc=none smtp.client-ip=193.222.135.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=o2.pl
Received: (wp-smtpd smtp.tlen.pl 33231 invoked from network); 4 Apr 2024 23:05:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1712264729; bh=qSHrbVUuH3RpnStcVOAX85alNRhQ+L7vmT9vMlOfAHU=;
          h=To:Cc:From:Subject;
          b=bL/Jy/KEcj9Zdg9691OjrK4INk0XhbwBO0nk/5ndwh2FGEk+uGFZyZyjKEzAlos8a
           +TN1uQ1xvVplh3gAOCyjhuz+EXyhWNbnOjIAvIuj2LkS8GaV/9iXQKCTvUmYIMNHJU
           e/Zp/rL0Zu8ahswz7R/e8D8ftjmn12ijHAw425ew=
Received: from aaer216.neoplus.adsl.tpnet.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[83.4.121.216])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <bp@alien8.de>; 4 Apr 2024 23:05:29 +0200
Message-ID: <658b2641-1f06-4680-8bf9-87b64ad5241d@o2.pl>
Date: Thu, 4 Apr 2024 23:05:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: "Borislav Petkov (AMD)" <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Subject: [REGRESSION] Build failure on 6.9-rc2 with "x86/bugs: Fix the SRSO
 mitigation on Zen3/4"
Autocrypt: addr=mat.jonczyk@o2.pl; keydata=
 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
 TANkZ3QqXNX2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 40027ac6927ec68a11edc0238d083472
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [8cOV]                               

Hello,

The v6.9-rc2 kernel fails to build without CONFIG_MITIGATION_SRSO but
with most other mitigations in place (incl. CONFIG_MITIGATION_UNRET_ENTRY):

[...]
      LD      vmlinux.o
      OBJCOPY modules.builtin.modinfo
      GEN     modules.builtin
      GEN     .vmlinux.objs
      MODPOST Module.symvers
    ERROR: modpost: "srso_alias_untrain_ret" [arch/x86/kvm/kvm-amd.ko] undefined!
    make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Błąd 1
    make[1]: *** [/media/1T-data/linux/linux-6.9-rc2/Makefile:1871: modpost] Błąd 2
    make: *** [Makefile:240: __sub-make] Błąd 2
    Command exited with non-zero status 2

An investigation pointed to the following commit:

commit 4535e1a4174c4111d92c5a9a21e542d232e0fcaa
Author: Borislav Petkov (AMD) <bp@alien8.de>
Date:   Thu Mar 28 13:59:05 2024 +0100

    x86/bugs: Fix the SRSO mitigation on Zen3/4
    
    The original version of the mitigation would patch in the calls to the
    untraining routines directly.  That is, the alternative() in UNTRAIN_RET
    will patch in the CALL to srso_alias_untrain_ret() directly.
    
    However, even if commit e7c25c441e9e ("x86/cpu: Cleanup the untrain
    mess") meant well in trying to clean up the situation, due to micro-
    architectural reasons, the untraining routine srso_alias_untrain_ret()
    must be the target of a CALL instruction and not of a JMP instruction as
    it is done now.
    
    Reshuffle the alternative macros to accomplish that.
    
    Fixes: e7c25c441e9e ("x86/cpu: Cleanup the untrain mess")
    Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
    Reviewed-by: Ingo Molnar <mingo@kernel.org>
    Cc: stable@kernel.org
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

After reverting it, the kernel builds successfully.

Config extract:

    CONFIG_CC_HAS_RETURN_THUNK=y
    CONFIG_CC_HAS_ENTRY_PADDING=y
    CONFIG_FUNCTION_PADDING_CFI=11
    CONFIG_FUNCTION_PADDING_BYTES=16
    CONFIG_CALL_PADDING=y
    CONFIG_HAVE_CALL_THUNKS=y
    CONFIG_CALL_THUNKS=y
    CONFIG_PREFIX_SYMBOLS=y
    CONFIG_SPECULATION_MITIGATIONS=y
    CONFIG_MITIGATION_PAGE_TABLE_ISOLATION=y
    CONFIG_MITIGATION_RETPOLINE=y
    CONFIG_MITIGATION_RETHUNK=y
    CONFIG_MITIGATION_UNRET_ENTRY=y
    CONFIG_MITIGATION_CALL_DEPTH_TRACKING=y
    # CONFIG_CALL_THUNKS_DEBUG is not set
    CONFIG_MITIGATION_IBPB_ENTRY=y
    CONFIG_MITIGATION_IBRS_ENTRY=y
    # CONFIG_MITIGATION_SRSO is not set
    # CONFIG_MITIGATION_GDS_FORCE is not set
    # CONFIG_MITIGATION_RFDS is not set
    CONFIG_ARCH_HAS_ADD_PAGES=y

OS: Ubuntu 20.04, GCC 9.4.0

To me, it looks that with the patch applied, arch/x86/include/asm/nospec-branch.h uses
srso_alias_untrain_ret when CONFIG_MITIGATION_UNRET_ENTRY=y
even though CONFIG_MITIGATION_SRSO=n.

Greetings,

Mateusz


