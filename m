Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779B27F5311
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344629AbjKVWMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344631AbjKVWMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:12:49 -0500
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AC61BD;
        Wed, 22 Nov 2023 14:12:45 -0800 (PST)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-359c1f42680so876265ab.2;
        Wed, 22 Nov 2023 14:12:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700691165; x=1701295965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shYyO58BPes3ozOUzmFhahNxoCiZTriaHChWVdh269w=;
        b=omMUj/9PmI/bVj2XUQJZ0AiwhwX9qoa4nFEKbAlgSRZPyU42S9f74UBXRARR0Zwgy7
         NhhtmoTYfDCV4LFD0ZUSVs3jJZOl2dhE/j5O2/AenNl+BILKH3ztmQhJyVY585bqa3p0
         BXnnjjOGdo8yavzG4tuE/ErJntQJU4t72nx2zpbW9nlWKGEEIF3n/exxSY6u7qoRL+z8
         DdRBIM/uEZ5sQyc19qWeKZ9WwJ3zotIioH3xgQrmwRfua7R18PF7D+M+rXAPQ20+l683
         wZMx6aIt8eqCeSMQeqHsAblCfUbHEQVtreyuJYsEnk200iq2h8hbsSdJSJKXOoUoNkTf
         CgGQ==
X-Gm-Message-State: AOJu0YxRiXpIsAFED8Bxeb0izCY+RvV/Vf7+VqEUygUbR4UuLWODM+yp
        lxW/gfGhfK5pzvh7FNsXqZwV0nMDpw==
X-Google-Smtp-Source: AGHT+IFMJzsEvpbSktexSSdFIfR9OaWDnu0zBfHOB7Y/r6iYkYi/TaZpUgTAHm5TMgYN9AvcD7iJ5A==
X-Received: by 2002:a05:6e02:603:b0:357:704a:8699 with SMTP id t3-20020a056e02060300b00357704a8699mr3547266ils.8.1700691165100;
        Wed, 22 Nov 2023 14:12:45 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id em4-20020a0566384da400b0045b4a059a57sm91639jab.44.2023.11.22.14.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 14:12:44 -0800 (PST)
Received: (nullmailer pid 2753840 invoked by uid 1000);
        Wed, 22 Nov 2023 22:12:33 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 22 Nov 2023 15:12:34 -0700
Subject: [PATCH v2 3/4] riscv: dts: Always enable extra W=1 warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-dtc-warnings-v2-3-bd4087325392@kernel.org>
References: <20231122-dtc-warnings-v2-0-bd4087325392@kernel.org>
In-Reply-To: <20231122-dtc-warnings-v2-0-bd4087325392@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Conor Dooley <conor@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As all RISC-V .dts files are W=1 clean, enable the W=1 warnings all the
time.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/riscv/boot/dts/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index 72030fd727af..a7b17e0ac8c8 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+
+export KBUILD_EXTRA_WARN_DTC=1
+
 subdir-y += allwinner
 subdir-y += canaan
 subdir-y += microchip

-- 
2.42.0

