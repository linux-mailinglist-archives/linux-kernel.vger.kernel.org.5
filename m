Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3013C77C5DC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbjHOC2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbjHOC2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:28:04 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBB610C1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 19:28:03 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37F2MK3h031704;
        Mon, 14 Aug 2023 19:27:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=subject:to:cc:references:from:message-id:date:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=4U+MsRmCaZzA5SqlT2cR1Xuqm4tYI8ACAGU6KI0B8gw=; b=
        jBwFvLGAF07EwzNfQihYnzowk+rCyr9oLDCE1EheZvipq8hVPRHHRPmFPs0TvKtl
        et1XLwEMy0yrMqJsPbiu1wgizEsAiL53EXjOXdQx5mk391rbY+u2HtUsBgYbRRpp
        eJ+VAVfuv4gicDx9dwJSy4GxEaDNaua6aQcZt8enqEXRFDOGm/vHSXTtxMvwLqb8
        rTMg3ZeK8ThP0/bGsVJAOcWq2Ll62i+8GMnQV3UR0JAtkoRjRhBEfKehLBLVVNnu
        AceFCkGtQpx8SNAwKSmPlFgtnlmK7KbqTpNrxhS6F3w3F7Fco+CN9OWJxY5/9ycm
        NeiegWhQgZKp2yRaUgv/HQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3se9ket1v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:27:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUDvne7Z1TGLNQF7lcO+3sxp0SiiZT1/DJfU4Ypqgj1zYpm4TzEOS1usYZIbla8ZhEbaYj2x644jXibBF3Tpgq3sSjeyZ+P3hjz6fP7DAt0PbluCuENwQAXHC0Lc72TGSv4JzKAJqmG1swITJoQbAw+7zbU1GMOLo27+4i9hwd7PChotNF3zfNzCx2fuXnqI/YQ0/irDPgXE7tAsHRtA5PKARZWS/5EtynCzbEp9nZ59Q1/vRV+gD2GBDuWCtDT3XFfxU9khBHXwLoc1i2eEQP6n/GM0B1l66/j4ecRm5zF29RlNUOkfP9tWFG6AXrINw5qK3O6UsttF1poYhT7Vdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4U+MsRmCaZzA5SqlT2cR1Xuqm4tYI8ACAGU6KI0B8gw=;
 b=TaE7YeXVuZ0erFwmH0f4boQnzEACrzYG1+/Wxn5i5GqgYNzfiq2Snb76LQWgSS4ycNb/VWGiwJzom8Sh4daxaS2boBjUR5Wyapp8MiX5U118dODcZsGf+29lp4pUpOQgJvHiOnnTn001Ih9zsn9MIv1CMXAWWUXOP3igeVQuJG8g5wCYrJwpLSwhnvCI0xGwnS6o28I2DRoPzK3h3ShEpUf2f7LtoqPRCS4AtBg6vjGYUulyN5lEErUMBmSC61Aozdq82nNsneLtfnYWpv8Na1YAzszoA6sEtFYgk4bjN/R/QGwe8QAnbm6duNrBTEYnYkGzKUmV6dZlGJdlmZ2kCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by DS0PR11MB7263.namprd11.prod.outlook.com (2603:10b6:8:13f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 02:27:25 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 02:27:25 +0000
Subject: Re: [PATCH 2/2] mm/kmemleak: No need to check kmemleak_initialized in
 set_track_prepare()
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, glider@google.com, andreyknvl@gmail.com,
        zhaoyang.huang@unisoc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230810074704.2042664-1-xiaolei.wang@windriver.com>
 <20230810074704.2042664-3-xiaolei.wang@windriver.com>
 <37397d75-c95c-8730-cf22-79e283e0bd6c@suse.cz>
 <79deae0c-eeef-2370-9d8a-b2746389d38c@suse.cz>
 <e401350a-1e23-dae9-97be-fe659665e22d@windriver.com>
 <dbffe403-3419-58b3-cf94-ea4119c1c00d@suse.cz> <ZNpUal2iJZXqpMN3@arm.com>
From:   wangxiaolei <xiaolei.wang@windriver.com>
Message-ID: <87a3f504-c36b-d12c-1951-be5ff154ec70@windriver.com>
Date:   Tue, 15 Aug 2023 10:27:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <ZNpUal2iJZXqpMN3@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|DS0PR11MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: fbaddde0-8c75-4034-6df3-08db9d37297a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muVGfhk9Ae+mQzvjCpknz8sm5tzY85Vg7H/UoV+ijHqRqUg158dYoPjmUs8DgE/LRMHx0+J9EcTmi+y6ZpkphCi2gWJmkV11CVwWj412pWQ0JAjEInV/kKe3zQKNhfsGHi4vdIaFyLtnktn10QNDNQ6DyEPKUZyPXfOV7Vb2d/SoUu4u/NqOHj3gFo8T39mtVTUOvuTR0CvF7YAt53M03ERAxJBV3hwCpsyhIvaaQ8218PMRFCyNFg1SMMilAxWGH6gsr0DfKZEJtTyKsvrZiU+ehO4Y2mw/W+j9wO270Ws6XnAmjC0Jf35zxVyohpIgRYuD5JaXcuHh6ikzymSIwcTQtG9TpskpsG06I/1YkK8YnQv0MvON7+IQybNSNEQOz/eye0s+Rkjlby6y8YqCYFYbNcyEc6Z6uWoMUEKBvvyb2A9p+oopanZScaOKohiUrV9Ozt0ATET+Uf7zR9SghT0U+8+kdT5rsaW9iEBKLzPtae5NSsvSudWJQKJCL47FZj/aA46pa++SIsmh4hjlTDESFOMrmsB9fxsBtOXjcU8M+hh8501IetR7UxRPv4HjDn9bsyaeV0qHMnASX3oyx7auiCyyEmkDRq61+q4qGTyYMBs1e5CYapU2rOTIIhMJ0+wQB8LebtW4kr1FTTKyrnKNnMuOaAlS79K9sHqpr8Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(346002)(396003)(366004)(376002)(136003)(186006)(1800799006)(451199021)(2906002)(316002)(83380400001)(66946007)(66476007)(66556008)(41300700001)(6506007)(6486002)(6666004)(53546011)(478600001)(110136005)(6512007)(26005)(2616005)(86362001)(31696002)(5660300002)(36756003)(8936002)(8676002)(4326008)(38100700002)(31686004)(43062005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVhvalpFdW5Xa2tOb2M5UGNFZlRkeTV4Nm1lYWs3Wm5QazRlQnZ0UHd4aGNz?=
 =?utf-8?B?Wkl1Lzg4dXZucjZIZ2NIMDlwaWpkRTczTmVLZFU2V0FOenRSZ2NBZzVyeWhk?=
 =?utf-8?B?aFRzT3JGU3JZOXhybVVFZjdxTlRyaENpQmtGZ2VSbmtRS1VaNnNPeUM0aGxy?=
 =?utf-8?B?cldKbmd2QzdhTVFrbFQ4SlpTa0hQeVN4SjJQb3BjdnhkUFlVQXdPZGZsWkFr?=
 =?utf-8?B?L1BvbTNiYXg4MnFqbUNrb1hDbTJPZm9wbE9GNm5IcnNvQkduTHo2RktxWHV5?=
 =?utf-8?B?c2tQYVZVT2tsNUp4cjNlT1lQdlUrc29uNk5mbFhKUU44QWVRMklzdkxscVVv?=
 =?utf-8?B?QUYybkcyMDk0MjgxWEdPT3lpSkpmNjZSWU5uMWlDMmZTN3RMRi9yK1FFSDBS?=
 =?utf-8?B?Q1hrWGxtbW5FSisvVUw5TndPNmpQUmRRZHlZZkpINmFtcTB0RG1CZnFyTUhK?=
 =?utf-8?B?WDIvaVVhbWN0TnVRVldObk0yeVVjYzJCdjdaUTJXL0llMHJPV2Y5cU5USjZP?=
 =?utf-8?B?MDZNLzlEYkNUdVpMVUlONG5KdVBGUFp4TzN4K0RadXR0VVNFWXNnOURZSVdB?=
 =?utf-8?B?dGd2a1dRMDRqL1E2bnB6dEtrek9Eb1hFUjBLT0VDQ2g1YmF5bzdweTJSaHFv?=
 =?utf-8?B?VlprWnpocUdFeWJHVldRRURmaDAyNFg1U2lyWnQ3NFM1aHJzYTF1WXM3Ry9W?=
 =?utf-8?B?cll6aGp4WDhRNWRlMXMrdk1qY2tPREhjTDhxM2FSWHZDbTRuWThtUjgyZEl5?=
 =?utf-8?B?OU41MjFzd0ZweUZHdFF6WmsvSGV3WWNLV2hOWUQvSlJ0WFp4N3hqczMzSS9x?=
 =?utf-8?B?Z2JFTGRTSGxJNFh4ejlMQldqb1JZZXoyQTFoZU5YYjU2aDRTV3BJK25VUnBu?=
 =?utf-8?B?ZnBmVUxEeTkvQUlRdVMvSk1IU2U4T1JuL2FtL0M2dDZPR1l0Qy9RV2JYT0dr?=
 =?utf-8?B?elVUbmV5bVdVSzBEM0NuRnlnOGpCeG80alBEaTNkWWxtcjFTRnJtUllJU01Y?=
 =?utf-8?B?eVBKeDErSWZmNm5Gb0dHcnl5aEs1VTREV3JVUWE2MzNRVUcvd2VVQjllZ3N6?=
 =?utf-8?B?eUFsdU1Ndm8zWFA1SDhJcnhNN3pkb0FrUUVYUlZEZW0zdmZpZ3BWbzRweTFP?=
 =?utf-8?B?dlIrdjZ6OHF1L0tUUTlaSFVFU29qU0tMa213MWlla0xjOERjMnJna3dYc05m?=
 =?utf-8?B?STZTVWNQZld5QjQ3Y0xSd1FQMWxuQlZneUY3SmlnMlV2dDczM085bVhQSENa?=
 =?utf-8?B?UXV3TFNPUDhSVVlJaFVySkpaczhtanE4NWZpQ3hpcVU3WG9EdnVFVXdFU0tu?=
 =?utf-8?B?MHdSNnVvOHB6UVdzSnJCTVhoUnF6Ym1TV0pBUERUS2ZFOCt4cWVVUTdVVTRU?=
 =?utf-8?B?K25DL3ZKK2U2OXc0M2tvcVBuUGNxOG9LM1RrWkt4WXo5RHk3UEVheEE0MDNp?=
 =?utf-8?B?dEhwQXUySzFjNmdNZkdka0JYejNmelFBbG5VMEd2M3pqTkkreTJpVjVRUUpY?=
 =?utf-8?B?QmUxOGY0RUk5V0Z3WlVzMGdmU2duUndrSTJnOGpwcS81TmFjOGlWL3pYRFMr?=
 =?utf-8?B?blJ0MkR3UGVoSWY5ZFFqNlJFTkREZk1TZmF0a0ZaTXc5VG5uUm11UUR0bW0v?=
 =?utf-8?B?Yk5zMEUzUE1RRjlDZ0YyM1ozMXMzUzNOVE5pSnN0Y2wzUXREdTV1ZVRlT1hr?=
 =?utf-8?B?cmJ2TXFTUzZNOFR5cHY4UEo5aWhNZjFubEZ5VXpFdHZLMHJKb2Fwb2NUVDB5?=
 =?utf-8?B?eFhzR3M2YTFTVDAwaDl4dklyVjh4RERYQTRmODhhSnExOEZPOGVqVnNDVTRU?=
 =?utf-8?B?bXUzM2ZxL3lqM2Fva1VRWHR3enQ2Rk5aOHRCVDZXZzhHdDBFbUh0UUp3RDlK?=
 =?utf-8?B?blRsNDk3S3RpYzZ3VjBMUTlQemJzakFmZVFCQXpDdGxPVk5Ka29qaEhBRXU5?=
 =?utf-8?B?QUpnL0lINlI1SnBHZW9Xazdrc3FVZW5nZGpISmxxL0R6RGxoQitSLzVFRlZH?=
 =?utf-8?B?bkNBcXdRaTlkUzdmMERrZVN1YmNrVlV2UTVRQVE2Uk5SeldlSVlNTk1OeVFu?=
 =?utf-8?B?RUx1QktWVTVDQ1RUd0U4TVhVRkE4RExUVkh2WnFtRnArU0JPeU84cU80bEps?=
 =?utf-8?B?UUR4SktFejk0QjJLa2R0MmNzczFmWmlmV3BxRWNRRTZFRG04OHdvYW1DVHdK?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbaddde0-8c75-4034-6df3-08db9d37297a
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 02:27:25.0061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7M1J0ZNGsgVq9VQWG4yZ8duQXrsCZPLwg4bv//ONK0stvkcPmRj8emZBPOsqcqflIalfGv4BSrA1b4yMhJKCgdgVOMzLpCtkaw4iQeLGJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7263
X-Proofpoint-GUID: iTznzClPls8600eZ8YeTxdps0S5I5kRi
X-Proofpoint-ORIG-GUID: iTznzClPls8600eZ8YeTxdps0S5I5kRi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_01,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=897 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308150020
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/15/23 12:20 AM, Catalin Marinas wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Fri, Aug 11, 2023 at 10:09:08AM +0200, Vlastimil Babka wrote:
>> On 8/11/23 04:03, wang xiaolei wrote:
>>> On 8/10/23 9:16 PM, Vlastimil Babka wrote:
>>>> Looking closer, I think what you want could be achieved by kmemleak_init()
>>>> setting a variable that is checked in kmemleak_initialized() instead of the
>>>> kmemleak_initialized that's set too late.
>>>>
>>>> I think this should work because:
>>>> - I assume kmemleak can't record anything before kmemleak_init()
>>>> - stack depot early init is requested one way or the other
>>>> - mm_core_init() calls stack_depot_early_init() before kmemleak_init()
>>>>
>>>> But I also wonder how kmemleak can even reach set_track_prepare() before
>>>> kmemleak_init(), maybe that's the issue?
>>> Before kmemleak_init, many places also need to allocate kmemleak_object,
>>>
>>> and also need to save stack in advance, but kmemleak_object is allocated
>>>
>>> in the form of an array, after kmemleak_init 'object_cache =
>>> KMEM_CACHE(kmemleak_object, SLAB_NOLEAKTRACE);'
>> Hm I see, kmemleak has this static mempool so it really can record some
>> objects very early.
> Indeed, otherwise we'd get a lot of false positives.
>
>>> I think there is still some memory not recorded on the backtrace before
>>>
>>> stack_depot_early_init(), does anyone have a better suggestion?
>> No we can't record the backtrace earlier. But I don't think it's a problem
>> in practice. AFAIU kmemleak needs to record these very early allocations so
>> if they point to further objects, those are not suspected as orphans. But
>> the early allocations themselves also are very unlikely to be leaks, so does
>> it really matter that we don't have a backtrace for their allocation?
>> Because the backtrace is the only thing that's missing - the object is
>> otherwise recorded even if set_track_prepare() returns 0.
> It's not a functional problem, just a reporting one. There are
> rare early leaks (usually false positives) so identifying them would
> help. That said, I think set_track_prepare() is too conservative in
> waiting for kmemleak_initialized to be set in kmemleak_late_init().
> That's a late_initcall() meant for the scanning thread etc. not the core
> kmemleak functionality (which is on from early boot).
>
> We can instead use a different variable to check in set_track_prepare(),
> e.g. object_cache. stack_depot_early_init() is called prior to
> kmemleak_init(), so it should be fine.
>
> If "kmemleak_initialized" is confusing, we could rename it to
> "kmemleak_late_initialized" or "kmemleak_fully_initialized". I'm not too
> fussed about this as long as we add some comment on why we check
> object_cache instead of kmemleak_initialized.

Ok, I will send v2 version, use object_cache instead of kmemleak_initialized

to check in set_track_prepare, and update kmemleak_initialized to 
kmemleak_late_initialized

thanks

xiaolei

>
> --
> Catalin
