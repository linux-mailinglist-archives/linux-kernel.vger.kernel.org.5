Return-Path: <linux-kernel+bounces-89785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C139586F5A8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E334F1C21091
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A644869D2D;
	Sun,  3 Mar 2024 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NurPyJBn"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABADD67C6A
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709478091; cv=none; b=d6aFDnqHpAG2f2ay+CkW4wOi5ZQS1rQQgk2t0CwuHvKyn+pto3DjH+jcTfuhZ4BAo05GT7Mb52fhjZGQWgDazclKHvlz7NXqfI19Af2nyr9gq2jIyGQNVH0kvKyAP7YQKUo69CBZCYuBLLA1G7btSKszfb3ZbmmmisWN/+GazF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709478091; c=relaxed/simple;
	bh=OjLFQivtHlaSfovOENt2lbC4EBIzbzcugSyAVDkhXsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K3a0NFAs06JqDnrs6yD8ctGvjoRKrciAnPqXJlduA21gwZHhNRmo7WPXugnGpJcBIVYyt1quGIACS8yurl9s30DhPFLTN/Qbf8/nr1TDraM8/wbUMGjZreagmYUaMs+SyqMm2+hW+bnFR2QICbbaiYRelcVFiM+N8lLVF69U/2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NurPyJBn; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4515f8e13cso49114066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 07:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709478088; x=1710082888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcH8Gs0ePK1IRGlv4zM5EcshiNK/rdgYWkudHAB0izE=;
        b=NurPyJBn+7dlm0QdXpg7iPjfa3cWWXeQmeEfXO43zW1oYZXSk5mTS9W5DS3voWLE1M
         UQ0su2jnK6EKj5Cv2KnHeOkM9ryZuCtRbExvftxFg69J6+3h0zExWj6CkKSVepSQL9fc
         JCjfwmRtHFfe6CcUPTMri32RGKkcfftc+lPrXuXfku2I17QlI/11gUCe75qJGbS4VZst
         s62YoWf2dotdfMtW8Sgk5odluSzvEzQ65epkI3SGEZJbRouDcAAHmbLs+EkZsEjb/8Z/
         VNzIBh4gwYdRSC6gjAHBuMy5r8ADrcIXrD85QHdGvgExMbshFyTrvvy06tjnIBp1HL6W
         VxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709478088; x=1710082888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcH8Gs0ePK1IRGlv4zM5EcshiNK/rdgYWkudHAB0izE=;
        b=pPWozZLveENKV5lDwZ7wiRNoLV/0FPGNgrckB7MJGYJTy5a/F+Fny7J2n1PYVh+osE
         RBshQRmLuq7sJ4IjFjBTRzdqZPoakPTsFw16FimDPpkYL63NGUi8qU+TFEezK9l4vX7X
         /yHbl22GY9wKOT7wkSy7A6KjpIFfUifmQWj36i76tJXMSutEp6fTUmDF1B1CYFQHFUca
         213L1iKwazOdOKzgUOtjjYaiU/BhekGWVPZLLs9z6rbjpdHh1tZ1xUXQtmgj0xOWTnjK
         GAi2IXyHa7VESSplNojZORbVY5i99QyImohu1dw4MG71uP5iO5HStsZpc2UmsGc0Wg2x
         9rIg==
X-Forwarded-Encrypted: i=1; AJvYcCWUDQhyVLX9F1UfiQ+7l3qih8FHPEHoq7kagWqV456C6Yjlcapw+uXN4WQPmD8W2jSw453+mMcmAv5t+tEs4+17pgZcmjikueRJNRnP
X-Gm-Message-State: AOJu0YwsKNNGu23Suyq1SHdRrsHoSbAqCy2IuB1RaZHjBA+1m9O2+ijv
	mqGbDHiLuzzYVL66FxUUkSR1vcBQawO5ZRCvm78lMsKAbxAvAtaWp+IXXXmvaTk=
X-Google-Smtp-Source: AGHT+IHvinUrWnb2ODBDZj/G27wn+bgJ59fftISqEVUtBV74uxy7DphSvelwNQdD7qV6cUmJJn5hPQ==
X-Received: by 2002:a17:906:3bd5:b0:a3f:ac54:5aa1 with SMTP id v21-20020a1709063bd500b00a3fac545aa1mr5265556ejf.21.1709478088194;
        Sun, 03 Mar 2024 07:01:28 -0800 (PST)
Received: from brgl-uxlite.. ([77.241.232.10])
        by smtp.gmail.com with ESMTPSA id ch14-20020a170906c2ce00b00a42ea946917sm3740293ejb.130.2024.03.03.07.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 07:01:27 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Guru Das Srinagesh <quic_gurus@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: [PATCH v8 05/12] firmware: qcom: scm: make qcom_scm_ice_set_key() use the TZ allocator
Date: Sun,  3 Mar 2024 16:01:08 +0100
Message-Id: <20240303150115.133633-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240303150115.133633-1-brgl@bgdev.pl>
References: <20240303150115.133633-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Let's use the new TZ memory allocator to obtain a buffer for this call
instead of using dma_alloc_coherent().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 054b538828d5..50c574fef3ac 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1197,32 +1197,21 @@ int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
 		.args[4] = data_unit_size,
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
-	void *keybuf;
-	dma_addr_t key_phys;
+
 	int ret;
 
-	/*
-	 * 'key' may point to vmalloc()'ed memory, but we need to pass a
-	 * physical address that's been properly flushed.  The sanctioned way to
-	 * do this is by using the DMA API.  But as is best practice for crypto
-	 * keys, we also must wipe the key after use.  This makes kmemdup() +
-	 * dma_map_single() not clearly correct, since the DMA API can use
-	 * bounce buffers.  Instead, just use dma_alloc_coherent().  Programming
-	 * keys is normally rare and thus not performance-critical.
-	 */
-
-	keybuf = dma_alloc_coherent(__scm->dev, key_size, &key_phys,
-				    GFP_KERNEL);
+	void *keybuf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							   key_size,
+							   GFP_KERNEL);
 	if (!keybuf)
 		return -ENOMEM;
 	memcpy(keybuf, key, key_size);
-	desc.args[1] = key_phys;
+	desc.args[1] = qcom_tzmem_to_phys(keybuf);
 
 	ret = qcom_scm_call(__scm->dev, &desc, NULL);
 
 	memzero_explicit(keybuf, key_size);
 
-	dma_free_coherent(__scm->dev, key_size, keybuf, key_phys);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(qcom_scm_ice_set_key);
-- 
2.40.1


