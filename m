Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F29752F89
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 04:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbjGNCuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 22:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjGNCuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 22:50:22 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A814D2733
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 19:50:17 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2GDP5bxdzBHBQ2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:50:13 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689303013; x=1691895014; bh=5I3UgUQXgtcwA4fB/8ofF8DzG0N
        PaPrYz+o/ATGeLLs=; b=j+qJAwA4LakA3Q0pk6yKqzcooJbaJAbEZVKp5o3LfsB
        /FWfR8nXmf5oqZFUXNfZglYdjpjp6g4GzFcVJR9jlAE0dV7wX4U4J1eBQycTlGIl
        paQmg3TN1dMCoaNmjcRt/1sxEeqo5fD/1qrlWv0ZGKSTE1Zjn20CiAk34VajZV9V
        NvdUFBLCyvSSN3nrW9kSUyNbiFsnMpy8e2Fu+oszCd2bmV1HhhIP0b9DSEC0uC8V
        na4elv6YaFayhe8swEnk+Dv6tKG4McjbjDcAU+l5HNuTb4GsT96kHlUhHoXQ+qiu
        /mrJzhnLxz8U77tK7GD1HYIpQ13E3MyOelnsHQeKQWw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VVfipOkjm4Ws for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 10:50:13 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2GDP2Vv5zBHXR9;
        Fri, 14 Jul 2023 10:50:13 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 10:50:13 +0800
From:   hanyu001@208suo.com
To:     yazen.ghannam@amd.com, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, mchehab@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: edac 'unsigned int' to bare use of 'unsigned'
In-Reply-To: <tencent_1109A4B8453E45F850A4A038DBF78E91F907@qq.com>
References: <tencent_1109A4B8453E45F850A4A038DBF78E91F907@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <56065773c390ef4f6575bda9b855a63a@208suo.com>
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

Use of 'unsigned int' instead of bare use of 'unsigned'. Fix this for
edac_mc*, ghes and the i5100 driver as reported by checkpatch.pl.

drivers/edac/amd64_edac.c:2097: WARNING: Prefer 'unsigned int' to bare 
use of 'unsigned'

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/edac/amd64_edac.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 62b7611..5d2c9bb 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2094,7 +2094,7 @@ static void k8_map_sysaddr_to_csrow(struct 
mem_ctl_info *mci, u64 sys_addr,
      }
  }

-static int ddr2_cs_size(unsigned i, bool dct_width)
+static int ddr2_cs_size(unsigned int i, bool dct_width)
  {
      unsigned shift = 0;
