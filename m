Return-Path: <linux-kernel+bounces-38470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA01E83C05C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A17329D6B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AF55A7A4;
	Thu, 25 Jan 2024 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="WoUQR6y8"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC9F1C16;
	Thu, 25 Jan 2024 11:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180539; cv=fail; b=T3pg/CChZ9ICUTldWSkhsDbOqM5iHRYh6yLh07Qg0vlzJspPtvYaHxYIlBGXuzCbEYU8prQeAradzqaIln6zmp0BycOP1xzKp07tjzTMPXMXTrvvK+tTu9uRBNmFNCj02RDFhhj/TgJVLuzZhkXrGR0qE3AAvqpRPvy1cW+2sls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180539; c=relaxed/simple;
	bh=HJ8f4/z7q9igcCAgKEQYvDxvL4zoBrPqJPfqtmnYu+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iRbcAJETbUnYO48rheDwb31rU9fAcvVesTkwevWLfNIwHwp2bDHzuasnYBBW/5Gl5d06WJ6b7RcZPKDTOhLuS1LKW1fyxOh+6ml1SIr/ynFgLQIrCPEwSS1/NX+yFFKi2oMBZAYzqDbulazLZ6N5rHL1FO4Hi/gf6NjamemU6Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=WoUQR6y8; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P9HLkA004362;
	Thu, 25 Jan 2024 11:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=GO9WRaVX6/+nJi8HfTszljmrC7VJB15wwwINaqu7qW0=; b=
	WoUQR6y8gpz8JkcWJsXZTvBiN9Z2CZvs3bjrJfIm1jhtlFX+/akw2rphYYagAjr6
	XYB4MsuqZwDzu+ktRu8ebe4YDt0Ofk57KySUEulOOVBuLOkeyw5mLINgQKT9TXq2
	j7RI+MYmgXSSuJ9LkUZwprZbWwFjAeO7IMejDnvD2V4jq5LGiI8YPg6PoHUJr9xL
	SWJ6rLI6TUOTW04jpMNgf1n+K3eXe9HWDNsmtdbsH8Lfmhw1VxXEbmutGSrQXZbr
	d4CJ43/H4qXUi0Zf87mubezbOdPPNVeSZbFZbkHw/sVUvot8nNcxsrkIbPhRfcaV
	8kjTg3LxealIVCuWsBB0/A==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vucv20e4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 11:01:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6DnVtGmworZO5gYBRYm7PDPJOHMWrc0fO+tXslNEUXH5ItqoHRcEIEwCw7JX5rw6nqvM4aEKeQbZnG9wy14xyaSmoXfajvx4+ZRfHu/O+GJyR9HH6/KEiNuziWghuNgQN1hqkTRWQ8yFlWNhSllUteXlWHN40UBZhI1HeLXerWOdtiAhnUVPaYORBsT9pPaEJM8b0glAhooaIWP+3BMpXpWWA74aH9r25qzSK1nKwO19+ftYIy6gwZopdP7j65Ko1JJs29M5krRyGxte3kEHDm7dhkrbc0m/go44yL54ZkpZBAAOq6Njz+m7tVgwML5c+Yw9p2Uh0RBbzbtt+ZloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GO9WRaVX6/+nJi8HfTszljmrC7VJB15wwwINaqu7qW0=;
 b=e83vuh4EfKOtUgTgxQxWbT9d8q9xMrWUc/IRrpAlJhz8rLOOsp5RoGQhqa0lnRlbdp4WXnmXiYZq+yq7YSQKS58RTRp8uWpbw21P85hN0t2XgM0ACTTkjkNGqjG6wayWFdTZFrRMsrXNI9D/a4QDQgrc8abHekUI+b5nSA0Amh+jMFsX8PpffHwDBSc3Kg9ycN1B/xsx32pczID7R1x4aYJwlp+mL2HilWS3h6SuuiR6PF/CIMrGUiFILkTnJkAtbqtYvNSrImmIllmHhSQP34jfGNuTzKkSheNYQizJ4arLcqs7j6nBhej3ANcni03JCNCtV3YpkI3EVc8eQj7+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22)
 by DS0PR11MB6423.namprd11.prod.outlook.com (2603:10b6:8:c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 11:01:50 +0000
Received: from DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::7c2e:5b95:fdc2:30e]) by DM4PR11MB5327.namprd11.prod.outlook.com
 ([fe80::7c2e:5b95:fdc2:30e%3]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 11:01:50 +0000
Message-ID: <0aa0664a-21fc-48d6-bc88-c752f5a10ebe@windriver.com>
Date: Thu, 25 Jan 2024 12:56:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: iommu_group_alloc_default_domain: Fix
 ops->default_domain codepath
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, robin.murphy@arm.com,
        will@kernel.org, joro@8bytes.org
References: <20240123165829.630276-1-ovidiu.panait@windriver.com>
 <20240123174905.GS50608@ziepe.ca>
From: Ovidiu Panait <ovidiu.panait@windriver.com>
In-Reply-To: <20240123174905.GS50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0273.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::40) To DM4PR11MB5327.namprd11.prod.outlook.com
 (2603:10b6:5:392::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5327:EE_|DS0PR11MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c5b240-c84d-46e4-a068-08dc1d950819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FKGoFgnCStnVuTe1VNILp3SYIH+EJsYTI+wO1MY5CiFGGOvJ6wJiSl8Ki3p5iZOsVmZFSe4RiMdlYrEW7CaIcpFYasN4a0RgsFYVljeZ6tYcnwALcVnCJL/9pi/P4Rw1xVMzfaHu76R+Bdit5PoIG1+7L66ll2QEbKo+vRr0scpxLh3qN8R2aTyHICeO/AKw3FtvzDdegsDHNOwq+2o3dp8skUxy6sy6dbFiH3tN1GzAKL8ixw3MinoMsGOzZlE7vl2KItCxGpa+si3XUzva9csrm2BpIayVhV4GuHuZYRxXUukxY+Phcfn9jrTmGHfZFB0gYZZXjd35eJgFNliKaYwULaS+UhgBNHgvASf9G6/gkDqhPYNICkv6DBtYJCJqOiseI9WLYzOR82W+PLiwaC/pvjMt/eRnlRCMhWL0JTbMQYPWiWbpcvsC0gEXui+2awZmk0aKL6gmPzxMIjCv5q6kkoe18gnk2U1ekvvYZXSkK8f9ZCBsJ1o5JpMHHHADiWLVk3uQ0yNeP9y+kGe7NBWISxBmraur3hs1rnOnHBdZqgMvpIkZcfqtZo0+CARAWOcb3RM2zowDuCKjse2Y065Ld/wOqqjUyijKM9O4VJT+iWhkMy3SZ7KOG05x2dMlRnw3AOFjtRuAfU2JBUTucrvJflKGFOfoz75vHgnIxozVEGA7zVKqNh3cTWRy1aqt
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39850400004)(376002)(346002)(136003)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2616005)(26005)(53546011)(6506007)(6512007)(83380400001)(4326008)(8676002)(8936002)(44832011)(6486002)(66946007)(478600001)(6666004)(316002)(66476007)(66556008)(86362001)(31696002)(6916009)(38100700002)(31686004)(41300700001)(5660300002)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZFVkbU9vYXltUTBPQThNWDdvS2QrL2Zuei9kaG81c01YTUVNYU9ZWmM3UmVR?=
 =?utf-8?B?OE5vZXIwRU50ZUs2RXBNb0xVaW1HRmh6b2JqOGQwU3VRV2lvWC9uc3p1Ui9E?=
 =?utf-8?B?K2V6MWh2LzAwRG05SlhQK0MwKytqYWoxZld4cEFhQUY1YW9UaDRucnVJVm14?=
 =?utf-8?B?TDFpbHVZMWlVRDU0VWc1STk3QzZrbU8rMmR5SUJhUE5LNUdDbW1nRlRwaEd4?=
 =?utf-8?B?VDNqQTNOR1drYXFNd1VOYUU1M2c1WTlZTjA4a1NyM3Q0SThwSGVDQS9EQUk0?=
 =?utf-8?B?Y3VPL2dTWmRDYkRTZ0VLVGJmNjZEMEhTd29teTNtcEwwT2lBdEJ0Rm13SGc0?=
 =?utf-8?B?d0VWUktWSXU3WE04K2FISGlDVTd6citwQ2hJVUhXZ1puQlRXMDh3NnZ4Qjkv?=
 =?utf-8?B?enBLZnNiZjFLMHdGNDFwMVk0Qjh6dkV4S2RQdEI4VHA0eWlPWlEzdk5mWkFP?=
 =?utf-8?B?OHhINTBPU3AxU2hwTmxGa1ZDL0xuZjJtQnJ0V3lCZlUyckhTMHJzaU5Pa1Q4?=
 =?utf-8?B?aUZaeklJQUJzay8rQ1p4YjlPS0dYZ1hUdXNBa1R0NHBvKzlHL3c5RnZnblFV?=
 =?utf-8?B?UkNnZHZJWE9PeEZ6RWNHQk9jaGVXRytaNElBQ0ZDQmhUZHNFNHFkdkp2OE9N?=
 =?utf-8?B?MTFNZW01YVBFazlSazJoVmVMblI1ajRJckVrTitOeGtyOTJlODNrQ3RMKzJq?=
 =?utf-8?B?NnVXR3hVaktUalh1ZVJLaTdiMzZhaGt3MWUyRkQ0MWx4anpsYlRNSDlBMVl5?=
 =?utf-8?B?c2VEa1FIYWNpY0VmMUszY3hQWmhEOWdKYUxLelNLU0ZjOHdwSFBKRDlCTUNo?=
 =?utf-8?B?VndpVmhuV3IwaVpmTkdQTWJyTFNMdFg0WW50OENVL3MvdlJoQjAwN0UvRmRl?=
 =?utf-8?B?bVhZVmIwQ1NlWXFlc0UwWjJyeUJ5RnFaYjVrOEdyVHFWMVF0OVNSYVQ0Tm50?=
 =?utf-8?B?SDBqYzJLczFTQjhQSEpuRXlkdnRGK1IxMkpHUkFpa0dhL2cwb3JxdE1XN0RF?=
 =?utf-8?B?WUcvZmM4VlRLVGNHSXd0R1MxZzRzSG0zaGRNQzgwL3RnTjRlcXRRNkVQLzls?=
 =?utf-8?B?UEU2N3ZHOWxra1Jjc0w3eWRRQ1lsb3o3NlZXbVdYd1g2NFB4NVlOSlZ0WWJJ?=
 =?utf-8?B?cjFkT25oM04wL1NNbGVkNXFuR0RYcTBxNnI1NXBjZ3RYa21MSEp1VUoyVVFx?=
 =?utf-8?B?UUppMGRRTmp5SmlGS1E5UnhuR3U0U3hFYlR0cFVNdkJ0Lzl0UzIvaGw0RjFB?=
 =?utf-8?B?eUNRRExzRFlnZDR5OElUV3hlN2hVbmMxN01mbmlVQXBDQjVMTXQ5R3BKTVZU?=
 =?utf-8?B?NGw4bnJUak1kbjNhQk8xMzFDaTRjTzM2cGFnZnp0T2FBVFBVMmt5d2VPL2c0?=
 =?utf-8?B?S3VnQlBHd09mLzdIb2I5Um1kaWc0UEE5TElDeUw4anhmMmtsMzY0N2VRTlRP?=
 =?utf-8?B?NU9GYnFZbEVLaTZYMGR6Qi9oL050RXBkNnByclBHYWdiNkdTYW85RzBpZ0ZX?=
 =?utf-8?B?RFpKYW81WUN2dCsrb2FBbEw1Z3VETHhrekhXNDdYeFN5cFd2eGl0T0VkMWI5?=
 =?utf-8?B?Y0owQmJTVTF3c001WXAzYnAxSHdlZmZxWm9YazN6ZEdLei94anR0QVFXcWVX?=
 =?utf-8?B?YjdkNjZuR1FOWXRXU3hub2FoUXlEQkZIeklIU2FLa3VEbGJqRHpoMnloNG9o?=
 =?utf-8?B?WlN4YU1tb3dRUS9XNHhBUVBWbjQ0YTV3cXVZTWJqWnZJR2YwcUUzbTlLOHhU?=
 =?utf-8?B?aGc4Y2tQcHBlVVk2T20vbjBFM2NJcmhmZk1zbHd1eitKRlllZEt4V1JmTFlB?=
 =?utf-8?B?U1dtcktMWUEzZldMNEREQnA0NXJhMUVlOU02bngrU3U0cTFaRyt5dDNXR2Zy?=
 =?utf-8?B?cCtKYXhyS2RtanBHeTdHVEdNWENrTlVVN2Y3LzllZVN6dDU4NEw1RVp5UTk4?=
 =?utf-8?B?Yk1UdFE0d0NGNE84L2hJNDJ3dmlxRUEzc09IMk5VOW5Mb2didXo1UG1uMVhP?=
 =?utf-8?B?Uk9jdmVnaE1PekwybUZUNit0SXRTeXc0c1EzTWs4UXBLVWRSdDh5R25wNzA4?=
 =?utf-8?B?Z3N1cXRuai9mQ0ZyZGdSMnM2bzZkQmlzZ2Q5QzFGQXNpdkkzbWpBVSsrZXE2?=
 =?utf-8?B?SVJEblozU2o0QS9LM05iMmt3RzA5K0tNWm9rdFlSdkpsYkNwdDdkWHI4VFpk?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c5b240-c84d-46e4-a068-08dc1d950819
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 11:01:50.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LqvUSrsZAUjxQUPnXaVjgCFGBqDI7OM0KrBVA46QstGKODLhp8eiadhKZfQIbBpOfe5+TyFzaWORXBf/24RFOrIDglIEvpZj/joeZroZ860=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6423
X-Proofpoint-GUID: rQtY41uuo8ZqzruOwId8QdDaD90Qo5hU
X-Proofpoint-ORIG-GUID: rQtY41uuo8ZqzruOwId8QdDaD90Qo5hU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_06,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250075

Hi Jason,

On 23.01.2024 19:49, Jason Gunthorpe wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Tue, Jan 23, 2024 at 06:58:29PM +0200, ovidiu.panait@windriver.com wrote:
>> From: Ovidiu Panait <ovidiu.panait@windriver.com>
>>
>> Since commit [1], FSL_PAMU initialization on t4240rdb board fails
>> with: "fsl-pamu-domain: pamu_domain_init: Can't register iommu device".
>>
>> Commit [1] changed the behavior for drivers that set ops->default_domain,
>> as the function iommu_group_alloc_default_domain() is now called with
>> "req_type == IOMMU_DOMAIN_IDENTITY", rather than "req_type == 0". This
>> causes the following EINVAL condition to be hit during FSL_PAMU
>> initialization:
>>    ...
>>         if (ops->default_domain) {
>>                 if (req_type)
>>                         return ERR_PTR(-EINVAL);
>>                 return ops->default_domain;
>>         }
>>    ...
>>
>> To avoid this issue when ops->default_domain != NULL, remove the check for
>> non-zero req_type and always return the proper default domain, as set in
>> the driver.
>>
>>    [1] 0f6a90436a57 ("iommu: Do not use IOMMU_DOMAIN_DMA [...]")
>>
>> Fixes: 0f6a90436a57 ("iommu: Do not use IOMMU_DOMAIN_DMA if CONFIG_IOMMU_DMA is not enabled")
>> Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
>> ---
>>   drivers/iommu/iommu.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
> Oh, that is a neat combination of things
>
> Removing the test will cause problems for the sys flow - I think the
> right thing is to get the correct req_type earlier. paml wants to use
> a specific domain type so it should not be switching to identity at
> all.
>
> Does the below work for you?
Yes, this works, thanks a lot!
> Also, what is your interest here? I have been wanting to delete this
> driver, would your system still be OK for your usage if it was
> removed?
CONFIG_FSL_PAMU is enabled by default in corenet64_smp_defconfig, and it 
looks
like many platforms are based on this config. I actually noticed this issue
while boot testing the mainline kernel on the t4240rdb board with the 
default
corenet64_smp_defconfig.

In this particular case, the board still boots fine with CONFIG_FSL_PAMU 
disabled,
but I'm not sure how/if removing the PAMU driver will impact other 
platforms.

Ovidiu
> Thanks,
> Jason
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 68e648b5576706..7fa3ccdc3286e6 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1799,7 +1799,7 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
>           * domain. Do not use in new drivers.
>           */
>          if (ops->default_domain) {
> -               if (req_type)
> +               if (req_type != ops->default_domain->type)
>                          return ERR_PTR(-EINVAL);
>                  return ops->default_domain;
>          }
> @@ -1871,10 +1871,18 @@ static int iommu_get_def_domain_type(struct iommu_group *group,
>          const struct iommu_ops *ops = dev_iommu_ops(dev);
>          int type;
>
> -       if (!ops->def_domain_type)
> -               return cur_type;
> -
> -       type = ops->def_domain_type(dev);
> +       if (ops->default_domain) {
> +               /*
> +                * Drivers that declare a global static default_domain will
> +                * always choose that.
> +                */
> +               type = ops->default_domain->type;
> +       } else {
> +               if (ops->def_domain_type)
> +                       type = ops->def_domain_type(dev);
> +               else
> +                       type = cur_type;
> +       }
>          if (!type || cur_type == type)
>                  return cur_type;
>          if (!cur_type)

