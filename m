Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B06805DAA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbjLER6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLER6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:58:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EE71BFA;
        Tue,  5 Dec 2023 09:58:45 -0800 (PST)
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2DFF5660715D;
        Tue,  5 Dec 2023 17:58:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701799123;
        bh=4K1nG0XcLJCaqmXjT00pOtA2M+BKj18KQH6LnXZWdi4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kNeoQvdoOS3DwcND2QZyfuEIZsgZyU5iZ15cm4yY/NVzUTn+Vl3WFhBEyfMrRP+ll
         E/TlLTyM7BcYLGTRiNX/sN/0nh1S3MT0Ph/7eVCl96LVANv9h4wDH4qNcellEzTLsd
         LL2OTdZcCh3Lmz90qR8qOZBYlOJ2pdSwmi7czM69qCblgHSzrA6IHwcrHdGXi4buYM
         RD2ICfN+PGZbpeL0LnkmTMuwyZnS4ZA+a7ZLAQVroahHgUDxPecy7cLs8r5C/5PmcC
         RmwHlTNtC+b8kBViwPC25X9IstWWgGdHQceVBM5FBqn1K6c+SeMI6G7Gc0qcyE+NQw
         2fcz4jmWaOTHA==
Message-ID: <136041c8-bbc8-49b6-a3ff-7236e79afa5c@collabora.com>
Date:   Tue, 5 Dec 2023 14:58:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/10] drm: ci: mediatek: Set IGT_FORCE_DRIVER for
 mt8173
Content-Language: en-US
To:     Vignesh Raman <vignesh.raman@collabora.com>, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     david.heidelberg@collabora.com, sergi.blanch.torne@collabora.com,
        guilherme.gallo@collabora.com, daniels@collabora.com,
        gustavo.padovan@collabora.com, emma@anholt.net,
        robdclark@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20231129121841.253223-1-vignesh.raman@collabora.com>
 <20231129121841.253223-7-vignesh.raman@collabora.com>
From:   Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20231129121841.253223-7-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your patch.

On 29/11/2023 09:18, Vignesh Raman wrote:
> Expected driver for mt8173 is "mediatek" and for mt8183
> it is "panfrost". Set IGT_FORCE_DRIVER to 'mediatek' as
> the expected driver for mt8173.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v5:
>    - Added a new patch in the series to set IGT_FORCE_DRIVER to 'mediatek' for mt8173
> 
> v6:
>    - Use GPU_VERSION instead of CI_JOB_NAME to check if it is mt8173
> 
> ---
>   drivers/gpu/drm/ci/igt_runner.sh | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
> index c6cf963592c5..70a0f84021a1 100755
> --- a/drivers/gpu/drm/ci/igt_runner.sh
> +++ b/drivers/gpu/drm/ci/igt_runner.sh
> @@ -30,6 +30,10 @@ case "$DRIVER_NAME" in
>           ;;
>   esac
>   
> +if [ "$GPU_VERSION" = "mt8173" ]; then
> +    export IGT_FORCE_DRIVER=${DRIVER_NAME}
> +fi

Just a nit, could you add this in the first case statement? Just to 
avoid confusing about double assignment? -> but feel free to ignore this 
comment.

With or without this:

Acked-by: Helen Koike <helen.koike@collabora.com>

Thanks
Helen

> +
>   if [ -e "/install/xfails/$DRIVER_NAME-$GPU_VERSION-skips.txt" ]; then
>       IGT_SKIPS="--skips /install/xfails/$DRIVER_NAME-$GPU_VERSION-skips.txt"
>   fi
