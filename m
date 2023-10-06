Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD447BB667
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjJFL1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjJFL1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:27:05 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1999AC5;
        Fri,  6 Oct 2023 04:27:04 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.west.internal (Postfix) with ESMTP id 0AAFC3200ACB;
        Fri,  6 Oct 2023 07:27:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 06 Oct 2023 07:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bearcove.net; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1696591622; x=1696678022; bh=DfsU3izUar
        c3urIWoQV9VaCFxzhD45N7hVfrg6KIZDA=; b=Ow/1XNa7qmUGOzUPyN8DJX1sue
        LeS9RBxVkUqsajMnSXnjYmneOUSLJ5p0ICeQGu8fEJ77CWHOLd9Ihsflgnz1X9rH
        iePqNhT3tAZBI6axg40+tNBt9dOfQYIRs6j/7A1GUeFgXoWei7UiThaEPZJSpskh
        ynlsN0cYqdud/2gpI2+PMBx4gbSW/bX5+ArdIRbrA0ekSycBB1HBl8SYML5+WP5w
        XuJfirJM4CuFa17XmvcqjPhqw099xTCjYLFAoTN8e4/NdiS1IuHj155YC3UQZkNz
        4lE4Bxtm9CJP2j9OTnK09glx/ggte+7sgMS8BSDqEf/1aTTOewCpNWp96n2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696591622; x=1696678022; bh=DfsU3izUarc3u
        rIWoQV9VaCFxzhD45N7hVfrg6KIZDA=; b=EA7xUKzREuuKfVjRlCk3yrhmvk/oX
        3980WsyyeHXQQ45yL3lg4b0TsPD94bzPx4L0rl0ZoOvSsPSNiSmBB6q8C75hjIz/
        jvOipKVvAhvqqe4PGvSVxes28W9MFkAVIbLH/KaeMlcsMUjSY2SRFktoMcXlCy+M
        POMSqL3fx+FDf5hbz4I7R3Xw4j5tfIOUnhOVNCOkZvvuVDZUzlkVgy0HLTvZax/N
        UCDkqk+mrg7wrDisO0uc+Q6O6vsocF3V4oNIhxjQvkWi428yI9njKtCEvs7/N0gn
        kr9b9imJ4UYl/LKtFgTzuyMKHlpsKeiSVn1Qs/MsyzQ75t1W/LxgjEHAQ==
X-ME-Sender: <xms:Bu8fZVEb_9g79KHPZgKGKE653JP5u0088lQzVQ49wkzt0MWUH8bgkQ>
    <xme:Bu8fZaWDy0uhR2mfmLqeyR-CrGezB3Bs2z_3uoPsrEDPeRfPVCtwoDwBnHhe36waq
    ef1cvc3KxpLTkP9AJg>
X-ME-Received: <xmr:Bu8fZXKjaYftPKdobgq88Fq5p_22nonb4APhyiHHLHUBNSL__tr5D-iHdbu1LuH0dg0gyt4H8sA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeigdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    etfedtuddqtdduucdludehmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddt
    necuhfhrohhmpeetmhhoshcuhggvnhhgvghruceorghmohhssegsvggrrhgtohhvvgdrnh
    gvtheqnecuggftrfgrthhtvghrnhepkeehfeefgefhheeuhfevgeelieegleehtdfffeef
    veduveejieekveejgeevudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghmohhssegsvggrrhgtohhvvgdrnhgvth
X-ME-Proxy: <xmx:Bu8fZbFvzl6LjssoRnBxPZoqqixaT4-uz1t6i4ET9jT-yv2HjlVnZw>
    <xmx:Bu8fZbVYroe06MkoA3DfZ0qKhcy3DcrosMnDPwubgDKxIa57YtNeAA>
    <xmx:Bu8fZWP_sKY0ouF84OFzYJIfpoKVjceCJDnToLU9zX7Aw6PX58fupA>
    <xmx:Bu8fZRxY90iwdWrlT9YHg9kWu1lJ3rfY-pBO4dXzgVmDjnG8WJXcDg>
Feedback-ID: i779946bd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Oct 2023 07:27:00 -0400 (EDT)
From:   Amos Wenger <amos@bearcove.net>
To:     amos@bearcove.net
Cc:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-mm@kvack.org (open list:MEMORY HOT(UN)PLUG),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mm/memory-hotplug: fix typo in documentation
Date:   Fri,  6 Oct 2023 13:26:36 +0200
Message-Id: <20231006112636.97128-1-amos@bearcove.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm 90% sure memory hotunplugging doesn't involve a "fist" phase

Signed-off-by: Amos Wenger <amos@bearcove.net>
---
 Documentation/admin-guide/mm/memory-hotplug.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index cfe034cf1e87..fbf2c22f890d 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -75,7 +75,7 @@ Memory hotunplug consists of two phases:
 (1) Offlining memory blocks
 (2) Removing the memory from Linux
 
-In the fist phase, memory is "hidden" from the page allocator again, for
+In the first phase, memory is "hidden" from the page allocator again, for
 example, by migrating busy memory to other memory locations and removing all
 relevant free pages from the page allocator After this phase, the memory is no
 longer visible in memory statistics of the system.
-- 
2.39.2

