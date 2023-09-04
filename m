Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6EB791E0D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 22:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbjIDUBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 16:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjIDUB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 16:01:27 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E438ACFD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 13:01:15 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 50758200054;
        Mon,  4 Sep 2023 20:01:14 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 32BAF21DC6; Mon,  4 Sep 2023 21:59:43 +0200 (CEST)
Date:   Mon, 4 Sep 2023 21:59:43 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     lizhe <sensor1010@163.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/tcic.c : remove the "&" of the second parameter
Message-ID: <ZPY3LzXER_P1uRxR@light.dominikbrodowski.net>
References: <20221221063749.82666-1-sensor1010@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221063749.82666-1-sensor1010@163.com>
X-TUID: byX+ZeQzSWX1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, Dec 20, 2022 at 10:37:49PM -0800 schrieb lizhe:
> 	The second parameter is the entry address of the function,
> 	Not required&
> 
> Signed-off-by: lizhe <sensor1010@163.com>
> ---
>  drivers/pcmcia/tcic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pcmcia/tcic.c b/drivers/pcmcia/tcic.c
> index 1a0e3f098759..5ef888688e23 100644
> --- a/drivers/pcmcia/tcic.c
> +++ b/drivers/pcmcia/tcic.c
> @@ -435,7 +435,7 @@ static int __init init_tcic(void)
>      }
>      
>      /* Set up polling */
> -    timer_setup(&poll_timer, &tcic_timer, 0);
> +    timer_setup(&poll_timer, tcic_timer, 0);
>  
>      /* Build interrupt mask */
>      printk(KERN_CONT ", %d sockets\n", sockets);
> -- 
> 2.17.1
> 

Applied to pcmcia-next, thanks!

	Dominik
