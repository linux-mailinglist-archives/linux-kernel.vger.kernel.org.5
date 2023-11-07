Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246707E41EC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjKGOgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjKGOgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:36:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD6A98
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:36:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB05C433C8;
        Tue,  7 Nov 2023 14:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699367762;
        bh=K3rekygBEwbjKu81yXel/MYn4q9jsZqaJD0PXd0KmRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0XgA6bHSuFP5ciVHfbpE0EVStAnHNQZTHVwV2aLr+pbP8XQS6R+bqycl+D0F3rwQH
         aLvKqL0DBp7+/ndbqkFybXn/fEGYjyupjx7owKOFkoSYrVmMYOCKIeOVkVoGBch8iv
         a9GoAyrG7Jk5g/YYuROH8HbvDv1GkILGgm40KTK0=
Date:   Tue, 7 Nov 2023 15:35:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc:     "De Marchi, Lucas" <lucas.demarchi@intel.com>,
        "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] mei: pxp: add dependency on Xe driver
Message-ID: <2023110718-obscure-carrot-3467@gregkh>
References: <20231107134606.316651-1-alexander.usyskin@intel.com>
 <20231107134606.316651-6-alexander.usyskin@intel.com>
 <2023110700-emptier-retrain-08fd@gregkh>
 <CY5PR11MB6366D1F5EB27DA07628B42DCEDA9A@CY5PR11MB6366.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB6366D1F5EB27DA07628B42DCEDA9A@CY5PR11MB6366.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 02:26:17PM +0000, Usyskin, Alexander wrote:
> > 
> > On Tue, Nov 07, 2023 at 03:46:06PM +0200, Alexander Usyskin wrote:
> > > Optionally depend on either i915 or Xe drivers.
> > >
> > > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > > ---
> > >  drivers/misc/mei/pxp/Kconfig | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/misc/mei/pxp/Kconfig b/drivers/misc/mei/pxp/Kconfig
> > > index 4029b96afc04..d9ae5483567f 100644
> > > --- a/drivers/misc/mei/pxp/Kconfig
> > > +++ b/drivers/misc/mei/pxp/Kconfig
> > > @@ -1,11 +1,10 @@
> > > -
> > 
> > Why this change here?
> 
> I've been told that SPDX should be the first line in the file,
> but here fist line is an empty line.

That is correct, and should be fixed up, but you didn't say that you
made this change in your changelog text so I didn't know why it was
there.

> I can drop this change if it is inappropriate to put it in this patch.

It should go in a separate patch please.

thanks,

greg k-h
