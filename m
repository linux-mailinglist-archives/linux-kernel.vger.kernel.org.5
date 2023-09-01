Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D1A78FD07
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349095AbjIALEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242270AbjIALEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:04:01 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9524F10E4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 04:03:57 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bcb89b476bso31579641fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 04:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693566236; x=1694171036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=duvwdvUou9ovP3x58ccTQUVl1jXo27Ajp0N7Ke2ouSU=;
        b=D6eAgRLMQSM+8VbQP1n9HMRa011IuMoUmHHHlNFYmuP+Ta/cVRv21Nn/Xz0WxA8itH
         no/6MyddrXNivZ++sr23BWFAv0HRD8fe4zSBIgzkEXnDOotIYt8J0Yd3zeal0I63Y29z
         lVPo/8uKTtYAIYPWQgIwONNjIPqHR6EKS480N8cstaAeG3PKAcHwpBhjw9od1Ge6FnD3
         OmahZf5dFCTVF7fRwaFh1kUehyysPfPDRUZtIwKU7CZhjfUwZJWErkOX4x6Lf8uqfjYF
         GzhM+M8Qu8AlwEtog8cCCADEBv3wWzOqC01bX7AmMG1yvO3SiSHpS+qRak3IPqvBP5iq
         aIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693566236; x=1694171036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duvwdvUou9ovP3x58ccTQUVl1jXo27Ajp0N7Ke2ouSU=;
        b=bmxRmQPHDCm464XbzH9TYLT6H1zPqkSEBf9r8UG0E5y0ZB6ApnGNtnapQI4/BBo1yM
         ZNe3kDRG4FihGWGpOlKs69yp2spTuzvY6hvsFDfyO2ngOp9uTe7c8GO0OGgG3+fdYeTX
         8hoaw1z63U0q13C0evtsfUUoxCysMMaL+za+yukVB+4Edtjuwc8sinnI/5buOW8OzxOg
         6JPL3XTBaUq0uIsdU5J3NB/43AS4+Cvic84cPBABEO9HNUAD8Vkm/hp4WFx3KvDb3P8A
         i9jKqdzDoKUkPrMXEwV8ebhKlFiqyZmcXkWBsTJLHF0FAngR8cRiy2NAWEtX0gDFQm/P
         RM7w==
X-Gm-Message-State: AOJu0YySucKQCNR+2BabNqjhuLxqgrv/1wbCSWB/H0ep/c4o8P2UgsYr
        uLj8PNh5NEgpZEoCMRFt2Ik=
X-Google-Smtp-Source: AGHT+IHt96lX9c0h5UQyEWxF/ahPrbLxtus8+mTps5mtTJvC+wZbk4BlT1Mxbxz0HUpBNBcdRAsH7g==
X-Received: by 2002:a2e:9c06:0:b0:2bc:f739:2eda with SMTP id s6-20020a2e9c06000000b002bcf7392edamr1356891lji.5.1693566235704;
        Fri, 01 Sep 2023 04:03:55 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:64d6:8737:b80d:a298])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c248b00b003fc01495383sm7667847wms.6.2023.09.01.04.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 04:03:55 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] riscv: Kconfig.errata: Add dependency for RISCV_SBI in ERRATA_ANDES config
Date:   Fri,  1 Sep 2023 12:03:20 +0100
Message-Id: <20230901110320.312674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Andes errata uses sbi_ecalll() which is only available if RISCV_SBI is
enabled. So add an dependency for RISCV_SBI in ERRATA_ANDES config to
avoid any build failures.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308311610.ec6bm2G8-lkp@intel.com/
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/Kconfig.errata | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index bee5d838763b..566bcefeab50 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -2,7 +2,7 @@ menu "CPU errata selection"
 
 config ERRATA_ANDES
 	bool "Andes AX45MP errata"
-	depends on RISCV_ALTERNATIVE
+	depends on RISCV_ALTERNATIVE && RISCV_SBI
 	help
 	  All Andes errata Kconfig depend on this Kconfig. Disabling
 	  this Kconfig will disable all Andes errata. Please say "Y"
-- 
2.34.1

