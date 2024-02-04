Return-Path: <linux-kernel+bounces-51743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0298848ECC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 520DCB22076
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE0923750;
	Sun,  4 Feb 2024 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="ge7NGRcF"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A2522EF5;
	Sun,  4 Feb 2024 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707059209; cv=none; b=XY1p8eeVhnwGw5i4IljoIGoaTXaXdUWqs+uXc4cedLZkUKgIMizrlZGpO+HO6fbLGPilGK9nfVz3NjyTVF7i+c6X5yuAVaZGz9/v3/Dxb1MFMXCvo+nm+OVQXA4zzBZ+DSZ2/8OMJ2T2dGhncLlp8cxmJ/bN9z4S4FxksZbcbgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707059209; c=relaxed/simple;
	bh=DtL/rj48QTd9lRPw6xPNjYPtR2GFBn9tAGzHB4G/qVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hLD1zWYMF30he6TgVdJXHloNMxvFnny1AMzGx/yeu3DLCaRuEUXOFhyEIWiyffyysJu7N9JeL71KNI/Qji2UNk9PdsGN9+SocyinI3FqNxjGCbu25GOMQRJcKTT38aRzGLfzilc1esNHCmTDPUIMSQS7Uprb4AqQT1bJ9foP7yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=ge7NGRcF reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2969da3e5a7so37532a91.3;
        Sun, 04 Feb 2024 07:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707059207; x=1707664007;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4WWcBCgV3xgF0CDiZiVH3sUpocLC2BkMhO8gBV3rBII=;
        b=YFRlUd+Eoyp/n+7IBoI7jP4gsHHT/5FANbqNSGtp8xUYDNLwy2f4D/VeHiAonjxKTQ
         O+Cfyiov+iNw8PMuoMw74ajCZUUul6fr8Topi0FhuutZe7YXN8nk2WiyHA5w6EeZb/Pm
         mM00FBlJy/Gg4le8jP7roxcxB5j0/fleEqA6BoOI9MpDsBQ5UUY4VE66lf/FYEpg8+x5
         A7C10jEMKagkp3TzxhxhhyHSYsqI20y4AE0uFyRn/rSC7L13oqCXz1rmJeH8D4TXYzsT
         AL8Ug9K+4EKOViJjYFUcs1YAYERkEy8fAWZbLcFiCpj55w5ZRFyL9cIgjwNmUsUM2fvi
         wvpw==
X-Gm-Message-State: AOJu0Yx25+XjQv6POtaULMz/LRGGGCNkTBCugC4fdXjeocPdag9xk5a9
	2I6m0/NtErxAnxCkZih4pACGwJXNmNPNs6oTKO1YX+oYRon5ljHz
X-Google-Smtp-Source: AGHT+IFc4czdYvOMZb8c9+pJJvDnMGvicZEaQaJQAfTiZNapJ7KlgRICzOgbsLUMOw+P6++12UUXKg==
X-Received: by 2002:a05:6a20:a323:b0:19c:88c3:f400 with SMTP id x35-20020a056a20a32300b0019c88c3f400mr9662281pzk.51.1707059206986;
        Sun, 04 Feb 2024 07:06:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU1I5Wfzp1zyaw3J5xeL7RVOfNWZJc61b6w8KibHJEaoADx4XjCLPTSUOrFsN3ykA5BO1vhUowrHf0vsA9K6BesHntKdl+TXjwgULFCAQolWXeT2QHYIgbUGRNRpYBCII17efWcBUsULw==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id s17-20020a635251000000b005dbed0ffb10sm5229058pgl.83.2024.02.04.07.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 07:06:46 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707059205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4WWcBCgV3xgF0CDiZiVH3sUpocLC2BkMhO8gBV3rBII=;
	b=ge7NGRcFhpBopShOEWSMVucyqk8ZJNaqG8vpC4jwDYsFVpMbnMr9CDFvlpH3t5HdsWJF8J
	dk63cE18Ssrdgo6TdTAdKLd7kNJnNZVi5tKHAruzlq4wWwbPbkxqYr8sNaEjzpkArSMJtP
	+syKNAcSLVo0c41CKSu4t4b0sJqmJouHx8t4kCjRfFdcLET+Bl+uR77uaUUIvreKC4vdRW
	pUXGRhm1FTwmKmjeJpQ4SwZ+HiNyMAtMX7/Zc5Qo/ONhCJeVeP8DoVmsyg8BORreLV1aL1
	MBhpyAq2jDPxtycLGQR/V2WU6BE5M7XnQmwyH4OpJZwHw9XfdbDXr6B0ETNqLw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 12:06:58 -0300
Subject: [PATCH 2/2] mips: txx9: make txx9_sramc_subsys const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-mips-v1-2-05af5e9a7ead@marliere.net>
References: <20240204-bus_cleanup-mips-v1-0-05af5e9a7ead@marliere.net>
In-Reply-To: <20240204-bus_cleanup-mips-v1-0-05af5e9a7ead@marliere.net>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=948; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=DtL/rj48QTd9lRPw6xPNjYPtR2GFBn9tAGzHB4G/qVc=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv6gcKbCWSvWamcZU4OHB9cGcXKbzrtTB4v/xo
 qj0Dv3TYY6JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+oHAAKCRDJC4p8Y4ZY
 pt9SD/0RGAK7HDjICxB9fAie13GpRWS7ndpzkwqxpwzOfja51FUWuC5yx9CzeilPgCgd+OFXT08
 2HWaZfiCWEN0mjvsVHsVJt4ewsXuBT04bWleOZ/1UFRX086SvSress64ScWC051NdsXq489nNFf
 o3/RI9VC+dRmmP0HEfYHurTYYEL/eHtIzpOCqY0uwLu54gGC8RQW0ROJcCBY+CcH3h6xPTXFx//
 OMmsXUJRxBverMNAchGczMSpx/MOPQPVLi6JKxD/Zzu8ciCdctUtdTAiafO7LUvJJW1nldWcv+F
 BvkA1M+9Fsk2+TWayU+nyViqCj8lkaXARSspBbjkCEBT89nKV26vP459xXNRyKs3lLm+W4udp3U
 DFzhlbfyI07aaiQqADsUr4GaVVRFEYZG45Z2KD+eZ+ymtntfW1vvPM4f1yohR7hdQ3oUv7kc8pe
 Pai7+au8lBUwtROSChjZawhDiFTSIIYnrDPxGhKL9CaI0M6ITdR431RzjuRL/IAtzGo7FZ3spJn
 1XMt7pacwLEPtLayTnVOwYaqjWg6bi8juds38KNNex4bCc+jSdEWGO5/OVUu/3Y/qp08y/dmEUW
 w8YN6DtaYlSHAsaIyBUk2A5iXVxYCFDBpzyfCQQvY0DemNUwkzja08GNA2cG0HPTcri7UPYs1Jb
 9qSAzyLP6AFqvQA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the txx9_sramc_subsys variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/mips/txx9/generic/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index b098a3c76ae9..1e67fecd466e 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -762,7 +762,7 @@ void __init txx9_aclc_init(unsigned long baseaddr, int irq,
 {
 }
 
-static struct bus_type txx9_sramc_subsys = {
+static const struct bus_type txx9_sramc_subsys = {
 	.name = "txx9_sram",
 	.dev_name = "txx9_sram",
 };

-- 
2.43.0


