Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4006A7EC30C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343837AbjKOMzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343723AbjKOMza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:55:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D167AE6;
        Wed, 15 Nov 2023 04:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700052924; x=1731588924;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aWT05MKbeBQo2Y70pf5dpl5Ce9pE1/PtoibK+Cjeg0k=;
  b=lMnmy6/7MoEGCM6xQCEdOF7vJ4f5vK2c9eh1xln6BwGfSGVFW4PixSRZ
   mmlP+ZyFQ/lst3saFoqB51XDE7UI6pNhyxVOcvjg7NA2/t7iizmvh5Onf
   mR/OrzinAR/surl8SWMSEuG5Ih8Vix5EKo/N+tTvL5mfMtCxvTJTxfTlE
   2lID8jJQRB2m1ZMefCeMEJZ4xxWq8eTOHRKRO1yfdBGuzByJHjQkcmdsI
   +LYqqRSwb91EThQT9uaZfmDYbjzRMZjbzK1Wkd9Ks7iBZJfQjaO4JTPJy
   4kixnQL6bj26V65OOuc9rv5QmVVhMq9OA8QzIELcj100HNPPxKj8viCnm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="12418965"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="12418965"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 04:55:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741429458"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="741429458"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 04:55:20 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 04:55:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 04:55:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 04:55:19 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 04:55:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZc19cAdEVxCqFk/j215MLizQxtIKzSJsN7s/FD9jEXeLDSEjckwzFUAHokLtnturmohBmiP2qmW+ukQo5Ho3KpuLFjZz4Jks9rbYpFBYXVRwN7bYVzTyFJcKp8Y3s/nGJS3A3htSj/yCQPiacZRiqlDC+oeVG3s/cA7/WhTj2F7uaXv3WY3uFXrh+f98qN3dB1/EC6IemdMs9ww2hcuUZXx3FSd0byORjybXW8yxMYnjsh3I0jvT6nWYfI0FjF3X8b4k2spMaob++B46j1FktpXcKxlogyrfRrmn1eubTYFJbpDtN5lJh6gYWlNcPLmOlIbPurvG00n87P5qOtQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NawafQ5TmhyyY5igp0PG0M1RBFD+ICdApt9Pvh4o4v4=;
 b=mkBSlYEc7aLZmJ2mQcwflVsW0HQSBOjPkV5wBHEQPo1wHlfFVk/vADaSQf3A8I2XPW41FZAZo60oh5OQA2Q+zOBS1Xj14u0km/rQiFgulmqqpOaXH3Xhp4vova/1aneK7KsfcXjuuzuWIUqoRPEPaj1HY5SDg+Zs6h9zeuCQhNRtJXVQTqAjfE9tpmpQd/x4/leGDQ6EJ2T1hoSogDhlHMjlDcbQ4Xe4ymQIWHGieY31F483PugxCsd29mg/Gxg9uNM+wTbM6LKRt5JDOIu7IwWbka+E9crt/uHP4I128Xay/70AJIHUSVHTuGSxtWSvFnm5zk/uKXg8pXlJJFEscA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by BL1PR11MB5445.namprd11.prod.outlook.com (2603:10b6:208:30b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 12:55:15 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 12:55:15 +0000
Message-ID: <59e1edc3-2ebc-40a9-a05b-cab02e8b0c10@intel.com>
Date:   Wed, 15 Nov 2023 13:55:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/8] net: qualcomm: ipqess: introduce the
 Qualcomm IPQESS driver
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
 <20231114105600.1012056-4-romain.gantois@bootlin.com>
Content-Language: en-US
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231114105600.1012056-4-romain.gantois@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::10) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|BL1PR11MB5445:EE_
X-MS-Office365-Filtering-Correlation-Id: cdff8786-fa73-4247-8f19-08dbe5da1c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKv54rsn/zAWPnk1LzWdiwuJtNKlVxLDcZdTD4YCadD/vLgS9r8p1Y113lMAMuT+mtQhRa4j+sSBgcCh7qXc0OzGe0yeLZl913mXP0kOrq1UbEbvfPIPGv5i75I36mbQGnCn2xOHyDBAjJQ/8K/hWviNuct0eUkYIqpSQxG2xbNG7+BU+6O9ObXlBINhc/hbdl9nVChWr/BTxmX2vHjR48b4gbDfGPZQ0qSjbUacpKjsEW5/1xUQwyT4jNs0VrDdmmsuzlnpl9VzTy10AC4uMEJgbyS5jLXjNbUFMl7rEU90/XyummY4TH8CEz1Tt4Rs4gX5kk0qcHhCRzhI5zVFsdAAf3T3pM4WKegEyUAZjnRrYyxu3niS6Ozg3mgr2Ow6KxuLOEdxQ190V2NzVRmWsDakwY3qna9SsIaFu3qQRvepl07O95iNFHcnMhVK1gbUcK+FhZKLYE9Chp6jhSSsgRKrKZ/tH7KohnKPwO8x9w4uctG+uyzX7izFsaJVfeSzNl1zNDgwx9RnhZR3uvgbmFoh/yWpeK4/MJkd2C3N6YGhYo0UEuNOcPmRaFXE3CLuw2Br2I2cVE9WW8Kf/AEfIdHOqwYpXL3XvYnpEZLcC17MvGckp3ZGRdRvoPiu8ZV1h4YmBqCcVgs7m3F5lhAkXS/OHv1lUPZ0d9MCl5HkuUCTIRa+5sNckHBoD398EyrV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(376002)(396003)(230273577357003)(230922051799003)(230173577357003)(64100799003)(451199024)(1800799009)(186009)(53546011)(6666004)(6506007)(83380400001)(38100700002)(31686004)(26005)(82960400001)(6512007)(41300700001)(7416002)(5660300002)(2906002)(30864003)(86362001)(4326008)(8936002)(44832011)(36756003)(31696002)(8676002)(54906003)(66556008)(110136005)(66476007)(66946007)(316002)(6486002)(2616005)(478600001)(43740500002)(45980500001)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmtSTTAvMjQyUFhKS0xEMlFkK0pFZHRudTI4U3ZacjdvaEVQS3g3bU84SXpk?=
 =?utf-8?B?aTl4RUptZDdKUmtZT1pMNUV0TExUQlNxOEV1ejFuL1QxcUcxQ3N1M0ZOUEwr?=
 =?utf-8?B?TTZraU43d3Bjc3Nva2hCTVJ1dlpwUTZyWU5oTEY1YVV4Z3VCaENPVXpHY0pn?=
 =?utf-8?B?YUdzVjRSZ2gxZzNlQmVjeGNMMmFzSWE5V0IzTXVCclBHVGFLdXJJVWczR040?=
 =?utf-8?B?dXgreDZiOWtUcy9xaTVQVkY4em55b1YyYU5oMXQ4RGY4VEYrWVpXTW4xN0JF?=
 =?utf-8?B?cW1HcUgxUElMSjZPRGRqVWJjZ1pQY2pmMGhTeE1VYW96SEVvUTZJOXI4TUZI?=
 =?utf-8?B?N3huRjRlejZZL3hoOU9hdHN4YVdUZ2FaUmtpTlh3RFdWNmE2cFQxeG1UYlVN?=
 =?utf-8?B?eTFBb3hoR0NsTHhXZndmVXJ2eW5HQ21vVE5jR1hPZnJTWW9OSGQvMkdHb0Ju?=
 =?utf-8?B?MU95UlNoUVlJL2tCdEVMZ1Y3ZU04UGpvZDN0ckhrRE1QRlZYY001bFVsUUtx?=
 =?utf-8?B?UllTM01td1pMUG8zWEVuWHlwcWNvOGFQRFpwQmhrN012RDJBY2hBanJTTEpt?=
 =?utf-8?B?TkxFaU1taUJVQ2hqOUJvbElhZkVoYjVZTWZSSVZjL2gySG12a0NzbVpKMHYy?=
 =?utf-8?B?R2pKL0pIaHdjOXJqWmhTUVRSZEVKWU5tbmRCNlhjaXpQRkRaVkNyM09IanZm?=
 =?utf-8?B?S1F5OEF3NFp1VGRGN1ZIMGxJR2RmblBFRW1UVGRJcWFxSHBrcndDdjFRYVk0?=
 =?utf-8?B?WmlGZ0tyK2RwNFZzR2J6SHkyWmhhY1NlazNlWDMwZHJiYTdRNUdoR0xVTm1C?=
 =?utf-8?B?anh5bDQvWUpERUxEcXZxL3lsellydG9pNjcwU3p4aTVnU1RLUWI1UHV1L09k?=
 =?utf-8?B?cy90SFl6alV5R3N0RTRybkZKd3BOUnJOd0lmU2V3MWxDY2hZVVdBYk8wWnNr?=
 =?utf-8?B?b3hWUVdTd042ZDJVZlkvU09TbjB0cTMvSXFBZjZNRENwMlhocXNVY2VHemRY?=
 =?utf-8?B?VVZDb3NtY3ozblV6RW1BUE1YUDhLTnRPYW9HR2tGQ09NOEtyeDFKVXhlbHp1?=
 =?utf-8?B?c3orUW5pS1ZtUWRHWE9jL2h6R29paXM3TkNBVGtpcThiZGR2bEJQd2tmSGlp?=
 =?utf-8?B?UFQvWnVwYnhDVUE5V2pLVXZVQ2lCeDZoVjdDUnlOK2MycWxRdENkRlFyaWtw?=
 =?utf-8?B?bGpXUWdqVEUwck8yWGE5R1c3SWtkL3lJczk0czdTWVpFTGJtMWVCbmFQTzFp?=
 =?utf-8?B?ek5IdnBxTDZ0bUd4TUFBQU9zS0JtVVZlK1BIQUlFcC9pbkhIQkJsaXo4OW0v?=
 =?utf-8?B?aTBibk5tLzhtTmpXNWJLTy8vTFVpQkZjbXpEeUN3ZnZ3U0RvTFpQbDlGN2Z0?=
 =?utf-8?B?ZDk1enV0SFhjZGJrSlYyYUFiMkJrR0FrVW55YlhPWkVzMmEwbnBGc0daT3dS?=
 =?utf-8?B?THBBa3k3S2ROdHM2V1V1b1RWVXI0VmxZMGVZZjFHbDhXcTQ2MnBrdFBKVi8w?=
 =?utf-8?B?OGdLQjhRa1N2SVBaME01NXFQQ3FTTVNVdG90OWJIWnlKdU43aTdRUmJvK3lS?=
 =?utf-8?B?WXJxMU9DM3plaFhWaGpaUGIrUkgydHpMbjFxUlRBcmkzZVoyU05RWFl6bVZE?=
 =?utf-8?B?bDIxUExEMGl4MzNmR0g4cUo0cVlTNVZ3eEtGcTg0Zk0xWDNOQk04S0c5enNs?=
 =?utf-8?B?ZzhWSmRvL0NIR3pxRnQ5NDNvczNuRi9haFNycmJIdE9JYXNWMitDa3NGWkdJ?=
 =?utf-8?B?cjFLZlMyZ3IzQ1lpZk55MGRQRCszeHVEYklWa3RCNURmYW9LdDBKNFh3a25r?=
 =?utf-8?B?YUJyOGdEcVRldmFjd3Q3WjN0dHNrb3hnMVdEMHpvTW5YTncyY3IyVnBtQ2Rt?=
 =?utf-8?B?ZU5BdzluNjhkN0Z0Q2dqNy9hemMxVDFBS2NicSs2dktVSDhTTExadGlmdmd6?=
 =?utf-8?B?dnhIdjFsQnZEQlBnZWRuenpibDh4dFFPRklJaGY2dmN5Nys5ZFowbGZOdVVW?=
 =?utf-8?B?OEhER1lnSUF0bS83aG11T0JzZVpwaUF0clRLZGM3dWhxc1RNblorK0xzdkN2?=
 =?utf-8?B?Wlo1RDhCbGVoYXUrQm5NMGZTQjF6TjJjY3VpaTBxb25hWUtFeTMrM1R2b1dQ?=
 =?utf-8?B?ak1lZkdPa0F1UFZhYzFxSGFGWkRLNVlZNldFVUZERFd0aHFmZWFNcm53SGRY?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cdff8786-fa73-4247-8f19-08dbe5da1c83
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:55:15.0196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2JSfVNW2lUvVVDEPJeKFnT5FClT6RPj/Td4P5A42/UwVIH+RrpK7XugxRqd0dXqNHeL3EuJD+k6b9kZSuTYFAphWPu6XecCtEk6z9bZOfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5445
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.11.2023 11:55, Romain Gantois wrote:
> The Qualcomm IPQ4019 Ethernet Switch Subsystem for the IPQ4019 chip
> includes an internal Ethernet switch based on the QCA8K IP.
> 
> The CPU-to-switch port data plane depends on the IPQESS EDMA Controller,
> a simple 1G Ethernet controller. It is connected to the switch through an
> internal link, and doesn't expose directly any external interface.
> 
> The EDMA controller has 16 RX and TX queues, with a very basic RSS fanout
> configured at init time.
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

Hi Romain,
I see that you splitted the patch, thanks for that.
However it's still too big IMHO, edma ipqess_edma could be introduced in seperate file e.g.

> ---
>  MAINTAINERS                                   |    7 +
>  drivers/net/dsa/qca/qca8k-common.c            |   47 +-
>  drivers/net/ethernet/qualcomm/Kconfig         |   14 +
>  drivers/net/ethernet/qualcomm/Makefile        |    2 +
>  drivers/net/ethernet/qualcomm/ipqess/Makefile |    8 +
>  .../ethernet/qualcomm/ipqess/ipqess_edma.c    | 1188 +++++++++++++++++
>  .../ethernet/qualcomm/ipqess/ipqess_edma.h    |  488 +++++++
>  .../qualcomm/ipqess/ipqess_notifiers.h        |   29 +
>  .../ethernet/qualcomm/ipqess/ipqess_port.c    |  757 +++++++++++
>  .../ethernet/qualcomm/ipqess/ipqess_port.h    |   62 +
>  .../ethernet/qualcomm/ipqess/ipqess_switch.c  |  546 ++++++++
>  .../ethernet/qualcomm/ipqess/ipqess_switch.h  |   36 +
>  include/linux/dsa/qca8k.h                     |   47 +-
>  13 files changed, 3217 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/net/ethernet/qualcomm/ipqess/Makefile
>  create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.c
>  create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.h
>  create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.h
>  create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
>  create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
>  create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c
>  create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.h
> 

<...>

> diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.h b/drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.h
> new file mode 100644
> index 000000000000..172193d7126b
> --- /dev/null
> +++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.h
> @@ -0,0 +1,488 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR ISC) */
> +/* Copyright (c) 2014 - 2016, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2017 - 2018, John Crispin <john@phrozen.org>
> + * Copyright (c) 2018 - 2019, Christian Lamparter <chunkeey@gmail.com>
> + * Copyright (c) 2020 - 2021, Gabor Juhos <j4g8y7@gmail.com>
> + * Copyright (c) 2021 - 2022, Maxime Chevallier <maxime.chevallier@bootlin.com>
> + * Copyright (c) 2023, Romain Gantois <romain.gantois@bootlin.com>
> + *
> + */
> +

<...>

> +
> +/* TX descriptor fields */
> +#define IPQESS_EDMA_TPD_HDR_SHIFT 0
> +#define IPQESS_EDMA_TPD_PPPOE_EN 0x00000100
> +#define IPQESS_EDMA_TPD_IP_CSUM_EN 0x00000200
> +#define IPQESS_EDMA_TPD_TCP_CSUM_EN 0x0000400
> +#define IPQESS_EDMA_TPD_UDP_CSUM_EN 0x00000800
> +#define IPQESS_EDMA_TPD_CUSTOM_CSUM_EN 0x00000C00
> +#define IPQESS_EDMA_TPD_LSO_EN 0x00001000
> +#define IPQESS_EDMA_TPD_LSO_V2_EN 0x00002000
> +/* The VLAN_TAGGED bit is not used in the publicly available
> + * drivers. The definition has been stolen from the Atheros
> + * 'alx' driver (drivers/net/ethernet/atheros/alx/hw.h). It
> + * seems that it has the same meaning in regard to the EDMA
> + * hardware.
> + */
> +#define IPQESS_EDMA_TPD_VLAN_TAGGED 0x00004000
> +#define IPQESS_EDMA_TPD_IPV4_EN 0x00010000
> +#define IPQESS_EDMA_TPD_MSS_MASK 0x1FFF
> +#define IPQESS_EDMA_TPD_MSS_SHIFT 18
> +#define IPQESS_EDMA_TPD_CUSTOM_CSUM_SHIFT 18
> +
> +/* RRD descriptor fields */
> +#define IPQESS_EDMA_RRD_NUM_RFD_MASK 0x000F
> +#define IPQESS_EDMA_RRD_PKT_SIZE_MASK 0x3FFF
> +#define IPQESS_EDMA_RRD_SRC_PORT_NUM_MASK 0x4000
> +#define IPQESS_EDMA_RRD_SVLAN 0x8000
> +#define IPQESS_EDMA_RRD_FLOW_COOKIE_MASK 0x07FF
> +
> +#define IPQESS_EDMA_RRD_PKT_SIZE_MASK 0x3FFF
> +#define IPQESS_EDMA_RRD_CSUM_FAIL_MASK 0xC000
> +#define IPQESS_EDMA_RRD_CVLAN 0x0001
> +#define IPQESS_EDMA_RRD_DESC_VALID 0x8000
> +
> +#define IPQESS_EDMA_RRD_PRIORITY_SHIFT 4
> +#define IPQESS_EDMA_RRD_PRIORITY_MASK 0x7
> +#define IPQESS_EDMA_RRD_PORT_TYPE_SHIFT 7
> +#define IPQESS_EDMA_RRD_PORT_TYPE_MASK 0x1F
> +
> +#define IPQESS_EDMA_RRD_PORT_ID_MASK 0x7000
> +
> +#define IPQESS_EDMA_MAX_MTU 9000

I see that some of those defines are unused in this patch. 
They should be introduced together with their references and if
they have no usecaes then those defines should be dropped.

> +
> +#endif
> diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.h b/drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.h
> new file mode 100644
> index 000000000000..47f06a757cf7
> --- /dev/null
> +++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR ISC */
> +
> +#ifndef IPQESS_NOTIFIERS_H
> +#define IPQESS_NOTIFIERS_H
> +
> +#include <linux/if_ether.h>
> +
> +struct ipqess_switchdev_event_work {
> +	struct net_device *netdev;
> +	struct net_device *orig_netdev;
> +	struct work_struct work;
> +	unsigned long event;
> +	/* Specific for SWITCHDEV_FDB_ADD_TO_DEVICE and
> +	 * SWITCHDEV_FDB_DEL_TO_DEVICE
> +	 */
> +	unsigned char addr[ETH_ALEN];
> +	u16 vid;
> +	bool host_addr;
> +};
> +
> +extern struct notifier_block ipqess_switchdev_notifier;
> +extern struct notifier_block ipqess_switchdev_blocking_notifier;
> +
> +int ipqess_notifiers_register(void);
> +void ipqess_notifiers_unregister(void);
> +
> +void ipqess_flush_workqueue(void);

This is unused in this patch, I think this file should be moved to the 5th one.

> +
> +#endif
> diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
> new file mode 100644
> index 000000000000..f0f5fe3a7c24
> --- /dev/null
> +++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
> @@ -0,0 +1,757 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Handling of a single switch port
> + *
> + * Copyright (c) 2023, Romain Gantois <romain.gantois@bootlin.com>
> + * Based on net/dsa
> + */
> +
> +#include <linux/if_bridge.h>
> +#include <linux/etherdevice.h>
> +#include <linux/if_vlan.h>
> +#include <linux/of_net.h>
> +
> +#include "ipqess_port.h"
> +#include "ipqess_edma.h"
> +#include "ipqess_switch.h"
> +#include "ipqess_notifiers.h"
> +
> +#define ipqess_port_from_pl_state(config, pl_config)\
> +container_of(config, struct ipqess_port, pl_config)
> +
> +static struct device_type ipqess_port_type = {
> +	.name	= "switch",
> +};
> +
> +/* netdev ops */
> +
> +static void ipqess_port_fast_age(const struct ipqess_port *port)
> +{
> +	struct qca8k_priv *priv = port->sw->priv;
> +
> +	mutex_lock(&priv->reg_mutex);
> +	qca8k_fdb_access(priv, QCA8K_FDB_FLUSH_PORT, port->index);
> +	mutex_unlock(&priv->reg_mutex);
> +}
> +
> +static void ipqess_port_stp_state_set(struct ipqess_port *port,
> +				      u8 state)
> +{
> +	struct qca8k_priv *priv = port->sw->priv;
> +	u32 stp_state;
> +	int err;
> +
> +	switch (state) {
> +	case BR_STATE_DISABLED:
> +		stp_state = QCA8K_PORT_LOOKUP_STATE_DISABLED;
> +		break;
> +	case BR_STATE_BLOCKING:
> +		stp_state = QCA8K_PORT_LOOKUP_STATE_BLOCKING;
> +		break;
> +	case BR_STATE_LISTENING:
> +		stp_state = QCA8K_PORT_LOOKUP_STATE_LISTENING;
> +		break;
> +	case BR_STATE_LEARNING:
> +		stp_state = QCA8K_PORT_LOOKUP_STATE_LEARNING;
> +		break;
> +	case BR_STATE_FORWARDING:
> +	default:
> +		stp_state = QCA8K_PORT_LOOKUP_STATE_FORWARD;
> +		break;
> +	}
> +
> +	err = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port->index),
> +			QCA8K_PORT_LOOKUP_STATE_MASK, stp_state);
> +
> +	if (err)
> +		dev_warn(priv->dev,
> +			 "failed to set STP state %d for port %d: err %d\n",
> +			 stp_state, port->index, err);
> +}
> +
> +static void ipqess_port_set_state_now(struct ipqess_port *port,
> +				      u8 state, bool do_fast_age)
> +{
> +	ipqess_port_stp_state_set(port, state);
> +
> +	if ((port->stp_state == BR_STATE_LEARNING ||
> +	     port->stp_state == BR_STATE_FORWARDING) &&
> +	    (state == BR_STATE_DISABLED || state == BR_STATE_BLOCKING ||
> +	    state == BR_STATE_LISTENING))
> +		ipqess_port_fast_age(port);
> +
> +	port->stp_state = state;
> +}
> +
> +static int ipqess_port_enable_rt(struct ipqess_port *port,
> +				 struct phy_device *phy)
> +{
> +	struct qca8k_priv *priv = port->sw->priv;
> +
> +	qca8k_port_set_status(priv, port->index, 1);
> +	priv->port_enabled_map |= BIT(port->index);
> +
> +	phy_support_asym_pause(phy);
> +
> +	ipqess_port_set_state_now(port, BR_STATE_FORWARDING, false);
> +
> +	if (port->pl)
> +		phylink_start(port->pl);
> +
> +	return 0;
> +}
> +
> +static void ipqess_port_disable_rt(struct ipqess_port *port)
> +{
> +	struct qca8k_priv *priv = port->sw->priv;
> +
> +	if (port->pl)
> +		phylink_stop(port->pl);
> +
> +	ipqess_port_set_state_now(port, BR_STATE_DISABLED, false);
> +
> +	qca8k_port_set_status(priv, port->index, 0);
> +	priv->port_enabled_map &= ~BIT(port->index);
> +}
> +
> +static int ipqess_port_open(struct net_device *netdev)
> +{
> +	struct ipqess_port *port = netdev_priv(netdev);
> +	struct phy_device *phy = netdev->phydev;
> +
> +	return ipqess_port_enable_rt(port, phy);
> +}
> +
> +static int ipqess_port_close(struct net_device *netdev)
> +{
> +	struct ipqess_port *port = netdev_priv(netdev);
> +
> +	ipqess_port_disable_rt(port);
> +
> +	return 0;
> +}
> +
> +static netdev_tx_t ipqess_port_xmit(struct sk_buff *skb,
> +				    struct net_device *netdev)
> +{
> +	struct ipqess_port *port = netdev_priv(netdev);
> +
> +	dev_sw_netstats_tx_add(netdev, 1, skb->len);
> +
> +	memset(skb->cb, 0, sizeof(skb->cb));
> +
> +	return ipqess_edma_xmit(skb, port->netdev);
> +}
> +
> +static int ipqess_port_set_mac_address(struct net_device *netdev, void *a)
> +{
> +	struct sockaddr *addr = a;
> +	int err;> +
> +	/* If the port is down, the address isn't synced yet to hardware
> +	 * so there is nothing to change
> +	 */
> +	if (!(netdev->flags & IFF_UP)) {
> +		eth_hw_addr_set(netdev, addr->sa_data);
> +		return 0;
> +	}
> +
> +	if (!ether_addr_equal(addr->sa_data, netdev->dev_addr)) {
> +		err = dev_uc_add(netdev, addr->sa_data);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ipqess_port_ioctl(struct net_device *netdev, struct ifreq *ifr,
> +			     int cmd)
> +{
> +	struct ipqess_port *port = netdev_priv(netdev);
> +
> +	return phylink_mii_ioctl(port->pl, ifr, cmd);
> +}
> +
> +static int ipqess_port_get_iflink(const struct net_device *dev)
> +{
> +	return dev->ifindex;
> +}
> +
> +static int ipqess_port_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	struct ipqess_port *port = netdev_priv(dev);
> +	struct qca8k_priv *priv = port->sw->priv;
> +	int err;
> +
> +	/* To change the MAX_FRAME_SIZE, the cpu port must be off
> +	 * or the switch panics.
> +	 */
> +	if (port->sw->port0_enabled)
> +		qca8k_port_set_status(priv, 0, 0);
> +
> +	err = qca8k_write(priv, QCA8K_MAX_FRAME_SIZE, new_mtu +
> +			  ETH_HLEN + ETH_FCS_LEN);
> +
> +	if (port->sw->port0_enabled)
> +		qca8k_port_set_status(priv, 0, 1);
> +
> +	if (err)
> +		return err;
> +
> +	dev->mtu = new_mtu;
> +
> +	return 0;
> +}
> +
> +static int ipqess_port_do_vlan_add(struct qca8k_priv *priv, int port_index,
> +				   const struct switchdev_obj_port_vlan *vlan,
> +				   struct netlink_ext_ack *extack)
> +{
> +	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
> +	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
> +	int ret;
> +
> +	ret = qca8k_vlan_add(priv, port_index, vlan->vid, untagged);
> +	if (ret) {
> +		dev_err(priv->dev, "Failed to add VLAN to port %d (%d)", port_index,
> +			ret);
> +		return ret;
> +	}
> +
> +	if (pvid) {
> +		ret = qca8k_rmw(priv, QCA8K_EGRESS_VLAN(port_index),
> +				QCA8K_EGREES_VLAN_PORT_MASK(port_index),
> +				QCA8K_EGREES_VLAN_PORT(port_index, vlan->vid));
> +		if (ret)
> +			return ret;
> +
> +		ret = qca8k_write(priv, QCA8K_REG_PORT_VLAN_CTRL0(port_index),
> +				  QCA8K_PORT_VLAN_CVID(vlan->vid) |
> +				  QCA8K_PORT_VLAN_SVID(vlan->vid));
> +	}
> +
> +	return ret;
> +}
> +
> +static int ipqess_port_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
> +				       u16 vid)
> +{
> +	struct ipqess_port *port = netdev_priv(dev);
> +	struct switchdev_obj_port_vlan vlan = {
> +		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
> +		.vid = vid,
> +		/* This API only allows programming tagged, non-PVID VIDs */
> +		.flags = 0,
> +	};
> +	struct netlink_ext_ack extack = {0};
> +	int ret;
> +
> +	/* User port... */
> +	ret = ipqess_port_do_vlan_add(port->sw->priv, port->index, &vlan, &extack);
> +	if (ret) {
> +		if (extack._msg)
> +			netdev_err(dev, "%s\n", extack._msg);
> +		return ret;
> +	}
> +
> +	/* And CPU port... */
> +	ret = ipqess_port_do_vlan_add(port->sw->priv, 0, &vlan, &extack);
> +	if (ret) {

Should we delete vlan from user port if this fails?

> +		if (extack._msg)
> +			netdev_err(dev, "CPU port %d: %s\n", 0, extack._msg);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ipqess_port_vlan_rx_kill_vid(struct net_device *dev, __be16 proto,
> +					u16 vid)
> +{
> +	struct ipqess_port *port = netdev_priv(dev);
> +	int err;
> +
> +	err = qca8k_vlan_del(port->sw->priv, port->index, vid);
> +	if (err)
> +		return err;
> +
> +	err = qca8k_vlan_del(port->sw->priv, 0, vid);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int
> +ipqess_port_fdb_do_dump(const unsigned char *addr, u16 vid,
> +			bool is_static, void *data)
> +{
> +	struct ipqess_port_dump_ctx *dump = data;
> +	u32 portid = NETLINK_CB(dump->cb->skb).portid;
> +	u32 seq = dump->cb->nlh->nlmsg_seq;
> +	struct nlmsghdr *nlh;
> +	struct ndmsg *ndm;
> +
> +	if (dump->idx < dump->cb->args[2])
> +		goto skip;
> +
> +	nlh = nlmsg_put(dump->skb, portid, seq, RTM_NEWNEIGH,
> +			sizeof(*ndm), NLM_F_MULTI);
> +	if (!nlh)
> +		return -EMSGSIZE;
> +
> +	ndm = nlmsg_data(nlh);
> +	ndm->ndm_family  = AF_BRIDGE;
> +	ndm->ndm_pad1    = 0;
> +	ndm->ndm_pad2    = 0;
> +	ndm->ndm_flags   = NTF_SELF;
> +	ndm->ndm_type    = 0;
> +	ndm->ndm_ifindex = dump->dev->ifindex;
> +	ndm->ndm_state   = is_static ? NUD_NOARP : NUD_REACHABLE;
> +
> +	if (nla_put(dump->skb, NDA_LLADDR, ETH_ALEN, addr))
> +		goto nla_put_failure;
> +
> +	if (vid && nla_put_u16(dump->skb, NDA_VLAN, vid))
> +		goto nla_put_failure;
> +
> +	nlmsg_end(dump->skb, nlh);
> +
> +skip:
> +	dump->idx++;
> +	return 0;
> +
> +nla_put_failure:
> +	nlmsg_cancel(dump->skb, nlh);
> +	return -EMSGSIZE;
> +}
> +
> +static int
> +ipqess_port_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
> +		     struct net_device *dev, struct net_device *filter_dev,
> +		     int *idx)
> +{
> +	struct ipqess_port *port = netdev_priv(dev);
> +	struct qca8k_priv *priv = port->sw->priv;
> +	struct ipqess_port_dump_ctx dump = {
> +		.dev = dev,
> +		.skb = skb,
> +		.cb = cb,
> +		.idx = *idx,
> +	};
> +	int cnt = QCA8K_NUM_FDB_RECORDS;
> +	struct qca8k_fdb _fdb = { 0 };
> +	bool is_static;
> +	int ret = 0;
> +
> +	mutex_lock(&priv->reg_mutex);
> +	while (cnt-- && !qca8k_fdb_next(priv, &_fdb, port->index)) {
> +		if (!_fdb.aging)
> +			break;
> +		is_static = (_fdb.aging == QCA8K_ATU_STATUS_STATIC);
> +		ret = ipqess_port_fdb_do_dump(_fdb.mac, _fdb.vid, is_static, &dump);
> +		if (ret)
> +			break;
> +	}
> +	mutex_unlock(&priv->reg_mutex);
> +
> +	*idx = dump.idx;
> +
> +	return ret;
> +}
> +
> +static const struct net_device_ops ipqess_port_netdev_ops = {
> +	.ndo_open               = ipqess_port_open,
> +	.ndo_stop               = ipqess_port_close,
> +	.ndo_set_mac_address    = ipqess_port_set_mac_address,
> +	.ndo_eth_ioctl          = ipqess_port_ioctl,
> +	.ndo_start_xmit         = ipqess_port_xmit,
> +	.ndo_get_iflink         = ipqess_port_get_iflink,
> +	.ndo_change_mtu         = ipqess_port_change_mtu,
> +	.ndo_vlan_rx_add_vid    = ipqess_port_vlan_rx_add_vid,
> +	.ndo_vlan_rx_kill_vid   = ipqess_port_vlan_rx_kill_vid,
> +	.ndo_fdb_dump           = ipqess_port_fdb_dump,
> +};
> +
> +/* phylink ops */
> +
> +static void
> +ipqess_phylink_mac_config(struct phylink_config *config,
> +			  unsigned int mode,
> +			  const struct phylink_link_state *state)
> +{
> +	struct ipqess_port *port = ipqess_port_from_pl_state(config, pl_config);
> +	struct qca8k_priv *priv = port->sw->priv;
> +
> +	switch (port->index) {
> +	case 0:
> +		/* CPU port, no configuration needed */
> +		return;
> +	case 1:
> +	case 2:
> +	case 3:
> +	case 4:
> +	case 5:
> +		if (phy_interface_mode_is_rgmii(state->interface))
> +			regmap_set_bits(priv->regmap,
> +					QCA8K_IPQ4019_REG_RGMII_CTRL,
> +					QCA8K_IPQ4019_RGMII_CTRL_CLK);
> +		return;
> +	default:
> +		dev_err(priv->dev, "%s: unsupported port: %i\n", __func__,
> +			port->index);
> +		return;
> +	}
> +}
> +
> +static void
> +ipqess_phylink_mac_link_down(struct phylink_config *config,
> +			     unsigned int mode,
> +			     phy_interface_t interface)
> +{
> +	struct ipqess_port *port = ipqess_port_from_pl_state(config, pl_config);
> +	struct qca8k_priv *priv = port->sw->priv;
> +
> +	qca8k_port_set_status(priv, port->index, 0);
> +}
> +
> +static void ipqess_phylink_mac_link_up(struct phylink_config *config,
> +				       struct phy_device *phydev,
> +				       unsigned int mode,
> +				       phy_interface_t interface,
> +				       int speed, int duplex,
> +				       bool tx_pause, bool rx_pause)
> +{
> +	struct ipqess_port *port = ipqess_port_from_pl_state(config, pl_config);
> +	struct qca8k_priv *priv = port->sw->priv;
> +	u32 reg;
> +
> +	if (phylink_autoneg_inband(mode)) {
> +		reg = QCA8K_PORT_STATUS_LINK_AUTO;
> +	} else {
> +		switch (speed) {
> +		case SPEED_10:
> +			reg = QCA8K_PORT_STATUS_SPEED_10;
> +			break;
> +		case SPEED_100:
> +			reg = QCA8K_PORT_STATUS_SPEED_100;
> +			break;
> +		case SPEED_1000:
> +			reg = QCA8K_PORT_STATUS_SPEED_1000;
> +			break;
> +		default:
> +			reg = QCA8K_PORT_STATUS_LINK_AUTO;
> +			break;
> +		}
> +
> +		if (duplex == DUPLEX_FULL)
> +			reg |= QCA8K_PORT_STATUS_DUPLEX;
> +
> +		if (rx_pause || port->index == 0)

nit: this could be !port->index instead of port->index == 0

> +			reg |= QCA8K_PORT_STATUS_RXFLOW;
> +
> +		if (tx_pause || port->index == 0)
> +			reg |= QCA8K_PORT_STATUS_TXFLOW;
> +	}
> +
> +	reg |= QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
> +
> +	qca8k_write(priv, QCA8K_REG_PORT_STATUS(port->index), reg);
> +}
> +
> +static const struct phylink_mac_ops ipqess_phylink_mac_ops = {
> +	.mac_config = ipqess_phylink_mac_config,
> +	.mac_link_down = ipqess_phylink_mac_link_down,
> +	.mac_link_up = ipqess_phylink_mac_link_up,
> +};
> +
> +static int ipqess_phylink_create(struct net_device *netdev)
> +{
> +	struct ipqess_port *port = netdev_priv(netdev);
> +	struct phylink_config *pl_config = &port->pl_config;
> +	phy_interface_t mode;
> +	struct phylink *pl;
> +	int err;
> +
> +	err = of_get_phy_mode(port->dn, &mode);
> +	if (err)
> +		mode = PHY_INTERFACE_MODE_NA;
> +
> +	switch (port->index) {
> +	case 1:
> +	case 2:
> +	case 3:
> +		__set_bit(PHY_INTERFACE_MODE_PSGMII,
> +			  pl_config->supported_interfaces);
> +		break;
> +	case 4:
> +	case 5:
> +		phy_interface_set_rgmii(pl_config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_PSGMII,
> +			  pl_config->supported_interfaces);
> +		break;
> +	case 0: /* CPU port, this shouldn't happen */
> +	default:
> +		return -EINVAL;
> +	}
> +	/* phylink caps */
> +	pl_config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +		MAC_10 | MAC_100 | MAC_1000FD;
> +
> +	pl = phylink_create(pl_config, of_fwnode_handle(port->dn),
> +			    mode, &ipqess_phylink_mac_ops);
> +	if (IS_ERR(pl))
> +		return PTR_ERR(pl);
> +
> +	port->pl = pl;
> +	return 0;
> +}
> +
> +static int ipqess_port_phy_connect(struct net_device *netdev, int addr,
> +				   u32 flags)
> +{
> +	struct ipqess_port *port = netdev_priv(netdev);
> +
> +	netdev->phydev = mdiobus_get_phy(port->mii_bus, addr);
> +	if (!netdev->phydev) {
> +		netdev_err(netdev, "no phy at %d\n", addr);
> +		return -ENODEV;
> +	}
> +
> +	netdev->phydev->dev_flags |= flags;
> +
> +	return phylink_connect_phy(port->pl, netdev->phydev);
> +}
> +
> +static int ipqess_port_phy_setup(struct net_device *netdev)
> +{
> +	struct ipqess_port *port = netdev_priv(netdev);
> +	struct device_node *port_dn = port->dn;
> +	u32 phy_flags = 0;
> +	int ret;
> +
> +	port->pl_config.dev = &netdev->dev;
> +	port->pl_config.type = PHYLINK_NETDEV;
> +
> +	ret = ipqess_phylink_create(netdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = phylink_of_phy_connect(port->pl, port_dn, phy_flags);
> +	if (ret == -ENODEV && port->mii_bus) {
> +		/* We could not connect to a designated PHY or SFP, so try to
> +		 * use the switch internal MDIO bus instead
> +		 */
> +		ret = ipqess_port_phy_connect(netdev, port->index, phy_flags);
> +	}
> +
> +	if (ret) {
> +		netdev_err(netdev, "failed to connect to PHY: %pe\n",
> +			   ERR_PTR(ret));
> +		phylink_destroy(port->pl);
> +		port->pl = NULL;
> +	}
> +
> +	dev_info(&netdev->dev, "enabled port's phy: %s",
> +		 phydev_name(netdev->phydev));
> +	return ret;
> +}
> +
> +/* netlink */
> +
> +#define IFLA_IPQESS_UNSPEC 0
> +#define IFLA_IPQESS_MAX 0
> +
> +static const struct nla_policy ipqess_port_policy[IFLA_IPQESS_MAX + 1] = {
> +	[IFLA_IPQESS_MAX] = { .type = NLA_U32 },
> +};
> +
> +static size_t ipqess_port_get_size(const struct net_device *dev)
> +{
> +	return nla_total_size(sizeof(u32));
> +}
> +
> +static int ipqess_port_fill_info(struct sk_buff *skb,
> +				 const struct net_device *dev)
> +{
> +	if (nla_put_u32(skb, IFLA_IPQESS_UNSPEC, dev->ifindex))
> +		return -EMSGSIZE;
> +
> +	return 0;
> +}
> +
> +static struct rtnl_link_ops ipqess_port_link_ops __read_mostly = {
> +	.kind         = "switch",
> +	.priv_size    = sizeof(struct ipqess_port),
> +	.maxtype      = 1,
> +	.policy       = ipqess_port_policy,
> +	.get_size     = ipqess_port_get_size,
> +	.fill_info    = ipqess_port_fill_info,
> +	.netns_refund = true,
> +};
> +
> +/* devlink */
> +
> +static int ipqess_port_devlink_setup(struct ipqess_port *port)
> +{
> +	struct devlink_port *dlp = &port->devlink_port;
> +	struct devlink *dl = port->sw->devlink;
> +	struct devlink_port_attrs attrs = {};
> +	const unsigned char *id;
> +	unsigned int index = 0;
> +	unsigned char len;
> +	int err;
> +
> +	id = (const unsigned char *)&index;
> +	len = sizeof(index);
> +	memset(dlp, 0, sizeof(*dlp));
> +
> +	attrs.phys.port_number = port->index;
> +	memcpy(attrs.switch_id.id, id, len);
> +	attrs.switch_id.id_len = len;
> +	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
> +	devlink_port_attrs_set(dlp, &attrs);
> +
> +	err = devlink_port_register(dl, dlp, port->index);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +/* register */
> +
> +int ipqess_port_register(struct ipqess_switch *sw,
> +			 struct device_node *port_node)
> +{
> +	struct qca8k_priv *priv = sw->priv;
> +	struct net_device *netdev;
> +	struct ipqess_port *port;
> +	const char *name;
> +	int assign_type;
> +	int num_queues;
> +	u32 index;
> +	int err;
> +
> +	err = of_property_read_u32(port_node, "reg", &index);
> +	if (err) {
> +		pr_err("Node without reg property!");
> +		return err;
> +	}
> +
> +	name = of_get_property(port_node, "label", NULL);
> +	if (!name) {
> +		name = "eth%d";
> +		assign_type = NET_NAME_ENUM;
> +	} else {
> +		assign_type = NET_NAME_PREDICTABLE;
> +	}
> +
> +	/* For the NAPI leader, we allocate one queue per MAC queue */
> +	if (!sw->napi_leader)
> +		num_queues = IPQESS_EDMA_NETDEV_QUEUES;
> +	else
> +		num_queues = 1;
> +
> +	netdev = alloc_netdev_mqs(sizeof(struct ipqess_port), name, assign_type,
> +				  ether_setup, num_queues, num_queues);
> +	if (!netdev)
> +		return -ENOMEM;
> +
> +	if (!sw->napi_leader)
> +		sw->napi_leader = netdev;
> +
> +	port = netdev_priv(netdev);
> +	port->index = (int)index;
> +	port->dn = port_node;
> +	port->netdev = netdev;
> +	port->edma = NULL; /* Assigned during edma initialization */
> +	port->qid = port->index - 1;
> +	port->sw = sw;
> +
> +	of_get_mac_address(port_node, port->mac);
> +	if (!is_zero_ether_addr(port->mac))
> +		eth_hw_addr_set(netdev, port->mac);
> +	else
> +		eth_hw_addr_random(netdev);
> +
> +	netdev->netdev_ops = &ipqess_port_netdev_ops;
> +	netdev->max_mtu = QCA8K_MAX_MTU;
> +	SET_NETDEV_DEVTYPE(netdev, &ipqess_port_type);
> +	SET_NETDEV_DEV(netdev, priv->dev);
> +	SET_NETDEV_DEVLINK_PORT(netdev, &port->devlink_port);
> +	netdev->dev.of_node = port->dn;
> +
> +	netdev->rtnl_link_ops = &ipqess_port_link_ops;
> +
> +	netdev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
> +	if (!netdev->tstats) {
> +		free_netdev(netdev);
> +		return -ENOMEM;
> +	}
> +
> +	err = ipqess_port_devlink_setup(port);
> +	if (err)
> +		goto out_free;
> +
> +	err = gro_cells_init(&port->gcells, netdev);
> +	if (err)
> +		goto out_devlink;
> +
> +	err = ipqess_port_phy_setup(netdev);
> +	if (err) {
> +		pr_err("error setting up PHY: %d\n", err);
> +		goto out_gcells;
> +	}
> +
> +	/* We use the qid and not the index because port 0 isn't registered */
> +	sw->port_list[port->qid] = port;
> +
> +	err = register_netdev(netdev);
> +	if (err) {
> +		pr_err("error %d registering interface %s\n",
> +		       err, netdev->name);
> +		rtnl_unlock();
> +		goto out_phy;
> +	}
> +
> +	return 0;
> +
> +out_phy:
> +	rtnl_lock();
> +	phylink_disconnect_phy(port->pl);
> +	rtnl_unlock();
> +	phylink_destroy(port->pl);
> +	port->pl = NULL;
> +out_gcells:
> +	gro_cells_destroy(&port->gcells);
> +out_devlink:
> +	devlink_port_unregister(&port->devlink_port);
> +out_free:
> +	free_percpu(netdev->tstats);
> +	free_netdev(netdev);
> +	sw->port_list[port->qid] = NULL;
> +	return err;
> +}
> +
> +void ipqess_port_unregister(struct ipqess_port *port)
> +{
> +	struct net_device *netdev = port->netdev;
> +
> +	unregister_netdev(netdev);
> +
> +	devlink_port_unregister(&port->devlink_port);
> +
> +	rtnl_lock();
> +	phylink_disconnect_phy(port->pl);
> +	rtnl_unlock();
> +	phylink_destroy(port->pl);
> +	port->pl = NULL;
> +
> +	gro_cells_destroy(&port->gcells);
> +
> +	free_percpu(netdev->tstats);
> +	free_netdev(netdev);
> +}
> +
> diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
> new file mode 100644
> index 000000000000..26bac45dd811
> --- /dev/null
> +++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR ISC */
> +
> +#ifndef IPQESS_PORT_H
> +#define IPQESS_PORT_H
> +
> +#include <net/gro_cells.h>
> +#include <net/devlink.h>
> +
> +#include "ipqess_edma.h"
> +#include "ipqess_switch.h"
> +
> +struct ipqess_port {
> +	u16 index;
> +	u16 qid;
> +
> +	struct ipqess_edma *edma;
> +	struct ipqess_switch *sw;
> +	struct phylink *pl;
> +	struct phylink_config pl_config;
> +	struct device_node *dn;
> +	struct mii_bus *mii_bus;
> +	struct net_device *netdev;
> +	struct devlink_port devlink_port;
> +
> +	u8       stp_state;
> +
> +	u8       mac[ETH_ALEN];
> +
> +	/* Warning: the following bit field is not atomic, and updating it
> +	 * can only be done from code paths where concurrency is not possible
> +	 * (probe time or under rtnl_lock).
> +	 */
> +	u8			vlan_filtering:1;
> +
> +	unsigned int		ageing_time;
> +
> +	struct gro_cells	gcells;
> +
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +	struct netpoll		*netpoll;
> +#endif
> +};
> +
> +struct ipqess_port_dump_ctx {
> +	struct net_device *dev;
> +	struct sk_buff *skb;
> +	struct netlink_callback *cb;
> +	int idx;
> +};
> +
> +struct ipqess_mac_addr {
> +	unsigned char addr[ETH_ALEN];
> +	u16 vid;
> +	refcount_t refcount;
> +	struct list_head list;
> +};
> +
> +int ipqess_port_register(struct ipqess_switch *sw,
> +			 struct device_node *port_node);
> +void ipqess_port_unregister(struct ipqess_port *port);
> +
> +#endif
> diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c
> new file mode 100644
> index 000000000000..927f834a62bc
> --- /dev/null
> +++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c
> @@ -0,0 +1,546 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023, Romain Gantois <romain.gantois@bootlin.com>
> + * Based on net/dsa
> + */
> +
> +#include <linux/dsa/qca8k.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_mdio.h>
> +#include <linux/reset.h>
> +
> +#include "ipqess_switch.h"
> +#include "ipqess_port.h"
> +#include "ipqess_edma.h"
> +
> +static struct regmap_config qca8k_ipqess_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = 0x16ac, /* end MIB - Port6 range */
> +	.rd_table = &qca8k_readable_table,
> +};
> +
> +static struct regmap_config qca8k_ipqess_psgmii_phy_regmap_config = {
> +	.name = "psgmii-phy",
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = 0x7fc,
> +};
> +
> +static const struct qca8k_match_data ipqess = {
> +	.id = IPQESS_SWITCH_ID,
> +	.mib_count = QCA8K_QCA833X_MIB_COUNT,
> +};
> +
> +/* devlink */
> +
> +static const struct devlink_ops ipqess_devlink_ops = {
> +	/* no ops supported by this driver */
> +};
> +
> +static int ipqess_switch_devlink_alloc(struct ipqess_switch *sw)
> +{
> +	struct ipqess_switch **dl_priv;
> +	struct devlink *dl;
> +
> +	/* Add the switch to devlink before calling setup, so that setup can
> +	 * add dpipe tables
> +	 */
> +	dl = devlink_alloc(&ipqess_devlink_ops, sizeof(*dl_priv), sw->priv->dev);
> +	if (!dl)
> +		return -ENOMEM;

Sorry, this not what I meant. You can use devlink_alloc to allocate ipqess_switch.
Which means it has to be the first thing done in ipqess_switch_probe.

	struct ipqess_switch *sw

	devlink = devlink_alloc(&ice_devlink_ops, sizeof(struct ipqess_switch), dev);
	if (!devlink)
		return NULL;

	sw = devlink_priv(devlink);

> +
> +	sw->devlink = dl;
> +
> +	dl_priv = devlink_priv(sw->devlink);
> +	*dl_priv = sw;
> +
> +	return 0;
> +}
> +
> +/* setup */
> +
> +unsigned int ipqess_switch_fastest_ageing_time(struct ipqess_switch *sw,
> +					       unsigned int ageing_time)
> +{
> +	struct ipqess_port *port;
> +	int i;
> +
> +	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
> +		port = sw->port_list[i];
> +		if (port && port->ageing_time && port->ageing_time < ageing_time)
> +			ageing_time = port->ageing_time;
> +	}
> +
> +	return ageing_time;
> +}
> +
> +int ipqess_set_ageing_time(struct ipqess_switch *sw, unsigned int msecs)
> +{
> +	struct qca8k_priv *priv = sw->priv;
> +	unsigned int secs = msecs / 1000;
> +	u32 val;
> +
> +	/* AGE_TIME reg is set in 7s step */
> +	val = secs / 7;
> +
> +	/* Handle case with 0 as val to NOT disable
> +	 * learning
> +	 */
> +	if (!val)
> +		val = 1;
> +
> +	return regmap_update_bits(priv->regmap, QCA8K_REG_ATU_CTRL,
> +				  QCA8K_ATU_AGE_TIME_MASK,
> +				  QCA8K_ATU_AGE_TIME(val));
> +}
> +
> +static struct qca8k_pcs *pcs_to_qca8k_pcs(struct phylink_pcs *pcs)
> +{
> +	return container_of(pcs, struct qca8k_pcs, pcs);
> +}
> +
> +static void ipqess_switch_pcs_get_state(struct phylink_pcs *pcs,
> +					struct phylink_link_state *state)
> +{
> +	struct qca8k_priv *priv = pcs_to_qca8k_pcs(pcs)->priv;
> +	int port = pcs_to_qca8k_pcs(pcs)->port;
> +	u32 reg;
> +	int ret;
> +
> +	ret = qca8k_read(priv, QCA8K_REG_PORT_STATUS(port), &reg);
> +	if (ret < 0) {

Could be just
	if (ret)

> +		state->link = false;
> +		return;
> +	}
> +
> +	state->link = !!(reg & QCA8K_PORT_STATUS_LINK_UP);
> +	state->an_complete = state->link;
> +	state->duplex = (reg & QCA8K_PORT_STATUS_DUPLEX) ? DUPLEX_FULL :
> +							DUPLEX_HALF;
> +
> +	switch (reg & QCA8K_PORT_STATUS_SPEED) {
> +	case QCA8K_PORT_STATUS_SPEED_10:
> +		state->speed = SPEED_10;
> +		break;
> +	case QCA8K_PORT_STATUS_SPEED_100:
> +		state->speed = SPEED_100;
> +		break;
> +	case QCA8K_PORT_STATUS_SPEED_1000:
> +		state->speed = SPEED_1000;
> +		break;
> +	default:
> +		state->speed = SPEED_UNKNOWN;
> +		break;
> +	}
> +
> +	if (reg & QCA8K_PORT_STATUS_RXFLOW)
> +		state->pause |= MLO_PAUSE_RX;
> +	if (reg & QCA8K_PORT_STATUS_TXFLOW)
> +		state->pause |= MLO_PAUSE_TX;
> +}
> +
> +static int ipqess_switch_pcs_config(struct phylink_pcs *pcs, unsigned int mode,
> +				    phy_interface_t interface,
> +				    const unsigned long *advertising,
> +				    bool permit_pause_to_mac)
> +{
> +	return 0;
> +}
> +
> +static void ipqess_switch_pcs_an_restart(struct phylink_pcs *pcs)
> +{
> +}

Empty functions, I'm guessing they're going to be filled in one of the next patches.
If yes, then I'd move them to this patch.

> +
> +static const struct phylink_pcs_ops qca8k_pcs_ops = {
> +	.pcs_get_state = ipqess_switch_pcs_get_state,
> +	.pcs_config = ipqess_switch_pcs_config,
> +	.pcs_an_restart = ipqess_switch_pcs_an_restart,
> +};
> +
> +static void ipqess_switch_setup_pcs(struct qca8k_priv *priv,
> +				    struct qca8k_pcs *qpcs,
> +				    int port_index)
> +{
> +	qpcs->pcs.ops = &qca8k_pcs_ops;
> +
> +	/* We don't have interrupts for link changes, so we need to poll */
> +	qpcs->pcs.poll = true;
> +	qpcs->priv = priv;
> +	qpcs->port = port_index;
> +}
> +
> +static int ipqess_switch_setup_port(struct ipqess_switch *sw, int port_index)
> +{
> +	struct qca8k_priv *priv = sw->priv;
> +	u32 mask = 0;
> +	int ret, i;
> +	u32 reg;
> +
> +	/* CPU port gets connected to all registered ports of the switch */
> +	if (port_index == IPQESS_SWITCH_CPU_PORT) {
> +		for (i = 1; i < IPQESS_SWITCH_MAX_PORTS; i++) {
> +			if (sw->port_list[i - 1])
> +				mask |= BIT(i);
> +		}
> +		ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port_index),
> +				QCA8K_PORT_LOOKUP_MEMBER, mask);
> +		if (ret)
> +			return ret;
> +		qca8k_read(priv, QCA8K_PORT_LOOKUP_CTRL(IPQESS_SWITCH_CPU_PORT), &reg);
> +
> +		/* Disable CPU ARP Auto-learning by default */
> +		ret = regmap_clear_bits(priv->regmap,
> +					QCA8K_PORT_LOOKUP_CTRL(port_index),
> +					QCA8K_PORT_LOOKUP_LEARN);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Individual user ports get connected to CPU port only */
> +	if (port_index > 0 && sw->port_list[port_index - 1]) {
> +		ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port_index),
> +				QCA8K_PORT_LOOKUP_MEMBER,
> +				BIT(IPQESS_SWITCH_CPU_PORT));
> +		if (ret)
> +			return ret;
> +
> +		/* Enable ARP Auto-learning by default */
> +		ret = regmap_set_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(port_index),
> +				      QCA8K_PORT_LOOKUP_LEARN);
> +		if (ret)
> +			return ret;
> +
> +		/* For port based vlans to work we need to set the
> +		 * default egress vid
> +		 */
> +		ret = qca8k_rmw(priv, QCA8K_EGRESS_VLAN(port_index),
> +				QCA8K_EGREES_VLAN_PORT_MASK(port_index),
> +				QCA8K_EGREES_VLAN_PORT(port_index, QCA8K_PORT_VID_DEF));
> +		if (ret)
> +			return ret;
> +
> +		ret = qca8k_write(priv, QCA8K_REG_PORT_VLAN_CTRL0(port_index),
> +				  QCA8K_PORT_VLAN_CVID(QCA8K_PORT_VID_DEF) |
> +				  QCA8K_PORT_VLAN_SVID(QCA8K_PORT_VID_DEF));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int ipqess_switch_setup(struct ipqess_switch *sw)
> +{
> +	struct qca8k_priv *priv = sw->priv;
> +	int ret, i;
> +	u32 reg;
> +
> +	ipqess_switch_setup_pcs(priv, &priv->pcs_port_0, 0);
> +
> +	/* Enable CPU Port */
> +	ret = regmap_set_bits(priv->regmap, QCA8K_REG_GLOBAL_FW_CTRL0,
> +			      QCA8K_GLOBAL_FW_CTRL0_CPU_PORT_EN);
> +	if (ret) {
> +		dev_err(priv->dev, "failed enabling CPU port");
> +		return ret;
> +	}
> +
> +	/* Enable MIB counters */
> +	ret = qca8k_mib_init(priv);
> +	if (ret)
> +		dev_warn(priv->dev, "MIB init failed");
> +
> +	/* Disable forwarding by default on all ports */
> +	for (i = 0; i < IPQESS_SWITCH_NUM_PORTS; i++) {
> +		ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(i),
> +				QCA8K_PORT_LOOKUP_MEMBER, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Enable QCA header mode on the CPU port */
> +	ret = qca8k_write(priv, QCA8K_REG_PORT_HDR_CTRL(IPQESS_SWITCH_CPU_PORT),
> +			  FIELD_PREP(QCA8K_PORT_HDR_CTRL_TX_MASK, QCA8K_PORT_HDR_CTRL_ALL) |
> +			  FIELD_PREP(QCA8K_PORT_HDR_CTRL_RX_MASK, QCA8K_PORT_HDR_CTRL_ALL));
> +	if (ret) {
> +		dev_err(priv->dev, "failed enabling QCA header mode");
> +		return ret;
> +	}
> +
> +	/* Disable MAC by default on all ports */
> +	for (i = 0; i < IPQESS_SWITCH_NUM_PORTS; i++) {
> +		if (i > 0)

Hmmm, we could just start from 1 here.

> +			qca8k_port_set_status(priv, i, 0);
> +	}
> +
> +	/* Forward all unknown frames to all ports */
> +	ret = qca8k_write(priv, QCA8K_REG_GLOBAL_FW_CTRL1,
> +			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_IGMP_DP_MASK, 0x3f) |
> +			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_BC_DP_MASK, 0x3f) |
> +			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_MC_DP_MASK, 0x3f) |
> +			  FIELD_PREP(QCA8K_GLOBAL_FW_CTRL1_UC_DP_MASK, 0x3f));
> +	if (ret) {
> +		pr_err("Error while disabling MAC and forwarding unknown frames %d\n",
> +		       ret);
> +		return ret;
> +	}
> +
> +	/* Setup connection between CPU port & user ports */
> +	for (i = 0; i < IPQESS_SWITCH_NUM_PORTS; i++) {

This happens a lot, ipqess_for_each_port would be nice.

> +		ret = ipqess_switch_setup_port(sw, i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Setup our port MTUs to match power on defaults */
> +	ret = qca8k_write(priv, QCA8K_MAX_FRAME_SIZE, ETH_FRAME_LEN + ETH_FCS_LEN);
> +	if (ret)
> +		dev_warn(priv->dev, "failed setting MTU settings");
> +
> +	/* Flush the FDB table */
> +	qca8k_fdb_flush(priv);
> +
> +	if (ret < 0)
> +		goto devlink_free;
> +
> +	/* set Port0 status */
> +	reg  = QCA8K_PORT_STATUS_LINK_AUTO;
> +	reg |= QCA8K_PORT_STATUS_DUPLEX;
> +	reg |= QCA8K_PORT_STATUS_SPEED_1000;
> +	reg |= QCA8K_PORT_STATUS_RXFLOW;
> +	reg |= QCA8K_PORT_STATUS_TXFLOW;
> +	reg |= QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
> +	qca8k_write(priv, QCA8K_REG_PORT_STATUS(0), reg);
> +	sw->port0_enabled = true;
> +
> +	return 0;
> +
> +devlink_free:

Why is it called devlink_free, I don't see any connection to devlink.

> +	pr_err("qca_switch_setup error: %d\n", ret);
> +	return ret;
> +}
> +EXPORT_SYMBOL(ipqess_switch_setup);
> +
> +/* probe */
> +
> +static void ipqess_switch_psgmii_rst(struct ipqess_switch *sw)
> +{
> +	reset_control_assert(sw->psgmii_rst);
> +
> +	mdelay(10);
> +
> +	reset_control_deassert(sw->psgmii_rst);
> +
> +	mdelay(10);
> +}
> +
> +static int ipqess_switch_probe(struct platform_device *pdev)
> +{
> +	struct device_node *ports, *port_np;
> +	struct device_node *np, *mdio_np;
> +	struct device *dev = &pdev->dev;
> +	struct ipqess_port *port = NULL;
> +	void __iomem *base, *psgmii;
> +	struct ipqess_switch *sw;
> +	struct qca8k_priv *priv;
> +	int ret;
> +	int i;
> +
> +	sw = devm_kzalloc(dev, sizeof(struct ipqess_switch), GFP_KERNEL);
> +	if (!sw)
> +		return -ENOMEM;
> +
> +	priv = devm_kzalloc(dev, sizeof(struct qca8k_priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	sw->priv = priv;
> +	sw->port0_enabled = false;
> +	priv->dev = dev;
> +	priv->info = &ipqess;
> +	priv->ds = NULL;
> +
> +	np = dev->of_node;
> +	ports = of_get_child_by_name(np, "ports");
> +	if (!ports) {
> +		dev_err(dev, "no 'ports' attribute found\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Start by setting up the register mapping */
> +	base = devm_platform_ioremap_resource_byname(pdev, "base");
> +	if (IS_ERR(base)) {
> +		dev_err(dev, "platform ioremap fail %li\n", PTR_ERR(base));
> +		return PTR_ERR(base);
> +	}
> +
> +	priv->regmap = devm_regmap_init_mmio(dev, base,
> +					     &qca8k_ipqess_regmap_config);
> +	if (IS_ERR(priv->regmap)) {
> +		ret = PTR_ERR(priv->regmap);
> +		dev_err(dev, "base regmap initialization failed, %d\n", ret);
> +		return ret;
> +	}
> +
> +	psgmii = devm_platform_ioremap_resource_byname(pdev, "psgmii_phy");
> +	if (IS_ERR(psgmii)) {
> +		ret = PTR_ERR(psgmii);
> +		dev_err(dev, "platform ioremap psgmii fail %d\n", ret);
> +		return ret;
> +	}
> +
> +	priv->psgmii = devm_regmap_init_mmio(dev, psgmii,
> +					     &qca8k_ipqess_psgmii_phy_regmap_config);
> +	if (IS_ERR(priv->psgmii)) {
> +		ret = PTR_ERR(priv->psgmii);
> +		dev_err(dev, "PSGMII regmap initialization failed, %d\n", ret);
> +		return ret;
> +	}
> +
> +	mdio_np = of_parse_phandle(np, "mdio", 0);
> +	if (!mdio_np) {
> +		dev_err(dev, "unable to get MDIO bus phandle\n");
> +		of_node_put(mdio_np);
> +		return -EINVAL;
> +	}
> +
> +	priv->bus = of_mdio_find_bus(mdio_np);
> +	of_node_put(mdio_np);
> +	if (!priv->bus) {
> +		dev_err(dev, "unable to find MDIO bus\n");
> +		return -EPROBE_DEFER;
> +	}
> +
> +	/* If we don't reset the PSGMII here the switch id check will fail */
> +	sw->psgmii_rst = devm_reset_control_get(&pdev->dev, "psgmii");
> +	if (IS_ERR(sw->psgmii_rst)) {
> +		ret = PTR_ERR(sw->psgmii_rst);
> +		dev_err(dev, "Unable to get PSGMII reset line: err %d\n", ret);
> +		return ret;
> +	}
> +
> +	ipqess_switch_psgmii_rst(sw);
> +
> +	/* Check the detected switch id */
> +	ret = qca8k_read_switch_id(sw->priv);
> +	if (ret) {
> +		dev_err(dev, "Failed to read switch id! error %d\n", ret);
> +		return ret;
> +	}
> +
> +	priv->ds = NULL;
> +
> +	mutex_init(&sw->addr_lists_lock);
> +	INIT_LIST_HEAD(&sw->fdbs);
> +	INIT_LIST_HEAD(&sw->mdbs);
> +
> +	mutex_init(&priv->reg_mutex);
> +	platform_set_drvdata(pdev, sw);
> +
> +	ret = ipqess_switch_devlink_alloc(sw);
> +	if (ret)
> +		goto out_devlink;
> +
> +	devlink_register(sw->devlink);
> +
> +	/* Register switch front-facing ports */
> +	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++)
> +		sw->port_list[i] = NULL;
> +
> +	for_each_available_child_of_node(ports, port_np) {
> +		ret = ipqess_port_register(sw, port_np);
> +		if (ret) {
> +			pr_err("Failed to register ipqess port! error %d\n", ret);
> +			goto out_ports;
> +		}
> +	}
> +	if (!sw->napi_leader) {
> +		pr_err("No switch port registered as napi leader!\n");
> +		ret = -EINVAL;
> +		goto out_ports;
> +	}
> +
> +	ret = ipqess_edma_init(pdev, np);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize EDMA controller! error %d\n", ret);
> +		goto out_ports;
> +	}
> +
> +	ipqess_switch_setup(sw);
> +
> +	return 0;
> +
> +out_ports:
> +	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
> +		port = sw->port_list[i];
> +		if (port)
> +			ipqess_port_unregister(port);

You can add something like ipqess_destroy_ports,
could be used both here and in ipqess_switch_remove

> +	}
> +out_devlink:
> +	devlink_free(sw->devlink);
> +	pr_err("%s failed with error %d\n", __func__, ret);
> +	return ret;
> +}
> +
> +static int
> +ipqess_switch_remove(struct platform_device *pdev)
> +{
> +	struct ipqess_switch *sw = platform_get_drvdata(pdev);
> +	struct qca8k_priv *priv = sw->priv;
> +	struct ipqess_port *port = NULL;
> +	int i;
> +
> +	if (!sw)
> +		return 0;
> +
> +	/* Release EDMA driver */
> +	ipqess_edma_uninit(sw->edma);
> +
> +	/* Disable all user ports */
> +	for (i = 1; i < QCA8K_NUM_PORTS; i++) {
> +		qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(i),
> +			  QCA8K_PORT_LOOKUP_STATE_MASK,
> +			  QCA8K_PORT_LOOKUP_STATE_DISABLED);
> +		qca8k_port_set_status(priv, i, 0);
> +		priv->port_enabled_map &= ~BIT(i);
> +	}
> +
> +	/* Unregister user ports */
> +	for (i = 0; i < IPQESS_SWITCH_MAX_PORTS; i++) {
> +		port = sw->port_list[i];
> +		if (port)
> +			ipqess_port_unregister(port);
> +	}
> +
> +	devlink_unregister(sw->devlink);
> +	devlink_free(sw->devlink);
> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id qca8k_ipqess_of_match[] = {
> +	{ .compatible = "qcom,ipq4019-ess", },
> +	{ /* sentinel */ },
> +};
> +
> +static struct platform_driver qca8k_ipqess_driver = {
> +	.probe = ipqess_switch_probe,
> +	.remove = ipqess_switch_remove,
> +	.driver = {
> +		.name = "ipqess",
> +		.of_match_table = qca8k_ipqess_of_match,
> +	},
> +};
> +
> +module_platform_driver(qca8k_ipqess_driver);
> +
> +MODULE_AUTHOR("Romain Gantois <romain.gantois@bootlin.org>");
> +MODULE_AUTHOR("Mathieu Olivari, John Crispin <john@phrozen.org>");
> +MODULE_AUTHOR("Gabor Juhos <j4g8y7@gmail.com>, Robert Marko <robert.marko@sartura.hr>");
> +MODULE_DESCRIPTION("Qualcomm IPQ4019 Ethernet Switch Subsystem driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.h b/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.h
> new file mode 100644
> index 000000000000..221c628d1728
> --- /dev/null
> +++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR ISC */
> +
> +#ifndef IPQESS_SWITCH_H
> +#define IPQESS_SWITCH_H
> +
> +#include <linux/dsa/qca8k.h>
> +
> +#define IPQESS_SWITCH_MAX_PORTS       5
> +#define IPQESS_SWITCH_AGEING_TIME_MIN 7000
> +#define IPQESS_SWITCH_AGEING_TIME_MAX 458745000
> +#define IPQESS_SWITCH_CPU_PORT        0
> +#define IPQESS_SWITCH_NUM_PORTS       5
> +#define IPQESS_SWITCH_ID              0x14
> +
> +struct ipqess_switch {
> +	struct net_device *napi_leader;
> +	struct qca8k_priv *priv;
> +	struct ipqess_edma *edma;
> +	struct ipqess_port *port_list[IPQESS_SWITCH_MAX_PORTS];
> +	struct devlink *devlink;
> +	struct reset_control *psgmii_rst;
> +	bool port0_enabled;
> +
> +	/* List of MAC addresses that must be forwarded on the cpu port */
> +	struct mutex		addr_lists_lock;
> +	struct list_head	fdbs;
> +	struct list_head	mdbs;
> +};
> +
> +unsigned int ipqess_switch_fastest_ageing_time(struct ipqess_switch *sw,
> +					       unsigned int ageing_time);
> +int ipqess_set_ageing_time(struct ipqess_switch *sw, unsigned int msecs);
> +
> +int ipqess_switch_setup(struct ipqess_switch *sw);
> +
> +#endif
> diff --git a/include/linux/dsa/qca8k.h b/include/linux/dsa/qca8k.h
> index 3c75c3704fa0..cafb727f4e8b 100644
> --- a/include/linux/dsa/qca8k.h
> +++ b/include/linux/dsa/qca8k.h
> @@ -266,6 +266,7 @@
>  #define   QCA8K_PORT_LOOKUP_STATE_LEARNING		QCA8K_PORT_LOOKUP_STATE(0x3)
>  #define   QCA8K_PORT_LOOKUP_STATE_FORWARD		QCA8K_PORT_LOOKUP_STATE(0x4)
>  #define   QCA8K_PORT_LOOKUP_LEARN			BIT(20)
> +#define   QCA8K_PORT_LOOKUP_LOOPBACK_EN			BIT(21)
>  #define   QCA8K_PORT_LOOKUP_ING_MIRROR_EN		BIT(25)
>  
>  #define QCA8K_REG_GOL_TRUNK_CTRL0			0x700
> @@ -342,6 +343,31 @@
>  #define MII_ATH_MMD_ADDR				0x0d
>  #define MII_ATH_MMD_DATA				0x0e
>  
> +/* IPQ4019 PSGMII PHY registers */
> +#define QCA8K_IPQ4019_REG_RGMII_CTRL			0x004
> +#define   QCA8K_IPQ4019_RGMII_CTRL_RGMII_RXC		GENMASK(1, 0)
> +#define   QCA8K_IPQ4019_RGMII_CTRL_RGMII_TXC		GENMASK(9, 8)
> +/* Some kind of CLK selection
> + * 0: gcc_ess_dly2ns
> + * 1: gcc_ess_clk
> + */
> +#define   QCA8K_IPQ4019_RGMII_CTRL_CLK				BIT(10)
> +#define   QCA8K_IPQ4019_RGMII_CTRL_DELAY_RMII0			GENMASK(17, 16)
> +#define   QCA8K_IPQ4019_RGMII_CTRL_INVERT_RMII0_REF_CLK		BIT(18)
> +#define   QCA8K_IPQ4019_RGMII_CTRL_DELAY_RMII1			GENMASK(20, 19)
> +#define   QCA8K_IPQ4019_RGMII_CTRL_INVERT_RMII1_REF_CLK		BIT(21)
> +#define   QCA8K_IPQ4019_RGMII_CTRL_INVERT_RMII0_MASTER_EN	BIT(24)
> +#define   QCA8K_IPQ4019_RGMII_CTRL_INVERT_RMII1_MASTER_EN	BIT(25)
> +
> +#define PSGMIIPHY_MODE_CONTROL				0x1b4
> +#define   PSGMIIPHY_MODE_ATHR_CSCO_MODE_25M		BIT(0)
> +#define PSGMIIPHY_TX_CONTROL				0x288
> +#define   PSGMIIPHY_TX_CONTROL_MAGIC_VALUE		0x8380
> +#define PSGMIIPHY_VCO_CALIBRATION_CONTROL_REGISTER_1	0x9c
> +#define   PSGMIIPHY_REG_PLL_VCO_CALIB_RESTART		BIT(14)
> +#define PSGMIIPHY_VCO_CALIBRATION_CONTROL_REGISTER_2	0xa0
> +#define   PSGMIIPHY_REG_PLL_VCO_CALIB_READY		BIT(0)
> +
>  enum {
>  	QCA8K_PORT_SPEED_10M = 0,
>  	QCA8K_PORT_SPEED_100M = 1,
> @@ -467,6 +493,9 @@ struct qca8k_priv {
>  	struct qca8k_pcs pcs_port_6;
>  	const struct qca8k_match_data *info;
>  	struct qca8k_led ports_led[QCA8K_LED_COUNT];
> +
> +	/* IPQ4019 specific */
> +	struct regmap *psgmii;
>  };
>  
>  struct qca8k_mib_desc {
> @@ -507,6 +536,8 @@ int qca8k_read_switch_id(struct qca8k_priv *priv);
>  int qca8k_read(struct qca8k_priv *priv, u32 reg, u32 *val);
>  int qca8k_write(struct qca8k_priv *priv, u32 reg, u32 val);
>  int qca8k_rmw(struct qca8k_priv *priv, u32 reg, u32 mask, u32 write_val);
> +int qca8k_set_bits(struct qca8k_priv *priv, u32 reg, u32 bits);
> +int qca8k_clear_bits(struct qca8k_priv *priv, u32 reg, u32 bits);
>  
>  /* Common ops function */
>  void qca8k_fdb_flush(struct qca8k_priv *priv);
> @@ -560,6 +591,16 @@ int qca8k_port_fdb_del(struct dsa_switch *ds, int port,
>  		       struct dsa_db db);
>  int qca8k_port_fdb_dump(struct dsa_switch *ds, int port,
>  			dsa_fdb_dump_cb_t *cb, void *data);
> +int qca8k_fdb_del(struct qca8k_priv *priv, const u8 *mac,
> +		  u16 port_mask, u16 vid);
> +int qca8k_fdb_next(struct qca8k_priv *priv, struct qca8k_fdb *fdb,
> +		   int port);
> +int qca8k_fdb_access(struct qca8k_priv *priv, enum qca8k_fdb_cmd cmd,
> +		     int port);
> +int qca8k_fdb_search_and_insert(struct qca8k_priv *priv, u8 port_mask,
> +				const u8 *mac, u16 vid, u8 aging);
> +int qca8k_fdb_search_and_del(struct qca8k_priv *priv, u8 port_mask,
> +			     const u8 *mac, u16 vid);
>  
>  /* Common MDB function */
>  int qca8k_port_mdb_add(struct dsa_switch *ds, int port,
> @@ -577,8 +618,12 @@ void qca8k_port_mirror_del(struct dsa_switch *ds, int port,
>  			   struct dsa_mall_mirror_tc_entry *mirror);
>  
>  /* Common port VLAN function */
> -int qca8k_port_vlan_filtering(struct dsa_switch *ds, int port, bool vlan_filtering,
> +int qca8k_port_vlan_filtering(struct dsa_switch *ds, int port,
> +			      bool vlan_filtering,
>  			      struct netlink_ext_ack *extack);
> +int qca8k_vlan_add(struct qca8k_priv *priv, u8 port, u16 vid,
> +		   bool untagged);
> +int qca8k_vlan_del(struct qca8k_priv *priv, u8 port, u16 vid);
>  int qca8k_port_vlan_add(struct dsa_switch *ds, int port,
>  			const struct switchdev_obj_port_vlan *vlan,
>  			struct netlink_ext_ack *extack);
