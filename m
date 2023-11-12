Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5124C7E918E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 16:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjKLPuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 10:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjKLPul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 10:50:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD89B270C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 07:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699804192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1iGUBaKM2azxvdhKt2504NIadxJuEuzBdu7h+LqBo+w=;
        b=dL2fOY+n9IQHfX8FcgAb1+apwkgg3BMUv9YD7JTchwYIVwtPS94p33eqG96aYy6c2S0ZWD
        yKXDUkdhv14d0xn8QNLMFfCH2k2EbeGExmiRzJ3+fGyFBXY7WSXWv3SqguS7sUBglNmOI+
        rDgmKkO1OIvLwUiqLppcgsjp+XtpBOA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-d3c2ag9EOu204FfuEj8IUA-1; Sun, 12 Nov 2023 10:49:51 -0500
X-MC-Unique: d3c2ag9EOu204FfuEj8IUA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40839252e81so23619335e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 07:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699804190; x=1700408990;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1iGUBaKM2azxvdhKt2504NIadxJuEuzBdu7h+LqBo+w=;
        b=sUjh9sPkpdb5tjKUNMmSdeRgqPR0CgwnOp7gsO4rBd81rFAYg+htUVaW2oGd+DN71D
         Y2W410SoubtMz4z2YfUCCusZcG+640affrZiYQMAVkpB9mQFrlhCNvVyMERqulq/yfMq
         uuxE8B9aFxm0CTgXJ/SVMurSB8HJjGoZRhHiiBt5ilQNlyowWTe7o4QFehjWvjlAvJwq
         KGgVppEh2B1WbOIsNRpk76p3kaHgoAKGOjrVuLeS40uPtFt1oFME4DJqo+Kt1l9cbXf7
         /RfYDUHERBvcE3GRmTuvUDMIsbyKb4EuBRMjCTF6b7da1xneOcI7rwEPFR6nQeP+5PKJ
         SyLg==
X-Gm-Message-State: AOJu0YzjKb+1+FaOyj0b+xADeMjEXO85a8XOPdYCbWHg5Ny+XU3Xrtdq
        Obj9UhkEsbHR8ODQv+nai+xTSqdGhgW0xzgWEnlgPqythx3xzHc63Nev4OQEEQTkZYJKN5Fj+OM
        U5Ebd6thnSlobb7ESGqHKz6dt
X-Received: by 2002:a05:600c:450a:b0:409:375:5a44 with SMTP id t10-20020a05600c450a00b0040903755a44mr3732203wmo.24.1699804190079;
        Sun, 12 Nov 2023 07:49:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUuuVMqtepn8YqkS2uXyv/BIU5zsNbbkXjFlgY9AV4c/T4BJKy5pu+jFjucMYUqC95FSxPsA==
X-Received: by 2002:a05:600c:450a:b0:409:375:5a44 with SMTP id t10-20020a05600c450a00b0040903755a44mr3732194wmo.24.1699804189595;
        Sun, 12 Nov 2023 07:49:49 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z14-20020adff74e000000b0032f7865a4c7sm3530465wrp.21.2023.11.12.07.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 07:49:49 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Andrew Worsley <amworsley@gmail.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR FIRMWARE FRAMEBUFFERS" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix failure of simpledrm probe when trying to grab FB
 from the EFI-based Framebuffer
In-Reply-To: <87a5rj9s37.fsf@minerva.mail-host-address-is-not-set>
References: <20231111042926.52990-1-amworsley@gmail.com>
 <20231111042926.52990-2-amworsley@gmail.com>
 <CA+Y=x3mF4jFX7PiJQ-1Gk9zyBE1mwZaF_GLYjSspT+mxtMn4GQ@mail.gmail.com>
 <87cywgac4r.fsf@minerva.mail-host-address-is-not-set>
 <CA+Y=x3nift8Xt_zT1na7D3ReRwy6Lh66Cszz9zkBpkz7tka20w@mail.gmail.com>
 <87a5rj9s37.fsf@minerva.mail-host-address-is-not-set>
Date:   Sun, 12 Nov 2023 16:49:48 +0100
Message-ID: <877cmn9dk3.fsf@minerva.mail-host-address-is-not-set>
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

Javier Martinez Canillas <javierm@redhat.com> writes:

[...]

>
> Reported-by: Andrew Worsley <amworsley@gmail.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>  drivers/of/platform.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>

Forgot to include the header file and just pointed out by the robot, so
need the following snippet too:

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index f235ab55b91e..2894d03f4415 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -20,6 +20,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/sysfb.h>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

