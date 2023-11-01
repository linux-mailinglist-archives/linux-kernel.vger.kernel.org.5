Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3407DDB1C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 03:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345359AbjKACnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 22:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345163AbjKACnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 22:43:09 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31982F3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 19:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4ZS3zLRkxJhRXXo0jsiQ5427ah2HYcZAMIAS2V7OooAwAC/VAvTuQ8gCRKhGEFUfNyyrsi7JbUWwS43ttjwlCxvHsvN3Yw17hYcvia3U11/WP2c/IX8f2bTLiYVB03UqUL1JFtH8tDTwp99s+C/6ZtGvqYq4c7Lg6gwG4KVuP6xe5RlAetXpJkdV7xOiR/TSNOxM2L30lvLyuwhRR9WK9n256dYboVgb3PYstV+sBQupaKLfUg8CBfw+y5dDgX1x5HQMD4JsFaBzWCgXDFFLdgzFBN3Zdjr9FUzQIVokFp/aarxrOtvFRrnG3TY+flUHb/0LkfZPuZ7gOqiG55sgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z05h+xNF9kpj4ARnTPKlW1M6hhs9DEDgxdJSDAJRvPE=;
 b=eBSw5HmV4PkWL9fRBDk7XoJzdxsn5zkzBOV3RNJLE5JtDSPR5vnypvIC1TtDk78iQvtRKY1u2ecQEp/XCPOg4bZeXeOlA5R4k4rW9YcGEBZdDT83uEw2EXbAGYuBKBT+FnLFtHZGZbHelm/EVMJJWnUmHoj8bOUFZGCOu7zEccs11mt4CHfobpMwy6tvJWOP1Z9R1JrZ3RrCjSWFS9cTsWlV8RMAuC68eDclv8E75ben5j1MMcvhUPMfvPAs5bGvXFtk4HKc3KcuHZ6+tX4XdZonSopvqURFu7K3t0DVYc72N+KhlLAjldKMbeJArHTrdwwPv1AvBi/1gR/mj+QRPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z05h+xNF9kpj4ARnTPKlW1M6hhs9DEDgxdJSDAJRvPE=;
 b=FQqjCktbvfTeuFsnoFpvOAv2g/3KLgyUunYHElQ159loRUVKJwoRB0rHu5i8YdQy5DgIJMzUoquAt2YmUHeEwxxC7JFzpcWaI9DBE05XvCatmEshwqLRPW0I/D29HozIlChsA3jhiSimldsI9FH0/qrOkRUOSd69sfa7wuWM6svHfR3ZbEkjdLE18DBSlgWSANrAXz8dM55xmCC8v2fcnybfVEROjseCBrvk4zfj7Hd3sOEYQCmLZZHkkuSk0CLwXpWeBIUY8j5df49/9O++svVzWBNS7FrT0iYJu0LUODh4zdkRSExgJ+i+PiVUmXxl8MDZf1/ip6/4qpPl2eJUAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7997.eurprd04.prod.outlook.com (2603:10a6:102:c9::6)
 by AS1PR04MB9360.eurprd04.prod.outlook.com (2603:10a6:20b:4da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.16; Wed, 1 Nov
 2023 02:43:00 +0000
Received: from PA4PR04MB7997.eurprd04.prod.outlook.com
 ([fe80::31c:b1e0:65a4:dddb]) by PA4PR04MB7997.eurprd04.prod.outlook.com
 ([fe80::31c:b1e0:65a4:dddb%5]) with mapi id 15.20.6954.018; Wed, 1 Nov 2023
 02:43:00 +0000
Message-ID: <4238c09a-c28d-43b6-8d1a-a5debcb2d8c5@suse.com>
Date:   Wed, 1 Nov 2023 10:42:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: call ocfs2_abort when journal abort
Content-Language: en-US
To:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Srivathsa Dara <srivathsa.d.dara@oracle.com>, mark@fasheh.com,
        jlbec@evilplan.org
Cc:     rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com,
        ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231030120057.928280-1-srivathsa.d.dara@oracle.com>
 <204108bc-8d74-6bab-a8fd-5598aa3e5cdd@linux.alibaba.com>
From:   Heming Zhao <heming.zhao@suse.com>
In-Reply-To: <204108bc-8d74-6bab-a8fd-5598aa3e5cdd@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To PA4PR04MB7997.eurprd04.prod.outlook.com
 (2603:10a6:102:c9::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7997:EE_|AS1PR04MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: fb40eebb-ea1e-43b1-a9d4-08dbda8442fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jtf07c5h/ssP4pB1oaOGEX8xBpXV9iRk81IuPz5tJnRhmuy/pVlnj5mt4q7VoZzvlaR+FM0jSdKAqi47Wes+QEjBvyiZGK3I/8aWL5zBhVRZlMGsQ2mEPUQlVCsqzUlj2MuMoAFZNuAmvgQ839oRDxaPpb58XYU4z37J4cwz7bn7o6c3iRZB4nPQO4d4G/4HBKGPKM3dRzbiXow3Hrp7KxkiZ7RKQKGYQLGLbQJP8sW+PRLWKK1sEUc/M17nxjCqv2Uvv8JYC25AOS1iMtiKzV2l/UFIO2lTJWRGWnVXVAN3FLdQRurOMoJifr4Ie2x0gGxuZGaNfDQjTIMvUMSPHP4+8dpchA1NVQEONpSAnRecNELcfnfBqQyXKl4HUEIGe+Se9IQkQj00te6GboSbCFz4lPjd7MfaU+GQ1/y49tdDOYZjlVTSMIFbup/QnVc2Dj+HHoxdCT5ZRynCzTEZ5IdRVRd92yJFrLxeD4pvExPAjyTsN25LwbzgwGrRtRfSc3nmfghBh6TywJ9ipYnYARs6RBrsJZzPwukiaB/U+x7NtAfjeATtBNY4U1JwQr2bGPSHznb1LsmpDTB09/9BFgCqdLWo+H5+Bu504l7g4O+oDNbsJkJYUfGMpQz2uwrwLWHiLnHXN8IETgOjwqvpotmHN8KNBxbPoHOiCcTH2D8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7997.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(39860400002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(478600001)(6486002)(966005)(6666004)(110136005)(66946007)(6506007)(2906002)(83380400001)(36756003)(38100700002)(66556008)(26005)(66476007)(86362001)(2616005)(41300700001)(53546011)(6512007)(31696002)(44832011)(5660300002)(316002)(4326008)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2R3bVM1ZjlWb05JN01Sb2c4NTgvRTZnL0VuaWcvbEVhZHNDdGlmOSttUTUz?=
 =?utf-8?B?ZndJSFhRaDZ2dUc2QXlsYS95dE8yUHJkUXdjNVpBRW1Pa0R4cTVXb0Mxdkw4?=
 =?utf-8?B?aVhVd0ZnUnlwSGJ0NEswQ2ZpRzB0dms4dVRUaGZzTkkzNUFPS05SWnplbGRx?=
 =?utf-8?B?Nk5vVGUzRVJ4ZXJDYy9kSy8yaFB0RjFpSXlIVWR2bFlPVFR1djJHM1FsMC8w?=
 =?utf-8?B?U2xkZmhwdVVFcnQwT2NScVRxS29xZHZoNk91Zlc2am9aTlV1WEIyRjFJV3M0?=
 =?utf-8?B?N1gwYWhneXFCWXRLb01uV2RkeUxDK3Zsc3FVZ1BQRHFUa21QM3JIc3ZOWWdo?=
 =?utf-8?B?SldabCt3cEdWNmFmVVRMcXA1RHlSK1hGNlk1TTIxVDVtdlgxMHJ5TlBsNm9O?=
 =?utf-8?B?SWt0eldDenZubEFiQy9NVXFMTUlXU3FWK3NhTDlkam1hZm5aeFc1bmVtRnli?=
 =?utf-8?B?UzdsNkVtM25sSTM2cDRGMll3cUpEVUZnbWJSR2RjZFVEREVyalVvaVhtNU5M?=
 =?utf-8?B?eCtlWTdqSWlUZFY0dm1HMFMwN0lSVzNDQ0xzc0JtQlBNYVFydHhIblZEd2Zo?=
 =?utf-8?B?dFdaMjBNVFcreG4zcTJGQnVoSitJTDZvalgwN1lLQ2tvbGI4RmYwUjcrSzJo?=
 =?utf-8?B?ZFF2cVFneHFTSnR4UURocFpwdmlCbGZQa0tlcE93dkFpVkNGb3ZvbWFLWjdh?=
 =?utf-8?B?S2YraDdPV1gxalE4M0NRRkROVTdCVGxmSFVZdFZkWExMMmhIVXkvcThJdFBj?=
 =?utf-8?B?QTZBRFBVdGRjSENGdWJqNXdXRHJTMjhBTkswU0gxVWRrWUY4dDZiMm05OGNr?=
 =?utf-8?B?bnVJMVFIT1RCZG9mWVgxUWNJeFAyTHpLdW9wbFdjQlZQaUhML1BvdlB3ZUQ0?=
 =?utf-8?B?bkhhZFp5YnFLQkJxZDNvTG5Ycy9TTERGdndmbXhwMW5wSTJhV3N1aHBNcERy?=
 =?utf-8?B?bkNhRnZsY09hODRuaGVQZVBvUG9zMHNzUWhmd04xczRlMDkyc2hiVW9nMnRF?=
 =?utf-8?B?RXJoS3RmWWt1Umt4SjhYWVFxOHdhNEpiNml3cjRIU1o3RmYvVEQrZHkxcStQ?=
 =?utf-8?B?dGF2SUVoekZXdlFaemVsZDJuWTk5c25sdzlESVBoUDRYQ1M5dkV5R0ZMVHNV?=
 =?utf-8?B?S3kzWXpEb0hndk1qY2RDcW1NbU1PcVlYSjZHWXhXa3pPblVCWHlaSWJPSmxq?=
 =?utf-8?B?L3BjL2tyU3EwRXZNZndta0dhWHN3dWtYMEFlVjZicVptekJiRGp5OFJ5c0hi?=
 =?utf-8?B?cCtRam1OWklha1pnVmRqdlpxMlBOVWdNNld4aWpneTcrQk1FWnBxWHczVzIv?=
 =?utf-8?B?MTV5bGcxdktISk5rM0VLZ1dxSlZPZUpZdVlienIyUlJRZkZpN0xwK3IvMWV1?=
 =?utf-8?B?NzdPMjZrSUxNeTVIM3RHalZYaDFFRmpPY2Q1dlVRb1RKbE9IeXJEVzIyLzNN?=
 =?utf-8?B?bXJDTnlRcWxEaFBEc051eEt0MFlibVYvU3p0ZTZPSnk3ZUYwQS9FMm56U2lT?=
 =?utf-8?B?YWNqazhmRmZrVHliTy9rS05uMVFnbEdST2RwZFlTb1lQczlTTTIyNGdRc0Zm?=
 =?utf-8?B?OHRUdmFKR0FVZ1BhZG1yMWQrOGhXRE5jMmJuOXdZUTZtZ2ZvR3dQSFNUMlVj?=
 =?utf-8?B?dlM4Wi9CcHd6L2d5VXJWQ2ltNVQ4dUlvZmFzVUwydnVHNDcrajN4cmpVK1U5?=
 =?utf-8?B?NmRURHcxQjJUUUMxVzBXVzBQUmYvRzNGVXY5TFlGQjJvQVBCUjBFcEJ6UFpB?=
 =?utf-8?B?UkFjUFdMc0F4SDNaQXdwZWlHeHZIQ0RSVkdha3BzV2JVYWgyejFEVkJFTVEz?=
 =?utf-8?B?SXd2NG5wbTdjVW5aQlR4VnpKSC9MOWlWZmIyOWNNc3ZhbkVlZm1zaFZ0V1Y2?=
 =?utf-8?B?eWVzcnp4TisxcW5MbjRYZkF4R3pyWEpySjBKa0Z1ZnV1LzNndlpOWkVxNmQv?=
 =?utf-8?B?R04xZTlMRG1LZ01JM0I2MDhRTGQ5ZnhjRFJ3anRNRjdsSVRqb29rTVAzd3d5?=
 =?utf-8?B?RTlmNUVveUZGRWhtRWRBS2FzQmxhYmQ4MVRzV1BJbFRaU2JPR2R0U0xmbCts?=
 =?utf-8?B?eHRQNkZCekYyYVU4TDltUVo5MC8xdlNiVnlJSE1QMXBpQWhHVncxMGMyYUVD?=
 =?utf-8?Q?pvGc/wgacJX+qBX5kVMnIQ82n?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb40eebb-ea1e-43b1-a9d4-08dbda8442fb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7997.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 02:42:59.9973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsUkXE3xYwmtZV2z5j6+DL8avyQraNaJfCaMC1yk29ASgPf+3LJQ/ryXCZ5NILc7n7VXWEw+Vp29cs535Xh3fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9360
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/23 09:13, Joseph Qi wrote:
> 
> 
> On 10/30/23 8:00 PM, Srivathsa Dara wrote:
>> From: Ryan Ding <ryan.ding@oracle.com>
>>
>>
>> journal can not recover from abort state, so we should take following
>> action to prevent file system from corruption:
>>
>> 1. change to readonly filesystem when local mount. We can not afford
>>     further write, so change to RO state is reasonable.
>>
>> 2. panic when cluster mount. Because we can not release lock resource in
>>     this state, other node will hung when it require a lock owned by this
>>     node. So panic and remaster is a reasonable choise.
>>
>> ocfs2_abort() will do all the above work.
>>
>> Signed-off-by: Ryan Ding <ryan.ding@oracle.com>
>> Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
>> ---
>>   fs/ocfs2/journal.c | 27 +++++++++++++++------------
>>   1 file changed, 15 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
>> index ce215565d061..6dace475f019 100644
>> --- a/fs/ocfs2/journal.c
>> +++ b/fs/ocfs2/journal.c
>> @@ -14,7 +14,6 @@
>>   #include <linux/kthread.h>
>>   #include <linux/time.h>
>>   #include <linux/random.h>
>> -#include <linux/delay.h>
>>   #include <linux/writeback.h>
>>   
>>   #include <cluster/masklog.h>
>> @@ -2326,7 +2325,7 @@ static int __ocfs2_wait_on_mount(struct ocfs2_super *osb, int quota)
>>   
>>   static int ocfs2_commit_thread(void *arg)
>>   {
>> -	int status;
>> +	int status = 0;
>>   	struct ocfs2_super *osb = arg;
>>   	struct ocfs2_journal *journal = osb->journal;
>>   
>> @@ -2340,21 +2339,25 @@ static int ocfs2_commit_thread(void *arg)
>>   		wait_event_interruptible(osb->checkpoint_event,
>>   					 atomic_read(&journal->j_num_trans)
>>   					 || kthread_should_stop());
>> +		if (status < 0) {
>> +			/* As we can not terminate by ourself, just enter an
>> +			 * empty loop to wait for stop.
>> +			 */
>> +			continue;
>> +		}
>>   
>>   		status = ocfs2_commit_cache(osb);
>>   		if (status < 0) {
>> -			static unsigned long abort_warn_time;
>> -
>> -			/* Warn about this once per minute */
>> -			if (printk_timed_ratelimit(&abort_warn_time, 60*HZ))
>> -				mlog(ML_ERROR, "status = %d, journal is "
>> -						"already aborted.\n", status);
>>   			/*
>> -			 * After ocfs2_commit_cache() fails, j_num_trans has a
>> -			 * non-zero value.  Sleep here to avoid a busy-wait
>> -			 * loop.
>> +			 * journal can not recover from abort state, there is
>> +			 * no need to keep commit cache. So we should either
>> +			 * change to readonly(local mount) or just panic
>> +			 * (cluster mount).
>> +			 * We should also clear j_num_trans to prevent further
>> +			 * commit.
>>   			 */
>> -			msleep_interruptible(1000);
>> +			atomic_set(&journal->j_num_trans, 0);
> 
> Unconditionally clear 'j_num_trans' here seems buggy.
> This may cause other nodes corrupt filesystem.

Yes, you described this buggy condition during review my patch:
https://lore.kernel.org/ocfs2-devel/2b90546e-d23e-7d45-22dd-a887a73f3e61@linux.alibaba.com/

btw, I ever send a v2 patch [1] about handling journal abort:
[1] https://lore.kernel.org/ocfs2-devel/20230626112453.22571-1-heming.zhao@suse.com/
This patch never get any feedback.

And I also send another mail [2] related with above patch:
[2] https://lore.kernel.org/ocfs2-devel/20230626150916.je3egonzb3crvbl5@p15/
please note, [2] is the problems from fsck.ocfs2, which is completely unrelated to [1].

Heming
> 
> Thanks,
> Joseph
> 
>> +			ocfs2_abort(osb->sb, "Detected aborted journal");
>>   		}
>>   
>>   		if (kthread_should_stop() && atomic_read(&journal->j_num_trans)){
> 

