Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A07B800E5D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379395AbjLAPQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379462AbjLAPPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:15:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB08210B;
        Fri,  1 Dec 2023 07:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701443734; x=1732979734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tWb4VPgidAHQe+HcKW5PIOVqtBQKyGJANuwYhvqD8Tg=;
  b=hTWeYIcfgQvg6qtkekJH9JliRMUQnArnl6S3mbz740ret+gNVbFiYSuf
   iOHzDqLpwI5sHLXclOM4DtFajbE0MbisJ/Mt71KWYvAIiqAbCAlmVo2ns
   6FEWghez2meqroook1uqlbv7Nb/IPEGU/capsNtMiNi95Co2Q74X8+b+U
   XvFHGIoSF9E34FRCmFDjq9Ser/oGtjyRG57ci/HThrmMy3UO2iEgWuEgm
   PS3AQOx2iVeWfkxJuJO6mAgRRwpe6+/kL6fvm+fejPmU1fo16Kk6mGK15
   guzgjKYbwWo9Bf0cNzPXg9F9R19kNUjslzZNgIiHhmYZ3AxrIaCypFx+M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="362393"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="362393"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 07:15:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="763176400"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="763176400"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga007.jf.intel.com with SMTP; 01 Dec 2023 07:15:26 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 01 Dec 2023 17:15:25 +0200
Date:   Fri, 1 Dec 2023 17:15:25 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>,
        Sandy Huang <hjc@rock-chips.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-doc@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 05/45] drm/connector: Check drm_connector_init
 pointers arguments
Message-ID: <ZWn4jUsVgjubVPvB@intel.com>
References: <20231128-kms-hdmi-connector-state-v4-0-c7602158306e@kernel.org>
 <20231128-kms-hdmi-connector-state-v4-5-c7602158306e@kernel.org>
 <87h6l66nth.fsf@intel.com>
 <v3hplco5fdedv6bnc6mwx2zhhw4xxdiekha26ykhc5cmy7ol77@2irk3w4hmabw>
 <ZWXv1Oi_sH0BRWao@intel.com>
 <2mnodqvu2oo674vspiy4gxhglu3it5cq47acx5itnbwevgc4cf@c7h2bvnx3m2n>
 <ZWcB4Ak8QnwkhObR@intel.com>
 <2lbs5dkpusow72koxknoautcfb6e2ygq5wledim4i572ya5xlc@stc4koneykhm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2lbs5dkpusow72koxknoautcfb6e2ygq5wledim4i572ya5xlc@stc4koneykhm>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 10:01:49AM +0100, Maxime Ripard wrote:
> On Wed, Nov 29, 2023 at 11:18:24AM +0200, Ville Syrjälä wrote:
> > On Wed, Nov 29, 2023 at 10:11:26AM +0100, Maxime Ripard wrote:
> > > Hi Ville,
> > > 
> > > On Tue, Nov 28, 2023 at 03:49:08PM +0200, Ville Syrjälä wrote:
> > > > On Tue, Nov 28, 2023 at 02:29:40PM +0100, Maxime Ripard wrote:
> > > > > On Tue, Nov 28, 2023 at 02:54:02PM +0200, Jani Nikula wrote:
> > > > > > On Tue, 28 Nov 2023, Maxime Ripard <mripard@kernel.org> wrote:
> > > > > > > All the drm_connector_init variants take at least a pointer to the
> > > > > > > device, connector and hooks implementation.
> > > > > > >
> > > > > > > However, none of them check their value before dereferencing those
> > > > > > > pointers which can lead to a NULL-pointer dereference if the author
> > > > > > > isn't careful.
> > > > > > 
> > > > > > Arguably oopsing on the spot is preferrable when this can't be caused by
> > > > > > user input. It's always a mistake that should be caught early during
> > > > > > development.
> > > > > > 
> > > > > > Not everyone checks the return value of drm_connector_init and friends,
> > > > > > so those cases will lead to more mysterious bugs later. And probably
> > > > > > oopses as well.
> > > > > 
> > > > > So maybe we can do both then, with something like
> > > > > 
> > > > > if (WARN_ON(!dev))
> > > > >    return -EINVAL
> > > > > 
> > > > > if (drm_WARN_ON(dev, !connector || !funcs))
> > > > >    return -EINVAL;
> > > > > 
> > > > > I'd still like to check for this, so we can have proper testing, and we
> > > > > already check for those pointers in some places (like funcs in
> > > > > drm_connector_init), so if we don't cover everything we're inconsistent.
> > > > 
> > > > People will invariably cargo-cult this kind of stuff absolutely
> > > > everywhere and then all your functions will have tons of dead
> > > > code to check their arguments.
> > > 
> > > And that's a bad thing because... ?
> > > 
> > > Also, are you really saying that checking that your arguments make sense
> > > is cargo-cult?
> > > 
> > > We're already doing it in some parts of KMS, so we have to be
> > > consistent, and the answer to "most drivers don't check the error"
> > > cannot be "let's just give on error checking then".
> > > 
> > > > I'd prefer not to go there usually.
> > > > 
> > > > Should we perhaps start to use the (arguably hideous)
> > > >  - void f(struct foo *bar)
> > > >  + void f(struct foo bar[static 1])
> > > > syntax to tell the compiler we don't accept NULL pointers?
> > > > 
> > > > Hmm. Apparently that has the same problem as using any
> > > > other kind of array syntax in the prototype. That is,
> > > > the compiler demands to know the definition of 'struct foo'
> > > > even though we're passing in effectively a pointer. Sigh.
> > > 
> > > Honestly, I don't care as long as it's something we can unit-test to
> > > make sure we make it consistent. We can't unit test a complete kernel
> > > crash.
> > 
> > Why do you want to put utterly broken code into a unit test?
> 
> Utterly broken code happens. It probably shouldn't, but here we are.
> 
> Anyway, you mostly missed the consistent part.
> 
> The current state with it is:
> 
>   - planes:
>     - drm_universal_plane_init warns if funcs->destroy NULL
>     - drm_universal_plane_alloc errors out if funcs is NULL
>     - drmm_universal_plane_alloc warns and errors out if funcs or funcs->destroy are NULL
> 
>   - CRTC:
>     - drm_crtc_init_with_planes warns if funcs->destroy NULL
>     - drmm_crtc_init_with_planes warns if funcs or funcs->destroy are NULL
>     - drmm_crtc_alloc_with_planes warns and errors out if funcs or funcs->destroy are NULL
> 
>   - encoder:
>     - drm_encoder_init warns if funcs->destroy NULL
>     - drmm_encoder_init warns and errors out if funcs or funcs->destroy are NULL
>     - drmm_encoder_alloc warns and errors out if funcs or funcs->destroy are NULL
> 
>   - connectors:
>     - drm_connector_init warns and errors out if funcs or funcs->destroy are NULL
>     - drm_connector_init_with_ddc warns and errors out if funcs or funcs->destroy are NULL
>     - drmm_connector_init warns and errors out if funcs or funcs->destroy are NULL

Those are perhaps fine, as things may not oops immediately if you get
that wrong. But NULL checking things that will anyway oops immediately,
(and there's not chance the thing will do anything useful if you prevent
the oops with a NULL check) doesn't make any sense to me. It just makes
you doubt the entire universe when you see code like that.

> 
> I think that just proves that your opinion is just not as clear cut as
> you'd like it to be, and it's far from being the policy you claim it is.
> 
> Plus, we're not even remotely consistent there, and we're not
> documenting that anywhere.
> 
> And we have plenty of other examples of static stuff being checked
> because it just makes sense. All variants of drm_crtc_init_with_planes
> will for example check that the correct plane type is associated to the
> primary and cursor planes.
> 
> We should fix that.

Ideally the compiler should catch all of this. But given we are
implementing this in C (and even C23 constexpr was neutered beyond
uselessness) that's not really possible in any nice way :(

-- 
Ville Syrjälä
Intel
