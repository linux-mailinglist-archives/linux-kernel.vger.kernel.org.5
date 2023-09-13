Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9894679E500
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbjIMKeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjIMKeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:34:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD419C3;
        Wed, 13 Sep 2023 03:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694601257; x=1726137257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aSLZAhLlCUcLtEt71s9aVgFB3sPUO22k85ZuXX7lIvk=;
  b=C0Qmswudx36Cx1JSwSQi1JrAbNLUKyrE3OzO/BSKVw9soAN1W/S3bQcB
   eRkH66UHWXRHATsEaAXVhkNCMAx+khf52If5VuQpUn+hS+JbkyA5Dl+Iy
   6TkXj7isNDZg/o+n6rrVlZfqr0IleNjdNUDkQB7ksbe6XXI04MagUfYz+
   wB+DFgnH61/wBVsEzmEOqWp3YnzOeP8vpPiWMnA/La4DFtDqoKC5neRzf
   70luKTEMlfZEQatf8zETCu/aqLpgpC4hHKT+l9hkDnwV8XWZ8GrDyv3bS
   BDPuCaDJtRdZsnEXbSbeQ7jCz9Yqj+S/Y1IjLKGmLirKJpOyXqDUXtUzF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="377534957"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="377534957"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:34:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="990870840"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="990870840"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga006.fm.intel.com with SMTP; 13 Sep 2023 03:34:09 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 13 Sep 2023 13:34:08 +0300
Date:   Wed, 13 Sep 2023 13:34:08 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
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
Message-ID: <ZQGQIGNUq+UL9lpi@kuha.fi.intel.com>
References: <20230903214150.2877023-2-dmitry.baryshkov@linaro.org>
 <ZPbrtAlO2Y+bjDhf@kuha.fi.intel.com>
 <CAA8EJpqUg2-k7LLBL38RHU1sThkXB54ca68xEMd1yMnHQcQ++w@mail.gmail.com>
 <ZPh0Ps9UJ3HLzdeR@kuha.fi.intel.com>
 <CAA8EJpratbBybgk8woD3maA=J_HuQis44Unq0n+c_UvaFs__AA@mail.gmail.com>
 <ZPiAwOf00RREiYPr@kuha.fi.intel.com>
 <6b6bacee-f7b6-4cfe-be3d-24bda44bfbcf@linaro.org>
 <ZQBGD8CY5OVKYX63@kuha.fi.intel.com>
 <a97a33f4-71f3-4610-a59e-0c2d5ae86670@linaro.org>
 <a36d7b75-b072-4202-8f09-9eab0dfd52ed@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36d7b75-b072-4202-8f09-9eab0dfd52ed@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Wed, Sep 13, 2023 at 11:38:19AM +0200, Neil Armstrong wrote:
> On new platforms (starting from SM8450) UCSI is mandatory to have
> pmic_glink_altmode events triggering.

You can also populate the typec devices conditionally, only if UCSI is
not supported.

However, I took a peek at drivers/soc/qcom/pmic_glink_altmode.c, and
it seems to be mostly is dealing with the muxes and retimer, and
sending the HPD notifications to the DRM side. All that is already
done in typec drivers, so there is actually a potential race here when
UCSI is used.

On top of that, it is sending two commands to the PMIC (ALTMODE_PAN_EN
and ALTMODE_PAN_ACK). I'm pretty sure both could be handled in the UCSI
glue driver (drivers/usb/typec/ucsi/ucsi_glink.c) if they are even
needed when UCSI is supported.

So why do you need that pmic_glibk_altmode driver at all when UCSI is
supported?

I don't know the hardware, so I may be missing something.

thanks,

-- 
heikki
