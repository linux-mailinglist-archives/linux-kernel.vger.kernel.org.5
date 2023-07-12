Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F885751374
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjGLWQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjGLWQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:16:44 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7C0199D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:16:43 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b74209fb60so7588961fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689200202; x=1691792202;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4LdmsOnFTqS1Cie5iiFkXBonoGBgUOcV5X4qo5inNSI=;
        b=CoJkBcDv6qjh66tX8On+ZG9yy/znVU3orvRevnsiqBzLKhhW51dADllqNXcF59L7/m
         Ggl+MJ8RJ62VQhpBLucODKkGchAerPNL+j4FDxvGdPORaHdCnAO+7ae0pCX6zn+Cekw9
         s6cUEATgylR0xi5980ecookYizWP7E8oaDpDOiLZenh13rA3LdvCP7OsttleF84yuhEd
         YEl9YKpC3eu7ZgRL37D6GKNDaXo4A07RC9QmTYvuxUbZa6W40ovt0Q/FH0kCLyE4N2ks
         UH78zrhTY9QVMx1m74azikM2+ofGMkwZ4EV5B2rYTDDuVQGx7Acv0DeMKscv874AFhuP
         Ns9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689200202; x=1691792202;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LdmsOnFTqS1Cie5iiFkXBonoGBgUOcV5X4qo5inNSI=;
        b=kkz5at3jFH/8QGvXH0UCuco7NRN9RuxChSrtSY82fCHJSMOB5ZBdnBEUMESNXBh8oS
         coSg/np15ottyGbrCaivoMCESb1VPd1nPohB9QNOnCeCAQ4qht2G/5bbwmxtTGq+99Tn
         Iu6mFcU2haK8/KpDvA09ODB1GLePHqjx8d8j1+7QSiR9WVVM09IieZQgNawYQj0tL/FK
         c5dMM0pYwlfV3PD/I1MtUaFRi57GrEWZj1FRZcvOxrZ1K197fTQngLZnbkHnjT4VUWuZ
         1xV0D0aOP6UinXKuo7MXBv7S44SFOFktKxcMAfyJvKC2ioRLxWdGMBq6q4UrmEJTyTdx
         8qNQ==
X-Gm-Message-State: ABy/qLYOyPsp+4dJLUGhPlCVMMSTCjkbRq2r64SdBSrhwkXZWyzAYl4q
        J9ZzwT5DUFwjr4kBOHi2utetzg==
X-Google-Smtp-Source: APBJJlGPiDIpavgNBQktJlQgrh6mHSCi/gmzFVU6mnV5+zb2pOmDldtlWtvKO66E1xXuAb0aFKgFnQ==
X-Received: by 2002:a2e:9904:0:b0:2b7:7e:e95e with SMTP id v4-20020a2e9904000000b002b7007ee95emr17196988lji.45.1689200201796;
        Wed, 12 Jul 2023 15:16:41 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id b19-20020a2e8953000000b002b6e00a3e19sm1177774ljk.132.2023.07.12.15.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 15:16:41 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4 0/2] (no cover subject)
Date:   Thu, 13 Jul 2023 00:16:40 +0200
Message-Id: <20230713-seama-partitions-v4-0-69e577453d40@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEgmr2QC/33NSw6CMBQF0K2Yjq3ph7bUkfswDl6hQBOlpCVEQ
 9i7LRM0Eof3fc6dUbTB2YjOhxkFO7nofJ9CcTygqoO+tdjVKSNGGCeCSBwtPAAPEEY3ptuIjWS
 EUmW0LgVKbwaixSZAX3X5cbvPyyHYxj3Xvust5c7F0YfXWj/RPP3TNFFMsCiJhIbaAip1ubseg
 j/50KKsTWwTFBE7AkuCrnmhG1ILML8C/xTUjsCTIAE019QU0pgvYVmWN8mtWDJSAQAA
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This type of firmware partition appear in some devices in
NAND flash, so we need to be able to tag the partitions
with the appropriate type.

The origin of the "SEAttle iMAge" is unknown.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v4:
- Drop the false tagging of #address-cells etc
- Link to v3: https://lore.kernel.org/r/20230707-seama-partitions-v3-0-6aa9391b46bb@linaro.org

Changes in v3:
- Drop reference from partitions.yaml again
- Drop select: false
- Use unevaluatedProperties
- Link to v2: https://lore.kernel.org/r/20230705-seama-partitions-v2-0-9d349f0d5ab7@linaro.org

Changes in v2:
- Make the binding clearly childless
- Link to v1: https://lore.kernel.org/r/20230506-seama-partitions-v1-0-5806af1e4ac7@linaro.org

---
Linus Walleij (2):
      dt-bindings: mtd: Add SEAMA partition bindings
      ARM: dts: bcm5301x: Add SEAMA compatibles

 .../devicetree/bindings/mtd/partitions/seama.yaml  | 44 ++++++++++++++++++++++
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts      |  1 +
 arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts      |  1 +
 3 files changed, 46 insertions(+)
---
base-commit: 035cd1416934ef7ae5374272d3c9e378c3d7049c
change-id: 20230506-seama-partitions-b620117b9985

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

