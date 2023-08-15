Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6A877D197
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbjHOSP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239044AbjHOSP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:15:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2425E1BEE;
        Tue, 15 Aug 2023 11:15:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gi1pO5vlz0RtVraAkkUewkTqab0S8ppi5N6wHXhw9Q/zE5kB1tJUFKMTRQyYk7kKCgHpkmoszucJZscbtxiPAn37uGQFXu9Queg7IgTn0dBmZxfv0CjMaJb3EOPGiQTk60cBakaPsz5F2a7NiE1VLRfnuN5A1IDHf3FYq8pSMc5pHzFZEnmvX4Zo4RR2pJQfjrp6JCL0F0fy/drbXSVlMPzNIF6mIGcJ0ozLCQkDBdh2JgIHyFNmikqjfz7OuA3xDkdvx9N7ciTu/+TwBrWUnL2AnewRJOgniQmimfnMR2BBGnzXDW3jc2NkJd4Fa+iorV5AV0bc8r1x7/7C/Zy2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxIsdT0CQfeJ/wLQuY7s08wzdm5tdeXWN7VCQd6KuBk=;
 b=gx6FKd8KizZaN0nI17UyGvOdvzphvusG2h7VzVGkxhsZVGfTJW4RPRmMnDUKSdUDg8H2AONDIZbnF0Ky7jmBdR8wqGQJ1ByAciYsqw/UPfIBm8IEsOMMxiJZeB7YOg8KqgFPKi4BZAqYjuzIJCK2lRWHkjPqtvB4ndS1DU0cItmQdIx+vlqhl9qEo6PY5PKlFFDjrZ2fs+5W9gfPEqf5+bbxINGP8VYFXTLrHPSAczZtGOVeVVDXjqIQA7ZrMvyP2cB9KfeqsFG7WcVCtvZrUlujMtBz0AZ/V7hnHstWXu79XmUOEJccFezIuma3aUo6auXLqDNCCFMKZE0dGWES2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxIsdT0CQfeJ/wLQuY7s08wzdm5tdeXWN7VCQd6KuBk=;
 b=dlTUAP1bkknveIqzWWwPwa/tqCeYYujE4VkDGzwKwW9H4uEqU0P+uiBWTnb1tL8J7KH8I0RViolOUw7dlplLHwm8N8nYH/PCy6nb06lqke6Uh2wsVevPj6JNRL0EMjfBcuCWrOiMBxHZ2NRRYzSia73LZIZ3FfW+/tUn7Vn7XR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CH0PR12MB5154.namprd12.prod.outlook.com (2603:10b6:610:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 18:15:12 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 18:15:12 +0000
Message-ID: <85964510-4f88-58d2-2687-f7fa76013cf9@amd.com>
Date:   Tue, 15 Aug 2023 13:15:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Avadhut Naik <Avadhut.Naik@amd.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [RFC] Proposal to relax warnings of htmldocs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:8:57::28) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CH0PR12MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed13995-5b52-4ece-561a-08db9dbb9151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iH5Z8/pWaEAIWJNuowe5z6oRruIjB86ouj51x6L7t98RBwCeLFarhy6nXmSKpinkTQeWENACrh83KAQUh33gvcDqcJPjfecruXqde69SzFINWwNgK2rfsJAPJ/kdRVmleRrNGui+AclKCNnDk5893Gk3G8XpH3kB5+xsj+hyQXb9l3EB2mtmPMV2zPyBDqAsOMRb2M1HTmGQwf2XgtY8W/2Jr08ZLUj+TXX2Gq5OOymvRxP2seD02sgz8VqQAPVkdAze889Ubet0jQUqOcllClXLEhrGj3WN4KNHo0ukpoUh3sDVprHXpVWG2Mwhv36Ms1rDUcuB4D86BKiLx9O9heUzzwqZ6HPfB3FCgIwWyitbtfqSKXZzfvpiGfQiu+pcvJUkCKn7O9OV/4wycDTgfCciKC/9a/OytkN1823LcQu18zmwbKeOcP3ijn1twUlDaLqvPfLPfdY4C4I81xn3nAIsj/O6TpGrr5mTCe2ey7H0K5R9j/QMu8xPABEVUyQbwG4lwgCifdmwED3FKn95Yp0Ee56//OBzskt7fJ3csYDBbnyBctgdXT3dfFpvAaN+x7ObB4sWgZMqvMv3PMtIZoWdrlqN23LvkX2AawZxihahwuQFcdzx3ka6Vi2NnHCjsokJ0m8UWoT5jClsv/OCWrnTgzCLtK+6oOkm7YBUTdc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199024)(1800799009)(186009)(2616005)(6512007)(66476007)(44832011)(38100700002)(83380400001)(478600001)(4326008)(66946007)(66556008)(54906003)(6506007)(8936002)(6486002)(2906002)(26005)(966005)(8676002)(316002)(31686004)(31696002)(5660300002)(36756003)(110136005)(86362001)(41300700001)(486264002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0dsd0REd2t4dzAreUNDN0tjdjFWRkJGY2NuOGxmakg4S3F1b09sNGlCV0N2?=
 =?utf-8?B?N3ZHczB3bXNrQnRjNC9WOE1rd2RndUprY05WVHRqTWtvSGtpUmV2Q040Tisy?=
 =?utf-8?B?SWk4cjVEWXdwQmJuUSttb3NVdXgxeHNzL1JETWNjaGJTR1dMQTIrdHVoY2l4?=
 =?utf-8?B?bkdaTWJSY2hMbFF2RzV3alUwTmYwb1dsYmJ1dzB3SEFLd2RvYys2Tm9kcUpW?=
 =?utf-8?B?aGY3bnlOdUdFWS9STExKcHBQamNRZi95dlVRZm1Uck52ZDNxTi84SmNmcito?=
 =?utf-8?B?c29Nc0o5UG1BaUdxRE9DNzUveVY0N3Q5OExPOUtEYVZQUTIvTWw4alUzQWtr?=
 =?utf-8?B?RHFlS1VOS1B1aFpNTlg0OTBXQ1lwT1pGRHhZMENCVE15YzdNT2JGVExnSGVy?=
 =?utf-8?B?NElBUG96Mm9KQ0VoYzNobWdZNGtaYTBTSmp3MmhrRDBoRm1LOHlPWTdrUmdu?=
 =?utf-8?B?YjJqQkxNQ3dWQWpxMVROWjV1V1VNcm5YNjFRNGNkai9yL1JNTkxhcis2YldS?=
 =?utf-8?B?LzRBRFV2eVppMmY3TUZlMUgxUEV5ZkNoakRzZU9iSURxUk1vSTVEZVA2Njdo?=
 =?utf-8?B?RkdJb1FBdVVjUFFvaVdyUmVnOFMyRkNjWStXcHhwMThMUlNmMHFLVyt5Zkhs?=
 =?utf-8?B?aWppR2QxQ3VOWWk1MU5RcXpDMnBmOVYwbXFyR2tVR2lVcmpzcFpGQTFNZ1Zu?=
 =?utf-8?B?eWhkamttaG1ZdWpvT3poSGcwTUNnUmEyUVVDcGtyN1F4bU0xUVlJM0tqSjZH?=
 =?utf-8?B?TGd3YU9wejlXK2NiTlhPbit3UlNsWlN3K2NFcTBzNmNoT2t3K1pkRkQ5NWwr?=
 =?utf-8?B?NzhlRmFrWUtodGVsdGRCV014YkR4ZHo0bWRVblpUaGdtRU8vMzVET1pGcERV?=
 =?utf-8?B?d1lZb2tJbEc3Mlh1UUFaRTZUYWUvcUJjTHpXSFRCODFpYmtyVmszNERwR1VS?=
 =?utf-8?B?bFV5SDNiS1MyNTRJdDkyWUVMYktVS0EzNzJVS3pTUEhwV0VadDh4bDgrWEpC?=
 =?utf-8?B?L2NNbU1TVkVqdURpeWZxVk5zK3cyQ0FlN0QwMHhhWDRwREN5RHlvdlZSR2cy?=
 =?utf-8?B?VmpybzdPcFFPTVRRRkdmcEJyT3FVbCtGMWoyTERubVRsTnpYaGdDbnI0Y3Z5?=
 =?utf-8?B?RFFUZGg0TzZ6WHNzV0thTkdPTmRxVUtqUDRnc28vbmNoRS9HZCt1aVg3MjZk?=
 =?utf-8?B?b3dXbFZyYUtGTDlCZkVJVFdEOUt6emt6V29va1duSFFKc0pZQjFleXdBeG9O?=
 =?utf-8?B?SGR6K0NEbEc5WjRpMi9TR0RLQ2ZCYWlGRzR4QVJmRlZaOWszVjZFNFZyaTVB?=
 =?utf-8?B?QVZ3UFV4TUtOcm1DV05Ka3lWT2FuQWFvTXdFRVBPY0Fzei9CMkZ3dnVYdzJX?=
 =?utf-8?B?OFZ6YTdUZ2pXbU82NnNOV3dncVY1c3FQQXBUUE5QbXRkK2lPaWNFZ3N2TkN1?=
 =?utf-8?B?bHRQaXdVV0RCZWRqZzZ4WjQ4bzVBUVpJZ0dPV0J0N1pLUTcxdTVSOUhUSUla?=
 =?utf-8?B?Q2VkKzBZd0ltUDl5b2xreXNFQlB1MDNqSzR4VWVENUZxQlZBdkdSRFRVRXZ6?=
 =?utf-8?B?NGF4eFpSUW5rMlFWbGQ2Rmdkek15aGpHaG9LWVkxZWpGRm9FaE9CS3pTcVhX?=
 =?utf-8?B?OEZRcithTE02UlVPeXJmamtpT1h6YjRMTmFkaWlLeFMxMVl1UEhYUlBjT1R1?=
 =?utf-8?B?dEVCOUJFTXk4VVRTdHRzck5nS0tWYVMwZUc0MG9kenBWZ3BlL1ZjV3plN1g5?=
 =?utf-8?B?bEFMSklqcXhMY2V5OHI1U0lGWEFXSGZCQzRrMUZMdXEwVU41TGcwWWRidEtR?=
 =?utf-8?B?WnpJREwvcDdmRUJWdmlVU0tJdUlrVUFrQjlJSnVxa0N2TW4rRk51clI1dGVu?=
 =?utf-8?B?bEZQSHkrVHJLNFliaWFGNnNOUFl4K3RUc3QvWlIxbmpaNTgxVlZoSWpFekwr?=
 =?utf-8?B?YU00TnFCTjRINFc2WVZXUmVxUUlNSm45ZWcrVEd4Vml0YWNxdUdtUHlYTFpG?=
 =?utf-8?B?UHJNNll5OUgxMmpUbkhPaWV5WmZMU0YwN3YydDdITTJaWTVzOGREV0l3a054?=
 =?utf-8?B?YzhyUCtIYmhKVDZYcFlUbENpeHpzOUtZVDlabUVNQUJ2dWpLSTFVVWIyMEtR?=
 =?utf-8?Q?Dmp/4Pfkn3i/p1qdIo4OyPKKl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed13995-5b52-4ece-561a-08db9dbb9151
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 18:15:12.7868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odp5FPnTkFFC3tmMEhExJfATdGGJKHC8H/qH/3nWNlewrmc1W+PQ6rQBZgul83Hcin7IQDlnqT3ghEFjAHTDhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5154
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I would like to discuss a recurring issue that we all have encountered
while running `make htmldocs`. The process often generates an overwhelming
amount of warnings that are not relevant to our work, which makes it harder
to identify and address actual warning messages related to our changes.

One of the reasons for this is the variation in warnings raised by
different compilers. For instance, the Linux kernel robot employs Sparse,
which recently raised a warning that we (Avadhut in CC, and then me
reviewing his patch) did not catch during our testing [1,2].

Particularly annoying -to me personally- are warnings of the form:

"warning: Function parameter or member 'field' not described in 'struct'"

that seem to enumerate every single undocumented field within a struct.

I would like to propose something to alleviate this issue before the list
of warnings keeps piling up. I suggest for the command `make htmldocs` to
only display, by default, warnings directly related to the changes being
made, unless explicitly requested otherwisee.

I'm thinking we could do this, for example, by making hmtldocs a two-step
process: First running htmldocs as usual but with warnings disabled, and
then generating docs again but only for the new files (see $git diff
--name-only HEAD), with warnings active but limited to the scope of the
changes made.

I'm interested in your thoughts and comments. Does anyone have a better
idea regarding this? Maybe someone more experienced in Sphinx can tell us
an alternative way to disable unrelated warnings.

Thanks,
Carlos

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>

[1] https://lore.kernel.org/all/20230717181602.3468421-1-avadhut.naik@amd.com/
[2] 
https://download.01.org/0day-ci/archive/20230722/202307221642.nEBAfROh-lkp@intel.com/reproduce

