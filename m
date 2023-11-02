Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51057DF46D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376694AbjKBN6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjKBN6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:58:03 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8552D111;
        Thu,  2 Nov 2023 06:57:56 -0700 (PDT)
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2A2mY7031524;
        Thu, 2 Nov 2023 13:57:28 GMT
Received: from eur03-dba-obe.outbound.protection.outlook.com (mail-dbaeur03lp2168.outbound.protection.outlook.com [104.47.51.168])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3u416dt202-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 13:57:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5qAHYZ2h2dM/e0bjI5S/gZ3/nT66YO1ift8Ap//ASltPvTY6WeKDvvWZIvKzl6iOCjFJgNOFqcPZab8n3/9GTXmIhf0LBsnVI4qjU4EqfYSstQtU5OxjvKelZwVMLI5XSzllQdykfcDDlO564hIimNcTD78UvIAUSYGmtQuIadIqJXulLz5MyOsqqPHqI1Y7FFdPWcPdOP2bnvN1taim2TlZ/esNm1OD116fYqejajec6v+5JUo12q4wwyamktXVVzkjr/+iYv7bdVJ2jIxvcIEUwioKC4UGoKVGjAsCaIW3VlhbWE/pr652FPfC99uSYQ9L6Nn5KWNQn9aTp5t6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCi7AKelv3oZIK8rFXJ3FBczIZTLSv+VKu8MPxkFf3o=;
 b=CuSlujyVLGb9LXw/PzCVeKfiKIu/BSKzwfUE1q6+slSpSveIYd2bmidGGcNgIRpxh9njhBLHAO5flWCYPzVdDZYR5pb+/F2UmWv5yahZ9twAbwl4ge9k/XgNgTaFC9Gh0jWzy63q0BMdREaIseKWug0vVP+h9EFQEtznyhZq/jJzgZV4r84OdHqnQ/7c8Qx3SHwdATcpuNLVqC7ETIqJCWMQPF8IAGWaEEoQOh/YRsK5kpmZ1L4ELjAA2YptDCGPiPVFEiqZWDPXYh0oBgS9J/qhA0S9LoVWjIXhlUpJ3mu/zBgr2b2s8RCDCvGyHh1RR+2bftB9eGq+J0Zyx5hMYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCi7AKelv3oZIK8rFXJ3FBczIZTLSv+VKu8MPxkFf3o=;
 b=quWFaFjmoE6JJ7N6WL0p6DDGQMXyUG8C4LSlKeJ+Z4Lfe03mbS19+Z+xw9jILsl2RXQXKlqB27jIL5JrXmTqo11TZZCNTHdT12N4jRXyYpO5qlZI/7hLLZ2GEEqkwR7oY3LhyQaYsJGB2xQG99M2adNn0CrCFqopzYuY7E9KvrabV7POzrtMz2+e6nvICLzy6KhA68VL1aiMNBcfw8lpR9ZNwww7rM53/eHRsI2awJBopWSo8uN9QF5m3lE4sw8kIOvrRjCCRUx5qUX9WBXYze4vK361RhDfjkFfrNp6Bsz091tSMmtM2lLG8NZbE4f3J/KH8BafO7r0om7zS1wvrw==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DBAPR03MB6454.eurprd03.prod.outlook.com (2603:10a6:10:19e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 13:57:24 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2211:9053:228e:4e40]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::2211:9053:228e:4e40%3]) with mapi id 15.20.6954.020; Thu, 2 Nov 2023
 13:57:24 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [RFC v5 2/5] drivers: firmware: scmi: Introduce
 scmi_get_max_msg_size function
Thread-Topic: [RFC v5 2/5] drivers: firmware: scmi: Introduce
 scmi_get_max_msg_size function
Thread-Index: AQHaCJ7BGAyc1OF/JE+gASJoTLvwf7Bmq3UAgABsT4A=
Date:   Thu, 2 Nov 2023 13:57:24 +0000
Message-ID: <9c9660c1-ab64-4186-917d-2007d88ce7c7@epam.com>
References: <cover.1698353854.git.oleksii_moisieiev@epam.com>
 <fdfedf6dd0196afd887049877eae9fce0fe63eb2.1698353854.git.oleksii_moisieiev@epam.com>
 <ZUNP6BeUd4Ba_rUp@pluto>
In-Reply-To: <ZUNP6BeUd4Ba_rUp@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|DBAPR03MB6454:EE_
x-ms-office365-filtering-correlation-id: 55673c56-eec7-4ca9-dd9d-08dbdbaba431
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gUWGe4MgyW/JynqvdOikmETuyiF+kueZ+a5Bq8/se+OhT2FqOZVFdzU93C2m413bHtD6chCdUvaLDKgRA1HfAEycqqaNYd+b2Kt4Mlr09XhSEKLsS44a/KdtDvP0+STqFJRQ4TYRBmgo5HbHwryZ1N1aEhyji8DOgfL4Jqnyl/aQY3YZ0YPdmm6oYYn95K0r5hnq7O0YlV9SUw0FcJCFNmYydSZIkqWrG+ibj0se8pqB5gIOUzY7tZX3Dk8ZhR0H4dwGv3IbI1AT6xM+OLlLwmPraDIX9CxQQIupUWygcANmISV7sQ/+a1Dt9AturlgQX/TPFbJWf3uV9sTbCf5CLtp87RBXY1oQLeG3qjhd366uyYEamtu4T7NzIfwS3EvkX0Ph1XQXQpPGHi/1pxPi11e6maKmrVMCBVtM5rXiqjm6v5hjc5G/y6p1NUveYBPP8DbtPUG8LQVnHirD2ONRBxvzRszaF6VXB+05nBpukg3gJJ3lR5l73KuLWNdb/U5BVdzGlACHuHjd2uoeHbv64ZxJcV9jauIRoB3rzdtaRme3peeRPPV2hswaNJGnyO/4tNmA7filKS7BUALgttUMQBI/fq0U2EXaSMDJKYaImCfBZLMqa2tOV+2VG7POvkFwYVSP+H3QSObnxdMHrZ2MrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(8676002)(4326008)(8936002)(83380400001)(31696002)(7416002)(38100700002)(122000001)(86362001)(2906002)(36756003)(5660300002)(41300700001)(31686004)(6486002)(6512007)(71200400001)(38070700009)(478600001)(6506007)(26005)(6916009)(53546011)(66946007)(316002)(2616005)(66476007)(66556008)(66446008)(76116006)(91956017)(64756008)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXBodHJIYUZ5RVRyallCOStxYURpamdEMTd2ZFR5SzIwMmZncnJ1bHVGYUo3?=
 =?utf-8?B?MEV5VENhNkwrVm03aWRJOGxxZTBTeFBReUJBdU85Q3hvYXErWnZ4cjNKcm1O?=
 =?utf-8?B?VXg2M1d3NnB5NXNZelBDTFNLMUhDbmZjenhkbXBZcm5CejlQNTFUWHBtWUJo?=
 =?utf-8?B?Z1QyZVd1QVorY0NTSVRrYXJnVStoNktFUkYrdjU5OXlGR0ZiVkpLSXA4Z0Fu?=
 =?utf-8?B?RWNjRmpDOWpoNFdVaTRGSjdISXRwbCttSjFkanRmR2tvcCtyVUd6UTlmRVJC?=
 =?utf-8?B?V3FheThCRHMvUFVNQ1ovdFg3ZXNxamJsaUx1UDZVcVUzYkhmdGZPbDR1cHJz?=
 =?utf-8?B?amgrZU5UdWdHQ2gwNll5U0M0cDJSS014MnpZM1dteDlZdE9qUHhIN3V4cS9E?=
 =?utf-8?B?T1JsVVJLOEVoSVk0MVd5VkVzakV4YTdlWGJJT2RTT29GQ25qOU5NeDRTQU1k?=
 =?utf-8?B?NjF3bytGaFdpNVlka0hYMlFWSCtpK1VlU0w2M0JUcWNSaTVXMVZHV2dtNUR5?=
 =?utf-8?B?SDBlWHhrK3FobktETFRDb0w4MHBPL1lQSEtwNmdMMXkzTWI0YXlyazlqZmE5?=
 =?utf-8?B?UlM0QXI4bUd6d2p6TXlvVUpUUHl1V2cvR2tmWHhqKzJPM3FhUStndFBUcHpl?=
 =?utf-8?B?YmM3WFVGb3hwTm84T1BnNFRaUmpyTm9pcnpzQlJyS2Z2cC9wUDdrQ3dpZzZI?=
 =?utf-8?B?WWoydTVOT215RGZDb242bEExdVh0QTRHY1pubHBNeWdEYVl3RGJqVVU1Ukwz?=
 =?utf-8?B?anoydzM1Z0RtaGx5RlpacXBJOU5VNit1azNNdHo1dUFBeUJLSWdtbktTRGxP?=
 =?utf-8?B?RmY2R2xPK0w0Z0xJMkZmeEZXb1dQUHNJTURGdThuK1RVU2J4RmRtQlgwMVkw?=
 =?utf-8?B?UUlHUlJtOHVvdlJUaklYVTZhYi83WGZTM0FFQkYzR3Ntc1FFM1lkUCtadnZ0?=
 =?utf-8?B?ZDczVWVHb3NrM0x2dlkwSTJMaFE2dWFuZXVWd0w5MVhRMFVIa3pOZXNGam1Y?=
 =?utf-8?B?dGhFclUzYmRQNkowOTRRSFFDeVNaM0trZVdUenRDSHR0R3BaMUxjTHBmVUJW?=
 =?utf-8?B?T2xONis2bWdMK2NnaUREbXpMcTBvRmNmYXlQaXI0UVF4ZHNtR2lzTU5JUXMy?=
 =?utf-8?B?R2NVdHd1NGhtTVFHdHdCaXVKUk5lWDNQeXhBc2wrd2grYTJvaTBaQm9EaVNC?=
 =?utf-8?B?SlpSVDZEdkRUcTRYVFQvYkgyTlFHYlZ1dnlDTXR5b0pRb2VwUDlRdEVvWWdS?=
 =?utf-8?B?Wk9oZmNoa2o4blBtR1ZUU1ZNY1o5TVZ2M1NOMEE0WUVhQW9UUGY0RUtWdkJB?=
 =?utf-8?B?b1BXSHlEV1krWmlKRWlva284VXB4RGZDU0g3S0VnckthNkN5VW9xWERsYi9u?=
 =?utf-8?B?N3hQcHB6MjF1a0V4bkNFQ05SSEVMamE1ejg4enFrTk5Iak1objJEUlBTbjBh?=
 =?utf-8?B?dmIyOG1pRSsyUjBpcUxGRlZOTk0zZG9QWHF5NXRLdzgrN05FWmxJMHZ3WFVQ?=
 =?utf-8?B?WTRxK2swbkhHRFA4dW55djNBMzZUbFRhTHQxbjlmSmNFWWQyVXJZSnpPajcz?=
 =?utf-8?B?em0rOVVweWZaeEFWN25weFljRFIvclVqNkR5cXU1eWdEbzVEckdxd3NTdy9J?=
 =?utf-8?B?bWE1dDlLdHo2dUV5blVIdUJoYTc5cC90TTc5N3U5RnBySzFuc2hpZy84L1BO?=
 =?utf-8?B?aEdpM002amtLSVFnYkRJRDJhM3pMT3djbEJYRVBacjlCdS9DaWNINWJ4ck9r?=
 =?utf-8?B?MjdVRmFhYXVwanpHOUZxaDBxN0JSVUlXMTNZR1hSLy9UaUlIMlhKUUZCM3pC?=
 =?utf-8?B?eVQwQXRTQnMvYzNENTNzOHJyY2xYckMySE0yYmtVUW5jZTBFTEsxa2VOWlBL?=
 =?utf-8?B?YThKczg4ZHVNeElZaEtZRkFnOUtabDlPN1BtSTBaTjdsRitOOTlpZVNNMzR0?=
 =?utf-8?B?ZEVyU2dPYXV4Z2xYSVdHcGFYOENIMTYvU1Z1V0dNUFovSXRrRnZrYVJoRUJ1?=
 =?utf-8?B?Z1dTU1pxME9GdlBSdDJkMDljZmVCTmcwbmpvdEc3amJVa1lScmxmSlB1Q2tN?=
 =?utf-8?B?dmNFY3ZmbTRIU0RKOVd5SXNZUlZyWHhrekNqSnFyWHpOYmhjSWJvaXZJc3pZ?=
 =?utf-8?B?QlN2amoyVzZnM3VLdjA4aCtPZzZlRk5BREI1T0U4QW1HT2pKWGRXbkVnYlRr?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D98A56FD7952C748909DD6780964EE39@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55673c56-eec7-4ca9-dd9d-08dbdbaba431
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 13:57:24.3195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEm0xtaKjN1Iu8pDlsfQh410mX3xM9nkFUZs7D1/meOxp0/JtNYmcReDQF9e/mEsrdYpShMNWGEmXgSBFQWadSgfOSzHZwDDZsXN8yfplH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6454
X-Proofpoint-GUID: cDYHWupeN6tByZS0V2feuGUfKA44gR4n
X-Proofpoint-ORIG-GUID: cDYHWupeN6tByZS0V2feuGUfKA44gR4n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_04,2023-11-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=480 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ3Jpc3RpYW4sDQoNCkp1c3QgZm91bmQgYW4gaW50ZXJlc3Rpbmcgbm90ZSBpbiB0aGUgUElO
Q1RSTF9DT05GSUdfU0VUIGNvbW1hbmQgDQpkZXNjcmlwdGlvbjoNCg0KVGhlIG1heGltdW0gdmFs
dWUgb2YgdGhpcyBmaWVsZCBpcyBsaW1pdGVkIGJ5DQp0aGUgdHJhbnNwb3J0IHVzZWQuIFRoZSBh
Z2VudCBuZWVkcyB0byBzcGVjaWZ5DQp0aGlzIGZpZWxkIHN1Y2ggdGhhdCB0aGUgZW50aXJlIGNv
bW1hbmQgY2FuIGJlDQphY2NvbW1vZGF0ZWQgd2l0aGluIHRoZSB0cmFuc3BvcnQgY2hvc2VuLg0K
DQpGdXJ0aGVybW9yZSwgSSBvYnNlcnZlZCB0aGUgYWJzZW5jZSBvZiBhIHNraXBfY29uZmlncyBw
YXJhbWV0ZXIuDQoNCiBGcm9tIG15IHVuZGVyc3RhbmRpbmcsIHRoaXMgaW1wbGllcyB0aGF0IHRo
ZSBtYXhpbXVtIG51bWJlciBvZiANCmNvbmZpZ3VyYXRpb25zIHNob3VsZCBub3QgZXhjZWVkIHRo
ZSBtc2dfbWF4X3NpemUgYWxsb3dlZCBieSB0aGUgDQpwcm90b2NvbCwgZW5hYmxpbmcgdGhlIHRy
YW5zbWlzc2lvbiBvZiBvbmx5IG9uZSBtZXNzYWdlIHRvIHRoZSBTQ01JIA0Kc2VydmVyIGF0IGEg
dGltZS4NCg0KR2l2ZW4gdGhpcyBjb25zdHJhaW50LCBpdCBzZWVtcyB3ZSBtaWdodCBub3QgcmVx
dWlyZSBhZGRpdGlvbmFsIGhlbHBlciANCmZ1bmN0aW9ucy4gV2UgY291bGQgcG90ZW50aWFsbHkg
anVzdCB2ZXJpZnkgYWdhaW5zdCBtc2dfbWF4X3NpemUuDQoNCkJlc3QgcmVnYXJkcywNCk9sZWtz
aWkNCg0KT24gMDIuMTEuMjMgMDk6MjksIENyaXN0aWFuIE1hcnVzc2kgd3JvdGU6DQo+IE9uIEZy
aSwgT2N0IDI3LCAyMDIzIGF0IDA2OjI4OjA5QU0gKzAwMDAsIE9sZWtzaWkgTW9pc2llaWV2IHdy
b3RlOg0KPj4gQ3VycmVudCBTQ01JIGltcGxlbWVudGF0aW9uIHN1cHBvcnRzIG9ubHkgcmVjZWl2
aW5nIGFycmF5cyBmcm9tIHRoZQ0KPj4gU0NNSSBzZXJ2ZXIgYW5kIHByb3ZpZGVzIGhlbHBlcnMg
dG8gcHJvY2VzcyByZWNlaXZlZCBkYXRhLiBJdCB1c2VzDQo+PiBtc2dfbWF4X3NpemUgdmFsdWUg
dG8gZGV0ZXJtaW5lIG1heGltdW0gbWVzc2FnZSBzaXplIHRoYXQgY2FuIGJlDQo+PiB0cmFuc21p
dHRlZCB2aWEgc2VsZWN0ZWQgcHJvdG9jb2wuIFdoZW4gc2VuZGluZyBhcnJheXMgdG8gU0NNSSBz
ZXJ2ZXINCj4+IHRoaXMgdmFsdWUgc2hvdWxkIGJlIGNoZWNrZWQgYnkgdGhlIENsaWVudCBkcml2
ZXIgdG8gcHJldmVudA0KPj4gb3ZlcmZsb3dpbmcgcHJvdG9jb2wgYnVmZmVycy4NCj4+IFRoYXQn
cyB3aHkgc2NtaV9nZXRfbWF4X21zZ19zaXplIGNhbGwgd2FzIGludHJvZHVjZWQuDQo+Pg0KPiAN
Cj4gSGkgT2xla3NpaSwNCj4gDQo+IGluZGVlZCBnaXZlbiB0aGUgbmV3IHZhcmlhYmxlIHNpemVk
IHYzLjIgU0NNSSByZXF1ZXN0cyAoaW5zdGVhZCBvZg0KPiByZXNwb25zZXMpIHRoaXMgY29tbW9u
IGhlbHBlciBpcyBub3cgbmVlZGVkIGZvciB0aGUgcHJvdG9jb2xzIHRvIGJlDQo+IGFibGUgdG8g
cHJvcGVybHkgc2l6ZSBhbmQgY2h1bmsgdGhlaXIgY29tbWFuZCByZXF1ZXN0cywgQlVUIHRoaXMg
aXMNCj4gYSBuZXcgY29yZSBoZWxwZXIgdGhhdCBoYXMgcG90ZW50aWFsbHkgdG8gYmUgYXZhaWxh
YmxlIHRvIGFueSBmdXR1cmUNCj4gcHJvdG9jb2wgc28gaXQgaGFzIHRvIGJlIGV4cG9zZWQgYXMg
YSBjb21tb24gaGVscGVycyBpbiBoZWxwZXJzX29wcw0KPiAobGlrZSBpdGVyYXRvcnMgb3IgZXh0
ZW5kZWRfbmFtZSBoZWxwZXJzKSwgaWYgTk9UIHRoaXMgY29tbW9uIG1ldGhvZA0KPiB3b24ndCBi
ZSBhdmFpbGFibGUgdG8gcHJvdG9jb2xzIHdoZW4gY29tcGlsZWQgYXMgZGlzdGluY3QgbG9hZGFi
bGUNCj4gbW9kdWxlcyAodmVuZG9yLW1vZHVsZXMgY2FuIGJlIGRlZmluZWQgYW5kIGJ1aWx0IGFz
IExLTSkNCj4gDQo+IFRoYW5rcywNCj4gQ3Jpc3RpYW4NCj4g
