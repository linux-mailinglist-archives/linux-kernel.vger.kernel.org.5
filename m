Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0174E7E80D9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345709AbjKJSTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346175AbjKJSQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:16:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A56C37AF9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 05:48:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E63DC433C8;
        Fri, 10 Nov 2023 13:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699624095;
        bh=pZ8aJuV2KsVuZiJJPUJVNZcJ8el4lhhalq2w7PkrUTo=;
        h=From:To:Cc:Subject:Date:From;
        b=W/krW53+BRT4JGtLpBr/mvjqVWq/HeHSW3CWLLU2YXXobeSJErYVhIR+0Fo5phhZH
         J4bpH/qH4etORqvKrXNo068V+oWzF+E64/mBvzUyVGJlU98Ry2ZoT8VYA1Sp5VzdeX
         dlLSEZVOf+GvWYjbznn750a/9SpB6BXdfXuH4PsTi1jwWENcV+MaW+GOI/cbBNAU7L
         ITvEUqraOEAS6hKbor+6W8zO+WdXmYsGYNUG2m6qq1aAT4DtDa/RxTocbiAT6MMjxL
         ciPBHSa43/qzSB7sfkyCwJN+7SpCPw0oBx26Pfd2yOfwekyXiNNCJozTGJKza93RFB
         8FsmrF9WY5KnA==
Received: from johan by theta with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r1Rrl-0008LS-2n;
        Fri, 10 Nov 2023 14:48:09 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] dt-bindings: usb: hcd: add missing phy name to example
Date:   Fri, 10 Nov 2023 14:48:02 +0100
Message-ID: <20231110134802.32060-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example host controller node has two PHYs and therefore needs two
PHY names.

Fixes: 3aa3c66aedef ("dt-bindings: usb: Bring back phy-names")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/usb/usb-hcd.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-hcd.yaml b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
index 692dd60e3f73..45a19d4928af 100644
--- a/Documentation/devicetree/bindings/usb/usb-hcd.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
@@ -41,7 +41,7 @@ examples:
   - |
     usb {
         phys = <&usb2_phy1>, <&usb3_phy1>;
-        phy-names = "usb";
+        phy-names = "usb2", "usb3";
         #address-cells = <1>;
         #size-cells = <0>;
 
-- 
2.42.1

