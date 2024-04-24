Return-Path: <linux-kernel+bounces-156974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA00C8B0B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE251C22CBB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC46C15ECE1;
	Wed, 24 Apr 2024 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="oL/StOxG"
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E939C15E818;
	Wed, 24 Apr 2024 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965581; cv=fail; b=K17AOHQsXKc830RPc4cybSKFVzSHO7YkcptB0Boyo52HDka1YLZlse4fq/xDM+m6nmjqRMPt0t1vvJ0BN4tPQj3HB7mYQh/K9kvAH500BUU7NJQjfN0lvzfN6oKaSM7uN0z81aGKUcQCX4ugO0z57JzrxDcswKDtSOI2gtiAxS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965581; c=relaxed/simple;
	bh=G1VcsJugo8Ga6uy/2zrLo/sk6mf1FHmvlf9HS/SQioA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kcj4jcsWNLVWKCrD34AgxcPZ1HiOe1sAI+kmn97cUS6I6MRk3GZtR8AchEfL2rTS2//PRUaxT3/hlmAIG9a463OxIkUodhBBVxy5uGW/kyZlANV0vc4jvohBHD26gvEp9rNksPhaprL8x/ufNCX8ZWVkf7sO5CI1G18LMyn1yRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=oL/StOxG; arc=fail smtp.client-ip=205.220.184.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43ODK2Z7012433;
	Wed, 24 Apr 2024 14:32:48 +0100
Received: from pnzpr01cu001.outbound.protection.outlook.com (mail-centralindiaazlp17011004.outbound.protection.outlook.com [40.93.132.4])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 3xny4n8uyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 14:32:47 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9Lob+pqNPo1WKdTYaMAI7WErPRXmRc8vfTX1ru8jXTt5vY2bghbx1JecKam/7ZS/z0T4ICBHXnSRnzDvZ4HfBP7vvCPWKV/8A29QS8k94j1HFFXYMOb5mD6NbjVca9IRgwSVRx6GhCMgRPp/BBFIPWM4jtvT+VD5gYhbV5YW4TPkKDkRiKpk4xnqs0nTzy/b+0ehqjKTqImaVp/u9JqHfE5LXXTHZ8VJqSM0zrgwkwE/36Vjo1tPhB3s+VW1cIAe7/7D+C05PnUpKnX/jib/TtOPDxhwcG7XlRNoYblBYgkbsA5MIMMzyK31X+bJABCitokzuoOfEi+b6omj6/t7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCfG7XpxwRpQ+q2Tui8NjM5ORNfj8JwvYVSTtWTrzts=;
 b=ISfHVNyMTDNvhy2bYiBITZMrEogsqRJsKZ2PMwV6OZyW7FiWtbY8KRy4hz8/j6aUfgoMEMUcrB2o7r0lAYcgKJGVZSRTd99EPsZolN1cb0DhSA7ze6yKP0gTX6vu7LJoQcgn390wmw2vzsyuxseCLwmtvw31RJPq59QeQEpBuM/TQ3UuMD4RvELRfZMMBQ+5e6jGsj2qn/nGK9P0E+s9AJezC5YexgHEZbUC0Y3aYGnSkJG3rJBnY7XsEUFbnygwEkSWl9+OrJXMqNYWeDJaf0anqItKmNk2qgKHdUcBiHLHYHG5aU0XH9Uxe/XakK0f+TkuEMR10dwcFwvbQL47hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCfG7XpxwRpQ+q2Tui8NjM5ORNfj8JwvYVSTtWTrzts=;
 b=oL/StOxGOhn0xKkqPZ/c+WD75PCFeKX+hOMrR3OwjoaFSRgr8mfeUZJsawchRZYbaItHFY35uJ8dKaTvAoKWSlDe019DVnCkIXqUh1IKaKdK2VLSAvxWXkmaxASo+sbTXNiAryAB8XrwODYloN3fgVF3CIoHjZEOv3KDynZzBpo=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by MA0PR01MB6106.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 13:32:43 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 13:32:43 +0000
From: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
To: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>,
        James Cowgill
	<james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil
 Jones <neil.jones@blaize.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: [PATCH v2 4/7] dt-bindings: clock: Add binding constants for BLZP1600
Thread-Topic: [PATCH v2 4/7] dt-bindings: clock: Add binding constants for
 BLZP1600
Thread-Index: AQHalkviFYf75wXqX0WwAXHOarcksA==
Date: Wed, 24 Apr 2024 13:32:43 +0000
Message-ID: <20240424133241.19210-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|MA0PR01MB6106:EE_
x-ms-office365-filtering-correlation-id: 9544ca62-3234-4870-9630-08dc6463057c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?MB2ZMrUHpbw4tBz90wY6+dwsIQxRSzppWDPY5Y+ocVhb/+DgEqvmcKSvtR?=
 =?iso-8859-1?Q?apAZh11/nwEZHFiFQAQPeu0aEeGJ+UE8FywdKdFaHLl3iN87nxQIoBGmsv?=
 =?iso-8859-1?Q?ZcxYioSdfddfKtRpgLzwYQDI8CxvjCf/S4uT5+oPvArE6Aw+6OOydu+AlP?=
 =?iso-8859-1?Q?L5mAKPiemDUfBWcLWGGJxCh4s6yl3515l6L60T15ttZvktrHsocMTZldYF?=
 =?iso-8859-1?Q?6xUz/tKvajaJbhF+Sx3l2a5CTWihIfHG1idy1iIHNVr1aDQvCKnOgDYV6R?=
 =?iso-8859-1?Q?49Gr4nrPH2aYwD1uubCwcxNFZlrF9V8h0gzczFQGUU+JgnR5eZ/XkCjC2D?=
 =?iso-8859-1?Q?ZjVKlJemPR6dtBHP/Wo7uVXjhx66pjCh/M3ORTcDlRyL5vc5E4RH9iSEvM?=
 =?iso-8859-1?Q?O7NXBkQG+VWanwhZV3Ei84aaKuQ2tSyHdN7LEXh2gJyE1o0WZd1njemvjJ?=
 =?iso-8859-1?Q?Y7WaJyXvcLmjTZubwJnSr2N6QEBtMVWVo7BjMITbCIDC68zatgKUSRV26q?=
 =?iso-8859-1?Q?efahiQDvi9MCUFE4cp3cO/zyaAXWUjjk/VxUX//KDeFIxjjnFB2UVyung2?=
 =?iso-8859-1?Q?vrW58oBicVlQdOIR8gTeQx/1fMP9Td9tLcnYD8G2BWcX5E9mJ0JXGDoKmX?=
 =?iso-8859-1?Q?sFXReOYXBEqXeFzfT5PRgnJINPOeHEB8H9LQTVQ1HLtquMJBL17OxAOg6p?=
 =?iso-8859-1?Q?33srvEguTaPjHTSBjF6uILlG1vfcO/gBTT5l6zrlVqHK0Ix+pDXwtjlR4L?=
 =?iso-8859-1?Q?gi7GBB/dDFFqQWivZE+NtmUiQtcuomBXeb+HO/XyyKweARH53LtludvvvP?=
 =?iso-8859-1?Q?kJu8POBSc1GyIL2B9nw87/iGtuhQMWc2hm14ZR6S0/xXHOnxdLe93vRQX0?=
 =?iso-8859-1?Q?tgxsiSOxz9SPTxsMSubQ2SgeeUvwxXtK53elr+bga3MzI/ymWNo9ClIs0J?=
 =?iso-8859-1?Q?iPemuAnTRuDtOU10fmTfhJzunUO7LXiGiDYZxmUxOdb/pPQUlwyMXzaL0G?=
 =?iso-8859-1?Q?15ICncQxome9zzw/DorCgSedKI7uKJpGh3kRpW92XOLJiMHlU+33kYQ6JD?=
 =?iso-8859-1?Q?hXrLwZv+/wHnTz+oN5wyBBf0T1jUfofRdeKGmR9/TsvUvaxnuxVVZkD8IG?=
 =?iso-8859-1?Q?O/ZH8mYBfqbii+iHtWrRDmWJNWf7enHJadR4P6TDz53fuO+1PI5/g7z87x?=
 =?iso-8859-1?Q?Dfk8wN/vh/DkLMr8oKOwDJ1v1xz8XUCm1ZIkuu+nvv83vo0EETkAPLfuIf?=
 =?iso-8859-1?Q?TuJ21timglwJ4QXYoJjC8nEntnuy6biV9Jnj09mGo0fx3PmXUUB8171Nyd?=
 =?iso-8859-1?Q?EMNK8zB+nmyxTxNK2L71Rx1n1eLh05lZsF0XCigPPgx4k0tBuD/4qhSF4N?=
 =?iso-8859-1?Q?0hI5ZolnlaTIUiMMa2VJ1cDeMdGS2B7g=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?f5wHQ5sxx6B6ZlArBMAOD+UfJINZVLpJ43OMbQdr9t7S/Qmt/aoTMyqbL8?=
 =?iso-8859-1?Q?NPvyFdseXc7u5+S0zEAbhfcbdYwghR6m2z4fsdRM7oVtrA4ZaMs0/pyNBU?=
 =?iso-8859-1?Q?aVmxsnaX30F78MqGL3T14av39Z7a4Z8z4YMLOZ5J3aEO22V2mui7AFN6r9?=
 =?iso-8859-1?Q?yPt5MwrLMq/Jp2EACcCB+RFAB8j8vmROQgdrFt9uvhNnu3kwaEx74o623z?=
 =?iso-8859-1?Q?7qC7l/hZoZWiDEfHHGLzGX6DcwUHz84z8P0JKLjfwFXxaj6/bqcu7IuuiJ?=
 =?iso-8859-1?Q?U+zb3jqUcdVlkMjb3W1h/81Tv1rfiRs7QA0Lb+bvV1yde0XNVStMGgRNkU?=
 =?iso-8859-1?Q?TrsH7IRUEj4EzHQ7FCLHQIVcHlbA/troYmHaPkJ7sR6tEtsjmba77YBGUu?=
 =?iso-8859-1?Q?BpJbu7fxTCyngBifnVlVvdTZLuON/M9z31SoIZcI8m2OUvUp2ihE/Pc3Zq?=
 =?iso-8859-1?Q?1DwFIHfce8tpCxco7/X8PJ941Pl8ZDuJR2WANYlbZ6MkSVI4yiw2AgPEMg?=
 =?iso-8859-1?Q?bPJPE4zlWMIgHy0YM24siCOt0+zKhUmCjMRb+kSf5bEj7KvI+EBVVJPYXg?=
 =?iso-8859-1?Q?/+IwhA5ckmcgoZumq6cgvdT68sCm6Fyp0EqdV5c/LJZxxAQV/Mxfo7BbWK?=
 =?iso-8859-1?Q?1AKageTYRyEutNeD369WYYkRqNaZ4msPsXMZBxmSj+0X46eMq/A8izWuNX?=
 =?iso-8859-1?Q?B31Y0qEp13mimiXthZzVPIUEqnIaKp8U8cIuIDX8RwOJ5ERULqili0Ffbz?=
 =?iso-8859-1?Q?hxQNuN3lPkV2MtgzdlUk+BpeIs5ydTNQ958Z/HfXNCOoLRwDEHIe5sOkbv?=
 =?iso-8859-1?Q?lmtJ/qc2Ns/1Oe15Ev5jg4VyIIwZRgGli/OCEli0wDhazsA7hSyPSIhePz?=
 =?iso-8859-1?Q?WyRdyoJnHmF9jWOFZ1ByNbpAe7rV15NvW9Z+//BroKJW9IhvYwMB9YT1TR?=
 =?iso-8859-1?Q?3mMmmRDGDC2er5PWmaK09mpPAY80IO54kI5JB0hQHz1qgBASUGPFCJzA4Q?=
 =?iso-8859-1?Q?zvoa7ctjP3ra5M6K1M11KUsLdllhWbjaOPOrw2VE97khmWTxhd5AZtT+mr?=
 =?iso-8859-1?Q?SdU7SeDPrk9VONhR1uSLMi0YV3PqmG54EolPQnKAkx1YqDaKjXcOXN2SFN?=
 =?iso-8859-1?Q?fdn8rlLQBVLviS//76a1WVrHbH7RgiWeP89FvvTvBfmMN1a5GPkqA+OGHf?=
 =?iso-8859-1?Q?IVRUitd0zhrAyKMQehWOLDU5PkUgwqM6RRLCyllPbmo8FZWeKBmc4xxP7Z?=
 =?iso-8859-1?Q?jnUKUD7I6Yuryrt3oiLdGqh81Fb7ZU3FBPzCbsRbjbe6mCoxARqLVfHA/a?=
 =?iso-8859-1?Q?jIfdHIfnwVF5S8lUhHfNjpJgYyoXzKJ1jSOxBSbIVryd0VjYtnBIq2Z11r?=
 =?iso-8859-1?Q?S5LRpZLO7XmjCMOcdp178J1gs5AF0t60CJksTT0clN1j21rfThN7d/BrgQ?=
 =?iso-8859-1?Q?J+G2f6gpsGnLODsCHgA9za6lectAFg3TKtfG7GGJhZl3TYi3fW+mjTtBNh?=
 =?iso-8859-1?Q?j1E5j0nMFii5+cwTLcuDoHAXRLi++8FtczziMHOAg3XZ8AtOKRolXNZ9wp?=
 =?iso-8859-1?Q?Bo6ZamBqO0WgAbsqCUXGK3NO3sVBQtNpMsXXx31irrqXay1BWkpucntstb?=
 =?iso-8859-1?Q?//39+LfiiA/hYh0soN4wA0MNvkDWPT3WYNmTTIRIeLZzRXMZPwgv1NOA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9544ca62-3234-4870-9630-08dc6463057c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 13:32:43.5795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03n8jlbY5MqJg9GLDFqj6LIJKMEKkG8ovfmsgOP8SvDyewFULI1XsJyIjv1NL9X+cPcMWbH5RI1PHhppMUCZ3j14VlohZa5r0sKwzloRim4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6106
X-Proofpoint-GUID: alJ9DnF24i5_H1Mz-vQyDcB-1h9u_fRr
X-Proofpoint-ORIG-GUID: alJ9DnF24i5_H1Mz-vQyDcB-1h9u_fRr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_11,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=622 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2404010002
 definitions=main-2404240046

Add SCMI clock numbers according to the Blaize BLZP1600
SoC hardware specifications.

Reviewed-by: James Cowgill <james.cowgill@blaize.com>
Reviewed-by: Matt Redfearn <matt.redfearn@blaize.com>
Reviewed-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 .../dt-bindings/clock/blaize,blzp1600-clk.h   | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 include/dt-bindings/clock/blaize,blzp1600-clk.h

diff --git a/include/dt-bindings/clock/blaize,blzp1600-clk.h b/include/dt-b=
indings/clock/blaize,blzp1600-clk.h
new file mode 100644
index 000000000000..f1d59849a6e5
--- /dev/null
+++ b/include/dt-bindings/clock/blaize,blzp1600-clk.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (C) 2023, Blaize, Inc.
+ */
+
+#ifndef DT_BINDING_CLK_BLZP1600_H
+#define DT_BINDING_CLK_BLZP1600_H
+
+/* ARM SCMI clocks */
+
+/* BLZP1600 clock-gate numbers as defined in the hardware architecture */
+
+#define BLZP1600_CPU_CLK 0
+/* clock-gates 1-6 invalid */
+#define BLZP1600_CRYPTO_CLK 7
+/* clock-gate 8 invalid */
+#define BLZP1600_GSP_CLK 9
+/* clock-gates 10-23 invalid */
+#define BLZP1600_USB_CLK 24
+#define BLZP1600_USB_PHY_CLK 25
+#define BLZP1600_CAN0_CLK 26
+#define BLZP1600_CAN1_CLK 27
+#define BLZP1600_CAN2_CLK 28
+#define BLZP1600_ETH_MAC_CLK 29
+#define BLZP1600_SDIO0_CLK 30
+#define BLZP1600_SDIO1_CLK 31
+#define BLZP1600_SDIO2_CLK 32
+/* clock-gate 33 invalid */
+#define BLZP1600_SD_CARD_CLK 34
+#define BLZP1600_CSI0_CTRL_CLK 35
+#define BLZP1600_CSI0_VDMA_CLK 36
+#define BLZP1600_CSI1_CTRL_CLK 37
+#define BLZP1600_CSI1_VDMA_CLK 38
+#define BLZP1600_CSI2_CTRL_CLK 39
+#define BLZP1600_CSI2_VDMA_CLK 40
+#define BLZP1600_CSI3_CTRL_CLK 41
+#define BLZP1600_CSI3_VDMA_CLK 42
+#define BLZP1600_CSID_CTRL_CLK 43
+#define BLZP1600_CSID_VDMA_CLK 44
+#define BLZP1600_DSI_CTRL_CLK 45
+#define BLZP1600_DSI_VDMA_CLK 46
+/* clock-gate 47 invalid */
+#define BLZP1600_I2S_CODEC_CLK 48
+#define BLZP1600_DMA_CLK 49
+#define BLZP1600_QSPI_PCLK 50
+#define BLZP1600_QSPI_CLK 51
+#define BLZP1600_I2S_TX_CLK 52
+#define BLZP1600_I2S_RX_CLK 53
+#define BLZP1600_I2C0_CLK 54
+#define BLZP1600_I2C1_CLK 55
+#define BLZP1600_I2C2_CLK 56
+#define BLZP1600_I2C3_CLK 57
+#define BLZP1600_I2C4_CLK 58
+#define BLZP1600_UART0_CLK 59
+#define BLZP1600_UART1_CLK 60
+#define BLZP1600_SPIS_PCLK 61
+#define BLZP1600_SPIS_CLK 62
+/* clock-gate 63 invalid */
+#define BLZP1600_TSENSOR_CLK 64
+#define BLZP1600_VIDEO_E_CLK 65
+/* clock-gates 66-67 invalid */
+#define BLZP1600_VIDEO_D_CLK 68
+/* Special clock-gates */
+#define BLZP1600_NIC_CLK 69
+#define BLZP1600_NIC_HALF_CLK 70
+#define BLZP1600_ETH_MAC_M_CLK 71
+#define BLZP1600_I2S_MASTER_CLK 72
+/* Clock sources */
+#define BLZP1600_SRC_XTAL_CLK 100
+#define BLZP1600_SRC_PLL0_CLK 101
+#define BLZP1600_SRC_PLL1_CLK 102
+#define BLZP1600_SRC_PLL2_CLK 103
+#define BLZP1600_SRC_I2S_CLK 104
+#define BLZP1600_SRC_CSID_CLK 105
+#define BLZP1600_SRC_DSI_CLK 106
+
+#endif
--=20
2.34.1


