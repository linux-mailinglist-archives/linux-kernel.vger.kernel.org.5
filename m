Return-Path: <linux-kernel+bounces-42960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B7084094F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD68428C15A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83B61534EC;
	Mon, 29 Jan 2024 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VdRdT15M"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF991534E6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540801; cv=none; b=rUT8DYtWCmQsDJpMXyoUp//ofZLtPx6bFAoQvMrROu1tsaiywKEfsFd6s6AeTxrfC3Seyjb4HUS8QPfZw0cIqpCuZduktuRs2f0wHMrR50nTdbWUak9MuhUOO+s2QqtBacMJeY9417uLqb6a+zs5ckrBQRKbV3ZivchmiE9HCjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540801; c=relaxed/simple;
	bh=UdVE88RvKofu1niD7h9x7NM6QyJbb3bceyHPaqVCFyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBJIBKQ1kj7rnnq8ImIcG6UJC1pXjt7W9f3BrDVz3aFoioL4AsIjUQuMa2fOz0QBg1NT+zgOt3fCD7LmQ+XetiSF5wBecKsscLYbPXI6xU6Iyp+NUB8SvFxWBfZHm3zwo5NmSYWX4EJvP4WmyqXnIMIM9/HOPMwsQGqGUswFsKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VdRdT15M; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ae3be1c37so957283f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706540797; x=1707145597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SB7k/BFApJBDg3KYf+GK3Duye99o6PLwEtImHq4bcyM=;
        b=VdRdT15MKtBIYKo1FVDLVuBJOyolpgnhYmkvL+t+E380Q7RVpZ2Ht+Ab249wG3NQpe
         uoX2HB5715VR2K6zWuPUWlIGodBsPjBU7yP/9z5O/krCnjGfOdKlYPtMpWVQWssFIDDA
         916K48BGaMT4lDsiFhGZUwR6px2Fgi8O5UwzN8n4DjjOdQeOHr27Bk1APMv78a5ovSjs
         mr7CbqjvT7/mCQehPrhEHRsGhJupHyt/YkpmJnDHke+VJdz9Yv/Kg42R3s1k33kBzx3i
         YkV1vJUC2uDVAeHn0e0CElgn8Qv6jICrOPKKnIoiqHKpKW7TdWOgTuztNMrEj2kz60pF
         8MSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706540797; x=1707145597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SB7k/BFApJBDg3KYf+GK3Duye99o6PLwEtImHq4bcyM=;
        b=S1mW9vZgZrpi3J+WP8xCn1q6z1gTnJwrqR06HS7Evy8Iesd33q29ehi6LRMjY4E7QO
         BLrVYYV5Nk39nLOySYYd9FIVKPJY+fdSAVy7fMjIRTgGWdaiTTs5eywVqJ5ius2YQryK
         X7Z/1WwxOPdho765N/2DFVcNw//syJYN/UV3tqe1+yIBHYHNaFqtaWg2B/UiGG18tpdE
         /pgaxkNmU42UDjFq1jSDg+jPxQDghfrYnFxyVtNt5MUqjX2jCNpXpPE/wWGDluvmr7pu
         gdGo7H8SyyZ7WFXa4Pj+xsFG0NFcXSN4UCLRu1NygzHAOvdvbOx8u1WtD7Sf9+lqZt3B
         qMXQ==
X-Gm-Message-State: AOJu0YzapyVNeIjY178sasjyuPPLS33QckZVbkeyQo9XJTM5mQ6x+eOk
	ftyw/Y7MWrxkqBZHuZvZorwu9LxKvOrVwJ4ZZwcKL6Emx2vaPKQFyalhZvVH7KQ=
X-Google-Smtp-Source: AGHT+IE+uX7yUe7MwfmkZ12D1Eijb9mak9vnudqGmL2IFa7HkMwnDFRdrTBve8PDAwKPyZ2UDUlpMA==
X-Received: by 2002:adf:ce0d:0:b0:33a:e559:5357 with SMTP id p13-20020adfce0d000000b0033ae5595357mr4148708wrn.28.1706540797491;
        Mon, 29 Jan 2024 07:06:37 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id k7-20020a5d6e87000000b0033addeabd6fsm7642647wrz.18.2024.01.29.07.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 07:06:37 -0800 (PST)
Date: Mon, 29 Jan 2024 18:06:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Meir Elisha <meir6264@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] Staging: rtl8723bs: Fix block comments warning
Message-ID: <888364a5-0445-467b-9e3c-6662019852e4@moroto.mountain>
References: <20240129141856.416532-1-meir6264@Gmail.com>
 <20240129141856.416532-4-meir6264@Gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129141856.416532-4-meir6264@Gmail.com>

On Mon, Jan 29, 2024 at 04:18:55PM +0200, Meir Elisha wrote:
>  /*
> -struct	wlan_network *_rtw_dequeue_network(struct __queue *queue)
> -{
> -	_irqL irqL;
> -
> -	struct wlan_network *pnetwork;
> -
> -	spin_lock_bh(&queue->lock);
> -
> -	if (list_empty(&queue->queue))
> -
> -		pnetwork = NULL;
> -
> -	else
> -	{
> -		pnetwork = container_of(get_next(&queue->queue), struct wlan_network, list);
> -
> -		list_del_init(&(pnetwork->list));
> -	}
> -
> -	spin_unlock_bh(&queue->lock);
> -
> -	return pnetwork;
> -}
> -*/
> + *struct wlan_network *_rtw_dequeue_network(struct __queue *queue)
> + *{
> + *	_irqL irqL;
> + *
> + *	struct wlan_network *pnetwork;
> + *
> + *	spin_lock_bh(&queue->lock);
> + *
> + *	if (list_empty(&queue->queue))
> + *
> + *		pnetwork = NULL;
> + *
> + *	else
> + *	{
> + *		pnetwork = container_of(get_next(&queue->queue), struct wlan_network, list);
> + *
> + *		list_del_init(&(pnetwork->list));
> + *	}
> + *
> + *	spin_unlock_bh(&queue->lock);
> + *
> + *	return pnetwork;
> + *}
> + */


Delete the dead code.

regards,
dan carpenter



