Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EE175C0DA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjGUIIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjGUIIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:08:09 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C25D273A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:08:08 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-579dd20b1c8so17508717b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689926888; x=1690531688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqcAnVxpvMo7IksBTYj7fHRMjHClyEVoFOPZWnp2zrc=;
        b=FiaLlQpG+FX04kcW5hPzlM69UWqegsCa8SHht89DbgfZwxyZ2NPixF4HZ+bjd7wy80
         w0A2C7YWmkD11MfX3bs7qVweeGnF99K6lmjgksE4chTNdK2n/UggSDKHtaI5ZUbxNNPO
         0aCkJQsa5a3qlFG5A6KhT+53F03Rt19zOX/BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689926888; x=1690531688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqcAnVxpvMo7IksBTYj7fHRMjHClyEVoFOPZWnp2zrc=;
        b=FZhHZI6xXXPDLiBRtrTC5b2YsGGYAtW3lqRv0PRcFSzwxMoD6Uv+MmgaVK1tkzFwui
         QOZq7iDaQisJ0ugC1tsqEtw0v+8UM7Fh6XDNbOHrKrhCZu+sdieVhMB2PRx9O2DYNlCF
         LRBlTKpI4a7fFlfhZDV7jKTUimTtjOat7K3SFa1Z0e87pzFyjDhBRXsVZt7W+Qxzjomu
         CS7DR/HTO4HgSoe6IGvfd7Syw7JRGuL1+zFdTiLKg93IqZ9Uj780Honm9h8xr9jtCtEW
         wpbRpipECcPKbxP9PdXSuEeC5WD63Eife/Flf+/Hobi0kHvN+Z2SW+NSQoCZ3BobF2Ik
         DHMQ==
X-Gm-Message-State: ABy/qLaQ26gUaxqtph105trmaYzuZNOE+70FQ/8NHQpuZPRQqWfvxJrM
        VCN2V7DXR+vxDcNfcpoLn82Tsg==
X-Google-Smtp-Source: APBJJlF8D2kE/WLC7WdE8mYRIasoZYyBucxGnkw1pAE30KqjiBSmN0qvmA+xlqWibibNJkQ/CaUsYQ==
X-Received: by 2002:a0d:d6cb:0:b0:561:e8d7:ac6b with SMTP id y194-20020a0dd6cb000000b00561e8d7ac6bmr1388896ywd.49.1689926887693;
        Fri, 21 Jul 2023 01:08:07 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6d86:d21:714:abab])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902bcca00b001b850c9af71sm2740294pls.285.2023.07.21.01.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 01:08:07 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] mfd: mt6358: Add missing registers for LDO voltage calibration
Date:   Fri, 21 Jul 2023 16:07:42 +0800
Message-ID: <20230721080751.2012318-2-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230721080751.2012318-1-wenst@chromium.org>
References: <20230721080751.2012318-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the LDOs, except the "VSRAM_*" ones, on the MT6358 and MT6366
PMICs support a finer output voltage calibration within the range of
+0 mV to +100 mV with 10 mV step. Some of the registers for this
function are missing from the register table.

Add the missing ones for MT6358.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 include/linux/mfd/mt6358/registers.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/mfd/mt6358/registers.h b/include/linux/mfd/mt6358/registers.h
index 3d33517f178c..5ea2590be710 100644
--- a/include/linux/mfd/mt6358/registers.h
+++ b/include/linux/mfd/mt6358/registers.h
@@ -262,6 +262,12 @@
 #define MT6358_LDO_VBIF28_CON3                0x1db0
 #define MT6358_VCAMA1_ANA_CON0                0x1e08
 #define MT6358_VCAMA2_ANA_CON0                0x1e0c
+#define MT6358_VFE28_ANA_CON0                 0x1e10
+#define MT6358_VCN28_ANA_CON0                 0x1e14
+#define MT6358_VBIF28_ANA_CON0                0x1e18
+#define MT6358_VAUD28_ANA_CON0                0x1e1c
+#define MT6358_VAUX18_ANA_CON0                0x1e20
+#define MT6358_VXO22_ANA_CON0                 0x1e24
 #define MT6358_VCN33_ANA_CON0                 0x1e28
 #define MT6358_VSIM1_ANA_CON0                 0x1e2c
 #define MT6358_VSIM2_ANA_CON0                 0x1e30
-- 
2.41.0.487.g6d72f3e995-goog

