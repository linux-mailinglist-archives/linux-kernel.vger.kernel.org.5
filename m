Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA9D77D089
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbjHORE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238602AbjHORDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:03:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8251991
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:03:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 144CF62167
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 17:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99868C433C8;
        Tue, 15 Aug 2023 17:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692119033;
        bh=0GmbESWFc+4IjIBduOcReVgODGi32wSRMGd/WvwRYDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XfTGAWgOrwbUuRj8oy6bL/Ln9hpU8q+qKfssve7qyRJZeBis17jeR4vhDBMKbQm1W
         apXi1mE+C5uXtuCeLl1qoz7Rg7kubyUsk+LoaZd9+LaGnNkr1rQ2t8uqVUbxzKQvu1
         LWKUPq3FpJkNEaokURT/ck+b1ouHcP9HzTS4LBdWVoH6sz/Pzsm5X5Q0l/zddQe3Hk
         +JtLetK/ywF8Z5dJzHhFpKHR7wpx4ZMIVkQlKl1GSs2mYuru/nvnwfS7thiicLpOb6
         h2rkvOrB9ccJuE+Akb/cI1mHWxFcf6fF4X0bs8rw9N+Joo2wNNgmrSDBPhoS7VILYp
         P31ylQJqPwPnQ==
Date:   Tue, 15 Aug 2023 18:03:49 +0100
From:   Lee Jones <lee@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH -next] mfd: remove unexpected file
 drivers/mfd/rz-mtu3.c.rej
Message-ID: <20230815170349.GC648357@google.com>
References: <20230810025413.3223814-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230810025413.3223814-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023, Yang Yingliang wrote:

> Commit bb60922c31d0 ("mfd: Explicitly include correct DT includes") added
> an unexpected file drivers/mfd/rz-mtu3.c.rej, remove the file.
> 
> Fixes: bb60922c31d0 ("mfd: Explicitly include correct DT includes")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/mfd/rz-mtu3.c.rej | 12 ------------
>  1 file changed, 12 deletions(-)
>  delete mode 100644 drivers/mfd/rz-mtu3.c.rej

Thanks for the report.

I have squashed this into the original patch.

> diff --git a/drivers/mfd/rz-mtu3.c.rej b/drivers/mfd/rz-mtu3.c.rej
> deleted file mode 100644
> index 9654d98cfedf..000000000000
> --- a/drivers/mfd/rz-mtu3.c.rej
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -diff a/drivers/mfd/rz-mtu3.c b/drivers/mfd/rz-mtu3.c	(rejected hunks)
> -@@ -11,7 +11,9 @@
> - #include <linux/irq.h>
> - #include <linux/mfd/core.h>
> - #include <linux/mfd/rz-mtu3.h>
> --#include <linux/of_platform.h>
> -+#include <linux/mod_devicetable.h>
> -+#include <linux/module.h>
> -+#include <linux/platform_device.h>
> - #include <linux/reset.h>
> - #include <linux/spinlock.h>
> - 
> -- 
> 2.25.1
> 

-- 
Lee Jones [李琼斯]
