Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187B575823C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjGRQfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjGRQfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:35:32 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737C410C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:35:31 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R54Lm6CTNzBR9tV
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:35:28 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689698128; x=1692290129; bh=f0lIyFBFjPx0IprcathWHFRn+Oz
        vzscZlcDubsXRrY4=; b=N15vQrHMJhMkwLbFlcB4hasBYuYlEcBhtzhXs4e/G8Z
        vR0tlAM6YLD39x3j0RpuvcdwKQ4QmG3CJMP2Wiu22I3HGsrvokV1Qk6Ihu2qVH1E
        bJqpylG5sUp/wxgnioy9BbWt45t1G0ytyBVUA98kcOAeHNbLJlaXu++DtoFoHifT
        kwk/yLjGkTvdAFltjoLEQEsqfOwI/LUQUta5Hj2iWiAGXLPRMfWYHbeeojAe5sP5
        az5lvVQx2WuwIo23etgHZIAxU4L86YLb8QvgO1KhkGvk+wRuiGwV37n05rXGHBmm
        PGY7wGz71dlsQ2TpDmQevYg2Hp+DcRA10ftKMhK3nqA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NzCrN5d6YzN1 for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 00:35:28 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R54Lm4bZfzBR1PQ;
        Wed, 19 Jul 2023 00:35:28 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 00:35:28 +0800
From:   pangzizhen001@208suo.com
To:     dinguyen@kernel.org, bp@alien8.de, tony.luck@intel.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/edac: Fix comment typo
In-Reply-To: <c3f79bcc93dc4090e88a36fc9fadf26b@208suo.com>
References: <20230712094640.24445-1-wangjianli@cdjrlc.com>
 <c3f79bcc93dc4090e88a36fc9fadf26b@208suo.com>
User-Agent: Roundcube Webmail
Message-ID: <562575dc60e79aab479f1d83ffc54ecb@208suo.com>
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
  drivers/edac/altera_edac.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 8b31cd54bdb6..a3b17813eb9b 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -168,7 +168,7 @@ static ssize_t altr_sdr_mc_err_inject_write(struct 
file *file,
      /*
       * To trigger the error, we need to read the data back
       * (the data was written with errors above).
-     * The READ_ONCE macros and printk are used to prevent the
+     * The READ_ONCE macros and printk are used to prevent
       * the compiler optimizing these reads out.
       */
      reg = READ_ONCE(ptemp[0]);
