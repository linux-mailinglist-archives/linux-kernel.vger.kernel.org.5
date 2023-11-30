Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9E07FFD9E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376943AbjK3VhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376859AbjK3VhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:37:09 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1215E194;
        Thu, 30 Nov 2023 13:37:15 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8071A5C01BC;
        Thu, 30 Nov 2023 16:37:12 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 30 Nov 2023 16:37:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1701380232; x=1701466632; bh=Zz
        F9h379MrAFj54pXWhL+XcbpUP3DpZlKzF1Dnx5FrY=; b=VUwU1hZ5uvMFqnriFi
        fZNJ2fUdH7Aa5LbOPjDXL+SMTdE1URP+lXR4UgpTdHT0/25JMTdeoI1foTS7o7HP
        3v6lsx2tcZwvY0cYSv2A0NVWSyvoaR8S0CW+gtYZb77WwTaP1hdZHZwNmf2HhbF3
        Njq+2RfP3Umj8yFhfpWDmnwISxlqqgFvEjsJwkVvtiWsJmHMeSvh+8b8fxUQ7+mj
        HeePWxpvgok5gmZzwKA5hAO3cxAP2+96L5oY3eijzE7Ae7nMBuFG0gX5ilVhViUa
        3r9opUS+dctQIG5z4VJD3/XgXOfzNNWsG8nJZ/JA74RfVTMW1q0553h7mqJM3WyM
        1Y+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701380232; x=1701466632; bh=ZzF9h379MrAFj
        54pXWhL+XcbpUP3DpZlKzF1Dnx5FrY=; b=xtu8hJy4NCZgJkhuo6Vdqoe7aPaYs
        hu2d9SSnQuPMZKo/wqq9EX538D/lSwJIZmSwPr46vcjUc85mGIJRsTxXgnTWA44R
        vbp6/KqI2bzT5406NtyMrkTL1iBqnc4kuPWfnmiBZru9lXDLfe1FPL2RTilrDMoO
        SiSBdxV/sycERlIt3JNl4FUyT+c+QeRP2GwzmxpKAC+bqZNGjHGpXP+iutR6qC3c
        Mo0Sv/xy3sMRtpnC1tylWeubJX9nM2HOcHJBPKmyB1XJ/3N+uotC9Ap/Hu7d/Pyc
        R8bLTE3kqnwQ6gMOlH/vBgkXxk/UJA/9El8blbBCRZhO2rUtxxjj+ntYQ==
X-ME-Sender: <xms:hwBpZZHQuTBe7RDle2Un4O4CJuIMyYZTAe9_ya1VLyIE1IpJEEyqFw>
    <xme:hwBpZeUvIvzOgkdiL9MtbJ7cxxWa0SJfkt_97-yww6DW1sLDQhG26JOwtagUDwFJ6
    VGUQWZxWMXRhndAvp8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeijedgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:hwBpZbJ6EsZXwFWS7NTv4ZhUNrXLJ_JLpBnHAvigtsNslQylZulc0g>
    <xmx:hwBpZfGVFa3Po9QgM2Sr11NTtHLRK4QU47H8uZhxH_Pv7r7YKYgvag>
    <xmx:hwBpZfUhV4s4k09ASokxWzATzECncoE3Gci5bth3tu3R21KlwWRkUQ>
    <xmx:iABpZVf0RCnCciZ9H2I4w-dz_IdNmXN2Xg26tDd9qtkl3yds-Q_KyA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ADD8DB60089; Thu, 30 Nov 2023 16:37:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1238-g6cccb1fa34-fm-20231128.002-g6cccb1fa
MIME-Version: 1.0
Message-Id: <8cef91eb-140c-46a6-b695-70df89bbdb81@app.fastmail.com>
In-Reply-To: <20231130081929.46a79c33edee8651c63112dc@linux-foundation.org>
References: <20231130075838.05e5bc9b@oak>
 <20231129131003.d2c1078847c3865c1ac2dfd5@linux-foundation.org>
 <ebb5b1a2-ed27-4a77-b62b-1d3f19bddd85@app.fastmail.com>
 <20231129151030.24b807f1d2b43be301a533b7@linux-foundation.org>
 <4be73872-c1f5-4c31-8201-712c19290a22@app.fastmail.com>
 <20231130081929.46a79c33edee8651c63112dc@linux-foundation.org>
Date:   Thu, 30 Nov 2023 22:36:50 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andrew Morton" <akpm@linux-foundation.org>
Cc:     "Stephen Rothwell" <sfr@rothwell.id.au>,
        linux-next <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: linux-next: lots of errors/warnings from the -Werror=missing-prototypes
 addition
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023, at 17:19, Andrew Morton wrote:
> On Thu, 30 Nov 2023 09:07:38 +0100 "Arnd Bergmann" <arnd@arndb.de> wrote:
>
>> > I guess it should precede "Makefile.extrawarn: turn on
>> > missing-prototypes globally".
>> 
>> I already have a collection of patches to fix up known
>> -Wmissing-prototype warnings across architectures in the
>> asm-generic tree, so I'll add this patch there:
>> 
>> commit bdef96eb0b89dfa80992312a8e3b2613bf178ae5
>> Author: Arnd Bergmann <arnd@arndb.de>
>> Date:   Thu Nov 30 00:07:07 2023 +0100
>> 
>>     arch: turn off -Werror for architectures with known warnings
>
> I think this would be better in the mm-nonmm tree, alongside
> "Makefile.extrawarn: turn on missing-prototypes globally".  Can I steal it?

Agreed, that does help with bisection. I had pushed out the
asm-generic branch with the patch earlier today but now reverted
back to the previous state.

      Arnd
