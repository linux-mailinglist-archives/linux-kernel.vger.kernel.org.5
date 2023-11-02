Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5DF7DF7E0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377095AbjKBQnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376923AbjKBQnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:43:20 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2086.outbound.protection.outlook.com [40.107.249.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7288713D;
        Thu,  2 Nov 2023 09:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pk2OiIi3v67YVvswzn6qGebhYwA7XTF0smv7mTiQRpIK099jDYzDraEeMa6E/FmB6/2D7/EBF7WYYcOexnLurmMWckdwBBHtjIznZ7VsuU5bGVDzqfztDaoQNWxWdLBTeuWg1prvLmF7KEwDT2d0E9hqBL48C/gA9v4cPtXdCUxP8fSNrynsDiJk9ZeyBa50HTZksKONLjCL1necdjjqB5C0MKN3ZbtJC+Y4Pjrtp5GcBDgM7F5F424wBL6a7e3DJ0DAe4+ba9xctzrDAzsKD4JCVTlgpK0YDE8tw8YoRtAAxcvnEsJJyPl1zQjMqHg6AoZcFdEBt/YITJyOXsuSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQemWVaiMfXTEYU1dlBtmjhiCFfuE/zNR/zhIp4cco8=;
 b=h13MjJp2OkZ3InTI7Km0nVJ02YkBcvgRwqN5p0F2bNbwCe/VjdwBVpSgr69wgnN02xmqYyTSaxQJDKqpvVQUKuresDwIzZBisbKrH6xc28LzsbqHi95RGtgXqyD3NHmDpgHnQZn0rO9ZyS4qpx5W31/JB2vtGwjHcBDVq8VzEAmlU5kUBrwMABN3z3untshceA4AKRpnYQ38q+niK3KAx0ql5K8bSCkWi3YPI7KUW6OTAGD8VpgS9DkYNqgTNg2vISINGEKPhb+J5Pb2SIZ0JMaSVQs2Kh56xQ9qDj1iMlD4A5IE/wt3GHm0GNF0RGD6zwgQkAaoIIOiqMojZuZR9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQemWVaiMfXTEYU1dlBtmjhiCFfuE/zNR/zhIp4cco8=;
 b=i4V7MdepfBYQqZFiIzSPTeiulUNsALRQSDQzfwm/cM1SDBiofu4EIOzyeLBvG7Od0Cz2ORpNkWeTvnXV4t9g0GT8ORBl5g8DjLBTEmDiDbC5W+Y3yVDl+Jb3Y+/7ZtOqWbgPh6LDB1U+IianfBlr0B75eBYiZbb9WeszjxAtMYFRBlgJjXNZtdKyrNmMphkrEb0cUt76uhUs075pku24Fo1cJU/7SBaTbM5KyWWaAJrer4gay/idplrP2bNkuEFuLWQCHOgKhVX9JGAuKWPe8ezwd5ldkNUVpfS7d8GNG2IrJYeP2Ie95AkXD7t4bh4R2SQn1SSfmZZoMy8SS9ikkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5537.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Thu, 2 Nov
 2023 16:43:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d%4]) with mapi id 15.20.6954.020; Thu, 2 Nov 2023
 16:43:11 +0000
Message-ID: <106f3a36-16d8-4272-ad7a-287e6a3acfb5@siemens.com>
Date:   Thu, 2 Nov 2023 17:43:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] remoteproc: k3-r5: Add support for IPC-only mode
 for all R5Fs
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suman Anna <s-anna@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hari Nagalla <hnagalla@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nishanth Menon <nm@ti.com>,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
References: <20220213201246.25952-1-s-anna@ti.com>
 <20220213201246.25952-4-s-anna@ti.com>
 <e0bc7eb5-f1b9-4e99-a39f-ca6f31daa9d8@siemens.com> <ZUPDrlVLkDDgJpWm@p14s>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <ZUPDrlVLkDDgJpWm@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5537:EE_
X-MS-Office365-Filtering-Correlation-Id: 0414de0c-86ff-4cc2-7508-08dbdbc2ccf0
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VIEVqvoG5dzGuF+Pnc+rli6okkgHGEfWf1mYIebEFmEe319o6/mYQWAoc2pD0/6A+4AqCSxzQKaCq/ZDvQ+aCfkn0+xOuBcp3GysH47IpfQVcjHyoRcM565B+vqPGRuFnwk3KrPS7fhyMP9Gt1oI8FS75ZiRwoIdjnwF70T3n67O8Jnaygxs8WftocrSV1XXZBB2vBQYOTA1ujl7CE4dHw7aFCX3+XVkNnjAy+eej3gvMml//OJ6ScqwGu/DP0+L2IPZ7lXerLhy6EjACXV09ih+/LwdKFDUVYnbey7Qz2nqEocVQ+2oh87jrMEyaxbayoJf1iECNsSnqk06vRSrS0ghCeBj2SPjzccqg2sA20WEdQHGWVHEcACtpK6mlbRred936bxjTk5mb77zdE50/KqqTGDRFmNS1WHL/DPUFu01TjjqQzzIa3xDKrMEspXm2U/6f8v+GIGqgOnvArTCatnpSrtu4e5pop9Ceaztc+bSHouxz1oNuHy4mtPvEaTwjh0Pw/9qr/qTfoUS2fDKSyaXi8gjb9ygICtHAYgvfCY7ZdGYq/qbaRBDBSKVwgIhVv8M05+K6gy+HVMGtFC5wB0xX4vq3CqaZ4Q3c28vDYcyKB/ogcFdwX83Im/hseyVOgay7gpDlxYxfL9t5IL3RCnepzZ/5UlzMhGXuzRuFj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(5660300002)(41300700001)(2906002)(45080400002)(8936002)(44832011)(54906003)(66946007)(66556008)(6486002)(966005)(8676002)(4326008)(66476007)(6916009)(316002)(478600001)(83380400001)(38100700002)(107886003)(86362001)(53546011)(36756003)(31696002)(82960400001)(6506007)(6666004)(6512007)(26005)(31686004)(2616005)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGc5aXBmam16T0RZNWlqNlYrVXNMTmlQTU5qaHJWOGFZa2ZiZlNhWGdtb2c1?=
 =?utf-8?B?MEZDck9QT1g1cERGd01DUDkwTlducFo4Z0ZXR000cTJMM2V0N3hNYlpNT2pH?=
 =?utf-8?B?UjBmNHRkTFJJYit1Ylg4THBPNjdQKzk1K3pNWWF5cFFmZGJZTkhVbmVqRWNT?=
 =?utf-8?B?NEpQSVRoQitaS01RR0JHVU1WSGVsS3dSNmpqWkRoTjJkWFBVcStqelFETGs2?=
 =?utf-8?B?TkwyYWlqQVFjb1N5N3liRmY5eWlTT3Rnd0RYdUVjT2hzU3hIRklIdlVnNFJC?=
 =?utf-8?B?TXY1LzZIWUQ4SDR0RE9GSlpwM3hwcFozT2VrQ2lxZlJyRmQyUkVIWlZ0OGVO?=
 =?utf-8?B?NU9KZHhUdnQ5U3c1aWcyRVIxaDlPZmZXdjB6WFROalNWQS9JWHlkaFNFYTZl?=
 =?utf-8?B?YVZxVXAvWS9oSktTNEc1NlgzQjRSc0V1TGFHRTBNUTlhUWRWaFczT3pSb2RG?=
 =?utf-8?B?TDhnaGMvNHVNRjhlZVc3TThGSGhWY2I4ZE5XNGcvc3NrS2phQjVxNi8vbnUz?=
 =?utf-8?B?Wkt4c2JnQ1JQSGVndkw3dmZKRmpPeEVxN0NvR3NBcUJNaFZneFBMaHMvWHpM?=
 =?utf-8?B?elBqTGFTMkNuTU1JeHVxZWRHSS9VeDNIRDZ6dHE0SFltRnBIM1lva1M3Sk5P?=
 =?utf-8?B?UWI4eWo0emNiNElRODltRDNtRzBMaHZvRC90bE1mcTZRSktsYUFaenZMblNO?=
 =?utf-8?B?VStrcjExb1l2S1VjdXk4NkN6VWppeUVFekJTbUdQUjRzcUY4NHFjWHc2d1Vh?=
 =?utf-8?B?OFdSbklxUkk2NUg4TFphU1hWdU9nbUxBYS96dXM4cG9XME1DR3FldDErVUNY?=
 =?utf-8?B?bFJHZS83R2VuZ1NjM2FuTUVFU1EvMTc2T3cvZVBuVkl3a3huS1d6MDU1WlJV?=
 =?utf-8?B?YnZlbm1qQXJkYlV5bkFnQ2NmTzJkVGdaeTJGL2lhaTMwRGhxampnSVZOaUdm?=
 =?utf-8?B?YWZSZjdrcFdKQWVWd0QraGxJdDBUOVFrMHZBMHNTYU11TFYwcmNYQXlOaWoz?=
 =?utf-8?B?bVcybkhUUUJ1VE52YUlLT0grQ25QSUJKcUFuZEpWeHUzRnFTckxMUzZjVTJW?=
 =?utf-8?B?YVNZdW95RTV4ZFhma2tScCtnWU5JcFptRWdCb2FqKzZWQzkrZVJZSG9mTm1m?=
 =?utf-8?B?OE5RTHdCTDRYd2ZKdUFjeVZGaElEQU41OWRCSkVEeHh4eWo0Y2NxdTh1ZjB0?=
 =?utf-8?B?SlR3bTBFaGh4dnhGQllxWDl4anpFdGgraTBUZnpXb0R2aFdpVmV1WmNpYXZC?=
 =?utf-8?B?em1mZGxFZTJNaE5ZWXZ5QWNhMTJyOFBmYmtXTFBtSHlFMzNPT2NBcEtaU0xa?=
 =?utf-8?B?eWtLa25mZnQ3SGtGL3Y5N0c1VXQ5b1oxUkw1VkVHdGNiVElmTkN4L3c5U2xr?=
 =?utf-8?B?bWhlVkNQVXM0REN1L2V3dkYxOUVWM250cnlYa1BpeWcvVGg4QW5HTFFRcTBP?=
 =?utf-8?B?RHV5VnBhV0JNNVBJOVJ0SmN1Z28zOHpJQlRYT21UL1oxZ0xmWTdzWVVXZ002?=
 =?utf-8?B?d3pWd2srWmdYTENqSkt5ajlyWDJsUWtBNWxBSVdQVi9OVEpQME1udFVGVnhr?=
 =?utf-8?B?L2xLRTl0VlFNUzlDeitKVWh1WmhXTXYwS1pwWkhtMzBhbXVUZlZKcENCcW9V?=
 =?utf-8?B?RWdYU2ZqQUpnTmFyck1FWktzNFg1U3BRYjJJekkxdEM3c0M4THpGbkxPOHE1?=
 =?utf-8?B?ZWZKSlQ1bEdMYi9SL0RZVW5pTVZBRlNIMytiamc2SGRwQnRCemJNTTRDQ09x?=
 =?utf-8?B?TGJtd3IxSEQ1WDNITGZIUkRLaFJJcEUxMUFVZUp2bDdLRWgyKzJsb1VQUnFL?=
 =?utf-8?B?WGdSVVBmeVREWTZPRWpOeDBnVGJPQlhjY0txWmNsUzZKTndpdVpwMk5HMHpH?=
 =?utf-8?B?U0RsWmRtNjlMSjlwMEJtUDFJRjJYTzAxT1BoVXlIdWFSRjFQRVlFVGNiWDdS?=
 =?utf-8?B?bk55clBHa082TjZZQkpGc3VaN3h2MVFDZHVBU1hWZzVIT3pDbk1tYzBIMDBm?=
 =?utf-8?B?enhZVW5MN05laGxENFlaWmJkMG14c3NuZXNwaE5JMUZPUGR4NzdIQlFpVlBQ?=
 =?utf-8?B?QmkvTWoyYWI3U0NJeU82M24rbGJyc0pmQW04bUhBeXp1NHl5dWYwZmxBV0l3?=
 =?utf-8?B?d3FuQUVTUjlPMGdiY2t2K2svY2NGaFZoOXpkNk9mLzhyUHVWblgxTWROWWxI?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0414de0c-86ff-4cc2-7508-08dbdbc2ccf0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 16:43:11.2881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFGuEF+B6/HnDewPdbmzeDwdMla25heJbXPkfUuB4iv5VdR4NRfN9AcwARLab+/PqnktK5/R++MX93OjtwGunw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5537
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.11.23 16:43, Mathieu Poirier wrote:
> Hi Jan,
> 
> On Thu, Nov 02, 2023 at 11:07:45AM +0100, Jan Kiszka wrote:
>> On 13.02.22 21:12, Suman Anna wrote:
>>> Add support to the K3 R5F remoteproc driver to configure all the R5F
>>> cores to be either in IPC-only mode or the traditional remoteproc mode.
>>> The IPC-only mode expects that the remote processors are already booted
>>> by the bootloader, and only performs the minimum steps required to
>>> initialize and deinitialize the virtio IPC transports. The remoteproc
>>> mode allows the kernel remoteproc driver to do the regular load and
>>> boot and other device management operations for a R5F core.
>>>
>>> The IPC-only mode for a R5F core is detected and configured at driver
>>> probe time by querying the System Firmware for the R5F power and reset
>>> state and/or status and making sure that the R5F core is indeed started
>>> by the bootloaders, otherwise the device is configured for remoteproc
>>> mode.
>>>
>>> Support for IPC-only mode is achieved through .attach(), .detach() and
>>> .get_loaded_rsc_table() callback ops and zeroing out the regular rproc
>>> ops .prepare(), .unprepare(), .start() and .stop(). The resource table
>>> follows a design-by-contract approach and is expected to be at the base
>>> of the DDR firmware region reserved for each remoteproc, it is mostly
>>> expected to contain only the virtio device and trace resource entries.
>>>
>>> NOTE:
>>> The driver cannot configure a R5F core for remoteproc mode by any
>>> means without rebooting the kernel if that R5F core has been started
>>> by a bootloader. This is the current desired behavior and can be
>>> enhanced in the future if the feature is needed.
>>>
>>
>> This change surfaced some complex issue in the K3 core: Turning on the
>> RTI1 watchdog also powers up R5F core 1. And this could happen either in
> 
> When writing "... also powers up...", other than R5F core 1, what else is being
> powered?

Would be a question for the SoC vendor - I assumed that only mcu_rti1
[1] goes on when enabling it. But also mcu_r5fss0_core1 is enabled after
that, at least according to the respective TI-SCI query that the is_on
handler is performing. I've tested that under Linux and in U-Boot.

> 
>> U-Boot or in the kernel. If the kernel finds the core running, it also
>> expects a resource table in the reserved RAM. But as the core is
>> supposed to start via remoteproc, there is none, rather often garbage.
>> Sometimes, a consistency check catches that, but not always:
>>
> 
> If I understand correct and strictly addressing the Linux case, the R5F is
> configured to operate in split mode and both cores are off.  An RTI1 watchdog
> happens, which has the side effect of turning on core 1.  At some later time core
> 1 is turned on from the sysfs interface, the remoteproc driver recognizes that
> it is already powered and as such enacts the "attach" scenario.  That leads to a
> crash because the resource table hasn't been loaded into memory.
> 
> Is this a proper description?

Almost: The watchdog device (rti_wdt [2]) is probed before
k3-r5-remoteproc. This comes with powering up rti1, and that turns on R5
core 1 as well. There is no watchdog fired.

After that, the k3-r5 driver probes the available cores, finds the
second one enabled, and goes down the IPC-only road for it.

> 
>> [   38.372844] remoteproc remoteproc18: 41000000.r5f is available
>> [   38.380324] platform 41400000.r5f: R5F core may have been powered on by a different host, programmed state (0) != actual state (1)
>> [   38.394910] platform 41400000.r5f: configured R5F for IPC-only mode
>> [   38.401941] platform 41400000.r5f: assigned reserved memory node r5f-dma-memory@a1000000
>> [   38.476997] remoteproc remoteproc19: 41400000.r5f is available
>> [   38.484661] remoteproc remoteproc19: attaching to 41400000.r5f
>> [   38.491092] Unable to handle kernel paging request at virtual address ffff80000dffffff
>> [   38.503704] Mem abort info:
>> [   38.509760]   ESR = 0x0000000096000007
>> [   38.514071]   EC = 0x25: DABT (current EL), IL = 32 bits
>> [   38.519578]   SET = 0, FnV = 0
>> [   38.523095]   EA = 0, S1PTW = 0
>> [   38.526355]   FSC = 0x07: level 3 translation fault
>> [   38.528974] cal 6f03000.cal: Neither port is configured, no point in staying up
>> [   38.531775] Data abort info:
>> [   38.541866]   ISV = 0, ISS = 0x00000007
>> [   38.545765]   CM = 0, WnR = 0
>> [   38.548814] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000082fdc000
>> [   38.555831] [ffff80000dffffff] pgd=10000008fffff003, p4d=10000008fffff003, pud=10000008ffffe003, pmd=1000000886609003, pte=0000000000000000
>> [   38.568623] remoteproc remoteproc18: powering up 41000000.r5f
>> [   38.569338] Internal error: Oops: 0000000096000007 [#1] PREEMPT SMP
>> [   38.574440] remoteproc remoteproc18: Booting fw image am65x-mcu-r5f0_0-fw, size 932
>> [   38.580644] Modules linked in: usbserial ti_cal videobuf2_dma_contig ti_k3_r5_remoteproc(+) videobuf2_memops pci_endpoint_test videobuf2_v4l2 rti_wdt watchdog videobuf2_common at24 st_lsm6dsx_i2c(+) optee_rng st_lsm6dsx kfifo_buf pm16d17 rng_core tee_stmm_efi tpm_ftpm_tee fuse dm_mod ip_tables x_tables ipv6
>> [   38.589862] remoteproc remoteproc18: remote processor 41000000.r5f is now up
>> [   38.615533] CPU: 1 PID: 283 Comm: (udev-worker) Not tainted 6.1.54-cip6 #1
>> [   38.615546] Hardware name: SIMATIC IOT2050 Advanced PG2 (DT)
>> [   38.615553] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [   38.641945] pc : rproc_handle_resources.constprop.0+0x8c/0x164
>> [   38.647788] lr : rproc_boot+0x2fc/0x57c
>> [   38.651628] sp : ffff800009d53740
>> [   38.654934] x29: ffff800009d53740 x28: ffff00087f7d77f8 x27: ffff0008048f4c10
>> [   38.662068] x26: 0000000000000001 x25: ffffffffffffffff x24: ffff80000e000000
>> [   38.669199] x23: ffff00080227e038 x22: 0000000000000000 x21: ffff8000092bb1b0
>> [   38.676333] x20: ffff00080227e000 x19: 0000000000000000 x18: 000000000000028e
>> [   38.683464] x17: 0000000000000000 x16: 000000006d958cac x15: ffffffffffffffff
>> [   38.690597] x14: ffffffffffffffff x13: ffffffffffffffff x12: ffffffffffffffff
>> [   38.697728] x11: ffffffffffffffff x10: ffffffffffffffff x9 : ffffffffbfffffff
>> [   38.704862] x8 : ffffffffffffffff x7 : fffffdffffffffff x6 : ffffffffffdfffff
>> [   38.711994] x5 : ffff000802be1f00 x4 : ffff80000e000100 x3 : 00000000000000fd
>> [   38.719127] x2 : 00000000ffffffff x1 : ffff80000e000003 x0 : ffff80000e000000
>> [   38.726260] Call trace:
>> [   38.728703]  rproc_handle_resources.constprop.0+0x8c/0x164
>> [   38.734196]  rproc_boot+0x2fc/0x57c
>> [   38.737689]  rproc_add+0xcc/0x16c
>> [   38.741004]  k3_r5_probe+0x44c/0xe14 [ti_k3_r5_remoteproc]
>> [   38.746501]  platform_probe+0x68/0xc0
>> [   38.750168]  really_probe+0xbc/0x2dc
>> [   38.753742]  __driver_probe_device+0x78/0x114
>> [   38.758099]  driver_probe_device+0xd8/0x15c
>> [   38.762282]  __driver_attach+0x94/0x19c
>> [   38.766119]  bus_for_each_dev+0x74/0xd0
>> [   38.769954]  driver_attach+0x24/0x30
>> [   38.773529]  bus_add_driver+0x154/0x20c
>> [   38.777363]  driver_register+0x78/0x130
>> [   38.781198]  __platform_driver_register+0x28/0x34
>> [   38.785901]  k3_r5_rproc_driver_init+0x20/0x1000 [ti_k3_r5_remoteproc]
>> [   38.792437]  do_one_initcall+0x64/0x1dc
>> [   38.796272]  do_init_module+0x48/0x1d0
>> [   38.800023]  load_module+0x185c/0x1cc4
>> [   38.803770]  __do_sys_finit_module+0xa8/0xfc
>> [   38.808040]  __arm64_sys_finit_module+0x20/0x30
>> [   38.812571]  invoke_syscall+0x48/0x114
>> [   38.816320]  el0_svc_common.constprop.0+0xcc/0xec
>> [   38.821053]  do_el0_svc+0x2c/0xd0
>> [   38.821077]  el0_svc+0x2c/0x84
>> [   38.821095]  el0t_64_sync_handler+0xf4/0x120
>> [   38.831698]  el0t_64_sync+0x18c/0x190
>>
>> (this crash was with a stable kernel, but same issue with head of tree)
>>
> 
> Right, stable or head the result would be the same.
> 
>> This raises several questions:
>>  - Is it a hardware property that RTI1 powers up core 1 as well?
> 
> I will leave that question to the TI guys.
> 
>>  - If so, how can we use both watchdog and remoteproc so that the latter
>>    loads the firmware for the former? We are currently doing that from 
>>    U-Boot, but what if that is not desired? Should the watchdog driver 
>>    take care to not leave core 1 in a different power state behind?
> 
> Making sure core1 is turned off by the watchdog driver is a solution but based
> on how the HW is behaving and when the interrupt service routine runs, there
> may be a race condition when core1 is genuinely enabled.

Yes, that worries me as well. In Linux, watchdog and the R5 cores have
no explicit dependency, although you need a firmware on the cores so
that the watchdog event is handled (it does not trigger a hw reset
directly, sadly, that's why there is [3] eg.). That could also cause
probing to happen in parallel, in theory.

> 
>>  - Can and should we do more while parsing the resource table to prevent
>>    such crashes?
>>
> 
> That's a tricky question.  The kernel's firmware subsystem ensures the validity
> of the ELF image by looking at the image's magic number.  But for the attach()
> case only the address of the resource table is provided, and that resource table
> doesn't have a magic number.  As such I am not sure that is it possible to parse
> the resource table that is provided while keeping things generic.  That said,
> I'm open to ideas.
> 
> Since this is a platform problem I think the checks need to happen in
> k3_r5_get_loaded_rsc_table().  I can't advise on what those should be since I do
> not have the HW.

Sure, thanks nevertheless.

Jan

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi?h=v6.6#n432
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/watchdog/rti_wdt.c?h=v6.6
[3] https://github.com/siemens/k3-rti-wdt

-- 
Siemens AG, Technology
Linux Expert Center

