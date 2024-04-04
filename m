Return-Path: <linux-kernel+bounces-131295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC2A8985D4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5981F27E16
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062CC82D6C;
	Thu,  4 Apr 2024 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyLasYlp"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C13D811E2;
	Thu,  4 Apr 2024 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229231; cv=none; b=k8iQ3Chvttf3NJP5cllWLmL577uZ09ScUxwiVyNd7AMkHyVjDfHBkgS3bmp4DUKJzHiHXWcEpasD3SVyHFVQ5Exw74k1H/FAKDJbwFVv1QyPVPVNdo5832gkMJ3dJmu1pYnRowX/MqP3TR9yoaqrLtNCTYZmfYf3EVtc9vaGrZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229231; c=relaxed/simple;
	bh=mdB/is+bhkTf8zf9+ZpFgDdhd5sBFtX+UWQ+XXvoQFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ynnl2ZpKChNDqjeO8xcsi6tyTj3TBLRogG/lUPHZ88qL+x7PhAOPggPatBcAjPas8SS64KWKIscwilnZ62NCDikmEIzUZAenvqcFBhcn22wB7UF5jOtgRCthcg3TzwAg+ROAbzY/ZJEPLi/h9cZjQBrTWrWo+1eA34gWeaPuKJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyLasYlp; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516be63af88so923269e87.0;
        Thu, 04 Apr 2024 04:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712229228; x=1712834028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XIEXAxQtbL/E7hyKdaP1dvGA88Z/fpv13jCLw6PaM6A=;
        b=VyLasYlppGJJh8/y7prViGV57Ugr0TpteEyKMpY4isj5pS3oBW9224tFoe0zr09TzC
         0y5a2M4zv7AJPCs7uh6vLHnjV5GxI5WZA18HAe4URTkuTVXK5dqpy6U4/qIsDRwH9Eg2
         8QRkPe9z9SmuUrSlw8vqnrGSrRi6wdKblRskLl399toyt/OFWpLuTgYFqoHAnB5urZn4
         s42wHTNEApyG3JmeDud91jIaioEYNsmn9ycjlYDEzvtgkflE36DXMS/VzmhMYp/fPyco
         u8cdKKHlGbyXDrkEpViuliFQ0id3i1AuKA4xcLYlmWBReDTQSNFS+H7YdRBQ7BR/Kum3
         Z5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712229228; x=1712834028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIEXAxQtbL/E7hyKdaP1dvGA88Z/fpv13jCLw6PaM6A=;
        b=TbLzHdzFyrAquZU0DtGrC6UInXILFpnqWByNXlIv9pKRoqxYy4zwf0aNqZxL3xetMD
         FrGoGAiNEIiD/yILOLZST1mTmHPVySwrRY4GqMa9m/X8phN2plC6KUym9ECR08/LUz9m
         IprjJtIBpBq1E3063I9FUrpigM8sNmrojzgsuhXEPZJfq+B+jplb4ZqFM0FDfjfvCev6
         haOtSNoJyoyqjQJZFDMZffe3RSjRWSEYP70Fxn3TkLPlzg2rnaN8rEpHP5rIX6GQ5s2n
         szYEYfWIu35wrZzvQYzfbT2+Yh52coHwOOnsQE1sMa4uiAvQLCMXAofAwAUZ/mHoWRnv
         ESrw==
X-Forwarded-Encrypted: i=1; AJvYcCUij7LGQUlgsl6Ke1h0R533C1VOoWSJfYRAekdK3bj1EUz+BlTF8hNoM87xTd7tLE4/DVkTurQHdwDoIowEm6DkGN1DQe3XPcUQctoV
X-Gm-Message-State: AOJu0YyCp9TjBKx8Guh7ecQSh2EewLkm7mx+tIM83/kcWctcaxR+NwpE
	neGxp9AKJwCT2ev+ApDuK/HEZ8dQ33x4tvC1rb2CdEDTI/YOiqzn
X-Google-Smtp-Source: AGHT+IEAY2SACGYBonENoL3giQbqYb/IFCw4VBRZlAdA+PsuXCQvF8ilnrM4wAdwEfvzA7Sp77hp2Q==
X-Received: by 2002:a19:3857:0:b0:515:bee6:5e8c with SMTP id d23-20020a193857000000b00515bee65e8cmr1469779lfj.40.1712229227549;
        Thu, 04 Apr 2024 04:13:47 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-64.cable.dynamic.surfer.at. [84.115.213.64])
        by smtp.gmail.com with ESMTPSA id qf4-20020a1709077f0400b00a5195edf8e8sm104659ejc.62.2024.04.04.04.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:13:46 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 04 Apr 2024 13:13:27 +0200
Subject: [PATCH 1/2] hwmon: (ltc2991) use
 device_for_each_child_node_scoped()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-hwmon_device_for_each_child_node_scoped-v1-1-53997abde43c@gmail.com>
References: <20240404-hwmon_device_for_each_child_node_scoped-v1-0-53997abde43c@gmail.com>
In-Reply-To: <20240404-hwmon_device_for_each_child_node_scoped-v1-0-53997abde43c@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Tim Harvey <tharvey@gateworks.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712229225; l=1469;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=mdB/is+bhkTf8zf9+ZpFgDdhd5sBFtX+UWQ+XXvoQFE=;
 b=871oLthXyBWNsgAKIRYx4v/+xlOm0QoNkNg2s7AEOUvUZA5f5RYFc8RZwfgDHADRlyAoXaKX3
 hGG7EWgv87uDWq+43pC9tHgMhuUrG4z8c8EphXe0HKZ4Iwxyjp+w3ah
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Switch to the _scoped() version introduced in commit 365130fd47af
("device property: Introduce device_for_each_child_node_scoped()")
to remove the need for manual calling of fwnode_handle_put() in the
paths where the code exits the loop early.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/ltc2991.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/ltc2991.c b/drivers/hwmon/ltc2991.c
index 80a6e391f266..3286775de6e8 100644
--- a/drivers/hwmon/ltc2991.c
+++ b/drivers/hwmon/ltc2991.c
@@ -284,7 +284,6 @@ static const struct regmap_config ltc2991_regmap_config = {
 
 static int ltc2991_init(struct ltc2991_state *st, struct device *dev)
 {
-	struct fwnode_handle *child;
 	int ret;
 	u32 val, addr;
 	u8 v5_v8_reg_data = 0, v1_v4_reg_data = 0;
@@ -294,17 +293,13 @@ static int ltc2991_init(struct ltc2991_state *st, struct device *dev)
 		return dev_err_probe(dev, ret,
 				     "failed to enable regulator\n");
 
-	device_for_each_child_node(dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		ret = fwnode_property_read_u32(child, "reg", &addr);
-		if (ret < 0) {
-			fwnode_handle_put(child);
+		if (ret < 0)
 			return ret;
-		}
 
-		if (addr > 3) {
-			fwnode_handle_put(child);
+		if (addr > 3)
 			return -EINVAL;
-		}
 
 		ret = fwnode_property_read_u32(child,
 					       "shunt-resistor-micro-ohms",

-- 
2.40.1


