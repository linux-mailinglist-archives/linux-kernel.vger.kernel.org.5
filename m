Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F7178B526
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjH1QLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjH1QLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:11:19 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1491186;
        Mon, 28 Aug 2023 09:11:15 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RZFsp6GXsz9sV3;
        Mon, 28 Aug 2023 18:11:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1693239070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Aoaaryzi6SBqAG9hPq9YHz3/mtxEs0iaU4L1R/VYHlw=;
        b=MkBv4LmWqB4b8yilepEp0iTZf/XsZa8/Ct8sticPhsSKzvm4Ctczto5Rtrl5x79oopv8eg
        29srTw4rlIoeV2p2oXlvwKAtZEHoIRGFv1iiPmAntjU3cR+V+2nNYzJ2sx2FUbYDcnooOl
        HfRGMoR6EMGx9Xaod1negh2/+FllGQiErZH6GtGuDDl+vPU48YW1V53VEOpesZlh5RQF0T
        WXRnCU/jlFI4tnv/XVOxIZAbzA+UeuNHD8q9yd6+NQq01hJauOcSg6aa778z7PMM5lEGvX
        dYJaG+1u73gNfrXHKZzfsVecd3N3G1b8gxC20QWYhY4TFpNSRINsebkVN6HNfw==
Message-ID: <88d4d764-6b71-3eff-3e2c-31f2b2f3ea6f@mailbox.org>
Date:   Mon, 28 Aug 2023 18:11:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH (set 1) 00/20] Rid W=1 warnings from GPU
Content-Language: de-CH-frami, en-CA
To:     Lee Jones <lee@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Karol Herbst <kherbst@redhat.com>, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Mikko Perttunen <mperttunen@nvidia.com>,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Michal Simek <michal.simek@xilinx.com>,
        amd-gfx@lists.freedesktop.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Danilo Krummrich <dakr@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Stanley Yang <Stanley.Yang@amd.com>,
        linux-media@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        linaro-mm-sig@lists.linaro.org, linux-tegra@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Jerome Glisse <glisse@freedesktop.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Gourav Samaiya <gsamaiya@nvidia.com>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
References: <20230824073710.2677348-1-lee@kernel.org>
 <87wmxk4xt3.fsf@intel.com> <20230824120735.GS1380343@google.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20230824120735.GS1380343@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ibs94ie8miru1dh146saewmp5c3pjzxf
X-MBO-RS-ID: aab928bbbf67e7ef629
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/23 14:07, Lee Jones wrote:
> On Thu, 24 Aug 2023, Jani Nikula wrote:
>> On Thu, 24 Aug 2023, Lee Jones <lee@kernel.org> wrote:
>>> This set is part of a larger effort attempting to clean-up W=1
>>> kernel builds, which are currently overwhelmingly riddled with
>>> niggly little warnings.
>>
>> The next question is, how do we keep it W=1 clean going forward?
> 
> My plan was to fix them all, then move each warning to W=0.
> 
> Arnd recently submitted a set doing just that for a bunch of them.
> 
> https://lore.kernel.org/all/20230811140327.3754597-1-arnd@kernel.org/
> 
> I like to think a bunch of this is built on top of my previous efforts.
> 
> GPU is a particularly tricky though - the warnings seem to come in faster
> than I can squash them.  Maybe the maintainers can find a way to test
> new patches on merge?

One approach for this which has proved effective in Mesa and other projects is to make warnings fatal in CI which must pass for any changes to be merged. There is ongoing work toward introducing this for the DRM subsystem, using gitlab.freedesktop.org CI.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

