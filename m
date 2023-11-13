Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97F87E9D00
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjKMNTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjKMNTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:19:50 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39B3D6D;
        Mon, 13 Nov 2023 05:19:46 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-543923af573so6838566a12.0;
        Mon, 13 Nov 2023 05:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699881585; x=1700486385; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a11+eNzvbF/kcPW9cn/ZnakaOTTklV9oL65Bkb1+y/k=;
        b=bWcyZQXCx9hYpzFp4tT/EegmlDgrExuXYHPMJ5IM6avKKM/NSXcyE/NBcsocPYA/SB
         Kxw2PTc2ynLI70jfzuE2985YP8RiVdkT1u0ewbVtoCJwm7GtFcvi6j09kEKoc69t+yls
         3+6vODiJEs1tyRYPqlnxm4enRqvs/RVrooKPC20L71NH8d3wZeIuvFmdXoNJ+jm8LqHd
         FJXqQsRilXVjkuiRLHdVvLPqpPuNQmFSyVmtau95Iea+uBfvb/VMzIG8vEiuzOpa8k2i
         eSWe5Q3gAZyybmo2CRHXqqjPV6D8VjJH0B+nBak6WAND66Xlsdhw/tRhJVqLke2vvVfL
         ZYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699881585; x=1700486385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a11+eNzvbF/kcPW9cn/ZnakaOTTklV9oL65Bkb1+y/k=;
        b=gHG4BRnMskKvoGYfMCpIlO/eI9+BC0wSAcxzrqUslEBHN4ksnc8+CBvlIQ9Gatq30+
         WoeL9A2RnFmR7eyDbBvVZ7cQadMChUWhsBx9yKb6BQR3egA0Qizgh2H3jjlrmO2F2hb7
         tQuLFF8MGJRJS7ByWHgO86B87bbgAexyOCRMTLnIgFH1smVzsHtvWE8doWSQG/QVYTwr
         BukA9VzXUlOQLXcS3Uoq9ISJUk1gWt8BtHmu9TM09Uz3BCBitRaVdM8T1dh0fgB09aCg
         sAzaHCH5ixvWfTBNoepdAIBJ9wAEWZFzdh975gPpHKsdGbjjVpLQ2s0tiwsB9Ia4Qj8r
         JKdg==
X-Gm-Message-State: AOJu0YxH42RkCed7b9D+SaJKc5hT4cAlrxsqW+x63N/1TLK6ead/DkPK
        KkMoJIyY2BwXTwHmstBbw/tJYSQ/S42vsuotraE=
X-Google-Smtp-Source: AGHT+IHZ1mrDGCDvnEEZdKV40pAG5QOVaBtnmaQQxpB8mtkmNVOSVGIKXdmvf+TFCt/wVxUanlemmdwWbrlwjW5k6ew=
X-Received: by 2002:aa7:d6d1:0:b0:53e:b8e2:1d58 with SMTP id
 x17-20020aa7d6d1000000b0053eb8e21d58mr4690928edr.13.1699881585138; Mon, 13
 Nov 2023 05:19:45 -0800 (PST)
MIME-Version: 1.0
References: <20231113085305.1823455-1-javierm@redhat.com> <9f3d3c8d-fbf1-485b-9c2a-4d442733954d@suse.de>
 <CA+Y=x3khfKx_oQYABMSCAPOEuDWyZ+MyTHK=JufH8fC-m6z7Xw@mail.gmail.com> <8734x9steb.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <8734x9steb.fsf@minerva.mail-host-address-is-not-set>
From:   Andrew Worsley <amworsley@gmail.com>
Date:   Tue, 14 Nov 2023 00:19:33 +1100
Message-ID: <CA+Y=x3=AC8uFyq2n7GmWLFR8xbw__SRiFmGSxo914gN3e5HQxw@mail.gmail.com>
Subject: Re: [RFC PATCH] of/platform: Disable sysfb if a simple-framebuffer
 node is found
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        Hector Martin <marcan@marcan.st>,
        Sergio Lopez <slp@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2023 at 23:57, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Andrew Worsley <amworsley@gmail.com> writes:
>
> Hello Andrew,
>
> > On Mon, 13 Nov 2023 at 20:18, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >> Am 13.11.23 um 09:51 schrieb Javier Martinez Canillas:
> >> > Some DT platforms use EFI to boot and in this case the EFI Boot Services
> >> > may register a EFI_GRAPHICS_OUTPUT_PROTOCOL handle, that will later be
> >> > queried by the Linux EFI stub to fill the global struct screen_info data.
> >> >
>
> [...]
>
> >
> > I applied the patch and just the simpledrm driver is probed (the efifb is not):
> >
>[...]
>
> Great, thanks for testing. The patch works then as expected. Can I get
> your Tested-by then ?

Sure absolutely.
>
> >
[...]
> We were talking with Thomas that the sysfb design seems to be reaching its
> limits and need some rework but currently you either need some driver that
> matches the "simple-framebuffer" device that is registered by OF or won't
> get an early framebuffer in the system.
>
> That could be either simpledrm or simplefb. But if a DT has a device node
> for "simple-framebuffer", how can the OF core know if there is a driver to
> match that device? And same for any other device defined in the DTB.
>
> It's similar on platforms that use sysfb to register the device (e.g: x86)
> since either "simple-framebuffer" is registered (if CONFIG_SYSFB_SIMPLEFB
> is enabled) or "efi-framebuffer" (if CONFIG_SYSFB_SIMPLEFB is disabled).
>
> That means CONFIG_SYSFB_SIMPLEFB=y and CONFIG_DRM_SIMPLEDRM disabled won't
> work either, even if CONFIG_FB_EFI=y which is the case you are mentioning.
>
> What I think that doesn't make sense is to remove conflicting framebuffers
> from drivers that can only handle firmware provided framebuffers. As said
> in the other thread, drm_aperture_remove_framebuffers() is only meant for
> native DRM drivers.

Ok - I'm taking it that conflicts between EFI and DT didn't happen in the past
but when they do DT wins. I guess there may be more such conflicts in
the future so
would be resolved in a similar way as more drivers are updated to
support DT settings.
Perhaps one day all drivers would have DT settings and this could be
standardised in some way.


> --
> Best regards,
>
> Javier Martinez Canillas
> Core Platforms
> Red Hat
>
Thanks

Andrew
