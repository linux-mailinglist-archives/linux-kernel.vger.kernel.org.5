Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C927E6A99
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjKIMbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjKIMbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:31:44 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA872B4;
        Thu,  9 Nov 2023 04:31:42 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6c32a20d5dbso772087b3a.1;
        Thu, 09 Nov 2023 04:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699533102; x=1700137902; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVI79wNia8uEnYAyEAtsqaroacqbg0p7sTHgGhpCjHg=;
        b=YQGmgWwCe3qJORl7yD0D88fP/Z3eYLIxRfVY3qvx0eXX3MKe3g55BCR3x8Bhv+FUpJ
         2ncq5iZgI2WIHUswh4vQj6/S4LbTy+gRXpN/Z2ZiGxVoHn9HwKAH7w9qT6SsNin2J4u6
         DYh4znx3xknGP+8aVfe0IUf9hxlo1hxzgyCYSXrO/gR2LCelSVM4HPS4xuwvuGSTnvc3
         Kxo+4hOntdswWdcSIuov38jZSJsvRycBwCXEn4+jxnkipJjNGyItoKkmT6hjNy+MPlHP
         RnumPw+9E7S4rJFcYpNceyfOu5n23hlVTinDrf2iVPoMTTaDAXnhVd3SSS9Zvz9Js9De
         fFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699533102; x=1700137902;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVI79wNia8uEnYAyEAtsqaroacqbg0p7sTHgGhpCjHg=;
        b=QMQCEiPJ3ZuB2Uk7R8vp/3v446HdzARn4eCqN1iutXTvGOARfPEih2qpBp9Hez4kdD
         DfvqeoxhEb92eyG0wQdNlj2PTdxJYruBDrMnR1U7yfaHhTknxK6nXn7pYf5di/WLL7rx
         lGTbliwFVroM76PEW3MunI7DCQBvpjtv0DXL2TRgbwBlPNmN0QMVwCtIRJI50jeXQnyh
         9+uT3gIgZ+OytIxPqLx23i8gIe4MdFB2hXVA7VVtBsE7ciB6925SO92YGakobCWI7w+D
         LyQPm2AZW2Ugr0r+QyYZwC8hoODsWghjdjYzx8KdV9x6RC5APmcrwUogOXL0DwDNJMpW
         MU2g==
X-Gm-Message-State: AOJu0Yyqw5H69PLEGNGFu7QjJ/wG4ZNi0o6e3xrLPvDc6E6b2wTHwXDW
        Rf9UroefoV/ABnD7SbEQaCU=
X-Google-Smtp-Source: AGHT+IGHj3o1rJdDVkhmH3dnpR+HkuNRcMg0FhHb9HaV4TtjOEsT5NiLy2NonrlIEAaz/+Y5oKXUlA==
X-Received: by 2002:a05:6a21:35c2:b0:153:39d9:56fe with SMTP id ba2-20020a056a2135c200b0015339d956femr5314450pzc.47.1699533102110;
        Thu, 09 Nov 2023 04:31:42 -0800 (PST)
Received: from smtpclient.apple ([2401:e180:8821:59e0:e5cc:8803:56b9:e782])
        by smtp.gmail.com with ESMTPSA id g13-20020a17090ae58d00b00263b9e75aecsm1206722pjz.41.2023.11.09.04.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 04:31:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Mining Lin <mimi05633@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 1/1] rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R
Date:   Thu, 9 Nov 2023 20:31:29 +0800
Message-Id: <960A21A8-532E-4F61-B0CB-ED2C27D640D8@gmail.com>
References: <20231103231639fd4b631c@mail.local>
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
        KFLIN@nuvoton.com, mylin1@nuvoton.com, openbmc@lists.ozlabs.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231103231639fd4b631c@mail.local>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
X-Mailer: iPhone Mail (20G81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Alexandre,

Thanks for your comments.
The replies are as follow.

Thanks.
Best regard,
Mia

Sent from my iPhone

> On Nov 4, 2023, at 7:16 AM, Alexandre Belloni <alexandre.belloni@bootlin.c=
om> wrote:
>=20
> =EF=BB=BFOn 13/09/2023 09:37:19+0800, Mia Lin wrote:
>> The NCT3015Y-R and NCT3018Y-R use the same datasheet
>>    but have different topologies as follows.
>> - Topology (Only 1st i2c can set TWO bit and HF bit)
>>  In NCT3015Y-R,
>>    rtc 1st i2c is connected to a host CPU
>>    rtc 2nd i2c is connected to a BMC
>>  In NCT3018Y-R,
>>    rtc 1st i2c is connected to a BMC
>>    rtc 2nd i2c is connected to a host CPU
>> In order to be compatible with NCT3015Y-R and NCT3018Y-R,
>> - In probe,
>>  If part number is NCT3018Y-R, only set HF bit to 24-Hour format.
>>  Else, do nothing
>> - In set_time,
>>  If part number is NCT3018Y-R && TWO bit is 0,
>>     change TWO bit to 1, and restore TWO bit after updating time.
>>=20
>> Signed-off-by: Mia Lin <mimi05633@gmail.com>
>> ---
>> drivers/rtc/rtc-nct3018y.c | 52 +++++++++++++++++++++++++++++++++-----
>> 1 file changed, 46 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
>> index ed4e606be8e5..b006b58e15e2 100644
>> --- a/drivers/rtc/rtc-nct3018y.c
>> +++ b/drivers/rtc/rtc-nct3018y.c
>> @@ -23,6 +23,7 @@
>> #define NCT3018Y_REG_CTRL    0x0A /* timer control */
>> #define NCT3018Y_REG_ST        0x0B /* status */
>> #define NCT3018Y_REG_CLKO    0x0C /* clock out */
>> +#define NCT3018Y_REG_PART    0x21 /* part info */
>>=20
>> #define NCT3018Y_BIT_AF        BIT(7)
>> #define NCT3018Y_BIT_ST        BIT(7)
>> @@ -37,10 +38,12 @@
>> #define NCT3018Y_REG_BAT_MASK        0x07
>> #define NCT3018Y_REG_CLKO_F_MASK    0x03 /* frequenc mask */
>> #define NCT3018Y_REG_CLKO_CKE        0x80 /* clock out enabled */
>> +#define NCT3018Y_REG_PART_NCT3018Y    0x02
>>=20
>> struct nct3018y {
>>    struct rtc_device *rtc;
>>    struct i2c_client *client;
>> +    int part_num;
>> #ifdef CONFIG_COMMON_CLK
>>    struct clk_hw clkout_hw;
>> #endif
>> @@ -177,8 +180,27 @@ static int nct3018y_rtc_read_time(struct device *dev=
, struct rtc_time *tm)
>> static int nct3018y_rtc_set_time(struct device *dev, struct rtc_time *tm)=

>> {
>>    struct i2c_client *client =3D to_i2c_client(dev);
>> +    struct nct3018y *nct3018y =3D dev_get_drvdata(dev);
>>    unsigned char buf[4] =3D {0};
>> -    int err;
>> +    int err, flags;
>> +    int restore_flags =3D 0;
>> +
>> +    flags =3D i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
>> +    if (flags < 0) {
>> +        dev_dbg(&client->dev, "Failed to read NCT3018Y_REG_CTRL.\n");
>> +        return flags;
>> +    }
>> +
>> +    /* Check and set TWO bit */
>> +    if ((nct3018y->part_num & NCT3018Y_REG_PART_NCT3018Y) && !(flags & N=
CT3018Y_BIT_TWO)) {
>> +        restore_flags =3D 1;
>> +        flags |=3D NCT3018Y_BIT_TWO;
>> +        err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, fla=
gs);
>> +        if (err < 0) {
>> +            dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL.\n"=
);
>> +            return err;
>> +        }
>> +    }
>>=20
>>    buf[0] =3D bin2bcd(tm->tm_sec);
>>    err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_SC, buf[0]);
>> @@ -212,6 +234,18 @@ static int nct3018y_rtc_set_time(struct device *dev,=
 struct rtc_time *tm)
>>        return -EIO;
>>    }
>>=20
>> +    /* Restore TWO bit */
>> +    if (restore_flags) {
>> +        if (nct3018y->part_num & NCT3018Y_REG_PART_NCT3018Y)
>> +            flags &=3D ~NCT3018Y_BIT_TWO;
>> +
>> +        err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, fla=
gs);
>> +        if (err < 0) {
>> +            dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL.\n"=
);
>> +            return err;
>> +        }
>> +    }
>> +
>>    return err;
>> }
>>=20
>> @@ -479,11 +513,17 @@ static int nct3018y_probe(struct i2c_client *client=
)
>>        dev_dbg(&client->dev, "%s: NCT3018Y_BIT_TWO is set\n", __func__);
>>    }
>>=20
>> -    flags =3D NCT3018Y_BIT_TWO;
>> -    err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);=

>> -    if (err < 0) {
>> -        dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
>> -        return err;
>> +    nct3018y->part_num =3D i2c_smbus_read_byte_data(client, NCT3018Y_REG=
_PART);
>> +    if (nct3018y->part_num < 0) {
>> +        dev_dbg(&client->dev, "Failed to read NCT3018Y_REG_PART.\n");
>> +        return nct3018y->part_num;
>> +    } else if (nct3018y->part_num & NCT3018Y_REG_PART_NCT3018Y) {
>=20
> This is a weird way to check as this will accept any value of
> NCT3018Y_REG_PART as long as bit 1 is set, is this really what you want?
=EF=BC=BBMia] Thanks for your comments. I=E2=80=99ll fix it.
>=20
>> +        flags =3D NCT3018Y_BIT_HF;
>> +        err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, fla=
gs);
>> +        if (err < 0) {
>> +            dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL.\n"=
);
>> +            return err;
>> +        }
>>    }
>>=20
>>    flags =3D 0;
>> --=20
>> 2.17.1
>>=20
>=20
> --=20
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
