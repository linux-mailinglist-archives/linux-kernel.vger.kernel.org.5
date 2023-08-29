Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF4D78CFD6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 01:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241050AbjH2XEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 19:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240656AbjH2XEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 19:04:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC1D1BE;
        Tue, 29 Aug 2023 16:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693350271; x=1724886271;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vXqICYnzaOqND5FKQagieBrPrd0aeYtrLg1HfahufbI=;
  b=a3+/2AHTQ889q1iiczg1drbrSxFt30FCYulK2dIitGT/gUxg8JI0HrcJ
   3MXKga3DTVSzyyN9zgbDRf+zWMth3Qpu26YnUW8u2zFfT1zseiZHzaDn6
   IImLy/Ik7fqLtmT9cxb1NVKV2bQJQmMzcyHFq4YgsrfkE0JvLqdCHIMSg
   eytfL6hu1agKN7RUbLE0rouNsNtMPslMvBuNRZh3ju6dpwJnkdcMvz1mg
   BLcgj42v3gQqyCx+76cM248VjEHi7APnvez6Ga6XrnXxbzmtQoDgB1Sw2
   XBa0okY4q3U6nf7GqRUbClZrCdG8qlAhGtppPFD6TvPkiwFaEDoJ901rS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="365703695"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="365703695"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 16:04:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="742014351"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="742014351"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 16:04:29 -0700
Date:   Tue, 29 Aug 2023 16:04:28 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] EDAC drivers
Message-ID: <ZO55fLRfOawcoxQt@agluck-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.6

for you to fetch changes up to ce53ad81ed36c24aff075f94474adecfabfcf239:

  EDAC/igen6: Fix the issue of no error events (2023-08-02 13:09:56 -0700)

----------------------------------------------------------------
Intel EDAC fixes:

- Old igen6 driver could lose pending events during initialization
- Sapphire Rapids workstations have fewer memory controllers than their
  bigger siblings. This confused the driver.

----------------------------------------------------------------
Qiuxu Zhuo (2):
      EDAC/i10nm: Skip the absent memory controllers
      EDAC/igen6: Fix the issue of no error events

 drivers/edac/i10nm_base.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 drivers/edac/igen6_edac.c |  8 ++++----
 2 files changed, 53 insertions(+), 9 deletions(-)

