Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9F077B3DD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjHNIUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbjHNIUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:20:14 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481CEA6;
        Mon, 14 Aug 2023 01:20:13 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6DAED5C0114;
        Mon, 14 Aug 2023 04:20:12 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 14 Aug 2023 04:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1692001212; x=1692087612; bh=B51Onwh3iWBAAPtdsNjfOqvNOpKIaP2W3tR
        msFA0aKE=; b=TMH+OHpgzNCd4Six7k9m/+K7EdFcOikfRALEuZrd/RvwI0OVLFF
        vx/PNfza3P6C452k1Iz+k2BxPQH7WkLH+4jt37cmZIgfB9peL/4fg5ebNAaYvxfb
        kbM0cK3pQ/cmBi1oXKj/vi341jAR0rHUe50LCBdizobNlC0T0MyxX4rMrYwFR993
        xCw1KndzQlg/4e2FVGDyzA1s3ip+GU+JjDq5kdRsNoY46a6o8qaq207GywGpS7Ms
        th5ZvtLzAwroyCZcmEEmF9GuQBLTnzXAutfM7dB9QDUG94MnvwlqZqRP2YwHEkCU
        lCGkBLJjTNTAzBTFO058sowVJ3ZGu7ZxRdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1692001212; x=1692087612; bh=B51Onwh3iWBAAPtdsNjfOqvNOpKIaP2W3tR
        msFA0aKE=; b=MJkvaMv0Ijx/vjESlu3NDBeAKtTKYM/jAgwOhIBurbT7jBxo38e
        Qo+kVTfavZImHEFdvhcShCxgznhcdDFjPrQQiWerFxLyGUqQ0/5YGJy/jxrOBPTP
        SonEY5TfhdDnVncCgrpMcCFUbI/cbOonlA/ZXsVzg5Sk37IuEIGoNHxkS0XcU42g
        GSy6OFI+C41MJbC4oWCg/geQvFWoog5p6ee+YMjHtQ7X4CimNLgVDYb8G/IrLlci
        00jtuzjrWfMY+CbqxVUEEjPblzXIaeEaNPFGPMG0oxRyUfp+EeYJqe2ujgiaQgco
        jNUBtWeeG0cbxZ6cdctD6m+WuR3k88zm2uw==
X-ME-Sender: <xms:u-PZZK6Vv_mMrP4elr-XUPlX1OEQt4BoQTl1mBsuQZ4ZiKjZveYG2g>
    <xme:u-PZZD4ra58VdJIjnH9x-dN_fwI-4PbtOibrUPPi2JwD1y9TilC_mrc5oWjxEbsAN
    _XtW-w29lrqHsl1lWU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtgedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeettedttdefhfekueduvedutdejudetgfekgfegfefhjeejteegveehtdeh
    veejgfenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhlihhnuhigqdhmihhpshdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegr
    rhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:u-PZZJd1A8KNHsZsQV6ydlMx6A41uEN6W268ArxUt2kjybCeiCDFlg>
    <xmx:u-PZZHInNlWjmB3NQwLTiQX9NVBzi4BwJgXV0AZ6IHvg-O5iQ5rU9g>
    <xmx:u-PZZOL72mS2HRU-guEhimaq_Tyhk6StEFW-7Izd07mqXATvBYv7Jw>
    <xmx:vOPZZJZ0ucCZ5qCMB0aL-BRyEFaODwgEbRPKP2u42lrXDwJ8lBS5nQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6D7CFB60089; Mon, 14 Aug 2023 04:20:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <19feb595-e22a-4304-9b88-b5cb55949cd8@app.fastmail.com>
In-Reply-To: <0616585d-1459-b6ef-375b-890426004e01@loongson.cn>
References: <20230803063703.5659-1-zhuyinbo@loongson.cn>
 <20230803063703.5659-2-zhuyinbo@loongson.cn>
 <193f9138-57e0-4d4b-8225-54d38be9bfbc@app.fastmail.com>
 <8efeac46-ebb7-fa05-3d88-7c21acd59c8b@loongson.cn>
 <6d7335b4-63e2-4a7e-9620-8a0012558dfd@app.fastmail.com>
 <0616585d-1459-b6ef-375b-890426004e01@loongson.cn>
Date:   Mon, 14 Aug 2023 10:19:51 +0200
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
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023, at 09:57, Yinbo Zhu wrote:
> =E5=9C=A8 2023/8/12 =E4=B8=8B=E5=8D=888:25, Arnd Bergmann =E5=86=99=E9=
=81=93:
>> On Fri, Aug 4, 2023, at 04:54, Yinbo Zhu wrote:
>>> =E5=9C=A8 2023/8/3 =E4=B8=8B=E5=8D=883:44, Arnd Bergmann =E5=86=99=E9=
=81=93:
>>>> On Thu, Aug 3, 2023, at 08:37, Yinbo Zhu wrote:
>>>
>>>> Is this some SRAM that needs to execute the suspend logic
>>>> in order to shut down memory and cache controllers?
>>>
>>>
>>> Yes, The suspend-to-ram after into pmon firmware code and set
>>> self-refresh mode in memory controller and ensure that memory data is
>>> not lost then shut down memory controller.
>>=20
>> I'm sorry I missed your reply earlier, getting back to the
>> thread now. So it's clear that this code needs to run in a
>> special memory from your description, but I'm still trying
>> to understand the details better.
>>=20
>> I found https://github.com/loongson-community/pmon source
>> code, and a reference to its origin at LSI Logic at
>> https://www.linux-mips.org/wiki/PMON but otherwise have
>> no idea about what this actually is, or how it relates
>> to your UEFI firmware. Did you add UEFI support to PMON,
>> or do you use it as a first stage loader that loads
>> the actual UEFI implementation (EDK2 or u-boot, I guess)?
>
>
> Pmon and uefi are two different firmware, and there is no connection
> between them.

It sounds like we still have problems with terminology.

I don't think categorizing UEFI as a firmware is correct,
it's the interface used by various firmware implementations
to load the operating system. As far as I understand,
loongarch currently mandates the use of UEFI in whichever
firmware is used, so if you have Pmon installed in ROM,
and Pmon does not itself implement UEFI, it would have
to load some other firmware such as u-boot in order to
load a kernel through the UEFI protocol, right?

Has the assumption that loongarch requires UEFI changed?

>>>> Or is
>>>> this a runtime firmware interface similar to how UEFI handles
>>>> its runtime services to keep the implementation out of
>>>> the kernel?
>>>
>>>
>>> No, The main cpu and other cpu will offline that after into firmware=
 and
>>> finished Corresponding operations, the pmon firmware will not run.
>>=20
>> I'm still trying to understand your explanations here.
>> You say that pmon no longer runs, but that seems to contradict
>> what you said earlier about branching into pmon firmware code
>> for suspend.
>
>
> It's not contradictory.  The suspend-to-ram is that from kernel goto to
> pmon firmware code, then pmon finished corresponding operations, which
> was to set self-refresh mode in memory controller, then memory HW will
> maintain its own data and no longer requires software processing, pmon
> firmware will not run.

That is what I mean with a "runtime firmware interface", i.e. you
jump into firmware in order to request services from it. Clearly the
firmware itself does not run while the OS is executing code, but it is
still there and waiting to be called here, which is similar to
things like UEFI runtime services, PowerPC RTAS, Arm EL3/trustzone
based firmware or x86 SMM firmware, except that this is much less
formalized and only consists of an entry point with undocument
calling conventions.

>> Is this executing directly from ROM then?
>
> Yes.

Is this the only runtime call into the firmware, or are there
others that are either already called from mainline kernels
or in your downsteam implementation?

How do you ensure that the DTB matches the actual ROM code
after rebuilding Pmon? Does Pmon itself fill that field with
the correct address, or do you rely on it being a hardcoded
constant?

     Arnd
