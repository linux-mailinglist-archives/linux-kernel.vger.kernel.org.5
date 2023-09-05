Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8B7792D2C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240282AbjIESMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjIESMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:12:24 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C21F61B0;
        Tue,  5 Sep 2023 10:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qn7N+lw5nFRVPRQoEP3ZWJ7HsXFYMtVFNfLAUBdvQpGa6q8OaDpjYPLm0KetATmik/M1LR5ySPMWSsVPKo0C9csvCrrBGHffO6CmuVQoQCh485TqdRm3KNyj574Xvn5Vkm1+VtOtfdP25MxOGnzC9qlqwfQBqrJfkHJ6zaljNarW79dpuDhITvqdu+FTzVGak/TMX6SfSCcIRxpFLZjG901Dkrp6ekrovysG0zGc6UOw/fiV8Z1mb9im/dCpZDoT6rdEu2M3sgzyagz7b+ftjxWQoG3cIefBPNF+2Eo9ZNnSFnGFln+iQw5mvDZO7cokrIb2x8LUys0B08IC/vkKrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0ljZAVWu594IVPo3wq0wTWXp2kv3SCEeV1+6FzjSwk=;
 b=OJKUyg7HPcQgh4H4QG9TFeTNGWQAULuuc9vedhyNLNvgn1Qzj2LPl4eE24rM9zUnzPfNSJ1GaWHLO8ueGsWY0+jkQtYaHa60QPeiek0IsVOBIvgvrLqRCDORkAfLlakSW2gGu2TPb20vlD4hiSDndy6JZehfShgVIIh1V72JkpW+AC2r/uyZOB9l4xV2l+xouKWW+9uet0uwGeA8lD+o8hSJmUzxWxQD37fnwYPOGztO9dSyW68YI8iyuvT4rlOquvnzBMYfAXeajtKG48pCi8bZa4GcbjBstOMhH3/h3l33f4CPG6ABQ4E0bBTOV7JFosTwXwOHYA1zBo8zVCblHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0ljZAVWu594IVPo3wq0wTWXp2kv3SCEeV1+6FzjSwk=;
 b=QEc7t8Fl5WDHgmgy1OhyM3e5f7zJ/FSaSabAJZV7sKKjO8gy5s0Ayhb1DGujXD8l6yHlGRA8CxoC2I091mnMMWqmxemyeL1vqe4pQ67WevhR09RR5ArBHt2HrhRhP8vjYfFkFsrDGF/NfnwZN7MmbM3qQc9d6+76mGetx0Hv7vI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 16:51:33 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 16:51:33 +0000
Message-ID: <cdfeb701-3eee-167e-1132-d14bacd845f1@amd.com>
Date:   Tue, 5 Sep 2023 11:51:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 8/8] x86/resctrl: Display hardware ids of resource
 groups
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
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
 <20230821233048.434531-9-babu.moger@amd.com>
 <4019a73a-8478-f18b-7f34-b8d838dfc7fe@intel.com>
 <da47698a-aa9e-3760-1321-5ec3ea1a14e6@amd.com>
 <5b75506b-80ac-a89d-4b70-f775c3b354d3@intel.com>
 <012bf30d-7c41-b9a8-cdda-0922797d6a80@amd.com>
 <2feb3e01-96c7-fdde-a0d2-509fa1527243@intel.com>
 <ce3e0cf3-9b4c-86ae-8095-d433a5669737@amd.com>
 <f2481932-fb3c-d9e7-c6cc-9407fc0df416@intel.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <f2481932-fb3c-d9e7-c6cc-9407fc0df416@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0127.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::17) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: dc9e6c13-ac96-4c86-2f61-08dbae305c36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fQzGSNg2wf/+gzVDnrhuwBImUUwzglHDTvqLvRBK+ONYHfqYTqyUg19YOEBde7/1amydC8lFipsvdICia+7DkYC9JX+0Ke88haBfzOwP0vl+NDBz0SbryV8vqZj+CbiHXCpJL1k+YWmcKjJtq6ZvXZhjttM7K2rpy7L3whUQ1SjLKJ6lDokUB1L+bYlvvt+e3qzlY5+AMnMrJwcT40rZiCmPptbhfw28eYjeEyL3murjgcHE+d8oISvSNXbw3nVcLV04m7iA7Dlt54gkqenxVXI2MP5hSvvFsIyJE6uoY6QpkUhhJbWv6tUhH00VKossk7bpIjCET6D41xeTS3OJq/2X5xoX2LAGvz0EEc64NrrLP6u6CpN/NE0lBUA1Hh0e9BYlUN0JELkYJr/vrEHqwl+E2/xFoPjRDSttkq3nMkMJ08pC+Xa2TugsVvB5HZ/rvEIrnQDyWois4rpO3mUqJGle4FISEM9H5oIWy4zstWHWdx0dLiU4iZQDCA3Yc+bZ78al3e1oAuqrYy4uO6sRZk31XtDlMG9q7MQDiRwYFSiSaQnWl8Gp0khqwh0/xIDlnuQytsLtcYO/oUB4gQ7Z9TtavWkgaRVPM5SFD+sQWMGMQhV9Jtb3yppP1jTPsSqvoCVi5GccDfiSxub+MUACzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199024)(1800799009)(186009)(36756003)(86362001)(38100700002)(31696002)(31686004)(6666004)(478600001)(26005)(5660300002)(53546011)(6506007)(66946007)(316002)(66476007)(66556008)(6486002)(41300700001)(2616005)(8936002)(6512007)(4326008)(8676002)(2906002)(7416002)(7406005)(3450700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTNLUnhtczc3a1RWRmdJQTArQzlpd2J2YVBNWkc0UnhxN3BkTjlheE1kMlhK?=
 =?utf-8?B?VFFxbERhREtSMG5xbWwvanYySExvN2Y5c21Ibng2ZmxpT0dVdlZxS0svaWdq?=
 =?utf-8?B?SVVETU00bFFIMHlUcysvN0RLM3Z6TzlUMHBHVEEyU2NWVTFNOFJNdGtaeTBs?=
 =?utf-8?B?MERUZnFrSzV4SnZWQWhHZENDN0VBSUQ2YjN5MUR5YkFlVHlkUFhQZ0VTU1Ns?=
 =?utf-8?B?dGR5dUpqR2pwb2ttWmx6Q3lod0dST3RMaW1ReFpiTmlNWjdpTmk2VEZJOFFt?=
 =?utf-8?B?NlpRcjI4YmxiRlN3ZzlmK01IUDBWVVdMYXpiSmNHd2oyZjFxT1ZOQ0FIdjg2?=
 =?utf-8?B?WWg3SXFDUmVKYzM5OXJIZU96Y1BGMTJqVjVldTZtVkg2UWZBM0oxRnRvNFdx?=
 =?utf-8?B?OHJ6cSt6TUpOVGRuNGJ4TlhBM2N1elhmMG5CWnVxY1M4MmtmelM1LzdscGo3?=
 =?utf-8?B?N3FFc00vZkJVeS9MYlNNTmlGS01rYTRNUXVIYi9MVWlNT2gveFZycHFmQ2lO?=
 =?utf-8?B?bzV1YUxxdG9PTzBXdTFMVUFLMS9IaWtqSkFFSW11VFNEckJ0OVdVOVlQMjJL?=
 =?utf-8?B?NlNEeGtJR21jUm9HR3ZOQ3NZZllyM3RPeVlmQnVrQnpFTHVOdXBWMDFEd01W?=
 =?utf-8?B?Y013aUxXZFpQWXB1dkZ1eU9iSGhxWWhwKzRUTEMwaUtVcmcyVUtXWEdmalNi?=
 =?utf-8?B?RWlNQjg4c2pLWGpUam00MXNhRjFzWmtabjR2YzAxNnZlbDY5MkFTaXo0YXR0?=
 =?utf-8?B?K0V6S2hMMzQ0MGJpUURCbmJHdml4bVBoNWtzVGtNdTBrL0hHU0hORWd4R0Qy?=
 =?utf-8?B?L3doZ3lFNFpUU0hzSktseXdzUUdKMDYwZm5FUUN2ZnFKbGRIQTBLT0UzdGtL?=
 =?utf-8?B?Q0oybHJaeXJrZ2JvdVpwRGltUzl2N2ZLVUtGQWlBUzJYbUJsemFOb2pTRDJx?=
 =?utf-8?B?Q3BpaU9yVk5yQ2JnTlZQREpnWXY1VTQrcERQR1crbjREaitESGNYb1o0NmFa?=
 =?utf-8?B?aEZWd3dMTDFpQjhlSkFHSVZrbEh3S2ZIZkhFNTE3SmZBY2tjL1JYdGdLSjYx?=
 =?utf-8?B?VzB3QzZ5cXZCdDlpMjFObDM4MVRjR0lUL1BWZXNRRy9ZNWpzL0NlbjZtQjEz?=
 =?utf-8?B?OWVRMnY2VFErc25IU0oydXZFTjJ6SmxQQlJnVklhbTR0Y3hmMk9jbm10enhs?=
 =?utf-8?B?T0pQalVXTkRZa2wrbXdCOVBhSk5UT1lFblRVWGxYVFVFckhqczRvZjhxd3Q3?=
 =?utf-8?B?TTcyYlpWQ0NIeHEvbmNqemdsWk5tSllEb0dPR2UrLy9aTWROcW1xbEMvRXlS?=
 =?utf-8?B?dHpVRHJUT2pOQmJ4SnZ3SnJaZmd3VU1VZmFlMEx5MnA5L21tQzVtTkdDbU9G?=
 =?utf-8?B?TkgzRmdOaFRZL2FobmhRRWtHcnUyVUxEbWpEN3JQNDBNaGEvZXppTi8vRGJQ?=
 =?utf-8?B?Y0x0OVl4TEFlQU5hT1NBUEtKa015WWVtVEJZNXZoWXRuQTZCSlgzMEdVQlBO?=
 =?utf-8?B?dyttZVdPc09rMTl1L3hjdlFVTkg0T1paQ3NpWFhDRVBiQWRkWEJlbC8rRC9a?=
 =?utf-8?B?Yng4Y2pGSTZ4ZVpVTm5XelF2TUN1OXAzNTRUd1crZTNjM1BwQ1JiZFVjVTh0?=
 =?utf-8?B?M2Q3WVNzSEV1SnpFMWpZWWJwL0haUFJHeURzdE91UCtYUC85akQwVFpkQkRm?=
 =?utf-8?B?Tm1seFdJL0NvYUpLNjRYU1h5WHhNL0ZZZm5YTTRTRXMyVXI0ZHVTaG1oZXpN?=
 =?utf-8?B?a1MzWWQ4Q2hDaHpKTi9xc1JxUXg2dFExWHFnMCtac0wwcDV0SVJvaFRqdWpK?=
 =?utf-8?B?blBFRGZwOFVJc0p0Yi9JSjJGRjZ1aE5HakdUODh1alp0YjBOMmVST2V1WDBQ?=
 =?utf-8?B?VkZ5dkYxTFBtaFo1UUF2VW9wanMrblFObDUvb1VxaWdGUTdZYlhmYVRLbTNn?=
 =?utf-8?B?cGR0MWlnS2ZnTzczMnFvbGF6ekVTMU9iZElkYnJOKzd1eDFuOFNZSi8xL2Nr?=
 =?utf-8?B?WDl4RWRNZ1MxaS84TkRhSHRydks4SE0vaWZKNmJoaFhrYVpXWG9XZS9VNVFj?=
 =?utf-8?B?dWsxUDRBU244T21QSmpPR0dBR2FsTU5GcFVtQTJCS1ZtNGZIK1pYMGh3ZUly?=
 =?utf-8?Q?Z0kA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9e6c13-ac96-4c86-2f61-08dbae305c36
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 16:51:33.4037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZKFu6xRgJy/+hUUPuNb+FYJksb2Yv9lrHRqz6Kw7Is8L2xUIMBbCKS6R87MiKKh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 9/1/23 12:57, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/1/2023 10:28 AM, Moger, Babu wrote:
>> On 8/31/23 19:43, Reinette Chatre wrote:
>>> On 8/31/2023 4:58 PM, Moger, Babu wrote:
>>>> @@ -3336,6 +3340,9 @@ static int mkdir_rdt_prepare(struct kernfs_node
>>>> *parent_kn,
>>>>         else
>>>>                 files = RFTYPE_BASE | RFTYPE_MON;
>>>>
>>>> +       if (rdt_mon_capable)
>>>> +               files |= RFTYPE_MON;
>>>> +
>>>
>>> Is this not redundant considering what just happened a few lines above?
>>
>> Yea. Right. I will change the previous line to
>>
>> files = RFTYPE_BASE;
>>
> 
> This is not clear to me. If I understand correctly this means that
> when rtype == RDTMON_GROUP then files = RFTYPE_BASE?
> This does not sound right to me. I think it would be awkward to to set
> files = RFTYPE_BASE if rtype == RDTMON_GROUP and then later do another
> test using rdt_mon_capable to set the correct flag. It should be possible
> to integrate this better.
> 
> What is needed is:
> When group is a control group:
> 	files = RFTYPE_BASE | RFTYPE_CTRL;
> When group is a monitor group:
> 	files = RFTYPE_BASE | RFTYPE_MON;
> When group is a monitor and control group then:
> 	files = RFTYPE_BASE | RFTYPE_CTRL | RFTYPE_MON;
> 
> How about just moving the "if (rdt_mon_capable)" check into the 
> snippet that sets the flag for a control group?
> 
Sure. Will change it to.

   if (rtype == RDTCTRL_GROUP) {
                files = RFTYPE_BASE | RFTYPE_CTRL;
                if (rdt_mon_capable)
                        files |= RFTYPE_MON;
   } else {
                files = RFTYPE_BASE | RFTYPE_MON;
   }


thanks
Babu

