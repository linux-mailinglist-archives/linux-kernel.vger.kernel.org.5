Return-Path: <linux-kernel+bounces-107299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D2987FAB9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B577D1F22304
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626067CF18;
	Tue, 19 Mar 2024 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lYIHsT0V"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2241D51C28
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840679; cv=none; b=pJsaXLJ6xO9f+2wMYEMzkNAUPtK8HJuK4mr/+0vqO4H2z0GJ77Tqrkn5nLe5mN+HDHFCQrjxBEjI6nVQp0OMs7iGb+Qpao/XZ8HcV6XrTFVznBW4qvBxlDCDyhSOGQe3BRPDVlB69eZ4+5vFiewUtJsdP2yqEycD9s4rRFxyaeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840679; c=relaxed/simple;
	bh=SY1uQyt8vSR2v8hUPxa5exu6uGYaOX8KaWkKj+cinQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSlwo9H73C9HS1h6TQ2Os0ssJW1G6ifI7Famb1p1VrB1mbckwZgz4dQd+6fuzHLhFt48EotRSDszk1gSEbPunddp89Ew/Nw6tuR3N1j7tB15S+aSTEs7aahYlHYmwiq4XRiivSCFcNsTRCgqLxwKxE3TwyGvnpAi/n/rf+Vbzvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lYIHsT0V; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6d0cc3a0e5d311ee935d6952f98a51a9-20240319
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VQki1eI8SVL7vuknmmrJsXB51tDn6Ie+ozgQSfZSEjw=;
	b=lYIHsT0V9fBsEoJX7/h7vSysOBHnUiQ3MGSiKFaIyaULp3g2ClQzTPNq4ld9dl39Or2Zw8Ki5Tlh5n2F3eMCO5cd+HRH8NdVJZIg/DEHce/yCsjQYmV3XjJvn86h8w9SxKuRLYKJVfHKVXzT4KE4zWyplE0UAOc7/Vcaq95NzeY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:83c72e98-dede-4092-a416-a30ed9b27c0c,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:1,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-4
X-CID-META: VersionHash:6f543d0,CLOUDID:26d02c85-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 50,UGT
X-CID-BAS: 50,UGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6d0cc3a0e5d311ee935d6952f98a51a9-20240319
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <guoyong.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1627979646; Tue, 19 Mar 2024 17:31:12 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Mar 2024 17:31:10 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Mar 2024 17:31:09 +0800
From: Guoyong Wang <guoyong.wang@mediatek.com>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>, Theodore Ts'o <tytso@mit.edu>,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>, "Guoyong
 Wang" <guoyong.wang@mediatek.com>
Subject: Re: [PATCH] random: Fix the issue of '_might_sleep' function running in an atomic contex
Date: Tue, 19 Mar 2024 17:30:55 +0800
Message-ID: <20240319093055.3252-1-guoyong.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <Zfidal8CEZStp3R7@zx2c4.com>
References: <Zfidal8CEZStp3R7@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.984400-8.000000
X-TMASE-MatchedRID: scwq2vQP8OFq0U6EhO9EE97SWiiWSV/1jLOy13Cgb4+qvcIF1TcLYHG3
	IDkkj7AXYYnmnL3l3X94CDdDyzWksYoNUbXqhOogEdFsavUQKAeVq+okl1rYD4m3+evajL3wMTM
	ELdGCO1o7+AqDyYkkE7zhRZbj1fFhMRXV8lvz/l2GuzokAQvW7hLXa2P1m93zpbyIsT/ya8HwgB
	OtAk1RzXjz1W+ftiuwTkPoEKaGtfHN81HPMxpUIJ4CIKY/Hg3AGdQnQSTrKGPZs3HUcS/scCq2r
	l3dzGQ1rmN9FZqI8KahkbtarVEBrUNxfO5fJyW5aZTIZgj8uzW+tXmB1d47djB5zPBa/PuxMGNP
	4LoAdn2LY5R/XxIRza5kCR6qopRbE1GeEHxFMW90BNB20+SxH7f8mJY57oZddJaBDYald1mHO0t
	VYDV4T0MMprcbiest
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.984400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: D8CB58CF87B07B83D4FF05979176682EBF85968089EDCB2E320408EFDFA00B6C2000:8
X-MTK: N

On Mon, 18 Mar 2024 21:00:42 +0100, Jason A. Donenfeld wrote:
> I'm wondering, though, rather than introducing a second function, maybe
> execute_in_process_context() should just gain a `&& !in_atomic()`.
> That'd make things a bit simpler.  

> However, I'm pretty sure in_atomic() isn't actually a reliable way of
> determining that, depending on config. So maybe this should just call
> the worker always (if system_wq isn't null).

> Alternatively, any chance the call to add_input_randomness() could be
> moved outside the spinlock, or does this not look possible?

Hi Jason,

Thanks for your suggestions. 

I am inclined to accept your second suggestion. My reluctance to accept 
the first is due to the concern that "&& !in_atomic()" could potentially 
alter the original meaning of the 'execute_in_process_context' interface. 
Regarding the third suggestion, modifying the logic associated with 'input' 
is not recommended.

