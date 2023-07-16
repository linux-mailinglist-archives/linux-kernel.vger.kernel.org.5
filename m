Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5F7754DC9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 10:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjGPIMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 04:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjGPILZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 04:11:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B7610D0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 01:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689495085; x=1721031085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k2QBVUHSfTaG4k7pbO40VxZQItrLWV3izF57/xIjCMw=;
  b=HDxgnCeYLMQdGrZI79oQSZHZyUF2BE5xQBjAcHjqd+1gBlAJUeTMz8st
   wQkubXZyXMRUdunZ4Q4yUV9/viseHl4/C5UuSqpFgUcLfi1X5uGyHCLyv
   UfGLG8d5GH2evn9BSuHAExznXffh3muhUtuSPXd6PUJXdtv9VM+Dk9+f6
   saZXo8rWaEbtaS4YCQGxAKsy68gIt1MCaOEpflj3EHEaHc++Ppij6zhOe
   uQDFYh46a/CXAuIGYQMrCF1OBG1NOJIz0HzR1Eu5kOlonEIJUlKEZ/td7
   HY0fVdXlS2Jv5/0Sk6wIG3Di9l9d/u8/Idyl6mMzfievG2/RzNzwgWr6s
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="368381718"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="368381718"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 01:11:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="716823156"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="716823156"
Received: from twinkler-lnx.jer.intel.com ([10.12.230.239])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 01:11:17 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 4/4] mei: gsc: add module description
Date:   Sun, 16 Jul 2023 11:10:43 +0300
Message-ID: <20230716081043.3092690-4-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716081043.3092690-1-tomas.winkler@intel.com>
References: <20230716081043.3092690-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For completeness add gsc module description.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/gsc-me.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
index e63cabd0818dc9fdd00312fa..ed9b421e82d6994b84953379 100644
--- a/drivers/misc/mei/gsc-me.c
+++ b/drivers/misc/mei/gsc-me.c
@@ -312,4 +312,5 @@ module_auxiliary_driver(mei_gsc_driver);
 MODULE_AUTHOR("Intel Corporation");
 MODULE_ALIAS("auxiliary:i915.mei-gsc");
 MODULE_ALIAS("auxiliary:i915.mei-gscfi");
+MODULE_DESCRIPTION("Intel(R) Graphics System Controller")
 MODULE_LICENSE("GPL");
-- 
2.41.0

