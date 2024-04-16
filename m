Return-Path: <linux-kernel+bounces-147322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720E78A7280
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8123B21571
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28CF1350EF;
	Tue, 16 Apr 2024 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqqqZymI"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3BC134411;
	Tue, 16 Apr 2024 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713289040; cv=none; b=JTo+4DXZFf8YJ2VCuToct64rFQbE30icjxg2Pab4X4+GrvBDHaSZzQs7PHlgtIdC4+gtVq7mPglTnn5+9/hvNV0PyuO/HXTrT9TQCsDY0NGSj/5J5vmnTcAKrDBb0F4za6UD5i7scl1T48bF5r1LMe8Anu5vJIrTfFBpTdPicvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713289040; c=relaxed/simple;
	bh=kCXkydWYRKWeR7tI1rDndpU6YNBEBtTWlczdEFMI3iw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HuyMIw9FBqOIYq3fkotCQ/UpfFpeXItVDLKNVGSDW5VhfcRjcmzIXOgL+l//Nzk5wqB2o1BaT8OdmwYd29AuPsZJE5PFRNyTYAwUsrzhQ6HI/zVeErGZw0MrBX2nmlExwydPJKnndvTa0rhmXQsQ+OjUVQS78RwrBvQqhA8UsoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqqqZymI; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-61acfd3fd3fso27009777b3.1;
        Tue, 16 Apr 2024 10:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713289038; x=1713893838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEJ4Kzu1ZMQKDN5Ea8M9owwXpw6cPm4vJBsPoRrcQW0=;
        b=fqqqZymIyO69r/+uAwkMTu2Zg0s0bPITU5/UNsKK1l/h/7zQrgE9CvMKEp/f8hM4aw
         1qzDFedajjPK2CJdH+VdeUNy1m7SgXdKNQwBmPYUfsE/19uDpbLTF8HZal4LL0+h23B+
         jy4FCTjyjMdJSXm5lech0UFmqxG4EnHKv+rMRVSDiHgiGdS2EvmfsovbrEnF/KdlkECK
         wCfh5s9/1JP0rdHgU0Wznsbf2wJWIfYNi/5+6tzB+NXf55hNMEYxxc7xqamWGUlZnyDx
         BUZjUMpkXl4x8i0k90QADI/g1reaOJ1MkYr/P3UtEjXyIa6LIfl9T04nAoAP0+9coke2
         MGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713289038; x=1713893838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEJ4Kzu1ZMQKDN5Ea8M9owwXpw6cPm4vJBsPoRrcQW0=;
        b=kVOPpN3d4CjUYH0Lpde8XGFlH+Apy2JaVrIlGkMOdA9rCqrJAg9ZNB1YXMCljroGoV
         fWUwfUZRi0MF5VLVJ6+0BIdmhBcGA8jp3Hd7n6FiqQBwHNLDWGUxLIf/Upc9zlh0H47R
         n1KY4oI1EAxVtphvOHcNPSWYHea1sdgzPWfeUsXQS6+Bcz1WWNG/p6b7xHUPRf1XRWtp
         0RVLPDnc8aSqRUMfwNj2cMfxiF4rcGzVHJXlOFdjuCUeskxC++UgNnYeg6oScRe1Ehzb
         VxLaS8XfHwa91KggC5ZhC82s17zEUjArIFyzP5lhi6vQwJJuT48d4izbD6cBcXZd3y5v
         IY+w==
X-Forwarded-Encrypted: i=1; AJvYcCU1sSzWbdzx0m46l1dYdCh4vXBo7Ds3qo2tkOxhXierydObq/FkRNePaZSu2cEpudHv0cI/rUfF5fDwnYKbR81Ec+vTUDEnRdS7YhPE/hmaPf+zBqWMv5rkNC2CWvpBI8yxlVM69jdiMw==
X-Gm-Message-State: AOJu0YxJG9hinlbiFhFDzmLshJleouOsPhP3ej28lDb5qwS5rtRcWzaA
	X9HXM/UAmFiGA+os23a/z9bR+PXp5jPwP+efcYN3FujvPcOXF1kvEdFDQw==
X-Google-Smtp-Source: AGHT+IG7MGMWwZqNEMCRBfFRsR92czsXN34/Nje9Ozynleb2QnQrYFzNBnsetytngtZGkiAhzVn2mA==
X-Received: by 2002:a81:a00f:0:b0:61a:cf94:97b2 with SMTP id x15-20020a81a00f000000b0061acf9497b2mr7153482ywg.8.1713289037837;
        Tue, 16 Apr 2024 10:37:17 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:2767:ac3e:3052:cd0])
        by smtp.gmail.com with ESMTPSA id m124-20020a817182000000b00611213d62adsm2582820ywc.124.2024.04.16.10.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 10:37:17 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 2/2] MIPS: SGI-IP27: use WARN_ON() output
Date: Tue, 16 Apr 2024 10:37:11 -0700
Message-Id: <20240416173711.613750-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240416173711.613750-1-yury.norov@gmail.com>
References: <20240416173711.613750-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WARN_ON() propagates the result of conditional expression, and it can be
used to return early in the following expression in the arch_init_irq().

This is a no-op cleanup, except that compiler may optimize the error paths
better because WARN_ON() implies 'unlikely()'.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/mips/sgi-ip27/ip27-irq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index d8acdf0439d2..00e63e9ef61d 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -289,13 +289,12 @@ void __init arch_init_irq(void)
 	bitmap_set(hub_irq_map, NI_BRDCAST_ERR_A, MSC_PANIC_INTR - NI_BRDCAST_ERR_A + 1);
 
 	fn = irq_domain_alloc_named_fwnode("HUB");
-	WARN_ON(fn == NULL);
-	if (!fn)
+	if (WARN_ON(fn == NULL))
 		return;
+
 	domain = irq_domain_create_linear(fn, IP27_HUB_IRQ_COUNT,
 					  &hub_domain_ops, NULL);
-	WARN_ON(domain == NULL);
-	if (!domain)
+	if (WARN_ON(domain == NULL))
 		return;
 
 	irq_set_default_host(domain);
-- 
2.40.1


