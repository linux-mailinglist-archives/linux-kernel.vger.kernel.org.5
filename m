Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD3E778C97
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjHKLBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbjHKLBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:01:50 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA8BE65
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBTMrLjMYXxPHNsRGtnSByYVe2UTjl8iZwy773CIRLAWEDGcSRg2JNnDAAplRQt3ANIo2C/IpoZudLYCLIR0tDzs3e5mHj+i1u06PD7Ri5xzfIVqrlNP5tKjbeoEgCX1i0eeO19NRpmKMvzOntRhlaXonscxd3yUUmCalwbDlWGZNKV4NJogV72lA8jsHGCkKoqfdZ0K6cOXM1lX1kpU4x/NbdV2Bq1IyEJyXth9Kiq/2gpVO3ZHCABphW83vXp/DCTZ3qFwl0r2dFWSkddeWeBb4VqSjBOgL7MGup+saXG3DosCz2NPxR9VyF/4t/r+elcJM+LNLv3eLcp4PWE1fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0vItjDd2W8A6+mLGgb44kaGztZsAyyPwr5FlevwfNM=;
 b=cHlVx9AlDYh1sxUucaJxGwdouYFhKqxg4dLbz4LWtTWpHgKD0cYw3S/GVrZh1ROtuU4sYy10V/DOTaxIS/3sNlFGcr8lushirziKbY0Zkf2NadZ9GNv9qljjYPj/fRUlTnSEbmvPNuod85i0PYFDBafREbIRlVJjlRyEBrxNK4hzL8urJhpoR4N/kVRJ2yS7YIx4bj9Q+cM6bl/clwSNwvvaLUE1E4jJJ8EYxMj1JnNwi66hZLjAgBc0fMv1B3e71dyqoocRPh6Iud9dKvOVpp58dVZNHDxc/SLKdiMskB5vTzkFXmnnqwMqHQtiKXcq9eUwNKE1oZJf/WvxqCx4gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0vItjDd2W8A6+mLGgb44kaGztZsAyyPwr5FlevwfNM=;
 b=D6FhO15JkNzg71F469G/K09WFJ6hbGm4DK2KVw8My27XMHF31pAVhkN4k1PvWsmBZSJhwXRq2VE+jLXrpJ3pd6w3gm5OJVqEonIgZl6N5E7d340cC1UGuRWgVwzStu+PwEFqURckoWCfVKsr2kMBq6YUICH32f3YC67N7Qn9ApTmmqGGAbxNynHCeU/NTzJJEiUsb8hp02kupBmxtZpz0EXd7YDMOAqZPPNzk3phQZZCPErWSBfFc7KaiGSgjCUA8pczCuGuYWVSLAvfDY3MjiuNyN4KFg4tKi1BrlLrrsqCUf5GzAF54uqRM4NyXj74JySZHbcJB4K8PAvXBblf6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DB9PR04MB8493.eurprd04.prod.outlook.com (2603:10a6:10:2c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 11:01:47 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 11:01:46 +0000
Message-ID: <3248d974-51f2-e2cd-68e1-0536fba83127@suse.com>
Date:   Fri, 11 Aug 2023 14:01:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch 13/30] x86/microcode/intel: Cleanup code further
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
References: <20230810153317.850017756@linutronix.de>
 <20230810160805.710329611@linutronix.de>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20230810160805.710329611@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0148.eurprd07.prod.outlook.com
 (2603:10a6:802:16::35) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DB9PR04MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: ace13e3a-af56-40d7-d97e-08db9a5a5aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PI0Bb0SXC4ZhX98lLmJgj5ofyuhxfeJH60gdMiZ9N1aI29mSF24DV6OG6j39eQDmiNe/DABpGs9AVWS19dppxN8LvHEjpUcEOmu07ruMuK0h3Od43VbEXFZgzq7vZT3eqd2I0pv6/VyHSi/AIcmDNBU3xHGQtwdq5Jv1Stn1IxLBws796WTrqFwjt7fhJjHlwR7G0f8ziCVIpGWLkVw1Q8bX0u+eZ0e2d1DK0DxZ+/dDbXqhGlnzcnJtdEQyOaknO5nSjyyed/3GaJollDoj58uvCn2/oyJRNypni56tBvcnbaPXU3kXxIJeODNm8qHlsjv0ktcwbdYxzLGL3A1FWiF2kj1lefzkwO4T3alQIEBd4+M9d5VcDuBzlPZwWaVppVvffK0cFLFOYF7uX4b4s5F6TC37ikWGyUQTzttzx2BIZ4dAsKRF2ElZGAPahfLu/TurseoaRtlAAplINP9gU5TmfSGTJvfaKDGF7du57I46UC9WGXclAnwMAkyLdVrAQLus+590YEZfhZ8BU5HxMmYntLJ/NzzF2yT8ReqIwLImnSUL0aDf0yt8ByNG4w6XqhmYlIEj1vFxXz+sRn9/C8of/nKyFMZPMKHUzDcHJSVanCX0Tsd1cQyBqxTc8lysbQ4xS0jiIAzIgXDvjCNVyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(376002)(396003)(136003)(1800799006)(451199021)(186006)(31686004)(66946007)(6506007)(26005)(66476007)(478600001)(6666004)(110136005)(54906003)(36756003)(66556008)(2616005)(41300700001)(316002)(4326008)(6512007)(6486002)(4744005)(2906002)(31696002)(86362001)(8676002)(5660300002)(38100700002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?by9iaXZXeE1kRGViMTZjOXcxV095bW85M0pzZDFuaEtkUkJmSi9RSUxmaGFV?=
 =?utf-8?B?a0ZxWXdtcGFZK1BRMWkyMDE5YkNqQjA5SVhpWFllc3IrK3loK3BOcEtHam92?=
 =?utf-8?B?ZEV1Sm5oM0FWVVRHRjM4ajJick9wWG1FejZoY0pHWmY2bktjbG1lSUxQejdK?=
 =?utf-8?B?eUpoMUFGVVNLRTFFOGw1THRQS0F0a3dmdHlmTXVVbUJvUzV3bEFTaVY3L0VU?=
 =?utf-8?B?REdOT3BKRG9oSWVjRW01bVNKa0dyRVV0RVRTVXVBdnFjcFVvU0dzVGxFZzV0?=
 =?utf-8?B?d3VadUwwQjgzdHN0VGdoVmZoUEljZVN2czZhWG8yRVFLMGQ2a25PTjZ1U0NO?=
 =?utf-8?B?R0JZcGVmNUxZYXJ2U0ZSblRXbkRRZmQvQ2t6R01tZ0c3dmlVVVNIZXhZVGlK?=
 =?utf-8?B?bm1PLzF4RFFhUGJOcFprbWNjZmE4NDNPZVJiRVB4WDUzNmxXMmVhNUlGcWJw?=
 =?utf-8?B?bFhlS2pnRjN2a0VuYkltTFE2TUtxMnNTNmhnbWJnRk55M2VzMkFmZHJUMHFL?=
 =?utf-8?B?VDFrMHhDdkl1RERkOTlSUUI1K0kxQlU3S1dZc1hMSFBJQUF4VDhKaEhadkla?=
 =?utf-8?B?dUVkMFZPVHBZQU9VcTBBWmwvZ1hQZlRFM1E0TFVqbnNVK0FwVVNvWmlsUFVK?=
 =?utf-8?B?cVFSalJkTG9xbTc3T3dzNWJIRzNHV2VTR1JxRzVqM0J0ZlFndXh5SWgvNTNl?=
 =?utf-8?B?YklMbmxISmhjMmVKZjdRTkRoNFh4eTV3alhDZi9FRnlZY202ODJpaFRGdEp0?=
 =?utf-8?B?REc4T1NQenBsZjlvVEQ4NHlHa2xCZVNzLzVJMVNtdkdFdEhSZ1BYc3pWUkpo?=
 =?utf-8?B?Wkl3REQ0WWYzQUhGRjVGTFFCOUh1SkJadjAxM2k5ZjNZKzd5RlNyaGh4WHk4?=
 =?utf-8?B?c0JhZDJ4dWZESjI2Z05pTVlqSEU2U09BTU50NkJDd2xnMVhJUkp3L3ZSd2JD?=
 =?utf-8?B?aytVUE1KQmpSZnlZZ216L21ZY0lybDFTckhMWHI3RStaQmlXb2FjbGVKYUlH?=
 =?utf-8?B?S0Rzb1h1SWFJS3p3NmZqMjBLTThPL3VxTEE2Y0g0K3IyYmJmOEovbFRyeTEr?=
 =?utf-8?B?V1lMUzlJSVJrd1liLzZMRlNLYlowb25LK3ZsWEJjVTk4aTZGU2JENmV2QmVh?=
 =?utf-8?B?UEMwL1VvYkZRVmNxejdETlNGT2VlcW4yV01ORldQYUswNSsyckh6OGtNSTlB?=
 =?utf-8?B?KzNsQ09vOXJSZDk3WnNoNlBZTUNJajFINjIzM3A4MkEvWHM3YjFwTE15OHRY?=
 =?utf-8?B?VkJMS29Zc0pCalF1MnlKM3lhTWJqbjh0VllUc0poQ1BYekhFSHFqc1hFTEhL?=
 =?utf-8?B?WEhMZC85UC9lVlpwVG5mSHhZQmpCSmc4MkF5cWdKSFc0WVNmY0xlOVVOS2lT?=
 =?utf-8?B?TFV3ZDBSckl2elozS1czcERueTl3VFU3SlU1VkJRMGtWS3NyY1hOb0hYN2xz?=
 =?utf-8?B?NHRHa0RqU1FFSlh2WVFFOWlCVnpYaFN0TExuQXRSSTk4SGNLRVJKdXJOdDhW?=
 =?utf-8?B?aUJGV1hJOGNCMGZ2bDdPbjJNR2FMN2g3Zml6bU12OUhqa09YbDROZ1lqLy84?=
 =?utf-8?B?aks5QkRuZ2RuVnVjSCtzVEM1b3pKQXlPQ21NMWJlMDlkcFFLY21zNWRIK2Vu?=
 =?utf-8?B?SVo2WUhpczJhNzgwTlJYZGdtbndvbUtXTGRnZkJydE9MK2xrT1pUcUhCNU91?=
 =?utf-8?B?cFJGcmZCc2hqRUhXZlNTOTZHeGUzTTBJTDN4TlRWMGFTZjA1T01TVmpENW9G?=
 =?utf-8?B?a1JEOTBUMmJrOUFMSFVDVnlXOXIwUWhSQUNQeXI0MGFoVnBNK2xQb0xjUXdH?=
 =?utf-8?B?djVsM0t0NllxWXFSZWYzaEhXQ2JLMzQyOHlHOHVKZzlFZjNEa1I2LytERS84?=
 =?utf-8?B?VDhRdTk0c0dSd1pmbHQ2N2Njb3RtVzAwR09XUjZ0TlVScTJuOWR3clNNSjhF?=
 =?utf-8?B?ZE9hNWIyTGRZM2dTSkk5Z05NYWRJdm9RTGh6OWVQMWRiLzFUQ2F5L2U5WTRl?=
 =?utf-8?B?d2h0eXQzbFdyY2xjTWxQZk1nSlgrNnpXSnU0MzJYTHV5Zmh1bEdZNFJ6dU1S?=
 =?utf-8?B?ZytTTHF4WFN6YTl1bUh5WlhmcTJhZlFLYVFOWmplWEh1dW0zOGl5K0hraExq?=
 =?utf-8?Q?l5eLWsA04VuxgoUgBEiEQWge/?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace13e3a-af56-40d7-d97e-08db9a5a5aeb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 11:01:46.7859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdoviJSV721+yY6T0uCOdrZ4BiDIUIPbBIhcDnX1hhABxCAgLhRXW98fdUqLHEOaEVDBbYc3HKSpc+GBkji1RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8493
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.08.23 г. 21:37 ч., Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Sanitize the microcode scan loop, fixup printks and move the initrd loading
> function next to the place where it is used and mark it __init. Rename
> generic_load_microcode() as that Intel specific function is not generic at
> all.

The rename happened in the previous patch, so drop the last sentence.

<snip>
