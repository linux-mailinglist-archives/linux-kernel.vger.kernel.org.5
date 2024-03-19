Return-Path: <linux-kernel+bounces-107607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EFE87FF11
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28B09B25089
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960A78063C;
	Tue, 19 Mar 2024 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="EDOdiuwf"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4A880030;
	Tue, 19 Mar 2024 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710856060; cv=fail; b=aCasVdGLJdjy0jIJrnX3BGVtvS1e95s0Xcv0H/5kgaNZe3wZGSfsV/BE1OnduHgyBgXQV48/FFpBfiaeNSbNmhjv95I3qy/a7VnCqyFf7FhIEUPm2MUNMbvsPh2s96kkwUEcZ4wQOjN98jEd1PHCyc5Tk3xn11a1MlEjL9/3wrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710856060; c=relaxed/simple;
	bh=ksuXVgVGxwpGCqu0ToYhg3BoYPqdT4w919uZqk/bKEE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k9ZuVf7d/a8lulhayLNulL0qyJ6t9l3q6ZgZUHk/NDAYsiUx6oHadaY19+dpCKKEIemBQmGIIwnKG5h+QuredOma3zM7XQWATh4ZDRpuBc0tm1i9zDxieKeU+GcAzXkYlyXLpNCtenno3pZ1JYj5Ws4h81MoLRNLDL9KRy9PpcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=EDOdiuwf; arc=fail smtp.client-ip=18.185.115.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.199.142])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id EFC49100004FA;
	Tue, 19 Mar 2024 13:47:30 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1710856050.111000
X-TM-MAIL-UUID: 4a666d9d-5a38-464d-a755-51decd8498f4
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 1B6D5100724AB;
	Tue, 19 Mar 2024 13:47:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mwk438XZ63MZeSoWTMwa/U3FWb9iElRCpwhOdZQvkUH/ur1m7flTPrAQN//0u1wHTApLNyIHZ2QGW/DSwEfAFghpDjwfWUNwuuBIHHH+j+0EVjTtQf/lUvAekzHc/TN3lip9x0ZS+DHKmifboeTsxb/3AP2xWFDD1TbxseqmyVjzvTRBXkAGpai3NJmJr8nkPr1wI+yNdmppNAHnSHehsnwh/Kfha/oOZBezMd0t+/Zp5jKFfcr+8Kz3adRj55oQ+lwCsNfTx9orT6jKZ2wZ9gEPYWbgVZGuaGCvQ81xUTp4tBj1kHCVyCa+piD/N/8YNvQ3TVqf6OPNOmnS/0JshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfo16+duAnva9osn7MDnuf+o8GW6xPOla0EL2HmR3vI=;
 b=HZ25GNb1UfCRhTi4WZtrcOcvA28UUZ2dfHhRx1+S4Ilj6yrQ4e+JaKpFWFyb3JQzYH8fE4Z5/2YCgESLeA4WwUNZHdqojtmf/xwq1d3sLl5YfNDkD2m7YYiKZ4hauVm83Yk7GcHT+NTQ4OzNVHECVa4vyy1/R4WHvwfRwgFKRtrYkRB6SMJ8tkQ5pnBWDx/mLrxrS8pDDhQe/cRMBO4gPSo/ahVc0TAJ5xTAgWmdKYRFlCdFOwCu23KWCkWiAhtBvzG7CxLO4iPH9bJ5eyjDeWgp08avLhuTu/flDeh62XaygQLfCPok/3q0Wb97xB6x6Ivgku69rxf9//BBmwsyPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Message-ID: <61364452-bdf5-4bd8-adb1-a9e6236c9d26@opensynergy.com>
Date: Tue, 19 Mar 2024 14:47:26 +0100
From: Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [RFC PATCH v3 0/7] Add virtio_rtc module and related changes
To: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, virtio-dev@lists.oasis-open.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Cc: "Christopher S. Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 "Ridoux, Julien" <ridouxj@amazon.com>, Cornelia Huck <cohuck@redhat.com>,
 Parav Pandit <parav@nvidia.com>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com>
 <0e21e3e2be26acd70b5575b9932b3a911c9fe721.camel@infradead.org>
 <204c6339-e80d-4a98-8d07-a11eeb729497@opensynergy.com>
 <667c8d944ce9ea5c570b82b1858a70cc67b2f3e4.camel@infradead.org>
 <f6940954-334a-458b-af32-f03d8efbe607@opensynergy.com>
 <57704b2658e643fce30468dffd8c1477607f59fb.camel@infradead.org>
 <d796d9a5-8eda-4528-a6d8-1c4eba24aa1e@opensynergy.com>
 <47bf0757de3268c420d2cd3bbffaf5897b67b661.camel@infradead.org>
 <60607bcc-93c5-4a6f-832d-ea4dbd81178e@opensynergy.com>
 <89268C36-E8FB-4A17-8F81-1DED4BF47400@infradead.org>
 <2eb5a616-eeb3-446a-85fd-fff376c15f55@opensynergy.com>
 <9455F710-E38C-45DA-9883-EC034495ADEF@infradead.org>
Content-Language: en-US
Autocrypt: addr=peter.hilber@opensynergy.com; keydata=
 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
In-Reply-To: <9455F710-E38C-45DA-9883-EC034495ADEF@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0024.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::37) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|BEUP281MB3759:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vW5rHTMaJPe2PgwF/PeIbdMeW5TjiOxMuEuSE0/y2ROS5JqfWQYw/M2M3PPyHi8eGScnay2Ejt7PgvRBsTkFeBNn1KIvBTwjZSQx49yG8SzD7AIMeFQ0VGTxS8pWzF6iV63Ob8QZ8Ztm81g+rnfZ32akVMJNj5KsYC3a62jW/gJz2WatmKC2813QEHo3N9z2yqSe4dv7Vv3rnLA9mPzNit5lWv56BIARp0PQoDn+BgMHVVRI4441EeAFrQXVTGx8TMFPsvz2UJ3g2P9gkMT2NXLmlUT8O9JzuUAidikVOTfBmpL2n/4pWrSU3WkBwo1C5jRBOLkN+x7WjYP2H0acZ527o61JBXLJZEtGOxHI//Khdcoj7X29cWDi06kXIGrF90pCCJ+zR55MkzSJXsHjZzxxxFU3RYfawb162MbSoWzd0V3ZpifjHnyPwqWxfAUgLWmxj6mXtG4HnkGQE2J1BxC2XCRKzwggUCXNcUQV0kYQMv53tojNDMY5Ax/voqCp+Q0Y0CxMF4mXRrnX5oUx0/1e5qt10xO+PLU6BzIRFC+STU15Tlrxa0B0ks2BNrv7409gRTUhsUZ8WX9irl7WZh4Hgc3Y+/EgGu1n7FKWIpSq1MdwlT2+N7sO6kmj3fNYfBNO2y6u0nJSIqmEAgLnNWqarV3FtF/6eQczQgnSemk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWVoT2g1cyttTUZZdGt1TE1JaFBNL2hjdXltVU5JUU41bklWdnZueXV0aVJ5?=
 =?utf-8?B?QUU1L09YR0JsVWdFNFMwRkpkajVBUUlsOFVxaXBwNk5KakpSWWphR1NFTjhl?=
 =?utf-8?B?eFpPWGFITFBuTGUvOFAzTTEzb2hFWkpvU0FNRTRydzRrWWd3bEpxR2RrNEhw?=
 =?utf-8?B?QkRJNTBvblJCTVZLUkdXVjU5OTdhY2VHMldJb0gyVkZ5aGI4aEk3LzlFVmxp?=
 =?utf-8?B?RWdGek5QQTROLzZQR3VNVnpxR1ZRMDl0K3J5ZCtiV0R3R3JQVk1RbDlZTXBz?=
 =?utf-8?B?cVBFdzRTU2FDUmdLeVRxWDdsZStnOEdRS3hnQkkvVVJaL1Z2TkhEbDNWc0xO?=
 =?utf-8?B?REg1cGpLTEFvR1hPaGs1Nmk3YVVVOXQ3WFFSaVNINFJwUGpLN0FCWTFYUDNT?=
 =?utf-8?B?K3NFRGYraGNFS25KYVUzM0lDREpoV2lGY3VJQjFwcCtCeTY5S3E4QnJuNmcw?=
 =?utf-8?B?ejVaUmpoWEcyM3A0S3UzbjNQbE1VQUt4YnRzbmxSem5VaFlCUVZMVXJBbWdM?=
 =?utf-8?B?QWdLMmZxaGowdzVRWW53QjVGVDQ0R0hmTkIrdzY3RHhpRGlCQ0txVEVPampS?=
 =?utf-8?B?c2plRGpTVkVSWENXdExxVFI4UzVMdHNuekE3Q1NEU09GenVxeGZxazFyWlZN?=
 =?utf-8?B?czd1aUo3eWp1L1NyOG5MTjF2RXpkMGhRMUhNZVhyaWgzdjFTcS9WemZVV3lv?=
 =?utf-8?B?Ty9iNWFldVU3dGYxemZPdFJPZEJOa01MbWdEQnhLSkRJMno3SWlEMEpvRzR3?=
 =?utf-8?B?dmEwVnRVazNPTlAzYmRBbkIydlZvY284SDkrcXFzTFpPQjR1WTM1d2I5R1Fi?=
 =?utf-8?B?dHdxc0xPalE4Rk1UNVV0dkM2dk5tUERjbHM5RjlGcTMwVGwxY2lTM1BHNGVs?=
 =?utf-8?B?L2hCbFZIVUtFUnREYlA5a1ZUSFFTcHFEWXdkTEdETVp1dUdURTdpSFBGR0pp?=
 =?utf-8?B?SmhFdmNWd0wrSUNKUDlQK21oc0VIRk5DaDZHTmtjcEp4VHRBdzFicGpNMWNS?=
 =?utf-8?B?VEhYV2FUc3Uzelg5OWoxeGpVR2t6clVGV1BHT1QyL1R6cHBmS09UbW5kYml2?=
 =?utf-8?B?YVFQL2V2N2l6eDAyMUJUcjNKOGVuZFlwbUJnMlJUNk5udXNKcHFBWDlHenA3?=
 =?utf-8?B?QUtIN045N1l3bTN1dENZSGpOK0dVQllvSTM0aDdPRlNabDBSbkRWWXg5Uy9Z?=
 =?utf-8?B?cWZTZlZTU0I5dzlqOEVvY25kakE2R2RGVklSZFp2MDRLMnA0Q2E4QjhxbDgz?=
 =?utf-8?B?TFZGeUhsOXlkTUs1Q1dNLzBESmNOZGhzamo1aTNUOWNPUVdMZDhHL2FLN0kr?=
 =?utf-8?B?UzZSRG1OQVZEZXVmTVJYSEh5YVVpbzVXZ0V4RGV0dlRONUxaeHZ2QmNsT0FL?=
 =?utf-8?B?d1h1NkFMR3RDSFRyWjdRdTdvcUpHMkpRZ1BiM1d4VkhTaDlNdENTZThkUmVV?=
 =?utf-8?B?a1JiMWZTcEp3VWtsWFZqTlR4eFR5clFiTkgyOThWZHNxdVVNbEM5ZjZLSzda?=
 =?utf-8?B?VlpWQ3VPa1haUDNRbUx6YVVxMEYvcktUb1I3bU50NmF4SXJLZER0bCtPRnVY?=
 =?utf-8?B?VGFOdzNLQ2FmODZidXBYR0s2a0VzWGRqQk5UKzFnYXNMQnhTeWVGODF1WEpt?=
 =?utf-8?B?K3JiR0V4TGh0L3V4ZWxDV0xjMVRxUXkzTjFJMjFyaGVxdW9jKzBJSzkvRm5Z?=
 =?utf-8?B?TmdjTFlZdDQ0NFBRK2RqOExUSXI3cFRCaHdwdU1RM1o4cVZYT3hCZ0VFOFNS?=
 =?utf-8?B?cTF6T09WOWJSWm5DSk00bldQWTdnUG8ySVY1dlgrNCtmbU03WlozZXRxcnJh?=
 =?utf-8?B?VWVCN2NjRVNOWHFYUEUrdlhvSjh2cmFSMkR6UXMrbmtrdWdYTks5WUVIZDQ4?=
 =?utf-8?B?dEJXcnJWN2llWG1sWURuaUtXV2NyeWVzMWEydjNnOGpVNDBWZlA5SCtuTkVR?=
 =?utf-8?B?QXI2TXpNcHFicThJQ1FiVnh5STYxNkZTdyswZlAxb2NXd1I4djRwNCtOR3pi?=
 =?utf-8?B?bktxTkhWQ05QRDVNY1FUcWNrdkpnOEpubjlWSXhVSG9xVEtkc0xHU1RSeXVk?=
 =?utf-8?B?UC9qWjNPL2U1NkQ3Wjc0RGZTT3BtUVZUMFFqR2hEWW9ZVE8rb1RSbEJPVlFx?=
 =?utf-8?Q?46srl5GQd6Eqx57R2V8o3fHFT?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5966a208-aef9-40c7-9005-08dc481b1ded
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 13:47:28.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvWE04S/KHBME78wc3MNNh1ej7SuC8/DnyPh5Z0p0FCOjMbAb64q8cl+4LTa5ywJox4O2lsvYj95TKpUrMxq9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEUP281MB3759
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28260.007
X-TMASE-Result: 10--17.085600-4.000000
X-TMASE-MatchedRID: eVEkOcJu0F75ETspAEX/nusfkPrj7CaqWEAVr2HIu3ZT5Q5JnEsf/g1p
	ECgAu23OHe/Upp/4ecQ8VABh5YDjzbpPJQ7/EpmFBgHUAUS9QRdelLFkoMPMWLqs/ojgm0KhQgY
	Eq6qj6b3seZERoFiIGG1UpzrMdBHEXHf+YlOpoTUlQx76zly9o7ioBo3qy9pIiGVApiRLArlkja
	Dkm5+itsUGVUsHHMIxSE3uK2tLdI28awlgYvAwiF7l57ki0S38lZroRtOiCG2mopAzNrNOJslAG
	p8at6qivWIwHzIu5ODLinohr1WAKbHiQqdhqKnfh0qTqtQuZvB5T7GL8CA6kOrZB6IUDx4zhh9W
	JjaUDJi6miiB19Ur4l3jHUhSUqcUjWDfMO3Wy/moO2aOVDgUaaJYuGaIjh0/6T/LTDsmJmg=
X-TMASE-XGENCLOUD: 2e3b61a0-6cd4-4b35-b221-fbe600529fef-0-0-200-0
X-TM-Deliver-Signature: D2BD4A2C5B262353AD7645278BCACDC7
X-TM-Addin-Auth: udxFPuqA1cnk7ho96iOhN/Ziy1902qyv/KJtReXEp7avQpTQf/hLLJ23qns
	4IYOaE1SSJZ/tTI7ZY0T2KbD/SxczrdogcIYySyNo362yQ5OQFimNu1RxZW2lQOkHwayb4rAQhv
	MnDyZWKalr8amHY1gXAV2M+7mvcuoX7gI88mXJvJFy4RFrV1X5/Cq5z0BiAc1BOT9J3L0P+Mw8d
	f8YTfnfSLfSElb2KOEwJfbzsERa4/I7oGuvIgy+7RdydBNAUnj8UlJIG+eyFdAslTQnqBY/eu/t
	GbK4oH+yOK9q9XE=.px5Zc1abZfC02b7JoDMCgXULYN8T/8+YieDtXB+HcWiUvsyrHDwxvpYFYp
	gmxR7NK5oimMsJD9+R/v9xGiPmKNFtKZr6mVRaP+cqnMx0yYVynK7pTGkmFqVaTQymW6fj9BOy+
	a7+FO5fS5D5cA9f3pDVasd+75C9ZiF32kAno1XasfhY32R+wfaPLv9X/xHr5sdVzC10fx4KqwnC
	YAitXu5h78+uTAK615jZkL+QoHusoGN/VcvDUusK/BASEgyyeH71h+x50pJPBwSgXII0qg/XrQ2
	BfpwwPvhGVrKp15gpdk1ic891wyPvcT3zkW7vvVP8pGEZGitiVUx3YVvegg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1710856050;
	bh=ksuXVgVGxwpGCqu0ToYhg3BoYPqdT4w919uZqk/bKEE=; l=1957;
	h=Date:From:To;
	b=EDOdiuwfH/mUANHJ/RdNzgzvyUVP84rvDenAL4KdeoBeD867SwCJRjJcxrqiMHaY5
	 /HYXyJ7jf/l6PiGtplmm3Gpo4Qr27h5B/sghS61EVPBTcE+HrznWbCA8f9B1kV0jba
	 WisFaQwcMcSkM3TrycGs2MmSlpw2UnTPtSXGK2eTsAwKsmemwN8jmp9Od8kqfGEImv
	 uwZytLcz+B8Mm3aob+IWJ3oNYkvw+SwJyZwaR7dC+OG+CBA0CdiaVDJZjOlR1HxgCr
	 JIpa4trxjJL4R5i6dleNPvdb9mUN5DMF5t6gFaBkj3kbnTJonwm/w0FM4PlMbPjYG4
	 aJwSBK0En3X+A==

While the virtio-comment list is not available, now also CC'ing Parav,
which may be interested in this virtio-rtc spec related discussion thread.

On 14.03.24 15:19, David Woodhouse wrote:
> On 14 March 2024 11:13:37 CET, Peter Hilber <peter.hilber@opensynergy.com> wrote:
>>> To a certain extent, as long as the virtio-rtc device is designed to expose time precisely and unambiguously, it's less important if the Linux kernel *today* can use that. Although of course we should strive for that. Let's be...well, *unambiguous*, I suppose... that we've changed topics to discuss that though.
>>>
>>
>> As Virtio is extensible (unlike hardware), my approach is to mostly specify
>> only what also has a PoC user and a use case.
> 
> If we get memory-mapped (X, Y, Z, ±x, ±y) I'll have a user and a use case on day one. Otherwise, as I said in my first response, I can go do that as a separate device and decide that virtio_rtc doesn't meet our needs (especially for maintaining accuracy over LM).

We plan to add 

- leap second indication,

- UTC-to-TAI offset,

- clock smearing indication (including the noon-to-noon linear smearing
  variant which seems to be somewhat popular), and

- clock accuracy indication

to the initial spec and to the PoC implementation.

However, due to resource restrictions, we cannot ourselves add the
memory-mapped clock to the initial spec.

Everyone is very welcome to contribute the memory-mapped clock to the spec,
and I think it might then still make it to the initial version.

> 
> My main concern for virto_rtc is that we avoid *ambiguity*. Yes, I get that it's extensible but we don't want a v1.0 of the spec, implemented by various hypervisors, which still leaves guests not knowing what the actual time is. That would not be good. And even UTC without a leap second indicator has that problem.

Agreed. That should be addressed by the above changes.

Best regards,

Peter

