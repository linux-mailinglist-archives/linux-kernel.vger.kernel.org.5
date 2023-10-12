Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749B17C7023
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347274AbjJLOMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbjJLOMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:12:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0358FD3;
        Thu, 12 Oct 2023 07:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697119963; x=1728655963;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=BkdmDpJuvdPA6uNP1YwON3CZnfQ7UiyWykOwjXTxAtU=;
  b=F67S1Y5i4ztojdOieGL7JY7P9/p6WsTcWsp6Armt71gf81gbGq0tl3jX
   TrV/TrlXdAUejsMBt0ahgSa9ZGAg9FGwByUJb/DFcGccH+aDNS+NkuKo0
   pC8pI6O/7C1WjTQ6iGuzfGz0eH62O8gb+EDxBFUtTby1srX/a1cZxav3b
   bIM/QkFmxw0FIKTuXn7kt/e6hWMwWBvtt2Yx3BWqepiEqCBw4nC3vp59h
   U8tmrOnF3ETejv7w4Oe+4isCdHe8DW1icyWLybe4vxXkZnuywAaizZGh3
   mfa8KPvfksLmMW9LVOjok38bzRDFGyN0VHTW5S4OIG10mQ7ut5EBGKVSf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="6485083"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="6485083"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 07:12:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="789430632"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="789430632"
Received: from nesterov-mobl.ger.corp.intel.com (HELO localhost) ([10.249.36.132])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 07:12:37 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?utf-8?q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Mark Gross <markgross@kernel.org>
In-Reply-To: <20231010134019.3892062-1-andriy.shevchenko@linux.intel.com>
References: <20231010134019.3892062-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 1/1] platform/x86: asus-wireless: Replace open coded
 acpi_match_acpi_device()
Message-Id: <169711995148.7227.4791108652615935564.b4-ty@linux.intel.com>
Date:   Thu, 12 Oct 2023 17:12:31 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 16:40:19 +0300, Andy Shevchenko wrote:

> Replace open coded acpi_match_acpi_device() in asus_wireless_add().
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

Once I've run some tests on the review-ilpo branch the patches
there will be added to the platform-drivers-x86/for-next branch
and eventually will be included in the pdx86 pull-request to
Linus for the next merge-window.

The list of commits applied:
[1/1] platform/x86: asus-wireless: Replace open coded acpi_match_acpi_device()
      commit: 5a026767275ef0ba6d7aba37629d9ec638aabb7d

--
 i.

