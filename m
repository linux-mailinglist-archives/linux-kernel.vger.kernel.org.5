Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D767D807D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjJZKQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjJZKQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:16:58 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC65195;
        Thu, 26 Oct 2023 03:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698315415; x=1729851415;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gTmCLlZoeAzh4g2ZWLNk/zQv0qksTIaESyHkdzJDiNg=;
  b=nTU1J4F1JhiJqa20gq2qDNB0AbjQ9YULXG5V+r3wEIIVl3/GciBusPlv
   XWd8k34Tw61P+P4wksw+oLQZspWwya29UUPQHryEtKSL9zoo6DMh5SkyP
   qZHwxhhDyV/AVsauVdrFBlxlPHO1ak/JsGV2FuwLoSg7Ck5gD17l44KN1
   S+yHNzKEXiTl/Uo7TTMSLwsdbcNv17tM0y9xFunLiGmiFJuCQNZbfuTZQ
   oCfR6nsHPQlASyhBp/Vg8teaVRtShM5vgiANwQa/Wbd0ydHFMWYsMfY2T
   ONI9x/fB7TDs7OIXHMxDVkoeI5+Sg+qQzNlP2Rvc/If2IT3qA2txaORlH
   w==;
X-CSE-ConnectionGUID: D4/hySeORuGAwYH3yHxr2w==
X-CSE-MsgGUID: HI2cfzcsS1ePBqFwuROswQ==
X-IronPort-AV: E=Sophos;i="6.03,253,1694707200"; 
   d="scan'208";a="682530"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2023 18:16:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3PyHnYleMT6aLI3fGaXbddsm+O/920fF1cM09Fu5sctRxDhP/U3N40aQaHoM9bioQ7n9lwob2JJ3bal/+hGvm45teF62izOFoG12v2RTmeGcBPicrpbD8ol9+eek0A/WmjAPGfHDgudGC/zKKc70c0NJoBzNz6pgAmM5UCuxhqlOhuOWmkx6EVLsFJoCCcgPlV4QEliWOfC/VT22DLPd8kpUiOwBqfTnplZ/0dckS2SclS/Cr3IdQmLzUfKrQlX3QA1c4dq9bWKRHaTXPg/ExhFxVVghGX0xGzyeIZIfJNEoVcSezg8ftrnsVcMFsd/dtyf9bnXauX2eatmBkAFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1Y2/GeVpEQ4vIVkzaAXx72i6jzVqY1upjL354wQSGo=;
 b=bidm0yHeyOVrwxo2QaAE9/klF24dB2IC6fX3OAXwdMlz2TJKCo8OFo/wP0MTwXxxwRPBkcQFfQbAR6sq01mE9J61KsP811UJMLeeGf7A8ZG9fqMFy6Z50+AP2U8mWsbDKDHNNtdx0bKXyvYGDd8nk2d1NbpA+ASimTxzaq97bN2+Bpw8nRvQlzCeOnMHzsjt7O3ykVJIRcRct7hZf2oJIM2lAIHAcTKeAtuKOQ+JThzwlmDdcBIkjOnFOFIsq77x7m+n5EKmM1cYBpUd1a8PFgIaYoPpcfZRLWIYB95mP0gdNqdJhm5wdnPNfIucc8t4B/P1NMg2GG7LQfKCBC1xeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1Y2/GeVpEQ4vIVkzaAXx72i6jzVqY1upjL354wQSGo=;
 b=X7rMAKNz64q67OmppRBPjLMtVtR04+0LJNEcsDAFFtKG9zTQSdobq4XQB9hqGoxfNzyh4cWaqGPy47ZeIhuYXj2oSLkKfKMFZLnnWDi40EKLdKCJ2nLnPRO/JqBMlrpq+gLoH7G4wpo9q6zRWBRc1nM6wX6Kpf39d1JNqsT3+sc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB8469.namprd04.prod.outlook.com (2603:10b6:a03:4d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Thu, 26 Oct
 2023 10:16:53 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::83bc:d5e1:c29:88dd%5]) with mapi id 15.20.6933.022; Thu, 26 Oct 2023
 10:16:53 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Dominique Martinet <dominique.martinet@atmark-techno.com>
CC:     Dominique Martinet <asmadeus@codewreck.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alex Fetters <Alex.Fetters@garmin.com>
Subject: RE: [PATCH] mmc: truncate quirks' oemid to 8 bits
Thread-Topic: [PATCH] mmc: truncate quirks' oemid to 8 bits
Thread-Index: AQHaB+Fund2V2t/1tkG/nk83veyIqLBb2p7w
Date:   Thu, 26 Oct 2023 10:16:53 +0000
Message-ID: <DM6PR04MB657596E19EF3D7976197660EFCDDA@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231026075230.414685-1-dominique.martinet@atmark-techno.com>
In-Reply-To: <20231026075230.414685-1-dominique.martinet@atmark-techno.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ0PR04MB8469:EE_
x-ms-office365-filtering-correlation-id: 53ea1877-d995-4e41-6c78-08dbd60cacdd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yYZorfED5Oysk8hSuur05znlsxoV1V/RMsKdEprke9WAgktttueurzdPOGSPbrseaXNTh42tJ8v1VJuYnU8VLuT/k1V6NHnsMuP4ySBVBMeloVpL+A0pf/ehNG2H9Jtm8JnQ1ppo3w1OOoiDPEKOfq2+B8Sqyfo/i5KreMn8GlVNJ0xFaiBRu8/1a6klaUPyO+WWkZ+9Ul3Qu7cvPWy2sanzMDavRzDzal/a5K2fnibXRLUKd17y9Qll7evdq+YHboHKLkE0JSVsoavldYatWXrm1tragPeTVlymij1+SDTeUTF8eVnVK4lTyYsa4F3iRiU+ZYRmPiqctsu7gH9IeYJguX1SvuAMyISuZcEriQMgXvIxL2uEXxU8GR19nWcdeOzjz0T3/X9BHQ2z8JNFspiCKKgGTWLzqiCdqKfQRm5dJ75jsLvEkkMeVjtSpAvWn5yvN244NHcrfdiej8Dtd41LNbp9oKcatOVze+vXA/ERIhWb1jA3qktN3eRP3M4B17vJB53NFYMQyRjcLWbPn57fYBdaxXYSglT9JFe56/B+FOOzDwsMsd3Adn8fbN1RB3zWGM77d0fatVd4VsOZxbQNLnE1++NcYv4LS4l/1Os=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(38070700009)(8676002)(41300700001)(5660300002)(52536014)(8936002)(4326008)(55016003)(6916009)(66946007)(76116006)(316002)(64756008)(66556008)(54906003)(66446008)(66476007)(83380400001)(9686003)(82960400001)(122000001)(6506007)(7696005)(38100700002)(71200400001)(26005)(2906002)(33656002)(478600001)(86362001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MEu1qJ5azKWu5ptsxo17EzKFbwHufeQrTFaBYamymGJYfEQ0XKre66rz5Ujw?=
 =?us-ascii?Q?6lWU14aQb5rVD8M3CNbBAYyXPJ0onpg/bhenvx4F2Z7iVIQGO/tbgUuYKo6+?=
 =?us-ascii?Q?Us7jIutN4RHRZvhmQSmhGn6npqDqiB9xfF5sxB91/D0yMqLnT+0VpmRg445A?=
 =?us-ascii?Q?1IzsSlKnzC7y0kvgYWYGXS8bu2tBYhs+dPvB9ltbEkeM4fY9SD+gJh5pNUOe?=
 =?us-ascii?Q?8Tg1D6tKi7/8i0xhEDNeB/mUHEsHmT59UQitZk9502A3avdKpirTgNz2QaW4?=
 =?us-ascii?Q?pl50iy8NQ9zq6Bl4+3gs/9m6UMCxWM8Ib9JH/A12v9dfdcsQzx05jeNOaSaf?=
 =?us-ascii?Q?5WEjQby1WfC59Zp0SJFo9nt9T0n3P5mp3AXZC3wmIKgN/Xu1pAIXTCvEKOPB?=
 =?us-ascii?Q?1fnwiE/Zrk89X4voi2k9yr9FwsEKdUXGd+xsO/frGjt47VGrosuOfWqVq6Xb?=
 =?us-ascii?Q?u5/9J/ukz3qsetm63OqIyLfxwcYAUbBSvWjec1xqcoId30xPi7PaIZiCMMIp?=
 =?us-ascii?Q?p4S4i7TbXa/DIECvhEHgHdA29V4ywW8Z+x6wxgQda8NxHi2P/rPdioV0HsMb?=
 =?us-ascii?Q?NfC9kwGpB2rItOk6PT96MAI3tlDFcRhtPy8/tow+4GtpTvCGp1Qd+gr8sHWL?=
 =?us-ascii?Q?/ER+XmOxG3h29kWomN2ZUAMIru+QXgi9l4IK/9ahoh1M7st8/T0Uck6og6SB?=
 =?us-ascii?Q?u0X0ZJlmBVObhRG9QyGmL57MtwmfLMWFhABiJZ9XXfxXSmI7E0qfwrJfZNsR?=
 =?us-ascii?Q?3tbx5v7PqeVoe1Uw/k+vwKv2JIZm7Gca8/RMS5a8jQnlSDZhg3gjeR3Y5IG9?=
 =?us-ascii?Q?i9iSfORaA/nI+ruK6FfffSP0eptqowdJHRYTW+1x0j1+YqqgB6DO0vKVgnvj?=
 =?us-ascii?Q?mhbgMftQtNURjdeYl02AMjqb0jnUhFUeheZutUTPVg5SI1wcMihAF/PABZok?=
 =?us-ascii?Q?JZCAxWHLxhmYhD5s7rfqJkUUAyFmDtYU8BFd2+EMTFybXO4mUrFTGnFR04en?=
 =?us-ascii?Q?KlZH/ZAQeIPHp29Nrt2pDVdsB+2x5sCTD42ZFyj4rMxgknzoD9ncZdv4Wann?=
 =?us-ascii?Q?a9f2D0NjbjekNebnp6xBUp/VW+Qk7OGZkWvivJygy9U+dl0GcgN6k5KD4la+?=
 =?us-ascii?Q?H0+tbKXrYbye0XLrBuYryCi/tc14wJkquwg/2fUtrCzlngLXw3l7LsvDEFdl?=
 =?us-ascii?Q?KFnsifpGtL8Dqn2fpiOW7b2TJP1c+Qp3IdTaYWeGhxrrFEszSfwDQr7rv4eM?=
 =?us-ascii?Q?cPSN2BB65GqwgNcZWZda/EgIYJ+2z5K+wi8ZawsRS/pohs7Lg2KUy5ygquTK?=
 =?us-ascii?Q?79Cfw50Auuj2CYDm2SflDWiir37UvSqhFAi7lBiqJQ2I+IyOMOkP+mdfaocm?=
 =?us-ascii?Q?lfmLeW6XG32faCCMXUxzJpPIw97pHrygvqW4gOBBAlKEgAumSIt3JSO3Fe+1?=
 =?us-ascii?Q?qEADmzTf+6/kw/UK7OjHJNjgkH4w82jy7cDdz7TzL4aEtm6QmBsmCtmouX1Q?=
 =?us-ascii?Q?zm5UVN10Oo9CvNls/tT+b0Fr09ossNaQTiKmPT6hz5cqejLmvLqy79rw7nFC?=
 =?us-ascii?Q?3cbE4QNdH3POJRTsOrxnZnZrNnNo0/ZTthzgb89G?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HKmJJ6TdHZlzknefmwbjppawhILssvfjwflenM/DqewBRxYRo+fwIge5uM59T0zGcaviNb5SJTc/FQbGb+uvIxXr+2QQhvbzh2MobaZCPxUZJ/+PSEbv0FFRdnTFI6Ul3DfIXWhmZIy/CaS7SmLwqTo0CA91bGjhBTeh/qUjYXKkpHqgkgoWBbHJA8VQQwP2lE+aFZhLsvnRWed9UrA6zspmv86RClN1EcFqaSX69ZK1kUmIF3bqB856ajqp5EEV3Aug/HnMXe0/X8s73nDwaCBnqbpxmM9Yk2RLWrYrs4OYFVkDFmqy2xASZCZaitVbq1/ZpmpzXn/FekjutR3jUc4raKeER68HA4ScNKQFVvHBZyeTvwibVo59EilLlQH9da5EfKOXGBOhivnDYo47XR5mLKfkp7AEa3FM/yeFTVNvMmA6EO8J/qrrLE2WVxrP46a4uqbdCOU7IImuiG6BnTWAYW/L4F4TtkVYM1rYAS5aVxLHUx+ZqDWlr+/iSO1LbdALfW4P9MhbAqxj8acmZ5X337nD9TwgI0xV2lgchufvKSwgyizNCN7stEB/S1no+m0VrEteZvsmqiqjFCgp06CmdeNsXH7ZzXtUEq/OmCnPYb6anAqpxu1t5/yTHqqant3TgximErqSG17BwL+cGWfCV7JX33yw17fVhhiuCKRB0tBHyfcHGedF0mod60szWSG6j5/bAyTqmWzP4SsJ0bpQFskKUQ1AJp8/6cIBI6w47BQDGax4o72q8Tes5ea4vxSuWZdD+n9AMacG/ny+fZfivCqnIHneThjrEz3SNdm+NFA7EUoMzemb2QECIhohMiDcNMn2+l4lGXNhnsYvoQhmTMGreHV9rvTGs9JaiVR7zO+RTv8ALNmcZVf2zRfnwU3DPdcanxl4JF8bzK7hBSTKFRMfzUZJJDKnyfSlYng=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ea1877-d995-4e41-6c78-08dbd60cacdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 10:16:53.0753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iTW/lFTeGXmkNLitQCgzG75/8g6Thuupzz2ufEnnb0R5UktdFwEsJkgyN773V19E7tITXwYspzmG3AykPbDgbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8469
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We now only capture 8 bits for oemid in card->cid.oemid, so quirks that
> were filling up the full 16 bits up till now would no longer apply.
>=20
> Work around the problem by only checking for the bottom 8 bits when
> checking if quirks should be applied
>=20
> Fixes: 84ee19bffc93 ("mmc: core: Capture correct oemid-bits for eMMC
> cards")
> Link: https://lkml.kernel.org/r/ZToJsSLHr8RnuTHz@codewreck.org
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-
> techno.com>
> Cc: stable@vger.kernel.org
> Cc: Avri Altman <avri.altman@wdc.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Alex Fetters <Alex.Fetters@garmin.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

> ---
> Notes:
>  - mmc_fixup_device() was rewritten in 5.17, so older stable kernels
>    will need a separate patch... I suppose I can send it to stable
>    after this is merged if we go this way
>  - struct mmc_cid's and mmc_fixup's oemid fields are unsigned shorts,
>    we probably just want to make them unsigned char instead in which
>    case we don't need that check anymore?
>    But it's kind of nice to have a wider type so CID_OEMID_ANY can never
>    be a match.... Which unfortunately my patch makes moot as
>    ((unsigned short)-1) & 0xff will be 0xff which can match anything...
>  - this could also be worked around in the _FIXUP_EXT macro that builds
>    the fixup structs, but we're getting ugly here... Or we can just go
>    for the big boom and try to fix all MMC_FIXUP() users in tree and
>    call it a day, but that'll also be fun to backport.
To me, your fix is clean, elegant and does the job.
I would let the quirk owners to fix that hard-coded bogus oemid - should th=
ey choose to.
I guess Sandisk would need to do that as well.

Thanks,
Avri

>=20
>  drivers/mmc/core/quirks.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 32b64b564fb1..27e0349e176d 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -211,8 +211,9 @@ static inline void mmc_fixup_device(struct
> mmc_card *card,
>                 if (f->manfid !=3D CID_MANFID_ANY &&
>                     f->manfid !=3D card->cid.manfid)
>                         continue;
> +               /* Only the bottom 8bits are valid in JESD84-B51 */
>                 if (f->oemid !=3D CID_OEMID_ANY &&
> -                   f->oemid !=3D card->cid.oemid)
> +                    (f->oemid & 0xff) !=3D (card->cid.oemid & 0xff))
>                         continue;
>                 if (f->name !=3D CID_NAME_ANY &&
>                     strncmp(f->name, card->cid.prod_name,
> --
> 2.39.2
>=20

