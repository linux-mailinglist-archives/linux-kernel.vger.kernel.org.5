Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3A87A0747
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbjINO1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjINO1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:27:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B261E3;
        Thu, 14 Sep 2023 07:27:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOd44Zl9Ts4ZC/t1LePKLRyjo5/yH5qC4rxLBr/RqDXIuQ67ReClArQbX43vWDmNNxMsMhmMJ6fWIS6NQbTbjTDQxLmdIpn4ZhxRuRyQJedvzFWWqhRVvXJiqn3mN6eqCbU7R+zhWKT7B+8EgulzvQtRv5hnltQ9ZJEeRn9SdmNH5fQeb5E6NEpo/6ffBMWPMQnUaUrQOrYqjR6wu44D8ZvcgJgADX6riGSo6V+Bh+J2JtaxEHdd9BvaK/pCOvJhnAgCWZUgYR78AX9fG/1sdVWXSgp1yWYjbcTh+2AFCEAoK0BsKm3xmfRtYYtLTa6BxKye5hSPm+3VGx+GThZ2rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VKrebc785JQYZmMOBQ3YwBdw/K2gIRoVuHZjV2tOqU=;
 b=T2Wpl7Cv8JMpX3A2tWnNpIRE6/pMy+G53bSdG81QrmMEABKPXyZ+aFDLzBppcr+kr9ZKtvUwAMH7tDRvTSgunAYiChegYcacnlUdpJJ+OU76EuFcklsb3H0KZlP+h8/MFT7Ih1QIufgDRLLq8zpZX2hscYbL+MvWZTk7oM7Wnv8eeypKZOC6vGrpQVJiOaTsdEVb/mbk7oB1bcMPszZGia0++zddMty/2iuXtD/czUQ5V6N29Sm1K3qOtvXvQ4Uvgbiqay/2x10AtzJNyJoNH/rrk3ZcrOqTZhLi4OIK/Wf59jmAy8p2ZYxylaf3NueMamIlODiuYtRsloY3Z3oDLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VKrebc785JQYZmMOBQ3YwBdw/K2gIRoVuHZjV2tOqU=;
 b=tRz1zFfan6OFPLpFpsKzj7Ir1KVGz+pizZ5iBfMS9UmtSZ/E2mRGsUzfWQCQsHqUAVJ2J3lHDS7OfbyVG53VY2E2TRCF3NXOZxoF6x9rZ+PhtFI5Etn1hNWLh9slGhryrebDa5CORcjUYh4TS82J8xeHH4dXFLjFjbEqlhWY4Gc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 14:27:35 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::a285:eb6e:8fc:7cd7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::a285:eb6e:8fc:7cd7%4]) with mapi id 15.20.6745.035; Thu, 14 Sep 2023
 14:27:35 +0000
Message-ID: <ef8e9420-2f73-4d2c-8161-1000ce5f2fc1@amd.com>
Date:   Thu, 14 Sep 2023 19:57:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: rom 3540f985652f41041e54ee82aa53e7dbd55739ae Mon Sep 17 00:00:00
 2001
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     x86@kernel.org, peterz@infradead.org, leitao@debian.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, leit@fb.com, dcostantino@meta.com,
        jhladky@redhat.com, eranian@google.com, ananth.narayan@amd.com,
        ravi.bangoria@amd.com, santosh.shukla@amd.com
References: <20230914140604.267672-1-sandipan.das@amd.com>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20230914140604.267672-1-sandipan.das@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::26) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|PH7PR12MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: d2bc5294-34fd-4e45-5f6c-08dbb52ebd14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3pW4h1wizXKc7MlfJEG4oX64WCc7alJqDQWGGsiw0jakTvH2eCyo6M2TrQOVPsBcgxfMwhLNvBg1QdtEufh0VW4L8tz0QtdOvWaaEc+xcpR4YTL2o/jtZoYoErDYJsC705s1b0apD+L6BLogD+/OydN/u0gQK2+DM2STlKo9lgOiWg6KnIIE0QV8Uyh1313KxVTXdkmiU+DwACjJhz/EYeU2+6bXzaH3MQ1iimsz54sMToX5wmYIAI/rfAePpK8ywEIzBg/uQrQlwqxcNyUXMUGq+o1hBwh6WRvsyq12a/wRT4P2FK3XS8HWcHD3Py7CfAjkPdiIn4uAntccs7gZmcsks3Pfdh6Rs3qi5rJtYmdme9Go7gUWJ9kJN6F6bkvN6R66AP5DQKobvjUHXJIt8cvICJ2MMLbL+lBMmqUBp4EpkGsToicHY5UVePXa0foHiAi8gzUg8RYFl/SbtfBayXcTX9FrI53b58wFdlwNWOctpMP2+47tGPVSWUkUi7dksKV6dZZdXTE1/VvuGf98nT1iDPv6LPARPU/LAWSRIms/SLas2n1CLWqLLNSVbuA3SP7xE7Vn4vO4MJnvDC8EK8PGU6/8QzJcgtsu0BGRBbFHD7HOm90GDqackqwhhtZUbI3tRljLjKVidaWIes3udA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(186009)(1800799009)(451199024)(31686004)(8676002)(4326008)(8936002)(316002)(66946007)(66476007)(66556008)(4744005)(5660300002)(44832011)(53546011)(41300700001)(36756003)(6506007)(6512007)(26005)(38100700002)(6666004)(7416002)(6486002)(2616005)(478600001)(86362001)(2906002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YktWakx1am4zRlR4Q2dkSi9TL2pSSXo5YU9TQ3dKeVBwTCt2S0tQVWVlZ3p4?=
 =?utf-8?B?THRqQVluR2U3ek9FWHhuTHhMb1NuZlo5anNCK0c1WFU1dG1sMFFqb3MyZnZZ?=
 =?utf-8?B?UHAvRTJ1cEVwb0d5aWVOdUIyRXZWaTh2SVkzZTVSaXhWYUt3Y0NGUTUzaWpE?=
 =?utf-8?B?ZmZGSE0zR1I2VEh6U2xQTnRnY0lHUWIvMDFQTFZOanltOEh2V1FCQ0h2dE9t?=
 =?utf-8?B?MVBtMjJKVjVGZzcvbEN0TWVkZnlRbm5CekhTdFBFUnpuWGI0S2dvcSt1NHVD?=
 =?utf-8?B?REdBUTI2T3NyWG4yaTVTR0JkdDd1UDFBRW1EK0RSUGFuMGt0UnBDS0N1R2Rq?=
 =?utf-8?B?SVAwRnZkbWFQaGVWRVhlNmxwMnljZ0lONXNTajlZMzl3NTdTRTlLQmRLbFpE?=
 =?utf-8?B?aVdiUW1mZklWNm1WTXptMWhWZ0xySnB3RW9tdVBXTDVUcFhqdlNqVDZMb1k0?=
 =?utf-8?B?cXQvN1pSelJXM3gxMm94WUJFRWxpU1VEWlJQMnl0QVFwMFdGTnk4YzNnaVZP?=
 =?utf-8?B?dXBTZWxvU242Tlc3bytVODc0aVkyVFNDekFQQUEyblBPQ2xYR1ArR05JVGJJ?=
 =?utf-8?B?U2JGeXVjRnEyb09STzlTMjVUM0NGWVlkNUJzNGF1UjkzYmdEa0dMMDNFdnYw?=
 =?utf-8?B?cVpzYVRCTmhmU2NqNVU3RWVpWHlyaXkrNzdlMHVFRFhoU2IxL3ZNYmQ4c0FT?=
 =?utf-8?B?Tm5SMUxpc2lOeUdYUEl6YkZYeDFKbW1mWjZqbmFWajBvNmR4bS84MzNVZjht?=
 =?utf-8?B?dGhJTWpNZ0hNQlQvWm5lVDR0R0hjVmx0aDFVamxiVDNNN28vMVI1Zyt4NXh6?=
 =?utf-8?B?OWF5enZwSmY5bklOcEpTWWJqYUFMTDR4TGl5N0hxVE5LV3FyVlNzMkVXWUFo?=
 =?utf-8?B?MlNGYURBQXRRY0xBSU9lckJIUFJQRHBxTVd2cE8rZGcwQlpRRk1JUWo1L3Zy?=
 =?utf-8?B?SE1lejllS2ljSWJtMWFDNmRvTlh1Z1ZjdkxadS9WZEV6M3A1WWZXTDQrTnU3?=
 =?utf-8?B?QThkTGcxZFR1a1Fha0ZuS1RnV1A4TENCeGJTcVR1UkVnbE9PS1d4SG9uV2U5?=
 =?utf-8?B?SU5qbElLbUM3SmdDbXNSMlE0aTBOSTIrdzNTZGxCVUpGT3pDRlkxTUhxRksw?=
 =?utf-8?B?bFRBenNIYnJwRVhrMTBVcnpsck92YW9ENXZET3R4MXdRQ1lOUGk2M2hMLzV2?=
 =?utf-8?B?cm1ER0ZTSnpwVkI1SEhIZXFNWjROTUIvZlBpR090NXlwdzI0WGozRThXbmhB?=
 =?utf-8?B?SlpMdkhLNEZ3M092NnpNaGdIclE4cE9jSHc3cEV6MVdLV3JqUG4xUC93R2c1?=
 =?utf-8?B?Nm9kUy9CUGJtcWdENno3cUJrVzhlaVkzWFNLdktROWVjMWUwUFlHUXA0K3RQ?=
 =?utf-8?B?dlJaWk5RMEYrK253c2g1MFlkUzJzZzRKRmp1KzdjTzZvSEFYWjh4c2Nla1NS?=
 =?utf-8?B?emw2OVo2emdueTZEVFRpeUM5K0NjQzN1RmFoRVB0K3l2WFFHdzJ4clVaWk5y?=
 =?utf-8?B?UWtXeTdLdmNGNUtWL1NFbnRvZmZUOFk5dVdIY1FleHNPRHk4RHppYWhWUHNK?=
 =?utf-8?B?ZnVLT3FwNzJacStqd3VPOHJST24yRmt0dVpGREVZWWNremd2azZZK2ZQQTRp?=
 =?utf-8?B?WGdpQzhxdm1zVDlKZDd4NFdzMjZib3NqVXp1dmRhcTdMOGN0c3VybURodmp0?=
 =?utf-8?B?bEZvZ0lPdUtqTWU0eUVyazhmUmNDbVhwaDR5Z3RvMHBERTV0cG1VS1BxUkVa?=
 =?utf-8?B?c0laVFViMStHMnBXcitxRHlxRDJldDU3Vk91MDdvZzUvQVhuTU5paXRCOTNo?=
 =?utf-8?B?dmloMWJ5b1BWYkREMkQya2JMMld1L3FkZG53RnJRWXR2aVgwUlZtRVZwSW1C?=
 =?utf-8?B?aU5zS01PQzNDWHNwYkV2UFQ0V3NmMUNhbXZWa0VIY2krY2JTdlFZK2U2RWps?=
 =?utf-8?B?ZVBOdmJnam9qSkIvUGRlbG9iMHJMcnk2Wk1SK3huZ1hsR0thWXR2dDBnUnA1?=
 =?utf-8?B?dFpwQzB0QTd1Ny9ub3pVemQ0bm1TbzlxNGJRRTlUdCs0Y0gwN0M1VVl3MWtP?=
 =?utf-8?B?NnBwQ2tHZFJpMFlNdFlNeDFBOEN4dFRSY0dhUThsVzYrQnFRWGUrbHJ2U2RH?=
 =?utf-8?Q?0synIpGFMo41UHPb28y19CwJ8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2bc5294-34fd-4e45-5f6c-08dbb52ebd14
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:27:35.2926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9nZt+7gvf5S/S6SeHA9pgxmwwXgMnBxniYxAzt2p4AiMAUbn4L20dF+LT3V5l2+EAprnu7Pt3GiZNlbzoKF5DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7820
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/2023 7:36 PM, Sandipan Das wrote:
> Zen 4 systems running buggy microcode can hit a WARN_ON() in the PMI
> handler, as shown below, several times while perf runs. A simple
> `perf top` run is enough to render the system unusable.
> 
> ...

The email header has a problem which breaks the subject line. Apologies
for having to resend this.
