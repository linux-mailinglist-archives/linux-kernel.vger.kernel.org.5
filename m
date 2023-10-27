Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A847DA075
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjJ0SbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbjJ0Sa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:30:59 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D503AA9;
        Fri, 27 Oct 2023 11:30:23 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id BDEBA3200A13;
        Fri, 27 Oct 2023 14:27:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 27 Oct 2023 14:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698431230; x=
        1698517630; bh=SX5fl+EhwuJvuJSgszNvKWpCysGddZbGyxPGegx2anM=; b=j
        FRAXDUuK2CFPQX5/xA0kUTtyU567S0snECMD+OHTNcU8aQCUTpOb9inZjuSuKJvd
        zGvLRA1OFzH1Y5NZTXse/wulq+xgRyWzBvnmxITUUOlJBAMIhCAlECE/qu6ntzrn
        F3nY1dvVHx3m+YB6DaLmW5xNJvPmZbMyTTC8fxLv5OOqqgWywO3ANEftOLW22kIm
        HS+QPnl8cxWrGk5zgI9JYpIk2cy6/Opf/ecV0oQ1otlikweEgKE+esZRqbId3BSW
        iWdp0imEGPBt+5DXXDOfksjtacbFfWqY3hwRRyEHKUVx1Iej+fBhdFRfjlggETmx
        F1E86efsjDfbTsD4hvixg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698431230; x=
        1698517630; bh=SX5fl+EhwuJvuJSgszNvKWpCysGddZbGyxPGegx2anM=; b=F
        wk4pn7WFZEFlB6XbJ3pn0TwDefOr50L7wsw59vOtX4b5fWI0awk4sVgWYr4DMKyC
        +uDiOBSgBZxlPTTMXSvtslyXP+FptDNdGSrS89LvFb5OdfmGZ9boOsiZDskflHSM
        erxHbOOQaVebV/950eJ0A2jhVhlXce95GQddvpTsNn7F5qkZIsv3W8d0fcqTA1zk
        R4U35v+iZwkLAqN2fkk3lXnx4dwEyniCY1mEwiq6v+PtMGq1bdsXP2D5CWkNNu3W
        0lrbF8+fXDvEc/WT7e+EQQV6QW+QDN1iSZNQXtEO9NkrYQChkVDaWL/ptnExaKM3
        hJLNelkDszevOZcTWlBmw==
X-ME-Sender: <xms:_QA8ZccQ54tfTkmXKGJqd5XrTcy1n7ePLwL0MX2Cx7XNDwDP0eshdQ>
    <xme:_QA8ZeMK33uPp_jWvnlkJOOuOoM9xlzZtuSYqyGGM38VS5-1rzTDe0m9oPIPGOExU
    5uIwd4DhpUyYZ8Ri3A>
X-ME-Received: <xmr:_QA8ZdjsY_xYP_gQPeu4H7g8CmOimDWAQACyxQZV9MS1uXT0cPqPTrpWsPySR0resaAqCVp8CG4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:_QA8ZR9UWSkqkTO8VVe1_lN1OTFffYAUdcFkx7wJ91BEl_-dGquWZg>
    <xmx:_QA8ZYtvdIcWLPKsXwpLfb_mAvxtQ4TnDKxd2okYHyeI5bO_ZAbnMA>
    <xmx:_QA8ZYH81Cc6ovOM7V6e4U-R9iqN2sv00WTqq-D_Uhb3ZWPP8-wG6g>
    <xmx:_gA8ZSW70abzJYYV1_K4QNmwZ00aAPcDdo4VFm4q273IneEapd3Gag>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 14:27:08 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] serial, MIPS: Add MIPS UHI semihosting support
Date:   Fri, 27 Oct 2023 19:26:47 +0100
Message-Id: <20231027182650.281405-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027182650.281405-1-jiaxun.yang@flygoat.com>
References: <20231027182650.281405-1-jiaxun.yang@flygoat.com>
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

