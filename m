Return-Path: <linux-kernel+bounces-156292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C790E8B00E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C784B23577
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B149915530F;
	Wed, 24 Apr 2024 05:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="NM7mhivJ"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9581E868;
	Wed, 24 Apr 2024 05:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713935608; cv=fail; b=SmZCsgW/DK1UpC/W30aWSbsTJOZi4e+YO7PWdF4m6qRB5uB73SGe0tVHC1XJ8mB4zp86hR4B6CyYzCg6wiG16pvjYaFuGbgFTdguPpjaNE1waApdLR2r2rvzzoutRZ2yzfOvOfHAyIkgnI+vh4JT/jlJ5V1AENW7mf52Lru97Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713935608; c=relaxed/simple;
	bh=LWGJZQ7K8dLVTBKLhCjTFAtoOcs1S0MYBXyDkT3DACo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dWRFQlYM77dkEggGdx4iYPUs+LadTdLJrWrtDm+sihYNBipDMSQxHNXH9F6M+zxTYaJCWi1Q7K/g+DkljsuO8/1/3FRY2erENujpW7hkHY7nr1UOZ0JzaRZOzkYNxPjeCjy3Ery2+F2Dw2NQfpIIm1Ggc2u7QqjUFukq11tZsRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=NM7mhivJ; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O0qaZF022561;
	Tue, 23 Apr 2024 22:13:12 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xmd7gmjh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 22:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giYiYIZ7wEEUTMDlbWVODql6aOBc0yrIbFvWTD1ujopNBsvn9LOvf1v10yFqG9wI9vLwpRlEVucXQccY+QnM/ysSY0nEh1mzrfooYlChvzPt9n9J2gqjS9BTPdAFjoi0Jio8seHSZgxio9O8oqJu6PEvaHXpzKweB8bdbnz12kOFHfj47/ikR4QB85cqmi13hDPF3e1usLPJmSw0l95WbzKtcRZzfv/79F6v90oNzWrRU4VMJrL8Nwg1+IXLpytMx4AO89ZzzK7V7w5FFOfo1A8IJl941gk9niaWa0AgJhCdZMefyL7H4eZpIf80Z/WV3Ie8mMTHDldMWbgpt9FaJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWGJZQ7K8dLVTBKLhCjTFAtoOcs1S0MYBXyDkT3DACo=;
 b=eldSyRFHCDf/w+34Z2cTo25nA21xjwvE53TpW+pBV8sxEPprO40KNRrG/voy1QsvwBVlbqZDHWA9lWErgD3xUlXcmf4jtlSYjZ1vnLRtasN47Kmt1r407xKTYeoD/7qoODZ8i+8uO9x3ZKcfXhTG7ldYSf5OaALL6g/b3TbvtgrntMJpac8FwJtj3LDmrna/rFQZLlC+rTYhfmlgGEjPlo4+LGapT2sZO8eL9r0FmizUX4+xHrXbXedqyizRo7p+PYbuwVbkHZkCVQ1mG70nY1vDD2tKbMEEpNwotjG/1U0jJHXLqL0IduVpZTxGoStn0MgR+QpBguRttnGcE4z40Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWGJZQ7K8dLVTBKLhCjTFAtoOcs1S0MYBXyDkT3DACo=;
 b=NM7mhivJa7FsTMvRsOfMsLEb/WjQAI4ob2nTiDPWiYB842J42sXkDfVHCzTU/ydjHHxTLmXRckKKayzG7g4WcRx51svXmfGYlgbp50Rm1BvR6BkT+sa7j0DPobaBAy7ISEbQ6C+mP34b1tIY1H71IVTr/7RBmirrxUj+HZJ9d6A=
Received: from PH0PR18MB4474.namprd18.prod.outlook.com (2603:10b6:510:ea::22)
 by CO1PR18MB4572.namprd18.prod.outlook.com (2603:10b6:303:ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.45; Wed, 24 Apr
 2024 05:13:10 +0000
Received: from PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916]) by PH0PR18MB4474.namprd18.prod.outlook.com
 ([fe80::eeed:4f:2561:f916%5]) with mapi id 15.20.7452.049; Wed, 24 Apr 2024
 05:13:10 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
        Jesse
 Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen
	<anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] net: e1000e & ixgbe: Remove PCI_HEADER_TYPE_MFD
 duplicates
Thread-Topic: [PATCH 1/1] net: e1000e & ixgbe: Remove PCI_HEADER_TYPE_MFD
 duplicates
Thread-Index: AQHalgYZ+8V9FFDao0WWIO40kJFegA==
Date: Wed, 24 Apr 2024 05:13:10 +0000
Message-ID: 
 <PH0PR18MB4474F39D49346BCAD5535021DE102@PH0PR18MB4474.namprd18.prod.outlook.com>
References: <20240423144100.76522-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20240423144100.76522-1-ilpo.jarvinen@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4474:EE_|CO1PR18MB4572:EE_
x-ms-office365-filtering-correlation-id: 004fc4cc-076d-4251-b8e6-08dc641d3c04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RklBOTRPQ0JaTnhQUFdCOE5nSWhDaGM2Um9vWTVVYWl1bkRKMXUyZXdIRTVi?=
 =?utf-8?B?SU9FUjBEblljcFBNcU9CL1lvK3VkaHZkYjlFK0RiOElXdTk5aWVIR0NwYmZv?=
 =?utf-8?B?SzByYkhKaXRsVHh4MlZTMGVBL21iMUNlM09wVWY5OC9WbTl4VjJvRVFaMTJJ?=
 =?utf-8?B?elFRRTU0WWVtbUwyMzJFc292M3ppSXAwcjdtb2xxS1BQdUFNR3pYVExqdU1w?=
 =?utf-8?B?N3ZSWldCbU81NEpOa3FxQ0dyOVQrZkhQK2hSSG5jYnZhNFptUW5rRDEydnVC?=
 =?utf-8?B?Ync4QU1uR1JPYjZHek0xZGc3NW1BU3daam8yNHZrRHVjNnJWMk9wODRGRnAx?=
 =?utf-8?B?bDZPOWRCSXZNYXFjNHJQRGdkOC9kRUFSZmFaaW5XVUk0UktZa25MUmc3V1Iz?=
 =?utf-8?B?R25kSi80NFBOd0ZCYTgwWkkxQjduMkRPcS82ajNXTnU3OFRMRS9CeStYa1pm?=
 =?utf-8?B?a0oxS09ldnB6K3AzRDV0bm1lQmZKdUdMVkZCRUdrblN3OTNNZkd2TUhzTWox?=
 =?utf-8?B?M1NNRFlvZ21YVzJZc1N4VWJ3RnNQbzNtbkNXZ2VSZjlQdHJOMG9DVmhNQXgz?=
 =?utf-8?B?TzBURjV6RXFQK0k5NnZHYzAyZ1VpdjZsVUE1dytISStHRWxxV3VJRTVUYjBz?=
 =?utf-8?B?TkxLUW1vSzY1d05FV1BsYjE0c1V5OHE0elpxOFpkU21FcWdCNUFQVU1pQWR4?=
 =?utf-8?B?Q2VjVjI4aHhqRUZDMTBzTlJlN3h6NU9LYWwwK0loLy9HNnRoK0sxOXlmSzZj?=
 =?utf-8?B?YWd0NzRKQjJ1QjBoYllhZHE2M2xsS21yUjFTYTFuSi9aTEY5UjhIbm4za1Fk?=
 =?utf-8?B?VjVOQXhwdEZGZC9ObmliVkVkLy9kK3VCNlcxMW43NUJhTk91YUZVWG9ReEFW?=
 =?utf-8?B?Ykx6KzFHcFFCN0d4Y3ZUYk1wM3g3b2VBK3pZcUNIMHViM2tHd2s4RUMxWktk?=
 =?utf-8?B?aDZSQnhNVmRTRm9jQ0lpRlNUNE9RUGpLZnJ4YXVzR1FienlNOFhnNEFvQjJa?=
 =?utf-8?B?MDh3eGh3T0t1S1Q2M1doTkU3OFV0S3piYmtQK05VbUVMdWh6Y24rWi95SW14?=
 =?utf-8?B?b3Y4Q0tVUzBpNitJbVFyOWlNbmR6TExVUVVjbnErZzc3Q2VWczJRbTF6RWs1?=
 =?utf-8?B?dGRuL1RYSGJnUGt2OHR2czA2dFBGN0l3TFFKZm9VOVVyM1Fyd0plSFlyakxX?=
 =?utf-8?B?VUxPdkdkSEkvZTVMNGgwelZLcDl5UmJ0akpHQkJteG92TWxPRlBxOWprMmRj?=
 =?utf-8?B?SEt2UzJOU3R1ZGZPYkQxOEtnVUJKYzYvbGtNbEdxY25CeHpZUGFvZEJTeU1v?=
 =?utf-8?B?OWJ3ZDFZNEVVbjRpcDRzZXhDVlJLN1g1ekw4NEpLV1BReDNKYWJzM2lvbzYr?=
 =?utf-8?B?QW1JUEJkZ2VEZ1FVelhBTU1KQ1AwdDlqSkJRUzVRUDVVVTB1WEhoa051ZGJP?=
 =?utf-8?B?aGhndFVRUCtRb1hwR1ZHNVZpYWx4UEVNWUc2Mi9KQ0lyN1lRcG5ZSjlwTHNF?=
 =?utf-8?B?Y09KTHdDUjNqN05nMGp1THNOQ0h3ZFhYQTV0MEVHZEpjQzRpRWE0K1BwdGl6?=
 =?utf-8?B?ZFRKMEZ6WGlGcVhEaDNXWGRHK3VsWVdib0dlNVBLdHAwV01Nb1M2NkcxVll4?=
 =?utf-8?B?c0F4dWh1b3AzekJhT2JWd3g3ZTJaUDdxUE9pRGZ4WkJBS3pvaUg1OU9CUDZZ?=
 =?utf-8?B?dHVGT3FhVlhLOWJDL3Q0QVBLQXlGT1R2MW9waFIwbEFuQVVORFNRUGJ1SFNL?=
 =?utf-8?B?eFBxY0RTOWVhWXc5ZHFjSFBSSUxiL09RWS9pSnZpWldTSkd4TnhEVml0MjZ3?=
 =?utf-8?Q?IJULzeOwEgfOY54TBBvp2RVhdtyF2fChy+B7c=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4474.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MmJnNFROalFOTUthYnBYRFpLcmNMUXZXZEdjT0pWeEo5aFRnT1k0Z2twVVNN?=
 =?utf-8?B?dFZFeks0N2tPNUEzbmZ0TXJhS1ZLcTdPZ3NjdzZvV0lCaFAwQkt2NEx6TlZp?=
 =?utf-8?B?N0lacmd5blIyb0VqZEYrNTExZ0VhNWJVMWNsY2FXQm9wMDMzdXZoUUZTQjQ3?=
 =?utf-8?B?d3BVL3I1aTZQdlNnK0hkWHBYU1RqeWRzMW14VDQxclpYUW1tbndRYnczb3Jm?=
 =?utf-8?B?dFM3b3ZaU3NaeVhjcUcvOVAxekJtKzl5NkJEME1GWGc4aUpTWXVSTXVVQmND?=
 =?utf-8?B?NURtVER0L0xYdVc3MVhwUjNmYk44WldyVGdPNkRYVWxaWEt0dXFMS1R0V3kv?=
 =?utf-8?B?ekNWeHJ4WDN5RGp3R1dHYVg3Sko2ZWVLYXJBTDVhbkpPZzYxRDRpSkhnN0Fw?=
 =?utf-8?B?YjlCaENObFBTaFM1NW9Ka2poOEhOeDhnRHJSNTBpRkh6TnZHMk1ET0VXTUxa?=
 =?utf-8?B?MkNuQ0dWYkNPdVFwQXJlc2F0L2V6WUp1b21ldnd1UTVVV0F5MjFtMVFiNW9t?=
 =?utf-8?B?WXpGb3UzM1hGTE9uaGtEdHpLTWhyNVBxWXh4a21KcnN6Ymx2VVRueXo5T1Vq?=
 =?utf-8?B?ejBOSUJwUnZ3bnQvQmZhRDJEMUdjdTR0dFRscm81WG4rV1R4NnJPZkRHWnBs?=
 =?utf-8?B?ZkZvbktrZnpHOXo3bG1jdW1mdkNuMGMreVJMSjBrMkhBRWN2YXZYQktpck9t?=
 =?utf-8?B?Wks2dm9ocVEya05PNStYRnFKRFNOcnB4VzEwM1ZjY1pzL2pmbnp5MkRFSXNT?=
 =?utf-8?B?dUtTSEVWUmpBRWlTa1QvcUorajlwTStMd1JUYWJlU1JMR1hiSmJwbjBlZ3FT?=
 =?utf-8?B?SmgzZG1vbzZJOHlmRlZlWm81bFlRNUtxc2pseC8vY21UbDIyOCtPcXVHNzdO?=
 =?utf-8?B?TWdLdWVRNzVEY1lYSkptQTdhQ1FDbC8vcHRGUzdBZ29XVUhodUxaTDFrSUho?=
 =?utf-8?B?OE9WZ2pDWWRlS0RHSDdSQnoxV3hxWmdUK0l4NmR5c1pmanFOUmt3QTlqUVFl?=
 =?utf-8?B?dDhRMDRhcWsrZnpRR0JqRCtZTVpUTVFWMTNFcTdYc1k3ZDM0ZVFQdURqejlY?=
 =?utf-8?B?U0NZTjU1MTBiNkRFcE1pNjVJU1Fvb25FUmdQRDk1dThzNS9TMXJzRThVSXVw?=
 =?utf-8?B?QzhnWDBHRUVoeXgzbEQ4ZWlySk1YVmhWSzFGZ1ZQa1FQaFUzQXI0c2FrTjlq?=
 =?utf-8?B?T2Z6SG5JdFBTTHZDRVhzSHZoOUF4TjNyeVI2aGN5ODVLNkVBdlppbkxxUnVp?=
 =?utf-8?B?dXBOUENmaWh1akVDYlhNUzEvTlZTR016SFpHaEthSnc0YkRUNjMxeGQ3MFVU?=
 =?utf-8?B?dHNGMmhUQmRPMzcvSjRLb2szUVBubHRPVkhQVHJoU0E5VVQzZGhuZVJ2UHZY?=
 =?utf-8?B?TWdIU01ieWVTQWJpWXQwaEdDNGFlUmc4a25IU01Na213LzZYYkZCTjEvd3FT?=
 =?utf-8?B?ZStldzM0UElhUzVqbVNVa0FxSElXMEFhRlB2RERRYktJak96K1pIZzVuUDRF?=
 =?utf-8?B?Z2grb0NzTlY3N29tYzllOWllYS80S2lyU0hxQ252Q2puTEhvWU1jVzJORzJB?=
 =?utf-8?B?cjBiNHdQcS81Wm5PMzAyanlLd2FydnJYNkpQaDlUNnh1MnJhWXpjZVZ4WHpL?=
 =?utf-8?B?WXRUVDI1VW43cjJ2Mm8zTEx0OEZJQVU3cXVzdXdUYURqTGh5YmlzS0VCVHhZ?=
 =?utf-8?B?aGhHektockQ2c2lHbUxUYmpXaWJvSGtSNHNUaEpoRW4yQzZWd0JFa081STFU?=
 =?utf-8?B?RTNKMWo4NENWZlYzK01FZThUbnM1bWszTjg1cWxSSkFCUUZ3cHFSVDFrbG1G?=
 =?utf-8?B?TzROSFErdWpGa2JCOTZ4VkZwSDREVGFHK3gvTTNIdkIwVm4yRXphT0gvZ0lj?=
 =?utf-8?B?NVB2VWRhbGt3QTdyRDhXL2FoaW5JaTNvZTc0KzNCK1BaUDRaTTBhbkg1N0Uv?=
 =?utf-8?B?VjJlNjIvcmpPay82dTVVbkFOOWZnZG9iMTdIanI4bXhHZWVsYTBCNDQxR0dz?=
 =?utf-8?B?VURvQmxURW9JRE4yTnUwSy9BZkNNeEVjYStNVkpwVXhoNGhhdkNrNGpRRm9n?=
 =?utf-8?B?OXJKVm8rMGRXTWNIUFA2c3g1RXFyNlN5dGJtWUx6WUlISzc3bXFPOEpSdE9R?=
 =?utf-8?Q?kH4k=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4474.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004fc4cc-076d-4251-b8e6-08dc641d3c04
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 05:13:10.2971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2D+gaUlFRtAYQSdARsn2aJs1GdDO3hbpKi6WCkwOzyD6iadZjMn3/1t4SxM1HHckJ14705VRIW3X0BUjKG+kSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4572
X-Proofpoint-ORIG-GUID: U8M89Th7IMZlQANigpP3LLHQUi7V8bQR
X-Proofpoint-GUID: U8M89Th7IMZlQANigpP3LLHQUi7V8bQR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_02,2024-04-23_02,2023-05-22_02

DQoNCj4gUENJX0hFQURFUl9UWVBFX01VTFRJRlVOQyBpcyBkZWZpbmUgYnkgZTEwMDBlIGFuZCBp
eGdiZSBhbmQgYm90aCBhcmUNCj4gdW51c2VkLiBUaGVyZSBpcyBhbHJlYWR5IFBDSV9IRUFERVJf
VFlQRV9NRkQgaW4gcGNpX3JlZ3MuaCBhbnl3YXkgd2hpY2gNCj4gc2hvdWxkIGJlIHVzZWQgaW5z
dGVhZCBzbyByZW1vdmUgdGhlIGR1cGxpY2F0ZWQgZGVmaW5lcyBvZiBpdC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IElscG8gSsOkcnZpbmVuIDxpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9lMTAwMGUvZGVmaW5lcy5oICAg
fCAyIC0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZS9peGdiZV90eXBlLmgg
fCAxIC0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9lMTAwMGUvZGVmaW5lcy5oDQo+IGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvZTEwMDBlL2RlZmluZXMuaA0KPiBpbmRleCAyM2E1OGNh
ZGE0M2EuLjVlMmNmYTczZjg4OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvZTEwMDBlL2RlZmluZXMuaA0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRl
bC9lMTAwMGUvZGVmaW5lcy5oDQo+IEBAIC02NzksOCArNjc5LDYgQEANCj4gIC8qIFBDSS9QQ0kt
WC9QQ0ktRVggQ29uZmlnIHNwYWNlICovDQo+ICAjZGVmaW5lIFBDSV9IRUFERVJfVFlQRV9SRUdJ
U1RFUiAgICAgMHgwRQ0KPiANCj4gLSNkZWZpbmUgUENJX0hFQURFUl9UWVBFX01VTFRJRlVOQyAg
ICAweDgwDQo+IC0NCj4gICNkZWZpbmUgUEhZX1JFVklTSU9OX01BU0sgICAgICAweEZGRkZGRkYw
DQo+ICAjZGVmaW5lIE1BWF9QSFlfUkVHX0FERFJFU1MgICAgMHgxRiAgLyogNSBiaXQgYWRkcmVz
cyBidXMgKDAtMHgxRikgKi8NCj4gICNkZWZpbmUgTUFYX1BIWV9NVUxUSV9QQUdFX1JFRyAweEYN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX3R5
cGUuaA0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX3R5cGUuaA0K
PiBpbmRleCBlZDQ0MGRkMGM0ZjkuLjg5N2ZlMzU3YjY1YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmUvaXhnYmVfdHlwZS5oDQo+ICsrKyBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2JlX3R5cGUuaA0KPiBAQCAtMjE3OSw3ICsyMTc5
LDYgQEAgZW51bSB7DQo+ICAjZGVmaW5lIElYR0JFX1BDSV9MSU5LX1NQRUVEXzUwMDAgMHgyDQo+
ICAjZGVmaW5lIElYR0JFX1BDSV9MSU5LX1NQRUVEXzgwMDAgMHgzDQo+ICAjZGVmaW5lIElYR0JF
X1BDSV9IRUFERVJfVFlQRV9SRUdJU1RFUiAgMHgwRSAtI2RlZmluZQ0KPiBJWEdCRV9QQ0lfSEVB
REVSX1RZUEVfTVVMVElGVU5DIDB4ODAgICNkZWZpbmUNCj4gSVhHQkVfUENJX0RFVklDRV9DT05U
Uk9MMl8xNm1zICAweDAwMDUNCj4gDQo+ICAjZGVmaW5lIElYR0JFX1BDSURFVkNUUkwyX1RJTUVP
X01BU0sJMHhmDQo+IC0tDQo+IDIuMzkuMg0KPiANClJldmlld2VkLWJ5OiBIYXJpcHJhc2FkIEtl
bGFtIDxoa2VsYW1AbWFydmVsbC5jb20+DQo=

