Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D20E7825A3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbjHUIis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjHUIiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:38:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFDECD;
        Mon, 21 Aug 2023 01:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692607087; x=1724143087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zOJg0d1CLejbRhwfPLo/bKpaBzBoG/QHB8TE91t3uOw=;
  b=WK4HReo4p9XRQt+90912+qlJ5fYo7rR1GrJx0g1WBD8xIt0VUuYFXraL
   1MhtByVp/1e7AkKFLBmL6+eEPOHMmXZV591/VzW5YVb8wdPCse+R9UH85
   zvgjOhP/RjKPVCL5GsHg59f7qMl4vDXmgX9dWbSQvPST3QXR5KKchrGyH
   LQMD2nOvwsIDmKuHYXmRiZcHrMIhFmYE+tK32Mpdchpa8FlB8OMnu+Auj
   +yETsTbn7DqJURHOcC/fv+ASDatP7mHFAQIufIufIdOebxOEKkRVLf1RR
   VxzNWzg7SXv1vPHrP4Hl7FJjuT7tJjyoTfxmIcnBMUfHVf49kOpnHJmKV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="404537308"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="404537308"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 01:37:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="770862015"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="770862015"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 21 Aug 2023 01:37:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 72EC61A5; Mon, 21 Aug 2023 11:37:38 +0300 (EEST)
Date:   Mon, 21 Aug 2023 11:37:38 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v1] pinctrl: cherryview: use ACPI_HANDLE() to pass handle
Message-ID: <20230821083738.GI3465@black.fi.intel.com>
References: <20230821063002.29807-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821063002.29807-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 12:00:02PM +0530, Raag Jadav wrote:
> Use ACPI_HANDLE() to pass handle to acpi_*_address_space_handler() APIs.

Please explain here that this actually fixes a bug on the remove path
where we pass an incorrect pointer. Please adjust the $subject
accordingly.

> Fixes: a0b028597d59 ("pinctrl: cherryview: Add support for GMMR GPIO opregion")

Add also Cc: stable@vger.kernel.org
