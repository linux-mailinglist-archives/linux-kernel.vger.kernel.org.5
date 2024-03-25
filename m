Return-Path: <linux-kernel+bounces-116790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F0A88A3EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652F91C3A6F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0463718277F;
	Mon, 25 Mar 2024 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mX+EpAHb"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4575196694
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361053; cv=none; b=F0UwcnbgkLtN9FVrn32PdBJpayxWCirraypGD921ZyiNO8rpLQjcu5Enokp4WCGQ7Xg7xbRTrMk1bh6dYSAmwCt7af9AnXcFSMG4wryxjFo7sKGFY5fscNSlh+PD+puwwZP9iTOJ5EaGfFN2s3iWLNSfgTDfyXUEH6bpfSJGXNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361053; c=relaxed/simple;
	bh=Xu1f+RPnvEjBRa3DS5LFCyEe2cJ9nWGA+wJiNMQI+rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q9Mm59Dqz3v4eae/kIGd+KDMV8iWqaMaxCegrMlfDa7fjEDDP01HR8C4HPWRE31n1xuqhZsHVebQP3WqbSKaBcAMViduH9AGQkEhrt1yQp2/sR+bjOUtuaDghc1ABjB0XwLvo2p8yCsYsW2V5ZCgistKT7TXer1nOuYb5YcKba8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mX+EpAHb; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-341cf77b86bso355274f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711361050; x=1711965850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fl37vGRYSy2kvf67OGkupfqZ+uqFGGpfw8NF9/514Q=;
        b=mX+EpAHbM6wART6kFGrGyie3b+83UlT/m431IWSyrQT/ktQ/hCO9Ba1BqfJcCIqolS
         zgZMv5hQUNLDor5Ef+QgPyRQWGwhoYdkBdYjH1ZDYDpgQQlCq+mbfO86gAhxwmUPYcDu
         Y3z9W5rINGQAEW0biEnfQ1+g9I++8ts3ybxh42oFRs7/JWzy2cH0pdYz3GOwOMaOG9Nd
         I0tPrwYypTQHXpTUfOwj+NsZBsb0jfv+tQ+EbDklhXUrp1qP075wSm5pnoNMHtd367e1
         +Rt6v+eg0Q2i0j5T7mIqWhjHRIj0YouDTZHX5sfvcYTTN9g8II/SHK/XdqZcXRp/DUDR
         PA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711361050; x=1711965850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fl37vGRYSy2kvf67OGkupfqZ+uqFGGpfw8NF9/514Q=;
        b=haEWhUFaXTdYualgswp1XocbemouRdyDUkt3EJzFBkSpUShJLsCTDt135Al5EjXLXj
         fJsdGX1nyTrJ5EQNPSKNLioSTvlVP7tgotmB9xezGqbM6n2fZvGn6BfH5Ktp7j/BbSed
         Qr8D0inyjkVAOoplvkIvKe0OaURx4fwsaZL/MgefOMdUGk+BDA9uqFTuhLGAIyd0wmG0
         b4dRkgwl68p4kfvRNS1g14M37QLyqBGJoh1faR1P/7L0JQtiIck73Kvkk4BSi8FeEhxp
         B/0zU3kBmWMFxo7RDpEs5F63/GpFotPnLBf982QbDbeeyeP/ZQ3ADCrWF49fKhaqIsrW
         BQHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtqHAgqDcv2ZEtWxr/7HaMCUbLpqfX/6aMBXKwgVplW3WJMu4TLG/i1FiINU6Qon0oKdKQOf7TfRQR9N0JqDaUoIdNbFZKpnR9uRiU
X-Gm-Message-State: AOJu0YwPftGl9Xwmz2OZCj0U8yRm82DxY8XY+o1A/pKj2CGgwJQ3+Twp
	tvBV7WJTiZ8NY2dvIPW4L3FCuyIG7Q0DGxKFv5wC1R8vyglfGcHHWCKrct12PrQ=
X-Google-Smtp-Source: AGHT+IH+hhp3hOA7UiKIPybzE1EoKjoYoyhlQKM6glQr3E4kR6w3ftf3S8vD8LlexgRD9oDYqvKJUA==
X-Received: by 2002:a5d:4084:0:b0:33e:c924:5486 with SMTP id o4-20020a5d4084000000b0033ec9245486mr4958754wrp.46.1711361050341;
        Mon, 25 Mar 2024 03:04:10 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:861d:8b72:a859:4ce9])
        by smtp.gmail.com with ESMTPSA id dv13-20020a0560000d8d00b0033e25c39ac3sm9086874wrb.80.2024.03.25.03.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:04:09 -0700 (PDT)
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
Subject: [PATCH v9 05/13] firmware: qcom: scm: make qcom_scm_ice_set_key() use the TZ allocator
Date: Mon, 25 Mar 2024 11:03:51 +0100
Message-Id: <20240325100359.17001-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240325100359.17001-1-brgl@bgdev.pl>
References: <20240325100359.17001-1-brgl@bgdev.pl>
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
index cd47389ac80c..de66319cbfb9 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1200,32 +1200,21 @@ int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
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


