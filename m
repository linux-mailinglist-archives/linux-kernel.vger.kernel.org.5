Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1718275801F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjGROun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjGROuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:50:39 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32916A4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:50:38 -0700 (PDT)
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 36IAalta032077;
        Tue, 18 Jul 2023 14:50:16 GMT
Received: from eur01-db5-obe.outbound.protection.outlook.com (mail-db5eur01lp2050.outbound.protection.outlook.com [104.47.2.50])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3rwkuf2bm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 14:50:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doNSBVwA+n2RDobVX/KoukkdbckOUOKMbHDjUfr19ia7Gyt/PR91wzWAZ/NhIfFaLkVH1EhgDZk0Wz0ufx0S6+sTHf+mPlersLAd4XAdS3QDdhL/MQ2aXJxYWCCIFoCMn3NWbrXjf64uQGS2LlBb+aRi3gLiHCln9RHEIrk01jXH9PsDufI+NBheMxzCBLADCc/ijqYHktS9nohwAbqDXGbsWibuxqOE0lzxvusF0hdKr6ZXD+tPvcPgPebWh7ea/BRPsGaMdJajlhPe9YdDEJWiwX6KJ3IcqmbF1l1DCs97Ewzhc1VFBylfOhcKCvOHC4sE2z7r0o9RPOUh5XHQWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAeKl1E0tZdICBip/bXZYl5P930x+EXVgz1D+2mFUqc=;
 b=gOnavY8kdybcWU4sBLNoedqgB2+yUqqhpC/fJp9gBO6LIEKXaJJkQBrm5h402mQOIg29JT3ubnGrhfmL5JZZMWJwJCzZk8j+kOHNjX+xfgLfXKjYV3zJ3v//0ydKWKR6QqCvEvYavna2ynM/jkk5idd1yV413sR3/Vn8mufvSbf3hNaJUmxGbG3zN3pYM4MjUB75t4gT8lGXlrPfTR3JBYglr+zXqIn4XsaCQF9EUemR02pMa9ddGNoPIVVYu2uK1IqBzNZtqVIdIM1sqOdE3N/1o2XhYw3HOWpCx86aScuHAjO649gjlXPIMLTdf2ZL52AhYyCULMpK9bup67uQmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAeKl1E0tZdICBip/bXZYl5P930x+EXVgz1D+2mFUqc=;
 b=j9Q4Ia6myi3UUtLY6ZvVLrAQg0IkjcyEfBJxUN2sdsbm7P4uMU++7VDXFzplBXcAPsNWauBobM3nWGpWbjxh3onSYEsgi7BgwfUgMCMwq0+auMurDUcomO8aVFBWFPip7VJT/EN+8II/O1sZznQT2529ZiLH80Bk8P4za+wv/b4SsNc80XXjeQS4oOXHjZZjzrOYHUfyQaAvFYM/mrjkmWY53fvXHym9SAT6uLE//g0nJdyxoXS0Tw0HxXLeiCTitPkrg6dqDKFP+GevyfXvejX47kV/zh9Vl4btcTjU8NVpVElgyfdNGGxcqADGcK/e6mG/KQpE8Mpuks1+HoIrrA==
Received: from AM0PR03MB6100.eurprd03.prod.outlook.com (2603:10a6:208:155::13)
 by VI1PR03MB6253.eurprd03.prod.outlook.com (2603:10a6:800:138::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 14:50:10 +0000
Received: from AM0PR03MB6100.eurprd03.prod.outlook.com
 ([fe80::52c2:88f4:353e:4a44]) by AM0PR03MB6100.eurprd03.prod.outlook.com
 ([fe80::52c2:88f4:353e:4a44%4]) with mapi id 15.20.6588.028; Tue, 18 Jul 2023
 14:50:09 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Rahul Singh <rahul.singh@arm.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jane Malalane <jane.malalane@citrix.com>
Subject: Re: [PATCH v3] xen/evtchn: Introduce new IOCTL to bind static evtchn
Thread-Topic: [PATCH v3] xen/evtchn: Introduce new IOCTL to bind static evtchn
Thread-Index: AQHZuWtmTJj//uCt6EKYgZEjiCdjM6+/m3CA
Date:   Tue, 18 Jul 2023 14:50:09 +0000
Message-ID: <9a917f42-1a22-0c75-459e-db30c17dbe78@epam.com>
References: <ae7329bf1713f83e4aad4f3fa0f316258c40a3e9.1689677042.git.rahul.singh@arm.com>
In-Reply-To: <ae7329bf1713f83e4aad4f3fa0f316258c40a3e9.1689677042.git.rahul.singh@arm.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR03MB6100:EE_|VI1PR03MB6253:EE_
x-ms-office365-filtering-correlation-id: caf38915-d167-4282-cb13-08db879e48a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lUxIn1vmKNbfRKmq4Gr9xIJdAU12jPqg7Oly1myVIU0oDmYNFT6cZze+I8xhiTeuM0iIP72lx1vJtmtm2tXbghxpZrUVdWI2Pe6sfFHPkhrvmdzZ/fbuuyzunZeAf1H4m6tgnsr2rmXaoGLh0gpfuKxXFXWVRDi6gEipwvIDgxoeCkrWEvdzRN5yDQ30EarUEf4z9LmByoWmSP0Jbpy/7IMQhJdzHqbF1bWJ7qSPUb2nckwgK4Ohepsa0s4Wj2MSEY2v7bIrkFeKjbwSzNM+LO4A9R7ZvcdkqEe5+FR3/MVF3u6gzBZjlGGIbZIqlG9mDaZpS5vsmqcgYkfceS+LAVKLpWj/kjlUbaBbztpvZ37hM5kVPc4PZabu7gqpXmGRAWFekLudB0T5uCU2YpIo5g/sBYU2sBW4uPrk2/fr/Zq/Y/xQz4qaC3pHPj1RDZC/c8XDCOMcaEy/inBzk/8CBAfIzfpswITeuI+oiqkpydRDZm9nrZuiZM6W38souAq1FYenesvzkFoJeven1TDIVVz5aiBE4oQVxZHy3pmO6cZxNp5XSvPmrChhPYKzLyVqGjmJ2FX2fcOsh48jkCmQKrG8RMtRvlh0ZcWeErPMOhHol62BbX/jdbEc35KJu8ahgDmAtDyBjQdi21C1IntYxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR03MB6100.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199021)(110136005)(71200400001)(478600001)(6486002)(54906003)(53546011)(186003)(6506007)(6512007)(26005)(2906002)(76116006)(4326008)(316002)(66946007)(66556008)(66446008)(41300700001)(8676002)(36756003)(8936002)(5660300002)(38100700002)(122000001)(64756008)(66476007)(86362001)(31696002)(38070700005)(2616005)(83380400001)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0Fua0VwQ2sxTi80Q1N1RzZGRzUyaHhlWnFFZFl0MnhiV0ZYMkNlRDdxUVpV?=
 =?utf-8?B?TTJHaS81dDdQNDZnQ0U2MnhnU3dnNEZQcFU3K1RjY0kydVBFL1Q3TUJCSUY3?=
 =?utf-8?B?US8wU1ozenN6RjEyWnhjKytBMm41QkNON2x1emZjL2dWZjBPUzBjb0NqUVBF?=
 =?utf-8?B?YWh5OU1oVElDVGhvMmQ2cjFtMUpseVovdUk0SXJDZ2dGckwxdWxGdUhVb0lG?=
 =?utf-8?B?M2pzY0h4WWdyaTFOYUJmc2JKYUNjMWkvYWtLK3FNODkvb0ZtbFhuWDg5OG0x?=
 =?utf-8?B?ZFVjY2FyZGxmNG5GR1J2QWd0TmcxOHhKbkxEYW85U0JWSlkvVkdiNkF6UjhU?=
 =?utf-8?B?QVBIUGxnblY4a1NLMm5zdVhRQVZXa1NFWUF4OUZickNkemI0NmlvUHBMRGJI?=
 =?utf-8?B?ck9uU1pJRnlMRWVrNWszUC9lZUtlUldSNE5yeHlqeVM2Wk5Yci9adEo3bm1z?=
 =?utf-8?B?aGRFK1Z6dWpNMUZBQWwxT0o1Z3Bna2czdlZ3ZG1lNUhrcG9EQmIvWStjc29r?=
 =?utf-8?B?SzZhZHJzRFV6NEV4cER5NHZXMDVGZ2ZYR2hGTVhIQ1l0Y3pVUFYzd2lEekxY?=
 =?utf-8?B?UHpTemdNY2I2QloveFZldm53Y296dTFRQmpTYW5SYVQ3eGRUV2dUQlAwQnI4?=
 =?utf-8?B?VlZqby9DK01iQlh6ejBhdHEwcGVySDVlUkRvZTBWQ3k5M2dzWDgvMmZzRktK?=
 =?utf-8?B?SEFxZk4vdWpCL2puTkRhUHlXVDJNWUVDcWxvMUVycmtlQ0RRZnoxeFREemly?=
 =?utf-8?B?VDJGaVkwcDRscDFINUtneUhxMHdONUFsdndPTW40eXFiM09JUmVMMHF2Nk96?=
 =?utf-8?B?R0ViclQ1SWdFL1c5NURkN050cXRmY2RQZTcxU1F2TWdMeWx3SXI1aGtUb2ds?=
 =?utf-8?B?eUI1dEYyRTB6WGp1WUViK0EzSHhNZ0pxNkk5eVFaRmY2VzRXRU82Mm1UUUxj?=
 =?utf-8?B?R0xHV3NLck0yZzFNdG5GMnRBalRFM2Z3aHA2NmJ2bUpYa3VvQXVCYitHOFcw?=
 =?utf-8?B?SFgyV09jREtoYS9SRVZmR1pCOHdRV2x5OWtVMGxoekdZZkd6R2NaWXNXZ2tU?=
 =?utf-8?B?cnozWE5xSVpmQnM2SytZVkdDcS9uNjlTYWJYckhaMDE5bFV4VFNOUG5mUkE4?=
 =?utf-8?B?MnV1S2I3RmpOb3QxalU3VWpvbEMrZWwyckxKS3o3WGc5QTNKV0hLZEZFNnli?=
 =?utf-8?B?aGh0Ymk2UENyWExLRVNZUG9MNHRkYyt6UW9FTmVTZTQ2VTgrY2l3amc5cGRC?=
 =?utf-8?B?YnlxWm9RVnhseGswRm05ZHJRWS9wdXRRS0JGS05aVWMrNE5BUEpISzFxbkw0?=
 =?utf-8?B?RG5NYW9MbVVoNXI3RXFrZGJQL1VCazBnTDdOWWJTN3hPRTdIVU1RNDVnSEs0?=
 =?utf-8?B?b3VrOEs3VnBtekpta0NkbGsvRzJYeTdsVHhmRGVKQzM1NXVSYlBzSlpLUFc5?=
 =?utf-8?B?SDh5cDdjdENsc2ZFNWE3NDRpcVk3akRWd0dJUnk4UHdsTFJiOW5sR3EyRVB2?=
 =?utf-8?B?TnAxZStvZHpzWGpRTGdySlhOMWZnVDQ5WkFtMlJrSUxEMVR0MmZPZmhmU0xJ?=
 =?utf-8?B?Y0pmN0J1b3BmMC9HQ3Zzem9SU3prRGl3WDMyajg2SHdIR0ZjVVFWUW1tYUc2?=
 =?utf-8?B?SUtGbzBCVnJUNkVzRW1XQTdoZGdEZ1ZpRkw0SEs5NmdSR3hDZG1LeVJYUmgx?=
 =?utf-8?B?WVBJelpxQkdlVFJyRjRXWnloSDRJT3lDRWcxdWcxTmJhOGFtdVRqbytUNFRO?=
 =?utf-8?B?bmtDeWV3MzBvRmpMblRNeTZGSXhwZ0lzMjFIOERnODQvYU5qeC9GRDBCZ09r?=
 =?utf-8?B?L0hUQ0E3a2pZRkFXUGdxVXM3THZHcWp0Rm14bzFGOEZzaHNaNkl6OG1Yd1cz?=
 =?utf-8?B?U2FsYkpDMkYwcXBXQjFHU0FWdjljTS9ORVg5RUFIbGlKbTlGRUM2TXgraHpy?=
 =?utf-8?B?aGpRM2s1M1B2Y0RPdDJlcFk4WkYvdld2YW91OHBwOEJlNWo3RlZFcnM1Ri9t?=
 =?utf-8?B?RFR4d1Y4VGF3RUhpSy9VK0orWlBvUm12aDY3MW4zRG1NdWZROW4rbTdUeEtH?=
 =?utf-8?B?cWQvT3ZFMmRUenM4WnhVR2szeXhpajNYRkszZXVmditqZFE5YjNHeXN3Yk5p?=
 =?utf-8?B?djM1L0V4R2ZkaCtMS2N6Sm5xcmlDZ2NidjhOR3grMGVPcHcyRm80M1d5bktj?=
 =?utf-8?Q?FuaUfqZ9pbbKcZJMom6+Ij4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7198593747993140A9F3BE4C3C1F5528@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB6100.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf38915-d167-4282-cb13-08db879e48a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 14:50:09.5700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LKdTwtwG9Xs+3YlJDAG1cA5rN+9Z2FZOu5yGbjlt62qIJv2gmmzM7492YPta32rsiVht193i2KZdOfeuDRr/buXjEeSRhE7MIy34LdP7Tog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6253
X-Proofpoint-ORIG-GUID: eB1JZC6e361mYFByopMRRHvUpxn0tFKW
X-Proofpoint-GUID: eB1JZC6e361mYFByopMRRHvUpxn0tFKW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_11,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=880 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE4LjA3LjIzIDE0OjMxLCBSYWh1bCBTaW5naCB3cm90ZToNCg0KDQpIZWxsbyBSYWh1
bA0KDQoNCj4gWGVuIDQuMTcgc3VwcG9ydHPCoHRoZSBjcmVhdGlvbiBvZiBzdGF0aWMgZXZ0Y2hu
cy4gVG8gYWxsb3cgdXNlciBzcGFjZQ0KPiBhcHBsaWNhdGlvbiB0byBiaW5kIHN0YXRpYyBldnRj
aG5zIGludHJvZHVjZSBuZXcgaW9jdGwNCj4gIklPQ1RMX0VWVENITl9CSU5EX1NUQVRJQyIuIEV4
aXN0aW5nIElPQ1RMIGRvaW5nIG1vcmUgdGhhbiBiaW5kaW5nDQo+IHRoYXTigJlzIHdoeSB3ZSBu
ZWVkIHRvIGludHJvZHVjZSB0aGUgbmV3IElPQ1RMIHRvIG9ubHkgYmluZCB0aGUgc3RhdGljDQo+
IGV2ZW50IGNoYW5uZWxzLg0KPiANCj4gU3RhdGljIGV2dGNobnMgdG8gYmUgYXZhaWxhYmxlIGZv
ciB1c2UgZHVyaW5nIHRoZSBsaWZldGltZSBvZiB0aGUNCj4gZ3Vlc3QuIFdoZW4gdGhlIGFwcGxp
Y2F0aW9uIGV4aXRzLCBfX3VuYmluZF9mcm9tX2lycSgpIGVuZHMgdXAgYmVpbmcNCj4gY2FsbGVk
IGZyb20gcmVsZWFzZSgpIGZpbGUgb3BlcmF0aW9ucyBiZWNhdXNlIG9mIHRoYXQgc3RhdGljIGV2
dGNobnMNCj4gYXJlIGdldHRpbmcgY2xvc2VkLiBUbyBhdm9pZCBjbG9zaW5nIHRoZSBzdGF0aWMg
ZXZlbnQgY2hhbm5lbCwgYWRkIHRoZQ0KPiBuZXcgYm9vbCB2YXJpYWJsZSAiaXNfc3RhdGljIiBp
biAic3RydWN0IGlycV9pbmZvIiB0byBtYXJrIHRoZSBldmVudA0KPiBjaGFubmVsIHN0YXRpYyB3
aGVuIGNyZWF0aW5nIHRoZSBldmVudCBjaGFubmVsIHRvIGF2b2lkIGNsb3NpbmcgdGhlDQo+IHN0
YXRpYyBldnRjaG4uDQo+IA0KPiBBbHNvLCB0YWtlIHRoaXMgb3Bwb3J0dW5pdHkgdG8gcmVtb3Zl
IHRoZSBvcGVuLWNvZGVkIHZlcnNpb24gb2YgdGhlDQo+IGV2dGNobiBjbG9zZSBpbiBkcml2ZXJz
L3hlbi9ldnRjaG4uYyBmaWxlIGFuZCB1c2UgeGVuX2V2dGNobl9jbG9zZSgpLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogUmFodWwgU2luZ2ggPHJhaHVsLnNpbmdoQGFybS5jb20+DQo+IC0tLQ0KPiB2
MzoNCj4gICAqIFJlbW92ZSB0aGUgb3Blbi1jb2RlZCB2ZXJzaW9uIG9mIHRoZSBldnRjaG4gY2xv
c2UgaW4gZHJpdmVycy94ZW4vZXZ0Y2huLmMNCg0KVGhhbmtzIQ0KDQpMb29rcyBsaWtlIHRoZXJl
IGlzIG9uZSB1bm1lbnRpb25lZCBjaGFuZ2UgaW4gY2hhbmdlLWxvZyBzaW5jZSB2MjoNCiogTWFr
ZSBzdXJlIHRoYXQgZXZ0Y2huIGhhc24ndCBiZWVuIGFkZGVkIHlldCBiZWZvcmUgYmluZGluZyBp
dCBpbiANCmV2dGNobl9pb2N0bCgpOmNhc2UgSU9DVExfRVZUQ0hOX0JJTkRfU1RBVElDDQoNClJl
dmlld2VkLWJ5OiBPbGVrc2FuZHIgVHlzaGNoZW5rbyA8b2xla3NhbmRyX3R5c2hjaGVua29AZXBh
bS5jb20+DQoNCj4gdjI6DQo+ICAgKiBVc2UgYm9vbCBpbiBwbGFjZSB1OCB0byBkZWZpbmUgaXNf
c3RhdGljIHZhcmlhYmxlLg0KPiAgICogQXZvaWQgY2xvc2luZyB0aGUgc3RhdGljIGV2dGNobnMg
aW4gZXJyb3IgcGF0aC4NCj4gLS0tDQoNCltzbmlwXQ==
