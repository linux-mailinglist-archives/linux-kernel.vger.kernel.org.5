Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A56771779
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 02:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjHGA0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 20:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGA0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 20:26:07 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2109.outbound.protection.outlook.com [40.107.7.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15A0170B;
        Sun,  6 Aug 2023 17:25:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/zWs6lLFxH0zXNGQdXTs5VFguDLVqH6iL28G6bXIODs/2BI/u/GSwADIGjW78e/f8z7QCQOKaHk0KHf7PuEJYpilnCZxGoi/A0ciVsEfi6q9Jdo7Kd9TAqjFwRiFIBG7TvbX9jFsVpqZthathndB7nhd+H4LgXcxA2pBVx9ejgeABrBOduYMMm2wHgFWIQNdT+F+gH/u9Yr1hn8hXylU8zJwlFD6yJziZcBtasiMPJxlQJXRbg5Bd8m99QN8P11Vrq2NDvwZS/rgwwZ2xV3YRGV92VZvG2jYorlJvGyb+cgZnCnIH9nhY6AY1opxJASyJIrrUbi4aM1gZhoteMbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+T+SNDh6vGaVdRQecykhyBlhNpnfdvQi9ippEqC5z0=;
 b=lvFSqnf1QG2XM9tT5ewRI7lf4j3JmSFb3wVZiHNwKKSeJNht2JCyWzu0iOVdnvC/aRWVwHgfdx4rUXFFiPpQs4QoEVFZwyQcfLisZ69OyPINjIVNPpGcrV+o4/NeHa4I/8kpvtYOe3oiC8SAZBhaDo06NEkQ8sQg0vLibd39I/EKnR1cNZP2GPrlDCZ/LY/DBjC5nzy5TkRjLMzfuLtr8qHWAh/+BCND8hOB2C73+OJqNZJr6KjrOG4M1wIcBQGWWZcJEg9G4XdaHcWVGbES8qD8+U1o0A5XxQd+BGK4/DmGvrE9E3YjJuQVW96iffHGzUZoVnG0Z+maGwgHlclTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dektech.com.au; dmarc=pass action=none
 header.from=dektech.com.au; dkim=pass header.d=dektech.com.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dektech.com.au;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+T+SNDh6vGaVdRQecykhyBlhNpnfdvQi9ippEqC5z0=;
 b=mHG4E/M5g4TpWoqyx10L7viHDV4BVzvcpYyp8OvMys8Fgq1deUhoGddli4lyM6LNEMT9G40W48c3I5wdPcJ1FX/pBOiU9rVgs2ERNDchlSgVyeSSdX0DIKfCSzXqOhKEVWfDXl8rrYovxYyr+Vmc7FuPmRiKv3msFB5TTU72PvA=
Received: from DB9PR05MB9078.eurprd05.prod.outlook.com (2603:10a6:10:36a::7)
 by AM7PR05MB6709.eurprd05.prod.outlook.com (2603:10a6:20b:136::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 00:25:56 +0000
Received: from DB9PR05MB9078.eurprd05.prod.outlook.com
 ([fe80::85b:aaea:a5bb:e08d]) by DB9PR05MB9078.eurprd05.prod.outlook.com
 ([fe80::85b:aaea:a5bb:e08d%7]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 00:25:56 +0000
From:   Tung Quang Nguyen <tung.q.nguyen@dektech.com.au>
To:     "yang.yang29@zte.com.cn" <yang.yang29@zte.com.cn>,
        "jmaloy@redhat.com" <jmaloy@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "ying.xue@windriver.com" <ying.xue@windriver.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: tipc: add net device refcount tracker for bearer
Thread-Topic: [PATCH] net: tipc: add net device refcount tracker for bearer
Thread-Index: AQHZxrFfSLW6PQQYC0qMumgl2k4oQK/d/M2Q
Date:   Mon, 7 Aug 2023 00:25:55 +0000
Message-ID: <DB9PR05MB907879CBF037AC6D916EF08C880CA@DB9PR05MB9078.eurprd05.prod.outlook.com>
References: <202308041653414100323@zte.com.cn>
In-Reply-To: <202308041653414100323@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dektech.com.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR05MB9078:EE_|AM7PR05MB6709:EE_
x-ms-office365-filtering-correlation-id: 6ca9eb3e-98f5-47c9-5937-08db96dcddb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h6WFmrUQMbfTZLcRQy60TUyrP+whxYxQWZAT+x+WJViKYJjnh0+hnGBUNOPB1eV137czZONoMVyC4YWvdVkDTTKrTWLU8XcKL7PWrLSuma64/T8IDg7YlhBgQjeANnbmg4LcA2EN49d9pive2kYTVOSpiMW1IIdxdRe2T23RTS4pYi88UCy4sHiQka/6Y0cSPzRh/Acx4GP4n1mhQMM0njlXGOCfnZYLpULPhT+7T0IU1K66Ha/hSprINGVgPfxVsCBK7x2lLMB+q8pev+bpWEgGO4uoaFRqXharzVw9LoP3Q6Azx4seyqYUyGeXqQDSq4PoduG6FfjjPA1oSsFBSdTygdDiuqRnAdIp/dJ7TfieTrfhyNkV79JM6p4unwX7t1MGVhhdILITfDMh+YcaJ21KqIhz17muAvrzC4C/DOl8Gu9W30frzzp0eYpWbb/IuHLz0zQ4EA84/81js10aKNIpuZIj66rPbwiZfwPD3FXk36SSxcGm7jWbgy16+DhYHb0ncrFr7Du8uwCBXj8CpEiXgq0pHslQz9ivbbEkBU8doHi7bMkSGxLFPh6Ftb8+/VTc/cjjGPUHhs+W0qGxN2RZBLuXAxGoTWVF4NvWANJH/ES2xewUD44UHjfe3iet
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR05MB9078.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(39830400003)(396003)(136003)(186006)(1800799003)(451199021)(52536014)(38070700005)(41300700001)(26005)(2906002)(5660300002)(83380400001)(8936002)(8676002)(55016003)(122000001)(478600001)(86362001)(316002)(33656002)(6506007)(7696005)(38100700002)(110136005)(54906003)(76116006)(64756008)(66446008)(66476007)(66556008)(71200400001)(66946007)(4326008)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vzl2aDhmektnRDkxTnptT3RMNjJaLzk5NzMwdGZXcEN0aExua3Zra01uYkxB?=
 =?utf-8?B?SXhCOFFpMDJ0YkdscmFKbWQ1dEZUOTdGTEZoV0I4RXo1REpQTnFOVnRUSWtt?=
 =?utf-8?B?LzJPSllzbWsxT3cvTkF1aDRzOHdJSEZTWFQ2OVgzNElPMWkvT0Z4YWhla2hz?=
 =?utf-8?B?cXJiMmUxVjZNZUNIQzRCWUlwbXoySDFtaGpXYURBQlFremp6TnBGTjIxUUJ3?=
 =?utf-8?B?RUZ5QzhyWGVJa1U3eXRrWWtjSGNNNWFkZzZjNFVWR0VFSVJIR3pZVmVhMmZI?=
 =?utf-8?B?MHo3dVhjcEZ1OE5Qb0huWnZCUmpvUmd2ekR5V3paNkZQdWI5YnFhbDBxQlZk?=
 =?utf-8?B?SGpzcU90OGJQb08wN0RrQ3plVklKU1Y1UFgrdkFyKzJwckRqcUtGcHdsV05m?=
 =?utf-8?B?S01sQjNZM0RYUUFYMzhNVzhOWG1VT1FIU2lUdUFyOHltWUxKMlFhUDNaT0JZ?=
 =?utf-8?B?OWNOKzd1bmdQMngxNUN2ZUdtMHZsZDlmYkl1eGJQa0dQbWprK1pPcTRWUlZp?=
 =?utf-8?B?M0pvZHBEaGRqbjNHSERYTnFDNzdWeXhmQWg4dkNFNmdzWG1BTWY2NTBFeU1j?=
 =?utf-8?B?VVJDQkdjZUNWb3RjNllTc3VPc3RMUDdQbzZ2R1FvaGlHTG5IUi96ZXgxUEJy?=
 =?utf-8?B?akdIYzQ3dUM4OUgra21jV3hMbFQ0Sm5RczB4MFBlaVlBejZiVVFUSkIvOFZC?=
 =?utf-8?B?Y0JtZFljdlRXSWVEY3ovLzA4WDlVck1Rbml0cmNGSzIvRmJETU0wUUkwWWtH?=
 =?utf-8?B?cWlrSGlCa053RWE1UHR3Rmh6UlQvb1FHNHlFWUhoalVrL0x1VzdZWjhsdWxI?=
 =?utf-8?B?SDBPdmFpaDhjNkp5SjgxbC9PV1FLUExDQkd0M1ZlSUE0bHpNaUJXTUhtNFBS?=
 =?utf-8?B?cjExUHBYNGRZa2xldHlqdThuS1dVMmk5YWNOVVo3ODVZV000QU9JbzBiSXlG?=
 =?utf-8?B?ZGpSRi9maGNlTEt1TmV6alFTSWgrQlB1Q3N6a1dwT21SbllqZ0psbnJUSFky?=
 =?utf-8?B?aFk3NWxqaDIreU1JeUpHNzlCanV1TVMvVzgzcGJZU01lRGNpODVFNmVXK1FZ?=
 =?utf-8?B?NXNHUjRLRGRVVUlVZHpVWEt6VmR0cFpjTUpIVkUxVkVWeXp1QzMxMDVnSWg1?=
 =?utf-8?B?bmhpWE1iMU01NWJ1MVR0c3dtN1RreUNGWFk0MWQxQTk5ODltYlpnRVVib3VN?=
 =?utf-8?B?dDY5eGVwdnNzWWVlWHVYdmZNNW5lbkZFYmJzZ1FzL2hSdEZqaE9oaGt1amp0?=
 =?utf-8?B?UHJmN0xmcC82eDB0cEtwdDNtV2ZnVjhPL0hqQ1FMWGVVWFZwT3FISnBzdFc2?=
 =?utf-8?B?VDY4SHJjSjdXcXk0SHlCckFwVHNKZFRMcDFOTGpWVWJEbkEzeUxsVk5zWWg1?=
 =?utf-8?B?LzN0TEh6VldSVThuaGU5MTcyeTBzaFBqLzJNOEhTSG9kT2I1WkVDU1N3RHhm?=
 =?utf-8?B?NFp2SW9PM0R3c2Q2allMaVAzNlZkQ1dmeEZrc1pIZFN1YnNYNGgzNEZ4dFY0?=
 =?utf-8?B?SFRJWnczYVl3V0Z6dXhvb3lUNmhsbnhpRGw3STA5MGtxOTVNZE42STZaVHU1?=
 =?utf-8?B?c1RVQ0M1UUVXSnVQVzB0ajdVbDl3TktKOHY2TTJYYlRCZ3FXYlgza1Y1Y1F3?=
 =?utf-8?B?RVovR1J0WnhuaHRTbHdzb0puZlhDS0xIZjlVRkRKQU9qUWt4bit4Y3lXNlBs?=
 =?utf-8?B?OXhXOVUxOWo2bkhCK1d1SjQ1bVRPaU9oay9RajAvZlZMTEZPR01qSDdmbkJx?=
 =?utf-8?B?VlZzNGdZQUx1V1E3ODhJT0dzVHpkNG0rdThINjhtbVNYb0w4VmJkUmJuRzRj?=
 =?utf-8?B?NGFFSDMxaWgyTFNKNHhmdElsMHliNjE3SFB4SnAzeWp1azIzVWlpcU50eUQ0?=
 =?utf-8?B?VFovYjVjV0pxS3U5UHhEQWdDUVVVcXdJdldZaWMveUZVcDBldWt6YThWNmtR?=
 =?utf-8?B?UVI3dUZzaU4yTG5SL2p2Z0xjVHl0azZrdDRkRm5WK0kxaHdPTWNZZE1YbkRT?=
 =?utf-8?B?ZVZSam5ZMy96eUliMUZDNEhoZVNUcVJPUDNKV1RBRnFGRDRXeVhHTTlpb3h2?=
 =?utf-8?B?c21zNnNZdG4zemRQN3hnZ0daMHBrdFV0UFNYTklyWTZZNTRFdGJQZHg3NFFs?=
 =?utf-8?Q?gJ2ePBcgO+vPodPvWdKyeKeLI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dektech.com.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR05MB9078.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca9eb3e-98f5-47c9-5937-08db96dcddb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 00:25:55.9166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1957ea50-0dd8-4360-8db0-c9530df996b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HpG26O8pkszDlcq4U5e5K0O6optSzKgT4+BSeZGycU6qy8H3zFbQ8OZcK8tjzr5O4LOLYUdgpJrRjza+runwRoJdw4ifxeDQHaVaKmyrPic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB6709
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkFkZCBuZXQgZGV2aWNlIHJlZmNvdW50IHRyYWNrZXIgdG8gdGhlIHN0cnVjdCB0aXBjX2JlYXJl
ci4NCj4NCj5TaWduZWQtb2ZmLWJ5OiB4dSB4aW4gPHh1LnhpbjE2QHp0ZS5jb20uY24+DQo+UmV2
aWV3ZWQtYnk6IFlhbmcgWWFuZyA8eWFuZy55YW5nLjI5QHp0ZS5jb20uY24+DQo+Q2M6IEt1YW5n
IE1pbmdmdSA8a3VhbmcubWluZ2Z1QHp0ZS5jb20uY24+DQo+LS0tDQo+IG5ldC90aXBjL2JlYXJl
ci5jIHwgMTAgKysrKystLS0tLQ0KPiBuZXQvdGlwYy9iZWFyZXIuaCB8ICAxICsNCj4gMiBmaWxl
cyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+DQo+ZGlmZiAtLWdp
dCBhL25ldC90aXBjL2JlYXJlci5jIGIvbmV0L3RpcGMvYmVhcmVyLmMgaW5kZXggMmNkZTM3NTQ3
N2UzLi4wMWZmZDFmMjMzN2EgMTAwNjQ0DQo+LS0tIGEvbmV0L3RpcGMvYmVhcmVyLmMNCj4rKysg
Yi9uZXQvdGlwYy9iZWFyZXIuYw0KPkBAIC00MjYsMTUgKzQyNiwxNSBAQCBpbnQgdGlwY19lbmFi
bGVfbDJfbWVkaWEoc3RydWN0IG5ldCAqbmV0LCBzdHJ1Y3QgdGlwY19iZWFyZXIgKmIsDQo+IAlz
dHJ1Y3QgbmV0X2RldmljZSAqZGV2Ow0KPg0KPiAJLyogRmluZCBkZXZpY2Ugd2l0aCBzcGVjaWZp
ZWQgbmFtZSAqLw0KPi0JZGV2ID0gZGV2X2dldF9ieV9uYW1lKG5ldCwgZGV2X25hbWUpOw0KPisJ
ZGV2ID0gbmV0ZGV2X2dldF9ieV9uYW1lKG5ldCwgZGV2X25hbWUsICZiLT5kZXZ0cmFja2VyLCBH
RlBfS0VSTkVMKTsNCj4gCWlmICghZGV2KQ0KPiAJCXJldHVybiAtRU5PREVWOw0KPiAJaWYgKHRp
cGNfbXR1X2JhZChkZXYpKSB7DQo+LQkJZGV2X3B1dChkZXYpOw0KPisJCW5ldGRldl9wdXQoZGV2
LCAmYi0+ZGV2dHJhY2tlcik7DQo+IAkJcmV0dXJuIC1FSU5WQUw7DQo+IAl9DQo+IAlpZiAoZGV2
ID09IG5ldC0+bG9vcGJhY2tfZGV2KSB7DQo+LQkJZGV2X3B1dChkZXYpOw0KPisJCW5ldGRldl9w
dXQoZGV2LCAmYi0+ZGV2dHJhY2tlcik7DQpMb29wYmFjayBkZXZpY2UgaXMgdXNpbmcgdG4tPmxv
b3BiYWNrX3B0LmRldl90cmFja2VyLCBub3QgYi0+ZGV2dHJhY2tlci4NCkRpZCB5b3UgdHJ5IHRv
IGNvbmZpZ3VyZSBiZWFyZXIgb24gYSBuZXQgbmFtZXNwYWNlIHRvIHRlc3QgaWYgeW91ciBwYXRj
aCB3b3JrcyA/DQoNCg==
