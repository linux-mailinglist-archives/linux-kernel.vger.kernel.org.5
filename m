Return-Path: <linux-kernel+bounces-134219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C6089AF27
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB741F23A39
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093D9E56A;
	Sun,  7 Apr 2024 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEh0vZom"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F15C2599;
	Sun,  7 Apr 2024 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712474620; cv=none; b=GCrAFHUhj82QO+XknBRPtKiqW7KAoBA++W+qcxgnIFCZ/WfS/HKs3a9f3ZcH1URCJqK5eDzYuAPBVKrMb1neBd81mn+5eFLQuBjacCtCTYqMDyI9EaR86KPqIAltfAb5OBAvb3T83oRSDreiZi+eOfHGGF/l3NVAXXTgVsBLUwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712474620; c=relaxed/simple;
	bh=7S/El9TdgvijcAglb5agsVUSiJ6mtO5aoRmD48cWGXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rCQGD7FdT0GITI0Cb4WLgGZONCNe1V6X6VhdoCII6aplaPbp7e1St8zjpinzmA73o18MHvIUyjZ6UdeAjnLHEGuGJp73oTC5UC+jTl3u4End1opHoq2I40/Rx8JFvEkUqH/kURdXqVa0cS7w1LFEhniwt+FyyoickQhCbKPUkFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEh0vZom; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ecec796323so3179069b3a.3;
        Sun, 07 Apr 2024 00:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712474618; x=1713079418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xLDjbth16M4GQYJ2I0rnUwmiJmnd3GMQV4Bn9gHO33E=;
        b=OEh0vZomrSj0L35zSWlI9+mqb/4GbpXFNQ+tRvnrOI5fLjmnnrqWP2NcXIRic6SWGx
         neDT0R/PGlIkZGlVlf4DUyFFLAO2solkIrhMYoa8K2RbeXGmhvOmaHt+aVw8URfIKOnb
         0NiR1p1H0MQH1nLSN/rgv2xjEXUD/tgusxX8MAXXRWWUXnGM5uIzMwWSU9iqjCRv6wUk
         7aHgBjW8TUV73kWFt9sjjoygjUVJlozmqMFv/17JkbkxDL6Sn/0Pd2L+7kOgPTAeDqJ2
         uOW9Spqyc5mgsFzNnpkwo8zvpW2M8Ya2/WObEEkhW1APfY2vq8PHp7mrumJntCmNoLyX
         aL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712474618; x=1713079418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLDjbth16M4GQYJ2I0rnUwmiJmnd3GMQV4Bn9gHO33E=;
        b=OxlEgUrpmuQJIVYK1d/sJJO/RIPaxMz8HFmJmYqGEzcP134aPGGFIj1QiiXiediOrz
         sCVgd3tcv2Ejg+7PvvpPdXfz95fDfFQOkeiwczcZD56fZpF7xZdgUXQCQSRMdb1rNQVs
         wge/T0OBC4UHXaFHAjHkcYXPsw/i0Mh5UNeBcYw7kGsDOQOID0azNUD1FzxuiIPlzYk2
         RbgU8hgdfDPvso12aYRbie+Y8xZ7Pg04qo3+XNiOkYS1UW6NAwlBNm8dSnbfr5YArnTv
         RWv0INpaZI6ErkuuoyfjxoGVDA7xA2PfNy0unAoU236mTN2IfsPZhUSHZoE3R3VOyatm
         M6rw==
X-Forwarded-Encrypted: i=1; AJvYcCU4GcwOWxctJDFWOqZVBwv2fRv9dJ5t+qBjtXfVQ/yFZ0AOIHQTRHKYER97U5VtYsUiJ7GPHAk3yTsekvQiA96WvNfV+FHGTUcLYWzf96WG8FhxZ5QEVSe+Z/8yLg+7KkvUMAWaoUcbMjfGPg==
X-Gm-Message-State: AOJu0Ywxh6Thft/JtzFNalwzxUNERrlz4No9x/sGqFtdk5JEn+c26OSj
	cmnNpRsaNaGZe5swriY2onIfVY1q09k1j4x0oq/chVApefvusacg
X-Google-Smtp-Source: AGHT+IFLpTvDq6bxCyg9x6iopUE3Doi2HXfYPQ45fUBDiXC8sMvGNZ9w1O21G/b6KOlSW7X0442Ceg==
X-Received: by 2002:a05:6a00:928e:b0:6ea:c2c7:5d6a with SMTP id jw14-20020a056a00928e00b006eac2c75d6amr9240026pfb.2.1712474618252;
        Sun, 07 Apr 2024 00:23:38 -0700 (PDT)
Received: from localhost.localdomain ([27.7.9.61])
        by smtp.gmail.com with ESMTPSA id x18-20020aa784d2000000b006eadc87233dsm4185497pfn.165.2024.04.07.00.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 00:23:37 -0700 (PDT)
From: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr,
	javier.carrasco@wolfvision.net,
	skhan@linuxfoundation.org,
	Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Subject: [PATCH next] drivers: soc: qcom: Auto cleanup using __free(device_node)
Date: Sun,  7 Apr 2024 12:53:30 +0530
Message-Id: <20240407072330.229076-1-pvkumar5749404@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use automated cleanup to replace of_node_put() in qcom_smem_resolve_mem().

Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
---
drivers/soc/qcom/smem.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 7191fa0c087f..ad1cf8dcc6ec 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -1032,18 +1032,16 @@ static int qcom_smem_resolve_mem(struct qcom_smem *smem, const char *name,
 				 struct smem_region *region)
 {
 	struct device *dev = smem->dev;
-	struct device_node *np;
 	struct resource r;
 	int ret;
+	struct device_node *np __free(device_node) = of_parse_phandle(dev->of_node, name, 0);
 
-	np = of_parse_phandle(dev->of_node, name, 0);
 	if (!np) {
 		dev_err(dev, "No %s specified\n", name);
 		return -EINVAL;
 	}
 
 	ret = of_address_to_resource(np, 0, &r);
-	of_node_put(np);
 	if (ret)
 		return ret;
 
-- 
2.34.1


