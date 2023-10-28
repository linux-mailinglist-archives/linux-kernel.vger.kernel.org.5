Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C2C7DA73A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 15:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjJ1N2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 09:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1N2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 09:28:47 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A711CC0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 06:28:45 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507a98517f3so4158582e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698499724; x=1699104524; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/mkG76O5/U+/SehUGbHiNCbyeL7D+anBRyG+yd5ZEiQ=;
        b=VNwohSIgr2oHuhVrOE5RYOqTR/zSwvnIqJ/7pkOxDk2oa1mNuzUnmOk7bYoI1GEG9h
         30TAkv/aXjIW6Yjru7JskkSoBCn+z9yncD51x6fzmqbOZoeCI5tdcZohUv++gbTcBpVY
         bD7rMVNSEnCr/5hlNH2ikVz2AajE7meerHtJ79h0VBWUJASbxPNJiHcMiIG1SpjizqXC
         Q4cqWJmOQYjcw9+As5ijFcQXTMPN+1IAxVjExZkEAU9RNiMCurfwWx8WSI4HieXhrje6
         /Jc0dt3YZhYbjpeXmWy95bcwKYqki0JXYnLDf0N803IQ37ZatSXrcrrAB+kbFmxu2G0a
         yyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698499724; x=1699104524;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mkG76O5/U+/SehUGbHiNCbyeL7D+anBRyG+yd5ZEiQ=;
        b=CRqbs4cs4yIqs8arLZZxlavkdgbtRrMEjYmdEDLyib5ZdGHowfUXgSRhwTjSXg37Yl
         MccLuUc+p3BQo9Uky91Oml1e1o9yerbdqnNdrt13WZ0Lkoi33029MJyvl/AXNNdjUTUq
         dxZRbIk/EIc0273Ow/tz9806pYdtXXrRVXLuyH305rXZK5O9IUu5m+PVfzuUV41m4+Or
         Wzg66nKNBgyNwVEota6Vy9Go6/J8lu20rLnVv122MupDHHTdbkQlz8Iwup938xNJfeml
         jHZeVYMoh4ofsGzcSILDBfV9wgA0Ecemq0F4aPw5d0go63P2mNK3exAScLnty4odZ0TC
         kn+A==
X-Gm-Message-State: AOJu0Yx+Nk/UPT6WwWOJEqeZ8gi99K3ZLWEgNlnXuIGC1qK4nbTgRk+B
        K0KXVOtOKKR8ACNDqusrICs=
X-Google-Smtp-Source: AGHT+IGzuRyj9hWKy9PdPNOmNKSqdyRi0YhGkg1OVLpfmSzNL/QVIhVQCWlqrU0d8hpDSnaLA7lH3Q==
X-Received: by 2002:ac2:5ec3:0:b0:507:a16d:6699 with SMTP id d3-20020ac25ec3000000b00507a16d6699mr3341963lfq.13.1698499723670;
        Sat, 28 Oct 2023 06:28:43 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id 22-20020a508e56000000b00542db304680sm1023829edx.63.2023.10.28.06.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 06:28:42 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 28 Oct 2023 15:28:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [GIT PULL] x86/build change for v6.7
Message-ID: <ZT0MiAYT40md4uIS@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/build git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2023-10-28

   # HEAD: 70c8dc9104275037a39ab0b2a4ed6eaacac39e32 x86/defconfig: Enable CONFIG_DEBUG_ENTRY=y

Enable CONFIG_DEBUG_ENTRY=y in the x86 defconfigs.

 Thanks,

	Ingo

------------------>
Ingo Molnar (1):
      x86/defconfig: Enable CONFIG_DEBUG_ENTRY=y


 arch/x86/configs/i386_defconfig   | 1 +
 arch/x86/configs/x86_64_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 1b411bbf3cb0..73abbbdd26f8 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -281,4 +281,5 @@ CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
 CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_BOOT_PARAMS=y
 CONFIG_UNWINDER_FRAME_POINTER=y
+CONFIG_DEBUG_ENTRY=y
 # CONFIG_64BIT is not set
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 409e9182bd29..61e25f6209ed 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -276,3 +276,4 @@ CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
 CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_BOOT_PARAMS=y
+CONFIG_DEBUG_ENTRY=y
