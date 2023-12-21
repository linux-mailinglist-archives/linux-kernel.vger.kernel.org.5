Return-Path: <linux-kernel+bounces-7780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A4C81ACF7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC492870BB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD617168C2;
	Thu, 21 Dec 2023 03:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7Hgfg6k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD88F14262;
	Thu, 21 Dec 2023 03:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1fb37f25399so206487fac.1;
        Wed, 20 Dec 2023 19:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703128148; x=1703732948; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5AP2LRwmj5B1JnlRMb7Khmq8hXg0KZXg4HVBuQYFNSQ=;
        b=k7Hgfg6ko4KTPBBopehlrJRT0JZ5AOFRiCbil9XJq59qX8s8HNBQ37fM0vrr4jycnK
         /xedySJipj9hxJ5KwMirMJsFeNEqt7IKGtGiUeZ9BnrNlG+V3JeI7YOAHLhfM1lGI8ck
         d1Gs8kEs/YyhZ46VCzCQwB8SgxSMKa1na9xh4MfZo72lWQRevJA8elvk8ipLAUpaqE3d
         3j2LklHKaEnCBuLi4iZGXpzTWebnqtgLLgadHYjFmkXkO7vxhe72vkh3fLeM7UwgyewV
         2SrMpeFtNO942o5Mwt64DpbzpyVM4nE+hcwQBtBupCMU+5HlaajceRc2mt+GfIqQkcjb
         L+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703128148; x=1703732948;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5AP2LRwmj5B1JnlRMb7Khmq8hXg0KZXg4HVBuQYFNSQ=;
        b=s7FztOb18mSYdynyINh5k5q8kO5L2e0gAtS18Sjv2K3IRX5I9kHFf/er0v87Vez9H1
         RP5GcSD9JlGXhET1SNgfg+Vorf59LpQSMkx1zCzucWxRatohMX0sM6ZyzbyOuxrK+VNY
         Dvn7A53ftvRMjhW5deAb2BLo8ItULKCZpSachHjSBxfJPFIaNSFrX2qnfDnFMrdV38hq
         LqgDFC08e3Vyjml9G34BIVQzZBhbRaY65bb6oBuYqdXhNlW4ERmGxGvACHnjfSEEr2KP
         y3/GefVhsdMPoMtZf/KsEHt8/osimBq5Ikn6ksAeLbWKKNobdKmsX54yfuX5PoZNYUqz
         MifA==
X-Gm-Message-State: AOJu0YxI6uACnveH0EShGOWKukihl1mkmpJHLw3GHXn/3xGQ4N0MwF3R
	eDAoE9mwKOcfECUUefqe1kqjbIQaMm8=
X-Google-Smtp-Source: AGHT+IEDkiio061QvVAbfFXsuR+Ygds+inA19zrIgaNUqgjHH4SPtN8YDKI2uPWdjxO8ciFnSppKFA==
X-Received: by 2002:a05:6871:d202:b0:204:371:f5a9 with SMTP id pk2-20020a056871d20200b002040371f5a9mr955875oac.38.1703128148515;
        Wed, 20 Dec 2023 19:09:08 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:9d7:3461:3155:35d4])
        by smtp.gmail.com with ESMTPSA id w22-20020a63c116000000b005cd8b5d1007sm496588pgf.89.2023.12.20.19.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 19:09:08 -0800 (PST)
Date: Wed, 20 Dec 2023 19:09:05 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Support Opensource <support.opensource@diasemi.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: da9063_onkey - avoid using OF-specific APIs
Message-ID: <ZYOsUfKceOFXuCt5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

There is nothing OF-specific in the driver, so switch from OF properties
helpers to generic device helpers.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/da9063_onkey.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
index a8b7f1cd0ec2..ce499c28a7b2 100644
--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -9,11 +9,12 @@
 #include <linux/errno.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/pm_wakeirq.h>
+#include <linux/property.h>
 #include <linux/workqueue.h>
 #include <linux/regmap.h>
-#include <linux/of.h>
 #include <linux/mfd/da9063/core.h>
 #include <linux/mfd/da9063/registers.h>
 #include <linux/mfd/da9062/core.h>
@@ -199,8 +200,8 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, -ENXIO,
 				     "Parent regmap unavailable.\n");
 
-	onkey->key_power = !of_property_read_bool(pdev->dev.of_node,
-						  "dlg,disable-key-power");
+	onkey->key_power = !device_property_read_bool(&pdev->dev,
+						      "dlg,disable-key-power");
 
 	onkey->input = devm_input_allocate_device(&pdev->dev);
 	if (!onkey->input)
-- 
2.43.0.195.gebba966016-goog


-- 
Dmitry

