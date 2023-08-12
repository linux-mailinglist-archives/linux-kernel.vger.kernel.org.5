Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6719B779FF7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 14:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbjHLMZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 08:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjHLMZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 08:25:27 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E19E62;
        Sat, 12 Aug 2023 05:25:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D7A935C00F2;
        Sat, 12 Aug 2023 08:25:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 12 Aug 2023 08:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1691843127; x=1691929527; bh=+DE7K+FkDwlmdeL3CpVV/dlir8qOYF4EGSw
        DTQ8Iztc=; b=JArr1yVWNA+hyM/8PmwyBL5cCOeyn7ppUeMvEj3q6erbi0eVawO
        867hmjCwtRzshjj2II9l4BZKRuGGCWLMkuP/Tz/OAalpUsmZM1BJGT78l2AG0a7d
        gIR73l20BuTSrI5WwqBqiou8kAjZCn4k+C8idCsQE+gb5gn6UUA9mKj46tB92fj5
        esXxYeS5cZLNSKqyZBfQM8S5e4522oHRV0grJaSo3Y7WR0DwZXZ02YsllhwdAwrP
        Q0IflLIBUqovRLVQ784WxamIL05exxJ5WruA/DK7ljvJndImRdIqE9o+MMDk+YKp
        vAXNEpdE8rvzXzC1CM81oyXljQQcVSJi+mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691843127; x=1691929527; bh=+DE7K+FkDwlmdeL3CpVV/dlir8qOYF4EGSw
        DTQ8Iztc=; b=Az+t/QSiqKmMPqKtoziHfe7jvt4TJZzOE1fILZdhkcUAndG4fn8
        eAreGmEkLX/xwFMV0GsoLrVMOhFDfXCIJD3LJ/0phyC2Q8PDF1n7Cxq1tuE4L7G3
        9sDzitcmlA8w8LoYLCUxLxF+YLQj6fDGzTSfNN8Axz7WJbkXKFqHM5OEoTyzLQek
        Ff+9ZflUFUQmEyZNs5D0IUgSCQeLiABn/iMNOpkAPEE8DxrbtuihPDk8qR1qEjN5
        Y+tjaINHK7bM0/uSb3RlrvuJJb/KXXMGdOBsej/cCwkKqyy3sW7mLqKaZET0DGhf
        gQoJPttwz9jPteAjvxC47AVo3AX0ZLrLjGg==
X-ME-Sender: <xms:NnrXZIzvzHGDioQfqPjdOYWvVqV7l4pnddLNQ9kqdvM7IZ5lS267EQ>
    <xme:NnrXZMTifxguaVpAQlXXwXslDwd56SoT_D1BJsSPRC08gVTabjHd5tg5qWZAMTTAM
    13ktE_tmuUa2w22Pxo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddttddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeettedttdefhfekueduvedutdejudetgfekgfegfefhjeejteegveehtdeh
    veejgfenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhlihhnuhigqdhmihhpshdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegr
    rhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:NnrXZKX9P1BhvMJDQMMiY_IYIPZHOeNBSEWK5rOrNIWPbKu4bpWFiA>
    <xmx:NnrXZGipINhmUz8Wv4-kl9WFBgJe4FtJ4ccxqF68HUAyxkE0vI43KQ>
    <xmx:NnrXZKBVP_aSNVnYmUKzXmng-IlmF0BY_vpf_iyUsGyelQuMHLJVrg>
    <xmx:N3rXZGzh1zo1LBJT5Oeh7YcR2sxGyGV06W2jhv1PJY6SUMznMbBNsg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A7436B60089; Sat, 12 Aug 2023 08:25:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <6d7335b4-63e2-4a7e-9620-8a0012558dfd@app.fastmail.com>
In-Reply-To: <8efeac46-ebb7-fa05-3d88-7c21acd59c8b@loongson.cn>
References: <20230803063703.5659-1-zhuyinbo@loongson.cn>
 <20230803063703.5659-2-zhuyinbo@loongson.cn>
 <193f9138-57e0-4d4b-8225-54d38be9bfbc@app.fastmail.com>
 <8efeac46-ebb7-fa05-3d88-7c21acd59c8b@loongson.cn>
Date:   Sat, 12 Aug 2023 14:25:05 +0200
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023, at 04:54, Yinbo Zhu wrote:
> =E5=9C=A8 2023/8/3 =E4=B8=8B=E5=8D=883:44, Arnd Bergmann =E5=86=99=E9=81=
=93:
>> On Thu, Aug 3, 2023, at 08:37, Yinbo Zhu wrote:
>>=20
>>> +  loongson,suspend-address:
>>> +    $ref: /schemas/types.yaml#/definitions/uint64
>>> +    description:
>>> +      The "loongson,suspend-address" is a deep sleep state (Suspend=
 To
>>> +      RAM) firmware entry address which was jumped from kernel and =
it's
>>> +      value was dependent on specific platform firmware code. In
>>> +      addition, the PM need according to it to indicate that current
>>> +      SoC whether support Suspend To RAM.
>>> +
>>=20
>> I just commented on this in the driver patch, assuming this
>> was an MMIO address, but I'm even more confused now, since
>> we try hard to not rely on being able to just interface with
>> firmware like this.
>>=20
>> If this is executable code, where does this actually reside?
>
>
> Pmon firmware code.
>
>> Is this some SRAM that needs to execute the suspend logic
>> in order to shut down memory and cache controllers?=20
>
>
> Yes, The suspend-to-ram after into pmon firmware code and set
> self-refresh mode in memory controller and ensure that memory data is
> not lost then shut down memory controller.

I'm sorry I missed your reply earlier, getting back to the
thread now. So it's clear that this code needs to run in a
special memory from your description, but I'm still trying
to understand the details better.

I found https://github.com/loongson-community/pmon source
code, and a reference to its origin at LSI Logic at
https://www.linux-mips.org/wiki/PMON but otherwise have
no idea about what this actually is, or how it relates
to your UEFI firmware. Did you add UEFI support to PMON,
or do you use it as a first stage loader that loads
the actual UEFI implementation (EDK2 or u-boot, I guess)?

>> Or is
>> this a runtime firmware interface similar to how UEFI handles
>> its runtime services to keep the implementation out of
>> the kernel?
>
>
> No, The main cpu and other cpu will offline that after into firmware a=
nd
> finished Corresponding operations, the pmon firmware will not run.

I'm still trying to understand your explanations here.
You say that pmon no longer runs, but that seems to contradict
what you said earlier about branching into pmon firmware code
for suspend.

Is this executing directly from ROM then?

       Arnd
