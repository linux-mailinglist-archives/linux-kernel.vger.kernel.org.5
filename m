Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C6E783BAB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjHVIXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjHVIXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:23:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C439012C;
        Tue, 22 Aug 2023 01:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692692600; x=1724228600;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7ZtFOd37UZeljeWUI+hNQjCnZrwIHihIrplW6xrvVMs=;
  b=Zoq8RjexDkBRjbJG9VK9Iy9Wn/Bm99jV8RUtNGVjRLMQmGaU4LlKc6IK
   Z947kIhkrfojxrN2XNQy/MwQunPSLOVfx/x3IdTUCOSav3pyDqDI99m4O
   JZir6CZcDE4xp1bdaO5HgNT9NetL0zuFoKCF3sRsPnDubBLKqLhHfqWQA
   WAxmRjjUGirMAn+p90f6xDxhFugK0PCGp7MEh7sEFwAvf3WW6j+jH6Z1Z
   tKC9TKSa2Ycylxkz0LnunFjsV8526fH6CiEK7W0Sj8LqaK6nb/HdnAFRU
   d5H/bUJIsHb1CokkFDFZLPfOkiCiIEM+A29l1x4GNbxXqEULill80CbwT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="376552101"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="376552101"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 01:23:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="739225314"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="739225314"
Received: from refaase-mobl.ger.corp.intel.com ([10.252.53.244])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 01:23:17 -0700
Date:   Tue, 22 Aug 2023 11:23:14 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
        Zhirong Qiu <zhirong.qiu@unisoc.com>,
        Zhaochen Su <Zhaochen.Su@unisoc.com>
Subject: Re: [PATCH] tty/serial: Cancel work queue before closing uart
In-Reply-To: <20230818031532.15591-1-Wenhua.Lin@unisoc.com>
Message-ID: <5b2cc220-eafc-c34a-c0de-617bd09c9cff@linux.intel.com>
References: <20230818031532.15591-1-Wenhua.Lin@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023, Wenhua Lin wrote:

I've problems following your description below due to grammar errors.

> When the system constantly sleeps and wankes up, plugging and unplugging

wakes

> the USB will probalility trigger a kernel crash problem.

probalility is typoed and I cannot guess which of the words you meant, 
please fix.

If there's a known crash you're fixing here, please quote the crash 
message in the changelog (and you should probably add Fixes: tag too in 
that case).

> The reason is
> that at this time, the system entered deep and turned off uart, and the

"entered deep" lacks probably some word?

> abnormal behavior of plugging and upplugging the USB triggered the read

unplugging.

Why call that abnormal behavior? Isn't USB expected to removed.

> data process of uart, causing access to uart to hang.

Are you saying a read was triggered while the UART was suspended or what?

> The final solution
> we came up with is to cancel the work queue before shutting down uart
> , while ensuring that there is no uart business.

", while ensuring" -> to ensure

"uart business" is too vague, you should replace it with something more 
concrete.

Thanks.

--
 i.

> 
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>  drivers/tty/serial/sprd_serial.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> index b58f51296ace..eddff4360155 100644
> --- a/drivers/tty/serial/sprd_serial.c
> +++ b/drivers/tty/serial/sprd_serial.c
> @@ -20,6 +20,7 @@
>  #include <linux/slab.h>
>  #include <linux/tty.h>
>  #include <linux/tty_flip.h>
> +#include "../tty.h"
>  
>  /* device name */
>  #define UART_NR_MAX		8
> @@ -1221,7 +1222,10 @@ static int sprd_probe(struct platform_device *pdev)
>  static int sprd_suspend(struct device *dev)
>  {
>  	struct sprd_uart_port *sup = dev_get_drvdata(dev);
> +	struct uart_port *uport = &sup->port;
> +	struct tty_port *tty = &uport->state->port;
>  
> +	tty_buffer_cancel_work(tty);
>  	uart_suspend_port(&sprd_uart_driver, &sup->port);
>  
>  	return 0;
> 
