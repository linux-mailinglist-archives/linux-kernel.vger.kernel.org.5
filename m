Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F087EB666
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbjKNS3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKNS3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:29:52 -0500
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A904712A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 10:29:49 -0800 (PST)
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEIDO07022248;
        Tue, 14 Nov 2023 18:29:40 GMT
Received: from eur01-db5-obe.outbound.protection.outlook.com (mail-db5eur01lp2051.outbound.protection.outlook.com [104.47.2.51])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3uc9hms5vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 18:29:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFej8r1JAB1nuZusKnUJD3j3NXuRL8Pb7lQHcsPMxsWV3DRJV2HPvYkB8i6mjwzKz+QoCn5Q/UmWQY4ktlUFcUqH+6bjPJm69NRBEZpsBIMPDtqdN5tbQngWEeSocs7GEcwbeWQuIxzmF0C14Z3I20yQuQvdy6N8Rskqb2MW0tnaMdROOxqNlmu4lHbfsY2Ib0jTo9OfSYIG+6JUt6+HZ3fQoz4L+lVYdiwScuMCnGHr4Iq1oPNuztIZv+8nGv+YQFMVPiTXK8Ygk4NvB4AGjsJvv0hBxkb2NL6eKECoapJNN9BJap2SsudExNKQDVnfX+XfSvCwQeJrIV0ywlANTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYrY7iKxg4pfR/RJHl5azVRlccViE2bTWR8N7od3LjM=;
 b=fSsYGkWgD0rl+69r1C54XgpZio7aq6g3uPhC5f09Q+gsarj1fnJgxslS+Vw6rpHGKkAwXCifRKmMhOnpum3X57mgi01+Pw/gkRJn7+rSXephw4AfO6ExIW9LXzaXBV6OpnBqeiu0ESomNLczfLv82m/QexFafOhDMD0mCuENoAgEukySVB6DJDXcvlAlOqBi4XoxK5llWaGvN632KRxbKLFwmJ4Q3Xs6SmjREFuUXZRRovRIi9floRif2tOqfWHTw2MjIKXv5NB0faftbh+/Kqk45a5SrjBZnxAPi8TgFrTZZ8zY/GM4O0nVOT2+BsdPTdSgOnKx0IwzJf/jBXbEbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYrY7iKxg4pfR/RJHl5azVRlccViE2bTWR8N7od3LjM=;
 b=k7mAITDH3rzaUbzkm2lLY1eieK58jJ6QOu558zFL5LDxEj2JqRsoRdrGB+S1l6g/ZbLnacR0bN7VpnirZwMT/d8laDmWphWXQQlWzcAuLjjU7I/oTP3aVI8YG+tZBRuP7jFkq3lJjo0ehY2x6vBgUsQhCiJWQVNoqE5bptm2RSvf+ttyGP39qLHwP1i9k6WfIvBByuSX3d+epqcivVvFYWbBxoCdk0BoLWsJ+Y59tkt/myy0is3WrBqWd9C2A3Am8LkoD8xjYs2RoKCfeY56K8oU+yy2V6FVCzvjN1+n+NxI+w/DmTa2QA+5s1+556cHG+LJ6AwaU3mkGPNZC3HYwg==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by AS8PR03MB8369.eurprd03.prod.outlook.com (2603:10a6:20b:525::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 18:29:35 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::fea9:8f02:fb13:fd44]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::fea9:8f02:fb13:fd44%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 18:29:35 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 5/7] xen/events: drop xen_allocate_irqs_dynamic()
Thread-Topic: [PATCH 5/7] xen/events: drop xen_allocate_irqs_dynamic()
Thread-Index: AQHZ//oUYzlaLKzNvESKtKHtrAIYJrB5psyAgAAEXwCAAKXigA==
Date:   Tue, 14 Nov 2023 18:29:35 +0000
Message-ID: <8ea75027-7e0f-4ea7-8bad-219d67ebae2f@epam.com>
References: <20231016062831.20630-1-jgross@suse.com>
 <20231016062831.20630-6-jgross@suse.com>
 <955c998f-4550-4945-8dab-c5901d833074@epam.com>
 <c29136e0-054f-449d-b9f6-8116e3eea0c6@suse.com>
In-Reply-To: <c29136e0-054f-449d-b9f6-8116e3eea0c6@suse.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|AS8PR03MB8369:EE_
x-ms-office365-filtering-correlation-id: d1712c73-10aa-4b9a-6d55-08dbe53fa773
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bXJVBHuJ+KmRHsvd6wlq0UUY0l3lnbE6fNkv/3Wnve06d8WW+2Tc5qq6nE8tV+lr1sHPETBZHlrzH43mqxQmVq1p0nKmNlxh+2jsOlisO6tZeicPQHil/Gte2gFr6OV9cZswjz8h8gzMbaltdhaa4+fxw5PABDvjK3Wt2/PnXEm/Sk6SXnhIBkSUIAbJiHbJ1aVw/Jqaj3oOBnqJVjptRLCap3da1miMDWdrmlpSxaRM9xgy/oDodxp4NM9FVcBgdg+RQl+ZnKQRVPOAPh9IKHm/7GtSz7NKPeSd+i3Y3PrLp5IqPFPm6foXbJCfrZlslyxveT+fL8oCgW8KP6xeLfXF99r+DTltzZUxmPO2/QdZ+9t1uHYfmQIbemLF84KZhQbyW+3/UmSJgO42ugZYIXK/+8Zp8cZ/dYHBM237ZVH4ezmhejDd9ssO819mhiL3mrVLwBBrCvd8jAIzApRwlcwmAvJ0YOVBHcC+cDrOY1asfMflUxX6xcrA2dRrAGMdPmW114eKLpRKg+2bsuNt7mNpByWU0gfukdSeUIRE/fwIm0ySVkbvbKcFIKeHAJaI8DT76geq2emp46dthJDHSIWLVOSrUEXJ9eVjCxsXlGxbuC3mIFCPVL1vTCJsqc+cbenUht0WZrTWR0ikREen2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(122000001)(38100700002)(83380400001)(86362001)(5660300002)(2616005)(38070700009)(31686004)(6512007)(6506007)(53546011)(31696002)(478600001)(71200400001)(6486002)(36756003)(66946007)(316002)(76116006)(110136005)(54906003)(66446008)(66556008)(64756008)(91956017)(66476007)(8676002)(8936002)(4326008)(2906002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzVQZ0N3YThndnhBY3cvTU5nSnZJMG9jWndoRlJXTnd2dnI0bUVKc2U2Y1BQ?=
 =?utf-8?B?UVQ2ZmEzM3dYZjhvdDlxRmlUbkJvaUpEWWs4RU5HNTZsUG01c0Y3a2VJdHRm?=
 =?utf-8?B?M1hVdEpma0NYMjNYZ0xUNk9WZm9XSFZaM3YyNUI2MFhBN2JIMzRYVk85bU43?=
 =?utf-8?B?UmtiMGt2ZkUxaVVIaXlXUTJ6WkQ3TXN3ekpXVGlQWDJmY0dmZFZhS1Q4eWk2?=
 =?utf-8?B?b2s5c1A5SFUzWTV5ajZQNmc5WjRReTRYdklON1UrVmFwaHkvL2NFY2thMXIv?=
 =?utf-8?B?MFlwdmJCc3NybmlZdGgwS0lkeDA5MEs0VFRWQlZGYWhUUFdqOVpvc2sxQnJj?=
 =?utf-8?B?cGp6ZEVrMXNxeDdwUDhhOUVyRFovVlB6aTkvZmppQ0JxbEV1WTIrSXZrUitO?=
 =?utf-8?B?MkdNdzRWanBHK3VQTnBpUWhGR3F6cUFtYTFMT0hISy9kS2x6KzY3K2Q2SUJn?=
 =?utf-8?B?MHB1bnBNcUkzRno1bU93VmpHNmNGdStUSWRDMWYrUnU0UnZmUlppa2psRng4?=
 =?utf-8?B?YnpNSkFod08wWE9hb0pDVzI5bVFUODE3QlZBbHZWYVNKS2RWL3dPYzljYWtr?=
 =?utf-8?B?Vng0TkJWdmszOUI4RmNwMFFGbVlNeVdIWjMwWHhQZ1JlR1JyVFpLY1FLR2sv?=
 =?utf-8?B?RGtkZ1VCSVdvRkRzd01RdGF4aUxIbWZ0WG9TYjZaUldwSHQzM3cxWGVEeDk3?=
 =?utf-8?B?YnZ2SjVJSXJhNWV6VVFoYjY5NklGZC9sTUg0UFlDUnRxaDFVeGZGMHVoa1lp?=
 =?utf-8?B?UCswRmlWczMzRUo3ZUxKNFRIR0UwSVFKL0Z3WEREajZlODJtWDNFbTZoK1Zq?=
 =?utf-8?B?bk9SeGxKV0R6ZkNHakNrdVdSL1FZVGJtUzUxZ2RqcTIxWkp1YVRQRTFoSHRr?=
 =?utf-8?B?dFArcTUzeVZya0tkaGphUnNteS9tSFVOTFJSdGZ3MHpZZ1JzM3hoRFFqNHVy?=
 =?utf-8?B?SkxTb1kwa0w2NWdCYk4vZHQxb2ZpeUJIUmVBZFNlS2VNbVZnd0hkL0VkVmVp?=
 =?utf-8?B?TVJGcE5MZjExWkR6bDlPbVU0WEN1dTlQZXlnYVJ2aDZaaHhXS2lSZWhnU1NP?=
 =?utf-8?B?Rjc4SHZoa1RsZFNaSTJQWCtGZlRHTkhyM2V6aXBFWmpTdFU2d2VlZDlFc3U0?=
 =?utf-8?B?cFJaNmlVNjd4TENIUURURGNRcUxNcXplTTh4LzQzUllDTHIyTStjbFhkTnFQ?=
 =?utf-8?B?Z2svYTBLZTExZVN4ZlNtSWY1cWMxN01tWHdpWGtkMzEyemZ5U051YXdYTzFv?=
 =?utf-8?B?blJnOWR1OWpjUkp2RzJhZUVxaERLNXpwVjFlMkJMcHRSeG9ET3Vpc0trbDRj?=
 =?utf-8?B?RFdBbW9EZmFpS0kzYUtwOFJ1VVZrTlJHZG1NNkd0cUluQnAzdnNnU011TExT?=
 =?utf-8?B?M3FYTVJ3UkE0M3JJN3J3Z3B2eHhIeXhZSGtYMVEzNW1uRnNWdThhZ0lzaUZw?=
 =?utf-8?B?eDRqUFk4SjN4UDRuWG0rVWVuY05rQ0xYTUdzSVF1NnVMaXEzRnNHemtiUEox?=
 =?utf-8?B?OW1xeXVvNDRGVld6aExIblRLZEFLc0F6VWliY2NNYjB2a3pTb0JXN3hRRGlD?=
 =?utf-8?B?T2RrWU05aTd6elNRNldiUWVEazMrcHJsTDVSSmNvVGdzQXUxclMwS25RRnNy?=
 =?utf-8?B?Yi9pYkZkZzR5UVUwWGFqTEh5OERqNHBGZWVZQy9xN0FzKzdBYkNxdUNhalVS?=
 =?utf-8?B?T0RZcVdDd3RDT0M5cTFQaldoT2N0a004T2xSRUY5SFhYd29DajJIb05HTE1F?=
 =?utf-8?B?SVF4OXVKT0oxSGZMZFF0VW1xbk50RmxVaHV3cHd0dFVCYk8wMEY4Y1BEM3Zn?=
 =?utf-8?B?MzBDaVdpTmN2cEVQdkwwaFNnZ0pCRlBVRmFmS3RPMWtaZnRjMUNUYUFVTm4v?=
 =?utf-8?B?c2xOYkw3RVdaTytyREFZRWpObEhzTk9MbDJuRGtjOG5JVE1GZHNxTDdEdW81?=
 =?utf-8?B?dkl6TjhlNUdvelJkOVAzZENKa0RiUUVsaXpOckhNVHE2M2hucVI4UGpjeG5F?=
 =?utf-8?B?Tng2bGpQSFZxOUxwUzhKb1VEaUcxdG4zazBNZVNMcTJRMU1UdVVRelRtUzBp?=
 =?utf-8?B?NytQbzhFWnB6aXBpRDlySW9ETDd6RURyc2hwbWwyTnFYSmU3WGFpRWRpeFJy?=
 =?utf-8?B?N0x4RHVZdXc4N0dTNjFVY3psTC9yUUx4TzJyZzVOQUdxSm11RWRTc0YxZ3dQ?=
 =?utf-8?Q?PFPr+rk+XQ0JVrhfGOFNeGQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30BC16396265ED4681A634B2574211F9@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1712c73-10aa-4b9a-6d55-08dbe53fa773
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 18:29:35.7960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: osUeEyowPSRzr9gvjx6cnCjgMZjRSCfXZYfHBTNNqladZ8XYxu4VxjTV1dvpH5gqrJLaZcduMax4oJWmdJxJAHocY+mpiAixOiTxtIT5GFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8369
X-Proofpoint-ORIG-GUID: NjmB7ZQMQ5jZ6gjiC9R_pp4gQTKsL7bJ
X-Proofpoint-GUID: NjmB7ZQMQ5jZ6gjiC9R_pp4gQTKsL7bJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_16,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=981 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE0LjExLjIzIDEwOjM1LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KDQoNCkhlbGxvIEp1
ZXJnZW4NCg0KDQo+IE9uIDE0LjExLjIzIDA5OjIwLCBPbGVrc2FuZHIgVHlzaGNoZW5rbyB3cm90
ZToNCj4+DQo+Pg0KPj4gT24gMTYuMTAuMjMgMDk6MjgsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+
Pg0KPj4NCj4+IEhlbGxvIEp1ZXJnZW4NCj4+DQo+Pj4gSW5zdGVhZCBvZiBoYXZpbmcgYSBjb21t
b24gZnVuY3Rpb24gZm9yIGFsbG9jYXRpbmcgYSBzaW5nbGUgSVJRIG9yIGENCj4+PiBjb25zZWN1
dGl2ZSBudW1iZXIgb2YgSVJRcywgc3BsaXQgdXAgdGhlIGZ1bmN0aW9uYWxpdHkgaW50byB0aGUg
Y2FsbGVycw0KPj4+IG9mIHhlbl9hbGxvY2F0ZV9pcnFzX2R5bmFtaWMoKS4NCj4+Pg0KPj4+IFRo
aXMgYWxsb3dzIHRvIGhhbmRsZSBhbnkgYWxsb2NhdGlvbiBlcnJvciBpbiB4ZW5faXJxX2luaXQo
KSBncmFjZWZ1bGx5DQo+Pj4gaW5zdGVhZCBvZiBwYW5pY2luZyB0aGUgc3lzdGVtLiBMZXQgeGVu
X2lycV9pbml0KCkgcmV0dXJuIHRoZSBpcnFfaW5mbw0KPj4+IHBvaW50ZXIgb3IgTlVMTCBpbiBj
YXNlIG9mIGFuIGFsbG9jYXRpb24gZXJyb3IuDQo+Pj4NCj4+PiBBZGRpdGlvbmFsbHkgc2V0IHRo
ZSBJUlEgaW50byBpcnFfaW5mbyBhbHJlYWR5IGF0IGFsbG9jYXRpb24gdGltZSwgYXMNCj4+PiBv
dGhlcndpc2UgdGhlIElSUSB3b3VsZCBiZSAnMCcgKHdoaWNoIGlzIGEgdmFsaWQgSVJRIG51bWJl
cikgdW50aWwNCj4+PiBiZWluZyBzZXQuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+Pj4gLS0tDQo+Pj4gwqDCoCBkcml2ZXJzL3hlbi9l
dmVudHMvZXZlbnRzX2Jhc2UuYyB8IDc0IA0KPj4+ICsrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tDQo+Pj4gwqDCoCAxIGZpbGUgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwgMzAgZGVs
ZXRpb25zKC0pDQo+Pj4NCj4+DQo+PiBbc25pcF0NCj4+DQo+Pj4gQEAgLTE3MjUsNiArMTczOCw3
IEBAIHZvaWQgcmViaW5kX2V2dGNobl9pcnEoZXZ0Y2huX3BvcnRfdCBldnRjaG4sIA0KPj4+IGlu
dCBpcnEpDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHNvIHRoZXJlIHNob3VsZCBiZSBhIHByb3Bl
ciB0eXBlICovDQo+Pj4gwqDCoMKgwqDCoMKgIEJVR19PTihpbmZvLT50eXBlID09IElSUVRfVU5C
T1VORCk7DQo+Pj4gK8KgwqDCoCBpbmZvLT5pcnEgPSBpcnE7DQo+Pg0KPj4NCj4+IEkgZmFpbGVk
IHRvIHVuZGVyc3RhbmQgd2h5IHRoaXMgaXMgYWRkZWQgaGVyZS4gRG9lc24ndCBpcnEgcmVtYWlu
IHRoZQ0KPj4gc2FtZSwgYW5kIGluZm8tPmlycSByZW1haW5zIHZhbGlkPyBDb3VsZCB5b3UgcGxl
YXNlIGNsYXJpZnkuDQo+IA0KPiBUaGUgSVJRIHJlbWFpbnMgdGhlIHNhbWUsIGJ1dCB0aGUgZXZl
bnQgY2hhbm5lbCBjb3VsZCBjaGFuZ2UuDQo+IA0KPiBUaGlzIHNldHRpbmcgb2YgaW5mby0+aXJx
IGNvbXBlbnNhdGVzIGZvciB0aGUgcmVsYXRlZCByZW1vdmFsIGluDQo+IHhlbl9pcnFfaW5mb19j
b21tb25fc2V0dXAoKS4NCg0KDQpUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLCB5b3UgY2Fu
IGFkZCBteQ0KDQpSZXZpZXdlZC1ieTogT2xla3NhbmRyIFR5c2hjaGVua28gPG9sZWtzYW5kcl90
eXNoY2hlbmtvQGVwYW0uY29tPg0KDQo+IA0KPj4NCj4+IE90aGVyIGNoYW5nZXMgbGd0bS4NCj4g
DQo+IA0KPiBKdWVyZ2VuDQo+IA==
