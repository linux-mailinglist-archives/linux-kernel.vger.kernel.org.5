Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E417818ED
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjHSKlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjHSKkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:40:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B61B344DC;
        Sat, 19 Aug 2023 02:53:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4F2361330;
        Sat, 19 Aug 2023 09:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC35EC433C8;
        Sat, 19 Aug 2023 09:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692438819;
        bh=L75NVUdfz2Xb+oyezfmaKKx4HihhfXajWI70UiC3jcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=clO5WlqP4tkmz+YtoVNBo1+0uIP+J72QLEB9WLZKMZ6Ir3Bxh6XazicYxlWFzzxwO
         dy68eyHmMmKsNrl9eH/cfam61rh9M3BsliBLX1RUOYhppjjmI5iMqMMFYWminZTDKf
         S4Blgv6XJI6JHNjmi2AYfN505v5FEfUPg18aNEkc=
Date:   Sat, 19 Aug 2023 11:53:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: core: Remove unused PORT_* definitions
Message-ID: <2023081954-situation-massive-269b@gregkh>
References: <20230818111229.764380-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818111229.764380-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 02:12:29PM +0300, Andy Shevchenko wrote:
> For the last couple of years Linux kernel got rid of a few architectures
> and many platforms. Hence some PORT_* definitions in the serial_core.h
> become unused and redundant. Remove them for good.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/uapi/linux/serial_core.h | 43 ++------------------------------
>  1 file changed, 2 insertions(+), 41 deletions(-)
> 
> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index 281fa286555c..c361570a334f 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -28,7 +28,7 @@
>   */
>  #define PORT_NS16550A	14
>  #define PORT_XSCALE	15
> -#define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
> +

I'm all for removing these defines, but are you sure they are not used
in any userspace code?  Ususally a debian code search is good enough
"proof" of this, did you do that?

thanks,

greg k-h
