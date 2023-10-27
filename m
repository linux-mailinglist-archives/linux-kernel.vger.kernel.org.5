Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298E57D9A51
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345868AbjJ0NqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJ0NqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:46:05 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736289D;
        Fri, 27 Oct 2023 06:46:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUtLmSuiNAUf8ooty01VbEXRxx5Pd8yI1vUwO1XMZLBbWN4kY0GZ0pfxvED/dvV8NroTTHteQ9csSB618rdbF7QGT856HZ9vUhuuZVcMN9sGmicL9ztyxFKSukOUUkQrlJOPAccGNmO7GuCr6wARY5J94w1zdw0esT/c/o/PFtrGdgODsSf+krHE6B0vHDBNfPyXlFPGrvMLNKI98YVYPW4nQwgigkKjLTtq4C6/SNa1ZzHTopYibxCZGbAxdrD/ff5u5EtjZoMrNDYpMgJ0TWsua61EX8dSf75beXSiR/Pi/6mlaB/YOyIAo2aDVUsqV5EScpqpeoTvyXVpgtSNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkD73iJUcdjF5s7PbqUzlQ4udf+hmQfchnghABx7cEE=;
 b=oLq3jc/Wh+U67kl8CkxXjNuUnjyXGsQqDNSiuc6L9J9qXZgWjrBmyhWzTKESCA0QNymEP/wG6YcUkfPIWgREj+mshkAeekl/AhHTnhkxmzobuG7ZmW8mK+4LmB749xlnwHKkWv591nHJkM7WszDo5EYefxGTxkUNHMcS5CDICh7ciUFym2FHuU2ujN2pPEj7px00eMe59E44gtflmtuicdnsRpRO93y/qdnPY3xg/UwYbhXDjorRS/ZAXZKTrgPcg526WADtSxBY3CErBE2yP3EkRAEIxmt7K24vKO03AH2JLNqdPpkoH5/7qRBoVhXIDVHTA8i+yps/xq+hjhpoVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkD73iJUcdjF5s7PbqUzlQ4udf+hmQfchnghABx7cEE=;
 b=cLtRysLctPRzdn/QwrvaxZeVeypfNtNhMjU1RO0g9IZn7dQpSHser6UYa5f4bRp0kRWkP801h4MH3W7P9MghtLVoTASZMaOVS35iEZjT9YDJpch30DoTTiuegM353CRC5gpU1bgcLxzFduBNFLKcB3A5ZRd9wSzrYjzGLtCoHSO60v/tLMwEs6UkqaJlnZ/SOclrnNdHZ7CpaTzelhwqgVAWMxzTBQu2SeZ6eNgtUCvtCaueg57yGe3enlCBA2Nbguo9+MdJZjB7dq5iPHmR1ZyWifNvx+sWp+n3wsVKT2v8l0tlMXr+5tzjQyaBw4mUaPEjfBOYczApPWwv/P9GoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5726.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:313::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 13:46:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ce06:5d24:9896:669c]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ce06:5d24:9896:669c%6]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 13:46:00 +0000
Message-ID: <110c4e57-adab-4211-9d8f-4603a5e5e756@siemens.com>
Date:   Fri, 27 Oct 2023 15:45:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] arm64: dts: ti: iot2050: Refactor the m.2 and
 minipcie power pin
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
References: <cover.1698413678.git.jan.kiszka@siemens.com>
 <ccac993e604b912bb8472f08f5fd43c528c7973b.1698413678.git.jan.kiszka@siemens.com>
 <20231027134325.qvwe4ocpf36qvmry@prism>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231027134325.qvwe4ocpf36qvmry@prism>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0445.namprd03.prod.outlook.com
 (2603:10b6:610:10e::31) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db1e7b8-de75-4e1d-583b-08dbd6f30db5
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UuOiTOQ/mrH6rtrXJSLrOgOgwzaN2UP9OErmHAA925t6A1uwdY3vfLixHmisaMEDgyJESD2j8W1tym4peUUPkXkHjqY6PjwdHO7SAybZ/4Bl4rwhcgc9kQnvR87Ln83/X/SNYPDh4VsIzpr+3SXC+0V8/tvr4L4uOcMQ26cBTAq4lROq9NRiDyrA1Sb17EHSjTbsYt4ruEfow/UUCfJ1werdGr8QOojkqfKPxrwoh6ogcAYWL1bGhWG2ds7EGjm6DDiyL9TxEi4DBdr87CyQUlg//CZXShZG+NKgiDVqEdt+gqw2aUUXCDVQ5fZD8IkCL/jEyK1Mz6M/CCGp3ERBMnNxGL99WZ8eQcksSdvZukcnXYwlOfS1FVvsMjkdUBXOvK0LpRQJw3qc7XuGPH4AddqnWCpb675a7lh1/ku7TIFU6M92iBsk24cCexdsGinXfo8YGBMeopAQd+oAX4OTR6Bdy6e0QDsaYc184T6lKPknUk6QdJH1JJJtU1v9QoDz8VfjdFmvPfj9kjzJxWeUoZ+X1tvpejwym9MklVGN6uTmVU5dv+XaxRow/Tq1LiG++hOJrVdyYUMoULNcBWArKD66CFTVqzzn817R4oabCwb43wBnVdDUBn452ofcuC0jvqMZ8afcAiz2nVMdBOdGEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(4744005)(107886003)(2906002)(31696002)(38100700002)(5660300002)(478600001)(66476007)(66556008)(66946007)(26005)(6666004)(6916009)(53546011)(6506007)(2616005)(82960400001)(6486002)(6512007)(54906003)(44832011)(4326008)(41300700001)(36756003)(86362001)(8676002)(316002)(8936002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzRMWWRXek9RT2lVMk5qVTFoZmZOYURHRnNvQmpsYllXUjdNMW5iWXFWNlh6?=
 =?utf-8?B?dURiaDNJTG9uSjBRSnJmNXB3RFdsVDdUM09vSGhrT1VicGNJV1ZOZElLcCtq?=
 =?utf-8?B?K2taSHJ4OUtEQVIzbktQUDNQa1hIY1J6eS84STJyUnlGMDhOUTlLZ2d2VWZi?=
 =?utf-8?B?UjJoeWQ0L3NzU1pYMGpGQWprNDNNNmxvRzF1ek1Pc0hQaXFZQjVENG1kaXFV?=
 =?utf-8?B?SFhydlRUY0QyVTA5dW9oVWhselV2cXZtS0p5L1Q3VWErWnp4YWNDZ0hocTRs?=
 =?utf-8?B?WWVmVWowV09KOE44cWZrNXNsb1g5dXhDTEV0L0NPdTJkVmZ0bmFKK0VuN2ZI?=
 =?utf-8?B?dVpEU2RkYmVFaENkYjFTczJ6UmliNElCUDE3a24xMWlYZVBOWE11TXJiUWpw?=
 =?utf-8?B?WVBmWnpTUXNJSVJpVU1KNmkrQ2JuT2t0dXB6NWxEZ0ZEeXNabDZackVGVWxw?=
 =?utf-8?B?Z0Q5UVdLaGRsQVRNNCtaQ3h1RTdORzUzU0d4aG9kZFdReHZoSkk2bXRHclB5?=
 =?utf-8?B?NEFxOEdET2loQ1Z6Y1d4bG1qT2dUYjAwRjVmZzRSYnBjd3JGZzJmTUJPdS94?=
 =?utf-8?B?aEhLbWhmTmlqOFhYZHk5eG5wdDZ0SWZYMVBBYjlWZ21SY3d1a29sc2ZkQ25C?=
 =?utf-8?B?anJEemhQMW5MQ05FZWZzMTQ1dG9NWERqb0dFT1BHY0xkTkViQ2c5ejRuVnhC?=
 =?utf-8?B?NklMek9QclFraTE4T21ReUtITVRLWThsZW91MW5CUTlwZUljKzZQamQ2MVY5?=
 =?utf-8?B?UU45YU8vdXA1NzNLMG9Hb2tJd1d4MHg3Vnlsa2ZUa0xXZlhJK01BTHpnSkJl?=
 =?utf-8?B?OGtCRnkzMjQvakZ0UjZNdU9pWUV6WG1vay9SMjJYUjhmeE9Kc01IdkpLdTlH?=
 =?utf-8?B?YWczMnVEZzNCUWZaU2xEQUFaOExnREx2RjZhMFNmVGpCUXZSZ1YyMEpyTFo1?=
 =?utf-8?B?ellKNklhNkswU1lJdjNmR09DZktHa005cTdZc1RrOVp5aDhGSkhQeWRmQ2VM?=
 =?utf-8?B?cnpvdU5pRlV2aCs3dmI5d3I1WjhCTCtZNmV5TFozOXVRVm01MEV4ZzJmaFBZ?=
 =?utf-8?B?akFsbVp5bXlxbkhiT1lKK3lQWmVJcUtuRXhEQ3djUVdsV2t5djBqV210eklW?=
 =?utf-8?B?dWF1ZW4zQkFSbHJqTVBsZ3RKYXRqcUhyVElwYWRlSUpSaFhTOHhOcURHancx?=
 =?utf-8?B?dlpmVzJHQXU5ODVWYjJibGRqOGVFcWtBRW5UTUJiRjJXYlFTS3JOcXNJektz?=
 =?utf-8?B?ZFFRTVFpTmlXRjR4LzdUN1JsOHFLNUhwanlBZDBVRmhlTzZMdlBlK0lpNGtv?=
 =?utf-8?B?RnFQb1JmMzJFcG9SemUzaFhTZmNkNkk2NFNJVEg3cWhlbFFMZ1IyTFVJSy9E?=
 =?utf-8?B?Ty9WcjVRSzVJRGc0c0NsSCswKzFlNUJDeHA0TnJOWVpJUk02WkRpdFA1U0JN?=
 =?utf-8?B?UXFhTDNIQkhvQVFaVW1pS0l6dGlid3VSK1JDZ3FoTUlqQlFpYi83T1NvTjNR?=
 =?utf-8?B?dDkzYTJ0MjROblBGeUxhU25GZW9BRnJXZjM1QnRabVZQamhDeVRodHcyYkxB?=
 =?utf-8?B?YUxSVlNTUnNKbmtKbUR6Z1FqVXBrdDhWYndac1BrZXVjNktXdVg3elg1MG5N?=
 =?utf-8?B?dDFiSUNVVHJaRFdDWERCZUErTWpZYUlDNUxvWmFTaDREcFNlUm5ZWFhJdGM1?=
 =?utf-8?B?U2txaU02LzJYRk9nL2x2L3ArTXZHNnlsQjZBazd2YVJwRzZHRzhJSXlYZ0E1?=
 =?utf-8?B?MnJiOVBXQVBnL1p4S3M5MUthTlkvWFUrN1NjdGRDL2NFWVVqTXdWNzdrV095?=
 =?utf-8?B?UWhFTnNuRS9YYlJ6YzduM0IxSzB5QVBObCtXRGpqNTMrcG05djJRNmVuWjlB?=
 =?utf-8?B?MjNlRkFYcTFrQVd2Y0ZTcTZKaExkcjdlak5mTzlPNHRnUGFFa2wyU2g4bXpi?=
 =?utf-8?B?ckdzbWtscFcxejBPTUpMdUluVnpPWDBTTjRVU1o4S2x4eG94OTEvSk45Z3B5?=
 =?utf-8?B?Vmd3ekxqeTZMT1JIdnVEclJXNURMVS93U3AwU2l1QzVEUDlqZDJsUW0xUzIv?=
 =?utf-8?B?bVM4TDQ0M1JaK1ppOEVrb09hdW93YkZXbTJsYVZWUDFzUmNZd0g1bHE4eHdx?=
 =?utf-8?B?Z1V3cDNtQm9iZTBodkl2S1c3cGNMWjZFNFBwaVlHeEh3TEFwOEJqM2QzU0do?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db1e7b8-de75-4e1d-583b-08dbd6f30db5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 13:46:00.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ES4fVHuwtYIE2CVhZwL+wsxqAzFOLB/YfSdmLUisNddY1pjzKp7JzWVuF2+RX5ouFOD0NMwu9WU95GeLJVEIZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5726
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.10.23 15:43, Nishanth Menon wrote:
> On 15:34-20231027, Jan Kiszka wrote:
>> From: Su Bao Cheng <baocheng.su@siemens.com>
>>
>> Make the m.2 power control pin also available on miniPCIE variants.
>>
>> This can fix some miniPCIE card hang issue, by forcing a power on reset
>> during boot.
>>
>> Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
>> ---
> 
> Jan - please Sign-off for the carried chain..
> 

Sure, can do. Was intentionally not doing that because I somewhere
picked up that this is not desired.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

