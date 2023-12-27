Return-Path: <linux-kernel+bounces-11770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27FF81EB70
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BD21C22191
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8632620F4;
	Wed, 27 Dec 2023 02:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eaATy6iu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFA01FBF;
	Wed, 27 Dec 2023 02:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0BrVlmPWKKehalFtZAOefANVneodTEBVxjiVx9T21Ik=; b=eaATy6iuQDpLZmSfhgLojVqkOW
	8hNB0H+nUKUrtlvOD1ikpqu02BBDQY35mB0bINmH2RcbgH7UAjEloGkHHABQfrxnEMTLyssiu+78m
	rNYtNC+D0lpNxLbS+VM//TYYqL9pcUC/P1tR1cgur7syVQqyKVQIxrvXQ1TW0/k+f0Voex0bLLMhp
	QfnlqMuhblsVAohyH1OEW6dPgdDBZCkbPQP6drJZ0JVB1gFbTTtliow+9GpT/Y15AlGWZ58cVl/db
	cExPFNepTdIp3HGJZTcSbTQEvso4Jvkv4ukX/YMVL5ShE0ortTmhztDANPhycCalvLHRLwwaPoAgD
	lLrUKnkA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIJLK-00Do0t-0p;
	Wed, 27 Dec 2023 02:08:22 +0000
Message-ID: <007b0b3c-26c8-4a59-b2d6-017ccb656694@infradead.org>
Date: Tue, 26 Dec 2023 18:08:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers/isdn/hardware/mISDN/w6692.c: Fix spelling typo
 in comment
Content-Language: en-US
To: YouHong Li <liyouhong@kylinos.cn>, isdn@linux-pingi.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 k2ci <kernel-bot@kylinos.cn>, Simon Horman <horms@kernel.org>
References: <20231227013753.286177-1-liyouhong@kylinos.cn>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231227013753.286177-1-liyouhong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/26/23 17:37, YouHong Li wrote:
> Fix spelling typo in comment.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: YouHong Li <liyouhong@kylinos.cn>
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> ---
> v1->v2
> 	*Fix spelling typo in comment oscilator ==> oscillator
> ---
> diff --git a/drivers/isdn/hardware/mISDN/w6692.c b/drivers/isdn/hardware/mISDN/w6692.c
> index 6f60aced11c5..69d23e732e85 100644
> --- a/drivers/isdn/hardware/mISDN/w6692.c
> +++ b/drivers/isdn/hardware/mISDN/w6692.c
> @@ -788,7 +788,7 @@ w6692_irq(int intno, void *dev_id)
>  	spin_lock(&card->lock);
>  	ista = ReadW6692(card, W_ISTA);
>  	if ((ista | card->imask) == card->imask) {
> -		/* possible a shared  IRQ reqest */
> +		/* possible a shared  IRQ request */

or		   possibly

>  		spin_unlock(&card->lock);
>  		return IRQ_NONE;
>  	}
> @@ -873,7 +873,7 @@ static void initW6692(struct w6692_hw *card)
>  	/* enable peripheral */
>  	if (card->subtype == W6692_USR) {
>  		/* seems that USR implemented some power control features
> -		 * Pin 79 is connected to the oscilator circuit so we
> +		 * Pin 79 is connected to the oscillator circuit so we
>  		 * have to handle it here
>  		 */
>  		card->pctl = 0x80;

-- 
#Randy

