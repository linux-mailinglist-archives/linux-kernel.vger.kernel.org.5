Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAA9759DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjGSSoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGSSoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231302119
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689792175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FesoQTJ8UjoHrjSRH+KuNtLC4V0/j8s1GxlaRmyTwsI=;
        b=PiJSzAUtSXgS6NcDyoI2kEMC3sMtVhstMkmDMiXuWWxTtHWjOMuXq1lpT1Bq4p3xlDj+wA
        pKI1lcMrcg4qlbj5tG73fqw5EkqOfN3MtyLMIlTEftbz3D7/AgejFzzUdGLBPv9jmLnztp
        OdgRuew5Tn4aB7Pe3r0Xh5RB/FF3GSw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-0J0gwCdfP4euzvgW158lkw-1; Wed, 19 Jul 2023 14:42:54 -0400
X-MC-Unique: 0J0gwCdfP4euzvgW158lkw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-314326f6e23so3990185f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689792173; x=1690396973;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FesoQTJ8UjoHrjSRH+KuNtLC4V0/j8s1GxlaRmyTwsI=;
        b=km7DUhW5RAr2dMBnTQF0vohctDK3KtCAOF+oWJ/9NPtvGaOCA8WDDwcFGK4np7fup2
         K1ft8E37islAbHfh4Q3xRyyNj9/H/0CwR57d97bivw4cfpqlLaLjNabAtiRyheNpv6hD
         Box4GlMtakKzV4b6uGk624jLLgYyqRfYuhoHRR2FhTRYZ6FOAWJp/EtTFT4Y1tbvtM7n
         U0MojoQ2byiuSWQKbNerVs58tHlkSXQjj2ygYW0V3o2ntYZNJuqKUnR1y7BF6sijFSDk
         f/dt1J3EXzTpVAKRn/MB0agKwg5FefVbJHF9gXSANxxFNSF+r1w8esd22Vhu71dNG2nm
         RqYQ==
X-Gm-Message-State: ABy/qLa7oHQlDJivSWqBSFABghW96HD5Uip/BdmJJLWeUcwoU0Ksm7aY
        m/szqUHw9umRGYVhkNNNwNR1uLfqWvKZHZHGi0AIwV/h+SybPEjYhEtiUVlaC5Zm1m6P0pG4JvU
        urMLVBKhhrq4JNfl3UjgUjHLQ
X-Received: by 2002:adf:f40b:0:b0:314:3b70:1c72 with SMTP id g11-20020adff40b000000b003143b701c72mr202808wro.12.1689792173113;
        Wed, 19 Jul 2023 11:42:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGfJpG0ygob3RPXEtMhQc4NUJjcgzdJI8tfjTO74cqd+QsTgZdrwIQDuFradrw/TbO50ij7dw==
X-Received: by 2002:adf:f40b:0:b0:314:3b70:1c72 with SMTP id g11-20020adff40b000000b003143b701c72mr202803wro.12.1689792172804;
        Wed, 19 Jul 2023 11:42:52 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d4a88000000b003145521f4e5sm5980075wrq.116.2023.07.19.11.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 11:42:52 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>
Cc:     Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 01/11] drm/tests: helpers: Switch to kunit actions
In-Reply-To: <20230710-kms-kunit-actions-rework-v1-1-722c58d72c72@kernel.org>
References: <20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org>
 <20230710-kms-kunit-actions-rework-v1-1-722c58d72c72@kernel.org>
Date:   Wed, 19 Jul 2023 20:42:51 +0200
Message-ID: <871qh3ivys.fsf@minerva.mail-host-address-is-not-set>
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

Maxime Ripard <mripard@kernel.org> writes:

Hello Maxime,

The patch looks good to me. I've two questions below though.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/tests/drm_kunit_helpers.c | 32 +++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> index 4df47071dc88..38211fea9ae6 100644
> --- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
> +++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> @@ -35,8 +35,8 @@ static struct platform_driver fake_platform_driver = {
>   * able to leverage the usual infrastructure and most notably the
>   * device-managed resources just like a "real" device.
>   *
> - * Callers need to make sure drm_kunit_helper_free_device() on the
> - * device when done.
> + * Resources will be cleaned up automatically, but the removal can be
> + * forced using @drm_kunit_helper_free_device.
>   *
>   * Returns:
>   * A pointer to the new device, or an ERR_PTR() otherwise.
> @@ -49,12 +49,31 @@ struct device *drm_kunit_helper_alloc_device(struct kunit *test)
>  	ret = platform_driver_register(&fake_platform_driver);
>  	KUNIT_ASSERT_EQ(test, ret, 0);
>  
> +	ret = kunit_add_action_or_reset(test,
> +					(kunit_action_t *)platform_driver_unregister,
> +					&fake_platform_driver);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
>  	pdev = platform_device_alloc(KUNIT_DEVICE_NAME, PLATFORM_DEVID_NONE);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
>  
> +	ret = kunit_add_action_or_reset(test,
> +					(kunit_action_t *)platform_device_put,
> +					pdev);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
>  	ret = platform_device_add(pdev);
>  	KUNIT_ASSERT_EQ(test, ret, 0);
>  
> +	kunit_remove_action(test,
> +			    (kunit_action_t *)platform_device_put,
> +			    pdev);
> +

I understand that this action removal is because platform_device_put() is
not needed anymore after the platform_device_unregister() remove action is
registered since that already takes care of the platform_device_put().

But maybe add a comment to make more clear for someone who is not familiar
with these details of the platform core ?

>  EXPORT_SYMBOL_GPL(drm_kunit_helper_alloc_device);
> @@ -70,8 +89,13 @@ void drm_kunit_helper_free_device(struct kunit *test, struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
>  
> -	platform_device_unregister(pdev);
> -	platform_driver_unregister(&fake_platform_driver);
> +	kunit_release_action(test,
> +			     (kunit_action_t *)platform_device_unregister,
> +			     pdev);
> +
> +	kunit_release_action(test,
> +			     (kunit_action_t *)platform_driver_unregister,
> +			     &fake_platform_driver);
>  }
>  EXPORT_SYMBOL_GPL(drm_kunit_helper_free_device);
>

I thought the point of using the kunit cleanup actions was that you could
just make the kunit framework handle the release of resources and not do
it manually?

Can you just remove this function helper or is still needed in some cases?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

