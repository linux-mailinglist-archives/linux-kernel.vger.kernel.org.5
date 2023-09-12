Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E101179C888
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjILHtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjILHtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:49:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F13F4E7A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694504893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2B0WC8PzLNLdGRasGQ/ag9W7qGL3oBFmynvW1yiJ2zE=;
        b=DR7DB/PTgaV89H09PpN2cmXUy1QTCcibPArTICn4mAg9cssZ3X/a2xxD0ycE8Qnt8EkN9k
        HAbx0BuQoGA5RqPWZ+9qArPBZXCD9Dtda7CChEL/o1yD+Nr3jDdKYbevkSFI26bjGWjZud
        LTFCWl5fZf/ER/tK2NtZ1ANNyP1jMqE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-WNu2mFOyO_a4WGEl4HEuNw-1; Tue, 12 Sep 2023 03:48:11 -0400
X-MC-Unique: WNu2mFOyO_a4WGEl4HEuNw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-401c4f03b00so42199185e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694504890; x=1695109690;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2B0WC8PzLNLdGRasGQ/ag9W7qGL3oBFmynvW1yiJ2zE=;
        b=gL/erWC1Vv9CjiLMtVtZ3msKS8NLxZNvCnvEAdo5LPEcd9c+aTizusu/RvrHatlcTh
         cE+uaKm6Q3mI8+FdJ5PJYOj1o2/2Ri2G+nR9DtOKkPBmOw4yr8XCrJlEc5l9twsv0Nha
         P9JD8Z9TCTAOsb0+F5xeaeQefcpPotG92DtqK4IZk4SS1OVoheGB6TE4McXCld4WoyLS
         d7MzO5m7QtvkbuHDv/5jZ56VWUzL5uxu6uc92gyq9/rz1rBRFukHeqA3PzUgohmUuaQF
         ecnXr2IcKwp7M6spQwgGOmmnwO45hQxdlghWUKqqVQKzURbqLciCg7a6BLO0fGoRDL/g
         I/vg==
X-Gm-Message-State: AOJu0YxZb9m+iwuqHzKyGg86yCHg+Ir//X0NUtz4EXMdlzVh8ANlW9kh
        SYzH67L2MnKR6klj/KaDLofmy7izF9HiW8DgpYeG6lSGMWNvz3tpUj+0z/hu7MMRCexb+vDXA1q
        1/3WF8ttulxWJJuudp4hS2ZZD
X-Received: by 2002:a1c:7508:0:b0:3fe:1f93:8cf4 with SMTP id o8-20020a1c7508000000b003fe1f938cf4mr9447296wmc.8.1694504890542;
        Tue, 12 Sep 2023 00:48:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+rSaX2GVdThWkFlifttXlbzNXae8MOoKXkiRAt9ShgN0wMc6R6A+/mp5KLadFPQ6BmDhQJQ==
X-Received: by 2002:a1c:7508:0:b0:3fe:1f93:8cf4 with SMTP id o8-20020a1c7508000000b003fe1f938cf4mr9447271wmc.8.1694504890238;
        Tue, 12 Sep 2023 00:48:10 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g17-20020a7bc4d1000000b003fc02e8ea68sm15255183wmk.13.2023.09.12.00.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:48:10 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] drm: fix up fbdev Kconfig defaults
In-Reply-To: <CAMuHMdWizKkuLEcv8sFFOWPib-0e1onCRuQEZm6OhV592VWUKQ@mail.gmail.com>
References: <20230911205338.2385278-1-arnd@kernel.org>
 <CAMuHMdWizKkuLEcv8sFFOWPib-0e1onCRuQEZm6OhV592VWUKQ@mail.gmail.com>
Date:   Tue, 12 Sep 2023 09:48:09 +0200
Message-ID: <87a5tr3k92.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

Hello Geert,

> Hi Arnd,
>
> On Mon, Sep 11, 2023 at 10:53=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> =
wrote:

[...]

>> --- a/drivers/gpu/drm/Kconfig
>> +++ b/drivers/gpu/drm/Kconfig
>> @@ -135,7 +135,7 @@ config DRM_FBDEV_EMULATION
>>         bool "Enable legacy fbdev support for your modesetting driver"
>>         depends on DRM
>>         select FRAMEBUFFER_CONSOLE_DETECT_PRIMARY if FRAMEBUFFER_CONSOLE
>> -       default y
>> +       default FB
>
> While this is true for existing configs, it is no longer true in general,
> as DRM_FBDEV_EMULATION is no longer related to FB.
>

Maybe default y if (FB_DEVICE || FRAMEBUFFER_CONSOLE) ?

>>         help
>>           Choose this option if you have a need for the legacy fbdev
>>           support. Note that this support also provides the linux console
>> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconf=
ig
>> index b575cf54174af..83c2d7329ca58 100644
>> --- a/drivers/video/console/Kconfig
>> +++ b/drivers/video/console/Kconfig
>> @@ -74,6 +74,7 @@ config DUMMY_CONSOLE_ROWS
>>  config FRAMEBUFFER_CONSOLE
>>         bool "Framebuffer Console support"
>>         depends on FB_CORE && !UML
>> +       default DRM_FBDEV_EMULATION
>
> Sounds good to me, although it looks a bit strange at first sight
> (FRAMEBUFFER_CONSOLE defaults to n on a system with real fbdev, but
> y on emulated fbdev?).

And there Maybe default y if (FB || DRM_FBDEV_EMULATION) ?

> So this is the fix for commit a5ae331edb02b ("drm: Drop select
> FRAMEBUFFER_CONSOLE for DRM_FBDEV_EMULATION").
>
>>         select VT_HW_CONSOLE_BINDING
>>         select CRC32
>>         select FONT_SUPPORT
>> diff --git a/drivers/video/fbdev/core/Kconfig b/drivers/video/fbdev/core=
/Kconfig
>> index 114cb8aa6c8fd..804c2bec9b43c 100644
>> --- a/drivers/video/fbdev/core/Kconfig
>> +++ b/drivers/video/fbdev/core/Kconfig
>> @@ -28,7 +28,7 @@ config FIRMWARE_EDID
>>  config FB_DEVICE
>>         bool "Provide legacy /dev/fb* device"
>>         depends on FB_CORE
>> -       default y
>> +       default FB
>
> Changing this means possibly causing regressions on systems running
> an fbdev userspace.
>

Right, specially if using DRM fbdev emulation since then the default will
be different between v6.5 and v6.6 (that's what this patch tries to avoid).

So probably we could keept that default as 'y'.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

