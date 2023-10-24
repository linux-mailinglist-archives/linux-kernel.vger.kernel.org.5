Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080A67D481F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjJXHMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjJXHMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:12:52 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA71510CE;
        Tue, 24 Oct 2023 00:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emDXwE8RK/7mwFOWcs5bEVtjqW+xNnqc7br7LSMpXNAjUzZsJ5JerIAwWOn9qheJdA2RxSB4wnGCaV+t2YMKFO+p+n12QRX+cTmRx+EjoQFs+algIPpv9FMwITRqAk65hs9RscTf6NlTzwjMA6bvz3LMAoZw9lkzuCtgcmY9vyDwR96we+tM1RkuBeF2l9AbWHWD/yTW8+SWaETXpaQ4kxYYa3uFcH5HXr0b67nF6uN39aIhZPSXhFhFqs70djOlutNoYHso+B5q16zNKd2og8Db0LtoxnQdg1wim1Qxq66802l5ZjSu1nZGE4ehEnB+vo70m4nXsc5qdeCDJiMiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PnFT/h5yBhf2kUqonsS2/ZpVHFw4+YxLLmmu9LSw44=;
 b=HocwvzThc36Tb6s/J82v1/ZoEXQF4lIC/Js50jRl0tCNVRPg7V09zWoEbBsiliGckN5SQwqQAG3QmJaEc/zdQ8TatThApWCOLoA2mEjGImtLkGDMVtFO4g/MfsPqqVHZS7B4HFyDIdcfZaHvMLO6r3ltvaIpBTdlMf2fmxgf5NfcZpQmNP8lDe5mVhY4FFudyiZW681DC44c1Q+calDmmU9YbpHZvs5RtS5jUfkVlE4P33uarwN14yMJuCtnWWH4TWawAHEsIZITLdcjA8eZ2eyw/yZ9DxrnxE+7rdXoxpMH2uMlHOORQtKqdpTNntjpc9wnJT7CMDhl60yanyZ6Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PnFT/h5yBhf2kUqonsS2/ZpVHFw4+YxLLmmu9LSw44=;
 b=bC3N+0klC7SpUFdembLu2aJyW7y32fGe3ZLc0pKGiUJMTU5LChyd+2UISK/HQ+zIk7/3MzNDSaZQufJomoRgWE/CIP7U/1WnQ6mxGFrTqLFiQWdrrhpeOLmykTSBk0abIbkiBx+C2l2jvtxu/ptRt5TrYHO9eVit2Zp/h0cmtUs=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB8462.eurprd04.prod.outlook.com (2603:10a6:10:2cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Tue, 24 Oct
 2023 07:12:43 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6e53:39fc:f010:30d5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6e53:39fc:f010:30d5%5]) with mapi id 15.20.6933.011; Tue, 24 Oct 2023
 07:12:43 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>,
        Eagle Zhou <eagle.zhou@nxp.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>
CC:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] media: amphion: Move the blocking
 check_is_responsed() out of wait event loop
Thread-Topic: [EXT] [PATCH] media: amphion: Move the blocking
 check_is_responsed() out of wait event loop
Thread-Index: AQHaBjrZNmd4W8AL30+T9gvj2MJn57BYhL7w
Date:   Tue, 24 Oct 2023 07:12:43 +0000
Message-ID: <AM6PR04MB6341E9DCD1BC75F6F7773DA9E7DFA@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20231024052709.2897714-1-xiaolei.wang@windriver.com>
In-Reply-To: <20231024052709.2897714-1-xiaolei.wang@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|DB9PR04MB8462:EE_
x-ms-office365-filtering-correlation-id: ef551722-b668-4a9b-931a-08dbd4609dee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P/zvm9kfNMen8Yw3yIUrOYxlmXoKDE/9lCkmh2gameaY9ocI5ercyWCreETfsWmNw0Co65dKIzqD/kqr08eo/daqPVq9KyHMgtn/rr3BdaR27jdTsJefyZdWNhzZoGCVE+STnXPHRjJ6ycGHW4RWPlpurC8eglq8RNiDOFD/JpSqxCyuGIiWU1LRmfYKNWA//G+bvMQf1+f9s6qpO5+IPEFSVXt8G6Cgo7uXHMdmfMn+Pgcu5jol65/3pRsLsWOI9PlnNgBbkj1UKOscPPBVpt5nM6RfxPH8gYdzkX6aomIwHH83FU7qKMlxwwz0P6X9ib+e3POjyMGd5qQtUDNqtM90B1sTXlXES4iyQ5VRixQwx3m58WxR9arylAvKmgI7GOkplSe5y6UUSsA18PsCjGet+owhI4GyGDXfz59eSKcUJpDmI/cK3iQJu2Ejjt+p+jKP9r6MYZkuowGsu5VVD6sHNow7/s0eYeufqNOQ8CFl4BTTmYSf1uf9G8KeqGQaNteYq7oOwgAN897UoT51faec+s2LEegb0fq5i4ncvtP2bqtJN4kH4TZ64d4ey55FiSkUaXECb+m6VeIbgVsgATOIPjSAG4bKt0BS5bFs0BTvTk4EYMEH/E4EtWgEZieQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(4326008)(8936002)(8676002)(52536014)(44832011)(41300700001)(38070700009)(2906002)(5660300002)(26005)(122000001)(71200400001)(38100700002)(6506007)(9686003)(7696005)(83380400001)(33656002)(76116006)(66446008)(66556008)(66946007)(54906003)(64756008)(86362001)(110136005)(316002)(66476007)(55016003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VVBRaFFJWno0bnJ3RGYvWU5QQ2Y5UWpyYTlVN3hDaXF2OVo1ZHRkQi9GbmNy?=
 =?gb2312?B?U3lCRnhORGI2SUZUaXA2TW9wcXJyajhDdENwSFY5ZUdLY0RuazRIdlpGejQv?=
 =?gb2312?B?aTA1ajFaeEFadnVsOGdKbENVZkgvK2hMWDZySVBOS3RmTTgwREJ6MkJ2MUpE?=
 =?gb2312?B?N2ZiWlBBa2t4elA4eTR1Mm9YUTlCUUlYZWZGbTZ5cTRONW5DcGlSa2FMRkFH?=
 =?gb2312?B?bkJoc2JEUmZrMkhIT0xFSHFHLzVMQjd5d045dzZ3YXpFYlM5MXZQSkZnTTBk?=
 =?gb2312?B?QUFFankzT1lBODdiaTREMFhJb05yOUprcUY2V2NnSDVGbTIyOVM0ZGZxWW5J?=
 =?gb2312?B?ZkJXdWoyODU1WGczVE1oRUlXS2g5RnFub2ZtUys0THN6MEIva1RHM21xWjBH?=
 =?gb2312?B?d2FNeVp5cGxMVms4dng1RFh1Qm04ZC9QZWZrOFdpSVlKSUdvR25HVzAvTmpu?=
 =?gb2312?B?QWR6eDVzU3M4TmsxdFNPckNybnJ2dGRUTDJjVEdoTFRHUjZ0QUNPNGYzNml2?=
 =?gb2312?B?ODcybUlUYzZ6b0x2WWl6K2tTdnZVNEFFUE5UTjV3VVRsZFpCNkRRczY0eTJi?=
 =?gb2312?B?cUxDU0c0eVlEbzlJdFo3UHpXS1FBS0gyY0hYNXdRWFJFWGZVQmxUdmx5YWla?=
 =?gb2312?B?YkU1aDBBU3B3eTJ5OWlORkQyWE9RYkRqSVN3dVpRMGRXZ1RqS29kMWNoU1Iv?=
 =?gb2312?B?K21oRk02dnFXOGFSb3R0aEZ1Qmh0aWVpN0oycFRVVXdNRlFJTlVTV2RKdERv?=
 =?gb2312?B?aGVxWEErSUtRbUovQTdwZS9jVkdGRi9nbmFBd1lYb3BSdC9ZSVo0dzhYb0VP?=
 =?gb2312?B?bVJRSGJZcmlIOEJYQXFVTDhLWWMxd0ZpODVhMzF4MUpTdHBJdHBRNEw2TkY2?=
 =?gb2312?B?c09FSm9KN0NFNllGZVZTNEFTTVJFZGRFV0R4VUJIdlg1N0VaNDhGWlltbVgy?=
 =?gb2312?B?alpmOHhNdTY2YTNKZmhFR2ZlTnlqcDB0Y05XRmxXUHExY1NJWC9KVHlxUVlM?=
 =?gb2312?B?TmhaNzhCMHdEc1oxdGx1NEU5MHRrODNLL05kS3VVSGwzZ1lkd01pdVhsNVlP?=
 =?gb2312?B?UDl0QVRSRWlPbS90anFZMFhtall2T3d1M3hZMnFObGt3ZEtvTE1CMGZWVHM4?=
 =?gb2312?B?T3pXaURET2JoR0I2YlJCM081d25aL3ZFYmlhQm1KcGlaR1MxNk1Zbi9YUlli?=
 =?gb2312?B?RnN0TGZmZmxqUUVyWHRwOUNHL1cySkFKQ3YxclVPbVVCZmROclVPLzVYWHlN?=
 =?gb2312?B?ZDcxUEZNWU11bElibm9YdHpNS3J2YjVLVkxLakZuMkQ4TGdaWXNneWE1dVZG?=
 =?gb2312?B?V0R2U25nSGZkSnhpYStqYVRUMjl3Y1VIdzQyMm9XWlVnNDRxMWdxZS94MXEr?=
 =?gb2312?B?RDEyQzNFU2pVNnpub1R3K0pnMy91eXZyUktSbkZ1bE9EalRwSmxaNzAxYTZi?=
 =?gb2312?B?V2VFQVluaVRZbzh4RmxwbTZsakFjZVVMQWk2c1VtcjZ4bmRLSFk1SUJrUlR0?=
 =?gb2312?B?UEUyaFViWlhYbERvOFJiUENWNkt3YTFSM0M1VC9Lc0NCWG9HcGZjT29OT3Bn?=
 =?gb2312?B?K21yYTJmbnZvdS9IUndFY2RlanF2UURzcDJNUDB5ZnpPM05wSnVzcWlZYUhK?=
 =?gb2312?B?dHdWaUZzc3dWZEV2RDdDbzhRUGJFU0FUaGdDdUplWDhEYVNoeTQzbEN0MGpZ?=
 =?gb2312?B?d25ORURneEhEQ2JZRjB3NTZCK0FNS3NSSDJnL2VwUTlWb0ZKNGtUOXJLRDcy?=
 =?gb2312?B?TDZ6SU1xTHJObHhQWnhSUy9BTU5JSUdiYmVqWTJ2eitGRHVza0l3OC9jMG95?=
 =?gb2312?B?UzJ4VGlwZUNGUXFqbjMxNm0xcStVWFpvZnhvUGtZdmVpTTcxN3lEblhYYVNO?=
 =?gb2312?B?c3NEOFU2b1V2djk2R0xxd0R2U3p0M0FSbkUyTThnVk5ocTVseHlkT1V2UXpY?=
 =?gb2312?B?czRLUDdPQTMyQ2lLSjRSM21JMzBLTUZVaHJmZWdOWDhBeHBzQmlSUVh6czJU?=
 =?gb2312?B?WXlLYTMwK0ozRkZpOGlxYm9qc1VMblQrY2tNVUdPYVVkeGZLbnNEc2QwcE5D?=
 =?gb2312?B?RGVMeFZ3c2NDS3dHZmsvNUQwTXlQMGE1UUFuQ0RacnBWRCtKdzcrdjZDQmVr?=
 =?gb2312?Q?ijyc=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef551722-b668-4a9b-931a-08dbd4609dee
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 07:12:43.4435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nb3fgt2ldVbnvq4olsmcGmPicysH+BMtsw2WsEK47hmwnVmx0tKbz4VzIdSCNn6uK4HjFJ5Dmvr7EjrLu4tqKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8462
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyb206IFhpYW9sZWkgV2FuZyA8eGlhb2xlaS53YW5nQHdpbmRyaXZlci5jb20+DQo+U2VudDog
MjAyM8TqMTDUwjI0yNUgMTM6MjcNCj5UbzogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT47
IEVhZ2xlIFpob3UgPGVhZ2xlLnpob3VAbnhwLmNvbT47DQo+aHZlcmt1aWwtY2lzY29AeHM0YWxs
Lm5sOyBtY2hlaGFiQGtlcm5lbC5vcmcNCj5DYzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogW0VYVF0gW1BBVENIXSBt
ZWRpYTogYW1waGlvbjogTW92ZSB0aGUgYmxvY2tpbmcNCj5jaGVja19pc19yZXNwb25zZWQoKSBv
dXQgb2Ygd2FpdCBldmVudCBsb29wDQo+DQo+Q2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBl
bWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+b3BlbmluZyBh
dHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAn
UmVwb3J0DQo+dGhpcyBlbWFpbCcgYnV0dG9uDQo+DQo+DQo+VGhlIGJsb2NraW5nIG9wcyBjYW4n
dCBiZSB1c2VkIGFzIGEgY29uZGl0aW9uIHBhcmFtZXRlciBvZg0KPndhaXRfZXZlbnRfdGltZW91
dCgpLCBvdGhlcndpc2Ugd2Ugd291bGQgZ2V0IGEgd2FybmluZyBsaWtlIGJlbG93Og0KPg0KPiBk
byBub3QgY2FsbCBibG9ja2luZyBvcHMgd2hlbiAhVEFTS19SVU5OSU5HOyBzdGF0ZT0yDQo+IFdB
Uk5JTkc6IENQVTogNSBQSUQ6IDc0MSBhdCBrZXJuZWwvc2NoZWQvY29yZS5jOjk4NTkNCj5fX21p
Z2h0X3NsZWVwKzB4ODAvMHhhNA0KPiBDUFU6IDUgUElEOiA3NDEgQ29tbTogbXhjX3Y0bDJfdnB1
X3RlIFRhaW50ZWQ6IEcgICAgICAgICBDICAgICAgICAgNi4xLjU1LXlvY3RvLQ0KPnN0YW5kYXJk
ICMxDQo+IEhhcmR3YXJlIG5hbWU6IEZyZWVzY2FsZSBpLk1YOFFNIE1FSyAoRFQpDQo+IHBzdGF0
ZTogNjAwMDAwMDUgKG5aQ3YgZGFpZiAtUEFOIC1VQU8gLVRDTyAtRElUIC1TU0JTIEJUWVBFPS0t
KSAgcGMgOg0KPl9fbWlnaHRfc2xlZXArMHg4MC8weGE0ICBsciA6IF9fbWlnaHRfc2xlZXArMHg4
MC8weGE0ICBzcCA6IGZmZmZmZmMwMTIzNzM4YTANCj4geDI5OiBmZmZmZmZjMDEyMzczOGEwIHgy
ODogZmZmZmZmYzAwOTE5NGM0OCB4Mjc6IGZmZmZmZmMwMGJiYzEwNTANCj4geDI2OiBmZmZmZmY4
ODE0YjI4MmYwIHgyNTogZmZmZmZmODgxNGIyODBkMCB4MjQ6IGZmZmZmZjg4MTRiMjgwODANCj4g
eDIzOiAwMDAwMDAwMDAwMDAwMDAxIHgyMjogMDAwMDAwMDAwMDAwMDAzMiB4MjE6IGZmZmZmZmMw
MGJiYzEwMDANCj4geDIwOiAwMDAwMDAwMDAwMDAwMTFiIHgxOTogZmZmZmZmYzAwOTMyNDY3MCB4
MTg6IDAwMDAwMDAwZmZmZmZmZmQNCj4geDE3OiAzMDMwM2M1YjIwNzQ2MTIwIHgxNjogNzQ2NTcz
MjAzMjNkNjU3NCB4MTU6IDYxNzQ3MzIwM2I0NzRlNDkNCj4geDE0OiAwMDA1OGI1YjhiOWFhMWYx
IHgxMzogZmZmZmZmYzAwOTAzY2RhMCB4MTI6IDAwMDAwMDAwZDc0NGZjYzkNCj4geDExOiAwMDAw
MDAwMDAwMDAwMDFjIHgxMDogMDAwMDAwMDAwMDAwMDlhMCB4OSA6IGZmZmZmZmMwMDkwMjAxZjQN
Cj4geDggOiBmZmZmZmY4ODI4MjQ1MDAwIHg3IDogMDAwMDAwMDAwMDAwMDAwMSB4NiA6IDAwMDAw
MDAwMDAwMDAwMDENCj4geDUgOiAwMDAwMDAwMDQxMGZkMDgwIHg0IDogMDAwMDAwMDAwMDAwMDAw
MiB4MyA6IGZmZmZmZjg4MTVhYWI0YzgNCj4geDIgOiAwMDAwMDAwMDAwMDAwMDAwIHgxIDogMDAw
MDAwMDAwMDAwMDAwMCB4MCA6IGZmZmZmZjg4MjgyNDQ2MDANCj4gIENhbGwgdHJhY2U6DQo+ICBf
X21pZ2h0X3NsZWVwKzB4ODAvMHhhNA0KPiAgbXV0ZXhfbG9jaysweDJjLzB4ODANCj4gIHN5bmNf
c2Vzc2lvbl9yZXNwb25zZSsweDExMC8weDMxMA0KPiAgdnB1X3Nlc3Npb25fc2VuZF9jbWQrMHgx
OGMvMHgyNDQNCj4gIHZwdV9zZXNzaW9uX3N0YXJ0KzB4MzgvMHg3MA0KPiAgdmRlY19zdGFydF9z
ZXNzaW9uKzB4MWI0LzB4M2UwDQo+ICB2cHVfdmIyX3N0YXJ0X3N0cmVhbWluZysweGEwLzB4MWM0
DQo+ICB2YjJfc3RhcnRfc3RyZWFtaW5nKzB4NzQvMHgxNjANCj4gIHZiMl9jb3JlX3FidWYrMHg0
ODgvMHg2NTANCj4gIHZiMl9xYnVmKzB4OWMvMHgxMDANCj4gIHY0bDJfbTJtX3FidWYrMHg3Yy8w
eDIyNA0KPiAgdjRsMl9tMm1faW9jdGxfcWJ1ZisweDIwLzB4MmMNCj4gIHY0bF9xYnVmKzB4NTAv
MHg2Yw0KPiAgX192aWRlb19kb19pb2N0bCsweDE3NC8weDNmMA0KPiAgdmlkZW9fdXNlcmNvcHkr
MHgyMTAvMHg3Y2MNCj4gIHZpZGVvX2lvY3RsMisweDIwLzB4MzANCj4gIHY0bDJfaW9jdGwrMHg0
OC8weDZjDQo+DQo+SXQgaXMgbm90IGVhc3kgdG8gY29udmVydCB0aGUgY2hlY2tfaXNfcmVzcG9u
c2VkKCkgdG8gYSBub24tYmxvY2sgZnVuY3Rpb24uIEluDQo+b3JkZXIgdG8gZml4IHRoaXMgaXNz
dWUsIHVzZSBhIHVud2luZGluZyBpbXBsZW1lbnRhdGlvbiBvZg0KPndhaXRfZXZlbnRfdGltZW91
dCgpLg0KDQpIaSBYaWFvbGVpLA0KDQogICAgVGhhbmtzIGZvciB5b3VyIHBhdGNoLCB0aGlzIGlz
c3VlIGlzIGNhdXNlZCBieSBjYWxsaW5nIG11dGV4X2xvY2soKSBpbiBjb25kaXRpb24gcGFyYW1l
dGVyIG9mDQp3YWl0X2V2ZW50X3RpbWVvdXQoKSwgSSB0aGluayB3ZSBjYW4gZml4IHRoaXMgaXNz
dWUsIHRoZW4gd2UgY2FuIHN0aWxsIHVzZSB3YWl0X2V2ZW50X3RpbWVvdXQoKQ0KaW5zdGVhZCBv
ZiByZXdyaXRlIGl0Lg0KDQpNaW5nDQoNCj4NCj5TaWduZWQtb2ZmLWJ5OiBYaWFvbGVpIFdhbmcg
PHhpYW9sZWkud2FuZ0B3aW5kcml2ZXIuY29tPg0KPg0KPnNxdWFzaCEgbWVkaWE6IGFtcGhpb246
IE1vdmUgdGhlIGJsb2NraW5nIGNoZWNrX2lzX3Jlc3BvbnNlZCgpIG91dCBvZiB3YWl0DQo+ZXZl
bnQgbG9vcA0KPi0tLQ0KPiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X2NtZHMu
YyB8IDE1ICsrKysrKysrKysrKysrLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPg0KPmRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L2FtcGhpb24vdnB1X2NtZHMuYw0KPmIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hbXBoaW9uL3Zw
dV9jbWRzLmMNCj5pbmRleCBjMjMzNzgxMjU3M2UuLjFhYmVjOGQ5ZGFkNSAxMDA2NDQNCj4tLS0g
YS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2FtcGhpb24vdnB1X2NtZHMuYw0KPisrKyBiL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vYW1waGlvbi92cHVfY21kcy5jDQo+QEAgLTI3MSw2ICsyNzEsNyBA
QCBzdGF0aWMgYm9vbCBjaGVja19pc19yZXNwb25zZWQoc3RydWN0IHZwdV9pbnN0ICppbnN0LA0K
PnVuc2lnbmVkIGxvbmcga2V5KSAgc3RhdGljIGludCBzeW5jX3Nlc3Npb25fcmVzcG9uc2Uoc3Ry
dWN0IHZwdV9pbnN0ICppbnN0LA0KPnVuc2lnbmVkIGxvbmcga2V5LCBsb25nIHRpbWVvdXQsIGlu
dCB0cnkpICB7DQo+ICAgICAgICBzdHJ1Y3QgdnB1X2NvcmUgKmNvcmU7DQo+KyAgICAgICBzdHJ1
Y3Qgd2FpdF9xdWV1ZV9lbnRyeSB3cV9lbnRyeTsNCj4NCj4gICAgICAgIGlmICghaW5zdCB8fCAh
aW5zdC0+Y29yZSkNCj4gICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+QEAgLTI3OCw3
ICsyNzksMTkgQEAgc3RhdGljIGludCBzeW5jX3Nlc3Npb25fcmVzcG9uc2Uoc3RydWN0IHZwdV9p
bnN0ICppbnN0LA0KPnVuc2lnbmVkIGxvbmcga2V5LCBsb25nDQo+ICAgICAgICBjb3JlID0gaW5z
dC0+Y29yZTsNCj4NCj4gICAgICAgIGNhbGxfdm9pZF92b3AoaW5zdCwgd2FpdF9wcmVwYXJlKTsN
Cj4tICAgICAgIHdhaXRfZXZlbnRfdGltZW91dChjb3JlLT5hY2tfd3EsIGNoZWNrX2lzX3Jlc3Bv
bnNlZChpbnN0LCBrZXkpLA0KPnRpbWVvdXQpOw0KPisgICAgICAgaW5pdF93YWl0X2VudHJ5KCZ3
cV9lbnRyeSwgMCk7DQo+KyAgICAgICBmb3IgKDs7KSB7DQo+KyAgICAgICAgICAgICAgIGlmIChj
aGVja19pc19yZXNwb25zZWQoaW5zdCwga2V5KSkNCj4rICAgICAgICAgICAgICAgICAgICAgICBi
cmVhazsNCj4rDQo+KyAgICAgICAgICAgICAgIHByZXBhcmVfdG9fd2FpdF9ldmVudCgmY29yZS0+
YWNrX3dxLCAmd3FfZW50cnksDQo+KyBUQVNLX1VOSU5URVJSVVBUSUJMRSk7DQo+Kw0KPisgICAg
ICAgICAgICAgICB0aW1lb3V0ID0gc2NoZWR1bGVfdGltZW91dCh0aW1lb3V0KTsNCj4rICAgICAg
ICAgICAgICAgaWYgKCF0aW1lb3V0KQ0KPisgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0K
PisgICAgICAgfQ0KPisNCj4rICAgICAgIGZpbmlzaF93YWl0KCZjb3JlLT5hY2tfd3EsICZ3cV9l
bnRyeSk7DQo+ICAgICAgICBjYWxsX3ZvaWRfdm9wKGluc3QsIHdhaXRfZmluaXNoKTsNCj4NCj4g
ICAgICAgIGlmICghY2hlY2tfaXNfcmVzcG9uc2VkKGluc3QsIGtleSkpIHsNCj4tLQ0KPjIuMjUu
MQ0KDQo=
