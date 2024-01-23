Return-Path: <linux-kernel+bounces-34746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32526838710
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B666E1F237A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F343B39AE5;
	Tue, 23 Jan 2024 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NPCwJpTb"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B744374F5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 06:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705989874; cv=none; b=ZdNj3RgVoFk4VA4Dz8jbkn8odxJRP/PQxXZ85pyyntPkt/xwH8ozacQxyayIb5tBFyqEPi/7RlkdRsV8SgJul/MIdRIysWZYR174Y0IrMByLyjsP1TqlYIALlE/f+mv/o/RjXAix05CV3zQY5JZtZKoyPUF33HaLkY5+7uyjZeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705989874; c=relaxed/simple;
	bh=7EqcWsyZ+h3svlefe6+y3WK7H6gzDUkqDW4wwAzshSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zu/SFkxR+eX+puqeBJabyVMlFCszsGaCEApoTWzZov37D9Vtyy5SmHqTVYauEZAQEDAUdsb5/SCmgiul9HkU1FogtncJHas2CkBuY/DqGLk2LnBIXSk867zr3wiTHuBlpNL2PGNGk5Irf7V0mzHZUIT3/bAuzWBewdmH8djg1k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NPCwJpTb; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3392b045e0aso2317635f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705989870; x=1706594670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DuEzjVSg/RQQwKlc0Uyux+cdBaiyYeWCUP9YcLhjwnA=;
        b=NPCwJpTbkwhLGQweZarLl67lFcmIBSazVk9Ka/+ALIertJbg84nPCf5zmFJwvfhZm9
         Q5tJgB6yZPPcMYQI3Zj+ekTDsnxneGEFG8ZVbrVsc8d0iubDk4ffBFMc9I6xq0ULT68q
         XXzKYcngIrXsEzh0lre4JXiyJYRcURZQSxXa1/aIlQDX8zGtTinDh+nXB2g0pwr+/jZU
         dM8aJUPVSONwWLS7FWGaips3/OYFDVuXOQJcgawN3c224lAXNfn+1A3elg5PLqNXfbB4
         CXMSDe0ss9TXUb2PPdLL3+UoLXCykFGbnC6ksNNhdIAlhY/+9o+BJ989zY7TV8CBtw9w
         /NZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705989870; x=1706594670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuEzjVSg/RQQwKlc0Uyux+cdBaiyYeWCUP9YcLhjwnA=;
        b=b/dvrBMUNdTfpksfIEaU+dQsJW9AtLwVhFUvG2cMVhZPjlq0K8VsMPhJ8N4LRnv7ga
         mAB753R9zW0IL6BNp5U94dDdLTnU4N/kCYZ8m4rrje1+wFg0E0fDbNZnlyD7bIrgJ/ba
         1wzWd25r49hSUZ7CP4K04Ikht5oueJHmYNowrF+CkNokA5p9lIp/d7gIc7rs22Q4iUhh
         cVOPy4ZB7BmifrlIXJAqImntl5G9DOgGuFmCp7fs0BP5E/H1Nj2MVQ4jCrJ/X/rM0+UU
         0wrp1gad0srEKBEmb09Qov4zPcPiC48hPrXb4e6eZUw0vZzOPidlOiYMlcBV7i0o93gk
         9NKg==
X-Gm-Message-State: AOJu0YzafF38ud/k9HZvYZw/4LkiTbQbzwqGdQA3pN+fJt1UA9FuZsR3
	m9k08N6521UxOFe6qmzo9qe1BzJRASMgRu4OpJUmy/uebv+SNuGbSeNSuON8YiA=
X-Google-Smtp-Source: AGHT+IFLHaZr+mF2sYyUABvXyhzrT4n/xOssMtnFknUGdtEhhS0RhZUa1R3tZrI36x7WhV9qUfSCLg==
X-Received: by 2002:a5d:4208:0:b0:337:4219:3e8d with SMTP id n8-20020a5d4208000000b0033742193e8dmr3424121wrq.15.1705989870613;
        Mon, 22 Jan 2024 22:04:30 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id bl1-20020adfe241000000b0033935779a23sm4856417wrb.89.2024.01.22.22.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:04:30 -0800 (PST)
Date: Tue, 23 Jan 2024 09:04:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Christian Gromm <christian.gromm@microchip.com>,
	Dan Carpenter <error27@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] most: fix a memleak in audio_probe_channel
Message-ID: <4e065b3a-240e-4cd9-acd8-53e5a56abed0@moroto.mountain>
References: <20240122172044.3840976-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122172044.3840976-1-alexious@zju.edu.cn>

On Tue, Jan 23, 2024 at 01:20:44AM +0800, Zhipeng Lu wrote:
> When get_channel fails, audio_probe_channel should free adpt like all
> its following error-handling paths after get_channel. Otherwise there
> could be a memleak.
> 
> Fixes: 15600aea2754 ("staging: most: sound: create one sound card w/ multiple PCM devices per MOST device")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
>  drivers/most/most_snd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/most/most_snd.c b/drivers/most/most_snd.c
> index 45d762804c5e..6cccc9c26796 100644
> --- a/drivers/most/most_snd.c
> +++ b/drivers/most/most_snd.c
> @@ -564,7 +564,8 @@ static int audio_probe_channel(struct most_interface *iface, int channel_id,
>  	if (get_channel(iface, channel_id)) {
>  		pr_err("channel (%s:%d) is already linked\n",
>  		       iface->description, channel_id);
> -		return -EEXIST;
> +		ret = -EEXIST;
> +		goto err_free_adpt;

No, this doesn't work.  Someone should add a comment here explaining
why.

This function is a bit complicated because we sometimes allocate "adpt"
and sometimes we don't.  Why can we not make it consistently one way or
the other?  This is not my code and I don't know.  But presumably there
is a good reason.  I looked up the previous discussion of this and found
this thread.

https://lore.kernel.org/all/78cc59b31042f865e947a2c09a5d10cc60ddc01c.camel@microchip.com/

Anyway, in the end, we're trying to clean up and on the other error
paths we're allowed to free "adpt" even though we didn't allocate it.

However once it's got a channel linked then we cannot.  At that stage
"adpt" is already added to the &iface->p->channel_list list.  The
release_adapter() adapter function will free it without removing it from
the list so it leads to a use after free.

However, memory on this path is not leaked as your commit message says.
"adpt" is still on the lists.  The stuff is in a messed up state so the
user will need to tear it all down manually and recreate the
configuration.  Quoting the email I linked to, "This
involves the call to mdev_link_destroy_link_store() that cleans up
everything."

So we can't apply your patch because it leads to a use after free.  But
we could apply a patch which adds a comment like:

	/*
	 * This error path doesn't leak.  If the channel is already set
	 * up then something has gone badly wrong.  The user will have
	 * to tear everything down and reconfigure from scratch.  The
	 * memory will be released via mdev_link_destroy_link_store().
	 *
	 */

regards,
dan carpenter


