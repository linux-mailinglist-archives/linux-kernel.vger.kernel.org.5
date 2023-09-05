Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874B3792BB9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbjIEQ62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353952AbjIEIuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:50:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A78DAA;
        Tue,  5 Sep 2023 01:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693903805; x=1725439805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fGB8Ql7Gce8esFznLWuQEPATfaVZ2AGRnVV+EfOKE9A=;
  b=kIT57pMbL4lESL1a4d41BQtoRMVrjr9twlR+eBnLuaNYq2Vf+TciNJor
   u2RzIc5dgk3Mfl4Tx9nI2hyDd8ysQ4NijU5lVxHlr8RVqUNIfxnpNnSkj
   0Ab2qVCQA8A/9kjOjjc+Nc9lM2rbpFw7H9NO+ggcapfrAPMSOsm+P1SAS
   9lPyy9Cy2B26BzAqM53/Ifni0TmZuH+NovN2pr+6FWAGAQryFqAwG/oBL
   VvDrFx6F8YwLOa3KeciAjGX2EOblXDn3Nch90JBgLRBXVTVIJqasfqJjw
   UN1IFWr6+meuinuxXJdJixOvUqZ+VNA0ReoSGaIvvMMIPpXoZavfXA5r6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="379463451"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="379463451"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 01:50:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="1071893689"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="1071893689"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga005.fm.intel.com with SMTP; 05 Sep 2023 01:49:56 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 05 Sep 2023 11:49:56 +0300
Date:   Tue, 5 Sep 2023 11:49:56 +0300
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
Message-ID: <ZPbrtAlO2Y+bjDhf@kuha.fi.intel.com>
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
 <20230903214150.2877023-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903214150.2877023-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Mon, Sep 04, 2023 at 12:41:39AM +0300, Dmitry Baryshkov wrote:
> The kdev->fwnode pointer is never set in drm_sysfs_connector_add(), so
> dev_fwnode() checks never succeed, making the respective commit NOP.

That's not true. The dev->fwnode is assigned when the device is
created on ACPI platforms automatically. If the drm_connector fwnode
member is assigned before the device is registered, then that fwnode
is assigned also to the device - see drm_connector_acpi_find_companion().

But please note that even if drm_connector does not have anything in
its fwnode member, the device may still be assigned fwnode, just based
on some other logic (maybe in drivers/acpi/acpi_video.c?).

> And if drm_sysfs_connector_add() is modified to set kdev->fwnode, it
> breaks drivers already using components (as it was pointed at [1]),
> resulting in a deadlock. Lockdep trace is provided below.
> 
> Granted these two issues, it seems impractical to fix this commit in any
> sane way. Revert it instead.

I think there is already user space stuff that relies on these links,
so I'm not sure you can just remove them like that. If the component
framework is not the correct tool here, then I think you need to
suggest some other way of creating them.

Side note. The problem you are describing here is a limitation in the
component framework - right now it's made with the idea that a device
can represent a single component, but it really should allow a device
to represent multiple components. I'm not saying that you should try
to fix the component framework, but I just wanted to make a note about
this (and this is not the only problem with the component framework).

I like the component framework as a concept, but I think it needs a
lot of improvements - possibly rewrite.

thanks,

-- 
heikki
