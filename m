Return-Path: <linux-kernel+bounces-65798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DC68551FF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60ED1F254AA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E42128367;
	Wed, 14 Feb 2024 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MjhLPVc7"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7FA84FC8;
	Wed, 14 Feb 2024 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934930; cv=none; b=InJNymaWay5pny0IIydhgBX1nIjKC5eFgmjOIqYddtcEY4qkm+VhVW59k0mkLL7AOrn/avbWLhcVHDc016JPd/X22BPv70TxXOCP2PpdZLLpsC7+fqzQpU/GwX9HKu2vjJMbhlHjZ78r3K8mfKESAajPs4Gk0XqThBmuKzcPGKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934930; c=relaxed/simple;
	bh=BlohAVdQg8aAH/rGOpb+k4F3aQG8n4xB4MOCoRmKlwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEM9TEr04LEYK94v0L9/3loyT5XGM3vB3jqU6xpn3Ss574EsqlHZfCfYJXgX0EfpwG9y7EK0Hu29SYRWSX35ueKAGm5XuYUkvEHIsI7iH+fb5q3k+QboKFa5gBdt2PS2y55wlW2Y2iu04LS8BMM7rJA2UtC3ykyPQZNVcRXD3Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MjhLPVc7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9ACBA40E016C;
	Wed, 14 Feb 2024 18:22:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UgydcL41a98H; Wed, 14 Feb 2024 18:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707934923; bh=p2c24939mDKGPdH1u5xSSWo661pqweRtr5XTtkyBFbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MjhLPVc747FOTzTmEA0/xcn2DQ0Cxp6GbcTDTOzWA8OBwIXjkTNrQCiqgnE8vzIy3
	 dDKeYst96NkCiGu37tiu0YcjieDyBcqCXP52C5aowrXWoT/Tdt03saDjXkY/VruF7P
	 97zA0ZNe5kX8I9DTpwl/eV8TA0reAg46uZLJDlcppZY2muvtZhi8smQqMMU+R6B6kZ
	 AtclW4XSJ2HvzKO7ahFQslP7YkelX7FjoNyKVyGWEycbIO9XqiYqQ0P7v25raITprI
	 NVwOnxEtGNHrZhhkGR3l4DU70omHAmwlYYj1HyLosw1jv7SX+LPk+HMfstJRX8lg9F
	 unuCW3/xfZPU3XE7VuYaMuecG/leUFc8WdZkcu4zNYDxm37/HehZ71ME8N2SF1aQ6r
	 uZFZFUPL7gUHNHJV7fWTAAXFidh/NfWxFlOGLl5/LVtPO5AST6A6yfEj2Yk1uJwJlD
	 WrDgz9KX8D+KH/OQRloR7Hlqg1/n9Rmx4nyO5fS2PRj9TLV0rItoL1KG82UmHSW7Km
	 N4RUVdRLQkdU8BJatfm0Nt6uCZ+l6+N42RzgjPcnLflGKR8xFIWfeISXV96FwXFPaD
	 /mTrWy+J6xuUly4cYo++OfZT3SnKaphRTNwnXlpgTXiSkF0T6HYX0Aqxiv7BZ2b7AS
	 8SBClTS+kraSblHjcOL0hAkI=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 39E2A40E01A9;
	Wed, 14 Feb 2024 18:21:54 +0000 (UTC)
Date: Wed, 14 Feb 2024 19:21:48 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Message-ID: <20240214182148.GFZc0EvDru3gmS2jFL@fat_crate.local>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
 <20240214092839.GBZcyHxzsaz9NcijyV@fat_crate.local>
 <76fe899b-73ea-4f6b-9821-84240d89b0cb@amd.com>
 <20240214175035.GKZcz9a0CieQSsMEmC@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240214175035.GKZcz9a0CieQSsMEmC@fat_crate.local>

On Wed, Feb 14, 2024 at 06:50:35PM +0100, Borislav Petkov wrote:
> On Wed, Feb 14, 2024 at 09:28:54AM -0500, Yazen Ghannam wrote:
> > > That's a good thing to have here.
> 
> Up to here. __packed still needs clarification.

Yap, that is plain old __packed, as we just established:

---

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 99499a37e9d5..a67a4b67cf9d 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -53,8 +53,6 @@
 #include <asm/cpu_device_id.h>
 #include <asm/mce.h>
 
-#pragma pack(1)
-
 /* Validation Bits */
 #define FMP_VALID_ARCH_TYPE		BIT_ULL(0)
 #define FMP_VALID_ARCH			BIT_ULL(1)
@@ -78,7 +76,7 @@ struct cper_sec_fru_mem_poison {
 	u32 fru_id_type;
 	u64 fru_id;
 	u32 nr_entries;
-};
+} __packed;
 
 /* FRU Descriptor ID Types */
 #define FPD_HW_ID_TYPE_MCA_IPID		0
@@ -93,7 +91,7 @@ struct cper_fru_poison_desc {
 	u64 hw_id;
 	u32 addr_type;
 	u64 addr;
-};
+} __packed;
 
 /* Collection of headers and sections for easy pointer use. */
 struct fru_rec {
@@ -101,10 +99,7 @@ struct fru_rec {
 	struct cper_section_descriptor	sec_desc;
 	struct cper_sec_fru_mem_poison	fmp;
 	struct cper_fru_poison_desc	entries[];
-};
-
-/* Reset to default packing */
-#pragma pack()
+} __packed;
 
 /*
  * Pointers to the complete CPER record of each FRU.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

