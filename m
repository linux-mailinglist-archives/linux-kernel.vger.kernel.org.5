Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DB47CA97A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjJPNcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbjJPNbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:31:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107EB182
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697463103; x=1728999103;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bzMvMJjnGiiY1tM8g8jsB2bJw5N/7agfEBwKFWzfcTA=;
  b=fR/ViX6doqVWmByxG8PBlCLDW5k2yd177RBc89Zj6TiFea0FlLGRJNIB
   KNy4b/UbLEQhuEoKvaF9MaxpRk513wbOPzMltiEW1RYXalFYt/QWMD4lD
   gyLA18v36UDUTBXq5qsHiLMXi0hd2+/PTglXPw5n8V3go+BRlb4YwNLFS
   wXTWOLOielH4Zhfd+9db3ZL3Q2ysY66lP3inUFwslRBJ5JL+pLI30tEOY
   kTieBrcIj/s1gEP13wRKhYKlTWAe1lIQpBAWHW+/sBykh6fVV/+SDDV24
   XWcIw8eTS4+dvC2zJ41OIWbL6qi5/Vr2Ctq2RCz6zwPXTqtAKQ1DhcfTO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="375892100"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="375892100"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 06:31:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="1002934886"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="1002934886"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 16 Oct 2023 06:31:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 315A211D; Mon, 16 Oct 2023 16:31:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Joel Granados <j.granados@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [resend, PATCH v1 0/3] parport: Switch to some modern APIs
Date:   Mon, 16 Oct 2023 16:31:32 +0300
Message-Id: <20231016133135.1203643-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a set of ad-hoc refactorings and cleanups to the parport driver.

In v1,resent:
- resent with Greg KH in Cc list

Initial contribution have been seen here 6 weeks ago:
https://lore.kernel.org/r/20230901134250.1172990-1-andriy.shevchenko@linux.intel.com

Andy Shevchenko (3):
  parport: Use kasprintf() instead of fixed buffer formatting
  parport: Use list_for_each() helper
  parport: Drop unneeded NULL or 0 assignments

 drivers/parport/procfs.c | 53 +++++++---------------------------------
 drivers/parport/share.c  | 25 ++++++++-----------
 include/linux/parport.h  |  2 --
 3 files changed, 19 insertions(+), 61 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

