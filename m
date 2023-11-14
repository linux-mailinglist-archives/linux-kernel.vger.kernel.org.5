Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CB67EB643
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjKNSRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKNSQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:16:59 -0500
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFADD120
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 10:16:55 -0800 (PST)
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEIEJxW003590;
        Tue, 14 Nov 2023 18:16:46 GMT
Received: from eur04-db3-obe.outbound.protection.outlook.com (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3ubpk9ccaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 18:16:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvtQdpJeembNOVEtjDMbfSuftZFXoTfhdxwLZH/C9ZW4+jTRBlRkVaNmnNmcLkce33Nuc1eQXilBVJ8/dMXL0lTuRmF4PWk4MeUg+knWtrRvyrwU3D/D7358pti1X19YsA6yKdwM5EAktHo0l8FO7lOEuJW/UoaDNgbfQDrWol48DM2GCC3CibPDn4fIaot9zcsIn24RjWzjKCxSUQ6CMs7PIkWRgUNNyQmG0Tzo/S4fW2yu0c1Z9u2WaEujX7HPIKPG5vHewNhzeeiiy14v9+La4wfYlPj6jU82sHBs0sIGfYfNGawBnLAyoFj+2MlgfPRykE39eYFX1f7FujfWDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snhrVvvN4n1+9E1UVn5rS3vpAdArREM6gOElex3dLIg=;
 b=gSqgqnlB4bMRw53CI8tvwHigAbLSMjICxQsn4KIzQrGbrase1Qu6uWZX2k+Mb2sG34wyC9zhZ5RUuCcZOw8ZjzLtZy0leK7Nx6Mhf+Z0zjtWkNlmQkmNumh4m2qGAZx4/CvAMqZwdusSDCWicVD5k7w2ClE1zhwe7OkcKuowtbWU6deuXlE9cJhW6Fjgeggrz8WvIyL9qiMnfsReXpTUs6EXDRK/s8Pcd5rh1YKeO6xPzdieSe5mvPO7YUgfMuLcW6p0FEScjR6iZPJMXxRBVXQ7XjBqrSSzWgpWONlZ1aDWSKRQNXLQPTFMo3W097+1aVPHsRunSQzLpkg0oFPDlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snhrVvvN4n1+9E1UVn5rS3vpAdArREM6gOElex3dLIg=;
 b=gW4QeQ32kf8GRi1RrzFQ6X6qQA4QYVVdRkfBqnVpdm+m6LmR8GQ2psC1FuzRNBjy3okQGcJ/KR4bMSDpmmum6ikVXpOGJG4gv4o859AgYsTUQikgskHg7amIxRTcY9fJaiitLQQIvDTI3xjiAyd8HeTkFFMCIU1hAAxqfI3iHNULy4Mrv/ZL/jjQDH7u5eomMy2XuO4E6HSAqvKDRS61LYwbzuvGg1aQxxjznky7Pyk49BP5j/JOacBVJOOOQyYCa1kbBJ1MGxWExcwZPA5SrsFFm/BlG2efBmSwAmhieAgkpyn3jCRC/yo/05a/IKrg6k65P91bG7+Ps1MQOJrHvg==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by DBBPR03MB7017.eurprd03.prod.outlook.com (2603:10a6:10:201::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 18:16:42 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::fea9:8f02:fb13:fd44]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::fea9:8f02:fb13:fd44%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 18:16:42 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 7/7] xen/events: remove some info_for_irq() calls in pirq
 handling
Thread-Topic: [PATCH 7/7] xen/events: remove some info_for_irq() calls in pirq
 handling
Thread-Index: AQHZ//oeBwkqjiPvKEql1DMh00sxAbB6TXqA
Date:   Tue, 14 Nov 2023 18:16:41 +0000
Message-ID: <1a62fc9a-7bd2-4fed-a690-0a12f2724044@epam.com>
References: <20231016062831.20630-1-jgross@suse.com>
 <20231016062831.20630-8-jgross@suse.com>
In-Reply-To: <20231016062831.20630-8-jgross@suse.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|DBBPR03MB7017:EE_
x-ms-office365-filtering-correlation-id: a2062262-b042-49bd-bebd-08dbe53dda33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aZ4vxKZsTfc1i4esPGAbu+/6RS9Umd0Cvxg6ZTJCootQzy0CpllMLN3WEPvqXlq8z90XiKZOu44ITP5+/Y/U8RFJvmLMH/eyNZtzfaIS9Acyupu4kzMb2mISJrwHPxdWnNgkXEnpZtH0CzxNTUGrT9SrIurf54DG/qRcNZ2kyGZIGaxePR0EsJ5PhejrvryS3XBWsoh6+SO2B2GLnJayJrQRSIQd3NmvQxX/AOhyh2xCuafYzO1fGhe7VwgHA+aWzc7a4FyvrTmlhV6TJwv8/00aksuVpla4EVqudKEadvUuLf+0d6EsuLpFU0nt1LOIu4jU2XNe1DZ9FrAiQPmXPl6ZOQqsFrCakzgFhwfLmk5n0RPCCNgabmpme6JAcoJKO3akj/sDhUNL37+sZSJ3CV/I2oQMQng+AJpHzNwkKcXFqNyAcJ97Khk7DX5Eu8MKxjeUpX/B975cwvfY8j/TQx/cic4NsolO8YPCjXOX7nPqhlEEU7CmU59LJOPGIv0BBYUVPMjwtQ2P4muLxrijV4E4+TOivyHz9S/XNB7dCHqzDp7UtU/jsUQPwKx5WS0MmYeg26PSvbuXgEY+6Yedpus7fAQxxCqiTFVoPsynZ1HKcht1kV/epiQMCRXgyLjnOQyOTtdCGf8ckFD66EWe7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(366004)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(122000001)(38100700002)(86362001)(5660300002)(38070700009)(2616005)(31686004)(6512007)(6506007)(53546011)(31696002)(478600001)(71200400001)(6486002)(36756003)(66946007)(316002)(76116006)(110136005)(54906003)(66446008)(66556008)(64756008)(91956017)(66476007)(2906002)(8676002)(8936002)(4326008)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azJmekl0bCtqOTltQ2czczdNZzJyWXNDL3JGV2VmTVNwem5nZ0wrMGVFelZn?=
 =?utf-8?B?L205RGdUNnRIaVdWbzl2Q1h3T2FjTFJnL3p3bzNHTXVpWXFpd3V0dS90QkJx?=
 =?utf-8?B?NmdtRFZua2VtOHpjbXpoZWZjNlVFcGxjaTZoeEcyVGRoVHIzZEgyVndqS1I1?=
 =?utf-8?B?ZzFWOHdtVFZqSThKeWh6ekpYZ004NGp6T2lhb0Myak93bHc5bkpQaHc4Smdl?=
 =?utf-8?B?UDdJRUtzaDl4dWNDV2dpWHZzVHdrYnEyMXJWdCtCZDFSejhWd1pBOFZKaXBX?=
 =?utf-8?B?NzNTTER3WVdyOEw4WUdlcnBuTjBkOS9JV2IxbHZHTnF0Qk1kMk4xUlI0cWMx?=
 =?utf-8?B?M2Y4L1ZxVFJnZ0p1dGY2UXAwTFZLWFpjaTVkVFlmc2UxK1JzR2NlYWhiVVY1?=
 =?utf-8?B?bUxpVXZWa0dabEZ5SUtaRUNMNmlOQ3VHdVdUSjdYdFgvY2JhblQxaVZPTkRp?=
 =?utf-8?B?VlV1TitpU2s4cGFzTFlFMlQvdGJubE41WG5maWVZZzlqeEZzTU1pYW82Z3J4?=
 =?utf-8?B?SmxnZ2FtWHlOeGVFL1RTR09hTUMvbDhzWktWWlp5czgzcmU1TmQvaGszZTEx?=
 =?utf-8?B?R3dSOVFtb1o0dVBhN2R0cXg2Y1poc0p3dEZVRmJxWXZWc01uZzN0RHQzWERW?=
 =?utf-8?B?SG52Wm8zQXVIZnFXSVBtOTRUeGNWYjdlTmlVODBPVEYxRmppb2QxQWswVGlo?=
 =?utf-8?B?WER4UUM0d2JwZHBhK3djYzBoSEJxcVZFMFJoQnR3dktNUWVtdm9uVnRBSzVs?=
 =?utf-8?B?bVlISUROZ2dGWTdaenBBbzdiTG9mOWdUUEhKQytKb1lSSHlYQWw0OEpwTDY2?=
 =?utf-8?B?L1U2ZEFENHFFWlF5UEoyOEFDWG80MS83cGtUWjRVOHBYQnRWZklLb1dXUlZw?=
 =?utf-8?B?UWQ1WW1Kay9LQWlWTU83ckdMUEhWMjJZWngveS9xMGVGKyt1allhS2M1Mytr?=
 =?utf-8?B?L3FIdXAvejFZc2N3bVZrYTQ2NmpOSW9DY09xV2JNalU3L1p0YjFiZGM2NzM4?=
 =?utf-8?B?THV1RklhV2loaXlZeHJoR1lRNmwxVUw4RVdCTDNZWWxWWFBkUWdaRWpCbk5N?=
 =?utf-8?B?enlOc0RMYVBXYjJhSU1XbG1YaG9rTXQ1ZWc2U1AvNGlQSXYvdExwczFGMWVU?=
 =?utf-8?B?ZkE0b2dtNlFBL0JPQzU1d2l5bCtyOUpVc1Z3VzJoSjZ3dWpub2NrQ2N2SHlQ?=
 =?utf-8?B?Snc3VmN5UE5hU2VKbGNvNmVGMWFmbjRrTy94VkpjRTFnS1o3UkcrY3VPRUFv?=
 =?utf-8?B?RUdyckRVdVkwSTI1eWlUaWtCK1paUWhuUnZKQUpkalF2cVdtWVAzRmpOY1hZ?=
 =?utf-8?B?L0M2Z1F6eURIcklSRjVUZjdpTDVQdXQxZC96RWd6NmxjY0YzeE90bGRzcWtI?=
 =?utf-8?B?ZFU1SDdVeXNObk8rUDdYQU03b0RLbUx2YWVrNzBhNGQvcnEzMU40MmZXVUxW?=
 =?utf-8?B?aHhRdVFJOTE3WndpZHhWWkMwWnNnSlB4QXVPMGsvdzV0bUdCK3JZRWF4enYr?=
 =?utf-8?B?ZGhyM0ptbEwyV1FsY0doeGR0RmFwdVVPQktHV0h2Y0JtSW9HbGtsMEdKdGsw?=
 =?utf-8?B?eGd3SnBENEJ6Q01SbWl1QUVnS2kxT3pjeTFaTlVDcWxGNkhDUVlkSW0ydWtj?=
 =?utf-8?B?WFhSNVhwaUd3Y3hGbFUzUWRQOXJLYkhGd283WEh3VUFISUNPRFh2ZmlUbEox?=
 =?utf-8?B?RmUzaVYzVUJ3UUtSS0dKL0RkTFVTODIxWTh2MFlRWEp0SVFUWVh4UWIzRzRD?=
 =?utf-8?B?S2ZJNS93bGs4SFVaWnY3clV4OCtrWVUyc01sQ3ltUGpwMEdIR0R1THlzZkc5?=
 =?utf-8?B?U1QvQnIxYTZaUkVJSTRZYlNtQTJtZmFubVR2V1RzUlBsN1VIbjNTRm5PcW5Q?=
 =?utf-8?B?ZGNqQjgyN2tGcjMxQU5IaDM0TTV5LzUzeGpFbVBhQ1phTnpYcW5xWFh3VmRH?=
 =?utf-8?B?aytQdG4rUTBmTkhQMCtudldvcnY3R2pkSi9pTW5NWlA4N1RUWUszbTJPWXlh?=
 =?utf-8?B?U1RwY040WG1xblFqZXloVkFJdlMzTjVhZWhlNmJvMFFhOU80WEZYbWFSMGxR?=
 =?utf-8?B?YXBOeHREdEpjSmlRYXVJV3M5bitJd1ZhVVFpMTgyMWRFdS9GS3dYT2tUNTJh?=
 =?utf-8?B?aVB5S09FMWxyN3lCRk0yeEl1djhyM2tWeG1ZaWRjVjFoSFo2Y3E1T2I5Q1k5?=
 =?utf-8?Q?ys5RY1x9JuxKyMhNhawR5s0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AB0BD723298D946AF073692B4F0C8E0@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2062262-b042-49bd-bebd-08dbe53dda33
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 18:16:41.9334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vyoW0Svgq6q+96+BDFX76mB41PweLgdN+JwiqsnBGeJUDx1i/AwMBkznEkFDWCOOJBpnMbW+0crks8G5rteQ/d3m3wupbVXLbOqTFBim4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7017
X-Proofpoint-GUID: LXECq6xt6FDF2AAMmHf6EEvuU3s9njCl
X-Proofpoint-ORIG-GUID: LXECq6xt6FDF2AAMmHf6EEvuU3s9njCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_18,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140139
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE2LjEwLjIzIDA5OjI4LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KDQpIZWxsbyBKdWVy
Z2VuDQoNCg0KPiBJbnN0ZWFkIG9mIHRoZSBJUlEgbnVtYmVyIHVzZXIgdGhlIHN0cnVjdCBpcnFf
aW5mbyBwb2ludGVyIGFzIHBhcmFtZXRlcg0KPiBpbiB0aGUgaW50ZXJuYWwgcGlycSByZWxhdGVk
IGZ1bmN0aW9ucy4gVGhpcyBhbGxvd3MgdG8gZHJvcCBzb21lIGNhbGxzDQo+IG9mIGluZm9fZm9y
X2lycSgpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2Uu
Y29tPg0KDQoNCkxvb2tzIGdvb2QsIHNvDQoNClJldmlld2VkLWJ5OiBPbGVrc2FuZHIgVHlzaGNo
ZW5rbyA8b2xla3NhbmRyX3R5c2hjaGVua29AZXBhbS5jb20+DQoNCg0KSnVzdCBvbmUgTklUIGJl
bG93IC4uLg0KDQoNCltzbmlwXQ0KDQo+ICAgDQo+IC1zdGF0aWMgdm9pZCBwaXJxX3F1ZXJ5X3Vu
bWFzayhpbnQgaXJxKQ0KPiArc3RhdGljIHZvaWQgcGlycV9xdWVyeV91bm1hc2soc3RydWN0IGly
cV9pbmZvICppbmZvKQ0KPiAgIHsNCj4gICAJc3RydWN0IHBoeXNkZXZfaXJxX3N0YXR1c19xdWVy
eSBpcnFfc3RhdHVzOw0KPiAtCXN0cnVjdCBpcnFfaW5mbyAqaW5mbyA9IGluZm9fZm9yX2lycShp
cnEpOw0KPiAgIA0KPiAgIAlCVUdfT04oaW5mby0+dHlwZSAhPSBJUlFUX1BJUlEpOw0KPiAgIA0K
PiAtCWlycV9zdGF0dXMuaXJxID0gcGlycV9mcm9tX2lycShpcnEpOw0KPiArCWlycV9zdGF0dXMu
aXJxID0gaW5mby0+dS5waXJxLnBpcnE7DQoNCg0KICAuLi4gd2hhdCBpcyB0aGUgcmVhc29uIHRv
IG9wZW4tY29kZSBwaXJxX2Zyb21faXJxKCkgaGVyZT8NCkZvciBleGFtcGxlLCBfX3N0YXJ0dXBf
cGlycSgpIGNvbnRpbnVlcyB0byB1c2UgaGVscGVyIGluIGFsbW9zdCB0aGUgc2FtZSANCnNpdHVh
dGlvbiAuLi4NCg0KDQpbc25pcF0NCg0KPiAgIA0KPiAtc3RhdGljIHVuc2lnbmVkIGludCBfX3N0
YXJ0dXBfcGlycSh1bnNpZ25lZCBpbnQgaXJxKQ0KPiArc3RhdGljIHVuc2lnbmVkIGludCBfX3N0
YXJ0dXBfcGlycShzdHJ1Y3QgaXJxX2luZm8gKmluZm8pDQo+ICAgew0KPiAgIAlzdHJ1Y3QgZXZ0
Y2huX2JpbmRfcGlycSBiaW5kX3BpcnE7DQo+IC0Jc3RydWN0IGlycV9pbmZvICppbmZvID0gaW5m
b19mb3JfaXJxKGlycSk7DQo+IC0JZXZ0Y2huX3BvcnRfdCBldnRjaG4gPSBldnRjaG5fZnJvbV9p
cnEoaXJxKTsNCj4gKwlldnRjaG5fcG9ydF90IGV2dGNobiA9IGluZm8tPmV2dGNobjsNCj4gICAJ
aW50IHJjOw0KPiAgIA0KPiAgIAlCVUdfT04oaW5mby0+dHlwZSAhPSBJUlFUX1BJUlEpOw0KPiBA
QCAtODUxLDIwICs4NjgsMjAgQEAgc3RhdGljIHVuc2lnbmVkIGludCBfX3N0YXJ0dXBfcGlycSh1
bnNpZ25lZCBpbnQgaXJxKQ0KPiAgIAlpZiAoVkFMSURfRVZUQ0hOKGV2dGNobikpDQo+ICAgCQln
b3RvIG91dDsNCj4gICANCj4gLQliaW5kX3BpcnEucGlycSA9IHBpcnFfZnJvbV9pcnEoaXJxKTsN
Cj4gKwliaW5kX3BpcnEucGlycSA9IHBpcnFfZnJvbV9pcnEoaW5mbyk7DQoNCiAgICAuLi4gaGVy
ZQ0KDQoNCg0KW3NuaXBd
