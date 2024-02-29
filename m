Return-Path: <linux-kernel+bounces-87119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD90886CFD7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095AB1C20AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DD213D2ED;
	Thu, 29 Feb 2024 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub3H0jKp"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C36D13C9C5;
	Thu, 29 Feb 2024 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225648; cv=none; b=h5hAy7z6ZKhYZefk/aCYh9dab3WavrUh8KlAKkq+U13bKb1HgPHsCS8UVlMCScEDvERo3JXXUc/gYaMKQ0CSK4r2AgmV9WgCTRwfnwezCUqOJRpDxJX0o3y5hqtrYMV3nzLLS93nIqEt3sbNbGbf+Gibe2bvt8ila2lJFMOM1F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225648; c=relaxed/simple;
	bh=kIV+r0ACwujt8Ud8BN5PzX5ymKevE281zvWcgcIHk2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e63PlXOU/KBVEDVyD1o8tFLiJST5rN3anO7+A8M0pdDiVMFK0pmQ6FX/2JXkPF0QB0l647ggNiXJgbj4lLye8MBkrrDyskYreBSXLYRdB9X4Z8mmLiwexV5Y/GOBmT0XdRJQDO6QnI5bBHdZrzc8cWWKw+WxhVmEJWiRd6RNesQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ub3H0jKp; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so14162051fa.0;
        Thu, 29 Feb 2024 08:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709225644; x=1709830444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYKAzvzTJgBHvVjI4kCPgko7vz6zofMdlrXR1h42jjM=;
        b=Ub3H0jKpFbmvdeVsS4vItawiD6o9B/9Sr+B58PqKEc4JttXHK33ldEEiw/NM6opgiu
         F5ZWnSu4mfILRSgAEQ9DDU0h25e3ocIXrBENdStSnxne67zZG2r1EwdLZOsqscbA2JLf
         Af5BIuV1eRXxvoabKWizCkMrEtdw4CQwXY9UnXjPM/P+KZPekDt+dk7wP7b75WnKa4in
         1FWQqDabKNEki522o78/3GsNknYXLmGYh6LVDAYHCBUa+c9dfYYvD8LldidScdEtyg9v
         d2kmtgLBODkhf9xw4g6cCMmzpsVYx7LbJC7NrEU1uR7LMoCV5L3PeIA/oE5L7nqzmTF6
         c5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225644; x=1709830444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYKAzvzTJgBHvVjI4kCPgko7vz6zofMdlrXR1h42jjM=;
        b=S0aOiNgmMfMYKxuvbuxbCYajba/cqf90nvFDdLapdSlgFOgjWHI5SRP3l8ME6NQsZO
         NWveQQr7ePyB5f76YCn258oRiPoL41FZvJdRzxddvxtEU+CBsBwm3TmTQTix4JZyAl/U
         uWEK1+5EyndlHnRRQ4uD1NEqBQo1bf2k+kcJ08Ejwbmb1NMRHiecf4mBpBZFx+fI5r4v
         QpOC/1EXqfQ8Fq5Cm4U1Q6kSZnp1CULlIi6nFI5uv90tqNKAi3tPoPkxaQKNzrYIhQnu
         dcMac6j9TstAXKyQedWCxGxBWfzRuep+xoQ4CQkFGMxvMm1s80J63+r11qygXY/Uvx0A
         uHag==
X-Forwarded-Encrypted: i=1; AJvYcCW6hKcJx31T8wT+it6Y/4sro+nATBWMv5u74hA8XRK3YIyh6LgisED2GVdc5JKeAivMeic9ot8t2AOwr2n+ypZJpC0mWpCKozctjgxq
X-Gm-Message-State: AOJu0YxRMty/SG6xfAZiZKjHCjFKiiUBNfWAeheP7JiOkTMGfiBRHiVO
	RIYnzXkfDGm2SnCbb6kFSltJx1CyqPc/4AhiS7fU76XeKLSVnwUFXgBCEJx/1Ps=
X-Google-Smtp-Source: AGHT+IFsX4Pz5Ge5AAoI846ACK2R7Pf/hLFFMlTRl4+p0pVib8P9N5j87MWlmQA9jkUhcXEi2LBPSw==
X-Received: by 2002:a2e:b6cc:0:b0:2d2:9b00:2289 with SMTP id m12-20020a2eb6cc000000b002d29b002289mr1936775ljo.29.1709225643834;
        Thu, 29 Feb 2024 08:54:03 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e9613000000b002cf55fddca7sm276255ljh.49.2024.02.29.08.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 08:54:03 -0800 (PST)
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
Subject: [PATCH v3 13/20] media: i2c: ov4689: Implement digital gain control
Date: Thu, 29 Feb 2024 19:53:26 +0300
Message-ID: <20240229165333.227484-14-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229165333.227484-1-mike.rudenko@gmail.com>
References: <20240229165333.227484-1-mike.rudenko@gmail.com>
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
index 01ee8cadb7c9..1450db7302b7 100644
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
 	{CCI_REG8(0x3503), 0x04}, /* AEC_MANUAL gain_input_as_sensor_gain_format = 1 */
-	{CCI_REG8(0x352a), 0x08}, /* DIG_GAIN_FRAC_LONG dig_gain_long[14:8] = 0x08 (2x) */
 
 	/* ADC and analog control*/
 	{CCI_REG8(0x3603), 0x40},
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
2.43.0


