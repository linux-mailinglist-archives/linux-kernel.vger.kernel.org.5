Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017D277F94D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352036AbjHQOir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352053AbjHQOia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:38:30 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8755D30E5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:38:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3178dd771ceso6852194f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692283107; x=1692887907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utritafRnMiaSTyT0IAIApkzIcd4AYRvEhOST/jK4tQ=;
        b=wzVx8M87EJIxH2/TAQBSfLHDgPeyr6JLs9WhfVtcNUQQ6u50yhEy00vaJ104D6ckuH
         SlyuED6KH1dAFzAHAoGwQjLskL+MD93hn6Z1D5uXSzBpT7iiO3+E6lKU7EcU2Bsf80sN
         eqei4zS0ZCzUA7RfTIEFOpdcPjq+tmq0Tz8Jv0BLtk9GpjIo+jqWadLmzO6Lms02AiTZ
         ivchvM7LwRkp88q9vEJ70boh631oqHMIS3iRfa0w+yzpY1+PlHcf45keovJgzOMtg/80
         AgCNSKXjxWbO5OEUWsL00imi06kWHQrkrRHw9+9h5pbNO9dXWuON9W1WjaS4PTv/SjNf
         Astg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692283107; x=1692887907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utritafRnMiaSTyT0IAIApkzIcd4AYRvEhOST/jK4tQ=;
        b=OMYL9GPrkj8lpGoYdG+RjI4m8cNxemejm8rYkp0xbXR2czECW80gZr1MzP8K5qdOue
         X3E1aZOpPH70OJXIWpOO7f63nM4E0IhUG9MOqHRsGAVOWkF+nGphV3+g2/R+x95QOi+o
         Fv27dMguNG0uPte8IH0gG9yb///hiYdkhD9Ac7For+Py4G4x+bwGh497YgxVfuvOmOta
         SFbZ+XIGcb4wf3mKEYntGdkX9XdjPP6NbLTRsE3Hgr/F5TYLN6U4mRpmtiIdPw8LqsS6
         vULt+tYydnV4AAO2Rgwe4BiQHmBssHloakGUY6qb8GiRgdbN8sp22Ok39hCmaHYDXkgf
         17sg==
X-Gm-Message-State: AOJu0YwOBIuzbDaRs1HTNbLAY9FKn33dQfMjohVmPmSbesSgFoMdwuYz
        5tjysNS2nVTN652UNmRZ5nTqWg==
X-Google-Smtp-Source: AGHT+IF3Gtfb77Duh0RwzljBgColyv7QM8smrdcSeZUpNlSJJQPu84Ky2kTdveWklDoH8DpuiZzJbg==
X-Received: by 2002:a5d:61c1:0:b0:319:71be:9241 with SMTP id q1-20020a5d61c1000000b0031971be9241mr4055783wrv.25.1692283107066;
        Thu, 17 Aug 2023 07:38:27 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d4388000000b0030647449730sm25218232wrq.74.2023.08.17.07.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:38:26 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/13] media: qcom: camss: Improve error printout on icc_get fail
Date:   Thu, 17 Aug 2023 15:38:08 +0100
Message-ID: <20230817143812.677554-10-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817143812.677554-1-bryan.odonoghue@linaro.org>
References: <20230817143812.677554-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If icc_get() fails print the name of the failing path.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 2452c10261e9f..64de82204db34 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1504,8 +1504,11 @@ static int camss_icc_get(struct camss *camss)
 	for (i = 0; i < camss->res->icc_path_num; i++) {
 		camss->icc_path[i] = devm_of_icc_get(camss->dev,
 						     icc_res[i].name);
-		if (IS_ERR(camss->icc_path[i]))
+		if (IS_ERR(camss->icc_path[i])) {
+			dev_err(camss->dev, "Unable to icc_get %s\n",
+				icc_res[i].name);
 			return PTR_ERR(camss->icc_path[i]);
+		}
 	}
 
 	return 0;
-- 
2.41.0

