Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47008801B62
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 09:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjLBIGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 03:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLBIGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 03:06:49 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C5A133
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 00:06:55 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9257D5C0185;
        Sat,  2 Dec 2023 03:06:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 02 Dec 2023 03:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1701504412; x=1701590812; bh=Q7wf+2tdim
        +n+AqDdmyvJiyR5NBYgGXoMqHt3aSVxHY=; b=nNH4xFeRpytfe9F4Ft3TffOuEc
        ZOP7HRK4QT8GByMU+50+4U2zZjxsvRjxTQ1F/ejM/F84bYuVJ5s39n0/1thDdnGN
        zhs9wvnHiV8RmFfgZwM3rJS0Q4v2eCyXTgbPur336OZ2cdtAdDvwGjDQsyK5JwBS
        o7vw1QaDvAn4s8Xz+IN9nizpzeQpQ/puOUIBqc/YF7EKtyHAmzkBqo6S161kDJog
        BlrLoRQDoQJFyvXizjc2w0XEKYce2xhWgG/Jjtjikv9YUDr4sZTDXVNqFnKJosVj
        xg/AlDIkeGvCH20vU+C8WQQrh6biHhKlf75HciMdacjOisvBBYSH1gdPpWlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1701504412; x=1701590812; bh=Q7wf+2tdim+n+AqDdmyvJiyR5NBYgGXoMqH
        t3aSVxHY=; b=AtXzoSDpjMnPbT5kLNKWsb/rlGEJFqfs0V1rAhz75S9GJke85dl
        +pLuyfI9PGJ+EgwYGY4oi/TQlTYw3qAN3Oil3syfIj5DyfhgSeEZgXfsVdLwiwng
        lEDnVwOsPryJYOy8LB7rV5SQgw/1x4dARAYUgfY/PJbkYTTJYyrjX3IErbZz6aBa
        a/gp4LUbz5wnXUGF6NtaHQoQjtrficvOW38zz0kDFla7CytsT9QNc0/93SmW1e4z
        WoIBmji9MiSceonZhsQihqmXtMi9UuFcQO39zIi+KxXLmtXdlPimHDdE1O7XJc4Y
        D0w6kkWnyP9hIVvifdlBzHIxFWo/belHbSg==
X-ME-Sender: <xms:nOVqZURIlPFU5x7wHpNUCgiqVYjEKAlhjQmOwqHC7VLpfZScz6_sMw>
    <xme:nOVqZRz5tfOMSCeZEDPD3tF9XlHlCS7u78QeEMCZC68-XEx8GXX6q0ufwQQ4xZpRv
    vCNcHu3UQ0bFAsxhY4>
X-ME-Received: <xmr:nOVqZR2Reicg2pX-zq1UplK6qKtcYJwhRuDZNqNQSV23o0LcHuS5S9LA4rnqBkFyx4_-2gvCEvUXvhgRGwW809N8JxgPTiuk2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejtddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesthdtre
    dttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepteefieetfe
    evgedvgfegffehteeljeekkeelueegfffftdfgtdetteekvedvvdfgnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:nOVqZYBDLx_Wz09I-XRYI5JD_HaYcSQEZp1rz22rp7IK3Wo529CUMA>
    <xmx:nOVqZdiBCDSWuc5iCM0TXz3FLrGiCK5sBLtus4jqYXU2MG29z27M9w>
    <xmx:nOVqZUr1TVD_uBa41__fb8H-fZhrhqg859nLwqu6-iDgFL7L3iINlw>
    <xmx:nOVqZdLUa1uuC-3WFeGv8tc9z8-yMsLcf1nnLohZ-oKMB0Q3dgxhNQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Dec 2023 03:06:51 -0500 (EST)
Date:   Sat, 2 Dec 2023 17:06:48 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] firewire fixes for v6.7-rc4
Message-ID: <20231202080648.GA34377@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please take this pull request for v6.7-rc4 release. It includes a slight
change to fix scarce memory leak.

As I noted in pull request for v6.7[1], Linux FireWire subsystem still
has an issue of unexpected system reboot in AMD Ryzen machine with a
kind of PCI card. Recently I got a help of AMD developer[2] and got some
advices to investigate the mechanism of system reboot, but never catch
its tail yet... I wish to fix it within the development period for v6.8
kernel.

[1] https://lore.kernel.org/lkml/20231105144852.GA165906@workstation.local/
[2] https://lore.kernel.org/lkml/20231128052429.GA25379@workstation.local/

----------------------------------------------------------------

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.7-rc4

for you to fetch changes up to 891e0eab32a57fca4d36c5162628eb0bcb1f0edf:

  firewire: core: fix possible memory leak in create_units() (2023-11-30 09:16:35 +0900)

----------------------------------------------------------------
firewire fixes for 6.7-rc4

This pull request includes a single patch to fix long-standing issue of
memory leak at failure of device registration for fw_unit. We rarely
encounter the issue, while it should be applied to stable releases, since
it fixes inappropriate API usage.

----------------------------------------------------------------
Yang Yingliang (1):
      firewire: core: fix possible memory leak in create_units()

 drivers/firewire/core-device.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)
