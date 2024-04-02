Return-Path: <linux-kernel+bounces-128528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D12B895C10
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC08284832
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A11015B548;
	Tue,  2 Apr 2024 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="YW5c4cCU"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A9515AAC8;
	Tue,  2 Apr 2024 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084271; cv=fail; b=UedcniGegPSOcVIMs04HJZsyQJ6Lffkk5JZc6k3ybOvvF3aTpNHD31XkZjTuiYDjSpG2JPCwvQ02tgl01rYrMBe0N3JeXyo1tgWnXdpPxI/JGe7XVu9xOKgPQqC/0J8PKgkepo2DNsgvK9X9BnNiTyJxV4HrPGgJuaurFUUygks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084271; c=relaxed/simple;
	bh=1P/XDU3yMtnwP4ClcB6OfKwu+l7d1qqYHuZY/C6/3Sg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Axx4tEOQqr1q4n9TsXACsBbpZrS75Q6yUnOnlJh6KUy8Xk5jYEC+uwJQmkcphyLdRVwcOWp2cvIcZQrQlmIY7IFNy66hPnHghLA5F8jO1+Ntvg/CLWwyrKg8B6Itnn2Vl5QkAz3H10bWcK28iqxTIZsRekUNYNe8oMnFSEELkAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=YW5c4cCU; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 432FjgFJ013797;
	Tue, 2 Apr 2024 18:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=1P/XDU3yMtnwP4ClcB6OfKwu+l7d1qqYHuZY/C6/3Sg=;
 b=YW5c4cCUzsKMjN/KMyPMqa5CzENlYRxtk0SX+fwucBHFcGd1hSjsgaCuMx213Ogk9gJc
 gWT8kkHBzWX+fSJxawSD43qoWHrJZHHkuv6zKzF2vsicwy4h2/6MSDacq9Cif7ie3d8s
 7q4nPAZhisxF1KolPAOIhRLvb5Q9kbRjqV+jyf4Q4eHCG4iH/MUR02GpmI/RUdQMaGfs
 vf5oaREOvvoPDKE25zTJbIannoI89MJ4MgoxhrAi4VWExLISgeIJ46jHSpWTN/RpeYvu
 9C1CBiyQWC1r1gPwreGnKkrWPyEyhfyYoumCiICmxCZCt5ymxtm6DE3qPN2gAIg5CJOY Lw== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3x8cbyy36c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 18:57:32 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 5708D12B4F;
	Tue,  2 Apr 2024 18:57:30 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 2 Apr 2024 06:57:22 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Tue, 2 Apr 2024 06:57:22 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 2 Apr 2024 06:57:22 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E95CVWRtuRRyxYz1+PNm74wsvSXqgyR+vSF6A/ms7xQEWLncSioVS/0xLrWS+OtAItDlpJRE+hpUQn74n+z+HcAIdH952MEeHaHfsv+e7N4I6HjCuD3f0A50p0dMsYR9MpiQVJ5QH9kCn6CJS/2+l+oYYhfLhZJlu8GeHonN3ey+AGl8Itd6h9JspRIDJ+lSXNpQAXEfHB+A+gcdTDK90L2SSfCeprka2H8OdsWwTP37p5WjidL6PF5Yk1UYO1sJRI1qGSGoaZDnpraUmBj03ypF8aByBNzAXZ3b037Th016XP84mHRBjozYvDVnbm0cMb3T8KBZcTR/W+dBlH5Skw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1P/XDU3yMtnwP4ClcB6OfKwu+l7d1qqYHuZY/C6/3Sg=;
 b=UGcImCw/g2n+e0a0erA8BMwhUqsCXbtZatTTdvw3uK0CHYVk5WfSk1ryZaKSu2NCSub6wf49eyVghOEGx+76eDrtSBOFAPcXt2oIULo8NIAJXa8TGbF3/tfsFWerB+31IKKrAXgpQXFc7yJ5+s7YNFjsEHI5CqIQwC8cZoHO7zAZCwPCL5ZFfQzm2v05tkP5xzVM7cjWI3njmDhTUi9NYNrTPfDGsROeOFx8zx7vnI8QatzCcJYaDy7uZB34YO3PDs0c1WyeSuGjeLqdURI5p0gk0NqHDUCwatq73Tm7dZjNsklPBQLHq/GhSC8ZNMbF5wXuVPRnLHNaYUFw6pdR8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:153::10)
 by MW5PR84MB2226.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 18:57:20 +0000
Received: from PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::98bd:65c6:6d6:e5]) by PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::98bd:65c6:6d6:e5%5]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 18:57:20 +0000
From: "Ernst, Justin" <justin.ernst@hpe.com>
To: Len Brown <lenb@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tools/power/turbostat: Fix uncore frequency file string
Thread-Topic: [PATCH] tools/power/turbostat: Fix uncore frequency file string
Thread-Index: AQHacZpeBxFvlRjSPkOAQ1GFadcH5LFVZ/4AgAANvSA=
Date: Tue, 2 Apr 2024 18:57:20 +0000
Message-ID: <PH7PR84MB181347D0D20FD336933C6029873E2@PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM>
References: <20240308204957.2007212-1-justin.ernst@hpe.com>
 <CAJvTdK=R+XQZ4Vov8iXGiMADShgrwSoDL8-Jqfhii7YruRLDsg@mail.gmail.com>
In-Reply-To: <CAJvTdK=R+XQZ4Vov8iXGiMADShgrwSoDL8-Jqfhii7YruRLDsg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR84MB1813:EE_|MW5PR84MB2226:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aHbePnzgGMlHWLU3d+xMBg6pcYqkMD8KaNPhxUaqv9iNPDVN2Ykz5EbMQuGQ7SKJihzXuVZ5NyArXkdxc4KYtSgv7ScXwm4r8odSgc4v5Ta1AS19jHqIc6qM56xz7/lpGcN2FJqkylsfi7OeyqyNbq2k/ar6deRpxFvytVPUg9n7fAU0mRJRiXErQByA0vO5YzwrMSBwHKeVQWUQ6jGJshKGQlpIVWd/eFgUpdCSV+O2mu74BE9Dc1ZFZaa2U4OqQ1Xwrs1BAmT+UhGRC1vYz9tpOQ0FhUmyCiQOrKan65dhaMlYTEH+VJOg42rNFn/vMZ7wlkp6D85AvNq8rA1rZoZll/7e5Z8Ss5i0mXaodpBQ0iFkk8SYvp8venv51ODWOuSI5Fa5u/iPIUUqX9HmLPNivL7Eg3Cgo0gdJ8eCqJuv0o7T45OVh0DvaFnc6bsEXofEws69gnX2jcLCARDbtFcdqW3gU2eOYy/lLlYx14LVWU35+FYMceaMjgO2qOpFwDGg+MCNtz6+2t+PdseFrQUCrZ0jwj/uFUfZ3m9faRbCd3QE8iZWt/qidwW6cWJxzXek0a/yOO7VKCGWvL3/TRZZzNHBoHoAt46eOSQA2Kc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTBrcHFlWUNRT1NSQWI4clo0Vkp3QWw4WmcyZ2R3SFRFb1Y0TVpPRTJuQVVq?=
 =?utf-8?B?cTZvdHlwVXBQMnZUMEtTZ0tiNUdUd0lxVVN3YlRiRkg5cEwxck5zck5PY2pE?=
 =?utf-8?B?bzVPVTNkblNuYlFrdlhOVjdCUXZaZ1huM2xBSk52OVFEck1vYW5wbjNFa2J3?=
 =?utf-8?B?RFJ6WWhHTjRuUjQ1OHNZaUJtRnQ0aG9WVDRwZ1VZL1grU1lSdWNvSXVTUm1C?=
 =?utf-8?B?VTZqSUg4SDdlVVQ1ZEIyUnJoRkNtajRQRkszZHlLWUt1LzF6L1RzUjg4eU9Y?=
 =?utf-8?B?cDRlODVmUGhoZWYwY2VYcTNXaThNYzF4QWZQQW55WUtndjloWE9GR3hLMzFo?=
 =?utf-8?B?R3NNd0hVL3JjM2V5TkhEbXpCc2pJR0ExWnh0K1QrWktVbW1OaUlVci9GcWdL?=
 =?utf-8?B?dkE0RU16UitwaTlxRDBXRHJtWTY3akNhaWx0ang3QWZyRHhnK1dZTVd3MElE?=
 =?utf-8?B?UWNEbE1MQTFXeVJUUjEwelF3aWlsZXdUMEhZOEFaay9tY1V5SElMdXRGbFJU?=
 =?utf-8?B?KzJOZ041am1oTktpUk9Bam5DQmZndS9ZTG9oSk1LUnNPeHpkVjFiekFUcUd3?=
 =?utf-8?B?U1hTdWtRZTFSOStxYy9pUkhqSDZTUlF2ZEpST3VOWlFxcjVZWUZqMmJmTWRJ?=
 =?utf-8?B?ZW1SSGx4dzdGK0NwK2tSVURVYU1PU2FUdlV5U1k3VnBwYmE3ZUZmaVJNQlNZ?=
 =?utf-8?B?N3pxRFdZN2ZiRGJaWkRnZys5TlNqZ0pvZ0lhN0RhZFpCOE5XU1hiem5Qck91?=
 =?utf-8?B?V1NPRlRLMUJpdTdGVVgyUUs2Si9BNDlLaVdVUFpTSUdwVGJyL09kMGwzcTBB?=
 =?utf-8?B?dkRjRFBVYjA5OWJlS0FKTzNuQ0diMU5xVXZLSFlBNVNIOCtRQU5lcVV4Wk1z?=
 =?utf-8?B?YjdlcXA4MkhKcHU3Sml3UjIwb1ZMMTkxSFJldXpnWFhRSUFYZnJNOG0zcHA3?=
 =?utf-8?B?TXJnZHp2cjNKR1JMeTNSVTRPVnpwQnRaaG1PTlZxZWUvcG1sY0tqYVBhRElC?=
 =?utf-8?B?Zi9POXcvaFNWWHNUQktnbXJqOVVYb2tZd0c0OVZwVnVyeVJOeEpEODdmVno4?=
 =?utf-8?B?YzB6Rm5lQWlHeUlHQmZ2RXplUUtpQUk4NHpXOXhWWURHVU9NeEhHVi9pUXhr?=
 =?utf-8?B?SElqODFTZXh2Y1plWm93Um9wU1JoY0h1aFA0bGlWNUlGcXB4aXVLUzBPMUNi?=
 =?utf-8?B?M2JpWWsxaFRFKzNFYTRITHowcVRmOTJJczBURkRUNWlTRXVWV0NhdE1EVVdQ?=
 =?utf-8?B?eHM4aFFkUS9Gejl6UlFsYXJvRlVNZlpYSitLYkFhTkhEaTJmUjEwSE4waDh4?=
 =?utf-8?B?dDhvRlJja2R2VjNmYmNLNllOODlhVXBtdGhxUXZZdU9UcmlGTWlGcS9SRzEz?=
 =?utf-8?B?cGg5ZEtrQWZzMUQ5bWl3WXoxTVpGTTRoaFY0ZHFKRVVyTHJ0bjBHK1RVcmN0?=
 =?utf-8?B?MXVBR3duM2F3ZXhxd1YxMzFlNVl3SG4vbmlreEZFMWtHVDkyTE9Da1R0Vm1K?=
 =?utf-8?B?MXFhRVNHVkdVbzV4L0IyZXgzVHdyWkxEemVzM1VQblpKeHZVN21ock1WLzlv?=
 =?utf-8?B?YWhEVEJFZzUxak4xVWZmSFlrSzNXK2gvZmNsSzRaaExzamYyZWNXelFNWTdh?=
 =?utf-8?B?NnNjQWpMNUZEWkNFTlNMR2Z1R2I3MjBZSmtIWEI5WlNvblMxbC8rQjRzYURV?=
 =?utf-8?B?NVVjRm0vZjZmUVlTTnNVT2FWYkMrVnZYNGxXMS9xRk1qRlVOUm9IZVdtNXBa?=
 =?utf-8?B?NFJTcnBBVTFTQU1GbXJWd0Z5YXF4VFQ3aDZ0L0l1SXR0ZGJCSkxZRDQxZ3RX?=
 =?utf-8?B?VkM3RE5vMTJ4R1lQL0l4OWRxd1I4Z1BsTGpHaWRXVjN0TnVlZW1SSTVyUDhS?=
 =?utf-8?B?RmNhZ0ZrWktmT2N3T1lDdEoyVjh4N1dkNi90cjg2SHhYcnVxYVhZYi94U0Vn?=
 =?utf-8?B?MjFFaE4wRzNwOVNZWDZvYkMvcldybk4zNE9BYVRBdUx4enB6bjNrdXVUUUpN?=
 =?utf-8?B?YzlWc1VOWVhTMFp0OUVLbmJ2ejJKRHZoNUxTb3hwZ0hVL1RvczJLNnhKbENr?=
 =?utf-8?B?MGRIV3Uzc29OOWVWdHRueG9CZUhpa09hU2hHM0c3QU5QNVJlQTlaNmJILytO?=
 =?utf-8?Q?MF+cAal86sivfIOkymZ4GWM7t?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1813.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f1456f13-471b-431e-b90e-08dc5346b99e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 18:57:20.6315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0d131KkgWRWkpjy4uOEcUHf7M2d7V6CPLWk70V2H8ZtGHYKKqQeFdtm/92WEyn7FV8Gz96gm+ELPBw596IQY5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB2226
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 9xQaK7X60XcOam_l8cG33LZnJWOp5_zp
X-Proofpoint-ORIG-GUID: 9xQaK7X60XcOam_l8cG33LZnJWOp5_zp
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_12,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0
 clxscore=1011 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020140

PiBGcm9tOiBMZW4gQnJvd24gPGxlbmJAa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgQXBy
aWwgMiwgMjAyNCAxMjo0NiBQTQ0KPiANCj4gVGhhbmtzIGZvciB0aGUgcGF0Y2gsIEp1c3RpbiwN
Cj4gDQo+IExvb2tzIGxpa2UgdGhlIHByb2JlIHBhcnQgb2YgdGhpcyB3YXMgYWxyZWFkeSBmaXhl
ZCBpbiBteSBnaXQgdHJlZSwgc28NCj4gSSBsb3BwZWQgb2ZmIHRoYXQgaHVuayBhbmQga2VwdCB5
b3VyIDFzdCBodW5rLg0KPiANCj4gTGV0IG1lIGtub3cgaWYgaXQgd29ya3MsIG9yIGlmIEkgc2Ny
ZXdlZCBpdCB1cC4NCg0KSXQgd29ya3MhIEkgdGVzdGVkIG9uIGEgMTYtc29ja2V0IHN5c3RlbSB3
aXRoICIuLi4sIHBhY2thZ2VfMTBfZGllXzAwLywgcGFja2FnZV8xMV9kaWVfMDAvLCBldGMiIGRp
cmVjdG9yaWVzIHByZXNlbnQuDQoNClRoYW5rcyBmb3IgdGhlIGxpbmsgdG8geW91ciBsYXRlc3Qg
dHJlZS4gSXQgbWFkZSBpdCB2ZXJ5IGVhc3kgdG8gYnVpbGQgYW5kIHRlc3QgeW91ciBwYXRjaC4N
Cg0KQ2hlZXJzLA0KLUp1c3Rpbg0KDQo+IA0KPiBsYXRlc3QgaXMgaW4gdGhpcyB0cmVlOg0KPiBo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9sZW5iL2xpbnV4
LmdpdC8NCj4gDQo+IHRoYW5rcywNCj4gLUxlbg0KPiANCj4gT24gRnJpLCBNYXIgOCwgMjAyNCBh
dCAzOjUw4oCvUE0gSnVzdGluIEVybnN0IDxqdXN0aW4uZXJuc3RAaHBlLmNvbT4gd3JvdGU6DQo+
ID4NCj4gPiBSdW5uaW5nIHR1cmJvc3RhdCBvbiBhIDE2IHNvY2tldCBIUEUgU2NhbGUtdXAgQ29t
cHV0ZSAzMjAwIChTYXBwaGlyZVJhcGlkcykgZmFpbHMgd2l0aDoNCj4gPiB0dXJib3N0YXQ6IC9z
eXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2ludGVsX3VuY29yZV9mcmVxdWVuY3kvcGFja2FnZV8wMTBf
ZGllXzAwL2N1cnJlbnRfZnJlcV9raHo6IG9wZW4NCj4gZmFpbGVkOiBObyBzdWNoIGZpbGUgb3Ig
ZGlyZWN0b3J5DQo+ID4NCj4gPiBXZSBvYnNlcnZlIHRoZSBzeXNmcyB1bmNvcmUgZnJlcXVlbmN5
IGRpcmVjdG9yaWVzIG5hbWVkOg0KPiA+IC4uLg0KPiA+IHBhY2thZ2VfMDlfZGllXzAwLw0KPiA+
IHBhY2thZ2VfMTBfZGllXzAwLw0KPiA+IHBhY2thZ2VfMTFfZGllXzAwLw0KPiA+IC4uLg0KPiA+
IHBhY2thZ2VfMTVfZGllXzAwLw0KPiA+DQo+ID4gVGhlIGN1bHByaXQgaXMgYW4gaW5jb3JyZWN0
IHNwcmludGYgZm9ybWF0IHN0cmluZyAicGFja2FnZV8wJWRfZGllXzAlZCIgdXNlZA0KPiA+IHdp
dGggZWFjaCBpbnN0YW5jZSBvZiByZWFkaW5nIHVuY29yZSBmcmVxdWVuY3kgZmlsZXMuIHVuY29y
ZS1mcmVxdWVuY3ktY29tbW9uLmMNCj4gPiBjcmVhdGVzIHRoZSBzeXNmcyBkaXJlY3Rvcnkgd2l0
aCB0aGUgZm9ybWF0ICJwYWNrYWdlXyUwMmRfZGllXyUwMmQiLiBPbmNlIHRoZQ0KPiA+IHBhY2th
Z2UgdmFsdWUgcmVhY2hlcyBkb3VibGUgZGlnaXRzLCB0aGUgZm9ybWF0cyBkaXZlcmdlLg0KPiA+
DQo+ID4gQ2hhbmdlIGVhY2ggaW5zdGFuY2Ugb2YgInBhY2thZ2VfMCVkX2RpZV8wJWQiIHRvICJw
YWNrYWdlXyUwMmRfZGllXyUwMmQiLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSnVzdGluIEVy
bnN0IDxqdXN0aW4uZXJuc3RAaHBlLmNvbT4NCj4gPiAtLS0NCj4gPiAgdG9vbHMvcG93ZXIveDg2
L3R1cmJvc3RhdC90dXJib3N0YXQuYyB8IDEwICsrKysrLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS90b29scy9wb3dlci94ODYvdHVyYm9zdGF0L3R1cmJvc3RhdC5jIGIvdG9vbHMvcG93ZXIveDg2
L3R1cmJvc3RhdC90dXJib3N0YXQuYw0KPiA+IGluZGV4IDdhMzM0Mzc3ZjkyYi4uMmExNWEyM2Ni
NzI2IDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3Bvd2VyL3g4Ni90dXJib3N0YXQvdHVyYm9zdGF0
LmMNCj4gPiArKysgYi90b29scy9wb3dlci94ODYvdHVyYm9zdGF0L3R1cmJvc3RhdC5jDQo+ID4g
QEAgLTI1OTksNyArMjU5OSw3IEBAIHVuc2lnbmVkIGxvbmcgbG9uZyBnZXRfdW5jb3JlX21oeihp
bnQgcGFja2FnZSwgaW50IGRpZSkNCj4gPiAgew0KPiA+ICAgICAgICAgY2hhciBwYXRoWzEyOF07
DQo+ID4NCj4gPiAtICAgICAgIHNwcmludGYocGF0aCwNCj4gIi9zeXMvZGV2aWNlcy9zeXN0ZW0v
Y3B1L2ludGVsX3VuY29yZV9mcmVxdWVuY3kvcGFja2FnZV8wJWRfZGllXzAlZC9jdXJyZW50X2Zy
ZXFfa2h6IiwgcGFja2FnZSwNCj4gPiArICAgICAgIHNwcmludGYocGF0aCwNCj4gIi9zeXMvZGV2
aWNlcy9zeXN0ZW0vY3B1L2ludGVsX3VuY29yZV9mcmVxdWVuY3kvcGFja2FnZV8lMDJkX2RpZV8l
MDJkL2N1cnJlbnRfZnJlcV9raHoiLCBwYWNrYWdlLA0KPiA+ICAgICAgICAgICAgICAgICBkaWUp
Ow0KPiA+DQo+ID4gICAgICAgICByZXR1cm4gKHNuYXBzaG90X3N5c2ZzX2NvdW50ZXIocGF0aCkg
LyAxMDAwKTsNCj4gPiBAQCAtNDU4OSwyMCArNDU4OSwyMCBAQCBzdGF0aWMgdm9pZCBwcm9iZV9p
bnRlbF91bmNvcmVfZnJlcXVlbmN5KHZvaWQpDQo+ID4gICAgICAgICAgICAgICAgIGZvciAoaiA9
IDA7IGogPCB0b3BvLm51bV9kaWU7ICsraikgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
IGludCBrLCBsOw0KPiA+DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgc3ByaW50ZihwYXRo
LA0KPiAiL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvaW50ZWxfdW5jb3JlX2ZyZXF1ZW5jeS9wYWNr
YWdlXzAlZF9kaWVfMCVkL21pbl9mcmVxX2toeiIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgc3ByaW50ZihwYXRoLA0KPiAiL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvaW50ZWxfdW5jb3Jl
X2ZyZXF1ZW5jeS9wYWNrYWdlXyUwMmRfZGllXyUwMmQvbWluX2ZyZXFfa2h6IiwNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGksIGopOw0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIGsgPSByZWFkX3N5c2ZzX2ludChwYXRoKTsNCj4gPiAtICAgICAgICAgICAgICAgICAg
ICAgICBzcHJpbnRmKHBhdGgsDQo+ICIvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9pbnRlbF91bmNv
cmVfZnJlcXVlbmN5L3BhY2thZ2VfMCVkX2RpZV8wJWQvbWF4X2ZyZXFfa2h6IiwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICBzcHJpbnRmKHBhdGgsDQo+ICIvc3lzL2RldmljZXMvc3lzdGVt
L2NwdS9pbnRlbF91bmNvcmVfZnJlcXVlbmN5L3BhY2thZ2VfJTAyZF9kaWVfJTAyZC9tYXhfZnJl
cV9raHoiLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaSwgaik7DQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgbCA9IHJlYWRfc3lzZnNfaW50KHBhdGgpOw0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgIGZwcmludGYob3V0ZiwgIlVuY29yZSBGcmVxdWVuY3kgcGtn
JWQgZGllJWQ6ICVkIC0gJWQgTUh6ICIsIGksIGosIGsgLyAxMDAwLA0KPiBsIC8gMTAwMCk7DQo+
ID4NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBzcHJpbnRmKHBhdGgsDQo+ID4gLQ0KPiAi
L3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvaW50ZWxfdW5jb3JlX2ZyZXF1ZW5jeS9wYWNrYWdlXzAl
ZF9kaWVfMCVkL2luaXRpYWxfbWluX2ZyZXFfa2h6IiwNCj4gPiArDQo+ICIvc3lzL2RldmljZXMv
c3lzdGVtL2NwdS9pbnRlbF91bmNvcmVfZnJlcXVlbmN5L3BhY2thZ2VfJTAyZF9kaWVfJTAyZC9p
bml0aWFsX21pbl9mcmVxX2toeiIsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpLCBqKTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBrID0gcmVhZF9zeXNmc19pbnQo
cGF0aCk7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgc3ByaW50ZihwYXRoLA0KPiA+IC0N
Cj4gIi9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2ludGVsX3VuY29yZV9mcmVxdWVuY3kvcGFja2Fn
ZV8wJWRfZGllXzAlZC9pbml0aWFsX21heF9mcmVxX2toeiIsDQo+ID4gKw0KPiAiL3N5cy9kZXZp
Y2VzL3N5c3RlbS9jcHUvaW50ZWxfdW5jb3JlX2ZyZXF1ZW5jeS9wYWNrYWdlXyUwMmRfZGllXyUw
MmQvaW5pdGlhbF9tYXhfZnJlcV9raHoiLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaSwgaik7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgbCA9IHJlYWRfc3lzZnNf
aW50KHBhdGgpOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGZwcmludGYob3V0ZiwgIigl
ZCAtICVkIE1IeilcbiIsIGsgLyAxMDAwLCBsIC8gMTAwMCk7DQo+ID4gLS0NCj4gPiAyLjI2LjIN
Cj4gPg0KPiANCj4gDQo+IC0tDQo+IExlbiBCcm93biwgSW50ZWwNCg==

