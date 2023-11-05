Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74F97E13F6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 15:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjKEOtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 09:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjKEOtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 09:49:03 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E3EC6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 06:49:00 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C848032007CF;
        Sun,  5 Nov 2023 09:48:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 05 Nov 2023 09:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1699195737; x=1699282137; bh=4MjQo55h4T
        o9DLao6GrOz2Dpb9CF/KX7SNVATC19L+4=; b=Qj7toek/tEW0e1NeYcUvUT77iB
        C8h/DGj+ODoUs4xP5a6mlRh4jc9jTO2t1IHUPa5uSlM6dAJHHjjL14sX+5dUmuz5
        cd3RmJYb5FgJs0GBa0q0mEMTWSe7wtsrF5ypyGjBtTBcxWeZP4qDXcCbVVUa0DwG
        11ChG7mi+8HolQUBDSTkHCsy7I9Yr8XuXYbluwPiGaYyzBO5tLBfIShh4ZxfF3RY
        X7sg7EQLz/WpdZIRZLJwOa4HhQ7M3kfnV3D5mHEeur9h6Qzq3oRGE08sDPShkVJ/
        NYIfAmE3sn2Tv960+kwc8xcMZbRdFOjV4T/FkPGKUrvgMgsntEIBT6cvX+YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1699195737; x=1699282137; bh=4MjQo55h4To9DLao6GrOz2Dpb9CF/KX7SNV
        ATC19L+4=; b=c4Y2yPHv1F3JPYY2mGVUZhmusxg1Ne1dPuqVVZsu3HyVDjT/0Sj
        R5aq8caZUk27bIbmOigFWh/TEuQ7WKucjsAw/oM/C6M4wZRbE91oAdT8zVNI/BlF
        /d1SRKtul0SDWDyIjGBw6PTP1C02vZaZksB1VN1U32ycPuyxBgd5XxoSCnksTOQc
        x83Oj737MKToMBwlyWDWrS1PdY0bPj4BPV2Nnb9JU541upGm2VaNa1F9HBuVOVdQ
        BmQoVKlM4cIwhvok6zcdIb3sMAg5iORg5UNhgqw5juVvYNA8RwoS4mrIg0XQ/F5c
        r9HUWYrLxjXkPGotOR7UbrO7TDQi8vylYoQ==
X-ME-Sender: <xms:WatHZaAYPerxev-krJERolawIiLHy0MEhhtHNUlR5Jwya9Z-SPUDBw>
    <xme:WatHZUhYmVvgMZZgCxdUXkSY6AUelCGKElaaLbuCGtO9sLusdspFcKVwF9fdmrNq1
    0rRtsKUq6ZesROVIM8>
X-ME-Received: <xmr:WatHZdmeW49zS-FOdf-vpuxJlIN9EaGXb5TawNjczluK2nNWqJeH9Z2Uth35k0gjQHzELttoEZUWPAbneLQG27Cp4S97oVgY8SY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduvddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedugeehgeefvd
    elueekjedvtdehtedtledtjeehtdeigfefueffffehgfetvddukeenucffohhmrghinhep
    shhushgvrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghh
    ihdrjhhp
X-ME-Proxy: <xmx:WatHZYwEqT2ePSFPCuGbLT7pZUEeaQ9aBcZq4pULeZtzV9nL6G_P6Q>
    <xmx:WatHZfR7YPAhtn06ubDqoQ-hJFvD7seW_6JNA9VxLE_dO8IscmBntQ>
    <xmx:WatHZTabSGZf1rg7f8I1Axsb95oYHLrYz4BR1NIEHjXYCbXt4flh1A>
    <xmx:WatHZQ5eIke3PbznWFkM2h1zO_6qV5mb430z4YMZzMchUZZZrYHycg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Nov 2023 09:48:56 -0500 (EST)
Date:   Sun, 5 Nov 2023 23:48:52 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] firewire updates for 6.7
Message-ID: <20231105144852.GA165906@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the pull request from FireWire subsystem. It contains a slight
change in core function itself. I'm glad if you accept it to your tree.

Allow me to report a regression of PCI driver for 1394 OHCI hardware in
kernel 6.5 or later. When probing the hardware with following combination
of chips on Linux system running on AMD Ryzen machines, the system
unexpectedly reboots.

* Asmedia ASM1083 (PCI bridge)
* VIA VT6306/6307/6308 (1394 OHCI controller)

The issue has been reported by users from OpenSUSE 
(https://bugzilla.suse.com/show_bug.cgi?id=1215436) and Fedora
(https://bugzilla.kernel.org/show_bug.cgi?id=217994), and I can reproduce
it on my local machine. The superficial cause of issue is accesses to
Isochronous Cycle Timer register in OHCI control register space during the
PCI device probing. However, the exact mechanism triggering the reboot is
currently unclear, as the system does not provide any useful output. In my
experience, this issue does not occur on Intel machine, AMD Sempron 145
machine, or with different 1394 OHCI hardware from other vendors such as
Texas Instruments. While it's possible that there may be code issues
within the PCI device driver, I think that specific hardware quirks exist
in the combination of the Ryzen machines, the PCI bridge, and the 1394
OHCI controller, since I can see another issue of cache-coherence over
DMA memory mapping in Ryzen machine with VT6315. Anyway I'm still under
investigation and wish to find any workaround as soon.

----------------------------------------------------------------

The following changes since commit ffc253263a1375a65fa6c9f62a893e9767fbebfa:

  Linux 6.6 (2023-10-29 16:31:08 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.7

for you to fetch changes up to c12d7aa7ffa4c61443241fbc1ee405acf4aa17de:

  firewire: Annotate struct fw_node with __counted_by (2023-11-05 21:15:17 +0900)

----------------------------------------------------------------
firewire updates for 6.7

The pull request includes a slight change for flexible length of array
in core function.

Kees Cook provides a patch to annotate the array embedded in fw_node
structure referring to structure member for the length of array. The
annotation would be defined by future extension of C compilers, and
used for access bound-check at run-time enabled by UBSAN and
FORTIFY_SOURCE.

----------------------------------------------------------------
Kees Cook (1):
      firewire: Annotate struct fw_node with __counted_by

 drivers/firewire/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


Regards

Takashi Sakamoto
