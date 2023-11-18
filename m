Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014577EFF2C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 12:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjKRLK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 06:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjKRLKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 06:10:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593DBD6C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 03:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700305849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zcW40Pm/C2VhC3hYpvH2rN7+M3PaPEN3Ao5G1XKi4yM=;
        b=OEdsLfjcdDRwEE9Mxl7WQL713jqJ8J1PEqAukqrObtaRViHDxvqZakO2zBdtSq4NHDkDWD
        pOQKDVIV8s8VrMpcAOncIZPxt2fcF8BIL8yzfoM138+esC+FZ/ZEsSWzQZY2ype6HR/oUW
        IoXPXCjhaDuOyKt5Z7BXm+S8FDuxrOY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-YJxqXrZiM-Sq6Et9oJhhlA-1; Sat, 18 Nov 2023 06:10:47 -0500
X-MC-Unique: YJxqXrZiM-Sq6Et9oJhhlA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4083a670d25so2471965e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 03:10:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700305846; x=1700910646;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcW40Pm/C2VhC3hYpvH2rN7+M3PaPEN3Ao5G1XKi4yM=;
        b=lgc1dT0enOcX7aOHZ84E46ariGZzkeHjqwmCkGYHDqZ2ir5uRKvXSv8UDNnHcjog2M
         5ZCRW31ribUjKQoOCcCpWp0lOSF3pbzXMnCN3F+KyKCUHxkB4x5BxakJEbKmhBCNp2ya
         bCvK6Q9LiLu3p5Ztrg9zWNTCjNFVFINm2aGPQUXrPputLsrlu3gjzedG4GtYYrx2f6Qh
         1K5BwSVlAFo4B+duRvXpCjbyjfL8BYm63oHodOsYfSo6gJsgWjLnOvUANzrCrt2AStG7
         RHpTImV+lSQ8U2Z1TVKZss2WAmklvC6Cq7Z8zF50R4KTgImDtyRtD6admXAcgJ85UTl4
         Fg/Q==
X-Gm-Message-State: AOJu0YyXkylzIdCz4eu9R5FlOC6LRIo0HclkDhUmoJgJtDHR0dcUTkK2
        td5nmr8yI1L9KBTKws1HhvMQlgQhOfaFPKE5buiThvZOzS8mWUKyKUH5FUW+7Sm8f/b3y/xFzba
        1ffArKSpy+OHn34nrPmopqMLI
X-Received: by 2002:adf:ef92:0:b0:32d:9cdd:a23 with SMTP id d18-20020adfef92000000b0032d9cdd0a23mr1563667wro.25.1700305846414;
        Sat, 18 Nov 2023 03:10:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5Qbad3a6WzEcATGME42HhfaqZx1bG/yleXweOgoccNqiDLr2I5NcRH9p1kx3aG3lak43/aA==
X-Received: by 2002:adf:ef92:0:b0:32d:9cdd:a23 with SMTP id d18-20020adfef92000000b0032d9cdd0a23mr1563650wro.25.1700305845984;
        Sat, 18 Nov 2023 03:10:45 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o6-20020a5d4086000000b003316e684c5esm2950657wrp.79.2023.11.18.03.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 03:10:45 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Sergio Lopez <slp@redhat.com>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Hector Martin <marcan@marcan.st>,
        Andrew Worsley <amworsley@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] of/platform: Disable sysfb if a simple-framebuffer
 node is found
In-Reply-To: <CAMj1kXG7Xyk0ys9j-XRo7Rr8gYz1qJE8fFSixBOwVbm-pjeX+A@mail.gmail.com>
References: <20231113085305.1823455-1-javierm@redhat.com>
 <CAL_JsqKHTN5hfd4qpg5RXbmQLKZNVywDkSj9mxvfGmjrcChQQg@mail.gmail.com>
 <87jzqi59bt.fsf@minerva.mail-host-address-is-not-set>
 <CAL_JsqJM9+cbNviwuKGB5+3YbyAP3UH+TxCxsU5nUtX-iRGP2w@mail.gmail.com>
 <CAMj1kXG7Xyk0ys9j-XRo7Rr8gYz1qJE8fFSixBOwVbm-pjeX+A@mail.gmail.com>
Date:   Sat, 18 Nov 2023 12:10:44 +0100
Message-ID: <874jhj1fm3.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ard Biesheuvel <ardb@kernel.org> writes:

Hello Ard,

> On Fri, 17 Nov 2023 at 00:09, Rob Herring <robh@kernel.org> wrote:

[...]

>> > >
>> > > This could also lead to an interesting scenario. As simple-framebuffer
>> > > can define its memory in a /reserved-memory node, but that is ignored
>> > > in EFI boot. Probably would work, but only because EFI probably
>> > > generates its memory map table from the /reserved-memory nodes.
>> > >
>> >
>> > I see. So what would be the solution then? Ignoring creating a platform
>> > device for "simple-framebuffer" if booted using EFI and have an EFI-GOP?
>>
>> Shrug. I don't really know anything more about EFI FB, but I would
>> guess it can't support handling resources like clocks, power domains,
>> regulators, etc. that simple-fb can. So if a platform needs those, do
>> we say they should not setup EFI-GOP? Or is there a use case for
>> having both? Clients that don't muck with resources can use EFI-GOP
>> and those that do use simple-fb. For example, does/can grub use
>> EFI-GOP, but not simple-fb?
>>
>
> The EFI GOP is just a dumb framebuffer, and it is not even generally
> possible to cross reference the GOP with a particular device in the
> device hierarchy unless you e.g., compare the BARs of each device with
> the region described by the GOP protocol.
>
> GRUB for EFI will use the GOP and nothing else, but only at boot time
> (the GOP protocol is more than a magic linear memory region, it also
> implements a Blt() abstraction that permits the use of framebuffers
> that are not mapped linearly into the address space at all, and GRUB
> makes use of this)
>
> The EFI stub will only expose GOPs to the kernel if they are in fact
> linear framebuffers, but has zero insight into whether the hardware
> needs clocks and regulators, and whether or not the framebuffer needs
> IOMMU pass through (which might be the case if the scanout is using
> DMA into system memory)
>
> So calling EFI GOP 'source of truth' is rather generous, and I think
> it makes sense to prioritize more accurate descriptions of the
> underlying framebuffer over EFI GOP.
>

That was my opinion as well and the reason why I called the DTB the
single source of truth.

> However, making 'simple-framebuffer' magic in this regard doesn't seem
> like a great approach to me. Is there a better way we could get the
> resource conflict to be decided in a way where the EFI GOP gets
> superseded if its resources are claimed by another device?
>

There is an aperture [0] framework that is used by the fbdev and DRM
subsystems to allow native drivers to remove any conflicting devices
that share the same framebuffer aperture.

But it only makes sense for native drivers to use that I think, but
in this case is about two drivers that attempt to use the same frame
buffer provided by the firmware but getting it from different places.

I don't have a better idea than this patch but maybe Thomas or Sima do?

[0]: https://elixir.bootlin.com/linux/latest/source/drivers/video/aperture.c

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

