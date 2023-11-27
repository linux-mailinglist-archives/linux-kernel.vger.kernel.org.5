Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53A37FA18B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjK0Nyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjK0NyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:54:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BED01B6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:54:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7F7C433BA;
        Mon, 27 Nov 2023 13:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701093255;
        bh=K6oYquv/QpWiofrzNCT7om1oXAaFGsfKZSXmrfqobk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OUO40r4jIQ3TQfYialoyVxyxOnAh9dBMd2mIbXNXdd8rURdQspASm+bnN6FYjMggQ
         iJ37DgyK6f5O6SJDIpwc/7MejPFo5lHO3hEuTLG+MEchfPNO6+d/TE45H2CtHiwUpj
         wwTOaZiMQFUkBHHrJ/mskbLhcpPJ9C9VRlyZH10s=
Date:   Mon, 27 Nov 2023 13:31:14 +0000
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>
Subject: Re: [Intel-gfx] [char-misc-next 3/4] mei: pxp: re-enable client on
 errors
Message-ID: <2023112703-skid-reconfirm-9f0a@gregkh>
References: <20231011110157.247552-1-tomas.winkler@intel.com>
 <20231011110157.247552-4-tomas.winkler@intel.com>
 <ZVN9e3BczixJy_1H@intel.com>
 <ade96d9edd8bce1bc63dba4e2f1a92517180d774.camel@intel.com>
 <MN2PR11MB4093E7F5490A51DED7672145E5B2A@MN2PR11MB4093.namprd11.prod.outlook.com>
 <ZVUrhGsqJ9jKNM5x@intel.com>
 <ZWSYFc-ltqthibb9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWSYFc-ltqthibb9@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 03:22:29PM +0200, Ville Syrjälä wrote:
> On Wed, Nov 15, 2023 at 10:35:16PM +0200, Ville Syrjälä wrote:
> > On Tue, Nov 14, 2023 at 06:40:26PM +0000, Winkler, Tomas wrote:
> > > 
> > > 
> > > > -----Original Message-----
> > > > From: Teres Alexis, Alan Previn <alan.previn.teres.alexis@intel.com>
> > > > Sent: Tuesday, November 14, 2023 5:32 PM
> > > > To: ville.syrjala@linux.intel.com; Winkler, Tomas <tomas.winkler@intel.com>
> > > > Cc: gregkh@linuxfoundation.org; Usyskin, Alexander
> > > > <alexander.usyskin@intel.com>; linux-kernel@vger.kernel.org; intel-
> > > > gfx@lists.freedesktop.org; Lubart, Vitaly <vitaly.lubart@intel.com>
> > > > Subject: Re: [char-misc-next 3/4] mei: pxp: re-enable client on errors
> > > > 
> > > > On Tue, 2023-11-14 at 16:00 +0200, Ville Syrjälä wrote:
> > > > > On Wed, Oct 11, 2023 at 02:01:56PM +0300, Tomas Winkler wrote:
> > > > > > From: Alexander Usyskin <alexander.usyskin@intel.com>
> > > > > >
> > > > > > Disable and enable mei-pxp client on errors to clean the internal state.
> > > > >
> > > > > This broke i915 on my Alderlake-P laptop.
> > > 
> > > This fix was already posted, just missed the merging window
> > > https://lkml.org/lkml/2023/10/31/636
> > 
> > Gave this a spin and it fixes the issue for me. Thanks.
> > 
> > > 
> > > Greg can you please take this fix into v6.7-rc2 run, or I can repost it with the correct subject.
> 
> We're at -rc3 already and this fix is still not in!

Ah, good point, I'll take it now, sorry, catching up on things...
