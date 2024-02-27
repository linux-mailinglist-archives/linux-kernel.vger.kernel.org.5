Return-Path: <linux-kernel+bounces-82769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEA0868970
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3FB1F248C2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC5F53804;
	Tue, 27 Feb 2024 06:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Qzur8aGv"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6811C537FC;
	Tue, 27 Feb 2024 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709017122; cv=none; b=hGtL0VvKz5Sv//A33eoimYMpsNGYqTwatheos4CIL+lRqlRhaJS/IplzSM/n6EUTcXexD6ijcx1tuAtQywOC2vImjCv7EE7hSxkafKlvo0N1w4BHWfv6mn6nRLttDJ6k8X0Y0Gwigt+Y+89guNrWIW2E1Jobil3Ar0rK1GAxyUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709017122; c=relaxed/simple;
	bh=BRtV5Vyn4aIy+xz+W1iBw7ybgHIQuX2mDWeZHMIzSSU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rE/AbHJe1UR86xDUvKMYgsJYs95Hdn5RNfRx2Aq1Y2JgZNXnP5jdxwMb7P/Po7RsMnL7Smw4Spnls4qpATwokZDeZriCUNe+SSdfAGibKpF3NRE0nf7G9/p0GMERLICjHqp+BEtMfcJek5kOO7oOPz7mqTihggghtGaLYM5JGgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Qzur8aGv; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a0265130d53d11eea528b71b88a53856-20240227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vC9iEcm/UVcOWv/4cFobjCd65sEBEJQ4MqFHTs+Wa6w=;
	b=Qzur8aGvsvZIWeyj/jFoU4of/xGIbIK4l1CpVw4ZuIBqMKqEkjUZyYa2bycq4AZSF4TVCCDJYHHtBubajO+vyxDP2VPkAm3gAR7wXqMxnnhBCKl9R9Qgm+RF2rcA6JlUEnqwhNDpz0ZYLDl88D1sc/OH5/jrqhIdwLKa5NwIvIU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d29753cf-a4e0-4717-a8b1-8adcaaee442c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:26ad41ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:817|102,TC:nil,Content:0|-5,EDM:-3,I
	P:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a0265130d53d11eea528b71b88a53856-20240227
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <haibo.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1377718937; Tue, 27 Feb 2024 14:58:35 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 27 Feb 2024 14:58:32 +0800
Received: from mszsdtlt102.gcn.mediatek.inc (10.16.4.142) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 27 Feb 2024 14:58:32 +0800
From: Haibo Li <haibo.li@mediatek.com>
To: <tnovak@fb.com>
CC: <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux@armlinux.org.uk>, <mark.rutland@arm.com>, <mingo@redhat.com>,
	<namhyung@kernel.org>, <peterz@infradead.org>, <will@kernel.org>,
	<xiaoming.yu@mediatek.com>, Haibo Li <haibo.li@mediatek.com>
Subject: [PATCH] ARM: perf: Use correct unwind info for tracepoint events
Date: Tue, 27 Feb 2024 14:58:28 +0800
Message-ID: <20240227065828.24598-1-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220921002446.3096120-1-tnovak@fb.com>
References: <20220921002446.3096120-1-tnovak@fb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-2.641300-8.000000
X-TMASE-MatchedRID: 6neWtTD7fHEIKTbeRIBWzDWQg1yejS72OlW1BAebvzDCfgNAnrDKhRla
	aIjbFjxvaxE9Kn8Vayr7znzPpwZYC45S9RIYp1E+VU3yVpaj3QwhauGyjTkf9YfAYSb4KlgZ94V
	amfVCBA6C6LDcSmpL7JD/QawhxLCoHaQ9wyk4fkCeAiCmPx4NwGmRqNBHmBve8JnRnNG2x81JKW
	4mDlJsMVgXepbcl7r7C1hm4mTjU4ykZlHOxJ/5IyzxsmTyithGEGtYF56J97pbcCRXcd0pINGpK
	guv+DtLld+Vz+P9nRtWu8gdZjpy+shfslRL5TighJVRlkc0uv5GBXoeyrLHXVBo425nomviD2Te
	XwRpghw5Asr9kfiuVn7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-2.641300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	06FEA735E92AB0FA45F424D20DA30440FB6FE2F3E550F1E46D4E31AEE356D07B2000:8
X-MTK: N

>Unwinding tends to work okay in practice 
>because perf_trace_* functions and their callers 
>usually have similar prologues.A common unwind insn sequence
>is "sp=fp, sp-=X, pop_r4_to_rN", so even if prologues don't match exactly,
>stored LR gets correctly popped off the stack.

It does not work well for all tracepoint events.
perf gets incomplete stacktrace after below commands
if CONFIG_ARM_UNWIND is on:

perf record -e block:block_rq_complete  -g sleep 10
perf script
'''
swapper     0 [000] 50333.927556: block:block_rq_complete:
 254,0 WSM () 376888 + 18 [0]
      804ac458 __traceiter_block_rq_complete+0x3c ([kernel.kallsyms])
      806bdd70 virtblk_done+0xc8 ([kernel.kallsyms])
      10 [unknown] ([unknown])
'''
In experiment,
ext4:ext4_da_write_begin,
block:block_rq_complete,
csd:csd_function_entry
suffer from above problem(maybe more).

As you said,it is caused by mismatched ARM_pc.

After apply similar patch,now perf gets correct stacktrace:
swapper     0 [000]   122.003800: block:block_rq_complete:
 254,0 WSM () 377064 + 16 [0]
 804acdd4 perf_trace_block_rq_completion+0x80 ([kernel.kallsyms])
 804ac2b0 __traceiter_block_rq_complete+0x3c ([kernel.kallsyms])
 804b9388 blk_update_request+0x64 ([kernel.kallsyms])
 804b9ab4 blk_mq_end_request+0x14 ([kernel.kallsyms])
 804c0bac blk_done_softirq+0x58 ([kernel.kallsyms])
 8010135c __softirqentry_text_start+0x138 ([kernel.kallsyms])
 801298f8 __irq_exit_rcu+0x58 ([kernel.kallsyms])
 801299a0 irq_exit+0x8 ([kernel.kallsyms])
 80100ba8 __irq_svc+0x88 ([kernel.kallsyms])
 80165628 arch_local_irq_enable+0x4 ([kernel.kallsyms])
 801659d8 do_idle+0xdc ([kernel.kallsyms])
 80165bf4 cpu_startup_entry+0x28 ([kernel.kallsyms])
 809c8764 kernel_init+0x0 ([kernel.kallsyms])

Acked-by: Haibo Li <haibo.li@mediatek.com>


