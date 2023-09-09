Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687C979961B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 05:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbjIIDfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 23:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbjIIDfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 23:35:09 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5A91FDB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 20:35:04 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 94E5C5C00DA;
        Fri,  8 Sep 2023 23:35:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 08 Sep 2023 23:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1694230501; x=1694316901; bh=7qKxF25X/y
        ixp8+CfoJbiwkUN/JTDm1XwVO/dTBVGew=; b=CS/QnkaYkt7n0oP/OnVUGTkg28
        WfLgYAzBoS9eOfU+6MZWPrTpKrDxQG0aCaYyKHdz60KN5MPAJZk3OkICAPF0SCpY
        xwqPNoV1ChCGM7BvjS9WJa+54OvFt9BvLYAE7MPnhpxVOfDL+1pWpcv+WlAN4pDZ
        0C/iNbxh3afsgnxt8/qhDD7HUib2yJxtDGRPfH3/E8y4lKh98FjKd0oJGDpkhv7w
        C7UVyF+od9CHpUrfEQDaPmJdpj8deirUbBjXTiH85Kkw5oplBJyOnjp/qv7QBGeN
        qIrxHp8W4wMywTCBEiz4tLm3HRjIOarQs046MGq+XOftJh28Qm/UWKEECktQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694230501; x=1694316901; bh=7qKxF25X/yixp8+CfoJbiwkUN/JTDm1XwVO
        /dTBVGew=; b=biFHUAHr2saW74LScns2QClVga24RavUf6/y6Gg4zRAp1Z1VIoM
        u2IRpeKaJOVg/mXH5vcIYZvDzhxTSh0QmY5+VnIk0Jspj2c8aVXoyZWbZEMTAh/m
        UMypLMB9JWCEIQViFOscz6DPn/xqowDX2ms2ry2HUOM2BWjxkThRcbGdP+r5sA8f
        I4dg0Ge8SPau3gwlz+93UBcFf51zqOAJ4b3Eje+Lm4cnFIF0CIqxYvpfeKY4uzso
        BrtND4LwBzkEBKO2dvMu2ZAnVgGnhSMlyAnTiTDt818XaTSPhNe67+tbKmK51zd5
        X+rzj8UgLBoAe7XIDmHaUC2P9HOrinj9UqA==
X-ME-Sender: <xms:5ef7ZG1O0qUlaSe8ZwCobrLzDxQsu0CAjzeZs0_GXvq6Fn_8R7mjHQ>
    <xme:5ef7ZJFuc6c7dKn6GX0L0dUqZjrWas3fFlZaxFPeyehPpHNGX6VImfi-_QIyTbRv6
    ENh68LdXCQPD4BqGTQ>
X-ME-Received: <xmr:5ef7ZO6xiKTD8jmkMecrGgQRZNkFacOz2ZnJpjNxcPPvRWhjnTZbhNVTlcP4cTV6h4YRoPgjwKW69kjIDHmyeYYPrNoD38_-rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehkedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeetfeeiteefve
    egvdfggeffheetleejkeekleeugeffffdtgfdtteetkeevvddvgfenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:5ef7ZH0CW46g9zVDd3LTmDH1QQSu6z3SaFwKzRUrVY_IURjCxJgOsw>
    <xmx:5ef7ZJEhfE4kANzvn6QXWRhZOsz54_WzTgGW1Db48hxkNF7_35Z2Sw>
    <xmx:5ef7ZA8tlSEj4-u4JYVySsl65ZRsVfjAGNMMSK21pyuRbO7b9GpB9w>
    <xmx:5ef7ZMPe1M2ZnjBeqHmEno3O24oFiR1Ji5cNwxcALTmtfxxfLRh-tA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Sep 2023 23:35:00 -0400 (EDT)
Date:   Sat, 9 Sep 2023 12:34:57 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] firewire updates for 6.6
Message-ID: <20230909033457.GA59845@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull firewire updates for v6.6.

The following changes since commit 2dde18cd1d8fac735875f2e4987f11817cc0bc2c:

  Linux 6.5 (2023-08-27 14:49:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.6

for you to fetch changes up to fd416616d0995f4947dd0a7a8c2ac4d9f916a9d0:

  firewire: allow deactivating the IEEE1394 menuconfig section at once (2023-09-07 19:11:17 +0900)

----------------------------------------------------------------
firewire updates for 6.6

The pull request includes a slight change of configuration entry in Kconfig.

In the second half of 6.6 merge window, Jan Engelhardt sent the change. It
allows any front ends of Kconfig to deactivate FireWire subsystem at a
clip. I would usually nack such late change and postpone it next merge
window, while it includes no impact to existent CI build in the world since
it just a hint for the front ends. I would like to include the change in
the time as an exception.

----------------------------------------------------------------
Jan Engelhardt (1):
      firewire: allow deactivating the IEEE1394 menuconfig section at once

 drivers/firewire/Kconfig | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)
