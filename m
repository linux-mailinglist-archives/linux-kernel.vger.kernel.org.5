Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D53756991
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjGQQum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjGQQul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:50:41 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CBB710E6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:50:35 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxJvFacbVkEAcGAA--.16310S3;
        Tue, 18 Jul 2023 00:50:34 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxbSNIcbVko7MxAA--.23049S3;
        Tue, 18 Jul 2023 00:50:33 +0800 (CST)
Message-ID: <970f4a65-25dc-1805-3776-6447a61f77c5@loongson.cn>
Date:   Tue, 18 Jul 2023 00:50:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [05/11] drm/tests: helpers: Create an helper to allocate a
 locking ctx
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230710-kms-kunit-actions-rework-v1-5-722c58d72c72@kernel.org>
Content-Language: en-US
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <20230710-kms-kunit-actions-rework-v1-5-722c58d72c72@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxbSNIcbVko7MxAA--.23049S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxur1DGF43AF1DXw1rJF4xGrX_yoW5Cw45pF
        4UAa40krWUtFZxCw1Iva4DZa4S9w4xXr1Uur97Zr45ZFWYgF9I9a1Dtr13urW5GrWDXF1I
        vF4a934Uua1jkrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Jr0_Gr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
        x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
        McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
        I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
        x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/7/10 15:47, Maxime Ripard wrote:
> As we get more and more tests, the locking context initialisation
> creates more and more boilerplate, both at creation and destruction.
>
> Let's create a helper that will allocate, initialise a context, and
> register kunit actions to clean up once the test is done.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/tests/drm_kunit_helpers.c | 41 +++++++++++++++++++++++++++++++
>   include/drm/drm_kunit_helpers.h           |  2 ++
>   2 files changed, 43 insertions(+)
>
> diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> index 38211fea9ae6..40a27c78d692 100644
> --- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
> +++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> @@ -124,5 +124,46 @@ __drm_kunit_helper_alloc_drm_device_with_driver(struct kunit *test,
>   }
>   EXPORT_SYMBOL_GPL(__drm_kunit_helper_alloc_drm_device_with_driver);
>   
> +static void action_drm_release_context(void *ptr)
> +{
> +	struct drm_modeset_acquire_ctx *ctx = ptr;
> +
> +	drm_modeset_drop_locks(ctx);
> +	drm_modeset_acquire_fini(ctx);
> +}
> +
> +/**
> + * drm_kunit_helper_context_alloc - Allocates an acquire context
> + * @test: The test context object
> + *
> + * Allocates and initializes a modeset acquire context.
> + *
> + * The context is tied to the kunit test context, so we must not call
> + * drm_modeset_acquire_fini() on it, it will be done so automatically.
> + *
> + * Returns:
> + * An ERR_PTR on error, a pointer to the newly allocated context otherwise
> + */
> +struct drm_modeset_acquire_ctx *
> +drm_kunit_helper_acquire_ctx_alloc(struct kunit *test)
> +{
> +	struct drm_modeset_acquire_ctx *ctx;
> +	int ret;
> +
> +	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, ctx);
> +
> +	drm_modeset_acquire_init(ctx, 0);
> +
> +	ret = kunit_add_action_or_reset(test,
> +					action_drm_release_context,
> +					ctx);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return ctx;
> +}
> +EXPORT_SYMBOL_GPL(drm_kunit_helper_acquire_ctx_alloc);
> +

I think all of the patch inside this series are quite well.

Personally, I can't find problems in it.


But I still want to ask a question:

Should the managed functions you introduced be prefixed with drmm_ 
(instead of drm_) ?

As mindless programmer may still want to call drm_modeset_acquire_fini() 
on the pointer returned by

drm_kunit_helper_acquire_ctx_alloc()?


>   MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
>   MODULE_LICENSE("GPL");
> diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
> index ed013fdcc1ff..4ba5e10653c6 100644
> --- a/include/drm/drm_kunit_helpers.h
> +++ b/include/drm/drm_kunit_helpers.h
> @@ -87,5 +87,7 @@ __drm_kunit_helper_alloc_drm_device(struct kunit *test,
>   						      sizeof(_type),		\
>   						      offsetof(_type, _member),	\
>   						      _feat))
> +struct drm_modeset_acquire_ctx *
> +drm_kunit_helper_acquire_ctx_alloc(struct kunit *test);
>   
>   #endif // DRM_KUNIT_HELPERS_H_

