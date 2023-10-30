Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A65C7DC09B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjJ3Tg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJ3Tgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:36:55 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79088DB;
        Mon, 30 Oct 2023 12:36:52 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507f1c29f25so6770236e87.1;
        Mon, 30 Oct 2023 12:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698694611; x=1699299411; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bh26XfJbTftWgy18NaxuF1WAEMg2xoCjkdWOn5977yI=;
        b=Ankkjo6byXRMP1f2FphgaOWQrEqOyuyZyAOO2Cw6MAr3AuhlTdf2yPbBv6JEaInVf3
         n0eKxRoBeCFX+FyKwObuwTSgs/6jP8mbn0O//0MKRonimrV0ynFCrXnXGUDrCIQ55V4H
         Ih/85U3jgWMCy9AaPiQAAQYSboop6C2Js/hko4f9X6vTnwfv7jB7GKVVD3i3hLanboSh
         kHPRb/0UpE/paEGv8kRn9qa1AmSa3otOAUMrPnIWZZypes/CTqHH9EeS0N2gcPz2vs5w
         zpUF9dkyh4Q9PXNxFx8J1l7SbjpG9VRBLQUI5bTqarKvWFV7Kwpw/Z56CpX2wD9eiasS
         9LfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694611; x=1699299411;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bh26XfJbTftWgy18NaxuF1WAEMg2xoCjkdWOn5977yI=;
        b=jJOMMMPxx8RQ2+mbcZEvCsw7XPqyRUJ+U7xvUVAAgH/BRTnPdhL2wsK0risuLtFVD4
         K+pP6Z1nFgaVYiRk4EtGHmECKfl5TBT5GQ+fFNjojt9XHCOdxXoGqiImKPVhKvexbFva
         mO/E5Tc1/bxblIEVVFvzTH0v2BgAFjMPjsLYyLOyk13V0YPvR6uX47tA7GbOWVcOHBVI
         yH53G61sAbRsJXHplhycxeGmux4uzz8uOFNGj9Tg1xIoD82jwXUNFLxmfPdksUGLvMC5
         8C0mtDujHqwYTreY0wkv2g6o7t8dSnRAKF3RBMvYhWKkNfw4md2UoqtePLN6CoqoQcpe
         9MZA==
X-Gm-Message-State: AOJu0YxtJ0uDf/n23NKmGKYuWak6HO49mKQBboLwsjuhyDARr459BsBI
        AsfQOz1BnTAWMS40LiYekzk=
X-Google-Smtp-Source: AGHT+IFVbjYqeABIoPu8DwMk3cICsKdrlwzu1sNA3bEnRYKzBi6n/CDT8zTE7cxdP4KmOodOsO78wg==
X-Received: by 2002:ac2:5390:0:b0:500:91ac:c0b5 with SMTP id g16-20020ac25390000000b0050091acc0b5mr7558359lfh.30.1698694610559;
        Mon, 30 Oct 2023 12:36:50 -0700 (PDT)
Received: from hex.my.domain (83.11.208.51.ipv4.supernova.orange.pl. [83.11.208.51])
        by smtp.gmail.com with ESMTPSA id a27-20020ac2521b000000b0050482b29ac8sm1510781lfl.31.2023.10.30.12.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:36:50 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH 0/6] mfd: bcm590xx: Add support for BCM59054
Date:   Mon, 30 Oct 2023 20:36:37 +0100
Message-Id: <20231030-bcm59054-v1-0-3517f980c1e3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMUFQGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAyNL3aTkXFNLA1MTXePUFDPTVDMTSxNjUyWg8oKi1LTMCrBR0bG1tQA
 1gSuaWgAAAA==
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698694608; l=2127;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=8uNP0FkkjxZLolVyEC3Crq7ZNEr3i9gNvQ7PYt3oBl4=;
 b=gtxa7vZMkbHoh5+HI/HS+vJWbKblgVgBc1TrziDaAzI5Is20/imvZ1DNc729ZtNdjRrPuz0av
 2TxKRw4NduGA7u3GhyO4bhkBe/7eLTgFhpoRu8UyUqKiXFBDTE4gDmn
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the BCM59054 MFD to the bcm590xx driver and fix a
couple of small bugs in it that also affected the already supported
BCM59056.

While we're at it - convert the devicetree bindings to YAML format
and drop the bcm59056 DTS in favor of describing the PMU in users'
DTS files, as is done for most other MFDs.

The BCM59054 is fairly similar to the BCM59056, with the primary
difference being the different number and layout of regulators.
It is primarily used in devices using the BCM21664 and BCM23550
chipsets.

I'd appreciate testing on BCM59056-equipped boards to make sure
they aren't affected negatively by the changes. So far, I've
tested this patch series on a Samsung Galaxy Grand Neo (BAFFINLITE
REV02) with a BCM23550 chipset (BCM59054 MFD); this device is not
yet supported in the mainline kernel, but I'm working on adding
support for it, and other commercially-available devices using
Broadcom Kona chips. Hopefully some of that work will make it
into mainline in the near future ;)

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Artur Weber (6):
      dt-bindings: mfd: brcm,bcm59056: Convert to YAML
      dt-bindings: mfd: brcm,bcm59056: Add compatible for BCM59054
      ARM: dts: Drop DTS for BCM59056 PMIC
      mfd: bcm590xx: Add compatible for BCM59054
      regulator: bcm590xx: Add support for BCM59054
      regulator: bcm590xx: Add proper handling for PMMODE registers

 .../devicetree/bindings/mfd/brcm,bcm59056.txt      |  39 --
 .../devicetree/bindings/mfd/brcm,bcm59056.yaml     | 142 +++++
 arch/arm/boot/dts/broadcom/bcm28155-ap.dts         |  68 +-
 arch/arm/boot/dts/broadcom/bcm59056.dtsi           |  91 ---
 drivers/mfd/bcm590xx.c                             |   5 +-
 drivers/regulator/bcm590xx-regulator.c             | 708 ++++++++++++++++-----
 include/linux/mfd/bcm590xx.h                       |   7 +
 7 files changed, 728 insertions(+), 332 deletions(-)
---
base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
change-id: 20231029-bcm59054-3ed65e649435

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>

