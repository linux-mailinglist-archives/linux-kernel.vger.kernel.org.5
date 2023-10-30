Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96037DC0BE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjJ3Tlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjJ3Tlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:41:51 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D44B3;
        Mon, 30 Oct 2023 12:41:49 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507ad511315so7073979e87.0;
        Mon, 30 Oct 2023 12:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698694908; x=1699299708; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oLBCiejWcLX5tzcNkh0MgObjl1pJEDZ1NaFHdVzEHHY=;
        b=Zoez7amHjbnHWrNfZ+mPJoo0XuXENbH2hP/FUoM7p6uuD/q7tAd//H7YAm5IBcDbLQ
         8fveMTFXvvSWI7EqtIuvEpH1Cjm7YD2ZtMg3vrR8UxApIuN28ISezHVg5ibs8hwmtq/+
         OoquqEt8cL//KZreMFWmSDjDxpez6xdQnHzMaqBwaYjLvsLLJvnkP1pSwJJh2fcyKFd5
         ahkedhgPxOqqp8KHXWh0uiR7OjQdQtFTsXWvTPjMihyM5rfkKcFeKA2pyhq6qwDcdxoA
         N33mET2lI9TTX1ImKQOr9PQclJewpPE1PDLHDCdbgX65N9Brp7Zf3cTyb8mr9ZS9WHvz
         +ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694908; x=1699299708;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLBCiejWcLX5tzcNkh0MgObjl1pJEDZ1NaFHdVzEHHY=;
        b=k57uthC82+AIMpJvwlSutb7+2oJZeVwSvVGz9xqV9DIaSVgkYG6cDs57dzWPSV03Xm
         SnCGtcwjgayv3Hk0Zqrl85ig60Ely+Jw0O8NSyWNKqmAW6mx7Lhx1UWZ0hfs+dOmjnQu
         TNKpSpzjrYe7cpg3kXEN8aibCzz3Wgr4cLwThvlje+pJwfSQATKq888IcDGibScTQy1+
         bJ666wgJHt0+qRjg4yoaKG/ebpEpxiuOy/M1DSH36GWgpp/MlbS/wHZZPFfmCP4etxr3
         19Pgkn7XMopJzOuxoKOiCKVzc2MLBK3nma0U73l6EThTlCYj0tkPZ++LZqiEOzhouftv
         wdxg==
X-Gm-Message-State: AOJu0YzXSMBGSAjDsgqV0Y/GZzJfvjzo4VByQvSlrMaskwIUni98t2cj
        EWdlfE/8W7iQ5TkMhseD+EU=
X-Google-Smtp-Source: AGHT+IH8oLUZxa/qDapfaqh+h8SSJjQMEWfN8vEfOglWrr6qY0TlgxnahKt61qU8BJDMkKNqRG53yw==
X-Received: by 2002:a19:ae08:0:b0:507:a58d:24ba with SMTP id f8-20020a19ae08000000b00507a58d24bamr7836062lfc.63.1698694907651;
        Mon, 30 Oct 2023 12:41:47 -0700 (PDT)
Received: from hex.my.domain (83.11.208.51.ipv4.supernova.orange.pl. [83.11.208.51])
        by smtp.gmail.com with ESMTPSA id m10-20020ac2428a000000b005057184ae62sm1527802lfh.96.2023.10.30.12.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:41:47 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v2 0/6] mfd: bcm590xx: Add support for BCM59054
Date:   Mon, 30 Oct 2023 20:41:42 +0100
Message-Id: <20231030-bcm59054-v2-0-5fa4011aa5ba@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPYGQGUC/0XMSwrCMBSF4a2UOzaSZzWO3Id0UNPb9oJpSiJBK
 dm7sQgO/8Ph2yBhJExwaTaImClRWGrIQwNu7pcJGQ21QXKpBJeW3Z03lhvNFA6twVZbrQzU+xp
 xpNdO3braM6VniO9dzuK7/hDF/0gWjDNlxGm0Z+4Equvke3ocXfDQlVI+2g0eBKAAAAA=
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
        linux-arm-kernel@lists.infradead.org,
        Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698694906; l=2364;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=xEWklxV2bb+THqz2hq7fCZYhiQfBC65HD3CxOBM/EsU=;
 b=Hi1r6Cuym/1TEN0XMMiSJF37zFmuslgicn4heRqmRSDjBZF7B+8LBPVuGY7+lww/KzdqK1Hws
 J3BGKg5B1+9Bg3FvlnTf7Zvy9Q7VHd1v3wG4qmgETkzgFpAaEpf8xYv
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
Changes in v2:
- Fixed BCM59054 ID being passed to BCM59056 function in the
  regulator driver
- Dropped linux-rpi-kernel from the CC list
- Link to v1: https://lore.kernel.org/r/20231030-bcm59054-v1-0-3517f980c1e3@gmail.com

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

