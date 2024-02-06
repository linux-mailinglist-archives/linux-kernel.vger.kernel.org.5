Return-Path: <linux-kernel+bounces-54744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E51CD84B31E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C9B1F242A4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF57D12E1FC;
	Tue,  6 Feb 2024 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lUE8Juoz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NnwCirF0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAFE12E1D8
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217597; cv=fail; b=XycmHPUCZJzuW4/Rzps6Hp5VtqSdNrOAP1iHrv/hnT/pIaPn+JtwgJq9Mw++F3yQQJa6sfeEDldWi2VTyFWLvREoootwLD9nvz3UDlJ654Ms7YZiUU3yCk/qC/iFX0jkl8idoFLfmiwTiosytoa3RzY9ONsIJlZQOZJuVoXryYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217597; c=relaxed/simple;
	bh=tMsgBHDHapsoU1IsYWLztknCtagmoz7WlGQ/Hr/u6As=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XG2T4GDZqEAj0JxUEC81NQ/Ut5jIwevbswodd5L7PzsmboBfGKVaYEeIQIBBCycqZ3DTymBTcJ56Crsdaz5kElN0wxme5tZ+j06X0d3rWTSgko1JlyTfhSxjAaU1j9GYrXRRu7dEvhigVoAL1Q+YFrO3NWbA7PLVkoQkmmgAGQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lUE8Juoz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NnwCirF0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416APFWk025333;
	Tue, 6 Feb 2024 11:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=4Aqc6bGGyT+rHy+QdD3pBn0IQ36F8RtFMU26Bx5u2lw=;
 b=lUE8JuozEzWVAbnlnzt52sTPdb5gnTaLvfWmzC5uOZEhKBYh2hEZ83PHbb2Q+WFL0mdN
 mrZiS0rIQz0LDhfydNLmq2dMopOymxC5lrKQ10QzjKY5CurbSaR1efviDZUSvX8Ntn1A
 tAwiW3ihLlm1w3mX+IoAoN3T2JF39EQDFrx9SIGPGJ721ZhMpyCT+1F6IMWpyY02PsYT
 ylOib5TjbIfAxg+yXlGyyOR4PUCMyW+kNc55WG7m48EHZY3emL52saVeh4Q3Fu+0sy97
 gwvSedtCsgbUaJA4QtWe+mwzSXrF4c4UBgjhKuxtKS4mJPmlvj7xGZvR1t4FyCjhjDoW AQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1e1v6ey8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 11:06:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4169ZsMU038393;
	Tue, 6 Feb 2024 11:06:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx6x6nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 11:06:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImZYttFkJssFwsH5XwTLNjthTec3Zlr76HDKrpwwPW+cigs2qG1ro4XppFGkGuowUdlWFKr3hbJMbQxYnIDIo4nVWCvb/OZCU/vKj91VVIbaTzs977hQUPVpgn7G7a4wj1mcjN2pVLIIZt4Hu/WJKOAA5JPppEXc+Q/TEOwcnYMca1WjyHhOXv5vhskVoTKzCEJIjpuErRdJjXGIOniPmY7ezpVb+A7gdZDLEFD02cHV4F04/E/sOt/VB32nsEJ9yPt3a7QFe6RUoea72Q5qK9T5eQrYa8Y1zmPmW/3jEjz0QeYxYYbMu6xZ6+8hqCD9LyOzkukowTBRnlqLFb+WOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Aqc6bGGyT+rHy+QdD3pBn0IQ36F8RtFMU26Bx5u2lw=;
 b=bNOxA1K+K37zxayXtV+H1GHgJoneqcWrANxRzifM17VMKuw2udLytb42vfSveubOefvvhtkIo/A1itm2p/7Vbp8jBlteM+WCtgiExurH2qdos4nfIZDvHwpyUYDwybxxS0Okp1NjxmkG0CYe9Z3cHFbdcwpecDiXwnB8qpHaZo8kn+voiyAC0xvVYBVoTzXFNoMIksTFHLYPOku8fatB+zjDJYGpuRwv9iONpGW6II2uQUGI4YU3BecvbG/VvvbOSwT24V846/wZk+EjkQqvUdbWzIRnfHsocYEWO+RzvvGcRY+QwL9SjC4+WMbl2V8sfxwAQE/7wWTl19ypMbDTiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Aqc6bGGyT+rHy+QdD3pBn0IQ36F8RtFMU26Bx5u2lw=;
 b=NnwCirF0UUwhCXnqWme2O0tiXbbQAjwvcBxp9lCLrZGwU8u35V7LXl5mbEAtz2qZLOtQWpLNbpAac+fK2JCgyGSH9KEmmBLcyGTUFE77PqCSHksbvL/8zakbU1gTTLt8JXBxtHRJrIN7b0sgfZngATGU/wUtCLxExzBCQbkJRoQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB5180.namprd10.prod.outlook.com (2603:10b6:610:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 11:06:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 11:06:03 +0000
Message-ID: <ee6ec5a8-e2e3-4811-94f1-d6c25b981a38@oracle.com>
Date: Tue, 6 Feb 2024 11:05:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] iommu/iova: Reorganise some code
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc: will@kernel.org, pasha.tatashin@soleen.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com,
        yosryahmed@google.com
References: <cover.1707144953.git.robin.murphy@arm.com>
 <d4753562f4faa0e6b3aeebcbf88fdb60cc22d715.1707144953.git.robin.murphy@arm.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <d4753562f4faa0e6b3aeebcbf88fdb60cc22d715.1707144953.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f59766d-9708-4e6c-a4fa-08dc27039bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oSjtIlGZURWpUCc1WQ4W3bS64cKQTt+jVJqPFq5Lb9hTTiQO9AsPSCI8vFH+EcLXH6bUBIy+HSySA33OIcdX0gRAmBsvztGwgkLgaQe8SZ6QPnKfiUQfu5ZahYghazintV1as3BGsrcdggOC/B9xHNcXKRc7W/kUw5u3q/rPxQuVXYDNviZXCMtJEfn9DeZ/Sx8dY6XP4nOnba1LIUZMBELkLP7cHt6IGzqH4iPSrQ65v/ZglxAdENTBdkyrZf5NnnXC3sOFBQvDPQIwHWLBb3+mqLz05Q1Wr/7ftwZCCfYU5PA1PlF5jsC1qW7s5bz+mOZEu8IUnAfS0oDrV+JqkhcZXCCeudFOFaAtQ60tz8Exjg42mF6naFugMdknILWb2002c8Op/wFqrbU8hHh60iXBo5gH9Y4prYI7A6w3uJ0nj2WqQU7TAL9Lcgfg/8kmXjfGRVYCzK7p2doKLp1s/r1+dd42CN5pB0k/DAJgJ1zGXMWKgfL9CP3JUSwh/KiUd9H9Q7soQ90VpmcWMS4TPoKdNTkswYwJ/NploG0VDHfc5cbkt1Hi3tWglbweC78tg4wPwtuEP8JgErE44F2zxV4xmUjiz9NhU0ZfaFN9ITKkmWlr/eggovxaGaByHalAitCqLO3ZGNsG6u60x3YvWQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(31686004)(38100700002)(36916002)(53546011)(6666004)(41300700001)(31696002)(6506007)(2616005)(86362001)(8676002)(36756003)(4326008)(26005)(8936002)(6512007)(4744005)(6486002)(2906002)(478600001)(5660300002)(316002)(66556008)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bHdWcnhLMUFQRDVwVXUrbWlEL1ErV3J3ekdqbkU0ZWRQditRMmJ3V1RuR1ZO?=
 =?utf-8?B?K3NGa3EzdGdNZlVlR0NadmJkTjZ3WEdoOU92ajZZZi8yaHRjNXkxa1QwUnlz?=
 =?utf-8?B?VzlYZC9wT3Zkc28zQ2I4SGJmZlUzQlNQbHdhYnNiaGN0M3RKa2ZjakJESitX?=
 =?utf-8?B?Vy9aYnlpbEVra1FrYW1PanRtVVpOR0NzTVVlUEN4MS8rRjdKNW9vVUE4NlF5?=
 =?utf-8?B?RXQ4b0VpSGpUbHM2Rm0rZHdaTG9acHFTVkh3RkZkTE5GblpFc2htTlJnSXMy?=
 =?utf-8?B?OTRlMEw0K2hxdktPcXNHR1RTMFNtQ3FXL1VPaURmK2VwSm0zWE9OUDhwYjJQ?=
 =?utf-8?B?NTV2WGp4bUlZdFBYUEFXa0lsSkZ5aG55MnYyNW81SUp6b01WdHU4b3V0YTVl?=
 =?utf-8?B?Mk1LWG92SGFmQUtSQlNLQ2p3VVR2M1A4VmFwUE9jUzlaVnFMMzFaTXV5cnQw?=
 =?utf-8?B?U3U4VU10WHRVNys0Tnp6djNhQWNFa0VmMVlyREVnVmtITVE2SW9TSXUwbkNw?=
 =?utf-8?B?ZGM1NXVKT3E4L2k0ME9uNzVvRFlMRUtVR1VYMDdHcVN0SDArSDFRNXJXUWRL?=
 =?utf-8?B?bHF1K0dhNDhWampIa2p4MU44Z0ZKUG92Q2VxZGEvaVI1QnJnWnpPTEY1M3ox?=
 =?utf-8?B?cUt3TU5ycjdmdnc4QjFEelM4ZURXOTJYdjZ1UUp4SmdHejJKVWs3Y0JzS2lX?=
 =?utf-8?B?T3RLVFY2RjlHWDhjbjUxRlBxaWt4ZnhVcWowSkRSK2dPMFZ3UVRkUjNJeWh3?=
 =?utf-8?B?b002Q1ArY29iMTNhaUE3ZllHNWNsdnNQQTNnc1BTL3cyK3JrbThRZkdpcG5J?=
 =?utf-8?B?KzVXcFJqa1pnSnBDcEVvbHNIemM5VGd4T2RtWWVHZ2VwWEZxQnkvckhzZUg2?=
 =?utf-8?B?REdaNUdLd3k2OUFaZzViQWxmVWdLSHluendsZzBwVzZmMzQrWEJpNllMY3FT?=
 =?utf-8?B?dDJjUE1FN0xhVWlZalZIblBDeTJ0cUdpd1pSdFYyUnBPSjFqY1ZhUUlZaS9t?=
 =?utf-8?B?eFYzcGZJbVFaZUwrKzZmdnRIWUkwbGtHcHU0aVF2MkdGMHVEbnVtR2s2dVpL?=
 =?utf-8?B?S2FsTGE0QjkwcHBSU0FMU0hPeHZQNXlKZklmL3cybUZEOC9mZjhRTGl6TEw0?=
 =?utf-8?B?U1NYckMrdGY3azd2Y2FXYmQrT0NkRnJOcmNGcHJZbTlVZFpSdTRJdVUrSllv?=
 =?utf-8?B?bXFoaERQUWlGTXpoR1N2RjgxNjRCcmFGcWxHL2hURXQrUW1janFFQnNQTWFh?=
 =?utf-8?B?UmE0SURKOVpTRlNHTWZydHNoUVpQdGlTTS9JZkp1VlhISXozNXowMnIzaGlx?=
 =?utf-8?B?TXhrN2lZc0x6RkVWSVpmOFYvR2VWeGxEZWd5N3JaRmt3L2JIeVkwMFRUTS9R?=
 =?utf-8?B?MXFSanVvcXdYN0ErellPVTBVM0dCeGE3REd4VWxoS29BYjQ3TE42VDhRMm5a?=
 =?utf-8?B?Q0F0aHhwTDI3cUtFZEVDeXFPclNVMTlKNU53RGtrWE1GZEhqL3ZoVGNpaXhR?=
 =?utf-8?B?YWJJVHZ0NE9TcEJCVmF2ZEt5RjBZS050bzRCRUVnYnp0dW4rcFBmY3g2eXJ5?=
 =?utf-8?B?TW92OGJ2ZnRudG1WVWdJUkJBNzdPWDBEOERoQ0JOeTE2aGtOR1lEaEloN1I2?=
 =?utf-8?B?WktDOG8xNnNadVo0eWpuL0FKNTJzclprd0NuNDlFYVErenNmaFpPQXpxRzFP?=
 =?utf-8?B?SGdlMWRkY1I3RXZxMXgxcjZRbFBiWmM5dlMrZmc5UEhsaDRydzEyMnZ2SnBp?=
 =?utf-8?B?M2Flazk2bHJWSEdjWkhkRTBKSFlhZmszRFFjSTcwNktSVmYxcm9wTElNT29p?=
 =?utf-8?B?SWdoMDljM1VYWXUzYVEwM0dTNEpIL0pUNWtFYTJ2UDBVTXNsdWFoN1puNVA2?=
 =?utf-8?B?MVRUclQxcTd6YlFjYVdyQk9rUDQzYThiaVlucUlZekUxTXBwWVB4d2hJaDFE?=
 =?utf-8?B?R2tuZFU3U1R1Qlh6QlV2VDBId2Q1VkhiVzA3WU0wN2E0OUx2b2lTaGdnMU9o?=
 =?utf-8?B?SG1rVm4zZ0tNNFdmcjJiSG5lZVFTaVlPWElsT0F5bmUxTXJVbzFidWdBdWVx?=
 =?utf-8?B?ZjZ2SzJqU0xPUk9pdnA3c2QzTkduODd4Y1piT1BlOTZHNHRBd2xxSUUvMEpy?=
 =?utf-8?B?TG4yT3hrTmVCTmE5WlRuV1dhb0Jyd1NYRGk3R2tvS3YxaGp4UklzaG9iSEpj?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	U0PO86Hmv7LX0JZrTvxYjph/PRHkjG3yQQguvGQKZF6m36G3iJ16nOEN4hLflCIUTH6WJzH3pI3XecjD7uP/FgykM0A43n4fKmDRz0XLYmq6WNG1zJoK1gN0Vet4fxgLfJ9436Tw6pRKxgkCBnQCWSgKh6+GvlTQvyUKWgxQwP2pjsorCeLr9cmCkxEgKkkB+h4BMcGjSMuS8K3UXlAdvltBjr0mJY1F81H1WNy4csmnvs4J6MgB9pVfC/RvO30J1pY6oe1p9ZLDK12iaAfMKVIBJEdIHttE13FPQuRff3SORb47Sv+q8MX8RDlzqN7ltGdbpfEv3Cmg/JkU0cRRmM9PcIe0w8+dDC2WCpz8+NEwzKKcHtafml9znAkjsIcWibbjcjRxinWID8f2B677kOoLIb3ia9c155bd4SLHt59xA+9mECO3MzR6pHLet7m2d/Rad6T5xmx4sbYuHUcdCOQApPaQm98Q1jcAc0HvkiKeUVbJdYKQgz2R7lvVRgtaT5WUrOijKVyeBo4NTxfvYTbJmLDe/CwSSdWiDeOGGRIMtTsEVbxDSlL3vLHUm2Wtc0gK0sFvrFQfWq6Gu7/aBPXnZWBPts/mfqyc3TZx15w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f59766d-9708-4e6c-a4fa-08dc27039bd2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 11:06:03.4512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8AlOMj2FgbkAxyLc7IgDcwAWR0Oe6/5GzJmP4949/sOqWLXMhDEv7RFe1eF/4O0T3R9iwxmOu3TRIBJLOi/Y+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=791 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060078
X-Proofpoint-GUID: 6hK_bJfQmQUYaiDZeyyCATKTRbG9SaSJ
X-Proofpoint-ORIG-GUID: 6hK_bJfQmQUYaiDZeyyCATKTRbG9SaSJ

On 05/02/2024 15:32, Robin Murphy wrote:
> The iova_cache_{get,put}() calls really represent top-level lifecycle
> management for the whole IOVA library, so it's long been rather
> confusing to have them buried right in the middle of the allocator
> implementation details. Move them to a more expected position at the end
> of the file, where it will then also be easier to expand them. With
> this, we can also move the rcache hotplug handler (plus another stray
> function) into the rcache portion of the file.
> 
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>
> ---
FWIW:
Reviewed-by: John Garry <john.g.garry@oracle.com>

