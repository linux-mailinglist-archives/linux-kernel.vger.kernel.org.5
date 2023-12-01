Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6F58016DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441851AbjLAWrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjLAWrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:47:37 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2059.outbound.protection.outlook.com [40.107.247.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8958B95;
        Fri,  1 Dec 2023 14:47:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMvv5o7kjx++t6tgFR5o+JipaKwTPaGzgNAxohrhhIjz+xTh8yhhJn9Gar2vL1q7bicA0UkQb9FXYFxh+rqlAnJJl0WesI6o47EAHsi6hfUT2jKIEeECc5lv/9CJVWpeurPIcyRCOkXztkyyLJFMNxsKgwpjINYVBAHDo4BYhDY8o7MgXNs9UjvWdkSXzZNJLBmuKUbFLjms8WX0c06y/Ws0zrggtcBpzRRmX4Mm4kdxUKJ6b5OesWj2RWe5i8uYMAYQ+qEcwo6KeUjyN7zgbF0CFS5nDSQdINAvATQaIQVf+pspGoqD+HkKeM4L3VdGq9haKdYu1TRLtDfAil0umw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xed+qbTgJPIvSgMNPpZzwYp0N1JPSJ9YbW8S2mgC7vo=;
 b=Q+0bITwn34yss0ytsGZ2+zlsGQvfrOTVj91Yt1iIwVgM6hWzSgnw3GjDUzXxMk/2MD4Bom99flLREQliRaza2EanVQVO4H0hwvI6Z+U1dmGpdkSGdbOsQp082Kxeo2/2kMJNPkXpy+Wby+DtYI53o/PMqEgylkpO9rm6rTrl8iiTF/mFpDLmm6xf8iO6ZXwErl4oLLsmSytImMLYgpjYAF6ib7lqXgLGKNzFYWrYeV/AmvpWAviWz7Ts3EZaIU7GMIf3/+7//WeXorL3QYWpILPJ7EW5029U6ZYZUu28S9TX+fL7zF/F9SsCsJVb5FtkYqd2pbAScztZcPqnc4MXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xed+qbTgJPIvSgMNPpZzwYp0N1JPSJ9YbW8S2mgC7vo=;
 b=O0at6Hz+nvU9Nod3nWLkaCZTgetE68AaJRtW2tMvkAhl0hyBEmLiQZ8Oul7JdCJCPRz4f5OZ+MFg9Bodv+8cYw8UKtri0FFiaHaKWPXXtxEovetNnjZ9lsyk20nKworc0kKOS3fmFPxMoAcldwIUX2W8zxJ3RoDVbuvJo5pgmi8=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM8PR04MB7875.eurprd04.prod.outlook.com (2603:10a6:20b:236::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.16; Fri, 1 Dec
 2023 22:47:41 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7068.012; Fri, 1 Dec 2023
 22:47:41 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v7 04/12] wifi: mwifiex: fixed missing WMM IE
 for assoc req.
Thread-Topic: [EXT] Re: [PATCH v7 04/12] wifi: mwifiex: fixed missing WMM IE
 for assoc req.
Thread-Index: AQHaIdVYu6BJedWzZkuajUNTuEil2bCUO9iAgADQvWA=
Date:   Fri, 1 Dec 2023 22:47:41 +0000
Message-ID: <PA4PR04MB963816B99845D943B4D061E2D181A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
 <20231128083115.613235-5-yu-hao.lin@nxp.com>
 <ZWmzAWlh7o4bLZB8@francesco-nb.int.toradex.com>
In-Reply-To: <ZWmzAWlh7o4bLZB8@francesco-nb.int.toradex.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM8PR04MB7875:EE_
x-ms-office365-filtering-correlation-id: 8b1bb55d-34a2-4e74-5967-08dbf2bf8684
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0guO3v4sbrd6Y1NBJ0IoyWDCh3oJsMS3mTbpSO4YEOmMAOgvn67Zc0BKSks8/VAzHB2sOBXMWV5I1ZlLdIKDHaRGxlLHBt3CQk/NZxXu3Uj/YsaAZJVMDVRBXEwUDYKQDYcMt6J76gNyVJd2TfGrHn1I0lw0gz5dD0DvPcDR66V8xG9tar13UZtIawGwioxHa0/g0cF7k5dtzRfYJJTudLp7YPedrMedULHrIpoGKF4NLqhZuPv2Ke3jm7P7d8WQ+K29GRPSvnBU5upueepkvYm1sR+vOMalQiW8XYANlIR7CrBGWaCXlwK6IeRzCzp881TslMppwlY/qB3mWdd1NO9n1ljR0VrMfDwblxP9Wiapq4QVzqbbsctQsuGYSEefaW/8PAKubFsHVrAtoXk6NAl9vTjXVGZ64HtEr1aY+OS9ZunBfzvxI8Cm6dd7vInGSAfveLmHzUt9qNRQ4zHrPNXVnfM2IOvkW5LX+gACojx9i2bZi8zAxcBM8hGZJCmVzRahpHLOe76k+OWEbioa+ZmTPJAHRpf5Q2FK/eftNyZ9INVp21a1jHdkNnWO0MPzA6Czt/l1V0ezKcIniLxKFrGnUBCOMeNb2GqFSWhkCFAh/A8IFfzv2kOPToZqsrCL0bvjf588+QmHo4WDuheryEWIP/el/j9fahQZfQOAjcE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(230173577357003)(230273577357003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66946007)(26005)(53546011)(83380400001)(6506007)(8676002)(7696005)(8936002)(4326008)(71200400001)(478600001)(41300700001)(52536014)(9686003)(86362001)(2906002)(38070700009)(55016003)(122000001)(76116006)(316002)(64756008)(66476007)(54906003)(66446008)(66556008)(33656002)(6916009)(38100700002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ey3NMK/NQg/yS7S6OCvUPLFWEhYni8I1aSRnK/j+qIoiTb6ecsUWIv2/gIqh?=
 =?us-ascii?Q?4iFglLInDw2p1sO5xEr0VLzjpoBFVRUgvtCWKOXM5FquTm4IRXfG4x/T/PFk?=
 =?us-ascii?Q?MaUhbKSV9A+JOiMf3vM8+CfzH2CkiKbfSabPbmjAxQoeOPF3yX+u1quINwe4?=
 =?us-ascii?Q?PTwMk6MyAQRLEeniG6OjXAj74GHACU3/2KaxIeDlwePNFF5ljEbpYh+7Rz+N?=
 =?us-ascii?Q?kFO2x0pUaFuu4O2N1dAQklkkEsWl/Rj+2/RuAhC9bk7/NQrXRZKRe446V3w/?=
 =?us-ascii?Q?t70cmTq8L5syLHxDTrFB58S24Mehdjb3cDm4H2dleOuR5oGZtiRdUDH8rTrr?=
 =?us-ascii?Q?fTFTMbiErHSuAO77nVMCIwhcq+6QmBGElwEtMaTM4rBooYekpjpv9NNklcjv?=
 =?us-ascii?Q?NNvxLqaaCKFFQ/hhObVQuDwhiu01PTdGyv6nNnloMRBu4FNBvxfW9Mv43Iu1?=
 =?us-ascii?Q?iGhrUjGuxEjEMoyocSfaKy9Yu6oxkt/M7jdZYuMc5OdM02+1IxE6wmqNgyJL?=
 =?us-ascii?Q?kw/xIBjpfhEmZbgViOT2dnte2Oj2j6v8CYzrviLXVrXt0QGnxWDgUTEuXTZ+?=
 =?us-ascii?Q?xFImKoIG5zS+FP6wFpo/oTSdM4ROzgFyq3BKOS+qtGLme3go6H1PoSq+ZMCW?=
 =?us-ascii?Q?nMymVABjc/mKNDdJnq6gLgVwZJiGLCW0d6f0YhdQctCo04fjlMG17Igw5Iu9?=
 =?us-ascii?Q?HDfAmia8ZDkrp0aMRJadc/BCXgGg1whpFkworS1OICmSC4qUb2l9geSW0S4H?=
 =?us-ascii?Q?C8CYjAxVbUuL6YYerNr2IIt3EgS2IOxsR1zQw6wf5HRBTW3ee6D+tvcZ5Pi3?=
 =?us-ascii?Q?TLW4ckNQwF9o2Vo1MMfKIwk7EqWAqhS0hlEUimJD4xiP9KKiFgzRs47BRC3e?=
 =?us-ascii?Q?VGLCRILiO6iF2YJRSfezWNjEks1TpXVElH08iIb3KIkqNgxKsbz3mfQjZ57v?=
 =?us-ascii?Q?dJjYTALXP7eAwj5dkVjHQ1z2m+J81I+i/QKkOVfotaRx5qme/S5arNL8boGc?=
 =?us-ascii?Q?rgm0T5t4FL4p71+gcspKLgj1pmfDY4Ywu72T4MgCTlFQoeo3lHJfS7UymgQ1?=
 =?us-ascii?Q?cGKVP4swLuUHYqK1CaLSaPfQ4c7kzCvcRCxI1HM7ire31RJu4vu/M/cRoeyH?=
 =?us-ascii?Q?XcRs1zXpmJYVpXwMJH4nygMA1QqlDIhUEAY3hxX7XNdsND3awdqav/8Wx89i?=
 =?us-ascii?Q?ukwqFmCBHU3P1tIT9P1CRtvC9LgSI4pP3OHAGJJuBtCkNTw4bK1Hv3weRkhC?=
 =?us-ascii?Q?RYuudhT9lbPCaZRAxsW1ibm5tYcvueZjTUjv2PJrIZa3kyGAij3D2L/55Df4?=
 =?us-ascii?Q?epx+CE1kjNwjtyp047JDyjTYeehQPRUxnacbnvT0KX93vvphLWVIJrY/YwR0?=
 =?us-ascii?Q?iAEQWN4dclIW7iwwo5t2mF41nTIfR2XD/gMh79qfF6u5bUQqi7yS2GfVvDVj?=
 =?us-ascii?Q?6cs/FeF4GNQH054c0bfTm9AZ6KV9wRBvdlBLVPM/fx74nNd7UACNPdLJz04Z?=
 =?us-ascii?Q?vZdu87U7JIn4BQOtUvTYOd5D0853kXite85iZo0PEIBOYOzW3maimunsirge?=
 =?us-ascii?Q?WLclQrorUoQ658IxaelymIP0spFCFjwvDzB90frm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1bb55d-34a2-4e74-5967-08dbf2bf8684
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 22:47:41.2224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: to7y17SdUf1wjZL/KYgUIwH6Ad7VDIbWGZXqonzjvuS2tyGnPV7ijDafpTkLIM8lPP5oSZ/fmyvfnwqoUo92jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7875
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Friday, December 1, 2023 6:19 PM
> To: David Lin <yu-hao.lin@nxp.com>
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> Hsieh <tsung-hsien.hsieh@nxp.com>
> Subject: [EXT] Re: [PATCH v7 04/12] wifi: mwifiex: fixed missing WMM IE f=
or
> assoc req.
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Tue, Nov 28, 2023 at 04:31:07PM +0800, David Lin wrote:
> > Remain on channel must be removed after authentication is done.
> > Otherwise WMM setting for assoiation request will be removed.
>=20
> Same comment as patch 2, this seems a fixup of commit 1, you should fix
> that patch, not add a followup fixup commit.

So you think patch 1 to 4 should be merged as a single patch? In fact, patc=
h 2 to 4 is issues reported by our QA for patch 1. If you insisted merge al=
l of them, I can do this for patch v8.
>=20
> Francesco

