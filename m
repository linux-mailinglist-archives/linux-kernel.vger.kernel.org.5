Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0C47F6576
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345564AbjKWRb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345172AbjKWRbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:31:53 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B78D44;
        Thu, 23 Nov 2023 09:31:59 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 051533200A0C;
        Thu, 23 Nov 2023 12:31:54 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Thu, 23 Nov 2023 12:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1700760714; x=1700847114; bh=r7YWHIfKs1lRtQljNoq9n0N8njCRxKVxB0j
        /oEqFGJ8=; b=gcuciQNHPyLhNrt9hMusqeRhRHncBl86lxovPoBIi0uz5ETFy35
        sy26tYy2lcezp4at8sXuI+gxGYBpZmL0463jgrb4tmk1Pc+ZU1nInpXvNbuOjFGW
        ZvHwdiu9HmlPH+FxyQOU+RKAWmgnqxwRZYRsADYnGR1AJvGcgoCw51rgIKtVXEei
        tV7LX/kHuvfNU0Jr/pTcJWPYPS9/UJdPFgL3F3SOeYfTUgoDFncfyU/oCu7or3VJ
        H5Sq+h4N5U/Vlb6rTUL34x5kXeLlMabxOZJ0qrUfLIWkxFN4gspnyNUMvW57Tcoy
        75UKOblrACO/yOiHnAQJm+i4DJr6OwU1Log==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1700760714; x=1700847114; bh=r7YWHIfKs1lRtQljNoq9n0N8njCRxKVxB0j
        /oEqFGJ8=; b=kv69WDjo+qyKK7pmC0j7JuBlJFHfQw3agKWMBEE9Sfc4gMBXits
        bUB7y2f+s3m5leDUyYdRYSZ+UAYkCUB6YZZoUj7W8s7KEgw8J5rq1mY43enhdCVc
        6KJQLsBFLtUnUVR7KQZYmzXaNWe36bsCFX3l5vcYYni5n97sGESyyDP7Z8SXQWo/
        BvAKYZlkJN/GSBbzkJTU7IIemoAjwNZDuNDP4c5jxhQo7pqNDaEpb1XEETLTsTFb
        sHFhlkD7FKtOTCzILVXKwpVybK8D06hu+2rzNwUvI4dVM1eLdiOtaDKG4NE1aQEr
        Il7an2b45E1XkS+dKAGNNXF0UQkLUjMu00w==
X-ME-Sender: <xms:ioxfZTUuN9wJnwXh8PAnpluylHi_g4qSH9Fdpolif4Y4jZeYg6lnYA>
    <xme:ioxfZblm1C3UZdBSumou4iztnFohGLw0cx3KiaE_-9hb3LmvRMQPxtNIWDKDxvw0f
    pbzzZ0bRxVgc5wFg6I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehfedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    lfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtg
    homheqnecuggftrfgrthhtvghrnhepkeelveffhedtiefgkeefhffftdduffdvueevtdff
    teehueeihffgteelkeelkeejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdr
    higrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:ioxfZfZKpm9WG62x6XNl1UWP2qr5lcr1QtT92BuNuoO-Qqb-i5ZlPg>
    <xmx:ioxfZeVa0qQisTL-4f-tC7bBbij3kZAoyudiuXLVOe0wPGP2JoBP_A>
    <xmx:ioxfZdk1msiY1Zi3OOVhgAsMEEmfjTpZg2GwF8KXW8rr780ltNRAmw>
    <xmx:ioxfZWfwTXpAIux1XSpGVByRIFugkV9VmG8RJSs0osSGcR8tbk_C0w>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 04C4E36A0075; Thu, 23 Nov 2023 12:31:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
MIME-Version: 1.0
Message-Id: <32db8a76-7842-4d04-94f1-67e3984cb349@app.fastmail.com>
In-Reply-To: <20231123152639.561231-1-gregory.clement@bootlin.com>
References: <20231123152639.561231-1-gregory.clement@bootlin.com>
Date:   Thu, 23 Nov 2023 17:31:33 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Gregory CLEMENT" <gregory.clement@bootlin.com>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
        "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 00/21] Add support for the Mobileye EyeQ5 SoC
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82023=E5=B9=B411=E6=9C=8823=E6=97=A5=E5=8D=81=E4=B8=80=E6=9C=88 =
=E4=B8=8B=E5=8D=883:26=EF=BC=8CGregory CLEMENT=E5=86=99=E9=81=93=EF=BC=9A
> Hello,
>
> The EyeQ5 SoC from Mobileye is based on the MIPS I6500 architecture
> and features multiple controllers such as the classic UART, I2C, SPI,
> as well as CAN-FD, PCIe, Octal/Quad SPI Flash interface, Gigabit
> Ethernet, MIPI CSI-2, and eMMC 5.1. It also includes a Hardware
> Security Module, Functional Safety Hardware, and MJPEG encoder.
>
> One peculiarity of this SoC is that the physical address of the DDDR
> exceeds 32 bits. Given that the architecture is 64 bits, this is not
> an issue, but it requires some changes in how the mips64 is currently
> managed during boot.
>
> This second version comes a few weeks after the first one, because
> there several iteration to support having kernel code outside kseg.
>
> To build and test the
> kernel, we need to run the following commands:
>
> make 64r6el_defconfig BOARDS=3Deyeq5
> make vmlinuz.itb
>
> In order to get ride of the aliasing patch I got, I followed Jiaxun
> Yang suggestion by splitting the memory in 2 part: low part under
> 512MB and high part beyond the 4GB. It allows to boot and run Linux on
> the platform however as a side effect the number of pages used for
> memmap passed from 512 to 8672 which is a huge consumption of
> pages. Do you know if there is a way to reduce it ?

The best workaround is to enable SPARSEMEM, that's why I sent[1] :-)

I'm going to reversion my XKPHYS work to fix some other issues I found.

[1]: https://lore.kernel.org/linux-mips/20231028-mm-v1-0-45377cd158cf@fl=
ygoat.com/
>
> I also noticed that if the kernel can't be in kseg0 at all by using
> low memory at 0x40000000, then I got the following message during
> boot:
>
--=20
- Jiaxun
