Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24A4757555
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjGRH3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGRH3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:29:47 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2052.outbound.protection.outlook.com [40.107.249.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40634AC;
        Tue, 18 Jul 2023 00:29:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2GyhwK2sFATMfjTrm0kzI2oj0fDrmuKcS8brtcBKaFPRkhr+uwy0YUrVjP3yJLek6ew76XoIIRIutn310/UpWPXjx6n4tlMgl8jjDDTSiWTbCcM+i0oTvJwZdeo9JQY+wYpgPD+OhOMzOtZCw1BrxU96GQVbDoJX4Q00IArBJq+YzKrWezE8SaPXZ3Vltk6LYQZH1hpU4ddycGsva4liEDV7kSP76ZtG5WoBTHjHRxbE03drSqwsLV5aHXgVeGSNXsJlCCLI3GG2sN7eWwE8yjpk+vTPtnxIFF0/9U8FZnXsO5gvNOsI00qgTrqnytgPyDnmFVLt912MOvk6SnlYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQq2vGvefsD9d80RGsPfIJVKpYQPiGkqsz3F+ZzGGn0=;
 b=R9KxFgR4bbsKKxionjzTx3kZdJ6EMbVtqZDiF5Fycm4y9QqeJwNw6C6bfcn6LWmvrcsQk5m3vDpqTKyrFcKW4PjxPvRRX1BxMFFBSwYqGHEl5iPPOqMKXuZvxUB4T1v9cEIylNv2T6IqrVy/AAnzCUMFflswqc85isRXs5TNlobwzQLRmHXKZeP0Oe5OnT9e9r6VVxjUjjPy8tYm1WLu8Bb+mUJK+Epg1QuYuZBg2pGuvbkumLueygsf0G3imQcoW72kFxjjkWzkqs/6McSdFlSkdUIN3gDtxLaEQh7dOJkmSuoScREm/iz1rGueM1eHIctt8EJCCkjo7gCR8HMumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQq2vGvefsD9d80RGsPfIJVKpYQPiGkqsz3F+ZzGGn0=;
 b=eGHeoCBJ0yEvbmDYI+/N67xx1X6TKrYcHSmIDS5Kq6PLhCEhWgXtEnWZmk+U0YGy/aafCN3Eahr9q8uoZxNPtCtnOw773RVROobIsEdzIN0lIXmGSyWUG01uSnSBCqHcO6iBWwc+Tji/PDsr+WcH87w9oyiKznnckOlAsMmVeF8LzCJWG9JG2lk4ikAlLLkPXKmOfrpbD6cNnCcuV3ZLxZHdAarTVbwWw6Ex2cbcIiNm+jBf0RnDaoe+ZrNeTnVjR/oDldQon0m7pJjgWjZW2y99PMID/Rbw+Sd1x9+SzU5158EhSfkUm41D9s6pbhI14Nx0BvZWBv2zplGFB6TDpw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAVPR10MB7236.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Tue, 18 Jul
 2023 07:29:44 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c056:6a8e:6bed:d7e1]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c056:6a8e:6bed:d7e1%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 07:29:44 +0000
From:   "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To:     "Haener, Michael" <michael.haener@siemens.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: Re: [PATCH v3 1/3] net: dsa: mv88e632x: Refactor serdes read
Thread-Topic: [PATCH v3 1/3] net: dsa: mv88e632x: Refactor serdes read
Thread-Index: AQHZuUV9/7m1PXOi20CKD6b502mHe6+/ILEA
Date:   Tue, 18 Jul 2023 07:29:44 +0000
Message-ID: <dfe2dd01a3ba1051f429d049d09ec8d03b965a4d.camel@siemens.com>
References: <20230718065937.10713-1-michael.haener@siemens.com>
         <20230718065937.10713-2-michael.haener@siemens.com>
In-Reply-To: <20230718065937.10713-2-michael.haener@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAVPR10MB7236:EE_
x-ms-office365-filtering-correlation-id: f8cc9acd-5a40-48da-f912-08db8760c1cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dn+4CzoZK8NbFLcNywNTff7ZJ6rhSs1P8uz+Mr0Fo8own319kMZJ9RBCMgxCBdosl5Dgs0z1wbvABFq5wsAtrEWHMN+8FC97WuCRDR/8ZFfCHaXERS1sSAIjL8HvBNRkZiYB+fRwKu3395TcOXBjxc4KlxVYEUfwMWqzbbeXBM3pyyn9Pri2laWO10ck0IuiMMgGxuXiPqrkscdrtnU5JuPsGUtaoS8fpEbbQHgH5uNQc9kjwTjQkwEkrjMkK3RLKVyW+0HmtJtItw3PFAyg+OZFIRIQbfaWL6iwFg8txMg7Ql1B3g0XY59jII4L/KjtEKPB9jCPb0+RZaSr/ro2uz+O6dIvUh1FHi+q49TpvoW7GARgJxlPRKgcCFtAGnS3o8inmzeRcGRwvf3ftYtDqE1wI5Wh5shmwPe2X8dtzXUDx4n4PODpNstfBuHDBGfUUlqVScechU8e22RcrhaPh8rwLkhSZ7fpHB1gmUqZ7fN6OzPB7lp/By+gAdoIgjvqIpz8wvVU9/L9vs+T/r2xc5qc+vw+9skA8TDWYagqLxKWLPhjjE46bv/M5ZQe1Q1ymUxHmuCGZaYjFR3SlkXYGwsUAp4KXW9/7/P/99JhlW9qgjnEwEY5fxgyUxpHp3jSnKyHLVthzlxcJGwq5d5Xnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199021)(86362001)(2906002)(8936002)(478600001)(110136005)(71200400001)(36756003)(7416002)(4744005)(54906003)(66446008)(91956017)(316002)(41300700001)(64756008)(76116006)(4326008)(6486002)(66556008)(66476007)(66946007)(82960400001)(83380400001)(38100700002)(122000001)(6512007)(5660300002)(55236004)(15974865002)(38070700005)(2616005)(26005)(6506007)(186003)(8676002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnljOVFjdFFLUFZGQjk0OEw2K2JId2dzV3VseHpnMVFFOW9pNWFWNHFKNklX?=
 =?utf-8?B?SHNXMG9rMnZjY1ZrUFB4b3Z5YllpQ3ZlMHhhUVVqcFlWM0xpZFJ3d1Fub2Nn?=
 =?utf-8?B?VG1MRktGUm5KK2F2VmxZblZSdkRycDUvZUt5RWZKbXJsbjlYbXViMDhhUEtv?=
 =?utf-8?B?WVhtRnBrSTNMR0tzRGZNMkx1QkFWb3JrUXlrVm1TRE1hSjcvT1Q2Y05qaXdP?=
 =?utf-8?B?OUR1UjU3UStNcEhoUkhFYitzQ1JLTXlDRnhlU3dPeFVYSm1kYU9idDBsUnI0?=
 =?utf-8?B?ekhHRStTaC9Sa1BjSlNtd0tuUVovTmowRlNsaEI0K21oOUhEYi9Gd295M0tZ?=
 =?utf-8?B?dmNLSXNwK0V3cjRYazFoY2RSM3lBUXFyV2l2dlRiMFBvSUZqVytmL0VDUUdS?=
 =?utf-8?B?N25CN1JNUnBaeFh3OWk5NkdZYVV2NVBBUjdaUGxCZG4zd1BrSDk2NTBtaTBK?=
 =?utf-8?B?aHlQMGROWXFJTVNFNTkySlh2SStXRk9jdTFQYm1BS1h6a3FjT0VBKy9yQ3Jx?=
 =?utf-8?B?ZkJWWUhhY1VqbUQvbDQxTXU4SGp2MFpwWXdQbXpzVVVVNjB3cnI0ZnY5TmtD?=
 =?utf-8?B?UmFxWnZPbjJZV1o5b1VYYnYvQXlPVmlac1laNElPbWc0SkFwSHBlNitqYXAv?=
 =?utf-8?B?d3dnYU1aWUVKekV5Z1UyWnNMWlE4RnE3OHpjSlNIU2dIWUpuY1hMd0ladmFO?=
 =?utf-8?B?Z3JkNDJydXBrdnFoSXdhTTJCV25vVGtud2xnMWpCejVhenBXRDJ3amN0NnBP?=
 =?utf-8?B?MEt5cCtVb3JXMFFBWUJvdjUxQ1BnaElsTHR0NUlCOEZlcWt1a0dDaXhTQUNw?=
 =?utf-8?B?UHEwcXZNU0dUVEtNU3pVcHcwZFJwTmlYUGNFc1FDSjNudmxHaVQxNGJId0Fu?=
 =?utf-8?B?YWtKUkd5UHpZRDZjNldKRUNyR3huSWtkUlN4ZTBYNFAxTll5NjlZNVpDL0M2?=
 =?utf-8?B?dGh1VFg0Q0ZlWlQyK1pKTThYZ2ZHcHRwOEl0TzFwc3d5VVdKbmZaRU9iZ0lt?=
 =?utf-8?B?MTNhZmwzT0JvemRQaUE3dlY4UEFkVFlJcUVRaDB3Ny8yRGV3aVVGWFpqWUx6?=
 =?utf-8?B?NXVKenkrVlllT0Z2WW44R0xDWXNzdkhaQzdWamo0VE9uV3ZUNFlkZkEvWi9X?=
 =?utf-8?B?RTJ1K3FKYjlBb0NlaGV6WE1HR0hpMXlSTmVvRlVWQjBDbDZZUUtWRVQ0R3Zy?=
 =?utf-8?B?MzZWZW5OcUQ5bkpZLzdDUEZIbHdoaHlzRFh6bUU2VlEvdHhlQ1cyb2RHVnVs?=
 =?utf-8?B?bzkwMFYrUDFqVEZ3V1FXVzBUK3J4Z3NnUi9vMGRmOFZ3R0lta3VyZFVBaTFj?=
 =?utf-8?B?bUJDT2NXcWM0d3BQVHk1YWZaQXJQb2VTSmhlUVZjWFVtRHptREdnOTNMcUdn?=
 =?utf-8?B?UU4xRUtJRmFibzVUTW5XVHRERis1OUFoc2NMckVQdDk4NWdKR0NyZVkxZjhE?=
 =?utf-8?B?dXJuWE1tSFRNRXpJWTJqRHltNzBsbGFxaVc0Sy82MkJKNVlaajgycUNpaUFO?=
 =?utf-8?B?Z2FuYTl2dlhnT0FNZHV6TDNyT2w3MzNaN1k1bVVvbDZXUkRpeitnTXl4NDU3?=
 =?utf-8?B?MGFKdmd0ZElWQnJHOFpUbGZFeGFzOExNUU8zdVZzRHZlQjBiN2VURU8vSzg0?=
 =?utf-8?B?MFhkMXJMc2NOM2xjQlRmMCtEZmNCTGRkeVFmUWJHNmJaWGZBSXJSUStJdDc5?=
 =?utf-8?B?VVAyQlFlSTFuYW9lRTU5eTc3MHU2WWhJSnFqQ1BDbXF1VHJvU1YrSzBkRnd4?=
 =?utf-8?B?VmE2b0pTUTBrT2NlSXlnNW5NbGNhdHNKSUlZbzh2SEhMd1IxZy95TFdxY1oz?=
 =?utf-8?B?alNnalRrNlJwelZrRGdmcDQzN2dPVnQ4UGYydVhsSXd5cFdNSmxPNExWZTJa?=
 =?utf-8?B?bHFVdUZZNlE0ZUN0QkdRMmFVRUFMQXNPSVJCR0RKUUxxNXV2R2tyckRSaGdN?=
 =?utf-8?B?OGVNNW1ZOFFhUzlvd25BTStiZUd3UHhDaUdYRVU5bm1VZVY4dnBCc3hpQ3hK?=
 =?utf-8?B?MysvdUxadW5NTEwwRldseGNvVkJ5RFpreGpJdXJZNWk4YzhCMFFDZEVLVUNj?=
 =?utf-8?B?TkczWS9jSUhtOFB6T2NTcHR2RFV0bmszNTE4eWVBTUNLcGN0TXQxb0owRktI?=
 =?utf-8?B?RFgzNzByQmRXVnhnVGgyVWlCVDRxN2pXY0NHWjRVVGpMZ2FPbEo3cTlmczM4?=
 =?utf-8?Q?3noeeea61QDgxiQKZAbk1BI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60D9D2C16E40A6449FDB556BEBB5525F@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f8cc9acd-5a40-48da-f912-08db8760c1cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 07:29:44.0836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qTiC2RH9SvHCWhczlnILALdBhlrybeoIhVq7sJqvz1Gy1jN3KZ2LiE0ZbeORg1blVBtDSA5ne2UeJeCuRF7ezZtmIvRLhlIi1KTrtztiH5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7236
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTE4IGF0IDA4OjU5ICswMjAwLCBNLiBIYWVuZXIgd3JvdGU6DQo+IEZy
b206IE1pY2hhZWwgSGFlbmVyIDxtaWNoYWVsLmhhZW5lckBzaWVtZW5zLmNvbT4NCj4gDQo+IFRv
IGF2b2lkIGNvZGUgZHVwbGljYXRpb24sIHRoZSBzZXJkZXMgcmVhZCBmdW5jdGlvbnMNCj4gaGF2
ZSBiZWVuIGNvbWJpbmVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBIYWVuZXIgPG1p
Y2hhZWwuaGFlbmVyQHNpZW1lbnMuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJk
bGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCj4gLS0tDQo+IENoYW5nZWxv
ZzoNCj4gdjM6IHJlYmFzZWQgb250byBtYWluIGJyYW5jaA0KPiB2MjogcmViYXNlZCBvbnRvIFJ1
c3NlbGwgS2luZ3Mgc2VyaWVzIGRzYS84OGU2eHh4L3BoeWxpbmsNCj4gDQo+IMKgZHJpdmVycy9u
ZXQvZHNhL212ODhlNnh4eC9jaGlwLmPCoMKgIHwgMTMgKysrKysrKysrKysrKw0KPiDCoGRyaXZl
cnMvbmV0L2RzYS9tdjg4ZTZ4eHgvY2hpcC5owqDCoCB8wqAgMyArKysNCj4gwqBkcml2ZXJzL25l
dC9kc2EvbXY4OGU2eHh4L3NlcmRlcy5jIHwgMzEgKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tDQo+IMKgZHJpdmVycy9uZXQvZHNhL212ODhlNnh4eC9zZXJkZXMuaCB8IDEzICsrKysrKysr
KysrKysNCj4gwqA0IGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9u
cygtKQ0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMu
Y29tDQo=
