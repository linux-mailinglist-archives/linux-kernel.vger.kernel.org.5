Return-Path: <linux-kernel+bounces-167900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF128BB0D6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461091F204E2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DC3155343;
	Fri,  3 May 2024 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrW1Rvth"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FF8155342
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753405; cv=none; b=jcdLXB4e2nCsOP0738SDYt3HhlbCxJEsKzHBZ19NdUdyeuKLKwkKIJSvOJuIX2WzdlREkzYSOnsPkqHGpUMTP4c3KvfdZs7xlcHviKe7Hg2TiSoEvFkMUEFy1dDPqPb41T9XhoWoilih1GKmtHoFedE1CYW68d8b8mM8gPVPnU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753405; c=relaxed/simple;
	bh=2TK0WfyT+uobla4qoKzP2gAKcDWPP/VYNZP4PYQFP0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcZ3iTEBjfkrDu9MhVUWV0pn6z+MHn1Ct92vxjRQhf9xBrh1VB9SeN9nNh41YL5zR6weuo6zxNfvY2Svk0DZrvyv1HQ68fI52JJqh2+kOJgcc9iatbu5/Nf38EYGuY9zs/VRyRkpQ3ClURE8rW2xMCTAX46c/OaJB/lNZkGi+O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrW1Rvth; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso8508364b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 09:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714753403; x=1715358203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mwKDafe28MIieMSNGIPW3eOTsHHrwRXu1m7RhuwOcZc=;
        b=mrW1RvthgHzIVZ4kN045WXM/fhPCmMc/Rm+6Xv+rkewGVy1kS4uiPcgpFLWjMBmZw5
         ne6uHunDYyK1Lmr2UBJ81uI8ODy8VMmWN6hIKADn26n1Gjqi3WqjT3KNJByLbml9BNrI
         tG2+4YjZ1FEh18bPj2ErjQcssAOGQEi+4oMogWAWuaqfkkGS/0vRCCIn8YU7uXyO6XRC
         Xm4cFt7Ud6SUuJ8f10M2nCOAEHtqMavBhLSxrTd3pfDxAKD9E/eeBnioPzZ7lbIHbMbr
         x8S1DnSd25Wgc9U40kSKbFZyFwVssFeyzxx4d00OXedlCuGBhGfbUFO4XwqjSxSkHLSq
         mMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714753403; x=1715358203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwKDafe28MIieMSNGIPW3eOTsHHrwRXu1m7RhuwOcZc=;
        b=lVX/jlav6nmSA78V0/R+FXxRc2v2GCl6jhNwZGnd508Jm8KYUMsAOdH97eRWWs3jlF
         HdQHk1YxE2VJ7nVBCcvG7K9cb2/TE+OAaUFxTyv8jgIf+d/MuBn7+eqPZRca50ddw4Gi
         RIvLVjamR/TD5VQMNEq8bQaW/Z4NpIkCR6B/5mZ6p/jIFmZCjWR4Gotun0H9SZLh2yfF
         TlLIL8MZEPh4AGNOC9V892aJ5R+dyUBagBr8ugBMLQjOWstIeCzEfQeUUgpWgy+sZ30L
         rXC4ASL4QZUI0/lbH4EJ+8GqmB31EvDe2daof0Cd3ksmhcfBD3k+XTWiWn2eajFx1E0U
         /8kA==
X-Forwarded-Encrypted: i=1; AJvYcCV2hiDM94VflGmxrnzwC/qtTCtsRGN6V+JQ9T60ttaFi1Vpzhn+jbA0+qtuk1Ru/nz4cdIJHfWk4KgFdNvqdrVBJwRcSWNO62Sh2UPC
X-Gm-Message-State: AOJu0Yyf21s2N2kaS2WKbMIsmT++/YXoruzDzmN6erfbbVUjC0hu+RLU
	YpfIEQIuMumwjtlCADnOkqwYaKs31vHkFe/RV+wPHRfNeydDPYdE
X-Google-Smtp-Source: AGHT+IGuqVde44+OlfespuDSTAfHKUhnMDH3dyay8UhKf4umdgctT17gfataxz2qw5xl3u+0CdUBww==
X-Received: by 2002:a05:6a00:130a:b0:6f3:e6e0:d9fb with SMTP id j10-20020a056a00130a00b006f3e6e0d9fbmr3124846pfu.11.1714753403334;
        Fri, 03 May 2024 09:23:23 -0700 (PDT)
Received: from ?IPV6:2402:e280:214c:86:b096:5d6e:50c3:70e5? ([2402:e280:214c:86:b096:5d6e:50c3:70e5])
        by smtp.gmail.com with ESMTPSA id w17-20020a639351000000b0061cf79eab38sm1612625pgm.37.2024.05.03.09.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 09:23:23 -0700 (PDT)
Message-ID: <f87bfbb1-b80f-46a5-be85-058a406de99d@gmail.com>
Date: Fri, 3 May 2024 21:53:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] gpu:ipu-v3:pre: replace of_node_put() with
 __free
To: p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
 Julia Lawall <julia.lawall@inria.fr>
References: <20240427045024.7083-1-prosunofficial@gmail.com>
Content-Language: en-US
From: R Sundar <prosunofficial@gmail.com>
In-Reply-To: <20240427045024.7083-1-prosunofficial@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/04/24 10:20, R Sundar wrote:
> use the new cleanup magic to replace of_node_put() with
> __free(device_node) marking to auto release when they get out of scope.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: R Sundar <prosunofficial@gmail.com>
> ---
>   drivers/gpu/ipu-v3/ipu-pre.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/ipu-v3/ipu-pre.c b/drivers/gpu/ipu-v3/ipu-pre.c
> index aef984a43190..95830cf8fa3e 100644
> --- a/drivers/gpu/ipu-v3/ipu-pre.c
> +++ b/drivers/gpu/ipu-v3/ipu-pre.c
> @@ -113,8 +113,8 @@ int ipu_pre_get_available_count(void)
>   struct ipu_pre *
>   ipu_pre_lookup_by_phandle(struct device *dev, const char *name, int index)
>   {
> -	struct device_node *pre_node = of_parse_phandle(dev->of_node,
> -							name, index);
> +	struct device_node *pre_node __free(device_node) =
> +		of_parse_phandle(dev->of_node, name, index);
>   	struct ipu_pre *pre;
>   
>   	mutex_lock(&ipu_pre_list_mutex);
> @@ -123,14 +123,11 @@ ipu_pre_lookup_by_phandle(struct device *dev, const char *name, int index)
>   			mutex_unlock(&ipu_pre_list_mutex);
>   			device_link_add(dev, pre->dev,
>   					DL_FLAG_AUTOREMOVE_CONSUMER);
> -			of_node_put(pre_node);
>   			return pre;
>   		}
>   	}
>   	mutex_unlock(&ipu_pre_list_mutex);
>   
> -	of_node_put(pre_node);
> -
>   	return NULL;
>   }
>   
Hi,

Any feedback on this patch.

Thanks,
Sundar

