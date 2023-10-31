Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC38F7DCA4A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbjJaJ6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjJaJ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:58:45 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D03D8;
        Tue, 31 Oct 2023 02:58:43 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 85EE93200A30;
        Tue, 31 Oct 2023 05:58:41 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Tue, 31 Oct 2023 05:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1698746321; x=1698832721; bh=hGHPH0otSQhb+ezuJFb5cOt3lM/d83wh5j3
        /Ve+BNBg=; b=fNmbxvMlV55NZdolsFP5rPiCIgl3z9Odq+LczgeiP88OIpZjoo4
        K6ASsJhKOYnKYfbBXk66lAIEEpQsiNbC7dX7jE9CecC1NvEiNHbawsAkIBvdhDn7
        ArT6/ep/q07FIM7nUBHEkA+0cLKNfh8hDaim4bRexdTYNmQw2d6dJ9gD8SpNAfsK
        kxCuwgPD833Sj/vOC18tTdgCE0JSqoCur1CAY7IGlCWSz/umsBEuTn2wGW6Mpl6p
        /QE28tMkQEKNBcL6WDln08Ig1YNdNmiuOqCBc6uwUQiOJBSaPJosJEyC8iCG2WSD
        JoOJZAjZAwoTZ2bn7YhfxNy2qkz9TJLtQig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698746321; x=1698832721; bh=hGHPH0otSQhb+ezuJFb5cOt3lM/d83wh5j3
        /Ve+BNBg=; b=M0nMIz5OBIz6py8D1Q+FhV08TDzEuLzN3EnFN4TtYWf34IoioQf
        bBX6dLiBxA+ed3muDRoFrMH89zBoaWtr73lxsYRCWQXi8zad6vkWn12U81SXQATI
        3wJBQ979KT4h3rWMuyWQZBrqwNup/3InH52qNxNghPZ0OuYDwqIOUiQTHl7IyX1b
        2okJjqqqY5yPdyZkv1SqqYHjyePuuWoA5dnu7hcTY8cAyDaBHlEhmtSfCopK5BaE
        hzpCHsfBceF83o8nQasdYHeN7bH8ivuH/GKQr0vJ7nFku9KYDF6sh/ExcJb0GKBa
        8h2zfV1F5KjlrSqIp083PBk76w5BqKsYkUw==
X-ME-Sender: <xms:z89AZRan5mhkNFr0oE97S49XgmLqrk9K-pqu2fcTJB1dVvQxNfZjdA>
    <xme:z89AZYYEkUg_eOs-ONb7B00c-T-Ncd-JT_RTwzSbo6tIwnRRM7q9BL-t_lEIP7wct
    xRWdxMCJbVOYnRnvJk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtvddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:z89AZT-pt4ajXvIucm5TTh-V5z2_iSj_O0c1_ybx1j1UTE5pgtoTHQ>
    <xmx:z89AZfoVOUuspXOJ5tuxGE-yo96_0SZ6jWNPoTBgK2xuOpjUb0TyRQ>
    <xmx:z89AZcq7yJuHCW29WDkcWogiK4Fxt9CGDlV2s_KeeZpO0cyXtc8EMw>
    <xmx:0c9AZZ6VoWbK1NBjvwRbHms9EOjMXb7V7h7wPrPHhMKUGlTBu8Yu7w>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3082C36A0075; Tue, 31 Oct 2023 05:58:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <83e32f3a-75c4-4a72-a523-ecef501f9605@app.fastmail.com>
In-Reply-To: <fd5efc8a21b94e044e4e225255655fc92beb0c63.1698717154.git.zhoubinbin@loongson.cn>
References: <cover.1698717154.git.zhoubinbin@loongson.cn>
 <fd5efc8a21b94e044e4e225255655fc92beb0c63.1698717154.git.zhoubinbin@loongson.cn>
Date:   Tue, 31 Oct 2023 09:58:18 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Binbin Zhou" <zhoubinbin@loongson.cn>,
        "Binbin Zhou" <zhoubb.aaron@gmail.com>,
        "Huacai Chen" <chenhuacai@loongson.cn>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>
Cc:     "Huacai Chen" <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "Jianmin Lv" <lvjianmin@loongson.cn>,
        "WANG Xuerui" <git@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] dt-bindings: interrupt-controller: loongson,liointc: Fix
 dtbs_check warning for reg-names
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82023=E5=B9=B410=E6=9C=8831=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8A=
=E5=8D=882:36=EF=BC=8CBinbin Zhou=E5=86=99=E9=81=93=EF=BC=9A
> As we know, the Loongson-2K0500 is a single-core CPU, and the
> core1-related register (isr1) does not exist, and we need a separate
> declaration.
>
> This fixes dtbs_check warning:
>
> DTC_CHK arch/loongarch/boot/dts/loongson-2k0500-ref.dtb
> arch/loongarch/boot/dts/loongson-2k0500-ref.dtb:=20
> interrupt-controller@1fe11400: reg-names: ['main', 'isr0'] is too short
>         From schema:=20
> Documentation/devicetree/bindings/interrupt-controller/loongson,lioint=
c.yaml
> arch/loongarch/boot/dts/loongson-2k0500-ref.dtb:=20
> interrupt-controller@1fe11400: Unevaluated properties are not allowed=20
> ('reg-names' was unexpected)
>         From schema:=20
> Documentation/devicetree/bindings/interrupt-controller/loongson,lioint=
c.yaml
> arch/loongarch/boot/dts/loongson-2k0500-ref.dtb:=20
> interrupt-controller@1fe11400: reg: [[0, 534844416, 0, 64], [0,=20
> 534843456, 0, 8]] is too short
>         From schema:=20
> Documentation/devicetree/bindings/interrupt-controller/loongson,lioint=
c.yaml
> arch/loongarch/boot/dts/loongson-2k0500-ref.dtb:=20
> interrupt-controller@1fe11440: reg-names: ['main', 'isr0'] is too short
>         From schema:=20
> Documentation/devicetree/bindings/interrupt-controller/loongson,lioint=
c.yaml
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

[...]
--=20
- Jiaxun
