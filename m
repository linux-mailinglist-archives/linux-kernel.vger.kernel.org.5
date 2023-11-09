Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521987E6AA1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjKIMdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjKIMdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:33:40 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1D22D57;
        Thu,  9 Nov 2023 04:33:38 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc9784dbc1so6977565ad.2;
        Thu, 09 Nov 2023 04:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699533218; x=1700138018; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTHBXAc9zM9xt1Wy1erfrR/9L+jcsqcOSfBsUDoZoMI=;
        b=jnQDT3HuLWzY9jAD4pmToxxFW4CuaCT2qfDGpcxgKKa4kcVnHV3zBkgzAWcFjtC9PF
         o3ig0fafnWaV/pKUT7V4pLnp9YYso+7wdazgASYu228gq7YZEzCANqC6ABxrO5d+8rpQ
         SY2JPUmeCwNbGDQ86+fOahGLTBzUXkjWy+/Lgz/WI/PfyXiEULDjXGNTnnAhgc0419fo
         m35VIg5jzWZaj2rg3zolR992AiUVbuLnL8X54zJsnUjDtX0a+JBbtI8VnaUU9BPEvww3
         oOMv73w8PvP3Pz1DtyFFqqJn+GCJe4UyhBdXKGC/GJtLbR6h1MLIpcuJlmNbHwrJouZ/
         78gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699533218; x=1700138018;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTHBXAc9zM9xt1Wy1erfrR/9L+jcsqcOSfBsUDoZoMI=;
        b=XPQ169g2CK1mE2/rNI/ryZc+qagYTv/G8U2ySsp6WoQ1dwgDCs4WQmTsYmfN4eS7qw
         28MpmbCzseB3kGKK0XFDorsXkOXuSDblIU1CGKuQlpbaM2DuZlzIu9vnw0AtBixlUWV7
         g4aakvO1VYzhbhd3GikWuaiH/VvW1z77X1WvZ1mGUVGIxMpw88lPLLSNFopTVUOXVqOw
         ETDgBhxkGbibGEqsK3wtXRfccSmOUOeTui2vd4tXkx5RjfE+mdMSQRmz60u7lyiIHPlR
         A/d0AyK6LpHDoQN9aTHOwza1mV3FR4u2yyGFaJ6Zm+KZ9zNZQ+S80wvmEUxuNSD0kUYq
         yLKA==
X-Gm-Message-State: AOJu0YxtZgD5BxBcaTPqCYmuue1fGMUdAjX+OA+oKYN1+dc2llN+Ir3d
        MFlmLDFSw+jnFg79fYJN2KY=
X-Google-Smtp-Source: AGHT+IEWqil4LO0GuTbHAh6kUp2YrHS6DfkZH2dJOZVMwpiGaNIcEpflnfIgcd8Jp9z3stQgvB6oBw==
X-Received: by 2002:a17:902:ec83:b0:1ca:a290:4c0c with SMTP id x3-20020a170902ec8300b001caa2904c0cmr6188990plg.16.1699533217532;
        Thu, 09 Nov 2023 04:33:37 -0800 (PST)
Received: from smtpclient.apple ([2401:e180:8821:59e0:e5cc:8803:56b9:e782])
        by smtp.gmail.com with ESMTPSA id h21-20020a170902eed500b001bf846dd2d0sm3426037plb.13.2023.11.09.04.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 04:33:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Mining Lin <mimi05633@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 1/1] rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R
Date:   Thu, 9 Nov 2023 20:33:25 +0800
Message-Id: <79C789B5-345A-44F0-B81E-A0FB7E64235B@gmail.com>
References: <20231103231735b4769ca4@mail.local>
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
        KFLIN@nuvoton.com, mylin1@nuvoton.com, openbmc@lists.ozlabs.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231103231735b4769ca4@mail.local>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
X-Mailer: iPhone Mail (20G81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Alexandre,

I will add change log next patch.

Thanks.
Best regard,
Mia

Sent from my iPhone

> On Nov 4, 2023, at 7:17 AM, Alexandre Belloni <alexandre.belloni@bootlin.c=
om> wrote:
>=20
> =EF=BB=BFOn 04/11/2023 00:16:40+0100, Alexandre Belloni wrote:
>>> On 13/09/2023 09:37:19+0800, Mia Lin wrote:
>>> The NCT3015Y-R and NCT3018Y-R use the same datasheet
>>>    but have different topologies as follows.
>>> - Topology (Only 1st i2c can set TWO bit and HF bit)
>>>  In NCT3015Y-R,
>>>    rtc 1st i2c is connected to a host CPU
>>>    rtc 2nd i2c is connected to a BMC
>>>  In NCT3018Y-R,
>>>    rtc 1st i2c is connected to a BMC
>>>    rtc 2nd i2c is connected to a host CPU
>>> In order to be compatible with NCT3015Y-R and NCT3018Y-R,
>>> - In probe,
>>>  If part number is NCT3018Y-R, only set HF bit to 24-Hour format.
>>>  Else, do nothing
>>> - In set_time,
>>>  If part number is NCT3018Y-R && TWO bit is 0,
>>>     change TWO bit to 1, and restore TWO bit after updating time.
>>>=20
>>> Signed-off-by: Mia Lin <mimi05633@gmail.com>
>>> ---
>=20
> I forgot to add, please include a changelog here, this will make my
> reviews easier (and faster).
>=20
>>> drivers/rtc/rtc-nct3018y.c | 52 +++++++++++++++++++++++++++++++++-----
>>> 1 file changed, 46 insertions(+), 6 deletions(-)
>>>=20
>>> diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
>>> index ed4e606be8e5..b006b58e15e2 100644
>>> --- a/drivers/rtc/rtc-nct3018y.c
>>> +++ b/drivers/rtc/rtc-nct3018y.c
>>> @@ -23,6 +23,7 @@
>>> #define NCT3018Y_REG_CTRL    0x0A /* timer control */
>>> #define NCT3018Y_REG_ST        0x0B /* status */
>>> #define NCT3018Y_REG_CLKO    0x0C /* clock out */
>>> +#define NCT3018Y_REG_PART    0x21 /* part info */
>>>=20
>>> #define NCT3018Y_BIT_AF        BIT(7)
>>> #define NCT3018Y_BIT_ST        BIT(7)
>>> @@ -37,10 +38,12 @@
>>> #define NCT3018Y_REG_BAT_MASK        0x07
>>> #define NCT3018Y_REG_CLKO_F_MASK    0x03 /* frequenc mask */
>>> #define NCT3018Y_REG_CLKO_CKE        0x80 /* clock out enabled */
>>> +#define NCT3018Y_REG_PART_NCT3018Y    0x02
>>>=20
>>> struct nct3018y {
>>>    struct rtc_device *rtc;
>>>    struct i2c_client *client;
>>> +    int part_num;
>>> #ifdef CONFIG_COMMON_CLK
>>>    struct clk_hw clkout_hw;
>>> #endif
>>> @@ -177,8 +180,27 @@ static int nct3018y_rtc_read_time(struct device *de=
v, struct rtc_time *tm)
>>> static int nct3018y_rtc_set_time(struct device *dev, struct rtc_time *tm=
)
>>> {
>>>    struct i2c_client *client =3D to_i2c_client(dev);
>>> +    struct nct3018y *nct3018y =3D dev_get_drvdata(dev);
>>>    unsigned char buf[4] =3D {0};
>>> -    int err;
>>> +    int err, flags;
>>> +    int restore_flags =3D 0;
>>> +
>>> +    flags =3D i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
>>> +    if (flags < 0) {
>>> +        dev_dbg(&client->dev, "Failed to read NCT3018Y_REG_CTRL.\n");
>>> +        return flags;
>>> +    }
>>> +
>>> +    /* Check and set TWO bit */
>>> +    if ((nct3018y->part_num & NCT3018Y_REG_PART_NCT3018Y) && !(flags & N=
CT3018Y_BIT_TWO)) {
>>> +        restore_flags =3D 1;
>>> +        flags |=3D NCT3018Y_BIT_TWO;
>>> +        err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, fl=
ags);
>>> +        if (err < 0) {
>>> +            dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL.\n=
");
>>> +            return err;
>>> +        }
>>> +    }
>>>=20
>>>    buf[0] =3D bin2bcd(tm->tm_sec);
>>>    err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_SC, buf[0]);
>>> @@ -212,6 +234,18 @@ static int nct3018y_rtc_set_time(struct device *dev=
, struct rtc_time *tm)
>>>        return -EIO;
>>>    }
>>>=20
>>> +    /* Restore TWO bit */
>>> +    if (restore_flags) {
>>> +        if (nct3018y->part_num & NCT3018Y_REG_PART_NCT3018Y)
>>> +            flags &=3D ~NCT3018Y_BIT_TWO;
>>> +
>>> +        err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, fl=
ags);
>>> +        if (err < 0) {
>>> +            dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL.\n=
");
>>> +            return err;
>>> +        }
>>> +    }
>>> +
>>>    return err;
>>> }
>>>=20
>>> @@ -479,11 +513,17 @@ static int nct3018y_probe(struct i2c_client *clien=
t)
>>>        dev_dbg(&client->dev, "%s: NCT3018Y_BIT_TWO is set\n", __func__);=

>>>    }
>>>=20
>>> -    flags =3D NCT3018Y_BIT_TWO;
>>> -    err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags)=
;
>>> -    if (err < 0) {
>>> -        dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
>>> -        return err;
>>> +    nct3018y->part_num =3D i2c_smbus_read_byte_data(client, NCT3018Y_RE=
G_PART);
>>> +    if (nct3018y->part_num < 0) {
>>> +        dev_dbg(&client->dev, "Failed to read NCT3018Y_REG_PART.\n");
>>> +        return nct3018y->part_num;
>>> +    } else if (nct3018y->part_num & NCT3018Y_REG_PART_NCT3018Y) {
>>=20
>> This is a weird way to check as this will accept any value of
>> NCT3018Y_REG_PART as long as bit 1 is set, is this really what you want?
>>=20
>>> +        flags =3D NCT3018Y_BIT_HF;
>>> +        err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, fl=
ags);
>>> +        if (err < 0) {
>>> +            dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL.\n=
");
>>> +            return err;
>>> +        }
>>>    }
>>>=20
>>>    flags =3D 0;
>>> --=20
>>> 2.17.1
>>>=20
>>=20
>> --=20
>> Alexandre Belloni, co-owner and COO, Bootlin
>> Embedded Linux and Kernel engineering
>> https://bootlin.com
>=20
> --=20
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
