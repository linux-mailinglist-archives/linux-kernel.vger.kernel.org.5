Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C621B8098F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572943AbjLHCED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHCEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:04:00 -0500
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E9110EB;
        Thu,  7 Dec 2023 18:04:06 -0800 (PST)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B81K39q005353;
        Fri, 8 Dec 2023 02:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=0EZ5xZyv4xgyu4qjkTIj4sDXhCqdfZGtOh0PiMT8e9w=; b=
        hyzk2/4fPFXTcTPZliYrWhiU772HPlNFT4+shBeYGak1ImoAb6lYTWT4DnOtctjS
        0bcgcFDiVhTi3XVVHEU6iMiMQ+4mgCpTasjEKB2lDIVvezrls1aWPXnclnX8iTif
        B3jhOuygJSM8NBIXmGpWdZP514a1kHWxrKIs17FOTVnzoMEefHjsjIhPuQQBcb4a
        r5ucvHUn1EZYMWUDzEH6dBi6E1qa2nMfGuFOMObw2CjE/dFgsp+1XJnha7j/Rt3+
        8FI7hjZgiVqle47TwBGV6A0+DVIYH+kDJ6MGkAkqg8zmlPFUCcOQSAyFKYuuRVB4
        fNyWxuf6KDyZ9ZfXblKfag==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3utd53tc82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Dec 2023 02:03:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glYzXWSpBPhTziF+tQYv/jus4doijx7pgR50GMAIZlCsyEfWYF26YtdmGVwVmwwAjfJrlsrMcCYsnnsX7+RFCDx+xmG79/klx2V3CFQgS5wtJ3ohsPo3SzCt9dJ8KwKfBpRoFp67rGXOSQCAwyaD7CrIGDwdhNde4JgDyrjxzzggymMSJMHH0AjaRY1xRo34AzLquLEO7DODQOZ35RMDpHOExQJyzcAO3rgX16lWu4m09feiZU8DstEE80IV6WvF5lp41vNJ3pPyOWul8OKRiaYHZ8SYCXuk1Y51YZF56s5unNGYQxlV7dsWLBBlMVoUOTXHekguXMgRb7YgAEnlQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EZ5xZyv4xgyu4qjkTIj4sDXhCqdfZGtOh0PiMT8e9w=;
 b=N8dAzmrv7CVbiau/gTJlDlTFts2bt5rwg0N1wXAxxg1FcjQDcGlIsMkW1UK29M2b1CfDkW5V3EIuVsac2njvdoPH9ursZ/N3gP2AY19nRw4QaWLRR+Y5GvmpGs2DyYApbAPLXZB3KakN2icvP+pDNIA6r5YhGe1zBpOWZFqo+rR3G05bUtfTxWuhSGsjdWkCmxGC+7gSX8F9irYNZoiR6j0R6fRtZlGcuNhn/23onKseoBUMmG+fQ+Sipx3IqnovTZ2pU/IE00LXtCdmr0EUWB3fsxE2XmYLyi4bhsQb3MtS+CAqx3gHfDLSMAv1ZynIWsMSwjw1XZRQP6huT1BzRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by CO1PR11MB4772.namprd11.prod.outlook.com (2603:10b6:303:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 02:03:32 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::928a:7606:e525:8b91]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::928a:7606:e525:8b91%6]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 02:03:32 +0000
From:   "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        "sxwjean@me.com" <sxwjean@me.com>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/3] supplement of slab allocator removal
Thread-Topic: [PATCH v2 0/3] supplement of slab allocator removal
Thread-Index: AQHaJX354XOJH8BfT0y5plIKLnMp37Ccc0SAgAI3GkA=
Date:   Fri, 8 Dec 2023 02:03:32 +0000
Message-ID: <PH0PR11MB51924FB2FEE2155059FFC989EC8AA@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20231203001501.126339-1-sxwjean@me.com>
 <457899ac-baab-e976-44ec-dfdeb23be031@suse.cz>
In-Reply-To: <457899ac-baab-e976-44ec-dfdeb23be031@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|CO1PR11MB4772:EE_
x-ms-office365-filtering-correlation-id: 17ade1b9-28b1-4828-48b5-08dbf791e145
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j2fktc5I1NE5tPMvtvADu3p8gkLvn366/eUcnkev5RZ65W5tTa34iJc3mcUUky/C3HQT1+f1tUT416PkmcleKLaG4rIhJXNOf7wYlDh43oh85fjbNUaF96U/MG6CLtskmo7MaXdc8zZ811rZ9FOmhcu85sWHYU55krp70eOSbrIhx/ICUbk2112U/XMYRXwcCyXUciHtScW31XqdSy+TZ15de1FELJN5KW4gD9F/WRXkm7n3zVY7xocAyQsBqs/pw0ah2zxWhj2GRwbj2wq/hW92BAT7AD1eAza6xdQOPuGb/0MV1kiSb+dYRyb/8D42o3tM3gZ1rs+fVki78IpkbWtd5tOhTBxl6Shk99PwMwPJUCqauPxPl1PfPy4k2TFi5i3He27h+PL0iaROq9n9NnSncKaYnqTwWe5CyuSgqfv5SiJ6HgRJLq2jpx0cFeCVWHw1vj7Zq1cN0YVFQx6clagOb7poPL41ZR/tkKLAB7Gh1hbAA9xY8yCfqRZBl3GL57JTnhhWohHcj595l/lM7KYcwkz+dzRbrZOWbeHAhwS5BnzQCYVkm20SlKivziPdvXWr5O8vX9KviJFOyo6brbOu2u6awIrbfPGeY13LnetXxD7xcuCx+Jf8oVq3M0re
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(66946007)(76116006)(55016003)(66556008)(66476007)(4326008)(478600001)(110136005)(8676002)(122000001)(53546011)(26005)(8936002)(6506007)(71200400001)(54906003)(66446008)(64756008)(316002)(52536014)(7696005)(9686003)(86362001)(5660300002)(7416002)(2906002)(38070700009)(38100700002)(83380400001)(33656002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGJsL3h0bS83TTJWZnJ1Y2hGT3F6ajVDWVIrV3h6VFduV0VmOHRIYzZzd0RW?=
 =?utf-8?B?OTBUb3hyVzA1T2NMYXlCQTRHRHNSNktyN2s4M0JqRm1NbWtWcmFhZ3RtRnNS?=
 =?utf-8?B?ZXc4aVNYd2dzQWVmMno2Ym9nVTB2R2ozVCtZMnhINWViR05ZTFRwa28yem9s?=
 =?utf-8?B?ck11OStNM2FRWFVZbW5mRDVaM1JGdU1LMkhja3Z6UlVKVUlkWW5EaDlweVRU?=
 =?utf-8?B?eGcrb0JnNzJXYUtYUVNoYkZlNTZ5WkU3aGxhMlBwOHppeHdFU0NmOUNUc3Jr?=
 =?utf-8?B?Rmg3SG5LcVBEaVlYUUJGUWdtb0pSNnB6SnRWY2ZzUVNWTFk5eEMzcXVCVnp1?=
 =?utf-8?B?YWhqajVsS29nOU1MdUp0Zkh4V0pxUUJ5ZktWb2V5OVpvejZ6Wkk1SXdxUmcx?=
 =?utf-8?B?SWdpREJOZHJGaG8xVmVPQ25IcVFmNDdXRDg1MEYzTUVUNDlpSTl6UzNteE9w?=
 =?utf-8?B?aklmeVVWZno2dFNnYnNyVFVWdHdxNjVGY0JWeHcyTHBDaTYwSGpLNHlLdHFu?=
 =?utf-8?B?SXFHRGdnNmlPdG16a0ZPTDIxaXFkS2F1ZVB5SzdIQk85MGFCR0I5cDJzdmwz?=
 =?utf-8?B?b0NxMmF3NGRWNlZhMmtWVkVJNnBxMkFtRC9DcGk3QnZMVTVzdlBWTzh3NmNj?=
 =?utf-8?B?bDRDTDh1L09QM2YwRGVudDFvMXVCWTkyVEVsRkN5TFkxN1R1ODhpcGJGVGRo?=
 =?utf-8?B?QlpBY0diemVKVVJIeUZBbVNtY09VS0tzelBaUWVZRHpYNGZsZ1dPZ0g4VXRJ?=
 =?utf-8?B?OU1KbTlsTTdWaW9sNk4ySFFlZGRkemhhUlNCYUdFYUJvVGRTSngyUVpQWElJ?=
 =?utf-8?B?S0dzRnpTK2dETHp3YmdQWitGOG5CU29RTVlHSlE0a254MUdYWHhraFZhMlVI?=
 =?utf-8?B?R2hySnROWGdSNFZndWdqQ2Npa1RQdmdjZmNCWlRsY0ZvWDgzMEIwTkZTSUNK?=
 =?utf-8?B?NExjKzc3dFdWMTMyMWxYcEJPWW9PSmF0SllXWUhNWkhvQWJqeXVKaTFLR0RV?=
 =?utf-8?B?dmFTNFB4QWNKeFM3NjVoZmN3M3VDbEZMeW1HZVkzajcxYVZmRWhRWEdWSTFz?=
 =?utf-8?B?QmJhRWI3RDdDWWh3b2dxOEQ5b2lzWk9sbmtNRGtNdmsxZjZGZ3BhdHRGQXAx?=
 =?utf-8?B?K3BXY3Qyemw0amNmblRrTmhIc0xWV1hUc0RNSXU3RmdNNmdublFyMzZkeFNR?=
 =?utf-8?B?MzlQdEtoMjdMTytIWkNhRUV2T3JXaE1yc0tXekJ0a3ZidEZONWhxM3RPOWhk?=
 =?utf-8?B?c0VXdDAvbGhUNHI5cWRmdzRHaUlvZ1RWVzhxbUZaMmJLT2VoM2RCckp0dXRQ?=
 =?utf-8?B?dDRJb0RkZ3drY24vTnpaM2Z0Qjl5RkEvK0tYbkUwQmZKZVdmY010VVUwL0Zm?=
 =?utf-8?B?ZE1hcDY3cnphVzY5ai9uNXlaMTB1cWxnK3BIUUhYVGtXaUJyQTNDUWtNUTNp?=
 =?utf-8?B?cndqc1Y2OEpwdE5UMndxa0J0S0JEV25kOS8vWEs4SEUwdG45WXlCczJlNEVM?=
 =?utf-8?B?OW1iWUlndURlSE5wWlRjLzNCQUxudFp6MlNmOEtZc1A2MFlsZk0vNzV3bmt1?=
 =?utf-8?B?dVRpQjR6Y3pmdVFqN2N0ZFg3dXdiQkx2bmttTjRQVGNtSEJ1aCt5Ulg1M1RK?=
 =?utf-8?B?QnovRXBBWE45R3B1RDZRQ0pQVUJnZjlaQVNLWklkUFl3SmgxTjNUR3BTY2V4?=
 =?utf-8?B?ZXppMHhIaFRaVmtpbDkwL1orK3FneUJlK1FSUmphamo3YzdBLzRCRWR3V0h5?=
 =?utf-8?B?SjZXcXZhTHdBZmVlUkIyc2t6Y3M5dEtYWFludG04Ym5Vd1RMVVhCSG55ckJD?=
 =?utf-8?B?Z1pqUXNmdm9vTVJjN3FjRFBVZ3pydWlKMlJ5ZlFPQkdzbStpOXp6TUIxNVpO?=
 =?utf-8?B?d2p2SC8wTVNwK3R3K1lmbU9hSDczQmFENVhaY29EVlgzME5IOXVjK2FaKzFJ?=
 =?utf-8?B?NDM1a0JEUlVNbXVBK2tRTjFEZW5xRk51SG9JdDFaTWVHNE1HUDI4UXRYYU40?=
 =?utf-8?B?VkZZQkpmMWJJODhWYTdtS283bUFRV1NDUU45aVN1SkNocTZwSnlaOVgzV0ZC?=
 =?utf-8?B?cVk2YWVGVGM0YjNRTzVpRkw0MlNZaE5qK1VKYzJWWTVxblU3eWZzZVlTQ0VW?=
 =?utf-8?Q?is91B82tHuYnjbfGtm4uG1Y3j?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ade1b9-28b1-4828-48b5-08dbf791e145
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 02:03:32.4432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZzX91NSO9C4z4y6vSUrzIwCl4Hb3u/YgRquZwsBJfEhu+1qMDQ0PbLxalApPyPPmdOYdP5cdZKeP4zcF+ezKs7jX2BVEfx3ja7yTIx6O71I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4772
X-Proofpoint-GUID: X8HSXFbWYk6X8ChMUBHfcRtBEQzfsbQC
X-Proofpoint-ORIG-GUID: X8HSXFbWYk6X8ChMUBHfcRtBEQzfsbQC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 mlxlogscore=874 malwarescore=0 suspectscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312080016
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmxhc3RpbWlsIEJhYmth
IDx2YmFia2FAc3VzZS5jej4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDcsIDIwMjMgMTI6
MTMgQU0NCj4gVG86IHN4d2plYW5AbWUuY29tOyA0Mi5oeWV5b29AZ21haWwuY29tOyBjbEBsaW51
eC5jb207IGxpbnV4LQ0KPiBtbUBrdmFjay5vcmcNCj4gQ2M6IHBlbmJlcmdAa2VybmVsLm9yZzsg
cmllbnRqZXNAZ29vZ2xlLmNvbTsgaWFtam9vbnNvby5raW1AbGdlLmNvbTsNCj4gcm9tYW4uZ3Vz
aGNoaW5AbGludXguZGV2OyBjb3JiZXRAbHduLm5ldDsga2Vlc2Nvb2tAY2hyb21pdW0ub3JnOw0K
PiBhcm5kQGFybmRiLmRlOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZzsNCj4gbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgU29uZywgWGlvbmd3ZWkNCj4gPFhpb25nd2VpLlNvbmdAd2luZHJp
dmVyLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwLzNdIHN1cHBsZW1lbnQgb2Ygc2xh
YiBhbGxvY2F0b3IgcmVtb3ZhbA0KPiANCj4gT24gMTIvMy8yMyAwMToxNCwgc3h3amVhbkBtZS5j
b20gd3JvdGU6DQo+ID4gRnJvbTogWGlvbmd3ZWkgU29uZyA8eGlvbmd3ZWkuc29uZ0B3aW5kcml2
ZXIuY29tPg0KPiA+DQo+ID4gSGksDQo+ID4NCj4gPiBQYXRjaCAxIGlzIHRvIHJlbW92ZSBhbiB1
bnVzZWQgcGFyYW1ldGVyLiBUaGlzIHBhdGNoIGFjdHVhbGx5IGlzIHYzLCBidXQNCj4gPiBpdCBp
cyBub3QgcmVhc29uYWJsZSB0byBhZGQgdjMgdGFnIGluIHRoZSBjb3ZlciBsZXR0ZXIsIHNvIEkg
cHV0IHRoZQ0KPiA+IGNoYW5nZSBoaXN0b3J5IGluc2lkZSB0aGUgcGF0Y2guDQo+ID4NCj4gPiAt
LS0NCj4gPiBQYXRjaCAyIGlzIHRvIHJlcGxhY2Ugc2x1Yl8kcGFyYW1zIHdpdGggc2xhYl8kcGFy
YW1zLg0KPiA+IFZsYXN0aW1pbCBCYWJrYSBwb2ludGVkIG91dCB3ZSBzaG91bGQgdXNlICJzbGFi
XyRwYXJhbSIgYXMgdGhlIHByaW1hcnkNCj4gPiBwcmVmaXggZm9yIGxvbmctdGVybSBwbGFuLiBQ
bGVhc2Ugc2VlIFsxXSBmb3IgbW9yZSBpbmZvcm1hdGlvbi4NCj4gPg0KPiA+IFRoaXMgcGF0Y2gg
aXMgdG8gZG8gdGhhdC4gSG93ZXZlciwgdGhlIHBhdGNoIGlzIGJpZywgSSdtIG5vdCBzdXJlIGlm
DQo+ID4gZXZlcnl0aGluZyBpcyBwcm9wZXIgaW4gaXQsIHNvIEkgYWRkZWQgIlJGQyIgaW4gdGhl
IHBhdGNoIHRpdGxlLiBGb3IgbW9yZQ0KPiA+IGluZm9ybWF0aW9uIHBsZWFzZSBzZWUgdGhlIGNv
bW1pdCBtZXNzYWdlIG9mIHBhdGNoLg0KPiA+DQo+ID4gSSBkaWQgdGhlIGJhc2ljIHRlc3RzIHdp
dGggcWVtdSwgd2hpY2ggcGFzc2VkIHZhbHVlcyBieSBzbFthdV1iX21heF9vcmRlciwNCj4gPiBz
bFthdV1iX21pbl9vcmRlciwgc2xbYXVdYl9taW5fb2JqZWN0cyBhbmQgc2xbYXVdYl9kZWJ1ZyBp
biBjb21tYW5kDQo+IGxpbmUuDQo+ID4gVGhlIHZhbHVlcyBsb29rcyBjb3JyZWN0IGJ5IHByaW50
aW5nIHRoZW0gb3V0IGJlZm9yZSBjYWxjdWxhdGluZyBvcmRlcnMuDQo+ID4NCj4gPiBPbmUgdGhp
bmcgSSdtIG5vdCBzdXJlIGFib3V0IHRoZSBmb3J0aCBwYXJhbWV0ZXIgb2YgX19zZXR1cF9wYXJh
bSgpLA0KPiA+IElzIGl0IGNvcnJlY3QgdG8gc2V0IHRoZSBwYXJhbWV0ZXIgdG8gMCBkaXJlY3Rs
eT8NCj4gDQo+IFllcCBpdCdzIGZpbmUuDQoNClRoYW5rcyBmb3IgdGhlIGNvbmZpcm1hdGlvbi4N
Cg==
