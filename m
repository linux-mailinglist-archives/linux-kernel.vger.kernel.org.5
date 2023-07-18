Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695AC75824A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjGRQkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjGRQkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:40:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03750173A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:40:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C28B61689
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 16:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462E5C433C7;
        Tue, 18 Jul 2023 16:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689698406;
        bh=zJAHBL0kr+xwS0Z4Zf2nP/H5EVn5MoYr1bw/XeI+P8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A6AAfLrj61c1f1fsgHzwS3WcoL9Cqxq2jdaPpzeMw0VEg9cA1m3Y5QVg5v834uekO
         YWt3+B59N7mRWSIAY7qe6LvBdnE3IUXoyHojEPqrGzR+PJG5nYFtQqVbTt4o7pQga4
         NR/oQb9Qje78d7b5Pm4zwnOm+QWT5gK4x2suPzvk=
Date:   Tue, 18 Jul 2023 18:40:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     pangzizhen001@208suo.com
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/tty: Fix typos in comments
Message-ID: <2023071815-battle-surrender-60e7@gregkh>
References: <20230718162025.64358-1-wangjianli@cdjrlc.com>
 <ffa4ee5ba65722fe52481638ab20e068@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffa4ee5ba65722fe52481638ab20e068@208suo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 12:22:25AM +0800, pangzizhen001@208suo.com wrote:
> Delete duplicate word "the"
> 
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  drivers/tty/n_gsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index b411a26cc092..e8cd1e07eafe 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -1148,7 +1148,7 @@ static void __gsm_data_queue(struct gsm_dlci *dlci,
> struct gsm_msg *msg)
>   *
>   *    Add data to the transmit queue and try and get stuff moving
>   *    out of the mux tty if not already doing so. Take the
> - *    the gsm tx lock and dlci lock.
> + *    gsm tx lock and dlci lock.
>   */
> 
>  static void gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)

Please learn how to get involved in kernel development by working in
drivers/staging/* first, as the developers there are used to simple
errors like what you did here, and will work to help you out.

Otherwise, patches like this are just going to cause developers to get
grumpy when you have obvious errors.

good luck!

greg k-h
