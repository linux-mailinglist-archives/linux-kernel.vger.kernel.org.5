Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A68812BE8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjLNJqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjLNJqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:46:43 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B94E0;
        Thu, 14 Dec 2023 01:46:49 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F299B5C029E;
        Thu, 14 Dec 2023 04:46:48 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Thu, 14 Dec 2023 04:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:subject:subject:to:to; s=fm2; t=1702547208;
         x=1702633608; bh=uzaZ2T/iq1KIJxlVF1wV39ljPwWnMmto9XWBVN4kLn4=; b=
        CynJzwHVkWnoMJVasBPRJb76XXUT1mkeepZdxfLOLIC7J1iJlOG4DWQX8TQ+5QXk
        oi7DwmL9PfsdGmgw47Hf88ll1B+P2P5IOWMLcHfzC8tU1J9gQtukXcuon3NpPhgm
        RNaoZlAAAG0l2fDK8RbUb3vBtZXRIIJt6sfHWL/c4PPsBYzfHuseBQLVkC+tlqMN
        koGkLfksgOjqSKSQCf4uwgYSQtnOutIixwObYT/7yKfOtNzTNHPfNfzwXdhagdhF
        V5UlZ6WGaLf9MTUMsGrKz3PQ/vIdXoTOJNoxRCepDriySkqU4QkWBPm09eAa89/H
        v9CrpinH5+M4VkyCTplYFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702547208; x=
        1702633608; bh=uzaZ2T/iq1KIJxlVF1wV39ljPwWnMmto9XWBVN4kLn4=; b=2
        8hSaxdBH5/teyrfv+9soeV/vlb2oGsIMNal/+egvw/vw8jmeVHfp1FYDrTDgWDss
        lrErdvn2NxWPNbT+lJ0Ae+QsL35BrskzkOQi5MiE1k9b9k2fFhyiOeVhhfKh+iJU
        q/PG197jsnLqpguWzhgN9+EIwHwoFfa0e19lfaX9VUMdriFKi8yWkknANYecEVhb
        Lh+DvginZFPJ4GECe4FokPfTSBYdVxkR8PSMP4VA/SwJZJU0pVjH9N6ELH5iComu
        dL8BFhBa2WJ90PKurvy997yV1x9QVG8MlZiaTVs0K/EYgcnBg1WyolcwFXtDabtf
        8lRFqJdWiKhFw42dcC9SA==
X-ME-Sender: <xms:CM96Zdzceq6mjRYH1j0jopqDubCshEwosezBumHmScWW60Rl70h-IQ>
    <xme:CM96ZdTNg1d_KxRMdSu2nEIEBq6y3dW-6TKlX38kEg0T3TGFS5y80sr-Hph0US-qH
    _nYn9F6l_D4CD6cXec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelledgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:CM96ZXVz2zwSvX7VM4qd-wbHNl9c6GwCgDRSWCC9RxaTd1AkJGEzdQ>
    <xmx:CM96Zfiy6j2pawsE-j3Sd4I-ml8cORRqQJRn3IeE7Y30fSmLacUAew>
    <xmx:CM96ZfDHnIIpSbI_21UJvl-0OrbT3BDeoeIUU7dgzOnIWvIj2WemWw>
    <xmx:CM96ZT42hYzmv4iikYb8qZRlmrUt_qG5p0BQ6hvJr1CpKh94_4ep7g>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4047836A0076; Thu, 14 Dec 2023 04:46:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1283-g327e3ec917-fm-20231207.002-g327e3ec9
MIME-Version: 1.0
Message-Id: <6b747f3b-f0d7-4e40-a331-8d2323e4874c@app.fastmail.com>
In-Reply-To: <20231212163459.1923041-22-gregory.clement@bootlin.com>
References: <20231212163459.1923041-1-gregory.clement@bootlin.com>
 <20231212163459.1923041-22-gregory.clement@bootlin.com>
Date:   Thu, 14 Dec 2023 09:46:27 +0000
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
Subject: Re: [PATCH v5 21/22] MIPS: generic: Add support for Mobileye EyeQ5
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82023=E5=B9=B412=E6=9C=8812=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =
=E4=B8=8B=E5=8D=884:34=EF=BC=8CGregory CLEMENT=E5=86=99=E9=81=93=EF=BC=9A
> Introduce support for the MIPS based Mobileye EyeQ5 SoCs.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  arch/mips/configs/generic/board-eyeq5.config | 42 ++++++++++++++++++++
>  arch/mips/generic/Kconfig                    | 15 +++++++
>  arch/mips/generic/Platform                   |  2 +
>  arch/mips/generic/board-epm5.its.S           | 24 +++++++++++
>  4 files changed, 83 insertions(+)
>  create mode 100644 arch/mips/configs/generic/board-eyeq5.config
>  create mode 100644 arch/mips/generic/board-epm5.its.S
>
> diff --git a/arch/mips/configs/generic/board-eyeq5.config=20
> b/arch/mips/configs/generic/board-eyeq5.config
> new file mode 100644
> index 0000000000000..d94e408145389
> --- /dev/null
> +++ b/arch/mips/configs/generic/board-eyeq5.config
> @@ -0,0 +1,42 @@
> +CONFIG_HIGH_RES_TIMERS=3Dy
> +CONFIG_TASKSTATS=3Dy
> +CONFIG_FIT_IMAGE_FDT_EPM5=3Dy
> +CONFIG_BOARD_EYEQ5=3Dy
> +CONFIG_PHYSICAL_START=3D0xa800000808000000

^ I still think by doing this you are risking overriding starting address
for all other generic systems. make 32r6_defconfig will load config files
of all boards.

Perhaps just provide an eqm5_defconfig will work better?

Thanks.
--=20
- Jiaxun
