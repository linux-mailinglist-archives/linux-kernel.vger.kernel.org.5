Return-Path: <linux-kernel+bounces-167251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BADE8BA66D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C014D280D5D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6277613A275;
	Fri,  3 May 2024 04:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="A0fmQPTw"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673D813A256
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 04:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714711863; cv=none; b=ee0GMB8wl+4HEj9wYBc3G4iQNtVsTpwKoYgBgnRh6uX6MuIztx2sNTIIEBdxS57p/Xf0OpX5fpjIE8f6KmtkNzpZuiGVzmEcW8RebS27vvQJMH1bmS2FouVPSNHRAhwGQBBuR56bCLTypTKbWwAft7kgvF8PFwnAFo38vkfxvls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714711863; c=relaxed/simple;
	bh=aClvRhkni8+VngBib+tXbyLWgA3xiyhnWY6l4lDY2FI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gjbt1jXnRyWmgrOIengGMHepV38fHNQ5Z5lrF/t6SeK/+JyRPxY5khrOe71uehdPDYjYa88ZF9a2w433zt7zZ3Lj/nWVUxPyA8TbCwQB+2I2SVuwBcysSin4UnGBKqbjF4OLPPgolabWM3qj3fUIcfSrmEO4Mvly/if3LzuTwr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=A0fmQPTw; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-602801ea164so5967629a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 21:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714711862; x=1715316662; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtwC5CithaOsyDnX18EUQqmgLnixhsZn53ghod6HD4Y=;
        b=A0fmQPTwPQt+hnzMkhsdI3xnEzBKHGTojDsdY/fbRbDd7GKLkJhSHWBqC58JmIbtS7
         RYxEjHs7JmLrG37VRrm1b/w0hxO4NgxkdvtyqdvKkuw4LmHUbX87XMx/UOzQlDiJ8UAB
         d9++7nkaodKJ3aGkMIrwvaO+GQCi8RJ6xj5x7OL9NMMV7YLTraiQ1xY8J8/n6GMM1ra9
         vUeJQh1/2bOD618IwKpfDwW6o7slbkVqBRy2VIO+hPMzaq9+gE4AaYqobaPulWoPkibV
         GG9jJYc5Rm3PP9hTxeA1wMLgHs6vkmCWcsbAO32qyEagZd/s2MoxTAmtfpoo43+btKkC
         Wz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714711862; x=1715316662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtwC5CithaOsyDnX18EUQqmgLnixhsZn53ghod6HD4Y=;
        b=HosSaWHEDQkxnjxMuaQV+GFTvfgoR+YKEyRKmyHNgsX1jZWp3ULZkP7kfkxOqgdjJR
         uFjMqWs0BQDt0USUq6/J6XJmlBZx4gQA09fkmSSs8kfFbs28ER29syuGWRxGW3unKleZ
         hhN8UnJuSSGwusYH1VRsdb3gUoHfBaqUfQ1Q8TGu35zWmeqGZFdxYwrnIAUJPskIu7XU
         ZOX9wtFnAyX902X9uwPQmAcSB1QjMd91OWH9D1Dej9XHGUkQqVdXsJUfi90vqE7KMYJq
         i5sti/jeKgmxX1TAjH0zuR+0TDjqQHrRgRgrqdL8FZxsaRnCWyMJS1DeFpMwngWVX5G0
         LAoA==
X-Forwarded-Encrypted: i=1; AJvYcCWutdNhmDTCER7zZdPqapfmnb3iKQ+jJ/85gwyJy6KM+/VpJ0gdJv8U7azKzJO+KHDysxx7Nl0+BsMVKsX9G/7m3QZFUuJyKFWX4sJZ
X-Gm-Message-State: AOJu0Yz2T+j5gRtbckwSEqTgL1qfOgxN/DA19ahj+PSsie1KphFPQsnC
	T/aX4LZYRq28CsmLV5unm3qnhdD1sT0dAhp98Sp5nhCDYiXlXToO3CALAGs8ZVs=
X-Google-Smtp-Source: AGHT+IHfmJLnWNlQ+jLqowVWeSehnNZwiNPlCiwptv1oonBtcaPkYBu1VzKgOUEcLWxXtlfYGmWvRw==
X-Received: by 2002:a05:6a20:258c:b0:1a9:ffa0:d007 with SMTP id k12-20020a056a20258c00b001a9ffa0d007mr1997150pzd.58.1714711861757;
        Thu, 02 May 2024 21:51:01 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id li11-20020a170903294b00b001e3c77db2aesm2276384plb.88.2024.05.02.21.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 21:50:58 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 02 May 2024 21:50:51 -0700
Subject: [PATCH v4 2/2] riscv: cpufeature: Fix extension subset checking
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-cpufeature_fixes-v4-2-b3d1a088722d@rivosinc.com>
References: <20240502-cpufeature_fixes-v4-0-b3d1a088722d@rivosinc.com>
In-Reply-To: <20240502-cpufeature_fixes-v4-0-b3d1a088722d@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Evan Green <evan@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Andrew Jones <ajones@ventanamicro.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714711851; l=1173;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=aClvRhkni8+VngBib+tXbyLWgA3xiyhnWY6l4lDY2FI=;
 b=gwRqVJm01uxvkdlrQKBBOn3dquKs2d0HbChFUuQQkjkWjU4Pgd55dBFMK5u5tp3XbrAvXtJiV
 gG2bGvn4tcMBAHUDeEUo4MTq+EhGf2AyyVTIO2ihJ6xqFiTuHUUJ79s
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

This loop is supposed to check if ext->subset_ext_ids[j] is valid, rather
than if ext->subset_ext_ids[i] is valid, before setting the extension
id ext->subset_ext_ids[j] in isainfo->isa.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Fixes: 0d8295ed975b ("riscv: add ISA extension parsing for scalar crypto")
---
 arch/riscv/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 13d4fc0d1817..5ef48cb20ee1 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -603,7 +603,7 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 
 			if (ext->subset_ext_size) {
 				for (int j = 0; j < ext->subset_ext_size; j++) {
-					if (riscv_isa_extension_check(ext->subset_ext_ids[i]))
+					if (riscv_isa_extension_check(ext->subset_ext_ids[j]))
 						set_bit(ext->subset_ext_ids[j], isainfo->isa);
 				}
 			}

-- 
2.44.0


