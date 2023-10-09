Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EDD7BEABB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378431AbjJITjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346671AbjJITjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:39:42 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5F393;
        Mon,  9 Oct 2023 12:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfMPlKuVW9UiJX2MJQhoRoRsogcZk4YXJayeA1+Nq/uWRa9Opm/cNO4Fox7/Cavo5auW4sqvUU14qP6cj3a+Qwiw2zWnPOspEofQDaQeHks3ZjxHwsGfjebMK78Vip+boh1AhMQXS9tPqoqoL32xezwQ+vWBhpo6NuUJcCEPZQU33DTOQGyO2blaaZqI7RgumEtrC4dvW1ezhOQDrAGcXwqIgOOj3qtKeP8tjgnHjSvZZdt8Cfm5kYOjt9c9TF70/1wAWdqLDdy8sw1NeM9yrMwSU0LaSxpPW76aBmE60XU4xxnA7mh788I0251xKHOpmzy2J7tVlO6OCAaEqksWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc6QQpCfE5LXQHooICULshobPavR+LBm2YdYF0yh5Oc=;
 b=J5ExUgKqZTnej1fov2fniFbJEUZKZF7I6iCBYp2u+H7+vfLCspgs/leQh0GF+JxiaFxNRa9ywPAP1ZUVA0U+SwspRBwCH7I5s3XSdXcD6p+s/VtBHgu7RKC2uAWQlggr37yUu4HQNziL/cUU7Os34EYZmimrmJSs3sDp11EDZCUUgJiipz8kdsR1aeX6mWG+4l3m7pgJLaSFyLRonfxTJVVZ6H4o6tauI2W2nXzj9See8Cb3DW51/K4LC7LgPJiSGzTCGkfP739MgEwI8mii2ATAX1qxk7kSFUweJqPlVX9mqhxybWKNARG/le6RsGNYksEf9i4xFMwpFBHi0DZL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kc6QQpCfE5LXQHooICULshobPavR+LBm2YdYF0yh5Oc=;
 b=ds1uqgzcSEecglaZZK0Pe6RXVPHHPKtzYaetXb5YUumvvD7oY6ddL6B7Eqy1ihxNoR7WuGOj6PfIOVKHOp4DKhSvENQqtf6MrhV5YjDNOOsSWBnJ9DIxK3mwxyLxXAnXPp5Df18xy1ZBF7WVAdRIVS5MNppFeqnb6AupCnASUOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 19:39:35 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 19:39:35 +0000
Message-ID: <c794d06d-1954-470d-bd3f-b8c73a32dce0@amd.com>
Date:   Mon, 9 Oct 2023 14:39:30 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 04/10] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <20231003235430.1231238-1-babu.moger@amd.com>
 <20231003235430.1231238-5-babu.moger@amd.com>
 <20231009172207.GQZSQ2vyKLm660U5o6@fat_crate.local>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20231009172207.GQZSQ2vyKLm660U5o6@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:805:de::49) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: a167ab6d-b6f5-425c-22b2-08dbc8ff777c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nX/Ew0TZhk/GZpyrlhxYEtBsYFaazGKikstRJImw6SiSfYVNWMrrL8FBqP0XBPtR/erCbyHLazxanyOGmXVZejuWRRO5gLZ7aoQ6w3e5vHnhD+gkXzRonxwTMED0ZzGYjcUSC62kxwzkjLrpC1FBM5IYQP4uKkJ/J2HmQaSvG7nfVizkc+FPSi+kxY3lVQ0kqnUqqLTx37wPis5Y/3dVWyUSQ3WncqHKEqRQbTovUaZoBiQr27xJM/QEzuQq03JIxsOw08wC2vq0MPFWEkJdW8/lPOw/aMygcHM0FV988Qp37o3Bc0lnZae1jlxk2jZMvMacQpwVeF6nm/zYvTvRnOx5BfQU8WACegZ9D6ZirLXMp2xUPykZbLa3wHYjCWQrT5TPljeaP4vXPTPrF1Hepu0NMznEm+xol+GvksABoDRue7cyEu7ofNvFUv9uDQCwoLfAY2eIpUsKffg64ZSW0DxrTXwLOmWidcYn8EOYdBgaueIkLoxjNuZN8gZqiCf8dxPJaqlClR6SQhUbR3iXuL+uQteUApSqruxLF2LjyKv8AXbm4ERBD4H9vZq6zcGVm6XKxZDDqibnIFuQq9NIhCBQBAWvlSJOPMZo2f5EY5vFemMigGhAiT8Oh4qeGcaUXH26x5rzv6RP/qAonqDy/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(31686004)(6506007)(2616005)(6512007)(53546011)(6666004)(31696002)(86362001)(36756003)(38100700002)(3450700001)(7416002)(7406005)(6486002)(2906002)(478600001)(41300700001)(4326008)(8676002)(316002)(8936002)(26005)(66556008)(5660300002)(66946007)(6916009)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXVWN252Y0o2cWdheXBvYUVZendma28wckQxSml0QitCNStELzhCenRMVUVY?=
 =?utf-8?B?Sks3ZW9BN0cwVHJVamhGcVZjb3Jxb0tFTnY2T3ZDMFFFbEUzYlhVeWprSm1I?=
 =?utf-8?B?SnZ0MzRkN09VNVBhRktEWXdxbEZlVTNOSVFxa25DUFdvLzNuTWs4elZueE5B?=
 =?utf-8?B?OVBxWEhlU0laLzVucTl5QmNLaEVRQlNjMmFSMGsvWkxJVE1vdmJQUEJaT2tF?=
 =?utf-8?B?UXpESXJDQSs1VXdGZEE3TjhIZUc0Q2paajM1bjZrMTRpTnBucHdsKzBFY0xa?=
 =?utf-8?B?RDErOEFDUFoxYVRuTGhkN01lYVZjT2E5RGtpeFJETFpDdkJoT1lCNU9tZHJU?=
 =?utf-8?B?OFpvbkhkdGY2cWNFMndMWjZ3Yi8wN3NXT253c0pLSlh2eTNpZEw1b25RNmpV?=
 =?utf-8?B?d3FobGFpaGl1U1paYUY1VU16NENxZUdMRnF2TDlmZG5iL3d3RXJ5ZGFrYjBh?=
 =?utf-8?B?eG1RY3ByK3RPZElUY3hFNHVZbnpSK1BUaFRyTGNGTGpJTVd1Q0p1TEJhZmNE?=
 =?utf-8?B?UlNJOEhjTW03NFcwbnF4LzVyNC8wdFQyV1hadHZrQmNFczQ5Uit1eHllTzYw?=
 =?utf-8?B?VTRDL3I2Vnd4dVRVa2RDbmZrOXBlaGxJRkwrdWZtMllTaW9mN2ZQY3FOUms3?=
 =?utf-8?B?Z1NHaDU3WkF2MHYyS0ZZL2J0K2dLMlRYVCtueEhMTFJIMzdESWFJMnZoRXdN?=
 =?utf-8?B?U2tDclBDbmVxSXNiZTcvVUpLb2cxd213ZFcveklHZnJkOHJxeDhNQk4vSmhq?=
 =?utf-8?B?NVRmdHVvcUxMSVRDZ3dIeEk1VzFHdXhjb2lsNTFFWmNLZGZHYy9saVBPUU1U?=
 =?utf-8?B?NFJDeE16NzR5eFBZa2JQSE13dXIveHgvQnRka1lBZEhsWWpnY0l2SXNMU0R6?=
 =?utf-8?B?T2oxdDNSRHYzSk9HSVJTQzF6Ny9YblFSdmJlOVhjVnA2UDBOeGowa2NHZmI4?=
 =?utf-8?B?TUd2b0Q3cTUxenZhRDd5ek5UdkoxbW5DS2pJNGd5VFRaMmlkQlF3TE0wc2Fo?=
 =?utf-8?B?U1ZPc1VTbVh2bTJ5aGNWTDFhN0pWdmdhQlhWck1qeW9LQ0NUYjhvZjdwWkpQ?=
 =?utf-8?B?QUxYdi9pMzRNa2V3b0w5N0QzVTRRSThONXg3MkRGS2c4dzFFcW9DVVc4aVRQ?=
 =?utf-8?B?OXRsUms1Q3I3S09RcTdhNmdTR2Fub0lQQjVKcUhUR1hUN2hna0pRWFB3YWI4?=
 =?utf-8?B?cE9IenIvSGdERCtxV3Q4bStIamR1N3RCM090UmRzNTNpNkw5U0E5cWhiaEFx?=
 =?utf-8?B?VURaUlhaNjF6SGpLaFlTcHFEZThPcGxCOW5hRnlsV0ErMzN5aENaaHEwYjhE?=
 =?utf-8?B?RlAyUzhiOHp5NzlMR3pVR3RRNHloN2ZZMTNiNWdBQ08vdDg2Mko0WjEyZTJR?=
 =?utf-8?B?TlZLOXVXQ3JQV0lEWEdRRUw2bE0ydFpsN2tGZ1NzSVVOVWowcXdjZWgxWmRx?=
 =?utf-8?B?ZXhyTmkxQ3JNendNNTcyZ3hsNU1YdjBBS0phQ3NVcFlSNmRRSTVHUCs3L0Rm?=
 =?utf-8?B?SE1OQzhQbHM5NWNtVndZNTQ2dnM5WEpndHFNaWF5L2VFcklPeDFnbVp6dktG?=
 =?utf-8?B?b2grdEp2TTZVc2swRitIeDBvcGo5RGpsL2I1T1dsL2Fxa29heFJWT1U0UXJT?=
 =?utf-8?B?QnlpcXVJL3M1SEtNTmtIa3l0TGdIWGpndjdkYTFDc0pTWldGM21rQUMxV2VQ?=
 =?utf-8?B?MlVUMnh3NWRzeGZxTVNOcGZ1T3JiUGQwcVRIVkRvYnNWcC9BaTRKZTZLdlJI?=
 =?utf-8?B?TElMRXIxRWU2SXNDczZtdTRnRWZsWkUvVGlhZk1YZWt3MDROY2RsYm0rbzBK?=
 =?utf-8?B?Z21mbWJnemhVYkU1NlhPVk05K0krbktIS2tDMkdobUJkcVFXSFNrTFhoZUdW?=
 =?utf-8?B?dkxFcHk5YnhDekFMRlF3N0J2TlNBNkxId1pZM0dVLzRGakdJY0IzSElxVjJ4?=
 =?utf-8?B?clM4Qmx5TGZkcVdpNkI3d21Ld2x4RzZDTXQ1bmRNamlCZVQ0VFJBM1JNMUhT?=
 =?utf-8?B?NnNnblhLR0xIMWorTy9ESmdvdjV4eEdiMVowRG9teVNCU2pia1Q1WlNIMU8z?=
 =?utf-8?B?OWpzUzVRbmc1bzRVZG5MdXNhRGxXTjVDQkhpZm00bXlrMmFMdWVITlRXSmhv?=
 =?utf-8?Q?+Y5o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a167ab6d-b6f5-425c-22b2-08dbc8ff777c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 19:39:35.1117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19E3f+YB3dldhfiU3KeNzvbqo02T8CqNO2d5Nz3rVInhJbqKDQW8AUCGtkW5wAJX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 10/9/23 12:22, Borislav Petkov wrote:
> On Tue, Oct 03, 2023 at 06:54:24PM -0500, Babu Moger wrote:
>> resctrl uses RFTYPE flags for creating resctrl directory structure.
>>
>> Definitions and directory structures are not documented. Add
>> comments to improve the readability and help future additions.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Tested-by: Peter Newman <peternewman@google.com>
>> Reviewed-by: Peter Newman <peternewman@google.com>
>> Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
>> Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
>> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h | 58 ++++++++++++++++++++++++++
>>  1 file changed, 58 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index f71bc82c882f..b47a5906f952 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -240,6 +240,64 @@ struct rdtgroup {
>>  
>>  /*
>>   * Define the file type flags for base and info directories.
> 
> Why is this lengthy comment explaining internals in a header and not in
> the perfectly fine
> 
> Documentation/arch/x86/resctrl.rst
> 
> file?
> 

User visible files are already documented in resctrl.rst file.

Understanding of these flags are mostly required for programmers. Users
don't need to know all these internal flags. That is why it is listed in here.
-- 
Thanks
Babu Moger
