Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC325803C21
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjLDR6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjLDR6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:58:48 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB375101;
        Mon,  4 Dec 2023 09:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701712730; x=1733248730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aJmltqwBbaEOteJ2p7N7TZ1mYGvxKH6gve3NxVGk7R0=;
  b=EJnkFHM68Bw5UidDj91nSZBg2qRI3ydjFmx0odJXDdrial1pchb5OVFF
   eNf5TljogGMK1H426rwSzgHWs3YvEqRb1UgPnGuvSxbt11BeIrGeU2dK+
   NcAT/iDAQhA0Y8lH04PI9X683tJITX7P8rl4BZzco0wnmUURlyQDA235G
   SrNJ0RrtAJqO8Oejk39DTLpyfbzTcsz+RE1VyAbOWV478zeJcCgK3B991
   0L3M+J4Evy5FE7aUu5fBPRdw4n7BqDlJSo0Ea9s2yRb1pAIrrZDB9vSf4
   z5OLuWTo4YnN2rgBXauxkxpxViIGGyU3FeRekGbLYgt+v8YxZHvrpj6P/
   A==;
X-CSE-ConnectionGUID: Yt3/5JkORO+k6KmgLo7KKQ==
X-CSE-MsgGUID: 1dbKrOFcSCKigyN1kDsPNQ==
X-IronPort-AV: E=Sophos;i="6.04,250,1695657600"; 
   d="scan'208";a="3976995"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2023 01:58:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jH1ER7aYMs3J0sSlKSUmCvtG7Fc07wJ3QJK+2JzqzB7mVEPVNGv6vLbeumGw7XlKmbIYmmLZ9SWwPWaZhHwAWNBhSray/s+2ryznTSDx6ntNsv651qZ5U29huD4VsOK78vRO7S7kprcLzS4PGsFOCcL6EHkPiBnR3+Cf51GRuGcpmMtp+CScT62blxtQllI819Y6pcAzPMP/yVfmPkfyE3jigaNojEvjFlpXZGhJHgQF+CHRX2+4xSB1RRHDnV5boOgXJUaAsmHgjBodiS4jRaClTr8lwW1i+Y69MNzSyD65Bc++0FJ/JIMBeFgKONcGKZU6x2HqEvjYCAOvAzGg9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0D7XT5czTDyUqskt9iglbCalDl1CsW8xWoxkKVCsz3c=;
 b=fqmBZNyo3d6bJYAyqFIDMlRQu08ZI85c6BW/xZUl/kPUwDo3JrnUzarcPLng7j66EFc6xi3uQjykEldg61MC0K58TmLC3i3LELSD79UFtwhEQNjtmHNGJ3lQsbQXR8aWQjvaCIa5k2cPqS2qpWHckY04G4/u7B2ASIFL/q5XrrXAhiVU1sleGzswLkyQW+8BMZAuGa/5ntO/ToEHlaLjOtukEgEXTsLAYvwHygWYLBa73jFJq/HaXv4gHdrX0JSZu4YNKMwyXSJuHhJrICfK/zx2L6dtJhdnwIPyVjEs7pHcZkMebuxzvOE/psMEU67m5DmoG99WLQZVa8Rrri/L0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0D7XT5czTDyUqskt9iglbCalDl1CsW8xWoxkKVCsz3c=;
 b=fxHY/9G4YV2H++6feuhUSF4JuDn3+Jpu4vkb3Wd059cwKcVMUZowOquW91TTg0dKb2RdW07yLbnpCsaqDl36nj5bJ9fTa19+AIBWgs1znKZvAwt1QPRaOAwU5l0Xg4VE/zH8XsZf4C2By/o0UB6a4naCrYFhsfWU+8nMFCb3EKY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 LV8PR04MB8936.namprd04.prod.outlook.com (2603:10b6:408:18b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.33; Mon, 4 Dec 2023 17:58:45 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4%6]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 17:58:45 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "christian.loehle@arm.com" <christian.loehle@arm.com>
CC:     "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "yibin.ding@unisoc.com" <yibin.ding@unisoc.com>,
        "victor.shih@genesyslogic.com.tw" <victor.shih@genesyslogic.com.tw>,
        "asuk4.q@gmail.com" <asuk4.q@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "yebin10@huawei.com" <yebin10@huawei.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Thread-Topic: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Thread-Index: AQHaJsLBZ2sxhOoGTkWiMOgXX6Cv0bCZaLEA
Date:   Mon, 4 Dec 2023 17:58:45 +0000
Message-ID: <DM6PR04MB657532850510D64BA7D62297FC86A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231204150111.3320071-1-jorge@foundries.io>
In-Reply-To: <20231204150111.3320071-1-jorge@foundries.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|LV8PR04MB8936:EE_
x-ms-office365-filtering-correlation-id: c9972b57-3de4-4b41-0fd9-08dbf4f2a8fe
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gxrDHvsvJtp24/UU5NrhZAHeDkRDm3qmHu0REoQPEAyeIyo7AWZjTDybkon26lZXgi+Lb19KuAa3Dt7GWv0xDwqg2ay2t9r5wWg7ACbWafg+ln3CrnzBGB4JYdtDo7XK0r4TZrGS25O9rO3q9/lJPV4uPbnB5/ZXKqXyXIcWSanfz26q+0D37ZSXgQf3KkSQM/uFGECKwncDYJq4tIBDKR/yay+eBYRWy+fxm4mmTRwwFZwMugio0g3QgXHg05lv/0OCRB0Z3e/qKybE+YxVWCg9SNHQP5WUGU2GqOdoE7ttEiIOXrcMKRWafU2S1AKnHPmmKVuNHmN+21pTk+ikcDNtSTAtWxytt7Mf01Xr0YDAAdDAk47owyBW4h6GXs8rPeKTy1tUNhuLMx93/1/AObXbLnnNvcXkzBhN0TM07HPnQMxpQPHp/nYpW1vqjahXAdCN96hzSv2sEOKVmM6TmR7JEUoEomu4hlgl4n70oHwFHuJ1doXd24EgkHGeHsXbsqZ0s9rtb/BdGiXBGQRBUQ9yHFwDvr7lKQ5kHe0CpUAMc/TppPRrzKTidmvNbvqbCAcWAU7feyiZjklbyy3U8ciwuZ7sFEE7qsEBMg5jqgJp7W8hxY+jjR3Sc3Z3ka1L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(52536014)(86362001)(4326008)(7416002)(8676002)(8936002)(2906002)(38070700009)(41300700001)(33656002)(9686003)(6506007)(82960400001)(83380400001)(478600001)(26005)(71200400001)(7696005)(38100700002)(55016003)(122000001)(110136005)(316002)(54906003)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kMYtAzUWArM41AuwhIpu0A5xx2/+P4rRGUuKwxNQlB66U2/Gq/NtFZDXNZ1P?=
 =?us-ascii?Q?z4utovpa9c35RXornFcanI7coXSSDNVcrtV+DxWQpXSBdl2GW39UfK7n+vI6?=
 =?us-ascii?Q?mmbvYOr85iyCzRhiZVj2pt7xUOK3Far+GFPY1FDtzK6ZqdJFnV8YayQfFCZR?=
 =?us-ascii?Q?uXjTYruxYcfTPq4n2gHvoImSExfwMTN/nLFaFutbzzfGOvTislwM/3XDs1bX?=
 =?us-ascii?Q?CC0uiS/90L8nffDdHbUtyALbcyGlB2J/Jh3Wxz5SB7LzOQjim88ttLMTC9SH?=
 =?us-ascii?Q?zx/66c9h0Uhy9pbvv7Ca7YBBlwMkXdNaflFcUvEoIfXcxR3EdZ/YkXshda7O?=
 =?us-ascii?Q?JhpFIFSG0NCEFFXftXPpBT2Vp1MgPX4yGiEBpsaGdA0UbveeNJ4JkmFli4Bf?=
 =?us-ascii?Q?BMRSCjib+ZWpJyj7V5hLlD61u03OGiz8sj3KnsjrIn14k32Nr3l3ZBHqiz82?=
 =?us-ascii?Q?+t1XXV8kttslzZ2YHW1A+H8Cf7mSXxLnfPtG7LHeUAtCnYW8XWYDxeIthYG8?=
 =?us-ascii?Q?JT3y69CDjAb3M8AXwsgZ+ySD5tCJHoj1DyFO77WuDmwh8V/hz1CqgMOES1JA?=
 =?us-ascii?Q?Ok88CDSq8rYfjnYwN1h6kY2Xv8itwoGEy6R69w7MhsDEDEmUiNCq6h7AjHsO?=
 =?us-ascii?Q?lRLhK2SdjBV+2EpJJ77r7yVNVEerb+evmJwiGaTMvpHVOLfuPKVMGqoxiEnc?=
 =?us-ascii?Q?7QhUpTVcikvi89MLu7czRoGivOOH85zDOMLJkiezOyDKox/Y4qVog1xCCs4+?=
 =?us-ascii?Q?gxf8QvctWGURu8sW1Zt9oOsIhUDBS0X0GXOFCPfFxSvlDj8rO/79jIiJOgUi?=
 =?us-ascii?Q?AGnW+3vrr/YS+lqnyFv0CWNA1Mf64qbWCA3GZdUZ6IhYr1UECwmMxeCElqL1?=
 =?us-ascii?Q?p99uzuDMk8lXb9FiMVJZMsnXs6fQQ6UsJOf66ob9/qLlAS6NWxcHo92Pvqhx?=
 =?us-ascii?Q?p4PFZh+JNuz4y/NpWYs6E+85I0ViY+o/534RB+bQzjnuKWLNUhtvHBiuE9cI?=
 =?us-ascii?Q?mNz3oyWXj67SmnP36Gw/cDBFibbDnlhtW9aOR9F0Pw3Rt8oZngvQaFpJJeV8?=
 =?us-ascii?Q?knGso/eZzDm6wtA7bD0Mum35UCp3zaQ2sqc26cKha6Y3lnmbvVboKdkMJtlX?=
 =?us-ascii?Q?xO0+ALY1TN3QM2cSFb9LYUuL7YiYAqHe+WvL4c4m4ZCTJ5euElkDxIkHgdGn?=
 =?us-ascii?Q?lDZoYbBiqTdZixwZ1j6AfoevVEMky2k4JEP6qaBY1rIrG2JK21TMCiSuOk+H?=
 =?us-ascii?Q?17nPm5oJbBWwMcS+KmVjukYyaFLk+IVu+sQmOVnone/ysjh8DiwpCabgStTr?=
 =?us-ascii?Q?MnOAHKfckV3cOxruIpKbihs7IeOjfHgTnHPyBNbMyi8TSY59Wjal0Bi/AqT0?=
 =?us-ascii?Q?C2yOmwSKIL+dx46bYE6c8LVX/7RB4qDS/FOcmC3A496tdqCE+OmQfF6ZazPU?=
 =?us-ascii?Q?Uae+hOmpCOvbdGlPVwZZlAQii+nKDNv4omV8KD3PKuBPjqUFzQkuoD5vI/9p?=
 =?us-ascii?Q?fEgQPrzBmJaZ/d6WHZmUsndLS8cNPpjHUqfIIJBNmA1yEO1zzKCvdjGTdB2j?=
 =?us-ascii?Q?ufw5LUv9e42dTeYrjRzQVmnCKxeeEH9RmDohsnlp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?eYLec3vf+Jn7uGOm71C/wUFiM8G5iCyAq6zbrJyyJug6u331RBol7nYoe26y?=
 =?us-ascii?Q?70yqRQSmpflSF999syrF1TflgKa+tTP6IgYSYwm0R0GXkJBOmP58Lq8lIt4H?=
 =?us-ascii?Q?1mYWUe3QqvIf3Iz1fqsmthkf0jbLU/xPq+OKR8+5Rns5akzOWtApLaHFJg9W?=
 =?us-ascii?Q?S51Yq8yifJroDfbGzzELwXqPiKwhd8THOKX2dfzFznHQ68+dmP2fffkYoeRU?=
 =?us-ascii?Q?mW3eK8jy1Sil2Vs3OmpcmNVVJE0xQLevELRtX3yWnR0F2FekltITsCbmsD9N?=
 =?us-ascii?Q?HN6Lo5IsqRU4ShbVRBn0RY70HnSoo6atFx1sLbYWHKxqY0pA/Do4ttmAQ3e0?=
 =?us-ascii?Q?gBy/iKE8L9yDSS5FFpBhPIzIAWFo1QczPOwYvlYASv3udKf5DQJfN/4G7Rwl?=
 =?us-ascii?Q?Cgi4mbpgXj6HCMbLKI8bxCG3+VazZYpVzxwjVrnLbMXPn1HsVZ/MwQdUTCaT?=
 =?us-ascii?Q?iiXY0rf8wcrgm9nZ7z/b7zzwtV+GCz4/4H0e5N1PQ0GIKG8OBpKWxMRMbgeO?=
 =?us-ascii?Q?IBeTDRf3j3xaN5LKK3q3PBF9b7F7qsd++OZ2AR0AuCCJO80fGSKa1YVWOzFJ?=
 =?us-ascii?Q?KTVvE8LLq+UjBRITwzYlaVovmr81PXTDUVXKXXsSc70lcfp7JBGSxbMs7qqH?=
 =?us-ascii?Q?0Mmc+TQutTrzeyOkbQ4hfJGZeb9MF5yIzEJD4pW/ApDgmiVRojeVKdQ3ZYdc?=
 =?us-ascii?Q?q0DHCl7AKHigAcoyNmQMj83ZHHHUMuzxGdtjk6CVBuo0FhzlZWgeYoKsu55H?=
 =?us-ascii?Q?HhRJP+OsCzyaPG2TjL/XSek7nmAHEwIevk/N1f40jEl56nuiYPg0KmSJqaHy?=
 =?us-ascii?Q?mTNupJm3xncLpSAZJQNYwUvce9OMBM2x4GsD+P+n5eXuzf6Ffp2sOUfyTpGm?=
 =?us-ascii?Q?SXUzPyzruRdFOMlnSjO2mwOVwGY9Pl793T0wUQzFtivbp17E19XMgZuWnoY+?=
 =?us-ascii?Q?ZO/zK0w43bLyDTRFfU+A8SPYyHYSlCrsEJGdpiKrWkGWbCBPfaJZOisqIRn4?=
 =?us-ascii?Q?G4DFsoQ+Dyih2CRVBALIoHh4/kq5+kB/si4cFJ3URP16YrwV9wZv0uqb6mtl?=
 =?us-ascii?Q?CLBj+JbnVnaMzf9JGZeYu0XZyOBE+nVARSC613KO64pXiSANTMk=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9972b57-3de4-4b41-0fd9-08dbf4f2a8fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 17:58:45.7036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M+z9BWgnXjZZYsHmszzCMq0dPrkCXiuZjtCmEuh72DnKUz8V4AYI+Mhp0ZvKLBAA334z3FzBB7XfiP1gxo9+gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB8936
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Requesting a retune before switching to the RPMB partition has been
> observed to cause CRC errors on the RPMB reads (-EILSEQ).
>=20
> Since RPMB reads can not be retried, the clients would be directly affect=
ed by
> the errors.
>=20
> This commit disables the request prior to RPMB switching while allowing t=
he
> pause interface to still request a retune before the pause for other use =
cases.
>=20
> This was verified with the sdhci-of-arasan driver (ZynqMP) configured for
> HS200 using two separate eMMC cards (DG4064 and 064GB2). In both cases,
> the error was easy to reproduce triggering every few tenths of reads.
>=20
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> ---
>  drivers/mmc/core/block.c | 2 +-
>  drivers/mmc/core/host.c  | 7 ++++---
>  drivers/mmc/core/host.h  | 2 +-
>  3 files changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> f9a5cffa64b1..1d69078ad9b2 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -859,7 +859,7 @@ static int mmc_blk_part_switch_pre(struct mmc_card
> *card,
>                         if (ret)
>                                 return ret;
>                 }
> -               mmc_retune_pause(card->host);
> +               mmc_retune_pause(card->host, false);
>         }
>=20
>         return ret;
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c index
> 096093f7be00..a9b95aaa2235 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -119,13 +119,14 @@ void mmc_retune_enable(struct mmc_host *host)
>=20
>  /*
>   * Pause re-tuning for a small set of operations.  The pause begins afte=
r the
> - * next command and after first doing re-tuning.
> + * next command and, if retune is set, after first doing re-tuning.
>   */
> -void mmc_retune_pause(struct mmc_host *host)
> +void mmc_retune_pause(struct mmc_host *host, bool retune)
>  {
Since mmc_blk_part_switch_pre is the only caller of mmc_retune_pause,
How about just move those lines into it?

Thanks,
Avri

>         if (!host->retune_paused) {
>                 host->retune_paused =3D 1;
> -               mmc_retune_needed(host);
> +               if (retune)
> +                       mmc_retune_needed(host);
>                 mmc_retune_hold(host);
>         }
>  }
> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h index
> 48c4952512a5..321776b52270 100644
> --- a/drivers/mmc/core/host.h
> +++ b/drivers/mmc/core/host.h
> @@ -18,7 +18,7 @@ void mmc_retune_disable(struct mmc_host *host);
> void mmc_retune_hold(struct mmc_host *host);  void
> mmc_retune_release(struct mmc_host *host);  int mmc_retune(struct
> mmc_host *host); -void mmc_retune_pause(struct mmc_host *host);
> +void mmc_retune_pause(struct mmc_host *host, bool retune);
>  void mmc_retune_unpause(struct mmc_host *host);
>=20
>  static inline void mmc_retune_clear(struct mmc_host *host)
> --
> 2.34.1

