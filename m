Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3BA757557
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjGRHaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGRHaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:30:10 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2052.outbound.protection.outlook.com [40.107.13.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE321707;
        Tue, 18 Jul 2023 00:30:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L55QCq6xZ3Wsoc0U7GjdFC/FZkTwwNLDL4VDf1Xrq/eGgBpP1YKOVzEZaF0QvFY3/ploexcWPQVvAeIMsX1sQD+qCUKJlYY9omk0gS89Eai+x/a7FLu+XcAYrr4LHPIKY99JeMfuGgJdzJYmOu/od3lNG3atRE45aot4sbeu9605pTVX9VGSCkdi9kVnN5ZhLg0jmzfFqeEf9VNcTxm1TK43hRcXo+VVUZvud/WKnwmZjeKZbRaSl7zgOX6WIF2eZSvrTNBlYfqLJjRZLImZXDKnX6dpbncrXGpR+yb9NAza3j8Ka4q2w7/rzNFSQXyv2bLK+Z7G6/sPCcjOV8A+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/w7Gtyq46r2CxP+NTS4TNGvi7d0rbd1BZ+8tCatOAw=;
 b=eP95JMpLC1wSyfW++wz0OicuuD74ecYQ7mVVqOUzcgOKPX9Tvzvr6gK6fVt40GZydIBOq88CxXUIFI2RYsRoRUfiaZo8R7iRLyJTkc5ZgXdWCFcwjULXGvxrP9J42/vP5LNiElyxnziWdlSJxBhp50wI6LwiR6Gewi8MTfO1ZAS8jez1z9mrSBt1HxWUBGta6iS1WhaDV7TYNauC6sQQPZUrIDKLE74W/s2Tf6OnAUap1ehtlDfEvYGs6wkBmMbytKQMNpZhROEd38vnJlgVSMhPzGzcS0VhByUhJAwt//CBVJ2NQB2IO48bsBS+E5Rm9MoKrPnLmaTQfMjMJZEppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/w7Gtyq46r2CxP+NTS4TNGvi7d0rbd1BZ+8tCatOAw=;
 b=oNpY4O8pB6t3VSZYo5Vg55xjQ5RCXy02xJ31ChJ60Vy1m+mADMP7Hm4QtW42gJ/fxt9Sbp2JyaJc+X0F+k2J0fxmF8FDXo56ZKt1choPxlvijy+J/cR/dqgXPb5k/10dWmTIx/1rCmP+bW2N9Wl+wBzYNJqmi5fq93ny0IA06dQJh8dvPYn+vVfSNnjcAYGiWSgVSXM8efShK9XNFefzK3TZqWpUwVUJmcxReqZuphktFVedV5m4BfaAc93znvwzr3Yzuv3SiCYb+n9BUhgCSb9XoZp/OnIQAhVmSlVwRueBRcIOgJO8rZ8v8zHC4ktCyKGgG/pAe7sg933R3vVKUg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAVPR10MB7236.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Tue, 18 Jul
 2023 07:30:02 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c056:6a8e:6bed:d7e1]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c056:6a8e:6bed:d7e1%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 07:30:02 +0000
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
Subject: Re: [PATCH v3 2/3] net: dsa: mv88e632x: Refactor serdes write
Thread-Topic: [PATCH v3 2/3] net: dsa: mv88e632x: Refactor serdes write
Thread-Index: AQHZuUV/M+tKl3Ek20GYmmhOLEd8RK+/IMeA
Date:   Tue, 18 Jul 2023 07:30:02 +0000
Message-ID: <69b618b8bd5555ac6085995c14a84982949455cb.camel@siemens.com>
References: <20230718065937.10713-1-michael.haener@siemens.com>
         <20230718065937.10713-3-michael.haener@siemens.com>
In-Reply-To: <20230718065937.10713-3-michael.haener@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAVPR10MB7236:EE_
x-ms-office365-filtering-correlation-id: 72600ac1-c3a3-4bf4-b21c-08db8760cc84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: karPbbV+EMwkmV/wsvx+uCgKfq8CYzBxqqeoTDnvyd7p6twho/1o/KcqR+KFlWUe7KA1WwMVHbuyukq+iIAVFbkNOtXs8CjGPe3vPD+Q0DyNUJE3tysA/SfuAQPXEQZvuoTovpFmnyrjdMTAmjQN+CB8DORghNWPTDYXgjbKqg+SZcjUZ6G2zheMMcyloVSIdjZZMXge4o07l+uCBykrmkwh5Ei25a61MUSy8lRWxEPK1cCct+EaAhwPfOJ1UnOLEW1/P24wq+I0QW8TG2pCH8pXtVFU0E+PWUy2KPZZ/SJ/S7RarxJD8fFpTvOX13j2oEzT46vDupYufrbI24Duct/Z7BayA4+dspgC5YDfw+oU/kZr6ClxTN/UI/XEl3LOmSuIMhymysoJD8CbwZhMkN7HrM2VZTbpQWZhHiXINPtlRkCkEjXkl7Ur7oQuWhSdliK59nn7JNwTCHF41YYVWdGgC0/GYI8Vhzo2ql1ZI0pN3zccRzBKEPv/jPeV45B4QbbEt7YVuocj4RBn2rUYZwBSmK9f4LNcjTFrMiLaBg4GOBLtxHd+2fFnl1A/vID+d6b3VP2Wr8yaYjyYY3VtdP/ozkHOF3Bzs9p0mczDnxUMUnrkl59rH06u6yLOUQKWU3p5LH6RIVDjf/fRc/CAVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199021)(86362001)(2906002)(8936002)(478600001)(110136005)(71200400001)(36756003)(7416002)(4744005)(54906003)(66446008)(91956017)(316002)(41300700001)(64756008)(76116006)(4326008)(6486002)(66556008)(66476007)(66946007)(82960400001)(83380400001)(38100700002)(122000001)(6512007)(5660300002)(55236004)(15974865002)(38070700005)(2616005)(26005)(6506007)(186003)(8676002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RE5RZHViNmNHZEJSOWlDbERMUkFSNmsrMktPeFdYRzlNTERqdDQzbG1aRWNu?=
 =?utf-8?B?UExraXNra1VTeEF3WVRpdkJsN3I5VWhiYkptUndMd0J6MGpwbVpXRlAzb1Nj?=
 =?utf-8?B?citJYTc2L0JrU2U2UnkzOGcvZlhIbFMvSC80L0YwV3g1YzNwaU9YNkVadUNX?=
 =?utf-8?B?OHNybTNQV0dnV1hOdDA0dFU4WFF2YUIrS01EYUZ2OVdlZ3V6d3Rxem4wazYy?=
 =?utf-8?B?OWIxcjYvYVA3bHhTRnc0NXExZVN3NXJoUVFNSW1lT3g3bDQwc3hsSEplMDIx?=
 =?utf-8?B?eUlmc21FVFVLSWZ4K0pqWnUzZ1ZKSmYrQ3htZGFzVzF4YjcyTzMzQWp1WFAr?=
 =?utf-8?B?Tk82VytPSWpOY1hGWS9oWGpCU3lQdWM3NTlubEZpUzRxNWFhSjdTZUFIUU5P?=
 =?utf-8?B?S2drQTZvRlEvYUFPbEk4bGdueVpFTzAyOWxLNGNCNG1lbFBtMmtVa01ON2RX?=
 =?utf-8?B?OU90dVBKdU9tTndyeXZ5ZHJKdDhVdWJJcTI1aHR2TGFFWkFsTDJlelJVS2Jy?=
 =?utf-8?B?bEVkRkk0VWdlb1NVNmdDZFpIUzFyN3pKNWhZa3gxYXcxNDVIT28zNHdxMHRG?=
 =?utf-8?B?Q25Edm1aMDZwMS9nWThNdDJmV29Pai9pYUpnMjcxVzlKSzBSaDBpS1k4YnNq?=
 =?utf-8?B?dnR1ZVdKSEJmckV6ekcvam9NWVBzQmVGWjBXQlB3ejZzOERUcXBsM0VXdkNK?=
 =?utf-8?B?V0hYY2xEWkZKd3Bha2xQbWR4OWpWMVF0ODl2TWZLT1ZYMElzUXNKcFBLZGdz?=
 =?utf-8?B?OEg2V3l1cHNIem80K1hUT0lOUHBZK1dTaFFGVFpnMENNbWtTOVJvNzYrQzA1?=
 =?utf-8?B?QWtYeHZPZldaK0RwenhVa3JnLzRFSlpwM1pVQlJrd251UEgwZ0h6ODg0UVdN?=
 =?utf-8?B?d0JQS3Z1U1Y1U2xvWkZEWkxxTFFRdWxkUHZSeWhvalpubE9mTmpvY3RlMCtu?=
 =?utf-8?B?YkNIdzJpeDhNRkd2WE9Rd0R0MkxoUmhwbzBDcUxLQ3QxcmZVTWZMNHVPUis3?=
 =?utf-8?B?QU9aR0hocUE3a0RaT2xZM0U4UEYxbFhUOE1DWGl2aWRDY1FlMGFoOXA5VHhn?=
 =?utf-8?B?TDQzWVcvRXRVWC9mdTFOV1dsb09aSDJjU0Q2QURLek1SSENVVXNvTlozQ0hi?=
 =?utf-8?B?UEMvVHN0MmN2VGFFTXlxYk5JNGZEN2grT244WVJGeVZQZUxtRGZ5b0ZlUDh4?=
 =?utf-8?B?eUU3MjZ0SHVHcUZBY243UjBZR3N1Mlo4TzdUTmoxQUp6VnNpSlNsR1RYVHFk?=
 =?utf-8?B?VE4zcXVTZjljUGZ3eldadlVHb1M3SlpUbUNOTHBPbmlmTzlqNE9scnZqc1RU?=
 =?utf-8?B?Y05GNytQNG1xbTZOTDRXck1SYkYyYmVNU3dLbVZTcThjOFlLRHJuTDdCazFH?=
 =?utf-8?B?M3BIWG9ubUtha0tIT0IxZ044S3MzK3FNSHY4UUpGSzJYcFVsNkFsUWZ0My96?=
 =?utf-8?B?RmhxMmFUcFMrZFYvdzVvY1o0U3YrUjArb2sxK1Y1ZnR1VkpUUHIvV044T2dz?=
 =?utf-8?B?bmY3TkFaZjBQbitMZUNSRStWUlVhZkVnWjFISVVNRU1rbXVJWW9zZGxKd3pO?=
 =?utf-8?B?RVpZK3RMSTdaU0ppRGsvWGhHSlZzMGJCMGhlTTN6YkF4MXFQRWI2UmZSTi9C?=
 =?utf-8?B?VFBrUGtjajhMUkVXMS96N1A2dUdqTFFFVTlkZEdwQlliMTgyTE12dmhFUEp4?=
 =?utf-8?B?dWVkVE04aVBrU1VFcGJrMVFXbTdHT0lsYTE3Z1UwQ0VOeWlCamQxTVp6U25a?=
 =?utf-8?B?VFNlcks5Q21Ua2RvbFg5VktNTmdZMzg4M2VGL2FMUnVZYzFyNDlsbWRQb2pO?=
 =?utf-8?B?Mzl4dnZDaTIrN3UyTmxBcUlpRFJMbW5FZE9vdzZGYUxuT2MySFUxdDlGNUVC?=
 =?utf-8?B?dzdNVVdvT1pLRmhPSTU0RFdoNGxkc0hnclJsMUdDeTdBUUhieFJ0UTIwaTZY?=
 =?utf-8?B?WTFUNXlBM0M5TUJUSGl6NnpSSlNRSG9LckpPR3B4dXMzNDB2U0FwWTZmcmZG?=
 =?utf-8?B?NXd6OTBwKy9OaHI2bmRvK2M5NnFKc1QvOVRKS0RsRWNMcnBiU1AwOU8yNitj?=
 =?utf-8?B?cGJ6eDI3Nm1uYjFGWllML05LMVVYSSs0SmErZjFNV1dhMUo0ZTh0QytJcm11?=
 =?utf-8?B?bVdZZC95OWpzTmRraU54ZUJkTURSWmFOVVNUKzVMTGhhdkNuU1JMT0lvSVVD?=
 =?utf-8?Q?tyulo27oWeWEV7yd05INUGs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40E696B0B33E5A45B6308C307A5D0AC6@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 72600ac1-c3a3-4bf4-b21c-08db8760cc84
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 07:30:02.0630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U/eQhApxR6rs7Ec3+zXqJ6RbsLY2az/qjYLzupOeRA2AG+yP1yuIiSwqKJuy/Xr8K67q9Azdg6GKwZn4cN2s/IJN6qIwKQpE6OHeSQQ3kQg=
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
IGF2b2lkIGNvZGUgZHVwbGljYXRpb24sIHRoZSBzZXJkZXMgd3JpdGUgZnVuY3Rpb25zDQo+IGhh
dmUgYmVlbiBjb21iaW5lZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgSGFlbmVyIDxt
aWNoYWVsLmhhZW5lckBzaWVtZW5zLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBTdmVy
ZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KDQo+IC0tLQ0KPiBDaGFuZ2Vs
b2c6DQo+IHYzOiByZWJhc2VkIG9udG8gbWFpbiBicmFuY2gNCj4gdjI6IHJlYmFzZWQgb250byBS
dXNzZWxsIEtpbmdzIHNlcmllcyBkc2EvODhlNnh4eC9waHlsaW5rDQo+IA0KPiDCoGRyaXZlcnMv
bmV0L2RzYS9tdjg4ZTZ4eHgvY2hpcC5jwqDCoCB8wqAgNCArKysrDQo+IMKgZHJpdmVycy9uZXQv
ZHNhL212ODhlNnh4eC9jaGlwLmjCoMKgIHzCoCAyICsrDQo+IMKgZHJpdmVycy9uZXQvZHNhL212
ODhlNnh4eC9zZXJkZXMuYyB8wqAgNiArKystLS0NCj4gwqBkcml2ZXJzL25ldC9kc2EvbXY4OGU2
eHh4L3NlcmRlcy5oIHwgMTEgKysrKysrKysrKysNCj4gwqA0IGZpbGVzIGNoYW5nZWQsIDIwIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpT
aWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==
