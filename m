Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11531810C76
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjLMIcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjLMIcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:32:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B31291;
        Wed, 13 Dec 2023 00:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702456375; x=1733992375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yOuFqDFHt/+ICo+bJ6KPeRzo2w2uLCAeNLAy7AYJyLc=;
  b=I3siDL0LP/BNgs/qXCNlrlAf9lEY6hZVGeP762/QupngrwuvP165Aa0Y
   ettCHHlhOOKyvy80lKTxw67f1zI4P62pC7KLVTfCvJVIriL719vRnhci1
   Gk6EwdBZG+ydNmoJcnGQTHrcxyG9u37VQLLBMqoOwiyxgQ0KEKXx/6A7b
   AEbsXm6tgi5e567Ahu7cG9blLa5MXQRcFVeTsgHH0e+NcBkN4d8qlAXFj
   jIJ/ET7T14Loxz8BzQq3bHd+Qi9Z2t/ZLyayFcwBnHAwGP+lNb0Z/6DLk
   6YRCIpMUElsAmruS6wmEXDLlbp6lZ1YyrWMA1j4TSG4yJVlFcKJ+GMZQ5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="461406817"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="461406817"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:32:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1105234999"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="1105234999"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:32:50 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 55A7611F7E4;
        Wed, 13 Dec 2023 10:32:48 +0200 (EET)
Date:   Wed, 13 Dec 2023 08:32:48 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] media: i2c: mt9m114: add CONFIG_COMMON_CLK dependency
Message-ID: <ZXlsMAgkqkGb4kVI@kekkonen.localdomain>
References: <20231212213625.3653558-1-arnd@kernel.org>
 <ZXlmnmGepRnMyNfr@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXlmnmGepRnMyNfr@kekkonen.localdomain>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 08:09:03AM +0000, Sakari Ailus wrote:
> Hi Arnd,
> 
> On Tue, Dec 12, 2023 at 10:18:04PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > With clang-16, building without COMMON_CLK triggers a range check on
> > udelay() because of a constant division-by-zero calculation:
> > 
> > ld.lld: error: undefined symbol: __bad_udelay
> > >>> referenced by mt9m114.c
> > >>>               drivers/media/i2c/mt9m114.o:(mt9m114_power_on) in archive vmlinux.a
> > 
> > Avoid this by adding a Kconfig dependency that avoids the broken build.
> 
> This sounds like an odd way to fix an issue with udelay(). On which arch
> does it happen? Wouldn't it be better to fix the udelay() problem in the
> source?
> 
> A quick check reveals there are about 2400 files using udelay.

After discussing with Tomi, I think the driver could be improved, too, by
adding checks for clock frequency and avoiding an obvious potential
division by zero if clk_get_rate() happens to return 0. Switching to
fsleep() would probably address the Clang 16 issue, but that doesn't seem
to be the primary cause here anyway.

-- 
Sakari Ailus
