Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF7477FF47
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355004AbjHQUuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354979AbjHQUuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:50:01 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F5C358A;
        Thu, 17 Aug 2023 13:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QS1emyECqG246b5g3PIGPw/Zxjv5bdqv4NnsfJJfS5bsNl+afWZmvQIJCiBjcEBpENNLI4dQcgw6/Ye2xKOVpdTVwrdb2LaWonQ1Z88Map9WUwU7qOrHCcshYZD3HBjbRZpkJeWL5ui1VRY2j2arD1bgP3yR/184k24BQ17XkZ//oioFMP8G0WP8tgyLRu2o1Tk7eMdxo/F/nNoh/l8IdHWKNP6aqQx5Rcx+T4WoxXXqB8BSxpoHTYVt6H1rcaaVsmqk6vLXbNwVZZiS2qhbHzqrxdQhQs7843eeLqGcMV+nL0CCNJgh+nn1D+yWEHsTxWJds7dqL0prsXKmYCW4Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+GDB3+XcUPLAK8I4Ib2m2+zacsDvEb5UGw9j4WqRjY=;
 b=OSOg1t7ndrzycZufimJBMNsnMqD9V7u/5sUSKOWQ5x3HXFLCioKxggT/vTXVHqwNcGGbmj6mY5y2ad8pTWeu1EsDv6YR+/6ObozFy0parSAsRwUOTsWGb86Qn6S/z23tGCHxikaDGkGsIlrHMXeUxikWry5Zy9CKlaQDgw4PFaLj0UdN2jtbvmJeZGHQQ/8N/8awiFBXzVBLSxODWWOthHkiiZ6o1l/KZ7zYiVMPdbxw1PDCgk6MqwvS0szpQxlYPPXWqqYS1XrjSKbgZHSzjdPvPNJEXAWEH1uzi046y0vRe3AB+YVjz/utxqwGtMI+AOtVs4g9Fq296c++RXeTuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+GDB3+XcUPLAK8I4Ib2m2+zacsDvEb5UGw9j4WqRjY=;
 b=yPuWkz9t05aBQ6htr1WcmmLteznHXI5bRWsSOCXeGBxMFLPyhDXEbBJTjMsphdld4ahFC1bEvxmTasxFd8XoPEMY/4aPszLacM/pxJY+SWI9Azp3D4lvTKgQjvkz5zLHT6X02ydnSLIQVTa0o16i3EjeMW+cUvhxIEXU5ONsGaZ3auL3yYoJf3v/d+PpZT5h2jHLLcRtlIBIwuDMPVg1QQeTAu6bERfv7NWvxp/Tyb03I0azW5QIo57mGaHh6hNBvJUXc58P3LM8PmVDVZM4QI6ykkYbpbJk7PJILhVvrR8qXCIJxpD8ELVx7ChlX7Nvi8D7P8h4eoaMWPMzYgl2cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by PAWPR04MB9742.eurprd04.prod.outlook.com (2603:10a6:102:389::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 20:49:56 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 20:49:56 +0000
Message-ID: <4500f9ad-6ecf-60a6-637d-694619ce4c15@suse.com>
Date:   Thu, 17 Aug 2023 23:49:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [BUG] missing return thunk: __ret+0x5/0x7e-__ret+0x0/0x7e: e9 f6
 ff ff ff
To:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, x86@kernel.org
Cc:     peterz@infradead.org, keescook@chromium.org, elver@google.com,
        dvyukov@google.com, glider@google.com
References: <4dc3d0ec-b827-4bce-8927-cfa5d837fd03@paulmck-laptop>
Content-Language: en-US
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <4dc3d0ec-b827-4bce-8927-cfa5d837fd03@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0039.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::20) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|PAWPR04MB9742:EE_
X-MS-Office365-Filtering-Correlation-Id: 61771ea5-d434-42f4-da82-08db9f6383a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kd4TfAWJ26B4wrovKjpAxuXajpCHKeKPnqLBxwYxvnzBoczmo3mZLwHXsFOy2lUswZdsXZJAoW2BpVQaS0oIsglY1Kfr6TthRo9ZqF02zdgxcofCie/slQjpE77RLL1U4EZnSjeaEveNDRmcAiCB+X1sMyP+YfUjUTjhYKb9vGctiL4ZaS+e73LcMxoZJmY3p4bc4nwMOoAM/no00iyYq1YMRmD5LdwCap4HUvesMXFQzA4hhMmS8wMfACeLkvuWqETjsiskcGuxqp0eaIfivolTEA3OCOrFc59c2YaJDeKEiY7d5d8Z5vl/Z5a47LNhQ7yymIP/ge2R8DR+hVF25TnKXu032srnCgtSjfcYTB/dvooVj8JCu8bdOQqVkDiP1hkn0m19NrKQ2e2/GMabSCU5g5hwHaIBHyEZaNzcQmdfgK0HIQyyRW6fZlbCOzkV6xlJ60B1lNny05nqB+W8haMDQ8fwjArWtqk0qjyLCC7XazAzwcjgCPuH768qcYgfHYIENSlgDeT4E48YmS1xPS0k3j8DPlqxMkKVyjW1PcouqFXNLsJIr2Aiy7pXUrICVFt9/0QSTloLTZ7NN4MPmFJ7eANk1hkPApcC808AWjW46ZTAsZXhomnBRxJAzARv6IG5dcrZEEzc5UK/uylOrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(186009)(451199024)(1800799009)(31696002)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(6666004)(2616005)(6486002)(36756003)(6512007)(5660300002)(41300700001)(316002)(66476007)(66946007)(66556008)(31686004)(4326008)(8676002)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3liUFFZZE9ORCsrSkVlQVlJOW1KbDAzMmUwMVV4MkhKS2lJc3BpWEdaeUx5?=
 =?utf-8?B?YnlWQW56S0w1NldCVUFuS2VhNVpVOVFORzdUdWRkOGtRV25aMTJCWE1hc2hh?=
 =?utf-8?B?bE1qK2ZzWDBkdU9EbzMrUzNaMCtRNWRheEJFZjJsMmd2VnF1ZTEra0dBZGpR?=
 =?utf-8?B?dmg2VzVnS3NOclMrZ25OM3g3NDNlZlRidUdrYnVxNEloVE9xZmlhMVVOYnA2?=
 =?utf-8?B?a0JHWGp4RkRiNHNaa3ZuajJXU0dzU254MStSQ2oxYThJc1VQR2NEZUZlS3ZD?=
 =?utf-8?B?ZUFHWVFMTmNBenRWWWlMbmRSSDNPUURyVjJnWXZMc3hDdEw5dVhVZWs3ZSt3?=
 =?utf-8?B?K05aU01UOFdyMFRDVFJlb0RCQjBVV2RsUEVmWHRTUmJwdnY3UW03cVNkeFJN?=
 =?utf-8?B?ZlBDMEhxTExxbnAzcmUxMStUMW9BdE8wYzVWNmh5TUw3Nnh0OVVsUXhvN1Rw?=
 =?utf-8?B?clVNaXZybzg4TDVHSHpWUjY4aGYvdmVlK2xYOG00Z0hSVzRJVUtZNzJON09a?=
 =?utf-8?B?T2I1OWJUWnNKZFlFeWdkaGpuMkFhVTJQWVlqQXZFSk9IKzIva2IxakViMVVQ?=
 =?utf-8?B?bWh2dGhlUEJJWU5nZTN1S3BZejd2eTY1Z3UyYXkzTThsZVNpMmk2MDNlMk15?=
 =?utf-8?B?b1czWmxzN0ordWtQeHRYSVFCd2F4eSt3MFFlV2JWaytxaG1LbDJweVZBek1h?=
 =?utf-8?B?eVV4VllHNHhXa04rV0FkYzZ6UStrRjFPUUxGK1pncFF0TDFkZXd1Wm5EVVNz?=
 =?utf-8?B?YTM3VHduMTR6aENQcVVkU2VCVGxsN1JhMHdoTnljOEc0Y3RwUTVYZmVoYWha?=
 =?utf-8?B?UkdTTHQ4NXFXQ0NJLys1MHpmM0c0czhUWURNRS96bzhYeUVFZHBENnZ6K0ZC?=
 =?utf-8?B?RG5WTlRsOC85STRSSXZUamVqK2FTbmFJOS9LeFlENTNsa3M1KzdCbTVLQld3?=
 =?utf-8?B?Kzl0QjcyaFh1cXNpdzE1b0JSL09QZWZUazViRjNUcG52OWoyK1plVndqVlZJ?=
 =?utf-8?B?SHQzSjBXS3ZBOVVBL0Rhd1l1cWphNTZ3MFA0dnZ3MHJFdlZTZDRzZHlhWWFZ?=
 =?utf-8?B?OWpCZDg4L2ZQZzR1eHIyY3NDMzR6a201dDV0QktZY290ZlZlZEM5T3VIV2ZG?=
 =?utf-8?B?aU9hZzZuWXV5eE8zTy9Oa0lMcmQycEhIRUQ3c1UwY0xjUEdXL0lCUjBBUFA2?=
 =?utf-8?B?L1FxRXN6bUFpK0R2eWF1TjJwdkhqTUlja1lmSVZuRVdwQ3djRjR0MExGc1NF?=
 =?utf-8?B?RGhWbkxabUZTUC83TEVKblZUa3hBU0c5WDFucDVtc1gySk5RYXlXOGhQZldp?=
 =?utf-8?B?RDQ4SXNOL1ZBZ0phSmVoTVJubWUyQlZJdlczb29pVjViZzNsNVF1bWNvWVBK?=
 =?utf-8?B?Q0ZZYi85djlURTJWY0F1WWhnWDcrekdpSGNyd2xLQUEyYTkrcVNWNFprblF0?=
 =?utf-8?B?cG8rODB5UWVNRkJTZURnVVlqRDZXVDB6cU1CN2Z4dFZsRjA5clFKRzBuQ2ZQ?=
 =?utf-8?B?eWxoWU1WWEtvaWMwVHV3Ui81djVzWWJlOU4yNXd6WUVlcXJuNXBSTzEwT0Z5?=
 =?utf-8?B?UHYrak55cDhheVdmb0VjaEFzWnZPZTM0NjZLOUF0RUJVWUkrOUpnL1B5V3ZW?=
 =?utf-8?B?K2hTUW5BMUFMVmNPUmRiUHluSGxNR2pVaWYxK1QxMmMyY0tnUGh2TUFsSS9Y?=
 =?utf-8?B?S1ZGR2lPVThwZlVISDN1NGR5akcxaU81bmNoU3ZJUnd5YmdWM2NhM1I1d3Y2?=
 =?utf-8?B?Z05aR2xRaG82dC9rTGk3V1UvVk1KWnQwUDEwL3hHL3pCMWxFYVlHUFJLUm9O?=
 =?utf-8?B?NzFjMk9Eb0FmQ2FaSHR4YUpIWm5PYnhRWGtjcDNxTnY4dzVrVW0vZ2hRT0hI?=
 =?utf-8?B?TFZSUEYvSDZtNkttUURTNjAzbzJUU1FleE1DMU0yQmZVVkFjUERhMUNYQWRp?=
 =?utf-8?B?TjFZNGtpT1BRU2NwNk4yamI2aFo0ZVdnaGwzZStETmQvVG5XVWdFTXRlY1A1?=
 =?utf-8?B?RmxCVGgrVTZubm9iMDArN0FpZzZTaHRvNVQ0SXBCdndYclNHTmx3UXkwT3JD?=
 =?utf-8?B?UWZ3ZFAwN0dETFFEZnRpenRReHVGdktNY0hzdFlJbkgydTBtMFRJYStici94?=
 =?utf-8?Q?aQ+jpz07lb+hZ1kj+yMBHLJ6i?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61771ea5-d434-42f4-da82-08db9f6383a5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 20:49:56.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQhHspTmOsxbGnEWrB8V/SvTVfCcKDLmcYOALI2iAbKH7R4KiUd60orCexyw0pDDueC6WgMhcLbpqm4mDTg1ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9742
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.08.23 г. 20:54 ч., Paul E. McKenney wrote:
> Hello!
> 
> I hit the splat at the end of this message in recent mainline, and has
> appeared some time since v6.5-rc1.  Should I be worried?
> 
> Reproducer on a two-socket hyperthreaded 20-core-per-socket x86 system:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5m --torture refscale --kcsan --kconfig "CONFIG_NR_CPUS=40" --kmake-args "CC=clang" --bootargs "refscale.scale_type=typesafe_seqlock refscale.nreaders=40 refscale.loops=10000 refscale.holdoff=20 torture.disable_onoff_at_boot refscale.verbose_batched=5 torture.verbose_sleep_frequency=8 torture.verbose_sleep_duration=5"
> 
> This is from overnight testing that hit this only in the KCSAN runs.
> The KASAN and non-debug runs had no trouble.
> 
> This commit added the warning long ago:
> 
> 65cdf0d623be ("x86/alternative: Report missing return thunk details")
> 
> Thoughts?
> 
> 							Thanx, Paul

Likely fixed by the following commit in tip/urgen : 
4ae68b26c3ab5a82aa271e6e9fc9b1a06e1d6b40 [tip: x86/urgent] objtool/x86: 
Fix SRSO mess
