Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440847F1807
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjKTQAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbjKTQAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:00:30 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2108.outbound.protection.outlook.com [40.107.114.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B56F5;
        Mon, 20 Nov 2023 08:00:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akeU8Xgp2kDrbWScHI6RXuc2N6kbWWkg4YQX8B3pNyVi53c+b23/G4mB/P8NrQZMt8KYlAVBousSVZ3pWuJvBD+CLmdvUqnEtYZQQWzWFq572YQeLwVL44fl2zrt+gjy8KreIBu1oqZRdQrJbQsUmWgI6cbGqTd5j/Ph2GFd3SQMYXpu+ou/aIWrUMD3Tv6r14BNrOj/uVWS4UAWnRDyebqe3jB/R5FH24Lh0tTPSSw8qdFFMYYwBA5d27eT8SVQWmJrQzwwWJX6i2TVN8V47auwb4he9Kd4nqx6kLaUhui1zYj3XkFD2JR8Y3jGGBloHrmZCnJN9R7ZDnQTJ81Ngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLqqxy9kesD3F1c7lla8Cp0PWdGIrT7wSeq2XrVLGbs=;
 b=iPZvbJXJ88HQLApELTK1CnGvLp5J23FxX5Zzvc88TEokIAlVsP72iQfn723Brul1zGFE4ulSr+vjJnHFTafzCef4bcHaq9eF6dm1JD1oYfjAyEYEw69r30OBbsr2/h4UI0GVijuQnvEmnrzlZ/q22SifMDz22vXU4AlXJgSQqYnOu36OtvCbh23ZhhJW4QuDqVLnrx8R3qSrqJ6Xang+t0TH/LOY+7OlKZbrk52+JgJrrhoODf6ujIpkoPZHo0vWgyvDuQ/G8h3gmTOdTLjHyBPIawggqNA8K5vzsxww2/8sLvk0VXoO35xoATcWVnfl6bbTRhtEi+/Kc1eZY/zPWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLqqxy9kesD3F1c7lla8Cp0PWdGIrT7wSeq2XrVLGbs=;
 b=UedSDpedqVhzwgyBPOdTYX5obXzdf5yhn5ZSwgfMYUuph3eEmkDWDTtDu6z1C2fj7RgEFpM8d9qFQC1atKKZN9p9rFajpnuHKSugeOdLZrh4MBksW3KpL/ikzhCMO9E26CFOT/9TcUXfXWXx6Yal5CK5VLdvpER7T/4F+CI5tKo=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OSZPR01MB7940.jpnprd01.prod.outlook.com (2603:1096:604:1bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 16:00:19 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::3f89:e42b:ed6a:489b]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::3f89:e42b:ed6a:489b%3]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 16:00:19 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Simon Horman <horms@kernel.org>, Min Li <lnimi@hotmail.com>
CC:     "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v4 1/1] ptp: clockmatrix: support 32-bit address
 space
Thread-Topic: [PATCH net-next v4 1/1] ptp: clockmatrix: support 32-bit address
 space
Thread-Index: AQHaF9X+rfqWHxkaSE65IZplIdGS4rB+vb2AgASiGZA=
Date:   Mon, 20 Nov 2023 16:00:18 +0000
Message-ID: <OS3PR01MB6593FBB65E9AC4B2CA721F95BAB4A@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <MW5PR03MB693280FDB441C89906BE044BA0B1A@MW5PR03MB6932.namprd03.prod.outlook.com>
 <20231117165419.GO164483@vergenet.net>
In-Reply-To: <20231117165419.GO164483@vergenet.net>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6593:EE_|OSZPR01MB7940:EE_
x-ms-office365-filtering-correlation-id: 790e0add-1f95-42cc-8480-08dbe9e1cb40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PmfJFeelwtKCTOKvPcY+kjn4Mk4eiUwyxiX38NuhoHlfJZlWS0W/I1vw5zI7oYU0RTZdJHvnJP8OnFP1xQ6u0mYJ/9rmGO/juhsGNoc8jpthjtv/KhgC27kKp9+dGPTjXcpktA8knzXwsZeDjuQzGxoYEy4+EZciahd7h+tIuympASgHBN2P8Q2BJ6FOiwYIEUea9JCOYfMevvuYJsZzo8+VghAKfSHfMVfv+rTS83d5sZ+QFVU/33G5+v3nUju3CGToEJUzoT+OaBY/24JkwZMU5HHzXaLFsivCKqsVTn78z3DCqRWMnZmeQR8L4qAGOI7fMkPHIX1ZMBKj2LwhfjRUS5dJf4lmm5s0xKWZ1ddmRCC/PefolQnIZYL6A1CFBBgePh1TOc2PmjXiYrDfjdtSG4y9Tb1s9oCHTP2gAlOot6OOG3R8CkruGuQOF94LjTrZkx+Xgm5tixP/Djp3K0mYwyerFJYGrHR8Ulw02pohqJ70PxMBEdHMfRMiJHPuOur61xB0UheH8Si7ofKQYxyminDvlzvJ6fqqzqlol7dD/g4ABwks5bnFIrCcvqkefLKJiKHMIOEI2PoHv2REEb6/jDaizSJ4Bj2Z1/U8dFo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(316002)(45080400002)(66556008)(64756008)(66476007)(110136005)(26005)(41300700001)(66446008)(54906003)(66946007)(76116006)(122000001)(478600001)(71200400001)(6506007)(83380400001)(55236004)(966005)(52536014)(7696005)(9686003)(55016003)(8936002)(8676002)(4326008)(2906002)(5660300002)(33656002)(38100700002)(38070700009)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T6s3S8FgleoCz1eybOpb32jXxmSs45ggYWFpChnOuDOiH196ntzRv/+dlKBw?=
 =?us-ascii?Q?glza3hXxya8lRewFN2g0+9OUwei98ZwwredDQfGFduL+FSVmkOtMlKY/LBlf?=
 =?us-ascii?Q?iTr+UgHKqQ2AIrivjX4MA1FheExddVgE9aFeoAl3cEkvnz2cDNGC2JHnEEU2?=
 =?us-ascii?Q?ESLsZAegXP3jBEWy5ZXaR91tcxLdfLQuEaN9nH+6KI4/x88+REa5s06WHwEf?=
 =?us-ascii?Q?6XZpKiff0DpoQRoEQOiSZN4LncrCE8xTbo9xejyboAgYSTMNIMxR8at7PSfJ?=
 =?us-ascii?Q?RQ0iZHu5m9huZF2qo34wAhdvx0A04Ls7TcRrRjmvhwyNnWU9gsHK3a3zYfLg?=
 =?us-ascii?Q?7odQYWSDoGB2xLObs2yPljPlrazHEJ33FV04m0VHkQU8Dz8aLAJA1Zs3b1+m?=
 =?us-ascii?Q?c95ez/hc6JVD/ktClGJ/Lns2EieEkyZwbwvOR+S5JzWsArFlvq3ak9BWuiBN?=
 =?us-ascii?Q?Zynu7YJkuZpk9yxpstL3cCe9iZeQP/DKuEdaDYs27Cgg4ykxYMmi6U+3nw9A?=
 =?us-ascii?Q?VPafdURlvQ1Sgq65B5N0p0ZFIRH4YI2+FA3MkhqgdfHPtK6xNMKtSsWvBPGT?=
 =?us-ascii?Q?maPclRsgWvILo1hSZh13Mjsm13LkjB9U1T5uP7EzE+Zw17xzG++OKxFnOmFj?=
 =?us-ascii?Q?XYkhZTODiUIcOhyB52kYCY+3e4Kq/gjxiQ18nAa5t4MD0CTFKUPS3/AovMhi?=
 =?us-ascii?Q?+thcXulPbdBvP1afnkZ/kvdcb9rwO74YkJe+nTEPcPILhjXRIWDKsfKDmciB?=
 =?us-ascii?Q?SA1UomVFm0css+WtJbF5FrzOwgkUuCV/Yhvsf8IsMGN976Q07YzLtEYmigdo?=
 =?us-ascii?Q?uD81l+RYq6DHFPLyB0MbxviTU7rAUxEghbD7LRbJzoyVL1o9HgvE3tgsuVXr?=
 =?us-ascii?Q?wZTpADZdv4ukUH9JSi4BJwkOi2P7Q6pCocqKw6HoSUl1Js1/LyzfVhDMk2on?=
 =?us-ascii?Q?mwnHLclpt6X8i6JJVw9fBXy6+bgSp5XBJdDXAeXAmR+03CLTPSD4uRWeMc5c?=
 =?us-ascii?Q?fI7gLGWZqyORm3Kj8ATqn9amacKhpZ2oSQIqXJeFGSvvTqtz/WpUEoDc8iR8?=
 =?us-ascii?Q?sX8mdRXuQgTKSf3D1xF7fR/fqG7ZBcwkc3f8EtR4Jy8XS+rI2H/CyTWy58BC?=
 =?us-ascii?Q?7pgw3dpzmi2AQK0Qramkw3t8sd4vRiQwAz6X37VNmR2OmULPxqzVDx+zkYMN?=
 =?us-ascii?Q?3uCle31G4E1UVE59oeUlVQ2IVr9JbhmD505XkTmfNMaMeUDs2ZFW+TNFSZLy?=
 =?us-ascii?Q?uUhNoka+MqFfAqJl2A3ZizBc3BxCFUezPteLOzwz/u/ryeRw7OOqzOGR6qS9?=
 =?us-ascii?Q?i7N7fWDMNMydmBWE1FP2fyL5RGB9BoYNEyrRvq5HjGyFy00lpUZjE3xMxFmO?=
 =?us-ascii?Q?4cxZ59eKb60mRi03QD8KT2/LiCHnb3ulzbEnHifKm2NpnCXOjflFQwE0qYoL?=
 =?us-ascii?Q?u8y116UTMRj3ZiHBReCN0+zQbeTV8b2WOMOEpGLmLqqzvOkkDoZZppTVy8i1?=
 =?us-ascii?Q?yZ41+fKx9pQ4FiFQfqKzJVY6hvf5+QLCiVJHqV2e9yt/C0DER8QuFdlJiTcB?=
 =?us-ascii?Q?2Kj+DZnyoqCUCV4PTl9Z9LX8s2BUWKDBe5VcqYxQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790e0add-1f95-42cc-8480-08dbe9e1cb40
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 16:00:18.9652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: It/qaDtcFRAWyuadXCzo2gP3JKdUfSbo+n4AUop1R+3RA+ZQG0Fpfczq1Nxy/vkjjBk2pIqWPpGpBi0DTh4ZSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7940
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> I feel that I am missing something obvious, but I have a question which I
> would like to ask by way of an example.
>=20
> Both before and after this patch idtcm_read() looks like this:
>=20
> static inline int idtcm_read(struct idtcm *idtcm,
> 			     u16 module,
> 			     u16 regaddr,
> 			     u8 *buf,
> 			     u16 count) {
>         return regmap_bulk_read(idtcm->regmap, module + regaddr, buf,
> count); }
>=20
> And so before this patch the above call to idtcm_read() ends up as a call=
 to
> regmap_bulk_read:
>=20
> 	regmap_bulk_read(idtcm->regmap, 0 + 0xa7d4, buf, count);
>=20
> In particular, the 2nd argument is 0 + 0xa7d4 =3D 0xa7d4.
>=20
> But after this patch the call to idtcm_read() becomes:
>=20
> 	regmap_bulk_read(idtcm->regmap,  0x2010a7d4 + 0, buf, count);
>=20
> In particular, the 2nd argument is now 0x2010a7d4 + 0 =3D 0x2010a7d4.
>=20
> My question is, how does this patch take into account the change in this
> value from 0xa7d4 to 0x2010a7d4?
>=20
> Or to the point, does the call to regmap_bulk_read() still work with the =
new
> value?

Hi Simon:

The regmap_bulk_read side of change is handled by the following patch. Basi=
cally
Clockmatrix has 4 bytes of offset registers and rsmu_i2c driver used to ass=
ume=20
0x2010 as part of the offset and only take the lower 2 byte offset from reg=
map_bulk_read.
After the change, rsmu_i2c will take the full 4 byte offset from regmap_bul=
k_read

https://lore.kernel.org/lkml/MW5PR03MB693295AF31ABCAF6AE52EE74A08B9@MW5PR03=
MB6932.namprd03.prod.outlook.com/T/

