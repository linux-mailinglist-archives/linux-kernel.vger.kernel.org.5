Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3878895B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245393AbjHYN5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245447AbjHYN4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:56:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7122722;
        Fri, 25 Aug 2023 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692971788; x=1724507788;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=rL8lwlEpWwyz5gytyannueKCuDWZ7o3Z7O2OXGq9D24=;
  b=n2NsTeYC9dPgt8JUtmceRHEGDy+zmLfYRx22h38ZYAHBykBC9R0G3NMq
   vGlmACzkVvY9UYi2pvyarR0ewng5inwB1nyg0tud/yKVtXd0XDwYX5cdI
   t3t3nAdoLr3FII+4hhLBVxBWCUKGf/dzXWfQOtWymWRBKIIEJnnGgSjbp
   POFT0yktsUUIvQI/1yMY2nutO8fbiaJQCPqm1zl5EaSKHS4EWhLJDraV4
   CiG8UQN6JR9LogHZrNaeLLAo0VrnpXxuiK+fBlKNEYd7aI/RCZpYn9RZc
   GblVxbkD8dutmuc2BLvDein1tbgtV75fIE3NkqgRGQG+atFDQeRDiTmlI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="373586065"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="373586065"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 06:56:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="731073145"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="731073145"
Received: from ogbrugge-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.56.56])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 06:56:16 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Vignesh Raman <vignesh.raman@collabora.com>,
        dri-devel@lists.freedesktop.org
Cc:     emma@anholt.net, linux-doc@vger.kernel.org,
        david.heidelberg@collabora.com, linux-amlogic@lists.infradead.org,
        jbrunet@baylibre.com, robdclark@google.com, corbet@lwn.net,
        khilman@baylibre.com, sergi.blanch.torne@collabora.com,
        gustavo.padovan@collabora.com, linux-rockchip@lists.infradead.org,
        daniels@collabora.com, martin.blumenstingl@googlemail.com,
        robclark@freedesktop.org, helen.koike@collabora.com,
        anholt@google.com, linux-mediatek@lists.infradead.org,
        mripard@kernel.org, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com, neil.armstrong@linaro.org,
        guilherme.gallo@collabora.com, linux-kernel@vger.kernel.org,
        tzimmermann@suse.de
Subject: Re: [PATCH 2/6] drm: ci: Force db410c to host mode
In-Reply-To: <20230825122435.316272-3-vignesh.raman@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230825122435.316272-1-vignesh.raman@collabora.com>
 <20230825122435.316272-3-vignesh.raman@collabora.com>
Date:   Fri, 25 Aug 2023 16:56:12 +0300
Message-ID: <87pm3b2pkz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> Force db410c to host mode to fix network issue which results in failure
> to mount root fs via NFS.
> See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a629b8c15c80a54dda510743cefd1c4b65b8
>
> Since this fix is not sent upstream, add it to build.sh script
> before building the kernel and dts. Better approach would be
> to use devicetree overlays.
>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  drivers/gpu/drm/ci/build.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
> index 7b014287a041..c39834bd6bd7 100644
> --- a/drivers/gpu/drm/ci/build.sh
> +++ b/drivers/gpu/drm/ci/build.sh
> @@ -70,6 +70,10 @@ if [ -z "$CI_MERGE_REQUEST_PROJECT_PATH" ]; then
>      fi
>  fi
>  
> +# Force db410c to host mode to fix network issue which results in failure to mount root fs via NFS.
> +# See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a629b8c15c80a54dda510743cefd1c4b65b8
> +sed -i '/&usb {/,/status = "okay";/s/status = "okay";/&\n\tdr_mode = "host";/' arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> +

It seems like a really bad idea to me to have the CI build modify the
source tree before building.

The kernel being built will have a dirty git repo, and the localversion
will have -dirty in it.

I think it would be better to do out-of-tree builds and assume the
source is read-only.

>  for opt in $ENABLE_KCONFIGS; do
>    echo CONFIG_$opt=y >> drivers/gpu/drm/ci/${KERNEL_ARCH}.config
>  done

Ditto for the config changes in the context here. Those are files in
git, don't change them.

Shouldn't this use something like 'scripts/config --enable' or
'scripts/config --disable' on the .config file to be used for building
instead?


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
