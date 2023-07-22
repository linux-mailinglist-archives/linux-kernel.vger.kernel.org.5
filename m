Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A4375DEB4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 23:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGVV4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 17:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGVVz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 17:55:58 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04251FD9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:55:56 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-66f5faba829so2061914b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690062956; x=1690667756;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z8jlHBT2yxbyFBb6F36pXWfZpWaDr43yzvucdNt0npo=;
        b=Z757kvzGOw+bZdl8TOtk4lFAcuq3yuIWqJckq6JGLDFNJgH3zSSutT/oFB+Hdk5Uy2
         Gw91Ep1KFwlvvvFDQG5IfKRB7ph3ou/LzHSUW3KuFRLu+LgOJtek1YrO0/UlkNjVvauH
         +AGNr199OIVmxlH6T2VdhzboUCSCW1uZQfFOYIsWCBHsBBkyXfu5NGhOOCviVIVDcYZU
         wYU0qtbE167pV0Ikf1eWsdYlnXOpKboS100UqcdY1S5+Pt/G+YcwbEVe6ikJ7x08niuX
         58VnuQmQBC5/cmjOI8aOzfNqRynoEwGgwiCxJRJXfHPGLjimJVE1fm/5faULiOWD/Q9p
         NR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690062956; x=1690667756;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8jlHBT2yxbyFBb6F36pXWfZpWaDr43yzvucdNt0npo=;
        b=HMB2KscJW/GUj5curMo+ltMFYRqKOrcei0LYwLDnC1TG3lVj3q2XQK1pJXABiSQXLG
         Jg/wJlzHZEsL7eIH3Eox8Qzg20qC++AXKt6vxXTi/ckETBsanPeHFeU2FneSRZUlKw0u
         w8NZbPfBPovGNPv1gfxahDSA/Y3fEMAOJTQt+NZNH0nx6ra93oFJYB0PlpZTWr3BGiax
         zGTLgQ+yxLjBvuBL88OBsjfRbiVU/69ovQ2JnwxFZraPijnNhDM1hmtGX8cSEVsGOGho
         Y/Yp5j8+lZL/dMf04kAjoyWYX7f1NLwOTF4kNHcwfe1xfjX/xAfY4TYikeIGAwMjYL0R
         Rw+w==
X-Gm-Message-State: ABy/qLYVjZsDlkRSb60gSvSpDZbSKHxxCExw49KrwmRB8FEhqQYpi5c6
        kYQl8AUH4j/GCrq9tbC2yKlXAg==
X-Google-Smtp-Source: APBJJlGE4CzG88umTRhcUR+JWXZx//14i1FxVULmahmL2zD+X1EMYCUsmV9DLjkPDMroa5+VdF3Lgw==
X-Received: by 2002:a05:6a20:4caa:b0:12c:e745:78b3 with SMTP id fq42-20020a056a204caa00b0012ce74578b3mr4794500pzb.62.1690062956394;
        Sat, 22 Jul 2023 14:55:56 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:2a8c:966f:392d:7230])
        by smtp.gmail.com with ESMTPSA id e23-20020a633717000000b0056368adf5e2sm5517642pga.87.2023.07.22.14.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 14:55:55 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH 0/3] riscv: Add BeagleV Ahead board support
Date:   Sat, 22 Jul 2023 14:55:38 -0700
Message-Id: <20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFpQvGQC/x2N0QqDMBAEf0XuuQeaUgv9ldKHi9mYQE3lTqUg/
 ntjH4dZZncyaIbRo9lJsWXLn1KhuzQ0JCkjOIfK5Fp3be/O8TrbopCJPWR8Y2NJkMBhMQ79rZN
 YZ1F6qgEvBvYqZUhnYhJboKeYFTF//6/P13H8AOmwrmuFAAAA
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
        Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690062955; l=1780;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=71d3MCYkA85zokTlI23bWcE++G7REBpiXeQepGnAaL0=;
 b=PbzkmCRHeRzjCh7JRWfarJrOR8diJDl6IqJHpP88iO8v5aQ6WpmjznPBifIp0rCLuqJTACVjW
 stLIAsU/ZJ5DU/fkUxbXckIxo4Zn27rmtYQ3YKf+E2pmVBKU4qXjwML
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BeagleV Ahead single board computer [1] features the T-Head TH1520
SoC. Similar to the Lichee Pi 4A series from Jisheng, this adds a
minimal device tree file to support booting to a basic shell [3].
    
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
      riscv: dts: thead: add BeagleV Ahead board device tree
      dt-bindings: riscv: Add BeagleV Ahead board compatibles
      MAINTAINERS: add reviewer for T-Head RISC-V SoC support

 Documentation/devicetree/bindings/riscv/thead.yaml |  5 ++
 MAINTAINERS                                        |  1 +
 arch/riscv/boot/dts/thead/Makefile                 |  2 +-
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 61 ++++++++++++++++++++++
 4 files changed, 68 insertions(+), 1 deletion(-)
---
base-commit: 295e1388de2d5c0c354adbd65d0319c5d636c222
change-id: 20230722-upstream-beaglev-ahead-dts-d651af307fa6

Best regards,
-- 
Drew Fustini <dfustini@baylibre.com>

