Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82837F6173
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345775AbjKWO2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345736AbjKWO2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:28:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F058AB9;
        Thu, 23 Nov 2023 06:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700749699; x=1732285699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XLAZfxCJx9i3M+lTjWT8waPS+sPI734OcLBi9WVbsM4=;
  b=StxfxrCIIRWkiL25HVPIyK+qGu9Lfv+2tB1WW3ZYGMYB1KuGUtwGg2W8
   q4RV8P2V4DQEbgzTwK5NiwQrcoFgyOwsmO5drgHrz2Kau+Q9tbqIQ9GCc
   dDM8u/TRcMrIeY2MKjvLw5VsHzDKOCXUB1Nz5uvIaIuXSiV6MbbzEVm2k
   nuoPo/Nhe1ftpdFhD+FIqHdFAvnlHYIMG2uy7OvI7rWI3X+DeW87NrDFN
   9gc8hozTvKbW1BRvLe1a9XpgDtRjRSECYq4Si6PuqMiB3T3ooFUIdmiox
   +h3f9Lnp1jKkKtYlGzb3YjRgAdzFO/Ado2GddtE+//p4ukHbmdtVnTAUn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="478474726"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="478474726"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 06:28:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="1014642713"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="1014642713"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 23 Nov 2023 06:28:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0CDCA387; Thu, 23 Nov 2023 16:28:16 +0200 (EET)
Date:   Thu, 23 Nov 2023 16:28:16 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pinctrl: tangier: simplify locking using cleanup
 helpers
Message-ID: <20231123142816.GE1074920@black.fi.intel.com>
References: <20231123140212.12135-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231123140212.12135-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 07:32:12PM +0530, Raag Jadav wrote:
> Use lock guards from cleanup.h to simplify locking.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
