Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275997D60FF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 07:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjJYFFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 01:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJYFFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 01:05:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AF0E5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 22:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698210313; x=1729746313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=htZwSr1yPfU4DAE0T3T5Cf6TY9qanaVYs1o0tVaq0Wc=;
  b=iKVqebevCLwqzVkj9dwmHNNAX8lgMEYXSRQC7kPMkswlQwlHOchgWA+U
   kjSeIm+bPLbsF8x4LNmZ/ZhdtsBtoouukuQeRdziLJPskJbVriozi5p4p
   vIpc77wih0/JuOmvQCMs1maaWvXLe3GQb4alOWO5m4io2YGXRCcsVosR6
   wUcb8u/UPRyEzeUMPdDW/4hWTBiFIKgDU0xJuf835m/q0f3d5DahQ7Oit
   16g7YklgLUQLr3fWpdApfb6DcT99wzE8YHOUxDaGtZq7EUYKlRdmTKKkr
   Qc78BUL0mN5MAMVp/tiE+z05lpH4QCuMFSXn4J6wBHr45bD1m1eYGSaWU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="367451383"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="367451383"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 22:05:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="882324731"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="882324731"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 24 Oct 2023 22:05:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0ADD5125; Wed, 25 Oct 2023 08:05:08 +0300 (EEST)
Date:   Wed, 25 Oct 2023 08:05:08 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mtd: spi-nor: Improve reporting for software reset
 failures
Message-ID: <20231025050508.GH3208943@black.fi.intel.com>
References: <20231025030501.490355-1-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231025030501.490355-1-acelan.kao@canonical.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 25, 2023 at 11:05:01AM +0800, AceLan Kao wrote:
> From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> 
> When the software reset command isn't supported, we now report it
> as an informational message(dev_info) instead of a warning(dev_warn).
> This adjustment helps avoid unnecessary alarm and confusion regarding
> software reset capabilities.
> 
> v2. only lower the priority for the not supported failure
> v3. replace ENOTSUPP with EOPNOTSUPP and check the first command only

In addition to Michael's comments, please put this version information
below the '---' line.
