Return-Path: <linux-kernel+bounces-37952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EDF83B8B8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F48F28666E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752A012E45;
	Thu, 25 Jan 2024 04:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pxyEnNVo"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF39712B9A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706157470; cv=none; b=pxEiFGxOW/X1ZhK3qFq352mVfZKAgR+XE+W9L4nlZ2sfcYOaC60W11emuJ7RvssPOJJ3xyyb/3Fws9f5TkPdFKSaSAeXEhoMxqR6BjVnXG8aVAPBws/m9hZyyptoE8F41b6OSLO9AcT2TsoR7fHWn1felNIXyOXAVk8LVueFJMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706157470; c=relaxed/simple;
	bh=UN/F+XVB/Cp9Tieq9zjlpx7ClwW716UrfXAszysaL8M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U74jFRzT9LuXj2nXx7DD6yzNS2JDSbHM/sptaQsJcBGrxZLIQ1MGIw9LTNeueCJNd4r1mmnB8KQwbdkT3p8Hcjz+ZzNm395AgVhdXLf+Atq8ugNrDLjS+HuRNlJ5PtrZb3if6skyGcJAOmRnMeZrjILkDEuHRixJybG23x8pA0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pxyEnNVo; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bb53e20a43so4405682b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 20:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706157468; x=1706762268; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XcoyNR3kETNGPPUq1jr14FKqvGXhNZvoHJA6sIwz/Uk=;
        b=pxyEnNVorcRsuSuwHKTyjbh2NmyeyALD8vQPHHuqR378vzH4oD6WgXLA0e9Mv2lZ6R
         kSaAaCJUmk/BO6TA9QHOKjJTb2A9jDPFy4FmADf0GgnqiV4eOvIeMqISa2PsZldgIEhi
         twTiL79KjS+uFPz2rOatK3jNVPluF8eqBavjO9ekZIBQSubxjThe4TixCw0ZNRpWv0oo
         q3mB9TFYljvHRJU5LwpPJzjG3TB25CHZwE5H+5VZ+g0VeGe1O7wbvSfAGbAeGMEZA/mL
         NwGI+LB2jirLqMplrf64/gul+XpV43Y+eNCdLyqjtoV6RE9Y+99zyKg+A+DRD7eJ1IOS
         I2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706157468; x=1706762268;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XcoyNR3kETNGPPUq1jr14FKqvGXhNZvoHJA6sIwz/Uk=;
        b=VyTnbkk0tgcPQiKUgyEKMQvA7CbMsdqaKeyPQbPLKsAXnx5JT5s1bolEAqQYTZg6pu
         A3CVvDzN2x96jLUzV5mfNqjj5DqmWvlTKV/9LIKA5kohQIYoXvoEyhbFbHPrC2PaHPe1
         CgHIcKPbnYgt9N9yD4dPpTMOBeivkEkV+ST5QtVG3jH1WhRjaUNKWzp7cnYCNRm4iZYH
         OQhMnKlmIbdYP5oeyV6lctfE7eqq4vCmNLw07wPZGVDx9mn9oEkMBlY3jXGuuWqXFgLE
         7tbz+uvXKkSFJJIJNgf2GsqUqYknjwt31I9VLoRJqznROwxOEJTQfwk+8qt7luFCLGwR
         x0+w==
X-Gm-Message-State: AOJu0YwHA1jHMkDpVPxtDJv/piBOyZURT4P0koVAywia2vLT5cuc5AOM
	3JLrGq242nWS//X8FrUiPA3/F4N2a3Luon6dgB+nVc70GuUUsD0KE5YRCsjB/Rs=
X-Google-Smtp-Source: AGHT+IHMIkXnlpGzThml0daT6Sdsx27w8GvXcIXszVTp5Z4mV4movoKDzl9uF5mJo+JMTRndog0kpA==
X-Received: by 2002:a05:6808:3c96:b0:3bd:a9f5:f5d4 with SMTP id gs22-20020a0568083c9600b003bda9f5f5d4mr551061oib.70.1706157467965;
        Wed, 24 Jan 2024 20:37:47 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id n2-20020a056a000d4200b006ddce8e110bsm355185pfv.128.2024.01.24.20.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 20:37:47 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v4 0/2] lib: checksum: Fix issues with checksum tests
Date: Wed, 24 Jan 2024 20:37:23 -0800
Message-Id: <20240124-fix_sparse_errors_checksum_tests-v4-0-bc2b8d23a35c@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIPlsWUC/5XNTQrCMBCG4atI1kaaH9PWlfcQCW0ytUFsykwNS
 undja5EXOjyG5jnnRkBBiC2W80MIQUKcchDr1fM9c1wAh583kwWUhdC1LwLN0tjgwQWECOSdT2
 4M10vdgKaiEvTVqZV2peVZpkZEfLPK3E45t0HmiLeX8Ukntc/8CS44NIr31XGVzmxx5AihcFtX
 Lywp5/kmynVD6bkBW9VYVrjoPTN9oup/jVVNqED58qu1rIuP8xlWR4i4V/2ewEAAA==
To: Guenter Roeck <linux@roeck-us.net>, 
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706157467; l=1153;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=UN/F+XVB/Cp9Tieq9zjlpx7ClwW716UrfXAszysaL8M=;
 b=+yq58rzT8R6QUQP8cyrj+P5zkzPgTfRgTfFW4jY3TwtPHtHHPXc+G/zVnR2PPgjeVY4w+B8zc
 RZmgJyT3ajPDF7961FN6Ppzc0ZelicJ7F+ZXuTPiZ55ngzJxTTrf1wI
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The ip_fast_csum and csum_ipv6_magic tests did not have the data
types properly casted, and improperly misaligned data.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
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


