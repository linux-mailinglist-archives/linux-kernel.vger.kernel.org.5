Return-Path: <linux-kernel+bounces-19888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A23E82763D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C791F22FEA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB13154BC2;
	Mon,  8 Jan 2024 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g76E/Yhs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C55476B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704734607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nOy7rPmBJeQA7S2Ya6yzPxUkyXWk0XWROf8BC/z6Uqc=;
	b=g76E/YhsqKb7FoUxE4pIPRtNLffJbjdo+Dpd3ZdEprQZEH+ku0o1BsGQ2ceBVdLXlg/x90
	JljTi1Bz1pOlcXoxkAvjXsV4YX39OCoTzvQqBwnkPkRmA64t7HNSH13oy38dNu60rqF4+Y
	lNxKmwSMJt2db9pAsuuU3FWiHcrpvdg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-akiqq1koPuSieCbhgZ8uiA-1; Mon, 08 Jan 2024 12:23:20 -0500
X-MC-Unique: akiqq1koPuSieCbhgZ8uiA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-680c651928eso42888376d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 09:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704734600; x=1705339400;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nOy7rPmBJeQA7S2Ya6yzPxUkyXWk0XWROf8BC/z6Uqc=;
        b=RekBOGc74FN5Zg8yV3tGlyFOwwWBmAXcewGaTkzjjfg5e+VSUOTHOvc6W4RnSa4Os9
         8SA2z569iN4/XdwyXIwmQnFz0pfrfR66KGzeT06mKD4ihMG5KMc1JHMGPmIctO7gE8y3
         6jnVIK+4QmE0xTDs9UBq46gRUfO3KuRvDHkvsGxcN1CdOrjbVpseiCfifpfC/4ypVsI9
         o2VSigv5//R76XU01/zEpxyS/IPl0cm9ch2DYvU2stLkJj9IymBCYbEuhYkPsBNHS/Wx
         tDIdqjl/N2ZjSNyFfEEyMDbFPI7yinGzM0gTfcKjXrQYGlDbGJYbpPEbBD6WkyI/dMDm
         liGg==
X-Gm-Message-State: AOJu0YxwrRloYXMScjmBODxo1VIWrnIg6lXk7mv4nG2QWxgM5T4SJYol
	zo/cp0UjEKVT9gINrDy3inDSKLeDSAe1yD3grelZdio4tqCoOrKyTs38cSTFoRTeVqMFdaobssH
	M83MvOWLL4KCd0IxlYTVYM7dFJlTk/nZV
X-Received: by 2002:a0c:eb8b:0:b0:680:f8a6:bcf9 with SMTP id x11-20020a0ceb8b000000b00680f8a6bcf9mr3295223qvo.13.1704734599749;
        Mon, 08 Jan 2024 09:23:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUqoB7J6lI/Dv2EV3jEiEvSKUSF711d35mvJLCRr099kSHpmF+L6Jmb7nH/7EYRnhpbK2MHQ==
X-Received: by 2002:a0c:eb8b:0:b0:680:f8a6:bcf9 with SMTP id x11-20020a0ceb8b000000b00680f8a6bcf9mr3295212qvo.13.1704734599460;
        Mon, 08 Jan 2024 09:23:19 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id t7-20020ad45bc7000000b0067f789a59c8sm127305qvt.113.2024.01.08.09.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 09:23:19 -0800 (PST)
Message-ID: <3b3a1c92-8c1f-4812-95ce-b5431114e154@redhat.com>
Date: Mon, 8 Jan 2024 18:23:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau/fifo: remove duplicated including
Content-Language: en-US
To: Wang Jinchao <wangjinchao@xfusion.com>
Cc: stone.xulei@xfusion.com, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <202312151802+0800-wangjinchao@xfusion.com>
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <202312151802+0800-wangjinchao@xfusion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Wang,

there is another patch [1] to fix this, which already made it upstream.

- Danilo

[1] https://patchwork.freedesktop.org/patch/msgid/20231122004926.84933-1-yang.lee@linux.alibaba.com

On 12/15/23 11:02, Wang Jinchao wrote:
> rm second including of chid.h
> 
> Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
> ---
>   drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
> index 87a62d4ff4bd..7d4716dcd512 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
> @@ -24,7 +24,6 @@
>   #include "chan.h"
>   #include "chid.h"
>   #include "cgrp.h"
> -#include "chid.h"
>   #include "runl.h"
>   #include "priv.h"
>   


