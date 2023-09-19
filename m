Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41677A582F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 05:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjISDzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 23:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjISDze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 23:55:34 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7977B11A;
        Mon, 18 Sep 2023 20:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWpCEedx08Jwz4Mv4zRgO+X22+eBa34B9O2rtzjZpcCMWXjaBm5zp4cunRXIEuphdWCE5pdSi/OhruMi5eNTd9EPHkIvv5aM1v2wcS4v81KtP+WrYbvY7yTd3oNRkFjMD4ZLuFTW+j0Amy4gGETGn/sMrClkVDZ5wtHYssCdqvfC78fOuaU3jf7CIeICifhpA9prG2nTXR4C8p4uqU/W+9bkK48+wtiH0c+0EWyBMuxQznjpM3hdQbLaPsy//gjBECredkXv+hL4JRT5IN1TVEshzO7eY2jAugh+5Y3U/79NG9ftlhN/ip6br+TNHR6H4loBt2f3wgNJBfUuhZ6L9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDfhUaD0D/6e5gX5dXkteqAquiA+Hfb25i1T/OKHU9Y=;
 b=Mnqc+VLQXcHdNTzV0q9uXU6oX2+9TOlv3IXCseCd0qm0c3iy2ghH7ibwC4NfuSYZjkohqTPj0eOJIOQi6sgeRvf5lFuVJI4wpxYvJJZbVzlFVnWZHHo8upZneLrvQsVtbhhNPrXLQHXS7ClSrF3gsj23lih+m4Qc+2v6NxeoXYSBLL/O065zJmOgnS+vuYlqbqauL89vVDBx6U4aXgEpnZQVPwSOriPMbX0UfxXSLoCqMOCcDlkD9U55+xTgtXDXQrve+I58YM9+OARN+JLOoaBGfI3eTca9R220kOBS9A1012w4tW7cYHs/EdgMp+O3Qum6ZE2Esx8kwskzi5fxZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDfhUaD0D/6e5gX5dXkteqAquiA+Hfb25i1T/OKHU9Y=;
 b=Ormd2DDQF2RVY4NHBnsVwkHOV3cy8tUnC2+QzZFfXWc5rL/WdDue+cM6KR5fx4/lRn1n3p3Acvx7nFAa57Kh4H5d1wn9QMSeqJWNFoTsEFyEhcLalf+TEV+QAlhvWojTbi0k02LCqxdAugcRU5A5pF5NWJYrxA6AZYf0LCyK6xc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.26; Tue, 19 Sep 2023 03:55:05 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::6754:7b9d:a877:39b6]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::6754:7b9d:a877:39b6%3]) with mapi id 15.20.6792.021; Tue, 19 Sep 2023
 03:55:05 +0000
Message-ID: <d2b5b60a-7540-5a00-5fca-9690c1db85c4@amd.com>
Date:   Tue, 19 Sep 2023 09:24:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: linux-next: next-20230918: x86 build fails
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        memxor@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230918135002.6d9610da@canb.auug.org.au>
From:   "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <20230918135002.6d9610da@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::14) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 00dedaba-5cd2-40cd-b196-08dbb8c4351a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZSkJm9sxeRGdlg5gKn0N4B1/7fi0GRzXTlhJ72shBHRpX/M/yPL9h0+X2PaJSp8X3cUMNG3ZMPoUPG559gQqQ5tPdQiP2jFbiHW4g/wqR3t8XyMiMwo3uuEUSfEbatVRpkJA5NlJJFyxiEdSeCmpKTD0MONx66/HbafHXma6yEuSGkWQiuFUxqwS6hwBoxCwHyBgcXyZLMf7LjI60YsdAOyN1aWjYLc7wZlk8tL+3eAW9y4CytylsjFcvUtLhH0hBaFyMTbfvdj2kWTU+tJ+CxwVd0LWLZFuBByMEY386BuYMX05iCi9iwbaLJrc5t1q+lkayoSa9OwMSbEaP4a6xgwNVq3Go8wW7pQqvcqgvQ83skoZ/nBMAcVBFUC3an0oebBH59WPbrjcwFImgSV9bAdwyolX3aaRtlFKpDFilvn2tR/cSrno9iesQPFItMqFCpEkRNG9QtQadWH5tt4HG0UCGzmsSHxCDMt5ZGt/cnTrk5M7/wiZ6e/rIfKvSm/LOsnZF/htiCcgDDXmw9zgjZasdOs16y1pgfRpY59XciBM56fZlIFG6+hl8bniTRHp8vi9DPhG/AqeEGD+41dypcS0SjTUYnkBW9wsFgIFhWkPuj0XWZgsKRHXRR29mQoOJ1anyHBQ0MA6GbivPNR1vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199024)(1800799009)(186009)(6486002)(6506007)(6512007)(316002)(66946007)(41300700001)(38100700002)(66556008)(66476007)(110136005)(6666004)(31686004)(5660300002)(478600001)(2616005)(8936002)(8676002)(26005)(2906002)(36756003)(31696002)(4744005)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHNOV0IxeTBVaVErZVk1TDhwOTJuUGRMSm52eXhGL0xyN0szR2N3YTIyL2dH?=
 =?utf-8?B?M2I0eU1PM0xEeW9ISWVVQlpJRTd3YXREUGNQcDNzYmU0d0U4emVnTy9KWE9H?=
 =?utf-8?B?YmtjblIyL2lmek9vSmdrSHl5Wk0zZ1ZWMGJiZFU5QWl3b2VpTzRxWVVCQlp6?=
 =?utf-8?B?WFk1RlMrNVFhWnB1MDNFTzIzZlBRSkszR2ZxcjFwblEwcWhsSnJRSWpPVFZa?=
 =?utf-8?B?WGQxdWdmbnREWXRkV2x6c0lUSy9uVXZWTHl2SGZ2SzllQzJTRThSME1BM2J5?=
 =?utf-8?B?NVc2WXRmSWFyWFdjTDV5YmdKa2Q3K21IWm1aY3JWdEVLQmZhTlRXWlFGVUdY?=
 =?utf-8?B?VVM0RDFIaXdiVWxQUW1DSVozQ3BNUWxPTzZUNXl6Z09uVjYwY1RjeVE1bUYx?=
 =?utf-8?B?aENZU2VVMS8zZGxjanQrRmhuekJKR09mRmxmSFAyWkFGZHl5YjlCU2NPV2NH?=
 =?utf-8?B?SldMMVNNbjRNK2MvbG9tcU85dmJrYUNnUHNnN0N4c0VkNU1RREg0anVydTk3?=
 =?utf-8?B?SGN6VzhzNUJRbVV3dmxiSGx5VnE3dUpCa0c5U1JGczlJcUxnNG1QWG1ML2VI?=
 =?utf-8?B?YWMwTktkV2JUSmxQV2RVWFNwVGJTVEZNWjBjVVc5QnA1Zk5tMEgzTzZnL2hC?=
 =?utf-8?B?RlVORzdDQ2NZL1hITFdVT0hsOVpKM2ZqZEtQb09JUzQ2aVpqbEZUS3RRUEJl?=
 =?utf-8?B?SFdTNFlnOVVzN0VYWWpHc0JBMHd5M1BYcUQyNTFHS0RKOEVSSEhvWGZTY3NN?=
 =?utf-8?B?QUh4aGJDank2V1VHSDBua1lUYzdDdCtuZndka1VDWnRKVTNaazhLUSswNE5T?=
 =?utf-8?B?Nzg1TGQ2L0tGcHEyZ1orK0xheDQrRjFTUkhQWDVXb1d2TDNoS3hzb2JBalRR?=
 =?utf-8?B?YTdIWlE2WFYySUJmR2U0RTFyY3ZnVlVranpBZVUzL3FpVE84clJieUlPWm9w?=
 =?utf-8?B?WDExdDVibnZyeHdQOW1UejdwT2FkOVhrbE1kdnlzdFFGVVRNMG9Ta1VXdjBY?=
 =?utf-8?B?QzdvWUwzOEZHTjk2UkxsY2tGOVdSREpUcG5qdWZrRUVkVDJvM3JJRjhFcHU3?=
 =?utf-8?B?d25RSzNkclZwSUl6dGpvdWxXRGpmMElpc2VITkxhWmU0N3k1YTFDSWpLeTR5?=
 =?utf-8?B?YWp1TEpUSEtOc21MQzZ0THlZUEtyQldlVUo4NG1lS1lLWGdscU9lRlQvWmdB?=
 =?utf-8?B?eHRuVUQ1QjBmZkxycDVUNUdEWkZIN2NrMWw4VG1tdXNyVEdUeVJaSFhLc1Rw?=
 =?utf-8?B?dkllUFFBa2dqK2ZVT21kT1dJQytJTEEvdHpEQ1RueVFTaHc3VkNtaVcwd21Q?=
 =?utf-8?B?bXZ6T2ZmQ2MvUTFwSWtmUmR3K3VOcG1NbHNHdWpZbUpZcUpZcm45dTNPZXky?=
 =?utf-8?B?RDFzTWc2UTVMdXppdnZxRzZFMWwzdnZ4RTlTb2Z0VUhmT1F3SzloRlllV0pI?=
 =?utf-8?B?ZThtYUdyKzdiZURzQUwzbnpwWHJHbDRwcjVxQ1VqMXRPQ3EzbkV2ckluUjZH?=
 =?utf-8?B?ekJCWWsyU3hQek5SeGJMcVJ1SG9mQUFDWXBMeVBpVEJOM2lmaTRuWDlreDlQ?=
 =?utf-8?B?emNCYmFlbWI4djRudTFjVDlIUTBrMzJBbHRwWlZaZE9uYVM0TnZTdk5UdUZL?=
 =?utf-8?B?cnNUUWZGRS9hYUdnS0oyZzFZRmtRNkRnb3hHYndXTGRoUlE0d0xBRjdSRlEz?=
 =?utf-8?B?Q1VDUlBnRVNTbVFocGJQMlcrWXFQMVNEUHNvY2x3VVc1L2lkQ2dNcUo4YlAy?=
 =?utf-8?B?UTQ3aWptcmdNQU9vbHFuaXdkT1lLczlWZlhaVDJUSDNOYWFGWnlFbFNDMCs3?=
 =?utf-8?B?UzMvVTJmeUFCWlBBZkFBNjBFTzJWcVNDd2VXMkorMU1JSUQva1FvSzF1U1c5?=
 =?utf-8?B?VkhaYzljcFdzbXJ2QjR5YktXUzR4SmhiaS95MXdsc3FkS2xoeDE0MzR4ZlZr?=
 =?utf-8?B?Yko1TGxCRlVCa1Q5YVVweWZFY0drUWNCcHl5b2Y1bDdlNW9vYWo5bWVJanBh?=
 =?utf-8?B?Mk9BRUNKUC91aDJFMzJ0NW85dDBRRFpGNTkxL0YxR2ZuWE5HZVB6MjhaQzhL?=
 =?utf-8?B?V3dUUVVmaXdLWHZVNGRNUFhLSThCQ3NZNnV5cHp1SkRrU3FEbnppeWtUMUVH?=
 =?utf-8?Q?qlJIni9H+8CkVgDMKmk82mXSz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00dedaba-5cd2-40cd-b196-08dbb8c4351a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 03:55:05.1375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upWpYFMUXAiuFebMSuUGEVsXAOX+2CBYpbG9b6E9DrXbuEzNomW852srjVB5SKd63X4Zj0Rm2aHJ4OegA8Ymsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

linux-next: next-20230918: x86 build fails with below error:

arch/x86/net/bpf_jit_comp.c: In function ‘arch_bpf_stack_walk’:
arch/x86/net/bpf_jit_comp.c:3022:72: error: ‘struct unwind_state’ has no 
member named ‘sp’; did you mean ‘bp’?
3022 |                 if (!addr || !consume_fn(cookie, (u64)addr, 
(u64)state.sp, (u64)state.bp))
|                                                                        ^~
|                                                                        bp
make[4]: *** [scripts/Makefile.build:243: arch/x86/net/bpf_jit_comp.o] 
Error 1
make[3]: *** [scripts/Makefile.build:480: arch/x86/net] Error 2



Thanks,
Srikanth Aithal
