Return-Path: <linux-kernel+bounces-15916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7E68235A3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF06E2845D3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8191D543;
	Wed,  3 Jan 2024 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iUndUA2a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A891D53E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 117CF40E00C7;
	Wed,  3 Jan 2024 19:33:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JJ364MEOexCW; Wed,  3 Jan 2024 19:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704310400; bh=LI4BoQxt9juo8GAaDe/qJjCCtPWkH2PdXrbh9USLSXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUndUA2aUU0N6d0Cx2P+C4dAo88NRh7/qGVWfKUuKLk371ORXQuLXGWhfcjTMQ84Y
	 Yn644KI5biroliewtLXnYxGPK3QEhImNcttJMwS9m3RQndvHrS+jK/g9ZWNDzlI0hz
	 x/4QLNYtTEN6wQJ/Ebtb6sQSlG5zERzDK3Q5yXilFfiUgPj3dju3UkBGSDndmkxW24
	 L2E5XB0r1QurfW/aAJE+VnF1FjEiUUEAOaajcCHSBbtg51as1jqQwJ/0eQupCvodJi
	 VCibOuEJgDNpaNxOtpsEFoL8GTbeqVOzCwMzwcryg5Q698bGPhJ91xDeIAiQCe/PQJ
	 4+WxxHIFygfnc9lSzl5Tr6Ym+KcsAwzzUEaRSbSjTXRQhdb4mG6AyCb01uaLbmriZy
	 bvxB2pYDHfYh/CP6r/aNMdH0hNQhn356Z/40w9BKaIa8TTEaaZ7RciUqceHOgz+NFC
	 f3T7fdDXYs4EM5BXuHHCHm+XmFCSNREk2K0GZ+15GtWBuqzcXZ/x7C5MF4MhiKtu/3
	 Z3SNtZsdWZFKjWy+j5OS7LTCMCkxkMU/JHo5Vyb3SlbuSXHRYuRLfIYO8t9hrTjJP2
	 Qhr4Ba6STe/c5xt9GdC8qAk3EXqjKwM1E02/sfVeCvf2fdtoogA2SLh3jakzfTFixQ
	 wvd/n0ZT1NAI0EjluRM3Rp0o=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C34F640E0198;
	Wed,  3 Jan 2024 19:33:15 +0000 (UTC)
Date: Wed, 3 Jan 2024 20:33:09 +0100
From: Borislav Petkov <bp@alien8.de>
To: kernel test robot <lkp@intel.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [tip:ras/core 11/13] include/linux/ras.h:9:10: fatal error:
 uapi/asm/mce.h: No such file or directory
Message-ID: <20240103193309.GFZZW2dehRC+K/VreB@fat_crate.local>
References: <202401040257.NPrXuVk7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202401040257.NPrXuVk7-lkp@intel.com>

On Thu, Jan 04, 2024 at 02:35:29AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
> head:   d48d30d8c358004c7b1cb2e16969a569d45953b3
> commit: 8e1d0790e0a749a62428ff039c7a9050a06e9feb [11/13] RAS: Introduce AMD Address Translation Library
> config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240104/202401040257.NPrXuVk7-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240104/202401040257.NPrXuVk7-lkp@intel.com/reproduce)

How are you even testing this successfully?

I get with this compiler here:

<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
{standard input}: Assembler messages:
{standard input}:1094: Warning: end of file not at end of a line; newline inserted
{standard input}:1095: Error: expected symbol name
sh4-linux-gcc: internal compiler error: Segmentation fault signal terminated program cc1
Please submit a full bug report, with preprocessed source (by using -freport-bug).
See <https://gcc.gnu.org/bugs/> for instructions.
make[5]: *** [scripts/Makefile.build:243: drivers/net/pcs/pcs-xpcs.o] Error 4
make[4]: *** [scripts/Makefile.build:480: drivers/net/pcs] Error 2
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:480: drivers/net] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:480: drivers] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/mnt/kernel/kernel/linux/Makefile:1911: .] Error 2
make: *** [Makefile:234: __sub-make] Error 2

Anyway, this should fix it:

diff --git a/include/linux/ras.h b/include/linux/ras.h
index 829252a358b7..5d8f0e6fc03d 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -6,7 +6,9 @@
 #include <linux/uuid.h>
 #include <linux/cper.h>
 
+#ifdef CONFIG_X86_MCE
 #include <uapi/asm/mce.h>
+#endif
 
 #ifdef CONFIG_DEBUG_FS
 int ras_userspace_consumers(void);
@@ -38,11 +40,12 @@ static inline void
 log_arm_hw_error(struct cper_sec_proc_arm *err) { return; }
 #endif
 
-#if IS_ENABLED(CONFIG_AMD_ATL)
+#ifdef CONFIG_AMD_ATL
 void amd_atl_register_decoder(unsigned long (*f)(struct mce *));
 void amd_atl_unregister_decoder(void);
 unsigned long amd_convert_umc_mca_addr_to_sys_addr(struct mce *m);
 #else
+struct mce;
 static inline unsigned long amd_convert_umc_mca_addr_to_sys_addr(struct mce *m) { return -EINVAL; }
 #endif /* CONFIG_AMD_ATL */
 
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

