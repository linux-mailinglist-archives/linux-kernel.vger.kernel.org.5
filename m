Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC6277EE9B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 03:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347467AbjHQBSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 21:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347390AbjHQBSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 21:18:07 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D98CFD;
        Wed, 16 Aug 2023 18:18:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbyhUjFM4bl/3Y1PgaD50LZcMKAuCl2xiT0T6DpODzrONOkwTKAYL3LsQoSLwnrngCUQQpEjkQjSSDHLuwz6L2OCTjwZnNOISSdIHffWuKLDcZGau9aBZSa4w7DZ+O09CYReSYP7xYbgU1VsEYU/y4RX2+pfPDqt6M8/8/7LBXUo2pkY9GwqHzi2dKjtEuo7LSTHMwvdAuL7egxt/feIB7dNcff0eHMHrXd5TW+0eEHuMOxGKhBdnEfolidM5IQ5ffHUOiquhoaD9J2eZWfRb0nYnQKIvi2HZkwA143SINl78Oaux0b0wKxD7ktaVcxPmmQ+lEumNDjo7IzTIPl+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/a/vng6z56A/15RRGNtabzI9SxdZgVWS3Eqy8vSMHRs=;
 b=mlOzsxrwU6NlUfC0W5Yk1K9mpbfio3r56XagYS+94IlnujmerGITIdl6q8+w6JqbrL3GVFf7qAAroNLdaH8J10KKyhlq2IaE3vhpZNyD+7jjNm8c3E07nNwsD1VLVZB0S01y4q/EFi0iZ9WxLKJhScbHGBCbprHoZjHcpceb3vU0fV2+cyfuYW3wswu0OxxM8YQ3GXnAv8s2Y5garvOV0FdQIM4GJ9lnCqHk7eIggZ5jmqUHtXuToLZqCE8EXQaxynmuJoqQfkZYwil99cllpiEDSsILj0fBYB9HVxvVgxTlBiCBfHZ03ltwMiOBu7LvNu6egUyXP1SPsYBjA+qcIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/a/vng6z56A/15RRGNtabzI9SxdZgVWS3Eqy8vSMHRs=;
 b=RpqfQ4sgvTvLUJkxMOVHNE1Yvjxjm3/QokKQbqhDir9PJmBiwq2e/dAD5/CQ4CfHZzeBR7ueRupP+PoorEqGTWLVrtSw2dyyh3OCPeORUJQBfhHZ/RxqdJ/d1LNsohv6/nN2Os06IPHGQ6aH8UOonmL8kSWB1zYpqRHW3wwECs0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9146.eurprd04.prod.outlook.com (2603:10a6:10:2f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 01:18:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 01:18:02 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] of/platform: increase refcount of fwnode
Thread-Topic: [PATCH] of/platform: increase refcount of fwnode
Thread-Index: AQHZzRc8Wntpzb78S0+PWGV18SgfTa/q7e0AgALIHJA=
Date:   Thu, 17 Aug 2023 01:18:02 +0000
Message-ID: <DU0PR04MB94177015BD71516E0E1FEA53881AA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230812122411.3410399-1-peng.fan@oss.nxp.com>
 <ZNse/kwnG9WTc9cL@smile.fi.intel.com>
In-Reply-To: <ZNse/kwnG9WTc9cL@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU2PR04MB9146:EE_
x-ms-office365-filtering-correlation-id: 4dbd8d41-f6bf-42fb-43aa-08db9ebfcd87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d0T+oG6oOyehp/DrauJ+dEy6E+oO0H1dsA22xCzjnDJ/BTB29hnlgeyPanGqEOodtrPZLzNCsiPyiK4UQVMHPvnTSgIUFOeg7iOybVN+P955Fafv78ho+eeuKplaXcifDAasM1cSUBOJveeJ4Ey4QFQalqDa6qgqyMjQRlba5spVa0GDn6hZGwWsyysg2g7Gd+VaEyrt7QHHmsfkT2x7elNkqLq8WLZkMACtAtZrHVihD7PKGZhOut0CBNho/wabcECQazWT3ycX9fDjY+LvprQ9c58SbJ9sSZKX52+OozgLnC0fzltQZGOSC3pCammJhUf00j5XEB4RjF3w1YW1erIyMUZnZTbTd/jzEKMSmSPSm+0uaiKRk4w1/wcY8CF6TFWpy0CzfGTjhkXBYapOOJbJk/bb5OMMIs91929Ihg9YPgkgDu0AMbHTNFDTBaYEOr48yGPy62RzMpSQbFlZLEg1sMNwzdKBUjUlRT/3aop5ywNoiitMPFwHydt7nle3CgBGaM+P0mT5AVDlob1JM2ma7xU0dmWik96mCzU8UTMXBk9o3iJ/PyUq/nGiW8qA/bTEAe1qbkCBZZqfPeXpcUH+ITN25RgUwHvgHMZw2s14imVF/XSiEXQiixbC32MN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199024)(1800799009)(186009)(316002)(110136005)(54906003)(66556008)(66946007)(66476007)(64756008)(76116006)(66446008)(122000001)(5660300002)(41300700001)(52536014)(44832011)(38100700002)(38070700005)(4326008)(8936002)(8676002)(26005)(2906002)(83380400001)(55016003)(478600001)(86362001)(9686003)(33656002)(7696005)(6506007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mAunBdMUqMu5LSvMjgPBDIoqI8COAqyZjcZomCDW95uHMu4mmNRXga/Vov+Q?=
 =?us-ascii?Q?UYrbunpuDHaEsmY+PgiHOoU4Rz4HehX7JzfksNkgi3f/Pe5Kx4vZcbW1caQG?=
 =?us-ascii?Q?MLP034Rs/4bNgf930n4NvFiIl4XqkQbK1W8omV7CJaVkvmAuHHlnGuvKfXA4?=
 =?us-ascii?Q?R2AxgyNzci8T4bwyrGqTZP94vqxR7AzYdOC8/bezqK176igLLYmR8HveGosa?=
 =?us-ascii?Q?QDbV0+dObbP1WEu//8SyrgMJ9k49QmfhqL63rveHh3kUulbBFl5A7801swdC?=
 =?us-ascii?Q?ccyGlLwnQNjJg1DnzIf3v0cqfiP9vf1c8Vqz/VZrC0k/SbbVXbpd3QpdeiiA?=
 =?us-ascii?Q?EMOa5nLWjvV5PBCbyCvN5YdUGWguyUi2xQQ3oVq2pS+iME7FcoXlffZHdCjY?=
 =?us-ascii?Q?TfIaZUNzH7kzO8YLLow/qQPZtKqhO1ZzPy/2gOWat4FQ4rM+Hwj8g6zSf+82?=
 =?us-ascii?Q?Zce3DltPy8eYNCMbdDla7Oh19fNZ9m3t7l1i6GCN+oAIfWQllSUyiA6Nzt0y?=
 =?us-ascii?Q?1+uY4M+nkSMQGITwEoCeqdgRqSxdFlAA9efsSGnTMfcA8tzHV3bu425Eog7X?=
 =?us-ascii?Q?AuVcze4f1Z0MIcq5UFrIC6yevdvqIMXzm8a/U5QJvC734kyxv6A5yCAd2wRA?=
 =?us-ascii?Q?zKXGYuPyich3IDXcG+S8G1Xu1qk4oXCQlWHQTmX5ebzaKdqxvfUiFKyTdT7+?=
 =?us-ascii?Q?Rl9R+VPYmeHouG9Ct4JMx8lDj4fmz5gdnn8wtH9RRIwohx8GtPGwL/nyYwff?=
 =?us-ascii?Q?V3lAEd9BNf5Hdv1bPk4k736GL53HxJwPLdS8PBxsqdelB03hzULLMptSEis4?=
 =?us-ascii?Q?qslF3BAp3Y3wp8e66wyZGJ+Bqm0X7OBnu79fRhLVpc8oAl9banwsnwFA5TZM?=
 =?us-ascii?Q?pm7GRCiPMgZqznRDVD4Ujh3eaYUQo//73btFa4P19S6PCC3Um9QE7dnpYLUK?=
 =?us-ascii?Q?wi4vb7SzIb3/ULMKu/z+Z+3WisQLxbuUaXOZ3iUw+BL2o7+5FciqBuKdReV/?=
 =?us-ascii?Q?ol1uOhWA2IHHF4jVrN+M0XcBX7TsT/BPw2K6amcGaqNunvZXiXNkFYvktVdu?=
 =?us-ascii?Q?uw/zkY8ehZepRqz9RVgk25HAqSx9ZXzGeHnFd3rh4gx6SO7Kg2OSsen7Blb8?=
 =?us-ascii?Q?BmWm5NexlFcyoJEG8gahFqnW1wHyTPXx0F2AEEskaAhanovLZKCf+f2nyxme?=
 =?us-ascii?Q?VHwxr+nSKmpE1+jCi8yeXRXFcNS2JupJbXfqm9TVDeL5P0yj/OUwp3y1im/h?=
 =?us-ascii?Q?vgQcNkhOpEc91vNmsjrJ416J3WtS+rx8kaC550GhuPzENfdFPZJyUtw1jIx+?=
 =?us-ascii?Q?AZZr8an6fMaHLQ+6F0WAQ6INToRlj5Ea2vOoCzu1jHqBpPVk/gIECiIyVDdv?=
 =?us-ascii?Q?cIvbutg9MpBanjh9i17063P5mo/pTh7/ByKwQotWciCvXBLILuZeepRdZ8wF?=
 =?us-ascii?Q?8Yx5dpwJaZXDw7y2akLRX5cK0rNjiGRYy9MkIq22V+zzauecR8LWg3gWOjW0?=
 =?us-ascii?Q?MOte+gEh5xtEHx4l1qaEWuTzzWpDjqk/FFXdlXRo6xXVJpV0fyjLkEhAwjLS?=
 =?us-ascii?Q?ARY2VTZDigAnaBSf5+c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbd8d41-f6bf-42fb-43aa-08db9ebfcd87
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 01:18:02.6595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Cp3mhPjFB47QMkETHudlafGIHrkOCXWhbhZKIeoPolJhydO0567EQYaxcP5eJIM/2oYihFjZhx7r/DryBPYTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

> Subject: Re: [PATCH] of/platform: increase refcount of fwnode
>=20
> On Sat, Aug 12, 2023 at 08:24:11PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > commit 0f8e5651095b
> > ("of/platform: Propagate firmware node by calling device_set_node()")
> > use of_fwnode_handle to replace of_node_get, which introduces a side
> > effect that the refcount is not increased. Then the out of tree
> > jailhouse hypervisor enable/disable test will trigger kernel dump in
> > of_overlay_remove, with the following sequence "
> >    of_changeset_revert(&overlay_changeset);
> >    of_changeset_destroy(&overlay_changeset);
> >    of_overlay_remove(&overlay_id);
> > "
> >
> > So increase the refcount to avoid issues.
>=20
> Right, thank you for the report!
> I was too busy to send myself a fix (I realized about the issue).
> But what I think about this the actual platform code has to be balanced w=
ith
> this. I dunno why we have OF code do one part and the platform core do
> the other.=20

No idea, Rob may comment.

It's not obvious and prone to mistakes (like I made).
>=20
> Let me look to this closer.

It is 6.5-rc6 now, I hope we could land a fix. If you have better fix, that
would be great.

Thanks,
Peng.

>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

