Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA98D77D496
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbjHOUsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239069AbjHOUrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:47:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12hn2249.outbound.protection.outlook.com [52.100.166.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD711BFF;
        Tue, 15 Aug 2023 13:47:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rk/ACWjYYA276chk8yO5PnzgCzIkT4JTLk+OkTwIiLZxe/jG3RfdKwqzj8DaX22GFxHuIyZXY74VDtO5TPRE7aQlbqoZW7J+TVNmtMRG+B1lqpazzyApufgZSxmwQE+lEtagErVXeU5W0qS0u12MGSryseUIV5d/EpsWaZXM6T3Dce/D5hZCgMjfNz74VDM2oEZtb5yO/5u7YIUJ6xBZXqlf8kmk5pNivYT++zj+cJ6crnzdBmBEeD6V7LMfuvZeTDi5GqXhhv9MzYcRjxC8pkgxX/LVxJWzz6v8v3IeOSk1mf9eipZe92xoL296T7LM0fmQQxklwGcVV45Pbg5Tkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7SJB2kKzFcMzJV0s8Ck7GAAqc5FVrIHX3yHBaxcwBs=;
 b=Rau+jttoT2wsMrWfVgWUd0wRqGohea73dJPbANGnp9WYb7pKw3Edg5xjXboX5aNX2UjpFt+5RHNPh69o/FWoXp2LvM2rj1FvFHlkpGZ/GIbZ7fNPk65TFBHvuzlC++MBuDlkIVaL1zHVff+6yFHv+5mQhEpv8V9MpoS9iQpr/MdzE0MASTmXJUTOSz9eZEuYyCnXUHHXMbOk+U64+ogJXv9Zc4LaSRmr+yAAL6tOqheiBvcMEd9B2J0j33I6nm9bsmMjdL7O8tYK4yeoNFHetK3y02e6Jg2y/YoC4z86t4HgBYx6LCbX9sy28ZzU+tP7nn9MTijSZXYNohvyP4Duow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7SJB2kKzFcMzJV0s8Ck7GAAqc5FVrIHX3yHBaxcwBs=;
 b=aWfag+UCbIp4EeylsVBOeVlqReSdTnZ5iKDzT1wRdtMV+dAywHVtdTNmzgwodwCFxzAQdYBeptaD2hRxv7lcF6DYCA5FBdKqmsAemFBmL7bnJbobA6orGawtJyOFjYjtQRoa5KAVEHmV1yVl0ROln0UzR0qYvlq8umbkKxZ/u9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BY3PR01MB6708.prod.exchangelabs.com (2603:10b6:a03:363::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Tue, 15 Aug 2023 20:46:30 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::ed8c:18b8:dac:2331]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::ed8c:18b8:dac:2331%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 20:46:30 +0000
Date:   Tue, 15 Aug 2023 13:46:00 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 1/4] perf: arm_cspmu: Split 64-bit write to 32-bit
 writes
In-Reply-To: <ab4a51ea-3956-2d2f-5705-a760be69fb59@arm.com>
Message-ID: <e04669ee-d547-dbbe-e87b-5d7efa6ee8@os.amperecomputing.com>
References: <20230815063526.9022-1-ilkka@os.amperecomputing.com> <20230815063526.9022-2-ilkka@os.amperecomputing.com> <ab4a51ea-3956-2d2f-5705-a760be69fb59@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:610:e7::24) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|BY3PR01MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a7676d-b534-4aab-35fb-08db9dd0b3bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gl8LSYod2zE5z2EsENiJMlR7b/i/aawLvL8h6PB+jvBCzSU0+37BAsRHjeIN?=
 =?us-ascii?Q?pAWXLhv1SWS+FdfW1xntvKQ+nXA9xk6xjWFpl3acbd2tnykf66DzJi22v9g4?=
 =?us-ascii?Q?Tsb0piIMBVj+Pdip/1ACfXZ5W6FBaCrfTB6ofe3WRQHzM4YgfXbvfVHnXmmU?=
 =?us-ascii?Q?e5f0e2sYEUFVIU+wNwpvRuZQcgaqTzOGMYMD926hk6NonuwvFdFBz5i3t07D?=
 =?us-ascii?Q?oDO1Y2l6eX9iKAJmPQYahFoFXOTcY0cyq4xdpRobFTiov+TLBrhXv5PBZDb/?=
 =?us-ascii?Q?VgUANa8H1Yuo5qqI0x8QwLxdMhExr0AUlsdoANnVu/nAuNRkmDj6JqUEuY1P?=
 =?us-ascii?Q?1QtHmDeYxLxknFKM/OWx7bIeipiV2DWWVIb9rA36/q95VB4J1QSpl6aaXkDj?=
 =?us-ascii?Q?1iH95yX9rjYvueyjyu/mYfDSqQeSAHwz2lsYAoxuN/wtZsYZQZqfM4eAOQTm?=
 =?us-ascii?Q?V326ZDH+mc9fraB1znv84brvJAotQySCYzDkQwumvJGh0uC7OxlSxo37hmf/?=
 =?us-ascii?Q?vaaMrBqS0zb+tTfa43yPKweQcdgBgY6O5mwZOoX5bF7Fb2vpI/wzLKTCX7Wn?=
 =?us-ascii?Q?+3BArUowkzMTus+ZKj5v21MZAFjfNHZ/aLxMBPdHI13l4PWzqZnHYJgwAi6h?=
 =?us-ascii?Q?mUcL629GURcZ6uh/0arySSzpSavmdR8p6nqxg9T0d7PXNpExGSF5oM4LlgDe?=
 =?us-ascii?Q?TkArHY/iOs1aY0EATH2Li0EeoG8fZJQ2aRZoYBG3no4C7tq7dEAtc2OLjUKy?=
 =?us-ascii?Q?ssqpCBSQ/AiYvuk6gqWQnRHv8aIh3vCSmY/cf4D0S7Qldxh1+hOCJ+EVYtMg?=
 =?us-ascii?Q?gvQYAWhnbRUnnFzbFJy2+qiFLIkAuH4ycTfWSV3MIZJI1b6K5IuvKAGEWINb?=
 =?us-ascii?Q?LnZMk/qXQeiYTvbKuxkprhVcIwsITQf6c46M1JpfJzZmuTQ76AkyPfdnxuXQ?=
 =?us-ascii?Q?hl2NdwEkfUYdZwnuw/KYuWfugRjoDZJq7sreO4O90IIFfrpud7qNihuDvolA?=
 =?us-ascii?Q?DeWrFmPBl/x/+1Or1b0hp3y+G32BJtDhp6tK/v2/cOeduaA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:OSPM;SFS:(13230031)(39850400004)(396003)(376002)(366004)(136003)(346002)(1800799009)(186009)(451199024)(26005)(54906003)(316002)(5660300002)(83380400001)(8676002)(6916009)(66476007)(53546011)(38350700002)(38100700002)(6512007)(6486002)(2906002)(2616005)(478600001)(52116002)(7416002)(6666004)(6506007)(41300700001)(66946007)(86362001)(66556008)(8936002)(4326008)(58440200007);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kSqaXXUCTW+BHUCpk1pDYe6nFDnYqccEbf2ksBQgciKyEJosaIQiyMuRUCAB?=
 =?us-ascii?Q?1c78Et6chiwQiPAQ+tAX/7ujoKNM/xgeLeIsC+rpMS6GDofLIYVUPuk8VTa+?=
 =?us-ascii?Q?CQAyx/ZjYIWkp7gZLrkyHohwRcP5etoGcVr+RfC2IWHmtg22XBZkBNrYmhQ3?=
 =?us-ascii?Q?UmAsVp5V6DaG1CcmTlkAjFEne+38+YE9eLw9L1DiHTr955dnBDuLUeLFAW68?=
 =?us-ascii?Q?ZcQFuYTir6tgmzsx6PAnfEQtx42raXfSlhFBamnX/t0LgorWEeBU6VAZNvyI?=
 =?us-ascii?Q?BJxDgr7EcpS9Lqp8p0CCLEDPjXN29tIqZuvvg/03cgn+ysiYN29VYWLbj4cH?=
 =?us-ascii?Q?0HkYUa/OL/OB2xlv5P9/jENAHgrA4TG1hi2G+vwSBEABcG/KqJhEzZW8lAfz?=
 =?us-ascii?Q?gg+OfRG07nR0mLGVcfjoL3aTVZQdIQYnNzBeZznwUbuGX5PnEUbnhBb7In9S?=
 =?us-ascii?Q?QnMiE3A877ROFYTXSJYSoSb8yZWyAiDWj7QfJKbcUGq5J18YNplS3SjKfpRO?=
 =?us-ascii?Q?lH5FVAJWNowXoOo26l7/2NNxe33K0jPxZ0zjZ1KEymByUT6GJ59BavKuihUE?=
 =?us-ascii?Q?r3IQJCnSy+nV6QPWag9O1X0moNoSg2FqQlwWCkbAqFT64brxvbgnrenrShwB?=
 =?us-ascii?Q?6cK/YAUt2D4rv2AJEP+PA9a1pDtr0kUGepfz+Gri+/egQKQLIozgLJWu9KQg?=
 =?us-ascii?Q?FFaHTQJ9lkiZZ9TevaPnRdyP2HhF4CkXrpp9P3ZJIVtSK2E43Kz/mXTohUuC?=
 =?us-ascii?Q?qk85ca33CjvF0v8VXfwnDmK5ITgj+FO3yZfiUE/aeB1BPwrHMtyWgKu6SIHv?=
 =?us-ascii?Q?YsElasyaf8wwLGUI7FIW7YNhl1Z3jm5i7s2P+e/14OlLnEQ4XMbAQluD5RwZ?=
 =?us-ascii?Q?6vEsgoBUnblfbjXgopfG8xh0Zk1oTqypz80yEsZIuBOXgM0zX72Bv6BYYMZU?=
 =?us-ascii?Q?imJAr5v36HF07trJrsApl3JCPM35J7FlBmLQLOdw7OzfSJ7jlATH8fR5PIII?=
 =?us-ascii?Q?i6XY0yUjp7N3HgKKg22new//FHiY7IdclWsX3m6X1mi5WLJAd13XmUCPfCFU?=
 =?us-ascii?Q?uxKDl9FkQjSCewKxgyXzjyw481ACvPXccj+eAk9v4bjhCIDXvcu/Cv1QGosk?=
 =?us-ascii?Q?QuxoW608YYROG8a78T9tRHlzHqF+HcB4ByR7XRiyISpT97OZUG70b4e3uU1x?=
 =?us-ascii?Q?zKsgldAQGyA4EkJqcuQswCghexQWpXYEpCEVHSbznw7+zMBMMUqoIsiZwE4P?=
 =?us-ascii?Q?kt/SZpkuYsY9qsfZdtDzi+/qAplmZ3E8tXduMHFMsLQYsIkK+lsISMZplYin?=
 =?us-ascii?Q?MkBSXiiO2AJIwA8ydhELCDGZ9TrFkm6iinvWcg5HFac5el1n7mA/5lvdn+Jv?=
 =?us-ascii?Q?YfK8zX5MAhWK+S7/oEn7hXSFs7TI+kud81PigsrYFc5AQG6Dd6u/Fal6Fo+8?=
 =?us-ascii?Q?rcDGMPFK8dwR2ADNXpNsP5mY2aOipcbG4Z2Iltf2/3ZgqTmhKmKi9FJHQXLQ?=
 =?us-ascii?Q?Y7QlMFoF17YyBTCnEd8+bcb7lu5Wxv3ycvLaRvT0ZFxyQ0HTN/QoVZ6ibIAl?=
 =?us-ascii?Q?tE84QitinbA9Wl17ujNgIB6LBsqN4YOkD03kc8c99tzcW+Lqk5wYK8Js5xcm?=
 =?us-ascii?Q?jNSIYZxBTOyAEIe+YhEt7Vo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a7676d-b534-4aab-35fb-08db9dd0b3bc
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 20:46:30.1755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mI4Y3sf0g7E1rOwnB33uoOL2a3C1dD6KRShEVTkrxWROaQ12HXsEJxTg2lWug/aDuKkDFr9zCgDrDkGH3CEEyc+384V6wUNXUl4Q8CpUOFxUSis9aQwKHr02JI2SOEWB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6708
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Suzuki,

On Tue, 15 Aug 2023, Suzuki K Poulose wrote:
> On 15/08/2023 07:35, Ilkka Koskinen wrote:
>> Split the 64-bit register accesses if 64-bit access is not supported
>> by the PMU.
>> 
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> Reviewed-by: Besar Wicaksono <bwicaksono@nvidia.com>
>
> Do we need a Fixes tag ?

I believe, NVIDIA's PMU supports 64-bit access while Ampere's one doesn't 
and since this patchset enables support for the latter one, it doesn't 
seem like we need a Fixes tag here.

Cheers, Ilkka

>
> With that:
>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Suzuki
>
>> ---
>>   drivers/perf/arm_cspmu/arm_cspmu.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c 
>> b/drivers/perf/arm_cspmu/arm_cspmu.c
>> index 04be94b4aa48..6387cbad7a7d 100644
>> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
>> @@ -715,7 +715,10 @@ static void arm_cspmu_write_counter(struct perf_event 
>> *event, u64 val)
>>   	if (use_64b_counter_reg(cspmu)) {
>>   		offset = counter_offset(sizeof(u64), event->hw.idx);
>>   -		writeq(val, cspmu->base1 + offset);
>> +		if (cspmu->has_atomic_dword)
>> +			writeq(val, cspmu->base1 + offset);
>> +		else
>> +			lo_hi_writeq(val, cspmu->base1 + offset);
>
>
>>   	} else {
>>   		offset = counter_offset(sizeof(u32), event->hw.idx);
>> 
>
>
