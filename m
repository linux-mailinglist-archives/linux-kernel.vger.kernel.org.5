Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5807B7791
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 07:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjJDF7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 01:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjJDF7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 01:59:18 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2087.outbound.protection.outlook.com [40.107.13.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC30B0;
        Tue,  3 Oct 2023 22:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KODpJC2CY7rDUn9HIvYxmU5R5r8BZUYaMtUibtyOshV3l12Nez7aM25i4hxOqo3K3HPZgWp48CeBksYk2WXKRR2l46vrha/507W/OR9a4hl01V0bFbMvAsDsZ67ecLylHt7Csp1bKgMh3EjyNcPbwgSCVpr8t0r62jQBOwf0pDDNSikSP6QkQMenIxoZfXFbKX2vtTh1trpdzfLHgnw1nwHv/j98ka1P1Q53UHngyasmMgijrDJBVZnrvi2w1OZacDpEQ3Ag2iLvBxPeldpxt6q8hO9E2NrM/b62p7wPRQJt2KbehwFCy5C+MeE6wQlfLxoj7Wh68C55uV49WHoObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvFV9Q/FcIspNONVZFMfnu/5RRYer0zLcYhat6nDKls=;
 b=my1fnvecLEEikHxFKocGX7mlr5GOBXdJ1c9gbymIVTXPpY3S8qREE2a/YJp0JzrOUGV+a8gsha/iUyN6Xb6OiFY4FrkMgNJw+/uePw66L/Em0HiQ46+OEo5liiZRL3e+8YkBuwez2v0xSkecU2KV+05U8xYCwspquJjgr4C44JGvTIkFmng8A5LQe9nHCRJgFP1tqFay3vpNc8pfdiCn4ekQRYGjbuEdpcqsbxhu9YWNds74y1dGRjSpPB9/kcRIZ/AyIilgA9taQi1Evm29InYOQR0K7aluf+lVMdsuXx8jA+boXaBWbf9qjaUx1XlSGGjHnCTmfFjhzut43JNLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvFV9Q/FcIspNONVZFMfnu/5RRYer0zLcYhat6nDKls=;
 b=GUARomLFVUiAZt7Fy9qPX9LUyWknRTY0W/retlO+qPEN0FINyVi0tq3d4KhPWAAXuFGWpDEqvjrnsqqpEfSBcPBHNQn1wenrleDnca7kcYmEBCDt9dBYp6Zph/CsxvqPgxZ4kStJXtL1Dl95mv/LdBfmQkkSNBrgYxg2XRJoFyHqC+ZXy9XJtxwHwVu8bLbL4Vdu/Zp3g3QyojURs+DN8Hot2SVGlHrasZgbcC2yUxC6rlzs132ZRY/kor0LBIbD99joprlMPAtnjLH8bnbXOv3kNyG2WG52epmcOgOmJeMy1/6urFG4XJ+Ozpw6+amNkLBWVcY/ugqleNOKnRUQiw==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by DB9PR10MB7145.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:459::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 05:59:09 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4880:f83a:7de4:ac92]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4880:f83a:7de4:ac92%5]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 05:59:09 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com" 
        <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
Subject: RE: [PATCH 1/1] tty: n_gsm: Avoid sleeping during .write() whilst
 atomic
Thread-Topic: [PATCH 1/1] tty: n_gsm: Avoid sleeping during .write() whilst
 atomic
Thread-Index: AQHZ9hsms1Jp2Ee+x0K6pi4iDpsHIrA4XssAgADExJA=
Date:   Wed, 4 Oct 2023 05:59:09 +0000
Message-ID: <DB9PR10MB588170E923A6ED8B3D6D9613E0CBA@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20231003170020.830242-1-lee@kernel.org>
 <2023100320-immorally-outboard-573a@gregkh>
In-Reply-To: <2023100320-immorally-outboard-573a@gregkh>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=d4f9f93d-bebd-424e-8bc9-20b62af073cd;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-10-04T05:31:43Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|DB9PR10MB7145:EE_
x-ms-office365-filtering-correlation-id: 381d7a77-881e-456d-5021-08dbc49f067b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p6QEVouflNzSO66opwLKH+MLHwbLYbhrWJmMxXD3c8N/WuzKuB6QhGsQMwtwYM2NMchGpeFAKEYV/ArtbzAqCbxLzaxuXSae2ruwK/ceDkrFtd+p90u72PqPYqqzcrp87n53LCCBKfFjB8ysJGRb78gU5ZZRx4bOm+s2treBtUhQXfD/3fGyJ33nR78NFz8K1FTOXxzcY3U3CRPcq8UltyF9BCMUktgb9xNuUnIRI8YHTcf2gx4YvG3HMt2WUvGJgsTaAd6UYrGqc9gdE2aXUi04pHIcUkSVsWF7+VLXrkzs/9dRWqeHNykXBx97N+zfr9inlSB+MVdrKCSQ5ZR1wfcgRB01F7jRdtTxPzgtmKSZ0y6SOQTJx16vU+I0baul8ypv1FT1HtvOF6Ckv17nR0q1PYRhYtnGr3+At0ueb+zQL3KFVwLXd3FhTHiQ+uhA4xPZGJlrRybYQ0zVfbiNWvEJ96Y/qYCF+mcezd+WHWPrGM3oC2fVo3OyD7cbO3i+nHkw/NAAyLkFNj56WZkeNlI28lLcxndnRzByYlvAImA5buVWa9lxyhze03KE8Yxp1G19fs8UOz2GxMtgDUYfsWSOwdNgYLoVHvhrbKh/CFjviPobwWm5I+oIkXbBL5T6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(8676002)(8936002)(83380400001)(38070700005)(38100700002)(71200400001)(7696005)(6506007)(82960400001)(122000001)(33656002)(478600001)(9686003)(110136005)(966005)(26005)(41300700001)(54906003)(66556008)(316002)(76116006)(64756008)(52536014)(5660300002)(55016003)(2906002)(66476007)(66446008)(66946007)(86362001)(4326008)(142923001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+U+6oC22ofgVrExZOaXsVeAFY2iav9NN1nDRELM0EK6n0UuhqHo+smXbV/QF?=
 =?us-ascii?Q?l2Z8iifo1vvUTOc6wc/WX2KHjvf9eMKKpPlAAiQPnNKcUqLg2B5PTkJmcKh1?=
 =?us-ascii?Q?642+Yr9gO789ORwn/i1qeBOFJTEZOVV9WU9tw9SfXndf0sMCTNTisbaD/61I?=
 =?us-ascii?Q?mR8P2GSxqzqdsgDrSQaCttnqBX2WLPy6J+f3pdyOAIrxT7o22ET4bBqn1o2s?=
 =?us-ascii?Q?UASP0XjXLpu6dQcRaPs7JZqbyjbj+LoDNA4nzi1pdaVq3PkgCWW+AiB7KFgL?=
 =?us-ascii?Q?sVuj3TDvrM78is2vnFPlkRos9P9s/jklVChCfLi8vi8ktvzUhp0sb0ZmBTDD?=
 =?us-ascii?Q?OLukPuAUNepRejeI3v8xa54VINbRNOdPkUSWFs1JDscad0L5vWwCQKqkWsIe?=
 =?us-ascii?Q?3O1qCzaEa24EW/m0GVvZ0E6iQobGP4CMSmP/Z8gc8fpOel5HLDC3/jNxHKpa?=
 =?us-ascii?Q?byAjk7jQ3ZuQ6dObUqxtrREW8Y2akUXqb3DXiAGilfL/dMsFMrWWSDdxkzlf?=
 =?us-ascii?Q?kPcnPeeU3reChxJ0Cln+5sSu4ksolZzR1z4JDA2bsrwe3akZnhWD/emWD62w?=
 =?us-ascii?Q?qEuQRpfhZIEPLJAgPApogticQ9dpM27UHosrglYLTP2E5HR9NyNzHZ5Yufaz?=
 =?us-ascii?Q?XDgK13NgIf59OZsx4U6pr0KtPKzF22yHyX3RrmtJYelhLuLjqIVIJpykKpE9?=
 =?us-ascii?Q?7W1GEr8A3HNMyaBXrcm4EwErL75EKMMdoX6WRkDm2/fPsSaU225zBy006Ls7?=
 =?us-ascii?Q?aBEzdRNnxU+OH4RZmBmkti79WtiqEHSQjWwze/YEIZ9C1aPggw6eB9hsinu5?=
 =?us-ascii?Q?iakyqdXxAPqw1/zOnhlZlWzchwMXIeuBqOI3/bQKVMemeRDVNC00Qbz5x3ZR?=
 =?us-ascii?Q?jtqTSYZB5N3xV/usxrjc25ruOGJT9G7/4llYrWg04SlMSPnNFkY20jB1Kb3u?=
 =?us-ascii?Q?05Vr3tqvBAKrs6L2O+qKwVHalqzxFhgcbuz5a3mhcj/BtcK8Ma54T5oITI67?=
 =?us-ascii?Q?5svuXl9syT22dLHMLtYY/gWAAMgMzueYfoUndD4/fGenUaZVzAjwWkMgUIOA?=
 =?us-ascii?Q?HQi3XJyRj9ZtsSnhvVrZNrNsOALjMQJNU9fwixew3m8BfkhmQJ//GApRnqfC?=
 =?us-ascii?Q?bpszkuxz9AlTZF/p961LEC0rpinbgNXe+m0NB2zAUcDCidyC3E1qpPY1XBSf?=
 =?us-ascii?Q?eopq1KudT1Qj1msCTosDT7LAbaXAFOkE0VxtzviEfk5gBz6o9Z2W7KJeWg9S?=
 =?us-ascii?Q?kmVQQTmQw73uSqq3OhymbvwxD/ETWCuSoHu/ZL73K7RQv6gZXf9q7z1Qwd1T?=
 =?us-ascii?Q?XTQ/74r+TqGL5EBHDThVbIYEQVmL0E3MN/O1PguPt6//Z1FXZdN72HVtH5bp?=
 =?us-ascii?Q?K5+J4MkRVROx4iWD2YlOF3/Xp38XlR0yoo4zKDVhxFMIQei8gRt6yIKtpnlw?=
 =?us-ascii?Q?AyecWMObFyQCnw4NWAC82zsSCNpia/2+qoAKtZYQHBZ/5Td5YRAzwnNQRrkB?=
 =?us-ascii?Q?2tn35LfXdTHP4bXU9ZSNE6RloBICX75v9XWpnuqDWHJeKlsKF9gQbueOLXAI?=
 =?us-ascii?Q?X0BCta+qRR3JFVHlNazskuHDZEOCKdbccI2xzrHi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 381d7a77-881e-456d-5021-08dbc49f067b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 05:59:09.0399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qQafEjWgqKwT7T8jJGPZyYIDYrXBv1HSOL7oPHpjzgmh3GbWXlbJs8H1dvsOIV8tjbNGEyZ1Jj9IsrbR9saFZ1lbcuXm18TmQj78SXEesY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7145
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Daniel, any thoughts?

Our application of this protocol is only with specific modems to enable
circuit switched operation (handling calls, selecting/querying networks,
etc.) while doing packet switched communication (i.e. IP traffic over PPP).
The protocol was developed for such use cases.

Regarding the issue itself:
There was already an attempt to fix all this by switching from spinlocks to
mutexes resulting in ~20% performance loss. However, the patch was reverted
as it did not handle the T1 timer leading into sleep during atomic within
gsm_dlci_t1() on every mutex lock there.
There was also a suggestion to fix this in do_con_write() as
tty_operations::write() appears to be documented as "not allowed to sleep".
The patch for this was rejected. It did not fix the issue within n_gsm.

Link: https://lore.kernel.org/all/20221203215518.8150-1-pchelkin@ispras.ru/
Link: https://lore.kernel.org/all/20221212023530.2498025-1-zengheng4@huawei=
.com/
Link: https://lore.kernel.org/all/5a994a13-d1f2-87a8-09e4-a877e65ed166@kern=
el.org/

Best regards,
Daniel Starke
