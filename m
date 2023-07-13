Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328DB751863
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjGMF51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbjGMF50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:57:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248E32101
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F4C461A1B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88018C433C8;
        Thu, 13 Jul 2023 05:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689227843;
        bh=q9r7XL80n84mZRG4PdZ0AdqE+56ebbBdWajAjngC5A8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WpwksOFfZ76NAFPXnmei8z70xdfDaIKdLVMBAYNN22wjjZlXvvBLo6lAjEWQUZv5A
         BHToA1aR6mUvDYof73pZQZ6tpDmb1As2JaOn+UZ1OrrFCIzki+1BreX8lH1aHehHjk
         drTpwemmCubIBahWBdVTgKtwCVwqHk4hg+7hAP2s=
Date:   Thu, 13 Jul 2023 07:57:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Gupta, Puneet (DCG-ENG)" <puneet.gupta@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>
Subject: Re: [PATCH 3/4] cdx: create sysfs resource files
Message-ID: <2023071303-encore-emporium-b847@gregkh>
References: <20230711121027.936487-1-abhijit.gangurde@amd.com>
 <20230711121027.936487-4-abhijit.gangurde@amd.com>
 <2023071148-grievance-gulf-0841@gregkh>
 <DM4PR12MB776565FAF9F3797643C9AFA78F36A@DM4PR12MB7765.namprd12.prod.outlook.com>
 <2023071231-drinking-unskilled-3c00@gregkh>
 <DM4PR12MB7765AEF30AA787C246852C0C8F37A@DM4PR12MB7765.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB7765AEF30AA787C246852C0C8F37A@DM4PR12MB7765.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 05:36:25AM +0000, Gangurde, Abhijit wrote:
> [AMD Official Use Only - General]
> 
> > > > > Resource files provides the basic MMIO regions info to the
> > > > > user-space. Also, resources<x> devices can be used to mmap the
> > > > > MMIO regions in the user-space.
> > > > >
> > > > > Co-developed-by: Puneet Gupta <puneet.gupta@amd.com>
> > > > > Signed-off-by: Puneet Gupta <puneet.gupta@amd.com>
> > > > > Co-developed-by: Nipun Gupta <nipun.gupta@amd.com>
> > > > > Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> > > > > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > > > > Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-
> > > > vuuren@amd.com>
> > > > > Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> > > > > ---
> > > > >  Documentation/ABI/testing/sysfs-bus-cdx |  15 +++
> > > > >  drivers/cdx/cdx.c                       | 139 +++++++++++++++++++++++-
> > > > >  include/linux/cdx/cdx_bus.h             |  10 ++
> > > > >  3 files changed, 163 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/Documentation/ABI/testing/sysfs-bus-cdx
> > > > b/Documentation/ABI/testing/sysfs-bus-cdx
> > > > > index d9e00058471d..6ca47b6442ce 100644
> > > > > --- a/Documentation/ABI/testing/sysfs-bus-cdx
> > > > > +++ b/Documentation/ABI/testing/sysfs-bus-cdx
> > > > > @@ -76,3 +76,18 @@ Description:
> > > > >             For example::
> > > > >
> > > > >               # echo 1 > /sys/bus/cdx/devices/.../remove
> > > > > +
> > > > > +What:              /sys/bus/cdx/devices/.../resource
> > > > > +Date:              July 2023
> > > > > +Contact:   puneet.gupta@amd.com
> > > > > +Description:
> > > > > +           The resource file contains host addresses of CDX device
> > > > > +           resources. Each line of the resource file describes a region
> > > > > +           with start, end, and flag fields.
> > > >
> > > > If you documented what this file looked like here, it would be obvious
> > > > that this is not an acceptable sysfs file in any sense of the word.
> > > >
> > > > Please do so, and then fix the patch to not do that at all.
> > >
> > > Similar interface exist for pci and we intended to keep it same way. Could you
> > please elaborate on this.
> > >
> > > # cat /sys/bus/pci/devices/0000\:01\:00.0/resource
> > > 0x0000000092100000 0x00000000921fffff 0x000000000014220c
> > > 0x0000000000000000 0x0000000000000000 0x0000000000000000
> >
> > Please don't propagate incorrect decisions in the past.
> >
> > Why do you need all of these "resources" in userspace?  What tool is
> > going to read and parse them and do something with them?
> >
> > This really violates the "one value per file" sysfs rule, you are going
> > to have to have a huge reason why this is not applicable here, AND you
> > are going to have to document it very very well and get everyone to
> > agree with it.
> 
> We don't have any strong reason apart from that this is being used by some
> test and debug applications. Will drop this one now and revisit later by
> complying to the specifications.

If it's only for debug stuff, then use debugfs, that's what it is there
for.

thanks,

greg k-h
