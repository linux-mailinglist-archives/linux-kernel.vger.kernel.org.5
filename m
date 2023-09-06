Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C038E793CF2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbjIFMpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240784AbjIFMpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:45:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C16171F;
        Wed,  6 Sep 2023 05:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694004295; x=1725540295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2WFFdBuEq97dJvORezwILe9aKvh+wu88t3sQ9yPyujk=;
  b=QXfN3zJSqnbjdtkqE6NQ86Sb1faEN/fOrfP4HVoJ871eWeY1RdSS4R8J
   yvUvBSANhTLm/Hyv37EL0hGG/bybAT4RngiA1j2q15zx1t/ybSlU7TcV2
   wLc1VRAbOyhZIxXWdqeQ7t+z50BWey52zYCGHwrsU01H2pXt0UB8B4/CV
   87FwZLm5yGa1ipLixboUXZ4BDhHJshODzjqUMq0MWI/cQ6SstFlunVsKt
   QAKmZwQaKE+YUQt6UiOnJIkgH1kZfDXXWHXT4X0MQpNNWJ2TVBklfrTWQ
   Aa9tp3aast6MwqdyhVwNs0SGitgoD+Ist85VpoeGsDO0Mqj6PXdtowKXb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="367280616"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="367280616"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 05:44:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="1072369586"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="1072369586"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga005.fm.intel.com with SMTP; 06 Sep 2023 05:44:47 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 06 Sep 2023 15:44:46 +0300
Date:   Wed, 6 Sep 2023 15:44:46 +0300
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
Message-ID: <ZPh0Ps9UJ3HLzdeR@kuha.fi.intel.com>
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
 <20230903214150.2877023-2-dmitry.baryshkov@linaro.org>
 <ZPbrtAlO2Y+bjDhf@kuha.fi.intel.com>
 <CAA8EJpqUg2-k7LLBL38RHU1sThkXB54ca68xEMd1yMnHQcQ++w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqUg2-k7LLBL38RHU1sThkXB54ca68xEMd1yMnHQcQ++w@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 01:56:59PM +0300, Dmitry Baryshkov wrote:
> Hi Heikki,
> 
> On Tue, 5 Sept 2023 at 11:50, Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Hi Dmitry,
> >
> > On Mon, Sep 04, 2023 at 12:41:39AM +0300, Dmitry Baryshkov wrote:
> > > The kdev->fwnode pointer is never set in drm_sysfs_connector_add(), so
> > > dev_fwnode() checks never succeed, making the respective commit NOP.
> >
> > That's not true. The dev->fwnode is assigned when the device is
> > created on ACPI platforms automatically. If the drm_connector fwnode
> > member is assigned before the device is registered, then that fwnode
> > is assigned also to the device - see drm_connector_acpi_find_companion().
> >
> > But please note that even if drm_connector does not have anything in
> > its fwnode member, the device may still be assigned fwnode, just based
> > on some other logic (maybe in drivers/acpi/acpi_video.c?).
> >
> > > And if drm_sysfs_connector_add() is modified to set kdev->fwnode, it
> > > breaks drivers already using components (as it was pointed at [1]),
> > > resulting in a deadlock. Lockdep trace is provided below.
> > >
> > > Granted these two issues, it seems impractical to fix this commit in any
> > > sane way. Revert it instead.
> >
> > I think there is already user space stuff that relies on these links,
> > so I'm not sure you can just remove them like that. If the component
> > framework is not the correct tool here, then I think you need to
> > suggest some other way of creating them.
> 
> The issue (that was pointed out during review) is that having a
> component code in the framework code can lead to lockups. With the
> patch #2 in place (which is the only logical way to set kdev->fwnode
> for non-ACPI systems) probing of drivers which use components and set
> drm_connector::fwnode breaks immediately.
> 
> Can we move the component part to the respective drivers? With the
> patch 2 in place, connector->fwnode will be copied to the created
> kdev's fwnode pointer.
> 
> Another option might be to make this drm_sysfs component registration optional.

You don't need to use the component framework at all if there is
a better way of determining the connection between the DP and its
Type-C connector (I'm assuming that that's what this series is about).
You just need the symlinks, not the component.

thanks,

-- 
heikki
