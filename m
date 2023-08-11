Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8487A778FFD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjHKM6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHKM6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:58:05 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA0B26A0;
        Fri, 11 Aug 2023 05:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8zat9OrROUrBbzp4kkPA1FZYXt8YnoTUKS7YjMFj6NUiqf0h4+c9KWvtoCEH0vvsFnjCAOdjPZWUzsDUZM5D5M0qvA3hldFGxsirCys+6Ee98oFxjKqUMKcC5VOQOWK36SgenTkhe2exkM7rVGvXYkWSzpfA2/68or/uIsZQG7n5fFH1IZSV/PDMbbMeMf8Y6/o9p3Q3KeKZXvI8SLQ3f55p9IcN6aNth+F3XOYWEXrt6D3TSB1kOGmDi5ADwRNjrL2W1sHOp4TLQe2lHPtpAD14AxnNhKPPs1XC811PBpRjJKppjFKA4AN5uXeCitJ4BJzh2D5u6taFpa1gypYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7UcXP7IPTBWc5ptFAGbDCeQ9XdsD/nzplAN5Bdxomc=;
 b=faN+SlZaBhOcaVRakn5SOJheNNAaXfy3HOi6e4K+SzJqroimfNaOp0WITWVU2NGnzkfSpOYnq69V6mAqEx6v350bMeSe4vISzf/h0RhWAQxcJrl+RAh5gv+Qs6obc5AzKB56Jdy+T6J7VzrccWIVuXtqm6pmaH50QkTga2Zi0etyJj0LL3hW1WALe+oWH5CIkEAAjujWvhvr51zY+QhHhaYoQSBOBki9kaL65gPsgZnAB/l2eLGoZUeEIXhCbvaOw1UZOGbNdbY1ieIeSiQFCPPlgVxhovCbN0/Kd3uspZt0yPsIWvV5skxvadXEd2MvDl/cSwnvOj9uyOClFdoYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7UcXP7IPTBWc5ptFAGbDCeQ9XdsD/nzplAN5Bdxomc=;
 b=JpSEThfVUxvp8U/WXbGxnP4iDk1wtv4LCfpxZj4np0YPn9q4cEEZ4WaZPd8qQD1RKVisgDluJRnLsOHsvoHthzlH69Z6n68RPZ2VsvzzBa7JS4Gq4UiW51XjRVsU85DmiefCF/wLY2JkKDhraKy7I2dIjAkNkqwDX25wfA/EdyY=
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by PA4PR04MB7616.eurprd04.prod.outlook.com (2603:10a6:102:e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 12:58:01 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 12:58:01 +0000
From:   Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     Bastian Krause <bst@pengutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Douglass <dan.douglass@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: RE: RE: [EXT] Re: [PATCH] crypto: caam - adjust RNG timing to support
 more devices
Thread-Topic: RE: [EXT] Re: [PATCH] crypto: caam - adjust RNG timing to
 support more devices
Thread-Index: AQHZnQeck2v36DTv3UmJ9e2grSaJgq++HokAgAFf5ACAAWGXIIAHwLJggBGNPoCAAC8BgIAKyfWAgAAvDSCAABYvkA==
Date:   Fri, 11 Aug 2023 12:58:01 +0000
Message-ID: <DU0PR04MB95637DD95D05179F36AFAF958E10A@DU0PR04MB9563.eurprd04.prod.outlook.com>
References: <20230612082615.1255357-1-meenakshi.aggarwal@nxp.com>
 <e1f3f073-9d5e-1bae-f4f8-08dc48adad62@pengutronix.de>
 <f673a09e-e212-ee7b-15c3-78afe8c70916@pengutronix.de>
 <DU0PR04MB9563E31E69F93B63EE83DD378E39A@DU0PR04MB9563.eurprd04.prod.outlook.com>
 <DU0PR04MB95637D86F0134DC26EF955DB8E02A@DU0PR04MB9563.eurprd04.prod.outlook.com>
 <ZMzBWXpvdW5YB8bt@gondor.apana.org.au>
 <AM0PR04MB60046B045B5965A61BA1CA91E709A@AM0PR04MB6004.eurprd04.prod.outlook.com>
 <f9e34f8a-5a7b-8223-c672-4fcb2bb23c0a@leemhuis.info>
 <DU0PR04MB95639E903580457856250C008E10A@DU0PR04MB9563.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB95639E903580457856250C008E10A@DU0PR04MB9563.eurprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9563:EE_|PA4PR04MB7616:EE_
x-ms-office365-filtering-correlation-id: de03c170-0e44-4c64-0844-08db9a6a980c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: opKeszmZYZ4t71i61Xm7JS0OpniwHciZNqd5f8ZELQ4Ha8y/rf53ZhdeLIWxzkDbZKSSg/GyIsZ9jdyLnTfZhGXJ3T5YC7xfzt6b99idK+8Wl4E8eYi8BS57ELWGAZIHI8PdvswP3chBRP2hqtWdeoj34bno+aqoReveGI29c00SO9BOSUuNrgFPiV5S/4pDg9Y6BRPklm7BDweGWlP+zEpkLLXwZ8nN66NvfZiG2FFj/d7N5srQkK+//BdFa6kse0+rMRh2x5NyZwOFdHGw08i9XuBumM6H91Lm3N2X8AlTcCDM2RheVKjq/8irwwYOSoLZ4sGtchONqnfrMNBVE3GZZ8vYNwgzq+tWQmtX1KYrK2Nksa8QN7Tga5ogmsiKPj8wCEscvUG8BlcIB02Z9rbESSCcaFFn0tBGQ5eJu8aPrmuQ9u7YAs834kviu6QssKCh6254XFl8uSK4BITF1ZQpFOIo2/LJ8u1gr5/jOwW68vaj6guUjejN86ruwEzRHJ3s/jv+Qqg0b1cmv2Umlj79GbhMeLiG6FdXKulcG3WR76dXvDrEfSyN78EXFfAi8Dk+0yg/vszAoQUCDSd46rOpQ+SKDOGHs7O/pCPBclVP6TpMWnpMW/bf6V0SovmX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(1800799006)(186006)(451199021)(8676002)(26005)(53546011)(86362001)(966005)(38100700002)(54906003)(33656002)(9686003)(110136005)(45080400002)(2940100002)(2906002)(122000001)(7696005)(6506007)(478600001)(66446008)(76116006)(66946007)(66476007)(64756008)(4326008)(66556008)(71200400001)(316002)(44832011)(8936002)(41300700001)(5660300002)(38070700005)(52536014)(83380400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yg5AqnAaYIfRQKR+QEhOwKbok+eoI2G6iGpGJ0JAaUVTvt8iCA5RQlf+vtb/?=
 =?us-ascii?Q?XEd45xSXlKLBMdrmfxlhUZIT0nmIpQ/x4QlWcDQNqpGKFoDMcu7gQ8rYc0Wy?=
 =?us-ascii?Q?H1IbHA/OZfrYt9wvHoUbt745ubEXuwEYKNdfPQQYj6J++n+tIY9/9Gbsf1Qt?=
 =?us-ascii?Q?jFngX0M9FEBITf9LQEiulW+iBa5zVGKEVBJSzLuF8rHV4Hpu9yM5dJCfLVHo?=
 =?us-ascii?Q?K4GQHy4RLfSD2whP3Sfc5ONt+U09t8+PVsqPZc4ZeYxhMrggrD8KjK1fSK5D?=
 =?us-ascii?Q?PDneqxyF4yFns1O5IHjBlrZdx/JOySPSgi5BhBvje2mXiQ3nvBRRsU/TCPR1?=
 =?us-ascii?Q?2ZdD/9eMYokjX/7VdWcB1KPbpjVCDf5iWo9JFoMggrgoW/5vNenTx5/9JNtR?=
 =?us-ascii?Q?yqjNOX3gkD+IHTGO3tYkT8xh1IfKQCsHckQTgsyD/T4DNg2fx3UOozex8Ri5?=
 =?us-ascii?Q?ywtnrpiNRaDi2tryDT+9ziZEdjUvZhS8L9Vi7BR6+c1SSgHC8C4//SI+nAIf?=
 =?us-ascii?Q?5Ul9qepBqEfwyNoljxvEPUua6jZXumkv9sxVY4TH3IrmJh2u776l93ekQ1MJ?=
 =?us-ascii?Q?/lre3QOP8lS2nQ4aN3nX9HeiEgT2w+k9hXqbvTbVd/dL4A0wQ8YICygE+Hjj?=
 =?us-ascii?Q?5aeVOYVzfUVXgzN3ASLp+6Gwq4xQvN9SFTzDmdMFU58Ox3b+IDw7aLhJdbP9?=
 =?us-ascii?Q?7rencZE+GoExIO6k4qzszXeuDdSguEWcxpSjNObqeHAGWpfS3TuUsrj4/IeW?=
 =?us-ascii?Q?0gizKOJGBf1Y+klBcVs6bNrusyTUI+74Y7uU8QmucaP9yqUS3o28gfi3fl47?=
 =?us-ascii?Q?KD28r/aTuVdDGNIQOYNr78slOViUDqtrrjTDS5eHLtshIiGW0CxEq4FA8C+O?=
 =?us-ascii?Q?siT+Yyvxwp39oO/sP0IVB3pszRO13ANwZaoxWyskVgQ2YznZX7uodWH3/dYd?=
 =?us-ascii?Q?yehTHYF27gceE0tE12WOAjSkcxEauuYPkFaFo/W3iq5JYfTkh65iWyoMDPPc?=
 =?us-ascii?Q?csVKvJ0y/KTNs0slb/VNVEEjkgnXCghIqrtPxoEteYvSyxYf7hznL/ZrVxFe?=
 =?us-ascii?Q?OG9TDMlQRI8KCLYVurNbsitgiPy5TvILUE7qmDOckECgYpHk3tNycs7l9NnR?=
 =?us-ascii?Q?1a0g2N+0EbDdwqm4e4rVBNTwTsgDpPya6VRLONIyGU4dKVW+AkJCAIrMIY2s?=
 =?us-ascii?Q?UCd6U2bKNwL/jqXEbCQDkAJcXLT5RTZhvT4Q4BmNEUXIfPsbkNe4sSDFc4r8?=
 =?us-ascii?Q?yzvKH4rX9vCEqiqQ1Vz3he8VgWpueJ71FEXCYjJo7MwlAIFZzerkzqytqoiY?=
 =?us-ascii?Q?/D3aVzTo2gxbH7MCdt8UtERCkMkHVxEA3EzBdyRWZOLu9S24itOm5TbDRM1B?=
 =?us-ascii?Q?TehCG/ZZu9Hx6URspYEAF5Tbl1rXoLB1pLrkwhQRSiDLwpDq18MgP1MfRNDU?=
 =?us-ascii?Q?QbuJuNjL9ZlGrJZAuWSs2vLWIAuwGTqOy1YOHWnt4+x19EMkJUliDhCtRxUl?=
 =?us-ascii?Q?uXQQamN1QKjbwoX9I76CQ0JmYlk4VYnm2/qVrTOaUbMWsf+cgWI+RKEFNF1r?=
 =?us-ascii?Q?qbeZQJz3P4+VSqasFqBFZBp3p7WVOKObQ8J6BQwhjAT/52U0Elarypz/LH2A?=
 =?us-ascii?Q?nA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de03c170-0e44-4c64-0844-08db9a6a980c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 12:58:01.1103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bYCBmu0EE0Hpl2drtTWdX6F9VxjbK5/dh4toNzZz9rc/wYAEvQ0prcyquX4zHFEp9saFzKm2OHlkbGb5B/5OBr6C/eUqqo3KTKh14z26qQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7616
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We discussed about it and lets revert the patch for now, as the tag is to b=
e applied this weekend.

Thanks,
Meenakshi

> -----Original Message-----
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Sent: Friday, August 11, 2023 5:25 PM
> To: Linux regressions mailing list <regressions@lists.linux.dev>; Gaurav =
Jain
> <gaurav.jain@nxp.com>; Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Bastian Krause <bst@pengutronix.de>; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Dan Douglass
> <dan.douglass@nxp.com>; kernel@pengutronix.de; Horia Geanta
> <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>
> Subject: RE: RE: [EXT] Re: [PATCH] crypto: caam - adjust RNG timing to su=
pport
> more devices
>=20
> Hi,
>=20
> we have tested this patch on multiple variants of imx board and it is wor=
king fine.
>=20
> We are actively debugging the issue, it is taking time as we are not able=
 to
> reproduce it at our end.
>=20
> Thanks,
> Meenakshi
>=20
> > -----Original Message-----
> > From: Linux regression tracking (Thorsten Leemhuis)
> > <regressions@leemhuis.info>
> > Sent: Friday, August 11, 2023 2:18 PM
> > To: Gaurav Jain <gaurav.jain@nxp.com>; Herbert Xu
> > <herbert@gondor.apana.org.au>; Meenakshi Aggarwal
> > <meenakshi.aggarwal@nxp.com>
> > Cc: Bastian Krause <bst@pengutronix.de>; davem@davemloft.net; linux-
> > crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Dan Douglass
> > <dan.douglass@nxp.com>; kernel@pengutronix.de; Horia Geanta
> > <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Pankaj Gupta
> > <pankaj.gupta@nxp.com>; Linux kernel regressions list
> > <regressions@lists.linux.dev>
> > Subject: Re: RE: [EXT] Re: [PATCH] crypto: caam - adjust RNG timing to
> > support more devices
> >
> > [CCing the regression list, as it should be in the loop for regressions=
:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdoc=
s
> > .ker%2F&data=3D05%7C01%7Cmeenakshi.aggarwal%40nxp.com%7C84b2ed6da
> ac44625
> >
> 779408db9a61d801%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> 827351
> >
> 7248142302%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luMzI
> >
> iLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DOWH18Cwu
> h8zyAFqn
> > I6iiL3Kewpj5NiWaQorKcmiYrr0%3D&reserved=3D0
> > nel.org%2Fadmin-guide%2Freporting-
> >
> regressions.html&data=3D05%7C01%7Cmeenakshi.aggarwal%40nxp.com%7Cfde9
> >
> ceeb9e0d40d4f77d08db9a47a5e1%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> >
> C0%7C0%7C638273404742560069%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> >
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> > %7C%7C&sdata=3Dlt7nphOXYXc3GRfOquvM5jmqNszQkDd%2BuSRdAbJd8Ec%3D
> &r
> > eserved=3D0]
> >
> > On 04.08.23 14:02, Gaurav Jain wrote:
> > > From: Herbert Xu <herbert@gondor.apana.org.au>
> > >> On Mon, Jul 24, 2023 at 05:13:23AM +0000, Meenakshi Aggarwal wrote:
> > >>> Please share the required information.
> > >> Any progress on this?
> > >>
> > >> Should we revert the offending patch?
> > >
> > > Debugging is in progress. There should be some mismatch in TRNG
> > configuration in customer board.
> > > Will be sharing a patch to dump the same.
> >
> > Any progress on this? Afaics would be good to have either the fix or
> > the revert in by -rc7 to ensure things get at least one week of proper
> > testing before the final release.
> >
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker'
> > hat)
> > --
> > Everything you wanna know about Linux kernel regression tracking:
> > https://linux-/
> >
> regtracking.leemhuis.info%2Fabout%2F%23tldr&data=3D05%7C01%7Cmeenakshi.
> >
> aggarwal%40nxp.com%7Cfde9ceeb9e0d40d4f77d08db9a47a5e1%7C686ea1d3b
> >
> c2b4c6fa92cd99c5c301635%7C0%7C0%7C638273404742560069%7CUnknown
> > %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> wi
> >
> LCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DXg3ZCWObptmF6xLKO7dpaIYB
> > A17eKK5wNhlPZ6FR2XA%3D&reserved=3D0
> > If I did something stupid, please tell me, as explained on that page.
> >
> > #regzbot poke
