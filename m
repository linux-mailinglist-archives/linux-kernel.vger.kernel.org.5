Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44169800E6A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379423AbjLAPSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379475AbjLAPRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:17:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F2C1726;
        Fri,  1 Dec 2023 07:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701443862; x=1732979862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wYPSx9+wbY4jC6jNQkQIxE7XoYAMfQUsgyw8T5lmYsg=;
  b=BSk1eTp8KH6vv/xHR/hqBvxjsmTmsyXdzRXG1Wo/L7e7G5SfwQylPMG+
   YkXtbigEZsO5w1S2iweiDGXZE3iSHwiy2hGcke9MzRQ/Wf7+7RbPJQ0yB
   d5mUl2JYLwlSiJrwkHCENgayWrszw5EjLyyMilpOztM5ZkiPV97WaZgEB
   gc1xMQicCyPCHH5B7GT7jFQ5weEzDjCf6ukWsA9WbX9GbpQp1Sn42gvk5
   4GkvCDs2urtN9tMD9T1hSlgCLTLIcZiQkznmc4o0i9HFLq0MGqG2C3/Kv
   uxzckUkozpf2PnDJddt/I/gU8IcgbWVvio6fga4qiMB/dCuJZVeDyDUHJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="362668"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="362668"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 07:17:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="763178004"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="763178004"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga007.jf.intel.com with SMTP; 01 Dec 2023 07:17:36 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 01 Dec 2023 17:17:35 +0200
Date:   Fri, 1 Dec 2023 17:17:35 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>,
        dri-devel@lists.freedesktop.org,
        Samuel Holland <samuel@sholland.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandy Huang <hjc@rock-chips.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v4 05/45] drm/connector: Check drm_connector_init
 pointers arguments
Message-ID: <ZWn5D387DYmsh1sa@intel.com>
References: <20231128-kms-hdmi-connector-state-v4-0-c7602158306e@kernel.org>
 <20231128-kms-hdmi-connector-state-v4-5-c7602158306e@kernel.org>
 <87h6l66nth.fsf@intel.com>
 <v3hplco5fdedv6bnc6mwx2zhhw4xxdiekha26ykhc5cmy7ol77@2irk3w4hmabw>
 <ZWXv1Oi_sH0BRWao@intel.com>
 <20231129121259.47746996@eldfell>
 <ZWcRoTJ9VgOqZ3ts@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWcRoTJ9VgOqZ3ts@intel.com>
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

On Wed, Nov 29, 2023 at 12:25:37PM +0200, Ville Syrjälä wrote:
> On Wed, Nov 29, 2023 at 12:12:59PM +0200, Pekka Paalanen wrote:
> > On Tue, 28 Nov 2023 15:49:08 +0200
> > Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> > 
> > > Should we perhaps start to use the (arguably hideous)
> > >  - void f(struct foo *bar)
> > >  + void f(struct foo bar[static 1])
> > > syntax to tell the compiler we don't accept NULL pointers?
> > > 
> > > Hmm. Apparently that has the same problem as using any
> > > other kind of array syntax in the prototype. That is,
> > > the compiler demands to know the definition of 'struct foo'
> > > even though we're passing in effectively a pointer. Sigh.
> > 
> > 
> > __attribute__((nonnull)) ?
> 
> I guess that would work, though the syntax is horrible when
> you need to flag specific arguments.

I played around with this a bit (blindly cocci'd tons of
drm and i915 function declarations with the nonnull attribute)
and it's somewhat underwhelming unfortunately.

It will trip only if the compiler is 100% sure you're passing
in a NULL. There is no way to eg. tell the compiler that a
function can return a NULL and thus anything coming from it
should be checked by the caller before passing it on to
something with the nonnull attribute. And I suppose error
pointers would also screw that idea over anyway.

Additionally the NULL device checks being being done in 
the drm_err/dbg macros trip this up left right and center.
And hiding that check inside a function (instead of having
it in the macro) is also ruined by the fact that we apparently
pass different types of pointers to these macros :( Generics
could be used to sort out that type mess I suppose, or the
code that passes the wrong type (DSI code at least) should
just be changed to not do that. But not sure if there's enough
benefit to warrant the work.

-- 
Ville Syrjälä
Intel
