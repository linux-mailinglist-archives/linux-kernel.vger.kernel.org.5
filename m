Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E495C76F5F9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 01:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjHCXFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 19:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjHCXFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 19:05:20 -0400
X-Greylist: delayed 77 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Aug 2023 16:04:46 PDT
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3521546A6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 16:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1691103886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d2QxI1VIFLr9Zd/T7UXA/F5/G1e1i21XBdqtpHTollM=;
  b=dZ/JD9osKOelmKpERnBhjdQY5ljF0Oikf4djvLfmqlTt8yZ1r+iUDry8
   XI8lZDqjhmriS+sPoz9FAq4Eca6K2b60k8fNs6LZZT9wWeeO6k9xMs69l
   +6dT+jqx3e/vUHorC836aZKvVqM6+Bi80318C6gsKE/22X9Azu8QK+IwB
   Y=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 118879229
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:UdM24Kj3lzIVdJMiBUbWuVmoX161SBAKZh0ujC45NGQN5FlHY01je
 htvDWnVMvaONmr1eNF/bdzkpEMD68LczdQwSAVqpHs0Fy0b9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrWCYmYpHlUMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMRqu1iUc3lg8sspvkzsx+qyr0N8klgZmP6sT7AeFzyJ94K83fsldEVOpGuG4IcbiL
 wrz5OnR1n/U+R4rFuSknt7TGqHdauePVeQmoiM+t5mK2nCulARrukoIHKN0hXNsoyeIh7hMJ
 OBl7vRcf+uL0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tQVKTUHfh6zpNvn56yiZe1l3Ognd9fSadZ3VnFIlVk1DN4jSJHHBa7L+cVZzHE7gcUm8fT2P
 pRDL2A1NVKZPkMJYw1MYH49tL7Aan3XWjtUsl+K44Ew5HDe1ldZ27nxKtvFPNeNQK25m27B/
 zKWoDWjWEBy2Nq30Ty80XKU3+71libwZJA3DYHiyaU0qQjGroAUIEJPDgbqyRWjsWa6WtRCO
 wkX9zAooKwa6kOmVJ/+Uge+rXrCuQQTM/JIHvEgrhmE1K7Jyx2EHWVCRTlEAPQ+udM7Xy4C1
 1mHhdrlCDVj9rqPRhq19K+TrDa4PiU9LmIYYyIACwwf7LHeTJob10yVCIw5Sejs04OzQGurq
 9yXkMQgr7gSiMQb2ZWYxAHgnSuDopGTYgpu+DyCCwpJ8ThFTIKiYoWp733S4vBBMJuVQzG9g
 ZQUpySNxLtQVM/QzURhVM1IRej0vKjdbFUwlHY1R/EcGyKRF2lPlGy6yBV3Pw9XP8kNYlcFi
 2eD6FoKtPe/0JZHBJKbgr5d6exwlcAM9vy/DJg4i+ZzjmBZLlPvwc2XTRf4M5rRuEYti7ojH
 pyQbNyhC30XYYw+kmvvH7dCj+52nn5lrY82eXwc5032uYdymVbPEetVWLdwRr9RAFy4TPX9r
 I8EapriJ+R3W+zieCjHmbP/3nhTRUXX8ave8pQNHsbae1oOJY3UI6OJqV/XU9A/zvs9eyah1
 i3VZ3K0P3Kl1COZc17VNig7AF4tNL4mxU8G0eUXFQ7A8xAejUyHts/zq7NfkWEbydFe
IronPort-HdrOrdr: A9a23:U0OCAqpB/l0jLOoyamIXvbwaV5oTeYIsimQD101hICG8cqSj+f
 xG+85rsyMc6QxhIE3I9urhBEDtex/hHNtOkOws1NSZLW7bUQmTXeJfBOLZqlWKcUDDH6xmpM
 NdmsBFeaTN5DNB7PoSjjPWLz9Z+qjkzJyV
X-Talos-CUID: =?us-ascii?q?9a23=3A7JUfkGqsHo+4lgLDvCQvUJHmUc0kd3fNwkfzGh6?=
 =?us-ascii?q?fF39GTLTPZVvL5poxxg=3D=3D?=
X-Talos-MUID: 9a23:4t+bKwjww5BoH4qRu0L6V8MpLMFRwKSWUUE3mpANh9uhLBAqBGzDpWHi
X-IronPort-AV: E=Sophos;i="6.01,253,1684814400"; 
   d="scan'208";a="118879229"
From:   Andrew Cooper <andrew.cooper3@citrix.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Petr Pavlu <petr.pavlu@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH] x86/retpoline,kprobes: Fix "Fix position of thunk sections with CONFIG_LTO_CLANG"
Date:   Fri, 4 Aug 2023 00:03:23 +0100
Message-ID: <20230803230323.1478869-1-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230803215555.zl5oabntc44ry3uc@treble>
References: <20230803215555.zl5oabntc44ry3uc@treble>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lets hope there are no .text..__x86womble sections around.

Fixes: 973ab2d61f33 ("x86/retpoline,kprobes: Fix position of thunk sections with CONFIG_LTO_CLANG")
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
CC: Petr Pavlu <petr.pavlu@suse.com>
CC: Peter Zijlstra (Intel) <peterz@infradead.org>
CC: Josh Poimboeuf <jpoimboe@kernel.org>
CC: linux-kernel@vger.kernel.org

Alternatively,

int strstarts(const char *s1, const char *s2)
{
        return strncmp(s1, s2, strlen(s2));
}
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e096eb325acd..e2ee10ce7703 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -389,7 +389,7 @@ static int decode_instructions(struct objtool_file *file)
 		if (!strcmp(sec->name, ".noinstr.text") ||
 		    !strcmp(sec->name, ".entry.text") ||
 		    !strcmp(sec->name, ".cpuidle.text") ||
-		    !strncmp(sec->name, ".text..__x86.", 12))
+		    !strncmp(sec->name, ".text..__x86.", 13))
 			sec->noinstr = true;
 
 		/*

base-commit: 029239c5b0e6484e4443be90e5664fd0bf0f066b
-- 
2.30.2

