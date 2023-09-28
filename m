Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946867B1812
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjI1KHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjI1KHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:07:51 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B55194;
        Thu, 28 Sep 2023 03:07:49 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1B3F85C25ED;
        Thu, 28 Sep 2023 06:07:47 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 28 Sep 2023 06:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695895667; x=1695982067; bh=16
        HPbAIF0KxSDAv7A2kqSkSfgf23118g+srCqqLlUyo=; b=PsH2Fx4sdu8I1G6WJq
        dcOCqaWVZnmVfsHQeyDxC0zwLh3ARMGM1doSQwNyuhdTJv+Td+p3/DtsD5hg7h+N
        EXISVysMCCVGSGO9Jvh4vjejy193LyWKcLb9z/jxhB/hmkqShVQmWuESkVHpz6ZS
        faJgl9CExx3yXKwdy63xlLdwujUCoD2wFEu4dKnPJh2BCxC17g1W1SxoJtCFeIat
        Uln3U+t6R61vp5bFQLAAqDkHsCwMdQQJcgJGENfRfLQZCx08dnTK7++Ruj36j1NT
        GABQtJjawL6E+gg0tQsVfYZUzju8Z8eISdd+831+rsLkynIWCJMWE7SEyhqhcyap
        S6Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695895667; x=1695982067; bh=16HPbAIF0KxSD
        Av7A2kqSkSfgf23118g+srCqqLlUyo=; b=VHKj0JAtIseHmp2Zv91ZZ4tNcBC+J
        9D/EVrUgC6bhTkYb5W23jt7J9BG+oluC2deIhcKdnCztsl+XYxKN4/dP4zoWZInn
        MzBwqyOybmJV3uSUMjZxlDacqSx279EjoqEUi0ECZOfjHNT+HQw0C5B78ZqIeRaW
        +aAb54aUiERQYBVODa7xxi51xs1zSNqe/0GETN2YYElVM8Hw9vRqd2ZoaoICjZt0
        NmTsldiwWEfYWIDGrzur79ZNmDD3pHPtaP8mgI2uF4XwIpomY2s4aMBv3QrNk/Ak
        Sb+nHflxFUWzy4ygVIR0N5ZQGh2lrdNLbGTfC7x/cJMDr3d9jejsfPY9Q==
X-ME-Sender: <xms:clAVZRYqYpjaGD_Hp6XPKA8r6PqkXcxaaKC7GNplZdJr5b8ieNIA2g>
    <xme:clAVZYbL2TuQ6rDe5y_nRR4TF0qGRupHq_YHUawhsKnzIgn1mvg5baNXBQdRD_Oar
    WH8UVNPvRzR78BsT18>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdeigddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:clAVZT9kfvPpvf-MmWrocY-VEYMZUX3LhoOkdm0jNhiDpy_JSEcewA>
    <xmx:clAVZfq02IsMC4VND0THfuDgs6n3YBBgLqXWK-8JHvPBiNbicUEQtA>
    <xmx:clAVZcpumRyFUv91bGuTWSqWgaFYRJnn6hwAKkLWWKxLBvo71SXW2A>
    <xmx:c1AVZddApnKSrIfxmdu8O87-_WW4FQBiUzyc1t8dDkJSzsdCYU4KoQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B9EB1B60089; Thu, 28 Sep 2023 06:07:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <839638d2-7502-4925-8b7f-6b15779a6840@app.fastmail.com>
In-Reply-To: <20230928092804.22612-3-eliza.balas@analog.com>
References: <20230928092804.22612-1-eliza.balas@analog.com>
 <20230928092804.22612-3-eliza.balas@analog.com>
Date:   Thu, 28 Sep 2023 12:07:26 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Eliza Balas" <eliza.balas@analog.com>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "derek.kiernan@amd.com" <derek.kiernan@amd.com>,
        "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023, at 11:28, Eliza Balas wrote:
> This patch introduces the driver for the new ADI TDD engine HDL.
> The generic TDD controller is in essence a waveform generator
> capable of addressing RF applications which require Time Division
> Duplexing, as well as controlling other modules of general
> applications through its dedicated 32 channel outputs.
>
> The reason of creating the generic TDD controller was to reduce
> the naming confusion around the existing repurposed TDD core
> built for AD9361, as well as expanding its number of output
> channels for systems which require more than six controlling signals.
>
> Signed-off-by: Eliza Balas <eliza.balas@analog.com>

Thanks for your submission, I've had a first look at the driver
and the implementation of the interface you have chosen looks
all good to me, so I have no detailed comments on that.

It would however help to explain the ideas you had for the
user-space interface design and summarize them in the changelog
text.

You have chosen a low-level interface that wraps the individual
device registers and gives user space direct control over them.
The risk here is to lock yourself into the first design,
giving you less flexibility for future extensions, so it would
help to understand what the usage model is here.

One risk is that there may be an in-kernel user in the future
when the TDD engine interacts with another device, so you
need a driver level interface, which would in turn break
if any user pokes the registers directly.

Another possible problem I see is that an application written
for this driver would be incompatible with similar hardware
that has the same functionality but a different register-level
interface, or even a minor revision of the device that ends up
breaking one of the assumptions about the hardware design.

In both cases, the likely answer is to have a higher-level
interface of some sort, but the downside of that would be
that it is much harder to come up with a good interface that
covers all possible use cases.

Another question is whether you could fit into some
existing subsystem instead of creating a single-driver
interface. drivers/iio/ might be a good choice, as
it already handles both in-kernel and userspace users,
and provides a common abstraction for multiple classes
of devices that (without any domain knowledge in my case)
look similar enough that this could be added there.

     Arnd
