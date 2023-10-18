Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86727CE1D2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344850AbjJRPyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344790AbjJRPyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:54:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB99116;
        Wed, 18 Oct 2023 08:54:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/CydcMl5DF2EyaBTxDgg0jj9VW9uTuXZdMbvbTLr7t71VVd0d4jLJKzwyiO94bTDebOkM9h4+9G29rmeZybKGEOXTz3CzEVRPFoHbbHF9Sg8l01eACYC4lI5NtQoEtNwMX9cThGZu5Np8Y4HxVtQiekL75/0NbEqJwGFrux8K/CUv2Tvn3jywRFvMUhBPT8pD8F/fBQTIAu3ABqFcBAdVR9Vm3Q2eUsG7JtOMpdwTWOgQCYgaCoOGAl/igoFRacEcOg+lgyp30/K6VpRVI0ulFeuwrr7qp8Y69eehb42MjTcREUsyvtSkHwARm9dHqSI5v6v/uPG+bKiutGp2fMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEAZCSOjPC9bstwDMgcsfIqfyO2T+1pCkzD7QhEQIDM=;
 b=GItkbEAoETQ5qyiXsmgE9FwYElrt0t55/b6CAiBbky8LnQ/66mJw2GpxmdIuVPwwzbsKMA3/EulfkaFVFz/YGiotkfggALayHticLM/GylcNYJHeMKEuXqSrFE67MpQXOBFQVav+QyjhT2iNYMMpDHu3Fiyq5C1q9F2Mb5Me5dUJyN1s3+1+LdamPUmlP+P8I+/E4PiTrlRqqG1AMeDz2+sQ0Cy0mB8DEsg1g9x3pZ/sPSZx+M0fRK4xj/C3jGCOn/hDg2rbXCaEInrtCSbOKy2wUtYGFOL8G1L3qpwY9G3rZQNX/B3J0gPpPip992S8TZt5kp/7o/ZTikBw4bV/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEAZCSOjPC9bstwDMgcsfIqfyO2T+1pCkzD7QhEQIDM=;
 b=tKwyDTELL6rnaSDigdrAgEYuFvTUKfU128NAxmrTkcpVh6sl1Fgzo5J5tE5xRgm8i1K91H7Uw80ge7JQFJxR92n7DmfT6pfW8ewC23RFhV1oMs6wg1VUXh0w00gvoHAPb2yIrPy5Ud8rcHUu001QdrwSmZXG54CWjlVJVLsVNc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3407.namprd12.prod.outlook.com (2603:10b6:208:c5::18)
 by SJ2PR12MB8720.namprd12.prod.outlook.com (2603:10b6:a03:539::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 15:54:36 +0000
Received: from MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::3008:be4:e9a4:2a98]) by MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::3008:be4:e9a4:2a98%7]) with mapi id 15.20.6863.043; Wed, 18 Oct 2023
 15:54:36 +0000
Message-ID: <7946d74b-6d07-41f1-9dba-6c2d98683e26@amd.com>
Date:   Wed, 18 Oct 2023 16:54:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] w1: Add 1-wire master driver for AMD programmable
 logic IP Core
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        thomas.delev@amd.com, michal.simek@amd.com, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <20231013093109.37165-1-kris.chaplin@amd.com>
 <20231013093109.37165-3-kris.chaplin@amd.com>
 <3aed801f-cb11-4306-b588-b1de1405f93f@linaro.org>
From:   Kris Chaplin <kris.chaplin@amd.com>
In-Reply-To: <3aed801f-cb11-4306-b588-b1de1405f93f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0106.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::22) To MN2PR12MB3407.namprd12.prod.outlook.com
 (2603:10b6:208:c5::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3407:EE_|SJ2PR12MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b21bcd-d5bf-4d97-acdd-08dbcff286da
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VAv5z9fwvp9Nab5+NC1h7SPlx8NbwqPElzsSmIQ6YX6YMdE09JpwAKTLxDf3dk2y7+5hfgszwrXBb5tQVvjMybYWN8R9AA64k9EMG6m/54cLaVUrDuQdbuLMXegMlElV9XNeH3Pwo2uTME6q3iTWF77t/3R003rZVztdytIFe4Zl/kA+f4mD46Ou0EdTdA4MoIWDFaz8wuFcdv8rH6irkLDl4kW+BTsy49xdALH8w3sfKAJLrn4scV8EOPm2Hk8Rh11PlIt57/9UCwrM+29KiYoRzwCYMBg9kciJ64PNyqCqhKtLYj4DQ0S2EXiMnr56n4ExCxIxUtW1/DSGaa3exhXj8ywO7Fa4E7ar0s2z5E0c8miF2UwqpEij7DtD/5X7TBCXohTTeNlM7v/T7nMUJgI96HjDncnUbkIwq5KawqQtwIrtc6fRXm0b9A44U9AAdMw9h5n5at4yNno++kokNH8lAh5FvtUZCDdCAfKVU5MWbRQhkjLKJgk894JlPZBymJZ21D9WXo+500LIyvKJfwT+oB/XQ+N4rFmpZaO5GTsgF+tOUA85SxxUB5DXvsgz/PLbnZpch3SSQ5/rOzjbvANTBhwvHlgTD7NJNU7KR/vzJG7n3CcQ0oSPgAgA1y5NArqZUgwLAcZTe3RscOJZQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(31696002)(36756003)(86362001)(478600001)(6486002)(2906002)(53546011)(41300700001)(6666004)(6506007)(5660300002)(38100700002)(44832011)(26005)(2616005)(316002)(8936002)(66946007)(8676002)(4326008)(83380400001)(66556008)(66476007)(30864003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFZzUFhOdS9laW51SmZGVGlRTDVTRnliY3BERjNnYjZMK05LV2ljVWNCQm1m?=
 =?utf-8?B?WG83eHJvWURrenlLcmszVmtiam15MGtuaXV2MjlyWVpHMitpTDZmOWhQTmZ3?=
 =?utf-8?B?OXRHdGRYRGFjaG9OcnI1NU9kZkNXdGNSQWVQMmZFY0xVMU9SRFFxdDNpSzZB?=
 =?utf-8?B?MkFMRW0vUWdQMDg4aVRZQi9VNTk0Z3lyKzBhajBVa0dsT3JpQUk5NTFXalNm?=
 =?utf-8?B?aDJjYXpCcFlHUldOamlPWlBMSTI4RGtNMFRGZEtpanZDdS9ORzI5dGtNMGcx?=
 =?utf-8?B?ejRWNkVEVXJ0M2R5UjFQWjExRDBOR215MEpqSFRISUZESHVtUXVFZVV2dFZG?=
 =?utf-8?B?bFR6K09OWmJhNi9zT0dSeUt0Q2x3WVhwZ2dkaWFpQ0RsMFhMQnhBM0RaM24w?=
 =?utf-8?B?TWszVkZhSkdaTy9ZWmExb1hKQndrRExqTGtjSDBicUpjamxQTGVRUkp2L2Z4?=
 =?utf-8?B?WkRFREFkdHRiOWRpNnhWRE9JZklBNXczQXd6TCtxcTQ5UXluSG9sUC9LM1R4?=
 =?utf-8?B?Wnc5a293NmZVd0hJRjVyR296YzBwTGRUNW1LSHRBNUYyWjZPTXJWcUtnRDY4?=
 =?utf-8?B?ZWNhRllFSWZLNEF3c0ltb2ZQbGhaWXBwcEUxZ3lQKzA0VE4xSlMwY3VFWk5M?=
 =?utf-8?B?QUJsUEZ1ZGorMnFlOS9BMnVIckVtUEpnWE4zYjkvTVZpamhucitkc2NaSzNs?=
 =?utf-8?B?RC8xMEw2cnk3eFpQNVlYYkpPTjY2ZDArNjlWNG96bHp0aGZSNUl6UUhjNDkv?=
 =?utf-8?B?ekRMNFZCdG16emg0d3JRY1dUWlRmb01weDllR3Z5Nk5LMXdObFE0VEZFYWJs?=
 =?utf-8?B?dkF1eWV3QVJtVEc5SEs4dGRLTDBkTHlTV3NaQlFFMGorSG5uVXg4OUhpRWRL?=
 =?utf-8?B?dWNYaGRMdmUrR2VKenVqNEhBbjByOUh6ejRxWENaaDVTMlZqZTJzVkQ5OVln?=
 =?utf-8?B?WkZTNVJpVzJmKytpSzhIbGllMkFSbStkRjAzeW0xMU9pYWx3YkJLQ2tsKzdN?=
 =?utf-8?B?RTFJbFZKVUdJNWMzN3F4bGJDbVV4M1QxTWZ6S2R4THFTNzJHbVFOU1NpK2Q1?=
 =?utf-8?B?S1ZYWGQyeDllcmhWRUtRR3VLUmhnN3lNRHJBQ1E4QWVJc201dFg4WDVjODFm?=
 =?utf-8?B?ajYvN2tQNittemhzQnN1TmlFK3ROcXd2WVB3OUxHTWhoclJXQW1leWl2cTBn?=
 =?utf-8?B?T2cyU0ExeGZTWnM1VCtnbE9KTXdQQmZQS2JsUy9hREVnc3QzVjJLOEFOTTgv?=
 =?utf-8?B?YzQ0Ym8zbmg3cnl1RTUyY3Y4ZEltV1VuaXkvUnBhT2tEWmpGM3c5c3grNDFi?=
 =?utf-8?B?dXZXWGRwbVRRbFdjMTUzdmVrV2FZSDZUbDZIOE94Skt4N0NaSXN6K0xZaE5t?=
 =?utf-8?B?TXFudmhaSnlmMENnZlVWeFRNaTZCd25ucmpKY1B3Y0E3SkthT2NLTHBmRUVw?=
 =?utf-8?B?NitoRUZjbTViWWt1bEY5TlBlUDlaWHVYTHFNeHpFSXRCNkJPZFBOVGI4dllr?=
 =?utf-8?B?OHlBNjhkS3Fld3BTOW1IekViZmltc1JjMUJBUTlaOWVFaCsvMXRuWVRmRzB1?=
 =?utf-8?B?QzZNVHU4RUV0NHQzWGxBV2pNL1VnbXBiZFQxQm50dzYxRTNLZHlucE9DUXlF?=
 =?utf-8?B?V2wwc1diV2xlSkE4c0czQ2UzTWlLY0VXRkh5dy9qbDRqUEgzdHgvekFXNGlh?=
 =?utf-8?B?YXNSMEV4NWN3QXJxVTRTZENtWlVTWDZHaTU3K3c0MHB2Skdaa3hnWEtIQktH?=
 =?utf-8?B?cm9BamdCUUZoaVVHdEpwbzR6YXpBMlRHSmxnSDRQVktTTzgrSWVrL1NGc2Q0?=
 =?utf-8?B?WG41Wm1iT2ZiUkxBMEtjajY0USsyOG5CYlp2YnpnUU43UWxXdHNaR1FrOWxs?=
 =?utf-8?B?dmpmWmYrT2U1N1pJNXNtM2pWelFzQ0VBNTk2VGFZRkxMSWtDWml5Nkxia29D?=
 =?utf-8?B?ZGJWaE8rTDh5bnhGcVNnaDBwWmMxQTZmaW93c3pMalpiOU51aGRPMXdLRzlv?=
 =?utf-8?B?a1QyZzFXWWp4Wkl3dWs0RmlLM0pDbi9WV1dkN050QWdpemFvbWtkOXg1R3Jz?=
 =?utf-8?B?NU1rUGdNZFVZd09VUmR4Z2MrZTUxS0plbHN3aW9jN1lnRkhQbjhnQSt3ZGJB?=
 =?utf-8?Q?OKZs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b21bcd-d5bf-4d97-acdd-08dbcff286da
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 15:54:36.3644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWiu8iKd+bXkJ618tRotlIYIaihR4GVR7H6xuueALKJJ0KwWfCHA3zUVK2xSu9I9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Krzysztof,

I shall post v2 tomorrow:

On 13/10/2023 16:20, Krzysztof Kozlowski wrote:
> On 13/10/2023 11:30, Kris Chaplin wrote:
>> Add a master driver to support the AMD 1-Wire programmable logic IP block.
>> This block guarantees protocol timing for driving off-board devices such
>> as thermal sensors, proms, etc.
>>
>> Add file to MAINTAINERS
>>
>> Co-developed-by: Thomas Delev <thomas.delev@amd.com>
>> Signed-off-by: Thomas Delev <thomas.delev@amd.com>
>> Signed-off-by: Kris Chaplin <kris.chaplin@amd.com>
>> ---
>>   MAINTAINERS                 |   1 +
>>   drivers/w1/masters/Kconfig  |  11 +
>>   drivers/w1/masters/Makefile |   1 +
>>   drivers/w1/masters/amd_w1.c | 422 ++++++++++++++++++++++++++++++++++++
>>   4 files changed, 435 insertions(+)
>>   create mode 100644 drivers/w1/masters/amd_w1.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6ec3922b256e..7f26dab5261b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1072,6 +1072,7 @@ R:      Thomas Delev <thomas.delev@amd.com>
>>   R:   Michal Simek <michal.simek@amd.com>
>>   S:   Maintained
>>   F:   Documentation/devicetree/bindings/w1/amd,axi-1wire-master.yaml
>> +F:   drivers/w1/masters/amd_w1.c
>>
>>   AMD XGBE DRIVER
>>   M:   "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>
>> diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
>> index ad316573288a..9232fd1f4e5b 100644
>> --- a/drivers/w1/masters/Kconfig
>> +++ b/drivers/w1/masters/Kconfig
>> @@ -67,5 +67,16 @@ config W1_MASTER_SGI
>>          This support is also available as a module.  If so, the module
>>          will be called sgi_w1.
>>
>> +config W1_MASTER_AMD
> This looks oddly places. Isn't entry above 'S', so A should go before?
> The rule is for entire Linux kernel: do not stuff things to the end of
> the lists.
There doesnt appear to be a specific alphabetical ordering taking place 
in this Kconfig:

config W1_MASTER_MATROX
config W1_MASTER_DS2490
config W1_MASTER_DS2482
config W1_MASTER_MXC
config W1_MASTER_GPIO
config HDQ_MASTER_OMAP
config W1_MASTER_SGI
config W1_MASTER_AMD

I've moved AMD to the top of Kconfig for v2.  If appropriate, please 
advise and I'll send in a pair of patches for Makefile and Kconfig to 
reorder alpahbetically separate to this patch set.

>> +     tristate "AMD AXI 1-wire bus master"
>> +     help
>> +       Say Y here is you want to support the AMD AXI 1-wire IP core.
>> +       This driver makes use of the programmable logic IP to perform
>> +       correctly timed 1 wire transactions without relying on GPIO timing
>> +       through the kernel.
>> +
>> +       This driver can also be built as a module.  If so, the module will be
>> +       called amd_w1.
>> +
>>   endmenu
>>
>> diff --git a/drivers/w1/masters/Makefile b/drivers/w1/masters/Makefile
>> index c5d85a827e52..cd3da1daaf97 100644
>> --- a/drivers/w1/masters/Makefile
>> +++ b/drivers/w1/masters/Makefile
>> @@ -11,3 +11,4 @@ obj-$(CONFIG_W1_MASTER_MXC)         += mxc_w1.o
>>   obj-$(CONFIG_W1_MASTER_GPIO)         += w1-gpio.o
>>   obj-$(CONFIG_HDQ_MASTER_OMAP)                += omap_hdq.o
>>   obj-$(CONFIG_W1_MASTER_SGI)          += sgi_w1.o
>> +obj-$(CONFIG_W1_MASTER_AMD)          += amd_w1.o
>> diff --git a/drivers/w1/masters/amd_w1.c b/drivers/w1/masters/amd_w1.c
>> new file mode 100644
>> index 000000000000..04bf08c1b6d7
>> --- /dev/null
>> +++ b/drivers/w1/masters/amd_w1.c
>> @@ -0,0 +1,422 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * amd_w1 - AMD 1Wire bus master driver
>> + *
>> + * Copyright (C) 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
>> + */
>> +
>> +#include <linux/atomic.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/clk.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/types.h>
>> +#include <linux/wait.h>
>> +
>> +#include <linux/w1.h>
>> +
>> +/* 1-wire AMD IP definition */
>> +#define AXIW1_IPID   0x10ee4453
>> +/* Registers offset */
>> +#define AXIW1_INST_REG       0x0
>> +#define AXIW1_CTRL_REG       0x4
>> +#define AXIW1_IRQE_REG       0x8
>> +#define AXIW1_STAT_REG       0xC
>> +#define AXIW1_DATA_REG       0x10
>> +#define AXIW1_IPVER_REG      0x18
>> +#define AXIW1_IPID_REG       0x1C
>> +/* Instructions */
>> +#define AXIW1_INITPRES       0x0800
>> +#define AXIW1_READBIT        0x0C00
>> +#define AXIW1_WRITEBIT       0x0E00
>> +#define AXIW1_READBYTE       0x0D00
>> +#define AXIW1_WRITEBYTE      0x0F00
>> +/* Status flag masks */
>> +#define AXIW1_DONE   BIT(0)
>> +#define AXIW1_READY  BIT(4)
>> +#define AXIW1_PRESENCE       BIT(31)
>> +#define AXIW1_MAJORVER_MASK  GENMASK(23, 8)
>> +#define AXIW1_MINORVER_MASK  GENMASK(7, 0)
>> +/* Control flag */
>> +#define AXIW1_GO     BIT(0)
>> +#define AXI_CLEAR    0
>> +#define AXI_RESET    BIT(31)
>> +#define AXIW1_READDATA       BIT(0)
>> +/* Interrupt Enable */
>> +#define AXIW1_READY_IRQ_EN   BIT(4)
>> +#define AXIW1_DONE_IRQ_EN    BIT(0)
>> +
>> +#define AXIW1_TIMEOUT        msecs_to_jiffies(100)
>> +
>> +#define DRIVER_NAME  "amd_w1"
>> +
>> +struct amd_w1_local {
>> +     struct device *dev;
>> +     void __iomem *base_addr;
>> +     int irq;
>> +     atomic_t flag;
> Document what this flag does and what its purpose.
Done for v2
>> +     struct clk *clk;
> Why do you need this? It's never changed (after fixing the bug).
Removed in v2
>
>> +     wait_queue_head_t wait_queue;
>> +};
>> +
>> +/**
>> + * amd_w1_write_register() - Helper to write a hardware register.
>> + *
>> + * @amd_w1_local:    Pointer to device structure
>> + * @reg_offset:              Register offset in bytes to write
>> + * @val:             Value to write
>> + */
>> +static inline void amd_w1_write_register(struct amd_w1_local *amd_w1_local,
>> +                                      u8 reg_offset, u32 val)
>> +{
>> +     iowrite32(val, amd_w1_local->base_addr + reg_offset);
> Unwrapped code:
>    iowrite32(IRQ, amd_w1_local->base_addr + AXIW1_IRQE_REG);
>
> Your wrapper:
>    amd_w1_write_register(amd_w1_local, AXIW1_IRQE_REG, IRQ);
>
> Does not look simpler. If you want to use wrappers, they should actually
> help.
Unwrapped in v2
>
>> +};
>> +
>> +/**
>> + * amd_w1_read_register() - Helper to write a hardware register.
>> + *
>> + * @amd_w1_local:    Pointer to device structure
>> + * @reg_offset:              Register offset in bytes to write
>> + *
>> + * Return:           Value of register read
>> + */
>> +static inline u32 amd_w1_read_register(struct amd_w1_local *amd_w1_local, u8 reg_offset)
>> +{
>> +     return ioread32(amd_w1_local->base_addr + reg_offset);
>> +};
>> +
>> +/**
>> + * amd_w1_wait_irq_interruptible_timeout() - Wait for IRQ with timeout.
>> + *
>> + * @amd_w1_local:    Pointer to device structure
>> + * @IRQ:             IRQ channel to wait on
>> + *
>> + * Return:           %0 - OK, %-EINTR - Interrupted, %-EBUSY - Timed out
>> + */
>> +static inline int amd_w1_wait_irq_interruptible_timeout(struct amd_w1_local *amd_w1_local, u32 IRQ)
> Drop inline.
> This does not look like wrapped according to Linux coding convention.
> Please abide by the convention, so wrap at 80.
Inline dropped.  I've wrapped it in v2, albeit at column 84 as that is 
the first break point (comma).
>
>> +{
>> +     int ret;
>> +
>> +     /* Enable the IRQ requested and wait for flag to indicate it's been triggered */
>> +     amd_w1_write_register(amd_w1_local, AXIW1_IRQE_REG, IRQ);
>> +     ret = wait_event_interruptible_timeout(amd_w1_local->wait_queue,
>> +                                            atomic_read(&amd_w1_local->flag) != 0,
>> +                                            AXIW1_TIMEOUT);
>> +     if (ret < 0) {
>> +             dev_err(amd_w1_local->dev, "Wait IRQ Interrupted\n");
>> +             return -EINTR;
>> +     }
>> +
>> +     if (!ret) {
>> +             dev_err(amd_w1_local->dev, "Wait IRQ Timeout\n");
>> +             return -EBUSY;
>> +     }
>> +
>> +     /* Clear flag */
> Drop.
Dropped in v2
>
>> +     atomic_set(&amd_w1_local->flag, 0);
>> +     return 0;
>> +}
>> +
>> +/**
>> + * amd_w1_touch_bit() - Performs the touch-bit function, which writes a 0 or 1 and reads the level.
>> + *
>> + * @data:    Pointer to device structure
>> + * @bit:     The level to write
>> + *
>> + * Return:   The level read
>> + */
>> +static u8 amd_w1_touch_bit(void *data, u8 bit)
>> +{
>> +     struct amd_w1_local *amd_w1_local = data;
>> +     u8 val = 0;
>> +     int rc;
>> +
>> +     /* Wait for READY signal to be 1 to ensure 1-wire IP is ready */
>> +     while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_READY) == 0) {
>> +             rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_READY_IRQ_EN);
>> +             if (rc < 0)
>> +                     return 1; /* Callee doesn't test for error. Return inactive bus state */
>> +     }
>> +
>> +     if (bit)
>> +             /* Read. Write read Bit command in register 0 */
>> +             amd_w1_write_register(amd_w1_local, AXIW1_INST_REG, AXIW1_READBIT);
>> +     else
>> +             /* Write. Write tx Bit command in instruction register with bit to transmit */
>> +             amd_w1_write_register(amd_w1_local, AXIW1_INST_REG,
>> +                                   (AXIW1_WRITEBIT + (bit & 0x01)));
>> +
>> +     /* Write Go signal and clear control reset signal in control register */
>> +     amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXIW1_GO);
>> +
>> +     /* Wait for done signal to be 1 */
>> +     while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_DONE) != 1) {
>> +             rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_DONE_IRQ_EN);
>> +             if (rc < 0)
>> +                     return 1; /* Callee doesn't test for error. Return inactive bus state */
>> +     }
>> +
>> +     /* If read, Retrieve data from register */
>> +     if (bit)
>> +             val = (u8)(amd_w1_read_register(amd_w1_local, AXIW1_DATA_REG) & AXIW1_READDATA);
>> +
>> +     /* Clear Go signal in register 1 */
>> +     amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXI_CLEAR);
>> +
>> +     return val;
>> +}
>> +
>> +/**
>> + * amd_w1_read_byte - Performs the read byte function.
>> + *
>> + * @data:    Pointer to device structure
>> + * Return:   The value read
>> + */
>> +static u8 amd_w1_read_byte(void *data)
>> +{
>> +     struct amd_w1_local *amd_w1_local = data;
>> +     u8 val = 0;
>> +     int rc;
>> +
>> +     /* Wait for READY signal to be 1 to ensure 1-wire IP is ready */
>> +     while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_READY) == 0) {
>> +             rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_READY_IRQ_EN);
>> +             if (rc < 0)
>> +                     return 0xFF; /* Return inactive bus state */
>> +     }
>> +
>> +     /* Write read Byte command in instruction register*/
>> +     amd_w1_write_register(amd_w1_local, AXIW1_INST_REG, AXIW1_READBYTE);
>> +     /* Write Go signal and clear control reset signal in control register */
>> +     amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXIW1_GO);
>> +
>> +     /* Wait for done signal to be 1 */
>> +     while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_DONE) != 1) {
>> +             rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_DONE_IRQ_EN);
>> +             if (rc < 0)
>> +                     return 0xFF; /* Return inactive bus state */
>> +     }
>> +
>> +     /* Retrieve LSB bit in data register to get RX byte */
>> +     val = (u8)(amd_w1_read_register(amd_w1_local, AXIW1_DATA_REG) & 0x000000FF);
>> +
>> +     /* Clear Go signal in control register */
>> +     amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXI_CLEAR);
>> +
>> +     return val;
>> +}
>> +
>> +/**
>> + * amd_w1_write_byte - Performs the write byte function.
>> + *
>> + * @data:    The ds2482 channel pointer
>> + * @val:     The value to write
>> + */
>> +static void amd_w1_write_byte(void *data, u8 val)
>> +{
>> +     struct amd_w1_local *amd_w1_local = data;
>> +     int rc;
>> +
>> +     /* Wait for READY signal to be 1 to ensure 1-wire IP is ready */
>> +     while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_READY) == 0) {
>> +             rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_READY_IRQ_EN);
>> +             if (rc < 0)
>> +                     return;
>> +     }
>> +
>> +     /* Write tx Byte command in instruction register with bit to transmit */
>> +     amd_w1_write_register(amd_w1_local, AXIW1_INST_REG, (AXIW1_WRITEBYTE + val));
>> +     /* Write Go signal and clear control reset signal in register 1 */
>> +     amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXIW1_GO);
>> +
>> +     /* Wait for done signal to be 1 */
>> +     while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_DONE) != 1) {
>> +             rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_DONE_IRQ_EN);
>> +             if (rc < 0)
>> +                     return;
>> +     }
>> +
>> +     /* Clear Go signal in control register */
>> +     amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXI_CLEAR);
>> +}
>> +
>> +/**
>> + * amd_w1_reset_bus() - Issues a reset bus sequence.
>> + *
>> + * @data:    the bus master data struct
>> + * Return:   0=Device present, 1=No device present or error
>> + */
>> +static u8 amd_w1_reset_bus(void *data)
>> +{
>> +     struct amd_w1_local *amd_w1_local = data;
>> +     u8 val = 0;
>> +     int rc;
>> +
>> +     /* Reset 1-wire Axi IP */
>> +     amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXI_RESET);
>> +
>> +     /* Wait for READY signal to be 1 to ensure 1-wire IP is ready */
>> +     while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_READY) == 0) {
>> +             rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_READY_IRQ_EN);
>> +             if (rc < 0)
>> +                     return 1; /* Something went wrong with the hardware */
>> +     }
>> +     /* Write Initialization command in instruction register */
>> +     amd_w1_write_register(amd_w1_local, AXIW1_INST_REG, AXIW1_INITPRES);
>> +     /* Write Go signal and clear control reset signal in register 1 */
>> +     amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXIW1_GO);
>> +
>> +     /* Wait for done signal to be 1 */
>> +     while ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_DONE) != 1) {
>> +             rc = amd_w1_wait_irq_interruptible_timeout(amd_w1_local, AXIW1_DONE_IRQ_EN);
>> +             if (rc < 0)
>> +                     return 1; /* Something went wrong with the hardware */
>> +     }
>> +     /* Retrieve MSB bit in status register to get failure bit */
>> +     if ((amd_w1_read_register(amd_w1_local, AXIW1_STAT_REG) & AXIW1_PRESENCE) != 0)
>> +             val = 1;
>> +
>> +     /* Clear Go signal in control register */
>> +     amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXI_CLEAR);
>> +
>> +     return val;
>> +}
>> +
>> +/* 1-wire master structure */
>> +static struct w1_bus_master amd_w1_master = {
> And how does it work with two devices?
Thanks - we've got a 2x instance design running and I've reproduced an 
issue with rmmod on cleanup when both are active.  Fixed and will submit 
in v2.
>
>> +     .touch_bit      = amd_w1_touch_bit,
>> +     .read_byte      = amd_w1_read_byte,
>> +     .write_byte     = amd_w1_write_byte,
>> +     .reset_bus      = amd_w1_reset_bus,
>> +};
>> +
>> +/* Reset the 1-wire AXI IP. Put the IP in reset state and clear registers */
>> +static void amd_w1_reset(struct amd_w1_local *amd_w1_local)
>> +{
>> +     amd_w1_write_register(amd_w1_local, AXIW1_CTRL_REG, AXI_RESET);
>> +     amd_w1_write_register(amd_w1_local, AXIW1_INST_REG, AXI_CLEAR);
>> +     amd_w1_write_register(amd_w1_local, AXIW1_IRQE_REG, AXI_CLEAR);
>> +     amd_w1_write_register(amd_w1_local, AXIW1_STAT_REG, AXI_CLEAR);
>> +     amd_w1_write_register(amd_w1_local, AXIW1_DATA_REG, AXI_CLEAR);
>> +}
>> +
>> +static irqreturn_t amd_w1_irq(int irq, void *lp)
>> +{
>> +     struct amd_w1_local *amd_w1_local = lp;
>> +
>> +     /* Clear enables in IRQ enable register */
> I don't understand this comment.
Reworded in v2 to "Reset interrupt trigger"
>
>> +     amd_w1_write_register(amd_w1_local, AXIW1_IRQE_REG, AXI_CLEAR);
>> +
>> +     /* Wake up the waiting queue */
>
> Drop obvious comments.
Done in v2
>
>> +     atomic_set(&amd_w1_local->flag, 1);
>> +     wake_up_interruptible(&amd_w1_local->wait_queue);
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static int amd_w1_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct amd_w1_local *lp;
>> +     u32 ver_major, ver_minor;
>> +     int val, rc = 0;
>> +
>> +     /* Get iospace for the device */
> This is memory allocation, not IO space.
Agree - Dropped in v2 with other obvious comments
>> +     lp = devm_kzalloc(dev, sizeof(*lp), GFP_KERNEL);
>> +     if (!lp)
>> +             return -ENOMEM;
>> +
>> +     lp->dev = dev;
>> +     lp->base_addr = devm_platform_ioremap_resource(pdev, 0);
>> +     if (IS_ERR(lp->base_addr))
>> +             return PTR_ERR(lp->base_addr);
>> +
>> +     /* Get IRQ for the device */
> Drop obvious comments.
Dropped in v2
>
>> +     lp->irq = platform_get_irq(pdev, 0);
>> +     if (lp->irq <= 0)
> Open platform_get_irq() function and read the help. Error handling
> couldn't be more explicit there...
Changed in v2
>
>> +             return lp->irq;
>> +
>> +     rc = devm_request_irq(dev, lp->irq, &amd_w1_irq, IRQF_TRIGGER_HIGH, DRIVER_NAME, lp);
>> +     if (rc) {
>> +             dev_err(dev, "Could not allocate interrupt %d.\n", lp->irq);
> return dev_err_probe(). But this leads us to second question: why would
> you notify about allocation errors? Core does it. Do you mean request?
I did mean request - removed dev_err for return in v2.
>> +             return rc;
>> +     }
>> +
>> +     /* Initialize wait queue and flag */
>> +     init_waitqueue_head(&lp->wait_queue);
>> +
>> +     lp->clk = devm_clk_get_enabled(dev, NULL);
>> +     if (IS_ERR(lp->clk))
>> +             return PTR_ERR(lp->clk);
>> +
>> +     /* Verify IP presence in HW */
>> +     if (amd_w1_read_register(lp, AXIW1_IPID_REG) != AXIW1_IPID) {
>> +             dev_err(dev, "AMD 1-wire IP not detected in hardware\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     /*
>> +      * Allow for future driver expansion supporting new hardware features
>> +      * This driver currently only supports hardware 1.x, but include logic
>> +      * to detect if a potentially incompatible future version is used
>> +      * by reading major version ID. It is highly undesirable for new IP versions
>> +      * to break the API, but this code will at least allow for graceful failure
>> +      * should that happen. Future new features can be enabled by hardware
>> +      * incrementing the minor version and augmenting the driver to detect capability
>> +      * using the minor version number
>> +      */
>> +     val = amd_w1_read_register(lp, AXIW1_IPVER_REG);
>> +     ver_major = FIELD_GET(AXIW1_MAJORVER_MASK, val);
>> +     ver_minor = FIELD_GET(AXIW1_MINORVER_MASK, val);
>> +
>> +     if (ver_major != 1) {
>> +             dev_err(dev, "AMD AXI W1 Master version %u.%u is not supported by this driver",
>> +                     ver_major, ver_minor);
>> +             return -ENODEV;
>> +     }
>> +
>> +     amd_w1_master.data = (void *)lp;
>> +     amd_w1_reset(lp);
>> +
>> +     platform_set_drvdata(pdev, lp);
>> +     rc = w1_add_master_device(&amd_w1_master);
>> +     if (rc) {
>> +             dev_err(dev, "Could not add master device\n");
>> +             amd_w1_reset(lp);
> Why? Does this mean that w1_add_master_device() changes the state of
> hardware?
No it doesnt - removed un-needed reset in v2.
>
>> +             return rc;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static void amd_w1_remove(struct platform_device *pdev)
>> +{
>> +     struct amd_w1_local *lp = platform_get_drvdata(pdev);
>> +
>> +     w1_remove_master_device(&amd_w1_master);
>> +     clk_disable_unprepare(lp->clk);
> This wasn't tested. Duplicated disable.
Thank you.  Bug reproduced with rmmod on module version of driver and 
resolved in v2.
>
>> +}
>> +
>> +static const struct of_device_id amd_w1_of_match[] = {
>> +     { .compatible = "amd,axi-1wire-master" },
>> +     { /* end of list */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, amd_w1_of_match);
>> +
>> +static struct platform_driver amd_w1_driver = {
>> +     .probe = amd_w1_probe,
>> +     .remove_new = amd_w1_remove,
>> +     .driver = {
>> +             .name = DRIVER_NAME,
>> +             .of_match_table = amd_w1_of_match,
>> +     },
>> +};
>> +module_platform_driver(amd_w1_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Kris Chaplin <kris.chaplin@amd.com>");
>> +MODULE_DESCRIPTION("Driver for AMD AXI 1 Wire IP core");
> Best regards,
> Krzysztof

Regards,
Kris

