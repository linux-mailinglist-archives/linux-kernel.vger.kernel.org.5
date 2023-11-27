Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31FD7FA15B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjK0Nub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjK0Nu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:50:29 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945CFC3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:50:35 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id B87DF604AC;
        Mon, 27 Nov 2023 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701093034;
        bh=FE9cvV3PjTeKPLT9+4+I0lHD4+oUEtNr//lG4eUzrzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sOg33PuRFPb4dK1Qfkk80dZYbIvLfUVgUl30rBvhJk1LlEBQdjRwQsxNZvh2GPwZq
         oU7Q0aIXs7RJI77othtwSKD5RLzgI6hLlQcud7CNbexg4It2oHqJlQx/zu4Fzq3BjU
         FAl63pOdUEp2gLwOlFLuC6NIhoHq1rtllfPqTNmlsmR9iLV5vG5LuxSjkXpQ3JmDph
         jFgQ6dkPvzH3Up1j8EPOOSW1FI7Xqiu0WUi0fLDkIkbbcRd1QU6VXD4Z56EGnZ4szs
         InYkmJxbYJudmoCC23NUjac0819zpQiozHoWy2LtweHQucfhzbuw8KBG5PSKJyFbwA
         zhpmZAGW/+pSw==
Date:   Mon, 27 Nov 2023 15:50:08 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com, johan@kernel.org,
        arnd@arndb.de, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, tomi.valkeinen@ideasonboard.com,
        =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>,
        robh@kernel.org
Subject: Re: [RFC PATCH 3/3] drivers: misc: ti-st: begin to deorbit
Message-ID: <20231127135008.GN5169@atomide.com>
References: <20231126191840.110564-1-andreas@kemnade.info>
 <20231126191840.110564-4-andreas@kemnade.info>
 <2023112729-qualify-relearn-6a72@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112729-qualify-relearn-6a72@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH <gregkh@linuxfoundation.org> [231127 08:25]:
> On Sun, Nov 26, 2023 at 08:18:40PM +0100, Andreas Kemnade wrote:
> > The TI-ST driver seems not to be used anymore. For bluetooth needs
> > there is hci_ll.c which has device tree support and can work without
> > this one. Also firmware download support is there, so it is also not needed
> > here. GPS can also reuse parts of the framework in hci_ll
> > 
> > Contrary from this driver, device tree support has been removed.
> > 
> > So start deorbiting it by marking it as broken.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  drivers/misc/ti-st/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/misc/ti-st/Kconfig b/drivers/misc/ti-st/Kconfig
> > index 1503a6496f632..6bf9cc845745c 100644
> > --- a/drivers/misc/ti-st/Kconfig
> > +++ b/drivers/misc/ti-st/Kconfig
> > @@ -7,7 +7,7 @@ menu "Texas Instruments shared transport line discipline"
> >  config TI_ST
> >  	tristate "Shared transport core driver"
> >  	depends on NET && TTY
> > -	depends on GPIOLIB || COMPILE_TEST
> > +	depends on GPIOLIB || COMPILE_TEST || BROKEN
> 
> Why not just delete it?  Why have it stick around any longer?

Sounds good to me too.

Regards,

Tony
