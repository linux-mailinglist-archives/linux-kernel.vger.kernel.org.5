Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BEC7ED27A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344466AbjKOUkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344569AbjKOUjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:39:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7661BC5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700080747; x=1731616747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oyRW0yJOnAQMk+aLzL3aM5R69kLnq/p9mbXN8ypSMoY=;
  b=OWAIERkDMYDIpoXoax3JGenPKsGL1LWqbozYBtyznZwyUWS6LlzdaXxY
   5j8cSMcnTJO4i/GOeOeDwWCL9zqxQXAG92lgRPxlxE3hUZWplPp4GwQ6u
   3J3DOs79ClHcj+dm5flYSssfUCpHO9aWP/0/WLvga+WAnk2qmuNmfot3w
   ARF4K4tGlMk+N6maF7ptnGVKcjRwLq99bhBI2rgAyKbOvKp8PIDvBl1u3
   e/Acc9fGyj7RrL+qj1dRxhAeBvg4glceu3KYBGUuLvgweyHjEcD8Oj5rj
   PnICl/Ty5Ytzu6MS/zADtL3+DuE31e1ecYtpRdbYKMigyX0Wcq5tEu5dB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="12504643"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="12504643"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 12:35:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="758604661"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="758604661"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga007.jf.intel.com with SMTP; 15 Nov 2023 12:35:17 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 15 Nov 2023 22:35:16 +0200
Date:   Wed, 15 Nov 2023 22:35:16 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>
Subject: Re: [char-misc-next 3/4] mei: pxp: re-enable client on errors
Message-ID: <ZVUrhGsqJ9jKNM5x@intel.com>
References: <20231011110157.247552-1-tomas.winkler@intel.com>
 <20231011110157.247552-4-tomas.winkler@intel.com>
 <ZVN9e3BczixJy_1H@intel.com>
 <ade96d9edd8bce1bc63dba4e2f1a92517180d774.camel@intel.com>
 <MN2PR11MB4093E7F5490A51DED7672145E5B2A@MN2PR11MB4093.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR11MB4093E7F5490A51DED7672145E5B2A@MN2PR11MB4093.namprd11.prod.outlook.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 06:40:26PM +0000, Winkler, Tomas wrote:
> 
> 
> > -----Original Message-----
> > From: Teres Alexis, Alan Previn <alan.previn.teres.alexis@intel.com>
> > Sent: Tuesday, November 14, 2023 5:32 PM
> > To: ville.syrjala@linux.intel.com; Winkler, Tomas <tomas.winkler@intel.com>
> > Cc: gregkh@linuxfoundation.org; Usyskin, Alexander
> > <alexander.usyskin@intel.com>; linux-kernel@vger.kernel.org; intel-
> > gfx@lists.freedesktop.org; Lubart, Vitaly <vitaly.lubart@intel.com>
> > Subject: Re: [char-misc-next 3/4] mei: pxp: re-enable client on errors
> > 
> > On Tue, 2023-11-14 at 16:00 +0200, Ville Syrjälä wrote:
> > > On Wed, Oct 11, 2023 at 02:01:56PM +0300, Tomas Winkler wrote:
> > > > From: Alexander Usyskin <alexander.usyskin@intel.com>
> > > >
> > > > Disable and enable mei-pxp client on errors to clean the internal state.
> > >
> > > This broke i915 on my Alderlake-P laptop.
> 
> This fix was already posted, just missed the merging window
> https://lkml.org/lkml/2023/10/31/636

Gave this a spin and it fixes the issue for me. Thanks.

> 
> Greg can you please take this fix into v6.7-rc2 run, or I can repost it with the correct subject.
> Thanks
> Tomas
> 
> 
> > >
> > 
> > 
> > Hi Alex, i just relooked at the series that got merged, and i noticed that in patch
> > #3 of the series, you had changed mei_pxp_send_message to return bytes sent
> > instead of zero on success. IIRC, we had agreed to not effect the behavior of
> > this component interface (other than adding the timeout) - this was the
> > intention of Patch #4 that i was pushing for in order to spec the interface
> > (which continues to say zero on success). We should fix this to stay with the
> > original behavior - where mei-pxp should NOT send partial packets and will
> > only return zero in success case where success is sending of the complete
> > packets - so we don't need to get back the "bytes sent"
> > from mei_pxp_send_message. So i think this might be causing the problem.
> > 
> > 
> > Side note  to Ville:, are you enabling PXP kernel config by default in all MESA
> > contexts? I recall that MESA folks were running some CI testing with enable
> > pxp contexts, but didn't realize this is being enabled by default in all contexts.
> > Please be aware that enabling pxp-contexts would temporarily disabled
> > runtime-pm during that contexts lifetime.
> > Also pxp contexts will be forced to be irrecoverable if it ever hangs.
> > The former is a hardware architecture requirement but doesn't do anything if
> > you're enabling display (which I beleive also blocks in ADL). The latter was a
> > requirement to comply with Vulkan.
> > 
> > ...alan
> > 
> 

-- 
Ville Syrjälä
Intel
