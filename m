Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85A1765785
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbjG0P0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbjG0P0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:26:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39962D6A;
        Thu, 27 Jul 2023 08:26:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31786b71fdcso193632f8f.2;
        Thu, 27 Jul 2023 08:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690471606; x=1691076406;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GUQyuOtfNbWPvY5eKKHj+k484zL92SmCITGys5Zq2is=;
        b=S5gVWoDdcvk+NvnLtoMM/XBJt3y/MmZuwC5G5oxghFxemupZ0CBfTN+v+UmMpmU0tl
         zhEM8zPsQSCrKd5X3rY9BzOPoS1xVN3xyQzM11u3akp2ujSq7mK9DtTSO0zK01t+4PIp
         sJZj7h5y9n+Rtq8KGcHURqbMdXo45mCcjaoizPKKHLfFogQ1/WSXgxrXrKlZxTdb2Oem
         tGnsRynkAXv1m5tk4vKI3Zjq/iLf0dy3VUI2KLGCWxxzAe/N/WKqaQq57dgmcvzLTHIl
         tZ/kxxIB4APH9XRitIjd7kN7pqWpcGUR84oWYorGPNY79Wfm/2wAB+gfdYK5Jkg2k6fI
         yvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690471606; x=1691076406;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUQyuOtfNbWPvY5eKKHj+k484zL92SmCITGys5Zq2is=;
        b=DPWNZHjtZoikXdICy9qTclcYuFjHYr6oyXVbGBLZRBxqIzGROKs87Uwx1dpO1HjNEs
         McoRyy9G9822M8REYp9Jyc4p6rxkS0whAIMJK9t4oPbiuCTqonm++RXNTFScHIoW7HGn
         +WUBR/vOYz3UKIsNhw7dB4+DrUtfjMy3Aayx1nay5+7D8wZxG5no2l9m7ujqPMuIuV9i
         D7FyuZcVwumexCBwBUvDStB8cHhYW70faEzmfA4EX1R22z7giXNLDty6ZbPlmg9JYv9j
         HiaR9Tt2N+305qwrOVKkNnlf8otsv7tgftmw35cmu5kQe9GHpgoUasZL09Zk4g8gGR5H
         nqnw==
X-Gm-Message-State: ABy/qLZ5D1MZnoIMSJJ9E8i/Qz6iQX8gSfZQT8XAuQ2JdR4KYW0k2yOG
        uhCI1q6C5Qh6Y8JcXlcUJUI=
X-Google-Smtp-Source: APBJJlHFzL6FoulKIhle8aYNwxrIqQJXRUpz53AOkn4fETi3AZ/P3ovRQGBkowuZ76zu/M+VYY4Tfw==
X-Received: by 2002:a5d:658b:0:b0:317:6d9d:1250 with SMTP id q11-20020a5d658b000000b003176d9d1250mr1938309wru.61.1690471605833;
        Thu, 27 Jul 2023 08:26:45 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id b17-20020adfde11000000b003143765e207sm2350622wrm.49.2023.07.27.08.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:26:45 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Subject: [PATCH 0/6] regulator: pca9450: register restart handlers
Date:   Thu, 27 Jul 2023 17:26:35 +0200
Message-Id: <20230727-pca9450-reboot-v1-0-c8edb27bf404@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKuMwmQC/x3MQQqAIBBA0avErBNsMqyuEi3UxpqNhkYE0t2Tl
 m/xf4FMiSnD3BRIdHPmGCq6tgF3mLCT4K0aUGIvNSpxOjOpQYpENsZLSNsjdqN32iDU6Ezk+fm
 Hy/q+H+CkDbhgAAAA
To:     Lee Jones <lee@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Jerome Neanne <jneanne@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

This series is based on linux-next and 6/6 depends on [2].

Thanks & best regards,
Benjamin

[1] https://lore.kernel.org/all/7eddaf8c-ab04-7670-fc45-15f0fce5eff2@collabora.com/
[2] https://lore.kernel.org/all/20230327-tegra-pmic-reboot-v7-3-18699d5dcd76@skidata.com/

---
Benjamin Bara (6):
      kernel/reboot: distinguish between cold and warm
      mfd: rk8xx: Specify restart mode
      soc/tegra: pmc: Specify restart mode
      mfd: tps65219: Specify restart mode
      kernel/reboot: remove generic restart mode
      regulator: pca9450: register restart handlers

 drivers/mfd/rk8xx-core.c              |  3 +-
 drivers/mfd/tps65219.c                | 17 ++++++--
 drivers/regulator/pca9450-regulator.c | 59 +++++++++++++++++++++++++
 drivers/soc/tegra/pmc.c               |  2 +-
 include/linux/reboot.h                | 23 +++++++---
 include/linux/regulator/pca9450.h     |  7 +++
 kernel/reboot.c                       | 82 +++++++++++++++++++++++++++++------
 7 files changed, 167 insertions(+), 26 deletions(-)
---
base-commit: 4d2c646ac07cf4a35ef1c4a935a1a4fd6c6b1a36
change-id: 20230724-pca9450-reboot-0b32218fc7a2

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>

