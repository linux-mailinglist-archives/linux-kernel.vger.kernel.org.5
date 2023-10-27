Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA457D9E07
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjJ0Qcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjJ0Qc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:32:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33484128;
        Fri, 27 Oct 2023 09:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698424347; x=1729960347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5IcXRoptUEcVDpArktnOALVLCfO+5LN/wy4M44e5nIE=;
  b=RudKEyFE54qe2k4ieI/u7o3X/OrgZPuYdJyxP+7Ljhexz3GVHtFm7+uM
   tvYtPjucivomJfxeY4xeBxceXCBsk5HJR8+lkTLyJCc46VXch/pcZMBoC
   wBCn7Ht/hxk/OW/8l/ox38/pIlP0/f/Y6o5CzwsbLf6gyVZv1TFviDWJt
   JYfNt5jtCHIQ10YF9LYOTPBx+nAKBMoh7n+YK9sGu4E+4w8hsv1yCLdg0
   x0Excs0nAtUhOfwPQtrLdNKiwID5rPjokpzxOks6V1/F66YD/zVuxVoni
   FNY2QOgdDhEummEHI6Oebcoj6PFAK9zbBBSDMxaIP9Ur1pu0D7sMx4Y2I
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="368020368"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="368020368"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 09:30:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="903316290"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="903316290"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 09:28:10 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 3322E11F830;
        Fri, 27 Oct 2023 19:30:36 +0300 (EEST)
Date:   Fri, 27 Oct 2023 16:30:36 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] GC0308 Camera Sensor
Message-ID: <ZTvlrJK8nwvFbUhU@kekkonen.localdomain>
References: <20231027011417.2174658-1-sre@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027011417.2174658-1-sre@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Fri, Oct 27, 2023 at 03:12:00AM +0200, Sebastian Reichel wrote:
> Hi,
> 
> I did the following tests done by me on an i.MX6ULL based system [0]:
> 
>  * v4l2-compliance -u /dev/v4l-subdev1
>    - v4l2-compliance 1.24.1, 32 bits, 32-bit time_t
>      (from Debian testing)
>    - Total for device /dev/v4l-subdev1: 44, Succeeded: 44
>  * Using gstreamer + v4l2-ctl
>    - Tried 640x480, 320x240, 160x120 YUYV8_2X8 formats
>    - Tested effect of all exposed user controls
>  * checkpatch does not report any driver issues
>  * dt_binding_check does not report anything
> 
> Note, that there is another patchset adding GC2145, which
> adds the same vendor prefix. I just included it for completeness,
> since it's needed to avoid checkpatch and dt_binding_check
> warnings.

Thanks for the update.

There's a spelling error I noticed which I'll fix while applying but
otherwise I'm looking forward to have Jacopo's comments on the patch. It
seems good to me.

-- 
Kind regards,

Sakari Ailus
