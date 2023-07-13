Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA277525FB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjGMPCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjGMPCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:02:39 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2070.outbound.protection.outlook.com [40.107.15.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79F7B4;
        Thu, 13 Jul 2023 08:02:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0yDLdeiQ6/FY54uu02onXk6Kpyx8LY7QCWqX2nn2KkjjykfeQ2Orl2LzTak3aEi/TCHawnqgADa453Z3MCL1lY41peIVI0ZLdYBFKMZMEFakT+W1zcrv4Owi5F2Y5kV9/4h0TLCnbxBimuPE+EE4teNdI6re498jG7HdDa/9UHw0VPQ4QR3p/ByMMPfp/DUcSkZlsdjhfVB/jblGad/1flvbOdtSYkRr/HtvQA0279tGeafCSZWjF6zrzW3DcGJRoMSGRhGXZpyIVwKa3SiOTl3qci1onqXaMxifWCySC/lRjxvJJg2OJnLu55CXNAlPKs+AV6zywcH2pdieaAwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnpQy7WQ2GhgcqXHe81xQo2DR8hvz6m2IvXy69/QJLI=;
 b=NU0FdKDh6yHSL7jfcDVSmObYknIIc2uIjU2fVbhzfBCOraDpMdkeRyBYSp1sD8IjzqHqmLb3q4n657pdLgFfR37IgfQAdbx8APl9hu9K6SscbYkoVQArm2qLQ2dXbYNMF9KWe08/fbYcgYOKDYbusQf6TtOXi0z/Mgq8G+3wWkCUSt6GlWTnvmhlLfdiXbhscqwRCY/b39bvTdO+wvAsqy4vbEmXtmP0LcMH4iU5p42+KNZ0Aj6p7Tn6FQ7MiCpB30/D/uvLHptm4ljpDc3YTJwZOAIDa/S1pcy+PInB4Q+HCUL/aS2gabTYh64pIQkpcIZCJ3Gr3MsAXiGR7x99VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnpQy7WQ2GhgcqXHe81xQo2DR8hvz6m2IvXy69/QJLI=;
 b=bq4SKt4wDOBylFui8o1o/TDfblcU1RkuS56RWTlkT2cst0EzRn4iqzw6mujNTsug8fzD4eZQEz7Vb/0egGRScv9Fd+v2e2RvaDpJ57af/Nvh/czxsA17zpKGlGz3ovZcPjfG6l7++s890+YZto6fTLMRr71FZRonM53tW7zT8x0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM8P193MB0850.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 15:02:33 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::33e5:1608:50a0:38a7]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::33e5:1608:50a0:38a7%3]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 15:02:33 +0000
Message-ID: <185b3acd-bdd0-8cdc-9974-5e6010d394a5@kunbus.com>
Date:   Thu, 13 Jul 2023 17:02:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3] tpm,tpm_tis: Disable interrupts after 1000 unhandled
 IRQs
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jgg@ziepe.ca
Cc:     jsnitsel@redhat.com, hdegoede@redhat.com, oe-lkp@lists.linux.dev,
        lkp@intel.com, peter.ujfalusi@linux.intel.com,
        peterz@infradead.org, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        kernel test robot <yujie.liu@intel.com>
References: <20230619092219.2600-1-LinoSanfilippo@gmx.de>
 <CTYXI8TL7C36.2SCWH82FAZWBO@suppilovahvero>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <CTYXI8TL7C36.2SCWH82FAZWBO@suppilovahvero>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AM8P193MB0850:EE_
X-MS-Office365-Filtering-Correlation-Id: 57f6f0a6-52f2-4e22-80e5-08db83b22f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OF/K6MueVj1N3vTWg0GN/ugWzT4xay6fTnABX53YBHi5oNWaobIgmlXlR1dd+jk/7SogbUfL8StwUpJSM5gdoIVPHX4+T6MIgYbc6ggfoYuNkJn0JyWyNcBF29B3ZHYDSxI2cQk1EUpaGKsMNB1v69eJJi8T2kcS8OlsehEkl2SBv2XAheJGDTTUhI2dKRt1RkXsbuu1Kzj6kxDOUsOW+SU/WzUUonS21egAxZJyuRJoJ0u98YkXWNX2m61/7a3kxNdpGmyc/dVgwW0O7Pp+pcXCyD0ell98s6zbP+8CCVHGaQL4Nc96kvR2uPPqpqX5q2BZOi9OezBMYhoOVJSkiyS9lbdBisWvQeC5S24lM6JPVNHqnhDwyH5/XbnCXZnVojLuZElCKWsymIr41Rr6JbtBoOVTisFgzELdELXd4Sjgfo3chSFlEdyQ1JrVQon7QnoJHqWAC5P8wtT9WDhj7OABf+TcA8U33ef9WBSZ2r7uCL130Qc16N6O4dYDpCgyxgVCpNeQIFR5tO79ykO5Atd7+toH8MOdEyr3q3qdRBFExkT4U2QKXeLdewmKbJdCdHjDCbHFPAErvt6mtMcYT2KIEPOmfBN3LvNdNBequZJSBqRcr6RRLwybb6gk5qb2w9W5InWlfeyysDWD1ZZFauuCR+YhELFQUg4dOeLMko06mseSaz7lJNxbuiRKpdCU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(39840400004)(396003)(451199021)(478600001)(31686004)(66946007)(110136005)(4326008)(2906002)(5660300002)(316002)(8676002)(41300700001)(6666004)(8936002)(7416002)(66556008)(30864003)(66476007)(6512007)(966005)(6486002)(26005)(6506007)(52116002)(53546011)(38350700002)(38100700002)(186003)(83380400001)(2616005)(36756003)(86362001)(31696002)(221023011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVJIRTkwQmNOeGVGOG1MU0FVMk5GY0t1VzdnNlE3VGI5SGRQdW5iSGpxaENh?=
 =?utf-8?B?WUMzYUFKdTlhN0kyUE5BZzNiMDhFR0p3UGVMbXFvOTNyRXFVNlllNlQ0NjQ1?=
 =?utf-8?B?MGpsalFSUVg0U2w5NnFoQ1Q0bXp3bUFRVk8yeU9OWWUxRnJvemJqWnlJODNy?=
 =?utf-8?B?Szc0SDhFWHhyN3k4dDFpRVU3cW5SVE5KOWE4azFDN3RDNkE1dmR0S1ZtV1Y0?=
 =?utf-8?B?ZCtmRTdyTFBScXI0alJuOUJCbm8wTTUyNHdrMGtVazNSN1U1dVQxV0E1WkY3?=
 =?utf-8?B?WGR4R1hpL01hdDNWdWJHa29YTk1qVzhFNFF5MnVKUmdXbzNsRmd1UFdDbDh6?=
 =?utf-8?B?dWVGY1FuZnptZmVORUtmdE1aMHFnSkxIdUk2TGh1TFczNDBEYWpVYjBSd1Ar?=
 =?utf-8?B?R1dhWXZuK253QzRnSmRGSERkOVJHNHdWSE16ZmpZb1c0YzVrcXRYQVN3N1Zn?=
 =?utf-8?B?YlJxSkN1dXBIb0ZBdVRCa0VlaG5KT2VQUEszSDcySzhmKzJHUGxyd3g5WTdR?=
 =?utf-8?B?cGlhZjUwNG90eE0rMHJaOVBmcmp6Y1JXNFlab2h4S3FDdU4ySVVWWWNhVjF5?=
 =?utf-8?B?SWx6cEpQUnJ4OGN2eWVRTDlFa1hpSVhndGxHRGFIdDY2c3lOZmI4NlAyMDlo?=
 =?utf-8?B?K0N1SW1zQjV5eUVrZVFoZk5mUWhTbUcrclh4RjhZT2tJbGExWk9jM0dFcGxi?=
 =?utf-8?B?MDhqeXBDZC9nT3pHRTIzRkduZ0lPOHBTTUtDOGVmWWcyM3pwRDNSYU5rMUhH?=
 =?utf-8?B?MVhDMTZRM2ZQZlk4aUVyVlZFR3liZFQvMDB0UCtDUVVEQnhRM1FiOGZuRGVG?=
 =?utf-8?B?RmNoM0NSYkR1aDg1V1JRS3hwQjBYMDZjV1lNUytkNkdHRkRONHYrNjhRaUFM?=
 =?utf-8?B?ejRXejkrWUZRTmR0d3BRNEliUEdBWEdEang1V2JCZlVGbTZPTWVTNEl4T25P?=
 =?utf-8?B?VUtVcWpzNTY4TVpodHVXazg2T0tJelh0MGRyeUZlZnlxZ2VkdFNucUh3TE9Q?=
 =?utf-8?B?TXpreU8yT21KS2JBQ1I5UnhYWHFaVmxObTBIMU9TZk9HVjgrQmtTU0lsRGpW?=
 =?utf-8?B?clhQUitWY1FZYjBFSnhnTXlTak9JSml5d1MyMUo1ZmxzNWVJalVzMXJreU5v?=
 =?utf-8?B?aFpVd0RFYzc3TWZVSTZEdFppU1hDVERyd2FkWGxuZmhlZUIybDU1QlNYR0dQ?=
 =?utf-8?B?dGhhM0w4ZWM4ZVkrbjJMVUE5S3h0V2pnb1MvVmJaSzZRa2tTUC9SdTJtd3dK?=
 =?utf-8?B?TzhQclkzVk5weUc5aW5uWmdLUG5yZXVPcnBYQXZxSXp0dVlKYUpzOXdPVThE?=
 =?utf-8?B?bDJjb3RxQnpROWlRUEtpZnJnRXowY3NjdnlxcWJxMngwbFIybGRseVJUSXRy?=
 =?utf-8?B?SkxVRWRZNWNjbXErbUYxK214NWd0TmRqblk4NEF4dGl1NVpOOWEycTJYcG1M?=
 =?utf-8?B?QVlYVVEwOHZreHA5NTJ0SGRVcC9hWkU0bi9HRTV1bjBveVBINEszRkl3ci9Q?=
 =?utf-8?B?QWxaV3FJT21lR2MrOWFRVkRXTEhMSlN4b2lZZVlaS2RtRTVmcXA4WFA5Nmov?=
 =?utf-8?B?bEVBWWE1cm1rZ2M3VFN1Y0YzaFl6QktmR0lKWGQxWFZrdHhRbXB5MWhsVUs1?=
 =?utf-8?B?enFmWVkwam9UU3dJVElMb0c1aFYxSThjQWNpYXl0cmdSMFBtTEE3QlRjUEdR?=
 =?utf-8?B?ekdwM1pDcXRlTUNLZDkzbUZNc3lOS3llNFhsclVqZ3hRN2ZESVJxSTJ2amVY?=
 =?utf-8?B?RW9uYnZHQWdzNDlOUTZKbzFNTUYvaUJnMWgzaDFGYmxBNVBDRmRNanFaejB0?=
 =?utf-8?B?L1pWT2hoa3BSMmcwR0diKzN1dXAvdjIxazhzY01TcGF2M3Yrcm04Ky9vdFcr?=
 =?utf-8?B?WmRsd1d5Uk41S2tKZjFla2xsQ0JwM1dCblBsbnZCdHFZSlZTN2hRVXNPRGRC?=
 =?utf-8?B?Nyswbm41WjZUcmFqbkZGWU85eDF1amR6NVY0NXFWSEhyZWFvaGtxRm9KSUpC?=
 =?utf-8?B?a01TY21ncVUzMUNuS2RidE1kYTAzYVpzZjdERzJtSkFUOEYrU0h5Wjg4Y2VZ?=
 =?utf-8?B?ZFRDdFdOWEtENWxEREkzY25rcEY1enNSTDFmbXRweFBtNi90UUZhbTdJaGFO?=
 =?utf-8?B?M2dRaUlJVkt3ZUtSQlp0K0RHNDdpSG4zUW5LMjAxWE11RHBxMXA0SFNrYlND?=
 =?utf-8?B?bmc9PQ==?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f6f0a6-52f2-4e22-80e5-08db83b22f89
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 15:02:33.0964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cFSldU6rEQwkwhaYtw+PSb4AYeLYGKZXoF5IzXnMPaVw8uHxcqkaQil5m11v1aKBKUNkCoP9+hdNSYtut9bvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB0850
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11.07.23 02:50, Jarkko Sakkinen wrote:

> 
> BTW, you should do next time:
> 
> git format-patch -v4 to get "[PATCH v4]", which defacto way to mark up
> patch set versions.
> 

Right, will do so the next time.

> On Mon Jun 19, 2023 at 12:22 PM EEST, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> After activation of interrupts for TPM TIS drivers 0-day reports an
>> interrupt storm on an Inspur NF5180M6 server.
>>
>> Fix this by detecting the storm and falling back to polling:
>> Count the number of unhandled interrupts within a 10 ms time interval. In
>> case that more than 1000 were unhandled deactivate interrupts entirely,
>> deregister the handler and use polling instead.
>>
>> Also print a note to point to the tpm_tis_dmi_table.
>>
>> Since the interrupt deregistration function devm_free_irq() waits for all
>> interrupt handlers to finish, only trigger a worker in the interrupt
>> handler and do the unregistration in the worker to avoid a deadlock.
>>
>> Note: the storm detection logic equals the implementation in
>> note_interrupt() which uses timestamps and counters stored in struct
>> irq_desc. Since this structure is private to the generic interrupt core
>> the TPM TIS core uses its own timestamps and counters. Furthermore the TPM
>> interrupt handler always returns IRQ_HANDLED to prevent the generic
>> interrupt core from processing the interrupt storm.
>>
>> Reported-by: kernel test robot <yujie.liu@intel.com>
>> Closes: https://lore.kernel.org/oe-lkp/202305041325.ae8b0c43-yujie.liu@intel.com/
>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> ---
>>  drivers/char/tpm/tpm_tis_core.c | 117 ++++++++++++++++++++++++++++----
>>  drivers/char/tpm/tpm_tis_core.h |   4 ++
>>  2 files changed, 106 insertions(+), 15 deletions(-)
>>
>> Changes to v2:
>> - use define for max number of unhandles irqs(requested by Jarko)
>> - rename intmask to int_mask (requested by Jarko)
>> - rephrased short summary (requested by Jarko)
>> - rename disable_interrupts to tpm_tis_disable_interrupts (requested by Jarko)
>> - print info message concerning adding an entry to tpm_tis_dmi_table
>>   (suggested by Jerry)
>> - amended commit message
>> - handle failure of locality request by returning IRQ_NONE
>> - dont take and release locality in __tpm_tis_disable_interrupts but in its
>> caller
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index 558144fa707a..d42537b985c5 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -24,9 +24,12 @@
>>  #include <linux/wait.h>
>>  #include <linux/acpi.h>
>>  #include <linux/freezer.h>
>> +#include <linux/dmi.h>
>>  #include "tpm.h"
>>  #include "tpm_tis_core.h"
>>
>> +#define TPM_TIS_MAX_UNHANDLED_IRQS   1000
>> +
>>  static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value);
>>
>>  static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
>> @@ -468,25 +471,29 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>>       return rc;
>>  }
>>
>> -static void disable_interrupts(struct tpm_chip *chip)
>> +static void __tpm_tis_disable_interrupts(struct tpm_chip *chip)
>> +{
>> +     struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> +     u32 int_mask = 0;
>> +
>> +     tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &int_mask);
>> +     int_mask &= ~TPM_GLOBAL_INT_ENABLE;
>> +     tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), int_mask);
>> +
>> +     chip->flags &= ~TPM_CHIP_FLAG_IRQ;
>> +}
>> +
>> +static void tpm_tis_disable_interrupts(struct tpm_chip *chip)
>>  {
>>       struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> -     u32 intmask;
>> -     int rc;
>>
>>       if (priv->irq == 0)
>>               return;
>>
>> -     rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>> -     if (rc < 0)
>> -             intmask = 0;
>> -
>> -     intmask &= ~TPM_GLOBAL_INT_ENABLE;
>> -     rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
>> +     __tpm_tis_disable_interrupts(chip);
>>
>>       devm_free_irq(chip->dev.parent, priv->irq, chip);
>>       priv->irq = 0;
>> -     chip->flags &= ~TPM_CHIP_FLAG_IRQ;
>>  }
> 
> These look pretty good.
> 
>>
>>  /*
>> @@ -552,7 +559,7 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>>       if (!test_bit(TPM_TIS_IRQ_TESTED, &priv->flags))
>>               tpm_msleep(1);
>>       if (!test_bit(TPM_TIS_IRQ_TESTED, &priv->flags))
>> -             disable_interrupts(chip);
>> +             tpm_tis_disable_interrupts(chip);
>>       set_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
>>       return rc;
>>  }
>> @@ -752,6 +759,71 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
>>       return status == TPM_STS_COMMAND_READY;
>>  }
>>
>> +static irqreturn_t tpm_tis_reenable_polling(struct tpm_chip *chip)
> 
> 
> I'd rename this to tpm_tis_revert_interrupts(), as it reverts enabling
> the interrupts. Polling was never enabled in a fully initialized driver
> so the function name is implying something that never happened.

Ok.

> 
>> +{
>> +     struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> +     const char *product;
>> +     const char *vendor;
>> +
>> +     dev_warn(&chip->dev, FW_BUG
>> +              "TPM interrupt storm detected, polling instead\n");
>> +
>> +     vendor = dmi_get_system_info(DMI_SYS_VENDOR);
>> +     product = dmi_get_system_info(DMI_PRODUCT_VERSION);
>> +
>> +     if (vendor && product) {
>> +             dev_info(&chip->dev,
>> +                     "Consider adding the following entry to tpm_tis_dmi_table:\n");
>> +             dev_info(&chip->dev, "\tDMI_SYS_VENDOR: %s\n", vendor);
>> +             dev_info(&chip->dev, "\tDMI_PRODUCT_VERSION: %s\n", product);
>> +     }
>> +
>> +     if (tpm_tis_request_locality(chip, 0) != 0)
>> +             return IRQ_NONE;
>> +
>> +     __tpm_tis_disable_interrupts(chip);
>> +     tpm_tis_relinquish_locality(chip, 0);
>> +
>> +     /*
>> +      * devm_free_irq() must not be called from within the interrupt handler,
>> +      * since this function waits for running handlers to finish and thus it
>> +      * would deadlock. Instead trigger a worker that takes care of the
>> +      * unregistration.
>> +      */
> 
> Way too complex description. This should do:
> 
>         /* Defer devm_free_irq() outside the interrupt context: */

Hmm ok. I thought a little description about why devm_free_irq() has to be deferred
would be helpful. But maybe it is obvious and one sentence is enough.

> 
>> +     schedule_work(&priv->free_irq_work);
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static irqreturn_t tpm_tis_check_for_interrupt_storm(struct tpm_chip *chip)
> 
> What does checking interrupt storm mean, anyway?
> 

This function is supposed to check if an interrupt storm has occured.
So tpm_tis_check_for_interrupt_storm seems to be proper name.

>> +{
>> +     struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> +     irqreturn_t irqret = IRQ_HANDLED;
>> +
>> +     /*
>> +      * The worker to free the TPM interrupt (free_irq_work) may already
>> +      * be scheduled, so make sure it is not scheduled again.
>> +      */
> 
> I don't understand the text in the comment. It is not even a proper
> sentence ("to work to free").

Right, there are some words missing. I think this should be something
like "...the worker that is supposed to free..."

> 
>> +     if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
>> +             return IRQ_HANDLED;
>> +
>> +     if (time_after(jiffies, priv->last_unhandled_irq + HZ/10))
>> +             priv->unhandled_irqs = 1;
>> +     else
>> +             priv->unhandled_irqs++;
>> +
>> +     priv->last_unhandled_irq = jiffies;
>> +
>> +     if (priv->unhandled_irqs > TPM_TIS_MAX_UNHANDLED_IRQS)
>> +             irqret = tpm_tis_reenable_polling(chip);
>> +
>> +     /*
>> +      * Prevent the genirq code from starting its own interrupt storm
>> +      * handling by always reporting that the interrupt was handled.
>> +      */
> 
> Ditto, textual content is confusing.
> 
> You can either make them more informative, or add a short description
> before the function.
> 

Ok, what about "In case of success return IRQ_HANDLED to prevent the genirq 
code from starting its own interrupt storm handling".

>> +     return irqret;
>> +}
>> +
>>  static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>>  {
>>       struct tpm_chip *chip = dev_id;
>> @@ -761,10 +833,10 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>>
>>       rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
>>       if (rc < 0)
>> -             return IRQ_NONE;
>> +             goto unhandled;
> 
> s/unhandled/err/g

ok

> 
>>
>>       if (interrupt == 0)
>> -             return IRQ_NONE;
>> +             goto unhandled;
>>
>>       set_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
>>       if (interrupt & TPM_INTF_DATA_AVAIL_INT)
>> @@ -780,10 +852,13 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>>       rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), interrupt);
>>       tpm_tis_relinquish_locality(chip, 0);
>>       if (rc < 0)
>> -             return IRQ_NONE;
>> +             goto unhandled;
>>
>>       tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
>>       return IRQ_HANDLED;
>> +
>> +unhandled:
>> +     return tpm_tis_check_for_interrupt_storm(chip);
>>  }
>>
>>  static void tpm_tis_gen_interrupt(struct tpm_chip *chip)
>> @@ -804,6 +879,15 @@ static void tpm_tis_gen_interrupt(struct tpm_chip *chip)
>>               chip->flags &= ~TPM_CHIP_FLAG_IRQ;
>>  }
>>
>> +static void tpm_tis_free_irq_func(struct work_struct *work)
>> +{
>> +     struct tpm_tis_data *priv = container_of(work, typeof(*priv), free_irq_work);
>> +     struct tpm_chip *chip = priv->chip;
>> +
>> +     devm_free_irq(chip->dev.parent, priv->irq, chip);
>> +     priv->irq = 0;
>> +}
>> +
>>  /* Register the IRQ and issue a command that will cause an interrupt. If an
>>   * irq is seen then leave the chip setup for IRQ operation, otherwise reverse
>>   * everything and leave in polling mode. Returns 0 on success.
>> @@ -816,6 +900,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>>       int rc;
>>       u32 int_status;
>>
>> +     INIT_WORK(&priv->free_irq_work, tpm_tis_free_irq_func);
>>
>>       rc = devm_request_threaded_irq(chip->dev.parent, irq, NULL,
>>                                      tis_int_handler, IRQF_ONESHOT | flags,
>> @@ -918,6 +1003,7 @@ void tpm_tis_remove(struct tpm_chip *chip)
>>               interrupt = 0;
>>
>>       tpm_tis_write32(priv, reg, ~TPM_GLOBAL_INT_ENABLE & interrupt);
>> +     flush_work(&priv->free_irq_work);
>>
>>       tpm_tis_clkrun_enable(chip, false);
>>
>> @@ -1021,6 +1107,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>>       chip->timeout_b = msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
>>       chip->timeout_c = msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
>>       chip->timeout_d = msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
>> +     priv->chip = chip;
>>       priv->timeout_min = TPM_TIMEOUT_USECS_MIN;
>>       priv->timeout_max = TPM_TIMEOUT_USECS_MAX;
>>       priv->phy_ops = phy_ops;
>> @@ -1179,7 +1266,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>>                       rc = tpm_tis_request_locality(chip, 0);
>>                       if (rc < 0)
>>                               goto out_err;
>> -                     disable_interrupts(chip);
>> +                     tpm_tis_disable_interrupts(chip);
>>                       tpm_tis_relinquish_locality(chip, 0);
>>               }
>>       }
>> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
>> index 610bfadb6acf..b1a169d7d1ca 100644
>> --- a/drivers/char/tpm/tpm_tis_core.h
>> +++ b/drivers/char/tpm/tpm_tis_core.h
>> @@ -91,11 +91,15 @@ enum tpm_tis_flags {
>>  };
>>
>>  struct tpm_tis_data {
>> +     struct tpm_chip *chip;
>>       u16 manufacturer_id;
>>       struct mutex locality_count_mutex;
>>       unsigned int locality_count;
>>       int locality;
>>       int irq;
>> +     struct work_struct free_irq_work;
>> +     unsigned long last_unhandled_irq;
>> +     unsigned int unhandled_irqs;
>>       unsigned int int_mask;
>>       unsigned long flags;
>>       void __iomem *ilb_base_addr;
>>


Regards,
Lino
