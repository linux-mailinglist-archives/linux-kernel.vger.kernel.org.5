Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB8F76EE34
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbjHCPei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237162AbjHCPee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:34:34 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7575C3582;
        Thu,  3 Aug 2023 08:34:29 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,252,1684767600"; 
   d="scan'208";a="175498302"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 04 Aug 2023 00:34:26 +0900
Received: from localhost.localdomain (unknown [10.226.93.128])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6B58E4008496;
        Fri,  4 Aug 2023 00:34:21 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     tony@atomide.com
Cc:     andriy.shevchenko@intel.com, andriy.shevchenko@linux.intel.com,
        bigeasy@linutronix.de, d-gole@ti.com, gregkh@linuxfoundation.org,
        ilpo.jarvinen@linux.intel.com, jirislaby@kernel.org,
        johan@kernel.org, john.ogness@linutronix.de,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        oliver.sang@intel.com, vigneshr@ti.com,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 1/1] serial: core: Fix serial_base_match() after fixing controller port name
Date:   Thu,  3 Aug 2023 16:34:17 +0100
Message-Id: <20230803071034.25571-1-tony@atomide.com> (raw)
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230803071034.25571-1-tony@atomide.com>
References: <20230803071034.25571-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> While fixing DEVNAME to be more usable, I broke serial_base_match() as the
> ctrl and port prefix for device names seemed unnecessary.

> The prefixes are still needed by serial_base_match() to probe the serial
> base controller port, and serial tx is now broken.

> Let's fix the issue by checking against dev->type and drv->name instead
> of the prefixes that are no longer in the DEVNAME.

> Fixes: 1ef2c2df1199 ("serial: core: Fix serial core controller port name to show controller id")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202308021529.35b3ad6c-oliver.sang@intel.com
> Signed-off-by: Tony Lindgren <tony@atomide.com>

This patch fixes the boot issue on RZ/G2L SMARC EVK since yesterday.

Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
