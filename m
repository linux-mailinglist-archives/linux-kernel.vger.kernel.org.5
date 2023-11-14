Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF587EB499
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjKNQSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjKNQSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:18:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC1512A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699978695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hw4Bw5O59qe5xsXMRfcSSDQ86e49jjUAP8rW0qG/g2M=;
        b=bSbYBXGS9yBZL9zJ8U1YbaGQvZAqwQ0WyEbqAiYzbNMGlp6FIfOMkl5tX7rETf0kMEu2WI
        MjJFEvGV3kJA2bwS6Jk6oEEmPx4dlbISSVUFuSk0ERlmfRI/HeHYOkNU6YcTD/N+zZ9j0i
        TuidNje6X5Mq3zj5n/VxlqBAFwyZ6ek=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-HGV7YYUvPo-OQH3y52EMRA-1; Tue, 14 Nov 2023 11:18:13 -0500
X-MC-Unique: HGV7YYUvPo-OQH3y52EMRA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66d87503d24so70435046d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:18:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699978693; x=1700583493;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hw4Bw5O59qe5xsXMRfcSSDQ86e49jjUAP8rW0qG/g2M=;
        b=tSHFZ5yQrlk//aVQu+frHXFOk79hG/QNU6Tfz3W7u5oGaVjon4mJsEhvPecUuCdqf2
         7180+NXn5TZb+cO+mf/A1zVqMl4wWU9IEILl50BArnggdJYui/SwO1lR4p9lmr1lX9g1
         ZBN1MF1FyLrRW1nFNoDYTj+uGHvvVcmkITyeCRx6JZDDLp7ZMvh2gabyeFlVKpPlW1v7
         nJaEA2if7VEA19AY00ZjTrrNClveQCqBZXLl17L3fL7R1gXpK6PJIi+PTnCgidkN+XyJ
         iCpAuOu/sZS/kgAyhiBh84vJU/OPXVyQ7JSbT7eFFFyTMFoEJV7thISc0My/1J2wUTzS
         wphw==
X-Gm-Message-State: AOJu0YyAwC07SBBGCfROLE9VA6OinXR6MTOMRhXqMIV0LTbSYkH9CAMO
        Wzfn6MCLaTt7DuY7X4bKHUl8XmdsgrXAQvdwhwEfwI/t7Uh9q5OmTOmyFpLteXjVqnIvCWefMCc
        YM+s8Q9o5Fmp+3YVSaXUgYco=
X-Received: by 2002:a05:6214:5842:b0:672:96a7:4614 with SMTP id ml2-20020a056214584200b0067296a74614mr2872765qvb.17.1699978693078;
        Tue, 14 Nov 2023 08:18:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeBHtArb07IqJkCI4XTGeDMk0v6lnoxQr19rGiPyvGHV/TNX2WVpnXhaSvTgTMuspuNfNx+A==
X-Received: by 2002:a05:6214:5842:b0:672:96a7:4614 with SMTP id ml2-20020a056214584200b0067296a74614mr2872740qvb.17.1699978692706;
        Tue, 14 Nov 2023 08:18:12 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-24-154.cust.vodafonedsl.it. [2.34.24.154])
        by smtp.gmail.com with ESMTPSA id y15-20020a0ceacf000000b006779f7e68cdsm3005288qvp.79.2023.11.14.08.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 08:18:12 -0800 (PST)
Message-ID: <e2c3e589-880c-4b24-8aa3-5084d1d40e21@redhat.com>
Date:   Tue, 14 Nov 2023 17:18:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Marco Pagani <marpagan@redhat.com>
Subject: Re: [RFC PATCH v2] drm/test: add a test suite for GEM objects backed
 by shmem
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20231108134205.111478-1-marpagan@redhat.com>
 <dqpsjdpedvpbooffrn2nwg6hxr2bhdizwx27icwz2dx5bgsho4@id5drrg66e7h>
Content-Language: en-US
In-Reply-To: <dqpsjdpedvpbooffrn2nwg6hxr2bhdizwx27icwz2dx5bgsho4@id5drrg66e7h>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-11-10 15:41, Maxime Ripard wrote:
> On Wed, Nov 08, 2023 at 02:42:03PM +0100, Marco Pagani wrote:
>> This patch introduces an initial KUnit test suite for GEM objects
>> backed by shmem buffers.
>>
>> Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>>
>> v2:
>> - Improved description of test cases
>> - Cleaner error handling using KUnit actions
>> - Alphabetical order in Kconfig and Makefile
>> ---
>>  drivers/gpu/drm/Kconfig                    |   9 +-
>>  drivers/gpu/drm/tests/Makefile             |   5 +-
>>  drivers/gpu/drm/tests/drm_gem_shmem_test.c | 381 +++++++++++++++++++++
>>  3 files changed, 389 insertions(+), 6 deletions(-)
>>  create mode 100644 drivers/gpu/drm/tests/drm_gem_shmem_test.c
>>
>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>> index 3eee8636f847..a2551c8c393a 100644
>> --- a/drivers/gpu/drm/Kconfig
>> +++ b/drivers/gpu/drm/Kconfig
>> @@ -76,14 +76,15 @@ config DRM_KUNIT_TEST
>>  	tristate "KUnit tests for DRM" if !KUNIT_ALL_TESTS
>>  	depends on DRM && KUNIT
>>  	select PRIME_NUMBERS
>> +	select DRM_BUDDY
>>  	select DRM_DISPLAY_DP_HELPER
>>  	select DRM_DISPLAY_HELPER
>> -	select DRM_LIB_RANDOM
>> -	select DRM_KMS_HELPER
>> -	select DRM_BUDDY
>> +	select DRM_EXEC
>>  	select DRM_EXPORT_FOR_TESTS if m
>> +	select DRM_GEM_SHMEM_HELPER
>> +	select DRM_KMS_HELPER
>>  	select DRM_KUNIT_TEST_HELPERS
>> -	select DRM_EXEC
>> +	select DRM_LIB_RANDOM
>>  	default KUNIT_ALL_TESTS
>>  	help
>>  	  This builds unit tests for DRM. This option is not useful for
>> diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
>> index ba7baa622675..d6183b3d7688 100644
>> --- a/drivers/gpu/drm/tests/Makefile
>> +++ b/drivers/gpu/drm/tests/Makefile
>> @@ -9,15 +9,16 @@ obj-$(CONFIG_DRM_KUNIT_TEST) += \
>>  	drm_connector_test.o \
>>  	drm_damage_helper_test.o \
>>  	drm_dp_mst_helper_test.o \
>> +	drm_exec_test.o \
>>  	drm_format_helper_test.o \
>>  	drm_format_test.o \
>>  	drm_framebuffer_test.o \
>> +	drm_gem_shmem_test.o \
>>  	drm_managed_test.o \
>>  	drm_mm_test.o \
>>  	drm_modes_test.o \
>>  	drm_plane_helper_test.o \
>>  	drm_probe_helper_test.o \
>> -	drm_rect_test.o	\
>> -	drm_exec_test.o
>> +	drm_rect_test.o
> 
> Thanks for reordering the tests and symbols, but they should part of a
> preliminary patch.
> 

Okay, I'll send it as a separate patch before v3.


>>  CFLAGS_drm_mm_test.o := $(DISABLE_STRUCTLEAK_PLUGIN)
>> diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
>> new file mode 100644
>> index 000000000000..983380490673
>> --- /dev/null
>> +++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
>> @@ -0,0 +1,381 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * KUnit test suite for GEM objects backed by shmem buffers
>> + *
>> + * Copyright (C) 2023 Red Hat, Inc.
>> + *
>> + * Author: Marco Pagani <marpagan@redhat.com>
>> + */
>> +
>> +#include <linux/dma-buf.h>
>> +#include <linux/iosys-map.h>
>> +#include <linux/sizes.h>
>> +
>> +#include <kunit/test.h>
>> +
>> +#include <drm/drm_device.h>
>> +#include <drm/drm_drv.h>
>> +#include <drm/drm_gem.h>
>> +#include <drm/drm_gem_shmem_helper.h>
>> +#include <drm/drm_kunit_helpers.h>
>> +
>> +#define TEST_SIZE		SZ_1M
>> +#define TEST_BYTE		0xae
>> +
>> +struct fake_dev {
>> +	struct drm_device drm_dev;
>> +	struct device *dev;
> 
> AFAICS, you're not using the dev pointer anywhere. You could remove the
> fake_dev struct entirely and pass the drm_device pointer in test->priv
>

Nice catch, thanks! It's a leftover from the previous version, where it
was used in the .exit function to free the parent dev. I'll drop it in v3.

>> +};
>> +
>> +/*
>> + * Wrappers to avoid an explicit type casting when passing action
>> + * functions to kunit_add_action().
>> + */
>> +static void kfree_wrapper(void *p)
>> +{
>> +	kfree(p);
>> +}
>> +
>> +static void sg_free_table_wrapper(void *sgt)
>> +{
>> +	sg_free_table(sgt);
>> +}
>> +
>> +static void drm_gem_shmem_free_wrapper(void *shmem)
>> +{
>> +	drm_gem_shmem_free(shmem);
>> +}
> 
> I think you need to explicitly cast the pointer (or do a temporary
> assignment to the proper type) to avoid a compiler warning.
> 

Do you mean like:

static void drm_gem_shmem_free_wrapper(void *shmem)
{
	drm_gem_shmem_free((struct drm_gem_shmem_object *)shmem);
}

I built the current version with clang 16.0.6 and gcc 13.2.1 but got
no cast warnings. Clang spotted an uninitialized variable, though.

>> +/*
>> + * Test creating a shmem GEM object backed by shmem buffer. The test
>> + * case succeeds if the GEM object is successfully allocated with the
>> + * shmem file node and object functions attributes set, and the size
>> + * attribute is equal to the correct size.
>> + */
> 
> Thanks for all those comments, it's super helpful
> 
>> +static void drm_gem_shmem_test_obj_create(struct kunit *test)
>> +{
>> +	struct fake_dev *fdev = test->priv;
>> +	struct drm_gem_shmem_object *shmem;
>> +
>> +	shmem = drm_gem_shmem_create(&fdev->drm_dev, TEST_SIZE);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
>> +	KUNIT_EXPECT_EQ(test, shmem->base.size, TEST_SIZE);
>> +	KUNIT_EXPECT_NOT_NULL(test, shmem->base.filp);
>> +	KUNIT_EXPECT_NOT_NULL(test, shmem->base.funcs);
>> +
>> +	drm_gem_shmem_free(shmem);
>> +}
>> +
>> +/*
>> + * Test creating a shmem GEM object from a scatter/gather table exported
>> + * via a DMA-BUF. The test case succeed if the GEM object is successfully
>> + * created with the shmem file node attribute equal to NULL and the sgt
>> + * attribute pointing to the scatter/gather table that has been imported.
>> + */
>> +static void drm_gem_shmem_test_obj_create_private(struct kunit *test)
>> +{
>> +	struct fake_dev *fdev = test->priv;
>> +	struct drm_gem_shmem_object *shmem;
>> +	struct drm_gem_object *gem_obj;
>> +	struct dma_buf buf_mock;
>> +	struct dma_buf_attachment attach_mock;
>> +	struct sg_table *sgt;
>> +	char *buf;
>> +	int ret;
>> +
>> +	/* Create a mock scatter/gather table */
>> +	buf = kunit_kzalloc(test, TEST_SIZE, GFP_KERNEL);
>> +	KUNIT_ASSERT_NOT_NULL(test, buf);
>> +
>> +	sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
>> +	KUNIT_ASSERT_NOT_NULL(test, sgt);
>> +
>> +	ret = kunit_add_action_or_reset(test, kfree_wrapper, sgt);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	ret = kunit_add_action_or_reset(test, sg_free_table_wrapper, sgt);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	sg_init_one(sgt->sgl, buf, TEST_SIZE);
>> +
>> +	/* Init a mock DMA-BUF */
>> +	buf_mock.size = TEST_SIZE;
>> +	attach_mock.dmabuf = &buf_mock;
>> +
>> +	gem_obj = drm_gem_shmem_prime_import_sg_table(&fdev->drm_dev, &attach_mock, sgt);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, gem_obj);
>> +	KUNIT_EXPECT_EQ(test, gem_obj->size, TEST_SIZE);
>> +	KUNIT_EXPECT_NULL(test, gem_obj->filp);
>> +	KUNIT_EXPECT_NOT_NULL(test, gem_obj->funcs);
>> +
>> +	/* The scatter/gather table will be freed by drm_gem_shmem_free */
>> +	kunit_remove_action(test, sg_free_table_wrapper, sgt);
>> +	kunit_remove_action(test, kfree_wrapper, sgt);
>> +
>> +	shmem = to_drm_gem_shmem_obj(gem_obj);
>> +	KUNIT_EXPECT_PTR_EQ(test, shmem->sgt, sgt);
>> +
>> +	drm_gem_shmem_free(shmem);
>> +}
>> +
>> +/*
>> + * Test pinning backing pages for a shmem GEM object. The test case
>> + * succeeds if a suitable number of backing pages are allocated, and
>> + * the pages table counter attribute is increased by one.
>> + */
>> +static void drm_gem_shmem_test_pin_pages(struct kunit *test)
>> +{
>> +	struct fake_dev *fdev = test->priv;
>> +	struct drm_gem_shmem_object *shmem;
>> +	int i, ret;
>> +
>> +	shmem = drm_gem_shmem_create(&fdev->drm_dev, TEST_SIZE);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
>> +	KUNIT_EXPECT_NULL(test, shmem->pages);
>> +	KUNIT_EXPECT_EQ(test, shmem->pages_use_count, 0);
>> +
>> +	ret = kunit_add_action_or_reset(test, drm_gem_shmem_free_wrapper, shmem);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	ret = drm_gem_shmem_pin(shmem);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +	KUNIT_ASSERT_NOT_NULL(test, shmem->pages);
>> +	KUNIT_EXPECT_EQ(test, shmem->pages_use_count, 1);
>> +
>> +	for (i = 0; i < (shmem->base.size >> PAGE_SHIFT); i++)
>> +		KUNIT_ASSERT_NOT_NULL(test, shmem->pages[i]);
>> +
>> +	drm_gem_shmem_unpin(shmem);
>> +	KUNIT_EXPECT_NULL(test, shmem->pages);
>> +	KUNIT_EXPECT_EQ(test, shmem->pages_use_count, 0);
>> +}
>> +
>> +/*
>> + * Test creating a virtual mapping for a shmem GEM object. The test
>> + * case succeeds if the backing memory is mapped and the reference
>> + * counter for virtual mapping is increased by one. Moreover, the test
>> + * case writes and then reads a test pattern over the mapped memory.
>> + */
>> +static void drm_gem_shmem_test_vmap(struct kunit *test)
>> +{
>> +	struct fake_dev *fdev = test->priv;
>> +	struct drm_gem_shmem_object *shmem;
>> +	struct iosys_map map;
>> +	int ret, i;
>> +
>> +	shmem = drm_gem_shmem_create(&fdev->drm_dev, TEST_SIZE);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
>> +	KUNIT_EXPECT_NULL(test, shmem->vaddr);
>> +	KUNIT_EXPECT_EQ(test, shmem->vmap_use_count, 0);
>> +
>> +	ret = kunit_add_action_or_reset(test, drm_gem_shmem_free_wrapper, shmem);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	ret = drm_gem_shmem_vmap(shmem, &map);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +	KUNIT_ASSERT_NOT_NULL(test, shmem->vaddr);
>> +	KUNIT_ASSERT_FALSE(test, iosys_map_is_null(&map));
>> +	KUNIT_EXPECT_EQ(test, shmem->vmap_use_count, 1);
>> +
>> +	iosys_map_memset(&map, 0, TEST_BYTE, TEST_SIZE);
>> +	for (i = 0; i < TEST_SIZE; i++)
>> +		KUNIT_EXPECT_EQ(test, iosys_map_rd(&map, i, u8), TEST_BYTE);
>> +
>> +	drm_gem_shmem_vunmap(shmem, &map);
>> +	KUNIT_EXPECT_NULL(test, shmem->vaddr);
>> +	KUNIT_EXPECT_EQ(test, shmem->vmap_use_count, 0);
>> +}
>> +
>> +/*
>> + * Test exporting a scatter/gather table of pinned pages suitable for
>> + * PRIME usage from a shmem GEM object. The test case succeeds if a
>> + * scatter/gather table large enough to accommodate the backing memory
>> + * is successfully exported.
>> + */
>> +static void drm_gem_shmem_test_get_pages_sgt(struct kunit *test)
>> +{
>> +	struct fake_dev *fdev = test->priv;
>> +	struct drm_gem_shmem_object *shmem;
>> +	struct sg_table *sgt;
>> +	struct scatterlist *sg;
>> +	unsigned int si, len = 0;
>> +	int ret;
>> +
>> +	shmem = drm_gem_shmem_create(&fdev->drm_dev, TEST_SIZE);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
>> +
>> +	ret = kunit_add_action_or_reset(test, drm_gem_shmem_free_wrapper, shmem);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	ret = drm_gem_shmem_pin(shmem);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	sgt = drm_gem_shmem_get_sg_table(shmem);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sgt);
>> +	KUNIT_EXPECT_NULL(test, shmem->sgt);
>> +
>> +	ret = kunit_add_action_or_reset(test, sg_free_table_wrapper, sgt);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	for_each_sgtable_sg(sgt, sg, si) {
>> +		KUNIT_EXPECT_NOT_NULL(test, sg);
>> +		len += sg->length;
>> +	}
>> +
>> +	KUNIT_EXPECT_GE(test, len, TEST_SIZE);
>> +}
>> +
>> +/*
>> + * Test pinning pages and exporting a scatter/gather table suitable for
>> + * driver usage from a shmem GEM object. The test case succeeds if the
>> + * backing pages are pinned and a scatter/gather table large enough to
>> + * accommodate the backing memory is successfully exported.
>> + */
>> +static void drm_gem_shmem_test_get_sg_table(struct kunit *test)
>> +{
>> +	struct fake_dev *fdev = test->priv;
>> +	struct drm_gem_shmem_object *shmem;
>> +	struct sg_table *sgt;
>> +	struct scatterlist *sg;
>> +	unsigned int si, len, ret = 0;
>> +
>> +	shmem = drm_gem_shmem_create(&fdev->drm_dev, TEST_SIZE);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
>> +
>> +	ret = kunit_add_action_or_reset(test, drm_gem_shmem_free_wrapper, shmem);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	/* The scatter/gather table will be freed by drm_gem_shmem_free */
>> +	sgt = drm_gem_shmem_get_pages_sgt(shmem);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sgt);
>> +	KUNIT_ASSERT_NOT_NULL(test, shmem->pages);
>> +	KUNIT_EXPECT_EQ(test, shmem->pages_use_count, 1);
>> +	KUNIT_EXPECT_PTR_EQ(test, sgt, shmem->sgt);
>> +
>> +	for_each_sgtable_sg(sgt, sg, si) {
>> +		KUNIT_EXPECT_NOT_NULL(test, sg);
>> +		len += sg->length;
>> +	}
>> +
>> +	KUNIT_EXPECT_GE(test, len, TEST_SIZE);
>> +}
>> +
>> +/*
>> + * Test updating the madvise state of a shmem GEM object. The test
>> + * case checks that the function for setting madv updates it only if
>> + * its current value is greater or equal than zero and returns false
>> + * if it has a negative value.
>> + */
>> +static void drm_gem_shmem_test_madvise(struct kunit *test)
>> +{
>> +	struct fake_dev *fdev = test->priv;
>> +	struct drm_gem_shmem_object *shmem;
>> +	int ret;
>> +
>> +	shmem = drm_gem_shmem_create(&fdev->drm_dev, TEST_SIZE);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
>> +	KUNIT_ASSERT_EQ(test, shmem->madv, 0);
>> +
>> +	ret = kunit_add_action_or_reset(test, drm_gem_shmem_free_wrapper, shmem);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	ret = drm_gem_shmem_madvise(shmem, 1);
>> +	KUNIT_EXPECT_TRUE(test, ret);
>> +	KUNIT_ASSERT_EQ(test, shmem->madv, 1);
>> +
>> +	/* Set madv to a negative value */
>> +	ret = drm_gem_shmem_madvise(shmem, -1);
>> +	KUNIT_EXPECT_FALSE(test, ret);
>> +	KUNIT_ASSERT_EQ(test, shmem->madv, -1);
>> +
>> +	/* Check that madv cannot be set back to a positive value */
>> +	ret = drm_gem_shmem_madvise(shmem, 0);
>> +	KUNIT_EXPECT_FALSE(test, ret);
>> +	KUNIT_ASSERT_EQ(test, shmem->madv, -1);
>> +}
>> +
>> +/*
>> + * Test purging a shmem GEM object. First, assert that a newly created
>> + * shmem GEM object is not purgeable. Then, set madvise to a positive
>> + * value and call drm_gem_shmem_get_pages_sgt() to pin and dma-map the
>> + * backing pages. Finally, assert that the shmem GEM object is now
>> + * purgeable and purge it.
>> + */
>> +static void drm_gem_shmem_test_purge(struct kunit *test)
>> +{
>> +	struct fake_dev *fdev = test->priv;
>> +	struct drm_gem_shmem_object *shmem;
>> +	struct sg_table *sgt;
>> +	int ret;
>> +
>> +	shmem = drm_gem_shmem_create(&fdev->drm_dev, TEST_SIZE);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
>> +
>> +	ret = kunit_add_action_or_reset(test, drm_gem_shmem_free_wrapper, shmem);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	ret = drm_gem_shmem_is_purgeable(shmem);
>> +	KUNIT_EXPECT_FALSE(test, ret);
>> +
>> +	ret = drm_gem_shmem_madvise(shmem, 1);
>> +	KUNIT_EXPECT_TRUE(test, ret);
>> +
>> +	/* The scatter/gather table will be freed by drm_gem_shmem_free */
>> +	sgt = drm_gem_shmem_get_pages_sgt(shmem);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sgt);
>> +
>> +	ret = drm_gem_shmem_is_purgeable(shmem);
>> +	KUNIT_EXPECT_TRUE(test, ret);
>> +
>> +	drm_gem_shmem_purge(shmem);
>> +	KUNIT_EXPECT_NULL(test, shmem->pages);
>> +	KUNIT_EXPECT_NULL(test, shmem->sgt);
>> +	KUNIT_EXPECT_EQ(test, shmem->madv, -1);
>> +}
>> +
>> +static int drm_gem_shmem_test_init(struct kunit *test)
>> +{
>> +	struct fake_dev *fdev;
>> +	struct device *dev;
>> +
>> +	/* Allocate a parent device */
>> +	dev = drm_kunit_helper_alloc_device(test);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
>> +
>> +	/*
>> +	 * The DRM core will automatically initialize the GEM core and create
>> +	 * a DRM Memory Manager object which provides an address space pool
>> +	 * for GEM objects allocation.
>> +	 */
>> +	fdev = drm_kunit_helper_alloc_drm_device(test, dev, struct fake_dev,
>> +						 drm_dev, DRIVER_GEM);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fdev);
>> +
>> +	fdev->dev = dev;
>> +	test->priv = fdev;
>> +
>> +	return 0;
>> +}
>> +
>> +static struct kunit_case drm_gem_shmem_test_cases[] = {
>> +	KUNIT_CASE(drm_gem_shmem_test_obj_create),
>> +	KUNIT_CASE(drm_gem_shmem_test_obj_create_private),
>> +	KUNIT_CASE(drm_gem_shmem_test_pin_pages),
>> +	KUNIT_CASE(drm_gem_shmem_test_vmap),
>> +	KUNIT_CASE(drm_gem_shmem_test_get_pages_sgt),
>> +	KUNIT_CASE(drm_gem_shmem_test_get_sg_table),
>> +	KUNIT_CASE(drm_gem_shmem_test_madvise),
>> +	KUNIT_CASE(drm_gem_shmem_test_purge),
>> +	{}
>> +};
>> +
>> +static struct kunit_suite drm_gem_shmem_suite = {
>> +	.name = "drm_gem_shmem",
>> +	.init = drm_gem_shmem_test_init,
>> +	.test_cases = drm_gem_shmem_test_cases
>> +};
>> +
>> +kunit_test_suite(drm_gem_shmem_suite);
> 
> Looks great otherwise, thanks!
> Maxime

Thanks,
Marco

