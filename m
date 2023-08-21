Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6557825FC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjHUJDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjHUJDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:03:18 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5665AC1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Njs8D4PZhGfrFmm8MFfC4px+XBEi3dW2aX6hqhfmrUUjvs027m72sYAOg2V/kuvAVCH7DX8x8XazHX4OampjIoykdKpohLtNMfDez88oP9LBezOfryqZTBmOgoS/ziG3ZnKyNkTQMjLTl83rVxAH9Dth9XfQHDfYo3MR300j4UywrhUodFyOPSBHHA32VXXWLmxDUTOl1n/EjDPcqX3/KW1ZzseuPUU85iQWb98BLfqtN2bxu0cnZAgWVItM8Jmpw/wdp4jLoBrUJ4AaUcs8R+Y5hbN/BeUoJbdny5pW/iXSHpKmSFCsWKiwLm9g58Uq8T8W+apKS4p5Si9DsUqD3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCwT7s/KlJCT+RhhQ9OrMCDgpSZoElsURqWIWNLjKdw=;
 b=JSsA26WX+ljEjvPGX45+7uP9eG1pM9e7iqpiIyQT9QGPNFErnjI0zh2Nx7ckIrAFplMddK2tqBLR90ottmYQzTtNJK1+WLKi1Fb9h9Av/xFRp3fpDgkxkZ43b3op81DpxoV7i5/LrSSE9Wq6G0dtXs3JpAQdx+g971Ha+PmdE9I0EjBXTzXtsjAE1MSyY0UX6AXt5J8LPZoxObPuvvDfCEkRTmgY993dJu4g/Szi1XKhWD36uxDWSRcASO8DFwKzb+VciscIrxM+clXdwWvUyIeXavrl3/DAkLMAlbzDoX7BqVU6yjlO01AiA2tkvx6JQKaYx61bbAMZtcDpEhDOqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCwT7s/KlJCT+RhhQ9OrMCDgpSZoElsURqWIWNLjKdw=;
 b=yvQfF61cu+j4kr/4JlXZQRgaDL8kGGcP2M4Pu3ktKyxncxQmRJIQLr4GvXjtDISiGbYEPaC4n7mco8pLrBrR7nFnDYpB23VV0DitVZ6FRigUI1cRbEPTfEvaVzDhUEKcyxVBuGwPzDCRShc+jpRR2elRHW8hlJiI1jZaj2V2HHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 09:03:14 +0000
Received: from BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::266b:49f3:3cba:406d]) by BN9PR12MB5163.namprd12.prod.outlook.com
 ([fe80::266b:49f3:3cba:406d%4]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 09:03:14 +0000
Message-ID: <1f618ab9-389f-e3ec-58fd-fdda14e3b800@amd.com>
Date:   Mon, 21 Aug 2023 14:33:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] iommu/iova: Make the rcache depot scale better
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, john.g.garry@oracle.com,
        zhangzekun11@huawei.com
References: <cover.1692033783.git.robin.murphy@arm.com>
 <2c3a0f6b381ae5f743c1b28bbc6eae486160f3b7.1692033783.git.robin.murphy@arm.com>
 <3689f036-5d48-0e4d-56fc-9d96823b9547@amd.com>
 <f8c62974-eea8-f58f-cb67-9e2f13b242fd@arm.com>
From:   "Srivastava, Dheeraj Kumar" <dheerajkumar.srivastava@amd.com>
In-Reply-To: <f8c62974-eea8-f58f-cb67-9e2f13b242fd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::9) To BN9PR12MB5163.namprd12.prod.outlook.com
 (2603:10b6:408:11c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: f177fb85-86af-487e-4d7d-08dba2257386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jBmi83I1FGZ+UaVPAqOkFOO1EJWXIt+vAXPbt9iYOQVOExxqotIKcy9rAL3MzwO/EFCpSfkO4ii95CCYW+UTscA/UqzLpiATmzed+MoEBeS1veJ+Y75BD6XKBsupNTCvLloMYCaPtsys/C+a/3F1HZe8cUDgUOAvFXnJRERFVIYflms9bC8hPXkXuhAUzDBTKaNfei0leLPaEVkveqxhvbaC6W6rZzv5G0g+80fZ1LmlYZXOh/8Zbd5AucO3M2pjqo2Einc50nz9EPXj0uY5RHz9twk4J3TJS93IYck5FOsLCieJ4LB2oAeAPk1cy6HM7eWUdnggsHUa5a6WGLTrp5Eptr7e6dXPGSdv75tx5A+xE9X8kg9yQy9EdbkuCxXdkCDWT2DktWC/1uokkv6KWCIe7I0tS3geF+HZEe3VEqYfYMfhOTqICiyZrheIcPRCTco3oCBpescrtbHf2XxQf1mlw5n7G9P+b8sEJf1H4CZdj57UL2oMMYc+Fx9B9tAK6O8+UjoQXOzlgq2yMSEClhO3/rbrWIN3rdQ+PBEuKVir0iWLvpTQa26TrKl5PC02Eu9M7bJlVJBBhjrhhtNITlF1OSOEX9iNox0VYJCXXRhhq35eAMCTf5obogWY+dHPbiRZr+Mn+5R5Yp1Im1IHlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199024)(186009)(1800799009)(2906002)(4744005)(83380400001)(53546011)(38100700002)(6506007)(6486002)(5660300002)(26005)(86362001)(31686004)(31696002)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(66556008)(66476007)(478600001)(6666004)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGozSzEvRXIyQTQrUmhxenk5N0J2Z1YyV25DQ2laVzBpNmI2bElWSmVmYkFD?=
 =?utf-8?B?WUVFWXRCaFdyWXhPbHFCMzZ2RStDVUN5bGxpRGdPVHQ5QU8wTWlUTUxkYVJC?=
 =?utf-8?B?TUFibHd2dEd1WGtXZ2FnQVhTLzljWGI5WDBaQ2h1NjV5a0JYUFpOZTNKVkdM?=
 =?utf-8?B?TlQrTHhUUGFYSWZJaDJKUzhCemY0dThybDFqM2pZd0lGWis0dzhhV1cxTnFn?=
 =?utf-8?B?Vi8xcmNUaWx0QlpqeVgzcmNQamVNVmNDL1lZaGZFcmtDZSt1UVA3RURCeE02?=
 =?utf-8?B?aFBRS2FpQ04rUkMxVmZpYTFmYVU1VVZQWm5tWDhhbW9vajFldzRQcTkvYnFN?=
 =?utf-8?B?R0xZNFF3YXhOU0d3WU5PSU54YWxJbm1jd0I2b0tabGJyZ1RGRFBqenlUc3Z1?=
 =?utf-8?B?ZC9hak81d3lPMm9hOGk3VVBqQ0t6aGdWNjFUMTUwSnFNOFlPS0tEdWpDV09J?=
 =?utf-8?B?NklWUGFmUlJyaW05K1VVWVYwM0lJdU4zWXJFSFBvZ2ZoOGt0OWJBcmprbHBS?=
 =?utf-8?B?NjFzUkwwbTI1LzV6VjVWRFF2S0lnUWl4VFpXd2loSmo2UmF6Q3ZaUkZOY2Js?=
 =?utf-8?B?bVRSR1N6QlZwWmxCb2ZSNmplMWxMRFJZOWxwU3pGendyVjZYbERqYno2d0Q3?=
 =?utf-8?B?cDZHS0NIZ3hzVzJaNTR3bXM4emY0bzRMTmJrZnk1clo1cy9OUHpWSHh4UVdo?=
 =?utf-8?B?U0pQOGFWbkZNZkRlUmVGM1U3amdIa2dvby9rNUNDWGRHUEFVOFZTMURGdFhQ?=
 =?utf-8?B?U0MwcFpKYTJoQStkUXFWWmtleFlRWThqd1RrNTh6OVduSGtBNHJtSThhb2FD?=
 =?utf-8?B?T3VCYUJyZ0oxSUhDWHlPVHNPaWJqVzRIZm1Udy9HWlpkQXBkVXdlN2NLOWxu?=
 =?utf-8?B?azIrcXYrcHppelFrQmR2U1ZGcmNTWXM0bkFRSlF4LzlLUS9SeUhoalBkalBx?=
 =?utf-8?B?MktnK2xiRXoxQVpiWVRGd3hJZVVvZytwTk9nU0R5eDBPK0x3bDVxblMybTJH?=
 =?utf-8?B?TDcxUjgwaWhGTTU5OFdOckIwQzUvek5QbjBTQUhRT1ZJejNBeVdQSGJrWGNk?=
 =?utf-8?B?ZjAzMGRSc1ZpZmF1ZkVnd252SmZNV1lDUnY2TWp3a2VURW5TcllYUXZ4d0M5?=
 =?utf-8?B?SzRWWElrT0NIUWtmOTdFMmcyVS96ejlicEFGRjMzSnZ5OVhndDFDT24wM2pC?=
 =?utf-8?B?OXZUMDNlUElIaDhGaFk4M294WWdUQWlwdzRqSmxIQlVBYm5pTSsrbytjZ0dj?=
 =?utf-8?B?czBPaDEyUnY4aEtmM3VtZXVLOGVWWUx4eXhnUS94bW5wYWJ4YzlITnR1dFFF?=
 =?utf-8?B?c1NZd1MxRlg3c3FMdmdqbE51SDBockZpajVKZWdDdHc3OG00NUdCUTNOWXhl?=
 =?utf-8?B?K0NUWndTNXlxdFBsMWlEVWQrdVQ2SlZodERYQWpDSmhwdDNYa3pIWVN1d01x?=
 =?utf-8?B?Mk5jcVVJMHMrWnJmblcyTU9sbHd2aXR6dHArL3VzS1VwTTZIeHpDZy9LR2xo?=
 =?utf-8?B?VXlNdmN3bERhWnNJTEJ0ZHdpWFovME1LVWtjc0paQks3eEdDOWpCbFVoMlVC?=
 =?utf-8?B?Q3Z5Y1pzRmd3S0FZcXZ0OTIzTU1BdG9OVVQzOWJmeXNFaGUvT1NGRjkzTU9a?=
 =?utf-8?B?SGlkM2tWN1lxZ0ZhRnJYSklvRTZEYlg1eTU5bHVBM3JBbFNSaXNkWngyMUdi?=
 =?utf-8?B?eVgyeXBDNDg2clFDWEFielI0Kyt1YW00T0VOTURYOWZzNmFhUkVsNVAyaXRS?=
 =?utf-8?B?YnlPODRySW81eDZjZFNPd21zNGhpQkpyNkw2cVN0N2c1MkR5QWFvZXdZVXlW?=
 =?utf-8?B?aTVPdEpVZmtjSzYrV2ppaVNzcTFQMGcySjhuVnc5ZlorK2kwWDZzU3BlVmZI?=
 =?utf-8?B?YmhYQm5GN2QxNkdzWjNvaGpPNFRyNmhBNGd2bFVUQlBkUmJtUUhJclVCR09G?=
 =?utf-8?B?Zml4eXZwVkRxbEZDd2V1S0ltUVBiN1pFanpKN043OHdZQ1kwQVE1dTU4Yklm?=
 =?utf-8?B?NmZ4RjBBNkZWeTd0U3ArTUwvYmRsN29UNENHRXpuRDdUMVQ1V0VZcExBRmZl?=
 =?utf-8?B?eDFGVWgrTnZuVzdtTkVobi9vVmJsbzEvZWRoWGZiSkVBRTMycXRTSnZBMThY?=
 =?utf-8?Q?nESihxpiitH6eoy2SqjxyRyDc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f177fb85-86af-487e-4d7d-08dba2257386
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 09:03:14.2507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AzlVOC1UPDLYTJ5c7hUJN/Gc1tkUqgromIpOofdaUKlO3k1xmlld1lavkTc/kY2yYRT3kD1bryr7KMNkWSEYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Robin,

Thanks for the quick reply.

On 8/21/2023 2:25 PM, Robin Murphy wrote:
> Other than that, though, were you able to notice any difference (good or 
> bad) in CPU load or memory consumption overall?

I am still in process of testing the patches. I will let you know if any 
observe any improvement in CPU load or memory consumption.

Thanks and Regards,
Dheeraj Kumar Srivastava
