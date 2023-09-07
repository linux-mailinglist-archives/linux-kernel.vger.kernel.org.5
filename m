Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2276D797F72
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbjIGX5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbjIGX5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:57:06 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA211BC8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 16:57:02 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id CDD205C01B7;
        Thu,  7 Sep 2023 19:56:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 07 Sep 2023 19:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694131019; x=1694217419; bh=+7pgqLGNps7ru
        3XDKk84aBvcEHC6gQtbMxC/jw4A3UM=; b=tmruPd0iqZauQz7vC0ffnf8bkuyyC
        1ijwwK1IF8Abdh/RdoKapqeCl5xGXIdU/CqSdbEIs64ALcTCqNqeoT5lCCnSUfjf
        Egfji+KqfLIUvHh9N6sXatwagPs1B172iH4mH6Rc8wx+S3Eq/dlrIFiZXjZkhYhf
        9/8phocbzl3QujfJvm8cp3MNkx6LVEOgRuspwuAZKhFc4DcEaI2bsT7EXUNl7aqN
        +ld1QGq8XlWpr+h5ZFrbOhv86WUNXU3VZmDTlwaECLbgnDSO33ny+iWYerLkddlt
        D/WXZlfwg8vDiS9BjWSXDsMGIfkqoTcQiAmUYo5bHq26r0NJlj7IGKQlA==
X-ME-Sender: <xms:S2P6ZPvu8CAyvwhLeNB3Dp7QFgdCS1djbm1VMnQSe0HzKzP1JRRS8w>
    <xme:S2P6ZAdfpb6pR_7IoDCNjorWaQ_fgmzuPsta6YilUNzFaWRfr0uvGEGuHdV2C29fZ
    2QnhoEQNRa38upD3H0>
X-ME-Received: <xmr:S2P6ZCwYnmOCv42DveI8jeOm0CYAe2Vb30iLBset3yPUnKwFzaCBwNOv6SyNq_n5HU3RCSujtaLTBMscKhuTCRmoVMo2h-Lawvo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehiedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:S2P6ZOM-eylmdVEVhl68kL_KINhOpcaC2-bXcRvaHAp6lA5lreQCIA>
    <xmx:S2P6ZP98gXMATucx26GsvxP3DJ2mOCS7_YUisn0AixlP575powG0Fw>
    <xmx:S2P6ZOXuaWL--SxSDY2l-uVoY2M9wn-DzZNmTEt0FbhGm_me8s-r7g>
    <xmx:S2P6ZAO5UFTx1ojwd0ex_PocZhvuYB1bVPx6XEoL3X7jaLHKNy6dwg>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Sep 2023 19:56:56 -0400 (EDT)
Date:   Fri, 8 Sep 2023 09:57:01 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Philip Blundell <philb@gnu.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/52] m68k: atari: Add and use "atari.h"
In-Reply-To: <0778d9dd186928666d760d5523c7d2311f781621.1694093327.git.geert@linux-m68k.org>
Message-ID: <142e4eb5-b47e-e27c-1be3-bc6c5df889c0@linux-m68k.org>
References: <cover.1694093327.git.geert@linux-m68k.org> <0778d9dd186928666d760d5523c7d2311f781621.1694093327.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2023, Geert Uytterhoeven wrote:

> diff --git a/arch/m68k/atari/atari.h b/arch/m68k/atari/atari.h
> new file mode 100644
> index 0000000000000000..494a03ddac3d16ae
> --- /dev/null
> +++ b/arch/m68k/atari/atari.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +struct rtc_time;
> +
> +/* ataints.c */
> +void atari_init_IRQ(void);
> +
> +/* atasound.c */
> +void atari_microwire_cmd(int cmd);
> +void atari_mksound(unsigned int hz, unsigned int ticks);
> +
> +/* time.c */
> +void atari_sched_init(void);
> +int atari_mste_hwclk(int op, struct rtc_time *t);
> +int atari_tt_hwclk(int op, struct rtc_time *t);

Wouldn't atariints.h and atarihw.h be more appropriate places for some of 
these?
