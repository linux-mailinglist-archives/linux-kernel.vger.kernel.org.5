Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C7E7B5848
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbjJBQ1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbjJBQ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:27:00 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2044.outbound.protection.outlook.com [40.107.15.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB06A7;
        Mon,  2 Oct 2023 09:26:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZuPjcUDOuEq/hCNAXPaS8CZl6kMLSZnML1rjypVrWHUFawKnr5EP688647o+reSvNL6mzMPMU6cCSmHY27LDtUiocrOj8ZSHqBxjD27K6PKOK7AsCeMmVFwBdSk3SqaeBK7egMqivUnKcDZR1l1Ln06JK38UTsKrogceZw0YimokKfN9DN569xXzADYF2GPhXCWJMEIEjySeg5Nc1Ut0kJ3JD/+pwgulXIANhdV5+bWGVwfxO68GPWBm5ZoRdkBTt34fVE5xgY06gihhLW+Ufq+4QOxQ0i1gpLKH6rry8jPr4eO45cJ3LQTJQKpfL/3AslWk6DzItmAmAtsMKi5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBunxkxc4zJovds5pOowV+d/GkuZ0gNyc+NbCD6HMuM=;
 b=YhrdsMHqmIvoP8aGrDJsyJTSwJ0a1CoVW8ypqyUN35dMlM6OAmZ5jRPHhK15pIi7iMTtpkxtSOYTCA8bHZTJYaOS05kLQ4r0hHi8pdS0MU9pnXXxSKUreKFTR+QFSSjFLATONRFDfjqgsy+sdhbB6QBpGiAIQ9mHQ2LFpS9w17OZ0vGEK7dWALivTsVI3nqAKTwlMaGvmSTG3L/+JRLzIg21zzaoOo8yTCJGtefjDeud8Wmy1mx1QZvw8R4C/0oq85jDAYbbOlBP+ZBbiyKoX006YPpczBkUW26ptzOI6h6OzlVNE82DtcavOPTMnzkDbWHGrpCQgmfyhbEiwFILDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBunxkxc4zJovds5pOowV+d/GkuZ0gNyc+NbCD6HMuM=;
 b=B7bfXFXSPMNUu8PjtSI0lK5pm7hLHaqvR4nszc934MDuk1lH4GOVvsym8qGPJKEI83a+T7XCWMrRaFxuFid94FAfQIbzadhDTtwpkhv2dBMBxkbY+II//IdcE7wYEno3ywcIYjK1mYk+lKa9W3AP63A1dbvU/wR2b4eR13dZRwc=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS4PR04MB9624.eurprd04.prod.outlook.com (2603:10a6:20b:4ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Mon, 2 Oct
 2023 16:26:54 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Mon, 2 Oct 2023
 16:26:54 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: [EXT] Re: linux-next: build failure after merge of the dmaengine
 tree
Thread-Topic: [EXT] Re: linux-next: build failure after merge of the dmaengine
 tree
Thread-Index: AQHZ9UrkFAVeXpPWIkGDVr10dGh5VLA2r0eQ
Date:   Mon, 2 Oct 2023 16:26:53 +0000
Message-ID: <AM6PR04MB48382B21C39B68B933E9A38B88C5A@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230929131324.6bb84292@canb.auug.org.au>
 <ZRrrToewRnOYGOD3@matsya>
In-Reply-To: <ZRrrToewRnOYGOD3@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|AS4PR04MB9624:EE_
x-ms-office365-filtering-correlation-id: d7854b66-c476-4783-4fa9-08dbc36463b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2yaz/v4sBC4xiK3hpCnYPzB/1Sy1EdmvoNd8M0WduP2tLbm2X1e1PYXY/yXZCh+t9Yf2is8jNlAHaRV4k5sLhqneK7x0gChzrJMwWdwplojAv9I7YIudBUozVNyjqS0+JaN+9GnrD5eNq+r5Ox4v+dps+CbCEN575n59KOWeFiQtcpd1qfg2tB94jC44144Bm/aWSEGa/lJzCZkyVfgNWYcXbFr9Dwf5ikfPQDHNohWf8GiXna47imeNz5Se/qLs9f35F1VsjDbNKZQ1t0F4d77tH/NLv7DE2WX3PbD4Xs4Cgtlb00UWipaaLsAUvC865JEWjCO4ITHUf/Cc/Lc6t9IlUmk9xFF7yasxro0TKHBKasAoJvKoj5uJWhDnSZBzukEBFv4Knmk1siY2IcBs0FmRDqySd59PONzmamnMIv/zOgjnj5icbNqn4oGrNG8kUKq/Mp2lyQTnEhz4AOSHN/N3W1X1Tyf8GrxZQz/DlxAoHstIM5h9tZnv3J/O2qFqDjIh05mEzaRS2cjiZ2zed+DQX/9E+yXGMo6wgm1Zm8qTxemVgPrxHWiADzybB1fc9DPu4QMDFNtNGdiqG96l7vlHCOv2bIRr2HL2GHVdwws=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(38100700002)(2906002)(55016003)(38070700005)(55236004)(26005)(9686003)(71200400001)(7696005)(6506007)(53546011)(83380400001)(966005)(86362001)(122000001)(478600001)(54906003)(76116006)(66446008)(66556008)(5660300002)(66476007)(110136005)(64756008)(44832011)(52536014)(8676002)(66946007)(8936002)(316002)(33656002)(4326008)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AoiIHRd+eBjaHxE4cQB9AH02iJLkWYI3nyKT2gZpUaBl3YVqVGSpjjjS3Pza?=
 =?us-ascii?Q?P7VR8m6FfMVPvCpVGHztzcw8Lry6pHp0Tu8OmJps/7fCmZ17ow9GwoYYIa6T?=
 =?us-ascii?Q?QJdIVNgno7o5RrtemQPpqXcTqtIy7VEywy5X2ga3WSj/WGjtgJ4g2opHb2Fc?=
 =?us-ascii?Q?zQoqAVIjER26txoy10ugp9A7sN45WqwfnqIOH9FfH5dnIKrXbIq8QtdD0Hco?=
 =?us-ascii?Q?4RcQVRfLHBGTMBaOpUqN5fgrthFLel9m851Mf1Ai5+7417/0EN5Dj1Zms8Fd?=
 =?us-ascii?Q?+YgWdEIz0Emjdsq6wyj0zYXWsqJgKHjk/tWsnMl2BEkiky5ulhrHCJWwOvIT?=
 =?us-ascii?Q?7DLCVXV/wNTNlG7iw9aG97UWMRRs71n6vT8Uu7ZvEkO/J/VrSl5fCcpBm7lD?=
 =?us-ascii?Q?uX6R6v/76MC+oyYLUnd+IOIugWTf05sKOLGFt8dFfXQ4HZV1lpcgKn3eZc/W?=
 =?us-ascii?Q?nUEksJmL9HG7Ys6iusXMtwXte7NYQ3MzfhaGM1AnPa1oU/RnZWoR6gLP6WRz?=
 =?us-ascii?Q?ZS220h8dz/Pt/rGxoYDmtWSyLhtElyrxc3eZDEwGjEmP5pXs9CtY7C5r0jEp?=
 =?us-ascii?Q?GaBEt+8ZJIkk7F5YyRjSo3/EbBnz1YMWjWSipZTGF2nE/QQHuCSyYLs6fr2Y?=
 =?us-ascii?Q?WOjJOC0P87zMxyew51OW6pKErtyIa0J7ECWvCiCzNZxo9ASfkfX1ur3xS8lY?=
 =?us-ascii?Q?xFyaMv0HYcWdOTtSxcoV/2AAsnrOinIPFxkwRt69lD4jyki16MVZPhYDkDnp?=
 =?us-ascii?Q?3k/QNuEcYjZjVjtfEajYBS3y1X8EG0iQbkNjDuaXg46nIgFYKTMyWyKDRdyW?=
 =?us-ascii?Q?faFxCCOQqcDEaa+VhHVjWtwgbYsvaxmqAhF8+jKCgs/him9agR0Z7mkdLnDA?=
 =?us-ascii?Q?/56DbPjpJqBpdMglcUDgNPjl5pPEPgYbmXvf2mqzbKHyCSP8bepeP4mYe86R?=
 =?us-ascii?Q?LtkNFAJFNVB6wKg6j3j6I3nlMJD3JRjO/+9XuV5DfFai7/sLt/Z3iHn1KuRe?=
 =?us-ascii?Q?50zXvUtiQb36u52sejnhEQiO1NRvUdeIOihzrnqms6RSY9L8UOLBbjJsgMWV?=
 =?us-ascii?Q?rBFJYckk2TTX3QNFsHfiYas+lptFdayy19vQv3KltGcGzgDuJnD2abkb8qi3?=
 =?us-ascii?Q?VE+GB0N+2lNPpUv56J+ApT5Lj8Z8j6cpJb6O7BVwpSB1ntklw6gd/vNCHrh+?=
 =?us-ascii?Q?5edaMEHmDh2+5te4CHKrsdqpy0njksxr6+Bi4Cj3DY/g2a4MGf/JhEJrt+q0?=
 =?us-ascii?Q?sJ6G4K6hZ61OfUNkjgCSJ1tKIB5F2oDl+1Lr5k8PorIywbHqWqmX6BmljDYE?=
 =?us-ascii?Q?hG/hosIwAKOXl9RirhVu/1QpU25H3DrKYiLD4IdKUnW8iXg2l+8iLJjJjmz/?=
 =?us-ascii?Q?sAgHSFAL4pQzx/CqHK8pk2tDDqbZv/pE74dOyAJKZe/LIHomL0M0JInnkTpd?=
 =?us-ascii?Q?sAZ+pW4C78iLbsTf1Bnm3Jm0j1nW94kc6ek47yGGKiUsiAIXm/QX0rAm3bZP?=
 =?us-ascii?Q?Scf8EHlQ42jFKx/YbMWhDFm19gefVz/Q2SlGUK40n8mfjx531YV2woGB56bj?=
 =?us-ascii?Q?4ASpeVqlkqumCDJalEU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7854b66-c476-4783-4fa9-08dbc36463b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 16:26:53.9997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VMcb6jCNkqTJsVX5uubSCJIznWMj/at8V/mJTEaMHYUd11nsDei08BVWm0tzrOA8PzCk1PY0NwdFdHmRRNIEVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9624
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Monday, October 2, 2023 11:10 AM
> To: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Frank Li <frank.li@nxp.com>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Linux Next Mailing List <linux-next@vger.kernel.=
org>
> Subject: [EXT] Re: linux-next: build failure after merge of the dmaengine=
 tree
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On 29-09-23, 13:13, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the dmaengine tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> >
> > ld: warning: discarding dynamic section .glink
> > ld: warning: discarding dynamic section .plt
> > ld: linkage table error against `ioread64'
> > ld: stubs don't match calculated size
> > ld: can not build stubs: bad value
> > ld: fs/debugfs/file.o: in function `debugfs_print_regs':
> > file.c:(.text+0xee8): undefined reference to `ioread64be'
> > ld: file.c:(.text+0xf50): undefined reference to `ioread64'
> >
> > Caused by commit
> >
> >   09289d0ad122 ("debugfs_create_regset32() support 8/16/64 bit width
> registers")
> >
> > I have used the dmaengine tree from next-20230928 for today.
>=20
> Thanks for report, I have dropped offending commits for now.

Fixed patch already post at
https://lore.kernel.org/dmaengine/20231002145737.538934-1-Frank.Li@nxp.com/=
T/#u

Frank

>=20
> BR
> --
> ~Vinod
