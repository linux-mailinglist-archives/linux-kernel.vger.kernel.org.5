Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C1B76554D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjG0Noc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjG0Nob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB5E1BD1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690465427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6IdfiH6mIMbR0FSXPQIGzj7LBm5xu56D2rRO//Z4diQ=;
        b=KIKYoMz1HP1/pScbuSig/DnzN2+esasij7fMZ3xpJOb2O9ekacEz1nn2l1p9XEhD0wxjs1
        ups1M+lhlndAMCAFGQm8EBWjMCCGU883BOqMr/HsJ5wL5ARUkWXrU54tnfzZIsfYr92rCY
        BUC/fqeYiT9y4syh1Wfwo0NFouqSW3U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-O4T2f3kIMJ-HF-RQhQasBA-1; Thu, 27 Jul 2023 09:43:46 -0400
X-MC-Unique: O4T2f3kIMJ-HF-RQhQasBA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fd2dec82b7so5708335e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690465425; x=1691070225;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IdfiH6mIMbR0FSXPQIGzj7LBm5xu56D2rRO//Z4diQ=;
        b=cRpYa+PkCd5VU9UvRQG1+4arNdH/GHJXrfaeJjMhMKYHNlQbNTu/61qBgMX7czmsKg
         cHCiGciMnAjrOUnEFFVBfQbA34POQbjYaAvaZWxiLLr8kppKSZxGPLtR1MUkV0yyT6Ic
         ChnJnbb0brUzZNcSffBD7BLEUl/WtOePFeSktxOnqC6ENNIGFRCtrfDFk/6xwV6MJSes
         p+4GhJ/q9Gn0/85+pWSZYOQYA5r49JOpSEcl8LudlLG5I+vlbq9beW+wA4CgM0nhuCf2
         zCDrZzUQEo7oMoEfdw8a/53OzhXeizUzXORmWHGwRBANvSh+CFBeyP5ZCAan17T7LgD/
         Sc0g==
X-Gm-Message-State: ABy/qLZG9e54AMbAd5BHM4v8s5FzszrYgr5Mm30BYuEXKI6prGAWsxBO
        w0zG1saWi2va6x/p+z37PT5sjAf5cnWmgASU9Q074XfMcd9L9db0RKd8osWQ79kE+GPAFYAfeYy
        JKkkyraeNPmy0v9sYgG39Y6lG
X-Received: by 2002:a05:600c:2310:b0:3fb:d1db:5454 with SMTP id 16-20020a05600c231000b003fbd1db5454mr1655360wmo.35.1690465425397;
        Thu, 27 Jul 2023 06:43:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFNNkcpZZZoQTCtuvLKA9S/2aEqx3XjLUzUW8H6jP7uraezXsHXbBMd93Ho1Ikj5PKWqof+3A==
X-Received: by 2002:a05:600c:2310:b0:3fb:d1db:5454 with SMTP id 16-20020a05600c231000b003fbd1db5454mr1655348wmo.35.1690465425050;
        Thu, 27 Jul 2023 06:43:45 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h4-20020adffa84000000b0031417fd473csm2077965wrr.78.2023.07.27.06.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 06:43:44 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4] drm/ssd130x: Allocate buffers in the plane's
 .atomic_check callback
In-Reply-To: <76cea601-2730-21a7-f52b-1d53be343d6e@suse.de>
References: <20230721070955.1170974-1-javierm@redhat.com>
 <76cea601-2730-21a7-f52b-1d53be343d6e@suse.de>
Date:   Thu, 27 Jul 2023 15:43:44 +0200
Message-ID: <874jlp5v1r.fsf@minerva.mail-host-address-is-not-set>
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

Thanks a lot for the feedback!

> Hi Javier,
>
> this patch is completely broken. It's easy to fix though.
>
> Am 21.07.23 um 09:09 schrieb Javier Martinez Canillas:

[...]

>> +struct ssd130x_plane_state {
>> +	struct drm_plane_state base;
>
> You need to use a struct drm_shadow_plane_state here.
>

Yes, I already noticed this when testing Arnd's patch to drop
DRM_GEM_SHADOW_PLANE_FUNCS. I already have a patch ready.

[...]

+
>>   static const struct drm_plane_helper_funcs ssd130x_primary_plane_helper_funcs = {
>>   	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
>
> This macro sets the callbacks that vmap/vunmap the GEM buffer during the 
> display update. They expect to upcast from drm_plane_state to 
> drm_shadow_plane_state.  And hence, your driver's plane state needs to 
> inherit from drm_shadow_plane_state.
>

Yup. I missed that. I'm now testing my patch and will post it.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

