Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825A4776CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 01:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjHIX4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 19:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjHIX4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 19:56:23 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3193C10C7;
        Wed,  9 Aug 2023 16:56:21 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379NW4jF024582;
        Wed, 9 Aug 2023 23:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : content-type : content-id :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=Z2fGvcE+98wAqW4o3dJhRIOPuPt7UGB6T7C8rWq2Y0o=;
 b=mc6x7E3iTG8or0s0cQjlCuhRPzHoBTs+ET1B6K3vRgmXssaCaRt9CANSoQeSZ9uBCoRW
 LJ+9qnhRcuwrhNNf9cXKzqm82JreuiwFUPUeu7pPelRSn25qvjfu72c3yJA5768pDUQQ
 SQ9KD85HCe16iM/pQM2uGKLWPn4W1QPx9jMVvxMPgNXsAGTzaMcgV3NF4Xp44EEMPN93
 RVZHpy+j5W6Cx7YZd9I1Nq5wnqxba6fKuzBCdJe9urF8NQBUtnCJSKTfGtezjy/yEigc
 iEiFawicSpFoQKZeWU73oveRvNX3L/QR4sM5nw+NVWrjRePOnnyq9zu9FiQWhaROrZq6 oA== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3scf90tfru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 23:55:53 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id C62FFD2EA;
        Wed,  9 Aug 2023 23:55:51 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 9 Aug 2023 11:55:51 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 9 Aug 2023 11:55:51 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 9 Aug 2023 23:55:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPbx4ECaNkNK+IwVuwPKn3oAxB4t3PtG7Jo24uH3FWE7fzoofcIuFh87wuq+YMjVStIkZhpBcc3KRjoMUjRxNjyyZiUBZnxhRempUjBLS1LG3QoTE0HF7X8U/PSPevsEViLGeztNW0zCQ+KihyvRgivB6fQJL/nM7EiwaYktsDbDaVwEtKYWaWMG/univdRbs72juKFczTb69f9D71lOOBvHmrje5r/MTKCSuWDrbTmdFJUglpXb2PGFs/+HDcpiH40CMgUALqUbc6WKjg8Ksn8YkSOOKShk6hRoF+QH5AvW2C91Bp7kCbG8NazFNny6rphSOxFqkyLpfcB8TuMVlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2fGvcE+98wAqW4o3dJhRIOPuPt7UGB6T7C8rWq2Y0o=;
 b=PWHDxJcpJlsNgvYFEUQ/FbhNZB4WLWQWyFvsblhb6Z3G+VO6gpSwVmxkVMJ8AZM/y702zJhOZcftlWw9UUdQ393PHf37dfh5NFE5Gt0ugHKxy4Sbqr1Ws0Dtz9+wrR9Q0pEoCm6ERd0beilnMLaEh4jormgX5Z3dWr0I92WQiLvNh6Dp8gELrg+S4gj1KP8r7oSCIneSkx0p7Bh0OMG4hC08wai+4PxTK88bl84mqQQx6S4mTwTovKptMUJ/2mvnPI43bNjgVgyQMD5Q35tnF5Ds7QZKrQ9LYAQZwG8JyS9eDC9e4ztN6UMLgXmXvwUMAZ7iBlnugBi2hkDmwS2Gew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 PH0PR84MB1525.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:170::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Wed, 9 Aug
 2023 23:55:49 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20b7:769e:3974:f17e%4]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 23:55:48 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/5] net: hpe: Add GXP UMAC Driver
Thread-Topic: [PATCH v2 4/5] net: hpe: Add GXP UMAC Driver
Thread-Index: AQHZxX8FQEkQXvMN30SqHDZcFt7as6/XpOCAgAEA6ICAAqAfAIAFTDCAgABYDICAAYm2IA==
Date:   Wed, 9 Aug 2023 23:55:48 +0000
Message-ID: <DM4PR84MB19277DFEB543CF29AB3D58608812A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
 <20230802201824.3683-5-nick.hawkins@hpe.com>
 <fb656c31-ecc3-408a-a719-cba65a6aa984@lunn.ch>
 <933D6861-A193-4145-9533-A7EE8E6DD32F@hpe.com>
 <61c541c9-be30-4a43-aa85-53816d5848f9@lunn.ch>
 <DB60B268-85DA-43A2-A20F-52D684473348@hpe.com>
 <06d1bc6a-0584-4d62-a2f4-61a42f236b3c@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.75.23071400
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|PH0PR84MB1525:EE_
x-ms-office365-filtering-correlation-id: bf505f99-27ac-4f47-5e80-08db9934278e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L3fVA0TZ67dw0Kb0T0Gq77o5SfTuq3x95p0beoSCtK3o8dVeaIUMaSKV4HoiYFHNsAKTSqTmaS5RTwBSiq+Qxwh0osveaJhZhGrREKwulbLcalJ0v96zWcb2FD4a6PuczFZPhN721XKmcp9NfNugK55foWBxfnLV8zvIkm0fFcXLQ2wLo0tq0Ew9SQdt97ZplmG7O9zMJngR+yuJoY4KNSpHTXSOA54TIrS5A5Y1kEGTEDKEXSQnCQI3VZfRD3qZCAvfr4LwgTtnugwVnzwRiZmEpGxlJHWvc7itxQWmaOYbn+TBwp57Z54FyHJivGycylhWy0WBsoB+d2WjKT1cS59nOBbOcFNSaENxMABDxCXYVfMWhUbdwK5qAExhGRqE+FzzYlbHnhDG+GSjPmt42aK2nobKsVg3FsSYP4QO4wS5JhV0HhjsNkbPruJugb4WkIn2Bg+fHuSsXyf1PX6MkBLTfC4xkmGanVK0eFd9sBR63v8XLEQn0fX/9F8zwQQBUPb/gMCtbf5B+ioLZ3S/eC7U8fjW/8S7Jpw6TiJaSh1TZadMSk9cMwiiCnaY+XQzE545Jk+Z2l1k4XxmjViJEBfrOzptw/AaLsEoiWihCBctMr0tOFZMkCDn5sjfJb8+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(366004)(39860400002)(186006)(1800799006)(451199021)(9686003)(82960400001)(7696005)(71200400001)(6506007)(55016003)(54906003)(8936002)(52536014)(2906002)(7416002)(8676002)(86362001)(478600001)(33656002)(38070700005)(316002)(38100700002)(6916009)(4326008)(122000001)(41300700001)(5660300002)(66446008)(64756008)(66476007)(66556008)(66946007)(76116006)(91956017)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFoxdVdrQmtpRGZSdGxWdDV6ZUZzbXlDY0Y1WVRSREJDWUx0ZzBUZUp6UGMy?=
 =?utf-8?B?dW1hWUpuWS9CZnhvY3ArVFNFa0lxR3hMUk9rNXcza0JWUkZoZVFLb2RNTzNt?=
 =?utf-8?B?dXBsMXlvRUVBV09uYkowbWlZVGlzdlhXam5TQnVwY2NhaTExeWR6MG9IZ0pi?=
 =?utf-8?B?WFpKZ2sxRE9OWTllWEJBdlBBb1ZFTnlzbHdSdkxYRkw4bEpKSXdZWTFiUzhX?=
 =?utf-8?B?Y3FpVktzMDM5RFJmNjZMb0tadzY2bXdPNkl5b3FvVHU5WURRV2dwKy96WDZP?=
 =?utf-8?B?UkVUY3BSZElHSXFJMDdTM3pUNEVtdm9SQk02VHRtWWRzQmZ3TlVqRzh0d2dz?=
 =?utf-8?B?TGJ2TnR1bURyYXVyUS9DdFRpeGlNVXBoTXp2eERIRGZzS29KakJnWnJyVk9D?=
 =?utf-8?B?bzhLeC9mSEpENXVBWmxZZmg2dmRCbGowOWJhM1lFMUx2NG0zbURBc0hWaEND?=
 =?utf-8?B?RmZSQit3cS9qaE9zdTZjU0hrVlRCRUZ5b0FjL1BCSG5XdEcrNDVpSCtiZk4w?=
 =?utf-8?B?K2F5a3lRK3gva3ROZDVnLzloSy9sOXFWQjdmWTFsdzROQlNzaDk2ZlAzRXhl?=
 =?utf-8?B?Z2JPZ3M4RFRWeUJpdTNZOHhWTG1wcUI5d2NMKy9NUWtlaVN6aDMrTHVZbGQ0?=
 =?utf-8?B?NEMwSVN4V2I3djRIODBScHZFQjVoczgrK3JEMkx2bzJNQTZIQWRGazFPU2pi?=
 =?utf-8?B?TGc0ZTNQZDljK0JPQmlKWk1UK2NXZDZkQ2hmM0ZlUlcveFVsdUIrWWxaNnc3?=
 =?utf-8?B?SDEwL0FnajY2T1p5dGJteDBCeVJaVVBHVWh0US9PcnJlUWNtRE1qaUNTSjlX?=
 =?utf-8?B?NElpUVlOclROWVp5QnZsUEN5cEd2aEMwNWpocGFpd1pxOHo5R2RPMHNRWHNX?=
 =?utf-8?B?Rit1Zmc5V0RHRUphaEV4UUhUN2xKQXUrcTRDeXpLUkRNUWZ5S09hc3N6TCtE?=
 =?utf-8?B?K2JxSDcrN0ZrTzk1SXphZlRzYmlqSUhiNlhYS2RKMWZxRk04RUR0V2FyRDZJ?=
 =?utf-8?B?RnNaQUtkTGc2dU4zendtMWZkWFlucytqcGFNd2Y0VGZiN2pCaHN0YkpwaGtD?=
 =?utf-8?B?OE1LbUtqeU1PYmJNc1o0SkpyTXkvNHhaOFYvb3RGUXZKdFR0eUZhdFBMZ2FZ?=
 =?utf-8?B?QjE2aUlXTTByRm1ERkJFeUZhYVlzeGpZZVo4RVc0ckdZRmcwRjNWY2RLSHZD?=
 =?utf-8?B?NHlYRHdPcXFNdXJTbmtJcld1WDJwcFd0Y0tWYW51RHdtKytVb0R5UUF3OTBq?=
 =?utf-8?B?K3VYL0tDWmI1RTZmZlRIREl1UlhpR0gxbUxVWlJXdFJDK0dSbENwNktLZWwv?=
 =?utf-8?B?bm80RW1kMSs5ZnRzL0M1N1JONVRHc05lYXcwM0xZMmxWLzF3bHA2OW1LUlov?=
 =?utf-8?B?UjFpSTduRnYwRGUwckRUZEVXU2w2TEVBWVpBc2NsWk15aHlZNllqU0x0amQ4?=
 =?utf-8?B?bHBLVG1LY0ZYaDZVOSt6OG5MSlJiU3pBRHJDaXViOTZ3RVBDK1NUVy9OYVdx?=
 =?utf-8?B?QUY5c0VoQ0FCdzhMT0Qwb21BbkY1VXh3aU9YYTNpSnRGbnNLb2Y0NHlyWE04?=
 =?utf-8?B?RFA3TXk4bVQyaXhFbE01bzYySjFiMG9QUEVGZW9YaWhtb0hsVmlpSWFyOXJH?=
 =?utf-8?B?cjRCTlZPL0lZdFZnWURCWlU4M2Z1bSsvNWRSUGpraDJzUGYyWU1LSS9pUUlu?=
 =?utf-8?B?OGRwdkVBTWtScm5GVWRFc3ZiSk0yRFQwcE5haXdkWCtWUTdRdkYxMEZaR2hJ?=
 =?utf-8?B?UFpZakZPaU0zMTVmYlNvYWF0MDJWRm84K2pRRk91anlVOXIvVjcvdUFyNUd3?=
 =?utf-8?B?UktDS2c5L3kzTnJVU0U1WU5XejJhK0psYU8vMkR3VlppRlRWRFJCR0RzdlNx?=
 =?utf-8?B?U1VMSmJ5clh5MldDZ1hHOVV6MGVkWHg1VmNOb09SNE56WHNMUCtoaWpONjZV?=
 =?utf-8?B?SzFUbkwzNmF5KzJoMU44MXdFS28xbnpKNzNoWFFHWWpGNDBmcHBSbmIwaW4y?=
 =?utf-8?B?Q3NKcGZnTFVwb2JybU5IWWxETjcvb1lzTDJqRnhXcklBVU15UFAwUXRFelgw?=
 =?utf-8?B?Q3l4eXFZU2FvR0NzdWhPdk53U2R0Zk9UZ0RralZwRTNYVGdITlNHczhQVW5n?=
 =?utf-8?B?SW0yY1hzZmliaWFrSzdUSmdwa0o1QjhMMVlrb0RUY0paMVc5b3hGNHlIelNW?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8509823884645C4D8F0F076323B8E437@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bf505f99-27ac-4f47-5e80-08db9934278e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 23:55:48.3533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nShCWsTuB1KVwQc85cOYGpLDK02wpdAShBQdElpFbudb2miYbg1t1QI094JeKJvSK8ruY0B1JeXo2aqDMlI6hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1525
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: cmHiZYb8dkTH-GKVeEyrWt5khK3DQITN
X-Proofpoint-GUID: cmHiZYb8dkTH-GKVeEyrWt5khK3DQITN
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_19,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=635 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090206
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gU28gd2hhdCB5b3UgY2FsbCBhIFBIWSBpcyBwcm9iYWJseSBhIFBDUy4gUGxlYXNlIGxv
b2sgYXQgdGhlIEFQSSB1c2VkDQo+ID4gPiBpbiBkcml2ZXIvbmV0L3Bjcy8uIFRoZSByZWFsIFBI
WXMgYXJlIGV4dGVybmFsLg0KPiA+IA0KPiA+IEkgZG91YmxlZCBjaGVja2VkIHRoZSBpbnRlcm5h
bCBQSFkgaXMgY29uc2lkZXJlZCBhIFBIWSwgYnV0IEkgYmVsaWV2ZQ0KPiA+IEkgY2FuIHJlcHJl
c2VudCBpdCBhcyBhIFBDUy4NCg0KSGkgQW5kcmV3LA0KDQpUaGFuayB5b3UgZm9yIHRoZSBhZGRp
dGlvbmFsIGluZm9ybWF0aW9uLg0KDQo+IElzIHRoZXJlIHByb3BlciBkb2N1bWVudGF0aW9uIHNv
bWV3aGVyZT8gcmVnaXN0ZXIgc2V0PyBJcyB0aGVyZQ0KPiByZWdpc3RlcnMgdG8ga2ljayBvZmYg
QmFzZTEwMDBYL1NHTUlJIGF1dG8tbmVnPyBTb21ld2hlcmUgdG8gZ2V0IHRoZQ0KPiByZXN1bHRz
IG9mIHRoZSBhdXRvLW5lZz8gU2luY2UgdGhpcyBpcyBCYXNlMTAwMFgvU0dNSUkgeW91IHdhbnQg
dG8NCj4ga25vdyBpZiB0aGUgbGluayBiZXR3ZWVuIGl0IGFuZCB0aGUgZXh0ZXJuYWwgUEhZIGhh
cyBlc3RhYmxpc2hlZC4gQW5kDQo+IGlmIHRoZXJlIGlzIG5vdCBhbiBleHRlcm5hbCBQSFksIGJ1
dCBhbiBTRlAsIHRoaXMgYXV0byBuZWcgaXMgd2l0aCB0aGUNCj4gbGluayBwZWVyLCBub3QgdGhl
IFBIWS4gSWYgaXQgZm9sbG93cyA4MDIuMyBjbGF1c2UgMzcsIHRoZXJlIHNob3VsZA0KPiBhbHJl
YWR5IGJlIGEgbG90IG9mIGhlbHBlciBjb2RlIGZvciB5b3UuIElzIHRoaXMgaXMgbGljZW5zZWQg
Y29yZT8NCg0KQWZ0ZXIgZGlzY3Vzc2luZyB3aXRoIHRoZSBBU0lDIHRlYW06DQpUaGUgdmVuZG9y
IElQIGluIG91ciBBU0lDIHBlcmZvcm1zIGEgcGFyYWxsZWwgR01JSSB0byBzZXJpYWwgU0dNSUkN
CnRyYW5zbGF0aW9uLCBpbmNsdWRpbmcgY2xvY2sgcmVjb3ZlcnkgYW5kIGZyYW1pbmcuIEl0IGlt
cGxlbWVudHMNCnRoZSBlbnRpcmUgSUVFRSA4MDIuM3ogUENTIGFuZCBpcyBtYW5hZ2VkIHdpdGgg
YSBNQ0QvTURJTw0Kc2VyaWFsIGludGVyZmFjZS4gVGhlIFNHTUlJIGludGVyZmFjZSBjb25uZWN0
cyB0byBhbiBleHRlcm5hbCBQSFkNCihhbmQgdGhlIGV4dGVybmFsIFBIWSBpcyBtYW5hZ2VkIHdp
dGggYSBzZXBhcmF0ZSBNRElPIGludGVyZmFjZSkuDQoNClRoYW5rcywNCg0KLU5pY2sgSGF3a2lu
cw0KDQo=
