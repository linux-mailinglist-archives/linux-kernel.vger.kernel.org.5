Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E183478F2B2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345097AbjHaSde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjHaSdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:33:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1B7E65;
        Thu, 31 Aug 2023 11:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693506805; x=1725042805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=px3FvT2RH7DAb7h5X2rn9hNLxQJQvAASvN2jtIrqh9o=;
  b=AASgif7GedMH45eJW5YI5lYhSf+bVlvKGTOR1avgmDoWx6eQbu40itm8
   +PsirLsTy1GjYGcvDyMveHMOGhp1e5x1fab0ZQ0BioKFBG0Y3zH3RFzT5
   toYEIWW8IG0gYV0SHrx/n7/okGAe04UrH2djXDF1/k3JXZh6SgW6cfeyU
   uVnH0EvIGYxILj8nNzFME2e/7wqDi8Xrh4EOUYtiCHhiy9UwMRLPGzoLs
   vXP7HSin5KprmsW8+Z1KVZRR6xRS9evG3vyafCEF8ohSwrfsOGpfDfkin
   5SojNl/Jt0Dq1WMuEgjycO5H+qJ4VlXRCwf4yzGohlc0iIC/CJBv8gW/T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="375969039"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="375969039"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 11:33:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="863234151"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="863234151"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 11:33:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qbmTh-005Tcq-0j;
        Thu, 31 Aug 2023 21:33:13 +0300
Date:   Thu, 31 Aug 2023 21:33:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH 16/36] tty: use u8 for chars
Message-ID: <ZPDc6P2tp4lQzrKA@smile.fi.intel.com>
References: <20230810091510.13006-1-jirislaby@kernel.org>
 <20230810091510.13006-17-jirislaby@kernel.org>
 <27366cad-30b2-e326-8d8f-c6fe17cf4899@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27366cad-30b2-e326-8d8f-c6fe17cf4899@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 01:28:56PM +0300, Ilpo Järvinen wrote:
> On Thu, 10 Aug 2023, Jiri Slaby (SUSE) wrote:

...

> > @@ -22,9 +22,9 @@ struct tty_buffer {
> >  	unsigned long data[];
> >  };
> >  
> > -static inline unsigned char *char_buf_ptr(struct tty_buffer *b, int ofs)
> > +static inline u8 *char_buf_ptr(struct tty_buffer *b, int ofs)
> >  {
> > -	return ((unsigned char *)b->data) + ofs;
> > +	return ((u8 *)b->data) + ofs;
> >  }
> 
> Any particular reason why b->data is left unsigned long?

It might be the performance issue due to unaligned accesses on some
architectures. But I'm just speculating...

-- 
With Best Regards,
Andy Shevchenko


