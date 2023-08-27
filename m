Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B0B789C1C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 10:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjH0IO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 04:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjH0IOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 04:14:55 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1E3100
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 01:14:53 -0700 (PDT)
Received: from pps.filterd (m0174676.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37QIf4h4000382;
        Sun, 27 Aug 2023 08:14:31 GMT
Received: from eur03-am7-obe.outbound.protection.outlook.com (mail-am7eur03lp2236.outbound.protection.outlook.com [104.47.51.236])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3sq6k3t26e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Aug 2023 08:14:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzCzbME+Tx499srBVz/sZndrJB8fTLK2DkNLwOAFIj/6XCgxPDkE9tZ8wGHPLQzqXlPiBDVfww6XK+vhA0sUeJR5JlF+0aU4romdTawjtcNUkJYpHm3D6TvQSGfLgL5cbFiUDL5XmmN8ccrjfwfOrhCESlzCvGzCzUAhQwJBGichs0MJVCFmHX/Zd+crWR/+6hYRH0Vwf3WSSsOSQJ2Wh+0IKr2tBu6ACCARmwgZaFZ1xpoeNGcA7AfgTdWiT4Hkir6CQALyY0XCDx14E1nsLbkr7rkcuI3X7u97pVzvT6AYNeARIe7lF7DVUNsbBenB0Bj8AELwIBSI69kHU2LaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12SRTJncwVv9aT/1IBiZU3Ifjh03pi+EwRoN+gp/rxI=;
 b=T4G/oDaWNJS7zAHeLha+QtITIgWexac4HaKJG1WbdzJbzdzT82nPomYGPPR5UWC78RyZqp4zMZ2jKSF95AdBJoxqpiolJVuncUs4N7E+aX/XOty103VFdfd0LZYJtA4ULTcQ9siIbqAjJWNCLy2jyCtmu859Ch6G3Pb1le/e7vqEPS383vajuw7ApjTbbyczoKJldnSsHQc63c6/b4Sd2I/D6mHNUXYgsCmuEp0gOcvGxhziR0sCaUjmM/M8Wp8J7WNZemjaCChXrCgPV5OzvRsvjseveuig11/zc09kYJqE5H58F8O7U9Gd/oEtDVnA0xS7YEREQdf4c3716/8y2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12SRTJncwVv9aT/1IBiZU3Ifjh03pi+EwRoN+gp/rxI=;
 b=fmSI3Qhyk6P2sf5BO38vejM/Zxoh0K2B+kcOV9/ytfHByNskBkzNyst8uEgVpdffwC8B+JdKDxbsltEYf55Wd1SYzRSVZTA0XUIt3NIPYa2ewXkj0gKYBVG07RDJ4bW41V8CamVXehRlhLoxwlAs1kVXj/T/V58ZQjqIX6dw3Ggfk3evXRG9/sq8jSd1HCGZHAHHzLBnz9zMzKWDmQSJZd0jUC1LNmnLdplwe3yQMq2nN4Pk6V8kOu4xyPnic7MPWXRv9jNIuteZL+rVh/lAOxo7ym+D/tLkExMIVpvpVHOfYZofBWtbEZsd/HBt3W8D0K+WPTlJMEViRxwyGXujtw==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by AM9PR03MB6883.eurprd03.prod.outlook.com (2603:10a6:20b:282::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 08:14:28 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::ac2a:7470:c441:365c]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::ac2a:7470:c441:365c%6]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 08:14:27 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] xenbus: fix error exit in xenbus_init()
Thread-Topic: [PATCH] xenbus: fix error exit in xenbus_init()
Thread-Index: AQHZ1Niy5Jst2USBYE2HABrwl061oK/900WA
Date:   Sun, 27 Aug 2023 08:14:27 +0000
Message-ID: <72c8ea59-4ef1-4117-32d8-3b775d1f8661@epam.com>
References: <20230822091138.4765-1-jgross@suse.com>
In-Reply-To: <20230822091138.4765-1-jgross@suse.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|AM9PR03MB6883:EE_
x-ms-office365-filtering-correlation-id: c0d46753-1657-4a31-a650-08dba6d5a185
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eyzY4mYYHv/ZDx/F9MQ8B4NBsUzA9yd2+qqHwwDL8RRBSI5F8swl9zJEPQedXN+TaTX9HUnBeVzQUsaJbNvs8JBNZSYFQQkEe7HqeXuUgY/a5kP2yKBdoa/tok3y6NoIcRB8vNDb0uitE4HrOjqZEhYsfQgoNIHtCFA43A+OQIXDhvVN7PKfg9J2V8Pe3mbBnyVLRrqe5cyB7IPJfvYa4m+Xo9leYn592piUFMtJ7PzP/Dsiz/QO8aJfgmeqyqjXFzotQvPrNnpD3MFum3uPyk30fzMDdjYgIraQMEWAVjPSK1JBOzCTH6hs2wPXehSxJb3YRDL9COpgOVC9oEfMkdtfVqZeiuf+ObqAHoRLrppfEtokmBHNJCjzKgyk3eBZHeWXZtMq/symVmvBlxZ87AFR3tPBMqzocnaFfcbEWgIB/SBbszwv4iOq054U0qvvZ3SEUbQWG2AUJTm6XzvtfCwJFeTs+fRfAhLXZg/l3nGX8v44Z5Xv4GWDSGUlJ9LiVAQriAfk0mu5FZgBRkxBTRt6flBUtkzuJ7Ya3U/8LRCkXayYkWsiF93E4yEq7tI/G/3/g3aus1ydVw2CujkNXT5y34XQpAL89YmjGKbPxTUr84PftpI+/sq7bpv23KqwOke/JVDwqFbFlKJNSKN3Ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(451199024)(1800799009)(71200400001)(31696002)(53546011)(6506007)(6486002)(2616005)(6512007)(86362001)(2906002)(76116006)(66946007)(5660300002)(41300700001)(8676002)(8936002)(54906003)(66476007)(36756003)(38070700005)(64756008)(66556008)(66446008)(4326008)(110136005)(316002)(91956017)(38100700002)(122000001)(478600001)(966005)(83380400001)(26005)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0lJSzcyKzBuOXNTdTgzN1JnaCs2RjFYeEl5cmxCSmdPb0hUcVlWbS9yQy9o?=
 =?utf-8?B?RHJjWlU1RXZrVHRodXJvakdFUU4rR2FwQk9DWStMOEZxSC9reG5xZ1Z1NEFZ?=
 =?utf-8?B?UjJKOXRFUXZndXpHdk9La3BwbXZDVDd2WnlreS9IWU1ZZVNGOUZKQ2taY3Nt?=
 =?utf-8?B?TG1FZ25MRUhSQU90ejB5cC9KRnlFOFBXWjg2WDJueERCbjlJcyt1alVSMEpo?=
 =?utf-8?B?S1Zqc0Y2S3piMjlZb3ZqMFA4clRrOHp0QzNORm5SMS9ObVR2Wm5PM1E4OWcv?=
 =?utf-8?B?bjliYVMxT2htMEIrc29xNjFyMWVIUHdDVUZqL3NFZ2U5NGxzajRDbmhuZVF0?=
 =?utf-8?B?bTFkQklXQVlXblFFUHRtNklnb1ZFV24zUDlYZldWa3pSd3d6RW5iV0lWWG1v?=
 =?utf-8?B?K0wzMGtIRURNamxJTjU3dEM4Q1k3YSs4cFVDMkl0WUd2bmU5bDF4Z0tWVTZ0?=
 =?utf-8?B?SVRQV1QwZnRGa3NvZEhBN2xzMnNnUy96Z053aFFBaUdXZ1ZKR1hvZURuVzRw?=
 =?utf-8?B?YjJUb3NkNHphd3crNi9MQkJzM2o3YVlDdjVXaE10YW1xMndkMGV6cVFhK1hs?=
 =?utf-8?B?QnBWRTBTeXJSL1ZvbE00amhMS1F3Z00ybk9wb0p4NFVjUFVQZ3pNc2oxTGpR?=
 =?utf-8?B?OUtGU0o4WERiWnJZSGZLZ0ZQUTlCV0U2NE5DelUvOWlPVFF0a29NTk9XWTFa?=
 =?utf-8?B?M3lxNDFWOCtVcnhuUGtWeWl4SXdkYVVneFdYMGNOaGNaZVd3K1UvVVo5dW5w?=
 =?utf-8?B?dUFvY09HeUFKWk45V0NxUUZ6M2Vpbm1HOWMxMU5odkUxanp6dWZSN09mdDFB?=
 =?utf-8?B?TTgvcHljanE2Q1A1RzdqUUd2OUczUW03bmtzMWhiUnZmZTVJZlVwd2NSNmpD?=
 =?utf-8?B?Tm9XZlNPYStSbm9YUlNIeDkrV2tPNHdzSHlid2tjUkxpb3dxN0U1cStPMi9o?=
 =?utf-8?B?WG5JV21HbXNZeFl1S1VqL1JkcjhJZXVUSCtzT0FNamg1Tlc2djZmeWxWS0ZP?=
 =?utf-8?B?MGk4NlN5WkdTSUVBdyt1cHA5eWs2TlVpNUdSWjZKQjhuT0FBZFkxOERqY1Js?=
 =?utf-8?B?YjJkdDlVb3haSHZNaTVib0ZaOHlnQ0p2K3pwMmp6UUs5MXcrYkd5OTFLY3Zr?=
 =?utf-8?B?RTlqNmNhNVpBd1BYS3duZzJTbFFpMGdic2hjVkt6QXlhSEZkcG13VzhmL3dD?=
 =?utf-8?B?VkNnVGhqemF1ZFVZVkdXakpMckgvTmkvTmR6dUdWc0NJVDFiT3AxM0xQKzgz?=
 =?utf-8?B?REtnZ000ZldZMkZ5V0pqSmFXbFVCMGdzN0RhQlBxVzNwZXo5c3pIM3lLUUhC?=
 =?utf-8?B?NFFHaHBNMWJGVmtJUU9OUWxQbSs1aGxidUhFaHBJUzVDY3dMRDVGS2RGSUcw?=
 =?utf-8?B?a1hSZkdWTklHUE5JTDhSMlppU0ZmVUtJa1ZLZkdYeCthZmJ2TnhsS3dYd3Ix?=
 =?utf-8?B?TWhJZUpobC8zNFZlZmZCenpYSXlndjg3K2pjZjdoUnNabXp3THpHaEVCOW8w?=
 =?utf-8?B?SlNvWmVycm52MFZuaUp0elIwRnVONkxuY1I4YUZFOXVSYlhEUWR6WWgyVTJi?=
 =?utf-8?B?ZVphb0hBd05CSGVqNlZ6a0M0V2pETTNQRmRxU3MwQkpDQVJNVnFTSkc0Vno1?=
 =?utf-8?B?ZFhvUE9mTVU0U21QL2hsdkFNeGN2NC9samN3b0plaTFTTE1LZWVTSUFuc1Zv?=
 =?utf-8?B?VUJDeGNuUnhOSXRXbEYzQW9PaFRDUXVPY05PMmtmQ3ZwMkNsaC9wMlBGNWh0?=
 =?utf-8?B?UUgyZVlvTlk1WWtSQ2NqVVRZd3c2S1A4VjF6amt2K3FYYjZ6R3p3czdYSStO?=
 =?utf-8?B?WVFvc2RHaVVVM2QzOXhqcWZaNEtZaklvM09tWWo3TUVON2ViNHFZZFJHcG83?=
 =?utf-8?B?WUVjS0RtS3VrRmEvdmpUTnc0L2VBbmxTZ0ZINWNkZk91R1Y2eU4xYitFT0tn?=
 =?utf-8?B?NlRtcVJ1YkZHRzByanBDZHN2M0IxdEduS3oxRzl6U3dUZVR3RG5rcXVqM2kv?=
 =?utf-8?B?a3YwaVBYSFN1SEM2NmNaNlJScHh6YWw5aHZDRVJUQjhGVmRZOHJRRERQWS9Z?=
 =?utf-8?B?Z3NTM1JhckQrYmpEOE04TEFXSVdISmtZU3N2bFg1VUdVditQcFJsQnppL3BD?=
 =?utf-8?B?a2wzNUdIa2E4SnlaUjBxWTBzTmgxeWNpbFhGMHJBbjJLSmRqUm1taHlrQi9C?=
 =?utf-8?Q?Gx6TvW5zZz+wMEArjuxBnKw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCB881958AEC404A94469C7A03D7301A@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d46753-1657-4a31-a650-08dba6d5a185
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2023 08:14:27.0740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ys4J47srkteAw/Xs48++Vwhjwa6Jj4xYUxyO+C40U25F3sLe7L3CKMy8xlDAnlK4dwUHWp4sniYhJjTY36f+G6G0ovK6tXvvRtcbgmmb5eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6883
X-Proofpoint-GUID: _gTzRrK4nrMydYJGv5tShd7G-gD02wdy
X-Proofpoint-ORIG-GUID: _gTzRrK4nrMydYJGv5tShd7G-gD02wdy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-27_06,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1011 spamscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308270076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIyLjA4LjIzIDEyOjExLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KDQoNCkhlbGxvIEp1
ZXJnZW4NCg0KPiBJbiBjYXNlIGFuIGVycm9yIG9jY3VycyBpbiB4ZW5idXNfaW5pdCgpLCB4ZW5f
c3RvcmVfZG9tYWluX3R5cGUgc2hvdWxkDQo+IGJlIHNldCB0byBYU19VTktOT1dOLg0KPiANCj4g
Rml4IG9uZSBpbnN0YW5jZSB3aGVyZSB0aGlzIGFjdGlvbiBpcyBtaXNzaW5nLg0KPiANCj4gRml4
ZXM6IDViMzM1Mzk0OWU4OSAoInhlbjogYWRkIHN1cHBvcnQgZm9yIGluaXRpYWxpemluZyB4ZW5z
dG9yZSBsYXRlciBhcyBIVk0gZG9tYWluIikNCj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJv
Ym90IDxsa3BAaW50ZWwuY29tPg0KPiBSZXBvcnRlZC1ieTogRGFuIENhcnBlbnRlciA8ZXJyb3Iy
N0BnbWFpbC5jb20+DQo+IExpbms6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczov
L2xvcmUua2VybmVsLm9yZy9yLzIwMjMwNDIwMDg0NS53N200a1haci1sa3BAaW50ZWwuY29tL19f
OyEhR0ZfMjlkYmNRSVVCUEEheVZxbWJXdTZ1R3JnQ2wySFZPQXBJdFZ5c1pkelBRZEwwV3hlRks5
dlZIZTVyUGJJNkI0dVF2ZG9ZY0VlQVF2WFRKVXJhZTlLTnlRa19KQlcxUVZMJCBbbG9yZVsuXWtl
cm5lbFsuXW9yZ10NCj4gU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2Uu
Y29tPg0KDQoNClJldmlld2VkLWJ5OiBPbGVrc2FuZHIgVHlzaGNoZW5rbyA8b2xla3NhbmRyX3R5
c2hjaGVua29AZXBhbS5jb20+DQoNCg0KPiAtLS0NCj4gICBkcml2ZXJzL3hlbi94ZW5idXMveGVu
YnVzX3Byb2JlLmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4veGVuYnVzL3hlbmJ1
c19wcm9iZS5jIGIvZHJpdmVycy94ZW4veGVuYnVzL3hlbmJ1c19wcm9iZS5jDQo+IGluZGV4IDYz
OWJmNjI4Mzg5Yi4uMzIwNWU1ZDcyNGM4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3hlbi94ZW5i
dXMveGVuYnVzX3Byb2JlLmMNCj4gKysrIGIvZHJpdmVycy94ZW4veGVuYnVzL3hlbmJ1c19wcm9i
ZS5jDQo+IEBAIC0xMDI1LDcgKzEwMjUsNyBAQCBzdGF0aWMgaW50IF9faW5pdCB4ZW5idXNfaW5p
dCh2b2lkKQ0KPiAgIAkJCWlmIChlcnIgPCAwKSB7DQo+ICAgCQkJCXByX2VycigieGVuc3RvcmVf
bGF0ZV9pbml0IGNvdWxkbid0IGJpbmQgaXJxIGVycj0lZFxuIiwNCj4gICAJCQkJICAgICAgIGVy
cik7DQo+IC0JCQkJcmV0dXJuIGVycjsNCj4gKwkJCQlnb3RvIG91dF9lcnJvcjsNCj4gICAJCQl9
DQo+ICAgDQo+ICAgCQkJeHNfaW5pdF9pcnEgPSBlcnI7
