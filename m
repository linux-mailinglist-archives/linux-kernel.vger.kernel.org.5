Return-Path: <linux-kernel+bounces-64963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE96A854536
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774281F2B3C8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AA712E76;
	Wed, 14 Feb 2024 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JUYCd74y"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3C6168D0;
	Wed, 14 Feb 2024 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902941; cv=none; b=M6ZvVPfuBRBEU9CVcQ13Txkp/kQlqXOn7213MKSDtg222KTh5CTujaZKvg69BnhiCkZdz0Y2bA6Lc/Zav6L45hV6IAHSaIZRmgRVvCnXvY2HbZzmRdMmndAwxeiheExIJl2AxmL8n4LXK47eVN3i4eJ+Xg5AX1o8RwC/Kwgmupo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902941; c=relaxed/simple;
	bh=1hpRClKmTPNX2vTFzy0Be6KFiRl2Dy3oFeZC6agd1a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwJeAFwQMDzB2IcQoZap1bZczWbb47YmaL44ePtaiCCjK4GHbBwEgWzXuC0+zUUINAToINEs2MuQmPp5rABH/2oA5X7DUpEEFG5Z2hfeFULfTIujgTImw2ilb6cnHOebkzYfMBuIYmjMFc+Gf/EAiKMlO1mpKz/r3RWP5CZjGwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JUYCd74y; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6473040E01A9;
	Wed, 14 Feb 2024 09:28:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WP9Zj7QVWper; Wed, 14 Feb 2024 09:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707902934; bh=LD2OQzDMo0zKu6jbPv5GEtHNMYpXCiZT9uYQtfb85b8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JUYCd74younkhk806A/9+fjVO4i5LbNUyM3b2pcysD+bGG5zRTZu2crWvgZ1muVuD
	 AAwFWHkLH6Gc+79SZwfdIO7e0WTf6oDluFyGG7C+UbWsyyUycxi1cApg4Mbz8fhXjq
	 k9kGanvl5ckEwJ5fU/GC5FR9uPDD6WLQpSIlZnap8CQvclo4etEBiWuiYf5o+tMNPC
	 so44o53+V75/3e8bZ62UW8e1AXNwENPt9XUW3iUA89ulBbxRyyLqVlEjI0zWs57Wx+
	 MFbVo9cKTsg6tDejxAQyxWxDqSMsayfEHMSW6uqJ7X+FPshwXyBhkx2rwR9LaGwy6e
	 1RfyxRARn39R0mW9cT2PfijnNc9xXzVcWYS8FWOf3xukwCADY5Nez8SVBUTY9DysdH
	 9XW+6GFcglHPjtXtMg5We4u5LUvumXCxGZAyoEu9P5f7xWGCo7Be2LuZeVUeVm1OaY
	 ++uLYuHSc7tV1MZg3PSNkG5obCBNm/uucj4N7jhUr/JW3cCYaThk3Vls+GmbkclheO
	 u+8Uz15u2XGhNFRZNEskKhjd5uy42xR6rl6OWotW6/U5rjw5Nsl+yY0xvSGvO/G6ei
	 JHTvhrB+1mRWxd9Jo2q5fIV4Qyr3iGuqQh8nRFshqzNTCMzvKC1YvOJwnCc2BibVB1
	 bufdPWF3P8V/xQw199YS05bA=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8433E40E00B2;
	Wed, 14 Feb 2024 09:28:45 +0000 (UTC)
Date: Wed, 14 Feb 2024 10:28:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Message-ID: <20240214092839.GBZcyHxzsaz9NcijyV@fat_crate.local>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240214033516.1344948-3-yazen.ghannam@amd.com>

On Tue, Feb 13, 2024 at 09:35:16PM -0600, Yazen Ghannam wrote:
> +config RAS_FMPM
> +	tristate "FRU Memory Poison Manager"
> +	default m
> +	depends on X86_MCE

I know this is generic-ish but it needs to be enabled only on AMD for
now. Whoever wants it somewhere else, then whoever needs to test it
there first and then enable it there.

> +	imply AMD_ATL
> +	help
> +	  Support saving and restoring memory error information across reboot
> +	  cycles using ACPI ERST as persistent storage. Error information is

s/cycles//

> +	  saved with the UEFI CPER "FRU Memory Poison" section format.
> +
> +	  Memory may be retired during boot time and run time depending on

s/may/is/

Please check all your text - too many "may"s for something which is not
a vendor doc. :)

> +	  platform-specific policies.
> +
>  endif
> diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
> index 3fac80f58005..11f95d59d397 100644
> --- a/drivers/ras/Makefile
> +++ b/drivers/ras/Makefile
> @@ -3,4 +3,5 @@ obj-$(CONFIG_RAS)	+= ras.o
>  obj-$(CONFIG_DEBUG_FS)	+= debugfs.o
>  obj-$(CONFIG_RAS_CEC)	+= cec.o
>  
> +obj-$(CONFIG_RAS_FMPM)	+= amd/fmpm.o
>  obj-y			+= amd/atl/
> diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
> new file mode 100644
> index 000000000000..077d9f35cc7d
> --- /dev/null
> +++ b/drivers/ras/amd/fmpm.c
> @@ -0,0 +1,776 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * FRU (Field-Replaceable Unit) Memory Poison Manager
> + *
> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Authors:
> + *	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
> + *	Muralidhara M K <muralidhara.mk@amd.com>
> + *	Yazen Ghannam <Yazen.Ghannam@amd.com>
> + *
> + * Implementation notes, assumptions, and limitations:
> + *
> + * - FRU Memory Poison Section and Memory Poison Descriptor definitions are not yet
> + *   included in the UEFI specification. So they are defined here. Afterwards, they
> + *   may be moved to linux/cper.h, if appropriate.
> + *
> + * - Platforms based on AMD MI300 systems will be the first to use these structures.
> + *   There are a number of assumptions made here that will need to be generalized
> + *   to support other platforms.
> + *
> + *   AMD MI300-based platform(s) assumptions:
> + *   - Memory errors are reported through x86 MCA.
> + *   - The entire DRAM row containing a memory error should be retired.
> + *   - There will be (1) FRU Memory Poison Section per CPER.
> + *   - The FRU will be the CPU Package (Processor Socket).
> + *   - The default number of Memory Poison Descriptor entries should be (8).
> + *   - The Platform will use ACPI ERST for persistent storage.
> + *   - All FRU records should be saved to persistent storage. Module init will
> + *     fail if any FRU record is not successfully written.

Please drop all that capitalized spelling.

> + * - Source code will be under 'drivers/ras/amd/' unless and until there is interest
> + *   to use this module for other vendors.

This is not needed.

> + * - Boot time memory retirement may occur later than ideal due to dependencies
> + *   on other libraries and drivers. This leaves a gap where bad memory may be
> + *   accessed during early boot stages.
> + *
> + * - Enough memory should be pre-allocated for each FRU record to be able to hold
> + *   the expected number of descriptor entries. This, mostly empty, record is
> + *   written to storage during init time. Subsequent writes to the same record
> + *   should allow the Platform to update the stored record in-place. Otherwise,
> + *   if the record is extended, then the Platform may need to perform costly memory
> + *   management operations on the storage. For example, the Platform may spend time
> + *   in Firmware copying and invalidating memory on a relatively slow SPI ROM.

That's a good thing to have here.

> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/cper.h>
> +#include <linux/ras.h>
> +
> +#include <acpi/apei.h>
> +
> +#include <asm/cpu_device_id.h>
> +#include <asm/mce.h>
> +
> +#pragma pack(1)

Is that some ugly thing to avoid adding __packed annotation to the
structure definitions below?

"GCC supports several types of pragmas, primarily in order to compile
code originally written for other compilers. Note that in general we do
not recommend the use of pragmas; See Declaring Attributes of Functions,
for further explanation. "

Oh, that 1 is something else:

-fpack-struct[=n]

    Without a value specified, pack all structure members together
    without holes. When a value is specified (which must be a small
    power of two), pack structure members according to this value,
    representing the maximum alignment (that is, objects with default
    alignment requirements larger than this are output potentially
    unaligned at the next fitting location.

So do I understand it correctly that struct members should be aligned to
2^1 bytes?

Grepping the tree, this looks like something BIOS does...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

