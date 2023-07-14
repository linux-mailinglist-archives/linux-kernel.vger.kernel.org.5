Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9297531F8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbjGNGb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjGNGbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:31:55 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD1310D4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:31:54 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2M853pF8zBR9sX
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 14:31:49 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689316309; x=1691908310; bh=vePWjMFUPigKMP/Y7MTmNpJd9lY
        4lk8B7VT/afW3fa4=; b=p5p9A2N1fQp6lrCUFOkXMtQ0HVZvoctYELwS8dQ+Jo9
        bT5pwEq/S4LRNPp+C+n0E1yUPnyS+UgyesR7pn7lz8AaVbd7S/PT8E5dxxW7KTsv
        qNc52d5wdWI2r7dqnL4jI7DIzR1vbB4r+q2LAcYyRlQMZgzBl0qzbZkda9fQ06P+
        2pgSIPwpQ8leNtqUfA6OLLrLJGrCb/NCszQcpsfpwtK8/TnVQ1fRBRa6JV5yDzbc
        W7+Aso0usHkHXBaekmpw6pXYJRc/85KKHxDCXL2vy8h9QHQEL4ZCdgc6Lu7Hc62X
        ui96ni3lYb9EeustMECz6xl4vBZwxQhKySMKReYkRvQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fsVL3CMLpVWJ for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 14:31:49 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2M850jHjzBJFS7;
        Fri, 14 Jul 2023 14:31:49 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 14:31:49 +0800
From:   hanyu001@208suo.com
To:     bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/edac: Use unsigned int instead of unsigned
In-Reply-To: <tencent_7104C9739158112DF43868C9F6A2C36E3E05@qq.com>
References: <tencent_7104C9739158112DF43868C9F6A2C36E3E05@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <07f86d127c9ac5688d68ce8541e0e007@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the checkpatch.pl issue:

./drivers/edac/ppc4xx_edac.c:199: WARNING: Prefer 'unsigned int' to bare 
use of 'unsigned'
./drivers/edac/ppc4xx_edac.c:200: WARNING: Prefer 'unsigned int' to bare 
use of 'unsigned'

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/edac/ppc4xx_edac.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/ppc4xx_edac.c b/drivers/edac/ppc4xx_edac.c
index 046969b..16dd9ff 100644
--- a/drivers/edac/ppc4xx_edac.c
+++ b/drivers/edac/ppc4xx_edac.c
@@ -196,8 +196,8 @@ struct ppc4xx_ecc_status {
   * TODO: The row and channel parameters likely need to be dynamically
   * set based on the aforementioned variant controller realizations.
   */
-static const unsigned ppc4xx_edac_nr_csrows = 2;
-static const unsigned ppc4xx_edac_nr_chans = 1;
+static const unsigned int  ppc4xx_edac_nr_csrows = 2;
+static const unsigned int  ppc4xx_edac_nr_chans = 1;

  /*
   * Strings associated with PLB master IDs capable of being posted in
