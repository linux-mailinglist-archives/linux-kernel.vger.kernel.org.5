Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBCA793DDE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241166AbjIFNiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240979AbjIFNiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:38:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2DD10C7;
        Wed,  6 Sep 2023 06:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694007497; x=1725543497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l0yqPyXeMtkEe7eJDRu4uOHmMf5EFulFbVZ32U4Q2G4=;
  b=C8+FUnuonfrByuLMbAMzOarWDy4/ITFz4K27RaBZUTS56tg/EOxF95Pr
   O1SoGfJ/8kEjn5PhZ2mRf1i9Zf9CpX86IKBzGLC9mYPCpwGJdHE7xxBAb
   PUeYYCJ1KNY0n5QEgFL6rKlpit/ZT76+xr1q9csaGLEPlFtWUCvgK4yDf
   sxD0wy7DHitXV9H/ABJL5db1ATKdwBVJuBGwt8V4CompFkTnSfRiPIJ8+
   Dbsh28mMHvODj5yZXSh9qNiU4cQBHxh82U4OoaWm3Ef+gcvO1YFWhkk3D
   kPZN5OD79sq515kdOzWB9udwj8AptR/uWK7uygDqk/YYSL/ZLY3nqf5dZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="362097849"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="362097849"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 06:38:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="735049955"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="735049955"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga007.jf.intel.com with SMTP; 06 Sep 2023 06:38:08 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 06 Sep 2023 16:38:08 +0300
Date:   Wed, 6 Sep 2023 16:38:08 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Janne Grunau <j@jannau.net>, Simon Ser <contact@emersion.fr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org, Won Chung <wonchung@google.com>
Subject: Re: [RFC PATCH v1 01/12] Revert "drm/sysfs: Link DRM connectors to
 corresponding Type-C connectors"
Message-ID: <ZPiAwOf00RREiYPr@kuha.fi.intel.com>
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
 <20230903214150.2877023-2-dmitry.baryshkov@linaro.org>
 <ZPbrtAlO2Y+bjDhf@kuha.fi.intel.com>
 <CAA8EJpqUg2-k7LLBL38RHU1sThkXB54ca68xEMd1yMnHQcQ++w@mail.gmail.com>
 <ZPh0Ps9UJ3HLzdeR@kuha.fi.intel.com>
 <CAA8EJpratbBybgk8woD3maA=J_HuQis44Unq0n+c_UvaFs__AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpratbBybgk8woD3maA=J_HuQis44Unq0n+c_UvaFs__AA@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 03:48:35PM +0300, Dmitry Baryshkov wrote:
> On Wed, 6 Sept 2023 at 15:44, Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Tue, Sep 05, 2023 at 01:56:59PM +0300, Dmitry Baryshkov wrote:
> > > Hi Heikki,
> > >
> > > On Tue, 5 Sept 2023 at 11:50, Heikki Krogerus
> > > <heikki.krogerus@linux.intel.com> wrote:
> > > >
> > > > Hi Dmitry,
> > > >
> > > > On Mon, Sep 04, 2023 at 12:41:39AM +0300, Dmitry Baryshkov wrote:
> > > > > The kdev->fwnode pointer is never set in drm_sysfs_connector_add(), so
> > > > > dev_fwnode() checks never succeed, making the respective commit NOP.
> > > >
> > > > That's not true. The dev->fwnode is assigned when the device is
> > > > created on ACPI platforms automatically. If the drm_connector fwnode
> > > > member is assigned before the device is registered, then that fwnode
> > > > is assigned also to the device - see drm_connector_acpi_find_companion().
> > > >
> > > > But please note that even if drm_connector does not have anything in
> > > > its fwnode member, the device may still be assigned fwnode, just based
> > > > on some other logic (maybe in drivers/acpi/acpi_video.c?).
> > > >
> > > > > And if drm_sysfs_connector_add() is modified to set kdev->fwnode, it
> > > > > breaks drivers already using components (as it was pointed at [1]),
> > > > > resulting in a deadlock. Lockdep trace is provided below.
> > > > >
> > > > > Granted these two issues, it seems impractical to fix this commit in any
> > > > > sane way. Revert it instead.
> > > >
> > > > I think there is already user space stuff that relies on these links,
> > > > so I'm not sure you can just remove them like that. If the component
> > > > framework is not the correct tool here, then I think you need to
> > > > suggest some other way of creating them.
> > >
> > > The issue (that was pointed out during review) is that having a
> > > component code in the framework code can lead to lockups. With the
> > > patch #2 in place (which is the only logical way to set kdev->fwnode
> > > for non-ACPI systems) probing of drivers which use components and set
> > > drm_connector::fwnode breaks immediately.
> > >
> > > Can we move the component part to the respective drivers? With the
> > > patch 2 in place, connector->fwnode will be copied to the created
> > > kdev's fwnode pointer.
> > >
> > > Another option might be to make this drm_sysfs component registration optional.
> >
> > You don't need to use the component framework at all if there is
> > a better way of determining the connection between the DP and its
> > Type-C connector (I'm assuming that that's what this series is about).
> > You just need the symlinks, not the component.
> 
> The problem is that right now this component registration has become
> mandatory. And if I set the kdev->fwnode manually (like in the patch
> 2), the kernel hangs inside the component code.
> That's why I proposed to move the components to the place where they
> are really necessary, e.g. i915 and amd drivers.

So why can't we replace the component with the method you are
proposing in this series of finding out the Type-C port also with
i915, AMD, or whatever driver and platform (that's the only thing that
component is used for)?

Determining the connection between a DP and its Type-C connector is
starting to get really important, so ideally we have a common solution
for that.

thanks,

-- 
heikki
