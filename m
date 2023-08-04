Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB0E770284
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjHDOEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjHDOEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE9A139
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691157801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rM0KkvOUv4Nz/Z5qH0iBKJPwNP5wSyX/+jjNpzRgOhU=;
        b=V/drah5YBOKDkHWsLCQJ0v0/Wvr6U53OsQQmx26OE++Rw8Rn+oEJ1V448EJb8mhZ1HYudM
        7qUuwZD1GndQqVRkPrJygNSebpHpym9jWCC33A2NubdX9FjYBlpvCjxZ4UiDWi7DbcPTLP
        YtPC3liyr1xvbLBUbgQvhQLyU/14Dtw=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-cq0dXvpIPkqK5FWJizUlCA-1; Fri, 04 Aug 2023 10:03:20 -0400
X-MC-Unique: cq0dXvpIPkqK5FWJizUlCA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1bf0c0bd5f3so3070216fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 07:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691157799; x=1691762599;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rM0KkvOUv4Nz/Z5qH0iBKJPwNP5wSyX/+jjNpzRgOhU=;
        b=fbNsYOvMuZNWI1Vy5TjaSYo5qqEat/sKSluRtqt5MLTtSAPluYp2CxJlZ9/2gc+uK8
         8gsiwwM7ypLEzvZt4IYwxDtp9Pj5IKxtPiwUrDqI9yrTkOKph3tKPRdU8qS3JkvC3CUS
         rnh8wUlKPhp+5w/Q2Slz/qlhDoIfdm2mVarYCAsM0Ymu3tg46rM51kP+U+MsCFDExFwG
         Q5UVEQe5qN+NU4+WGr7T59W3HrN985itIRyl6dTrlXSJu1I9qfs713nfvIy/b3u7xIwh
         0EiI24jzdF/0TP/ZHQSXsiuQZwxSjqDZ6SdQhp6uHl8LcdxTZQZlz5V7CHlN2zqK0JhH
         9+bg==
X-Gm-Message-State: AOJu0YylR5KsZNDdb0Nw7oV24W5DjdUp21VpzfxFAfSnJjmpJvS6Amry
        TZ8F9fQmq9cus7PmuTVd6X/pL0tTXlkf6BY1ePXsQUMyb8UuTXuWJ4tXBrFvYsoVQ+lEVar9n26
        On/gsFcOSsivHWYvsBMG4/IXe
X-Received: by 2002:a05:6870:2320:b0:1b7:89b5:7c11 with SMTP id w32-20020a056870232000b001b789b57c11mr2102325oao.9.1691157798823;
        Fri, 04 Aug 2023 07:03:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUV/leL4jrrZoKlc3LvgjHnG2JMNaqpN35nghURvLsFst5MZv4asGQ4fgwScpSVrKsB7d8LA==
X-Received: by 2002:a05:6870:2320:b0:1b7:89b5:7c11 with SMTP id w32-20020a056870232000b001b789b57c11mr2102301oao.9.1691157798536;
        Fri, 04 Aug 2023 07:03:18 -0700 (PDT)
Received: from localhost ([181.120.144.238])
        by smtp.gmail.com with ESMTPSA id y1-20020a056870388100b001b047298a44sm1111240oan.52.2023.08.04.07.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 07:03:18 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org,
        Arthur Grillo <arthurgrillo@riseup.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dave Airlie <airlied@gmail.com>, Helge Deller <deller@gmx.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Drop select FRAMEBUFFER_CONSOLE for
 DRM_FBDEV_EMULATION
In-Reply-To: <19a2a2a0-2f35-4c4e-926c-47b75e6f9353@app.fastmail.com>
References: <20230804125156.1387542-1-javierm@redhat.com>
 <CAKMK7uH=7m=2Y0SxPm2Q1J+u2MRWHNQrYy7M5se7Ua9ZA19y=A@mail.gmail.com>
 <19a2a2a0-2f35-4c4e-926c-47b75e6f9353@app.fastmail.com>
Date:   Fri, 04 Aug 2023 16:03:15 +0200
Message-ID: <87sf8ygb18.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Fri, Aug 4, 2023, at 15:07, Daniel Vetter wrote:
>> On Fri, 4 Aug 2023 at 14:52, Javier Martinez Canillas
>> <javierm@redhat.com> wrote:
>>>
>>> The commit c242f48433e7 ("drm: Make FB_CORE to be selected if DRM fbdev
>>> emulation is enabled") changed DRM_FBDEV_EMULATION from 'depends on FB'
>>> to an effective 'select FB_CORE', so any config that previously had DRM=y
>>> and FB=n now has FB_CORE=y and FRAMEBUFFER_CONSOLE=y.
>>>
>>> This leads to unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
>>> as reported by Arthur Grillo, e.g:
>>>
>>> WARNING: unmet direct dependencies detected for FRAMEBUFFER_CONSOLE
>>>   Depends on [n]: VT [=n] && FB_CORE [=y] && !UML [=y]
>>>   Selected by [y]:
>>>   - DRM_FBDEV_EMULATION [=y] && HAS_IOMEM [=y] && DRM [=y] && !EXPERT [=n]
>>>
>>> Arnd Bergmann suggests to drop the select FRAMEBUFFER_CONSOLE for the
>>> DRM_FBDEV_EMULATION Kconfig symbol, since a possible use case could
>>> be to enable DRM fbdev emulation but without a framebuffer console.
>>>
>>> Fixes: c242f48433e7 ("drm: Make FB_CORE to be selected if DRM fbdev emulation is enabled")
>>> Reported-by: Arthur Grillo <arthurgrillo@riseup.net>
>>> Closes: https://lore.kernel.org/dri-devel/20230726220325.278976-1-arthurgrillo@riseup.net
>>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>>
>> Yeah originally this was just to help people not misconfigure their
>> kernels and end up with a black screen. But select is really not a
>> nice way to do that, imo we could drop the FB_CORE select too :-)
>
> Droping the 'FB_CORE' select only works if we make FB_CORE user
> visible and add a 'depends on' for it instead. Not sure this
> is any better since this would only ever be used when either
> CONFIG_FB or CONFIG_DRM_FBDEV_EMULATION is enabled.
>

Agreed.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

