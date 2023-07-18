Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3034758233
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjGRQeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGRQeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:34:10 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B98A1B3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:34:09 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R54K7669LzBR9sr
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:34:03 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689698043; x=1692290044; bh=EAMpXsiaSYTo5oEE8hQAmIO+2wP
        QvJdgOG78JHu50g8=; b=it/c09NUhSWpZvgfIQ/tXSyZDCgD5q1y8toPEf7WewC
        FVxK1WJrsDPpZ/ou8uE4OHkJN2cXinU86LUvpjyJ0d14ua7yb6G4OpYMJMWE5qJA
        WxKhrK/Es4GgmWAznwHDN5oh0UdUwKGAXKMd58MvxCZ+eexq8Sbp2Y7bxasEW5/X
        NogfII1LFvxkX/r0miOrenxSFpE02YBE/J0+r6uC48H2fOSx3Q66PmU2uWzDMi0f
        aHevKe6ZbGomnW7gbdywxy4BthpZlR5PadJXuuBEQdNGqkEckW3UHrNfVFXNPs1s
        gWV004BVCpPrInTjxC2qRNLyP8bwUStCPjpyV+5B+UQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dUlPJTtoJbao for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 00:34:03 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R54K74D9zzBR1PQ;
        Wed, 19 Jul 2023 00:34:03 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 00:34:03 +0800
From:   pangzizhen001@208suo.com
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390/kernel: Fix comment typo
In-Reply-To: <24163a6fd52a3a496a27740039e07dd7@208suo.com>
References: <20230712093757.36116-1-wangjianli@cdjrlc.com>
 <24163a6fd52a3a496a27740039e07dd7@208suo.com>
User-Agent: Roundcube Webmail
Message-ID: <74c6628531f2544e9aa26828a6a21c5b@208suo.com>
X-Sender: pangzizhen001@208suo.com
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

Delete duplicate word "the"

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
  arch/s390/kernel/perf_cpum_sf.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c 
b/arch/s390/kernel/perf_cpum_sf.c
index 06efad5b4f93..3e1d8c58e4d1 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1193,7 +1193,7 @@ static void perf_event_count_update(struct 
perf_event *event, u64 count)
   * combined-sampling data entry consists of a basic- and a 
diagnostic-sampling
   * data entry.    The sampling function is determined by the flags in 
the perf
   * event hardware structure.  The function always works with a 
combined-sampling
- * data entry but ignores the the diagnostic portion if it is not 
available.
+ * data entry but ignores the diagnostic portion if it is not 
available.
   *
   * Note that the implementation focuses on basic-sampling data entries 
and, if
   * such an entry is not valid, the entire combined-sampling data entry 
is
