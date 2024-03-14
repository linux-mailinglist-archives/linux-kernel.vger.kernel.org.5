Return-Path: <linux-kernel+bounces-103027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A881F87BA17
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC71B1C2169F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537C96BFB3;
	Thu, 14 Mar 2024 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="QCbP/BMC"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756766BFAF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407623; cv=fail; b=RkRW9cldyZAtjWA4WcjFMcpO4Tr3wf6vbRZ6pR6XlecBMPm6ZahnxGiuxnfPENckiYpt22aXR6fzwLDK/2BNryGsa11PiBtkRBLS+fMIKFMTrwsNuGnAorjZAWSpXvu7oDPBnOtPB485L7scC5XVTiQVCIAnxfTak/kx/2NHlBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407623; c=relaxed/simple;
	bh=S5yionLxs/ffmpPuuEObJJjl7tCL42MQZ7oTUj6QOrU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=quzMJlR4cslUKBh5Mx7trV0pGFz9nb5Oe3/kHxc0uK+eUVa7QmJD/EP7mBgq56WQluUwi/ljY8/X7mNSAduY1T3o654Qj6CqEe7rup15NK1IRXv+AH6rsZd7o+7oH99GtCGs6CRuZwXMgaT3P8d3v5OLUkDyniED6yNarxLZzMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=QCbP/BMC; arc=fail smtp.client-ip=18.185.115.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.187.21])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id E910A100017BC;
	Thu, 14 Mar 2024 09:13:32 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1710407611.918000
X-TM-MAIL-UUID: 574abe95-263c-4c06-b2e9-eff720b77c70
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id E03B01000040D;
	Thu, 14 Mar 2024 09:13:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8MbSSLmtkiidajlpbyEKSiiVfplwn5/k8dC2OQ0laWJgGFkB9Ff0Im7uwSHpC/+8jBmV6/Wnh6wtjiktLMXp35AmLfo9LafcGwder+QeGwxUSiJ8Cy6M09t1/rAsKl/v9izzB3fsbJZskK2+NxGfZ29B38jnYeb2UNrlTPHhJ3r2r0Q08zIuvmx/n3BFZ9QdWbMUclguA0CVLfwIp3p4dKv6HKpQ6x/+SHsUSzgi+9EE78JKODAjayaHx5bdNTXcAQiipGid+CmCw1pgsfiM5zk8IBCCUfO6WWUqHdxwJ241u7S2bLi7XjHn4IBvH55cy7qpmaPfSJfRVqb9ofzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZQJdKYgzUnhPbTpmaXzBjB1zAg6KtrsouiLvBxBMqY=;
 b=G+XBYYM/qXiqXiRH4jIC85IRKz2uFt2X9EtatpsA030CW8IrSVAlU9wCLoYBx45PM/2Z8oyCDGG/+Be0nGS83APIQ7e5Bo5M+0s6fUSscpuUTj8br7M8l/EhUFaT8Hmlr5al73jn9NfVgZtRJDr1DwVBA7EOjn2piBmcs9poD0M+PMENZ8lwA0lQ6XQmZm5LQeb1LHJr7J7r8jws3XW8dLd6Hrkl4YIghYeCVuezIp9CfjbFpv5QA+8AZUHqnK8PcECwuhvNBs0hXbPyasnrCRsKf37IOPre2OxBg1x6aAMjznuYxIZlg1SUPUVPPOFpJ+JhqhCf7K6QEY8MGkY3jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <ed2769d7-1cbe-4e27-86b1-4ae365cceb28@opensynergy.com>
Date: Thu, 14 Mar 2024 10:13:28 +0100
Subject: Re: [RFC PATCH v3 0/7] Add virtio_rtc module and related changes
To: Andrew Lunn <andrew@lunn.ch>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, virtio-dev@lists.oasis-open.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "Christopher S. Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>, "Ridoux, Julien"
 <ridouxj@amazon.com>
References: <204c6339-e80d-4a98-8d07-a11eeb729497@opensynergy.com>
 <667c8d944ce9ea5c570b82b1858a70cc67b2f3e4.camel@infradead.org>
 <f6940954-334a-458b-af32-f03d8efbe607@opensynergy.com>
 <57704b2658e643fce30468dffd8c1477607f59fb.camel@infradead.org>
 <d796d9a5-8eda-4528-a6d8-1c4eba24aa1e@opensynergy.com>
 <202403131118010e7ed5bf@mail.local>
 <dcd07f0b733a90ac3f3c43a4614967bbb3ef14ad.camel@infradead.org>
 <20240313125813ec78d5a9@mail.local>
 <96be7312f7bddaf06c690e082a8028fa8b511deb.camel@infradead.org>
 <202403131450547f373268@mail.local>
 <04246331-e890-4c9a-95fb-9673580e6d30@lunn.ch>
Content-Language: en-US
From: Peter Hilber <peter.hilber@opensynergy.com>
Autocrypt: addr=peter.hilber@opensynergy.com; keydata=
 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
In-Reply-To: <04246331-e890-4c9a-95fb-9673580e6d30@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::11) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|FR6P281MB3483:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c52801b-5555-432b-2187-08dc44070429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	er5yYPVrb8TV1J28bpOYdrj6YK1f0hlvi5uInwItad407dWER3TTR+VdAsP5nOEBfG8kLA0EHbOQMx/Pz7teB+8csThBTAUAuoxLk+s4jHs9+4fnR484ddI33wYa9zYIz98z5AHiEMfNiOAScd70Q5Y98/++AtpmdVilQXA7JfuR5d78KjkRKendf0vxLMbrhaGTWbjk9qfM5sPy/V2o14jRawC/cgrwBR33dvMtT283NaQdIaEo9B9jRsa2YMIcKS45xUfZG76l+MZl0yxbb1HBWg72h1c8e99bWXwmNLVEmeQQO6sQkgG3LM7TFnPsfb1H2aoXS2MTVyrcBRIjq1nSxXbOawo2WB9WHxilTC2Uz0LVAzKoqS32PH47Atz4mXSOJTietwa/i8v02/uWI8jOH1a/gecjm2KvYQMUQ7JlVObu2XB0FEZfG6NyPoNh9mjADLJBhZrC2N5sptl1cvrXuw/QTP/NglqVXrNDMOnG65YyWOPmSLcgz0CPJsUmCZZCnX8/iIW3pNvQ8o+CMrDD4MwTGJjtCKNul9SYWFUjUm1iFMnttITzDpFPZ+FZfFB9wdO/P22w1fgS4zTQfq1eGtg5KZT/3Qp9sbffx/DTW3R5AKQCLbToznEXxpMgu0amJM0m2iKfXZaYObocQ+U4uxrrmOdvIfQkipyM/x8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1pyVzRxTHhUaHRrM245WjZ1MEhReXh5N1A2R1pJQVFhUS96Uk1uTWxaelRj?=
 =?utf-8?B?SldxUUV0WEJnOFpZUU9odkl1Z2tXNkh2NURNL0tYZ055N1FBTmpraEpUcVkv?=
 =?utf-8?B?Z3lvM0IvRVU4TURCWHVXQzFFbTFGT05NVXhhNWp2UmZjeHdPQTFoK2RVVEdt?=
 =?utf-8?B?c2xNalRHaW40QnI1RjdZM1JQNkRUcC95ZWhsT1pFbUNDbTZJbzV3WWI0YmZJ?=
 =?utf-8?B?aWpxS09FL015WW55dklIYkxsR1BQWURZZGI4MGhML2JZUWtqVW1HQlhUaWJJ?=
 =?utf-8?B?Slk4MjdLWlBhS09IaTFXQXowKzBXNnZzMEM5azZXZXZzckJtOEZSai9rMkVt?=
 =?utf-8?B?RTlYRU1nOHlmVi9SdU1CanNFZWhMTHNrdmJFbmpaZ2kvbFRVSllGN3FUeTVH?=
 =?utf-8?B?RkRSdkdpVG9EeXU1VGd0WWJ5Z3NEOVFOckQxa3JRMUluRDVaYnk3WU9wQUV1?=
 =?utf-8?B?YmF3ajlkRTlZamgvTUh3bXVyMUw5eGxQRWYxT0ZLcytJRHZwQ3BFWTg0U3pF?=
 =?utf-8?B?Yzg3amljZmNRalZ2T1hUeFNqK1ZDcVQ3MzVVRzZldkF0R3RYT2ZjODRnQ1lN?=
 =?utf-8?B?enhYRkZMaVhXR2o0VWZHSVE3ejVtSzQ5VXU5c2hQSFcwbVZhLzVCZi9Dejc4?=
 =?utf-8?B?dHlYQS9ORTJORFdNeTZPTzBSTE9rdUE5TUlNUzN3Q2c1UExmWkpmdXdLd2ZV?=
 =?utf-8?B?RGtmb0h5UXI0eW1weUlna2ZPdTZrRXRsWFZWd0wybGtiUTVpZ0FnSHJpc3Nm?=
 =?utf-8?B?ODNWWGYxOEd1dmEyR3RoSGtTWXhCd3R2R0pXbmNlbXBFd2E3Z291dVhRL0Rj?=
 =?utf-8?B?ZG04TXNzSEZjbzZ6K0dVeFNFb2RJTzBtOVEvODA3Tmk3VFNCM0VLVk5FREVi?=
 =?utf-8?B?RXBDM3R4K29VL0xxVzdRN3VGWk92RGlNbGlsQUVZL2s0NnFuSVQ2UEV3Z2N6?=
 =?utf-8?B?Z3AvaWZlci9uNWZwMFRRZEpMdE1qelcvRWtyTldldzduYzM0NERBM0FNYVln?=
 =?utf-8?B?ZGlkRzJGODlMZHdlWTUxcFZVSUY1WEdUa09pdDBDak5POWM2Zi9NVkJ6OWp1?=
 =?utf-8?B?eTQybUVBa3oyemxEOHRSVjZSSzRyRTJoTUxrZUtad2s3RmlSNWtMK1E0dUZE?=
 =?utf-8?B?cHBZWnF3V0Z5Y2VwTFJkc1VKUDBpdnBpdHhWMmRwOC91b1lUMmxQUEhLQVdQ?=
 =?utf-8?B?aTgybWZwUVYxWVlrbmUzQXI4UE9iY1VhSGFpVi9TWHpOb0tYMlVVWlZHdGZn?=
 =?utf-8?B?ZGNCRGFadnY5dlByWnFIZEZSanVQZjU0dVVNVG1NS1BBOEVsZUg4RVNiVGRV?=
 =?utf-8?B?aW1hTkJkZm1EanlBTTRZVG16K0FwdWdUZnFmRHZIalRlY2FlbzJrTWlCNkgy?=
 =?utf-8?B?ZHk2bzdWK1FWeDBETXAxb3lJVEhrbFhMZXJja3FacVhUR29DbThwVGJncXhp?=
 =?utf-8?B?V1VraU9NSHJwMHJ5RVpIakh3VWZNOHN4bkV6bkFKc1J1NU5qOEphdG8zekNC?=
 =?utf-8?B?MTFoRVlFMko4QnYySTd2MkxoZFRoR0hBLzZEMlRvdkUycWZhMEdkdEZkRnpk?=
 =?utf-8?B?Y3h5RnkxbW1pdWhxeW55RzcxRWdBUDdZSEpoZWk3UGViVFY2QmtRNFR2UFlq?=
 =?utf-8?B?dXpRclZpQmV1Y20wUW5tL1FNL1pkWEpwM1Y3SmNTQk41VGpLNXdnQWIzaEJT?=
 =?utf-8?B?TUZEa3FUZkVXY3FqOWxDVzRnbXBKOERuNFRBRXVZRVhoL0kxUkxUWHNxa3hJ?=
 =?utf-8?B?cjIwVGtla0FjTW5tOHo5WWxCTHprb3R6S1V1L1ZiTEtCQXMzVWJZWHJJRGFl?=
 =?utf-8?B?aHlLSzZwbWc2MmNKTGZJTExLcTJuQWpqcWw3TU4vM1dqYjhUbFhEM3NJYlRG?=
 =?utf-8?B?ZFdCQjJDQUFSS2hZc2QxcUJyd3NCVzhSWWlOWWVBRGtlbk9FeDZkUU1YN2pP?=
 =?utf-8?B?NlU5T3J1dDJWMEh1S3cxanZaL09EN0s1QmszRTZyaEZZR21SaXZ2VURxc3RN?=
 =?utf-8?B?TFNhT0VndzM0YjVlMUNTQ0FNVXcrQ2tjeTRrNDV1d2VQS0d2SElSUzhyS21r?=
 =?utf-8?B?ZFNRTHFmVGg3VG00Tm1ZcWJ5RkpvQ3RmV3BmRDdmR0hoSGZsVTROWTM1UkRj?=
 =?utf-8?B?MCsvZjhhNjN2bVdWOUNyRHdnQmp1cHc3M1pVaU5oRjM4RU9CbjJJeGluWmJO?=
 =?utf-8?Q?HOJxoQ/r5bY1gIN9tNS0jq4m14WSf/u+hiL2pqPEro2X?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c52801b-5555-432b-2187-08dc44070429
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 09:13:30.7240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VahofVO6SAM0NaPI5+6XU/YrQsMWc2TyxKu8KhlHvuBczVm+UT17UcfVJdZ8egjaVLfBUn/jbkXPI3X6KACARg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB3483
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28250.006
X-TMASE-Result: 10--10.196000-4.000000
X-TMASE-MatchedRID: VPleTT1nwdT5ETspAEX/ngw4DIWv1jSVbU+XbFYs1xIgVjtEzPedW2bk
	7AUpj3QfzPGL5Z29NfWBtTCKewZ6xePXzq8/z8gYnRTJpY7VAKeVmuhG06IIbUfA+mhLvGJNRQc
	XrCueZFg7agZLomT1YdixLe5vszLRFnf33mBzr9FCPQBD3xA/3aryV/2jRq/XEgg3cwDHl/1qdl
	V1LmbEfINlCgp1qvO8HWzqMRY7mohIkEj2f2VroVo7GmCOJYd1/KO2LNTSuGMnqVKtN93FnMpZ+
	i3kzp/niUsgTX2zjLHckiyazWPDrw==
X-TMASE-XGENCLOUD: 31e3eb51-602c-493b-aa22-f31abc011119-0-0-200-0
X-TM-Deliver-Signature: 1138B98EBD5FC8C21C837A5DA93F517F
X-TM-Addin-Auth: aETC8i63u+/sWhK+DUUlovUVvdLkpgn5iWymgpPpcE6YR1RO/5FGbldtlu9
	bUhhQPDM8dgQ5yJrcOuqGRKw1GNMeOuqP1N4cVRltEetf183iewV1im1tGxjtbUwE4iOi+jI6bF
	FiEoNhmuIL73HGOkiyBHrkkGa7TE60o7AeUkgflWlRc1PAFDRU+xuL9NbYqAIhAkoPph+rCA0/y
	mVOju4wg4SDOKmhWjparUjMJ8Job6qMy6b9f//LpcmBYjfr7++AcMUlubV7fDIJOWt+FzhQ+gm5
	WA2nQoLhTsVj264=.qVsrtSwxrQOC9jpJtR/8soLrmV8pmeVqVPNqg8L+u2W4XuM4lCJfAh/5U1
	OHkt3Cp6c9sqvZM0mjYvqdKWV/486szdvftJV3qDVuDI8yb2bbhOXKtfDCHdwaYT57ef8Da9Vr2
	SVt8Js9KVXGrVlIB7q/aA1CL+y0LeZaYhnB+4Jd8mTX+e2ZOL1DgKXkptt/gKNEVom3Tx2TkcRu
	FeTi9VSnfn7D0tlN1DPMUfDmw6AUW5dpDPGUO9rhitt+CpvsDt78fJK/dguH7TM0kXHFoOweM73
	FR5kj5XFaBoiweopeOIurIdDYZc1mpbpjnaZurlSWRvBODf3v/g2BAU3Otw==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1710407612;
	bh=S5yionLxs/ffmpPuuEObJJjl7tCL42MQZ7oTUj6QOrU=; l=827;
	h=Date:To:From;
	b=QCbP/BMCnUKUjgn5z4LCRXGvIc5M2FvZLW/ZT7U2/Qo3FCegAFMr7SGbSXqAHRDYZ
	 R+B/h1SWpNebw9RKvMSPkXSPlWJu6L5CHV7vtnu+ywPAxV96ifMhpqFbHZ9UbVtFl2
	 pWHHpfkLnN7CuD1sLkFI19QV0j0zp2UhhdpjxY3A784yzqNehw9L93E3yP1pBY1GDy
	 PIM7MneLJJgSPihysfRXx5w+9+BKzgclHGygKSvE9r/ClHIKuWUP3zQ/L7rzHH4eUz
	 EmOjc4K4NzK8NvFiv6hHujU5zEyzvac4Lcm/3R1fBVh1wRN3b0ul7rdU7/b4/CwSMb
	 NCBSm/+w/XDQw==

On 13.03.24 21:12, Andrew Lunn wrote:
>> As long as it doesn't behave differently from the other RTC, I'm fine
>> with this. This is important because I don't want to carry any special
>> infrastructure for this driver or to have to special case this driver
>> later on because it is incompatible with some evolution of the
>> subsystem.
> 
> Maybe deliberately throw away all the sub-second accuracy when
> accessing the time via the RTC API? That helps to make it look like an
> RTC. And when doing the rounding, add a constant offset of 10ms to
> emulate the virtual i2c bus it is hanging off, like most RTCs?
> 
> 	  Andrew

The truncating to whole seconds is already done. As to the offset, I do not
understand how this would help. I can read out my CMOS RTC in ~50 us.

Thanks for the comment,

Peter

