Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1314B7786D2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjHKFCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHKFCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:02:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F129171D;
        Thu, 10 Aug 2023 22:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691730153; x=1723266153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yZkbFxlPlO5GCkzmyGVYAdzSWYDSBeKIWLfwTVDKm/g=;
  b=jfQLbRnNaKFiO0w96IW7Lau5IDasff7smJ4isRBqyPGasvfMQ82ygkUo
   GBsvaTDaBunvb3gyqLJ3vrrIFjDBM8X+U3EqxknX1YTPsWhktWE2dayIY
   o7wR8cgU7jBGNKiKtKW2DNYLpjuvTRh9rm04hoikb68hBEefGQe4FVkRT
   6dKOwLIgnM4woseKcUw4nIeR6trBZjfJrAHgO+veWegoJvCZBCRLKGixY
   k01TB8pMxVqC/mHQQwkvCYlDaUjnkvWI2eDCf3owH+7fcEmgh10DfP1yG
   HHJS7Dp16ImqRVtBd/wIFIgG85izMuaNF5e4sbpmV3di6jil3BpB8HeOh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="371603764"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="371603764"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 22:02:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="797873282"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="797873282"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 10 Aug 2023 22:02:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D335D1D9; Fri, 11 Aug 2023 08:07:28 +0300 (EEST)
Date:   Fri, 11 Aug 2023 08:07:28 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Alexander Ofitserov <oficerovas@altlinux.org>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] pinctrl: tigerlake: Add Alder Lake-P ACPI ID
Message-ID: <20230811050728.GV14638@black.fi.intel.com>
References: <20230810115938.3741058-1-oficerovas@altlinux.org>
 <20230810115938.3741058-5-oficerovas@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230810115938.3741058-5-oficerovas@altlinux.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 02:59:38PM +0300, Alexander Ofitserov wrote:
> Intel Alder Lake-P has the same pin layout as the Tiget Lake-LP
> so add support for this to the existing Tiger Lake driver.

Isn't it the same as Alder Lake-N so this ID should be added to the
pinctrl-alderlake.c instead? Andy, do you know?
