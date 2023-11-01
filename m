Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F66C7DDCC0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345039AbjKAGhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 02:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbjKAGhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 02:37:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F380125;
        Tue, 31 Oct 2023 23:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698820607; x=1730356607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fThre7gCVecR9JTcgps+yggCPrYjaLTZuguhy2Dsewk=;
  b=RJ8+dXr2Z9f86rV7+uSze7XtqPIcWE6XP7iHwxMGwWmVo0aHoQDweFC3
   PK6OnUQ/ylN5zHfNRpL9vkqWTn7XNH36vHuOXJPTd/751V0ZMja7fOpLG
   GhM4JHi5KL8poxQo5woT/A/A2CqOAqQQ/JCp+vXIlgdNuhsidjRPEID6o
   VCoPaxIKIKhR0yiWgyWosgEjS4BybtZT/Yr0FyfW7nyBDi81nRAP5T8DY
   KByfU+9BvUWYyafxP/gilVCchIcx5Vcj15e9pMftG8sWAmmeaBDGFToLe
   gyJkvlZAzk4iddtav8ZZ73MiHdujX5xxbMezEKXnKeiAZEHxhjG+J8u9E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="387327045"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="387327045"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 23:36:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="795814109"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="795814109"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 31 Oct 2023 23:36:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A6DEF591; Wed,  1 Nov 2023 08:36:43 +0200 (EET)
Date:   Wed, 1 Nov 2023 08:36:43 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Refactor
 intel_pinctrl_get_soc_data()
Message-ID: <20231101063643.GE17433@black.fi.intel.com>
References: <20231030155906.3492801-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231030155906.3492801-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 05:59:06PM +0200, Andy Shevchenko wrote:
> Refactor intel_pinctrl_get_soc_data() to drop initial assignment
> of the data variable. It's only used in ACPI case and instead
> we may always assign it there as the ACPI ID table has the terminator
> entry that has driver data set to NULL.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
