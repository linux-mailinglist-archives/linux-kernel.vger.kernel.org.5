Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31687632A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjGZJms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjGZJmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:42:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9262691
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F87461A1D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05F9C433C7;
        Wed, 26 Jul 2023 09:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690364527;
        bh=jT7Nd0DTD2cLsNYeo9Ha6N6zXG4jGj4savk3XbwfyNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UceMv7yRBsMpU6EFD5fnSm68w07ZIVTaHp8SLds80phf4UAU6lD+9Xcipk4zWl2HN
         ci48z8nN5jXIQvj5ViX8PREkREeevgumjyEhNyTZiV7BUxevKS+MGnGvRG+gOnaQTO
         BGWHtuefeeCtlFrDlduzXx9qr1AvvCAuwDqE/nes=
Date:   Wed, 26 Jul 2023 11:42:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] misc: hi6421-spmi-pmic: Remove redundant dev_err()
Message-ID: <2023072646-valid-quote-d313@gregkh>
References: <20230726170644.2474917-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726170644.2474917-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 05:06:44PM +0000, Ruan Jinjie wrote:
> There is no need to call the dev_err() function directly to print a custom
> message when handling an error from the platform_get_irq() functions as it
> going to display an appropriate error message in case of a failure.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/misc/hi6421v600-irq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/misc/hi6421v600-irq.c b/drivers/misc/hi6421v600-irq.c
> index caa3de37698b..e5ed94e98a3c 100644
> --- a/drivers/misc/hi6421v600-irq.c
> +++ b/drivers/misc/hi6421v600-irq.c
> @@ -245,7 +245,6 @@ static int hi6421v600_irq_probe(struct platform_device *pdev)
>  
>  	priv->irq = platform_get_irq(pmic_pdev, 0);
>  	if (priv->irq < 0) {
> -		dev_err(dev, "Error %d when getting IRQs\n", priv->irq);
>  		return priv->irq;
>  	}

It's good not to add coding style errors when trying to fix up a
different type of issue :(
