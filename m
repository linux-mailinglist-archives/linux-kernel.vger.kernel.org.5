Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153B87EE176
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345057AbjKPNXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjKPNXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:23:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE238CE;
        Thu, 16 Nov 2023 05:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700141025; x=1731677025;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9fAk2AVahsCC+fGbERZpE/6f/Y7dA/bYpQWCoYTGZw4=;
  b=AT+3t38SH5FpW0d5znjJupHHTLBMrR0wSuOiNqCWOgqNDCH1CNapsxFU
   rQAOxxLKI6uRewSzU2y3j/qv2kCoKOKUC0VEmj9rlSFkaETIIZb3PgJlK
   EgG2yfvv7s9qN2k7cU9na7FaZpRerjiwMBgqnAmiNaRolvfjhmsAJuGaf
   bGmuFFcxQLZrx7zlsxyLtj/5svQrFbrkdvgpv0OteklwGYiucMD0FYV9L
   lT57l2wOWNiNVrcx5RrjNkHBoaw1GzQ2i6nP1gJ2ocvMpvQ8po9UV0FOA
   GVRoOn+solRr73J/npO5Xlw2tRC4tRP7PBnKnpqn24Y6sbnnlPqgPPdMZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="389945444"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="389945444"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 05:23:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="1012610706"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="1012610706"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 05:23:43 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 05:23:42 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 05:23:42 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 05:23:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liphdhurXMF0s5AIqaxjvDrARxQwyntGVbLTd5vsmFGZohndy+rNU17fskvDKusuuWD9aCfIAwwfPVYeyFHB57JDjypEdyF7xs0Ez5fuf+vZHJVaZ/dQHEpq5y8ipbXHA++b4cRjd8Znd2wShYTedySEbEDaqbVeVwLfgIjzMT38DKHb5BicWe/k6VorqHoM6SLlXEACJVwsCFQvm7OOId6jBW2RdXmHR3i0cJlratcsk73chSGUWJ7blrbS08QtEDCpAqG/vFCd2JzJ7f6YtXaudsu8NeRC94MkknqejDPwd2Z6tcOHJ3JcSxkAPnqbbMenffaAdVRrI+kUCjy+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQ+QUfoG1U/OCB5K1yllWi1XBojJJ+URg0VmwIb0VNI=;
 b=VQCMPPIoMfWC0t5O2oBVYjBd+oZnjSKYaD+HYhU3Ik8LcZDlBD61/FAIIDkkeUKNKUlLeJ4giuJc/onHBll+Tgct4EPW/fUwMuw5Vs07uxD6OyfYfU7rIh08s8w4qLWOeuipQBGi0tfYZ/MNUbCu/K4VEWZx1CJYXGPKq3y26JBs997o0AVWB3kA47TpLuowy3VXqIdbBfaGHXN0rd0T5JeJUC2O3OI7T0ZKv0PDOZdyn079BK8TnWfkZqwE6RzUyVXrMO8qvjCA9uYAEGrGHLmk5uwarOOb0zDnLaFdPkLmR7tKntIe/o/HCAKTobPwJxLE6Rczwat5FdNPzgJ13A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by IA1PR11MB7823.namprd11.prod.outlook.com (2603:10b6:208:3f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 13:23:38 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 13:23:38 +0000
Message-ID: <1ff87e22-ba18-4667-ac67-ec50cad12f19@intel.com>
Date:   Thu, 16 Nov 2023 14:23:29 +0100
User-Agent: Mozilla Thunderbird
From:   Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH net-next v3 5/8] net: qualcomm: ipqess: add bridge
 offloading features to the IPQESS driver
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
 <20231114105600.1012056-6-romain.gantois@bootlin.com>
Content-Language: en-US
In-Reply-To: <20231114105600.1012056-6-romain.gantois@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::10) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|IA1PR11MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b00029b-36b0-4b2d-1051-08dbe6a73e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3U1iektmet7nJO5/Kv8cp6zkjF0hdTJ2DpSA5O02zWKplLQzYnhWY8aApJ6V8OTfJnNnmN/4VS/qqGpaeAwOH0T5uEofCPkbT/lLiSgGXgXUMRnrkq5NX01ZigPa1Y+ZG0JQmE71k1OcxmFNT83UK+9ky76vwX4q0ppt5g03Ki9fYhzIuP2MQq9EiNBC6H/Lk3RheSmsATeH2gOUT/KSuPTERvLJGY46JI9ETJoysyZbTmMdSfoXi07O6m/JnpMABQEqxqgQpc4VTnTLlCVNp83orchdbNGQ2e28RL+ph6esVMtCGRJowHJWPz9/bZlIA2l9ikT1dSJ9SpdW/xmkKlCJ34+WsnjvcTsE7cammHDeBIJDW/gYCj78ySxQYKAWGCDz35M5KmmXQ6MDuplKPVeTjZRefT9Pm1AZuL8WTkAHnGarslkQ95IhTHNc16zJ3gVFr88lj6W8dGvZLm6ew3IgKRZYtCcVZSc7EIjFK2o+flt5sPvx8Hm//SQ5Wpe1mzMEqgE7L72F2XKkg/bZedan4yvLfEUTccigijFIhGVoGCQG/vIwfGELFYRYQYy+zcYxsseXu+hr2Ujrc2O7IhE7mBblVYRtlJo9fMBUmPxtmdhegY+mi3J+9bXMp43uzn2SHpyKOwauhWXaQ0BvfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(66946007)(110136005)(66476007)(54906003)(66556008)(38100700002)(86362001)(31696002)(82960400001)(36756003)(83380400001)(26005)(6506007)(6512007)(2616005)(53546011)(6666004)(2906002)(30864003)(316002)(6486002)(478600001)(5660300002)(8936002)(8676002)(4326008)(44832011)(41300700001)(7416002)(45980500001)(43740500002)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFVtTkxhL0ttRWJwZDd5UnBVSFFGd3dPcTJwL0dBVXpXRE43eUk5TjFHMExK?=
 =?utf-8?B?Y25tSldabFRkUFpFMEJQRlJybWhzbmQzWG5GeExrR0dGRWQwT3pqQ1I3b0NF?=
 =?utf-8?B?cXRac3ZqU1ZTL1c0Q2NrTHBVTnVUUXFHV0lrWFZxZmFIenJhcWxpS3RKeklK?=
 =?utf-8?B?QVdqU1QwWnc0WnYxeDd0Y0N2SVBxK2cxeXNSZEkwQ1N4WDdBeHZiU0dNRCtQ?=
 =?utf-8?B?TEVwY21HbndkQlMvUnZzQjVRLzJZZHB4S25jdEU2QTNCTjFFVzZmWHZlQ3pr?=
 =?utf-8?B?VUpjTnFrcVd4UExVZ1RscjRsRkJkS0taeWM3c2QxMlNONHY2a3ZpSVJjdHBV?=
 =?utf-8?B?UzFOUm11QWZkeURLMU5EWHFia1V6bjFnanlmZkFUWUhEdi85eVdRdmNjR2lX?=
 =?utf-8?B?ZWpHV3A2V2VWUGgrR3lOOVpjZkkyM2ZPRHI3NHN1dkVycFFzMFhmMVNzMTM2?=
 =?utf-8?B?VWl4ZFlPMVZ2NFpmTTZwZDhFdHVuTDlYTzRSMkZmOVh6bzNudXNJdHNKN09O?=
 =?utf-8?B?L0cyWGN0c0VuVVdoMGl3VTJveFpTMFhvQWI1WWpyZlhBMVNIc2JJWDllMjZo?=
 =?utf-8?B?NytaSlpCU0FiSW9VeGQ0ZVlrN2N4RW9sT3grT1NZdkhkbUhVZFIzNzA3c05J?=
 =?utf-8?B?bjFaQy9xVWs4QW04Q0wyTHA0RURjeWZ2SzhhUjlsb25SY2d5eTd0Uk8yd0lj?=
 =?utf-8?B?cG5Jbmw3T2wrTlRaUVBLMWluT0JZaGZFMFZvTDRTOVJucHRiMXpQWXZwQ0N4?=
 =?utf-8?B?MnJMNWRsdHZaK1pnU29CdVA0Ulpjd3NMUFZNZ0hVMWZlSStIRGJvT1NWNm1k?=
 =?utf-8?B?VlhySnpTYUVmdTl5eEpnTGdWV0tYQUc0YTVVY0JxcElPK3hFb0dTUExkVXpt?=
 =?utf-8?B?REo2STdueFdHVW8zdHBDN0VZZUkxM1ZFVSs2VTNwbTNOWUlxL0FWYlAwRCti?=
 =?utf-8?B?cVh4dWZEa0ZPNWlCVExHMlZLMi9rSWZKTThlOUFiN0tXa21DOFRTME5uOUFw?=
 =?utf-8?B?VWZlaUtxTjRvM0FSR0w4SlhPNzAvdUNUcW5nd05kcVp2c2E1S0Z1UkM2S2Fj?=
 =?utf-8?B?c2F1SUttRGpiendrMHd1a1pvRFdjRmowckJXSFdOekNFSGo5QlY1bDIvUlJ4?=
 =?utf-8?B?WGRvZ0FtaUU2N2o0TGRuMjNtQWNVODk5Q1I2S0J3clVXOE9hV2xNNklxOTQ5?=
 =?utf-8?B?aXVXV1VOMU5rMmU4N29jdTN0MjhCS2E1eHE2NlhtV2pOSVUwL3I5N2Q5RXp3?=
 =?utf-8?B?ZzUrTUFTWlk3SENkcGpTaDBGKyt5WEZkenl4Z3JDdkw0TTZPOUkwMG5zMkow?=
 =?utf-8?B?WTUzMmFBRVpCdXk3KzM0VUVJWVQ0amZTdjRIUDBzNGgwb2orMnY2WXRsa3Fq?=
 =?utf-8?B?Q3V4aG05MXVSeVd2clhCSFlLOFZZbnZGOUlqOEs2WjFBQkhoTXVQSzYza3BI?=
 =?utf-8?B?dDNHWENnM05Xc2VOY2crWlZrMnAzUWkyRGFhaTFZeWhYQ3lTK1I3K1FYcytX?=
 =?utf-8?B?OUI4SUc5NHpEQjR1L2JvNUxTaHJzUGw5YmlXWHpENDJ0TzRCcU03a0lUcGIx?=
 =?utf-8?B?dGtKRlluZ3krZ0RUYlBpMjVQM1pzWlhmT2w5WjdnT0NkVzczRmR3UWNKZUpu?=
 =?utf-8?B?RCtmZkZtbE1aZ25LeWduSSt4SVY3cmMzRjdpWGdnaVYvdHpta1ZrUGRJUlZM?=
 =?utf-8?B?ZERsZ1F1OCttSzhTL3FzeE9FeGFMKzhrc1FIM3hQZzNreW04MFUyRFFUaU4w?=
 =?utf-8?B?Sm55bzhreHhaeGMrU1diMWl2M203QWlDZWxXVWt2UUhSY01iNXJ6NEI5Q2l6?=
 =?utf-8?B?K1h3Z0hmbTJTT1hEQWtDN3RDZFRVM09nNE1ZMEtzVGp4Y09NSE5nZnVGMG9a?=
 =?utf-8?B?QmNBWjFXRVJuKzVQR1JJSHlLZWY5Z0hzNnU5cE9yZUxCNEpaWEFBK1l2eHI4?=
 =?utf-8?B?Z1RDS3kxZGl3VVROOWdEd1BqbWw5THd0WnZDaHlUYVZpeHEyWUdiZ3Zib1Bz?=
 =?utf-8?B?NmRoWkMySFE2K2Z4cVFpdUxwdTVIb2lQZTdPOTdCWlViRGJDZjRVa2MyaWdY?=
 =?utf-8?B?QlFKYS82WWJRbHpEWk4wbW5uWWxLMTkwUGdwL29VTGFiZFozdXY5Ym51Ymh4?=
 =?utf-8?B?MWVVQm1EL1ZXcVpuOEpBYmlhM0llNldRN25sMzdSODdqbUEzSzNTMjBBU1l3?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b00029b-36b0-4b2d-1051-08dbe6a73e09
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 13:23:38.1306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NlQvBkCFKc0u8PUAMWxYC3mOxrr5gbysXOn0YmPM84DFbBuYFsf/p2OKnnsUYDls14adMtkquZvHk4mut7iXIX2GLgBnW4xjrRkIGy2ugg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7823
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.11.2023 11:55, Romain Gantois wrote:
> The IPQ4019 ESS switch is capable of offloading various bridge features.
> Add netdev and switchdev notifiers to offload bridge uppers, link state
> changes, FDB and MDB accesses and VLANs.
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  drivers/net/dsa/qca/qca8k-8xxx.c              |   49 +-
>  drivers/net/dsa/qca/qca8k-common.c            |   42 +-
>  drivers/net/ethernet/qualcomm/Kconfig         |    1 +
>  drivers/net/ethernet/qualcomm/ipqess/Makefile |    2 +-
>  .../ethernet/qualcomm/ipqess/ipqess_edma.c    |    7 +
>  .../qualcomm/ipqess/ipqess_notifiers.c        |  306 +++++
>  .../ethernet/qualcomm/ipqess/ipqess_port.c    | 1050 +++++++++++++++--
>  .../ethernet/qualcomm/ipqess/ipqess_port.h    |   33 +
>  .../ethernet/qualcomm/ipqess/ipqess_switch.c  |   15 +-
>  include/linux/dsa/qca8k.h                     |   16 +-
>  10 files changed, 1391 insertions(+), 130 deletions(-)
>  create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.c
> 

<...>

>  
> diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.c
> new file mode 100644
> index 000000000000..77f6d79c2ff6
> --- /dev/null
> +++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.c
> @@ -0,0 +1,306 @@
> +// SPDX-License-Identifier: GPL-2.0 OR ISC
> +/*
> + * Copyright (c) 2023, Romain Gantois <romain.gantois@bootlin.com>
> + * Based on net/dsa/slave.c
> + */
> +
> +#include <net/switchdev.h>
> +
> +#include <linux/etherdevice.h>
> +#include <linux/if_vlan.h>
> +#include <linux/if_hsr.h>
> +
> +#include "ipqess_notifiers.h"
> +#include "ipqess_port.h"
> +
> +static struct workqueue_struct *ipqess_owq;
> +
> +static bool ipqess_schedule_work(struct work_struct *work)
> +{
> +	return queue_work(ipqess_owq, work);
> +}
> +
> +void ipqess_flush_workqueue(void)
> +{
> +	flush_workqueue(ipqess_owq);
> +}

Those two functions look like overkill to me

> +
> +/* switchdev */
> +
> +static int ipqess_port_fdb_event(struct net_device *netdev,
> +				 struct net_device *orig_netdev,
> +				 unsigned long event, const void *ctx,
> +				 const struct switchdev_notifier_fdb_info *fdb_info)
> +{
> +	struct ipqess_switchdev_event_work *switchdev_work;
> +	struct ipqess_port *port = netdev_priv(netdev);
> +	bool host_addr = fdb_info->is_local;
> +
> +	if (ctx && ctx != port)
> +		return 0;
> +
> +	if (!port->bridge)
> +		return 0;
> +
> +	if (switchdev_fdb_is_dynamically_learned(fdb_info) &&
> +	    ipqess_port_offloads_bridge_port(port, orig_netdev))
> +		return 0;
> +
> +	/* Also treat FDB entries on foreign interfaces bridged with us as host
> +	 * addresses.
> +	 */
> +	if (ipqess_port_dev_is_foreign(netdev, orig_netdev))
> +		host_addr = true;
> +
> +	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
> +	if (!switchdev_work)
> +		return -ENOMEM;
> +
> +	netdev_dbg(netdev, "%s FDB entry towards %s, addr %pM vid %d%s\n",
> +		   event == SWITCHDEV_FDB_ADD_TO_DEVICE ? "Adding" : "Deleting",
> +		   orig_netdev->name, fdb_info->addr, fdb_info->vid,
> +		   host_addr ? " as host address" : "");
> +
> +	INIT_WORK(&switchdev_work->work, ipqess_port_switchdev_event_work);
> +	switchdev_work->event = event;
> +	switchdev_work->netdev = netdev;
> +	switchdev_work->orig_netdev = orig_netdev;
> +
> +	ether_addr_copy(switchdev_work->addr, fdb_info->addr);
> +	switchdev_work->vid = fdb_info->vid;
> +	switchdev_work->host_addr = host_addr;
> +
> +	ipqess_schedule_work(&switchdev_work->work);
> +
> +	return 0;
> +}
> +
> +/* Called under rcu_read_lock() */
> +static int ipqess_switchdev_event(struct notifier_block *unused,
> +				  unsigned long event, void *ptr)
> +{
> +	struct net_device *netdev = switchdev_notifier_info_to_dev(ptr);
> +	int err;
> +
> +	switch (event) {
> +	case SWITCHDEV_PORT_ATTR_SET:
> +		err = switchdev_handle_port_attr_set(netdev, ptr,
> +						     ipqess_port_recognize_netdev,
> +						     ipqess_port_attr_set);
> +		return notifier_from_errno(err);
> +	case SWITCHDEV_FDB_ADD_TO_DEVICE:
> +	case SWITCHDEV_FDB_DEL_TO_DEVICE:
> +		err = switchdev_handle_fdb_event_to_device(netdev, event, ptr,
> +							   ipqess_port_recognize_netdev,
> +							   ipqess_port_dev_is_foreign,
> +							   ipqess_port_fdb_event);
> +		return notifier_from_errno(err);
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int ipqess_switchdev_blocking_event(struct notifier_block *unused,
> +					   unsigned long event, void *ptr)
> +{
> +	struct net_device *netdev = switchdev_notifier_info_to_dev(ptr);
> +	int err;
> +
> +	switch (event) {
> +	case SWITCHDEV_PORT_OBJ_ADD:
> +		err = switchdev_handle_port_obj_add_foreign(netdev, ptr,
> +							    ipqess_port_recognize_netdev,
> +							    ipqess_port_dev_is_foreign,
> +							    ipqess_port_obj_add);
> +		return notifier_from_errno(err);
> +	case SWITCHDEV_PORT_OBJ_DEL:
> +		err = switchdev_handle_port_obj_del_foreign(netdev, ptr,
> +							    ipqess_port_recognize_netdev,
> +							    ipqess_port_dev_is_foreign,
> +							    ipqess_port_obj_del);
> +		return notifier_from_errno(err);
> +	case SWITCHDEV_PORT_ATTR_SET:
> +		err = switchdev_handle_port_attr_set(netdev, ptr,
> +						     ipqess_port_recognize_netdev,
> +						     ipqess_port_attr_set);
> +		return notifier_from_errno(err);
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +/* netdevice */
> +
> +static int ipqess_port_changeupper(struct net_device *netdev,
> +				   struct netdev_notifier_changeupper_info *info)
> +{
> +	struct ipqess_port *port = netdev_priv(netdev);
> +	struct netlink_ext_ack *extack;
> +	int err = NOTIFY_DONE;
> +
> +	if (!ipqess_port_recognize_netdev(netdev))

This already done in ipqess_netdevice_event

> +		return err;
> +
> +	extack = netdev_notifier_info_to_extack(&info->info);
> +
> +	if (netif_is_bridge_master(info->upper_dev)) {
> +		if (info->linking) {
> +			err = ipqess_port_bridge_join(port, info->upper_dev, extack);
> +			if (err == -EOPNOTSUPP) {
> +				NL_SET_ERR_MSG_WEAK_MOD(extack,
> +							"Offloading not supported");
> +				err = NOTIFY_DONE;
> +			}
> +			err = notifier_from_errno(err);
> +		} else {
> +			ipqess_port_bridge_leave(port, info->upper_dev);
> +			err = NOTIFY_OK;
> +		}
> +	} else if (netif_is_lag_master(info->upper_dev)) {
> +		/* LAG offloading is not supported by this driver */
> +		NL_SET_ERR_MSG_WEAK_MOD(extack,
> +					"Offloading not supported");
> +		err = NOTIFY_DONE;
> +	} else if (is_hsr_master(info->upper_dev)) {
> +		if (info->linking) {
> +			NL_SET_ERR_MSG_WEAK_MOD(extack,
> +						"Offloading not supported");
> +			err = NOTIFY_DONE;
> +		} else {
> +			err = NOTIFY_OK;
> +		}
> +	}
> +
> +	return err;
> +}
> +
> +static int ipqess_port_prechangeupper(struct net_device *netdev,
> +				      struct netdev_notifier_changeupper_info *info)
> +{
> +	struct ipqess_port *port = netdev_priv(netdev);
> +	struct net_device *brport_dev;
> +	int err;
> +
> +	/* sanity check */
> +	if (is_vlan_dev(info->upper_dev)) {
> +		err = ipqess_port_check_8021q_upper(netdev, info);
> +		if (notifier_to_errno(err))
> +			return err;
> +	}
> +
> +	/* prechangeupper */
> +	if (netif_is_bridge_master(info->upper_dev) && !info->linking)
> +		brport_dev = ipqess_port_get_bridged_netdev(port);
> +	else
> +		return NOTIFY_DONE;
> +
> +	if (!brport_dev)
> +		return NOTIFY_DONE;
> +
> +	switchdev_bridge_port_unoffload(brport_dev, port,
> +					&ipqess_switchdev_notifier,
> +					&ipqess_switchdev_blocking_notifier);
> +
> +	ipqess_flush_workqueue();
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int ipqess_netdevice_event(struct notifier_block *nb,
> +				  unsigned long event, void *ptr)
> +{
> +	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
> +	int err;
> +
> +	if (!ipqess_port_recognize_netdev(netdev))
> +		return NOTIFY_DONE;
> +
> +	switch (event) {
> +	case NETDEV_PRECHANGEUPPER: {
> +		err = ipqess_port_prechangeupper(netdev, ptr);
> +		if (notifier_to_errno(err))
> +			return err;
> +
> +		break;
> +	}
> +
> +	case NETDEV_CHANGEUPPER: {
> +		err = ipqess_port_changeupper(netdev, ptr);
> +		if (notifier_to_errno(err))
> +			return err;
> +
> +		break;
> +	}
> +
> +	/* Handling this is only useful for LAG offloading, which this driver
> +	 * doesn't support
> +	 */
> +	case NETDEV_CHANGELOWERSTATE:
> +		return NOTIFY_DONE;
> +	case NETDEV_CHANGE:
> +	case NETDEV_UP:
> +	case NETDEV_GOING_DOWN:
> +	default:
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +struct notifier_block ipqess_switchdev_notifier = {
> +	.notifier_call = ipqess_switchdev_event,
> +};
> +
> +struct notifier_block ipqess_switchdev_blocking_notifier = {
> +	.notifier_call = ipqess_switchdev_blocking_event,
> +};
> +
> +static struct notifier_block ipqess_nb __read_mostly = {
> +	.notifier_call = ipqess_netdevice_event,
> +};
> +
> +int ipqess_notifiers_register(void)
> +{
> +	int err;
> +
> +	ipqess_owq = alloc_ordered_workqueue("ipqess_ordered",
> +					     WQ_MEM_RECLAIM);
> +	if (!ipqess_owq)
> +		return -ENOMEM;
> +
> +	err = register_netdevice_notifier(&ipqess_nb);
> +	if (err)
> +		goto err_netdev_nb;
> +
> +	err = register_switchdev_notifier(&ipqess_switchdev_notifier);
> +	if (err)
> +		goto err_switchdev_nb;
> +
> +	err = register_switchdev_blocking_notifier(&ipqess_switchdev_blocking_notifier);
> +	if (err)
> +		goto err_switchdev_blocking_nb;
> +
> +	return 0;
> +
> +err_switchdev_blocking_nb:
> +	unregister_switchdev_notifier(&ipqess_switchdev_notifier);
> +err_switchdev_nb:
> +	unregister_netdevice_notifier(&ipqess_nb);
> +err_netdev_nb:
> +	destroy_workqueue(ipqess_owq);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(ipqess_notifiers_register);
> +
> +void ipqess_notifiers_unregister(void)
> +{
> +	unregister_switchdev_blocking_notifier(&ipqess_switchdev_blocking_notifier);
> +	unregister_switchdev_notifier(&ipqess_switchdev_notifier);
> +	unregister_netdevice_notifier(&ipqess_nb);
> +
> +	destroy_workqueue(ipqess_owq);
> +}
> +EXPORT_SYMBOL(ipqess_notifiers_unregister);
> diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
> index 52d7baa7cae0..29420820c3d8 100644
> --- a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
> +++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
> @@ -23,50 +23,50 @@ static struct device_type ipqess_port_type = {
>  	.name	= "switch",
>  };
>  
> +struct net_device *ipqess_port_get_bridged_netdev(const struct ipqess_port *port)
> +{
> +	if (!port->bridge)
> +		return NULL;
> +
> +	return port->netdev;
> +}
> +
>  /* netdev ops */
>  
> +static void ipqess_port_notify_bridge_fdb_flush(const struct ipqess_port *port,
> +						u16 vid)
> +{
> +	struct net_device *brport_dev = ipqess_port_get_bridged_netdev(port);
> +	struct switchdev_notifier_fdb_info info = {
> +		.vid = vid,
> +	};
> +
> +	/* When the port becomes standalone it has already left the bridge.
> +	 * Don't notify the bridge in that case.
> +	 */
> +	if (!brport_dev)
> +		return;
> +
> +	call_switchdev_notifiers(SWITCHDEV_FDB_FLUSH_TO_BRIDGE,
> +				 brport_dev, &info.info, NULL);
> +}
> +
>  static void ipqess_port_fast_age(const struct ipqess_port *port)
>  {
>  	struct qca8k_priv *priv = port->sw->priv;
>  
> -	mutex_lock(&priv->reg_mutex);
> -	qca8k_fdb_access(priv, QCA8K_FDB_FLUSH_PORT, port->index);
> -	mutex_unlock(&priv->reg_mutex);
> +	qca8k_port_fast_age(priv, port->index);
> +
> +	/* Flush all VLANs */
> +	ipqess_port_notify_bridge_fdb_flush(port, 0);
>  }
>  
>  static void ipqess_port_stp_state_set(struct ipqess_port *port,
>  				      u8 state)
>  {
>  	struct qca8k_priv *priv = port->sw->priv;
> -	u32 stp_state;
> -	int err;
>  
> -	switch (state) {
> -	case BR_STATE_DISABLED:
> -		stp_state = QCA8K_PORT_LOOKUP_STATE_DISABLED;
> -		break;
> -	case BR_STATE_BLOCKING:
> -		stp_state = QCA8K_PORT_LOOKUP_STATE_BLOCKING;
> -		break;
> -	case BR_STATE_LISTENING:
> -		stp_state = QCA8K_PORT_LOOKUP_STATE_LISTENING;
> -		break;
> -	case BR_STATE_LEARNING:
> -		stp_state = QCA8K_PORT_LOOKUP_STATE_LEARNING;
> -		break;
> -	case BR_STATE_FORWARDING:
> -	default:
> -		stp_state = QCA8K_PORT_LOOKUP_STATE_FORWARD;
> -		break;
> -	}
> -
> -	err = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port->index),
> -			QCA8K_PORT_LOOKUP_STATE_MASK, stp_state);
> -
> -	if (err)
> -		dev_warn(priv->dev,
> -			 "failed to set STP state %d for port %d: err %d\n",
> -			 stp_state, port->index, err);
> +	qca8k_port_stp_state_set(priv, port->index, state, false, false);
>  }
>  
>  static void ipqess_port_set_state_now(struct ipqess_port *port,
> @@ -93,7 +93,8 @@ static int ipqess_port_enable_rt(struct ipqess_port *port,
>  
>  	phy_support_asym_pause(phy);
>  
> -	ipqess_port_set_state_now(port, BR_STATE_FORWARDING, false);
> +	if (!port->bridge)
> +		ipqess_port_set_state_now(port, BR_STATE_FORWARDING, false);
>  
>  	if (port->pl)
>  		phylink_start(port->pl);
> @@ -108,7 +109,8 @@ static void ipqess_port_disable_rt(struct ipqess_port *port)
>  	if (port->pl)
>  		phylink_stop(port->pl);
>  
> -	ipqess_port_set_state_now(port, BR_STATE_DISABLED, false);
> +	if (!port->bridge)
> +		ipqess_port_set_state_now(port, BR_STATE_DISABLED, false);
>  
>  	qca8k_port_set_status(priv, port->index, 0);
>  	priv->port_enabled_map &= ~BIT(port->index);
> @@ -204,34 +206,9 @@ static int ipqess_port_change_mtu(struct net_device *dev, int new_mtu)
>  	return 0;
>  }
>  
> -static int ipqess_port_do_vlan_add(struct qca8k_priv *priv, int port_index,
> -				   const struct switchdev_obj_port_vlan *vlan,
> -				   struct netlink_ext_ack *extack)
> +static inline struct net_device *ipqess_port_bridge_dev_get(struct ipqess_port *port)
>  {
> -	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
> -	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
> -	int ret;
> -
> -	ret = qca8k_vlan_add(priv, port_index, vlan->vid, untagged);
> -	if (ret) {
> -		dev_err(priv->dev, "Failed to add VLAN to port %d (%d)", port_index,
> -			ret);
> -		return ret;
> -	}
> -
> -	if (pvid) {
> -		ret = qca8k_rmw(priv, QCA8K_EGRESS_VLAN(port_index),
> -				QCA8K_EGREES_VLAN_PORT_MASK(port_index),
> -				QCA8K_EGREES_VLAN_PORT(port_index, vlan->vid));
> -		if (ret)
> -			return ret;
> -
> -		ret = qca8k_write(priv, QCA8K_REG_PORT_VLAN_CTRL0(port_index),
> -				  QCA8K_PORT_VLAN_CVID(vlan->vid) |
> -				  QCA8K_PORT_VLAN_SVID(vlan->vid));
> -	}
> -
> -	return ret;
> +	return port->bridge ? port->bridge->netdev : NULL;
>  }
>  
>  static int ipqess_port_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
> @@ -248,7 +225,7 @@ static int ipqess_port_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
>  	int ret;
>  
>  	/* User port... */
> -	ret = ipqess_port_do_vlan_add(port->sw->priv, port->index, &vlan, &extack);
> +	ret = qca8k_port_vlan_add(port->sw->priv, port->index, &vlan, &extack);
>  	if (ret) {
>  		if (extack._msg)
>  			netdev_err(dev, "%s\n", extack._msg);
> @@ -256,7 +233,7 @@ static int ipqess_port_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
>  	}
>  
>  	/* And CPU port... */
> -	ret = ipqess_port_do_vlan_add(port->sw->priv, 0, &vlan, &extack);
> +	ret = qca8k_port_vlan_add(port->sw->priv, 0, &vlan, &extack);
>  	if (ret) {
>  		if (extack._msg)
>  			netdev_err(dev, "CPU port %d: %s\n", 0, extack._msg);
> @@ -340,24 +317,13 @@ ipqess_port_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
>  		.cb = cb,
>  		.idx = *idx,
>  	};
> -	int cnt = QCA8K_NUM_FDB_RECORDS;
> -	struct qca8k_fdb _fdb = { 0 };
> -	bool is_static;
>  	int ret = 0;
>  
> -	mutex_lock(&priv->reg_mutex);
> -	while (cnt-- && !qca8k_fdb_next(priv, &_fdb, port->index)) {
> -		if (!_fdb.aging)
> -			break;
> -		is_static = (_fdb.aging == QCA8K_ATU_STATUS_STATIC);
> -		ret = ipqess_port_fdb_do_dump(_fdb.mac, _fdb.vid, is_static, &dump);
> -		if (ret)
> -			break;
> -	}
> -	mutex_unlock(&priv->reg_mutex);
> -
>  	*idx = dump.idx;
>  
> +	ret = qca8k_port_fdb_dump(priv, port->index, ipqess_port_fdb_do_dump,
> +				  &dump);
> +
>  	return ret;
>  }
>  
> @@ -374,6 +340,882 @@ static const struct net_device_ops ipqess_port_netdev_ops = {
>  	.ndo_fdb_dump           = ipqess_port_fdb_dump,
>  };
>  
> +/* Bridge ops */
> +
> +static int ipqess_port_bridge_alloc(struct ipqess_port *port,
> +				    struct net_device *br,
> +				    struct netlink_ext_ack *extack)
> +{
> +	struct ipqess_bridge *bridge;
> +
> +	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
> +	if (!bridge)
> +		return -ENOMEM;
> +
> +	refcount_set(&bridge->refcount, 1);
> +
> +	bridge->netdev = br;
> +
> +	port->bridge = bridge;
> +
> +	return 0;
> +}
> +
> +/* Must be called under rcu_read_lock() */
> +static bool ipqess_port_can_apply_vlan_filtering(struct ipqess_port *port,
> +						 bool vlan_filtering,
> +						 struct netlink_ext_ack *extack)
> +{
> +	int err;
> +
> +	/* VLAN awareness was off, so the question is "can we turn it on".
> +	 * We may have had 8021q uppers, those need to go. Make sure we don't
> +	 * enter an inconsistent state: deny changing the VLAN awareness state
> +	 * as long as we have 8021q uppers.
> +	 */
> +	if (vlan_filtering) {

	if (!vlan_filtering)
		return true;

One indentation level less

> +		struct net_device *br = ipqess_port_bridge_dev_get(port);
> +		struct net_device *upper_dev, *netdev = port->netdev;
> +		struct list_head *iter;
> +
> +		netdev_for_each_upper_dev_rcu(netdev, upper_dev, iter) {
> +			struct bridge_vlan_info br_info;
> +			u16 vid;
> +
> +			if (!is_vlan_dev(upper_dev))
> +				continue;
> +
> +			vid = vlan_dev_vlan_id(upper_dev);
> +
> +			/* br_vlan_get_info() returns -EINVAL or -ENOENT if the
> +			 * device, respectively the VID is not found, returning
> +			 * 0 means success, which is a failure for us here.
> +			 */
> +			err = br_vlan_get_info(br, vid, &br_info);
> +			if (err == 0) {
> +				NL_SET_ERR_MSG_MOD(extack,
> +						   "Must first remove VLAN uppers having VIDs also present in bridge");
> +				return false;
> +			}
> +		}
> +	}
> +
> +	/* VLAN filtering is not global so we can just return true here */
> +	return true;
> +}
> +
> +static int ipqess_port_restore_vlan(struct net_device *vdev, int vid, void *arg)
> +{
> +	__be16 proto = vdev ? vlan_dev_vlan_proto(vdev) : htons(ETH_P_8021Q);
> +
> +	return ipqess_port_vlan_rx_add_vid(arg, proto, vid);
> +}
> +
> +static int ipqess_port_clear_vlan(struct net_device *vdev, int vid, void *arg)
> +{
> +	__be16 proto = vdev ? vlan_dev_vlan_proto(vdev) : htons(ETH_P_8021Q);
> +
> +	return ipqess_port_vlan_rx_kill_vid(arg, proto, vid);
> +}
> +
> +/* Keep the VLAN RX filtering list in sync with the hardware only if VLAN
> + * filtering is enabled.
> + */
> +static int ipqess_port_manage_vlan_filtering(struct net_device *netdev,
> +					     bool vlan_filtering)
> +{
> +	int err;
> +
> +	if (vlan_filtering) {
> +		netdev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
> +
> +		err = vlan_for_each(netdev, ipqess_port_restore_vlan, netdev);
> +		if (err) {
> +			netdev_err(netdev,
> +				   "Failed to restore all VLAN's successfully, error %d\n",
> +				   err);
> +			vlan_for_each(netdev, ipqess_port_clear_vlan, netdev);
> +			netdev->features &= ~NETIF_F_HW_VLAN_CTAG_FILTER;
> +			return err;
> +		}
> +	} else {
> +		err = vlan_for_each(netdev, ipqess_port_clear_vlan, netdev);
> +		if (err)
> +			return err;
> +
> +		netdev->features &= ~NETIF_F_HW_VLAN_CTAG_FILTER;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ipqess_port_vlan_filtering(struct ipqess_port *port,
> +				      bool vlan_filtering,
> +				      struct netlink_ext_ack *extack)
> +{
> +	bool old_vlan_filtering = port->vlan_filtering;
> +	bool apply;
> +	int err;
> +
> +	/* We are called from ipqess_port_switchdev_blocking_event(),
> +	 * which is not under rcu_read_lock(), unlike
> +	 * ipqess_port_switchdev_event().
> +	 */
> +	rcu_read_lock();

Again, I would move locking inside ipqess_port_can_apply_vlan_filtering

> +	apply = ipqess_port_can_apply_vlan_filtering(port, vlan_filtering, extack);
> +	rcu_read_unlock();
> +	if (!apply)
> +		return -EINVAL;
> +
> +	if (old_vlan_filtering == vlan_filtering)
> +		return 0;
> +
> +	err = qca8k_port_vlan_filtering(port->sw->priv, port->index,
> +					vlan_filtering);
> +
> +	if (err)
> +		return err;
> +
> +	port->vlan_filtering = vlan_filtering;
> +
> +	err = ipqess_port_manage_vlan_filtering(port->netdev,
> +						vlan_filtering);
> +	if (err)
> +		goto restore;
> +
> +	return 0;
> +
> +restore:
> +	err = qca8k_port_vlan_filtering(port->sw->priv, port->index,
> +					old_vlan_filtering);
> +	port->vlan_filtering = old_vlan_filtering;
> +
> +	return err;
> +}
> +
> +static void ipqess_port_reset_vlan_filtering(struct ipqess_port *port,
> +					     struct ipqess_bridge *bridge)
> +{
> +	struct netlink_ext_ack extack = {0};
> +	bool change_vlan_filtering = false;
> +	bool vlan_filtering;
> +	int err;
> +
> +	if (br_vlan_enabled(bridge->netdev)) {
> +		change_vlan_filtering = true;
> +		vlan_filtering = false;
> +	}
> +
> +	if (!change_vlan_filtering)
> +		return;
> +
> +	err = ipqess_port_vlan_filtering(port, vlan_filtering, &extack);
> +	if (extack._msg) {
> +		dev_err(&port->netdev->dev, "port %d: %s\n", port->index,
> +			extack._msg);
> +	}

No need for braces

> +	if (err && err != -EOPNOTSUPP) {
> +		dev_err(&port->netdev->dev,
> +			"port %d failed to reset VLAN filtering to %d: %pe\n",
> +			port->index, vlan_filtering, ERR_PTR(err));
> +	}

Same

> +}
> +
> +static int ipqess_port_ageing_time(struct ipqess_port *port,
> +				   clock_t ageing_clock)
> +{
> +	unsigned long ageing_jiffies = clock_t_to_jiffies(ageing_clock);
> +	unsigned int ageing_time = jiffies_to_msecs(ageing_jiffies);
> +
> +	if (ageing_time < IPQESS_SWITCH_AGEING_TIME_MIN ||
> +	    ageing_time > IPQESS_SWITCH_AGEING_TIME_MAX)
> +		return -ERANGE;
> +
> +	/* Program the fastest ageing time in case of multiple bridges */
> +	ageing_time = ipqess_switch_fastest_ageing_time(port->sw, ageing_time);
> +
> +	port->ageing_time = ageing_time;
> +	return ipqess_set_ageing_time(port->sw, ageing_time);
> +}
> +
> +static int ipqess_port_switchdev_sync_attrs(struct ipqess_port *port,
> +					    struct netlink_ext_ack *extack)
> +{
> +	struct net_device *brport_dev = ipqess_port_get_bridged_netdev(port);
> +	struct net_device *br = ipqess_port_bridge_dev_get(port);
> +	int err;
> +
> +	ipqess_port_set_state_now(port, br_port_get_stp_state(brport_dev), false);
> +
> +	err = ipqess_port_vlan_filtering(port, br_vlan_enabled(br), extack);
> +	if (err)
> +		return err;
> +
> +	err = ipqess_port_ageing_time(port, br_get_ageing_time(br));
> +	if (err && err != -EOPNOTSUPP)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static void ipqess_port_switchdev_unsync_attrs(struct ipqess_port *port,
> +					       struct ipqess_bridge *bridge)
> +{
> +	/* Port left the bridge, put in BR_STATE_DISABLED by the bridge layer,
> +	 * so allow it to be in BR_STATE_FORWARDING to be kept functional
> +	 */
> +	ipqess_port_set_state_now(port, BR_STATE_FORWARDING, true);
> +
> +	ipqess_port_reset_vlan_filtering(port, bridge);
> +
> +	/* Ageing time is global to the switch chip, so don't change it
> +	 * here because we have no good reason (or value) to change it to.
> +	 */
> +}
> +
> +static inline bool ipqess_port_offloads_bridge(struct ipqess_port *port,
> +					       const struct ipqess_bridge *bridge)
> +{
> +	return ipqess_port_bridge_dev_get(port) == bridge->netdev;
> +}
> +
> +bool ipqess_port_offloads_bridge_port(struct ipqess_port *port,
> +				      const struct net_device *netdev)
> +{
> +	return ipqess_port_get_bridged_netdev(port) == netdev;
> +}
> +
> +static inline bool
> +ipqess_port_offloads_bridge_dev(struct ipqess_port *port,
> +				const struct net_device *bridge_dev)
> +{
> +	/* QCA8K ports connected to a bridge, and event was emitted
> +	 * for the bridge.
> +	 */
> +	return ipqess_port_bridge_dev_get(port) == bridge_dev;
> +}
> +
> +static void ipqess_port_bridge_destroy(struct ipqess_port *port,
> +				       const struct net_device *br)
> +{
> +	struct ipqess_bridge *bridge = port->bridge;
> +
> +	port->bridge = NULL;
> +
> +	if (!refcount_dec_and_test(&bridge->refcount))
> +		return;
> +
> +	kfree(bridge);
> +}
> +
> +int ipqess_port_bridge_join(struct ipqess_port *port, struct net_device *br,
> +			    struct netlink_ext_ack *extack)
> +{
> +	struct ipqess_switch *sw = port->sw;
> +	struct ipqess_bridge *bridge = NULL;
> +	struct qca8k_priv *priv = sw->priv;
> +	struct ipqess_port *other_port;
> +	struct net_device *brport_dev;
> +	int port_id = port->index;
> +	int port_mask = 0;
> +	int i, err;
> +
> +	/* QCA8K doesn't support MST */
> +	if (br_mst_enabled(br)) {
> +		err = -EOPNOTSUPP;
> +		goto out_err;
> +	}
> +
> +	/* Check if we already registered this bridge with
> +	 * another switch port
> +	 */
> +	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
> +		other_port = sw->port_list[i];
> +		if (other_port && other_port->bridge &&
> +		    other_port->bridge->netdev == br)
> +			bridge = other_port->bridge;
> +	}
> +
> +	if (bridge) {
> +		refcount_inc(&bridge->refcount);
> +		port->bridge = bridge;
> +	} else {
> +		err = ipqess_port_bridge_alloc(port, br, extack);
> +		if (err)
> +			goto out_err;

You already have ipqess_port_bridge_destroy, this could be moved to the
ipqess_port_bridge_create, 

> +	}
> +	bridge = port->bridge;
> +
> +	for (i = 1; i <= IPQESS_SWITCH_MAX_PORTS; i++) {
> +		other_port = sw->port_list[i - 1];
> +		if (!other_port || !ipqess_port_offloads_bridge(other_port, bridge))
> +			continue;
> +		/* Add this port to the portvlan mask of the other ports
> +		 * in the bridge
> +		 */
> +		err = regmap_set_bits(priv->regmap,
> +				      QCA8K_PORT_LOOKUP_CTRL(i),
> +				      BIT(port_id));
> +		if (err)
> +			goto out_rollback;
> +		if (i != port_id)
> +			port_mask |= BIT(i);
> +	}
> +	/* Also add the CPU port */
> +	err = regmap_set_bits(priv->regmap,
> +			      QCA8K_PORT_LOOKUP_CTRL(0),
> +			      BIT(port_id));
> +	port_mask |= BIT(0);
> +
> +	/* Add all other ports to this ports portvlan mask */
> +	err = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port_id),
> +			QCA8K_PORT_LOOKUP_MEMBER, port_mask);
> +	if (err)
> +		goto out_rollback;
> +
> +	brport_dev = ipqess_port_get_bridged_netdev(port);
> +
> +	err = switchdev_bridge_port_offload(brport_dev, port->netdev, port,
> +					    &ipqess_switchdev_notifier,
> +					    &ipqess_switchdev_blocking_notifier,
> +					    false, extack);
> +	if (err)
> +		goto out_rollback_unbridge;
> +
> +	err = ipqess_port_switchdev_sync_attrs(port, extack);
> +	if (err)
> +		goto out_rollback_unoffload;
> +
> +	return 0;
> +
> +out_rollback_unoffload:
> +	switchdev_bridge_port_unoffload(brport_dev, port,
> +					&ipqess_switchdev_notifier,
> +					&ipqess_switchdev_blocking_notifier);
> +	ipqess_flush_workqueue();
> +out_rollback_unbridge:
> +	for (i = 1; i <= IPQESS_SWITCH_MAX_PORTS; i++) {
> +		other_port = sw->port_list[i - 1];
> +		if (!other_port ||
> +		    !ipqess_port_offloads_bridge(other_port, port->bridge))
> +			continue;
> +		/* Remove this port from the portvlan mask of the other ports
> +		 * in the bridge
> +		 */
> +		regmap_clear_bits(priv->regmap,
> +				  QCA8K_PORT_LOOKUP_CTRL(i),
> +				  BIT(port_id));
> +	}
> +
> +	/* Set the cpu port to be the only one in the portvlan mask of
> +	 * this port
> +	 */
> +	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port_id),
> +		  QCA8K_PORT_LOOKUP_MEMBER, BIT(0));
> +out_rollback:
> +	ipqess_port_bridge_destroy(port, br);
> +out_err:
> +	dev_err(&port->netdev->dev, "Failed to join bridge: errno %d\n", err);
> +	return err;
> +}
> +
> +void ipqess_port_bridge_leave(struct ipqess_port *port, struct net_device *br)
> +{
> +	struct ipqess_bridge *bridge = port->bridge;
> +	struct ipqess_switch *sw = port->sw;
> +	struct qca8k_priv *priv = sw->priv;
> +	struct ipqess_port *other_port;
> +	int port_id = port->index;
> +	int i;
> +
> +	/* If the port could not be offloaded to begin with, then
> +	 * there is nothing to do.
> +	 */
> +	if (!bridge)
> +		return;
> +
> +	for (i = 1; i <= IPQESS_SWITCH_MAX_PORTS; i++) {
> +		other_port = sw->port_list[i - 1];
> +		if (!other_port || !ipqess_port_offloads_bridge(other_port, bridge))
> +			continue;
> +		/* Remove this port from the portvlan mask of the other ports
> +		 * in the bridge
> +		 */
> +		regmap_clear_bits(priv->regmap,
> +				  QCA8K_PORT_LOOKUP_CTRL(i),
> +				  BIT(port_id));
> +	}
> +
> +	/* Set the cpu port to be the only one in the portvlan mask of
> +	 * this port
> +	 */
> +	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port_id),
> +		  QCA8K_PORT_LOOKUP_MEMBER, BIT(0));
> +
> +	ipqess_port_switchdev_unsync_attrs(port, bridge);
> +
> +	/* Here the port is already unbridged. Reflect the current configuration. */
> +
> +	ipqess_port_bridge_destroy(port, br);
> +}
> +
> +int ipqess_port_attr_set(struct net_device *dev, const void *ctx,
> +			 const struct switchdev_attr *attr,
> +			 struct netlink_ext_ack *extack)
> +{
> +	struct ipqess_port *port = netdev_priv(dev);
> +	int ret;
> +
> +	if (ctx && ctx != port)
> +		return 0;
> +
> +	switch (attr->id) {
> +	case SWITCHDEV_ATTR_ID_PORT_STP_STATE:
> +		if (!ipqess_port_offloads_bridge_port(port, attr->orig_dev))
> +			return -EOPNOTSUPP;
> +
> +		ipqess_port_set_state_now(port, attr->u.stp_state, true);
> +		return 0;
> +	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING:
> +		if (!ipqess_port_offloads_bridge_dev(port, attr->orig_dev))
> +			return -EOPNOTSUPP;
> +
> +		ret = ipqess_port_vlan_filtering(port, attr->u.vlan_filtering,
> +						 extack);
> +		break;
> +	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
> +		if (!ipqess_port_offloads_bridge_dev(port, attr->orig_dev))
> +			return -EOPNOTSUPP;
> +
> +		ret = ipqess_port_ageing_time(port, attr->u.ageing_time);
> +		break;
> +	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
> +		if (!ipqess_port_offloads_bridge_port(port, attr->orig_dev))
> +			return -EOPNOTSUPP;
> +
> +		return -EINVAL;
> +	case SWITCHDEV_ATTR_ID_BRIDGE_MST:
> +	case SWITCHDEV_ATTR_ID_PORT_MST_STATE:
> +	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
> +	case SWITCHDEV_ATTR_ID_VLAN_MSTI:
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ipqess_port_vlan_check_for_8021q_uppers(struct net_device *netdev,
> +						   const struct switchdev_obj_port_vlan *vlan)
> +{
> +	struct net_device *upper_dev;
> +	struct list_head *iter;
> +
> +	netdev_for_each_upper_dev_rcu(netdev, upper_dev, iter) {
> +		u16 vid;
> +
> +		if (!is_vlan_dev(upper_dev))
> +			continue;
> +
> +		vid = vlan_dev_vlan_id(upper_dev);
> +		if (vid == vlan->vid)
> +			return -EBUSY;

EBUSY feels odd to me

> +	}
> +
> +	return 0;
> +}
> +
> +static int ipqess_port_host_vlan_del(struct net_device *netdev,
> +				     const struct switchdev_obj *obj)
> +{
> +	struct ipqess_port *port = netdev_priv(netdev);
> +	struct net_device *br = ipqess_port_bridge_dev_get(port);
> +	struct switchdev_obj_port_vlan *vlan;
> +
> +	/* Do nothing if this is a software bridge */
> +	if (!port->bridge)
> +		return -EOPNOTSUPP;
> +
> +	if (br && !br_vlan_enabled(br))
> +		return 0;
> +
> +	vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
> +
> +	return qca8k_vlan_del(port->sw->priv, 0, vlan->vid);
> +}
> +
> +static int ipqess_port_vlan_del(struct net_device *netdev,
> +				const struct switchdev_obj *obj)
> +{
> +	struct ipqess_port *port = netdev_priv(netdev);
> +	struct net_device *br = ipqess_port_bridge_dev_get(port);
> +	struct qca8k_priv *priv = port->sw->priv;
> +	struct switchdev_obj_port_vlan *vlan;
> +	int ret;
> +
> +	if (br && !br_vlan_enabled(br))
> +		return 0;
> +
> +	vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
> +
> +	ret = qca8k_vlan_del(priv, port->index, vlan->vid);
> +
> +	if (ret)
> +		dev_err(priv->dev, "Failed to delete VLAN from port %d (%d)\n",
> +			port->index, ret);
> +
> +	return ret;
> +}
> +
> +static int ipqess_port_host_vlan_add(struct net_device *netdev,
> +				     const struct switchdev_obj *obj,
> +				     struct netlink_ext_ack *extack)
> +{
> +	struct ipqess_port *port = netdev_priv(netdev);
> +	struct switchdev_obj_port_vlan *vlan;
> +	struct net_device *br;
> +
> +	br = ipqess_port_bridge_dev_get(port);
> +	/* Do nothing is this is a software bridge */

Do nothing IF this is a software bridge

> +	if (!port->bridge)
> +		return -EOPNOTSUPP;
> +
> +	if (br && !br_vlan_enabled(br)) {
> +		NL_SET_ERR_MSG_MOD(extack, "skipping configuration of VLAN");
> +		return 0;
> +	}
> +
> +	vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
> +
> +	vlan->flags &= ~BRIDGE_VLAN_INFO_PVID;
> +
> +	/* Add vid to CPU port */
> +	return qca8k_port_vlan_add(port->sw->priv, 0, vlan, extack);
> +}
> +
> +static int ipqess_port_vlan_add(struct net_device *netdev,
> +				const struct switchdev_obj *obj,
> +				struct netlink_ext_ack *extack)
> +{
> +	struct ipqess_port *port = netdev_priv(netdev);
> +	struct net_device *br = ipqess_port_bridge_dev_get(port);
> +	struct switchdev_obj_port_vlan *vlan;
> +	int err;
> +
> +	if (br && !br_vlan_enabled(br)) {
> +		NL_SET_ERR_MSG_MOD(extack, "skipping configuration of VLAN");
> +		return 0;
> +	}
> +
> +	vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
> +
> +	/* Deny adding a bridge VLAN when there is already an 802.1Q upper with
> +	 * the same VID.
> +	 */
> +	if (br && br_vlan_enabled(br)) {
> +		rcu_read_lock();

I'd move locking inside ipqess_port_vlan_check_for_8021q_uppers. Someone could
use in the future and forget about locks.

> +		err = ipqess_port_vlan_check_for_8021q_uppers(netdev, vlan);
> +		rcu_read_unlock();
> +		if (err) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "Port already has a VLAN upper with this VID");
> +			return err;
> +		}
> +	}
> +
> +	err = qca8k_port_vlan_add(port->sw->priv, port->index, vlan, extack);
> +	return err;
> +}
> +
> +static int ipqess_port_host_mdb_del(struct ipqess_port *port,
> +				    const struct switchdev_obj_port_mdb *mdb)
> +{
> +	struct qca8k_priv *priv = port->sw->priv;
> +	const u8 *addr = mdb->addr;
> +	u16 vid = mdb->vid;
> +
> +	return qca8k_fdb_search_and_del(priv, BIT(0), addr, vid);
> +}
> +
> +static int ipqess_port_host_mdb_add(struct ipqess_port *port,
> +				    const struct switchdev_obj_port_mdb *mdb)
> +{
> +	struct qca8k_priv *priv = port->sw->priv;
> +	const u8 *addr = mdb->addr;
> +	u16 vid = mdb->vid;
> +
> +	return qca8k_fdb_search_and_insert(priv, BIT(0), addr, vid,
> +					   QCA8K_ATU_STATUS_STATIC);
> +}
> +
> +static int ipqess_port_mdb_del(struct ipqess_port *port,
> +			       const struct switchdev_obj_port_mdb *mdb)
> +{
> +	struct qca8k_priv *priv = port->sw->priv;
> +	const u8 *addr = mdb->addr;
> +	u16 vid = mdb->vid;
> +
> +	return qca8k_fdb_search_and_del(priv, BIT(port->index), addr, vid);
> +}
> +
> +static int ipqess_port_mdb_add(struct ipqess_port *port,
> +			       const struct switchdev_obj_port_mdb *mdb)
> +{
> +	struct qca8k_priv *priv = port->sw->priv;
> +	const u8 *addr = mdb->addr;
> +	u16 vid = mdb->vid;
> +
> +	return qca8k_fdb_search_and_insert(priv, BIT(port->index), addr, vid,
> +					   QCA8K_ATU_STATUS_STATIC);
> +}
> +
> +int ipqess_port_obj_add(struct net_device *netdev, const void *ctx,
> +			const struct switchdev_obj *obj,
> +			struct netlink_ext_ack *extack)
> +{
> +	struct ipqess_port *port = netdev_priv(netdev);
> +	int err;
> +
> +	if (ctx && ctx != port)
> +		return 0;
> +
> +	switch (obj->id) {
> +	case SWITCHDEV_OBJ_ID_PORT_MDB:
> +		if (!ipqess_port_offloads_bridge_port(port, obj->orig_dev))
> +			return -EOPNOTSUPP;
> +
> +		err = ipqess_port_mdb_add(port, SWITCHDEV_OBJ_PORT_MDB(obj));
> +		break;
> +	case SWITCHDEV_OBJ_ID_HOST_MDB:
> +		if (!ipqess_port_offloads_bridge_dev(port, obj->orig_dev))
> +			return -EOPNOTSUPP;
> +
> +		err = ipqess_port_host_mdb_add(port, SWITCHDEV_OBJ_PORT_MDB(obj));
> +		break;
> +	case SWITCHDEV_OBJ_ID_PORT_VLAN:
> +		if (ipqess_port_offloads_bridge_port(port, obj->orig_dev))
> +			err = ipqess_port_vlan_add(netdev, obj, extack);
> +		else
> +			err = ipqess_port_host_vlan_add(netdev, obj, extack);
> +		break;
> +	case SWITCHDEV_OBJ_ID_MRP:
> +	case SWITCHDEV_OBJ_ID_RING_ROLE_MRP:
> +	default:
> +		err = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	return err;
> +}
> +
> +int ipqess_port_obj_del(struct net_device *netdev, const void *ctx,
> +			const struct switchdev_obj *obj)
> +{
> +	struct ipqess_port *port = netdev_priv(netdev);
> +	int err;
> +
> +	if (ctx && ctx != port)
> +		return 0;
> +
> +	switch (obj->id) {
> +	case SWITCHDEV_OBJ_ID_PORT_MDB:
> +		if (!ipqess_port_offloads_bridge_port(port, obj->orig_dev))
> +			return -EOPNOTSUPP;
> +
> +		err = ipqess_port_mdb_del(port, SWITCHDEV_OBJ_PORT_MDB(obj));
> +		break;
> +	case SWITCHDEV_OBJ_ID_HOST_MDB:
> +		if (!ipqess_port_offloads_bridge_dev(port, obj->orig_dev))
> +			return -EOPNOTSUPP;
> +
> +		err = ipqess_port_host_mdb_del(port, SWITCHDEV_OBJ_PORT_MDB(obj));
> +		break;
> +	case SWITCHDEV_OBJ_ID_PORT_VLAN:
> +		if (ipqess_port_offloads_bridge_port(port, obj->orig_dev))
> +			err = ipqess_port_vlan_del(netdev, obj);
> +		else
> +			err = ipqess_port_host_vlan_del(netdev, obj);
> +		break;
> +	case SWITCHDEV_OBJ_ID_MRP:
> +	case SWITCHDEV_OBJ_ID_RING_ROLE_MRP:
> +	default:
> +		err = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	return err;
> +}
> +
> +static int ipqess_cpu_port_fdb_del(struct ipqess_port *port,
> +				   const unsigned char *addr, u16 vid)
> +{
> +	struct ipqess_mac_addr *mac_addr = NULL;
> +	struct ipqess_mac_addr *other_mac_addr;
> +	struct ipqess_switch *sw = port->sw;
> +	int err = 0;
> +
> +	mutex_lock(&sw->addr_lists_lock);
> +
> +	list_for_each_entry(other_mac_addr, &sw->fdbs, list)
> +		if (ether_addr_equal(other_mac_addr->addr, addr) && other_mac_addr->vid == vid)
> +			mac_addr = other_mac_addr;

Consider storing the fdbs in rhashtable, it's faster when you want to retrieve one given fdb.

> +
> +	if (!mac_addr) {
> +		err = -ENOENT;
> +		goto out;
> +	}
> +
> +	if (!refcount_dec_and_test(&mac_addr->refcount))
> +		goto out;
> +
> +	err = qca8k_fdb_del(sw->priv, addr, BIT(IPQESS_SWITCH_CPU_PORT), vid);
> +	if (err) {
> +		refcount_set(&mac_addr->refcount, 1);
> +		goto out;
> +	}
> +
> +	list_del(&mac_addr->list);
> +	kfree(mac_addr);
> +
> +out:
> +	mutex_unlock(&sw->addr_lists_lock);
> +
> +	return err;
> +}
> +
> +static int ipqess_cpu_port_fdb_add(struct ipqess_port *port,
> +				   const unsigned char *addr, u16 vid)
> +{
> +	struct ipqess_switch *sw = port->sw;
> +	struct ipqess_mac_addr *other_a = NULL;
> +	struct ipqess_mac_addr *a = NULL;
> +	int err = 0;
> +
> +	mutex_lock(&sw->addr_lists_lock);
> +
> +	list_for_each_entry(other_a, &sw->fdbs, list)
> +		if (ether_addr_equal(other_a->addr, addr) && other_a->vid == vid)
> +			a = other_a;
> +
> +	if (a) {
> +		refcount_inc(&a->refcount);
> +		goto out;
> +	}
> +
> +	a = kzalloc(sizeof(*a), GFP_KERNEL);
> +	if (!a) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	err = qca8k_port_fdb_insert(port->sw->priv, addr,
> +				    BIT(IPQESS_SWITCH_CPU_PORT), vid);
> +	if (err) {
> +		kfree(a);
> +		goto out;
> +	}
> +
> +	ether_addr_copy(a->addr, addr);
> +	a->vid = vid;
> +	refcount_set(&a->refcount, 1);
> +	list_add_tail(&a->list, &sw->fdbs);
> +
> +out:
> +	mutex_unlock(&sw->addr_lists_lock);
> +
> +	return err;
> +}
> +
> +static void
> +ipqess_fdb_offload_notify(struct ipqess_switchdev_event_work *switchdev_work)
> +{
> +	struct switchdev_notifier_fdb_info info = {};
> +
> +	info.addr = switchdev_work->addr;
> +	info.vid = switchdev_work->vid;
> +	info.offloaded = true;
> +	call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED,
> +				 switchdev_work->orig_netdev, &info.info, NULL);
> +}
> +
> +void ipqess_port_switchdev_event_work(struct work_struct *work)
> +{
> +	struct ipqess_switchdev_event_work *switchdev_work =
> +		container_of(work, struct ipqess_switchdev_event_work, work);
> +	struct net_device *netdev = switchdev_work->netdev;
> +	const unsigned char *addr = switchdev_work->addr;
> +	struct ipqess_port *port = netdev_priv(netdev);
> +	struct ipqess_switch *sw = port->sw;
> +	struct qca8k_priv *priv = sw->priv;
> +	u16 vid = switchdev_work->vid;
> +	int err;
> +
> +	if (!vid)
> +		vid = QCA8K_PORT_VID_DEF;
> +
> +	switch (switchdev_work->event) {
> +	case SWITCHDEV_FDB_ADD_TO_DEVICE:
> +		if (switchdev_work->host_addr)
> +			err = ipqess_cpu_port_fdb_add(port, addr, vid);
> +		else
> +			err = qca8k_port_fdb_insert(priv, addr, BIT(port->index), vid);
> +		if (err) {
> +			dev_err(&port->netdev->dev,
> +				"port %d failed to add %pM vid %d to fdb: %d\n",
> +				port->index, addr, vid, err);
> +			break;
> +		}
> +		ipqess_fdb_offload_notify(switchdev_work);
> +		break;
> +
> +	case SWITCHDEV_FDB_DEL_TO_DEVICE:
> +		if (switchdev_work->host_addr)
> +			err = ipqess_cpu_port_fdb_del(port, addr, vid);
> +		else
> +			err = qca8k_fdb_del(priv, addr, BIT(port->index), vid);
> +		if (err) {
> +			dev_err(&port->netdev->dev,
> +				"port %d failed to delete %pM vid %d from fdb: %d\n",
> +				port->index, addr, vid, err);
> +		}
> +
> +		break;
> +	}
> +
> +	kfree(switchdev_work);
> +}
> +
> +int ipqess_port_check_8021q_upper(struct net_device *netdev,
> +				  struct netdev_notifier_changeupper_info *info)
> +{
> +	struct ipqess_port *port = netdev_priv(netdev);
> +	struct net_device *br = ipqess_port_bridge_dev_get(port);
> +	struct bridge_vlan_info br_info;
> +	struct netlink_ext_ack *extack;
> +	int err = NOTIFY_DONE;
> +	u16 vid;

RCT

> +
> +	if (!br || !br_vlan_enabled(br))
> +		return NOTIFY_DONE;
> +
> +	extack = netdev_notifier_info_to_extack(&info->info);
> +	vid = vlan_dev_vlan_id(info->upper_dev);
> +
> +	/* br_vlan_get_info() returns -EINVAL or -ENOENT if the
> +	 * device, respectively the VID is not found, returning
> +	 * 0 means success, which is a failure for us here.
> +	 */
> +	err = br_vlan_get_info(br, vid, &br_info);
> +	if (err == 0) {

Could be if (!err)

> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "This VLAN is already configured by the bridge");
> +		return notifier_from_errno(-EBUSY);
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
>  /* phylink ops */
>  
>  static void
> @@ -669,6 +1511,7 @@ int ipqess_port_register(struct ipqess_switch *sw,
>  	port->edma = NULL; /* Assigned during edma initialization */
>  	port->qid = port->index - 1;
>  	port->sw = sw;
> +	port->bridge = NULL;
>  
>  	of_get_mac_address(port_node, port->mac);
>  	if (!is_zero_ether_addr(port->mac))
> @@ -756,3 +1599,58 @@ void ipqess_port_unregister(struct ipqess_port *port)
>  	free_netdev(netdev);
>  }
>  
> +/* Utilities */
> +
> +/* Returns true if any port of this switch offloads the given net_device */
> +static bool ipqess_switch_offloads_bridge_port(struct ipqess_switch *sw,
> +					       const struct net_device *netdev)
> +{
> +	struct ipqess_port *port;
> +	int i;
> +
> +	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
> +		port = sw->port_list[i];
> +		if (port && ipqess_port_offloads_bridge_port(port, netdev))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +/* Returns true if any port of this switch offloads the given bridge */
> +static inline bool
> +ipqess_switch_offloads_bridge_dev(struct ipqess_switch *sw,
> +				  const struct net_device *bridge_dev)
> +{
> +	struct ipqess_port *port;
> +	int i;
> +
> +	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
> +		port = sw->port_list[i];
> +		if (port && ipqess_port_offloads_bridge_dev(port, bridge_dev))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +bool ipqess_port_recognize_netdev(const struct net_device *netdev)
> +{
> +	return netdev->netdev_ops == &ipqess_port_netdev_ops;
> +}
> +
> +bool ipqess_port_dev_is_foreign(const struct net_device *netdev,
> +				const struct net_device *foreign_netdev)
> +{
> +	struct ipqess_port *port = netdev_priv(netdev);
> +	struct ipqess_switch *sw = port->sw;
> +
> +	if (netif_is_bridge_master(foreign_netdev))
> +		return !ipqess_switch_offloads_bridge_dev(sw, foreign_netdev);
> +
> +	if (netif_is_bridge_port(foreign_netdev))
> +		return !ipqess_switch_offloads_bridge_port(sw, foreign_netdev);
> +
> +	/* Everything else is foreign */
> +	return true;
> +}
> diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
> index 19d4b5d73625..00f0dff9c39d 100644
> --- a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
> +++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
> @@ -9,6 +9,11 @@
>  #include "ipqess_edma.h"
>  #include "ipqess_switch.h"
>  
> +struct ipqess_bridge {
> +	struct net_device *netdev;
> +	refcount_t refcount;
> +};
> +
>  struct ipqess_port {
>  	u16 index;
>  	u16 qid;
> @@ -20,6 +25,7 @@ struct ipqess_port {
>  	struct device_node *dn;
>  	struct mii_bus *mii_bus;
>  	struct net_device *netdev;
> +	struct ipqess_bridge *bridge;
>  	struct devlink_port devlink_port;
>  
>  	u8       stp_state;
> @@ -62,4 +68,31 @@ void ipqess_port_unregister(struct ipqess_port *port);
>  /* Defined in ipqess_ethtool.c */
>  void ipqess_port_set_ethtool_ops(struct net_device *netdev);
>  
> +bool ipqess_port_recognize_netdev(const struct net_device *netdev);
> +bool ipqess_port_dev_is_foreign(const struct net_device *netdev,
> +				const struct net_device *foreign_netdev);
> +
> +int ipqess_port_bridge_join(struct ipqess_port *port, struct net_device *br,
> +			    struct netlink_ext_ack *extack);
> +void ipqess_port_bridge_leave(struct ipqess_port *port, struct net_device *br);
> +
> +int ipqess_port_attr_set(struct net_device *dev, const void *ctx,
> +			 const struct switchdev_attr *attr,
> +			 struct netlink_ext_ack *extack);
> +
> +void ipqess_port_switchdev_event_work(struct work_struct *work);
> +
> +int ipqess_port_check_8021q_upper(struct net_device *netdev,
> +				  struct netdev_notifier_changeupper_info *info);
> +
> +struct net_device *ipqess_port_get_bridged_netdev(const struct ipqess_port *port);
> +
> +int ipqess_port_obj_add(struct net_device *netdev, const void *ctx,
> +			const struct switchdev_obj *obj,
> +			struct netlink_ext_ack *extack);
> +int ipqess_port_obj_del(struct net_device *netdev, const void *ctx,
> +			const struct switchdev_obj *obj);
> +
> +bool ipqess_port_offloads_bridge_port(struct ipqess_port *port,
> +				      const struct net_device *netdev);
>  #endif
> diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c
> index 927f834a62bc..d09d0aa8314f 100644
> --- a/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c
> +++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c
> @@ -80,21 +80,8 @@ unsigned int ipqess_switch_fastest_ageing_time(struct ipqess_switch *sw,
>  int ipqess_set_ageing_time(struct ipqess_switch *sw, unsigned int msecs)
>  {
>  	struct qca8k_priv *priv = sw->priv;
> -	unsigned int secs = msecs / 1000;
> -	u32 val;
>  
> -	/* AGE_TIME reg is set in 7s step */
> -	val = secs / 7;
> -
> -	/* Handle case with 0 as val to NOT disable
> -	 * learning
> -	 */
> -	if (!val)
> -		val = 1;
> -
> -	return regmap_update_bits(priv->regmap, QCA8K_REG_ATU_CTRL,
> -				  QCA8K_ATU_AGE_TIME_MASK,
> -				  QCA8K_ATU_AGE_TIME(val));
> +	return qca8k_set_ageing_time(priv, msecs);
>  }
>  
>  static struct qca8k_pcs *pcs_to_qca8k_pcs(struct phylink_pcs *pcs)
> diff --git a/include/linux/dsa/qca8k.h b/include/linux/dsa/qca8k.h
> index cafb727f4e8b..9ad016f7201e 100644
> --- a/include/linux/dsa/qca8k.h
> +++ b/include/linux/dsa/qca8k.h
> @@ -553,7 +553,8 @@ int qca8k_set_mac_eee(struct dsa_switch *ds, int port, struct ethtool_eee *eee);
>  int qca8k_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_eee *e);
>  
>  /* Common bridge function */
> -void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state);
> +void qca8k_port_stp_state_set(struct qca8k_priv *priv, int port, u8 state,
> +			      bool port_learning, int set_learning);
>  int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
>  				struct switchdev_brport_flags flags,
>  				struct netlink_ext_ack *extack);
> @@ -577,8 +578,8 @@ int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu);
>  int qca8k_port_max_mtu(struct dsa_switch *ds, int port);
>  
>  /* Common fast age function */
> -void qca8k_port_fast_age(struct dsa_switch *ds, int port);
> -int qca8k_set_ageing_time(struct dsa_switch *ds, unsigned int msecs);
> +void qca8k_port_fast_age(struct qca8k_priv *priv, int port);
> +int qca8k_set_ageing_time(struct qca8k_priv *priv, unsigned int msecs);
>  
>  /* Common FDB function */
>  int qca8k_port_fdb_insert(struct qca8k_priv *priv, const u8 *addr,
> @@ -589,7 +590,7 @@ int qca8k_port_fdb_add(struct dsa_switch *ds, int port,
>  int qca8k_port_fdb_del(struct dsa_switch *ds, int port,
>  		       const unsigned char *addr, u16 vid,
>  		       struct dsa_db db);
> -int qca8k_port_fdb_dump(struct dsa_switch *ds, int port,
> +int qca8k_port_fdb_dump(struct qca8k_priv *priv, int port,
>  			dsa_fdb_dump_cb_t *cb, void *data);
>  int qca8k_fdb_del(struct qca8k_priv *priv, const u8 *mac,
>  		  u16 port_mask, u16 vid);
> @@ -618,13 +619,12 @@ void qca8k_port_mirror_del(struct dsa_switch *ds, int port,
>  			   struct dsa_mall_mirror_tc_entry *mirror);
>  
>  /* Common port VLAN function */
> -int qca8k_port_vlan_filtering(struct dsa_switch *ds, int port,
> -			      bool vlan_filtering,
> -			      struct netlink_ext_ack *extack);
> +int qca8k_port_vlan_filtering(struct qca8k_priv *priv, int port,
> +			      bool vlan_filtering);
>  int qca8k_vlan_add(struct qca8k_priv *priv, u8 port, u16 vid,
>  		   bool untagged);
>  int qca8k_vlan_del(struct qca8k_priv *priv, u8 port, u16 vid);
> -int qca8k_port_vlan_add(struct dsa_switch *ds, int port,
> +int qca8k_port_vlan_add(struct qca8k_priv *priv, int port,
>  			const struct switchdev_obj_port_vlan *vlan,
>  			struct netlink_ext_ack *extack);
>  int qca8k_port_vlan_del(struct dsa_switch *ds, int port,
