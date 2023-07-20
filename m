Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE4C75B2BA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjGTPcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjGTPbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:31:50 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFEA30FF;
        Thu, 20 Jul 2023 08:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACL2U6ttH/silbP8YMOMleM68SQYCTnYYE0FbNiHqYh+5kIRnGOJ9AamSzBUBue223cgbl6T3khEublX/zQe2kVE9xOMXaRVp1+QHOEJdzu1SbGEuY1pT8EtijALwLbb2sitqqwdyIK9krHuXoffT0FNgGJgG6MXg3pHxT5z04jk6VBYH4+CLdBQrRqpv90wvl8MET06rHQuPQpcshrJthZsiqQ/DpWN4w+c7cIS03rpChGTXd1+hOXuvbO7CUrmYX+pwHOxlqWMu6T+xJ0+N54M8W38DvxF8Ngd+M2mMfxRp7mXvt4ZnXqYfU+8cu6pP9poxY2ypRwnDRF1ow0big==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/iIcRKzljZTnndxDMQNNGl2MLSHJ0aui+qRbAwspLg=;
 b=gvd4ypht+KXuQFbbKMXQumIlUG7Jcq33jLzNCbXkPpRc+x2mcwokrv4O0/ciVIiSMMDklpQZs4wmjES8QXR9ZTp3+bT/G0A0R3k9yujSuIBMZCeDzXIwJkSpG0MThaNvTdW/sa9/Bsn0r+96mFwoFmBmCHLq+Z5WF8FO/39b1dNRnBtLcJoit1zNOdzJ/aro9NbnWI+f/E7nBx8ebBGp9Y8iMacggKDRlCjzRGXbWcBWbCZh1o+4XV//boSUSzDAjXoX9g5KVaL+ApGFbhGUsh67R16QpQBu03pvRSCyBhEV/6gGjGgvDCPwHX/VHVk+tH3mTKP5BAGGv7tsZ0ehSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/iIcRKzljZTnndxDMQNNGl2MLSHJ0aui+qRbAwspLg=;
 b=wO0Rt7CN1Q7qGEX5LYxKozBV+n8gaKXKQ+YMmOBSPnIbJv1G/p9UF5WvdHqF1ycWFzKWplXISvpecB6QOzAXUJ/w04AliJUK2eoJToRfMmxbmt40pGG1Q/wYTXS1Ccg1f2M/UOUSodxGK7LCpwqRdgRqebWU3UQDPlafPUEGuOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Thu, 20 Jul
 2023 15:31:17 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::bf76:da18:e4b4:746b]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::bf76:da18:e4b4:746b%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 15:31:17 +0000
Message-ID: <b949697e-319a-7cc1-84d8-1391713fa645@amd.com>
Date:   Thu, 20 Jul 2023 08:31:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        xuanzhuo@linux.alibaba.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, edumazet@google.com,
        maxime.coquelin@redhat.com, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
From:   Shannon Nelson <shannon.nelson@amd.com>
In-Reply-To: <20230720083839.481487-3-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::44) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: db36a43b-c27e-4b3e-a194-08db89365c05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aUaGBNE67ha57Y09AAxLC0rqrzWzQhb3XJLxacr6WnlxkYXs9BwaRIdN6JcAvbHEUmoAov8O48o7ffKIb7cyV+s580vrU8L0Gm0f1ncwN2c3Dl3o9VxsXNqQc2Zj8z3JYbtwfLxLSXdj2iFvaLqcyz7iZbc9f5jxb5sdwIs8P7L7NPI2GyzhIJ3KwGWqQPBaASEJScgB6DMlDK2duNNxHDpiYdaRJK/tAg98ujoOn1B5O4j3JrwKDCZUIq5QW9Y8kSDwsn+h46Ga6glncuVSN7RgffeFVOL8ivh3X47b05HEeUwXO0zNGWP3BHyAQWRl9SxlBOQtizNpH1S6IY6Z89ZQl/qv6/F0/Tc4T1JSagw5Lfiryn8Ye+ijF08fMOYqB8h8Z04cQ5jQT1UtG0cEKOedg6XuM6ttR08vfpwvcnpeinfn3okqDz4h+FWNuA2Fe1YWqkL3LtgjY3B6xufZ5UtuIQ9ENI+vhQzIQ4Ln9O/49hxV40peNwOKFq3muo1uwWNIF/9Z/XJVQdyP3840uAlxZa5o69+27kcTQE9U3K62X2eQ6l1d8W7PU19Zj2/jzcLmVz36BYysGJmElqB9zelV3vnrrzPJ0MloQAErw1Z9AFGOsPCPJIjsNpymWyzt+7FH6ez/Z4PDy7F5Isochw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199021)(2906002)(86362001)(38100700002)(31696002)(83380400001)(26005)(5660300002)(6512007)(186003)(53546011)(6506007)(2616005)(316002)(6666004)(44832011)(36756003)(8936002)(478600001)(41300700001)(6486002)(8676002)(4326008)(66946007)(66556008)(7416002)(66476007)(966005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUloTUdBMVdJVExlcVN0bTMxbGdFS0hzc1BJN3FvL1l1bzR3US9ub3BmcWJm?=
 =?utf-8?B?OE1ZUXYrSXA5T3h6SUpZVWU3bTNlbXpRcWpCWmhmZjNLazlmZEtiT3hlR2hi?=
 =?utf-8?B?TUdQc2pyZ1VrTWtRMHdlcGp4Yi81NjgxS3JzSTJFRVZsZjB0R1ZyOWRmSHli?=
 =?utf-8?B?TjRiZWJhVm9kcDVrdmpMSjZvZU9nNGJBZklaWVRxMHpkdGVoQzFZZ3V0SXF2?=
 =?utf-8?B?UWI5VU80TFlCNU0zcWhpdmcwTTVaa3NrSS9NeXVPOG5hTlNZcFJBSmdWQ2o1?=
 =?utf-8?B?ZTM4V3FSdDRBeFA1Tk1xQ1lSc2F2VkpCcTRqRVVaR0tnTksrcWZUZTRvTzZ5?=
 =?utf-8?B?UVppNkpSSDAySWppSWhuNWhNWUNkalBFZDM3ZlpxbzRZZEd1eERlQUROZlE5?=
 =?utf-8?B?NlJqNElKVkt5K3BOaVBzbGpIRGhYbXk4aVZZcmdSMnpJa3I5RWUwZGVyVXhD?=
 =?utf-8?B?UGtlTnV2VDRUaksxVGJ1SC9raUlVQ3dBZHNDelVNSCsybnp3Nk9hNTRtRDUv?=
 =?utf-8?B?RU9hcFgvQVZuamo1aUNLT1dGUWJ4MzhZODkrOE5QeTZDd1pLS2RuUHBMN285?=
 =?utf-8?B?eXBrN3ZydVBuQlBRUXhpcytaT2Y5R0FwdjM1NFlkelBPVU5vRGZaWkl2a0JY?=
 =?utf-8?B?d3VOeDBBS0RKUjBaVXNyekEwS01tRkpqd3pVbko3TUFPRlFqd0VjMDdWZjZM?=
 =?utf-8?B?a1J4ZG5QM2dIeVFXS1hxYWN6NVZWeUJvR2hhNXZvUlE0Ri81TzV0ZWV4anEz?=
 =?utf-8?B?SEk4RkxPT0dGZFpzVEdjMjBSbTNaeHZPRm9JMnZtS0VjSEFENnErOURTZ2Fw?=
 =?utf-8?B?VW5uRnZzU09xN21FcS9KU3BZR3hCenp2SGdYRndzc3FXWU5SVis2U0NiV0Q5?=
 =?utf-8?B?VEM4OHgrNXRZVjh0a2N0SUtIYys4WVpWZDBsMzZFdytSd2NVV1pFK1N1ZlVp?=
 =?utf-8?B?OW5VK3VwRW1MR1o2U3pXcCs3VENsTHFVUTUzV3IxK0k4cnlEdmNZcm5FckJ6?=
 =?utf-8?B?czlpS3JkaEdFZVY1Z1pYSkZaNWJUdjVsaG9ZdTd0K3IzOEpyQXhwWkJKQUcx?=
 =?utf-8?B?QWZkTFpjOHYxUGRaTmVCSkp4L0VOSWVIb0RnN2hIYkFzQThwMHIvZ1I3cnc2?=
 =?utf-8?B?NmJpajdBWVlxVG5ZNWV2eHNFY2o1ekUyRngvN0E0SUxtdzNkVnhhMnFPTDdj?=
 =?utf-8?B?VnVWdklZYmdiS21rdkE1WUZldGF4am9NeXQ1b0c5bXBvOUtGekt4dkZSQWdM?=
 =?utf-8?B?V3dFNnVxUmNiMVcvNk41MDNqUCtwRW9Qb09rVW9GcmtZb2htSFhvdVBxS2ZR?=
 =?utf-8?B?WUFOaEhKblNFMUd0K2llLzFZVmVScUVBTTU5YzdnSTFTZnBFVHJtNzJ2aktn?=
 =?utf-8?B?M1cxVG94SVZjUjVYY1U1a29MdG1jTU44V0pDVEdKWXp4NGROMlJxdXNibVdR?=
 =?utf-8?B?SkNjZTd2NkFZRWEvQi9WYmtuVzlDTSt0enFPaXQzNHFzZUpETkhOUEJYV1Az?=
 =?utf-8?B?VWVNL3NDa0lmdy93S05qVmFrUVZUY1RFd21JMlZ3bDE0d0RCMWUyeEFNNFpQ?=
 =?utf-8?B?djJZbDFSTmpudDZVUkxIWm1RZDBGZktNSUd2TzdTMSs3ZDJjYzdpRFREdFBs?=
 =?utf-8?B?dFdud2RqRkc5cU9SNzRWRU1wMytQckVJUHk5bFFJOURhZHNYZ2JKL3RpMmlV?=
 =?utf-8?B?amZiV21pS3AvajU5M1J1UHVaa090NWE0RnpYQXpVcGRUK3lacHlGdVdUWS83?=
 =?utf-8?B?Mm9rRzM3bEYzOUZqNlpIdUR5SE9tcW95dXBCNW04SE0xbGJUdkF4SHl2azl6?=
 =?utf-8?B?bXlaRVFGcEdqT056cE04L3B6c2dXQVFwNXVEN3ZHazNya3B1Q1NFSzl0Nis2?=
 =?utf-8?B?K1R1RFhsOG5CNk1iaU5zeE1MWnd0ODU1dXVIbFl3Z1hwdWxPaWRRMlJjVVo4?=
 =?utf-8?B?S0dXbC9ma0Z1L2p5NnNXUmdtdTd6bE1TMnhrRGtkZlk3blZZRzR4TUkxMXNT?=
 =?utf-8?B?dW1YcUFtSnBRU1ZtQ210WWtWNUhINjdVQ3VaMzE5Q3oxMEpqNUt6eVl0NHJW?=
 =?utf-8?B?aGpxUUVyVFhJaUxDcVN3bVRqbDlVMWxoeTVTYXcyOUVZM0hjY2YwSzFtSGI2?=
 =?utf-8?Q?xvNm0DTm/zTwDcdS4r40fkhKr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db36a43b-c27e-4b3e-a194-08db89365c05
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 15:31:16.9625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzaK6e7j3N/xq9aN0+7GumcA+cAEFPeElnjDyUQ/JvUI9kte4NRlec9rhI2XkOPTd7ZbxRiRSBLwuWSNvddgZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 1:38 AM, Jason Wang wrote:
> 
> Adding cond_resched() to the command waiting loop for a better
> co-operation with the scheduler. This allows to give CPU a breath to
> run other task(workqueue) instead of busy looping when preemption is
> not allowed on a device whose CVQ might be slow.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>   drivers/net/virtio_net.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9f3b1d6ac33d..e7533f29b219 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>           * into the hypervisor, so the request should be handled immediately.
>           */
>          while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> -              !virtqueue_is_broken(vi->cvq))
> +              !virtqueue_is_broken(vi->cvq)) {
> +               cond_resched();
>                  cpu_relax();
> +       }

The cover letter suggests that this addresses the infinite poll for 
buggy devices, but I don't see how that is resolved here.  This should 
make it a little nicer to the system, but it still is going to poll 
forever on a device that has gone catatonic.  Is there a reason that I'm 
missing that we don't have a polling limit here?

sln

> 
>          return vi->ctrl->status == VIRTIO_NET_OK;
>   }
> --
> 2.39.3
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
