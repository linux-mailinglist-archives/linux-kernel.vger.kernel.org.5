Return-Path: <linux-kernel+bounces-147714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EAF8A7811
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2865B1F21268
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A64D13D52E;
	Tue, 16 Apr 2024 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdnQXgii"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A31313CF9D;
	Tue, 16 Apr 2024 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307549; cv=none; b=h5/ENHVh2mDhO9X3zcL5WoT+J24CDQAjlDyKsWGwUHbiggHopwoF/DsCJJn4GJGnq5y1utxnFrzpEJAPI9WeZAVGbJVAbealFr20EAdnb6fnkkzVLfzdWDSs9pQTaxgLQj7f53gJ8bhAqXbtJv6soEcCTmj2MMNBVrpxGOFuK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307549; c=relaxed/simple;
	bh=hbl71ErSBzkD6kHWrHMCOjLZqMs6UNDDekpRwwC8K4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBcOj7epM7e2JBduf/mldHAR/FlWFSs/sfVGtpFvby22HDIZFC0HxUav9UHofNtpXgCzMa+CD4ze4SvOhPwYNJh66N4YP183eY4F+mf2LjDGyFiarklzrpYY5E7Ls6XHtJMOjAnNTb/JCBB936cgJ7XWs2T2qplveoQn/PAiW8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdnQXgii; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d6c1e238so5889601e87.2;
        Tue, 16 Apr 2024 15:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713307546; x=1713912346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTiIt4/6Hl6mPaW2hMZHjAcnbQ3TgX0d3sLt6FdNZb8=;
        b=kdnQXgiiVUook+3XC0MneU3LdzykQs3swkt3veM2JEVw3vazGVrOVtopsE6uigRRUU
         IzLTjsNyOCk6Y6MdV2LHOCwzUB/3SGe3WRC/Iavsxbg/l3Q7N+dihoepA/JmQghjhbjy
         yZRaQ0NgXd2bBM5V0tvkREFf9b9rYyQ8PLy2Tu9Bd5l+WPwkYUCdwx1QVk0vT3jAUGBY
         S/3RzWC16oKe4QhIdpH4Wq6tGd7sZHK8JgZtmA5Va4GhTWB7MDnC6c5acYbD/5Dv/iop
         b8q00rInMxI615E5Z0vFzPZaFQ+JtOA0SkemisL/KdomUHQww75aKCNT6WVURpUwLKiJ
         LhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713307546; x=1713912346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTiIt4/6Hl6mPaW2hMZHjAcnbQ3TgX0d3sLt6FdNZb8=;
        b=HhUlekZkULP+TzBbY32HPnm/ALQUFyKCHSdLnNTnloeyOWJ1dFO18JXbRUVkbAo2Ty
         HRFziuqYAt8Nz7rFYdXjA3cY2+ze1ZnweudIu2p2dyYRj2R89d0YXpp7mioRauPJD1L+
         dLlEXplwKh1xfOVAafbNnhueuXxvFc19Qaq7YyKhYlFh5HIL8fbuYmLush3odHxVJQi7
         DB2jfSI24VzbTiXsZoib096cE9Dv+jKthhQa5tXF0fxI+tz+6Oioanue3xbZod5eJ4/H
         3upqcX3JnEcCJP4ZosCPHGNLik+yZuwGyRAt61oXdZ6cxaHid3SPvlyIwICNump0kpNq
         LVjw==
X-Forwarded-Encrypted: i=1; AJvYcCWoiCH9wUk/6zDLkpxkoi/lOFWGFjLHhlU1lR0OFDuz1Hy7ni+MD09Cp44ZkkiGnGFfxv1S28iFRbF/gMScXt5t0Muq3dq6W1YnFvZD
X-Gm-Message-State: AOJu0Yxe1R/fX6tkj0nGei0eO4DlmuGz+O2+qOHwOTaEH13Fcjocb4dm
	HlNPzRXwfhVvn6qECwLMijZaJVJFJ8p2xMJCogvM8+DMeO7zHZfuTEh8yXseoUY=
X-Google-Smtp-Source: AGHT+IH04duWoR4wt54iYga0fEwnBfZLMpiAF8tynWpSdLcBdx4NDToAIYtkcaMcyZgCWUEYzP72oQ==
X-Received: by 2002:a19:f015:0:b0:518:c564:1089 with SMTP id p21-20020a19f015000000b00518c5641089mr5328953lfc.52.1713307546207;
        Tue, 16 Apr 2024 15:45:46 -0700 (PDT)
Received: from localhost (95-24-153-47.broadband.corbina.ru. [95.24.153.47])
        by smtp.gmail.com with ESMTPSA id w14-20020a05651204ce00b0051949824d57sm4013lfq.27.2024.04.16.15.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 15:45:45 -0700 (PDT)
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
Subject: [PATCH v5 13/16] media: i2c: ov4689: Implement digital gain control
Date: Wed, 17 Apr 2024 01:45:21 +0300
Message-ID: <20240416224524.1511357-14-mike.rudenko@gmail.com>
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

The OV4689 sensor supports digital gain up to 16x. Implement
corresponding control in the driver. Default digital gain value is not
modified by this patch.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index aed87a1b6141..9419fc4de33e 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -35,6 +35,12 @@
 #define OV4689_GAIN_STEP		1
 #define OV4689_GAIN_DEFAULT		0x80
 
+#define OV4689_REG_DIG_GAIN		CCI_REG16(0x352a)
+#define OV4689_DIG_GAIN_MIN		1
+#define OV4689_DIG_GAIN_MAX		0x7fff
+#define OV4689_DIG_GAIN_STEP		1
+#define OV4689_DIG_GAIN_DEFAULT		0x800
+
 #define OV4689_REG_HTS			CCI_REG16(0x380c)
 #define OV4689_HTS_DIVIDER		4
 #define OV4689_HTS_MAX			0x7fff
@@ -131,7 +137,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
 
 	/* AEC PK */
 	{ CCI_REG8(0x3503), 0x04 }, /* AEC_MANUAL gain_input_as_sensor_gain_format = 1 */
-	{ CCI_REG8(0x352a), 0x08 }, /* DIG_GAIN_FRAC_LONG dig_gain_long[14:8] = 0x08 (2x) */
 
 	/* ADC and analog control*/
 	{ CCI_REG8(0x3603), 0x40 },
@@ -624,6 +629,9 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 				OV4689_TIMING_FLIP_MASK,
 				ctrl->val ? 0 : OV4689_TIMING_FLIP_BOTH, &ret);
 		break;
+	case V4L2_CID_DIGITAL_GAIN:
+		cci_write(regmap, OV4689_REG_DIG_GAIN, ctrl->val, &ret);
+		break;
 	default:
 		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
 			 __func__, ctrl->id, ctrl->val);
@@ -654,7 +662,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 
 	handler = &ov4689->ctrl_handler;
 	mode = ov4689->cur_mode;
-	ret = v4l2_ctrl_handler_init(handler, 12);
+	ret = v4l2_ctrl_handler_init(handler, 13);
 	if (ret)
 		return ret;
 
@@ -697,6 +705,10 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
 	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
 
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_DIGITAL_GAIN,
+			  OV4689_DIG_GAIN_MIN, OV4689_DIG_GAIN_MAX,
+			  OV4689_DIG_GAIN_STEP, OV4689_DIG_GAIN_DEFAULT);
+
 	if (handler->error) {
 		ret = handler->error;
 		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);
-- 
2.44.0


