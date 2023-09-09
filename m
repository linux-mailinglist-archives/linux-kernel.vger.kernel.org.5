Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB407996DB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 10:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343623AbjIII2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 04:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243092AbjIII2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 04:28:40 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D6E19BA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 01:28:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id CE1D95809CA;
        Sat,  9 Sep 2023 04:28:35 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 09 Sep 2023 04:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694248115; x=1694255315; bh=yhLobfQ0x+LkGN/nwOrxq0JVysZ+tCF7Qsj
        rXNCba/M=; b=HQE1Y+b4ncRnjXU6Bukn3hmuQsSaJ4wBIjwWAqcUL9dXyTS+TNU
        aijv2yyilUAWuH/ZJAJ0q77lEqe7q2C+qtzFo0M+scKmQIktBzUC/jrfakjCtJub
        E9lc8dY7GeMksyJSYaI5+0eFmFX5/ZtquIamcl9x49S664x2/LOYaD0JrEDT7gLd
        IfbT8GeOVnCMP92RQH0IvBVKV6N+FeXCiN8ckjshT4I+7uxuUYcwTGqAMO4LeFK2
        l5DfaRAyzt6OnPtjz03WG83VQIWGHVHQ8PCNw1v2tLz7PRHzeV+Fy9kNHBm5rrrV
        tjw9+sOupGtwaaXr6EHsZsq/u4cdRI0UEfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694248115; x=1694255315; bh=yhLobfQ0x+LkGN/nwOrxq0JVysZ+tCF7Qsj
        rXNCba/M=; b=v/nw40CfuTVNlbAiRLW2xwO/F3EugkMmE1jJZoUUnGqb7Y5vxVr
        gOwv+IAgdjBZ4H0M6ipthYS+RzpmOuHVX4qeA2pOMUHM1MF8u+k8yqPLGFGKgr6p
        dU6XqV0OFWo03XeR8dx5vDg7I/mSzMjFhgS1pDIdaOYpmjWrqr4zdRI5TkCx/pwx
        F2Nrr5kJtMpRB1QDhdRNGGCV6OYMCAMs+Be5OqdHoxdH2LHPXr7RVB2XrSUNYlqV
        2cv4sahpv35j5TTlnSWJQsGStIz4gvB+Z1Z725ThTvH2Rvojn5dpBriMiwsRZ1eC
        b7ckw6OdLGsQiSvshiFLD7YengyrW9vYuFA==
X-ME-Sender: <xms:syz8ZIc5DByuy2w_WxQwglZgAJrI_7jyOuEF1XUEI1V4EEdtNXf-wA>
    <xme:syz8ZKPkTU_IfhYKVuy5QuP0lGywwACkV7zahISrZj6nGjLqrnVHKppE5R5kFwUUQ
    uI3NCj9gRpXi0OlW-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:syz8ZJgjOdfI6farxGvSchTvgdzIbDzhaW-vJlGlVwq8YVTBF5BeFw>
    <xmx:syz8ZN8jUt4M4kk-GMrbNnFDJFXs4OWvpIrXSutPbjzb8QMiOY-7xw>
    <xmx:syz8ZEtkCyX2d2ieV48Fde4PVT-AeVPpRwU6qOZJ6Gvt-fbPVFC6Hw>
    <xmx:syz8ZJ_d1WoMmlbOPeL_CGSjJKVuiBoPyFMA7VI-qCVmUj4pQIUkuw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0DBB0B60089; Sat,  9 Sep 2023 04:28:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-711-g440737448e-fm-20230828.001-g44073744
Mime-Version: 1.0
Message-Id: <2545f40a-0c59-491d-895f-4a7975faaedc@app.fastmail.com>
In-Reply-To: <64ea8cf65a4318fbf8c91cb3062d90a2555007c4.1694093327.git.geert@linux-m68k.org>
References: <cover.1694093327.git.geert@linux-m68k.org>
 <64ea8cf65a4318fbf8c91cb3062d90a2555007c4.1694093327.git.geert@linux-m68k.org>
Date:   Sat, 09 Sep 2023 10:28:14 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     "Finn Thain" <fthain@linux-m68k.org>,
        "Michael Schmitz" <schmitzmic@gmail.com>,
        "Philip Blundell" <philb@gnu.org>,
        "Greg Ungerer" <gerg@linux-m68k.org>,
        "Joshua Thompson" <funaho@jurai.org>,
        "Sam Creasey" <sammy@sammy.net>,
        "Laurent Vivier" <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/52] m68k: emu: Mark version[] __maybe_unused
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 7, 2023, at 15:41, Geert Uytterhoeven wrote:
> When building with W=3D1:
>
>     m68k/arch/m68k/emu/nfeth.c:42:19: warning: =E2=80=98version=E2=80=99=
 defined but=20
> not used [-Wunused-const-variable=3D]
>        42 | static const char version[] =3D
> 	  |                   ^~~~~~~
>
> Fix this while obeying the wishes of the original copyright holders by
> marking version[] with __maybe_unused.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

That will just drop it from the object file, maybe it should
instead be marked "__used" ?

      Arnd
