Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC23478E053
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245491AbjH3TWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243428AbjH3K6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:58:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D974A1BF;
        Wed, 30 Aug 2023 03:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693393121; x=1724929121;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version;
  bh=Ba+ap190nbT9y0MOHYUH6N6N/yy00EJmGs6/T//2stI=;
  b=BeB6r25y24qEWo7txHbSXFkkCIzhHtycNp1igP/eKZqeYWXH0EgxaaIY
   NNigsKTwEU2h80Ix0eYblkSenW2CzKu6RlkNK9Gl4N5MV+hNb9laq6VdL
   6YVJzSCt98wAdiRKQKTVbU7M/s1q4Ol/VOt52Y9fxjdq9ST/yIaKYAGMQ
   L/bF/R4Odcn7k56bUA8wyFNPEMugYQdKbLBEgCUrjt/verLky0OVNkK+Z
   jgxtHCl9sfDf9MRmWf9j0EdFDKGeG6UFVb2t4SL9g05LcGZ2CRCC14XNk
   NnFUhnaKa04xzhug1DjJS2S277Wo159q6mqNIUB5gH6cjYwOPqVVaTtIl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="441974435"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="441974435"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 03:58:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="882711770"
Received: from ziemtocx-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.57.251])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 03:58:39 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Helen Koike <helen.koike@collabora.com>,
        dri-devel@lists.freedesktop.org, guilherme.gallo@collabora.com,
        sergi.blanch.torne@collabora.com, david.heidelberg@collabora.com,
        daniels@collabora.com, emma@anholt.net, robclark@freedesktop.org,
        gustavo.padovan@collabora.com, robdclark@google.com,
        anholt@google.com, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, airlied@gmail.com, corbet@lwn.net,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        heiko@sntech.de, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v11] drm: Add initial ci/ subdirectory
In-Reply-To: <zorvxwffshrsqx5cy76pe3gn52qrqav7qusz5acav2un2ydvwr@fwjd56qg2xve>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230811171953.176431-1-helen.koike@collabora.com>
 <ZOTFfhtzzWkrQ23Y@phenom.ffwll.local>
 <zorvxwffshrsqx5cy76pe3gn52qrqav7qusz5acav2un2ydvwr@fwjd56qg2xve>
Date:   Wed, 30 Aug 2023 13:58:31 +0300
Message-ID: <87bkeo23vs.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023, Maxime Ripard <mripard@kernel.org> wrote:
> On Tue, Aug 22, 2023 at 04:26:06PM +0200, Daniel Vetter wrote:
>> On Fri, Aug 11, 2023 at 02:19:53PM -0300, Helen Koike wrote:
>> > From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> > 
>> > Developers can easily execute several tests on different devices
>> > by just pushing their branch to their fork in a repository hosted
>> > on gitlab.freedesktop.org which has an infrastructure to run jobs
>> > in several runners and farms with different devices.
>> > 
>> > There are also other automated tools that uprev dependencies,
>> > monitor the infra, and so on that are already used by the Mesa
>> > project, and we can reuse them too.
>> > 
>> > Also, store expectations about what the DRM drivers are supposed
>> > to pass in the IGT test suite. By storing the test expectations
>> > along with the code, we can make sure both stay in sync with each
>> > other so we can know when a code change breaks those expectations.
>> > 
>> > Also, include a configuration file that points to the out-of-tree
>> > CI scripts.
>> > 
>> > This will allow all contributors to drm to reuse the infrastructure
>> > already in gitlab.freedesktop.org to test the driver on several
>> > generations of the hardware.
>> > 
>> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> > Signed-off-by: Helen Koike <helen.koike@collabora.com>
>> > Acked-by: Daniel Stone <daniels@collabora.com>
>> > Acked-by: Rob Clark <robdclark@gmail.com>
>> > Tested-by: Rob Clark <robdclark@gmail.com>
>> 
>> Ok I pushed this into a topic/drm-ci branch in drm.git and asked sfr to
>> include that branch in linux-next.
>> 
>> But also I'd like to see a lot more acks here, we should be able to at
>> least pile up a bunch of (driver) maintainers from drm-misc in support of
>> this. Also maybe media, at least I've heard noises that they're maybe
>> interested too? Plus anyone else, the more the better.
>
> I'm not really convinced by that approach at all, and most of the issues
> I see are shown by the follow-up series here:

I'm not fully convinced either, more like "let's see". In that narrow
sense, ack. I don't see harm in trying, if you're also open to backing
off in case it does not pan out.

> https://lore.kernel.org/dri-devel/20230825122435.316272-1-vignesh.raman@collabora.com/
>
>   * We hardcode a CI farm setup into the kernel
>
>   * We cannot trust that the code being run is actually the one being
>     pushed into gitlab
>
>   * IMO, and I know we disagree here, any IGT test we enable for a given
>     platform should work, period. Allowing failures and flaky tests just
>     sweeps whatever issue is there under the rug. If the test is at
>     fault, we should fix the test, if the driver / kernel is at fault,
>     then I certainly want to know about it.

At least for display, where this also depends on peripheral hardware,
it's not an easy problem, really. How reliable do you need it to be?
How many nines? Who is going to debug the issues that need hundreds or
thousands of runs to reproduce? If a commit makes some test less
reliable, how long is it going to take to even see that or pinpoint
that?

It's a kind of cop out, but this is not filesystems. In many cases I
think we might be able to make things more robust by failing faster and
failing more, but the users probably want us to plunge forward despite
some errors to try to get something on screen.

(Come to think of it, perhaps we should classify tests based on whether
external hardware plays a role.)

So I'm not so concerned about the filter lists per se, but rather about
having them in kernel.

BR,
Jani.

>
>   * This then leads to patches like this one:
>     https://lore.kernel.org/dri-devel/20230825122435.316272-6-vignesh.raman@collabora.com/
>
>     Which (and it's definitely not the author's fault) are just plain
>     unreadable, reproducable or auditable by anyone not heavily involved
>     in the CI farm operations and the platforms being tested.
>
> That being said, I don't have anything better to suggest than what I
> already did, and it looks like I'm alone in thinking that those are
> problems, so feel free to add my ack if you want to.
>
> Maxime

-- 
Jani Nikula, Intel Open Source Graphics Center
