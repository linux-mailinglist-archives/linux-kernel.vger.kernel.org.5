Return-Path: <linux-kernel+bounces-6737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E570819CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCCFF1F2894B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A830B20322;
	Wed, 20 Dec 2023 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qUNEaR4D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5C1219EA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmNF2W4Xx27BWaPiRsximnfRv+7gfIoPpKqPsohXnk46BikxM6cbqVqyvGbrfhsYlC/bDphHiGvapcpQXdtcfMn3KNfDkPsGI676ZgPL/I2GlSaEMRo73+qJNb5sLGj3eSbYK5NAWV3I8ptcdCmdf7Unbc212ThHMNJjrjLPb4u8fcbma7If4fTkN7ASYzRH98AZo6AMpYv1o5gKunHjNYZ5IMow4//f1FoVXFovvH3KOsIUsnT5L9QQ/lkE268IuNNnDAjcD8tnIiCUsthuVQhSTYhaO4xsZlCMZjaSnXgCwUpiXYNn6NNMOCiJ2IDUN0a5G+uaei1eiJIxS91XYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPh1Cxx1/SUddMoM5I2AcQtVzhUlKA4Pdbyr7kN+r78=;
 b=j3s42ewOaJjteACpgb6H6OS2VZuS+1YEz2DlVeyOaqBZzXMkj3yYLSmcQiSg6PgJyjbbhAQApPV7ynW954IOSv7giaXe8dDzu9UUvL0E4WhSV8o6cv1SI8ZEP2n483HUtK+aPyN1TVC44WhiRoPXC0wYzHF23+QnUdP8Ah7leIRWCFZMpPNYJYaa5lvHWxajJlxwIUZAapptnu6g1k2z1z+ssYVpeyqCrW6hj/pIz2GcHThHDRbKKSqF9KwVWaO1FPsfmMAOJ/gneL/9ZioXfp2Mb1Ub4wyyRvSgG88+6WliuMYuHvXwG0oX9ZxWJqEaXbAjMAs8FF+PQxUpBfT4cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPh1Cxx1/SUddMoM5I2AcQtVzhUlKA4Pdbyr7kN+r78=;
 b=qUNEaR4D7h8XLqLPOg3erTccaYnZw7DmrjoZ/v+Smda7Mfezk8OwfaV8YWd2go2b0pyQD0RYfv/H5Rg2ZG8TNAWuhv7jmjngGWv6tw2iU8uy9dUVjJYqRz9jVWldrE1whreV9lCSbddISqzIPXMBKJb0M/If39awEu8MbVLIMhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 10:23:56 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::e557:fd55:457:12%4]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 10:23:56 +0000
Message-ID: <6d7163bc-db76-42f9-8c5e-f9b855b233fc@amd.com>
Date: Wed, 20 Dec 2023 17:23:48 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: amd: NULL value may be dereferenced
Content-Language: en-US
To: Alexander Sapozhnikov <alsp705@gmail.com>, Joerg Roedel
 <joro@8bytes.org>, ToWill Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20231219100219.17332-1-alsp705@gmail.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20231219100219.17332-1-alsp705@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: b78e7a82-7b0d-4dbd-e595-08dc0145c5e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YBNlMtPh/JDCiNSaXbWF9H0EVceFvuaVU1hIFyJfx/IZ1XdUO2DWo2hwAtqt4fxHO27QIi486jLQ67lxz9rNoX1l1hFbH3hWZCq5hC3eDK+Id0C+eMTosVLo5rW46bbhNfM1/ohSifcjiIEXk81VI+HYQDRZpvdUafJwXqsHqhUQdWWUt7qsEql4GvdCQn61Ra1rdAtXbHoSSFFsiQc+wF1r/XOP3WQGoMFjjXt7QqBT3S6l0yyUtdbFhJzZkXoNHGH8oT5MjT7/Prmq0Lu+glTzgPDKWLW3txuvv86ffbme6/pKvmuSY9ybSghNRRhdUgbZYYZjghp1ioyeAm5mfMthhthjkY5SzyQ3jvhI7h8JEiyYoIf1VqCRzIUhZghnEu1PCnNo/FtpyPIN4yi2k90cexEBBdoTy3a7j7kK2sDgefVdpojDQoWXL33LH0Ptyv1ge23+NrxMdFTnMniNlWjbxwltrAI8a65sKR35/T09/90xl/aEPsscV+5/9ryXA4T3psp3crII1DgosVu/TQPh5RSA2KA1qghjWpu04MN9F2FIvQoJFD0nvtJswenqBTdn+EJqws1U2BWX6zUe4OkRgoAtkcistkr3oBXwnbml87ivVBS5k3BDw7EzjYUlE1IW8o3TvHIEZTd9XGtiSg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2616005)(26005)(53546011)(5660300002)(83380400001)(6512007)(8936002)(6666004)(6506007)(66556008)(478600001)(8676002)(110136005)(316002)(6486002)(66946007)(66476007)(4326008)(41300700001)(2906002)(36756003)(31696002)(38100700002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3ZIajNqck9DY1pYK1MyN29ZZWpTUTNGc2pIb29FT0RqaENsaGZzQzM4NjBn?=
 =?utf-8?B?ekswdVRUWEk0K0NQTmV5dTNocTBGOUxoaE9aZW1DWFF2QlUwT2lwWXk5Mm1o?=
 =?utf-8?B?VFNRdDdTMFNHSUpkRWdUaS80Q0RJdENLWkhPWWpOT25IcmNIbVdVMlU4Y0xh?=
 =?utf-8?B?cDlMYnJCcnlnbjh0NWFHWHdFUDE4WlhqU0FKS0ZpakZzSjBEZ0c3RTh1YlJI?=
 =?utf-8?B?K3M5QUk0MllOTzVmT09uM0ZobkRHSDdLN0xLVHdFQmVQNWlMaEYyZ2NxUVFi?=
 =?utf-8?B?akJYRGo0TUpvK3laY1hCWjdDU3ZCbmJwL2FZQnU3UHRldi9KMWRDYmszOVZ2?=
 =?utf-8?B?SWlaYnJxQ3R0Q1RmMFF2K2R4MzlVb3dMZVhvZU54Y3Rnbi9nQmFpTzJsT1Fn?=
 =?utf-8?B?cGx2TjUzT3FlVXZ2czJmdFd6WjdtSDNmRXBvYVhJZGU5MFNScUFWZWc0T0Nu?=
 =?utf-8?B?REFTbmlKbjFHT2VQVTJZYzlHMEs3UktFeVlmcVgybHRsVnEwWDlJemU4YUVt?=
 =?utf-8?B?bzFUOGcyOTUyTS94eG1ha3U1M2NPOWQzcDhBaTNObG1GM1M1Z0ZCek8zSGhm?=
 =?utf-8?B?NTFCb1JaSWYwTFFqVGFrb2ZLcmxOa1hVMnJKKzFUL25peW1XRzVsQ0hCbUNJ?=
 =?utf-8?B?L1drNGVOYnY0azR1SHI2QzlwelNZMTJqNk9iRlJLMjVzK0ZRUlJQMElTWXhN?=
 =?utf-8?B?M1c1RlBnOTJxWDJWT3BaNlV3MFZyUStPQVZVd1R6K2ZnQ0NraFZwSHd1cmVo?=
 =?utf-8?B?eUFTYnRoUDRma243VmdtcGJTaDQwU3NWR2ZKdFl4YjBKY1BzMzZSSDJDWFpl?=
 =?utf-8?B?U2hDUzVJYWRCNkxKOThSWVVxWko0dUFWZWM3dnVYOWpVSHNMZWJjMGNFMDJD?=
 =?utf-8?B?T1JxZDBtQjYzNDlwelUxYVA1ekdhaUNDRytHbGFJTXVZVUZrYjJ1RXdwc1lk?=
 =?utf-8?B?NjhPbjZvUUx5ZXJ5ZWdYR1JIN1Y5OFdReENDK3RHZkJRaktuMTBLa3lhYXpP?=
 =?utf-8?B?TXVMNUVoYnBwMWlYU01rdDB5d2JwK0k0VlVTOFNKc0dFVjh4RndpNzFNZ053?=
 =?utf-8?B?NkNnT3dkWkk1UGFoT3J0WVJLN1ExUUt5Mno3UStaWGlOWmtmbldCc1kzd1Rz?=
 =?utf-8?B?OFFORnN3VEswTWk5cjY3dUFQcXRqT3ZxZ2ROMDAycVZsdHZxRTBDRnNVVWE2?=
 =?utf-8?B?RGZWSEd0NnF2QTBuS2FsdzRtY21WaFdkMGl6WUFXYlJXY29UaUVYVkd0cnl5?=
 =?utf-8?B?eE5GdURIOWZ5TGNOUFFDQ0RMZXlxL0llOTJQOW52bFM4NzNMNmJjd0dQS3cy?=
 =?utf-8?B?ZklhQ3hrUkhLc2lKWGx2Y0hpVjJxdWtpbFA4clByT2lvVjhZaktUcWRRYVBW?=
 =?utf-8?B?NFlGUGt4TGF3bUpkTWJxWlc1bHVJZEg5N1Rjci9aQ0lQWnR5eGJqMHdnNkNB?=
 =?utf-8?B?azRoNVdOdGdhM0JTYWg4bFRaSldBRFkrd2pmZUU1SEllSXk0TmlteFpGSW1n?=
 =?utf-8?B?dGVHb0hFcTJvbHpLV2xyMFY2WTN1cmowL1hvWi9rUTQvWDY1NURoS0gzSDJC?=
 =?utf-8?B?dDBsMWI0aDRsb2RFVEN1R05FaWlJMTFJSGY5MWNNVFYrM3dpUFd3cFhuYzJ3?=
 =?utf-8?B?NGg3QTNHZzJFbVRQOXpJY1hTWWtzbHRuTjhobDBTV3ZkVHdjSVNUUDdKN3JR?=
 =?utf-8?B?VkZieHpsL0t3cDB1SElpMUUrZWV2M01GamYrelNKMGF5RERoU2dKd2p2azQ4?=
 =?utf-8?B?UDJqSXltem5MS1lrQjVNVnFsVkhyMzlvL25kMmtGVzFRQkVHdHMwc1VOaXFP?=
 =?utf-8?B?czY3NFVsbks2YmtodTE4QmgxOHFPVXNzR29xYVNqOHVZOUVBdVlQTE94QW94?=
 =?utf-8?B?Vjl0TEdySXBEMVhNSXBZa21PV0QzTzFnWjNtSTdja3pGSXBZMXdZSlBWUmVH?=
 =?utf-8?B?cGhHMlZrUnRGZnMwT2h5ZjhiSDNvU0J3aTZjWko2N1BEYmtYME9zZUtlVFZy?=
 =?utf-8?B?Mjk1ZUhXRnVvd0xxUFJDVnpndnkybFgvcVQ0amYrZzlLL0RZMkRtbEhRVVZr?=
 =?utf-8?B?TGpxa0ptcEdUSU1uMVlLU3c5clNRT1ZFaUxBVHBGMDJEMjBvZmtJY0JzMDhu?=
 =?utf-8?Q?jlzxvzOj4mHjqnxmlKdMHJSiV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78e7a82-7b0d-4dbd-e595-08dc0145c5e3
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 10:23:56.5607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwODwT3TMN2yQ/o2+kOl2+fib7Couc9kyZil8t+1YcUXAOlC79edwc8Y4XVMTgjjS99QqZFNsGMTbcdJGASQZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801



On 12/19/2023 5:02 PM, Alexander Sapozhnikov wrote:
> Pointer 'dom' which was dereferenced at iommu.c:1993
> is compared to NULL value at iommu.c:1998.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Alexander Sapozhnikov <alsp705@gmail.com>
> ---
>   drivers/iommu/amd/iommu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index a0924144bac8..64a88e67be9c 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1985,6 +1985,9 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
>   {
>   	struct protection_domain *domain;
>   
> +	if (!dom)
> +		return;
> +
>   	domain = to_pdomain(dom);
>   
>   	if (domain->dev_cnt > 0)

This check is already added in the following commit in the next branch 
of the iommu.git repo.

3f4b87b959ea "iommu/amd: Make use of domain_alloc and domain_free"
(https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?h=next&id=3f4b87b959eab362b89fce6ceb9d1badd102e5ea)

Thanks,
Suravee

