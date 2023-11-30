Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88247FEE4F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjK3L4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjK3L4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:56:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B311884;
        Thu, 30 Nov 2023 03:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701345367; x=1732881367;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=X8cOIal6ZAAKvog0KBY4YFXu6vaFlgNpBf7VJckMNyw=;
  b=T2O25keQ5O77t0cQRhKXh8PtVY9CrLy2mfGzyzX/R73KW7ShRv25lcH7
   g9FeyTifwIxpbrCFJq3PWmfZGMG/rHNOfw20jV8TX7LNwNnb8DESc2Hc8
   yXCvvnMJ/0ga0f6xIAKcUMAfASRL5UwGkQyCxs2uZCXF18jb5yaUBaLDS
   7WEwIPXDkbba4a5qmnJHIyJxeIxt3kQ8OgntGeJT9Q6T5XuGcqfzGHgn3
   uoHukTdXA4eGeZ4GTsCp2uERjNLji7IW45+OJi/KiDW4cf1CtCA4iMrFJ
   PJiNpAFS1MGUz8H45oaqJglrOGWy6DQ/WZIRfiZGKYxUpvCdp+86/rxnN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="392177846"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="392177846"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 03:56:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="1016610155"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="1016610155"
Received: from sprenzel-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.222.26])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 03:56:05 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     hdegoede@redhat.com, Armin Wolf <W_Armin@gmx.de>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231129181654.5800-1-W_Armin@gmx.de>
References: <20231129181654.5800-1-W_Armin@gmx.de>
Subject: Re: [PATCH v2] platform/x86: wmi: Skip blocks with zero instances
Message-Id: <170134535986.1693.13811439093104640324.b4-ty@linux.intel.com>
Date:   Thu, 30 Nov 2023 13:55:59 +0200
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

On Wed, 29 Nov 2023 19:16:54 +0100, Armin Wolf wrote:

> Some machines like the HP Omen 17 ck2000nf contain WMI blocks
> with zero instances, so any WMI driver which tries to handle the
> associated WMI device will fail.
> Skip such WMI blocks to avoid confusing any WMI drivers.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: wmi: Skip blocks with zero instances
      commit: cbf54f37600e874d82886aa3b2f471778cae01ce

--
 i.

