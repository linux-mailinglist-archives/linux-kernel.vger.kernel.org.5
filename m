Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8B07D4F18
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjJXLo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjJXLo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:44:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9859D79;
        Tue, 24 Oct 2023 04:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698147861; x=1729683861;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b8Oeo/UIe/n5758IozA1EacNa7RgrT9VPVyP/mwENns=;
  b=Z+/QqO/pDDmtqqOexRmw/UjNxuYwOUa5ls6f5Pm9n/bD5eHpI2+nsKEL
   MOk9oXO8JupmwoLlhHTDpftNq/PVOHNnzoF0Ec7UmNlPkwkBK2mdOAgEe
   XuMEN4ECcldXO6/h50CNsZI2JOBb//kE6ko3LRdjpFI2Quw8gTswN4KKx
   jD2Nl6HLWk1vCMOsvp8yII3xNj0jAAJOMQSl9Mt5L0qH2MLIij4qe2KIh
   AoB7iWel9W2ks4TcbMzYvzOEcGhDCPW3symj5iWOvnxOZq8eMjySUSsp1
   zf57E3+9eOR/HnR0pRSppygrfZuAlgcgAt2n4oF/1jDujkbxQoKhx5fq4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="366382978"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="366382978"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 04:44:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="932014400"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="932014400"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 04:44:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 04:44:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 04:44:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 04:44:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpoSkgQomnrMgGkoJ9htz5H+IpHPJpsx9zDwv+HE82KaqmBlC8bH1794mZ+qRlokyuMA8SFXPwY0BOO11Kh9MV/ETHWyE40gHEto5xSn4B8kMc8waD2tysTaK9dtQotKqYmvxa6KkibmZt38d1sXzel6bsImk3erndD1NxlaPyi1WKngbduSR+1xlUlsd3d2fapZjxtbB67h/2TZ5Abm6lQ62EUAmG7lWWdky/90KgSOCaxtifnA2R57fEg9PG8HOkfd6vQ1GsDWE7yR03pnja/wD1OwXfnvk4iR/7RkRuuBps9iCJLt+tT9UxZtEY/TWh4vTncfhgRyQ0IOMiYPYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NJ/96L6oSIsGkBIYaRYp6Yf0BLfNLDnBREDddj++Tg=;
 b=C3f7BRYcRXYhkOgxff/yj+tH176pJeWGbHVS6T1WZ7MKgQRSG4q6rgPnnmxAJHcS6/sV4HSkS1XzPOyGKL/RpC78zzWjNChkoTUgxORnyAs+PwpLfKPfIQusoyE6GApWdR8Cq49pWPXZf7ZJdSxAi7KwQJ89L+4EeI6O2ykQoHxxysZwxsezbpMmmoSRxSbmK6uifSpfNPNmt+UQWZrcWXeuNVnGkswXL5P9+HA1EZAYoacaPo6iSICMeKIL3Pkir0k+2EpUwFxl8loU+qnSYtSHe/zfker7VF0BXX55j3KAvZ2fkI0ztqcnnoRmhUhWUTw7KGK+n9DRTWHejmu00A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Tue, 24 Oct
 2023 11:44:10 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 11:44:10 +0000
Message-ID: <a0c09443-af32-4440-8439-ad187c21fd13@intel.com>
Date:   Tue, 24 Oct 2023 13:44:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] net: ipqess: introduce the Qualcomm IPQESS
 driver
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
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20231023155013.512999-1-romain.gantois@bootlin.com>
 <20231023155013.512999-4-romain.gantois@bootlin.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231023155013.512999-4-romain.gantois@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::28) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH0PR11MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 658a69b8-e933-4b0d-71f4-08dbd4868956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zbjfnK7rGEwd5t7dt7CmDWt8ErzSjHQTOdY5LnKUpZrhqWSv4dscSQM6aTDsBs9DWC7zpnK3f06oXj2UrZn1DjE4qdou24VEnaO+TqwgG8Uzlg3rIzF2TjXACPrNSXVn8sIftwhgijcLFknIi+oZnvO51850yAuy0U79sClWXV63aHrDcYCAWdcfBxGoi8CZkCqRcfzrNBR3oVO8KpLrp/QFk9zx2uxBPS7S6qBzCSK0oF4sTaQrKHySIXeOF7VbEyfEzPfoEIoK/RKdIMjnC9cRY6xRw5Xrp/hyYj1fM/ITeRLE1fUAQviRrAveLjTDjEYCloymlOYbOf66ZRzhp4ZOx8FPu5oT1RC65IAiWCKuHgbR1NN5o4IzciNhDCfb1o4nqpNGNBUcTtlUw8NrBGeHYFn5tsVeHLOTVsa4l7PPmkyWM50yW5dZfACJMLIS2XQHR4XjM6jcWa/Y5d7d+lH15Ws7Y9an5MBeisXMCLXCE6oKexOwIXOM9cYgV//dAucdlubs2dKm23G1bcLl9KbcmVxbUkU7HcPulN+IRnaXSHWaOWRcQt1OQG4rf+g12fegyNRTI6J/74LkF96zDGJwWMuBXhVw5tj/3N2jbLiRDrkwd2T+nntX5qXfXuklB//6phaKWQWIlrMxOYmBUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(30864003)(2906002)(38100700002)(66476007)(54906003)(66946007)(316002)(66556008)(82960400001)(2616005)(110136005)(478600001)(6506007)(6486002)(53546011)(6666004)(83380400001)(6512007)(44832011)(86362001)(5660300002)(7416002)(41300700001)(36756003)(31696002)(4326008)(8676002)(8936002)(26005)(31686004)(45980500001)(43740500002)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUJzVXlOK1EzRTRIZEJ0Szg4Ly9iU0QyS0Zhek5SM2ZjQ2lCd0lxWUgwNzll?=
 =?utf-8?B?TTh0eWdLd2FTSXVSRU1pRForWHJYNmFjQkdxdHZlaUhlOWE2YWg1dEVBbUlo?=
 =?utf-8?B?c005QXdtSFVUV1NSNys1dXBBTTEwZTQxY1d0UzhSOHdrT011TllPUTgxeU5y?=
 =?utf-8?B?WCt1WkU1SWUzZ2FMMUFYQzBOcTZaaGZNc2hBWThOMjNmZ1FnTitUbE5HRE1u?=
 =?utf-8?B?Y0FnZnpzTnRGK1Bod3RCWC9CeVB5QkVvY09Cay9uV1pHdWkrazQ3ZG1UTnJX?=
 =?utf-8?B?V3hBMWd0VzcrT2o5bmVkTy8yai91aklYWEI3MXkwaGxWZ3NvbEI4S3F1TFZk?=
 =?utf-8?B?YWpOVEhnYXY0TTNNSHhXODdSZ0FIeVZyK1VmWkw4clU1cFRUbWtkSEY1UzlV?=
 =?utf-8?B?bjdaU1BWbmhmczdBVnlvc0pzVmJBYkY3MktXSWY3WVhqNnBWc1Vrd0xONFh4?=
 =?utf-8?B?Z0xzNDRTblUrREtCWUFTVHdDRWw2bzFkbnlIM2VTelNSWTNXeTh5NEI2ZUtl?=
 =?utf-8?B?RU5RbWRsY0JzSXdZekh0S2Y1RVFMR3QwdEpBa2Z1OFdDNDdhaXRHZW5qdEw2?=
 =?utf-8?B?dlF1QmI0SksyaHRDdDc3RGNnM09VK09oQUpCeVVxbXFxdmp4Q0tkdFdOZW96?=
 =?utf-8?B?VCtsUzYreVdNd2NNQ0loRFE4amlVd3d1c1A1ZTE4aHA2cENaM2daTHB1UUt2?=
 =?utf-8?B?SDZpSjd0OVVuNnRYZmx0UlhoUm1VOEMzNm4wZzRzbXBQeitoZE5QQVFlbUdG?=
 =?utf-8?B?ZklUVzd2cVR2Y1JsY1pIRFE4Z0YyVEVhNnE2eXZvNDN4OUNBQitCV2JvN2lW?=
 =?utf-8?B?T0pJSWVoZ0QvR1RBSHJ5U3B4ekNjYWJrb2dpQzJtK1ZQdXFDVmRxdGxxK1Ry?=
 =?utf-8?B?MFhiVkRwdEF2c3ZZZDY5VHV4YzR5bnQ4a0VGMU9ZSlRmTUpwa1dGdkVNbWNy?=
 =?utf-8?B?elZzYlRCdzhnMUVKK242Slg3VEdJY29kVjV4U2VXR2FPb01iYVQ2d0M5ZmNp?=
 =?utf-8?B?dWc5S2pIazIyV1ZkSmUrREh5SnF6WmNqNmtEY3FyZnM1aTd0NzZxa05iV0gx?=
 =?utf-8?B?TWhvSGdDV2FVckxUaDV6ME5PM1NYUGxueXNTKytkWXhSL05yZGRqVFVyazcr?=
 =?utf-8?B?U1A0ZFRwODlpRTI5Y1hWRHBMOUM0dVMwQnNiN2Q2TVpoMkZVY0JrM2NYTHU1?=
 =?utf-8?B?NG5hSHMva1ZqMHZDWEZFSnpBNW01RVhVMkMwNDM4Sm9zL2tkbnpjakVkK3dZ?=
 =?utf-8?B?S1BrVzlkeEozRUZycmh6amNOcHo3RWE2WVdlbkYvUFo1Sm0wcjZXcmVFcDla?=
 =?utf-8?B?ckhpQWYvcW83WEFoOGJUWHFHRjczTWRwemNjNHZ1ejVSeU5GM21pREt1T09u?=
 =?utf-8?B?ZE1vb1NuZDkrSmVQNWdtd0F4RzRaNGRFT3hnNmo0Tm0zMHdTMXVHcHNDMFFj?=
 =?utf-8?B?SHFOVmZNakZSS0JLT3hlN2Y2dmp3R2R6dDdqZVJndVBBbWp5b3RiT3RCcDhN?=
 =?utf-8?B?cUIzV2dBWUtmUnZsRExQZTFRREZOOXpaMnJQU3c2aWswSUpwRDlrWkJQdFls?=
 =?utf-8?B?UjNJSW52cjg0VWRldzQrdFFET2taNG5EQ2F0d05nTDN3RDJNV1pZYzNkSEhY?=
 =?utf-8?B?Rmp0S3EwN2xZSElzRUdaTjhicUxLRG9DTkM2YjB5MEJkcGNPWjVEUUR4QkRq?=
 =?utf-8?B?ZkF4Q3JBMWsrZFlkVGZ2b2hiSHhLKytRbXduK3cwejRlOWI2Z05yNUFnR21J?=
 =?utf-8?B?Qis0Y2dPMDU5YjdFRHFaMFdDdW8vdHc5UTJHT1lnNkMwZnFTY1hOK0dTMmJY?=
 =?utf-8?B?ck5HUkxhTEh1a1ZKRW9xME9ReUVES3dXbU1ORnJkL0JDcUZ6MFZ1c2dmdmw0?=
 =?utf-8?B?TWxJYnN6OGNHekpsM0hxL3N2YnVwWUVPVUtRNmxVOGtsWmNJSE5BeUpJYi9j?=
 =?utf-8?B?aS9scUdvcGhUdUNSaC9UVFJReDd4MFltb3dVT3ZFdFd5b3YxczNGd2lzVi9i?=
 =?utf-8?B?QUQ4Q3ZkNGlsc3NhS0RXY2h5Tk1wa2xmcHV1Qm1abG9oSnRCdG11LzZSb2NT?=
 =?utf-8?B?Qm9ndjd1b0R2cVpHNklIQWsvMDJTSjdiVm8zRy8wQmMzVG5TKy9CWXZpMVFW?=
 =?utf-8?B?UjA5cURSWS9neUp4Ry9ZbVAzK3ZEa1VXRmk5aVpTNjcyaS9PSW04REhLWTk0?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 658a69b8-e933-4b0d-71f4-08dbd4868956
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 11:44:10.0972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKddRJfaOfrWNxguMYl87B/70TwMOA1Uvytk1e6gIdGIug9w03ETv7f8Q5tE8I9eyyMWxTKkK+nsZIP+N29FmWqeErFOaNBUoE9KDbwVNKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7585
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.10.2023 17:50, Romain Gantois wrote:
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
> ---

Hi Romain,
Thanks for the patch.
Whole driver introduced in one commit, hard to review :\
I did as musch as I can but it would be easier if you split it into several patches.

Reagrds,
Wojtek

>  MAINTAINERS                                   |    7 +
>  drivers/net/ethernet/qualcomm/Kconfig         |   14 +
>  drivers/net/ethernet/qualcomm/Makefile        |    2 +
>  drivers/net/ethernet/qualcomm/ipqess/Makefile |    8 +
>  .../ethernet/qualcomm/ipqess/ipqess_edma.c    | 1162 ++++++++++
>  .../ethernet/qualcomm/ipqess/ipqess_edma.h    |  484 ++++
>  .../qualcomm/ipqess/ipqess_notifiers.c        |  306 +++
>  .../qualcomm/ipqess/ipqess_notifiers.h        |   29 +
>  .../ethernet/qualcomm/ipqess/ipqess_port.c    | 2016 +++++++++++++++++
>  .../ethernet/qualcomm/ipqess/ipqess_port.h    |   95 +
>  .../ethernet/qualcomm/ipqess/ipqess_switch.c  |  559 +++++
>  .../ethernet/qualcomm/ipqess/ipqess_switch.h  |   40 +
>  12 files changed, 4722 insertions(+)
>  create mode 100644 drivers/net/ethernet/qualcomm/ipqess/Makefile
>  create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.c
>  create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.h
>  create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.c
>  create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.h
>  create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
>  create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
>  create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c
>  create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 36815d2feb33..df285ef5d36e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17782,6 +17782,13 @@ F:	Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
>  F:	drivers/mailbox/qcom-ipcc.c
>  F:	include/dt-bindings/mailbox/qcom-ipcc.h
>  
> +QUALCOMM IPQ4019 ESS DRIVER
> +M:	Romain Gantois <romain.gantois@bootlin.com>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/net/qcom,ipq4019-ess.yaml
> +F:	drivers/net/ethernet/qualcomm/ipqess/
> +
>  QUALCOMM IPQ4019 USB PHY DRIVER
>  M:	Robert Marko <robert.marko@sartura.hr>
>  M:	Luka Perkov <luka.perkov@sartura.hr>
> diff --git a/drivers/net/ethernet/qualcomm/Kconfig b/drivers/net/ethernet/qualcomm/Kconfig
> index 9210ff360fdc..aaae06f93373 100644
> --- a/drivers/net/ethernet/qualcomm/Kconfig
> +++ b/drivers/net/ethernet/qualcomm/Kconfig
> @@ -61,6 +61,20 @@ config QCOM_EMAC
>  	  low power, Receive-Side Scaling (RSS), and IEEE 1588-2008
>  	  Precision Clock Synchronization Protocol.
>  
> +config QCOM_IPQ4019_ESS
> +	tristate "Qualcomm Atheros IPQ4019 Ethernet Switch Subsystem support"
> +	depends on (OF && ARCH_QCOM) || COMPILE_TEST
> +	select PHYLINK
> +	select NET_DSA
> +	select NET_SWITCHDEV
> +	select NET_DSA_QCA8K_LIB
> +	help
> +	  This driver supports the Qualcomm Atheros IPQ40xx built-in
> +	  Ethernet Switch Subsystem.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ipqess.
> +
>  source "drivers/net/ethernet/qualcomm/rmnet/Kconfig"
>  
>  endif # NET_VENDOR_QUALCOMM
> diff --git a/drivers/net/ethernet/qualcomm/Makefile b/drivers/net/ethernet/qualcomm/Makefile
> index 9250976dd884..63c62704a62d 100644
> --- a/drivers/net/ethernet/qualcomm/Makefile
> +++ b/drivers/net/ethernet/qualcomm/Makefile
> @@ -12,3 +12,5 @@ qcauart-objs := qca_uart.o
>  obj-y += emac/
>  
>  obj-$(CONFIG_RMNET) += rmnet/
> +
> +obj-$(CONFIG_QCOM_IPQ4019_ESS) += ipqess/
> diff --git a/drivers/net/ethernet/qualcomm/ipqess/Makefile b/drivers/net/ethernet/qualcomm/ipqess/Makefile
> new file mode 100644
> index 000000000000..51d7163ef0fc
> --- /dev/null
> +++ b/drivers/net/ethernet/qualcomm/ipqess/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for the IPQ ESS driver
> +#
> +
> +obj-$(CONFIG_QCOM_IPQ4019_ESS) += ipqess.o
> +
> +ipqess-objs := ipqess_port.o ipqess_switch.o ipqess_notifiers.o ipqess_edma.o

<...>

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
> +	struct net_device *br = ipqess_port_bridge_dev_get(port);
> +	struct switchdev_obj_port_vlan *vlan;

RCT

> +
> +	/* Do nothing is this is a software bridge */
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
> +	return ipqess_port_do_vlan_add(port->sw->priv, 0, vlan, extack);
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
> +		err = ipqess_port_vlan_check_for_8021q_uppers(netdev, vlan);
> +		rcu_read_unlock();
> +		if (err) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "Port already has a VLAN upper with this VID");
> +			return err;
> +		}
> +	}
> +
> +	err = ipqess_port_do_vlan_add(port->sw->priv, port->index, vlan, extack);

nit: blank line

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
> +	struct ipqess_switch *sw = port->sw;
> +	struct ipqess_mac_addr *a = NULL;
> +	struct ipqess_mac_addr *other_a;
> +	int err = 0;
> +
> +	mutex_lock(&sw->addr_lists_lock);
> +
> +	list_for_each_entry(other_a, &sw->fdbs, list)
> +		if (ether_addr_equal(other_a->addr, addr) && other_a->vid == vid)
> +			a = other_a;
> +
> +	if (!a) {
> +		err = -ENOENT;
> +		goto out;
> +	}
> +
> +	if (!refcount_dec_and_test(&a->refcount))
> +		goto out;
> +
> +	err = qca8k_fdb_del(sw->priv, addr, BIT(IPQESS_SWITCH_CPU_PORT), vid);
> +	if (err) {
> +		refcount_set(&a->refcount, 1);
> +		goto out;
> +	}
> +
> +	list_del(&a->list);
> +	kfree(a);
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

more meaningful name than "a" would be nice

> +	int err = 0;

RCT

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
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "This VLAN is already configured by the bridge");
> +		return notifier_from_errno(-EBUSY);
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +/* phylink ops */
> +
> +static int
> +ipqess_psgmii_configure(struct qca8k_priv *priv)
> +{
> +	int ret;
> +
> +	if (!atomic_fetch_inc(&priv->psgmii_calibrated)) {
> +		dev_warn(priv->dev, "Unable to calibrate PSGMII, link will be unstable!\n");
> +
> +		ret = regmap_clear_bits(priv->psgmii, PSGMIIPHY_MODE_CONTROL,
> +					PSGMIIPHY_MODE_ATHR_CSCO_MODE_25M);
> +		ret = regmap_write(priv->psgmii, PSGMIIPHY_TX_CONTROL,
> +				   PSGMIIPHY_TX_CONTROL_MAGIC_VALUE);
> +
> +		return ret;
> +	}
> +
> +	return 0;
> +}
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
> +		if (state->interface == PHY_INTERFACE_MODE_PSGMII)
> +			if (ipqess_psgmii_configure(priv))
> +				dev_err(priv->dev,
> +					"PSGMII configuration failed!\n");
> +		return;
> +	case 4:
> +	case 5:
> +		if (phy_interface_mode_is_rgmii(state->interface))
> +			regmap_set_bits(priv->regmap,
> +					QCA8K_IPQ4019_REG_RGMII_CTRL,
> +					QCA8K_IPQ4019_RGMII_CTRL_CLK);
> +
> +		if (state->interface == PHY_INTERFACE_MODE_PSGMII)
> +			if (ipqess_psgmii_configure(priv))
> +				dev_err(priv->dev,
> +					"PSGMII configuration failed!\n");
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

nit: blank line

> +	if (ret) {
> +		netdev_err(netdev, "failed to connect to PHY: %pe\n",
> +			   ERR_PTR(ret));
> +		phylink_destroy(port->pl);
> +		port->pl = NULL;
> +	}
> +
> +	dev_info(&netdev->dev, "enabled port's phy: %s",
> +		 phydev_name(netdev->phydev));

nit: blank line

> +	return ret;
> +}
> +
> +/* ethtool ops */
> +
> +static void ipqess_port_get_drvinfo(struct net_device *dev,
> +				    struct ethtool_drvinfo *drvinfo)
> +{
> +	strscpy(drvinfo->driver, "qca8k-ipqess", sizeof(drvinfo->driver));
> +	strscpy(drvinfo->fw_version, "N/A", sizeof(drvinfo->fw_version));
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
> +static int ipqess_port_get_eeprom_len(struct net_device *dev)
> +{
> +	return 0;
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
> +			continue;
> +
> +		if (mib->size == 2) {
> +			ret = qca8k_read(priv, reg + 4, &hi);
> +			if (ret < 0)
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
> +	u32 reg;
> +
> +	/* Port's PHY and MAC both need to be EEE capable */
> +	if (!dev->phydev || !port->pl)
> +		return -ENODEV;
> +
> +	mutex_lock(&priv->reg_mutex);
> +	ret = qca8k_read(priv, QCA8K_REG_EEE_CTRL, &reg);
> +	if (ret < 0) {
> +		mutex_unlock(&priv->reg_mutex);
> +		return ret;
> +	}
> +
> +	if (eee->eee_enabled)
> +		reg |= lpi_en;
> +	else
> +		reg &= ~lpi_en;
> +	ret = qca8k_write(priv, QCA8K_REG_EEE_CTRL, reg);
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

seperate file for ethtool ops?

> +static const struct ethtool_ops ipqess_port_ethtool_ops = {
> +	.get_drvinfo		= ipqess_port_get_drvinfo,
> +	.nway_reset		= ipqess_port_nway_reset,
> +	.get_link		= ethtool_op_get_link,
> +	.get_eeprom_len		= ipqess_port_get_eeprom_len,
> +	.get_strings		= ipqess_port_get_strings,
> +	.get_ethtool_stats	= ipqess_port_get_ethtool_stats,
> +	.get_sset_count		= ipqess_port_get_sset_count,
> +	.self_test		= net_selftest,
> +	.set_wol		= ipqess_port_set_wol,
> +	.get_wol		= ipqess_port_get_wol,
> +	.set_eee		= ipqess_port_set_eee,
> +	.get_eee		= ipqess_port_get_eee,
> +	.get_link_ksettings	= ipqess_port_get_link_ksettings,
> +	.set_link_ksettings	= ipqess_port_set_link_ksettings,
> +	.get_pauseparam		= ipqess_port_get_pauseparam,
> +	.set_pauseparam		= ipqess_port_set_pauseparam,
> +};
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
> +	unsigned int index = 0;
> +	const unsigned char *id = (const unsigned char *)&index;
> +	unsigned char len = sizeof(index);
> +	int err;

RCT

> +
> +	memset(dlp, 0, sizeof(*dlp));
> +	devlink_port_init(dl, dlp);

no need to call this, devlink_port_register will init
devlink port (devl_port_register_with_ops to be precise)

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
> +	port->bridge = NULL;
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
> +	netdev->ethtool_ops = &ipqess_port_ethtool_ops;
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
> +	rtnl_lock();
> +
> +	err = register_netdevice(netdev);

you can use register_netdev which takes care of rtnl locking

> +	if (err) {
> +		pr_err("error %d registering interface %s\n",
> +		       err, netdev->name);
> +		rtnl_unlock();
> +		goto out_phy;
> +	}
> +
> +	rtnl_unlock();
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
> new file mode 100644
> index 000000000000..a0639933e8bb
> --- /dev/null
> +++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
> @@ -0,0 +1,95 @@
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
> +struct ipqess_bridge {
> +	struct net_device *netdev;
> +	refcount_t refcount;
> +};
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
> +	struct ipqess_bridge *bridge;
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
> +#endif
> diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c
> new file mode 100644
> index 000000000000..45e83a8965be
> --- /dev/null
> +++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c
> @@ -0,0 +1,559 @@
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
> +	struct ipqess_devlink_priv *dl_priv;

ipqess_devlink_priv is not necessary I think, you can just alloc ipqess_switch using devlink_alloc.

> +	struct devlink *dl;
> +
> +	/* Add the switch to devlink before calling setup, so that setup can
> +	 * add dpipe tables
> +	 */
> +	dl = devlink_alloc(&ipqess_devlink_ops, sizeof(*dl_priv), sw->priv->dev);
> +	if (!dl)
> +		return -ENOMEM;
> +
> +	sw->devlink = dl;
> +
> +	dl_priv = devlink_priv(sw->devlink);
> +	dl_priv->sw = sw;
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
> +		for (i = 1; i < IPQESS_SWITCH_MAX_PORTS; i++) > +			if (sw->port_list[i - 1])
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
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node, *mdio_np, *psgmii_ethphy_np;
> +	struct device_node *ports, *port_np;
> +	struct ipqess_port *port = NULL;
> +	void __iomem *base, *psgmii;
> +	struct ipqess_switch *sw;
> +	struct qca8k_priv *priv;
> +	int ret;
> +	int i;

RFC

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

you can use @ret var here as well (like above)

> +		dev_err(dev, "platform ioremap psgmii fail %li\n", PTR_ERR(psgmii));
> +		return PTR_ERR(psgmii);
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
> +	psgmii_ethphy_np = of_parse_phandle(np, "psgmii-ethphy", 0);
> +	if (!psgmii_ethphy_np) {
> +		dev_warn(dev, "unable to get PSGMII eth PHY phandle\n");
> +		of_node_put(psgmii_ethphy_np);
> +	}
> +
> +	if (psgmii_ethphy_np) {
> +		priv->psgmii_ethphy = of_phy_find_device(psgmii_ethphy_np);
> +		of_node_put(psgmii_ethphy_np);
> +		if (!priv->psgmii_ethphy) {
> +			dev_err(dev, "unable to get PSGMII eth PHY\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	/* If we don't reset the PSGMII here the switch id check will fail */
> +	sw->psgmii_rst = devm_reset_control_get(&pdev->dev, "psgmii_rst");
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
> +			  qca8k_port_set_status(priv, i, 0);
> +			  priv->port_enabled_map &= ~BIT(i);

Wrong indentation

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
> +	{ .compatible = "qca,ipq4019-qca8337n", },
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
> index 000000000000..e86674c2947e
> --- /dev/null
> +++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.h
> @@ -0,0 +1,40 @@
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
> +struct ipqess_devlink_priv {
> +	struct ipqess_switch *sw;
> +};
> +
> +unsigned int ipqess_switch_fastest_ageing_time(struct ipqess_switch *sw,
> +					       unsigned int ageing_time);
> +int ipqess_set_ageing_time(struct ipqess_switch *sw, unsigned int msecs);
> +
> +int ipqess_switch_setup(struct ipqess_switch *sw);
> +
> +#endif
