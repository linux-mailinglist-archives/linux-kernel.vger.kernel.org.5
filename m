Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727CD7518AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjGMGO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjGMGOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:14:55 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3451BF6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:14:54 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CMvZhM029573;
        Wed, 12 Jul 2023 23:14:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=sWvV7enxEms3lnihEgDDPRSUES5Ft88bJqzJvyKHSBc=;
 b=h2C01TFm6eSj0bxKRGvWCm0fY89tTfai5dumqiEgp4lWXnTZ1r2OwUBXk61tlffKnB+v
 /B48JSIPabuNn3guAhUhLZ4PVjfXYyOJYCDxWQZbNlqs6bm5SqeErOnjNYwTv3zIvFV8
 WEkuMBCdw+Xk1FkX0wpt3AQ/2+XnGP57VGjFZnDH/gFwJBZnvV9Lz70JfPjFT8gEvEe1
 k3ZXpnscOezQSU0cyA3idBr1rgHxbZo41PLwazy+WvQ86dQ4OHUCUxwbptfheb08Ox3m
 Mzr3bdT7onRxE8dRb3/qcHyPo1ojRn/jAu60ItwFjyxyqUvv3sSF4163SlYktdjt5Vzq eA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rt1awc00u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 23:14:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKfgw/HZdoK+IYYGd1005jZ2NpXiPYSBpQmTRvQIBS6CVsGdw5esKB6roPHBLw4OYbDx6TNx0YsTbKjNPYh3C8U2kW2U2/ZNAsFxCqcRo8Do1jBT4ns6GWNFZI6DN6ctUM1E1UzgBypx6tJ75dzT1FtfTJ/awyd8DtGxnpQIx2lZblgjNU0aYZZMdBmA2mq8ScOxS6yF7/Cnsf8N0atpkOj1GlwQCBsSmav0CDVmmIspHyfbI+bfo4y6+j8qTSqFPsPnUjAgS66wdXlHg7fxQu/vKdCa6t7NXoyLmShR6KXflK3ZXApsv4mZOkrLY+Mv1CnzkfhgbxL/cl8lH8h0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWvV7enxEms3lnihEgDDPRSUES5Ft88bJqzJvyKHSBc=;
 b=L6sGPlWVATrwGmmBA5/L3a9lrVUx0bOL1InQWY7MxmtHBZssMkDn//XewEM9RClvbfI0BgchxDnUYLewSusxVlf+0SrzNLnL79x3pv3UoMJIB5CqOyygJRI/fBcgCBFl/dv2bWURQEyTm5Lhfmw5QNZc3gKXfqoLHz3/Cx6NBrknuIpzY64+j1G1/ef/fGoEmgozNcdrNXcdqh5lGgA0LK2tKO/RlrdQ/YxqD6sA6wFQ5z8vR+1Pi5q/5ykBTXT+A2uDxWibDerJuETy1jcQsnGBJ44JuOT0hezS6DkLw4VTV+sc1xMHmLOLG/lqtk/TNWP7YnjW9Ij54UYrQOVbzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DS0PR15MB6208.namprd15.prod.outlook.com (2603:10b6:8:160::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.33; Thu, 13 Jul
 2023 06:14:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1757:f075:376:8ff1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1757:f075:376:8ff1%4]) with mapi id 15.20.6565.034; Thu, 13 Jul 2023
 06:14:24 +0000
Message-ID: <a743d8e1-0460-775c-2a21-54a891d6a973@meta.com>
Date:   Wed, 12 Jul 2023 23:14:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] kallsyms: strip LTO-only suffixes from promoted global
 functions
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Petr Mladek <pmladek@suse.com>, Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yonghong Song <yhs@fb.com>
Cc:     Fangrui Song <maskray@google.com>, kernel-team@fb.com,
        Leizhen <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230628181926.4102448-1-yhs@fb.com>
 <168920160691.3781136.7715367614867053724.b4-ty@chromium.org>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <168920160691.3781136.7715367614867053724.b4-ty@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DS0PR15MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f9edb1b-74b9-45a3-c6e2-08db83686791
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LGs7gv/KFAp5/WSKL7ddnn3UuHK0djjVSgZSQfsdYJ5Lgd9d4OwdWB/FO8NUPkKsGpFHWnO2bMJrrKcbdRf8mDkE+eQAtTJup4K7uxbh9XIsMA/Q+OQB00a6Uk7j6oMLbVBROQfkq9iDkWUey5k2jDhZ0jcH5XU1UxK43zCMl42CslQQKpSLdxezlZP7e6jwI1W2QTREpfmNAk8AwnCJSQ3MFVjLVknbj9cpkeHVuOQX3SzYSefyT3GJCpUsZlF3gofuMyRM4Pa5DAF8EBgF0rL8YI1vdJp5As9zgXV7awFp5OnGErZ7ewbhaIWzXRl0wabuAY7iUYvBwQnbDypDfEAM+SmfxFotucJkrcQExhnhlStLjd5O+27/ghinAVZa50cnRBuQXm968gO0/EkwJ8owgMXBBPY2NNlJU4sRZw9L7O6VRvOCe/lErMbwYH5Kb5AWuzAS5Mz01Ie3Vf5pXYNP7uVj2ktQghL0/Fq61NW8MiAKtEVjOvl0gCjR0n3cP8qClbNSHTJ2m7iVwPD0qcX9bGpp9+rEkbEU/CFCamOdjm79G7n6jDaDO6DuJn8OB8PoTurzLWQi6LMVmi4NOG5bODDba6/6MeKWcSS95E7a8avCR8Gs6XlGdwCK72uR0t02NDRXgkeKeinNG8a3eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199021)(41300700001)(2616005)(8676002)(8936002)(4326008)(966005)(38100700002)(6506007)(53546011)(316002)(66556008)(66476007)(5660300002)(6512007)(478600001)(86362001)(6486002)(6666004)(66946007)(31696002)(110136005)(186003)(36756003)(2906002)(54906003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnNVczE2bS9IeDJua3RWaFIvZUFwUDZXeFlWeG1XNStLWFB6ZmNCRDA5elA5?=
 =?utf-8?B?Y1o2cXMyVmNob0ZWS3BicVp5RGJXeHh0ZjY2UFRpY29mMm41MlV6QSs0Q0FW?=
 =?utf-8?B?TjlDVnl5TWlYdW1jR1I5eU5QaUJ1R2FaUmJ2K3g1UkhmekVrNnk1RlpDQXJ6?=
 =?utf-8?B?T3NncjNvYnJvV3QweE9yZ2lJc0V0YWpydDk0eUM1dUFMbFB4cHdJTmQ3aW9E?=
 =?utf-8?B?ai9JL2NjeHBBamhjZW9EWUptK1l0REl5eHlWc25yVnlUV3l6dUUxMlZ0eFZE?=
 =?utf-8?B?SVk4a2NWT1E4K1F4eVo4NmM0QXlQTHB3K2FRMWVZK1JsejZDSU9scXJ5TE5N?=
 =?utf-8?B?UjI0RFVrU0ZLTnZxR3ZjNzlkcGtUWUNhWEsvNXBwYnM5QnhGNi9naEdtd0Fx?=
 =?utf-8?B?cUJ6SU1VUWVtaldQRzNtNFhrYnFlOEhEMFBTK2tRelB1R2REeEJlbGxNck11?=
 =?utf-8?B?TjlaQmpBTERCZU9nbC8xK0wzTi82RUZQUFFheDIrTlVpVHB4NzFwYjhsa0ll?=
 =?utf-8?B?VEoxQ0xFOUVGVXd4ZHk2a1RvTWVyblN6V1ZIdUs2d0w2U0p2N29MUVFOSStq?=
 =?utf-8?B?ZC83NXBVRm1janN3UGZaVU8wM1U4RDgwVklOem5xMFFvOWdDYU50bU53UnNw?=
 =?utf-8?B?ODgvVU1jUHp3NEs4VFQwQ0FzbmZra09UZytpNmhHalptNGY4UnYxSE13RzRn?=
 =?utf-8?B?NnZlUFYzdUtaQko1THg5Y3h4SlJvaG4vVDV1L2lYR3ZrNXNINDF1M0pkN2Rq?=
 =?utf-8?B?WDlZSlRTRU4wcTZqaEo2ekNBcUFTRktmTnBwT0VvVFlQTmpuS04zZ1dzd0xq?=
 =?utf-8?B?a0NhWURFY2cyOGZiRFIvdEt2dHgwVkdmU01LREZYUldEUzNoM3A3UTluSUp6?=
 =?utf-8?B?WEtSUE1WMERkSktSNWg2WDhZTmZ3VXhMTEwxNnlCNXN0LzZGb1V0VGZSdWVS?=
 =?utf-8?B?cVpkVHVhNjdqRzZnSGs1RVZJRUd6NDI1NUttSFJhTDcxQTc0eTkwdHpGZ2Rm?=
 =?utf-8?B?L05pUnpYUlhXQ2VRcjNuTW5TR3NQOHh6OVVBWHE5QWgyckZ0ZkZPYW4vUUdY?=
 =?utf-8?B?QTdpYnNZU3R2a0t6enQ2cWhWcnNzajJ6UExTTWxGNk1sWjUwR2JOcXRIb1Vp?=
 =?utf-8?B?MllrYzlwWDUzSGxRY0VLa0w0UTNmVFlFbzc4ZEVMTi95QkdFQ2tNbEZnR1pY?=
 =?utf-8?B?OW1LSXpPcjBoSHRzeHpOcFZkdlJuaW13Z1JkTFVOdGRFK2oxaUNiNXkyZWE2?=
 =?utf-8?B?WkxqaDFEQklYWG9nUHNxVGZMeFp1K1ZVSXRMY0ZpbmNWYkh1eFZXZXFrN1lj?=
 =?utf-8?B?R3d5YVZGRTNjUWdUalAyb1VLbmNPclZ5OHRWN2ZUdGRGTVptTlhuQ2dFUXdL?=
 =?utf-8?B?dk5ad0RlWFlTVTdDWXYrVWlMc3plRldOUHJJSFFjN1cya1NaRjFLdU42Vis3?=
 =?utf-8?B?WnhCZ1pZWWtzZllqWEcyQUlhQkxCbnNFSGJYRVhhYTBIYmI0Y0E4T2doK05x?=
 =?utf-8?B?UTk3bHVmL2o2bTN3M3pDNk81bGJVcitqZXhRaHhtWFhtTkRicWNOaCt1Z0t0?=
 =?utf-8?B?ZEpFR2t1SmQ3ZzJBUVNmMWJ3dysyYjl3OUR2QWJiQUxFenhvUW5Zem1aZkwz?=
 =?utf-8?B?cDA0VDcrM0dSRWxiUWg1THhQVlRscFdFUEp6SXhyOXgvTEFRRncydE1ENzJk?=
 =?utf-8?B?MlFBSkFMZnlJOE5YSC9uNWFaRFB1WXk0aEo4dlJiVFJkU01OQkY3T2h6aE5Y?=
 =?utf-8?B?SjVVNUk5TzhOVUdzRm51RGpuUTBmMVMxV1EybE9wTjk2NlBidE0zdjhTWjh1?=
 =?utf-8?B?TlhEOE1iVHhkc1FpUkFhOEhJUmpOSDI1YVNTYno5c3F3aDV6ckRhcFp0TThm?=
 =?utf-8?B?amxwZkRBdFoweXo3SXU5MkhtWGN0eHBXbTFORkZnN05ma0d2UytTUHN4STlM?=
 =?utf-8?B?OFdpZDFSYWlraGxuczM3ZVp3alFDS3NhZXdHY0p6eFdCTVBHRWRKc1hKcjFI?=
 =?utf-8?B?RXl6N0VhS0J0NVFRRklhQzJKSzFpZDRlajR2NWh6R0E5S1ZkVFc2Uzd1QjBU?=
 =?utf-8?B?Mm1vWFlkd2hkZkUzazNjdDVYSFFPVW83NVZwQk9VajJCTHBNaUZpWGo2STAw?=
 =?utf-8?B?T0RHN3BjRi9qREZCTHFSUmNGdVYzQTZBdjVxVGpnbjdxZVhPcFBtU0RYUVpx?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9edb1b-74b9-45a3-c6e2-08db83686791
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 06:14:24.2272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oY2UKxcpUA0S8pDwgr73RQVIaDmKEC50dkBYRtAYW14U+vaitLgAJEmb0UL2dAi+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6208
X-Proofpoint-GUID: A_QONaASzyEv4YKDO8OYWwy9HcnpYEET
X-Proofpoint-ORIG-GUID: A_QONaASzyEv4YKDO8OYWwy9HcnpYEET
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_02,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/23 3:40 PM, Kees Cook wrote:
> 
> On Wed, 28 Jun 2023 11:19:26 -0700, Yonghong Song wrote:
>> Commit 6eb4bd92c1ce ("kallsyms: strip LTO suffixes from static functions")
>> stripped all function/variable suffixes started with '.' regardless
>> of whether those suffixes are generated at LTO mode or not. In fact,
>> as far as I know, in LTO mode, when a static function/variable is
>> promoted to the global scope, '.llvm.<...>' suffix is added.
>>
>> The existing mechanism breaks live patch for a LTO kernel even if
>> no <symbol>.llvm.<...> symbols are involved. For example, for the following
>> kernel symbols:
>>    $ grep bpf_verifier_vlog /proc/kallsyms
>>    ffffffff81549f60 t bpf_verifier_vlog
>>    ffffffff8268b430 d bpf_verifier_vlog._entry
>>    ffffffff8282a958 d bpf_verifier_vlog._entry_ptr
>>    ffffffff82e12a1f d bpf_verifier_vlog.__already_done
>> 'bpf_verifier_vlog' is a static function. '_entry', '_entry_ptr' and
>> '__already_done' are static variables used inside 'bpf_verifier_vlog',
>> so llvm promotes them to file-level static with prefix 'bpf_verifier_vlog.'.
>> Note that the func-level to file-level static function promotion also
>> happens without LTO.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] kallsyms: strip LTO-only suffixes from promoted global functions
>        https://git.kernel.org/kees/c/8cc32a9bbf29

Thanks Kees!

> 
> Best regards,
