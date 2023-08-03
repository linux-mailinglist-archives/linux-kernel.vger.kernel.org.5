Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479DE76E3C7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjHCI6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjHCI5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:57:53 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE8B1FC2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:57:42 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-268b3ddc894so357847a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 01:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1691053061; x=1691657861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yLuMaVJQRwFXzrj2KAyjh6dQRHn4ylta+xeHAhU0hZc=;
        b=Bu0D3tGjQV9Pc4NF3RI5B5EiGg4B5cv6DLumG8NB9wnCVaSTXNEZzxw48JRUczYBZg
         zia2PWyNqRQVA1lY1qZBnJ95b8Kr3cIHSKrJ+uLCY5rcKIWSx6IDWM8IryDShuLSGoE5
         pn9BtS0M7KZ4IzyfSh0JZ0j6l5cXaQojDx7yqnjlwtlmOnpvMJnlEs6kfTLnZCkEqAiU
         D14t5UbsxeVCvzkkUSbJhYQ8kVoIOwIZDDmcEvkSF3lTBYlUBm0nnfSfKvF+pX3pa0gD
         Dl1uFzTOlCW3eVyT7CNUSofcEAwnHXRh5EUHt9kC4E0DQEhfSNDOz8JZAG2r6AqJmufg
         +xHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691053061; x=1691657861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLuMaVJQRwFXzrj2KAyjh6dQRHn4ylta+xeHAhU0hZc=;
        b=Eh9PtNYuXZHbY082P/X8KMj13lJKJmdkXu17SHbrZJe3SQDr7R5cjmp4PBjOF0YFvU
         d6E8y0zsaAhocvAP7XtEqOdnZEJV9eSEdfQTrPFscQ5OpxyKQFWCY2FLqdDbgEpfrZzc
         k7EUKKkdfuPsZHl1YQ/7lFjc1hPlFb/QuU+FA+1362XNgTxNON0bK8F7ziBxks7hDK0m
         U6h95QmSw2XA2LHzaIutUWfSnJ/4IxdU86nPIOWn+B4VB7ZAHaLi0ewFS7L4Hw4R0AJE
         nG2yFDnImUSPJz44u/iUTD4u+/vROrDPecBsAbE/JaCrzj5Erie4M23d7FXBVm9NP5ET
         sF/A==
X-Gm-Message-State: ABy/qLbR9NTPaSgI84ajqM1xFClBw2B5N6ZE8rGD74FUkU+UbjX285Qk
        43MDmJdPBrsTyEwLcC5B9cHgsulIKtUxfK2ulIbHclw/zRc/U4XZM3x5zlqnzH714YVDmjcgWqn
        GqjLZFhdCqt9wvZevUSJlYIV7i0RnghS8nTth/kcCg6f3LyqvKB4sQZbpCzyKuITASrhiuRo9ni
        A2U4PkQW2J3g==
X-Google-Smtp-Source: APBJJlGnnPb//8k65nNPvHDIdInt/WndMpdPrnE5Y80vvoLgTBTdyYd4KLPnCWV1uD6o2WUos8NKPg==
X-Received: by 2002:a17:90a:a592:b0:268:daa4:3a70 with SMTP id b18-20020a17090aa59200b00268daa43a70mr8066701pjq.32.1691053061337;
        Thu, 03 Aug 2023 01:57:41 -0700 (PDT)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id i6-20020a633c46000000b0056334a7b9b2sm12941735pgn.33.2023.08.03.01.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:57:40 -0700 (PDT)
From:   Nylon Chen <nylon.chen@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        geert+renesas@glider.be, pavel@ucw.cz, vincent.chen@sifive.com,
        nylon.chen@sifive.com, emil.renner.berthing@canonical.com,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor@kernel.org, zong.li@sifive.com
Subject: [PATCH v4 0/1] Change PWM-controlled LED pin active mode and algorithm
Date:   Thu,  3 Aug 2023 16:57:33 +0800
Message-Id: <20230803085734.340-1-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the circuit diagram of User LEDs - RGB described in themanual hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.pdf[1].

The behavior of PWM is acitve-high.

Removed patches: 1
New patches: (none)

Links:
- [0]:  https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf
- [1]:  https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce76f4192_hifive-unmatched-schematics-v3.pdf
- [2]:  https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf

Changed in v4:
 - Remove previous updates to the PWM algorithm.

Changed in v3:
 - Convert the reference link to standard link.
 - Move the inverted function before taking the minimum value.
 - Change polarity check condition(high and low).
 - Pick the biggest period length possible that is not bigger than the
   requested period.

Changed in v2:
 - Convert the reference link to standard link.
 - Fix typo: s/sifive unmatched:/sifive: unmatched:/.
 - Remove active-low from hifive-unleashed-a00.dts.
 - Include this reference link in the dts and pwm commit messages.


Nylon Chen (1):
  riscv: dts: sifive: unleashed/unmatched: Remove PWM controlled LED's
    active-low properties

 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 4 ----
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 4 ----
 2 files changed, 8 deletions(-)

-- 
2.40.1

