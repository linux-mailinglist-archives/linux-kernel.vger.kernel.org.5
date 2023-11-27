Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FB67F9BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjK0Iiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjK0IZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:25:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDE6182
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:25:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B359BC433C7;
        Mon, 27 Nov 2023 08:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701073549;
        bh=32wd1LcJrhba6MmZdU1Ep6DLsF6PtYHOka5p4OoEN7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lQjqsSBDpVX8/Pudoyw1tQTn/zeDfj8cwIRL7M5zy5QQCKAlm7tGi0OFB8NbASVyg
         gzBapnMQxC4ymPkoEV2OQFbY7XheY0eQOYH+8f4mntH4YsAt54m8JXUDwPFEqeNB+1
         JbM7nfZ1wPJQlIZMsav9sWugi5ljcuR+SbrlSo/w=
Date:   Mon, 27 Nov 2023 08:25:46 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        johan@kernel.org, arnd@arndb.de, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, tomi.valkeinen@ideasonboard.com,
        Tony Lindgren <tony@atomide.com>,
        =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>,
        robh@kernel.org
Subject: Re: [RFC PATCH 3/3] drivers: misc: ti-st: begin to deorbit
Message-ID: <2023112729-qualify-relearn-6a72@gregkh>
References: <20231126191840.110564-1-andreas@kemnade.info>
 <20231126191840.110564-4-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126191840.110564-4-andreas@kemnade.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 08:18:40PM +0100, Andreas Kemnade wrote:
> The TI-ST driver seems not to be used anymore. For bluetooth needs
> there is hci_ll.c which has device tree support and can work without
> this one. Also firmware download support is there, so it is also not needed
> here. GPS can also reuse parts of the framework in hci_ll
> 
> Contrary from this driver, device tree support has been removed.
> 
> So start deorbiting it by marking it as broken.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/misc/ti-st/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/ti-st/Kconfig b/drivers/misc/ti-st/Kconfig
> index 1503a6496f632..6bf9cc845745c 100644
> --- a/drivers/misc/ti-st/Kconfig
> +++ b/drivers/misc/ti-st/Kconfig
> @@ -7,7 +7,7 @@ menu "Texas Instruments shared transport line discipline"
>  config TI_ST
>  	tristate "Shared transport core driver"
>  	depends on NET && TTY
> -	depends on GPIOLIB || COMPILE_TEST
> +	depends on GPIOLIB || COMPILE_TEST || BROKEN

Why not just delete it?  Why have it stick around any longer?

thanks,

greg k-h
