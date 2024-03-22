Return-Path: <linux-kernel+bounces-111337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F973886ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E281F22FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80233FB1E;
	Fri, 22 Mar 2024 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BH9EoFAh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uDqzv2c8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3B03F9D3;
	Fri, 22 Mar 2024 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105164; cv=none; b=I7jbpXLlvhvXV93P2KYegj63qjpiKgINpjPQzinNJ6MH0LG10QRYr1C5A/GqFoLz26QYoxWYMyby1F1H8IJeLS7WneOlTyXRxfx58z1SjeNBTtLvItPcV20kXWAZmr0eIc/VTOUtjXBn04euQHqRttKySVSQ0QL470ctLSrFOv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105164; c=relaxed/simple;
	bh=dai3Xz5wzRtRT0lWJ11EnIuZzgBwMopKTyJcyTZEMyY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q2L3KKrYbyq/GrEp+x7/GE1MshqTouq78lc57WJ+6FL9nGBENU56TpsJdz2miFh+y58K1mn4uweoA/7MahknpFYr32TBkc3Hdxe6/y7YPH3NMTXzFM2qPG9I5SiYYSoBfi1FmWNmNBZHNoVe5XH//RvKFL6s5ZwqjzIYr/L28nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BH9EoFAh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uDqzv2c8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 10:59:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711105161;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLwdPRNNuZ5nU1ClEQFU5fW1R3tmWVNtHDAtg0XsDkU=;
	b=BH9EoFAhXMHXYfwCFm3oxADFSC3cMdOirbbSNWVmLQuauNmxUVaucMJT6ORs7r/caqcaVQ
	+PAt8OAHf/PykwO4LdGyGE5if8bkX7oYtVj2HmDE24CHlPYj4FvKr5Ur2tsc8OIeEQhgvW
	HRqKj1irkcZSbhvWlP/JlerbfCJx6JnQrpGiO9HM4dUToZ4LZzVp7M+eo/l723rtNcus65
	R+CuqfdGI6wsKAooKBzocQw1kGRQ/Y+wPf3t5jJV8otmNFUaNZEoDCFvxh4UzvasYh3P8N
	qHPnXf2yuTIN+2gkfEmtK7hVtYo0/iWW38rimfAGo/VqfUuR5T9HUyfB3vUrfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711105161;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLwdPRNNuZ5nU1ClEQFU5fW1R3tmWVNtHDAtg0XsDkU=;
	b=uDqzv2c8+fl2/C3ENmzhA8CDcKdwdpFg9DBUaMCgiGE5h0ipA613H8Rvujbet/V6PvsEpV
	7Ed1M0N3Jvm09eAA==
From: "tip-bot2 for Dave Young" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/kexec: Do not update E820 kexec table for setup_data
Cc: Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Jiri Bohac <jbohac@suse.cz>, Eric DeVolder <eric.devolder@oracle.com>,
 Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
 Kees Cook <keescook@chromium.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <Zf0T3HCG-790K-pZ@darkstar.users.ipa.redhat.com>
References: <Zf0T3HCG-790K-pZ@darkstar.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171110516060.10875.9405979047736972683.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     fc7f27cda843ce294c71767d42b9d8abd015d7cb
Gitweb:        https://git.kernel.org/tip/fc7f27cda843ce294c71767d42b9d8abd015d7cb
Author:        Dave Young <dyoung@redhat.com>
AuthorDate:    Fri, 22 Mar 2024 13:15:08 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Mar 2024 10:07:45 +01:00

x86/kexec: Do not update E820 kexec table for setup_data

crashkernel reservation failed on a Thinkpad t440s laptop recently.
Actually the memblock reservation succeeded, but later insert_resource()
failed.

Test steps:
  kexec load -> /* make sure add crashkernel param eg. crashkernel=160M */
    kexec reboot ->
        dmesg|grep "crashkernel reserved";
            crashkernel memory range like below reserved successfully:
              0x00000000d0000000 - 0x00000000da000000
        But no such "Crash kernel" region in /proc/iomem

The background story:

Currently the E820 code reserves setup_data regions for both the current
kernel and the kexec kernel, and it inserts them into the resources list.

Before the kexec kernel reboots nobody passes the old setup_data, and
kexec only passes fresh SETUP_EFI/SETUP_IMA/SETUP_RNG_SEED if needed.
Thus the old setup data memory is not used at all.

Due to old kernel updates the kexec e820 table as well so kexec kernel
sees them as E820_TYPE_RESERVED_KERN regions, and later the old setup_data
regions are inserted into resources list in the kexec kernel by
e820__reserve_resources().

Note, due to no setup_data is passed in for those old regions they are not
early reserved (by function early_reserve_memory), and the crashkernel
memblock reservation will just treat them as usable memory and it could
reserve the crashkernel region which overlaps with the old setup_data
regions. And just like the bug I noticed here, kdump insert_resource
failed because e820__reserve_resources has added the overlapped chunks
in /proc/iomem already.

Finally, looking at the code, the old setup_data regions are not used
at all as no setup_data is passed in by the kexec boot loader. Although
something like SETUP_PCI etc could be needed, kexec should pass
the info as new setup_data so that kexec kernel can take care of them.
This should be taken care of in other separate patches if needed.

Thus drop the useless buggy code here.

Signed-off-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: Eric DeVolder <eric.devolder@oracle.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/Zf0T3HCG-790K-pZ@darkstar.users.ipa.redhat.com
---
 arch/x86/kernel/e820.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index b66f540..6f1b379 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1016,17 +1016,6 @@ void __init e820__reserve_setup_data(void)
 
 		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
 
-		/*
-		 * SETUP_EFI, SETUP_IMA and SETUP_RNG_SEED are supplied by
-		 * kexec and do not need to be reserved.
-		 */
-		if (data->type != SETUP_EFI &&
-		    data->type != SETUP_IMA &&
-		    data->type != SETUP_RNG_SEED)
-			e820__range_update_kexec(pa_data,
-						 sizeof(*data) + data->len,
-						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-
 		if (data->type == SETUP_INDIRECT) {
 			len += data->len;
 			early_memunmap(data, sizeof(*data));
@@ -1038,12 +1027,9 @@ void __init e820__reserve_setup_data(void)
 
 			indirect = (struct setup_indirect *)data->data;
 
-			if (indirect->type != SETUP_INDIRECT) {
+			if (indirect->type != SETUP_INDIRECT)
 				e820__range_update(indirect->addr, indirect->len,
 						   E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-				e820__range_update_kexec(indirect->addr, indirect->len,
-							 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-			}
 		}
 
 		pa_data = pa_next;
@@ -1051,7 +1037,6 @@ void __init e820__reserve_setup_data(void)
 	}
 
 	e820__update_table(e820_table);
-	e820__update_table(e820_table_kexec);
 
 	pr_info("extended physical RAM map:\n");
 	e820__print_table("reserve setup_data");

