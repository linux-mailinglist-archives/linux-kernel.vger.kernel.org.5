Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B557762482
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjGYVbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 17:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjGYVbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D8C1FE6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 14:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690320623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M6R5PqHz89a5dYS6wq5jIGBjMTrYBr/afZbcaHTTyIA=;
        b=F0RQqs6vBWayEefcDpLTe3YUMiP6Rqc8UUht7x7qNwi3NXxQpRwB+NP+jLewqJCsbvd/1p
        ya1KvXnbb1J7SJz2bunVsvxc7i3DZGoIuDIY/CgJ6sw1nbMk+OVZL/ooVWwPdk6+PXWmgg
        7aAU+BRNRyywcdeAeRPGYSpsHEXUnfU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-NVcSCG44Mmy8bq-YUiw1Ew-1; Tue, 25 Jul 2023 17:30:22 -0400
X-MC-Unique: NVcSCG44Mmy8bq-YUiw1Ew-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-765ab532883so810335885a.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 14:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690320621; x=1690925421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6R5PqHz89a5dYS6wq5jIGBjMTrYBr/afZbcaHTTyIA=;
        b=dQF0oEL/cFU+7tFoGL3lSO+Zm2Qh/mi0yskKGc2BmPbatliEixF9TuqBpBKbITvxzB
         K/wo1I2qdWZ0S35jSbewyWxJyIbO40TbvJQ2YRVTLDsKI03/Je4QKXNt8mUE81i9OGCn
         b0yV059vE1ZYG/1DxEz2cca+Exmqz710bts5yp0tICDgOWx9dO5U6YbW7Frsq54uDl0M
         6M+xpGCtS9kJufYmu1mYhjLR88M2PoZeRc/TCov3Xzt7flPi48h/RVLmqybsYS/83bL5
         w/wxj7JzT/2UsbAZrgiKQm9WocMGVhXKkMV9c3KKFClLPCEnxH/sPBY+kJ1Ikz88Jm7I
         cZNw==
X-Gm-Message-State: ABy/qLYwcCTIH0nx8XI0Xs1nnux5hoLOwEoxptCpKkTdTsl6RNgZDmjh
        fPTNE4sDqhGf2eZGyB+hWh9Iko1C6HUKE3Dfb+OgfmIeL00rlUkcEp8dATcaMpEXPD4nDq65/va
        UIQXyUg801uiOU0SrPWl0ReoHIZGKTEfvs5+33MGzQueIdzcxXEvIt29Fom+dnUqMwc5sOQO7Lh
        dCpWi4jEkm
X-Received: by 2002:a05:620a:2545:b0:768:156e:41b8 with SMTP id s5-20020a05620a254500b00768156e41b8mr171833qko.56.1690320621372;
        Tue, 25 Jul 2023 14:30:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEXEDMipNpnjboiVX9tymuPzO29w0eF8hLR09Ab5g7ZDyLrlEARGaZBlmf5qh4U8wb5xzUttQ==
X-Received: by 2002:a05:620a:2545:b0:768:156e:41b8 with SMTP id s5-20020a05620a254500b00768156e41b8mr171797qko.56.1690320620999;
        Tue, 25 Jul 2023 14:30:20 -0700 (PDT)
Received: from fedora.redhat.com ([2600:1700:1ff0:d0e0::17])
        by smtp.gmail.com with ESMTPSA id j3-20020a37c243000000b00767d7307490sm3943067qkm.34.2023.07.25.14.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 14:30:20 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     ahalaney@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, jsuraj@qti.qualcomm.com,
        Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v2 2/2] net: stmmac: dwmac-qcom-ethqos: Use max frequency for clk_ptp_ref
Date:   Tue, 25 Jul 2023 16:04:26 -0500
Message-ID: <20230725211853.895832-4-ahalaney@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725211853.895832-2-ahalaney@redhat.com>
References: <20230725211853.895832-2-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm clocks can set their frequency to a variety of levels
generally. Let's use the max for clk_ptp_ref to ensure the best
timestamping resolution possible.

Without this, the default value of the clock is used. For sa8775p-ride
this is 19.2 MHz, far less than the 230.4 MHz possible.

Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 .../stmicro/stmmac/dwmac-qcom-ethqos.c         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 735525ba8b93..a85501874801 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -694,6 +694,23 @@ static void ethqos_clks_disable(void *data)
 	ethqos_clks_config(data, false);
 }
 
+static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
+{
+	struct plat_stmmacenet_data *plat_dat = priv->plat;
+	int err;
+
+	if (!plat_dat->clk_ptp_ref)
+		return;
+
+	/* Max the PTP ref clock out to get the best resolution possible */
+	err = clk_set_rate(plat_dat->clk_ptp_ref, ULONG_MAX);
+	if (err)
+		netdev_err(priv->dev, "Failed to max out clk_ptp_ref: %d\n", err);
+	plat_dat->clk_ptp_rate = clk_get_rate(plat_dat->clk_ptp_ref);
+
+	netdev_dbg(priv->dev, "PTP rate %d\n", plat_dat->clk_ptp_rate);
+}
+
 static int qcom_ethqos_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -779,6 +796,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	plat_dat->bsp_priv = ethqos;
 	plat_dat->fix_mac_speed = ethqos_fix_mac_speed;
 	plat_dat->dump_debug_regs = rgmii_dump;
+	plat_dat->ptp_clk_freq_config = ethqos_ptp_clk_freq_config;
 	plat_dat->has_gmac4 = 1;
 	if (ethqos->has_emac_ge_3)
 		plat_dat->dwmac4_addrs = &data->dwmac4_addrs;
-- 
2.41.0

