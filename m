Return-Path: <linux-kernel+bounces-16652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F458241ED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25D22B24588
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89338219FC;
	Thu,  4 Jan 2024 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="c855kIav"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55562231E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 404AXP1m020338;
	Thu, 4 Jan 2024 04:38:21 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vd39qedug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 04:38:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxRx3yJA4K68QKhefaPSRWujmCTR7rm6IX9Z5MMuYCFqWzBkeL8oGnu4h+GrKdjAUj9o1Or/Rpu69FSxDE0jjfiNw1GnjPBbtbQdo0qdK9Ynd0vSIsS9Er9h3UH7sOPcXo/sEgl6o4SBuMkksOZdFZBrmQHGWf+iW3WeLbTV1YFWyCv0rJogLul3C1jLFcYLd6YrWvW5CTJAlzEWquGnjzGBGbnU1rviBQlEOWbskUJDBpTfsHhDYk+Ov1JD0MLHmbqck09dYTMN0xAq8ySqN9J5j/c+Kb6CMiPY4rBtee+uo/x6K4b2JqcF5Z/5/vp0U3LvvFpOorT0FmZDWkWTnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9Duwzjx5N8fGRe9Q/5kVHpF+XtO8OriPYN6cPl2JFw=;
 b=Z/M70v3EelQCKgRgUDQQJkewHqxWgf6ALpHApZpXAnQOoW92SGMrVlsX7bnrTG1xD3vYmTkXz8bMx/5PZHx+Ad4FIukUdWHtwGgg5UWCMfqjGiUb0CaNEAFZt4iOALE0xIh0NZ/2fueje5l10FAXbHhORmhTj0Nh34FC96zkanpbL+3v+NQlpcCMSVRxL2vBPD5YPimuni6n4hYNulhdUIEetZyG+EoPYI+BB1l3YhfFJKv9cFQiudzz1Dg5+050qWjYDT1DBba2hnWZK2QXTaYiUh2asmVFMEBVjAMA10uHPBsS2Xb/vTaWf71fQSXIc6tBEu9F1v5Dco4AEGVxQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9Duwzjx5N8fGRe9Q/5kVHpF+XtO8OriPYN6cPl2JFw=;
 b=c855kIavq8+U9jRpXkFRok47Us85FXS1fFqgok6r2TG/HFHCY7GJfL8e/0exSJIn9G9Hp+gusM5m+RESDB9S5OTTM2UmfigZFOVazGgeE4Zu7FC1zrCr0g6pSos6XQxfqcNdBkEZP3VxYBLI6BNzI9+j8wjPDosO0u6joKfGeGQ=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by SJ0PR18MB3963.namprd18.prod.outlook.com (2603:10b6:a03:2ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 12:38:16 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::cbda:8123:48d4:6632]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::cbda:8123:48d4:6632%6]) with mapi id 15.20.7159.015; Thu, 4 Jan 2024
 12:38:16 +0000
From: Elad Nachman <enachman@marvell.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
        Will Deacon
	<will@kernel.org>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "bhe@redhat.com"
	<bhe@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "yajun.deng@linux.dev" <yajun.deng@linux.dev>,
        "chris.zjh@huawei.com"
	<chris.zjh@huawei.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH] arm64: mm: Fix SOCs with DDR starting above
 zero
Thread-Topic: [EXT] Re: [PATCH] arm64: mm: Fix SOCs with DDR starting above
 zero
Thread-Index: AQHaPmZY/EHin6dDVUeSHB1g0ELBfbDIXH4AgAANHQCAAS6V4A==
Date: Thu, 4 Jan 2024 12:38:16 +0000
Message-ID: 
 <BN9PR18MB4251A62F3C57A8C6910C00F5DB672@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20240103170002.1793197-1-enachman@marvell.com>
 <20240103174531.GE5954@willie-the-truck>
 <fc6f3fff-9915-4ffd-93f0-a633d5662147@broadcom.com>
In-Reply-To: <fc6f3fff-9915-4ffd-93f0-a633d5662147@broadcom.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|SJ0PR18MB3963:EE_
x-ms-office365-filtering-correlation-id: cc503559-cfe7-46a8-17e2-08dc0d220621
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 g3HoHrLgON+UyCVnDotMYtAW8/xR9lRCzwTAdV5tV6TXseiDApIefow+fxuB/MjgIF5Y+GzSj878GqSwQq9rJXY1OEKYl6SDOc2g+YvfiHJJ32MC2wm1mtxqeE+ptziwh8Cz8YoivsLDzCDK8AK1uyjFZT8noHy5W8zntWZnDgtTpU63Qp8QYhQqLjL7nm8tv4Iz7Yd3R5b4JnvIW8hydc5aOwznL5N0asnnSVxiN65O01py7qLj24aX5pGqm0BZrUgkJBeJNC8mfD27Xv/NG42Uq+LFGFQrifY3SwhJiHIAfAnY7GZAawil3zd8ynKO+WFSgLicKw3hz/XEbodc9S/KZPVx21/lNL57bf+1WInxSZHLchSMPTp9Ker4x7yRhXsLjcH3F8u22Oh75CpwNm/R+ZfiJA3LzNvYivwOy8xspSLii7j9q28j2H0FPV+qIW6FpIfMEq1WQ1F5mSGY+MIguzKPuUs1yiVpGSPrXRDd1qjSnaapv/FA/yI9nlq9qUejG1VFyYqk3hNXQy5YbZnDRMq5a/pW+LI0EIe4f4r77YmSdF+IT/GwgRo9ZfilOrz0NNxZs1XVy1HH14Bz+Mpm0wUc9Tk28mVk40R17ab0Ocft5sHMIKTMYh54DF/XIUgHWlpozjb1Uqn2eNbVXOViZCIuM020HmYnFrhgkjI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(136003)(366004)(230173577357003)(230922051799003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(7696005)(478600001)(6506007)(71200400001)(53546011)(9686003)(8936002)(55016003)(86362001)(122000001)(8676002)(38100700002)(38070700009)(316002)(4326008)(110136005)(54906003)(52536014)(5660300002)(2906002)(7416002)(66946007)(33656002)(41300700001)(83380400001)(66556008)(66476007)(66446008)(64756008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UVN3eTZQL1QvdW10alUxT0YwOHNWcWtoMXJBeWJYNW5mQ212dlpScDQ1K0FZ?=
 =?utf-8?B?MzFsK1ZqWTNWZHc4ckkveEhTVmI5dXZlUWhYcnp1RlQ5MTZ2djM2aGdoM0JG?=
 =?utf-8?B?ZXhpOG9XdHYzdnB5QzZGc2dWa3cxN0d3a1VsOStCUjNjQnRpdTkzM2Z0cTBN?=
 =?utf-8?B?bTRQQXVLeXBMTXRuaHNyOENRRFJzVkRBVzFhRjJJcEtWWWRGUGk1UHNCb01n?=
 =?utf-8?B?Y1hPTkVFZjRQTlRacUZBM2d0M2RQVzNpYlZZWWVPcmZLMmcwNS9EZmZFUjJt?=
 =?utf-8?B?L2xPY2JUL1NZbUVlWkpjOWRqYjdUWUwxUVg1Z25hT2YzQWt3aW5tQWhESXBW?=
 =?utf-8?B?amVUaWlGNEFYTnBGaUlPNkhYZ0F1dGtYSS9PSGhnMUc5M3JuZ1RUTllQN2VV?=
 =?utf-8?B?ZGo5ZVkrb2s2cUtnbWpHVHVQTGxrdmdTUERORFRCYXFnVDFsbGlXRDlua0ZW?=
 =?utf-8?B?OFFEdFBSeUJWWUQzOElQQmRPa3MrOTRBZlNKQXZLeE8zS29FNVpGWER3aUkz?=
 =?utf-8?B?cURYbkJVcFZVQUdQbmJZbHVFVTExdzZwVGZ3QkpJdnFDVy91Y1hxVGIvb05S?=
 =?utf-8?B?QSt0U0FjMTdBc0ZmZ2FZL0N0aEo3bUN0SWNmZWROc2ViZkhpTWtwaWp0SkJo?=
 =?utf-8?B?SEk2aEhFcWJPSHpjQjFXNlQ1c1lxd09SUWU0U211YmNtWmE3T1RyQVhaWVh4?=
 =?utf-8?B?K1hQVFd1Q3EvdVNYakMyV2ErUHYwM0VVVHBBUW5TcXdFTy84WVVPMDZVSU1V?=
 =?utf-8?B?Nmxkc3NwTENVNDRRZTZXZ3JPc3F3a3h6SUNvYlZXQ1VPUXRYRkhSTHhLRU41?=
 =?utf-8?B?a2gyWDFEY0pvenJsakFMNmpJa1ZkbStlTnh1MVEzZTZCQkwwUFRkL05tekFv?=
 =?utf-8?B?bDhwNm1SOE9jN0ZFT1FOZGpwR3c5cUdBUnNDcDBoSCtxOHRDZ1N3MCtjaTRJ?=
 =?utf-8?B?R3JMbzFwN3NGRllCNzZzNm9nSktpNjdMZUU0UUk0RW5qSTczTjM0L3BtY2lJ?=
 =?utf-8?B?SjIxdENPQ1ZHczZ2TUhrZ0pMMndoUUg4N1Z3bUh0RVhxRmpkSWNyNjZSSUNU?=
 =?utf-8?B?YmU1Tno0UktWd3ppUkdPYXdMVFJPamQwVUtnZ2Z2SXozSmVhQkxtdStySE42?=
 =?utf-8?B?d3RhN1ZaRGU4LzhTa0Y0QjIxeUxFQmxnNUlJS1RNNktpNytqZTRuREl3MnZH?=
 =?utf-8?B?djJRMjI3dUk4QzhBR3JUL0U5eENkNFVERmdVV3hFWFRyVmpmVnp4NGF4Ym1h?=
 =?utf-8?B?VWZDRGFDdWtUTkliRUIrbU1Deit3ajhHd0k0MlRjcmY3ZmVjV24zbXFlbjdM?=
 =?utf-8?B?SUo0dDRIalEyY3YzZkcwNTRHMDB1aTlDY1VzVTg1d2x0Y05kWks3TFVWRm14?=
 =?utf-8?B?Y0F3cXRwZkxLazZUd0luYTdyTDkrYlNkTDlrWFUwL0twRGRXbjVJZXJkODhi?=
 =?utf-8?B?K0Z1cFFaOHgvTFNQOEFzdXhqZXFmTm5sUkZEZXArYWlUT2RjQ3Y2aDB6MFhs?=
 =?utf-8?B?dHVMNlJVU1ZKL2Uzb0V2MzU1b2wxUk9lMjhGRGw3M0NKMXJrL0F4aEViYVFV?=
 =?utf-8?B?ckZPeklya01KR2k1VGZOWWlNM2NZUHJ5TTBtY3podXRTQWs2dUMwK2RLZHpi?=
 =?utf-8?B?ZGJZcXhZVU9JRzlJUjNtTjJRVVdhRkhXNmFnVW1ZdmRQQWJsR1lBUXgxb2pK?=
 =?utf-8?B?Ukk3VHI3WHFBdStqblJNdHphMVlJR09VUENHczFiMEJrRm1KMjZ4VEpBWFBL?=
 =?utf-8?B?dXhBMnZZbVhPUGV2WTNobkhSNjczdkg0TGdoc2tEY3NuK3I5YUo1Y0V3Z2lZ?=
 =?utf-8?B?THR5aStVUDVVQ3hEclcxazFTazFKQWFSTHh0c0UvM2VGcWFlR3gzL1dZNlBo?=
 =?utf-8?B?WGVPOHRNTE1qNlFSR1kxU0dFZjhERyt2TFZKZnNURzlVRC9TNURqV01zMERn?=
 =?utf-8?B?cVdrV1IzSWprRm1aaGkwdmZWK0FVTWVaS1pSQW9FWXJMbTJUa1MyY1NPOHNn?=
 =?utf-8?B?QUhmRDhVcFNqeVcybmRrU210L3lvV05TZzUrWU40OGFjMVBHZko4RzBtOUZU?=
 =?utf-8?B?YWxNdVcvOXMxQ0JyaE1ZdENDRnFOTHFvOVYyZDZSczNqUG1XRGpmN2pJdmdz?=
 =?utf-8?B?QVNLZ1VmU0hvK0M0SzNlZG5yaFQ4T25ZWVY3U1pVbm1BZXoxMlZyZlZkbzFF?=
 =?utf-8?Q?RfZQZFGUdNJGtSiISGOTArcrGzl+nyzLkL59FWZ0iT0/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4251.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc503559-cfe7-46a8-17e2-08dc0d220621
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 12:38:16.2381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T1+Tv2j9IU/tXqB0Y1nsgPTjfwQiUazv4fzhRm7RR2K35KQM84+OXRgsHwpEMTtECpDDgOcJtnnH4vfQwE/H8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3963
X-Proofpoint-ORIG-GUID: 0ys19CCjRtF0yNoesLgVmbxXNHKLAFuo
X-Proofpoint-GUID: 0ys19CCjRtF0yNoesLgVmbxXNHKLAFuo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmxvcmlhbiBGYWluZWxs
aSA8Zmxvcmlhbi5mYWluZWxsaUBicm9hZGNvbS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFu
dWFyeSAzLCAyMDI0IDg6MzIgUE0NCj4gVG86IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+
OyBFbGFkIE5hY2htYW4NCj4gPGVuYWNobWFuQG1hcnZlbGwuY29tPg0KPiBDYzogY2F0YWxpbi5t
YXJpbmFzQGFybS5jb207IHRodW5kZXIubGVpemhlbkBodWF3ZWkuY29tOw0KPiBiaGVAcmVkaGF0
LmNvbTsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgeWFqdW4uZGVuZ0BsaW51eC5kZXY7DQo+
IGNocmlzLnpqaEBodWF3ZWkuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6IFtFWFRdIFJl
OiBbUEFUQ0hdIGFybTY0OiBtbTogRml4IFNPQ3Mgd2l0aCBERFIgc3RhcnRpbmcgYWJvdmUNCj4g
emVybw0KPiANCj4gRXh0ZXJuYWwgRW1haWwNCj4gDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gT24gMS8z
LzI0IDA5OjQ1LCBXaWxsIERlYWNvbiB3cm90ZToNCj4gPiBPbiBXZWQsIEphbiAwMywgMjAyNCBh
dCAwNzowMDowMlBNICswMjAwLCBFbGFkIE5hY2htYW4gd3JvdGU6DQo+ID4+IEZyb206IEVsYWQg
TmFjaG1hbiA8ZW5hY2htYW5AbWFydmVsbC5jb20+DQo+ID4+DQo+ID4+IFNvbWUgU09DcywgbGlr
ZSB0aGUgTWFydmVsbCBBQzUvWC9JTSwgaGF2ZSBhIGNvbWJpbmF0aW9uDQo+ID4+IG9mIEREUiBz
dGFydGluZyBhdCAweDJfMDAwMF8wMDAwIGNvdXBsZWQgd2l0aCBETUEgY29udHJvbGxlcnMNCj4g
Pj4gbGltaXRlZCB0byAzMSBhbmQgMzIgYml0IG9mIGFkZHJlc3NpbmcuDQo+ID4+IFRoaXMgcmVx
dWlyZXMgdG8gcHJvcGVybHkgYXJyYW5nZSBaT05FX0RNQSBhbmQgWk9ORV9ETUEzMiBmb3INCj4g
Pj4gdGhlc2UgU09Dcywgc28gc3dpb3RsYiBhbmQgY29oZXJlbnQgRE1BIGFsbG9jYXRpb24gd291
bGQgd29yaw0KPiA+PiBwcm9wZXJseS4NCj4gPj4gQ2hhbmdlIGluaXRpYWxpemF0aW9uIHNvIGRl
dmljZSB0cmVlIGRtYSB6b25lIGJpdHMgYXJlIHRha2VuIGFzDQo+ID4+IGZ1bmN0aW9uIG9mIG9m
ZnNldCBmcm9tIERSQU0gc3RhcnQsIGFuZCB3aGVuIGNhbGN1bGF0aW5nIHRoZQ0KPiA+PiBtYXhp
bWFsIHpvbmUgcGh5c2ljYWwgUkFNIGFkZHJlc3MgZm9yIHBoeXNpY2FsIEREUiBzdGFydGluZyBh
Ym92ZQ0KPiA+PiAzMi1iaXQsIGNvbWJpbmUgdGhlIHBoeXNpY2FsIGFkZHJlc3Mgc3RhcnQgcGx1
cyB0aGUgem9uZSBtYXNrDQo+ID4+IHBhc3NlZCBhcyBwYXJhbWV0ZXIuDQo+ID4+IFRoaXMgY3Jl
YXRlcyB0aGUgcHJvcGVyIHpvbmUgc3BsaXR0aW5nIGZvciB0aGVzZSBTT0NzOg0KPiA+PiAwLi4y
R0IgZm9yIFpPTkVfRE1BDQo+ID4+IDJHQi4uNEdCIGZvciBaT05FX0RNQTMyDQo+ID4+IDRHQi4u
OEdCIGZvciBaT05FX05PUk1BTA0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBFbGFkIE5hY2ht
YW4gPGVuYWNobWFuQG1hcnZlbGwuY29tPg0KPiA+PiAtLS0NCj4gPj4gICBhcmNoL2FybTY0L21t
L2luaXQuYyB8IDIwICsrKysrKysrKysrKysrKy0tLS0tDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQs
IDE1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQg
YS9hcmNoL2FybTY0L21tL2luaXQuYyBiL2FyY2gvYXJtNjQvbW0vaW5pdC5jDQo+ID4+IGluZGV4
IDc0YzFkYjhjZTI3MS4uODI4OGM3Nzg5MTZlIDEwMDY0NA0KPiA+PiAtLS0gYS9hcmNoL2FybTY0
L21tL2luaXQuYw0KPiA+PiArKysgYi9hcmNoL2FybTY0L21tL2luaXQuYw0KPiA+PiBAQCAtMTE1
LDIwICsxMTUsMjEgQEAgc3RhdGljIHZvaWQgX19pbml0DQo+IGFyY2hfcmVzZXJ2ZV9jcmFzaGtl
cm5lbCh2b2lkKQ0KPiA+Pg0KPiA+PiAgIC8qDQo+ID4+ICAgICogUmV0dXJuIHRoZSBtYXhpbXVt
IHBoeXNpY2FsIGFkZHJlc3MgZm9yIGEgem9uZSBhY2Nlc3NpYmxlIGJ5IHRoZQ0KPiBnaXZlbiBi
aXRzDQo+ID4+IC0gKiBsaW1pdC4gSWYgRFJBTSBzdGFydHMgYWJvdmUgMzItYml0LCBleHBhbmQg
dGhlIHpvbmUgdG8gdGhlIG1heGltdW0NCj4gPj4gLSAqIGF2YWlsYWJsZSBtZW1vcnksIG90aGVy
d2lzZSBjYXAgaXQgYXQgMzItYml0Lg0KPiA+PiArICogbGltaXQuIElmIERSQU0gc3RhcnRzIGFi
b3ZlIDMyLWJpdCwgZXhwYW5kIHRoZSB6b25lIHRvIHRoZSBhdmFpbGFibGUNCj4gbWVtb3J5DQo+
ID4+ICsgKiBzdGFydCBsaW1pdGVkIGJ5IHRoZSB6b25lIGJpdHMgbWFzaywgb3RoZXJ3aXNlIGNh
cCBpdCBhdCAzMi1iaXQuDQo+ID4+ICAgICovDQo+ID4+ICAgc3RhdGljIHBoeXNfYWRkcl90IF9f
aW5pdCBtYXhfem9uZV9waHlzKHVuc2lnbmVkIGludCB6b25lX2JpdHMpDQo+ID4+ICAgew0KPiA+
PiAgIAlwaHlzX2FkZHJfdCB6b25lX21hc2sgPSBETUFfQklUX01BU0soem9uZV9iaXRzKTsNCj4g
Pj4gICAJcGh5c19hZGRyX3QgcGh5c19zdGFydCA9IG1lbWJsb2NrX3N0YXJ0X29mX0RSQU0oKTsN
Cj4gPj4gKwlwaHlzX2FkZHJfdCBwaHlzX2VuZCA9IG1lbWJsb2NrX2VuZF9vZl9EUkFNKCk7DQo+
ID4+DQo+ID4+ICAgCWlmIChwaHlzX3N0YXJ0ID4gVTMyX01BWCkNCj4gPj4gLQkJem9uZV9tYXNr
ID0gUEhZU19BRERSX01BWDsNCj4gPj4gKwkJem9uZV9tYXNrID0gcGh5c19zdGFydCB8IHpvbmVf
bWFzazsNCj4gPj4gICAJZWxzZSBpZiAocGh5c19zdGFydCA+IHpvbmVfbWFzaykNCj4gPj4gICAJ
CXpvbmVfbWFzayA9IFUzMl9NQVg7DQo+ID4+DQo+ID4+IC0JcmV0dXJuIG1pbih6b25lX21hc2ss
IG1lbWJsb2NrX2VuZF9vZl9EUkFNKCkgLSAxKSArIDE7DQo+ID4+ICsJcmV0dXJuIG1pbih6b25l
X21hc2ssIHBoeXNfZW5kIC0gMSkgKyAxOw0KPiA+PiAgIH0NCj4gPj4NCj4gPj4gICBzdGF0aWMg
dm9pZCBfX2luaXQgem9uZV9zaXplc19pbml0KHZvaWQpDQo+ID4+IEBAIC0xNDAsNyArMTQxLDE2
IEBAIHN0YXRpYyB2b2lkIF9faW5pdCB6b25lX3NpemVzX2luaXQodm9pZCkNCj4gPj4NCj4gPj4g
ICAjaWZkZWYgQ09ORklHX1pPTkVfRE1BDQo+ID4+ICAgCWFjcGlfem9uZV9kbWFfYml0cyA9DQo+
IGZsczY0KGFjcGlfaW9ydF9kbWFfZ2V0X21heF9jcHVfYWRkcmVzcygpKTsNCj4gPj4gLQlkdF96
b25lX2RtYV9iaXRzID0gZmxzNjQob2ZfZG1hX2dldF9tYXhfY3B1X2FkZHJlc3MoTlVMTCkpOw0K
PiA+PiArCS8qDQo+ID4+ICsJICogV2hlbiBjYWxjdWxhdGluZyB0aGUgZG1hIHpvbmUgYml0cyBm
cm9tIHRoZSBkZXZpY2UgdHJlZSwgc3VidHJhY3QNCj4gPj4gKwkgKiB0aGUgRFJBTSBzdGFydCBh
ZGRyZXNzLCBpbiBjYXNlIGl0IGRvZXMgbm90IHN0YXJ0IGZyb20gYWRkcmVzcw0KPiA+PiArCSAq
IHplcm8uIFRoaXMgd2F5LiB3ZSBwYXNzIG9ubHkgdGhlIHpvbmUgc2l6ZSByZWxhdGVkIGJpdHMg
dG8NCj4gPj4gKwkgKiBtYXhfem9uZV9waHlzKCksIHdoaWNoIHdpbGwgYWRkIHRoZW0gdG8gdGhl
IGJhc2Ugb2YgdGhlIERSQU0uDQo+ID4+ICsJICogVGhpcyBwcmV2ZW50cyBtaXNjYWxjdWxhdGlv
bnMgb24gYXJtNjQgU09DcyB3aGljaCBjb21iaW5lcw0KPiA+PiArCSAqIEREUiBzdGFydGluZyBh
Ym92ZSA0R0Igd2l0aCBtZW1vcnkgY29udHJvbGxlcnMgbGltaXRlZCB0bw0KPiA+PiArCSAqIDMy
LWJpdHMgb3IgbGVzczoNCj4gPj4gKwkgKi8NCj4gPj4gKwlkdF96b25lX2RtYV9iaXRzID0gZmxz
NjQob2ZfZG1hX2dldF9tYXhfY3B1X2FkZHJlc3MoTlVMTCkgLQ0KPiBtZW1ibG9ja19zdGFydF9v
Zl9EUkFNKCkpOw0KPiA+PiAgIAl6b25lX2RtYV9iaXRzID0gbWluMygzMlUsIGR0X3pvbmVfZG1h
X2JpdHMsDQo+IGFjcGlfem9uZV9kbWFfYml0cyk7DQo+ID4+ICAgCWFybTY0X2RtYV9waHlzX2xp
bWl0ID0gbWF4X3pvbmVfcGh5cyh6b25lX2RtYV9iaXRzKTsNCj4gPj4gICAJbWF4X3pvbmVfcGZu
c1taT05FX0RNQV0gPSBQRk5fRE9XTihhcm02NF9kbWFfcGh5c19saW1pdCk7DQo+ID4NCj4gPiBI
bW0sIEknbSBhIGJpdCB3b3JyaWVkIHRoaXMgY291bGQgcmVncmVzcyBvdGhlciBwbGF0Zm9ybXMg
c2luY2UgeW91IHNlZW0NCj4gPiB0byBiZSBhc3N1bWluZyB0aGF0IERNQSBhZGRyZXNzIDAgY29y
cmVzcG9uZHMgdG8gdGhlIHBoeXNpY2FsIHN0YXJ0IG9mDQo+ID4gRFJBTS4gV2hhdCBpZiB0aGF0
IGlzbid0IHRoZSBjYXNlPw0KPiANCj4gQWxsIG9mIG91ciBtb3N0IHJlY2VudCBTZXQtdG9wLWJv
eCBTb0NzIG1hcCBEUkFNIHN0YXJ0aW5nIGF0IFBBDQo+IDB4NDAwMF8wMDAwIEZXSVcuIFdlIGhh
dmUgdGhlIGZvbGxvd2luZyBtZW1vcnkgbWFwczoNCg0KVGhhdCBpcyBiZWxvdyA0R0INCg0KPiAN
Cj4gMS4gRFJBTSBtYXBwZWQgYXQgUEEgMHgwMDAwXzAwMDANCj4gMi4gRFJBTSBtYXBwZWQgYXQg
UEEgMHg0MDAwXzAwMDAgd2l0aCBhbm90aGVyIG1lbW9yeSBjb250cm9sbGVyDQo+IHN0YXJ0aW5n
DQo+IGF0IDB4M18wMDAwXzAwMDANCj4gMy4gRFJBTSBtYXBwZWQgYXQgUEEgMHg0MDAwXzAwMDAg
d2l0aCBhIHNpbmdsZSBtZW1vcnkgY29udHJvbGxlci4NCj4gDQo+IEhlcmUgaXMgdGhlIGJlZm9y
ZS9hZnRlciBkaWZmIHdpdGggZGVidWdnaW5nIHByaW50cyBpbnRyb2R1Y2VkIHRvIHByaW50DQo+
IHN0YXJ0LCBlbmQsIG1pbiwgbWFzayBhbmQgdGhlIGR0X3pvbmVfZG1hX2JpdHMgdmFsdWU6DQo+
IA0KPiBNZW1vcnkgbWFwIDEuIHdpdGggMkdCIC0+IG5vIGNoYW5nZSBpbiBvdXRwdXQNCj4gDQo+
IE1lbW9yeSBtYXAgMi4gd2l0aCAyKzJHQiAtPiBubyBjaGFuZ2UgaW4gb3V0cHV0DQo+IA0KPiBN
ZW1vcnkgbWFwIDMuIHdpdGggNEdCOg0KPiANCj4gQEAgLTM5LDcgKzM5LDcgQEANCj4gICBbICAg
IDAuMDAwMDAwXSBPRjogcmVzZXJ2ZWQgbWVtOg0KPiAweDAwMDAwMDAwZmRmZmYwMDAuLjB4MDAw
MDAwMDBmZGZmZmZmZiAoNCBLaUIpIG5vbWFwIG5vbi1yZXVzYWJsZQ0KPiBOV01CT1gNCj4gICBb
ICAgIDAuMDAwMDAwXSBPRjogcmVzZXJ2ZWQgbWVtOg0KPiAweDAwMDAwMDAwZmUwMDAwMDAuLjB4
MDAwMDAwMDBmZmZmZmZmZiAoMzI3NjggS2lCKSBub21hcCBub24tcmV1c2FibGUNCj4gU1JSQGZl
MDAwMDAwDQo+ICAgWyAgICAwLjAwMDAwMF0gbWF4X3pvbmVfcGh5czogc3RhcnQ6IDB4MDAwMDAw
MDA0MDAwMDAwMCwgZW5kOg0KPiAweDAwMDAwMDAxNDAwMDAwMDAsIG1pbjogMHgwMDAwMDAwMTAw
MDAwMDAwLCBtYXNrOiAweDAwMDAwMDAwZmZmZmZmZmYNCj4gLVsgICAgMC4wMDAwMDBdIHpvbmVf
c2l6ZXNfaW5pdDogZHRfem9uZV9kbWFfYml0czogMHgwMDAwMDAyMQ0KPiArWyAgICAwLjAwMDAw
MF0gem9uZV9zaXplc19pbml0OiBkdF96b25lX2RtYV9iaXRzOiAweDAwMDAwMDIwDQo+ICAgWyAg
ICAwLjAwMDAwMF0gbWF4X3pvbmVfcGh5czogc3RhcnQ6IDB4MDAwMDAwMDA0MDAwMDAwMCwgZW5k
Og0KPiAweDAwMDAwMDAxNDAwMDAwMDAsIG1pbjogMHgwMDAwMDAwMTAwMDAwMDAwLCBtYXNrOiAw
eDAwMDAwMDAwZmZmZmZmZmYNCj4gICBbICAgIDAuMDAwMDAwXSBab25lIHJhbmdlczoNCj4gICBb
ICAgIDAuMDAwMDAwXSAgIERNQSAgICAgIFttZW0gMHgwMDAwMDAwMDQwMDAwMDAwLTB4MDAwMDAw
MDBmZmZmZmZmZl0NCj4gQEAgLTg4LDI0MyArODgsMjQzIEBADQo+IA0KPiBNZW1vcnkgbWFwIDMu
IHdpdGggMkdCOg0KPiANCj4gQEAgLTM5LDExICszOSwxMSBAQA0KPiAgIFsgICAgMC4wMDAwMDBd
IE9GOiByZXNlcnZlZCBtZW06DQo+IDB4MDAwMDAwMDBiZGZmZjAwMC4uMHgwMDAwMDAwMGJkZmZm
ZmZmICg0IEtpQikgbm9tYXAgbm9uLXJldXNhYmxlDQo+IE5XTUJPWA0KPiAgIFsgICAgMC4wMDAw
MDBdIE9GOiByZXNlcnZlZCBtZW06DQo+IDB4MDAwMDAwMDBiZTAwMDAwMC4uMHgwMDAwMDAwMGJm
ZmZmZmZmICgzMjc2OCBLaUIpIG5vbWFwIG5vbi1yZXVzYWJsZQ0KPiBTUlJAYmUwMDAwMDANCj4g
ICBbICAgIDAuMDAwMDAwXSBtYXhfem9uZV9waHlzOiBzdGFydDogMHgwMDAwMDAwMDQwMDAwMDAw
LCBlbmQ6DQo+IDB4MDAwMDAwMDBjMDAwMDAwMCwgbWluOiAweDAwMDAwMDAwYzAwMDAwMDAsIG1h
c2s6IDB4MDAwMDAwMDBmZmZmZmZmZg0KPiAtWyAgICAwLjAwMDAwMF0gem9uZV9zaXplc19pbml0
OiBkdF96b25lX2RtYV9iaXRzOiAweDAwMDAwMDIwDQo+IC1bICAgIDAuMDAwMDAwXSBtYXhfem9u
ZV9waHlzOiBzdGFydDogMHgwMDAwMDAwMDQwMDAwMDAwLCBlbmQ6DQo+IDB4MDAwMDAwMDBjMDAw
MDAwMCwgbWluOiAweDAwMDAwMDAwYzAwMDAwMDAsIG1hc2s6IDB4MDAwMDAwMDBmZmZmZmZmZg0K
PiArWyAgICAwLjAwMDAwMF0gem9uZV9zaXplc19pbml0OiBkdF96b25lX2RtYV9iaXRzOiAweDAw
MDAwMDFmDQo+ICtbICAgIDAuMDAwMDAwXSBtYXhfem9uZV9waHlzOiBzdGFydDogMHgwMDAwMDAw
MDQwMDAwMDAwLCBlbmQ6DQo+IDB4MDAwMDAwMDBjMDAwMDAwMCwgbWluOiAweDAwMDAwMDAwODAw
MDAwMDAsIG1hc2s6IDB4MDAwMDAwMDA3ZmZmZmZmZg0KPiAgIFsgICAgMC4wMDAwMDBdIFpvbmUg
cmFuZ2VzOg0KPiAtWyAgICAwLjAwMDAwMF0gICBETUEgICAgICBbbWVtIDB4MDAwMDAwMDA0MDAw
MDAwMC0weDAwMDAwMDAwYmZmZmZmZmZdDQo+IC1bICAgIDAuMDAwMDAwXSAgIERNQTMyICAgIGVt
cHR5DQo+ICtbICAgIDAuMDAwMDAwXSAgIERNQSAgICAgIFttZW0gMHgwMDAwMDAwMDQwMDAwMDAw
LTB4MDAwMDAwMDA3ZmZmZmZmZl0NCj4gK1sgICAgMC4wMDAwMDBdICAgRE1BMzIgICAgW21lbSAw
eDAwMDAwMDAwODAwMDAwMDAtMHgwMDAwMDAwMGJmZmZmZmZmXQ0KPiAgIFsgICAgMC4wMDAwMDBd
ICAgTm9ybWFsICAgZW1wdHkNCj4gICBbICAgIDAuMDAwMDAwXSBNb3ZhYmxlIHpvbmUgc3RhcnQg
Zm9yIGVhY2ggbm9kZQ0KPiAgIFsgICAgMC4wMDAwMDBdIEVhcmx5IG1lbW9yeSBub2RlIHJhbmdl
cw0KPiBAQCAtNTQsNyArNTQsNyBAQA0KPiAtLQ0KPiBGbG9yaWFuDQoNCkRvIHlvdSBoYXZlIGFu
IGV4YW1wbGUgd2hlcmUgdGhpcyB3b3JrcyB3aGVuIEREUiBtZW1vcnkgc3RhcnRzIGFib3ZlIDRH
Qj8NClRoZSBjb2RlIGluIG1heF96b25lX3BoeXMoKSBoYXMgc2VwYXJhdGUgaWYgY2xhdXNlcyBm
b3IgbWVtb3J5IHN0YXJ0aW5nIGFib3ZlIDRHQiwNCmFuZCBmb3IgbWVtb3J5IHN0YXJ0aW5nIGFi
b3ZlIHpvbmUgbWFzayBidXQgYmVsb3cgNEdCLi4uDQoNCkVsYWQuDQo=

