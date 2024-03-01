Return-Path: <linux-kernel+bounces-88927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF8D86E88D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99551C21378
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA0937153;
	Fri,  1 Mar 2024 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AuhXK4T4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YKQQFxEZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360DC27446;
	Fri,  1 Mar 2024 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318243; cv=none; b=dkvNLBJ6b1a/iZF74xCj7vIrwHDomDi95le2+9buFipQsm+9IKWhH+kErLoRy6Elmg73dt5aIEpoB1j1rrSpfaXEbYk+8wpoucSkan3i1Z9pDb5rFLjpCSPxUWJC8aftfjoH12R4E6jxIaudC/dftO3EAwvDFS/llRBJq2YWtRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318243; c=relaxed/simple;
	bh=tLz2ila8AXbLQK+R/ALei/RIv7nTsOOt25XgvgEz+7k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r8/X+l1c6pGCUhLXkBwNlBuE3/Fo801joRLlo5RA25RVBnu4bz4XjEZnGz1DnYv87qyaMJr3EpIMvAEf7MXhS/o3JTVlVXZ7ybKesROgXpGVFwN3Ig/gaZPJXhrhRPKA58l0xD1e42IfArf5/ZPJ3BOhUfyTFTq1kKiU7g3eV8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AuhXK4T4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YKQQFxEZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 Mar 2024 18:37:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709318239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jj4sN7cWDxyUWyuDz4KI62wudm769lIrwf7+u+SdHbg=;
	b=AuhXK4T4F8k9ZH/br6/SEP+g1xVXojbWR8XGLQFdhY7+/y3tCYc7BSFWdmhaIbZxIXpfQA
	VexTRGm4zOMM3WhYc2fojsCEFmSMBmifnwJnGxA6i4aGgdMSiSU3+mQUxg8h33OMUD7X/g
	TgKs/4YG1iDz0KUP+mnaaJyFxlGZjnywpG9A61D8bvCww88K6Pp5Vn67869nZHL9wetSd7
	SI7XJB41A8xTgQXLGoMOePC3xOHoypD3ULElg0oIHWKZW1z0IQ4mKCma4L6Py2UbvWaEbn
	qTAHyejLC5fAvAPjkseApi9ZFpJEW6zJ1DuNUNNpN4gfyby5rRr+RcGEO0+ihg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709318239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jj4sN7cWDxyUWyuDz4KI62wudm769lIrwf7+u+SdHbg=;
	b=YKQQFxEZUMqCfHu7Bj9UCi6N6EkOrqNspQi5fTja3UdBcFzVyChPsKEhv8mvlVgBLHHLNx
	oepeoEX60EBxWBDw==
From: "tip-bot2 for Jiri Bohac" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/e820: Don't reserve SETUP_RNG_SEED in e820
Cc: Jiri Bohac <jbohac@suse.cz>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,  <stable@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <ZbmOjKnARGiaYBd5@dwarf.suse.cz>
References: <ZbmOjKnARGiaYBd5@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170931823840.398.408977952832718323.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7fd817c906503b6813ea3b41f5fdf4192449a707
Gitweb:        https://git.kernel.org/tip/7fd817c906503b6813ea3b41f5fdf4192449a707
Author:        Jiri Bohac <jbohac@suse.cz>
AuthorDate:    Wed, 31 Jan 2024 01:04:28 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 01 Mar 2024 10:27:20 -08:00

x86/e820: Don't reserve SETUP_RNG_SEED in e820

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
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/ZbmOjKnARGiaYBd5@dwarf.suse.cz
---
 arch/x86/kernel/e820.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index fb8cf95..b66f540 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1017,10 +1017,12 @@ void __init e820__reserve_setup_data(void)
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

