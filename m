Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673C87FA18C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjK0Nyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbjK0NyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:54:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B680A10C1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:54:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1475FC433C9;
        Mon, 27 Nov 2023 13:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701093258;
        bh=ogCda4IEnDbNwVjhJVW41RiF6AQ3B1fNwlkaBmmQ3rU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FBcSYuPWTlZjyqzxwZXmZSuDeaMcwQtlYYSAQGq0iLf50ff8CbHDviDKIw2qbzL1d
         u0J8KcptauMCV9s8Hm3wK8XZxjq5zFe6F2JNLDba14mB8BrlFSGh9sYf2z1qmAw1wD
         K8ORd9fh5q5COdIT3wKLBA8O2aI/OmtqGPcenvlE=
Date:   Mon, 27 Nov 2023 13:32:47 +0000
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
Message-ID: <2023112729-quench-device-397c@gregkh>
References: <20231107134606.316651-1-alexander.usyskin@intel.com>
 <20231107134606.316651-6-alexander.usyskin@intel.com>
 <2023110700-emptier-retrain-08fd@gregkh>
 <CY5PR11MB6366D1F5EB27DA07628B42DCEDA9A@CY5PR11MB6366.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB6366D1F5EB27DA07628B42DCEDA9A@CY5PR11MB6366.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
> I can drop this change if it is inappropriate to put it in this patch.

It should not go into this patch.  Remember, each patch should only do
"one thing".

thanks,

greg k-h
