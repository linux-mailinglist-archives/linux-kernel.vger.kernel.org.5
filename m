Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CE875D9B3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGVEqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVEqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:46:46 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9075A3ABA;
        Fri, 21 Jul 2023 21:46:44 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 186613200910;
        Sat, 22 Jul 2023 00:46:40 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute2.internal (MEProxy); Sat, 22 Jul 2023 00:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1690001199; x=1690087599; bh=gVBZiaaQfOx5SYlJXYqrN/v0ssHWYelQxlU
        k0DAazRo=; b=fuSAlzDIYF/W81t8AQpzu4qSPjTEDln/iNw7bBmJE8nyYnLVzhr
        ouK+Oe1U/d0tFU0NAvxt6Gs+Mzt8BDc7sjZaJB707MiXmpj2ojv1EPbeyNjfZLa2
        1G+wq2YP3bBfWB14iNd3ZrpS48vYmGSzEKNsQF1M4l40XrtoRwdsPlJQYMFquk98
        PWveBn9ZD6LeKV0jqdxpkAQDxjSOBBpEeLQ/oQtswtYJb1I9SRTrwX9pvplESPhO
        hhm3Z59Tt9u6gqbg3gFv+nmh68KUbf4iKUMCvhkltL+gdqBpZUN44n1ugHwi74GD
        sI/AfKXK/CKv4dF1pb8OJswn0o2uPMC3Jig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690001199; x=1690087599; bh=gVBZiaaQfOx5SYlJXYqrN/v0ssHWYelQxlU
        k0DAazRo=; b=yN+g7pZ1PwfKINuReDMs1332gAwM84dgfonc4QGNPCT025ODbCs
        ZLh9kkd6zN2nBeFJPULENlnZiU4z/0OTm9+JXqLQ7OCO/kBAFB/jx+q4hChnh8U3
        rN9qk9HknyvAdS47TDD3qV58Ms4XfA8tLSicCi6cL+flyZ245clnine7Csfpou3b
        RGsdIJH0vUJE12ce7Rn1vMMNTianCHwmXKSZ5XSJ8xLV0b3vuoSkhKeLjpJL9w/v
        e5kbg/LxHycMaQjOOu2jMjQnvtmCQTKV1S62sGrm2cg/bgz8J5eWC/CNi/JFY8Iu
        bW4egRPcuzoWir6OFn88TvzEx0Ft8Nla5Mw==
X-ME-Sender: <xms:L1-7ZI2rS-qgh7GsrNMxiXNpckOsDsO5_PuVouQfzSHe2wwXGpHR2g>
    <xme:L1-7ZDHVSnLKRWTt2RwGUUnxgUc1kx1mSvJ1xpz82UkdC6M2JpoCAYzb0as2N5tUR
    SD4bCIeU_Z6omlWWC0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheefgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepkeelveffhedtiefgkeefhffftdduffdvueevtdffteeh
    ueeihffgteelkeelkeejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigr
    nhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:L1-7ZA4k8-My3Qk_o2LEWmE16OuOi4PakNur71ekklm31z-C3egiQg>
    <xmx:L1-7ZB1atiZD_gkPB5QOliRrkaP6GO6obxWOd43nYsfayC1wQ0d4dg>
    <xmx:L1-7ZLEwmsVDZfIDVM0GsqDTD3--Jv20A-hbm9Fcum3LXAs8tnT-kQ>
    <xmx:L1-7ZARDfvJaQPq3WUoqKC-UuRtwYillaEGw1rVEsl86H4d1fiQebQ>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1C77D36A0075; Sat, 22 Jul 2023 00:46:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <4e7e7e55-ba5a-4e48-a5f4-1bab69cc87fb@app.fastmail.com>
In-Reply-To: <ef4b3c72-1676-fc73-9eb6-5ea6539d8876@linaro.org>
References: <20230718134411.2871477-1-jiaxun.yang@flygoat.com>
 <ef4b3c72-1676-fc73-9eb6-5ea6539d8876@linaro.org>
Date:   Sat, 22 Jul 2023 12:46:18 +0800
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "kernel test robot" <lkp@intel.com>
Subject: Re: [PATCH] MIPS: Loongson64: Fix more __iomem attributes
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82023=E5=B9=B47=E6=9C=8819=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=E5=
=8D=887:39=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=93=EF=BC=9A
> On 18/7/23 15:44, Jiaxun Yang wrote:
>> There are some __iomem type casting being missed in previous patch.
>> Fix them here.
>>=20
>> Fixes: 5bd3990723bd ("MIPS: Loongson64: Prefix ipi register address p=
ointers with __iomem")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202307020639.QCZOKp8B-l=
kp@intel.com/
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>   arch/mips/loongson64/smp.c | 168 ++++++++++++++++++----------------=
---
>>   1 file changed, 84 insertions(+), 84 deletions(-)
>
>
>>   static void ipi_mailbox_buf_init(void)
>>   {
>> -	ipi_mailbox_buf[0] =3D (void *)
>> +	ipi_mailbox_buf[0] =3D (void __iomem *)
>>   		(SMP_CORE_GROUP0_BASE + SMP_CORE0_OFFSET + BUF);
>> -	ipi_mailbox_buf[1] =3D (void *)
>> +	ipi_mailbox_buf[1] =3D (void __iomem *)
>>   		(SMP_CORE_GROUP0_BASE + SMP_CORE1_OFFSET + BUF);
>> -	ipi_mailbox_buf[2] =3D (void *)
>> +	ipi_mailbox_buf[2] =3D (void __iomem *)
>>   		(SMP_CORE_GROUP0_BASE + SMP_CORE2_OFFSET + BUF);
>> -	ipi_mailbox_buf[3] =3D (void *)
>> +	ipi_mailbox_buf[3] =3D (void __iomem *)
>>   		(SMP_CORE_GROUP0_BASE + SMP_CORE3_OFFSET + BUF);
>> -	ipi_mailbox_buf[4] =3D (void *)
>> +	ipi_mailbox_buf[4] =3D (void __iomem *)
>>   		(SMP_CORE_GROUP1_BASE + SMP_CORE0_OFFSET + BUF);
>> -	ipi_mailbox_buf[5] =3D (void *)
>> +	ipi_mailbox_buf[5] =3D (void __iomem *)
>>   		(SMP_CORE_GROUP1_BASE + SMP_CORE1_OFFSET + BUF);
>> -	ipi_mailbox_buf[6] =3D (void *)
>> +	ipi_mailbox_buf[6] =3D (void __iomem *)
>>   		(SMP_CORE_GROUP1_BASE + SMP_CORE2_OFFSET + BUF);
>> -	ipi_mailbox_buf[7] =3D (void *)
>> +	ipi_mailbox_buf[7] =3D (void __iomem *)
>>   		(SMP_CORE_GROUP1_BASE + SMP_CORE3_OFFSET + BUF);
>> -	ipi_mailbox_buf[8] =3D (void *)
>> +	ipi_mailbox_buf[8] =3D (void __iomem *)
>>   		(SMP_CORE_GROUP2_BASE + SMP_CORE0_OFFSET + BUF);
>> -	ipi_mailbox_buf[9] =3D (void *)
>> +	ipi_mailbox_buf[9] =3D (void __iomem *)
>>   		(SMP_CORE_GROUP2_BASE + SMP_CORE1_OFFSET + BUF);
>> -	ipi_mailbox_buf[10] =3D (void *)
>> +	ipi_mailbox_buf[10] =3D (void __iomem *)
>>   		(SMP_CORE_GROUP2_BASE + SMP_CORE2_OFFSET + BUF);
>> -	ipi_mailbox_buf[11] =3D (void *)
>> +	ipi_mailbox_buf[11] =3D (void __iomem *)
>>   		(SMP_CORE_GROUP2_BASE + SMP_CORE3_OFFSET + BUF);
>> -	ipi_mailbox_buf[12] =3D (void *)
>> +	ipi_mailbox_buf[12] =3D (void __iomem *)
>>   		(SMP_CORE_GROUP3_BASE + SMP_CORE0_OFFSET + BUF);
>> -	ipi_mailbox_buf[13] =3D (void *)
>> +	ipi_mailbox_buf[13] =3D (void __iomem *)
>>   		(SMP_CORE_GROUP3_BASE + SMP_CORE1_OFFSET + BUF);
>> -	ipi_mailbox_buf[14] =3D (void *)
>> +	ipi_mailbox_buf[14] =3D (void __iomem *)
>>   		(SMP_CORE_GROUP3_BASE + SMP_CORE2_OFFSET + BUF);
>> -	ipi_mailbox_buf[15] =3D (void *)
>> +	ipi_mailbox_buf[15] =3D (void __iomem *)
>>   		(SMP_CORE_GROUP3_BASE + SMP_CORE3_OFFSET + BUF);
>>   }
>
> OK up to here,
>
>> @@ -782,7 +782,7 @@ void play_dead(void)
>>  =20
>>   	if (prid_imp =3D=3D PRID_IMP_LOONGSON_64G) {
>>   		play_dead_at_ckseg1 =3D
>> -			(void *)CKSEG1ADDR((unsigned long)loongson3_type3_play_dead);
>> +			(void __iomem *)CKSEG1ADDR((unsigned long)loongson3_type3_play_de=
ad);
>
> but these changes look dubious.

Oops, will fix later.

Thanks

>
>>   		goto out;
>>   	}
>>  =20
>> @@ -790,19 +790,19 @@ void play_dead(void)
>>   	case PRID_REV_LOONGSON3A_R1:
>>   	default:
>>   		play_dead_at_ckseg1 =3D
>> -			(void *)CKSEG1ADDR((unsigned long)loongson3_type1_play_dead);
>> +			(void __iomem *)CKSEG1ADDR((unsigned long)loongson3_type1_play_de=
ad);
>>   		break;
>>   	case PRID_REV_LOONGSON3B_R1:
>>   	case PRID_REV_LOONGSON3B_R2:
>>   		play_dead_at_ckseg1 =3D
>> -			(void *)CKSEG1ADDR((unsigned long)loongson3_type2_play_dead);
>> +			(void __iomem *)CKSEG1ADDR((unsigned long)loongson3_type2_play_de=
ad);
>>   		break;
>>   	case PRID_REV_LOONGSON3A_R2_0:
>>   	case PRID_REV_LOONGSON3A_R2_1:
>>   	case PRID_REV_LOONGSON3A_R3_0:
>>   	case PRID_REV_LOONGSON3A_R3_1:
>>   		play_dead_at_ckseg1 =3D
>> -			(void *)CKSEG1ADDR((unsigned long)loongson3_type3_play_dead);
>> +			(void __iomem *)CKSEG1ADDR((unsigned long)loongson3_type3_play_de=
ad);
>>   		break;
>>   	}
>>

--=20
- Jiaxun
