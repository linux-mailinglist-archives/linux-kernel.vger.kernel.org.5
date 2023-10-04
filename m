Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D477B7FC4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242491AbjJDMuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242506AbjJDMuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:50:44 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742C9A6;
        Wed,  4 Oct 2023 05:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696423831; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=G/+Y78j+TnQSG034HncO/+EMPJEyanQsdIXLcYPxTkb+xZjEPKlBcGvdYKRHXlS3pb
    1LH24Xg5P8ZnL5U1ggkySAx5PbsJ1aTiFY9mppJ1Vc57ZIEtIYlnZIsdtXFAerG5SPGz
    +FRWTp/hviKLv1UpciOQxAlV5p3GxjaW3uTFtqu2VMFDC0YA/JzHHT0rC/zUo6YW/AzD
    Kg7n4ykrkBjcbu27b/XEceUbT2shYtOKGzPob046IU02ZwxFtYgkrcO5vIdkvIUCGbzv
    EOxrTeHOk0f9T1bidLh7A1KtdIVQUYhP/6jijn/AdDesYQ8mKTm855O9Wr0euU0e4Hw8
    dhvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696423831;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=4w3ts48X7eZ6ydMiR/OMyQRliO+hTozCQIcKRpSezrU=;
    b=BZ+SLxrej5baOZeZE2tHezC2T29dMkwHKx0rvc/O7pI+ZzL7hea97NWTy4fGJ0sIHf
    7Qfe586t38AcE53fLxPVY3V7YyvgpzuwrLP3LrVGCEpPP9KhKAD8Ss6fvaa/p/dBEp+/
    RUvzX0RQHls5jVdwYhhTTN9wfZzl/42Z0RoBMHaLU84OKoTd/Yan4EgQehuaeLGrxNZs
    sQJcvdLQeBpdFjE4Nh1WXj9l7wOsBxyR2ZwbJka661ybxVBfWddSjX4iA4rYv/A/1EEW
    4MMazbVad1F2DpVrZgAy/gItsAWEAzlEq9eOiIFsC8T4zIqcFMteB7LtyamgapmgzPw3
    /F5w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696423831;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=4w3ts48X7eZ6ydMiR/OMyQRliO+hTozCQIcKRpSezrU=;
    b=peRdb80hI0aDXh5TdtDwv4pKBwHxyypLfekPGJfQJXLq4ptcDyqt0pkIR3En0gsAbU
    vpwY68bJVrhxEGt6495hRzAfu2GirMadczN8SdhoravCBimm7TEC+Jvnh11VuNC6LjXu
    sazTeUkoHrFt+0gGg9IfGUTT1SfuezMxbKUOcjfao+yiU55vzIGOToyEHiBpCqqeZPNz
    EOj1FDqzoFOxofGbWAN1hBfADz0/DFOEJ1YPm0FpvKABLaB+WffPhTWmh25pvzKlEHC9
    oqnxv272hNYjz0tG6AI7PXzaCZjXTYgImirVZh9A7hLmRKLm0fHKpW0umS49dtkpU0ks
    5j8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696423831;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=4w3ts48X7eZ6ydMiR/OMyQRliO+hTozCQIcKRpSezrU=;
    b=5/8JS2gcmNbwBITHRNrbB5vH8gYKHKhW6Opez0C5nVkrIz05A+WjpettRsSfo8Y5Sz
    rxpTAbArt5cecvEkaFAw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGeo3Q="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id Y04dd7z94CoVjSY
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Wed, 4 Oct 2023 14:50:31 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] ARM: dts: omap3-gta04: Drop superfluous omap36xx
 compatible
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <42806B60-E48B-4AA9-B375-E9F65F59AB87@goldelico.com>
Date:   Wed, 4 Oct 2023 14:50:30 +0200
Cc:     bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B245439-F9FE-4931-A0DE-81F825BB5FE5@goldelico.com>
References: <20231004065323.2408615-1-andreas@kemnade.info>
 <12323F42-3611-4685-8981-F6A18C4A5862@goldelico.com>
 <20231004130353.01228376@aktux>
 <FF3A3F35-E264-4D28-AFAC-EFA2ADB69F40@goldelico.com>
 <20231004135449.591b3f6c@aktux>
 <42806B60-E48B-4AA9-B375-E9F65F59AB87@goldelico.com>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 04.10.2023 um 14:42 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
>=20
>=20
>> Am 04.10.2023 um 13:54 schrieb Andreas Kemnade =
<andreas@kemnade.info>:
>>=20
>> On Wed, 4 Oct 2023 13:39:03 +0200
>> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>>=20
>>>> Am 04.10.2023 um 13:03 schrieb Andreas Kemnade =
<andreas@kemnade.info>:
>>>>=20
>>>> On Wed, 4 Oct 2023 12:50:16 +0200
>>>> "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
>>>>=20
>>>>> Hi Andreas,
>>>>>=20
>>>>>> Am 04.10.2023 um 08:53 schrieb Andreas Kemnade =
<andreas@kemnade.info>:
>>>>>>=20
>>>>>> Drop omap36xx compatible as done in other omap3630 devices.
>>>>>> This has apparently fallen through the lattice.
>>>>>>=20
>>>>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>>>>> ---
>>>>>> arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi | 2 +-
>>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>=20
>>>>>> diff --git a/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi =
b/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
>>>>>> index b6b27e93857f..3661340009e7 100644
>>>>>> --- a/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
>>>>>> +++ b/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
>>>>>> @@ -11,7 +11,7 @@
>>>>>>=20
>>>>>> / {
>>>>>> 	model =3D "OMAP3 GTA04";
>>>>>> -	compatible =3D "goldelico,gta04", "ti,omap3630", =
"ti,omap36xx", "ti,omap3";   =20
>>>>>=20
>>>>> there seem to be some more references to ti,omap36xx:
>>>>>=20
>>>>> arch/arm/boot/dts/ti/omap/omap3-lilly-a83x.dtsi:	compatible =3D =
"incostartec,omap3-lilly-a83x", "ti,omap3630", "ti,omap36xx", =
"ti,omap3"; =20
>>>>=20
>>>> apperently all the dtsi are fallen through the lattice when =
handling the dts.
>>>>=20
>>>>=20
>>>>> arch/arm/mach-omap2/board-generic.c:	"ti,omap36xx",
>>>>> drivers/clk/ti/dpll.c:	     =
of_machine_is_compatible("ti,omap36xx")) &&
>>>>> drivers/cpufreq/ti-cpufreq.c:	{ .compatible =3D "ti,omap36xx", =
.data =3D &omap36xx_soc_data, },
>>>>>=20
>>>>> So are you sure that we can remove it without replacement or code =
fixes in dpll and cpufreq (board-generic is probably no issue)?
>>>>>=20
>>>> see discussion of:
>>>>=20
>>>> commit e341f338180c84cd98af3016cf5bcfde45a041fb
>>>> Author: Andrew Davis <afd@ti.com>
>>>> Date:   Thu Feb 16 09:33:38 2023 -0600
>>>>=20
>>>>  ARM: dts: omap: Drop ti,omap36xx compatible =20
>>>=20
>>> Ah, I wasn't aware of this.
>>>=20
>>>>=20
>>>> all the places also basically check for omap36xx || omap3630. =20
>>>=20
>>>=20
>>> Yes, I have checked but drivers/cpufreq/ti-cpufreq.c seems to be an
>>> exception (unless I am missing some other patch).
>>>=20
>> No:
>>       { .compatible =3D "ti,omap36xx", .data =3D &omap36xx_soc_data, =
},
>>       { .compatible =3D "ti,omap3630", .data =3D &omap36xx_soc_data, =
},
>=20
> Well, in v6.6-rc4 I see:
>=20
> static const struct of_device_id ti_cpufreq_of_match[] =3D {
> 	{ .compatible =3D "ti,am33xx", .data =3D &am3x_soc_data, },
> 	{ .compatible =3D "ti,am3517", .data =3D &am3517_soc_data, },
> 	{ .compatible =3D "ti,am43", .data =3D &am4x_soc_data, },
> 	{ .compatible =3D "ti,dra7", .data =3D &dra7_soc_data },
> 	{ .compatible =3D "ti,omap34xx", .data =3D &omap34xx_soc_data, =
},
> 	{ .compatible =3D "ti,omap36xx", .data =3D &omap36xx_soc_data, =
},
> 	{ .compatible =3D "ti,am625", .data =3D &am625_soc_data, },
> 	{ .compatible =3D "ti,am62a7", .data =3D &am625_soc_data, },
> 	/* legacy */
> 	{ .compatible =3D "ti,omap3430", .data =3D &omap34xx_soc_data, =
},
> 	{ .compatible =3D "ti,omap3630", .data =3D &omap36xx_soc_data, =
},
> 	{},
> };
>=20
> Either the "/* legacy */" or the "ti,omap36xx" seems as if it should =
be removed.
> But it seems to break the systematic approach of this table.
>=20
>> The bindings also only specify omap3630.
>=20
> What I think is that the background was (before bindings documentation
> was invented) that there are drivers covering all variants of omap36xx
> (incl. am37xx and dm37xx) and some parts specific to a single version.

Ah, there is indeed an issue with removing omap36xx and replacing by
omap3630.

What about the PVR/SGX driver. This needs a compatible that can =
distinguish
between the DM3725 and DM3730. The first is w/o SGX and the second one
with. Having all summarized as omap3630 does not allow to load the
PVR/SGX driver based on the board specific compatible entry.

AFAIR this was the original idea behind=20

	compatible =3D "goldelico,gta04", "ti,omap3630", "ti,omap36xx", =
"ti,omap3";=20

Only with this we can make the SGX driver depend on "ti,omap3630" and =
all
other general omap36xx stuff on "ti,omap36xx".

So it seems as if there was a reason to have both, and the omap36xx is =
not
completely superflous to be dropped.

BR,
Nikolaus

