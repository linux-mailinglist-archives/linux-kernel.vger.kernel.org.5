Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D860800CF9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379127AbjLAORe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379094AbjLAORd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:17:33 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04A219E;
        Fri,  1 Dec 2023 06:17:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcNSxSJ5v/yfo8sS6g02EHWobqqjOeNJfsXQBXlssjKhau+MF81Mcz2iOOmVYmmqJ7FTShAmmQt0spxqsrYBBf1reubxJC2i1iVcfldzeVLYAOsSVTk1sDvUedVjv1ThEUbieLFgSwDvzb4f/HUJY+BI+9d4132GDAEtO72iIW+ikGCNRfyRf1zk2TtCSnLClVInmMRtg4w09SWOTN/+bX+FvD1glkIUbFEUKw8u2ClpW8FPLuQbFdb7vkk6DJ8WWyzsYYgXFrVu0ybfDmTBxxYUK95PPb7FhT6Eqew2YlJ3R5RCfrYSvHr1b2vm8Gm2nRYNdjJwVzJ7+weCQ97/Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBtjaUycuZKkjOBlFjz90bCEjlOihqLw87m93ukWmMU=;
 b=F+vgl/+12NYe7Zedo/YPbtxP5WIpRxERFT2WmdNDyILH1lsCmlNif/rrekROZhdDEHfXznujYvrLFIFz1cLEAWrc78IdwirMRzoDWUaHG70U4xmhGBVjsK+OPWEuXTU67JGwamgTOjWDQ5KpMsmhNAb9VcdRTzuz0q1oYuELsBeQAngo9W1rGirxqZ+VLWzXC+ijlwVwfkM6Q/omHxnFtg8aQg4cULhkdKyTesRGlsS5hWRXWxjygkFjGuM2j1azyL4d25u1K0EFDU3llHMq8ukmVwLd1Z6C5VdVcaD8wEfq6qmqnOJOAoX8Ib2fbsjd9TBMIKuFXggUsVvfKpSYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBtjaUycuZKkjOBlFjz90bCEjlOihqLw87m93ukWmMU=;
 b=QewQry+FuTQrNJzSKLD8Tnpe0Ot3T8f6xcwGRQUWQER2CBxUBkJ4l7n0T5AHfSFdczhKpWhU71SdAUWDKR4ejJ6AjysAizHDvaEgy1qakM9VqqN3I5gYaF+qUNeJMAmgxpDrqjDviKlR5DHu7lHQSpfGHyRRUBfXu/IlTzgXGUNMEB/IiPQRAY08JEFfO2StB+BTtkHA4yaTRcEkDnufRSAvIXKJ0onR7/TEOdNGcdex+8sUfrFBaa6lU5t2dGC760cfaXNSRZPqYrrKB+K05fHumpqCZqzsqxojRyVERwj87swX7M148zo7SfOqPXAspPwlNHQNATKpx78krx7xXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by AS1PR04MB9239.eurprd04.prod.outlook.com
 (2603:10a6:20b:4c5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.16; Fri, 1 Dec
 2023 14:17:36 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14c8:fc35:a9ae:9c9d]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14c8:fc35:a9ae:9c9d%4]) with mapi id 15.20.7068.016; Fri, 1 Dec 2023
 14:17:36 +0000
Message-ID: <d404113e-4ffe-4e9c-ab45-1b076c1f498c@suse.com>
Date:   Fri, 1 Dec 2023 15:17:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tracing: Simplify and fix "buffered event"
 synchronization
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        zhengyejian1@huawei.com, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231127151248.7232-1-petr.pavlu@suse.com>
 <20231127151248.7232-2-petr.pavlu@suse.com>
 <20231127124130.1041ffd4@gandalf.local.home>
 <77037ca1-8116-4bc6-b286-67059db0848e@suse.com>
 <20231128102748.23328618@gandalf.local.home>
 <bb6c9771-1a7c-4367-bb14-63524d9c560a@suse.com>
 <20231129095826.1aec6381@gandalf.local.home>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20231129095826.1aec6381@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0293.eurprd07.prod.outlook.com
 (2603:10a6:800:130::21) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|AS1PR04MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: 02454c2a-d8bd-49bd-b942-08dbf278449d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YVnzD3MK3GHNxKAtcEjYTOyIqZHH0SYaBEnYQVRwN0NgkqymAJ2OkkI6uBIMi3f5GrY8DEeDHpHDmWOTPOmbHlHlIHASuFZLxzOLE3mXdSjWEmdXi0fjCg42DezI0LmwEydG+h7Ypimnb3rX2yL7ZxNY6EhtJdBaaXddPf/xqU3vK/ZjA3S4N0DTCOxe10DVPCX8DvbyAlhDcuWJuCLgupN+fSGb8YwSGGlI9QXgnke9ZN6oBXBExyU0fuEHQlTtlkEnHgaEo3cuFEPOnbH13d8ApnQSqNE89qaBJRr35IN+P3RN7Ax2BEAvUNqKXJUvEpHerJFmIi7LLVenHx36s3utLnz+mxTu75VdusGTcCUaaJCi4H/3L/VG7GG1z+IoGoS7bUNi1SIVp4yDLq9xOPJCikV4S2b36XyHyHMXtarYVo7BTzyMs0Seh082SvtmHX04XjEgbbGi7L6mUiWw7jr1Z/BsjITsbDEM9mg89g16ZgAlgqBiA6CMKeP+46EAo/eIz0aeXbuTNRj4Yj2aIjRcLxXseJwERmgNVV0adwA1VLER8zWi08WAHUTgzxOGLui/xSN7tFBJsdJPDvcegqZVOFMC3AcfpEVGyFRfgY/hm0PPpPBpcpGz+iVaTmuiL2XMknAG6354XEF0sFMylQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(396003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(8936002)(4326008)(6486002)(6512007)(2616005)(26005)(31696002)(86362001)(508600001)(8676002)(55236004)(6506007)(53546011)(6916009)(66476007)(31686004)(66946007)(83380400001)(316002)(66556008)(44832011)(5660300002)(2906002)(66899024)(38100700002)(41300700001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVV3Mkd3R2UwNmhPcFdXcjhQVnpYZ3FmY1hCTmd0cFZ2YVRMYXpjdEVDRjFl?=
 =?utf-8?B?NW9qK25tYktlWjJIYzJYNUlHMlVKNHlKbWhXTkRFWEY1K08wc0kwWnFwS2gr?=
 =?utf-8?B?SDBaRk9Oby9qUDhHa0Z0U2FrbkhHczRGMzJiWkRoS2oycTlNam9IQ3RXbnNL?=
 =?utf-8?B?QXZmKzNFeVJ3TGJwYVFERHVINFFTVldVQnhtVHZtUnJNcXVnQjlRd2doOEtO?=
 =?utf-8?B?UlNHdUovbzU3MVFZcU9nSkF5aTN0ZW9tVUhNS3IzQzhUYnYvZXlxRUlmV0FE?=
 =?utf-8?B?Qm50ZG9QV0NQdWdoYW1rWmVTRnF0NTZ5VFZicnI5WTZWUVNsemVzQ25zRFlN?=
 =?utf-8?B?elQ4OXRzbVQwbjZLbThmd09oQmJiS3lpRTZnSS9weUk4bk9HaVRPY3lvZ3FU?=
 =?utf-8?B?Z0p1bE1ESVk0VXVNWldpeFh6bll6OHRYcGpSN0M1ZFV0d2tKV3FhMmlJeXFy?=
 =?utf-8?B?VW10VGdGay82THh4OG1NeHJidWFHSzZWRTBjUzIrOExoMHRwTDNmeDhpdmtq?=
 =?utf-8?B?Z21IVGNGVGlXN1dhZVNBYzkrUnFrb0JuV0VPYUdZYmRSVmZIUVdtaUxMWGVO?=
 =?utf-8?B?VjdMUXgwcTZnLzVQZjVCMXNLWmRZcXdGMkRCdm52VS9aYzdabnVsNU1VaGFN?=
 =?utf-8?B?NUhhd0lJYVFkVW5IMWt6VGE2UnhsZ0hRM3RUVzJvVDM2eHppSE5vaDBXYUFs?=
 =?utf-8?B?YUxVKzlSYVBBa2RKTWxXQzBKZDRyenRVQkNVRmNNZHdEcDhNbDRHb2R3QmhY?=
 =?utf-8?B?RGVjU1pqMlJ5SjRrNHM4OUUxVmpHZFFmRVk0bXMvVGtTaEk1ajQvaHh0VmFW?=
 =?utf-8?B?ZkcvT2VsYTBtZVZ1K3hxK2x0dHo1N3NIbVN5ODkwcGxBeUxUQTcvMnpVZlBk?=
 =?utf-8?B?djhaRkhVa3owM3R6cVpzQUFzdlByZnRMc3BZaVY4RUh0WVdxbFlIVm8rU25R?=
 =?utf-8?B?WVoybUFtdVNmTnVaQlRpOXBqK0pYZ3Z6cDBPVnBSNzNoTE51Wmh4LzRaUUNa?=
 =?utf-8?B?R3dsNi9ERnJOZkQyN280bnFJS1JYVnlWZ0JPZHdjQ05abE41RnpqWk5PNXhu?=
 =?utf-8?B?T3FCSzRzNVNpRjc2SDlTNG8wOVk4NU1DaXdCcGpwcU1jK0ExUkM0eTdHOUNU?=
 =?utf-8?B?T1VYbmp2WVhkcGx4Nm8yNFMweFRwZkwwM1dSQnh2K2pjQ3A2eUhBRnoxb1Nz?=
 =?utf-8?B?WEtyY1I3WWI4dXo4a2dLdmE3ajltMEI2ZDVOZ3pXOWxsNmoySnhHSkJ1V3lB?=
 =?utf-8?B?REI2b2dXL1liTW9mVUxzV0lQYlBFL2VVQ0FrVW41aEVhREJNdkIySS9MQlcv?=
 =?utf-8?B?cG13SnB1MHFuK1RvcVhmMWs2M0I4aUFwdDJ2Z3ZSYk1JeldjT2NaMzM5Q2J1?=
 =?utf-8?B?SW05Z0VKczFMTXEzMnNCK2dBM2xmb2xIV0tLU2RnODdvb0lGSFY0NjN3L3Vq?=
 =?utf-8?B?b0xJbWFmcVdWaGtjYTJUc1JkRlhSRGkvRVQvNUdwaVlvMXQrc1U0UDcwN0Vx?=
 =?utf-8?B?N3VINTRramJzdys1cW1KVzZOdGR3WTA1VmZ1ZURkOFBYeFMvcXZnM0M2V3Iz?=
 =?utf-8?B?a3Rnek9oem1Vdk54ditQdkZYdVFvZXJQMWdKa1VQaFJlZHBwZ21zVTBmUFJG?=
 =?utf-8?B?QW5pd3FzOVJLMTBYdjk3cWxJVS9sbWdicHM3TldPbnlqUWlpQUJNTklua3lh?=
 =?utf-8?B?VlJ1aXhvVzZ2OXNMLzJhaTBuMVhTclphNS9yUEIzVXZ6SW9hTkVIVEZKdFBx?=
 =?utf-8?B?NVdLcWdSR1ZHTU01UHJWdzVlNUJxKzlseFErektmWEI2UUNHUk1LS0s4VWVG?=
 =?utf-8?B?Z2piQi9LMVVGVzExM21uMjNQQXEzWGJPM1BseWowZHFtRzU5UHl2VVkrVmJ6?=
 =?utf-8?B?SXJFYml4d0prUjhnSUkxNngreFBmdHpKOTRxcVlxa09FSjhyTWt1MllhV0RU?=
 =?utf-8?B?NjR1RTMyRS9qOWx2NDJhTWlwSFJWSWZ0YXBkb21kT3IyMHoyZ1RDU1VXb3pq?=
 =?utf-8?B?Z1RIc2g1d001TFZ0bjJlaWVJbVU5czZ1M0ViWnE4SWp0L0d3QjZwZkhpcFNB?=
 =?utf-8?B?QXVEWlYya1AvNHBjeWdhYW8wT2FJYmNHdEdxUmtscXZKZ1JEc2V6Z3BReEhX?=
 =?utf-8?Q?j4PHZwkh524OBWNLTWIXSd4Zw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02454c2a-d8bd-49bd-b942-08dbf278449d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 14:17:36.6152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8O7TjU/wBgzQJ012ZpKQdnhOrg4/r6gY8wqmxIxYtpz2hUVt6MAfgNyzx/4/mgDfWbEaOdUj7SSCZ5egj58NRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9239
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/23 15:58, Steven Rostedt wrote:
> On Wed, 29 Nov 2023 10:22:23 +0100
> Petr Pavlu <petr.pavlu@suse.com> wrote:
> 
>> Yes, I believe this should address this potential race condition.
>>
>> An alternative would be instead to update
>> trace_event_buffer_lock_reserve() as follows:
>>
>> 	if (this_cpu_inc_return(trace_buffered_event_cnt) == 1) {
>> 		smp_rmb();
> 
> This is the problem I have with your approach. That smp_rmb() is in the
> highly critical path. On some architectures, this has a significant impact
> on the overhead of this code. This path is called during code execution and
> increases the overhead of the tracing infrastructure.
> 
> If I'm given two solutions where one adds a smp_rmb() to the critical path
> and the other just slows down the non-critical path more, I'll take the
> slow down of non-critical path every time.
> 
>> 		if ((entry = __this_cpu_read(trace_buffered_event))) {
>> 			[...]
>>
>> That saves the synchronize_rcu() call but additionally modifies
>> trace_buffered_event_cnt even if trace_buffered_event is currently NULL.
>>
>> Another alternative is the approach taken by my patch which avoids more
>> RCU work and unnecessary memory modifications.
>>
>> I'd be interested if you could have a look again at what I'm proposing
>> in my patch. I think it simplifies the code while addressing these
>> problems as well. However, if you have reservations about that approach
>> then it is ok, I can fix the found problems individually as discussed.
> 
> Fix this without adding any memory barriers to the critical path, then I'll
> take another look.
> 
> FYI, this code was designed in the first place to avoid adding memory
> barriers in the critical path.

Thank you for the explanation. I ran the tests you mentioned in the
description of commit 0fc1b09ff1ff ("tracing: Use temp buffer when
filtering events") to understand this aspect a bit more. I confirm that
my proposed patch makes the tracing slower, usually by single digit
percentages. I understand this is not welcome. I also realize that the
slowdown might be even worse in different situations and on other
architectures that I checked (arm64, x86_64).

Ok, keeping the current approach, my plan for v2 is to prepare the
following patches:

* Fix for the missing increment+decrement of trace_buffered_event_cnt
  on the current CPU in trace_buffered_event_disable().

  Replace smp_call_function_many() with on_each_cpu_mask() in
  trace_buffered_event_disable(). The on_each_cpu_mask() function has
  also an advantage that it itself disables preemption so doing that can
  be then removed from trace_buffered_event_disable().

* Fix the potential race between trace_buffered_event_enable() and
  trace_event_buffer_lock_reserve() where the latter might already see
  a valid trace_buffered_event pointer but not all initialization yet.

  I think this might be actually best to address by using the same
  maintenance exclusion as is implemented in
  trace_buffered_event_disable(). It would make both maintenance
  operations consistent but for the cost of making the enable operation
  somewhat slower.

* Fix the WARN_ON_ONCE(!trace_buffered_event_ref) issued in
  trace_buffered_event_disable() when trace_buffered_event_enable()
  previously fails.

  Add a variable/flag tracking whether trace_buffered_event is currently
  allocated and use that for driving if a new allocation needs to be
  done when trace_buffered_event_enable() is called, or the buffers
  should be really freed when trace_buffered_event_disable() is invoked.

  Not sure if the mentioned alternative of leaving trace_buffered_event
  partially initialized on failure is preferred instead.

* Fix the potential race between trace_buffered_event_disable() and
  trace_event_buffer_lock_reserve() where the latter might still grab
  a pointer from trace_buffered_event that is being freed.

  Replace smp_wmb() with synchronize_rcu() in
  trace_buffered_event_disable().

Thanks,
Petr
