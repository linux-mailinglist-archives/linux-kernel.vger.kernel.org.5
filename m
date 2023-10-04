Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D1F7B7F7E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242411AbjJDMnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbjJDMnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:43:01 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526D193;
        Wed,  4 Oct 2023 05:42:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696423368; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bIIs/wQ662AGCMQ60bRN/Bq5J6nEwQHOBLka3URcQVRdnncc40qzpOaDOHIPNiSTPC
    9GDVNVT4M4aURTdiYhv7s9BRg7sOvEIe+QfV0exqErVN6Eybv0MKB/aVS8H8cyy+JBFY
    kWMZ6x0PyI93sQzyduewHLTRa9q0623xtGbuxQMREbR4QMAYtmcmfUH47Z/23ZVsaSmL
    3sTD6CmoGE0uHgwA1c8CVJMjuxmqGUY5bUWGA/wGUF5chytVSq9yNipkWaxRJMJ7sHrR
    9KY4VbhXfUpCVEoLO1iPkddvkkBzUw+otoFQO/jXGA/0zRyuU4oHrc/LHDIPShnmT7lx
    EDAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696423368;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=1tOW5l3WTyj5E5hPy7McNdTfJh1oCo+gm00ZLJ7Z+6Q=;
    b=cPEaat+lHijQ7wiL2bRXuNazWrinDZ7euMR+r7nvAew8ppP8JyzAixHh0V08N144Sn
    mADP/ZEEGfWWYPTJc2MsowgnZr5fIATGvHn7JkxcFq449Yg0cxvFi+SUsckS5FakSaYe
    SdYOshvIDYr+i+iYZWOi7+HUYPtRHHUO/nv1KlmvKnir1B4Zb3cyrmnXLG1VJRnS+Tm7
    qNL6HZvPK4CKV9Z69Qtqk4rPYjAFTZIgnl8lqkQyvCDIZ4ZTHFVzU4Mpn9o+zRiBO1JB
    3OLnQZjuUspdAPyTdSgSiN5fD0+BqYdT1ucJtm4zQ/vrwZId+c9hAqmmjFoiabqtAAKU
    IGjQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696423368;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=1tOW5l3WTyj5E5hPy7McNdTfJh1oCo+gm00ZLJ7Z+6Q=;
    b=dpX5Wl1MfnYvKmZPaj36LN1USilkJ+F9xK6SRDM8T9IKpFZn/m8btLFR0pJdOud2U6
    IJoI5hUrhm5VeN/IgslhCXU2njeHUk5pvh8KnBWrAOf8+gXleWS6XShQKE63boAqcmFY
    1xA7sqvpBue5APx0Q1s612JR5/pZIXJ232jotcVcrcpjow3viQZJcp/42zctM9Yzjn8P
    XXivX2wLBWbKuVI2D0+9wxdMVqIEcaqyUNDKJBun1A3i8NySVMqf4bM/zYCJqB/PeQBy
    pYdiC+OyWD2hog3q4HGOypUdYLZIyrE5ECjL1QbERtABt8CThVGZ2awmMusGP+eDw7l3
    1Snw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696423368;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=1tOW5l3WTyj5E5hPy7McNdTfJh1oCo+gm00ZLJ7Z+6Q=;
    b=CpNKpbhUOLbMZaCx7RZB97Q3iX71jZDxh1Qs8h4lIZJyemrCmK/lga3XQWcByb/2SN
    UCEfDPR+YmQvkmsF1zDQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGeo3Q="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id Y04dd7z94CgljPp
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Wed, 4 Oct 2023 14:42:47 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] ARM: dts: omap3-gta04: Drop superfluous omap36xx
 compatible
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20231004135449.591b3f6c@aktux>
Date:   Wed, 4 Oct 2023 14:42:47 +0200
Cc:     bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <42806B60-E48B-4AA9-B375-E9F65F59AB87@goldelico.com>
References: <20231004065323.2408615-1-andreas@kemnade.info>
 <12323F42-3611-4685-8981-F6A18C4A5862@goldelico.com>
 <20231004130353.01228376@aktux>
 <FF3A3F35-E264-4D28-AFAC-EFA2ADB69F40@goldelico.com>
 <20231004135449.591b3f6c@aktux>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 04.10.2023 um 13:54 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> On Wed, 4 Oct 2023 13:39:03 +0200
> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>=20
>>> Am 04.10.2023 um 13:03 schrieb Andreas Kemnade =
<andreas@kemnade.info>:
>>>=20
>>> On Wed, 4 Oct 2023 12:50:16 +0200
>>> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>>>=20
>>>> Hi Andreas,
>>>>=20
>>>>> Am 04.10.2023 um 08:53 schrieb Andreas Kemnade =
<andreas@kemnade.info>:
>>>>>=20
>>>>> Drop omap36xx compatible as done in other omap3630 devices.
>>>>> This has apparently fallen through the lattice.
>>>>>=20
>>>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>>>> ---
>>>>> arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi | 2 +-
>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>=20
>>>>> diff --git a/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi =
b/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
>>>>> index b6b27e93857f..3661340009e7 100644
>>>>> --- a/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
>>>>> +++ b/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
>>>>> @@ -11,7 +11,7 @@
>>>>>=20
>>>>> / {
>>>>> 	model =3D "OMAP3 GTA04";
>>>>> -	compatible =3D "goldelico,gta04", "ti,omap3630", "ti,omap36xx", =
"ti,omap3";   =20
>>>>=20
>>>> there seem to be some more references to ti,omap36xx:
>>>>=20
>>>> arch/arm/boot/dts/ti/omap/omap3-lilly-a83x.dtsi:	compatible =3D =
"incostartec,omap3-lilly-a83x", "ti,omap3630", "ti,omap36xx", =
"ti,omap3"; =20
>>>=20
>>> apperently all the dtsi are fallen through the lattice when handling =
the dts.
>>>=20
>>>=20
>>>> arch/arm/mach-omap2/board-generic.c:	"ti,omap36xx",
>>>> drivers/clk/ti/dpll.c:	     =
of_machine_is_compatible("ti,omap36xx")) &&
>>>> drivers/cpufreq/ti-cpufreq.c:	{ .compatible =3D "ti,omap36xx", =
.data =3D &omap36xx_soc_data, },
>>>>=20
>>>> So are you sure that we can remove it without replacement or code =
fixes in dpll and cpufreq (board-generic is probably no issue)?
>>>>=20
>>> see discussion of:
>>>=20
>>> commit e341f338180c84cd98af3016cf5bcfde45a041fb
>>> Author: Andrew Davis <afd@ti.com>
>>> Date:   Thu Feb 16 09:33:38 2023 -0600
>>>=20
>>>   ARM: dts: omap: Drop ti,omap36xx compatible =20
>>=20
>> Ah, I wasn't aware of this.
>>=20
>>>=20
>>> all the places also basically check for omap36xx || omap3630. =20
>>=20
>>=20
>> Yes, I have checked but drivers/cpufreq/ti-cpufreq.c seems to be an
>> exception (unless I am missing some other patch).
>>=20
> No:
>        { .compatible =3D "ti,omap36xx", .data =3D &omap36xx_soc_data, =
},
>        { .compatible =3D "ti,omap3630", .data =3D &omap36xx_soc_data, =
},

Well, in v6.6-rc4 I see:

static const struct of_device_id ti_cpufreq_of_match[] =3D {
	{ .compatible =3D "ti,am33xx", .data =3D &am3x_soc_data, },
	{ .compatible =3D "ti,am3517", .data =3D &am3517_soc_data, },
	{ .compatible =3D "ti,am43", .data =3D &am4x_soc_data, },
	{ .compatible =3D "ti,dra7", .data =3D &dra7_soc_data },
	{ .compatible =3D "ti,omap34xx", .data =3D &omap34xx_soc_data, =
},
	{ .compatible =3D "ti,omap36xx", .data =3D &omap36xx_soc_data, =
},
	{ .compatible =3D "ti,am625", .data =3D &am625_soc_data, },
	{ .compatible =3D "ti,am62a7", .data =3D &am625_soc_data, },
	/* legacy */
	{ .compatible =3D "ti,omap3430", .data =3D &omap34xx_soc_data, =
},
	{ .compatible =3D "ti,omap3630", .data =3D &omap36xx_soc_data, =
},
	{},
};

Either the "/* legacy */" or the "ti,omap36xx" seems as if it should be =
removed.
But it seems to break the systematic approach of this table.

> The bindings also only specify omap3630.

What I think is that the background was (before bindings documentation
was invented) that there are drivers covering all variants of omap36xx
(incl. am37xx and dm37xx) and some parts specific to a single version.

So maybe it could have been missing in the bindings?

Anyways it seems to need some cleanup to remove all references to=20
omap36xx before it is forgotten...

BR,
Nikolaus=
