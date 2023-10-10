Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AF97BF691
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjJJI4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjJJI4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:56:07 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65B297;
        Tue, 10 Oct 2023 01:56:03 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4E3FF5C01BA;
        Tue, 10 Oct 2023 04:56:01 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Tue, 10 Oct 2023 04:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1696928161; x=1697014561; bh=cMrT6oQLJKD/UFrbVl1BexNgkcPTW0+RFma
        e0fqFgFw=; b=wJOr+LIp9sP2y0Dia6ik8+mzyZOHZ0K/mcrKiHd0TLp8ScwP2+V
        Yv4m4/p9jnqHO+ARVS9HxxFuOPtW2EnDcL7PsjK+NLDrvS5BjHJD5UnTgaVcvk7R
        uWCRyZTmD9cOQYDkfYoCrmL8kUcC2euQIrNjhP8jiP4BicvR+0q5dwPL3q/Btvv+
        c3z7oYbVtZrxSdwuG6yhg+fr7VJGWD+2b0ZikgDvglRSbqnExqA3iNLMP1a9kAbZ
        wHdtFA/zBXUbuAkaHeAB/e24CuH4i1qiF7OO1sYEOFOv4CRbN3AIs/mSmKdIa+aF
        f4CATaUiqm6gCVV69gMgSVVJ1+bH6FvrxqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696928161; x=1697014561; bh=cMrT6oQLJKD/UFrbVl1BexNgkcPTW0+RFma
        e0fqFgFw=; b=TDCook6trC2hcQRNuFJqX55QRqASsVi7o7Cp87CaaLEPkL7YrJQ
        Q0Esg7yCRInxMCAM34G9Qs6BQyL7TJYZAFTzvL64FK8E+B3bxEsXcFubaGsk5J/n
        8m5s0crr85jWgt+tipPnr5GBChtuw/3Wk9SXd+8FLkslyl1Jbos7+vpXT6n60Y2W
        jwfGUeT41Sqi1GN5Q3OyiCw7Ap27qwv/nKcqBbONORVIOc5OE5wlM4+pEieuJZDK
        FoM9e64A2u97PjswXHSRmMdnhuOL90iYYrMeiEhLqyhmeNS/O1BwkQdkGU2aOENi
        ysiTJyemizRNenilvDgibQ4yDwvXPf6Zz6g==
X-ME-Sender: <xms:oBElZcC7EYATwJVzko6W4UkDpKye9jMupkIif4P2H5SbWyASOMlCaA>
    <xme:oBElZeiMMVP88vIFXFo5oI_woJjO95sm_DEepiarUWW5QE_6kzFuGD8KfKWxJ-AwR
    P3XWeI-u5YYBZgGUpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepvdduvefffeejlefhjeeugedvfefhhfehkeevveeugeeu
    udevuddthfdtudeiieetnecuffhomhgrihhnpegvlhhinhhugidrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigr
    nhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:oBElZfnG8f0nfv5QRCqBDYNWO7CMzIz-g_mnzceAKXAvD8BrtIQX9g>
    <xmx:oBElZSzaJPkJ8yF7f25VGSkEveKPf5Hiua6kuUJhkhbfmMvXsK3Fdw>
    <xmx:oBElZRQxiLXTGHMxArQC_w-niIBZPerHwiuK-MkymlUFLLPKczWD4g>
    <xmx:oRElZWIwbXWtEfB5qwtaCb5Hx3j5JkWtIeli0MetBFOwIekjdZlKxg>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 945BC36A0080; Tue, 10 Oct 2023 04:56:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <e5b8c68e-8a1d-45e7-92bf-db0c2fa812ad@app.fastmail.com>
In-Reply-To: <87edi3bxcl.fsf@BL-laptop>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
 <20231004161038.2818327-4-gregory.clement@bootlin.com>
 <f98d0cf9-6339-4cb1-8019-56bc71bfb822@app.fastmail.com>
 <87edi3bxcl.fsf@BL-laptop>
Date:   Tue, 10 Oct 2023 09:55:40 +0100
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Gregory CLEMENT" <gregory.clement@bootlin.com>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Vladimir Kondratiev" <vladimir.kondratiev@intel.com>,
        "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 03/11] MIPS: support RAM beyond 32-bit
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82023=E5=B9=B410=E6=9C=889=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8B=E5=
=8D=884:59=EF=BC=8CGregory CLEMENT=E5=86=99=E9=81=93=EF=BC=9A
> Hello Jiaxun,
>
>> =E5=9C=A82023=E5=B9=B410=E6=9C=884=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8B=
=E5=8D=885:10=EF=BC=8CGregory CLEMENT=E5=86=99=E9=81=93=EF=BC=9A
>>> From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
>>>
>>> Support platforms where RAM is mapped beyond 32-bit.
>>>
>>> The kernel parameter ddr32_alias allows to setup the alias to point
>>> outside the first 4 GB of memory.
>>
>> Are you trying to fix the problem that if kernel text is loaded in
>> XKPHYS there is no way to to set EBASE to that region?
>
> Yes that exactly we try to fix.
>
>>
>> The common practice for other 64bit MIPS system is to load kernel
>> in KSEG0 and add low 4G mirror with rest of the high memory to buddy
>> system. By doing this Kernel still have access to all memory beyond
>> 32 bit, the only draw back is Kernel's text and data can't be relocted
>> beyond 32-bit.
>>
>> Loading kernel into KSEG0 (i.e. with KBUILD_SYM32) have significant b=
enefit
>> on performance, so I think you shouldn't try to load kernel into XKPH=
YS
>> without a good reason, but it might be helpful to add a BUG_ON at
>> CPS driver to handle such situation.
>
> I guess that being in KSEG0 allows to use shorter pointer.  But in our
> case the RAM is physically connected beyond 32bits, so it is not
> accessible in KSEG0.

For most system there should be a mirror of part of DDR which is accessi=
ble
at KSEG0 and kernel runs from here. As per my interpretion of your code =
EyeQ5
is also doing this? If not could you please briefly describe the memory =
map?

For Kernel in KSEG0 the pointer is still 64bit but we can use fewer inst
to load ABS pointer into register, see [1].

>>
>> Btw: Is your target hardware publicly available? Folks at CIP United
>> are looking for EyeQ5 boards for a while, they are supporting MIPS R6
>> support at various projects.
>
> We use evaluation boards and I don't know if they are publicly
> available.
>
> Gregory
>
[1]: https://elinux.org/images/1/1f/New-tricks-mips-linux.pdf

Thanks
- Jiaxun
