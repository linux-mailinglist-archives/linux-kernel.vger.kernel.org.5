Return-Path: <linux-kernel+bounces-147715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8548A7813
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D1E284E68
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B1913DDB4;
	Tue, 16 Apr 2024 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLBSAdZe"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEF313D291;
	Tue, 16 Apr 2024 22:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307551; cv=none; b=GaFYhBbavKeG1EGmqAocm4ikQxSiIZgE5s+OM/4xY7mCdmwTJ76AqI7+pLtbZqMVf9yRMvWlfC1EWccG6HCcqce4eEd6u5qDaQaPun/3k6ipnZhetNQcdqkBXRC9FTH0oKwALGtrSiKnOLd3cQxZhJ6kL72+JBMOD+TK0edPEo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307551; c=relaxed/simple;
	bh=DtVUHIfAgevKu4djLbP7nqbfz3fagvRXoPG1r681QNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmUqNlfatmNl84Fm6+4zrmG4F45GDUXVyZs1N65hiTWwkeFykxgc6HEDxjzOZc+r45QdBSC7EZKEBOSGulElSkjCU3Z8bZQHPxMnWEniI3ZrZKgXlfC9wH5yhc8RyniUHXfdazIeObiSaCFQfZ9jbx9tDxDT1i0pTpjREFcTcio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLBSAdZe; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d715638540so59384901fa.3;
        Tue, 16 Apr 2024 15:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713307547; x=1713912347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnB6EJezC8uEYf8UpSPwf0QVKtD7oJuVnHfWXzU0FRs=;
        b=mLBSAdZeaEEWs13K8yqif38Rvhqg1EWfLABzZAN/6zE60oXNYTuse6R1Dsmzgse6BE
         rLiTTBfSO8V40/TUCXnnvXVt/fcmUwyLe7v0NKRYR7jIBQlRjf5uc+Obb6PudznF/j+D
         vYiCEsOoeaBWKtZ4ny3rncn7aiAsgoLDt6Xui52KktorRfY6NuUp1oqhU4n8e61i2i5c
         B05eyrJnnnzFVDkClkHTqIHFii4BsMWnvqjI66+XN6jMfi22RlR7TITqTiZ0obruY8sI
         nDy6Qlmz6dF52ze8BliW3/ktId6coe1ZKOsS2aQ1w/Is07q8Oq7YFir/FL6X0lE1pEcK
         X8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713307547; x=1713912347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnB6EJezC8uEYf8UpSPwf0QVKtD7oJuVnHfWXzU0FRs=;
        b=Su1nAY1+/gfbWFTLl1/nMppPxNC3BFMbU+uhwFkRNqBOp/et9VcuoDDM1A1Sb7ofVH
         udKg991BKx6wbpWe5Hc9U+h4n9JNDmy6SU50xTJmZ5Kv4LNQTbjmfiNjSDrjAcnKvmE+
         L3YWNcMzUI60bci/4HoUCHsmti1MfFndN/WGxS4iRsUG+Di0j2yUnPCIHj40uvLhDJ57
         XxOr+J96Cxu79Yms4ciOdZHpnADrobeTVbmLc6MjXYeFrv7pUhpiXLprOQPW6+BVH8nV
         CyUPgMK9wrz4jlTTAaMmayzMfYIxn472JSN4lh+ldcNtRxZtC5zC47cLLt6MW/laUF9J
         HJKA==
X-Forwarded-Encrypted: i=1; AJvYcCV8KXNOoNs8GA31FpTaN+TLkqrDaSqSYslKLw414+ufJMDSfyu+1UZO9bVn4tPwA/tT1dREe5Un1L72FQrM3pynjdIbjt1zEQvIltTa
X-Gm-Message-State: AOJu0Yz8OL5WByIDXY3jf0Ewd3pJ4DgHey2vNck2ck5QS+IIxxSHHyG+
	wa7/dnapQS1rPkNcQQ1rDKY2FG2YM5FBKgf6lfUWTc0c6+MDjiV040bP5eVnayk=
X-Google-Smtp-Source: AGHT+IEvriP6sQBlcmr+Hy9a6IM5os+FLPMPiuFDW+kvAJIgTO/WULr1+E+BcVf2XnlMz5gB5u56TA==
X-Received: by 2002:a05:651c:1254:b0:2d4:77c0:d61c with SMTP id h20-20020a05651c125400b002d477c0d61cmr8709506ljh.35.1713307547087;
        Tue, 16 Apr 2024 15:45:47 -0700 (PDT)
Received: from localhost (95-24-153-47.broadband.corbina.ru. [95.24.153.47])
        by smtp.gmail.com with ESMTPSA id y1-20020a2e95c1000000b002d2d1c11703sm1704617ljh.76.2024.04.16.15.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 15:45:46 -0700 (PDT)
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH v5 14/16] media: i2c: ov4689: Implement manual color balance controls
Date: Wed, 17 Apr 2024 01:45:22 +0300
Message-ID: <20240416224524.1511357-15-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416224524.1511357-1-mike.rudenko@gmail.com>
References: <20240416224524.1511357-1-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OV4689 sensor has separate red and blue gain settings (up to 4x).
Implement appropriate controls in the driver. Default gain values
are not modified.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 9419fc4de33e..81153b1a49a5 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -56,6 +56,13 @@
 #define OV4689_TIMING_FLIP_BOTH		(OV4689_TIMING_FLIP_ARRAY |\
 					 OV4689_TIMING_FLIP_DIGITAL)
 
+#define OV4689_REG_WB_GAIN_RED		CCI_REG16(0x500c)
+#define OV4689_REG_WB_GAIN_BLUE		CCI_REG16(0x5010)
+#define OV4689_WB_GAIN_MIN		1
+#define OV4689_WB_GAIN_MAX		0xfff
+#define OV4689_WB_GAIN_STEP		1
+#define OV4689_WB_GAIN_DEFAULT		0x400
+
 #define OV4689_REG_TEST_PATTERN		CCI_REG8(0x5040)
 #define OV4689_TEST_PATTERN_ENABLE	0x80
 #define OV4689_TEST_PATTERN_DISABLE	0x0
@@ -632,6 +639,12 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_DIGITAL_GAIN:
 		cci_write(regmap, OV4689_REG_DIG_GAIN, ctrl->val, &ret);
 		break;
+	case V4L2_CID_RED_BALANCE:
+		cci_write(regmap, OV4689_REG_WB_GAIN_RED, ctrl->val, &ret);
+		break;
+	case V4L2_CID_BLUE_BALANCE:
+		cci_write(regmap, OV4689_REG_WB_GAIN_BLUE, ctrl->val, &ret);
+		break;
 	default:
 		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
 			 __func__, ctrl->id, ctrl->val);
@@ -662,7 +675,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 
 	handler = &ov4689->ctrl_handler;
 	mode = ov4689->cur_mode;
-	ret = v4l2_ctrl_handler_init(handler, 13);
+	ret = v4l2_ctrl_handler_init(handler, 15);
 	if (ret)
 		return ret;
 
@@ -709,6 +722,14 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 			  OV4689_DIG_GAIN_MIN, OV4689_DIG_GAIN_MAX,
 			  OV4689_DIG_GAIN_STEP, OV4689_DIG_GAIN_DEFAULT);
 
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_RED_BALANCE,
+			  OV4689_WB_GAIN_MIN, OV4689_WB_GAIN_MAX,
+			  OV4689_WB_GAIN_STEP, OV4689_WB_GAIN_DEFAULT);
+
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_BLUE_BALANCE,
+			  OV4689_WB_GAIN_MIN, OV4689_WB_GAIN_MAX,
+			  OV4689_WB_GAIN_STEP, OV4689_WB_GAIN_DEFAULT);
+
 	if (handler->error) {
 		ret = handler->error;
 		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);
-- 
2.44.0


