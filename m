Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7700175C2C9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjGUJR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjGUJR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:17:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E512D7E;
        Fri, 21 Jul 2023 02:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689931046; x=1721467046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=At/XX8D34+ZirskRZoM0gc4kR3O4x9uKb1Fn8SBafdU=;
  b=nwcxKHoQTB0j5aOqu+0IbJ3hzYr9grQPG8H9JeCtoJRGPdRoZ1rzUy8D
   0uP+d6S2Ikvynassncn00qyVSaqOm8+qT9t+PnKePS1UmaR87DejGfaVw
   oU/PsSPw8WTTuppxfNCwpLfr8VfXK5qVb2dGtKxEpjF6kcGiDBk60nLN6
   AOuoxx4c7ThZ5N3AR4+J4G8o6zkCFt+wy5GxmGHMGemqnXtkxsjAklLKa
   svd8tlfpvECAESVNM3XJZGsM6H/8PXdUjSZ2ehRwk/H2U/gLsaAz0qTHh
   JpftYiWIbfZvkR+aG8VKuHAlhDwYwZ3qJGu9DvpuWiY/gl2bDIKJWUP9q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="365870940"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="365870940"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 02:17:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="718751338"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="718751338"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 21 Jul 2023 02:17:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMmGI-00F8sC-1s;
        Fri, 21 Jul 2023 12:17:22 +0300
Date:   Fri, 21 Jul 2023 12:17:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Armin Wolf <W_Armin@gmx.de>
Subject: Re: [RFC PATCH v1] platform/x86: wmi: Do not register driver with
 invalid GUID
Message-ID: <ZLpNIsLrrQGWOQc/@smile.fi.intel.com>
References: <20230715211604.1272227-1-pobrn@protonmail.com>
 <ZLUOxnE58wUgZXWx@smile.fi.intel.com>
 <mL0s5ZsO3eU18EzO_7zVsawf2rr7o-zsOrwBDncazQIAgRn-LRNTGw2ugm1bfRoHKWTRYmUHt8s7zjfNEESapwFZlaNj6B041x_AZ-pagoI=@protonmail.com>
 <ZLUmh0nKJdRMmhX1@smile.fi.intel.com>
 <kN5iBK5RwAEr8LXNTgb6dUk7zxuGFFtF2q_ReNezksLqaq7C4frYfo6ELswUu0wVoewy3UENAwFjjK48d2qBwf6q4is8ST28zpK6-ze_eIU=@protonmail.com>
 <ZLjyDQ80QKWtKqUk@smile.fi.intel.com>
 <_szgAop-lIsQt90xoCYXQbiJtrQclFitfhE2ak2omTiPCx37toqB4lq7OTmBD_vMEn6TonpAns5NgVH1xFpGQLyuLkd0pOGwRqrB8C9INRw=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <_szgAop-lIsQt90xoCYXQbiJtrQclFitfhE2ak2omTiPCx37toqB4lq7OTmBD_vMEn6TonpAns5NgVH1xFpGQLyuLkd0pOGwRqrB8C9INRw=@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 10:42:29AM +0000, Barnabás Pőcze wrote:
> 2023. július 20., csütörtök 10:36 keltezéssel, Andy Shevchenko írta:
> > On Wed, Jul 19, 2023 at 07:23:37PM +0000, Barnabás Pőcze wrote:

...

> > Yes, that's what file2alias is for. We trust modules we build, right?
> > If you don't trust, then we have much bigger problem than this patch
> > tries to address.

> It seems we have to agree to disagree then.

I am confused. The parts are related to each other, you can't disagree on both.

You mean we have much bigger problem in the kernel or file2alias is the proper
place? I.o.w. which part you agree with and respectively disagree?

-- 
With Best Regards,
Andy Shevchenko


