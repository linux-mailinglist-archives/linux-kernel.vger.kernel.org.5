Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F379B80E931
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346161AbjLLKdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjLLKdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:33:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4889A0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702377217; x=1733913217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XeplGklgHLJxoovt/kg80zc3J0HsmV+8BKBRljb8r84=;
  b=lVKC+EaryuOTxBLhxuaFDjDfM2M8+KhSlaE/WFK/Xmzn5/4qk+JButUG
   TZHSIdinmQVY6sUsyULrcXQhWUN58G32Cjxqxk+hPGKgICcutycKHX9Zf
   fbWLQOyqAuONn+iSp1fEz7SHV8boHE3zDH8ThZtoW0yR4xT4yYFtQjcNB
   ai9nbejuBBv2tyINLtzMbG/dLqSYbwhVWzsUs0CFZAb9RY19wxBlUXTt2
   RUnffan1O/VGCrkVzuKpRhAd2XwPi/tvqCovRSvIkvcY43h39nH4cfUYK
   KUpFNZD2bVpV5+AFk+2GswLm2ZuvNyJ2RN/EPBmXX338X9enYrF4/Tw1Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="425910174"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="425910174"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 02:33:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="14912358"
Received: from adamjame-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.48.205])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 02:33:35 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9BC6710421C; Tue, 12 Dec 2023 13:33:31 +0300 (+03)
Date:   Tue, 12 Dec 2023 13:33:31 +0300
From:   kirill.shutemov@linux.intel.com
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     mingo@redhat.com, tglx@linutronix.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] x86/virt/tdx: Remove duplicated include in tdx.c
Message-ID: <20231212103331.pyuuz4ffve4g4zv5@box.shutemov.name>
References: <20231212003825.70297-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212003825.70297-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 08:38:25AM +0800, Yang Li wrote:
> The header files linux/acpi.h and asm/cpufeature.h are both
> included twice in C, so one inclusion of each can be removed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7713
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
