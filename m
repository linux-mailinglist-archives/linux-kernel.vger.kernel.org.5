Return-Path: <linux-kernel+bounces-108669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE25880E35
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07CB1F2457E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3843A1BE;
	Wed, 20 Mar 2024 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="czWUnAt7"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A558E11720
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925394; cv=none; b=chjwKaVZWP43aaZfC0c8SILFHrGmZ8nggUWNPUAvkAjvmkxJ3yYCPzhEAJ6xoC7ILZjkggF9rGbstDIxjU5geTIdz9a3v2L18Ep9T5nuQA5bXFwnk3JI7AIIU1yvEwuDTE63Wf6FFp7qZzfCtMNBq7WTpa60/P6HPVGU7zp+u5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925394; c=relaxed/simple;
	bh=rSSBa2WZ0ivmSNOdA+rs77TZqcNDiDvF8dF8/aG6a+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRbUXnFpr+3Nx3xI/rLHd4EDsVoUQ2Zdhu21498H/6ahR3zrKwGHRpdupnmk7AWRPsmmYqY30zfyXUK5ZLiGRMe/k0oNNkkAKLuL4Gsfe80h9n4LqcnxGQ6+9KIwyHx3JCiuTvhy+l9Gf871acbtbKcrrvsbMRSurqdEI2kPgQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=czWUnAt7; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a5f40d5ce69811eeb8927bc1f75efef4-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=lqxL/EcqF65J4vebvy58T+0FP8K0sKm33BQZcXi+Eck=;
	b=czWUnAt7EWvLxTyFgdKolvOfcx3TlpznMEgc3vg/NxO6ej3SgSEiPwRVXWJTpmaA3DW8QwHXPQGUy/NqUXvB6sowPqEsLTqNNcbc9IQH4LUqE2SjEs3osLEeGAu4IK3a37TUMZGE4sW42N6a+lHDxft9uss3aeeAMEY1iIMZiLs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:bea5db0c-27c7-488c-8442-74be515d4624,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:3da41c00-c26b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a5f40d5ce69811eeb8927bc1f75efef4-20240320
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <guoyong.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1447634097; Wed, 20 Mar 2024 17:02:58 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Mar 2024 17:02:57 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Mar 2024 17:02:56 +0800
From: Guoyong Wang <guoyong.wang@mediatek.com>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>, Theodore Ts'o <tytso@mit.edu>,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>, "Guoyong
 Wang" <guoyong.wang@mediatek.com>
Subject: Re: [PATCH] random: Fix the issue of '_might_sleep' function running in an atomic contex
Date: Wed, 20 Mar 2024 17:02:42 +0800
Message-ID: <20240320090242.10318-1-guoyong.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <Zfo3QUFEy4wHkLEB@zx2c4.com>
References: <Zfo3QUFEy4wHkLEB@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.270600-8.000000
X-TMASE-MatchedRID: scwq2vQP8OFq0U6EhO9EEya1MaKuob8PC/ExpXrHizyo+b+yOP0oGAAt
	9g7dvMC1IKdjJZRyIZmrMtdnoedbNxHzG0HT5tBb/1aBDnIV4ikWTveLitVUgcwHSQ+yXjTD/VQ
	G3oVfx34Pu+MfgwheR2w5+V5bC8rHsEBAuoaUqK8QNC45RlqcS167veYUroY0yWCL+8tLbvaPdB
	sWkfHN7SQPHPUuX+yXwFVmU96WjVi8f06ZoOZQY54CIKY/Hg3Am4n49vyf9XH6APa9i04WGCq2r
	l3dzGQ1wDQUlnxIhXnF3KvIbbLTLjwLy1kxf84msz8UF4jbTMVNVapMcyeuVg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.270600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: E24C5DBEC4A7B66132F1E1AFB2034EB23CBD72908B80C0880F7B0ABAD10D83592000:8
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

Your proposal is not suitable for scenarios where input_event is called within an atomic context.

For example:
spin_lock(&dev->spinlock);
input_event(dev, EV_ABS, ABS_X, x);
spin_unlock(&dev->spinlock);

