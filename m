Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A435796DA2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 01:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243272AbjIFXeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 19:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240901AbjIFXeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 19:34:11 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC1EE66;
        Wed,  6 Sep 2023 16:34:06 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 916C65C00E3;
        Wed,  6 Sep 2023 19:34:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 06 Sep 2023 19:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jcline.org; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1694043243; x=1694129643; bh=vBTjdMfz1C
        O5+QvldXBB+2bQ59B3jeU81T91GJRZKcc=; b=lCbZbYYS3BAZ5uNKthMk1f2xTa
        Fai2IZ8aUGUTKsBa07bR8OklHlqG2i35GZqaBndYGzq2G+s6q+wh3gpiypHMHkv0
        VgUeQbWrCOuMtmTlFY+iWtQhvgGiwunlAghInQvPUhsdvRQkEtCVsU+dw/9oieLG
        DcmrWC7/mZ3exbfVNeXuPpO9FoLprv+YZTmtxWll8OTgpdUBMEPNXrWjLRtwYWot
        dGnDJibx0k/kIXpr5WDpT37RWKJGjQg1ciEiTB19qgb8lqRMstyk2xgz7FHODibE
        eq9X79czzYlxXsF7+WMVQbdS9i/SuC8TDgOC5qYNahPRBugZr8WP7uUGvgJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694043243; x=1694129643; bh=vBTjdMfz1CO5+
        QvldXBB+2bQ59B3jeU81T91GJRZKcc=; b=gJHjU750+HzSv7RYPPkd3G/rLMEs+
        obWwwh3TAzL5rtFQUCV16ciho2lwUcRbnM8Kf20i+iX4PPyN/AI9exx7FKFV5Wxe
        1O5I9QMItyY4P4L88Pz5ndQ8iojAMB0PpD3ugJDL4iFVTxeWFk7Shd88cND8j9SA
        5qWHdHVeGUK9kIIvUxxuDWRbyJhqASjjvcIOF7ieJSY1rJKS05O3LUFJ9AB0KSDE
        k+nEwnR4zJAiyeslbr5OkrHZflH91oTKfp54dv+wEnBBhy4ZL1Zv7ity0qhjZNZg
        RvvDAxP4hBcmA98u70lmdCYzEFjN6PU6NEgiIIYawfUImSYTzbJ2mmbCw==
X-ME-Sender: <xms:awz5ZHVaOqD9lcWDPTi_5fWYXVXlWA5za_46Oh_wEfwGB5P1-jbfNA>
    <xme:awz5ZPm978cA7CcbVMSmnyxDr6pSJ_uY7GZQQ5K5J8Nn6MPsmbYTSY75MI74qzC_6
    qyDYDJW_cl1IDwegFI>
X-ME-Received: <xmr:awz5ZDbxrYyWYpBt4jKImwjtBwyuJ8dKXYddV3RAKMhDrMXe38FsrWa_k0ffxqyuSrsMFKYAzCL7VEYTBCJWGAzkAD8858VBgjTM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehgedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfgvrhgvmhih
    ucevlhhinhgvuceojhgvrhgvmhihsehjtghlihhnvgdrohhrgheqnecuggftrfgrthhtvg
    hrnhepveelveefheeuhffhieduvefgudefiedvfeduteejlefflefggfekvdeuhffgteev
    necuffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgvrhgvmhihsehj
    tghlihhnvgdrohhrgh
X-ME-Proxy: <xmx:awz5ZCWkcaO4bFiFIqcNguTg5QVtNZpml3xrudyffiVQANXvJ6TGIw>
    <xmx:awz5ZBnmO1WZbve-7Kao0jbyCz3doiZDJlqaqU_H9Gf3lLNT8MW5Lw>
    <xmx:awz5ZPcKLml0D4C33e2VA_h6ck9VTOOUnhfolkO4_S0oYZDd2hVUbg>
    <xmx:awz5ZHW4mAojt2U5mb3yGZm_1dDMnahEI9etx0iBQEMIACpmSQtelw>
Feedback-ID: i7a7146c5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Sep 2023 19:34:02 -0400 (EDT)
From:   Jeremy Cline <jeremy@jcline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeremy Cline <jeremy@jcline.org>,
        syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com
Subject: [PATCH] nfc: nci: assert requested protocol is valid
Date:   Wed,  6 Sep 2023 19:33:47 -0400
Message-ID: <20230906233347.823171-1-jeremy@jcline.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The protocol is used in a bit mask to determine if the protocol is
supported. Assert the provided protocol is less than the maximum
defined so it doesn't potentially perform a shift-out-of-bounds and
provide a clearer error for undefined protocols vs unsupported ones.

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Reported-and-tested-by: syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0839b78e119aae1fec78
Signed-off-by: Jeremy Cline <jeremy@jcline.org>
---
 net/nfc/nci/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index fff755dde30d..6c9592d05120 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -909,6 +909,11 @@ static int nci_activate_target(struct nfc_dev *nfc_dev,
 		return -EINVAL;
 	}
 
+	if (protocol >= NFC_PROTO_MAX) {
+		pr_err("the requested nfc protocol is invalid\n");
+		return -EINVAL;
+	}
+
 	if (!(nci_target->supported_protocols & (1 << protocol))) {
 		pr_err("target does not support the requested protocol 0x%x\n",
 		       protocol);
-- 
2.41.0

