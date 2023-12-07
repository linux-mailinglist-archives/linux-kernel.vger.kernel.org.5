Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317E9808131
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377843AbjLGGvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjLGGvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:51:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440531994
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 22:50:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544E9C433C9;
        Thu,  7 Dec 2023 06:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701931848;
        bh=rTrj+609LSXiUpACDhoj4mKW1YyIQfyh+kNZrOdvGXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FyFgUT00KRW2fhfDQ3yiYl2xNNwFdJETCHpiIa+Bs/eHqvAzXvqLYg3BWAXt6iiPS
         mJY60DT6d8IpPIkhSAOiAeZ/a50cocZ4feFq6CZAzFBTLsxsvLAWXQ26deRnEJhjNB
         CcKB62Njz310fFyTo8dTwFN88vjdOlxOjM5HGNh4=
Date:   Thu, 7 Dec 2023 10:37:38 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v5 2/9] tty: serial: amba: Use linux/{bits,bitfield}.h
 macros
Message-ID: <2023120742-argue-slighting-6120@gregkh>
References: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com>
 <20231130-mbly-uart-v5-2-6566703a04b5@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231130-mbly-uart-v5-2-6566703a04b5@bootlin.com>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 03:07:14PM +0100, Théo Lebrun wrote:
> The driver uses bit shifts and hexadecimal expressions to declare
> constants. Replace that with the BIT(), GENMASK() & FIELD_PREP_CONST()
> macros to clarify intent.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  include/linux/amba/serial.h | 248 +++++++++++++++++++++++---------------------
>  1 file changed, 127 insertions(+), 121 deletions(-)

As 0-day had a problem with this patch, I've applied only patch 1 of
this series.  Can you fix it up and rebase and resend the rest again
(while adding the collected reviewed-by that some patches in this series
had)?

thanks,

greg k-h
