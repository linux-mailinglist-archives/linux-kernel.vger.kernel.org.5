Return-Path: <linux-kernel+bounces-28626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 593748300E1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A411F26C92
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10C7C2E6;
	Wed, 17 Jan 2024 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="RDfY1LG7"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BC6BE4B;
	Wed, 17 Jan 2024 07:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478202; cv=fail; b=N693dllXJiw8FHnw8YAhr2JMe7BTMwnkvaUv88j+UORSfmZ/5M3PXT4q/VYq/KVmnywOD7lBZ+29mMXKK9ht5cbRpUMQKnu+2PGRp0TC90St2RqvOieYVBIaCkzb1Ubblpf7LQC3gjTaB5txbKR9q+BzaGdnd/T7/QowCx83GzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478202; c=relaxed/simple;
	bh=NDOKHFJH+ysVg5dCkloWo4dde68OyiASkFemInT+OGU=;
	h=Received:DKIM-Signature:Received:ARC-Message-Signature:
	 ARC-Authentication-Results:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=Krj3FptmbvlK7XDq6ZWV7ufwk6I4ocBmZk05zK7meg7FaBctF0MyQwhk4vkxEnk/wDFiOnujHqryV23EGwfm93CRysHOWXhRy5aVYPA2dGoMBbDBXlUcEcmCK/yK8mM9jiDYhjYkVUcMFNqyb7MlV9YLlKUmQl1+NLLfPZ+/ZQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=RDfY1LG7; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H4keoj004837;
	Tue, 16 Jan 2024 23:56:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=ADDc/QLIKXG1z+pYKQtnrYe62zl5tcMIcVEOibZTz+E=; b=
	RDfY1LG7u2qc59s0ze9M6bV7QA/0d1lyBuNce8LtPLnSImVHYtNDSGRgj/S3XTiN
	2YSz7ZhBc80qfC7dpJ1XEh+kaQq/SdD1n3eXiySAj+ymxLB8kFE/l1kzQrsls+Mf
	yoBLgtHsXiKtSQBYFfVrh2DsuzegzeLnYoL+dLtCtfJCDBDUG6HPj7HCvg3xzrJc
	xAR5CgWccLeNxEY2eqXQPpzVkgKLkIqPCPQr9xZtO1a+0t4aKtGrxq0g/2IEt2tj
	7CniJSQJeJBKRC0tNV0enykMhFiKCF+l/oKIdSm6QZ1XJufYq7YSWeGDx93BHFJm
	9/G79FMh9Y1Q02G6tXdlZw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vktwkkwh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 23:56:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvq3C94ezgF/OmwYFCoI4nipL3z8E0fRnF+gw/hMTFjADCsnE9FKg1KAFWrl+qF432r7FXx6e3HLLc5vjqaw+KyjWbodWdO0YX3JpOt3NgWahzAzMjPSWszJQmOZUYrl6kPBJg6wwaK72zs/Ey1RbxqjdwKl2q8miSuPvZF1C9K4PLQy4hzpzFnierYGUq+YGB88FUT/zxiZayKfx5oFL04QWhBclEYseIoZnt0iEE+Pmhdgpekbs5K3UnWvevJPEBM2FRbQ/vn0pmcH1v3lyG0/nnmA03BqwLLrU63hwTXt9x8170ywGIYN0UDm7IHfTYDBd86OwVpgnI9ia4jfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADDc/QLIKXG1z+pYKQtnrYe62zl5tcMIcVEOibZTz+E=;
 b=e8GS7OEBquR1Jcfhrv7KqtjQ/K4GdhWExmF6j3RHDQi8XZPd/CIxm1r3oqmbC+H3fXBFf+1RJXAEsNjppg8MS9galOEXcsQpsVDigjtpnQg+9mFxwnTzm9Zsd0/efRzIxJ+TcKMNIpEuYHxe4D6TAjr3dwZEXKXJ/VGf8aG37DodKtvBsBILzawUJa9wxce5tpAUJZG5nAg0cgmeumF5536Hn6RYHWO4TQ049s/A+AGJMC6rfRMVD7V4HoFpJ+mRNf0NyAHYb7CovGBs6mHTX9FvS0FyR2X4bJ51LqQxXfHugXxXdosyhPjXSzZFiQyikEm4dI1Ysr0hY5tpwNfexg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA2PR11MB5193.namprd11.prod.outlook.com (2603:10b6:806:fa::5)
 by DS0PR11MB7681.namprd11.prod.outlook.com (2603:10b6:8:f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Wed, 17 Jan
 2024 07:56:32 +0000
Received: from SA2PR11MB5193.namprd11.prod.outlook.com
 ([fe80::1f50:d5e1:869c:1709]) by SA2PR11MB5193.namprd11.prod.outlook.com
 ([fe80::1f50:d5e1:869c:1709%7]) with mapi id 15.20.7181.029; Wed, 17 Jan 2024
 07:56:31 +0000
Message-ID: <c9f5b6b7-7e01-5b99-c2a9-1bbfd50ebb27@windriver.com>
Date: Wed, 17 Jan 2024 15:56:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARM: dts: tps65217: add power regulator & backlight
 drivers support
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240117043323.2008454-1-xulin.sun@windriver.com>
 <70d52400-13b8-4f2f-81e3-0753e77e129f@linaro.org>
From: Xulin Sun <xulin.sun@windriver.com>
In-Reply-To: <70d52400-13b8-4f2f-81e3-0753e77e129f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0142.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::18) To SA2PR11MB5193.namprd11.prod.outlook.com
 (2603:10b6:806:fa::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB5193:EE_|DS0PR11MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d1cf4be-24e0-48cd-4357-08dc1731d161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	63yfYglmhKpXG01yAOWubqjJxe2MUQ1eil5y6sv/hhQoapjXOq4ycyU06sg8UQaxdXO0uCf+24OpC7XKIneeqFPU6XYtZIoP8DfkV8rMZJHu27hYrAqDPoW54lhGDZWp12LdeunOj5NZ+Cte9NBpiFZzIadP0CAhr1fOslQNz/LYSzEv08wVyf9GIK7/gDHd5d2dOf1h/VyTxLfCWnSfn9Ai/NEZcC6kzLuY14mXCDWOr+IwEmvBW4ZMoaOxUZNhdBkvfuaiGGqBR9EHVds8xXOyH2DmCHjHPX40rJolpmXmWj9nn7JCPKzuHYxwQ+f4J0aj2/z635T7scxWsPiyktDJ7umOqBH6Hod5l+pJA6IaTQDpy1rJuCthohmOaJCjsbv6VJOkQjDy+7kY5Us+L4dkq4aNfhm5Z2KBlVCvipPCSlsBPDM2zcnE0YqIS9GnntFTuFVRznlWydqKcsh58lEv1hoeHcpBGcckRYr1Blk+3gmUqfTMAPoqOI+DEDZZ3sLIWJGoYjzy79sgeMX0aBad8I20Q1AKZxa5o4kk6tnscFZzaaxQQohszhB71Rcsw+xv4nYZSpeaDnacLvu5nujBJ2d7fgELJhTctLcqjsYAr+af3eu0KTHJmwmqGBaKlwQ4buxzZYElFPoLQwIVQQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5193.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(39850400004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(53546011)(31696002)(86362001)(36756003)(66946007)(6666004)(44832011)(8936002)(8676002)(4326008)(5660300002)(26005)(2616005)(38100700002)(316002)(66556008)(66476007)(2906002)(6512007)(6486002)(6506007)(41300700001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QmtoeTJlSG1tcUx6VTRWeEk3K0p1amhxR0xKQ1UwWDhQZC9PcE9TTEEyTk5T?=
 =?utf-8?B?a1FyQ1BvUUF2MTNTUGE2QTlJaHdWSEVqV255L2JScFhtWldnNVpaaytiSWli?=
 =?utf-8?B?TGNhNXlXd3JMdzQ0OHZFdCtWRjhxR1p6dUEvOHhJajViN0FDQmtTVjAwQkFG?=
 =?utf-8?B?ZlJzUXlrUzA0Z053SUpMMzdwT3BYOVNKV3hNRjh1dHY5bi9aTFQ1R1VEWTNZ?=
 =?utf-8?B?NTNxdTRram91QVpRUS8yK2tVM3lmRDg5VERwY1FRM0plbnEzREFYVU81RXNW?=
 =?utf-8?B?UWFZMS9kN2FqbCs3bExXck5RQXVGVFFaZ05adldlc1N1QlRudVo1ODA3Q0FC?=
 =?utf-8?B?bkxzZ2hielh6ZUQzcHo5UmRZNUY1MWIxZVZpbHpGcDBTS3NEcnc0ek13Q1Fl?=
 =?utf-8?B?ZjIvNWUxM2E1ekV6cDZKVUpwQlAwdnFTNDZOYUNlMk02aWIxMzdndlVRSHVQ?=
 =?utf-8?B?TUpBaUdwR1YvdkNkWXF6SVNTeEdPMnBKdzBXdjYwS3RVTDh1MUFvUEJsWWtx?=
 =?utf-8?B?dHpTNklXLzVZZ0w1YTBjWnZMVXVkcTRjN25XQVp3bkFPdUVUWHNoelZVOHhy?=
 =?utf-8?B?VlQ4c0pmNDlSeUdUdmJoSHRWaXBRdUk2cnU1eEF0bXpML1A4cDVaQXVsTXZt?=
 =?utf-8?B?NjREbnlkTzRvSUVPbW1vQlkyUk1CbFE3RDhIbjF2S2Q0OTNPdk5zV3EvMnl5?=
 =?utf-8?B?TDBZT2tLWlhEaWszNytic0lVTEdVOTE1STR3alNPelVMeEs0SEFjNmlSbk4z?=
 =?utf-8?B?VzVta3ArMFlpdjJHUEpNcWhWdnlnZlVoS3YzbDV2NFVReWdJNjhpWXdWTVox?=
 =?utf-8?B?M0dnL2lGM2JUcXRVT05IbWZFaStJMXF5RjhJdmVuZVlOOUpOVm85ZS9wRlZW?=
 =?utf-8?B?TzYzKzQxdXFHc3JvZGhDZUxMQk5DZzRtTlJUMEd4RElSeU5VbkdvUHlCZ1Jx?=
 =?utf-8?B?NXdaekdWSUt1bFRuZitTbENjeUNoSG9Oc09uMnE5ajl1Nk9lK3RSbEpyTW5a?=
 =?utf-8?B?NXp2VkRQcXB0M0lEME9leTdHVWlscDR4QzJFOVJmaUsrNlBLZCtTMG5zaEVX?=
 =?utf-8?B?QXBoOHB5ZzRvQjJBblBBRVlUZTFaTzJLZ2pQdVV4YjRzY0ZWdjBHZVRjZTdV?=
 =?utf-8?B?YjczQWVaSFg1aklXOTVqT0kxdmJqU21qTkRkbTlnYWxqNVU0eDdFUldiQ1ZC?=
 =?utf-8?B?OWJNSjNLc0VUaFd5QjRBZzZPend2akxIR2hweldBUmorZ0tvUGFYSi9MOHYy?=
 =?utf-8?B?dW9qYzdGcDk5NjZZZVcxNHY5VE9MNFZHZEhvUXpNZE84bmpVb1V3WmsrNURC?=
 =?utf-8?B?LzlUdFdWN1E4R3JpcTBVcUo2RnVDUXNKOXdyZjMvTm1KRlhSdmFTQ29ZTjEz?=
 =?utf-8?B?d3R5N3p3UXJ4bFJMN2tIYmpyZStBSmxDS2h2cWZNdlVVZnhHOHZkUERDY1Nz?=
 =?utf-8?B?L05yTnV4ejhwSXhHN2x3dFlTQjlib084VXFXbEE4MHEzOWtYMWhDelFkN1Y2?=
 =?utf-8?B?dGJWZ2xlL0hLNHFBaDdWNzFLOHlnWC9sNVJoN3hZUDFvVGNqdTQrT1FmVmpi?=
 =?utf-8?B?bjZTZVJ2UVNRYktpWkNURHFNRWpIVi8rdDJaQlhHZ2VLKzVRYU83eDZqWmpw?=
 =?utf-8?B?SlpZM1JvaFI1VUVOZEV4Q3Nwc2krOGZFUDU1SkZobXBrNFJLRmNTSE9oT2dm?=
 =?utf-8?B?amRoM1VCK1E3UHlWOWxYVkRXcUFSTFViSTJIOTArZWxUR0dzTUhISlc1amRV?=
 =?utf-8?B?ejBhQmVzWDlJNkhMMUpOb3l5a3k2dUswZEVzRlhSdFVCeDFaSUUxQ2tWWDh5?=
 =?utf-8?B?V05hRFYrK1lpRGZ4VUxvV3RlaXFxckc3b3NGVlNFZFBqUmU3a1NIRUtyUEps?=
 =?utf-8?B?aitqWjVqNXJ1T0ZodCtSdDlBYm4xNzZucHdENGd3QkNNL2RucHZYYnlIZDBQ?=
 =?utf-8?B?emY3emxydUJZcVVkTXpkUXdDVnJ6REwyUWVFM3FYa3RuQWZpQWduRjFHUk0w?=
 =?utf-8?B?WGcvcGRydnlNQlUzYWlPSzc0bnJNQy8wSHFtWHh1aTZFN3FIRDdrdDBzZW9t?=
 =?utf-8?B?c1I5bnJMTmZhbi9qc1d0eFA4NHZkaFZMMmZ2QlJNTFVFc0w5ajhXTzRsYStq?=
 =?utf-8?B?dFpsSTNrd3R5TXRQVFRNUjBNdnJwdFRXS1BXV0ljaHhkUU5HR3VhRG1HV0JJ?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1cf4be-24e0-48cd-4357-08dc1731d161
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5193.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 07:56:31.5638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkIkcaN/goiUsaxHGTQaJbENhCVknwVxY5JRZ1ky6JPLzf8iqWYIfs0VB10JfTXwmoy0z9+dhzQPo46meA/2jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7681
X-Proofpoint-ORIG-GUID: TzQr1pBgcJdj-rmpVOy-jaEHt2VrLByr
X-Proofpoint-GUID: TzQr1pBgcJdj-rmpVOy-jaEHt2VrLByr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_04,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=494 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401170053

On 1/17/24 15:24, Krzysztof Kozlowski wrote:
> On 17/01/2024 05:33, Xulin Sun wrote:
>> Support TPS65217 voltage regulator driver and TPS65217 Backlight driver.
>> And enable them by default. This will avoid below booting failed
>> information:
>> tps65217-pmic: Failed to locate of_node [id: -1]
>> tps65217-bl: Failed to locate of_node [id: -1]
>>
>> Signed-off-by: Xulin Sun <xulin.sun@windriver.com>
>> ---
>>   arch/arm/boot/dts/tps65217.dtsi | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
>> index 0d463de5650f..f412e7476660 100644
>> --- a/arch/arm/boot/dts/tps65217.dtsi
>> +++ b/arch/arm/boot/dts/tps65217.dtsi
>> @@ -13,6 +13,16 @@ &tps {
>>   	interrupt-controller;
>>   	#interrupt-cells = <1>;
>>   
>> +	pmic {
>> +		compatible = "ti,tps65217-pmic";
>> +		status = "okay";
> Why do you need status here?


It corresponds to the drvier: drivers/regulator/tps65217-regulator.c, 
and regulator is one of the main function of TPS65217.

I think it should be enabled by default, so set status to "okay" here.


Thanks

Xulin

>
> Best regards,
> Krzysztof
>

