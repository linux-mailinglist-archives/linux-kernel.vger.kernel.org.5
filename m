Return-Path: <linux-kernel+bounces-75803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2BE85EF3A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC081C2255D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57C017577;
	Thu, 22 Feb 2024 02:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bDqLaH4M"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C0D17562
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708569458; cv=none; b=aebnoRNHm/MKwtQqcXrkVrd6+lOAHC5ThRHwtue40bGBSczII0dfsxG/ixNHhIannzQ60+iphClFBL3vOr8fSss/cEjpJjTAZ74Hcsg/v8GvLFXxo6Oh40XFqfCM2S6z7NEA+xAiLdc+j2ryZUVTNRgvuK1FJPcNAcuMPZlElwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708569458; c=relaxed/simple;
	bh=loWpjUeaU5B9E/ejxOfrGk83272NpESpvlB1T6y7RcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JKVudTO9EvgZ6k+wGknB8rw8thv8jBMP+RJTEW3woFk1i9Xnabzn302yuzove6qdbnqcSS6cO8cavzdBfBQCjCIEDeofqU0ATl5TlyDWDgGqwJ7hTLptkzNGzMhgqwwT7+9Yh+A5OSzqidwNKpHbsnfbD3au6/UkWPHF73YuKYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bDqLaH4M; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c1404d05bfso5399589b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708569456; x=1709174256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGrNzxe3gyC6VQWPSLHOaYx0WPaI3IQ/8Jr8tyLxsyE=;
        b=bDqLaH4Mz6HBVCQH8/bzqJM/xjCxIxcGrIh8PIEU0TYPLwt6nH79zDhos0DOTlmk/R
         sewKpdEG84CTfUkO4fqkKo+KLgPemD7mqj176D+7eicT/3SoHLmguQVgQkvNX5ol1zoE
         1W7S3IroWirVSWaPWLLTcdWP2uQMrDsflRj7BxPghmFDaR2YAXMEKZSs0qejzkCxbjGA
         SPlxggHVkvmjfUHi8n+B1W5tu/YIAmEF7fyYfycUAhwAiGUCgm2UfQa7df201Dg9OBTJ
         /MxdofkD0gNu3TRQycgc42xIeApQf4q278El0L7milqb7PMFVtXnJXTxROIBSCctm+Os
         siJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708569456; x=1709174256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGrNzxe3gyC6VQWPSLHOaYx0WPaI3IQ/8Jr8tyLxsyE=;
        b=LDbsMdPocSxwD6xvsAQuVvXWZzxYeVS5Zdvvc2g242RDPiH5dChfvNv+UhYNOmgJCI
         a/e+8INKfTnwuGKqZpgMescGpv+0rp1pe4couY/dbNQyhPX/k9kMFGnSEDdTzfAZnq69
         /sOta1CwMwxTmzFfgvoWT83NnKOeSaSU2M4qCmjFqTfwf/yiJzqZaNSm26+xOFCTaJNE
         CfdzPIZNhybqLCaGVPyZ2ejG+yHnW/HbXwYAT3IrAbzAwTekbV7DS/Ig48BAsQGKR6E4
         sE64geUVJl5JsalxdhgRMHTnDQcB/c1SL48raq9/ZC2kHzJwquwT3BBUNvTgvH+Zn//Z
         iy5w==
X-Forwarded-Encrypted: i=1; AJvYcCVML9mFzUwqT1CeRe4WsC+8JnJgsYkdL+cZCLRS11PDJ2VTPaWJq8lqxkmp/bqwGslu2ioDvvdoixqpGkYEJf7Zp7/Sl0SbWHdK+Zoe
X-Gm-Message-State: AOJu0Yz3+/O+4k/o+/ZopE1hezttOa87pCDWBdC7VpJVHe952cXSWppr
	DV1o8cqdFQ4inxFoyBWfKTOJTpGpvtSaG79VSq8QvB7bcUy9E1LrJt+bTbcrGEKeAwMSEs3k2+5
	S
X-Google-Smtp-Source: AGHT+IHr4SZnfJdYWs07MIcE+jUM6/a0JrEuqqzI8zGh/SYhR/8eR1eYgSYBAmBjDUh92jlYMvK//Q==
X-Received: by 2002:a05:6359:45a9:b0:17b:335c:fa07 with SMTP id no41-20020a05635945a900b0017b335cfa07mr13781339rwb.32.1708569455998;
        Wed, 21 Feb 2024 18:37:35 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id kt21-20020a056a004bb500b006e465e1573esm6469705pfb.74.2024.02.21.18.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 18:37:35 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 21 Feb 2024 18:37:13 -0800
Subject: [PATCH 3/4] parisc: checksum: Remove folding from csum_partial
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-parisc_use_generic_checksum-v1-3-ad34d895fd1b@rivosinc.com>
References: <20240221-parisc_use_generic_checksum-v1-0-ad34d895fd1b@rivosinc.com>
In-Reply-To: <20240221-parisc_use_generic_checksum-v1-0-ad34d895fd1b@rivosinc.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708569451; l=1119;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=loWpjUeaU5B9E/ejxOfrGk83272NpESpvlB1T6y7RcU=;
 b=xtNabUDylbAE6Wad/8orZRl3dAazwQY8qAbie+Ef8VKsiWBGicqZfawURBgIzMindz5keC/GQ
 JFElQKZrZefDR+vZaVkejbXrGuxRi9Xb6hk2IyfNMsmFd1KK3OjfEjC
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The parisc implementation of csum_partial previously folded the result
into 16 bits instead of returning all 32 bits and letting consumers like
ip_compute_csum do the folding. Since ip_compute_csum no longer depends
on this requirement, remove the folding so that the parisc
implementation operates the same as other architectures.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/parisc/lib/checksum.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/parisc/lib/checksum.c b/arch/parisc/lib/checksum.c
index 05f5ca4b2f96..eaa660491e24 100644
--- a/arch/parisc/lib/checksum.c
+++ b/arch/parisc/lib/checksum.c
@@ -95,14 +95,11 @@ unsigned int do_csum(const unsigned char *buff, int len)
 /*
  * computes a partial checksum, e.g. for TCP/UDP fragments
  */
-/*
- * why bother folding?
- */
 __wsum csum_partial(const void *buff, int len, __wsum sum)
 {
 	unsigned int result = do_csum(buff, len);
 	addc(result, sum);
-	return (__force __wsum)from32to16(result);
+	return (__force __wsum)result;
 }
 
 EXPORT_SYMBOL(csum_partial);

-- 
2.34.1


