Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8876577F969
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352134AbjHQOjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352038AbjHQOi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:38:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04CA30EE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:38:24 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3159d5e409dso697410f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692283103; x=1692887903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VK3Brkf0Kp4KIHjNefD/kT85SGPeM6rUSbzh8rEXytE=;
        b=f7qlvQSYM/4ohSC0HNNj402tYjcNWtPG5XrXAgQo80PDSuk+wJdxVqNK8co3I94f2L
         6WtGmjX4XdRBumqevFyd33PaIo4rifnd+tU33mmex/eimupJ5H8yARgy5rpvibjpkSy5
         jKd/Yawu4NqsqDO4FNBVMzyBA7N+gFW1Sy87i0MxWHPh/lcxgNtAMlEAP7l4g4d0fIZp
         MPkwKX4E+ekLPjntmWoR7jis4mElQkm1B4IzTC4FndSqDeBSxV3qoMku4srOHppOV6sQ
         aNGGa4HbV2llE4W6bkRVcprhB0JKqWExpLrW58oV8OCI5k6vuDANmSwVWsJYs07L4m8v
         gyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692283103; x=1692887903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VK3Brkf0Kp4KIHjNefD/kT85SGPeM6rUSbzh8rEXytE=;
        b=Jv2Qe4YlhQ2WsyipG47F2dS8ipf9rPFPJxyfbSJaQcetVODedov5ROeO7LYTUGNb35
         gvc9q+LK5hmzjsBx6xanyCtGSTX5wlXFQpiNLuTWEJMPDFTnkVaThodGPtNqhbOQcKvr
         uMYK2gOG+uWSpAex4FeyoWdm+1eB5C0WJL37MgXVv4yoD01X0mRO4ZiGaFS3A01MzgR1
         mrgpZsJO8uAb1bBFdD4CwoeU8SPps8/ayT+7rJwDz1pH5kA45PE8Thf94o0Icg/XlC+v
         mVF+P2pcUppgPyI7g0a2qdRMKQc+WbniVlyneOzEU86t+ojpn9mtYbulESCCRbjRDOBB
         zW/g==
X-Gm-Message-State: AOJu0YwkUejvNA8H8iYf6vI4RXVLVDFhMAH9v6LhC7bYAsecfICjji8T
        D/ZB2xdPpn9hyoVkeHyzOCybVQ==
X-Google-Smtp-Source: AGHT+IHfO0UMjFO4iaOygLz7ibMfjXEtu5vxjgjIounITf+xI1UoVwv1SnkcIf5CeTnIMkp5hFIH7Q==
X-Received: by 2002:adf:e412:0:b0:317:dadc:4a63 with SMTP id g18-20020adfe412000000b00317dadc4a63mr2535367wrm.8.1692283103222;
        Thu, 17 Aug 2023 07:38:23 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d4388000000b0030647449730sm25218232wrq.74.2023.08.17.07.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:38:22 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/13] media: qcom: camss: Assign the correct number of RDIs per VFE
Date:   Thu, 17 Aug 2023 15:38:05 +0100
Message-ID: <20230817143812.677554-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817143812.677554-1-bryan.odonoghue@linaro.org>
References: <20230817143812.677554-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each Video Front End - VFE - has a variable number of Raw Data Interfaces -
RDIs associated with it.

The CAMSS code started from a naive implementation where a fixed define was
used as a control in a for(){} loop iterating through RDIs.

That model scales badly. An attempt was made with  VFE_LINE_NUM_GEN2 and
VFE_LINE_NUM_GEN1 to differentiate between SoCs but, the problem with that
is "gen1" and "gen2" have no meaning in the silicon. There is no fixed
constraint in the silicon between VFE and RDI, it is entirely up to the SoC
designers how many VFEs are populated and how many RDIs to associate with
each VFE.

As an example sdm845 has VFE version 175 and sm8250 VFE version 480.
sdm845 has 2 VFEs with 4 RDIs and 1 VFE Lite with 4 RDIs.
sm8250 has 2 VFEs with 3 RDIs and 2 VFE Lite with 4 RDIs.

Clearly then we need a more granular model to capture the necessary data.

The defines have gone away to be replaced with per-SoC data but, we haven't
populated the parameter data with the real values.

Let's call those values out now

msm8916:
1 x VFE
3 x RDI per VFE (not 4)

msm8996:
2 x VFE
3 x RDI per VFE (not 4)

sdm660:
2 x VFE
3 x RDI per VFE (not 4)

sdm845:
2 x VFE
4 x RDI per VFE (not 3)
1 x VFE Lite
4 x RDI per VFE Lite (not 3)

sm8250:
2 x VFE
3 x RDI per VFE (not 4)
2 x VFE Lite
4 x RDI per VFE

This more complex and correct mapping was not possible prior to passing
values via driver data. Now that we have that change in place we can
correctly map VFEs to RDIs for each VFE.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 5133bf3f372f1..2452c10261e9f 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -124,7 +124,7 @@ static const struct resources vfe_res_8x16[] = {
 				{ 0 } },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
-		.line_num = VFE_LINE_NUM_GEN1,
+		.line_num = 3,
 	}
 };
 
@@ -265,7 +265,7 @@ static const struct resources vfe_res_8x96[] = {
 				{ 0 } },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
-		.line_num = VFE_LINE_NUM_GEN1,
+		.line_num = 3,
 	},
 
 	/* VFE1 */
@@ -284,7 +284,7 @@ static const struct resources vfe_res_8x96[] = {
 				{ 0 } },
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
-		.line_num = VFE_LINE_NUM_GEN1,
+		.line_num = 3,
 	}
 };
 
@@ -446,7 +446,7 @@ static const struct resources vfe_res_660[] = {
 				{ 0 } },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
-		.line_num = VFE_LINE_NUM_GEN1,
+		.line_num = 3,
 	},
 
 	/* VFE1 */
@@ -468,7 +468,7 @@ static const struct resources vfe_res_660[] = {
 				{ 0 } },
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
-		.line_num = VFE_LINE_NUM_GEN1,
+		.line_num = 3,
 	}
 };
 
@@ -627,7 +627,7 @@ static const struct resources vfe_res_845[] = {
 				{ 384000000 } },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
-		.line_num = VFE_LINE_NUM_GEN2,
+		.line_num = 4,
 	},
 
 	/* VFE1 */
@@ -648,7 +648,7 @@ static const struct resources vfe_res_845[] = {
 				{ 384000000 } },
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
-		.line_num = VFE_LINE_NUM_GEN2,
+		.line_num = 4,
 	},
 
 	/* VFE-lite */
@@ -668,7 +668,7 @@ static const struct resources vfe_res_845[] = {
 				{ 384000000 } },
 		.reg = { "vfe_lite" },
 		.interrupt = { "vfe_lite" },
-		.line_num = VFE_LINE_NUM_GEN2,
+		.line_num = 4,
 	}
 };
 
@@ -796,7 +796,7 @@ static const struct resources vfe_res_8250[] = {
 				{ 0 } },
 		.reg = { "vfe0" },
 		.interrupt = { "vfe0" },
-		.line_num = 4,
+		.line_num = 3,
 	},
 	/* VFE1 */
 	{
@@ -815,7 +815,7 @@ static const struct resources vfe_res_8250[] = {
 				{ 0 } },
 		.reg = { "vfe1" },
 		.interrupt = { "vfe1" },
-		.line_num = 4,
+		.line_num = 3,
 	},
 	/* VFE2 (lite) */
 	{
-- 
2.41.0

