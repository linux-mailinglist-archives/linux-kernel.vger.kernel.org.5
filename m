Return-Path: <linux-kernel+bounces-151180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298C58AAAB0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF6F1C21F7B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ECC69DF4;
	Fri, 19 Apr 2024 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NWSKgK6d"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869CC38D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713516070; cv=none; b=XtnC9wm0wbhScw5TVOwX3x41QZEy0xMdo9jn+uykVz1s5/os41qOXFbzIiNyNbdxJeN5tJa1jC80l/a3OLDBEPpC5zWHo737JihPdFX4jUfsE8teXK8oRqQvZs9kEKvhIRGrUjgMkq51oAqA3vSWCQZE7IIZf+INLYtd36fipDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713516070; c=relaxed/simple;
	bh=0vRLovWl5KEIglf2cQQRWj/7uykUfs3cf4YIQ3mBWzY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKjXQ3pE/u1C9GiYiLGLVrcGnHFQWLfjWK1Uh8XY/MKyldF5ezG8jfyeVooSxgzMkk0Ch4loUrDKeNQkwGDpBzbvCzMzc7e4zmiAqaupec6/9S6/rj0ysYJgQPN4Gt3RmAyKlhhnxpQzK++ZUTX5YpABS+XoLKg9zI3EFRe5FYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NWSKgK6d; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8ac6095cfe2811eeb8927bc1f75efef4-20240419
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Drd4NR2IgVUtVWtpvgjFaxZvXBxY6PVf2F85FP9p1zg=;
	b=NWSKgK6dp+5WB/2jyj0KilVaP93YJ0etiXLHjtxvco/9EBe0h8+QV0LhiJz6saTBMio+D6SQLoaBCzKhdgVLC+FBxWVcVoYjSEbUfS5p1zYNha8AdesPiCEKe7dxvnSyLnWeIS/REVPx12HMNTKcbbNb9SXTYoDwz2kakLD6/3E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:4c71051b-f9fc-48b5-a29b-dbfea1f50aee,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:37c55f86-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 8ac6095cfe2811eeb8927bc1f75efef4-20240419
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <guoyong.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1882416861; Fri, 19 Apr 2024 16:40:57 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 19 Apr 2024 16:40:55 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 19 Apr 2024 16:40:54 +0800
From: Guoyong Wang <guoyong.wang@mediatek.com>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>, Theodore Ts'o <tytso@mit.edu>,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>, "Guoyong
 Wang" <guoyong.wang@mediatek.com>
Subject: Re: [PATCH] random: Fix the issue of '_might_sleep' function running in an atomic contex
Date: Fri, 19 Apr 2024 16:41:12 +0800
Message-ID: <20240419084112.4089-1-guoyong.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240417120217.3814215-2-Jason@zx2c4.com>
References: <20240417120217.3814215-2-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.737100-8.000000
X-TMASE-MatchedRID: EMyCvCfVN1Fq0U6EhO9EEya1MaKuob8PC/ExpXrHizwKogmGusPLb1wJ
	qhTPmfKkCe3jA2E8gwcQ3Uikp7+aivQYZJBBoF8RaK+MsTwM+1mBHKTJ+sfXGRxUkJPe1WBq3J8
	6v+pUS6ApTBCqN/Cg+/hQCrII02E2g9rU75/tZ02sMW2Z7ncq+6ns03+XRsVeRaXolgMyx3HGXV
	TaHB60j/wnrdJjIWkajIO1ikJs9mfDBNgbKIiiTEhEDfw/93BugGa+oYp5i6rwNtyWWbgV+usnO
	fzCil8nHhgMFd/39H00L7hY/wAQOnXo24sP1JtCsyNb+yeIRApdymZBcuGGRIfAYSb4KlgZkB8g
	HfQ6Qd3AOq0lI6oDZxYchAzpNtsT29aHfVG01jxbuDP8ZuCmXsMdI0UcXEHzTUobVis5Bb/Rl4E
	KYR0JsWbURhko7VE1Goq5PC0a+a2lTHNxJDwdpD3stoORN7tbh8Ytn75ClDOo+b+yOP0oGNYyy3
	/zxX0m4kYcXv9HvHLTMj+5r/4BdrxXyJr7SWpsZlRzaO1xpJ19LQinZ4QefIWH8POvJNOW4Hwn1
	pZzW/9XKaQsz6vtVJBlLa6MK1y4
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.737100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: F76AA4E8210E43E4BA69E16CC2B5BD02BA2B50B76B5ABE62256E4807296A4EBD2000:8
X-MTK: N

On Wed, 17 Apr 2024 14:01:11 +0200, Jason A. Donenfeld wrote:
> The entropy accounting changes a static key when the RNG has
> initialized, since it only ever initializes once. Static key changes,
> however, cannot be made from atomic context, so depending on where the
> last creditable entropy comes from, the static key change might need to
> be deferred to a worker.
> 
> Previously the code used the execute_in_process_context() helper
> function, which accounts for whether or not the caller is
> in_interrupt(). However, that doesn't account for the case where the
> caller is actually in process context but is holding a spinlock.
> 
> This turned out to be the case with input_handle_event() in
> drivers/input/input.c contributing entropy:
> 
>   [<ffffffd613025ba0>] die+0xa8/0x2fc
>   [<ffffffd613027428>] bug_handler+0x44/0xec
>   [<ffffffd613016964>] brk_handler+0x90/0x144
>   [<ffffffd613041e58>] do_debug_exception+0xa0/0x148
>   [<ffffffd61400c208>] el1_dbg+0x60/0x7c
>   [<ffffffd61400c000>] el1h_64_sync_handler+0x38/0x90
>   [<ffffffd613011294>] el1h_64_sync+0x64/0x6c
>   [<ffffffd613102d88>] __might_resched+0x1fc/0x2e8
>   [<ffffffd613102b54>] __might_sleep+0x44/0x7c
>   [<ffffffd6130b6eac>] cpus_read_lock+0x1c/0xec
>   [<ffffffd6132c2820>] static_key_enable+0x14/0x38
>   [<ffffffd61400ac08>] crng_set_ready+0x14/0x28
>   [<ffffffd6130df4dc>] execute_in_process_context+0xb8/0xf8
>   [<ffffffd61400ab30>] _credit_init_bits+0x118/0x1dc
>   [<ffffffd6138580c8>] add_timer_randomness+0x264/0x270
>   [<ffffffd613857e54>] add_input_randomness+0x38/0x48
>   [<ffffffd613a80f94>] input_handle_event+0x2b8/0x490
>   [<ffffffd613a81310>] input_event+0x6c/0x98
> 
> According to Guoyong, it's not really possible to refactor the various
> drivers to never hold a spinlock there. And in_atomic() isn't reliable.
> 
> So, rather than trying to be too fancy, just punt the change in the
> static key to a workqueue always. There's basically no drawback of doing
> this, as the code already needed to account for the static key not
> changing immediately, and given that it's just an optimization, there's
> not exactly a hurry to change the static key right away, so deferal is
> fine.
> 
> Reported-by: Guoyong Wang <guoyong.wang@mediatek.com>
> Cc: stable@vger.kernel.org
> Fixes: f5bda35fba61 ("random: use static branch for crng_ready()")
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Guoyong- can you test this and tell me whether it fixes the problem you
> were seeing? If so, I'll try to get this sent up for 6.9. -Jason
> 
>  drivers/char/random.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 456be28ba67c..2597cb43f438 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -702,7 +702,7 @@ static void extract_entropy(void *buf, size_t len)
>  
>  static void __cold _credit_init_bits(size_t bits)
>  {
> -       static struct execute_work set_ready;
> +       static DECLARE_WORK(set_ready, crng_set_ready);
>         unsigned int new, orig, add;
>         unsigned long flags;
>  
> @@ -718,8 +718,8 @@ static void __cold _credit_init_bits(size_t bits)
>  
>         if (orig < POOL_READY_BITS && new >= POOL_READY_BITS) {
>                 crng_reseed(NULL); /* Sets crng_init to CRNG_READY under base_crng.lock. */
> -               if (static_key_initialized)
> -                       execute_in_process_context(crng_set_ready, &set_ready);
> +               if (static_key_initialized && system_unbound_wq)
> +                       queue_work(system_unbound_wq, &set_ready);
>                 atomic_notifier_call_chain(&random_ready_notifier, 0, NULL);
>                 wake_up_interruptible(&crng_init_wait);
>                 kill_fasync(&fasync, SIGIO, POLL_IN);
> @@ -890,8 +890,8 @@ void __init random_init(void)
>  
>         /*
>          * If we were initialized by the cpu or bootloader before jump labels
> -        * are initialized, then we should enable the static branch here, where
> -        * it's guaranteed that jump labels have been initialized.
> +        * or workqueues are initialized, then we should enable the static
> +        * branch here, where it's guaranteed that these have been initialized.
>          */
>         if (!static_branch_likely(&crng_is_ready) && crng_init >= CRNG_READY)
>                 crng_set_ready(NULL);
> -- 
> 2.44.0

Hi Jason,

Thanks for your feedback. We concur with the proposed change and have verified that it works well 
in our tests. Next, I will provide a patch v2 for the changes discussed.


