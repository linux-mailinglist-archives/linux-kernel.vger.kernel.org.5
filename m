Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00457E9E79
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjKMOU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKMOUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:20:24 -0500
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB53D4C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:20:21 -0800 (PST)
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADDtrrl025777;
        Mon, 13 Nov 2023 14:20:14 GMT
Received: from eur04-vi1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3ubg6x99jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Nov 2023 14:20:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHxnQYNwPq3Avze7mc8ZyVxd8YXi2hvSp4UTX+rf1uXH/awNBfcnb2r/v7D6KDfxUgHvm5uaMPC73TifH25UN+wOZyIzGlrLpeQ1vX78zfcfpTaxnCaisKOrxhudnKObawYSnHnUEGpNRWWo88X5y1U4g2aFtKn6dOZ4dBnraLySKGxCe9iLV4yM6eLpVgzVB0KYe1W57FJ4hpkYW7emXHlrMv4yDYephoU86/fCMenFAAijwSHZjZvnVX7o3xlOizC+ANPH2Y2qnO6RVsRIOiMZXhThbVHm8MCullMlG5DCS4wgzUy3TydWjXWR5XbTkKf3pTBuootYW2Jm2TRxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BH00PH4/MmKLpKfSIxE7UCwQdWJ8EMJ155MUPI+ejKM=;
 b=fplwU5x5+VQIkB7FgREeJWv1ZpZc+idd8YTz/VA1X6H42Fw7GnynBrKk8n3fjhx9z/Ht5oUh3OA19CY2cfOXF9VhNm+b7FDZ9O38DaHLPHOAJvePqMyTYJLracyvNc6q+xn4vLSsbYRVX4qeotUs17NDJO58iR/am+WvtCiGpcv5tBK2l4WapEGgLZ+SKFdagR1whhIGXqaRTGZ5U1Z9VfRVNfoAssTPi2plm/XuvXwCEvOgmtzMf5M4SP9eZKUI2M7h9xZFhWP9fjoVxHvObH44mY09sryUUlpsoB3Y1RcCb3xexJXZ6IACMNtWe3wBuTFNWKIhqwm60YKc65sdhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BH00PH4/MmKLpKfSIxE7UCwQdWJ8EMJ155MUPI+ejKM=;
 b=O1OX1iwlx0sfGNOZIm9+VcaDC779ZNrshIEaxDb5yXyVtbq6aRqAUceMILeE6WWQBaXX/wC5hyqPMCBzLj3Q/cBeks4Uo7NYcOhpBvnMxYIwPPZBu2bvD7AsrQywJq3jF/0jNxsHnasw78gV8q6ij46j2wbiZ7csqFuuPa8rcwgejRz+k+Jrv4qMAY7iVlsEKjj1aJqBV+vnmyOGcPWeGxRxLAI9DLMi9heO56xz+FB9CwabuAsrit0+szqtk+2ZSGDTif8cWkn0ZtuipOBbrbk5csZ0d7FkNOBIpZeKQFgD40XnjSmBSsOw1QTFA/4DXBJX4AQp1CDsLbqJHdUMRw==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by PA4PR03MB6957.eurprd03.prod.outlook.com (2603:10a6:102:ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 14:20:10 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::fea9:8f02:fb13:fd44]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::fea9:8f02:fb13:fd44%6]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 14:20:09 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 2/7] xen/events: remove unused functions
Thread-Topic: [PATCH 2/7] xen/events: remove unused functions
Thread-Index: AQHZ//oJo7CNZlOGmUOOgrMdy5X9FbB4eQkA
Date:   Mon, 13 Nov 2023 14:20:09 +0000
Message-ID: <0d6a1340-1c01-47ce-950e-0d30071bd0e4@epam.com>
References: <20231016062831.20630-1-jgross@suse.com>
 <20231016062831.20630-3-jgross@suse.com>
In-Reply-To: <20231016062831.20630-3-jgross@suse.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|PA4PR03MB6957:EE_
x-ms-office365-filtering-correlation-id: a9a19718-7d98-4d69-8573-08dbe453a4a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /mW5mC483CrAONOPou5PNbNUXJ7pIbNEu7qUVZRyQWea/CmYMr3nZ/U16m9ai+LUhWX7hREt6Ywcu+6L5h8obw8rOC4x9X1EfyEuZUpCSyVvvDiqUd20hchveSV+W/3l2O+ehhukt1p/NbQTm8xo3P3Aikz4SxtdGwyttKUg8NKRz722O8/Y7X+KTkkVf87qY6yEJ62cOPOPrJSngZfaWmvAFHu6+JGHuITSizCaWQgdKpyhzW9dgPOneTjbyn31r2pe/3CUCzeH6FzEQ8ONVsWpLl1XSVTUeCkpmH89nFylql8aH8pJ7LPoptgcfEyr0aaEjZ5H6wVGhtFENXdu1kaisfri8In8RLC0Q4jM3LGhLokO1yeu9iYPVD/WjqgQ87BpqCnXJSCLd2lSR17IlxzJKqHZMjk7Tz5myl6cGi8AhPyV+q/dyoq4aIuXhilZG+4rslBlRCemPc8LP6ouPkx3E9h8q3ZKftCwkP/o/qEImH5DNxaX42a+LRIsQSPQ66z2o4fI9XSGfvWJj2Pjl0um3/iSy9F+47QVusRWZcMD7bTBdT58JUuiD5VWcC8jnWChLKgw7bW++g6i7FRnPSP/NC+mZOscKN7+a0LdwiN1PQl+t44FfrMx9Xc6+QuHUW8O9ENNqaUDw39G+gip4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38070700009)(2906002)(71200400001)(2616005)(5660300002)(86362001)(31696002)(41300700001)(26005)(91956017)(110136005)(54906003)(66446008)(66556008)(66946007)(6512007)(76116006)(66476007)(316002)(38100700002)(83380400001)(64756008)(55236004)(31686004)(36756003)(478600001)(122000001)(6486002)(53546011)(6506007)(8676002)(4326008)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTVRTzdsdUZZQkFQbVZZQ1FuLzhYYjRtNDltcGhPdXl4WlFlOENLOU9lV2J5?=
 =?utf-8?B?UG85YzZ6YW56SmczamNpRTlaUzFKckRlSklPYnNOQmNnbDc5K0pVM1d5dWZ4?=
 =?utf-8?B?Vnd6YWJtS3A4aFBGOUdZRnJQVkUvQytRWkFsdlZhTE1iNjlpMjR3T3NVTko0?=
 =?utf-8?B?VHBJU1ZxekFFMVlwY0lIWDBmcytFQ3BpeXpxQWt5dDNVdnZkSm92QjNURkc5?=
 =?utf-8?B?OWdOdnNEclFGTSs4bHp1QWhic3N5bTFrN2RUa0lSMEVaTmI0aDk4TmFPQVFm?=
 =?utf-8?B?ZW9nT1A5YUV4a2tWNzRJN3ZWdEQ2anIyY25ZUWl4RGhKQmRGUDVwUU1MUFl0?=
 =?utf-8?B?aXZkRmRMWkJDVG5VQXpuWWFOZFdOZzJ0RTRtVUljUzBPVkRGMHI3YlJ3YzF5?=
 =?utf-8?B?UTI0bnk3WEcrQ1JjeEduQ2dkUDJQYTNYNFhXL21NeUN6YkVZSEJFOVVsYUR6?=
 =?utf-8?B?NWdXczQ0R050OTNZanpyRU9IVnI1QldjdXJ4ZDlOMUZlOUo0TWpGYTlESHh2?=
 =?utf-8?B?Y1BwTW9rYm9RdnR1RDRiZE5UQUYzdjhWTDkyYmwvc2xQUW40V2U0WWhmc1N3?=
 =?utf-8?B?OVZoY0dNZDdERXE5bm9LTnNHeHZLOTUzY0NJUzVoR0hoUnY3ckR3bnoyUk1Q?=
 =?utf-8?B?TmdCV1hvSWd0VjE5N1RZUFgzZHhBck1XOEpkeURNendsODRPSXd3ZUUwczFO?=
 =?utf-8?B?a29rUXhTUGQxWWxFSWZ5RVBSSmlFS09Yb0RsWnJnY3M2Tm5aU2lobTUzVFNT?=
 =?utf-8?B?aDZRY2hKTWdZK2xiRnBObEdoUmlObE9YU29ob016S3NFTW9jNEpBWXZ2UTNp?=
 =?utf-8?B?YTd6OGNZUGk0L0VJaVpld1ltd0JXellzVGpOdnVpNVVtYlpzcVBGMFUvQ2Fs?=
 =?utf-8?B?ZzN4eWdYMUp1QkE3bXIyRHZSZUlXUjdZazA4S1dQN05ZZ2crQWUvbFdqMmsv?=
 =?utf-8?B?VnltZWEwOTZ6MVc5WVdDbGdYWEcxYWY0NUpzR3JHbllySFl5SVFpb0tONldR?=
 =?utf-8?B?M3BVa1RiM1RjN0YvTGREQjg2NStSeGt1TnU3UW4vQXNMSytRR3FNYWp2R3Rz?=
 =?utf-8?B?K0s2QU1KcTFjQ29rS2xFbXRmUlZ4N0F3MExMeCtQYVJpSDNJc1FHQnpqUFpV?=
 =?utf-8?B?KzdaeXZweHBBNkdOaVk0amtVNnppME9Va3I5QlJkeGNOdlVtWnhvSUxteUph?=
 =?utf-8?B?MEhxcUQvZ3ZLVFdCRHdPYUNYRDFvSTNWZVh3eDZKak9QMTJUQVN2QVhqTVZX?=
 =?utf-8?B?QnljR01pczBkcHJncThkK1EwNExhSzFOWkNvS1NXcFg0QVY4N0VXTStvNytF?=
 =?utf-8?B?L1B5bVo4Z3NOL1ZBVHFUY0JxbVZZV2lGYk14cHFRVTdKRzV6ejhVenhKODNp?=
 =?utf-8?B?aVV4ZFg5WkdiWHVIM2lRL0RwUVl2c3YxRGozcnF1NHNCK1d2eEFxYXNXdSs2?=
 =?utf-8?B?V1pvY1JEekFxa29MTVUveHlObE51bjhRcVFEZ3Azd0NnYStqNm13L0lrSEVP?=
 =?utf-8?B?Rk1nTzJtdUQ2WXE1czlkSzVWeFBpNmh6dnYwVlNzdWU0eGs5K1VFNnRFVHpn?=
 =?utf-8?B?NVcrM3BuOHd5TDU1ejVHZFlpMVVvZ1ZiVFkvRjYvdkN6SG9sZ0ZOSUhYcVlX?=
 =?utf-8?B?bVhEVnRwRWlaUHBUb0FvVmE3TDRLcXEvUTZHZTRQUnVIMCs1M2VydWp3MFRz?=
 =?utf-8?B?ZTh6aVVRMmxDZEROZDU4eGt0WFN2emZFZGF0ekVMcU1YS0NRcVlkM1diNS9G?=
 =?utf-8?B?a05zMHhpR0t4dC81TkNHaGtoa0EzVUhYVDAvU1B4S3EySUExRW10WWVUVTlT?=
 =?utf-8?B?bW5xWEF1dzZxM2h2b3dTUjlUaHNlWGVGZVlzemZUcDR5c0pqOU5FMG1Vemh2?=
 =?utf-8?B?c2h0TmlVVnJTNTlRYUV6Wi9SZXNnTnhvODNJOUFYR0trOFlkMkJnU01Lcklm?=
 =?utf-8?B?NmEvcGV6eFdVMHRJR3lJcmVtSW40T2tZT3NveDc3U2NxRmhMQkozY01HeXpL?=
 =?utf-8?B?b1dvTmd0clBCaEVRSVBQZmNzM0NnWVgrWGE3SDgxOE9tbXBCR3pIUDhySk10?=
 =?utf-8?B?L1Z0SjA2cHlEOHJuSzdHdW1qbnJrSGQ4dDVDdFdUTU4rSm9QcHVucmF0bXRw?=
 =?utf-8?B?UklDY0xmVklMOXU5Z1J1U3lPOHBhaFZVemtLREFNRFFLWU5ZQkpUMmQ4K0cw?=
 =?utf-8?Q?+a2QnDiMA5ocOSkhaYdvGKk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBC0DF0FA14B394C9890FD984AD72275@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a19718-7d98-4d69-8573-08dbe453a4a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 14:20:09.8316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQLIM532mgGcGSfk5jP8o6KqmgOkITlqPPNBm5X2qzV0d2qj5igueA2oXkWMjuhkev5VWuukfFjoolmy7i1nHMRVKF0QS57Bv/kDlFLOnYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6957
X-Proofpoint-GUID: 4U9y3bP0B7-Fl2WnexU9noE0gkzqcrZm
X-Proofpoint-ORIG-GUID: 4U9y3bP0B7-Fl2WnexU9noE0gkzqcrZm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_04,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=781 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311130116
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE2LjEwLjIzIDA5OjI4LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KDQpIZWxsbyBKdWVy
Z2VuDQoNCg0KPiBUaGVyZSBhcmUgbm8gdXNlcnMgb2YgeGVuX2lycV9mcm9tX3BpcnEoKSBhbmQg
eGVuX3NldF9pcnFfcGVuZGluZygpLg0KPiANCj4gUmVtb3ZlIHRob3NlIGZ1bmN0aW9ucy4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCg0KDQpS
ZXZpZXdlZC1ieTogT2xla3NhbmRyIFR5c2hjaGVua28gPG9sZWtzYW5kcl90eXNoY2hlbmtvQGVw
YW0uY29tPg0KDQoNCj4gLS0tDQo+ICAgZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMg
fCAzMCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICBpbmNsdWRlL3hlbi9ldmVu
dHMuaCAgICAgICAgICAgICB8ICA0IC0tLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDM0IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFz
ZS5jIGIvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMNCj4gaW5kZXggMGU0NThiMWMw
YzhjLi4xZDc5N2RkODVkMGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVu
dHNfYmFzZS5jDQo+ICsrKyBiL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jDQo+IEBA
IC0xMTY1LDI5ICsxMTY1LDYgQEAgaW50IHhlbl9kZXN0cm95X2lycShpbnQgaXJxKQ0KPiAgIAly
ZXR1cm4gcmM7DQo+ICAgfQ0KPiAgIA0KPiAtaW50IHhlbl9pcnFfZnJvbV9waXJxKHVuc2lnbmVk
IHBpcnEpDQo+IC17DQo+IC0JaW50IGlycTsNCj4gLQ0KPiAtCXN0cnVjdCBpcnFfaW5mbyAqaW5m
bzsNCj4gLQ0KPiAtCW11dGV4X2xvY2soJmlycV9tYXBwaW5nX3VwZGF0ZV9sb2NrKTsNCj4gLQ0K
PiAtCWxpc3RfZm9yX2VhY2hfZW50cnkoaW5mbywgJnhlbl9pcnFfbGlzdF9oZWFkLCBsaXN0KSB7
DQo+IC0JCWlmIChpbmZvLT50eXBlICE9IElSUVRfUElSUSkNCj4gLQkJCWNvbnRpbnVlOw0KPiAt
CQlpcnEgPSBpbmZvLT5pcnE7DQo+IC0JCWlmIChpbmZvLT51LnBpcnEucGlycSA9PSBwaXJxKQ0K
PiAtCQkJZ290byBvdXQ7DQo+IC0JfQ0KPiAtCWlycSA9IC0xOw0KPiAtb3V0Og0KPiAtCW11dGV4
X3VubG9jaygmaXJxX21hcHBpbmdfdXBkYXRlX2xvY2spOw0KPiAtDQo+IC0JcmV0dXJuIGlycTsN
Cj4gLX0NCj4gLQ0KPiAtDQo+ICAgaW50IHhlbl9waXJxX2Zyb21faXJxKHVuc2lnbmVkIGlycSkN
Cj4gICB7DQo+ICAgCXJldHVybiBwaXJxX2Zyb21faXJxKGlycSk7DQo+IEBAIC0yMDI2LDEzICsy
MDAzLDYgQEAgdm9pZCB4ZW5fY2xlYXJfaXJxX3BlbmRpbmcoaW50IGlycSkNCj4gICAJCWV2ZW50
X2hhbmRsZXJfZXhpdChpbmZvKTsNCj4gICB9DQo+ICAgRVhQT1JUX1NZTUJPTCh4ZW5fY2xlYXJf
aXJxX3BlbmRpbmcpOw0KPiAtdm9pZCB4ZW5fc2V0X2lycV9wZW5kaW5nKGludCBpcnEpDQo+IC17
DQo+IC0JZXZ0Y2huX3BvcnRfdCBldnRjaG4gPSBldnRjaG5fZnJvbV9pcnEoaXJxKTsNCj4gLQ0K
PiAtCWlmIChWQUxJRF9FVlRDSE4oZXZ0Y2huKSkNCj4gLQkJc2V0X2V2dGNobihldnRjaG4pOw0K
PiAtfQ0KPiAgIA0KPiAgIGJvb2wgeGVuX3Rlc3RfaXJxX3BlbmRpbmcoaW50IGlycSkNCj4gICB7
DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3hlbi9ldmVudHMuaCBiL2luY2x1ZGUveGVuL2V2ZW50
cy5oDQo+IGluZGV4IDIzOTMyYjA2NzNkYy4uYTEyOWNhZmE4MGVkIDEwMDY0NA0KPiAtLS0gYS9p
bmNsdWRlL3hlbi9ldmVudHMuaA0KPiArKysgYi9pbmNsdWRlL3hlbi9ldmVudHMuaA0KPiBAQCAt
ODgsNyArODgsNiBAQCB2b2lkIHhlbl9pcnFfcmVzdW1lKHZvaWQpOw0KPiAgIA0KPiAgIC8qIENs
ZWFyIGFuIGlycSdzIHBlbmRpbmcgc3RhdGUsIGluIHByZXBhcmF0aW9uIGZvciBwb2xsaW5nIG9u
IGl0ICovDQo+ICAgdm9pZCB4ZW5fY2xlYXJfaXJxX3BlbmRpbmcoaW50IGlycSk7DQo+IC12b2lk
IHhlbl9zZXRfaXJxX3BlbmRpbmcoaW50IGlycSk7DQo+ICAgYm9vbCB4ZW5fdGVzdF9pcnFfcGVu
ZGluZyhpbnQgaXJxKTsNCj4gICANCj4gICAvKiBQb2xsIHdhaXRpbmcgZm9yIGFuIGlycSB0byBi
ZWNvbWUgcGVuZGluZy4gIEluIHRoZSB1c3VhbCBjYXNlLCB0aGUNCj4gQEAgLTEyMiw5ICsxMjEs
NiBAQCBpbnQgeGVuX2JpbmRfcGlycV9tc2lfdG9faXJxKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHN0
cnVjdCBtc2lfZGVzYyAqbXNpZGVzYywNCj4gICAvKiBEZS1hbGxvY2F0ZXMgdGhlIGFib3ZlIG1l
bnRpb25lZCBwaHlzaWNhbCBpbnRlcnJ1cHQuICovDQo+ICAgaW50IHhlbl9kZXN0cm95X2lycShp
bnQgaXJxKTsNCj4gICANCj4gLS8qIFJldHVybiBpcnEgZnJvbSBwaXJxICovDQo+IC1pbnQgeGVu
X2lycV9mcm9tX3BpcnEodW5zaWduZWQgcGlycSk7DQo+IC0NCj4gICAvKiBSZXR1cm4gdGhlIHBp
cnEgYWxsb2NhdGVkIHRvIHRoZSBpcnEuICovDQo+ICAgaW50IHhlbl9waXJxX2Zyb21faXJxKHVu
c2lnbmVkIGlycSk7DQo+ICAg
