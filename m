Return-Path: <linux-kernel+bounces-143345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFAE8A376F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E36F1C227EF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3864D84DE1;
	Fri, 12 Apr 2024 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3scX9XM"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC87E152505;
	Fri, 12 Apr 2024 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955468; cv=none; b=FvE8VlgYDd3QuvJmHtpPqLr1t9+mJARIJl4qMxlVTEtCNjrtWoTsNS5sMZSI2VDXTOtIv1Nur//tjq4vYTvQW0xNy3HLsr10UaQub9r00AkDL96cGYak4TLGrqxOQ37J7K0ZpofcXR3UBJXMHQAuNZBDMftahYYOk+ClR1zbBno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955468; c=relaxed/simple;
	bh=d5w2MW9nK7KnKh8JKrlAqM0YsWFjjs+DBOWAWJH9N0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BR5e+Cw6cBSxBkNw7tp6/B1hmD/WhVjMPUUVG8RiRJwvIhxWYepX8/wTZg1fa2lWk17NXa57PbdM36xmFuvndmRuGJzytyo/qoEnrhGt7qEL8Huqpa+1l+TQqhl7TkAiG2PNoiC7g5NSOccm/XJwTFE7ckojLmdIcyPuuUdy63k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3scX9XM; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-346b146199eso901116f8f.0;
        Fri, 12 Apr 2024 13:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712955465; x=1713560265; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6t7b3eK0fUcS94/uN1d+5XHYLVw/cvHYd3bbUDweOys=;
        b=Q3scX9XMWrJ8AEL7onE4uhlLfIND7lbHUZJ83/9BJDMc2dIfONy1pX9EC+qz2FB1tU
         0kOmMdad07OByPapmOqdQgKKBLk2p8XYu9tEO2Shm6iXoKHZyx2591xGQk5ZcL0WJTTw
         KJKPVCsxNZeCNZ8E2F4GlPePXvERuOMHOm+Et3ZtOX/EVObRAi7Hd861GXXG0m66twi1
         2udAtzo+teAK+8X7PjcsUoYnMlupbfO9+PRRCS6suviMP4r0GefyovekMhNY/R5LwSrW
         fqb+Nc48mTe6+uk9aJDfI7YRbc24akmODFYaCVpH1fGB35XqvEgyxeNdsbjjIM14nCj1
         wh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712955465; x=1713560265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6t7b3eK0fUcS94/uN1d+5XHYLVw/cvHYd3bbUDweOys=;
        b=d43pzi6JSa8tWhG2qZi6+bpm961mlfshBo14hoh83SMt9q2ACkimaUh3FITc/vHpPK
         S6KUaVTbsYGPe+yU7wUWypwNCoTS5jIxBaB7Ibl/VggOS9plasNatuTqcCDT2AynvcSy
         hRE3jFH4V0JgSwm7LBx5tmeNJe3+D6yZwJUimm36NX9uapR4W8WzBgpFjngrh4yjOZol
         skDTgymjtjKjy9UDK50do8Uk1IJlyVmJb+IV7Ki7zjw7D6PEs/NhZxnz7XP489qrPjca
         NX26vfL97EyNJsYPSvBWl52p3nUG5WnjSroE+j5VQ1AW8+ia0wqxKD3N/kXsBsJvQ+qf
         dvJA==
X-Forwarded-Encrypted: i=1; AJvYcCWObugGjSMq3AphWqXxjVtULLt7Ck05K9hZnlFeRUIhZ4jdTzcWqzwcwOx8kou0GZh/vODkwqonFdAhoHQH9nUThA5wjhxb2sGsuYc/
X-Gm-Message-State: AOJu0YyKPcCgftTj5nFGKynSuo7blSiT0Y8qXmaBBdeP3REE1WqXnHwc
	Fcqn0vU5yzbV1SSGHaAw2KFrAISCEXAEmdMhQ7Z0JYK4OdvU3gd5Ic+bu+DT
X-Google-Smtp-Source: AGHT+IHfeKgx+lF27zW8U7uJUFLX3yGe9p2iz1ZWNLQLEGeX6x6aG20TwM6ZEsgF3wA8/7rPV0kmoA==
X-Received: by 2002:a05:6000:1ac7:b0:346:f79c:4e1c with SMTP id i7-20020a0560001ac700b00346f79c4e1cmr2588234wry.3.1712955464767;
        Fri, 12 Apr 2024 13:57:44 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-64.cable.dynamic.surfer.at. [84.115.213.64])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d4808000000b0034599eca6c9sm4989203wrq.41.2024.04.12.13.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 13:57:44 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 12 Apr 2024 22:57:35 +0200
Subject: [PATCH 6/6] input: adc-joystick: use
 device_for_each_child_node_scoped()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-input_device_for_each_child_node_scoped-v1-6-dbad1bc7ea84@gmail.com>
References: <20240412-input_device_for_each_child_node_scoped-v1-0-dbad1bc7ea84@gmail.com>
In-Reply-To: <20240412-input_device_for_each_child_node_scoped-v1-0-dbad1bc7ea84@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712955454; l=2409;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=d5w2MW9nK7KnKh8JKrlAqM0YsWFjjs+DBOWAWJH9N0w=;
 b=F423xtrd5wAb9rAY+vtPr1AoN0oRP10J2B/cyTTcz9sPPPWxKq5MlK2RQsesBbXB99e62vBg9
 1c0trNaxF+sAY2zU+C59RPjtlUXm7140r3Z/s1cc/34S9+YrSplysNK
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Switch to the _scoped() version introduced in commit 365130fd47af
("device property: Introduce device_for_each_child_node_scoped()")
to remove the need for manual calling of fwnode_handle_put() in the
paths where the code exits the loop early.

In this case the err_fwnode_put label was no longer necessary and the
error code is returned directly.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/input/joystick/adc-joystick.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/input/joystick/adc-joystick.c b/drivers/input/joystick/adc-joystick.c
index c0deff5d4282..c7c2edf908e6 100644
--- a/drivers/input/joystick/adc-joystick.c
+++ b/drivers/input/joystick/adc-joystick.c
@@ -122,7 +122,6 @@ static void adc_joystick_cleanup(void *data)
 static int adc_joystick_set_axes(struct device *dev, struct adc_joystick *joy)
 {
 	struct adc_joystick_axis *axes;
-	struct fwnode_handle *child;
 	int num_axes, error, i;
 
 	num_axes = device_get_child_node_count(dev);
@@ -141,31 +140,30 @@ static int adc_joystick_set_axes(struct device *dev, struct adc_joystick *joy)
 	if (!axes)
 		return -ENOMEM;
 
-	device_for_each_child_node(dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		error = fwnode_property_read_u32(child, "reg", &i);
 		if (error) {
 			dev_err(dev, "reg invalid or missing\n");
-			goto err_fwnode_put;
+			return error;
 		}
 
 		if (i >= num_axes) {
-			error = -EINVAL;
 			dev_err(dev, "No matching axis for reg %d\n", i);
-			goto err_fwnode_put;
+			return -EINVAL;
 		}
 
 		error = fwnode_property_read_u32(child, "linux,code",
 						 &axes[i].code);
 		if (error) {
 			dev_err(dev, "linux,code invalid or missing\n");
-			goto err_fwnode_put;
+			return error;
 		}
 
 		error = fwnode_property_read_u32_array(child, "abs-range",
 						       axes[i].range, 2);
 		if (error) {
 			dev_err(dev, "abs-range invalid or missing\n");
-			goto err_fwnode_put;
+			return error;
 		}
 
 		fwnode_property_read_u32(child, "abs-fuzz", &axes[i].fuzz);
@@ -180,10 +178,6 @@ static int adc_joystick_set_axes(struct device *dev, struct adc_joystick *joy)
 	joy->axes = axes;
 
 	return 0;
-
-err_fwnode_put:
-	fwnode_handle_put(child);
-	return error;
 }
 
 static int adc_joystick_probe(struct platform_device *pdev)

-- 
2.40.1


