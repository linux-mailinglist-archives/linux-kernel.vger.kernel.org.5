Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1168279E02E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbjIMGoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbjIMGoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:44:17 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C81E1731
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 23:44:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNi8N7EqrBtnjPAGRvGuKes2E1aL/eXarxE1Sg3DpWewkqmvsGz9ln0pUuG480P8Zfuvm+JdShvQcMNzbUPagUFrmerjhPLzL1J/UB2AYMRffyxzItH33mI20NGiPGL+XLoYGQk6LfAMSV68aPfV2VdMj02mIbvpp24De/QQTA+uHxttEmPOs6Th7VUaHhChil9xjG49/mxvCbmkZfwjlQb5QyzJv4O9ZqQDVLuvbcM8vqZK8+XUzl8UXNotGIN7n0Q7CKf537z9HN06TGMxnqEPVPqM60V5/66hMx5z/cMssoLCS2KfNavJzrpZTgXXQd8/68chz1dFrfmhRapnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAVkgD8aUslq37Jow1ggKy5BmBjLDKzVBHttda9a28o=;
 b=TU+PgO2Rozc+Fstw1u2Gg+FH1OqqWHtehOl5e3Fkme0hGcISpIu+NAAW/AJWGuCBEooqY2q3IHhmpuacpKFSqU4uIDSxyTa6cLKViV35069foYUgW+aUHYvR9fhtD6pf1yzStRmaW8N2l9FC6wIdwnWk+nD3t0bs2YILEdAHfXZU4mJ5P2wMdYC5+8faPL38n+5xJhVFQNpJWpYynhS5hNflGapYEWIeVFf6Ropz0aEV1WexyGdkyOAsZ9+6cZ6w3q9ogyJGbAmWeMELhejJBMeJKk80ays3vpAq5OEt0lwaiuBmPJDzJiu3s8gy8qmsKryHUiZGd7IZAe5TRkaTog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAVkgD8aUslq37Jow1ggKy5BmBjLDKzVBHttda9a28o=;
 b=tqvVVZvg2Ok4w5/dP4/N7xqO0H87AEMzyLpEHPG8aU8eCmzsejujD3BR+LGJReUquEC3/XQqnih+HaCwcR5u+UXazyOPOUIVUG6hCpExBEwBHSLfd2FFtKUInU6K58WpFSSXnNY8xT0LFlTmzadVEXvp0iMv7YCoJbykLzWZdJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17)
 by PH0PR12MB5482.namprd12.prod.outlook.com (2603:10b6:510:ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Wed, 13 Sep
 2023 06:44:11 +0000
Received: from MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::74d4:ad6f:f00:8187]) by MN2PR12MB3008.namprd12.prod.outlook.com
 ([fe80::74d4:ad6f:f00:8187%3]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 06:44:10 +0000
Message-ID: <edfda601-013d-817e-03cc-ad92a6d72327@amd.com>
Date:   Wed, 13 Sep 2023 12:13:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 6/9] x86/clear_huge_page: multi-page clearing
Content-Language: en-US
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-7-ankur.a.arora@oracle.com>
From:   Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20230830184958.2333078-7-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::18) To MN2PR12MB3008.namprd12.prod.outlook.com
 (2603:10b6:208:c8::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_|PH0PR12MB5482:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b96b418-9f5b-4ddc-8625-08dbb424d5d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WEirW5IAqKH6Uri9CiDvWmUEaCU9XHqhfXKJIgztkvfuQrpLGDn9Q0opuRzy6oFCNWXIw97KHcRdwIrBXF6Qr3ag1C8cU3nFcuTMoZGwksCqTaiwVHw2ibgV0j8H6JImin7SW+1V4l9aVRfnuMRjX2xIqEM2zWIZxHSicraX353Blhwte5ettjUqYF8mYp4d75WNYod3TkAVTxH+3SzceMGqw3Mg9Nf14FpxcovtjXjcrOEKicnCxqKR2vMJxTmzMrIfYbDHrbwStXAgQf/6bhdo7IzhzI8+YZA4RPnYSg6bgMBKLyKREk7Omfne5wik+rmvWLW0DN0GtEnleqldO3FCgCG8FfED1nIYXwMo884+n9qcFGx3kIfaUG2CaA2Nn5q5JuwSpvCih08ehPlLFLQkcyEMMNNOYdaSZbzduxh/6OJEpiutlXxNxtiFWgAmniiiRgTAnf7XrGzNs76tOwouLCLBNLwWy7fhrZ+CMywd1flZfQi0UdUqIYNfMZAEEcy4oJBglLHx7peJrhUfeijUWssB24NhTG9skqS7oqI1Arg8fj3I/pzI4ogfOi+yYNfU/X2La40vFw/CJACbBreP8Vr+cDm4VheReP917Kw8FS1zIkeckDB49czUsQTU9LQNhD/dk1yjo9aSRy/sz3MlmoKVRfTcocbU0n1Dpc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3008.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(186009)(1800799009)(451199024)(6506007)(6486002)(53546011)(6512007)(6666004)(38100700002)(31696002)(36756003)(2616005)(26005)(66946007)(66556008)(41300700001)(66476007)(7416002)(316002)(2906002)(8676002)(5660300002)(31686004)(4326008)(8936002)(478600001)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHdaVzZNTXlXOXN5bG9yc2x5ZU5YRkxkU29BNFJRUklsNTJMUU9YS0g2YjVM?=
 =?utf-8?B?NFJtS3FaVUliWDhFOTNERkVoeGR5L05GWlZmN1A2K0lBcTdZYkd1WnRuWlhU?=
 =?utf-8?B?Uk1ESkcrOThIaGFMRHY3TWZuYkdXVHd5V2dGMXc3bHdTbEFuaVM1eWVsZXVa?=
 =?utf-8?B?QWZzdTFtL1MwRTNvVDAraVl6bHljOGJmZFN5bkt6b0xuM3gwWlR5Q0pOR001?=
 =?utf-8?B?Q21BU2hUVVRtM1FTMWlqYTExd09YeUdVVTZ5Y0U3Z3pxN1Z5cFJoLy82TzV1?=
 =?utf-8?B?VGRHdm9aNHlGTWt3b1NhMzZBT21vSHFPOHFsOGNjbjlPR2dDR05WcE1HQ3F0?=
 =?utf-8?B?VVh1N1IwN0Q4a1d0anpHeks1QXgyWGNNakxEMDBrS1RZdW5CdEw3WTRmOVNS?=
 =?utf-8?B?d0xCUU9tS0tVMXRJUDdReml1ZGhpS0hUNmIxZ09jTzhXMjBFYkhyc3V6RTBH?=
 =?utf-8?B?NmUwTmE4U1pyWnpnRXA4QlRrTlBBMGRxNGpNNjkrQm44VFIyRmVja0ZkR0Vj?=
 =?utf-8?B?UThhZFF0NmpmTWx0UUpab1k0V2Mzak1vMzhrOTVNcFU4NzMxV1g2R2p3emRV?=
 =?utf-8?B?VXlNL3h3ZE15Uzk0dzNuN0Q1dXI3YXhWOHAxUjhqdFZDREZNeDFEanZ6SHNr?=
 =?utf-8?B?ZjZQMnQ3dk1NazloWXVrVU13Z1hvZVlxSlVRdU56ZmtjdGR3T2pPcU1HVHkz?=
 =?utf-8?B?YzNsV1UyNmoxeEJSMGEwNitQS0dYa1crYlUzUDAzOHVMS1JoRXl3OHltUkxQ?=
 =?utf-8?B?MXVYNVlqR011VU84Ym5XZ0hHTmN4OWh6ajM3M284STk1N0lrdlNDUDlRMHUx?=
 =?utf-8?B?UzQvM1VrTmFIK09IaFh4YmZmclM3bHRDU2paeHh2M3prSU9LeVpGQS9ER2oz?=
 =?utf-8?B?cGpESGx1RFhHRmJiWkVDV09jZlNGZnpkeWkvYS9idHBwaVJwZGE3cWIvTmFz?=
 =?utf-8?B?d1RUcDQyZXRnVGpWMXlxbEVzbzhKQkpaWHJEb0xoQ0ZZdGJpVWxNNjJUdVF5?=
 =?utf-8?B?MU9wWXpEVFU0Q001enIyM2dab0djOEY5dExUL25mNGhJTStRSEpYUWFzUlJw?=
 =?utf-8?B?NnlhekJES0Raa3lPdTc2R09GTlBwdVYzTG5VRE5xVm5CRDdRcmpJeXpYL0dw?=
 =?utf-8?B?TGJxTHVrYzBQSUZ0NExVZEdoV2FXdmFLcmo3STdORzh3QVRSbk5mbkJiR3VL?=
 =?utf-8?B?Z2NrQktIMzFTRTVjZndTYVdWc1pFREVqbXVrTHA5YnF5azR5ZDNCRmhRdy9l?=
 =?utf-8?B?WEdzQUpKUFlSNEVZV3NkR0labWFhYUlUYUJ6Z2ZQd2ZSMEpMNXo4VWY2MGRZ?=
 =?utf-8?B?Z1FuYTNRZTVXdTZieHRYSSswYkRUeHJ6Y0lRZWtISnFXUUtuaTZHVUxkcHRu?=
 =?utf-8?B?TzhEZFdGWk52S0VvN3lqclI2bzN1VllmN1NRQmJSQlI4WE1SZHJRUDYvZ21B?=
 =?utf-8?B?dlA4ZnN6V0wyaWdUd3RFN3BSbFk1L3ovbElwRlFrWHBwZ0wveEVvRjZRa3Z1?=
 =?utf-8?B?ZGVHTzlDM2FpVitELzBFRHo5RHQzQmM1T29zTUdHMEIxYll6MndPRWxYY0dJ?=
 =?utf-8?B?azRWSE80ZDI1alJ4ZmYzNS9VaHdHZm05TUY4anZXTGJ4dFlhYWR3NG9Wd243?=
 =?utf-8?B?K2N4cUkvT3k0M0k4V0c0NGtJTmFDalJseW9GUTlZNXJXNUVoZk5GQTc2bWRy?=
 =?utf-8?B?QUs2ODJDcWpjTk1QUVBEYzhmS3dUQ0JEYzBJeHNhK0NIUTJZdkFpSEJHdTMy?=
 =?utf-8?B?aFFlYlRwTEQ3RHRxRDJzS1JQOEpWVWRycmNqbmFMdkpUdDFRTm5yK29QQlNT?=
 =?utf-8?B?R3hBSHp3SjhsTjdKeHpoOStLUVhYZzVKS2k5UWdnUGZBYkhPRmsxRkVaMDFj?=
 =?utf-8?B?bzI4bEE1YmppRzhvMnV3T0NPcXlKMzk0T0FsTjJHTmM1cjExQ1RScTFFUXZB?=
 =?utf-8?B?WFlhbWYySEhvek5hQU9mZ3FKZXlMRHZ6V1NFamIwUGhmaXRPYU1aWGNjN2lo?=
 =?utf-8?B?VDZ2V3FsTjRnZXhkTHNmLzVLVUhmV0dPbGhTdE5SWmhiaW1KV2g2am9sQjZ3?=
 =?utf-8?B?Ry9PTms2MnNkZHRvYkpZczRRYkt4TXdROG5ockFTMmFJSmFheWhMRGJ3ZTR0?=
 =?utf-8?Q?noMOr1EQKbcUEe1EV1BHBX3gk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b96b418-9f5b-4ddc-8625-08dbb424d5d5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3008.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 06:44:10.6395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVNtr9GOwo8lz5SehJKCz2Ig7OCn0tkBOYm/P7SxIJM/cpZp/JmVWa2BJODePqn3LnT3kOyc8d6IbhiQEWa4pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5482
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/2023 12:19 AM, Ankur Arora wrote:
> clear_pages_rep(), clear_pages_erms() clear using string instructions.
> While clearing extents of more than a single page, we can use these
> more effectively by explicitly advertising the region-size to the
> processor.
> 
> This can be used as a hint by the processor-uarch to optimize the
> clearing (ex. to avoid polluting one or more levels of the data-cache.)
> 
> As a secondary benefit, string instructions are typically microcoded,
> and so it's a good idea to amortize the cost of the decode across larger
> regions.
> 
> Accordingly, clear_huge_page() now does huge-page clearing in three
> parts: the neighbourhood of the faulting address, the left, and the
> right region of the neighbourhood.
> 
> The local neighbourhood is cleared last to keep its cachelines hot.
> 
[...]
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>   arch/x86/mm/hugetlbpage.c | 54 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 

Hello Ankur,

Just thinking loud here (w.r.t THP).

V3 patchset with uarch changes had changes in THP path too, where
one could explicitly give hints or non-caching hints. and they are
  passed down to call incoherent clearing.

IMO, those changes logically belong to uarch optimizations.. right?
