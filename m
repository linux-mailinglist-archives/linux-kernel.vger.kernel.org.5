Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B17809CB2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 07:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjLHG7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 01:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjLHG7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:59:31 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB0B198E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 22:59:31 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d2f1cecf89so206895ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 22:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702018771; x=1702623571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAuafsSJin/545S9JBl3k3169/mG+pk906+BZqM02rw=;
        b=LRDPeH5c3X1gTwXbBsyhAE/Qfkm2in7DS7OWrRZlWbwmq2SiHtQj8ogscfsNPh7on/
         Yf385E5UGVZYYBDjkL793HhhuPofS7TvBDFsu49/F0JLVPrvBlNkppRg/iUi6fhxxt8M
         ULYMLrGQIYAOKgkoki617P1KFpo5XYEqMC51lWtIoin+xVQWWhDpckFkmnLxcF+MGYUl
         /WpSGoI5AhsIo3MDOP4y2CiatZVzJ2alhoavN5CUw5IRKPoeKgKapzcM9HVFFjBxepnp
         XLuHItg1WOE9NakN2u5GaapYffw7YczLfray0h29Y3efzJ3zzhqNg9Ou4ixQLh9viXKJ
         Bk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702018771; x=1702623571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAuafsSJin/545S9JBl3k3169/mG+pk906+BZqM02rw=;
        b=YpeGR7O6fmWoJ2UfYuL7n222ax0yHWGO4QJSY5VW8H6MaQ5FkL24XCJFvzSquvgaVO
         K+czv2ehz1GhTaALvyFUbR4aSYZFmOvElzwO1TDNXtYB4t169381e+zwCskudPqayEIH
         s4bZJoL9R+MeYN0RRUBC6keV0JY3U59EeSqR6pFNqXaenzC9eQWeSjZM8QtVGPcNRgBU
         k160LUMFXAVhgXSj2zIHg4c+vY4/eRbfW7sEAak1lD5yCCVD8FF8vTca1VxBbr739cxY
         /yzQz4/pJaDU7kCskt7tzOHMtK0GXr5W4HDWT9+rbEYeR9WYwjlW6t/bLvCc8nHXe2W6
         9Zxw==
X-Gm-Message-State: AOJu0YzoZKXIKgDVCIMyqJnUVTDSatvrxt7ArT5eOwRoS8kNBV/pBjEF
        PCsWqzB8qmVDE/5ors6KXUbD
X-Google-Smtp-Source: AGHT+IGflETh4yKi3d3wNFGR84GW61XgeduRIXTsZv1jIX1NkcqrGsIZt50fSYYR0Goipa+nqYoolg==
X-Received: by 2002:a17:903:228b:b0:1d0:5878:d4f4 with SMTP id b11-20020a170903228b00b001d05878d4f4mr3198154plh.5.1702018771023;
        Thu, 07 Dec 2023 22:59:31 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.142])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001b03f208323sm934263plf.64.2023.12.07.22.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 22:59:30 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ahalaney@redhat.com, quic_nitirawa@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 03/17] scsi: ufs: qcom: Fix the return value when platform_get_resource_byname() fails
Date:   Fri,  8 Dec 2023 12:28:48 +0530
Message-Id: <20231208065902.11006-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
References: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value should be -ENODEV indicating that the resource is not
provided in DT, not -ENOMEM. Fix it!

Fixes: c263b4ef737e ("scsi: ufs: core: mcq: Configure resource regions")
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 852179e456f2..778df0a9c65e 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1701,7 +1701,7 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
 		if (!res->resource) {
 			dev_info(hba->dev, "Resource %s not provided\n", res->name);
 			if (i == RES_UFS)
-				return -ENOMEM;
+				return -ENODEV;
 			continue;
 		} else if (i == RES_UFS) {
 			res_mem = res->resource;
-- 
2.25.1

