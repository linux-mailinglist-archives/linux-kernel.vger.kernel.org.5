Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1777D8C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjJZXSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJZXST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:18:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0414A1B9;
        Thu, 26 Oct 2023 16:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698362297; x=1729898297;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mu1Ra3k1IV8wzh30J9xXzr2sdgkGgQ6yVqjjbo+tgtw=;
  b=c6J5yf47Z+Kbl9Y8wqyawUneXXEfWGyKdWZ9lIDDqU7aMQtYj/2ks5pt
   kSKQKI8XYyeB/EpnHiCiKpO0c6hFMwNK363+nNPBGzhquq6IgeXDfP6Jz
   tA77RuKTKv9eK7aUrPTOZQAWmvIyH+nDiNKl93dPQJPjlrG9iRZ6OJKAZ
   ziDYz3Av85vQ7H3sxPrENX1AnOPhnS9tQeuzwKFFR/1ojd2DyppJNvBY1
   ckw88GhGw6Pr/XlyXM27P9w7LnAsuzjfQvH4tIt0HeW4NYvUMgIq4hGtW
   H29rlNHotQEcFYhkxuoemL/aX4i1mjl2Q9uweGy+JcYv5fT1JyQ4vPjaj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="378037899"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="378037899"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 16:18:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="932882021"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="932882021"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 16:18:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 16:18:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 16:18:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 16:18:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 16:18:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VICSPemYDkn88n4y9AreqQa9E44r+FCDQAtuEkALUDihTxQOq4lmngMtZcBsXpbkEO1fUONFDvgnPg/DQTkOSAqLNVnBHd6up4KhylTDbmndPuT7l6YRsm6s53tvhUO8/RaeOSg09ufm3iU0KX2NpRIf+dLb91nZroUfCax8Y53W1qoAbOuPP5wPsSFBDwb3Y0J5WIV89x6Nh/fwP+6UoaZl4+QGSOKu3Z2EzIlJlvUMCoQ0XHr8sy3fYYn/oYFjzh91rJ4s20q8gKoGa8F1vsheobZ03jip0r3/A6NJKmaOOUpFrzChqDRgrO8czUG8rT3lhuEaTprLmniR9RV3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zn7EUUX2g7b1nnPVYnHuhCkYcgQSFLpUJouku6AWvto=;
 b=UzwKTPTNhA6Bs7FmQWTzx2GXw8o20m/91i/G3KKk+EJYznAyD4UXvdrDa6kbqp7SebORV4QufUOPFgRSd67ewxgG4VDLc6hsTHmVGEjBnseCiFGc7eaVOFDW9vV3j1l5IJkaDAKf/N7LVe/CJCNlk8N8hXBwIduGmfq3vcctf72Vd4f/6a+xCTKdfCh2vvIeud9G8jnoIzeS6xqdFN0BukRT25nLsIyEG7NKUqKIZn7Cvx6H6jl3Tr7capyJSkzopZXvyye3o8B6Uh3O7XEnY6jHnGonXq0u2EExejZ7kN5AkJR3n/xlbWwzuThcmVZH32rv2lrPjd1vgKGhAbzN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Thu, 26 Oct
 2023 23:18:08 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 23:18:07 +0000
Message-ID: <976cbd32-3f0c-4ca4-b147-10040f2d7767@intel.com>
Date:   Thu, 26 Oct 2023 16:18:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/5] net: ethtool: Make RXNFC walking code
 accept a callback
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
 <20231026224509.112353-2-florian.fainelli@broadcom.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231026224509.112353-2-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:302:1::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ1PR11MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c1fbe5-ad8b-48ba-79de-08dbd679d048
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NeZb7oJBjc+c794gnAX4V1u8P7ckV3o5WxKz05op3/771mDBZcOaSSZcVTgw5BVGUi99UOJZFn3hwmmcDHTHVf6E0WY7ULfStqSHqajB8yaVLGcPbGRfULg4t0uRRNaQIuFiVMj6OJXoWvP7eJnsRJMxghh6qd9f3jwSS181TYIkg9gHU4FytmjA6zgyPzbV/UiMqWZLoUg7tuPI8l1GKTU+QnRCfj7vmq0u9EHwK+da2NZ5+NqxXydMYKhHYdSW6EVGJbnB2MCTq4uZCWdahejNBQ32dilKt0Cpxo9kXlIVCpt+XicFy6BnuKhLE+D0maaffARfn68JGW0TBUMC7ctAUWRe3YGJPBbzIlgiqg2pW2nsbgHJj1cs71mpxTLm0bIrzC6xl8YRRsmfSuqpwkwurHPpiTUdloF1//ESGRXslhG4emXuPoNxvzCdZrDbJHzkux0GPsEcvfQ/h8KwWWXYF4E4CYSA/oBHa2QmzRlphi/SQeVlmpMoDkyPSXiQto2sdZn6uKsKdykYPUDlK/S+sDD1ogjaO5Z3kOoyI5TsVRYBPKK/eX02MXDiKhBK5fGt31qRwncBRS+BbI2eNIQ987ATlzqj2H8NaSpKAAgrXcQazzeWFKwV60nUAjCtV4g2D1eS58F3yDnLqtrn+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(4744005)(41300700001)(2906002)(38100700002)(54906003)(316002)(66946007)(66556008)(82960400001)(6666004)(66476007)(6512007)(53546011)(6486002)(86362001)(31696002)(7416002)(5660300002)(478600001)(2616005)(4326008)(36756003)(8936002)(8676002)(26005)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXc0V0g1RWd1ZG14dXJIRjRuRitGZjlMcTNaRk12MEliaHhQb0VuMHlSbGhM?=
 =?utf-8?B?OFVtSjRHVjEvenRNT3pnRGIvMld6VjhNeWN1YzZuMm80ajBGOXQ5NWlvUmow?=
 =?utf-8?B?S1VjMU5mRmpwbWpIWkRGdEFBK2xvYlBZQVpxRzlIZm9kem1zd2lLWVJrQ3Fn?=
 =?utf-8?B?bVVBZDlFS3hrRU9HUStRQnZlYzUrTVhNTjc2WlNCbCtOdXorYjdtNTdXN1JZ?=
 =?utf-8?B?d084YjhXcEY5SHlVb25oM3FnL3VrOFN4Mi9UNFBnUmoxSEt1NzFRZmd2V0dJ?=
 =?utf-8?B?TjdWM3lYY1RDNkZjQnphUTh5VFdKeWxqVGdHNkdZWGIvdmNlWWJSSFM5NnRz?=
 =?utf-8?B?NVdFcmw5M3lYSzBoekMxWCtVWjNndFdtUGlZWkc2UW9qdHByckhoTmhaQzls?=
 =?utf-8?B?ZFdOS25nanRVU3dzMzVWdlZZWXBldzdvTnczMXQxdjltdVBjUUQ1SVJJUTI1?=
 =?utf-8?B?b25mTGU0TUg2MGR4S3BLWUljeFRDUzBLcHB1WmJnVTJUcXBYamxyUjBTNFBx?=
 =?utf-8?B?VnVpREJpT3FQMkk1ZGxiWnVqV09MLyt6a0RpMlc4d0FCcEd6RXkxYTV4N3Bo?=
 =?utf-8?B?ZzRwNk1obnFrY0NoVzRBb1h6Wklhd3RaL3N0ZmdnRlhHNmtmODIvSkt2YUxB?=
 =?utf-8?B?S09NRHRNYVk2ODBjcVBzdDBZc0I5UWtzSWx6dVQ0dDlkN1lRRFJLUUdXWkd5?=
 =?utf-8?B?dHJoUWIwMHJta3FvVjVaekxaQithL1hUMWhaQWpPMUdkT2drbEZRR2hneTlL?=
 =?utf-8?B?QWhSVWZxVCtYV0RzVlpXZVdxLzRTTjdRMDY0SXVURWZhQ0xXSnlRVFJvRU0v?=
 =?utf-8?B?MmJ6SG1FSUNhd3lrZkhoT2NZbFQyYndYT3JuWUlBM01ZU1Y4cEREeUhyTGZY?=
 =?utf-8?B?RlZBOGlwcDllUGFMSUE4U0owQTNwbndDWVFGZ2F5VE9paUd1WHVmdDNlMHF2?=
 =?utf-8?B?b2E5L3FXOW94TElMS0J0WlE4OUFSYnk4enc1VDJoVkVRQ3RxWEZpNTg3WERD?=
 =?utf-8?B?dHR2QS9wWDVkaU9xQTRRUlk5NDVUczRIUndzVHNFZHU3L0hla05VTlhCLzU3?=
 =?utf-8?B?UlRlc29tVEZZVUcrSyszYzAzL01YaTBjUnpOWml3aUM2NktQdy9TMVVZSks2?=
 =?utf-8?B?aUJRcXY2eU5DTDNueWg5T0xueElIaXRqY1VyVDNDeXZETWs1aTBZaFZrbndr?=
 =?utf-8?B?dTN3dXV2Z1ZSaU5BMlRsenY5MXI3eHNEbmgxeXdQSGh3V3JKYlovT2VBUWR4?=
 =?utf-8?B?SEl2cFU0UVlCRkNzdUJzcnk3T0J6dUJSdGZZUStyZ0pRT1hCdTR3d0dtNFlF?=
 =?utf-8?B?S0NQQjMwcmNEQXBTbGEwSUNyVjl3U2lJd0luSFVKZDRVcHhJZGpDNVV4aFFE?=
 =?utf-8?B?NVpUUEc0TFRuRmkrVDh0M0c2Tk9TUzR3ODZpYmRsbUlLK2NoTysrTStyVTF2?=
 =?utf-8?B?Wm1LalBjSlNCNzErVE5xTUtJYU1mMktsMFJqV3EzOGdXcGhVakxTZmlhd3NS?=
 =?utf-8?B?bGcwSWJUWEE4R3p2TEpHUVlzVWJmcHV5VytiRmZrUGxwQzZhdCs0b0laRTlE?=
 =?utf-8?B?YnloSXFXbXA0TU1Zalk2Rkg5WkdSbllvbGpCalBDZkFtYzhmSWNwenFrSm5Z?=
 =?utf-8?B?Y0p3eFpOMEhINFNPaU52QkJaUTRmZHdGbDJnYkpOZVVTa0ZpQlZ5cC9PK3F2?=
 =?utf-8?B?UkIyT3J2a3VzWFlBQno2V0Y4VDlRUkYzUUhjRHlaTVhwb3A1WHBNV3duQTBw?=
 =?utf-8?B?cE5sNEFrRmFPU3U4amZnS1RLblM2Qnp1Y2tRZ1I5aXFXSXBGamFmR0g2cHVl?=
 =?utf-8?B?WFpYbHUrSWxsYUhnWUJNcytIYWRUQVBuQWZBUmxINXM1cm1Xb2dnREhCQTF2?=
 =?utf-8?B?SzRNS2w3c3ZTbld5WllEWFl4dFovSW1qQlR1UDk0aHhMMjJrVkdUU1lBOGdj?=
 =?utf-8?B?ZmdFcjBHbjN4clRrcm5XRHNCZkRpeUI0QnBaTDQ1UVFOWmxKeldpYkQ3bFVj?=
 =?utf-8?B?WWJBckMwOWdoRFRUUnU2aGtKQlZLMkdGM3ltVS9wdk9GZ05xcXVIOFFab1NJ?=
 =?utf-8?B?L01BYlFpeWFTYXlBdkxFQjZXV3JLTklscnplUUFZVjBZMVNUZk41SC9tY1FS?=
 =?utf-8?B?MDBNOFpCbHE5QTRHTzRtTXpQeTYxMHdYNnZTd0lZM3Q0clMrRzNWZ2JIRE5k?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c1fbe5-ad8b-48ba-79de-08dbd679d048
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 23:18:07.7824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTgiOnwtDbOdMihKNJNi6sVI66Kh/bUQP2PI2owOfva3Q/v7bBjGToAS3sLvPKdZlGGqbcuCx9VNvBp5bo8DKMzYcjTRN4cq22NxevG2EaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6180
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/2023 3:45 PM, Florian Fainelli wrote:
> In preparation for iterating over RXNFC rules for a different purpose,
> factor the generic code that already does that by allowing a callback to
> be specified. The body of ethtool_get_max_rxnfc_channel() now accepts a
> callback as an argument and is renamed to __ethtool_for_each_rxnfc().
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
