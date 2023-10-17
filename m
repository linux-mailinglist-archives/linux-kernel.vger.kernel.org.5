Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5497CC1FD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbjJQLtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQLtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:49:21 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2041.outbound.protection.outlook.com [40.92.73.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC04EA;
        Tue, 17 Oct 2023 04:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5PyDcqUBACsj69Ks0+X7/PSiNkT9/4EQIG0i4wQUsJjQlC8NtRk8Ms4q9Pusqv2mvn0Uk2cZGeeehfTI/lKh7cEofKplfN8lKXSErP6s9bv8AE7Kw0aFDN9kBZmT77bMboGzTqbq+IeFk5XAH+f9vOTlAJOtGIWknAomlqg1TYYXPOYcUd/vI8IXd5QynCnLggFwm7zmqm/kOwOUbTgT165v/Kd3NwblGBlWMaxJSNXBxORee47hyNXyzInHrJl/zpj8KT54+4rrl8X/YxQPtc2O3ubi1nWOmRmB7y1DXc5dx7B80EK1xOxt197EQFC3FkykkRkIZt+cAvT8OZ9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZruKVeR1aRK2ERa2+OzHPJCIEzlYvV/IONoz4Ah2m8=;
 b=gxKObr3Hqckj8GIK8nkxw1MalyhqvoSvC9zHnLo3Ymh2LUS/q2J0f2iPsrJUCyuSzTX1CGbigMrdRTjmfOIyYtaRqxQepiFx5Ly+aE9IWn3oUWBhQaQ4VuAByxm/IlcksKTnFA/TOEcjBp3C2D2/q2kW2uDT/+LwlT2xQfVYENKk37s3lYb6UiWqFiGna5V1n15fe79lIcilnMgsprXIX6le30dEgDCTIqLNbAnYSWReP2mNTMf9HbQ9/mtfpfC9X4dpS9AOprNALqwUZowgOH4hxtG/b/uVo8m7xy+uRe13VqPWeoimhBbD96lJLG5clc/V4dPMY/TyyOgEdYsToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZruKVeR1aRK2ERa2+OzHPJCIEzlYvV/IONoz4Ah2m8=;
 b=qmm6Gir87G0NsxvvwQF5f9Ejlhknz4Zs5+wrrSJiyks8WaZS/GmZ2fC0qxhPVRMpMYyT1hPwvPiCsipJ4nLay9MJrWAnrdf4HzZNn8mmH9sKrySSMceMMo6+PMdbWsDDIMmEGk2Hygm1AszH5CyKRVI+9LyQG8NC6W+Ta3S8EmBewVlwAq9UhvivJBTxgEUBF7Z3G+FT8a07oJ3/4HOu97jbanBtIUGrfqfbaIHmu6P9PdWrMRrZPnPdPWhIeO7XZ1sTtlyLj88UXDtY+77oeGF4uaEZrkrPssbDIrzKXCawpPHwQcRqfpsXwsT2PEJwI2hwptCy/zf0zF1phJZH6g==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by DBAP193MB0937.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:1b5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 11:49:17 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::af68:c2a:73ce:8e99]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::af68:c2a:73ce:8e99%3]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 11:49:17 +0000
Message-ID: <VI1P193MB0752F2E6DA346CDB2BCDBED899D6A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
Date:   Tue, 17 Oct 2023 19:49:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/tls: Fix slab-use-after-free in tls_encrypt_done
To:     Paolo Abeni <pabeni@redhat.com>, borisp@nvidia.com,
        john.fastabend@gmail.com, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com
Cc:     netdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com
References: <VI1P193MB0752428D259D066379242BD099D3A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <20aed7c604115c7f346cdbbe848c37feded3cf21.camel@redhat.com>
From:   Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <20aed7c604115c7f346cdbbe848c37feded3cf21.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [bagcPbRkxbNDFL/aBbWPy2QgnZoi6bYo]
X-ClientProxiedBy: LO2P265CA0337.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::13) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <694afb6d-54c3-4b33-a279-e9fd39259b3f@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|DBAP193MB0937:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f172eaa-4b52-4364-901b-08dbcf07179a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9h/IwcOQf2rkaXz0ADOGlCzy5BVzjiXyZk8vqeattKuO4TsJU/zoBzSEXnOjkwMdTEGza16BLYK4YNqXYRhnvPSJtV3t46zqbepMnYS9Cc72Lvq7+Bn9SeLixr+m5J5b9K+/9gtAMv87IG9NEt416sd7mZ2CUUtigt7eC/eBtM/D5zO43x0UNdmPGTS7ZKqO3txeSF4rhrINpYy13jxiDDKEzraXAa/U09LrMHeiAZzMa0ujOvWUCVi2OdI4r2rEjSS6Nlpx5+CcXHktcHz2f1SvKrrbL0VcZBkLvmhLqLaURfe3Nj83nv4O2ch2awBRP6EB2xda4sJlyanYCQ2FmNEuEPyJS8Q3sgeiAs2oh/KN/08P8BPF/aDI5hb6IxiSbWQgpYNuhj6ryeQjZzyqsxH9cl/4TDj3GIl22Kcf8mVB37wwmCa1SKHRcSRShPM4T2qqsJoW+/+B4iproaBxFIOU/mf5IkIUyjryNkgOnCPuAthlkiAHEcjP10qB4LD194dr+Lnet4QXzCrLVTDBud3f/+Mqbc8lmR+aJJDucTV66Q5ETiSnxGUFEUwcYNcXtUBeEzUJceF8vXkpFCILpzfusu0PNmbjMT96p8PIcg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTdjNjdwVE9pL3NVTmtJVmdHNituT09TMWt6NWQwUlNsYmlMeXc2Tm0vOEo0?=
 =?utf-8?B?VUE3RFM4eldFVjNJQ3h0bHo1RDdxUmVxWUZQRldhcHEycnB4ZUhwWTliWVdr?=
 =?utf-8?B?MGZyVURFLzQ0N0UwRHo2U0tsVnNsS1Y5NVAvak1zT0QvNXl1Nkt6dm5aSUh5?=
 =?utf-8?B?V2p3Wk5GRFpwVWZCVHhDR2haeVhCRW5vNk1jYnlubHFBY0NFUVJEVEtVN0ow?=
 =?utf-8?B?dGYrVC9mMDQva3dsQ3VoT3hmV2xydHQvaGRCYWR2bHVwYklnZTVXazVWb0tn?=
 =?utf-8?B?a3FJOVFKL1ZqZ3U5QUVTVEJkakhRVit0SitBVklZam90OHM1elRHNnExV2Q4?=
 =?utf-8?B?OFpDUGNWN1cwajBwZmR3NnZZVTNwL1pvL1FHRnNXa3k4QStCOXJSeHIxYzhn?=
 =?utf-8?B?eld2a01nWE1vcUZXd0J6cHlNbytvdUtXTGtTQWcwKzd4OHE2Y2RSakN0bzE0?=
 =?utf-8?B?SnBnNG5aUEx3ZkcwdW9Tck5maXhWQXJoTi9BTjVYa0lnNXZNMW1mNzZVaHRr?=
 =?utf-8?B?Q0RTRWErUUNyWllqelU0WllLdUtHeFlwMnZKdThxcTdEd0lBV3YrOGpqSjVz?=
 =?utf-8?B?V1BFSFlzTlFyVGxBZEtybnJTVld1V1Fvak5JVzRHdk01OCtFRlVUS1lVdzFG?=
 =?utf-8?B?cnNRZTlJUzU2b1BmVzFaYVR1YkVscUFLZUh5czRuQ2xRUENuRHNaeFRLZW9U?=
 =?utf-8?B?bUVja3lZRHo4Wjcya09Tdm15MVhGT0hYZExGZ1U3TDdzanBGQzNITDZ6QkZS?=
 =?utf-8?B?ZGVjZGNFZFJDaVhtSER4M1pJb1FTMVIvYVVVdjB1QnB1VmxSRzJYdjNCT1la?=
 =?utf-8?B?b2dndGFLeHZ3ZzRZVjBVd0JZL3dHNlhobHFxbndLN3hJTExFeURpZWx4WW9B?=
 =?utf-8?B?YS90dWNsa1oxWW4yL2ZFS05aQk9VdEl1WVlPTHo5dDMwcEVkK1FNdlJ0K1p1?=
 =?utf-8?B?aXFjeXZjQnhjYmFhVDNWeVltSDBINW5zWGJMU09yNnFiUStUUHp3Z0hDOGky?=
 =?utf-8?B?c2kyUFAyMXhNcnIvc3lKd08xVVJxd2I5a2gxcEtVWkJqQWxCeG5waFA1azV5?=
 =?utf-8?B?YldRRTZIR1RlVUpNVGtpcUhXRDFNOTFYWmZES2k1NDdIbnFaL3puY2tZcmZq?=
 =?utf-8?B?S2dRUSs2Y1JEb01uRkNNVy9JR0FFaGFpYkVhVms5WktkRGFSL0s3MnR0Tm5X?=
 =?utf-8?B?Snc1aTg5dE1JS09WazFqN1ZpaTc0c2V1NGFSdTQxazRITDVXVFRYK05jRXFw?=
 =?utf-8?B?bVovR1NnVHo3QU5kWnd3ajVMK01DcHVwK29aOTFHL3ljWm5Vb1ZVOTFwL3F6?=
 =?utf-8?B?NjlnOG9YOEdQT0Rid3Y2VXdTcDRNQUFwcW1GeTY0c2svenFUb2RUQmZFV1Aw?=
 =?utf-8?B?NTNlb1lZc1lwMFJjTEwwa3V0aEtJRGhYNU1nU0NxWUM1ZmUwVWVIeCt3bnNR?=
 =?utf-8?B?cGwzbzN0N1BYNjU3ZlFncGpjcmtSa25WT0ZLWUNIbjQwRXpPUDc4bnBOOUxS?=
 =?utf-8?B?TWpnT2hWZTZrVXJweThlc2hrQVJoQUpYVGNVaUlDeXBPV1JDTkhSR1lDUHp3?=
 =?utf-8?B?ckdHUWg3TGZQNTl0Tit4NUN3SlVzMXRjc3RVOVhyTS8wWS9iTXBOMXl5dS9Q?=
 =?utf-8?Q?kzn9Lm2+neiLFJqY0rskV6fgH4sAMZIkLIQ36BtaiO9Y=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f172eaa-4b52-4364-901b-08dbcf07179a
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 11:49:17.3264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP193MB0937
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/17 18:31, Paolo Abeni wrote:
> On Thu, 2023-10-12 at 19:02 +0800, Juntong Deng wrote:
>> In the current implementation, ctx->async_wait.completion is completed
>> after spin_lock_bh, which causes tls_sw_release_resources_tx to
>> continue executing and return to tls_sk_proto_cleanup, then return
>> to tls_sk_proto_close, and after that enter tls_sw_free_ctx_tx to kfree
>> the entire struct tls_context (including ctx->encrypt_compl_lock).
>>
>> Since ctx->encrypt_compl_lock has been freed, subsequent spin_unlock_bh
>> will result in slab-use-after-free error. Due to SMP, even using
>> spin_lock_bh does not prevent tls_sw_release_resources_tx from continuing
>> on other CPUs. After tls_sw_release_resources_tx is woken up, there is no
>> attempt to hold ctx->encrypt_compl_lock again, therefore everything
>> described above is possible.
>>
>> The fix is to put complete(&ctx->async_wait.completion) after
>> spin_unlock_bh, making the release after the unlock. Since complete is
>> only executed if pending is 0, which means this is the last record, there
>> is no need to worry about race condition causing duplicate completes.
>>
>> Reported-by: syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=29c22ea2d6b2c5fd2eae
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> 
> Have you tested this patch vs the syzbot reproducer?
> 
> I think the following race is still present:
> 
> CPU0                            CPU1
> tls_sw_release_resources_tx     tls_encrypt_done
> spin_lock_bh
> spin_unlock_bh
>                                  spin_lock_bh
>                                  spin_unlock_bh
>                                  complete
> 
> wait
> // ...
> tls_sk_proto_close
> 
>                                  test_and_set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask
> 				// UaF
> 
> regardless of 'complete()' being invoked before or after the
> 'spin_unlock_bh()'.
> 
> Paolo
> 

Yes, I think you are right.

My previous thought was that test_and_set_bit() is only called if
'ready' is true, but 'ready' will only be true on the first record,
and complete() is only called when processing the last record.

I simply thought before that the first record would not be the last
record, so I thought before that the test_and_set_bit() would not be
called when complete() was called.

But your reply inspired me and I thought about it carefully and the
situation with only one record is possible.

I will make version 2 patch to solve this problem.

Thanks.
