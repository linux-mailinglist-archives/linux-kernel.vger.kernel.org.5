Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC5C7EAB82
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjKNIU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjKNIUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:20:25 -0500
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3446FD43
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 00:20:19 -0800 (PST)
Received: from pps.filterd (m0174681.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE7MfnE020262;
        Tue, 14 Nov 2023 08:20:11 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3uc475068e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 08:20:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvOZ+/36jANvz4DqejjPiTj+8LVlOc35Ble1h+OBdrKsam5+b7tXSHN3jkSUuDDzsmCzvB0FEYoE1zr2g2EI1TGBVbwJnE12Ro8fX24PviFjL18vTCkLgBO7UeP/Q95M6j0+uRov7GRa3zDnuPpcy+jd5iOPoiEFcjRui/9BK138duhj4ym2VS2HvXFscFoARZzc2PEnyh6yezyRaj2JOQwfwQkdXKyTxR5q2fZ369fM5Ibk3cKW2AjGh7LOpPqhas4DYnJb/17ktngUWT8j00oQ3SW4RcXeYbLv9L/16K4E+DiVRp0zNM9/qY0kbUxMKk4B8RtkUI8BK32kk0m/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zu66BTRsKQSTP5zj7i0yftHaKjX4+sHfNq2CYBpLDRI=;
 b=jBItv+nz0REg7Hp29a07Ydovc7g8DmAS5z5xq8FvPXNy3U84BxcyayaxVn5gah75LV+1gZNf5vUxMknS/Mx5YSmrka59AWhm5gMtf25MSsskYav2kglqGBgCt1rs9pMgi1D3K/93cVIvzFIoVdRN3pAs964yUcNRSGTUdcVHOwbQL5WxKXOccZK68jRgWom9F8JJTOs3xZTewfe4Rs056dmAUWlnbeNKUXlaNXNXDIqFqF6N5ibINbhRr1Yr4uTBCVHCxIj8pPx/by4WyHIDHDzYkg5BrnoDf/L77mK/M/DlkdBL6a16UfW3IK6PYsMRMofTpAO0E6BNadoqQlp4DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zu66BTRsKQSTP5zj7i0yftHaKjX4+sHfNq2CYBpLDRI=;
 b=lgoKnl9zo+SyVYcFFyzr8lZafDPjmZ9bCvfOa2DDI/uSwv2M1Prg6jnXjdtJolYBxuL7RsZndjFTGnUjVa0l9YxR/a2ZHpUL6nGA8JxQH/z9ieSyYam/4oxh/IL+5E8C9psz2bP1iB7Qgq1NO3YYYHOSkmSHpXaQLCLbUuLACzVNowsxp8fAkNFVHiOsLH+EeCp2ndsEt4PUdHMFE32YjkBw186K62SmwF394oRGVZrpctdQQ6CFfdnnLqN6zG7vp8vrBGix0fTb8WMX/kQMci+GA+M/51Qe1j+jUpkFXp2sR19HbzWr61ND6L/apUkpnta5toZ7Mwz32PNT5tWbhQ==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by AM9PR03MB7187.eurprd03.prod.outlook.com (2603:10a6:20b:26f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 08:20:07 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::fea9:8f02:fb13:fd44]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::fea9:8f02:fb13:fd44%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 08:20:07 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 5/7] xen/events: drop xen_allocate_irqs_dynamic()
Thread-Topic: [PATCH 5/7] xen/events: drop xen_allocate_irqs_dynamic()
Thread-Index: AQHZ//oUYzlaLKzNvESKtKHtrAIYJrB5psyA
Date:   Tue, 14 Nov 2023 08:20:07 +0000
Message-ID: <955c998f-4550-4945-8dab-c5901d833074@epam.com>
References: <20231016062831.20630-1-jgross@suse.com>
 <20231016062831.20630-6-jgross@suse.com>
In-Reply-To: <20231016062831.20630-6-jgross@suse.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|AM9PR03MB7187:EE_
x-ms-office365-filtering-correlation-id: 6021fc4d-d32a-4ee6-3a60-08dbe4ea8327
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PERmYusKHzKap6Jlcso71kEBz8Obht/olFeNvcI2sC6xzDEn9JGSV2gaBeDcE59WT/BRBOwl3aTfw3H9x6dt3L/255fhmw/vKoHCTNQuhvROjcVzxr0R+LhYSNOfxGRA65RFl544Xc1tNJvOf88nZCtouEW2Qi2/JKeTw0422YR/e6zyWwII2ZJU3uPKmH8MJwr3T31FXOUaoAYtDP+v6FCeR0vf/8jaxK3bYoU/IWynGnXxcmZB/hgrmTot+GHaZkYHzeWwB/YhDICcEl+uUIpQ7CJ+lLEgXvn6giW9f+evrz18ZyiMERznTpAoJd93i4IR9DwLlcFL084y7SMYOvasQE2EL5TeVOBmrzz/E7vbc1ub6EQ+nGrEJHzcDuZJ916DUECg62qhXSQmNgb4jaUWPxUSkSgnbbVwlHjPBexJqFGq+wVke/fPrRRPC/Z7CYRaGxg4tar8irf9nARq0yd6tkEKPjGoxxHFBPcps5fN0YQ8UaLYG08FiWerVhAIbBFhkAPgGtngxqWQnXv5GUhBJa+C5gLgEgkFumIUi0gAkAg6QjOkE+EfFoMpSsi1ffIdvVcAShO9BAVUCeWHsuWZheZk3EUNM3ElwwdSapx8EDtDVXlaUCiLZ9mAiQ16u+jzddthyul48ubcyZq0qQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(31686004)(6506007)(71200400001)(53546011)(38100700002)(83380400001)(2616005)(6512007)(2906002)(5660300002)(41300700001)(8936002)(86362001)(31696002)(4326008)(36756003)(66446008)(8676002)(91956017)(54906003)(66476007)(66946007)(64756008)(110136005)(76116006)(316002)(66556008)(26005)(122000001)(6486002)(478600001)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0JLS2hBVm1FblZQWDF4WnBTeUdkSVlScmhNK0tjVVE4M2luS3BKbXoxYTJi?=
 =?utf-8?B?NzlQQmpOWUthT0RWMnQxMWNOOUJHNUl3UDZ2QnRpd0VIakpmRDdRUXdrSHFv?=
 =?utf-8?B?OGlmZTJEU2Vwa29xUmhzeW5WOGhUU2Y4YmNqbHNYR3lIU1QzSVI1bFJkNi9i?=
 =?utf-8?B?ZDUyODN2WFRuY3BiSm1nalFnRTZERjFPL1N4bDhqcUsrdDRNSlNjK1BWS1Ri?=
 =?utf-8?B?aXhuQmNmS3hWRUNoQUtuQkNzR1loVm4vbFV4TlRtZ0NnSEJiYkVnOGZROUtj?=
 =?utf-8?B?MDAxaU5oMUZLdW1CMnpBRCtaaW4yNGxtcVpheXdvS0NNd04zdG9iWnU4dHU0?=
 =?utf-8?B?RS9HZjFRbnR2K21SejRnYWZ3Z25rTjgrNGkwckJLM2RGTTdlc3VTRS9IamVV?=
 =?utf-8?B?ZlZmRHhyQ1RoQmZqUFhqNDZzYXNTVkJleFBFVWpZOTdHSndJV2gyeE8wN0Vu?=
 =?utf-8?B?QmtrRkh1Ni9pdUFndnFaMGEycloza1hNVFhGQkhtSnpndGR1ekd1MFNjbnAx?=
 =?utf-8?B?c2tZZGlBd0M0Sm02NFhadHBPbExoUHoreWYraThSaFVhZXZraXpZM1czNTlV?=
 =?utf-8?B?bDcyeGNUUUhJTUFTcENZN2o5ZnMzbCtDRGRqY3h4VndYLzVzK1BEUTFrblJE?=
 =?utf-8?B?VFcvRWFuaGRMVFlFL1k1ZWt4aTFuQjN4QVNvdmhWYVlMRmxXNWNQMHJqcXFI?=
 =?utf-8?B?a0dVSEFMODVUaEk3YS9pRldCU3lCMlZnRFpyOS9jczQwYnBONWY4eDNDNkhJ?=
 =?utf-8?B?bWdZUVdWOWNWYTZDdFZnZUxKdmhMR1ZkR2VhWk05RmkrL1l0V2pqNGFGRTBq?=
 =?utf-8?B?TEFzcUVnV2lXU3ZDL1hsSVpTWHI3RUYzRDFwZndud1J2ckJDZ3pYOEdZTVpm?=
 =?utf-8?B?VlVtcGdNcFZ6SWd4Ui9NR3JQODV3NzY3azlTdUJzaVdJRkk5WFNEenQwRzV0?=
 =?utf-8?B?dEIwamo3bGVZeG1Rekx5b2FEVjB6ZjF3S1NPcDdLY0QwYktwUGxNWE4rSVFm?=
 =?utf-8?B?OUJMV3kyMVZhdVdZc043ZTJaL2Y5U1hoQWJXU0dGVEowV25aK0lSeGhENXRv?=
 =?utf-8?B?MEcrV1J2RkUxY2NWYlg2ZmxKZUVyUTkrV3FGbDJnSE9YS1ZVRVJUS1g5KzZn?=
 =?utf-8?B?WStVVzJqM1pMTmpHcFl2cGd1OUZ1QkFyeWZSVlA0bTU2RUJweng5cEkzUUZG?=
 =?utf-8?B?Vktlem1leEhPbnhJZmsrUkxWRzRSQWFCbW9NM0UyOTBhV0NQblU5dkQzQytI?=
 =?utf-8?B?NDFxMmkweDRmNnR0L0lVNjh1amhWYktvQVkzZ25IWkw0ZmFTcm5rUlI3dmhO?=
 =?utf-8?B?Q2E5K1RJdVBET0YzeDFYNkFBanVFU3o5dzl4YWlwUVJSTFF4WXNMNDY3MHky?=
 =?utf-8?B?ZGJRT0g2MnVucUNnWjc2Ym5ORVh1Mm5CbXJhRmRwdXZQa3p4K25VY1BlT0F4?=
 =?utf-8?B?WTJRdFZSRXREc2xPTTJZRzFvc1Yxa3BFY3QwcVVrU0t3N1h1VDZDQlN3UDlJ?=
 =?utf-8?B?VkNqdHU5Rm1lbFBqbGtVcXdTa2FmL3RzRzdWVkgrOFJUTWh2Rit1QlZ4R1JS?=
 =?utf-8?B?b2g5Z3pIWTlDbjdVZVdtUjdwU3RoeFluNi83UU11c05XQm5HVnZISmRUd08w?=
 =?utf-8?B?ZlRIdmdVNnlWWmtDc1dQNlowRDA0d2RCRzBLWG1uOUpadHBxNFRyMS9TNGYx?=
 =?utf-8?B?RDE0SFBRYUhVL0R6bGg1YTZleGRHME9leDE3RzhJREpYd2E3TzQ0TVcvSGxu?=
 =?utf-8?B?dFRrUnFUOUhURTNEKzArdmhraC8xbzVIQUFOZWpzMmFjSWhPUVcrakpDNGtq?=
 =?utf-8?B?Tmd4c1pTOVJnS04wRDAyMFFiL2lhT21uVWorL3EwTElpZnlWZ0NEd0ZmbDdU?=
 =?utf-8?B?ZkpZN0lCS3JQaWJ5TWcrQWVneHJKckFlUzhDSk5Od0Z2dDUrU1drYnZYYzcw?=
 =?utf-8?B?eEl4YlhhakUyanIyeXJGdG4yeTJVZkhjV0JYVk0vUmtRNGxvMDdlTjJHdG92?=
 =?utf-8?B?TEpnMFF5TG5NSUcrRll6bnNQNzVvSDREbmRTS20vc3dxZ0pmTWM4Z3ZtbE4z?=
 =?utf-8?B?UElHMStKU1cra1Q3cXBqMkdWWXVqZlkyODBJTUQ1UTJGZ3MzRERnemJCRFNW?=
 =?utf-8?B?c2dBNTB1Q3ozV3ZjWnhoZFZ2eCtlK2Uza0ZPTUQ3UVB3aXV4R3cya1d0ajVH?=
 =?utf-8?Q?DPbPQZ5NcBknW2T9UPWUwNI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D530F5CE92039D40A73F4F3911AA7BA3@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6021fc4d-d32a-4ee6-3a60-08dbe4ea8327
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 08:20:07.6707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A0BQRkMpKmCjvkDtz9dbCzg2QZqJSDraQRhJ4eSYiho123nxvcBxdWUAgbxXJvwg7rrSIhKOXFWZe/LVF8c3ytPu9fMOKzAttq8mKRwGSAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7187
X-Proofpoint-GUID: b73z-J7dNbIa67NBQxv6vp10DcC4maAz
X-Proofpoint-ORIG-GUID: b73z-J7dNbIa67NBQxv6vp10DcC4maAz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_07,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=817 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE2LjEwLjIzIDA5OjI4LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KDQoNCkhlbGxvIEp1
ZXJnZW4NCg0KPiBJbnN0ZWFkIG9mIGhhdmluZyBhIGNvbW1vbiBmdW5jdGlvbiBmb3IgYWxsb2Nh
dGluZyBhIHNpbmdsZSBJUlEgb3IgYQ0KPiBjb25zZWN1dGl2ZSBudW1iZXIgb2YgSVJRcywgc3Bs
aXQgdXAgdGhlIGZ1bmN0aW9uYWxpdHkgaW50byB0aGUgY2FsbGVycw0KPiBvZiB4ZW5fYWxsb2Nh
dGVfaXJxc19keW5hbWljKCkuDQo+IA0KPiBUaGlzIGFsbG93cyB0byBoYW5kbGUgYW55IGFsbG9j
YXRpb24gZXJyb3IgaW4geGVuX2lycV9pbml0KCkgZ3JhY2VmdWxseQ0KPiBpbnN0ZWFkIG9mIHBh
bmljaW5nIHRoZSBzeXN0ZW0uIExldCB4ZW5faXJxX2luaXQoKSByZXR1cm4gdGhlIGlycV9pbmZv
DQo+IHBvaW50ZXIgb3IgTlVMTCBpbiBjYXNlIG9mIGFuIGFsbG9jYXRpb24gZXJyb3IuDQo+IA0K
PiBBZGRpdGlvbmFsbHkgc2V0IHRoZSBJUlEgaW50byBpcnFfaW5mbyBhbHJlYWR5IGF0IGFsbG9j
YXRpb24gdGltZSwgYXMNCj4gb3RoZXJ3aXNlIHRoZSBJUlEgd291bGQgYmUgJzAnICh3aGljaCBp
cyBhIHZhbGlkIElSUSBudW1iZXIpIHVudGlsDQo+IGJlaW5nIHNldC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVy
cy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMgfCA3NCArKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCAzMCBkZWxldGlv
bnMoLSkNCj4gDQoNCltzbmlwXQ0KDQo+IEBAIC0xNzI1LDYgKzE3MzgsNyBAQCB2b2lkIHJlYmlu
ZF9ldnRjaG5faXJxKGV2dGNobl9wb3J0X3QgZXZ0Y2huLCBpbnQgaXJxKQ0KPiAgIAkgICBzbyB0
aGVyZSBzaG91bGQgYmUgYSBwcm9wZXIgdHlwZSAqLw0KPiAgIAlCVUdfT04oaW5mby0+dHlwZSA9
PSBJUlFUX1VOQk9VTkQpOw0KPiAgIA0KPiArCWluZm8tPmlycSA9IGlycTsNCg0KDQpJIGZhaWxl
ZCB0byB1bmRlcnN0YW5kIHdoeSB0aGlzIGlzIGFkZGVkIGhlcmUuIERvZXNuJ3QgaXJxIHJlbWFp
biB0aGUgDQpzYW1lLCBhbmQgaW5mby0+aXJxIHJlbWFpbnMgdmFsaWQ/IENvdWxkIHlvdSBwbGVh
c2UgY2xhcmlmeS4NCg0KT3RoZXIgY2hhbmdlcyBsZ3RtLg0KDQoNCj4gICAJKHZvaWQpeGVuX2ly
cV9pbmZvX2V2dGNobl9zZXR1cChpcnEsIGV2dGNobiwgTlVMTCk7DQo+ICAgDQo+ICAgCW11dGV4
X3VubG9jaygmaXJxX21hcHBpbmdfdXBkYXRlX2xvY2spOw==
