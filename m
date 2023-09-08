Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6744A799135
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbjIHUqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjIHUqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:46:38 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5BF9C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:46:35 -0700 (PDT)
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx0.riseup.net (Postfix) with ESMTPS id 4Rj7SV5xTdz9t74;
        Fri,  8 Sep 2023 20:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1694205995; bh=LaM22m0U2Eli/oio4qvrPVmj6h2e0nMGwJA77B3gzPU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eSKfobZ/tZWb9L3jCg4GjsegW9phlvbiBSt4xpAMUd+0EMjugSXEVfXP0EV4OgC/X
         Inv/yLgeBPE2sTnAqfm8A4vnot9EBczqh4L/1tGVeclYm9hX4dk/ipIbrBoKrdznmi
         Cvo6Bf2FiJP83v5cxHL7fvOeYejvYzxop9g12ZQg=
X-Riseup-User-ID: E871C66ABABA5ABE84F71918891449B234914FF184A983EF8CBFEED1CDAF0756
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Rj7SR67ZGzJnsw;
        Fri,  8 Sep 2023 20:46:31 +0000 (UTC)
Message-ID: <b705023e-2943-1288-3ac7-b5737bbbea5b@riseup.net>
Date:   Fri, 8 Sep 2023 17:46:33 -0300
MIME-Version: 1.0
Subject: Re: [PATCH] drm/tests: Zero initialize fourccs_out
Content-Language: en-US
To:     Arthur Grillo <arthurgrillo@riseup.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     tales.aparecida@gmail.com, andrealmeid@riseup.net,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20230901-zero-init-fourcc-list-test-v1-1-68bc4cc738c8@riseup.net>
From:   Maira Canal <mairacanal@riseup.net>
In-Reply-To: <20230901-zero-init-fourcc-list-test-v1-1-68bc4cc738c8@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arthur,

On 9/1/23 15:52, Arthur Grillo wrote:
> fourccs_out array is not initialized. As the
> drm_fb_build_fourcc_list() doesn't necessarily change all the array,
> and the test compares all of it, the comparison could fail if the
> array is not initialized. Zero initialize the array to fix this.
> 
> Fixes: 371e0b186a13 ("drm/tests: Add KUnit tests for drm_fb_build_fourcc_list()")
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>

Applied to drm-misc/drm-misc-next!

Thanks!
- Maíra

> ---
>   drivers/gpu/drm/tests/drm_format_helper_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
> index 79bc9d4bbd71..1a6bd291345d 100644
> --- a/drivers/gpu/drm/tests/drm_format_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
> @@ -1165,7 +1165,7 @@ KUNIT_ARRAY_PARAM(fb_build_fourcc_list, fb_build_fourcc_list_cases, fb_build_fou
>   static void drm_test_fb_build_fourcc_list(struct kunit *test)
>   {
>   	const struct fb_build_fourcc_list_case *params = test->param_value;
> -	u32 fourccs_out[TEST_BUF_SIZE];
> +	u32 fourccs_out[TEST_BUF_SIZE] = {0};
>   	size_t nfourccs_out;
>   	struct drm_device *drm;
>   	struct device *dev;
> 
> ---
> base-commit: 8e455145d8f163aefa6b9cc29478e0a9f82276e6
> change-id: 20230901-zero-init-fourcc-list-test-2c934b6b7eb8
> 
> Best regards,
