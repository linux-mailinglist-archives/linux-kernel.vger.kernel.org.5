Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED7D77F3A5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349748AbjHQJjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349762AbjHQJj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:39:26 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2075.outbound.protection.outlook.com [40.107.249.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73312D69;
        Thu, 17 Aug 2023 02:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZ9TW+ib8HXaESGZNwadOO//2ETBqvsnxPeMp9ON5XSesxLHeuMI1MZ1HCf1kcUlYd3+xWgCpinK0XL0gJ8HSpOJdbK3aXf6fewrvycshrV+xpWvNXJraE/A4mNTNKxBO+P0dO31C+5ozuQEFFswWQAjcSiTSI7HIRNjRMRfr2Z37CJAP91uhvsKcJza6jn/hNRzR1sw6nKPVbS/ldErG5S1DFYnSKNN4bM+/fEUwquZDISbYom/Wvur92Mp4lpJah7/IFaQEGaydp+FNIyj62f+P2rQStDlBwU6TNg1ETk7Mv4NWu1cJ6dRo47DqJmiOjY0jCZH5+ZFL68mVEfggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HxecsHsHfrGY5bfFjntianLbfPkjn1ND0ItykkyWmQ=;
 b=FXaFhnmN4FpqG1Zx3bBL1Zzd2AERZmeFqixhlnbYjjun98FuhmOp8ZAw3ivK42zckRXODmF9k4g+b+9CyOIOOzzwLn2UWNZ/X0xyT6TYldSc93KbFCBYg9e6AJ6C3DMZZztLLGWIrw6DLYSxdINOShNRCjESOuLCyeNJfEWcmuWGvcvHYlNbjD/wCA1WbCRjpMZNsnJDbq2y234wFo8oDoX7jk8jnOaSmnv4R1qVp61JCRE1vHMsu9R9Bqk43nuDYjV2BZviahWGl0nZAUH4KTtlL7WpXdAGjZHiK9MUlx+QDiUKcfQDI08UkPlURn662O9q/lOWrvy96fuSRTXyyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HxecsHsHfrGY5bfFjntianLbfPkjn1ND0ItykkyWmQ=;
 b=jgZAZD+GKOESZeltil7JJW9sV2TZMYdmFvyCmqeVnxGJABg4BbOLLvHll9o/VRtFo3h5bC7q9VbRzCf78yUOj8QlQpcAPzde2VZZrNve9Qncgh2UAG1BY4ZV5vIaAE4+0jJrQKpSyBcYAYZj3spC+Df+JSWU6GP1fa7HVPWm5yM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8424.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 09:39:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 09:39:20 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: [PATCH V4 0/8] genpd: imx: relocate scu-pd and misc update
Thread-Topic: [PATCH V4 0/8] genpd: imx: relocate scu-pd and misc update
Thread-Index: AQHZzps748udueOOo0GX07/m7Jetoq/pp3+AgAAEhXCABJLlgIAAALHA
Date:   Thu, 17 Aug 2023 09:39:20 +0000
Message-ID: <DU0PR04MB941758F64FAFF5A9EBA7AD4E881AA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230814104127.1929-1-peng.fan@oss.nxp.com>
 <CAPDyKFowxz_Ndy5uFmXaTmQoY1SUNNg7-R04JUUXX0n=5FH_fA@mail.gmail.com>
 <DU0PR04MB9417C7E1BBD75E90D8755F518817A@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFptQsJqo3s4FLpnmCGmY3v2ywW1y0sCVozekZUsj7RWPA@mail.gmail.com>
In-Reply-To: <CAPDyKFptQsJqo3s4FLpnmCGmY3v2ywW1y0sCVozekZUsj7RWPA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8424:EE_
x-ms-office365-filtering-correlation-id: 73edc8b2-881a-4d93-08ad-08db9f05d551
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SLfJFL0mNdiU1qjC+QEG0DPkAraj0Avc1mjUdLgkdBU0vdmPmHiQlAR/jgu1J1VLavrGLmt7aVeINoeHTjDhksCazwM0DKD6aNmrW3ZegOvrT9SJJaUfH99w4Ap6o/oE085UbIpnLwgM49VpuupIjZqmEzICc6gDaVf5WwapvnJgZ7DGyZJArccNDEEOJPLEt+nrP9DOhBZIJen7GMBdbDDLKwxZfHUvY8j9XL5TjWVUBawIQbpQNSfXp12RLwV9IViZ8odHBW26GdNIJlhtzXHHqAPIcYGJAOQCQJfM82z9W1EId3yYLHeQRmVRqKcgSfuwby6HcPy7te5WOPK4JzUPwLmxvynfl8fSEBFgg+lkUPzjffka9TLE5IBho7PKwNVil8nsVgTyCB3KoH4X2NryyXBdJd6npN48sA3VJbq6qVqfq/NsI/EkV2hG8gJwCwKu7Gfd60ZiwmedkUKQINOayrMenmGXaB7gb0J2Fcx1SKcvcxd2WPSPyNjIPp4xnssJoYLfz/ObtU2Rt9uyCKmI6l7UzrC8uuLnn4Ihnz0a7+kcdPbF290jx79VH2HJozMKU2Q0Z/OSTk29UgrUqb1xPyBDUJANEaK4kRXZ3M72JFNtgfma6bkXLnELYLfk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(1800799009)(186009)(451199024)(55016003)(83380400001)(15650500001)(2906002)(66946007)(76116006)(478600001)(66556008)(66476007)(66446008)(6506007)(7696005)(54906003)(71200400001)(64756008)(6916009)(316002)(966005)(52536014)(44832011)(45080400002)(5660300002)(26005)(4326008)(8936002)(8676002)(9686003)(41300700001)(33656002)(86362001)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6v2/JRv4o7HNyf8JFijIlsALxXDBD0a/N4fChq3c5I1ZaVoVnx737YdTBWVd?=
 =?us-ascii?Q?YHB6UUqmLRyKkl5QtoMPMN1bPQtwx0DBg+q5qVk4Qz8amiwkeGWFrwZjgx7b?=
 =?us-ascii?Q?o9ZJtRCqmfEwIqH9mMBgXvGVMnMJZhASOKLTkQiZAdPcxHGX9fIjgrgSJDvg?=
 =?us-ascii?Q?BtGvcfKWsoD9+Ae5ITx6RxlDGpTYGhYmvkQJTdjCxiidCZbgj5KNoyTPRX9d?=
 =?us-ascii?Q?WbugJh5p66v6oSkA9ZqJxjMetMTiXX4USTjxZzp/oEhwJ4K2EqS0vNiaxUZN?=
 =?us-ascii?Q?VHhnq8YIhgEpIGcflmVyVTbeugjow3kbnNAjXeISEyiz8jWjLjGiVjVQ2mg3?=
 =?us-ascii?Q?cJ5Jsp6FQ3c/BQAu6FmL6T+vLz5gEOWDS/5ASIZZY87x33iYF/n5W2UHu9cR?=
 =?us-ascii?Q?o0/PY7OQgdZ26Vn0IsIKxjppdvkMAnooJN0RguPoPIpg8E0tq1DMtCnOHqe6?=
 =?us-ascii?Q?xwEuO73bD5eWojvYoJEbpRVmYJg5gfc0DwiBW5L2M14/GN7kNgKKU9zANpav?=
 =?us-ascii?Q?xpPP+/MXWka84rnYHMctEojVTmW5qI1RhiMfWOJHtyDbSntOEgdVflxngKLm?=
 =?us-ascii?Q?+ndeqXTWh84IME2iKv5E9cB2vhuBNXvWc/8Ev8n53hmbsWdIBkC5FvNjiiZh?=
 =?us-ascii?Q?4aXfGIiJT4Xx4rq9Ba+jr6TFeeRAMot2atl33XfcIV2YxNpprklKy5B/H+xw?=
 =?us-ascii?Q?d2rpa8ce7UEoaNsiRSrQkDSMmV+aUNg7Dr11fS7BkgYnd5/DVuVWI/NjwbjC?=
 =?us-ascii?Q?yfjPT1VFWCQqB3FHxnlZHveobZLP3ld8U+SnOtNqBdH4GrzfQkew2PvJp4ST?=
 =?us-ascii?Q?mQiSTuDgWm8hMCig4KWoSga31NGljkJbqv5nw9n10pwol+1hL4UOXKA9ym3O?=
 =?us-ascii?Q?0zWhqLOQNITofs6SV3XOP/6IsRtqLCoDTDdGkZcSE2x9Tkwy6hQOnfFEgA58?=
 =?us-ascii?Q?8+o1zCJlbgLOiKckeojPvB5AlbK96HB0J87Pz6wL0SGIGP8aHpFYCCkinwT2?=
 =?us-ascii?Q?F/VS88ZuJTW1d8QfnKUuenJjL4s/oUWxX6S975HJt8H4+3M8EfikeiMg2sv6?=
 =?us-ascii?Q?mJhU7csOawVN9kvfDfyODiym9Y+VLxCmw99o0xQuVfD1U7F8FH1chPOHYuWb?=
 =?us-ascii?Q?zEitU0qjt7QfQisbA0vv/gohSoRvWYvkIlIdRaKO3WWPbsCL0bBOmfBsE/rM?=
 =?us-ascii?Q?/6wXg4TUkScHRsTJo1CaBPbS5QwOtyxCfK23Ty3wp6/Hhu4ZLgELzYli4OBL?=
 =?us-ascii?Q?RcjwdGKe/gQrqDM9P7mIbwzDL9S5kVMB16XwYZ4E4wIMpUT7gmgfETp+WBkc?=
 =?us-ascii?Q?YcMbALlHCqU1fgf6D9163NUlwbtMrHetl9c5ThBiy+NSthrWsEhsscdL8Nz4?=
 =?us-ascii?Q?b+AH7hr7uRBzJzcXWrFz0E0F142t6A49a+KtdZZcQl+5K8jB4DuhoipqFv9v?=
 =?us-ascii?Q?4tjKFq35O3t3F2H0vR3P13ZAIBZzPylTXzZT8FLrQQHhSYWAmRW0LZQGe9nn?=
 =?us-ascii?Q?pNXTOypWbZ50cLJTUcox1ScZ7NpcoEHS0gYPvYpSge797C0PxQkLT975bZJV?=
 =?us-ascii?Q?z+u2vmxsNDKIA9WOD7Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73edc8b2-881a-4d93-08ad-08db9f05d551
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 09:39:20.5500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4dT6wdJ2yOWZmwnKjfQ9rAvyIQkJvTf8uYJ0rUmBXakkodeE9RPj7ooBDhMDvJ4lPJ2F/Oeu/HjhwKGwo3rI9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8424
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V4 0/8] genpd: imx: relocate scu-pd and misc update
>=20
> On Mon, 14 Aug 2023 at 13:46, Peng Fan <peng.fan@nxp.com> wrote:
> >
> > > Subject: Re: [PATCH V4 0/8] genpd: imx: relocate scu-pd and misc
> > > update
> > >
> > > On Mon, 14 Aug 2023 at 12:36, Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > > wrote:
> > > >
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > V4:
> > > >  Update commit message in patch 4
> > > >
> > > > V3:
> > > >  return -EBUSY instead of return 0 in patch 4
> > > >
> > > > V2:
> > > > Move drivers/firmware/imx/scu-pd.c to drivers/genpd/imx
> > > >
> > > > This patchset is to upstream NXP downstream scu-pd driver patches.
> > > > patch is to relocate scu-pd to genpd patch 2,3 is to support more
> > > > PDs patch 4 is to not power off console when no console suspend
> > > > patch 5 is to suppress bind patch 6 is to make genpd align with HW
> > > > state patch 7 is to support LP mode in runtime suspend, OFF mode
> > > > in system suspend.
> > > > patch 8 is to change init level to avoid uneccessary defer probe
> > > >
> > > > V1:
> > > > This patchset is to upstream NXP downstream scu-pd driver patches.
> > > > patch 1,2 is to support more PDs
> > > > patch 3 is to not power off console when no console suspend patch
> > > > 4 is to suppress bind patch 5 is to make genpd align with HW state
> > > > patch 6 is to support LP mode in runtime suspend, OFF mode in syste=
m
> suspend.
> > > > patch 7 is to change init level to avoid uneccessary defer probe
> > > >
> > > >
> > > > Dong Aisheng (1):
> > > >   genpd: imx: scu-pd: change init level to subsys_initcall
> > > >
> > > > Peng Fan (7):
> > > >   genpd: imx: relocate scu-pd under genpd
> > > >   genpd: imx: scu-pd: enlarge PD range
> > > >   genpd: imx: scu-pd: add more PDs
> > > >   genpd: imx: scu-pd: do not power off console if no_console_suspen=
d
> > > >   genpd: imx: scu-pd: Suppress bind attrs
> > > >   genpd: imx: scu-pd: initialize is_off according to HW state
> > > >   genpd: imx: scu-pd: add multi states support
> > > >
> > > >  drivers/firmware/imx/Makefile            |   1 -
> > > >  drivers/genpd/imx/Makefile               |   1 +
> > > >  drivers/{firmware =3D> genpd}/imx/scu-pd.c | 193
> > > > +++++++++++++++++++++--
> > > >  3 files changed, 183 insertions(+), 12 deletions(-)  rename
> > > > drivers/{firmware =3D> genpd}/imx/scu-pd.c (70%)
> > > >
> > >
> > > I am fine to pick up patch 1 -> patch 6, to let them go in for v6.6.
> > > Should we do that or defer until the complete series is ready?
> >
> > Please take patch 1-6 first. I could handle patch 7 issue in a
> > separate patch, since patch 7 is orthogonal to other patches.
>=20
> Okay, I have now queued up patch 1-6 for v6.6 via my genpd tree.
>=20

Thanks for your work.

> In regards to patch4 (no_console_suspend), did you manage to have a look
> at the patch [1] I sent a few days ago?

Yeah, the patch looks good to me, but I have not find time to work
on the serial driver part following your suggestion, so still not test.

I will reply with R-b there.

Thanks,
Peng.
>=20
> Kind regards
> Uffe
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fall%2F20230810162119.152589-1-
> ulf.hansson%40linaro.org%2F&data=3D05%7C01%7Cpeng.fan%40nxp.com%7
> C6d64514fd9b84f1d6a8108db9f054956%7C686ea1d3bc2b4c6fa92cd99c5c30
> 1635%7C0%7C0%7C638278617269111369%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C3000%7C%7C%7C&sdata=3DInU4ltSc26z2WJYFHTwLdyaoo9WqF6cZ1wyX
> 7FDpKkk%3D&reserved=3D0
