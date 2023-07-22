Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB66C75DEB9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 23:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjGVV4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 17:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGVV4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 17:56:00 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BD71BF
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:55:59 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-66872d4a141so1821751b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690062959; x=1690667759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Op8r3roG6OOa9Lv1oC4Z/qAoTQvBrQgFrwVjhxRoefc=;
        b=mTdJFi4UkmtcIztVWh5pYf8zH4Z4pB5cWYDL86PAivIdbNh9UfwYadaN9XjWHg5S2a
         AgdVNuWOQs9lRuGL5m3CfaSWhAnKLNqWgvt4VqbAv9X3828cCDCXf4T/M4IfBD9c/dfp
         Eq7qlpwUHmok/4vGNAegu6ixgsSRvLK+fyp+N/hhC8jhLjC5in2DRiVVMuH53BcBLx42
         7xk0vkrr65OB421xPAmnwhXICEjdNIlzPro/O9nBJo7Xejbi1OUeluzoOOyAof6i8OqL
         hpGXy4vbuNMV0vv7zLjijyQQESkc+EC/9WAuzjhPCAxX20uFGlnzc9jzzYwz+oaUp923
         lMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690062959; x=1690667759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Op8r3roG6OOa9Lv1oC4Z/qAoTQvBrQgFrwVjhxRoefc=;
        b=erACYeqhgtxeuw+lRwVqZ5qDp1ts1kVwqDT5dCWZTGDtWDh83x0d4D9i/ez5PRGhRd
         C1m1NhdM4fHtNTkF2rsZBva6a4VoEmCxu3G6Iq84CVTIXqbE0j+ehvMFGD64hPzaTqKy
         oGGUyy890+STGD+K/Km2dWWou2ekkzKjM5QyTtOTugL77FBCq+Eu2wdQlBgIagNjS5U8
         Pve70rJ3ezMW8NRLmWuV+vlIbs54QyqqtYNdZwhiMrRSy61m4fvG5lj8OlP9J9MrUlZb
         HEIU6r2aBgJUT2Xu8xjZNIP76mZsH6Mcivh5GveJ/m94GENrNjGUtM4WIcdu9xsLuNjm
         I6Lg==
X-Gm-Message-State: ABy/qLYkCir+Llu5S69w8eMosuX126CHJOqtUC1L/FcIAM/wzup8M+A8
        OFY//xT9HA1LvWzbdyzcRcqwoQ==
X-Google-Smtp-Source: APBJJlHi9uPk5HT8P/Bh1fdT5M6EBnO2qNX5zOmrDLhQ6F7I/qp+4TqP6xLAhgWDjArdpAjcRvYiqQ==
X-Received: by 2002:a05:6a00:1821:b0:680:6d16:8f8c with SMTP id y33-20020a056a00182100b006806d168f8cmr3608089pfa.32.1690062959005;
        Sat, 22 Jul 2023 14:55:59 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:2a8c:966f:392d:7230])
        by smtp.gmail.com with ESMTPSA id e23-20020a633717000000b0056368adf5e2sm5517642pga.87.2023.07.22.14.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 14:55:58 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Sat, 22 Jul 2023 14:55:41 -0700
Subject: [PATCH 3/3] MAINTAINERS: add reviewer for T-Head RISC-V SoC
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230722-upstream-beaglev-ahead-dts-v1-3-ccda511357f4@baylibre.com>
References: <20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com>
In-Reply-To: <20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690062955; l=651;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=YCC8HQBmQ4ArnnCjLKzrNbZrbvachARgWcNH5nyq8v4=;
 b=DD8uZ+RrE2UU4233SPWBBZvAtSm0Fj+EF7e7TvOfSnv2VL+fdfssMjERfpDTyWjmqIZU2m4G6
 jzN0MYkPTCsD5FC+ozl+/PB+Qr+QiUL5Kuhfs211l48QYFTbmDmmQ3C
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will maintain support for the TH1520-based BeagleV Ahead board so
adding myself as a reviewer for T-Head SoC patches.

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d516295978a4..eaec3333f2ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18326,6 +18326,7 @@ RISC-V THEAD SoC SUPPORT
 M:	Jisheng Zhang <jszhang@kernel.org>
 M:	Guo Ren <guoren@kernel.org>
 M:	Fu Wei <wefu@redhat.com>
+R:	Drew Fustini <dfustini@baylibre.com>
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
 F:	arch/riscv/boot/dts/thead/

-- 
2.34.1

