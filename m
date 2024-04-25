Return-Path: <linux-kernel+bounces-159093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620568B2940
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014611F21F33
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44664152534;
	Thu, 25 Apr 2024 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Nweo078U"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D80215252D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075128; cv=none; b=OyTERKgkJTL/l6aBSu0pcYcIb55ohNYIRiRxpIK/NZzbYh3XnOl05jgpvUx+M4b88hF6LoBpckxqOu1/RHcqEHsuIcYPXf5UH55NRq5LLTUV1tBhGhtizp5nir29QMHEZbJcTBRMhHjnh/52jjBjOhewJE6nRg+zqI60K55rSJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075128; c=relaxed/simple;
	bh=nA0EButQZ1tC8ouxJfYydhjZwNEli15W2Azor/y6KZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tv+mDuvmafk5hKNrx+/DsLJTSkt9CO+bKraP+QUS+LnCkRV8hDohJznLrlUDv7A2MBuv8JfCqUY00diLOAYdy6oo00l1Bx2KAyINLEu/S8FKKHiJqK4q/edJ+/PPI2sFURvvYC2WO5dCO7vQXERCQNxfUFl6DLK5e3FRdbEwznc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Nweo078U; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1eab699fcddso9750815ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714075125; x=1714679925; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0NZH4f99IF0WKrj7O85gUWonm//e5lpeuhKVLijLk2E=;
        b=Nweo078UWkJl5uZKvMSdw6n6ypTywgu+XYsEchWDJMFyPBBD12I+49BpCTJJhWYdaP
         jhYnPXwcepEXQdwIL6NGBP8UoVo0D5FNV45BM+JhhwBr1cyuQhW15Q0vI/QkPisNvQMw
         33OfyaOrv6lsUcpT07u8WYda3C8CizTaLHtg00LODCCgA3kKyMsZYGz53GjK8sR8hM6R
         BCADOgAlUWaF9KHB1DDKZ6AVJbRyd8Fed6fsjtLGABfH9SJWtVuqoJj94uNgACvUKldx
         LgGHBFKP48e0IrnnDz6KNZkGoafmGoHzXHcBEsexxWqtYQwZ6EL0mHvP7kngS+zg8rgq
         IleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714075125; x=1714679925;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0NZH4f99IF0WKrj7O85gUWonm//e5lpeuhKVLijLk2E=;
        b=aGXDEGZ1L6ydIuSnaq93Vsz6lTjNa/z3RfblYc0Lj635W+hYlFutcyfNEfUy3I/b1+
         5ESS0Tl3ba9ShtRGN0n6ULYvmOhpWokMb4rBwejZZj4IARuYfyHCccW25Mpc7gqkfY+d
         bTdgweDwbr2PT0sLMogBoI/x5YlIpGc5yuccBpBK5sXjuSKcqf0+UKyWRv/f2vvoaCCQ
         yDiNgKuvM6E5Cvo07D4fDi2EqU1iX9i9cOPyjEaOWSBlNQQaE+x9zR4fR1Ddtd/B+JLu
         QNZGOGyzGe6slRC0sNTtV38Bee7WyoLvv276drdTmmT7zuch8EHs5x0gz3YuosdRf+Cm
         jZPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsbc7NRdabke8Bm0tvPY5sNWjhBdZPQV9VBoUzLtOiNdRJtA6LHua6tbrLPYEuwnYsY9gPW2zKD6/F+rxcJXzMyIf16naQDY/f2+Je
X-Gm-Message-State: AOJu0YxysXkOHlN90k6m9N59Up1CZB3Tl67t9x3uPXVAcr7INteTaaqe
	64P8iTpN+OdQQHlqh+H7e01EdA3aHvEA7dooL2mj/uGYrKuVgxIyRS3MHzi6q3Q=
X-Google-Smtp-Source: AGHT+IECF4sLhnfZeY8g6vk2fi/Z9puc/V7awMpO2ZhBa2zz101/n/Rq4S5Hho5iCaLR2kaBPAoHRQ==
X-Received: by 2002:a17:902:e54d:b0:1e4:6938:6fe3 with SMTP id n13-20020a170902e54d00b001e469386fe3mr719133plf.58.1714075125454;
        Thu, 25 Apr 2024 12:58:45 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id p4-20020a170903248400b001dd88a5dc47sm14152176plw.290.2024.04.25.12.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 12:58:44 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 25 Apr 2024 12:58:03 -0700
Subject: [PATCH] riscv: selftests: Add hwprobe binaries to .gitignore
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-gitignore_hwprobe_artifacts-v1-1-dfc5a20da469@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAMq1KmYC/x3MQQqAIBAAwK/EnhPM8lBfiQizVfeisUoF0d+Tj
 nOZBzIyYYapeYDxpEwpVnRtAzaY6FHQXg1KqkEOSgtPhXxMjGu4Dk4broYLOWNLFm6TTtm913K
 0UIeD0dH97/Pyvh9r8BpEbQAAAA==
To: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714075124; l=933;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=nA0EButQZ1tC8ouxJfYydhjZwNEli15W2Azor/y6KZY=;
 b=EMBx4wRw1BijgV83w/DHcSmBFo1pgAnUefy+7FE1WoOwc0GghpU0GN3buJtNdf5uyLReFKFc8
 Ek2BHtYsvTBBwL2lzcL85G7/HKa4/x2hUALseg3IMLy0cbQDJ9zs7ic
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The cbo and which-cpu hwprobe selftests leave their artifacts in the
kernel tree and end up being tracked by git. Add the binaries to the
hwprobe selftest .gitignore so this no longer happens.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: a29e2a48afe3 ("RISC-V: selftests: Add CBO tests")
Fixes: ef7d6abb2cf5 ("RISC-V: selftests: Add which-cpus hwprobe test")
---
 tools/testing/selftests/riscv/hwprobe/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/riscv/hwprobe/.gitignore b/tools/testing/selftests/riscv/hwprobe/.gitignore
index 8113dc3bdd03..6e384e80ea1a 100644
--- a/tools/testing/selftests/riscv/hwprobe/.gitignore
+++ b/tools/testing/selftests/riscv/hwprobe/.gitignore
@@ -1 +1,3 @@
 hwprobe
+cbo
+which-cpus

---
base-commit: ed30a4a51bb196781c8058073ea720133a65596f
change-id: 20240425-gitignore_hwprobe_artifacts-fb0f2cd3509c
-- 
- Charlie


