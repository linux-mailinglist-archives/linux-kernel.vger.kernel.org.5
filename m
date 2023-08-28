Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D7378A8F3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjH1JaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjH1JaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:30:13 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2054.outbound.protection.outlook.com [40.107.247.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1243E9E;
        Mon, 28 Aug 2023 02:30:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mf5NUjzMpJP/OEhvsu7cHD4JHzNQaNFlfkdz7Y96c1iVXEUPzpqR/E+7+Fu+KO1+H8FNDLoDg3usHNuE5UBK7vFEDKinmcufwhg5WuAluS7L2+x4NVtcJG0OTBpHzm+uRaqn9Ha+BJAJ3UaJ6aZ8xtTfVINvTQMMZP85hd3K6SLFXZAVOKyGyl+OFuPq5/Ib426nL0ScY3XZaYoyAdyFKifQrEEb7bYXzkaFVHJxx4LHvF2e0kFHBMlc5KYTTLg276pe3Y0RyK+qFLA2vQWx8GXjGn+4bbUnqt65IA2/yvfAyRFEk6RooijIb7Bc1Pw9et7fDZoLt5GGLhSqDjQCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0urg889G0v0xLfARmQZrZbCuUska/u5v0fbbqVG5U0=;
 b=TUStj8ilRjl47fiqN29keBzkU2xnaSLocuS0lH1OB6pnLapaKNA1F9+d4l5AQ2qW8oqoZmviMf6siy7lBONYiF0GfpYP4jevXmyX+nE/rjewwiAqif/B8DGQGf7ADiCVrPqpgBYcmfylhc4nbo+1lnj+iWJxIiKgKrztI4pKP3eAeF/IXpapD0DA94WpN1PaH/Bs6fMVQlDn1eCvP0+r1SpD0T0YuRhxvxGRO0iQQax/WWBAnG0zcuqLTuuA/Y7cwzBsFJZ8eFdNZByfJEQnEWyXsF1KvhPEc8rMKgf76+AZaYQdEYdkysAqlk+zSj52fWe8UDxNrTDCpNcavfxZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0urg889G0v0xLfARmQZrZbCuUska/u5v0fbbqVG5U0=;
 b=XTP/zI68l0IMT43TOhmbSiUaJjKsdiFeUr8atTgmU8E2aELultfa06YVq5zB4/LasjhHYrnuqDM2FlFAyzkmYzRMWbFpWUle9wpB1gchW4Q54HoQVnGzoGLfPXN0wfDtxhAOUFZ3lP2BwpB2iPmNUaiyv/idf37vB3e62XQsKcY=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 09:30:08 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::693d:8782:eae1:2460%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 09:30:08 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "amitkarwar@gmail.com" <amitkarwar@gmail.com>,
        "ganapathi017@gmail.com" <ganapathi017@gmail.com>,
        "huxinming820@gmail.com" <huxinming820@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [EXT] Re: [PATCH v4 1/1] wifi: mwifiex: added code to support
 host mlme.
Thread-Topic: [EXT] Re: [PATCH v4 1/1] wifi: mwifiex: added code to support
 host mlme.
Thread-Index: AdnPR2mvHOQJHhM/R5inuXZ0d62ZCgH9B74AAJU/fRA=
Date:   Mon, 28 Aug 2023 09:30:08 +0000
Message-ID: <PA4PR04MB9638EAED5E4361F0429A796CD1E0A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <PA4PR04MB96386B2937FE0F7BD0BFAEB3D114A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZOh8deIyeJMZAs7u@francesco-nb.int.toradex.com>
In-Reply-To: <ZOh8deIyeJMZAs7u@francesco-nb.int.toradex.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DB9PR04MB9498:EE_
x-ms-office365-filtering-correlation-id: 3f6302f6-1e01-44f0-7c40-08dba7a95e99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 89NNG0FMaxMPS5T3THz4NSgktnN6tLGDLWbzK7hwCTPg60MOzDgWTm+ZV8+JVjKd300BIithZEBtfId41WaKPU9CV1Wg+Mai5uTobg/vbJml7nBCpeuTHP2EWc1W7+kqkVU0Jnp0RpP8v7blaxXMG5U3dshqh/d5wXpCs3VkGXsyW2PB76iM9tBw9lURy2Io+OoByEEKudRmEm0AfGWricceXHDCZCC5EOJWsYIci5a+8Y7p2TQDz9KygJTmlRrkfDn5XY70PBijcd9jpv6lxYiUAwRTR1JLBGZcc1nRjE2wtW0VJAdnDgZ4AW1boHK1HoVq3nQOIzUuMjcRAgJ6bw9zkjNIJdlyCJVynv0o4AGJRZrlOR5KF3OYq0K7p2pJN2ih4I0RQugYOewDmAs2GFhNTKNEJ3NP43xQZ65sAJkbgJL+qbn+MFkNXbLo2drXSIYLvAiyS3PDwDQK4eeYmjzYlkZ0cmqseEEOG/NKCGOgL42HB6h7fWglQKwGQ4ObfSh02fDUOD/SlTfrygku8Cl+eiHIkMkXMFXQ9EFPZAbYGV4UqR1rEPm0JdvGFiVoWs03sJ9TxWPdkPZ2zVKZbwxAszBfVb5xcFoGQWrBN0I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(1800799009)(451199024)(186009)(8676002)(8936002)(4326008)(2906002)(6916009)(54906003)(66946007)(66556008)(316002)(66476007)(33656002)(66446008)(64756008)(76116006)(5660300002)(52536014)(7416002)(41300700001)(6506007)(7696005)(9686003)(55016003)(53546011)(38070700005)(45080400002)(122000001)(38100700002)(478600001)(966005)(71200400001)(83380400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ow8mjo9kQv/cKRQbooiODsQtzv3qXamfwr1s2gJh4EBW0pDeT0TzEC2IQCUO?=
 =?us-ascii?Q?GUB3spYord/v3e3LEQV0lz5HUBMy6KxgmnX9kZiTNfJZrPgsu1ewHy9fG+Vs?=
 =?us-ascii?Q?SAIgEy3d2NY35vOA+sfCpMnw950pb2mbe86hYcJvAeqphYrQ7KljlwfD+8nx?=
 =?us-ascii?Q?0PgxpV/ELDquDWlK9QlproJzRey7HE7O95wtRcJVIg6HLLq1IKfupHn2Qt44?=
 =?us-ascii?Q?elX+fjxoO7CUTgwIgrBcUqDMZoFCplIt8ftTkOaRM2+/RGtNyGrfbdkXclX7?=
 =?us-ascii?Q?7Jikc1bq+jdHM/tW3Kp5Oqys84jNOROPR5gesp9ihf+zgW4G6FnHnB9Foz3/?=
 =?us-ascii?Q?VjyRVVzwWt2i4iJHtTo1hSKOIBtDhh6agUbJgVbC8e8xsyz5pnFc2k0ZY8ec?=
 =?us-ascii?Q?Av9/8brhhyypACvwJfqKTSAbRCN+aDIEa4JdbToK/jDgXgSoqYPocs/oA2vJ?=
 =?us-ascii?Q?EoyVbnjjcVY+9x0JlUJ5/SlHcr+8/jDA10yDIdkZg6czWRq+/sgcdsc5l/lg?=
 =?us-ascii?Q?tWGqGp2G83oNNBrUnlHgwXNYnIcTZv3lGVbr8gUiaw85YcsCr+bY9YF0lcez?=
 =?us-ascii?Q?nvr+xGSz+KYqqopgKUQbsJkAcU9qGHdpABU+IysD9KE1xUluGSy17tXT1sJt?=
 =?us-ascii?Q?3pgL+DxbM5WQzxld70idit5I/PVSkXXOJVi3HKrOYFzfJJa0mIHzW4yTv9OS?=
 =?us-ascii?Q?whcNenKO2d9WAtwbGQiBfeDhEKHJfRLgGHzhSaAPd5l8Sbyr0eA6f9V71wGd?=
 =?us-ascii?Q?Tn7DK0t5aNSWeD5GEXHB9Nbl2b1ieUHnJMXMrEphjJMn70J8SGytBkD+vNDt?=
 =?us-ascii?Q?LFHWY/hO4F/hXM8bcyFEB/5Fm48IAnn2WfqPOLwogo/ipO3MzIGDyK0g1P1t?=
 =?us-ascii?Q?fK9F7Askm4To/L49JLo7GpkUtWNJaKOfCx4T/A94+n+BP65RwhG16cCx5Uyc?=
 =?us-ascii?Q?W8lrPb+Cpf3+0L9VexkQR4D8oK9lHjVp6bek51PDJzywOIJ34McbVLwPJytI?=
 =?us-ascii?Q?kM5WACOToh0BVY45e6h6WIqXt3aIzGwjUcHCa33ofOzGIMxIjQy6CuVO73IP?=
 =?us-ascii?Q?cscWNBBH23Full34IlKgh6tlL+hDp58hylvXskwX0FxGByqiu/mtygLReox9?=
 =?us-ascii?Q?OW3BLqLYNh1O89dLdIKOplifhYGmZFunhf02abbxGacswmnGUmUgXjGZvTK+?=
 =?us-ascii?Q?cKlXcZqLLNoeBNxbJPo+yqjaYDe56ZcuqsDCSCz7z5Ho7mwvOllv/qCtanJ1?=
 =?us-ascii?Q?b7OarJLpt6xN8sjwYk2Lnoy5dL/EG7DuFhJ4yxMKsoyruP4wPplISbvBhrF8?=
 =?us-ascii?Q?e63EVkwqYm/8SS0VAOVHgNzYsrJlBmDZYsMjnwhPsx1mn5bkEIPDp/fhFTar?=
 =?us-ascii?Q?SXBxDE7LzfMOqulM3yYqYoKPjUJVsl0aivUPu9w1cXqqY75YJ2qL9qTJOwlg?=
 =?us-ascii?Q?CpTFyLtn/Cgzf0Qdi3tW4+jGwrtQAWsXmFiEotqGhdedi+8antJkCzE4sSM9?=
 =?us-ascii?Q?3ivYXOsOCDcTOtKUOTmaSA5zcoPpVSD5le4VHG+/KjSrYBjjkVROs0L2UA?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6302f6-1e01-44f0-7c40-08dba7a95e99
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 09:30:08.1073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bSgoLFn8Lx93xdhIunnpbQWqIVnacs9N7Icm0PEctH8VmApjVwcY5mIZuGi8qSDDwpKv6XI+NvY7nLoQph+u1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9498
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Friday, August 25, 2023 6:04 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org; Sharvar=
i
> Harisangam <sharvari.harisangam@nxp.com>; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>; kvalo@kernel.org; amitkarwar@gmail.com;
> ganapathi017@gmail.com; huxinming820@gmail.com;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Subject: [EXT] Re: [PATCH v4 1/1] wifi: mwifiex: added code to support ho=
st
> mlme.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Hello David,
> thanks for your patch.
>=20
> On Tue, Aug 15, 2023 at 07:09:25AM +0000, David Lin wrote:
> > 1. For station mode first.
> > 2. This feature is a must for WPA3.
> > 3. Firmware key api version 2 is needed for this feature.
> > 4. The code is only enabled and tested with IW416.
> > 5. This feature is disabled for other chips.
> >
> > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
>=20
> I think you are missing a few of the comments you received so far.
>=20
>  - verify the recipient list, the list here was likely generated with an
>    old kernel tree using an outdated MAINTAINERS file

I followed your suggestion and issued the command on latest wireless test r=
epository.

>  - you need to provide a changelog in your patch, otherwise is not
>    possible for other to review

Yes, one the cover page.

>  - some concern were raised on the fact that this is tested only with
>    IW416, we should have some confidence this is not creating regressions=
.
>=20

I had tested IW416 without host mlme enabled, it can work without issues.

BTW, The state of PATCH v4 is changed to "Defered".
Link to latest PATCH v4:
https://patchwork.kernel.org/project/linux-wireless/patch/PA4PR04MB963838F1=
2BADC1B9FD377CB7D114A@PA4PR04MB9638.eurprd04.prod.outlook.com/

Press "expand" of Series, you can find <v4 0/1> which is the cover letter w=
ith change history of PATCH v2 to v4.
>=20
> Francesco

