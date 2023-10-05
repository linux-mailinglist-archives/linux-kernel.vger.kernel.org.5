Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A067B9EEC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjJEOPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjJEONI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:13:08 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on20728.outbound.protection.outlook.com [IPv6:2a01:111:f403:700c::728])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F1183E6;
        Thu,  5 Oct 2023 00:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwHit44N1nSvxgvB8yKkCe2SgKk6z9SGbuEV5uQMTGjviNbNEfp1rVjc39SfDYu1r0fIMfeP0M99HdpvgbEIIHqhwnr6isEuZg4/tp8U2P2eg7pM3n3jgs306CBzkyRcxErua3nSNu6LJ9k6OF9focYVWsFtH2oQKFaHU2KiCq/SpL73AlIDhqnEhqu6x7fjbESicQ3ED0ir4iiOWJqoh/fc8KFekQZgl0EFWTiqFsDlHC85+uy2STrHUlFEh7p+rXIm0tR36lypED6Qxhz60azQE/hfHJ603uUmzzxJML3/eVME08Zhev8thrRE0KlfJ/CJozP2HtFoCXRdnOEoAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLsgvktaxu8QCF1Zqe83vK6jeFMsKKb5vJ9tht5IiVI=;
 b=cdLdQTXGxpX6+vHpGC76sBCTVe8qXqEAKiRLMFn7mA5OzBBA9EPqR5+6JPpA2zz3H0pF9lY+MFnCR8SAqjiqVuDUlFnMV/GVfXVHBoZOdv+GHh1OTzv89KDtbPAYJWs83pXlOxsDTAWXiX9Q+BXhCRNbk69ZNwHVyGXpnQG3k81sBvjG9LZRgiCR9HigYDd8xDzabbPeEV0cs4n3nWEWBlpvu2omge3xmDKDguLL+yZLRoBBTelh/HujDKKtEGFT3S60C2qb6KB5QPkR+xOKgqhDSG63qbqWh0BPLanf5mEVgWEEeUmy3/ij//jw812p+sCbfXkr5qxwmO8XuPZk1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLsgvktaxu8QCF1Zqe83vK6jeFMsKKb5vJ9tht5IiVI=;
 b=XqwX4dQK/5Jja0f0lpHQ+Cl+RkUVilr6Xk9trYfjWAC/FySFHvvsESOPef5Xk/7HFy3naPTUBtwwYMr6Q7QUimiWr9bCursT06DrIz9J0jEkBL8uWT13BppWR69B99nHsID1K+kdw2AR0IY+SBKyqtfojNxVdcFdXzl3gFJ3shU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB5991.jpnprd01.prod.outlook.com (2603:1096:604:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 07:58:04 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 07:58:04 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "bristot@redhat.com" <bristot@redhat.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "efault@gmx.de" <efault@gmx.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "joshdon@google.com" <joshdon@google.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        Pavel Machek <pavel@ucw.cz>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pjt@google.com" <pjt@google.com>,
        "qperret@google.com" <qperret@google.com>,
        "qyousef@layalina.io" <qyousef@layalina.io>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "timj@gnu.org" <timj@gnu.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "youssefesmat@chromium.org" <youssefesmat@chromium.org>,
        "yu.c.chen@intel.com" <yu.c.chen@intel.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: RE: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct
 se
Thread-Topic: Re: [PATCH] sched/fair: fix pick_eevdf to always find the
 correct se
Thread-Index: Adn3XJMEXg5HmmANSMuF9qI6/HDBQgABKAZA
Date:   Thu, 5 Oct 2023 07:58:04 +0000
Message-ID: <OS0PR01MB5922F9C13EB44AA99B3DC6C586CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <OS0PR01MB59220AF3959BDC5FEFC0340F86CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59220AF3959BDC5FEFC0340F86CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB5991:EE_
x-ms-office365-filtering-correlation-id: 882b71ff-ea3a-4067-2964-08dbc578ce13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jIFYTrajwjngltmLWdUXFEkpmob1vvF6qfrRKAJfwmtArWepGWln2qmD9u6F9/zgYN6VSGWWkb95/1hfLPAfDKHF+ioY34CEORVdjUxPTAlOP0wm1Z5AkkOmCXwz26CFZOa1+EK2TVI44Iot0WXnPMvF5pMXl1/XUqa9McdTmg+k510Yfrt9jMqY+mwKK5oLrLCDM4mNHsuJKAnbPqBIJP/gPGQGfXs+WHe+FY7pzMWzgr/F60NbifgYMeTqrQyiuUSx6PTdtBETw6dquMtBsr0GT4Jh23t36XWDASLN+Z66RIAcGeF01XUdX2xpkLxedS2voFrizn41FGordqG1SlWfMaUIy7tXPmvdcHAs9G7IE1YIwg59eZAk+yojQIsFwA/SRHv1p6+02XOIIdy9Xxk5ncBjbTybCo+d/kg4Pj91MvTL38gGH20q+ydJfOoLOkYHtsYp6Kn9tsrGW4oU+b4VO6QKUh91Q+dSUhZtH2zYSslvjdD5zkd9XAekhl5viLRcHD6ct5dXWkQaS5PgRdl8+xji1GOh3/eayHhMgUHvMgGllmaApfAY5wmfIKoxsESSIoa9pcvZe1lnXwe6IIkU3wqCx1VGXH4wZjeCQfQMtOPp3Q38CUy0/BdhjjnFfC+lcl5TH7XSjnJT+fFUTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(7416002)(83380400001)(52536014)(33656002)(5660300002)(8936002)(4326008)(8676002)(53546011)(26005)(7406005)(71200400001)(9686003)(6506007)(7696005)(2940100002)(122000001)(66476007)(66556008)(86362001)(66446008)(38070700005)(55016003)(38100700002)(2906002)(478600001)(966005)(54906003)(64756008)(76116006)(66946007)(110136005)(316002)(41300700001)(10126625003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1vWV5/exhJefLOJan80riSRE0kIAJSTyg/xUkanGivNxsfhD7oIixVF82pL7?=
 =?us-ascii?Q?x+Z9sKQEAp2D8yLOcCozNj6k8BOhgaTbBjU+BA4VAmM4WD90DrHbXp+czZ1n?=
 =?us-ascii?Q?Yk1x4/SDEV0CGA0rkR0zGO/8mOMUO52ZVgN9nmIaYDzqlGyajDye/9SRZToL?=
 =?us-ascii?Q?5x5X3w/uE0rqidkU65flDPxIt6e/xeIkR0fQa47uyrG4a/rOfI/Cqh8NM5ul?=
 =?us-ascii?Q?Vrf22STWsaGluFXBBrsC1x20amu+dR40Xev2bNKoeW/gcai3lvFY4Ns2ESzF?=
 =?us-ascii?Q?V6dWNUgOZO8ElAK1ve4QFfOVoC32ABUOMzolrSNIUc7bakhPigyRMywa6xqm?=
 =?us-ascii?Q?uNazWJkf6odI0ntUMS3C7xQdrdzF9W53RZQPssjkpaEBZRHHlQgWVxiq1O0J?=
 =?us-ascii?Q?lPCKGoWw9/PEfguZamThF8+SMtetvrWvBR05x2ccts8TRSKzrPTSAA4zpeWj?=
 =?us-ascii?Q?Wf60V/Cc5R2zFt/k9gbjs2ckko3/+9kwwJlzjoBQIcwHQrRN5VbxZEEpG12V?=
 =?us-ascii?Q?GVbQFc6eA/ePO8tS+m+HzDVC4Hpjqc72Jl4GW0cKz4HlkRF6yi2VlIN9Vp6a?=
 =?us-ascii?Q?snEByFNQjr2XktB+EIlfEsBMu0kA8Nx5eSp0Wl4wSMauzEEesHstZDMnyoFF?=
 =?us-ascii?Q?+4FgRSeogDbe7CklDv3JcdmealmVtFrMba5Jb0awErZa0EGiLbvlIhYoF1HA?=
 =?us-ascii?Q?IHHquQOfvzndoqzlylPIQ4XOjbA0MsGS6JJaczHgfVbh9LwHcBhByDPSDkIq?=
 =?us-ascii?Q?VwBkzkNjkEnOShhN6UdDUZHiK7K8S+101wybW7TGE6jbCKD1l+qxhindEl3M?=
 =?us-ascii?Q?F5c2QB8/tuXejQBda5MBG1C28SqwR3yY5+tk9My782DJ0WV7HuvNJsDep5gX?=
 =?us-ascii?Q?iZbKrZ080u0ltRQ9BGRS52i2Ji7epjkz9PUhOfBLiWtaMbqtwTxiYOUTFPEE?=
 =?us-ascii?Q?OuRyXR/T5HUCfEfAo2aaFMT0JCmF/hCbJFjL3LiA7i/CkxXGEs5TNgKPWxu9?=
 =?us-ascii?Q?inlXfy7g+wmIOqXmmqZpkC7+xUMjgKeRcOirGvfI3ucd1X6ZF/C3swf5vRLL?=
 =?us-ascii?Q?y5zlsJ+kc7QjlKg60raBdKZDQWKjyRkXn5Ph/VHJbahTEqZMB+DLFThIMYBw?=
 =?us-ascii?Q?HiAyG46ogtIHz4ZE0ot6EL6Uh8InBxlim6MLxNFErvHmGyJmF4CubclcRkmm?=
 =?us-ascii?Q?kUxdehLI2mnwadCXZAK8swCmWmgJ1JU16tqpyMYVkwCgCRdh/UIsOB7K140d?=
 =?us-ascii?Q?Fj30pFtEQloSopkVbxpSp9GqTCioTxMvCujJiJpHCLRuHVojp3aMG3cLoGt/?=
 =?us-ascii?Q?51zVIv+8sG38ruK2VxO+Qm7ioDa6WVycOSlJ9xvJlVKRbUxmAhiiXnTQ03Uk?=
 =?us-ascii?Q?B+pOCw7T5uR+efoV965mhOLgueH0pPiocV1K0NtYXwnwsFRo/SC56sxHiKwU?=
 =?us-ascii?Q?jRcLtpA8z2ik1SQt4gmx8EimyhB5enCWFWc+D0oa+NX/RVOhlUev2wjrTji/?=
 =?us-ascii?Q?lp+fDYHMGApvVSaVc17xzOTa2eOIRWrH81eron5Cl5jrtncACSX8ayLrgUqm?=
 =?us-ascii?Q?27anVHFIyG83tYEozyKs5Bi67YlMiH/IG6UCg2bv1/zhVWJ+fy2NKsMrOgXt?=
 =?us-ascii?Q?sA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882b71ff-ea3a-4067-2964-08dbc578ce13
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 07:58:04.6850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6PG2VTqoDMBfB6PLSNjDRH6hiKTJiWBAqVW32v40ePr64Ovv1fb7iH8mU8lILP1YsqKQWU013W3iSbO4zdpNgSPoHggrA7toD8MSJIpNF4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5991
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> -----Original Message-----
> From: Biju Das
> Sent: Thursday, October 5, 2023 8:32 AM
> Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correc=
t
> se
>=20
> Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correc=
t
> se
> Date: Wed, 4 Oct 2023 22:39:39 +0200	[thread overview]
> Message-ID: <c92bc8a6-225d-4fd2-88b5-8994090fb2de@samsung.com> (raw)
> In-Reply-To: <xm261qego72d.fsf_-_@google.com>
>=20
> Hi,
>=20
> On 30.09.2023 02:09, Benjamin Segall wrote:
> > The old pick_eevdf could fail to find the actual earliest eligible
> > deadline when it descended to the right looking for min_deadline, but
> > it turned out that that min_deadline wasn't actually eligible. In that
> > case we need to go back and search through any left branches we
> > skipped looking for the actual best _eligible_ min_deadline.
> >
> > This is more expensive, but still O(log n), and at worst should only
> > involve descending two branches of the rbtree.
> >
> > I've run this through a userspace stress test (thank you
> > tools/lib/rbtree.c), so hopefully this implementation doesn't miss any
> > corner cases.
> >
> > Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling
> > policy")
> > Signed-off-by: Ben Segall <bsegall@google.com>
>=20
> This patch causing issues [1] in Renesas RZ/G2L SMARC EVK platform.
> Reverting the patch fixes the warning messages
>=20
> [1]
> [   25.550898] EEVDF scheduling fail, picking leftmost
>=20
> [   15.109634] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   15.109636] WARNING: possible circular locking dependency detected
> [   15.109641] 6.6.0-rc4-next-20231005-arm64-renesas-ga03f9ebbbb4c #1165
> Not tainted
> [   15.109648] ------------------------------------------------------
> [   15.109649] migration/0/16 is trying to acquire lock:
> [   15.109654] ffff800081713460 (console_owner){..-.}-{0:0}, at:
> console_flush_all.constprop.0+0x1a0/0x438
> [   15.109694]
> [   15.109694] but task is already holding lock:
> [   15.109697] ffff00007fbd2298 (&rq->__lock){-.-.}-{2:2}, at:
> __schedule+0xd0/0xbe0
> [   15.109718]
> [   15.109718] which lock already depends on the new lock.
> [   15.109718]
> [   15.109720]
> [   15.109720] the existing dependency chain (in reverse order) is:
>=20
>    25.551560]  __down_trylock_console_sem+0x34/0xb8
> [   25.551567]  console_trylock+0x24/0x74
> [   25.551574]  vprintk_emit+0x114/0x388
> [   25.551581]  vprintk_default+0x34/0x3c
> [   25.551588]  vprintk+0x9c/0xb4
> [   25.551594]  _printk+0x58/0x7c
> [   25.551600]  pick_next_task_fair+0x274/0x480
> [   25.551608]  __schedule+0x154/0xbe0
> [   25.551616]  schedule+0x48/0x110
> [   25.551623]  worker_thread+0x1b8/0x3f8
> [   25.551630]  kthread+0x114/0x118
> [   25.551635]  ret_from_fork+0x10/0x20
> [  OK  ] Started System Logging Service.
> [   26.099203] EEVDF scheduling fail, picking leftmost

Complete log can be found here

https://pastebin.com/zZkRFiSf

Cheers,
Biju
