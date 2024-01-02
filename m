Return-Path: <linux-kernel+bounces-14783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E33822249
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF064284709
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC89E15EBE;
	Tue,  2 Jan 2024 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5rnPWRPz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A3A15E9B;
	Tue,  2 Jan 2024 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ov+jdq6+aYem8p7JIdfOHvUz4frmMIWVGi6qrnmpaXMCsQLw04difkSslumHYmVpKm0Pw4D4Qzx74ari51lVl55Tc7DEqYG8E27njS94vYUN/gF5qJLHIphV56V6nsaBcqCy7hUZrt0E8mjlkB552NVoSAozxf8j35zfp6hyd4OvZks6Ui8YdREvk02GLU9FzkBjF8aZ2dv4SQNc0lPEtNLOWBV2gTaN6AY2mPBUK8f0afcmkrCQUzLdNuQEVrNBJkvqoFF+vI36sGmslZK2jfbPyBhyZzP3T3SyG4QeOPaof3qJcQVJaxoSdUs5xPn0QxqyOPGglu6+SM+jQbJkYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kEm1cvUnSFuuf5Uv9HnrNhwrPAh1jZ5+FdZIvaYYEI=;
 b=FpMu7AMhwegjknyhE9gF7bWG+KqTnqN3sLkds0T3hMDda5zqGgxijiuFDupdO8QxRc2eHx6AnfDev2gDULSKEyFjI4CJuTT3xMw3G8v9CAnKvAoM4JwFNpG7ZP9S025gXOEwz23Kr2vB2oqerqF40OaEsO/NsVfevE38TxAPKeZqlJbFzyVGlwb3DxyRvHrRIHRoSARKt91/OuXCtzzGWNi6nMdu1kbvL/6hQoNzvv9KPqAQ/XQw+qBUFuRxTBAKG2aDcSb54v+vh5cPDX8sjzTJq1i+JJgPttCTtoNsFw6GTH61Dwi6KEwxTfCOOKgknm113Zj3V0LtupdB/Aq50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kEm1cvUnSFuuf5Uv9HnrNhwrPAh1jZ5+FdZIvaYYEI=;
 b=5rnPWRPzFIgitpzu2mOM9+wvopLT2zq5T3OMMHa6JWNOoammDrB+RyEP7wwROm8fgDlxcZUBuxsYAX7aOXorHuHP87VEmGb0+oT3n/INUUfWlfOR62Fgn7waK4xXFmFiCQIxFWpP1iZVoZL6wYTRZgAx40/+Gbr9qyjGbxZXjNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 19:52:31 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7135.026; Tue, 2 Jan 2024
 19:52:31 +0000
Message-ID: <78494d57-40cf-4604-b1b6-8d94ca1c9973@amd.com>
Date: Tue, 2 Jan 2024 13:52:27 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 1/2] x86/resctrl: Remove hard-coded memory bandwidth
 limit
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, seanjc@google.com,
 kim.phillips@amd.com, jmattson@google.com, ilpo.jarvinen@linux.intel.com,
 jithu.joseph@intel.com, kan.liang@linux.intel.com, nikunj@amd.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
 rick.p.edgecombe@intel.com, rppt@kernel.org,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, peternewman@google.com,
 dhagiani@amd.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <170240413801.760665.7930294172146734221.stgit@bmoger-ubuntu>
 <70b27d47-fdd8-46e3-a5d8-6bd9c1ca95fe@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <70b27d47-fdd8-46e3-a5d8-6bd9c1ca95fe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:806:22::30) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c9e6fea-26ab-4209-0e54-08dc0bcc5b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Btt5GY0YP+fFVxDdpmT0V8iB7Ajd5Fx6qqJL8Rtv9xSCsPIbKSx/5F/MDkIynftw6DV4chJdMUeSw/JsUMy36XNCtl44ObLak9BBB4MvVI+6bK9bG0j1UW1tJHKI66DC01NBdMXaU/yui1lhqRq55xbxaMLwEufZHXB9G6Ztq38BFUK5LyAAFXgXjHKrzRciNkS+MuF26jGjdgWxHja7tj0FcQBPnO3pKoOvzJqQ0znj2ZXa3rjM6bUJBI2bx17c2604AS9O/BYEZ7ZODhb02mg5jaM6BXRqteWTAug2acKm1I0qMLTBUWTRREM9h1a8DmeOLxLfiJVyo9tYRPL7p9U5PQ9dejOZEO7Hi9/HxQIW6P42gTFbRIIw/CMCIch7p6evD8kiihFaS0LgG+HTuy6jf60Hx62aA2ewwh47F3sEwsIoWVJWv3IofQjKFUCQhpuRdGdt1XG+9KvHaR0eoYm/5C3nYJeccT26ovXzt3yK51ZZRc2I3TOfgZrjc+bn1afMcwjExegx5xuOtR2ZL+Ky8n/ePN+gB+D85aX+yjDADgBB+DUnveMrT9ZUUfWDMgpz1BShzx+Dx6mLRvocTvRn6cFjJL5D76u6mfJm5JzEhHrAQvzhFrPRDNre/ba3kVV422Ed5HWEHEQkuFq3mA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(6506007)(6512007)(6666004)(966005)(53546011)(6486002)(478600001)(38100700002)(86362001)(31696002)(36756003)(83380400001)(3450700001)(7416002)(41300700001)(2906002)(2616005)(26005)(66556008)(66476007)(8936002)(5660300002)(316002)(66946007)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1NKWkp3L3pVZ1k1aWovV1QyU1Y2ZmFYUU0rc2t5cVFUejRVOTdSZEZUanNU?=
 =?utf-8?B?Z3JKc1Vjd1lXWitXeDZIektzanBmUXV5ZUZaMjZMT3RrOEx3TnNybW42WW1P?=
 =?utf-8?B?K3Q0YTF2OGxYdHJ5MWx4YWZYTVZyaHFTZ2F6NTQ2azJNeExvSE43citoV2V1?=
 =?utf-8?B?RW5NbHRhaHFhaEVzT2xLU3lVVFdaSlNlNE42TmMzK0pDVnFIVGtuMTBjeWV2?=
 =?utf-8?B?bUVRNGM5OGtkOUxIeDAyaDVGeE9DaCsxM2lpUXhLbWVWRkthTzd4Z1B2Wjl1?=
 =?utf-8?B?eW1LallHTGFySGtSY0kveUxQVVJxWHVrVWxNMVdZck0vd3oxblV0M2hYVGgw?=
 =?utf-8?B?UnZmWHB4MGRMUXg3RGtkaUhYREs1SkZRcytaNTVTcTVXRFM1WmdIWXNncHYr?=
 =?utf-8?B?bGM0NG0vZ3I1WjNGL3BLbU0wUXFWbngwMkdXV0lzSWVmQzU4R0pRR1I1UHh4?=
 =?utf-8?B?VktOM242NlB6NlpBRHJtczNMdnByMWR1WklDQ0doT3VZOUxqdW5pbTVML2hv?=
 =?utf-8?B?T2d5YjdhZ2FuQ3U1TXFOM1V0ejE4RC9TY0ZRSFJpaHppL1NzTjFXbDcvMHpl?=
 =?utf-8?B?STJsWCsrMDc2dTIybTZrQjlkUXlCRXlxTm1TeERybnJzUTFHRUE2ajBLUDFN?=
 =?utf-8?B?Rms0VTNQL3p5NU5hKzBoUWtvaW8wV3NOUjQxek1QR0lsZmFXQloyYUNyV1RY?=
 =?utf-8?B?bDZET1RJRWN4NUcxSFQvSzA0Zm5xTGZRQkFZUGl4VkpuSnhQZDFMMG5XK1p4?=
 =?utf-8?B?bkRSYllSWTJGUkt1RUNxWmhKdGVrK1I5cWpPVUVwcngrZFFNdkxNVjdZUnNn?=
 =?utf-8?B?bzNiM0lJOStCOE4waldpcFZ0NHN4TUh5RWg2Mkh5d2RlODVJS2FyOU9PaVhL?=
 =?utf-8?B?TkpxNUc0VEV2OHRRdnVqQkw3TnNncVN4eTVtMWJwMmJCYkVJR0xVbWpHN1hn?=
 =?utf-8?B?Vm9zc3pKcjhNS1Q1RXd0bzM0cWtLaGdEcUt1QlRwZHBCUkU4anRxNkc4MGg3?=
 =?utf-8?B?cndoWlpDUlhmekhpbTIvQzNTT2ltT3Z1YkxjSG5ZdGh1bm9LcVA3SWMxWG9r?=
 =?utf-8?B?b0RwbVVRVmR1MEUyQWRxS3hCbDVHT2tGN0gwSHI0NXFjR1A3TXk2ZmYzV0J4?=
 =?utf-8?B?N2JyUDhPS0liK3Fvam13ZmVIMzd3UGJrSGdZS2Q5dzNNWlRhL0N5TGgzOHJs?=
 =?utf-8?B?d3Jad2cvUDJMdUQ1NXd6WERlaXk3czNDNlN4aXRZMFZDYW1sM1FVOElaU3Vo?=
 =?utf-8?B?azBVQWtnU2J5MXRjSDc2aHJ1MERIN1hLRk16L3FHd3dGT2xpUnBjVjVGaEtE?=
 =?utf-8?B?TVdLdGxPNXUxRGVHOEppdWNnbHhKS1o3QlNiRmNOU3VZdWZjL2lFNFJpai9o?=
 =?utf-8?B?elptSXJMUkhXQTRpdDlFVjloQytRMU91ckdzWG1BdmR2eldEYzc0ZDNkTkF5?=
 =?utf-8?B?Y1ZoRCtKVzh0bFNkNE1tcXdlSEFSSXR0QUdzbG5vbWx5M0dYNjFDZ0N2NUJ5?=
 =?utf-8?B?RURHRWFFcHhlSU1ZMy9oNmtkYUthSlg2TVB5UzR3a0RTREI4QWhSN0VvN2F2?=
 =?utf-8?B?M2RDaGZleVdjZ3VBV1ZQQ3gwMmhodkxtajF2ZFBDY0Y5Y1B5QVFETVBNUHVV?=
 =?utf-8?B?bzZsRTRrMGJUVEFsMjYvRWFFSjZUcXB0ajNYcW0vdHVVSE95OEEyaVpQODU4?=
 =?utf-8?B?T25SMHJHQVU5Wlp0VUU1MDBPQ0poVlFjQ1JPQXg4NDh3cEJMUzg3QTQ0aUx1?=
 =?utf-8?B?WjUvVzNzRTRVclo2M3dtQkRNNS9YTlNIWER3emZNTXAzTE96NzFyZnY5eU5k?=
 =?utf-8?B?dDVwYlJmWFovNkU3TTNxMjVTWUZtM1MydTFodDU4Nm4yZDh1aTVCQWVGTkNK?=
 =?utf-8?B?aE45UUZSUU9xYThCMHE1bURWOWFncDB4QUFWWWY3SUZQSFJvaUxmdTV3RWxt?=
 =?utf-8?B?dG1BMUNiSWwyajBGVlRlVXFmTzFoblM3SFNhcitOblFBU3ZQekcxOEVVUkxJ?=
 =?utf-8?B?eDBmN2d4UmNQUDc4TVVFUlJZa0Q4OTFIcDNqUklqTjVGQlI5SmR2dE1OOEc0?=
 =?utf-8?B?VS85ejhsajFaeUNkZTc1K1B6WldiaFVFSVg1ejFyZlcxem1TWTFyd2lLZC9j?=
 =?utf-8?Q?Nbxg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9e6fea-26ab-4209-0e54-08dc0bcc5b0f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 19:52:31.0741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40pm7v6AKFtgRY4WWMxxOc1UvpOVDRaVeUsQyeRiT8iJuitaSzICwWPNC6MZAQx7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483

Hi Reinette,

On 12/14/23 20:20, Reinette Chatre wrote:
> Hi Babu,
> 
> On 12/12/2023 10:02 AM, Babu Moger wrote:
>> The QOS Memory Bandwidth Enforcement Limit is reported by
>> CPUID_Fn80000020_EAX_x01 and CPUID_Fn80000020_EAX_x02.
>> Bits Description
>> 31:0 BW_LEN: Size of the QOS Memory Bandwidth Enforcement Limit.
>>
>> Newer processors can support higher bandwidth limit than the current
>> hard-coded value. Remove the hard-coded value and detect using CPUID
>> command. Also update the register variables eax and edx to match the
>> AMD CPUID definition.
>>
>> The CPUID details are documentation in the PPR listed below [1].
>> [1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model
>> 11h B1 - 55901 Rev 0.25.
>>
>> Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>
>> ---
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thank You
Babu Moger

