Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487F47D7E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjJZIjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjJZIjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E92210E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698309509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BGnModyxxabVDouEDH7V4XE5H33aX5s1L3RuIOlJgco=;
        b=ZAKd3PktT5GhgonRYBfcRIsjPWyos40ZZbvEke+eU831bcxhbL4GtahGhZ54nNlUX+Ddt8
        n4DFMtB5Pc8dbpgV+BswKquCgDmVYJAYtP553Cyb+kxRmgTCl/wLMbt10e9bjSSlL/Z5z4
        0ceZFrXcraunS4hR8tAP2ifOTO1bchc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-qldHcjaqPfG72UpL-PRVFg-1; Thu,
 26 Oct 2023 04:38:26 -0400
X-MC-Unique: qldHcjaqPfG72UpL-PRVFg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B2F61C07244;
        Thu, 26 Oct 2023 08:38:25 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9BC671121319;
        Thu, 26 Oct 2023 08:38:23 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH iwl-next] i40e: Remove AQ register definitions for VF types
Date:   Thu, 26 Oct 2023 10:38:22 +0200
Message-ID: <20231026083822.2622930-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i40e driver does not handle its VF device types so there
is no need to keep AdminQ register definitions for such
device types. Remove them.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_register.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index d561687303ea..2e1eaca44343 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -863,16 +863,6 @@
 #define I40E_PFPM_WUFC 0x0006B400 /* Reset: POR */
 #define I40E_PFPM_WUFC_MAG_SHIFT 1
 #define I40E_PFPM_WUFC_MAG_MASK I40E_MASK(0x1, I40E_PFPM_WUFC_MAG_SHIFT)
-#define I40E_VF_ARQBAH1 0x00006000 /* Reset: EMPR */
-#define I40E_VF_ARQBAL1 0x00006C00 /* Reset: EMPR */
-#define I40E_VF_ARQH1 0x00007400 /* Reset: EMPR */
-#define I40E_VF_ARQLEN1 0x00008000 /* Reset: EMPR */
-#define I40E_VF_ARQT1 0x00007000 /* Reset: EMPR */
-#define I40E_VF_ATQBAH1 0x00007800 /* Reset: EMPR */
-#define I40E_VF_ATQBAL1 0x00007C00 /* Reset: EMPR */
-#define I40E_VF_ATQH1 0x00006400 /* Reset: EMPR */
-#define I40E_VF_ATQLEN1 0x00006800 /* Reset: EMPR */
-#define I40E_VF_ATQT1 0x00008400 /* Reset: EMPR */
 #define I40E_VFQF_HLUT_MAX_INDEX 15
 
 
-- 
2.41.0

