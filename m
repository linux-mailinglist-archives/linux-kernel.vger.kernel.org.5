Return-Path: <linux-kernel+bounces-6628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CCB819B31
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8B01C20FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D689E1D6AB;
	Wed, 20 Dec 2023 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="lGrJbhjp";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="KvOzaGZG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C670F1EB46;
	Wed, 20 Dec 2023 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK3avAW028279;
	Wed, 20 Dec 2023 01:00:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	proofpoint; bh=chY02OwlluLmxvRFtQG1qru3H2Kdxgcs1/tWZCWkr/Y=; b=l
	GrJbhjpUMK0Y9yHaQ8iDp9GN0GMTDU5V3hn8E/TBQoTkO8DQ22wkmX8V2NGKod4X
	BhR8BFEo/Rwdl5SGlcVlp91jRnwHiv87iXC/Z1znSGIG3b50b+8xHSAbHnONqqqJ
	12+AzUbHCWxQbH/we/sYvkDPPADBCPKVTirDdl2cO5VFl6egbszNKTesGejjqO9m
	fYIvsvLXT8nALz8smmVQr7YiMqrzM9qMM1zt2qjfBn9zFJ5tTyUABI80aO9Q5fma
	WKmyIzfO+CGFpF/0ODH4ahtOHeEB9gQl9wia6HOTkdM6LTKQAUS3qsJK91TsFUG9
	8aGrHX8Y3zouGK0jof89w==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3v18by5qb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 01:00:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6iPNHdWNlbPbPUDRr3sblRlglEYRrD7j8I0b/KSOLy2xufAr91NeV4goRk8i3Yz+cmxBN3eSTKT6CiCfXQArxR1/2mgs8Lly55EzhilglcQ3Umylh82dF6zwQ8/7ar65xNvJGkum7xOegv6pVWx72laBgUgNbjqEvwsxalqaWTY7hiaDMfX1ZV4EH/kRwiTm9adYexNcIzDDOPJjw61seQVrQevoHZBtraqszSQrUvdxu8rRM1bszK4HEmkk688hqS9OoALqDCcZsVIVhbYnI5qy5B9Ez/YHTKCAmfuSS6PNn+VPdwwDPXI3k35jgdMQTBzbn4CsNe/Dp6ziQcq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chY02OwlluLmxvRFtQG1qru3H2Kdxgcs1/tWZCWkr/Y=;
 b=AYb9BWHoi62UR4xp8Gsd+6A1DUcHMTt6a6hAoo0UfkU9j4hNeqFbpU+wqf/YkQAnX+f3v+3U38Wix5PaA4nYH9HxRTYiZbTboQzGYNTxkH34n4dR2VWKRosc8qpaDXd8ORqYV01zGI05CHMIzDRW/uugi96k7d9wfuAQmYh8QjKj0D7sl9o6d5Pb0pu7KkrEsAQihIuO8XEITfzDa06YeFWicHgCJUYCpKNysF9nltSTgWRZdR+QClrQn/3O72AtjeAeREdF+su2MiRVkwsMzh62jhBmyo5zFJQPRY++KZvlJ7donqRIk/lS54o6VYO+fJUL3fzdgafyYpnI4XTDzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chY02OwlluLmxvRFtQG1qru3H2Kdxgcs1/tWZCWkr/Y=;
 b=KvOzaGZG5CpE2b44i8h2ZxwdMhvnDrd8MMo83cAHfpYNpR3f7FrkqX1AY7XTTR7Wi5Ez8wKVCU+cUx2ksdv3VhF56hloH7DzsWCBVCFBx9xKdA1dQInM7fOhJiECpP7thssguJQq94YI4FeKPqDrLDKNPXc7hvf2V0ADp/ZsvU4=
Received: from DM6PR07MB6154.namprd07.prod.outlook.com (2603:10b6:5:17e::20)
 by SA1PR07MB8739.namprd07.prod.outlook.com (2603:10b6:806:19a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Wed, 20 Dec
 2023 09:00:21 +0000
Received: from DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::18e0:2af0:e596:d9ed]) by DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::18e0:2af0:e596:d9ed%4]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 09:00:21 +0000
From: Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To: Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "robh+dt@kernel.org"
	<robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
CC: Milind Parab <mparab@cadence.com>,
        "s-vadapalli@ti.com"
	<s-vadapalli@ti.com>
Subject: RE: [PATCH v2 1/5] dt-bindings: phy: cadence-torrent: Add optional
 input reference clock for PLL1
Thread-Topic: [PATCH v2 1/5] dt-bindings: phy: cadence-torrent: Add optional
 input reference clock for PLL1
Thread-Index: AQHaLPErVNHufsY/DkSKW4VikCPlO7CmxveAgAGOr6CAAAz6AIAHMGeAgAJRkrA=
Date: Wed, 20 Dec 2023 09:00:21 +0000
Message-ID: 
 <DM6PR07MB6154B687D5F3196D9FE3D2EFC596A@DM6PR07MB6154.namprd07.prod.outlook.com>
References: <20231212114840.1468903-1-sjakhade@cadence.com>
 <20231212114840.1468903-2-sjakhade@cadence.com>
 <e09e4df8-ec36-4953-9bb0-75a3ce0b535d@linaro.org>
 <DM6PR07MB61548DC520B4BA66D6FC625AC58CA@DM6PR07MB6154.namprd07.prod.outlook.com>
 <38d171ee-b94b-4d1c-8702-60735a005596@linaro.org>
 <9a86efae-2855-484e-be01-cf5fffdf9f95@kernel.org>
In-Reply-To: <9a86efae-2855-484e-be01-cf5fffdf9f95@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1mNjllNTliNy05ZjE0LTExZWUtYmMwNy1jYzk2ZTViNzM1MWFcYW1lLXRlc3RcZjY5ZTU5YjgtOWYxNC0xMWVlLWJjMDctY2M5NmU1YjczNTFhYm9keS50eHQiIHN6PSI5ODE4IiB0PSIxMzM0NzUzNTg4OTE2MzY1ODMiIGg9IjIwaVM1bWFwWXBQdmdtdGdoMUxiMGE4NHlTMD0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR07MB6154:EE_|SA1PR07MB8739:EE_
x-ms-office365-filtering-correlation-id: 85165412-c812-478c-6c73-08dc013a18bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 o5FGZLyYDXzCXmxtrckn5EcXID0qIiQUtf/i/sWur1UTGIYSkESM267KEMeq3Gltu76vW/aOTsToGEzG0T9uKM9qf/7X6Vc/YSkA1beUEZGzr7e00+H8tvn3jblokPKiIaBfU7tUaNJJ9CyQz39OsCwqQ0iCV1E2VOYHZeAHKjamuiuCGZaoK8c9B6m146xol2TuhzFRyvf+81a3Vi/Ux143j/XYQpvT9vgiR88Z4w09ucZ1AL3pKHro95xW5GpZk8bdGIiKELSPPehuzERlr6Rl/z76WzE7ew2R9++H96nKZv7Uf97SMB7Y1mDr2Mecjf3t5cSHtsZV8g3B2ITDU36JKWwhvowlP6AvIZhGBxw+2xD2apNzn1GJFOE/ZrtJ7/3mwIxkovs5dfnD9REMSxOMFQekRfLayTfulXmSdk0aBzKdDFkzv0NMAlqykgc6Lk+gp1IiEdQk+s01t/iyXEn9nv4dJceM38Y2Ww2bELLyY084DXcmS3IHWZeAnpeXCvjZfHt5FQ13jLYCGDkIWfuWCqy27mB0HTn5+bBDW7zJnCmgPEY5YMdoPMJ62ema3r+/9D2veZhlYNWv3UvgNHqrD/wtLvYOvgLlpX2sxHzkTfEXD5fV7SpWdC9HstFuquyQzQ2J0fdAyXntYgNVaKG/Apy/iaSaL/uycRj3XcJSADvd/R0sp0rVwKV9rU/G
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6154.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(230922051799003)(230173577357003)(230273577357003)(186009)(451199024)(64100799003)(1800799012)(66476007)(41300700001)(86362001)(64756008)(83380400001)(122000001)(66446008)(5660300002)(66556008)(38100700002)(53546011)(8676002)(2906002)(4326008)(7696005)(52536014)(110136005)(9686003)(71200400001)(478600001)(26005)(6506007)(7416002)(54906003)(66946007)(76116006)(316002)(8936002)(38070700009)(921008)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?R2ZGTDNMQlF4cTZSdlpHVjlBWDNhR2VtVWJEc1NxOXB4eGhXY2psUEJJSW1V?=
 =?utf-8?B?Z3dQTG5HRzZyYTduRkNMR0QrM0hZM1JySy9LUWc1clRtcXZxemw3MVpoWE1q?=
 =?utf-8?B?KzNNQ3hsbTFqSkRyZFpQYWdrVXdQbEJLOGYvempzaU54Mlpad2JXTnFteUk0?=
 =?utf-8?B?VUM2b0t3M0JUSUxYUy9GOEZEVE5ENGt0dWduOFBndTlsSUlkMHpqWHpUbU5N?=
 =?utf-8?B?cXdBWWVCZTA3TnZVaGlQZ05xd3RkWDJaR0FOeVNVMm5BQ0tVaFZOV3dUOVFD?=
 =?utf-8?B?STA1QXByMVNMUnZDUTArTDU0MEtqZTlXTTl3NHQ2bjUxc1hvcDQ5cXNGTXhJ?=
 =?utf-8?B?YXBzeG8yU2JSSzFtTkFYRmhLbXlCVGhWRHJpRnpUSHNieXJCMGhKaTNPaHN0?=
 =?utf-8?B?M1NUVGFRRU1aYXJNcXY4YUxMN1JWV0luQmFpUEpMLzMrcW5uYXdZWjd6aHMv?=
 =?utf-8?B?N1RnSEMrTnpXQ0xXN3NOV2VlSVBmbEc2dVBHQkxVQlZyWFkwSCtjWCtVMEFC?=
 =?utf-8?B?bG9nS2tmbmNBNGlYZzRRa3ZkVnUwRUtUSzF3VDVSbFh0M0p1Z1dzUlRoYi81?=
 =?utf-8?B?QmZ1V1ZDOW5JcmFBTVhHWElaQ256TUx6YTFjck03NjVrUitzKzVqREFXU2Fn?=
 =?utf-8?B?VjJWaHRjNE1rR3RoZTR3MG5LUFVPRzJtY0Rnc3l4N2VuTkF4SytrMHhjUDJK?=
 =?utf-8?B?NVlUaFRGYVNNSmcva1VwWmhKVm53dmVlMzhtNGJQdG5wbjB5TktWeTlodXVs?=
 =?utf-8?B?MWNlNXp3TWxIWUdNR3N6b3FhcFcrWjQvZjhNay85bFN4WC8xNUZWcHdqWi9x?=
 =?utf-8?B?eHNacE1xZ3FsZTJ2VkZURTFKNE5JVkpqZFhackVzb1QvUDJNdDY0Y1BsbThC?=
 =?utf-8?B?RytSTk00TTJPRW1rMy9qSzIyYThOeEZMQ2FEdWFSV2dVcFlPTm9OaXVtWjlQ?=
 =?utf-8?B?WCtFcFVFY3c2RHdWOTFvRHR2RE9QRU5TaGo2TW9vOFE1dlh4THo0c085RW5x?=
 =?utf-8?B?TDdNRExpRjZCWDJpZWI4RHVRN0dCSTRHNDJOTE5neGZZUm9qVHVNQ1Y5RDhh?=
 =?utf-8?B?R2ZUTzdlb0FyYXhscTlpRkE5RTFLZVNrcE0wS2t0ZDRUMEFmSVBWOWV3QWJE?=
 =?utf-8?B?Zkd3cHlSckVQQys0UG94eTJXdDJxRVVmUDNXNmM5czdSRlZPMzNGWWZzU1pu?=
 =?utf-8?B?cVdTY2V3RnBMSStTQ0xRN1hvdDV0bUFYVGdsaVJtNnpmNE9CYktSTSsxcW5G?=
 =?utf-8?B?dHJyaUFYUkVDaHkzNzhZUzc5MmhZaWhHaVhDM0RHcEdYTDNLZnlaUXJiQjlN?=
 =?utf-8?B?OE5XTDN0MXd4MngyN21uNGRpMW5xMHY2NEUrOExsRkdsa0JtQ1dwRUZSd0Zs?=
 =?utf-8?B?eVp5aktuc3RTdjFSajBLdW40ZFpjT1JISVptNjdlSURTUjNYR282R043cGNs?=
 =?utf-8?B?MWw3NjcyUURCYnMxaFVMOGEwUmlGbG1naXpMczh6VmluZDdkdlREVlNzYUgy?=
 =?utf-8?B?NlBYRjI1QS9hVUZlcHB4TmdEUzJzblBOdGxCakx0ZkFBQmsyNnBqMm5TWTZl?=
 =?utf-8?B?dXgzMjJkenhQZlZtWjBlRFpiN1BvYW1MZVk3RktSM2VEckJvTjJDRzMvVnhr?=
 =?utf-8?B?ZEdPZi9EazJ4Z00yTk1vbFFIakhYRisycVBiV3RRZ1NpTUNTZ3I0MU9KWXly?=
 =?utf-8?B?RUc0NzZSSlp5WVJaaTlJV2dKK1BuNUdEUTF0TGdRU2ZBWWpLR0FvRmhPMjBx?=
 =?utf-8?B?dVg5b0tKYVo5bDhHYldld2NlT2dQbUVZaXI1VDFxNGE2RzBmS21hdjFxZzBa?=
 =?utf-8?B?VEQ3QW5jVDZBZE5lbm9RbW0vYXNWcU9JWERpUUxoY0Z2WmVlNkpxVWV6Qnlp?=
 =?utf-8?B?b2VWajYvb1JLb3Q0b3NYdWcwQWpjUXBRL21pQk01cDJ1OFlhcU9ueW5IaFhu?=
 =?utf-8?B?UGliNXU4RGFFWG9XR3RTeEMyS1lvNy9mTHpYdFovTnNMd014UzY5ODU1bndx?=
 =?utf-8?B?MVoweS9nMG5lL1JISUR1Sm9sMWRibTdZRHVtMTFKd2wrcld1UzNCWWpsQk1p?=
 =?utf-8?B?b0JlbXNRZXZpVmlGeHRVUklrVm1LSmxTdzAzTTEwSjV4NjU0RzVFSUkwWnlR?=
 =?utf-8?B?VS95aDdHS3htUGNhY2ZUVlJOa3JtRFZaTkZCZnBMbUhMQjd2TmNmL1prc1lU?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6154.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85165412-c812-478c-6c73-08dc013a18bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 09:00:21.4245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wqv5MobDxmOzq5PWz9e91NSXCQ1zUCoGkCJGW12+ApM34/N0Rg8KHcXUElAMiWhoHsyurv+JRIu7u51H9iGggHB3vKBTJ/FxM+AP+8EIVoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR07MB8739
X-Proofpoint-ORIG-GUID: sUycUfSlM5GqdURSaGxLC8qf5lwxJM07
X-Proofpoint-GUID: sUycUfSlM5GqdURSaGxLC8qf5lwxJM07
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312200061

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9nZXIgUXVhZHJvcyA8
cm9nZXJxQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDE5LCAyMDIzIDI6
MzkgQU0NCj4gVG86IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGlu
YXJvLm9yZz47IFN3YXBuaWwgS2FzaGluYXRoDQo+IEpha2hhZGUgPHNqYWtoYWRlQGNhZGVuY2Uu
Y29tPjsgdmtvdWxAa2VybmVsLm9yZzsga2lzaG9uQGtlcm5lbC5vcmc7DQo+IHJvYmgrZHRAa2Vy
bmVsLm9yZzsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOyBjb25vcitkdEBrZXJu
ZWwub3JnOw0KPiBsaW51eC1waHlAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IE1pbGlu
ZCBQYXJhYiA8bXBhcmFiQGNhZGVuY2UuY29tPjsgcy12YWRhcGFsbGlAdGkuY29tDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjIgMS81XSBkdC1iaW5kaW5nczogcGh5OiBjYWRlbmNlLXRvcnJlbnQ6
IEFkZCBvcHRpb25hbA0KPiBpbnB1dCByZWZlcmVuY2UgY2xvY2sgZm9yIFBMTDENCj4gDQo+IEVY
VEVSTkFMIE1BSUwNCj4gDQo+IA0KPiANCj4gT24gMTQvMTIvMjAyMyAwOToyMiwgS3J6eXN6dG9m
IEtvemxvd3NraSB3cm90ZToNCj4gPiBPbiAxNC8xMi8yMDIzIDA4OjAyLCBTd2FwbmlsIEthc2hp
bmF0aCBKYWtoYWRlIHdyb3RlOg0KPiA+PiBIaSBLcnp5c3p0b2YsDQo+ID4+DQo+ID4+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiA+Pj4gU2VudDogV2VkbmVzZGF5LCBE
ZWNlbWJlciAxMywgMjAyMyAxMjoxOSBQTQ0KPiA+Pj4gVG86IFN3YXBuaWwgS2FzaGluYXRoIEph
a2hhZGUgPHNqYWtoYWRlQGNhZGVuY2UuY29tPjsNCj4gdmtvdWxAa2VybmVsLm9yZzsNCj4gPj4+
IGtpc2hvbkBrZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3ps
b3dza2krZHRAbGluYXJvLm9yZzsNCj4gPj4+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGxpbnV4LXBo
eUBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4gPj4+IGtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+ID4+PiBDYzogTWlsaW5kIFBhcmFiIDxt
cGFyYWJAY2FkZW5jZS5jb20+OyByb2dlcnFAa2VybmVsLm9yZzsgcy0NCj4gPj4+IHZhZGFwYWxs
aUB0aS5jb20NCj4gPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS81XSBkdC1iaW5kaW5nczog
cGh5OiBjYWRlbmNlLXRvcnJlbnQ6IEFkZCBvcHRpb25hbA0KPiA+Pj4gaW5wdXQgcmVmZXJlbmNl
IGNsb2NrIGZvciBQTEwxDQo+ID4+Pg0KPiA+Pj4gRVhURVJOQUwgTUFJTA0KPiA+Pj4NCj4gPj4+
DQo+ID4+PiBPbiAxMi8xMi8yMDIzIDEyOjQ4LCBTd2FwbmlsIEpha2hhZGUgd3JvdGU6DQo+ID4+
Pj4gVG9ycmVudCBQSFkgY2FuIGhhdmUgdHdvIGlucHV0IHJlZmVyZW5jZSBjbG9ja3MuIFVwZGF0
ZSBiaW5kaW5ncw0KPiA+Pj4NCj4gPj4+IEl0IGFscmVhZHkgc3VwcG9ydHMgdHdvLg0KPiA+Pj4N
Cj4gPj4NCj4gPj4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KPiA+PiByZWZjbGsgYW5kIHBs
bDFfcmVmY2xrIGFyZSB0aGUgdHdvIGlucHV0IHJlZmVyZW5jZSBjbG9ja3MgZm9yIHRoZSBQTExz
Lg0KPiA+PiBwaHlfZW5fcmVmY2xrIGlzIHVzZWQgdG8gZW5hYmxlIG91dHB1dCByZWZlcmVuY2Ug
Y2xvY2sgaW4gc29tZSBjYXNlcy4NCj4gPg0KPiA+IFdoeSBpbnB1dCBjbG9jayBpcyB1c2VkIHRv
IGVuYWJsZSBvdXRwdXQgcmVmZXJlbmNlIGNsb2NrPw0KPiANCj4gTG9va2luZyBhdCB0aGUgZHJp
dmVyIGNvZGUsICJwaHlfZW5fcmVmY2xrIiBpcyB1c2VkIGF0IDIgcGxhY2VzIG9ubHkgdG8NCj4g
c2V0IHRoZSBwYXJlbnQgb2YgMiBjbG9ja3MgYXBwYXJlbnRseSBjYWxsZWQgInJlY2VpdmVkIHJl
ZmVyZW5jZSBjbG9jayINCj4gYW5kICJkZXJpdmVkIHJlZmVyZW5jZSBjbG9jayIsIGVpdGhlciBv
ZiB3aGljaCBjYW4gYmUgdXNlZCB0byBlbmFibGUgYW4NCj4gb3B0aW9uYWwgcmVmZXJlbmNlIGNs
b2NrIG91dHB1dCBmZWF0dXJlLg0KPiANCj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGl0IGlz
IGEgc2VwYXJhdGUgcmVmY2xrIGlucHV0IHRoYW4gJ3JlZmNsaycgKHBsbDApDQo+IG9yICdwbGwx
X3JlZmNsaycgd2hpY2ggY2FuIGJlIHVzZWQgdG8gZW5hYmxlIGEgcmVmZXJlbmNlIGNsb2NrIG91
dHB1dCBmZWF0dXJlLg0KPiANCj4gU28gdGhpcyBQSFkgY2FuIHN1cHBvcnQgYSB0b3RhbCBvZiAz
IGlucHV0IHJlZmVyZW5jZSBjbG9ja3M6DQo+ICJyZWZjbGsiIGlzIFBMTDAgcmVmZXJlbmNlIGNs
b2NrIGFuZCBpcyByZXF1aXJlZCBvbiBhbGwgcGxhdGZvcm1zDQo+ICJwbGwxX3JlZmNsayIgaXMg
UExMMSByZWZlcmVuY2UgY2xvY2sgYW5kIGlzIHJlcXVpcmVkIG9uIHNvbWUgcGxhdGZvcm1zDQo+
ICJwaHlfZW5fcmVmY2xrIiBpcyByZWZlcmVuY2UgZm9yIG91dHB1dCByZWZlcmVuY2UgY2xvY2sg
Z2VuZXJhdG9yIGFuZCBpcw0KPiBvcHRpb25hbCBvbiBhbGwgcGxhdGZvcm1zDQo+IA0KPiBTd2Fw
bmlsLCBjYW4geW91IHBsZWFzZSBjb25maXJtIG15IHVuZGVyc3RhbmRpbmc/IFRoYW5rcyENCj4g
DQoNClllcy4gVGhpcyBpcyBjb3JyZWN0LiBUaGUgdHdvIGlucHV0IHJlZmVyZW5jZSBjbG9ja3Mg
bWVudGlvbmVkIGluIGNvbW1pdA0KbWVzc2FnZSByZWZlcnMgdG8gcmVmY2xrIGFuZCBwbGwxX3Jl
ZmNsay4NCg0KVGhhbmtzICYgcmVnYXJkcywNClN3YXBuaWwNCj4gPg0KPiA+Pg0KPiA+Pj4+IHRv
IHN1cHBvcnQgZHVhbCByZWZlcmVuY2UgY2xvY2sgbXVsdGlsaW5rIGNvbmZpZ3VyYXRpb25zLg0K
PiA+Pj4+DQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogU3dhcG5pbCBKYWtoYWRlIDxzamFraGFkZUBj
YWRlbmNlLmNvbT4NCj4gPj4+PiAtLS0NCj4gPj4+PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGh5L3BoeS1jYWRlbmNlLXRvcnJlbnQueWFtbCAgICAgICAgfCA2ICsrKy0tLQ0KPiA+Pj4+ICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+Pj4+DQo+
ID4+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkv
cGh5LWNhZGVuY2UtDQo+ID4+PiB0b3JyZW50LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcGh5L3BoeS1jYWRlbmNlLQ0KPiA+Pj4gdG9ycmVudC55YW1sDQo+ID4+Pj4g
aW5kZXggZGZiMzEzMTRmYWNlLi45ODk0NmY1NDk4OTUgMTAwNjQ0DQo+ID4+Pj4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktY2FkZW5jZS10b3JyZW50Lnlh
bWwNCj4gPj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3Bo
eS1jYWRlbmNlLXRvcnJlbnQueWFtbA0KPiA+Pj4+IEBAIC0zNSwxNCArMzUsMTQgQEAgcHJvcGVy
dGllczoNCj4gPj4+PiAgICAgIG1pbkl0ZW1zOiAxDQo+ID4+Pj4gICAgICBtYXhJdGVtczogMg0K
PiA+Pj4+ICAgICAgZGVzY3JpcHRpb246DQo+ID4+Pj4gLSAgICAgIFBIWSByZWZlcmVuY2UgY2xv
Y2sgZm9yIDEgaXRlbS4gTXVzdCBjb250YWluIGFuIGVudHJ5IGluIGNsb2NrLW5hbWVzLg0KPiA+
Pj4+IC0gICAgICBPcHRpb25hbCBQYXJlbnQgdG8gZW5hYmxlIG91dHB1dCByZWZlcmVuY2UgY2xv
Y2suDQo+ID4+Pj4gKyAgICAgIFBIWSBpbnB1dCByZWZlcmVuY2UgY2xvY2tzIC0gcmVmY2xrICYg
cGxsMV9yZWZjbGsgKG9wdGlvbmFsKS4NCj4gPj4+PiArICAgICAgT3B0aW9uYWwgUGFyZW50IHRv
IGVuYWJsZSBvdXRwdXQgcmVmZXJlbmNlIGNsb2NrIChwaHlfZW5fcmVmY2xrKS4NCj4gPj4+DQo+
ID4+PiBTbyB0aGlyZCBjbG9jaz8gQnV0IHlvdSBhbGxvdyBvbmx5IHR3bz8gQ29uZnVzaW5nLg0K
PiA+Pj4NCj4gPj4NCj4gPj4gWWVzLCBpZiBib3RoIHJlZmNsayBhbmQgcGxsMV9yZWZjbGsgYXJl
IHByZXNlbnQsIHBoeV9lbl9yZWZjbGsgY2FuJ3QgYmUgdXNlZC4NCj4gPj4NCj4gPj4+Pg0KPiA+
Pj4+ICAgIGNsb2NrLW5hbWVzOg0KPiA+Pj4+ICAgICAgbWluSXRlbXM6IDENCj4gPj4+PiAgICAg
IGl0ZW1zOg0KPiA+Pj4+ICAgICAgICAtIGNvbnN0OiByZWZjbGsNCj4gPj4+PiAtICAgICAgLSBj
b25zdDogcGh5X2VuX3JlZmNsaw0KPiA+Pj4+ICsgICAgICAtIGVudW06IFsgcGxsMV9yZWZjbGss
IHBoeV9lbl9yZWZjbGsgXQ0KPiA+Pj4NCj4gPj4+IFRoaXMgZG9lcyBub3QgbWF0Y2ggeW91ciBj
b21taXQgbXNnLiBZb3UgYWxyZWFkeSBoYWQgdHdvIGNsb2NrcyB0aGVyZS4NCj4gPj4+DQo+ID4+
IFllcywgYnV0IHJlZmNsayB3YXMgdGhlIHNpbmdsZSBpbnB1dCByZWZlcmVuY2UgY2xvY2sgdXNl
ZCBmb3IgUExMcyBlYXJsaWVyLg0KPiA+PiBBcyBzdGF0ZWQgaW4gY29tbWl0IG1lc3NhZ2UsIGEg
bmV3IGlucHV0IHJlZmVyZW5jZSBjbG9jayAocGxsMV9yZWZjbGspIGlzDQo+IGFkZGVkIGhlcmUu
DQo+ID4NCj4gPiBleGlzdGluZyBwaHlfZW5fcmVmY2xrIGlzIGFsc28gaW5wdXQgcmVmZXJlbmNl
IGNsb2NrLCBpc24ndCBpdD8NCj4gPg0KPiA+Pg0KPiA+DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+
IEtyenlzenRvZg0KPiA+DQo+IA0KPiAtLQ0KPiBjaGVlcnMsDQo+IC1yb2dlcg0K

