Return-Path: <linux-kernel+bounces-19397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1AC826C58
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E695B1F224DC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DEC14A9D;
	Mon,  8 Jan 2024 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB0RMELP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13DD1426F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e72e3d435so1459084e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 03:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704712508; x=1705317308; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=oqwxvs1w/Ch3j2FP21bD5Di3R8xlLyIRand9BhaDT4A=;
        b=FB0RMELP85dn6dSD5rFyeIq+TRft8GS4HKn4OpLaHyWMdaRHyujc9hAmzZZcELqmX4
         hUMv9mjB39AEbuayh4t6ypuw6vaFm/fHq5+iLjB7PIqki63MMv0RZ5DD8UUwLGv8W/y7
         +1UclBLE3sCPdi19ylC/kRZOdTWMtYXYkvZfKCOlen4Hr+/Zs/WItlfcZdWMEuxxWTuy
         18Yj4W9RzN4tfklIJcHpcg1HVJ7D4wDhgwi7E+Yce9zJUnQ5LfO9gAjXA89RiAYb5eFw
         nzGCXcB+QbHHu1xFPfdbhdb9DHYQmiLCorAlpIIo+BJhmUs/H+k4qLOF3eXjW6YIsZMv
         7K+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704712508; x=1705317308;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqwxvs1w/Ch3j2FP21bD5Di3R8xlLyIRand9BhaDT4A=;
        b=nZUDteMSmvXdLVIw4QSCsX1NkE5YqsUbAjnhEYh8VxaP+/+bvaDVLXp3Xi6Zn7jIsK
         CYBErioMCplaRvRY/Nx4vEZm6NJ64qqrCmtiiFIlfIx0PmJ5sssRtkTOOs1YrqioLB+n
         6FMTIIH6SE3mXRsg0oU2cM7DH9sU/+hAUV1RSGN+2iJp3LsyTK0YNNSNQugkxF5ihz+r
         W5pqtjIem8Ywn9vSHxnYGxzXCBDcqzDu7gPORJS7RCION7ktIGr0IUvqt0xqNE5QMXfR
         nRqaQcAEMN2S4pA14unIKCRCQtKSpnktzyihERBMS9vBFSH7lQ9Flju4I9Zaktl4NhbG
         g67Q==
X-Gm-Message-State: AOJu0YwW5wmysA4Xg1ovD62NTuLk5ahbHUorpc5kXPWw/8e+bjyyY8AA
	agyYonnao5QWbAjUH9lyuhmhWYMpOaM=
X-Google-Smtp-Source: AGHT+IGYyqiEugxnuLkG0XGKcJCudiuKRiMkQEk16jXKnn6NY2w761hIu/ZXMZVkSWkfCr1VDH8xrA==
X-Received: by 2002:ac2:4e10:0:b0:50e:aac2:b88d with SMTP id e16-20020ac24e10000000b0050eaac2b88dmr1070530lfr.94.1704712508430;
        Mon, 08 Jan 2024 03:15:08 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id j19-20020a170906431300b00a28aba1f56fsm3837343ejm.210.2024.01.08.03.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 03:15:07 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 12:15:06 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Subject: [GIT PULL] x86/build changes for v6.8
Message-ID: <ZZvZOhUHRrgkOAPJ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/build git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2024-01-08

   # HEAD: bcf7ef56daca2eacf836d22eee23c66f7cd96a65 x86/tools: objdump_reformat.awk: Skip bad instructions from llvm-objdump

x86/build changes for v6.8:

 - Update the objdump & instruction decoder self-test code for
   better LLVM toolchain compatibility

 - Rework CONFIG_X86_PAE dependencies, for better readability
   and higher robustness.

 - Misc cleanups

 Thanks,

	Ingo

------------------>
Arnd Bergmann (1):
      x86/Kconfig: Rework CONFIG_X86_PAE dependency

Nathan Chancellor (2):
      x86/tools: Remove chkobjdump.awk
      x86/tools: objdump_reformat.awk: Skip bad instructions from llvm-objdump

Samuel Zeter (2):
      x86/tools: objdump_reformat.awk: Ensure regex matches fwait
      x86/tools: objdump_reformat.awk: Allow for spaces


 arch/x86/Kconfig                    |  4 ++--
 arch/x86/Kconfig.cpu                |  6 +++++-
 arch/x86/tools/Makefile             |  2 +-
 arch/x86/tools/chkobjdump.awk       | 34 ----------------------------------
 arch/x86/tools/objdump_reformat.awk |  6 +++---
 5 files changed, 11 insertions(+), 41 deletions(-)
 delete mode 100644 arch/x86/tools/chkobjdump.awk

