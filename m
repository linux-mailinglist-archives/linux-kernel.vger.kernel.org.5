Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46237D8C2A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjJZXVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjJZXUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:20:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9818D43;
        Thu, 26 Oct 2023 16:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698362453; x=1729898453;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0dFLx1c2ZpzetMEN0QHXWaMJkusSpDqxv+mHcXIpSIs=;
  b=A5xCDL0JLFvjp54znNaiSOyWs/Ll1TVw/0+wBi1Rd0rDmKSXjNoCCeqN
   G7r8hajbmNXCYMNXYe5okyhCO1NwaR8xWisH73a9ZEDIF1MJAwDIKPA9e
   9FacJVM5E0VTn/XR4sy91BqHTgbukWj3GoqlIKDmaq2eAndOoluFduvWN
   IGpnvHekj0aDKWoW347SxWS0vjjt86Xxvxa5IhKHXh+p/XkWbSwU0Sl/I
   8ZYonRqqDGyODPyoUWP5y4CMwDxaHqAfaWQz9LjltrU7sokvLBs6vaGth
   GxuB8s4vmgRzT4nc0GAdvINqrxPxxMqKRxhCuo2IyTqj6NtjnEwQqoYcm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="466848"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="466848"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 16:20:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="654687"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 16:20:40 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 16:20:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 16:20:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 16:20:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBQ2Ihd+NJ1Syp75UKriB0V/29jsQ+o1gqCB4Se26uY7iocReO246+Q+gWKCWViRhQrfTH/O70/7LrESbEnqqWHJUEgdediQyF6gkmH4WBknc99UB/Se7r8C7LQ+wsUtOs7xiI2m+sNpVfuHqAfA2LD7qZwRa4y/vJAl/O7ozytRn5RRlEveV1Zm2vLV57xyUvbiCmRknzEncieOt1WlVjVYmGqEPEZvRXOHQdyXu6OjCV68r6Q8KYDW0okbK1bgxqB+FhK6oECjnyiUOQ26kXxbZAca/oOR+kA4HaWc+puWDrhfcMZlDOkOFxT9zyll+yQUmNQB0dt3oQyt88PO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9NRBTv8b7cPExpJDlgNxqwXhGHX4UMTBe+l1j/tX6g=;
 b=TcGjhqziOecSmtbCVFl8OJdSAYg9AOfBHzgpPK1ES+4adxDnX/MpuXUapS8w1QIbClCDVQwcIkkuoBlI2MGMASJ7gM8y9uZPD0Owg2gq02NHCAnSjBqF+4uaataPjcFplQb3roUfq01gkgmkNeEFoFgfhs/R31+cKsVacOfWZbTsqb33WmMizkhjbdqP8GCZ/GDEzcsLXWvaxKlNMkhC+5cZXVkPzwdR34kRX7c6HdQPTAd2979gsdZVGHBPjCu0j1ui/vyNgpuUZyjs7aNUs8jXDejGq7ZzpqZJcGvBQ4H7bvERjx0n22IYegBO7hy6EXN9wbITFT27kUKlOKGFQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7385.namprd11.prod.outlook.com (2603:10b6:208:423::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Thu, 26 Oct
 2023 23:20:43 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 23:20:43 +0000
Message-ID: <0e64566f-6dfe-49a7-aeac-21ed9e66bd75@intel.com>
Date:   Thu, 26 Oct 2023 16:20:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/5] net: phy: Add pluming for
 ethtool_{get,set}_rxnfc
Content-Language: en-US
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        <netdev@vger.kernel.org>
CC:     Doug Berger <opendmb@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "Tariq Toukan" <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
        Willem de Bruijn <willemb@google.com>,
        Daniil Tatianin <d-tatianin@yandex-team.ru>,
        "Simon Horman" <horms@kernel.org>,
        Justin Chen <justin.chen@broadcom.com>,
        "Ratheesh Kannoth" <rkannoth@marvell.com>,
        Joe Damato <jdamato@fastly.com>,
        "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
        Jiri Pirko <jiri@resnulli.us>,
        "open list" <linux-kernel@vger.kernel.org>
References: <20231026224509.112353-1-florian.fainelli@broadcom.com>
 <20231026224509.112353-4-florian.fainelli@broadcom.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231026224509.112353-4-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:302:1::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7a51af-34cd-49c7-965e-08dbd67a2d13
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vvOd29/MVLM+LPjznJfFK1gbSMYQCswUKbunShAIRQ5OIRqn4avC/PzUqxg2TNtkGNuvfwUZP8cT1msWDc4Rj1c1o8+bbpzHFE66H4HeanCXVWeH/u7vm9vaeHo/XdIxhrW/mHOcnT9dtSMn//qFk6ypkvT0XWJwj7A+Zbvnks3CUkeUGf42/QQiO/Q7azoKkxb/ZTZw36VX2LuDLf9n2ABMn6cZQj+eiW0DZpVfMEfXmIGZtlJ9UlM+eVFzuGY0GdP2AG82d4yVL+md7YJZwDsP9fZdTVEwBmQTK+7PGiLF1wUsytAOkO5DfIGibrXPrQJ5NLpo12jS9OSPwhYbt+oZyNq0kK99SpCvi/zSshdCNrjJeA8rR2BlBIV2jdYpToeBrL457euhBGiLvlAfXqS0e96RKe6CaWT90WUSr6Ro8f88Q0gME2FEfeGYcjV9WO1X5M5zzOfR/naS6a/PHzGg/XTcQk4FSkKMIL+9bEl0PKf6vz5bfaM4S7SRmlNNxBR+TGP5uEhOIoyadZyIiaWGDXot3ZUH/2zO+lKQ8TNYZ6WvIZQeLq6hoMlcj9ZgJeSAJ6aCzAb/7yZcfM+bUTvHNas53nFmydJD4sSVMU1LiyTwTrZyaApVBftWzZMKO821Qbi3jjoG9z65+a7Apw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(66476007)(66556008)(66946007)(316002)(82960400001)(54906003)(31686004)(6666004)(6512007)(6506007)(53546011)(478600001)(6486002)(26005)(2616005)(4326008)(8676002)(8936002)(36756003)(31696002)(86362001)(41300700001)(5660300002)(38100700002)(2906002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTNsZ2RVa0l0QnV0K3F5VERJd2dNenYxWkJuY1ZlOHV2SW9xVTJ5UHM1Vldu?=
 =?utf-8?B?enVJckcxdURaYWgxRnFIcFlIbTJ1UVJiVm0yTVJrUmliRFdPbVc2UUpDakpH?=
 =?utf-8?B?SjNzb0RxV2M3Z2ZLQ2Y0M3JjaFJoZjRXUjdBRUNwK2kwUDZvaUs5MTlnRW1i?=
 =?utf-8?B?RkxObHpNOTNHaTZVdWF4Uk5TYkRGWlA0VnhYTXJ0b0VHM0hmaytGWWl3Ujha?=
 =?utf-8?B?Qk45TlZtdUJ4YjRyWjRZSGtRcmdZVjd4a2orTDdXOXNiOHdWN1gyOUtNRU5P?=
 =?utf-8?B?SlA0RXRwdzBhaXRHTDJNL0FMR0tpbmxGZmh4dDBrSVlxRllRUHIzUDcwSGYz?=
 =?utf-8?B?UTFsdUs5NGZ0L3REMTl0QWgrVlZ0NmhnbnlYSVM5M0w4S1o2ZTVBbnJJdFp5?=
 =?utf-8?B?a0s3d05Gb1BBbGVubHpLUkRVNmhlQ2o0TmQzR3R4TWlLZlUwek9aTnRaSTg2?=
 =?utf-8?B?S0NNbHExdzNBRTlWSEg4emUzOXF3VVFiMERkK2hvNmZ2dGVmcXhNNzIvOW9L?=
 =?utf-8?B?a0RoVVNFbkd3bWFvRWZOeExXSHNWMFMvdVZGeUI1YlkraVRRSXpKYjBUNEZo?=
 =?utf-8?B?bTRCdXRzTmhhSHZ3VjM2bkhyNzBwM3dlb1czOVhUVWx3Rkg4d1hlZlhYeGdG?=
 =?utf-8?B?c3VHdEJNZ3FpMzVlWDhodlpIMk5iL3RJdTdnSXJrc0NpUXZ5dW1xcVhWMDRC?=
 =?utf-8?B?cVdoVkpsRmVIWWJEK1BSdDkzc2RuRzd4SXJTTGRuclc3Z2FKZC93TlFCWktk?=
 =?utf-8?B?V2VqY1RpL0hLOUl4dlBsV1VzNHVmM0dVaFdna3hGM25UZG9pd2JOSTFYZUJk?=
 =?utf-8?B?Nlg4aWhiWkdGaVRoLzBFOWJvUW5GRnFhcWdZN3JTS2xwcmVrUjNkV0RkYU5t?=
 =?utf-8?B?WVFLcTR0dnQwK2hnTjA5OUQ1MnFOQWREdGxiUU9pclNhZlZGRkRmT2FvdkdD?=
 =?utf-8?B?a3dCSDl0VlRnd0FwZmY3bWNXZVY3WDI2ZjVvZkZ4T3ExSWtFZVZPb3IyRm5R?=
 =?utf-8?B?dCtyTk1sNUpUWlB0QllFZWlUSzJQTFVuMWlKTmc1WlYzdkV2QXptdzY0QnU0?=
 =?utf-8?B?RjVHb1Q0WHJMays0TlM3SDN4NlRwdW9jRmNHR3V1RDNtOXR6ZHNaZGhDbnhO?=
 =?utf-8?B?VTBIRWQxYmdubXUra05BbEtTdXlCSEN0Y0Vpdi9yQmlDUTJCallqK09BekZa?=
 =?utf-8?B?UmxUUEtsNnhoeVJsTzFLQUFsbUJtNlZyVWlSMUFTTmRwR3VxMHJrd2ltUmIv?=
 =?utf-8?B?R3FjcHJHTGVUVTNiZG9WWU5PN1VJNUdyK282dEdwTnJqVStTNnlNTlJpZng4?=
 =?utf-8?B?YnI5elFpclI1cEVLUkxiVHU1WGVoT3d5RGZBQmh4TSsvTmtRbElWSDczNlA5?=
 =?utf-8?B?M2IyYklVNTl1dWp4VDhZT2VUYkFEVGxkd0g0ZWgyWFozNm5QV0Q4bkVmcjVy?=
 =?utf-8?B?SisrS1pXUXNxZ1J5U3ZVc1NWRUp2bkFLU0Fyd1NSL0FMY0dkblRaN28yT3hn?=
 =?utf-8?B?NkFEYWxZWGZUQmMwaTlZaWVDdHJ2NnJsWkk1Skx6L3dpZ0gxRmFkMGpvd0Vp?=
 =?utf-8?B?RnFEdjJEejlqYjFCTXBCSW1nMnFyVjIxV3Q4UExzOU1WdFIxNXNFc1N2MlVp?=
 =?utf-8?B?MVVrYlNFdmxWa0d5M2YrMFRMUUl3LzJrVnY0cXdneFBnaFIxOEliZEtDYmEr?=
 =?utf-8?B?KzNFTDFkekNZZ08yaDJ0citxb25oN3Q0bk9Kb0tpN3RnRGhvNmx6TGpmM3RO?=
 =?utf-8?B?YURlQnFob3I3d0hzMWVNSkdQMUNuYnJ1NW9hNDIxNEF5cjR4UHdiVUNxTyt2?=
 =?utf-8?B?aVZ6RGhMZi9ueWE3bUdtd2x2dlo5OHFUSnlWYjZJTlVqRytxanRabGY1ZXpi?=
 =?utf-8?B?NzR2eUp5enoxT0NIemFDOXl4K0RkeHFiRXAzNU5JelBKcXhyTU5ENkZwSGNk?=
 =?utf-8?B?STJKTlAwaitmdmtzK1orQU45S1Z5Wm1IbkhJTDRWekE4L3k2TmpHc2krOFFC?=
 =?utf-8?B?Umx4VVRGZ0ExbzFnamdHQVp5UkhCR0ZNT1pZWlVoKzlOM3p6emExUjVWbHFX?=
 =?utf-8?B?dXc4QW1vS3ZqdUx0aVVBTlg3OXFtRmZibERIWk5WSkp0RjV2UG8rVC9yaEZO?=
 =?utf-8?B?QmRaaHhaTDBQakJObjloc3RPUkVMa0JWUVpXRDQ5bVZDaWJCdHNSa3o0ODFT?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7a51af-34cd-49c7-965e-08dbd67a2d13
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 23:20:43.4824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f525BcmEbFkEyOUM6DzMPl7hu854OVYJnB5SC1pRxkqt917+BAFWWFr7jApnOZSBw+hGkSycK/SwLhoIKiPIdSIbGs3eo5Mwh5UAMOqYl7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7385
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/2023 3:45 PM, Florian Fainelli wrote:
> +EXPORT_SYMBOL(phy_ethtool_set_rxnfc);
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 3cc52826f18e..03e7c6352aef 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1077,6 +1077,10 @@ struct phy_driver {
>  	int (*get_sqi)(struct phy_device *dev);
>  	/** @get_sqi_max: Get the maximum signal quality indication */
>  	int (*get_sqi_max)(struct phy_device *dev);
> +	/* Used for WAKE_FILTER programming only */

Any particular reason this comment is required? I don't see it enforced
above so I'm curious.

> +	int (*get_rxnfc)(struct phy_device *dev,
> +			 struct ethtool_rxnfc *nfc, u32 *rule_locs);
> +	int (*set_rxnfc)(struct phy_device *dev, struct ethtool_rxnfc *nfc);
>  
>  	/* PLCA RS interface */
>  	/** @get_plca_cfg: Return the current PLCA configuration */
> @@ -1989,6 +1993,10 @@ int phy_ethtool_set_plca_cfg(struct phy_device *phydev,
>  			     struct netlink_ext_ack *extack);
>  int phy_ethtool_get_plca_status(struct phy_device *phydev,
>  				struct phy_plca_status *plca_st);
> +int phy_ethtool_get_rxnfc(struct phy_device *phydev,
> +			  struct ethtool_rxnfc *nfc, u32 *rule_locs);
> +int phy_ethtool_set_rxnfc(struct phy_device *phydev,
> +			  struct ethtool_rxnfc *nfc);
>  
>  int __phy_hwtstamp_get(struct phy_device *phydev,
>  		       struct kernel_hwtstamp_config *config);
