Return-Path: <linux-kernel+bounces-62304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8BC851E53
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59160B2323E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C0C4B5AE;
	Mon, 12 Feb 2024 20:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Mu+f6XZq"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359C3482E9
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768274; cv=none; b=s0hGTQdSn6H5u1503hwc43BwjIlkY4wVFIXSX+T7Ym9hIw7Q0pzAFmixUUfXng+gJyOl+gG0/mB0O3+vepXmH6K0gPF3xQK1MunHvIYWfIYUYN6A+mVeDTvuGAlNT47h/7lXz2Y6EurlBZ6rH3EtzpyKI6ltVAI1rJDHlV4SQ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768274; c=relaxed/simple;
	bh=wq2ksQ7riCsovFQtWGfWa+BPPUeBF8MZW1gziCVsNGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WxClXWuMnSskh0FL3jKaMmcO+A4ZydxGsHA2219ChfD6YiTf5JLbnUK7z33hU0cxTefX5M1RdgOk4fG57Gk6MfEPgO/rK38MgZcOnG/miT71sN/dRjmHGMFLnUVpyM32akHSDEd9OhOhELcwHWsm6X61klfHSfW6ICb6d5Y1k3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Mu+f6XZq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e0f5934813so186926b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707768272; x=1708373072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uM4Z12hpk6ywnXmg4o7JBjzuS2oolDAHFENYm+t/mgg=;
        b=n/F2OLAtH9CuqkSxHNDSFxdtHbz77yRhsNL0pHAwKNyFndUyBaGLxSqrSfX2a9L5G+
         34wbUJc2mRgbusUfEe/JNwSpgdZA8c6GIO9vJkU5dLKJJ9+ljM9/Y0dOGWgJjPugcYHM
         at3a1BvvWFRgPebHNQJcljHALv963TflS6ptKpgC/cQ5uxCpiuiL1mVgpLfRkMAZHHEq
         kkRE4xTSh+P2RDlqUYSbGWioyomoFJGLh2v5sc253SQtQGSdhdJPrNVAaUnVzfJ8j//R
         CkhrNxRnLxKll/ECjyZPNDdGiQKdxgJHA+EgWGMRtG8xSJhnoeSlFWxOrH0rxlz+nTUK
         SQ+g==
X-Forwarded-Encrypted: i=1; AJvYcCWzmOs03FzmISv4VboKQhEMdo97fK8ahImxwt/Y39qVLzisd2/nQ2DEsFW+pJXvXKJxW5o0Gd+PVtRJj0/eDtvjt5QUsQbfftNg9I7g
X-Gm-Message-State: AOJu0Yye36UJzI6dLGmAaQmcvw9CgaogMKOCPOV9V0/TfjNH/H10P2VI
	U6xzZL4RljxXJELgwQtDhCB2fsGcYoVYbbWmtxJlPFQfeEWOdb26
X-Google-Smtp-Source: AGHT+IHL2h7SDPA5vafi17KQNTfyVJG0IrVNXwwe9ZTwnAEz1/KhI2log19GhTkvjBRjJVI4CsvEJA==
X-Received: by 2002:a62:ee03:0:b0:6e0:9968:87e1 with SMTP id e3-20020a62ee03000000b006e0996887e1mr7194757pfi.20.1707768272484;
        Mon, 12 Feb 2024 12:04:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVinwUqKSkKJYv+R/n7EffgHxiGUzgM35n6oa1VEuy9ZvuyKBWxjlADigt3y3pzhUJqrNRwXgWnCX0dNI71O+S/wor5D1PlIOn6NoZiFHVyNjxFeLEpgW9LH5COqxddNWR0H8XxBDAiFU55yQ46GA5D6LmGp/qqcc9OxriEqbgymJUetyIaZhvI7HVDlG7+iTqZPJpSJOs6iHjnDD5oWMnXerLJ+bp7uB8Sdw+7NPb7YPyc7BjCc7LlQS84RrefPx0z+4V9AiXZ53aYDWOj
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id m15-20020a62f20f000000b006d9b35b2602sm5811979pfh.3.2024.02.12.12.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 12:04:32 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707768271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uM4Z12hpk6ywnXmg4o7JBjzuS2oolDAHFENYm+t/mgg=;
	b=Mu+f6XZqXzB5rLbeydHSZDUmtAFIJg2dn9KaXSgbCpUMbMBnYriFsCK75v1YeEyHp4m5se
	+tH7WC6PT8LPYeH6LREYA2pQ25PpYGu5IW6FelQEstIZDi5Xa0zebeZ5JWRYUnscuQtX+M
	SLkN8jZENSKRqJwzmD3xdZv7y/iWOUo4hP0jsTA+DxFrzfhtDJ0wVi5Qb4d+TjqQAb83tu
	cyk6YtcC8kssV+3STawo1Jb8DHGqJOt7NquuobFaThTvWfJcG9pgG167lldNYdFtskOyBe
	rZD0Zt0lyvK+9aiu3CKSzws2ZkPyzl0u/xlXXCwW9QIp3So1MoTgbjYssjdwmw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 12 Feb 2024 17:05:00 -0300
Subject: [PATCH v2 2/5] powerpc: vio: make vio_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-bus_cleanup-powerpc2-v2-2-8441b3f77827@marliere.net>
References: <20240212-bus_cleanup-powerpc2-v2-0-8441b3f77827@marliere.net>
In-Reply-To: <20240212-bus_cleanup-powerpc2-v2-0-8441b3f77827@marliere.net>
To: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1757; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=wq2ksQ7riCsovFQtWGfWa+BPPUeBF8MZW1gziCVsNGU=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlynnu5I52P5SuFmly4enraO0oN3OCpnat1fA57
 nImlIfWOsWJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcp57gAKCRDJC4p8Y4ZY
 plOOEACKsrsOIpmokRU6VXNzK5ezwmSY1tKdNJU9PusraupJcKE2n+zNbTsO7P5miK+XDIoxMgp
 gAKt4L7OYDC1SLDWnwrvjBh3KT87u7myz6lDXxktjBDIVvW8nn5NGWLZLuZ1qGwJ9LAWoDFjHoo
 8b6Io7uvYUtxXe/ySxu0RSFrt+EYRbg04RtFr8SVICTdjxIuzCioMfRtkNLR7N3QySEB2HIyPtc
 kSKqp5cl1g8IMkHarHcoXAhBYjCk6aPwEE3kfPUl3gcs8v7DUV3rWH7dGdcq+VuwXrClS7tLItU
 617tRgXwDdLnyahFel6MpI2ox8xCWlqsvcluCBVoTpzF+sTkZfrQ1/4Ek+Cve77dEnrEHK5JS2C
 NYY9i7EwVZRRIByV+fUbiKJnUZv09JWMGLEEpu3KQiWOZAqX2EJsjt0KMK5MiOY5RE+sszSSzci
 jyXHCXTU9kiOs6IJW1ajSp/su1epRKrroB78gNK7PLQjL0HdH9eWz4W5UmtevA8K2fxFk478PSU
 nKiJkGFws5DkY9GM3cF6QTfSwG9cG8RGm9h0TSnRRKVZd0/aZFEwnfwuoAzLawtEOL+cegctqMP
 7Phk4cJcihQhz1rIbkojDNncrIFvqVV0Vqo5sSjfDSpbOd/hyzNANnrMcsFNYxS0WjDM37UoPsF
 iBzsz4gniZJWHRQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the vio_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/powerpc/include/asm/vio.h       | 2 +-
 arch/powerpc/platforms/pseries/vio.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/vio.h b/arch/powerpc/include/asm/vio.h
index cc9b787627ad..6faf2a931755 100644
--- a/arch/powerpc/include/asm/vio.h
+++ b/arch/powerpc/include/asm/vio.h
@@ -39,7 +39,7 @@
  */
 #define VIO_CMO_MIN_ENT 1562624
 
-extern struct bus_type vio_bus_type;
+extern const struct bus_type vio_bus_type;
 
 struct iommu_table;
 
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 6c58824190a2..90ff85c879bf 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -1615,7 +1615,7 @@ static struct attribute *vio_cmo_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(vio_cmo_dev);
 
-struct bus_type vio_bus_type = {
+const struct bus_type vio_bus_type = {
 	.name = "vio",
 	.dev_groups = vio_cmo_dev_groups,
 	.bus_groups = vio_bus_groups,
@@ -1634,7 +1634,7 @@ static struct attribute *vio_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(vio_dev);
 
-struct bus_type vio_bus_type = {
+const struct bus_type vio_bus_type = {
 	.name = "vio",
 	.dev_groups = vio_dev_groups,
 	.uevent = vio_hotplug,

-- 
2.43.0


