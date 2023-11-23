Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E76C7F65BD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345657AbjKWRqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345731AbjKWRqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:46:38 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AF710DA;
        Thu, 23 Nov 2023 09:46:44 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5D2893200A92;
        Thu, 23 Nov 2023 12:46:43 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Thu, 23 Nov 2023 12:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1700761602; x=1700848002; bh=JdVkYHyZCwkaqqs8iJxKPLWNDNKV1uUX4zd
        6JLzaduk=; b=Av9IVz9upWizEgMWXliaWlxTB2n29cXJjymrRgPOhNTeuolTl80
        qtPWMlJ4KacVpv5o4Yxod+BZtSojlcNJ2d+KsIULxhSKyDwSZR98i9dGaJbM8GOo
        aZn1xiYh0OCzjBO0RMoDLLDZabAT5q0eldp0Rl5rNkLGqGHWus2l9DbHi2Bev5EI
        ZFrYlbt2ykoVbfvrbGA+CqlR5shfrrsUp5OQmHP/edRoPTCTds3uhggp8LcNjiRC
        KBkAPi4aH023MLVv+QLvu3IiOxf1kYMcC9UqtGdC7+TiZZ126AcTiB389G4tLbPb
        Eidu+yMF+hrgGBbWnTaq2JMkHjsqlj3RAXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1700761602; x=1700848002; bh=JdVkYHyZCwkaqqs8iJxKPLWNDNKV1uUX4zd
        6JLzaduk=; b=LHAbkZsEk5baSGX4tj3aOonz7W4kleGgb/h86/BbL2AR9+F/6R7
        NeX9uB8FIpgahkQVIpI1VwSL+8j3YZCfYLiym4p0zRZWvLd0AzkHPFowbW3Bo5/d
        ACbo1IDy0xvSVcK4Tzfr0dBkiDGTtzy1vSzK8iLpXtJ7eBfzPg8ROIPZPEbgn21X
        /wuiXJrlo9sjANfBqEmO9y4wPjwk4bQ5zSFequ8Nl2481aPrnEVPLB9SaWpts77q
        /P9wI9PCJpwoOhEKhgD15sD2ait/jUyVnvzKZj+SYyJ9fPsMO//u7/WxzgT7F+8j
        VUC0vBdvCKVpPUYRdI2e/KYLIGrFOU35fNQ==
X-ME-Sender: <xms:ApBfZYWSeq5YcSACIiu9Ny592KVe02DhqgN9AxKCD-QjHkst-67DOw>
    <xme:ApBfZcn8ZRo7OH9Y0YWJ7A4_kPsnhLgW-MLUrWjLwDqFp8f_vSFn6fTUYox9w3t7E
    3q-Z4yhsaaorUG5olI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehfedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    lfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtg
    homheqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefh
    jeeugeevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:ApBfZcaPNS2qOqi6-NIEobQrkLF8d-Baf0jUAo-7DwiuhusYtkMkig>
    <xmx:ApBfZXWHZeJYLPxL-Wmc2yx8yhT1iW8EBwUK7TzcCHs4EDXglH343Q>
    <xmx:ApBfZSmPDS-kACi1pAJm-cVih3X2OzAXexYukiz_F-pugmdqbNUEfw>
    <xmx:ApBfZbc9itzmhbm4YqjXDjn87OwcdTRS-9i_JwGS0cx8AGsFph8JiA>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 604E436A0075; Thu, 23 Nov 2023 12:46:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
MIME-Version: 1.0
Message-Id: <db993514-7daa-41cb-8e6e-179305c16e24@app.fastmail.com>
In-Reply-To: <20231123152639.561231-21-gregory.clement@bootlin.com>
References: <20231123152639.561231-1-gregory.clement@bootlin.com>
 <20231123152639.561231-21-gregory.clement@bootlin.com>
Date:   Thu, 23 Nov 2023 17:46:19 +0000
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
Subject: Re: [PATCH v2 20/21] MIPS: generic: Add support for Mobileye EyeQ5
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
> Introduce support for the MIPS based Mobileye EyeQ5 SoCs.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
[...]
> diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
> index 7dc5b3821cc6e..04e1fc6f789b5 100644
> --- a/arch/mips/generic/Kconfig
> +++ b/arch/mips/generic/Kconfig
> @@ -48,6 +48,13 @@ config SOC_VCOREIII
>  config MSCC_OCELOT
>  	bool
>=20
> +config SOC_EYEQ5
> +	select ARM_AMBA
> +	select WEAK_ORDERING
> +	select WEAK_REORDERING_BEYOND_LLSC
> +	select PHYSICAL_START_BOOL
> +	bool

^ I believe WEAK_ORDERING is already selected by MIPS_CPS,
and WEAK_REORDERING_BEYOND_LLSC should be selected by MIPS_CPS as well.
=20
Thanks
--=20
- Jiaxun
