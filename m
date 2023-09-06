Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0A2793944
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbjIFKC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbjIFKC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F218D170E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 03:00:50 -0700 (PDT)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-rmTvppXLNnOd5bqmiosBcQ-1; Wed, 06 Sep 2023 05:59:40 -0400
X-MC-Unique: rmTvppXLNnOd5bqmiosBcQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe182913c5so22422515e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 02:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693994379; x=1694599179;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmAkZbkLbqrhYKWGilvLnXtd6fKYLLSrfrWjxYIXvzE=;
        b=XET6eVJteGSgDaVyUVwDopLO7Ykpg3CpC9/HZVM6un8Ew+p9oHq+HKfzIwMGFLM7qW
         yAMgZGDVEpUl8hAVTYcUlcGSOUObGJ8VS2iGHYSVKbk6RjJP0AOBTPOkIWgloF8StxA+
         rs30glqf/WKjXbNX8yfQZvt+hn6Q/ogop9vGtvHiaAmUbzeAUyl/ilno7D5T5obbK+AO
         jczauZypdaGvLK6IrJ6G5eVRGPRrQVFbn4SPD2yxgvSDBqE4y3kHFUdRdNSwPdnc9Rn8
         vRmeHFC3YtECfoxbyNdLfO/mFZHC6Jy698vu97UZakAdiiwZjVY61Q7of+Oz8vCNaQT9
         VxLA==
X-Gm-Message-State: AOJu0YyMnZnCNKIIvOfeeKdAo+3pTUtdem9qkgRaVe6EB1Ufj2u4nQiK
        GZq5kap0Eu5a0s9vauhtwOD8Meuxw8sXEHcTa0vIkpWoNK5GEpG7YhE7hUwatF+6/Z0OCX//3Z2
        Sh0gcmpShdv/6U/eotz24iDLc
X-Received: by 2002:a05:600c:128f:b0:3fe:25b3:951d with SMTP id t15-20020a05600c128f00b003fe25b3951dmr1928465wmd.5.1693994378901;
        Wed, 06 Sep 2023 02:59:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5+OhfOUQuGHMsv/QI74pAE53OdzJ3LqKgxFhHFhepwapLYpSxbrf63ipC3UeI9PeqR2f8jA==
X-Received: by 2002:a05:600c:128f:b0:3fe:25b3:951d with SMTP id t15-20020a05600c128f00b003fe25b3951dmr1928450wmd.5.1693994378520;
        Wed, 06 Sep 2023 02:59:38 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 15-20020a05600c22cf00b003fe2de3f94fsm19249458wmg.12.2023.09.06.02.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 02:59:38 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 3/7] fbdev/core: Fix style of code for boot-up logo
In-Reply-To: <20230829142109.4521-4-tzimmermann@suse.de>
References: <20230829142109.4521-1-tzimmermann@suse.de>
 <20230829142109.4521-4-tzimmermann@suse.de>
Date:   Wed, 06 Sep 2023 11:59:37 +0200
Message-ID: <87il8n4o6u.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Fix a number of warnings from checkpatch.pl in this code before
> moving it into a separate file. This includes
>
>  * Prefer 'unsigned int' to bare use of 'unsigned'
>  * space required after that ',' (ctx:VxV)
>  * space prohibited after that open parenthesis '('
>  * suspect code indent for conditional statements (16, 32)
>  * braces {} are not necessary for single statement blocks
>
> No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

[...]

> -	static const unsigned char mask[] = { 0,0x80,0xc0,0xe0,0xf0,0xf8,0xfc,0xfe,0xff };
> +	static const unsigned char mask[] = {
> +		0, 0x80, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc, 0xfe, 0xff
> +	};

I didn't know that checkpatch.pl complained about this.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

