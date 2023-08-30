Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1945978E02C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244115AbjH3TOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242485AbjH3Iua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:50:30 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2054.outbound.protection.outlook.com [40.107.13.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0920CC9;
        Wed, 30 Aug 2023 01:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlDMKGn6I8i4HOgjxn+DMzSJAfOQBKM3B0NSprImZ49Et1jnDZsj0DfP4CMb6tFwxaRiqTHqmhzyEAdb4nRnk1Ri1cef84nhHNR6xuxZCiZXsNkhs8xxzhDIR8eT0UJQ+nDKfsnV+HI5bUOkzpY9Jm54U00ThK94z9ARgpUwY2cxK3zlHkv7x6ekDqKz/MnTYp5clcYVybv2XMVFYoB1T3IrLnNMrlP3n0Mo3TtN3dDeutwAJywTJ4ewZ1H6bCZSCeXc7JAcxutH8wBfuPLgy1Q2/WfBEbeq/zrrEstPP+1cUKG5k/QNGNJlrf45b8eLdKgZS9MmwxHapN4JHgA+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVzLBW4oNbBDSpA71T1ukivvLPVs+D0aipFA6Wr0GlI=;
 b=imdtRtCyTTAi9ubcxohUPjLTiDxViIkK0UWnFv973/v9rMvccUUJtGn/tQ/tP2Tl2rs/4Q3YUgkyn9weAL9X54kwUKkFEOz577J+WTErNAXxgK/74HE1hWTLGAkMh3uKXcPMFs/HKWo8zD5QAGQW7Ofw+vDulZtsjeONqgZIda+5Tqh/7gIpO8ApN7jZCifRUbOakt/TQ/SJQQdXlFCQgOq+SjFps7dnJkoKEMLcbKcxVr8ZDyc0lYrhgs5xbwFWSAhBloBP0tEAKFRtML6ZZ5J9NlaQGFP6cH4K0G/F5uXidOIMZ29mb4J+DZpM/EevM4raWUwhBlmPrnBm+SLXLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVzLBW4oNbBDSpA71T1ukivvLPVs+D0aipFA6Wr0GlI=;
 b=Yrl8MP/2nIAqf9PTYPDd+VOb1JpuERMasLBvMdTZhZpriH+QiCPTz+0jCJxrHY2dI1nVIillYBik80ePjtcefEtmDVsZ5Bzv7GaFQDZU0Lg0So5xlVo7T6CiKvZHVUJ+Xa5LXWV0UDomSRdFY2xOZDEvgzqWz07rZJVWnzYYTvU=
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8)
 by AM8PR04MB7762.eurprd04.prod.outlook.com (2603:10a6:20b:241::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 08:50:23 +0000
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d]) by DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d%7]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 08:50:22 +0000
From:   Hui Fang <hui.fang@nxp.com>
To:     Anle Pan <anle.pan@nxp.com>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>
CC:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jindong Yue <jindong.yue@nxp.com>
Subject: RE: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
Thread-Topic: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
Thread-Index: AQHZ2UI/RGKEIcG6sEyAOrT4GOix9LACiU/w
Date:   Wed, 30 Aug 2023 08:50:22 +0000
Message-ID: <DB9PR04MB9284AA58AA71655C9C0C7C9A87E6A@DB9PR04MB9284.eurprd04.prod.outlook.com>
References: <20230828075420.2009568-1-anle.pan@nxp.com>
In-Reply-To: <20230828075420.2009568-1-anle.pan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9284:EE_|AM8PR04MB7762:EE_
x-ms-office365-filtering-correlation-id: 3432412e-1658-4ca3-f26a-08dba9362550
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OKgtLgxR+YXCCFCFDd6uKF4Y2epWeT26fu/95LrSywnsWxTZS+PXjTQDY7SOg6p4zdf5wiX0L75dZVs5DXtj5RlKkN7FTSwuOoTFZ61VOP4V/db2aX7RwoxucU6W5uZOOxWpyTIQ2ayNNpZPR7Yw+jST5IB3GwNJpXJFwgmuQpEyUu5cPRMYv7jL8NkhIMYY4wu7HnRu1OuctXFFUyLZvpRLV6Ndx2xoaXeij6Wx8LmkCYMN0EJHHvUz5gONspGEedV1AGA2vtNMfzhFO6aQ907xfxjA6F9Kt2JMqXDFkMu2cNZBZlfbCsw5SMHEoe5E+y6EJmIjN9/R0irigeuVLjZFpHKtGUI0at56Ngeir1sfhAWpS7s3C7rD62sb/7PYU1gkaxxyk/SKAWvsWcO1OFOKj1SBvB9VgHJJ9C8fF+njvWzce3VysNckPQK1AhmXK+mWRCDWlqQUTWIg3eO2ET10ObKyfoXq0kPK5o5kscQNqTCuxo6MZVCqfIQRLIH901s9YSUkWkzW6RkATWYg0eqFnj1u45356BxkvKizhDCu1KlrIraPhLOZ4/OUWpvqu2/+hRBG52ZPExe5cjbX1wOaOtH7opLs06Ou3cECsqFHSRq342cNHR+ePaJdcoAZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(396003)(346002)(1800799009)(186009)(451199024)(41300700001)(83380400001)(8936002)(55016003)(4326008)(8676002)(66476007)(478600001)(71200400001)(66446008)(66946007)(76116006)(110136005)(64756008)(54906003)(26005)(316002)(6506007)(7696005)(53546011)(9686003)(66556008)(4744005)(2906002)(38070700005)(38100700002)(122000001)(44832011)(52536014)(5660300002)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFZsN3QrSTVvcjk3MEZJbVRySGI1UGNBTnBsUzVUUDB3blBzbURHajBXcVRh?=
 =?utf-8?B?bWZFVDljbjdCejBXRFBsZVR0c2paRCtYS0pvTnk2N1oyN0JyTGsyWE1MejNj?=
 =?utf-8?B?aC9aZ0pzaWJTMktlV1B4SHNWczlhNitRYzdKbk5RcjF0Zzhld2NEaFNZdTFy?=
 =?utf-8?B?bEZadExZbFRGL3E5eC81a2RjbVdPMmxRWDU0TXZtenBJM00rQUNubUUzdytY?=
 =?utf-8?B?dnVLR2p6UzVHbzZYSTgwd1R5OExHWFoyQ0dobkRxR05nTzZCL1VrV0NMNUtD?=
 =?utf-8?B?aHkzTW51SjVhVmlsVHZXdWtTU3hUWXJmakdkc3BjYklZSkY4TU9XdDBrWWZZ?=
 =?utf-8?B?cXA5RjlYMWVLamExeFZnb1EzZVlUbHQyTmtwSEEwb2t0NnRzVTR4VFAwWkdw?=
 =?utf-8?B?b3Fhc0QrbE1oR3F4VWk0MGxkbnBuSTlmMW5iYXIxcVRuRTJDSWpLdzhPQ2pr?=
 =?utf-8?B?bld6THI4cVZXVm0vZ1ltMld0VXBjWGN6dHluSGI0ejJkN2ZDWU1CVTZVQzNm?=
 =?utf-8?B?b2tEK1lMODVNZytHVko5ZkVrUjJtbDIxbTlTcnFudVNycnoyOXhGMWtqbklV?=
 =?utf-8?B?QlNKc2FnRWNRRGRPRFZFM1FNM2k4d01jSHgyUzdGbUJFQmd2ellkYjFDRkh0?=
 =?utf-8?B?Sm5QVG5pSnZJaXgwRkdVSEVTRXp5T2lVZGdLMmh2aHo2VFJiRXJwZlRQaHF2?=
 =?utf-8?B?cHZ2eUdJNXB2RlZiWUtQQlgwM2FTR3F5amlhL3VUeHFrSC9qOW04TjZNTDNU?=
 =?utf-8?B?VEhGTXB5TWRwOG1oTTEzYW1RMjZrVXg4U2puemNpYVhwZGpYa2NQNkVBTzY3?=
 =?utf-8?B?Y3dTMDRGNHRIeHEyNlRsb1l3bDJGU1ZaWjhNa0phU2Y2eWh4d1VwR3lGaHNk?=
 =?utf-8?B?Nys3T3VhaGpyOHlsL2lJb2lhaFFNdExibnV4aFIrYlYxSEpJWlB3bEhhUmdN?=
 =?utf-8?B?YkNPLzhuSUJnQ2w5N2Rub2NpTllsSWFCRWx4U2lwRzVnTlJkYlBvK3p2SmlJ?=
 =?utf-8?B?RVM1WmI2L3Qya0hOdDJuR3F4aTJEd1plQWFtVmp4NUQ2MFJvY2t3ZDlqcnJS?=
 =?utf-8?B?WnZEd0FIdlA3V0s3WDYyZ3ZxZUJQWlNlb0ZiR0RUNEZmZWxINGtCczhjV3NL?=
 =?utf-8?B?MHhzTEFWKzhNN0EwUmY5MkswSktCREdhdk14cHNPUWlmdDh3RkJyelNCNHRx?=
 =?utf-8?B?dHQvSXBOUEpCMUtmNGkzS1I1MjV2UFVWeFV1VnU2eHFuNHliVmRSU3pUQUFU?=
 =?utf-8?B?TytMbUhmZm5ROVJlYzlRUUFjeVhrWVljU1VlRUFrM2p5TmgwVldSaXM2Yno1?=
 =?utf-8?B?dSt6bnNoVC8wT084RGFvalpnSTRkNW5JaWNEYmhEbmFCWFZWczJGNS9nSUM5?=
 =?utf-8?B?ekFzNHZZSTEzekI3eDFmcm0yblE5L3E0Mng1eFpCZlpHZFJNbVhycHJDVUY0?=
 =?utf-8?B?elNsYWxjVFJ1cUJPVjRxcCtlQzJqNVQza0hGaUZjK3pvbGUwYXNHQjIveno0?=
 =?utf-8?B?VXJKOEI0UGVJYXp5T20veDlOV2cxVTVKc1hSSEFxbHl1OWdBQTlSTmZnVUxD?=
 =?utf-8?B?T1J2NmNFS3Y1ZVJTbzVYc0JvMW1NdVRNeStZUG9hK3h4QlBrVUdURXVoRUJP?=
 =?utf-8?B?d1FaY051Snpva3ptZU9hanM1aUZac1BFRlNsN0ZaRTZpUmFZMGhzSnJ2M2Z1?=
 =?utf-8?B?Zy9TUHNZOENFd0oxQTFXTmRXWDR2bnZPMGJaU3hDcUJFblJjWnFmZGtDQXMr?=
 =?utf-8?B?Uk1LSnpBZEUveldMMlBPbkhhSUcxQ09TeDZEK2EvU2tKMmVuMGx0cGJMUjJm?=
 =?utf-8?B?cjhpSjkzTUdaR3lnZThSMEhmRzMrelI5bEh0cDJSOS85SjdReU9XM3cvME1M?=
 =?utf-8?B?R0JrK056YWZoZStJN3I2bWVzc0kwKzNFV3YyNnhWSVRORmhPT2lXWFJyTWQ5?=
 =?utf-8?B?OGtlNTNlSVl5eUs0VWUvTHJMN2JONzFUOC9vMW1ZUjZpQzVILy9CaTZLUFhT?=
 =?utf-8?B?TXhoU2I5Qis3bElsREJUNEJhMCtTVmt3Z1lkOXRuSWF4UE1Pb3JzOEVKRHMv?=
 =?utf-8?B?N3Z0K2RuRnMySUUwSXE0S3pDN1Z0V1EvdHVpYU5YNDNBc1BTRUhObmpRUk9I?=
 =?utf-8?Q?PabI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3432412e-1658-4ca3-f26a-08dba9362550
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 08:50:22.2081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JEVBUofKZZQKzFaMZpIWWs1lCsNJKr5Cplhs7PcUoRW9r20m+hFOu+kCD0ofBZgvjheFu5tlH9dmkoQmoIoI3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7762
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMjgsIDIwMjMgYXQgODo1N+KAr0FNIEFubGUgUGFuIDxhbmxlLnBhbkBueHAu
Y29tPiB3cm90ZToNCj4NCj4gV2hlbiBhbGxvY2F0aW5nIGZyb20gcGFnZXMsIHRoZSBzaXplIG9m
IHRoZSBzZyBzZWdtZW50IGlzIHVubGltaXRlZCBhbmQgdGhlDQo+IGRlZmF1bHQgaXMgVUlOVF9N
QVguIFRoaXMgd2lsbCBjYXVzZSB0aGUgRE1BIHN0cmVhbSBtYXBwaW5nIGZhaWxlZCBsYXRlcg0K
PiB3aXRoIGEgInN3aW90bGIgYnVmZmVyIGZ1bGwiIGVycm9yLiBUaGUgZGVmYXVsdCBtYXhpbXVt
IG1hcHBpbmcgc2l6ZSBpcyAxMjgNCj4gc2xvdHMgeCAySyA9IDI1NkssIGRldGVybWluZWQgYnkg
IklPX1RMQl9TRUdTSVpFIi4NCj4gVG8gZml4IHRoZSBpc3N1ZSwgbGltaXQgdGhlIHNnIHNlZ21l
bnQgc2l6ZSBhY2NvcmRpbmcgdG8NCj4gImRtYV9tYXhfbWFwcGluZ19zaXplIiB0byBtYXRjaCB0
aGUgbWFwcGluZyBsaW1pdC4NCg0KSSB3b25kZXIgaWYgb25seSBOWFAgbWV0IHRoZSAic3dpb3Rs
YiBidWZmZXIgZnVsbCIgaXNzdWUuIEluIHRoZW9yeSwNCndoZW4gZm9ybWF0IGlzIFlVWVYsIHRo
b3NlIHJlc29sdXRpb25zIG5vIGdyZWF0ZXIgdGhhbiAzMjB4MjQwICgxNTM2MDAgYnl0ZXMsDQp3
aGljaCBsZXNzIHRoYW4gdGhlIG1heCBtYXBwaW5nIHNpemUgMjU2SyApIGNhbid0IG1lZXQgdGhl
IGlzc3VlLg0KQnV0IHJlc29sdXRpb25zIG5vIGxlc3MgdGhhbiA2NDB4NDgwICgzMDcyMDAgYnl0
ZXMpLCBtYXkgaGF2ZSBjaGFuY2VzIHRvDQp0cmlnZ2VyIHRoZSBpc3N1ZS4NCg0KQlJzLA0KRmFu
Z0h1aQ0K
