Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B849B7999E5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbjIIQ1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244643AbjIIO2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 10:28:25 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4BD180;
        Sat,  9 Sep 2023 07:28:20 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 129102B000BF;
        Sat,  9 Sep 2023 10:28:18 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 09 Sep 2023 10:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694269698; x=1694276898; bh=2g
        tIrsNeic2vvbi63w8W2QWQB4mScZHdrnV/QA4eNl4=; b=YafaDm/GeG2cO+vffD
        w2B7TqoPfMIWfEZ8TZ0WMWPQhRN0a7k+yLwl8wVN2K3JO8EMCzgz9AeR9PWnQeyb
        m7de1lbuWheZEgb2JuEdMav+LSzXlBAwcwRoXaK2m/GvJk9C+FS9/e9+oEu/Zre0
        hMzKE7WTYmaloSi8mbeASXRe4NzNfgk1CTYjd5FxMuNpPf1k/HbwXTeTMszRFswr
        DOhExVQCOn0oRXpx/q6d60N2y+chPbVFKQyak0hj6JslWZwsf+5KTwIe6XDDX5jZ
        Dvwqami3JJoiqWI8dY7KdX35bpkI86RpyVHwCgxWyeaBViSp8eLb5Os/T3cSqEk9
        thog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694269698; x=1694276898; bh=2gtIrsNeic2vv
        bi63w8W2QWQB4mScZHdrnV/QA4eNl4=; b=YaznKN+hzBj6IkM3ZTURjSq7RKkfq
        k+NqaovWLToXXUvxV1PUIcHxh61XRqFEIV20aop3hRTXQK2WLmQXriVeAvOgBv5A
        V1E3JGAIeAhGAJqGrSvhPWl5yGdlf5XcdPtdCRGfnaZwNNZwwBEuG5+e9ND67/t2
        M2WBqyoFhUvpjdV9ggAEo9LhGj94uTo0UnrMvEx1UCr1Hn9NtzGbxZEZ9dzwONzE
        Y4vJoUvTjHeOu2ltb1Y1eXELjEHI2VfJhZ4v1JSLjicUeCxR1FRcDVtblMW7Bjqx
        JTZmng1BmUVEmhe0F+U2BF5BbEyD8tzCc0OGzkWnw+9vVbyufGRwrSIsw==
X-ME-Sender: <xms:AoH8ZJD3XspTGJcF1RPxyJ_pKAAZpwr0iiu_RHyOD-IabjaAvt9mrA>
    <xme:AoH8ZHjkkN3V4RY0PSkTrEBkUZZlVnKvCRmMHciUipb6vTLpvrLLlIdxS4b7nZheD
    nQ_85NBc6JZhTte4_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhephedvgedvhfegteejtdeggfevudevhefhgfdthedvheeuffeutdeljeeghfeh
    vdevnecuffhomhgrihhnpehsthdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:AoH8ZElv9SnlKQWwOu3RLeaFBO821xL-nfkvLe7YErY3tfZy0dEZlw>
    <xmx:AoH8ZDxkq4lEVu7YfYQjKOwhMQLcHyPuuQfpdyEsdl5arGGWCrcRPw>
    <xmx:AoH8ZORZm0VHLsdrF6_ZdiK4aWh-v7yhKzvMJPJC18ggAEBWDKLiOQ>
    <xmx:AoH8ZBG88pbx0p2iR40VYHj800zLtPodEBR0O29_2GV5cF_DrHDbtWZQsTw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F0C19B60089; Sat,  9 Sep 2023 10:28:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-711-g440737448e-fm-20230828.001-g44073744
Mime-Version: 1.0
Message-Id: <738c3b54-1f42-454a-90be-505ceba7544b@app.fastmail.com>
In-Reply-To: <20230904180513.923280-1-dario.binacchi@amarulasolutions.com>
References: <20230904180513.923280-1-dario.binacchi@amarulasolutions.com>
Date:   Sat, 09 Sep 2023 16:27:57 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dario Binacchi" <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Cc:     "Amarula patchwork" <linux-amarula@amarulasolutions.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [RFC PATCH] ARM: dts: stm32: fix SDRAM size on stm32f469-disco
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 4, 2023, at 20:05, Dario Binacchi wrote:
> The board is equipped with a 128Mbit SDRAM.
> 128Mbit = 16 Mbyte = 16,777,216 bytes = 0x1000000.
>
> Fixes: 626e7ea00215 ("ARM: DT: stm32: move dma translation to board files")
> Link: https://www.st.com/en/evaluation-tools/32f469idiscovery.html
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> ---
>
>  arch/arm/boot/dts/st/stm32f469-disco.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/st/stm32f469-disco.dts 
> b/arch/arm/boot/dts/st/stm32f469-disco.dts
> index cbbd521bf010..f173a5892b7d 100644
> --- a/arch/arm/boot/dts/st/stm32f469-disco.dts
> +++ b/arch/arm/boot/dts/st/stm32f469-disco.dts
> @@ -84,7 +84,7 @@ vdd_dsi: vdd-dsi {
>  	};
> 
>  	soc {
> -		dma-ranges = <0xc0000000 0x0 0x10000000>;
> +		dma-ranges = <0xc0000000 0x0 0x1000000>;
>  	};

The dma-ranges should be independent of the installed
memory, they usually reflect the addressing capabilities
of the bus, so this patch should not be needed.

      Arnd
