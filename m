Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74217AD1D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjIYHgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjIYHgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:36:36 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C36FE;
        Mon, 25 Sep 2023 00:36:28 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A167F5C2631;
        Mon, 25 Sep 2023 03:36:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 25 Sep 2023 03:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1695627385; x=1695713785; bh=us8JRLFyt4MuiVWXXPyVfjRQFmj6YHaWS6G
        WwW/GJBA=; b=VyalqmU4oJ1q8x2FSZ9V6nVOzI4TfHuoKi6+pr/976pN614EU6e
        xTm57+gLE7Ru167gtWu9FHHZk0szBYk4NME0hbrOo9EZg+RS1OSRsg48XVZ9/+IP
        Il9SyUCLifxObE8xLiJ4ovKzi6GIMJPv0M6wUbGeSKHwPriY58E/7hc9TjT1irhP
        9we21kiWA2E08Aso7KpaDRpCAcZvRXLnac6sO6rUvOYmWEOlo1mmmm5SsTfkg5v5
        /kxRoJ8lpWq7blSLXaCF1X7Mam+3BwFPz+Q68kbcXQCElNgc2K/bffMh/OHhr79G
        otPcMZciBIfhAexiMOmCvRR4wqBtPjrBz4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695627385; x=1695713785; bh=us8JRLFyt4MuiVWXXPyVfjRQFmj6YHaWS6G
        WwW/GJBA=; b=U9A5/dKrhcgtQXJ56TH4ndEhB/PzRfhq9wAUrYETErPYnHYwSUt
        Hmohh7GWdqhZ8SeP4aR/+iau9k8dUA3JwOdP5wdkHSW15PYQIe2wS9iJP8JOkjrf
        20JuoY9xDh06opZ4og+PsRR303K4U+ebd4J/kr4k71zG79Up0f7LEXiJhPD+6d2m
        fYS97/9AWHAnGZ5dNPTtiXDsQw2SfXWdYltIxVe4EL01Z5WMqA9LXGrZUbn1Uvif
        Pm1enAjqXgx8fCNw/Nj+jGsmWXowjHBi21zPK//N/djHKH0X26XI23vKgIcdZSFe
        xJInAvKKjhbLqhLuVt8I/BOaXdTV5MS8Xog==
X-ME-Sender: <xms:eTgRZbBJgaOWba0EIkCCnqVCKx-PG6jnoMYJV1jx1RPbipBjrh02MA>
    <xme:eTgRZRicdpxS84aRIHYQRCevqLW7MqWKjRAyTymfO2redpSra5ElNSg92q0CC428E
    3pUCMFp1cm_FNVoPh8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelfedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:eTgRZWlePtwxBxJjiSbw8H-HooY-JGwTkx5LXnrWtGQltEOPBdiFDg>
    <xmx:eTgRZdz0DyuquTfkJ25B0WYk38b_9l8aYJopYEL2Ywsi4_JLR4T31w>
    <xmx:eTgRZQSu3Gp4escdF_C4AiQjfKA-gd3YBboxpoAydzy_bpYlYqwd5Q>
    <xmx:eTgRZWPRn0tfAaP97ldTm-CpOqYNtQVv_KpGZg15n1G92UNhY_1dYg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2DFDEB60089; Mon, 25 Sep 2023 03:36:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <d0587e7d-95a4-4ce3-b7fe-1aaa94352592@app.fastmail.com>
In-Reply-To: <87msxau3up.wl-ysato@users.sourceforge.jp>
References: <20230802184849.1019466-1-arnd@kernel.org>
 <20230802184849.1019466-4-arnd@kernel.org>
 <CAMuHMdVjmD357K-yxxW-jn-6vKsXTg+u1Psw9DftyxH=dQoMEg@mail.gmail.com>
 <5dad2d86-78ea-4a39-8ee1-98e3eb134d36@app.fastmail.com>
 <CAMuHMdVYcvPL+JpPw9sA48=615cdfwa8d0LP-bVp0NWqbQ+JOw@mail.gmail.com>
 <190041c8-2d99-4bc3-adc3-6fbe902c1265@app.fastmail.com>
 <CAMuHMdXyLHitBWOMp74cqtJbSs6q_4sPOEee+x72tE-E2G-KWg@mail.gmail.com>
 <d2f5cdc1-4bff-4f1d-a7b2-38eee6a6a86d@app.fastmail.com>
 <f61e1f218ee4d5a87121c0e5ee0d8694364ea2dd.camel@physik.fu-berlin.de>
 <CAMuHMdXFSvyTGvYrc2af_Bba9hHNQ-taufOMXRPrKJGNiCP8mw@mail.gmail.com>
 <87msxau3up.wl-ysato@users.sourceforge.jp>
Date:   Mon, 25 Sep 2023 09:36:03 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "Arnd Bergmann" <arnd@kernel.org>, linux-sh@vger.kernel.org,
        "Rich Felker" <dalias@libc.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] sh: machvec: remove custom ioport_{un,}map()
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

On Mon, Sep 25, 2023, at 09:08, Yoshinori Sato wrote:
> On Thu, 21 Sep 2023 17:52:29 +0900, Geert Uytterhoeven wrote:
>> On Thu, Sep 21, 2023 at 9:45=E2=80=AFAM John Paul Adrian Glaubitz <gl=
aubitz@physik.fu-berlin.de> wrote:
>>=20
>> I think including Arnd's cleanups (that is, his v2) in v6.7 is fine.
>> Sato-san's series needs more work, and is easy to fix for Arnd's clea=
nup
>> (just provide sh_io_port_base unconditionally).
>
> For devicetree support, we have been using GENERIC_IOMAP and GENERIC_P=
CI_IOMAP.
> This change has no effect, so it's okay to be merged first.

Ok, thanks for confirming.

I would still suggest that you try to avoid GENERIC_IOMAP altogether
since sh has no custom inb/outb instructions and can just implement
ioport_map() to return an __iomem token that can be passed into=20
readb/writeb, the same as the non-GENERIC_IOMAP version in sh does.

Ideally you can however remove the iomap.c file and the
asm-generic/iomap.h include and instead get the inline definitions
from the defaults in include/asm-generic/io.h.

    Arnd
