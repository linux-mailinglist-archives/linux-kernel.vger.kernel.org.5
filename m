Return-Path: <linux-kernel+bounces-96760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D19A6876113
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51C9DB23273
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A43537E2;
	Fri,  8 Mar 2024 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuKF9ESH"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802962D05F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890852; cv=none; b=IGt3JLOb1DmVAZLXXJBfcxMuUvK24mtAQ1qVDHIvIOfTpPpc1wmnB9XV/2d4nObW/X3EVOh8mzz839waPdV6tcCqyVNFGdf39QKfTIB9YO4KYS580K5LeKWf4K8v0win+Z6wItVZVOFnQpac8Jl83OaODv9mcyDXEG9zpq9JpgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890852; c=relaxed/simple;
	bh=CM9/0PUYg/pcfPOkiw4ARx2BYspG8GIKoboQzPF3shk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JmHvKdPa8KqODzAGTRAQek3MSvnSI47hl+PkJFKn7+I4DvVccqyPcXWk0SExsgS7ePUhkrr3AhNOgJGv/pqjPO2yviehHpyXdtXHzTyheLOMPFGAUG/ozHl8A+tOFK9lNWhj6dyA+snXxzlsOJvpwksN6gBQqz4u7ZfVI4MCjdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuKF9ESH; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c1f5e14bdbso681201b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 01:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709890849; x=1710495649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1YGEtckg+/ZCVmrYriqUU7Dxf5OvuIpS6SnP93Azw8=;
        b=HuKF9ESHNbBJ9JMwaPVO61cshc9oIVev6a9ESsAwvE/jCeKmlE7CbN3Zl0xthhtKMT
         NKGYOX8Z3CdFupckWLjUYDqAg0S+NcFlQahLg39xcpIjuHWu3Ym3KWg3POv+VRr+UFB5
         pAnx7Sk9acZUI7TY9pUIXv4U5Jk6FEJ0ucH/W8Wh0/VofXbjFrDozn/D55VYzioU1Kww
         LdSez7ITYGOKqEBxcoTvVONhmZgWMdsf4sFHPTStsg5/G3XMXtzUI4G23n+BdXRWjvWa
         WGyd6UsxZNFWljP6lvCScjBZZxb2Fi8cgTADUx8zAYaDjVYOhOF4MDUPb16wPRHmn3iq
         yzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709890849; x=1710495649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1YGEtckg+/ZCVmrYriqUU7Dxf5OvuIpS6SnP93Azw8=;
        b=FR53Qa9JqzYU3HD1S4NosQvb35S//XmLIB+qh41QHoEZnpiasIu7SlRxeYUqgttD1c
         1wIigE3A1GW/j8TZXSiWIcaQaGIoCGXPiE9uRetgTjAqM9a7b34gvvGCjHQ4q0HoJia7
         otyasI3YExO68Bv7ATf/NCD9HF3p72cB8iv7RaXHRbNexS2rYWGdsJHgyIgppNanNwVC
         Co9XyxSSBZsXsoFFc734oit/DDMZ0EHfb8BoNxXpktAIQYtLv9h1q8Pmldg7Azd6YV32
         SJV848YtU7u4UOCMduyH7f+nIblhiLjA7m2H3jXw5X4L2nVbaj/gtgFAB8f9QOEwBmc1
         Igbw==
X-Gm-Message-State: AOJu0YzGUkrxgRXepGKO29KmPj5EuROD5VxTJi28zOx8PNsjHHPt8kqW
	fAR2jzfA9jvJcvAGfxQ8Z/UWmPWjxoUc4xedaHkB27RiMZpVjzia9ZbDMoov
X-Google-Smtp-Source: AGHT+IEWZGsRHoZW64R3bqSd0DJHvVHWTJk2if7Q+BGP/LwlsO5JTi4f6uS82U9N+pPKXIhqBzGtjQ==
X-Received: by 2002:a05:6808:48f:b0:3c2:2f44:539a with SMTP id z15-20020a056808048f00b003c22f44539amr1839754oid.50.1709890849034;
        Fri, 08 Mar 2024 01:40:49 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id ei30-20020a056a0080de00b006e5359e621csm13788300pfb.182.2024.03.08.01.40.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2024 01:40:48 -0800 (PST)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 3/4] workqueue: Move attrs->cpumask out of worker_pool's properties when attrs->affn_strict
Date: Fri,  8 Mar 2024 17:42:52 +0800
Message-Id: <20240308094253.2104-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240308094253.2104-1-jiangshanlai@gmail.com>
References: <20240308094253.2104-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Allow more pools can be shared when attrs->affn_strict.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 include/linux/workqueue.h |  3 +++
 kernel/workqueue.c        | 13 ++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index c885a5f6bb93..86f723579a32 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -180,6 +180,9 @@ struct workqueue_attrs {
 	 * Below fields aren't properties of a worker_pool. They only modify how
 	 * :c:func:`apply_workqueue_attrs` select pools and thus don't
 	 * participate in pool hash calculations or equality comparisons.
+	 *
+	 * If @affn_strict is set, @cpumask isn't a property of a worker_pool
+	 * either.
 	 */
 
 	/**
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3ff91243322d..3bb71cfd3e06 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4517,6 +4517,8 @@ static void wqattrs_clear_for_pool(struct workqueue_attrs *attrs)
 {
 	attrs->affn_scope = WQ_AFFN_NR_TYPES;
 	attrs->ordered = false;
+	if (attrs->affn_strict)
+		cpumask_copy(attrs->cpumask, cpu_possible_mask);
 }
 
 /* hash value of the content of @attr */
@@ -4525,11 +4527,12 @@ static u32 wqattrs_hash(const struct workqueue_attrs *attrs)
 	u32 hash = 0;
 
 	hash = jhash_1word(attrs->nice, hash);
-	hash = jhash(cpumask_bits(attrs->cpumask),
-		     BITS_TO_LONGS(nr_cpumask_bits) * sizeof(long), hash);
+	hash = jhash_1word(attrs->affn_strict, hash);
 	hash = jhash(cpumask_bits(attrs->__pod_cpumask),
 		     BITS_TO_LONGS(nr_cpumask_bits) * sizeof(long), hash);
-	hash = jhash_1word(attrs->affn_strict, hash);
+	if (!attrs->affn_strict)
+		hash = jhash(cpumask_bits(attrs->cpumask),
+			     BITS_TO_LONGS(nr_cpumask_bits) * sizeof(long), hash);
 	return hash;
 }
 
@@ -4539,11 +4542,11 @@ static bool wqattrs_equal(const struct workqueue_attrs *a,
 {
 	if (a->nice != b->nice)
 		return false;
-	if (!cpumask_equal(a->cpumask, b->cpumask))
+	if (a->affn_strict != b->affn_strict)
 		return false;
 	if (!cpumask_equal(a->__pod_cpumask, b->__pod_cpumask))
 		return false;
-	if (a->affn_strict != b->affn_strict)
+	if (!a->affn_strict && !cpumask_equal(a->cpumask, b->cpumask))
 		return false;
 	return true;
 }
-- 
2.19.1.6.gb485710b


