Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114AD808E4F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442015AbjLGQwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjLGQww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:52:52 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659DA10F3;
        Thu,  7 Dec 2023 08:52:59 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b9e07690ccso427073b6e.3;
        Thu, 07 Dec 2023 08:52:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701967978; x=1702572778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBWpeuUGETy3rsau1CIanjaFB3XHnIk3Ug7FoMVzpS8=;
        b=DroBu+9/y90GBDbk0rBjvxvi8/2ymAU6h2NIyk0nagPhEtVKUBO1z+w6p2NTRm2UIR
         3AxvIhWb2sKYMR+iMOWSYqvYDPFAgeDhL0XlWJN0BvlResQY/gDGVey6mqJR3JjK/AKr
         tm2Ml9C+gRJ1YFwg4ut4lBgUTf0GzAuL102wDOySF8iVrLivgAQwHt8+ugYg3waG5MfS
         wbmONqWQv/Ue2pwt8pt5Nnqa6fDtcgVZ0EycYSI5ljFy0ALif5LtFV1OSVz7rC9aqR2o
         6DC9fdDMMstgW+AgbS1R/TnQWNMIOz9wJSkrJbrE9mI6/8EQqsQKf/GC8s20b9o/fxZK
         bxFw==
X-Gm-Message-State: AOJu0YzNnpOKAStU47lksKKbV/iIgJQZ32+ne3nmcfXK/OEi4chX5ZvZ
        KAewGxa/I8H/iMvcE44Itw==
X-Google-Smtp-Source: AGHT+IGLJtSXaB9q+Z/tIRpqaXolbixm4Mmmz1DQ1syIQmhzmnw2iyLrGkzd9cTRmHPCfb8i7mQdUA==
X-Received: by 2002:a05:6808:191b:b0:3b8:b063:5d6d with SMTP id bf27-20020a056808191b00b003b8b0635d6dmr3494663oib.84.1701967978577;
        Thu, 07 Dec 2023 08:52:58 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e4-20020a056808148400b003b2daf09267sm14906oiw.48.2023.12.07.08.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 08:52:58 -0800 (PST)
Received: (nullmailer pid 2855942 invoked by uid 1000);
        Thu, 07 Dec 2023 16:52:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pci: rcar-gen4: Replace of_device.h with explicit of.h include
Date:   Thu,  7 Dec 2023 10:52:50 -0600
Message-ID: <20231207165251.2855783-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it was merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 3bc45e513b3d..2ca5b7983d62 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -8,7 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-- 
2.42.0

