Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D9E7BA402
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbjJEQDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237356AbjJEQDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:03:16 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2114.outbound.protection.outlook.com [40.107.113.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68239012;
        Thu,  5 Oct 2023 08:54:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7erfFxNjeBr1HfUkcR9ESW9oO7Yfhvmm5nmv3zOzfz/GM9+W8bPGD2gKq9OZT2YveBRqZkMjbp1SPy2X1LuLTpN2dYrKelX/y7npK7MRdYKCh+PGw5xjunME3ImqclXUUufH0wFETa6mEtBGCIyxOSB2sQpNSzlKK0d1Ic3OZaO5Y+EQ/8GiViZ5/FR3txG9kSU68GYCrbjgCLvJ8mwjO7jHLrq5HSXYO5LTL7tg5AYR4dDetJW8r76qz998x3BvXXZ8daXKQqZwnCzmjfSBZZyth4yO12WS9Z3AWSs4scUdye76iUTq1XGg8uXc1HLt+DrbAOAeuW/aske847cBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Zi6M5wrjkV9CXP4VWW6dGgirAkr5hySNfsqsWCYuHk=;
 b=M3G+xVc95YLjkCcXJPQGGWAX2HBGyOs0XxyRPUCErNN27cw0RriLJhOPu2GfZno7UmppiG+LNHE6Te/Jj5cnc39FmGsmoQNkq52oFIXyfu5UOjeqqDvjoj6is0r82ErjQGXPbVe4uhm2VuudOfhGtYglJ5BDIB4xofuByGP4IF/CYX4frTcJ9wTkba0gQUzdd6dvZAXYO7XMnUp3nGdBjnS3V2idA4KeEhBn2UDgU0ew7nna1UdoBZ4my5e7t5JBS+z/dpuqsTDWaD6swyqEJ1Y/0WSwy4VOkOAKoWuNLGfTywu8xTZQxm6cKDncMbofNQVJbCNnApoXrw2wQx37aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Zi6M5wrjkV9CXP4VWW6dGgirAkr5hySNfsqsWCYuHk=;
 b=bbdZjt99KDwy68QPBn37viTTxuhzCqYjpdu8UEEKO08agxkhFoxx1s77OxZ0K4WHJyzfgbAzfSamyZtYtHgu4O2cXf4xFaiEkWUg0pWpUkkMw2nYsNNqyrw84eHgB7nP5WN/ONAtfcdhKwXucZhEN35CHDPb72Zg6U3gBZp2B8M=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10005.jpnprd01.prod.outlook.com (2603:1096:400:1e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 15:54:43 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 15:54:43 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Lee Jones <lee@kernel.org>
CC:     Pavel Machek <pavel@ucw.cz>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v3 0/2] Match data improvements for pca955x driver
Thread-Topic: [PATCH v3 0/2] Match data improvements for pca955x driver
Thread-Index: AQHZ88dsO0axnR78PE2fJjAKMlDh77A7M2UAgAAjXYCAAAm5AIAAAEJw
Date:   Thu, 5 Oct 2023 15:54:42 +0000
Message-ID: <OS0PR01MB5922402C1C3260675B49981786CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230930175615.13301-1-biju.das.jz@bp.renesas.com>
 <20231005131140.GC681678@google.com>
 <OS0PR01MB59221DB73988292DE753DF6F86CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20231005155302.GC808963@google.com>
In-Reply-To: <20231005155302.GC808963@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB10005:EE_
x-ms-office365-filtering-correlation-id: 9680311d-083d-4f65-7961-08dbc5bb63fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DIDfiN1xiu8Dqjp7QTYIgkbuhvfM1o4lfLyE4zPXtXgKE1zAgifhknm88G+2Bli63ooyrTTftlUsxavtXMcHVVmvy5jDM6aGCoFd6myiOskeajePVRQ8zM5t9G375X26IgiTSvw2PTgJ2Jjr0JgTMKZtOC60Bsq7/vthX24fm/YsWQSf+5mnjF66XDan7WX5BBQekvwvIr/VwEJNUl78/6UPoVTYj15eVUepNmB/TVvFHMBtZEyoTVRTUna8xuvYaHAxaIiNoNTf+CHn5B4PC046MTwciwTI4S9UM45+CguYz47HbjBp0GbZNCxuG5c8SurFOY5sG7yfti8KHj7p+a8OGEGczOzykx0axX2MNTTuFDqiXrTTCPUbO89CkFxJvalC+eUjUgDTjLM59Wru9arBW+GP0bjqxi3Zj9Rj8f40w8fpt7znwU8RYSGVeODLtnBp1Q0YbZVmfcAv4o10XUSICkfBhx+1lULfsONNppKGSorQseErLzJeb5jHSCUqA4ptDYIUdV5b81qzpmK9GU70JB723mi12LJm9lXYeQks81YFtpi0nCdLRz5UAhueByJ2K5t0h61j0BrsgnrQgT6yUU5rfqD1UjS+yEwjOQuND3CbWT48PCJDwqDfqcsU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(83380400001)(8936002)(52536014)(33656002)(5660300002)(4326008)(8676002)(53546011)(26005)(71200400001)(7696005)(6506007)(122000001)(9686003)(66476007)(86362001)(66556008)(66446008)(38070700005)(55016003)(38100700002)(2906002)(478600001)(6916009)(64756008)(54906003)(76116006)(316002)(66946007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4jM6miiuPzmI8xrgrw3fExhnBdmNuF2st0UFyZXRXrS0wzXI8WRE1Ln3E91u?=
 =?us-ascii?Q?JtQAzcwEqfqmI3VRuPITTaE4fQy1Hzqf4pGnluRdGYmpjo7hlfjLT+6iE2Ow?=
 =?us-ascii?Q?I8b9lelxqTQZBj1piLohZWUXAMohPWjIr/PrHniE6U6+TDvcmCgcNfDlAxov?=
 =?us-ascii?Q?kBK/LLuAogPQFoEGZZUzZgAMcanF+JoweHl74XMR+3JG84BXKeF/iMWNJ2Hw?=
 =?us-ascii?Q?J9jZcqTh6kEQeperpbtW/T6F3qZGt0/JkSHTB2OqGFPLsn6tj7K02u6tdwZO?=
 =?us-ascii?Q?rlvDRlONpduw37o4+jdgj+Vo5y/gWmP0fK6c8d0INFxgg6CpSOHWeb7aiQqw?=
 =?us-ascii?Q?3weXmDQE2cPIb/ZZ492xTJ/9Vvgr6I0i9XOFXkPuNrTLMFZ4qq2NCicDRwHj?=
 =?us-ascii?Q?rEGFU/KpzbxS6Qq71rnd50jCPimgqP4/IBZb7Q1Jwcq7h8fNsUU5yR4S001F?=
 =?us-ascii?Q?pk6lPHrX7+UePWCwltowMUtBEn+KE+YGKIQiyI+3esBNSa0atzZY/F2PsJfC?=
 =?us-ascii?Q?N5Jpfl+D0Kj6O6AJ6KnYvSgZE83AZbhcStxEVNJEFpWOaJVZx0N9cBly1h9b?=
 =?us-ascii?Q?kige934GkEI3VT6MxT9TRBkAsZ+3Y+VpBYqp/iNdruTjnBFzDrfFWUI0gmC2?=
 =?us-ascii?Q?GOEOAfz0XYhZcjZS4S+9H6cornANArMicWxMQlshWDH+D8HD0u4gObMOL6oj?=
 =?us-ascii?Q?IYKDqClWHT08U7tN/R8fUa1aVG3+ftBNzBG6avAsFuZx0uvdGo0mP5hLs0uv?=
 =?us-ascii?Q?J98kC6EaE9Uuv53u2hJZwHoUFFi/94VgSpyk0J8/gfG35Fdw2IGB7Iv3hFVz?=
 =?us-ascii?Q?pfMMwxK7GqQbEWUp8ZZN2SYdl8sVrXf/+0cvnZP9iys9AiMD0sdWXRkRLfLS?=
 =?us-ascii?Q?tAsCok7XyNvhaPJ8UF5HZ894elIFO0m1/w/cPFcwUGEJMZxpu4rKRacMefN0?=
 =?us-ascii?Q?QBLP4tt4DsDzOyNDv7HpHtzyiq0IlS8cT1Y/pcPhVDE5irDdS78jHGeSZe1s?=
 =?us-ascii?Q?CHOmzvdX/v4qBzTQdZUKho1e+mt+3hDnJo7rUA1YGpLfFTayZeYSxzCHvXIk?=
 =?us-ascii?Q?KwnHJTiRPCEPdkz4RSydfTFQUAVwBsI598EbSoeqUHNsjFHK3+po+2TV3YtF?=
 =?us-ascii?Q?cpeAMXwV35hudnjQ0GDe2odxIf19Zs+1qvhBSgHc4pqS/tLMW3dDbaeyit0n?=
 =?us-ascii?Q?KGelqlGKmjYoBu6JPXNUjNDtESeAKKaQEUSkN1OiN47ZNI38OINFk0RCh7+w?=
 =?us-ascii?Q?E8457kkJlAWY4tXeFj1fydXPnoVEbT3qjN9Ol565ioyGNToZpxqAtNu6GV5e?=
 =?us-ascii?Q?9uYoeyyHyn5XQrKft7sbyctl56Fq6ljm0D5r+Rhmr65OI3PfGMei1Uyy3MYH?=
 =?us-ascii?Q?I+7BjtD8IKgsHAoIWj5M1Vwoo+sFn+mhkysi1lhrmr9A62v+CKnpwxoTdj+0?=
 =?us-ascii?Q?cnVbTtb/5cp4P4h/GNnDubCF3/T7P33KffYr25l6Ehf1I6bcNs6PiL5ymnsD?=
 =?us-ascii?Q?7evpHkM161yK6VY9SWVh8+wty1fyFkRzYTtREqRU33y9I+OqE1TgKIbVQQke?=
 =?us-ascii?Q?RDboT0j/3hgnOFTzUBxR6hTDkyJ3at+gdu5Fkf903A9ypyRKO65mVCfgo+oq?=
 =?us-ascii?Q?ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9680311d-083d-4f65-7961-08dbc5bb63fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 15:54:42.9985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oYd1MRsMOIfFDJNgzdwMD4GmAWtaqv8EjXfC1esJUxv0piSu4/Ec2PvTWJAASIiawCY3tVvSkhtygSA3QkPiyltmPcA6PX3UojnjA31gbdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10005
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH v3 0/2] Match data improvements for pca955x driver
>=20
> On Thu, 05 Oct 2023, Biju Das wrote:
>=20
> > Hi Lee Jones,
> >
> > > -----Original Message-----
> > > From: Lee Jones <lee@kernel.org>
> > > Sent: Thursday, October 5, 2023 2:12 PM
> > > To: Biju Das <biju.das.jz@bp.renesas.com>
> > > Cc: Pavel Machek <pavel@ucw.cz>; linux-leds@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; Biju Das <biju.das.au@gmail.com>; Andy
> > > Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Subject: Re: [PATCH v3 0/2] Match data improvements for pca955x
> > > driver
> > >
> > > On Sat, 30 Sep 2023, Biju Das wrote:
> > >
> > > > This patch series aims to add match data improvements for pca955x
> driver.
> > > >
> > > > This patch series is only compile tested.
> > > >
> > > > v2->v3:
> > > >  * Added Rb tag from Andy.
> > > >  * Dropped tabs from struct pca955x.
> > > > v1->v2:
> > > >  * Added Rb tag from Lee Jones for patch#1.
> > > >  * Adeed patch#2 for cleanup of OF/ID table terminators.
> > > >
> > > > Biju Das (2):
> > > >   leds: pca955x: Convert enum->pointer for data in the match tables
> > > >   leds: pca955x: Cleanup OF/ID table terminators
> > > >
> > > >  drivers/leds/leds-pca955x.c | 71
> > > > +++++++++++++++----------------------
> > > >  1 file changed, 29 insertions(+), 42 deletions(-)
> > >
> > > These no longer apply.
> > >
> > > Please rebase and submit a [RESEND] so I can apply them.
> >
> > Can you please point me to the tree I need to rebase?
> >
> > I believe previously I have rebased with [1], Please confirm.
> >
> > [1]
>=20
> Yes, that'll do.  Or if you're prepared to wait for the overnight-sync yo=
u
> can use Linux Next tomorrow.

OK, will wait for Linux Next.

Cheers,
Biju
