Return-Path: <linux-kernel+bounces-45509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082ED8431A5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F8BCB217CD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED6E15C9;
	Wed, 31 Jan 2024 00:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZrHrQ4QY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SIYstLZy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F6GbEu3l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gd3zlcqa"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA16136A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706659476; cv=none; b=a+u+Amue5UTpPjTGXcjUcFGaLnwHvRlrD4juOJqfUQSF9j/vkb0v7c9hHRNvEJKxvXfh8ufvZ4C7ZlOIhziFzNe7M56KdpgIJ3X9/fi2Q4CN6VeYToT6bKsoXU9tKfNb5e6RczCtlz/uqcRbFQzq2a/QE6yQ52KokLS6gfVXiwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706659476; c=relaxed/simple;
	bh=rRqxO0gki4Gjc/MK2dXPYGxgGhxCZWwwQ4PVNhKZVGw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rvEz/7+CGMsBPwXXbLE6cOnsz4tSDpnM14eS+4ICpHliUOFiLvqiYqeNi8CsaG6Vo1tv9UTiuQ/BQ4VfQ3QEIxGpHYTbo1flQR09Mm3BPLFftlrBC5telmUv5epFnO++BG+gMS2P2QRZ49eKjpk83hAp4VBQl7B6EYCKpswF+/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZrHrQ4QY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SIYstLZy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F6GbEu3l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gd3zlcqa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id DBBA721FD0;
	Wed, 31 Jan 2024 00:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706659469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=0XeDypmWoFCxEAOSG8Ni46O4GVdc987V5RE1wFxEfLs=;
	b=ZrHrQ4QYC2PkGTYYJ+eRHVLnr1v0IZVgSGrq9LPeadWFLIlqA0mc5iEF93QACF9vXDvkds
	WD7kZ1fyIB5mJ5SxouCKu+i8MO1QC1/B0Zt98/Ze4tiGTrug2N+5ThyT7i6Nq7487D/CP3
	IATkfCQB/8T4c4QBEmPMdmsra6fVOpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706659469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=0XeDypmWoFCxEAOSG8Ni46O4GVdc987V5RE1wFxEfLs=;
	b=SIYstLZyd+10l7UljKL3sH8cYAMRaB2OsoBc/LpSAdSH79eyNDIr241SF2UoJSsQAfVksD
	nwE/DUCD4Tny9XCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706659468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=0XeDypmWoFCxEAOSG8Ni46O4GVdc987V5RE1wFxEfLs=;
	b=F6GbEu3ltqIflLc6pKAy/CffJjsm5XqUJ4MAp5rdUZM0p/CsYHqvIYX0nDHCr6oJ9O7FLk
	HTyzl4WOdSt9Ce/q+ZnPZH7LiiIamniSOxppIHcXTz9KrEUCdnWkEyatplNY89DxemiN9x
	DUfwxr1F2cT3d8sYhNP/Z+/G1t2IXIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706659468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=0XeDypmWoFCxEAOSG8Ni46O4GVdc987V5RE1wFxEfLs=;
	b=gd3zlcqa+lGfSBc7xwkdHsUG2ZLdfnJhctfbhkZ5ERqiQaq4YtDDUK3VZ7K5Ej9hUSjxv4
	1RGCSFc2MBZAlRAQ==
Date: Wed, 31 Jan 2024 01:04:28 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: x86@kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86: don't reserve SETUP_RNG_SEED in e820
Message-ID: <ZbmOjKnARGiaYBd5@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.10 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_MATCH_FROMTLD(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.10

SETUP_RNG_SEED in setup_data is supplied by kexec and should
not be reserved in the e820 map.

Doing so reserves 16 bytes of RAM when booting with kexec.
(16 bytes because data->len is zeroed by parse_setup_data so only
sizeof(setup_data) is reserved.)

When kexec is used repeatedly, each boot adds two entries in the
kexec-provided e820 map as the 16-byte range splits a larger
range of usable memory. Eventually all of the 128 available entries
get used up. The next split will result in losing usable memory
as the new entries cannot be added to the e820 map.

Fixes: 68b8e9713c8e ("x86/setup: Use rng seeds from setup_data")
Signed-off-by: Jiri Bohac <jbohac@suse.cz>
---
 arch/x86/kernel/e820.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 91ade749f184..7be1362a31aa 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1018,10 +1018,12 @@ void __init e820__reserve_setup_data(void)
 		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
 
 		/*
-		 * SETUP_EFI and SETUP_IMA are supplied by kexec and do not need
-		 * to be reserved.
+		 * SETUP_EFI, SETUP_IMA and SETUP_RNG_SEED are supplied by
+		 * kexec and do not need to be reserved.
 		 */
-		if (data->type != SETUP_EFI && data->type != SETUP_IMA)
+		if (data->type != SETUP_EFI &&
+		    data->type != SETUP_IMA &&
+		    data->type != SETUP_RNG_SEED)
 			e820__range_update_kexec(pa_data,
 						 sizeof(*data) + data->len,
 						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


