Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE3F7F26D6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjKUH7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjKUH7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:59:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE484CB;
        Mon, 20 Nov 2023 23:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700553581; x=1732089581;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jLywcSkJVeUVZAMXXk4GKRzHNS5GUGt7XyR9aAX8XtQ=;
  b=eIqFNRGh2rzHRCvmMM64QSesFBSPFlUsqra8ZICM74NVdHQJ3zXtVtiv
   /ZdAC1WZb1kf+EsK7QcJqWamO7hXbyvZ9QQPBbV9ZP61NBTHcfZsVbzdp
   0wCSnIv13rpUE9azoeSeLp1tNdXK1BxiJRiPChukwZym+/RM4K4quuKyG
   58AzzaWs7HtAkNLtC340GLWDbyOBaBc0rU7xyqES4UyHcPuRAIqE75i+a
   ltsJGIAfHRPODb+e/frHHEzGT28e+vbC1iOh46g3/NTp1Xku6hk4fci/D
   ELe0WvuXhw4uz8Cwo6MOvjMzEyOBkUoiFz1sa6dfuTqIevzFFrQ1hJ5rZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="456123241"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="456123241"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 23:59:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="742961606"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="742961606"
Received: from sbouradx-mobl.ger.corp.intel.com ([10.252.58.80])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 23:59:39 -0800
Date:   Tue, 21 Nov 2023 09:59:36 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        vadimp@nvidia.com, platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] platform/mellanox: Simplify bool conversion
In-Reply-To: <20231121005557.69324-1-yang.lee@linux.alibaba.com>
Message-ID: <4e9d19f-2a51-3286-5b48-ea3dd278c7d5@linux.intel.com>
References: <20231121005557.69324-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023, Yang Li wrote:

> ./drivers/platform/mellanox/mlxbf-tmfifo.c:94:41-46: WARNING: conversion to bool not needed here
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7584
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thank you for your patch.

This is already fixed by the commit 57eb82ff34e3 ("platform/mellanox: 
mlxbf-tmfifo: Remove unnecessary bool conversion") that is currently 
queued in pdf86.git/review-hans branch.

Also, next time write a better changelog, it's not enough to just quote 
an error message.


-- 
 i.

