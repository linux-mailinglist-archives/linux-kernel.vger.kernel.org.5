Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0D37E0351
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376881AbjKCNEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376671AbjKCNET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:04:19 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA511A8;
        Fri,  3 Nov 2023 06:04:13 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 91C455C0263;
        Fri,  3 Nov 2023 09:04:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 03 Nov 2023 09:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jcline.org; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1699016650; x=1699103050; bh=7V/ZlNKaTU
        skIGK6nMw36B9soacEoSk1nBJTzZo/h7A=; b=DFubZ7uslAHrPRf4Gam4dx6Mp7
        KC7SRt1xFsVkov2P32eLdvxV2qGfTVZqxbsPY1DRqFbY+mvk6jKZ7MHYr8MRc47Y
        pIilV4qP2e4ridQkaP6fZ4AAUPF6sYUU7W2PfC9HR9M+nLLHquFX8Mbq0l4g28PJ
        Lh4+YCrM4ccTt1jiCi+8MvuLG+CpOSQqTwj20kkBagx7wz/ZiZhbtXYddg8zX4Rx
        LJJb6AHmBM83pxdynltenTEjVh3KUQRyO+FQ8i4cYTgkojb+5ELniPCPZbDY+z8Z
        +WQad9yXqWTIuWWH+iAD3gSg2Y8+1RfpPUWChv6q7Scf9Vo3s3YIMlGsdIlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1699016650; x=1699103050; bh=7V/ZlNKaTUskI
        GK6nMw36B9soacEoSk1nBJTzZo/h7A=; b=VusiPKup15XHpVJnrC0BKjU8xmBtY
        Nfjwhrb2scb+53HL7zJb7YvikPgyBHqRr6N590d7POPJgmHUMvoU8NyHcalQ3bfQ
        F+OXunsmJPUMYdOxqsc+UW6D6Dc8zIUbw+1HnFh4d5K77GRapbVDavmiv3lYDiMB
        D+vjGql+ClRQyI9xcSXi08wWNrq5U7J/dOT2j9qp1L2vdcGi0dp++jcEaYyC6yCC
        gzDZGvqFI9ajaIQNsCndNYwkaTLiBx8WjyqYfnIvIYfyt9yTQHna13UsLbxn0P6t
        OOUYSDy3bGes30pOd1lq6Rr3Oc5euAPkLDUj8p5B26O5r5nCC2aFhkePQ==
X-ME-Sender: <xms:yu9EZQP9SS2HwVI7LnRaFeiZVSC7_k5C_x5Cjx2xaKX4zLTxpeJDZg>
    <xme:yu9EZW-Ii-KgBxiZXUwHd5aAE5kKa4mJ04IBDyK2rTWOFnCHwAg6uYtfe-we2w8iS
    3C9KlMU9xFv14t9cYI>
X-ME-Received: <xmr:yu9EZXQpsdHvrkdcBfw4ioEee6qlInnRygQ8c4mqvMicTDNJZicB-u6O0fdw0EwuakuwMoRUtXBPwN_xIS3PfN-zZxJpNSUyEN8O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflvghrvghmhicuvehlihhnvgcuoehjvghrvghmhiesjhgtlhhi
    nhgvrdhorhhgqeenucggtffrrghtthgvrhhnpeevleevfeehuefhhfeiudevgfdufeeivd
    efudetjeelffelgffgkedvuefhgfetveenucffohhmrghinhepshihiihkrghllhgvrhdr
    rghpphhsphhothdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjvghrvghmhiesjhgtlhhinhgvrdhorhhg
X-ME-Proxy: <xmx:yu9EZYtKgIfxMe5_tRzCJYsiMRmhx6mTorKFd6AG3HC0DmV474pTFA>
    <xmx:yu9EZYdjAHO2K_pvf8ZfjDj42KhEZfhmBtMn90aHgfZ0HVvlMZfKjQ>
    <xmx:yu9EZc1G8KPy5h84KEwHwOdhid6Z9OYhFhcojFINxzLG_qaWnQzaOQ>
    <xmx:yu9EZZq6Kwl8mH2L-ibR8vaoPJdE2ISTycQ7cEqdrrimoOenHFyQOQ>
Feedback-ID: i7a7146c5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Nov 2023 09:04:09 -0400 (EDT)
From:   Jeremy Cline <jeremy@jcline.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jeremy Cline <jeremy@jcline.org>,
        syzbot+5ce571007a695806e949@syzkaller.appspotmail.com
Subject: [PATCH] hfs: check return value before accessing fd in hfs_brec_find()
Date:   Fri,  3 Nov 2023 09:03:59 -0400
Message-ID: <20231103130359.882002-1-jeremy@jcline.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the event that hfs_brec_keylen() fails, an error is returned to the
caller of __hfs_brec_find() and the struct hfs_find_data is not
initialized.

The result needs to be checked before attempting to read any fields from
fd.

Reported-by: syzbot+5ce571007a695806e949@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5ce571007a695806e949
Signed-off-by: Jeremy Cline <jeremy@jcline.org>
---
 fs/hfs/bfind.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index ef9498a6e88a..f225c78a9e66 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -136,6 +136,8 @@ int hfs_brec_find(struct hfs_find_data *fd)
 		bnode->parent = parent;
 
 		res = __hfs_brec_find(bnode, fd);
+		if (res < 0)
+			goto release;
 		if (!height)
 			break;
 		if (fd->record < 0)
-- 
2.41.0

