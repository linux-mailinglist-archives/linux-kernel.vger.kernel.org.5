Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AA17A3F79
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 04:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237990AbjIRC2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 22:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbjIRC2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 22:28:18 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DEE122;
        Sun, 17 Sep 2023 19:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlBayNw8VRlDQ7xzav8nZgfN5KWTES6sUclso1RRhi1mo0cQMvtAHc/Ni1bBzM6fahjyAgZl4LKDj7juD56Il+O4898JyItyYmT6DkliKJQxYIcWiU6CrNv2gOBlZ/tYzxLPYJDp+cjPoSvb6jykR4aXEZVySldFfaIix6SmtN6xqOAvMnU1Cxb9zILPUnT306eHwe4ILZZD4DZ4fGha28L5CkYkeZ4nTIcPuhznTZh11uw8koY7uAxJSCtgDBa6EDhjeH1apxBcLaTd3B9CKTAvmfErJpmfJcFXp7zbrTdOeA/vVjSmu3q9Eu760IKlLaTD+ngHq03mKypfZsRtJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYreOqMe+oJG1nRcctvP1Mz0qFgJ2ZhP+UFgho+mhFw=;
 b=NXilYNccrRR+PTXDvpmOR5ZUEoCcAY3nPTACSbiHf1opQ0LRnooY/l949fXWUhsZIa4dZbT02t/F9jPsoB47LIwj7DaYxDRguRSQ2cwSqfFAUM7R8iReyg4FbBRAC+y+h8lgJeCiRaftD87KyWhZSIBfGRSpbm9FzPaqnQV27IRUF1C7uPkjDorROA9BYvD3+nLgo3pN5Lwat/O0uIpI2gbaMcWqG36LDmijwhPgBdGp3DXmAofxS6ivd4ar94izwCxhB9Cc//Z9Hgkbk1NJQ17SMUFVLC4NdQRE/DeBPvx7p2ztI7OCk6AKi0MMRHnA5T2doeaYAVr5VL4RYeYMfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYreOqMe+oJG1nRcctvP1Mz0qFgJ2ZhP+UFgho+mhFw=;
 b=lX4lZnRqT2XvlgLLZUfVpCBt90FKABlI5d2JMAedQEq4YD87SM6K1OrBkh+vl2ZitIaRxbkaaFLfXGUkvhy9D74blYc2hQSOLvdqweOfoz5RMFFvwkv1iPHKtUguWfftwCAWrHz2FQ/2QDN2a1rw8HG7jLVVmAmy2SjGUOOX0jc=
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8)
 by DUZPR04MB9727.eurprd04.prod.outlook.com (2603:10a6:10:4b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 02:28:10 +0000
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d]) by DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d%7]) with mapi id 15.20.6792.024; Mon, 18 Sep 2023
 02:28:10 +0000
From:   Hui Fang <hui.fang@nxp.com>
To:     Tomasz Figa <tfiga@chromium.org>
CC:     Anle Pan <anle.pan@nxp.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jindong Yue <jindong.yue@nxp.com>,
        Xuegang Liu <xuegang.liu@nxp.com>, Xu Yang <xu.yang_2@nxp.com>,
        "jchowdhary@google.com" <jchowdhary@google.com>,
        "rdhanjal@google.com" <rdhanjal@google.com>,
        "arakesh@google.com" <arakesh@google.com>
Subject: RE: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment
 size
Thread-Topic: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment
 size
Thread-Index: AQHZ2UI/RGKEIcG6sEyAOrT4GOix9LACiU/wgAAMzoCAB7BFoIABXXYAgAHcP6CAABZdgIAHn6dggAFXQACAAE0GQIAAA6qAgAAHETCAAARQgIABqGOwgAAJY4CAADsAgIAHJYQw
Date:   Mon, 18 Sep 2023 02:28:10 +0000
Message-ID: <DB9PR04MB92846C041353379E18ECCBB087FBA@DB9PR04MB9284.eurprd04.prod.outlook.com>
References: <20230828075420.2009568-1-anle.pan@nxp.com>
 <DB9PR04MB9284AA58AA71655C9C0C7C9A87E6A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5DYxwX+JdXQ_-ba5B9y+gyWPjvUpCBnKM1zz1W2EkO_vA@mail.gmail.com>
 <DB9PR04MB928460023FB3CCCBC3EACE1487E9A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5BGJX7=Z1ukFRq_ktaQ0d7FbvV-ob5gs8hfGaNHUXPTww@mail.gmail.com>
 <DB9PR04MB9284A0CDB1FC7CAADE0A394F87EFA@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5AugUGh7Z=9Qh7SS4=-0ddGBmRAOOyCGDfPdT-=eurtUg@mail.gmail.com>
 <DB9PR04MB9284A45033B3E24F44C5AA3987F2A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5Bk0DUq5jgFDHV2wGYEcfQzNVQ2KYJ2ZYLubwFLgqW4kQ@mail.gmail.com>
 <DB9PR04MB92846D75C93A9B2B8C8A998D87F1A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5Ar18TvFE3jXBuphpCiwWAb8O99wqkiwEVDSs3+MXvW0w@mail.gmail.com>
 <DB9PR04MB9284404C1E1F1300EEF5A70487F1A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5Aq=ZrNGQU6psXJXt1ak2SkoRrZ=QBzp+xxHmWre0zBVg@mail.gmail.com>
 <DB9PR04MB9284A1DAB3C642C57298893A87F0A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5BQ+FsuKipxE-yh3P-NbPdc_U=FHp7PBkWY-xunxthKuA@mail.gmail.com>
 <DB9PR04MB92847BD33B99D6494A1BCFB687F0A@DB9PR04MB9284.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB92847BD33B99D6494A1BCFB687F0A@DB9PR04MB9284.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9284:EE_|DUZPR04MB9727:EE_
x-ms-office365-filtering-correlation-id: 1de49807-05f4-4bb3-98d4-08dbb7eee691
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W2m1OBJWMY+bmNc8b9qBY1chGNJ2MB/VaJshzyKSpXMQp5vzdF2nH/DhQSLDyaynElp3QTjvJU3DweBMgf0ZI5a0Xb+Cogd8GBVjATIJBsyfMcvCw0VoEKaozahAuNXxSrKYMohFCLHtMSCamVlE4bBEP4ye/y0y+cE1MfNaKTYIjpLEk9Q+avZrwPCcxPnao3NcvhVJymeDg/Tq3Q7pPMx63Im2MueRpNavhRpKXkKM1ygbLof5S0oQWWjs5z9pKwXQ2VL7YygCdfFpS/3yVUAObaamk241rU9O/qdj30f3BmQaqyrxJcustvqYAzFVYPO/0PR4ekiSxIST56KRNbagcLkwaP77B/QEeW9lMc3ZaNYNR5NameEyhUgNGc4s93Uq0pI8g6x+etR4XnXlYOBCfbeuAKSFSsRcY6Kk9DYOe+e3ydsGRnJSjzUXFMiIDoEdBxZ9jxpr8e708dfezo1uqMceMF4PTaQ9M45x+A6/2M7WuPkz37gumsNNH48Ozl5OewLdSOKxohZlYRtXkcg2SZELTwJu7xXWoYlgVfSisX2lJIxkGlXAH+/vgGCgzZZgfDHTLPFCUTuvS23CQW1dsE3teFLVKqS9pFginc4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199024)(1800799009)(186009)(55016003)(7696005)(6506007)(53546011)(38070700005)(33656002)(558084003)(86362001)(38100700002)(122000001)(26005)(2906002)(966005)(9686003)(71200400001)(478600001)(83380400001)(52536014)(316002)(6916009)(5660300002)(8936002)(8676002)(4326008)(41300700001)(44832011)(66446008)(64756008)(54906003)(66476007)(66556008)(76116006)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjUyU2kwM2lOUEwyUjJUUDdXNWN3cjMrdkNWeEY5cTh1YnZibk9uTkFxNFpD?=
 =?utf-8?B?REJoWmdxdHo1RGlyalV2KyttWjdmYkVaZ0R2anhUMmM3NktxR1BBL21HRjJk?=
 =?utf-8?B?NVZ0TWtmdVljMUdJd09GOUhQZ0Fubkk2Z3F5elJ1Yk1EZmI2WHhFR0JRRkJG?=
 =?utf-8?B?V2FLZ2kvZTF5c1VTaGw3WVVPSjg4VUV2VUJITUtFNlhJaGtuNDVUY1Y0V3dn?=
 =?utf-8?B?S1hKSGNNZno2ak4yc0ZnUmlzenhzTThPN2JkUzZqaWtNNVBHbGo3UHpSNHZU?=
 =?utf-8?B?UnBMVlJRWTRVcDZmRUg3WEMrcHpJRWxFRGdaMWlER1dJN0xnWmtOckV2VGRQ?=
 =?utf-8?B?RDBxODdDbmhPbjZQR3VpbG5QTHVYQjl2eHJMcklxOXlEY29nVFl0ZTlSZy9v?=
 =?utf-8?B?UWk5WEZXZnhRUk1NbkN3RDVKR1dpbUZ0ejdzVHl5VkNBZmxDOFB6ZDRaWVhC?=
 =?utf-8?B?aDNtQmxsaCtRZzhNQ3VJbTZkN3g3eERWOTNCWTd2Zkp3WTZwcHBvcWhrTVJF?=
 =?utf-8?B?MTJReW1vM1RObUNrdWtQS2RlZytBcjZoU0dBQ1F1V0UyeU42R09PN2x2aHhK?=
 =?utf-8?B?RTJUU1FsMDZvUGZzVG5zczEzZG0xN21yUGdmL3ZndzRkUlFBendCTHVkM2NL?=
 =?utf-8?B?ajltOGFGeVRhVDI4eEMvcFNoc2lKa0dvVFRWTTZTUXExTjFOTVV5Wk1RaENv?=
 =?utf-8?B?NzFxSHRqOXNMcFFMdEVxdGF4bDZ3UUM4ZERVbFY2ZkRlUEpLTlVjaU02ZGYw?=
 =?utf-8?B?eE01ZHA0dW1YYUV0SFl2YVpRRXFybjVzMTdZQ0UrWFF0djRCamR2UXM1MlNI?=
 =?utf-8?B?WFgxZTd2Z2Zldm0rNTNlNzlraU4vWkNlZGpXRmVJYUVvU3F5ZlpZSlRyRStp?=
 =?utf-8?B?QVNZYXN2SVBkSjBZOVZIM0NQSGt4WXJiZDR0ZlJPU3Bqc1VheFNtSFYvQ3Nk?=
 =?utf-8?B?Z2pjTzlEK0JReGtydDIzSVo0eFhxaXJrVzFJRit4Y3FuTHZraUhxL1lWYjBk?=
 =?utf-8?B?Unl0d2Y4VmR4cDFreUowaHV6bUJDK1JGZ2RuWStYbkRTQm5jSndJNTZXcUVz?=
 =?utf-8?B?WExHdlJGM1VuL3BTY1dBU0ZUSThnRTBvUWhCaTUwMjNWWGlsVnl2amhGVkg5?=
 =?utf-8?B?Y2tTZ0RFVEhidFhBaC9aTURBU1QrUG93VzBhVkVWbVl1d2VndmYwZnRUWVdy?=
 =?utf-8?B?TElUU2ZXZlRRVGtROEEzSGNRUjN6ZVpUcFpSblZlYzExYU15VTNsL0QxQlU1?=
 =?utf-8?B?cVdUKzk5RGRGRjZRTEMzWWVEWXUva3ZhR2JnL1pYZkRadWpqQTh6dExKc1dK?=
 =?utf-8?B?cWFhYjRDWVpiODBzakRrV3llZklxMEZNYmRmZzBlc3JPaHBlcDJMcGJOQitn?=
 =?utf-8?B?cldRdEgyUGhna3dFQVpKNWx6MzA1UUdyTGk2bVJKbmRTT1B1VnhjUXp6bElj?=
 =?utf-8?B?Y2had25MQWw1UUhDcVBVZkZ3R1huTlB3Qlh3VjJUMWtZeW95Z3pvY1VVZVZN?=
 =?utf-8?B?RE5kUi9aME1oMUxZQzR3Y2pLSHZLWlZKYmQ1aXp3RUlKMnNZR3ZBVkp0U0x1?=
 =?utf-8?B?cXIvb0tiTXgwb2ZMNzZiSWVLL1ZyTkhTYkZ0V2x0NkxJY3l6b2w4VnVSZ05k?=
 =?utf-8?B?bFFtYnN2L0wzL0lmYWcvTlNaWVJTcGVSTXY0YTlaWVRoSkVrdnlhR2NtT3Ex?=
 =?utf-8?B?OFZHa2dIWkx5TXJiSi9wZUp0STBSdmxlZWtTbHNJOU1uNGRGOE9LU0hhZnVY?=
 =?utf-8?B?eTVLZlEwTnpUMGtTMmJObjlaYTl0MGdVM2lmSWdTZHdqWi80R3VVcDVlbk5y?=
 =?utf-8?B?OW1WN1h6eWY3bFBkNUg3UnlIbkV1aVQxbENucWdZRklDYlhXWkZkcStsNUQx?=
 =?utf-8?B?aCtQb1grTDArNHVGSlJnWjZBN3NFc2x6Y0NMTjNSRWpia1pCWjNGRDFaZXpz?=
 =?utf-8?B?d2VaSUMwZTREZFZwTHVDeHpaTlZ6YU8vWVBrU1p3OGZVdHlrN1Rnc0pLdjNm?=
 =?utf-8?B?aVdsc01rYkRzVjQ0QmlZOGVXNFdwRFpITmlEbjhpMWhCMklQNXVNNWdVQ21P?=
 =?utf-8?B?b3BkRnBWak92SXJLZzNQVjZZVVk0czg1cTBoMHNxU2F4czV6YmU0WVNvUmp5?=
 =?utf-8?Q?o2gc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de49807-05f4-4bb3-98d4-08dbb7eee691
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 02:28:10.1317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8NWYx0M8dmRNFIOx3qmdxbex+u604yrFcYx5MZLKeI9B3taXmF+Cj9akBzQsgxzdHE5vL5UmmA8DUFEgb/IaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9727
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBXZWQsIFNlcCAxMywgMjAyMyBhdCAyMToxN+KAr1BNIEZhbmcgSHVpIDxodWkuZmFuZ0Bu
eHAuY29tID4gd3JvdGU6DQo+ID4gYWJvdmUgdGhlIFNpZ25lZC1vZmYtYnkgbGluZSBpZiB5b3Ug
ZG9uJ3QgbWluZC4gVGhhbmtzLg0KPiANCj4gU3VyZS4gV2lsbCB2ZXJpZmllZCBvbiBvdGhlciBk
aWZmZXJlbnQgaS5teCBib2FyZHMsIHRoZW4gcHVzaC4NCg0KUmVmIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC8yMDIzMDkxNDE0NTgxMi4xMjg1MS0xLWh1aS5mYW5nQG54cC5jb20vDQoNCkJS
cywNCkZhbmcgSHVpDQo=
