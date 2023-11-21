Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6844D7F2703
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjKUIMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKUIML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:12:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD2BBB;
        Tue, 21 Nov 2023 00:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700554325; x=1732090325;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=xm10E9XwcVC7evSjB+z0KYIglw8SKb7xS0u8qnauF5I=;
  b=OexhmRc6+JLlRv+54+TgZdEUSqVnWCD7mlETlD9UUsZGKFP1D40373MH
   1gylieDN7h+biTKxvg3OQQG/H5wPmBtZQlpLi5eJ34DE/5+/jWpa5kK4a
   8H3k8qTymPNDwgxfJvgSx4XOYMckF+Bg2/AQOiHJTTfyFHX2FXOPYP4XX
   uHQUYT3dy7HEK9HTpbEkLpuuVRm5nFO4GaDUOA1pmIOU0J/JZc18sWFL+
   fyjYDvffoChRAJI+0xWDO+Mtv9puL+plpKyRiIjdupMU9vzbOVBLsrekZ
   VXKabXiZJFsDeECunyQQEAqu5TY2hUszf0IcnjnEtlc8eAnTkBmsQRCww
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4984105"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="4984105"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 00:12:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="836978583"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="836978583"
Received: from wpastern-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.57.17])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 00:12:01 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20231120150756.1661425-1-andriy.shevchenko@linux.intel.com>
References: <20231120150756.1661425-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] platform/x86: intel_telemetry: Fix kernel doc
 descriptions
Message-Id: <170055431616.2004.12067704239482503222.b4-ty@linux.intel.com>
Date:   Tue, 21 Nov 2023 10:11:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 17:07:56 +0200, Andy Shevchenko wrote:

> LKP found issues with a kernel doc in the driver:
> 
> core.c:116: warning: Function parameter or member 'ioss_evtconfig' not described in 'telemetry_update_events'
> core.c:188: warning: Function parameter or member 'ioss_evtconfig' not described in 'telemetry_get_eventconfig'
> 
> It looks like it were copy'n'paste typos when these descriptions
> had been introduced. Fix the typos.
> 
> [...]


Thank you for your contribution, it has been applied to my local
fixes branch. Note it will show up in the public
platform-drivers-x86/fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: intel_telemetry: Fix kernel doc descriptions
      commit: a6584711e64d9d12ab79a450ec3628fd35e4f476

--
 i.

