Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32B47F7152
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345536AbjKXKWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345427AbjKXKW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:22:27 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2132.outbound.protection.outlook.com [40.107.6.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E87391;
        Fri, 24 Nov 2023 02:22:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbA32iD7LpTlcymIgYQOk7eoBvfmiWRH3XhxVMUy/m77Ki9M3x+sFiga2a8jHaSjRUyPnrf5mNomChZQHubsnfdsNqIiEGmZpmXuqXWokRMjPUH37Wu4fBFeldddJaavoIMYhtvFbrGoAdGtRUFlU+zXT+HJmfYz014gswuuWRMTaQLN8CNifQ5JJHpOS8jvn1QAAEOg6OSe1s8Scg3nk6xVBXjaNRS3okXhx4OUsb7ZNw6ll+4CdysHaofUOzWteayvCZEkLDFKGlanJOXtJzo+ktoMFCoO2R8mHIh30Q6TP/TEVHPoQn8sNwc/4gI1MMVrE7GbyXbEPBEYcn7Rsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMzDDo0WZj5j0lI9tOQ88IEubcHAh6ITXOMPJ7Y6/NE=;
 b=dtG6EFl71+BJDnI9RM4vA0oqOhciJ+7CsleF9V0A3XQ4lRwK//xmLBdPxbo5N5B8VmLgE5zha+PRBt8Egq0pu0Q3sijHKH1Pu7nUtipPQ1v/ek6tRCJ78tiBeHGO3thN+oLe3wZfRSKbHfTXcLBdrArH189432UncSoV/Q5L0mjEoFRtRm0TfEK7o+fsleG4iiFzk9m4U7mbQWq8yy+wE1QyDc9MK2XbtJ04H8cgREqFD98MKdx4UsW6RgZiWkQ+vP7TYjvA9UvXUjceKURo0NdwD3I3kvVKBHMcQ3oMVj38LIa4LRhe67jiXjgSSCIpZzZiM3jZ/WUAHUXwzwuACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dektech.com.au; dmarc=pass action=none
 header.from=dektech.com.au; dkim=pass header.d=dektech.com.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dektech.com.au;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMzDDo0WZj5j0lI9tOQ88IEubcHAh6ITXOMPJ7Y6/NE=;
 b=cr1a1N9IexXyrOwxyE8W4y8xuxGKNkl8PeJDc8jN98jb7AbVunEnzpKfq5tsCSx/N5vquV6tK2mlDHPbmn2EC0dO/2bypHTzt0vPr+Yrfvg4pSqSvex5u8+r/TqBL/vUkEHYuSx1n277KelMlfyd0cgsyK9jVzfkQ6aohDa1wm6CcsNAgSQbIOhpprgIWGsBAItZFgTRmxeWSyNGd1uVTNZ2xlHLgLm0KywVjsJrV1h+BMxLRnUI+kePpKyXANRKYogE/CWJhY1Pe8MMuhZ+xuiz6nOMsTLjZ/Q8WyBIe2m4lHGCjTDRlMYIVcX/nPGbXNuC8Iu06msxt1bD5Om47w==
Received: from DB9PR05MB9078.eurprd05.prod.outlook.com (2603:10a6:10:36a::7)
 by AS8PR05MB8200.eurprd05.prod.outlook.com (2603:10a6:20b:31a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 10:22:29 +0000
Received: from DB9PR05MB9078.eurprd05.prod.outlook.com
 ([fe80::c9ed:567d:143e:af2b]) by DB9PR05MB9078.eurprd05.prod.outlook.com
 ([fe80::c9ed:567d:143e:af2b%5]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 10:22:29 +0000
From:   Tung Quang Nguyen <tung.q.nguyen@dektech.com.au>
To:     xu <xu.xin.sc@gmail.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "jmaloy@redhat.com" <jmaloy@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        "xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>,
        "yang.yang29@zte.com.cn" <yang.yang29@zte.com.cn>,
        "ying.xue@windriver.com" <ying.xue@windriver.com>,
        "zhang.yunkai@zte.com.cn" <zhang.yunkai@zte.com.cn>
Subject: RE: [RFC PATCH] net/tipc: reduce tipc_node lock holding time in
 tipc_rcv
Thread-Topic: [RFC PATCH] net/tipc: reduce tipc_node lock holding time in
 tipc_rcv
Thread-Index: AQHaHbcmsQ7KURUzRkaicoeZO+zrDrCHRXnwgAAp2oCAAAQK0IABobQAgAAL9yCAABqGgIAAB5KQ
Date:   Fri, 24 Nov 2023 10:22:28 +0000
Message-ID: <DB9PR05MB9078A431986292D93127682A88B8A@DB9PR05MB9078.eurprd05.prod.outlook.com>
References: <DB9PR05MB9078FE84F8244C627FDCFA2888B8A@DB9PR05MB9078.eurprd05.prod.outlook.com>
 <20231124094919.2043838-1-xu.xin16@zte.com.cn>
In-Reply-To: <20231124094919.2043838-1-xu.xin16@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dektech.com.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR05MB9078:EE_|AS8PR05MB8200:EE_
x-ms-office365-filtering-correlation-id: 7b3bb690-c9a2-4fe1-53c3-08dbecd7430e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xbvd0oUrjqDvBm8gPMGJD3wEWxXBvaIuQGQsnXEheo0uBhKDmnOnnVmSa7xzd7yBuBOZZg8Gp1a94tTTUFHjjUSH6uJBrYia2JPjV3yo9OJglLxMfIgf4k011ThPK+6gEJVCzqXhcpgvPkMqwpoV3qtYSivGKq1ed/8PqKug7d9UQ6ZJ6KHMa1oB6BjNRSbilkSlp0Mpl0S49FPqFBC8IRTfafhYgskGhCLG4WU+8dYu+DFAUKEdXmtXKp7cnjJRMuHisDmn74jt0sVZ76P7FROKZEoCj7sKnbwIf4y6ElwWDxf4gYrLDzEjmOLL3e/CkjuYNpWgQ1ERkopGmc1nuo0aCURkt6tS8ZqjAhVXmXtm+tGs27zjQ7dzH0lHJ9+q5jjwdw9j6LsFcZVACUeio7eFGnUGBZr45IIf8ZB6NSHHYQSUSa9WLTnZ7AK/2vvaMBxVKwiWdu/+Fe6rG97RUFtX6Q7wUUuXHH7BU5xFNoEp/qSBH4Q3XSVmExIdTNORE0xyhAjoREuMjC19Cjju6frfarCy1EY4Fj+KreDUCKDARrPuwCkgVG6Evkq+8tHv/JyE4rYMvdlc92y8DBvmz8Gc7QUtayGTBSvwSNrwvbScOBvxmMu2pImwMDrpT9uq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR05MB9078.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39840400004)(376002)(346002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(76116006)(33656002)(9686003)(7696005)(6506007)(86362001)(71200400001)(38070700009)(41300700001)(6916009)(316002)(38100700002)(4326008)(54906003)(8936002)(122000001)(66946007)(2906002)(66556008)(66476007)(66446008)(8676002)(4744005)(7416002)(52536014)(64756008)(478600001)(5660300002)(55016003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PasGjVfb4Kn9nQzNdrMe13Yabw5KCkp5Oz4dzj3EORwVo77FyVhksL2lgcwl?=
 =?us-ascii?Q?aC/ST38do0a7Q+malC4xL7sjP/PxHaLrJNbyXZ11R3TasKRKHFaYTiWWE9qq?=
 =?us-ascii?Q?az71NmK8yzy9Tf/IzLSb39U0yQq+ql0nXgLo1fCaM9vhvE+LfrOxq+MpcZOO?=
 =?us-ascii?Q?3Rqr0wD9VIJ97xJtyMtZRqZ4SIEXYiN6r6nppXEbzimSKy2kLv4u70zok2BG?=
 =?us-ascii?Q?ZqE8vF7psLo5huy2yMXrUn0GryZJZOqZrY44ay+E+BRd2sJqq7kb6BcpZf43?=
 =?us-ascii?Q?HrXFYWn+wlIV+9HdN+ce+Oc/EjFueoVIl2OMeoAI8bCOjRlkN3HL0wQm4Fkt?=
 =?us-ascii?Q?MijkEMuieJ3+wF/IhfRZFvbcP2Lnsg2CSy8T6ZE3UMqKz3SC5PoR4woEeayA?=
 =?us-ascii?Q?hSyrujrZU7ccoquhtQWPSrmrvhE6X6mDd3j0BqGFCFBjaGQgCRTkXk3HiGFh?=
 =?us-ascii?Q?hbfwp7fbwn9U46CXf2zp7gOt3gZ8dqxwqXe/cIvtoTuzeIG9Mwj8DUPfxPhU?=
 =?us-ascii?Q?fXAuzFEWKvJiDfhGnumeg/0rx41zU8k6gfBufNTXfFI7+7T60Bj6MmBe482V?=
 =?us-ascii?Q?mUvU7futjKQOXwckkX+sXvOc7pstMmKjetqldI93QYTkbAIACjAL882ubMB+?=
 =?us-ascii?Q?UJL5VtxOe6m3Qeapk7HfSsqrJrZ9tu0ba6c/ytY4Z4s3QgcMvEXBAQIRcgV1?=
 =?us-ascii?Q?CzqZz3wiNzcQIbyAvsVP+w6XBua1jr9LWmin5l6nALBMernuJPJY8kqHGG/a?=
 =?us-ascii?Q?Q+FP08sSH2hRMGeXNRTcao8wk7LcFFejHZ4Lf2rHzBYAjycc8SvRSWt71ULr?=
 =?us-ascii?Q?M5vpqZHWSm29yMmVTg6R/jRKoVGyb1cgPuZzlpxJGz3vWluFW7O5e414iBlM?=
 =?us-ascii?Q?kDhM2W9NqotTDUUMf2hbt+muDvjnixadlhVK1A0I9Wo9xiojYxFn5PakuOtp?=
 =?us-ascii?Q?+/+d6m15LXHk1IrvNchR4z9T0sYDqCME4lCyETKGbKlJN6PJ+mzQD5rmVRg8?=
 =?us-ascii?Q?LIMtISiT4YaGkk8MKhAuuIEn3J3tj1y8u70UBZVAaOeOiFg9MTw2BII/5z0e?=
 =?us-ascii?Q?vbuf0AkrsjiPfI/sqfdzmOGpkIxipqyOKJ/8YRui7upjQgt0xw6t9kfvD9pT?=
 =?us-ascii?Q?K2E6ZfydFbqzWUtLEl4ZD8R6kmwFgS//pRcZnTjL1Vm0a7LngL3+19O9zA0F?=
 =?us-ascii?Q?t04+GG/jEnXxB5meNs963YNwwoektOMi1VxOw09KWjFf8X1GDOmjNaJthtcr?=
 =?us-ascii?Q?CszWFNYTBhXbrSNeFhZWzvyp4tIUXfLU/sB38SKBQ5uT/lgyQR0ozR7w0Mzs?=
 =?us-ascii?Q?VpCwC6WrFqDMkMer/0dSCLUR6OnTuWc1XIbYmrHL2kPHb5vhQ2r+BURcUPfw?=
 =?us-ascii?Q?oaxNACgYfZtXkIqH4B9WsfZaidBqJIOujtjRA3SP5Nqag7lbbdrLYeZmTOy7?=
 =?us-ascii?Q?bXLHfXA+3M74uF5xjBYJauagxTvgX74orZjQ5vICZ5KCFMONCs1UOWmI3i2Y?=
 =?us-ascii?Q?9MNZyjnOV+tGkCzNu6JmecaJQbkps0luv9qhrWIEGzl0MaFmuubHJ/SvlvHp?=
 =?us-ascii?Q?MnMWMeQKvgyAcK4nyZ5Y0WTg3jMx22Gr7uumwKbgA+Ybi0ht/CZsnB15ZlA1?=
 =?us-ascii?Q?0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dektech.com.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR05MB9078.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3bb690-c9a2-4fe1-53c3-08dbecd7430e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2023 10:22:28.9593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1957ea50-0dd8-4360-8db0-c9530df996b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2VqG+D0Xu6NaeOTi+ImK1QFOYmSyxdGNe0gJ8ZsRaPsmPS8kxadCA8Ssgote5EkmjrLP1Sk/DvTkPmlCiwOCHe8eTBX61Wp1qkfIkicm8qU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB8200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Why can't use le->lock instead of node's lock to protect it in tipc_link_r=
cv.
>
I have already explained:
__tipc_node_link_down()
{
    ...
   if (!l || tipc_link_is_reset(l)) <-- read link status
    ...
}
>>What I showed you were just 2 use cases (link reset/delete). There are mo=
re use cases (netlink, transmit path etc) that need proper
>locks.
>
>The same. We can also add spin_lock_bh(&le->lock) to protect the link in o=
ther places where it changes the link status in addition to
>'reset/delete'. Because using node lock to protect the link in tipc_link_r=
cv is really wasting CPU performance.
>
If you want to change current lock policy, you need to submit a complete/co=
rrect patch. I will acknowledge this patch if I can see a significant impro=
vement in my test.
