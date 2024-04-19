Return-Path: <linux-kernel+bounces-151655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB838AB1A4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2573C28434D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D7513440A;
	Fri, 19 Apr 2024 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JY2mHB5c"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC24D131BCB
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539894; cv=none; b=gROFAk959lANg6Kuww4S6Jz7Qi4f5Nhn29dYdTbygFktXPtpZS7A2gOd298KB/Xc9tWjI0RQGZ46zTKQQxcP1q6YUwFLup0PaLhNVyyeNfgitPQJyMmz9+DdIKP1KT3UuoIxh9SZ9g5GJJAd/aJe1Kk0s6ttlihER2j/DO8QuXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539894; c=relaxed/simple;
	bh=29UQTRms78NT9PmEmVPmwD7BlBFzDdceaYcGgV2Ra8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CJVMsSH6Pt7t/lNwovpdtLafxTDadMTk3aODiC0+eMAXLTpUm6ZmOge6AGvsbCjSlw741ep8YxXP9/AXiQCV4UzHw6N3ASryzJ9x5jSHDVDMM3n+ubTDaIwduZ5jBaUYkfyoELNWUsKyRjR8uGU/X9DbLFeqXabAzh2R2Tk39d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JY2mHB5c; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7da42137c64so54020439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713539892; x=1714144692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNVrYLH0wb76uVIxxR6dH2jv6p++X/8Jk5CCf1uTdzw=;
        b=JY2mHB5ceKbhrSDbuj1c+3GB1u3p/0i4hG7ILO46BaeJvwf8F63OVdNCvby5/s6Z2K
         5mDIwS3AIlJkDhldG8cq1ugu/ADL+pMtuqTLHfUvDv0xkGZvRZCGFGXjcJ3bDjPL7g7a
         TFadgwnc2JidoRAmpr0KFV7NsLQe229vBYKXMdyFLSvjsj5oj0tiWDFTA9KMGmmJRqK3
         4WganPDT0AI0Y+wSi2+nBbuBzksDfs3+oOZW7kENk0KaOmGPxpdkuScpJLko4je/hUAP
         xERZRC0zBM/PplXQhpmR5ucFTXl3xFO6DK3F5dDSeUTqpuVxi5EBizTCBLyCA2Hi23M1
         OsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713539892; x=1714144692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNVrYLH0wb76uVIxxR6dH2jv6p++X/8Jk5CCf1uTdzw=;
        b=qN1rWW9stqPDrMK5Qmbwn1mdnSG8c9aShR5q/QVSqlMRbSe78t1chxPEfLErupIC3C
         AekrX1lN0SyXZURMfqLQpEkmtJGCgV6gMJVEOIgq1hrhE48A6Q9IUClNcmev+zEha35t
         P/lYOXq9wFXzKVNG7qQH/J0R1zjRMH6Z7ZyY9OjkVr8N+oi3Dn+ZBXy3+vsVADNhcTEa
         KUAenXU18Ts/5DN7wVRdJP6f7UZhKkHMBHNe4HXXjedUZ+8ab+DSLtQQKkxN6r561EbB
         R6vcISIth4Ip1OwSBbeG2cVXCKJB49eJVMdbeMED9PKLW/gWBLl6FTH9Nn0YnSyb6oFg
         82cg==
X-Forwarded-Encrypted: i=1; AJvYcCWbPLBvq/0AKzTyEbdFY0du25YKawotkADjgEircAW7aLSD8Z+lMQqDjUMvviQy6NjTTY+rvg04fQogG4q5AQSdMtwmj0GSO2tL1fXS
X-Gm-Message-State: AOJu0YxpOrvuxd0zIsJf4Au/LaKlqWNAW/Nk0Cswm6oTKuXLTiL2j2IM
	HBQCejXJgZKxTWgfvFlmhMExWa5H8PlHsalSqxb4Ck+uDCOKmNlCOMRUD6FS+yg=
X-Google-Smtp-Source: AGHT+IFigKq8yuqDrNndjHBMbYyQIQ1Pnj1JL8I9PBudmiqEMtVw+in69/DdYxB8/vTe9aRyxy+MRg==
X-Received: by 2002:a5d:8995:0:b0:7d0:d84d:9e13 with SMTP id m21-20020a5d8995000000b007d0d84d9e13mr2743219iol.19.1713539891870;
        Fri, 19 Apr 2024 08:18:11 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id lc8-20020a056638958800b00484e9c7014bsm116126jab.153.2024.04.19.08.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 08:18:11 -0700 (PDT)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 7/8] net: ipa: fix two minor ipa_cmd problems
Date: Fri, 19 Apr 2024 10:17:59 -0500
Message-Id: <20240419151800.2168903-8-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240419151800.2168903-1-elder@linaro.org>
References: <20240419151800.2168903-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "ipa_cmd.h", ipa_cmd_data_valid() is declared, but that function
does not exist.  So delete that declaration.

Also, for some reason ipa_cmd_init() never gets called.  It isn't
really critical--it just validates that some memory offsets and a
size can be represented in some register fields, and they won't fail
with current data.  Regardless, call the function in ipa_probe().

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_cmd.h  | 8 --------
 drivers/net/ipa/ipa_main.c | 4 ++++
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ipa/ipa_cmd.h b/drivers/net/ipa/ipa_cmd.h
index 5824bb131ebab..2077fdbade99c 100644
--- a/drivers/net/ipa/ipa_cmd.h
+++ b/drivers/net/ipa/ipa_cmd.h
@@ -53,14 +53,6 @@ enum ipa_cmd_opcode {
 bool ipa_cmd_table_init_valid(struct ipa *ipa, const struct ipa_mem *mem,
 			      bool route);
 
-/**
- * ipa_cmd_data_valid() - Validate command-realted configuration is valid
- * @ipa:	- IPA pointer
- *
- * Return:	true if assumptions required for command are valid
- */
-bool ipa_cmd_data_valid(struct ipa *ipa);
-
 /**
  * ipa_cmd_pool_init() - initialize command channel pools
  * @channel:	AP->IPA command TX GSI channel pointer
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index b13a59f27106d..6a0fec873cddf 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -865,6 +865,10 @@ static int ipa_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_reg_exit;
 
+	ret = ipa_cmd_init(ipa);
+	if (ret)
+		goto err_mem_exit;
+
 	ret = gsi_init(&ipa->gsi, pdev, ipa->version, data->endpoint_count,
 		       data->endpoint_data);
 	if (ret)
-- 
2.40.1


