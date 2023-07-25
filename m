Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582D2760A69
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjGYGi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjGYGiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:38:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616EBE51
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:38:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA5F361556
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D07C433C8;
        Tue, 25 Jul 2023 06:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690267101;
        bh=XVaMzrnP3e0s+YG7IJaZvLLZmDNtN/6Ng+xTO1VOHus=;
        h=From:To:Cc:Subject:Date:From;
        b=ZB0dcWl7ZbcL8eP0ReyKFctR0PbuZkJvGJFub9vM3Ht1GVNdRaUlrG/Lbk/zWLuL3
         omHGjrJ2AOA3PXAOu0ebcW0ZJ9vKZpV9ttv75f1WhLcCBIVVbsN7QeL1V8HCXNG3RK
         PcPayd65CzSN04otaoqo8T3NuSc7fy0GuUKqdkJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] Documentation: embargoed-hardware-issues.rst: add AMD to the list
Date:   Tue, 25 Jul 2023 08:38:15 +0200
Message-ID: <2023072514-submersed-yanking-652e@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Lines:  29
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=XVaMzrnP3e0s+YG7IJaZvLLZmDNtN/6Ng+xTO1VOHus=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn7c6/9U53WuOu3SqjZoVhhzl+KbNW3GGYv2qFTauE9z YMzeatnRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEzk5m6GeWqxcVr3W17kLF+V wv/LNmnXtUsmaxgWNCjzXjiz0WY9x0+lonf/JneY3fafCwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AMD back to the embargoed-hardware-issues.rst list.  There was
confusion about a recent issue that ended up being due to third-party's
misrepresentation, not AMD, so add AMD back to the list to get notified
properly as they understand the proper procedures to follow.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: properly sign the patch when sending it to the mailing lists so it
    can be validated as coming from me.

 Documentation/process/embargoed-hardware-issues.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index 81a8fb0862a4..cb686238f21d 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -244,6 +244,7 @@ disclosure of a particular issue, unless requested by a response team or by
 an involved disclosed party. The current ambassadors list:
 
   ============= ========================================================
+  AMD		Tom Lendacky <thomas.lendacky@amd.com>
   Ampere	Darren Hart <darren@os.amperecomputing.com>
   ARM		Catalin Marinas <catalin.marinas@arm.com>
   IBM Power	Anton Blanchard <anton@linux.ibm.com>
-- 
2.41.0

