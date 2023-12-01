Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B985800E51
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379435AbjLAPPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379406AbjLAPO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:14:56 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246CA171A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:14:59 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cdd13c586fso2048015b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701443698; x=1702048498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5u5mj8ueK+oc2yv8mZg26TvQm1X83rBh8cXq05A5b8=;
        b=OqYs0GmF8HFxp5IsgzqAulfJFTwog24rf3mni9vKI2/sxOm9JPq3BaymnyA3lIYbDq
         lGSX+JeE8BOmoWcJ/af2/C8Z+yk8j73ivOFvKMKt3z7hSLpuZBIN2rheDuC1e24em4Hu
         eNpbL5BMEQjQQjMX5piE943Zp5ANR/GLCN2tG1JtzFsrpDZtQ2cLI9EoNr/QiQVAtCf3
         Q5i7E6PPHlYSfWrNvjBgtCYiSeCGGs9H4Kz412qih8tCbREub2ythCx2gF1NU65jOOKh
         GW78sJammyY7wBmDChniak6rErGEUS+maCY9+Pzuo4QwbzbFoy6qqG1nfNpQCAR/9fWz
         DMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443698; x=1702048498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5u5mj8ueK+oc2yv8mZg26TvQm1X83rBh8cXq05A5b8=;
        b=p1aEMkSo7WzHBoWhBBwTLlLaZh7SVzjC3RiuaDAAL9QiOeSQELO0pjfLfiNCY2J6tp
         gcZkjhlVkOZlPRcUeM6BatQ6VVJqDEi7rpNShdQKOBfeNAISsL5BW4X17Ae1kZXtP4sI
         v6FLgpLwHbfuhHxXyZ6qBqeq6jNZu2GhH3bsFnuxOI+RN9ypD2A/+WvynLk/JjjDu5Oc
         qzG7BA3qp+BG2yC1bq87aNWwScZcHftBoT+CEsmPJkyHZ7NszBziT9nPlerreFzjNaYF
         9/IFK5rceOhsEv6lENHxrG99rT00TRA74RBgskmwS0z3Lr91zh5ZjhPfV9kpgg2Vmdo7
         CITQ==
X-Gm-Message-State: AOJu0Yyj267iZcYftNaNa7jQVQk0B1qg1DFIWdhTkYZnn8eqkHKVEXpl
        uOARapaWA6qpj8K46OjTCH0f
X-Google-Smtp-Source: AGHT+IEjBAHxDNnswReyTsQ/wgyRVee0zz+RTPON/r87o5NDp9vCjrHC67XAbwc0Yi+6bHfU1R4nag==
X-Received: by 2002:a05:6a20:548e:b0:18c:8d0f:a794 with SMTP id i14-20020a056a20548e00b0018c8d0fa794mr19592802pzk.19.1701443698551;
        Fri, 01 Dec 2023 07:14:58 -0800 (PST)
Received: from localhost.localdomain ([117.213.98.226])
        by smtp.gmail.com with ESMTPSA id s14-20020a65644e000000b00578afd8e012sm2765824pgv.92.2023.12.01.07.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:14:58 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 07/13] scsi: ufs: qcom: Fail ufs_qcom_power_up_sequence() when core_reset fails
Date:   Fri,  1 Dec 2023 20:44:11 +0530
Message-Id: <20231201151417.65500-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
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

Even though core_reset is optional, a failure during assert/deassert should
be considered fatal, if core_reset is available. So fail
ufs_qcom_power_up_sequence() if an error happens during reset and also get
rid of the redundant warning as the ufs_qcom_host_reset() function itself
prints error messages.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 604273a22afd..4948dd732aae 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -359,8 +359,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 	/* Reset UFS Host Controller and PHY */
 	ret = ufs_qcom_host_reset(hba);
 	if (ret)
-		dev_warn(hba->dev, "%s: host reset returned %d\n",
-				  __func__, ret);
+		return ret;
 
 	/* phy initialization - calibrate the phy */
 	ret = phy_init(phy);
-- 
2.25.1

