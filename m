Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5584D8098EE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572952AbjLHB7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLHB7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:59:33 -0500
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B51B1AD;
        Thu,  7 Dec 2023 17:59:39 -0800 (PST)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B81P1P7010300;
        Fri, 8 Dec 2023 01:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=DYIAxTiu0nBZIWWlOT9w3CpYMMy7yDEqyXa/adU8N0w=; b=
        R3ioZkr6QuBDy/0ccFI1kvyiaDhGTSGrJTkHr8KDCiXqSttLG7qeVqr4lZLesdfa
        6QJTNf7xhPyWVXxaf5mo9x5/PS29r63OyIGrZdrZ+16QLIgZY44y23xgWQorsrTJ
        uyPAfMW63dY7WsdT+xVes7PcWcqTFAD3SqemkHi4OQbrXMjV8kxkNfOLDpZcbuvM
        7z9u7FAVs1IFMsjYT8QJjMRf6Eazzu3JhKAvPY428PdZo80LqwQjpsaW73ASdPdI
        q7xMFuoYStyBNURiNcU/4RhBymD+MTsbfD9dB+HMXUVBVzigwS/x0w3DVu4fb0mb
        4t4z/l6rOoV2MUCPPb8okg==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3utd53tc54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Dec 2023 01:58:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1iOhp+SxJ9RiNsTccdtYzDfo6r6sZC7WHiIAodqpUAWeC3WfPzfMDOygNlrld5C3c7MzPZZn2rP+bjxY26gfGhbVEakDPnwQvq5G7/BIHxiMMCYW5oK3y2tRVWobM9fYrF8mv7I5U5Mm5cJIExZBvUmWLyHLMotq7tqzlwmmhLH14tHAkXa8Wj4MSVrp4iWQFT8cSEn+29YL4M23f2ENozRDpnseAG/+KBNLpY3750dgQeDqSRVOJh7kTgjIEkqG6Xny0NgdtS30jamaTn4YFfU8BlmHyBLX28Vb7OpkGlZoxLXQqGL6IgFDzvqSPeqzGtq5Oc4mHzGs+HHox+BlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYIAxTiu0nBZIWWlOT9w3CpYMMy7yDEqyXa/adU8N0w=;
 b=nUm2cGIUeXrByDFT8pnQdWH2GLbyL6Sou9+RQlY18xqzVkh2ekg0HLUnjPiCHuISWnOUemsEfWah/cm15YXDoSxKaGoZc+1JgmdQMi//cRlZ45aY3hmnyCfJhqTcgQhm22vqQMtNHowjwH0YkPONoGEckqOj5B7Jc/nma6LXWZY64qxY7rd1JGX72j35LWPY081Ggyf9P5Avx/jJS0HXTbDVYS7hddF7L+kK5av7rmxW1UWAPggtF6zC3Xi2WzHqNg1P5/MFahBFgmBiHZZ1Qt11tom5201CRqG8UQyf8FbZSpB7MjtQqMmDbtEwHJqRyKTTuJ1gsapskYoI78LsQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by IA1PR11MB7246.namprd11.prod.outlook.com (2603:10b6:208:42e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 01:58:45 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::928a:7606:e525:8b91]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::928a:7606:e525:8b91%6]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 01:58:44 +0000
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
Subject: RE: [RFC PATCH v2 2/3] mm/slub: unify all sl[au]b parameters with
 "slab_$param"
Thread-Topic: [RFC PATCH v2 2/3] mm/slub: unify all sl[au]b parameters with
 "slab_$param"
Thread-Index: AQHaJX4GvlmLVMf03U253wXUMYQC3bCcc6uAgAIx3AA=
Date:   Fri, 8 Dec 2023 01:58:44 +0000
Message-ID: <PH0PR11MB5192BB602044602E0BD3D56FEC8AA@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20231203001501.126339-1-sxwjean@me.com>
 <20231203001501.126339-3-sxwjean@me.com>
 <75a71276-dff8-ad3a-d238-fcfa3ab39413@suse.cz>
In-Reply-To: <75a71276-dff8-ad3a-d238-fcfa3ab39413@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|IA1PR11MB7246:EE_
x-ms-office365-filtering-correlation-id: 84612b01-f513-4d54-4735-08dbf79135ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5blbxYkN0U1IF07FPqcb5fUoKr/F15C48ya7suO7IgpouTH2KcrzdXD7FSUjVl+zYICNeqfS6ybSke9TH1gvs6Ua+U9T9Zi3LLLe80qe+oVC9vniNnQ5YAZ8/WX0pVIY8yq1iuaEbBm5tk177Ekm+XkiywrRH2BMEFH0mkWcRngNH3r5YF1/P8usPaHqxowceTTeCFD1ti69RjufOBU1nKSsjlVywfwmeQV6duUtXd6RBcnBQeKvxu0/hTO3hPGzx/5lZV3Z3PonEFyGdso/il7ka77e2LiChbannnRU0sqmut/kjcgdT9d6KW672ecZZz7DqAXDJBXrK2CUSEMpQOCf7u3G02usSG0Buu0arutSkp+/Z2XdV65O9nCMfqFEH+oCW9IPifSWSlO7SbD8XjrOHQiZOyBy25Jj1mXOpvf09Q7Wut1R6Pqfjn3KOgqfZ3Mmz1LHcysiWawAFM1Tst8Sf+4mTExwSeLvxdLufrgCTKqHip/5a1SRXr1LAzNocDahz/75KHtvx6jO1ps/FrpEWfhmhkRJ+TkiHIE+cCxcwrBSb3ssa1XufH0myWrtTMAODowBUaXEx6YSZIU6IBUMkFEmopK8MLSyQJUZHdM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(39850400004)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6506007)(53546011)(478600001)(9686003)(966005)(38070700009)(38100700002)(7696005)(5660300002)(26005)(122000001)(52536014)(316002)(86362001)(76116006)(54906003)(66946007)(64756008)(110136005)(66556008)(66476007)(66446008)(71200400001)(4326008)(55016003)(8676002)(8936002)(33656002)(2906002)(83380400001)(41300700001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUVLTlV6dU0wNnZpUFhQcWxUTis1bDdGdDZaMk84aHAyUXROZm4rd2lFc3Uv?=
 =?utf-8?B?NVE5QzY3K25TVGh6V1hNcW5jd1JmWDRXaUtqYkoreWpoa2sxcG10aVZKR3Vu?=
 =?utf-8?B?ZnF0Uk9NYUpsK0M5QU1SNnE2cEEzU3pMRzRtSnNRS2NQU0o0M1RIWW84bWlt?=
 =?utf-8?B?dmZUczhHSzJjVmRKb2NiZ0FGVXJqTWpSQzRjYzE0VnMxL3dJSlVXem9ORFBC?=
 =?utf-8?B?WmN5Z1Z3cXk5bkt2aVdOK1JWYVp5bjNuM3JWdlp5UVF1N09ob0NDbDU3YTFB?=
 =?utf-8?B?bnR2eXgwUklXUWlsUzBtTjdxRjhMY2dxelE0aEViWWVkSUMyOEJjVzc1SmMr?=
 =?utf-8?B?azdxTlFoNVQrNjBmdjA3MjdxRkxTaU54bEwwOE44N3BNU2hxTVR0emZnUWh3?=
 =?utf-8?B?Tm4zVW9DdW5RZmRoY2NPaXNPT2VUZG9aKzhaano4ekIzRE4zZGZhNGdKejNt?=
 =?utf-8?B?b2dpODZnYnFwZ3JKTnJ6SlBJZFpsVUpLVTRjOWdGbkhEUnVmZk1ZUUQxRmxI?=
 =?utf-8?B?dlRhczh3NEZ4QXg0Vk9kWGFHZEJ0Y2ZKekNxQVMrbWl3ODdQcmhOSkswZ2Y2?=
 =?utf-8?B?b0NaNkRhL1lhemYxSkorNjd4U0owSXZYamxuSnVYdncrQktodzZXMjJLcDQ5?=
 =?utf-8?B?bzZKR0p3clBMbWljRVVSbWQycFUwOUFXdCs3b285Y0YrK1o0UEI1ZkF0MXdW?=
 =?utf-8?B?STl4Z2VXbWwyRHNWcWUrYzFZeDhrMzJrQmdmK2Q5Wml5a2VKM3Y3WDBscWJt?=
 =?utf-8?B?d1ZPTUtWYVVVcU5Kd1c2bFhDby95UEpwQys2SitUTEtxdzQxSWdSMCtmcGg2?=
 =?utf-8?B?Um5zb282Yk5jUXFSNkpuVHFHWXhvNzdCT1JKbGNhVWRwVkt1Tm4zZy9tK2Rw?=
 =?utf-8?B?dmdYTWhBNmgzcVNWejJYM1lPTFAvTGtRQkdQRDJWNlBQcEFqTjBMUW5zcGpt?=
 =?utf-8?B?SllxUXNiUkt1a0JtLzB2OVV4eTJYQ0tHakFQcElJbXVpZnFGa2JZeGZhL1Vs?=
 =?utf-8?B?WThvNGNZOE54MElBeW4zbTF0bzcvWGpWenZiTEpFUXRQN2tZVFJqS2JiSWxC?=
 =?utf-8?B?YmVhbW1qT0JlVFRLOS9abG5HZHFPK0lJRUFvdTgxSC9kQytZVXllemZJMmta?=
 =?utf-8?B?L0ZVcHlleitVWTVIOGVDRFFINDYzMjJ3bkgyRC9FRFduaG1UQ3dhZFI1TGdL?=
 =?utf-8?B?WUZyQUxEQWZUSzRyNkdVUjRzR0JUR1JNK3FmeHFlZFRhOHpWdDY3ZFpxWG1G?=
 =?utf-8?B?bFJsVGpNdTZ1Z1RFZjZCaXNFcjJuSUtiMTA4OFdzOEo5TWlaN3lyeXh1Qk9i?=
 =?utf-8?B?OU8vS09HVzY0V3FGZmZtNGRUWVRUY0dvd3VVVVBUNVg4TlByYmdIZHZkSEZt?=
 =?utf-8?B?czdaQlFaOC9NbjcxVXhSaVc0WjdDV0pDUENoOWR0ZmFiVUFDeUtvRXlKR1c1?=
 =?utf-8?B?djYzczJLZjlSNFNtdVpMUklnZVFiZ1JmeGZaZVdkd3liOUhQcUxHYVBFM3hH?=
 =?utf-8?B?engvV2ZIZ3RTN05ONFhGcitOVFRqUjRKUzM5MGNwdFJoYVVuLytpQ2tTcWNJ?=
 =?utf-8?B?S1J4VDd3azdZR2NRb1dUV0hFdCtSVGVQN29tbU93UTNFVFBKblRGSWFUVjJV?=
 =?utf-8?B?UDhXdU9MYVFqVVVjZVpjekp6emFEVkZ1YUxkdUxudUEwYkZTZTlHd1kyVUlS?=
 =?utf-8?B?RWI3QTNXRHFwKzVaWEd5K1BScVIwUXZVRlB6VlFRNWpGdnJFNlRLOXpFZU82?=
 =?utf-8?B?eTFhV1oxMzFOK3cxMzE0Wk9yaWI2ZFZZUmVyVTJSdndkMTNuanE3c1lZUVlo?=
 =?utf-8?B?OW1nbjRrMlk2M3BMZVlIWW4xS1BhSEhtVDN3aVZ0MGt2UWROYnhxV3RhdkxC?=
 =?utf-8?B?anREZHY4ODkvVU92M2FBbUZyN2ZhN1o4bmlkdlV0MzNNWXQ0dHVvTndTQmVP?=
 =?utf-8?B?RlhvbENPOTA2TGh1WEtKRGZzSU16OGxtQ0pOL0w1QXMwanI1cGFxWlN0VjJQ?=
 =?utf-8?B?bUczUWUxNUk0bTMrQjZvN1dmMzVRVDZ3N1NsTE8rMnBOSm5FMGxoVEJRNCtk?=
 =?utf-8?B?dGdIRDdhaGxLMkljc2NFMUdYdWVoMW9zd1VsUEllOEwycmJPTnJDMC9ScFUy?=
 =?utf-8?Q?mJnu34rSRhZm1Td7fn6rwSuLK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84612b01-f513-4d54-4735-08dbf79135ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 01:58:44.7839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQxMMKOTTXl4udlu+YsPUriRhX0fTFzfKycv3pt2fupHPOGIgJsc/C5hy8B41x9yPqQID4rl+EnYegU5L+pg+9ljX1Y0VQZE32fuv3duNuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7246
X-Proofpoint-GUID: 0dLRASC4L5VEwV0n1qiPMAiqixf9EbQO
X-Proofpoint-ORIG-GUID: 0dLRASC4L5VEwV0n1qiPMAiqixf9EbQO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312080015
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
MTUgQU0NCj4gVG86IHN4d2plYW5AbWUuY29tOyA0Mi5oeWV5b29AZ21haWwuY29tOyBjbEBsaW51
eC5jb207IGxpbnV4LQ0KPiBtbUBrdmFjay5vcmcNCj4gQ2M6IHBlbmJlcmdAa2VybmVsLm9yZzsg
cmllbnRqZXNAZ29vZ2xlLmNvbTsgaWFtam9vbnNvby5raW1AbGdlLmNvbTsNCj4gcm9tYW4uZ3Vz
aGNoaW5AbGludXguZGV2OyBjb3JiZXRAbHduLm5ldDsga2Vlc2Nvb2tAY2hyb21pdW0ub3JnOw0K
PiBhcm5kQGFybmRiLmRlOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZzsNCj4gbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgU29uZywgWGlvbmd3ZWkNCj4gPFhpb25nd2VpLlNvbmdAd2luZHJp
dmVyLmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjIgMi8zXSBtbS9zbHViOiB1bmlm
eSBhbGwgc2xbYXVdYiBwYXJhbWV0ZXJzIHdpdGgNCj4gInNsYWJfJHBhcmFtIg0KPiANCj4gT24g
MTIvMy8yMyAwMToxNSwgc3h3amVhbkBtZS5jb20gd3JvdGU6DQo+ID4gRnJvbTogWGlvbmd3ZWkg
U29uZyA8eGlvbmd3ZWkuc29uZ0B3aW5kcml2ZXIuY29tPg0KPiA+DQo+ID4gU2luY2UgdGhlIFNM
QUIgYWxsb2NhdG9yIGhhcyBiZWVuIHJlbW92ZWQsIHNvIHdlIG5lZWQgdG8gY2xlYW4gdXAgdGhl
DQo+IA0KPiAid2UgY2FuIGNsZWFuIHVwIiwgYXMgd2UgZG9uJ3QgcmVhbGx5ICJuZWVkIg0KDQpP
aywgbWFrZSBzZW5zZS4NCg0KPiANCj4gPiBzbFthdV1iXyRwYXJhbXMuIEhvd2V2ZXIsIHRoZSAi
c2xhYi9TTEFCIiB0ZXJtcyBzaG91bGQgYmUga2VlcCBmb3INCj4gPiBsb25nLXRlcm0gcmF0aGVy
IHRoYW4gInNsdWIvU0xVQiIuIEhlbmNlLCB3ZSBzaG91bGQgdXNlICJzbGFiXyRwYXJhbSINCj4g
DQo+IEknZCBwaHJhc2UgaXQ6IFdpdGggb25seSBvbmUgc2xhYiBhbGxvY2F0b3IgbGVmdCwgaXQn
cyBiZXR0ZXIgdG8gdXNlIHRoZQ0KPiBnZW5lcmljICJzbGFiIiB0ZXJtIGluc3RlYWQgb2YgInNs
dWIiIHdoaWNoIGlzIGFuIGltcGxlbWVudGF0aW9uIGRldGFpbC4NCj4gSGVuY2UgLi4uDQoNCk9r
Lg0KDQo+ID4gYXMgdGhlIHByaW1hcnkgcHJlZml4LCB3aGljaCBpcyBwb2ludGVkIG91dCBieSBW
bGFzdGltaWwgQmFia2EuIEZvciBtb3JlDQo+ID4gaW5mb3JtYXRpb24gcGxlYXNlIHNlZSBbMV0u
DQo+ID4NCj4gPiBUaGlzIHBhdGNoIGlzIGNoYW5naW5nIHRoZSBmb2xsb3dpbmcgc2xhYiBwYXJh
bWV0ZXJzDQo+ID4gLSBzbHViX21heF9vcmRlcg0KPiA+IC0gc2x1Yl9taW5fb3JkZXINCj4gPiAt
IHNsdWJfbWluX29iamVjdHMNCj4gPiAtIHNsdWJfZGVidWcNCj4gPiB0bw0KPiA+IC0gc2xhYl9t
YXhfb3JkZXINCj4gPiAtIHNsYWJfbWluX29yZGVyDQo+ID4gLSBzbGFiX21pbl9vYmplY3RzDQo+
ID4gLSBzbGFiX2RlYnVnDQo+ID4gYXMgdGhlIHByaW1hcnkgc2xhYiBwYXJhbWV0ZXJzIGluDQo+
ID4gRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQgYW5kIHNv
dXJjZSwgYW5kIHJlbmFtZQ0KPiBhbGwNCj4gPiBzZXR1cCBmdW5jdGlvbnMgb2YgdGhlbSB0b28u
IE1lYW53aGlsZSwgInNsdWJfJHBhcmFtcyIgY2FuIGFsc28gYmUNCj4gcGFzc2VkDQo+IA0KPiBO
b3Qgc3VyZSBhYm91dCByZW5hbWluZyB0aGUgY29kZSBhdCB0aGlzIHBvaW50LCBJIHdvdWxkIGp1
c3QgcmVuYW1lIHRoZQ0KPiB1c2VyLXZpc2libGUgcGFyYW1ldGVycyBhbmQgdGhlaXIgZG9jdW1l
bnRhdGlvbiBhbmQgYW55IGNvbW1lbnQgdGhhdCByZWZlcnMNCj4gdG8gdGhlIHBhcmFtZXRlcnMu
IEZ1bmN0aW9ucyBhbmQgdmFyaWFibGVzIGNhbiBjb21lIGxhdGVyIGFzIHBhcnQgb2Ygd2lkZXIN
Cj4gc2x1Yi9zbGFiIGNoYW5nZSBpZiB3ZSBkZWNpZGUgdG8gZG8gc28/DQoNCk9rLiAgV2lsbCBj
cmVhdGUgYSBzZXBhcmF0ZSBwYXRjaCBhcyB5b3UgbWVudGlvbmVkIGluIHRoZSBjb21tZW50IG9m
IHBhdGNoIDMuDQoNCj4gDQo+ID4gYnkgY29tbWFuZCBsaW5lLCB3aGljaCBpcyB0byBrZWVwIGJh
Y2t3YXJkIGNvbXBhdGliaWxpdHkuIEFsc28gbWFyayBhbGwNCj4gPiAic2x1Yl8kcGFyYW1zIiBh
cyBsZWdhY3kuDQo+ID4NCj4gPiBUaGUgZnVuY3Rpb24NCj4gPiAgICAgc3RhdGljIGludCBfX2lu
aXQgc2V0dXBfc2x1Yl9kZWJ1ZyhjaGFyICpzdHIpOw0KPiA+ICwgd2hpY2ggaXMgdG8gc2V0dXAg
ZGVidWcgZmxhZ3MgaW5zaWRlIGEgc2xhYiBkdXJpbmcga2VybmVsIGluaXQsIGlzDQo+ID4gY2hh
bmdlZCB0byBzZXR1cF9zbGFiX2RlYnVnX2ZsYWdzKCksIHdoaWNoIGlzIHRvIHByZXZlbnQgdGhl
IG5hbWUNCj4gPiBjb25mbGljdC4gQmVjYXVzZSB0aGVyZSBpcyBhbm90aGVyIGZ1bmN0aW9uDQo+
ID4gICAgIHZvaWQgc2V0dXBfc2xhYl9kZWJ1ZyhzdHJ1Y3Qga21lbV9jYWNoZSAqcywgc3RydWN0
IHNsYWIgKnNsYWIsDQo+ID4gICAgICAgICAgICAgICB2b2lkICphZGRyKTsNCj4gPiAsIHdoaWNo
IGlzIHRvIHBvaXNvbiBzbGFiIHNwYWNlLCB3b3VsZCBoYXZlIG5hbWUgY29uZmxpY3Qgd2l0aCB0
aGUgcHJpb3INCj4gPiBvbmUuDQo+IA0KPiBBbm90aGVyIHJlYXNvbiB0byBkZWZlciBjb2RlIG5h
bWluZyBjaGFuZ2VzLg0KDQpPay4NCg0KPiANCj4gPiBGb3IgcGFyYW1ldGVyICJzbHViX2RlYnVn
IiwgYmVzaWRlIHJlcGxhY2luZyBpdCB3aXRoICJzbGFiX2RlYnVnIiwgdGhlcmUNCj4gPiBhcmUg
c2V2ZXJhbCBnbG9iYWwgdmFyaWFibGVzLCBsb2NhbCB2YXJpYWJsZXMgYW5kIGZ1bmN0aW9ucyB3
aGljaCBhcmUNCj4gPiByZWxhdGVkIHdpdGggdGhlIHBhcmFtZXRlciwgbGV0J3MgcmVuYW1lIHRo
ZW0gYWxsLg0KPiA+DQo+ID4gUmVtb3ZlIHRoZSBzZXBhcmF0ZSBkZXNjcmlwdGlvbnMgZm9yIHNs
dWJfW25vXW1lcmdlLCBhcHBlbmQgbGVnYWN5IHRpcA0KPiA+IGZvciB0aGVtIGF0IHRoZSBlbmQg
b2YgZGVzY3JpcHRpb25zIG9mIHNsYWJfW25vXW1lcmdlLg0KPiA+DQo+ID4gSSBkaWRuJ3QgY2hh
bmdlIHRoZSBwYXJhbWV0ZXJzIGluIERvY3VtZW50YXRpb24vbW0vc2x1Yi5yc3QgYmVjYXVzZSB0
aGUNCj4gPiBmaWxlIG5hbWUgaXMgc3RpbGwgInNsdWIucnN0IiwgYW5kIHNsdWJfJHBhcmFtcyBz
dGlsbCBjYW4gYmUgdXNlZCBpbg0KPiA+IGtlcm5lbCBjb21tYW5kIGxpbmUgdG8ga2VlcCBiYWNr
d2FyZCBjb21wYXRpYmlsaXR5Lg0KPiA+DQo+ID4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LW1tLzc1MTJiMzUwLTQzMTctMjFhMC1mYWIzLQ0KPiA0MTAxYmM0ZDhmN2FAc3VzZS5j
ei8NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFhpb25nd2VpIFNvbmcgPHhpb25nd2VpLnNvbmdA
d2luZHJpdmVyLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJh
bWV0ZXJzLnR4dCAgICAgICAgIHwgIDQ0ICsrKy0tLQ0KPiA+ICBkcml2ZXJzL21pc2MvbGtkdG0v
aGVhcC5jICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gPiAgbW0vS2NvbmZpZy5kZWJ1
ZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICstDQo+ID4gIG1tL3NsYWIuaCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxNiArLQ0KPiA+ICBtbS9zbGFi
X2NvbW1vbi5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDggKy0NCj4gPiAgbW0v
c2x1Yi5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTQyICsrKysrKysr
Ky0tLS0tLS0tLQ0KPiA+ICA2IGZpbGVzIGNoYW5nZWQsIDEwOSBpbnNlcnRpb25zKCspLCAxMDkg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1n
dWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCj4gYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRl
L2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPiA+IGluZGV4IDlmOTRiYWViMmY4Mi4uZDAxYzEyZTJh
MjQ3IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBh
cmFtZXRlcnMudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwt
cGFyYW1ldGVycy50eHQNCj4gPiBAQCAtNTg2OSw2ICs1ODY5LDggQEANCj4gPiAgICAgICBzbGFi
X21lcmdlICAgICAgW01NXQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBFbmFibGUgbWVyZ2lu
ZyBvZiBzbGFicyB3aXRoIHNpbWlsYXIgc2l6ZSB3aGVuIHRoZQ0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICBrZXJuZWwgaXMgYnVpbHQgd2l0aG91dCBDT05GSUdfU0xBQl9NRVJHRV9ERUZBVUxU
Lg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAoc2x1Yl9tZXJnZSBpcyBhY2NlcHRlZCB0b28s
IGJ1dCBpdCdzIHN1cHBvcnRlZCBmb3INCj4gPiArICAgICAgICAgICAgICAgICAgICAgbGVnYWN5
KQ0KPiANCj4gSG93IGFib3V0IGEgc2hvcnRlciBub3RlIChhbmQgYWx3YXlzIHN0YXJ0IG9uIG5l
dyBsaW5lKQ0KPiANCj4gICAgICAgICAgICAgICAgIChzbHViX21lcmdlIGxlZ2FjeSBuYW1lIGFs
c28gYWNjZXB0ZWQgZm9yIG5vdykNCg0KT2suDQoNCj4gDQo+ID4NCj4gPiAgICAgICBzbGFiX25v
bWVyZ2UgICAgW01NXQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBEaXNhYmxlIG1lcmdpbmcg
b2Ygc2xhYnMgd2l0aCBzaW1pbGFyIHNpemUuIE1heSBiZQ0KPiA+IEBAIC01ODgyLDQ3ICs1ODg0
LDQxIEBADQo+ID4gICAgICAgICAgICAgICAgICAgICAgIHVuY2hhbmdlZCkuIERlYnVnIG9wdGlv
bnMgZGlzYWJsZSBtZXJnaW5nIG9uIHRoZWlyDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIG93
bi4NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgRm9yIG1vcmUgaW5mb3JtYXRpb24gc2VlIERv
Y3VtZW50YXRpb24vbW0vc2x1Yi5yc3QuDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIChzbHVi
X25vbWVyZ2UgaXMgYWNjZXB0ZWQgdG9vLCBidXQgaXQncyBzdXBwb3J0ZWQgZm9yDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgIGxlZ2FjeSkNCj4gPg0KPiA+IC0gICAgIHNsYWJfbWF4X29yZGVy
PSBbTU0sIFNMQUJdDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIERldGVybWluZXMgdGhlIG1h
eGltdW0gYWxsb3dlZCBvcmRlciBmb3Igc2xhYnMuDQo+ID4gLSAgICAgICAgICAgICAgICAgICAg
IEEgaGlnaCBzZXR0aW5nIG1heSBjYXVzZSBPT01zIGR1ZSB0byBtZW1vcnkNCj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgZnJhZ21lbnRhdGlvbi4gIERlZmF1bHRzIHRvIDEgZm9yIHN5c3RlbXMg
d2l0aA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICBtb3JlIHRoYW4gMzJNQiBvZiBSQU0sIDAg
b3RoZXJ3aXNlLg0KPiA+IC0NCj4gPiAtICAgICBzbHViX2RlYnVnWz1vcHRpb25zWyxzbGFic11b
O1tvcHRpb25zWyxzbGFic11dLi4uXSAgICAgIFtNTSwgU0xVQl0NCj4gPiAtICAgICAgICAgICAg
ICAgICAgICAgRW5hYmxpbmcgc2x1Yl9kZWJ1ZyBhbGxvd3Mgb25lIHRvIGRldGVybWluZSB0aGUN
Cj4gPiArICAgICBzbGFiX2RlYnVnWz1vcHRpb25zWyxzbGFic11bO1tvcHRpb25zWyxzbGFic11d
Li4uXSAgICAgIFtNTV0NCj4gDQo+IEkgdGhpbmsgd2Ugc2hvdWxkIHJlLXNvcnQgYWxwaGFiZXRp
Y2FsbHkgYWZ0ZXIgdGhlIHNsdWJfIC0+IHNsYWJfIGNoYW5nZS4NCg0KT2suDQoNCj4gDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgIEVuYWJsaW5nIHNsYWJfZGVidWcgYWxsb3dzIG9uZSB0byBk
ZXRlcm1pbmUgdGhlDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIGN1bHByaXQgaWYgc2xhYiBv
YmplY3RzIGJlY29tZSBjb3JydXB0ZWQuIEVuYWJsaW5nDQo+ID4gLSAgICAgICAgICAgICAgICAg
ICAgIHNsdWJfZGVidWcgY2FuIGNyZWF0ZSBndWFyZCB6b25lcyBhcm91bmQgb2JqZWN0cyBhbmQN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgc2xhYl9kZWJ1ZyBjYW4gY3JlYXRlIGd1YXJkIHpv
bmVzIGFyb3VuZCBvYmplY3RzIGFuZA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBtYXkgcG9p
c29uIG9iamVjdHMgd2hlbiBub3QgaW4gdXNlLiBBbHNvIHRyYWNrcyB0aGUNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgbGFzdCBhbGxvYyAvIGZyZWUuIEZvciBtb3JlIGluZm9ybWF0aW9uIHNl
ZQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICBEb2N1bWVudGF0aW9uL21tL3NsdWIucnN0Lg0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICBEb2N1bWVudGF0aW9uL21tL3NsdWIucnN0LiAoc2x1
Yl9kZWJ1ZyBpcyBhY2NlcHRlZA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICB0b28sIGJ1dCBp
dCdzIHN1cHBvcnRlZCBmb3IgbGVnYWN5KQ0KPiA+DQo+ID4gLSAgICAgc2x1Yl9tYXhfb3JkZXI9
IFtNTSwgU0xVQl0NCj4gPiArICAgICBzbGFiX21heF9vcmRlcj0gW01NXQ0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICBEZXRlcm1pbmVzIHRoZSBtYXhpbXVtIGFsbG93ZWQgb3JkZXIgZm9yIHNs
YWJzLg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBBIGhpZ2ggc2V0dGluZyBtYXkgY2F1c2Ug
T09NcyBkdWUgdG8gbWVtb3J5DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIGZyYWdtZW50YXRp
b24uIEZvciBtb3JlIGluZm9ybWF0aW9uIHNlZQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICBE
b2N1bWVudGF0aW9uL21tL3NsdWIucnN0Lg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBEb2N1
bWVudGF0aW9uL21tL3NsdWIucnN0LiAoc2x1Yl9tYXhfb3JkZXIgaXMNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgYWNjZXB0ZWQgdG9vLCBidXQgaXQncyBzdXBwb3J0ZWQgZm9yIGxlZ2FjeSkN
Cj4gPg0KPiA+IC0gICAgIHNsdWJfbWluX29iamVjdHM9ICAgICAgIFtNTSwgU0xVQl0NCj4gPiAr
ICAgICBzbGFiX21pbl9vYmplY3RzPSAgICAgICBbTU1dDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgIFRoZSBtaW5pbXVtIG51bWJlciBvZiBvYmplY3RzIHBlciBzbGFiLiBTTFVCIHdpbGwNCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgaW5jcmVhc2UgdGhlIHNsYWIgb3JkZXIgdXAgdG8gc2x1
Yl9tYXhfb3JkZXIgdG8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgaW5jcmVhc2UgdGhlIHNs
YWIgb3JkZXIgdXAgdG8gc2xhYl9tYXhfb3JkZXIgdG8NCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgZ2VuZXJhdGUgYSBzdWZmaWNpZW50bHkgbGFyZ2Ugc2xhYiBhYmxlIHRvIGNvbnRhaW4NCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgdGhlIG51bWJlciBvZiBvYmplY3RzIGluZGljYXRlZC4g
VGhlIGhpZ2hlciB0aGUgbnVtYmVyDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIG9mIG9iamVj
dHMgdGhlIHNtYWxsZXIgdGhlIG92ZXJoZWFkIG9mIHRyYWNraW5nIHNsYWJzDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgIGFuZCB0aGUgbGVzcyBmcmVxdWVudGx5IGxvY2tzIG5lZWQgdG8gYmUg
YWNxdWlyZWQuDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIEZvciBtb3JlIGluZm9ybWF0aW9u
IHNlZSBEb2N1bWVudGF0aW9uL21tL3NsdWIucnN0Lg0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAoc2x1Yl9taW5fb2JqZWN0cyBpcyBhY2NlcHRlZCB0b28sIGJ1dCBpdCdzIHN1cHBvcnRlZA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICBmb3IgbGVnYWN5KQ0KPiA+DQo+ID4gLSAgICAgc2x1
Yl9taW5fb3JkZXI9IFtNTSwgU0xVQl0NCj4gPiArICAgICBzbGFiX21pbl9vcmRlcj0gW01NXQ0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICBEZXRlcm1pbmVzIHRoZSBtaW5pbXVtIHBhZ2Ugb3Jk
ZXIgZm9yIHNsYWJzLiBNdXN0IGJlDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIGxvd2VyIHRo
YW4gc2x1Yl9tYXhfb3JkZXIuDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIEZvciBtb3JlIGlu
Zm9ybWF0aW9uIHNlZSBEb2N1bWVudGF0aW9uL21tL3NsdWIucnN0Lg0KPiA+IC0NCj4gPiAtICAg
ICBzbHViX21lcmdlICAgICAgW01NLCBTTFVCXQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICBT
YW1lIHdpdGggc2xhYl9tZXJnZS4NCj4gPiAtDQo+ID4gLSAgICAgc2x1Yl9ub21lcmdlICAgIFtN
TSwgU0xVQl0NCj4gPiAtICAgICAgICAgICAgICAgICAgICAgU2FtZSB3aXRoIHNsYWJfbm9tZXJn
ZS4gVGhpcyBpcyBzdXBwb3J0ZWQgZm9yIGxlZ2FjeS4NCj4gPiAtICAgICAgICAgICAgICAgICAg
ICAgU2VlIHNsYWJfbm9tZXJnZSBmb3IgbW9yZSBpbmZvcm1hdGlvbi4NCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgbG93ZXIgdGhhbiBzbGFiX21heF9vcmRlci4gRm9yIG1vcmUgaW5mb3JtYXRp
b24gc2VlDQo+IA0KPiAgICAgICAgICAgICAgICAgImxvd2VyIG9yIGVxdWFsIHRvIiAobW9yZSBw
cmVjaXNlLCB3aGlsZSBhdCBpdCkNCg0KWWVzLCBJIGFncmVlLiANCg0KVGhhbmtzIGZvciBhbGwg
dGhlIGRldGFpbGVkIGNvbW1lbnRzLiBXaWxsIHVwZGF0ZS4NCg0KUmVnYXJkcywNClhpb25nd2Vp
DQoNCj4gDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIERvY3VtZW50YXRpb24vbW0vc2x1Yi5y
c3QuIChzbHViX21pbl9vcmRlciBpcyBhY2NlcHRlZA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICB0b28sIGJ1dCBpdCdzIHN1cHBvcnRlZCBmb3IgbGVnYWN5KQ0KPiA+DQo+ID4gICAgICAgc21h
cnQyPSAgICAgICAgIFtIV10NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgRm9ybWF0OiA8aW8x
PlssPGlvMj5bLC4uLiw8aW84Pl1dDQo+IA0KPiBUaGFua3MhDQoNCg==
