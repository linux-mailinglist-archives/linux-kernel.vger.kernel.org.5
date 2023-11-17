Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C034D7EF4B6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjKQOrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKQOrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:47:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3D6C5;
        Fri, 17 Nov 2023 06:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700232417; x=1731768417;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ohmm8kuM0bdZm1zqRDYoY/cwWBn4FwK09Yp3KMlSNXQ=;
  b=OH0ECwki3jQgzlTD4gfl+13JlEgGWVd+H93lK6A1QprQ78BeJ/waMjvr
   aCuphsaYNR17hioFeBtV7sOQKb/KFceY7mPEoCMCg0KFGPcHNz8j+0RWz
   SNYgFZQu1zgiWy7/CreVC97eZ1KiZgPYAuwmw0M/3h06Izs1myOK9zPEt
   h44II9yVfSlewbkWywN6RQ2qdUT7wA0/NaaY8b7cf+SOGGjCp5Spq7flf
   pjjTRKRZzj37MflPIvv31aBzrQqc7RvV7nZiyM9rBFGQ5llkA9GHMnC+3
   dTGLZ0ylOxAK+nW07Ktl+YIqzLFStK43XglszUOMhpjMGi6EcBqu/GdeI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="477523737"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="477523737"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 06:46:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="715552644"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="715552644"
Received: from unknown (HELO [10.237.72.75]) ([10.237.72.75])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2023 06:46:53 -0800
Message-ID: <552aec2a-7f95-460e-b3e4-44a94f32b15a@linux.intel.com>
Date:   Fri, 17 Nov 2023 16:46:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/25] i2c: designware: Rename dw_i2c_of_configure() ->
 i2c_dw_of_configure()
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>
References: <20231110182304.3894319-1-andriy.shevchenko@linux.intel.com>
 <20231110182304.3894319-15-andriy.shevchenko@linux.intel.com>
 <f92f670d-11a0-4ff5-944c-d5809588b1e7@amd.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <f92f670d-11a0-4ff5-944c-d5809588b1e7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 21:39, Mario Limonciello wrote:
> On 11/10/2023 12:11, Andy Shevchenko wrote:
>> For the sake of consistency, rename dw_i2c_of_configure() and change
>> its parameter to be aligned with the i2c_dw_acpi_configure().
>>
>> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/i2c/busses/i2c-designware-platdrv.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
