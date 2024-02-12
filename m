Return-Path: <linux-kernel+bounces-61445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50440851277
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837AA1C215B6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1396939852;
	Mon, 12 Feb 2024 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="q+9/3kHs"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E737339AC5
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738026; cv=none; b=gbsakVbzmhkwNpfznqRptdK9G4E7p9y561dAiqwahZwsd9Gx5JdmZ0ManyHe2dOkGghsq/BoU8KAPrrxo3DJCmEd5Nc4cFLot6hGXN06ZDLJSSq8irSreGtSfvYgK79/LZqzSLTLFsgTtg3OjRs540H5qDPHmFrtMCQE5Nm+8Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738026; c=relaxed/simple;
	bh=ISwS6xN2Yw/M8chV4wQKb1/qoz9l6s3iwaLCZOfBdBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XQOUB9Xh+oBA6MFzfhty7pdHifwvEYe8Eu2MIbrpmcimzC7dVIv/xY4pI2YFE9wQs1JGs6xuEZEbb1CVhLB+aX+NxswyIXSTmeYPZ0QQ13GO+yXHl+06juoVixsyPSXT+WSMw0fuuvLssqHF0NTfWWyfQwf1V+7Am3IWEgSeHhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=q+9/3kHs; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso2304183b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:40:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738024; x=1708342824;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dj3PGJRjmBSX9qjz7f5Yv+1J0ANJIG2OZjDihmWfICk=;
        b=chSdtQE0NvJGng5PMpIaFV6errHzC+RN89uGbFUEds0HfYRdm50tR7UKG46JrjAxOn
         jfoSUhkMiIUQJWy1IBDDD+x7fnNeX+Gay7qyQVa8wF5FzW9anXjZ68QtdNAwz2kCZ+TQ
         SOHnpkjhpdTGS/RgTxj7o8fu97RRjCuE0X92wh+Va9CTOC5rZZVoRdmIxSOe48TC3Q22
         cR6hI4FDEB4EyKIsJMyDfUCiEs783yhcsc/I+ZIFCMwWnjf122mk2jvG5qmoHGD/pN8k
         UbxdfZnKgl1uzCFpjg5jly4x38PaxA9fb753pGnpbcNZ83KhSezOtNrpQjmUrBqhhne/
         4a+A==
X-Gm-Message-State: AOJu0YzcsEuyNdM08g34uIWtmx24LYvNTnFS3FdypG8QHfdExcEiuy/0
	T78h4OJ51qz9iOIWlhJVcJudYueemVh3w3ouSTOYpNCvwtVhC6X6tjT3TjkN/Q/jPQ==
X-Google-Smtp-Source: AGHT+IFeh/3oYKQ0vo4DUX9JQLQzwfvtj8mRoFzoqboKglldZiEwHloguS9Rs9luIWXEf2I/k2sb3A==
X-Received: by 2002:a05:6a21:1585:b0:19e:c777:5c6c with SMTP id nr5-20020a056a21158500b0019ec7775c6cmr3808879pzb.19.1707738024142;
        Mon, 12 Feb 2024 03:40:24 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903308b00b001d9fa58f5a4sm204577plc.48.2024.02.12.03.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:40:23 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707738022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Dj3PGJRjmBSX9qjz7f5Yv+1J0ANJIG2OZjDihmWfICk=;
	b=q+9/3kHsSlukWcy0nFc5x2+KOd4gtXPFxv/rhZ93R4URxP67MyhnW+ece9HkU1a6xkLFSD
	9slRnv1kjEUn2yrYDbd0LOitBSAyaM2SVb/TEztyPpYuPtNj+ZIGirtSnWesALp2dIVcC6
	7uUKtpNwA1hzFyTWlHBgnuCD2VUFXIkFYBt6U3M4zqkbb7LVnK7uMySvHJBm1JZsVQgmnC
	Gr3vvAzrsdl4LsQJeGSNMVxL4T6Es7u/Z1qyDh0QO8SSfDOt1TnjxlIqiYAPLsi+hFspN0
	ZBQVYEiQNxGR4a2T+tPR5qEJP3dEqDkORrSThTQh/zh47D0eUJ6ktPOSjkBJoA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 12 Feb 2024 08:41:01 -0300
Subject: [PATCH v2] dio: make dio_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-bus_cleanup-dio-v2-1-3b1ba4c0547d@marliere.net>
X-B4-Tracking: v=1; b=H4sIAMwDymUC/3WNQQ6DIBREr2L+ujRAtNWuvEdjGsBP/YkFA0raG
 O5e6r7LN5N5s0PEQBjhVu0QMFEk7wrIUwVmUu6JjMbCILmsuRSC6S0+zIzKbQsbybOLUVa1HK9
 Np6GsloCW3ofxPhSeKK4+fI6DJH7pf1cSTLDS1Nxq08i2618qzIQBzw5XGHLOX5vov1KxAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=ISwS6xN2Yw/M8chV4wQKb1/qoz9l6s3iwaLCZOfBdBk=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlygPNFOQNdBSHJYaPpe8zkPGA5YIC6LAohIaF5
 orLzMmm6d2JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcoDzQAKCRDJC4p8Y4ZY
 pjdiD/40coLbzQKwif1wW/9BkbDQDLZxbpdcvKzvO5xbhyrdcP0ertwfumF3w59qu+GrcO/KZdY
 Oy89V1E7/Tmdi4ykGDtgDelgCBBzHPED5fwOJamLXGdxF1+PfeV/Ns2wI0ShagJKGR3g9/FP7KX
 f3Fa4Cwg/RbRB2k07Su23sXJXFq16CMrF/FQUXPKB3Lr3KWbdz+pcfpdrBCRapfjaQsr1BVrlnK
 yezoCS8Wlw9KNXMYKg2I4Y9qYcRCF/0mPRZiw/9+ntZIdqhAmlJJRs5zDEJdyD/B+o0z7c4q8BI
 oyhs9MUlis4WgQR8xkHdYQaG6t25PbzLjvc1g0BZ6jvejkoWhEsNVcQgkS2Q3tG/F7RB9JhStFi
 TqD/qtbCi9DNt4hSZY69/C/qWp3JtTw9A7OJxN/pPY8QQqvYyMCQrlHDYvt6HEsLZcKKY389aJx
 5niN+oag2DCzxCGjHbLoTVrBPZCMkFOV/QYuxmWWt0LRDDDP9mi2Kzfwzxt46XEvYD5UVWUvYgX
 9edvT29jtkRifpvCEQUtHe0Db0z8y91o+stGMFUBZUYbZJT+cWZIUmVsvmpNNux15UranISdSZ8
 Vo4DG4Z2egtLEnLytqH+2W5/QZAn736Qw+JVwYujWPJRzBWqwlPV8exOgGWIEYL0p5vbY7FJ5Rr
 b4Xsa8m4WtIikCA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the dio_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
Changes in v2:
- Added missing 'const' to dio.h
- Link to v1: https://lore.kernel.org/r/20240211-bus_cleanup-dio-v1-1-02140fbc5289@marliere.net
---
 drivers/dio/dio-driver.c | 2 +-
 include/linux/dio.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dio/dio-driver.c b/drivers/dio/dio-driver.c
index 69c46935ffc7..2d9fa6011945 100644
--- a/drivers/dio/dio-driver.c
+++ b/drivers/dio/dio-driver.c
@@ -123,7 +123,7 @@ static int dio_bus_match(struct device *dev, struct device_driver *drv)
 }
 
 
-struct bus_type dio_bus_type = {
+const struct bus_type dio_bus_type = {
 	.name	= "dio",
 	.match	= dio_bus_match,
 	.probe	= dio_device_probe,
diff --git a/include/linux/dio.h b/include/linux/dio.h
index 5abd07361eb5..2b5923909f96 100644
--- a/include/linux/dio.h
+++ b/include/linux/dio.h
@@ -68,7 +68,7 @@ struct dio_bus {
 };
 
 extern struct dio_bus dio_bus;      /* Single DIO bus */
-extern struct bus_type dio_bus_type;
+extern const struct bus_type dio_bus_type;
 
     /*
      *  DIO device IDs

---
base-commit: 047371968ffc470769f541d6933e262dc7085456
change-id: 20240211-bus_cleanup-dio-6cafa80e759b

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


