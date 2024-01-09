Return-Path: <linux-kernel+bounces-20272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8CF827CB7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B441C23340
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F2823D8;
	Tue,  9 Jan 2024 02:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="S53XnOwC"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB4117F4;
	Tue,  9 Jan 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 408NeQ6v018378;
	Tue, 9 Jan 2024 02:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=pycfE4DdKZnEYflI1CIVfpSHZeYG9sAbqBcLrC0ZldY=;
 b=S53XnOwCun86OFzYubF3/ojHsVl8boaWAJzW+f8S7CcTqXHW750ZlmiLoOopk3nyxejs
 /TBDS9H1P5OFTs1mT492hgvOXA9QG0qh+S1VQLsJR9YGKkQQZbxoRJiz7gqejGTze71S
 OB+uvJnGEQF3B2osEh9rgA6HqF/rCUShI4UHQoKlVGMTOt9KQJfcsly+xZrbBJsipBfN
 F0zjaS/UjsCHXsPKK+Q3MHZPMt/8+iJt+JByH9pyDknTxUjFizNHs6xXVgh0LZLVFpY7
 zyVbf2l4Vazdjl12wB8yDEEWrLKh4dy38KyIGU6akOCPPZ84cWIfNhTIi4pCOlYf367a 6g== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3vgg8n7c5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 02:10:24 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 4CAE6805666;
	Tue,  9 Jan 2024 02:10:23 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 8 Jan 2024 14:10:07 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Mon, 8 Jan 2024 14:10:07 -1200
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 8 Jan 2024 14:10:07 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmjPirI+8fmvsORoodm2JCmQy9sNqxwNifO3jAhmwShPz5o/V9EjDorcEt2owWIUso2TeWsB1/h6K0gnVsR0j2IKp1v4nCwycXmFgErWBZfKz2tUNPFV9CeLjQ2WxezBpR2f7F5DuW7I5cs4qND0DJ3EjpPQ4/dUxEmhrg62vjh00pJQaUT/SDSA7NJYoqEIOfvBwRu7dseZB1kELSAyn0C6986oURwDf/vGXQdj+EWaDOzSUpUCilIdrvDc8JK7KcgmbLcwY4UofLLaQXKyit+OE9n/cJxuKyRqHEe0/kVXMnxXv32W6+J33f7XswPmaqAiZVSHA/Ck3xq7aBIU4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pycfE4DdKZnEYflI1CIVfpSHZeYG9sAbqBcLrC0ZldY=;
 b=VZWFbWVoMkqIXNRXYUf8r3a/+7Sup5Is7wd3YIeiZ7i0T2myp9EAbg6w8xk7xWjQfO4AcYjAlwgrWhBNKUGULP4kR6mpP/OkrLgnaYasOxRnnrSJQvLGSh2Qjodvw/SedlUzrAbZxi8D69VTfjznGUTJyu8PB2D1U7qp+fmVDB1bMe4Tst9pI2Ciupazm5rUBkBpK9PkWPyHbRIw9XoP9J88qTQ7nEmeOEs22yysyijGY842207vHcuX3x6oKl3sN9/nBiRe4qv6tGtNjeazPkdjieY2XPTJ3SPDlxZgJY8qb8RTqrZWuSO4Yem2jPOOYA5DTWqUDt8a9LWNQGCAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:173::21)
 by CH3PR84MB3712.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 02:10:06 +0000
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9138:7a8f:9a12:d1ea]) by PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9138:7a8f:9a12:d1ea%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 02:10:05 +0000
Message-ID: <a77797fd-cbe4-42be-abd6-54cc815d360a@hpe.com>
Date: Tue, 9 Jan 2024 10:10:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KEYS: include header for EINVAL definition
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, <keyrings@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <dhowells@redhat.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
References: <20240107132842.4024084-1-clayc@hpe.com>
 <CY9E6M2BYETA.1VE73N3UHD4B9@suppilovahvero>
From: Clay Chang <clayc@hpe.com>
In-Reply-To: <CY9E6M2BYETA.1VE73N3UHD4B9@suppilovahvero>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR01CA0015.jpnprd01.prod.outlook.com
 (2603:1096:404:a::27) To PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:510:173::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR84MB1480:EE_|CH3PR84MB3712:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb2d217-8ac8-427a-02f7-08dc10b81881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v7El0cs09JaFvQtsNjGycf2Om+9g+WoTd7AiIU47cptb+7jnp+bLwmG3JKKSs3gIGqWu91s3QWrGGbYQjY6iKxZUHhU+zDqxaPtxgXrQfq1jE2VpuaB3PVpN5Xzm3Ur4kvhEjB9/lHG2q5ApGNKUNvTpp4mhI0RUSUOuCmnqPoH1eP5KeJ1tkTuMT9V//5tUMw1mirNEsQh1O5wMKsKAXXogD4GAHK6OX6h36NpB/LcszD5GASmf9Oad7llHtvDP52CN7oJdzE2kKCnt5NyLhwX8djL4nG0kB6VHGYbUF9F0KRG8AUthYlBo30LLbA+b5aYBTA48lOOzEnJ8OTpNPwYBXAThjGeyWz7hAWbs8umNVpzERVImX/zAUf0zImrzBHxEKVmMMOHyIe56+OG4z8Hd7mu8OFW4tntgrNdNNRIyqVhH7Vl7/UgAWHEc6U9yxg1kJjzFc5h8qki5UDS8i9gzvnDj80qPnPacdhRBxO+S/gqjI1WhsKBHmb+ztrztpHIJqYlZfZKONKJRRlCyENpIK+GPucMMsqDTg5YhaNtUoYTNxXUQ4FB3NVJZ2MbLrGja63azsqO9AbwyqjR8aX7pCHtzp2MKUvahZBR+GRUpyOEinQiC/Je/TvUH9qWaOuaDUAP+6keJ6bmRaTbvJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(36756003)(5660300002)(38100700002)(6666004)(478600001)(31686004)(2906002)(4326008)(82960400001)(53546011)(2616005)(8676002)(8936002)(6506007)(316002)(6512007)(26005)(41300700001)(86362001)(31696002)(6486002)(83380400001)(66946007)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1FaVzRyMDkydGEzSEpaOHNuYUplVFFWL3lMWUcwNlJnRm5EY25hNS9DajdT?=
 =?utf-8?B?a25tb282NDJkdjN2b3ppU1hsRDJzN1hQRVQyVXFweEljOGRoWE5haktjaTQ5?=
 =?utf-8?B?VmJzeWJiMzFEd283SGxZVkxhWSswZUZsT1ZUMHN6YzFqQmtSQ25vY1R5M1FO?=
 =?utf-8?B?ZC9iS09Ock56RXFkTmQwMUJUZU1OdUZyazhXc3g3WWFEYlNlTEcxMkRGbXd5?=
 =?utf-8?B?TjhTVjhhakxtRFkvOHBybFVVUUpTNWZjTUVOVHJySzIzRWQ4UE03VnVNa0xM?=
 =?utf-8?B?NXpSd251L1VvWVV6WE5UcjM4WXFOY3k1SXdTTTdZL1hjZVZ1SjJXR0pwSGNJ?=
 =?utf-8?B?R2pmNVBuTjE5SmxyVU5kY1IzY0tybUw4Y3YzbkM4SWQrMWY2bGZXRGRlSFhT?=
 =?utf-8?B?VzF0QjZTTzVZd0V6TTQ0Vk5va3owR0REK25iOFJObGtzcEZtRkhJS09aUHRK?=
 =?utf-8?B?NkFCNGE2ZE82WHZOeXhueFRnbDgyV3VpeDF5Y05weDE1aUJ3ekYrSXRJZklF?=
 =?utf-8?B?cnkreWdTUzR3NnkvNFpBV2Iwakg5bUxNSU9HRFhYWll3OUVUUEJKK3JJWUlB?=
 =?utf-8?B?NFRhY0ZkaWQ3ckp0a25BT1k1SE1VMy9UaWpkWXdZaHJMVjIvL2g1d1dDT1RV?=
 =?utf-8?B?K2p6Mm5HNm8rQndxUDdtTWFUbjhPdlJxZEtlai9WdzhjdEltcnlmNllPWG9J?=
 =?utf-8?B?R0pDeTk1cytEQWJzSFRFSTZUdEVkU0hGaFcyZkowT1RZNGoyR3V4WTRYMzZK?=
 =?utf-8?B?Umt5OGM2YzRIcDJzOXUyaFAvNi84bDFEU2EwcFMwdnk2UW12bTFKNDNhTk9Z?=
 =?utf-8?B?eUMwQXFIbk1HUkRtQ08vK1Y3aGlCWXNiN1Z5VFBIaElsM1BvcnNQdUhlZXdB?=
 =?utf-8?B?TDBKNDhPeFo3ajFkMmUySnNFRzR1NmZVQ3I4Y29iMTlpL0ZCRENXOTduejlx?=
 =?utf-8?B?VUdWN1BTVmIzWWhxSmtqbVRTcGZvemxpVjVQSVVzY3lBNDFtMUpndkVpRkR6?=
 =?utf-8?B?b0xtaHZZQ04zdkxQNWlLZ2ZNazZZb1M3dGxDdzgvVTJ3S0FYSjFpYTUrMito?=
 =?utf-8?B?Qm5jYytNZG9jajBlWkw1UTJLYUxyQmpMRGJnR0VhUVA4dTFSNDh4bXVJMWtq?=
 =?utf-8?B?WDZsNlhxakx6NmFzQmxRRzdVQnhyU1RNNElzSmZLT3h2VzFnL0NiUFZDbmNX?=
 =?utf-8?B?ZjhrOVN2elZNcWpUYUpydWphL3FnTXRGRXpoNEFzc3dvdDFvcWdYZTNlY2FY?=
 =?utf-8?B?TXE4dmF3dHpWcEZtbVliV1RrTjYrQUZwckdaMmc4dFVlQm9ZaVIvYkZtb09p?=
 =?utf-8?B?b0lCVTQrbWFIRjlmZ2M1WEpWYWxUR2hYZGl6TXpzcTRzS2VHNkFDWHhObjcx?=
 =?utf-8?B?OHh2MlJWM0NNN1R1RXZIeFlMT29VUjJMS2VOeSttbUpWdlQ5U0w1b0V5RmlM?=
 =?utf-8?B?aHVFcTg1L3VOTUJ5SkJwclA4aW5wdzBmZFdWaVAzSTZ5ZkxYRDdZKzExSEJp?=
 =?utf-8?B?b3lsczJtTEd2OTdxUHB1R2NlT3hqM01CWFJia2R6L1BrTXJTNnRPZzh4SVJ3?=
 =?utf-8?B?YlR1cTFveHViRmYwRUYrV3JPaFJNV05WUk1SdC9TczFmbzZ0elBNN2J4dkFJ?=
 =?utf-8?B?L2NrcHRNTUpDSUNZaEo1TmZyRWZrWlpEbDlMS3Z2VkdFS3BHbUpNMjlDbUFC?=
 =?utf-8?B?VjJqRTRad1g1UkNqUFlNK3ZrZFdBQ2pVSmlZaDhVNjgzTGpQRmduWnIzcVho?=
 =?utf-8?B?c2NOT0x0TDJqRHhyNThuRUpkdkNOSDRMNU5oQ0ZjV09aQXFDdm5PeitPa3Z3?=
 =?utf-8?B?NGl6T1NyNjhYYm8rV3JHLzRHQmZFVFRqcCtHSTZWQ1NBKzlqUk05Vm5NYTE4?=
 =?utf-8?B?R2JHeUlZYmZSWnBvVUljMmFNQlJxU2g0cmNialBkSy9VSHhLVGdmeFN3VUVM?=
 =?utf-8?B?WEU2NXdENkdxMzZMamZ4dW96d1ZDRExTUmZVWWdiN1FTZFQzU2ZoZEwvNWxJ?=
 =?utf-8?B?OFphTEg0VGFkdnYyRWlvRkpvV3N2Y1N3V0FHQm00aHpkOXpJS1pGNWkrd2FL?=
 =?utf-8?B?NUZ1Slo0dHREdHJKMndZOXJDd0NlVHdUSjdiYnJRT2VKYjlBejRqaTF0TW9s?=
 =?utf-8?Q?UUys=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb2d217-8ac8-427a-02f7-08dc10b81881
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 02:10:05.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jplne57d9x57obhUJWip4qvVclgyOO066FYOCuAAEtRylLRlM0dyxsDMNqZu/0Nh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR84MB3712
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: VHUIASe0X4O1Vu0QlI707Cz7MqQjB12w
X-Proofpoint-ORIG-GUID: VHUIASe0X4O1Vu0QlI707Cz7MqQjB12w
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-08_11,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=713
 mlxscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401090010

Hi Jarkko,

The issue was found when crypto/public_key.h was included, but CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE was not enabled. If CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE was not enabled, the public_key_verify_signature simply returned -EINVAL, which was not declared without linux/errno.h being included.

Thanks,
Clay

On 2024/1/8 10:24 PM, Jarkko Sakkinen wrote:
> On Sun Jan 7, 2024 at 3:28 PM EET,  wrote:
>> From: Clay Chang <clayc@hpe.com>
>>
>> This patch includes linux/errno.h to address the issue of 'EINVAL' being
>> undeclared.
>>
>> Signed-off-by: Clay Chang <clayc@hpe.com>
>> ---
>>  include/crypto/public_key.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
>> index 462f8a34cdf8..b7f308977c84 100644
>> --- a/include/crypto/public_key.h
>> +++ b/include/crypto/public_key.h
>> @@ -10,6 +10,7 @@
>>  #ifndef _LINUX_PUBLIC_KEY_H
>>  #define _LINUX_PUBLIC_KEY_H
>>  
>> +#include <linux/errno.h>
>>  #include <linux/keyctl.h>
>>  #include <linux/oid_registry.h>
>>  
> 
> Please provide evidence that issue exist (applies for any possible kernel issue).
> 
> BR, Jarkko

