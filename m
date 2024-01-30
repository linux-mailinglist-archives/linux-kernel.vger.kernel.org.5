Return-Path: <linux-kernel+bounces-45170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFA1842C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB79AB22767
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CDF7AE49;
	Tue, 30 Jan 2024 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NAabapWD"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF906995A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641845; cv=none; b=bPGPQH+lA+HA58EKDzIxJ7M97CG4R6HigxnKi5YwZ6tRbncPo7KCcevBI6Elk2GRfq/aZMI8O9pWoC2eCpvNWfXJKuXTGzBgV4+jK0JtnvBDm5qtcGtdBOwd2eSnIikahFW91jorlKrS++3hWiFUZaiepOqFlJMW4DdRF3KWt0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641845; c=relaxed/simple;
	bh=eBVjOwBzBXz+wIjzt1q65tjnnhsG8BpMMZrg4Z57nN8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bu5mJOmerFhlmHqrXn+OmoOJZVx6vOADBpUC1NMsJjymsjR/kMWSprs/0g5KNFKgTai+51m6Gc8Ou6Vb4ELINQgkVGzSPW8cUS6Z5oHJOJ/lobXYCqFVcyYkeC+lzwtK/8JG4tjTo0G4E5UqmVY9QiCiovZE25ejnkyBx/mXIHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NAabapWD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d8cea8bb3bso13653625ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706641843; x=1707246643; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ih6aJQpYeudm4DH7GXDOkPsJAqGPh0tA+fMPoGsmAE=;
        b=NAabapWDUOV40bv+6ZwqKfkgcp2rzUkefapK8A8r4GnPPi7tCfMJ4rsjkM21a9aiBP
         6a46PvDrgFknr1KEufEs1lk4YTnSaNOBSJXWXUwc1IuoPQVGnYrPdAy2HiTmP+35mhER
         ZWSd7zR1cJyfLPVb/h26BLDhk3GZUoHsG6r1Dwxm47z49an7e+bQS9YMaG2i1w0PEXJK
         8RJ+1tedqD4WoXpV6CPlMCe7BbQyr01QADTQg0+qfcwsDb2UvZlroUidhEc6ur9L4NXW
         Z0CVKrh0GV+fzPckYqQld4ADyu2p7p4Ou40Xf4TCh2KRc5zjxdH8w2pw6Uuu/BqOVZin
         7qLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706641843; x=1707246643;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Ih6aJQpYeudm4DH7GXDOkPsJAqGPh0tA+fMPoGsmAE=;
        b=H0KwT0sPYNBuVPjJll8GQgPB2/HSvn/jKFv6cWtf8AQs9deQ9rVLm4Av2rqz7RsBA2
         u4oyuxIr1r/C/A8qA4m4ApN8QxgQlGnqqQHVvWDOqsvWVbldc6UG2maOrX7OxJU6evAr
         yiCQ5KOVyASxH5jc3nVVCIAyoL3FMla0FizEWzmK+Y2aWXofANBIA2O7Y2s2Lc8WIgw0
         1F3OIgYiVJBwYkQimTRKNsvKBnXRttxYIDihXre5khyzMkKc/sk44uywQWBFQKCVA7BF
         B0YHi11Xaer65a9omRCVmVRpQ1i+y4iQfR9b6m6AFx2XD5hj8ysec9KLN/WkoK6CGQ+8
         z9Hg==
X-Gm-Message-State: AOJu0YygIxTx5OG7e9lsfPf893uB18IS6cLL63gFgFtCclNZMXpTpV7Q
	cGDekfFMR+k3h0fQZ/HLsr2aGZ/cMZNcagvq/Xw5EXnW2Ra0bVE/Tvdorz4lOFc=
X-Google-Smtp-Source: AGHT+IFuOQ56M0BP8wcdrL0TKmyCJCLk2a3wcsCv//tTV80wCtl5ogSqVeOVepqLf89//Be6TCXAGA==
X-Received: by 2002:a17:902:f689:b0:1d8:f7d2:a3ec with SMTP id l9-20020a170902f68900b001d8f7d2a3ecmr399698plg.61.1706641843104;
        Tue, 30 Jan 2024 11:10:43 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902ebd000b001d91d515dffsm605340plg.156.2024.01.30.11.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:10:42 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v5 0/2] lib: checksum: Fix issues with checksum tests
Date: Tue, 30 Jan 2024 11:10:02 -0800
Message-Id: <20240130-fix_sparse_errors_checksum_tests-v5-0-4d8a0a337e5e@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIpJuWUC/5XOQWrDMBAF0KsEratijWRZzqr3KMVYo3EtSqygc
 UVL8N0rZxVKFsnyf5j35yKYciQWx8NFZCqRY1pqaF8OAudx+SQZQ80CGjCNUr2c4s/A5zEzDZR
 zyjzgTPjF36dhJV5ZgvXOem1C54yozDlTvblOvH/UPEdeU/69Lha1t0/gRUklIegwORtcnXjLs
 SSOC75iOondL3Bjgn7ABNlIrxvrLVIXxvaOqZ81dTVpIsRu6g303R3T3JrmAdPsfyJ4F0CPusV
 /5rZtf7gqhQ/PAQAA
To: Guenter Roeck <linux@roeck-us.net>, 
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706641842; l=1332;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=eBVjOwBzBXz+wIjzt1q65tjnnhsG8BpMMZrg4Z57nN8=;
 b=7sF2F1mP4h7BoqiMwL28dR/S3hgryYSg+PKK6R9aomtq9SivpE91yVhID2gujBmc4jLiPiEIl
 YuEQKAxdEgzCSSz4JXwndteXr6YgurhPhiSJeM98NUfehlN86tmUzRv
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The ip_fast_csum and csum_ipv6_magic tests did not have the data
types properly casted, and improperly misaligned data.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v5:
- Add Guenter's tested-by
- CC Andrew Morton
- Link to v4: https://lore.kernel.org/r/20240124-fix_sparse_errors_checksum_tests-v4-0-bc2b8d23a35c@rivosinc.com

Changes in v4:
- Pad test values with zeroes (David)
- Link to v3: https://lore.kernel.org/r/20240123-fix_sparse_errors_checksum_tests-v3-0-efecc7f94297@rivosinc.com

Changes in v3:
- Don't read memory out of bounds
- Link to v2: https://lore.kernel.org/r/20240123-fix_sparse_errors_checksum_tests-v2-0-b306b6ce7da5@rivosinc.com

Changes in v2:
- Add additional patch to fix alignment issues
- Link to v1: https://lore.kernel.org/r/20240119-fix_sparse_errors_checksum_tests-v1-1-2d3df86d8d78@rivosinc.com

---
Charlie Jenkins (2):
      lib: checksum: Fix type casting in checksum kunits
      lib: checksum: Use aligned accesses for ip_fast_csum and csum_ipv6_magic tests

 lib/checksum_kunit.c | 389 +++++++++++++++++----------------------------------
 1 file changed, 129 insertions(+), 260 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240119-fix_sparse_errors_checksum_tests-26b86b34d784
-- 
- Charlie


