Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111E57EB4BC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjKNQ2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjKNQ2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:28:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52E0116
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699979317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zT55sICneOruB98vZghCPIaAQzAuT2+qJvhhUcjEcFU=;
        b=XkBq32wEBh2K4uBSL0gBD4FbCaIaLCkSfXN9oHb7Gi8BKTYLsKuMNqtuHEg8wcmLjclaEM
        BfAjOt8gVbwC7n2iE91LCm4EKwZQayNeFx8BVSqaCrLbETAl+lBX8x2vvTdL0E3C5bRF+7
        TQOzKaQlNXZJYpfs/3JFnmkeUVFzSME=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-BQNbCFU0N9GfFYFjeKaz8Q-1; Tue, 14 Nov 2023 11:28:35 -0500
X-MC-Unique: BQNbCFU0N9GfFYFjeKaz8Q-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b6cb6a1a7fso5707607b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699979315; x=1700584115;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zT55sICneOruB98vZghCPIaAQzAuT2+qJvhhUcjEcFU=;
        b=b7+3kfPglqoLWL6fWFC9w0yLwVjWhhMsNV40s4KAsrlY1nKVQ7teLc79MvA7slBHbY
         +gXDHy8xBvoT5h2nFmXq6qF3dPkbqqBayJ0ESaVnxSkbrjsgUDh8lW0+W2DVKEZDS42/
         rXf0Y4aXoXmHFS0m8cOfzJaL9FcInuA6d/5mDOx8m8G684CL4qLvlsWW6LrFkUeUCtsG
         Jx2KjGX48eOP4GMp2rvnz790Wyn3HKwD+DNDx/yhwGJD1z5wMdHx1AOYg0KqGqmBd5qe
         icKZWZw1v5pri86FKG+6MkLtPKmfe5ygbcxxkuzStzplRDBpeZMFzI7HhI/GBPDK8rDq
         VnsQ==
X-Gm-Message-State: AOJu0Ywpf5f2skgg2DrMqP+CtgV7MirymMAxV2D2zNtDlaQUKK6h/1n+
        V+yTg61wGKgH/pXQHQ9C3ZC16zi/NBCnWh61xRMRAzmcNlzQRHtr4rBJ0dJWw5qysfVu//BVuRZ
        V2cWKXGirfQUVZ1KxguJ5zx/X
X-Received: by 2002:a05:6808:1b13:b0:3b6:db1b:67be with SMTP id bx19-20020a0568081b1300b003b6db1b67bemr12820726oib.16.1699979315247;
        Tue, 14 Nov 2023 08:28:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCs4OZHiYJNQd+EbwIGjg3wDC1a9KzyEDPS/n5hkAeLDacLMu9zBSwKsOA9Yp+3SBU3M3l2g==
X-Received: by 2002:a05:6808:1b13:b0:3b6:db1b:67be with SMTP id bx19-20020a0568081b1300b003b6db1b67bemr12820694oib.16.1699979314953;
        Tue, 14 Nov 2023 08:28:34 -0800 (PST)
Received: from localhost ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id t26-20020a05620a005a00b0077263636a95sm2768517qkt.93.2023.11.14.08.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 08:28:34 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     Simon Ser <contact@emersion.fr>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Maxime Ripard <mripard@kernel.org>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Erico Nunes <nunes.erico@gmail.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        Zack Rusin <zackr@vmware.com>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 0/6] drm: Allow the damage helpers to handle buffer damage
In-Reply-To: <9296c184-22c1-4d71-8b11-2d26f49a5790@suse.de>
References: <20231109172449.1599262-1-javierm@redhat.com>
 <9296c184-22c1-4d71-8b11-2d26f49a5790@suse.de>
Date:   Tue, 14 Nov 2023 17:28:32 +0100
Message-ID: <87wmuk5mfj.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi Javier
>
> Am 09.11.23 um 18:24 schrieb Javier Martinez Canillas:
>> Hello,
>> 
>> This series is to fix an issue that surfaced after damage clipping was
>> enabled for the virtio-gpu by commit 01f05940a9a7 ("drm/virtio: Enable
>> fb damage clips property for the primary plane").
>> 
>> After that change, flickering artifacts was reported to be present with
>> both weston and wlroots wayland compositors when running in a virtual
>> machine. The cause was identified by Sima Vetter, who pointed out that
>> virtio-gpu does per-buffer uploads and for this reason it needs to do
>> a buffer damage handling, instead of frame damage handling.
>
> I'm having problem understanding the types of damage. You never say what 
> buffer damage is. I also don't know what a frame is in this context.
>
> Regular damage handling marks parts of a plane as dirty/damaged. That is 
> per-plane damage handling. The individual planes more or less 
> independent from each other.
>
> Buffer damage, I guess, marks the underlying buffer as dirty and 
> requires synchronization of the buffer with some backing storage. The 
> planes using that buffer are then updated more or less automatically.
>
> Is that right?
>

In both cases the damage tracking information is the same, they mark
the damaged regions on the plane in framebuffer coordinates of the
framebuffer attached to the plane.

The problem as far as I understand is whether the driver expects that
to determine the area that changed in the plane (and a plane flush is
enough) or the area that changed since that same buffer was last used.

> And why does it flicker? Is there old data stored somewhere?
>

It flickers because the framebuffer changed and so the damage tracking
is not used correctly to flush the damaged areas to the backing storage.

This is my understanding at least, please Sima or Simon correct me if I
got this wrong.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

