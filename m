Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BF4803A14
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344604AbjLDQWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjLDQWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:22:02 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1E595;
        Mon,  4 Dec 2023 08:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701706928; x=1733242928;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8sk/qovy2W2/oFX7zBMNMw05DapkoL/gmocPJbFIMEw=;
  b=RNMyV8ZJqJapUM72md43zkks0bV/VJEei7Ck6KPol9HcBP2gJ5SzBM7t
   uVQe7QbmdAbpbb2MEtEC6wx0IOLu3rzSNmaMNTtMcpY29s+uU6kQVhgP5
   VZHdcXzLMbel/QC6JMgqlWboIsNjK3iedGBf+77+Dlm5NrM/VXXHeHoYJ
   LIxTGqUqk18r7l7n4fXbOPTl2/UqYPhO63/72IAvvHhuGQyGEo7jD++4S
   wkeiuJ9vx8bldAB7ew6h93oGSXPvkBGXL1toMAhU0Jhsgs9SHld1qeMnv
   9UwREDZ+R8LSgktp2lXWoPRukWiXM+sLS5Ec58kfyV8DPA6LOyFkEB04r
   w==;
X-CSE-ConnectionGUID: 215R0z/ZTri9loApHXoULQ==
X-CSE-MsgGUID: fT2CKqUQQ3aLBfKiQmU/uw==
X-IronPort-AV: E=Sophos;i="6.04,250,1695657600"; 
   d="scan'208";a="3996878"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2023 00:22:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFrYhEEcF3gruqNnEuOBlBOdx3JyFB93nSLwNfzzCx6suZ8Zq09NtPceRAHuMLi77yL2JlZLekC8T85vvZ8mfdz8WPVG6Ex7rsKU6bhiT5DrUWsHWlxV9ThvkP0mjFQiqDGyXS/QicnTqtPVKgrzy0UyBFUUrdyoAQW8k/GLc0Q1XPsZo/Wb1yAI4EXwXJeELTjiKwm/z7zbU5HFTcY27Jozb14yQd5d/a6xRoUOJ7tarecy7x982ozH+oGnG72fANvgp8iQ9bMy136evZLdb9glXTvcj5NGIskJQf5nUVr/6DK2cRKJxWZLcq7mZETlrtRYONQsqFdurDBSLUtaCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cg6Vxvi07yipfm4ZglbIq2af4DeqTR/yXt2tsJun9DI=;
 b=I5YpmOrUr3UzNPgqvGE2hg+imHNUk6XURdX9c7XKycGVmh/xudSjHR1mGd9lz02rJisyvNMGBYiVWKSbNn5fPDDDiVpRjEPKnUSaPQLOGyxkaAiHwq/ah+BIZC8xwCF0I6ITx8zGTf8GcxpPTg7Z07XhpYCodoWBzgELhZvGHZZigH4ksm2S6ih3lwwehMxj30XsyO1gSnUgMXv0Gl1mSMBruOa4bJhgP8iXKz+2h5OzDn/Jjhb/OZBdLXCPGB7YBvq8xXvY0ns/v0hJbTLn3BFbxjj7mO2MRYegO7klY38+V7iDnUQZiiX3hSMy9K6nykp7faTjSLZYBSE1aEOW/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cg6Vxvi07yipfm4ZglbIq2af4DeqTR/yXt2tsJun9DI=;
 b=uxMbRGIjsYEYIPyfrXBfgzagK43UMInZ5c6ESWL1FNnpRZAOrtXM0egX1ude3I3o19d5I/MTOJ4eSLKpBKrICqIc6lsO8CC3juM0wNQ5i4tAemID0F/QjNH9zc7uhBxlGkUcNGoqoylaBpFjDKijqOtoCur5nzHzfUOG+maQxiE=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CYYPR04MB9050.namprd04.prod.outlook.com (2603:10b6:930:c8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.33; Mon, 4 Dec 2023 16:22:04 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::7d7a:2cd1:54e5:ebc4%6]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 16:22:04 +0000
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
Thread-Index: AQHaJsLBZ2sxhOoGTkWiMOgXX6Cv0bCZTlZw
Date:   Mon, 4 Dec 2023 16:22:04 +0000
Message-ID: <DM6PR04MB6575DE834F55913A9E799ACEFC86A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231204150111.3320071-1-jorge@foundries.io>
In-Reply-To: <20231204150111.3320071-1-jorge@foundries.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CYYPR04MB9050:EE_
x-ms-office365-filtering-correlation-id: 220f6653-ffc9-4c34-ed4d-08dbf4e5273e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /cIpVYV1bDjspvP15EVnw2hElniEyTfPaoTvfJsXH3qnIL58dSRei3JJq41q+WSYIC2kNqIIp8orMorgW9I6yqcG1wfMrW0JVuRinpqWVT8p6qr4hOq8t8cXXlx9Obcuxiw0Rf7jicBVR9kYfqRTIDNYO/ydSedvQtTbSmcUEKqmv3nULRUFYYvxZ7+chlNFdopJAUwMGk9ZaZGF7Z5GwNx8JQ4z3PAmcE0q+QuboEmAiS8c/TjE1IJGrk2VGEe+c3GNGAZ7AfhAOjsh8FxfZAS4CSEu97o1hQtyGdxnWWi+Ukh2sQKs1LJ/UoLruFpI/nObQmMrBBw8fsmTlDKeaUB9t5iXwfnmthwfcJ3GJRdtjQ1tV7Cu7EX26hbzVTWZSdhP8jU0dc96vJxLPtSYxKbQ7+uWjjWKUtZrN3HAvhqpUzxowrlszTjs79D8TaFMqRI84/nXEB5D3SwuH4b9Rrg9V3VJJ38pWdkeuL1kmCGoT4cJwz8taIkBuMw8KpuNjI8hBY/9MMemB6fCQHec/2kRO5u20ErSo47QwoIfP+YdYuB94jSSTEPilCD0ZTv3gLs9XKzBlTAmNg7460WEpBOlINGB87Mn9EEvf2R8eOG3erkiiSQcLKUnw41J6/EM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(478600001)(83380400001)(71200400001)(7696005)(6506007)(9686003)(82960400001)(316002)(110136005)(66476007)(66446008)(64756008)(54906003)(76116006)(66946007)(66556008)(122000001)(38100700002)(55016003)(5660300002)(52536014)(86362001)(4326008)(2906002)(8936002)(8676002)(7416002)(41300700001)(33656002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eH3t3PVuL4btjO0vowiAqmbaUDO9bvue0PZ4depT+sueUVedYEkPaj7IYEyv?=
 =?us-ascii?Q?2T4WqIugCo/Oowrapblx5tsKjCYUpMmN1wgz3Z7XHy/PQLV9qUUe0ortO3dC?=
 =?us-ascii?Q?UOKSvK1v7WLLZXAcx2WwEfxRB/nI1OvCwliO9SxyK7fkR4uumxfjzq+uHRP3?=
 =?us-ascii?Q?fCwXsaKctJ94x8a9uGkB4AON4vmzoFd4u5y8NHkcbV+CbPL0mBUreuKrVR7b?=
 =?us-ascii?Q?8SixhnppnpLB4NOStAJj8+yeQrhdB0fczcGRCyxul86f+2qFNJDO9WWPvC6C?=
 =?us-ascii?Q?X8PRPifaCcIY9/KAu+mjMq9dJeg46CNk3Hc3TWSQaGVhRLL7NfxdW0cFNCzf?=
 =?us-ascii?Q?B3ZDyHwl++gJvY9fWKo6vUIwl1QgyaQcnFh7KWTdOdeGfaSP6eWRWGDHKr8D?=
 =?us-ascii?Q?H7zVubezbDBUPtPPZMp8xXSfGNoW0UylQlh6aMD2LiN5+9kOjse+i8vycz6r?=
 =?us-ascii?Q?4Q5uZaGnYryub6GoRxKdHPUnepDf1PgWjkwcV7l+MxTm3KJtv36EtB3uHGI3?=
 =?us-ascii?Q?VN5XjG7QDn2H7yPubzTsWcvAx9SOPot928dzypt2ZkOQJpfXMXU4T1x/mCUU?=
 =?us-ascii?Q?X6qow+XVT/Ksy+OKp/rVJLAs0+GaUAJUWXLrFxgshldM+tplzihShNhLyF++?=
 =?us-ascii?Q?HY8Ef/yrgJFQCJ6HZbz0epVeRj1D1XZNKC42a8Y9tmEWL9X10lS4gaBGLVD2?=
 =?us-ascii?Q?1YfuygLYJPt8EM8Yn/Ds24FdABgnH6Ml8Snmj+fCAgmSmhm0/wRkKVf21xxG?=
 =?us-ascii?Q?m6fVn5YLvaGIxrxeu0tlJWnDCADE9t56eMXBdSOc4AC9rDmj9uGnttGPIU7R?=
 =?us-ascii?Q?AQg/NILrUjjI+bcDG1O5oHW6S8hzDfmSCSsdj4Aoq98pa+a6Szqk4DS3JISz?=
 =?us-ascii?Q?Ej+IvYBP9C6Tu1BzorNnTLsnMfJxtx1e4p2olIbGQJV9QIesJDOVuX+Md6JM?=
 =?us-ascii?Q?1be15r8HNv2JMNepT+tVDdyAXKEYXePNIrvQEfo1OIn+UEmTt8ECzvpgNw7B?=
 =?us-ascii?Q?E4xgV2TBCMo3JXImZvWiG+A6WggcXA2+MwNkzxnU/haK9BijwNj40ODTZqZh?=
 =?us-ascii?Q?By4vXPEh0qCG7fxfnqEiQOJn4qp2JnUj+Ww8Xbd1pXc8/thWf2Ib2zbEmAOv?=
 =?us-ascii?Q?iJP3xelEHDWnrM2WzRBu0AxyzIWwOzs7NJA1wQbfhZRREDLSObixFs92XWR3?=
 =?us-ascii?Q?KoA2rAflJRm/NaeN+p6lWdMix4vz1SjN+Ca0EBoGhvpvu3+OO11qM2kp+c53?=
 =?us-ascii?Q?HpoKk0ZEOuv2heO4pKzqCMC6eZHA7UYxkfRqzsK3yIMZyJhYMMctiRp036VL?=
 =?us-ascii?Q?JJZ8LivHvNgSLB6gX/Q6nA6UHiq54yWaYi796mveY/5dqk2o5pAu6yY+NXq4?=
 =?us-ascii?Q?2WQLFu7WTinWuSjzDb+k7GCdRliFpc/GTwFBDW5MnzUnmjVW2NRXhCK5s6YY?=
 =?us-ascii?Q?YOZtJhhoIRxSSsaX9Fml7DGOPwwvWKwpPpg6lxad7TW1WmkatuLy40A+gIhY?=
 =?us-ascii?Q?I2Swo8IoQC4eQkRQjcK+B7svsA8GyUC23589PKeQeFJOPbrvszjI3EJx7Idf?=
 =?us-ascii?Q?yB1J1UmZXmyfK1nZXVm9HGer69r0BE1dVPz1fizL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?BmLsXEdWQxXdPfG90rJVPLCquWVF+VWO/EAlnWeI+mdyKsEu8JjzkQaoo5Di?=
 =?us-ascii?Q?y0cXsMJXodL/u9N4NzlYAK91dSS+p5Cz5+uepBydmrPsz5T336MJp8IwmXTP?=
 =?us-ascii?Q?sz99lmikhV9C5uNy031HbXXEj1R3xn2yoUSDaymWS3BVzv4L27KMsV999cGr?=
 =?us-ascii?Q?KFLpTyu+Zjekfq7h8p2xzKOsOjhqxZAv292Pur03taiUnc+bTDQSdDGBLcWr?=
 =?us-ascii?Q?H2I70/mA3HpxRj7leqTBW6PyhCcnB+4rLs5eRG2iOnd+1BfN1JXxKDgQOQVC?=
 =?us-ascii?Q?MA2uhMrhe+C2y+jUI64+6mYhuya6GmO5pDZPdTPNaENYxmIzdTLz+kTVzSFm?=
 =?us-ascii?Q?cRaaDnCIuWfpfRMjjsQjEzmoaoRRLnpDJrhCZX3xaDvS6EyJfuue1oYSf5/B?=
 =?us-ascii?Q?pL2RJBECjaBMWLMr/ije05YjXIyG1In+Iq/gEpnXVrhQT2i999KrwxY3Qaxp?=
 =?us-ascii?Q?49rYv4B+uTmmbBy3j3gOwMk3lx1dtsZoOl+3r9syAVYHntJScl0837LiM2uB?=
 =?us-ascii?Q?UJFecMcPQTz2g20vd0KIYAI6DLiiqChz8cVEtE9ZAHGb7jyInpYGN8q8J/xZ?=
 =?us-ascii?Q?/7oks6O5QzVhbHsegKlDe7zWjD0XWA3+WcHblAQhwVboYQv/kkSxzfw8X1O6?=
 =?us-ascii?Q?IUcXF7lgPTSEiHsYNYYdWzvfMQYY+6uQ05ZBP9++cRaF0ujFeotaFOdjmgY6?=
 =?us-ascii?Q?6RBissb/Ly22z5eLG22NEuaoxJTqlGBIgokBrFFoGK05YsbpjvzFdlyXN9XA?=
 =?us-ascii?Q?NjH3/P14VTD1HzsOtoBbx9Gu1fmPNgURfiQjPa6sjn3BXrT0sPBMFR7Z8joN?=
 =?us-ascii?Q?6GHWKuiipPymWh6i3kDeQlzTQvLplqBdoxzrBal/tYxYnbM8YcGNeXt/1W99?=
 =?us-ascii?Q?AvKN+Bj/AdvGs5p/9BQTKEP+Sob+bhVBWMFwpsHL4Ito8F7GmVFRlDmzlmKg?=
 =?us-ascii?Q?0GhpvWssFJS5crprdtMQxnhCw9TybCRLT6TfVWvkgyezhcBwifJxfgtYs5cx?=
 =?us-ascii?Q?bBoD3kVaNbQ/4G+FX8kvFm8O7t6D7KmhAtOvcjHvLKZF6TQng4ZiBaI41hkv?=
 =?us-ascii?Q?o4vBclY+NKGgvEg4ii2T7DUUbPtPFmR0zr7ve/8Oem3VYksRVUA=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220f6653-ffc9-4c34-ed4d-08dbf4e5273e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 16:22:04.5993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S1D64vdTYx7s+ti7je9UJKvDcpsH6f0OsaxbrrfJWOBXwzEsJCA2Z21ks4XNuw62wJ8vTwl26O9YvA7fD5UM0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB9050
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
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
Acked-by: Avri Altman <avri.altman@wdc.com>

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

