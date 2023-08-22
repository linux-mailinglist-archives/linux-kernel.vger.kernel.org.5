Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C7D784A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjHVTZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjHVTZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:25:18 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B05191
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:25:16 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bdb7b0c8afso28870035ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692732315; x=1693337115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a1G5m8Qjmh6jxuKz8UMaMjH/jWYmISiVf2CP4Ro+UAY=;
        b=nlIifxq5oK59/+pYadZdfblkJhLw6Wf3kugMEjW/uM48NiTw+MEQquBAdNN3yINmbD
         G+WWwh/Pzr1+cjfFDD2NjH7RmIVfDUTU2A0OctPa2W9L0sWWs2W0v+o+z+RG8vT7YKju
         zjJT87CjUaXWXDuraadxViGz5sZ8tWTSkGJTpKx12WajS8z6AKVq/RwMCk2X2Z8carxZ
         u/shkw0jB0Aax9jmMviiz6zCh5lhoETGbQFc6yuCE4hghGIxtVPwcb4gNTOYkgoiivBd
         njXujFVP42SKzRLbjGteCe2RONqCvLfW2pTkhcHprrWmcQOBAMZqA/PT0XBUZsgesyry
         +38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692732315; x=1693337115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1G5m8Qjmh6jxuKz8UMaMjH/jWYmISiVf2CP4Ro+UAY=;
        b=VgI5Ulnw71AxzM+aJuW09swyzZchCO3rOIZ/fc6/DzgkBpbKwAe4MgbWyuHLuECKFf
         Z8YsrdFSz2uablDVlVMFhzl01yXtx2kHxnLJsR+huwonSrts2ozHmasqHmdDWpR3F7r4
         7H10mJDe3VsV2E/4tMZzPzS5J1clCD7S651+50w0RrBQYKJkEDabrN8MfFKOdSda49ej
         XaZ0IAzMa/tqvu2cCtg5wZQGTuI/3Ew/dU+BmoUwOu8yCSMFZBfO7LXsmVgqMj+YlNYt
         eI0HYwCMh/sI8NLlapAAfHNBq9PZssFSaQR7bMIYI7HxbzU4wjRQql7XH+qQhqXCS0aI
         co2Q==
X-Gm-Message-State: AOJu0YzLIaBjsfmgMu0o9mCnU+nOAZTRo9QhgAIykqhOcurl/H+NOLbX
        4Wc8QTw8Unyi3Z4T1yGEojBxyw==
X-Google-Smtp-Source: AGHT+IEaJfj8jetHWv6UJxqJomeGDsdD4fGQV/B1z8Y4BwNnSPKNCwY61lFIuQahs/kESgkkORG+gA==
X-Received: by 2002:a17:903:120d:b0:1bb:c971:ef92 with SMTP id l13-20020a170903120d00b001bbc971ef92mr8792158plh.59.1692732315450;
        Tue, 22 Aug 2023 12:25:15 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:4e2f:8663:6f0a:bb69])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b001b2069072ccsm9377559plh.18.2023.08.22.12.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:25:14 -0700 (PDT)
Date:   Tue, 22 Aug 2023 13:25:12 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Robert Nelson <robertcnelson@gmail.com>,
        Kevin Cahalan <kevinacahalan@gmail.com>
Subject: Re: [PATCH] remoteproc: core: Honor device tree /alias entries when
 assigning IDs
Message-ID: <ZOULmFR51C+9kEhZ@p14s>
References: <20230807140247.956255-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807140247.956255-1-nm@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On Mon, Aug 07, 2023 at 09:02:47AM -0500, Nishanth Menon wrote:
> On many platforms, such as Beaglebone-AI64 with many remote
> processors, firmware configurations provided by the distributions can
> vary substantially depending on the distribution build's functionality
> and the specific remote cores enabled in that variant. Ensuring
> consistent udev rules mapping remoteproc nodes to constant remote
> proc device indices across distributions (yocto, ubuntu, debian and
> it's variants, ...) on a board basis can be challenging due to the
> various functions of these distributions. Varied device node paths
> create challenges for applications that operate on remote processors,
> especially in minimal embedded systems(initrd like) that may not
> have udev-like capabilities and rely on a more straightforward bare
> filesystem. This challenge is similar to that faced by I2C, RTC or the
> GPIO subsystems.
>

I'm puzzled by this patch.  I can see how using an alias can help in boards with
various HW configuration.  That said, and as written above, FW files for remote
processors can vary based on the build's functionality.  As such "remoteproc3"
will reference the same HW device on all distributions but the functionality
enacted by the FW may be different.  As such I don't see how an alias can help
here.  Can you provide a concrete example that highlights the benefits?

Thanks,
Mathieu

> Assign remoteproc device IDs based on device tree /aliases entries if
> present, falling back to the existing numbering scheme if there is no
> /aliases entry (which includes when the system isn't booted using DT)
> or a numbering conflict. If the alias node is not present, the driver
> behaves as before.
> 
> Cc: Robert Nelson <robertcnelson@gmail.com>
> Reported-by: Kevin Cahalan <kevinacahalan@gmail.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Test log: Beaglebone-AI64
> https://gist.github.com/nmenon/365cf80d6c0685dd9be7c2cb18d7c937 (along
> with a test change to force the sequence of initialization)
> 
> The report occurred on Beagle discord channel - so I am not
> sure how to share the logs of the report.
> 
>  drivers/remoteproc/remoteproc_core.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 695cce218e8c..a12f3d37b8de 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -19,6 +19,7 @@
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/device.h>
>  #include <linux/panic_notifier.h>
>  #include <linux/slab.h>
> @@ -2417,6 +2418,25 @@ static int rproc_alloc_ops(struct rproc *rproc, const struct rproc_ops *ops)
>  	return 0;
>  }
>  
> +static int rproc_device_get_id(struct device *dev)
> +{
> +	int of_id = -1, id = -1;
> +
> +	if (dev->of_node)
> +		of_id = of_alias_get_id(dev->of_node, "remoteproc");
> +
> +	if (of_id >= 0) {
> +		id = ida_simple_get(&rproc_dev_index, of_id, of_id + 1, GFP_KERNEL);
> +		if (id < 0)
> +			dev_warn(dev, "/aliases ID %d not available\n", of_id);
> +	}
> +
> +	if (id < 0)
> +		id = ida_alloc(&rproc_dev_index, GFP_KERNEL);
> +
> +	return id;
> +}
> +
>  /**
>   * rproc_alloc() - allocate a remote processor handle
>   * @dev: the underlying device
> @@ -2476,7 +2496,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  		goto put_device;
>  
>  	/* Assign a unique device index and name */
> -	rproc->index = ida_alloc(&rproc_dev_index, GFP_KERNEL);
> +	rproc->index = rproc_device_get_id(dev);
>  	if (rproc->index < 0) {
>  		dev_err(dev, "ida_alloc failed: %d\n", rproc->index);
>  		goto put_device;
> -- 
> 2.40.0
> 
