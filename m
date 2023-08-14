Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3882177BA5A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjHNNmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjHNNmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:42:11 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7D9106;
        Mon, 14 Aug 2023 06:42:10 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 102A65C0072;
        Mon, 14 Aug 2023 09:42:08 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 14 Aug 2023 09:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1692020528; x=1692106928; bh=JtLQE1XjIOUZcTeTsP5whAkN0vSfae5cywo
        2KZQ9oJA=; b=Hu8nMt5o8LJapF9LALNUvc6uTUsBVbRUOS7ySwTg+z7NHo6rqpF
        /LN875sB3oFHQTsFvw9CPGWU+u7FopQZ6CiQNZe3dzZvsDF0UYimGNIfXCQ/SVet
        a//79hYibjZnoaYwsVix0301198piZ7hyLZE6r6p3p/CnGzXj5CoQtV1y1yhPd60
        +3utgJ7Hc8mEyzkdj4BOd2JB0SwI+qaKT9SqSnbfvBxRUq0Bkoa/H96WHAz34JLJ
        9k/W71Che1sm8cn0otOaC7iK9q2EkG401/fjuS7SQgIDx6vhzZ4p9ttcELkXZ63k
        do6aQ1vUlLQ02pXcr4HqMkuR8xl1JBP2VaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1692020528; x=1692106928; bh=JtLQE1XjIOUZcTeTsP5whAkN0vSfae5cywo
        2KZQ9oJA=; b=01YlBOWjN+e1GbWAOx3Ax+EupWSIxIfqoSedd53cZvYGLAvuH/A
        QjGCbYul5IctD6w9a3kd8K6lM3SIEPyEYTYB1jmpGcsUk1qcSCU8YyJkFuz7tq33
        ehRMmZsA+ogfmBgyalmyhnHHlC/B2zegZzYJe9p+6/kV8dazEhznKCTvABTpOUtH
        G/VQOSBjjXbLPi6yolCaStLDedP7fsW0kY0BdQyx3qylxJDegdYYdmuGl5Ev1OHi
        4bA/CE1H9DX+iCl3bhnwIj1RUdveoHFVWycEOudU14tbhkWsXCmDP9ZbFq0mMiRJ
        SqkME+1SLo3IJp4aOYVtTdzTrDVOuTi9w3Q==
X-ME-Sender: <xms:Ly_aZA6FBRQG91ir1YblSsCKmlE0GAAuNXnXuebFzT1IHe4lSvqm0A>
    <xme:Ly_aZB5XwpC8OI8RPOMPkNvAGjfu1RMJNmp4qMvq4-cXLxYIphSHYk1576oaRYkPm
    FdO_-w5NZTv4nO2jjk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtgedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeettedttdefhfekueduvedutdejudetgfekgfegfefhjeejteegveehtdeh
    veejgfenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhlihhnuhigqdhmihhpshdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegr
    rhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Ly_aZPdjDIjzWkp91VBvj4_-RGiPcA7UlyBa2Vooy8vUKT24gOScsQ>
    <xmx:Ly_aZFLmra1lC_zMbs0Ahvyc-j2KfEBjYn__eaOq1z08kGSDWsyBXg>
    <xmx:Ly_aZEKB1NsYWLJnm8L_5SXCD3D9YBczegVJOzwtGXJsPUWZutVdyQ>
    <xmx:MC_aZHY5T_hJwz4SLQ_AEy7fOWE5fcSiiwatXkIqV3DV3yE7br7jIA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 032FFB6008D; Mon, 14 Aug 2023 09:42:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <e04cf26e-2e38-4e87-b7b4-23dafadee00d@app.fastmail.com>
In-Reply-To: <71c53c37-a0a6-6b11-31d5-4455d2309927@loongson.cn>
References: <20230803063703.5659-1-zhuyinbo@loongson.cn>
 <20230803063703.5659-2-zhuyinbo@loongson.cn>
 <193f9138-57e0-4d4b-8225-54d38be9bfbc@app.fastmail.com>
 <8efeac46-ebb7-fa05-3d88-7c21acd59c8b@loongson.cn>
 <6d7335b4-63e2-4a7e-9620-8a0012558dfd@app.fastmail.com>
 <0616585d-1459-b6ef-375b-890426004e01@loongson.cn>
 <19feb595-e22a-4304-9b88-b5cb55949cd8@app.fastmail.com>
 <71c53c37-a0a6-6b11-31d5-4455d2309927@loongson.cn>
Date:   Mon, 14 Aug 2023 15:41:37 +0200
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023, at 13:57, Yinbo Zhu wrote:
> =E5=9C=A8 2023/8/14 =E4=B8=8B=E5=8D=884:19, Arnd Bergmann =E5=86=99=E9=
=81=93:
>> On Mon, Aug 14, 2023, at 09:57, Yinbo Zhu wrote:
>>> =E5=9C=A8 2023/8/12 =E4=B8=8B=E5=8D=888:25, Arnd Bergmann =E5=86=99=E9=
=81=93:
>>>> I found https://github.com/loongson-community/pmon source
>>>> code, and a reference to its origin at LSI Logic at
>>>> https://www.linux-mips.org/wiki/PMON but otherwise have
>>>> no idea about what this actually is, or how it relates
>>>> to your UEFI firmware. Did you add UEFI support to PMON,
>>>> or do you use it as a first stage loader that loads
>>>> the actual UEFI implementation (EDK2 or u-boot, I guess)?
>>>
>>>
>>> Pmon and uefi are two different firmware, and there is no connection
>>> between them.
>>=20
>> It sounds like we still have problems with terminology. >
>> I don't think categorizing UEFI as a firmware is correct,
>
>
> Sorry to have confused you, uefi firmware is our internal name, which =
is
> actually what you referred to as EDK2, the EDK2 need use UEFI.

Ok

>> it's the interface used by various firmware implementations
>> to load the operating system. As far as I understand,
>> loongarch currently mandates the use of UEFI in whichever
>> firmware is used, so if you have Pmon installed in ROM > and Pmon doe=
s not itself implement UEFI, it would have
>> to load some other firmware such as u-boot in order to
>> load a kernel through the UEFI protocol, right?
>
>
> PMON is an independent firmware and loader that can directly load the
> operating system and it does not require the use of UEFI.
>>=20
>> Has the assumption that loongarch requires UEFI changed?
>
>
> LoongArch embedded board was use Pmon firmware, The other one uses UEFI
> firmware (EDK2) on LoongArch platform.

I'm pretty sure we discussed this when the loongarch port
was originally merged, with the decisionto just use UEFI for
booting any kernel, as the legacy entry point for the ACPI
based environment was not really well-defined and the UEFI
stub was an easy alternative to have more commonality
with other architectures.

I see this was already extended for embedded CPUs to use
the uefi stub with DT in commit 88d4d957edc70 ("LoongArch: Add
FDT booting support from efi system table"), which seems like
the right direction.

Can you explain why this board would want yet another method
for entering the kernel? Is there any documentation for the
boot protocol?

>>>> Is this executing directly from ROM then?
>>>
>>> Yes.
>>=20
>> Is this the only runtime call into the firmware,=20
>
>
> Only when suspend-to-ram occurs, the kernel will call into the firmwar=
e.
> No other case.

Ok

>> or are there
>> others that are either already called from mainline kernels
>> or in your downsteam implementation?
>>=20
>> How do you ensure that the DTB matches the actual ROM code
>> after rebuilding Pmon? Does Pmon itself fill that field with
>> the correct address, or do you rely on it being a hardcoded
>> constant?
>
>
> Use Pmon, firmware team will always ensure that DTB matches the actual
> ROM code.  The "suspend-address" of dtb and pmon entry address will
> synchronized modification by firmware team.

Ok.  So it's linked against libfdt to fill the dtb information,
or do you have to provide a dtb blob that matches the firmware?

      Arnd
