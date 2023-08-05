Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FA77710F3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjHERYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHERX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:23:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04976E7;
        Sat,  5 Aug 2023 10:23:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8470760CA0;
        Sat,  5 Aug 2023 17:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0A5C433C8;
        Sat,  5 Aug 2023 17:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691256236;
        bh=BbzHGpUBsuGfV7pkOJsxZ3KB9uZF7Ih5TgB7xbv8WZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IFjuy7s9HlNqCdhSjHhUckxj+uPZnXdNmhOLnvG2I89/HiINMBV2Ig8gPmcbkKWv3
         04tPMZmbW7o2q9m6shfDcZ+AOkjeTF1rNFkUfv9cjSEkMEuUfwo5aftlmjp3++Bizz
         hpA5pEuBv3zACD0r54fuPcs+e2F4pH0h/j03pPnFkuDpKyCDKWobXfPhQou9Sw57m2
         Em194qqIZ/BAZmU7AbPA9FwL1h2fjMUTQdE3FhiqHNWqNLRLU6pVlKzS/CWmM0p/ld
         Le/E392k48Cz9Kzl/HMlRcsDygeOuu8iT5MNta4quGFERp7kpM7pO1DgRzhpiGrRXg
         inWtrFWP/KO+w==
Date:   Sat, 5 Aug 2023 10:26:54 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v14 09/25] gunyah: vm_mgr: Introduce basic VM Manager
Message-ID: <nczfl5gh2uwxyswgntzmwdhb5zlrybostekanvsrdyfv7sjwlp@fb4m2sz4ojoa>
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
 <20230613172054.3959700-10-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613172054.3959700-10-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:20:37AM -0700, Elliot Berman wrote:
> diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
> index 04c8e131d259f..a0faf126ee56e 100644
> --- a/drivers/virt/gunyah/rsc_mgr.c
> +++ b/drivers/virt/gunyah/rsc_mgr.c
> @@ -15,8 +15,10 @@
>  #include <linux/completion.h>
>  #include <linux/gunyah_rsc_mgr.h>
>  #include <linux/platform_device.h>
> +#include <linux/miscdevice.h>

'm' < 'p'

>  
>  #include "rsc_mgr.h"
> +#include "vm_mgr.h"
>  
>  #define RM_RPC_API_VERSION_MASK		GENMASK(3, 0)
>  #define RM_RPC_HEADER_WORDS_MASK	GENMASK(7, 4)
> @@ -130,6 +132,7 @@ struct gh_rm_connection {
>   * @cache: cache for allocating Tx messages
>   * @send_lock: synchronization to allow only one request to be sent at a time
>   * @nh: notifier chain for clients interested in RM notification messages
> + * @miscdev: /dev/gunyah
>   */
>  struct gh_rm {
>  	struct device *dev;
> @@ -146,6 +149,8 @@ struct gh_rm {
>  	struct kmem_cache *cache;
>  	struct mutex send_lock;
>  	struct blocking_notifier_head nh;
> +
> +	struct miscdevice miscdev;
>  };
>  
>  /**
> @@ -580,6 +585,33 @@ int gh_rm_notifier_unregister(struct gh_rm *rm, struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL_GPL(gh_rm_notifier_unregister);
>  
> +struct device *gh_rm_get(struct gh_rm *rm)
> +{
> +	return get_device(rm->miscdev.this_device);

Please add a comment to why the VM is parented off the miscdevice and
not the RM itself, when the function name indicates that you're
acquiring a reference to the rm...

> +}
> +EXPORT_SYMBOL_GPL(gh_rm_get);
> +
[..]
> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
> new file mode 100644
> index 0000000000000..a43401cb34f7d
> --- /dev/null
> +++ b/drivers/virt/gunyah/vm_mgr.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#define pr_fmt(fmt) "gh_vm_mgr: " fmt

Unused?

Regards,
Bjorn
