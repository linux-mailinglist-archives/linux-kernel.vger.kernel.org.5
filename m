Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4BC79E8F2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240881AbjIMNQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240835AbjIMNQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:16:38 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2043.outbound.protection.outlook.com [40.107.249.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89C419BD;
        Wed, 13 Sep 2023 06:16:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XR2gVCaYFKV0OxbpgL3ge4fqSdxGp07stP8npHbqmhZFjLA77WLSH48icpqllCQIphwfZkefOFmy0RcQW+PfUG60wDsoaWOqQYkk44syCBNVcPKDFFavvvncmfAjEpVpAzoDIFeX5C4aWWPczVhp1eSCZhik2/DdVR6ULW1eIPsll6obaOgep4ejZlDEjp6+WkdwMbBLDRUTsxBsjUZ5jvgic8sBy1/gCCwaqEX52RbdlL2GdDQuSAD24Jv0Viowr53GHl5883BzotebwK3zKCorq7CW0m324+hLr/wbOOxQIl4NheGSaxBR5c5JiFVU0+8FE9SjLXwJrtYMSpEMjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLzLxnvJqlvhdRYLUKpY81VQyzZdpySw9rQ16B/UIPg=;
 b=QTJnn1/UQ6blJq4CyZXqD+qUDlDu/BkiwXqlV0avVNM6T7+Q9+A0FvC6VB6kazK2rFZj+uDwi4eNzhyDuc3yXRY/TPxcIcdPiORJIcJxOF28uqzlchjzkI4iBgxt1V46+2rYBHrFOnc7OB3ZlZ8bqTHepGOKLkanRDksyZY3xYua3aRXvh3oawAtGdkRxKzLR6UOnzS45B+HmxcjJXoqr4UHN1pmaP06rWtcaFe4ydG56s9EfhC57lX78wdMCQw9RlVROquI8w5ymK/j4eM1Hx11BJK56aC+R6z6CVWT5b75P4VEOEIkyFFiPptEUuqMjUSojZ5yv/gzRINZsFxzow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLzLxnvJqlvhdRYLUKpY81VQyzZdpySw9rQ16B/UIPg=;
 b=BKJDeK65zZE1svtDmO5UXm9dn8iWD1RNTJvtw1oeurP0VqLNYbBbw4H5ai5ZxmkVhvFq61h4RUOeDqcwGdydmo1eOME7C672zUVjWLNimmPYQ69l3fGruxXwoGOL88KxC3Uc2KFn1TslIU33KaFAdvzmGkcAdhAav94NbgoLLDM=
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8)
 by AM7PR04MB7031.eurprd04.prod.outlook.com (2603:10a6:20b:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 13:16:31 +0000
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d]) by DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d%7]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 13:16:31 +0000
From:   Hui Fang <hui.fang@nxp.com>
To:     Tomasz Figa <tfiga@chromium.org>
CC:     Anle Pan <anle.pan@nxp.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jindong Yue <jindong.yue@nxp.com>,
        Xuegang Liu <xuegang.liu@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
Subject: RE: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment
 size
Thread-Topic: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment
 size
Thread-Index: AQHZ2UI/RGKEIcG6sEyAOrT4GOix9LACiU/wgAAMzoCAB7BFoIABXXYAgAHcP6CAABZdgIAHn6dggAFXQACAAE0GQIAAA6qAgAAHETCAAARQgIABqGOwgAAJY4CAADsAgA==
Date:   Wed, 13 Sep 2023 13:16:31 +0000
Message-ID: <DB9PR04MB92847BD33B99D6494A1BCFB687F0A@DB9PR04MB9284.eurprd04.prod.outlook.com>
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
In-Reply-To: <CAAFQd5BQ+FsuKipxE-yh3P-NbPdc_U=FHp7PBkWY-xunxthKuA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9284:EE_|AM7PR04MB7031:EE_
x-ms-office365-filtering-correlation-id: a0fe057a-c799-4f49-207e-08dbb45ba56b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GZCE6nmHD9lX0W/LKRdYs+bd7+qzZSM/VrDOWdNFs8+Ymt+FR/Ts2ISgf0PapilE2WfE2E0WAntC+0yElZDkjQ06E9B8WlHVQZkPPF6styse4QxIWsXQet8ERc78F2u/yp9vL6wJIlWR8JcKRehzQTaLKujK/n0LCdIBFm73gZbkP51TB46royFlYNIvj+bBff2d4ciHsvFLJkVzOGprTx9O19kjd3WhblHqmowZIr337FO+SYmVf+8at5w+MwPACt6IRa80KpcZy/QQJFpUnJjVLg4KmhXyb++5TeMyTncdzr93g+3k6+V7Gb3V+DoF0gP8nIhS8euLWG0NH5W+5cXehdQQmZardNxtQQmlcb/2fgOVwsEmsbW14PPats3LXj3p7MQLkriJ2+zadWj+fQ4yBgIzbMkAgzaJ8vQvYk9pKpUdz21Q2nypiQ6JvLOjX3OyyMf8ZlDfi9aslx4qpW18OFzJpXXZxbSNCvdrpHsLHG52iAzHidjSrC1X0S8/3PdQ0Ydo8K2eOf3TidW5FMiDoN6te+Rflg5Ha01g4OCThbi/jQc0pw8P+pRmrxLvRt74Jnv2hyFFE3LNOsx+z1f95kxjMXLKp8MhPT0ozSgpbyT54oTXmzMXw8Keu93r
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199024)(1800799009)(186009)(38100700002)(38070700005)(122000001)(33656002)(558084003)(86362001)(55016003)(7696005)(6506007)(478600001)(53546011)(54906003)(52536014)(44832011)(64756008)(66446008)(66476007)(66946007)(76116006)(66556008)(2906002)(8676002)(8936002)(71200400001)(4326008)(9686003)(83380400001)(5660300002)(41300700001)(316002)(6916009)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2F0VFRQeGZiL2dhdVpxSlNwTGIzU2g2MGk0SmtDR2dIRy9vOTJoem02ZFEr?=
 =?utf-8?B?cWpIY2NKb3E1MW5iNVA4K3hzdFZ2VXcxYkNodFo3TTBoWnMyc1V6L1J0ZGdu?=
 =?utf-8?B?Z1pYVVJNcGVHU0F1UE8rRm9RTXF4VFgrekFncmhwbjBhWTdnTDJUdVhXVTYy?=
 =?utf-8?B?a1V1VzNnaFQxWXpaWVNqSEh6KysrRmNnenVXcE94c1dHSjFjZ1QwRnN4dzNa?=
 =?utf-8?B?enovbWFxSjBqUERWeDFpZlE3VnZxSDh1TnQ5THlxUUVSYWhxRFlGZDNlNHEy?=
 =?utf-8?B?RWJZTTdudzZQVWxqQUhkaHM1dElBdkZsRXBuWjgxTUE2bGZWakRmSm5RREpa?=
 =?utf-8?B?OVo5NmZZQjVqSGVITVNsc0ZwVGRsOTZIZG9xWXVOc0pYL1ZIdXNJRjJhZzVW?=
 =?utf-8?B?cUt1emtUS2RrMlpFVzNmS2k4U24ybTBKQ05zeG5HaVF1VldaVXB6REk2bEFF?=
 =?utf-8?B?MUdJVkFoRlcrL21OS1VaRWpSTWVWemRZek9EdU1yaFo3cmlGbys5dndaUWU4?=
 =?utf-8?B?ZEE3RmtPV2UyUG8yVThkSTFwT1BObXphVW05NUhNSG1NUWRiT1B5T3M0dEsv?=
 =?utf-8?B?UWJjNWQwSGRrVngvejg2VW4zNkN6VGRrWHo2ZTJSREVzVVN1MXZrTS9PWWU2?=
 =?utf-8?B?c0ZscEQybjBqelR4UkxOcjZmSFhFajFNOHRtcGNaaUdhVmptTDBOTnI1dFQ0?=
 =?utf-8?B?bHBwUFJRUCttanVsN09Ic1pKNVphQ3JzZmlhemc0THY1cVF2blFldkNyZ1Zy?=
 =?utf-8?B?ZWNsZm9kUEY3ZGdLTWxZa2VjRzN4dkRrTU5lZUwwQ3lOd1VyLzFqNTN3YjhX?=
 =?utf-8?B?Sk5IVzVFTEYxM05uV2VmN05GNUF4YksvUFBWRm5FeFZzRHRrZ2ZkbUM3SnJu?=
 =?utf-8?B?QzFpU1NEeUdWek5lcUNkc3B4MElEY2RVZUFZVHpCSzE0OW5xUUZsWGIrNVk4?=
 =?utf-8?B?dkZPdCt4VU9aQWVyQklxRzdTYitzUUxzdDVrWCtERWxxU2x0Ti9GUDdLUUF3?=
 =?utf-8?B?cnprLzZDRnBmb2IydnQvYWZrRkJSMWdzVFZhaE9sS2liK05kWWJaOWNwOHF1?=
 =?utf-8?B?bHV5ZVhWS2tKeDdkNHVBam5zc0tiNU1TYTUzNDByZzJpeW9SV1d3NERWZFhM?=
 =?utf-8?B?RXV6QWhkUi9yT1lrWUVNS0xWdUY1VTJXbUdYbFZqQXNOeW9TalhKblcyYU9M?=
 =?utf-8?B?bUNKQmFSTG9oL0lmTXRBWVRxN2dFY1A4OTBaU3h5bE1Ea28rSzk1UzFpVlpy?=
 =?utf-8?B?TGZyK25mV3JpN2pSMkR5NUp0UDROcHBlMUd3U2Q0Sy80ZXk2OW0rRlZmTFhI?=
 =?utf-8?B?OVRpbXJjSnZJTkRvVUd2cGk1dXI5YktITWMxTU5YdnZnSERFNnZEa2ZHbDR4?=
 =?utf-8?B?Q2ZqaHd5dEJGTTVaRWQ0ZmMzUC9HdDZJMjhFaE5mUzJBelJyNGxZQlUzakhE?=
 =?utf-8?B?Z0RtTVBJdWdrcEMzdEpLa05hUWU5a2huSDlRYjdWUEh6TG94NFk3LzJlNnJl?=
 =?utf-8?B?VHdyU3JiUUJsdXdqMnFvSEY4T2tSbEdWNEYzL2U2YVZJaDZiRWhRMUEvUyta?=
 =?utf-8?B?emg2TjhWSWR3dk9ldmpkakJNTGZ1S1VZSk4yMUJmUVlsVkNkNUhwc09zNTVk?=
 =?utf-8?B?SnlIcmpuTitLS0d1WGdnTkhNMWJ2LzUyRXp2OERRcEIxV3c0b3o1bklneC9y?=
 =?utf-8?B?Smp3SW1FM0ZvckQ3THNMN2Jaa3Y3NGN1RUpmWjFUSk1Td3FPOWljSWF1ZWdw?=
 =?utf-8?B?Z1U1L2I4VE1JQnRlNzRZYlZQUGk1R2hLRmZySHR1MVEyNXVsbmwvTGQwZWpD?=
 =?utf-8?B?ZFJJQkN1VTFWRmNBODVTMm9DY2FGbzAwbTZERlBvSGp1MVRBMkRta3Ewb1l4?=
 =?utf-8?B?UVpVRjgxVjUwcGFzNnpZck50U0xUbDkvS2QvSHV5VHRmYURUd1Zza1ExaENZ?=
 =?utf-8?B?YnBXMldYOHVMVEpva2hOU3pGbm1mc01tNm1MTVZSRU1HdVFvcldZdmRsUHNV?=
 =?utf-8?B?cDg0TXF4bkNHbmt4QnF0NlBoVm9LakV0UEFzSEpCOWRIQ1AwUXVieHA0M1Zh?=
 =?utf-8?B?OVpITzdKajFMK0o0RUpHaHpiRCtSMFJPSVZVQ1o2d0x5YmNuck5wdlVaUS9i?=
 =?utf-8?Q?Yqbw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0fe057a-c799-4f49-207e-08dbb45ba56b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 13:16:31.2817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +O0iS9gObd47pDU6FvH8wW2WvZJH0xgsCGUXPx5rjGYT1PF06D9JjNHRLVbJzKYTxIa0y5ovV6cGLU7Jz9byQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7031
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBTZXAgMTMsIDIwMjMgYXQgNjo0NOKAr1BNIFRvbWFzeiBGaWdhIDx0ZmlnYUBjaHJv
bWl1bS5vcmc+IHdyb3RlOg0KPiBHcmVhdCB0byBoZWFyISBDb3VsZCB5b3Ugc3VibWl0IGEgcGF0
Y2g/IFdvdWxkIGFwcHJlY2lhdGUgYWRkaW5nDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFRvbWFzeiBG
aWdhIDx0ZmlnYUBjaHJvbWl1bS5vcmc+DQo+IA0KPiBhYm92ZSB0aGUgU2lnbmVkLW9mZi1ieSBs
aW5lIGlmIHlvdSBkb24ndCBtaW5kLiBUaGFua3MuDQoNClN1cmUuIFdpbGwgdmVyaWZpZWQgb24g
b3RoZXIgZGlmZmVyZW50IGkubXggYm9hcmRzLCB0aGVuIHB1c2guDQoNCkJScywNCkZhbmcgSHVp
DQo=
