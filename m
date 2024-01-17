Return-Path: <linux-kernel+bounces-28396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4BF82FE0D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AEA91C244BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AEE17D9;
	Wed, 17 Jan 2024 00:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="vJ3mLjLs";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XwMvo2yw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="O7j9i2tF"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06FA80C;
	Wed, 17 Jan 2024 00:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705451962; cv=fail; b=W5+NVNG1ll/Cg+FAUvHTqNZtMt9PRhjpXTlapWkl4S8OsuJ+Zmcn7IQ8JSbJWlP6qf+ZdMnuzctnvQzDG3tYKHtzriFYLu9BKWJp29VWNJySXvyYxARQGKakcMJiK6QOyYXBsoQXz8X+cWOcQMcsXKay1+J5QQCdUVBPDr9p1P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705451962; c=relaxed/simple;
	bh=aw0XMqSsDXouLXktO5m5mDZEJ8FjLW3ZjQ4aKVDoo18=;
	h=Received:DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:
	 DKIM-Signature:Received:Received:X-SNPS-Relay:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=g/u5P9xVYwEhB9Piv5gZrOTcT3HAp4bHDx4yLE2DDtEDIky0EynqQSEtfpuIZ+DZiTOg9Iot0gsuesPR/ETgVnb/Alzr4+5yMoYbJaoPEBGvzG2RLxcnF9wqkCobML4ezl2jkuka0i1ofxiCAJbJNPhsCwppA1gWiixskc9vltU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=vJ3mLjLs; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=XwMvo2yw; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=O7j9i2tF reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40GJSLhC011559;
	Tue, 16 Jan 2024 16:39:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=aw0XMqSsDXouLXktO5m5mDZEJ8FjLW3ZjQ4aKVDoo18=; b=
	vJ3mLjLsWQ1untmOkAiJ+muVE2KPeOJ+Q3gmK5mG5Xjjm/PO3IWuOeF8Ql8lf8DH
	lYdiZlsEMBsgX45veFrxTVX/zEQ7nLDa1XiMVUg4oThPHFP8Gv/R98zjzK8wTqWV
	aU6emdESuKJp+NsrqWNd3CYachRXkAIVJM0uCe+NLKZFGq6jcLjNF1bALAxPkstO
	pd0H11GRqyt3OeOakGJEjWyzotKSXC3rM1Ehe44K5fHt+aJvQGkaKAtzP2seJ6BD
	NYtecHagPsYiMQG8hdxlpClp2zW3B8br9Rix2/txk+NmiP5nd1bPbmZzkC0t0GEU
	XarLMac2f7Pl0ztrq8G/XA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3vktn66xmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 16:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1705451950; bh=aw0XMqSsDXouLXktO5m5mDZEJ8FjLW3ZjQ4aKVDoo18=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=XwMvo2ywOynZS+cYH828+d0xytLGBS3cj2leIEbImeo/JbdCtRTR5rX65LW99oOXk
	 25qNSwl5+ZslgV650/+NNsshxwLXTvRqnOGm1/eNPFshmfYvZ3q6L2fmqRR153akOW
	 gPuftaJ0BjR42D4bovE/Zolq1yWAEtyWspqSYJvDUtDTAxfmhvNPJ7SKaDSyADrx1i
	 30cYpLsiBkUzQWq12OOOtJ+CNuLpwcZNzCtxJgLfJC2ev0WmHCR04m1eJMVZlElYz0
	 fRFMog+7vId5Tko9NTmB+lpaYulu1T+VSnpcMXb76UBLeYRQRjlT7+ynC4TB0+FaMR
	 we90sPJ90jcrw==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2133740362;
	Wed, 17 Jan 2024 00:39:10 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id A633CA008D;
	Wed, 17 Jan 2024 00:39:09 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=O7j9i2tF;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9DFE740467;
	Wed, 17 Jan 2024 00:39:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aW+S2zS69fBST2IS1+FfPj8LRH6DreG1ScrTZURDvWYf1jSYlfcvFJwyjK45AKmZJqebXQ8LXYuOa2rzcFQin5g96cGccfyDGWEjtBmF3dCZuOHqlLgyS0Cgc2dmg91l2rLxXmpAAtKCM8ouQaMn3poljkoJLAKKK+ssN35Eb6w0C9IaJbzTHi6/XJmmpaPsZ1UuyCX9JyuR4IaCs0KfbzjZRIBhMxSYR7MmqMlT9FJI/6BqP4rPaRpnIFTey8Xbq3XmdW2E4I2aabid/4ODkLzmtwUxY3vnwYB9m4SSSGUZnnZ2FML2lfpslVkPQSklkFIkchsmkB3cjy2LqPD9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aw0XMqSsDXouLXktO5m5mDZEJ8FjLW3ZjQ4aKVDoo18=;
 b=d9nNYC4PyYE4ERERTTz5TEtqVoVpgqiLksNxm1OAZSCmvOsr7K17PPv5y3W3CzlNbWrrJSMvK2KkKFzDq8v8wY/2wk1gWz3Xg9phm7YWjH4gcJLMUSR/i8w8bTOv8/xwF5JYq/XOkUyDSx4E57jL+0LWIlNlYRQbmaYEYlh0+Zkz+YhoGJuZH8a9R12aK4iin6SWMMBdoZUnYRG4YZsqWSeA0xDiIbSygGF+4NHtWnBYH3vQUD0kS+itcSiCMLyOHTisOPxyrq04MYyLVZTPhbHp35YRn86eOEVqHVNA/nhtlsQfXidWyoQKckBgwQy13GOZ1WigM+NEnyCgpopGRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aw0XMqSsDXouLXktO5m5mDZEJ8FjLW3ZjQ4aKVDoo18=;
 b=O7j9i2tFlcWSZb++10vJjxLXAYlJIENeVGuuSc4b1c3ihnZHOLuTaqLCFtUAQPhgrtiYzaqklDZQrPaUJfuAcb0JmD/x071siE4c39kdibKo5LxbAxTR93cBRavGSpHr2HZMjNZv9gQZbIyO3vNBIORKmiY2P2rnMiXGgo0IEOE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW6PR12MB7072.namprd12.prod.outlook.com (2603:10b6:303:238::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Wed, 17 Jan
 2024 00:38:58 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 00:38:58 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Prashanth K <quic_prashk@quicinc.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK
Thread-Topic: [PATCH v3 1/2] usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK
Thread-Index: AQHaSEEPkR1Qqy9PJU6lf1pifXOu/7DdKpgA
Date: Wed, 17 Jan 2024 00:38:58 +0000
Message-ID: <20240117003856.avzbos6l6u3sgm2k@synopsys.com>
References: <20240116055816.1169821-1-quic_prashk@quicinc.com>
 <20240116055816.1169821-2-quic_prashk@quicinc.com>
In-Reply-To: <20240116055816.1169821-2-quic_prashk@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW6PR12MB7072:EE_
x-ms-office365-filtering-correlation-id: c9f8e78e-68d8-4350-776b-08dc16f4b1ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 2aklldH05I8zH99GPBJ/mcOSO3jYjk5kJlwSRyhAhwe4eLe5PMoKWvXybvuihGwdGiOtz5VzKNASHtJAXm2BEo5XuLiWKYqqxDmEcYbvhXLFLN50VWha2Hk1sE/1/Dp04ItPe0kjazEpUOb2edvMZy8qiyVRdqUZE3+XvyOFXV8fovrmuTEo+n5iAEu1cv6iotaNi2P0N+AQuDd9B4r9j38Rct4yEAdGoa98hxMEdEdyY0ouvc7p73yr23+U/RK7JUQD0U/Hv7VlFCxb6PZTrAcMRMCZTJmVF8eY/NXU1t8sQZfUpCCwoabqQ/6HNOegYQK0o3Q6w3d8DY73hHKwO43HUO+pP0VxpZm+GXrKEBKynFCkYC4N4FgBxwYiEuHMn3W+O+XJoZTzFm18sCFzRTZF96piBNgg5YelJ8ftrgydHMvYO2VGbMb4LNMjN8QGmlUy09wytMji8GvfC4lLIPSk4PibyZhhcSlVWcCxFqLcAl7O+S//FDAqGDibQJm7xMIA9aedB4T2g6NUgepbX2UBt9q2AiQ+t8mk6Wy8MzNzHSMyKm32DeEwQuMYztCK80hJlMB6A/BkDAUijGoBQ/R0nQnNij3A5xQi/iB8M2FrLy0V2urmd8/9hM9pWHlu
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(8676002)(4326008)(5660300002)(8936002)(6916009)(2906002)(66446008)(66476007)(54906003)(316002)(66556008)(71200400001)(26005)(1076003)(2616005)(36756003)(86362001)(66946007)(64756008)(91956017)(76116006)(6486002)(6506007)(6512007)(478600001)(41300700001)(38100700002)(122000001)(38070700009)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZmFJUnhpR0JzZnF0V2J5UFdkdlptQ2VGblNLa3ZxYncvYmFKVlRFM3QyWGZl?=
 =?utf-8?B?UnNFVkl0ZWlBYzdnNXRBY21NMzJjRjFsNWtBdWlJRFR0OVF2cVJOUEtvcjFL?=
 =?utf-8?B?TGRzRHZTYXNqQjI0QlRiSUpkWVoyTkZtZDdNV3VOZ0FDR1FSNzIvYVE4bGky?=
 =?utf-8?B?Zmx2TTNjZktoVFp2eWQxZGc1RjdWdEZodXV0SFpCS2FNb3Z5aTZYM2Y1b2Qw?=
 =?utf-8?B?dHg4RGtwS0IvYXpEaXlkaXZQTU8vMFJsWmZKelphN2ViYXNwc2RxWUVWV01v?=
 =?utf-8?B?d1JiMkpGbmxhK0hTT0gwVHAwVEZRUmZEU1ZtbDd5TW83dUVxM0Fvam55c2Zq?=
 =?utf-8?B?aG9jcGVQVkpMSnluV0IvQTY3NzdzNTRvQTE3bXRWK3MrbXdQZ2VsRFcwQ0pN?=
 =?utf-8?B?ZS9hZzN6WDNOSVRPWVIveng1ZE5zdjJtSzNvbGd6T2d4WU5HQXY2WlpoZWxH?=
 =?utf-8?B?Y0ZianBDSTNjSWhtRlFxSVVJVzh5MnoxbW80WHZ1VDBXNy9GRWd6WFZZdytX?=
 =?utf-8?B?aTl2NkZWendGM2tyMDlrbkdndzh5cENtY3YxNWE3UGpVOElqS1dxSHNHVkVS?=
 =?utf-8?B?VVk2cmNuN3lvQTNoWWxUYlh3ZHBwY2lHVGZ3enRVUGNKK3BMWm1iWlRwQkQ2?=
 =?utf-8?B?cW13ejNEQWNEdXJwbUtld0MrSTNNSnhwYnAySUloTjJjUXFFVm1nZVhXQUk3?=
 =?utf-8?B?Ly9JVkxMWUNhQ2FncXh5TEVLUk1abEFWRmpKVEw5WkhYYVVRWnZhZXJUZHY3?=
 =?utf-8?B?VExBY3hOcmU0ejZ2Z0Foa3QvY2QyYURBR3pVR2hralV2dmRpQWFjY0RiZEN4?=
 =?utf-8?B?c3VNL2NVVXFOYVh1QTZ6OVJRUWZvc2VUYU1VcTR0NDJVVUlLL3YzVDV4WnBS?=
 =?utf-8?B?bUVuWDhFQmhWVXkvcXBhVytVOHVnTldjajZhQkpaMFFoUENKZ0Fvdmd0Z1h0?=
 =?utf-8?B?bHdzcXFtUks3c3c2WlBiTVpkbVBBZG5ZUXNya08vL2ljc0ZpZDZHTzJjRVNT?=
 =?utf-8?B?UXpQa0dYRllKSVZrTjZQT3l0QXJWc3Jtby9ZTEI1K1Zob3Z6K2lTVnRIMXox?=
 =?utf-8?B?bm9GYkU2anlGc294WENDUkNKN25FM2dnNG5KUmliZ1NQeGowdUtZQnlmTjBl?=
 =?utf-8?B?ZytYNjNoMFB4eVZuN1VZMlJXSUdtUGFucXNqOUZEanFGMkg0d09sVVp6aG9y?=
 =?utf-8?B?VHZ2d1Y5SXpnVlVtdVFxQUFac0dMaGdKcEFkWk1WNlJ2SVN2dk8yOTVIUllI?=
 =?utf-8?B?Z3kzL1ZROFZQSU16SnBKdDh2S1hIc3VyWnlWdWs0eituaWE1b25iNFFzNXBW?=
 =?utf-8?B?ZGR4MlhsRGJzak1DcWZQalU3aHRtS3pNLy8vbEpnY2NpOGM4aTlZK0pzVkQ4?=
 =?utf-8?B?ckI0UkVHSWtsSmRlNENlUDlnYzQ3SGV5VGFmSVoycmw3TU44eTJCbEovMFdQ?=
 =?utf-8?B?eWNyRE9wTFVCOGJFOGEyVWRGY1loTE9xYm10K1dLd0pWL25YbUUxcUw5SGUv?=
 =?utf-8?B?ZHNIaHFwWHBSU3U5U3pJalVPOUR4SWtka3A1azU2Y2NwUVJZd2oxSDJDVzZk?=
 =?utf-8?B?R3NFcVQ2RldJME5EZkllcEVLa2dHRWQ5M0ZFcjNzSXMrZmxpT0ZDamxTRTI3?=
 =?utf-8?B?dUlpdFVuNHN2Y3NQcXloTVJLRGY4TmZyZFNmMURNUllXdWlncUxaSTZpd0Zj?=
 =?utf-8?B?WlltdVpBNVFSaGUyVnpxTWtnSkh2KzBDdGp4VzFqOGVJbmVCNEpXQ0hzK2Js?=
 =?utf-8?B?K3o0S1lXQkJCbkxmNUNWSUhHSFhIL25Vb3lHZkhqRnIva3BCVUhwM3habFNt?=
 =?utf-8?B?M3FkamhGYXpXbE1rV3NHeTlxUXpOT1ZBeUpPS0hxaGhSZzM5YTlwbE5ZdkZE?=
 =?utf-8?B?YlZQQUpjdFJGUTdLaWlvamQ2K28zTzlrWk81L2ZMZGR1a1poRldjSzMwWmxw?=
 =?utf-8?B?ZmRXRGpMTnFnL2htVEZTWVdUMmxRa1BsQWNtNmgyS1BscC8xMjhxZGtaL1dT?=
 =?utf-8?B?cHZjNGVvZzRKbS9MeXNVZ0xKRktRWDFwVkMzM3FKT2ZxdmpDazEwTzJacmRa?=
 =?utf-8?B?azl3aHpIUk11cE1mZjg4Uzg0Q1dsNm9xVkhwRXFUYllxd3I3SVAyNWY1VGln?=
 =?utf-8?Q?qIJorNX0uMmV+gWEywax3BtxB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <423ACBCF9192884FBFE6325FF0C4D638@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hf9iaCRncSNR0AqllKfIFzEuVHy/L7er1szS9Axt7RQLOFWTZme/nNmN1wDXhzArNkuSiBTEbCi3BAnW+olld/rrCI903t1uQku7ntU9n6qOUq1nLWVF9zxOR2EM7/9prBLPlwpwe0vIMDYIhvb0ctTNd8j25mUAnECTj0Q/ykSBS5WubxxDx5kLm0ZQwcM+mwLUV8IJycA/gZIaTWdjZa1oYG0YRnzuP4pdzd8fjKiPPvu3he7Bmh7PB4lxREWfzPgvnv10iB8/Ayr7yyU/X37DWYI7rmPv8n0T/HYYc5grZyyEyd6LzSqGarhamgNLw6QLao5GvfzsXY7xpC2E+1hzSs7qH2Bx1rQuzLWF7s/+a7jx7dG8E5D7sk+cvDfRe+cr6w7CH7EsxR5wmr78g6IU0FjGNENVYwnNQutN2ViC12K91Hz0+hJ7ai2aDs5QjBit9X/TL6yd7wCR5RwCXcKSmWM0NbWv44/0k8OvBgVc9k2865FhBnQl2YCi1x07i5P3go2+YJ9Ht1WAfxCX8NLeOBLOO/JYfznyZZw0AsXD0gWbM1gKvbwmdsXBMat7NokH1XPgiGFnFWNjvAnENs42vfUc89Il9GTsI9KusdxM7DZi/kpkuOgorYbAk91nwD8N0cxK22NrY6r0kNCTGA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f8e78e-68d8-4350-776b-08dc16f4b1ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 00:38:58.8248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r752h5eajoXvlzmoVsN1gQQDYQqDX0HhnnYI5wxA/HO1gTB9X/5dAHvie8K3bH3RwJ2XvVJTxF/oyoGT/U1C5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7072
X-Proofpoint-ORIG-GUID: ORfwcV9YAmYg4B2uglBSVVUkYvb5-tNG
X-Proofpoint-GUID: ORfwcV9YAmYg4B2uglBSVVUkYvb5-tNG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 clxscore=1011 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401170003

T24gVHVlLCBKYW4gMTYsIDIwMjQsIFByYXNoYW50aCBLIHdyb3RlOg0KPiBVcHN0cmVhbSBjb21t
aXQgYmFjMWVjNTUxNDM0ICgidXNiOiB4aGNpOiBTZXQgcXVpcmsgZm9yDQo+IFhIQ0lfU0dfVFJC
X0NBQ0hFX1NJWkVfUVVJUksiKSBpbnRyb2R1Y2VkIGEgbmV3IHF1aXJrIGluIFhIQ0kNCj4gd2hp
Y2ggZml4ZXMgWEhDIHRpbWVvdXQsIHdoaWNoIHdhcyBzZWVuIG9uIHN5bm9wc3lzIFhIQ3Mgd2hp
bGUNCj4gdXNpbmcgU0cgYnVmZmVycy4gQnV0IHRoZSBzdXBwb3J0IGZvciB0aGlzIHF1aXJrIGlz
bid0IHByZXNlbnQNCj4gaW4gdGhlIERXQzMgbGF5ZXIuDQo+IA0KPiBXZSB3aWxsIGVuY291bnRl
ciB0aGlzIFhIQ0kgdGltZW91dC9odW5nIGlzc3VlIGlmIHdlIHJ1biBpcGVyZg0KPiBsb29wYmFj
ayB0ZXN0cyB1c2luZyBSVEw4MTU2IGV0aGVybmV0IGFkYXB0b3Igb24gRFdDMyB0YXJnZXRzDQo+
IHdpdGggc2NhdHRlci1nYXRoZXIgZW5hYmxlZC4gVGhpcyBnZXRzIHJlc29sdmVkIGFmdGVyIGVu
YWJsaW5nDQo+IHRoZSBYSENJX1NHX1RSQl9DQUNIRV9TSVpFX1FVSVJLLiBUaGlzIHBhdGNoIGVu
YWJsZXMgaXQgdXNpbmcNCj4gdGhlIHhoY2kgZGV2aWNlIHByb3BlcnR5IHNpbmNlIGl0cyBuZWVk
ZWQgZm9yIERXQzMgY29udHJvbGxlci4NCj4gDQo+IEluIFN5bm9wc3lzIERXQzMgZGF0YWJvb2ss
DQo+IFRhYmxlIDktMzogeEhDSSBEZWJ1ZyBDYXBhYmlsaXR5IExpbWl0YXRpb25zDQo+IENoYWlu
ZWQgVFJCcyBncmVhdGVyIHRoYW4gVFJCIGNhY2hlIHNpemU6IFRoZSBkZWJ1ZyBjYXBhYmlsaXR5
DQo+IGRyaXZlciBtdXN0IG5vdCBjcmVhdGUgYSBtdWx0aS1UUkIgVEQgdGhhdCBkZXNjcmliZXMg
c21hbGxlcg0KPiB0aGFuIGEgMUsgcGFja2V0IHRoYXQgc3ByZWFkcyBhY3Jvc3MgOCBvciBtb3Jl
IFRSQnMgb24gZWl0aGVyDQo+IHRoZSBJTiBUUiBvciB0aGUgT1VUIFRSLg0KPiANCj4gQ2M6IDxz
dGFibGVAdmdlci5rZXJuZWwub3JnPiAjNS4xMQ0KPiBTaWduZWQtb2ZmLWJ5OiBQcmFzaGFudGgg
SyA8cXVpY19wcmFzaGtAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9o
b3N0LmMgfCA0ICsrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2hvc3QuYyBiL2Ry
aXZlcnMvdXNiL2R3YzMvaG9zdC5jDQo+IGluZGV4IDYxZjU3ZmU1YmI3OC4uNDMyMzA5MTUzMjNj
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2hvc3QuYw0KPiArKysgYi9kcml2ZXJz
L3VzYi9kd2MzL2hvc3QuYw0KPiBAQCAtNjEsNyArNjEsNyBAQCBzdGF0aWMgaW50IGR3YzNfaG9z
dF9nZXRfaXJxKHN0cnVjdCBkd2MzICpkd2MpDQo+ICANCj4gIGludCBkd2MzX2hvc3RfaW5pdChz
dHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgew0KPiAtCXN0cnVjdCBwcm9wZXJ0eV9lbnRyeQlwcm9wc1s0
XTsNCj4gKwlzdHJ1Y3QgcHJvcGVydHlfZW50cnkJcHJvcHNbNV07DQo+ICAJc3RydWN0IHBsYXRm
b3JtX2RldmljZQkqeGhjaTsNCj4gIAlpbnQJCQlyZXQsIGlycTsNCj4gIAlpbnQJCQlwcm9wX2lk
eCA9IDA7DQo+IEBAIC04OSw2ICs4OSw4IEBAIGludCBkd2MzX2hvc3RfaW5pdChzdHJ1Y3QgZHdj
MyAqZHdjKQ0KPiAgDQo+ICAJbWVtc2V0KHByb3BzLCAwLCBzaXplb2Yoc3RydWN0IHByb3BlcnR5
X2VudHJ5KSAqIEFSUkFZX1NJWkUocHJvcHMpKTsNCj4gIA0KPiArCXByb3BzW3Byb3BfaWR4Kytd
ID0gUFJPUEVSVFlfRU5UUllfQk9PTCgieGhjaS1zZy10cmItY2FjaGUtc2l6ZS1xdWlyayIpOw0K
PiArDQo+ICAJaWYgKGR3Yy0+dXNiM19scG1fY2FwYWJsZSkNCj4gIAkJcHJvcHNbcHJvcF9pZHgr
K10gPSBQUk9QRVJUWV9FTlRSWV9CT09MKCJ1c2IzLWxwbS1jYXBhYmxlIik7DQo+ICANCj4gLS0g
DQo+IDIuMjUuMQ0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5
bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=

