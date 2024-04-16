Return-Path: <linux-kernel+bounces-146988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 529A88A6DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF432B269D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FFB1311AE;
	Tue, 16 Apr 2024 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx9+IeLn"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48285130AEC;
	Tue, 16 Apr 2024 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277160; cv=none; b=jcRzxx96lWeudZ0206tUn9dQAoG/6pplof2iSNqiVj6ziIWFf8AQ5V0XEdPyvwH8aCy1DbnpCXPVB23AZ5aEHE1JFoDhH4gT7BBTRbjkvM48czg3glIQxlXsU07+20K0aTUAvzvk6auvqJSh/yZSfFN+rTax3hugeYs8dc5xWqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277160; c=relaxed/simple;
	bh=kOk94sDfRB9obNeWEXtFIH86DpFIYOJJKzMDvNPsJSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pd7tM4CCcQC9vR8Ya2JxNaLnCiJHrZ38oq4ZojVILjIOKy4AJu+oMJ1BlWRbB8wCSAkiedl91KhcYdgBL+rD2doyOTCEdpziLBUkqc6wZkiSEgsMiuEId67IfZp3kgE8H7lMVDunzZUXNc5uDWjy5+x41v48sUQUgI+8E1XiPaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wx9+IeLn; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-343c7fae6e4so3683515f8f.1;
        Tue, 16 Apr 2024 07:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713277158; x=1713881958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYnzlWewa0I9IkBCguztRigCuk90aXorNy3BFwvN0fM=;
        b=Wx9+IeLnkxSqWJeUcsrarhyU4Dh/9iVboMpJ72pIYmIaZOBYpVjcmuEaDhFB0o3nD5
         4Y6e7OPBAHaNdZveCZDHGh/lP+6P0Y1eNnzegU0MQGoRrgw72v9rNA2Cx0ZtX/5pEv3k
         3D87W+8/DxCr4ZBbjPve17ic0m/TQu0FuJaocO8lYbdYTNw+1rS1/GaMBjZlrHapJKcF
         4v6bcnIGe1muFQ7s9eQ0MU+G9/uwUyP4Q7uAzF8Haz18gcK02YGFMgOC/a32dLQEgYkq
         066zbdYVyGLJ4jWftCmdVX1SZOgC3LPTTsRM7JjaNG0CuOaoIM67exfZBHiuyTCIX4kv
         ISvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713277158; x=1713881958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYnzlWewa0I9IkBCguztRigCuk90aXorNy3BFwvN0fM=;
        b=oYsjFkmWkaLyylaOe/qQz/9uUg1IQcKdLQQrO1VVBU0hM1WRv6BdaCyiIBUyMRLWB1
         GbK/WJ38OBXXBqn2hWtxvm5Q6ZFTklF1s5k69Yn80hR5euCQy4g3xlHs8asiDZlJrh0s
         5X7Nf4BRRswuvU/kePhC7bxaGhBUlrcZEUoF58eXBtrqmJpbS9fTnN1OmdcNrRX+4AWx
         FmaVK5zIiPYJ3oqmufsdUk2l/z3vV+5UdGLYu5SAhHzuCCNxOqkFJiquwSrnUCL1DgWD
         AFUmU9zdJrbY4NCq3PAgiXBSJXx8T2I2aR0rD1HciHxhtF5vYfXhyVKo1oo7UaBBB6ve
         zGFQ==
X-Forwarded-Encrypted: i=1; AJvYcCViOGiG8HMyXAIOTGLramDKKpM2XRqJjKZmDh2LcRrXjW5MawW1nswIenDKC67i6DROKMddXHmCxFU6ztj6Ch2pkJioi8RZJFHV2NX7jDwTpTV1Y/tpGXpkL4lDWRtYFdf45aZXaMKiE9g=
X-Gm-Message-State: AOJu0Yy2re+quYixwKaAwa0qEB11z7u/FFw7iFSeugrexnMBTIlr1Pj5
	kJrwwzV7q3W4clNd9WiFW29CJC9oDSafY7DRNPCV9AINtae8QJUf
X-Google-Smtp-Source: AGHT+IEljBxtTyx0rtlKruqwcJPIJgMekDTR3xsVmj4xQPNJoh/Wke5o53Ls9bSMXgpwNruF+wzgHA==
X-Received: by 2002:a5d:59ae:0:b0:343:ef33:3ba5 with SMTP id p14-20020a5d59ae000000b00343ef333ba5mr10139620wrr.3.1713277157488;
        Tue, 16 Apr 2024 07:19:17 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-57-233.cust.vodafonedsl.it. [188.217.57.233])
        by smtp.gmail.com with ESMTPSA id b11-20020adfe30b000000b0034625392416sm15055114wrj.104.2024.04.16.07.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 07:19:16 -0700 (PDT)
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: 
Cc: martin.hecht@avnet.eu,
	michael.roeder@avnet.eu,
	tomm.merciai@gmail.com,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] media: i2c: alvium: enable acquisition frame rate
Date: Tue, 16 Apr 2024 16:19:03 +0200
Message-Id: <20240416141905.454253-4-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416141905.454253-1-tomm.merciai@gmail.com>
References: <20240416141905.454253-1-tomm.merciai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alvium camera by default is in free running mode. Datasheet say that
acquisition frame rate reg can only be used if frame start trigger
mode is set to off.
Enable r/w aquisition frame rate and turn off trigger mode.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/media/i2c/alvium-csi2.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
index 991b3bcc8b80..2ab4c7e563d2 100644
--- a/drivers/media/i2c/alvium-csi2.c
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -1184,6 +1184,20 @@ static int alvium_set_frame_rate(struct alvium_dev *alvium, u64 fr)
 	struct device *dev = &alvium->i2c_client->dev;
 	int ret;
 
+	ret = alvium_write_hshake(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_EN_RW,
+				  1);
+	if (ret) {
+		dev_err(dev, "Fail to set acquisition frame rate enable reg\n");
+		return ret;
+	}
+
+	ret = alvium_write_hshake(alvium, REG_BCRM_FRAME_START_TRIGGER_MODE_RW,
+				  0);
+	if (ret) {
+		dev_err(dev, "Fail to set frame start trigger mode reg\n");
+		return ret;
+	}
+
 	ret = alvium_write_hshake(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_RW,
 				  fr);
 	if (ret) {
-- 
2.34.1


