Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96B87D5044
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbjJXMub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbjJXMuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:50:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A8F10D8;
        Tue, 24 Oct 2023 05:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698151818; x=1729687818;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UXnRqjyzjWzzZfjLxhQj7kQzPRXeZHU7gyF5jvqB5MM=;
  b=fJKIQgT6K16BNXFsn81MoTQDfYphZ1ZymJMNjQqs4LsMjuu2EI7V2yhX
   MjuiK2ADNJkOwb812N3XlXHoc0Gww7PZJ6bJh1KmunFf1V2giaDATDT2I
   cH4KFuj7cKdLjs7wDZGGBGP8RedLr0DD8/Pvzcrd6Fds5mfhjlUS0AkYW
   3M1tCcgFCFphnlImH4MJJHzx4sovmVid3v8vmEq3aHuJtwuTNGifsWcd9
   G8aJ2QtLUhNzbv+B3pIbfDuT63KlUmD//oyrjmWuHYqEz1G3xwrN9gKzR
   NstwZwCyoEDyQW3PfZSPiYJjQptPOOR4VrI1mHWdScN83rBlCxS7mcn8K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="5670832"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="5670832"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 05:50:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="762088386"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="762088386"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 24 Oct 2023 05:50:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4ADB4871; Tue, 24 Oct 2023 15:41:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH v1 0/3] serdev: Update a few places to use new APIs
Date:   Tue, 24 Oct 2023 15:41:12 +0300
Message-Id: <20231024124115.3598090-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inspired by the reviwing the patch by Tony Lindgren.

The first one makes a behavioural change on ACPI platforms where sysfs
entry will get firmware_node link in addition to what it has now.

Andy Shevchenko (3):
  serdev: Make use of device_set_node()
  serdev: Simplify devm_serdev_device_open() function
  serdev: Replace custom code with device_match_acpi_handle()

 drivers/tty/serdev/core.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

