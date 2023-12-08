Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA61809F20
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjLHJUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjLHJUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:20:32 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BA91716;
        Fri,  8 Dec 2023 01:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1702027239; x=1733563239;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jsHqDmzYDRAxZzOKuc948HTEFP1zY6edqkrFeGz882A=;
  b=ZO+AwQ9RKppgpLOzoSLt4Hy0f2+MEY4CoDZoWOlrTgf2uuw3Rvo6UeSm
   Vo54tth4kfSSSdlc/e4KEhRNhpCYJQzjWggJN7rGO1T3M9ICsq1eTbzhz
   n4GvXF31z9m4FreGHaNzfdidiLoDPX1DWAdf/8qT6Q7cqbMVfx2L4daJd
   tlv/Rkt2c9XCXdVcp3htF9/HcrUCOfm6dzUQ10geeDfvmVBXrsSThTRwq
   H6VcdW/DwOCPKIpiFDiAhCTtA34gJ4K0dKSSuwC6PKzmARYz4CQjW5MGt
   T7i+PlPyFDxRQ0SBp6qmRJZFLJRArAtMZj91gl4mUV8fXjrvN+m0bxk+r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="108804098"
X-IronPort-AV: E=Sophos;i="6.04,260,1695654000"; 
   d="scan'208";a="108804098"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 18:20:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6PdInf+vxFhtENo1YdWn4KZ9fDPI5amm7vdx/Fyjui8QNJEs3xUszdiGNhpGEAJZqpUAWMQhNSURIa1MXsDRKPIy3p/S9YbtsRTpmqQlUO8aJggOQ2kRxFrOutdnwhAFj7ohk375hbjOOZGxue8nDbmZPyxgmBzCykh1cQZQZmxZEvtWZptW+pXqM4MW+A9eLImb5UM8MPBRG4niko4ArtLVHQPNjpIuwP0mQsUtMxsN+T0wEqY2ELRzwR0XuM5rab7PdPjgy/civSYZEtMUlHSuzkxaEol/kLAHKSC9vXs0C1+/lsvjfoTv86CHIfCrkeiNdkbneqbyjJkx6sfTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsHqDmzYDRAxZzOKuc948HTEFP1zY6edqkrFeGz882A=;
 b=Eq7O6D7DG2M0cWo1C4+hUNPoltN3h5Y25vAqoSauGh1H2zsPfnf9s8JPOD250r6gP9CPTQHN82pbLSH1HWrdexOFlgQRW2xw4U/DLE+GRL1uP11PD6RChTPi6GLkW3Zt8NcpzdevOEOuQfrkYeagI1+vT+f5e+amGblHBF5okcw3Ws0QvsTMxTe2cALjIhw0dRK8qXGX+bPfYq5hsm2qofoYZ3jWQMkVTuZfLTHQWruNUj3tGxdjAVGv9cvFJIreJNzfi44JlKq1MS+WZzbLYIV/WcofVYp+HaoDyAN3aIoOJxGS2sNKeLfpyY0d4gCkBWlAaavHMySwBC90i3m/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by OS3PR01MB5704.jpnprd01.prod.outlook.com (2603:1096:604:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.15; Fri, 8 Dec
 2023 09:20:31 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50%6]) with mapi id 15.20.7091.017; Fri, 8 Dec 2023
 09:20:31 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v2 2/2] dax: add a sysfs knob to control memmap_on_memory
 behavior
Thread-Topic: [PATCH v2 2/2] dax: add a sysfs knob to control memmap_on_memory
 behavior
Thread-Index: AQHaKMb1Ze8I+hDKSk6AX1Jl5zz+7bCdfY0AgAC3NgCAAOlBgA==
Date:   Fri, 8 Dec 2023 09:20:31 +0000
Message-ID: <ad95e550-cdb3-448f-beb1-fc4899053639@fujitsu.com>
References: <20231206-vv-dax_abi-v2-0-f4f4f2336d08@intel.com>
 <20231206-vv-dax_abi-v2-2-f4f4f2336d08@intel.com>
 <4b1a415e-6a56-455a-a843-277cc08d05a9@fujitsu.com>
 <96a55ffddd8f6a00ff00e6a67e50d30129ae2456.camel@intel.com>
In-Reply-To: <96a55ffddd8f6a00ff00e6a67e50d30129ae2456.camel@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|OS3PR01MB5704:EE_
x-ms-office365-filtering-correlation-id: 57dd1238-7a16-4068-1a0c-08dbf7ceecda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PWjX1Z4nLsBdShRdFnRjjkO3iCqH4ClBMa3XMRmkxzZ4lA5pC3ICetn3N6sW/1BUTCauFdAVLBxpo0SPcymZ4Z1uYHb4Ync/tbyc/fkQ3P6+Kh4X8S6NCx8+vI7Y95A4j9qF4zMeZYe+fajwOvwxb5wOj3jlJ2QeuoMbzPWEgOt1oaFxPrIR2r4jgA1zggEf+hDtnVBVomdLkmhpjv6XvYkhYBy/kF7k0UclEaEC8bRCK1JyzSE8Hn2UOdoa5Hc2jHA/p58rxpj1+TdbGjjkqOHldF6OeQOLZAP/DJfJ8XG6kqpFfAm9qCUlYy+5bBT/EXGQxZkAiH5F91QsGWjS9BF4sRzIdTLtxGDk9Jo6meokjVfdOfefYK3K19m1GjBGt98oWhvQLucDroKvseVUL86q16MOeQN92Q421pkOW1nIMr0qtxDCDbEa2svvzz4iuxtQE84ik/xTjqhpAnQ1iA/X9s0RBdvOVEtmMIs98uhP4hWMPbOSzCHn1DG7h3hZFWut1oo7SEF5+XbGUiftMsAu+7oCqaPLoLrobC0cc1N8n+IKgIy/PCpoUL5x1KZeM0WvrSbz2v5DjtHSsTFHnhIUehkCtQ3Opi6DnManAft+Ln/S+scQ2oijIw19AQqbQLFZmC5hqz6/y6KuYlUva8/x+QQkulAYgp+UFSMR3RiFPGf8GzJNQtn4WoBuLLzK1bgMucckoU/WoHGrlgN3oA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(1590799021)(91956017)(64756008)(66556008)(54906003)(76116006)(66946007)(8676002)(4326008)(66446008)(66476007)(316002)(1580799018)(8936002)(110136005)(6486002)(478600001)(71200400001)(7416002)(5660300002)(36756003)(41300700001)(38070700009)(2906002)(31696002)(86362001)(122000001)(85182001)(38100700002)(6512007)(31686004)(2616005)(6506007)(53546011)(82960400001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHJzaGxjbmZhZFpiUE10cWRIMU9ENWx0TUI2bUIzRUpEQ0xWZHFyV0FHQU4x?=
 =?utf-8?B?MCtCTzdqZU80bmhBcUhhSUJCR0RweUpmWkNieFR5VytBUGFYU1haSzVYeFBl?=
 =?utf-8?B?a0hzM24rR2dybHZBY0prdWNNMEdlT01SS2NxTkRzRHYvenFxNDBObDhBMEZU?=
 =?utf-8?B?VC9JclpSVEtlSVRiQVYvYVd5ZmFHS2o3UTRJZzFQOE4xMTdkWEdZQlVhK2t1?=
 =?utf-8?B?dUJsY1ZlRHJTMEozSHdjZUFwZ0Y0TUdoK2NWOHNpYW0zREs5Wk9NTk9TbkxI?=
 =?utf-8?B?eitLbVVzeHVUNTZZaTFVOTYzMkdkRFpITnhraXpway91dmRFamYyaWhSTGNs?=
 =?utf-8?B?cTB5VlRMU0h3dVMzWUlyNWxWM0hkb0lzVjZoVmwvVjRWWksxSGJidGE4dEpT?=
 =?utf-8?B?a2JGbHpGL0ltWmVlWnlRYm5YeW40aFVXQmhmMU9JZlptbnN1REF1UlpHS3ZW?=
 =?utf-8?B?amc0aU5PQWRJSEN0THBWS1BvWTJ5ZlVOcDd1K1pTVlJ4UStvTEdDL2JCRm5C?=
 =?utf-8?B?QXdpR1AySGRKVFpQWnhnK1duSlVmZjExcDNvdWNlWTQwblE2ZkxicGJIbGRu?=
 =?utf-8?B?d0krK2E3RERGKzE1UWR4NXhtZUVyeHNiVW9iNVk0eFZ0NmtaVWNITkN6MTl1?=
 =?utf-8?B?dTkzOWZTUEhOYVg1ZEJHOFpsclRDY3RiVzRTOUV2R0plMVg1NXQ4eGRrMkpk?=
 =?utf-8?B?VkFlRVp2MkRTSHVNRFFJL2lVVTBzV0NnWHdZcTZSdWZMbVJVSUl6d3lpWkdp?=
 =?utf-8?B?cnhjYWVmSEJ1cmo1Tk1oSjZUeFhkYkk1NGlDZ0lpZncvdmZLTEl5WGdrSnp3?=
 =?utf-8?B?MnpadkRXbCt6anZMQ1NuTzJJSGJEYjJzNXNTdlNEMnpheTRVU2RNaTh5ZDBX?=
 =?utf-8?B?aU4rUkd6QTZabzhRQUlma3RoVVJOMGVoc1FlMkRTQUJGV1lsT3lvU0NCSURm?=
 =?utf-8?B?VWhBbjhrM2M2cFd4Ty9iMG9Vd2FhNzBReHNIVWVrSC9sdVJJVXg4Q2xTYzNM?=
 =?utf-8?B?RkpIUjlVcHkreThPdW1acER4NS9tSlMxb0ovZ2hxd1A1WW5XNzMxc09ReWNG?=
 =?utf-8?B?TkVucUdRV050aWU5VUN6VE43aG15WDcyOXk3eSs0eEY2YUI3ZE5tQ2VHbjV6?=
 =?utf-8?B?bVg5MzRQMnB0cXJqWHk4TDF2NlRtYjZENmkwTGkyUVpxa1ExL1BuWVd6YXhI?=
 =?utf-8?B?YXphU21jSlRjQ29CME1HVlhyMFU0clA3Z2gvQm4vVnIrOE9xa3ZTb213R1hn?=
 =?utf-8?B?WUxmK09YKzVldDJady9jaExmWEVSczAxZkJFZUNSamkzaUZiRUY0bFRIN1Zo?=
 =?utf-8?B?TDFqQ1Rxdm1BNVFWdTdqYklKRkE5eFZISHY3d0lrY21yMEx4bUxBalMzaHZl?=
 =?utf-8?B?L1NlRlFoaUpDN3BEeWxxVFJZTDNOUDV4UDBnNjRJVVVFTDNHN2JHL1pqa0FX?=
 =?utf-8?B?OFdmTEhaditVNzVkc2pnQ0tHcERJSnBLUHNPUG12MTN0VDI1d0V5MURIVjJz?=
 =?utf-8?B?L0VXOXBTTEhDNDdnc2poOEVPWW5xYjFUSzFWMHNHeG93eWxDR0w5WWxFNUVK?=
 =?utf-8?B?Q0J5emlQRzVQV0R2RS9VZVB6a3h1SWdiTkE3M0JoNWRjai94WEVNaTFSbnJG?=
 =?utf-8?B?VWtYVGpJbVRicTJnMlJNelZCZzRLZkJzcHFjbGVUTTFJNDZmWnpjd011NGFJ?=
 =?utf-8?B?eUNZQkZWMjNJMmtDQk1iWFB3d01xYldnYXZ1YUZ5TnE3UUtwbTBpMGRmNnVu?=
 =?utf-8?B?WUFpZnhXSFFXTTdTRDlwNURvTkJNRDRHUTZCRGMzMm4xbGJXaCsreTc1NTZi?=
 =?utf-8?B?ZVFkMlVNSHZKTVpINEppQUFQa3Yxb3kzVHQzZlNxYzFHZ1MyT3JyN2lRUHBq?=
 =?utf-8?B?S3kwTlQvTnE1TDhBUjVvN2VwYkloYzZjcy9POFg1ZWlMMXRURXU1MzFQNVFY?=
 =?utf-8?B?YUt3LzFxWlMxeFVwRE8vM0VpTGdPL2RKdmFqK2dkbmVRTndYaFREQ0dtazgx?=
 =?utf-8?B?SjNkYlhNaGtqZXIwMDdBVlArZjBhQTBEcVF4NjhZRko0SkM3M2t2elRsYW5N?=
 =?utf-8?B?ay9OY2U0YjhVZUJGY1Z0cy9QT205RnRxdGxIcGVydURCSEh5M1JXa0JtNVIv?=
 =?utf-8?B?Z2JtQlR2QUY5TENHTHkxckJ0cmJvM1RNZGhEd0QvcTdrQko3a0M0Z3ZicGNU?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F95B453A0E5D44CAD41AECE5BCA1114@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rEl0z6MnluuH68dRK/RdFHZOBrBnU/p6p07eMKDY7xqxhfvjsnpHvti1ddpkxf7kLGlpnO4Sb6z4/+btrc9qMMy7BdvhBeXycDIaq3xd5DvsxqdURLccEjE6428cdC+d7Q2KOKpLYqkCV4L+C+FdsXgWjoNuoc304UczqkHQWiolNpPMpBmMUaCWMh/KHEI9CgSPaXVSv1ywY6FXCSRdfvUSb29dqqQc0JWpJO71kePGwneu93rpjZhWLst0zZGBSse5QVqwkVeSMi029ALO1Y7lYI8LOPfvmIoaeUthI31oVaaNaINR6ka6BdC0FH4D5dC0G2wSucYqnVe7OsYcH/1D+976utTOemVqaLeJkjvB1fxBSSoL2g/Y2NTFNhw6WmOD5xoFi1WqspBAcMqt44Ycs32qsMGC1etkACp++lj5gmoRbkIbOL5clc1TL+aOxZQr4Wn1YvtHnUEB68pXWm8rQduB7Zfb+teYePFSfP17oik3s6wVi8qwNU9rmm4wcZMKhleabO++A6TUabI0IO/nPUDzaAHWg82AAA2ujPjOcZzv0/i82h8XH7/C+s12YGBu20IP966Vz3K7C6lTS/J6wDrys1jcaXGg/I501C1Jlhxze+g0/NV5XjGqxrra
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57dd1238-7a16-4068-1a0c-08dbf7ceecda
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 09:20:31.1643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P9dh0i5eZ1J4SgPFTgvWYLesAdoE6fIoDCvQ3JtMAGA6NzBWfCoKANAx3sva5qc1OY/GPGHwZbUB+B0qSdBKwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5704
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzEyLzIwMjMgMDM6MjUsIFZlcm1hLCBWaXNoYWwgTCB3cm90ZToNCj4gT24gVGh1
LCAyMDIzLTEyLTA3IGF0IDA4OjI5ICswMDAwLCBaaGlqaWFuIExpIChGdWppdHN1KSB3cm90ZToN
Cj4+IEhpIFZpc2hhbCwNCj4+DQo+Pg0KPj4gT24gMDcvMTIvMjAyMyAxMjozNiwgVmlzaGFsIFZl
cm1hIHdyb3RlOg0KPj4+ICsNCj4+PiArV2hhdDrCoMKgwqDCoMKgwqDCoMKgwqDCoC9zeXMvYnVz
L2RheC9kZXZpY2VzL2RheFguWS9tZW1tYXBfb25fbWVtb3J5DQo+Pj4gK0RhdGU6wqDCoMKgwqDC
oMKgwqDCoMKgwqBPY3RvYmVyLCAyMDIzDQo+Pj4gK0tlcm5lbFZlcnNpb246wqB2Ni44DQo+Pj4g
K0NvbnRhY3Q6wqDCoMKgwqDCoMKgwqBudmRpbW1AbGlzdHMubGludXguZGV2DQo+Pj4gK0Rlc2Ny
aXB0aW9uOg0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAoUlcpIENvbnRyb2wg
dGhlIG1lbW1hcF9vbl9tZW1vcnkgc2V0dGluZyBpZiB0aGUgZGF4IGRldmljZQ0KPj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB3ZXJlIHRvIGJlIGhvdHBsdWdnZWQgYXMgc3lzdGVt
IG1lbW9yeS4gVGhpcyBkZXRlcm1pbmVzIHdoZXRoZXINCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgdGhlICdhbHRtYXAnIGZvciB0aGUgaG90cGx1Z2dlZCBtZW1vcnkgd2lsbCBi
ZSBwbGFjZWQgb24gdGhlDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldmlj
ZSBiZWluZyBob3RwbHVnZ2VkIChtZW1tYXBfb24rbWVtb3J5PTEpIG9yIGlmIGl0IHdpbGwgYmUN
Cj4+DQo+PiBzL21lbW1hcF9vbittZW1vcnk9MS9tZW1tYXBfb25fbWVtb3J5PTENCj4gDQo+IFRo
YW5rcywgd2lsbCBmaXguDQo+Pg0KPj4NCj4+IEkgaGF2ZSBhIHF1ZXN0aW9uIGhlcmUNCj4+DQo+
PiBXaGF0IHJlbGF0aW9uc2hpcCBhYm91dCBtZW1tYXBfb25fbWVtb3J5IGFuZCAnbmRjdGwtY3Jl
YXRlLW5hbWVzcGFjZQ0KPj4gLU0nIG9wdGlvbiB3aGljaA0KPj4gc3BlY2lmaWVzIHdoZXJlIGlz
IHRoZSB2bWVtbWFwIGJhY2tlZCBtZW1vcnkuDQo+PiBJJ20gY29uZnVzZWQgdGhhdCBtZW1tYXBf
b25fbWVtb3J5PTEgYW5kICctTSBkZXYnIGFyZSB0aGUgc2FtZSBmb3INCj4+IG52ZGltbSBkZXZk
YXggbW9kZSA/DQo+Pg0KPiBUaGUgbWFpbiBkaWZmZXJlbmNlIGlzIHRoYXQgbWVtb3J5IHRoYXQg
Y29tZXMgZnJvbSBub24tbnZkaW1tIHNvdXJjZXMsDQo+IHN1Y2ggYXMgaG1lbSwgb3IgY3hsLCBk
b2Vzbid0IGhhdmUgYSBjaGFuY2UgdG8gc2V0IHVwIHRoZSBhbHRtYXBzIGFzDQo+IHBtZW0gY2Fu
IHdpdGggJy1NIGRldicuIEZvciB0aGVzZSwgbWVtbWFwX29uX21lbW9yeSBkb2VzIHRoaXMgYXMg
cGFydA0KPiBvZiB0aGUgbWVtb3J5IGhvdHBsdWcuDQoNClRoYW5rcyBmb3IgeW91ciBleHBsYW5h
dGlvbi4NCihJIHdyb25nbHkgdGhvdWdodCBudmRpbW0ua21lbSB3YXMgYWxzbyBjb250cm9sbGVk
IGJ5ICctTSBkZXYnIGJlZm9yZSkNCg0KZmVlbCBmcmVlIGFkZDoNClRlc3RlZC1ieTogTGkgWmhp
amlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg==
