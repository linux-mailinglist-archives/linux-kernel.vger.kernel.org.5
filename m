Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853977D9601
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345649AbjJ0LIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0LH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:07:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B159F9C;
        Fri, 27 Oct 2023 04:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698404876; x=1729940876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2vc4u83zhSQDbHRQB1dGUjT2PyjUrmwjzYV4iijhh68=;
  b=Zk+k8gpisFthZ+Li7uLm2ooQtghtAP0SnvbYYbMU8gGnmr4fYJBTCPL7
   qoA+HpplEJTLvYrMjs3dWg/GHWZGaDOvBqvOJ3+rKeknJ1sC/THG5JWpA
   /b82khsG0BPPUIMGwr+G+emcawQKwI7XqC6s7obYX1OsQ408qUvunIMbR
   1/2yUOKLXHgzdeQ0gyZC1NTGneoa1rWeE4p7y5+PWoV0YU8kLaJkvS+N9
   u63L2DgCQc+cDQ6EeXN++nceiDMViDFeF9jUXgz95dUfKf9+w1vDM3Vdq
   fX1M0X/0XePt1uaSXOmsab70y4y5eh/gLy+UJZAUs/JKsxvC5DJtZp/qW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="418866883"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="418866883"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:07:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="850216676"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="850216676"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:07:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qwKgn-000000097se-2gQW;
        Fri, 27 Oct 2023 14:07:41 +0300
Date:   Fri, 27 Oct 2023 14:07:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light Sensor
Message-ID: <ZTuZ/Y2Go/RGOG7U@smile.fi.intel.com>
References: <20231027074545.6055-1-subhajit.ghosh@tweaklogic.com>
 <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 06:15:45PM +1030, Subhajit Ghosh wrote:
> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor with als
> and clear channels with i2c interface. Hardware interrupt configuration is
> optional. It is a low power device with 20 bit resolution and has
> configurable adaptive interrupt mode and interrupt persistence mode.
> The device also features inbuilt hardware gain, multiple integration time
> selection options and sampling frequency selection options.

Please, do not send so often this big patches (~1.5kLoC!), let reviewers a bit
of time, please.

Since I have my message postponed, I finish review on the v1, and I believe
100% of those comments will be applicable here.

-- 
With Best Regards,
Andy Shevchenko


