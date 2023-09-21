Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B790F7A9940
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjIUSMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjIUSLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:11:45 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0438ED4E;
        Thu, 21 Sep 2023 10:45:04 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout1.routing.net (Postfix) with ESMTP id DC5833FEB1;
        Thu, 21 Sep 2023 10:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1695292753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U8lPL8gvRmnaEpf/huc7WVV80bv+l3yEM1F4525ShH0=;
        b=HR7j7WZApj9VbwW3iPBKrTXmBVeJ1d6mFTiD+TlsJUUfllL5FfZrO+5OlG2OGPo8PYmMuU
        RCPhmFpyYItcvwOHjGwob9LgGN08GTzIgidO9nVKXXmbzjdMHdgaveL80nad8EGpQ/51aP
        KcCyRxFyMMw79W873zXLOfafao2TFDE=
Received: from [127.0.0.1] (fttx-pool-217.61.144.184.bambit.de [217.61.144.184])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id EED6C360630;
        Thu, 21 Sep 2023 10:39:11 +0000 (UTC)
Date:   Thu, 21 Sep 2023 12:39:11 +0200
From:   Frank Wunderlich <linux@fw-web.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
CC:     Frank Wunderlich <frank-w@public-files.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_4/4=5D_thermal/drivers/med?= =?US-ASCII?Q?iatek/lvts=5Fthermal=3A_add_mt7988_support?=
User-Agent: K-9 Mail for Android
In-Reply-To: <eb6cc1dd-1df9-3b68-1f72-d536189c7b4d@collabora.com>
References: <20230920175001.47563-1-linux@fw-web.de> <20230920175001.47563-5-linux@fw-web.de> <eb6cc1dd-1df9-3b68-1f72-d536189c7b4d@collabora.com>
Message-ID: <F68F7C77-BB1E-4D9F-B760-9B35DE3693C5@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: 72196824-0e00-40ec-b699-70d3d8de6d29
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21=2E September 2023 09:54:35 MESZ schrieb AngeloGioacchino Del Regno <a=
ngelogioacchino=2Edelregno@collabora=2Ecom>:
>Il 20/09/23 19:50, Frank Wunderlich ha scritto:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
=20
>> diff --git a/drivers/thermal/mediatek/lvts_thermal=2Ec b/drivers/therma=
l/mediatek/lvts_thermal=2Ec
>> index c2669f405a94=2E=2E8fd1dc5adb16 100644
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
>> @@ -89,6 +91,7 @@
>>   #define LVTS_MSR_READ_TIMEOUT_US	400
>>   #define LVTS_MSR_READ_WAIT_US		(LVTS_MSR_READ_TIMEOUT_US / 2)
>>   +#define LVTS_HW_SHUTDOWN_MT7988		105000
>
>I would simply reuse the definition of LVTS_HW_SHUTDOWN_MT8195=2E=2E=2E=
=2E

Hi angelo,
thanks for review=2E

Imho it should be separated=2E=2E=2Eif someone thinks it needs to be chang=
ed later it will be changed not only for mt8195=2E=2E=2Ea generic name can =
also cause problems if the next soc has different value=2E

>>   #define LVTS_HW_SHUTDOWN_MT8195		105000
>>     #define LVTS_MINIMUM_THRESHOLD		20000
>> @@ -1269,6 +1272,41 @@ static int lvts_remove(struct platform_device *p=
dev)
>>   	return 0;
>>   }
>>   +/*
>> + * LVTS MT7988
>> + */
>> +
>
>Please remove this big comment block, that's not needed=2E

Ok,i drop the comments (maybe except the wed one where the name in technic=
al document (i used for constants) does not point to wed function=2E

>> +static const struct lvts_ctrl_data mt7988_lvts_ap_data_ctrl[] =3D {
>> +	{
>> +		=2Ecal_offset =3D { 0x00, 0x04, 0x08, 0x0c }, //918,91C,920,924
>
>This 918,91c,etc comment is not necessary
>
>> +		=2Elvts_sensor =3D {
>> +			{ =2Edt_id =3D MT7988_CPU_0 }, // CPU 0,1
>
>If you want to retain those comments, you shall use the right style=2E
>
>{ =2Edt_id =3D MT7988_CPU_0 }, /* CPU 0,1 */
>{ =2E=2E } /* CPU 2,3 */
>{ =2E=2E } /* Internal 2=2E5G PHY 1 */
>
>etc
>
>> +			{ =2Edt_id =3D MT7988_CPU_1 }, // CPU 2,3
>> +			{ =2Edt_id =3D MT7988_ETH2P5G_0 }, // internal 2=2E5G Phy 1
>> +			{ =2Edt_id =3D MT7988_ETH2P5G_1 }  // internal 2=2E5G Phy 2
>> +		},
>> +		=2Enum_lvts_sensor =3D 4,
>> +		=2Eoffset =3D 0x0,
>> +		=2Ehw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT7988,
>> +	},
>> +	{
>> +		=2Ecal_offset =3D { 0x14, 0x18, 0x1c, 0x20 }, //92C,930,934,938
>
>comment not needed
>
>> +		=2Elvts_sensor =3D {
>> +			{ =2Edt_id =3D MT7988_TOPS_0}, // TOPS > +			{ =2Edt_id =3D MT7988_=
TOPS_1}, // TOPS
>
>The dt_id definition already says "TOPS", this comment is not needed=2E
>
>> +			{ =2Edt_id =3D MT7988_ETHWARP_0}, // WED 1
>> +			{ =2Edt_id =3D MT7988_ETHWARP_1}  // WED 2
>
>Same comment about the format; /* WED 1 */
>
>> +		},
>> +		=2Enum_lvts_sensor =3D 4,
>> +		=2Eoffset =3D 0x100,
>> +		=2Ehw_tshut_temp =3D LVTS_HW_SHUTDOWN_MT7988,
>> +	}
>> +};
>> +
>> +/*
>> + * LVTS MT8195
>> + */
>
>Please also remove this big comment block, it's not needed=2E
>
>Apart from that, this patch looks good; v3 will be the golden one :-)
>
>Cheers,
>Angelo
>

regards Frank
