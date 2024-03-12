Return-Path: <linux-kernel+bounces-100723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F3C879C62
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5421C21B85
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEA9142657;
	Tue, 12 Mar 2024 19:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XBlu3+39"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA7C142634
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710272877; cv=none; b=Vbl+D0hnT4q2YJvp8iZmvBuk0LsD4yYB3mcspTSyejnUiTxc7VP+YCT7h72krUXBnYHRzYaQDLyxtav1CIllzgCnFLKeyij9Y3lnvI6lup/Crfn21awsQrv39nbj5SDPzbRzjsZkItNhxBNMKKuap2XFaIdo7IHysn/yryYHFvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710272877; c=relaxed/simple;
	bh=U1yCIqRq0duvpJX2nz5FFSagYRqS2vPnAY5Af8ygvZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qILXuyRVbuCPBS4+cNSzKwW1DbjmsHvblECXPw7zhjQx4D9vpFaKr6TQLfoFUSZBoDLLe1t5UXRGL779yGxX3RtwOifg2zF4tlvc2tl0KswLtnVYofX5eAKBS1wPOmRswc3N9EpbaUK83kiopPO8wKfqIbGeQAheFNFLT95ePSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XBlu3+39; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a19de33898so221161eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710272874; x=1710877674; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOqRUTnz4dMY1mDsAaQqT8RlSz6vNVMJhwSPPEU0/Tk=;
        b=XBlu3+39DS35WQKvpj1l1k9QknOGZUQRwfMYYFXgJjjnGdIw4UioCcFjGfq3RtOHfw
         SMOd1B165Xxq10WCu/lLNqp0o1jv8eqcOcTuLx3Ze/u5b6epq1OrjR3Ax4h+JkDWM8Ub
         mA329ajlsEElbTBwabifjORjGbMA/5ypYwgLRBxmWQr8T4AUM6FPDZuyLT7xtNzojfbD
         duJtDz/hxl9RfVONEw1+Vv3Tlw01yf+fUOswsSgw+TCVQwaSUbaLpNqBDE75wr5SGF5y
         GNVy4drxIgFOEDF4ZzzXN38PGJKjnhw9npIjvxJKtmpv9AHIerw23wKJP51J+DteflAJ
         TrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710272874; x=1710877674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOqRUTnz4dMY1mDsAaQqT8RlSz6vNVMJhwSPPEU0/Tk=;
        b=KmPMUVE4hg2OcHaF/3XLETwqobnePKfnlLR4BBaVKEsrm+fzfXq93IrtqEmAuxJgBP
         nwIHewub837vZ2XNsHkQKzagtlWIiZvWekrxxqAfbUo9g7udjb33IbGjlS0ylAlRLBpg
         toYM7LIpEaur9VHGeTApqyh8VUj2ZZMaLwFoKX4rDpbm3OYrLb0ETClc3agqOZMcY1W1
         Af79oW/qa+ikQKhQ4EoBzEHXMJBDKYbz2jhWrywspyrlXW6ZS/Iz/L94FilaKqv2ZBo8
         h2YjL4CEZEnus66IA30rzHpoEpWWW9r+zNFq1wxy1sGYHccgoUaGFA/I7Zrw/rwPdQr2
         7aww==
X-Forwarded-Encrypted: i=1; AJvYcCXLDTurNX2Us7dQCzGcX3wkbqbnXZOWHqSa0PeAs34JraRRb+hMDHOpHxMpJRystffWMUZVGYz6fVMwqLnR0AwxJpNsD04nft7HwCgG
X-Gm-Message-State: AOJu0YwqEHn8OgPCt66ZcpkfAZv/RQzaQYJ/pA/fIn255fTtUimZVRWp
	/n7WwmEB2TdF1qyu9AL2r57Zyni8jpr0xVltt8CS48nt74NwlLI1ytwCcInOCXg=
X-Google-Smtp-Source: AGHT+IGI3bdfpp+X8J+ZAKrqf6mS+YBT6i2j3SsCGQcUF6D9lLzGReHwzZfu7T6A9BAy8M6S+dJeAg==
X-Received: by 2002:a05:6358:3228:b0:17e:6924:e4ef with SMTP id a40-20020a056358322800b0017e6924e4efmr4693399rwe.24.1710272874205;
        Tue, 12 Mar 2024 12:47:54 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id z69-20020a633348000000b005dc884e9f5bsm6433495pgz.38.2024.03.12.12.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 12:47:53 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 12 Mar 2024 12:47:51 -0700
Subject: [PATCH v12 1/4] riscv: Remove unnecessary irqflags processor.h
 include
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240312-fencei-v12-1-0f340f004ce7@rivosinc.com>
References: <20240312-fencei-v12-0-0f340f004ce7@rivosinc.com>
In-Reply-To: <20240312-fencei-v12-0-0f340f004ce7@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710272871; l=696;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=U1yCIqRq0duvpJX2nz5FFSagYRqS2vPnAY5Af8ygvZo=;
 b=B4BSJn3Ds/uhAQxDonyv5DKERy7Fsrbt2TvkM0fPKhogZvT+pJ7QmCDUxVLS6ckX7qedOXG0u
 KalC8LH+1ZCD46M/5bI5dIEnZ3XJ5XlRQEEBBBsLpauEY6z5ACcZhlV
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

This include is not used. Remove it to avoid a circular dependency in
the next patch in the series.

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


