Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1807F9208
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 10:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjKZJvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 04:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZJva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 04:51:30 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AFCC3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 01:51:36 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54af61f2a40so2553366a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 01:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700992295; x=1701597095; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=g8dlLMzxL+gBjRy7kgyXbZNFALXIOTxQEDRAQsJxNc0=;
        b=NmtT1FbjVoEWB3tYeMH1TTJL4rFYNTaFrgTtllksJ8ITxAE6+M3wTBexHmPlYtkRlA
         Rdaqk/kzBO9JkqzY+uhEIvNt931yDePjx1mA74Qr9yf2IVV5MkxOWzsHbznSYqtNX+ex
         xXrqm244InwRXb6G7d4Y7K5CSd4fxNoVmm2Awpei+iSv7inHAhVkYV5hg5mq7bUlF6Tc
         dYWSoMUza9jsTqDTpVgSHxGclxLKmv3soyvC8n8dKMx7FG65NfMs9gO6TKPoKLSoqzzC
         VEq1jqyKzSe0/iQSGK5h8znLsV7jujFnijvhSmqHzyvSdgQjWNbOKG5Gq1HBKfQXU0V9
         +wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700992295; x=1701597095;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g8dlLMzxL+gBjRy7kgyXbZNFALXIOTxQEDRAQsJxNc0=;
        b=i+of7Z/eyTnhysSPQ393OrBBrdy0lPln+sf5/L6aTHQlFuxvDcKFt0D+ohacZRBHmI
         Qhkpt0NVtj1jNjz5RS3GM+nh6jdNzcCf2jbduTmUn0Voip39bHxp3Qvg4nBIqx0t7n0K
         bfB4A1aPvq7sB7hbAPLqnh2r+VNaoZLh7mrkmDWBnNC9uC/TLhrdfq3Ss1z00GAscaKW
         h0U8l3h2ETpwnJG3574WBlZi7RKX44xx5Zmeq7tM3tLpz9zwlYleRb5DUYzmKX6NF2sk
         yp38bXDPmxgoM+QJPygJFB+C/0x6yNJFxIUxA+wJykddXCIv9b1DVnXQrav/8yr2nyCw
         Z27A==
X-Gm-Message-State: AOJu0Yx111xbokCbpEMm67EK5633VHFnqIXHkDtOD/XvjYwMGYgdBJqe
        AT5FnIGhf14v8O8Unv0xCls=
X-Google-Smtp-Source: AGHT+IHwD2gc88zTgY9CcsLH5zrnLSmNAdSZNIlWmETs8l3V3l3QXcg71HMu9r3EXwm6EWfk5QzNXQ==
X-Received: by 2002:a17:906:f80c:b0:a0d:e65a:277d with SMTP id kh12-20020a170906f80c00b00a0de65a277dmr657919ejb.12.1700992294904;
        Sun, 26 Nov 2023 01:51:34 -0800 (PST)
Received: from gmail.com (1F2EF15C.nat.pool.telekom.hu. [31.46.241.92])
        by smtp.gmail.com with ESMTPSA id bk21-20020a170906b0d500b00a0451802b3csm4378615ejb.4.2023.11.26.01.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 01:51:34 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 26 Nov 2023 10:51:32 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <ZWMVJCJdugia9YIL@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-11-26

   # HEAD: 080990aa3344123673f686cda2df0d1b0deee046 x86/microcode: Rework early revisions reporting

Fix/enhance x86 microcode version reporting: fix the bootup log spam,
and remove the driver version announcement to avoid version
confusion when distros backport fixes.

 Thanks,

	Ingo

------------------>
Borislav Petkov (AMD) (2):
      x86/microcode: Remove the driver announcement and version
      x86/microcode: Rework early revisions reporting


 arch/x86/kernel/cpu/microcode/amd.c      | 39 +++++++++-----------------------
 arch/x86/kernel/cpu/microcode/core.c     | 15 +++++++-----
 arch/x86/kernel/cpu/microcode/intel.c    | 17 ++++++--------
 arch/x86/kernel/cpu/microcode/internal.h | 14 ++++++++----
 4 files changed, 37 insertions(+), 48 deletions(-)
