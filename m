Return-Path: <linux-kernel+bounces-15971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A815B823678
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA171F240BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F1B1D54B;
	Wed,  3 Jan 2024 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZCLRylQ8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87C31D533
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 20:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d44200b976so39158455ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 12:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704313323; x=1704918123; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gTexI7tnAdoFFXRXkFNPAWJZ+GVqwcinKJy6ELjkn58=;
        b=ZCLRylQ8B918yjouy/VQsORN5ONs6VD8M7q98yrDaMvG7NR/KfCgU2Vzn0DY/l6SP3
         9hHVfP1aOnQBLqzPYK0LaaveKP4IvqoTBbOQbOvTuUCerstrxYI9b3gLND37JRn0//o+
         pIlnjiPFHBm3Ygt2nMOeo5CHteFZw7TzzWyRcnFvWaWWN+MTGoN7ZXHppQZFYv0OXkno
         Yo0mZCYYEbSJVKYvmUbI43Be03bdnR6sK6Vok83ut88XvGS52qud3sZ6o/mUBm7ZwF5B
         bKapvbFbbgeBYaVMVF3x+jBMDUNcPPQxuwjQgJEnkW8+9GQf0sDwvPBCZ8xmWk7ylHhK
         wugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704313323; x=1704918123;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTexI7tnAdoFFXRXkFNPAWJZ+GVqwcinKJy6ELjkn58=;
        b=JMyrYZIzKGjFZvIU052eLk0vQULWCh+/h5+gWTJ8VOsQ7s1TcMx34fbDrDb5UZn+/s
         r6+M6BlXzVeb165DEixkucurChQm1VxlZOC+D170qXNYX26WD6IEG2yWxpJ0IPPOy36O
         piHMPSbshojoJbBKT5uMkbZI7JGbxJnnKxKsTinPkFOPjo/765X0Hujsf8e3rldHOvck
         EZnpQD3QFB16GgQrGriOKWyHkobgn1n2tcoTSAOKhNdOlVl8H8r9iB29fQ6x/BIXQsje
         yhmiZuulIAbWXyLQ62bThrzQJzr07H9sXvfHDo4UCua5Eou0VnPQgS2pXBvo1qDfaZos
         OI3g==
X-Gm-Message-State: AOJu0YzD7cHxo3SWg27TJWmebZ9D1a7oj2Tsgd9iZ51fWKEEO5iZihA9
	PKo5LKno9vDOqpyG/hPGWhIvB+YK1W5paA==
X-Google-Smtp-Source: AGHT+IHvVQb7kgSchdLziFcMtH5i/arCS5/o8D3svG2o4+X6JKJgSmfGvIHFxmPZdBP03J9lNRtvDA==
X-Received: by 2002:a17:903:60e:b0:1d0:6b95:9c06 with SMTP id kg14-20020a170903060e00b001d06b959c06mr6626370plb.16.1704313323274;
        Wed, 03 Jan 2024 12:22:03 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d13-20020a170903230d00b001d3fa5acf71sm24278739plh.12.2024.01.03.12.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:22:02 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v2 0/4] riscv: modules: Fix module loading error handling
Date: Wed, 03 Jan 2024 12:21:59 -0800
Message-Id: <20240103-module_loading_fix-v2-0-292b160552c9@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOfBlWUC/32NWw7CIBBFt9LMtxgBX/TLfZimGWFsJ2nBgBJNw
 97FLsDPc5J77gKJIlOCtlkgUubEwVdQmwbsiH4gwa4yqJ3SUkkt5uBeE/VTQMd+6O/8Fhrt0e0
 Jz1IZqMNHpKrX6LWrPHJ6hvhZP7L82b+5LIUUDs3tZI1CR4dL5BwSe7u1YYaulPIF9AEPB7cAA
 AA=
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>, 
 Julia Lawall <julia.lawall@inria.fr>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704313322; l=964;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=iejeji0PdwBP2+MrHzl9oqmctk2biWWiQKeoNT5CSgU=;
 b=TcZUkCn0ll7uTspedyQj8DLjja65+zSMipWNDJaXGKS2IENK0pUgIqga+UJONlE75uI9wo2jk
 L9swYz/1P/GBowbm5HPUKPtpZIJF4XWgVR4VscJWf27ccFdOCmISlGl
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

When modules are loaded while there is not ample allocatable memory,
there was previously not proper error handling. This series fixes a
use-after-free error and a different issue that caused a non graceful
exit after memory was not properly allocated.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v2:
- Split changes across multiple patches
- Link to v1: https://lore.kernel.org/r/20231213-module_loading_fix-v1-1-da9b7c92ade5@rivosinc.com

---
Charlie Jenkins (4):
      riscv: Fix module loading free order
      riscv: Correctly free relocation hashtable on error
      riscv: Fix relocation_hashtable size
      riscv: Convert relocation iterator to do-while

 arch/riscv/kernel/module.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)
---
base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
change-id: 20231213-module_loading_fix-3ac6d4ea8129
-- 
- Charlie


