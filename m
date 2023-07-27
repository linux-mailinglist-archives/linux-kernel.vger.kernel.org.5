Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966D87643C7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjG0CY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjG0CY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:24:56 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2101.outbound.protection.outlook.com [40.107.117.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EAC2680;
        Wed, 26 Jul 2023 19:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFcJBj9kCbmNDv6Whvdeq4RgeWJxqZlBZTCRGvTQMWawNqPq8dMu3JMYuW22fB2fEskdxc/VmabGBF0D7Q32u1AFvq3n8Zj7uPyx8dxnjWLyhDSUo+Y5Q7cWGURzsRDZrYgpme961ThJB0ymb76PcXe6/hKolBF02phQDTDH5znW6MBZcgf/clT2YbQInsPMHI1c/J1PAuvgY/QAyXYv6l+bxc1I87my+qEqXO6GkzoR6xQk4B/Oc7rMc2xA9g2REHMH/TT2jaNrO2+qU4Fv/rg3bL0yOYa6hygVYCLPzL1Y+yOX5wG/dRGLPUBBTzkSFLZvIBycgE+1cRFioejPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okOxLJ+g/a8Zihqu2DfH2Mu64HYCZEcwpL4Y7fRs8pg=;
 b=Q/ZwGRE+Pg70HU3CviM24JdF20ql/dT+kHF2eel6RyOJs4k2q85LCy7R+9ogdlT8/CNzv6LM07qTOcv+Rv1BmDrAVEkWlVWfCpwMlq27XV6pBHzBK1H8eQuBT+gHLWKePwo9kF13XoPSrAIWmoa8W8qSU/eoxDcSJs557FUWGLHf485mRf0oDgKYERGY0TzoUBpVO0ahJQ4BK/IlkdDusBxj9gHhcmFQePJr5yciup6RtgyiRb6Hc+oqA3vIPdx8kUSi0hzFMrvvwM5yksI2A9ChfnwvN51xv9Q8QCA9BxZuZq6tgGx4yXw4cPfqpIYoL3tpr9fydDd85x7m5fEv8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okOxLJ+g/a8Zihqu2DfH2Mu64HYCZEcwpL4Y7fRs8pg=;
 b=TGxRagN4Q6A7oE16ILT5YxvWwhBGUdM2fjkqgzE9TWM8atxHLSeH7VTXY55NWRI53k/xz0MD860OmBi7AuX4TBY50qgbGwKWqnFA5QwV7JcavPDH1zh3aKwHcmjtLpPNhpUqlyqAkRY305YPvyjrBKA9HSaAeJjaRMpQ4/39xTuvCyzXtLL2hMd9XQaAECwyupybf3CFC27JGo/cIhKRkhUQ+p5ABDe/5bjnbR0ls2odNI52tOoofY/gHDB/9gW03C7KxX3CERuLnHKdPcPRf//tDeIoW2itq+vcyvDUhXqJuu9t6RxUOPvRfN9zvD0Qkpc8Qe4EZ3dieke6fCMgmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYZPR03MB7027.apcprd03.prod.outlook.com (2603:1096:400:331::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 02:24:07 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::4716:19e8:ce87:9909]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::4716:19e8:ce87:9909%5]) with mapi id 15.20.6609.032; Thu, 27 Jul 2023
 02:24:07 +0000
Message-ID: <39dc0aba-54f7-5c36-01a0-b48d91b6f1c8@amlogic.com>
Date:   Thu, 27 Jul 2023 10:24:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 3/4] soc: c3: Add support for power domains controller
Content-Language: en-US
To:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20230707003710.2667989-1-xianwei.zhao@amlogic.com>
 <20230707003710.2667989-4-xianwei.zhao@amlogic.com>
 <7ha5vii9ew.fsf@baylibre.com>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <7ha5vii9ew.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR06CA0030.apcprd06.prod.outlook.com
 (2603:1096:404:2e::18) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYZPR03MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b277a72-8079-4693-a6cb-08db8e488df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99Dho3ZCo4kWYnxOOycyKndwJBDYb+jutpc435by29dtOWH8TKnRlYH9k4r44lmDgE+Lz6y13fqZYmMw6fGrGC9MTlwXCJHkk9oxJfQNNBEi4hcsKX/rfLzwCwbtYnG0rRQVcO7q17maiifMbTc8+IboqSJejRVWUgFD+N7GnK/IhfDhuw7OtlWxyNKfJhDx83jISABmfGTCU8xKaKq6x+FG+jMwKyPmSTEV2UgWbKX1+RWnRwPG10rDX8fiOI7ZcC9WJke1tKxGxGduSCR4K6DZJPzqLCiLLgCMiPbdQpzOn8kRo/B1vEX/5GnPQJh2CiT0ShTN+rgi0KOy9r5r2CmTyqJ8Vf9uayAFE4GRccL7bi2KCP6nR2cjeu6W3Y52P70uCXhhl+l8sxfitZSN8gkdNaRz41J2Mkp4ApktKQJmGH9dSTxDCtTbxRGGPfcOeAAEkI+eI4qkRnaf12tITR2yeX73BJ740pLu2A3lMfeiHDwM7AT+fRUtWvgaNTL3VOmsFAjqYbEMEzK01jzcBNGYRF2smbfvJGMe7wxvdESyLmqZN4nikOpDlmCImxDSlgPTiB1OfcT3duQXNisJlTBR3qJnrHFQVW8zKjgppSjpBUZgghs29fwZ8CuruKkhMxYUglhhBHT4wXxicTb+6P/nTs8cUmYb93GQNgyLv0DHC/KWuetxewEiH5pEUoVv7lZzWdbhvSblWhlQwDNKLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(366004)(39850400004)(451199021)(8676002)(66556008)(44832011)(5660300002)(8936002)(41300700001)(4326008)(31686004)(316002)(6486002)(6512007)(2906002)(54906003)(478600001)(186003)(6666004)(6506007)(26005)(53546011)(2616005)(66476007)(66946007)(83380400001)(38100700002)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RENrK3BoOGx1amdBU2V4S3k2TkZDaFlOODZUTG9YcC9RdkFFMGI0SXMyVGlJ?=
 =?utf-8?B?VHVicnVrQWNrWmllMHdPVWRVOTJGUkhodzk2YWhmM0F4UHlPNzYrQS9mS01R?=
 =?utf-8?B?NVVyMGRnUWVUV2JZOUs3STl2NDU0QTRCSzBQaTYxOVB4N2ZQbDF1dGpGOVJh?=
 =?utf-8?B?YW9pZUhvOThaRDF0ZXdZSlRYb0FsS2xraUVkNXRVWkdmMklxV21DZmhTcyt5?=
 =?utf-8?B?Uy9WNlB6dU4yRlgyaTdMT05xZ0NnSCsraXM4QkZJNkgxSEdoNEx4ZGdBdC9u?=
 =?utf-8?B?OC9QMkVmU1hLMGZ6SVlNMVArNGZQWTBNeGZLQS9EVS8rTmhHRVNvZE1zZUg0?=
 =?utf-8?B?Unk2WUlKb3VrLzlQWDZHNHR0MzIwdFNIb0NXN2xyV0o1V1RBSWcrL2U3VGdH?=
 =?utf-8?B?R3FuUnQwRHNNUVVoZXFVaHlReDRaSHJQMFZwNjFSNG5reE5HNmlaNzhvU1ho?=
 =?utf-8?B?dEE2dG5iSDdlWEYwMGxLcDJzeEd6c1VuT2ZxejRLTGdhUDNBTDhRbXZ3VlJ4?=
 =?utf-8?B?VUx3T3FpaTd0L0VuMTY0TmE4bHV6Vm1aVHpZUWczQWdBSXNLczhLdStvMitn?=
 =?utf-8?B?QkV6MjgvV2NiV05jL2thTGM0Sk5yMCtlN2x4Q3VEU2VUa3VPQkNQSmFqd2J6?=
 =?utf-8?B?ZWI0T0tuTG1GS284WUlkUjhDcG1nZnhPUk1MYm1oTHVLRllPUEdrNCtvTml6?=
 =?utf-8?B?YXcxWWovekJSZFVNVkNlcmQrZStoVEVwWUVQcm9ia2xwdmtKWHkrQlBHNDlr?=
 =?utf-8?B?UFlEZytVRVo3aDZHeURXK2FEQUNITzhnRnRPT05lK3RBZUNZTEQyQUlndFVL?=
 =?utf-8?B?bFhDVkJtQWdJdmtFWERWVTJNUGRoYXVxK1kxQmFldDVZeVRoUlBXa0pML3NG?=
 =?utf-8?B?YXMyN3FsQUhFekRqem0zTEh2QkJlV2NZU0FsbWw0YXFNQkNTeEFrbG9KYmwy?=
 =?utf-8?B?MGQ4YjkxVUhTaWVONWdMMlFlcDVtUElPMytaRm45aE1iSlUzRm5Vb0lLaEVQ?=
 =?utf-8?B?dzVGaVpWVFgyUUdoUTVBaGRraWQwUzRQMU01YnQ4M3lPTi96T1VVaGVZM3ov?=
 =?utf-8?B?aFZLd2lDY0c3bnNRV3ZCV25pY2YzUGw5d3pnS2Y2V0VkcEhZVWUxUFFjbGVI?=
 =?utf-8?B?VVVjbDVSM2lMbDdZTHNvTDhOM21tYmxhR2NVVTdRT29Ick9KdFNBNTA3V20x?=
 =?utf-8?B?a2QybUs1ZDNCTlFGN0kzK3BpbHlSZ1R5N2F3eWc4d0htZHRnY3l0dGtpQkl3?=
 =?utf-8?B?N25rMWNleWl1aG1EY3V6MnR5T1JES01aWWd3bnQ5YUJrUUVJUXFtdTFZcFVm?=
 =?utf-8?B?M0xrdnNidEJRSU5CQ0FOOXpwWlYxOFF2NGhVRU9MT0pJd2twYzJQdGlyTU14?=
 =?utf-8?B?dFRyWWpUcm9ON3ZvdlZkV0NrcDJQeExUMGhjUGoyVXNaT05yUjBBOVhyZ1dl?=
 =?utf-8?B?K1pjT3UwSzZPVlZMR0RrN0N4MTBZUUxnL1VXRTRWWGNwZGc4U3NaOFRQMDJI?=
 =?utf-8?B?VHJHZ0lBYUVHU3FZL3V4SW85Vm1FSG5tNlFMVWpSSHBRbUM4UE1KQXFaajAz?=
 =?utf-8?B?VndPZTBVcTBnc0VkNEpZYjdMSWc2bjAwcGpaZU1HM0wvU0UySTAwam5zdUF0?=
 =?utf-8?B?NnJtY1dSVVNDaXlyTnBuUy9VMmc0YVJyNWF3M0hXQ2U1aGJub25uckFSYUlL?=
 =?utf-8?B?VG5HM0VJTFhNNm5XcEdoVm1Hcm56Q3pBNjAzWVhWbnJEbjJOdnJJSlgxRS9J?=
 =?utf-8?B?UWVwTjNNeS9FRWNYekpLbWd5TEc1Wkg4VXZNZlJtdGV0aW4xZ0hpWUM4aTRk?=
 =?utf-8?B?ZnFjVE5qL3R2ZFZZREsvMW5oU3pzLzdBR0dONUU1THNFTSsrbS83WHE2RUpD?=
 =?utf-8?B?YVVVcDZkNkFZTU1UdFhOMSs2ZE5ZVFkzQktLVi9sL1JtSjBEZ3RGUU54S0NZ?=
 =?utf-8?B?Y0xDSnFxRTBsYXRZOVQyYVVRa2JoVEoraklSSE1EdzFJc2F3Q1RxYVVJUTRP?=
 =?utf-8?B?Z29Jd1JSaUJJdHNpak4zeEtiVmwyM0RFT3daZ3NiUjVFcWVLK0dSaUUwLy9K?=
 =?utf-8?B?eE1FcUM4cFpYZXdyVXlFY3BkL1NLanhxNWQ4RFBqQlVCWXFwWlpVaDIvUVFW?=
 =?utf-8?B?OXo0M3pHclB1TitlUXVjTFpNN3lUYVNTTWJjcW9QRWsvRDF0b3pOL1ZlcHpu?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b277a72-8079-4693-a6cb-08db8e488df5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 02:24:07.7653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uZire5sU02tzTzukAIplJDARIg1WsFhY0tRGdULYRWnyQrsBbuKtSeT/XQ2520Morm9OVjS2Bu8ZilGYQ2XlP0AGvIoM/y7O9q8sKWDFek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7027
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,
      Thanks for your reply.

On 2023/7/27 06:40, Kevin Hilman wrote:
> [ EXTERNAL EMAIL ]
> 
> Xianwei Zhao <xianwei.zhao@amlogic.com> writes:
> 
>> Add support for C3 Power controller. C3 power control
>> registers are in secure domain, and should be accessed by SMC.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>> V1 -> V2: Fixed some formatting.
>> ---
>>   drivers/soc/amlogic/meson-secure-pwrc.c | 26 +++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
>> index c11d65a3e3d9..a1ffebf70de3 100644
>> --- a/drivers/soc/amlogic/meson-secure-pwrc.c
>> +++ b/drivers/soc/amlogic/meson-secure-pwrc.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/pm_domain.h>
>>   #include <dt-bindings/power/meson-a1-power.h>
>> +#include <dt-bindings/power/amlogic,c3-pwrc.h>
>>   #include <dt-bindings/power/meson-s4-power.h>
>>   #include <linux/arm-smccc.h>
>>   #include <linux/firmware/meson/meson_sm.h>
>> @@ -120,6 +121,22 @@ static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
>>        SEC_PD(RSA,     0),
>>   };
>>
>> +static struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
>> +     SEC_PD(C3_NNA,  0),
>> +     SEC_PD(C3_AUDIO,        GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_SDIOA,        GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_EMMC, GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_USB_COMB, GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_SDCARD,       GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_ETH,  GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_GE2D, GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_CVE,  GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_GDC_WRAP,     GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_ISP_TOP,              GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_MIPI_ISP_WRAP, GENPD_FLAG_ALWAYS_ON),
>> +     SEC_PD(C3_VCODEC,       0),
>> +};
> 
> All of these domains being hard-coded to ALWAYS_ON looks suspicious, and
> can also be an indicator that the drivers for these domains are not
> (properly) using runtime PM, or not connected to the correct domains the DT.
> 
> Similar to the tables for s4 and a1 in this same file, please describe
> the reason that each of these domains needs to be hard coded to be
> always on.
Will do.
> 
> Thanks,
> 
> Kevin
