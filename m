Return-Path: <linux-kernel+bounces-13674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14239820ADE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 10:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E779B208B1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F82133EE;
	Sun, 31 Dec 2023 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMpcWZdq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E30033CA
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704015864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuKW/WiYTJxSI9VLFVMNPYnkyJG0fGJhGRmQq6BzIUI=;
	b=NMpcWZdqIN05g3gmtr6KD8jz5fzD3TD7h3JS0MA6iDGjMxJdg3ZSfx9B4+htZpXnKcCajJ
	EKsndKZyDcw1kggrEDwRsudQDxqqBav+E6ynHtfzw4NYCE6JhRcZlDIW1L7gFaMlmMg6I5
	Io3lYsm0Xa2ONu+xzlDSyAH5mgb1KOo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-qIkHD0EGPcqtSMzGjr9AVg-1; Sun, 31 Dec 2023 04:44:22 -0500
X-MC-Unique: qIkHD0EGPcqtSMzGjr9AVg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9fd0a58549bso845663266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 01:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704015861; x=1704620661;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EuKW/WiYTJxSI9VLFVMNPYnkyJG0fGJhGRmQq6BzIUI=;
        b=TRcHADiKFwGIGtngAvACzlZAw+a74pBf0iYXRQ6vULswi6oZ801rTZq0gBfrD1KEMu
         cZOlsIFUuixeo287oVBjeqbNbn0/BfdhnkXjgUAGGmNXQXj2hmgQ74LHiKG0gI5zVKCS
         9LRpyJQsg0n5ZE9LTslqoklDFEFa9QD7u44Bw6dSAXj1ufuxILMl8zCuR71cz8wIsUmL
         V/lPho4do6XLLamhNWS8J4OXiNkCP+T+hDwvcEHG2hcHJL9NoTvk1+Nf/K2jWgMI4LpV
         Gj3tLQVDzg/Xb0mgNGiOq0Tebo8M4Tcd6V0xzsUc2WgMfFloL8cP/B/0BZLsLlGTAotW
         JNYA==
X-Gm-Message-State: AOJu0YwreYntZ3Ic1YdM+z8GO7BJPbBGCXJEvz+aeQhygCcEPytvza1o
	b5PEXaPPAfPwcE6euMxHjlXjWTZ7dQVbzNn5A4P+E403jtvDhr66aEaS0vigOux6jsqZWlakm7V
	ULCs4tf1s0arMHE2F9qElXuDLVMOU8+yI
X-Received: by 2002:a17:907:3ac2:b0:a23:5893:1ac8 with SMTP id fi2-20020a1709073ac200b00a2358931ac8mr12276786ejc.27.1704015861773;
        Sun, 31 Dec 2023 01:44:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/zizKMwsqQrr7Yg28UomwhUJDmAq2ZJO9CDn6qhcdAiFIo1fEqPPVWqvKf+f4ihpRARn9xA==
X-Received: by 2002:a17:907:3ac2:b0:a23:5893:1ac8 with SMTP id fi2-20020a1709073ac200b00a2358931ac8mr12276778ejc.27.1704015861469;
        Sun, 31 Dec 2023 01:44:21 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906715100b00a26966683e3sm10072345ejj.144.2023.12.31.01.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Dec 2023 01:44:21 -0800 (PST)
Message-ID: <91b0ae65-eefc-44f7-a801-fbe3ee6073a5@redhat.com>
Date: Sun, 31 Dec 2023 10:44:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: media/atomisp/pci/base/circbuf/interface: Fix
 spelling mistake in ia_css_circbuf.h
Content-Language: en-US, nl
To: Dipendra Khadka <kdipendra88@gmail.com>, mchehab@kernel.org,
 sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org, hpa@redhat.com
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20231223061647.78669-1-kdipendra88@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231223061647.78669-1-kdipendra88@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/23/23 07:16, Dipendra Khadka wrote:
> codespell reported following spelling mistake
> in ia_css_circbuf.h as below:
> 
> '''
> ./base/circbuf/interface/ia_css_circbuf.h:76: poistion ==> position
> '''
> This patch fixes this spelling mistake.
> 
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

Thank you for your patch.

I have merged this in my media-atomisp branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/log/?h=media-atomisp

And this patch will be included in my next
pull-request to Mauro (to media subsystem maintainer)

Regards,

Hans


> ---
>  .../media/atomisp/pci/base/circbuf/interface/ia_css_circbuf.h   | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/base/circbuf/interface/ia_css_circbuf.h b/drivers/staging/media/atomisp/pci/base/circbuf/interface/ia_css_circbuf.h
> index 0579deac5535..e9846951f4ed 100644
> --- a/drivers/staging/media/atomisp/pci/base/circbuf/interface/ia_css_circbuf.h
> +++ b/drivers/staging/media/atomisp/pci/base/circbuf/interface/ia_css_circbuf.h
> @@ -73,7 +73,7 @@ uint32_t ia_css_circbuf_pop(
>  
>  /**
>   * @brief Extract a value out of the circular buffer.
> - * Get a value at an arbitrary poistion in the circular
> + * Get a value at an arbitrary position in the circular
>   * buffer. The user should call "ia_css_circbuf_is_empty()"
>   * to avoid accessing to an empty buffer.
>   *


