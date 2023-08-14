Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CCF77B1B2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjHNGgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjHNGfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:35:50 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2053.outbound.protection.outlook.com [40.107.249.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF4D10D7;
        Sun, 13 Aug 2023 23:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxEVefwjpnmfZq301ZxQ6bhf8wre/3rreePShFtyAz25to8c7oQJJH+kMF+SeWuA0Whm1FIqImWdorFf6TLJUDKfvsNwdSdMw9ygHiU10hEGwKtyysJJZ28sR59J7UGvj5yW1WCCGekZFWUd/N04aG3zvcss34LYY0dcou6sQSqNQ+/kAxaQPWAecht8Nrn9/mi3J6patIv0LR1aAblgm7jUGAiCNp+AUYrl/ALTVtKYuJgVKwlyhrIpie9wPIyuIaLXek4olLgsgGLVHxUuUZwlImN5aYDp5B9dSwMB4sNb775Hz3tfTiWkfLFXeblQXWj25XmD6b31kAb/CyyT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vtt9UVy36I47ijPUYiOWNkwxNv3vTbpPy0Kng4ZRZK4=;
 b=ItT7p/z0XUysLqZ7qywNa5pDe4Q9oAvXlQjXngWKLeHNHaUkPwJ7MosJcjAo+H3N52dFxhp68wa6vM6P0Fdx80KngoA14sGr6C2/dlx6rhdbw7dJNsvTcuM0T3/6Up38hzh2v4c9YMIY2cDM/b4CKlRnVrsh/EAj+dPrzWHWgJ0O6c/NnKKX3FY6HTQOi47w3uK/t3NfpmHcQUvyPwgg9G3NEyg3Zc9SHk3yrYdp12scepgNNI6weGSNtk4ULSZYyjeULPZ8yCNnLWUOnqWIW4uIhHuFvQ8yPnHEd7AffmyjfPeyptpuUKItxCYw41zMp73OWCQ9YzqitmWCwry3KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vtt9UVy36I47ijPUYiOWNkwxNv3vTbpPy0Kng4ZRZK4=;
 b=WCkmwUvxwijEh8+Dx8KHeOiW5zLR7eKGx0qN722RWKDj8fiGBJb26kqcLstwJbjRx879NxSh2s8UsD5WjrL6GkVrLuELs67gK6nEoTjDiMXRoUGvI6v8lw+knHtfZgP8RBE+4YMvTl5Mp85FJzmIsw86FjyT3v0pC01kF4a1Kt4=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by PAWPR04MB9912.eurprd04.prod.outlook.com (2603:10a6:102:387::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 06:35:34 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::1392:7c78:1b43:769f]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::1392:7c78:1b43:769f%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 06:35:34 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] crypto: caam/jr - fix shared IRQ line handling
Thread-Topic: [PATCH] crypto: caam/jr - fix shared IRQ line handling
Thread-Index: AQHZyebj5uO41ZXd906jN1MGG70A7a/pXzeQ
Date:   Mon, 14 Aug 2023 06:35:34 +0000
Message-ID: <AM0PR04MB6004A1287DD4DD0BFD08810AE717A@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230808105527.1707039-1-meenakshi.aggarwal@nxp.com>
 <20230808105527.1707039-3-meenakshi.aggarwal@nxp.com>
In-Reply-To: <20230808105527.1707039-3-meenakshi.aggarwal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|PAWPR04MB9912:EE_
x-ms-office365-filtering-correlation-id: af7c1fca-af24-49d3-8e84-08db9c90a9d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qbj4Fa2iQ/a3nesQV04v82t+NqXTbax9FkXUB8NtZVbb8AYe8thgs9fZpoZMsqzMBXA4KI4IyVRa89ecfXAnHwDTdff8IwRMpuo6in7PyR8cCzhnsLlzVr7etQ2mpe3vqM+FUqelvrogMa3MKo/LzA5KQQysbdshWwuRp0F190gD8IgjOBfm9Uy+V/7zqm5qtDHL7SavSiKaz4mbuQC64mv6ShWfu8wV7MjL+3/+3tl1hclo0PyETJN0TGE8aEq8Pl5lU8suIVlmjZ3gsvPPMMKeqRwAN5z+RNDsm0OaqbFUh9q5pnLd4pcvshWNMQxgxw2WpUmHHRx6pGrnL7KuIkFIrdYbbcXtHjaDKtCX4EtBhSXji4cOxawZ/zhUwG5Hyu3bvuLKdMjYu8mG0jTTMBoeOLIbvXAVx/nUEy9XE4CC0M3Bi47BWrrzef0DoKcL3mC6wpYC7X0SuHUEQkieqDmWMH4YkqE9VH928DUJAVHqAsnahxfLjRHISdulvyIaTozTGbq3/07RoszUjAsG5DWcSV+JkCgz0PzCHyibSex8geZiW3gYmclpavISZqFlUeLC+Olxm6vdD/odgAueGjMb29fzR/Ow54OZWcb9bDRl+T/HMq7GMGQ43c1IeFWf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(39860400002)(366004)(1800799006)(186006)(451199021)(478600001)(71200400001)(110136005)(76116006)(6506007)(7696005)(26005)(55236004)(53546011)(9686003)(66946007)(2906002)(55016003)(8936002)(8676002)(66446008)(66476007)(66556008)(64756008)(316002)(41300700001)(44832011)(52536014)(5660300002)(38100700002)(38070700005)(122000001)(86362001)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0tLb2R6ajE3dVNvS3IzekpSVFR4YkxuRFVxb2RiUGNJVEJ5Y21UMW5qbVhC?=
 =?utf-8?B?WDdBdVp6ZnBSNG9adG9DL2VxcVJqZWFFM1RIaGJNS0p2eWFYR1lseTRvL2NF?=
 =?utf-8?B?RGFEazdUM0h4Q09kN1VFRDJrR0RtRjZxL0IwZkhRQlJpcXJqV0s1dDRLaVcr?=
 =?utf-8?B?aDNERExTRmQ2T2JiMytjemdnMVF1WjNKeVhOZXExcGx3NmxPNFZYREs5bjBD?=
 =?utf-8?B?RDZ6Z3l2WlBvenJ4VTVuazBjV0EwUE1rRTc5T05EWWE4NDdSVjV2RFVkMUlO?=
 =?utf-8?B?QThZbDZTUzVUMnVzQjJheXozczZXV09GalJ4R1Mxb2VUc2p0MjIzWFFOOHRl?=
 =?utf-8?B?Y3lONlQzbjd6eVFOR2pHRkQ4cVRHUTNXalV0a3AxM0ErSTBkdHljZXdWTkdN?=
 =?utf-8?B?c09Hd2NXSjV4VW1aTGE4NXMvMG5wYkVLeHRhakVlOWtOeUtHMTlxOXJZMW9l?=
 =?utf-8?B?K1lYNW5BdWt3SzNnNWc2MlAyQ1NXVTRXUFB2bGpwNDBaeXlLK0orZ1hleWNF?=
 =?utf-8?B?SU1wV0cyMjdqVDI2am5qakdjbXpzRVN3b2JXUitla2NwTlR6TWZxQVIrVUVk?=
 =?utf-8?B?Vk8zVWlSZVptOUNBYjVEenp4WVdaekpyK1YyS291dll4Zi9vdnE0T2R1VmlB?=
 =?utf-8?B?Z0M1bEVScDhYTFhURUtvMENrMUhLd1RndHV4dUFVMDI4cUJzNDdCTjltWnpP?=
 =?utf-8?B?Y2RsVGVpemNPWGY5VHREMVo4eVdaeUIvZHRhZVhaTlZZT0lVdHRHcDY4UjI0?=
 =?utf-8?B?WHpMamQrNWdUL1hzankxWHQyUXZSUFlNNS94SEZmMmIrcy9HWXYxZUloUVVU?=
 =?utf-8?B?cXppTnJWRzlyUjF6U1BvbG5qaklhaHAyQXlWZ1RvSEtlNDl3WHlqN0Ntd2Yy?=
 =?utf-8?B?enRYM2ltcDlaK0pFV205K2l0QkxLdHBMUzhwYVZlSTZsejdmM2pqa2JmL1Z3?=
 =?utf-8?B?bldlOHQwaThPTFdmYWt3ZldwZVd4ZnpuaWJ5ZVhZcHFFMXB4RmZ5aHJPQ2gy?=
 =?utf-8?B?MHQ0RlU1Y1F3VEdOQklnQ0lGTCsrLzVyUXVWRE0rMmJjSlFlaUVlS3ZRMnll?=
 =?utf-8?B?MFZNVTdCb3k1dzJuNHNOUTc0TzlOcngrUTg2OE5DeldYQ21OdFh1U0QrVGdx?=
 =?utf-8?B?L2xQY3UvN2VJZXdiVDhqMUlFd21FNW1ZdURnTTVSVXR2a3RNL3p6L3FIcnI4?=
 =?utf-8?B?TmlMU3AwRWxiMExRQ1NLQkdCNnlYL3BTZnplcXl4bEFxQndKSGRTWnNRUk5L?=
 =?utf-8?B?WURRSGp0cjJvWnBxMmxBNFJ3QllGWnRkQTRoM0t3NGxiY1N2WjJQMUVqcnJV?=
 =?utf-8?B?aFZpbmtEQkJYNWxmdnd2RlVRcm1xMHBmNkt1Qnk0akt0ZWY1TDlqQkQ5ZHd5?=
 =?utf-8?B?bDBhekdndjdFM3JqOUNNeXB4U29HL2lGWG9OMlFlaDJVaFY1QXZkSWhTWmlt?=
 =?utf-8?B?OEIrbU9USkVJUGpHMFU1NmM0bWtlWnZZTzJuZ3hMK0FRRkwxS0RBV2NDUnZV?=
 =?utf-8?B?dkNoNUg5d2hQMUhpM0xseml4SWY1R3NyYmlpUG1TRENEb0Z3N0hrK2xDU0kr?=
 =?utf-8?B?dWhrQys3eVNmd0EvTk5hYUpJTlArOEJTZ2RHcjZGekNLalFSbnZaRGZ6cnR4?=
 =?utf-8?B?bkdRQmtIbzZmbitaN3JLYWNPUnZxYXgrc3lYMC8wVTkvZWFlOHp4bWpoNFlC?=
 =?utf-8?B?WmVCTWxFeTRTMEpRY0pBTk9YcFp3Y1NTa2dSOGMvY3RMMnc3UzBacjg1cGIw?=
 =?utf-8?B?Wk9mNWpaUStZanVwM2F3dkdBZ0pPTGd4OHRWS3hmY2VZMHJPa3NhQlRTQ0lL?=
 =?utf-8?B?amRTWE1lbGUwRW8rNEoyWENUeUxwWHZvb0ZpR3BJVlc1WWk1REY5M0NHQlFa?=
 =?utf-8?B?QlhlUWdIZ25Ldjg0ZGhsd0ViYjRaSFFpdkRONytuUCtPS29nc3dBejBtTFRV?=
 =?utf-8?B?Q1hSdlBSUUtUc3luLy9oRHh0aHhReCswcmY0MTdoWEF3Z2lKOWtKRFVWZHpt?=
 =?utf-8?B?M2xSMzVXNU01V2hWcDRRbnMxUE9yYnduTDNUWVgyM1Z2N1FOMVhtL1lzMUVQ?=
 =?utf-8?B?VlduZnZEbnNVZzN2RkxLZi9SVFRhZGR1WnpDekp1UXJ1U25jOVQ0T3FTdHN5?=
 =?utf-8?Q?6xLvObXsVRDuffqVQd8qzTBNB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7c1fca-af24-49d3-8e84-08db9c90a9d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 06:35:34.1171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ph+GcX+5DmCScbw92vO10rzPEdVrxYzYQ7Mlez+2UcDR8/VEXGJJR+oGpXf8l1lTc++pHjJ+0AnyL1TyRIy5kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9912
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IEdhdXJhdiBKYWluIDxnYXVyYXYuamFpbkBueHAuY29tPg0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1lZW5ha3NoaSBBZ2dhcndhbCA8bWVlbmFr
c2hpLmFnZ2Fyd2FsQG54cC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCA4LCAyMDIzIDQ6
MjUgUE0NCj4gVG86IEhvcmlhIEdlYW50YSA8aG9yaWEuZ2VhbnRhQG54cC5jb20+OyBWYXJ1biBT
ZXRoaSA8Vi5TZXRoaUBueHAuY29tPjsNCj4gUGFua2FqIEd1cHRhIDxwYW5rYWouZ3VwdGFAbnhw
LmNvbT47IEdhdXJhdiBKYWluIDxnYXVyYXYuamFpbkBueHAuY29tPjsNCj4gaGVyYmVydEBnb25k
b3IuYXBhbmEub3JnLmF1OyBkYXZlbUBkYXZlbWxvZnQubmV0OyBsaW51eC0NCj4gY3J5cHRvQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogTWVlbmFr
c2hpIEFnZ2Fyd2FsIDxtZWVuYWtzaGkuYWdnYXJ3YWxAbnhwLmNvbT4NCj4gU3ViamVjdDogW1BB
VENIXSBjcnlwdG86IGNhYW0vanIgLSBmaXggc2hhcmVkIElSUSBsaW5lIGhhbmRsaW5nDQo+IA0K
PiBGcm9tOiBIb3JpYSBHZWFudMSDIDxob3JpYS5nZWFudGFAbnhwLmNvbT4NCj4gDQo+IFRoZXJl
IGFyZSBjYXNlcyB3aGVuIHRoZSBpbnRlcnJ1cHQgc3RhdHVzIHJlZ2lzdGVyIChKUklOVFIpIGlz
IG5vbi16ZXJvLCBldmVuDQo+IHRob3VnaDoNCj4gMS4gQW4gaW50ZXJydXB0IHdhcyBnZW5lcmF0
ZWQsIGJ1dCBpdCB3YXMgbWFza2VkIE9SIDIuIFRoZXJlIHdhcyBubyBpbnRlcnJ1cHQNCj4gZ2Vu
ZXJhdGVkIGF0IGFsbCBmb3IgdGhlIGNvcnJlc3BvbmRpbmcgam9iIHJpbmcuDQo+IA0KPiAxLiBU
aGUgY2FzZSB3aGVuIGludGVycnVwdCBpcyBtYXNrZWQgKEpSQ0ZHUl9MU1tJTVNLXT0xYicxKSB3
aGlsZSBvdGhlcg0KPiBldmVudHMgaGF2ZSBoYXBwZW5lZCBhbmQgYXJlIGJlaW5nIGFjY291bnRl
ZCBmb3IsIGUuZy4NCj4gLUpSSU5UUltIQUxUXT0yYicxMCAtIGlucHV0IGpvYiByaW5nIHVuZGVy
d2VudCBhIGZsdXNoIG9mIGFsbCBvbi1nb2luZyBqb2JzIGFuZA0KPiBwcm9jZXNzaW5nIG9mIHN0
aWxsLWV4aXN0aW5nIGpvYnMgKHNpdHRpbmcgaW4gdGhlIHJpbmcpIGhhcyBiZWVuIGhhbHRlZA0K
PiAtSlJJTlRSW0hBTFRdPTJiJzAxIC0gaW5wdXQgam9iIHJpbmcgaXMgY3VycmVudGx5IHVuZGVy
Z29pbmcgYSBmbHVzaA0KPiAtSlJJTlRSW0VOVEVSX0ZBSUxdPTFiJzEgLSBTZWNNb24gLyBTTlZT
IHRyYW5zaXRpb25lZCB0byBGQUlMIE1PREUgSXQNCj4gZG9lc24ndCBtYXR0ZXIgd2hldGhlciB0
aGVzZSBldmVudHMgd291bGQgYXNzZXJ0IHRoZSBpbnRlcnJ1cHQgc2lnbmFsIG9yIG5vdCwNCj4g
aW50ZXJydXB0IGlzIGFueWhvdyBtYXNrZWQuDQo+IA0KPiAyLiBUaGUgY2FzZSB3aGVuIGludGVy
cnVwdCBpcyBub3QgbWFza2VkIChKUkNGR1JfTFNbSU1TS109MWInMCksIGhvd2V2ZXIgdGhlDQo+
IGV2ZW50cyBhY2NvdW50ZWQgZm9yIGluIEpSSU5UUiBkbyBub3QgZ2VuZXJhdGUgaW50ZXJydXB0
cywgZS5nLjoNCj4gLUpSSU5UUltIQUxUXT0yYicwMQ0KPiAtSlJJTlRSW0VOVEVSX0ZBSUxdPTFi
JzEgYW5kIEpSQ0ZHUl9NU1tGQUlMX01PREVdPTFiJzANCj4gDQo+IEN1cnJlbnRseSBpbiB0aGVz
ZSBjYXNlcywgd2hlbiB0aGUgSlIgaW50ZXJydXB0IGhhbmRsZXIgaXMgaW52b2tlZCAoYXMgYQ0K
PiBjb25zZXF1ZW5jZSBvZiBKUiBzaGFyaW5nIHRoZSBpbnRlcnJ1cHQgbGluZSB3aXRoIG90aGVy
IGRldmljZXMgLSBlLmcuDQo+IHRoZSB0d28gSlJzIG9uIGkuTVg3VUxQKSBpdCBjb250aW51ZXMg
ZXhlY3V0aW9uIGluc3RlYWQgb2YgcmV0dXJuaW5nIElSUV9OT05FLg0KPiBUaGlzIGNvdWxkIGxl
YWQgdG8gc2l0dWF0aW9ucyBsaWtlIGludGVycnVwdCBoYW5kbGVyIGNsZWFyaW5nIEpSSU5UUiAo
YW5kIHRodXMgYWxzbw0KPiB0aGUgSlJJTlRSW0hBTFRdIGZpZWxkKSB3aGlsZSBjb3JyZXNwb25k
aW5nIGpvYiByaW5nIGlzIHN1c3BlbmRlZCBhbmQgdGhlbiB0aGF0DQo+IGpvYiByaW5nIGZhaWxp
bmcgb24gcmVzdW1lIHBhdGgsIGR1ZSB0byBleHBlY3RpbmcNCj4gSlJJTlRSW0hBTFRdPWInMTAg
YW5kIHJlYWRpbmcgaW5zdGVhZCBKUklOVFJbSEFMVF09YicwMC4NCj4gDQo+IEZpeCB0aGlzIGJ5
IGNoZWNraW5nIHN0YXR1cyBvZiBKUklOVFJbSlJJXSBpbiB0aGUgSlIgaW50ZXJydXB0IGhhbmRs
ZXIuDQo+IElmIEpSSU5UUltKUkldPTFiJzAsIHRoZXJlIHdhcyBubyBpbnRlcnJ1cHQgZ2VuZXJh
dGVkIGZvciB0aGlzIEpSIGFuZCBoYW5kbGVyDQo+IG11c3QgcmV0dXJuIElSUV9OT05FLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogSG9yaWEgR2VhbnTEgyA8aG9yaWEuZ2VhbnRhQG54cC5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IE1lZW5ha3NoaSBBZ2dhcndhbCA8bWVlbmFrc2hpLmFnZ2Fyd2FsQG54
cC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9jcnlwdG8vY2FhbS9qci5jIHwgMiArLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9jcnlwdG8vY2FhbS9qci5jIGIvZHJpdmVycy9jcnlwdG8vY2FhbS9qci5j
IGluZGV4DQo+IDU1MDdkNWQzNGE0Yy4uMDdlYzJmMjdjYzY4IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2NyeXB0by9jYWFtL2pyLmMNCj4gKysrIGIvZHJpdmVycy9jcnlwdG8vY2FhbS9qci5jDQo+
IEBAIC0yMzIsNyArMjMyLDcgQEAgc3RhdGljIGlycXJldHVybl90IGNhYW1fanJfaW50ZXJydXB0
KGludCBpcnEsIHZvaWQgKnN0X2RldikNCj4gIAkgKiB0YXNrbGV0IGlmIGpvYnMgZG9uZS4NCj4g
IAkgKi8NCj4gIAlpcnFzdGF0ZSA9IHJkX3JlZzMyKCZqcnAtPnJyZWdzLT5qcmludHN0YXR1cyk7
DQo+IC0JaWYgKCFpcnFzdGF0ZSkNCj4gKwlpZiAoIShpcnFzdGF0ZSAmIEpSSU5UX0pSX0lOVCkp
DQo+ICAJCXJldHVybiBJUlFfTk9ORTsNCj4gDQo+ICAJLyoNCj4gLS0NCj4gMi4yNS4xDQoNCg==
