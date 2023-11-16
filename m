Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D93E7EDCB0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344864AbjKPIMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjKPIMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:12:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3513519D;
        Thu, 16 Nov 2023 00:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700122358; x=1731658358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=kn6H7SmV8yOUusYhGUhruU7IfrbVntknA7QrIKEdOD4=;
  b=Oeh8+H9UYW+X83cLsKge1/fpNmJZMmJHUTmMogn0e60GsB7etZxdqNcY
   VydEa2RpfToFgqFTEtn/oUkyUTPaKWjXw3mraZVkI7ZfiaqMSyXUoDXPu
   lJSTZDz8/BOYE0B++4ZvLJv0NZW6jj9lglThYH5JoI400znGC9Xv2Jr2z
   +JLVZOQk0wJKFB/RJ/KeJtpiAjRZdSIkif67NttfB5fls80SXwpfWzTq3
   coFQEKZrx8qSmEz0/ZxnCqncS7JfWP4Y0YnBcG+loduBVWiKGWB+2TZSb
   7JAFGtHCcXrTcnFKhWOAmU80rzTuDm5d4q7kpBXLXAJ4GfR/Ic3WfSnnh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="389897555"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="389897555"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 00:12:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="6664192"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 00:12:22 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     bp@alien8.de, james.morse@arm.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org, rric@kernel.org,
        tony.luck@intel.com, qiuxu.zhuo@intel.com
Subject: Re: [PATCH v1 1/3] EDAC, pnd2: Replace custom definition by one from sizes.h
Date:   Thu, 16 Nov 2023 16:12:10 +0800
Message-Id: <20231116081210.89007-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231115154940.664664-1-andriy.shevchenko@linux.intel.com>
References: <20231115154940.664664-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ...
> 
> The sizes.h provides a set of common size definitions, use it.
> 

This patch LGTM. Thanks!

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/edac/pnd2_edac.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> ...
