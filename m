Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B042801746
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441864AbjLAXFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjLAXFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:05:45 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2058.outbound.protection.outlook.com [40.107.241.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D21619A;
        Fri,  1 Dec 2023 15:05:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eph80xybHxlowNTNViLvBOfMMAX0SQhWhNbI5knh5IPGH7rVAkfDUYSDbrKsdz+1H82+FCzDAha/0ka5JgPx3MNQgrkV5JjaR0bM5JGzvSEYirmBUvxon7/itOh/zs8fBXW9Tm+O1AMezQ7LpsIbadzWjMWXlwXHRJxVOXLr6uFWifmY7H+O0Cdo9IHz+vbPlclg6owFfrALkNTEWi6vN9973cEDF/tJb+LfeRXZ2Ykd8y3AijmCCFqJVgl8pqsM7SnZKv3YRIdchyqA+bRK5De/J4iXhGMITGmOi5a14H5gXngAIk3o0uxJvzczCOgHT99xDdGhRywNCu434Yo1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIf+YKhmGz3ApciR4E/FvSgEUExpsnaEuPtww00r9/c=;
 b=X9sgMFjz1P/BdqRazEjTnfhHkspwbvzshAmf5tFHnv0yE084LObtKJzcBdRtgSToA8gt5NdRBL6pSGLXG/2FpQQ8HcWWS0MeIww/ne5nZy6zEa1vC03ORIxnvqAEi5hlJekz6iiQUJJzpc2QHzCbS8zpc/g0pkWTsM1/opM9GDg++1zkkFi8huzrLkWSPLtrECGEzr0XHpDPQKsPpATxDSw5nmDLE2rXtwv7RpO+fnyWUtgHfyFZKMZsQgcKnUnfU+sL2NuX1sTvRy37zLXpqUXv4ox5NRWGU8Tr/PifgafQe1SOdnsK8lrXQ8DVTCd+XnniN8xRMCwhprL1B6rGqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIf+YKhmGz3ApciR4E/FvSgEUExpsnaEuPtww00r9/c=;
 b=OCaI6AGIeDUZx8g7Tnz6vpizyVy4X3HEWBReUmcdN/29S6z4+3lvW4iuUXvsP7HiNlCEfCwaUdEQIRiO5FY1V03EMCx7ASh6Te56TgQ/Yw3vjlxaU2wG4dcPDkQnYvJUtH6ELmU8W1VHcFXrqu9js9xUFyrpbL/m0DwJ+X+gpL4=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS4PR04MB9267.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.8; Fri, 1 Dec
 2023 23:05:47 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7068.012; Fri, 1 Dec 2023
 23:05:47 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v7 00/12] wifi: mwifiex: added code to support
 host mlme.
Thread-Topic: [EXT] Re: [PATCH v7 00/12] wifi: mwifiex: added code to support
 host mlme.
Thread-Index: AQHaIdVRwVjPeSM2JEKuatsKwEyar7CUVRkAgAC6w/A=
Date:   Fri, 1 Dec 2023 23:05:47 +0000
Message-ID: <PA4PR04MB9638E6F1128DE4ED977E0D07D181A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
 <ZWnIMGytEdDCySS8@francesco-nb.int.toradex.com>
In-Reply-To: <ZWnIMGytEdDCySS8@francesco-nb.int.toradex.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AS4PR04MB9267:EE_
x-ms-office365-filtering-correlation-id: 669ebc39-8877-4c14-c5b5-08dbf2c20dff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IRGsk44QQGoQYyCD/MHIRR9Cf5YfUhBqi9MCsKvpSrEaJ4gHaKhvBv/VBlvyt1t7sDgrdWOytShKL4xwbtgmWu8jt+0gN91OOHKMuhvlgAfTz+AfA9HXyYxYUeiP4RN+exZtvbEMcrjDpDlFPBMzRb1qFWH/KyKR4F+LAUhJILXDdpG54ShR9C4k+h5pOZSK1Smfi3t9o7NjtJf6P1hx3lB2DtpKq9MQ/TcxffBVHB36nk6PToXz3DgBoJg3nZc03qKOWAVLNO/GCEXYg2R1TxCcchY6/sbnZEEQ05hHr0Aj2bmWSNezBL9+HdsHxjKMayEhifZhhBdVp12mCdxsw/luVwUh8g1/21SmVoLlStPqyUJvJM9JBMMcDmcmzSXxW9pn6KDBnZBgK0iDg6QmQuhA+mkxy0zHCRyCHQgQ5PRC5J5TmD51mXTghPOH8KrCn5pLpzgAm0AKoHetR/Gj9Ko24wWI3sbgbslIRsrBckzkKAQncLmqSOniS8/KZDVWslIOSUd5uuLPiEZ8B0DeYAJwDokMFGzUzKqe8p46iBQGeKzkiGByTeiOt9LQHWgyWsO0gSbqwa2L13Z6/QBN5d28A/6B989lHuaQ1G6v7D2blzyPTQBmovz0hGr+ekqcugyZVZ1P5ib69zQ0/yc5+HwLlCueKv2ZRjaBxqGBGTM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230173577357003)(230922051799003)(230273577357003)(451199024)(64100799003)(186009)(1800799012)(55016003)(38070700009)(54906003)(86362001)(64756008)(66446008)(66476007)(76116006)(6916009)(66556008)(66946007)(38100700002)(33656002)(9686003)(83380400001)(26005)(6506007)(53546011)(7696005)(122000001)(8676002)(2906002)(966005)(5660300002)(316002)(45080400002)(478600001)(52536014)(71200400001)(41300700001)(8936002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XQ2hkEDJRsobu21KgIzPRktt5pq2KlS5JVDMsgGC8EMWzmwx3wYvhVGDKUT8?=
 =?us-ascii?Q?DkMlQOzfpZzaKRuUqGqodaPVFwjRgoj1NfE8Yv4L/5XCvDaJBIYtsaeax/if?=
 =?us-ascii?Q?GGaB3Uu/s/w27kQqdlH8vCK6FPduKu+mP9n6zcCJ6drl0ptoIozxpQSpBcS2?=
 =?us-ascii?Q?MevE9zs5qCpz+v/FphSKzeEtS/k7rA0f3DJ6WOlEHZr22jwR6x7iq2IWo59y?=
 =?us-ascii?Q?logeCWUGVSjPQpbIPTv8ly4PZNe/bnPm33yvMDmEbOBkV5C+jjRZdqgc90y8?=
 =?us-ascii?Q?ibk//4l+4DwTWK2gnNIUTUPzjJloax9p6VStbA+WPUKu0Wte1boORWBBtaC/?=
 =?us-ascii?Q?RgMWKDrz/b6R/hdq6nIoRkWgHIPNSnJshxlNNQT0gHlkgAnJODv/a09r3FCl?=
 =?us-ascii?Q?MgV1vpoIdv3lifaKKm1gWR7iRfsH5mHn3f2AWPfVaXrOPTCP3PEq7Spmlb+x?=
 =?us-ascii?Q?RjhJG/AXjRlxCn3pblJxyLBWgzv9oJCFUcHklj0bprkZxaPP7+ZJeOHGhx+u?=
 =?us-ascii?Q?tJyUitjh2U5o8xMNHigv2vfYE/fP4WUsWGnlCriSrgWt05tiZqrccMdnvNpJ?=
 =?us-ascii?Q?E93pZrrdmKk43zvWY6Z2GCtzL1tHg7z+4374IHC7ejNmaSHg6EhfFEzqV7Uf?=
 =?us-ascii?Q?RFDQwwYLVlu5D6xKtuwgDKWoIuCi51d25E5Ub8D3yTpZjZDSWT8XRQqmPpKX?=
 =?us-ascii?Q?9n+R+n/5O0jgM7wQWYE0pfdG4JTSXCsqfQPkDvt7taiTv1ec38z9TegUVUIG?=
 =?us-ascii?Q?6QN87GM58lJMnmglU1gfN5mI5A6DEpTHrx2dll//+jGqREAt9s9etqYAdwfC?=
 =?us-ascii?Q?b/flo/ckEu9MveAILigpZ2QVjTbrq1lvjf2LYJv8IKu3UHFGCX3SiMtC4P6R?=
 =?us-ascii?Q?g6ba3htrY0YbAkr2Fba4dUrQPKSKxVE/v+wDuXMRAWEqgJna9dDImhhR3YaL?=
 =?us-ascii?Q?sEe2xQtLosVneqLK5dyuwxT2X6nM6IxkFwfMdoT/5w1ZSeR6kJ9wZGZJKoKg?=
 =?us-ascii?Q?wLxSXLr+o+41pGYn/c8UTF2XFqArpjBL0OWHmowKD/zoIzebhgiZ8Y8m/qYL?=
 =?us-ascii?Q?/ANZeMTQd73HgaGNmNb+fvf5a9s29Y3mw2DqDHFI2+60xWxGSEfWjD2QSDRH?=
 =?us-ascii?Q?PGkjGWgtTc7JzvGLYPGvNTDoUXq/NojVqxzGM0SJeV3Wbm01D3InEss5QFQm?=
 =?us-ascii?Q?DcCCSmLAYNeeqAFqFJQhmxrIotyJuwS3ncE/ulOtLgTJB8+gAn2HmA9vk0wJ?=
 =?us-ascii?Q?ipOovnJn4Ibh73F7hnoDk21mlcT3aUcgOK2bIroLMm78iJHhumHD6NWQZvXd?=
 =?us-ascii?Q?Cw8W2KN0NHbNrDBgyDeAOHRctmwCQRXH5s+21gkb9+X9zEIsnhMAaE2BMZQK?=
 =?us-ascii?Q?L6zMlE1UrY9hv79ydP1mAiZ5T+t3BF18c0TLgdxpxFoF3PVO1kITDweHcKHd?=
 =?us-ascii?Q?RWr9yUbGGD53LMNlK3IcGrZnVzz6gkpLRwqurBblVxHjtgfbrCS2Zydl1ZOp?=
 =?us-ascii?Q?3bqPjMzogYv5du1b67pz3d10X2W1kD6NHNo2Tdt53B3ci9LUGkVVgxGRjQsI?=
 =?us-ascii?Q?6CQqG2e2NtU/ilxVmtysVefcyn5TdsAURzFbGIZ4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669ebc39-8877-4c14-c5b5-08dbf2c20dff
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 23:05:47.5315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5zkiCe+q2Gz2gbyu9lYwhueVlgsPbkPkPdLxMqPKLmhJQkog8+38vDOPbTh1Ut8wR0j9d19S/6A817x0HCE7kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9267
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Friday, December 1, 2023 7:49 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH v7 00/12] wifi: mwifiex: added code to support
> host mlme.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Hello Lin,
> thanks for the patches here, I can clearly see that this code is going th=
rough
> some real testing given the improvements you did lately.
>=20
> I have commented on the single patches, and honestly I did not look into =
the
> code details at the moment.
>=20
> The major feedback from me is the following:
>  1 - you should not add code with a bug and than fix a bug in the same
>      series, you should have a non buggy patch in the first place (e.g.
>      git --amend). (this applies till the patch is not merged into the
>      maintainer tree, of course).
>  2 - point 1 applies also to reviewer comments
>  3 - if you have fixes that are not connected to the feature addition
>      you are doing is beneficial to have those separated, this makes
>      reviewing easier, they can be "prioritized" to some extent (given
>      that they are fixes) and follow a slightly different patch flow
>      (they can get applied, depending on the maintainers decision, when
> the
>      merge window is closed and should be backported). Not to mention
>      that smaller patch series are appreciated, "Maximum of 7-12 patches
>      per patchset " from [1]
>=20
> In general I would suggest you to have a look at [1], not sure how up to =
date
> is that compared to the in-tree Documentation/process/.
>=20
> On Tue, Nov 28, 2023 at 04:31:03PM +0800, David Lin wrote:
> > 5. Address reviewer comments.
> You should list the changes you did, something that generic is forcing th=
e
> reviewer to compare v7 vs v6 to known what changed.

Can I summary what should I do and hopefully I can make agreement with you:

1. Separate patch v7 6/12 as a single patch.
2. Merged all other patches as a single patch for host mlme.

So there should be no patch v8 and only have two patches, one for host mlme=
 and another one to fix hostap restart issue.

>=20
>=20
> [1]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwirel=
es
> s.wiki.kernel.org%2Fen%2Fdevelopers%2Fdocumentation%2Fsubmittingpatch
> es&data=3D05%7C01%7Cyu-hao.lin%40nxp.com%7Cde461eef26c44e28e80c08d
> bf2638639%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63837028
> 1495779090%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj
> oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3Dy
> OW9SndPm%2FDuI%2BZU8fxBieerDxVZp5RzefQiSfFA%2BW0%3D&reserved=3D0
>=20
> Francesco

