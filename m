Return-Path: <linux-kernel+bounces-156282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCAE8B00C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED2FB22AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3B615445E;
	Wed, 24 Apr 2024 05:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tkRHMfXa"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36F214387C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713934957; cv=none; b=knKYmFR7f9MvXwSFnYLUHwjnWc5MxnvjPjeKcmqSZVMBW2j0R75WaD1Dp01le7CEhh7lT1Lzl+umDVsox4px8TM81o/cHNJcWJZt1IVedlTjNV5q8uVRD6DgpkksiBbjzg3GCuEi7RXRoznI3JdkIA0hNGE7GV/d/PZT87dCiu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713934957; c=relaxed/simple;
	bh=x37nCAEtkzKmnw2FIwieCR2ee+0AhiENTRGgvvQ3L5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LDZXpzi/4TXP+xW6W8CRsMA2C4scTtaMbrX9eLsBE4k7cI0F4OPqZGAfLzAz+7HD4p5DVNweFCsL7iz9TMqqkw+ZXCaSS/dsR7cntZ6bAr9JHOnW5UUsuvOt+rTXJOftw1iShce+6Yg9BJ4jNurOnk2RQEFR+b6rSP5pCFfI08M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tkRHMfXa; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ECB953FE4D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713934947;
	bh=5qlSwbqn0yKjajOnnokLTupGDAbqF62Q3ztb6vzSw9g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=tkRHMfXaYWOXt1er9T+rgsJXe04Q8TNg1adx5kR72Tv1d97IcMV+td4Nme4oyztPg
	 yW+LJ6JlvDuzZQlzCy1H2oJZQI9XAWT7GyddudfPv3eSqXWkYBW4nG1mqk5l9L5f6w
	 uJM3VPk71WCpMOPbL13Qm6/HNtbvAIo67c0NU4ufbffF3uddKg8+O3vLwQIg9+IPre
	 SwYmtAIhu+gc2vroiDgI56Tlf3aeuz/lFs3abF3WomVOcd68O6aoWQrwFhJ/yqkD1o
	 sC0pIZdPKBp0riRAqZgkiravS4FrxPwwXaHVP6zOvJdz13OE6Dre+e3gnx7lGNDgl+
	 QxVKtOUMSd6zQ==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1e422d89ec9so75660195ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 22:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713934945; x=1714539745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qlSwbqn0yKjajOnnokLTupGDAbqF62Q3ztb6vzSw9g=;
        b=dQsVY+N0PYhtx2FRR8Ah9cFWjm+Hqv4QEwLhPxrqlPdU2+BehRv75nIzid14KX66w8
         etD/2xahTxvLOdWeHd+OQrTQsqf2gf73r/j/iP5RMa69CO40fgfwUt8luBYnzGWDXB2G
         vtmMveQz7AOGdYPFzmgdAmWK63LA6NfCkSR/yuQ6UEezZ2MfYjawGoJ3I/evh20P0DSd
         9y69M2UFvr38/O/Q0mX+TMeUm7p2FLPxU1xC28q3Umk4xOebJcNr7nw1zS+iX0p8jKdF
         xBOwj3oleVzzzQZ1OHpyvM8ZxfL3VAeIOWYrb5eejMnpffyawQyX3I4lIYIYlJTcG3/e
         Swbg==
X-Forwarded-Encrypted: i=1; AJvYcCU6mrLHZWRUHMGhwiQGjXT14dBSC4RreMdjMQhStSiHMIj449aOP8KAA5Y0HBbpBsG6EdcqCR5hjoJz4dL9HDR1v2bg7Q2BT4JT9uW5
X-Gm-Message-State: AOJu0YzFxupPUrQP8ArWCRGp2RKpMMyAO1k0MPXCr7oEUQr8hRpfGLf2
	N3C/32mtdX36Ol3/uCy2KiIdLyw3SAPfAhjNuruB91g6wZVJ52dwhUSyPAW0GyIbBUdlKGTbGpB
	qqpR7ATs6+rWE2DXf9SJ12irX/4w9pUygZMXS5NOoCZQLYQ9GZAXfLAOP9d0OKuM/SWjFlzBXfO
	6e3g==
X-Received: by 2002:a17:902:d50e:b0:1e4:3ed8:e264 with SMTP id b14-20020a170902d50e00b001e43ed8e264mr1931941plg.43.1713934945435;
        Tue, 23 Apr 2024 22:02:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfx/iKCRsXuYaLjisAIOV8TYBxO7/bFDwJ1MD1LgF/g+Q24fJgz+P7l0mtak8JWPQHZ4SQhw==
X-Received: by 2002:a17:902:d50e:b0:1e4:3ed8:e264 with SMTP id b14-20020a170902d50e00b001e43ed8e264mr1931921plg.43.1713934945079;
        Tue, 23 Apr 2024 22:02:25 -0700 (PDT)
Received: from localhost ([159.196.41.205])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001e4d22f828fsm10727496plb.33.2024.04.23.22.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 22:02:24 -0700 (PDT)
From: Portia Stephens <portia.stephens@canonical.com>
To: mmayer@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	rafael@kernel.org
Cc: viresh.kumar@linaro.org,
	florian.fainelli@broadcom.com,
	abelova@astralinux.ru,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stephensportia@gmail.com
Subject: [PATCH] cpufreq: brcmstb-avs-cpufreq: ISO C90 forbids mixed declarations
Date: Wed, 24 Apr 2024 15:02:20 +1000
Message-Id: <20240424050220.889814-1-portia.stephens@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a compile warning because a NULL pointer check was added before
a struct was declared. This moves the NULL pointer check to after the
struct is delcared and moves the struct assignment to after the NULL
pointer check.

Fixes: f661017e6d32 ("cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return value")

Signed-off-by: Portia Stephens <portia.stephens@canonical.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 1a1857b0a6f4..ea8438550b49 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -481,9 +481,12 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
 static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct private_data *priv;
+
 	if (!policy)
 		return 0;
-	struct private_data *priv = policy->driver_data;
+
+	priv = policy->driver_data;
 
 	cpufreq_cpu_put(policy);
 
-- 
2.34.1


