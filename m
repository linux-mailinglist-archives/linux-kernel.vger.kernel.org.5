Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9827781DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbjHJTy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbjHJTyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:54:24 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697BE2724
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:54:24 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bc6535027aso11459925ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691697264; x=1692302064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+KSmMqqtvDIiHz4Ho0lGfwn8AtEPGP14LPDghXjLYrI=;
        b=nrXbwl42fHl/TmgPZPbp4NYdzZS26suBRDTcs7Wk4VaUdbnJFtqlYuY2kVpZaOc7eE
         ZlYyHSoOEqPr8lDHmmJ2KCFnyPADLw+V4jlJXFebMimObgbYQvVI4AV6ufI6GOAMe0O3
         /cc+CErvpTqxvL+kqT8XL2a6TPPC7RrAj+ppE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691697264; x=1692302064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KSmMqqtvDIiHz4Ho0lGfwn8AtEPGP14LPDghXjLYrI=;
        b=fUnGdVcB3KzJS8XnhZQHbjrfrS/h15ZBjEhsoASiTitt59odbYQRJHk9i0PCdVXz0G
         JxcW5+3/ntZf1xUsN9j67NOm/q4PXKiNdFE/yjgJ8SOBKa/FjP4KCwRdyjmIDw06POBn
         6EjgtbOzNFHR4Gnt5MJQGmbJ39CF2pMzIqyW7jOdlIhfiuIuZMHrEif9EaaxtoEGP6HW
         SKrzBwpUVvAR8QD459Qz7P6Janeo8xyXItNXzinsN5lZL6tI6R7N6f6RYmhKjGjaXic3
         grm20cz8nYh2TF81aE4T/ivF3upMzvbUszmtXW1co7Hto1R9Ow7Gh4wpo5/FRCLOqNs8
         VDjQ==
X-Gm-Message-State: AOJu0Yyf34o41zxacnRa8VsWfnAYA8lDC4eoTsHetJ+YHBrnP3jXfrJ1
        wV5E64l15OUjh1jSFdbA4CJDFQ==
X-Google-Smtp-Source: AGHT+IHw2G+HNk0pb7rzPTFmiR+l4BrfXX5lv/VPOP/htPgz5DnJIC6tehMM+4QHARhcvvVVGb92Rg==
X-Received: by 2002:a17:903:22d1:b0:1b5:219a:cbbd with SMTP id y17-20020a17090322d100b001b5219acbbdmr4340562plg.3.1691697263898;
        Thu, 10 Aug 2023 12:54:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902d4c400b001bbf7fd354csm2158636plg.213.2023.08.10.12.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:54:22 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/2] ARM: ptrace: Restore syscall skipping and restart while tracing
Date:   Thu, 10 Aug 2023 12:54:17 -0700
Message-Id: <20230810195141.never.338-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=696; i=keescook@chromium.org;
 h=from:subject:message-id; bh=LCtgD+PkZR6hbDOPphiW7QCeCuo059Geg0rwEi/JXFY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk1UBqGYdSbOqXERSHJr0Lg4TG85J053QilT3rx
 86gcS3SVtWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZNVAagAKCRCJcvTf3G3A
 JiYID/4/t1FvGqMPIZTEFTDWaziXdqRsIgasib2VD3Jxm2l2wQZbrf4v5wkXyRD3N8pNt8bKWsP
 hgXBdnAmaw0wVgFVOd4ndKxz3mPyf4uRjrGZ+ROt4tk8jcuIesbqpiZG6hmphvaj6k+afiwDz4+
 rZsNZ4CSy01PD3/4xtg9DD3kQAMqcxL5DiOsysyu3r84yV2WDA9szFriGj1QZf136ah7QF3Aupm
 AldTkpzllWT2PV43vXW41N+rSQOKTApFMu3Zqx2yKXBy5uN9Oyo77xCXZgsyJ86SYRQvC7A1jCr
 eHc0NcFnR5cC2X5kexSm945JtTHCzDClECCewMFNJPnDr8jesTNw06UJEi+SM/xthFEeH7mcdhP
 KgVz28hRWjzk4vMgN2xcXBNae5I6RvEsPPd8RRFRib1H8QZzinYH24fnxgraz9R7E3d+ZaWWR8x
 nw1NCGg5UNWwTqfGmdoSl5KzS+WSnZAR/QM3TLGs5SdMfjgPsWAyZgCao60+nPHeiDmIsuB08uJ
 Wfp+BavPWbToB/UEl0uj61Pj/O349RScCZwUxwXdTXJzpFBKNG6uD0njcUxBk6vq1rbOxNPVlw0
 AXI1XTCDPJeyHMPgkipEVbyifWObQs6PoN1WsJA8zHa5BjgQlRGW6WZ6FlHuo84LJVxUKqgOzcr
 U11nDG3L XieHU1w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Fix tracing on arm since commit 4e57a4ddf6b0 ("ARM: 9107/1: syscall:
always store thread_info->abi_syscall"). This was seen with the broken
seccomp tests "syscall_errno", "syscall_faked", and "syscall_restart".

Thanks!

-Kees

v2:
- split fixes
- move scno store into the actual restart path
v1: https://lore.kernel.org/lkml/20230804071045.never.134-kees@kernel.org

Kees Cook (2):
  ARM: ptrace: Restore syscall restart tracing
  ARM: ptrace: Restore syscall skipping for tracers

 arch/arm/include/asm/syscall.h | 3 +++
 arch/arm/kernel/entry-common.S | 1 +
 arch/arm/kernel/ptrace.c       | 5 +++--
 3 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.34.1

