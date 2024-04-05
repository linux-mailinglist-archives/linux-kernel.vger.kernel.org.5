Return-Path: <linux-kernel+bounces-133022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C656899D97
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9B73B21FB3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234D116D313;
	Fri,  5 Apr 2024 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="d1og2vLx";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iy9YBG0v"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4F81DFE4;
	Fri,  5 Apr 2024 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321659; cv=fail; b=TPvAEvroHOvFLMX73RBjmESgxC7S/0bEKvF1B7dP42zHToIh5+Ko0IuxHJdw1nsZGGkGOzJLNLbYiscQFCldHvA1uvYVeQfpd0f6ar2i3RvVfv/pJRw/0XkrtsZ8R+e3PaLWUFOUwnnMlo81M42jrRa7Ju6Htfdr8MqqmQCckXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321659; c=relaxed/simple;
	bh=/FIJvKg3Nhr0/MFCKh8vur+ev2yooMmYFmNu3ymbpDE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AXvgaUbYBfPnll0m6yu5iJe/Z+ZVKuAP6G2OS5nCdh1fkmW0tn+pnCB3jC/kFym2KQIElZgXIo0Fwv7jmuUmbUSo06YH82QWoEFhI1ZWuJoYRGd8ONolhAHevHNgkZTECaDsBS3f0PKCuyZ4FnKpKh40be7DKlJ5BfExXewDpaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=d1og2vLx; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iy9YBG0v; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712321657; x=1743857657;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/FIJvKg3Nhr0/MFCKh8vur+ev2yooMmYFmNu3ymbpDE=;
  b=d1og2vLxTJTdL+M1+vtaQlpQmXLPZ1a7WTKkfuJMgy7Ibog9jYaEcfuv
   oiW0D8e4SVUFZzYTG6DbzfkOogfsYwCd0VQC+3ESF22wQ3xcHLE7wDbuY
   N3e4gLKKPsLpakQ5ozU2cGr61MQPqMWPTdasJepbf3jCB54Q0TmSt75wa
   rjv02c66HmxAxdYC44kp+bNbyXoqnA93UFNA1MzARqtTrSysjw5eFpcUj
   adaVKWy0J42iVAs9asjqzY0p1KGsTLfNN+Mju6dx/gfdKXHmbBomVaRQ9
   SKEn0okOk3yrelHaWxlKxjkdfudPnmwtUAz/t18iVcDGel9Cc3XCOBAr3
   w==;
X-CSE-ConnectionGUID: /aocNBZtTHKH1E4yeMPQ6w==
X-CSE-MsgGUID: e726OJLWRIy1h1mgcqEP6Q==
X-IronPort-AV: E=Sophos;i="6.07,181,1708412400"; 
   d="scan'208";a="186925418"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2024 05:54:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 05:53:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 05:53:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Evu5buvQ/ZV18NT/ZudzHEl2mVUUBF4TBzYdwOLAZrcNsxol2D5wKbCcE+uympkMAZKI+6zWNgBNO83yOILO9purZBLcWS7iTm4Xuag2zrHJiSUc0AFVsJeWxzefKubqpmorSNMgPWkkz0MV2R8bup6W3lkCQvHdF/EO6/fg1hwG2xFT9ppqEamMwFJIJfv5nlSTCvpyUo5FjwS6AwHNA2LKJoXjllpOEim6eF6oZvXGHVXK2CmavJp/XHdHCdPJYC+3FP1ObR0Jz/6+JorQE2E2YZPhsXl4kXSX1tKS5CvDis7Sxgm9U6LRYTYf1bZQVxTYHm3nADfEbBw/YcNULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FIJvKg3Nhr0/MFCKh8vur+ev2yooMmYFmNu3ymbpDE=;
 b=L1yb0Ij7LxZL1VEd3oGzcYNQxSxDdUoCmWFtsRUzqTxcJLsBPhxT9QeW5+Mn2G15COB7I270zfrvLElUK5rKlMEwUoRV1CwRnI5qAdP3zipOoU/EW02ROJk3fBbLCTGIa5WvV/MbeWb/bRCgbrql8qj1gEc22Xr3PBtvpB7Y0z3bnhMeuqLxfyPsFhpxjc6gGqdmM/BFu4yz+K4pMWDQY1Vn4BQY/FXn0VSAB9sBXnrxyoaPBwn5/Cr5tmfBRkiJEKxCjTwvw6CGGPXE3eeWZeK4Qqa3xXeKdif2k2tIEEncfjJef83cbibOAoERmQS2kT+slhjlUEntvWBhK40TVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FIJvKg3Nhr0/MFCKh8vur+ev2yooMmYFmNu3ymbpDE=;
 b=iy9YBG0vArryhW99nI0ddeBk34JmVcn37UOA0wVKCdz/Uq8OL8UaFDjterib352NmZtSGiGVH3ymxl/Hy6ELn8XvACVrSSiV4SxiyATSe4zP1+axFoZF7L4e3ZEuh4/g5qEwUzV7kzsuTnsf+ZrwwVc69uG9wbJnJTpburueBw2JnMucksmUH1nWFM+oP6CPYlbPKjqkCBxWEZqJNXu50XEQE6BWwra5tUNXJJx9UelzHWDfwt1gI2/NCtb0pzABqGqq01p+KeIgUJfsDgVgUSk6SzEpVmX1B4/2grv5mmV+PUrBoJiiE/a9DjZpQoUveuAQWYh9uJcQGPfdhzpLpA==
Received: from SN6PR11MB3167.namprd11.prod.outlook.com (2603:10b6:805:c6::10)
 by MW4PR11MB6933.namprd11.prod.outlook.com (2603:10b6:303:22a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Fri, 5 Apr
 2024 12:53:38 +0000
Received: from SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::b059:198c:9128:7b43]) by SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::b059:198c:9128:7b43%3]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 12:53:38 +0000
From: <Marius.Cristea@microchip.com>
To: <jic23@kernel.org>, <Conor.Dooley@microchip.com>
CC: <linux@roeck-us.net>, <jdelvare@suse.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <lars@metafoo.de>,
	<linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
	<conor+dt@kernel.org>
Subject: Re: [PATCH v5 2/2] iio: adc: adding support for PAC193x
Thread-Topic: [PATCH v5 2/2] iio: adc: adding support for PAC193x
Thread-Index: AQHaZa41DnEBQNNY0k6p6RiYUs7Fp7EZ4G+AgEABbwCAAANSgA==
Date: Fri, 5 Apr 2024 12:53:38 +0000
Message-ID: <e432bddc16952d9144ccf6da5a54b88e3171b947.camel@microchip.com>
References: <20240222164206.65700-1-marius.cristea@microchip.com>
	 <20240222164206.65700-3-marius.cristea@microchip.com>
	 <20240224191559.40d233db@jic23-huawei>
	 <20240405-embellish-bonnet-ab5f10560d93@wendy>
In-Reply-To: <20240405-embellish-bonnet-ab5f10560d93@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB3167:EE_|MW4PR11MB6933:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D77TJ1DYIGrGv6DGPpIls3UTo8jC7rycuOI/iXTQ5J3mE1d6AVO9IQVH7PRk5Vw6+lOdC/JBbTmAhUtINu5QZJ0XLVpbHmYKwIvJyrkr16EHT1FrJx3DH8S+iLo5GrSiZIpDcTHocwIlwX74SNd/bCSGu7WPMY5K0TAB4zwCGAw6CeiPZEfIWaaylJU3VRkea9TMydTGuD49iFRMK1xaXxCbciH7zpaZAPy9qwWLHJDlKwzCqVj9Kmb6CQb2FQVR4vrwQG0GOeC2XCYq7YMcGvl4KRQGt14eRs8lZGHQsFhdpr/ly0lkPf8zWaNlTd02XdVvcNNbs+SF3VjVve+dk8gGkW5IBZvgMtv2/d9BwwU5oFjr11Xx5hwPXCwTDafAzbhNPX8DQjJ2W5ps7TNwS5WkwbgApC83nqzGZV3gb1zPM6l/NQX1iP0Haxjm2WEDObJq4CeonmK4xU2E1jwbt5kOnFMoDwb7eJVKokC0q7QauBX6R+NUBa677Q49s9AsWRCH6bhuI0rvPZP2qg1Q+3bY5TqAayozFZP0phZcy0nVXJ/b8iBYTTxbOjv9jIjuBNOM62q2aU5HerB5sUQWzofpqt/snwHfiF2cXq+xkDF7B9FLcH3LufPj1QuBXqKIhIjVVPh4Sv2RCMVt9UwMkUisjfF6LpPX4qvsn/Hs65Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3167.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0VrSDhwTkZ4VElGc2FaZnlIelJDSDNvdlltcUEvNjRtdlcyZVdxRzE2RW94?=
 =?utf-8?B?TDBCU3hlWURlOVpPN3JCU0IrL25rQ05XYzZ6ZzBVM24ya3NNNnF6cVcyZGlB?=
 =?utf-8?B?MHU2eWZQWWN2UnVpdVkyaFpMT1Vpajk2dytBOHh6MjVGdVhJUWVuWFNyMnk3?=
 =?utf-8?B?QWVKQ2cydFY3S1k2ZHRSMklGMkhrM2tEM3FHK2kzYWcyN3lFcGxUTXc5RU81?=
 =?utf-8?B?TWZ2cnZUdTVoWFVJSkUxeVlSZnhBSzdsSzQ4U0l6OUNvY0xDaWlLMWIrUXFJ?=
 =?utf-8?B?U2VGcHNERmY2OUpIWFlhOTdPc0lKVUluUm9LWGY2WmZ0ZDdlZUd6YkJBM2Fu?=
 =?utf-8?B?ejhZL0VjaFhOV2tLQTdKN3dZenlPQWZsZkZDdHNyOHQ5WnBIUTg3ak4vTHcz?=
 =?utf-8?B?UFVJdEwvNEtXYlFlV1ZuRWZRKzhnYmVQeHBlaS9nTDlyenlsUEhJT1VnWFls?=
 =?utf-8?B?K2tUWGFxWldlUlhoeldabDk4MGdRM1VsL1BwcFVCWjRMQk9MWWozd3NxaVh0?=
 =?utf-8?B?NjBqdEttb3BTWStvZlZmYVQ0VzFSLzQzSVNHcVFDOVRNanhkZ0ozQXBnWGZw?=
 =?utf-8?B?bjVVZG9OYWlUZW96WkV5aFBiU2pSeU0vQ29waHdRbEdybytaSTE0MjNJNXlI?=
 =?utf-8?B?emlTQVE2cDRBTW1mSXpwa3d6OEpUSWQwdU1ja3UvYmFDbmN6ZVJmYkhOTHNT?=
 =?utf-8?B?eWhTeWlDdGJLaFlpcFZPMHRSc3VmUUFMK1VxRjdjbnNPVWVJRFB4b01GRlpT?=
 =?utf-8?B?cnQ0TXJTVXpQYnBLMjUvTnBLR3JHWGswS3pTWFNUS29mMTA2YVNkRHRLakJs?=
 =?utf-8?B?RnpyZUZieDFvVFZ4eE1ZMjV5TmVycEc3a01FMDkxZG8yRnhxWk5BMVFJWDhD?=
 =?utf-8?B?aEZaellNcDJYeFh5Q2VGNGQ5YkpLajFvY2s2SlBYS1dIMDBWa2kzOXVaTXRC?=
 =?utf-8?B?UFJ2dVRrRExMcjlONnRRUC8rZkZxVHh3SlFWWXZEaWxRNXJJNmlGdjdhaHBU?=
 =?utf-8?B?UVd4d1NwcHB0eUZTeWpzeCtOZFNPWERMZTByL2lZaUMwRjUzNkZBSXpWWmpP?=
 =?utf-8?B?dTJSczNCU0k1T2VTV04yWm4rTWkveHcrUkRGSklNalBzeGJOb3NiWnVHUUsy?=
 =?utf-8?B?ZS9PVzV2NXcwOXpiMTNQcnZyN1BETU94TEtPcGxFZ1JRZDNUemhQdmJVKzVj?=
 =?utf-8?B?Z2tOTThGMFhmNXoyK3RNQ1paUWQyMzJsV0d5UjlNMXVreVVtZ3d2Z0NWM1Fz?=
 =?utf-8?B?SmJiUGRHN3BzaVo3VUxxRGQwak9GU2RZQnd0TndwdjZkK0V0L0lmbzBsaVFX?=
 =?utf-8?B?N2RwUHFJY0YxWlhwdUZtRXd0d3ZMdkd0bTZCeGZ3WFlJSXVwUFZSek9KN2pT?=
 =?utf-8?B?NnRydjlqenJXS3ZmQXVZNDR4c0tvQU53d2dTU0lmWWl1QkY4bXdWKytzaEs4?=
 =?utf-8?B?T1lmcXZGSXR5bDJNcE9YMHNKV05QL05kbTdvNkg1VktFV1VRVTBWS3o0Q3NK?=
 =?utf-8?B?NWIxL1dvTVEyQjFkQisrMDE1U2owNk0yV1BPdE1zM1h5Zmo3aWZXS1I1YU01?=
 =?utf-8?B?NFdLRUlHWE1NVDdDSHVXWDFlcGs1TlNYWnF3elFaUFdQRG03S3RJWE1lYzRr?=
 =?utf-8?B?R2V4ellZM3hMdUxOQXRVVTdqUmhjQmxEajVUMWFQYmQ0V1ZNaTNaQ1JsUXV0?=
 =?utf-8?B?U29MWXUrZkFMaEs4aDhPWVZOMEZUYzNYWUp2K0d3NTY3dGFybDVWekFGYVZY?=
 =?utf-8?B?MUJOcjl1OXdYK1JsOEdzbTFLMWdkSXh3VUNIWU1PTGszRmhkR3JnMk1XOUtQ?=
 =?utf-8?B?Njd3ZEFFY3hCVzRpZGdsRzR1SW9OVlZZeVJ5UzFwYkQrV0xNbnFBTkxTVzY3?=
 =?utf-8?B?eU1IWTlpcUdVdG5seUoxQnpKNDJpVTB5Wll4L2xTeG9yNUJOV1F6N3ZKM21i?=
 =?utf-8?B?SUVZMGltMU0vdG1kK2pYckd6TzVWNDFkN0JEYUJTWjhlVmQvaktFUCtVZ0dv?=
 =?utf-8?B?cTREQ0szSm55NlRmODNIcE9qdXFlVUQvSjNOaG00RURzWlJud0NrMElzcjdk?=
 =?utf-8?B?Q0VkZFFVUUVhSkpNdDFMdE5qTTNxTHJiRyt4VkVPOWczdFpZRUIyZ3loaUhV?=
 =?utf-8?B?MFBPTVBDVS82UkU0ZWFDVy84RDN1dERneDF2bmw4eS9JQ0ZEQ2VWaWNGcjJX?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E19D4DE676DBEA4CBA88323BBB29BB67@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3167.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d925e5a-124e-4bc9-0897-08dc556f69ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 12:53:38.2843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdX1g17jwHwuEGoNzZ+aqzy8F0/GWzhD8kik0tnKQAi05sMRw+qZcQWatcTvKj9kwGZc5+DvaZr9H4/xyQzHwfL5NOrYWniol92iSPN/Sso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6933

SGkgQ29ub3IsCgogICAgVGhhbmtzIGZvciByZXBvcnRpbmcgdGhlIGJ1Zy4gSSBoYXZlIGRldGVj
dCBpdCBhbmQgSSdtIGFscmVhZHkKd29ya2luZyBvbiBhIHBhdGNoIGZvciBpdC4KClRoYW5rcywK
TWFyaXVzCgpPbiBGcmksIDIwMjQtMDQtMDUgYXQgMTM6NDEgKzAxMDAsIENvbm9yIERvb2xleSB3
cm90ZToKPiBPbiBTYXQsIEZlYiAyNCwgMjAyNCBhdCAwNzoxNTo1OVBNICswMDAwLCBKb25hdGhh
biBDYW1lcm9uIHdyb3RlOgo+ID4gT24gVGh1LCAyMiBGZWIgMjAyNCAxODo0MjowNiArMDIwMAo+
ID4gPG1hcml1cy5jcmlzdGVhQG1pY3JvY2hpcC5jb20+IHdyb3RlOgo+ID4gCj4gPiA+IEZyb206
IE1hcml1cyBDcmlzdGVhIDxtYXJpdXMuY3Jpc3RlYUBtaWNyb2NoaXAuY29tPgo+ID4gPiAKPiA+
ID4gVGhpcyBpcyB0aGUgaWlvIGRyaXZlciBmb3IgTWljcm9jaGlwCj4gPiA+IFBBQzE5M1ggc2Vy
aWVzIG9mIFBvd2VyIE1vbml0b3Igd2l0aCBBY2N1bXVsYXRvciBjaGlwIGZhbWlseS4KPiA+ID4g
Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1hcml1cyBDcmlzdGVhIDxtYXJpdXMuY3Jpc3RlYUBtaWNy
b2NoaXAuY29tPgo+ID4gU28gSSBoYWQgYSBmZXcgY29tbWVudHMgb24gdGhpcywgYnV0IG5vdGhp
bmcgdGhhdCBjYW4ndCBiZSBjbGVhbmVkCj4gPiB1cCBsYXRlci4KPiA+ICsgSSdsbCBmaXggdGhl
IHRoaW5nIHRoZSBib3RzIGRpZG4ndCBsaWtlIG9uIHRoZSBiaW5kaW5ncy4KPiA+IAo+ID4gU2Vy
aWVzIGFwcGxpZWQgdG8gdGhlIHRvZ3JlZyBicmFuY2ggb2YgaWlvLmdpdCBhbmQgcHVzaGVkIG91
dAo+ID4gYXMgdGVzdGluZyBmb3IgMC1kYXkgdG8gdGFrZSBhIGxvb2sgYXQgaXQuCj4gCj4gSSB0
ZXN0ZWQgdGhpcyBvdXQgb24gdjYuOS1yYzIgYW5kIHByb21wdGVkIGEgYmFja3RyYWNlIHdoZW4g
Y29sbGVjdGQKPiBzdGFydGVkIHJ1bm5pbmc6Cj4gwqDCoMKgwqDCoMKgwqDCoC0tLS0tLS0tLS0t
LVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQo+IMKgwqDCoMKgwqDCoMKgwqBVQlNBTjogYXJyYXkt
aW5kZXgtb3V0LW9mLWJvdW5kcyBpbgo+IC9ob21lL2Nvbm9yL3N0dWZmL2xpbnV4L2RyaXZlcnMv
aWlvL2FkYy9wYWMxOTM0LmM6ODU3OjI1Cj4gwqDCoMKgwqDCoMKgwqDCoGluZGV4IDcgaXMgb3V0
IG9mIHJhbmdlIGZvciB0eXBlICd1MzIgWzRdJwo+IMKgwqDCoMKgwqDCoMKgwqBDUFU6IDEgUElE
OiAxNzkgQ29tbTogaWlvZCBOb3QgdGFpbnRlZCA2LjkuMC1yYzItZGlydHkgIzEKPiDCoMKgwqDC
oMKgwqDCoMKgSGFyZHdhcmUgbmFtZTogTWljcm9jaGlwIFBvbGFyRmlyZS1Tb0MgSWNpY2xlIEtp
dCAoRFQpCj4gwqDCoMKgwqDCoMKgwqDCoENhbGwgVHJhY2U6Cj4gwqDCoMKgwqDCoMKgwqDCoFs8
ZmZmZmZmZmY4MDAwNmJiYT5dIGR1bXBfYmFja3RyYWNlKzB4MjgvMHgzMAo+IMKgwqDCoMKgwqDC
oMKgwqBbPGZmZmZmZmZmODBiZDY3ZDg+XSBzaG93X3N0YWNrKzB4MzgvMHg0NAo+IMKgwqDCoMKg
wqDCoMKgwqBbPGZmZmZmZmZmODBiZTc4MjA+XSBkdW1wX3N0YWNrX2x2bCsweDZlLzB4OWEKPiDC
oMKgwqDCoMKgwqDCoMKgWzxmZmZmZmZmZjgwYmU3ODY0Pl0gZHVtcF9zdGFjaysweDE4LzB4MjAK
PiDCoMKgwqDCoMKgwqDCoMKgWzxmZmZmZmZmZjgwYmUxNDUyPl0gdWJzYW5fZXBpbG9ndWUrMHgx
MC8weDQ2Cj4gwqDCoMKgwqDCoMKgwqDCoFs8ZmZmZmZmZmY4MDYxNTM1OD5dIF9fdWJzYW5faGFu
ZGxlX291dF9vZl9ib3VuZHMrMHg2YS8weDc4Cj4gwqDCoMKgwqDCoMKgwqDCoFs8ZmZmZmZmZmY4
MDk4MWYzYT5dIHBhYzE5MzRfcmVhZF9yYXcrMHgyMGMvMHgzNGMKPiDCoMKgwqDCoMKgwqDCoMKg
WzxmZmZmZmZmZjgwOTc3YzRjPl0gaWlvX3JlYWRfY2hhbm5lbF9pbmZvKzB4NWMvMHhiZQo+IMKg
wqDCoMKgwqDCoMKgwqBbPGZmZmZmZmZmODA3MzUxNmU+XSBkZXZfYXR0cl9zaG93KzB4MWMvMHg0
YQo+IMKgwqDCoMKgwqDCoMKgwqBbPGZmZmZmZmZmODAzODcyOTI+XSBzeXNmc19rZl9zZXFfc2hv
dysweDgwLzB4Y2MKPiDCoMKgwqDCoMKgwqDCoMKgWzxmZmZmZmZmZjgwMzg1YjEyPl0ga2VybmZz
X3NlcV9zaG93KzB4M2MvMHg0YQo+IMKgwqDCoMKgwqDCoMKgwqBbPGZmZmZmZmZmODAzMWUzZDg+
XSBzZXFfcmVhZF9pdGVyKzB4MTM2LzB4MmU0Cj4gwqDCoMKgwqDCoMKgwqDCoFs8ZmZmZmZmZmY4
MDM4NWNkZT5dIGtlcm5mc19mb3BfcmVhZF9pdGVyKzB4MzgvMHgxNmEKPiDCoMKgwqDCoMKgwqDC
oMKgWzxmZmZmZmZmZjgwMmU5MDRhPl0gdmZzX3JlYWQrMHgxYmUvMHgyYmEKPiDCoMKgwqDCoMKg
wqDCoMKgWzxmZmZmZmZmZjgwMmU5YzQ4Pl0ga3N5c19yZWFkKzB4NjQvMHhkMgo+IMKgwqDCoMKg
wqDCoMKgwqBbPGZmZmZmZmZmODAyZTljZDY+XSBfX3Jpc2N2X3N5c19yZWFkKzB4MjAvMHgyOAo+
IMKgwqDCoMKgwqDCoMKgwqBbPGZmZmZmZmZmODBiZTgzOGE+XSBkb190cmFwX2VjYWxsX3UrMHhl
ZS8weDIwNAo+IMKgwqDCoMKgwqDCoMKgwqBbPGZmZmZmZmZmODBiZjU3ZDA+XSByZXRfZnJvbV9l
eGNlcHRpb24rMHgwLzB4NjQKPiDCoMKgwqDCoMKgwqDCoMKgLS0tWyBlbmQgdHJhY2UgXS0tLQo+
IAo+IFRoZSBkZXZpY2UgaXRzZWxmIG9ubHkgaGFzIDQgY2hhbm5lbHMsIGJ1dCBpbiBzeXNmcyB0
aGVyZSBhcmUgImZha2UiCj4gY2hhbm5lbHMgZm9yIHRoZSBhdmVyYWdlIHZvbHRhZ2VzIGFuZCBj
dXJyZW50cyB0b28uIFVCU0FOIHBvaW50cyBhdDoKPiDCoMKgwqDCoMKgwqDCoMKgY2FzZSBQQUMx
OTM0X1ZTRU5TRV9BVkdfNF9BRERSOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
KnZhbCA9IFBBQzE5MzRfTUFYX1ZTRU5TRV9SU0hJRlRFRF9CWV8xNkI7Cj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoY2hhbi0+c2Nhbl90eXBlLnNpZ24gPT0gJ3UnKQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCp2YWwyID0gaW5m
by0+c2h1bnRzW2NoYW5uZWxdOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZWxz
ZQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCp2YWwy
ID0gaW5mby0+c2h1bnRzW2NoYW5uZWxdID4+IDE7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gSUlPX1ZBTF9GUkFDVElPTkFMOwo+IAo+IEFuZCBpbmZvLT5zaHVudHMg
aXMgb25seSB2YWxpZCBmb3IgdGhlIDQgcmVhbCBjaGFubmVscywgc28gSSBndWVzcwo+IHRoZQo+
IGF2ZXJhZ2VkIGNoYW5uZWxzIHByb2JhYmx5IG5lZWQgdG8gZG8gYSBbY2hhbm5lbCAtIDRdIG9y
IHNpbWlsYXIuIEkKPiBkdW5ubyBpZiB0aGF0IHJlbGF0aW9uIGJldHdlZW4gYXZlcmFnZWQgY2hh
bm5lbHMgYW5kIHRoZWlyICJyZWFsIgo+IGNvdW50ZXJwYXJ0cyBpcyBmaXhlZCBvciBpZiBkaWZm
ZXJlbnQgcGFjIGRldmljZXMgbmVlZCBkaWZmZXJlbnQKPiB2YWx1ZXMsCj4gYnV0IG9uIG15IHN5
c3RlbSBoZXJlIHRoYXQgd291bGQgd29yay4KPiAKPiBJIGRvIHF1aXRlIGxpa2UgdGhhdCBVQlNB
TiBwb2ludHMgb3V0IHRoZSBsaW5lIGluIHF1ZXN0aW9uIDopCj4gCj4gQ2hlZXJzLAo+IENvbm9y
LgoK

