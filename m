Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E638878EBC5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239697AbjHaLRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjHaLRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:17:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D17CFA;
        Thu, 31 Aug 2023 04:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693480619; x=1725016619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mHnMhORAN6ESyUeI0X3KU+KDJrXJu4+KoaEIxjPWmmE=;
  b=mPfn4yxz73VNHifEwK2FRg1pHOz34ifOc9fAsyp6knf1Q/E2+nHUhF/X
   ylKfUhtuxC7tmufiKVw+B8pAzXhcGFm76kNcf8XU63Z70Y/yOEoAhKEgd
   anUASrUeUIQVnGqVrPEEKtB/5r4HLkRGIIv25+mfHtaX6d3riJJgHGgZV
   Txev4yQKiX5N8ywfumbtWnBDMUNgaD5agldUEqrTwZ3+q1TLj3N2lgcYO
   MUv1RHD9DXlgvYeOrrf1rBc4Auw4IOyvb9hPHTRTA1MIGh/W6Sp9sVujT
   J5/eEUdMPXkaLDSS8JyhQESUVPUCXCHrt8XRlSvNXqu6R9QhmsA5rXTrm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="374817444"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="374817444"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 04:16:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="716303618"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="716303618"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 31 Aug 2023 04:16:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C694F3B5; Thu, 31 Aug 2023 14:16:55 +0300 (EEST)
Date:   Thu, 31 Aug 2023 14:16:55 +0300
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     David Binderman <dcb314@hotmail.com>
Cc:     "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Possible cut'n'paste error in linux-6.5/drivers/thunderbolt/tmu.c
Message-ID: <20230831111655.GP3465@black.fi.intel.com>
References: <DB6P189MB056829997A31D4B968AEA77C9CE5A@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DB6P189MB056829997A31D4B968AEA77C9CE5A@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 31, 2023 at 11:02:58AM +0000, David Binderman wrote:
> Hello there,
> 
> I just tried out static analyser cppcheck on linux-6.5. It said:
> 
> linux-6.5/drivers/thunderbolt/tmu.c:385:50: style: Expression is always false because 'else if' condition matches previous condition at line 383. [multiCondition]
> 
> Source code is
> 
>             if (tmu_rates[TB_SWITCH_TMU_MODE_LOWRES] == rate)
>                 sw->tmu.mode = TB_SWITCH_TMU_MODE_LOWRES;
>             else if (tmu_rates[TB_SWITCH_TMU_MODE_LOWRES] == rate)
>                 sw->tmu.mode = TB_SWITCH_TMU_MODE_HIFI_UNI;
> 

Thanks for the report. Indeed, this should be

             else if (tmu_rates[TB_SWITCH_TMU_MODE_HIFI_UNI] == rate)
                 sw->tmu.mode = TB_SWITCH_TMU_MODE_HIFI_UNI;

I will fix it up and send out after v6.6-rc1 is released.
