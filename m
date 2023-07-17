Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FCB756AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjGQRsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjGQRrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:47:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06810191;
        Mon, 17 Jul 2023 10:47:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E9F0611AD;
        Mon, 17 Jul 2023 17:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE7AC43397;
        Mon, 17 Jul 2023 17:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689616067;
        bh=P0+p9Olt6ycXAEYaEcE6zFrH57LOqtI2MFvhh2oCT1k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kHPyWFnZ0jjemwyAWnAfABKjVAgEvP2ZtXQPpVr9dazEzY4Z1CJeF3wI4KuupDdXo
         /ehVYo4W//mhyOsQDlkB6Q9xjgbiQZ+KbrQUpam/kGB/Ct8OwAbKB4MSz+LK8fb365
         hK70OdsD7DJV+7FFuEcqycvR1PokdrHEtmoAsevlU3c8Prj7H4rhTgh1oSKNjSO1ik
         3yVp9qIwh1EV/eW31AV9ZHoxRZ2JjMICf1NWuDWEu0SmGMwYDxcrrpJb29D7nzglxM
         UMteuPksMhUCGRF8nEFTSSn+/XTMlebBx8G2Y+sAGu5NkXe8TU3Hzuo4Oh2Xo5N+9W
         8iHCUIctDICew==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b734aea34aso73642711fa.0;
        Mon, 17 Jul 2023 10:47:46 -0700 (PDT)
X-Gm-Message-State: ABy/qLZFOxJpTnK9IrMsTksH5Y83HPnOztHU38WBRsvPIiHNq7xumdkm
        LAhqsAkzWL6RhtWs5iohQsrQaQxqO+WrEYY29w==
X-Google-Smtp-Source: APBJJlHDBBqNEhwdpt/uN8797F2olufKZp3/nJpjbMiW5Ff0J6rgsYNLEqheulUrN8J9VhW4Smgd0dfY+xaxvTzg0RM=
X-Received: by 2002:a2e:8611:0:b0:2b6:e625:ba55 with SMTP id
 a17-20020a2e8611000000b002b6e625ba55mr9811234lji.41.1689616064972; Mon, 17
 Jul 2023 10:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230714174735.4060016-1-robh@kernel.org>
In-Reply-To: <20230714174735.4060016-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 17 Jul 2023 11:47:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKTqmAVBJmuGUb_oi3X4zvfroEwEtq0Ww=cJPyXtgx5pA@mail.gmail.com>
Message-ID: <CAL_JsqKTqmAVBJmuGUb_oi3X4zvfroEwEtq0Ww=cJPyXtgx5pA@mail.gmail.com>
Subject: Re: [PATCH] misc: Explicitly include correct DT includes
To:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 11:47=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
>
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/misc/cxl/base.c            | 1 +
>  drivers/misc/fastrpc.c             | 1 +
>  drivers/misc/lis3lv02d/lis3lv02d.c | 2 +-
>  drivers/misc/qcom-coincell.c       | 1 -
>  drivers/misc/sram.c                | 2 +-
>  drivers/misc/vcpu_stall_detector.c | 1 -
>  drivers/misc/xilinx_sdfec.c        | 4 +++-
>  drivers/misc/xilinx_tmr_inject.c   | 3 ++-
>  drivers/misc/xilinx_tmr_manager.c  | 3 ++-
>  9 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/misc/cxl/base.c b/drivers/misc/cxl/base.c
> index cc0caf9192dc..b054562c046e 100644
> --- a/drivers/misc/cxl/base.c
> +++ b/drivers/misc/cxl/base.c
> @@ -7,6 +7,7 @@
>  #include <linux/rcupdate.h>
>  #include <asm/errno.h>
>  #include <misc/cxl-base.h>
> +#include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include "cxl.h"
>
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 9666d28037e1..1c7c0532da6f 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/sort.h>
>  #include <linux/of_platform.h>
>  #include <linux/rpmsg.h>
> diff --git a/drivers/misc/lis3lv02d/lis3lv02d.c b/drivers/misc/lis3lv02d/=
lis3lv02d.c
> index 299d316f1bda..49868a45c0ad 100644
> --- a/drivers/misc/lis3lv02d/lis3lv02d.c
> +++ b/drivers/misc/lis3lv02d/lis3lv02d.c
> @@ -26,7 +26,7 @@
>  #include <linux/miscdevice.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/atomic.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include "lis3lv02d.h"
>
>  #define DRIVER_NAME     "lis3lv02d"
> diff --git a/drivers/misc/qcom-coincell.c b/drivers/misc/qcom-coincell.c
> index 54d4f6ee8888..3c57f7429147 100644
> --- a/drivers/misc/qcom-coincell.c
> +++ b/drivers/misc/qcom-coincell.c
> @@ -8,7 +8,6 @@
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/regmap.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>
>  struct qcom_coincell {
> diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
> index 5757adf418b1..a88f92cf35be 100644
> --- a/drivers/misc/sram.c
> +++ b/drivers/misc/sram.c
> @@ -10,8 +10,8 @@
>  #include <linux/genalloc.h>
>  #include <linux/io.h>
>  #include <linux/list_sort.h>
> +#include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> diff --git a/drivers/misc/vcpu_stall_detector.c b/drivers/misc/vcpu_stall=
_detector.c
> index 53b5506080e1..6479c962da1a 100644
> --- a/drivers/misc/vcpu_stall_detector.c
> +++ b/drivers/misc/vcpu_stall_detector.c
> @@ -13,7 +13,6 @@
>  #include <linux/module.h>
>  #include <linux/nmi.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/param.h>
>  #include <linux/percpu.h>
>  #include <linux/platform_device.h>
> diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> index 270ff4c5971a..35941c006552 100644
> --- a/drivers/misc/xilinx_sdfec.c
> +++ b/drivers/misc/xilinx_sdfec.c
> @@ -15,12 +15,14 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_platform.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/poll.h>
>  #include <linux/slab.h>
>  #include <linux/clk.h>
>  #include <linux/compat.h>
>  #include <linux/highmem.h>
> +#include <linux/of.h>

Double include of of.h. v2 coming.
