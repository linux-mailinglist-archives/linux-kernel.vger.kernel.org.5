Return-Path: <linux-kernel+bounces-167242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A75E48BA651
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9261B229F3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07C313C3E8;
	Fri,  3 May 2024 04:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dxDDEAek"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C727813BC10
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714711629; cv=none; b=nlY2nrsO5Bul5GqQo1r7EVRhP0lCzoq5qPzuP412AY6d6EyFVTZm5vC6jLEGnrY7igRqtNqJzIDkbaIjw1KAqNQ4iX79Ww1lxMyKBP9eWZXxSYrAu9kDYw3L2dgEFFnV5tL2RRzYcgy3mECHE/sUBsYfFeoSE/vnmTavOiROcZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714711629; c=relaxed/simple;
	bh=hSZDQKNr3tkZT93AWiF+tJx7RzaJfBNyv2pzte748aU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qCgw0hE5P6+f4eFiGhpUznid+/osYH/vSU8Zr6xC4jDjb8qf86N/Y1zkl65ONu52PIazv8DYW5I2LGlZIlz/etM3TNunKWAgI8T6Tp5n0LpKS7baUtPeaoEYyFphoE+Uka4PIzJHgl2jMbUWkFCXSXAwKQuHCu5eVVhIilQc1gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dxDDEAek; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e83a2a4f2cso58924745ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 21:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714711627; x=1715316427; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2nk2JCBk+l9WgkXKFxu/w/itsXmN0i69JJANxOESAA=;
        b=dxDDEAektpJAi68fOu7OGfcJgr5pzgWUdrLc0v/0da2JvGNVFRjJZICqwetDDqztt6
         7B82HASj2knJsUDS4xs7IgOrq2/yMPRHnbmt5HtxjgFAJ8kJ/9dC507VZcC/JvoNNF/I
         C/qidGNo99Wi2tcbXYbI4b6mIURU3WiN2Q8XJ4TJvwIeZVr3CqKjbEWZ+l8emreRNIIR
         HZALnd0z+rMkvBH7mjr1IAFxLdrg3ocCSCVHjwThdkdDEom3XGSq2AuAvcE6lrigAN50
         Hv6DF5pv5Im1SOTEWkrMHCJnOK3yG6UZiIx1FZtzQTx5XW6myrpWbzCCuhTwCX68pafb
         05mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714711627; x=1715316427;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2nk2JCBk+l9WgkXKFxu/w/itsXmN0i69JJANxOESAA=;
        b=D0NXmDqzo1DAoOFCZsHQVuQaoO+VTkLBESv20paSv6ZlEHg7XCn7BEiM5dMuzqe2dL
         +zKOf72mFkmbmbJ63Qz6Il/vPl1CIwXEaWN83PGv6v8H/8V3tE4YWy1TpuQKv8SQFla1
         BY6ysCXhVzVAffgQ2qBIZeFMhLhQSd40/qOVqVoP2Pd4saH/6kYVp31RnsBPSTrShGHQ
         xn1qRaBZqWJct5/6iq4I9YonRmVZWlhp3xmvmKQ751T7UV7Zw9VDNFMndANKNM2Kpdxb
         N5OccKagX8SW8UwRaWcKVGYrQZIYDJDjl5pF0nu4BrGhkf35c6EZhdFWdzwCkN2e1+hG
         CXfg==
X-Forwarded-Encrypted: i=1; AJvYcCU+2pgekSX40NRjq9YkBs7LL7LqGpmu3ojs+XrPc+dU0guvj/1dGFlEoCwI4O3p4c8JB17DHZ+LN5RJPqhCRH3mvGjRzcFzGkxn8YFa
X-Gm-Message-State: AOJu0YzdXh0B0RrRdyIgkBVz9VDsf9dzwKtQ5nLnjDK0Z3I7T9srYSID
	HbcMsZLZe9EgT17jcsywg3bTn90GZ8CZ/C9KDVDFiODfDp+0aW6O9H9+AWxyAkI=
X-Google-Smtp-Source: AGHT+IGLvfuIAlBMYBUVi+TLiO4QdvrYlPkTzw3LbvYys310NrxKX5klWbfcjGlfYftnOqjktyh3bg==
X-Received: by 2002:a17:903:191:b0:1eb:73c2:6b4a with SMTP id z17-20020a170903019100b001eb73c26b4amr1926925plg.8.1714711627297;
        Thu, 02 May 2024 21:47:07 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b001e2bb03893dsm2240411plh.198.2024.05.02.21.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 21:47:06 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 02 May 2024 21:46:46 -0700
Subject: [PATCH v5 11/17] riscv: csr: Add CSR encodings for
 VCSR_VXRM/VCSR_VXSAT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-dev-charlie-support_thead_vector_6_9-v5-11-d1b5c013a966@rivosinc.com>
References: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
In-Reply-To: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714711602; l=706;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=hSZDQKNr3tkZT93AWiF+tJx7RzaJfBNyv2pzte748aU=;
 b=UFZlFM3RPKRvEq4iil4sCALt5muWs8uugdi45/DJmZsHXC3Ny7LZMEMUZMpO4ymqs1OLTreJo
 XGaQ1FIh62qCFEPNP6HOy8o4Nghcqt7bK10HySuu2pzzpqXLVPmjp7o
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The VXRM vector csr for xtheadvector has an encoding of 0xa and VXSAT
has an encoding of 0x9.

Co-developed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 13bc99c995d1..e5a35efd56e0 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -219,6 +219,8 @@
 #define VCSR_VXRM_MASK			3
 #define VCSR_VXRM_SHIFT			1
 #define VCSR_VXSAT_MASK			1
+#define VCSR_VXSAT			0x9
+#define VCSR_VXRM			0xa
 
 /* symbolic CSR names: */
 #define CSR_CYCLE		0xc00

-- 
2.44.0


