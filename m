Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DA77865B5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 05:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbjHXDJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 23:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbjHXDJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:09:20 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F40510DF;
        Wed, 23 Aug 2023 20:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692846556; x=1724382556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w7lS3YqBG1Sa04UYaQiSug/JB6jD/ygv2ALlNExerog=;
  b=k3Vp40miB3bkk+sSAFpitHnj3F5eIjlwtgG10L9rIzUULdlUB1O/2x1Y
   p6tIkWsApaI21CKd+L/fvmomYlaczT1MXuYoueNRwrW7FIOq6m94nV1xV
   bk82xawSwFJR1eC+TuZsHx8nYcvWyKvb2Apucayu9WTtRYt8NOaVrvOCA
   EWEQuRdi/unSFijkOCX/vY3rRYfSoHsWqTAC/IJpCsHUAlhI8VsC1lgt2
   y71Q0KLuyAeveEDPzMh/C1VZeIwqtr9Ge9DK1aw28PHPaZbOp4TvKCPsy
   4bLrFbMH0zXxZfo6boOyIQiDtnJM+icfFB4BxA1SH1kchuhfJ9/KRt6YT
   w==;
X-IronPort-AV: E=Sophos;i="6.01,195,1684771200"; 
   d="scan'208";a="246541243"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2023 11:09:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBrjVEFqVN7wPUMuqXJa4zr4DoMRtrQs7iubokvhASZlbWimh6ytbC7xgug6jvvH1NzVEP8HLC7zr7nY6mJnRmbvr124iBz2jdhyLT8GZDgqodM4WH57y+oQ0hQTY6q9fu5Mt39l/94mEa4T953sVU2hXgpPO6pVCuLBjXnHa5VdK0fXyriYS10xkex4lcUvk5RW8u5YRqtImg48PTNqRWE8tJtghNopRw2WLGnauLlPq7uk05+EGM1ySBJrjPolVxWeJgB7gXtunUp5dKz4ljKY5X1jjouVPBDO9OFxGsIHoxRF2EiesKRomie6eBjfzCoIhhGTpXEDb/PlAjMw4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LcnS//Mzgcvm4FopZzFYb/8GlHOgDSaS0Q0k6L6PQQ=;
 b=F/pw5rN9ToKB+vm14wnl9FqEd9Nd3pl5YMKtw3TaMtfFwY7/PBXCprEYRmDS4Xv3oYDV/qHzgWewecDwP1O09bzbjXZRwPHxSi6KrwG+bMLlASKyZYFWNjB65soWaAeo9qEgSrrtEe6t288SejetF2MwK4gBjpJGJFthsLIVB4I3FUMVIIBXtFxSV7VIm/AmuCEqYlMF3fF57JL366mLpm+6ZyKli8+AYMZ+m+UaGBaGzKK19b0NP9l3Uz9iKtd/G7zNmioLs9nTXgvPX4C+bEyumoUIGaSsTLzKIuXPBVy90vw2tVIkqAiyXsU62mwDXr5WSJsSbYIlTUWxbKF/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LcnS//Mzgcvm4FopZzFYb/8GlHOgDSaS0Q0k6L6PQQ=;
 b=gYDPBVmujnp18kv72WHz2Q46gGTuZXClwWQ5MoZONC0uClOK6Cw7WWq2N8WYaKMb1BNjNk1xovpoSgQgRtXIfpez45rHYvrMvSr+aNgZ6BDGfO6/vDZqm7WkwBkhr3+2gt9by1UFSUjGpNSFCNQGVPbiReqT2YkO6tcHjRuNO/c=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH0PR04MB7938.namprd04.prod.outlook.com (2603:10b6:610:eb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.17; Thu, 24 Aug 2023 03:09:11 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6723.016; Thu, 24 Aug 2023
 03:09:11 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Thread-Topic: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Thread-Index: AQHZ1NQBelM/0wps2Uy83of5WKTqEa/4xwsA
Date:   Thu, 24 Aug 2023 03:09:11 +0000
Message-ID: <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
In-Reply-To: <20230822083812.24612-4-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH0PR04MB7938:EE_
x-ms-office365-filtering-correlation-id: 2a76ac21-d7cb-4f63-0854-08dba44f7d6e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mOLX+b/MTB7+QtinaZwU/KiLOJgU/uBs5QUgQTbKYcCCoOoeWSTDEGbCRX5ug9y5DE/ZerLG0C1OrN2t+v6F05vNMT6/34JCCx5u3QWTiZZ3+cDJCfo4o1k5fBGinZnIw2L5JBlEJvsmXdDXp28mE9HyqdWY1SkHQHC7NUhQz7JMCUptt3DhZt9GAVMGHRj9zGDrG4+kQL6HdwruFXdyfQtjVmHu3FN0JAAVwbwllIOFBT595rmzpGTRkZYiBfAncEMTVrpYjsnlqmiG1I15M4tia4YxdqlyQi8/O4ReKOtwlwFM8yP2KdCJvVMQjfe4H+f2H72e2vllDLjHJxaXRCQXEBgIUQQgvgbrGuC9esybd65DbGneC4AFGAq7LwQ6fAcIDEKF5kKJX69RmibImT2hFJsCA5cEh6t+SHRjhcPBx7x5O/LuPNVMzjXJzPJKcVyg0sTECd2exI8bgsiZKquEldf8doFnOQE+Ay629uDVoLvgKzgoOt3JrDyccPoCxK9gOTJ3SpzbeaatZSB+xguy0g2YIsrml22vHoGSAKTdMtaOGJ4XoCRuLyq98fnCDk38RVoypmOwlJNVnMXnNoE2P0U2M+KgPtQGA9DItUNcfN36oZmogVtLkpuukcfU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(376002)(396003)(366004)(136003)(186009)(1800799009)(451199024)(5660300002)(4326008)(8936002)(8676002)(30864003)(83380400001)(40140700001)(44832011)(26005)(71200400001)(38070700005)(38100700002)(82960400001)(122000001)(66946007)(76116006)(66556008)(66476007)(54906003)(64756008)(66446008)(33716001)(6916009)(316002)(91956017)(478600001)(41300700001)(6512007)(9686003)(2906002)(6506007)(86362001)(6486002)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kd98lqZ8A48Sb7nFm7OvTV+kWtLASnEjTRpCnVVDVu+xLf8aHMZX3cAaIHzs?=
 =?us-ascii?Q?PisqJGiVNgACDRhvEMuskzgPGuqBbQ66Gfq4GykRNk/afTYm6p1QI421ctC+?=
 =?us-ascii?Q?QZysDpCHscX2VVjwpedJm85VspVb7f7Y+tFmrHNGQvinn+4taJJpIFHhwFEx?=
 =?us-ascii?Q?5AHA3bfOHaEo5uAbaJYF3ts8mltJEn9puR/OxPoUHRZETHQMQFgwjgNBbre+?=
 =?us-ascii?Q?MR4D0olxzy+d2m9UqmuiWz9dLT9TgR4EuFtbQY4LVnOT3yVt9GhuR4f6FJys?=
 =?us-ascii?Q?O5bDmdMs6ok36oeT+LMByGAx931wo9c/C0Q+mV8A4w+1Nu+PZge7Px0DwiM9?=
 =?us-ascii?Q?95X2ePJSzd/LVbioTqcBS5Tp/fKIjZLTFaLeA4IzA5G55Wa8nAH6MhnIrz77?=
 =?us-ascii?Q?cLZxSS4X3CXvwvWfvaTO7TTQhFK6+FLzA98b3J16aOcyyWwdABH4+cFmKVaS?=
 =?us-ascii?Q?nDxCI+GRZFJl88RKBqBzMR2BgfBUTSW3XKWimEg6hhhI/Rmxozi9DXCBA9iW?=
 =?us-ascii?Q?oPK3lvp7M3VGP5YkgeYZqPqk8bQhxXIqJ+WYOxrr3Y7iB5hEoWo2dn56tV44?=
 =?us-ascii?Q?5ZfKSq8dcFznj9zarH7XBPmYA/EcGpstGWMBwKqNLYdJvlncw+bMElOJ+F40?=
 =?us-ascii?Q?F6NxshsQL1uVWgGZE0b5u3WYL6xTtQbE/QuoDdPjGGlfbD/QpXKGWBnHX1+9?=
 =?us-ascii?Q?4lIMKh5H3f8lm6VBF1A6pt9cM697ygA4xthhcf13LrumIcg53SZLIfxF5gsh?=
 =?us-ascii?Q?ZztZGJxwyBblHPzwcZsUu+oBn/fg62OuI6kn0zChUjOgZLQ2iguTYh7U6QaV?=
 =?us-ascii?Q?JHSnaIy12uGm4h9/AW0jpTAgoIhorhVGN7JIf+liCHjMi1iMlv5y3XBVwESl?=
 =?us-ascii?Q?5PFbEoUWB/1q6i6XtEh5f8kV5OfIvcsZ94w9ivaTvWOakMN8ylr9q1S8jn2f?=
 =?us-ascii?Q?mVTgWSsUMGyEHdHF8sMwbOFSeHqf3hNEq5KgUxOmGIi7QKdecpir2bemxi77?=
 =?us-ascii?Q?JO8U2a3qsBFUnKrYc2pwiJAe4ygUfPoNoxUJDIkt7gEHyNh9RzzZDj9Gp+vN?=
 =?us-ascii?Q?uPjHg2a4DnisnXx7dgtd+0IfwxgMWzaVdL9wZRGTnPyVhdbvtp2/PTxRb19y?=
 =?us-ascii?Q?sBL7exFAZMIaJ8ugWe/OtphD3OIs6nVvvqmI3Fez43F33kNl7ids78+byH3A?=
 =?us-ascii?Q?8WsEe1Z5FYpi2xr1yaz9QHpL7SacdrvbJHRt+txKpIcRxsqXIZj9RQG8JDBH?=
 =?us-ascii?Q?MjMf2YFfa5/Z0mWnCUmu3xXZex5NWeoXf79ot4n/qdh2LCMcmoS3BRzLumEz?=
 =?us-ascii?Q?wQpBPOtu2tylL0PiK6tkrPS1U5KSpsTMpMDhTdtrmUvsGiOoDa7ll3/XV8Fh?=
 =?us-ascii?Q?xmRFHm10uVAOaCH24QEpstRxVVRKHBvz/mOvebzUxl2Ie36OhIMPaCxv3CtR?=
 =?us-ascii?Q?fu+n2oHbVsCuA1XT71PpyDSfh0s0upIRWa6MmveaXdcSYqlX4hgbLvT4A/nf?=
 =?us-ascii?Q?jgucqAcS8moVz/WGfu1n2XxpG6lr32k4QDcRE7leXpsvMiKSQCXLfgsHq4Hh?=
 =?us-ascii?Q?p0J/0491REukXmd/XjAu800mPpd86mrtJk6rY4NXTLmFB8A5N7fiJnfVFP5E?=
 =?us-ascii?Q?CIy8X52JU2w5ThMnT0oFokQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FA200D5F6ADE8844B8DD7C261FF5DFAB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?hOtoPoGXYRVNbPGnbQPgmVj9Ymr3dpFDWY41ILikRXJFTl/aVUcQ8wrFBp3W?=
 =?us-ascii?Q?4JxsINzZnpkB8xfvPx40qhBMb1c2QG4WEhBnttWxwzEC+3DbshV393vkaFaB?=
 =?us-ascii?Q?VaTaAk/CDz6gPxhCq2zKXX+ZfKS7h7M7ih1Vdg43UvhX2ysNSAYTmT5bEf4g?=
 =?us-ascii?Q?Prm1nCUkdM6Lzhdh9bhfmEdUIlu2EACJWUroWsAEk7HgKQcNid+G2X5Rxi4i?=
 =?us-ascii?Q?YrMhaiKOxzxBQfDIoXq/mdmpWI45MFezh3KdzXDP+EkESm+GAGuMiAV+deKy?=
 =?us-ascii?Q?8NnMAnaPseX1EK4z5CNWi/sHzTnP++lM7mXBDfq2VD2bkCh2pbtd35qasY9m?=
 =?us-ascii?Q?QTvum8Lb+5pSAK8UOipLvFx0FT+9Z/61WEZ8q+e6a+MocHrNU4TlTJO37Zm2?=
 =?us-ascii?Q?EgfiBvEVM2icLrG3WP6nNHb1Db46+eMmeeGs03PxixnIh6th9a7WaM2z/6n4?=
 =?us-ascii?Q?rnFtIDcxukC8qGTl23U1G5xIm/JOdyaUYPzOxOUiRp7+R1hZoRWeJRPbwIzl?=
 =?us-ascii?Q?dCgfui7nzl5p+VTVYnr3sHkGMkQ+yPjLk6H4j0KFgPSiTXxXpua7W4tPU51u?=
 =?us-ascii?Q?2O7OaSDR4GIX8ZViPDtnLjmAPJltpxba13xSVyJa711ao0H1yJER6GgsyMIV?=
 =?us-ascii?Q?i6wn7tgxTL9nVXAH2MjZ/2FM9Q4inZazpi9Ml8xB9l3Zu5ZMykzGxTNxGkZ1?=
 =?us-ascii?Q?g3CnRhroK5g1iPmXYnT0lc3N9BDZ94vGy5J2PCNSaBWNLT9lb5tGl/aurGX2?=
 =?us-ascii?Q?zeZSo0hT6Iv6AJNYQex+67QuPUiHaY4y4xbtvGUYDUqm/sjk3Bwgqk9Q+gRO?=
 =?us-ascii?Q?3xgfTAHzhPm09hE2m39LNYOT4qaFCD0hLD2uffhttwZCjZE5CrCiwO4ODM5a?=
 =?us-ascii?Q?CywQ7YoSFq6ZymwhT7oRnZwN+DfRFH2D7Xoaummpy+3iXD8N2DD98YMyv7a4?=
 =?us-ascii?Q?wPoTiqjO4YqHFkrnnVmvbA=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a76ac21-d7cb-4f63-0854-08dba44f7d6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 03:09:11.6234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FJ/VFx8ViOao21KatYkqKAOcIBuZShWG8L2bz5EMg732+ohV86IaWP4aB2Eql9J3Z6YetloZUdPZEFusAy7ZxlzmHERzANa1S4qUrtAKhA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB7938
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 22, 2023 / 10:38, Daniel Wagner wrote:
> Almost all fabric tests have the identically code for
> setting up and cleaning up the target side. Introduce
> two new helpers.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

CC+: Bart,

This patch makes shellcheck unhappy:

tests/nvme/003:26:2: note: Use _nvmet_target_setup "$@" if function's $1 sh=
ould mean script's $1. [SC2119]
tests/nvme/004:26:2: note: Use _nvmet_target_setup "$@" if function's $1 sh=
ould mean script's $1. [SC2119]
tests/nvme/005:26:2: note: Use _nvmet_target_setup "$@" if function's $1 sh=
ould mean script's $1. [SC2119]
tests/nvme/006:24:2: note: Use _nvmet_target_setup "$@" if function's $1 sh=
ould mean script's $1. [SC2119]
tests/nvme/008:25:2: note: Use _nvmet_target_setup "$@" if function's $1 sh=
ould mean script's $1. [SC2119]
tests/nvme/010:25:2: note: Use _nvmet_target_setup "$@" if function's $1 sh=
ould mean script's $1. [SC2119]
tests/nvme/012:29:2: note: Use _nvmet_target_setup "$@" if function's $1 sh=
ould mean script's $1. [SC2119]
tests/nvme/014:28:2: note: Use _nvmet_target_setup "$@" if function's $1 sh=
ould mean script's $1. [SC2119]
tests/nvme/018:26:2: note: Use _nvmet_target_setup "$@" if function's $1 sh=
ould mean script's $1. [SC2119]
tests/nvme/019:27:2: note: Use _nvmet_target_setup "$@" if function's $1 sh=
ould mean script's $1. [SC2119]
tests/nvme/023:25:2: note: Use _nvmet_target_setup "$@" if function's $1 sh=
ould mean script's $1. [SC2119]

But I think the warn SC2119 is false-positive and we should suppress it. In=
 the
past, blktests had suppressed it until the recent commit 26664dff17b6 ("Do =
not
suppress any shellcheck warnings"). I think this commit should be reverted
together with this series.


Daniel, please find two more comments in line.

> ---
>  tests/nvme/003 | 14 +++-------
>  tests/nvme/004 | 21 +++------------
>  tests/nvme/005 | 20 ++-------------
>  tests/nvme/006 | 19 ++------------
>  tests/nvme/007 | 14 ++--------
>  tests/nvme/008 | 21 ++-------------
>  tests/nvme/009 | 16 ++----------
>  tests/nvme/010 | 21 ++-------------
>  tests/nvme/011 | 16 ++----------
>  tests/nvme/012 | 21 ++-------------
>  tests/nvme/013 | 16 ++----------
>  tests/nvme/014 | 21 ++-------------
>  tests/nvme/015 | 16 ++----------
>  tests/nvme/018 | 16 ++----------
>  tests/nvme/019 | 21 ++-------------
>  tests/nvme/020 | 16 ++----------
>  tests/nvme/021 | 16 ++----------
>  tests/nvme/022 | 16 ++----------
>  tests/nvme/023 | 21 ++-------------
>  tests/nvme/024 | 16 ++----------
>  tests/nvme/025 | 16 ++----------
>  tests/nvme/026 | 16 ++----------
>  tests/nvme/027 | 17 +++----------
>  tests/nvme/028 | 17 +++----------
>  tests/nvme/029 | 21 ++-------------
>  tests/nvme/040 | 19 ++------------
>  tests/nvme/041 | 18 ++-----------
>  tests/nvme/042 | 17 ++-----------
>  tests/nvme/043 | 17 ++-----------
>  tests/nvme/044 | 19 +++-----------
>  tests/nvme/045 | 18 +++----------
>  tests/nvme/047 | 21 ++-------------
>  tests/nvme/048 | 17 ++-----------
>  tests/nvme/rc  | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  34 files changed, 141 insertions(+), 519 deletions(-)
>=20
> diff --git a/tests/nvme/003 b/tests/nvme/003
> index 71b82ce758a3..b5ea2720100e 100755
> --- a/tests/nvme/003
> +++ b/tests/nvme/003
> @@ -22,15 +22,8 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local loop_dev
> -	local port
> =20
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -
> -	loop_dev=3D"$(losetup -f)"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> +	_nvmet_target_setup
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" nqn.2014-08.org.nvmexpress.discov=
ery
> =20
> @@ -46,9 +39,8 @@ test() {
>  	fi
> =20
>  	_nvme_disconnect_subsys nqn.2014-08.org.nvmexpress.discovery
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> +
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/004 b/tests/nvme/004
> index 697c758d3059..31af8737857b 100755
> --- a/tests/nvme/004
> +++ b/tests/nvme/004
> @@ -22,19 +22,8 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
> -	local loop_dev
> =20
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	loop_dev=3D"$(losetup -f --show "${def_file_path}")"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
> -		"${def_subsys_uuid}"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -44,12 +33,8 @@ test() {
>  	cat "/sys/block/${nvmedev}n1/wwid"
> =20
>  	_nvme_disconnect_subsys ${def_subsysnqn}
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -	losetup -d "$loop_dev"
> -	rm "${def_file_path}"
> +
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/005 b/tests/nvme/005
> index 4ca87ff48016..f9956e960a56 100755
> --- a/tests/nvme/005
> +++ b/tests/nvme/005
> @@ -21,20 +21,9 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
> -	local loop_dev
>  	local nvmedev
> =20
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	loop_dev=3D"$(losetup -f --show "${def_file_path}")"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
> -		"${def_subsys_uuid}"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -43,13 +32,8 @@ test() {
>  	echo 1 > "/sys/class/nvme/${nvmedev}/reset_controller"
> =20
>  	_nvme_disconnect_ctrl "${nvmedev}"
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_host "${def_hostnqn}"
> =20
> -	losetup -d "$loop_dev"
> -	rm "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/006 b/tests/nvme/006
> index 910204aaeb90..d85f64b702eb 100755
> --- a/tests/nvme/006
> +++ b/tests/nvme/006
> @@ -20,25 +20,10 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
> -	local loop_dev
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> +	_nvmet_target_setup
> =20
> -	loop_dev=3D"$(losetup -f --show "${def_file_path}")"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
> -		"${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -
> -	losetup -d "$loop_dev"
> -
> -	rm "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/007 b/tests/nvme/007
> index db00bdcc2d08..feac5060a950 100755
> --- a/tests/nvme/007
> +++ b/tests/nvme/007
> @@ -19,20 +19,10 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> +	_nvmet_target_setup --blkdev=3Dfile
> =20
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
> -		"${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -
> -	rm "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/008 b/tests/nvme/008
> index bd5e10fbfb99..f4b45b2f1c11 100755
> --- a/tests/nvme/008
> +++ b/tests/nvme/008
> @@ -20,19 +20,9 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
> -	local loop_dev
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	loop_dev=3D"$(losetup -f --show "${def_file_path}")"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
> -		"${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -42,14 +32,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}"
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	losetup -d "${loop_dev}"
> -
> -	rm "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/009 b/tests/nvme/009
> index c9a4b57ac288..63614c91a96d 100755
> --- a/tests/nvme/009
> +++ b/tests/nvme/009
> @@ -19,16 +19,9 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
> -		"${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup --blkdev=3Dfile
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -38,12 +31,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}"
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	rm "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/010 b/tests/nvme/010
> index 19bb7f3fc7a7..e782a9bb06f3 100755
> --- a/tests/nvme/010
> +++ b/tests/nvme/010
> @@ -20,19 +20,9 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
> -	local loop_dev
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	loop_dev=3D"$(losetup -f --show "${def_file_path}")"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
> -		"${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -45,14 +35,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}"
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	losetup -d "${loop_dev}"
> -
> -	rm "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/011 b/tests/nvme/011
> index 0e54c2588bc8..7329e0505f59 100755
> --- a/tests/nvme/011
> +++ b/tests/nvme/011
> @@ -20,16 +20,9 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
> -		"${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup --blkdev=3Dfile
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -42,12 +35,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}"
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	rm "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/012 b/tests/nvme/012
> index c6b82c821bf2..6072eed3532a 100755
> --- a/tests/nvme/012
> +++ b/tests/nvme/012
> @@ -24,19 +24,9 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
> -	local loop_dev
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	loop_dev=3D"$(losetup -f --show "${def_file_path}")"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
> -		"${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -48,14 +38,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}"
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	losetup -d "${loop_dev}"
> -
> -	rm "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/013 b/tests/nvme/013
> index 441db7477d75..c9be60675cc4 100755
> --- a/tests/nvme/013
> +++ b/tests/nvme/013
> @@ -23,16 +23,9 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
> -		"${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup --blkdev=3Dfile
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -44,12 +37,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}"
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	rm "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/014 b/tests/nvme/014
> index 3656f9399687..d49e8f3cce4d 100755
> --- a/tests/nvme/014
> +++ b/tests/nvme/014
> @@ -20,22 +20,12 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
> -	local loop_dev
>  	local size
>  	local bs
>  	local count
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	loop_dev=3D"$(losetup -f --show "${def_file_path}")"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
> -		 "${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -54,14 +44,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}"
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	losetup -d "${loop_dev}"
> -
> -	rm "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/015 b/tests/nvme/015
> index bc04e39c628c..b418d785ab27 100755
> --- a/tests/nvme/015
> +++ b/tests/nvme/015
> @@ -20,19 +20,12 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
>  	local size
>  	local bs
>  	local count
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
> -		 "${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup --blkdev=3Dfile
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -51,12 +44,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}"
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	rm "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/018 b/tests/nvme/018
> index 68729c3cb070..19e439f3f3e0 100755
> --- a/tests/nvme/018
> +++ b/tests/nvme/018
> @@ -21,16 +21,9 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
> -		 "${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup

I think the line above misses --blkdev=3Dfile, doesn't it?

> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -48,12 +41,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}"
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	rm "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/019 b/tests/nvme/019
> index 33a25d52e9fd..15e98c40134f 100755
> --- a/tests/nvme/019
> +++ b/tests/nvme/019
> @@ -20,21 +20,11 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
> -	local loop_dev
>  	local nblk_range=3D"10,10,10,10,10,10,10,10,10,10"
>  	local sblk_range=3D"100,200,300,400,500,600,700,800,900,1000"
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	loop_dev=3D"$(losetup -f --show "${def_file_path}")"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
> -		"${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -46,14 +36,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}"
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	losetup -d "${loop_dev}"
> -
> -	rm -f "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/020 b/tests/nvme/020
> index f436cdc8b262..aae40e7131e0 100755
> --- a/tests/nvme/020
> +++ b/tests/nvme/020
> @@ -19,18 +19,11 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
>  	local nblk_range=3D"10,10,10,10,10,10,10,10,10,10"
>  	local sblk_range=3D"100,200,300,400,500,600,700,800,900,1000"
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
> -		"${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup --blkdev=3Dfile
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -42,12 +35,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}"
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	rm -f "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/021 b/tests/nvme/021
> index 5043fe4916be..f9bed1546307 100755
> --- a/tests/nvme/021
> +++ b/tests/nvme/021
> @@ -20,16 +20,9 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
> -		"${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup --blkdev=3Dfile
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -43,12 +36,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	rm -f "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/022 b/tests/nvme/022
> index 8b6f610c4894..e3e67b0996df 100755
> --- a/tests/nvme/022
> +++ b/tests/nvme/022
> @@ -20,16 +20,9 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
> -		"${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup --blkdev=3Dfile
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -43,12 +36,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	rm -f "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/023 b/tests/nvme/023
> index 90af0338e81f..c8d1e4619822 100755
> --- a/tests/nvme/023
> +++ b/tests/nvme/023
> @@ -20,19 +20,9 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
> -	local loop_dev
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	loop_dev=3D"$(losetup -f --show "${def_file_path}")"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
> -		"${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -46,14 +36,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	losetup -d "${loop_dev}"
> -
> -	rm -f "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/024 b/tests/nvme/024
> index 7a89ddd79fd9..2308b42968e1 100755
> --- a/tests/nvme/024
> +++ b/tests/nvme/024
> @@ -20,16 +20,9 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
> -		"${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup --blkdev=3Dfile
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -42,12 +35,7 @@ test() {
>  	fi
>  	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	rm -f "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/025 b/tests/nvme/025
> index 90f214eff6c8..b3851d8ceb14 100755
> --- a/tests/nvme/025
> +++ b/tests/nvme/025
> @@ -20,16 +20,9 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
> -		"${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup --blkdev=3Dfile
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -43,12 +36,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	rm -f "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/026 b/tests/nvme/026
> index ec352acaa489..38acfcc373b4 100755
> --- a/tests/nvme/026
> +++ b/tests/nvme/026
> @@ -20,16 +20,9 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
> -		"${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup --blkdev=3Dfile
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -43,12 +36,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	rm -f "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/027 b/tests/nvme/027
> index 339f7605a9f5..2d65b3e1a820 100755
> --- a/tests/nvme/027
> +++ b/tests/nvme/027
> @@ -20,16 +20,9 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
> -		"${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup --blkdev=3Dfile
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -40,14 +33,10 @@ test() {
>  	if ! nvme ns-rescan "/dev/${nvmedev}" >> "$FULL" 2>&1; then
>  		echo "ERROR: ns-rescan failed"
>  	fi
> -	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> +	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
> =20
> -	rm -f "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/028 b/tests/nvme/028
> index 7f387eb337f6..eec1807884a9 100755
> --- a/tests/nvme/028
> +++ b/tests/nvme/028
> @@ -20,16 +20,9 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
> -		"${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup --blkdev=3Dfile
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -40,14 +33,10 @@ test() {
>  	if ! nvme list-subsys 2>> "$FULL" | grep -q "${nvme_trtype}"; then
>  		echo "ERROR: list-subsys"
>  	fi
> -	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> +	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
> =20
> -	rm -f "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/029 b/tests/nvme/029
> index 461e6c6c4454..bbc481437fc8 100755
> --- a/tests/nvme/029
> +++ b/tests/nvme/029
> @@ -53,19 +53,9 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
> -	local loop_dev
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	loop_dev=3D"$(losetup -f --show "${def_file_path}")"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
> -		 "${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -83,14 +73,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	losetup -d "${loop_dev}"
> -
> -	rm "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/040 b/tests/nvme/040
> index ed6df3bbed52..7759bac9b43c 100755
> --- a/tests/nvme/040
> +++ b/tests/nvme/040
> @@ -21,18 +21,10 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
> -	local loop_dev
>  	local nvmedev
>  	local fio_pid
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -	loop_dev=3D"$(losetup -f --show "${def_file_path}")"
> -
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
>  	nvmedev=3D$(_find_nvme_dev "${def_subsysnqn}")
> @@ -54,14 +46,7 @@ test() {
> =20
>  	{ kill "${fio_pid}"; wait; } &> /dev/null
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	losetup -d "${loop_dev}"
> -
> -	rm -f "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/041 b/tests/nvme/041
> index bc84412ccb46..99c24ad4e6a2 100755
> --- a/tests/nvme/041
> +++ b/tests/nvme/041
> @@ -24,7 +24,6 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local hostkey
>  	local ctrldev
> =20
> @@ -34,13 +33,7 @@ test() {
>  		return 1
>  	fi
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
> -		"${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" "${hostkey}"
> +	_nvmet_target_setup --blkdev=3Dfile --hostkey "${hostkey}"
> =20
>  	# Test unauthenticated connection (should fail)
>  	echo "Test unauthenticated connection (should fail)"
> @@ -59,14 +52,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}"
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -
> -	_remove_nvmet_port "${port}"
> -
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	rm "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/042 b/tests/nvme/042
> index 47e1b95ffdc6..f0e196a13ba0 100755
> --- a/tests/nvme/042
> +++ b/tests/nvme/042
> @@ -24,18 +24,12 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local hmac
>  	local key_len
>  	local hostkey
>  	local ctrldev
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup --blkdev=3Dfile
> =20
>  	for hmac in 0 1 2 3; do
>  		echo "Testing hmac ${hmac}"
> @@ -71,14 +65,7 @@ test() {
>  		_nvme_disconnect_subsys "${def_subsysnqn}"
>  	done
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -
> -	_remove_nvmet_port "${port}"
> -
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	rm "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/043 b/tests/nvme/043
> index 15676f88d556..c95f38e6c71b 100755
> --- a/tests/nvme/043
> +++ b/tests/nvme/043
> @@ -25,7 +25,6 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local hash
>  	local dhgroup
>  	local hostkey
> @@ -37,12 +36,7 @@ test() {
>  		return 1
>  	fi
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" "${hostkey}"
> +	_nvmet_target_setup --blkdev=3Dfile --hostkey "${hostkey}"
> =20
>  	for hash in "hmac(sha256)" "hmac(sha384)" "hmac(sha512)" ; do
> =20
> @@ -72,14 +66,7 @@ test() {
>  		_nvme_disconnect_subsys "${def_subsysnqn}"
>  	done
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -
> -	_remove_nvmet_port "${port}"
> -
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	rm "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/044 b/tests/nvme/044
> index 9407ac6338c8..f48458a82323 100755
> --- a/tests/nvme/044
> +++ b/tests/nvme/044
> @@ -25,7 +25,6 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local hostkey
>  	local ctrlkey
>  	local ctrldev
> @@ -42,13 +41,8 @@ test() {
>  		return 1
>  	fi
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" \
> -			   "${hostkey}" "${ctrlkey}"
> +	_nvmet_target_setup --blkdev=3Dfile --ctrlkey "${ctrlkey}" \
> +			    --hostkey "${hostkey}"
> =20
>  	_set_nvmet_dhgroup "${def_hostnqn}" "ffdhe2048"
> =20
> @@ -95,14 +89,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}"
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -
> -	_remove_nvmet_port "${port}"
> -
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	rm "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/045 b/tests/nvme/045
> index 396bcdefbcba..902eb26bef8e 100755
> --- a/tests/nvme/045
> +++ b/tests/nvme/045
> @@ -26,7 +26,6 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local hostkey
>  	local new_hostkey
>  	local ctrlkey
> @@ -46,12 +45,8 @@ test() {
>  		return 1
>  	fi
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" "${hostkey}" "${=
ctrlkey}"
> +	_nvmet_target_setup --blkdev=3Dfile --ctrlkey "${ctrlkey}" \
> +			    --hostkey "${hostkey}"
> =20
>  	_set_nvmet_dhgroup "${def_hostnqn}" "ffdhe2048"
> =20
> @@ -114,14 +109,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}"
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -
> -	_remove_nvmet_port "${port}"
> -
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	rm "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/047 b/tests/nvme/047
> index 1da24b5638a6..94d7d50f9f98 100755
> --- a/tests/nvme/047
> +++ b/tests/nvme/047
> @@ -22,20 +22,10 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
> -	local loop_dev
>  	local rand_io_size
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	loop_dev=3D"$(losetup -f --show "${def_file_path}")"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}" \
> -		"${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup
> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
>  		--nr-write-queues 1 || echo FAIL
> @@ -55,14 +45,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}" >> "$FULL" 2>&1
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	losetup -d "${loop_dev}"
> -
> -	rm "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }
> diff --git a/tests/nvme/048 b/tests/nvme/048
> index 19234a5b3791..06e1fa6b4f65 100755
> --- a/tests/nvme/048
> +++ b/tests/nvme/048
> @@ -87,16 +87,8 @@ test() {
> =20
>  	local cfs_path=3D"${NVMET_CFS}/subsystems/${def_subsysnqn}"
>  	local skipped=3Dfalse
> -	local port
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
> -		"${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup --blkdev=3Dfile
> =20
>  	if [[ -f "${cfs_path}/attr_qid_max" ]] ; then
>  		_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}" \
> @@ -118,12 +110,7 @@ test() {
>  		skipped=3Dtrue
>  	fi
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	rm "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	if [[ "${skipped}" =3D true ]] ; then
>  		return 1
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index fdffc07da34a..261892ed2070 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -359,6 +359,12 @@ _cleanup_nvmet() {
>  	if [[ "${nvme_trtype}" =3D=3D "rdma" ]]; then
>  		stop_soft_rdma
>  	fi
> +
> +	blkdev=3D"$(losetup -l | awk '$6 =3D=3D "'"${def_file_path}"'" { print =
$1 }')"
> +	for dev in ${blkdev}; do
> +		losetup -d "${dev}"
> +	done
> +	rm -f "${def_file_path}"
>  }
> =20
>  _setup_nvmet() {

The added lines above are same as those in _nvmet_target_cleanup(). So, tho=
se
liens are executed twice. Is this what you intend? At least, I think it's t=
he
better to factor out the lines into another helper.

> @@ -818,6 +824,69 @@ _find_nvme_passthru_loop_dev() {
>  	echo "/dev/${dev}n${nsid}"
>  }
> =20
> +_nvmet_target_setup() {
> +	local blkdev_type=3D"device"
> +	local blkdev
> +	local ctrlkey=3D""
> +	local hostkey=3D""
> +	local port
> +
> +	while [[ $# -gt 0 ]]; do
> +		case $1 in
> +			--blkdev)
> +				blkdev_type=3D"$2"
> +				shift 2
> +				;;
> +			--ctrlkey)
> +				ctrlkey=3D"$2"
> +				shift 2
> +				;;
> +			--hostkey)
> +				hostkey=3D"$2"
> +				shift 2
> +				;;
> +			*)
> +				shift
> +				;;
> +		esac
> +	done
> +
> +	truncate -s "${nvme_img_size}" "${def_file_path}"
> +	if [[ "${blkdev_type}" =3D=3D "device" ]]; then
> +		blkdev=3D"$(losetup -f --show "${def_file_path}")"
> +	else
> +		blkdev=3D"${def_file_path}"
> +	fi
> +
> +	_create_nvmet_subsystem "${def_subsysnqn}" "${blkdev}" \
> +				"${def_subsys_uuid}"
> +	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> +	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> +	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}" \
> +			"${hostkey}" "${ctrlkey}"
> +}
> +
> +_nvmet_target_cleanup() {
> +	local ports
> +	local port
> +	local blkdev
> +
> +	_get_nvmet_ports "${def_subsysnqn}" ports
> +
> +	for port in "${ports[@]}"; do
> +		_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> +		_remove_nvmet_port "${port}"
> +	done
> +	_remove_nvmet_subsystem "${def_subsysnqn}"
> +	_remove_nvmet_host "${def_hostnqn}"
> +
> +	blkdev=3D"$(losetup -l | awk '$6 =3D=3D "'"${def_file_path}"'" { print =
$1 }')"
> +	if [[ -n "${blkdev}" ]] ; then
> +		losetup -d "${blkdev}"
> +	fi
> +	rm "${def_file_path}"
> +}
> +
>  _nvmet_passthru_target_setup() {
>  	local subsys_name=3D$1
>  	local port
> --=20
> 2.41.0
> =
