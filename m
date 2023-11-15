Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC047EC342
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343864AbjKONH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343723AbjKONH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:07:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ECBCE;
        Wed, 15 Nov 2023 05:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700053672; x=1731589672;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aLJQ2t/eoVUWtbqu1Bs6HcdZoHlyjs3RpN0A6icd6yQ=;
  b=Qs1j/J4Y1AyKpzchKDh6Mrh9PQZBoF2SMHYpv+3bZtSb/WSN1KnHoXMj
   SY758YZuqyZ/5LMOoFIzlGHd0REa3J2uxkuSYBi4xnNb/zLHSapGbwoL8
   GTc59xzkl28XXMsQWL3/NTNS9At7MmHnFDqx8yUjZtp3ZbeVcTZGolu0f
   tz04/YOylg1brhbNJQmN+6Ee/HfffHb5XVqP5l/VvVa3mMpF5DV4goMKH
   eZmctAYw9lZ5ixjPOKUXYxndXVXKkG566zU9Rz+idKthJJiQp4UIfeNcb
   FC/rvIzpRD/YIYELsOJKH53/SUDv+EY/X/F7ZZEpB6hox84V/quiJ0VOs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="477092609"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="477092609"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 05:07:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="768576121"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="768576121"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 05:07:51 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 05:07:51 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 05:07:50 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 05:07:50 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 05:07:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOQU1LPGk+ZpnOIF8xEfaqckzazqqFxtNofeIO5Y5fQh5h0fHQISYpSx5rlSyGtZzz+ukUxqDMkWYAEXdye0JD2/y5wbhyycGBeOASbeyNYgepVbSGXatsYHtZQUKUmTyb97APD30A+1xO2PCSw0kxSSkl4FuE/Gg5tMWcah8/cZlXYb9tYV/J3EDy8IUFpLUYl60Bii7UmbQaCXOCq0aJu7vlAPlaqkvT89JchiMgYrV0ztKeUAd7/3v85p4INv53HxLHQfmpjlktOioA/x7ZMA8Q6Asm9urqSDI3EzApmE2vgzXrE+yksxdXVIoF+L+wReJfMn0JEOzN5/SjRx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGLI3iGXFgS/IxY8fziaGIfwNGBs/4w0je0UUKVPJNY=;
 b=HpRS6KADNaZ+0LHuF2g2IMxrGgqsYU4iU2evg7+SWu6PmwAUuYiMppA+ilxp2WsZBarHqMeW+3L4BDQzJqNYKcBohpmMQb+3bTtCNFRfe3PKFIuz1UQo2gg9WUfogbg15/KPdKP/bwJh/9DrKURnZO69x+/osb8Ye8CFwm8X8MWAhTEja7h9+qhxJ+axseK4AQDfuE4efA6JYu2REigCgSl8xX+oy+h0u/EWX9JJJN0Dh2W4KVUK8EFKITaQrQr+HQBlYPEFVRgQw5JtRoU9zlUqSzl9fHKC/gXRJ0MRTy6/kpVN4+F/YJghRSegiCCeOPAY4IigBjrTZ4WAZuq6fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH0PR11MB4775.namprd11.prod.outlook.com (2603:10b6:510:34::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 13:07:48 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 13:07:48 +0000
Message-ID: <271ef021-c0f7-4fd3-a64d-e94e24d46516@intel.com>
Date:   Wed, 15 Nov 2023 14:07:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/8] net: qualcomm: ipqess: Add Ethtool ops to
 IPQESS port netdevices
Content-Language: en-US
To:     Romain Gantois <romain.gantois@bootlin.com>, <davem@davemloft.net>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20231114105600.1012056-1-romain.gantois@bootlin.com>
 <20231114105600.1012056-5-romain.gantois@bootlin.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231114105600.1012056-5-romain.gantois@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::13) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH0PR11MB4775:EE_
X-MS-Office365-Filtering-Correlation-Id: bd38d165-a392-49d1-05ea-08dbe5dbdd94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzCCOzL0N7HqFJtc6THJIw92bCBaGXfow4VE36gRht/XLxsu1SlTmMjpvUjHpdPNx0AKI5ecYqqnhYxDiHAZu8S+wNlauZiaDtkpmP4vLHCzexR+U1mPZq1VOoSLnNT/YiZR3Gnjov7raMydK4Xu9bXUm1s921twbrlBoRUHtcF3juHgL3D6mpyxIrVkxec+F+80GjfLYAVxxphxJ5THsH8I3NfHXSSaXnekdFFylIdtBRb8QOuGlZZb0yvGl5qa2dA6TU7iJzfLu6qElHkr00QEDsu2CQix+Qabq7rD/dqy67aBccu64YBHAt6jhdt5JtmxWWAz74m/xdXXizbtCEqyqn8Un9nuIfGnw7TJ180cr1WQMSnsMHb44AHufEv8a9CUauq94tx+CnGbBFHMK6+9+jQ4RWTKRA6qBnenvg7JfJ5Lr6MOjqlv17INePNe5WuVKljhwH+XrMWylRNVw0qaYdQ5HvdPTpWOWyw9jIFfY90avdCP5vDmUkwOItjh1L09p77+g6zOFJMQqNNDu44JHMtVo9eHMWuXIN1zwti71TwpPUVKiOsRLGxkSnMBIibGkXuWUv0pXgL6C/BvGpcDWSDlgmnK1YzPzIFRPQzjU5IrWYoVjPZ5LgdO0rIqxj73XJSXR965yi7u+oFRFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(26005)(6666004)(6506007)(53546011)(83380400001)(44832011)(41300700001)(8676002)(7416002)(8936002)(6486002)(5660300002)(4326008)(478600001)(316002)(6512007)(2616005)(82960400001)(66556008)(66946007)(66476007)(54906003)(2906002)(31696002)(36756003)(86362001)(38100700002)(110136005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVJBTHdhRGw5bjV0Zkh4K2RuMnBuQVJmeVQvdWxpUmJsTGt6TitENEsyS2FH?=
 =?utf-8?B?dnYyaVNsVjlMcUo0TUlqeWc5Q2Ziei80eEtuTXNzYlBiVlFMZU04Smk3RzRS?=
 =?utf-8?B?Qm5hcXM3SU9CVTJJWU82WHBpUFQvOU1VamluYkVEdk5CWkZUTnFoL0F6emt5?=
 =?utf-8?B?SmtvY3FuaGs2OFVwcEg5VFVWeUMzNitQMmxLa2tUWUZpSGhOWTJUcG82dWNj?=
 =?utf-8?B?UDdkNUxzVEU1QkJPWGZoY1BxRTRBR2lYNHJPN3BnQjJxclhrNmhPeEdGdnhZ?=
 =?utf-8?B?NVJKOFFxR1YwWm9iM3VpQURRd1Z6SGxKOWxnS2lDaXMrcVlBZ0RlTUxTRjdi?=
 =?utf-8?B?OWN6TmNjSXBGZ1ZmZEJEQ3JqcUNnS2szb1MrUFp2dXNrWnhCeUhnQWE1NmMw?=
 =?utf-8?B?SVhwWVVHWmJrUjh6WE5iMzBPQnd4MkEvK2tMb2s4eExFU250b1JONDg5ejYz?=
 =?utf-8?B?U0U3UERNYU03a2dZYk81ZTRucXNjMDBBR21tVkpzYnJ2T0ZYVTNzK1FJem82?=
 =?utf-8?B?NU4yVEplU2FsQm5MRXBNcEJ0YzZST0pOenFMOTR3Uk1YUTdvOGUxajgxczlV?=
 =?utf-8?B?a0pOTitrOGI0WnhSQmZuYWRrMHJDTkRzczFEeXVWazNFNmkxdlNOMmZxeEIr?=
 =?utf-8?B?ZXVKeHhuTTBWaWdtYk8vSUF0bHVqSXliVFhkczI4c2RhZkpTVExRb2Zwekly?=
 =?utf-8?B?ZElIbUNrNnZRRHM0RFBpL1IweENiLzJ0NXhqdmFoUk03NG9Ea3FkSnFkbEtr?=
 =?utf-8?B?d0JiSnF0SmtiQytjQlR3NEM2bnd5NnRBdEdzQ0U5K0NFeXVibFpJM1poT0VK?=
 =?utf-8?B?bkowM3pQc2lJNEpSK0MvazZsU0IzQ3hTRnNMamU2WHpnUVVBWk1lb210c05S?=
 =?utf-8?B?MXJ5MlhIMTJpSXdyajZXczhyeWNzS3VDV21uQlZ4NnpHenhzZDdMOHZ4RHBk?=
 =?utf-8?B?b0VVWEZjVGZMaE05YVhOd2hXTEhDTWhpMGdGVkZ1WU52ZUZ1TkhWNWtkaWlQ?=
 =?utf-8?B?akVVUEM5a0s5SzMydkJpYlczUWd4UjVQWE11Qzc0NnFTdFNkbHZ1OVhDLzZF?=
 =?utf-8?B?TnpKeWtGd2k3eVJjK3pFYTJtRFRrbGpwcDlNWnN3VDllb3RFQ0NtUzJFdDlI?=
 =?utf-8?B?SzlRYjBjSURSNys1aDMyZm9rcHA4Z3gwTDEwWVp1dVU1aHlTR2p6ODBiT3hn?=
 =?utf-8?B?Nm9WNEhzOHF3bkp6Y0xVM3VoOG8ybnNkdDFUV2szUGM5aU0vVGNjbFUvQVBU?=
 =?utf-8?B?djBHb2VMbWQ1ZjNUc0Z4eVYyc0xoZ1NXMG5UZnhKNW5VWUhLandGWGVpOFc1?=
 =?utf-8?B?Y1Y1K2NTRjZjNmVSZ1VsTzhjYS8zMUgxT0V1WEx0dzg1NndYSURHUWhMak8v?=
 =?utf-8?B?ZS90Ryt2YVlaMkhzQytzakpaQ205azREc090OUVsYWFEaXFWVEtBcDdxY1ow?=
 =?utf-8?B?ekJFbjI0RzlQU1JLU1ZxT01zR09YUzN6NEY5Um00bTZKQ0RZMzBxREdIWWVi?=
 =?utf-8?B?U3V2eW9GRUxHaUxNbHY3cVUzNy92NXpGb21QY0Fka1NYWHlQbVZYWUNQc2xx?=
 =?utf-8?B?UUxwWGFqK1VKdENaSHN0UlZaMVl1bmFIS01uYVVVbytSMGJQS1VXenJ5UmRV?=
 =?utf-8?B?MXZyL3FkVDBnekpSOS9TMC83Nkx6R1IxMHhMcDdtUnd0VExTSlhSekRWeHdF?=
 =?utf-8?B?MWdxUmVsRjV6NXBCSjN1NXBXWXdFVlUwV1B2emZ1S012cFFod0d5YmJVdDZO?=
 =?utf-8?B?eUFQbUVCMURBS2pYSWRTL0ZycmFQZnRrbzYwNkwrK0FXY1UvN0lUUzZzNFVD?=
 =?utf-8?B?eUg4VTBYZ1dpYkZTbWE2UEdoMjc2aEJoejdnYk15UXkvcmNXdWhwMzBoT2h2?=
 =?utf-8?B?V25VZ1JOYmFqSDZ1Sk9WSjRzZ1BqN2JzTlg3VW1YUmNWZ01tK1pRV0FjbU0r?=
 =?utf-8?B?NktoT2ZwTU5rRUJuQm1PdWM4TWhCNlZpeWdJbVU3Z00zQ1RpTVdKdFl1cUZJ?=
 =?utf-8?B?NUc2b3ZhalQ0WDdGV2dpclZlZzZoYWN1QTh2UWNPSUNvczl5UHowelNJRTlu?=
 =?utf-8?B?OENFN3VXTDdIa1hiWUVUWS80cmU1djAyenlkcmt1c0EwNFpNbm85S0FrM0VS?=
 =?utf-8?B?NzZONWl5QmdJeUZrZGRQVG5oZWFLeXowSUcxa1lWSW1ZVllrSG1pa3p5WmU0?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd38d165-a392-49d1-05ea-08dbe5dbdd94
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 13:07:48.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9DtA6FMgptXJag4rSyee8CmYAbPyUSoAKBQAsfy1W8l8QJ9uircp985NrJP2a/+E+ZPlV2zAwJnqKiYaiYHLudcaRqtOwbRHzL5VzEo64A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4775
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.11.2023 11:55, Romain Gantois wrote:
> The IPQESS driver registers one netdevice for each front-facing switch
> port. Add support for several ethtool operations to these netdevices.
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  drivers/net/ethernet/qualcomm/ipqess/Makefile |   2 +-
>  .../ethernet/qualcomm/ipqess/ipqess_ethtool.c | 245 ++++++++++++++++++
>  .../ethernet/qualcomm/ipqess/ipqess_port.c    |   1 +
>  .../ethernet/qualcomm/ipqess/ipqess_port.h    |   3 +
>  4 files changed, 250 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_ethtool.c
> 
> diff --git a/drivers/net/ethernet/qualcomm/ipqess/Makefile b/drivers/net/ethernet/qualcomm/ipqess/Makefile
> index f389080cc5aa..6253f1b0ffd2 100644
> --- a/drivers/net/ethernet/qualcomm/ipqess/Makefile
> +++ b/drivers/net/ethernet/qualcomm/ipqess/Makefile
> @@ -5,4 +5,4 @@
>  
>  obj-$(CONFIG_QCOM_IPQ4019_ESS) += ipqess.o
>  
> -ipqess-objs := ipqess_port.o ipqess_switch.o ipqess_edma.o
> +ipqess-objs := ipqess_port.o ipqess_switch.o ipqess_edma.o ipqess_ethtool.o
> diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_ethtool.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_ethtool.c
> new file mode 100644
> index 000000000000..06a8f2cccc4e
> --- /dev/null
> +++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_ethtool.c
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Ethtool operations for a single switch port
> + *
> + * Copyright (c) 2023, Romain Gantois <romain.gantois@bootlin.com>
> + * Based on net/dsa
> + */
> +
> +#include <net/selftests.h>
> +
> +#include "ipqess_port.h"
> +
> +static void ipqess_port_get_drvinfo(struct net_device *dev,
> +				    struct ethtool_drvinfo *drvinfo)
> +{
> +	strscpy(drvinfo->driver, "qca8k-ipqess", sizeof(drvinfo->driver));
> +	strscpy(drvinfo->bus_info, "platform", sizeof(drvinfo->bus_info));
> +}
> +
> +static int ipqess_port_nway_reset(struct net_device *dev)
> +{
> +	struct ipqess_port *port = netdev_priv(dev);
> +
> +	return phylink_ethtool_nway_reset(port->pl);
> +}
> +
> +static const char ipqess_gstrings_base_stats[][ETH_GSTRING_LEN] = {
> +	"tx_packets",
> +	"tx_bytes",
> +	"rx_packets",
> +	"rx_bytes",
> +};
> +
> +static void ipqess_port_get_strings(struct net_device *dev,
> +				    u32 stringset, u8 *data)
> +{
> +	struct ipqess_port *port = netdev_priv(dev);
> +	struct qca8k_priv *priv = port->sw->priv;
> +	int i;
> +
> +	if (stringset == ETH_SS_STATS) {
> +		memcpy(data, &ipqess_gstrings_base_stats,
> +		       sizeof(ipqess_gstrings_base_stats));
> +
> +		if (stringset != ETH_SS_STATS)
> +			return;
> +
> +		for (i = 0; i < priv->info->mib_count; i++)
> +			memcpy(data + (4 + i) * ETH_GSTRING_LEN,
> +			       ar8327_mib[i].name,
> +			       ETH_GSTRING_LEN);
> +
> +	} else if (stringset == ETH_SS_TEST) {
> +		net_selftest_get_strings(data);
> +	}
> +}
> +
> +static void ipqess_port_get_ethtool_stats(struct net_device *dev,
> +					  struct ethtool_stats *stats,
> +					  uint64_t *data)
> +{
> +	struct ipqess_port *port = netdev_priv(dev);
> +	struct qca8k_priv *priv = port->sw->priv;
> +	const struct qca8k_mib_desc *mib;
> +	struct pcpu_sw_netstats *s;
> +	unsigned int start;
> +	u32 reg, c, val;
> +	u32 hi = 0;
> +	int ret;
> +	int i;
> +
> +	for_each_possible_cpu(i) {
> +		u64 tx_packets, tx_bytes, rx_packets, rx_bytes;
> +
> +		s = per_cpu_ptr(dev->tstats, i);
> +		do {
> +			start = u64_stats_fetch_begin(&s->syncp);
> +			tx_packets = u64_stats_read(&s->tx_packets);
> +			tx_bytes = u64_stats_read(&s->tx_bytes);
> +			rx_packets = u64_stats_read(&s->rx_packets);
> +			rx_bytes = u64_stats_read(&s->rx_bytes);
> +		} while (u64_stats_fetch_retry(&s->syncp, start));
> +		data[0] += tx_packets;
> +		data[1] += tx_bytes;
> +		data[2] += rx_packets;
> +		data[3] += rx_bytes;
> +	}
> +
> +	for (c = 0; c < priv->info->mib_count; c++) {
> +		mib = &ar8327_mib[c];
> +		reg = QCA8K_PORT_MIB_COUNTER(port->index) + mib->offset;
> +
> +		ret = qca8k_read(priv, reg, &val);
> +		if (ret < 0)

		if (ret)

> +			continue;
> +
> +		if (mib->size == 2) {
> +			ret = qca8k_read(priv, reg + 4, &hi);
> +			if (ret < 0)

same

> +				continue;
> +		}
> +
> +		data[4 + c] = val;
> +		if (mib->size == 2)
> +			data[4 + c] |= (u64)hi << 32;
> +	}
> +}
> +
> +static int ipqess_port_get_sset_count(struct net_device *dev, int sset)
> +{
> +	struct ipqess_port *port = netdev_priv(dev);
> +	struct qca8k_priv *priv = port->sw->priv;
> +
> +	if (sset == ETH_SS_STATS) {
> +		int count = 0;
> +
> +		if (sset != ETH_SS_STATS)
> +			count = 0;
> +		else
> +			count = priv->info->mib_count;
> +
> +		if (count < 0)
> +			return count;
> +
> +		return count + 4;
> +	} else if (sset == ETH_SS_TEST) {
> +		return net_selftest_get_count();
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int ipqess_port_set_wol(struct net_device *dev,
> +			       struct ethtool_wolinfo *w)
> +{
> +	struct ipqess_port *port = netdev_priv(dev);
> +
> +	return phylink_ethtool_set_wol(port->pl, w);
> +}
> +
> +static void ipqess_port_get_wol(struct net_device *dev,
> +				struct ethtool_wolinfo *w)
> +{
> +	struct ipqess_port *port = netdev_priv(dev);
> +
> +	phylink_ethtool_get_wol(port->pl, w);
> +}
> +
> +static int ipqess_port_set_eee(struct net_device *dev, struct ethtool_eee *eee)
> +{
> +	struct ipqess_port *port = netdev_priv(dev);
> +	int ret;
> +	u32 lpi_en = QCA8K_REG_EEE_CTRL_LPI_EN(port->index);
> +	struct qca8k_priv *priv = port->sw->priv;
> +	u32 lpi_ctl1;

RCT

> +
> +	/* Port's PHY and MAC both need to be EEE capable */
> +	if (!dev->phydev || !port->pl)
> +		return -ENODEV;
> +
> +	mutex_lock(&priv->reg_mutex);
> +	lpi_ctl1 = qca8k_read(priv, QCA8K_REG_EEE_CTRL, &lpi_ctl1);
> +	if (lpi_ctl1 < 0) {

	if (lpi_ctl1)

> +		mutex_unlock(&priv->reg_mutex);
> +		return ret;

ret is not initialized at this point

> +	}
> +
> +	if (eee->tx_lpi_enabled && eee->eee_enabled)
> +		lpi_ctl1 |= lpi_en;
> +	else
> +		lpi_ctl1 &= ~lpi_en;
> +	ret = qca8k_write(priv, QCA8K_REG_EEE_CTRL, lpi_ctl1);
> +	mutex_unlock(&priv->reg_mutex);
> +
> +	if (ret)
> +		return ret;
> +
> +	return phylink_ethtool_set_eee(port->pl, eee);
> +}
> +
> +static int ipqess_port_get_eee(struct net_device *dev, struct ethtool_eee *e)
> +{
> +	struct ipqess_port *port = netdev_priv(dev);
> +
> +	/* Port's PHY and MAC both need to be EEE capable */
> +	if (!dev->phydev || !port->pl)
> +		return -ENODEV;
> +
> +	return phylink_ethtool_get_eee(port->pl, e);
> +}
> +
> +static int ipqess_port_get_link_ksettings(struct net_device *dev,
> +					  struct ethtool_link_ksettings *cmd)
> +{
> +	struct ipqess_port *port = netdev_priv(dev);
> +
> +	return phylink_ethtool_ksettings_get(port->pl, cmd);
> +}
> +
> +static int ipqess_port_set_link_ksettings(struct net_device *dev,
> +					  const struct ethtool_link_ksettings *cmd)
> +{
> +	struct ipqess_port *port = netdev_priv(dev);
> +
> +	return phylink_ethtool_ksettings_set(port->pl, cmd);
> +}
> +
> +static void ipqess_port_get_pauseparam(struct net_device *dev,
> +				       struct ethtool_pauseparam *pause)
> +{
> +	struct ipqess_port *port = netdev_priv(dev);
> +
> +	phylink_ethtool_get_pauseparam(port->pl, pause);
> +}
> +
> +static int ipqess_port_set_pauseparam(struct net_device *dev,
> +				      struct ethtool_pauseparam *pause)
> +{
> +	struct ipqess_port *port = netdev_priv(dev);
> +
> +	return phylink_ethtool_set_pauseparam(port->pl, pause);
> +}
> +
> +static const struct ethtool_ops ipqess_port_ethtool_ops = {
> +	.get_drvinfo            = ipqess_port_get_drvinfo,
> +	.nway_reset             = ipqess_port_nway_reset,
> +	.get_link               = ethtool_op_get_link,
> +	.get_strings            = ipqess_port_get_strings,
> +	.get_ethtool_stats      = ipqess_port_get_ethtool_stats,
> +	.get_sset_count         = ipqess_port_get_sset_count,
> +	.self_test              = net_selftest,
> +	.set_wol                = ipqess_port_set_wol,
> +	.get_wol                = ipqess_port_get_wol,
> +	.set_eee                = ipqess_port_set_eee,
> +	.get_eee                = ipqess_port_get_eee,
> +	.get_link_ksettings     = ipqess_port_get_link_ksettings,
> +	.set_link_ksettings     = ipqess_port_set_link_ksettings,
> +	.get_pauseparam         = ipqess_port_get_pauseparam,
> +	.set_pauseparam         = ipqess_port_set_pauseparam,
> +};
> +
> +void ipqess_port_set_ethtool_ops(struct net_device *netdev)
> +{
> +	netdev->ethtool_ops = &ipqess_port_ethtool_ops;
> +}
> diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
> index f0f5fe3a7c24..52d7baa7cae0 100644
> --- a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
> +++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
> @@ -684,6 +684,7 @@ int ipqess_port_register(struct ipqess_switch *sw,
>  	netdev->dev.of_node = port->dn;
>  
>  	netdev->rtnl_link_ops = &ipqess_port_link_ops;
> +	ipqess_port_set_ethtool_ops(netdev);
>  
>  	netdev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
>  	if (!netdev->tstats) {
> diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
> index 26bac45dd811..19d4b5d73625 100644
> --- a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
> +++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
> @@ -59,4 +59,7 @@ int ipqess_port_register(struct ipqess_switch *sw,
>  			 struct device_node *port_node);
>  void ipqess_port_unregister(struct ipqess_port *port);
>  
> +/* Defined in ipqess_ethtool.c */
> +void ipqess_port_set_ethtool_ops(struct net_device *netdev);
> +
>  #endif
