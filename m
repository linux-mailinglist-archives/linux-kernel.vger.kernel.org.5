Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D167B3A43
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjI2S4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjI2S4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:56:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37F0193;
        Fri, 29 Sep 2023 11:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696013790; x=1727549790;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WrwQYITMJ7xtS2AoMQbIhnuVUXRlCd4Zj0Ob74GBpII=;
  b=dUmB++4Rt7gSFFYBOzlwZS9W5Zv3qf6KcZVWLTdNycpSJbNUc6S5+aXN
   cb4rGvs3Us/r8o327CCqLvPwzTQ3Cdii4PeJUmzFl58jN/DoLfE6xSge1
   EmPknxmRcGhQiWxsnlenH18Yr2MPkht7sxvZSZXhj3zs19GsJnsGKMQ7V
   mbjT+eH2Ch9TXUH7kvlwr/fUTtGwuYaR0REa5FwJJ1GNVj3e2GJy0HUSf
   peqkr553AmJ4n/BXnVRDNE/1hIACLnk4U52pH4WRX9KxjPISohcL4Tj1V
   jbWsbJAc9TJqXratGwRcDNDqelrV6o0vyGUdrAhdHD70j/mMEbDfVP/no
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="413248136"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="413248136"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 10:43:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="891613"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 10:42:34 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 10:43:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 10:43:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 10:43:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0wt5sXWV0Volio2WwFhkjKukN1iOTICIJxhnacL988ZqaOmPFbMQG+KpcUaFDGcTmVRiy43p/IjEqvpvCPv3aYIJgOF5nNiiGwBc8HfDwGs90tryPjY8mElRutC36XJ3sQ6qymR03jtiVdOu99YX7rGQ9Wmy0u+yCPBfcUeMn0v+lqppyw7m7Jukhe0wISjwLMRb2YS1oxpUawt23nLDMmMTPRobBvORUzw1gwazm+csi+qs2mSw6UZAyT98ukwPjhc5kIXa5r4t+5vaR6HJtvh9W67ckGO2/yxy1Xn52sU0tMSityDF++FrC2MJtfRA6H3IzhrPMSSeGcg4Be1HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqRKsHhkVaFO5L8RXU0PMgJDGlcMWzkinaEjLqFRqn4=;
 b=XGw8n0Drob2ENd1y+pivywfDUWkTtUtQrGU86QUZR+LwwBTP2bsmUMXteBBBCVA5Ck8BGytpKmDSiL3OT+rQnCd14iQLWeHZkk8EdDAB+dirNMOPYh9jVaQA9UQdgmiQvOLiBb2QxxixQWyBAG/ZYDprKX5w12WcDA1ADadhfisx16SCYFVJeVwZIfquz9VZzpmKjUwFsyaA62iXTkp/vk7QDCAB5HPyybO+RvNAtY1LTnDjpG4vUYl10qknArYk2DopgNRcDZQlUP7UIpOQldn0A5HzHOevVam2VJMu2RucgyaKhgBwz+bxkccmKb39PjT/sJJ3KrMCQb6BJ2reAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4688.namprd11.prod.outlook.com (2603:10b6:806:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 17:43:06 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 17:43:06 +0000
Message-ID: <a5fba3c6-c35d-9a27-a118-f321d7868996@intel.com>
Date:   Fri, 29 Sep 2023 10:43:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v3] net: ixp4xx_eth: Support changing the MTU
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230928-ixp4xx-eth-mtu-v3-1-cb18eaa0edb9@linaro.org>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230928-ixp4xx-eth-mtu-v3-1-cb18eaa0edb9@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:303:b6::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4688:EE_
X-MS-Office365-Filtering-Correlation-Id: 21fb4e3b-8f69-4974-3b6d-08dbc1138996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vD8bgF3Q+hd/wUseQ3mDhUKWZ+Uo70h1+Vg32OtgdrJpLnhG0ulUr0o4eWfE9SYUNcg3z1QlS6S31F0W/nSJYet/RovWkJD725H4IiE5UwKkcYB+5ZRzAiV8DL1mYQbzSWMZyUoqoRBA2l0Nz0Y/r7RHisDLHjOvYvWsGStVzq0kp0iP3xgsHi+O7Imd1SSLhKfWoJO0k6nwYA09WOuttemiUpUaVifVbiFJWb3wdLX4DO2tW4RrMnQNnXGhozO2OdukHb7e9uSlHEpomzD84OOJRaYqRxBi81y2dxTFuY5jkSEVQ+Zc4kI++6Psfa9ZFyoEiE4CjYvHQ8QSKK0ubo6YY4myg4l58Y7GZvDs4HZqXm1Jo6KsPzckzcd8Q3rJQfVJUk31/03/nsK6oofI/9lhocMpXduQTLRdfBEszA/V9lCT0Jz/WB30mfdiQQqJzPJLBs6LPb2GK7dGHFx2Gnd8a/ePeNW5Ia9twTGxlm/yxLH4YvRTNZa3Pck1wAcoXyjdlBZPmw6h8+ftzzaN/R8rfK3wTjEez98JsV+eMvSLyy4VO+aqaKa3Dwd0n6KrQ7QCytsMgIpuSsFJJuSeF8nruwMlXE1xH8rbi2AzEkgi5tOqDyqtkikKdSKbERZnnvEZDSCkmGlengu5EV5Kug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(316002)(41300700001)(26005)(2906002)(5660300002)(8676002)(110136005)(66556008)(966005)(478600001)(8936002)(66476007)(4326008)(4744005)(66946007)(31686004)(6486002)(6666004)(6506007)(6512007)(53546011)(86362001)(2616005)(36756003)(31696002)(83380400001)(38100700002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3JIc2dxcERzRURFZGoxcWxhU1V6UWk2TWdhRmFLZWRqMTFoV2IwUkllNjFY?=
 =?utf-8?B?SmZlL3BUZzgzMGdFd3FOL3FWcWpCUnFHV2Q4eWZFcTBKYllrU2hsV2hneld4?=
 =?utf-8?B?Y0JzbzROczNCemYxRXMwY3piUS9Yalh5dGNaTlZBSzYweEYxTnZsNnNhdEZX?=
 =?utf-8?B?QWNJOHk0ZWhucjZ3QmdsRVhaZ3lOcmNEaWU5eGtTRnlxRjlOcldnQ2F4a2Fa?=
 =?utf-8?B?eHVyejlQSHhyYlEzQThRUjBWc0o5VW5nNVMzem1OSXY1ekpjOVgxM0RYTUI0?=
 =?utf-8?B?UWRDaGlPRUpzSy9PQVZYVnI5U2Q5UFN5MHk2aG1ublhnM2hweVZ6dU9QWmlR?=
 =?utf-8?B?eFozVmZXYmEzVGF0QTlsaVd3LzhpTWdNb3Z0eEFJVzN4dnYvMkdyUlhsa1Zn?=
 =?utf-8?B?MnFGVUhXUnhrQ1Z6dzIzdW5OcENQZXU4Qmt2RGRvbVp5c09KMjhkU3BZRElG?=
 =?utf-8?B?eGo5Q0FBSEtjMUIvUFVCZjl5MHVrWmdHSWFpcVpqQ3BWRzhMci91OWVXM1RG?=
 =?utf-8?B?ajdsS0x3aDk1eTVDZnc0L3Arb3JVdDZHNm1sRUw2QUpBSncvMkRINkZHZG9D?=
 =?utf-8?B?dEx2OXFTYzBhb0JoazRUK1FHbzVkMEZOWGtzdW9wQ3BsNnhxcGN2cnB6NmhG?=
 =?utf-8?B?RGNVekZGc1p5Y3ZONy84MWFBVnBaNFE3YzZLbjZQbFVObjA0UkpvN2VJQml3?=
 =?utf-8?B?Z3hpbXZwenhuL3Q1dTVxZnI5K3dLRkl5OVJjdzNyaVdYZGx3ODN1T0N0WFlU?=
 =?utf-8?B?Sk9rZHgvSVZEUkNsSzhyejRxb1VPNHVBMUZxM3NuZE1IbVNCdEZSMUE0N1M0?=
 =?utf-8?B?ZjhKay8xei9vbmExUzhDRW9nZVlxeVFpVGVob0Nod1RpaTFaTFB2QmlsNjR0?=
 =?utf-8?B?YlpaYVl5SU9hd3psOFJMUzRMbHlpVWFEMERzWG1RNFd4UzMvY1pPMStZMW5N?=
 =?utf-8?B?MC83RFpEMktNTnNwcllzQ1J1UEpKUGdONm10NzhJdG1scjBWS2plMURVOThK?=
 =?utf-8?B?MnhIZ3lFZDZoZnlIQmdaMzRwRG1HV09vZitXdm03aG1BOUVkQ2t4dEcybXBY?=
 =?utf-8?B?K2V4a2EzVEFXay9pK1VDQkFHYUF1MGlaWTBvcXdQV1RUN3F6cnFuaklCVElK?=
 =?utf-8?B?SEZrZnJ1czZkcmp4dmFOd0dsK0dENTBiQ2tSRlRFbDdVRkk1RXFQcE5iRUZv?=
 =?utf-8?B?YVF5Rk9Qdkh0d2ZiUXNjM3JDTDkyeUxRc053SVh2VTkwVGhjVkxlMEpKTlBt?=
 =?utf-8?B?d1dPeDRtSmFHcW1RZTlCM3RXbERSVC9JclJQR3lGWGxUU2JORmlVc0J0dnZT?=
 =?utf-8?B?c1NDM3duMDE5Znpaa3UwcStyQXpUdGVtR1RPUWExWFN1K1J1c0cvZGs3Znpj?=
 =?utf-8?B?SVhhNk9ENGk4bU1Db1Jldjk1VnNqdGJzK1Qra3hMYThXMjYrQWUvZlJYRGdt?=
 =?utf-8?B?THlVdUZzTEoraWp4LzlZU3RwTkdIQTUxVlVPbkgxdWx6OFN0L0hPVVlMQUN5?=
 =?utf-8?B?N3ZHdkgxc0pLTFRMQmxqd21VOFlJSzZ5TzBoVmc4eWVCRFFKUlE3bDVrWW5h?=
 =?utf-8?B?N3JMa3VXaE5nUjFCU2xSYUJUTzljRGdLT1R2VlMwOEZDTTdvQnplZE1aVjZn?=
 =?utf-8?B?VUVIRTVJendhODgzbEJRNzRBc3d5K096cXByaGxvdThEN3BMejZJSFc4cUIv?=
 =?utf-8?B?OWV0a0Z1VndidXQ0aDJ1UVVWWlJGRkdXSjlxRXNZSlVpQUxzVnNJeExmNDNF?=
 =?utf-8?B?VlVvK3ovSHNXaXp6dWNqWXd4MGFNMG54NnRIYU5wSE0wQlJGbkxKRGlSK1RC?=
 =?utf-8?B?Nmo5RlQxTW95NXhhNDY1RlRmVURBbGw3a2NIK2ZTdVpoT1BaMGcvS0xURlNE?=
 =?utf-8?B?RDZrVFZtc2EvVUdqRnR2MUc1eERHcWhTd2xPV2tHbms0cU4xeVhoQ3A1cUhy?=
 =?utf-8?B?SzhvMUxmbG9GamJOVTlRN2ZJM0xDbm1lL1lNU1R3Z3owTnpha25kL0lMamQr?=
 =?utf-8?B?SnV4bDU0THpXQ1loWTdoMGIxdksvVzJMdTNFaGxoTXV0eFVrMnhtaWR5YWsw?=
 =?utf-8?B?RStUeDluWVdrNG1VUzFqT0RGUit3UHhuZHI0QW56K0JoRWZiMEovY1pvY0NU?=
 =?utf-8?B?LzRFdEhqbzJsek51OWMyNEVUZUtiZEJMNk1uY05DSEpLaTdNeDJBM2hhcVZh?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fb4e3b-8f69-4974-3b6d-08dbc1138996
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 17:43:06.1992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FB2Rmlbux6eZCSpZNKlGmLlj67I9zvq6F+hClNshfzOe5yEQ2ylIj6NTMtjwV1KkJ6xCw4xsNrXL1T/xnlvywV6nKHm2mLTd6N50Fz2rzL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4688
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/2023 3:12 PM, Linus Walleij wrote:
> As we don't specify the MTU in the driver, the framework
> will fall back to 1500 bytes and this doesn't work very
> well when we try to attach a DSA switch:
> 
>   eth1: mtu greater than device maximum
>   ixp4xx_eth c800a000.ethernet eth1: error -22 setting
>   MTU to 1504 to include DSA overhead
> 
> After locating an out-of-tree patch in OpenWrt I found
> suitable code to set the MTU on the interface and ported
> it and updated it. Now the MTU gets set properly.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v3:
> - Fix some coding style and initialization style.
> - Collect Jacob's review tag.
> - Link to v2: https://lore.kernel.org/r/20230925-ixp4xx-eth-mtu-v2-1-393caab75cb0@linaro.org
> 

Thanks for the cleanups! Looks good to me still.

-Jake
