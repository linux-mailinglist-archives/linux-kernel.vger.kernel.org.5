Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5087DDCB2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbjKAGeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 02:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345112AbjKAGdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 02:33:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59B0F4;
        Tue, 31 Oct 2023 23:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698820427; x=1730356427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cMmKwnOvQvzXPtg3T8Np6CB+ddphWJtLH2DhM/pDklc=;
  b=XGc2u4eTr6ZYf0fWNVPldi8GWCuy0S6L2EA3YCIYupjs1Kb/qAA9+ATc
   kTP9wNzsM4ly49l0VLftTnzmXn8U5ekm0yv8h+C9Y/iV/72a1yI6l/Z3/
   jivaQUoCISfxM8AEahUZpueaCQRfh19YsAMaujYvfPKeNSKezFpHE2nbQ
   tHwBfLdzFBupOvL1hg9vkKAYxNOE0JU80b8rqrb936zeY6/9koiTgfk3b
   BATDS2hhaqlAs5RY/YIKK4LvaQ+7IFu3o1D7qrG0h7HO5ZIEuV7ZWdgkx
   wuSpPw4gFBiUGgtQvw3zeuzaDT/bctZo1dVbOuiuS9MeH6fQ7AhDvcFkn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="452730971"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="452730971"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 23:33:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="851483411"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="851483411"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Oct 2023 23:33:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3744B54A; Wed,  1 Nov 2023 08:33:40 +0200 (EET)
Date:   Wed, 1 Nov 2023 08:33:40 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Raag Jadav <raag.jadav@intel.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: tangier: Enable 910 Ohm bias
Message-ID: <20231101063340.GB17433@black.fi.intel.com>
References: <20231030141404.3242102-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231030141404.3242102-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 04:14:04PM +0200, Andy Shevchenko wrote:
> Family 7 (I2C) supports special bias value, i.e. 910 Ohm.
> 
> Enable it for configuring pin.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
