Return-Path: <linux-kernel+bounces-125163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB0C89215D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C47B1C24D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CD412FB3B;
	Fri, 29 Mar 2024 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EZtXVMD6"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80C585C58
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711728832; cv=none; b=GnSPSw9Tr87FznWS+kxqFPSeoOvL1G3MXHHbZ0Lo8QS1tUMifniC7PDOXtuRyVGHKDdezx1oSVuFrGZ6GmGS8CigV+dIcjzZAzzBDB2Q3IK4kc+vAVpOsMGFc0cal506fyILUNClKnt5vCMHMPOPrJlZ5k58P0Thq0nk2cN5Sm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711728832; c=relaxed/simple;
	bh=o4TIacLg5JyvHmGuDwm27DsyHiubmek7OIhnkJO2r1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hr96WyAzxNfacO/2nkpctVfc1NVG9X0FTfe2KDgl7zGzUlVvL9zcTGbM+6ysM+Oqz633KN16SL4Uj65pJXdnYyk5i86H1OvveYk20izczWR2Xj6U5R/Rgkh6Yo7UztrKgQTX2IhorLuH7xCnHKYFPshoKnNSy0/v0DZ0yKaRYx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EZtXVMD6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41544650225so12403305e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711728829; x=1712333629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+8OG4ORmBIFSwhCUR59MKAikt+Qkmsr6f9T+eVhOqw=;
        b=EZtXVMD6wqGd5yzJVXyj25/vBWybQ1JxCAlC804ArWQfUc+PbmUGeWOAhlIXY0blYZ
         Afi7NN4VsuPxq6LdevvfQfEjypsafVMYw3UVxHjvxWTrr/DwCoA/bPimJ4rwqSk1E3vJ
         Wpas4tilGqMBTT6g25AAsdmSdcfwVUxvFf/uY6pomy4WU2PsFQxebfkUZt2XNC+RQ5oY
         FdiAZqEDCh9xYdYka7zuhjsv70UEmVkFBuXZ1S6x70v52mL1zSN2+JY7xqcTVHpd1qt6
         xwR53jMOHhd8vfPppKOrYJMFRz7U/6ILxIZjXdgl1F5QYqD2Tju+eBoXPrper9wg96Gj
         psSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711728829; x=1712333629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+8OG4ORmBIFSwhCUR59MKAikt+Qkmsr6f9T+eVhOqw=;
        b=IlSk3/cGp+/MUuuXw+mAi5/b7f/BXieRgkDYOkqk9KZNrnwVi699a1BWpihMv6GlMQ
         Q6Ef2NiqkHZEZpgBHuRl24RkdhF0UxfO/zIDQyWI45F/xhBOGsV6RUBj+VQ+sd6kNV6q
         3PMtUaUOBDKDeSug+JOnsgHBXjAd7lGGnRl6GB1Ul9G6tN5ZedU9+XXqPv6QCP59NiXJ
         9rNGTCn5mSUIpQl0fEk6nHcSKolUjbJi2MSlmMybZWR/bJVz5m2pxPC/6TUkULxpf/la
         sUA7UDw7iPCbAHFEEc1pI5TD2ZjOsVE5cMJ4u6KoBr9A2C8OHiHJvyFwzngs1A2qZg0n
         uQRw==
X-Gm-Message-State: AOJu0YyVW2EFKOkCIKpzukyUBmVyX9lTM+SqVkRcCWvj485JOdZoLxMU
	WVikbVxQXmGWE+tKcPRTrRCHlztk+Jc8CzZc6E3UHJKXweREHZFAlo4Rx4fMN25tTT5QiY0jTYJ
	d
X-Google-Smtp-Source: AGHT+IGMsT8Mw7Ro2aINEXQoDYkPfS0bKMj9nW78ArxXYRRGlDIIpIysSGRs6ZN89hHph7zmyTYgEA==
X-Received: by 2002:a05:600c:4710:b0:414:286:fd1f with SMTP id v16-20020a05600c471000b004140286fd1fmr1646594wmo.11.1711728829112;
        Fri, 29 Mar 2024 09:13:49 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c45c600b004155568fa99sm214878wmo.36.2024.03.29.09.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 09:13:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 29 Mar 2024 17:13:37 +0100
Subject: [PATCH 3/3] nvmem: layouts: sl28vpd: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-module-owner-nvmem-v1-3-d700685f08e1@linaro.org>
References: <20240329-module-owner-nvmem-v1-0-d700685f08e1@linaro.org>
In-Reply-To: <20240329-module-owner-nvmem-v1-0-d700685f08e1@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michael Walle <mwalle@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=717;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=o4TIacLg5JyvHmGuDwm27DsyHiubmek7OIhnkJO2r1Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBui2qvJCEqs9MrJhUeBJFExSp8iZ+5UPb/cUK
 Aqal0UR8xWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgbotgAKCRDBN2bmhouD
 15FeD/0SmzTcnyuPqL00kn0oedhmq5zcZi0WC7rA2L/qM9YgI17f49XoGpkWumZHEVvEpWBJrKj
 Lb7b//u3NjBNE/pWUKdQF7nGrclDut1jPgYm7JKmrh41S6v5Xwv8bkdmV+Tn26ks2m36vXgVg1Q
 JTk3aXRZwZhY1Y/tK9cStCc97121/RsGExPnV5Yckpj0rrVDMv3mkvNyAcbylLaSdoXit9TRGNR
 XnDC9FGZTVSgKtpExYTxZ4y27gLU7VT/nF9qJBXDmK+rkXW4QI1Gzg+ll1q//0LLQxSy4Zl1Gal
 uZY8W7zFCVMwIOngXCIKMOp6/n2d+A2IZxqh4ROF4jdCJObrMZLYA+4CH/OOjbcMU5kPZOg8dnG
 x+XPplIM3ITB+1LLWmK8rUc7qV4hVGzIODlq4W1cvDQPtF1vwa2dmMVh7fazR3E1N5khXQI/hUA
 Ta3wNeAtcacob5VAX9yGh/R+LOn/tuBubaDVlGFcXsiZOLbgyJELL74lD4hNBqzUQdLEy+UMcei
 D6i572fUJmDWoSlXPHR9LWSLwYWg24FqGWgeKlivKW7Et7L7D+DhpQ9bG6M/iXZ9EwTQV4K2DUP
 aGNASwc2uoj9ZLHAfL0CgrqWZQl4CDhmeSj1QoSO0uVjwBEpEi6Izf/U4o+dj/7SLeUNUiNZ3ow
 /eN33nTDsl20h5A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in nvmem_layout_driver_register() already sets the .owner, so
driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/nvmem/layouts/sl28vpd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/layouts/sl28vpd.c b/drivers/nvmem/layouts/sl28vpd.c
index 53fa50f17dca..e93b020b0836 100644
--- a/drivers/nvmem/layouts/sl28vpd.c
+++ b/drivers/nvmem/layouts/sl28vpd.c
@@ -156,7 +156,6 @@ MODULE_DEVICE_TABLE(of, sl28vpd_of_match_table);
 
 static struct nvmem_layout_driver sl28vpd_layout = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "kontron-sl28vpd-layout",
 		.of_match_table = sl28vpd_of_match_table,
 	},

-- 
2.34.1


