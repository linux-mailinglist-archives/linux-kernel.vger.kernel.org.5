Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488257FB124
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbjK1FTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1FTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:19:45 -0500
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB93194;
        Mon, 27 Nov 2023 21:19:49 -0800 (PST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3AS4rGaZ028968;
        Tue, 28 Nov 2023 05:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=yDyATkW0qc1NXozTZFZomcg/NP0i2xL+pAH2OofBpF8=; b=
        KhZN/ysP0R1xNpAjj5PddiNosnZQ9kCaPgmSa99or4c/NXFdfGGAZLAkV8cuRhhb
        KbthkU9f9MSqFyGBVa9bH8uNyW6lOf+nXx3h7HiyQENTqEKxgY5sHBxrIcfiybn8
        wmISpZ7ZaoNoG8+EIiWkZ9Ud6dcL5aXviT5U7IVbP7JQrS0R+LAvHCgaIz/jE4KA
        CPWxWT40PQ2tVOCQgdN7MxRH6MZOcRkxAXR0mlqzBrxFL33lNDM5ERv7yaSQ0Bhw
        lVe4YfjSk2NI6XcBHhFNKq7fAI704Fj0LAVGdCQ3wu07TzTBrlm9q0W6Z9wTC7jk
        DMTZFwhpUgfeiVPpqrk46Q==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3uk64xjcj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 05:19:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaERhbZI1KlpASX1oNhOy9uMfRPG0gJwxK4EqkjfI+80Zcg/giy/lu5wLR2Pu0CrQJS9rGpFgs8YONctYbJlimVjvOSRTmD4qQJh4ktC3GNH8dxVxMPppIJJPYIXmYXWOFDTQxhpJxrukH70YPu4gPlhFTLQ7Dm9yA5R5RRvSTdSJyvUBPOErqvZejv1hHiQhbO4EiPWPf/SBptKAIY4faVN3/Sbx/ZmgTKfmoDuxYlijNg/zq1iZkChHkzMxJ49/PZ5PJDz7DuMyPbUbozGtRPgy6FC8glsnQLwkas5hF956+VsfyCLfMw3VPXT/nTGBXCe7YOTgbx2lOiLEIOq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDyATkW0qc1NXozTZFZomcg/NP0i2xL+pAH2OofBpF8=;
 b=H5CwnQKxnxT99ugcGQ9+hpIXi+loIfbSHo/vw2xW49B3jTH4hnOyxz+dfgTBcgoi3KuYjjcgUPkal/XIO7NAeI+CP705ltO0et2oq+tK1kSAPOI3TZIAwY3D6DVBVHe7J8Ir7rlDpCYKQZLrfIc0jfopLylWBhRDhXRYzZ2yVr3lll/vFy4Q4rYASzoBmrcaeSfSRlSJ2oULExcHfpQ5WRjHE2wL4VcHRc/++TEAtaEZCGc/OAFB7/7lG4HI7mfHCe3gsn1PBpjadtBn2J25ZxL5FVD4hEDowLonTvTX5ZBAzCbxRZCC9NhErNqdVNkJ2gx8BaEGiQBBx3KkBAYJLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by DM4PR11MB6383.namprd11.prod.outlook.com (2603:10b6:8:bf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 05:18:58 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::cc54:6503:20fd:46d5]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::cc54:6503:20fd:46d5%7]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 05:18:58 +0000
From:   "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        "sxwjean@me.com" <sxwjean@me.com>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] Documentation: kernel-parameters: remove
 slab_max_order and noaliencache
Thread-Topic: [PATCH v2] Documentation: kernel-parameters: remove
 slab_max_order and noaliencache
Thread-Index: AQHaHVFRLDt9h0WjjkGvj0A7QVrUS7CJVtuAgALe1PCAAeLggIABISOg
Date:   Tue, 28 Nov 2023 05:18:57 +0000
Message-ID: <PH0PR11MB51929C73CA26257742E7D1DDECBCA@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20231122143603.85297-1-sxwjean@me.com>
 <7512b350-4317-21a0-fab3-4101bc4d8f7a@suse.cz>
 <PH0PR11MB51929193317D75141C28059BECBEA@PH0PR11MB5192.namprd11.prod.outlook.com>
 <2f8e8e28-28d4-b0a4-11a8-639f78c319c3@suse.cz>
In-Reply-To: <2f8e8e28-28d4-b0a4-11a8-639f78c319c3@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|DM4PR11MB6383:EE_
x-ms-office365-filtering-correlation-id: dfdcacdc-8398-4c70-13e8-08dbefd18621
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FvTcqN6HpIcXdFZV9mjceJQd/EkCUYJ28igbFi2tw8M7u5JMNWVm/jRLNYLrhl1j6uJb+czbw5Gjz5/RL2RM1piUz5Wgcz+zi8yjmIv055nVL5vqsRTZYzQqlh69eVAO4uELCxILTZMX8ew6vCpBgR/e4ldJV66jh3H49C9SMwfvTCUvy00PszpVEefHJdTdtZrcdwx9bvxL1psBSVg9g1hE6JD5XUdbmiJBdOztCNoy//kbGZaMYdkGFLsXvbCWPIMQeSnEYye3eVLZL0eFt/K/z2LMggjR27bDQnYQG/Uoe0N0f0bmD2VghwEl/92ry8qxKkGazOvoGxzchIn3sGoS0URq6bgAErThjOFO4AkAnhUum87VEq0Pm2SzhSiLl1gNgZ3Sdk1Ca6MR1d8WCcywK5oszVFJvYss3eU2A+6cXYiPbWrKVG7a5zlpnCqG/6hH7KrSj7oWgJMGDMSDHBhpud9987EffL5T8FGHShukfOypJpLgaDBv/ej3omTURfpPrBEbkIZZQE7NK1hsx36B52QXa4umyyeyF3YBlSnirGzEoRB8pk2FXyciRKkKj0R9udEpn4NcQ00E1GBIQMKGjZJ0UUZphvXHSaJSqj3FSS536uUz9Xbe4FqwTF/ZDdzEAHoP7GSk5vMAGd3kKQJmhGEMIQvVjOnkv2VYRqNybEOC/MLRaFiMAN8DcFBV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(136003)(396003)(346002)(376002)(230173577357003)(230922051799003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(54906003)(38100700002)(83380400001)(38070700009)(122000001)(33656002)(86362001)(66556008)(66446008)(64756008)(41300700001)(8676002)(76116006)(110136005)(8936002)(4326008)(52536014)(55016003)(7416002)(5660300002)(2906002)(7696005)(9686003)(66476007)(66946007)(6506007)(53546011)(316002)(478600001)(26005)(966005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THVmNDlnQXlqRVRoV3p0ZnZsZGJXd2ZWUVgzd2I0SHd1aWlXaEc4WkJDaWhN?=
 =?utf-8?B?ZnZyV1NkanRpS2tma0JCWE00cmVkbW9BQ3I0anNqMXBsbHlmeEVMQVV5bVM4?=
 =?utf-8?B?WFZNQ21YQWV6dzJBOUp6Qk5Eb3M3VWh5VUtwby9lM2lEdWpEdENLYi92K1FU?=
 =?utf-8?B?QjF5VFFWdmdHSFJJeW01a0xPUU5wMGlnMjhRUG1qV1ZsQlEycWU2VjE5K21p?=
 =?utf-8?B?cXFWTTg0TzdQMzBXemZzMjV0dWlTa0NTWHEwTXZLMmc4ZTZWeXM3Y3kwOGp2?=
 =?utf-8?B?U0ZWNlhUVithaXRtdy9SM0QyOWt3Q2RXL0x4V094Z2lhYzJiRkZhSVQ1bjZT?=
 =?utf-8?B?dk5PZFJBdDc5dGlPNkVJc2w1U2NRVVhLRUdmU2QwSlVicjRSSGFObnlzL1dl?=
 =?utf-8?B?MGo5d1hqUTBlckEvZ20zT2JVa2piS3ZVeFd5UHMrMDBBMmFmRVpxZTIzWXZa?=
 =?utf-8?B?Y24yNS9TVkVzVk5LYUhIak9nWFdFU1ZOblRVYVBzMUZiVW5iWnZvalBsWDVU?=
 =?utf-8?B?K0tMcnZ5T1NEenZ1TytFT3BPaUlOR1UwdGNDQ0huRURWYW9uaDdDT3R2d1hh?=
 =?utf-8?B?cGMxYmZ6OE40NWhjRlpwMGNVeGltWTZzNWNSaEhzOTFsYXFud1ZaRWRTMEZF?=
 =?utf-8?B?dmwvUTZUdVpRamo5aWdmSDRVMCtDZWR1N0xHazZPRHgxMHRhakJMVERvTlQ1?=
 =?utf-8?B?VXVNaXpEMklVMVY5QmVlQ3NVaUF2cWZncW9TSnBqKzlrRm8vZ2lMVndFb1ZS?=
 =?utf-8?B?T0NRNkJqbEZDbGYrWEdlTHJtVHM2a0dNUDNNUGN2MXZ6ZTJCbXJMcVQvVzdm?=
 =?utf-8?B?aGNnNmNCU1hnWDVTc2V3Mm84Qzc4UHhpK0VrZXpBNzc4dFZlMzh0OVdDMWJC?=
 =?utf-8?B?Y3lLdUdjOTNsYmpMUE1mK3kwMlEzdmxJWU82cG9oczg5TDRtSGloV25odXd1?=
 =?utf-8?B?RjBhUzFFazVNYTZTTEZrYWZ3dndxVDJRVkZzRnc2ZWptUWorNDVLY0RHMU5G?=
 =?utf-8?B?WHJQaWx0UG9SNFZVWHEvdlpwWEZCeU9nVnVPY0VaanJMd1FSaGNtdHNyNU5L?=
 =?utf-8?B?WllDdDBSVzQwKy9LUUtrRGpUOUlyQ2Y5L0FYM0FCWGwxTWwxUFVCckdVeTNK?=
 =?utf-8?B?MU1xSnc3Y3F5R3NoSlNvSngrVGJMU1lkMUx2M2pkUnp1VS9aRHBpeElJTWN6?=
 =?utf-8?B?algxaDVrTTJPQ1pwbld6czdEZ1ExSVdOcDhxUFl4RlpWeXJzaEV0d3hZZGNs?=
 =?utf-8?B?NU5oc2lNdWJIVy9WdjJOM1R1bGhLdnFnby90WmgySHNERHBjRDB2bTZlZ0ZI?=
 =?utf-8?B?U0RPUmJ1cXU4K3NCam9LeGN5L3ZCa1lYK1VzMEFURFcyWStpNFlzZm9QSmov?=
 =?utf-8?B?MTRTRnhmWUF0SVYzYjZ5VXhIaWZKTnVvbGxESTU5dm95MW52Y05SVlJjRnVy?=
 =?utf-8?B?b2JsOXR5QXJOWWJXZVpoMGNrcWJ2RE9Od2tRa3VZUjgvRjZIZlI0ZFplSXpT?=
 =?utf-8?B?aC8wWFBVVGRYTE1aMUUwd0pXWXJ2Y3pjMGJtdStnYnB2NnFoWnlKT1BPaThw?=
 =?utf-8?B?ZjdPNGRCMFN3MGhTU2V6bEgrQjU0SzlLZ3ZSdXJnTXdsRDBlYmVTNjNKd3lM?=
 =?utf-8?B?MktqKzRteG5WU2x5MHNhY0dXNlpMMFZVNU1XcXJFaHRRUUIyMS95VS83aitC?=
 =?utf-8?B?SlNDb01aUTZ6TTU3dEdQRHVOSU8yUjZNWll0WDJVTFVsMlF6RmNzMXZEMUs3?=
 =?utf-8?B?SWU1dHhwVnVpS1NsS1ZOVlZuTVJiLzlvUXVNeVY1ekg5VGFvRzFzNU5LdEdE?=
 =?utf-8?B?YU9ZWEczMlAvVHVab3RHNi9wVk1rWlc2QUxYelpNRFBYZytaK0xxR1ZRUkJP?=
 =?utf-8?B?enZoMmNMeDJDTEZlaTJBdjhYdGhjeVJ5aWtkTEF1OGlpc2hER2J2UGZ2eGsz?=
 =?utf-8?B?M09nWDh1WC8zSXNhdG5sSWhZNjI4eHYxWUFNTk1kZTZJSEZ4U3IxV3FrNUI3?=
 =?utf-8?B?anZYeTlsM3oxSHFod1dJbTJPRmtvbFh6cE83amVGZHpwVTdjQzdKVXQrR213?=
 =?utf-8?B?RTd3bGhvNFN1dE1YcEZWcE1GZ2h5bXBCYWcvQng5VTVXRERxR0Q3THlSd1Rs?=
 =?utf-8?B?cnl5cmZtQ2RwMXJ1MnJGT09kdmRHUk85b2lLejBmRGNEaFd5RmVUNGgyQVlr?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdcacdc-8398-4c70-13e8-08dbefd18621
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 05:18:58.0173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DUKLVJ2j0Ik9ZVhcM50S3NEmUf7CfqYbjFxPAiiy0bhT+mXsAc/UFUFp+SiaRIg6mEkCflxdcpXXkrPjV/Uj7BdQGEDz+LQO1fKTlP0z7Ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6383
X-Proofpoint-ORIG-GUID: J1O1lrFBYmTCzxi8xM0YTRvUR4YLf3mf
X-Proofpoint-GUID: J1O1lrFBYmTCzxi8xM0YTRvUR4YLf3mf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 bulkscore=0 clxscore=1011 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2311280039
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
IDx2YmFia2FAc3VzZS5jej4NCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAyNywgMjAyMyA4OjAz
IFBNDQo+IFRvOiBTb25nLCBYaW9uZ3dlaSA8WGlvbmd3ZWkuU29uZ0B3aW5kcml2ZXIuY29tPjsg
c3h3amVhbkBtZS5jb207DQo+IDQyLmh5ZXlvb0BnbWFpbC5jb207IGxpbnV4LW1tQGt2YWNrLm9y
Zw0KPiBDYzogY2xAbGludXguY29tOyBwZW5iZXJnQGtlcm5lbC5vcmc7IHJpZW50amVzQGdvb2ds
ZS5jb207IGlhbWpvb25zb28ua2ltQGxnZS5jb207DQo+IGFrcG1AbGludXgtZm91bmRhdGlvbi5v
cmc7IHJvbWFuLmd1c2hjaGluQGxpbnV4LmRldjsgY29yYmV0QGx3bi5uZXQ7IGxpbnV4LQ0KPiBk
b2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjJdIERvY3VtZW50YXRpb246IGtlcm5lbC1wYXJhbWV0ZXJzOiByZW1v
dmUgc2xhYl9tYXhfb3JkZXIgYW5kDQo+IG5vYWxpZW5jYWNoZQ0KPiANCj4gQ0FVVElPTjogVGhp
cyBlbWFpbCBjb21lcyBmcm9tIGEgbm9uIFdpbmQgUml2ZXIgZW1haWwgYWNjb3VudCENCj4gRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUg
dGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudA0KPiBpcyBzYWZlLg0KPiANCj4gT24gMTEv
MjYvMjMgMDg6MjUsIFNvbmcsIFhpb25nd2VpIHdyb3RlOg0KPiA+IEhpIFZsYXN0aW1pbCwNCj4g
Pg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBWbGFzdGltaWwg
QmFia2EgPHZiYWJrYUBzdXNlLmN6Pg0KPiA+PiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDI0LCAy
MDIzIDc6MjQgUE0NCj4gPj4gVG86IHN4d2plYW5AbWUuY29tOyA0Mi5oeWV5b29AZ21haWwuY29t
OyBsaW51eC1tbUBrdmFjay5vcmcNCj4gPj4gQ2M6IGNsQGxpbnV4LmNvbTsgcGVuYmVyZ0BrZXJu
ZWwub3JnOyByaWVudGplc0Bnb29nbGUuY29tOyBpYW1qb29uc29vLmtpbUBsZ2UuY29tOw0KPiA+
PiBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyByb21hbi5ndXNoY2hpbkBsaW51eC5kZXY7IGNv
cmJldEBsd24ubmV0OyBsaW51eC0NCj4gPj4gZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgU29uZywgWGlvbmd3ZWkNCj4gPj4gPFhpb25nd2VpLlNvbmdA
d2luZHJpdmVyLmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gRG9jdW1lbnRhdGlv
bjoga2VybmVsLXBhcmFtZXRlcnM6IHJlbW92ZSBzbGFiX21heF9vcmRlciBhbmQNCj4gPj4gbm9h
bGllbmNhY2hlDQo+ID4+DQo+ID4+DQo+ID4+IE9uIDExLzIyLzIzIDE1OjM2LCBzeHdqZWFuQG1l
LmNvbSB3cm90ZToNCj4gPj4gPiBGcm9tOiBYaW9uZ3dlaSBTb25nIDx4aW9uZ3dlaS5zb25nQHdp
bmRyaXZlci5jb20+DQo+ID4+ID4NCj4gPj4gPiBTaW5jZSBzbGFiIGFsbG9jYXRvciBoYXMgYWxy
ZWFkeSBiZWVuIHJlbW92ZWQuIFRoZXJlIGlzIG5vIHVzZXJzIGFib3V0DQo+ID4+ID4gc2xhYl9t
YXhfb3JkZXIgYW5kIG5vYWxpZW5jYWNoZSwgc28gbGV0J3MgcmVtb3ZlIHRoZW0uDQo+ID4+ID4N
Cj4gPj4gPiBTaWduZWQtb2ZmLWJ5OiBYaW9uZ3dlaSBTb25nIDx4aW9uZ3dlaS5zb25nQHdpbmRy
aXZlci5jb20+DQo+ID4+ID4gLS0tDQo+ID4+ID4gdjI6IEh5ZW9uZ2dvbiBZb28gPDQyLmh5ZXlv
b0BnbWFpbC5jb20+IHN1Z2dlc3RlZCB0aGF0IG5vYWxpZW5jYWNoZSBzaG91bGQgYmUNCj4gPj4g
PiByZW1vdmVkIHRvby4gSGVyZSBhZGRpbmcgdGhpcyBjaGFuZ2UuIFRoZSBwYXRjaCBpcyBiYXNl
ZCBvbiBbMV0uDQo+ID4+ID4NCj4gPj4gPiBbMV0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvdmJhYmthL2xpbnV4LmdpdC9sb2cvP2g9c2xhYi0NCj4gcmVt
b3ZlLQ0KPiA+PiBzbGFiLXYycjENCj4gPj4gPg0KPiA+PiA+IHYxOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1tbS8yMDIzMTEyMDA5MTIxNC4xNTA1MDItMS0NCj4gPj4gc3h3amVhbkBt
ZS5jb20vVC8jbTU1ZWJiNDU4NTFiYzg2ZDY1MGJhZjY1ZGZlODI5NmQzM2M1YjExMjYNCj4gPj4g
PiAtLS0NCj4gPj4gPiAgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVy
cy50eHQgfCAxMCAtLS0tLS0tLS0tDQo+ID4+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBkZWxldGlv
bnMoLSkNCj4gPj4gPg0KPiA+PiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1
aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPiBiL0RvY3VtZW50YXRpb24vYWRtaW4tDQo+ID4+
IGd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPiA+PiA+IGluZGV4IDY1NzMxYjA2MGUzZi4u
ZDU2YTViZWVmZTI0IDEwMDY0NA0KPiA+PiA+IC0tLSBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3Vp
ZGUva2VybmVsLXBhcmFtZXRlcnMudHh0DQo+ID4+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9hZG1p
bi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCj4gPj4gPiBAQCAtMzc0MCwxMCArMzc0MCw2
IEBADQo+ID4+ID4gICAgICAgbm81bHZsICAgICAgICAgIFtYODYtNjQsUklTQ1ZdIERpc2FibGUg
NS1sZXZlbCBwYWdpbmcgbW9kZS4gRm9yY2VzDQo+ID4+ID4gICAgICAgICAgICAgICAgICAgICAg
IGtlcm5lbCB0byB1c2UgNC1sZXZlbCBwYWdpbmcgaW5zdGVhZC4NCj4gPj4gPg0KPiA+PiA+IC0g
ICAgIG5vYWxpZW5jYWNoZSAgICBbTU0sIE5VTUEsIFNMQUJdIERpc2FibGVzIHRoZSBhbGxvY2F0
aW9uIG9mIGFsaWVuDQo+ID4+ID4gLSAgICAgICAgICAgICAgICAgICAgIGNhY2hlcyBpbiB0aGUg
c2xhYiBhbGxvY2F0b3IuICBTYXZlcyBwZXItbm9kZSBtZW1vcnksDQo+ID4+ID4gLSAgICAgICAg
ICAgICAgICAgICAgIGJ1dCB3aWxsIGltcGFjdCBwZXJmb3JtYW5jZS4NCj4gPj4NCj4gPj4gTm8g
cXVlc3Rpb24gYWJvdXQgdGhpcyBvbmUsIGNhbiBiZSBkZWxldGVkLg0KPiA+Pg0KPiA+PiA+IC0N
Cj4gPj4gPiAgICAgICBub2FsaWduICAgICAgICAgW0tOTCxBUk1dDQo+ID4+ID4NCj4gPj4gPiAg
ICAgICBub2FsdGluc3RyICAgICAgW1MzOTBdIERpc2FibGVzIGFsdGVybmF0aXZlIGluc3RydWN0
aW9ucyBwYXRjaGluZw0KPiA+PiA+IEBAIC01ODg3LDEyICs1ODgzLDYgQEANCj4gPj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgb3duLg0KPiA+PiA+ICAgICAgICAgICAgICAgICAgICAgICBGb3Ig
bW9yZSBpbmZvcm1hdGlvbiBzZWUgRG9jdW1lbnRhdGlvbi9tbS9zbHViLnJzdC4NCj4gPj4gPg0K
PiA+PiA+IC0gICAgIHNsYWJfbWF4X29yZGVyPSBbTU0sIFNMQUJdDQo+ID4+ID4gLSAgICAgICAg
ICAgICAgICAgICAgIERldGVybWluZXMgdGhlIG1heGltdW0gYWxsb3dlZCBvcmRlciBmb3Igc2xh
YnMuDQo+ID4+ID4gLSAgICAgICAgICAgICAgICAgICAgIEEgaGlnaCBzZXR0aW5nIG1heSBjYXVz
ZSBPT01zIGR1ZSB0byBtZW1vcnkNCj4gPj4gPiAtICAgICAgICAgICAgICAgICAgICAgZnJhZ21l
bnRhdGlvbi4gIERlZmF1bHRzIHRvIDEgZm9yIHN5c3RlbXMgd2l0aA0KPiA+PiA+IC0gICAgICAg
ICAgICAgICAgICAgICBtb3JlIHRoYW4gMzJNQiBvZiBSQU0sIDAgb3RoZXJ3aXNlLg0KPiA+Pg0K
PiA+PiBJIHRoaW5rIGhlcmUgd2Ugc2hvdWxkIGNvbnNpZGVyIHRoZSBsb25nLXRlcm0gcGxhbiBm
aXJzdC4gSXQncyBhIGJpdA0KPiA+PiB1bmZvcnR1bmF0ZSAoaW4gaGluZHNpZ2h0KSBTTFVCIGJy
b3VnaHQgaXRzIG93biBwcmVmaXggb2YgcGFyYW1ldGVycywgZXZlbg0KPiA+PiBpZiBzb21lIGJl
Y2FtZSBpbnRlcmNoYW5nZWFibGUgYWxpYXNlcyBsYXRlciAoc2xhYi9zbHViX25vbWVyZ2UpLCBz
b21lIG5vdC4NCj4gPj4gSSB0aGluayBpdCB3b3VsZCBiZSBiZXN0IHRvIHVuaWZ5IHRoZW0sIGFu
ZCBjb25zaWRlciB0aGUgc3RyaW5nICJzbHViIiBhbg0KPiA+PiBpbXBsZW1lbnRhdGlvbiBkZXRh
aWwgb2YgdGhlIGdlbmVyYWwgInNsYWIgYWxsb2NhdG9yIiB0ZXJtIGdvaW5nIGZvcndhcmQuDQo+
ID4+DQo+ID4+IFNvIHdoYXQgSSdkIHByb3Bvc2UgaXMgdGhhdCB3ZSBjaGFuZ2UgYWxsIHBhcmFt
ZXRlcnMgdG8gYWNjZXB0IGENCj4gPj4gInNsYWJfJHBhcmFtIiBhcyBhIHByaW1hcnkgYW5kIGRv
Y3VtZW50ZWQgbmFtZSAoYW5kIHRoZSBkZXNjcmlwdGlvbiBjYW4NCj4gPj4gY29udGFpbiBqdXN0
IFtNTV0gdGFnLCBubyBbU0xBQl0gb3IgW1NMVUJdIG5lZWRlZCksIHdpdGggInNsdWJfJHBhcmFt
IiBpcw0KPiA+PiBhbHNvIGFjY2VwdGVkIGFzIGFuIGFsaWFzIHdoZXJlIGl0IGV4aXN0cyB0b2Rh
eSwgYW5kIHRoZXJlJ3MganVzdCBhIG5vdGUNCj4gPj4gdGhhdCB0aGUgc2x1Yl8kcGFyYW0gbmFt
ZSBpcyBhbHNvIGFjY2VwdGVkIGluIHRoZSBkZXNjcmlwdGlvbiBvZiB0aGUNCj4gPj4gY2Fub25p
Y2FsIHBhcmFtZXRlciwgbm90IGluIGEgc2VwYXJhdGUgZGVzY3JpcHRpb24uIFRoZW4gbWF5YmUg
aW4gYSBmZXcNCj4gPj4geWVhcnMgd2UgY2FuIG1hcmsgdGhlIG9sZCBuYW1lcyBhcyBkZXByZWNh
dGVkIGFuZCBzdGFydCBpc3N1aW5nIGxvdy1rZXkNCj4gPj4gd2FybmluZ3MgKHdoaWxlIHN0aWxs
IGFjY2VwdGluZyB0aGVtKSwgYW5kIGluIDEwIHllYXJzIG1heWJlIHJlbW92ZSB0aGVtDQo+ID4+
IGNvbXBsZXRlbHkuIFRob3VnaHRzPw0KPiA+DQo+ID4gU29ycnksIEkgZGlkbid0IGtub3cgdGhl
IFNMVUIgaGlzdG9yeSwgdGhhbmtzIGZvciB0aGUgY29tbWVudHMgYW5kIHByb3Bvc2FsLg0KPiA+
DQo+ID4gRGlkIHlvdSBtZWFuIHRoZSByb3VnaCBkaWZmIGJlbG93Pw0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0IGIv
RG9jdW1lbnRhdGlvbi9hZG1pbi0NCj4gZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0DQo+ID4g
aW5kZXggNjU3MzFiMDYwZTNmLi5kYjZkMmViZTdjN2QgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCj4gPiArKysgYi9Eb2N1
bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPiA+IEBAIC01ODcx
LDEwICs1ODcxLDEyIEBADQo+ID4gICAgICAgICAgc2xyYW09ICAgICAgICAgIFtIVyxNVERdDQo+
ID4NCj4gPiAgICAgICAgICBzbGFiX21lcmdlICAgICAgW01NXQ0KPiA+ICsgICAgICAgc2x1Yl9t
ZXJnZSAgICAgIFtNTV0NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgRW5hYmxlIG1lcmdp
bmcgb2Ygc2xhYnMgd2l0aCBzaW1pbGFyIHNpemUgd2hlbiB0aGUNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAga2VybmVsIGlzIGJ1aWx0IHdpdGhvdXQgQ09ORklHX1NMQUJfTUVSR0VfREVG
QVVMVC4NCj4gDQo+IEknZCBob3BlIHRoZSByZXN1bHQgbG9vayBtb3JlIGxpa2UgdGhpcywgc28g
dGhlIGR1cGxpY2F0ZSBuYW1lcyBhcmUgbm90DQo+IHNvIHByb21pbmVudC4NCj4gDQo+ICAgICAg
ICAgc2xhYl9tZXJnZSAgICAgIFtNTV0NCj4gICAgICAgICAgICAgICAgICAgICAgICAgRW5hYmxl
IG1lcmdpbmcgb2Ygc2xhYnMgd2l0aCBzaW1pbGFyIHNpemUgd2hlbiB0aGUNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAga2VybmVsIGlzIGJ1aWx0IHdpdGhvdXQgQ09ORklHX1NMQUJfTUVSR0Vf
REVGQVVMVC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgKHNsdWJfbWVyZ2UgYWxzbyBhY2Nl
cHRlZCBhcyBhbiBhbGlhcykNCj4gDQo+IE5vdGUgdGhhdCBpdCdzIG5vdCBqdXN0IGEgRG9jdW1l
bnRhdGlvbiBjaGFuZ2UgYW55bW9yZSwgYXMgbWFueSBvZiB0aGUNCj4gcGFyYW1ldGVycyBkb24n
dCBoYXZlIHRoZSBzbGFiXyB2YXJpYW50cyB5ZXQgd2lyZWQgdXAuDQoNCk9rLCB0aGFua3MuIFdp
bGwgY3JlYXRlIGEgcGF0Y2ggZm9yIGl0Lg0KDQpSZWdhcmRzLA0KWGlvbmd3ZWkNCg0KPiANCj4g
Pg0KPiA+ICAgICAgICAgIHNsYWJfbm9tZXJnZSAgICBbTU1dDQo+ID4gKyAgICAgICBzbHViX25v
bWVyZ2UgICAgW01NXQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICBEaXNhYmxlIG1lcmdp
bmcgb2Ygc2xhYnMgd2l0aCBzaW1pbGFyIHNpemUuIE1heSBiZQ0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICBuZWNlc3NhcnkgaWYgdGhlcmUgaXMgc29tZSByZWFzb24gdG8gZGlzdGluZ3Vp
c2gNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgYWxsb2NzIHRvIGRpZmZlcmVudCBzbGFi
cywgZXNwZWNpYWxseSBpbiBoYXJkZW5lZA0KPiA+IEBAIC01ODg3LDEyICs1ODg5LDYgQEANCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgb3duLg0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICBGb3IgbW9yZSBpbmZvcm1hdGlvbiBzZWUgRG9jdW1lbnRhdGlvbi9tbS9zbHViLnJzdC4N
Cj4gPg0KPiA+IC0gICAgICAgc2xhYl9tYXhfb3JkZXI9IFtNTSwgU0xBQl0NCj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICBEZXRlcm1pbmVzIHRoZSBtYXhpbXVtIGFsbG93ZWQgb3JkZXIgZm9y
IHNsYWJzLg0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIEEgaGlnaCBzZXR0aW5nIG1heSBj
YXVzZSBPT01zIGR1ZSB0byBtZW1vcnkNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBmcmFn
bWVudGF0aW9uLiAgRGVmYXVsdHMgdG8gMSBmb3Igc3lzdGVtcyB3aXRoDQo+ID4gLSAgICAgICAg
ICAgICAgICAgICAgICAgbW9yZSB0aGFuIDMyTUIgb2YgUkFNLCAwIG90aGVyd2lzZS4NCj4gPiAt
DQo+ID4gICAgICAgICAgc2x1Yl9kZWJ1Z1s9b3B0aW9uc1ssc2xhYnNdWztbb3B0aW9uc1ssc2xh
YnNdXS4uLl0gICAgICBbTU0sIFNMVUJdDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIEVu
YWJsaW5nIHNsdWJfZGVidWcgYWxsb3dzIG9uZSB0byBkZXRlcm1pbmUgdGhlDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgIGN1bHByaXQgaWYgc2xhYiBvYmplY3RzIGJlY29tZSBjb3JydXB0
ZWQuIEVuYWJsaW5nDQo+ID4gQEAgLTU5MDEsMTMgKzU4OTcsMTUgQEANCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgbGFzdCBhbGxvYyAvIGZyZWUuIEZvciBtb3JlIGluZm9ybWF0aW9uIHNl
ZQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICBEb2N1bWVudGF0aW9uL21tL3NsdWIucnN0
Lg0KPiA+DQo+ID4gLSAgICAgICBzbHViX21heF9vcmRlcj0gW01NLCBTTFVCXQ0KPiA+ICsgICAg
ICAgc2xhYl9tYXhfb3JkZXI9IFtNTV0NCj4gPiArICAgICAgIHNsdWJfbWF4X29yZGVyPSBbTU1d
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIERldGVybWluZXMgdGhlIG1heGltdW0gYWxs
b3dlZCBvcmRlciBmb3Igc2xhYnMuDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIEEgaGln
aCBzZXR0aW5nIG1heSBjYXVzZSBPT01zIGR1ZSB0byBtZW1vcnkNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgZnJhZ21lbnRhdGlvbi4gRm9yIG1vcmUgaW5mb3JtYXRpb24gc2VlDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgIERvY3VtZW50YXRpb24vbW0vc2x1Yi5yc3QuDQo+ID4N
Cj4gPiAtICAgICAgIHNsdWJfbWluX29iamVjdHM9ICAgICAgIFtNTSwgU0xVQl0NCj4gPiArICAg
ICAgIHNsYWJfbWluX29iamVjdHM9ICAgICAgIFtNTV0NCj4gPiArICAgICAgIHNsdWJfbWluX29i
amVjdHM9ICAgICAgIFtNTV0NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgVGhlIG1pbmlt
dW0gbnVtYmVyIG9mIG9iamVjdHMgcGVyIHNsYWIuIFNMVUIgd2lsbA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICBpbmNyZWFzZSB0aGUgc2xhYiBvcmRlciB1cCB0byBzbHViX21heF9vcmRl
ciB0bw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICBnZW5lcmF0ZSBhIHN1ZmZpY2llbnRs
eSBsYXJnZSBzbGFiIGFibGUgdG8gY29udGFpbg0KPiA+IEBAIC01OTE2LDE4ICs1OTE0LDEyIEBA
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIGFuZCB0aGUgbGVzcyBmcmVxdWVudGx5IGxv
Y2tzIG5lZWQgdG8gYmUgYWNxdWlyZWQuDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIEZv
ciBtb3JlIGluZm9ybWF0aW9uIHNlZSBEb2N1bWVudGF0aW9uL21tL3NsdWIucnN0Lg0KPiA+DQo+
ID4gLSAgICAgICBzbHViX21pbl9vcmRlcj0gW01NLCBTTFVCXQ0KPiA+ICsgICAgICAgc2x1Yl9t
aW5fb3JkZXI9IFtNTV0NCj4gPiArICAgICAgIHNsYWJfbWluX29yZGVyPSBbTU1dDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgIERldGVybWluZXMgdGhlIG1pbmltdW0gcGFnZSBvcmRlciBm
b3Igc2xhYnMuDQo+ID4gTXVzdCBiZQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICBsb3dl
ciB0aGFuIHNsdWJfbWF4X29yZGVyLg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICBGb3Ig
bW9yZSBpbmZvcm1hdGlvbiBzZWUgRG9jdW1lbnRhdGlvbi9tbS9zbHViLnJzdC4NCj4gPg0KPiA+
IC0gICAgICAgc2x1Yl9tZXJnZSAgICAgIFtNTSwgU0xVQl0NCj4gPiAtICAgICAgICAgICAgICAg
ICAgICAgICBTYW1lIHdpdGggc2xhYl9tZXJnZS4NCj4gPiAtDQo+ID4gLSAgICAgICBzbHViX25v
bWVyZ2UgICAgW01NLCBTTFVCXQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIFNhbWUgd2l0
aCBzbGFiX25vbWVyZ2UuIFRoaXMgaXMgc3VwcG9ydGVkIGZvcg0KPiA+IGxlZ2FjeS4NCj4gPiAt
ICAgICAgICAgICAgICAgICAgICAgICBTZWUgc2xhYl9ub21lcmdlIGZvciBtb3JlIGluZm9ybWF0
aW9uLg0KPiA+IC0NCj4gPiAgICAgICAgICBzbWFydDI9ICAgICAgICAgW0hXXQ0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICBGb3JtYXQ6IDxpbzE+Wyw8aW8yPlssLi4uLDxpbzg+XV0NCj4g
Pg0KPiA+IElmIHNvIEkgdGhpbmsgd2Ugc2hvdWxkIHVzZSBzbGFiXyZwYXJhbSBpbiBtbS9zbHVi
LmMuIFdoZW4gaGl0dGluZyAic2x1Yl8kcGFyYW0iDQo+ID4gd2UgbmVlZCB0byBhc3NpZ24gdGhl
IHZhbHVlIHRvICJzbGFiXyZwYXJhbSIgbGlrZSAic2xhYl9ub21lcmdlIiwgcmlnaHQ/DQo+ID4N
Cj4gPiBSZWdhcmRzLA0KPiA+IFhpb25nd2VpDQoNCg==
