Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CB97BFFE3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbjJJPBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjJJPBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:01:01 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2056.outbound.protection.outlook.com [40.107.247.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C658CB4;
        Tue, 10 Oct 2023 08:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kva2NKMkG3+SHPd1GwnlMzxq2idQjKmA52DhGdUiaNg=;
 b=YiIGlfYuNAFh+Gg9hRRDSimF3rUX9jYv0W/ysH3DA67xemQXrU6zBw4/V8MsCv02eeRtSI/lkU1mGNYhRC8DwTzcWgIQemVz0ACX5rbXr8LLw+BDVL4Cfz0eBzmMldnvHmPUf1wsrOesvAtEr8+r0axiTbDvUUNwW9hU7ihep34=
Received: from AS9PR06CA0078.eurprd06.prod.outlook.com (2603:10a6:20b:464::28)
 by DBBPR08MB6283.eurprd08.prod.outlook.com (2603:10a6:10:1f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Tue, 10 Oct
 2023 15:00:55 +0000
Received: from AM7EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:464:cafe::a2) by AS9PR06CA0078.outlook.office365.com
 (2603:10a6:20b:464::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Tue, 10 Oct 2023 15:00:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT037.mail.protection.outlook.com (100.127.140.225) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.23 via Frontend Transport; Tue, 10 Oct 2023 15:00:53 +0000
Received: ("Tessian outbound ab4fc72d2cd4:v211"); Tue, 10 Oct 2023 15:00:52 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 365f917152ea58d9
X-CR-MTA-TID: 64aa7808
Received: from 9a9358688d33.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 41F37A45-F550-4012-83DF-C68705986F73.1;
        Tue, 10 Oct 2023 15:00:41 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 9a9358688d33.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 10 Oct 2023 15:00:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6n3X0foma5Nr5NBjarFgf5Wx0caw7gPiHQ0Fkrl36cVDNSDii0fVR0GMUBND8wgNlHugoTO4wqWEQSQkI9kqiNxDHdWc/aJNncD71JExKd9afWdByVhgkO1EZPgDZMFe6fa5VIQcHqEoQwlvgeEitH+QQSH22/eEamdXzRVZny1hppJXgdOnc5vOF+o6UjZj8NEdXdCkmuNAJZr7VHHoP8tMAvqsHBLm0mXUcAr2WqNJfpGWicQtHpePxxzIK6w4HHaX/vZfKj/SllxMjw1DCyd0fw3QfadbnRc1UaUAvisRj+8wG6mkP0E3j5ljGACqKzOA0xd+DbO0bZgjnn2QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kva2NKMkG3+SHPd1GwnlMzxq2idQjKmA52DhGdUiaNg=;
 b=eCp+jOrJAphgqKqtLE1qmnOTHij6G7GCMqkac2SVjU7LRpLBwoxzJe/8Z8pc9A4MbDfWhqU3ZqLHZoz7onkrrJ8v+Z+EvXgFekFxNewSWeWVeRG3s71PSG0+XBnlzqb6SOICkR+AvUXgNaigVxOKxtWHGgus/yMwFAwj7J37U9QKN1hcTXT9W6RO5dySjs7gLvQzhdVBc8x8Nfmt54u/KJoydTbRStA8Q7yZsG2LLBp2a59Nusu7YuAhGrnxFt76KFFNgVF4EOgiSXrBqgM9Esm7YuHPPf763d3xaObFbB98cFQLVNUVR7NzA+VkHSqInhvt5yyuPaPqLoRQNFUslA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kva2NKMkG3+SHPd1GwnlMzxq2idQjKmA52DhGdUiaNg=;
 b=YiIGlfYuNAFh+Gg9hRRDSimF3rUX9jYv0W/ysH3DA67xemQXrU6zBw4/V8MsCv02eeRtSI/lkU1mGNYhRC8DwTzcWgIQemVz0ACX5rbXr8LLw+BDVL4Cfz0eBzmMldnvHmPUf1wsrOesvAtEr8+r0axiTbDvUUNwW9hU7ihep34=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB7727.eurprd08.prod.outlook.com (2603:10a6:150:6b::6)
 by DU0PR08MB9823.eurprd08.prod.outlook.com (2603:10a6:10:444::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 15:00:39 +0000
Received: from GVXPR08MB7727.eurprd08.prod.outlook.com
 ([fe80::7556:1a83:73f0:cf7]) by GVXPR08MB7727.eurprd08.prod.outlook.com
 ([fe80::7556:1a83:73f0:cf7%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 15:00:37 +0000
Message-ID: <c978b02b-2c82-06a6-f63a-67729524bf6c@arm.com>
Date:   Tue, 10 Oct 2023 16:00:32 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v2 2/3] arm64: perf: Add support for event counting
 threshold
To:     James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Reiji Watanabe <reijiw@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Zaid Al-Bassam <zalbassam@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
References: <20231010104048.1923484-1-james.clark@arm.com>
 <20231010104048.1923484-3-james.clark@arm.com>
In-Reply-To: <20231010104048.1923484-3-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0340.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::21) To GVXPR08MB7727.eurprd08.prod.outlook.com
 (2603:10a6:150:6b::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB7727:EE_|DU0PR08MB9823:EE_|AM7EUR03FT037:EE_|DBBPR08MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: ab226b3f-66ec-47be-9b88-08dbc9a1b2ff
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: VCD34SmuDnbTXzxPhZMx5bbSRHS9iaZHQRms5KYx5xYwzw0rB5sRQAPacC0sUBEmkekSdeqQHBE0liqIuOqUT33GxveKV4UTr2C7BavIw4J4JdZxzY8Zn/GDx/bWkrOV+K/l/lRVJrS3Qjo8CleHH6yK4z1UqQ95j0r/h9MXwtd5fZYr12ZDFVmQvC6dCWnUKfWEZ9+2f+9FAFyxSVZ2PzXcYs6tGWwQweaYGcFvl3UuxUx9L0t2s+NOFHBRR8Rdrfnm5gAdEzUYh+m3yMeX1X8mVBp0aTbAr+UqdCfGCVXEer/Ule8BfqnfInCjA9LqbTLqEWIIEDFesnAqLjGSVbgM6oV/iBl8zcdHQe96JjtcUTXZrf1YFI3fD9J3s0f6xjjHFRK2rwA4uCtekf5YmsRV15mn/eA3ees78Y9f17dX+ww/fs1WnSEuHsI9ljdOA6dp+i++Q8VT31e7aNO0El9wtqYdIYSHbQuf/EqXxmUljW/2QHa4TM1b3VwpaeX+OPehAQRdoe7BQ9rNUtDMphYgPzjTQR/Gc33bXBdOc7EdRr5mJSiDYFGB9ALAEqruJPrvVbWwQhO0KMML9MIES4ApAHRC0B2hjGTW3X2xpEfjCGugqd1nK3aNEJ6mez6+ydJv/2+6xzyz6m8Lb5YY4g==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR08MB7727.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6512007)(2616005)(53546011)(6506007)(41300700001)(6486002)(478600001)(83380400001)(2906002)(7416002)(5660300002)(66556008)(54906003)(66476007)(66946007)(8936002)(8676002)(4326008)(316002)(26005)(31696002)(36756003)(38100700002)(86362001)(31686004)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9823
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b585c1a0-03b9-4c89-1057-08dbc9a1a945
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7jVR6D7+0mfnTYX3BaLpL+ADqTle4IXtlcw2VYr2UPfQU7l1u7glcxjnZMLwB43YCR5X9IYEl5CqFe3bI+/ddps1Qs85LwgopI88Wtc/MuXSg3KNJXwPBgK5m8/oHC9JIxpC2yV3yKB91LRc3kD+1xeuCQfDhUngFF3CfHZ/goZ9hCdBA57wMO+LMD9QtFDC4RZoDXJ3gmbXDM3Dql5hrvAPABjtvczCMhVokrEQb1cptLQyWHOxRgOhu/jF1c4/ti7N0pnc9HesFSULOAGtxtB39GmsrF96Dv0carNIeVa/wQHPY2TRwEbdaUgUTAtksVekKCSBdltBuOw2C+kbKIwjAWu1Fx2b/RGkDpvzNyXWy6PvTXsjDy2tcArrSxrSlXzJchWVpMgzQA9kzoAm8SrNfs5eQZYVkU5eKm2cewjFBdQrB61QGdmVX7LE0L7ap+dPRQEB4tfQ/sAtySqWDdIK//41KuAxtvlPG3iHXUJuBkxf1rtFtpBeWF+kLvObZACDW2hXEO6EL2M8o4MmJWRK2bJ7ylye4FSoA31OwM9tDZNDVX8dhhgQB+CGcVU2VLQqRwZJWo9RXMJQrRe5cm2cThDSSEPV2n+HRD5hI/thsFbNyoQO5REFcOvCjnWxUhnDD5TNIJEMeEcuKN5O5jZeNmEyPBN1TJ7dezdz1s3rfQ8DYWjTbS6nO8m3RxQPL3YraaODqy3+ckGEE3zK+j5+kD5F2MTidpDkHjox1fIqV9YLCmrlARB8Jz9scTodW91xM6e6FIznFElXKNt1Q==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(41300700001)(2616005)(107886003)(40480700001)(86362001)(316002)(54906003)(40460700003)(70586007)(36756003)(5660300002)(70206006)(83380400001)(82740400003)(31696002)(26005)(47076005)(356005)(81166007)(2906002)(36860700001)(336012)(450100002)(8676002)(8936002)(4326008)(31686004)(478600001)(6486002)(6506007)(53546011)(6666004)(6512007)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 15:00:53.1820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab226b3f-66ec-47be-9b88-08dbc9a1b2ff
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6283
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2023 11:40, James Clark wrote:
> FEAT_PMUv3_TH (Armv8.8) permits a PMU counter to increment only on
> events whose count meets a specified threshold condition. For example if
> PMEVTYPERn.TC (Threshold Control) is set to 0b101 (Greater than or
> equal, count), and the threshold is set to 2, then the PMU counter will
> now only increment by 1 when an event would have previously incremented
> the PMU counter by 2 or more on a single processor cycle.
> 
> Two new Perf event config fields, 'threshold' and 'threshold_control'
> have been added for controlling the feature:
> 
>    $ perf stat -e stall_slot/threshold=2,threshold_control=5/
> 
> A new capability for reading out the maximum supported threshold value
> has also been added:
> 
>    $ cat /sys/bus/event_source/devices/armv8_pmuv3/caps/threshold_max
> 
>    0x000000ff
> 
> If a threshold higher than threshold_max is provided, then no error is
> generated but the threshold is clamped to the max value. If
> FEAT_PMUv3_TH isn't implemented or a 32 bit kernel is running, then
> threshold_max reads zero, and neither the 'threshold' nor
> 'threshold_control' parameters will be used.
> 
> The threshold is per PMU counter, and there are potentially different
> threshold_max values per PMU type on heterogeneous systems.
> 
> Bits higher than 32 now need to be written into PMEVTYPER, so
> armv8pmu_write_evtype() has to be updated to take an unsigned long value
> rather than u32 which gives the correct behavior on both aarch32 and 64.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   drivers/perf/arm_pmuv3.c       | 67 +++++++++++++++++++++++++++++++++-
>   include/linux/perf/arm_pmuv3.h |  1 +
>   2 files changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 8fcaa26f0f8a..6d669b16a2bc 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -15,6 +15,7 @@
>   #include <clocksource/arm_arch_timer.h>
>   
>   #include <linux/acpi.h>
> +#include <linux/bitfield.h>
>   #include <linux/clocksource.h>
>   #include <linux/of.h>
>   #include <linux/perf/arm_pmu.h>
> @@ -294,9 +295,16 @@ static const struct attribute_group armv8_pmuv3_events_attr_group = {
>   	.is_visible = armv8pmu_event_attr_is_visible,
>   };
>   
> +#define TH_LO	2
> +#define TH_HI	13
> +#define TH_CNTL_LO	14
> +#define TH_CNTL_HI	16
> +
>   PMU_FORMAT_ATTR(event, "config:0-15");
>   PMU_FORMAT_ATTR(long, "config1:0");
>   PMU_FORMAT_ATTR(rdpmc, "config1:1");
> +PMU_FORMAT_ATTR(threshold, "config1:" __stringify(TH_LO) "-" __stringify(TH_HI));
> +PMU_FORMAT_ATTR(threshold_control, "config1:" __stringify(TH_CNTL_LO) "-" __stringify(TH_CNTL_HI));


>   
>   static int sysctl_perf_user_access __read_mostly;
>   
> @@ -310,10 +318,22 @@ static inline bool armv8pmu_event_want_user_access(struct perf_event *event)
>   	return event->attr.config1 & 0x2;
>   }
>   
> +static inline u32 armv8pmu_event_threshold(struct perf_event_attr *attr)
> +{
> +	return FIELD_GET(GENMASK(TH_HI, TH_LO), attr->config1);
> +}
> +
> +static inline u8 armv8pmu_event_threshold_control(struct perf_event_attr *attr)
> +{
> +	return FIELD_GET(GENMASK(TH_CNTL_HI, TH_CNTL_LO), attr->config1);
> +}
> +
>   static struct attribute *armv8_pmuv3_format_attrs[] = {
>   	&format_attr_event.attr,
>   	&format_attr_long.attr,
>   	&format_attr_rdpmc.attr,

> +	&format_attr_threshold.attr,
> +	&format_attr_threshold_control.attr,

Given this is not supported for !CONFIG_ARM64, does it make sense to 
remove them for that case, given we already take care of this in
the code using IS_ENABLED(CONFIG_ARM64) ? The nice part is that
the arm32 doesn't see something that is never usable. I understand
the maxthreshold=0 already gives out the hint.

Rest looks fine to me.

>   	NULL,
>   };
>   
> @@ -365,10 +385,38 @@ static ssize_t bus_width_show(struct device *dev, struct device_attribute *attr,
>   
>   static DEVICE_ATTR_RO(bus_width);
>   
> +static u32 threshold_max(struct arm_pmu *cpu_pmu)
> +{
> +	/*
> +	 * PMMIR.WIDTH is readable and non-zero on aarch32, but it would be
> +	 * impossible to write the threshold in the upper 32 bits of PMEVTYPER.
> +	 */
> +	if (IS_ENABLED(CONFIG_ARM))
> +		return 0;
> +
> +	/*
> +	 * The largest value that can be written to PMEVTYPER<n>_EL0.TH is
> +	 * (2 ^ PMMIR.THWIDTH) - 1.
> +	 */
> +	return (1 << FIELD_GET(ARMV8_PMU_THWIDTH, cpu_pmu->reg_pmmir)) - 1;
> +}
> +
> +static ssize_t threshold_max_show(struct device *dev,
> +				  struct device_attribute *attr, char *page)
> +{
> +	struct pmu *pmu = dev_get_drvdata(dev);
> +	struct arm_pmu *cpu_pmu = container_of(pmu, struct arm_pmu, pmu);
> +
> +	return sysfs_emit(page, "0x%08x\n", threshold_max(cpu_pmu));
> +}
> +
> +static DEVICE_ATTR_RO(threshold_max);
> +
>   static struct attribute *armv8_pmuv3_caps_attrs[] = {
>   	&dev_attr_slots.attr,
>   	&dev_attr_bus_slots.attr,
>   	&dev_attr_bus_width.attr,
> +	&dev_attr_threshold_max.attr,

Similarly here and could avoid the IS_ENABLED(CONFIG_ARM) above.

Suzuki


>   	NULL,
>   };
>   
> @@ -552,7 +600,7 @@ static void armv8pmu_write_counter(struct perf_event *event, u64 value)
>   		armv8pmu_write_hw_counter(event, value);
>   }
>   
> -static inline void armv8pmu_write_evtype(int idx, u32 val)
> +static inline void armv8pmu_write_evtype(int idx, unsigned long val)
>   {
>   	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
>   
> @@ -914,6 +962,10 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
>   				     struct perf_event_attr *attr)
>   {
>   	unsigned long config_base = 0;
> +	struct perf_event *perf_event = container_of(attr, struct perf_event,
> +						     attr);
> +	struct arm_pmu *cpu_pmu = to_arm_pmu(perf_event->pmu);
> +	u32 th, th_max;
>   
>   	if (attr->exclude_idle)
>   		return -EPERM;
> @@ -945,6 +997,19 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
>   	if (attr->exclude_user)
>   		config_base |= ARMV8_PMU_EXCLUDE_EL0;
>   
> +	/*
> +	 * Insert event counting threshold (FEAT_PMUv3_TH) values. If
> +	 * FEAT_PMUv3_TH isn't implemented, then THWIDTH (threshold_max) will be
> +	 * 0 and no values will be written.
> +	 */
> +	th_max = threshold_max(cpu_pmu);
> +	if (IS_ENABLED(CONFIG_ARM64) && th_max) {
> +		th = min(armv8pmu_event_threshold(attr), th_max);
> +		config_base |= FIELD_PREP(ARMV8_PMU_EVTYPE_TH, th);
> +		config_base |= FIELD_PREP(ARMV8_PMU_EVTYPE_TC,
> +					  armv8pmu_event_threshold_control(attr));
> +	}
> +
>   	/*
>   	 * Install the filter into config_base as this is used to
>   	 * construct the event type.
> diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
> index ec3a01502e7c..753f8dbd9d10 100644
> --- a/include/linux/perf/arm_pmuv3.h
> +++ b/include/linux/perf/arm_pmuv3.h
> @@ -255,6 +255,7 @@
>   #define ARMV8_PMU_BUS_SLOTS_MASK 0xff
>   #define ARMV8_PMU_BUS_WIDTH_SHIFT 16
>   #define ARMV8_PMU_BUS_WIDTH_MASK 0xf
> +#define ARMV8_PMU_THWIDTH GENMASK(23, 20)
>   
>   /*
>    * This code is really good

