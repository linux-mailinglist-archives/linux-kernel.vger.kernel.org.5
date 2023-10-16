Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815387CACFE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjJPPKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPPKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:10:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C06B4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697469016; x=1729005016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MyQvP0kMS5N7+lm1yhQWu0Yl1r3TfRGrjFdxq50e9BY=;
  b=SxdhfmYRRF7j8cEO52r6X2R+ngjMYp4qzL6BTAcgBskneebP6zhOjEJa
   iu8UUvrDpYJCjgm7xmfhkQO/XiRBEjht1zsMMVZ83xLf6sLsuAO26lm2M
   IhUJxF438LnX6GgZCUs+juANlNqM3rcmiuVwOwbR8vsH7lJuByWwbmJKC
   AQn9bO6unP0DUigJX+kTGQjuseBXkVQyZyLMflnU57182/y86qTlrJ97L
   8KoRaBACyGU6X7l/ZWRPOSZiu7uBZS9xs97ceG+YtoxaxM0IHjCf/SEr2
   TPQ+OJiBFgAV6nQzjzNoWIVsb5wA40HPP13Jh2oLv/QYyy/wBgCoFVTbH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="370622954"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="370622954"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 08:10:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="790832317"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="790832317"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 16 Oct 2023 08:10:07 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 16 Oct 2023 18:10:07 +0300
Date:   Mon, 16 Oct 2023 18:10:07 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>,
        xaver.hugl@gmail.com, pierre-eric.pelloux-prayer@amd.com,
        Daniel Vetter <daniel@ffwll.ch>,
        'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Stone <daniel@fooishbar.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, hwentlan@amd.com,
        Rob Clark <robdclark@gmail.com>, kernel-dev@igalia.com,
        alexander.deucher@amd.com, Dave Airlie <airlied@gmail.com>,
        christian.koenig@amd.com, joshua@froggi.es,
        wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 6/6] drm/doc: Define KMS atomic state set
Message-ID: <ZS1ST6XAUHilBg3d@intel.com>
References: <20230815185710.159779-1-andrealmeid@igalia.com>
 <20230815185710.159779-7-andrealmeid@igalia.com>
 <1b23576d-1649-ff5c-6273-b54729ea46d8@mailbox.org>
 <b48bd1fc-fcb0-481b-8413-9210d44d709b@igalia.com>
 <20231016151856.74af9305@eldfell>
 <aa424bf8-5652-4a44-9b93-bdc0a31d835a@igalia.com>
 <20231016175222.7a89e6ab@eldfell>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231016175222.7a89e6ab@eldfell>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 05:52:22PM +0300, Pekka Paalanen wrote:
> On Mon, 16 Oct 2023 15:42:16 +0200
> André Almeida <andrealmeid@igalia.com> wrote:
> 
> > Hi Pekka,
> > 
> > On 10/16/23 14:18, Pekka Paalanen wrote:
> > > On Mon, 16 Oct 2023 12:52:32 +0200
> > > André Almeida <andrealmeid@igalia.com> wrote:
> > >  
> > >> Hi Michel,
> > >>
> > >> On 8/17/23 12:37, Michel Dänzer wrote:  
> > >>> On 8/15/23 20:57, André Almeida wrote:  
> > >>>> From: Pekka Paalanen <pekka.paalanen@collabora.com>
> > >>>>
> > >>>> Specify how the atomic state is maintained between userspace and
> > >>>> kernel, plus the special case for async flips.
> > >>>>
> > >>>> Signed-off-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> > >>>> Signed-off-by: André Almeida <andrealmeid@igalia.com>  
> > >>> [...]
> > >>>     
> > >>>> +An atomic commit with the flag DRM_MODE_PAGE_FLIP_ASYNC is allowed to
> > >>>> +effectively change only the FB_ID property on any planes. No-operation changes
> > >>>> +are ignored as always. [...]  
> > >>> During the hackfest in Brno, it was mentioned that a commit which re-sets the same FB_ID could actually have an effect with VRR: It could trigger scanout of the next frame before vertical blank has reached its maximum duration. Some kind of mechanism is required for this in order to allow user space to perform low frame rate compensation.
> > >>>     
> > >> Xaver tested this hypothesis in a flipping the same fb in a VRR monitor
> > >> and it worked as expected, so this shouldn't be a concern.  
> > > Right, so it must have some effect. It cannot be simply ignored like in
> > > the proposed doc wording. Do we special-case re-setting the same FB_ID
> > > as "not a no-op" or "not ignored" or some other way?  
> > There's an effect in the refresh rate, the image won't change but it 
> > will report that a flip had happened asynchronously so the reported 
> > framerate will be increased. Maybe an additional wording could be like:
> > 
> > Flipping to the same FB_ID will result in a immediate flip as if it was 
> > changing to a different one, with no effect on the image but effecting 
> > the reported frame rate.
> 
> Re-setting FB_ID to its current value is a special case regardless of
> PAGE_FLIP_ASYNC, is it not?

No. The rule has so far been that all side effects are observed
even if you flip to the same fb. And that is one of my annoyances
with this proposal. The rules will now be different for async flips
vs. everything else.

The other issues (mainly relating to hardware where not all planes
support async flips) I've already highlighted in some earlier mail.

-- 
Ville Syrjälä
Intel
