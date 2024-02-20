Return-Path: <linux-kernel+bounces-73267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D3285C039
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F088B23FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B85876058;
	Tue, 20 Feb 2024 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DL4j15bR"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93D627EA
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443788; cv=none; b=UaTZxwQ23E5YA2F7YbrHuk6vKwkB6m4oqGTiPhDeECHytk4ppJ0f6D8wiFAPABUW8PZjVFq+5aMpi65pkl3FeK828QjuW43RGCfx2Fpfq6TWAjBlH+qfDfP8RC0ypU04qqc1Cf0ahV6YRIf3IRX7gF7M8AtkJnJlkhGR5JIcyis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443788; c=relaxed/simple;
	bh=BHwUKr8biU6qwSoYRciff715r/Wq10MJ8jrCOgZ4EeI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VcZy380SU6gf233ivH/T3yQgzbF7AP+9+JgltTzj5IlPDNcGK8xlmOxB1fNJt3eUn2HnYjpIzEV0kwzmoRjEutDNZdGenOgHJrh1BqiQ1m8LQvTrkwf/B7cgYh0g0X9vOALKDTx/3jsipNtGMUSc+XY+yaD+ZP4BZkHRgBOLVt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DL4j15bR; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-59d78deb469so3513849eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708443786; x=1709048586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ba+FZT/y8DAA+ic+9F75Kom97L71NReEfdPzSuOXjjQ=;
        b=DL4j15bRVw8JX0Ue+Ro2pio4rRhekzaUMSW1tEC7sQOMlxAiPh+xP330Y+nZm9Hlhz
         Wk8IoeF0J8sC69vf7kGBNng3CHShuVURcTx34I0z4ynj/VCzw20J+FJiovGZAMjMINLV
         T+QL2QgJhi4Gw41wbWkyuAQqlGVVqxInrfzyndyOqAuhuor/65HEnOqnSMDK90F3Er3I
         T3eDTA1IxWlKiUca0YgoHAZazT4/HIzS4XjTcyjSs+UAxA1NGaATlG3Bsf3+/1pym/Ro
         fgFld9PggqtwvfRmydvbmhjINQ1Uw2tyopRfRpr5nKD8Y1FyLzkkFYmLWywzzaNCeUvG
         G6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443786; x=1709048586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ba+FZT/y8DAA+ic+9F75Kom97L71NReEfdPzSuOXjjQ=;
        b=LktsoA6HqA6Te1VklGP2MaC4euxQstPkxKBzZ8s4J8rKl78yxoCPSw0r4DsNz0EIXJ
         HK338ASiRJ4BfDTzR6hUEwzdL+glQGNGLNyPWbijUr1dVE+JcwCRYjsy2ILNjghHfT2b
         exrO/RmX2eEDiRXyFYbuZRuZtdDLjaprsI0gZ3OIk3c9ZEHIZG3SfQNb4JHCaKbeOWFg
         mkC3tnX7LPVPiciitJmeADykqfUsD9ZcM0CmPNNNvVPpTviPWw29n1eQn0d6xV5PEL5f
         17ULJbx5mQ+OKNrkaEzKqYqkCQbzCS+bq4GvyozJ1VRaquNonV8c56oFTTT40zO4/PYe
         DQ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/ndu4QExu3rKkl83EjY03rgLO8iam8PyQLnHPlmlLu54CQ8To12lFOR2m8Y7v3c+sbv4rGAxOcoPC4H/aqomvmGVg07+hs7AhZazi
X-Gm-Message-State: AOJu0Yy6+0M2OXbDgv8wopZDHKnWFoE1K/5b9IBL/ELhErVTciyz0u9A
	xppQK5RQj1OeBIT9WaGPOnO8moA9hKMZEcjmjozRZxW7ohQn5+FN
X-Google-Smtp-Source: AGHT+IGMh9C/THGjJ9L9lzGt8mkv2YzHJOx4qROhpehEf2GFdHrOOe/Lsm/J+pCmlIYkFTF5PQZHdg==
X-Received: by 2002:a4a:355a:0:b0:59f:fc30:d3aa with SMTP id w26-20020a4a355a000000b0059ffc30d3aamr2191859oog.3.1708443786272;
        Tue, 20 Feb 2024 07:43:06 -0800 (PST)
Received: from localhost.localdomain ([129.41.86.2])
        by smtp.gmail.com with ESMTPSA id p3-20020a4adfc3000000b0059aaa2bebb6sm1388768ood.48.2024.02.20.07.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:43:05 -0800 (PST)
From: Andrew Geissler <geissonator@gmail.com>
To: minyard@acm.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	openipmi-developer@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Geissler <geissonator@yahoo.com>,
	openbmc@lists.ozlabs.org
Subject: [PATCH] ipmi: kcs: Update OBF poll timeout to reduce latency
Date: Tue, 20 Feb 2024 06:36:15 -0600
Message-Id: <20240220123615.963916-1-geissonator@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrew Geissler <geissonator@yahoo.com>

Commit f90bc0f97f2b ("ipmi: kcs: Poll OBF briefly to reduce OBE
latency") introduced an optimization to poll when the host has
read the output data register (ODR). Testing has shown that the 100us
timeout was not always enough. When we miss that 100us window, it
results in 10x the time to get the next message from the BMC to the
host. When you're sending 100's of messages between the BMC and Host,
this results in a server boot taking 50% longer for IBM P10 machines.

Started with 1000 and worked it down until the issue started to reoccur.
200 was the sweet spot in my testing. 150 showed the issue
intermittently.
Signed-off-by: Andrew Geissler <geissonator@yahoo.com>
---
 drivers/char/ipmi/kcs_bmc_aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index 72640da55380..af1eae6153f6 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -422,7 +422,7 @@ static void aspeed_kcs_irq_mask_update(struct kcs_bmc_device *kcs_bmc, u8 mask,
 			 * missed the event.
 			 */
 			rc = read_poll_timeout_atomic(aspeed_kcs_inb, str,
-						      !(str & KCS_BMC_STR_OBF), 1, 100, false,
+						      !(str & KCS_BMC_STR_OBF), 1, 200, false,
 						      &priv->kcs_bmc, priv->kcs_bmc.ioreg.str);
 			/* Time for the slow path? */
 			if (rc == -ETIMEDOUT)
-- 
2.39.2


