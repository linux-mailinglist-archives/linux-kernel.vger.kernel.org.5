Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056357F3B39
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbjKVBZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbjKVBZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:25:28 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D069691
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:25:24 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7b34ee2a243so32744239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700616324; x=1701221124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BMxupQd497LdzSfq71N2Lrlf91nzxCDS16y5//A13wo=;
        b=dFyfbxLWoSAfJhRGo9KHNLUPaC6j+hkljTNEK27bL7TuvpYWImGFAnwiFdkvq2pWOz
         DJ/uHh5R4/bOsYOiVWuJ+ckdrDsHZyf0S5Zxnar19kBeXKL+GUGp8CXLdiPabRFFqBNf
         3bG67hqmFbsTFHfxURYFp+YQ75FZMK2x44MtoTh08zIk2a8lujls0FNx/NAWzfq2bGdX
         6Kmy2eC3Tl+rYv1hgnXagmuiJNCNN1Owk6UxUSnKNVxxrznyXa2DyBNeBRypqxCDUaHM
         qMFQpyeoKHO6YEfQ84BS0Hy5KoQJW2YWOC4gP7d3UpVwuuB6YBHbuJoGi+r/Zk5DS0Sb
         ytJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700616324; x=1701221124;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMxupQd497LdzSfq71N2Lrlf91nzxCDS16y5//A13wo=;
        b=tr14rJizGKkdA27Fvbud7lrMOkp0ZIA13KpEj4bQD8MgK/pDCJ34Kgk5Dtlv7bpkR9
         nTXOrQcubU/ShettzzR3TJmaYUw/07Yi8wczs+eFjj/WoJX0DT9QqIeanNfpeiTWfdkK
         mCGyAwKevTn8Yx9k/VAk1l8/jwGoVmsfA2taeoIDIP8aLRnb2l1I9gDU4wfp1dOLj/YT
         AkJfI8KcJZLNReijIiSwxsGD0SFBaKPVVsNxJJ91hlQh/zzxbox6WxD6UsvZ2Klz4W1k
         7QgUVzzBqn1hioHKHE7mR7u4gdyvQJZI+dwThExNR1zyHnpooEiZJG8vaUehw+AWobrP
         R53A==
X-Gm-Message-State: AOJu0Yzk88MXXkA6lN7woFQeFoIlrJP+x7y2i25swwOcj6AXGhZnUiBd
        v6+YZjxn64jKYzhVbx8/wA+U0ArRgS7rxjfkktE=
X-Google-Smtp-Source: AGHT+IGd2vGwd7giL7IiRH+5KGiQaPdBluSITVY3kHLXCILv1oR63uIuSpDbZGfswF+tU7/fqS6Mqw==
X-Received: by 2002:a05:6602:1b04:b0:7a2:a8d5:e146 with SMTP id dk4-20020a0566021b0400b007a2a8d5e146mr576892iob.15.1700616324211;
        Tue, 21 Nov 2023 17:25:24 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:3d43:c8e2:1496:e620? ([2605:a601:adae:4500:3d43:c8e2:1496:e620])
        by smtp.gmail.com with ESMTPSA id az2-20020a056638418200b004664b598273sm2122901jab.49.2023.11.21.17.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 17:25:23 -0800 (PST)
Message-ID: <d94d54d2-50a3-4dc8-9178-e69c118aeefe@sifive.com>
Date:   Tue, 21 Nov 2023 19:25:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] soc: sifive: shunt ccache driver to drivers/cache
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
References: <20231012-mooing-refined-ad1ab421c0d3@spud>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231012-mooing-refined-ad1ab421c0d3@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On 2023-10-12 4:22 AM, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Move the ccache driver over to drivers/cache, out of the drivers/soc
> dumping ground, to this new collection point for cache controller
> drivers.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Conor Dooley <conor@kernel.org>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Emil Renner Berthing <kernel@esmil.dk>
> CC: linux-kernel@vger.kernel.org
> CC: linux-riscv@lists.infradead.org
> ---
>  MAINTAINERS                                   | 14 +++++++-------
>  drivers/cache/Kconfig                         |  8 ++++++++
>  drivers/cache/Makefile                        |  3 ++-
>  drivers/{soc/sifive => cache}/sifive_ccache.c |  0
>  drivers/soc/Kconfig                           |  1 -
>  drivers/soc/Makefile                          |  1 -
>  drivers/soc/sifive/Kconfig                    | 10 ----------
>  drivers/soc/sifive/Makefile                   |  3 ---
>  8 files changed, 17 insertions(+), 23 deletions(-)
>  rename drivers/{soc/sifive => cache}/sifive_ccache.c (100%)
>  delete mode 100644 drivers/soc/sifive/Kconfig
>  delete mode 100644 drivers/soc/sifive/Makefile
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90f13281d297..ab32599fc799 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19580,6 +19580,13 @@ S:	Supported
>  N:	sifive
>  K:	[^@]sifive
>  
> +SIFIVE CACHE DRIVER
> +M:	Conor Dooley <conor@kernel.org>
> +L:	linux-riscv@lists.infradead.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> +F:	drivers/cache/sifive_ccache.c
> +
>  SIFIVE FU540 SYSTEM-ON-CHIP
>  M:	Paul Walmsley <paul.walmsley@sifive.com>
>  M:	Palmer Dabbelt <palmer@dabbelt.com>
> @@ -19595,13 +19602,6 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
>  F:	drivers/dma/sf-pdma/
>  
> -SIFIVE SOC DRIVERS
> -M:	Conor Dooley <conor@kernel.org>
> -L:	linux-riscv@lists.infradead.org
> -S:	Maintained
> -T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
> -F:	Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> -F:	drivers/soc/sifive/
>  
>  SILEAD TOUCHSCREEN DRIVER
>  M:	Hans de Goede <hdegoede@redhat.com>
> diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
> index a57677f908f3..433b7ded8787 100644
> --- a/drivers/cache/Kconfig
> +++ b/drivers/cache/Kconfig
> @@ -8,4 +8,12 @@ config AX45MP_L2_CACHE
>  	help
>  	  Support for the L2 cache controller on Andes Technology AX45MP platforms.
>  
> +if ARCH_SIFIVE || ARCH_STARFIVE

Since this is now in a file grouped/sorted by subsystem instead of by platform,
maybe it makes sense to convert this to a "depends on" line?

> +
> +config SIFIVE_CCACHE
> +	bool "Sifive Composable Cache controller"
> +	help
> +	  Support for the composable cache controller on SiFive platforms.
> +
> +endif
>  endmenu
> diff --git a/drivers/cache/Makefile b/drivers/cache/Makefile
> index 2012e7fb978d..7657cff3bd6c 100644
> --- a/drivers/cache/Makefile
> +++ b/drivers/cache/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -obj-$(CONFIG_AX45MP_L2_CACHE) += ax45mp_cache.o
> +obj-$(CONFIG_AX45MP_L2_CACHE)	+= ax45mp_cache.o
> +obj-$(CONFIG_SIFIVE_CCACHE)	+= sifive_ccache.o
> diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/cache/sifive_ccache.c
> similarity index 100%
> rename from drivers/soc/sifive/sifive_ccache.c
> rename to drivers/cache/sifive_ccache.c
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index d21e75d69294..76afeff93045 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -23,7 +23,6 @@ source "drivers/soc/qcom/Kconfig"
>  source "drivers/soc/renesas/Kconfig"
>  source "drivers/soc/rockchip/Kconfig"
>  source "drivers/soc/samsung/Kconfig"
> -source "drivers/soc/sifive/Kconfig"
>  source "drivers/soc/starfive/Kconfig"

This file has a conflict and needs to be rebased, but otherwise:

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>

>  source "drivers/soc/sunxi/Kconfig"
>  source "drivers/soc/tegra/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 0706a27d13be..ba8f5b5460e1 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -28,7 +28,6 @@ obj-y				+= qcom/
>  obj-y				+= renesas/
>  obj-y				+= rockchip/
>  obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
> -obj-y				+= sifive/
>  obj-y				+= sunxi/
>  obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
>  obj-y				+= ti/
> diff --git a/drivers/soc/sifive/Kconfig b/drivers/soc/sifive/Kconfig
> deleted file mode 100644
> index 139884addc41..000000000000
> --- a/drivers/soc/sifive/Kconfig
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -
> -if ARCH_SIFIVE || ARCH_STARFIVE
> -
> -config SIFIVE_CCACHE
> -	bool "Sifive Composable Cache controller"
> -	help
> -	  Support for the composable cache controller on SiFive platforms.
> -
> -endif
> diff --git a/drivers/soc/sifive/Makefile b/drivers/soc/sifive/Makefile
> deleted file mode 100644
> index 1f5dc339bf82..000000000000
> --- a/drivers/soc/sifive/Makefile
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -
> -obj-$(CONFIG_SIFIVE_CCACHE)	+= sifive_ccache.o

