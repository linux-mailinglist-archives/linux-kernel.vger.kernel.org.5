Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED74C7938C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjIFJrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjIFJrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:47:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0F81BD3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693993535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UlEOBu/VE6tjdzL9UJOCpexRbWh3hX2rULyWpu7l158=;
        b=cilXly8NEdvxAyKzLGZlv06W8dA75Ea6BSaoIp2ClcIdR5an/I8fCSJoEbRih1+pk13eqb
        VeT318nob5fuZf3Hy81u0V2nDBrUL2dssxdzqAVPrsd365jMIX5sBbiVVvp7xDzHbqqcxn
        gtWEbMcVYBvv7NuHVujOh4y0mS6p/pU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-N4sRPqNIP2CegU5UaP3z8w-1; Wed, 06 Sep 2023 05:45:34 -0400
X-MC-Unique: N4sRPqNIP2CegU5UaP3z8w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-401c19fc097so21394865e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 02:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693993533; x=1694598333;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UlEOBu/VE6tjdzL9UJOCpexRbWh3hX2rULyWpu7l158=;
        b=h92Vi9qj+972GC+laybIDw9Y6+uVgjlh7vX95sbu34oL5xo1chHBvhyAoiNopwQfyv
         O7DGHXADq2LDAocg8cfLyqWpbBmEpnLG01ui8E3jVeAxCI5TksSi9tnljkN+a+k6Q1Fr
         34OmTPSOn+EUYdRiTqYmvHcW5a4sDTQf+FJSwvxC2ZEzvV0ZfhM3H0WofoMxQhM5Gi5J
         ticPkGol3AGYFqZ0/7VBgTV6EzdbGTJAFkb9V5g5eiQJ17EZWPTcLNKGowdT898sMIe1
         0EapodwX0U8hUyaZfHGj/Z3qrGDl/5c7vpur44jTiZ9rmR1SztP+//WGYNulAafDLJXE
         xMjw==
X-Gm-Message-State: AOJu0Ywemle4lLNSv3iy+r6QG9hveLF6Xrw25HDgS3+l8z9kLBHvODHr
        7Q7V3KdtsMjQphFrCzPJ5ngtAswpZOex9kPA6Vh4FGDPwYmb6ZhDPooTvpoW8kz5WNGlTKWBVpw
        Lrah4tL79HuhzJ+XrvC+aRdMM
X-Received: by 2002:a7b:c01a:0:b0:400:419c:bbde with SMTP id c26-20020a7bc01a000000b00400419cbbdemr2083805wmb.18.1693993533251;
        Wed, 06 Sep 2023 02:45:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvzjMv9fXcOqlGgHExO0/Bky5TAsfqUJ4gFKWD/812OOB2n+3Ka+NKF8N9/cFpNJ2b058T6g==
X-Received: by 2002:a7b:c01a:0:b0:400:419c:bbde with SMTP id c26-20020a7bc01a000000b00400419cbbdemr2083793wmb.18.1693993532950;
        Wed, 06 Sep 2023 02:45:32 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600c015100b00401d6c0505csm19255994wmm.47.2023.09.06.02.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 02:45:32 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 1/7] fbdev/au1200fb: Do not display boot-up logo
In-Reply-To: <20230829142109.4521-2-tzimmermann@suse.de>
References: <20230829142109.4521-1-tzimmermann@suse.de>
 <20230829142109.4521-2-tzimmermann@suse.de>
Date:   Wed, 06 Sep 2023 11:45:31 +0200
Message-ID: <87o7if4ouc.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The fbcon module takes care of displaying the logo, if any. Remove
> the code form au1200fb. If we want to display the logo without fbcon,
> we should implement this in the fbdev core code.
>

Agreed. I see that this code has been since the driver was added in 2006,
I wonder if was ever used. Enabling a fbdev driver without fbcon doesn't
seem to be a common configuration.

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

