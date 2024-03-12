Return-Path: <linux-kernel+bounces-100941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD415879FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8835DB211F3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A04A4D59F;
	Tue, 12 Mar 2024 23:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1woHkUG0"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D29B481AB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 23:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710287626; cv=none; b=AOqve+bwVOSojQBBYgXwvXPl4KR2ZlodyiJcup958eDvNTtrSAjOM/epIM2noCi05xrHbfaW3fSlsqThTxoRIsCoZO0B02CK1p2MaK9CLdBuD+uILIp8B3zS3TAvs30/39qPUXQoxCaIQkux0Of+CaDkTL6aCdBjWtR5IqP/+Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710287626; c=relaxed/simple;
	bh=kzrpE3Jf/ixYwB6jIjCMuZiuZ4uucOwZGOq0f8reVWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zqom0VgqhFGVIS5a9pJL7535PRwjytAWwZ20/aOZrX5ZU+BhYEALEgrAXjuYYgGYnTexc6Ox8e15jD96KRX1RaB6rIoXH1gFBtZDNuu3haOus+/8hUcecY88s5F4jQMwevlIB/we4BK7/AktjGV29PyzfqIvGkeQ/qZVvyQS7xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1woHkUG0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dd878da011so21002005ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710287624; x=1710892424; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXYFACIdPWJdwy+Yl+k20SzAykOCyOjeDPUfEzEnCdk=;
        b=1woHkUG05Nkc8dc4j9FeFIJHST02NbSttNuLuttqP4qO3X/NJLSTJtovGkpj3Pjzn+
         O4AHzrLLCsz+fyllf9iM+YRY/Up9hg635QnH37t6Yg5yPZPCRYEl5oJfiBCvs2p5I212
         Lwc8Dx/cIpd6/i0o3VXVPe3kbVhFSg+kfoUFzWPN45xYGI1wQY7Z8cqtFmamECDAW2jO
         BBoMYlmX/er4vze+/p2K3lriFQrpPHxQ/037BXCx28aqrEP9FwFxRXV35OIIoBKFcC0M
         hlYIu7oY3hm6iwgxUkvOCotKvLyuoQIZK5nWjLsHLzmOLIXfq1XQs/3j5M/cYNA2OviO
         7skA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710287624; x=1710892424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXYFACIdPWJdwy+Yl+k20SzAykOCyOjeDPUfEzEnCdk=;
        b=SKZO6+qc2zhK8QIkZ+4NFz7MRXQBaAY3DYji5jELsLFVQnPAlGgQ12an274SYUu26b
         V02WAPOZVkGp3qNcbz/jf5IkgbIA/dkNTfnaK1bF2AFa4p43onurQAmZ+H6zHccBWwAA
         Bc+bzJRde/yVHnRIiOE7+V3I/IAcLTO9MBiiwOeRhWtgeDH/r3IDk7KbratsmRWb+bNa
         tzUA5z/d6NWwOx58UmaD9tYS/353g6ZH9Bj2ZnetaIcPf2gUXBuZsjkdeMKLkEEm3GHq
         PZ0Z7Hh0oZVhmZV5bxHjjtVHEl3j7/zXQgQWumY7wJ/fdBwB98cqNIi9zCFQeVuWnKRT
         2XwA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ1Y2s8hnoof+pu0WxSB6dnTTpaMIe3h3v6MRcFmxjrQ999Qm/dyn9SfhbmC13SkGDTAQWKjdyiRQnEts80bs84+UTRnFsA2rLJ116
X-Gm-Message-State: AOJu0YwZPisMqY6c97OXHbsSdnnT9wGv0PmhzRjgZ7GFaIkKOXwwVcOf
	2UurMsidYWXAwByyBLcZaXGhvmtqD+LD+DCNHUs+uGoG889wH74OHHf7AQkPHhE8aoLbIswD8X6
	q
X-Google-Smtp-Source: AGHT+IH0SfMIDZtbDgW+D7kbou1UQHEhchAClAhNSOZvw6/dDwtvlbI2nHGNgmwsKXGf11eS2MPl9w==
X-Received: by 2002:a17:902:cec2:b0:1dd:6174:c646 with SMTP id d2-20020a170902cec200b001dd6174c646mr3163048plg.8.1710287624279;
        Tue, 12 Mar 2024 16:53:44 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b001dcad9cbf8bsm7282844plw.239.2024.03.12.16.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 16:53:43 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 12 Mar 2024 16:53:40 -0700
Subject: [PATCH v13 1/4] riscv: Remove unnecessary irqflags processor.h
 include
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240312-fencei-v13-1-4b6bdc2bbf32@rivosinc.com>
References: <20240312-fencei-v13-0-4b6bdc2bbf32@rivosinc.com>
In-Reply-To: <20240312-fencei-v13-0-4b6bdc2bbf32@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710287621; l=659;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=kzrpE3Jf/ixYwB6jIjCMuZiuZ4uucOwZGOq0f8reVWQ=;
 b=JdUmv9KuobgRo10PoWynjhbDzqMEbIcDakiliqU/bWiH/yeoVaClcS5c6gI0xUpubRXXVWRFH
 vfEzAOtdC8OBOMPEPNikt9gJbUM6yqYKdtTdzPyRLqTmxVZE5W122JX
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

This include is not used and can lead to circular dependencies.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
---
 arch/riscv/include/asm/irqflags.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
index 08d4d6a5b7e9..6fd8cbfcfcc7 100644
--- a/arch/riscv/include/asm/irqflags.h
+++ b/arch/riscv/include/asm/irqflags.h
@@ -7,7 +7,6 @@
 #ifndef _ASM_RISCV_IRQFLAGS_H
 #define _ASM_RISCV_IRQFLAGS_H
 
-#include <asm/processor.h>
 #include <asm/csr.h>
 
 /* read interrupt enabled status */

-- 
2.43.2


