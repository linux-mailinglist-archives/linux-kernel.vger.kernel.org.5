Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65CE7BA51B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241230AbjJEQNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240948AbjJEQMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:12:19 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on20722.outbound.protection.outlook.com [IPv6:2a01:111:f403:700c::722])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9797D81;
        Thu,  5 Oct 2023 00:31:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5OLW0KVcEFt4B6hVYNWPEeFJjJrffGpOBW4YW9zl7Z7B3ZEOwsnpCCbnsuchfFXt2b6qMCvBDKX6aEYtXn/vRT2269612b7h2RgpfrhzqpssYqfEIXaBYHJkgm4u2D6munZQKPEYR5nHkjXtovWz7iIQTurrukjwBKEzLwJCu1ga1HcFm53BHyjyYxa18QdRnRP4SGw2CWSHCw3siYIN4ZareEXwxU+AFKdMRqKIYv6EeTvWxM66JuVoBbeQxZO0yv6VvEcIEwn4xcLDgdxKJhtq4dIS+YZSflcH44zOM+EX9mMf1f08dE7CRiUPQt/d4z9hB4egHS9lScrReyMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Jtnmj8kasg9IINjh/dFil/blqi/cQ3XjpVf+uY+g1Y=;
 b=oPDdfuzmFaBZ7uA2KHARPQQ0GHB7ljQ6SCYVC7hQgfBDqtzYFHom5z3uASY6qPHXNU6csu3GiTgdJJj5mWK8qFZKgcNgQHGIlJ2HlFYyCe2MOWhtMu0Ty9afBOIL9Ygsg1g2DWWjAOMFiC54iKO5Vfr75wa2Oh8ltAxIjIyXTOU8Lm+vncEXdJEHzqD+WbywMp2yn0PSk8rHtmN4Jg2Z3okshuNtPfF7dZgqJd+R5JgB2WIFE/ZQgaswiVKrmbpOuFKMy/TX1/VS/c4cwmoNMqEn+p7AXilISQFBnuozQcLaBqegZFsjEFnWJxHyZn6OLogiDlFFWeQD6+QMyeQO5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Jtnmj8kasg9IINjh/dFil/blqi/cQ3XjpVf+uY+g1Y=;
 b=DV2YUxPgYITchut9pVi0s/g2rNKxrAmhVEmTV8ZvppsAjC6abVcOSWzXIy1ZBVgU8cCeR1wTLc8DvHA3reF7PcTTKDSP3xMTkthHf2MEj01ngNEUFV6GDQ5f7NGz0hZVj4kkCyUMnaDky3907cAkjuV5znogzIlTMuYfQq37nV8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSRPR01MB11663.jpnprd01.prod.outlook.com (2603:1096:604:234::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 07:31:38 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 07:31:34 +0000
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
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct se
Thread-Topic: Re: [PATCH] sched/fair: fix pick_eevdf to always find the
 correct se
Thread-Index: Adn3XJMEXg5HmmANSMuF9qI6/HDBQg==
Date:   Thu, 5 Oct 2023 07:31:34 +0000
Message-ID: <OS0PR01MB59220AF3959BDC5FEFC0340F86CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSRPR01MB11663:EE_
x-ms-office365-filtering-correlation-id: fb35a1c0-1ee1-4ccb-4ca4-08dbc5751a73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4xxICLNjGi8pcB9LbjMZg+VYt3St0+DZsiF/1jyq4kZDzvGAEglIvG4DuLKCZ41VTtwFhsGrhd3oUMQzaga9M2UKfXCIpd2z1SyMi6VUVJO6Tfa5THECatJ19xD2jY0pFBy+GYgLrsq1U7BVk7xOwujo9rzqs+sFeY3RLa8THRCEBU9MuQqnQZOQ6JJwriFxn4ABnHKfQYsDgBH18lc9w8yuPS8cp7kPt/ZqBFc75s7fYvlC3vaKidrGFDqpBC6eiZowG2WTkBL8HF+xqJEghfVN550bMvPApEvbFMuGNxoIoQXyIPRq+u3KM5KRCwBo4VVPlw0Oi0gBoEXGJJMFF9GZAE5oLcRrfQQqMKS9e97xRNfYCBeFASql2VsfwWAy0rkA3XRystGegDQ4sYe1xG1hPhgApghLlD5+pXplNhxZNv01ArFZkIOveDQoGDzF1cKR2VK7oaLD3dFD4fTOwMp9JhT/U/UE7reCXIB8oE/Us/sxmlWgJZgD52KH9lWHL1/hcXC2GpYMxR+syLcRJBLeZmRU+hCLcNGEz1IkXdUj5I10f+mnWR5IifxhA2S0NnEzEAYMkA8o8agF+aZCrvy2xnL85yzY12pkUMEyzfsmvH/SgHIes+s1DMFgJT1T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(366004)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2906002)(8936002)(8676002)(5660300002)(52536014)(4326008)(7416002)(41300700001)(66946007)(316002)(66556008)(66476007)(66446008)(64756008)(54906003)(76116006)(110136005)(55016003)(26005)(71200400001)(6506007)(7696005)(53546011)(33656002)(9686003)(122000001)(83380400001)(86362001)(478600001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?woITzKrPEG+HEhe+dUE5t/NgeFEzeYgnc/PE2CTm0BwWIJ5oQQ/U/o5RJcWQ?=
 =?us-ascii?Q?uCHre8HD2/Ry/Y+iAT/st5VOQ7W40vTyDTdk/Exar9KqWgT4lZ0KzliroE56?=
 =?us-ascii?Q?qSEdk1Iv8uL7p+QC7aV7HrMgouAT1IGjaMtYXKjsx7oKW5V4ffy4S7I97FAB?=
 =?us-ascii?Q?yxIsZIpwbv8uYs23vR+cefhUkf2I6mBFWXMfeKnnvg8ENfEgbFY4l5BS4OGI?=
 =?us-ascii?Q?ukgsuSHtM2wBt+EKLAJv6mvrYaILMiz7avgt8zz79PUH93DUS1G0hIEg33d9?=
 =?us-ascii?Q?HHNgTQOV2XEnBnNaAq7RZH9yZ0nNqqhbgWztBPhihO86YpLx5S0jicIEmq3F?=
 =?us-ascii?Q?nYdMQq+G1clz3LuwE1dRulQRbq/TdDMzr+JxFcJhBWz6+cBh3WwYybGQZxdd?=
 =?us-ascii?Q?ZXS4inWqEn4Rq5kUxv8RuglAINrPPkXQ9NMWgXaKb6IXckPmSWpEZbPbgHUz?=
 =?us-ascii?Q?Z3xiOrYygu34+gu+sJmC7jdD0RZYSd0MZS77+lCmw1w0v38loDNvh/nMq+Wy?=
 =?us-ascii?Q?JPagJ0J24HJGzabWLThGgsYzDVP2ggxyz2AMZNWj0/GYMws12CUz0Si717TL?=
 =?us-ascii?Q?Fmm6QCmWDXxmVlm+Tbkcd0yRolYl0ZWXlZ0laqSzuk+OSFLuW153CjjVI3FT?=
 =?us-ascii?Q?mKo3X5WHL3vEvzewYSUoMB7+JOrwOcPkggMEblYvHPOnDZ383FQeQzs4Eptz?=
 =?us-ascii?Q?Uofjg13Xm9Z7peendfFHvVIsUaf1QNjfMtd76eRiHqkCcJjDFGKv9BSbYu7B?=
 =?us-ascii?Q?79e7lSH9Xz78i3hSUG8G3F+QGQxOLthxCqMEDuvq2R4JpAIARogvJZwnea+f?=
 =?us-ascii?Q?t4YGYKgUaoNzq2nD/4UxmpVZYYqBA3SBipMnK6MQjnN6svg0ySGHY4O8InaA?=
 =?us-ascii?Q?QSv33QRLlB4EHOj3Sa6Rvt/ZWrKvMKZipu4slScRcQszgQpmxCxZ+kdEnGXn?=
 =?us-ascii?Q?iwz+qQopxagyB8IZMCLEIDHPMQhFetDwkeJlMxvg8Z36j3iVNREGbzvktAaX?=
 =?us-ascii?Q?m5/gsykMgln9WfcgByoRE8xc6w1mHmVHsfExUY+QusmBTEtN1dbjtpT/Pzpw?=
 =?us-ascii?Q?1wKj0MU041lJ/jX4GmqfpN5NWubGKtqPx9ToDKbHgIRlemEEburEBgDcKDko?=
 =?us-ascii?Q?ujVdO2DUllv9R75cpnMyZSlByhDwWwA6yQ4DcADlP2J6NkAy1NMcBcjdiI3r?=
 =?us-ascii?Q?3OUs2xktJRydVcxnE9MzxP+2wYNKsvjRxWZLFXunJHiY0HepwxXzzYOsjQDE?=
 =?us-ascii?Q?lnM8d8rIWJisT39WnYdrXITmuu1os9YnZOkdKih/sGpNZsOkPyI6d71L2Qyd?=
 =?us-ascii?Q?aIk1DtSPID1XvAovG5WanY5La58VnlZqWE+m8fSMFK6JRdIe6SPMKXlJkxde?=
 =?us-ascii?Q?oa20RDbi/ZSxydt13BXJ3jrJ0v1D6vCFQ+dxrrfzdwi/t31L6+SRBTh91tPo?=
 =?us-ascii?Q?h3GRm8jcUD0sn2mM4v9DpdYReubcbx+Jvz/+1PY6oqKe9jdbB05dNnonRPuJ?=
 =?us-ascii?Q?DkOojxyCpb8r1A97gVNSeNnnnHj/Cp9vwZLfJFHZASJm760c0NcYE87oWgeG?=
 =?us-ascii?Q?B9gqYS7znQaMys0fpZ6Sz7XxxBK1HfYX/KnJNNleuSmqtGoQEioMP8IZ5vTj?=
 =?us-ascii?Q?yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb35a1c0-1ee1-4ccb-4ca4-08dbc5751a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 07:31:34.8461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fh1vzcYUv0kbJn8p2M4UgJGlgYlALbLaAJmGDX49DuDyrQpLFuoNmUzioyWS63UudFiyUZCmvMGj4+v0tlv4GJuaTuYMxTmE/9vC3CdpLWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11663
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct =
se
Date: Wed, 4 Oct 2023 22:39:39 +0200	[thread overview]
Message-ID: <c92bc8a6-225d-4fd2-88b5-8994090fb2de@samsung.com> (raw)
In-Reply-To: <xm261qego72d.fsf_-_@google.com>

Hi,

On 30.09.2023 02:09, Benjamin Segall wrote:
> The old pick_eevdf could fail to find the actual earliest eligible
> deadline when it descended to the right looking for min_deadline, but it
> turned out that that min_deadline wasn't actually eligible. In that case
> we need to go back and search through any left branches we skipped
> looking for the actual best _eligible_ min_deadline.
>
> This is more expensive, but still O(log n), and at worst should only
> involve descending two branches of the rbtree.
>
> I've run this through a userspace stress test (thank you
> tools/lib/rbtree.c), so hopefully this implementation doesn't miss any
> corner cases.
>
> Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling poli=
cy")
> Signed-off-by: Ben Segall <bsegall@google.com>

This patch causing issues [1] in Renesas RZ/G2L SMARC EVK platform. Reverti=
ng the patch fixes the warning messages

[1]
[   25.550898] EEVDF scheduling fail, picking leftmost

[   15.109634] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   15.109636] WARNING: possible circular locking dependency detected
[   15.109641] 6.6.0-rc4-next-20231005-arm64-renesas-ga03f9ebbbb4c #1165 No=
t tainted
[   15.109648] ------------------------------------------------------
[   15.109649] migration/0/16 is trying to acquire lock:
[   15.109654] ffff800081713460 (console_owner){..-.}-{0:0}, at: console_fl=
ush_all.constprop.0+0x1a0/0x438
[   15.109694]
[   15.109694] but task is already holding lock:
[   15.109697] ffff00007fbd2298 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0=
xd0/0xbe0
[   15.109718]
[   15.109718] which lock already depends on the new lock.
[   15.109718]
[   15.109720]
[   15.109720] the existing dependency chain (in reverse order) is:

   25.551560]  __down_trylock_console_sem+0x34/0xb8
[   25.551567]  console_trylock+0x24/0x74
[   25.551574]  vprintk_emit+0x114/0x388
[   25.551581]  vprintk_default+0x34/0x3c
[   25.551588]  vprintk+0x9c/0xb4
[   25.551594]  _printk+0x58/0x7c
[   25.551600]  pick_next_task_fair+0x274/0x480
[   25.551608]  __schedule+0x154/0xbe0
[   25.551616]  schedule+0x48/0x110
[   25.551623]  worker_thread+0x1b8/0x3f8
[   25.551630]  kthread+0x114/0x118
[   25.551635]  ret_from_fork+0x10/0x20
[  OK  ] Started System Logging Service.
[   26.099203] EEVDF scheduling fail, picking leftmost

Cheers,
Biju

