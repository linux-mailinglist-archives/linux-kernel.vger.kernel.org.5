Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5557DCE14
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344621AbjJaNmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344561AbjJaNmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:42:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6250A9F;
        Tue, 31 Oct 2023 06:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698759767; x=1730295767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aJcpi54mkMrL0wdJC8MpLSy7I+gdOKYWH8wlzsQiXAI=;
  b=KLw0FFKk9Nf812PGKvbS1gYGeMnNrbGW1RY1t+nCzM3si+JEYbf1UMzE
   wasfcIQCoB5KOXo5GjmstJGq6++2Gfr4sBEpmJJ0Lq26eRiTGFuc6m2Wu
   i5Lo0bM0qHesBhPRrDfWDxIGxng3tu8dj9Ktn7zty9uEUf0FOmTCH8hmS
   q4n7dd4kO79EyMW52/isPQtsxp8E35YAvwHNz6DIuFHt07g7AMVIBip+c
   1z5a5Ez9dvxzBgBbemqsJTdik8OxxXvPqoIMvmgL08I+8gXFlLXFnQAym
   FDQE29DsAMPfgf/mS0Z+utWQ4vgVmfS8QZzvnja+gft0gcLNRsRlI0L3r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="391158031"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="391158031"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 06:42:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="737070285"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="737070285"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 06:42:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qxp0y-0000000A9sT-0EmV;
        Tue, 31 Oct 2023 15:42:40 +0200
Date:   Tue, 31 Oct 2023 15:42:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Gazzillo <paul@pgazz.com>,
        Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light Sensor
Message-ID: <ZUEET34K7AOkFf4A@smile.fi.intel.com>
References: <20231027074545.6055-1-subhajit.ghosh@tweaklogic.com>
 <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
 <20231028162025.4259f1cc@jic23-huawei>
 <84d7c283-e8e5-4c98-835c-fe3f6ff94f4b@gmail.com>
 <6a697c62-6a7c-4b31-bc8e-10f40db0363d@gmail.com>
 <d528b45c-123d-4ef7-b110-7efbfef91bc5@gmail.com>
 <ZUDZIEY_uTVMHh3C@smile.fi.intel.com>
 <b01930d6-5bec-496c-89de-6cf6d178c860@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b01930d6-5bec-496c-89de-6cf6d178c860@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 02:07:46PM +0200, Matti Vaittinen wrote:
> On 10/31/23 12:38, Andy Shevchenko wrote:
> > On Tue, Oct 31, 2023 at 09:11:37AM +0200, Matti Vaittinen wrote:
> > > On 10/30/23 12:21, Matti Vaittinen wrote:
> > > > On 10/29/23 17:51, Matti Vaittinen wrote:
> > > > > On 10/28/23 18:20, Jonathan Cameron wrote:

...

> > > 	tmp = gts->max_scale;
> > > 
> > > 	rem = do_div(tmp, total_gain);
> > > 	if (total_gain > 1 && rem >= total_gain / 2)
> > > 		tmp += 1ULL;
> > 
> > ...which is NIH DIV_ROUND_CLOSEST_ULL()
> 
> There is a difference though. The DIV_ROUND_CLOSEST_ULL() does
> 
> tmp + total_gain / 2;
> 
> before division - which in theory may overflow.

Then you can fix it there for everybody, no?

-- 
With Best Regards,
Andy Shevchenko


