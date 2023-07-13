Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8C875292F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjGMQxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjGMQxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:53:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1852738;
        Thu, 13 Jul 2023 09:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689267207; x=1720803207;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wsaXoMjeXzUXPQTx1vrfeh4jfCe9bDIocWoVsE4tC4g=;
  b=fisohDjKx0A9WwBItBmbYcqnNB75VoEw/2e50OkkT4YjW/A6/jyoX+LS
   E/XM/pMJ9q22fnc+281fox3KhzOO9jFvn+0Ybnd8+S71+F/ks9ur0KZCK
   seXkisrdCKV3cd7jXHqEfQ1y1vcXkGQg4IfFj0cuJm4KwHf/8peI/Y4jj
   pewE46Y4LvNcqDhsj2MjyL9j+/c3tIlSiWEJkf2HzUw6QN/ZOheBG34FV
   n64WLkTH0Sj6bqLD3ztoYlmb5pRIXl92Gn08RbWPrGHCrEbmrR5jFlbUq
   yzLsfRdgXRupRFZvRk1zFZxTL9/uiinowYky6mHdVlvQmcDnKLv+e8G0N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345568482"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="345568482"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 09:53:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="716029145"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="716029145"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 13 Jul 2023 09:53:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3B23B241; Thu, 13 Jul 2023 19:53:29 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v1 1/1] Documentation: core-api: Drop :export: for int_log.h
Date:   Thu, 13 Jul 2023 19:53:20 +0300
Message-Id: <20230713165320.14199-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The :export: keyword makes sense only for C-files, where EXPORT_SYMBOL()
might appear. Otherwise kernel-doc may not produce anything out of this
file.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: f97fa3dcb2db ("lib/math: Move dvb_math.c into lib/math/int_log.c")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/core-api/kernel-api.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index a526fbe06f86..ae92a2571388 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -166,7 +166,6 @@ Integer log and power Functions
 -------------------------------
 
 .. kernel-doc:: include/linux/int_log.h
-   :export:
 
 .. kernel-doc:: lib/math/int_pow.c
    :export:
-- 
2.40.0.1.gaa8946217a0b

