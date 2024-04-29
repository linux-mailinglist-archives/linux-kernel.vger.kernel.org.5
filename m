Return-Path: <linux-kernel+bounces-162352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3FC8B59B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94051F21F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C3D6BB28;
	Mon, 29 Apr 2024 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zOPTuRq3"
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3360481C7;
	Mon, 29 Apr 2024 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396684; cv=fail; b=JbxaBVrEKaCV6hyBBl6C5BQ4SASMfQtgiEZ1HSn1gcix4YyKI3TjvjWbmlibLYjVzi9yDHn/32/4pIDQ17ZGCgSY89KokTgLiDJrgvd+9TzmVwYL333CUNRJLHzjqtPfU2wCVHECBt5TIQoys17giXjV7R0KMzXrtBtEiYKoPr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396684; c=relaxed/simple;
	bh=4LQ3aSI43dFvlAv94IQRG4/p3Hiuxb30/ksQ/mDtyRA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eWskWyp5LWHsMtqq7TYiBtODMD9svTx0NLdwvxOVoKy1aVy7U8NHbXz8pM0KDUcfTgtWrGWhBKddmkMEasDVd7GTA5rMdsc1yhnXOplkQqjISYx3D6GdHTWS+PqSAWNfZUhHeWj/XdbleGEIa5Ax9esakshkyhWju3gzED5QL/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zOPTuRq3; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TBrDFq008441;
	Mon, 29 Apr 2024 09:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=DKIM;
	 bh=4LQ3aSI43dFvlAv94IQRG4/p3Hiuxb30/ksQ/mDtyRA=; b=zOPTuRq3dzrb
	9uPRYAy2ti3lDDy7G3lI6IcZdxJsm6wBMGXBXBlwmFzKmqcCU9C+Rdgdpv3N0maB
	GwFrxoauUwMlE4qWiL4vu2058YU8920upPV2MQq80/XJhjfUwPJaIK5NO9VfMSy/
	etO3hbSNeKhZeEwXSi828Ck/HzWNdfCcHQCfGSdidX1KnkAn5AVCoOmDrUDb5uAW
	9WdyqRUbupL1V2D52RlHRjOfEzIns86uMD4x6u4vdVoSWiSqnMQN/0bre5XkhD6z
	HXq87QrgSo6GCKP1t2J8wf64cqtJbM+XycpeezQ3QeeWP/jZtFJFloWPesY679Ab
	Xx3eu1y9vg==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3xru496cdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 09:17:45 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKjPpGqwxSwEDn+/rVNBoT2YFVq0Eo02jrsdbyXiWTCk+ZJa5SsURJb/56s8Umvpu3EgCRIO9Gpgr6DAJEfT0eY6RR8MjfVX8WFqVm98B5AWYXR/7NtwAVM4uJWZ2QgPCjHbukhwPuP/6YsNE03uJ0vpvRIXRbxs8vp9TF+NsxUzJ+LghrMjOORQHvG/Qwzl+NjQm6dhnu/n6gln9HEXNvM2UyGMA9HeYZWzCd+p0VpaDazYQtL64bw3qQj2Oa5VGqAirQYWFgkqc6i2HhJ2xCyt2mslPD0bZv8So+4fdbOx9epPPd9GsLOy1Yz//VFGaFhVxCEyd6Tz0vNdQh6FGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LQ3aSI43dFvlAv94IQRG4/p3Hiuxb30/ksQ/mDtyRA=;
 b=BMazPSBvuEzrm/ZSg/r5IAvzA8YPvLPj+Fz9xIG/SCuY2wHg13JtyZCbRBQNi2Ho/AF2s6KspZTzIojgoAFYdyxOgvtbhJ/RaU2DG6a/HJkzZ59H4oWd7OZv8kCe58mdnren54gNtSWcy9KFTFmENwTBPsQ/vEfghnAQrOHujiHVfn6L9jtjZdEJ6bC1Kv0r7C7u3+iqi0C9NVHfK0nWt3XnfX5rgMZBWeCeBO8BsYO0QptrUnvlEFMTawyt/fw8vTBPgx23pRCoVQFMIO+VX/eSWe4sU4yLsPYAtfYN3vop6Cx/dz7OXC7nYgUvWUCte+L1X50PhJ0SlecXb7ZJnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from BL1PR03MB5992.namprd03.prod.outlook.com (2603:10b6:208:30a::20)
 by SJ0PR03MB5504.namprd03.prod.outlook.com (2603:10b6:a03:28a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 13:17:42 +0000
Received: from BL1PR03MB5992.namprd03.prod.outlook.com
 ([fe80::8988:90a6:57ee:7161]) by BL1PR03MB5992.namprd03.prod.outlook.com
 ([fe80::8988:90a6:57ee:7161%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 13:17:42 +0000
From: "Gradinariu, Ramona" <Ramona.Gradinariu@analog.com>
To: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Ramona Gradinariu <ramona.bolboaca13@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "corbet@lwn.net"
	<corbet@lwn.net>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>
Subject: RE: [PATCH 4/5] iio: adis16480: add support for adis16545/7 families
Thread-Topic: [PATCH 4/5] iio: adis16480: add support for adis16545/7 families
Thread-Index: AQHalVo3bqw+P5g2UkWo1XB+DdFxTbF91gSAgAEVXwCAAFF3kA==
Date: Mon, 29 Apr 2024 13:17:42 +0000
Message-ID: 
 <BL1PR03MB5992DEBF82C0DB7BDC5EA0FF971B2@BL1PR03MB5992.namprd03.prod.outlook.com>
References: <20240423084210.191987-1-ramona.gradinariu@analog.com>
	 <20240423084210.191987-5-ramona.gradinariu@analog.com>
	 <20240428162555.3ddf31ea@jic23-huawei>
 <e62f8df4b06abc371b1e9fe3232cb593e468d54c.camel@gmail.com>
In-Reply-To: <e62f8df4b06abc371b1e9fe3232cb593e468d54c.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jY21KdmJHSnZZV05jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFrWVRSbFl6UTRZeTB3TmpKaExURXhaV1l0WW1RMFpTMDBNVFUy?=
 =?utf-8?B?TkRVd01EQXdNekJjWVcxbExYUmxjM1JjWkdFMFpXTTBPR1F0TURZeVlTMHhN?=
 =?utf-8?B?V1ZtTFdKa05HVXROREUxTmpRMU1EQXdNRE13WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STJOemt3SWlCMFBTSXhNek0xT0RnM01ESTJNRFEyT0RJeE5URWlJR2c5SWpo?=
 =?utf-8?B?T1ZVTjFjVlEyVGtsb2F5OXNNbmRIZDFKeFdXdHVUV1V4Y3owaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUTI0ME9FZGpUalZ5WVVGU016WjBWbGd6VTFOblZr?=
 =?utf-8?B?aG1jVEZXWm1SS1MwSlZSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQlJUbFRORnBCUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZoVVVKbVFVaE5RVnBSUW1wQlNGVkJZMmRDYkVGR09F?=
 =?utf-8?B?RmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNla0ZHT0VGYVowSm9RVWQzUVdO?=
 =?utf-8?B?M1FteEJSamhCV21kQ2RrRklUVUZoVVVJd1FVZHJRV1JuUW14QlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMFZCV2tGQ2NFRkdPRUZqZDBKc1FVZE5RV1JS?=
 =?utf-8?B?UW5sQlIxVkJXSGRDZDBGSVNVRmlkMEp4UVVkVlFWbDNRakJCU0UxQldIZENN?=
 =?utf-8?B?RUZIYTBGYVVVSjVRVVJGUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsUlFtdEJSMnRCV0hkQ2Vr?=
 =?utf-8?B?RkhWVUZaZDBJeFFVaEpRVnBSUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVo?=
 =?utf-8?B?UlFXTjNRbVpCU0ZGQllWRkNiRUZJU1VGTlowRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUFQwaUx6NDhMMjFs?=
 =?utf-8?Q?dGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR03MB5992:EE_|SJ0PR03MB5504:EE_
x-ms-office365-filtering-correlation-id: 4cc81456-cbe2-48f5-4eeb-08dc684ec069
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WUx0SENpbTMwWUJXSjlaTEZNUDUvKzFIdHVDQkR5UWpXQ2dab0YxaXN3RzlZ?=
 =?utf-8?B?V05DTmROTUw5Q3Z2Mkt6ZFBoUkM3djU5OHQ3ZGFMUEd2S3U0SFAyRnYveUd3?=
 =?utf-8?B?cTVxSklOcTM1Ni9ob1paZGdnbURQa2ZFdFZuU2RMMkMrTmYvRDRlaDhsR1J6?=
 =?utf-8?B?ZmdSVlg2V0tmMWhYN3A3cWtmWUt3SlJRTjRSMEM4TmxORkd3RUdxL1ZQaHhR?=
 =?utf-8?B?THF2Vjl1RjhONXB0VDc4MFdiZHp6Y3doYjZiWmczaUdOWkhxbm5XQjJUYmsy?=
 =?utf-8?B?TTg5ZHBuRHdpYjNwbnpabWxRd3I2bHBxaWo4eEYrdDZkUVo4YzQxRXMzR3RB?=
 =?utf-8?B?SmtaS29uT3JXcldMMi9pVmpiNW55S25nY2lOZEl4SWRaczBrRmFpYnUvUkYz?=
 =?utf-8?B?TmcvL2krNU5IbFM4MVZsSUttclZGOUYxUzJhbzJKQUUvS2VZQ2x2QnRveXpR?=
 =?utf-8?B?TjRtZWQ3Nk5JZmpqRnNsMFoxanY3VjUrdERBaVNMWHVmaDJHbWVyNThyOGNQ?=
 =?utf-8?B?UVFLSEFtak5DWFAwaFlQR0lpSGRNZTdIcVZ1UWMwSlE2Vkp6RWVQblZYUktO?=
 =?utf-8?B?RXQ2S1h1ejRreWh4cHdkRzNGdVJIUWJ1SVc2Z05aeWNRUDVlT3ZFL0kyNWc5?=
 =?utf-8?B?bXJoQmhNbkRGbFF3VzhJMkp5ZFBXUjN4VDFhUUlKOFh5bmo1V0VhMjBCM056?=
 =?utf-8?B?Q2JkamZIN0l1OGZzdkpYR2xGdGFRakdTTW1IUlIyQUNIL0xaUnFFTHJPc3Bt?=
 =?utf-8?B?dWlSZjhjOGRCRGdJY3JFSzJNNE45azgrTFFvRS9RL2V5TWgrSUtBRG16UzlT?=
 =?utf-8?B?bElNYThYc0dhZEpXaGNBeHZCRHN4OStLUktVQVcxR2Y0Z0pUN01QYzg2QzU0?=
 =?utf-8?B?cW42VWZ5SU5Yc3JaaVlvV1hMT0s1WkFRbzcvSHBHRWZFSmF3WGxzMHNLa0Y2?=
 =?utf-8?B?eXhvSFoxUlF3d24vNlE1bDNJQk5XRjY5b3Q5VDNFdGlBa253RXNaVGc0YTVY?=
 =?utf-8?B?M1dUUkNTb3ZUUjN2azMwYzlmMUMvcTFzaHBacTk2aFFWbHE1dmJpVGhaTFFL?=
 =?utf-8?B?QUJ5ZUVGNnpBRHd4T242enl0ZWQzSWpEc1JLSFZsZzZudlFQOWc5bysxVlJY?=
 =?utf-8?B?RkxBbGFlcXhsNUp0OXhFSXZkeE1jUGRxbEU3emhiWmZ4REZ0WGk2QjRpZnZD?=
 =?utf-8?B?RC91YURwK1JJVHhaeXpzT2RhY3pEQ0lUMnZDdGZweE56bnB4Rk1qN25RVDNq?=
 =?utf-8?B?NDN4NC9DMGE0YjlKanhWRDhIeHhxVUdnOEE4NGxTTWoyWEpmdEQrYUNMd2g0?=
 =?utf-8?B?RFJ5NXhvOUZvSk54YnZZcG9EaGsyOWJLN2JzVnR1dzdhcC9zcVZ0SVdVdnNu?=
 =?utf-8?B?SytXLzVZWW4yM3pBUEs0NDB5RGpOK251OVlKaExzaDhiOEptTXFnbzl3Qi9P?=
 =?utf-8?B?ekZvSDZ0UzNhb1dRNVMrbkY5ckVtTi9HS2xHeHhZdTl3U1dPUk5nQzg1dzRB?=
 =?utf-8?B?ZXRuRTNnRUpQRkNoK0lJaCszNjZ2Z0ZweEpuN0lCUEI4ZGpvNnFQbllSMnlE?=
 =?utf-8?B?cFVBMHZXWVh0UiswbCs1MG9TR0VsR2R6bHcwUGFQL09UUlBWQmxGN3FGaE4x?=
 =?utf-8?B?b084dnQ5R0FYcWFVYkltMHZoSzUxQ3l6cUZwWkxNeTZmQ2JrWkE4TDd3NEI5?=
 =?utf-8?B?U3RtVXNCZGk2Nk5ldHYyang0Z2xLOXBiWGlNM0tSZ1ZYck9WbTVwbVpMc1NV?=
 =?utf-8?B?M1VYeGZ3ZTdiTEFaSWZldE8xYllEOVBLQXYyc2YwS2lid1hkRk9hdm5jQzNV?=
 =?utf-8?B?Qk13aE5qMTRkR1IzQ21TUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB5992.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dGJZSDNkU2pOVDluaUc3UWNDZDJhV05IQnl5U2xOcnFkYXhFd3h6OHE2Ukor?=
 =?utf-8?B?bTBJQXIzUkVxRVdXdmRuWDR3MVluQmhBYW1QS2RpK09KYUZ3MkgxYUJFKzNU?=
 =?utf-8?B?djM2bHVKcVJKa091VzdtdUl1Mk1GamJhWU9SamhGak9sOTZnNDFWN0lkcE5u?=
 =?utf-8?B?WExWckRFTUpjeVB6N1hCQ2VNaDVtVG9BWUVvbkFPWVh4cmJ4NFZJby8wTHJT?=
 =?utf-8?B?THNEYjRIMUNiMTEvd1NkdTR2a0FxYnE0bzNFdnY5SXNlTGM0WEF0dU1BTGh5?=
 =?utf-8?B?YnZLTjFuc1ZJWjB4bXhWbXJRRGhuSUk2Q1U1K21pTUhUb0REaUpsTm43OXNl?=
 =?utf-8?B?YW5MODhWY0wzTkdGUGhlRkdpK3o1KytXbFMrRlViRXZlWTFSWXY5UW00anIy?=
 =?utf-8?B?NzJVcVQ2YjRlUnVNd1QxV0tLR3k2bW1ZUzR1dUtqamluNkRmMlNtRXl0RSto?=
 =?utf-8?B?TnQrOEU1RDZhSXJKQmZMaWFsUXFmSlBYZnAyVExJQkhEL1hmUXgydkdMM0xF?=
 =?utf-8?B?RjBkR1JXSFRxVTBySnI4TG1heVd6T0JNakRUM0VJWllrS3NmanVuR2pPWEpl?=
 =?utf-8?B?MDd5S2Q3MVFibWgzKzNaWFA4MHprUXZkaWFQZ091WlNFRkE0Uno3ZjVaUW5i?=
 =?utf-8?B?WTJNeVVETHlISVdBckQ2eHRKbm05UmRaK3RpMkE2Z0pKNDcxUnlKcmFFSHVZ?=
 =?utf-8?B?NmZMQ3h6TmtMdUsyMXZwdE9tNTF6b0t3bmRsb3c5bXlNaWdPYzgraU95OWNU?=
 =?utf-8?B?MC8rVmtvUGl0b2orb2FVM2xqMWFLZVV1R2s0cGd4STNMYzA4TEVTcXA1d2sy?=
 =?utf-8?B?SndZVlNTVTNJTWx1NFdJeldoblBmK0ZUSzZMa3BpZ2xTZXJDN24zaDlyMGxR?=
 =?utf-8?B?SWYxQUhCYW1hRUppRDdxQllKd3pwdzJSK295L2R1WkZHbFhEV3hkOFlXUmk4?=
 =?utf-8?B?QzIxUGpCMTJUT3JONTg3R2ZPWkdHcUR2MWtGeE1QWDlWZlhDSi9hVWtmRUUy?=
 =?utf-8?B?N1MvdStkL05MWDBsSU5Wek1CZTNlVng3b29YSzV1UUhRc2pSc2M1QmFrNEZI?=
 =?utf-8?B?RFFiUnJ0VzBTMGlkWGdjV3pqcHRLekpJdTZTeDAyZ25lUHFrSnR6UnBzN3J2?=
 =?utf-8?B?US9Td1VkUE12WS9lMm1kdDBRblhIT3grV1g0THY4dVlIcmNZdXh0TnNLUHRl?=
 =?utf-8?B?dGhnM0FIY1ZSblNNMDhsRmtsNjZMMjJTUFlHelk4STF4cngxYUVlK2ZpTTlk?=
 =?utf-8?B?eUV5MjRaUUtMUFJrUHlQcFRxU053ZjhwUGc1TjJrb0htWVVoMUZnMXVCSk1Q?=
 =?utf-8?B?TWVVdnpBcEpBMk9RSHhJYWNpemRxZSsya3hDZUxQUE9NOFowVHE2SGNuMWVj?=
 =?utf-8?B?THR5ZFdnck5jcEtwQi84TUhha1AyYmJVVkRBUHlSNG5zQjM3cUcrN2pheWQw?=
 =?utf-8?B?TzNkZkhOOTNKK0p3Nm5SSFBHYjdiUUNkMkNQWTBSbUxZYW42Yld4QmRsL213?=
 =?utf-8?B?QjJ4c0pWVDlTV3R0Y1luS3hsU3R6RmQ5WHBReW9ma2N1cWNXVStrYmhiV1FG?=
 =?utf-8?B?RWhJVkdla2oyUFJ3aGZKTHRlMkMydmZ4SlhpTTI3SmFyVkVRYXYxL002VXVy?=
 =?utf-8?B?YUw3N1NVUTdrUkFSeHMxdnlOTkgrMkNjaTMwM0kxWURqclp3R2hvQm56TWtq?=
 =?utf-8?B?VjdBMmFpa25lb2h0ZVl0dm50Vko5YVNURGxab3dHbVRWaVRWRlpVM05UKzgz?=
 =?utf-8?B?dWV6TVhsRjVCOVNqdy9OaU42eG5aL1VmYktzRVhneG5PSnpFSlNQalJsSy9T?=
 =?utf-8?B?bmV6WmRzdHE0a3B6ZGpqMmhxUlo4Ym00SkREVEQreERDOFdSaVMzMWpQRTFQ?=
 =?utf-8?B?UElRTVdUSTFmdEVYOUN6RHZRZkFuMGovblBBVFo2SFp2R1RhdnoyVHpGQldD?=
 =?utf-8?B?WUlRaE5xU0lvSUpKV3RYMmpNcm1pOXp3czNwbmJVUXNZbVFnKy9vamJqSno3?=
 =?utf-8?B?ODlUZkJ2Um9kVU0rTVFoLzhFa3ZHUjVVU29Yc3RTMitidTBLSnhzVDFjRU1T?=
 =?utf-8?B?RFdpckdoc245MmhMbDRoSVpQSVJEbHBQN1VmelNGM2VuMmhSU3JLL0xtWnow?=
 =?utf-8?B?Ty9JSDlieWpvV1VEODk4OWxQSXBodDlvVTNrMm42Rk5rNmpuV3NXZzJjWGV1?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB5992.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc81456-cbe2-48f5-4eeb-08dc684ec069
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 13:17:42.4575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bg0F6M9yXueMACGrN0QWr/vVBrrfP+A8lQfQlWgbIWJk1oY2lnChDYbPHpCf+arbdkBXKVE/5/EtQFzEjzBy6mTPtANMyK2TJwLvx6l99kI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5504
X-Proofpoint-GUID: 4uDwnJmnRc1ennHvYpMJcb-ehMVWVik6
X-Proofpoint-ORIG-GUID: 4uDwnJmnRc1ennHvYpMJcb-ehMVWVik6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_10,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290083

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOdW5vIFPDoSA8bm9uYW1lLm51
bm9AZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIEFwcmlsIDI5LCAyMDI0IDEwOjU5IEFNDQo+
IFRvOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsgUmFtb25hIEdyYWRpbmFy
aXUNCj4gPHJhbW9uYS5ib2xib2FjYTEzQGdtYWlsLmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBkb2NA
dmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgY29yYmV0QGx3bi5u
ZXQ7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJv
Lm9yZzsgcm9iaEBrZXJuZWwub3JnOw0KPiBHcmFkaW5hcml1LCBSYW1vbmEgPFJhbW9uYS5HcmFk
aW5hcml1QGFuYWxvZy5jb20+OyBTYSwgTnVubw0KPiA8TnVuby5TYUBhbmFsb2cuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDQvNV0gaWlvOiBhZGlzMTY0ODA6IGFkZCBzdXBwb3J0IGZvciBh
ZGlzMTY1NDUvNyBmYW1pbGllcw0KPiANCj4gW0V4dGVybmFsXQ0KPiANCj4gT24gU3VuLCAyMDI0
LTA0LTI4IGF0IDE2OjI1ICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPiA+IE9uIFR1
ZSwgMjMgQXByIDIwMjQgMTE6NDI6MDkgKzAzMDANCj4gPiBSYW1vbmEgR3JhZGluYXJpdSA8cmFt
b25hLmJvbGJvYWNhMTNAZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gVGhlIEFESVMxNjU0
NSBhbmQgQURJUzE2NTQ3IGFyZSBhIGNvbXBsZXRlIGluZXJ0aWFsIHN5c3RlbSB0aGF0DQo+ID4g
PiBpbmNsdWRlcyBhIHRyaWF4aXMgZ3lyb3Njb3BlIGFuZCBhIHRyaWF4aXMgYWNjZWxlcm9tZXRl
ci4NCj4gPiA+IFRoZSBzZXJpYWwgcGVyaXBoZXJhbCBpbnRlcmZhY2UgKFNQSSkgYW5kIHJlZ2lz
dGVyIHN0cnVjdHVyZSBwcm92aWRlIGENCj4gPiA+IHNpbXBsZSBpbnRlcmZhY2UgZm9yIGRhdGEg
Y29sbGVjdGlvbiBhbmQgY29uZmlndXJhdGlvbiBjb250cm9sLg0KPiA+ID4NCj4gPiA+IFRoZXNl
IGRldmljZXMgYXJlIHNpbWlsYXIgdG8gdGhlIG9uZXMgYWxyZWFkeSBzdXBwb3J0ZWQgaW4gdGhl
IGRyaXZlciwNCj4gPiA+IHdpdGggY2hhbmdlcyBpbiB0aGUgc2NhbGVzLCB0aW1pbmdzIGFuZCB0
aGUgbWF4IHNwaSBzcGVlZCBpbiBidXJzdA0KPiA+ID4gbW9kZS4NCj4gPiA+IEFsc28sIHRoZXkg
c3VwcG9ydCBkZWx0YSBhbmdsZSBhbmQgZGVsdGEgdmVsb2NpdHkgcmVhZGluZ3MgaW4gYnVyc3QN
Cj4gPiA+IG1vZGUsIGZvciB3aGljaCBzdXBwb3J0IHdhcyBhZGRlZCBpbiB0aGUgdHJpZ2dlciBo
YW5kbGVyLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE51bm8gU8OhIDxudW5vLnNhQGFu
YWxvZy5jb20+DQo+ID4NCj4gPiBXaGF0IGlzIE51bm8ncyByZWxhdGlvbnNoaXAgdG8gdGhpcyBw
YXRjaD/CoCBZb3UgYXJlIGF1dGhvciBhbmQgdGhlIHNlbmRlcg0KPiA+IHdoaWNoIGlzIGZpbmUs
IGJ1dCBpbiB0aGF0IGNhc2UgeW91IG5lZWQgdG8gbWFrZSBOdW5vJ3MgaW52b2x2ZW1lbnQgZXhw
bGljaXQuDQo+ID4gUGVyaGFwcyBhIENvLWRldmVsb3BlZC1ieSBvciBzaW1pbGFyIGlzIGFwcHJv
cHJpYXRlPw0KPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSYW1vbmEgR3JhZGluYXJpdSA8cmFt
b25hLmdyYWRpbmFyaXVAYW5hbG9nLmNvbT4NCj4gPiBBIGZldyBjb21tZW50cyBpbmxpbmUuwqAg
QmlnZ2VzdCBvbmUgaXMgSSdkIGxpa2UgYSBjbGVhciBzdGF0ZW1lbnQgb2Ygd2h5IHlvdQ0KPiA+
IGNhbid0IGRvIGEgYnVyc3Qgb2Ygb25lIHR5cGUsIHRoZW4gYSBidXJzdCBvZiBvdGhlci7CoCBN
eSBndWVzcyBpcyB0aGF0IHRoZQ0KPiA+IHRyYW5zaXRpb24gaXMgdmVyeSB0aW1lIGNvbnN1bWlu
Zz/CoCBJZiBzbywgdGhhdCBpcyBmaW5lLCBidXQgeW91IHNob3VsZCBiZQ0KPiA+IGFibGUNCj4g
PiB0byBsZXQgYXZhaWxhYmxlX3NjYW5fbWFza3MgaGFuZGxlIHRoZSBkaXNqb2ludCBjaGFubmVs
IHNldHMuDQo+IA0KPiBZZWFoLCB0aGUgYnVyc3QgbWVzc2FnZSBpcyBhIHNwZWNpYWwgc3BpIHRy
YW5zZmVyIHRoYXQgYnJpbmdzIHlvdSBhbGwgb2YgdGhlDQo+IGNoYW5uZWxzIGRhdGEgYXQgb25j
ZSBidXQgZm9yIHRoZSBhY2NlbC9neXJvIHlvdSBuZWVkIHRvIGV4cGxpY2l0bHkgY29uZmlndXJl
DQo+IHRoZSBjaGlwIHRvIGVpdGhlciBnaXZlIHlvdSB0aGUgIm5vcm1hbCB2cyAiZGVsdGEiIHJl
YWRpbmdzLiBSZS1jb25maWd1cmluZyB0aGUNCj4gY2hpcCBhbmQgdGhlbiBkbyBhbm90aGVyIGJ1
cnN0IHdvdWxkIGRlc3Ryb3kgcGVyZm9ybWFuY2UgSSB0aGluay4gV2UgY291bGQNCj4gZG8NCj4g
dGhlIG1hbnVhbCByZWFkaW5ncyBhcyB3ZSBkbyBpbiBhZGlzMTY0NzUgZm9yIGNoaXBzIG5vdCBz
dXBwb3J0aW5nIGJ1cnN0MzIuDQo+IEJ1dA0KPiBpbiB0aGUgYnVyc3QzMiBjYXNlIHRob3NlIG1h
bnVhbCByZWFkaW5ncyBzaG91bGQgYmUgbWluaW1hbCB3aGlsZSBpbiBoZXJlIHdlDQo+IGNvdWxk
IGhhdmUgdG8gZG8gNiBvZiB0aGVtIHdoaWNoIGNvdWxkIGFsc28gYmUgdmVyeSB0aW1lIGNvbnN1
bWluZy4uLg0KPiANCj4gTm93LCB3aHkgd2UgZG9uJ3QgdXNlIGF2YWlsYWJsZV9zY2FuX21hc2tz
IGlzIHNvbWV0aGluZyBJIGNhbid0IHJlYWxseQ0KPiByZW1lbWJlcg0KPiBidXQgdGhpcyBpbXBs
ZW1lbnRhdGlvbiBnb2VzIGluIGxpbmUgd2l0aCB3aGF0IHdlIGhhdmUgaW4gdGhlIGFkaXMxNjQ3
NQ0KPiBkcml2ZXIuDQo+IA0KPiAtIE51bm8gU8OhDQo+IA0KDQpUaGFuayB5b3UgTnVubyBmb3Ig
YWxsIHRoZSBhZGRpdGlvbmFsIGV4cGxhbmF0aW9ucy4NClJlZ2FyZGluZyB0aGUgdXNlIG9mIGF2
YWlsYWJsZV9zY2FuX21hc2tzLCB0aGUgaWRlYSBpcyB0byBoYXZlIGFueSBwb3NzaWJsZQ0KY29t
YmluYXRpb24gZm9yIGFjY2VsLCBneXJvLCB0ZW1wIGFuZCB0aW1lc3RhbXAgY2hhbm5lbHMgb3Ig
ZGVsdGEgYW5nbGUsIGRlbHRhIA0KdmVsb2NpdHksIHRlbXAgYW5kICB0aW1lc3RhbXAgY2hhbm5l
bHMuIFRoZXJlIGFyZSBhIGxvdCBvZiBjb21iaW5hdGlvbnMgZm9yIA0KdGhpcyBhbmQgaXQgZG9l
cyBub3Qgc2VlbSBsaWtlIGEgZ29vZCBpZGVhIHRvIHdyaXRlIHRoZW0gYWxsIG1hbnVhbGx5LiBU
aGF0IGlzIA0Kd2h5IGFkaXMxNjQ4MF91cGRhdGVfc2Nhbl9tb2RlIGlzIHVzZWQgZm9yIGNoZWNr
aW5nIHRoZSBjb3JyZWN0IGNoYW5uZWxzIA0Kc2VsZWN0aW9uLg0KDQpSYW1vbmEgRy4NCg==

