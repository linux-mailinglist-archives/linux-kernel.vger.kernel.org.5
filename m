Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7B575A49B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGTDBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGTDBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:01:46 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A351739
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 20:01:45 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5yBt3XkpzBRDrr
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:01:42 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689822102; x=1692414103; bh=7TaMCUMPT1gwp5Zxmj+joOcKEEc
        ciuWrPqbP1dQvF8k=; b=A4HtVwIyZaYQbnWRDZHTLuFRFrmZ1S+9GPUGP9d96pp
        VE5JwAB7OFEQFWpEt0/Ug7rxYyEXtsw5Se1mRJxnC3e6lrmnqogBJ5XyALPE+emq
        SQliwTJ7NCdPmrRXhcrqWbitbqgsELFQfAw17l6stqwNmbvNo1nOQhcKWSPqpVc7
        2IjMZAY/f6SxS4dysQpthh+GNeCsCtGjsMRgxy4gpUiCf84HI0QoBvRnTb/YNCes
        UHKI/wuksDl3QqINkMm8vkXPQBufXwt/2YlfbTUR3Jals9DHwsdXniQ37guAKv55
        XeXqQMol/SEXN0c3xi1Hvrfl1dywEtG2sXdvKTnXeag==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JCtgkpDuH0RX for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 11:01:42 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5yBt25TSzBRDrS;
        Thu, 20 Jul 2023 11:01:42 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 11:01:42 +0800
From:   sunran001@208suo.com
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hv: put parentheses on macros with complex values in hyperv.h
In-Reply-To: <20230720030009.1369-1-xujianghui@cdjrlc.com>
References: <20230720030009.1369-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <e4b504ab6a1534cd26be777c9cb0bb6a@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "Macros with complex values should be enclosed in parentheses"
checkpatch error.

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  include/linux/hyperv.h | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index bfbc37ce223b..6f6fdc7cf086 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -428,9 +428,9 @@ union vmpacket_largest_possible_header {
  	struct vmdata_gpa_direct data_gpa_direct_hdr;
  };

-#define VMPACKET_DATA_START_ADDRESS(__packet)	\
+#define VMPACKET_DATA_START_ADDRESS((__packet)	\
  	(void *)(((unsigned char *)__packet) +	\
-	 ((struct vmpacket_descriptor)__packet)->offset8 * 8)
+	 ((struct vmpacket_descriptor)__packet)->offset8 * 8))

  #define VMPACKET_DATA_LENGTH(__packet)		\
  	((((struct vmpacket_descriptor)__packet)->len8 -	\
