Return-Path: <linux-kernel+bounces-65721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4BD8550CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E9C2815A0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED091129A78;
	Wed, 14 Feb 2024 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aQYrEZEW"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25481272BE;
	Wed, 14 Feb 2024 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933058; cv=none; b=I6DphFpndxI31oGvl3jLIUd1YPmJO1ScbHEHmHw6kN6gzxXb1srlq+EwSpl4o5I7dGOai8+oOBZRtgVXnnxeWpAGknV6bHvnse/Uo3WGvI5R5jDtjGVmqbr97/mGV0CRW4tj4g1243yrz86aMDNt4X4rVRL4fjWnk/FJsczatRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933058; c=relaxed/simple;
	bh=d7TpTIQFvUc4GtfYnpnoSFurHUBHeYBqssED1WsRs90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEa/h4g6m6wPV946vgso88917SL8o/uvl47kL0Cd9zb7LVW14ReNIzHhM7vKsx0VfsyF9uGmu2IhG5dwSj0PugJih+QjDxImB1bur4BtqHdT2yLwHlsx1q5RAtA599bVhz5ATxaNZYXqTFU4DumyLbEfDhTH3UMJCuYyf2YA/+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aQYrEZEW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8A02C40E0192;
	Wed, 14 Feb 2024 17:50:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YCe6fvn3JETS; Wed, 14 Feb 2024 17:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707933050; bh=qUh4WIH3ckW7fLarRAPiVUTTPuVgUfxxHviN4hfLN8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aQYrEZEWd9dQXNI4vF1k//9rVISI9oNp0/c0/Egkb2UXQqvVVFhxk1RE4UFreV6Jf
	 2+AvOeCWGpsR7dLvoqBudZ0ul5oouk5m8i6Bid7ktP15NoIO0HCsCX9wCTs6aev2MB
	 F/8AUSEiZ1T74M/PkXhDPM3QRVlgxcE5SlPrPXDU4v2Dj2GSw2EIpP06BiADHX0ir+
	 Uk2ZpZ76/cw+0MsLLH3M3TzeFqk1oS6ixJDe09FD/WnJYHoYRmbgA1n7nvphrx6clf
	 6vJyRRVUq5uq1bWy36hRkdH+ghJHZZUlCovNWEzyQ3GkRtJVa6jAcH4J/nVmVj5fjb
	 h2CHPFgZdG+1nPKOF8QgPe6jtQRmBwop/GoYPzuHVIfeOibOMBoVgu/nlxcaDGWvxi
	 uVXtoLsQMrtobrpiu2IakeOnz6FOypXiyRMvloRiWt5+T9eGjc63kRKsY6LZdQD03E
	 RvU2VS+SxEr49hXzeC6lb00F3Bx6tZVeQH0BcOToq/fl/mEfVhx4KObvZ39pjePKDX
	 BdkQ4uwDMDCGRHHs7hZaf6ZwOMx3dUu2z1+gQf78YsZtfdboWM4CKXaPAN+vFPvdnx
	 wb4VA9rD6q+GerzHyPAQI0/vcCgRIYY8ssSlzfaWVxIFm+VLIfMObqoSWc9Z3Ui1iX
	 YwP28P3368SpCgA/XN4QZ0Uo=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E99640E01BB;
	Wed, 14 Feb 2024 17:50:41 +0000 (UTC)
Date: Wed, 14 Feb 2024 18:50:35 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Message-ID: <20240214175035.GKZcz9a0CieQSsMEmC@fat_crate.local>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
 <20240214092839.GBZcyHxzsaz9NcijyV@fat_crate.local>
 <76fe899b-73ea-4f6b-9821-84240d89b0cb@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76fe899b-73ea-4f6b-9821-84240d89b0cb@amd.com>

On Wed, Feb 14, 2024 at 09:28:54AM -0500, Yazen Ghannam wrote:
> > That's a good thing to have here.

Up to here. __packed still needs clarification.

diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
index 782951aa302f..f5dde88a3188 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -37,14 +37,13 @@ source "drivers/ras/amd/atl/Kconfig"
 config RAS_FMPM
 	tristate "FRU Memory Poison Manager"
 	default m
-	depends on X86_MCE
-	imply AMD_ATL
+	depends on AMD_ATL
 	help
 	  Support saving and restoring memory error information across reboot
-	  cycles using ACPI ERST as persistent storage. Error information is
-	  saved with the UEFI CPER "FRU Memory Poison" section format.
+	  using ACPI ERST as persistent storage. Error information is saved with
+	  the UEFI CPER "FRU Memory Poison" section format.
 
-	  Memory may be retired during boot time and run time depending on
+	  Memory will be retired during boot time and run time depending on
 	  platform-specific policies.
 
 endif
diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index d6a963aca093..901a1f0018fc 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -12,7 +12,7 @@
  *
  * Implementation notes, assumptions, and limitations:
  *
- * - FRU Memory Poison Section and Memory Poison Descriptor definitions are not yet
+ * - FRU memory poison section and memory poison descriptor definitions are not yet
  *   included in the UEFI specification. So they are defined here. Afterwards, they
  *   may be moved to linux/cper.h, if appropriate.
  *
@@ -23,16 +23,13 @@
  *   AMD MI300-based platform(s) assumptions:
  *   - Memory errors are reported through x86 MCA.
  *   - The entire DRAM row containing a memory error should be retired.
- *   - There will be (1) FRU Memory Poison Section per CPER.
- *   - The FRU will be the CPU Package (Processor Socket).
- *   - The default number of Memory Poison Descriptor entries should be (8).
- *   - The Platform will use ACPI ERST for persistent storage.
+ *   - There will be (1) FRU memory poison section per CPER.
+ *   - The FRU will be the CPU package (processor socket).
+ *   - The default number of memory poison descriptor entries should be (8).
+ *   - The platform will use ACPI ERST for persistent storage.
  *   - All FRU records should be saved to persistent storage. Module init will
  *     fail if any FRU record is not successfully written.
  *
- * - Source code will be under 'drivers/ras/amd/' unless and until there is interest
- *   to use this module for other vendors.
- *
  * - Boot time memory retirement may occur later than ideal due to dependencies
  *   on other libraries and drivers. This leaves a gap where bad memory may be
  *   accessed during early boot stages.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

