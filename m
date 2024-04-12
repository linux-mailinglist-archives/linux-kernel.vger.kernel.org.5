Return-Path: <linux-kernel+bounces-143341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC9D8A3767
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0FC61C2373E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D261514CC;
	Fri, 12 Apr 2024 20:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzv2tOYe"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B414B062;
	Fri, 12 Apr 2024 20:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955463; cv=none; b=D2Y22KDcqgf3HLfGTtvSjjDziS12jydJNyKS0Pp+JkNPYjX8Mkg3aXzSXW2pcEpx45ldi3Xy8/bYchLQHyMJDxhIjOe2/s7qTbt4NUq89zQMpbhYVDLXekVrhGhhpM7EAf2hl1KHQsNLUH7gxBYZhmY4EcezmVju8mqH8V20Qr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955463; c=relaxed/simple;
	bh=bHQ5ybkYDk0fOfHbfP2h25h71UahoaKsFL86AulNsn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F0jvbnez/E/TbxI4jX8rM+DCDyC3C+X2+3/0ZRiyDxzoySs4qOK8q+7fe7KTmhSDizFZmq7++W1ivFs/dETg9GUREVXjHGj0SPwvkBYW9qyFedJO4mS62NzZTJw9c6hyNO+GjnbBj3aetRaATlJWO7Sy3gBMtQlUXFj1D5k0xLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzv2tOYe; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-346b96f1483so703452f8f.1;
        Fri, 12 Apr 2024 13:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712955459; x=1713560259; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOj4JmMFqTHFXBBftJzqfnu2FHUGLqUT9AgNpEyqCw0=;
        b=gzv2tOYelVK7MMaMVm9Idu3TZJEQF/H6wvBf/EUwsHVp1TZGilxNlUU/HerF6xRQcn
         IzMaAQaU9JIl6+7vP8UilNa8hqBZ0FM3g4sugR+RsqErGufQ4aoX8H2ykQBuiXYADcts
         WzOqqw6pGkMIjctLi6Cz7u3KiiSgpuD7gy/tXHxIsM04DyVCdZ80bZ6voVAdM1c3J4dU
         CsDk/S4VRLHj2RvBwdvS00gsd/5YGJyhPmVn+y40neePki8hUyd9Z5ROVtW2vK4nzKNi
         tULvEC7slnB4Y5/C4EMQROit5EMvPQKeCZ0Te7wky5r92Fjmbi6g1ZsgcGQamB49BksH
         YyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712955459; x=1713560259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOj4JmMFqTHFXBBftJzqfnu2FHUGLqUT9AgNpEyqCw0=;
        b=U3x3Z6LS66WfK3YZoCpe1L3NT3GKai/EzY/AVeiBuKHKWlUul5C9rdvjjk2zDJ3evn
         40t85Up1d5V3s4eFVzI7cAGSMysFQot7IRS047j5s3YuQNb4UsJUAJ6M5odQQZMfo+73
         /qg5fF3gTqQPWqLBA3nE7M7cMYXrj59v/d3Wh72EZxgHTvaY9VraVOtmudQ/qjF1YJ8K
         RSbmaza3y/rNBw0ap9eXO6SMUid6+O2OUeT5dlgv5nG+RMErJXsP+xnKsZpUbKicqKhH
         5tjOKyine26u+0qCcfqO/b0SPGAkQ6XUia5JSrDhiLYh/WmPTHRfopNUCVm75+vdSNof
         8kcA==
X-Forwarded-Encrypted: i=1; AJvYcCWMIt90HtYPsedAkjWlaRxnJCR292Hl2gubrBbXKs9Il/WtThbiOBn2RLuJ2TfoECNcceF8aXtbqsVa4PzhKRUogwcfUCW3zDw+hWV8
X-Gm-Message-State: AOJu0YyPtB9T6eYQbegnL5GacJyCtz95ErtQdvCbKBq38qQb/wI99Lei
	OLN5ko8opJJ7Em0SGyyz7ErUmYVBtflzz8C/5oMmOuIflY6qsNyZD0iKMtHP
X-Google-Smtp-Source: AGHT+IGBOLLPfBbNe7YQ9ApMXzauq2oxy0V7/7WxbASbJeYrHPSicKQQSYf4ovoCA59fS5JbaS+K7w==
X-Received: by 2002:a05:6000:1ac8:b0:346:f935:e828 with SMTP id i8-20020a0560001ac800b00346f935e828mr2969704wry.5.1712955459130;
        Fri, 12 Apr 2024 13:57:39 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-64.cable.dynamic.surfer.at. [84.115.213.64])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d4808000000b0034599eca6c9sm4989203wrq.41.2024.04.12.13.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 13:57:38 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 12 Apr 2024 22:57:31 +0200
Subject: [PATCH 2/6] input: qt1050: use device_for_each_child_node_scoped()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-input_device_for_each_child_node_scoped-v1-2-dbad1bc7ea84@gmail.com>
References: <20240412-input_device_for_each_child_node_scoped-v1-0-dbad1bc7ea84@gmail.com>
In-Reply-To: <20240412-input_device_for_each_child_node_scoped-v1-0-dbad1bc7ea84@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712955454; l=1642;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=bHQ5ybkYDk0fOfHbfP2h25h71UahoaKsFL86AulNsn0=;
 b=UVWCL1tscoqlpvQS2KBG1bHB3zXol2QGtLFAGqbkcNyC2zFqTtsffbpI+MSAxEzb2hREAC6RE
 v3+KlWQ0TPAB47+nb/iMfa+rGHrLOH0ER2+wHcTKR8F1D3NUg507s37
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Switch to the _scoped() version introduced in commit 365130fd47af
("device property: Introduce device_for_each_child_node_scoped()")
to remove the need for manual calling of fwnode_handle_put() in the
paths where the code exits the loop early.

In this case the err label was no longer necessary and EINVAL is
returned directly.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/input/keyboard/qt1050.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/input/keyboard/qt1050.c b/drivers/input/keyboard/qt1050.c
index b51dfcd76038..6ac2b9dbdb85 100644
--- a/drivers/input/keyboard/qt1050.c
+++ b/drivers/input/keyboard/qt1050.c
@@ -355,21 +355,21 @@ static int qt1050_parse_fw(struct qt1050_priv *ts)
 		if (fwnode_property_read_u32(child, "linux,code",
 					     &button.keycode)) {
 			dev_err(dev, "Button without keycode\n");
-			goto err;
+			return -EINVAL;
 		}
 		if (button.keycode >= KEY_MAX) {
 			dev_err(dev, "Invalid keycode 0x%x\n",
 				button.keycode);
-			goto err;
+			return -EINVAL;
 		}
 
 		if (fwnode_property_read_u32(child, "reg",
 					     &button.num)) {
 			dev_err(dev, "Button without pad number\n");
-			goto err;
+			return -EINVAL;
 		}
 		if (button.num < 0 || button.num > QT1050_MAX_KEYS - 1)
-			goto err;
+			return -EINVAL;
 
 		ts->reg_keys |= BIT(button.num);
 
@@ -419,10 +419,6 @@ static int qt1050_parse_fw(struct qt1050_priv *ts)
 	}
 
 	return 0;
-
-err:
-	fwnode_handle_put(child);
-	return -EINVAL;
 }
 
 static int qt1050_probe(struct i2c_client *client)

-- 
2.40.1


