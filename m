Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626497B78CB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241530AbjJDHde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbjJDHdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:33:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9242C98;
        Wed,  4 Oct 2023 00:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696404810; x=1727940810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VxsBh94/6HFHWLxU3WZGgHuTWLtLFHHNHDR9jDrMeXg=;
  b=JgGKNvHdOCesSQ6DjmAR7RywxahLuIJD1icqESXLvulIwHQSTpqKE0Eu
   rUSeHLjpo1bGl2oI4ZHJ2sQLebtIbzzJ8Zgs//OUnXUQ6p6IGRltW62nU
   96emRmC8xPVT1RgarKHUErcaBSnuzlEcyfRyT7JA2nQr9+tbIwUltf6Em
   g5l+xW+V69FJ6p/fA6JqnVqgLJhoJf1yRGhBpNnGIRLip5PEIhd2Ttru4
   d2uXNzy+JjRih2DjT243tbA4HaU9xKEy+OkxMWTE9DQp1q6ul62j5LHvo
   Zpe9ncPnWVI92SUo0S+lHTAadPth/e+zifxO1C/xw5KA7DlNY/orCFXAp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="386955055"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="386955055"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 00:33:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082363378"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="1082363378"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 04 Oct 2023 00:33:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3400D204; Wed,  4 Oct 2023 10:33:25 +0300 (EEST)
Date:   Wed, 4 Oct 2023 10:33:25 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 28/36] pinctrl: intel: use new pinctrl GPIO helpers
Message-ID: <20231004073325.GJ3208943@black.fi.intel.com>
References: <20231003145114.21637-1-brgl@bgdev.pl>
 <20231003145114.21637-29-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003145114.21637-29-brgl@bgdev.pl>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 04:51:06PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Replace the pinctrl helpers taking the global GPIO number as argument
> with the improved variants that instead take a pointer to the GPIO chip
> and the controller-relative offset.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
