Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E077BD711
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345789AbjJIJa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345846AbjJIJay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:30:54 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C6FCA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:30:52 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-504a7f9204eso5138312e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 02:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696843851; x=1697448651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gmwAEQHUShD13Crz4Xqpp8bdUVorE1C8HPaXCwJ5RJ8=;
        b=kZ6z5IxN4aX4KJfXpXCjNnV+YZauuccd/ep/diL8oX7vqFucd94XdWfSWn16ZKU22b
         T+bo9epP4aCwo8N54C7xvlkjFIzsj4i8V3JFGaoAWrq/+eUiQ/2O8swTZV1AfcMLhTpd
         WvqV+NPWHexoNivS2sX+Z45S3pAj1GMzy/nYm3a1rHdA/1+ww1QMPwMbHJcnWaHfRxHi
         LBtWqmXEYedWzeGa95gtnGf6Fnls0sI1pVVYj8/Y+K6YQGxf6SnKPyovCuryN6vGvwKL
         uDb6cH0GaZtk4GPNZGfCTh5baRmt+Sq1bLsH7ei5zA0EPTo2bhvw4PSPlNV4V2Tvx/pC
         vtlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696843851; x=1697448651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmwAEQHUShD13Crz4Xqpp8bdUVorE1C8HPaXCwJ5RJ8=;
        b=pIKlIg3f0SuzZoyt8Q7mj5w4dv7j0QVV0v7N6IxWyhpQpZHiDlPoXmmlED0Oj+3gVk
         qUJo5C/4ps2w0OXeCHfZ5RSjIwN+/MaA3kOtgyWj0gR72aoGia9CJyDoQJTEGIalrz64
         BJL/AYicEPpskuJrUEBWGVycXvagrWCKbT7bRGpoH6zUZtM374YRPzAk8cbhiy+gqZEH
         VXjKgSrocUzENZ+xUhv8M8G3cFEMYerbXAN0CUH6sU3oxhR2jM0LN0QIllP9xkEwjmwt
         PoFh4OE6BHkXphV1mjn8Nq63rwAMc0/qcqfY2cm7gLmjgn+NumylLhNMjh1bTeQGpbVM
         Dn6g==
X-Gm-Message-State: AOJu0YzHf5Qv4Gd26xb4dFsA0fdTh1KE+d4hvT8H5SOc5iMNpEXPEFZ4
        cAP7ZcGNyUyc0XmZjxWtKCfHNw==
X-Google-Smtp-Source: AGHT+IGHTGAuOleZS6uYzYovcWRJPRlE6qvUjsDstd5ZAD/P+o5pTl57ppGEmoWHacjXimQyT7/PjA==
X-Received: by 2002:a05:6512:1245:b0:500:a7c8:1847 with SMTP id fb5-20020a056512124500b00500a7c81847mr16170277lfb.66.1696843851098;
        Mon, 09 Oct 2023 02:30:51 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id h10-20020ac2596a000000b004fe26362d48sm1385178lfp.75.2023.10.09.02.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 02:30:50 -0700 (PDT)
Message-ID: <92377509-0f30-46ff-8b37-3b4b6fd53189@linaro.org>
Date:   Mon, 9 Oct 2023 12:30:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] drm/ci: export kernel config
Content-Language: en-GB
To:     Helen Koike <helen.koike@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     robdclark@chromium.org, vignesh.raman@collabora.com,
        sergi.blanch.torne@collabora.com, guilherme.gallo@collabora.com,
        david.heidelberg@collabora.com, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20231009004953.203576-1-helen.koike@collabora.com>
 <20231009004953.203576-8-helen.koike@collabora.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231009004953.203576-8-helen.koike@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2023 03:49, Helen Koike wrote:
> Export the resultant kernel config, making it easier to verify if the
> resultant config was correctly generated.
> 
> Suggested-by: Rob Clark <robdclark@chromium.org>
> Signed-off-by: Helen Koike <helen.koike@collabora.com>

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


I'd even say:

Appreciated-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

It will help a lot to debug possible Kconfig changes and/or omissions.

> ---
>   drivers/gpu/drm/ci/build.sh       | 1 +
>   drivers/gpu/drm/ci/image-tags.yml | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
> index 8eec15143bfe..740b5008be2e 100644
> --- a/drivers/gpu/drm/ci/build.sh
> +++ b/drivers/gpu/drm/ci/build.sh
> @@ -148,6 +148,7 @@ mkdir -p artifacts/install/lib
>   mv install/* artifacts/install/.
>   rm -rf artifacts/install/modules
>   ln -s common artifacts/install/ci-common
> +cp .config artifacts/${CI_JOB_NAME}_config
>   
>   for image in ${KERNEL_IMAGE_NAME}; do
>       cp /lava-files/$image artifacts/install/.
> diff --git a/drivers/gpu/drm/ci/image-tags.yml b/drivers/gpu/drm/ci/image-tags.yml
> index df94d8fb348e..3e5cd4e8be24 100644
> --- a/drivers/gpu/drm/ci/image-tags.yml
> +++ b/drivers/gpu/drm/ci/image-tags.yml
> @@ -4,7 +4,7 @@ variables:
>      DEBIAN_BASE_TAG: "${CONTAINER_TAG}"
>   
>      DEBIAN_X86_64_BUILD_IMAGE_PATH: "debian/x86_64_build"
> -   DEBIAN_BUILD_TAG: "2023-10-08-igt"
> +   DEBIAN_BUILD_TAG: "2023-10-08-config"
>   
>      KERNEL_ROOTFS_TAG: "2023-10-06-amd"
>   

-- 
With best wishes
Dmitry

