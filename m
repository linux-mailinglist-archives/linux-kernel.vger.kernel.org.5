Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F9F78CEB5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbjH2VVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238939AbjH2VVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:21:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93188E61
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693343928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jy+2K1yLANLa7lYSBwfRxxzOwoci1VeMwKfXVR7mlYU=;
        b=bP5ni6TWPmS2vmQCrCDomonsDri/t7F9DjeYLKqeks2/PCNd5TY+iNXxCvk6UvBbcx3J2a
        Hkxl512fQSk5jYoE+Yf2WRT34r8Wd8aN9D7ti3FXwpc8HXr1+3lzWSP57mjkJs02Xwvr5h
        Hvm/Uji7kUb0Eq19XNNf8JsyLM1N6ZA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-uhQzDwMlPuaFQ8X3PhprKA-1; Tue, 29 Aug 2023 17:12:28 -0400
X-MC-Unique: uhQzDwMlPuaFQ8X3PhprKA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31ade95a897so3307301f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693343547; x=1693948347;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jy+2K1yLANLa7lYSBwfRxxzOwoci1VeMwKfXVR7mlYU=;
        b=VQfN0hRddH8V0zHXSscefa9tMPwXyDjqMvslTdc4Y77zeXff7YUf/FEoVgjJuDWkuE
         FIux2uTpJwxPVyAo6xc3Ieo5rENQI/6HZqw3bjO+OdwkQysB6r6zKcDke7bmGwQ5P8U3
         P/T2I62Cx0KL6l9M0abJr2VwOwDBL6YzNZBj1bBGzGTmXkxjj7ek8al8BO/mxAN1hC/J
         VPRiTeCbl/uaOweHB5A2Yp6b9n6WLw+GskfHPCTKr456MIVeSfpMoOsorcYcwCzAZEcK
         3T89uWSmYV5g2RpiOSxrbK99KqsI4UTGS1HPYCRJ65NKLJXXjRtiCgJz/a3auKaF+mOL
         C9/g==
X-Gm-Message-State: AOJu0Yx/En9cXFy2gKQWf7IaNcneTcQzEG73Tkdo7hNXIcPguG9G33Mx
        h5onW1YlJJk7UeirgwHH4Q/6TeMagkKo+b8YH9JgcrUPuREwE0cXdT7mUT0G1oVmtZqdc8pP75W
        YkXVLO0gDzcIhzYXzwtwyDU9z
X-Received: by 2002:adf:e9ce:0:b0:31d:d977:4e3d with SMTP id l14-20020adfe9ce000000b0031dd9774e3dmr190713wrn.19.1693343547185;
        Tue, 29 Aug 2023 14:12:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH42PUKWhgWABC41K1eUctlcT6IxKHduBUV2k8w1BSLQMhzChfk2sRp5Y6Kzvuv8mAoQ3Ogrw==
X-Received: by 2002:adf:e9ce:0:b0:31d:d977:4e3d with SMTP id l14-20020adfe9ce000000b0031dd9774e3dmr190702wrn.19.1693343546891;
        Tue, 29 Aug 2023 14:12:26 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f10-20020a7bc8ca000000b003fe29dc0ff2sm84275wml.21.2023.08.29.14.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 14:12:26 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/8] drm/ssd130x: Fix screen clearing
In-Reply-To: <87zg2atf50.fsf@minerva.mail-host-address-is-not-set>
References: <cover.1692888745.git.geert@linux-m68k.org>
 <c19cd5a57205597bb38a446c3871092993498f01.1692888745.git.geert@linux-m68k.org>
 <87zg2atf50.fsf@minerva.mail-host-address-is-not-set>
Date:   Tue, 29 Aug 2023 23:12:25 +0200
Message-ID: <87a5u9d03q.fsf@minerva.mail-host-address-is-not-set>
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

Javier Martinez Canillas <javierm@redhat.com> writes:

[...]

> The change makes sense to me.
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>

I've also tested this patch now and found no regressions.

Tested-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

