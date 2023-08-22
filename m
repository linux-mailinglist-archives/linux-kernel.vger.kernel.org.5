Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4073784B22
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjHVUGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 16:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjHVUGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:06:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD2BE76
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 13:06:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-313e742a787so3007633f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 13:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692734800; x=1693339600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAm2r4m1EsTebzRY6t5OCpWP0E5Jb808dwyNgpcqVGI=;
        b=PSpyLKJkZsmjOaDV9/+40p9ylHE22PrHUvkC6h41HCisKyae4G3h7j+AWMNfXR6vC/
         nWvFlYfl+7g6F1x561z5W1LtCKcuUf+/tuXTkndVtH+S5HUSRSTPuFHZJbQRQ7Iw53S9
         3/ovHJzsXZD8twSSw+hwz1eJS6+WWsIdghIEJENpsRDz7jwoFp3LpG0nh8yBOCKHHIWq
         KbI/yaKoz/jJd2XoYxTZ6XLgfuebaiQiAOTcshaxjtF+VIGS2JsEA/9y7a0zJ4U2bwk2
         atopykC7K5jvITxeIhB0T/KjLK5pfGJPwqsyHc/sxhM9TcLJ2kmRZ66ABJFIRz2Dny38
         Klfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692734800; x=1693339600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAm2r4m1EsTebzRY6t5OCpWP0E5Jb808dwyNgpcqVGI=;
        b=CGxsLf57U8XrmC0pRKgn7DSTTotRt3+BedcxiUtJ2F1f8cFoc44RklttYj3AozTpXN
         /jdIriw4txJmAqWHyV7UZEJxQQOe0E5mkhnmJN5+Dh5ZYd2ihwKd3RYpRmOG6O7k3ar+
         FNkAD+z/5F+RC8dooYJALJwA/aRk9n5PpeTv4jgBLDaQIGxJMEt+HAIG9962hce/E3dF
         Y9yezNCc/m+RdZ57McubhH8T1e/X5t/4XdTEm93/mZUgX3v9zpFtHsrpi+QDcJUVuhGc
         P2KqWOJLMsW+K0TSh9hAAWptyYk1nEeX69/400O1wR50rwWYdWoqwaELa92vuuRnsFwF
         BRLw==
X-Gm-Message-State: AOJu0Yw/NViLA+b1wgsY9kpRpBt6nlYcdQ4MXri3UHHbsmTEIMuCsS+Q
        epPnsORcrsA6VVVX6s8Wu7amBQ==
X-Google-Smtp-Source: AGHT+IEXLXT5j7wtHf6axm9zDVMSAFBwgemk0FFwLcAXvuWJE4A95oQcoZk9OJnz11WXuv5wU1VDlQ==
X-Received: by 2002:adf:ea0a:0:b0:319:7ec8:53ba with SMTP id q10-20020adfea0a000000b003197ec853bamr11616267wrm.14.1692734800568;
        Tue, 22 Aug 2023 13:06:40 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id y12-20020adfee0c000000b0031aeca90e1fsm12873690wrn.70.2023.08.22.13.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 13:06:39 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 9/9] media: qcom: camss: Fix csid-gen2 for test pattern generator
Date:   Tue, 22 Aug 2023 21:06:26 +0100
Message-ID: <20230822200626.1931129-10-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822200626.1931129-1-bryan.odonoghue@linaro.org>
References: <20230822200626.1931129-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andrey.konovalov@linaro.org>

In the current driver csid Test Pattern Generator (TPG) doesn't work.
This change:
- fixes writing frame width and height values into CSID_TPG_DT_n_CFG_0
- fixes the shift by one between test_pattern control value and the
  actual pattern.
- drops fixed VC of 0x0a which testing showed prohibited some test
  patterns in the CSID to produce output.
So that TPG starts working, but with the below limitations:
- only test_pattern=9 works as it should
- test_pattern=8 and test_pattern=7 produce black frame (all zeroes)
- the rest of test_pattern's don't work (yavta doesn't get the data)
- regardless of the CFA pattern set by 'media-ctl -V' the actual pixel
  order is always the same (RGGB for any RAW8 or RAW10P format in
  4608x2592 resolution).

Tested with:

RAW10P format, VC0:
 media-ctl -V '"msm_csid0":0[fmt:SRGGB10/4608x2592 field:none]'
 media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4608x2592 field:none]'
 media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
 v4l2-ctl -d /dev/v4l-subdev6 -c test_pattern=9
 yavta -B capture-mplane --capture=3 -n 3 -f SRGGB10P -s 4608x2592 /dev/video0

RAW10P format, VC1:
 media-ctl -V '"msm_csid0":2[fmt:SRGGB10/4608x2592 field:none]'
 media-ctl -V '"msm_vfe0_rdi1":0[fmt:SRGGB10/4608x2592 field:none]'
 media-ctl -l '"msm_csid0":2->"msm_vfe0_rdi1":0[1]'
 v4l2-ctl -d /dev/v4l-subdev6 -c test_pattern=9
 yavta -B capture-mplane --capture=3 -n 3 -f SRGGB10P -s 4608x2592 /dev/video1

RAW8 format, VC0:
 media-ctl --reset
 media-ctl -V '"msm_csid0":0[fmt:SRGGB8/4608x2592 field:none]'
 media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB8/4608x2592 field:none]'
 media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
 yavta -B capture-mplane --capture=3 -n 3 -f SRGGB8 -s 4608x2592 /dev/video0

Fixes: eebe6d00e9bf ("media: camss: Add support for CSID hardware version Titan 170")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-csid-gen2.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
index 140c584bfb8b1..6ba2b10326444 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
@@ -355,9 +355,6 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
 		u8 dt_id = vc;
 
 		if (tg->enabled) {
-			/* Config Test Generator */
-			vc = 0xa;
-
 			/* configure one DT, infinite frames */
 			val = vc << TPG_VC_CFG0_VC_NUM;
 			val |= INTELEAVING_MODE_ONE_SHOT << TPG_VC_CFG0_LINE_INTERLEAVING_MODE;
@@ -370,14 +367,14 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
 
 			writel_relaxed(0x12345678, csid->base + CSID_TPG_LFSR_SEED);
 
-			val = input_format->height & 0x1fff << TPG_DT_n_CFG_0_FRAME_HEIGHT;
-			val |= input_format->width & 0x1fff << TPG_DT_n_CFG_0_FRAME_WIDTH;
+			val = (input_format->height & 0x1fff) << TPG_DT_n_CFG_0_FRAME_HEIGHT;
+			val |= (input_format->width & 0x1fff) << TPG_DT_n_CFG_0_FRAME_WIDTH;
 			writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_0(0));
 
 			val = format->data_type << TPG_DT_n_CFG_1_DATA_TYPE;
 			writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_1(0));
 
-			val = tg->mode << TPG_DT_n_CFG_2_PAYLOAD_MODE;
+			val = (tg->mode - 1) << TPG_DT_n_CFG_2_PAYLOAD_MODE;
 			val |= 0xBE << TPG_DT_n_CFG_2_USER_SPECIFIED_PAYLOAD;
 			val |= format->decode_format << TPG_DT_n_CFG_2_ENCODE_FORMAT;
 			writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_2(0));
-- 
2.41.0

