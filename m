Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9742D7E8188
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345732AbjKJS3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346519AbjKJS04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:26:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA5449EF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699598492; x=1731134492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F3x6oX+rvafLRaso93FOquCeRAY97QKEk4cHD0f+V5E=;
  b=cbFGuf0ebHzXtBzZSJD/3nAfmGEh8SpfqgPe4WintYY+5y+pDTmGb/hm
   JFIEumNYJKg39u1C0KNqSCClC90/EHrGpXAjc8yCLwHAbiQD7vWPvqkmZ
   hCzwvJcMCL1k0hLgjiMEAbyaM8mK5NyNV0ianUPsBLiorjJVU2QKD8Sbk
   D0aPoiKgRCLzX7LOcDLK1wlXD0bW53GOc1P4MqdWSuyBN5iRCHn/eY3rT
   uRlt5pAaYivsZr7Hp/PKxAqU7WdfZMoANFFBPv4Cug57zbTjJey3a/0Wx
   N92WKy4Ny4sT0AFT5nXqQ9SNdN2FYug4BrJ6O5Sbh7RAlOnuEIa1KZaCi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="369467519"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="369467519"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 21:39:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="907378749"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="907378749"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Nov 2023 21:39:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id F3A0614F; Fri, 10 Nov 2023 07:39:17 +0200 (EET)
Date:   Fri, 10 Nov 2023 07:39:17 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] mtd: spi-nor: Stop reporting warning message when
 soft reset is not suported
Message-ID: <20231110053917.GH17433@black.fi.intel.com>
References: <20231108094303.46303-1-acelan.kao@canonical.com>
 <20231108094303.46303-2-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231108094303.46303-2-acelan.kao@canonical.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 05:43:03PM +0800, AceLan Kao wrote:
> From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> 
> When the software reset command isn't supported, we now stop reporting
> the warning message to avoid unnecessary warnings and potential confusion.
> 
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

Looks good to me, only small comment is that perhaps you want to update
the kernel-doc of spi_mem_exec_op() to mention that if the
driver/controller does not support reset it can return -EOPNOTSUPP.

In any case,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
