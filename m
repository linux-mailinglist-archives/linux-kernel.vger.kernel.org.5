Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051E4759E84
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjGSTZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGSTZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:25:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DD8213D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689794691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l4X8keUZdQb2bH4NBTCOtLQ3Hj41EdN+SDgQPF1/pfY=;
        b=LevcImOQEyH53widEzfHgn84r2PCWCT4YmHSpmAK5Wd6Xdw90DOS2hH2LcVrULaBdXQ9Z/
        eCM68TZhrEszEI6o9r6kJ3YJRW48S44ziOokILimcVz7PA4cvtkkJFtUiZvvIWwpSJQQGk
        G8MP6x+Al1YgPJSZQQtVMqgEr4gncGU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-EbyTc2IdNcKgJRUmwmbzgA-1; Wed, 19 Jul 2023 15:24:47 -0400
X-MC-Unique: EbyTc2IdNcKgJRUmwmbzgA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f5df65f9f4so39154935e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689794686; x=1690399486;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4X8keUZdQb2bH4NBTCOtLQ3Hj41EdN+SDgQPF1/pfY=;
        b=Rh5USAYz4rIOo/wl6W01c0aGEVtF/N8BHBoegrarQIyI8JHSLdeHsezDPywIpRivAs
         LjkQS76vyjRXFRUC+wzaceH9eFBCPujYq0LxOaHeDcGD6vcXyyV/I0Wm6TWgalbAVo0I
         wcjJuBU1o7kukitD0Mveq7dciVmg5F0RqvTa8CIl5Sjzm3k7PT/Hli/t6MHLF2gJBoYF
         cBLQWljMuKig9/csX4Exlj/LiFFjg7wJZUt8nnAJ0SDLeYbhz+0Efmj8XuMaTz9IR28P
         Lx+r9HRancNupQtjfRF79NlL9NT/BiaY4jTEjamLIJ2SvebKXUHE65Irw51Uei2gsvOZ
         jKRA==
X-Gm-Message-State: ABy/qLZ1Y9nPVYXsF/FHoN/unad7k5p11n0vaKcu8PQSxCsd25P5qJRN
        39SszXQQQo45cZeK6wOx7EwFi0JXQYvCmbPlyQC17NDq8XGZV8ClRdyr3P42l5SkDUDgP0x6vzr
        1tuu+XKTfBjFwaOa4UmOMQ0On
X-Received: by 2002:adf:f803:0:b0:313:ebf3:f817 with SMTP id s3-20020adff803000000b00313ebf3f817mr694726wrp.22.1689794686778;
        Wed, 19 Jul 2023 12:24:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE+gAoZVxaGmHUoZ+DGJdKLFu6ZbS53uLFxpRmgqQc1kVBMnscA1+Tk/eOyiu3y0cdVGHrgig==
X-Received: by 2002:adf:f803:0:b0:313:ebf3:f817 with SMTP id s3-20020adff803000000b00313ebf3f817mr694713wrp.22.1689794686460;
        Wed, 19 Jul 2023 12:24:46 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d4fca000000b00314172ba213sm5943825wrw.108.2023.07.19.12.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:24:46 -0700 (PDT)
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
In-Reply-To: <fbbc08de-043a-2622-7cd4-fa485129edaf@loongson.cn>
References: <20230710-kms-kunit-actions-rework-v1-5-722c58d72c72@kernel.org>
 <fbbc08de-043a-2622-7cd4-fa485129edaf@loongson.cn>
Date:   Wed, 19 Jul 2023 21:24:45 +0200
Message-ID: <87lefbhfgi.fsf@minerva.mail-host-address-is-not-set>
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
>> As we get more and more tests, the locking context initialisation

[...]

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
>
> Because kunit_kzalloc() is also managed,
>
> Is there any possibility that kfree(ctx) get called before 
> action_drm_release_context(ctx) ?
>
> Currently, I can't find where the order is guaranteed.
>

It isn't documented indeed in Documentation/dev-tools/kunit/usage.rst but
the kunit_add_action() kernel-doc says:

"All functions registered with kunit_add_action() will execute in the
opposite order to that they were registered in".

And now that kunit_kzalloc() and friends are also implemented using the
cleanup actions, it will be part of that execution chain.

Probably the kunit docs can make this more clear.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

