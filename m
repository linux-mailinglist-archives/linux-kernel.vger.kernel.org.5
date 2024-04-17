Return-Path: <linux-kernel+bounces-147870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E49128A7ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2B21F2224F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF667482;
	Wed, 17 Apr 2024 02:58:36 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E5394;
	Wed, 17 Apr 2024 02:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713322716; cv=none; b=ZWv//iWBMIzk9wZLbcAQNwZf/TOgDsniZP0GvEeUjKRZuAYRJsk4u52Vtn0v9AbQoKbZytaHj3s3STpTDiw8o+ixErNofSekIPtpDxNeDHPLvnpKUKnjdU9Cgu3y588zl45ryquzrB5ePsd/d0hjNU/K5ZCU8af2zdMUhDt4/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713322716; c=relaxed/simple;
	bh=Gj57y4DEJZXM6RahWTXAxrkEjxXLIt6EopYgzwFzygg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fh3XR32DO/pNYh6St6d9Y1JAi6E1BBmtk3MfkcdBna7fVO5BOktZDav73CBCxTj69zlEbCoRypWGuaQF3pnky1agEm+Cn7CjyhZ33wmSjQY3CiFZJM4dP+ABDYmNYeUKy+SyWJ3QEVG9Q2ZP25S10OXP7O0cQNr3Mig9XGDw0Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9b3ac116fc6511ee9305a59a3cc225df-20240417
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:fa87ce5d-9d3d-4ad2-8569-f389b266c00d,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:12,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-3
X-CID-INFO: VERSION:1.1.37,REQID:fa87ce5d-9d3d-4ad2-8569-f389b266c00d,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:12,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-3
X-CID-META: VersionHash:6f543d0,CLOUDID:70be5267b51096b2a158101af600ca09,BulkI
	D:240417105304FRVF15SB,BulkQuantity:0,Recheck:0,SF:66|38|25|16|19|44|102,T
	C:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, DN_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-UUID: 9b3ac116fc6511ee9305a59a3cc225df-20240417
X-User: tianyaxiong@kylinos.cn
Received: from tian-thinkpad-x390.. [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 637547585; Wed, 17 Apr 2024 10:53:02 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: catalin.marinas@arm.com,
	will@kernel.org,
	rppt@kernel.org
Cc: keescook@chromium.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	akpm@linux-foundation.org,
	ryan.roberts@arm.com,
	wangkefeng.wang@huawei.com,
	ardb@kernel.org,
	david@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>,
	xiongxin <xiongxin@kylinos.cn>
Subject: [PATCH v3] arm64: hibernate: Fix level3 translation fault in swsusp_save()
Date: Wed, 17 Apr 2024 10:52:48 +0800
Message-Id: <20240417025248.386622-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On ARM64 machines using UEFI, if can_set_direct_map() return false by
setting some CONFIGS in kernel build or grub,such as
NO CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT、NO CONFIG_KFENCE
NO CONFIG_RODATA_FULL_DEFAULT_ENABLED.Also with setting rodata=off、
debug_pagealloc=off in grub and NO CONFIG_KFENCE.
swsusp_save() will fail due to can't finding the map table under the
nomap memory.such as:

[   48.532162] Unable to handle kernel paging request at virtual address ffffff8000000000
[   48.532162] Mem abort info:
[   48.532162]   ESR = 0x0000000096000007
[   48.532162]   EC = 0x25: DABT (current EL), IL = 32 bits
[   48.532162]   SET = 0, FnV = 0
[   48.532162]   EA = 0, S1PTW = 0
[   48.532162]   FSC = 0x07: level 3 translation fault
[   48.532162] Data abort info:
[   48.532162]   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
[   48.532162]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   48.532162]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   48.532162] swapper pgtable: 4k pages, 39-bit VAs, pgdp=00000000eeb0b000
[   48.532162] [ffffff8000000000] pgd=180000217fff9803, p4d=180000217fff9803, pud=180000217fff9803, pmd=180000217fff8803, pte=0000000000000000
[   48.532162] Internal error: Oops: 0000000096000007 [#1] SMP
[   48.532162] Internal error: Oops: 0000000096000007 [#1] SMP
[   48.532162] Modules linked in: xt_multiport ipt_REJECT nf_reject_ipv4 xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_filter bpfilter rfkill at803x snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg dwmac_generic stmmac_platform snd_hda_codec stmmac joydev pcs_xpcs snd_hda_core phylink ppdev lp parport ramoops reed_solomon ip_tables x_tables nls_iso8859_1 vfat multipath linear amdgpu amdxcp drm_exec gpu_sched drm_buddy hid_generic usbhid hid radeon video drm_suballoc_helper drm_ttm_helper ttm i2c_algo_bit drm_display_helper cec drm_kms_helper drm
[   48.532162] CPU: 0 PID: 3663 Comm: systemd-sleep Not tainted 6.6.2+ #76
[   48.532162] Source Version: 4e22ed63a0a48e7a7cff9b98b7806d8d4add7dc0
[   48.532162] Hardware name: Greatwall GW-XXXXXX-XXX/GW-XXXXXX-XXX, BIOS KunLun BIOS V4.0 01/19/2021
[   48.532162] pstate: 600003c5 (nZCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   48.532162] pc : swsusp_save+0x280/0x538
[   48.532162] lr : swsusp_save+0x280/0x538
[   48.532162] sp : ffffffa034a3fa40
[   48.532162] x29: ffffffa034a3fa40 x28: ffffff8000001000 x27: 0000000000000000
[   48.532162] x26: ffffff8001400000 x25: ffffffc08113e248 x24: 0000000000000000
[   48.532162] x23: 0000000000080000 x22: ffffffc08113e280 x21: 00000000000c69f2
[   48.532162] x20: ffffff8000000000 x19: ffffffc081ae2500 x18: 0000000000000000
[   48.532162] x17: 6666662074736420 x16: 3030303030303030 x15: 3038666666666666
[   48.532162] x14: 0000000000000b69 x13: ffffff9f89088530 x12: 00000000ffffffea
[   48.532162] x11: 00000000ffff7fff x10: 00000000ffff7fff x9 : ffffffc08193f0d0
[   48.532162] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 : 0000000000000001
[   48.532162] x5 : ffffffa0fff09dc8 x4 : 0000000000000000 x3 : 0000000000000027
[   48.532162] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 000000000000004e
[   48.532162] Call trace:
[   48.532162]  swsusp_save+0x280/0x538
[   48.532162]  swsusp_arch_suspend+0x148/0x190
[   48.532162]  hibernation_snapshot+0x240/0x39c
[   48.532162]  hibernate+0xc4/0x378
[   48.532162]  state_store+0xf0/0x10c
[   48.532162]  kobj_attr_store+0x14/0x24

This issue can be reproduced in QEMU using UEFI when booting with
rodata=off、debug_pagealloc=off in grub and NO CONFIG_KFENCE.

This is because in swsusp_save()->copy_data_pages()->page_is_saveable(),
kernel_page_present() presumes that a page is present when can_set_direct_map()
returns false even for NOMAP ranges.So NOMAP pages will saved in after,and then
cause level3 translation fault in this pages.

Since the NOMAP regions are now marked as PageReserved(), pfn walkers
and the rest of core mm will treat them as unusable memory. So this
regions should not saved in hibernation.

This problem may cause by changes to pfn_valid() logic in commit
a7d9f306ba70 ("arm64: drop pfn_valid_within() and simplify pfn_valid()").

Reference ohter arch architecture,drop the !can_set_direct_map() condition
in kernel_page_present().So in page_is_savable(),these page will skiped.

Fixes: a7d9f306ba70 ("arm64: drop pfn_valid_within() and simplify pfn_valid()")

Suggested-by: Mike Rapoport <rppt@kernel.org>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Co-developed-by: xiongxin <xiongxin@kylinos.cn>
Signed-off-by: xiongxin <xiongxin@kylinos.cn>
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 arch/arm64/mm/pageattr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 0c4e3ecf989d..0e270a1c51e6 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -219,9 +219,6 @@ bool kernel_page_present(struct page *page)
 	pte_t *ptep;
 	unsigned long addr = (unsigned long)page_address(page);
 
-	if (!can_set_direct_map())
-		return true;
-
 	pgdp = pgd_offset_k(addr);
 	if (pgd_none(READ_ONCE(*pgdp)))
 		return false;
-- 
2.34.1


