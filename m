Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C0E77F3A9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349767AbjHQJk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349757AbjHQJkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:40:25 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87F6271F;
        Thu, 17 Aug 2023 02:40:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yo+vYNyqiSZUy5EGIvwoRoaWqxc1wiqhT9644sazJq7bWTfn/KGP6xustWjAfz49WvpyyGyua74L82YKTrxRRunm63zW/fTM+y4GUIwEf4CSs5YINgrRvR0d7MdLQFjKcaWA/bW3DHCK4AF8DJljXNraHHT1UkSg3o7uVe8rAgPqAWOo3mNzWUAkSMwX6MIfIksxon7gvhdEWKifHXJvHxNQjPxb6LqFVS9BiDmjrMkpwzF1dpBXAfptmqVeqMTYywOpUP3rTZAVhZJiXyuWS9rkt6lmpHnn9KDRy3/WltqdGOna6+4XVDTjNBjC0p425sYGkpHWr+xu88bi7Gw8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lS8+NZ3eKkgobwArRGgBrkAQLAt0wOH1anJH+3YRwhI=;
 b=N0Lb72rhB04DoPkMkpAm/DKFWZchEq9jAMlpOYXcMNDGC+yPlK+CuwK+KCBbjjcfNtnqgnu8vH44fqZ7XcYZVAvQYTWfJv8Upe+Ijdjf/9T/IWHHEBFv6FkQVvhHK9jH1JpZUeUaf6ts6RqkxEjrrCCKKTB5EX+U31jvhSH5Fl14x70vYac69IxGF9FkTkWLfFWKGGLKl/zHvS2FkPi7AjSkPNcnVeeCxRzuz4c3+jpD8FbMWWMzKR81XcQ2ww2BdZ89lrpcsgMz6bbiO1uV3PTlHDaUJCCbW4fT0ze+jx6cDAbJkDQKd3mZasuu14DnqFxu3pMnQFqq1mEwd/erJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lS8+NZ3eKkgobwArRGgBrkAQLAt0wOH1anJH+3YRwhI=;
 b=ZkRM/H4HWHNiHtKN0j6aQubDndYFgGe/gk7PJaJTwb9Wy+nyBTANO5reokL36iYaMgGulj98FjgQR5Z1Cdl7u/TFz3VByvDaWCPWkE9p1Im2SH6npfIBW+kLyTcgmVVFppHtt9UspWMY4jTy2Q/3BQnFWrBom5OGN8o12tOAu/Q=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7863.eurprd04.prod.outlook.com (2603:10a6:20b:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 09:40:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 09:40:21 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Patrice Chotard <patrice.chotard@st.com>,
        Ajay Agarwal <ajayagarwal@google.com>,
        Michael Shavit <mshavit@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PM: sleep: Add helpers to allow a device to remain
 powered-on
Thread-Topic: [PATCH] PM: sleep: Add helpers to allow a device to remain
 powered-on
Thread-Index: AQHZy6a5h2L2zZgR2UWVt50Q2gWV06/uRivA
Date:   Thu, 17 Aug 2023 09:40:21 +0000
Message-ID: <DU0PR04MB94175C3C8869A61403975E76881AA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230810162119.152589-1-ulf.hansson@linaro.org>
In-Reply-To: <20230810162119.152589-1-ulf.hansson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB7863:EE_
x-ms-office365-filtering-correlation-id: a22f4370-8975-46b7-86ef-08db9f05f99a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ycyLVrvvyo1zTLo1p2qkygGgJpYYyAYkT1HX6GpvWCZLkMfyOpyJK1TSXqlDHJvS2TmyL1uhhbolXUMs3qpeawKGqx1mjGdx8x0yEqrP3r1xpOLfP4PtGljR+yjrlWLFQg14wS4Hku54jq+dwhoeqshIvWZm1Nd9ieXGmkJyFZvkYuxDStHJf3K1NKu9z5Kq3bY1CjCcEMtk0og8J+vZqXXw3dh6rzagmOsSyn6a7TGkWPiyWOoqUHye7skbun9o0D8bnHuYQT6EaeKegFjGCMa4WADo5rumbXJsAGU5uanlR3qGX0H9LwFQ0nPaJFHNR7RIzHfaxolJoEzAn5ROdoLcADgIFUxklUjVWgNGtjeAThJae4k46Cqzh7Q2GgD4vZCctq62kEssWpRl89SLelRRN6Z0RRlHDfH2SH9UbFQ731NHieYXWkChs4/9ytNS4dWbHuqZDoJ5mBfEDTZVpoOuAQ/YjJabzjkYYaOrFSByewbAj7WWddmovmFb8K7eq9PGawMYV1rQTPLgzIWoPh8i7B0qxTmqlukZpCvwkAxeu65yGUN2TbD7X/KXEIZS4m9kK2eU5ZxCHKy0+7YqJ2HJ6AwnSVeDUl3k2LpgM22j9PBPErX4IbpBxuGGK9z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(1800799009)(186009)(451199024)(55016003)(66899024)(7416002)(83380400001)(2906002)(110136005)(66946007)(76116006)(478600001)(66556008)(66476007)(66446008)(6506007)(7696005)(54906003)(71200400001)(64756008)(316002)(52536014)(44832011)(5660300002)(26005)(4326008)(8936002)(8676002)(9686003)(41300700001)(33656002)(86362001)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XGgHtCm+/mzYYpP5YXWKnvKT0iI+s8SVLlmGhRq7j0hGXDFi845CVtK+Jv38?=
 =?us-ascii?Q?b0D+i0tYKUjMCzNhBdHPjBu60TnhzLGgS8T3ugeGK00TWPnPS5I7JV6WDQ+6?=
 =?us-ascii?Q?ss2vdW1O/jjA2NZdXJGgAIOotlBv9LfnAmMbEv92tENOSoVpw+GnqowSFT6I?=
 =?us-ascii?Q?OBOKmO4APmjyHNC/XvFkmo2S1SJAKYT0sc9QplL4p/Nn7WGGfnzW9oHI6Whg?=
 =?us-ascii?Q?UeukekKEucEnUVzCCmRVx3SQ8JFBRFMAqizS3W4QwYrcdshqfijTk371fBdp?=
 =?us-ascii?Q?cgFZZLdJUkv0RRBZ3oX2N00UCgj8BLvUb3Qj5ubXXPgFaBNVMDterGEld1jI?=
 =?us-ascii?Q?o31ygVHPM9usBO7Ravzzu4js7C2XNVXGCI5kj6WF+naedWXcKVQfAmwxvH53?=
 =?us-ascii?Q?T6iucGu81tYWxOu8jgERs3gYgxffXhEEyqBw87E5jU1/+A7SX8BP2R5mhUD3?=
 =?us-ascii?Q?Xg/M0R3AdW/smBu2ajXOhm4aLpp2Pu8EiPLHkU/XvXqLTVn+wU+27eGczJnB?=
 =?us-ascii?Q?H3i27urjCwjXIZRkNyC+SJvZBNafWnR5ZqoWGFeXnQ2Hjsumwh5Ma2BemH64?=
 =?us-ascii?Q?ohoYIfusoBOQ0ZaX+HJLH/pgAPF33FHw9Tr2zkhRMm3L2Dxtcknq225Bvey6?=
 =?us-ascii?Q?mr2SXy0RIh3dC/e2saWWbGq455wb6Kcn5c7nmofbPQANc1K3HoygSSTGLSOt?=
 =?us-ascii?Q?ClDwsJcbjcWasfv3pdcPWi+tdlqSpMv+0KPrWz5uAjLjqnuDFJpp5W2Al/zb?=
 =?us-ascii?Q?AmnoVQPyoQfll5ApfazaUxQr2qfpScABdZR3vXw+6O4KzRR38z5AGcMJPmuz?=
 =?us-ascii?Q?xgQewJmh5vC1yP7e7q2BNJ1vrdDL8hXgRyNwQW0ziMozj3WBsRGAzHEgEC04?=
 =?us-ascii?Q?lnQebR0SmHyqFSITmwSWdNTPkh4ziW9F1XpOheQXPnlPRrQFheJspLFWRpZd?=
 =?us-ascii?Q?uShOjfyHQ+VkHt44vOrcdDA4rL8Vu2A5i+JCHrDzDksc+De9DzNnLtwMPebz?=
 =?us-ascii?Q?6fbnj+xltjsJaX0cJvMoUzkj1ShHuSRKR3AApYTGIfPdx+Qax1F7xQ2rFuq/?=
 =?us-ascii?Q?OtnI5sgWdveLC6Beb42C2NJ7j3Hb3BopQ5/fKifq6BwAbEYtCP2UjJLy3rEU?=
 =?us-ascii?Q?Cl2IFv+hT5ikSRoSAeT2Oi7CxsolHt+v9786BEnmpAWvNZmMycSCVD+PIqvG?=
 =?us-ascii?Q?akjiDNu4OUKAopDJ6LpACPgOJ0qSJr0rV35MV3lWWOrBPGNNRoVod5vV82T0?=
 =?us-ascii?Q?R45MUPEquDBH6p+q2asu48W4eXW+7BuYrrGLWNDJ6XqWXr4IkArYpKVa5YEl?=
 =?us-ascii?Q?AeOfRM2xF/izgTnEhU4wfXD65XyKIm952D3/QOiXK7YbzY+OZdb0Tyj83dn5?=
 =?us-ascii?Q?9JIUGkP6bQPJ8jJcdSq6uLImcFTCYR3zjen24I0PRcYm633EuPI6e8zKrOQt?=
 =?us-ascii?Q?fop2CzEcY6rRELt1Ctgg03wsvFSxLTzxkN1VLWmNgF9jiay60lguNT3ZDBhl?=
 =?us-ascii?Q?xNIvjMzr2lEm94MrK+bJ/G6CIgBDmd/eTe9d3QsEApJ0HHKCT0k3eJbRDowi?=
 =?us-ascii?Q?dFalSv5ZcyXoieAOWLQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a22f4370-8975-46b7-86ef-08db9f05f99a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 09:40:21.3769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H7jdr8edwNz6hjKox4m5WpYUlQ4itZrTO01FjQ28dwiisWMp7AA2KBE6gfpCR3RoyIwCI5v5ijbsBmMLIlhHdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7863
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] PM: sleep: Add helpers to allow a device to remain
> powered-on
>=20
> On some platforms a device and its corresponding PM domain, may need to
> remain powered-on during system wide suspend, to support various use
> cases.
> For example, when the console_suspend_enabled flag is unset for a serial
> controller, the corresponding device may need to remain powered on.
> Other use cases exists too.
>=20
> In fact, we already have the mechanism in the PM core to deal with these
> kind of use cases. However, the current naming of the corresponding
> functions/flags clearly suggests these should be use for system wakeup.
> See device_wakeup_path(), device_set_wakeup_path and
> dev->power.wakeup_path.
>=20
> As a way to extend the use of the existing mechanism, let's introduce two
> new helpers functions, device_awake_path() and device_set_awake_path().
> At this point, let them act as wrappers of the existing functions. Ideall=
y,
> when all users have been converted to use the new helpers, we may decide
> to drop the old ones and rename the flag.
>=20
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
