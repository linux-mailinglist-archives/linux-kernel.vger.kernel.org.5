Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42FF7D8F86
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345421AbjJ0HRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345425AbjJ0HQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:16:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3AA1985;
        Fri, 27 Oct 2023 00:16:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A3EC433C8;
        Fri, 27 Oct 2023 07:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698391004;
        bh=CBkxV/uFvpzCOvXq/7DVXjOGLxxi3GTw/t/A+HTWNJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0nGMnJTiNrrl2+rN9XPzMH2IcacHjDqVSv6UlJ/cULBbI+YiCV5QLG5YHCkoLKuZK
         eeItrfl/qeCk8SU0jS7rudj7Bw5yKwjE7UVm1sMMjxhAuaTUyeUJGdRosPS0Nhtjfx
         hoafJV4TNcsIqxE1mhrXswdKwYOML9x0OuA/Xw6c=
Date:   Fri, 27 Oct 2023 09:16:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     joel@jms.id.au, andrew@codeconstruct.com.au, robh@kernel.org,
        arnd@arndb.de, roblip@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] soc: aspeed: lpc: Fix impossible judgment condition
Message-ID: <2023102730-outmatch-rising-14f0@gregkh>
References: <20231027020703.1231875-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231027020703.1231875-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 10:07:04AM +0800, Su Hui wrote:
> smatch error：
> drivers/soc/aspeed/aspeed-lpc-snoop.c:169
> aspeed_lpc_snoop_config_irq() warn: platform_get_irq() does not return zero
> 
> platform_get_irq() return non-zero IRQ number or negative error code,
> change '!lpc_snoop->irq' to 'lpc_snoop->irq < 0' to fix this.
> 
> Fixes: 9f4f9ae81d0a ("drivers/misc: add Aspeed LPC snoop driver")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
