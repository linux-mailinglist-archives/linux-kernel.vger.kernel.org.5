Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D047DBBA0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjJ3OWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJ3OWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:22:52 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96457B7;
        Mon, 30 Oct 2023 07:22:49 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UDwMIw014831;
        Mon, 30 Oct 2023 14:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=vmFDwy+nqNh8PjpmdrDy8FIKKxCPzondaAMz3LiP9n4=;
 b=L+g2fYrFmuon7tAFIOlZBiX6vlEAheY5oQpMc8U5xTIBf/meuzziYZQNfl1qz4vhlyvd
 YziwQZPV4DsHl7wEH4GjfadfJBYq/KkVKg8/4dig9+GntwBajAa8k0azyXrnwcjIJzmo
 A2GbYBllwV4iJD5GaK1I3mppoarl6URb5+xdobOxWpZrQAxIfUpyuBpd5315c9/pKcHz
 p7uc/r3Eml8OtCE69vRbR3Lz+MJkgcy9HH7+V9A+4PxeFm1dk6/227fEPa1hcihcBdHa
 Z+2vBnOVA/JVMvdRVcQQB/ZMyCEtDk76L7GCo+ZxdpCzOc9agFEOUPs1mn+hgznXbrUf pw== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3u2due0a8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 14:22:40 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 382C480044F;
        Mon, 30 Oct 2023 14:22:39 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 30 Oct 2023 02:22:36 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Mon, 30 Oct 2023 02:22:36 -1200
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 30 Oct 2023 14:22:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJzJV+FcR6G7QcH6pCFzxT8aINK6kSyja8HoSCSfOsIp1rGa/scEMkb4LnnewSP4+l8kkvDb1eNlueMxS73rMbiML6QGnrTlsKqYLGSfGHfHIiV0lISzmSGXf2yeLP16cz0sQCpD61MFXrDFKSq7l6c2Miw91K+i/0shAIJM0NaducwnzXse61q+OlccAMMcnXFkLDquiZ4eFZfhTateF1tFSSj0u0/WVvF/7KLNt80yru8IrV+R2IyzmSOMRRXhTvK3EITSyvN+5Fzg58w7YeFyxzVsXLAOdiXtl8YtPlajv/bT+Te9e+bblGYNDamgdkO/THqfQ/OO9+uToxUUsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmFDwy+nqNh8PjpmdrDy8FIKKxCPzondaAMz3LiP9n4=;
 b=lNizndgMwx5mIBVSkXAYGncd4I+lXyDvvVHmC/1aA+TowmqBLdNrHwbVjg+nI5On7vuD0FIMAz53JU6dcqIdDbwPAdgxcrhdU/7SaIYG8kigSEWwHzlODnIG+yPFkmOiHnuPmMCz1BNHNC7E8AS+qwuJ9cpdqxWraJgK/LFSwSlZmpC7gtuBdo6wQPfSoU7FsTuvxxqDtEHbxGiqnKtvG4VgoD5uevRc4C9nzMfsj+rERVaMLx9pe/4yY8sVwEz2YHM1RvNE/RtkH9VDYzZgIVKFejHZqkGQmz6bzbO8Grww1XccoKxhDzQ6sHyBpnShMrRVoUAtaMXQcX2VZI6YDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 MW4PR84MB1489.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.26; Mon, 30 Oct 2023 14:22:35 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ee7a:9957:c12e:f84a]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ee7a:9957:c12e:f84a%3]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 14:22:35 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     "Kearney, Charles" <charles.kearney@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] ARM: dts: hpe: BUG: Correct GXP register ranges
Thread-Topic: [PATCH v2 1/1] ARM: dts: hpe: BUG: Correct GXP register ranges
Thread-Index: AQHZ69bGNw53IOA9qU+HERmpPih117BiTYyA
Date:   Mon, 30 Oct 2023 14:22:34 +0000
Message-ID: <D17092C0-D3E4-4283-8B51-677C7F1D2069@hpe.com>
References: <20230920152514.3889174-1-charles.kearney@hpe.com>
 <20230920152514.3889174-2-charles.kearney@hpe.com>
In-Reply-To: <20230920152514.3889174-2-charles.kearney@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.78.23100802
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|MW4PR84MB1489:EE_
x-ms-office365-filtering-correlation-id: 7444324a-6aa6-412e-a610-08dbd953a958
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9NJmcWiZxbvz8cjY39P6oUQ1hzabu1mOPaiZj2L/vcHcG2F+sHgpyNknsPCfXU6PVX/xO7d31c39+2VnVd8X7FmkKvVvdK5sAJTic2TBeDbISeuVaQTFvi+z3UmltfHZncusK2hDAPm3DBkC7r8f0T7d+J8EMJNWydHGH7IY9NMfQu6AEU9Jmj98EHmOXKmFDugFvV/LXbO9IQxSrkMeuMevZft8MD6HJfhBdlXWpPRNDdBh7L0L9/ovNiUb33K18WNNiupn2zEI72br2oRkBOiWIQU9GlsNXwNB5oTG+fQZagFn1HX2P2sX3N8oSzRS95GprMJc87UVZHV0aRDjWsKmI1MtwMVzOdoBiksYW32eG4slQ9jRBXB7mwbqnEgO/kQYKyu8/KmHZGEampWh3sf864w8P7p7nNWgTxZTszsJfhjK2KKUWwwkv7fYmzUiUJ40tqThDg/N5jbmRCvaNlzTmF7LP1J/f3Y8a6mrWxNV7C6xNOVGh58/v2xZRLuz2/WW8uvDluukTxXSf9yrJQbRn36LslElrhSPZ6JIs6wh4rQHcAY/P+5l1sbKorsAtVjXlQPS+3fEXLEwf2fB1GetJ4knl11CyHSvZGn0eXZWpOItbb1GWO5eFOuQjs5nI4XVkRvxr5IXTsZdFoqABg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(4744005)(86362001)(33656002)(2906002)(41300700001)(8676002)(8936002)(5660300002)(38070700009)(478600001)(36756003)(6486002)(6512007)(122000001)(38100700002)(6506007)(71200400001)(53546011)(64756008)(66556008)(66476007)(66446008)(110136005)(66946007)(76116006)(82960400001)(2616005)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eS9oUXdnY0lSNUFEZkVBUFE4UkdzRDI2WmxsNGw1QUJMSXA5VHpWblA2UDkx?=
 =?utf-8?B?Y21PamV6cytLMlc2dmp3QXBMZ29PakJnUHNjL0VJVWMyOUJhTEMxUFBtSWpD?=
 =?utf-8?B?NW00VnhPRk84RnJLZTFmeWd4cVdOb2NISEhhTHdNVlI0S1VBWUpjKytOV251?=
 =?utf-8?B?dndyWWdWVDlRczhndWhqcEhPZysweWQ1UC9QWHVZcFZ4SzNUdFV2WGJhYUdh?=
 =?utf-8?B?bko2K1NLTmloWUxnakdSMHVoQ01ZQ3pqV0NIYlY4N05vWlV0emlWZFk0VWx3?=
 =?utf-8?B?d2tQQWIyZmNTNEpOcHVSSmF2MzdvT3pvK2R6b3pMUldOOGlRbHNaVVlaUW16?=
 =?utf-8?B?QUhrVU5kelR0b0tsdFRmZDYwdGFoK0lHMDNiVEc5TmRQaXAzK3p0K05ETnRW?=
 =?utf-8?B?SW5yRmJLeWtTVWkwbFBkTENNWjcvNXZIajRIbHlXcUxlanlPd3FRclhKVjRE?=
 =?utf-8?B?TUIzelZpUUt2Q3dsZG92UHBUTE5kMXlVMjRlZ0txN25NekMvZ3VwUnZjM2Vx?=
 =?utf-8?B?ZnAyejZsUEFNeTlxK3hZczZETGlHT3hZSmVCYmljcEJwOWJsNE43bWs2WG5B?=
 =?utf-8?B?di9vc3hsRlhYNkQ1MWpsVlQxNVI3WmZTUXo0cHJmdzFjRzlZMWJJOWw4a0ZZ?=
 =?utf-8?B?SDhlWHRpNUZCVFc3aURIMUJrT2U1amM4YzU4QTRTR2NLcU9vL3FDVjRrb0Ja?=
 =?utf-8?B?TW9peW9YSUV2aVR5UG15bGNjQTdGYXJaa2VlQjlQNjBnYzkvdTM4dXBtZUhF?=
 =?utf-8?B?QTZkZUxxNkRHYWtjTnVCakJkMjBKOVZOQ291enRTS1pHenRiS1pTaGlqL2th?=
 =?utf-8?B?WDV1MG5tQmFyY1dRVVlSeEUwSkRoNHVpeTVINXNiR3BDbTM3NEJnUXkyTE1G?=
 =?utf-8?B?dUpzbFVUci9kdndtZjF4T1k4R0dWRGZXMFJPb3lGNE85T1pIYzJ6OVpLaWxh?=
 =?utf-8?B?TnVBYWMwNVJaT1VBNU5qVjJrWmNQcm9hclRxYmh0THM1eUdKQmEzSnhYNHdp?=
 =?utf-8?B?dS9EVWhLdUh4MSsvS3Y5dmx1Vzd5ZThER2drdFc4SHlxNjFkSWh5Q0JNZk4r?=
 =?utf-8?B?R2x5T2g2MWZEcThOTUdWNEc1RHk5OXFTMng0c3FlVzJBSXpZUUYzejZnRkNa?=
 =?utf-8?B?TlVDT1RxaTBjNjVuVEI5cXBiOXhIV0N5bmVYSU44NzRlWmVMbkZYMTlGOG9s?=
 =?utf-8?B?a0NOUWlTTURxTVJwVzRRcVFET28rd0xXR2I5WTJnMWVCbG83OGJHV3hIc05q?=
 =?utf-8?B?TzNPMlZMLzRxalpSVW95bVFCLzlWNHo4WUhwWVFpb2xPSFFycm1nQUlnM2VY?=
 =?utf-8?B?cHdBbmpuUERTVk9TN3VGSW1BRjU5NlBWclU3TVhzcUZ5WEpuZzhXL1R1djN6?=
 =?utf-8?B?WHRzTFBMR2RDaldlRVZaeUd1bXZGN0x6MW4wMVgwUERUZWdDWEhWKy9UdEtM?=
 =?utf-8?B?MndrSm5UMnEyZ3VVR0g4NGRzZVh0dm91QmpRdmxKM3RVYnZoRVY4emU0aklQ?=
 =?utf-8?B?c0xISTQvb3dXZGcrTVh6bm9RVGMxOVJBbDMxZmtxeUVTbnhVT25tdGNENlBk?=
 =?utf-8?B?eUx5NlZuOGQweGVULy9GeHJ5dm9sbXpRRzdreWI1K0ZrUXVtU2dJeGEySS9F?=
 =?utf-8?B?elpXZ2N4dEl6N3ltdUV0WkJSb3dnSTNNM1gyYnBMaHpUSDVGYVVyS1JqK2Zo?=
 =?utf-8?B?NzcwQ0ovY3B4UU5DVGN0aHQ2enpqY2NWbmRzSTlrVGdEcENSdzBmbFhKa2g2?=
 =?utf-8?B?bExxSkh5dVdFc0JvZStiRW8vVTg2RkFFdXY1K0NlRGlzNWZaUkFRSFo2MVUr?=
 =?utf-8?B?Z0x3Zk1BQTZJQUs5cHhzL05jc0VETjYyWXdSVFBqN1RKVE5ONkJoY1piYzhp?=
 =?utf-8?B?Rzl3bitmb0VYNndLQ2dKYk03TWxobWpwVFhkZ2ZCcjFFWmc0ZXVoekQwdzZt?=
 =?utf-8?B?aEczd3dubEk5bGxXYllPcFpzR1E5WVgrZWdBdXBWVC91djRTbFRSak5jZnRZ?=
 =?utf-8?B?WUtmODJiZkRlREZFd01USERXbllqYVlMaXgxc29vS0x0SEFOcHZ1cDFXejl6?=
 =?utf-8?B?YTR3bHE4NFB1OWRJRW1zOGkxLzc1VGFVUGt6R1haVFduUXhmS3hBWXFtSjY2?=
 =?utf-8?B?WENjUlF0ajBjRW84b1p6S083Qm14dUk1aTV5TEVyS24yb3JuRDBndnZrOVg5?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F94D60FF145C24AB9DEAF15442F1F79@NAMPRD84.PROD.OUTLOOK.COM>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7444324a-6aa6-412e-a610-08dbd953a958
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 14:22:34.9603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: StQ7wYVE2nFLw/STwfCpABXt7UPHf14p2ihg6v7Qg2R3e2h4TYEh3+n7X536ASmK7+w497/AMDY33Sj56EX6BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1489
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: CYeX_9H5ewH53Aq5QIblXx61FzeCHlav
X-Proofpoint-ORIG-GUID: CYeX_9H5ewH53Aq5QIblXx61FzeCHlav
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=679 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1011 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300110
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8yMC8yMywgMTA6MjYgQU0sICJLZWFybmV5LCBDaGFybGVzIiA8Y2hhcmxlcy5rZWFybmV5
QGhwZS5jb20gPG1haWx0bzpjaGFybGVzLmtlYXJuZXlAaHBlLmNvbT4+IHdyb3RlOg0KPiBGcm9t
OiBDaGFybGVzIEtlYXJuZXkgPGNoYXJsZXMua2Vhcm5leUBocGUuY29tIDxtYWlsdG86Y2hhcmxl
cy5rZWFybmV5QGhwZS5jb20+Pg0KDQoNCj4gQnVnIGZpeCB0byBjb3JyZWN0IG1lbW9yeSByYW5n
ZXMgb24gR1hQIHRvIGluY2x1ZGUgaG9zdCByZWdpc3RlcnMuIFRoaXMgDQo+IGNvcnJlY3RzIGEg
aXNzdWUgd2hlcmUgdGhlIGhvc3QgaW50ZXJydXB0IGNvbnRyb2xsZXIgaXMgbm90IGF2YWlsYWJs
ZS4NCg0KDQo+IEZpeGVzOiA1MzY1OGRlNGZhZGIgQVJNOiBkdHM6IEludHJvZHVjZSBIUEUgR1hQ
IERldmljZSB0cmVlDQoNCg0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFybGVzIEtlYXJuZXkgPGNoYXJs
ZXMua2Vhcm5leUBocGUuY29tIDxtYWlsdG86Y2hhcmxlcy5rZWFybmV5QGhwZS5jb20+Pg0KDQpS
ZXZpZXdlZC1ieTogTmljayBIYXdraW5zIDxuaWNrLmhhd2tpbnNAaHBlLmNvbT4NCg0KVGhhbmtz
IGZvciBhZGRyZXNzaW5nIHRoaXMgaXNzdWUuDQoNCi1OaWNrDQoNCg==
