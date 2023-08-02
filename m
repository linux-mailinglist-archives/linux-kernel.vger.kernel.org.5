Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A7276C3D3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjHBECN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHBECI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:02:08 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19309B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 21:02:06 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bb84194bf3so39779645ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 21:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690948926; x=1691553726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vG5UMw6bFZ2XuN8CCsSVN9Y60w1sWvQGrsbmsXSfDCg=;
        b=l0OlMBx+GytmlHiryoJm4BsFsflyHSrNEeowcnna3sb2VRaFNPQCkpXkOpIbypjAXi
         P1qKRrhuGKhoouanf6XjGT8QqcWaAklLPjPvz19Kt2vdqd3OfaeH5CWRXMVwkP/VIDaI
         Q3ejhBU1HEbl40qJvIQI/P8DnE1TQmXaQB3Uv8XKF4jtXj+Pe40hkHTfBPuKKORRfwmF
         BZ25EDRGgRABT1sRKMrBqDNiqT1VzNPpdNkkSZGk3Fekj+Ud8ayt5KJmp2/loDq0+hEt
         UcOqeSdiYu+eUPiLzYwNkJ8bpFcuoKXcmpj+UU+pUCs2uedvZa6tz2CG/p3gCUflrPaF
         z5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690948926; x=1691553726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vG5UMw6bFZ2XuN8CCsSVN9Y60w1sWvQGrsbmsXSfDCg=;
        b=STNSknXTWpVG34l0UUA1sXQz+0azaqymNSItqVRpy7keIeoFzWWB78SDfjuH3Jf4qb
         vIv31nudiq9CJcp+3BQ0o1mltZ//Cuu4VimtWwg72tJC5ZLGGhEBlQwSYwFkgLtnEqiM
         n23mBKEePNhCBtfLwCI39/J4H1g4tV05QZcfyP2tyRAQINukkUX6eLukGJaEYQvpfE11
         NUvXxxbMWriy8efMMlisBUIw7Lokbwdtc1TUlYNbL0HF/nD+mY1Sq1r9PTPHrkH188ur
         O4Qnt2nGtpkL65SZwJu2nTxIO0/zuOnHCy3DpSWobd3ai9U7UcA0hBm4gu2wwHE+U1Zq
         fhVA==
X-Gm-Message-State: ABy/qLZUXFNQ8xeG1DyivKmyeTACGU0QkEtFOmDwgssPMnjuUwfCyKsd
        crMefAw2SGDH55hs4AucGKhT
X-Google-Smtp-Source: APBJJlFdwviOBoJsVp3olVv/BcGe+WEfRsc/zCYIAaAGRExJh38BwE9IFhqgUoI63zUxsukJQ701Aw==
X-Received: by 2002:a17:902:e551:b0:1bb:a125:f831 with SMTP id n17-20020a170902e55100b001bba125f831mr17474097plf.58.1690948926150;
        Tue, 01 Aug 2023 21:02:06 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.129])
        by smtp.gmail.com with ESMTPSA id b12-20020a170902d50c00b001bb8be10a84sm11202710plg.304.2023.08.01.21.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 21:02:05 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] scsi: ufs: qcom: Make struct ufs_qcom_bw_table static const
Date:   Wed,  2 Aug 2023 09:31:54 +0530
Message-Id: <20230802040154.10652-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ufs_qcom_bw_table is not modified anywhere. So make it static const so that
it can be placed in read-only memory.

Reported-by: Bart Van Assche <bvanassche@acm.org>
Closes: https://lore.kernel.org/linux-scsi/43cd0057-c6d8-bc92-08f4-d767336d2cfe@acm.org/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 75a1fd295f34..0341c025e818 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -58,7 +58,7 @@ enum {
 	MODE_MAX,
 };
 
-struct __ufs_qcom_bw_table {
+static const struct __ufs_qcom_bw_table {
 	u32 mem_bw;
 	u32 cfg_bw;
 } ufs_qcom_bw_table[MODE_MAX + 1][QCOM_UFS_MAX_GEAR + 1][QCOM_UFS_MAX_LANE + 1] = {
-- 
2.25.1

