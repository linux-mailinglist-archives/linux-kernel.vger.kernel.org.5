Return-Path: <linux-kernel+bounces-31234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4148832AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A221C212E3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC4E53801;
	Fri, 19 Jan 2024 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TBy6rvLi"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C5F537EA;
	Fri, 19 Jan 2024 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673098; cv=none; b=cXHbeZ+FIm/+Xop1SK/WNxpUYufZiFbi71wJax04ZksEwdoq2nIq+GB4trW/waZugPENL9zVpdZIqqZmJCX8ijaL3DfLhPdqS+fn22dVElPYRCKLyVd9z/naMz0YM6dS47fDJsrQWAsPRExWKawOWw9n/vr7HRfIEIsllMbMDTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673098; c=relaxed/simple;
	bh=qaoEXV/u8siJjNT+jzeg5ORewGEo7Iu20ZxUN+Ot1gk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOvMylKmXjPkAl7euaHgTKN4YvHEuFV/o6uWiCHf4vdQn8BFoXqhR0W3K3GdzEBXcv5xATvM4dh1eACdvEdjxX355rhnB1N4ZPieoUoc7HNvxKDdj43XtBwAVwU3TP+nIQcrWZATHfGc9LCGmqebSejS5cUGU3zHdTOWxvHFhZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TBy6rvLi; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B3D620003;
	Fri, 19 Jan 2024 14:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705673093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LS64bqShtvNGI+XJwxvXBq3d8lOmvfDP9t+KLU3cghE=;
	b=TBy6rvLiccH2faYMeE7D9LtdTZcTL2DorXmXaYU15CSo+lTv15nYakVXX/XCd/A/hMnVAN
	eIBKvZNR+1OAHGaCfkFBPSj0fAWUrNkpHhWUKPvdW7K6AEsykZxcXXu2NwivKQrwv2ZDEr
	6bhpGOKatOSpU5P8LQB73UyCgSomfCtNK1wMbJloFyJB6qhtsDfDQpCRX5TlzJ/BYNbgFt
	TXa+SdEVUm+8dlNIelvRZL26nyRmZ0eOK7f7lV/Ihm2x4nRyU86zGyiVNRchKBtVViuFVk
	gHfggVco8tjfrHj2F3/Pykvn2e2oKhokFaZLxQHaEbYtTlikTYB/abJvddVN+w==
Date: Fri, 19 Jan 2024 15:04:51 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
Cc: <marcin.s.wojtas@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Antoine Tenart <atenart@kernel.org>
Subject: Re: [net v4 PATCH 1/1] net: mvpp2: clear BM pool before
 initialization
Message-ID: <20240119150451.476d6ba2@device-28.home>
In-Reply-To: <20240119035914.2595665-1-jpatel2@marvell.com>
References: <20240119035914.2595665-1-jpatel2@marvell.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello,

On Thu, 18 Jan 2024 19:59:14 -0800
Jenishkumar Maheshbhai Patel <jpatel2@marvell.com> wrote:

> Register value persist after booting the kernel using
> kexec which results in kernel panic. Thus clear the
> BM pool registers before initialisation to fix the issue.
> 
> Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375 network unit")
> Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
> ---
> v1-v2:
> -Move comments outside the loop
> -remove unrequired brances.
> v2-v3:
> -improve readability
> -correct register read API
> v3-v4:
> -optimize the code
> -improve readability

Thanks for taking the reviews into account, however ...

>  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 27 ++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 820b1fabe297..23adf53c2aa1 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -614,12 +614,38 @@ static void mvpp23_bm_set_8pool_mode(struct mvpp2 *priv)
>  	mvpp2_write(priv, MVPP22_BM_POOL_BASE_ADDR_HIGH_REG, val);
>  }
>  
> +/* Cleanup pool before actual initialization in the OS */
> +static void mvpp2_bm_pool_cleanup(struct mvpp2 *priv, int pool_id)
> +{
> +	unsigned int thread = mvpp2_cpu_to_thread(priv, get_cpu());
> +	u32 val;
> +	int i;
> +
> +	/* Drain the BM from all possible residues left by firmware */
> +	for (i = 0; i < MVPP2_BM_POOL_SIZE_MAX; i++)
> +		mvpp2_thread_read(priv, thread, MVPP2_BM_PHY_ALLOC_REG(pool_id));

.. I think you didn't answer Antoine's comment on that loop from the
V2, regarding what this does exactly. From the other sites this is
used, it seems to perform an allocation from the pool, can you clarify
how safe it is to do so here, if for example the BM was never configured
by the firmware beforehand and is therefore already in a Stopped state ?

And are we not risking any leak if there was something in the pool that
we don't release ?

Thanks,

Maxime


