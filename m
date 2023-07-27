Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEEB765735
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjG0PSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbjG0PRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:17:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEA119BA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690471020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pp7lX2S4BE1VOAd+Ohe4qOsAj8X9hgCenh8uffGy52U=;
        b=UV141jlwuyQs1PPe0lIWTzrbgQmVqE/02ksud2UoC7Caqdu0TDci0jJG1X6UDhST7mQKLk
        ZYZqhGx9rg3qgB8rmp6WsU951sXnvzxlpAfOY3pBjvxA8tte130pZij0AzU64rTBzLB1Nf
        B11czmMeVjAif1OtrWlagy6FrGLbcmI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-kmci5ySlMm2bqfyq1Mmlrg-1; Thu, 27 Jul 2023 11:16:56 -0400
X-MC-Unique: kmci5ySlMm2bqfyq1Mmlrg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fd22a4cf2dso6329305e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690471015; x=1691075815;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pp7lX2S4BE1VOAd+Ohe4qOsAj8X9hgCenh8uffGy52U=;
        b=dem0Kg4EHMR97dkQoZvj3nFFOseKnYiyHQc5JlIMLhb4LylcvzsA3FNGmz1/6VJeBC
         pFkiXrN4Unhb+13Yjbz4xeW3PL77aZg900WpAsKClnC2muAq9owv07TWWjoLmcI425zm
         83u2znKCZ/rJkk1jqv63pCbm8QzJ6jliR2uhXeQTwiv+5Xe9ASOZECPfnGAwJkDVwxKj
         sdMTyr1ZA8jKD9p/uKvrn9VRSjVPT67hBLVkuNluH7+ZGkIqWWLaQdWi0Wq12PY4IhsL
         +Y94D05IwAA/6WpBggWsSxzQfYYm7RekNdrgws/gEBe5SFfNexTsHylR18YCOObaMO+q
         lpFw==
X-Gm-Message-State: ABy/qLafjbLJwkDX4eYkwsr0sYsDWEzbN9OTIGEzPybI+6UYu0ySUEzC
        TcQWQErSS0VTSBeWYwj64urKcfCtRoyp+F5RWhuPVYxDNG6UdpgNtAQ4ViJMt/DyGGfbnQyxBw8
        B+KBXeufNK6zhTicQqeV/H9jf
X-Received: by 2002:adf:fc05:0:b0:317:5de3:86fb with SMTP id i5-20020adffc05000000b003175de386fbmr1932627wrr.10.1690471015016;
        Thu, 27 Jul 2023 08:16:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGFJTm1x26WKX+ZJ5GVgIV/5/cEhdRTj0qRIs77CCN9iPmG4jfZSNpagqJH+qPLWxdEJ7LocQ==
X-Received: by 2002:adf:fc05:0:b0:317:5de3:86fb with SMTP id i5-20020adffc05000000b003175de386fbmr1932612wrr.10.1690471014678;
        Thu, 27 Jul 2023 08:16:54 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h18-20020adff192000000b003113ed02080sm2265368wro.95.2023.07.27.08.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:16:54 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/ssd130x: Use shadow-buffer helpers when managing
 plane's state
In-Reply-To: <0ce32153-cfc0-e701-3863-803fcdb897ff@suse.de>
References: <20230727140453.577445-1-javierm@redhat.com>
 <0ce32153-cfc0-e701-3863-803fcdb897ff@suse.de>
Date:   Thu, 27 Jul 2023 17:16:53 +0200
Message-ID: <87y1j1tme2.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Hi Javier
>
> Am 27.07.23 um 16:04 schrieb Javier Martinez Canillas:
>> The commit 45b58669e532 ("drm/ssd130x: Allocate buffer in the plane's
>> .atomic_check() callback") moved the buffers allocation to be done in
>> the primary plane's .atomic_check() callback.
>> 
>> But it missed that since the driver uses a shadow-buffered plane, the
>> __drm_gem_{reset,duplicate,destroy}_shadow_plane() helper functions
>> must be used in the struct drm_plane_funcs handlers.
>> 
>> This was missed because the mentioned commit did not remove the macro
>> DRM_GEM_SHADOW_PLANE_FUNCS, which leads to the custom plane's atomic
>> state management handlers to not be used.
>> 
>> Fixes: 45b58669e532 ("drm/ssd130x: Allocate buffer in the plane's .atomic_check() callback")
>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>
> Reported-by needs to be followed by
>
> Closes: <url>
>
> where <url> would point to Arnd's bug report on dri-devel.
>

Ah, I thought checkpatch complaining about it but since we already add a
Link: with dim, didn't know what to add there. Makes sense to add Arnd's
report indeed.

I can include it when applying instead of posting a v2 if you don't mind.

>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> This looks correct now. Thanks for fixing this bug quickly. With the 
> Close added:
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>

Thanks and to you for pointing that out.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

