Return-Path: <linux-kernel+bounces-122063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D46C88F16C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047EC29FA30
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E4F153806;
	Wed, 27 Mar 2024 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b="luGaqH78"
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BD114D2AB;
	Wed, 27 Mar 2024 21:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.242
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711576610; cv=fail; b=DuQDRi/rE8sVpl6BYBip4KZh59VanjoYeGuGo3Pv3iEmIyZbZkUmIg/ZvDcbjO7ihBlREmphSCaeRStlDBV/WMBKUjzWjbGFNYqZU2qGlqv30N9399kVJSAI4whSTIpuI6AeAMfeIWB/d7PdyusjmqyLtvgi2utZJ1AL8BEUAhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711576610; c=relaxed/simple;
	bh=5asUPYl1vXWW7N0jGMd7tTIlwJYRcQZ8JGLTDFMQjYI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lGdrzbWaGWpIQ41UZG82K77saDKrrK7iu2Rq3mD2kvond7DZql8foBt+a+P5a62VLmRKEnd/lvFB6Pkq+MC6eWUphdr5sR5ofVIzfLOm3OaB8cdJ5MlDF6ZSNrBpEgiREe7pnDPMe8IhEujd3Y9KwhpvwMYVH0qMsDT2YKyFYig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com; spf=pass smtp.mailfrom=epam.com; dkim=pass (2048-bit key) header.d=epam.com header.i=@epam.com header.b=luGaqH78; arc=fail smtp.client-ip=148.163.137.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epam.com
Received: from pps.filterd (m0174682.ppops.net [127.0.0.1])
	by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42RGbawC032613;
	Wed, 27 Mar 2024 21:04:17 GMT
Received: from eur04-vi1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51])
	by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3x4q50rh0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 21:04:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtNPd+yiUkXj1H0+pq8DsT8FZnTIQRt9LTgaSRxFhOsX7opgYQN0izxlW7KMDSZ+qqVsWzIx9eAKSEsgdTxde9fdxl4svMW6xTCo6fClf+Z89cfedjjjarD71d28NCeTX3Lkl/e3g6nOhRvpf1+gH/+SaOekIGn4fh2fKj/9pozLW3cl8ActL6XUZh6H8PH6UwFNmh0Kvcn0V+QcPs2WWfriKtATq20ZdJMlSEjRvIR1DFpkoy4ytJP48cQ6OK81+bWWkDGAy7bjkyKNg50aZQfxv/TvV95C6cymzm7/V4g2jUPhtAw43477VC+ixcXsYFgDXAh0oAwp0uwquQDe0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5asUPYl1vXWW7N0jGMd7tTIlwJYRcQZ8JGLTDFMQjYI=;
 b=AQ6ndYNQOKk9Y2kMUOFwcA+J4P+nhBMUegnzMcNPd8wbULcyR6BSmD2sHCnBAth7VQuHFcf6nHEqHIUgS/ooYyrzU4sCEw/EHEpxAVyfXZ0jybvjBjtdNY7M8o9yEfMZTgyw6Bzfigu5oqozMZSBj4Qg6F0bG+Bl1JC29sHsV6Wf6lFV1Hv1UQJC0JJku2fPeE9pErSrvlf5MJg43wr5na1NYforWjzE/5GGAoxAw3X6cOeFxnXENlFTZ8yUlOkooYGM6XveqrPOA7YYMyWtbppAv6S8QAexo8GovS8+YSkCOF6Baq0JZFhgsgnd98fH/eIlTe6+KoYV7mqspTuisA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5asUPYl1vXWW7N0jGMd7tTIlwJYRcQZ8JGLTDFMQjYI=;
 b=luGaqH78Z8KMaZYNVCnBzBHEcL/9gT0GdI8CcVwJsZW99iw+dY2hnlgQZbT0JSFhjRKvT4LI8yGwqc7STs1GppisPyQ2ThrU7hdTBg1kCkSy2K13YRkvxx2j8th1abELISMFXHQWgu8lULibTgzmDgpetnBm/p0bkiqjjcxWRxrlklP1j+TxP/o/EENuVyhOpxpBX4it9UJXgdd1IRZz/HYRuDxmU9m5kO3jHN2oAcfeTlzESJdFeHl3+aIQJqMqeBK78alUCmiW1xNT7kBXZEIyK2ajZ1R9OxD3c5jxnljMlBsaa7Wz3ns+wAEVJ7MNqL7N5wuxqcS+D5yOtgANxQ==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by DB9PR03MB7227.eurprd03.prod.outlook.com
 (2603:10a6:10:1fe::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 21:04:14 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::74c9:2488:1dd7:b976%3]) with mapi id 15.20.7409.028; Wed, 27 Mar 2024
 21:04:13 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Caleb Connolly <caleb.connolly@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob
 Clark <robdclark@gmail.com>
Subject: Re: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
Thread-Topic: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
Thread-Index: AQHagIKviCrPH112HEOpsjr5BCtYWLFMDkOAgAAEYgA=
Date: Wed, 27 Mar 2024 21:04:13 +0000
Message-ID: <87a5mjz8s3.fsf@epam.com>
References: <20240327200917.2576034-1-volodymyr_babchuk@epam.com>
 <e0586d43-284c-4bef-a8be-4ffbc12bf787@linaro.org>
In-Reply-To: <e0586d43-284c-4bef-a8be-4ffbc12bf787@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.10.7; emacs 29.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|DB9PR03MB7227:EE_
x-ms-office365-filtering-correlation-id: 5b06d9b5-db31-4bc4-b5af-08dc4ea174a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 TkyCPWg+SB2MddGLWmJw5DPVRtFEKU3AGj13UrIv/l9c9amyVQioK0jWCg4EqD8dMMFTQzJAVQU+6VkgU1SDu1GPxdvdHIth6AAlp62EgOqgFMYT9IEcfFgX3oQbTeO2u6HeGlkuSYKHy/XKsrrKaJ72AXM7gzXCfqJKwMDb83wzJ7aCt/g3a7Sgn+qQBu4XypUGesZaWkHKWGj2mo2OpX2BJkJv5PGJ81FK349Ot4UUPKj7AU2CGq3ED1g6t4RYTrNjLUXylmnQ35nVM/GgKR+E+9KdPJhiNb4vAkmOkBOXBc/G3aw0U6kCv4n5ObS5/bHxSUu5crqfzDhg9SjYeuzrB2sGJIsALOyjeveEyhc0AtpoBluvpfI+fHLdSjgH/p5d4Zc5egnlHHt5rbNPYSkRX3PRybJNOvCXy+6YfEiQIsNUyxj1npINQDJW/Tw8cYx8umomlg8sea5cMZslaVpKAxW+PJOIBBdKRyXuxq8GVZxkXn//4wXB1Vhezsvgtn2oRR7t+njRaUuENbrxOCqao0Y8L1vbLrygfAYMKIbtsWxjcmZz4/YXhCuXIPewe3nfVTvMSIPy9/DmxEZ6bbvtwf2eE7vXmPl6wf8PFdtaq43BUeMUFbsLOKp5LQMaK/3IpGYVHNB74j1pz1oKpazBUrcdX3z5EVDHMzpqblPsixb1USZ6yZ2aESFebW6G4mvMjIZgWNnvlhJHkGgaviNHbTA2+Uw3IP1vagsZ+FY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR03MB10456.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?y/MNfGEpMZGTLDayiKWRS8JElzfJTSmfE2C/bjrUm4cz5OlGEZ3umhOvLY?=
 =?iso-8859-1?Q?ybWIpGsRj3aGFWN0Wxds5wEELNDF95yWbleiROf8ZQQ5gLffnDdAXhHABG?=
 =?iso-8859-1?Q?+u/1+Rm30rT/AjpKLu98Yf7hEUeV3ihvr2Hq963XBKlYSXpwQRwBux3j5Q?=
 =?iso-8859-1?Q?sao9H2xlHU7spfo2SWSnKUdMQwzEny1eZJIDWmqlreIRRKnMYhjfVMizUy?=
 =?iso-8859-1?Q?QnsVwAbCbAxblaYySIKHi0LyK3Lr1VhGbwUJi07lnq+XNTUUhEwi9URsxc?=
 =?iso-8859-1?Q?VjK6qcWoLBhD15J1/Y1LtWzY+Lrj6+/LvglGm/4ksdkT2kQRWZMWct+CCU?=
 =?iso-8859-1?Q?geCZ0x5Lx1k4qp+F1TKf9q6Fh51sRRG1l8V020DDpVqiQHE7Enj/dritem?=
 =?iso-8859-1?Q?pHyHvS2rH7Bt7cDwtc+QBYKcXNDPOvhADuwbIZo4EEOmtsJKMVfg13QBlP?=
 =?iso-8859-1?Q?oWz2wSVh+qMBUbGV3qAdpfgA9rgejxnENR5LYl9xyC4jM9DjKPBb5FgHcu?=
 =?iso-8859-1?Q?gLsciy/5qozvRAZBP6V1iphSTyQNFwa14JjTBnLZd1piStL3V6xHV5xvkx?=
 =?iso-8859-1?Q?rtPKzSDpCaeLyTjQCTtM5zB5vKC5QB30Bb37k1smb1x9NjuEGQATn7hLDh?=
 =?iso-8859-1?Q?07oY3XaGEp2U7Zrh98J9SXdk8Udm4rBoW8EXsBCJ/o/nvDXo7KQZINpCWr?=
 =?iso-8859-1?Q?bybHTOYwfEK6Yf4r93RNpzzCkA0KFkpAGX36jDi+y7fTrE5gnbgdMFsPrZ?=
 =?iso-8859-1?Q?WTF2K5iNFV+MysdjkFr8E2SKDVaA/QcHIGagRfRF9h8LmJ6P6R1pouWh2v?=
 =?iso-8859-1?Q?V05ljPD2WWvsyse3JVGiyn5WmIl/obsNJjydREO+QGBy8jzWZkasPjR9kW?=
 =?iso-8859-1?Q?ryXfeypeMGIDUsgKYn/v9KpfleVnMiEHcl+5Z9y2qNay5ljB4j/BPMonzy?=
 =?iso-8859-1?Q?DDfdWt/F+i7dJ5nqvDpL/yGiP1fDEiDtaF9ILvHOfl3h37otChmDNQFmgb?=
 =?iso-8859-1?Q?rUM55T3npb/nH09Mj1Kpp2zlKGLYqjKdhx1DkZ2SMuCaqC0WfqopIs/60S?=
 =?iso-8859-1?Q?GNtubu9Syh5uRWm9LWsAj7BkjZShy/WgvOHBl2W8NLhHHVtnxykFa86sDO?=
 =?iso-8859-1?Q?ReqTWqYhLeE140t0NAodzXOJsbcUU9D3YKYoDTNj6X0TV+2hyX9p6C7yIh?=
 =?iso-8859-1?Q?lHPrwOL27oTsGjiMTTPNPnX1UJfT3mh8yctKo4IFALyNi6Dlfbvfs9FzAs?=
 =?iso-8859-1?Q?3nTIBSibapZvqLB/F9NPJp+lbQcYgcUcminYCh+vKPqpD+vUmVHjwgDH9n?=
 =?iso-8859-1?Q?Bx7RhNnMXMMSS27fPGVwwSJwNXmEyzY/wo8V3qTSGB8vSvf4SykFsSJDXT?=
 =?iso-8859-1?Q?RqCbMznmCth2hLYsOZHv8fba3ahWIZNUSpiijsP5WCaLm18GS0RM+KYsb9?=
 =?iso-8859-1?Q?AAAB6hR+SVq8W6vZfldEPFXP0d5yumOILjuFS0AQZpgXfeAts2/+Luitpp?=
 =?iso-8859-1?Q?b2Ls8zKvBb/9QhbIzkYuaWZeNfABVoq3fpzdCgi9IHx1tebdq51dYy3EoO?=
 =?iso-8859-1?Q?7SUUut/2iVDCFXkWl6owTFa0D0FfiYJU+lKPOGhgD+IJ0k2+T9B/99NMkg?=
 =?iso-8859-1?Q?MGFcqyToe9+pRxeMEe/9JLto7/zu5UOpXCF+LrnFGBNBQJUOtvZVGFZA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b06d9b5-db31-4bc4-b5af-08dc4ea174a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 21:04:13.3141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ieyzz0Py4ChcHca82pe8Bmbw2/TOEpBF6lDNmyt+11XgUXpBK4PAH2k2JnPrMvJvxBUJFT4X/iN8x0xFabkYJY++TClVCTPE6ilVLl2AMlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7227
X-Proofpoint-GUID: D87HMTI_2x9DmDAUEDPMEOc7Oqksf5aC
X-Proofpoint-ORIG-GUID: D87HMTI_2x9DmDAUEDPMEOc7Oqksf5aC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_18,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1011 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=847 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270149


Hi Konrad,

Konrad Dybcio <konrad.dybcio@linaro.org> writes:

> On 27.03.2024 9:09 PM, Volodymyr Babchuk wrote:
>> It appears that hardware does not like cacheable accesses to this
>> region. Trying to access this shared memory region as Normal Memory
>> leads to secure interrupt which causes an endless loop somewhere in
>> Trust Zone.
>>=20
>> The only reason it is working right now is because Qualcomm Hypervisor
>> maps the same region as Non-Cacheable memory in Stage 2 translation
>> tables. The issue manifests if we want to use another hypervisor (like
>> Xen or KVM), which does not know anything about those specific
>> mappings. This patch fixes the issue by mapping the shared memory as
>> Write-Through. This removes dependency on correct mappings in Stage 2
>> tables.
>>=20
>> I tested this on SA8155P with Xen.
>>=20
>> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>> ---
>
> Interesting..
>
> +Doug, Rob have you ever seen this on Chrome? (FYI, Volodymyr, chromebook=
s
> ship with no qcom hypervisor)

Well, maybe I was wrong when called this thing "hypervisor". All I know
that it sits in hyp.mbn partition and all what it does is setup EL2
before switching to EL1 and running UEFI.

In my experiments I replaced contents of hyp.mbn with U-Boot, which gave
me access to EL2 and I was able to boot Xen and then Linux as Dom0.

--=20
WBR, Volodymyr=

