Return-Path: <linux-kernel+bounces-127530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03378894D3C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95CED1F22813
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F2C3DBBE;
	Tue,  2 Apr 2024 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7ysaKny"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEF93D548;
	Tue,  2 Apr 2024 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712045640; cv=none; b=eVHwLXzi0O10ARYTkchPLyStbI1SH/3ivM99NxEwXHeUH9wQ/FTlSecV4Avv6APT6C8jO9ng0RVXF4dJrbuk7FuttZ4AqxflNmFWdP8TaXHnE38wYlbwocijEzEC6IF//e5AHS2HwUklryTajwWcCU3jmhy06n1Yc28mhSnNV/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712045640; c=relaxed/simple;
	bh=3xZZaQElXv7jqvaVK6mXVEFWr6vkpFn7axhh8SlqDKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dmM/q2btT6X8Nc29lTzPdEfW2jOU6A5+AdiHY+DSRwUncp+Tv/o7JlSMAcmKboBoc3otuGva7wZ9J3MP3etoBXdZhg5rKpMGwHhvDVMtPYlRBKEYS4q9abH3Cm5mEYqjqZ2wCbaexpt88sKBruk9PyD5ukC9DUxb64d5AQTjNbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7ysaKny; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4161d73d873so639015e9.0;
        Tue, 02 Apr 2024 01:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712045637; x=1712650437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KF+R478r2NKQGh/IR7Buy4IuEIG5MGEIPdPKGc9/qWc=;
        b=l7ysaKnyaDxYtz1uFz79ekxqLF8sZNk3A+CGbpIclJh5G9Ar8ShcFe9COhPlcom8k2
         A+urjXZrFcZyv16n6NJb2O7327NMex1efgRyxJiOVCrnI9gLyTns1JqQOZFtPeHiUY5L
         secFYZp7CKETXAzHlbUel8ikyAthmp8PfKAgqDHXCXMq25ajX3gQ1eL/4bAnW2R5luFv
         iXHlhhyOKCZgEM2apnL6rNhwKmUremEdj4I0tuGApPUT3fskT/+vtST0rBjT1O7bbuvx
         iFnI1lKtdacBznmytWadUZzPz32B4lMLWoVVh6O98aRJkikWxTjMg90ZJfpoGPFHl4Tc
         +1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712045637; x=1712650437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KF+R478r2NKQGh/IR7Buy4IuEIG5MGEIPdPKGc9/qWc=;
        b=IpkCZ79DNb1AkLA9CaoNEJELeuDoGUCtXoHSJ8HX7dsftSwjynWCAmXr4TH2S3jP5v
         7D56MDa9JXP8UL+7tB4zfa8+IIKu63MCeGZwiALqfFq7grflJfwGnasQT1jBf4wUh2R+
         /dLc4RdgvBSGj3KSP7NySxipFhhk0RADmfdAU6fyhW1GiEIJmZvay36XuhyCfqL7N9XJ
         jHZBgQUSM93wpEZYvJea6sp9dfurpI4jeRM+06fIwEcT8ER2zQq090sZUWk/88TX+/jw
         tvZj9hyYs0GPn7nJO4SN3d2Z1xw9RdAKhYUef48RSq1YAV4GaaSzBeiG6cxDeskTZcJl
         DjOw==
X-Forwarded-Encrypted: i=1; AJvYcCXV9VBi7VCHLHGwZeCcoTyNMFIJbJrPyjp2pcxbbzDDOKZwjwB5PMYb7TmU0g6RSkmT+BuM/a12UYTGbmnnaZERpk1mzKKUYwdOnJ/RRxDYFt/XemSszjRMUkqx2oeaEnWMTTDJOBNVEGly
X-Gm-Message-State: AOJu0YzTjT3diaMsaIhUKe18S2rIb8v8ilNeRiZKarhVem2Oti32rADj
	38rMtTMhNvWd9U+w++GPUNbHauk3VOpCmnTsnN0BJx/msvSkRQqK
X-Google-Smtp-Source: AGHT+IHaRVdizvoW2eBOxvGtc/7IVqN//keUaKEJN/t8T2DXdU9AC5JIdgmXlAHTN+Ww2CT2gBd3Kw==
X-Received: by 2002:a5d:4f0e:0:b0:341:957a:1572 with SMTP id c14-20020a5d4f0e000000b00341957a1572mr9565004wru.0.1712045636940;
        Tue, 02 Apr 2024 01:13:56 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b10-20020a05600003ca00b00341c563aacbsm13762075wrg.1.2024.04.02.01.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 01:13:56 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Xin Zeng <xin.zeng@intel.com>,
	qat-linux@intel.com,
	linux-crypto@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] crypto: qat: Fix spelling mistake "Invalide" -> "Invalid"
Date: Tue,  2 Apr 2024 09:13:55 +0100
Message-Id: <20240402081355.1365780-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/crypto/intel/qat/qat_common/adf_gen4_vf_mig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_vf_mig.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_vf_mig.c
index 78a39cfe196f..a62eb5e8dbe6 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_vf_mig.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_vf_mig.c
@@ -976,7 +976,7 @@ static int adf_gen4_vfmig_load_setup(struct qat_mig_dev *mdev, int len)
 	ret = adf_mstate_mgr_init_from_remote(vfmig->mstate_mgr, mdev->state,
 					      setup_size, NULL, NULL);
 	if (ret) {
-		dev_err(&GET_DEV(accel_dev), "Invalide setup for vf_nr %d\n",
+		dev_err(&GET_DEV(accel_dev), "Invalid setup for vf_nr %d\n",
 			vf_nr);
 		return ret;
 	}
-- 
2.39.2


