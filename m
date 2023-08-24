Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4274786AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbjHXJA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238017AbjHXJAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:00:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B9B1739;
        Thu, 24 Aug 2023 02:00:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EE4461F83;
        Thu, 24 Aug 2023 09:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6785BC433C8;
        Thu, 24 Aug 2023 09:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692867647;
        bh=pRjABeYbdZ7kYm0kauhfXEU9jP8GasEtUcwhn21dCxc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FyA43QAVtvboJtLBnYjCn2l5B6rkqjm/L5UMpQBdz1EkwfzYAJF8ceZbbmfDWvnHP
         c0NMsslfjy8YhmJnLIzirvCjxSqW/j46XG9U+pmj4Rdo4Jb1Ib0MPYmuWBfIdRgQcv
         BQCIKj1tuabIgXNffOpoMoKWz6fFmUEc9y0mHFL+CvHTWIXiMDWg2qmK0a8Rrr6utX
         4rQmBV9mdjclIv6Vlg0WeG5NxWT/TfYNNSEl1D7oeImRLkiMXntWYDhOsYxx5vULvK
         4Ndwj/COJJ2khusQSyxLJCpSzB4hk7l3yB5hTbRpcCaHI+0YefYTK3XWKmNGhMw9SO
         EvN/cUb31UV0w==
From:   Maxime Ripard <mripard@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Danilo Krummrich <dakr@redhat.com>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Fabio Estevam <festevam@gmail.com>,
        Gourav Samaiya <gsamaiya@nvidia.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Jerome Glisse <glisse@freedesktop.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Karol Herbst <kherbst@redhat.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-tegra@vger.kernel.org, Luben Tuikov <luben.tuikov@amd.com>,
        Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        nouveau@lists.freedesktop.org, NXP Linux Team <linux-imx@nxp.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanley Yang <Stanley.Yang@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230824073710.2677348-1-lee@kernel.org>
References: <20230824073710.2677348-1-lee@kernel.org>
Subject: Re: [PATCH (set 1) 00/20] Rid W=1 warnings from GPU
Message-Id: <169286759481.453038.12943953579128536191.b4-ty@kernel.org>
Date:   Thu, 24 Aug 2023 10:59:54 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 08:36:45 +0100, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Danilo Krummrich <dakr@redhat.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Gourav Samaiya <gsamaiya@nvidia.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Hyun Kwon <hyun.kwon@xilinx.com>
> Cc: Jerome Glisse <glisse@freedesktop.org>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: linaro-mm-sig@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-media@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: "Maíra Canal" <mairacanal@riseup.net>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Mikko Perttunen <mperttunen@nvidia.com>
> Cc: nouveau@lists.freedesktop.org
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shashank Sharma <shashank.sharma@amd.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stanley Yang <Stanley.Yang@amd.com>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> 
> [...]

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime

