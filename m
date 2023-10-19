Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58B87CEEB8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 06:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjJSEoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 00:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSEoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 00:44:11 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2109.outbound.protection.outlook.com [40.107.21.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F7F124
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 21:44:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiTjGCYA/XVA1+rp/YD3KPvLgn4ISEw0SOZXWgNdHru+zH+12vKVMcWE6yLP/KbYYMM5DSL4k4f4wfejTykZUWG98gi1GWsuTuSbfW5QY9fOVTDHXMttgh0Kvg52n2xoyP6souGXup/IuvBTuY91VSSC7RrCrU9v7EZDp37+Oz3MKCFxGja/cClEfzWvAcKpG/oiQZbT+ctc2BxK3pLlWgsqkoo3YL3FsdBIT6/4CfS8Fj2M0qA/gIgiQVxychCIr2xbPn5tqs/g7n/FkRT4apSJVgET+1AuNcxIoujQfcLu+JWcZdkO/OTsdhCsZHY6dt2DWAULfdRaXkU7ozUNNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wM5pxqfQTtvAFlKS1w5+8O1VZFbrVjCW969QwTT0iIg=;
 b=lX7iDgS88aKiJlid7GvYDn5dp/NL+9Seppj7HSV220LeW54xbzOxjlOq9PAT9dT6b7/WgkD4AlcnUuhUxEKoR+B7rvQjz0jh6VAWrES1zIISXO2Z3OQVg532b/lWls83+vkwnBF5GBSIV6crq/xWu4vXI+AoedwHQ+GhtdImmFohFPV2O9a6K5fjUH3PixoTCGv6M2POo3K1Ukrsg0Ndp36navYExB47hGjtvYWsf78j61DLS2nF2MDYykhAVkXuVvIBAAd2VlynjZklaYGCyUWnSPYTj19HyaHJ/N6efrFdRfIwA9YJzWsumIDOnUw24dHDRdZc9eV4Ea5xWHDbLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=keba.com; dmarc=pass action=none header.from=keba.com;
 dkim=pass header.d=keba.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keba.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wM5pxqfQTtvAFlKS1w5+8O1VZFbrVjCW969QwTT0iIg=;
 b=cJt5ewdPxb7M5i2rnRwCZGI0aTUVh8K/Lm7zZTUZsZ9MAStC1kjsZaEss4mvVp/YwKdlmvDS1jjcO1bBNGb2BRv/dq3DZtDeU4YYZhb3TT3NOz9smXqO+iovwg+KnzZ+ym8MBLGEE+ZC7zmxsSaJ9Dh7XWAvaB4kuZ8S+q6+FSLWm4MvPhO4a9sFmGhUcB4+PKkX/4WL/GURqs9B5ahcD8X+aitcbJsmkQsap6iKRYvw/C6XMs/f0oPwwuZ9B66LfB7SBVoafCCHeOy1liJNIvbAF0fVmlD4XIsU1Di/qQecl5D+wepOfiuve5Wuii+J1IvYmblD6wrT8+S0OtzBsg==
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com (2603:10a6:803:7::19)
 by AM8PR07MB8191.eurprd07.prod.outlook.com (2603:10a6:20b:322::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 04:44:04 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::e3f1:1f82:2831:a70e]) by VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::e3f1:1f82:2831:a70e%6]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 04:44:04 +0000
From:   gus Gusenleitner Klaus <gus@keba.com>
To:     Al Viro <viro@ftp.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: AW: [PATCH] amd64: Fix csum_partial_copy_generic()
Thread-Topic: [PATCH] amd64: Fix csum_partial_copy_generic()
Thread-Index: AdoBilvmES7GiG9dTkSxSspB8XHmAgAT0kuAABppQjA=
Date:   Thu, 19 Oct 2023 04:44:04 +0000
Message-ID: <VI1PR0702MB3840F2D594B9681BF2E0CD81D9D4A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
References: <VI1PR0702MB3840EB26EF2A1A35BFEA53BFD9D5A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231018154205.GT800259@ZenIV>
In-Reply-To: <20231018154205.GT800259@ZenIV>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f7ce15f3-f9cf-4fe0-be64-c49742693951_ActionId=4aed22ee-49cb-451e-8335-840086e98737;MSIP_Label_f7ce15f3-f9cf-4fe0-be64-c49742693951_ContentBits=0;MSIP_Label_f7ce15f3-f9cf-4fe0-be64-c49742693951_Enabled=true;MSIP_Label_f7ce15f3-f9cf-4fe0-be64-c49742693951_Method=Standard;MSIP_Label_f7ce15f3-f9cf-4fe0-be64-c49742693951_Name=Confidential;MSIP_Label_f7ce15f3-f9cf-4fe0-be64-c49742693951_SetDate=2023-10-19T04:18:19Z;MSIP_Label_f7ce15f3-f9cf-4fe0-be64-c49742693951_SiteId=83e2508b-c1e1-4014-8ab1-e34a653fca88;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=keba.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR0702MB3840:EE_|AM8PR07MB8191:EE_
x-ms-office365-filtering-correlation-id: 995ab463-8cff-4e18-de7e-08dbd05e05bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ktQ5YwAvQOOjH0RRcX1/PRqCDtSLP5mZlHy81CRUmE76ZOFFQul2awTj0iqWPoxWXdg1NmoQtXZYr4huD1FC4ZswzTqQcGeOUp1koHBKBc6C4zfg2PeBtfNQOE3QzVDNrF9Cik9pROapYf0q9rmEad07hWjRXuqg/juLUmwqmhgTb3mWoBTq7jodpT9fWfJ85RUpKk9n0lhZGF96xb1Y6QdmWAwBn6iKSWLIFYynaO+oC4/X0XqWPBDDS3daUoRKIycpZLiSyrX37c8Wyp7FFVb90AbvtKWgcnEwd86hvPUxZskbXzkLimm5lvdxfBImWqtgbexey44LXKuvnmda9hfceWGWVJhwFzetPtxfGomdHBrPOGoP53eGt6ClmgH6EZdSlgVli6yZE26+N75T9WLS2KXFkMxiDDn44DISM2K77z91ExVMDeS/nuZA3LLc78ha288D4cuUQ1E+43H3Hl0iJuDKx0uvqmOZ7WftnnR8ABuEDPf7s/7Nzv/4O4j7pS15hAcJ8gvbeOum105QCG4+0HURd4MKMGRuSVCwlfQ6BcOmomkfkDfS085/G5AXAKaguwrOTy+2rtZOYc6+ag0Wm0ByMtC6MPzOz08ePWYTa1Gw2G1JLOdsU19QASvAlIMUdd9fquZhh76gluRAI++GHhsMEsB9KjXrV0R5Gj9BPWwu1EMAFunRgdUSktdc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0702MB3840.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(55016003)(38100700002)(52536014)(7696005)(76116006)(66946007)(478600001)(66556008)(5660300002)(110136005)(6506007)(83380400001)(4326008)(8676002)(86362001)(7416002)(71200400001)(41300700001)(38070700005)(54906003)(64756008)(66446008)(66476007)(316002)(2906002)(9686003)(122000001)(26005)(8936002)(33656002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?irlr7kdbmmBlVmfr7f5oJ3nycojAXrFWlL3AXm07CZxP4RaaJPttyM2Nm8Sq?=
 =?us-ascii?Q?4KsObzrlfM2izdg8XxLMzMFETx00bTstNWLBC3g1Uun9cgFHMWqwnovHB9XP?=
 =?us-ascii?Q?ClU7KnhTI5ngKCcFDcAd/Bi2m4H02JbhEt6x78u0UPeCCEnZjHK5H/BrPVVn?=
 =?us-ascii?Q?OZ90Hanbkyn2bvPQEWXr23eVpxwMRRY/ISkftii5Qc7KA25kN74d2vI1JMYd?=
 =?us-ascii?Q?AA9fWWJiQJD4+oJ9jvb+D+fJ7z5kbzb/enNpRk86PFPWF+6qkAadbSUJRgyC?=
 =?us-ascii?Q?QKBENtaVWJh8WhJkgSj/jeo/jfRRu24V3PqPNElN8XLEZFGzWeHgU0Z4kFY1?=
 =?us-ascii?Q?8o20I4XZB/HlERqYjaR00TJ8MTzwLBdKQtmmtWoLdJDrypTvxeRDxMlNmcPO?=
 =?us-ascii?Q?kg1+feJrjPHGjOMkvdffLLfdpQKc/+bJMnCs//eoSiyYimuPstSsQBDCY4Co?=
 =?us-ascii?Q?Wp5Qvatlgrii0NmNHkoO9dag+Vv1e3LuFv1BG+/4u7psyKIl9tkuJEmiag7a?=
 =?us-ascii?Q?gwyJkzn5rhcFyLpMJyHzo/IqV2rYe5GQB0T8wXH/bV6JR9WPkDC0WZnBLMAd?=
 =?us-ascii?Q?XHMTEbUCYRdU+ueYB4AK4FGC93SO0yzh/H28t3atFQAUIDlX8R+bq5R0nzH6?=
 =?us-ascii?Q?gr2v/1uDUILqK9vuVYh8hUzBA4pQsii7QflrV2Zgxv5V5PKR4IgYJZ8IAcTf?=
 =?us-ascii?Q?yBehqhwhT7zJGFC2QwHBRqhsot9J/QF1DZYa5gkbMU5gMa3wiVkk7nlR/cQJ?=
 =?us-ascii?Q?7wPrzp/6MyD/4WYRKa/MnvHYz80J88C+Y3FA5GEffMJXbmMLsmSY9o9yw+PD?=
 =?us-ascii?Q?NXpf+ZRQNX7Sk32QH/VTfhK14HfHQf3RnN4ByWRu88v45b9BRZ2AykA/whex?=
 =?us-ascii?Q?bwdo50flMT4SN6W7Lw4kuyYNvlh1oHm8vgfh1E0AQROhu+q1FKz8fwSjUqX6?=
 =?us-ascii?Q?sPtCds8XHOI+qJkr5HbKz6b+xB+voaR5HloA9gT+c35VGJYRIM1dDZuKc/kr?=
 =?us-ascii?Q?q8ez0dy/R2Pi1q1lyfWgc+4xIZrzcyLl04/T1xBAO49CQzZ31IcuJQwp88h0?=
 =?us-ascii?Q?RrGv85fPXijr9QFMpaWDd7wuD3wrSzjUp4dPns+6en+cKyLmqp+DB3lI4faU?=
 =?us-ascii?Q?4aqBiKFMxWxZtlsU1+TdgS09n7aijs7inxhKFAT1qzc9RaJUDQLVCV8mw0bD?=
 =?us-ascii?Q?6TzslxtZjz0RP/Z+U5wp72N72BlBCmzsxUjDsCeQKpYlnGOIz66SyS1QEb19?=
 =?us-ascii?Q?WmxtAtoGJsLW4LcRkEMJ2c5iEOwZtaU0DNhF0rvxG62keyUd5+T37EeYpMc8?=
 =?us-ascii?Q?jJ8BiTO6kMTPMK7lujsAgQWSFX+9vcxX1s7OyGi+I4k92Ut1dJVIffat0uAy?=
 =?us-ascii?Q?CXr0kk6u9J9bFImndH5jnW0HgXBxsJqBeHaqV5sEY/R1VJY9hFT3VbEOluvm?=
 =?us-ascii?Q?zDNuryfW4Za7o3eGawZziBvpg+3X1vG3D85JJC/sgTd4jTanFQQhbi6lzgpr?=
 =?us-ascii?Q?BGTXZ83sxTzKr8jVp2FdzQ+r7rzrvYTuUCYzFp8H6IzSBjzIHCyApacObNX9?=
 =?us-ascii?Q?95OhLkXqZ1w6q0BFzGY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: keba.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0702MB3840.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995ab463-8cff-4e18-de7e-08dbd05e05bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 04:44:04.4787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 83e2508b-c1e1-4014-8ab1-e34a653fca88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bCMjEM+42dWOO4PI6yl6VeDb8VqCOM0QBw0seGu4lAZtUJpTtL5rp6o3ONl0HWSZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Oct 18, 2023 at 06:18:05AM +0000, gus Gusenleitner Klaus wrote:
> > The checksum calculation is wrong in case of an source buffer
> > containing zero bytes only. The expected return value is 0, the
> > actual return value is 0xfffffff.
>=20
> Expected where?  The actual checksum is defined modulo 0xffff, so
> 0 and 0xffffffff represent the same final value.
>=20
> The only twist is that in some situations we internally use 0 for
> "not calculated yet".
>=20
> > This problem occurs when a ICMP echo reply is sent that has set
> > zero identifier, sequence number and data.
>=20
> What problem?  Could you please either point to specific RFC or
> show that packets are rejected by some existing system, or...?

Here's our situation:
Our device gets pinged by a third party manufacturer robot controller.
We have updated the kernel in our device to 5.15 from 4.9, the robot
controller is kept unchanged. At 4.9, our device's ping reply is accepted
by the robot controller, at 5.15 it's not.

Wireshark shows a bad checksum warning:
 'Checksum: 0x0000 incorrect, should be 0xffff'=20

