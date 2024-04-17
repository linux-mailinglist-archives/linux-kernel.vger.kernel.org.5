Return-Path: <linux-kernel+bounces-149331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1C98A8FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A529283937
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDC081748;
	Wed, 17 Apr 2024 23:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="iGb1lJap"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDE0481BB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713397793; cv=none; b=ubB9hY/UF7zXLC7LeDQlkHstAf4UVgVe5lRvUVBWQ9VW3RxDWgKgQIkFXyWToPsQsaaqLA1TkYBuM2Md5aw72Z1IBGNcuT/PIO+2WjwvsNrwIHhHOnHDZX/TjR3HBBDdkpmCrOhzwmSiamC06y+TDmOC0zXv7er7VFzGZKKUSSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713397793; c=relaxed/simple;
	bh=QOeEbZPIOXSFim7lsiz0WmrK/rdPihErm3BmndcXrBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YGr59On+SfwTADxiozmyHLKgjcRAdBWXJg/GfShTDOiasFg9GHdocNKrzwbku75T1yJfJb5P8wjIh+g9MNXzVpa+Gaf1ecnFklvhr1pq/wDqJoZQ6dixjbdA3/M+pdOaR+hSVf607rd1n2ZKNWlN/KAdsLu0m635NjgsAs/hj8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=iGb1lJap; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so365927b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713397791; x=1714002591; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l6QPcqewJGS3JFKwt5jL99ECNB022Q5NjXUoC/gxxD4=;
        b=iGb1lJapRHMiif7NmUJyRG3p2ISOsYT4GV83iRyWbOLbL+pgdsaoisFAc8WbpDTZ/1
         rqueXvg2O5xa4hmNJssiImNIMIqLRnUFx5dN5mkfRJOXU13Rzy0kXdMgiWFnsXnLZBMY
         Wi4KbukX6q3OBDOC5M3zcQ1tk3BFmEfVMdGB8Oxt5037FPcCnFkXdtAcaSiAQj7oJ3ei
         kPdxrmJYX5QRdaNIKR2gEOZEo4EB+zAxAYIa088RsHbexUqSNzVoLFG1zxfWJMBqYBI7
         CPjbbNeHqFPBOUeRIFZOOvjToMIk9ZvjH1cyU8HQf44Udysd7+ymIWJULzczSxAatqEq
         RzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713397791; x=1714002591;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l6QPcqewJGS3JFKwt5jL99ECNB022Q5NjXUoC/gxxD4=;
        b=OGXnokLvDVV9trtfWSYGk6wjIDiRi2JFRMxL3IZeRpOuuWgbynEL8Rhv/eQuJwEBwM
         udRFmlbvI0fDSQdytTmLRjOcGjrM/b5z/s92zPecJu1LjACpQVE+6EhHsmTNNSOMcu8x
         mivgOUFZb+42Y6LqAaboxzh5Op68VeYnV+0w/jKdpqa8IBZdwriz/W03PwLrNXP9LyRV
         h65MbLNr7ZeUge/DgIakGQFVTDMxV52pA3si4d8CEPVD3b5uesVPzm4FCk8SQpkiJuSH
         uIlscOVCCjNAV1PfH2Tx6zMzzE/OIuJnNVlISVKkjHwsVAUGZnqPFMct3YhAzpAkynSF
         jmMw==
X-Forwarded-Encrypted: i=1; AJvYcCXDf1nMSPYH9nx7g+w+XNTgok+RwIp9zmLrNzQkeGhx5zRjpPDQbr/WwOhUsfGbCOOpLew3YxIEBzHVpsC6UlHUV1D49yj1ftZ5Gtl6
X-Gm-Message-State: AOJu0YzudV/4ZgAbFNt5O02eDG22Uc/8FVh8bUQH5addZtE9JHJVe2A3
	H1QcQqo/gHLX1S4m9g+hFqA0foXcg6colFHHo1ywoVlrZX1X5iYMO3uN4lpnhkU=
X-Google-Smtp-Source: AGHT+IG4XjDqRECtKlDqradeGR//Cr8LDn9qG9X89yeLCIO+tM0IDNTJkjO4vUl8sBNG3QOo/yqRbw==
X-Received: by 2002:a05:6a00:b8f:b0:6ed:416d:f7c with SMTP id g15-20020a056a000b8f00b006ed416d0f7cmr1479557pfj.6.1713397790689;
        Wed, 17 Apr 2024 16:49:50 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id g21-20020a63e615000000b005f75f325db4sm180626pgh.29.2024.04.17.16.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 16:49:50 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 17 Apr 2024 16:49:48 -0700
Subject: [PATCH riscv/for-next] riscv: cacheflush: Fix warning when
 compiled without CONFIG_SMP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-fix_nosmp_icache-v1-1-921a3c07d4ce@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIABxgIGYC/x2MwQqDMBAFf0X23GC02kJ/pRSJ64vuoYnsFhHEf
 zf0ODAzBxlUYPSqDlJsYpJTgeZWES8hzXAyFabWt53vmqeLsg8p23cdhAMvcD7y/REQ4oieSrY
 qivNfvknFeKtjVpew/+hznhcIWRdpcgAAAA==
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Atish Patra <atishp@rivosinc.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713397789; l=1366;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=QOeEbZPIOXSFim7lsiz0WmrK/rdPihErm3BmndcXrBk=;
 b=MD96CDgWAywUmAiDDGjPnD1xMLhEG+ivBh9UezqhJGdfkpsEq6o7FnPPrw3xBGmVDL6+VzUzS
 ld/hGTyVCvTDoy9EAOBkddn8mzifBpZxFpe4aLic1QyFonX9klAMgYv
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

GCC tries to compile the static function set_icache_stale_mask() even
when there are no callers. Guard the function with #ifdef CONFIG_SMP.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: 383289e4b071 ("riscv: Include riscv_set_icache_flush_ctx prctl")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404180621.qG7A9Tk0-lkp@intel.com/
---
Since this is just in for-next Palmer do you want to squash this onto the
commit that introduced this 383289e4b071?
---
 arch/riscv/mm/cacheflush.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 3b03534e57b4..3ef666c7dfc7 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -154,6 +154,7 @@ void __init riscv_init_cbo_blocksizes(void)
 		riscv_cboz_block_size = cboz_block_size;
 }
 
+#ifdef CONFIG_SMP
 static void set_icache_stale_mask(void)
 {
 	cpumask_t *mask;
@@ -171,6 +172,7 @@ static void set_icache_stale_mask(void)
 	cpumask_setall(mask);
 	cpumask_assign_cpu(smp_processor_id(), mask, stale_cpu);
 }
+#endif
 
 /**
  * riscv_set_icache_flush_ctx() - Enable/disable icache flushing instructions in

---
base-commit: a76716f0ec75b9e7ac62d30854d690044c857684
change-id: 20240417-fix_nosmp_icache-0fc36aeafbe5
-- 
- Charlie


