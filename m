Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8417577E085
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244669AbjHPLgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244722AbjHPLft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:35:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3D02123;
        Wed, 16 Aug 2023 04:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692185746; x=1723721746;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V7fpj5s4u5jcfTgI0S+74ysRkOGB16xhJDqEiGmjZak=;
  b=lbFvJV8BX6SE+99ZWa1vWq9K1Xx7QOwEPMW85+v+Gzio0tnzPfUzV+XT
   LwpBb9FTExUqpAB+XFMZ4CwV/xqN2vgj9uE+GeGlhV2zmbYQh5rnZDTOz
   MQE+T6m+jtOGw5G4QuXCwOt9MnP7IFtRD+zLNHQQzqpBfqiiW+QBZjDuO
   ehgyQAltTVw9Ysi/emJc16nHgQMPH+4kZlFgaoF7Y0i8QvMgu4Me6zLbD
   B5ZQy91JubrTVEL72xwSlNiUk3xqnKa8Qo+Jg0gOylPsCo4cDk+/Mpufm
   q6MyVxbNJ0qSHo0zbOFHF8zsjXnJ8gQXYlNAXwpAS7mhXfFxg5dyuimw4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371416925"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="371416925"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 04:35:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="711087537"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="711087537"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 16 Aug 2023 04:35:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 04:35:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 04:35:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 04:35:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AK8AGyvIG376J6V+mVZ1xzJE784nEGFf/FMy8WH3wTox0zrqGs0CHv6U+2LkyGcSXkVNj4BBavuWscjqhESfmJC0X2DsSbr2dyrZ2X9ThYtwLf4+qB1OKgifmHMo/o711Gl0Qwv6IaXq2xEfSYJncn8DUvA+7D8rlEojFugglROpYqACyY1iWX0wPm/hHkINd0/Yq5R2INKLvF0N+xVDSIB2S6GKXKEDq4NIxNzqc/x4WzPXC3rGdcM0yJFH7b1PYM/2A9J3ZFXbDBcmmoozxencsOAgMRn6Jeh0xLCEjRpismxH/1z9ZPeZSiQIM0qWgqOPfx9lX+SEUuRm+pGPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9T4YZ45EvQworbzQBD7l7ibPOm2/hf8/uHXtfmbL7k=;
 b=n3RoKq8U88ZY7q77JcvZOpwnNwl9BESBSuHc+NjXDeSxx5ZReHeb7+gjQX1N0KUlsnR34vQCMYUIpmFF55d61CF36k+qi0hEZfQ5oa035GjYYXBZvs7wj7kDbHSTdmhChldhSQZZexAcXulAcdIT0ELIAmOzVy0eu0gRHwWmRQhhXkBoyqXJm199qkhDjDPneLOON0Ea/uM1XLLA3oVFfKo+rpUud7CztJCXaL0PIKcrgQ4jOit+1rnlUGHwRaBlex5ya7Nq1ay9ku4tAK29SFnQ/Fd9h2IHUm3isxV7fM6A7t0se1GxczExSg6rqBIEgZr4P5rYsT0uYNLpHRVKGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by IA1PR11MB8248.namprd11.prod.outlook.com (2603:10b6:208:447::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 11:35:30 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::5f7a:95cd:9d79:aafd]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::5f7a:95cd:9d79:aafd%5]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 11:35:30 +0000
Message-ID: <a0ab4d07-fb73-418b-b88d-c3ad6aa4cf49@intel.com>
Date:   Wed, 16 Aug 2023 13:35:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ACPI: PHAT: Add Platform Health Assessment Table support
Content-Language: en-US
To:     Avadhut Naik <avadhut.naik@amd.com>, <rafael@kernel.org>,
        <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
        <avadnaik@amd.com>
References: <20230810234856.2580143-1-avadhut.naik@amd.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <20230810234856.2580143-1-avadhut.naik@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::7) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|IA1PR11MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: ddae20a2-906e-4313-0a12-08db9e4ce4ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVv/lEKldrKwETBU5knXylY3/jJ1YpvyX+n0e1/QSFedKEpVZzKt64CyleSJnqykbqB1TwPjhHNqTQf0JWemP01R5s1pRzf8hxhfxqJQGWy7swjAgBS7jwabgOEddAt8DwJjpe0SGk3NjatZe9ImjlBP2/JLy0hClYj9tp0zlQMc2WkKOhnwh4FdhuZWmDQforKM8QGG+SsNqyMOlWJhwJKub/BP79VgtcbJ2vm4CeLe14ZAF7JpvX9YT+1hRKyFe/F5zqy/lMLVC/UAALxOpgEOllokoP5xrvDH6pQsinLvLOII4A+UONlotw2lRZB6F73M9w/u3J1NU9LAdHoK/vHz/yUIKZEYpSj7E6WfHHxohIyKoKhw3i8g1uPDJeJ/UxJQpPx1bXq3o1InRkNX0vjeNcVZEBlFeQvxXmRxTrPkzA9U6NW6ruBQuFZWzoaNXbDkODxoFef21Tfk8nLsSFHkA7VBDi5ZCu65bn5/oJJPmtaau9nBf2sORZUzZZP4caS8yjmJbjkZB/e1qUazXOJs4HdeiULdVTUVpcmNHjoVhZRaP3dWt8Q/t6C/fY1qJPLcqhNb0aPGd/2Go22D5liX61BWWoQACTnCzEjClTE88DB4wqZVemCqQcXjVuVOUQk2tE2sGHWJq8CqU1yqMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(1800799009)(451199024)(186009)(316002)(66946007)(66476007)(66556008)(41300700001)(5660300002)(38100700002)(31686004)(8676002)(4326008)(8936002)(82960400001)(30864003)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(53546011)(31696002)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWFpY2NRZzV2RFdCdWpTQ0NKUXRBM2Y2SW1qdEJIbjd6QlQwaHY3aGhLQWZl?=
 =?utf-8?B?aUdWK1FMVjRZY25EV2xTR2liZ1JxZXl1bkRHZG5vdFE2SFRGSlJuY3hNZXpO?=
 =?utf-8?B?Vll2Uk9vTEFiMC9PY2dGL0cwYXRRckFWdFptYVZ5ak81emx4V3ArTmpFMER2?=
 =?utf-8?B?TlFuQnc0TGtMM3dsc2lGYmVmOCtadGZacEpqRWNjdnRselhSbGZEU2orWVdD?=
 =?utf-8?B?d3MzOXZhT2lXSkVRMVpyVlA5dFhLWGduREJKUTV0Uk94QkVqbnlJOU11V0pP?=
 =?utf-8?B?bGJaakZoMmhyUlp3aGxCZFlsMTdLV00xQmlTaUIrUjJWMnFEYlpkZFlhb3lQ?=
 =?utf-8?B?a3BGVVJKV1JPT1ZFWi9vcmczYjVucjlkYm5pdGh2L3RMWEFoTmxtTXp3b1Jm?=
 =?utf-8?B?UWUrbVJ3N1JUSGY1Ly9ISmlyUHE1YldLdEVUQlpPc3o0U0hlaEZkSGRacjM1?=
 =?utf-8?B?RW9yakZKbGFDYmRSYzZoZkJzU1hCSFl2U1VFRmxHTGpPc0NVYitFMENTZDJx?=
 =?utf-8?B?RENpdDh6b2ZoM1VHRVZxb0NoUzQ5SkNORkNoS05sM3pkUEg5aENaeFpxc2dS?=
 =?utf-8?B?SzF3TGIxTWVjdnBqMVlBb3p6ajVwL1hOQjhmWVlGakVrR0VHTFV2UXN4anI2?=
 =?utf-8?B?dVVCc1Rnd2VCOVdISEdWcmJXdmxuYlUxZVcrZU95NFhQeFU4b2VNUTF3NXho?=
 =?utf-8?B?RW0vMW5vMzhZMWxKcFpLNGZZQk53Wk0wSWp3Z3JBL2J2SlppencxcEdnclhp?=
 =?utf-8?B?WkdiSzYyb0l0SGRCTlZPQ3cyd3VRbGNnM2VXUU9LbXpoQm5qRXFSUFYydGVt?=
 =?utf-8?B?Y09ISWh6bDlrWWZ2Z2ZqRk5jb2RRRWduMEFXN2dvVWh1aURWREdSTVBlaG9J?=
 =?utf-8?B?emxOTmNpZzlTMmQzeUtpTjRlSWRqOUlZYWthVUlNSEJWendiS0MwRHA4YXlN?=
 =?utf-8?B?ZzJER0U1dEs4S0dOY2FFWXRScTJhU2djOXNXNHNWM280S2pTOTZoejdyTlRp?=
 =?utf-8?B?Tk9rV3NzMy9BVUFPbDJJSnNEMFRoQmRERzEyWDAwOUptTXYxQWhrODJQa3hO?=
 =?utf-8?B?aG1TY1ZRNFpuZ1JHeW9LOUR3MUd0RVZGck5xYWxPcUlNZXZtSjZoTStDaTVO?=
 =?utf-8?B?UEx1b3ptWmJWYXBVWEJ0amJkNmxGWFVrRnJ6TTNQQUU3czRuK29YdEVMbXhx?=
 =?utf-8?B?c0xjTFJDUzdWUjBtUmRxUmwxRGhKeTA2WlhNUURsb1ovN0VhSWdhMW9qRGRF?=
 =?utf-8?B?eWhqTkJ5SCtaMFl0cTY4WkNaMTNTdFN0d0RyZWFBeDRpMytpSUViYTg4R05Q?=
 =?utf-8?B?dmNNaWxwOXVmSm5BMG94Y1ByS2FkZUR3ZFptbWsvQ3dmQ0ZldXh6OUZMOGZo?=
 =?utf-8?B?em0xNnFLdjVuUy9HVUsrUDRFRTNncUowcEtnQ3JPTVdSK1YrNzVzWUZXYloz?=
 =?utf-8?B?eTR3VGlsYzRsSVRrZExaWldKTnRDVjh3TVBMSzJaWlJVY1FRNURDbnVINVAz?=
 =?utf-8?B?UC80eDkzbWM3Y0pESW9wTHNGVXJEYXRLVWNkMWMvYStwVzhiTWhabkk5UlZ4?=
 =?utf-8?B?SFBjSzBDMkx5bUhyMEthWWVkQTZJZTk2S0NmSnorWWluaDhDV2d4eVZTc3pz?=
 =?utf-8?B?UzdHTG03N3RQK3BLYnl5cUU4RmZtaWJVWHVUSlM0dW1yVWhjd0VlbVFBa1pH?=
 =?utf-8?B?UmZQYjl6bytXc1ZabDBFMmhRQjkzRlhNclU2Q1NPQ3lYaFpzbmtlQkI5QmxQ?=
 =?utf-8?B?UUJvUnRNdjJEVUZKUGxRbnNqem1wZWQwbkZrM0JVQ1lxQ2dDVnlaWEtra1pT?=
 =?utf-8?B?TE1pL3FEdklrV0Z1NTU0dWNDNS81MnI3SG9CTHVKbXhnajBVWEs4RDRxQzJk?=
 =?utf-8?B?dDBaWWhyZFJENW5PbVh6K2R3UERmR3p4UlJ5cUczSXNkZnRZc29lQzM2NXNw?=
 =?utf-8?B?MGRtVWF3bVNNa01naFROMHhEeURMS1B0UWVHWDBrRnhiL2ZPd3N5dlBvTlFa?=
 =?utf-8?B?TkpPMkthRUNKTUMxN1g2SFBTQXhsODJKTjY3WlNoRVE2cGR6R1p5bC9FcnFO?=
 =?utf-8?B?Uk9ITjF2ejFnaGtHbWl4YVN1YzErcS9uZkpacmRxY21VWHVVL3NhWC8vRWs1?=
 =?utf-8?B?bWVEOFpMaWpLK1g2RVNsY0E0QkxkZktBR2cyUXlQbmJxYUtxNWNlRWF1Rmx4?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ddae20a2-906e-4313-0a12-08db9e4ce4ca
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 11:35:29.8778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrz1oqDfOIPyXUdhgRqm11WbyJIbmg0xgYhtpXZC2Z6AHGW+dvEfaLBU7rdtYGGvgts6BkyRNDPSNcbIITp9gGv0oP4jZD09diN+gK8Pwbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8248
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/11/2023 1:48 AM, Avadhut Naik wrote:
> ACPI Platform Health Assessment Table (PHAT) enables a platform to expose
> an extensible set of platform health related telemetry. The telemetry is
> exposed through Firmware Version and Firmware Health Data Records which
> provide version data and health-related information of their associated
> components respectively.
>
> Additionally, the platform also provides Reset Reason Health Record in
> the PHAT table highlighting the cause of last system reset or boot in case
> of both expected and unexpected events. Vendor-specific data capturing the
> underlying state of the system during reset can also be optionally provided
> through the record.[1]
>
> Add support to parse the PHAT table during system bootup and have its
> information logged into the dmesg buffer.
>
> [1] ACPI specification 6.5, section 5.2.31.5
>
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |   4 +
>  drivers/acpi/Kconfig                          |   9 +
>  drivers/acpi/Makefile                         |   1 +
>  drivers/acpi/phat.c                           | 270 ++++++++++++++++++
>  include/acpi/actbl2.h                         |  18 ++
>  5 files changed, 302 insertions(+)
>  create mode 100644 drivers/acpi/phat.c
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 722b6eca2e93..33b932302ece 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4490,6 +4490,10 @@
>  			allocator.  This parameter is primarily	for debugging
>  			and performance comparison.
>  
> +	phat_disable=	[ACPI]
> +			Disable PHAT table parsing and logging of Firmware
> +			Version and Health Data records.
> +
>  	pirq=		[SMP,APIC] Manual mp-table setup
>  			See Documentation/arch/x86/i386/IO-APIC.rst.
>  
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 00dd309b6682..06a7dd6e5a40 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -96,6 +96,15 @@ config ACPI_FPDT
>  	  This table provides information on the timing of the system
>  	  boot, S3 suspend and S3 resume firmware code paths.
>  
> +config ACPI_PHAT
> +	bool "ACPI Platform Health Assessment Table (PHAT) support"
> +	depends on X86_64 || ARM64
> +	help
> +	  Enable support for Platform Health Assessment Table (PHAT).
> +	  This table exposes an extensible set of platform health
> +	  related telemetry through Firmware Version and Firmware Health
> +	  Data Records.
> +
>  config ACPI_LPIT
>  	bool
>  	depends on X86_64
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 3fc5a0d54f6e..93a4ec57ba6d 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -69,6 +69,7 @@ acpi-$(CONFIG_ACPI_WATCHDOG)	+= acpi_watchdog.o
>  acpi-$(CONFIG_ACPI_PRMT)	+= prmt.o
>  acpi-$(CONFIG_ACPI_PCC)		+= acpi_pcc.o
>  acpi-$(CONFIG_ACPI_FFH)		+= acpi_ffh.o
> +acpi-$(CONFIG_ACPI_PHAT)	+= phat.o
>  
>  # Address translation
>  acpi-$(CONFIG_ACPI_ADXL)	+= acpi_adxl.o
> diff --git a/drivers/acpi/phat.c b/drivers/acpi/phat.c
> new file mode 100644
> index 000000000000..6006dd7615fa
> --- /dev/null
> +++ b/drivers/acpi/phat.c
> @@ -0,0 +1,270 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Platform Health Assessment Table (PHAT) support
> + *
> + * Copyright (C) 2023 Advanced Micro Devices, Inc.
> + *
> + * Author: Avadhut Naik <avadhut.naik@amd.com>
> + *
> + * This file implements parsing of the Platform Health Assessment Table
> + * through which a platform can expose an extensible set of platform
> + * health related telemetry. The telemetry is exposed through Firmware
> + * Version Data Records and Firmware Health Data Records. Additionally,
> + * a platform, through system firmware, also exposes Reset Reason Health
> + * Record to inform the operating system of the cause of last system
> + * reset or boot.
> + *
> + * For more information on PHAT, please refer to ACPI specification
> + * version 6.5, section 5.2.31
> + */
> +
> +#include <linux/acpi.h>
> +
> +static int phat_disable __initdata;
> +static const char *prefix = "ACPI PHAT: ";

Wouldn't it be better if you used pr_fmt macro instead ?

> +
> +/* Reset Reason Health Record GUID */
> +static const guid_t reset_guid =
> +	GUID_INIT(0x7a014ce2, 0xf263, 0x4b77,
> +		  0xb8, 0x8a, 0xe6, 0x33, 0x6b, 0x78, 0x2c, 0x14);
> +
> +static struct { u8 mask; const char *str; } const reset_sources[] = {
> +	{BIT(0), "Unknown source"},
> +	{BIT(1), "Hardware Source"},
> +	{BIT(2), "Firmware Source"},
> +	{BIT(3), "Software initiated reset"},
> +	{BIT(4), "Supervisor initiated reset"},
> +};
> +
> +static struct { u8 val; const char *str; } const reset_reasons[] = {
> +	{0, "UNKNOWN"},
> +	{1, "COLD BOOT"},
> +	{2, "COLD RESET"},
> +	{3, "WARM RESET"},
> +	{4, "UPDATE"},
> +	{32, "UNEXPECTED RESET"},
> +	{33, "FAULT"},
> +	{34, "TIMEOUT"},
> +	{35, "THERMAL"},
> +	{36, "POWER LOSS"},
> +	{37, "POWER BUTTON"},
> +};
> +
> +/*
> + * Print the last PHAT Version Element associated with a Firmware
> + * Version Data Record.
> + * Firmware Version Data Record consists of an array of PHAT Version
> + * Elements with each entry in the array representing a modification
> + * undertaken on a given platform component.
> + * In the event the array has multiple entries, minimize logs on the
> + * console and print only the last version element since it denotes
> + * the currently running instance of the component.
> + */
> +static int phat_version_data_parse(const char *pfx,
> +				   struct acpi_phat_version_data *version)
> +{
> +	char newpfx[64];
> +	u32 num_elems = version->element_count - 1;
> +	struct acpi_phat_version_element *element;
> +	int offset = sizeof(struct acpi_phat_version_data);
> +
> +	if (!version->element_count) {
> +		pr_info("%sNo PHAT Version Elements found.\n", prefix);
> +		return 0;
> +	}
> +
> +	offset += num_elems * sizeof(struct acpi_phat_version_element);
> +	element = (void *)version + offset;
> +
> +	pr_info("%sPHAT Version Element:\n", pfx);
> +	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
> +	pr_info("%sComponent ID: %pUl\n", newpfx, element->guid);
> +	pr_info("%sVersion: 0x%llx\n", newpfx, element->version_value);
> +	snprintf(newpfx, sizeof(newpfx), KERN_INFO "%s ", pfx);
> +	print_hex_dump(newpfx, "Producer ID: ", DUMP_PREFIX_NONE, 16, 4,
> +		       &element->producer_id, sizeof(element->producer_id), true);

I do have to admit that all this dancing with pfx and newpfx confuses me. Couldn't you
just use pr_fmt for everything printed using pr_* family of functions ? print_hex_dump()
is not impacted by pr_fmt, as it just uses printk to do it's printing.

> +
> +	return 0;
> +}
> +
> +/*
> + * Print the Reset Reason Health Record
> + */
> +static int phat_reset_reason_parse(const char *pfx,
> +				   struct acpi_phat_health_data *record)
> +{
> +	int idx;
> +	void *data;
> +	u32 data_len;
> +	char newpfx[64];
> +	struct acpi_phat_reset_reason *rr;
> +	struct acpi_phat_vendor_reset_data *vdata;
> +
> +	rr = (void *)record + record->device_specific_offset;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(reset_sources); idx++) {
> +		if (!rr->reset_source) {
> +			pr_info("%sUnknown Reset Source.\n", pfx);
> +			break;
> +		}
> +		if (rr->reset_source & reset_sources[idx].mask) {
> +			pr_info("%sReset Source: 0x%x\t%s\n", pfx, reset_sources[idx].mask,
> +				reset_sources[idx].str);
> +			/* According to ACPI v6.5 Table 5.168, Sub-Source is
> +			 * defined only for Software initiated reset.
> +			 */
> +			if (idx == 0x3 && rr->reset_sub_source)
> +				pr_info("%sReset Sub-Source: %s\n", pfx,
> +					rr->reset_sub_source == 0x1 ?
> +					"Operating System" : "Hypervisor");
> +			break;
> +		}
> +	}
> +
> +	for (idx = 0; idx < ARRAY_SIZE(reset_reasons); idx++) {
> +		if (rr->reset_reason == reset_reasons[idx].val) {
> +			pr_info("%sReset Reason: 0x%x\t%s\n", pfx, reset_reasons[idx].val,
> +				reset_reasons[idx].str);
> +			break;
> +		}
> +	}
> +
> +	if (!rr->vendor_count)
> +		return 0;
> +
> +	pr_info("%sReset Reason Vendor Data:\n", pfx);
> +	vdata = (void *)rr + sizeof(*rr);
> +
> +	for (idx = 0; idx < rr->vendor_count; idx++) {
> +		snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
> +		data_len = vdata->length - sizeof(*vdata);
> +		data = (void *)vdata + sizeof(*vdata);
> +		pr_info("%sVendor Data ID: %pUl\n", newpfx, vdata->vendor_id);
> +		pr_info("%sRevision: 0x%x\n", newpfx, vdata->revision);
> +		snprintf(newpfx, sizeof(newpfx), KERN_INFO "%s ", pfx);
> +		print_hex_dump(newpfx, "Data: ", DUMP_PREFIX_NONE, 16, 4,
> +			       data, data_len, false);
> +		vdata = (void *)vdata + vdata->length;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Print the Firmware Health Data Record.
> + */
> +static int phat_health_data_parse(const char *pfx,
> +				  struct acpi_phat_health_data *record)
> +{
> +	void *data;
> +	u32 data_len;
> +	char newpfx[64];
> +
> +	pr_info("%sHealth Records.\n", pfx);
> +	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
> +	pr_info("%sDevice Signature: %pUl\n", newpfx, record->device_guid);
> +
> +	switch (record->health) {
> +	case ACPI_PHAT_ERRORS_FOUND:
> +		pr_info("%sAmHealthy: Errors found\n", newpfx);
> +		break;
> +	case ACPI_PHAT_NO_ERRORS:
> +		pr_info("%sAmHealthy: No errors found.\n", newpfx);
> +		break;
> +	case ACPI_PHAT_UNKNOWN_ERRORS:
> +		pr_info("%sAmHealthy: Unknown.\n", newpfx);
> +		break;
> +	case ACPI_PHAT_ADVISORY:
> +		pr_info("%sAmHealthy: Advisory – additional device-specific data exposed.\n",
> +			newpfx);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (!record->device_specific_offset)
> +		return 0;
> +
> +	/* Reset Reason Health Record has a unique GUID and is created as
> +	 * a Health Record in the PHAT table. Check if this Health Record
> +	 * is a Reset Reason Health Record.
> +	 */
> +	if (guid_equal((guid_t *)record->device_guid, &reset_guid)) {
> +		phat_reset_reason_parse(newpfx, record);
> +		return 0;
> +	}
> +
> +	data = (void *)record + record->device_specific_offset;
> +	data_len = record->header.length - record->device_specific_offset;
> +	snprintf(newpfx, sizeof(newpfx), KERN_INFO "%s ", pfx);
> +	print_hex_dump(newpfx, "Device Data: ", DUMP_PREFIX_NONE, 16, 4,
> +		       data, data_len, false);
> +
> +	return 0;
> +}
> +
> +static int parse_phat_table(const char *pfx, struct acpi_table_phat *phat_tab)
> +{
> +	char newpfx[64];
> +	u32 offset = sizeof(*phat_tab);
> +	struct acpi_phat_header *phat_header;
> +
> +	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
> +
> +	while (offset < phat_tab->header.length) {
> +		phat_header = (void *)phat_tab + offset;
> +		switch (phat_header->type) {
> +		case ACPI_PHAT_TYPE_FW_VERSION_DATA:
> +			phat_version_data_parse(newpfx, (struct acpi_phat_version_data *)
> +			    phat_header);
> +			break;
> +		case ACPI_PHAT_TYPE_FW_HEALTH_DATA:
> +			phat_health_data_parse(newpfx, (struct acpi_phat_health_data *)
> +			    phat_header);
> +			break;
> +		default:
> +			break;
> +		}
> +		offset += phat_header->length;
> +	}
> +	return 0;
> +}
> +
> +static int __init setup_phat_disable(char *str)
> +{
> +	phat_disable = 1;
> +	return 1;
> +}
> +__setup("phat_disable", setup_phat_disable);
> +
> +static int __init acpi_phat_init(void)
> +{
> +	acpi_status status;
> +	struct acpi_table_phat *phat_tab;
> +
> +	if (acpi_disabled)
> +		return 0;
> +
> +	if (phat_disable) {
> +		pr_err("%sPHAT support has been disabled.\n", prefix);
> +		return 0;
> +	}
> +
> +	status = acpi_get_table(ACPI_SIG_PHAT, 0,
> +				(struct acpi_table_header **)&phat_tab);
> +
> +	if (status == AE_NOT_FOUND) {
> +		pr_info("%sPHAT Table not found.\n", prefix);
> +		return 0;
> +	} else if (ACPI_FAILURE(status)) {
> +		pr_err("%sFailed to get PHAT Table: %s.\n", prefix,
> +		       acpi_format_exception(status));
> +		return -EINVAL;
> +	}
> +
> +	pr_info("%sPlatform Telemetry Records.\n", prefix);
> +	parse_phat_table(prefix, phat_tab);

So for now you're only dumping tables to the dmesg output ?
Are you planning to create some sysfs interfaces similar to let's
say EINJ ?

> +
> +	return 0;
> +}
> +late_initcall(acpi_phat_init);
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 0029336775a9..c263893cbc7f 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -2360,6 +2360,24 @@ struct acpi_phat_health_data {
>  #define ACPI_PHAT_UNKNOWN_ERRORS        2
>  #define ACPI_PHAT_ADVISORY              3
>  
> +/* Reset Reason Health Record Structure */
> +
> +struct acpi_phat_reset_reason {
> +	u8 supported_reset_sources;
> +	u8 reset_source;
> +	u8 reset_sub_source;
> +	u8 reset_reason;
> +	u16 vendor_count;
> +};
> +
> +/* Reset Reason Health Record Vendor Data Entry */
> +
> +struct acpi_phat_vendor_reset_data {
> +	u8 vendor_id[16];
> +	u16 length;
> +	u16 revision;
> +};
> +
>  /*******************************************************************************
>   *
>   * PMTT - Platform Memory Topology Table (ACPI 5.0)

