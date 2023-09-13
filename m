Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F026D79F031
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjIMRRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjIMRQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:16:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26751BEB;
        Wed, 13 Sep 2023 10:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1694625368; x=1695230168; i=frank-w@public-files.de;
 bh=evIc2gXoJPFBYukv7WELvB3ulJHwz+QjiapUGFaCmOQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SSjnPg+IFLizfekyy/pircdzxR3Twhwr2m0CCwpyZdyYx/sJOv11KGqOacaZmu8UB55XnkI4/9G
 v1BRsLfa9HLjMkv8VURKHN5IRLPa+Cpik7HNFJYaX+SMt7m/pOEjD5lhP1oURrPfajvXypo5MtDoO
 DhzPPkHtXglikbZbYIcgy2K+Brscu5x5KUr1PdsBJ//5QBgGJtwrHveB5aCtq/2kG0T0kq0+9zz9+
 JQQ5FD8lDn+2AuxZSpQ+n2Xzab/zoj/8BrpZwjIxYbZHDHX5UBUFjzY5T7LFy6haSEfPKp+3SoZ1o
 Y4rDwl9Up+dOX0DNe9RqULPSSscJ2kF215vg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [80.245.75.211] ([80.245.75.211]) by web-mail.gmx.net
 (3c-app-gmx-bs38.server.lan [172.19.170.90]) (via HTTP); Wed, 13 Sep 2023
 19:16:08 +0200
MIME-Version: 1.0
Message-ID: <trinity-fc0082c7-cf37-4458-ac72-3c5774702f5d-1694625368681@3c-app-gmx-bs38>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
Subject: Aw: Re: [RFC v1 3/3] thermal/drivers/mediatek/lvts_thermal: add
 mt7988 support
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Sep 2023 19:16:08 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <f13a6648-cd21-a166-6e56-431ac7ee5dec@collabora.com>
References: <20230911183354.11487-1-linux@fw-web.de>
 <20230911183354.11487-4-linux@fw-web.de>
 <8949cbfa-acae-d6ac-e5fb-f238a29630bc@collabora.com>
 <465DDC1C-D687-47A7-966C-73FB42CFC5DD@public-files.de>
 <f13a6648-cd21-a166-6e56-431ac7ee5dec@collabora.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:XCCcgpHsS2Y3wu5iIC4BkTuhmHlxQgIRWvP5zTvcyL1FtYTHhHptUaVXa179NRMZF8jHN
 eQoXpU3YyBLrwiJg7iKH2kg+ax7eOvBMXKT1VfADC8ujkPV7q91ADnPy4I7CagKtDFjGUOsAV8Ni
 qolgsKY1DiMt9W6TKwmLkh8DlzlETQCqo+eQbmZ/3RT62YItMKtOB3sdLz09yYrwGl/ayHVXQq41
 z0dA8YqaTO/2t843H/kT6NHsIzTgWd6x8h08F3P6dXqktNNVa/5EuqWGAlsFJ7sTycEsNpSGvjUA
 2A=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:K5B52bMxsgA=;gJlo/Z2YmpnclOFV0Py4vULSfeh
 28t1YYyg1Uv9aA/EI++3uUcLX7WmKSIfJ+CntnkY4EqDwGAEt/riyea2/KqOUfzeyr9hjbe4K
 YJ6CBd19uMmPa+Q90Y5HZXhVSu0PQOvmIVm44BxgjD10b88VjZz7Vz5lGM7aFhEvPPJdGQzCe
 n0scd80+iqF0x07JDFW7gOQoE/Uuwtz9o2PEQcRxBh+kCS7444QSqxc7OfgtUM9umjJf0Gajt
 zsyTCBdM7YFBaPfiCM9xSVvG/tOw7Pn9CQIhyPNqN95FXrrREuJ91qxBkiChIRLke42I5AlNQ
 xCVQFKO4uAggxjpKq1dLCSxSsOVL6LXJZpxlvse/EaRGlAr76BW41WJzQYjRVGCrJoISDWghh
 GpW3InL08BoPSOH6Dii3bSiuzKr5Os6BMROo0oCIXIAE28F5XMVrHWuAYdRwFOZ6qkmDAIM/U
 nv9B4tBhvijFfJQG1FMur4ukrfvnt9luTanyl+MSjIzYXS/XTOuC5McLh65PbpqNePGHfaIaq
 i64Vyc9ecWdOcNqIevLf7ZldEy9mE2gMCwUAIgqWfqbbt5xkZVr4eI1L3s9EPQSNdA2cYHU7G
 uJb5s+QYPd3Yd1uzI5QwnZ52EpiHxvAXTwNt1UfWtEuFfoic/YN4wsGtbGJ+wCzvM0sNlcvTV
 SqwQGeFr4XIGeSEIesJR+kEB5Lrx0pg26m4gTulnpY2dVz75ZYwZ7tR6mDynVOubXwrcGMqOJ
 auwDhK4QffTgwDyxC6+4g7sZWZR5pzW+Kc3mssAzjuu2Xk2FBhDvola8VvqzdQ+ElYS+4dagk
 HQX4lyhuRLm47jFmqUez/nrw3T8aeglply38ddak7xk+E=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> Gesendet: Mittwoch, 13=2E September 2023 um 13:43 Uhr
> Von: "AngeloGioacchino Del Regno" <angelogioacchino=2Edelregno@collabora=
=2Ecom>
> An: frank-w@public-files=2Ede, "Frank Wunderlich" <linux@fw-web=2Ede>, l=
inux-mediatek@lists=2Einfradead=2Eorg
> Il 13/09/23 12:52, Frank Wunderlich ha scritto:
> > Am 13=2E September 2023 10:16:51 MESZ schrieb AngeloGioacchino Del Reg=
no <angelogioacchino=2Edelregno@collabora=2Ecom>:
> > Hi angelo,
> >=20
> > thanks for first look
> >=20
> >> Il 11/09/23 20:33, Frank Wunderlich ha scritto:
> >>> From: Frank Wunderlich <frank-w@public-files=2Ede>
> >>>
> >>> Add Support for mediatek fologic 880/MT7988=2E
> >>>
> >>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
> >>> ---
> >>>    drivers/thermal/mediatek/lvts_thermal=2Ec | 73 ++++++++++++++++++=
+++++++
> >>>    1 file changed, 73 insertions(+)
> >>>
> >>> diff --git a/drivers/thermal/mediatek/lvts_thermal=2Ec b/drivers/the=
rmal/mediatek/lvts_thermal=2Ec
> >>> index c1004b4da3b6=2E=2E48b257a3c80e 100644
> >>> --- a/drivers/thermal/mediatek/lvts_thermal=2Ec
> >>> +++ b/drivers/thermal/mediatek/lvts_thermal=2Ec
> >>> @@ -82,6 +82,8 @@
> >>>    #define LVTS_GOLDEN_TEMP_DEFAULT	50
> >>>    #define LVTS_COEFF_A_MT8195			-250460
> >>>    #define LVTS_COEFF_B_MT8195			250460
> >>> +#define LVTS_COEFF_A_MT7988			-204650
> >>> +#define LVTS_COEFF_B_MT7988			204650
> >>>      #define LVTS_MSR_IMMEDIATE_MODE		0
> >>>    #define LVTS_MSR_FILTERED_MODE		1
> >>> @@ -1272,6 +1274,67 @@ static int lvts_remove(struct platform_device=
 *pdev)
> >>>    	return 0;
> >>>    }
> >>>    +/*
> >>> + * LVTS MT7988
> >>> + */
> >>> +#define LVTS_HW_SHUTDOWN_MT7988	117000
> >>
> >> Are you sure that this chip's Tj is >117=C2=B0C ?!
> >>
> >> Looks a bit high=2E=2E=2E if it is exactly 117=C2=B0C, I would sugges=
t cutting earlier,
> >> either at 110 (safe side) or 115: after all, this is a life-saver fea=
ture and
> >> the chip is actually never meant to *constantly* work at 110=C2=B0C (=
as it would
> >> degrade fast and say goodbye earlier than "planned")=2E
> >=20
> > I took values from SDK
> >=20
> > https://git01=2Emediatek=2Ecom/plugins/gitiles/openwrt/feeds/mtk-openw=
rt-feeds/+/refs/heads/master/target/linux/mediatek/files-5=2E4/drivers/ther=
mal/mediatek/soc_temp_lvts=2Ec#1483
> >=20
>=20
> That kernel also defines 117=C2=B0C for MT8195, which leaves me a bit du=
bious=2E
>=20
> For safety, I would recommend using the same 105=C2=B0C hw shutdown temp=
erature
> for 7988 as well: after all if you think about it, reaching that kind of
> temperature means that there's a real problem (fan stopped working and/o=
r
> heatsink detached) that needs attention=2E

ack, will change to same value and put the define on top, abve the mt8195

> This is because you'll have trip points in devicetree that should thrott=
le
> the CPU in case it reaches at least a dangerously high temperature (read=
:
> a temperature outside the recommended continuous operation range), bring=
ing
> the temperatures down because of the throttling action; I would imagine
> throttling the CPU a bit down at 80=C2=B0C, then a bit more at 90=C2=B0C=
 - but then,
> if the temps won't drop like that, there's clearly a HW-related issue th=
at
> must be addressed (like the fan/heatsink scenario that I just described)=
=2E
>=20
> Though, take this as an advice; I'll respect whichever decision you'll t=
ake=2E
>=20
> >>> +//enum mt7988_lvts_domain { MT7988_AP_DOMAIN, MT7988_NUM_DOMAIN };
> >>> +
> >>> +enum mt7988_lvts_sensor_enum {
> >>> +	MT7988_TS3_0,
> >>> +	MT7988_TS3_1,
> >>> +	MT7988_TS3_2,
> >>> +	MT7988_TS3_3,
> >>> +	MT7988_TS4_0,
> >>> +	MT7988_TS4_1,
> >>> +	MT7988_TS4_2,
> >>> +	MT7988_TS4_3,
> >>> +	MT7988_NUM_TS
> >>> +};
> >=20
> >> This enumeration should be definitions in bindings (mediatek,lvts-the=
rmal=2Eh)=2E
> >>
> >> Besides, the LVTS is about internal temperatures, so those TS3_x and =
4_x can
> >> be renamed like what was done for MT8192 and MT8195: this is because =
you will
> >> never see TS3_2 being CPU2 on a board and CPU4 on another, being thos=
e - again -
> >> internal to the SoC, hence unchangeable=2E
> >=20
> > Right these sensors are internally only and i took naming from sdk to =
avoid confusion=2E And i have not more information about these internal sen=
sors (special meaning),but their values are packed together to get the resu=
lting (average) temperature=2E
> >=20
> >> Another reason is that you'll anyway have to refer to those sensors i=
n the
> >> devicetree to configure thermal trips and such, so=2E=2E=2E :-)
> >=20
> > In device tree it will look like this:
> >=20
> > https://github=2Ecom/frank-w/BPI-Router-Linux/blob/6=2E5-lvts/arch/arm=
64/boot/dts/mediatek/mt7988a=2Edtsi#L771
> >=20
> > Daniel has also defined thermal trips there,but these are untested atm=
=2E I only verified temperature itself i get from sysfs as far as i can (st=
art at ~40=C2=B0C and reaching ~70 while running)=2E
> >=20
>=20
> Check how it's done in mt8192=2Edtsi and mt8195=2Edtsi: we're using the =
definitions
> from the bindings for thermal zones=2E
> At least for consistency (apart from other even more valid consideration=
s), that's
> how it should be done: please do it like that=2E
>=20
> Besides, I think that you can definitely guess what `TS` is CPU related:=
 checking
> the driver and devicetree from the downstream kernel that you provided, =
what I
> understand is:
>=20
> 1=2E Your naming TS3,4 corresponds to TS2,3 downstream (so it's wrong?)
> 2=2E Downstream TS2 is related to the CPU cores, so it should be
>     - TS2_0 - CPU0
>     - TS2_1 - CPU1
>     - TS2_2 - CPU2
>     - TS2_3 - CPU3

i took the names from efuse names (which are listed as comment above), had=
 2/3 before=2E
need to ask mtk here=2E same for the second controller and if it is really=
 a "lvts-ap"=2E

> The other set of thermal sensors seem to be completely unused, so we can=
not guess
> just by looking at the code=2E Since you have the hardware, you may be a=
ble to take
> a position about what they are by checking what sensor heats up for each=
 "action"
> (could be ethernet controller or infra or whatever else); if in doubt, j=
ust leave
> them out, but add a comment saying that there are more sensors and say w=
here, so
> that if anyone finds what they're for, it'll be easy to add them=2E
>=20
> In any case, adding thermal sensors that you don't know about is meaning=
less, as
> the sense of all this is:
>   - Monitoring temperatures of the hardware
>   - Taking action to prevent temperature overrun
> but if you don't know what you're reading, you can't interpret temperatu=
res for
> something unknown, hence you can't as well take action to prevent overru=
ns, as
> you won't know what's the maximum temperature for "unknown thing" :-)

yes i have only the downstream kernel and some additional information like=
 interupt
number and the efuse offsets for calibration=2E And for the 8 sensors i ge=
t this information:

"8 sensors are distributed across the whole soc in order to get the correc=
t average temperature=2E
chip designer didn=E2=80=99t disclose more detailed info to us=2E"

so i thought all 8 sensors are taken into account with both controllers to=
 calculate 1
resulting temperature=2E In downstream i saw also only 1 controller in dts=
 and i have
only 1 interrupt=2E

https://git01=2Emediatek=2Ecom/plugins/gitiles/openwrt/feeds/mtk-openwrt-f=
eeds/+/refs/heads/master/target/linux/mediatek/files-5=2E4/arch/arm64/boot/=
dts/mediatek/mt7988=2Edtsi#579

and the compatible for both (mt7988 and mt8195) are without "ap" there, so=
 i took the same=2E

Where have you seen the mt7988-AP ?

i have only seen 1 sensor which should be the SOC itself and this chip has=
 metal surface
which makes it hard to get real temperature (infrared thermometer gives wr=
ong temp)=2E

> Regards,
> Angelo
