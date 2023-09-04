Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C052379145B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349232AbjIDJIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347691AbjIDJIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:08:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F310A18D;
        Mon,  4 Sep 2023 02:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693818510; x=1725354510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WseQe2DyGEA2l5F/Om99p4bQ5IVu+0O9Vfzw0M0smzw=;
  b=S65++Atb9n/mBBlyfqJZc4hb50gAEVhoOE1YOLNDTrLnAXKaFR7PX9H4
   DgLsVoAC0jr2+LUxjsJDpTiOhuYxKeFXRAn/VgCazGR+7gTnTASvFwuhV
   Ohm3zXkxMU7VSDaaYRQuH0tEDKnrL6lnYmKF+WEecod4NU1tqfZdF55se
   XXz0N/l5sw1+gtQAOO52Q+yNkblqHNpALnQce4aGJZAsjFiD4tlma4vMU
   z9b0tkVSmRuyz5PxL4FDfpnBNlaZ94E4MxKJ1Pl+muT28cvKg3TIMHD7I
   I0KmwbaQUmbw7/ZPKHpun/dFNRdHceiw0uwBiceRUMlkpvTtH67sYiakG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="462923173"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="462923173"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:08:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="806183798"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="806183798"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:08:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd5ZK-006Nj3-07;
        Mon, 04 Sep 2023 12:08:26 +0300
Date:   Mon, 4 Sep 2023 12:08:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH] pinctrl: cy8c95x0: Simplify probe()
Message-ID: <ZPWeicmYLUTgvGpm@smile.fi.intel.com>
References: <20230902082225.8777-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902082225.8777-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2023 at 09:22:25AM +0100, Biju Das wrote:
> Simpilfy probe() by replacing device_get_match_data() and id lookup for

ID

> retrieving match data by i2c_get_match_data().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I can test it at some point, but I don't see the point to failure,
so I consider the priority is low for that.

Easier to me to test when it lands Linux Next, which I can run without much
effort on the Intel Galileo Gen 1 board (with this chip connected).

-- 
With Best Regards,
Andy Shevchenko


