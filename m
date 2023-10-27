Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2427DA1EE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 22:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjJ0Ur7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 16:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0Ur6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 16:47:58 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5091AA;
        Fri, 27 Oct 2023 13:47:56 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 9B4CC32009ED;
        Fri, 27 Oct 2023 16:47:52 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Fri, 27 Oct 2023 16:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1698439672; x=1698526072; bh=ek3ttmqAGFF4b8P7ZekDoufP/IL89Iv8HyQ
        dghd7eQw=; b=Z4WMUZhDnZqz+a0WJMIJMI5XvTPevqCISq4SLnCfib77DmwNemj
        olY2i7UYWCJutyEHM2xBEtIQCnm8azJ3RvZt26lIocoNTbxfFPLU3w9mO7nKjmHG
        xjzkaUWBjjLJyaCHHtEKY/7nfUeMxYFy8Rneb9LXpgV97o9vJQh6bxVOEslZGQ6n
        KoiU0U0ESxN4VnBSluoKvwQEfrKGj7Tjnbwm9Cn67rfsALyej0ToWV/iXPsWbeMJ
        jr4FnG/6+VY9MbS/1bNtkYebWQiFBLtQn9svmy6JfPujbXz/GXb5jnehQS3zVEaW
        IMlidcL5zmMpMMxbnnpDcyCwu9JPpY9HqWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698439672; x=1698526072; bh=ek3ttmqAGFF4b8P7ZekDoufP/IL89Iv8HyQ
        dghd7eQw=; b=fXiENQFKwbENZ9r0XcfO44FFDNd/9GhNP1B3Rw5tFkmzHbqXhI2
        hzINZsyksx/AczjafefYQjk+0rUPqB95H8Z3eqpiO47kLOYs3lXtbNTri4GGEydx
        4v5XR0BGlBnp2a5ReMBLtfvZO2ZkW4dvfAW8MKugDxKjc8ZwC6HvhAPkvuuiPNfO
        HC3AbVFvWV+pd3EXy2cQL2y23D6ajfwqLXK4aThMx2QF0GH5FY4sdbsiR4hE8MK1
        YutanSSRHHLZD+/Xjn6ebphHHoocg9A8uXvThwKW5gQbiq1rEgd+uoFx0vFNAoYB
        wwA5cROhgc+fFpqIz44GcW/CkVUIgZuwHNA==
X-ME-Sender: <xms:9yE8ZQIHiKEi6BQAJzWCwm0HiEjecD21esC_o7G_kHHmkMkx0zM0Fg>
    <xme:9yE8ZQLkBHdR4DgMnApjV8E3cI27DDAsLPGpavmXglA2O1R9wvr88_EapG-FvZ57N
    9u8Mah8UEXwiPabMBc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpefhueefgfeuueeuvedvhfehkedtuefhheefffdugeel
    keetffetgffhgefhlefhjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhoth
    hlihhnrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:9yE8ZQs5J_fpTh250RlOixAIDHg2bJQSEJG4DUtaYGrKfp_aIwi5gw>
    <xmx:9yE8ZdaX-t16pcRU6KOrKUHo0Cf_O2j3jHUA4e7Q678lOlMi_64-8g>
    <xmx:9yE8ZXauqHGMIiBHFTDKXMsfl8xx15D8WFZSFKtckuUhq4qM1JZDQQ>
    <xmx:-CE8ZWnU8qgYAyaRYoW8OWGA-v-WenPnXkK2vB6qIBtUtSlNkpvxFg>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 83A3C36A0075; Fri, 27 Oct 2023 16:47:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <bf0f31a4-bfcd-4951-8b7b-67d7c1faf344@app.fastmail.com>
In-Reply-To: <875y2s81lx.fsf@BL-laptop>
References: <20231023191400.170052-1-jiaxun.yang@flygoat.com>
 <875y2s81lx.fsf@BL-laptop>
Date:   Fri, 27 Oct 2023 21:47:33 +0100
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Gregory CLEMENT" <gregory.clement@bootlin.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        vladimir.kondratiev@intel.com
Subject: Re: [PATCH 0/5] MIPS: Fix kernel in XKPHYS
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82023=E5=B9=B410=E6=9C=8827=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8B=
=E5=8D=885:35=EF=BC=8CGregory CLEMENT=E5=86=99=E9=81=93=EF=BC=9A
> Hello Jiaxun,
>
>
>> Hi all,
>>
>> This series fixes support for loading kernel to XKPHYS space.
>> It is derived from "MIPS: use virtual addresses from xkphys for MIPS6=
4" [1].
>>
>> Boot tested on boston and QEMU with loading address set to 0xa8000000=
90000000.
>> QEMU patch on the way.
>>
>> Gregory and Vladimir, do let me know if I missed anything.
>
> Thanks for this series, I reviewed it and tested it on my platform, so
> you can add for all the patches:
>
> Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>
> However I add to fix the patch " MIPS: Handle mips_cps_core_entry with=
in
> lower 4G", I think you missed a case. I will comment on it.

I found a better solution for CPS handling, will send v2 later together =
with
fixes to bring TO_CAC to 32bit.

Thanks.
- Jiaxun

>
> Gregory
>
>
>>
>> Thanks
>> - Jiaxun
>>
>> [1]: https://lore.kernel.org/lkml/20231004161038.2818327-3-gregory.cl=
ement@bootlin.com/
>>
>> Jiaxun Yang (5):
>>   MIPS: Export higher/highest relocation functions in uasm
>>   MIPS: genex: Fix except_vec_vi for kernel in XKPHYS
>>   MIPS: Fix set_uncached_handler for ebase in XKPHYS
>>   MIPS: Handle mips_cps_core_entry within lower 4G
>>   MIPS: Allow kernel base to be set from Kconfig for all platforms
>>
>>  arch/mips/Kconfig               | 18 +++++++++++++----
>>  arch/mips/include/asm/mips-cm.h |  1 +
>>  arch/mips/include/asm/uasm.h    |  2 ++
>>  arch/mips/kernel/genex.S        | 19 +++++++++++++----
>>  arch/mips/kernel/smp-cps.c      | 27 +++++++++++++++++++------
>>  arch/mips/kernel/traps.c        | 36 +++++++++++++++++++++++--------=
--
>>  arch/mips/mm/uasm.c             |  6 ++++--
>>  7 files changed, 82 insertions(+), 27 deletions(-)
>>
>> --=20
>> 2.34.1
>>
>
> --=20
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> http://bootlin.com

--=20
- Jiaxun
