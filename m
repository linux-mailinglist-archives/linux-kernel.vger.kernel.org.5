Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4781752F6B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 04:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjGNCdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 22:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjGNCdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 22:33:02 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FC31BF2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 19:33:00 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2FrT3Tq8zBHXhS
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:32:57 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689301977; x=1691893978; bh=nJEWEdmcaA5AHkvy4YNc3CzyARG
        mYSWiIBQ/FSGBulU=; b=0I6TiDrz+pWKev7GZKEsmt/xq0Gq7dgaeptB0Wk1WJo
        Ms+5CryTGuwzA1Wv37MYJsD9qIdoNENEZvAG68vRpyh1sqQrIWqsFiOlbbWuuFDG
        bHDSfe5atwy+JJJXO6oW27BYoPdI+lYRk5HZOxu3QDdckgcJR0yKEIphOwunHIqw
        AdRpmhccyC01FeRcFzPr0M0b8KKiV+GBbn3enCWpnZKO8F9ujPChw9uftnKSQiJ4
        kfs9LCPL7Ua9C7H3tV6HgzFM7YSCHI5EwUSOlo1cAnRnpSMrR+F1/ZA6uej5Gxv9
        aLR2KUZ1wgpSHkTsHzNnEtJuwmyOaEfqmW62PqQ2kqg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id H33Ff8DLSgy3 for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 10:32:57 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2FrT06qGzBHXR9;
        Fri, 14 Jul 2023 10:32:56 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 10:32:56 +0800
From:   hanyu001@208suo.com
To:     rric@kernel.org, mchehab@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, yazen.ghannam@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: [PATCH] drivers: edac 'unsigned int' to bare use of 'unsigned'
In-Reply-To: <tencent_1729A1084117B6691D94F35D48218BA78A08@qq.com>
References: <tencent_1729A1084117B6691D94F35D48218BA78A08@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <075f691cb489f3f480340203921a5eba@208suo.com>
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

drivers/edac/amd64_edac.c:2112: WARNING: Prefer 'unsigned int' to bare 
use of 'unsigned'

Signed-off-byC: Prefer 'unsigned int' to bare use of 'unsigned'
Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/edac/amd64_edac.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index ddb9bf3..62b7611 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2109,7 +2109,7 @@ static int ddr2_cs_size(unsigned i, bool 
dct_width)
  }

  static int k8_dbam_to_chip_select(struct amd64_pvt *pvt, u8 dct,
-                  unsigned cs_mode, int cs_mask_nr)
+                  unsigned int  cs_mode, int cs_mask_nr)
  {
      u32 dclr = dct ? pvt->dclr1 : pvt->dclr0;
