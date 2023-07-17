Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EEC755EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjGQJBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjGQJBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C2EA1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689584418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Itt90Gux0jb2OT7jpr0Odfrrivk8UdcQyUry5wTCds4=;
        b=e0JX2FlmUqX/CXUbIyF5rlz0SdHOfFlsENQrLsdZe/2GnF4631f9izgb4dpuN/7XW/oteY
        YDCfQsngFVHnrkSuMZ1DU/4oBSu0S4XPqRU06dh6mR6B4W0Askh2M/gSxxmBeAUZgbCFWN
        yRjc0oWureNKrBzRVHKfaMm4wsmk/b4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-gntwG0boN8mEp3CVpR36xg-1; Mon, 17 Jul 2023 05:00:16 -0400
X-MC-Unique: gntwG0boN8mEp3CVpR36xg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fc00d7d62cso26378705e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689584415; x=1692176415;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Itt90Gux0jb2OT7jpr0Odfrrivk8UdcQyUry5wTCds4=;
        b=hS5COUTtnfOAxYYKN9KauOWxMCEBii7jH08/1VOkmMrM6seI5l3Ggd9sDf6C/HeeVd
         bMhtnjahoCC+ajO95bpec709A3LJaofAfldZ/3UEl95aAyUyIKOHYhS8frCbDZmDJ+SK
         weMr3Y7L4GS5WSUDQck8XeWmhlXDOw3W7bBg/Hh/lMArecHpyZixwYwnHmfdmz+TJFMp
         ByRq+HSMcNOD4VTCp8O87PPIB2rhJrxIM9KotGYEtgzZdAphNhVtFn6k92FgXhOv/PiJ
         lFo87XPhbsWXaY2HFK3u1roTlKpz9Qb3bw79iM2l8af+RVPOValv2K8ZQJwXdCPCqZ5z
         9W/w==
X-Gm-Message-State: ABy/qLay/rehuhd1NkS+yC+Gb+A8iDP5SRndgqmB7yEH0NnCZlplpTt9
        Ly6XWCaYRIQtVUCoBvKg281eF5jgokB7/OBf4P6Qd+Z95W8mAKwIalr4BRrxUcpIrkBjZZRaoNP
        GrozQiWyQQtErs9Tn7Y3TLWL3
X-Received: by 2002:a1c:6a14:0:b0:3fc:186:284d with SMTP id f20-20020a1c6a14000000b003fc0186284dmr9864514wmc.18.1689584415474;
        Mon, 17 Jul 2023 02:00:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGDHkpkyeESX7xooqF0K6wFlMJilZYbngZvoyjjN8XTXh/IMVtAl4W74et1UyCmFZIWMbN/Bg==
X-Received: by 2002:a1c:6a14:0:b0:3fc:186:284d with SMTP id f20-20020a1c6a14000000b003fc0186284dmr9864495wmc.18.1689584415132;
        Mon, 17 Jul 2023 02:00:15 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f17-20020a7bcd11000000b003fc02218d6csm7415959wmj.25.2023.07.17.02.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 02:00:14 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] drm/ssd130x: Fix an oops when attempting to update a
 disabled plane
In-Reply-To: <bbbb18e0-5de1-5155-c6b2-52a2b1d75898@suse.de>
References: <20230713163213.1028952-1-javierm@redhat.com>
 <bbbb18e0-5de1-5155-c6b2-52a2b1d75898@suse.de>
Date:   Mon, 17 Jul 2023 11:00:13 +0200
Message-ID: <87r0p6kj4y.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Hi
>
> Am 13.07.23 um 18:32 schrieb Javier Martinez Canillas:

[...]

>>   
>> +static const struct drm_mode_config_helper_funcs ssd130x_mode_config_helpers = {
>> +	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
>> +};
>> +
>
> After some discussion on IRC, I'd suggest to allocate the buffer 
> somewhere within probe. So it will always be there when the plane code runs.
>

Yes, that's also what Geert suggested so I'll just do that. And also make
it a dev managed resource.

> A full fix would be to allocate the buffer memory as part of the plane 
> state and/or the plane's atomic_check. That's a bit more complicated if 
> you want to shared the buffer memory across plane updates.
>

I don't think is worth the complexity, allocating it on probe and released
when the device is unbound from the driver should be enough as Geert said.

> Best regards
> Thomas
>
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

