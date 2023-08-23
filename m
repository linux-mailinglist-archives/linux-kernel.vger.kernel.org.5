Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FF778599D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbjHWNk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjHWNk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:40:27 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C51E4E;
        Wed, 23 Aug 2023 06:40:21 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1qYo5p-0007Ob-SN; Wed, 23 Aug 2023 15:40:17 +0200
Date:   Wed, 23 Aug 2023 15:40:17 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        alex@shruggie.ro, herbert@gondor.apana.org.au, olivia@selenic.com
Subject: Re: [PATCH] char: hw_random: ba431-rng: removed unneeded call to
 platform_set_drvdata()
Message-ID: <20230823134017.gguqgagcbb7tvnxc@viti.kaiser.cx>
References: <20230823110758.3462-1-aboutphysycs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823110758.3462-1-aboutphysycs@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrei Coardos (aboutphysycs@gmail.com) wrote:

> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Also,
> the private data is defined in this driver, so there is no risk of it being
> accessed outside of this driver file.

> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/char/hw_random/ba431-rng.c | 2 --
>  1 file changed, 2 deletions(-)

> diff --git a/drivers/char/hw_random/ba431-rng.c b/drivers/char/hw_random/ba431-rng.c
> index 5b7ca0416490..b1518dd52a24 100644
> --- a/drivers/char/hw_random/ba431-rng.c
> +++ b/drivers/char/hw_random/ba431-rng.c
> @@ -189,8 +189,6 @@ static int ba431_trng_probe(struct platform_device *pdev)
>  	ba431->rng.cleanup = ba431_trng_cleanup;
>  	ba431->rng.read = ba431_trng_read;

> -	platform_set_drvdata(pdev, ba431);
> -
>  	ret = devm_hwrng_register(&pdev->dev, &ba431->rng);
>  	if (ret) {
>  		dev_err(&pdev->dev, "BA431 registration failed (%d)\n", ret);
> -- 
> 2.34.1

This was already removed in e8c1fdcc62d3 ("hwrng: ba431 - do not set
drvdata").
