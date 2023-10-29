Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1117DACA3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 14:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjJ2Np5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 09:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJ2Npx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 09:45:53 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5E3BF;
        Sun, 29 Oct 2023 06:45:50 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 1FF0A320027A;
        Sun, 29 Oct 2023 09:45:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 29 Oct 2023 09:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm1; t=1698587147; x=
        1698673547; bh=jtPdlzGB01j+zIhuSpzNxxVPJdcsn8CG2BgqukBh1go=; b=N
        D5yxJRP5opfVgZKtMKBoAihYpEsAlQF8+jFRodmy5WMW9X6XapO0DO0WWE1uzJSH
        Vi9eff7xlGmJbvmHc+TFxhiOxsBWEl3f1+ZWsYV9zwfEKFs2JwTxPxfd5+9oDMQ2
        ivGvwPp+pQdTw4eEsSCKXUNNmmMFQCn9QfWh8fEc2T1QPR7Nb/uSprQFqCqYpAp5
        xo3YK2pPSVUAeZQQvOFRvyFJSEk9LXxsdXIbQds91EECRV+WaqcULr/p2sJbLvZ+
        IowKAk6fk6PuRfGQQCl/15YuWh1MHlKOVuVzB3krtvOkokgV29MkszKPs/gJD67j
        Fs0oAb7T+r3geroFQnJfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1698587147; x=1698673547; bh=j
        tPdlzGB01j+zIhuSpzNxxVPJdcsn8CG2BgqukBh1go=; b=XfkW8ZcZy5CKQgjy6
        BlTa7z54/h6yFwR0X3phR71tD32QMx6m0/S8rcR4py7jUAP2wfFtaWfVx7doC2NT
        xACVwd+JudeS1TQohvz10/sb1tfIG0+2UldF8cMhYnSTM9qg7GxO2iXRyfS+BiKK
        KdEFKnIm7tiOQ6HZjGJuOgchDQEYMnBT5miv31ZPwxikkV4OMGw4ThwXBsL+Uv3z
        gr6GObE9lpcU32yUU6DQENIY69xSY6oEbokxCwNajt6J9ao1G+O2ohVa2yhMyDS2
        iyBMu/3hYFvnBe5JSvO1QnaPZ2CdC++bcy3tOBbG5h3lxOVD47zPFGmsUc7rhV1W
        ZkCbg==
X-ME-Sender: <xms:C2I-ZcTvDml_zop-4itdjKi3w_GY4IoNUxTr_ta-9VWlzPqacm1Ljg>
    <xme:C2I-ZZxKbG-kdEyx_XlW6vwcZHYHqGaczeIq7fmGmSBxRFoDKexdOyahVrBQK5zlU
    Y6os9_BNXFXGb1puIw>
X-ME-Received: <xmr:C2I-ZZ1EVMPWjzJ2GYcVTT2h_-3zWWKp3TN-SadY7dM-4vlHmXIhR-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfhirgiguhhn
    ucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtf
    frrghtthgvrhhnpefgveffjeetgeejfeelgfekteelkefhuefggedvueeujeekjeetkeek
    vdffffefudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhl
    hihgohgrthdrtghomh
X-ME-Proxy: <xmx:C2I-ZQCxJYyL2Gso1REu5RdHVqUb96HqQirjL1X92TDRA3Fwe_t0fg>
    <xmx:C2I-ZVghVvFCw_jhxWMetrWpU7qVcsBS0XYHgo51O5YhFDRhSLzWRg>
    <xmx:C2I-Zcrep7H6mD8Iu2Op9k5bx0xBL05YAmzFG22Zr60Yo-A7UES0Mw>
    <xmx:C2I-ZYsBU9FHTVi05hw2XS14imais39xSopFc9xMbGWze9YKv9xPjw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Oct 2023 09:45:46 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/8] MIPS: Unify low-level debugging functionalities
Date:   Sun, 29 Oct 2023 02:53:01 +0000
Message-Id: <20231029-mips_debug_ll-v1-0-d7a491e8c278@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA3JPWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAyML3dzMguL4lNSk0vT4nBzd1DTL5ORUQzNzM/MkJaCegqLUtMwKsHn
 RsbW1AMsMQrtfAAAA
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a attempt to bring all low-level debugging print functions
together and provide a arm-like low-level debugging interface and
a further function to debug early exceptions.

The plan is to elimiate platform specific early_printk and
cps-vec-ns16550 by debug_ll and earlycon.

cps-vec-ns16550 is leave unchanged for now due to pending patch[1].

Hope you'll find them handy :-)

Happy hacking!

Thanks
Jiaxun

[1]: https://lore.kernel.org/linux-mips/20231027221106.405666-6-jiaxun.yang@flygoat.com/

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (8):
      MIPS: asm: Move strings to .rodata.str section
      MIPS: debug: Implement low-level debugging functions
      MIPS: debug: Hook up DEBUG_LL with early printk
      MIPS: debug: Provide an early exception vector for low-level debugging
      MIPS: debug_ll: Add Kconfig symbols for some 8250 uarts
      MIPS: debug_ll: Implement support for Alchemy uarts
      MIPS: debug_ll: Implement support for AR933X uarts
      MIPS: zboot: Convert to use debug_ll facilities

 arch/mips/Kconfig                        |  12 +-
 arch/mips/Kconfig.debug                  | 212 +++++++++++++++++++++++++++----
 arch/mips/boot/compressed/Makefile       |   9 +-
 arch/mips/boot/compressed/dbg.c          |  37 ------
 arch/mips/boot/compressed/debug-vec.S    |   3 +
 arch/mips/boot/compressed/debug.S        |   3 +
 arch/mips/boot/compressed/decompress.c   |   6 +-
 arch/mips/boot/compressed/head.S         |   6 +
 arch/mips/boot/compressed/uart-16550.c   |  47 -------
 arch/mips/boot/compressed/uart-alchemy.c |   7 -
 arch/mips/boot/compressed/uart-ath79.c   |   2 -
 arch/mips/boot/compressed/uart-prom.c    |   7 -
 arch/mips/include/asm/asm.h              |   2 +-
 arch/mips/include/debug/8250.S           |  60 +++++++++
 arch/mips/include/debug/alchemy.S        |  46 +++++++
 arch/mips/include/debug/ar933x.S         |  41 ++++++
 arch/mips/include/debug/uhi.S            |  48 +++++++
 arch/mips/kernel/Makefile                |   3 +
 arch/mips/kernel/debug-vec.S             | 194 ++++++++++++++++++++++++++++
 arch/mips/kernel/debug.S                 | 130 +++++++++++++++++++
 arch/mips/kernel/early_printk.c          |  19 +++
 arch/mips/kernel/head.S                  |   4 +
 22 files changed, 750 insertions(+), 148 deletions(-)
---
base-commit: 66f1e1ea3548378ff6387b1ce0b40955d54e86aa
change-id: 20231028-mips_debug_ll-ef9cce16767b

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

