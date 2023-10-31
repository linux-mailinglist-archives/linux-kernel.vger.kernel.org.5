Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C83F7DC44F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjJaCRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjJaCRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:17:10 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2120.outbound.protection.outlook.com [40.107.255.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC95B3;
        Mon, 30 Oct 2023 19:17:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2k9HiCmba1SlVXwxdhhwgLUYV2vwjx9Pny9/jYHhnXl+hJnuDEBoWzyf+Ouj3vmqNcSJTp4NEHokDhskJWuYzy+QC2ETDIgR6ZY4Y5R8vRkcKvcWgq0/taZyaBzho6cGjlbE3Fv1fa57vTS4Bi8+Ry7EkgrvlcVV6TUzojWnrHPZi9S7ddnnJGuhhuBIOBpUOpbBi1AJI3D2bxtXOt64vyL3NZthZAib+uQnn0h9ZKytgZW+JX3LGiYhaL9BCbUCCm0ZbOL4+E+t5fkZtJ6mHHAq8RDJHSEonC3KAeAVYlZVj+ERM+KG7liln56rKz6q8/vDYIL9igW10tb8/1rfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbH7xZM4pJvlBkLY/qBXLENR9CukSKl3Vxozja7yM7Y=;
 b=GzRY7aZhoOS2edvQAouTo8uaB0K9NZnDrDYB6BEWS5U2NFfW/e4sFOSUIuQh9vW8pxSI+2E9LIeVWvHEk3ZeZHVmirPIZRRYMhlFma4YEWCP0QADSs8nQVwkKjtIyRcGeXIU4nuEB0ADHvodMOQTZxNNH8CsR5b/UntB+sCilwEsvd0mkMfs1T8wOmP0O9BHSzGtP85Ktupb8DQWQf1bJDhcYSIqO/fcsCOInOjMN17ILWk8USlWSfnJ2U61if5RYyiVjzuxf+5abJziuCg1RStwr6r+fDueVzZMH3JmnbwMmZqzaaJQUoM5HDipt3Tauf88wBy6SgplwjcFZaZtAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yunjingtech.com; dmarc=pass action=none
 header.from=yunjingtech.com; dkim=pass header.d=yunjingtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yunjingtech.com;
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com (2603:1096:101:177::9)
 by KL1PR0601MB3987.apcprd06.prod.outlook.com (2603:1096:820:2f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 02:17:00 +0000
Received: from SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::605a:d113:7ca9:8572]) by SEYPR06MB6507.apcprd06.prod.outlook.com
 ([fe80::605a:d113:7ca9:8572%4]) with mapi id 15.20.6933.027; Tue, 31 Oct 2023
 02:17:00 +0000
Message-ID: <131c8e8d-94f8-e0e9-5a1a-336b1ef84509@yunjingtech.com>
Date:   Tue, 31 Oct 2023 10:16:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V6 2/3] pinctrl: Add support pin control for UP board
 CPLD/FPGA
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     lee@kernel.org, andriy.shevchenko@linux.intel.com, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com
References: <20230915031123.14515-1-larry.lai@yunjingtech.com>
 <20230915031123.14515-3-larry.lai@yunjingtech.com>
 <CACRpkdbi0bS0yiJ9ac6Z44os0w6FyKm+UsvbgQEYzYKymjww-w@mail.gmail.com>
From:   larry <larry.lai@yunjingtech.com>
In-Reply-To: <CACRpkdbi0bS0yiJ9ac6Z44os0w6FyKm+UsvbgQEYzYKymjww-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR06CA0043.apcprd06.prod.outlook.com
 (2603:1096:404:2e::31) To SEYPR06MB6507.apcprd06.prod.outlook.com
 (2603:1096:101:177::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6507:EE_|KL1PR0601MB3987:EE_
X-MS-Office365-Filtering-Correlation-Id: da3a3755-6211-4807-ff44-08dbd9b77731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYgnK4s6u2ktWFH3hJbhrYM+gjO3gS87Vl/TbGhQZd5zp1XsiaS3gE8wG4pyYM7raeNeAZIGfb+wkj7ACitsPq/551eVzuZhJuCPvrEdvUjH7Phnacn0TSHd993WUOVr4+DNhR5zDvhmzjQH+j6XWoa/8uTKH3BqpUr/cjF/7E2hGLSshoLnTXyfHAbtv5PuzRDk6xLLv238zAfRLYNRkpf0CT0U/Mn+neKEHJMYVdYRtKay93oTyGoH6J8trSEynQepszdKMVJ52k7LBL6zlTP7XLqCMfta05gXK3g/j1HEItaMG0BWWQeEejSlLh0tR6ltJNF11dsrCtRvRHM5pXNhkFTEg8Gk2cFq6POtm9UxmWC86AeCO+RhYUG1lr9KJyWgiexMfwe9PqNcQ77a8rMgX9Pbdiwcq7V6x+OMML7OJku+YTkDJsbpmfUS6m8wnaMnadS4yt+NfigTRlkZmw1/SXHF/KZfOEBqxMHJUTJYDRDURCFJ/VtEO08q3XqLonmCDoVlzSgGzSloy4ab97veF1gWmaWTunB03OpxFpSS1AS+ZEFmOwvm2/ieFT83e2lRTRyzfgiEiXquWaiQUYkE1/UKfIvw8P5QHeXQMjihgQxY4AkD1EjiAk/+qqyp8UkAzOPJd0AtYhdgV/NqRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6507.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39830400003)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(31686004)(6512007)(26005)(2616005)(38100700002)(31696002)(36756003)(86362001)(2906002)(83380400001)(6486002)(6506007)(478600001)(4326008)(107886003)(53546011)(6666004)(8936002)(8676002)(6916009)(316002)(5660300002)(41300700001)(66556008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHBtNXdGSmZwVjdoSy94bFlmM3VBVER3YkFjV1VEdUNZWU1sdzBtS3ljLzR0?=
 =?utf-8?B?VjBiQ0xWSHZUeGNDR0tXZENhaU5RVnR6VjQxaWlIQ2ovU3NjeG15b3pwdGpl?=
 =?utf-8?B?L3V1UTJaWm5mMGNKVG9HSDRWOVVrZUhYbkluR0xYSzhoUGRLbzJNOEpta3I0?=
 =?utf-8?B?cHBuUk9yQWZ4Q2hkWEx6TTI0djhEN0dPR1BFNHBadWpBVU1qcmR0ZzJvcVVN?=
 =?utf-8?B?TmM0ZGZHdC9zT09hR1BKR1BML0c2T1lTNDFUWXp1aDVtVGxGMUYvYWV2Tyt6?=
 =?utf-8?B?NkY4RzdLdzFwaHlwTjVmQ1prS2NFSUxySFIreWEva1NJVWxkQkpWd1NLeEtj?=
 =?utf-8?B?OVVhcTR1V1lhMm1qRGY2K1Nham1hcXBDQ3BOeGhnVW5mdEJwRy9hVk5kQkYr?=
 =?utf-8?B?eVVNVWsxUjFsa1ZzL3FCS0U5amRzYTRxWDVVTjh1UHdNSVpGQzQ1YnNGUzVp?=
 =?utf-8?B?dW5rQ2QrVER5a2ljb2lBcUdrNjdKTW45ckNZYk05V3JIOThCdFBQUzRwVDMz?=
 =?utf-8?B?YXRmb2xsQmY0S0ZzeUpualFIMm4wSkdWWXVRcERXeDVTcjZxNXNHd3FPNnhK?=
 =?utf-8?B?Z1dkVTBFcnFIeVE3bGhVbmtLUE1TcTBOcmFaMWNqQVJwcGkxVWhJNmF1bmZi?=
 =?utf-8?B?eHBhdXZYYXQ3MkpZb1hPV1ZUeFAxNjNoTGxzZFZ0S01iTzQ3NkFPTWpKSTF4?=
 =?utf-8?B?OTlxaStpYkFkcDVhdGRmMElxYzJ1S2JuNnU5M1RpNUcrcWQzc2dobFNuYWVS?=
 =?utf-8?B?cUQrd1RjTXlWdzBiNEV1NVEzMmJqZkF4Yjk2YVBleTcza0ZaeGVSKzc1amxN?=
 =?utf-8?B?ZWxWdUJoclpWTC9JVWFhblIrMS9jVGlLVlhQaHd3a1ZGa3RxVUFLUDBWSFYy?=
 =?utf-8?B?SmJQWmJQOXJJSTcwQWhyVkxpVGNDVUlDTngxaENaNTJVdC9vUWZYOEZkbW5N?=
 =?utf-8?B?YnRkQnh5b0ZkU2ROaE1rTnNMbjVDMThlSjN4OS90WWZyVENmVnhZQTA3RDI2?=
 =?utf-8?B?UGtCTEhtU0NhaFNiYU5zRlQ1M1JvZ0c0T01OMTNLUFNwMGN0aGgzSWR1cWdx?=
 =?utf-8?B?c0pyd25Nc0hlakhycmZSV1dzWUo0T3E3Qldad2diakprZWx4Q01iaHVYVXRa?=
 =?utf-8?B?VzZCeWgxalpaUEcrYlNTVGovWDZXdjFoRUZ0R0IyTFNES2NEQmwyZ0xGQ29z?=
 =?utf-8?B?L21UVXViMDFBWTNjMXppd1JacG0zdG92U3QrUE1YQ1FvTDVtZzlpUGZ6dFRH?=
 =?utf-8?B?bURucFBvWDl1ZWc2VHp3SGFyUWZHYzNrQ3p0MURHMWFmNHlTNmROcFpQWEwv?=
 =?utf-8?B?bDJqU0s3NkdkR2ZaSzd3QktuS1BQRmk1cVN4Y3hUaUVrNGxmNWlPcmk0VUs2?=
 =?utf-8?B?QnorSm1zS244SXNUbm1HNUgzb0J6OTRyM3hmd0hxRk9xam9IUksxTk9vYzlj?=
 =?utf-8?B?bzFndENOM3BVSEtHaVZNTUNBOUJSWGRuOXBKNEM2WnFjSWF1VnRadWZaYXJI?=
 =?utf-8?B?SXhqSHJBUzNLQjdNbGpWVEk3Q055TUsvRjhnUXZzZW15L3V0b21YK01uZkFZ?=
 =?utf-8?B?Si8wcWRGQmFVdHB4NkEycWN4MFJ6ZGFmRndSdXFpTGdDTDZhQ0lkVG1RNC9J?=
 =?utf-8?B?Syt6TG52Y2xNOUcyODhwK0tBY21obzZrSlVZWWR4NU1RZUNTRUkrNTBPTUpQ?=
 =?utf-8?B?VmZLaFVVc3JOaWdwT05VcitodXBKV3IxekIyZ3VCS0k2aXB4eDZrSlp6cHlx?=
 =?utf-8?B?Y1l2RGhjSjdFeThMTDZZTWw4cmxtNjRlUDZzR2EzR0pJZlZHVGVHc2Z1dmxv?=
 =?utf-8?B?a0JGeEdFV0V0ZWRPaVpzOXN4NkYzUXdXQlB2ZG5obGFmR0hqRkpmZVMxRGYv?=
 =?utf-8?B?VHlTVjBpRyt0TlRmTTZaRHB0b0dORGtSTnZKcC9NdHRoaGdHZmxOVTV2dVNm?=
 =?utf-8?B?VmN3bEoyMDdTeHh3Y2tvR01UM2ladFlYano2alhRelBWRS85UHB3bEFUaDdG?=
 =?utf-8?B?UkhUN09TRGpwdzRVbm5xRSt5VDIxemFWeDdrQit1eWdmM1lZVE80YlFoeWFS?=
 =?utf-8?B?M0hIR2habjlrdGt0RHdnSm1HRmZwQzQ1b3AyZEd3U0tJMmJRV3A4eCtzV3dl?=
 =?utf-8?B?QVorZWk3dW9zMEkyUHBpVVZpZmhKNm1NV2NUUlAzQ1V6WlVpcjkwbmVMY0dS?=
 =?utf-8?B?aUE9PQ==?=
X-OriginatorOrg: yunjingtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3a3755-6211-4807-ff44-08dbd9b77731
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6507.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 02:17:00.6538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: be2d5505-f7e6-4600-bbe2-b3201c91b344
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGV+swqsDBA3YfPTMyq8YKencTcUTM14EYlrx4vPyL8Wn3C9ilzWepBe9REBopOpOPD3/h9iqv4oFW5+svaWn4ZI7fJCdbHYKrnlFsXlEOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3987
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLACK autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Cause we replied the wrong email-format to you last time.(Lee informed
us that format is hard to read), so we send the comment again, thanks.

On 15/9/2023 17:02, Linus Walleij wrote:
> On Fri, Sep 15, 2023 at 5:12 AM larry.lai <larry.lai@yunjingtech.com> wrote:
> 
>> The UP Squared board <http://www.upboard.com> implements certain
>> features (pin control) through an on-board FPGA.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Gary Wang <garywang@aaeon.com.tw>
>> Signed-off-by: larry.lai <larry.lai@yunjingtech.com>
> 
> This v6 overall looks good to me!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Can the patch be merged on its own?
> 
>> +#include "core.h"
>> +#include "intel/pinctrl-intel.h"
> 
> Didn't notice this before. But if Andy is OK with it, I'm
> OK with it, I guess there is a reason? Perhaps it warrants
> a comment explaining why you do this?
Need struct intel_pinctrl gpp information to control dedicated Raspberry
Pi compatible GPIOs.
These products (Up boards) are Intel approves foundation kits.

> 
> Valid reasons:
> - You are using Intel-specific HW features also found in this
>    FPGA
> 
> Invalid reasons:
> - Using nifty macros or helpers, then either make them generic
>   or (if they are small) duplicate them.
> 
> If it was that thing I asked Andy to keep locally because I didn't
> agree with its generic usefulness, maybe I should be told to
> reconsider.
> 
> Yours,
> Linus Walleij

