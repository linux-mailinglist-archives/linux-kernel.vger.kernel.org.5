Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D876876FFE2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjHDMCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjHDMCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:02:22 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2050.outbound.protection.outlook.com [40.107.14.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC57139;
        Fri,  4 Aug 2023 05:02:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahrHB5ByvPYG2yQkkm19+H0iFgg/scfpbevea09ZpkAhIrkg8eoY6F9CZZHBipk24clY9h8Phj5AcFlHoAlQ1dI9F6p2SkDbEBA+OBnyrb+8+yvuW+ZXuCtTr/YefRkG97T7jHcHGcyh8olVzpjJ5rv0X42BV2qq8ouju2oEPGdZ8eSkz52PYk/BuABcsTM8LImI4KFGzNEsx83TE2anTk5mi7gZdkuAbpEzXmvL+VGWYSAB5hTDQZiEYz+3ooFvnWCbwOWjb7K0fYV3MOwlPvsQSsJVgI550byof0Bepxcc29Btlu6Orqtd9Jdkrj/Rx61ALQtWBWH8MhArneAdeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uLEhLA8yF384aOB40ihXyQbB94b3DxVtX5UpFgPkSY=;
 b=ZQxo2QcGUmh0tYXbuZ6EITzgVXA6aM6jSd64YTgugS0Haqo4aiUkgMcO1D562rulRDkwdtzPA8DrsYgn+IfC9tH1ny8d+6oVNaVfp1CNV2H/GLCDrqRGzWqXSI7Ev6loNRWSRofIKgj4IIIkIWANIob35IcpOSAMb1K3s/Db0sdvccCAj+VhkL61rNUcxIaCcKHpoau0flQ9EJow0u93a1LXUJP5o0yEFXtrKzKHpGLc3yiqxt9KLhFWrnvHTCNhGEH43lqwCi1oCM4qXCMBn0AWb28EYsfrrgnutDQtBI3JQ4wBn8ZjrBrpZO8CKiY76zxe09g48PxPAnzJ6zY2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uLEhLA8yF384aOB40ihXyQbB94b3DxVtX5UpFgPkSY=;
 b=bDUqZoGIw31irBLNQ+3bxT4WCBE8jrZOuPxYJGf6Bvptl+WWbV6Z8Mmnuf0qP2+P2oA2IZGVaGSsKc6DXTvv0E22ZmhmBVyvF4e4AJDcl9GK0glskcR1Y6TEGPQagpMJUSGeKsxKA0eZNqW2TtwMMTE7mFNa1KPRJKvY+nSHo7Y=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by AM9PR04MB7650.eurprd04.prod.outlook.com (2603:10a6:20b:281::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 12:02:15 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::1392:7c78:1b43:769f]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::1392:7c78:1b43:769f%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 12:02:15 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
CC:     Bastian Krause <bst@pengutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Douglass <dan.douglass@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: RE: [EXT] Re: [PATCH] crypto: caam - adjust RNG timing to support
 more devices
Thread-Topic: [EXT] Re: [PATCH] crypto: caam - adjust RNG timing to support
 more devices
Thread-Index: AQHZug6+BPzkkhdXaUqEPx5hGyrmMK/IZwWAgBGM4YCAACoJkA==
Date:   Fri, 4 Aug 2023 12:02:15 +0000
Message-ID: <AM0PR04MB60046B045B5965A61BA1CA91E709A@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230612082615.1255357-1-meenakshi.aggarwal@nxp.com>
 <e1f3f073-9d5e-1bae-f4f8-08dc48adad62@pengutronix.de>
 <f673a09e-e212-ee7b-15c3-78afe8c70916@pengutronix.de>
 <DU0PR04MB9563E31E69F93B63EE83DD378E39A@DU0PR04MB9563.eurprd04.prod.outlook.com>
 <DU0PR04MB95637D86F0134DC26EF955DB8E02A@DU0PR04MB9563.eurprd04.prod.outlook.com>
 <ZMzBWXpvdW5YB8bt@gondor.apana.org.au>
In-Reply-To: <ZMzBWXpvdW5YB8bt@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|AM9PR04MB7650:EE_
x-ms-office365-filtering-correlation-id: cf984c69-1fec-458f-b6a2-08db94e2a50d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rLvPxarjEjrDyz+/TCLnXHQXwkFVkdfq3zz12yP4ZdzXUTE3lKkaRbamoNcYx6a+btAsuTtHlDll381cmMcxFNH2x2K02L7OaxD1Xrn6BRRK1PN6j6BH67ZWfBrnFOXwcudbPVS5q+K63DB5tWOptKHwD1RVv7h4XwKgYsmTv3c1uVYG2HLlDsdu9KbkVAMTPE2UxJYgoLb+mariJUD5+RaJx3zKw+O3bP1eYBctnvRNiLd4kPtCbdaRCtwVxiyru+Uo/9qRemKmilevnRf3GqkaKJqF8nHlq19q1wxGLp7T58CkMQQiuqrSppXnIQdgOcfnepNxFvEzuOaMMrWWGa3r5QHj0uBxBKyODeQURdAdXb7gcKa9s/fLgP1dRvSKS/pWZMCbInvpZthzPxmj6NqfCUYXxWhDnVf22WFVWk16eO1OOjL49rJXsvfuiFFrK1ZNInd2CIi20+YZ46CrFj33Z9CtgPX97u0lQjK/C+xwdDn/mPofoLBPPo6p/Z42i3NaPYakfpdJGoO9ROQzo+PKzpORr9pxuBYGIJ3cBKND+V5YUEaZJlOFvnVStyYlRDr90oCQ8FfUGDa8WzY8bNeSMOxI55iq53lc5kp+tU0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199021)(1800799003)(186006)(53546011)(55236004)(8676002)(26005)(6506007)(83380400001)(4326008)(2906002)(66476007)(316002)(76116006)(6636002)(66946007)(5660300002)(66446008)(64756008)(66556008)(44832011)(8936002)(41300700001)(966005)(7696005)(71200400001)(52536014)(9686003)(45080400002)(110136005)(478600001)(55016003)(122000001)(54906003)(38100700002)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hCLQoVHjZo86yrwA9Z4qV80b0RqbTrxR+ThzT7io9vAQFPvakl0u3jtqb5p0?=
 =?us-ascii?Q?FbPgh1qAKXU5OXRDd9tiFTVjtwfg9uYkUg7fV5TTnixYUiaQuZzrxhE9u/TN?=
 =?us-ascii?Q?o+VhKY/cF8Vy/PYi8aLg1qbBEg/FxQo8wDhPOc1n//UOsTECnwxErkR436dQ?=
 =?us-ascii?Q?3WGXu+RtL9yBD5Kq32S9L54XG3xcsirnC/lEDkXKwTDf15Nfdwvkupxzhj/e?=
 =?us-ascii?Q?0U8690bOpVzKQn3p46lPqh62FkM7kQ39maWu4GwDePmBO/XgGXSGehfp4uSf?=
 =?us-ascii?Q?pm6O+KQ/7I89jx5/WLxF7JYIVEjaLWv3ncTfBIic/bLfqqmgLc4DjZLueB3k?=
 =?us-ascii?Q?lmYSRhK+drrUK7pGTNgKh63KMoXOJURnSKBIETU0f8L6+80zEPrDEDToJO2s?=
 =?us-ascii?Q?YhH43Br56OKUJSNivVLuJCcOUqe9M73ue6xUDSsOIQsnFXIOr5r4SvcLObyr?=
 =?us-ascii?Q?ANKWECoLpCuWfuJweBzbrIK30nTDrzss+pZHrz1p8N4I4E7+n6g99mHkXyh+?=
 =?us-ascii?Q?1hVmoD8pDYZoipBELlbrpFUvCnKizBeo/HaCdpteFhiZo3gGyi1kkoJZzRdV?=
 =?us-ascii?Q?RuY4xyyi7DYqaQF4/AOrM6bkweJ0HJpFPyCcmpRpv2JbCzxy6CqB6G/vV93Y?=
 =?us-ascii?Q?iW8ZqEs/IQXUcRfZRmzKJAGFp5fRM/DFojrDA1ln/OW1ePOVVVM1kWJFZNpu?=
 =?us-ascii?Q?AJ1Xg7+lrUKILxUjqPo952QF+t+9zNpSi94yNZO52Dja193GNDv6p8qd7YOD?=
 =?us-ascii?Q?Dh7wIr7vjdd7u8OZlmCk8jMZhz0XCdKq0+oC+f6EiXtPqFAwmDEmy4rDrNXX?=
 =?us-ascii?Q?/gi32CInFBKQu5/GjbM/5NbSy4eyhTHMTJ5JS4A1YJyyiqsOnlZ6Sh4PqYYi?=
 =?us-ascii?Q?+xcEx1nHEVNYTotYGRRhiB09roCju8IpbrqkKKpWoWoik7O5WnXNDX7A9O3W?=
 =?us-ascii?Q?JX1UHWFQJWpvag0g/Uzaesfq7aZIHEgyLKzCeAzLXxAivmE0CQFm++rpi6mD?=
 =?us-ascii?Q?BLc1srEh0MEgb38nh9kvwU7qR3tnS9tfFtVqkNVRlB9Rwwj51sQ119NFJoxO?=
 =?us-ascii?Q?yLIJA9cpWyLThXOibhSX7nXI3xVAXqc8RgfJiRPEIMKJa4+y+v2R507He0Uz?=
 =?us-ascii?Q?FQpk9cuNZRFlYkwvTK6/RwkcG3CzuspqXqNOK9GUfr0iADsTLDvQR7+xk3QM?=
 =?us-ascii?Q?gfE4wyxzQI0liUlC/pROzpwffddvLPZimj3lxaMVcrnZU3hmFzOuzvuL/f+4?=
 =?us-ascii?Q?kggM1zxR9XA38/OoX5NL5y53E8+4MhBM1PejwZd5cEloFxkXIGvKYej0eP5Y?=
 =?us-ascii?Q?+unS064/S4rwblLBJuXXcEs1me4PEerxByaVUAvTRbk8hWl5a0isIVVnL/iS?=
 =?us-ascii?Q?Ct3GDPMU/sX5dOBnbUdAXnZmZHPX+A3PKiL8cZB0GkqKxxSMIyqs69FDmiLs?=
 =?us-ascii?Q?KLrJcP+WREdOMgC+44PBeuiUChSfVrkalBcf72HYnAjzA4m39t0c6nyDT++U?=
 =?us-ascii?Q?maS0FW7The82AWJgA0eaemt5mVTJub/cz9+rZxOiudawkiXdILOtHnkk7Ib8?=
 =?us-ascii?Q?YF7CaQJEgRqm4mCofTX6CVpWF7f4C3YDS6e+9/Dk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf984c69-1fec-458f-b6a2-08db94e2a50d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 12:02:15.5246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fX1nmP6plivaIS4ko26j4GNbvDT+UdNXk3xsPddQRZkPDUkrDcV5Cl653YLwlmDPeKMGTxXzXNrjdli1sSOpcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7650
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Friday, August 4, 2023 2:44 PM
> To: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Cc: Bastian Krause <bst@pengutronix.de>; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Dan Douglass
> <dan.douglass@nxp.com>; kernel@pengutronix.de; Horia Geanta
> <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>
> Subject: [EXT] Re: [PATCH] crypto: caam - adjust RNG timing to support mo=
re
> devices
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>
>
> On Mon, Jul 24, 2023 at 05:13:23AM +0000, Meenakshi Aggarwal wrote:
> > Hi Bastian,
> >
> > Please share the required information.
>
> Any progress on this?
>
> Should we revert the offending patch?

Debugging is in progress. There should be some mismatch in TRNG configurati=
on in customer board.
Will be sharing a patch to dump the same.

Regards
Gaurav Jain

>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> http://gondor.ap/
> ana.org.au%2F~herbert%2F&data=3D05%7C01%7Cgaurav.jain%40nxp.com%7C3d
> b657e628254a7a992a08db94cb2ba6%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C638267372562927851%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000
> %7C%7C%7C&sdata=3DkypjQ4eyWAw1NNMvnZ7bbF7cMdFUmU6PFWFSaOanw6
> w%3D&reserved=3D0
> PGP Key:
> http://gondor.ap/
> ana.org.au%2F~herbert%2Fpubkey.txt&data=3D05%7C01%7Cgaurav.jain%40nxp.c
> om%7C3db657e628254a7a992a08db94cb2ba6%7C686ea1d3bc2b4c6fa92cd99c
> 5c301635%7C0%7C0%7C638267372562927851%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C3000%7C%7C%7C&sdata=3DWsPJZj%2BGnC0CJoZS0YPNA6TxsN%2BAIXeuvRh
> nDY%2FPouQ%3D&reserved=3D0
