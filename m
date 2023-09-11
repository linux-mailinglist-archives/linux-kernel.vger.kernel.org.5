Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D5A79BC5C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349734AbjIKVel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244330AbjIKUH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:07:28 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20781A7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:07:22 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-500c7796d8eso8060372e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694462841; x=1695067641; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/oE5bznBg4aKiDvY6jBIZITJo1kBxpGdGt4GJUgziI=;
        b=C1o6HFTcLASMKnVuE0Eum4+Ec/+aNQc1iywqhcTiPOg++IMIKOuwQOs1lwnrrxxs/O
         JCtj6mrPBdhtPl4IKI6AyaVTOyTPLTyoPht5QdH4ub3gOZLWvIlxuOoYTTW7rABi/iM6
         FX9daCrrfYMBRvK9Sh94HUFMslo4EBscKZqcJ+yPGcPJJ8KNy1EnEUknx6PbRHU9Uqyi
         zmeFOS4cy08X+9XtxnVCjmmRvzP0NRFVyZRv6Bg4Wlw2wX3OhE49Yh2DNBrZhVuIc3ML
         KiUQAgp2hAh8cv1CQVzXppkcKkwFosO4E+fjm02A3mfmcKSlITAN05c3hhM01/UH70u3
         Egxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694462841; x=1695067641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/oE5bznBg4aKiDvY6jBIZITJo1kBxpGdGt4GJUgziI=;
        b=QWhYJZrtlZOWt4qXdaEQcDVwkqiGD6tamscokX4PN5CQtpPvJdUVttiTPDpgOemQZ7
         ZB4DIH2yILaoVpv6EoLCUT0C6DgRc4KnEaD/amrwoYC8VIkeMEQZiwPq4tyYv6/Rdimr
         BO5PvHq4kjkRovM5xn+zzowCkoJcvS9Dt4HOB2oQjfFIvLsKgBhU3d3tBmXBw8Hsr6c+
         fC56SusjXizHFVgAvbpi8kHHklNX+zvvnccEHLyEXNQM/+cHTTbqh/jpSPGBZb8FQ9Qy
         bVJoMb6qP9wd6zVbftwONraxfTcHyE/3MEhC92qkFBRzWU2vCbPWZJGdirhraji+Drs+
         nexQ==
X-Gm-Message-State: AOJu0YwIWFLDT2LLGge7dm7JBS5/+WxlDVBGp8eb/kt4HbUJJp/pu1cV
        YAj8+Qv/edLqMfZfxRf5cDw9aw==
X-Google-Smtp-Source: AGHT+IEAONeGtGXQL5OMvfLz4zVnvNRaE/NPqN7TVCaRAiiECgk2yb47kEGsYyVaCnTkcckP44AI3w==
X-Received: by 2002:a05:6512:3710:b0:502:bdbd:841c with SMTP id z16-20020a056512371000b00502bdbd841cmr2848849lfr.33.1694462841235;
        Mon, 11 Sep 2023 13:07:21 -0700 (PDT)
Received: from [10.167.154.1] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id z19-20020a170906715300b00992e14af9b9sm5753258ejj.134.2023.09.11.13.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 13:07:20 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 11 Sep 2023 22:07:15 +0200
Subject: [PATCH v3 2/2] phy: qcom-qmp-combo: initialize PCS_USB registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230829-topic-8550_usbphy-v3-2-34ec434194c5@linaro.org>
References: <20230829-topic-8550_usbphy-v3-0-34ec434194c5@linaro.org>
In-Reply-To: <20230829-topic-8550_usbphy-v3-0-34ec434194c5@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Adrien Thierry <athierry@redhat.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694462835; l=1296;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=cNyDA6fMaENsuHCLNNVW+UYlzx4pIxp/iYgLeni49ug=;
 b=uHEXpp8NQFwG0H2NddAl1WapfQ5ssKAAw81IEZDNcf3fTfOUgytXxoDVsDQ9foqs+IqEJDHGw
 ptoxYYM09iNA2n89eJVs81tUR7PiSpIfuKVTYNJw+2k3HyugLS1GbuY
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, PCS_USB registers that have their initialization data in a
pcs_usb_tbl table are never initialized. Fix that.

Fixes: fc64623637da ("phy: qcom-qmp-combo,usb: add support for separate PCS_USB region")
Reported-by: Adrien Thierry <athierry@redhat.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 8fd240dd5127..5e6fc8103e9d 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2555,6 +2555,7 @@ static int qmp_combo_usb_power_on(struct phy *phy)
 	void __iomem *tx2 = qmp->tx2;
 	void __iomem *rx2 = qmp->rx2;
 	void __iomem *pcs = qmp->pcs;
+	void __iomem *pcs_usb = qmp->pcs_usb;
 	void __iomem *status;
 	unsigned int val;
 	int ret;
@@ -2576,6 +2577,9 @@ static int qmp_combo_usb_power_on(struct phy *phy)
 
 	qmp_combo_configure(pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
 
+	if (pcs_usb)
+		qmp_combo_configure(pcs_usb, cfg->pcs_usb_tbl, cfg->pcs_usb_tbl_num);
+
 	if (cfg->has_pwrdn_delay)
 		usleep_range(10, 20);
 

-- 
2.42.0

