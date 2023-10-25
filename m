Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2493B7D78CB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 01:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjJYXmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 19:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJYXl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 19:41:59 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108D6182;
        Wed, 25 Oct 2023 16:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoOCEq9u6TdixIhbeYWSl5+vsK6FkgRCozAXYujxUcS9deKEUSYJK8GbWewxwiKc8ZqWjzOBnqw20hc/jz/AgXkGRnC+qGXdjkpD4lWGjyUK85Ja3XjUuONRG60NrTEr1AzLHp7oXCYO0lo35PI+TEAOWCoxwRuW0urwmDbLKeAMulGhoczQ16R4MfgDj+etgo/0imsFtsQ8PXERWjdiqMPm6tKk4s2+/aimR5OIGMiyPAoqHgk8EJmIG13/o7tumJrrAuPxtVYkL5I0hDKCp/h8NSngVSjLSHHTE5AzLPdbLXWF/9HNxSMDiSX6VoNkr78yfKPNRe9n7lpqrX7HmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfI3Is2whQXCSWrqhZp0+ykGnrwvaG6n7aEyPh0ljGQ=;
 b=acA3HQdXoQhOn8FSYnnxQzyrq70KmVJfznh2DrQ7fDtOi+FXnKkn07fvmb2UuL8CjW07ZKgXdRicuEWW62viFvoZxCiH3WFJEypnG7dcTxpPvpliISRDiUzVkskpkojlTcIGWNCdp1e7MiVg87ZYIHqtcng12xEz097mt88UQ2asCjkQyYCOAcI0dSF8UUhvPS4wsbqRoWUagtjaxCZ4b+gJn4K5iq48OHUWHVIMu/azpLxc2RwRvOJEnLOPiB+WszedfWJUqLp1MzDW0VDN7sy4Dedo6hzSaDSLwK9RtmMKqG1owrqD6DoIMlfd2gnw2xt0kPX55FieBDwVJhl3yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfI3Is2whQXCSWrqhZp0+ykGnrwvaG6n7aEyPh0ljGQ=;
 b=4NF4XkogCfBQzu43MetFUrtD0B59IYeax0ZxDtN9EMoINIYEU+4bjR76cdLy8iQewlN2qwq4rcFewd4RHPw+dkZEwwSz9CGcsB8izqi9MSvrRYbeZRvdyXZOc5vEctcEfPqadgbhhHKNZzNwEwuIbswjxC3ZW4uFs5duUgmCdMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 23:41:54 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1e4c:5da0:33ed:ff3a]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1e4c:5da0:33ed:ff3a%7]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 23:41:54 +0000
Message-ID: <88541b20-6745-28e3-6ba8-803a71554d6f@amd.com>
Date:   Wed, 25 Oct 2023 18:41:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, "Moger, Babu" <babu.moger@amd.com>
Cc:     Peter Newman <peternewman@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
References: <20231024181600.8270-1-tony.luck@intel.com>
 <CALPaoChftF-H6GauKq4-c_qBJP1GJbR3-ByE5krsaQF4y4y9oQ@mail.gmail.com>
 <ZTluypa9bCWv4k2n@agluck-desk3>
 <e4994218-a7a2-4505-868e-a5c825ca4db0@amd.com>
 <b8ea0a74-347d-475f-a36d-8944ced16951@amd.com>
 <ZTmAFVuYlMuCbQHz@agluck-desk3>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <ZTmAFVuYlMuCbQHz@agluck-desk3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:408:e6::21) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 2309f36c-b695-4445-efca-08dbd5b3f7d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6NLrLrmckvnceejGg/28CUajrNKh0tiX3KgaCxmtjJeJS2yEjUGZAltrCwHra3KuD+z5DrxxSDginBziFy0DduCN9OW1x7UznNwi8Gb+QaxiYITU7piCRVrAvauojyfBZWS2VkXikCY4fAJc5yHEqyTIC3cJEjX8ec/SNiyObub3rVEqPg9iF72VyabxqLQwHf9PtNw4uA4y17NXVBa46gRWozbUMrOdagMjUAHIXRpZQWierPMrkp1wmeHlssZREXMcpby9GMO0oX1OCjODLISfesOurYa9j4je/VD11XOA5GltYwxhMwakG5SKjHCevIQX1q2tORVXoOzBHIvhUehp+8Dd3ZU33AbGEz2m9pGqVXwt2IVvu5hM0xsm8iibjntRXtqFJ/OSs34Mm+/et1khPOnibiH65x9STwc+i6vo86mFzZFpbJBK3JWXbB5c2+qSLGl1oJFOBsoe4ksrQuqCBZepJ06HE9CTcM9vqWGByXGDmTCLpnZleOwxPioHQXnOBF+nP87gvTP8ZekhL2LvSmdHwOb1dB7AgqtsnqAaSwdOrsuRpsQW1IJANwgocmgbEr8VupNg38g1u1+uzrlmlqPyHdVe30Qd3VqubyozFuGxho2WpV7nvviV0T4wb7LVRnwQ4MbGXVufGfWlbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(31686004)(31696002)(38100700002)(2906002)(7416002)(5660300002)(36756003)(4326008)(8936002)(8676002)(6636002)(110136005)(6486002)(2616005)(54906003)(41300700001)(66476007)(66556008)(316002)(478600001)(66946007)(6506007)(83380400001)(6512007)(53546011)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUpMNU5sSEVlQXlCT0xUc29Ic1RRSzRKVEE2bU1Ya0Vpdm9paXhoWjRNYW1y?=
 =?utf-8?B?a0VqbndvSDY5L2t3aGYyTHB4N1plOTZkeHljOTlLSkkwV3d2UFIzNEtHTXZa?=
 =?utf-8?B?d2xJNXFCamUxb0NrU2U1YnpqMGJPcmhlcGpEcTBudkZRVTQ5RGdOTW53cDVD?=
 =?utf-8?B?d295YmlyV1BsYmI2b2JBd2dRdjlXZjNxRjMrNndxMGFsQ3U1RGE5SUw3Umly?=
 =?utf-8?B?bjRqVmllalA4UWFrRy9YRmk0RVYyNmc4QTBVQjdRYjU1U25ZeU1FUGVEL25r?=
 =?utf-8?B?NWdaMGxHNjg5WEZkbVdJTUFRajZiTTNGa1JuMHJEQnZWQnNkRnZ0Mi8ramZH?=
 =?utf-8?B?dW0wY21iU0M4c2crV0EvUDlCU0VndlMyTlV5TGszSVJxZ3c4UXRIRWtpTjFx?=
 =?utf-8?B?bmI2YVQzWnpnYXM0VnFFT05ETWZCYis3cUZXWHV6WFB4b3hsWGlsTFBkdTJ1?=
 =?utf-8?B?ZzRWRkF5b1JJa2M0dzRaMkZrOTRBekpCN3MyekZJbUhoSENWR2k0SHN0YW1m?=
 =?utf-8?B?blVvVXBGYk9jSnRpelRLcXJNVjYrN20weUZnbEw2SWpvbFhsajNiYUlxT0hU?=
 =?utf-8?B?MUJQbVo2Vk84RlgvMzNTbFNUNDhsZlE5clc5WWFyeHpzdUw2Nk03MzRCL05J?=
 =?utf-8?B?dFpGbG9UYXkxTW5nRFF4NVBHNlBNbmsvNGFSK2tKdHFtSk9EbS9MbzVhbU9o?=
 =?utf-8?B?am9sUkgrKy9UaDJwd1Jnbk5kSnBlemIyWSthSTY2aExMMm5DRFpJN0U4R0ZZ?=
 =?utf-8?B?Z3gzanVoQllDb00ycDBENURNakMvaHVRN3VsbjZvYzlVK0J0di9Vcmx5TzFL?=
 =?utf-8?B?YlZJSWpTNTR6dkJuY0RYNWxmOXc3ZVE3eDQyOXZrSUZRNGJMd241U1lVbjhq?=
 =?utf-8?B?NkRjM3FBVXB1MmxuV2pMV0N3US9HSFYzOXdRR1BmTGFMUUwrNTRpUytoL0ho?=
 =?utf-8?B?VllsY2V0R0oxOXN1Q2hJaVhkZWZQQWV4YTNiQVdIWXdBUU5UODJPd1VTNDBn?=
 =?utf-8?B?RkIwQnQ2cnNIRG5Nd2hyTWxkaHIzZmNrODVVNmU1Z0xDTDdPTWxZdFkyUUlk?=
 =?utf-8?B?bmxrMGdzZFA5MEFiejB4MCt6V2JOYVZrVnA4cm5VTVg0ODc1bzJYLzlaRGZ5?=
 =?utf-8?B?Rml5aDQ4ZU9NV1FIcm5kejhMR2xGcit5RGozTjZvcTc2TE1Mb0tzS2VHQ1ZY?=
 =?utf-8?B?cC9XZUMxekZ1c2Q4SXFvU0lKSm03a0RpV0NzTVlpZzE3MW9zNFYrUTB5dHpJ?=
 =?utf-8?B?L1ZJRDZkeFhGaGhIMW5WNE1UcXM3c2Y2eTJ6d0pZTS84UXhBZzcyb0xZT3l5?=
 =?utf-8?B?Yk1qTWh2Z3R6NEN6NDRyaFRrUnhEUkxWaFFBVVUyeTQ0UmFsZE9EMU11WFZq?=
 =?utf-8?B?MnJ1RzhIdG9YY1R2bjFqZEZVbTdOL05ucGVGV2ZZZmwyd0NDTG9XMERiVmsr?=
 =?utf-8?B?QlgxenB2ZkVDVXhSRVEvbkhWdi9QVmt5MGFYcTVtRTI2L3RTZnMwa2ViNXV6?=
 =?utf-8?B?bXArZ2VVUmJCTjVGeW4zTnFUaHppU3BTejlYYkIxTkgxS0FzTUJaMzRHS2dR?=
 =?utf-8?B?VXNaNkpKQWNmVGo4TkMzZURZTGFNM2FNbGRIbmxvekhBWHc0bVo3N3dZVWlL?=
 =?utf-8?B?bkZpK1lXUUZyTFlsajVDTXFxbzY4Y3ZNNE5CdDlWN3ROcnZkOUhBNmp4MHBM?=
 =?utf-8?B?VzdrelEvTEJNb1lsVnRSWGpWM2VqT0ZjZUlmTG1tbWY5Y0FaNE5RQVMzY3hn?=
 =?utf-8?B?ZE9NUCtYcDg0VE5CZTlaWGtjN2xQTlJXTUYzNUZObC9pRFBYTGw2VEd2cFp0?=
 =?utf-8?B?SjM2SnR5Z2ExRGEvaVU0ckVFQXhKdW1FV2Jya3NVTHhEUUpGUnJicm1mL0Jv?=
 =?utf-8?B?NEdlVXlzODQyR0JrQm9hNUlkVExnc24rcVNKZUJ6R1FqbVNRS3RCL0cxckMx?=
 =?utf-8?B?bXBzYU80Y2oxODNKbVp0ZUQrWG9LN3cvVEVvRjIvN1hnMVdRL0VZTkRscjN2?=
 =?utf-8?B?cE9aYkxLSnRUVDEvcEVNTFNGaW53aDFFbUJNWENzUjFvMjBkc1QxYlN3MmhF?=
 =?utf-8?B?UjU2OEkxTUlRQnE0dTZhazU1RkdZbC9qeTd1RFhad0ZCU3dZWjVJMVdYYmN4?=
 =?utf-8?Q?4ezw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2309f36c-b695-4445-efca-08dbd5b3f7d2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 23:41:53.8498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtwjWc83VyDs6/MjNqRD/4JvkLHnAw4znXbuW69xdqyEu9FwLZfZ6Dh8cXdx9RPE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 10/25/2023 3:52 PM, Tony Luck wrote:
> On Wed, Oct 25, 2023 at 03:42:14PM -0500, Moger, Babu wrote:
>> I meant, I was thinking bit different.
>>
>>> You need these changes in only two functions, mbm_bw_count and
>>> update_mba_bw. You decide which event you want to use based on availability,
>>>
>>> Something like this. I updated mbm_bw_count.
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> index 0ad23475fe16..302993e4fbc3 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> @@ -436,8 +436,16 @@ static int __mon_event_count(u32 rmid, struct
>>> rmid_read *rr)
>>>    */
>>>   static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
>>>   {
>>> -       struct mbm_state *m = &rr->d->mbm_local[rmid];
>>>          u64 cur_bw, bytes, cur_bytes;
>>> +       struct mbm_state *m;
>>> +       int evtid;
>>> +
>>> +       if (is_mbm_local_enabled())
>>> +               evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
>>> +       else
>>> +               evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
>>> +
>>> +       m = get_mbm_state(rr->d, rmid, evtid);
> Ok. Yes. That seems simpler.
>
> Maybe I should just set a global "mbm_evtid" at mount

Lets not make it global yet. This is only affecting couple of functions 
when mba_MPps is enabled.

> time. No need to check every time to see if is_mbm_local_enabled()
> somehow changed and local b/w measurements were suddenly
> available!

What changed suddenly? Can you please elaborate.

Thanks

Babu

