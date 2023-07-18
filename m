Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D237573A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjGRGJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGRGJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:09:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FF5B5;
        Mon, 17 Jul 2023 23:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689660558; x=1721196558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CNr6kFUkdj0yJc2gRaG6dLNr6I1GXlOtw7maA8EHH+M=;
  b=AfdpudeJVIrXpMeIhkwbGkHJdZ+2OMGN+emu5D59NMNhl11NAoS+usUb
   ELDgOMXNlG8UVQfhpuReneSXQDa8Ux9luY4G3xOWnTBjTtjXK/Y2gV7AD
   FGuHMVMqkb+RC3Dus1L9r6ImixGGViW8ocoFGisUspBSQQPC2r+bp1ctS
   MOIVfVNh2zag7mtgi2jWyCabRMoB5iG+72R67CFwa60mJfuztTUb2qKxy
   j5lflN+MOAlWVPNVtZeY2SV4b+zVrmGrsMD167m2k1A2wX332XpHjMuAZ
   jjs7nMlkljT1KvZNBdaN0epzGN5Rabh4AtRfpWWdeoVYirUrC/2/htl8N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="364995678"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="364995678"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 23:09:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="726821157"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="726821157"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 23:09:16 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id E681E11F89D;
        Tue, 18 Jul 2023 09:09:13 +0300 (EEST)
Date:   Tue, 18 Jul 2023 06:09:13 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the v4l-dvb-fixes tree
Message-ID: <ZLYsienU5SmqypZS@kekkonen.localdomain>
References: <20230714083645.4e587f71@canb.auug.org.au>
 <ZLTsXUFZy4Iggk5u@kekkonen.localdomain>
 <87jzuy34yj.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzuy34yj.fsf@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 06:58:28PM +0300, Kalle Valo wrote:
> Sakari Ailus <sakari.ailus@linux.intel.com> writes:
> 
> > On Fri, Jul 14, 2023 at 08:38:25AM +1000, Stephen Rothwell wrote:
> >> Hi all,
> >> 
> >> In commit
> >> 
> >>   b0b43354c345 ("media: tc358746: Address compiler warnings")
> >> 
> >> Fixes tag
> >> 
> >>   Fixes: 80a21da3605 ("media: tc358746: add Toshiba TC358746 Parallel to CSI-2 bridge driver")
> >> 
> >> has these problem(s):
> >> 
> >>   - SHA1 should be at least 12 digits long
> >>     This can be fixed for the future by setting core.abbrev to 12 (or
> >>     more) or (for git v2.11 or later) just making sure it is not set
> >>     (or set to "auto").
> >> 
> >> Also, please keep all the commit message tags together at the end of
> >> the commit message.
> >
> > Apologies for this, I guess I've removed one character too many from the
> > hash.
> >
> > I'll switch to a script (or alias) to do this. It'd be, though, helpful if
> > git could do this on its own.
> 
> Are you asking for git to create the Fixes tag? The documentation has
> has a tip using --pretty=fixes which is quite handy:
> 
> https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

Thanks! This is much nicer than a bash alias I created.

-- 
Sakari Ailus
