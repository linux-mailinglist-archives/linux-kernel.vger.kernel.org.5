Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216C680175C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441879AbjLAXMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAXMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:12:49 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2074.outbound.protection.outlook.com [40.107.14.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3BE1AD;
        Fri,  1 Dec 2023 15:12:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CunmPTeG8IqwhLlPhjEREiiqZMdPut9br+QVXtdNqtZ5bd5vPjUzNEqh0zPaq+2aaecbDBxzw7pfGFhpoYfBx3nURxOLrlW8s9I7pZZPOE/YtsBvJmKRiBVyAzeleDB7x2Bco8hXjpudE57BPJiGEa/gfa2f6t669oEgtE23avwyHeJfSdWqw6sRJ4SJjRtPMCVng+CmWETsIlJwnSsZ2Lf7mAUCW3CySNAhh8OPRjvpByfgPb/SE0SBF7C5tjGAV8piU9ONwhY/pz8dIWQk7oOfkxjA97Yn4LTenzZirdFNHdTK4GRAWuuad+AyTN5d1kgn+g3gw09kD9VUl+eWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJpaWabB7OGlx10laEFBEBQ7Z5ItxMEAQV/cVFjFAQk=;
 b=do9NH8eroPk8fbc2yt/4HQAT/hDJnvVgXqvOuOzekzFjsXVeZXxKUvjokpTeGBrD3jUYTw010hCNLTMfbLklgPbOR3TrBsRrUxhCFzAX23ZCxWjCMSBuG8f+lzx6Uf1br2Yv3GblMzYjq9PXy3fqvNbPgLA5JryZO796kDBWqqLUxWCy/43mvcjftPh5F3kk0Hd3J300FfHMw8NZyiZfO4PIbeR9Haz7XZegf2lZeEyqXFtfLQtiawR/L/nxXfqeGK6bgm+mMyLfxER0+sBz8YxMFVmCjKNdzuYUABDn7/gzSNz6HMRlK45oBIUOHluhBRIJaV+gdX68DKcnepqR7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJpaWabB7OGlx10laEFBEBQ7Z5ItxMEAQV/cVFjFAQk=;
 b=EXTfsjK4G817EcGfhJh1dz4KHZ5QfXd69RA1dX9+iXbicnWtJz9ao3XXQkCYJGNWEHsscXLZUC0TYpSeL0myyIs7ejeqCuCvr1pdpG32cGdaFY1qmiXd2WdJdm3ZGgEa4QpkIsGPfJvY7xlc2L80KOurqjroS1zDNK3MWTu2At8=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM0PR04MB6930.eurprd04.prod.outlook.com (2603:10a6:208:186::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.18; Fri, 1 Dec
 2023 23:12:52 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7068.012; Fri, 1 Dec 2023
 23:12:52 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v7 00/12] wifi: mwifiex: added code to support
 host mlme.
Thread-Topic: [EXT] Re: [PATCH v7 00/12] wifi: mwifiex: added code to support
 host mlme.
Thread-Index: AQHaIdVRwVjPeSM2JEKuatsKwEyar7CUVRkAgAAKKSqAALP1IA==
Date:   Fri, 1 Dec 2023 23:12:52 +0000
Message-ID: <PA4PR04MB963866B6DCE66489F177B8F8D181A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
        <ZWnIMGytEdDCySS8@francesco-nb.int.toradex.com> <878r6ertxx.fsf@kernel.org>
In-Reply-To: <878r6ertxx.fsf@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM0PR04MB6930:EE_
x-ms-office365-filtering-correlation-id: e309dc4c-4a67-443e-e467-08dbf2c30b7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YkeQ7wNug3kB3mLkd1DTAnx5gnGX1yKyxKTBYrVnLXOL52Ftd8hcd2xDc+jnEkgTR1v2O6JAqB/7S6zpynon2V+dUN7PsP4bO39IgLpO7/uNDykgkcF9u3L3p0yoU2wBRsG6ERQJ2+V034aIgRhozQcWML/oZJ0mMC71Ctus6ESxEVNQFKdPLKicBrDN25JUbEKLF9vQQSOGkBae0bTTSCnu6IjWEvUoIRljUr7Q1lXsVYJLOejKh/xRzlTSdc6y2Evm1Sxl7rOHrPbORC7cXm1ZTwskubJzuPtKE9D7OKXuIsQe2h9l6PciuOiRfKiWu4rRAdPkZB6aZ2uJ07QxUUfHAJRvEUDej6yY+8j73dNCBg1mfE9JX6/s2uwi/H3riD1Gudn3ORbIbDNieISTKhhMNveOy5x8GIVvKVeG2nvh6SqczXbQZ05E3DIFZpIP2AnMm4Irl52pcIH6cvsyLX/oNfPlYkcL/SmIRzAgre9XiY/Cq1fn+48f5ccmAO2UrLcykNSGuYCTMJzjSFeuMnJmNLo683AKZJLSqICWG3MAf5zrmOtb4J4HRFpptdAbQ75SD8wN7NO+5tCnmBUYa+c7BbwtdKe8lNQCU5FfzuZIXc9WFWHt+wLSdwFGTLZlTjs3mfrBK6ElooZc4t/WbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(396003)(136003)(84040400005)(230173577357003)(230922051799003)(230273577357003)(64100799003)(1800799012)(451199024)(186009)(5660300002)(55016003)(110136005)(54906003)(316002)(4326008)(66446008)(64756008)(66946007)(66556008)(76116006)(66476007)(38100700002)(41300700001)(83380400001)(26005)(8676002)(8936002)(33656002)(7696005)(86362001)(52536014)(71200400001)(45080400002)(2906002)(38070700009)(966005)(122000001)(9686003)(478600001)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W80PVVy3sxlznWIiRdvrwp082Elnh4tjqxiXDHFLI/ntYt1WxtknNEGo7vFd?=
 =?us-ascii?Q?7YcLMRF0rSZQZPmMq5xNhu/9FkQZ2gKDg+B941GPMHiK38R2XpEYMdwkf2Kh?=
 =?us-ascii?Q?/yut1C2YKEcSYALbE4aBbf/seMcF3U7+OyirNsLrqM8vk84naJUx/Gs5zpZl?=
 =?us-ascii?Q?Z+Ejo4ULfg64PY0TYmRQ8d54Nv8zNXHv6kXSu+GsS4SX2vOhhYShrP8pNX7O?=
 =?us-ascii?Q?ZJfwN6Th3AWzABzE/R4X5AGXgWcmJC/QEJ46O5UpLfhyYHKiAwSi1jJ1eO57?=
 =?us-ascii?Q?xJSJvWRF3ROHqtO6T++DLR81YjPUfTTB1inpkqYCGWeMpBfO61JEPMk8i5G3?=
 =?us-ascii?Q?atPGYeb9ogq8paC7JqdQZvnaR63SRMwxFiJg6teWGJ9pwVJ3+uKMcC600UVe?=
 =?us-ascii?Q?7rtiKhGXpHcL2fpWJVxl0nguysjsZxX1NfyVDRzfMTnrGbDRsEYxhU8nYj3o?=
 =?us-ascii?Q?QU0D2rLJZxER1narMSY9Udeip8B6jzykOtx0F6tfqFpq3ut5wezXi0+Rw5V3?=
 =?us-ascii?Q?zYHl90z1djNvCTXUtOCmooM4+3grgoQRinnK/AUP4cLBoTLiAq6xmUcPhqQk?=
 =?us-ascii?Q?7kpznsxodXbkzD/YTp/18BHGLiL0kDJ/MLQei4aN9RpVqAnb/mV4cS8KDMA9?=
 =?us-ascii?Q?oSgGoUhLWpaICEOEn4LZTTqAIx+wBIMKniLAAtRERkgsxEA93Om0uYbmz+d9?=
 =?us-ascii?Q?Cqx7rEvgHyKJYYDunPLM/DU+/nKLGzXyKTRixX4ajg8dMivq3nIHjxwIBO2l?=
 =?us-ascii?Q?9/PI9UDso3ae7mBMj6B/p2sytD0VKP3j6ft5HiSEWSEpRkHrIr2reGLPbqXN?=
 =?us-ascii?Q?UTlf4Wi1ikEJuYOYoBefd/+6cmH2aBtdxsoOIS9795kI+Giqq6yv6GBH+6c2?=
 =?us-ascii?Q?3kZSlr1U+B21g0lxvPUuyq3Fg1pvOLOYxdK62OqkxUt/co4jzWarXZxA5759?=
 =?us-ascii?Q?7b38alQSqGPnMDeqPiZLdqhyh6k/C/NvzoGiTU2xaM6VJWKyjqrHdxhxRy6V?=
 =?us-ascii?Q?UgbSuPozxb6vJvu2A3nI8hyMalnPjGCncxe87+Z39rEUaVYsYt184SekJ27d?=
 =?us-ascii?Q?PYRmZ6Vgj/Fay8yasARFTnZxmY05jxKf21wKKnEhFmlf0gbjNdapfcfTRY76?=
 =?us-ascii?Q?OTQdJMJsoBAuQ8bsU16Ahblx/e07nWY0XsZiHYZhEdm/mle0vLHm3CBfTh2O?=
 =?us-ascii?Q?w6BMzfxex6QWTrxDciiIJu8NjFtSRhKB3ZRfH4pn2YgJHsrnvp1IdvMGlic1?=
 =?us-ascii?Q?mkOdblrz0zP+ECF5cIZSkg/kTlQCb0syHZpCXAkhY1/7r6Y1lk3pOROp15ho?=
 =?us-ascii?Q?hxNxo3Zr6rQJ8yoNsXJYUxB7BWqT+RvhclurUgzUo4pg+2enxxYtS2wZVJeP?=
 =?us-ascii?Q?uMbE8+Ymn15cjA5rvdFWrZtZ23LqddlRTUt7LtEZw7yZciYlDO0Krz5GuKD4?=
 =?us-ascii?Q?uW3L4ecTWWjlkHYfHCYAwVvviaKuZ2cQP/L9858dNMcw69DeOy9VPooOdvdQ?=
 =?us-ascii?Q?PTGSqGsPRnWzcpQZC8j+rnljnPOf4w5nUkCQOC6D4/S5tOgtne4ebuV6T5wh?=
 =?us-ascii?Q?WYZuGQQGdMBrK+WD8VRpSp6g6D+0viz4UeP04vn9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e309dc4c-4a67-443e-e467-08dbf2c30b7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 23:12:52.7787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aaa9NSLNr3fG0XZAKAE6aniwoXXXZzAUFtSmTYkGXga66UzoOFIM9eDZX7wjRJZIJ+sVe6cyi8X8BhZ1jERxeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6930
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Kalle Valo <kvalo@kernel.org>
> Sent: Friday, December 1, 2023 8:25 PM
> To: Francesco Dolcini <francesco@dolcini.it>
> Cc: David Lin <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org;
> linux-kernel@vger.kernel.org; briannorris@chromium.org; Pete Hsieh
> <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH v7 00/12] wifi: mwifiex: added code to support
> host mlme.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Francesco Dolcini <francesco@dolcini.it> writes:
>=20
> > Hello Lin,
> > thanks for the patches here, I can clearly see that this code is going
> > through some real testing given the improvements you did lately.
> >
> > I have commented on the single patches, and honestly I did not look
> > into the code details at the moment.
> >
> > The major feedback from me is the following:
> >  1 - you should not add code with a bug and than fix a bug in the same
> >      series, you should have a non buggy patch in the first place (e.g.
> >      git --amend). (this applies till the patch is not merged into the
> >      maintainer tree, of course).
> >  2 - point 1 applies also to reviewer comments
> >  3 - if you have fixes that are not connected to the feature addition
> >      you are doing is beneficial to have those separated, this makes
> >      reviewing easier, they can be "prioritized" to some extent (given
> >      that they are fixes) and follow a slightly different patch flow
> >      (they can get applied, depending on the maintainers decision, when
> the
> >      merge window is closed and should be backported). Not to mention
> >      that smaller patch series are appreciated, "Maximum of 7-12 patche=
s
> >      per patchset " from [1]
> >
> > In general I would suggest you to have a look at [1], not sure how up
> > to date is that compared to the in-tree Documentation/process/.
>=20
> I haven't looked at the actual patches but a generic comment from me is t=
hat
> usually it's not a good idea for newcomers to submit a huge patchset like
> this. Start with something small, just with one patch first, learn the pr=
ocess
> and what we require from patches. After you have gained more knowledge
> you can start doing more complex stuff.
>=20

Can you help to check this patch?

https://patchwork.kernel.org/project/linux-wireless/patch/20231128082544.61=
3179-1-yu-hao.lin@nxp.com/

This is a very small patch and it really fixed issue of mwifiex.
> --
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
w
> ork.kernel.org%2Fproject%2Flinux-wireless%2Flist%2F&data=3D05%7C01%7Cyu-
> hao.lin%40nxp.com%7C47171ff92b204d48d7be08dbf26894c4%7C686ea1d3b
> c2b4c6fa92cd99c5c301635%7C0%7C0%7C638370303262144837%7CUnknown
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> wiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D%2FwH3UEUxKckAwlAVJkh
> 5LpR2L76a1uyOmxXVWiyTUmQ%3D&reserved=3D0
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwirel=
es
> s.wiki.kernel.org%2Fen%2Fdevelopers%2Fdocumentation%2Fsubmittingpatch
> es&data=3D05%7C01%7Cyu-hao.lin%40nxp.com%7C47171ff92b204d48d7be08d
> bf26894c4%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63837030
> 3262144837%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj
> oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DF
> I%2BwsMoSatv3woPhT2yWhHeFIi5pP1uzFQYUrynAZO0%3D&reserved=3D0
