Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B54F7DC280
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 23:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjJ3WcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 18:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjJ3WcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 18:32:07 -0400
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1744FFE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 15:32:04 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698705122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dX/CNNGfQ6c5dPpCwI6UOaZajkT8HSm2ODmF0tBLXhk=;
        b=uScaisRtxc5f6AxWz0R5aDz611fTWv469IFtr/9dW7S9xusx288MD3RyerH5qDTRPO8jya
        Z+arpJXjJIjVI45nX2tmbTlrMkHzZPjDNkvS28ac0RLP3wwWOH6SEd2afXdlWwhrDPAFwH
        pj0kFs68VWruzszKBSMnFDwo6/ea56I=
From:   andrey.konovalov@linux.dev
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: raw-gadget: update documentation
Date:   Mon, 30 Oct 2023 23:31:58 +0100
Message-Id: <20231030223158.36636-1-andrey.konovalov@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@gmail.com>

A recent patch added reporting of more event types to Raw Gadget.

Update the documentation to reflect that this feature has been
implemented.

Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 Documentation/usb/raw-gadget.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/usb/raw-gadget.rst b/Documentation/usb/raw-gadget.rst
index 818a1648b387..59b2132b584d 100644
--- a/Documentation/usb/raw-gadget.rst
+++ b/Documentation/usb/raw-gadget.rst
@@ -81,9 +81,6 @@ feature must be kept in the implementation.
 Potential future improvements
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- Report more events (suspend, resume, etc.) through
-  ``USB_RAW_IOCTL_EVENT_FETCH``.
-
 - Support ``O_NONBLOCK`` I/O. This would be another mode of operation, where
   Raw Gadget would not wait until the completion of each USB request.
 
-- 
2.25.1

