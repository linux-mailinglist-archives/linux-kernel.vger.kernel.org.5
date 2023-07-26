Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994F07628EA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjGZCzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGZCz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:55:28 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B20193;
        Tue, 25 Jul 2023 19:55:22 -0700 (PDT)
X-UUID: d9375bdc2b5f11eeb20a276fd37b9834-20230726
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=at1o8F8OPUaIxeoxn9edkjDGKS7CwMG6AhrkqVEFfQc=;
        b=fElZSzn2HsrT8qG+4JFC2GGZ3ZQd7AXIJiQv0cRXLNfwtQPYUZ8p6XMKIQptWLLzZ4a96WrrV+D1tXfmVo9Zc2SxfPaZdi3jz7ytoZpFP3AVOLpKJrDMHxkkdiYd0+boumZ1rcZKPAex+470LmzC6pLEW5YKmVKKmVwMrlAMgXw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:a15d7832-91c1-4ba4-9d54-df23247d5c0b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:e7562a7,CLOUDID:ecc4cab3-a467-4aa9-9e04-f584452e3794,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d9375bdc2b5f11eeb20a276fd37b9834-20230726
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1084775038; Wed, 26 Jul 2023 10:55:16 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 26 Jul 2023 10:55:14 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 26 Jul 2023 10:55:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxniW8cqhGipEDo6NGJSn4uvci4sT4iqsjunfD3G2WODGihWvPIGN79kJcenqiGRDzN7Ml7a9E7bXa+vvbpPfzc9BWsm/cWdCYWdG5k4IrdsrD7hyYEHyLbg8CQNGvX5djIfbw/O3lf+gp+5gPmqqFgt9B2w+CuPIXptrGRJ1CTjhYQ2RwYgIjw4ccpd1WAXF/6qP6RwfG28GleZmjmXzOmkfr/UKmlhQhFEzFEaxkuMzkbj60GNSQVj/7ykDtmIPsNNVdx834gN70LAzGXlYLVyUSqHFOyGjgBuUPF6LIYqbHhGI5QVGds7bFdbHIskRNPNtESvZbJMZroYwjn2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=at1o8F8OPUaIxeoxn9edkjDGKS7CwMG6AhrkqVEFfQc=;
 b=LkK3I3E3I7+QqS8tAv47iYlHhxta793kJGkxSseBX+Jm4zZ7OyOMor74iyup3d+qG3k22D0TDVm7GUJKnll2Z0briZToXbdRE50HdHXvfMeR/wIdAFYklTZ2gxYseEsyIV8w/1xnZRH8kknTQ57uJbngzhoGE4FcjLtgw8HQ/+1EBZhqOSNcyK5HT5SSGoJwbEMFmsMecO8CAsWImL1lF30dhXODj/fdmVI5UNiH0f8wWmQ7C3a07RUglPHZ35vrmA4UqojCKCNSucKDf5AZS7jube+/vjFyHgoPWCGfAMPjosO32LGbH9QCmA6r6O0G4UPoUF1ZncpmFuO8rP8GCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=at1o8F8OPUaIxeoxn9edkjDGKS7CwMG6AhrkqVEFfQc=;
 b=l8KgBORxTnD3vJmd0+bu/kZkPAFP9OlS+bM5SOJOSYx0inNBrVd1egOR8GkvH1U4EIgOSSjCeD5ADnEVIrwbQoqpp7koccGWMbz7W0x2/l4UkJSYq9gW3Vg5TSBoWSBNPJNCQiJntcQZBQboVGLYcvfn/Ej2epy/Ghyl9ljw/qU=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by TYZPR03MB7532.apcprd03.prod.outlook.com (2603:1096:400:427::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 02:55:12 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::8b42:7372:40b9:bd]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::8b42:7372:40b9:bd%4]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 02:55:11 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v15 07/13] remoteproc: mediatek: Probe SCP cluster on
 multi-core SCP
Thread-Topic: [PATCH v15 07/13] remoteproc: mediatek: Probe SCP cluster on
 multi-core SCP
Thread-Index: AQHZu3z3cgutzDQ/IUOYfUPlu48f3K/K7iIAgAB0EgA=
Date:   Wed, 26 Jul 2023 02:55:11 +0000
Message-ID: <206d7ce79c23f9ccbfcf228d42d7ee26472f4f44.camel@mediatek.com>
References: <20230721024132.6548-1-tinghan.shen@mediatek.com>
         <20230721024132.6548-8-tinghan.shen@mediatek.com> <ZMApsFKHbj2WPLE8@p14s>
In-Reply-To: <ZMApsFKHbj2WPLE8@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|TYZPR03MB7532:EE_
x-ms-office365-filtering-correlation-id: ca9b3ab6-fb08-445b-696e-08db8d83badd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uhm0vmJ0NA7PuK9TdB7IoBAkCG4HD8TOjyH60T0mv6aVQN/rJRrIJiK8H+e+IsSeEncddoKSnipNM1XlDOtD0RXadINIOnoy02tC5LECoT0MGKwho18hSWuW3+TQN0L8q+iGEe1qNSGPZemOQrYSN3CtV07mleZUnOXNvD4xORDEjkTo3ZDdDz/jzyFltZajcuAAdImuEixqJzykhL3MrIjFdjhBijMLffbNmolObiAoet6RTX7FFwk0xjp5O4nBSmEFletFVDZ0Lc6baB8tiFR8YSuafAIka7brvR62Qq+iNF+Wh6NWx1ZzZbQqbHYduWk/WVlO90pxxkE3OMv7YfjQxioVvY8svCwSDXJhULOpUBCYahPGI3wel+jJz44j8EudeQ++sZof0aMi6WFDktDtT63siO0bH0R51ttndLCTw0U2jg6k1g17aAgFAdo2tUn9rzpvw/Ssbs1cXo8HKmGEC3n0yDNRtx92oFsNyFY8Jk0BdeA6p/Vg8IeHn5onAw/RDsfYsdyOneKTmSaOdiDyv8WucX77XjMoWq7DvTTePc6l2gsvWqJBI3+r1MljPHcXygvUkMEIf1I8CscnHiVtvWfU41W8dbd0I9fQb8Xdv4wX59xyRPCPP1gWAN+3kM+cJYFu41gnFno1SlVrVF/mcqGhrXnIMWdF2+ZOH80=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(186003)(38100700002)(2616005)(26005)(6506007)(66446008)(66556008)(6916009)(4326008)(76116006)(66946007)(64756008)(66476007)(54906003)(83380400001)(316002)(91956017)(2906002)(5660300002)(38070700005)(7416002)(86362001)(8936002)(8676002)(41300700001)(85182001)(36756003)(71200400001)(6486002)(478600001)(122000001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVRzcnpBV1RJNm5UaS91RnloMkRvN3RTbk1IZ2V5K29yTmVxcmlySnZ3QkRF?=
 =?utf-8?B?d1kxbTg0dS9kWkM2bEovY0p6YStBaXNwL2RZY3BJNUorbUdHRmJGZWxQRlJG?=
 =?utf-8?B?bGpOdFlMS1FsbG1FbVNEd2cxamRMUjBzeWRaOTZoRkZmamdVYVU4MWdEZGJp?=
 =?utf-8?B?NGNpbDNJUUc5VlRncG92Mzd4USt6QUJwRXhBMjR4TTdseEpTWjkxUlZHV08r?=
 =?utf-8?B?a1RDU0tJbVlWR3NKMktqUEtneUUxcnpQeUREUFRkSm1oNXhWUk9jZUdSWTBn?=
 =?utf-8?B?UGVKb0NWSlE3T1doTXRJNDZJLzBXRlQyQ2lZYkNveFlYdnBJWWljUmZ0Z2ZR?=
 =?utf-8?B?elRRRW9QaW5INVMzZ0dxc0tkRDlBUE5OeHlad0F6SzJHcGQ3dUNBOFk2cGkx?=
 =?utf-8?B?NE0yZVpVWUYzdVV1K3Y4enZHOE1zamdQbWlGTVo4dGh2dmozQk5rSU1iWjJH?=
 =?utf-8?B?M0l4L3VHMWxOS0N3QmZyUEFUUWZmdUhha1dkdHFCcnFsV003U1JYelgvdzdV?=
 =?utf-8?B?QVBHa2tWd2N1Nitxd1BhN2hzbHhha3YxczYyY2haZ0dRZlgvVTlTVFdtZ09q?=
 =?utf-8?B?Y2cvcWE2bGt2MzA1NWwwZlJoUHFiKzB3TWQ0T0dQeXYvNmdDYW8zMS8yQmJF?=
 =?utf-8?B?alBISnJER0lTOVYxSzB2MUorYlZOVVFZVkVHQmlrQlZNL2NmK0lkRGJjSHRD?=
 =?utf-8?B?bEloc2V3a2lGRzhwMjdjY3VpMFhPSEhEY296cHgvdXZDSDAzTUxMSURaemVl?=
 =?utf-8?B?Qzc1T1gxbStxVGhPdjhTQlRNb1RtMHZGbk0vbi9SdU9BM2luaVVkZ3gxM1E1?=
 =?utf-8?B?ZjhFbXJkOGZZaWlac2I4Q0ZNb3poSSswcS9HQ1FoeXlLMTA4NHpmQzhvUEVC?=
 =?utf-8?B?VmR6NjRDM2Z3UlRlOGNmUGtPVFV6dzJzelJRU0ZXM3crejM2ZHllNzJvdjNJ?=
 =?utf-8?B?dkVPckZicjk0d0x2aHFERUJ1SFh5MWc1a1ptN2JGWGZCaGdjK0tHZFpobEQz?=
 =?utf-8?B?STMwZjF6YVE5Z2VVUUpjbGpHaXl5K1k0eG1JYWtsc2VJdUF2ei9oN1hBNFJR?=
 =?utf-8?B?NThDSWJlN2RBMFY4RUs2REw1OWF3VFNUUlpWbXUzTFQwQkd2R1lUSUQwbzla?=
 =?utf-8?B?Wjgrc3NSMTlaVGxkM3kxNDBOSFNISFpqTUtMd2VydkNJR0JxbUp5aXY2WFFn?=
 =?utf-8?B?K1hENm9KcVF1UjBEaC90WHFpRklmZkpGOThiRGRLbmgzeW1uQlVVRWdrckpi?=
 =?utf-8?B?MzRSdEZaTE96bnlkVkpCM2czOThYazZXSDJ4WlpWZTJZSDRSUGJvcENERGdR?=
 =?utf-8?B?Vk1ZVUFYWm5hZThsclQ0b3cxQSt4QVI0SWYydUJwZzVUQS93cjI2YkR3R0dy?=
 =?utf-8?B?cFN6TnZMZHRYKzBtQTlZVDVSaTNxZ01GV1A0YWZ1amh1M2NvL3JBOFNEMGZ1?=
 =?utf-8?B?eFI0cTZpVEwxdTZGTHY5RStKQU1HaGp1VWNOaElMYmlWdGk5RWwxV2o4S3N6?=
 =?utf-8?B?UGl0OC9UbE5Ic0hteGFmdXRIdUFka0ZyTUt0aGZEMVVwMFlvOGVpWmhBWW5i?=
 =?utf-8?B?MnMzWXVZR0FmYTlGZm9UYlZLVkRLRCtzN041NXF0ZzBUMVlJVVJqL0xKcDJr?=
 =?utf-8?B?dTJsTkRQK25uZjdTNm91aUZLVFR3ellvcG03bnIrYUdvUVlXdVhvcHQ2VXkr?=
 =?utf-8?B?UktJN0g1U1NTbjBIY2pIbzFSQjN5d01nT1Z3dncxK1lKT2lzNTByMlg4cCsx?=
 =?utf-8?B?UzloYjRmSUU3eTlRcEw3VTMwTWk2MlNrQWozWFFaTnhNWnFndldITzQ0VDNy?=
 =?utf-8?B?SHBvSENTSWZreGEveHBTK1pXbEdEcjNFT0dzZkxKOTZHVWZ4ajFNanpHTXZz?=
 =?utf-8?B?YjZ1WlNCTGVwL1pYdzRqN0hZQ1VoN1U0YUdQZFlsSCtZZHJ2R29XT3FkVDE5?=
 =?utf-8?B?ejV0NXg3MWJ6MC9RLzVhTm1jVzZXMTRKcFlVa2ZjWjVJTWxQSUo3cWVzVHJZ?=
 =?utf-8?B?MHY0bW1FWVk5TFVLZktvNU12NWdLd0VISWlQdkN3YjF1WDhPK09sdFNCc0Ft?=
 =?utf-8?B?YVJvQk5ldlNzUmpOVFRpVmhCaVFKQmgxbDllb2JOc0xmc0p0UmxRVFkwN0M5?=
 =?utf-8?B?N0NudlFyUC91YlBPQkllYWhOWS9EU24rRVorUnBDYzgwK3lvMzRUbFNkb3Uy?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44BC5121DB4D2D4F824A1030E495D982@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9b3ab6-fb08-445b-696e-08db8d83badd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 02:55:11.8141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rlfTgtIxZyNkUrwi/yKh3Sn88wd6YKaOmPdPtjr5t8v7F4oxE37UL0hY5dOWv5Rfcf+t1OezNbFd0HH649oRgP/XqCKtJPSwCIrzO0u2lYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7532
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0aGlldSwNCg0KT24gVHVlLCAyMDIzLTA3LTI1IGF0IDEzOjU5IC0wNjAwLCBNYXRoaWV1
IFBvaXJpZXIgd3JvdGU6DQo+IE9uIEZyaSwgSnVsIDIxLCAyMDIzIGF0IDEwOjQxOjI2QU0gKzA4
MDAsIFRpbmdoYW4gU2hlbiB3cm90ZToNCj4gPiBUaGUgZGlmZmVyZW5jZSBvZiBzaW5nbGUtY29y
ZSBTQ1AgYW5kIG11bHRpLWNvcmUgU0NQIGRldmljZSB0cmVlIGlzDQo+ID4gdGhlIHByZXNlbmNl
IG9mIGNoaWxkIGRldmljZSBub2RlcyBkZXNjcmliZWQgU0NQIGNvcmVzLiBUaGUgU0NQDQo+ID4g
ZHJpdmVyIHBvcHVsYXRlcyB0aGUgcGxhdGZvcm0gZGV2aWNlIGFuZCBjaGVja3MgdGhlIGNoaWxk
IG5vZGVzDQo+ID4gdG8gaWRlbnRpZnkgd2hldGhlciBpdCdzIGEgc2luZ2xlLWNvcmUgU0NQIG9y
IGEgbXVsdGktY29yZSBTQ1AuDQo+ID4gDQo+ID4gQWRkIHRoZSByZW1vdGVwcm9jIGluc3RhbmNl
cyBvZiBtdWx0aS1jb3JlIFNDUCB0byB0aGUgU0NQIGNsdXN0ZXIgbGlzdC4NCj4gPiBXaGVuIHRo
ZSBTQ1AgZHJpdmVyIGlzIHJlbW92ZWQsIGl0IGNsZWFudXAgcmVzb3VyY2VzIGJ5IHdhbGtpbmcN
Cj4gPiB0aHJvdWdoIHRoZSBjbHVzdGVyIGxpc3QuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
VGluZ2hhbiBTaGVuIDx0aW5naGFuLnNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+IFJldmlld2VkLWJ5
OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bj
b2xsYWJvcmEuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3JlbW90ZXByb2MvbXRrX3NjcC5j
IHwgMTE4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAxMTMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9yZW1vdGVwcm9jL210a19zY3AuYyBiL2RyaXZlcnMvcmVtb3RlcHJv
Yy9tdGtfc2NwLmMNCj4gPiBpbmRleCBkNjdkY2FiZGFiOWUuLjM0MDk1YTQ2MWUxNSAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL3JlbW90ZXByb2MvbXRrX3NjcC5jDQo+ID4gKysrIGIvZHJpdmVy
cy9yZW1vdGVwcm9jL210a19zY3AuYw0KPiA+IEBAIC04NTUsNyArODU1LDggQEAgc3RhdGljIHZv
aWQgc2NwX3JlbW92ZV9ycG1zZ19zdWJkZXYoc3RydWN0IG10a19zY3AgKnNjcCkNCj4gPiAgfQ0K
PiA+ICANCj4gPiAgc3RhdGljIHN0cnVjdCBtdGtfc2NwICpzY3BfcnByb2NfaW5pdChzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiA+IC0JCQkJICAgICAgc3RydWN0IG10a19zY3Bfb2Zf
Y2x1c3RlciAqc2NwX2NsdXN0ZXIpDQo+ID4gKwkJCQkgICAgICBzdHJ1Y3QgbXRrX3NjcF9vZl9j
bHVzdGVyICpzY3BfY2x1c3RlciwNCj4gPiArCQkJCSAgICAgIGNvbnN0IHN0cnVjdCBtdGtfc2Nw
X29mX2RhdGEgKm9mX2RhdGEpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZw
ZGV2LT5kZXY7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2RlOw0K
PiA+IEBAIC04NzgsNyArODc5LDcgQEAgc3RhdGljIHN0cnVjdCBtdGtfc2NwICpzY3BfcnByb2Nf
aW5pdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiA+ICAJc2NwID0gcnByb2MtPnBy
aXY7DQo+ID4gIAlzY3AtPnJwcm9jID0gcnByb2M7DQo+ID4gIAlzY3AtPmRldiA9IGRldjsNCj4g
PiAtCXNjcC0+ZGF0YSA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KPiA+ICsJc2Nw
LT5kYXRhID0gb2ZfZGF0YTsNCj4gPiAgCXNjcC0+Y2x1c3RlciA9IHNjcF9jbHVzdGVyOw0KPiA+
ICAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgc2NwKTsNCj4gPiAgDQo+ID4gQEAgLTk1MSwx
NSArOTUyLDE1IEBAIHN0YXRpYyB2b2lkIHNjcF9mcmVlKHN0cnVjdCBtdGtfc2NwICpzY3ApDQo+
ID4gIAltdXRleF9kZXN0cm95KCZzY3AtPnNlbmRfbG9jayk7DQo+ID4gIH0NCj4gPiAgDQo+ID4g
LXN0YXRpYyBpbnQgc2NwX2NsdXN0ZXJfaW5pdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
LA0KPiA+IC0JCQkgICAgc3RydWN0IG10a19zY3Bfb2ZfY2x1c3RlciAqc2NwX2NsdXN0ZXIpDQo+
ID4gK3N0YXRpYyBpbnQgc2NwX2FkZF9zaW5nbGVfY29yZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2LA0KPiA+ICsJCQkgICAgICAgc3RydWN0IG10a19zY3Bfb2ZfY2x1c3RlciAqc2NwX2Ns
dXN0ZXIpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+
ID4gIAlzdHJ1Y3QgbGlzdF9oZWFkICpzY3BfbGlzdCA9ICZzY3BfY2x1c3Rlci0+bXRrX3NjcF9s
aXN0Ow0KPiA+ICAJc3RydWN0IG10a19zY3AgKnNjcDsNCj4gPiAgCWludCByZXQ7DQo+ID4gIA0K
PiA+IC0Jc2NwID0gc2NwX3Jwcm9jX2luaXQocGRldiwgc2NwX2NsdXN0ZXIpOw0KPiA+ICsJc2Nw
ID0gc2NwX3Jwcm9jX2luaXQocGRldiwgc2NwX2NsdXN0ZXIsIG9mX2RldmljZV9nZXRfbWF0Y2hf
ZGF0YShkZXYpKTsNCj4gPiAgCWlmIChJU19FUlIoc2NwKSkNCj4gPiAgCQlyZXR1cm4gUFRSX0VS
UihzY3ApOw0KPiA+ICANCj4gPiBAQCAtOTc1LDYgKzk3NiwxMDIgQEAgc3RhdGljIGludCBzY3Bf
Y2x1c3Rlcl9pbml0KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQo+ID4gIAlyZXR1cm4g
MDsNCj4gPiAgfQ0KPiA+ICANCj4gPiArc3RhdGljIGludCBzY3BfYWRkX211bHRpX2NvcmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4gPiArCQkJICAgICAgc3RydWN0IG10a19zY3Bf
b2ZfY2x1c3RlciAqc2NwX2NsdXN0ZXIpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBkZXZpY2UgKmRl
diA9ICZwZGV2LT5kZXY7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2X29mX25v
ZGUoZGV2KTsNCj4gPiArCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmNwZGV2Ow0KPiA+ICsJc3Ry
dWN0IGRldmljZV9ub2RlICpjaGlsZDsNCj4gPiArCXN0cnVjdCBsaXN0X2hlYWQgKnNjcF9saXN0
ID0gJnNjcF9jbHVzdGVyLT5tdGtfc2NwX2xpc3Q7DQo+ID4gKwljb25zdCBzdHJ1Y3QgbXRrX3Nj
cF9vZl9kYXRhICoqY2x1c3Rlcl9vZl9kYXRhOw0KPiA+ICsJc3RydWN0IG10a19zY3AgKnNjcCwg
KnRlbXA7DQo+ID4gKwlpbnQgY29yZV9pZCA9IDA7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4g
PiArCWNsdXN0ZXJfb2ZfZGF0YSA9IChjb25zdCBzdHJ1Y3QgbXRrX3NjcF9vZl9kYXRhICoqKW9m
X2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KPiA+ICsNCj4gPiArCWZvcl9lYWNoX2F2YWls
YWJsZV9jaGlsZF9vZl9ub2RlKG5wLCBjaGlsZCkgew0KPiA+ICsJCWlmICghY2x1c3Rlcl9vZl9k
YXRhW2NvcmVfaWRdKSB7DQo+ID4gKwkJCXJldCA9IC1FSU5WQUw7DQo+ID4gKwkJCWRldl9lcnIo
ZGV2LCAiTm90IHN1cHBvcnQgY29yZSAlZFxuIiwgY29yZV9pZCk7DQo+ID4gKwkJCW9mX25vZGVf
cHV0KGNoaWxkKTsNCj4gPiArCQkJZ290byBpbml0X2ZhaWw7DQo+ID4gKwkJfQ0KPiA+ICsNCj4g
PiArCQljcGRldiA9IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUoY2hpbGQpOw0KPiA+ICsJCWlmICgh
Y3BkZXYpIHsNCj4gPiArCQkJcmV0ID0gLUVOT0RFVjsNCj4gPiArCQkJZGV2X2VycihkZXYsICJO
b3QgZm91bmQgcGxhdGZvcm0gZGV2aWNlIGZvciBjb3JlICVkXG4iLCBjb3JlX2lkKTsNCj4gPiAr
CQkJb2Zfbm9kZV9wdXQoY2hpbGQpOw0KPiA+ICsJCQlnb3RvIGluaXRfZmFpbDsNCj4gPiArCQl9
DQo+ID4gKw0KPiA+ICsJCXNjcCA9IHNjcF9ycHJvY19pbml0KGNwZGV2LCBzY3BfY2x1c3Rlciwg
Y2x1c3Rlcl9vZl9kYXRhW2NvcmVfaWRdKTsNCj4gPiArCQlwdXRfZGV2aWNlKCZjcGRldi0+ZGV2
KTsNCj4gPiArCQlpZiAoSVNfRVJSKHNjcCkpIHsNCj4gPiArCQkJcmV0ID0gUFRSX0VSUihzY3Ap
Ow0KPiA+ICsJCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBpbml0aWFsaXplIGNvcmUgJWQgcnBy
b2NcbiIsIGNvcmVfaWQpOw0KPiA+ICsJCQlvZl9ub2RlX3B1dChjaGlsZCk7DQo+ID4gKwkJCWdv
dG8gaW5pdF9mYWlsOw0KPiA+ICsJCX0NCj4gPiArDQo+ID4gKwkJcmV0ID0gcnByb2NfYWRkKHNj
cC0+cnByb2MpOw0KPiA+ICsJCWlmIChyZXQpIHsNCj4gPiArCQkJZGV2X2VycihkZXYsICJGYWls
ZWQgdG8gYWRkIHJwcm9jIG9mIGNvcmUgJWRcbiIsIGNvcmVfaWQpOw0KPiA+ICsJCQlvZl9ub2Rl
X3B1dChjaGlsZCk7DQo+ID4gKwkJCXNjcF9mcmVlKHNjcCk7DQo+ID4gKwkJCWdvdG8gaW5pdF9m
YWlsOw0KPiA+ICsJCX0NCj4gPiArDQo+ID4gKwkJbGlzdF9hZGRfdGFpbCgmc2NwLT5lbGVtLCBz
Y3BfbGlzdCk7DQo+ID4gKwkJY29yZV9pZCsrOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXBsYXRm
b3JtX3NldF9kcnZkYXRhKHBkZXYsIGxpc3RfZmlyc3RfZW50cnkoc2NwX2xpc3QsIHN0cnVjdCBt
dGtfc2NwLCBlbGVtKSk7DQo+IA0KPiAoc2lnaCkNCj4gDQo+IFdoeSBpcyBsaXN0X2ZpcnN0X2Vu
dHJ5KCkgdXNlZCBoZXJlIHJhdGhlciB0aGFuIGp1c3QgQHNjcD8gIFdoYXQgaXMgdGhlIHB1cnBv
c2UNCj4gb2YgdXNpbmcgdGhlIGxpc3QgQVBJPw0KDQpJIHRob3VnaHQgaXQgd291bGQgYmUgbW9y
ZSBjb25zaXN0ZW50IHRvIHVzZSB0aGUgaGVhZCBub2RlIHdoZW4gcmVtb3ZpbmcgdGhlIHNjcCBk
cnZpZXIuDQpJJ2xsIGRvIHdoYXQgeW91IHN1Z2dlc3QuDQoNCg0KQmVzdCByZWdhcmRzLA0KVGlu
Z0hhbg0KDQo+IA0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICsNCj4gPiAraW5pdF9mYWls
Og0KPiA+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlX3JldmVyc2Uoc2NwLCB0ZW1wLCBzY3Bf
bGlzdCwgZWxlbSkgew0KPiA+ICsJCWxpc3RfZGVsKCZzY3AtPmVsZW0pOw0KPiA+ICsJCXJwcm9j
X2RlbChzY3AtPnJwcm9jKTsNCj4gPiArCQlzY3BfZnJlZShzY3ApOw0KPiA+ICsJfQ0KPiA+ICsN
Cj4gPiArCXJldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgc2NwX2lz
X3NpbmdsZV9jb3JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gK3sNCj4gPiAr
CXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlX25v
ZGUgKm5wID0gZGV2X29mX25vZGUoZGV2KTsNCj4gPiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqY2hp
bGQ7DQo+ID4gKw0KPiA+ICsJY2hpbGQgPSBvZl9nZXRfbmV4dF9hdmFpbGFibGVfY2hpbGQobnAs
IE5VTEwpOw0KPiA+ICsJaWYgKCFjaGlsZCkNCj4gPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShk
ZXYsIC1FTk9ERVYsICJObyBjaGlsZCBub2RlXG4iKTsNCj4gPiArDQo+ID4gKwlvZl9ub2RlX3B1
dChjaGlsZCk7DQo+ID4gKwlyZXR1cm4gb2Zfbm9kZV9uYW1lX2VxKGNoaWxkLCAiY3Jvcy1lYy1y
cG1zZyIpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHNjcF9jbHVzdGVyX2luaXQo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwgc3RydWN0IG10a19zY3Bfb2ZfY2x1c3RlciAq
c2NwX2NsdXN0ZXIpDQo+ID4gK3sNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0ID0g
c2NwX2lzX3NpbmdsZV9jb3JlKHBkZXYpOw0KPiA+ICsJaWYgKHJldCA8IDApDQo+ID4gKwkJcmV0
dXJuIHJldDsNCj4gPiArDQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldCA9IHNjcF9hZGRfc2lu
Z2xlX2NvcmUocGRldiwgc2NwX2NsdXN0ZXIpOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCXJldCA9IHNj
cF9hZGRfbXVsdGlfY29yZShwZGV2LCBzY3BfY2x1c3Rlcik7DQo+ID4gKw0KPiA+ICsJcmV0dXJu
IHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBzY3BfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgew0KPiA+ICAJc3RydWN0IGRldmljZSAqZGV2ID0g
JnBkZXYtPmRldjsNCj4gPiBAQCAtMTAwNyw2ICsxMTA0LDEwIEBAIHN0YXRpYyBpbnQgc2NwX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIA0KPiA+ICAJSU5JVF9MSVNU
X0hFQUQoJnNjcF9jbHVzdGVyLT5tdGtfc2NwX2xpc3QpOw0KPiA+ICANCj4gPiArCXJldCA9IGRl
dm1fb2ZfcGxhdGZvcm1fcG9wdWxhdGUoZGV2KTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0
dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJGYWlsZWQgdG8gcG9wdWxhdGUgcGxhdGZvcm0g
ZGV2aWNlc1xuIik7DQo+ID4gKw0KPiA+ICAJcmV0ID0gc2NwX2NsdXN0ZXJfaW5pdChwZGV2LCBz
Y3BfY2x1c3Rlcik7DQo+ID4gIAlpZiAocmV0KQ0KPiA+ICAJCXJldHVybiByZXQ7DQo+ID4gQEAg
LTExMDEsMTIgKzEyMDIsMTkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfc2NwX29mX2RhdGEg
bXQ4MTk1X29mX2RhdGFfYzEgPSB7DQo+ID4gIAkuaG9zdF90b19zY3BfaW50X2JpdCA9IE1UODE5
NV9DT1JFMV9IT1NUX0lQQ19JTlRfQklULA0KPiA+ICB9Ow0KPiA+ICANCj4gPiArc3RhdGljIGNv
bnN0IHN0cnVjdCBtdGtfc2NwX29mX2RhdGEgKm10ODE5NV9vZl9kYXRhX2NvcmVzW10gPSB7DQo+
ID4gKwkmbXQ4MTk1X29mX2RhdGEsDQo+ID4gKwkmbXQ4MTk1X29mX2RhdGFfYzEsDQo+ID4gKwlO
VUxMDQo+ID4gK307DQo+ID4gKw0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9p
ZCBtdGtfc2NwX29mX21hdGNoW10gPSB7DQo+ID4gIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVr
LG10ODE4My1zY3AiLCAuZGF0YSA9ICZtdDgxODNfb2ZfZGF0YSB9LA0KPiA+ICAJeyAuY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDgxODYtc2NwIiwgLmRhdGEgPSAmbXQ4MTg2X29mX2RhdGEgfSwN
Cj4gPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LXNjcCIsIC5kYXRhID0gJm10
ODE4OF9vZl9kYXRhIH0sDQo+ID4gIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1z
Y3AiLCAuZGF0YSA9ICZtdDgxOTJfb2ZfZGF0YSB9LA0KPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDgxOTUtc2NwIiwgLmRhdGEgPSAmbXQ4MTk1X29mX2RhdGEgfSwNCj4gPiArCXsg
LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LXNjcC1kdWFsIiwgLmRhdGEgPSAmbXQ4MTk1
X29mX2RhdGFfY29yZXMgfSwNCj4gPiAgCXt9LA0KPiA+ICB9Ow0KPiA+ICBNT0RVTEVfREVWSUNF
X1RBQkxFKG9mLCBtdGtfc2NwX29mX21hdGNoKTsNCj4gPiAtLSANCj4gPiAyLjE4LjANCg0KDQo=
