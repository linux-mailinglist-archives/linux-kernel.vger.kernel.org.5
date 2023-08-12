Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD82779C21
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 02:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbjHLArl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 20:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjHLArj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 20:47:39 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1205B10DF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:47:38 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bdc8081147so2426265ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691801257; x=1692406057;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DeijLer+iQ1yTNsBhmCp+pc3Tg+drpD8NrA9bs7LzOI=;
        b=jhboQ5nYSX8Si1mah8gNOHs4iZEr/J2Ef5i1NA9qVP1EXw5Cmuuxw0Hyjl2HrAOZv7
         P/lq57Tg9pwtfi77ePWmFeE0AybM1YyDSNQu3Gydh9QJ12dJR1Cw5Xu6kd4w0wgCRosg
         +XM7wWskqnOq0kP3gWCHfs9aWft7N02XeV30LZskPZlXZpAdAwi2gWdiwzMbnlebVYdV
         vaRZVezKTjmkLV1392svkRdrzoLVdQ1T1wVvK6bTyYxv2zQwf9Wun6DxejsyrtsruJ6k
         3LZAdgGymB9OLzNEkHSL6JsLmoCvIZQoOn5hR6l8O68msyIuCsXK6XPaGzgQMsC3mrdO
         gKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691801257; x=1692406057;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DeijLer+iQ1yTNsBhmCp+pc3Tg+drpD8NrA9bs7LzOI=;
        b=NaFYtyJjQvBoNLXgyarRQCcFAfP/Z8KBtFzVlKe6uNBZJ+I22cVASFn1creSPN8Ls2
         FRUiKzQ9rjwogkAvW9sbh4Vl5wFbQxxSwFWXTZqrAS6eQ13yq8oV9o8ikyU5xG7ILOXK
         WGtp2bEmVSgIGzGvclppz5HEESAB+2YE/zqgMYYqLvhVlGxoxqOoippebVAjnNZH/rAP
         3EpR5Gv67QHKTpGESPzhHTi7eTCdFn+0UAR/qAuHB7PfoFbc0WFn3/FWoHgpe8ydKh0v
         tIfkAVwpuLtnYBDUIIpXRUpwcgLn3Eh+mRkfkd3Colww9poDPXEIq/VVRc2zMlvnA6Ey
         3Ryw==
X-Gm-Message-State: AOJu0YzPAcSPBu9KpKXoQSHytbMVuPDF0KNbmaQqGoyDu+0OtOv71h2E
        iq/dCf5GHiTGUFIu7A73TYYP7A==
X-Google-Smtp-Source: AGHT+IFUqsBSX3sAM2vTW05lL8kww3fgqy4Gp8gDRdpUORS4ySxv2rMKaBp0M16jTXGsFzuevyF1pA==
X-Received: by 2002:a17:903:1209:b0:1b5:5162:53bd with SMTP id l9-20020a170903120900b001b5516253bdmr4132072plh.33.1691801257518;
        Fri, 11 Aug 2023 17:47:37 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:5b85:b986:e090:9abc])
        by smtp.gmail.com with ESMTPSA id c11-20020a170902724b00b001b246dcffb7sm4559247pll.300.2023.08.11.17.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 17:47:37 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v3 0/2] riscv: Add BeagleV Ahead board support
Date:   Fri, 11 Aug 2023 17:47:15 -0700
Message-Id: <20230811-ahead-dt-v3-v1-0-aef2294bed86@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJPW1mQC/x3MTQqAIBBA4avIrBvwh0i6SrQQHXM2FhoSSHdPW
 n6L9zpUKkwVVtGhUOPKZx5QkwCfXD4IOQyDltpIqxS6RC5guLEZVGEhO0dPWkYYxVUo8vPfNmg
 G9vf9ABCWKT9hAAAA
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691801256; l=2003;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=KXruUC4m0GJJ2tG/yeNsrWAXuiSYwLQVyd8fgxtQfP4=;
 b=JylDP9oUkuZEpW4fXLJGGvGlX7V77+Vh17FFIFdl+LPteBDAnxNYnVhiy15cO1vRmecHLAo1S
 Itw7hFCfVvwDJl/LzGHus7sgql5xkb81no1b7x/uUd/9fTD6m47/1iZ
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BeagleV Ahead single board computer [1] features the T-Head TH1520
SoC. Similar to the Lichee Pi 4A series from Jisheng [2], this adds a
minimal device tree file to support booting to a basic shell [3].

Changes since v2:
- Drop the MAINTAINERS patch as it is not important and I want this
  patch series to make it into the next PR
- Add Conor's R-b

Changes since v1:
- Add dual license to dts file as Conor noted this is typical
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
Drew Fustini (2):
      dt-bindings: riscv: Add BeagleV Ahead board compatibles
      riscv: dts: thead: add BeagleV Ahead board device tree

 Documentation/devicetree/bindings/riscv/thead.yaml |  4 ++
 arch/riscv/boot/dts/thead/Makefile                 |  2 +-
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 61 ++++++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)
---
base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
change-id: 20230811-ahead-dt-v3-1d7e85fce20f

Best regards,
-- 
Drew Fustini <dfustini@baylibre.com>

