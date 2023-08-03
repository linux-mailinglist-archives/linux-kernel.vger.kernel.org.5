Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3798876E23E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 09:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjHCH66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 03:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbjHCH6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 03:58:30 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5706D5594;
        Thu,  3 Aug 2023 00:45:26 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 357E53200985;
        Thu,  3 Aug 2023 03:45:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 03 Aug 2023 03:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1691048713; x=1691135113; bh=oC
        7D+18iBZjjvCY62LFO9NAYOEDXUELI72sm1PfCWkI=; b=UYyl48QdjUaFOz2tJq
        imJnoNfXEW2jLvZGePuK9g36mnmzh0iPMibe8LZQtFLYuioYhjvxqFP38nO4hjsQ
        3f5OeSii24KWWW5MG14hKNADUPLd1MGflAmjj+D30F+US4y8LMb41spY4v5JDSfw
        +xPN8YS9M/VpomkO8clbR5LBoT/e300g/esZJ+VGmNxkQTsKL8Vn07nfaLAx3D5I
        AW8X6pqmubrmyNz0FFlOKwm5uKcEBRIY8hRs+w0HJffvLq5KKYoi9SnApasRk0i6
        jy/pj5M+snFX3uSUGR98vseYJ8k3QqxutZ+1YC8PNSg68Z0eZiAZHYKYOGcxOxBJ
        0/gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691048713; x=1691135113; bh=oC7D+18iBZjjv
        CY62LFO9NAYOEDXUELI72sm1PfCWkI=; b=bNJo8R0DJDfGmIf/rkjYEjz82apwj
        gpTE9MAMKSJaYmpdyEtnTsY4k7B1ow0D2HHbMPOx2FsKHiPdFjv7eZvyAGtXSfU8
        ZGlEH8SkyGpLXyD+mkaf2I9agmIkw7xZ+nQqljV0LIR3OMFHpT1GDqvi9caoWb3C
        M9aymR2awNZhpf2b0397uMQLc1EMfqEPIwK5xbU7wLWB4JJKBAvaZiKJDx3bJLo6
        bXH/dX+gyaUCSW2dqHpCqWmowt2z4zFiKDCIRyaAwcmocn68HyaYZiHOE9hIcCmb
        h8xdZ2THXQkgKX3UZ/4ypF1n7/hrdfS7ykkmSEvMlUj5vPraTN1I2+ODg==
X-ME-Sender: <xms:CFvLZDRTq-ikE1JvxFS4rjPovecGPfURswu-gep2zqf1xjrjQbWKYA>
    <xme:CFvLZExBmRGF57c0cfPINKqvgeA4m-yZ2GTuJe1y4c7rJQtlCu-AE-v8_yfHGxjTk
    syOS8ImcYb9r1gAH7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkedugdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:CFvLZI1tW0Al3UxBK07DgjYdCcn59IaxQVgbuSiX3SUrr4bIY2bttA>
    <xmx:CFvLZDC_ORQhNbucjfWsc0FxRlHzgJ-ASv_0ip1AehGgPaK-vY4zoQ>
    <xmx:CFvLZMhL35qDy1rqMwe5PqLw4L3GNnV6yxNFo-j2qxDMyRlTMHlURw>
    <xmx:CVvLZLSt1m2ZkQNW_uj_Qq-3VqqGa-DldvzMzqXq15NZsNgWHexjbg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AD37DB6008D; Thu,  3 Aug 2023 03:45:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <193f9138-57e0-4d4b-8225-54d38be9bfbc@app.fastmail.com>
In-Reply-To: <20230803063703.5659-2-zhuyinbo@loongson.cn>
References: <20230803063703.5659-1-zhuyinbo@loongson.cn>
 <20230803063703.5659-2-zhuyinbo@loongson.cn>
Date:   Thu, 03 Aug 2023 09:44:52 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Yinbo Zhu" <zhuyinbo@loongson.cn>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, "Ulf Hansson" <ulf.hansson@linaro.org>
Cc:     "Jianmin Lv" <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        "Liu Peibao" <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev,
        "Liu Yun" <liuyun@loongson.cn>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 1/2] soc: dt-bindings: add loongson-2 pm
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023, at 08:37, Yinbo Zhu wrote:

> +  loongson,suspend-address:
> +    $ref: /schemas/types.yaml#/definitions/uint64
> +    description:
> +      The "loongson,suspend-address" is a deep sleep state (Suspend To
> +      RAM) firmware entry address which was jumped from kernel and it's
> +      value was dependent on specific platform firmware code. In
> +      addition, the PM need according to it to indicate that current
> +      SoC whether support Suspend To RAM.
> +

I just commented on this in the driver patch, assuming this
was an MMIO address, but I'm even more confused now, since
we try hard to not rely on being able to just interface with
firmware like this.

If this is executable code, where does this actually reside?
Is this some SRAM that needs to execute the suspend logic
in order to shut down memory and cache controllers? Or is
this a runtime firmware interface similar to how UEFI handles
its runtime services to keep the implementation out of
the kernel?

Does the code work with both traditional suspend-to-ram and
modern suspend-to-idle logic?

      Arnd
