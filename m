Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B3B752FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjGNDN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbjGNDNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:13:54 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E09269D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:13:51 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2Glc400RzBRSVc
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:13:48 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689304428; x=1691896429; bh=tJ3pfxfwg/0mU23GPX8ocn8sdp0
        ++B+RjM+EwDPz9us=; b=WSuj9BjG9Gizt7p9utfYJU/32UME9SPpx8XkeSsNeTj
        xAVWJdo2KBCkgleuFztX3FSuzqKtmNMC/Gx9Z8dA8udCD5Vo8nC27tRZkwKdUq9R
        APSeyY/Vfr77jWsn1gsyLNcxVEYkDjWcqvGJqanbrN9B7vLKndipnbaIwXj8XEOo
        /7+dZCzXgi9zf6lrub17LXlTyI9t0a5jnGlaQtJnGH8OVoa+ByNlSrnHICNJ3IKa
        WrzQnLE/b9cpVO4mdYXwfAr8Q05BfiVqAbfD3P7LClQpCYlmT/OHdAzcX+Y+V0VK
        84KRCPjzheFBiSkYwS0E5bSDOHJ7EwX1j0LiywNUfXA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ODxarTMFw--A for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 11:13:48 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2Glc0lpJzBJk52;
        Fri, 14 Jul 2023 11:13:48 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 11:13:47 +0800
From:   hanyu001@208suo.com
To:     yazen.ghannam@amd.com, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rivers: edac Change 'unsigned' to 'unsigned int'
In-Reply-To: <tencent_2B68DB16B103727E0949749158313DF42F05@qq.com>
References: <tencent_2B68DB16B103727E0949749158313DF42F05@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <68c3d51c4cbb17442ea522192ac1aaf2@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes checkpatch.pl warning:

./drivers/edac/amd64_edac.c:2099: WARNING: Prefer 'unsigned int' to bare 
use of 'unsigned'

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/edac/amd64_edac.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 5d2c9bb..d99828d 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2096,7 +2096,7 @@ static void k8_map_sysaddr_to_csrow(struct 
mem_ctl_info *mci, u64 sys_addr,

  static int ddr2_cs_size(unsigned int i, bool dct_width)
  {
-    unsigned shift = 0;
+    unsigned int shift = 0;

      if (i <= 2)
          shift = i;
