Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B882978BD33
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 05:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbjH2DQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 23:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbjH2DQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 23:16:34 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46731122
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:16:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luYPMflu9D1jHMv4BmUjIDAlRLaKLz0ADTzjh8VLdLhp+3cBGJleFAGw1qIJ5R92W2/4OTeuSp69ixXMVdl7Tqhm5PVTTBzlCXh7Djats1I1dBmMOro9X2nM/ZHs3DIXgk9yl7iIV0nNsVKccJ56o5qO2qskg0U/BEzlJwSJ+bK7u4vaxwcVPso7pJbX/B8Wn4u9VcL/RzGoJX03FRFb/BKi4EJn0p6npC5mGu//uXG3KvuCxB+mGM/ADGk0nP6UniGFOzY59XFCkAkN6QZa694PUtbYJLRciESYOm4nYh/oDVkVSOtm5uLOjMxRsOfN9HFGMpU3PaLjt7rtwdgkPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qd4AVE7EymLJi7OIEirdAu0Gk6dyvoQC5AiSMv2rttE=;
 b=Cz1j1cUFstkB7kVPXhrCbuabLbWsfK76dVw+zhDC7SL+vs6EsnL9U2/l1kgyC60dVWQstR/Te4vGZswOLvvy+0eCzkwVTwLMoS+69Z8RB75U4QWMR3DdlOMjU/lw+jG+dh9iwyJWKxNC6LO/VySTqs8bN2n0WuEjC8+0mFBD+VbegQ+0j/0cgZgM9gFR67W6+7Fw3GZNRhFUnGbJbK8CVaSZlhelLyaOhobtDehxT5j5FU8etzfxmcznZ5iGi1uMH23svJq0gJuFRDSCzKDYiSm84BktZt3ftYc15Vn44g3AHYs8JgINvwUzWd+X8AiGCateih+/QD7LICGi4pht2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd4AVE7EymLJi7OIEirdAu0Gk6dyvoQC5AiSMv2rttE=;
 b=Yva3BAi/YwOTB/XQCW/ocdzB/oKSfg9u4OXvcnxcc9McvC+Xh2U+dr94p134vgATAVW1h3YYqA+eSnqQ0GBicZ9EEz0gDO48fCc67abH7JJLF/CPmowcEy7Ctuz18UMPx9790qaFK/z0r4TW1OHSF3cDpUjrw6ghSmE8eWcGDjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2381.namprd12.prod.outlook.com (2603:10b6:802:2f::13)
 by SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 03:16:29 +0000
Received: from SN1PR12MB2381.namprd12.prod.outlook.com
 ([fe80::bc95:c0e3:ad83:fc24]) by SN1PR12MB2381.namprd12.prod.outlook.com
 ([fe80::bc95:c0e3:ad83:fc24%2]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 03:16:29 +0000
Message-ID: <6f101718-7ee1-1c3d-3e0a-3aa708928ecd@amd.com>
Date:   Tue, 29 Aug 2023 08:46:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [patch V4 24/41] x86/cpu: Provide cpu_init/parse_topology()
Content-Language: en-US
To:     Arjan van de Ven <arjan@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>
References: <20230814085006.593997112@linutronix.de>
 <20230814085113.471353147@linutronix.de>
 <934072fe-eca2-44df-94e7-9fed1dc8b502@amd.com> <87r0nn8ots.ffs@tglx>
 <4a4d5a89-b024-ea49-8740-1f3aef412c15@amd.com>
 <abb65e60-4e8b-7036-4401-d21b273b6d67@linux.intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <abb65e60-4e8b-7036-4401-d21b273b6d67@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::24) To SN1PR12MB2381.namprd12.prod.outlook.com
 (2603:10b6:802:2f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2381:EE_|SA1PR12MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: a0efdc2f-fca2-4e88-e800-08dba83e5609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8U7hxmUXoI7KrBQeKuN9o1jkcMPadjQ8kC+AKFl8Sp6xhCQLl/Ogxljn14DmAzuK+Uv3sTXjQFkxmRqeD2nBVRvl4T4GhrVxxr0MwByzB5PhraKDPNdDKGDBDwVF8WirtBhRLJyh9rROsBTBP/itKSx/4msNjFb2HAk9x9rXq9k6K6SNhN1fhnRylYLyW6QSk6urRSMuTOOkDqdoHCxf/Ry4aVzi1k2dmPnqlX0MemPUVNC7ws5ZAJjwfZkKxQrxILEC0FkjgW8zehOQr2/NiZKco4wOTWQMdh4/4FVFN9OYo72Wj7t7ep04WW8eAZ1GMG2xkCwUFLRZ95Uut4VutQxe0ONg37GIanX8ElDFUWYMbfTXDe07wEoqkFpim0Jd8zLdDnQZZx/FQbDXX6FGsnTDQcgFW7Omum+OzFb8DeDqRI5TmQlKjGC6pvzskHjmoTIh9rWvLNnzOtLnFDimp8Ivf71wgg/WpcHxW2/jDIuEF1yhbxWStV58aVWoLTKgoACAFDY32O4MvJaaTKr3hNxdSOBIy2P1X8Qrw/GWVeTQphrVfqV32APnL+Ow7i4L21Jn1Lc2hThwWOOQBR+MIw6QqinJ0+Nzrp6o5RbWvQnmq/r7pe2y7TZ5gDlWzc0dDiljUNFR66Eu5amCt0Lgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199024)(1800799009)(186009)(8676002)(8936002)(4326008)(2906002)(54906003)(110136005)(66946007)(66556008)(316002)(66476007)(36756003)(5660300002)(31686004)(7416002)(41300700001)(6506007)(6486002)(26005)(6512007)(53546011)(38100700002)(6666004)(2616005)(478600001)(966005)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0NvR3pSbjEvWk9qNFJrcEZsMk1iTjZ3Uk5jczFyeVpwMzU5Z3JGVFBBU2Zv?=
 =?utf-8?B?OVVaMUFwSER2c0Q2T2M1WlhUeXJyVUlCRXY2WlNXWkhGc21RNVNzQTVwS2kv?=
 =?utf-8?B?aDdqN3lxTng5ZzRxUlBvV1V5dTc2STdpVWltbkdpZS80ZkRiY012emFpMHhl?=
 =?utf-8?B?WEQzMHdQcVF6RnBsTlJ3ZWVuRlgyZkdPTzdJc2phMGxGR2c0MUdjUUN3UDBY?=
 =?utf-8?B?aWJqNlZhSmFUaVdzdkVCRENFd3A5S3pjOEhsSURMc25KT3MxcHZLWm8zdWxQ?=
 =?utf-8?B?V2hGVng2RGRhaDYxbldPcE1QeHRJZXFBMjh1WUYxTXpnK0pqWHBTM3hSUkdh?=
 =?utf-8?B?TklNNGNLdkxIR0g1MzF6WnJkVjN6QXpXRFNtRlk4NjhNVGJBZ1dQSDU3OHZ3?=
 =?utf-8?B?aTZvWS9IR2RqT2ZqdlRtRVVhQll1WGFKa2NBV081T1dwQ1JYeFZTdmhHSExR?=
 =?utf-8?B?M0hlUVJKWDh5Y3krSStrSTRFTlRnQlhPdGVNSTRxYUkycHlsdVZHTXZZYUdv?=
 =?utf-8?B?cUVzZHZyZUxieHZHcFdSdzFLMDZ6NjlHQ2dLb25nWXBkWjF6cGxyY3FlazdW?=
 =?utf-8?B?dHFRcEJyZTFHVFR1Q1Z4MDJOZXFLN09XdGw3UkNJWVBMdUdPMTBwRjNUckFX?=
 =?utf-8?B?NUdtYzlOYXJjMzRPQWNWYjNIdzNGUGJxS1NaaTlmM25hMG0yRkhnSUthdDcy?=
 =?utf-8?B?Q3UwV1FWcXpmVWtQKzlpVmxGaDFXWE9BRnFHcEJMNHhIcDNVMWNoZkRPOGRi?=
 =?utf-8?B?YXJNblV6QzY1a3luMm5HdnR4Rk1yYk5HYzlBeDFucklTaG0wR2kyeS9sdVds?=
 =?utf-8?B?azRSbjEveFJGQTJSanA4VHZMREFmQnVpRXFSRkVJYklaSytYY294NUpLRnpQ?=
 =?utf-8?B?M3NBYWdjOFNKazZZNkRnLzBHcHpjV2Yvd09BVXZLWm5ab3l1MUhIZmFTckpi?=
 =?utf-8?B?NVhqcUdCNUtBYkJBOTlQSEoxNGRRc0NZZFZkb2RJU1VsaitKaXZPQjlvRHZ0?=
 =?utf-8?B?UlBUWE9uenphN2tXY2dxYXQyR2ZjLzI4Qm8wYU5vSWZWZHN6eDh4QnB0eUpU?=
 =?utf-8?B?WVJOZGIrUWZad1JnSGc5bkUrZld1N1JFcWxid0lucDR6eCs5MHVsWmFmQkZZ?=
 =?utf-8?B?ck4rM2U4ZDRzbjFzNmVEM1hXLzljL0RQTzE4Q1hnRWJhUi9FM09zS2xhMkx1?=
 =?utf-8?B?WjllZkFCdjlaSVp0MXJZSHlXSzlJc0tmNC8zT0ZPRjBKbkI4QmZKMUNTRW1Q?=
 =?utf-8?B?VXRiTVdhTFNZR28zWTFHNXUrRUQyRG9kN3VHWVQ0NlEzVFNXQmU5OVVzajZL?=
 =?utf-8?B?U042VmxDMDdlTWgxeFFtUmdJOTVmU2Q2WlB4Z0tWQTl5TUl5eXJyVVFZTjNk?=
 =?utf-8?B?d1dqUklYcVQ5VG45aTgrNngrWE44QUpNUjJtZnZNZ28xQ1dmTXJvelNPelBq?=
 =?utf-8?B?NkdXMVdkRE5mUTJhcmVVMGJLclYxYkR0QjQvbEt0b1FHSk8yUDZmNVo5Ymxw?=
 =?utf-8?B?QnBvNVd5UWoveklZai9OOXRLMzZuUXVkVXZZTCtRcDBWbFNlRlBqL3lVaW00?=
 =?utf-8?B?bThId3MrOC9LT0doM2pxWTRYbHB6SG5zR0Y1dk9EVG5VL2M0Z0paVUkzY3JK?=
 =?utf-8?B?cnlmU3IzNVppdG9JT2MwSDR1U2lDM1V1cFAzeFJ6UmJtMlFDRTZ6T1BlNzJK?=
 =?utf-8?B?NUFqVWtVU2U2TlcraUQzeEl0LzMxOGZaalRkMFJBTSs4cHU3S0tISzFIdCta?=
 =?utf-8?B?ZW9va0d5K1B2OUZzdWV4S3Z3cU1CTHpGeWh0WEZmVTA2aVZGTEhielBKbWsw?=
 =?utf-8?B?OU5sRmJaa0tRRGp4ZVIzMDdUQ3dSb1BPaWoyOTNzYW8wdm1mRnhuZVAxa253?=
 =?utf-8?B?bW5jMEs0RVZYOCtpR2tjTGpGbVg2UzhOWVV5aWlwN2ExM2loUFcwSzdad1Zq?=
 =?utf-8?B?WlEvdy9aR3M0K0kveWkxSDQzOWk3MXRoWk9Qdkg1UEtWODUzQm4zbDg5MjRI?=
 =?utf-8?B?UHFNcFIxak1SNThJZzlMbU9NNUdHQVMrckR6R05KbWRqMEc1a09nMXlWdHVs?=
 =?utf-8?B?ZGtveGNMQkNReXpkaDdZaGtscW4vYWlPNVpLRXFENjV1L0RXWnBTUVBxdTNI?=
 =?utf-8?Q?HSVu2jhu5X6D6+bpblY54BwqO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0efdc2f-fca2-4e88-e800-08dba83e5609
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 03:16:29.2546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhEHN4Sg5FVwNUbXRGeVz1TNeRo88L4pdLpTVpgZ1ljHXAFz8+0/XFqf0mAySOzo2zuYQn6XAU96GewCjMCpBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arjan,

On 8/28/2023 8:04 PM, Arjan van de Ven wrote:
> On 8/28/2023 7:28 AM, K Prateek Nayak wrote:
>>>     - Are these really different between AMD and Intel or is this some
>>>       naming convention issue which needs to be resolved?
>>     They do have different characteristics since, on Sapphire
>>     Rapids, the LLC is at a socket boundary despite having multiple
>>     tiles. (Please correct me if I'm wrong, I'm going off of
>>     llc_id shared in this report by Qiuxu Zhuo -
>>     https://lore.kernel.org/all/20230809161219.83084-1-qiuxu.zhuo@intel.com/)
>>
> 
> Sapphire reports itself as 1 tile though (since logically it is) as far as I know
> 

I believe there are some variants with multiple tiles, at least the
following press-release suggests that:

  https://www.intc.com/news-events/press-releases/detail/1598/intel-launches-4th-gen-xeon-scalable-processors-max-series

specifically "... combining up to four Intel 7-built tiles on a single
package, connected using Intel EMIB ...". Perhaps the one from Qiuxu
Zhuo's report does not contain multiple tiles.

But coming back to the characteristics, would it be safe to say "Tile"
would marks the LLC (L3) boundary if 0x1f reports multiple tiles in a
die?
 
--
Thanks and Regards,
Prateek
