Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0982580279D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 21:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjLCUvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 15:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjLCUvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 15:51:10 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2A6CF;
        Sun,  3 Dec 2023 12:51:16 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1FE0E32004E7;
        Sun,  3 Dec 2023 15:51:13 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sun, 03 Dec 2023 15:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1701636672; x=1701723072; bh=mkoL5GRW1yQRxowg4OvJz3ED7Ey6jz21dth
        CJqqVr+U=; b=dLvCS2kcTUwS9N4Xm5V+Ixe/ePgUeMixtxKJf6bEK8zUMcZGQHk
        ihibKZJnuFVA0v76C7DNwXB8RbrZdA2z8QJUhbFwKIa839NgpObO4CnVS22/n4UO
        QE9fk/dvYOBy2HUTEqb8BMa5/WcJl/dD2QNkL7V7nHsxjotSDl+owVhCjjLJtPjr
        ovNMAjv0sLXUcIfL9buo0+YcB8gV84cVcMgQEwaK7ZZ9oUXeSxOwHWH+oia7ib6u
        xX2KbQfx9FR7mRrx8klT4bvZ7DFS+yPlFNEglfBCAB+FXawMFrHMYpNB7U8Z1qtj
        vmFR7fU4VioOlLM5lJc9KldGa5nn1kXNDXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1701636672; x=1701723072; bh=mkoL5GRW1yQRxowg4OvJz3ED7Ey6jz21dth
        CJqqVr+U=; b=Z3FUh2joJ1dbaU9RDz9StRNo6WbzpMM2RNCmYusIJP4eVk9yP/z
        CasVYXX8XXAbdfgyx2Q08w1X13OMg6hxfXCSUt+d1u54y+s4EPvZQKqtwW6syjIN
        JZ1NkiwsXcHPTAn215EPuc9x86iITXaPjkkzYBBf1oP91yTxSuRhveJBJv1kz5AR
        OdrlHJQ8XlhX6F+rTT9v0/mtpBygAbBPQXlrbIDLwOv4/h6Rb978hQlXt8nG29w1
        WZF3M9nPft2prjyQtr3jIDZpyFckO4VFNJ/jSvpx+KMNcqyq9L9x5Rt0XPqFSCmK
        qVlgXkOPxNwtDJuVle2iUK3pY0aaisxopsw==
X-ME-Sender: <xms:QOpsZYHs0OwSGa7EubYD9zNO7Ok40cmOuVYrK306vyUTUN6MOCT1PQ>
    <xme:QOpsZRW1UrbkXKYesxG3MGW-ai-cbrcbrzUeFq664RHUR-UgecYz0pDOA2GidyDkN
    Dzabj9EWrhw0NQoj1c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejgedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:QOpsZSJQpAwxp8q__I9nN2JHe5GdnAFofplzqxH4jJyIf2hU1W0Gtw>
    <xmx:QOpsZaEWMKLUkFkerTtNabH1mQ9kqcZ7UNfH8PdQlKYZd7BH6Om_Ww>
    <xmx:QOpsZeUMfvkCWJpfq6aBG7ZtDRxQljPcspglDCX1u5q9DNfEPicVXQ>
    <xmx:QOpsZQeWZkK8Zpt40IfxooiIgNXINL8-8uawybNvvPWg-xW8plK7bQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 58C5DB60089; Sun,  3 Dec 2023 15:51:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <d180f06b-64b0-4885-9794-5127c297a0f0@app.fastmail.com>
In-Reply-To: <ZWzLvctpo1nNTMOo@google.com>
References: <20231127204206.3593559-1-zack@kde.org>
 <ZWzLvctpo1nNTMOo@google.com>
Date:   Sun, 03 Dec 2023 21:50:51 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Zack Rusin" <zackr@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        "VMware Graphics Reviewers" <linux-graphics-maintainer@vmware.com>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>,
        "Raul Rangel" <rrangel@chromium.org>, linux-input@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] input/vmmouse: Fix device name copies
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 3, 2023, at 19:41, Dmitry Torokhov wrote:
> On Mon, Nov 27, 2023 at 03:42:06PM -0500, Zack Rusin wrote:
>> From: Zack Rusin <zackr@vmware.com>
>>=20
>> Make sure vmmouse_data::phys can hold serio::phys (which is 32 bytes)
>> plus an extra string, extend it to 64.
>>=20
>> Fixes gcc13 warnings:
>> drivers/input/mouse/vmmouse.c: In function =E2=80=98vmmouse_init=E2=80=
=99:
>> drivers/input/mouse/vmmouse.c:455:53: warning: =E2=80=98/input1=E2=80=
=99 directive output may be truncated writing 7 bytes into a region of s=
ize between 1 and 32 [-Wformat-truncation=3D]
>>   455 |         snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
>>       |                                                     ^~~~~~~
>> drivers/input/mouse/vmmouse.c:455:9: note: =E2=80=98snprintf=E2=80=99=
 output between 8 and 39 bytes into a destination of size 32
>>   455 |         snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
>>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   456 |                  psmouse->ps2dev.serio->phys);
>>       |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> This simply wastes 32 bytes. It is perfectly fine to truncate phys
> (which does not happen in real life).
>
> -Wformat-truncation is disabled in normal builds, folks should stop
> using it with W=3D1 as well.

It does find real bugs, and we are fairly close to being able
to enable it by default once the remaining warnings are all
fixed.

It also doesn't waste any memory in this specific case since
vmmouse_data is currently at 168 bytes, which gets rounded
up to either 192 or 256 bytes anyway. I'd suggest using
the minimum size that is large enough though, in this case
39 bytes for the string I guess.

     Arnd
