Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9FA76C83C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjHBIRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHBIRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:17:20 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2163D19A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:17:19 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 3CFB43200754;
        Wed,  2 Aug 2023 04:17:18 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 02 Aug 2023 04:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690964237; x=1691050637; bh=Zl
        rPotTm9lgBhSGpA0zjVZ4BgRc4p+WCOMZ7mSc/ZXs=; b=URgVaSPTPr7V4rPjCD
        lDkR7qdDYd/tWGh3OiQsvKIj7/zbFRfeV6vVZdXctldLnBqYbLZWj6PaoD2duLmy
        y0roDij9g9fD78xqD0FsZlOrT8ufYuATK3dn5SoliSst45EvCuXxMZocrshqSNey
        zXJHY2x5Ni8RaCmpLK1VITyh7YxyJv10IJbtttwyPM0dGcTQVwAQY+uKsY+llpv7
        wLpFPLkxNejUVocoMrYtXL7db89hKMiX1AUeT7DYopV2PJedENQjiOVWwXwNQdu0
        EAgwlFWRypLTr4Bs7lf7z0avbRxTW6MuDE/wqfspvRTZNreD29pmdsnzh9bmHPSC
        GBIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690964237; x=1691050637; bh=ZlrPotTm9lgBh
        SGpA0zjVZ4BgRc4p+WCOMZ7mSc/ZXs=; b=ReT4wNgMzddIkJ3a4WFmi/HHT2+TU
        6nu0N4fsVwDLom89Mo1kvc3ObxKW5O0Qo6ipFYsTyeJRygYCyQ+HscS+4ZHOEE0M
        62W1LvBuoo9jwYWvfHGI8q598r+u/Y1VywpQxjrD6Gf4N1e8OEIuCuVG2aQwILXV
        VMN1+3tBDhhz83KZZvgd9mBAN5kuyLPC+ac2rF0kOuKVQpfYX0C/kTnteCaNekS0
        UJ78fs3XCwtjPkMgAQv0no9ZfIShK9vsGEQ0SWDO4eoqJS6Fwl5g672SX8smnQ1V
        wNxAcHgKs3bDlL3kvGpci0FsHwLi49A3Y1e18aPDtMGPsaKUSBd9QGMJQ==
X-ME-Sender: <xms:DRHKZNqGOI7P5bytL466aqm0DpvVhY0XX04m_VJ9PTAXDpt-Zw89pQ>
    <xme:DRHKZPpiJ_wlhOnL3zUXTfGp5AsW4TwEF8oiCie_nMVmKamkWKihpjwQWWoqnCggU
    EKz53MFg6kmGrlNZwc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeekgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:DRHKZKMYisFg_rhmZZfWnc-PDyB9Zx2xAW7fN6maKdgQv8tVYpfvEg>
    <xmx:DRHKZI5bFs9R08mP_Tfgwvnpu0XEjdANk0MDiMUdtrO_j3L4ab-YZA>
    <xmx:DRHKZM5T8gnjCy5jYOQhZL379hsqANo-ORF2Huoo6xWeBFR8uzLd4w>
    <xmx:DRHKZMHM2pWc6vYdH6QDJ_Per6rYhWDjo_UtbKpm2WzQYTsLdk1OgA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 48915B60089; Wed,  2 Aug 2023 04:17:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <d2c8e5ca-44e0-41ec-84d0-ef743a62a2a1@app.fastmail.com>
In-Reply-To: <20230802-abgaben-behutsam-92946d2ecbf5@brauner>
References: <20230802051924.7837-1-rdunlap@infradead.org>
 <20230802-abgaben-behutsam-92946d2ecbf5@brauner>
Date:   Wed, 02 Aug 2023 10:16:56 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christian Brauner" <brauner@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, "Dinh Nguyen" <dinguyen@kernel.org>,
        "Christian Brauner" <christian@brauner.io>
Subject: Re: [PATCH RESEND^2] nios2: support clone3() syscall
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023, at 09:40, Christian Brauner wrote:
> On Tue, Aug 01, 2023 at 10:19:24PM -0700, Randy Dunlap wrote:
>> Add support for the clone3() syscall to prevent a warning from
>> checksyscalls.sh:
>> 
>> <stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>> 
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Dinh Nguyen <dinguyen@kernel.org>
>> Cc: Christian Brauner <christian@brauner.io>
>> ---
>> Is there some reason that NIOS2 should not (does not) support clone3()?
>
> Cc Arnd, in case he knows.

As far as I remember, you left a few architectures without clone3
during the introduction when there was neither an obvious way to
handle the syscall entry nor a maintainer to have a look.

Right now, it seems to be missing on alpha, hexagon, ia64,
microblaze, nios2, sh and sparc.

There are a few architectures that implement a custom entry
point for both clone and clone3. The other architectures that
provide the generic sys_clone3 also use the generic sys_clone.
These are the wrappers I see:

# ARC
ENTRY(sys_clone3_wrapper)
        SAVE_CALLEE_SAVED_USER
        bl  @sys_clone3
        DISCARD_CALLEE_SAVED_USER

        GET_CURR_THR_INFO_FLAGS   r10
        and.f 0, r10, _TIF_SYSCALL_WORK
        bnz   tracesys_exit

        b .Lret_from_system_call
END(sys_clone3_wrapper)

# m68k
ENTRY(__sys_clone3)
        SAVE_SWITCH_STACK
        pea     %sp@(SWITCH_STACK_SIZE)
        jbsr    m68k_clone3
        lea     %sp@(28),%sp
        rts


# mips
save_static_function(sys_clone3);

# openrisc
ENTRY(__sys_clone3)
        l.movhi r29,hi(sys_clone3)
        l.j     _fork_save_extra_regs_and_call
         l.ori  r29,r29,lo(sys_clone3)

# parisc
        .macro  fork_like name
ENTRY_CFI(sys_\name\()_wrapper)
        mfctl   %cr30,%r1
        ldo     TASK_REGS(%r1),%r1
        reg_save %r1
        mfctl   %cr27, %r28
        ldil    L%sys_\name, %r31
        be      R%sys_\name(%sr4,%r31)
        STREG   %r28, PT_CR27(%r1)
ENDPROC_CFI(sys_\name\()_wrapper)
        .endm
fork_like clone
fork_like clone3

Nios3 in turn has a wrapper for sys_clone:
ENTRY(sys_clone)
        SAVE_SWITCH_STACK
        subi    sp, sp, 4 /* make space for tls pointer */
        stw     r8, 0(sp) /* pass tls pointer (r8) via stack (5th argument) */
        call    nios2_clone
        addi    sp, sp, 4
        RESTORE_SWITCH_STACK
        ret

so my guess would be that it needs the same thing
for clone3 as well. Same thing on alpha, ia64 and
sparc. On the other hand hexagon, microblaze and sh 
use the generic sys_clone() and can probably just
enable sys_clone3() without extra work unless it's
already broken.

       Arnd
