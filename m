Return-Path: <linux-kernel+bounces-42774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FE0840687
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF9A287D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEA163414;
	Mon, 29 Jan 2024 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgaFvKX3"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552596280D;
	Mon, 29 Jan 2024 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534256; cv=none; b=ePpd1QAP8dVSvNXfYn6P944lwPML3OpwxWilYEg9J96NP5lpy7EjjKQashNSLX6m/3FPhC1fjcDuqDfa++FzMgnm/o2m0yyXdtmYB4TzV5C26j0CyIobKIysxxQu7j6aAw3X+HFlyU7Baa5VKGJ6oQSiMvV9fUZgcqnP+/zQAaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534256; c=relaxed/simple;
	bh=6QTPt33T5rQKL/6Gt/bIWU0jYiWt8sqi5iCPonlXgec=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tqFDqnfr9HxRWFQMsSbvwcr5F3X0BcdoGWs8DrW386y+rVOMxg/A8bXiwaYJ38jbf2hm/6m7XypAKegYrW78mX9YaCAwAhjOVwydhu8xdRA3wQK0FmhODYB3eJze0M24Px1+W85Ln9w3OncdoIN8IMCd+KIchf1gUxg2V4SHlHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgaFvKX3; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a349ed467d9so286164666b.1;
        Mon, 29 Jan 2024 05:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706534252; x=1707139052; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMwNqcZZgOVXT/J1FjC+xI4RABs1qjk7vHn8GPhDdCA=;
        b=PgaFvKX3hLtNIRwS3CD1g+ugBX57+JA3YHbRQ9n6tneYEWhJ3uoU6T4hzxhG/qtp0h
         Ct64xKsJrffFcJyMxcDuXe++aYwxmYeZkwg6bm+9OmXBR8jwM3everq/e2LnCx13r87m
         Z6mxBBBtWWl7Gs+a12ilJ9M522NinOaDo5i2FfgjW0/ZNB6yj6UWy/RaA/42By1tmrKB
         F9oHvCyLYwUO5usWCD2kaWYsd3GQXOmUpsHnKwy7ZMa2bPIFiewRCQ/3/2AAbZnhDFv4
         HsvTK1GiyGaw7ZnhvYHmpt7GfEVNdDgSKCgJcmmKVrXmSRAGE+VM33DjyLnMcO5XHwFy
         uoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706534252; x=1707139052;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMwNqcZZgOVXT/J1FjC+xI4RABs1qjk7vHn8GPhDdCA=;
        b=RRYpqnIjGEtw2KISnxaoPCV2y34gE+oGG+jNHDGieuIfMbq3iMq3v5AlOSDlTJ6i12
         hh64Eh/lmXBFlFDrp8T8dTyNbMnjgqj3Lbtp/mn7zEqfq4EvgzdCSQfxLI6gJQ6gC4gk
         +j8iNPbcwNihVAWeIydVeca8Ee3ntZj9+BMEjWlQeDKC3dcq+mHZAn+RubNKIaIDvrnO
         eYLc5Q5Sf2fzKdGUFQQCZxPywabZug6NS6+K1g1IW7WsKIYzIl1XRacx2/4LR3Una13r
         LmyMo5uXoQEJVLOZ8r8IkSgvK06SWAKkgkOEFeucpDrKalTelsub5DGW1ZAEyORxdDJS
         zQVw==
X-Gm-Message-State: AOJu0Yw4SnnPm32ru6DB+TRfh5Exje0re0294+BGmHdF+USzCAQysQqI
	qMCU8H8tyLuvK6cDMqlyEB13g0vI4f5/9yEeczlZzJLFiX0KNDOB
X-Google-Smtp-Source: AGHT+IF56lsLVSwWT0MpkDQTXGgYqHeVKKkqZNQrGyXnP0BOY5XivLNVLZnraDMCsPBFwK/blGmZfg==
X-Received: by 2002:a17:906:2e94:b0:a35:fdf9:e6fc with SMTP id o20-20020a1709062e9400b00a35fdf9e6fcmr55005eji.18.1706534252237;
        Mon, 29 Jan 2024 05:17:32 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:fddc:9ce:9e0f:3ad3])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090622cf00b00a359afad88dsm1590449eja.10.2024.01.29.05.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:17:31 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Danny Tsen <dtsen@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust file entries after crypto vmx file movement
Date: Mon, 29 Jan 2024 14:17:29 +0100
Message-Id: <20240129131729.4311-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 109303336a0c ("crypto: vmx - Move to arch/powerpc/crypto") moves the
crypto vmx files to arch/powerpc, but misses to adjust the file entries for
IBM Power VMX Cryptographic instructions and LINUX FOR POWERPC.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
broken references.

Adjust these file entries accordingly.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Danny, please ack.
Herbert, please pick this minor clean-up patch on your -next tree.

 MAINTAINERS | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb944964be5..15bc79e80e28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10307,12 +10307,12 @@ M:	Nayna Jain <nayna@linux.ibm.com>
 M:	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
 L:	linux-crypto@vger.kernel.org
 S:	Supported
-F:	drivers/crypto/vmx/Kconfig
-F:	drivers/crypto/vmx/Makefile
-F:	drivers/crypto/vmx/aes*
-F:	drivers/crypto/vmx/ghash*
-F:	drivers/crypto/vmx/ppc-xlate.pl
-F:	drivers/crypto/vmx/vmx.c
+F:	arch/powerpc/crypto/Kconfig
+F:	arch/powerpc/crypto/Makefile
+F:	arch/powerpc/crypto/aes*
+F:	arch/powerpc/crypto/ghash*
+F:	arch/powerpc/crypto/ppc-xlate.pl
+F:	arch/powerpc/crypto/vmx.c
 
 IBM ServeRAID RAID DRIVER
 S:	Orphan
@@ -12397,7 +12397,6 @@ F:	drivers/*/*/*pasemi*
 F:	drivers/*/*pasemi*
 F:	drivers/char/tpm/tpm_ibmvtpm*
 F:	drivers/crypto/nx/
-F:	drivers/crypto/vmx/
 F:	drivers/i2c/busses/i2c-opal.c
 F:	drivers/net/ethernet/ibm/ibmveth.*
 F:	drivers/net/ethernet/ibm/ibmvnic.*
-- 
2.17.1


