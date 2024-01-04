Return-Path: <linux-kernel+bounces-17176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9302F824933
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6C728654F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871652C6A8;
	Thu,  4 Jan 2024 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xKjShSnM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EBF2C1BF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3606aa2c7a4so2085265ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704397375; x=1705002175; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zZ4NebEk/v8RtkZO7csT64Y6aHb7A5Z83OOo99KtSl4=;
        b=xKjShSnMqxwoYwFGdazY+zZ3gjWaDbFvOKTDsCiF2DmQaYr4rQzOoZVqw8naJdnARe
         pl3bEpMF+Dbcs8jJX811r2T5fCpuNDGlWV0sBPhRD/cTu13+6nwp8swT+MsjRzLYIAmJ
         CixIpGEu5/ERZ1ldqOWu69ZD07LiaK5/RLhfpMsOLMrX4ExPS3/pCeNCBWp5LZ6AczwN
         e6WjPhFVzSsN36IzKaOF+bUse7bFgxjlWTkYsXKcAHYTM6WthrZc+BQ8Al25MKFN2tOO
         qxDGCgzZoXzCqYXx6QhxWCZIrHDwesR/RQ4fxVQbdkx5hUc18/Z3iytiRX2qOkCk0xG4
         doMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704397375; x=1705002175;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZ4NebEk/v8RtkZO7csT64Y6aHb7A5Z83OOo99KtSl4=;
        b=mpJKXPk89LqnO7ogTsyP5d+ty6yIrUfImVr8iPDI9yP11sudN1m6E1fFLP0R8pObD2
         PNqXVt6SSN7V81sE5dbJHSpyP3sO6a0eiEEeWJhkjjMBiH0PbqB4+1DXww0w+I6y/dx5
         dj2V4u4PjNiuLn2FMLCSz0sworaa7P49/5hAiMLVz6c5gw35idGfUARzpyDB/4YavAX8
         +VqE/669crFOB3W6a4wO3s/T7dH5Ek0VTRL/BGz4lWui8bVQpf1w5c8qYFivIyVH64V5
         Y5iThz28NG036oVa0mc4KsTl435izQZ8dVdDtGBNGlHySbEDMpXrbfIwUdXSbvr7dnph
         liPQ==
X-Gm-Message-State: AOJu0Yw8i+PRIz87vfFyadTHtOs8w6UveaG6Fl/a4caLSG1lcGAEBnhx
	A0zjK2C6jd7236XYD0v3GTh1mU3rkrAYzg==
X-Google-Smtp-Source: AGHT+IHsElya+8s71eEn1wxhXEYSAasDbnd+VBq9vmycNipi4gm/93N0ihC5hlaYRI+LIQoFk7OxiQ==
X-Received: by 2002:a05:6e02:19c9:b0:35f:e71f:4c60 with SMTP id r9-20020a056e0219c900b0035fe71f4c60mr1114054ill.13.1704397375175;
        Thu, 04 Jan 2024 11:42:55 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o10-20020a92daca000000b0035d0da89a0asm19606ilq.6.2024.01.04.11.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 11:42:54 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v3 0/3] riscv: modules: Fix module loading error handling
Date: Thu, 04 Jan 2024 11:42:46 -0800
Message-Id: <20240104-module_loading_fix-v3-0-a71f8de6ce0f@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADcKl2UC/33NTQrCMBCG4atI1kaS6Y/GlfcQKWkytgNtIokGp
 fTupgU3Ii7fD+aZiUUMhJEdNxMLmCiSdzmK7YaZXrsOOdncDAQUEmTBR28fAzaD15Zc11zpyQt
 taluiPkhQLB/eAuZ5Rc+X3D3Fuw+v9UeSy/qXS5JLbrVq90aBtlidAiUfyZmd8SNbxAQfpRRS/
 FaACw4KWlmLqgKjvpR5nt9RWVTg/QAAAA==
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>, 
 Julia Lawall <julia.lawall@inria.fr>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704397374; l=1029;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=6NGr/DoKC3/yzJo7z44jpZYiAVYTGaXxLfBI12gIXoY=;
 b=4RPWQTDdkNAFI4p28vauTpKQftHTQB59nLae7uu4QHL1PR/S3LNN1lSC8AXI9pvl+rvxuasHi
 M9GLKbADcLKCXc1VW8mARqzk+s+jdiIP5Fk0HhmFkG5mpku3yh9YCqw
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

When modules are loaded while there is not ample allocatable memory,
there was previously not proper error handling. This series fixes a
use-after-free error and a different issue that caused a non graceful
exit after memory was not properly allocated.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v3:
- Drop patch using do-while
- Link to v2: https://lore.kernel.org/r/20240103-module_loading_fix-v2-0-292b160552c9@rivosinc.com

Changes in v2:
- Split changes across multiple patches
- Link to v1: https://lore.kernel.org/r/20231213-module_loading_fix-v1-1-da9b7c92ade5@rivosinc.com

---
Charlie Jenkins (3):
      riscv: Fix module loading free order
      riscv: Correctly free relocation hashtable on error
      riscv: Fix relocation_hashtable size

 arch/riscv/kernel/module.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)
---
base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
change-id: 20231213-module_loading_fix-3ac6d4ea8129
-- 
- Charlie


