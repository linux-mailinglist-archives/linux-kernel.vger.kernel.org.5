Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD027DA08C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346424AbjJ0Sci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346378AbjJ0ScR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:32:17 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9052847BC;
        Fri, 27 Oct 2023 11:29:54 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 74DBA32007F1;
        Fri, 27 Oct 2023 14:26:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 27 Oct 2023 14:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1698431218; x=1698517618; bh=SX5fl+Ehwu
        JvuJSgszNvKWpCysGddZbGyxPGegx2anM=; b=03IfJ58iQg6kqNHZAjKDSOW9WC
        dyWo/vU4NUtyJZoGGkJLC0j3MXU84+1hpXAwShK4fBfDwFhVygwT1FszYi/sSr6O
        v25Bs5xNplaNbpsvUou2carBJpqhvzps4kTmR82hVy/GapjEkSX+HIW7KeCBNOxD
        4cVb0UYzyN7vuC/G7/7DlJNl3+hYozXf7PDOIq9tuzMvTkqiXlMed+3AWsOqOkX0
        mzuABIydFwpTZrCn5EXiAe8aSPQFhEU4Er/BhjMcdfRqx3ja5Nx3fJFqFBnu0MhY
        fqPka0WW4bE9zRlwSM0iPvmNvPnZLrr/BE5CrflqZgU62+HzHOSea2RKHq7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698431218; x=1698517618; bh=SX5fl+EhwuJvu
        JSgszNvKWpCysGddZbGyxPGegx2anM=; b=HpPOfN2dlfROpP3t8TrgZNgJAQA6n
        M8ZpKN93bsaQrh1sRVjyH6WKIhjCzvJ0LCPqBt9m4opxgekG1hrijcZ/VXkQowR0
        nUh3DmzkJSjULI35unYyQ7L3uwwXbdSzY1TfCN3Vnw6JmjIFO/nQrjdwiAXjuO+J
        L/hnUDWmNptkycwjjeY0cHZ5Z4JKGZ6eCUcJKPDvjyiCqWYj5dmVBwF4TN7MpJEZ
        LdBW0v7Lzd6LSN4QcACuMsW6hJBlZ2OP1m4gXTSNYzSlfP+xfVBE96ypUoK1mmmR
        exOXZHXrIRw9ImvfKgPjO3MwqRWjB1iZZYw8wkQJroBm24q2BzzqdjEwg==
X-ME-Sender: <xms:8gA8ZbUIoLZC6XrAH9_8UjVGxYtUfMAbot2QdGXdvIwFT2pFOxxbCw>
    <xme:8gA8ZTlvyM6wCgQMlYTf1VUBA7y14U2_Jry7zwvhSkrt89b_zxrMs2WpuoqfP26Sb
    -nL5jU7JbjqBZfcess>
X-ME-Received: <xmr:8gA8ZXbpMA2eK5OE8nRl7kSaksfGPixFhpLVy6ZkdNx4GvOCd_-_NCoaiofILBipizI0WkUcYPU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhephfetuddtudevieeljeejte
    ffheeujeduhefgffejudfhueelleduffefgfffveeknecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:8gA8ZWXXPmH_TsyAFIQ3LBaulq7D-tiHeXEPZVn_3rkPuZfNBwPiSQ>
    <xmx:8gA8ZVk4pkDVrcyCVKSlmvJ74RVV6rfSoI9bM7vMLxM9ajokHsFhCA>
    <xmx:8gA8ZTeQWH4zvfIuDNBu5524wwVQ9uoTRt2WfEJjyNWEp941Mulyhw>
    <xmx:8gA8ZYu7uNvy9bMNUMP9MLzvYFUYXjNmEBi1yflfJfqPRQJ9Prom7A>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 14:26:57 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] serial, MIPS: Add MIPS UHI semihosting support
Date:   Fri, 27 Oct 2023 19:26:43 +0100
Message-Id: <20231027182650.281405-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patchset adds support for MIPS UHI semihosting.
It has been implemented on many debugers such as MIPS CodeScape debugger
and OpenOCD.

It is also supported by QEMU's -semihosting option.

I didn't add MAINTAINERS entry for this driver because I find other
simple earlycon drivers don't have one either. Do let me know if it
should be added.

Thanks
Jiaxun

Jiaxun Yang (3):
  MIPS: Add header for UHI semihosting defines
  MIPS: zboot: Add UHI semihosting debug print support
  serial: Add an earlycon driver for MIPS UHI semihosting

 arch/mips/Kconfig.debug                |  11 +
 arch/mips/boot/compressed/Makefile     |   1 +
 arch/mips/boot/compressed/dbg-uhi.c    |  11 +
 arch/mips/boot/compressed/dbg.c        |   4 +-
 arch/mips/boot/compressed/decompress.c |   4 +
 arch/mips/include/asm/uhi.h            | 309 +++++++++++++++++++++++++
 drivers/tty/serial/Kconfig             |  13 ++
 drivers/tty/serial/Makefile            |   1 +
 drivers/tty/serial/earlycon-mips-uhi.c |  85 +++++++
 9 files changed, 437 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/boot/compressed/dbg-uhi.c
 create mode 100644 arch/mips/include/asm/uhi.h
 create mode 100644 drivers/tty/serial/earlycon-mips-uhi.c

-- 
2.34.1

