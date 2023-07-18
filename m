Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF5D7571C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 04:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjGRCa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 22:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjGRCa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 22:30:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD00EC;
        Mon, 17 Jul 2023 19:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689647455; x=1721183455;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xz8CuI8h6uFvALg90e1Lg/ANKsMy8lnCqHJ4186y3vA=;
  b=kBaWiU3DY4zQWvf6UcYb5QQs+XtOe3yh1pqbOQAfcOq6vARh5hy9fqv9
   U1+okv1pd/raH+oKllyz0Gw8QH1eibvG2iQGJm2k29VOqrPbRkoHX4xmR
   azoX14kApZQLM0IMw3jXRPicVMJRQMDMAljCq8lZoS2Jxg1tO74EREtz+
   7tcoH5DcvttOgtrhZokwTPOIQbfaEwd9c+HMB30PLBHBDNJB7m54Wrj+J
   zF+lfj3BCwz3kUYdH93jEwAIETQIDA6Q41E43qx08LY5w+ONDnmYdLMyG
   UoA/25d+4p/0S/gxBoxho7PE77fY8U17L/qRvQiAvT+8/02KYg3RCuohy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="452467239"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="452467239"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 19:30:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="726760894"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="726760894"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.223])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jul 2023 19:30:54 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        bleung@chromium.org
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v4 0/2]Add support to configure active retimer cable
Date:   Mon, 17 Jul 2023 19:47:01 -0700
Message-Id: <20230718024703.1013367-1-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds support to configure retimer cable type

Changes in v4:
- Removed local variables and used inline assignemtns.
- Added details about return values in cros_typec_get_cable_vdo.

Changes in v3:
- Changed the return method in cros_typec_get_cable_vdo.
- Changed passed parameters in cros_typec_get_cable_vdo.
- Corrected definition for unsigned integers as kerenl standard.
- Assigning cable_vdo values directly in to cable_mode.
- Removed unncessary checks for Retimer cable type.

Changes in v2:
- Implemented use of cable discover mode vdo.
- Removed adittional changes to host command.

Utkarsh Patel (2):
  platform/chrome: cros_ec_typec: Configure Retimer cable type
  usb: typec: intel_pmc_mux: Configure Active and Retimer Cable type

 drivers/platform/chrome/cros_ec_typec.c | 28 ++++++++++++++++++++++++-
 drivers/usb/typec/mux/intel_pmc_mux.c   | 28 +++++++++++++++++++++----
 2 files changed, 51 insertions(+), 5 deletions(-)

-- 
2.25.1

