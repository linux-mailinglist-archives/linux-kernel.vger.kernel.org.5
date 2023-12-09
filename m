Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35E880B12A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574893AbjLIBDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLIBDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:03:13 -0500
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4847C1716;
        Fri,  8 Dec 2023 17:03:19 -0800 (PST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B909gJv015667;
        Sat, 9 Dec 2023 01:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=kOdpQWM4BMmuGxBcyzQ86HwAcSraKSvsJ483SQgRMLc=; b=
        hnf5fqcBjdyMqlTtr+N2qaD3XCNFQZmFA2B8vcNbMozW15edY9z5ISqPg4Fl8JHm
        8IUJ1Q/LD8nUzQmV9O8leBawEHfzNoKKez5/UKKVJ4xrxilpEDRPnTlEDs+uFfkE
        aDbtcsGC/bJQyBpHi4WbX5WUUljXjdk8PE5lwCjy/WweUTnlzkYmROhLElgkZJUH
        65LXF0gnyKTjY+Top1Rv2+Dw9ZE/jDueqgkdIceluewwXFGUgxKTdmBEILsTdjAn
        lXufLBpMqDJ4h9381PsAEhnHPvRsZ1u15hTaZNe8UJxf0R+BihIr3jSEs3s4KJYT
        1QZaiR/hV6UMKLDY7hMSjw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3uvdexr27a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Dec 2023 01:02:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGkvZYWfeFN58A4wKv8u0pCH+a7MU7h+GDt5zmkvXWQ/l0a1cN7YE84haajIZOHff0sheb1QneEbUec0ycqAkf2h5vhXzaqnb0DiY4/4ghHTz7q2knqan5Jaae/Lfko8tF7d/WYv5EyVLkKM9jPmwsub2FInokcPNkf6NbHgwbZj22U9YFTuGXv0LAW7TztuOjZ5eSM0x4AzG8DLNNay0B4xILO9TsVwFOflNdVBiafyPjwrrZTF1hBlviWiTkiKPi7pXjgEqM+a4rRGuLXOHTOvb9tCFOoFKOh4jTRrVBY7sUUn6AEkkMuOl3pGCOLwA8nTlvMLtAcJG6LO1TmuBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOdpQWM4BMmuGxBcyzQ86HwAcSraKSvsJ483SQgRMLc=;
 b=LUv2WZZQAUF33Jha9/WVil124nGjYg3ttYT29ht54URU902RAoV3op2eaqeKwt3ZAJmaT1eJLDCHzhH98+9IoR1efSGdIe6uEnjFcqt5kkTLlAfvP4xRGsYhe5GL2w7bmf74mbFh59m39/0SSsLMk4CkcaAjBnNgK+DRDoXsZPtFtMxHMVVzHK14XPh6Ec5LrX6sECrEaxdNDVareZ15v3+GxlFuHP0/gkI/jPxugDUoYs5rqP8/+fTZzaHXKJ+wZDnGP5JIkfOTvLeDadsItZlHaUfetUDlJ7p02nZNPoko/xVIQJzJ0MTVflGtJQ8woyhyW9HXApGLeno0/0W3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by CH0PR11MB5347.namprd11.prod.outlook.com (2603:10b6:610:ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Sat, 9 Dec
 2023 01:02:39 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::928a:7606:e525:8b91]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::928a:7606:e525:8b91%6]) with mapi id 15.20.7068.028; Sat, 9 Dec 2023
 01:02:39 +0000
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
Thread-Index: AQHaJX4GvlmLVMf03U253wXUMYQC3bCcc6uAgAOzBDA=
Date:   Sat, 9 Dec 2023 01:02:38 +0000
Message-ID: <PH0PR11MB51928A8212F2EE25916524A3EC89A@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20231203001501.126339-1-sxwjean@me.com>
 <20231203001501.126339-3-sxwjean@me.com>
 <75a71276-dff8-ad3a-d238-fcfa3ab39413@suse.cz>
In-Reply-To: <75a71276-dff8-ad3a-d238-fcfa3ab39413@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|CH0PR11MB5347:EE_
x-ms-office365-filtering-correlation-id: 28699046-dd36-4955-64ec-08dbf8528a00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oz8AqKpb6GnLVdrh02y2HmPpJ/YQb9wYy0uenddh4vzRBNN8QTV9aNYhqxuMy21+ezUcgtUkasP3I1KGLLX/NwZQ2CzF0zQHxI7o+LyBq7T8henOHS7iqKCSplfZcH/1OTD4jWgtlu4ehIl45Tn3gTErgwEqSOYqakk2f4MMyOiu9fYs2OgmnMTg9aCmraZasR0tv8EV4ckEdDaZU1u/mKIS7Ob6IrR9fUQ+UQ/6PsNnYthENIfd1ASXZc5EohuGQ2X6gyDGsvBHZNkPLXY6lFta7PGtXFvlGkUKwQXUzMiNfiFovwXpI2LI0A/t7qlM9BFfut2M0b2NkMvVyQBA1DCNIkwim8XCgjQDZXIcknmcNHpt9OkLQsDXImgBmmMOeuNHlpRowLi9kcvP6uw0GAyHvsTbnV50yE8RYQxLXYCN8j9cVVSYb+t7v5KgVh60It26rBiC/C0ZBLXf8uRZB3+VQZWW9sdH2U/XajglEjAfDRTW3v9dRR7nzOgRZDCeAnILjVyu2s6AWYo9AZUFhIMD2PqWGcO2XrRA6Mzq1fAtle9qJQGYJevLVSpfKhuTI7joAw8PX63N4xP67F4ZjlCH0EdpItVxXh39+Q4IgTk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39850400004)(346002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(38070700009)(55016003)(8936002)(478600001)(8676002)(53546011)(38100700002)(9686003)(4326008)(71200400001)(966005)(7696005)(52536014)(66946007)(54906003)(64756008)(66446008)(66476007)(66556008)(76116006)(83380400001)(110136005)(316002)(7416002)(33656002)(2906002)(86362001)(41300700001)(5660300002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUVvRTk1MXJXM2FHSVhYaVptZ0Z3OU0yc1diS2FaQVhhWHcvVTREL0l0VHpv?=
 =?utf-8?B?NWlJNFlEMlpjSkNXZ3Boem03N3FXVDZnQ0hrK2V0QmlYU1dGZDlZcEtLM3Ey?=
 =?utf-8?B?ajczZXJQTGxCL0pNcWw4VFNDWnpkbXdEVFZ2VEV5S01lUER3c1V2Q1J5SWNy?=
 =?utf-8?B?SEtpOXJwbzh2M1RSckNRenF1djlpV00rMFI5YlA2NEo3Q0NJNUVGYjNzUHB6?=
 =?utf-8?B?TytMWGMvazIrMXJjNG5wUXI0U0VMS2FPbjVvWHNGbVExbjlkMDhneVZUY2p1?=
 =?utf-8?B?dEkrUWJBTWQ0WWxOcGw5MXZGeXlTVGYyY3B4VHA2dFVWcWYzTm90M0NERW8w?=
 =?utf-8?B?OWs0UGJJbGhEMDFhTmZzbUhnQ3hMRExENVloa295bGJJbXpOVGJVWTBPckJo?=
 =?utf-8?B?bWlzMjN3QVpnZVJ3VjNGa3hwOG51M1RiRVNPVnBRY0syYzNadnRaV2hEMmF0?=
 =?utf-8?B?dlloT0o4SmVSaGw2VVlOMTVGeG1XM1ZPcDVFbFY1OTgzWjdVOFZ5TGx1RjhW?=
 =?utf-8?B?VDNucUVMMUFSSUJNNTlOcnRWL0lTYkxIdVFqMEM3NjJnNGttQ3h3L1BtZVU0?=
 =?utf-8?B?cUQ1T1JGR1MzWDVlSTBSVGZuY0RMZVVXNTVzZ05oTDgrU1orWkQyS3pydUIr?=
 =?utf-8?B?Vy9WWFZaUXdQUzZHaTRtL2c2T0ZxcnhWLzVBTU1WQXZkSGZmUkN4dFFmd0h4?=
 =?utf-8?B?NnRNK2E4ZHhiOXBrNDNMQlJLTHJ4dE0wYmVNSGJPaU5MZGF6WlZidzRVRnBE?=
 =?utf-8?B?Zmhhem00VmlYTXF6Z3l3LzFHWm9ubEV5cjBUK0FMT1NKMS9yU3gyaHRqRkxo?=
 =?utf-8?B?cXBzTEN6Y3JBWkhzQjZkWVpvVXV2SlZkdXdTTlBVbzRDWFpQZm9NM2hPVG5m?=
 =?utf-8?B?YnJuUytkVW95ZDNJclM5aEJSd2I4OG9KVTR6QzF5WmRsVXpWd0FBbUFQUWF1?=
 =?utf-8?B?dnl5NVE0Z3hoWmZwUlhuRzN6VmtiYnBSamN6dWcxVmFHNUtXaDFvb0ZWejlY?=
 =?utf-8?B?N0NJMmhRQnV4Z1dKdmxDdjkvb1RpRG9peDNqSHBsN0drVmJjZ3g0VXYyclMv?=
 =?utf-8?B?bWN2aEhPMWtrd0RSR2tabnA5VnJhZDBrK0x4S3VwY2l6WlM1TGhoUVF5N2d1?=
 =?utf-8?B?clFDVHppNEp3TEJTa3lsNWU3TVljUGIrNW11bE9ONk5hVnR5T1dtM0JXMXZQ?=
 =?utf-8?B?MGY3Q04yV3Nwc3haMkpqeitpT0drd3cwa01wbnFQdUJCdTFWOG1TaDE3bGM1?=
 =?utf-8?B?Z2N4eFN6ZVdPSjF2RFJ2d1JSUFRZUG9JeGhrQUV1eWdmakZBdkhBUllHeDVv?=
 =?utf-8?B?bE5IR2hsdlBqTHBaR1pRU0p3VDlXR1M5T3ZQTlgzdGo3VUxLYnlnZk1OazA0?=
 =?utf-8?B?NE10eHliRlMvYlR0TFNlQU9kc0I3VHBseU15MmhKWFZwQ21EN2RDZ2FMMEtP?=
 =?utf-8?B?VVVBcUFlK0F1Z2c1cC9CVGtZczNsOHcrUnl5Mk5NaG5wY1plUmlyaXJuKy9T?=
 =?utf-8?B?T1BIZXBKMlAzdUVpcCtQOUtNWXdwNUdWWkg3QzVJMnQ3SFRJNHhGa2xYSXN3?=
 =?utf-8?B?M2ZEU3NRdGZiZ01EdlRqTkFsNjR1R21HQlNFUHBXMkJMRzY2enFZYkl6N1JS?=
 =?utf-8?B?aS9PUU9DZ3BUM3YwL2lOemdUQ0xJQzhhNXAyc1lBY0h0UUNmUHpDWUtuaEh1?=
 =?utf-8?B?aFNhTkRIVjh6V0ptSGlaS08vVW1CV3FHMEVBTG1tQlk5QVF1MVlpdnBmY1RC?=
 =?utf-8?B?TXU1VFV3aTdQZCtkUG5INXJwU3NXUkxDdzNuVHhJaERMeU11UzVoODE5eU95?=
 =?utf-8?B?L0w1cVdTRnZRNzE2QU56VGZRcGxOZzQ5T2JmTlorTkhlQlZTR1FOblIyTFhl?=
 =?utf-8?B?a0VZdmZLSzlMeVFsQWxxbmk3VVkrbmIxN3VWLzFHcHVqc1d3bkxIcmpQVmRm?=
 =?utf-8?B?RGhGZUVvQmduaXJ4bmZsd0k0VEgvdXNQMlRhazFoRVVqTXE3K0hReTJ2bGhw?=
 =?utf-8?B?MGh2NW9uRTNhWEpIeTFrVEMzTDBSWXhSajAwcHFjU0lMYlc2M0ozMnhGaDBu?=
 =?utf-8?B?WjBwZTFkTkUxL2hGaW9xenprTlZlZHV3MVpEM1N2Q0dZc1kvVW9OMGZpdDh3?=
 =?utf-8?B?ZW82QWY5Nm5mYWxiSXczd2szenlaaFBUL0I3ck14SXhPVjNHK05JNk5DaGhP?=
 =?utf-8?B?TkYydlZGQmFFQk1Ea1NtVUZCRE9vUjduaE1zVXJQOHhML2psbVVpRXRPYi9W?=
 =?utf-8?B?TCt5d3NvQzlWZHhFYlBWWU5lZGV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28699046-dd36-4955-64ec-08dbf8528a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2023 01:02:38.8966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XkfDJMDL2DE72C+4Xslo/JrXpyjQaGeTC5jLum+HP/LkrcErOjCUiORfG0XHUlhiE6w+rLDiuUsAHhDjgq8j0zJuo3HCIzNXxcDO8PR+pe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5347
X-Proofpoint-ORIG-GUID: B__9OzXO1Hr64S5cqVBhcNAIblr6cIxz
X-Proofpoint-GUID: B__9OzXO1Hr64S5cqVBhcNAIblr6cIxz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312090006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmxhc3RpbWlsIEJhYmth
IDx2YmFia2FAc3VzZS5jej4NCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDcsIDIwMjMgMTI6
MTUgQU0NCj4gVG86IHN4d2plYW5AbWUuY29tOyA0Mi5oeWV5b29AZ21haWwuY29tOyBjbEBsaW51
eC5jb207IGxpbnV4LW1tQGt2YWNrLm9yZw0KPiBDYzogcGVuYmVyZ0BrZXJuZWwub3JnOyByaWVu
dGplc0Bnb29nbGUuY29tOyBpYW1qb29uc29vLmtpbUBsZ2UuY29tOw0KPiByb21hbi5ndXNoY2hp
bkBsaW51eC5kZXY7IGNvcmJldEBsd24ubmV0OyBrZWVzY29va0BjaHJvbWl1bS5vcmc7IGFybmRA
YXJuZGIuZGU7DQo+IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7IGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnOyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgU29uZywgWGlvbmd3ZWkgPFhpb25nd2VpLlNvbmdAd2luZHJpdmVyLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjIgMi8zXSBtbS9zbHViOiB1bmlmeSBhbGwg
c2xbYXVdYiBwYXJhbWV0ZXJzIHdpdGggInNsYWJfJHBhcmFtIg0KPiANCj4gDQo+IE9uIDEyLzMv
MjMgMDE6MTUsIHN4d2plYW5AbWUuY29tIHdyb3RlOg0KPiA+IEZyb206IFhpb25nd2VpIFNvbmcg
PHhpb25nd2VpLnNvbmdAd2luZHJpdmVyLmNvbT4NCj4gPg0KPiA+IFNpbmNlIHRoZSBTTEFCIGFs
bG9jYXRvciBoYXMgYmVlbiByZW1vdmVkLCBzbyB3ZSBuZWVkIHRvIGNsZWFuIHVwIHRoZQ0KPiAN
Cj4gIndlIGNhbiBjbGVhbiB1cCIsIGFzIHdlIGRvbid0IHJlYWxseSAibmVlZCINCj4gDQo+ID4g
c2xbYXVdYl8kcGFyYW1zLiBIb3dldmVyLCB0aGUgInNsYWIvU0xBQiIgdGVybXMgc2hvdWxkIGJl
IGtlZXAgZm9yDQo+ID4gbG9uZy10ZXJtIHJhdGhlciB0aGFuICJzbHViL1NMVUIiLiBIZW5jZSwg
d2Ugc2hvdWxkIHVzZSAic2xhYl8kcGFyYW0iDQo+IA0KPiBJJ2QgcGhyYXNlIGl0OiBXaXRoIG9u
bHkgb25lIHNsYWIgYWxsb2NhdG9yIGxlZnQsIGl0J3MgYmV0dGVyIHRvIHVzZSB0aGUNCj4gZ2Vu
ZXJpYyAic2xhYiIgdGVybSBpbnN0ZWFkIG9mICJzbHViIiB3aGljaCBpcyBhbiBpbXBsZW1lbnRh
dGlvbiBkZXRhaWwuDQo+IEhlbmNlIC4uLg0KPiANCj4gPiBhcyB0aGUgcHJpbWFyeSBwcmVmaXgs
IHdoaWNoIGlzIHBvaW50ZWQgb3V0IGJ5IFZsYXN0aW1pbCBCYWJrYS4gRm9yIG1vcmUNCj4gPiBp
bmZvcm1hdGlvbiBwbGVhc2Ugc2VlIFsxXS4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggaXMgY2hhbmdp
bmcgdGhlIGZvbGxvd2luZyBzbGFiIHBhcmFtZXRlcnMNCj4gPiAtIHNsdWJfbWF4X29yZGVyDQo+
ID4gLSBzbHViX21pbl9vcmRlcg0KPiA+IC0gc2x1Yl9taW5fb2JqZWN0cw0KPiA+IC0gc2x1Yl9k
ZWJ1Zw0KPiA+IHRvDQo+ID4gLSBzbGFiX21heF9vcmRlcg0KPiA+IC0gc2xhYl9taW5fb3JkZXIN
Cj4gPiAtIHNsYWJfbWluX29iamVjdHMNCj4gPiAtIHNsYWJfZGVidWcNCj4gPiBhcyB0aGUgcHJp
bWFyeSBzbGFiIHBhcmFtZXRlcnMgaW4NCj4gPiBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tl
cm5lbC1wYXJhbWV0ZXJzLnR4dCBhbmQgc291cmNlLCBhbmQgcmVuYW1lIGFsbA0KPiA+IHNldHVw
IGZ1bmN0aW9ucyBvZiB0aGVtIHRvby4gTWVhbndoaWxlLCAic2x1Yl8kcGFyYW1zIiBjYW4gYWxz
byBiZSBwYXNzZWQNCj4gDQo+IE5vdCBzdXJlIGFib3V0IHJlbmFtaW5nIHRoZSBjb2RlIGF0IHRo
aXMgcG9pbnQsIEkgd291bGQganVzdCByZW5hbWUgdGhlDQo+IHVzZXItdmlzaWJsZSBwYXJhbWV0
ZXJzIGFuZCB0aGVpciBkb2N1bWVudGF0aW9uIGFuZCBhbnkgY29tbWVudCB0aGF0IHJlZmVycw0K
PiB0byB0aGUgcGFyYW1ldGVycy4gRnVuY3Rpb25zIGFuZCB2YXJpYWJsZXMgY2FuIGNvbWUgbGF0
ZXIgYXMgcGFydCBvZiB3aWRlcg0KPiBzbHViL3NsYWIgY2hhbmdlIGlmIHdlIGRlY2lkZSB0byBk
byBzbz8NCg0KSSB0aGluayB3ZSBjYW4gcmVuYW1lIHRoZXNlIGdsb2JhbCB2YXJpYWJsZXM6IA0K
ICAgIHNsdWJfbWF4X29yZGVyLA0KICAgIHNsdWJfbWluX29yZGVyLA0KICAgIHNsdWJfbWluX29i
amVjdHMsDQogICAgc2x1Yl9kZWJ1ZyANCiwgd2hpY2ggYXJlIHVzZWQgdG8gc2F2ZSB2YWx1ZXMg
dGhhdCBhcmUgZnJvbSBwYXJhbWV0ZXJzLiBCZWNhdXNlIHNvbWUgY29tbWVudHMNCmFyZSByZWZl
cnJpbmcgdG8gcGFyYW1ldGVycywgdGhlIG90aGVycyBhcmUgcmVmZXJyaW5nIHRvIHRoZXNlIGds
b2JhbCB2YXJpYWJsZXMsIHdoaWNoDQpsb29rcyBpbmNvbnNpc3RlbnQsIGUuZy4gc2x1Yl9kZWJ1
Zy9zbGFiX2RlYnVnLiAgSXMgaXQgYWNjZXB0YWJsZSB0byBtYWtlIHRoZW0NCmNvbnNpc3RlbnQ/
DQoNClJlZ2FyZHMsDQpYaW9uZ3dlaS4NCj4gDQo+ID4gYnkgY29tbWFuZCBsaW5lLCB3aGljaCBp
cyB0byBrZWVwIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkuIEFsc28gbWFyayBhbGwNCj4gPiAic2x1
Yl8kcGFyYW1zIiBhcyBsZWdhY3kuDQo+ID4NCj4gPiBUaGUgZnVuY3Rpb24NCj4gPiAgICAgc3Rh
dGljIGludCBfX2luaXQgc2V0dXBfc2x1Yl9kZWJ1ZyhjaGFyICpzdHIpOw0KPiA+ICwgd2hpY2gg
aXMgdG8gc2V0dXAgZGVidWcgZmxhZ3MgaW5zaWRlIGEgc2xhYiBkdXJpbmcga2VybmVsIGluaXQs
IGlzDQo+ID4gY2hhbmdlZCB0byBzZXR1cF9zbGFiX2RlYnVnX2ZsYWdzKCksIHdoaWNoIGlzIHRv
IHByZXZlbnQgdGhlIG5hbWUNCj4gPiBjb25mbGljdC4gQmVjYXVzZSB0aGVyZSBpcyBhbm90aGVy
IGZ1bmN0aW9uDQo+ID4gICAgIHZvaWQgc2V0dXBfc2xhYl9kZWJ1ZyhzdHJ1Y3Qga21lbV9jYWNo
ZSAqcywgc3RydWN0IHNsYWIgKnNsYWIsDQo+ID4gICAgICAgICAgICAgICB2b2lkICphZGRyKTsN
Cj4gPiAsIHdoaWNoIGlzIHRvIHBvaXNvbiBzbGFiIHNwYWNlLCB3b3VsZCBoYXZlIG5hbWUgY29u
ZmxpY3Qgd2l0aCB0aGUgcHJpb3INCj4gPiBvbmUuDQo+IA0KPiBBbm90aGVyIHJlYXNvbiB0byBk
ZWZlciBjb2RlIG5hbWluZyBjaGFuZ2VzLg0KPiANCj4gPiBGb3IgcGFyYW1ldGVyICJzbHViX2Rl
YnVnIiwgYmVzaWRlIHJlcGxhY2luZyBpdCB3aXRoICJzbGFiX2RlYnVnIiwgdGhlcmUNCj4gPiBh
cmUgc2V2ZXJhbCBnbG9iYWwgdmFyaWFibGVzLCBsb2NhbCB2YXJpYWJsZXMgYW5kIGZ1bmN0aW9u
cyB3aGljaCBhcmUNCj4gPiByZWxhdGVkIHdpdGggdGhlIHBhcmFtZXRlciwgbGV0J3MgcmVuYW1l
IHRoZW0gYWxsLg0KPiA+DQo+ID4gUmVtb3ZlIHRoZSBzZXBhcmF0ZSBkZXNjcmlwdGlvbnMgZm9y
IHNsdWJfW25vXW1lcmdlLCBhcHBlbmQgbGVnYWN5IHRpcA0KPiA+IGZvciB0aGVtIGF0IHRoZSBl
bmQgb2YgZGVzY3JpcHRpb25zIG9mIHNsYWJfW25vXW1lcmdlLg0KPiA+DQo+ID4gSSBkaWRuJ3Qg
Y2hhbmdlIHRoZSBwYXJhbWV0ZXJzIGluIERvY3VtZW50YXRpb24vbW0vc2x1Yi5yc3QgYmVjYXVz
ZSB0aGUNCj4gPiBmaWxlIG5hbWUgaXMgc3RpbGwgInNsdWIucnN0IiwgYW5kIHNsdWJfJHBhcmFt
cyBzdGlsbCBjYW4gYmUgdXNlZCBpbg0KPiA+IGtlcm5lbCBjb21tYW5kIGxpbmUgdG8ga2VlcCBi
YWNrd2FyZCBjb21wYXRpYmlsaXR5Lg0KPiA+DQo+ID4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LW1tLzc1MTJiMzUwLTQzMTctMjFhMC1mYWIzLTQxMDFiYzRkOGY3YUBzdXNlLmN6
Lw0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWGlvbmd3ZWkgU29uZyA8eGlvbmd3ZWkuc29uZ0B3
aW5kcml2ZXIuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFt
ZXRlcnMudHh0ICAgICAgICAgfCAgNDQgKysrLS0tDQo+ID4gIGRyaXZlcnMvbWlzYy9sa2R0bS9o
ZWFwLmMgICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQ0KPiA+ICBtbS9LY29uZmlnLmRlYnVn
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKy0NCj4gPiAgbW0vc2xhYi5oICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDE2ICstDQo+ID4gIG1tL3NsYWJf
Y29tbW9uLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgOCArLQ0KPiA+ICBtbS9z
bHViLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxNDIgKysrKysrKysr
LS0tLS0tLS0tDQo+ID4gIDYgZmlsZXMgY2hhbmdlZCwgMTA5IGluc2VydGlvbnMoKyksIDEwOSBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1
aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCBiL0RvY3VtZW50YXRpb24vYWRtaW4tDQo+IGd1aWRl
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
c28gYWNjZXB0ZWQgZm9yIG5vdykNCj4gDQo+ID4NCj4gPiAgICAgICBzbGFiX25vbWVyZ2UgICAg
W01NXQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBEaXNhYmxlIG1lcmdpbmcgb2Ygc2xhYnMg
d2l0aCBzaW1pbGFyIHNpemUuIE1heSBiZQ0KPiA+IEBAIC01ODgyLDQ3ICs1ODg0LDQxIEBADQo+
ID4gICAgICAgICAgICAgICAgICAgICAgIHVuY2hhbmdlZCkuIERlYnVnIG9wdGlvbnMgZGlzYWJs
ZSBtZXJnaW5nIG9uIHRoZWlyDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIG93bi4NCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgRm9yIG1vcmUgaW5mb3JtYXRpb24gc2VlIERvY3VtZW50YXRp
b24vbW0vc2x1Yi5yc3QuDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIChzbHViX25vbWVyZ2Ug
aXMgYWNjZXB0ZWQgdG9vLCBidXQgaXQncyBzdXBwb3J0ZWQgZm9yDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgIGxlZ2FjeSkNCj4gPg0KPiA+IC0gICAgIHNsYWJfbWF4X29yZGVyPSBbTU0sIFNM
QUJdDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIERldGVybWluZXMgdGhlIG1heGltdW0gYWxs
b3dlZCBvcmRlciBmb3Igc2xhYnMuDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIEEgaGlnaCBz
ZXR0aW5nIG1heSBjYXVzZSBPT01zIGR1ZSB0byBtZW1vcnkNCj4gPiAtICAgICAgICAgICAgICAg
ICAgICAgZnJhZ21lbnRhdGlvbi4gIERlZmF1bHRzIHRvIDEgZm9yIHN5c3RlbXMgd2l0aA0KPiA+
IC0gICAgICAgICAgICAgICAgICAgICBtb3JlIHRoYW4gMzJNQiBvZiBSQU0sIDAgb3RoZXJ3aXNl
Lg0KPiA+IC0NCj4gPiAtICAgICBzbHViX2RlYnVnWz1vcHRpb25zWyxzbGFic11bO1tvcHRpb25z
WyxzbGFic11dLi4uXSAgICAgIFtNTSwgU0xVQl0NCj4gPiAtICAgICAgICAgICAgICAgICAgICAg
RW5hYmxpbmcgc2x1Yl9kZWJ1ZyBhbGxvd3Mgb25lIHRvIGRldGVybWluZSB0aGUNCj4gPiArICAg
ICBzbGFiX2RlYnVnWz1vcHRpb25zWyxzbGFic11bO1tvcHRpb25zWyxzbGFic11dLi4uXSAgICAg
IFtNTV0NCj4gDQo+IEkgdGhpbmsgd2Ugc2hvdWxkIHJlLXNvcnQgYWxwaGFiZXRpY2FsbHkgYWZ0
ZXIgdGhlIHNsdWJfIC0+IHNsYWJfIGNoYW5nZS4NCj4gDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIEVuYWJsaW5nIHNsYWJfZGVidWcgYWxsb3dzIG9uZSB0byBkZXRlcm1pbmUgdGhlDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgIGN1bHByaXQgaWYgc2xhYiBvYmplY3RzIGJlY29tZSBjb3Jy
dXB0ZWQuIEVuYWJsaW5nDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIHNsdWJfZGVidWcgY2Fu
IGNyZWF0ZSBndWFyZCB6b25lcyBhcm91bmQgb2JqZWN0cyBhbmQNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgc2xhYl9kZWJ1ZyBjYW4gY3JlYXRlIGd1YXJkIHpvbmVzIGFyb3VuZCBvYmplY3Rz
IGFuZA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBtYXkgcG9pc29uIG9iamVjdHMgd2hlbiBu
b3QgaW4gdXNlLiBBbHNvIHRyYWNrcyB0aGUNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgbGFz
dCBhbGxvYyAvIGZyZWUuIEZvciBtb3JlIGluZm9ybWF0aW9uIHNlZQ0KPiA+IC0gICAgICAgICAg
ICAgICAgICAgICBEb2N1bWVudGF0aW9uL21tL3NsdWIucnN0Lg0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICBEb2N1bWVudGF0aW9uL21tL3NsdWIucnN0LiAoc2x1Yl9kZWJ1ZyBpcyBhY2NlcHRl
ZA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICB0b28sIGJ1dCBpdCdzIHN1cHBvcnRlZCBmb3Ig
bGVnYWN5KQ0KPiA+DQo+ID4gLSAgICAgc2x1Yl9tYXhfb3JkZXI9IFtNTSwgU0xVQl0NCj4gPiAr
ICAgICBzbGFiX21heF9vcmRlcj0gW01NXQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBEZXRl
cm1pbmVzIHRoZSBtYXhpbXVtIGFsbG93ZWQgb3JkZXIgZm9yIHNsYWJzLg0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICBBIGhpZ2ggc2V0dGluZyBtYXkgY2F1c2UgT09NcyBkdWUgdG8gbWVtb3J5
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIGZyYWdtZW50YXRpb24uIEZvciBtb3JlIGluZm9y
bWF0aW9uIHNlZQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICBEb2N1bWVudGF0aW9uL21tL3Ns
dWIucnN0Lg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBEb2N1bWVudGF0aW9uL21tL3NsdWIu
cnN0LiAoc2x1Yl9tYXhfb3JkZXIgaXMNCj4gPiArICAgICAgICAgICAgICAgICAgICAgYWNjZXB0
ZWQgdG9vLCBidXQgaXQncyBzdXBwb3J0ZWQgZm9yIGxlZ2FjeSkNCj4gPg0KPiA+IC0gICAgIHNs
dWJfbWluX29iamVjdHM9ICAgICAgIFtNTSwgU0xVQl0NCj4gPiArICAgICBzbGFiX21pbl9vYmpl
Y3RzPSAgICAgICBbTU1dDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIFRoZSBtaW5pbXVtIG51
bWJlciBvZiBvYmplY3RzIHBlciBzbGFiLiBTTFVCIHdpbGwNCj4gPiAtICAgICAgICAgICAgICAg
ICAgICAgaW5jcmVhc2UgdGhlIHNsYWIgb3JkZXIgdXAgdG8gc2x1Yl9tYXhfb3JkZXIgdG8NCj4g
PiArICAgICAgICAgICAgICAgICAgICAgaW5jcmVhc2UgdGhlIHNsYWIgb3JkZXIgdXAgdG8gc2xh
Yl9tYXhfb3JkZXIgdG8NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgZ2VuZXJhdGUgYSBzdWZm
aWNpZW50bHkgbGFyZ2Ugc2xhYiBhYmxlIHRvIGNvbnRhaW4NCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgdGhlIG51bWJlciBvZiBvYmplY3RzIGluZGljYXRlZC4gVGhlIGhpZ2hlciB0aGUgbnVt
YmVyDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIG9mIG9iamVjdHMgdGhlIHNtYWxsZXIgdGhl
IG92ZXJoZWFkIG9mIHRyYWNraW5nIHNsYWJzDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIGFu
ZCB0aGUgbGVzcyBmcmVxdWVudGx5IGxvY2tzIG5lZWQgdG8gYmUgYWNxdWlyZWQuDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgIEZvciBtb3JlIGluZm9ybWF0aW9uIHNlZSBEb2N1bWVudGF0aW9u
L21tL3NsdWIucnN0Lg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAoc2x1Yl9taW5fb2JqZWN0
cyBpcyBhY2NlcHRlZCB0b28sIGJ1dCBpdCdzIHN1cHBvcnRlZA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICBmb3IgbGVnYWN5KQ0KPiA+DQo+ID4gLSAgICAgc2x1Yl9taW5fb3JkZXI9IFtNTSwg
U0xVQl0NCj4gPiArICAgICBzbGFiX21pbl9vcmRlcj0gW01NXQ0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICBEZXRlcm1pbmVzIHRoZSBtaW5pbXVtIHBhZ2Ugb3JkZXIgZm9yIHNsYWJzLiBNdXN0
IGJlDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIGxvd2VyIHRoYW4gc2x1Yl9tYXhfb3JkZXIu
DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIEZvciBtb3JlIGluZm9ybWF0aW9uIHNlZSBEb2N1
bWVudGF0aW9uL21tL3NsdWIucnN0Lg0KPiA+IC0NCj4gPiAtICAgICBzbHViX21lcmdlICAgICAg
W01NLCBTTFVCXQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICBTYW1lIHdpdGggc2xhYl9tZXJn
ZS4NCj4gPiAtDQo+ID4gLSAgICAgc2x1Yl9ub21lcmdlICAgIFtNTSwgU0xVQl0NCj4gPiAtICAg
ICAgICAgICAgICAgICAgICAgU2FtZSB3aXRoIHNsYWJfbm9tZXJnZS4gVGhpcyBpcyBzdXBwb3J0
ZWQgZm9yIGxlZ2FjeS4NCj4gPiAtICAgICAgICAgICAgICAgICAgICAgU2VlIHNsYWJfbm9tZXJn
ZSBmb3IgbW9yZSBpbmZvcm1hdGlvbi4NCj4gPiArICAgICAgICAgICAgICAgICAgICAgbG93ZXIg
dGhhbiBzbGFiX21heF9vcmRlci4gRm9yIG1vcmUgaW5mb3JtYXRpb24gc2VlDQo+IA0KPiAgICAg
ICAgICAgICAgICAgImxvd2VyIG9yIGVxdWFsIHRvIiAobW9yZSBwcmVjaXNlLCB3aGlsZSBhdCBp
dCkNCj4gDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIERvY3VtZW50YXRpb24vbW0vc2x1Yi5y
c3QuIChzbHViX21pbl9vcmRlciBpcyBhY2NlcHRlZA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICB0b28sIGJ1dCBpdCdzIHN1cHBvcnRlZCBmb3IgbGVnYWN5KQ0KPiA+DQo+ID4gICAgICAgc21h
cnQyPSAgICAgICAgIFtIV10NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgRm9ybWF0OiA8aW8x
PlssPGlvMj5bLC4uLiw8aW84Pl1dDQo+IA0KPiBUaGFua3MhDQoNCg==
