Return-Path: <linux-kernel+bounces-157927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA58F8B18C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345C71F2381D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51DE11711;
	Thu, 25 Apr 2024 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="b1KadsYi"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6AB7483;
	Thu, 25 Apr 2024 02:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714010850; cv=fail; b=T6L9rT2FZrdzac/WSizvv/gWidLJkEv46VRfsf91EKnpmNX9uA8ZhqyPk7lgApUXxgzKuxRpb5DCsDy1/+eRSVBAVDdTBDO21blWIixnvLVaBFfGiLyWJqYpkK3dkBrG5vU48hD1rz4nMUy0BlMxivF5lDJbYucmlMmsiY8oRCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714010850; c=relaxed/simple;
	bh=AfT9NSVBi+hJxuj8QxGVTC7Ot+MqqlM2ryxKwcnLsDQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m5Lz8fWObKzuIzhpVM0974CnqB7cW0W69y0ITjEVO526kY+3CyMj6CLuIJa9f6eBxHUJSsVTuNSJdgMIsbS8PSC6GiKGR7+1/UySCBDb4VNtuEaI/cA24FFCyI3ZGbmSBbEDM38oM1IVgRnUkctu2KX26VMQd/raFbpLT50gZHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=b1KadsYi; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P1VbBd031353;
	Wed, 24 Apr 2024 19:07:08 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xq284arku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 19:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFohGt2/puvFzQz/Bcgm6Tn48VIzTM4qp9X/pd9AKKUuV46Sw/Pk1PROM7kpyzkpRj9R1RwuJoOdOhjUUaY2Ou63s8S/keUKSlAG6VdaVTxYFwyUE/gLENzHmcTi0C3d2D4t4IQ68QWzK25BpJbpkgYldncsnqLflj7ntk+0L/FPqXEVCbZ79GiCZB4TeHN49UbmRtMiqbCs4NiP1zFpRn/R1cgHl0JuCdLQB1y2t+rIUyrf3npGUGRu9/FbO67tp8txT1VB0LVPvKqPJKXvClLN6SHlR3HpdmvjJpFAPEezs+QMfDS1WRYrredJsNWmiJvpJJjDWxu6QbOi3T2HEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfT9NSVBi+hJxuj8QxGVTC7Ot+MqqlM2ryxKwcnLsDQ=;
 b=KDtbhyTgVIhoP4iXlNTAfDSVUWyl+NOaZyIaCVYVsRBJqaVm39EZyuOUyBE9JwG18tQlgU7HQcDhA6qDE2XKOXfxubXovHjS4u59ea6aCw7gnSmplB4mjjtynDYNUbk19fLGBRrzimkhk+0GCGRDiHa+C8mb/InPHgnBeKl26zEhS+8NQElHaQP6Uk+8reiJQ+r23TwSafnHRo2y4j6rXASEtgQymA+ggHe/RHrBq4fzWrqeb3/86rKTmfmvQUr2qmv8WI07LCnxuvxRgN8xeaGqt7dhIZRQOhFPrV8GlBG96HpvlvZb9Mzbq/vxDKsMpHTmBfUYsOl4puu3kACOJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfT9NSVBi+hJxuj8QxGVTC7Ot+MqqlM2ryxKwcnLsDQ=;
 b=b1KadsYipCEuyu4ze+LUUXtIhtjctK6ZKK8/lzcdFmQtbyNXw0n/A0OP7dzlFY4T7zNyxjM+Uzol0SjyMxEgcN9uQO/L+b+sw1dcIMGxS3ROYj8SbF7X6dFvyXlJsj4Y2sEFRbbI4WBkvQXUJHK9Es6842w1I9Epaj2GAkkXEn0=
Received: from PH0PR18MB5002.namprd18.prod.outlook.com (2603:10b6:510:11d::12)
 by DM6PR18MB3538.namprd18.prod.outlook.com (2603:10b6:5:2a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Thu, 25 Apr
 2024 02:07:03 +0000
Received: from PH0PR18MB5002.namprd18.prod.outlook.com
 ([fe80::9914:645c:4a06:e659]) by PH0PR18MB5002.namprd18.prod.outlook.com
 ([fe80::9914:645c:4a06:e659%7]) with mapi id 15.20.7519.023; Thu, 25 Apr 2024
 02:07:02 +0000
From: Linu Cherian <lcherian@marvell.com>
To: James Clark <james.clark@arm.com>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "coresight@lists.linaro.org"
	<coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Anil Kumar Reddy H
	<areddy3@marvell.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org"
	<leo.yan@linaro.org>
Subject: RE: [EXTERNAL] Re: [PATCH v7 5/7] coresight: tmc: Add support for
 reading crash data
Thread-Topic: [EXTERNAL] Re: [PATCH v7 5/7] coresight: tmc: Add support for
 reading crash data
Thread-Index: AQHak5aBWXyywcvWg0uC8DohaEKemLFz9BwAgARMTLA=
Date: Thu, 25 Apr 2024 02:07:01 +0000
Message-ID: 
 <PH0PR18MB5002E428481F88D92EA9FA22CE172@PH0PR18MB5002.namprd18.prod.outlook.com>
References: <20240307033625.325058-1-lcherian@marvell.com>
 <20240307033625.325058-6-lcherian@marvell.com>
 <d707430f-00ee-4427-a9e4-6e42bc5b6aa9@arm.com>
 <PH0PR18MB5002D42E980EDF6317051B77CE092@PH0PR18MB5002.namprd18.prod.outlook.com>
 <a7b8d15f-5bcf-4774-a5b2-eb95d6174c43@arm.com>
 <PH0PR18MB5002CFB5DD77312CE0337896CE132@PH0PR18MB5002.namprd18.prod.outlook.com>
 <02191345-7048-4839-aecf-0e34479d49ef@arm.com>
In-Reply-To: <02191345-7048-4839-aecf-0e34479d49ef@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB5002:EE_|DM6PR18MB3538:EE_
x-ms-office365-filtering-correlation-id: afebf93e-a26a-46ae-fdcf-08dc64cc6589
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MDVSeENZdkozS3ByTklBb3FXYTdkVEd0akhTWnpVMS9TU3R4UGYzbnhqeWdV?=
 =?utf-8?B?aHVDWHJEb2d6S0FQNHZzeVFrL2h5aW1KQUdDNW1td3Z4SWNqYkUrek83dTVN?=
 =?utf-8?B?bXdNYzhCQ0JpZ05RMVJrOWd4YzFucFdnMEFtaDlaQ2p0Slpia29TQXJ3RW1E?=
 =?utf-8?B?cUlnYjdnVXN6K3lra1hoMVJQNnowVGNTaEtqRytwdHdIS1p4OVJHM0ZQZngv?=
 =?utf-8?B?NjdDS1g3SEZCTDQ5cUNTZzBoYUlERkhxTTh3aTVRNi9aL2hPTERjb2w4TFBy?=
 =?utf-8?B?T08wL09UVyt2L0wzVFVOZXlBUy9rczhqeVZXVjZ3VUJxdkVCM2FkS1liVWtX?=
 =?utf-8?B?K0RIaVMwdElhQjk4WGtqKzQ2WG1Wc3dIemVHNmhnUmNab2tSejRrTEJmU2tF?=
 =?utf-8?B?R2ovZWdYSGxtdm16TWJ3bUlMeXA4VjdqYjJYV3JMQzUxVS84MmJ4TkwvYVU2?=
 =?utf-8?B?WGxBUWZ5QzNhNFJhVC9xb3VtRW5DUHRUS2FxcUdEZWZBcS8wT3gyZFdONmx3?=
 =?utf-8?B?YjQwblEwZ2swbGtrR3VxeFBqSFNEVUF1dVpiVlhJMGJvR0FWdFE2YjZ6NHZm?=
 =?utf-8?B?cklROUMvWk9hYzdEck1lMEFtcjN0M2xtT2loVWI0dmQ2ZDdLcFVyWGJoSTFw?=
 =?utf-8?B?bEdrb0VNdU9RUGdFWVZ5eW1zcnlQWnkxQ0pLb3c3SkRZcFJwVGtwaC93YjdT?=
 =?utf-8?B?NHdjZDZPWGgrS3ZIanU0VkdRbVgyZVJWRzF3b05zL0hJOFB5dUlmeW9hN25F?=
 =?utf-8?B?SlhSVFUzVUMxT0ZTNFFFZEg3SDM2ZVAwS0FHb1JTUlRuWTV2aXUrdUs3aHlT?=
 =?utf-8?B?MERveHVRZXFiWmI5OFZzZ1R1SVBQRG9DU2hFMEZVYnkrODFqSUxMYkhMZlVq?=
 =?utf-8?B?Z3RtMkUxM3hNbjAxTWJxYjd4VjdZQjJwNytsM0ZsNHI3MHgyYTlwQ0xqYkMz?=
 =?utf-8?B?N1phLzJ0bUNJVVdsbm5pRGpZRnRhTm9lU1EvdlozWnIzTkprT0sydFBMQ1pz?=
 =?utf-8?B?S0hSdS9CdlU4LzFHT0Mwc2xrYWpVbmN5cjdYWC9jUCtoS1ZoZDl3MEdZREUy?=
 =?utf-8?B?YitZU0s5aEZKSDlsYjd3cEpONm9EY3NiN1AwNkw4cWR1bmlkRDkrR1NPWlQr?=
 =?utf-8?B?Rkxpcm1FZmRUcFE3Ym9OcHd6Tk1vaFFFK0hoNFB0RzNxU1pFdzRpS0dFamFS?=
 =?utf-8?B?RG9SRHRON0dYMFYzTS9ua2paai9TRTZpdC9HUXd5Mm5XbFJLQ05yTWdSaGdw?=
 =?utf-8?B?NTJCcTZONUNhWmRweVc2cnhBVG1KOS9Sb2ZWZDJxZHB4ZERYeFBHQ2YxZnda?=
 =?utf-8?B?aFdITk83ZWkrTmx1Y1Q0b0V3eU9CTmJrMmZoWlZIZUY1aVMwSFU3OHhFTllh?=
 =?utf-8?B?bzNQZVdRU0VTSEVhNGI3a2NJa1pwY24zZHRtT1RRU1pWUjlzVkpPVmwyWDcw?=
 =?utf-8?B?TGM5d3lWUkNPUC9VbHdmbm5FRlRuZHlya2ZIOFo5NG9xcWFWNkRncDkrS1RO?=
 =?utf-8?B?a2FKN2pRU1lPYytCMFpoZEdzbUhzTnM4QWNiMnRvOUdTaklzUHRwWVZndXhk?=
 =?utf-8?B?eDhIVFVuQ1FTNXpiRXFHNnlWWG1ENm52clJSUlBaVFVTc2FuK1JtVndQcGU1?=
 =?utf-8?B?R3d6am1kZlRYSGNYOHVUd2kzTnBUa01UMFhjSWNqbk5lNUtTVXBPbU8rOGpz?=
 =?utf-8?B?YjVjMXQrREg3WldGMzN1dXF0R29iQWtJL0hydjlGczExbFRvaXMxNHpJbnV5?=
 =?utf-8?B?Qit6enU1bnprNTFUVDJRcUd5TG9kUWlMcHRYYTJpcXRNNitJQTVyTjdrU2Yz?=
 =?utf-8?B?Q25Dc2ljVHdheDdVckl2UT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB5002.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UjJoMDcrZUc4aVd6akRXaXdUMlhabE5LTVhLeVBIcEliRmJJV3loZktRUGEy?=
 =?utf-8?B?aThLckVBMXZVTEVkaWZPcHh2Qm8zZUxXTmxkNmdpRDVHUXl6dTZKZjloa0d3?=
 =?utf-8?B?Z3ljSFhWNlFIMmg0WDNlT1cvWkxUL3k2bGFWbXZXVkx0Ykl3UFpLQ2o1aUUr?=
 =?utf-8?B?M2wzcFdNbjVtdjZhR1Y5aURFcUVRaElZRjBlV1FzUjFQVG9ZSW1Wbnh3NXly?=
 =?utf-8?B?VFZEbjFKUWNSYUZPVFE3SHcvb3FpZkQ5dVJMZWNUYXpSY2xlSVMzVVpnTFVI?=
 =?utf-8?B?K3lXMjFpQWlEZG92VXR5aXlVeUNDakU5UWpKWnV4OTI1ZERXOWE3cXFMS2hT?=
 =?utf-8?B?Z2ZYaFJ3NVhDZGJoNXlLQ2NNdmVqdXd5Q2lndkk5TE1EZm9NZS9iQVVFUEs0?=
 =?utf-8?B?QVVJOUF2RzBJRTh3UkxXVUtSMWZzb2p6SUJrdUluWndOQ3Z5NXBqRExLZURJ?=
 =?utf-8?B?WHRLMk9LeEt4bS9RYitTVFVsbVNMQ1NocHVwUmZFc3N3T2I0WXY0OHpyK3JE?=
 =?utf-8?B?NzRiczgycW90Q3VmdTVGazJyWmJvanNvZjVRNWYzOVV5c3dtVnJ1b3ZEUGJ5?=
 =?utf-8?B?MVdhcEtQWTZsdklMSXNPNEVBRlhzVFhvMjNSZUdSVThUMkUyc1B4WVc0N3Jh?=
 =?utf-8?B?QWZPVXVyOXcyWFh1NlVhVXJqbWZob08zaGZxVmxURENZZnN4dUhWWHppdHhZ?=
 =?utf-8?B?NFBjdGxpTHBaZ2hkUHlkc3I1cCt6ZXBxNmtIYjhZUjVTczNjQWVaMkNaa21P?=
 =?utf-8?B?S05iOXlHYmZVSTJRZG9OQlhXTGRkY2FiWVR1L2VGcGtpbEY0U0lmR2NrUzVp?=
 =?utf-8?B?My9mcHhaaTBPNHQvcWRIZTQyYVMwQzY1VVhvYlhuTGZjWXU3Zmhrc09vdnIz?=
 =?utf-8?B?MmNqaEJSMUN6ZEw1SVpMR0cvY3RoZHZKbEt3Q2hsWGE3THFNQmNmRlcwR2kx?=
 =?utf-8?B?OHNBczlDZG1SZjJJbGFmeE9qbjhLcm55T1JkWjNMRXlrd0JuY2tXdytwS0tl?=
 =?utf-8?B?ZWpncnU4VStia2dYUElQNlNNSGgyZ3pzTDl6VVM0NnZWcm42N3ZKY1Ivbmgx?=
 =?utf-8?B?SlgwU0J0OGZPLzFJcHpuUWU4dWloRlJobXZmaTZteVo3Y1hxbG45a0hBQWl4?=
 =?utf-8?B?U1I1SkZLa2YzeGF1R2doYUVaTXk5S3JmS1VuTkFtRExTUXQ4V1R0Z3BCUFRT?=
 =?utf-8?B?a0J0dzkzaFRkcFFhdEFMNjI1VU81Uk9UTi9PWTVETkVGM1hyeDF2UHUrZXhw?=
 =?utf-8?B?d0x2WkVrcTJrR2ZUeWRTOHo4Vnh4Zjk0alpZd2dlWXV3NHpVTy95cGM3RGYy?=
 =?utf-8?B?RFprWXpCenUwMWZjMll4QWM0KzVqaHVOalVmNUlFcERHOFAxUFVPRFc5QjZT?=
 =?utf-8?B?blpmekJTUStXSFdrWjMxaU4ycmJXbHlqQXg4UUk0MFhqS0tVMXpnTTBjRG5K?=
 =?utf-8?B?RFB2Q0NkblBLSHplK0RjY2luVmtyUDAzNTh2bFc3SXp4VldTQllDVGRYSkg1?=
 =?utf-8?B?TVhJdFg0dXRWR0ViOE5UaFFxNFIwKzdVQzB6M2VsajRKMEs1WE1nVmMvVEVE?=
 =?utf-8?B?RlBGZmhUaDV6cjFBd0pIRDFTT3VsUVpkV203WWRYZDE1WjE5UzJ6ZUV2VmZz?=
 =?utf-8?B?WGJBYmlycHpWR09ISVpSTWdzaE5BTnJPVHJZODJ0N0I4WkxXT1FMbkEvYkFt?=
 =?utf-8?B?RThMQzBsM1BidGdIVDJvVGFCa0J3Y3p1TU4yTTlZSmZ2UzZXQ1l6REtsbDR1?=
 =?utf-8?B?cmk2MDQ0NE1ZYjRiaWgzQmZlNTJnVHZ4aCtiRiszMlBWc3NzZVllRUU3aHBO?=
 =?utf-8?B?am8vc0QzRXF1UzJVc214THZVaTA0cXB4UHVKWlhiS1BuSEdZWERTUHdTUGM4?=
 =?utf-8?B?d0VreUNVZTk5YzJzNWZzUzk4MzVFbHZ3c0FYZ2lVeFRBbERDYUJWVzlsczkx?=
 =?utf-8?B?enFIQTVTaEVSaUYva2c5TnNGdlZ1bFRRRkhSSVl6YVg5T0IyQXZyWkZtdmdr?=
 =?utf-8?B?UnlNbVQvWW9obkJBMGNRS2NpRUc1MWRVMDRNanRMcDVkdC9GbXV2NnFJbXVU?=
 =?utf-8?B?aFRwZUhDY1pKMnNoQU5EYjJWdjhGZXE4UE9EVzd5dVdwMk5HQnozcVk0MEda?=
 =?utf-8?B?Y2ZQbktjQVZpNG1UUEhPYmRDeDJzN3BBdSt0WURKUjM0WlNKVTAxSEJZQjFh?=
 =?utf-8?Q?NwagNxnPv8Mz0EM/mB9udo/BvLQqDmGi8l99OU21klks?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB5002.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afebf93e-a26a-46ae-fdcf-08dc64cc6589
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 02:07:01.9084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETkfmYasiKFuM49DOAXx6lqvCljL90/EXFNk5VUeIbb5y7WmvEWofb1lnzzf/UzyQRyq8vgI4070FAF21foHWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3538
X-Proofpoint-GUID: wqkVkHYxPY1PrVA1GJfrgKm24r5dh-US
X-Proofpoint-ORIG-GUID: wqkVkHYxPY1PrVA1GJfrgKm24r5dh-US
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_01,2024-04-24_01,2023-05-22_02

SGkgSmFtZXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFtZXMg
Q2xhcmsgPGphbWVzLmNsYXJrQGFybS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgQXByaWwgMjIsIDIw
MjQgMTo0OCBQTQ0KPiBUbzogTGludSBDaGVyaWFuIDxsY2hlcmlhbkBtYXJ2ZWxsLmNvbT47IFN1
enVraSBLIFBvdWxvc2UNCj4gPHN1enVraS5wb3Vsb3NlQGFybS5jb20+DQo+IENjOiBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGNvcmVzaWdodEBsaXN0cy5saW5hcm8ub3Jn
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0K
PiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7
DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBTdW5pbCBLb3Z2dXJpIEdvdXRoYW0NCj4g
PHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgR2VvcmdlIENoZXJpYW4gPGdjaGVyaWFuQG1hcnZlbGwu
Y29tPjsgQW5pbA0KPiBLdW1hciBSZWRkeSBIIDxhcmVkZHkzQG1hcnZlbGwuY29tPjsgVGFubWF5
IEphZ2RhbGUNCj4gPHRhbm1heUBtYXJ2ZWxsLmNvbT47IG1pa2UubGVhY2hAbGluYXJvLm9yZzsg
bGVvLnlhbkBsaW5hcm8ub3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2NyA1
LzddIGNvcmVzaWdodDogdG1jOiBBZGQgc3VwcG9ydCBmb3INCj4gcmVhZGluZyBjcmFzaCBkYXRh
DQo+IA0KPiBQcmlvcml0aXplIHNlY3VyaXR5IGZvciBleHRlcm5hbCBlbWFpbHM6IENvbmZpcm0g
c2VuZGVyIGFuZCBjb250ZW50IHNhZmV0eQ0KPiBiZWZvcmUgY2xpY2tpbmcgbGlua3Mgb3Igb3Bl
bmluZyBhdHRhY2htZW50cw0KPiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiANCj4gDQo+IE9uIDIxLzA0
LzIwMjQgMDM6NDksIExpbnUgQ2hlcmlhbiB3cm90ZToNCj4gPiBIaSBKYW1lcywNCj4gPg0KPiA+
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBKYW1lcyBDbGFyayA8amFt
ZXMuY2xhcmtAYXJtLmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBBcHJpbCAxNSwgMjAyNCAyOjU5
IFBNDQo+ID4+IFRvOiBMaW51IENoZXJpYW4gPGxjaGVyaWFuQG1hcnZlbGwuY29tPjsgU3V6dWtp
IEsgUG91bG9zZQ0KPiA+PiA8c3V6dWtpLnBvdWxvc2VAYXJtLmNvbT4NCj4gPj4gQ2M6IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgY29yZXNpZ2h0QGxpc3RzLmxpbmFyby5v
cmc7DQo+ID4+IGxpbnV4LSBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5v
cmc7DQo+ID4+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgY29ub3IrZHRAa2Vy
bmVsLm9yZzsNCj4gPj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IFN1bmlsIEtvdnZ1cmkg
R291dGhhbQ0KPiA+PiA8c2dvdXRoYW1AbWFydmVsbC5jb20+OyBHZW9yZ2UgQ2hlcmlhbiA8Z2No
ZXJpYW5AbWFydmVsbC5jb20+Ow0KPiBBbmlsDQo+ID4+IEt1bWFyIFJlZGR5IEggPGFyZWRkeTNA
bWFydmVsbC5jb20+OyBUYW5tYXkgSmFnZGFsZQ0KPiA+PiA8dGFubWF5QG1hcnZlbGwuY29tPjsg
bWlrZS5sZWFjaEBsaW5hcm8ub3JnOyBsZW8ueWFuQGxpbmFyby5vcmcNCj4gPj4gU3ViamVjdDog
UmU6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2NyA1LzddIGNvcmVzaWdodDogdG1jOiBBZGQNCj4g
Pj4gc3VwcG9ydCBmb3IgcmVhZGluZyBjcmFzaCBkYXRhDQo+ID4+DQo+ID4+DQo+ID4+DQo+ID4+
IE9uIDE1LzA0LzIwMjQgMDU6MDEsIExpbnUgQ2hlcmlhbiB3cm90ZToNCj4gPj4+IEhpIEphbWVz
LA0KPiA+Pj4NCj4gPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+IEZyb206
IEphbWVzIENsYXJrIDxqYW1lcy5jbGFya0Bhcm0uY29tPg0KPiA+Pj4+IFNlbnQ6IEZyaWRheSwg
QXByaWwgMTIsIDIwMjQgMzozNiBQTQ0KPiA+Pj4+IFRvOiBMaW51IENoZXJpYW4gPGxjaGVyaWFu
QG1hcnZlbGwuY29tPjsgU3V6dWtpIEsgUG91bG9zZQ0KPiA+Pj4+IDxzdXp1a2kucG91bG9zZUBh
cm0uY29tPg0KPiA+Pj4+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
DQo+ID4+Pj4gY29yZXNpZ2h0QGxpc3RzLmxpbmFyby5vcmc7DQo+ID4+Pj4gbGludXgtIGtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gPj4+PiBrcnp5c3p0b2Yu
a296bG93c2tpK2R0QGxpbmFyby5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+ID4+Pj4gZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IFN1bmlsIEtvdnZ1cmkgR291dGhhbQ0KPiA+Pj4+IDxz
Z291dGhhbUBtYXJ2ZWxsLmNvbT47IEdlb3JnZSBDaGVyaWFuIDxnY2hlcmlhbkBtYXJ2ZWxsLmNv
bT47DQo+ID4+IEFuaWwNCj4gPj4+PiBLdW1hciBSZWRkeSBIIDxhcmVkZHkzQG1hcnZlbGwuY29t
PjsgVGFubWF5IEphZ2RhbGUNCj4gPj4+PiA8dGFubWF5QG1hcnZlbGwuY29tPjsgbWlrZS5sZWFj
aEBsaW5hcm8ub3JnOyBsZW8ueWFuQGxpbmFyby5vcmcNCj4gPj4+PiBTdWJqZWN0OiBbRVhURVJO
QUxdIFJlOiBbUEFUQ0ggdjcgNS83XSBjb3Jlc2lnaHQ6IHRtYzogQWRkIHN1cHBvcnQNCj4gPj4+
PiBmb3IgcmVhZGluZyBjcmFzaCBkYXRhDQo+ID4+Pj4NCj4gPj4+PiBQcmlvcml0aXplIHNlY3Vy
aXR5IGZvciBleHRlcm5hbCBlbWFpbHM6IENvbmZpcm0gc2VuZGVyIGFuZCBjb250ZW50DQo+ID4+
Pj4gc2FmZXR5IGJlZm9yZSBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzDQo+
ID4+Pj4NCj4gPj4+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4+Pj4gLS0NCj4gPj4+PiAtDQo+ID4+Pj4NCj4g
Pj4+Pg0KPiA+Pj4+IE9uIDA3LzAzLzIwMjQgMDM6MzYsIExpbnUgQ2hlcmlhbiB3cm90ZToNCj4g
Pj4+Pj4gKiBJbnRyb2R1Y2UgYSBuZXcgbW9kZSBDU19NT0RFX1JFQURfQ1JBU0hEQVRBIGZvciBy
ZWFkaW5nDQo+IHRyYWNlDQo+ID4+Pj4+ICAgY2FwdHVyZWQgaW4gcHJldmlvdXMgY3Jhc2gvd2F0
Y2hkb2cgcmVzZXQuDQo+ID4+Pj4+DQo+ID4+Pj4+ICogQWRkIHNwZWNpYWwgZGV2aWNlIGZpbGVz
IGZvciByZWFkaW5nIEVUUi9FVEYgY3Jhc2ggZGF0YS4NCj4gPj4+Pj4NCj4gPj4+Pj4gKiBVc2Vy
IGNhbiByZWFkIHRoZSBjcmFzaCBkYXRhIGFzIGJlbG93DQo+ID4+Pj4+DQo+ID4+Pj4+ICAgRm9y
IGV4YW1wbGUsIGZvciByZWFkaW5nIGNyYXNoIGRhdGEgZnJvbSB0bWNfZXRmIHNpbmsNCj4gPj4+
Pj4NCj4gPj4+Pj4gICAjZGQgaWY9L2Rldi9jcmFzaF90bWNfZXRmWFggb2Y9fi9jc3RyYWNlLmJp
bg0KPiA+Pj4+Pg0KPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBBbmlsIEt1bWFyIFJlZGR5IDxhcmVk
ZHkzQG1hcnZlbGwuY29tPg0KPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBUYW5tYXkgSmFnZGFsZSA8
dGFubWF5QG1hcnZlbGwuY29tPg0KPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBMaW51IENoZXJpYW4g
PGxjaGVyaWFuQG1hcnZlbGwuY29tPg0KPiA+Pj4+PiAtLS0NCj4gPj4+Pj4gQ2hhbmdlbG9nIGZy
b20gdjY6DQo+ID4+Pj4+ICogUmVtb3ZlZCByZWFkX3ByZXZib290IGZsYWcgaW4gc3lzZnMNCj4g
Pj4+Pj4gKiBBZGRlZCBzcGVjaWFsIGRldmljZSBmaWxlcyBmb3IgcmVhZGluZyBjcmFzaGRhdGEN
Cj4gPj4+Pj4gKiBSZW5hbWVkIENTIG1vZGUgUkVBRF9QUkVWQk9PVCB0byBSRUFEX0NSQVNIREFU
QQ0KPiA+Pj4+PiAqIFNldHRpbmcgdGhlIFJFQURfQ1JBU0hEQVRBIG1vZGUgaXMgZG9uZSBhcyBw
YXJ0IG9mIGZpbGUgb3Blbi4NCj4gPj4+Pj4NCj4gPj4+Pg0KPiA+Pj4+IFsuLi5dDQo+ID4+Pj4N
Cj4gPj4+Pj4gQEAgLTYxOSw2ICs3NDAsMTkgQEAgc3RhdGljIGludCB0bWNfcHJvYmUoc3RydWN0
IGFtYmFfZGV2aWNlDQo+ID4+Pj4+ICphZGV2LA0KPiA+Pj4+IGNvbnN0IHN0cnVjdCBhbWJhX2lk
ICppZCkNCj4gPj4+Pj4gIAkJY29yZXNpZ2h0X3VucmVnaXN0ZXIoZHJ2ZGF0YS0+Y3NkZXYpOw0K
PiA+Pj4+PiAgCWVsc2UNCj4gPj4+Pj4gIAkJcG1fcnVudGltZV9wdXQoJmFkZXYtPmRldik7DQo+
ID4+Pj4+ICsNCj4gPj4+Pj4gKwlpZiAoIWlzX3RtY19yZXNlcnZlZF9yZWdpb25fdmFsaWQoZGV2
KSkNCj4gPj4+Pj4gKwkJZ290byBvdXQ7DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKwlkcnZkYXRhLT5j
cmFzaGRldi5uYW1lID0NCj4gPj4+Pj4gKwkJZGV2bV9rYXNwcmludGYoZGV2LCBHRlBfS0VSTkVM
LCAiJXNfJXMiLA0KPiAiY3Jhc2giLA0KPiA+Pj4+IGRlc2MubmFtZSk7DQo+ID4+Pj4+ICsJZHJ2
ZGF0YS0+Y3Jhc2hkZXYubWlub3IgPSBNSVNDX0RZTkFNSUNfTUlOT1I7DQo+ID4+Pj4+ICsJZHJ2
ZGF0YS0+Y3Jhc2hkZXYuZm9wcyA9ICZ0bWNfY3Jhc2hkYXRhX2ZvcHM7DQo+ID4+Pj4+ICsJcmV0
ID0gbWlzY19yZWdpc3RlcigmZHJ2ZGF0YS0+Y3Jhc2hkZXYpOw0KPiA+Pj4+PiArCWlmIChyZXQp
DQo+ID4+Pj4+ICsJCXByX2VycigiJXM6IEZhaWxlZCB0byBzZXR1cCBkZXYgaW50ZXJmYWNlIGZv
cg0KPiBjcmFzaGRhdGFcbiIsDQo+ID4+Pj4+ICsJCSAgICAgICBkZXNjLm5hbWUpOw0KPiA+Pj4+
PiArDQo+ID4+Pj4NCj4gPj4+PiBJcyB0aGlzIGFsbCBvcHRpb25hbCBhZnRlciB0aGUgaXNfdG1j
X3Jlc2VydmVkX3JlZ2lvbl92YWxpZCgpPw0KPiA+Pj4+IFNraXBwaW5nIHRvIG91dCBzZWVtcyB0
byBiZSBtb3JlIGxpa2UgYW4gZXJyb3IgY29uZGl0aW9uLCBidXQgaW4NCj4gPj4+PiB0aGlzIGNh
c2UgaXQncyBub3Q/IEhhdmluZyBpdCBsaWtlIHRoaXMgbWFrZXMgaXQgbW9yZSBkaWZmaWN1bHQg
dG8NCj4gPj4+PiBhZGQgZXh0cmEgc3RlcHMgdG8gdGhlIHByb2JlIGZ1bmN0aW9uLiBZb3UgY291
bGQgbW92ZSBpdCB0byBhDQo+ID4+Pj4gZnVuY3Rpb24gYW5kIGZsaXANCj4gPj4gdGhlIGNvbmRp
dGlvbiB3aGljaCB3b3VsZCBiZSBjbGVhcmVyOg0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gQWNrLg0K
PiA+Pj4NCj4gPj4+PiAgICBpZiAoaXNfdG1jX3Jlc2VydmVkX3JlZ2lvbl92YWxpZChkZXYpKQ0K
PiA+Pj4+ICAgICAgIHJlZ2lzdGVyX2NyYXNoX2Rldl9pbnRlcmZhY2UoZHJ2ZGF0YSk7DQo+ID4+
Pj4NCj4gPg0KPiA+IERpZCB5b3UgbWVhbnQgY2hhbmdpbmcgdGhlIGNvbmRpdGlvbiBvZiAiaXNf
dG1jX3Jlc2VydmVkX3JlZ2lvbl92YWxpZCINCj4gYnkgImZsaXAgdGhlIGNvbmRpdGlvbiIuDQo+
ID4gSWYgeWVzLCB0aGF04oCZcyBub3QgcmVxdWlyZWQgSU1ITywgc2luY2UgdGhlIHJlc2VydmVk
IHJlZ2lvbiBpcyBzdGlsbCB2YWxpZC4NCj4gPg0KPiANCj4gQnkgZmxpcCBJIG1lYW4gcmVtb3Zl
IHRoZSAhLiBZb3UgaGFkIHRoaXM6DQo+IA0KPiAgIAlpZiAoIWlzX3RtY19yZXNlcnZlZF9yZWdp
b25fdmFsaWQoZGV2KSkNCj4gCQlnb3RvIG91dDsNCj4gDQo+IEJ1dCBpbnN0ZWFkIHlvdSBzaG91
bGQgcHV0IHlvdXIgcmVnaXN0cmF0aW9uIGNvZGUgaW4gYSBmdW5jdGlvbiwgcmVtb3ZlIHRoZSAh
DQo+IGFuZCByZXBsYWNlIHRoZSBnb3RvIHdpdGggYSBmdW5jdGlvbjoNCj4gDQo+ICAgICBpZiAo
aXNfdG1jX3Jlc2VydmVkX3JlZ2lvbl92YWxpZChkZXYpKQ0KPiAgICAgICAgIHJldCA9IHJlZ2lz
dGVyX2NyYXNoX2Rldl9pbnRlcmZhY2UoZHJ2ZGF0YSk7DQo+IA0KPiBXaGVyZSByZWdpc3Rlcl9j
cmFzaF9kZXZfaW50ZXJmYWNlKCkgaXMgZXZlcnl0aGluZyB5b3UgYWRkZWQgaW4gYmV0d2Vlbg0K
PiB0aGUgZ290byBhbmQgdGhlIG91dDogbGFiZWwuIFRoZSByZWFzb24gaXMgdGhhdCB5b3UndmUg
bWFkZSBpdCBpbXBvc3NpYmxlIHRvDQo+IGV4dGVuZCB0aGUgcHJvYmUgZnVuY3Rpb24gd2l0aCBu
ZXcgYmVoYXZpb3Igd2l0aG91dCBoYXZpbmcgdG8gdW5kZXJzdGFuZA0KPiB0aGF0IHRoaXMgbmV3
IGJpdCBtdXN0IGFsd2F5cyBjb21lIGxhc3QuIE90aGVyd2lzZSBuZXcgYmVoYXZpb3Igd291bGQg
YWxzbw0KPiBiZSBza2lwcGVkIG92ZXIgaWYgdGhlIHJlc2VydmVkIHJlZ2lvbiBkb2Vzbid0IGV4
aXN0Lg0KPiANCg0KVGhhbmtzLiBUaGF04oCZcyBjbGVhciB0byBtZS4NCg0KPiA+IElJVUMsIHRo
ZSBpZGVhIGhlcmUgaXMgdG8gbm90IHRvIGZhaWwgdGhlIHRtY19wcm9iZSBkdWUgdG8gYW4gZXJy
b3INCj4gPiBjb25kaXRpb24gaW4gcmVnaXN0ZXJfY3Jhc2hfZGV2X2ludGVyZmFjZSwgIHNvIHRo
YXQgdGhlIG5vcm1hbCBjb25kaXRpb24gaXMNCj4gbm90IGFmZmVjdGVkLiBBbHNvIHRoZSBlcnJv
ciBjb25kaXRpb24gY2FuIGJlIG5vdGlmaWVkIHRvIHRoZSB1c2VyIHVzaW5nIGENCj4gcHJfZGJn
IC8gcHJfZXJyLg0KPiA+DQo+ID4gVGhhbmtzLg0KPiA+DQo+IA0KPiBJJ20gbm90IHN1cmUgSSBm
b2xsb3cgZXhhY3RseSB3aGF0IHlvdSBtZWFuIGhlcmUsIGJ1dCBmb3IgdGhlIG9uZSBlcnJvcg0K
PiBjb25kaXRpb24geW91IGFyZSBjaGVja2luZyBmb3Igb24gdGhlIGNhbGwgdG8gbWlzY19yZWdp
c3RlcigpIHlvdSBjYW4gc3RpbGwNCj4gcmV0dXJuIHRoYXQgZnJvbSB0aGUgbmV3IGZ1bmN0aW9u
IGFuZCBjaGVjayBpdCBpbiB0aGUgcHJvYmUuDQoNCkFjdHVhbGx5IHdhcyB0cnlpbmcgdG8gY2xh
cmlmeSB0aGF0IHdlIG1heSBub3Qgd2FudCB0byBmYWlsIHRoZSBwcm9iZSBkdWUgdG8gYSBmYWls
dXJlIGluIHRoZSByZWdpc3Rlcl9jcmFzaF9kZXZfaW50ZXJmYWNlLCBzaW5jZSB0aGUgbm9ybWFs
IHRyYWNlIG9wZXJhdGlvbnMgY291bGQgY29udGludWUgd2l0aG91dCBjcmFzaF9kZXYgaW50ZXJm
YWNlLihUcmFjaW5nIHdpdGggb3Igd2l0aG91dCB0aGUgcmVzZXJ2ZWQgcmVnaW9uIGRvZXNu4oCZ
dCBnZXQgYWZmZWN0ZWQgYXMgd2VsbCkuDQogUGxlYXNlIHNlZSB0aGUgY2hhbmdlcyBiZWxvdy4g
VGhhdCB3YXkgdGhlIGNoYW5nZXMgYXJlIHNpbXBsZXIuIA0KDQoNCkBAIC01MDcsNiArNjI4LDE4
IEBAIHN0YXRpYyB1MzIgdG1jX2V0cl9nZXRfbWF4X2J1cnN0X3NpemUoc3RydWN0IGRldmljZSAq
ZGV2KQ0KICAgICAgICByZXR1cm4gYnVyc3Rfc2l6ZTsNCiB9DQoNCitzdGF0aWMgdm9pZCByZWdp
c3Rlcl9jcmFzaF9kZXZfaW50ZXJmYWNlKHN0cnVjdCB0bWNfZHJ2ZGF0YSAqIGRydmRhdGEsDQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKm5hbWUp
DQorew0KKyAgICAgICBkcnZkYXRhLT5jcmFzaGRldi5uYW1lID0NCisgICAgICAgICAgICAgICBk
ZXZtX2thc3ByaW50ZigmZHJ2ZGF0YS0+Y3NkZXYtPmRldiwgR0ZQX0tFUk5FTCwgIiVzXyVzIiwg
ImNyYXNoIiwgbmFtZSk7DQorICAgICAgIGRydmRhdGEtPmNyYXNoZGV2Lm1pbm9yID0gTUlTQ19E
WU5BTUlDX01JTk9SOw0KKyAgICAgICBkcnZkYXRhLT5jcmFzaGRldi5mb3BzID0gJnRtY19jcmFz
aGRhdGFfZm9wczsNCisgICAgICAgaWYgKG1pc2NfcmVnaXN0ZXIoJmRydmRhdGEtPmNyYXNoZGV2
KSkNCisgICAgICAgICAgICAgICBkZXZfZGJnKCZkcnZkYXRhLT5jc2Rldi0+ZGV2LA0KKyAgICAg
ICAgICAgICAgICAgICAgICAgIkZhaWxlZCB0byBzZXR1cCB1c2VyIGludGVyZmFjZSBmb3IgY3Jh
c2hkYXRhXG4iKTsNCit9DQorDQogc3RhdGljIGludCB0bWNfcHJvYmUoc3RydWN0IGFtYmFfZGV2
aWNlICphZGV2LCBjb25zdCBzdHJ1Y3QgYW1iYV9pZCAqaWQpDQogew0KICAgICAgICBpbnQgcmV0
ID0gMDsNCkBAIC02MTksNiArNzUyLDEwIEBAIHN0YXRpYyBpbnQgdG1jX3Byb2JlKHN0cnVjdCBh
bWJhX2RldmljZSAqYWRldiwgY29uc3Qgc3RydWN0IGFtYmFfaWQgKmlkKQ0KICAgICAgICAgICAg
ICAgIGNvcmVzaWdodF91bnJlZ2lzdGVyKGRydmRhdGEtPmNzZGV2KTsNCiAgICAgICAgZWxzZQ0K
ICAgICAgICAgICAgICAgIHBtX3J1bnRpbWVfcHV0KCZhZGV2LT5kZXYpOw0KKw0KKyAgICAgICBp
ZiAoaXNfdG1jX3Jlc2VydmVkX3JlZ2lvbl92YWxpZChkZXYpKQ0KKyAgICAgICAgICAgICAgIHJl
Z2lzdGVyX2NyYXNoX2Rldl9pbnRlcmZhY2UoZHJ2ZGF0YSwgZGVzYy5uYW1lKTsNCisNCiBvdXQ6
DQogICAgICAgIHJldHVybiByZXQ7DQogfQ0KDQpUaGFua3MuDQpMaW51IENoZXJpYW4uDQo=

