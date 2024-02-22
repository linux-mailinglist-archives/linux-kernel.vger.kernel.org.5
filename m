Return-Path: <linux-kernel+bounces-75800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 739AD85EF2F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E470283D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1F2168BD;
	Thu, 22 Feb 2024 02:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gR0RANxi"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E284A11C82
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708569455; cv=none; b=R9+s03D47V+XTXZWl8bJkeSo4K+lk1JSxsJt1VNmdG9LGCtjWqNICdeNwXuFaByQSFuYLJbYVn0GFCiKWMr6o2WOi554QY4GRg3WfXNb1CJX5wbErY3EUq5Zo/LqcaZeO++ShLem6fAnsH6jeu5shHAAHwqPg0LD7/PNykXVv7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708569455; c=relaxed/simple;
	bh=1rITqxdtfq8GZoHA2/P6H5GDaO7yrOL9kVv/nHPU4TU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bQhMx6pfvYHDZQ6yoq9gd82CnzisyL2e7EKTnAoKb22/2C424r2ycs1naXtnojpyJA/X/EXvLMdTFX73fUP+jeE1M6gQziZI8q1Ih6OXEXQVj3qJIdRi0Qnzzbe4ecsF11PLzr54la6S6KY4EXJpciFpRFr/Zwc1Wt9RI5O0sJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gR0RANxi; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so5070054b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708569452; x=1709174252; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4rZpjfp6r1hYdsUdVVxlhsRsruPrHjAGS8OkhXDlaJo=;
        b=gR0RANxiSAMH8GhgZqjk0IPaopbH4+gE27G11B8YLIndROy2iDEOMGPevMxl0EyOGF
         rXKHmJ+4aMEQuW4OEPdv5Y/XAPhAsTYwJmdWXD0Km+kG8PH8Q965r1XdUgBxgSZBxqOg
         GU+2NUYFWN5h5V1gUzdmb6LUYgsKlYon6xohjSo27NNKeZMN3WrP71FmEIGh5pHI3Qq4
         PqTdpLG8B8m/gpiDAKlYYL6Qv0LX6zmz3MWHJyLDj+hKqsGXuivvdRa6xFpNOVXiUJ7Q
         v3XN2t0PmBT+faqvSAZ9+7P1ObTuF0WaBrV1sKw4B/d+cC56uZLVK1eAlRqEg3jRK3+d
         2/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708569452; x=1709174252;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4rZpjfp6r1hYdsUdVVxlhsRsruPrHjAGS8OkhXDlaJo=;
        b=iD0SYfyhgliB5DXD+fNhPzOPdxmoeD2FqG9EFz+5/uVkjiP4L0ilpDJSlBeisYxW6X
         uZNyp5KyRpcS2zMgEkP4JiSXkNfsxpwxZV3fBHsDmbGuQ+CFWKifsTyO8Oy9RTFJIvlr
         sW4g6BFBehP5DDAQdXjHabRgWwcDa9kcD6aHDXlSr0exRS5IXhjDA9GxSul2rLF4c5LW
         yrVpW2a0ybuRFAMFZUdjorNmNgKvcoPePkCLH661qpjnNtXKDVoYrJy+DrtNbP8RW8qi
         Fso2J+2m024VEu0qFTKCYqxaTuroCj9ZpOe+iKi3N1+mEzNnWCl4yet/fkeOWme3rXXV
         yB2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyaBOOCzqPFiAD4KAojAFxwn54rQGP8ds9RX5wPt544dr9h2eZSbLNAeFTuG3a1exAdfhducaZVlTD836wl3GrtRwsy4Qnk/PqPaB6
X-Gm-Message-State: AOJu0YxJVUv10UzY+MCaC/cqXASv5NbgLq90cwYELiT9nagVxom4HaNC
	S/YarA7yFe6iX7/g1Ajw+/WZpY+zPmuh9/hRiMCdsACVHKzXubMdVig5xfnirnlHKwPpL/sDgcD
	G
X-Google-Smtp-Source: AGHT+IFRIxIu+JVzwZdlJu8YZiMiwkbmpNB23grY3hNkFMpitBdh4nauHwA0Yy9NcX1k3EJVLGL8aQ==
X-Received: by 2002:a05:6808:10d2:b0:3c0:3db0:55eb with SMTP id s18-20020a05680810d200b003c03db055ebmr27441973ois.49.1708569452460;
        Wed, 21 Feb 2024 18:37:32 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id kt21-20020a056a004bb500b006e465e1573esm6469705pfb.74.2024.02.21.18.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 18:37:31 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 0/4] parisc: checksum: Use generic implementations and
 optimize checksum
Date: Wed, 21 Feb 2024 18:37:10 -0800
Message-Id: <20240221-parisc_use_generic_checksum-v1-0-ad34d895fd1b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFaz1mUC/x3MQQqAIBBA0avErBNUQqOrREhNUw2RhUMRRHdPW
 r7F/w8IJSaBpngg0cXCe8wwZQG49HEmxWM2WG0rba1RR59YMJxCYaaYYwy4EK5ybsoMgzZj5Vz
 tPeTDkWji+7+33ft+wYiWG20AAAA=
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708569451; l=932;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=1rITqxdtfq8GZoHA2/P6H5GDaO7yrOL9kVv/nHPU4TU=;
 b=aEhaNvt6gbnljBaOC6ltqWD1hPBSsAa/QvOdn/yDpB1sz2Jty7JlIhPvaCCIBkO15dugotule
 Ichm+/2hyPZCNICgIz+gG5AQcLDmmc9PZi9bZi5Lyl3zMy8Dd4XPpNt
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

After the parisc checksumming functions were created, generic versions
were written that are the same or better, making the architecture
specific ones redundant.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Charlie Jenkins (4):
      asm-generic headers: Allow csum_partial arch override
      parisc: checksum: Use generic implementations
      parisc: checksum: Remove folding from csum_partial
      parisc: checksum: Optimize from32to16

 arch/parisc/Kconfig                |  3 +++
 arch/parisc/include/asm/checksum.h | 42 ++++++++------------------------------
 arch/parisc/lib/checksum.c         | 14 ++++---------
 include/asm-generic/checksum.h     |  2 ++
 lib/checksum.c                     |  2 ++
 5 files changed, 20 insertions(+), 43 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240221-parisc_use_generic_checksum-1bb01d466877
-- 
- Charlie


