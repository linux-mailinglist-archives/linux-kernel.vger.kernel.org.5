Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61882759E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjGSTNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGSTNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:13:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169371BF6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689793938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JXF15QANcQiQA1IPbs2QtIA09gB0+ec0aCzIw+lyU5o=;
        b=G5fnRAgnEV6e0Ld3LDl7xhj/mfRjR11h6psc4U5QxFyigsU1PJuU2Idy9jajrJm5aaALWK
        RMcASnkNZo5vdAQh2lCfD7UKdJYabt6zyaocZOsNHIHwjvndUklsEKzgTzUfHR+I9UmRuz
        Gjry1hdG4/nsD8HYegj6Q+jtGiewHx0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-Ujjh-iP7NWaP2gmiXaglyw-1; Wed, 19 Jul 2023 15:12:17 -0400
X-MC-Unique: Ujjh-iP7NWaP2gmiXaglyw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-314256aedcbso4013813f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689793936; x=1690398736;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXF15QANcQiQA1IPbs2QtIA09gB0+ec0aCzIw+lyU5o=;
        b=DDtToFDsNuMYYr0OWN7MLfP1RXtxJv0mDrH+INQ+w1xPihARtkRE/QqQs0KaZcoT60
         SSJ903XT61xtJ237MVkYoBN3GBkWqiBcp0FqHMWsClxV1BDU9tyMxjovCc1/h8YsRhWz
         0m+nLkJBRUrbhoLx+OMkrTjDDKgMFbNniQq9VHOF4IWLyzlHBETjlJr4yVR/USZ7d6iX
         c3quHxAcI6S3mZAHXRzDJMu7ojdCT/GMDMfVplEwy6X3yUp48wH2CMWzYbHBXOrGt8oe
         CFJKmkwLkzlz8OAzOai/GdYZ3ozWXWWYpSP/+ZT0GWVuS+rj28qI4E88ZZvJXoVUyhkI
         NMJg==
X-Gm-Message-State: ABy/qLbqARYgRuc6OQStHMyl8wbWxUqW9Ztly7k7VfLT5S9sulMKIorj
        4fJyLLJNfTiJSjfosHIDwDQMbwnpYVu7A+sHWXNYxJm0JVEX69wqBOArz9JXLboFdhzILOgnuYu
        nkeqmCk9QUYR0Ts7f9djFdBBq
X-Received: by 2002:adf:e351:0:b0:312:74a9:8259 with SMTP id n17-20020adfe351000000b0031274a98259mr184429wrj.71.1689793936032;
        Wed, 19 Jul 2023 12:12:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEyqQ3WA7Gw6Rk9H+5eUCRD6iK9ao4erODH0O7fqa0SS79LL7Rhhu2e5AISzSRYsaZnHCVO1g==
X-Received: by 2002:adf:e351:0:b0:312:74a9:8259 with SMTP id n17-20020adfe351000000b0031274a98259mr184417wrj.71.1689793935762;
        Wed, 19 Jul 2023 12:12:15 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b4-20020a05600010c400b003141e629cb6sm5984403wrx.101.2023.07.19.12.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:12:15 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     suijingfeng <suijingfeng@loongson.cn>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [05/11] drm/tests: helpers: Create an helper to allocate a
 locking ctx
In-Reply-To: <970f4a65-25dc-1805-3776-6447a61f77c5@loongson.cn>
References: <20230710-kms-kunit-actions-rework-v1-5-722c58d72c72@kernel.org>
 <970f4a65-25dc-1805-3776-6447a61f77c5@loongson.cn>
Date:   Wed, 19 Jul 2023 21:12:14 +0200
Message-ID: <87o7k7hg1d.fsf@minerva.mail-host-address-is-not-set>
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

suijingfeng <suijingfeng@loongson.cn> writes:

> Hi,
>
> On 2023/7/10 15:47, Maxime Ripard wrote:

[...]

>> +
>> +/**
>> + * drm_kunit_helper_context_alloc - Allocates an acquire context
>> + * @test: The test context object
>> + *
>> + * Allocates and initializes a modeset acquire context.
>> + *
>> + * The context is tied to the kunit test context, so we must not call
>> + * drm_modeset_acquire_fini() on it, it will be done so automatically.
>> + *
>> + * Returns:
>> + * An ERR_PTR on error, a pointer to the newly allocated context otherwise
>> + */
>> +struct drm_modeset_acquire_ctx *
>> +drm_kunit_helper_acquire_ctx_alloc(struct kunit *test)
>> +{
>> +	struct drm_modeset_acquire_ctx *ctx;
>> +	int ret;
>> +
>> +	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
>> +	KUNIT_ASSERT_NOT_NULL(test, ctx);
>> +
>> +	drm_modeset_acquire_init(ctx, 0);
>> +
>> +	ret = kunit_add_action_or_reset(test,
>> +					action_drm_release_context,
>> +					ctx);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	return ctx;
>> +}
>> +EXPORT_SYMBOL_GPL(drm_kunit_helper_acquire_ctx_alloc);
>> +
>
> I think all of the patch inside this series are quite well.
>
> Personally, I can't find problems in it.
>
>
> But I still want to ask a question:
>
> Should the managed functions you introduced be prefixed with drmm_ 
> (instead of drm_) ?
>

That's a good question. But personally I think that the drmm_ prefix
should be reserved for drm_device managed resources and helpers.

> As mindless programmer may still want to call drm_modeset_acquire_fini() 
> on the pointer returned by
>
> drm_kunit_helper_acquire_ctx_alloc()?
>

The function kernel-doc already mentions that there's no need to do that
and that will be done automatically by kunit. So shouldn't be different of
other functions helper where the programmer didn't read the documentation.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

