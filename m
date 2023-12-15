Return-Path: <linux-kernel+bounces-507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9174281422E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2C9283868
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433D4D2FE;
	Fri, 15 Dec 2023 07:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0OveFEi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2D0D2E5;
	Fri, 15 Dec 2023 07:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3536cd414so2472185ad.2;
        Thu, 14 Dec 2023 23:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702624090; x=1703228890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W37C+2ycxm8oCs4BdeN3ah+5YgIymOSMK8TmPVfIak8=;
        b=h0OveFEiRLQFrmT+stUKGyzD5x3fxAAbTrrWSQMsBNl+vRbCwUupLQAyyCFNgKThlE
         AqiC12yo3wKtponXBohihultFBOBF570SbhMTWJ1R93GiWkxZgZ3hyrF+XSONo5BMDda
         eBi3P/8URKwPodV8bCTkzhVTnNUUlFq6/NIEysFL2lfC377UEty1r0D8Af276plOLQUU
         yGJWQPIbugysrjFfwrvn+LZiIBxZIxrxZksJYBnSHGETqOUQZaa1G75bWn7v+VQwTsdg
         2bQQ3z+RVA0fFI2bs+w1jhoZOAZRuSQJX7h9V8gA2EybnFPlwWiXDE8h4iOeyqeZWjLt
         54WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702624090; x=1703228890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W37C+2ycxm8oCs4BdeN3ah+5YgIymOSMK8TmPVfIak8=;
        b=OoIrOtwuDMqSFZ33fc2wZ/Wp3X+CCx33EHvSs8NIPBZVdk8tuWHrELKlKKfRuW+KX+
         q0sGlke3KxwWtwhbTpLMFFUhe4Hw9sYRLef0dX2uPr+gHDGdkwL9e1adpH57fk9Rhw4N
         h2zcWCWnJS0qNoyHI1BVgvoYYwxjWyFPsOR2hZLEfE7qR3Vs6QlICAEIgbQuZmvCUaZS
         BMDF96wUo45ZiNeZsqR/mnWakYkYDh/sz498xdNFYDioIhdeWNMT9Rd+7DDDI8/XUvOz
         zVOJD7ZA585CM64GXC3hfbdwOcbIXBGtVoc/WrAy3WAt2J9A23gxvhHIak0Abuvk/6aV
         ns9w==
X-Gm-Message-State: AOJu0YwX4gK8A7NoNEZw31rpbH8soR45fvoL9YJPUsJPWViJNb+xlp5c
	/ftCGqwn9bEjdzT8oyKG4WQdzgV5owKE0RcW
X-Google-Smtp-Source: AGHT+IEsR0otrr0vI5FBQ7KLhMOuH6LxIFN52Hnn3le3jEKId+mlEnzlNRw0R6fAeBgWf2Kz8s1f7Q==
X-Received: by 2002:a17:903:24c:b0:1d0:6638:b9de with SMTP id j12-20020a170903024c00b001d06638b9demr12709592plh.10.1702624089645;
        Thu, 14 Dec 2023 23:08:09 -0800 (PST)
Received: from localhost.localdomain ([202.137.218.19])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d90200b001d369beee67sm2418224plz.131.2023.12.14.23.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 23:08:09 -0800 (PST)
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
To: agross@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: soc: qcom: fixed a typo
Date: Fri, 15 Dec 2023 12:37:07 +0530
Message-Id: <20231215070707.560350-1-ghanshyam1898@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed one typo.

Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
 drivers/soc/qcom/llcc-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 674abd0d6700..2625b39c5057 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -715,7 +715,7 @@ struct llcc_slice_desc *llcc_slice_getd(u32 uid)
 EXPORT_SYMBOL_GPL(llcc_slice_getd);
 
 /**
- * llcc_slice_putd - llcc slice descritpor
+ * llcc_slice_putd - llcc slice descriptor
  * @desc: Pointer to llcc slice descriptor
  */
 void llcc_slice_putd(struct llcc_slice_desc *desc)
-- 
2.25.1


