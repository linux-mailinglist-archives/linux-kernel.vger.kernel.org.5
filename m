Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADB57F5E9A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345190AbjKWMBK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Nov 2023 07:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345171AbjKWMBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:01:08 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF0E98
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 04:01:14 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1r68OG-00021x-57; Thu, 23 Nov 2023 13:01:04 +0100
Message-ID: <b50d2635dfa3c69d241910930737c17fd57df66e.camel@pengutronix.de>
Subject: Re: [PATCH] EDAC: armada_xp: Explicitly include correct DT includes
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Reply-To: jlu@pengutronix.de
To:     Rob Herring <robh@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, kernel@pengutronix.de
Date:   Thu, 23 Nov 2023 13:01:02 +0100
In-Reply-To: <20231013190342.246973-1-robh@kernel.org>
References: <20231013190342.246973-1-robh@kernel.org>
Organization: Pengutronix
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-13 at 14:03 -0500, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it was merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Jan Luebbe <jlu@pengutronix.de>

Sorry for the delay,
Jan

> ---
>  drivers/edac/armada_xp_edac.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
> index c4bd2fb9c46b..f18db536d58e 100644
> --- a/drivers/edac/armada_xp_edac.c
> +++ b/drivers/edac/armada_xp_edac.c
> @@ -5,7 +5,9 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/edac.h>
> -#include <linux/of_platform.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
>  
>  #include <asm/hardware/cache-l2x0.h>
>  #include <asm/hardware/cache-aurora-l2.h>

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
