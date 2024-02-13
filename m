Return-Path: <linux-kernel+bounces-64143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81436853AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32EE628B3DC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D1F1CD22;
	Tue, 13 Feb 2024 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="oStqw0xg"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D4111A1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.152.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851771; cv=fail; b=ksoj7buJW7k0soWPrQ1NK2ReeNYK4CkGP4bQa0oeN75BUvkoyLoqqQpJHgVJCsdbFH4eBSwvWpigp0WaGPh982iaOU6W0HgJe51hroMX7UON5oek2ENyygo9ZtYoXOAIzuWoiYq1qqFj/95f0PH6BduJe6AMjlxc6lRGlDFDjG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851771; c=relaxed/simple;
	bh=PoNxUweqSYrJRf4KKW2MZ+V8sBzKE/BjE133EFMuLG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qo3ZIkdOGorgl9otjVkp1d1yDvDELzfPv6A/sfjKLts3OeFv84TcfTKSLIVSeMWeobI4WwJBXIaqk8acYY1HUSMgEgDBDWoTMh/1g/A/cQPWP/hg0WkRmBfO+DPyIyYuqcldLjHC/OMbhe7A9+O8HK920bpwfU996nTglh2drBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=oStqw0xg; arc=fail smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355090.ppops.net [127.0.0.1])
	by m0355090.ppops.net (8.17.1.24/8.17.1.24) with ESMTP id 41DHlabr018727;
	Tue, 13 Feb 2024 19:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	DKIM202306; bh=PoNxUweqSYrJRf4KKW2MZ+V8sBzKE/BjE133EFMuLG4=; b=o
	Stqw0xgp13gRDcYJfhVnyDcxXWbTD0nvA/56uTfAjiklMm/OmmSNzpF3QqNjqNNS
	QyxM7yUZa/U4oXGTWyUqKyEUHcn6kNyRwOnQZzAfcXWZsHCg1dfM3C62r4AsHlTS
	VrxV98TCkdHsHf84Ph51CZIFaJJ0d88xwXbJX6dxO54DGUqj7fsa7gkhuT+QP+eZ
	Xj7MqilzXSuMDkyRVUDZkfSmE18QyadluvnXLmXgl8ieQAJC6lmpCPb5iYGL/NR/
	m/0pjLdNr+X3qNQZP1kKglNQlmH9uFywb1YRaKEh/r3i6Jg+enQ8buYI11TnbHSH
	R2nFkHvMhW+xtATrnSaZA==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2041.outbound.protection.outlook.com [104.47.110.41])
	by m0355090.ppops.net (PPS) with ESMTPS id 3w88298ufk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 19:15:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mu+n4iYmU0r4Qa8oeRN9cNbtqegW/TQetYYNNHAhOEgI8C7q8qJU+z6erz+PubSWXbfHhziFCiyHRTRtvP379bg3Xtd82LYG+bak6il+C/9kOISWug3/mNUPAi9jixMZNExFEYM8/j6WHIAronNc44GLE/4b3QXjA2OcjWx288IL21xWfrPtnc3knnHHdP1c+czhKLAOyhkDom+YPN1uGxkmp9RKgTiMsacyn2w9bzGDOjB6qGzEl3izTzbdJiabxZesNHxW5kO8bcCvLFtavLLB2SoD4cTvyFReXnxwaTdJBDpfGvwOqiftg3xMZL0H2TVemuMnOWd4J4lYGfxhuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoNxUweqSYrJRf4KKW2MZ+V8sBzKE/BjE133EFMuLG4=;
 b=bd/7onOuPDS3QUHGr28RDc31Bt5oIBr1FX+SKOU45XFyroj8MjNNbqFrQJk3QOhM8xhG/UO5mZF6TzHhFf4WtiolY+ZYYC2qgs9i/qL6mBtBYjBJdBvmyHKNlMGu2xUBQHiNU5sgIZOxo8wlhRz1xsIMhLlDjLO4Lh7qtrkzzaWbfwE/gKyWUcSSGVjuQQU0VO4JsAMbLFVi+Q3JWxL11WmP0bXH6KzDC/vDl+3RNjE7E/ZmETAIKt/cfNX73q+CvAN22AJcyEFd8mMXo8tEfOiV5cOGHcmfSpg7MR4kYNN49AuJrKXeE1jB99YmttMLuZzGeNzE0iGXyqBp3rAKww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com (2603:1096:101:66::5)
 by SEZPR03MB8893.apcprd03.prod.outlook.com (2603:1096:101:252::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Tue, 13 Feb
 2024 19:15:08 +0000
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::dbc8:b80e:efaf:2d74]) by SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::dbc8:b80e:efaf:2d74%6]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 19:15:08 +0000
From: Maxwell Bland <mbland@motorola.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org"
	<will@kernel.org>,
        "dennis@kernel.org" <dennis@kernel.org>,
        "tj@kernel.org"
	<tj@kernel.org>, "cl@linux.com" <cl@linux.com>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "shikemeng@huaweicloud.com"
	<shikemeng@huaweicloud.com>,
        "david@redhat.com" <david@redhat.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "anshuman.khandual@arm.com"
	<anshuman.khandual@arm.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
        "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>,
        "pcc@google.com" <pcc@google.com>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gshan@redhat.com"
	<gshan@redhat.com>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Andrew Wheeler <awheeler@motorola.com>
Subject: Re: [PATCH] arm64: allow post-init vmalloc PXNTable
Thread-Topic: [PATCH] arm64: allow post-init vmalloc PXNTable
Thread-Index: AQHaXrD0JRNfqROm3Uev/Znaoa6kew==
Date: Tue, 13 Feb 2024 19:15:07 +0000
Message-ID: 
 <SEZPR03MB67865557061A2494B1A1243CB44F2@SEZPR03MB6786.apcprd03.prod.outlook.com>
References: 
 <CAP5Mv+ydhk=Ob4b40ZahGMgT-5+-VEHxtmA=-LkJiEOOU+K6hw@mail.gmail.com>
 <ZcurbvkUR-BoGTxu@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZcurbvkUR-BoGTxu@FVFF77S0Q05N.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6786:EE_|SEZPR03MB8893:EE_
x-ms-office365-filtering-correlation-id: b89a6aa2-ca70-4761-eb89-08dc2cc81771
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 h3WoNhyWT4F9+FQQvD49mILy/6+8OPiDmg6w5QiuNAUsKke3l1ck3w47g1/oZqQtRmXLDUG7rmKQE9o21KyWH1X2hVi7beLalXSDNuqwtL+E0xjOsNOdPgLiI7vpRyRI5nEdDjqCMPnv8SBUTJIO0pQfX4VAh63X9ZUDOgvTd/R2qy5Wvxk7p5meqaeylwNnrkjPXRMVPjaKibYRvkpzMExN2hFLilVmlfDAq5rjHDdCq4G21SOwX58ZAINIQhqD+17YY+/uoOsD4/XDbmbpFWWd4qkHREgxUFxy4RLN1o98ER9gP98hKdHR5Rktz4Te7i80P84owskuMlRuO8mAKdsQFnjdUgQIAlMQEKcUbNY7RvHQeZuaoR4+hvDwrF5cHoUUhAQaxVEYxBXGgOpQ4eUJwyS9fdzjtasagEAnF0ZTxDgbSYyabFKOERAhFrOaYNIL89EB6AztiCshRD950DEFuOgZOQy5TRl/Oe3qenjpXLGxXnKFuZaIVgFTDkQwck+BWlubMDFYWTPdkgt47B5XATgaHEDSqfS/4U9bK24BkcTEXUAzt18redMpnGiMbKMU/fn22LkQ4/KRF+GD+zy1jM5ZMXeNSZmW4tA+Uvs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(55016003)(966005)(6506007)(38070700009)(9686003)(2906002)(7696005)(33656002)(7416002)(82960400001)(66946007)(86362001)(76116006)(66556008)(122000001)(38100700002)(6916009)(478600001)(54906003)(71200400001)(66476007)(4326008)(316002)(83380400001)(107886003)(66446008)(52536014)(5660300002)(8676002)(64756008)(8936002)(26005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WlRZTHk5RHJieHJNWnVucEpHaHk1TDBxME1yTWF0V2pncVhIS0dNaVFYMFJl?=
 =?utf-8?B?eHpja3c5cWV1QUt3eWw3YVdhU002SzFxdEprR0U1cTRaQlJKZzcyd2cvdHl1?=
 =?utf-8?B?M3pKODVXSkdwSGgzaHZoamVmaWlhY014anNHR2R1OEZnUXRTL000ZTVjMGlC?=
 =?utf-8?B?RnpVWVNGeTNlRDl3QStjS2lGaG1uY2xBYjRaczFPRVRjcHFxY1FENWsvSEVy?=
 =?utf-8?B?a3lmUVc2WHdiQW4vMmpyc3VRQUovZnk5Mm5aR0JHUXB4cFlJZ1F6azVpVkIv?=
 =?utf-8?B?Mm04akpaY2FzREhnSG9idG1WcXM4WUNUYmZ3eTlJSXMwcnA5VWRHRFJrZ3BG?=
 =?utf-8?B?TnhFK0pPbHc2eUFZRi95MFBYb0YvZmxnKzRzamEyT2ZDUkI1dy9nbTR1YWxi?=
 =?utf-8?B?OW8yeWpueFpPdllsTjJKeVFTUHdaSzkwV3JaenRMNXVPWlQ3d1BqOXNnOVYz?=
 =?utf-8?B?a1JFOU1xR2twcXZZWWNFaTF1ZDUydkgzOThCZythcDNWK3lwMGNrSmxHOVdS?=
 =?utf-8?B?a3dWYUJ2dWRsbXdNY1lub2RvY3lDMnNzU1NZc1lQSUZVdlA0eVQvdmVTL0Fo?=
 =?utf-8?B?YnNCczNUWDhLUHRCQm1ldnUwOGZKWUlJbmhma0QvandKdy94alpiaTlCQmtK?=
 =?utf-8?B?MU5RMFVUNUlXSyswM1NtaXZIOUljbTZqdU1jV0Foc2RhSGhpSjBlOE1QTlg5?=
 =?utf-8?B?SlRTQlRuK1dYdFM2YmlRQnMyMi92b3hWd2EvY09QYVd6SGI1R21iaVpBd0N2?=
 =?utf-8?B?SEt6RUNoWkVGM3JCbFJPSWhGK2dpVW5PVEhvbm9KUktMK0lSbW1BSnlsYWFz?=
 =?utf-8?B?RkR3Z1ZERjhjam5mZDBPUUVHWTBpSk91d3JBMGVrcllESzhtTGhsVGtVdEEv?=
 =?utf-8?B?bklwdUVXbURNSVF2ZS9pT05jaGJEMWlaanh1cUZzQ2FRUExDVWJRczg5dlRO?=
 =?utf-8?B?eDduWEp6R3VtS1FpRExPUmNqR1Q3U1d3dUUvWi9IekEzc2RKY1ZLeXNDaTIw?=
 =?utf-8?B?c1hJbkhSTXU2MjRUOGM0ZUt1MlRCSk8va2tNUWFEUUJzTG9jN3l4dEV3akdi?=
 =?utf-8?B?NHMvVUNUMXFteC9xM1Bxd2NkaVpaNlRrRVd1MlpWdjYwbzJGTHNiYW00bDhz?=
 =?utf-8?B?MjJzajduZ2dJcTQ4WEk0WCtLZFVqK3hobFVMZ0tpSTZmWEV5WXpRcVBUNmpD?=
 =?utf-8?B?OUZVOFVHZkkyUGswY1RiNmFXVWRtQU1hT0ZrRmxmUGtiakR1Y3VOOUdlaVA3?=
 =?utf-8?B?emE4V2pWdUZZYXdwWnR2VnFwYXJMZDY2dXpHbnRMUld3TFRFRTk4WW5BYnd4?=
 =?utf-8?B?OFNZT3piUnFQL2NyN0hiUHNkZGZmVGpoc2pmNDRwMC9aa1pKME5PSlVJUmZP?=
 =?utf-8?B?SGtpUGJqZlRzUHFURWhrSUhCMnh4aFVSLzI4dnAzd0ZnTXA4Z1laTXRhdjNY?=
 =?utf-8?B?WStaRmNUTWVWa1lMcW44QTRObW8yV3Nxb2dNV0lmTVcxbk5jUjBqaWY1RStX?=
 =?utf-8?B?MTVISndLeWcreDF5b2dPR2ZseUhLb1MzYXpXT3ZRTFVESjhaV1F4ajdsT0ha?=
 =?utf-8?B?cUFReDlMbHh4OEJZSnd0VGs4OFZWMmg4VGhnU3pnczR1MGtlUXpHeU96RXBQ?=
 =?utf-8?B?K2YrSitxVUc3dXE2VE0vNDdheUk5ZHUxZi8rSWIzNXlFM2VGWkp4eXVNUHpl?=
 =?utf-8?B?MlZDUTgvMHdJTzVRZGMvYXZ5eW84UnFnR1FlSExDU3czbGs3eGE2dGRoZnVJ?=
 =?utf-8?B?UWVLM2JqTHRyeER1S2IzWEVORGxWTkQ3dTRsL2grSnZPTnFCWjh3QUw2WHlI?=
 =?utf-8?B?TTBhWGVGd3BqQnE4SGlsbnRxdnFVeCtpc1UwckhEVWlPNjQ0MWkvSVBaenlJ?=
 =?utf-8?B?MnpSNWE5a0RtRXhtWkQ2SWdyVHlEaFlwQVh3OUMyZmdjSWRNMlRubTlSY0x2?=
 =?utf-8?B?bUJCd0h3eVhrRzcxeG1DRVpIZk5meWg0eDhjdDFJMU5ob3EyVXB0UDlDQnhX?=
 =?utf-8?B?YVQ4UklRL0llRVlDS0ZzS1A5akM4WGxQRXZ6SUNrandBUHZDaEllV3UzUTA0?=
 =?utf-8?B?R0EyZkozL2F1bzh4RGlwTW1LMFJkZW5kTjlWZFU3MVhqT1NmMW1YL3Z5ZjNw?=
 =?utf-8?Q?xV84=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: motorola.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6786.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89a6aa2-ca70-4761-eb89-08dc2cc81771
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 19:15:07.7873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JwbloDEoHaLryCidQce+TkZC+amAbS+DFyppiBdQsQn77gHLotRS5bzxuNQqOZIvqbsbLRhYi+tAwZs1hFRpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8893
X-Proofpoint-ORIG-GUID: niGg3a5mR1kWcxE6VVeNXmGBuxsqw8dq
X-Proofpoint-GUID: niGg3a5mR1kWcxE6VVeNXmGBuxsqw8dq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_11,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130152

PiBGcm9tOiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPiBPbiBUdWUsIEZlYiAx
MywgMjAyNCBhdCAxMDowNTo0NUFNDQo+IC0wNjAwLCBNYXh3ZWxsIEJsYW5kIHdyb3RlOg0KPiA+
IFZNQUxMT0NfU1RBUlQgZmZmZjgwMDA4MDAwMDAwMCBWTUFMTE9DX0VORCBmZmZmZmJmZmYwMDAw
MDAwIF90ZXh0DQo+ID4gZmZmZmI2YzBjMTQwMDAwMCBfZW5kICAgICAgICBmZmZmYjZjMGMzZTQw
MDAwDQo+ID4NCj4gPiBTZXR0aW5nIFZNQUxMT0NfRU5EIHRvIF90ZXh0IGluIGluaXQgd291bGQg
cmVzb2x2ZSB0aGlzIGlzc3VlIHdpdGggdGhlDQo+ID4gY2F2ZWF0IG9mIGEgc2l6ZWFibGUgcmVk
dWN0aW9uIGluIHRoZSBzaXplIG9mIGF2YWlsYWJsZSB2bWFsbG9jIG1lbW9yeSBkdWUNCj4gPiB0
byByZXF1aXJlbWVudHMgb24gYXNsciByYW5kb21uZXNzLiBIb3dldmVyLCB0aGVyZSBhcmUgY2ly
Y3Vtc3RhbmNlcyB3aGVyZQ0KPiA+IHRoaXMgdHJhZGUtb2ZmIGlzIG5lY2Vzc2FyeTogaW4gcGFy
dGljdWxhciwgaHlwZXJ2aXNvci1sZXZlbCBzZWN1cml0eQ0KPiA+IG1vbml0b3JzIHdoZXJlIDEp
IHRoZSBtaWNyb2FyY2hpdGVjdHVyZSBjb250YWlucyByYWNlIGNvbmRpdGlvbnMgb24gUFRFDQo+
ID4gbGV2ZWwgdXBkYXRlcyBvciAyKSBhIHBlci1QVEUgdXBkYXRlIHZlcmlmaWVyIGNvbWVzIGF0
IGEgc2lnbmlmaWNhbnQgaGl0IHRvDQo+ID4gcGVyZm9ybWFuY2UuDQo+DQo+IFdoaWNoICJoeXBl
cnZpc29yLWxldmVsIHNlY3VyaXR5IG1vbml0b3JzIiBhcmUgeW91IHJlZmVycmluZyB0bz8NCg0K
UmlnaHQgbm93IHRoZXJlIGFyZSBhcm91bmQgNCBvciA1IGRpZmZlcmVudCBhdHRlbXB0cyAoZnJv
bSB3aGF0IEkga25vdzogTW90bywNClNhbXN1bmcsIE1lZGlhVGVrLCBhbmQgUXVhbGNvbW0pIGF0
IG1ha2luZyBwYWdlIHRhYmxlcyBpbW11dGFibGUgYW5kIHJlZHVjaW5nDQp0aGUga2VybmVsIHRo
cmVhdCBzdXJmYWNlIHRvIGp1c3QgZHluYW1pY2FsbHkgYWxsb2NhdGVkIHN0cnVjdHMsIGUuZy4N
CmZpbGVfb3BlcmF0aW9ucywgaW4gQVJNLCBhIHJldml2YWwgb2Ygc29tZSBvZiB0aGUgaWRlYXMg
b2Y6DQoNCmh0dHBzOi8vd2VuYm9zaGVuLm9yZy9wdWJsaWNhdGlvbnMvcGFwZXJzL3R6LXJrcC1j
Y3MxNC5wZGYNCg0KV2hpY2ggYXJlIG5vIGxvbmdlciBwb3NzaWJsZSB0byBlbmZvcmNlIGZvciBh
IG51bWJlciBvZiByZWFzb25zLiAgQXMgcmVsYXRlZCB0bw0KdGhpcyBwYXRjaCBpbiBwYXJ0aWN1
bGFyOiB0aGUgcGVyZm9ybWFuY2UgaGl0cyBpbnZvbHZlZCBpbiBwZXItUFRFIHVwZGF0ZQ0KdmVy
aWZpY2F0aW9uIGFyZSBodWdlLg0KDQpNeSBnb2FsIGlzIHVsdGltYXRlbHkgdG8gcHJldmVudCBt
b2Rlcm4gZXhwbG9pdHMgbGlrZToNCg0KaHR0cHM6Ly9naXRodWIuY29tL2Nob21waWUxMzM3L3M4
XzIwMTlfMjIxNV9wb2MNCg0Kd2hpY2ggbW9kaWZ5IGR5bmFtaWNhbGx5IGFsbG9jYXRlZCBwb2lu
dGVycywgYnV0IHRyeWluZyB0byBwcm90ZWN0IGFnYWluc3QgdGhlc2UNCmV4cGxvaXRzIGlzIGRp
c2luZ2VudW91cyB3aXRob3V0IGZpcnN0IGJlaW5nIGFibGUgdG8gZW5mb3JjZSBQWE4gb24gbm9u
LWNvZGUNCnBhZ2VzLCBpLmUuIHRoZXJlIGlzIGEgcmVhc29uIHdlIGRvIHRoaXMgaW4gbW0gaW5p
dGlhbGl6YXRpb24sIGJ1dCB3ZSBuZWVkIHRvDQplbmZvcmNlIG9yIHN1cHBvcnQgdGhlIGVuZm9y
Y2VtZW50IG9mIFBYTlRhYmxlIGR5bmFtaWNhbGx5IHRvby4NCg0KPiBXZSBkb24ndCBzdXBwb3J0
IGFueSBvZiB0aG9zZSB1cHN0cmVhbSBBRkFJSy4NCg0KQXMgaXMgaG9wZWZ1bGx5IGFwcGFyZW50
IGZyb20gdGhlIGFib3ZlLCB0aG91Z2ggaXQgd2lsbCBoZWxwIGRvd25zdHJlYW0gc3lzdGVtcywN
CkkgZG8gbm90IHNlZSB0aGlzIHBhdGNoIGFzIGEgc3VwcG9ydCBpc3N1ZSBzbyBtdWNoIGFzIGEg
bGVnaXRpbWF0ZSBzZWN1cml0eQ0KZmVhdHVyZS4gVGhlcmUgaXMgdGhlIG1hdHRlciBvZiBkZWNp
ZGluZyB3aGljaCBzdWJzeXN0ZW0gc2hvdWxkIGJlIHJlc3BvbnNpYmxlLg0KDQpUaGUgZ2VuZXJp
YyB2bWFsbG9jIGludGVyZmFjZSBzaG91bGQgcHJvdmlkZSBhIHN0cm9uZyBkaXN0aW5jdGlvbiBi
ZXR3ZWVuIGNvZGUNCmFuZCBkYXRhIGFsbG9jYXRpb25zLCBidXQgZW5mb3JjaW5nIHRoaXMgd291
bGQgYmVjb21lIHRoZSByZXNwb25zaWJpbGl0eSBvZiBlYWNoDQptaWNyb2FyY2hpdGVjdHVyZSBy
ZWdhcmRsZXNzLg0KDQo+DQo+IEhvdyBtdWNoIFZBIHNwYWNlIGFyZSB5b3UgcG90ZW50aWFsbHkg
dGhyb3dpbmcgYXdheT8NCj4NCg0KVGhpcyBpcyByb3VnaCwgSSBhZG1pdC4gKS06IE9uIHRoZSBv
cmRlciBvZiA3MCwwMDAgR0IsIGxpa2VseSBtb3JlIGluIHByYWN0aWNlOg0KaXQgcmVzdHJpY3Rz
IHZtYWxsb2MgdG8gdGhlIHJlZ2lvbiBiZWZvcmUgX3RleHQuIFlvdSBtYXkgYmUgdGhpbmtpbmcs
ICJ0aGF0IGlzDQpyaWRpY3Vsb3VzLCBjJ21vbiBNYXh3ZWxsIiwgYW5kIHlvdSB3b3VsZCBiZSBy
aWdodCwgYnV0IEkgd2FzIE9LIHdpdGggdGhpcw0KdHJhZGUtb2ZmIGZvciBNb3RvIHN5c3RlbXMs
IGFuZCB3YXMgdGhpbmtpbmcgdGhlIGFwcHJvYWNoIGtlZXBzIHRoZSBwYXRjaA0KY2hhbmdlcyBz
bWFsbCBhbmQgc2ltcGxlLg0KDQpJIGhhZCBhIGhhcmQgdGltZSB0aGlua2luZyBvZiBhIGJldHRl
ciB3YXkgdG8gZG8gdGhpcyB3aGlsZSBhdm9pZGluZyBkdXBsaWNhdGlvbg0Kb2Ygdm1hbGxvYyBj
b2RlIGludG8gYXJtNjQgbGFuZC4gUG90ZW50aWFsbHksIHRob3VnaCwgaXQgd291bGQgYmUgT0sg
dG8gYWRkIGFuDQphZGRpdGlvbmFsIGZpZWxkIHRvIHRoZSBnZW5lcmljIHZtYWxsb2MgaW50ZXJm
YWNlPyBJIG1heSBuZWVkIHRvIHJlYWNoIG91dCBmb3INCmhlbHAgaGVyZTogbWF5YmUgdGhlIHNv
bHV0aW9uIHRvIHRoZSBpc3N1ZSB3aWxsIGNvbWUgbW9yZSByZWFkaWx5IHRvIHRob3NlIHdpdGgN
Cm1vcmUgZXhwZXJpZW5jZS4NCg0KPiBIb3cgZG9lcyB0aGlzIHdvcmsgd2l0aCBvdGhlciBhbGxv
Y2F0aW9ucyBvZiBleGVjdXRhYmxlIG1lbW9yeT8gZS5nLiAgbW9kdWxlcywNCj4gQlBGPw0KDQpJ
dCBzaG91bGQgd29yay4NCg0KLSBhcmNoL2FybTY0L2tlcm5lbC9tb2R1bGUuYyB1c2VzIF9fdm1h
bGxvY19ub2RlX3JhbmdlIHdpdGggbW9kdWxlX2FsbG9jX2Jhc2UNCiAgYW5kIG1vZHVsZV9hbGxv
Y19lbmQsIGJ5cGFzc2luZyB0aGUgZ2VuZXJpYyB2bWFsbG9jX25vZGUgcmVnaW9uLCBhbmQgdGhl
c2UNCiAgdmFyaWFibGVzIGFyZSBkZWNpZGVkIGJhc2VkIG9uIGEgcmFuZG9tIG9mZnNldCBiZXR3
ZWVuIF90ZXh0IGFuZCBfZW5kLg0KLSBrZXJuZWwvYnBmL2NvcmUuYyB1c2VzIGJwZl9qaXRfYWxs
b2NfZXhlYyB0byBjcmVhdGUgZXhlY3V0YWJsZSBjb2RlIHJlZ2lvbnMsDQogIHdoaWNoIGlzIGEg
d3JhcHBlciBmb3IgbW9kdWxlX2FsbG9jLiBJbiB0aGUgaW50ZXJwcmV0ZWQgQlBGIGNhc2UsIHdl
IGRvIG5vdA0KICBuZWVkIHRvIHdvcnJ5IHNpbmNlIHRoZSBwYWdlcyBzdG9yaW5nIGludGVycHJl
dGVkIGNvZGUgYXJlIE5YIGFuZCBjYW4gYmUNCiAgbWFya2VkIFBYTlRhYmxlIHJlZ2FyZGxlc3Mu
DQoNCj4gSSdtIG5vdCBrZWVuIG9uIHRoaXMgYXMtaXMuDQoNClRoYXQncyBPSywgc28gbG9uZyBh
cyB3ZSBhZ3JlZSBlbmZvcmNpbmcgUFhOVGFibGUgZHluYW1pY2FsbHkgd291bGQgYmUgYSBnb29k
DQp0aGluZy4gSSBsb29rIGZvcndhcmQgdG8geW91ciB0aG91Z2h0cyBvbiB0aGUgYWJvdmUsIGFu
ZCBJIHdpbGwgZ28gYmFjayBhbmQNCml0ZXJhdGUuDQoNCldvcmtpbmcgd2l0aCBJVCB0byBmaXgg
dGhlIGVtYWlsIGZvcm1hdHRpbmcgbm93LCBzbyBJIHdpbGwgaG9wZWZ1bGx5IGJlIGFibGUgdG8N
CnBvc3QgYSBmZXRjaGFibGUgYW5kIHJ1bm5hYmxlIHZlcnNpb24gb2YgbXkgaW5pdGlhbCBwYXRj
aCBzaG9ydGx5Lg0K

