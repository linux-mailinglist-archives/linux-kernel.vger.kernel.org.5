Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BA17BA272
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbjJEPhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjJEPh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:37:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0CC35C18;
        Thu,  5 Oct 2023 07:53:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1B3C433BF;
        Thu,  5 Oct 2023 07:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696491987;
        bh=1jTpDnM2GecCVC4qOmqZGahpZXui/D5O8mYTLXlY9MY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=baKb8dI33lKNmtfP0r/aNrrd2keZ5tsQ7Qh58HRXedsgre70GS3XfV3dwuabXHD1a
         5T5658L4OGPxPwdTsIz8B7UjmZSbtJnhgQ8BHkvj9+mLwfBuFL/lDx7sjDp47HkoPA
         FBP3c6DhXRJxKH41xHedx/xf32NU4T2UzOnR29lQ=
Date:   Thu, 5 Oct 2023 09:46:25 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9?= Javier 
        <josejavier.rodriguez@duagon.com>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?B?U2FuanXhbiBHYXJj7WEs?= Jorge 
        <Jorge.SanjuanGarcia@duagon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "morbidrsa@gmail.com" <morbidrsa@gmail.com>
Subject: Re: [PATCH v3 2/2] mcb: use short version for function pointer for
 mcb_free_bus
Message-ID: <2023100557-mournful-veto-64a2@gregkh>
References: <20230906114901.63174-1-JoseJavier.Rodriguez@duagon.com>
 <20230906114901.63174-3-JoseJavier.Rodriguez@duagon.com>
 <2023092000-overprice-guileless-e1a3@gregkh>
 <352fb63a17943b974f5bf6eebb4d861ae8307b24.camel@duagon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <352fb63a17943b974f5bf6eebb4d861ae8307b24.camel@duagon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 12:28:14PM +0000, Rodríguez Barbarin, José Javier wrote:
> On Wed, 2023-09-20 at 15:18 +0200, gregkh@linuxfoundation.org wrote:
> > On Wed, Sep 06, 2023 at 11:49:28AM +0000, Rodríguez Barbarin, José
> > Javier wrote:
> > > From: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
> > > 
> > > Just a style change so that the device release callbacks are
> > > defined
> > > in the same way for devices in mcb_bus and mcb_device.
> > > 
> > > Signed-off-by: Jorge Sanjuan Garcia
> > > <jorge.sanjuangarcia@duagon.com>
> > > Co-developed-by: Jose Javier Rodriguez Barbarin
> > > <JoseJavier.Rodriguez@duagon.com>
> > > Signed-off-by: Jose Javier Rodriguez Barbarin
> > > <JoseJavier.Rodriguez@duagon.com>
> > > ---
> > >  drivers/mcb/mcb-core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
> > > index 0cac5bead84f..5c6157b0db75 100644
> > > --- a/drivers/mcb/mcb-core.c
> > > +++ b/drivers/mcb/mcb-core.c
> > > @@ -288,7 +288,7 @@ struct mcb_bus *mcb_alloc_bus(struct device
> > > *carrier)
> > >         bus->dev.parent = carrier;
> > >         bus->dev.bus = &mcb_bus_type;
> > >         bus->dev.type = &mcb_carrier_device_type;
> > > -       bus->dev.release = &mcb_free_bus;
> > > +       bus->dev.release = mcb_free_bus;
> > 
> > But you aren't fixing the root cause here of an incorrect pointer
> > being
> > passed to this function, right?
> > 
> > Yes, removing the single variable is nicer, so the crash doesn't
> > happen,
> > but you are still passing the wrong pointer around, so why not fix
> > that?
> > 
> 
> > thanks,
> > 
> > greg k-h
> 
> The pointer to struct device in function __mcb_bus_add_devices() always
> was the correct one. The problem came when calling to function
> to_mcb_device() which was hapenning even for the case of struct device
> pointer being a member of struct mcb_bus.
> 
> Removing the need for this conversion makes the function generic so
> that it will work for both mcb_device and mcb_bus structs. This already
> fixes the crash as no member overlapping will occur (is_added in
> mcb_device struct and bus_nr in mcb_bus struct).
> 
> We belive the pointer is the correct one and this patch series was
> actually fixing the root cause of the crash. What do you mean by
> "passing the wrong pointer around"? are we missing something?

Ok, I understand now, yes, this looks correct.

But, the function mcb_bus_add_devices() seems odd to me.  You are
passing in a parameter that you are never using, so why have it at all?
You are implying that you only have one bus, yet you are ignoring the
bus sent to you?

This still seems wrong.

I'll queue up this series as it obviously fixes a bug, but more needs to
be done here.

thanks,

greg k-h
