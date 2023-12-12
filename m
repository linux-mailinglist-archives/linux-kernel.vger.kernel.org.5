Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB9980E342
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 05:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjLLES7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 23:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLLES6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 23:18:58 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E40094;
        Mon, 11 Dec 2023 20:19:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dafd0DpWrjrThulRP7kdzAXGePPrVYjjUtHgzYsFtYGIgwhsP4ITw8THKQ6NaC0lbWc+JNZv5EbaftYAlhXCzU0ON7ZGvHMP9H90hHIFIqpqdirdB0XNv45gy1YHAqMi8+ujo1iaU5vtrBi5kC0Dr7LbxLjT2PrqsPunbPGSiUd9n1c5y4RGSDDXRTQbo/5sNVyurKxS+yroOLQsAUxZTNkVGiJDPK+oLCKC+tCej5Jhxp7Fk8mv5td3ccFHjv1c7hz30jL4MqIJ+veLZFL2B2huj2uvq0358xDExTor5pRsNwD9p271tIm77rDDcKbNahvBJ3UHsoEO1Ykg0qEr3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5Gb83GnOQsWDcA477snbXRNV9mDykuISnnQaeHjgY0=;
 b=j+d2oVfwkU1N52lMaGHYuHscEEZcp3UUGfuY7TOm8tRpcKNs0cuOHhQlsT4alNKBFttjtNOe+jAvfLCvMRXU37ZY735cVJxCQCKNDLXMcTTsPDQa42Jabj8P2JBDtKTU/4jiezakKPTrINGV2jzTLlWb/ARZ5J4iY6X3/xf8rP4hM+HmfqCnGJaP05tHaa6z+Gth+ALEXYrmze3IklGxJLk1wU8ueIvKMFJunktIU/hwFs/6MattzZfbLkTVankVT0wpA1Xx5bluzvXs3yFZy5h9iHtk4oHHpDae/U8KUxSVlG7e4HbXPgVgtz1UG5m9Eiu0nFLsjTJLvf6pDjzopw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5Gb83GnOQsWDcA477snbXRNV9mDykuISnnQaeHjgY0=;
 b=AwzwyX8Fl3Xo90IZSG+Yc7EMwyyLiX6ebm9p5tDKCTQEdqoFBUuWpe7nR537ihgbEVgX12bbjJvAgERSHVTJ9MsUFOveI1EgOqQ8VP6nvcwFQ3t3oLzaOALwt+Zo6WMzDiupXD46Bvq1as0OJDDAn0yAvdCpPJxTxs3p3TdTBo8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 04:19:01 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::cd68:8823:38b3:65bc]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::cd68:8823:38b3:65bc%3]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 04:19:01 +0000
Message-ID: <15bf097a-1863-ce32-cac7-d91df3c73215@amd.com>
Date:   Tue, 12 Dec 2023 09:48:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] perf tool AMD: Use non-precise cycles as default
 event on certain Zen2 processors
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     acme@kernel.org, kim.phillips@amd.com, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, changbin.du@huawei.com,
        yangjihong1@huawei.com, zwisler@chromium.org,
        wangming01@loongson.cn, chenhuacai@kernel.org,
        kprateek.nayak@amd.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20231107083331.901-1-ravi.bangoria@amd.com>
 <CAM9d7cgs9Wk0OFoea4jOote-drHjvCimJyt7GWdO2Giw=d7Jog@mail.gmail.com>
 <f42bf6b7-75b8-124b-c79e-ad7a9b706990@amd.com>
 <CAM9d7cijrZzp=5m+BcQ77WFOSHT7e5vO-RCUTUp5Pevmz2wbtg@mail.gmail.com>
 <53374e41-d1e0-aa8f-d001-5e89783b962c@amd.com>
 <CAM9d7cgNsXVpFDsUt01TwxF3B=7G9TWZWoNU2dP_RGtQdQAJPQ@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7cgNsXVpFDsUt01TwxF3B=7G9TWZWoNU2dP_RGtQdQAJPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0191.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::15) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf97bab-3b24-4cca-ce99-08dbfac977f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zqj86Z7Cg7KnDaYjCw6neHO02gp1yr5xs1/W2XxM1Q8sgPK4FNFDrTK+jHk1kt+Ly6EjbZzzga31mklTIknfgtlvNM4lkbbXg+kNneUKKMEDLNRxOSmPF/7tzdLANjpzk5l3Qj3SxyiaOdLVKfMFr8kdlfYiBgVaf78oD4Z9/X/gujTECc0qTaLrY5w/A9atjdcY/wmckfZcudLlmUt+78v0FPBs19UkVq3rABb+wel9jMU3789I1/z2V4HR8yF/8FRXbXbUKJDM+ctlKu+6O+8WU5H/BTbIwf8zrEhKQtjv9XjKh/N5rWx1h+LY1gdLYHWv/KhIL9/mSEfoPrY1IX9CcSpnqCCAJM46ZP46Bbyt+WrBcmM75dbL/h6TRstI8V8gtezo7OtzEYne14D6JmYTDqPGrojs83cmxxqjAUWn2+fbuhj5GvO/r+NB3ri62TAZR61HLILsz68QEixfjLbNLQ+MqHTr1FW6cG57CwmWciCfOdZT8KoAWabtd3UjuQozxyGiMY+9x2HRg/v5zO280foJmRMT3eZUSAQz9eO/1205fyTfNAQmju/yCWZ4O3LJoPASr7gsyFeN+UXCLq0UV5npbfZfvl8GlXuQVdS0QAzyQkXNK7V4ifa3HWxOINZudg5JrL9H7K+uPc6YZ2wSKGA3SDZVHeW0Vf+0/QQcDtV6jiqQ7+0BfHZ/dcSe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(230173577357003)(230922051799003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(31686004)(2906002)(44832011)(4326008)(6512007)(6506007)(6666004)(8676002)(8936002)(6916009)(5660300002)(7416002)(316002)(36756003)(6486002)(66946007)(2616005)(26005)(478600001)(66556008)(66476007)(86362001)(31696002)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGVuQTlXMngzbzhSQnd6QWdWdDhBZ2pSbXpXeFE0ZXdLRzFkM2hNdTJjS0hv?=
 =?utf-8?B?TmkxUkpLbytxTXVNR1BDbkFpT095c1RrRU9NSnZqVXcvallHdVpndEZ3dVh6?=
 =?utf-8?B?OTVTU3dIWVRWek1pVEMxb1E2VTJ6YVF5SDVQVXFVLzhzcGNmdUZwZjZTeHdO?=
 =?utf-8?B?bExLaW9BWmtiY0VMbER1VmtSb0VxcGg2Nkh1RWNwVmY2a1Q4NDA5M0xBS016?=
 =?utf-8?B?OG42d2dNNFBsaTczaVpSeUlEcGg3SlkxT1JFUVlVbFloNCtsbEptM2xBZElw?=
 =?utf-8?B?RmZLUU8yZ2l1eVAwMWpkMlpIMk9wTHBBYkZLd2lCRVVMWVVkeHNWTzVPb3Iv?=
 =?utf-8?B?b2ZrT1cxOWlJZm1OUzhJMVpCV0U4THlBOFEzRXJmV0lRbjJVZklQdVZSV3dw?=
 =?utf-8?B?UHdtaGJrMER6dnpxNFplQ09hUkxUMXJEbGsyT1RHNDNsTnFBRlY0QjA2andi?=
 =?utf-8?B?MGFaajVrMXZ5bFVDZXU2azUxdk5KeTVKTm1Lb3k3MGNISG5qcW4zeG0wV2ll?=
 =?utf-8?B?dmV6RTlYWW42d0xaa214aEwrUmhTL2kwY1ZoVVBFaU5XVDlXTlUvYXlNZE4z?=
 =?utf-8?B?ZUdBMm5GdWRGOVJkTVJBbXRvQzNsaHFVN3hUdVdQZGE3Yy91aitpbkhXUFRX?=
 =?utf-8?B?aVF4cTEvbXd4dExKUThOVUhhWXg3U29ZSnd1WXNFbmM4dHl2WTJEMzRwOWNQ?=
 =?utf-8?B?bCtnR2tXWkk3d3FIVXJoOCtSLzlMZ1ExRXRrY3B2T3libFU5RmFxblcxbWVL?=
 =?utf-8?B?NWlRbFVKQ3hyNU82RVhPZnZVaXRaNWdIc2JMSmJpS1JoMjZmeU9HaDBzbzJE?=
 =?utf-8?B?bjhTbWh5M2hPeWgwMHFBdFRUZkg5K1BBbm1ZVUlpZVhEczAwUklPTDgzNUxu?=
 =?utf-8?B?T2pwei96eHVCYXRzMmhnZmlpcm1zdDB6ZE9qNVhhdzhhT3ZLcDdpK1pabkhD?=
 =?utf-8?B?Y01NRVdxYlNEMFZUY09uV0hpcFdCSUhmT0xucE11MFRET1BxT05wK0FDOGZB?=
 =?utf-8?B?STZMaThqczhXT0dxR3dyUWgvUDY2djBnTkdMeFlHdUtMYjUvbXBlVXZFcUV5?=
 =?utf-8?B?SWs4bFVJR0xMa2NhZ25iUCtlSDAxcXRybnJVNWNKa3VvdmQ4OXpMWGRod2Zq?=
 =?utf-8?B?QXlubE1QUlhGbGkwUjhVblZjdzQ1WFdObU51a09KN1YzSk81MzJ5MUsxRWg5?=
 =?utf-8?B?RkY3eHBlY1BjdEwzSHhReFhvZTRRdlJPREdzK1hvalppWjJCR0ptRGozSFoy?=
 =?utf-8?B?R21Qc0I3dkREME5pREt3YVhGeHFzVlFXUWVKK3lraWJtR09kQmtzWU9wSXht?=
 =?utf-8?B?WFZGdzZFL0hDNVp4YTRFQVI2eUdqUEtNSm1JUkhmTlVlRWF3QXprckVmcXRK?=
 =?utf-8?B?bkEwbXFHK3dWTGdSUjNOaHJTSkhyT2ZWZDU3aXVYejJxNFZHZVZ2Qk1jcksx?=
 =?utf-8?B?TUkrL1ZYU0s4UU9kNWE5TUhmS3ZieThGMURSSUFTQituaEd2UnZwdmdMZjI3?=
 =?utf-8?B?TWNYNWVHOXVnRmZsZUJGYmZqWGpmUU5HT3NNclR0SzI3Qm91TzVzZTkyeVk4?=
 =?utf-8?B?cDN3OXVpOXlmamVoTlZxYTB5RTJPK01hb3dCa1hkRm00dVJSUUhrTU5kbkw0?=
 =?utf-8?B?Q2NzN2cvRmswQU1zNE4rbXJsbEFaZ2VmdkUwcHA1NHVQY1JNTU5haVNjbnVw?=
 =?utf-8?B?QzNXWkVlZXo5MVg0SFFsVW9OQzJNeVFOclltaVlGNjYzbERyMkVMT1JUa2dn?=
 =?utf-8?B?YXZ3V0U5MURwQy8yZi9LWTRSamZGNjBOam9jbytQVXZGNExzNHJkT2Vmb1Vs?=
 =?utf-8?B?dzRGZFZOTTR3ZFNTbHBzRWtURUpEVndObjZiZUJBTlQ5SEl5TkJJUW1BLzl2?=
 =?utf-8?B?TlNpMlZiY0k2Rk9KRTNWMENvVWc3NkFlQTFsakZLUm5NUGdVVzRHdXZnUjhJ?=
 =?utf-8?B?dSt2end4VnFnZTVKYTE4U3NKeTN4UHM2SWROS0oyQXdWOU1mMDI4dXlSQklp?=
 =?utf-8?B?YzVPK3B6dUZIaGVJUDNFcGQzdjhBU0pxWWV0TUgyTUNoT1JoMStUVXgzWk9w?=
 =?utf-8?B?cVBVeVF3ak93clN4REhKMXY2ekgzUmRtalpVekluV2VGYXlvQ2xxcC9PRXNV?=
 =?utf-8?Q?sXYVoO4LLdDhAt05zr77w38QD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf97bab-3b24-4cca-ce99-08dbfac977f0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 04:19:01.4075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVT2rGy90xnjSQ9kodyQ5cnu9UMT+2yJRDtXR1XuiTE6WPbPAk/LN9Y1ys0XOWgJU5XVNuWIaWxTG4W7LjnW4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>>> By default, Perf uses precise cycles event when no explicit event is
>>>>>> specified by user. Precise cycles event is forwarded to ibs_op// pmu
>>>>>> on AMD. However, IBS has hw issue on certain Zen2 processors where
>>>>>> it might raise NMI without sample_valid bit set, which causes Unknown
>>>>>> NMI warnings. (Erratum #1215: IBS (Instruction Based Sampling) Counter
>>>>>> Valid Value May be Incorrect After Exit From Core C6 (CC6) State.) So,
>>>>>> use non-precise cycles as default event on affected processors.
>>>>>
>>>>> It seems like a kernel issue, do we have a kernel patch not to forward
>>>>> precise cycles or instructions events to IBS on the affected CPUs?
>>>>
>>>> I'm not sure how it's a kernel issue. User can use ibs_op// pmu directly
>>>> and might hit the hw bug.
>>>
>>> Sorry for the late reply.  I know it's the user's fault when using ibs_op//
>>> directly but I think the kernel should not forward cycles:pp to IBS.
>>
>> For all AMD zen uarchs, cycles:p is same as ibs_op// (man perf-list has
>> more detail). It's confusing if ibs_op// works but cycles:p fails on the
>> same machine.
> 
> Make sense.  Probably perf tools can provide a more detailed message
> about the situation.

+1

>> No strong opinion though. I can prepare a kernel patch, if you want.
> 
> I have a report that these unknown NMI messages caused some
> performance issues.  So maybe we need to be safe by not using
> IBS automatically.  I've also posted a patch to rate-limit the message
> itself.

Sure. Will prepare and post the patch.

Thanks,
Ravi
