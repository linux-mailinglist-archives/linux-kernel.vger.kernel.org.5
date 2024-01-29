Return-Path: <linux-kernel+bounces-42741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EB28405D8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10BEB2868D6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B653627E5;
	Mon, 29 Jan 2024 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQ8jbGBV"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535056166D;
	Mon, 29 Jan 2024 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533056; cv=none; b=RdsvLInHso8YEbSLS4CLY1hViypu9O4ZuhbcPzOsMeR8+iEqkbdgNXh0X46lgtsVag3eSE5LDkMStFi/lDkSQargzAppTRZx4O8enmbArp50PLe36fEWmEiLuoLrVY/EORSjK/YXAtyaLBnaFoHodLGRiebho33FpjVYCZ/69/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533056; c=relaxed/simple;
	bh=uQ/Xzy1t1vgnWJ/4O5irvMHl8vFPdVlozjit+qHy3vw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nFBZI1hoL6Q3C6fmASR3ApmctQ438UsrqBj/Diz1yvmGLqOg7+qKTXBuyT/IaLrZbDPgt4ZmEIbrRF6y5n7pRRXgWCmsROQ0mxE9aGrEX+VSG3Mt1uIQLuj03IiTGwuaYxahY05S2aM5Cnw0dtyIvX9XXo14KDjfs2KwPcIl3Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQ8jbGBV; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6001449a2beso17037007b3.3;
        Mon, 29 Jan 2024 04:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706533050; x=1707137850; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q7MRtgQq1559VqTtq0fV0eOYg6mrlq7EbBFuJ58DRMI=;
        b=AQ8jbGBVOFd6xGwO0CItRemwVgIIWS0L8O0IVV/eR7Ic1oMicAUU/HgFHfAVX7zuDd
         6Kxfc8C28ZtOHC35cHmKwUBXmPkE4onDQTPGEXYrXwwsqj/9zBkkQ1G5+knLDGqlWeky
         sAPVkDEGajz+D5h1dDV3sHHlgSTlV60yhHxwjLMNdgd3+1kVIToCPEuYnvRQ7+pWoOa5
         x2r4gi0bgOQQdhQaCO8xCYfgbdsgmN/RqDOefGsmLPsZVMe8Wt0B+tBeiMcNZ0CdSLeP
         ET/x7aUnZvfeA5jhAlj1O2chu9KGSeTKBZFqXzemTa/PWD0zGjgZLbVJA2PU9Wp3b2yN
         8XWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706533050; x=1707137850;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7MRtgQq1559VqTtq0fV0eOYg6mrlq7EbBFuJ58DRMI=;
        b=KM00yC+n8uI0pM+7FACzj+ERLjmqW9niV8a0NBRS53F29feicOtB0HJJU6HsTOkZ/5
         xVKeLdyyj3/VjanGBhbSGvEo2eHevZ+lLrlQA97CmQcmuoxdDYeqsvM5Pl3KppyxWrav
         Wcd5hUV+U9BkOEclEzHaPia/50iusJF5bkcSV2ydEDvBE+LizbezKPJVVnkh9ojs1iej
         PfmQ6LXfh1iPa4VHtcQAJB8x/ZJhNfQUOd9oB71UoR2e0+uVuu3xu716gtEOfn1/44Zp
         dSDsTNryu9Ii/sgW6JQDPAsDUWL2cFCd1o3fJ+QuLUrdzGjBAp0mm+SmauwbQugd+Nj1
         /HCw==
X-Gm-Message-State: AOJu0YzsVBCSTeVKuiC2xZHb3PKO+yBTuYi01vYTDdJDt+SEiV9TaFJP
	M0HUeyjj3kpSAgIi6Jv+PQKaEWnmP8YKs0ccfsgXrnJDDowkDXg=
X-Google-Smtp-Source: AGHT+IEEzC5ixYHXvoggCQs5qrvbv9IqQr5jYpj6wOIk6jV/fBwm69ksRVsje5mHZpNEaplLRhBK2Q==
X-Received: by 2002:a0d:d793:0:b0:602:ac0e:697f with SMTP id z141-20020a0dd793000000b00602ac0e697fmr3722989ywd.51.1706533050102;
        Mon, 29 Jan 2024 04:57:30 -0800 (PST)
Received: from localhost ([207.181.197.26])
        by smtp.gmail.com with ESMTPSA id v7-20020a05620a0f0700b00783b6da58a9sm3077939qkl.39.2024.01.29.04.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 04:57:29 -0800 (PST)
Date: Mon, 29 Jan 2024 06:57:28 -0600
From: Lenko Donchev <lenko.donchev@gmail.com>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: qat-linux@intel.com, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] crypto: qat - use kcalloc() instead of kzalloc()
Message-ID: <ZbeguDTmVrP9SnDr@nixos>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We are trying to get rid of all multiplications from allocation
functions to prevent integer overflows[1]. Here the multiplication is
obviously safe, but using kcalloc() is more appropriate and improves
readability. This patch has no effect on runtime behavior.

Link: https://github.com/KSPP/linux/issues/162 [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]

Signed-off-by: Lenko Donchev <lenko.donchev@gmail.com>
---
 drivers/crypto/intel/qat/qat_common/adf_isr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_isr.c b/drivers/crypto/intel/qat/qat_common/adf_isr.c
index 3557a0d6dea2..a13d9885d60f 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_isr.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_isr.c
@@ -272,7 +272,7 @@ static int adf_isr_alloc_msix_vectors_data(struct adf_accel_dev *accel_dev)
 	if (!accel_dev->pf.vf_info)
 		msix_num_entries += hw_data->num_banks;
 
-	irqs = kzalloc_node(msix_num_entries * sizeof(*irqs),
+	irqs = kcalloc_node(msix_num_entries, sizeof(*irqs),
 			    GFP_KERNEL, dev_to_node(&GET_DEV(accel_dev)));
 	if (!irqs)
 		return -ENOMEM;
-- 
2.43.0


