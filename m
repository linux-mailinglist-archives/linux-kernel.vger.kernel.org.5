Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556977A1BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbjIOKFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjIOKFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:05:07 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC3F4489
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:01:57 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 22AFB3200976;
        Fri, 15 Sep 2023 06:01:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 15 Sep 2023 06:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1694772092; x=1694858492; bh=bvSMhElmkv
        fznLgl5c8sT6LHpxhlXaxMtsom3WPqn90=; b=LxYlaN4zOGQGQUwkb1LyLGwkeO
        oJovUpMcq0UmdwZdbrXVcSgY8C88+EkFur+bRxXEfCNJqPzH9GJSNeDVJd73BCv/
        cpu9CfV7rqFw6/AUD9rlH5cyeHjMCaHO93aEu2dRhdWtzHZoWXmXN40DCFw6PHof
        YL8hrZkpbJbj0ed9wagM6z2om9B5vyeelJmLVDMYxOaOC1m4hJR04cH4S3qlORMk
        IgcoKVCgqRAfPF9jP2bIhsXSmpS7R0NtUp9yc6N0TOOpwGZKDmgcoFXDyh3E5JbW
        Wbe2V9m2VpWPy5AZh92DfnwUTKug1+3VyDV0tRaYaQwqCWJgSWcX5D/d1JXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1694772092; x=1694858492; bh=bvSMhElmkvfznLgl5c8sT6LHpxhlXaxMtso
        m3WPqn90=; b=Gra5pVKw+y2CYGY36PVUM5k/4dYK5r6i03lSBNW/TLgjlp9pX87
        IVxTMF80XPeG+q06Xuhpxfd7Wh6QHTCONTh+zLcVcW4TrhnDhDlawM9PUNPCBIhr
        d1FGKWVApK9j+qh+TK+5f94gM2s+MZKVeLMbYvtIn5ZLyYc1c4bV11rb8KM/qvkW
        kMaJS8z3xNQnoQKoQT2csO9OpGO9WobNAslZLv3kJE/jMTfSSeE5kWyZp1DX7m/K
        9cz4+7YEzG1vfENceI/vY9l8UsZIbK9PIE3CtoYWhU9JSy6ycDI6vnFuWp1XQ2w0
        ZsbggwZneUMLD427+xuDqHK5VsQuwKwNt4w==
X-ME-Sender: <xms:fCsEZanFVIqBvQ7q8gYiQkAh4JkkG-h-BBNSkmcIrhDtjHD-mrk4XA>
    <xme:fCsEZR0bcB1idUNe9AYUw3s-S5z4O1za4lQQ0JcjRt_jpW_i2xW_vI06AkDS5KZ6-
    iWDDDJFFxD08dL0NH8>
X-ME-Received: <xmr:fCsEZYrxM1103zQK4lYokoDZ7Q7g-drKVRUrEbh6499eR_CMuVqjnroUsFVAa9lZu6929fwsj1fVniFbf296cDiZU3GCFhdifQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeetfeeiteefve
    egvdfggeffheetleejkeekleeugeffffdtgfdtteetkeevvddvgfenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:fCsEZek_O_b0L0eqvJDQ0XHkH8ZTquWCpeFYvcTpC4-lfjvzK1SxDg>
    <xmx:fCsEZY1QtUeBZkQ9-Uo4_H3w3ng26K5rTnkVRg0la4B60syP3Y03_g>
    <xmx:fCsEZVuWdHeEc8HKBHhQVO0KUavRoszaX-XyiYVeo_gw1txrbmCw2g>
    <xmx:fCsEZd_19Q2J1LdJRH1sPN2-Ux9u3xDBL6rpigZ1sg49JlOevdQ3Xw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Sep 2023 06:01:31 -0400 (EDT)
Date:   Fri, 15 Sep 2023 19:01:28 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] firewire fixes for 6.6-rc2
Message-ID: <20230915100128.GA140388@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.6-rc2

for you to fetch changes up to 3c70de9b580998e5d644f4e80a9944c30aa1197b:

  Revert "firewire: core: obsolete usage of GFP_ATOMIC at building node tree" (2023-09-15 18:37:52 +0900)

----------------------------------------------------------------
firewire fixes for 6.6-rc2

A change applied to v6.5 kernel brings an issue that usual GFP allocation
is done in atomic context under acquired spin-lock. Let us revert it.

----------------------------------------------------------------
Takashi Sakamoto (1):
      Revert "firewire: core: obsolete usage of GFP_ATOMIC at building node tree"

 drivers/firewire/core-device.c   | 2 +-
 drivers/firewire/core-topology.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


Regards

Takashi Sakamoto
