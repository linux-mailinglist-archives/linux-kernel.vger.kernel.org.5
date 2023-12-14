Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA8C812526
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443027AbjLNCUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLNCUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:20:44 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61578BD;
        Wed, 13 Dec 2023 18:20:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7WG/DspcyvzhWOSlj712nL1J6f+yXH+9ylndy4VfuSCXdbNP/Me+y+mGxbZLiadglG37f3Mb58GR13QtCHQspPD5SBDVy878teJMXtAEGkdf9zxqekkgys3huTdOzmmBOaNMnCBuvAL2F6gfrR6QZphFeERYrTdvn8+OB9PAyHDuaJLQ79we/LtRxMGqZ3uG/ooOaSI+5LEm+NtkM5j/9RU4a8vGqhk+gXKTWmLpbh15P00UBGXDD/qrX6y+k/kx8VxEP9hC59sMD1l7UxrR1CPaH75xuyOIhevyV/9+73T6ajVvJBa4Gtd/h+CrIGIt+b56HCAr+2ZMTD868UJJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flqlZIL6m0N8CDq3wHTmY0ZyXGQ5lgxpKOi1iweAy+M=;
 b=jkYrVReg445BirFZzotqwF64N9l/9cUMjWLJHRcQXeG8/9V/aQ4TnJQqVgfjm/hbxKf642xLrDvRyAD1ajO7Ua+LE5HEQF4k2pb4yzLPx+woFPCLwD2uFnhTug0ATf2ZI82aq3o3mN6DEIIHwZO2hYQP6hbE1AUM0upDmmPRFSndTU+NPjJiZhtALkdlzJQ3h87yeSH4POjunb/UUmJli18cmCYPcP7qjQ5AM2rUDVTnJExxcr7u8Nu6tPX7f/I8VI+P9c8nxGpx/A0KxlgaVmm3GeEohg9NljRho5ODKJsNNCNsqN2cXAauLuMZp3qfFybKXIOWo58Ed/qwLVMXNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flqlZIL6m0N8CDq3wHTmY0ZyXGQ5lgxpKOi1iweAy+M=;
 b=EF3wqtcCwAGoduYJCsdZoiIFzGVvonzxufQnLdP1uv4Tmsmk+ERp8J2pkMSzhXFrJgMv4zA0TwAzv4z6i5pCtsPuaQDlWUr5Lyu3W0AaqW7gEvL9VFu+Wvuj5QzEFtuUoNCvxWk6F+nkFdjz80r2wdImozzFzjwUaCeArcy9ae8=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by PA4PR04MB7775.eurprd04.prod.outlook.com (2603:10a6:102:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Thu, 14 Dec
 2023 02:20:47 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7068.033; Thu, 14 Dec 2023
 02:20:47 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     Francesco Dolcini <francesco@dolcini.it>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v7 04/12] wifi: mwifiex: fixed missing WMM IE
 for assoc req.
Thread-Topic: [EXT] Re: [PATCH v7 04/12] wifi: mwifiex: fixed missing WMM IE
 for assoc req.
Thread-Index: AQHaIdVYu6BJedWzZkuajUNTuEil2bCUO9iAgADQvWCAExa5gIAAAKJg
Date:   Thu, 14 Dec 2023 02:20:47 +0000
Message-ID: <PA4PR04MB963845409055281417132AA3D18CA@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
 <20231128083115.613235-5-yu-hao.lin@nxp.com>
 <ZWmzAWlh7o4bLZB8@francesco-nb.int.toradex.com>
 <PA4PR04MB963816B99845D943B4D061E2D181A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZXplY3Gi6Fv19Y_t@google.com>
In-Reply-To: <ZXplY3Gi6Fv19Y_t@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|PA4PR04MB7775:EE_
x-ms-office365-filtering-correlation-id: 1f3e7503-371a-4a21-ec7f-08dbfc4b4873
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qJZJr35ye+6lsuYdHbJLnhcz2GDbmhvB/fkLVUATfWXdN41cwwFQXGu4FJnaJELeleBjd5hXLoHRa78RnwTsD0rmyNdQEnH2wAxcjTiqbyYydfHxHeaCy43LuljcwAImJ37qYWGuiLVYj+EVN4s4Mhhiu6EKT8ZN8zKW+wzhtLw6p1KZh5pBewQWu3+6LcllU/xiIlON9E5LmNdopaOVpHcKn2Bs5ofVYhL8I0Eb0qf8DbxIt2YAEUh75nxZa9CMqHG0CAjkoMyFits4O9D1pXT32U+5C8L29iYfft0UEnk9zF4wqUXKyEU7RW+iEWjLwSVT5o0ggY0nJnlXfozk4aYR/OIx2iAs12gwOBEDQENEM2A7FBBh73PHOUNEvqPfvc43AfFv5KW15Mn557IY9MqzDIvN34CQoFGSuS04gd3DdVLPMXxd4OmEnbqUk5ZarZp85+ogmPEpqLiL1hZ0haUuyW+Oj5S0j7Foh9dAEyDuwHLCmNBEmVdjc+gyvR3p7ICi2PzrCkpBiHmenrSYlHxn0wjIKt3qRieodgnr0Y17McjOHYBMsro9suNiGCvn7bCmpNmxLaImwIFEKw70DTrSDvnHCA1v/jY3r9uBB/AxAGXO/Kqdry7fj5hBOxD1/jpitqWvwvJD5p5vkB2Hkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(26005)(6506007)(53546011)(71200400001)(9686003)(52536014)(83380400001)(45080400002)(5660300002)(966005)(2906002)(41300700001)(4326008)(478600001)(54906003)(8676002)(8936002)(66946007)(66446008)(66556008)(7696005)(76116006)(64756008)(66476007)(316002)(6916009)(86362001)(38100700002)(33656002)(122000001)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aTmQJrFgKPYrAl/GxskwDSTrClN0mw0K8D5wPw6toxOI9dX24F4sl+ObZpHP?=
 =?us-ascii?Q?H72x9x6/yIyVa4wN0+H/ymxhIR90wpiwkrva8w1aUZMm02FmgEW+F3zP7bxi?=
 =?us-ascii?Q?yvOl73k0Rh0Vus/Bopp24MCU46lkS+tx6EOI+9Xc0vJY86+s34CkhInyfAI3?=
 =?us-ascii?Q?pxdXuCHv/mS/7SVheRxRVaH1gfMkdhUB7BflyeQdm2tRYX+apzQqA9LcHY+u?=
 =?us-ascii?Q?9DZLpdSGnHn6jkJG5pLj9K7x6+eTUWovtx5V9OdVGO4rkwgbe1QpLXC6gbBU?=
 =?us-ascii?Q?8IW9E3aKZAWrUekkQreE1j3luxC0Fey2HSY9ZOkvjVOQU58HbzfFWMTTuH6y?=
 =?us-ascii?Q?hPIisIhBmtbTHgrTXexZEAcjqFgtxk3KjkXdLLsG79ilx0UR8YZxOjB4TAbY?=
 =?us-ascii?Q?kVaFsAPUExcUcGS5/zYlFkVZfFBoxVITRn7YTdmx+w8QLKplthyamIXWbgtI?=
 =?us-ascii?Q?4v7IKUxJbAauOlI4M+rn/GHrkNCz7iVXCoSufFlbqEXgqwDpxs5EzsbnaQCn?=
 =?us-ascii?Q?5yqO23ZI7czSozJaGR3lCiU/jgfJKMH5KSC2tebEYKdIicixbZDQ1s70xJwF?=
 =?us-ascii?Q?iZ+1edtlOCMHu2nf6LkflFQCYhQX6QGuiV2Ww4QuQUhizaqSG0CkgELVIwSn?=
 =?us-ascii?Q?LP1y9JprcW/7gZjEubEoCiHNa4tt/QVq8ENVABO07vU5k72WXenE3B3KJpu3?=
 =?us-ascii?Q?cdUcdBaQasl4dmNNYXWPBFoBIEsIqsuXmyg0K+/ZDDTUuRUNTaJmJGCjy9mY?=
 =?us-ascii?Q?+o4Vvi3gHKdqTUC1Ijw6NvAxKNHfY8sodNHrW8CA6yHZp95Vm6Iy2y/vFOr7?=
 =?us-ascii?Q?KyJw4bxujUrTMKyNlrj/nduhK1XvHHz6UsuwSGi9aW1ZdwQPIJBCHnoLbtyp?=
 =?us-ascii?Q?UE3T/6aXeg++zwPoyH5zTeEsvL0tuIr0w0jaojV5Augn6DDV9kkKzBGMJFJl?=
 =?us-ascii?Q?uSaQ+fEZnQaIab3Va7tHuWBEOJo25eE4+JNZtK3w4LYcfOzM6SMWSserVUbL?=
 =?us-ascii?Q?VQk3q4onxH8t385UfhgGxyXU4BShMGbWK3ftoP8ZkLqweoqaD5WlrztYQXet?=
 =?us-ascii?Q?Y8zhAx49eovFr+P+MMSEDIU/rN/v3tsHp2RmLgHcKSvGtonZ6x/Ljkn7Dx9w?=
 =?us-ascii?Q?Uh8IWPRNtpKeUXv5LPLkPWadC0EjGz6v3bapLvHn+MVOfrcEs2dh2OvAryic?=
 =?us-ascii?Q?QwA+PdveetT2P1hS3gKvlm1SuYHpM4WHD/UkAP3RCIj49p17IiFPCZI2oXbj?=
 =?us-ascii?Q?2+lfuttxZM46R2tZ05nyfdwNjpceDNTaUjtGhlacH9yc1I6OCH3p65TEfnAU?=
 =?us-ascii?Q?+3GIGupYcI1Pqrht/Ggx4MuGa+y0O/h0s8fUtFAiknQlyiMnCmRDVqIWdwtM?=
 =?us-ascii?Q?0Azn/kBo3mHh8PZAonWnex2ApsphBS1b3QzBhSCDoFSHTVoYbLvsR5HU7+BY?=
 =?us-ascii?Q?PICAAVGbwrbeEvhdSxb+yl+VnCmpQJiEEmOvFjZ6XeDGfUctLhOaowf6rMIF?=
 =?us-ascii?Q?cVbV6EbygtKY7l3FFj+KTkX3PyBnlNmkWLAMhfLe/D/1aDM2URVwxUb4/Sv+?=
 =?us-ascii?Q?PEH+21oZOPvNBmC/XHrjU6SeDx+QGn30E9SWcrCC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3e7503-371a-4a21-ec7f-08dbfc4b4873
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 02:20:47.1020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CYWa6tDUT6VcMkSt+a53wa+Kv9FgDKP8Qt+1p0vmvoEcbwObE4WZBZk4jEdGtGM+a1jwRK9rRx0C+bcqBk552Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7775
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Brian Norris <briannorris@chromium.org>
> Sent: Thursday, December 14, 2023 10:16 AM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>; linux-wireless@vger.kernel.=
org;
> linux-kernel@vger.kernel.org; kvalo@kernel.org; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>
> Subject: Re: [EXT] Re: [PATCH v7 04/12] wifi: mwifiex: fixed missing WMM =
IE
> for assoc req.
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> On Fri, Dec 01, 2023 at 10:47:41PM +0000, David Lin wrote:
> > > From: Francesco Dolcini <francesco@dolcini.it>
> > > Sent: Friday, December 1, 2023 6:19 PM
>
> > > On Tue, Nov 28, 2023 at 04:31:07PM +0800, David Lin wrote:
> > > > Remain on channel must be removed after authentication is done.
> > > > Otherwise WMM setting for assoiation request will be removed.
> > >
> > > Same comment as patch 2, this seems a fixup of commit 1, you should
> > > fix that patch, not add a followup fixup commit.
> >
> > So you think patch 1 to 4 should be merged as a single patch? In fact,
> > patch 2 to 4 is issues reported by our QA for patch 1. If you insisted
> > merge all of them, I can do this for patch v8.
>
> In case you didn't get a sufficient answer elsewhere: yes, probably? We d=
on't
> care to see:
>
>   patch 1: introduce feature
>   patch 2: fix bug in patch 1
>   patch 3: fix bug in patch 1 and 2
>   patch 4: ...
>
>
> Just ... actually fix patch 1, and send 1 patch. (Or more, if you have se=
veral
> logical changes. Be sure to read [1].)
>
> In case you're used to GitHub: we don't work like GitHub, where people te=
nd
> to stack a bunch of incremental changes during review, and then the
> changes get squashed together before committing. We expect each patch to
> be a good commit, and that it will get committed as-is.
>
> If we're interested in the history and evolution of your changes, we can =
look
> at the mailing list archives.
>
> Brian

Thanks for your information. In fact Patch v8 is almost ready and it only i=
ncludes two patches: one for client mode and one for AP mode.

David

>
> [1]
> https://docs.ke/
> rnel.org%2Fprocess%2Fsubmitting-patches.html%23separate-your-changes&
> data=3D05%7C02%7Cyu-hao.lin%40nxp.com%7Cc031726831234d8efdf108dbfc4
> aa160%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638381169686
> 467616%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
> uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3Dfg0y2
> dg6hCyUyHyDnBQS3PmMQqJD5n1h2lpq0ea9tys%3D&reserved=3D0
