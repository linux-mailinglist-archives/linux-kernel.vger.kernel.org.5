Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98377810E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbjLMJti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbjLMJtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:49:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585ACF3;
        Wed, 13 Dec 2023 01:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702460967; x=1733996967;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/BE4cI8nyAieZmYdL41ExEy2b/slFRRpAViTi2mAXFo=;
  b=EYSsOQY2rzfytq3sjs3idNfwzENwbBtOJvGGawvx7EFi0L/L6o+mRMBs
   tQbnKcImENJFbiHLPgz2+Izyhdo3ssUyucPLixI4I6mfr6Giak8dDT1e+
   uqB+vwzwXELZrHLPlVjnjiKYkWjTVtludvo74wPgwmMuX4ioxhVPXP3VT
   Cvf8+mU2W6ID7nOP78FYYr00D8yyUimDCgYP5WnKcOHg8LhmEUGKdiYMy
   XuJwfyh9Q0e9/LUezdZYkVXr0dl1qdZgCYEJZpM0cCQNp07QkgyvKJCXW
   rBn/Z8kvKfziEy+NLU9dOBOyp7sLHCEgwoX2GO/l3Wn7wPBWx72GPq+c9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1797173"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="1797173"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 01:49:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="750057561"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="750057561"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 01:49:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 01:49:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 01:49:25 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 01:49:25 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 01:49:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElOvzamoSQopa0IuipPh3AHScKZ++/xc4V+AeywcTHzqyr6PTHVvZ6wxSObxL7hxKpy2xQy5kVYfST63KhOof2T14bSn4YB5KqRgawJedMvmzQ3am2nX6Z8PHCjNTsei3DUBOVQe5H6dvLjFYX7PThY3ndFeNf+UDrsUCWSh1/xlQYMns3CnzhMWzHKHTQl5bsYvsXDFyeyB41R01BaCij5a93oQnrcFo4LQHwrU3jl49OpEKQcUBvS7tu2mpr+AuApTXBDt8a6ZqhiXEWZ42JfsEbU2fxrcX7sB7+sPIZv/NSpQv9Bq1w2/HuD3pYZTVkuiL026bjpuc7u4QFt47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TulmZyRFh/7VObXQgbbOF1Lf1ZTH1UmaohdlvRZvtLI=;
 b=AjHhEil949C/g9wn0pPXlgUv5Tt254dZB2MvxJNBZInvw7gRtb1Et1LwY6ByYihI4iQxwlIkLXkPwu4I9Z95WuTU1YYwsyvncWQtYsMRGw5czLOj3gZfpMem7P48UQtkRwYx4V7WMqVb1G+upXPgba6PPK2AG5SAy67ReOxydXPgjjw3fTfIaSwdk9Gc/dwLH4B+eiGpB8jJDZpLXw3jX//KU04U3Rancvkd1nBJIyuUqkFUPSZtw2gjTPx0TPNpPg1n23W3nD3gySx/cG8NKJvSaFRgR6MIM+tnWFCuJNOCZA1hqFYN9T5U0rZhjeZCtO9u2v3neIKTKyrfeQYzhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SA1PR11MB8427.namprd11.prod.outlook.com (2603:10b6:806:373::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:49:23 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 09:49:22 +0000
Message-ID: <1abd6bcb-6f6c-10a7-9b6f-e5e038233af8@intel.com>
Date:   Wed, 13 Dec 2023 10:49:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 iwl-next] ice: Fix some null pointer dereference issues
 in ice_ptp.c
Content-Language: en-US
To:     Kunwu Chan <chentao@kylinos.cn>, <jesse.brandeburg@intel.com>,
        <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <richardcochran@gmail.com>, <jacob.e.keller@intel.com>
CC:     <karol.kolacinski@intel.com>, <michal.michalik@intel.com>,
        <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Kunwu Chan <kunwu.chan@hotmail.com>
References: <20231212024015.11595-1-chentao@kylinos.cn>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231212024015.11595-1-chentao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::14) To DM6PR11MB3674.namprd11.prod.outlook.com
 (2603:10b6:5:13d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SA1PR11MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 810c45cc-d015-4132-ff16-08dbfbc0c82c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9Zbbhlpinztdtjz8dQMeXUI504vNaAMZBvkD0UPYoimZYlcYRzKZM+X8/o6Cmnt94q/1jsRwhUTMZMnLgAyd1g2b2VhS4xT/KLzyIxSWkfVyuPpm5dh+TlCfD4CIzgai3tKhYbjzUDEOGZYXcRnUpkH1TRy852WLvzqBv947gYitkKMsTmitTfjvnLd2476bqcFOPUAkVPUgZfkhu3JAsmxCQJdGYJnR0NfvgbcLAnTUxoeTJJh+n5AgIKFCFbaqH6/xgwyhaxzOLEkT89lADDwvhSnQbE6n2HU+TTEjJ4bQ626gR7MySvnORlgVcp+BYZrkL6y8AQ2JxQib+/7aHjH7svtGtwCMiOn/d4XThggK//ZqZZgLdplI/wsaCgRxV1S9WO9EzhfHqvM4D0NrE5TzOeD2aaeHbayV7GW760jBcYiTjFoYoHOlEGYCLXYIYaIOfGbNGF4RctbhtPcI4V+jv0Hc0eTuzN1sY4zW0ByP+tc/6FdT2QN16dG3M/CMFk1+M5/9QmPaMLwIsA5D/L4oUZy1TZMneSZkTGQMDnZL4Y8XHC4czTLa8mAa8Xz8TWiuPenN7DH7up7YsWp+Aqbjusgw9Q+oJxGaM5d3BYOmoAxVRXOe57hnqP9ZTpr9ZL0Bewf5TGkjxA8G27NYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(66899024)(2616005)(26005)(6666004)(6512007)(6506007)(82960400001)(31696002)(86362001)(36756003)(38100700002)(5660300002)(45080400002)(8676002)(8936002)(7416002)(4326008)(53546011)(83380400001)(66476007)(6636002)(66556008)(66946007)(41300700001)(2906002)(316002)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzRHYldiaVBwaDg0OE1VTVNGL3JvNUtjREZPN2FVZlE4S1FUdVp0dHNCT3FL?=
 =?utf-8?B?S1IzOVFKcU1IdEJtbmU0RmhFZlN1eWpOUXFXaEJWL1hPYXowdzFqblpwS2RI?=
 =?utf-8?B?a1JLeWVCVG1OQ2hDMk0wa3dCSXhUSW1IaFFYOThQL3F0N2FLNWRGc2NOQ240?=
 =?utf-8?B?RHJoY3NCT2NEWjJteXduRDM4c1l1aXoxdWoxRzhKSWJvZDNqVUxUbjFYTC9p?=
 =?utf-8?B?aVZHTzNjckV1VmxDQWQ4QzE3UlNSeWtFUUlSc1FYV1MwenpSenFnQzMzQzJT?=
 =?utf-8?B?UHpCbEhRN3lJeDFqTk12T1BzZklnNHFlMkVWR3FjMXdPZnFlWnI0Umk5bUZz?=
 =?utf-8?B?MnNWcGxkVGlRRnNxNGdKWUhGN01US2ZjQURzOEJHc2FldDZBWm93OCtmMDEv?=
 =?utf-8?B?b3l1VFNZejgxN2ttekRTUGd6MU1tTkEreUZYZGJoQXpEMXNhN3hKNXRCeTVS?=
 =?utf-8?B?d3JYb2gxUHBMUUVYYlI4WHhBeUtSeDd4QSsyWlIzdVBXN0J0UzcybTNYUWd1?=
 =?utf-8?B?bVN3RStRS3dhc1lCa1ZhdHZnUWh1OXMzbkZWcGtDVXFhTFFrcjdhQy9lTUtl?=
 =?utf-8?B?UC9WSlpVajQ5Qzk2VTlmekVyd1V6WXBRaDE0ZnBFMUl6aEVqVm11T25oNnhG?=
 =?utf-8?B?U1l4ZVNybkNtOWtQa3BjWTd2VHVkeUtLY0pPbDBQR3JrRHFPTGFuYkFWbitJ?=
 =?utf-8?B?c3hIZ0cveU5QMWwzVWllVDlOUFhLd3Z3Q05HU3JMeWdUd0pZS2VUenJWbWRJ?=
 =?utf-8?B?alZmT2JGRmx3ak5yTWFwazJQY1lFNE5WQzdURXVxcjIwRWRsamRzYUFCdjFh?=
 =?utf-8?B?YVVnZUdjUUhCOVB1Vm9wT2duQTVxbEJWdDNOTWp4TGtyeVFRamRMOGZFY2Fu?=
 =?utf-8?B?VTNxU2g0b2RQcUsydHhCYVcwbWNjTmJxazBnSnRNZnNnUzZQTEpnNjRwaElE?=
 =?utf-8?B?dXRhTHNrRmVHQ1lvbEI1aWRPREtsRTcxNnNDZUhxaFQ0WUk3TURaa1VacDg0?=
 =?utf-8?B?VEk0emdqU0I5bmdjbExDS1JLUjBtNHBmOW9rdFBZdW1MOUpLbUprempLaTha?=
 =?utf-8?B?QzViZGxGdFJZelluZVN1WVBOcElpcnlpZDF1NFE4N1Y4d2xJV2xJNFB1d0VY?=
 =?utf-8?B?c0RVZmxmVnMya3gvTTZFVWY0d3VoUGZRTkZxcFJVS1hMdnozaXhseGhzMEMv?=
 =?utf-8?B?am5JODFKdUdzVjRaaC9aa0Q0MkdUQjZlME84OWZRRk9hRjBmMnQ4RWgwM3pl?=
 =?utf-8?B?VlhiaU54YmJTQ2VyVlo2RlFqVTg4OG1FWFFKVzVOd3d0N1JxUGU1N0IvWFd3?=
 =?utf-8?B?REcvbEtmdEEzTVVqNnpnQjFCMFpnZnl3VXdZaHlrMHhxZFphaUJkZjNkOVhp?=
 =?utf-8?B?ZVZldVJnd09VYmt2RWdORlg2ZWVTK1lJU3FRY0dnT0lkRCtEblJ4NTR1TzBD?=
 =?utf-8?B?S3FKblJxVUZibFhaZkx4UjNlckJCYUNCSk9EUXJXZnQzRWx5VHY3N1NFU0lC?=
 =?utf-8?B?Vm9nd0ZYSURtaTFPOXdjSzZLbTJVSFN2VjZzS2dHZlkyNERKOTlGU003V2tH?=
 =?utf-8?B?cFZLWG1Rbzd4YUdDSVp4bUtySjRBTjRiNnNQMlVaNmZML0xtZ0J3TjVSWTFJ?=
 =?utf-8?B?bHBVSisyd1Q3Q2t4TEQyZjlmT1pqUWhXb0JMSlMxQUt3WUhCenlkUFJGSWVt?=
 =?utf-8?B?ZWtScWkyMzFDdFhUOVFmRkl5WXk0S0hDVTZvYVdlcEJWa2hoNFBpdStJMC96?=
 =?utf-8?B?MDJ4NHhNblljY0U0NkdBUDVVeEtrOUNYZ3VvRmNuMXFCRmovWlF5UU5oeXZr?=
 =?utf-8?B?RkNWOUtzSzJpQ0ZISGg1K1JVT2xUL1p6Zy9IQVJsTURmZWVYZ2JqREt0UDB4?=
 =?utf-8?B?RktHMThtVGhiT1AxMXZuaUFYSGN2OHJFQkQwalF0WHJwSm13VElnSk5sSWNR?=
 =?utf-8?B?eG9BN2VUMldEcEVCMlBiSlUrclhwTUZDelFIUHgweHdGUmppU3M4Tk1oZVZo?=
 =?utf-8?B?dkVHWG9ZVE4wTERzVWR2cm5uUzZCYVBVanU1cGdPb1B4YkV2QW9oRjhzRTdH?=
 =?utf-8?B?Y1NQb29kOGRrU0dMRkF3dkZNWmRQMWlKb0tSdUVYL2tpWUVnYzJDcExPbW5y?=
 =?utf-8?B?SGZPM2cxVGNWVDJORzZUVjQ2aVY4ekJiVVRjR0d2R2ZjSi9kV0NWYllRaGU3?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 810c45cc-d015-4132-ff16-08dbfbc0c82c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 09:49:22.4571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCifLmbOVtz4dXXr/WNGyhWpCPOf9HI63NrMOG/ksh75lLqr0Ajwb+GUuseH5NiNHSSjzjvmL1PgWEBNbTQFKFlt+Me/+UC89jjtNojH9VM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8427
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 03:40, Kunwu Chan wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure.
> 
> Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

You found the bug (or some some static analysis tool in that case);
there is no need to add Suggested-by for every person that suggests
something during review - the tag is for "person/s that suggested
making such change in the repo".

Subject line would be better if less generic, eg:
ice: avoid null deref of ptp auxbus name

> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index e9e59f4b5580..848e3e063e64 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -2743,6 +2743,8 @@ static int ice_ptp_register_auxbus_driver(struct ice_pf *pf)
>   	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
>   			      pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
>   			      ice_get_ptp_src_clock_index(&pf->hw));
> +	if (!name)
> +		return -ENOMEM;
>   
>   	aux_driver->name = name;
>   	aux_driver->shutdown = ice_ptp_auxbus_shutdown;
> @@ -2989,6 +2991,8 @@ static int ice_ptp_create_auxbus_device(struct ice_pf *pf)
>   	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
>   			      pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
>   			      ice_get_ptp_src_clock_index(&pf->hw));
> +	if (!name)
> +		return -ENOMEM;
>   
>   	aux_dev->name = name;
>   	aux_dev->id = id;

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Regarding iwl-next vs iwl-net: this bug is really unlikely to manifest,
as we take care of both earlier and future mem allocs for ptp auxbus,
and auxiliary_device_init() checks for null name, so no big deal,
so: -next is fine
