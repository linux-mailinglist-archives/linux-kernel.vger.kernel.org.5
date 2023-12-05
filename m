Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFE48056E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345649AbjLEOLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345568AbjLEOLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:11:39 -0500
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0403BB9;
        Tue,  5 Dec 2023 06:11:43 -0800 (PST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B5AsSpH018877;
        Tue, 5 Dec 2023 06:10:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=6zhWD6OXd2gJSAObkw/EmwFvTq71tBM+xaOf+/Dlb4I=; b=
        DoXuARzQZiUV7ogIcpgls+EHmD84fEGSpV3f0TA/NuXCm+tUeYTuHqMMWSvH25JX
        7ZmyC9bjd3Pr78ktXMvUnYnx9gmxu68ORID8nzxAGSokQYeyFBJJMi+zHFHg0Lxs
        GAfh4uEzp4HxiAny2CuhUH5b+VDOokvx5+grHiUCZH3iY/4u9F9d9INUWq/59zzv
        KlRU3qlry7/IhjyaNhvwoFHOO4Bn2ls++qhOAQ8sPRbEpioBtl0Ca6UsxYXOSGdU
        9YpVdx6Z/PY5cJTzA2p2SKzv0O3d4zCSCMjPpBHxSFq/Iinld8Tn0MK3VLNRbVwg
        FNg3nne3rFhDId8TYDB5xw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ur0r4jn4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 06:10:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CV8OKOgS6ufKl1nEZf96fZ5+8XypzycLGURmROqgt4C2WkXFO00tTaA4QPhpcIL/ZsHZFSFod0BLF3dSs5BnItm69NAFX9daXxQH8+2bT05FKKOd/OIftRHfRaa/98BpjXR6k9JXsfYUFL0SKdr2HvaGTeUvJpTmEJc8kAtpuiwnnPPu7z7NLYNGKISQ/DtJr5sS5nwliwPFl4qGA6fUugk6N8R3FkvWuxAyJ79XnjDgZP37P6uveTrAK1H1kQg1QW50Nflpw2Tp0CNSO2XN3WeC+RVdaqXioOfdQzTjZV8k8ZCIPWQMgRLbPV9KhN/lnfigLwQ4rdfA5l7xLJrjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zhWD6OXd2gJSAObkw/EmwFvTq71tBM+xaOf+/Dlb4I=;
 b=Rv+Jayeqg1aZdQ5NqhmYMTYxDbdHuIm2rFNBkhYmwjCahDO34jX5qY07R9SxKmc5/u/qLIzF8vQdxPg5MiEyfJ8AqwoZe1a+7XG8fCBDWG+AwbsX74xXV0NBTZBZr/1TCPoQxXWeVgqTV1hJRxqqmZFa5VkBcRY4L9JNu/AH2MOF05q0qUoK5gTywMN+FUcA/N5ACMHCnWKCafSOLzQfeeGxIpvR2HmaLbVljkTqEZv/BqdJ8dIPDNZKhUJdCd8mkhw1M2PlwMaY/tTSBpnSSC6RS1o1HZevwG3AjyDciQeq4BNZsGxplEuzxUh5gAzXIgTiVOH+4uMfMmmGpSX7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 14:10:52 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::928a:7606:e525:8b91]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::928a:7606:e525:8b91%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 14:10:52 +0000
From:   "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "sxwjean@me.com" <sxwjean@me.com>
CC:     "vbabka@suse.cz" <vbabka@suse.cz>, "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "penberg@kernel.org" <penberg@kernel.org>,
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
Subject: RE: [PATCH v2 3/3] mm/slub: correct the default value of
 slub_min_objects in doc
Thread-Topic: [PATCH v2 3/3] mm/slub: correct the default value of
 slub_min_objects in doc
Thread-Index: AQHaJX4KvZcyJOVj/0Gw9sVyXKRq2LCZ3/YAgADW+JA=
Date:   Tue, 5 Dec 2023 14:10:51 +0000
Message-ID: <PH0PR11MB5192C8CFE3FC4CF1BCA74796EC85A@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20231203001501.126339-1-sxwjean@me.com>
 <20231203001501.126339-4-sxwjean@me.com>
 <CAB=+i9TVfzWk=anexu6ARPA21AC-uhjQjf4brZF0XDfVaWraWw@mail.gmail.com>
In-Reply-To: <CAB=+i9TVfzWk=anexu6ARPA21AC-uhjQjf4brZF0XDfVaWraWw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|PH0PR11MB7585:EE_
x-ms-office365-filtering-correlation-id: 92071d68-fed9-465c-a0a0-08dbf59bfd34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s3e8XcpRvMjGA05zDBM4iUMmosrUcGE9dS0dXvj0FUYeUIkenEw3ioJx+bTRERE7iorrsgN7VZuTmKVTBiRCWEI95qz/J0ENcJJDSeHTIQIZwzxHKfw+fxrRZ3qlyB8k9Phbredvq8/SLLDy9KriyJSOB40dV+lfW32nsBa9hwefVpbnkH80t9AzoH6Zu+1r51kx00XJs+4W9muny9RxguTU/GIWHclaFg7YbkK9p/jbXvKgBun+5RLqBWqZFtS2iTMEf1AzJJ6kqpdGE3thG+ApXnwMoaM0SrbtDXID3ozErDBHm/Ne9hkfiECQ7OpWoDsYr4PSK8JLq5v56tEKFFLjaJX9IAMO5jpFLl3DHZMY9bPXZNV/GuOhTUtPGJV1YPqGYkIgkD1zbYikeLr1yRWVqfukGjOji3MtM2Y3A+KOiKZd2kpZwrkFCQLqtpCstZ8n3Ar+PpbGRLMYg1xoJDqFyqCbX+0OTOf301tzfc1pla7rgUKzx99MsCEWwajWBvwOGDMaB+ElXmgNiMApfWjUCnHUc0leWrugR4rXZurqMtQi48pP7A4xd9qz+dCGD9OAz55rbxq+4dcZT+AIt2UNSP9j20EFTKs9+npgSSdGnpykd22BKbe44ull1qI+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39850400004)(346002)(366004)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(55016003)(66899024)(26005)(122000001)(33656002)(38100700002)(86362001)(38070700009)(83380400001)(7416002)(52536014)(5660300002)(9686003)(53546011)(71200400001)(7696005)(6506007)(8936002)(8676002)(4326008)(66476007)(76116006)(66946007)(66556008)(110136005)(316002)(64756008)(66446008)(54906003)(2906002)(41300700001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkRnbnl2ZUhYRUdGd2lIVXliU3lFZHpoRjhKMmovMmgyNG1sb2dXN1N0bGVL?=
 =?utf-8?B?VEl4RjNyd2MyUk1JR0hBWlFIKzFZTUZ5ZXE4SDhuUVhydkJzRTV3dE1sNHQv?=
 =?utf-8?B?NFh2TStpSFRxRkx0WjhsS0ZBZU9NNnVKdW1LZUNHK2FWeEE3VEpuVmE3Lzk3?=
 =?utf-8?B?ZmtNdmxZTmg4UUZ2N0JyWU5qSC9JRjh1TXF4WmNPYVRYYU5ZUlJJTUdjakkv?=
 =?utf-8?B?K0M5YmpaeXo4NVVKZ2dOWlE2RkZrS2FqQjBRSHo5TExhQlFpWHlNdS9OcVpa?=
 =?utf-8?B?NzRSSm5RcVhDUWJ5L1V3WURlS2w4OG0yVzROekNQYWFkbDdtLzhsOGtuSFpC?=
 =?utf-8?B?WDUwTUE5dy9KZGRnQ0tCekx3WDZXYjRmd2NKbDVJZHRDUFVYeG11UkloRUFE?=
 =?utf-8?B?RHp6SmdCdXRsYnVOSUNObFR5eDloTklFS3RSTUhnSm1sTlFOZWZQbGQ3cFRC?=
 =?utf-8?B?TEJhRTVOTEtmS016M2RXSzBDMGV2RnRxL2lKL0ZQUkNhNE8zUzdlRGl3S0Fq?=
 =?utf-8?B?ajM4eGZmKzFJdkwzK2pZb2dtUkVyQWFid05raC9hSEg3UlA3d214bVVIYXF6?=
 =?utf-8?B?dm85TVdXQzVsOUdaNEh6SWFNQjZENUpqY0JFVVExb0Z6cUZXSlI3ai9xQUho?=
 =?utf-8?B?R3pDUlJaR2tUWEhxTzhMaXoxVmw4Sk5iOTN5aFhXSHBvTFlXZ1IxQmw0VnRH?=
 =?utf-8?B?cXA3VGxvdE1ZTWRPN0dwbnJwQklJSzIwSExpTlluYnZwdlowZEEzKzFiQVM0?=
 =?utf-8?B?eDYveGVRNVZCMFMvN0RXakxOQ2h4WE5PcnFnUjBGd01vOFVnSVZrY1BzS00r?=
 =?utf-8?B?TU92ZWdZeFBJb3pDWlB6ZGdoeW96N3BTZ05tcHhadDJBNSszR0piNDgwMVpU?=
 =?utf-8?B?anNEZ3lVeUh2amEzbFV3cXh0S2wvb1lrSWZEcXVlRmJMTjFDRFZCeE40cXhh?=
 =?utf-8?B?eUNCcVByYlE0NTZuR3VCRmd0aCtVanBYZytndGNoK0k2WUJjS2c4a3oySFNQ?=
 =?utf-8?B?bXF6aXVpYUdGRGdreXJjNnJEbHF6UGJaNWhwVW1KUitlcmtIY1pNdU1pMTcz?=
 =?utf-8?B?UFNkUm9oMlJQUlF4emJoQ25SMXl4Syt1UmE4d1dGRFo0RFFIUy9FazcwaEFu?=
 =?utf-8?B?bVZxQi84cUtrTE8ySzJNN2x3c3UrMDlNMC94bkRkOEdMNWJZS2I2N2hXUTRP?=
 =?utf-8?B?M0JCenE0b0d6eFRzYnJld2RBM0lteTBEbyt2d2dxVXYrOFl5TmsxK0FLajNl?=
 =?utf-8?B?MUJsQTh5WHA4eVJHYm5uWWlPRXNrS1hGT2tmSTAzQVdmdGRVZ3hJTVZOTENj?=
 =?utf-8?B?a1dhelU0NzJ5UjF2VnJZb3FPeWhEelBtN0lKK01YQ0Nnc0ZxWmtjQnNXWG9R?=
 =?utf-8?B?cVE0QWVGcUFJY2VabTdqVlQrelNhZjBxSWw0S1RXVEhLMU05UThGYjFKVE5U?=
 =?utf-8?B?SjdBaUpCZzltc0hPQmRsQWJYNFpFMVVGa2pWMzl4VFhZNkVURk5DSmQvTm9m?=
 =?utf-8?B?aEpiaVZGYm9EZkxvd1QxTVBrejFuWFpUNUZRWXdGZlRiT0xxa3I1ZkJNS2xD?=
 =?utf-8?B?OW5lam1DaElENTB0bHBlREExTVhKc2FZQ3crNU4wVW5uSWdiRWxvZDZVeFEz?=
 =?utf-8?B?Y3NSeEhLRVYwbTQ3MEZ2UkFrSVRjOTc0dmUzUG9GYjA5MlRhRXRLbE9tZUIv?=
 =?utf-8?B?TjdTZ3daUjgxLzA2OEg5NWNkSDFvYVl2YTdmV1pGWTBFZXAyUUh4L3VpcGFK?=
 =?utf-8?B?NEdwOG9rM0F1NUJHdXBCcTN1NjV1NkZHbSsvV3IrbTlleU1rcmZXYUMyN1BF?=
 =?utf-8?B?K3dNUVM3MUZGNWFudHRmNjc1bWdVNzUvZVNIYkl1VjZTbEdHSVRqZWoxTis5?=
 =?utf-8?B?Y2hPanYyQnhONjB5akNsaFJUVVZyS2poZkdjbEUrL2hvQ3oyQ1VaYWJBODJP?=
 =?utf-8?B?di9MVmpwc2E2MkVSbzBYbHAzRTlyVDc3VzQvbWowSTZwSDhwRlFkZTU5WWpN?=
 =?utf-8?B?Z3hEUFpRTUdHWVA5a2YzR05nbzhCdlFXbThaR200M3lLNm50aHEwUDFtRjJr?=
 =?utf-8?B?dm10LzdJOVltTThGbG9BWmQ4N3JLbHUzK0NWd0VRNXlpRzB0RVR3VjNOZ2Qw?=
 =?utf-8?B?MjZuemZtc2pxWHNVY1dPNURKaHgzVlkwNVdaRjZ4RWozaEFDd05sZlVxUVhm?=
 =?utf-8?B?T0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92071d68-fed9-465c-a0a0-08dbf59bfd34
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 14:10:51.9253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BvYBecaWXWf8nIElPIsGnMMlLb4tVQsXMkrccE7EMDqJ84yPhnQFB/hDB5sS9ZL8gQ1watZy4ccSPju2agkoGAHwKDweDDb7ihnn1duH04I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7585
X-Proofpoint-GUID: 8mN6oAKABPLmgehhiHtzIHt862DjzowF
X-Proofpoint-ORIG-GUID: 8mN6oAKABPLmgehhiHtzIHt862DjzowF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311060001
 definitions=main-2312050111
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSHllb25nZ29uLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEh5
ZW9uZ2dvbiBZb28gPDQyLmh5ZXlvb0BnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2Vt
YmVyIDUsIDIwMjMgODo1NCBBTQ0KPiBUbzogc3h3amVhbkBtZS5jb20NCj4gQ2M6IHZiYWJrYUBz
dXNlLmN6OyBjbEBsaW51eC5jb207IGxpbnV4LW1tQGt2YWNrLm9yZzsgcGVuYmVyZ0BrZXJuZWwu
b3JnOw0KPiByaWVudGplc0Bnb29nbGUuY29tOyBpYW1qb29uc29vLmtpbUBsZ2UuY29tOyByb21h
bi5ndXNoY2hpbkBsaW51eC5kZXY7DQo+IGNvcmJldEBsd24ubmV0OyBrZWVzY29va0BjaHJvbWl1
bS5vcmc7IGFybmRAYXJuZGIuZGU7IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7DQo+IGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnOyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBTb25nLA0KPiBYaW9uZ3dlaSA8WGlvbmd3ZWkuU29uZ0B3
aW5kcml2ZXIuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDMvM10gbW0vc2x1YjogY29y
cmVjdCB0aGUgZGVmYXVsdCB2YWx1ZSBvZiBzbHViX21pbl9vYmplY3RzIGluIGRvYw0KPiANCj4g
T24gU3VuLCBEZWMgMywgMjAyMyBhdCA5OjE24oCvQU0gPHN4d2plYW5AbWUuY29tPiB3cm90ZToN
Cj4gPg0KPiA+IEZyb206IFhpb25nd2VpIFNvbmcgPHhpb25nd2VpLnNvbmdAd2luZHJpdmVyLmNv
bT4NCj4gPg0KPiA+IFRoZXJlIGlzIG5vIGEgdmFsdWUgYXNzaWduZWQgdG8gc2x1Yl9taW5fb2Jq
ZWN0cyBieSBkZWZhdWx0LCBpdCBhbHdheXMNCj4gPiBpcyAwIHRoYXQgaXMgaW5pdGlhbGl6ZWQg
YnkgY29tcGlsZXIgaWYgbm8gYXNzaWduZWQgdmFsdWUgYnkgY29tbWFuZCBsaW5lLg0KPiA+IG1p
bl9vYmplY3RzIGlzIGNhbGN1bGF0ZWQgYmFzZWQgb24gcHJvY2Vzc29yIG51bWJlcnMgaW4gY2Fs
Y3VsYXRlX29yZGVyKCkuDQo+ID4gRm9yIG1vcmUgZGV0YWlscywgc2VlIGNvbW1pdCA5YjJjZDUw
NmU1ZjIgKCJzbHViOiBDYWxjdWxhdGUgbWluX29iamVjdHMNCj4gPiBiYXNlZCBvbiBudW1iZXIg
b2YgcHJvY2Vzc29ycy4iKQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWGlvbmd3ZWkgU29uZyA8
eGlvbmd3ZWkuc29uZ0B3aW5kcml2ZXIuY29tPg0KPiANCj4gV2hpbGUgc2x1Yl9taW5fb2JqZWN0
cyBlcXVhbHMgemVybyBieSBkZWZhdWx0LCAnbWluX29iamVjdHMnIG92ZXJyaWRlcyBpdCB0bw0K
PiA0ICogKGZscyhucl9jcHVzKSArIDEpIHdoZW4gbm90IHNldC4gc28gd2hlbiBzbHViX21pbl9v
YmplY3RzIGlzIG5vdA0KPiBzZXQsIGl0IHdvdWxkIGJlDQo+IGVxdWFsIHRvIG9yIGhpZ2hlciB0
aGFuIDQuIEknbSBub3Qgc3VyZSB0aGlzIGxldmVsIG9mIGltcGxlbWVudGF0aW9uDQo+IGRldGFp
bCBpcyB3b3J0aCBkb2N1bWVudGluZy4NCg0KY29tbWl0IDliMmNkNTA2ZTVmMiAoInNsdWI6IENh
bGN1bGF0ZSBtaW5fb2JqZWN0cyBiYXNlZCBvbiBudW1iZXIgb2YgcHJvY2Vzc29ycy4iKQ0KaGFz
IGFscmVhZHkgZ2l2ZW4gInByb2Nlc3NvcnMgbWluX29iamVjdHMiIHBhaXIsIGRvIHdlIHJlYWxs
eSBuZWVkIHRvIGRvY3VtZW50DQp0aGUgc3BlY2lmaWMgZGV0YWlsPw0KDQo+IA0KPiBBbHNvLCBJ
IHRoaW5rIHBhdGNoIDIgc2hvdWxkIHVwZGF0ZSBEb2N1bWVudGF0aW9uL21tL3NsdWIucnN0IHRv
by4NCj4gKHNsdWJfJHBhcmFtIC0+IHNsYWJfcGFyYW0pDQpJIHRoaW5rIHBlb3BsZSBjYW4ga25v
dyBzbHViXyRwYXJhbXMgYXJlIHN0aWxsIHN1cHBvcnRlZCBieQ0KRG9jdW1lbnRhdGlvbi9tbS9z
bHViLnJzdCwgc28gd2UgZG9uJ3QgbmVlZCB0byBzYXkgdGhlIGluZm8gYWdhaW4gaW4NCnRoaXMg
ZmlsZS4gIElzIGl0IGJldHRlciB0byBkbyBzbyBqdXN0IGJlZm9yZSByZW1vdmluZyBzbHViXyRw
YXJhbXMNCmNvbXBsZXRlbHk/DQoNClJlZ2FyZHMsDQpYaW9uZ3dlaQ0KDQo+IA0KPiA+IC0tLQ0K
PiA+ICBEb2N1bWVudGF0aW9uL21tL3NsdWIucnN0IHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL21tL3NsdWIucnN0IGIvRG9jdW1lbnRhdGlvbi9tbS9zbHViLnJzdA0KPiA+
IGluZGV4IGJlNzU5NzE1MzJmNS4uMWY0Mzk5NTgxNDQ5IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3Vt
ZW50YXRpb24vbW0vc2x1Yi5yc3QNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL21tL3NsdWIucnN0
DQo+ID4gQEAgLTE1MCw3ICsxNTAsNyBAQCBsaXN0X2xvY2sgb25jZSBpbiBhIHdoaWxlIHRvIGRl
YWwgd2l0aCBwYXJ0aWFsIHNsYWJzLiBUaGF0IG92ZXJoZWFkIGlzDQo+ID4gIGdvdmVybmVkIGJ5
IHRoZSBvcmRlciBvZiB0aGUgYWxsb2NhdGlvbiBmb3IgZWFjaCBzbGFiLiBUaGUgYWxsb2NhdGlv
bnMNCj4gPiAgY2FuIGJlIGluZmx1ZW5jZWQgYnkga2VybmVsIHBhcmFtZXRlcnM6DQo+ID4NCj4g
PiAtLi4gc2x1Yl9taW5fb2JqZWN0cz14ICAgICAgICAgIChkZWZhdWx0IDQpDQo+ID4gKy4uIHNs
dWJfbWluX29iamVjdHM9eCAgICAgICAgICAoZGVmYXVsdCAwKQ0KPiA+ICAuLiBzbHViX21pbl9v
cmRlcj14ICAgICAgICAgICAgKGRlZmF1bHQgMCkNCj4gPiAgLi4gc2x1Yl9tYXhfb3JkZXI9eCAg
ICAgICAgICAgIChkZWZhdWx0IDMgKFBBR0VfQUxMT0NfQ09TVExZX09SREVSKSkNCj4gPg0KPiA+
IC0tDQo+ID4gMi4zNC4xDQo+ID4NCg==
