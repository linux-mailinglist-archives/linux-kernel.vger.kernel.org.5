Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0406A808FB6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443643AbjLGSQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjLGSQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:16:58 -0500
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2296B170C;
        Thu,  7 Dec 2023 10:17:02 -0800 (PST)
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7GQGEN024662;
        Thu, 7 Dec 2023 18:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 mime-version : content-type : content-transfer-encoding; s=S1;
 bh=jijt+GKfcpuOzMm4+u6nhDTrMyIS9DmehZhKzsLjwxY=;
 b=MUuqhOqX9UhARhMxWeHlGkaIJqXzN2sGMAUB2dNloZsljxkjsb0rKbDCivgy3zKcuER3
 BjmAZkJ0CJx2e/WPQ25wG6sK/92IUbHIg+RFOP3uqvPolhDNgz9L2kOB6Gnp7K3jtXiq
 u2zWIMriRZuaPpdcFEtYY6yZ+E94FEL6wWcUYK22qY47XFqhqtWb+zUzFDCHzskkMUy3
 116NYdUjAvnpKA6ys80EwECz+PiZh5Zd8B2A/ynxhJYgwEklmN+88I81YXQWr7Qihpej
 MFU5B/ziafnzybLq4rS3O3mjVLbCkZun7fmfS7vn8wOSRM5tlekKjVqL8t9RfNIYVH7u 2w== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3utd1qj6rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Dec 2023 18:16:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+eV43V7GQh+gf+oE/RgcCcCl9htL1qHVN7dgdUqJOvUeTeDZOttyaXFFOCa39k6cRVUYiRtQfiv5RF0/WNFthXQJHAtG6jx1ltYfjJaVsu++fwQIO0puyo3Y/2GWs6IkYge3yFQn0A4x4NNHgbtSFFv0TcIV1t/aw5ZqgLsrZJajDz6Yv8S7fBINK2AFCDULID0gpTGuRAxhYaAnP3CKxrPRSGDCFiL/ly0FGiCLs8CH6s718DCPHLnervAzP6r5fffhTpfXDShi6o/HLuGJiD8E84NGQFPSSaf1bDAk4yxiUjjeMqGdNTs8YfuoM2KjFjjDC1msAgocyG9HRnDyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jijt+GKfcpuOzMm4+u6nhDTrMyIS9DmehZhKzsLjwxY=;
 b=ZwKTz28RX4uIo+vh3uDW+sdib/5Oxe2/wtuqwR/85LAkwcBQHDTgisNIJ3jRH35P8a7JxkZAiKoUE3Gp71Vd6FGtX0zw9HJ+X6Ln7tbDxLdr+R8COufyTLCDGJwvxSxT99+GGR6VltUKPrOuLaked4YBOZyNVGed3o5Bml9Fc5gszE1sSynlcoN9D4Ro8q7RxbX/m2INYkshyYiFKYRYnUtYXHkvLYsNbsKln2rNQZpFnno41dom7cwe6JjXkDytQifQ8qeb7hlxkK0wDUaTWAZXz9hObDe5A6Q9LtbBXy6nAsILCZLhWnl7TjGEWI4NXgAVPj7eHzg74OIEvv6aaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2488.namprd13.prod.outlook.com (2603:10b6:a02:cc::14)
 by SA1PR13MB4880.namprd13.prod.outlook.com (2603:10b6:806:1a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 18:16:40 +0000
Received: from BYAPR13MB2488.namprd13.prod.outlook.com
 ([fe80::3adc:9688:f303:5c19]) by BYAPR13MB2488.namprd13.prod.outlook.com
 ([fe80::3adc:9688:f303:5c19%7]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 18:16:40 +0000
From:   "Yakovlev, Georgy" <Georgy.Yakovlev@sony.com>
To:     "lee@kernel.org" <lee@kernel.org>,
        "sanastasio@raptorengineering.com" <sanastasio@raptorengineering.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tpearson@raptorengineering.com" <tpearson@raptorengineering.com>
Subject: Re: [PATCH v2 2/2] mfd: sie-cronos-cpld: Add driver for Sony Cronos
 CPLD
Thread-Topic: [PATCH v2 2/2] mfd: sie-cronos-cpld: Add driver for Sony Cronos
 CPLD
Thread-Index: AQHaIj3tL39jo0vXlUe94JOJfRkMDrCd/WSAgAAxK4A=
Date:   Thu, 7 Dec 2023 18:16:40 +0000
Message-ID: <5de86b5611a30adbd026bdfa6b19e2c6420ea73c.camel@sony.com>
References: <cover.1701203916.git.sanastasio@raptorengineering.com>
         <05fae4dfc455e44a9eda7da447e86a3f34ee395e.1701203916.git.sanastasio@raptorengineering.com>
         <20231207152041.GF8867@google.com>
In-Reply-To: <20231207152041.GF8867@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR13MB2488:EE_|SA1PR13MB4880:EE_
x-ms-office365-filtering-correlation-id: 3d4463ad-3cd9-4e39-8098-08dbf750a8d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kOyiaj+iHiHSHTJ0hRma7J+p8FhQQKPQZyw/7gSrTQaY2S3lY06kfsFSmrlyGDxdKTvoR7WB0mLaeST8YipNtWRI4MNnZoCyTOTL2cgJGvDhiP6MWyksT18eVx41omZAHMvNqWmw5a0vYfJxu0x2EjONJo6FiTbk1zkns1Hi8HwXhskk8RRDeQP1+o2xtmLeZu0oHrs+UcVaVTZLZCbw9om8WAQbGRPECS44gCDMq1FJ752RWbgv5k0CBT/LXH8PZTUBgxAmlVLYd1JdwH3+xfKsgaeHBzBSsHqDkBV4y0MGz+FzPBIJyYYgW3qUIvNBTsGP05zjPE5Q3zRggPcR7u8vKKDY6cY5Jhlqj1mFSgEZW8Q2jvFUlDUnIGPFT4i9K4zysmZnhFHCwpncHrkOCcnHGLA/nEuArdAGh+AOQXJO13BiqIcIFeyp+EVrQlt7eVyITugKdsLD4JKRXUKCCDUJEx//WFPSMKy7ReHmPjBjk7xZ1c2r4LQ1WK7z/CneINMK0wAmgvRk2CH01rQUgJ+FZIsFNA9K6tadw0NkzrbmzlaeE981IyEWMERW7uRZde3bfLUDN4scTkekco6OXzYFbATlSuA5Db9OY0vo96YaHLlzC0xzF4uFZe8CyDvJO2zRqb3P2dimdJSACNFe8G9I9aarA/DAwaLcHRTfFNI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2488.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(4326008)(8676002)(8936002)(82960400001)(66476007)(38100700002)(110136005)(316002)(76116006)(66946007)(54906003)(66556008)(41300700001)(86362001)(36756003)(66446008)(64756008)(5660300002)(478600001)(2616005)(2906002)(6512007)(26005)(6486002)(122000001)(6506007)(71200400001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEwxNnhmTkp3WVovYTkzZUcwS05OSFFic1JBRGwyLzlFcnp5SENzSzRNdm1Y?=
 =?utf-8?B?a0xCd21nWTY0YmlpN3JnYlg0bzEzSnc2d3JxMWZQVkh3YWVMYVUvWlkxeUZo?=
 =?utf-8?B?dzhoMFB0UTJlYUdWNE1nRyttRGRPZTdCaGhNNFJxSUVTaCtjTUEweUFTVnRX?=
 =?utf-8?B?NFVESVlWaStDNTlDa1JQRWp5Nlh4MTcvdkhZa21DNEpXa0ozc3plRWw5QThL?=
 =?utf-8?B?TytXUG9DQlRzeVU5MVRxYzNCdXVNZ1NqREhnT2tudlRZWGJyRjRUMHkrNDNG?=
 =?utf-8?B?WDF0dkhzNE5XMHoyT1V6SW1CU3d5ZGFmNVcrWVpUbEtCWjFHOUF5MkZHOTEz?=
 =?utf-8?B?emxuOUxhSWZFODdnaVlnRXU5T1pRT3JqQmQ3MW9iU2JuWXJDVGhFNWhmcHA4?=
 =?utf-8?B?Sis5cVlnQ21lZEtDUkVmQytIQ1Y5akVRU1VpNXV2NWNmMXA0WFIzQjRSNHVF?=
 =?utf-8?B?ZzlRVTJEOXp2Tktjd3RGRm1zTEtPT3k4ekdsTmpUOUZxUDM5MXNDVDlTU2hC?=
 =?utf-8?B?UTN1YTNZMkhvY2hyWmZJTEVJYVBkb3JXVFg3VTJwbGJPbGpoSDlIVlZFSGtC?=
 =?utf-8?B?eU9SSnJrbC85TzVjUTROWnFPZkQxV3hBTGJTRlZCOUdZZWJSUXB1YzF1c1FU?=
 =?utf-8?B?blBuS1dwSGZrR20vNDJ4UkhLOVJRNDFiQTUxUTFpUVZuVURLMUNTekVBbXo1?=
 =?utf-8?B?Sk9pU3FIcGlNK1pIdkt4RmtTVFJXSGwranJUY2tOU1RGUUhmYzZvSkhqV21u?=
 =?utf-8?B?S013K0ZOaWRRb3FwS0UveThyUTlPdHFINyt5L3E1VzFUUUp0d2dEcCttUkwx?=
 =?utf-8?B?ZGVGNU90UlNCQ2dlY0RUM3dnQU1MNDRFMTN5QmpBbzBmUEtLL2J1QjdIN0cy?=
 =?utf-8?B?clhQL1J6VUZmdzNieElmdEx5MFozSVBCNHBwenVqVUxKNXdPQVpmdnU0eWFx?=
 =?utf-8?B?cUMyZmZUT3g4SnplQ2NjQ1pYMzZKd1p4Qjg4Y3BSWVFJMnlMaFV4YTFOdkRP?=
 =?utf-8?B?MFBCSWIyd1lKa0x5VFBqRzY2dmNUaUo5MXpKNVVDMWR3MEszdmpkL2FSUWU5?=
 =?utf-8?B?akhTcFF5MjNWUWVPZ05SY3FaeGtONUVrd3BTL0JmTysxK0hNZ2xlQWxvbVZh?=
 =?utf-8?B?Mzh2YlZPeDcva09JOU92eCtvbGNZUHZHem53bzRmeU9lclpWMDhLV28wM05n?=
 =?utf-8?B?VW5yMkgyNkFibXJVbjlWYXN2WGJ2WTFYQnR4Nllxai9QVHhVTi9hRlBhSWU0?=
 =?utf-8?B?bzhVR1RxUUUwNyt5YWVQN0FlbzAyai93bGhYU1ZNdElHUXdEYVprNVhTNkt6?=
 =?utf-8?B?TlQzVEFvT3NhSTdSRm9QZ1J6ZGJVUkg5M1NOTW1IVjIxaWJaSFo1cUIrNEpG?=
 =?utf-8?B?NGtmSVh5RGpOSW84SjBBNWxDZ2Fhb0dwMG5TKzVyKzRPWngrUXZSWE1SWGhv?=
 =?utf-8?B?eVNSdjZkT2dFTWljOFd5aDZsNGF3dXl0bXZ5UkptTTJ3ZGo5ZGVzWUZ2TkJo?=
 =?utf-8?B?K1E0NWY4TUFmcVYzb2drWnQrMUFhUU5FSFVCUElROTIyZi9maGJhVldGYmd1?=
 =?utf-8?B?K2NiZjdtdEQ1VXFDdnRyZ01KSEFZQVQyOVEyb1pLTHVtQTdaTzVDbUtKeVNL?=
 =?utf-8?B?V0dScjRNSkNTRTJtSUpScVVUaVdITnRpSW1xZXl1MTBKbmcrWUFrcHBxUlNn?=
 =?utf-8?B?R0gvQkpPU01mWmRDUVluZ2RQRWVnMVpmWjhwalRWNkNOTzZBUjNGNVFlM2w5?=
 =?utf-8?B?dnBybHVYT0pyaHBvNFMxZkdSQW1mMnpjRmd0Q2FxZVlWUXJOUlV6VTZTNU5D?=
 =?utf-8?B?SDhGWHhGUUhmZ0pBR3JkZTNWSmh0UWY3ZHdnc1JqUTdTMGM5QzV6Vmx5b1Q0?=
 =?utf-8?B?T202emlkZWE5OWlNTnhSellieUNkVzhiYktwY3UyZUxNa3RMNHRPbzRTTDJF?=
 =?utf-8?B?c3BScU9TZlZTTU9HbkpaU2NweGdIbzM0eU1mTjBqMDBJZnUwNmNEeWhpMzgv?=
 =?utf-8?B?Sm1WaE1Xd1I5T25ONmlXeEF2V0wvS2lTS1VMSzB5dkNGc1VWTkVBOTdmREY3?=
 =?utf-8?B?RExHWXI4U1pZakRIRHZWUDhIc01ibW5Tcm5kSHVHenQ0eE55Y3hYY2dhVG9D?=
 =?utf-8?B?a2duTGhhMkx6OUQvUVowT1pJLy8xRURXUFQ1Ty9XQnYxVUgrN0JpeU9rS1ly?=
 =?utf-8?B?eWc9PQ==?=
Content-ID: <A27552154E031A48897A750B5791B1BA@namprd13.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NV87Vw99LQeWrxil/6QByg8OXxb2wdoD4bVxbieN1d49UeZPqGxoXQSEeZkOy7YH45AY/HK165KTgtUl9h9Oii+y1RoQYlByYGnSEqknRBs3sXfshMbckZqoIG8gOUtu+O7++A2b0/XAnlExOE59hUzsCLo2S6owkMSoCoCp+6fqcgjN0t8xjMMPLqbmWeTlKL9y0OQvD8eZ+Cw/4A4mwVQ6VNdoBttK/LKbpUgjGjEnThvp34AKVieNwJ5QtFd/SakZ/xt90JnxHzAePnKY+vAuFkOUH1gOq8IMhUocPeFn8rTyEWhl8/N8EBTr1giWTtecgOHJc7ymrO63hkSupKLEzidEdiCUguL2rjXT5pqzja0NQo/IEjWLHy/+EEZpTx2AM4tx7Tg48yYcwjlys3AlJo4CkBFyX/PVtD7p4bMvskJSKg6L3LDSjh7HuRDt5BgmEJt1Rgl+uNwuF7ZbVgx3gRee339Mfk6Is5wSltvwkJ+8zFxeix9g2H/5zLfElupb4oRfbk+cp/NkzlIskZhFMm4boduSqD6zMzteqZiw/z1XHNGapdRI5X/E9H+F0YnoWOpi9jWkoFyQPZy6t7VrGU0lx9LOnc3Ykmlk3mDjMyXtnV5Q9LN1kPzAAZQhfGPovvOBxS4ZUutsNNtNBQ2z6MzHTFOqfcuVh9uo0d1Fohjho0u1TJu4GeOP2cX18X5YFv6E2Oy34ArjIKyAqFupP6JcZrCxdAC0zLiJdTwQRjO+dXrvI0voocTuG9tDHYtEYnOXWbSCpPCspeI1+9xFGdCKBXCr0I6ITBqt1SWWRejIHou5Fzlr80VaEHuI2G6Qu5wdyng91x4oDpdjPqfTGVYNsVCDgT7IvxQyeLBfilZ1i9+Kk6MCj23jyjNB
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2488.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4463ad-3cd9-4e39-8098-08dbf750a8d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 18:16:40.4682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LX3eO/aPKzVYkP+VskE+lZ0hom6L9nKyG3cGl47ysQPxQKzqjVoz+MYjPRaJW9viIui7AAZBqjCScKk/IuI0i01aBi9JeJHJ+u7enhMB+lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4880
X-Proofpoint-ORIG-GUID: HYEG_tNzKM64EGKA5CKSZvOUJ-mZT7GH
X-Proofpoint-GUID: HYEG_tNzKM64EGKA5CKSZvOUJ-mZT7GH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: HYEG_tNzKM64EGKA5CKSZvOUJ-mZT7GH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_15,2023-12-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTEyLTA3IGF0IDE1OjIwICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6DQo+IE9u
IFR1ZSwgMjggTm92IDIwMjMsIFNoYXduIEFuYXN0YXNpbyB3cm90ZToNCj4gDQo+ID4gRnJvbTog
VGltb3RoeSBQZWFyc29uIDx0cGVhcnNvbkByYXB0b3JlbmdpbmVlcmluZy5jb20+DQo+ID4gDQo+
ID4gVGhlIFNvbnkgQ3Jvbm9zIFBsYXRmb3JtIENvbnRyb2xsZXIgQ1BMRCBpcyBhIG11bHRpLXB1
cnBvc2UNCj4gPiBwbGF0Zm9ybQ0KPiA+IGNvbnRyb2xsZXIgdGhhdCBwcm92aWRlcyBib3RoIGEg
d2F0Y2hkb2cgdGltZXIgYW5kIGFuIExFRA0KPiA+IGNvbnRyb2xsZXIgZm9yDQo+ID4gdGhlIFNv
bnkgSW50ZXJhY3RpdmUgRW50ZXJ0YWlubWVudCBDcm9ub3MgeDg2IHNlcnZlciBwbGF0Zm9ybS4g
QXMNCj4gPiBib3RoDQo+ID4gZnVuY3Rpb25zIGFyZSBwcm92aWRlZCBieSB0aGUgc2FtZSBDUExE
LCBhIG11bHRpLWZ1bmN0aW9uIGRldmljZSBpcw0KPiA+IGV4cG9zZWQgYXMgdGhlIHBhcmVudCBv
ZiBib3RoIGZ1bmN0aW9ucy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUaW1vdGh5IFBlYXJz
b24gPHRwZWFyc29uQHJhcHRvcmVuZ2luZWVyaW5nLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBT
aGF3biBBbmFzdGFzaW8gPHNhbmFzdGFzaW9AcmFwdG9yZW5naW5lZXJpbmcuY29tPg0KPiA+IC0t
LQ0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gwqAgLSBDaGFuZ2UgU0lFIHRvIFNvbnkgKFNJRSdz
IHBhcmVudCBjb21wYW55KSB0byBiZSBtb3JlIGNvbnNpc3RlbnQNCj4gPiDCoCB3aXRoIGhvdyBv
dGhlciBzdWJzaWRpYXJpZXMgYXJlIHRyZWF0ZWQgaW4gdGhlIGtlcm5lbA0KPiA+IMKgIC0gRml4
IGJ1aWxkIGlzc3VlIHVuZGVyICFDT05GSUdfT0YgZGlzY292ZXJlZCBieSBrZXJuZWwgdGVzdA0K
PiA+IHJvYm90DQo+IA0KPiBEb2VzIHRoaXMgZHJpdmVyIHdvcmsgd2l0aG91dCBEZXZpY2UgVHJl
ZT8NCj4gDQo+IFdoeSBjYW4ndCB5b3UganVzdCBkcm9wIHRoZSBvZl9tYXRjaF9wdHIoKT8NCj4g
DQo+ID4gwqAgYnkgZ3VhcmRpbmcgZGVmaW5pdGlvbiBvZiBgY3Jvbm9zX2NwbGRfZHRfaWRzYCBh
cyBpcyBkb25lIGluDQo+ID4gb3RoZXINCj4gPiDCoCBkcml2ZXJzLg0KPiA+IA0KPiA+IMKgTUFJ
TlRBSU5FUlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgwqAgNyArDQo+ID4gwqBkcml2ZXJzL21mZC9LY29uZmlnwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDExICsNCj4gPiDCoGRyaXZl
cnMvbWZkL01ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgIDEgKw0KPiA+IMKgZHJpdmVycy9tZmQvc29ueS1jcm9ub3MtY3BsZC5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8IDU5MQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysNCj4gPiDCoGlu
Y2x1ZGUvbGludXgvbWZkL3NvbnkvY3Jvbm9zL2NvcmUuaMKgwqDCoMKgwqAgfMKgIDE3ICsNCj4g
PiDCoGluY2x1ZGUvbGludXgvbWZkL3NvbnkvY3Jvbm9zL3JlZ2lzdGVycy5oIHzCoCA1OSArKysN
Cj4gPiDCoDYgZmlsZXMgY2hhbmdlZCwgNjg2IGluc2VydGlvbnMoKykNCj4gPiDCoGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL21mZC9zb255LWNyb25vcy1jcGxkLmMNCj4gPiDCoGNyZWF0ZSBt
b2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L21mZC9zb255L2Nyb25vcy9jb3JlLmgNCj4gPiDCoGNy
ZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L21mZC9zb255L2Nyb25vcy9yZWdpc3RlcnMu
aA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+ID4g
aW5kZXggNmM0Y2NlNDVhMDlkLi42MjM2ODE4MjY4MjAgMTAwNjQ0DQo+ID4gLS0tIGEvTUFJTlRB
SU5FUlMNCj4gPiArKysgYi9NQUlOVEFJTkVSUw0KPiA+IEBAIC0xOTkzMiw2ICsxOTkzMiwxMyBA
QCBTOsKgwqDCoMKgwqBNYWludGFpbmVkDQo+ID4gwqBGOsKgwqDCoMKgwqBkcml2ZXJzL3NzYi8N
Cj4gPiDCoEY6wqDCoMKgwqDCoGluY2x1ZGUvbGludXgvc3NiLw0KPiA+IA0KPiA+ICtTT05ZIENS
T05PUyBDUExEIERSSVZFUg0KPiA+ICtNOsKgwqDCoMKgwqBHZW9yZ3kgWWFrb3ZsZXYgPEdlb3Jn
eS5ZYWtvdmxldkBzb255LmNvbT4NCj4gDQo+IEFyZSB0aGV5IGF3YXJlIG9mIHRoaXM/DQo+IA0K
PiBUaGV5IGRvIG5vdCBhcHBlYXIgdG8gYmUgaW4gdGhlIHN1Ym1pc3Npb24gcGF0aC4NCg0KSGVs
bG8sDQoNCkknbSBhd2FyZSwganVzdCB3YXRjaGluZyBhbmQgbGVhcm5pbmcuDQoNCj4gDQo+ID4g
K1M6wqDCoMKgwqDCoE1haW50YWluZWQNCjxyZXN0IHNuaXBwZWQ+DQo=
