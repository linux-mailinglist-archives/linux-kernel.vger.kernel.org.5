Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D18075BBBE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 03:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjGUBOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 21:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjGUBOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 21:14:30 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C80CC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 18:14:28 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6Wmb4l70zBRDt5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:14:23 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689902063; x=1692494064; bh=4GBqDFrt1FMfDd6HMrt3eR5rmJe
        B74SGP0SN71oVcpI=; b=1Dy5cVJekOXn66SldozBuzHJVOZrTe9Cw/8E7mbh47b
        0r3RodRbc4uzGg+BSa5n2fP9BbEVx9Tm78vA1X/8t23xrwSQyHu7+YN30VKq51Vj
        uKGL7SdOwruBbn2ubwCzTPcnmQWeUbxmFZywkieMvOi5HUQbqbVLWEow8R+Y8XOx
        7Hip5HhuKBGtf4tS7uAGqC039A1hPxZeJCX07KPl8i759FcBatSNkHrAz7ulPHle
        V4dYYwETJCJ5QqqMhzXVS9CWWJh+86RG4lsEryKOGpzunxauhIi0vl1rRwIY8MXZ
        3b2n4TjLuOyv9R3/L1DHjdDTaGLzzftweNcHkXE4f8w==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Fsa7ey6Yln53 for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 09:14:23 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6Wmb2LKTzBRDsm;
        Fri, 21 Jul 2023 09:14:23 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 09:14:19 +0800
From:   sunran001@208suo.com
To:     nm@ti.com, kristo@kernel.org, ssantosh@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH] clk: keystone: sci-clk: fix application of sizeof to pointer
In-Reply-To: <20230721011303.4303-1-xujianghui@cdjrlc.com>
References: <20230721011303.4303-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <8cfd376d48d63670882b8079c411d605@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./drivers/clk/keystone/sci-clk.c:390:8-14: ERROR: application of sizeof
to pointer

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/clk/keystone/sci-clk.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/keystone/sci-clk.c 
b/drivers/clk/keystone/sci-clk.c
index 6c1df4f11536..2c68c1e09d1f 100644
--- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -389,7 +389,7 @@ static struct clk_hw *sci_clk_get(struct 
of_phandle_args *clkspec, void *data)
  	key.clk_id = clkspec->args[1];

  	clk = bsearch(&key, provider->clocks, provider->num_clocks,
-		      sizeof(clk), _cmp_sci_clk);
+		      sizeof(**clk), _cmp_sci_clk);

  	if (!clk)
  		return ERR_PTR(-ENODEV);
