Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631FE76FC16
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjHDIfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjHDIfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:35:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E893A81
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nd/uxMtM3ciwEFCpev5ksOzUiBXJqkHMT2bomzCvwC3aq7lvhypiJZwYVaO1w+pf+4VUYc4JbIFc4k3yONhLzDftFhV+0MheCQTFVVQaCZ3KfRvqwmBthICgI6zQ/nhmVQIGiGkkTI6UEUvf0y3C84InNKjWHdtqaSq+U5vc76g2eWGLOxJHTbTlGR+xjXHb8/j9FD4fLhe2cZU1JbDZ664J2LI+20iVw5k12qJcHQ1brkExGHO+gC+Rg8r/8V9Hn9EehdPYjoLmweu1vzan5GMwyzbUgqi5TSOBCWTSsvDA9hMYWw0FOkEixVDV3WrpRM+rYPaBCXkVSAeV7u68AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWYXF/4D22nSvfat6UDFQKAlPqTipXClhfh/iu71ZrY=;
 b=B0Lh2loOJMqgrNhudRrdJ6ykwH0u5Yq212niAF5yOf8SXbHJbfqm+DfTjwI3bKW937/clAUqsHla7le0bGjTQxqcCvGdvqLrcerLAkB6sX2hJ70TAmk5Ea5dTMs8KmcRkqZi6PhsMUxNWpbCn+wOCtYq+83uGwyi3S94uhVvfqX09R+nL7ODd4q1zalSxwqJ0nW1TJrFiqniCorPMjvefIjpLHYYlV16TdF3gMnLDOhsQ5xF7bZFbKDEa7g4XhSEWdCZNl9jzDNRPshqObLiaNA7YlJkFg22HUnL/26pJsRaj/wFmV9Flvt+7x2SSZhwf/FieUYNXat8+trNXWQ+wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWYXF/4D22nSvfat6UDFQKAlPqTipXClhfh/iu71ZrY=;
 b=AzTH5mDjeHIQDGsuKS9mfPzyIujipSBp16GCpvW7dX/NdqOlAAG2aqzeiN/xq1ok4QVfwUV+QPl977WckzXNHMr7JW1RkDOkULD1R+0JnGXiaNnCC8mwCPB4LTkd/pI2BnujS1KhjbrVZEROEbsGVCiDWPk259Vx0FAcpeMz0J4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 08:34:59 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 08:34:59 +0000
Message-ID: <9b30a5cc-75fa-dde6-2b6b-a39aff9874c3@amd.com>
Date:   Fri, 4 Aug 2023 14:04:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [patch V3 23/40] x86/cpu: Provide cpu_init/parse_topology()
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.026097251@linutronix.de>
 <03ded839-a746-b741-02dd-c10fe37460bf@amd.com> <87leer1aa9.ffs@tglx>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <87leer1aa9.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::7) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4c7b89-bb61-4308-bd92-08db94c5b07f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DRfmGRjg7ZCBYZisSpog7kyojXvo5UwlY5pNpkcufLlg65H0LyK4Cz0NTkKtLR6N49efUHhzXmHFqxtDfAU/WIo70ogmGmKrfYRqXis0vYd1EuJcfITwkIACgTu9gVnhcdFpEbojiM9Q0jo6eWV/QLDHCPkXI1aKZkiRUJZqhblgDvup9V10/YbEDJXKhJoWUvuXTIkgpPP9z5zqXtuhTyGRspjqFxfS3l8B+sV7p++Ke9v7zwDG81ODyy4+Zs7ssZsSCSEHHgUQw7LntF23m+boXFTI4OdLINt6l9TgZ4RzYNIM49aIXzWYgrulxx2LlUL3Jpf105ykj9u2JGFFgqPoV36ywHY+782qGCWxXtlSXWAZfGt66UVdxSGqCSLUKH2MZV0LUWDi0Uk9w/mma6i9ARjwx7KyE54QNezxk3Z6yKjqP7W2wqMvsLbcCPa9srvj8UJd0FP4MlIgu+t0csWeA9hy6BFJzFkRqReK27W3iJKrODt/U58u81Qjr/X4peUXZcaveKRJ/YwzgSBAzwqdsYNold1/R9Xb/sF6PS0QpDLEtrgGgF03ZSSFqD46hq/G604fA6vIheJy37Y4j7yGoDzysL6KSqvSmeVc66pXNtVfsCJy2ylBIPZePSA8ElIEUWZsE0jxe9St0bQosg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(1800799003)(451199021)(186006)(2616005)(53546011)(8676002)(26005)(6506007)(66476007)(2906002)(316002)(4326008)(66946007)(5660300002)(66556008)(8936002)(41300700001)(6666004)(6486002)(6512007)(110136005)(478600001)(54906003)(38100700002)(31696002)(36756003)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFVRajJhb2sxcmVTeU1MMXQyOXUwYXkrVG0wbTNrcWRxYXNZMzhYNXFmbkdQ?=
 =?utf-8?B?NFFmS25qUmZVRGpGaUZjZFVUcHhhcytVMWc3bDdpU2szNTZEWFBDUXJkOHBZ?=
 =?utf-8?B?RVVBbkx1YmVCNGk4UzE1Q3J6TWo3SGk2T2t3QURyYnZRVEFXNERvbHo2c2w5?=
 =?utf-8?B?RzBFQ2ZnN0tGdzdqYnYxT3FoL1VjK0pjTGJCTVVhN0cza0FRNkV6elJ2b0xk?=
 =?utf-8?B?V0lGOXNPUDZLSlE4d0l0YjQzV0FpYnI4RUM5TkEyc3BzOUUvRkdmMWEwOFY1?=
 =?utf-8?B?SW1VVXYyWmVIMzBVV0kzZGcweEp1N3FYUXhpYlo1VWVlN3p2eHJBTjZDTExR?=
 =?utf-8?B?YkNJRHVGWTNPNGw2TEI5M0s4WGJsWUIyMGJzR2cxamJHTFhNdlhic2VZb0hy?=
 =?utf-8?B?eVQ3bUFFYzdqK1FQTUQrSTduM1ZSQ0xRTmp6MXdKajd6VXUrYTJySU9uQ1U5?=
 =?utf-8?B?VVZTSjhIdXZ5UzBrSUhuL3VxeFJBd2ZYNTYyRytvdTNkQUM5N0VEdDdiS1FU?=
 =?utf-8?B?a0Z6cjhoK3FrRDVtd1dkYzhFTit5ak50Nmp2dWZmTy8yUllwSzh4d1BiTTFv?=
 =?utf-8?B?dCs2ei9KNWd1cW9DdVQwZTdjejJKRnlzTWkyaXJLYis3QTNYRUFuNElabEJs?=
 =?utf-8?B?UWRxZExZbnFNckZSaWtrVEszQkpSd2FWOEU3WUExTmJUT0xuakJMbmxBSCts?=
 =?utf-8?B?eGtLVEdlZlRmeDZUY1JyWE5uaU84YThybmhlYWFpYjdIYitIc05KS2RZZm9O?=
 =?utf-8?B?SGdwdTA3eU1KRm9UdUtLc2RXN3dvbUtHSDArcUpJa0xEWHJ3cDczR3pYQXBx?=
 =?utf-8?B?NGpBeEFCZHQ2d3AzL1h3L1JmRDZQc1lpVWF4YXZ1c2J3V1ZJa3ZZV3E5dld2?=
 =?utf-8?B?aXoxZnF3T2hlWlQ0UW9pWm5oanExTFZSVHAxK0lDZ2ppekdJTVBWNmZubGRn?=
 =?utf-8?B?c1FJVzhPdkduYUFMbFg1aFhIZGsxb2F0aTNXSEdRUnZmcUluWmFQbVFtNlJV?=
 =?utf-8?B?VUtNMHJadTdkUnFXN1NoRTJXc0Nyc2l4UkdjcjRVdmo5YmhqMFQyaFQwelk5?=
 =?utf-8?B?UzRmT0VjQVcyZ214UDdva3JDMjdyRVdkYmRTM0hCejZGOFpSOUtwekJUNWNj?=
 =?utf-8?B?dExQZ2Z5WkVpT1ZmN0FGdlUxamJUbDBLdC9hazQzTXc1alZJTWcrbVZoTVVX?=
 =?utf-8?B?YUxKck1pcGNzRjVDR2JlMitHTVlMZEVXTjNZK0VabWM0ejlYRkhadkFGUy9N?=
 =?utf-8?B?aVZzSWRlY1ZRNnh2VDVkMHFvcVVSVWR3ZE5CSityUXE3YnM0d2pwbkx4a1My?=
 =?utf-8?B?cUEyZ3o2MXZaOWpnUDZpM3pLYjJVc25iaStCY3Z0TkdoQ294U2NvMDZnL1Bw?=
 =?utf-8?B?eFFTb0hLa2VMd2I0Ni83a0x4cDZBNTJJVW1YcXdDRGJUYUNtdXlFeXVhZHls?=
 =?utf-8?B?bkFTL0tCS3RkVkRxTS9vNGJPK3BEL3BSbEcySzF1M1V3emt3WDNKSFZPOTZK?=
 =?utf-8?B?K1B3dEN1akE4TG9CaDRRRGNOemJ2cVc1SHIxMkUxSjVTSVNEdSt5MUIva2cw?=
 =?utf-8?B?RFJTM3JnZno2b0ZHUjBwcWd5WXlva1d0eXQ4S1dCVXI2MGcxVFl0U1dBMEhx?=
 =?utf-8?B?WTgyc0VHR3FaSkdTU2NSVldVTDVpMjl2cjJoU3NYSncwSW1ZcUthSTYzT3J0?=
 =?utf-8?B?S2x6aDRpK1NhNDZJTEFQN0x1L2x3cmlReitWeGxPS3NPcjY0aE1aaEdMbE10?=
 =?utf-8?B?c3dPc1RLZHBUcUZwNUFGNkNobmNRSVpwQjBBKzdKZmVkcGxXdUQ2VEl4bWha?=
 =?utf-8?B?UE9SbVhYSkczMHFFMGwyL3gzYkpWR2xkTmszc3NOQnIrc2grRklDYk1vaDdB?=
 =?utf-8?B?ZjZDT1poMWhkQnlOcTVrckt0Y09zdElLNlpiaFYrT091SzdqdHJkQ29aa1lY?=
 =?utf-8?B?T0tFcTRiOVpVblRidC9sNDJpeWUxenhVNVBiUWxBV0hiWGtkdHlIb25vb1RM?=
 =?utf-8?B?RXVtdnEyNCtLbXZLUWV3SFcwV3A2RkNucmxZZjNkSlNpK2F3bTB0U2Z6c1Qr?=
 =?utf-8?B?UVNHaVBQcEdua3pMdm14eUliRHBaZFQ0ZFFhanZHMEZoR2dLMUdCNlB6S2l3?=
 =?utf-8?Q?B8fehpvYrj3P+O91luEBP69OJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4c7b89-bb61-4308-bd92-08db94c5b07f
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 08:34:59.4782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2pHJYqqlTV67z9PsOLcCyHFIUIIkjQOKRsOKNIk+FQiRcwJfIIF0eolRLvWe4+x/Fv418eIZEgvRlpKg85nhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 8/4/2023 1:58 PM, Thomas Gleixner wrote:
> On Fri, Aug 04 2023 at 13:44, K Prateek Nayak wrote:
>> On 8/2/2023 3:51 PM, Thomas Gleixner wrote:
>>>
>>> [..snip..]
>>>
>>> +static void topo_set_max_cores(struct topo_scan *tscan)
>>> +{
>>> +	/*
>>> +	 * Bug compatible for now. This is broken on hybrid systems:
>>> +	 * 8 cores SMT + 8 cores w/o SMT
>>> +	 * tscan.dom_ncpus[TOPO_CORE_DOMAIN] = 24; 24 / 2 = 12 !!
>>> +	 *
>>> +	 * Cannot be fixed without further topology enumeration changes.
>>> +	 */
>>> +	tscan->c->x86_max_cores = tscan->dom_ncpus[TOPO_CORE_DOMAIN] >>
>>> +		x86_topo_system.dom_shifts[TOPO_SMT_DOMAIN];
>>> +}
>>>
>>
>> In Documentation/arch/x86/topology.rst, "cpuinfo_x86.x86_max_cores" is
>> described as "The number of cores in a package". In which case,
>> shouldn't the above be:
>>
>> 	tscan->c->x86_max_cores = tscan->dom_ncpus[TOPO_PKG_DOMAIN] >>
>> 		x86_topo_system.dom_shifts[TOPO_SMT_DOMAIN];
>>
>> since, with extended topology, there could be other higher domains and
>> dom_ncpus[TOPO_CORE_DOMAIN] >> dom_shifts[TOPO_SMT_DOMAIN] should only
>> give number of cores within the next domain (TOPO_MODULE_DOMAIN).
> 
> You're right in principle.
> 
>> Am I missing something here?
> 
> The fact, that this is bug compatible. It's broken in several
> aspects. The real fix is in the next series, where this function goes
> away and actually uses real topology data to compute this.
> 
> I could change this to be more "accurate" as you suggested, but that's
> not making much of a difference.

Ah! I see. Thank you for clarifying. I'll keep an eye out for the
next series.

--
Thanks and Regards,
Prateek
