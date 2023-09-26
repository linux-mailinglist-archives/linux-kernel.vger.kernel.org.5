Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60ED97AEB6C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjIZLY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjIZLYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:24:55 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C761AE9;
        Tue, 26 Sep 2023 04:24:44 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 27AAC320091E;
        Tue, 26 Sep 2023 07:24:43 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 26 Sep 2023 07:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695727482; x=1695813882; bh=8e
        yX8AE9ekmLAMHsyT0GeS5BenFeWtINVJaFHwwMKHA=; b=cx8XGgkMMAcNeF+sP0
        Xg3n1R6IWF1+SXDGfWQApF4gZU9gK98wjZ0TUjZLFzYcgq8P2RRJCuEdBdODa4hG
        LwKYI47Zd+dAN2sC7uN5feNdegP+GZb7mb4cJX3pFg4zNHKKCNFUQVkLrJt7eOGy
        av9AhHq7+EzE3QAK4jK325rz1w3OUvVLfAw7DSQa/RpNs7kW2gOSTtEgEjLwdWtt
        7feAoyTVZ6ZTf8BytvH5XSxMWdPKa/nb5dXvC6xyPHZVayjpYoBqiW4jAorTVJja
        tKWHNOJnDGBH7Oyl+MKk4DD1HRisrJ2FlsDSQ2niXV/P7ghs31CB4+l+dtJ2ytA4
        zyTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695727482; x=1695813882; bh=8eyX8AE9ekmLA
        MHsyT0GeS5BenFeWtINVJaFHwwMKHA=; b=pKJsOAmfVoi/4sfxkVCOWL4nh8SdI
        vTNfaOPB2+Cy4Ja/lQ3Dgdcqqf/JHimuqu1zmUPu1MzuyGpR4BlyFO2fOSqdBrJD
        dG/SXyM6XoU2sGTJ/NWIMZUJyoecgPZl0b6nkj8lpNQjaLInMfKBHXpPk9o0zZ8N
        f2+asD/QlnYjipjgbC2xO89dl7+ZJh/tBYo16z1ZVbUowwfDtPnG8XSWj18p/jjv
        meBDvYSJBIu94daupGg0yGr0/hZUoiL/siu6JSFMX15KLH3A7lYiXNIDrCUb5iLE
        h/XNs2TVtz2eqKBcgk+145ybDYVcHPe7ZyW0WxZitiwz6DTkzvjhbteiw==
X-ME-Sender: <xms:eb8SZZEcaTZMFMpYAflPbP6DpBY0f9Jbgp7wKzhigFCtCYXkqvNtBg>
    <xme:eb8SZeWLDfYUwqlJ229zBamM2dVDiNCtnh-GLyX9v_isYz0AZO3tkJodHRo2fUQWA
    X280YTNERWABvT2jh8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddtgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:eb8SZbKm8HNdpZENOy-r1jGJ0F1fTPCpY5PTtvi6CyNDh_zlLriqNg>
    <xmx:eb8SZfFRNuDq8yK_KKFGXpTKP27IkbOjDlPtYdTHBP_Y0-oiCUp86w>
    <xmx:eb8SZfUtLwmWAwAlUgE5KB6vkv-NwyElt2tvY67MHACBpgfWmUA18Q>
    <xmx:er8SZSON_9QoBQ-aD3tFSwDaNYnpnNe3yTR1YBLYE5qoeHqhQ02ViQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 716E8B60089; Tue, 26 Sep 2023 07:24:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <a08e1cee-05e0-447a-b25b-6c2ebb116e8d@app.fastmail.com>
In-Reply-To: <fbb6f526-0db9-4bbe-9635-8cb55b4335ee@app.fastmail.com>
References: <cover.1695679700.git.falcon@tinylab.org>
 <fbb6f526-0db9-4bbe-9635-8cb55b4335ee@app.fastmail.com>
Date:   Tue, 26 Sep 2023 13:24:21 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Zhangjin Wu" <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     "Palmer Dabbelt" <palmer@rivosinc.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>, paulburton@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Willy Tarreau" <w@1wt.eu>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        "Tim Bird" <tim.bird@sony.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Nicolas Pitre" <nico@fluxnic.net>
Subject: Re: [PATCH v1 0/7] DCE/DSE: Add Dead Syscalls Elimination support, part1
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023, at 09:14, Arnd Bergmann wrote:
> On Tue, Sep 26, 2023, at 00:33, Zhangjin Wu wrote:
>
> It would be nice to include some size numbers here for at least
> one practical use case. If you have a defconfig for a shipping
> product with a small kernel, what is the 'size -B' output you
> see comparing with and without DCE and, and with DCE+DSE?

To follow up on this myself, for a very rough baseline,
I tried a riscv tinyconfig build with and without 
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION (this is currently
not supported on arm, so I did not try it there), and
then another build with simply *all* system calls stubbed
out by hacking asm/syscall-wrapper.h:

$ size build/tmp/vmlinux-*
   text	   data	    bss	     dec    hex	filename
  754772  220016  71841	 1046629  ff865	vmlinux-tinyconfig
  717500  223368  71841	 1012709  f73e5	vmlinux-tiny+nosyscalls
  567310  176200  71473	  814983  c6f87	vmlinux-tiny+gc-sections
  493278  170752  71433	  735463  b38e7	vmlinux-tiny+gc-sections+nosyscalls
10120058 3572756 493701	14186515 d87813	vmlinux-defconfig
 9953934 3529004 491525	13974463 d53bbf	vmlinux-defconfig+gc
 9709856 3500600 489221	13699677 d10a5d	vmlinux-defconfig+gc+nosyscalls

This would put us at an upper bound of 10% size savings (80kb) for
tinyconfig, which is clearly significant. For defconfig, it's
still 2.0% or 275kb size reduction when all syscalls are dropped.

     Arnd
