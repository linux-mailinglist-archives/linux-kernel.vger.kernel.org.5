Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5AE7FD566
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjK2LVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjK2LVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:21:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C054D1BC2;
        Wed, 29 Nov 2023 03:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701256883; x=1732792883;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=lrKRCLYE+lxEMvFvk2ubvXOvoDtEvu3r73T63mCHrvc=;
  b=lGmAOoue0tpniAQk7/ooEtRazqCL0wczrlypwFFZ7wZlUnBVsdjPS2Nj
   zwtvsDZRdoIgCs1nzh4WP0yq3YISnnSkep7jT3QmyWa/bw+Nu/popaIKe
   Q9qcdyKEcw/DBztsvUli1LJZyHfbSke2G+snQhmjn90k+Uwa3PaEDiHl3
   vc/lj/ybgvcAG4j4DC/NB47l91wG/Tkq/gIazezgK9LN3hxI68j8kIosm
   wuiIwXwcbi+S74fdDJFuf+vfKZWynOUlHHOPnl/wuDCfpUbixLVhOGZcP
   x3ioOk/XLQ7seoPuR44wPi1YSQxxg4BbDg55a0cip2xORdw4rQLc676r0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="479343912"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="479343912"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 03:21:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="762281083"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="762281083"
Received: from mpermino-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.33.123])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 03:21:21 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
In-Reply-To: <20231128194935.11350-1-francesco@dolcini.it>
References: <20231128194935.11350-1-francesco@dolcini.it>
Subject: Re: [PATCH v1] platform/surface: aggregator: fix recv_buf() return
 value
Message-Id: <170125687555.3606.16848036060218431083.b4-ty@linux.intel.com>
Date:   Wed, 29 Nov 2023 13:21:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 20:49:35 +0100, Francesco Dolcini wrote:

> Serdev recv_buf() callback is supposed to return the amount of bytes
> consumed, therefore an int in between 0 and count.
> 
> Do not return negative number in case of issue, when
> ssam_controller_receive_buf() returns ESHUTDOWN just returns 0, e.g. no
> bytes consumed, this keep the exact same behavior as it was before.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/surface: aggregator: fix recv_buf() return value
      commit: c8820c92caf0770bec976b01fa9e82bb993c5865

--
 i.

