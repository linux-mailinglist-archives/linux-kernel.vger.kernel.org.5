Return-Path: <linux-kernel+bounces-60340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2C2850364
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E88B1C21DA9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937542B9CF;
	Sat, 10 Feb 2024 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=envs.net header.i=@envs.net header.b="KDptHeRj"
Received: from mail.envs.net (mail.envs.net [5.199.136.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728FD28DBF;
	Sat, 10 Feb 2024 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.199.136.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551246; cv=none; b=LVdeWHtvCdf0R0rISKKk+doME0gzz+G8hjm2FscCvdPO7pxT1eh/V2s036ltBhQXqPcQU8U/9XB5lSg+DyUrnnfSUTuDE4DIRHOF5Z7EdkmSRaynVYbQjzsneo+ol5/GXsixWrONW0YCWgHZf9FGB2e/JpRtA2D6VhbpiFcoISU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551246; c=relaxed/simple;
	bh=GZiZoI6e3JvsqnLrL5xGsh92gGaBzJaPJ2zt48adfWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cI8AYMm4doo0deUUXDYXxBJ4CHonamdImTjInW//2zbUwqVnyCykZKr4b+Gz1ayGstxKZ2OZe008NGRwxX9WFhTm+AfQDclUbUQPJE+D0yE4H4Tq1Mo8XWpGxxS4tb/pLQqr/u3+OUkVAbLaRBfT2zu6VSZIIQtNptXfy4Oqgn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net; spf=pass smtp.mailfrom=envs.net; dkim=pass (4096-bit key) header.d=envs.net header.i=@envs.net header.b=KDptHeRj; arc=none smtp.client-ip=5.199.136.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=envs.net
Received: from localhost (mail.envs.net [127.0.0.1])
	by mail.envs.net (Postfix) with ESMTP id DE4E138A067D;
	Sat, 10 Feb 2024 07:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
	t=1707551242; bh=3RXoGcCjW+CB+wVoqLryQrySRvbelditpYUk0T7yTSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KDptHeRjyPkaRYgDgQJ76TMbGq2rsbc0AgiZQdCY1JOAdzUUBP4+RjmkgxBwk+Z4T
	 j1LGFsSoHsi7dXIAgAUbI/PPv5xfuDLWxP4xy8zkDFsW90QSwB5pLXrOkhMRao+XlL
	 KAGg3sF0YhX3cFUj7jBo9lVPvYfUmcRpz6Dlk3dlkBOPJkdR3HhxzbFttuK6GrofQY
	 ObwJoxqqdzPs/TeRoNi+Jn9jBlea4UDeZraoiBsmmwSyGY6ev426Owf0SUmoV+i3RR
	 OaHBBhn4elcui9shUMYi0MKJm8/fdLhF53D6fhPStFXiuMRn+EylTstmABQgAIluS2
	 k+BkRN8SrN9KqQntdQIwXQxV3M4XoETzxQqWgTPpLG+5rridntyZXpp9JG4db2uRBf
	 53smMVcv8z4u3nsFvR1BYtrtMOFXQdDNIkr8vIHR2Y4Fb9WClbM357GuFTdzDohLL3
	 ufzACtqqpgzpeAUIpB+hpnQys9UGaf19H5UEWoZBtp06T3Gxxhaq3RMkgzB2quBqMc
	 qLRu15nv/pXCuJxUSCsVfTbMkWHMyB4bG4gVLFKO2bEIjVS1ikgXoHx6r8+N90JWh3
	 W6U+HRvy34HObUcQk+4BHgKYhAFIqbkHlDApBHipsmz5NzMx1YZiZUH05xtydi02qS
	 1mp9NGb4qW3iB47WQjcJKO8A=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
	by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qlRMxgQ5V7Qg; Sat, 10 Feb 2024 07:47:13 +0000 (UTC)
Received: from xtexx.eu.org (unknown [223.73.102.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.envs.net (Postfix) with ESMTPSA;
	Sat, 10 Feb 2024 07:47:12 +0000 (UTC)
From: Zhang Bingwu <xtex@envs.net>
To: Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Zhang Bingwu <xtexchooser@duck.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH 2/2] kbuild: Create INSTALL_PATH directory if it does not exist
Date: Sat, 10 Feb 2024 15:46:01 +0800
Message-ID: <20240210074601.5363-3-xtex@envs.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210074601.5363-1-xtex@envs.net>
References: <20240210074601.5363-1-xtex@envs.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Bingwu <xtexchooser@duck.com>

If INSTALL_PATH is not a valid directory, create it, like what
modules_install and dtbs_install will do in the same situation.

Signed-off-by: Zhang Bingwu <xtexchooser@duck.com>
---
 scripts/install.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/install.sh b/scripts/install.sh
index 9bb0fb44f04a..02b845e7ab33 100755
--- a/scripts/install.sh
+++ b/scripts/install.sh
@@ -20,6 +20,10 @@ do
 	fi
 done
 
+if [ "${INSTALL_PATH}" != "" ] && ! [ -e "${INSTALL_PATH}" ]; then
+	mkdir -p "${INSTALL_PATH}"
+fi
+
 # User/arch may have a custom install script
 for file in "${HOME}/bin/${INSTALLKERNEL}"		\
 	    "/sbin/${INSTALLKERNEL}"			\
-- 
2.43.0


