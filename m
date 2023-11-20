Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEDE7F0FCE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjKTKGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjKTKGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:06:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BE8E5;
        Mon, 20 Nov 2023 02:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700474761; x=1732010761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0BdoP0B4O2vi17SpMZlY7kQXU0ZOHS8rzeAN7U7adNA=;
  b=cpigpYSU5YHSrkTeUFb5ZhNgRS3UlJrAzMx+DqIKfuNo4aW650KBxe39
   RfAk05Hcbisyr71+F0ocEI5IVYzCAFvujyxC7dxx7otS1QATeZul3hH6L
   jL4WOjzZAXhD9tAqkEJ4AJr97hv0uXQX3UbzC6lbUfHHHvum3sLzKE8YZ
   C2R7JlqdE8NvuEzlySE8wqxZ/VMQJ4Oe+CaNKJtAKB2Y0nkQp1PUA/Aha
   tXxzYe88wPomu6+FwN6disx3Xodr3/pbzcGwo3dECaOaSNmKf9uHWBH15
   fAutmcDOltmPJbjnVoXxrtQUxwnHqoo6rHwFDDPzLMn6885fQmMupjlxw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="371768021"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="371768021"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 02:06:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="1097710292"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="1097710292"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 20 Nov 2023 02:05:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 75BC324F; Mon, 20 Nov 2023 11:56:15 +0200 (EET)
Date:   Mon, 20 Nov 2023 11:56:15 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] gpio: tangier: simplify locking using cleanup helpers
Message-ID: <20231120095615.GA1074920@black.fi.intel.com>
References: <20231118072037.10804-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231118072037.10804-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 12:50:37PM +0530, Raag Jadav wrote:
> Use lock guards from cleanup.h to simplify locking.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
