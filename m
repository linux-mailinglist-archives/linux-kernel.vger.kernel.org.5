Return-Path: <linux-kernel+bounces-147713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 562108A780F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06661F212FA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D090313D296;
	Tue, 16 Apr 2024 22:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoLxRmHZ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B86D13CA9E;
	Tue, 16 Apr 2024 22:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307549; cv=none; b=XFHgjRsQDhbT/x/eh4WAPZh9xfaEXaCuzWJ84624OZnQgxm6lEYblD0a3UuKyCguTCPMumyX3m7fe4HiWzLyeBR4CJNgAgRVtPWw6gjNGSD42p3PYFP/o9l+8W8iVQFuP4kvFnE0FMNG7KmIgh26KOqdGqMHHLJAHgZpfY/mFIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307549; c=relaxed/simple;
	bh=nQLaOOi1m3INUw8IYeGsWUSR1Y5F/FcGFOzChmGZ6gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qn8amzr+g1+189PlDh9xGwT68gKdSIlaR+g1u9LGY2TvcKmk/JDSnzlIe85y8y/iFzrnHSMMnqb254B8nsGdeGWyN2jZpyHIGjG2VAj7I0J4Lx4wDfB0LGJqRr/m618DjwvLnAL7H4F9tO78kG2CHS+vESrpL3lWpzRmlaE3UWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoLxRmHZ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-518f8a69f82so2907013e87.2;
        Tue, 16 Apr 2024 15:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713307545; x=1713912345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfYWLG20tWLCctmjoEIlSfMzY43ed7+aAxJ9RfPojYc=;
        b=hoLxRmHZqBRIgxPvpIdrN7Ba5ct5GH5g+/JS0Vqn2KiT+J/gsTH9LFx5JzHAEdAH1h
         QM/lc/muiQxfJBZ+lvW/qYIh1mAPGFSAy5ymwscXnDk7Eyx/fU+NjwpNtF3ttWIsuy99
         VAwS5rLw3Bm/tDZR7uLH/U6oKyyldN29qu5ohHyUIGiLz+wfz0yIeRM3PjuMjzWGbSkA
         v9dPN9lO/pg6HPs6ZrBeZrage3vhROlghDoZP7WRikCzb89B3lxilnyjjthmvuBiHZyL
         qALOyF9L4Y2lzBoSpbCRc+mavJ8A6vcDOgfmOkjJxGRHEx4d3ONg516LF/T/Rp0PteUb
         EGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713307545; x=1713912345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfYWLG20tWLCctmjoEIlSfMzY43ed7+aAxJ9RfPojYc=;
        b=DggCiFziFVQup3d63kKsynbQTUnLg6j0tFAi7emCfKp4ZJ+r1JXvakGzzgjrwcJeqE
         1/OXqK8AhUK8GryTGQsKLlSC3ZzsmeoQ1q+sdagTsJMZhDnHwyfnmoUArXJnJe1P/epR
         ZlQC08V2epkOVuwY4PRDugYaH8i2g0+cq8bTehwDlrXJbqtGHuimft+p/ZSAI+iwHQ61
         YAtl7pzWvVRuFmQyYMzeBk0As2ss1A70T8uKCzwuTtOFxbKngp8EHm/s7WZRvhAYmF0O
         3X5HDuIwjdK1EKrKKS48IyrK3s3Be1qCRKplBs9S8e/4EiAInkQtXYk9W5VcBYNZXUpt
         XZqg==
X-Forwarded-Encrypted: i=1; AJvYcCWfU8nfmkE7lor0HPF+4c/nh/gMjfekhQ0gJgSAaSE0Q+oH8Ul4GPbLsXPt0WL9feo1SvyUZnpTL+ZPgIsT0Iy8v3aVi6Npw2DVkNQN
X-Gm-Message-State: AOJu0YxBFSx4swRn+WO6sClxuTaMi1AKfKVLj3F1a/h3Xaeo5OgRj7W/
	kD8Y5ZOtTzrtZdgyF+OSmaEbjHwamrAUv7Bhx5VmS7bmPTwg1bXmQhdjtmWyPKs=
X-Google-Smtp-Source: AGHT+IEk405u1zD+q0VmGL18rrASDlrBdHE//jacygoJwwtu7sDabFy7W31Z/oko/GplGnhEvniKRw==
X-Received: by 2002:a19:7510:0:b0:518:c7e5:d1ba with SMTP id y16-20020a197510000000b00518c7e5d1bamr5931604lfe.63.1713307545291;
        Tue, 16 Apr 2024 15:45:45 -0700 (PDT)
Received: from localhost (95-24-153-47.broadband.corbina.ru. [95.24.153.47])
        by smtp.gmail.com with ESMTPSA id y5-20020a196405000000b00515d407aaa0sm1756270lfb.252.2024.04.16.15.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 15:45:44 -0700 (PDT)
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
	Mikhail Rudenko <mike.rudenko@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: [PATCH v5 12/16] media: i2c: ov4689: Implement vflip/hflip controls
Date: Wed, 17 Apr 2024 01:45:20 +0300
Message-ID: <20240416224524.1511357-13-mike.rudenko@gmail.com>
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

The OV4689 sensor supports horizontal and vertical flipping. Add
appropriate controls to the driver. Toggling both array flip and
digital flip bits allows to achieve flipping while maintaining output
Bayer order. Note that the default value of hflip control corresponds
to both bits set, as it was before this patch.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index e478c1f7a8c2..aed87a1b6141 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -42,6 +42,14 @@
 #define OV4689_REG_VTS			CCI_REG16(0x380e)
 #define OV4689_VTS_MAX			0x7fff
 
+#define OV4689_REG_TIMING_FORMAT1	CCI_REG8(0x3820) /* Vertical */
+#define OV4689_REG_TIMING_FORMAT2	CCI_REG8(0x3821) /* Horizontal */
+#define OV4689_TIMING_FLIP_MASK		GENMASK(2, 1)
+#define OV4689_TIMING_FLIP_ARRAY	BIT(1)
+#define OV4689_TIMING_FLIP_DIGITAL	BIT(2)
+#define OV4689_TIMING_FLIP_BOTH		(OV4689_TIMING_FLIP_ARRAY |\
+					 OV4689_TIMING_FLIP_DIGITAL)
+
 #define OV4689_REG_TEST_PATTERN		CCI_REG8(0x5040)
 #define OV4689_TEST_PATTERN_ENABLE	0x80
 #define OV4689_TEST_PATTERN_DISABLE	0x0
@@ -183,7 +191,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
 	{ CCI_REG8(0x3811), 0x08 }, /* H_WIN_OFF_L h_win_off[7:0] = 0x08*/
 	{ CCI_REG8(0x3813), 0x04 }, /* V_WIN_OFF_L v_win_off[7:0] = 0x04 */
 	{ CCI_REG8(0x3819), 0x01 }, /* VSYNC_END_L vsync_end_point[7:0] = 0x01 */
-	{ CCI_REG8(0x3821), 0x06 }, /* TIMING_FORMAT2 array_h_mirror = 1, digital_h_mirror = 1 */
 
 	/* OTP control */
 	{ CCI_REG8(0x3d85), 0x36 }, /* OTP_REG85 OTP_power_up_load_setting_enable = 1,
@@ -607,6 +614,16 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 			  (ctrl->val + ov4689->cur_mode->width) /
 			  OV4689_HTS_DIVIDER, &ret);
 		break;
+	case V4L2_CID_VFLIP:
+		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT1,
+				OV4689_TIMING_FLIP_MASK,
+				ctrl->val ? OV4689_TIMING_FLIP_BOTH : 0, &ret);
+		break;
+	case V4L2_CID_HFLIP:
+		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT2,
+				OV4689_TIMING_FLIP_MASK,
+				ctrl->val ? 0 : OV4689_TIMING_FLIP_BOTH, &ret);
+		break;
 	default:
 		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
 			 __func__, ctrl->id, ctrl->val);
@@ -637,7 +654,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 
 	handler = &ov4689->ctrl_handler;
 	mode = ov4689->cur_mode;
-	ret = v4l2_ctrl_handler_init(handler, 10);
+	ret = v4l2_ctrl_handler_init(handler, 12);
 	if (ret)
 		return ret;
 
@@ -677,6 +694,9 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 				     ARRAY_SIZE(ov4689_test_pattern_menu) - 1,
 				     0, 0, ov4689_test_pattern_menu);
 
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
+
 	if (handler->error) {
 		ret = handler->error;
 		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);
-- 
2.44.0


