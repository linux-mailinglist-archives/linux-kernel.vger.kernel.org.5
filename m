Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46537D62CD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjJYHbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjJYHbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:31:22 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B41C10E3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:31:15 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c50906f941so81063791fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219074; x=1698823874; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lBWrjj6loRYq5BKdnDa4SkUsmmY02JfhSwBMKyXE3kI=;
        b=e1DT7R0fVIn0oUZB60XRIPRZDFlMsYosYElmTvk9AS5bpQUJYwjMAKroem4x5Xih5b
         bYWodWZzBp2Xjt0jlsb4riLG4u4CLDiwvIpVM+SZ0m8ipxSeYCc4pC2l9kobWfHDz4nj
         1NCshwEwQYvD7+BWY7xyxpiHoTwLBsSRsX/GWyBxijTPc1b7lvOO3nYZD0Y1lf/UlTAd
         +TXLo7Lsd8v95cG66tagEFSyK9fOBZNpd0358KFdnP9MKnVcVlaRkYVrvdcdjY3Gnn3+
         EEozLqbsn9pOE4fMpT37mvwtIxpVGhbTBwHHeSQ2U8i3KvvJnMbCI08Tvd7YdKGnwhcs
         xLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219074; x=1698823874;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBWrjj6loRYq5BKdnDa4SkUsmmY02JfhSwBMKyXE3kI=;
        b=fKF5+odtHzc3dq3EZbQkqgdLjpAMjq/eBpW3+5pKNe7AXFp5ycH01PuS1FI1ZVPfww
         5UtFlOjW9XXoaCDJsOyZYW414y7j9If5jXPOctLRCsZcwOlDsTEMycuTMeDPFf3Rjkfa
         dtcy6IeJnSXYebU2KvdrHRz0NImlj7lH+cjZQezV47hQh78N1fkUO6epW1spkGL6cdml
         1jOFUZhnZGGjUGjUrZT8hXfVypIBByS0vu70Gq9GcYuvFGMobx3MPrT9IsBOYrq+CsHu
         bwMvuRMhssb6ia832QC5g79dO9id3ly7SB9xNUZUMu3R3QUJmixBPvh50376UuI5ZhD7
         8iwQ==
X-Gm-Message-State: AOJu0YzEBML6oaP2t4m4iFlpEox9ov0mhSUsU/Myk1LmD+Pi4ng+Deap
        IXGn4eZ8s/NQ4XV8DhsnqOlXZg==
X-Google-Smtp-Source: AGHT+IH8up4Jiujoea6IKHrkO6WE94yNAtvyV2dpk4JuhvvVXScxJvSSpC8IlnxTSazoTvw5G1EPdw==
X-Received: by 2002:a05:651c:1695:b0:2c5:1a89:41c6 with SMTP id bd21-20020a05651c169500b002c51a8941c6mr9922535ljb.33.1698219073772;
        Wed, 25 Oct 2023 00:31:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b003fe15ac0934sm790563wms.1.2023.10.25.00.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:31:13 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:31:12 +0200
Subject: [PATCH] soc: qcom: socinfo: Add SM8650 SoC ID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-socinfo-v1-1-6776a5183fa0@linaro.org>
X-B4-Tracking: v=1; b=H4sIAD/EOGUC/x3MQQ6DIBAAwK+YPXcTQGq1X2k8EFzaPQiExcbE+
 HeJx7nMAUKFSeDdHVDoz8IpNuhHB/7n4peQl2YwyvRa6QFryuxR1nF4Ktyy1EJuRUmeY0jorH0
 pZ6wPk4Z25EKB9/v/zOd5AeO0SkFvAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=S/kxhY5hyKd6ZWpNvLQubweTRYoskRC3jilV5uoTGlc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMRAvIJdqLqCpko+CqJiGbBQ9ugsuJiNKU2BKS5Q
 jV9HaIiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjEQAAKCRB33NvayMhJ0cviEA
 CSYN58LMDoafxdi98u7fWxyKT6UCitXoL49tY/6BwOYyhGIFwQlMYxDq4yS00R+tuD8lTVy7IWryTW
 gzg0luXYM1IM/FgmROWXMyaOZhCN2altwJrjpzlZMhuJaKgLwwr/+CcDrX7ZZ7EsA/TUK59cGKwJTZ
 7iZAY1okKzivEuFhjsrKrOaynEkfqpa0k6qXQ8gi5lTIDcr6KrDU0Psyoo2F3mJ8z4Gl2PykIVeavX
 dC6cXDbE7JwTImFwwGpBCKE/S5s5mF8Evifbq5mPt3GbxXjWR/qL6EEcUb+jGoZIbdXrS8c6JPXlrc
 ONDWnUxhY8p4xS44RmHZNHQ1QnEW4X76P8R4uIjPSBt6M6plEAvh5U/YX58txLJHuE3hWX2V0D8poP
 bn1whdrE5sv7Rigr5PrW1C190t4W32R24hSr5mk4oLQUdsqyHac2UP4hyZh2TJvcc0pVMqbmlhZ9cg
 WU4kksy7VE65zCvXm5tCLNG5cn0Nh4AbdXg9gIxUBjImmWHjjjEIFAfB87viSblTZrpG8dyGAJ8Mmt
 KKUInLZg7N95XYoBo/n9bqmYFoLpmvVR27MtdjVnmLx6DtMTrjVn+llDmuyGtuycfcOqdYHWFwyvs5
 wYCfyltpzWeaMJKI8PXUU7LBZXAkZmwFKsINstqgL9Zx3pfLiBDi3WatU6eA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SoC Info support for the SM8650 platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
---
 drivers/soc/qcom/socinfo.c         | 1 +
 include/dt-bindings/arm/qcom,ids.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 51e05bec5bfc..8e8cd4ea58d1 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -417,6 +417,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(SA8775P) },
 	{ qcom_board_id(QRU1000) },
 	{ qcom_board_id(QDU1000) },
+	{ qcom_board_id(SM8650) },
 	{ qcom_board_id(SM4450) },
 	{ qcom_board_id(QDU1010) },
 	{ qcom_board_id(QRU1032) },
diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index f7248348a459..51e0f6059410 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -255,6 +255,7 @@
 #define QCOM_ID_SA8775P			534
 #define QCOM_ID_QRU1000			539
 #define QCOM_ID_QDU1000			545
+#define QCOM_ID_SM8650			557
 #define QCOM_ID_SM4450			568
 #define QCOM_ID_QDU1010			587
 #define QCOM_ID_QRU1032			588

---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-socinfo-a4470a24cf91

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

