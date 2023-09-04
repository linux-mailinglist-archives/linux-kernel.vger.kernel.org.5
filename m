Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F455791BD2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 18:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbjIDQ7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 12:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjIDQ7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 12:59:42 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E64CC5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 09:59:38 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d7e387c33f3so1261787276.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 09:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693846778; x=1694451578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bDhYFJwsc72fnWtZtTj1LIiHVNNT1m2etRJ8fUWREuo=;
        b=XLkiB+NXASKjoU3BhYA6KspDhjCcqlTHw6L0awibV3LB+WkL1Jwc5X/h+YUlbLMrsG
         UzkjS5Z+CMeoZtItxB861CMa4CF0Er2x6wsI6/8+fnOOfm5XrKoQQvHSNIg6XbgivK2Y
         aHzgJmKPFVTG/p0cZ131mqwGyM8KvmPbXr91lKmk7Hhj4GMZ/x+87FU8eXMysFrwolJb
         6pHXYD/i/ebfYAW1dAZwUJaM6471vQAa7zpJLcwJVzdcnJdxHiMPRtV0drGXci12X0E3
         HY4yiyQdcUYDGUxWYQiR2GYphb+sLwI0+YRavIkt8Z32xoCt8Q02mLyM6Pf9Rwi16HGT
         GYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693846778; x=1694451578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDhYFJwsc72fnWtZtTj1LIiHVNNT1m2etRJ8fUWREuo=;
        b=EpaqYcwkSH/wVX/IsjnK8VAbHEXbVZznlhYNNJeTOZbEdLiH7zsjF2pRs+y7iA5Uwf
         /MVzmbh0D3JB7ASRXfZyWxil12q/fqW/zRbEYluhgRXJZzq1iSLno7URtjmHEJisqzKE
         cwlzpp7ljhFRcFxv2m0QH8DK1eOAjMXIEHqyoqUiL5P6fNC/L2dF8m0llyTRZjJ9Vplr
         iUQ/2xcv9avAooXwrXYjrFlywXtoi2pAqaa8d3dAHhXgQ5u7Q//6irohconDDRYZIRch
         m0qRJmI072SdLJaPArXvwF+aJu7SAnQpMf08X34O+sYX7mVXl0BhE1/UrBvcILREi6ej
         GaxA==
X-Gm-Message-State: AOJu0Yx9gebWE3biQ3JVVcV3Hn2a5E5NfbrJx0+7cnewVTkdfBOHBbOA
        wwvDNFKFKk5UNxPb9aGivqtRA7WPZFED5nwowuqNvg==
X-Google-Smtp-Source: AGHT+IF/k/r0ySRsvTXjtMGk3oMS3ChIKX3SqVSvJ4wdwZ6HlhuHg/ElJKXsqxnttmxy4KSgE1/uIN6gA6j94CZFBuw=
X-Received: by 2002:a25:a2d2:0:b0:cfe:8cbf:5d28 with SMTP id
 c18-20020a25a2d2000000b00cfe8cbf5d28mr10283989ybn.31.1693846777856; Mon, 04
 Sep 2023 09:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230904161516.66751-1-vignesh.raman@collabora.com> <20230904161516.66751-3-vignesh.raman@collabora.com>
In-Reply-To: <20230904161516.66751-3-vignesh.raman@collabora.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 4 Sep 2023 19:59:26 +0300
Message-ID: <CAA8EJpq_cmFQ6TGy1xELh3ButWKLfSkQcp5ix049s_iqKw6DvQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] drm: ci: Force db410c to host mode
To:     Vignesh Raman <vignesh.raman@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, helen.koike@collabora.com,
        guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
        david.heidelberg@collabora.com, daniels@collabora.com,
        gustavo.padovan@collabora.com, emma@anholt.net,
        robclark@freedesktop.org, robdclark@google.com, anholt@google.com,
        robdclark@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, mripard@kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Sept 2023 at 19:16, Vignesh Raman <vignesh.raman@collabora.com> wrote:
>
> Force db410c to host mode to fix network issue which results in failure
> to mount root fs via NFS.
> See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a629b8c15c80a54dda510743cefd1c4b65b8
>
> Use fdtoverlay command to merge base device tree with an overlay
> which contains the fix for USB controllers to work in host mode.
>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>
> v2:
>   - Use fdtoverlay command to merge overlay dtbo with the base dtb instead of modifying the kernel sources
>
> ---
>  drivers/gpu/drm/ci/build.sh                         |  5 +++++
>  .../gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts  | 13 +++++++++++++
>  2 files changed, 18 insertions(+)
>  create mode 100644 drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
>
> diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
> index 7b014287a041..92ffd98cd09e 100644
> --- a/drivers/gpu/drm/ci/build.sh
> +++ b/drivers/gpu/drm/ci/build.sh
> @@ -92,6 +92,11 @@ done
>
>  if [[ -n ${DEVICE_TREES} ]]; then
>      make dtbs
> +    if [[ -e arch/arm64/boot/dts/qcom/apq8016-sbc.dtb ]]; then
> +        dtc -@ -I dts -O dtb -o drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dtbo drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
> +        fdtoverlay -i arch/arm64/boot/dts/qcom/apq8016-sbc.dtb -o arch/arm64/boot/dts/qcom/apq8016-sbc-overlay.dtb drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dtbo
> +        mv arch/arm64/boot/dts/qcom/apq8016-sbc-overlay.dtb arch/arm64/boot/dts/qcom/apq8016-sbc.dtb
> +    fi
>      cp ${DEVICE_TREES} /lava-files/.
>  fi
>
> diff --git a/drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts b/drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
> new file mode 100644
> index 000000000000..57b7604f1c23
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
> @@ -0,0 +1,13 @@
> +/dts-v1/;
> +/plugin/;
> +
> +/ {
> +    fragment@0 {
> +        target-path = "/soc@0";
> +        __overlay__ {
> +            usb@78d9000 {
> +                dr_mode = "host";
> +            };
> +        };
> +    };
> +};
> --
> 2.40.1

Can we use normal dtso syntax here instead of defining fragments manually?

-- 
With best wishes
Dmitry
