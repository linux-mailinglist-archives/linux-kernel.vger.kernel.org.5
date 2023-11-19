Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390377F09D8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 00:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjKSX3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 18:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKSX3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 18:29:01 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2121.outbound.protection.outlook.com [40.107.114.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE98136
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 15:28:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awfq0QXoq4XkkmklbArFvPkaDpgVNaHbpHYTl2ugYSG2rpjHgWwR+CekcLCEJTGgFJb8KPvhxBdMgrk7OUixd9r72q/2ztz4yOtToCKOd/ZLo33UMbYCuBilXah3fyl8X6pII/RDuds3f1gSVw1Cfjzk6tvQb6fTxufxNzfSn9+MhEuQNKfs3H281km8Q/Ggz8v95WcAYbErYVdUyd3ojQmcLe/AYxLs+ofT60BZM867bn15LR9+OmLZp0YvoliaWcwIFhbwe7k+CwdF6Sf964DxAb5h2Kg5LWI9z+qLvoyb3Fvaq1f2VNU/H1AidGnbH3mHIT34EC0sDNR8+pvOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nW1q0jTZM9NOjgcgFKIXEzfDYIKoyqOWZoSR5lLM3Q=;
 b=MXdY8yOvDoFhZVdWXSY5Fiw1nusqE8usEbwWLuUW7EouwM/WUzuzfrZx7i8DrArzERaUcOiOjK2oIASBVa0ckzaAjVgJUr1OxWK0SbzbxviexmZNB/qegWLToIuz22IMKvHKcORyPYjqXv473PxSEg7fZTxrT+JH79gP77eHn1ZrIdxW+2dSGoP2YDBX4PWlIsBonjdY3Ope8rtcTfXsUgBWBhS5Dn/VySgXuVQwUDowOiTum9vVY8tx3iMbas6Xi7Wzy5p0CjQNqYK65Y4hxLGMvWBI/8UTzXcC7PyTyzsi9s8Km0+D5Q9mjqAPFTaSbhMjRKH6w2HH/xEiqg3Rew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nW1q0jTZM9NOjgcgFKIXEzfDYIKoyqOWZoSR5lLM3Q=;
 b=kTLF/kajoly5STXgIjY70pbNhp3gfJIhLquHpCGSUL+FuEnbxGDqBbDCOhj3rvke5pRDsUiZlPSLWwdUVTOfQbvpU/n4mvJEb7qBcUnTg1han61Uu578UNPK/Nc6zuZLxqTt9y+EegiY38WErVL3ez67cx+tCjSBBhxy1HIL7n0=
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYAPR01MB6220.jpnprd01.prod.outlook.com
 (2603:1096:400:84::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sun, 19 Nov
 2023 23:28:53 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::16b3:a84d:faa6:4846]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::16b3:a84d:faa6:4846%6]) with mapi id 15.20.7002.026; Sun, 19 Nov 2023
 23:28:53 +0000
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iuliana.prodan@nxp.com" <iuliana.prodan@nxp.com>,
        "shengjiu.wang@nxp.com" <shengjiu.wang@nxp.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: RE: [RFC PATCH] ASoC: simple-card: Use dai_id from node description
Thread-Topic: [RFC PATCH] ASoC: simple-card: Use dai_id from node description
Thread-Index: AQHaGXSgqKqilaeU5kqopIa/H3nty7CCTJSg
Date:   Sun, 19 Nov 2023 23:28:53 +0000
Message-ID: <TYCPR01MB10914A8D3BA6BC9387EC2DC3CD4B5A@TYCPR01MB10914.jpnprd01.prod.outlook.com>
References: <20231117163900.766996-1-daniel.baluta@oss.nxp.com>
In-Reply-To: <20231117163900.766996-1-daniel.baluta@oss.nxp.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10914:EE_|TYAPR01MB6220:EE_
x-ms-office365-filtering-correlation-id: ecb2f27e-ef62-41f2-60bd-08dbe9574b1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4BENL2Koq3XSukr1M+rskhIX0LOF0VtoFpx/aIAn82qaUgtkUnzBUoOG4mUIDvO8WaMt/br/ekyVa7/ofmP//vIVM+H9d2sVDcIFFf4vGNYYDBFxB0iIQRzYaM7iV2eWrhOmkLJIbwQhY/ZfzLc+SywBi1qMegvrvG4WH8kDRCAm2bEU7NwD7Vt0b5T7SM2q4Bp3OV3dX0DUivMrl940Kb0BxiJPwbBWLs1YIcLpVRQkGCUgfVGpnZKlL+pzKvnezm3s8T7oImilykXtcX5ZNgXHaGDlgrMMKjONp7mOnXWjJkbD44VleHTrLB/89lp4Y8qc+o9s3E88K12KO2LcaYaj5yvZfowZqn7RyxcBvIwEZWOvG60Zcut9Q5hRC4NBWNDJ7P12AwFAM/cSTnmEBBx0xqOcuY6UpSq3U8evePCU8j7DG0OKqO6nwgiGI8u3IMrXCVxBh5zO7lQsn90tHAdW7sIdeU8pv+hn6LSpitDVT1Fw55VbjF4OruaHpG+aF5wcxifJEq8wlWn54cUbTFcw7zJw9EOITYHJgYRpC0ihmtlWbjNyQklH3Q8Wktnv1mdBKPfHvV+Hs1Mlg4MlMXeW8xvh0yFJ27xUdgQfqAYGdwC5/444vED2sjts/YDD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(396003)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(41300700001)(66446008)(64756008)(66476007)(66556008)(2906002)(66946007)(76116006)(54906003)(316002)(122000001)(38100700002)(6506007)(7696005)(9686003)(478600001)(110136005)(71200400001)(107886003)(5660300002)(33656002)(86362001)(8936002)(8676002)(4326008)(52536014)(38070700009)(4744005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?98sfXxzSLd4uXCCqI8r6ybovU1cso6Idt8BM1S3tSYL/n1VSLBEqqIA0SnUL?=
 =?us-ascii?Q?A3r18q9V3S3po4Appjly+119hYZCc0sP3+0WpfdAQ/dF0Uphciv30POkpx4X?=
 =?us-ascii?Q?p8nsIuZPWtlVWLBNOibTxocLxeiwvBQiHdPcs0uFT7ENPesmpeZykqc7x8Xd?=
 =?us-ascii?Q?v3J4T7dQUSNicG4nF2vHX77tvaEcGWGJoaY23DefNDeURO8q0llXQOtpiXuZ?=
 =?us-ascii?Q?KudLoLAsZXl7t3XnZbrDkMZubIx/BelUl5rfBM0xfXUYVUEPfFzhzDK9K8aJ?=
 =?us-ascii?Q?/1KxrB1tjej6zy2uD41APYg8PaTh+Ag6ezWnW+YUGD7s0ZErNm18BIblHGF9?=
 =?us-ascii?Q?L5zjcamsdCh8fKl/iS1iXjSaYmtLDnTHDaxBmV/31lkDEZTMjkAAVTJeiIVl?=
 =?us-ascii?Q?SyAzNIOdrdFJOvcn4TWC36tUfdw+FSiHEcR+SU3Rz+QSWWT6hvWwfq6+pjqZ?=
 =?us-ascii?Q?d8A8eK1P2A2ebF+poF85cLEF7ReF2xdeJUUDY3DGc0BoRmN7W6XCw7Ls7nRT?=
 =?us-ascii?Q?Hhrh/GutzJOfsCF1kLsrT7Eclqt8GwkQGuC3T7JJUOv3Nq8lp3cp/cV4DtzV?=
 =?us-ascii?Q?OQJTarbdCIMYarJGdkYdbzPJTvbnpp/fzNGVlJa1ATt/Wu6NrRsQUdo1DCVZ?=
 =?us-ascii?Q?AfzQXIctNpAmpGVB1CG+pC2gDIri6ltjvCtSzgaAgz2XHxJ6Cf3C3BO3s/VA?=
 =?us-ascii?Q?8w758V/1nQfzQpoVPW/YiEL2bmNofh/HUJwmCa1xTvn6wtfcfAEYhHh/nrim?=
 =?us-ascii?Q?rx7/IP/6xDg8BnQMhGtUEWvcmPLqSz0WbBTG4ENYaZFtDxBuM9vC8mHFS8hC?=
 =?us-ascii?Q?yQLFIl8wYIDHlE4OAZIpiA64NV/OkObz9M0Q4ETVIIxzSXRICm2bnjo+8oMW?=
 =?us-ascii?Q?zRLKiz2VHKV1pWrDSVcT0dM7UhqQJUkwiVu2b/keJNK9jnF3DnABUoxjQHBh?=
 =?us-ascii?Q?5/v4CsHey2GbyHZb9sNtnyXS8YeGjx+1ikyzFBMKbdCCDSdzY5ls1Q4YdEb7?=
 =?us-ascii?Q?kqYLOS3cxoXAW6MT4VtV+UQMSd4tcnYFfUfLF1raLINqEaHWG5jTbzbi7O8r?=
 =?us-ascii?Q?dI1aYq0YJB93Hl9J2ng/SiUZPp43eU0pTEDpGwgHUmjh8LcfUQgfb9mvBWeJ?=
 =?us-ascii?Q?q4sMVJBkw+y3z5jLDkZjGgxTQxiA/4+AMRwniGzlHua3e7ypyeZGoZNJhFTV?=
 =?us-ascii?Q?CcpL+3nhlozjr616uQYFqm9qZfei7dnlFyyqcbmZjeq7jQvJ6kelxIULWjb7?=
 =?us-ascii?Q?G/HqaGR3YhMm3JG8vUHefmGYfI7M+svL8EDoqXjv4IE5RfuxGXVhvIkOIp6O?=
 =?us-ascii?Q?iKhaPA2408uyDTh7zOaDL/xeuTAZV4FCCt2wbfkP2xULYH+/5QNvk4xqWK50?=
 =?us-ascii?Q?QSKOhqUNrk1EdIqEcZpC7SiBMLwuobmp4nlqdZhj09/YS6nYNIyKem3ecCaV?=
 =?us-ascii?Q?GAGTgavOmLzKIS7pcqDcCKQqSuRMS+3ymaKiEj+35Y//FY3WHEJlmAc2Us66?=
 =?us-ascii?Q?BsNNuxZCB3rPahyelEfnGd3hL3vcX1yS98YQzrwmf2OaReOgkTed6NyNNv6A?=
 =?us-ascii?Q?Tazgw4WWChn24To4Ab/UzjU6K5p+YYk6wXo0ZgkJ48zLHuoLOhLmmwBUEi1F?=
 =?us-ascii?Q?EohyUZYPPzKUBmS8V4XMGoNjOh6nJEi+Rp5akCIrTqsIrDpafGnXyBjGlzDH?=
 =?us-ascii?Q?sJRdqw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb2f27e-ef62-41f2-60bd-08dbe9574b1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2023 23:28:53.3941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMg+MHUUkR9p57awbm/20ouhzFuGolMf/odHS/IOSvCu0RZnLxglH00VfQTFmeGI6OcbPxCIaujz7TCCcBdaIWoSRL1Ma/HVVpmBUcIbRBagIhFcmYPZPweFPq0D4MNp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6220
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel

Thank you for your patch.

> We can specify DAI id using reg property. When dts
> node has only 1 DAI simple-card always assumes that DAI id is 0.
>=20
> But this is not correct in the case of SOF for example which adds DAIs
> staticaly (See definition of snd_soc_dai_driver in sound/soc/sof/imx/imx8=
m.c)
>=20
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
(snip)
> -	args.args_count	=3D (of_graph_get_endpoint_count(node) > 1);
> +	args.args_count	=3D (of_graph_get_endpoint_count(node) >=3D 1);

Hmm... I'm not sure how it works for existing drivers.
I'm busy this week, so I will check it next week.

Thanks

