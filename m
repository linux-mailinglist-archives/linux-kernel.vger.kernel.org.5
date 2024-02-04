Return-Path: <linux-kernel+bounces-51780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83020848F36
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69941C21FB7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8F424A08;
	Sun,  4 Feb 2024 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="CxdMg+vk"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F086F249EA
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707063705; cv=none; b=C+8p7GEVj8rEK01rUKBjj15E8Ho9OCor+t5ORzKJva29dynTszXrVkEBqQEVeyodqLQyfaZmS4c1cqB2vNq7MgJpB4EmThNSfwnTxAnIVjGegeiU+HPw9mgYARfgm8oDCGViadaO5ROfhSolG/d3erB0oMSpLvclI+uI7WGr/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707063705; c=relaxed/simple;
	bh=whCsz08h0i58RqyKp8ULdq/KffGrpkytr5XrDDac73A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TQJw7LdBBfGvZ1uN0adOofM1YlYRLxhnnHasD9JCDOLoezz9ihlzc6BKXJZY9PGCVmPPu4cyO5SnddzErEcAHdOzX/AMRLU8BEiCvLyha+G6PlbUz/yIpQTuLV8ikiSVqSYLmrhZi9zGCWDdm36qG1V6FwzT2McuQCe8va29Qws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=CxdMg+vk reason="key not found in DNS"; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59a8b9b327aso1564659eaf.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 08:21:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707063703; x=1707668503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K1azqWxlvOqGmzrUiDwgL9sXxCK8hJ79amUwNn8f5PI=;
        b=YfO5q2D3pj/iFKb65TeylW4gLS8qI1/oKEYF40cx0eM1R2D9oKyM09rgIcB6bZdpGX
         W19l0Ll13DFVs664jlxxDy3A3XXd4HREJnH9SINlVwuU0fRsBnVgWnXzEsBMAs3Z0lQo
         +WYPJ9pAQUhSnvNwy9JX/XrtLsQLxBie20EiGOJlLGh5pgUQ6NMAVVHAaxfBtWK9cwW6
         l6iWynILsswxPmwqPj5krVkQoVY0da5JGyHDaqkA8Ad5Fd3j9pVzBGLTKHOUnoQY7on9
         IZIu6z9Wf7tL9nPoIWG58laXpqkjdHVorlpgqcSJuufEp4/mjZiJh+ayl8p9Xjta/BVI
         G0+Q==
X-Gm-Message-State: AOJu0YxXtV5nYLwHLMNTHKOHMbE9/AF3t4sVdLMictrmONL94/UrnjZ3
	If+jAWKv6D/GxQMExyNiln3f/S7gxElgJvPUxU067E5K7iEZLyop
X-Google-Smtp-Source: AGHT+IFdEpUr4Xm+ktfWdWoY0RlDODYRlAPL/Wr0wrViAu0CesHzb8MPB2oEl74NUDZW8U2iSUiwRw==
X-Received: by 2002:a05:6359:1011:b0:176:6141:48e5 with SMTP id ib17-20020a056359101100b00176614148e5mr8432454rwb.10.1707063702762;
        Sun, 04 Feb 2024 08:21:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVzNmELDhKDwAdF7fxU3VjkJGOMlEATJVhXSMYG8QGPVYN4cFTsVOanXxWm/h64jMko6taWjgDoFDEVdYmccwcmTWycUrSi0RzKcbi2mLsBaNIGjQhsseX4bGGFcptoXBrJ9ZudX++zzZdIStnJixk1yulb2H39xGEgX5/NcTSx7erXJneHW9HAcBMi+Sm/t85H
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id d12-20020a634f0c000000b005d8b89bbf20sm5232335pgb.63.2024.02.04.08.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 08:21:41 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707063701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1azqWxlvOqGmzrUiDwgL9sXxCK8hJ79amUwNn8f5PI=;
	b=CxdMg+vkB4kY9oEf/zuX2BfMsjMCxy2adbhuqXrgoOCnlmtCsMnb9hIDND0f0moqG3nmko
	jydFr/JTUaZVENlTXTMKYAzABYY5W9O5qBgpyNbcQLhuamJsLmQqMm79qn4WoM62opjyv7
	mSqu/q0bXZJ42Cv6tFjPpLR8MewRY4jy8q7Q0HhhZkMNs2C9M8XnKNPxXN8wWNa/b/HGrg
	MDz2pguascEUqGHJzIBHYl7Q5KbHMmZA0g2OB3ugSdTiO1wAU7eRIMtkcsGKEQpdeMyr21
	/cNzrpl1tKCYhvCa0SLa9DSPJcHOwwCSa5f1Kl+bcn3hKjy8x7HDhJkyRTOA9Q==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 13:22:01 -0300
Subject: [PATCH 2/2] ntb: core: make ntb_bus const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-ntb-v1-2-155184f60d5f@marliere.net>
References: <20240204-bus_cleanup-ntb-v1-0-155184f60d5f@marliere.net>
In-Reply-To: <20240204-bus_cleanup-ntb-v1-0-155184f60d5f@marliere.net>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=whCsz08h0i58RqyKp8ULdq/KffGrpkytr5XrDDac73A=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv7msZcSD4qoPu9zwiVBcachyuBTMd9GvMQabu
 JmJUIfJi0KJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+5rAAKCRDJC4p8Y4ZY
 pkqLEACGTjC2kEyiouj+vFMWhl6ZY5OArxAOjO4RjgPcmnC4Qw/aR5riG36KNV/Q27Z1PBdiE8r
 cd2uelujSEOhlcEZBStiqoeQ6djMCvYfRS/+39SJT2dg9sp6ytRtABTQJ8eJbXqH1TXNNFayxAB
 Y3yrsuvXTgwnC3pH6DUDhrHsTqam9162EEfMefKcPb9d+aLLb55JHriIvW3xVPr/11NTLhpijUJ
 xjOAJGCu7IVzDH9hvkVxaigXbja1aSjKrLfsMNOdC+eN7g/FBSasyDsqylGskOx85xFYX9kEmk/
 l3sE2zDg8Z+f7RVb4Itk23nYF6Q0AcAaDjCU//Bb+bXbLj74Qa5rmY7J6S5MvFgsg+BmEt5mj+H
 /RslGj+/G0gUaUozu4ZYyiLw+1Ir7pfP9xbDaWn26PliGmE5QDGu01S8kwCF1e7784cOfpCHEy6
 vuRhPc76HnLS7hwAKbpS4J5IofFSwBiSHzRIVWkNT5Pe07uH1EBBdcVu40ZayrMEbTdD5wIJ8uX
 jWyCPvg15C4ZM/FHUEASsR3fKkW6Mw79CZZvpdMpWe9uBm9LNANAp/Iz898JrQYvzTVVx1/tFaA
 256HZ0DWl0SMW+7eUAb+uVd2aONhFsU24WNl7gDSXshNnS8U80WDlm5SWZerQCqL/5kLVdlQ2sh
 xrf7mJYpUbWb/+g==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the ntb_bus variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/ntb/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/core.c b/drivers/ntb/core.c
index 27dd93deff6e..f32b77c7e00d 100644
--- a/drivers/ntb/core.c
+++ b/drivers/ntb/core.c
@@ -72,7 +72,7 @@ MODULE_VERSION(DRIVER_VERSION);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
 
-static struct bus_type ntb_bus;
+static const struct bus_type ntb_bus;
 static void ntb_dev_release(struct device *dev);
 
 int __ntb_register_client(struct ntb_client *client, struct module *mod,
@@ -292,7 +292,7 @@ static void ntb_dev_release(struct device *dev)
 	complete(&ntb->released);
 }
 
-static struct bus_type ntb_bus = {
+static const struct bus_type ntb_bus = {
 	.name = "ntb",
 	.probe = ntb_probe,
 	.remove = ntb_remove,

-- 
2.43.0


