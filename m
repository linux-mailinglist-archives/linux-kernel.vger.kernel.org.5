Return-Path: <linux-kernel+bounces-30113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD533831962
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4665F1F26E78
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C7D24B55;
	Thu, 18 Jan 2024 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="qDb16hSl"
Received: from outbound-ip8b.ess.barracuda.com (outbound-ip8b.ess.barracuda.com [209.222.82.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB30E25112;
	Thu, 18 Jan 2024 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.190
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705581907; cv=fail; b=U+ozjuIkvx0gILv8H8uQVg1cwCVv0KiPnqWgwuez9wovZjBRFJw6fSWjXQqjAJVoAHvnrYOiSPPg4xH1yWem+JWtOWWPi2tqRYe5oc7zY6zy9mVG4YZc3C/UlfbCqr2UThkkJyb1hCbslfak6T+xDVkKD9FOZiBJmBq8hoZLHZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705581907; c=relaxed/simple;
	bh=WRXIoULkZhys3QT1OyOipta459jINORk724s5Knx+rs=;
	h=Received:ARC-Message-Signature:ARC-Authentication-Results:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Organization:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BESS-ID:
	 X-BESS-VER:X-BESS-Apparent-Source-IP:X-BESS-Parts:
	 X-BESS-Outbound-Spam-Score:X-BESS-Outbound-Spam-Report:
	 X-BESS-Outbound-Spam-Status:X-BESS-BRTS-Status; b=Mvyq825jRIk0Wm3ikafJcIvKmUrKsoQ54VQP+Qy4X0r3Fu8RSgBwou6VXkOcHxqgs0YjvwPZ2dvlYFRkG9iO70qKZ81DAh8gE14FE3Mgav1eRoKmLbHmbfZO/M/XbHgLNQ1Vg+q+rMUvzOKfX9ii1KSCW5nrCThHCP830yeVd4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=qDb16hSl; arc=fail smtp.client-ip=209.222.82.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100]) by mx-outbound17-183.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 18 Jan 2024 12:44:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYNnBOyY6XAvG4+OVhdW+7/gWXsF/qE077SducQvQJf0Qth5NtqHgCxM8t7nBimkxWDM138SU6k+ZnLQfV4ThSmVsMn1o1zeVdc5YcVWuj4YUDMI6p2ubopqd1ilk7qIhNognLZjUprseZJVNAhoMK4Ut4LcH4qBYXav1N1EJk2MSCG6y9hnjrP2XUcjHwVUk3HDVOGSj4zeGYaF9ScJGDabjrQPtqIS6WrkWc6Py/lDFMD4ek5dNKl1ZRunlWNq2AM4pNj6ERhEnfDnYKwbRR37igdQsaLKDr9gvXcovDO1AeI7WEIZuiQ66HDBTltpu5sIDxEfm20YcDN5lRDbZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f76mTfUIAaOL2SPerFk7wdTOKgc3tSBvNW1PF3uijXM=;
 b=E1kaflzCS3lxT2azsELbIi/qxL69AABLYu9lLyhG2JXUDeDTmEc+pL8bqHb3T5sHnQ3U2W3C+nYy4c+3meByw38IcuV/1yqZSpUo/DXG7PkNgfSx1EAVkf3v6Zf8owstOzw7uE1juJeVg/82+vJ7FZLbZA1eTwcibkF4wVRjikv7942KJSk1oATd2xhBi15bcIjzQpYpUsqORsJV3qJimG+OS66eW07Ow5CBfFgKx2HeLifVvjJf1iAGnHuxzT3fQSf6hEAu22IwN9XID3BMGEjy/uddagpTeAj+VgvfRbZGPtR0ajpWFVTa8/JagOq6yoEA6y4fChv6jT1uPIO+Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f76mTfUIAaOL2SPerFk7wdTOKgc3tSBvNW1PF3uijXM=;
 b=qDb16hSlj83oyghQF6aI4YA6U+Z/9mD/9/PtpLSQULq4WnV9K55huhIY89hnmWQZVoKgNETlGtfE50Fs1OimsG03dY99y3fz4gTdGcD2oWtbq3b2rh/XAMHTgUjG5tzEF+enWfa6cQVbKZA8Mh4dQ0H38eg8TDu7Nsi58Br8QbgoftNDuvWt66uHzcMLtbJJON6QN9isILmiUnrknYuwvPusdP9W7ZxOZrxI2Evuh7UTVuYhpKBWuDyhXF8Ep6qRrOKPdF3WrAnWp7X4u1tZSGbVXrM9SZ6B/2nY+KRYMQkYO6ZwtCDLaU4lBgXi4EcHKSN61JhUZkaTj8cY35KmxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19)
 by CO1PR10MB4513.namprd10.prod.outlook.com (2603:10b6:303:93::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 12:44:33 +0000
Received: from BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::7cf4:e989:1a52:fb39]) by BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::7cf4:e989:1a52:fb39%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 12:44:33 +0000
Message-ID: <9b370036-bf3a-49d3-99a0-5c11eaca4e6f@digi.com>
Date: Thu, 18 Jan 2024 13:44:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] gpio: vf610: add support to DT 'ngpios' property
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linus.walleij@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, andy@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, linux-imx@nxp.com, stefan@agner.ch,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240117083251.53868-1-hector.palacios@digi.com>
 <20240117083251.53868-2-hector.palacios@digi.com>
 <CAHp75Vci=1nAvxRcbkK2SxGWGbQVbzQMTycMt8tZ5snPRTYXOg@mail.gmail.com>
 <fd5550ad-76c0-419b-aa07-a0493a57286e@digi.com>
 <CAHp75Vf4wXLEjmfpz6KQSCB0Jd8LNv6+SU_ikbhR_8PsJHuq-g@mail.gmail.com>
 <CAMRc=MfAW5NDJHtZ1333-xrcCyQfft-pQF1-0Vv_ehY16agShw@mail.gmail.com>
From: Hector Palacios <hector.palacios@digi.com>
Organization: Digi
In-Reply-To: <CAMRc=MfAW5NDJHtZ1333-xrcCyQfft-pQF1-0Vv_ehY16agShw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::18) To BY5PR10MB4370.namprd10.prod.outlook.com
 (2603:10b6:a03:20b::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4370:EE_|CO1PR10MB4513:EE_
X-MS-Office365-Filtering-Correlation-Id: aa34c9bf-413b-4051-d95c-08dc18233825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ae4w67oxQio4QO1+W6lggOPu2Y/T6kOCYxDwdg8BbqHdwRJna1j2Tzaz6Uzs227imEI3O0V6/k70yhKX0/tu3BFTtmKuPhWDhya4vU2g/6YdaDEjU3GZylnVk3ozss1QB9NhiQD4JQE0SBk/X6fegtDSjy/EC4GgY+TlAgE9zLnJSw2PtDPDJRX6CSoMquOEdzS7E8s8AOlFPwRBd9mbUe1OcQ7pXA9oJxHeCG/a2nsZTqVbiq80mdgIvq5YSXJ9CbvFZNBBTnSJ3nfkGVYARXpgKMOnllbAC66kFrBBOt0sOtRtXUIHtyRxoATiebyp3ePlDLNexnNwsF00aRqthBer0/n6buPJdkQq61h0mDXtc1WI0fcy0LClwsCUk2rEqOlPQSxBy0YtLrWkCopCrODkReLmLvJfdQJhfOIccfkvxaae3gSS5ZXy/R0CueVfFYcJ82xm4PN3BosuNTegRIoHWGvxtDpFn/md2dC0HrOmigzDrvA1IeO/+tgIOxDg9wfbd3uSZsXgeljjfAnnmjbTl4DEInUenwID32YhzsilddkL9g/DN+nr0kJawrMHFhH22U0OlnYjpU1YXuEYMG2jW0d7UjR/c+2QOfYhSFSJVgR19XU5ZR7GWYGTjd01FAyvUZt7+kl/m+F7i1wJFQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4370.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(39850400004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(36756003)(6486002)(26005)(86362001)(478600001)(31696002)(6512007)(53546011)(2616005)(316002)(66574015)(41300700001)(2906002)(6506007)(6666004)(36916002)(966005)(66946007)(66476007)(5660300002)(66556008)(83380400001)(31686004)(110136005)(38100700002)(4326008)(8676002)(8936002)(7416002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkNnS3U4bVIxT1M2MzlVYWhFc0I5R01SZUNXMENreXVXZ3JtbWgyTGFEV2d6?=
 =?utf-8?B?QkxSbGV3OURoRmtYUGUrdlZTVTNIVkIwZFlXNGs0VDV2ZGhMSU43ZzB2WHR5?=
 =?utf-8?B?VXdRV2NkK1BEZzh2RUhiOWRwd0pmYi9lRGFvN3lacFdjZEdTdTFkM1NCTDJ6?=
 =?utf-8?B?ajU4YlFYbDdPMzFRbi9aSWE5N1Mwdkl4QVgvVWFKVFEwQmMvcFY0NlpweE9K?=
 =?utf-8?B?dGVuR3VwYVR4K2pXZjE1dnlidzFyRFI3SU14ejc3R092YjFWRS9XZU9OcGp4?=
 =?utf-8?B?ZnVmdGRZWVJtVTR6QnBXd2N4VUd5eTlZcS8zTFJ2MXl1RVlKVEFWTjVSWVBS?=
 =?utf-8?B?Wk9JQ0FrQlNZSktIYWlUU1ZON0dNbUk0UE9KSzV3K0VkR2pFVHpNbEQxUDF6?=
 =?utf-8?B?Q3czZWwvRjl1dENvWGdZMVVsWDl1Y2NSWms2cmF4MHJvVW9yUEZ4b2pmajBF?=
 =?utf-8?B?SWR5QzBHYXRhSFMrUUJoV0JnYmhNR0cwdmx6ODAzNmJ4Yk40Z1F0dHRXZUcx?=
 =?utf-8?B?bGJSR1dRR2lGcG8yVlJnZmhsSVVjRU83NzhkNGhIbWdTQWQrek1VOUNsWnZM?=
 =?utf-8?B?cGNFek5meXAwcFdmMnhObHc5OWFMMENLUTBJcGtleTh5ek5lU2Fpa08velpP?=
 =?utf-8?B?UDh0M1hPaUczYllLZGxaNXdudkNyTHp4ak1idjJxNHpRMFhXNDRiNDZjYk5n?=
 =?utf-8?B?c1ZMTUExdGFEcG1kL3BvbnRma1B1cE1Rc1VmMUpYS05hZ0lkdFJ2QkpZY0U3?=
 =?utf-8?B?MzRaeXUzdEl6R09kRkRKOWEzelVYSllZVXRuQ2Z0M3VmQlo1S3NtUUpkd2k0?=
 =?utf-8?B?SFBwZlVuOVVhV1RhT0tqeVhydGcvd1Mrd3BxTXZDUXh3TVpzaDExZWgzRjg0?=
 =?utf-8?B?d3d5OXlGSCswNjhXMXBRQTBwUEhSejNJc0Iydk5VWENKdFU5NHRlQWdkM1NZ?=
 =?utf-8?B?S0YzMGNXTEVYSE8xN1hTY1krdWpKTE1iKzltZnFpM1BES20yQTlCUHdRWmNt?=
 =?utf-8?B?QmoyZGhIRUxNL29ZK3A3TFhtbFRNdk5HYVB0ZnRsMHZ1NVJnbVhNc2F2ZjVl?=
 =?utf-8?B?OTFkdzJHVXlwWjYzcklWNElUVnQ2a1JhOW5RNnlhdWd0T2Z0QksrTjhtZlFH?=
 =?utf-8?B?RHhqR2pQL1ZGYkE4cHR3TUZpNzRwbkwvVVhpSnA5TVdjOU40YmNFcUw0R0Ft?=
 =?utf-8?B?VmNLZkJFKzl6K2ZkZFgwVTB4OG9NZnFPSmpzVmpXSlBFSHlKUWtWZjloQk1h?=
 =?utf-8?B?V2FFVVh3VWgxSDFPNTdnQjRVTFdaNWtiL2czUzF2cmlpdnE3MU1nUVNOS3d2?=
 =?utf-8?B?bHB2TUVwT2pUS3J2L01vQjgwN0RYZ2Zjb1cyUndRd2xPcVJXbHpRU01WRkxl?=
 =?utf-8?B?QU1hNkswdWpVZWhybXZVNDN5VGp0cjdvK3VlblFoWGthSDU5dkVLcFhJbUZr?=
 =?utf-8?B?blhuSlVWRjRyQS8xMXRjMXZMYk9pNmFLVTQ2UkhKVExzTW9NZTB3UWJQMHJQ?=
 =?utf-8?B?OUo0MEhrVldqYmxPQlVUUlpKWWU3bVpJUE9iQ3F2TS9SbERSMHdJd0JtRHRo?=
 =?utf-8?B?aysxanZRTUFZNU0wUWNkcGtEYkdNVEVYbloyMVVhdlNLUFJBTmsxM2ZsaXI3?=
 =?utf-8?B?WTJrT2hMWGt3QW1HdUFxSzFSRzdtOXBpdERKZHhBZW1vQzBIcE9hZkZvUlNN?=
 =?utf-8?B?L0k4RkJURHcyWUpuakhadDgyVVQ2eVpSM09FRDBxOTI0MVJ4ck5VRGRHUkJY?=
 =?utf-8?B?WHNtRnh5aWp0aG1YT3hqckVuVndpMWErVDkyQVB0R0VFbGVhUmpHWmY3SWFp?=
 =?utf-8?B?Z2l2dUtPZDJoc29CRnMxQWRHWXRnTk5vSmFObHE0a1E0VWdJOFQ1elBnbXc3?=
 =?utf-8?B?NjBIQkJDV1VSdjFzejgrbUNoYWg0Yzl6OUprQkt2ak1rTUg1TXN5eWt0elVj?=
 =?utf-8?B?SExFYlZyeUE3QTYvM2dRSXBNQ2FGOW56SWRqTDg3TEUxUVAxbWR0UXRZNHBi?=
 =?utf-8?B?cTNwdk9TM2xGcmhrVU5hcExudzE2VFljWUR6SklEK3IvaGZYYTZwNmloSWJG?=
 =?utf-8?B?bmQ1dTBZSXNNM3hoTVBhRktKeUhVSTVRUVJDa3oxd21YN1FKbmxlTVZXZi9Q?=
 =?utf-8?Q?m5sk/71pIGbNidFJb8lQqBkkp?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa34c9bf-413b-4051-d95c-08dc18233825
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4370.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 12:44:32.8055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCx62WIueJDsIlMrnQGKGFZILqeh6Og3H0FMUyqBDMnUD5wvLSkNkq8/ZC3+vXPIVZi9tlxFvYL9az6MR8HHKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4513
X-BESS-ID: 1705581876-104535-12453-16414-1
X-BESS-VER: 2019.1_20240103.1634
X-BESS-Apparent-Source-IP: 104.47.58.100
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamRqZAVgZQ0Nw00dDCICnJON
	ks0dwozdzUJNHEIiXVwiI5KS0pLc1EqTYWAJCL+RdBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253598 [from 
	cloudscan10-60.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.50 BSF_SC0_SA983          META: Custom Rule BSF_SC0_SA983 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA983
X-BESS-BRTS-Status:1

On 1/18/24 13:03, Bartosz Golaszewski wrote:
> 
> On Thu, Jan 18, 2024 at 10:04 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>>
>> On Thu, Jan 18, 2024 at 10:25 AM Hector Palacios
>> <hector.palacios@digi.com> wrote:
>>> On 1/17/24 21:51, Andy Shevchenko wrote:
>>>>> Some SoCs, such as i.MX93, don't have all 32 pins available
>>>>> per port. Allow optional generic 'ngpios' property to be
>>>>> specified from the device tree and default to
>>>>> VF610_GPIO_PER_PORT (32) if the property does not exist.
>>
>> ...
>>
>>>>> +       ret = device_property_read_u32(dev, "ngpios", &ngpios);
>>>>> +       if (ret || ngpios > VF610_GPIO_PER_PORT)
>>>>> +               gc->ngpio = VF610_GPIO_PER_PORT;
>>>>> +       else
>>>>> +               gc->ngpio = (u16)ngpios;
>>>>
>>>> This property is being read by the GPIOLIB core. Why do you need to repeat this?
>>>
>>> My apologies; I had not seen this.
>>> I'll use gpiochip_get_ngpios() on the next iteration.
>>
>> But still why?
>> https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L867
>>
>> It's called for every driver.
>>
>> Maybe it's needed to be refactored to allow fallbacks? Then can the
>> GPIO MMIO case also be updated?
>>
> 
> I guess it's because Hector wants to set an upper limit on the number of GPIOs?

I think Andy is suggesting to rework the gpio-vf610 driver to use 
bgpio_chip struct (it doesn't currently), and then I guess the 'ngpio' 
property gets read automatically if you call bgpio_init().
-- 
Héctor Palacios


