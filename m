Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D79F7768A4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjHITZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjHITZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:25:20 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5D54691;
        Wed,  9 Aug 2023 12:24:17 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe4cdb72b9so993375e9.0;
        Wed, 09 Aug 2023 12:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691609056; x=1692213856;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v0OupzEUCI9LUKIXmkOERrh940bGOq6qhg8B+pfcxgs=;
        b=HV2fSypLOEmAvKFieQ92XaiApHN6K95hfIOek/2M6i8dqTdlYi8Gs9lj1HkpIJ4+DX
         lYuHRnDZMsPGS9XeEyRwVUodGtUN608KVx2uupAwc95D/Jmx3itbMUgFBqJaf4BuPlJ6
         UmFI+QOczemah6/HHgs+YXJD/sxerHPhr+EsBfoD2OXxl3uKd+XiTLTYQHyqJ09k8L94
         NLN/ijhpcV5gvFH4I6KBndXdmkSGILOISdnhuSQymd9Fk84CqubeMTm1nLeNT5xiyRgm
         q0ZGXb5gNvmHKcdaJ5CF24+F+EVvTtx/y84yiD+A+fv8S7iJIU3ZXWWt1ba69RdWcOoT
         6VMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691609056; x=1692213856;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0OupzEUCI9LUKIXmkOERrh940bGOq6qhg8B+pfcxgs=;
        b=QzhuKt4oGudelpJ4ly0txl43KWpZxOaNOhn/IEEjrYK5MfgNKKBrI8i3vOiOOWRPsR
         EHoPf03U4KB0RtWlbezm7u0qRvyyPijc0tGoe3KcirqmHiktJnLBNXWAvNccNyMMNfZc
         ymZY6evArHRgPPrVB+xU3YGz2F2FpJYK8MFP7X/EMRobrNtDpNyvY12NtLDE4T9z5J8t
         BIpxq9MI+pnO7gt4m0FvLR+mfMAO46yKsPyLI/wfhWTDEtIiMFfY9qCUTGidvYfTxX7B
         kzD+N3msQUyPeiIgU50xrEBADM3G8hiAy0PrMrirt3zTtw70CxMkNz4G/aLjrX/h73pa
         W2Aw==
X-Gm-Message-State: AOJu0YzFljwbRjlJO9F5fMXJd3cHxO2Ba9Tl7ASehiwpNP6JtAIbQsOB
        4ZvHFUTpxLiPLHm3l4/rvEA=
X-Google-Smtp-Source: AGHT+IEDQ0jEC9DLkLjjDcq9vtTgHzcHQeZHytemLaVScSTO7uZiV8+UdY7Oq7vRBWlqUo3xR6nIwQ==
X-Received: by 2002:a7b:c395:0:b0:3fe:18a3:b3c with SMTP id s21-20020a7bc395000000b003fe18a30b3cmr62612wmj.12.1691609055409;
        Wed, 09 Aug 2023 12:24:15 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fba6a0c881sm2776208wmj.43.2023.08.09.12.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:24:15 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Subject: [PATCH v2 0/6] regulator: pca9450: register restart handlers
Date:   Wed, 09 Aug 2023 21:24:02 +0200
Message-Id: <20230809-pca9450-reboot-v2-0-b98b4f8139d5@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANLn02QC/13MQQrCMBCF4auUWRtJppFUV95DukjSiR3EpiShK
 KV3NxbcuPwfvG+FTIkpw6VZIdHCmeNUAw8N+NFOdxI81AaU2EqDWszenvVJikQuxiKkaxFVF7y
 xCPU0Jwr82sFbX3vkXGJ67/6ivuuPMv/UooQUvqPBoXFBS33NDx5ssUcfn9Bv2/YB8Pchw64AA
 AA=
To:     Lee Jones <lee@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        peng.fan@oss.nxp.com, rafael.j.wysocki@intel.com,
        Jerome Neanne <jneanne@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This series implements two restart handler registrations for the pca9450
(6/6). As the pca9450 supports both, cold and warm resets, and there
exist at least one other PMIC implementation which also implements a
warm and a cold reset (tps65219), 1-5/6 should simplify/clarify the
distinction process between warm/soft and cold/hard resets/restarts.
Instead of deciding in the handler, this should be done during
registration. The series is a follow-up to Dmitry's feedback, regarding
checking the reboot_mode in the handler [1].

As the cold handler queue is executed before the warm handler queue
(when the reboot_mode is not changed/specified), cold handlers are
implicitly executed with a higher prio and therefore the default
registration can be used.

This series is based on linux-next and 6/6 depends on [2].

Thanks & best regards,
Benjamin

[1] https://lore.kernel.org/all/7eddaf8c-ab04-7670-fc45-15f0fce5eff2@collabora.com/
[2] https://lore.kernel.org/all/20230327-tegra-pmic-reboot-v7-3-18699d5dcd76@skidata.com/

---
Changes in v2:
- rebase to next-20230809
- improve commit messages
- use helper (with implicit priority) instead of explicit priority
- fallback to warm handler if hard/cold requested but failed
- Link to v1: https://lore.kernel.org/r/20230727-pca9450-reboot-v1-0-c8edb27bf404@skidata.com

---
Benjamin Bara (6):
      kernel/reboot: distinguish between cold and warm
      mfd: rk8xx: Specify restart mode
      soc/tegra: pmc: Specify restart mode
      mfd: tps65219: Specify restart mode
      kernel/reboot: remove generic restart mode
      regulator: pca9450: register restart handlers

 drivers/mfd/rk8xx-core.c              |  6 +--
 drivers/mfd/tps65219.c                | 17 +++++--
 drivers/regulator/pca9450-regulator.c | 59 ++++++++++++++++++++++++
 drivers/soc/tegra/pmc.c               |  2 +-
 include/linux/reboot.h                | 23 +++++++---
 include/linux/regulator/pca9450.h     |  7 +++
 kernel/reboot.c                       | 84 +++++++++++++++++++++++++++++------
 7 files changed, 170 insertions(+), 28 deletions(-)
---
base-commit: 21ef7b1e17d039053edaeaf41142423810572741
change-id: 20230724-pca9450-reboot-0b32218fc7a2

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>

