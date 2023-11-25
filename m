Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32797F88D5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 08:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjKYHci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 02:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjKYHca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 02:32:30 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5936410E2;
        Fri, 24 Nov 2023 23:32:36 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id CF7215801B4;
        Sat, 25 Nov 2023 02:32:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 25 Nov 2023 02:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1700897553; x=1700904753; bh=ex
        qZesM4aQu3oVWnJphA5Nu6nKdj7qrJMiTqCcJpx00=; b=BZvX8XH73FmM0r9DS/
        HjBV6jHbJpIE0yM2JA7gePhM1fpVTjuLRIJHmHJNvQ+tHjsGBau1XGtrmJjblDzy
        WuchxuqNzEgvn59HhX6osfpe0uFexP3juHcSotJp7DhXl4MPg3DOVpURHZmrfwMF
        lfPeFmdg5opz29t9CRs0SK9PiZ7lyqTl/c5TLHMbcfZrKY7rco4YLnfLfBFs1tR+
        H/ytKd8C9aabbnYaocz8ZtZ8CuT3gfA3f1mtLldAqw5NdZTtBHNPty7ZSRaZBApd
        pglzVSNh5megitIMaAjSG6hnTNIRCrM7+/FXJo3rkUN2j8TdusjMhWC3zKbYEqpK
        h4LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1700897553; x=1700904753; bh=exqZesM4aQu3o
        VWnJphA5Nu6nKdj7qrJMiTqCcJpx00=; b=CiBJ9uxswgds8SICK0mvW8+D+HDJ4
        paAcWTr/+HvV1BAvQVH/uYuCfy9ScjbRWUjqaGjSNM4gVmiucXTLMDtCt6B4OqoJ
        JPAjksJ2P35LYOP9XbF187xfUbfnbYKCuodR0OYaFtZiRsc0rX5H5w51KUSwi2V2
        LapQZ9Zh/89bWDSqkgRdQC4oUB5gpFT5nriUdYLZ25UA3rzxNLEhznsQNp6dqeHm
        Jjour1Vkqw/iRzrvB7iTQIgo051oEF3fRutX6Ils8KIsBLI+05IABocW4IpS7lKr
        zSYlF5uBkuyveUjZMavS9CilUA4HWYtg3swmfkse+wVv/tQcgSyFXhRLQ==
X-ME-Sender: <xms:EaNhZXCbTaoROGZjkL8hVpyufJBAEz3ItuWYs4YqDfqANA050Eki3w>
    <xme:EaNhZdjq5-_Td17d9pA2jdZf49-AUa5qT998njzYUFsz9X1Ik8AeyVv9MxiGUeE5W
    5a-bO04l2QuAw>
X-ME-Received: <xmr:EaNhZSlmPUlPsmGeFWbPgiD81GO6EwR7WooenZoBYVQmv_8-mLb_NA_WAuV3rbsJngPq5SGfqtDAiyLlmWBnU5bcxqx2mUq03ojmRyah0g3ZO4_vD4-UeJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehiedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:EaNhZZzBnFlTu4Nvj8xB4db2CIOsSf-E3rWRn5tgb_gt9TwK2lG9fA>
    <xmx:EaNhZcRbxP2sARaJ9rdt5evwS4kzO6zzT48m-ZpBnf8t7xa3HIhdaA>
    <xmx:EaNhZcbGo4iMigsDujJUA6n9bs9PeDoE3gYXR_SGAMglyw7UjFGHzw>
    <xmx:EaNhZf_6MLVTDl3azaHQsBsddLrdXmgGsOZWIjVZUzjE9eafEZ_umA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Nov 2023 02:32:32 -0500 (EST)
Date:   Sat, 25 Nov 2023 06:53:34 +0000
From:   Greg KH <greg@kroah.com>
To:     Luka Panio <lukapanio@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v10 2/2] Initial support for Xiaomi Pad 6 tablet, that
 have sm8250 soc.
Message-ID: <2023112511-pavestone-satin-3b3e@gregkh>
References: <20231124212732.731419-1-lukapanio@gmail.com>
 <20231124212732.731419-2-lukapanio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124212732.731419-2-lukapanio@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 10:27:32PM +0100, Luka Panio wrote:
> Signed-off-by: Luka Panio <lukapanio@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> ---
> v2:
> Update commit message. Drop reserved gpio's as this device in reality do not have gpio, and pins are not protected.

Again, I see no commit message here, did something go wrong?

thanks,

greg k-h
