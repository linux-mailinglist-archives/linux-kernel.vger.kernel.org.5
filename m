Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E86A794004
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241484AbjIFPLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjIFPLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:11:14 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECBEE64;
        Wed,  6 Sep 2023 08:11:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6/r32Fkpk+G1R0YQM4E9ceQW+M5O3/pakjQVsqDLkw0ZrsgzqGK5aTXRbRqXloFPYhGyxEQX8S1Rf0ZyxUOekMdpW6cp90V5ie8g36EY8gqnmzCOeowpZYRhfcD6WCgiCoOa607+hYMDLYuOKXYlwwv24MFvhE8wMjW+34L3ypDK+qI+4V8DUDgqBb5pkgAHFxdin3cRH6/uDcjjPnrLhc7s8O/i+f8cpe0IDReP8tjrU12UO743ZyCoWlAHsq0y0AzQGcqFejZXAb+PK36YGEEmVEhoWhGt/6t2hh4IpYHxPOAP9Y8f4vfO/VMltsTIau5hWFD93eUYKNhR8yyhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tky1i6nc0oTu4PeOppTtTO9qmkhwsozXp1eSM3WSnAc=;
 b=miW+PHSxOjW4PXL8AjfPrB+dj+KKrlFd9Ub3jIePz7za7E0+coqsGmeX5kFkSgI9b/Oo8PX9v1SFhWqWJgEM6gXR39rkIZnxUSVQOHG+EtX7Ja4MIpGnzmNy+ayMXv22XHkloB3GxJHAP/kMIUGL8QRPSwzbjKUnZVooNbLqWWZPRTeLeCI8QnaPmvqkaVDEFK+BBAjNud5BZcGJSHx96CuBOrsouYZxxdx51FtrrZMZIaylFma2AdLHulocXQavKGcEhQMQvH+3at6igiYjXvq7r/QlTMAX/95AicG1GONmJbglXKyIEWF4MGyEC90I/Ye531pNSB/z5lg58JruBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tky1i6nc0oTu4PeOppTtTO9qmkhwsozXp1eSM3WSnAc=;
 b=EgfwcGjmbnFbiRHqvcUavMFIJ51jYHBdXS3Ky42ym+sdgCt25WbxO4rRi/re+ifJ8ByBid96ecN/29gCyAo8NQAYL68JqRbbmf+yCP9QdsuFRigaL/ga4XMhNwMYVLBfM+YwvVpjLw2xsEgiPTPoxF8CyAwh8uOMKImolfkjTiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 15:11:06 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 15:11:05 +0000
Message-ID: <2687ff26-5fe2-f1da-60c7-fae712ac42d4@amd.com>
Date:   Wed, 6 Sep 2023 10:10:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 4/8] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Cc:     dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
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
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-5-babu.moger@amd.com>
 <6a5ed053-5d4d-f098-d37f-17eec3554536@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <6a5ed053-5d4d-f098-d37f-17eec3554536@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e4ff56-ad7f-4953-c4b0-08dbaeeb7dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5wEi71t+e7ggXj1au4K/3pdQBbmBfUgYxxv0B18/RQuY75SmBJGv00aYO9gwpz8FILTWqGTL+6b87Xi0pewqX+IHI+i4SchxbVdRDOiRRemL3PK+aNMFSWDmvZdlZ41XAGfE/oCL3xyhUjp+Ij3xs6pgAgl6Nupp1yZ5xee0Zj8hTZJFdnfh/jffS1TQtopPLCDsOx4EYszCOsCwh3u4FaQKeFwOQWE68z4nJUTYgG1K26TLOfFYVwJBJ3MCk8J3NSWt6cJLVyVixfeP3e+RPzBw7gbcPgWGsSW9pt+c3u6zolTCcbzgquiSmH6KWZzqTMSIROziMJ37mlLEN+U+P6hzesqG1U/sJNi1zbuKXiBrrRVGRpjG33utNE1nzPd+FZ0osq9pV2HIjdUjHhx/DLefrc1s+MNHv+PPT0A/OEGvbkUBJgfKvZEONpQDN3BeJOvP7J50FN2j9+9Emr5V56Og1xTIZd6MpsD4TyNweUhp5H4bhLPN51wcIEghfqvrNIlMrQR3YgtUAOS4X7FdQiQFHO+0oI3QtHDIPaDrWurnx5OPHrJnQSY5iZvnZT36bW4D+QQW9SYPx7bp07BS38ZsQI9otSTmKj4bzLJEJZEAb8ndyYJ5RMqMZIz0bh+02CPg6aJFzzS9hO6LOtg4TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199024)(186009)(1800799009)(6486002)(6506007)(53546011)(6666004)(6512007)(2906002)(478600001)(2616005)(26005)(7406005)(7416002)(41300700001)(66476007)(66556008)(8936002)(316002)(110136005)(66946007)(4326008)(36756003)(5660300002)(31696002)(38100700002)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEQwbnZvUi91VWF5cGNhT0lNb2RpOTV1QzFqSS8wR2RyU3hTWVJtODVBdmxL?=
 =?utf-8?B?djZ0STdkVHo2WUFFc1kwbVJmQTMwQi9nNWVQN2dHblp5K0tDVWVHMmZtelFT?=
 =?utf-8?B?TDFWZU43QzR1dXM4cHYyUWk4OXZrSW4zSndhS04zTjh4Yks4Y20xYjdWU3pt?=
 =?utf-8?B?cGtBMDVGck5MUkM4bjJSdldzVzlPZFpFSnd5bE45NkJjQVJFcHNubzNMK2pv?=
 =?utf-8?B?V3NCOGNXWSs5TDFINnlKZmhObVJOeTJRbGdLUlNHUnJVY3lRK2Y5bHJOYWlo?=
 =?utf-8?B?bTZramZxaWVxNVo0RUY0Mm1lV1czeC9aQW9vcVZ2RUxNS1RDbC9lRXV4UnZi?=
 =?utf-8?B?T3liYUY0NW9ic1FuZFRya3l1c0JJak9xQ0duODk4RUhudXQwbnp2VW1NazlR?=
 =?utf-8?B?SXJwUzJndXpROEVwYW5QTEdybW0yRmJsTVVTVWdoYjR2c0l4N1dTODlPYXRi?=
 =?utf-8?B?NU5HWGlpT01XTzRoT3hMWkc5ZG0zTjQ2MVdnMHVTTzIyM0pqL0IrUzRGa2lD?=
 =?utf-8?B?VmZrR1FKbDNFTzBCOE1LUzBlTStuSU4wZ044V3MzZmROWklUanlPK0V4UHN3?=
 =?utf-8?B?YXVlNkFHVDEzRlB4MVJaeFlvYmI0Vy9teHNaYlNLZ0tCNVlsYWF0NUJyZ1Jr?=
 =?utf-8?B?TU82ZklDL3hsdm9IZmZZMkluVDFKSDNHMHZqaHVTU0diZkFBZk5SdXZQeVZi?=
 =?utf-8?B?Q3dDZnJxSitXU3lrd1F6WHhyVXhELzhQL2tDRENEMHdtaTBwK1BvbnJTUTNJ?=
 =?utf-8?B?L2xBT1FDTmFjL3N6SDNNbUhaODA3SnBwYW9FVVFVWGxwQUNVbmVsSmRXNWVp?=
 =?utf-8?B?SDFoaVZlekFQY05iV2tUYUtGdGpmbUl2eGJWamxLNzVOeGEzM2lJNlhlMjFq?=
 =?utf-8?B?cUNsdWlGNHpXM0dnMXp2T0c1VEx5MnVjTUdpVkJNLzdSYndJUXdoRklaR1Vt?=
 =?utf-8?B?SkRaQUVLem5rS1FwbE0xSTY1aDlObGR0dFNHaHl2RmVpcmJMN0lnYU1Ra1Q0?=
 =?utf-8?B?clIxQnlZd0ZRdlJUeVF5YWN4QUk2UlJOWlF1Z1dPdFc4NDJHQnAyYVFZV1Zr?=
 =?utf-8?B?N3JsYkdMazcrNXpydUFEMk5kYnhRMDUyMklSc1FWMlMzYWR3OWVvVUI0YytS?=
 =?utf-8?B?Qmt3Wk9vT2p5ekpWUlVBOEhaOHowY3ZJcDZyWGVlK3p0OFJxbTZFMHBld2JO?=
 =?utf-8?B?RkYreDdJN0RXdUd0QlRCVkNLeUFaRHpPc2YvdkNud3UrY0QzM0M1SndXWFA0?=
 =?utf-8?B?SjU2RUs4SlRMUWtndEpQTlJEaU12QXFmSEdsRTF6OTdNaHN4WXdpVFVZMFRC?=
 =?utf-8?B?M3I0cktEWm56bUtUSTZEd1VnY2lKeGVHSnhSdnRhUFBSb2pHUHU0RlRBZXpj?=
 =?utf-8?B?SkNIY29XYUpaa1JacStqTkw5OE52dGFwQUhTamVQNzZWdG5lMUVhTlJsdFc4?=
 =?utf-8?B?YVIyR3pKWFplbDZBYTBybUVlVUdzMVgvY0VQQkZhN3JsLzFsOXprWWdPQ1hG?=
 =?utf-8?B?U1dsM2N4SzQydWhQcVRDZDVXd1hrejM5aVNja2h0TzljYXNHZlROenpXdDZh?=
 =?utf-8?B?L1RyZGRpMHE0V0g4Y3hkM1MyZTBwVDREcmYxVnpWaVIwWHRGb0cyNHU0Z2ph?=
 =?utf-8?B?elNIK1RZTkYzeUsrdHpjSndPaEpBU3FjRWRqeUNtWlltTERXZ241Um5wem9w?=
 =?utf-8?B?MTJtVFlxMEdueGJiVWlsZFNpK2x5RDVvbWRmOGR1TmNRS3orS3hOb0JnbnZZ?=
 =?utf-8?B?N05hTVZZeXRvZ01CWHQ0eUdpRGZORm9NMnhHdE92RmdGSXFFN1lmNnBWOCsr?=
 =?utf-8?B?c1UxbW42aktydFZVcTdSSzVwenQ5alJXNkhscCtiUVdDcENXalU2djYzOG04?=
 =?utf-8?B?d05ONWg0ZlptWWo4eTRzTnVYZ1UrMTI4NExaemQzM25WTTJNWFoyNkhZSTAx?=
 =?utf-8?B?V1kzU1I5dDBRcDVSVFJ5d3pveXozaXVoMWtzZ29vb1ZNL3FVM2E0TFErTGt5?=
 =?utf-8?B?bjcxRlVQQVAyUy9xZW1yZTd2bXkrVHVnd0FDWnl0Tmc4UVhGTmQvaEZ5R0cy?=
 =?utf-8?B?YW9JOVUybXFsQ0pPMlI4ZXIyQW8vblkwUHlSaUh1cWZSTkNTakN4Q0lLZjRJ?=
 =?utf-8?Q?vX5uSWv5K8KavvdF67+rgw3Sk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e4ff56-ad7f-4953-c4b0-08dbaeeb7dbb
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:11:05.4949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDvJgnBpq3DhlU9LI4KKCGbpfh2EwVUXXufV6xMdmRC2hEv1CKHjySh8j/Ttun1s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 9/1/2023 5:31 PM, Fenghua Yu wrote:
> Hi, Babu,
>
> On 8/21/23 16:30, Babu Moger wrote:
>> resctrl uses RFTYPE flags for creating resctrl directory structure.
>>
>> Definitions and directory structures are not documented. Add
>> comments to improve the readability and help future additions.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>   arch/x86/kernel/cpu/resctrl/internal.h | 58 ++++++++++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h 
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 2051179a3b91..b09e7abd1299 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -240,6 +240,64 @@ struct rdtgroup {
>>     /*
>>    * Define the file type flags for base and info directories.
>> + *
>> + * RESCTRL filesystem has two main components
>> + *    a. info
>> + *    b. base
>> + *
>> + * /sys/fs/resctrl/
>> + *    |
>> + *    --> info (Top level directory named "info". Contains files that
>> + *    |      provide details on control and monitoring resources.)
>> + *    |
>> + *    --> base (Root directory associated with default resource group
>> + *          as well as directories created by user for MON and CTRL
>> + *          groups. Contains files to interact with MON and CTRL
>> + *          groups.)
>> + *
>> + *    Note: resctrl uses flags for files, not for directories.
>> + *          Directories are created based on the resource type. Added
>> + *          directories below for better understanding.
>> + *
>> + *    info directory structure
>> + * ------------------------------------------------------------------
>> + *    --> RFTYPE_INFO
>> + *        directory: info
>> + *        --> RFTYPE_TOP (Files in top level of info directory)
>> + *            File: last_cmd_status
>> + *
>> + *        --> RFTYPE_MON (Files for all monitoring resources)
>> + *            Directory: L3_MON
>> + *                Files: mon_features, num_rmids
>> + *
>> + *            --> RFTYPE_RES_CACHE (Files for cache monitoring 
>> resources)
>> + *                Directory: L3_MON
>> + *                    Files: max_threshold_occupancy,
>> + *                           mbm_total_bytes_config,
>> + *                           mbm_local_bytes_config
>> + *
>> + *        --> RFTYPE_CTRL (Files for all control resources)
>> + *            Directories: L2, L3, MB, SMBA
>
> L2 CDP and L3 CDP have different dirs. So need to add them here:
>
>  + *            Directories: L2, L3, MB, SMBA, L2CODE, L2DATA, L3CODE, 
> L3DATA (L*CODE and L*DATA only available when CDP is enabled)
>
Sure.


>> + *                   File: num_closids
>> + *
>> + *            --> RFTYPE_RES_CACHE (Files for cache control resources)
>> + *                Directories: L2, L3
>
> > + *                Directories: L2, L3
>
> + *                Directories: L2, L3, L2CODE, L2DATA, L3CODE, L3DATA
>
Yes. Sure.

Thank you

Babu


