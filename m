Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DA47992F6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 01:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345347AbjIHX7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 19:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjIHX7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 19:59:07 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8614C18E;
        Fri,  8 Sep 2023 16:59:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2D8F15C01D4;
        Fri,  8 Sep 2023 19:59:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 08 Sep 2023 19:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jcline.org; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1694217540; x=1694303940; bh=5hPh3+A1H4
        jBnyK3iCCM3bu6cw6mebsPN+ivH9DugBY=; b=a+a5xsQd2PAdpoDepP++GoZdkb
        RKTMbSDjw2ShX0Bt+cIK85NR6rD5RbqOQ/9y4iVnM1uVbVLnvuLt3Gm2vsLK5hON
        fWG7WOLd0m9qp1Hsodl/c+V07OHZdC0WPIhG9qqD+7Jm0hbQbVgDBSz5sLpfpicP
        w7SlUvaMilNVwKhmXVGyZHiZ8yNud2o7JYYpYm7NYRlDOC78vs+5Ff5/FSIeO1CZ
        wXTVM1gX+gq6boljjXo6Z//Y8gpRjJtUbjGR/YHU39F9K3765JNnnxtc204aU5qG
        AiGON/ZztWNywezQqr8cXkRyePv0W82BdSvDaWEd/A1roPxzyUGB/efAMNQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694217540; x=1694303940; bh=5hPh3+A1H4jBn
        yK3iCCM3bu6cw6mebsPN+ivH9DugBY=; b=2PBqp+Nl7uaqC2epPYIfFSFMrqSWd
        To5kX28VbPIvStwzKoJ/lBx1lGz+49twRUu9EzuVKCdrIz/WokyNSLGEK9c+XnK4
        VRSS1iaK0E2vBd/0zqliAyYkLXt4q/LB1jo+4c54G0C/vgB2y3QrxP4YKzMqETTm
        kv3NfsQwO/9JIpr82Lmr/iaU7XbXtbfY0kGUTL90cnZOXNcs8aXl26eLB22S23kk
        6QZjUL8+EfTBIaEFVEmO1XHS2cVRzN3Yaa9sGVZW6WM4WyRSZLvOqRxpEzztF2Fm
        Q23VpAs3aPuy/1XTaag3vu6nu6ckyFfG5QIdCkH5o7RBofBqIxnzO5b9g==
X-ME-Sender: <xms:Q7X7ZOMx_M8nQX_LtjMIWdv7AM-8qlnIGg43l0u9BqkSLxwQzvw88w>
    <xme:Q7X7ZM9LbUJ9xcoM6Ly5rJ-aZB2nU1UuXI7J8sK1nDDx3m25U3dHrICFe8_bD2ROZ
    Qg_CeWat6kv4o8vFJg>
X-ME-Received: <xmr:Q7X7ZFSZ2dYI7PEFOAhXnDGZIxfqZkkGZiW0v0Emt9nz9RtTZsXjqSIkZJHQsQjlA4_MReS3wneLSH54v_6fgw6DS5mn2tFOTL8S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfgvrhgvmhih
    ucevlhhinhgvuceojhgvrhgvmhihsehjtghlihhnvgdrohhrgheqnecuggftrfgrthhtvg
    hrnhepveelveefheeuhffhieduvefgudefiedvfeduteejlefflefggfekvdeuhffgteev
    necuffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgvrhgvmhihsehj
    tghlihhnvgdrohhrgh
X-ME-Proxy: <xmx:Q7X7ZOssu3Bbsp9MozxgLgYrEHn7goHQsBojjOMrc1EOsqZHBeWhgw>
    <xmx:Q7X7ZGcG9ZiDV2gc3EUDsplpyuptptk-3CxJc2WV9cAwrmLrI-Wqlw>
    <xmx:Q7X7ZC3g7v1crpVah3HDzlGoEb8H4-gM3_poFb6wJAA0xbpJ_x57QQ>
    <xmx:RLX7ZMtnjaQOFTXdNkRcCeYrU2FIlPHT1dilIXyKUQUT5CQ17aXgWw>
Feedback-ID: i7a7146c5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Sep 2023 19:58:59 -0400 (EDT)
From:   Jeremy Cline <jeremy@jcline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeremy Cline <jeremy@jcline.org>,
        syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
Subject: [PATCH net] net: nfc: llcp: Add lock when modifying device list
Date:   Fri,  8 Sep 2023 19:58:53 -0400
Message-ID: <20230908235853.1319596-1-jeremy@jcline.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device list needs its associated lock held when modifying it, or the
list could become corrupted, as syzbot discovered.

Reported-and-tested-by: syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c1d0a03d305972dbbe14
Signed-off-by: Jeremy Cline <jeremy@jcline.org>
---
 net/nfc/llcp_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index f60e424e0607..6705bb895e23 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1636,7 +1636,9 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
 	timer_setup(&local->sdreq_timer, nfc_llcp_sdreq_timer, 0);
 	INIT_WORK(&local->sdreq_timeout_work, nfc_llcp_sdreq_timeout_work);
 
+	spin_lock(&llcp_devices_lock);
 	list_add(&local->list, &llcp_devices);
+	spin_unlock(&llcp_devices_lock);
 
 	return 0;
 }
-- 
2.41.0

