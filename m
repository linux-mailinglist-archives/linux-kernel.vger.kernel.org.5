Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0163C791BF1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 19:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350806AbjIDRYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 13:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjIDRYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 13:24:47 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2CECDE;
        Mon,  4 Sep 2023 10:24:43 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 18279100CDA;
        Mon,  4 Sep 2023 17:24:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 917A1101008;
        Mon,  4 Sep 2023 17:24:42 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1693848282; a=rsa-sha256;
        cv=none;
        b=y88M6KqhxwseuuM9cTLVE0pB6aIhUrg5YyledG03J99j5HlHJGd7T3uw7pj0I4GGpEKphp
        KS28FgVttypAooKFClfa9OMKCnGuf1F2sXRM46uKA08RZK5GP15sQCypiFXYZvXfDQ8I8T
        15J8wc0BgDv2JQq2SVc5UulHo1Q7G2DgLytSCuu0jgz4sCsra+RsU39ciwFpZrNrhanBe4
        aOCMImPImISgUx+CV/1FKGsITflUzbljySP7l/YhHG3/v7vjhRsOTqoTBHnctXE9c5sJo8
        RN8ShXkC/L1f567XhV3Aj/VIFBmcI3a5RZ19oqLsGj5DQV4C0e7WV9/1xDZvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1693848282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=zNxbRKdOxnfy7EF/WgaXxgReIzw1Vwdxu7N06Gd5Clk=;
        b=jmn+yBmKLqMu5Qr7kZy7CsIOOr1mK9YDYkcUjeSmzkgo1uSa0qu1tBkcrpHoHD0efujX2D
        W8r2rpXbs4b+qhpf4iMRVGVQJKfMMOHoxf9m1m7Ca1QdEbTSce1Bk1qhI42ge/CJpWQxk4
        eahKTZKq28eGMdBgJh5srLLFtrGJh8mlnLIQh5nQcluR0SXEARM4ouiwWQOmm6nMc5im6a
        TQ70NOedSfUmr76yfrrb4b6/kTkYjv6z9sjttcMfqo+vnb6PoVxkMzH1WDZxWnq3g4nUVv
        BqGEI1vGwEhxOorOq6MfQwwmGBHFhlbUD+MrvWuOZwo5RG8I2STiURgIuauWHw==
ARC-Authentication-Results: i=1;
        rspamd-bfd6864c7-5nddj;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Chief-Whistle: 7df3e558529e9a78_1693848282876_472946407
X-MC-Loop-Signature: 1693848282876:2993707340
X-MC-Ingress-Time: 1693848282876
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.241.104 (trex/6.9.1);
        Mon, 04 Sep 2023 17:24:42 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4Rfb9P6gDbz9w;
        Mon,  4 Sep 2023 10:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1693848282;
        bh=zNxbRKdOxnfy7EF/WgaXxgReIzw1Vwdxu7N06Gd5Clk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=iG6x2FFNIwaCNhikWqhcHXave+3SlWxYDEQ7dUFZ9Pq4bTfQprFWPfFFKrXCkhQ7P
         JQtdFLv46r9HbEACjmAY24SHoqzZeAnIjOpHng4OllwwxKxbdK4z2f4k7TFC7xf7Q8
         T3Z+bRo0IsCqzKdzuexEPC28P9+rRqIGB5wzn9EJEWCKdfQ/iIpVxu1FeE26FHg8sR
         hJoVi+z7jFBj/E2vtIyz1ulpWfoHGVmB4pAxkaojmTh8Sd+jRblq9aytfn84oULhuh
         i231DX/K+vILdv8AylQ/C2m754FP4z29LFr1Q5vx30EJlhqIoJcAhUUTdfh1/ZGDWg
         EwlEbrwLlh8tw==
Date:   Mon, 4 Sep 2023 10:24:34 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/mbox: Fix CEL logic for poison and security commands
Message-ID: <v4gxbhybb2zhxowdyn6ri6tham22aemfvqc4xu7r65x6uhp6zi@2fiholdfp6sb>
References: <20230903-cxl-cel-fix-v1-1-e260c9467be3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230903-cxl-cel-fix-v1-1-e260c9467be3@intel.com>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Sep 2023, Ira Weiny wrote:

>The following debug output was observed while testing CXL
>
>cxl_core:cxl_walk_cel:721: cxl_mock_mem cxl_mem.0: Opcode 0x4300 unsupported by driver
>
>opcode 0x4300 (Get Poison) is supported by the driver and the mock
>device supports it.  The logic should be checking that the opcode is
>both not poison and not security.
>
>Fix the logic to allow poison and security commands.

Hmm yeah sorry about that.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>
>Fixes: ad64f5952ce3 ("cxl/memdev: Only show sanitize sysfs files when supported")
>Cc: Davidlohr Bueso <dave@stgolabs.net>
>Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>---
> drivers/cxl/core/mbox.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>index ca60bb8114f2..b315bdab9197 100644
>--- a/drivers/cxl/core/mbox.c
>+++ b/drivers/cxl/core/mbox.c
>@@ -716,8 +716,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
>		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
>
>-		if (!cmd && (!cxl_is_poison_command(opcode) ||
>-			     !cxl_is_security_command(opcode))) {
>+		if (!cmd && !cxl_is_poison_command(opcode) &&
>+		    !cxl_is_security_command(opcode)) {
>			dev_dbg(dev,
>				"Opcode 0x%04x unsupported by driver\n", opcode);
>			continue;
>
>---
>base-commit: 1c59d383390f970b891b503b7f79b63a02db2ec5
>change-id: 20230903-cxl-cel-fix-9da269bf0f21
>
>Best regards,
>--
>Ira Weiny <ira.weiny@intel.com>
>
