Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44ED975FD0D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjGXRUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjGXRUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:20:50 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB73E76
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:20:48 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bb893e6365so10586555ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690219248; x=1690824048;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T78H58Y+eyGMwfw+MQha4MkUBw4YAh2gvZHpk5miiEQ=;
        b=xB7435YNjj/ZzwqdtKUb5Op688RZ1fvskoaZtkg7UwSDKMTfGtLefhJqIvGkTWiB1F
         cYEuyMuOJRJsaLoFB9p0wYUxfbvaJLv2S7B4YByXe1iw9731ETyqK8E96K1aycDcjvKO
         MINN1k1mH0aBQ+22irnFgSMLhG7LVMoz1LH8JoXTSVAXfPNNE7xdVVURYTGQz0sMy46y
         MFV/3SiPnrNs2+X1wJCsbei8sWdmdPCbbYrYbKEfxC4ozZqWFFGfjFXS4J4zQHlyi3s7
         rSh949tS2WoJVU3LSqDf95ICjAyNuq9NaYpyqG+/r3Znvs/7xNA1AHmgojeBnLi7dfE1
         VB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690219248; x=1690824048;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T78H58Y+eyGMwfw+MQha4MkUBw4YAh2gvZHpk5miiEQ=;
        b=c4W5jRx6WKf7JE8dRIJrFg+MecIdwxgwQZSChPxViC3eyFNofWEtQ1nZz4C0FkiU4H
         2XIaoIcUB73VMSQS7z6Oj18lidr9PPOJtje5ADOoCIjBKop0JbFp8CLDQE1luijeJefy
         LO9A2gokITqAwxckwYY1u4lk7/JdCimjA1RrC23wJBSASzPpxqDveILi1NeI1CvEDk9y
         IPyXql5rBMA8s8UADOpQ+6HzG8wGgjs3v16EuZuDj4AP71da4aVp4Toj9DDLkl/lShMy
         3XPpgdd+9uw/1kaU8D62eruMUqp2w8BZ/GzLHWDlhRqsccxqRKunfuDQfvZQ2u0F+wGC
         RvXg==
X-Gm-Message-State: ABy/qLZNHP5rdO1rrp5anuY8MiRxQtplhStcjfSMqltJfWRYS3lfYzMS
        qfoQD4gUz0jFRPmBIPcY4pbbtw==
X-Google-Smtp-Source: APBJJlH/kqG3B2mSYH6hRT9OESM7I2ZRUbgGxqU0ifQgR0ERkakURqiGUhNCd6sBH7XTwao21DfzsA==
X-Received: by 2002:a17:902:7590:b0:1b8:a3a0:d9b3 with SMTP id j16-20020a170902759000b001b8a3a0d9b3mr8867938pll.47.1690219247804;
        Mon, 24 Jul 2023 10:20:47 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:b55a:eeb0:a3a8:248e])
        by smtp.gmail.com with ESMTPSA id ij15-20020a170902ab4f00b001b9cf522c0esm146456plb.97.2023.07.24.10.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 10:20:47 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v2 0/3] riscv: Add BeagleV Ahead board support
Date:   Mon, 24 Jul 2023 10:20:37 -0700
Message-Id: <20230722-upstream-beaglev-ahead-dts-v2-0-a470ab8fe806@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOWyvmQC/x2N0QrCMBAEf6Xcswc1YgV/RXy4NJsmYGO5i0Uo/
 XdTH4dZZjcyaIbRvdtIsWbL79LAnToak5QJnENjcr279Dfn+LNYVcjMHjK9sLIkSOBQjcNwPUt
 ssygDtYAXA3uVMqYjMYtV6CEWRczf/+vjue8/KiVb/4UAAAA=
To:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <dfustini@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690219247; l=2058;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=cb/GVUPxtZh8g4BNOlBWqM76o98CviH0nZ6IgW668jY=;
 b=bltEAH6YPHy7pRO3DKbzvxNCGJa/xoEQl4zNMsmlXZQc6/BplXS8X57MxNJu6rkOEMZbHDkRA
 Q2lksSHIwuoCpN74ArOKCVSFPjDWpgCiAaIy5TU5RwIMyFWG3uEo+CK
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BeagleV Ahead single board computer [1] features the T-Head TH1520
SoC. Similar to the Lichee Pi 4A series from Jisheng [2], this adds a
minimal device tree file to support booting to a basic shell [3].

Changes since v1:
- Add dual license to dts file as Conor noted this is typical
- Move the bindings patch before dts patch so patchwork bot is happy
- Reorder new entry in thead.yaml to maintain alphabetical order per
  suggestion by Krzysztof
- Add A-b's and R-b's from v1

[1] https://beagleboard.org/beaglev-ahead
[2] https://lore.kernel.org/linux-riscv/20230617161529.2092-1-jszhang@kernel.org/
[3] https://gist.github.com/pdp7/91b98f5b8a632802e669d8c359f4f498

To: Jisheng Zhang <jszhang@kernel.org>
To: Guo Ren <guoren@kernel.org>
To: Fu Wei <wefu@redhat.com>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Robert Nelson <robertcnelson@beagleboard.org>
Cc: Jason Kridner <jkridner@beagleboard.org>

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
Drew Fustini (3):
      dt-bindings: riscv: Add BeagleV Ahead board compatibles
      riscv: dts: thead: add BeagleV Ahead board device tree
      MAINTAINERS: add reviewer for T-Head RISC-V SoC support

 Documentation/devicetree/bindings/riscv/thead.yaml |  4 ++
 MAINTAINERS                                        |  1 +
 arch/riscv/boot/dts/thead/Makefile                 |  2 +-
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 61 ++++++++++++++++++++++
 4 files changed, 67 insertions(+), 1 deletion(-)
---
base-commit: 295e1388de2d5c0c354adbd65d0319c5d636c222
change-id: 20230722-upstream-beaglev-ahead-dts-d651af307fa6

Best regards,
-- 
Drew Fustini <dfustini@baylibre.com>

