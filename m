Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD9C7EFD78
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 04:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjKRDjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 22:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjKRDje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 22:39:34 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6CDD72
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 19:39:31 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28003daaaa6so2214119a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 19:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700278771; x=1700883571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xk65QbdRKZdLNSQh19GKuOPbc61/SWIMytvbu8dUYc=;
        b=jsiDW+/iFIlrJvhc1hGwOytoJLciIuIJz7wYjuNWDFnZ5gFquyO+WxRLDmDf5KmNJ+
         eG085RVuTESbmH30O6YSw8ZW16Q7nLxcgyL9+bMp6SI3m5pWoLrHgy887fKYprXZpcrx
         oMEzW3lRZpTqyB728Efq+OoAtH9CWzEzyaNwvWGBFjaxWg3dZz/nsVVU0iAZfsFfI/4Y
         EsxySpBUlSzbfQVUjuAOCMVGxvMtyMtb10oppx2S905yksnzieWrRF17TgLpe11JBXu1
         P1shtwpdQNms3HtW890uvEIPO3UYTqHZ5Lg8UU6lp2/7b8CotK6ZFshNEW8Y2O/GlU+l
         Rbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700278771; x=1700883571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Xk65QbdRKZdLNSQh19GKuOPbc61/SWIMytvbu8dUYc=;
        b=KWFXasLiUktojiv2XE7WtvBof2TkfhmOGZcZgT3KSSgJzGkmzB2G1kqndQxNQ5DnZQ
         NaRI5FW2j4xR0LPMj07RA2eDPnhowF8DwyslBoybPRzFwKBEuH+DYo8mfwhPznMW3zjf
         zR1zwXY7dvZ0mz+xVuF1yfpeL3LS0S2BNMwR89XyOIP0AJvCTNmY86tSHeZQX8ezkF/8
         8hmzlB2PRp2Y9HO0sxoYuQnCoPGaj8t5e6+vERU9J2Ne9ywjqHu1nZl4sKZc8qtUvUeF
         H53Cd+fwe7hhh889vP/Xjl8E/DeesmZ0GYb7wXS4HTuTi/0V7Sv7uar353cpWN2lAsEJ
         xxog==
X-Gm-Message-State: AOJu0YyGbgW76OgP/4DCBktUubI+UwCKEZw+S4y0Y2ix52sGxeu7Ekny
        RfPzELd2qMeP0mT1Vh0b83rFjo1jntnymyXUeGc=
X-Google-Smtp-Source: AGHT+IEdivzV5yM9VLUbAmX/fPwvXT56J4szG18kUoyADgqsU5ZolAzZbNQxZHHnYCkaszm6OKc0Yw==
X-Received: by 2002:a17:90b:4a49:b0:280:4ec6:97e9 with SMTP id lb9-20020a17090b4a4900b002804ec697e9mr1593141pjb.30.1700278770582;
        Fri, 17 Nov 2023 19:39:30 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.80.108])
        by smtp.gmail.com with ESMTPSA id cz8-20020a17090ad44800b00280fcbbe774sm2053823pjb.10.2023.11.17.19.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 19:39:29 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v4 0/5] RISC-V SBI debug console extension support
Date:   Sat, 18 Nov 2023 09:08:54 +0530
Message-Id: <20231118033859.726692-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SBI v2.0 specification is now frozen. The SBI v2.0 specification defines
SBI debug console (DBCN) extension which replaces the legacy SBI v0.1
functions sbi_console_putchar() and sbi_console_getchar().
(Refer v2.0-rc5 at https://github.com/riscv-non-isa/riscv-sbi-doc/releases)

This series adds support for SBI debug console (DBCN) extension in KVM RISC-V
and Linux RISC-V.

To try these patches with KVM RISC-V, use KVMTOOL from riscv_sbi_dbcn_v1
branch at: https://github.com/avpatel/kvmtool.git

These patches can also be found in the riscv_sbi_dbcn_v4 branch at:
https://github.com/avpatel/linux.git

Changes since v3:
 - Rebased on Linux-6.7-rc1
 - Dropped PATCH1 to PATCH5 of v3 series since these were merged through
   KVM RISC-V tree for Linux-6.7
 - Used proper error code in PATCH1
 - Added new PATCH2 which add common SBI debug console helper functions
 - Updated PATCH3 and PATCH4 to use SBI debug console helper functions

Changes since v2:
 - Rebased on Linux-6.6-rc5
 - Handled page-crossing in PATCH7 of v2 series
 - Addressed Drew's comment in PATCH3 of v2 series
 - Added new PATCH5 to make get-reg-list test aware of SBI DBCN extension

Changes since v1:
 - Remove use of #ifdef from PATCH4 and PATCH5 of the v1 series
 - Improved commit description of PATCH3 in v1 series
 - Introduced new PATCH3 in this series to allow some SBI extensions
   (such as SBI DBCN) do to disabled by default so that older KVM user space
   work fine and newer KVM user space have to explicitly opt-in for emulating
   SBI DBCN.
 - Introduced new PATCH5 in this series which adds inline version of
   sbi_console_getchar() and sbi_console_putchar() for the case where
   CONFIG_RISCV_SBI_V01 is disabled.

Anup Patel (4):
  RISC-V: Add stubs for sbi_console_putchar/getchar()
  RISC-V: Add SBI debug console helper routines
  tty/serial: Add RISC-V SBI debug console based earlycon
  RISC-V: Enable SBI based earlycon support

Atish Patra (1):
  tty: Add SBI debug console support to HVC SBI driver

 arch/riscv/configs/defconfig            |  1 +
 arch/riscv/configs/rv32_defconfig       |  1 +
 arch/riscv/include/asm/sbi.h            | 10 +++++
 arch/riscv/kernel/sbi.c                 | 43 ++++++++++++++++++
 drivers/tty/hvc/Kconfig                 |  2 +-
 drivers/tty/hvc/hvc_riscv_sbi.c         | 59 ++++++++++++++++++++++---
 drivers/tty/serial/Kconfig              |  2 +-
 drivers/tty/serial/earlycon-riscv-sbi.c | 24 ++++++++--
 8 files changed, 129 insertions(+), 13 deletions(-)

-- 
2.34.1

