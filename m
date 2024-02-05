Return-Path: <linux-kernel+bounces-52394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FFB849781
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D0F1F23C46
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BD917BA7;
	Mon,  5 Feb 2024 10:14:19 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8609214AB4;
	Mon,  5 Feb 2024 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128059; cv=none; b=Sfg/QOFbJW0HQS7JoMW85pAyxfddTTJk3xMkx6rnVR52lRKEoCsjuKOkXqZA7DvdFnfW82CZJw7uDvcJW4yD+KhiSLxzw3l30yjX2bIxj3w698F+gXJFof6P8nvUMuLBJDV05qm5ep/HcAOrh+OuxXl0Njpwamuf62aK8IVInp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128059; c=relaxed/simple;
	bh=atwRRAFztXzGD3KWPYr4aeQs1Rpm8oWvJPjmX4wVT0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DW8M0KjIP90qqoGpPnmKzrfCaEsTyefXQ8df2mmmak2l22+PjByA5GzvqQxi0GetJY3yCX8GsrfuJjd8tVkMlWs9pz3o6OL71BMBZSJJ+jSeurkpNQ6NJ7nJhEAQDH9P5EPkTG9k/HFoLqkIMBISiwpV+fr4pkc7MIOnmGiTx7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5605c7b0ca2so997330a12.3;
        Mon, 05 Feb 2024 02:14:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707128056; x=1707732856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmCKZcfoOVWDMX06KS3eziDG+p1IeDEhKIKh82+FwlA=;
        b=FCmp8mX9TQNoQ19jTseW2GI05fm0gnFWUhgsHrvLBHTH8d+CmX7xtPpzEF0Nt0PNSS
         Ow9bO9eEy1XPDXSTeUN3syfsuQxjR67RWB6nYclPR611QJhLikGEMO/qK3xdfXQGVmVG
         gtLHbKOsFdAd+3ykBqaMwDAFH+/QPozE0hDAT1EyGu30sgzh2WBzokAcX3+6IofNwD6e
         Q2m+0JyHhEo4A0/6qAFTS7yrCEI7ISWmFZrikN3XAP/qc40Tl7Vs35ABbzvrqwvzbvmr
         l/qtdJLtEnO2Rw7HF8iPSlbHnPwmwOohbIHIYejDO2RfzxSHrFyyJriG3ZEwW+VTROPf
         zc3w==
X-Gm-Message-State: AOJu0YxVOr+bm4+onZ8Z4T5est+q/EeWUTc6kyEWkzeQ3GoONQPHcHbG
	JJEYpEI3P+f4GaVva/+7BA/1G/zkKLtaRSXom7yCbrURqtHATvwC
X-Google-Smtp-Source: AGHT+IEhifbTAGmBYXX1oxAT/ejbyyDOKTVh0ejcGS5DLrP2REMg2mwuvw20A0blZXAb30P5XNzx/w==
X-Received: by 2002:a17:906:1445:b0:a30:e4d8:2e46 with SMTP id q5-20020a170906144500b00a30e4d82e46mr6731829ejc.20.1707128055539;
        Mon, 05 Feb 2024 02:14:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUSwNs+YsbAz82t5qbE5UtinQhUx40LNgVa/V6saHAIMcunPyjnumLU5rdi+DvfI/PShK9Y+RU1aYDv0pmlzRgbhp04Aln5+sYpVJ92NSs5nG20TgbWvt8n/VgJAo+QQ7pMKGspSvTNdW6gbiMLZD4qi4Y4StHjF0/MutfyfY/2j+X88IF42q5iebnsAQXM7ZUmSMX+HAzE64Kqt/WqWcwgj4ziCz6GBrfUH/vJfynzJR2MeWJTm4wpWCIENVuR9m/Yc4WEqoV3t3y33YRQUNPX2hA3H/hIDpTYFXJPwP1sDlPg4CK8cg==
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id rf19-20020a1709076a1300b00a370a76d3a0sm3839896ejc.123.2024.02.05.02.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:14:15 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch
Subject: [PATCH net 03/10] net: fill in MODULE_DESCRIPTION()s for af_key
Date: Mon,  5 Feb 2024 02:13:52 -0800
Message-Id: <20240205101400.1480521-4-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240205101400.1480521-1-leitao@debian.org>
References: <20240205101400.1480521-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the PF_KEY socket helpers.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/key/af_key.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index d68d01804dc7..f79fb99271ed 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3924,5 +3924,6 @@ static int __init ipsec_pfkey_init(void)
 
 module_init(ipsec_pfkey_init);
 module_exit(ipsec_pfkey_exit);
+MODULE_DESCRIPTION("PF_KEY socket helpers");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_NETPROTO(PF_KEY);
-- 
2.39.3


