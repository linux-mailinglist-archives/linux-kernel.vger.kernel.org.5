Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FA6786EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241286AbjHXMJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241323AbjHXMJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:09:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286BB1995;
        Thu, 24 Aug 2023 05:09:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9AEC65AAC;
        Thu, 24 Aug 2023 12:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFBCC433C8;
        Thu, 24 Aug 2023 12:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692878949;
        bh=nDrNKOtmg11/enQQ5RREoJgVg8/0zOccRWjy98KT4qQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oRUYmi/VCinRtYudh5/5tdhvXDfrGVv4obVDADWdP1BqXTCD2nVysXU+QdF+KVtI3
         OfrD/QYGQCFaNVe0xP8E6qig8Bj6UQGEhYb1z/bbfnWXKlREUW+pdjRushxaCxZkRq
         YoluSLv7+T+KYTaxP/gog5iV8k3wtgnkMQjrRHZRhkSLe6th/dFN3O7t8izie30yrc
         +PaYB8efb/alntKNaTtSXmJAKRIoDz240uw3FneHjThhmfMYulp+fQKO6kw5907Dtm
         YF6cPwF+bbWmW+ihwXeY3z/mup64gCiZAU1ByVA4KIgqVdMqve6pQcXQibnGMu7L5U
         IDq2nl106iyaw==
Date:   Thu, 24 Aug 2023 13:08:59 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Karol Herbst <kherbst@redhat.com>, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Mikko Perttunen <mperttunen@nvidia.com>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Michal Simek <michal.simek@xilinx.com>,
        amd-gfx@lists.freedesktop.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Danilo Krummrich <dakr@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-media@vger.kernel.org,
        Stanley Yang <Stanley.Yang@amd.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        linaro-mm-sig@lists.linaro.org, linux-tegra@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        Jerome Glisse <glisse@freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Gourav Samaiya <gsamaiya@nvidia.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Subject: Re: [PATCH (set 1) 00/20] Rid W=1 warnings from GPU
Message-ID: <20230824120859.GT1380343@google.com>
References: <20230824073710.2677348-1-lee@kernel.org>
 <87wmxk4xt3.fsf@intel.com>
 <20230824120735.GS1380343@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824120735.GS1380343@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023, Lee Jones wrote:

> On Thu, 24 Aug 2023, Jani Nikula wrote:
> 
> > On Thu, 24 Aug 2023, Lee Jones <lee@kernel.org> wrote:
> > > This set is part of a larger effort attempting to clean-up W=1
> > > kernel builds, which are currently overwhelmingly riddled with
> > > niggly little warnings.
> > 
> > The next question is, how do we keep it W=1 clean going forward?
> 
> My plan was to fix them all, then move each warning to W=0.

Some history:

- Starting with v5.8-rc1:       18867
- 2020-07-01:                   18089
- 2020-07-07:                   17288
- 2020-07-17:                   15762
- 2020-07-20:                   15724
- 2020-07-23:                   15116
- 2020-08-12:                   15184
- 2020-10-19:                   10909
- 2020-11-04:                    9385
- 2021-01-04:                    5478
- 2021-01-12                     4749
- 2021-01-29                     4911
- 2021-04-07                     3594
- 2021-05-20                     2938
- 2021-07-01                     2587
- 2023-02-10                     2587
- 2023-08-22                     1650

> Arnd recently submitted a set doing just that for a bunch of them.
> 
> https://lore.kernel.org/all/20230811140327.3754597-1-arnd@kernel.org/
> 
> I like to think a bunch of this is built on top of my previous efforts.
> 
> GPU is a particularly tricky though - the warnings seem to come in faster
> than I can squash them.  Maybe the maintainers can find a way to test
> new patches on merge?
> 
> > Most people don't use W=1 because it's too noisy, so it's a bit of a
> > catch-22.
> > 
> > In i915, we enable a lot of W=1 warnings using subdir-ccflags-y in our
> > Makefile. For CI/developer use we also enable kernel-doc warnings by
> > default.
> > 
> > Should we start enabling some of those warning flags in drm/Makefile to
> > to keep the entire subsystem warning free?
> 
> That would we awesome!  We'd just need buy-in.

-- 
Lee Jones [李琼斯]
