Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1819D7D4DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbjJXKYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbjJXKYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:24:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C508F9;
        Tue, 24 Oct 2023 03:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698143065; x=1729679065;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dc3i+9fWuALy4S8sty89cWgiJlmK95bkoxIO3uunrfM=;
  b=CT0kw4N3euPbrZggUMiazrX5AsAHkq4o6IHSo+BNJw8ND/s6CQz1ohP8
   7V2E5bO/DJ2aIR8EK0FPz7VbZqSa2F8N+x/ntc6sKXWzAE1lK/X62jIWj
   FmNTTsaqCZW7FbmxNfiUtbXQjfDocjFfljtkyffqNqX2USkFvtRVMiVjl
   iGBar3WFVma8CTG7utT8RCxEr8RbnDz/p1tO8GeA5JVLmu0phQa2UxVPR
   YqcKbXOlIREs+DFGw2hoHoIYos11eEDcoIF91ZQx8HLvousHZ8/V/r/GB
   hGAsvjm1svhmAf3X0F1VJW8MFHznspMRpIuqOlPdeuhCWm8Z/UpxZLKUo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="8577626"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="8577626"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 03:24:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="6135431"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 03:23:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 03:24:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 03:24:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 03:24:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClZCUXwoX1bvX0UdHrWjYk6A+d70f+CnitWXvOXvWTFUXQYxt4kO3mQrr65wrkMesTwQj+uS85qbvT+qCnxSPt+SItSIumW0uqj4hpI0U4QQrxf7r+y8u5hHp0p2UOviWABoE1xBLBBMdaqu3YbQsD482+xzKE5thlbjWTgYOFHKE+v3YqzPzErTqFUH74JzWyq3wTkTWw1o5uKsK+svqy8xbYZWpgSLGabLT1fwAM4qM83ckt7P7/xsDPsADqW+mg/8UGvrj/UdWdzklbHzGbYEnSxuutTrr4d+zBuJSNDyP2+WqOD4HSKs8Me91cecDklyXmEuhIzW/t0NHtVoTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9JJu5lzxqGQhc6Qwab8sI7ig/H4y3sX/MChOWBXzBk=;
 b=SVA2sWJ2j6mSFdc3W3kLMOR5OG0Q770LNrkkaZjEiGSE1sMKwu8vGPE+fzEYszeRsOnDrhtsRynXQTCZvuFBJw4wrn1PE4U8Fmf3zsuQqEO9k1y71ascr/1gOxmIbnJO6Yyki1WcJBe6jpDwjtE2Wlj9kYDJ0JGdUTyoDk9IDsjbes/7clwBlAVTPC7qBcWgbOcjMbUCTTSNXtofFb5Ti3ru68L6YsrGO/nK2ASuJsyk8XWK1Zdh1bD4gzVfjB78KqedSIqqwQ+0TjZ01Dri6RJ5F88A75i0Q1MnS4bdSb4glXDKahBZMy9quAmW/dh7vbLd0RJQdwxAhkWGfGfUEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA2PR11MB4827.namprd11.prod.outlook.com (2603:10b6:806:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Tue, 24 Oct
 2023 10:24:16 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 10:24:15 +0000
Message-ID: <2aba9a2d-9dfd-49f2-bfec-1ff563a5f017@intel.com>
Date:   Tue, 24 Oct 2023 12:24:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 2/3] i40e: Add other helpers to
 check version of running firmware and AQ API
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     <intel-wired-lan@lists.osuosl.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        <dacampbe@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20231023162928.245583-1-ivecera@redhat.com>
 <20231023162928.245583-3-ivecera@redhat.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231023162928.245583-3-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::27) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SA2PR11MB4827:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd8a96d-df0c-4dea-a2cf-08dbd47b5f8a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9rC6El77umHcWZNWqaw8tn2Yh/YYlKHGW7z/zuHKqMuV1u5evfdtU1L3drFxZW1v5cJpUKkEGBb4OK2Ze5KdHkz8L3BMXjnAsyc8f/n1SxRvqFkB7BO2BlcSVBE3zt+JiPYs70fdqlTcnbQ99A6RMaxCMMuI3LCcuODF2Lv5HfvYxxyMOqndfr3lhFfHU1QpLvBMZwJi7irS8RiVHE9RrdGZ0Yel+k1UQXY7ilw2UAHBR1MIaXy45l2QQ8ZVkkXDKwcCuV96IuOcTPwqzxZ3RG8nDgNMJg4RqmGNYMjAvPcHXc1Vpaf9ZjF0uCMiOPF/ayC1lfGYsBZ5OgSnkrMIJMRLGZmLh78ba38E+Lt0sh1gJunV70Ny0Co6ZH09slziL1xykg7jK9gTIBLT7UTA+mpNl+fXFDIUKYOo24TP6Wyw7wgQnpPdZ3ubhHW15MdY0p1ZEzJn4ZREAxWDvmGqFkRbk2RMrpjUqkHY7PfED3lzi+poLuX9+RaQDN25T7UBVgPGTTkpnC0Ss/vgnfsjLWIN88+3tdUQH7/wJAZptc5iou9ron2suUfTh+scIf7lfxvkhnMVHyw46Otvznjd9rxuYPA01ELFMZhbTX29xdOZ+gWNqNHV35jFniuLfv7EhKgQiSYu64K0BhV8OSoN3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(66556008)(38100700002)(66476007)(66946007)(54906003)(82960400001)(2616005)(478600001)(316002)(6506007)(6486002)(53546011)(6666004)(83380400001)(6512007)(44832011)(86362001)(5660300002)(41300700001)(36756003)(31696002)(4326008)(8676002)(8936002)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk1iaEcrdTdiaUQ5R25hd1oxcUF6VTJEaW1qdU82Q05FQUcwbDUwQmVDQXBS?=
 =?utf-8?B?c2kvVmdPMUVGdDhtbWpkbm8yOWxzbFlrUHM1cmJTejlWd3BITGxkdTRJVzJv?=
 =?utf-8?B?L0NwRWVYNk9kVStneDVyKzRGVExuUWx2NzV2cURIejhxTGpST3RhbC9ZbTdv?=
 =?utf-8?B?aGVSN3Y3aWpIVlJCbHdSa1pSOEF1K2cxSXJOS044MkNaWUVQbndtNlBLWTlY?=
 =?utf-8?B?cnd1Sm1BNzBSeG9ZMXhrdjAyNytvNXIyS1BrNjRjN2M5dDFxbU9PcEprSnZL?=
 =?utf-8?B?Njh1OW00Wm5DSWFRTVlaeHJRLzJNZm5zTTJubjdEU1Uvc05Fb2tGUXFRQnZO?=
 =?utf-8?B?MmxUc2xCcVdHR0N0MUtGenNTVWtkUkRheCtjQUtFL1lrVlNwYzlWMGJJYjVu?=
 =?utf-8?B?TzdKSkk5RW9TVTJadDZtN0J2V1RkUHhiRXYxZWw0SGlYSTJUVTBuamZIMlZt?=
 =?utf-8?B?RDd6NUFLb2NkdFdrSng5R3NBNk9PRm1sUVZzOHU0SnhZZFVvbjEzcUovRzRo?=
 =?utf-8?B?aStrb0h1Wm1iYlBXc2FlOC9uUEJTTnd3eDlQMmd4OWlIVDdFeE9iTWt0eUhm?=
 =?utf-8?B?bFVQZXBlc2lRckxYazNPZlkwMVVOMUR0UTM3NDZpYnB2a2ExbElYQTJtYWlm?=
 =?utf-8?B?UUJKZGVBd3BIcDBnM203ejVTeUs2eFFIMVFjRCtUeWFERXlMZ2RtV0I1b010?=
 =?utf-8?B?U1NKVllHV0l4TXNGZERLM2RncDNTTmQ4cFhXazBOSGdsWVdMQ2VqY3lpemZX?=
 =?utf-8?B?OGRHNk04c3RRbld1ckRLaDRVLzZ1N1VRMjJRZnp2S0ZEUnhEQk4yaHB4WUlD?=
 =?utf-8?B?VGEyVFpaVWlqU2ozY0w5dU1nQmZ4YU1pckx5RC9lVmdIZWhTdnRzWGxpYXFR?=
 =?utf-8?B?OTNOVnBiamJMVytXNUNUQ0hXWXRlUm40MHJkSXZPaEZZVVM2SDg3UXFqWERo?=
 =?utf-8?B?SzhMNmdsY0JVejQzWnBQV2RpSy9DY3o2d2NZR3ZYOHlBY0QzUW9IdWJsTkVr?=
 =?utf-8?B?T0ExczZMbHpic0lrSDRTMURKamxyWjJMc0VaUHZveDZrYTdvRk1qRUdaQ0tE?=
 =?utf-8?B?WHl2Y3ltb2FlK2IwSk1hQThWQS94RHM5NGhTSm5FYngxZWJZczV3aUd5Uzhh?=
 =?utf-8?B?QzBaOWFXRk5YaDU1U1IwMVZsMERkMDNCSlB0cS9ZMElVdEZzdUl4bHNRK1Zq?=
 =?utf-8?B?eUFaR284Q2R1WHIrOUFPa0VJc0UrZU5neUx3ckh3NTJIcU12SHhxbGE0bjNz?=
 =?utf-8?B?eUpCWDY2dWxlSGE1YjFNRFNUbXdLZ2owTUR2cnVEamUrU2pBeFJvM25XanR4?=
 =?utf-8?B?UmlxVUVPMlRqK3dlTk55TkkvMTk4dWFhRmdIYndIREdmVFhLWUVSbW9JZ3NP?=
 =?utf-8?B?YkVYRWNJbHJlKzVodGJOek9EbFJLcUNVS1ZtSUl0WUovVHloVzF2cjZaMi9Z?=
 =?utf-8?B?dGpEOENpb2dYS0JYUndacU1vM0dEOG1zcXZlcTBCZG9RYmthdnlLRmdwT25H?=
 =?utf-8?B?bEppM1oxKy8wOXo5K0lRZS9qRFVCSUlFNktsbUpHNERzcTR4SFg4MElORXlN?=
 =?utf-8?B?dDBGVG5kWDV0ZnlNZE1QeGV4M0RpNy9VN2xNaUN1WnNrRjhOVERCMU56OXA0?=
 =?utf-8?B?bWk3MmZnUXR1ekJtYVVjYWtoRzcrRkVuOE1rTkczYkw1Ui9rSWMza0x6Y0hL?=
 =?utf-8?B?dlMyb3phN2dsakYvWDBsY1FUSG9oYUZGTDZSMWN6N3VKeWxFRDMvMXF0QUdy?=
 =?utf-8?B?cEtDZEZUWVhPRThZMklpN0VyVXQ2RzMvdUIva2tnQ1FlaC9YTFh6VzBEUWQ4?=
 =?utf-8?B?YkJFQTIvdVhsc1MzMEFlT2lkL0JvQjJ6L3dISFl3NjlJa205VS90cFB1VjRS?=
 =?utf-8?B?OExMeHNzeUlTR3dudWxDYjFTT2NDRUJ4WlZZcWtDcmVQeUlRR3FjWUJydGhT?=
 =?utf-8?B?R1hXb2JUeW9wbVNadjgxN3RveVlQYzVJckl6YTlPZEdwOEIzbUl1ZGRZTlg1?=
 =?utf-8?B?NmpiNjZROVRtSkFLN1FORXQ2V3ZyUW5CRlVOOHY4dUNCZ1Y1Z2Nrd210S2VX?=
 =?utf-8?B?anBYMTVjQnM2c2lvM2FHVVJsRGoveExzK2Q5YjNhTDFPZTRieWljako2NXht?=
 =?utf-8?B?SEVVU1ZoMnBQM0Y0ZHNQUklRYnJnVDRhUkZ2cWd0blVvODNMUFI2dFcvb2lB?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd8a96d-df0c-4dea-a2cf-08dbd47b5f8a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 10:24:15.4603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6MhIufnfcrB6Pf+/Izlxn9etNzwwECIAh5hHD9G/YVCFfk0dRmYhYpsR7hMmAqGlA9qIBrlLNCe6D5O6tkBx488KPuYcN6gQ+ICCAEuZTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4827
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.10.2023 18:29, Ivan Vecera wrote:
> Add another helper functions that will be used by subsequent
> patch to refactor existing open-coded checks whether the version
> of running firmware and AdminQ API is recent enough to provide
> certain capabilities.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_type.h | 54 +++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
> index 050d479aeed3..bb62c14aa3d4 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
> @@ -608,6 +608,60 @@ static inline bool i40e_is_aq_api_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
>  		(hw->aq.api_maj_ver == maj && hw->aq.api_min_ver >= min));
>  }
>  
> +/**
> + * i40e_is_aq_api_ver_lt
> + * @hw: pointer to i40e_hw structure
> + * @maj: API major value to compare
> + * @min: API minor value to compare
> + *
> + * Assert whether current HW API version is less than provided.
> + **/
> +static inline bool i40e_is_aq_api_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
> +{
> +	return !i40e_is_aq_api_ver_ge(hw, maj, min);
> +}

It feels a bit off to have those helpers in i40e_type.h.
We don't have i40e_common.h though so I'd move them to i40e_prototype.h or i40e.h.
Same comment regarding 1st patch (I know I gave it my tag but I spotted the issue
while reading the 2nd patch).

> +
> +/**
> + * i40e_is_fw_ver_ge
> + * @hw: pointer to i40e_hw structure
> + * @maj: API major value to compare
> + * @min: API minor value to compare
> + *
> + * Assert whether current firmware version is greater/equal than provided.
> + **/
> +static bool inline i40e_is_fw_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
> +{
> +        return (hw->aq.fw_maj_ver > maj ||
> +                (hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver >= min));
> +}
> +
> +/**
> + * i40e_is_fw_ver_lt
> + * @hw: pointer to i40e_hw structure
> + * @maj: API major value to compare
> + * @min: API minor value to compare
> + *
> + * Assert whether current firmware version is less than provided.
> + **/
> +static bool inline i40e_is_fw_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
> +{
> +	return !i40e_is_fw_ver_ge(hw, maj, min);
> +}
> +
> +/**
> + * i40e_is_fw_ver_eq
> + * @hw: pointer to i40e_hw structure
> + * @maj: API major value to compare
> + * @min: API minor value to compare
> + *
> + * Assert whether current firmware version is equal to provided.
> + **/
> +static bool inline i40e_is_fw_ver_eq(struct i40e_hw *hw, u16 maj, u16 min)
> +{
> +        return (hw->aq.fw_maj_ver > maj ||
> +                (hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver == min));
> +}
> +
>  struct i40e_driver_version {
>  	u8 major_version;
>  	u8 minor_version;
