Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAE0800818
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378245AbjLAKVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378240AbjLAKVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:21:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8539FF1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 02:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701426066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Bh0vGQqG6k9jMrVj2KcvFrOUEDKVV6QIbcGZMpO/NE=;
        b=THk4CnInihMMOP5d+HzTJXiN8RgYyaMXQM7Y6VhJ3sCKNW1B+VgbRktdtIcoUElg94brXh
        qH9MoEFXXL0KUfadBU16gAm5MqFV3+HuImarJMdri22fC40IWBge3TfhEophBfMUdKg9yY
        yRS1ZRf4jx10AUT7uiMP+NcAeOSUZew=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-nw2wVhCoNQSjMjuNowhBhA-1; Fri, 01 Dec 2023 05:21:04 -0500
X-MC-Unique: nw2wVhCoNQSjMjuNowhBhA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-333127febb2so1664855f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 02:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701426064; x=1702030864;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Bh0vGQqG6k9jMrVj2KcvFrOUEDKVV6QIbcGZMpO/NE=;
        b=mBwh8aXOWh/VaFcXG3xT7iky0vJZ7jDmLScmAZQowR1p/QrKJwzzkntt68opvuffEI
         MXQdJpBIimab+9nCJXWJCkFORw+P0tzmCpbe7M/PYEIQMGf2+VEOynoV1sz7DeQ4WXMK
         /Eo506zuSXCTE6w8wg8AOOMiebX8AWpBIgWPpS3oJ/W8Vu5bDkE13l93V5YGWQkovwN2
         N3DRkemi4esK2G/aGYBWFQmmWgsyAyzni1sw464I2UI/8abWP5w6BDioRZ2jMvIXnvym
         MPJnLWvx7hNPq/ywT97mgWbSm8AySR0Uf2WbKFzRBB+ADIwEcmkV+a4jlCaTbzb5G9aB
         f+fQ==
X-Gm-Message-State: AOJu0Yy4gABW86whIhV20yo2HWqF4LsNKCzgohtuXMKRqbaZu+P/BdIz
        VFNIG1nUiIjkaoT2Bhrj5rki0k2LBRPZXS03B2Hc1Lzep6ZWpvyUwFqpTqIGyUil+HeWZZyEt/9
        j3JN4E2Gj0r9sITz9r6z70F0S
X-Received: by 2002:a05:600c:4504:b0:40b:5e21:d366 with SMTP id t4-20020a05600c450400b0040b5e21d366mr314303wmo.111.1701426063770;
        Fri, 01 Dec 2023 02:21:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH48dNlPqlwgO2N+pjIvLSQ7hASCsvohHOe8o2Sdt8EJlyAAewTySsrbSEPww2SelJYsI4ukw==
X-Received: by 2002:a05:600c:4504:b0:40b:5e21:d366 with SMTP id t4-20020a05600c450400b0040b5e21d366mr314294wmo.111.1701426063464;
        Fri, 01 Dec 2023 02:21:03 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h7-20020adf9cc7000000b0032d8eecf901sm3859764wre.3.2023.12.01.02.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 02:21:03 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Sergio Lopez <slp@redhat.com>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Hector Martin <marcan@marcan.st>,
        Andrew Worsley <amworsley@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RFC PATCH] of/platform: Disable sysfb if a simple-framebuffer
 node is found
In-Reply-To: <58672ab8-99bf-4a2a-af79-031d1e8fcba0@suse.de>
References: <20231113085305.1823455-1-javierm@redhat.com>
 <CAL_JsqKHTN5hfd4qpg5RXbmQLKZNVywDkSj9mxvfGmjrcChQQg@mail.gmail.com>
 <87jzqi59bt.fsf@minerva.mail-host-address-is-not-set>
 <CAL_JsqJM9+cbNviwuKGB5+3YbyAP3UH+TxCxsU5nUtX-iRGP2w@mail.gmail.com>
 <CAMj1kXG7Xyk0ys9j-XRo7Rr8gYz1qJE8fFSixBOwVbm-pjeX+A@mail.gmail.com>
 <874jhj1fm3.fsf@minerva.mail-host-address-is-not-set>
 <58672ab8-99bf-4a2a-af79-031d1e8fcba0@suse.de>
Date:   Fri, 01 Dec 2023 11:21:02 +0100
Message-ID: <87fs0mxlyp.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi
>
> Am 18.11.23 um 12:10 schrieb Javier Martinez Canillas:
>> Ard Biesheuvel <ardb@kernel.org> writes:
>> 
>> Hello Ard,
>> 
>>> On Fri, 17 Nov 2023 at 00:09, Rob Herring <robh@kernel.org> wrote:
>> 
>> [...]
>> 
>>>>>>
>>>>>> This could also lead to an interesting scenario. As simple-framebuffer
>>>>>> can define its memory in a /reserved-memory node, but that is ignored
>>>>>> in EFI boot. Probably would work, but only because EFI probably
>>>>>> generates its memory map table from the /reserved-memory nodes.
>>>>>>
>>>>>
>>>>> I see. So what would be the solution then? Ignoring creating a platform
>>>>> device for "simple-framebuffer" if booted using EFI and have an EFI-GOP?
>>>>
>>>> Shrug. I don't really know anything more about EFI FB, but I would
>>>> guess it can't support handling resources like clocks, power domains,
>>>> regulators, etc. that simple-fb can. So if a platform needs those, do
>>>> we say they should not setup EFI-GOP? Or is there a use case for
>>>> having both? Clients that don't muck with resources can use EFI-GOP
>>>> and those that do use simple-fb. For example, does/can grub use
>>>> EFI-GOP, but not simple-fb?
>>>>
>>>
>>> The EFI GOP is just a dumb framebuffer, and it is not even generally
>>> possible to cross reference the GOP with a particular device in the
>>> device hierarchy unless you e.g., compare the BARs of each device with
>>> the region described by the GOP protocol.
>>>
>>> GRUB for EFI will use the GOP and nothing else, but only at boot time
>>> (the GOP protocol is more than a magic linear memory region, it also
>>> implements a Blt() abstraction that permits the use of framebuffers
>>> that are not mapped linearly into the address space at all, and GRUB
>>> makes use of this)
>>>
>>> The EFI stub will only expose GOPs to the kernel if they are in fact
>>> linear framebuffers, but has zero insight into whether the hardware
>>> needs clocks and regulators, and whether or not the framebuffer needs
>>> IOMMU pass through (which might be the case if the scanout is using
>>> DMA into system memory)
>>>
>>> So calling EFI GOP 'source of truth' is rather generous, and I think
>>> it makes sense to prioritize more accurate descriptions of the
>>> underlying framebuffer over EFI GOP.
>>>
>> 
>> That was my opinion as well and the reason why I called the DTB the
>> single source of truth.
>> 
>>> However, making 'simple-framebuffer' magic in this regard doesn't seem
>>> like a great approach to me. Is there a better way we could get the
>>> resource conflict to be decided in a way where the EFI GOP gets
>>> superseded if its resources are claimed by another device?
>>>
>> 
>> There is an aperture [0] framework that is used by the fbdev and DRM
>> subsystems to allow native drivers to remove any conflicting devices
>> that share the same framebuffer aperture.
>> 
>> But it only makes sense for native drivers to use that I think, but
>> in this case is about two drivers that attempt to use the same frame
>> buffer provided by the firmware but getting it from different places.
>> 
>> I don't have a better idea than this patch but maybe Thomas or Sima do?
>
> At SUSE, we've carried such a patch in our repos for some time. It works 
> around the double-framebuffer problem in a similar way. [1]
>

Thanks for the information. I see that your patch is basically mine but
doing it unconditionally while this one only does the sysfb_disable() if
a "simple-framebuffer" DT node has been found.

> As Javier mentioned, we do track the framebuffer ranges for EFI/VESA/OF 
> framebuffers in the graphics aperture helpers. Fbdev has done this for 
> decades, and the current codebase extends and harmonizes this 
> functionality among fbdev and DRM drivers.
>
> WRT DT vs EFI: AFAIK the EFI support on affected platforms looks at the 
> DT to set up the EFI framebuffer. So IMHO the DT is the authoritative 
> source on the framebuffer.
>

Agreed. Sima Vetter also mentioned on IRC that they think this patch is
the least bad option. Rob, Ard any thoughts? Maybe we can land this as
a fix and then figure how this could be better handled in the long term?

> Best regards
> Thomas
>
> [1] https://bugzilla.suse.com/show_bug.cgi?id=1204315
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

