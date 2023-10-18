Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4397CEB04
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjJRWNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjJRWNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:13:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D276B6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697667212; x=1729203212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J9MSXc9livi9wY04KjUidMwQUars9CGlH7kYAxX/wVI=;
  b=ZuVr/Lv4fOg5ZkNeoSqHUf1zujScH0fVI6s1crQiIRriYzCcHwojnJWZ
   HSaNmbcXtaT6q9MQdzSN7LLr5rXH8We8xmfEe4fVMcFzIFJHwCX1cSsiu
   dqvjZDSttguz4w8iqoGTI6O+4WbYAnJLYiGiWh6OFh+zCUOFZkcjWs0ug
   CnGhEBAWk/AS49taTV16MCMcMdSRnkE7rhUgx51lHYUezA6qTAxvQoVIK
   exhW5mcLKazjyUEKxCZJUbcOl0y2lB+8MtwewE3ZBEDFz6TRnfeZGFHUs
   5ZZazFWjrQqR9V2nukdkR2FvwK8gJimlQdFaWnjXnXJdEy+Zx393R0Qz3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="376497664"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="376497664"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 15:13:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="4713319"
Received: from nurfahan-mobl3.gar.corp.intel.com (HELO intel.com) ([10.213.159.217])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 15:13:29 -0700
Date:   Thu, 19 Oct 2023 00:13:17 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/2] staging: vme_user: Use __func__ instead of function
 name
Message-ID: <ZTBYfbQy9SoUHyAI@ashyti-mobl2.lan>
References: <cover.1697601942.git.soumya.negi97@gmail.com>
 <c553e5901f16b78681e74b2d77796f8fc102b602.1697601942.git.soumya.negi97@gmail.com>
 <ZS+6sTNNZ5KUzpd4@ashyti-mobl2.lan>
 <20231018203020.GB32553@Negi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018203020.GB32553@Negi>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Soumya,

> > On Tue, Oct 17, 2023 at 09:36:33PM -0700, Soumya Negi wrote:
> > > Replace function names in message strings with __func__ to fix
> > > all checkpatch warnings like:
> > > 
> > >     WARNING: Prefer using '"%s...", __func__' to using 'vme_lm_get',
> > >              this function's name, in a string
> > > 
> > > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > > ---
> > >  drivers/staging/vme_user/vme.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> > > index e8c2c1e77b7d..11c1df12b657 100644
> > > --- a/drivers/staging/vme_user/vme.c
> > > +++ b/drivers/staging/vme_user/vme.c
> > > @@ -422,7 +422,7 @@ int vme_slave_get(struct vme_resource *resource, int *enabled,
> > >  	image = list_entry(resource->entry, struct vme_slave_resource, list);
> > >  
> > >  	if (!bridge->slave_get) {
> > > -		dev_err(bridge->parent, "vme_slave_get not supported\n");
> > > +		dev_err(bridge->parent, "%s not supported\n", __func__);
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > @@ -572,7 +572,7 @@ int vme_master_set(struct vme_resource *resource, int enabled,
> > >  	image = list_entry(resource->entry, struct vme_master_resource, list);
> > >  
> > >  	if (!bridge->master_set) {
> > > -		dev_warn(bridge->parent, "vme_master_set not supported\n");
> > > +		dev_warn(bridge->parent, "%s not supported\n", __func__);
> > 
> > I wouldn't disagree if you made this dev_err() instead of
> > dev_warn(). The reasoning behind is that if it's a warning you
> > should not fail. But beacuse you are returning -EINVAL it means
> > that you are failing, therefore you should use dev_err().
> > 
> > Others might object that the change I'm suggesting sohuld go in a
> > different patch, which is also OK.
> > 
> > >  		return -EINVAL;
> > 
> > ... or, if you want to keep the dev_warn(), whou can consider
> > removing the "return -EINVAL;". But this is an evaluation you
> > should make in a different patch and mainly evaluate if it's
> > OK to remove the error here.
> 
> I think it should be dev_err() too. The driver has inconsistently used
> warn and err log levels in similar functions as well. But I was planning
> to tackle those in a standalone patch after the printk's are gone. Or do
> you think it should be part of this patchset?

OK... if you already noticed this and you are saying there are
more cases, then it's better if you send a different patch.

> > >  	if (!bridge->slot_get) {
> > > -		dev_warn(bridge->parent, "vme_slot_num not supported\n");
> > > +		dev_warn(bridge->parent, "%s not supported\n", __func__);
> > >  		return -EINVAL;
> > >  	}
> > 
> > Nothing wrong with the patch itself. But imagine if we end up in
> > one of those printouts and, as a user, you read something like:
> > 
> >    ... vme_slot_num not supported
> > 
> > The message itself doesn't say much to the user. The perfect fix
> > would be to re-write all these error messages with a proper
> > meaningful sentence, like, e.g.:
> > 
> >    Can't retrieve the CS/CSR slot id
> >
> > (don't even know if it's fully correct). Anyway, I understand
> > you don't have much time for such fine changes, so whatever you
> > decide to do:
> 
> Got it. Thanks for the patch suggestion. Although yes, since I still have project
> starter tasks pending for my outreachy application(will have to prioritize                           
> them) I'm not sure if I will be able to get this done right away. Will try to
> though.

yeah... nevermind.

> > Acked-by: Andi Shyti <andi.shyti@linux.intel.com> 
> > 
> > Andi
> 
> Thanks for the ack. Since I'll have to revise and resend this patch as v2, 
> should I not add your ack tag as the patch will be reviewed again? Just 
> wondering what the etiquette is.

You can keep my tag, unless you are making drastic changes.

Nevertheless, the patch might be reviewed again.

> Though normally are patches supposed to be resent as new versions when adding
> ack tags?

If someones acks or reviews the patches you don't need to resend
just for adding the tags. There are tools doing it and
maintainers take care of that.

But, on the other hand, if you are going to resend anyway, for
other reasons a new version, then you should add the tags
yourself, otherwise they might be lost.

If the new version changes considerably, then you might consider
not adding any tags.

Andi
