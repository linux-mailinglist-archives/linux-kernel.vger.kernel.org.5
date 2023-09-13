Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7A479E555
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbjIMKxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239774AbjIMKxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:53:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C3DCA;
        Wed, 13 Sep 2023 03:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1694602352; x=1695207152; i=frank-w@public-files.de;
 bh=Ww1mJyzDjTYs1kiuvu9JwKCRtrZkVm5UBxhogIXBc+M=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:References;
 b=WzdF8yJrs/LmwLwvwWapUB5NaH2xWmUy1M52B/iNsaeD2q5zcV6zNOmfnWhsVA1ZA9RlAlZ3JYQ
 z3F8QKOdLg7+i2Oo/Lk+sINpLPdCr4uCUGyyOR+n3cY18+of9adykfchPn5yfUSf+NJHvLZOmjIiU
 Z0TACC3mfNYUleKdA6GKZYjG46WWGdRC8j1DZC82jiQZmB45PUvxwx8DgXFixqsGziK/te8UdiDqC
 VMU+5dnr7TAX+/9mobCR5+c3b7idtGiLKkqQB17AySXSyIxayUfwaHAFjwQZA+qoeF9IJMzbdH9ID
 M3I+7TKUWVfdBbiHkiEDyGBXfAyVW2aNe/MQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [IPv6:::1] ([80.187.70.211]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTRMs-1rABOd48E8-00ThSc; Wed, 13
 Sep 2023 12:52:32 +0200
Date:   Wed, 13 Sep 2023 12:52:29 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_v1_3/3=5D_thermal/drivers/medi?= =?US-ASCII?Q?atek/lvts=5Fthermal=3A_add_mt7988_support?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <8949cbfa-acae-d6ac-e5fb-f238a29630bc@collabora.com>
References: <20230911183354.11487-1-linux@fw-web.de> <20230911183354.11487-4-linux@fw-web.de> <8949cbfa-acae-d6ac-e5fb-f238a29630bc@collabora.com>
Message-ID: <465DDC1C-D687-47A7-966C-73FB42CFC5DD@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L7b7/3vlJqiK9clXTp9802DVzVqAZMwttJN+9iGUAhZZHaV6OSy
 7BUGp6yda4GZj2iMqEKvvkANIvXYPg/3GXzBV4HlsNsolYPL9Rt+Oj6QpV34eHcokVbGPVR
 WkdkNpi4XJqLdEg1Ji4nt5Usejxyel6vID/utZYR07ZfN46yVCcudjvckPDbrHrclPP7OMh
 0q7BYXIqsNYn1T8+ATojg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j6FRPAxwTHg=;WJHkeOXGVVFss1sYZOexXfgn3f5
 bo9Opg/eegbc+RzJsn5Bx1hdWmURIo/tgZ2w6It2i9uY8xP3iBOdcAOMnb0nU02Jpa3z07FQ2
 WeuZ1w7JTNLPOrT9CN0nwxB+EtwFPrOEUjp6/OQLpSzXKDf5E0bZOYTIKidz4/lSmrFXjfzrF
 dqUTFnN/QeXAftgepoPE8fOZ1A3B8CsFeRcqkNSoJLR9mj7dmM78fWJJeuui2L1lZaCZn7Hb+
 LMYg7kr9n0KI2vRAQarI55AoP3RK2ESXg63sJz5369S/H0wUfG64/MwK+XoYOMYH82k1IohtL
 EPvVR/PdmWR5oHk5H2lvCTFaFRwHmHUse7CxvPPvrng3qTi+hkTiCa7HXibsJaffQ/SM61E0g
 rkl6Bao9Rvc1V3EKX0fNRixJ3BdgIkQ5GyTDKDua+WC49Rd4HKf452DrEfnpVqQU/yGzHQGuX
 qo2RiYyqj6F+2m/avrVmCBhJTPhFpz2ifFIIqH4sgkJdSzEAmG2RFzylDXM0D/u9eu7aOpB9d
 1RkNE2tkrQlLpmLOwSc48B++qgbsyK/otMXVFSS+GH9Ne2Cj8MIuV8l2ESCrt0o37AJagjemr
 iVzfeEjoTu+ivR6fC6rC/S2AV6VU9gP5DP3zn/iIgPfwo7UjjOi2Y80fg2V/62dYkQCKDTArL
 VQL2c59QDvJX3j+euvbk5cYzYs9TPMaWNI2wCkpWkjLQLTJPVsutO+GoslLf+EC1Zg6ed06vc
 0KJ5/91BKp2yfsFSDkFfxSS2fodeTuuvtJ9t0EY9+MzIqC++K2LtLFtgAb0xQfNum/Irf+qED
 kWt0lMBnzGRWZR3MmPK5/jBFFWVXcNYNdUhL0dU+3EKJRh+NoyAFN31OTQnmZbEPow8m7sgVF
 j+Vu+qMdSAapjxtMfdnoLevEfA51qh40yzN30iOKo0Oz918eRi1KlXdyrNeNHQM0/pu4wvb+m
 K/TaaQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 13=2E September 2023 10:16:51 MESZ schrieb AngeloGioacchino Del Regno <a=
ngelogioacchino=2Edelregno@collabora=2Ecom>:
Hi angelo,

thanks for first look

>Il 11/09/23 20:33, Frank Wunderlich ha scritto:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> Add Support for mediatek fologic 880/MT7988=2E
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> ---
>>   drivers/thermal/mediatek/lvts_thermal=2Ec | 73 ++++++++++++++++++++++=
+++
>>   1 file changed, 73 insertions(+)
>>=20
>> diff --git a/drivers/thermal/mediatek/lvts_thermal=2Ec b/drivers/therma=
l/mediatek/lvts_thermal=2Ec
>> index c1004b4da3b6=2E=2E48b257a3c80e 100644
>> --- a/drivers/thermal/mediatek/lvts_thermal=2Ec
>> +++ b/drivers/thermal/mediatek/lvts_thermal=2Ec
>> @@ -82,6 +82,8 @@
>>   #define LVTS_GOLDEN_TEMP_DEFAULT	50
>>   #define LVTS_COEFF_A_MT8195			-250460
>>   #define LVTS_COEFF_B_MT8195			250460
>> +#define LVTS_COEFF_A_MT7988			-204650
>> +#define LVTS_COEFF_B_MT7988			204650
>>     #define LVTS_MSR_IMMEDIATE_MODE		0
>>   #define LVTS_MSR_FILTERED_MODE		1
>> @@ -1272,6 +1274,67 @@ static int lvts_remove(struct platform_device *p=
dev)
>>   	return 0;
>>   }
>>   +/*
>> + * LVTS MT7988
>> + */
>> +#define LVTS_HW_SHUTDOWN_MT7988	117000
>
>Are you sure that this chip's Tj is >117=C2=B0C ?!
>
>Looks a bit high=2E=2E=2E if it is exactly 117=C2=B0C, I would suggest cu=
tting earlier,
>either at 110 (safe side) or 115: after all, this is a life-saver feature=
 and
>the chip is actually never meant to *constantly* work at 110=C2=B0C (as i=
t would
>degrade fast and say goodbye earlier than "planned")=2E

I took values from SDK

https://git01=2Emediatek=2Ecom/plugins/gitiles/openwrt/feeds/mtk-openwrt-f=
eeds/+/refs/heads/master/target/linux/mediatek/files-5=2E4/drivers/thermal/=
mediatek/soc_temp_lvts=2Ec#1483

>> +//enum mt7988_lvts_domain { MT7988_AP_DOMAIN, MT7988_NUM_DOMAIN };
>> +
>> +enum mt7988_lvts_sensor_enum {
>> +	MT7988_TS3_0,
>> +	MT7988_TS3_1,
>> +	MT7988_TS3_2,
>> +	MT7988_TS3_3,
>> +	MT7988_TS4_0,
>> +	MT7988_TS4_1,
>> +	MT7988_TS4_2,
>> +	MT7988_TS4_3,
>> +	MT7988_NUM_TS
>> +};

>This enumeration should be definitions in bindings (mediatek,lvts-thermal=
=2Eh)=2E
>
>Besides, the LVTS is about internal temperatures, so those TS3_x and 4_x =
can
>be renamed like what was done for MT8192 and MT8195: this is because you =
will
>never see TS3_2 being CPU2 on a board and CPU4 on another, being those - =
again -
>internal to the SoC, hence unchangeable=2E

Right these sensors are internally only and i took naming from sdk to avoi=
d confusion=2E And i have not more information about these internal sensors=
 (special meaning),but their values are packed together to get the resultin=
g (average) temperature=2E

>Another reason is that you'll anyway have to refer to those sensors in th=
e
>devicetree to configure thermal trips and such, so=2E=2E=2E :-)

In device tree it will look like this:

https://github=2Ecom/frank-w/BPI-Router-Linux/blob/6=2E5-lvts/arch/arm64/b=
oot/dts/mediatek/mt7988a=2Edtsi#L771

Daniel has also defined thermal trips there,but these are untested atm=2E =
I only verified temperature itself i get from sysfs as far as i can (start =
at ~40=C2=B0C and reaching ~70 while running)=2E

>Regards,
>Angelo

regards Frank
