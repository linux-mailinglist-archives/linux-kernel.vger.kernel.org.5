Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058F4790242
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350653AbjIASwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjIASv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:51:58 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77D61BF;
        Fri,  1 Sep 2023 11:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693594315; x=1725130315;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qYc10d/Sn1b1AkYzdMCSSBnqZYjr7qPeMQwrTVhZ4rc=;
  b=eFn47ttY1lSriqb4UBlm/z1RAvTDw9HXYHs9KpybR0F+qM4LkD3kJWKe
   6qf49okzGlxLjMV2ZvtmrDFc0rdLsLkEfFGj2MZL26GPriGQDxqHE8h2F
   0BaV1LdbZwHZiPTmMb0R8iHFpOSx/Dt42DA/V6O6Ud5vMi30lGJ1Qr17C
   U7+rXihj+NPAunDqvRZ4UPKMHLo5Y/70zTNAXrMtnwqEUxQ8fpljSCBEQ
   GMyu8jBpji2xuqkpgv4ENoaIpcmM7qS+0BpHqJAoJ5Ue8dnxm9DPFUW1z
   55Yb4NQSjj2ZJjtRjqI9+cINftYsFurtOnMxJjXP3aHZDN2EH6lcOvcjP
   A==;
X-IronPort-AV: E=Sophos;i="6.02,220,1688400000"; 
   d="scan'208";a="247317149"
Received: from mail-dm6nam04lp2048.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.48])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2023 02:51:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVcaCVzfEF96p787EMLb1MG17RzXVa29pdSmvePYrSJcRN/VxtFCGpdyAuZrnYYHfT4uqnGGFxivBNuMOAkSXXMJokf7fyIVbn7Th4L/nnBOY1VtjemcQ5sxPfFlVJGTuRqBHgomU5NhhW0ltmVU86ZQOC/P/PrBu5HBGt0lOQE/wsQjJwSA9tkPuSKvzSoz0ERtikkHk0SPiaqrEY2rUPuXjiVT7oI6G5XkjLn1z1x9AwokQm0/PJvmRO8fMEcIlb9LdKoQaoYy39QV8gabHLvtepPcleNGxqnqMGsl/Nj1CG/WCMA4StDEJStSfkINICSBgUPzkeXDFrpyeSmTvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7vB5aphGS61V7CuCy9/ZPNQMhBTdTYQqLFpswAjOS8=;
 b=SWOf6pHTcAzwPrxGCSO7wS/UvAwDmHcspHxQiY8FpsgRXhLS4L87LjI1LScOnIRbNpfb5j0w2Hxo1iASX3lrPTsqSkACRrMZkRthN1hmBoz4G3WugwA3b8PhhV5l2X/OE9TXB8W1/krzGIaKEBEpKcY+xpjmBFLE5A2itul3MpS0eeDSfLVGOrjzdQl0ebwzJFRsU+DLj/MaMBNvH3M1aGAXWmXG9vl0Ac0KLyfcxordOXIkLrkr0ckZ85gITmLyYJlmyZRPW0A0VRscETW4IQ8fmzgcYAVwSlqscmW7EovYqoJzfRC2bPebKEhO8moLMGd27lbIuozaTpKc3kQpjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7vB5aphGS61V7CuCy9/ZPNQMhBTdTYQqLFpswAjOS8=;
 b=EcoZHgPYWVpcS6+cZqmFHnzMleMswJOAtANZw7Ap9pSAF7dW4WkMmf6SsP4yv1U5e2br5IR1cfeLqV1pB+DBYfwqoNBpO/GmAIt5YbfGjlPJ2g/W7TUkxXuZAQKbfkkPV6PV+/zmD5aNIOdBMLjzK+/WXR97tFF8wbDqZQO/8L8=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB6470.namprd04.prod.outlook.com (2603:10b6:a03:1e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.15; Fri, 1 Sep
 2023 18:51:52 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6768.014; Fri, 1 Sep 2023
 18:51:52 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Pawel Zmarzly <pzmarzly@meta.com>
CC:     Damien Le Moal <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ata: Disable NCQ_TRIM on Micron 1100 drives
Thread-Topic: [PATCH v2] ata: Disable NCQ_TRIM on Micron 1100 drives
Thread-Index: AQHZ3QFxYKmpluKz2UyymccVFU2ydLAGULgA
Date:   Fri, 1 Sep 2023 18:51:52 +0000
Message-ID: <ZPIyxg+iSWa+W93Q@x1-carbon>
References: <ZPGznkRMxemW2N9E@x1-carbon>
 <20230901182317.3243660-1-pzmarzly@meta.com>
In-Reply-To: <20230901182317.3243660-1-pzmarzly@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB6470:EE_
x-ms-office365-filtering-correlation-id: 84f97338-af28-47a7-4f8f-08dbab1c8180
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8/xoRwP+Ch43l5ETrxQmSpfhobJBKoLWvq2j8Bd/xPLTxlv7+hfqK34Ft76flb8Hi0MS8fkj0xRn1ySTjVC1D0nHcFi/RdmkHj2LXvRGBQ6dPhoEo/PkmV6pBRNX1umsfPk/ZK2/Ow/MKClfce3/J1GNBQwihHJvkLx6qm5f05IuqAkPGDhVyMHPM2E7KXze9Fx2Y7xd9cVP5YQFtmiA+PEa/v4vfJ8wzBVkiOfNMKX35y3Pbl0TPlLo4ajX0BIyQsadzizbe5ab6fvgvZb0KVp9mbCxoXPd4sO4QCzABPJkshVKIXXa5sDbHIQRk4M/X/hZDaVNrxHXPxJ+ZQAN5MNokk//Z2ruMekll/ncfyWjqZFLKhadiC2hQRSAI3B426P+2Ki5PyoD2ZXrHSK2Aowt5UMmaGvhuSBIPqPkOX9C2/QTHt9Bd2g2zFejygloda+wdzYJe1n+MwHhI/u8+3XBcfAAh3D1V3XkFD9LFiwj2ITIurcWleqYnu61GOjD49lw/Xo3HzY2WAQwt/U54/gKeye5V44ma2iSpt6qMRfiTTGyh+A1oUkiUQSNAKhi2Csnhi59JEEKIlg/ZFYijqdpmH27Xfaa9AXQ5GMOPHY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199024)(1800799009)(186009)(4744005)(2906002)(71200400001)(86362001)(122000001)(6916009)(316002)(82960400001)(5660300002)(478600001)(4326008)(8676002)(6486002)(6506007)(9686003)(6512007)(8936002)(26005)(966005)(38100700002)(38070700005)(33716001)(41300700001)(54906003)(66946007)(64756008)(66556008)(91956017)(66476007)(66446008)(83380400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WN9Hu+ssE1HbKfwsEyR9XRlsK6ufnC4IABdy5fHJTPd+T6gZ3CkBI243hznz?=
 =?us-ascii?Q?r8VRMB4fU61TkQPCIxuINvSSVqej4d0D1AIjm6ShGDGk50YGC6QQ2rHT1a6j?=
 =?us-ascii?Q?3cSyPCGv1VPlOf5PtUSl7iciwl/QsVoIQRjmLQ7sLb8B71b/HsIny/tTZOk+?=
 =?us-ascii?Q?I3DSuwkQYeQxVDgAyrAPcd+5GnGyp4qn2fuCHuIVn6vcmEUO6AgiZtaNOEmd?=
 =?us-ascii?Q?efMpjaUXlYGKA5nObT5XMPA3nPVNw/M2e6Jz5NoJJx7hM4Tu40gTOu3nbNsS?=
 =?us-ascii?Q?xGieWImB+ynz4OdzlM601eOw6dTwF6GZo86QgT4UTYeg0Qt9CbSOPRujY5Ma?=
 =?us-ascii?Q?hV5RRyjQ9kcqbRjPMTBfhCjRqxUzCflSO32GkSTHKrvM6QGwiJ6OH+y9txrm?=
 =?us-ascii?Q?F8tZ/nx8QXGgq4djEwEBcsIe8G6d7nrfis8ZUicdmLNZiFF+jgjqR8ZIjIKO?=
 =?us-ascii?Q?if8w9w44lzj477M5nyZiI0aJ3BLVQ7HBkmDFCmhN5T0v6iOeWPCMdM5JIjKR?=
 =?us-ascii?Q?Y8JmSBGE0R4MNWzmusCY2B38utbEkLQFcJLjYMyEdld7JIdeuux1kLnnQX+m?=
 =?us-ascii?Q?M2uUABMRXUUVlNlfkCHlcGwqnl8slKHoCoKKqNeSrkauGs37g5mzXl5Mw1QD?=
 =?us-ascii?Q?ObJBJdVPdwb+DLFaFH8HNEfH5JVzUYfIgtVjvJ9I7ZY1E768xvdr/fTt4Xu9?=
 =?us-ascii?Q?r+/kvXTkL/yvHcDrzBu39o8GaCL8nccxjOKNE3sBCZc0RlDrwKkxkT1JlrYc?=
 =?us-ascii?Q?cPaRF4SSq5PgDXFyxSmaweHFduZ5D0XB1bl2ibUhgLFO+DvmPqYVX2LWU0fd?=
 =?us-ascii?Q?66WT7E3spC7tv74sLrqOO3EqPBkCgbxj4hYXMOeOTwApsCGo4aRlZ5cJ9xN3?=
 =?us-ascii?Q?5ym+9G7Crj9QFLFAegVXyJcsvkMqEn3Rzw+gojd2r2v214AEXEXcbuJtmY9l?=
 =?us-ascii?Q?lKObDA1W5ceIj9DcYbppQYntjQuyeSVRVYdAxNK6Aqy6/G6+ED/cPsRd19qG?=
 =?us-ascii?Q?aM4hl0ePvekDj3x/DEbUVv/0Yth/t3Unpu9eqRHvSzYDsFzkySTvKrpvCcfh?=
 =?us-ascii?Q?SzVenWZMsY31tq7VeMCcIo83rqb7t1z7QkrJ0U8izJnEXvxGKqq7gnOfazHq?=
 =?us-ascii?Q?umbvJlDu0HT/iknHCKJlKrP8foErDbq0+Lkb/3yE0QzQnsh05QfEPH1x5ZnN?=
 =?us-ascii?Q?3rqM49tT6Z4M4IYFXk9Ee8dPfmyH3MjjA7Ogahb7/vBqU2pSY6eh3ejptv2y?=
 =?us-ascii?Q?FYRFkKsZilA2kSK3XP96P7YI7BDHBoe4zlORxQPdZlLt6s+3bV0wRGR+jNJI?=
 =?us-ascii?Q?ll/bnwp99y3MzVPT6H6RHKb3t1VOUJz3W9pS6voBMUym/kZUqLuvJe26DBwz?=
 =?us-ascii?Q?1jju/TH2kderRfsgijJyYbLb7OjIEanWa/tVLwinzeC9sxodKYGHmH+lv3Wu?=
 =?us-ascii?Q?d3W4ke7amn9w1c64vDy2KayW6g9WwjOoD1/5qFOV1dZAcWhImvGoK+UQgvLu?=
 =?us-ascii?Q?cYoFVdFzdRjYyXS1VSS72iguqSfyy3SoLNgCIrdlvVi6b/fJftBmvxjuHNq5?=
 =?us-ascii?Q?/EHGgrr7DWiUk6WNJgMworulWhHMrBoH9hI9twGv7iwSfF1gmeAIjAtBm/9p?=
 =?us-ascii?Q?9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4D1A89A84E9C254594558CD97A78F928@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hasVPaZEChyITAjhOssIR7+DlclKYt/KW/PoAXkZfKEYK0FIowmsl1PvR9dIm/dHsFbQZCK8s1K9v168YAQpdaPZWUbS1DzwLkhDcb1282MKC7raAny74ir6Rj/A2aXaoSST3+W5LGinImUTYP+qrJkLzDNu0zuGZJVkQkWt1q9IP+KPm5M2ON/XmiGAIfo3841zCClOzwKuGJMyDAVkH5SMfCu8vRsOlobY6Md9EJ8wn6x6CtuY0tnRYQs+GyGPuUsChlPHjAiFXeGtvB7MgOaWsFfZudZHclb+PqV6vVpORD/jDzkO7jAwYNc33jaZTt4wbK0JNrqPcK5OcOpnBBvtO3W35/QrDCQBdQyxx5lVawHhCxF1ZGTBpUGLCYhkzaFevBhh3lbRdsG5HAne6Dd3Uo/dQNBxKl686+sKaD1vDa/cXmOR+kw2zCWTUplplpWIe/83DK2Byaju9b3lc3A27zLaWt+ZZTRvO4cLsd2VAHMzY3EusQq7pfO5Xh9HQ5+1FWArkgFK5UMiY49junKzmO4Uqs5g0pBow7enbHFKpBYOWw4hZtcAQRqx1HBdDMxOBjIAfb8HHBzuIJPtcXkHLQIZayhEqZMB6w12QMMBaM0pC9uFqzxdJ+bMe4WpQ4+15034K1IvPI4RrNYtYPGdVy4jMp9yswqTy12h+1rpMgRNtOn3tFseI1bI5HDjMdG+DU4VglA9ddbwmMLLlKSYsay48RzEuuoP3owBzvhfNQzmX83imoyghUReCut5aNSXNRsQOykXlJJFCr7HW39PVeXe9wVM2RDI+9py2FEnQL57vI/pdBQzpKNx0eH49L9ZKljH5uKii00FYSBQEw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f97338-af28-47a7-4f8f-08dbab1c8180
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 18:51:52.2897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X6k8X625+Q3zHZ0OBeXOfcZC3+a33ukWfvreZV+a23WwTfisfd7shbAl723vY9lgv+nHHsGpwGoQzB674VzCgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6470
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pawel,

On Fri, Sep 01, 2023 at 11:23:17AM -0700, Pawel Zmarzly wrote:
> Micron 1100 drives lock up when encountering queued TRIM command.
> It is a quite old hardware series, for past years we have been
> running our machines with these drives using
> libata.force=3Dnoncqtrim.
> ---
> V1 -> V2: Fixed formatting.
> ---
>  drivers/ata/libata-core.c | 2 ++
>  1 file changed, 2 insertions(+)

I think you forgot your Signed-off-by tag this time.

See:
https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch=
-format

E.g.

<commit message>
...
Signed-off-by: Author <author@mail>
---
V2 -> V3: Removed redundant helper function
V1 -> V2: Cleaned up coding style and addressed review comments

path/to/file | 5+++--
...


If you run ./scripts/checkpatch.pl against your patch,
it should tell you if the Signed-off-by tag is missing.


Kind regards,
Niklas=
