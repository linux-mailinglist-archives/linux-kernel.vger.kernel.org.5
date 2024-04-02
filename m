Return-Path: <linux-kernel+bounces-127529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2A1894D38
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2AA1F210B7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F063D968;
	Tue,  2 Apr 2024 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="O88CmPZU"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C5945007
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712045560; cv=none; b=u2N1ktF4ybuSKQ35R1Cux2lgNCCuUMCx1x2r93uhRlyjEPeJ5bYcS/qSZaiyWJPxLTlA0FIe+agIbC6u00c40DEoVQ7sh2b+OnznusrrMO023x2t6g7JJSA936ssjO627762BPKbQQmWENqyKenz6S/xwjshcK17QwcV/M5TVnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712045560; c=relaxed/simple;
	bh=5lhu8bkA4ICih9Qc8yz1RpFgwQC1a6ZaDAdiBJ/ytt4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMjewVja1GE7EW8N4xKlnEmEg7HlunIGFPdqG8HDe+37YGXmCpOoIMR14k6sxe6EaYBmx6wa4tTZ03UqSgUX9FPD4JMtvs1WFBVdlRgU5bikuIH5CloNyeVpBKjxESYoZ7btzUJ2TpRll7uGQM4ei2eRZ92pQhNtzKHYL5bd0o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=O88CmPZU; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bde17668f0c811ee935d6952f98a51a9-20240402
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=d4nRvJ0c59zUyR8ezgAHKzFD+7G8QnVomCEdYphyOZA=;
	b=O88CmPZUqkw0d5Ku+niN01bdy5m91N9rFlOXocdLkbhoWEzGPET0ZydKqWl3YBaa7clFW5oK0+/HO32jEveKw9E4GXxCb81AUfWjlca6DX6Z2EhfIAin8hKofh90+UxkIIYGyNghGMaAQ5kaKwgdbN5iX1PoFj54+lRo3avLZHg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:eee8753e-3c77-4049-a53d-ee9db0624979,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:d8331f91-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bde17668f0c811ee935d6952f98a51a9-20240402
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <guoyong.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1646343256; Tue, 02 Apr 2024 16:12:26 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 2 Apr 2024 16:12:25 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 2 Apr 2024 16:12:24 +0800
From: Guoyong Wang <guoyong.wang@mediatek.com>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>, Theodore Ts'o <tytso@mit.edu>,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>, "Guoyong
 Wang" <guoyong.wang@mediatek.com>
Subject: Re: [PATCH] random: Fix the issue of '_might_sleep' function running in an atomic contex
Date: Tue, 2 Apr 2024 16:12:14 +0800
Message-ID: <20240402081214.2723-1-guoyong.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240320090242.10318-1-guoyong.wang@mediatek.com>
References: <20240320090242.10318-1-guoyong.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--11.181500-8.000000
X-TMASE-MatchedRID: VfovoVrt/oZq0U6EhO9EEya1MaKuob8PC/ExpXrHizyo+b+yOP0oGAAt
	9g7dvMC1IKdjJZRyIZmrMtdnoedbNxHzG0HT5tBb/1aBDnIV4ikWTveLitVUgcwHSQ+yXjTD/VQ
	G3oVfx34Pu+MfgwheR2w5+V5bC8rHsEBAuoaUqK8QNC45RlqcS167veYUroY0yWCL+8tLbvaPdB
	sWkfHN7SQPHPUuX+yXwFVmU96WjVi8f06ZoOZQY0KcYi5Qw/RVQrO4XR6BRQNgg+UjPGL1RUTNC
	ucTZFZapt+BKnbPggH9KP9acIz8sx8TzIzimOwPVnRXm1iHN1bEQdG7H66TyH4gKq42LRYkIxUs
	k7Y5zqotD17eyPoKssqg3Bx5SzilnGVR9vPBa4t+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.181500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 06C58068D73256DA76C0B51F75B979DDFF4EDD0C74A25AEFEA31C055BBFF53672000:8
X-MTK: N

On Web, 20 Mar 2024 02:09:21 +0100, Jason A. Donenfeld wrote:
>> Hi Jason,
>> 
>> Thanks for your suggestions. 
>> 
>> I am inclined to accept your second suggestion. My reluctance to accept 
>> the first is due to the concern that "&& !in_atomic()" could potentially 
>> alter the original meaning of the 'execute_in_process_context' interface. 
>> Regarding the third suggestion, modifying the logic associated with 'input' 
>> is not recommended.
> 
> Doesn't something like the below seem simplest? Just move the call out
> of the spinlock and we're done.
> 
> diff --git a/drivers/input/input-core-private.h b/drivers/input/input-core-private.h
> index 116834cf8868..717f239e28d0 100644
> --- a/drivers/input/input-core-private.h
> +++ b/drivers/input/input-core-private.h
> @@ -10,7 +10,7 @@
>  struct input_dev;
> 
>  void input_mt_release_slots(struct input_dev *dev);
> -void input_handle_event(struct input_dev *dev,
> +bool input_handle_event(struct input_dev *dev,
>  unsigned int type, unsigned int code, int value);
> 
>  #endif /* _INPUT_CORE_PRIVATE_H */
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index f71ea4fb173f..2faf46218c66 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -391,20 +391,22 @@ static void input_event_dispose(struct input_dev *dev, int disposition,
>  }
>  }
> 
> -void input_handle_event(struct input_dev *dev,
> +bool input_handle_event(struct input_dev *dev,
>  unsigned int type, unsigned int code, int value)
>  {
>  int disposition;
> +bool should_contribute_to_rng = false;
> 
>  lockdep_assert_held(&dev->event_lock);
> 
>  disposition = input_get_disposition(dev, type, code, &value);
>  if (disposition != INPUT_IGNORE_EVENT) {
>  if (type != EV_SYN)
> -add_input_randomness(type, code, value);
> +should_contribute_to_rng = true;
> 
>  input_event_dispose(dev, disposition, type, code, value);
>  }
> +return should_contribute_to_rng;
>  }
> 
>  /**
> @@ -428,12 +430,15 @@ void input_event(struct input_dev *dev,
>   unsigned int type, unsigned int code, int value)
>  {
>  unsigned long flags;
> +bool should_contribute_to_rng;
> 
>  if (is_event_supported(type, dev->evbit, EV_MAX)) {
> 
>  spin_lock_irqsave(&dev->event_lock, flags);
> -input_handle_event(dev, type, code, value);
> +should_contribute_to_rng = input_handle_event(dev, type, code, value);
>  spin_unlock_irqrestore(&dev->event_lock, flags);
> +if (should_contribute_to_rng)
> +add_input_randomness(type, code, value);
>  }
>  }
>  EXPORT_SYMBOL(input_event);

Hi Jason,

As I mentioned last time: Your solution may not be applicable when 'input_event' is executed in users spinlock. 
What are you thoughts on this? I'm looking forward to your suggestions so we can reach an agreement and expedite 
the upstream process, Thanks!


