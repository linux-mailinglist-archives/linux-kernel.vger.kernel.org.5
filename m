Return-Path: <linux-kernel+bounces-13732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2298820BC5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 16:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DECB281C82
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42BDB664;
	Sun, 31 Dec 2023 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EgK3MOKR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D747CA957
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7b7f2c72846so400401839f.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 07:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704036480; x=1704641280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leMifUQFY/hnRKKKOp+M4kt1TiREdMrY53gOOvxLu5g=;
        b=EgK3MOKRC8Yak0GueyTlYsgy0GJ/JXChiZHZ3HaWP6ow73J3K12TL/wZUAvLPR9/iu
         nERe9vhr2/CS4a/PMAOpz+0Fjm+hZnQVSkyjcEGNTlc62PoF9in2UHeH3wHN+hqHN/Ma
         pnEaumnn6SpwGcwFQS4UVZHW5h9nJm8MXTd/C9FDUbxy2E8Hr2Rp6fH8VnSPIRWXnpxF
         Y0FnlJQG2YLsfWzShu0yIuj2WA6qBXYChAIpVQ4OfWEwRyv4dY69MVJvfiS1vr6+Rftu
         TMhdazHS/Sn/w+fZIRLr6hPMX5iHn2Nmd/i8YnRFH5FVlIRGS5UROBrYebv8TcpHSDcz
         ee+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704036480; x=1704641280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leMifUQFY/hnRKKKOp+M4kt1TiREdMrY53gOOvxLu5g=;
        b=k5EsyoUafEtbgivyJyC9DSteNgJO/KUa/VOCmEnLgaarjwiigmeJwlsX8+6Yo8U3y1
         xYQe/GJUtRgaG6BS9cgGQpdEi/3Wgr/sj7TXJVEzU9n+5OPXSRyUpzFxxODJPdGkybWs
         qiKShVz29gFL3KhGpWZqhsdm0L/WR4bD46OilYa4HyYVIX96K3U8wGUlppVHuv9ZSVXR
         QmSn3jjyV66D4XDEbwQITrBexW8vL8SSZVxincJUn6x+xuRMWi9h0jBoorbvS877qQ/l
         INa7PoIZp65M/SHL249AD7E0xK+v7fxnZNG/4amreYmsOqlEfWpGbGTrMzYsl0j6Gqzf
         k+TA==
X-Gm-Message-State: AOJu0YyVNwVq2USTU3G3M9oln0E2knw5lRX1lq0IavFdF21lLz97Q/qz
	8NPRzotsYSSzg96fO2Sj8bvqH6XlXpuWyg==
X-Google-Smtp-Source: AGHT+IHvzlmEOnBTt5frc//wb3eiOCzfM75y7LicREf98+n1CVL3gaYUoNXYckFPbzNADg+lxI7hlA==
X-Received: by 2002:a92:ca4a:0:b0:35f:f4ae:955e with SMTP id q10-20020a92ca4a000000b0035ff4ae955emr17849031ilo.35.1704036479991;
        Sun, 31 Dec 2023 07:27:59 -0800 (PST)
Received: from localhost.localdomain ([49.216.222.63])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902e54400b001cc3c521affsm18624430plf.300.2023.12.31.07.27.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Dec 2023 07:27:59 -0800 (PST)
From: Jerry Shih <jerry.shih@sifive.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	conor.dooley@microchip.com,
	ebiggers@kernel.org,
	ardb@kernel.org
Cc: heiko@sntech.de,
	phoebe.chen@sifive.com,
	hongrong.hsu@sifive.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v4 02/11] RISC-V: hook new crypto subdir into build-system
Date: Sun, 31 Dec 2023 23:27:34 +0800
Message-Id: <20231231152743.6304-3-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231231152743.6304-1-jerry.shih@sifive.com>
References: <20231231152743.6304-1-jerry.shih@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

Create a crypto subdirectory for added accelerated cryptography routines
and hook it into the riscv Kbuild and the main crypto Kconfig.

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
---
 arch/riscv/Kbuild          | 1 +
 arch/riscv/crypto/Kconfig  | 5 +++++
 arch/riscv/crypto/Makefile | 4 ++++
 crypto/Kconfig             | 3 +++
 4 files changed, 13 insertions(+)
 create mode 100644 arch/riscv/crypto/Kconfig
 create mode 100644 arch/riscv/crypto/Makefile

diff --git a/arch/riscv/Kbuild b/arch/riscv/Kbuild
index d25ad1c19f88..2c585f7a0b6e 100644
--- a/arch/riscv/Kbuild
+++ b/arch/riscv/Kbuild
@@ -2,6 +2,7 @@
 
 obj-y += kernel/ mm/ net/
 obj-$(CONFIG_BUILTIN_DTB) += boot/dts/
+obj-$(CONFIG_CRYPTO) += crypto/
 obj-y += errata/
 obj-$(CONFIG_KVM) += kvm/
 
diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
new file mode 100644
index 000000000000..10d60edc0110
--- /dev/null
+++ b/arch/riscv/crypto/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "Accelerated Cryptographic Algorithms for CPU (riscv)"
+
+endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
new file mode 100644
index 000000000000..b3b6332c9f6d
--- /dev/null
+++ b/arch/riscv/crypto/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# linux/arch/riscv/crypto/Makefile
+#
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 70661f58ee41..c8fd2b83e589 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1519,6 +1519,9 @@ endif
 if PPC
 source "arch/powerpc/crypto/Kconfig"
 endif
+if RISCV
+source "arch/riscv/crypto/Kconfig"
+endif
 if S390
 source "arch/s390/crypto/Kconfig"
 endif
-- 
2.28.0


