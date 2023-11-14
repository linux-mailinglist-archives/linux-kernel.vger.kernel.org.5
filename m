Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112707EB6C0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjKNTHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjKNTHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:07:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FF8FB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 11:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699988869; x=1731524869;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=3MLx/VKCp7Z6CZe1ZWabnlu0cIKVThj0kbq/QnvpMS8=;
  b=SgG1ydkAANE6XfJjI4lSzfHtKLpIbN7yIVAu60LHuo2EZftA98yVaD3o
   gUE3GwIKAELU5ro2vytNmeDk2H7mjMTgG1iVOTbkBQ5EsnzxdLxnMa9GK
   SIDy/VDPErwamgF5/r16ILn77OiyrVeeFf5wJsJEZRQvyljfmBmNwl9dd
   4KhWhZni5ecMOu3YfHRuWMlky4dsnPX8Mti2Hu6T822uHLNsrMoTyEIpI
   4le35CoEnE/ZytxOvfKMsMN80i/sz2VVYdSHI02aHBUCEdyiYDYAksLc1
   UKQrY3GEwkFH6VacdYOHQwI/rGjR0lymK8ZwVTTQkMwGxFRbhWaz0ZGtg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="381125221"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="381125221"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 11:07:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="12528598"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 11:07:46 -0800
Date:   Tue, 14 Nov 2023 21:07:45 +0200
From:   Imre Deak <imre.deak@intel.com>
To:     David Laight <David.Laight@aculab.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Build fail in drivers/gpu/drm/i915/display/intel_tc.c
Message-ID: <ZVPFUdc6Q/qCI8M7@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <4df68c74c4da46ac943ac21578e9b084@AcuMS.aculab.com>
 <ZU1shQH64ryxp/l5@ideak-desk.fi.intel.com>
 <CAHk-=wgiPxF6GnvaSGV+xOjcBO-T1vxLYhSvho0Q5Cdqw7t74w@mail.gmail.com>
 <39709b4bb3e447159759a9923bd4a564@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39709b4bb3e447159759a9923bd4a564@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 09:00:21AM +0000, David Laight wrote:
> From: Linus Torvalds
> > Sent: 10 November 2023 00:52
> > 
> > On Thu, 9 Nov 2023 at 15:34, Imre Deak <imre.deak@intel.com> wrote:
> > >
> > > The compiler warn should be fixed/suppressed by:
> > > https://lore.kernel.org/all/20231026125636.5080-1-nirmoy.das@intel.com
> > 
> > Ugh, so now it's a dynamic allocation, wasting memory, and a pointer
> > to it, using as much memory as the array did in the first place.
> > 
> > All because of a pointless warning that was a false positive - and was
> > always harmless anyway, since snprintf() is safe (ie it was only a
> > "might be truncated").
> 
> That entire warning for snprintf() is a false positive.
> The ones that are likely to overflow unexpectedly are the ones
> with a "%s" format for a 'char *' pointer where there is no
> implied length.
> 
> The same check for printf() using the implied buffer length
> probably does make sense.
> 
> I don't even think there is a way of avoiding it on a case by case
> basis - apart from passing both the buffer address and length
> to an inline asm that the compiler has to assume might change
> the values, but that tends to generate an extra 'mov' instruction
> for no good reason at all.
> 
> > 
> > Please don't do this. Either do that ((tc_port & 7) + 1) suggestion of
> > David's, or just do '%c' and make the expression be
> > 
> >   '1' + tc_port
> > 
> > which should be fine since I915_MAX_PORTS is 8 or whatever.

Ok, the patch above was merged already to drm-tip, but I agree not to
use kasprintf for this. The above looks ok and there is already
tc_port_name() for this, would just need to export that from
intel_display.h.

I can follow up with a patch for this, or if you or David wanted to do
that please send a patch to the intel-gfx@lists.freedesktop.org list.

Thanks,
Imre

> If I'd though for 2 seconds that is what I'd have done.
> But I wanted to get something through the compiler.
> 
> > I do wonder why those ports are printed out as '1-8', when the 'enum
> > port' is PORT_A..I.
> 
> They look like TC_PORT_[1..6] to me - the enum values are 0..5
> which is why there is a 'random' '+ 1'.
> 
> 	David
> 
> > 
> > So it would actually have made more sense to print them out as %c with
> > the expression being
> > 
> >    'A'+tc_port
> > 
> > but I guess by now people might depend on the 1..8 naming?
> > 
> >              Linus
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
