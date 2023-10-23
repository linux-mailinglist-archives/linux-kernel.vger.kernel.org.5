Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D497D4281
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 00:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjJWWBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 18:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjJWWBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 18:01:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1317A83;
        Mon, 23 Oct 2023 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698098490; x=1729634490;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1zyuNOXsUCyRSn9PDztBwRVa6GDXMO8TEd1wyFf8YAk=;
  b=kpEfl8DK8C5gXBP0SOSYvX3a8qUNunyk2+54HXLga2mJYh6YFkhkCN+l
   nEVJOuGGayBsHWYziQWfNioO8X23cnQg7o8TUglBF+4+0VGiBCY4bADxA
   +G/UXmJ6wom92PUgu6LzQDQuKqIpY3TSTL1QvBIbAZtBP+YZv8NEXs/31
   6jwGzItcGlK9mdAh2AAIp3O6FepUMrW7pl/2pfQVQ8TBKHILWeVomWvYW
   eLIEdoMN6Yq3BzSFA9N5Y3VOQZJdFrCTDsvNj2/MYxN+LVe/5jf1WVADa
   r3FB5J/1F/8dWm6IeXDSrFMI+ND47y8q8XkV/RHgC9zLX1SGPXAvBsmLx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="372004025"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="372004025"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 15:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="1089630195"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="1089630195"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 15:01:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 15:01:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 15:01:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 15:01:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 15:01:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KILGqgAowXtAvst23UmrZcj+5og46AfRa5H4OFU5pfP+5CxJLuEXYQRF8D5JEKLZ4MSz4OsuQl3gl2j95OcDIZANC4AirLAbzxGtXb4rpiZglU/sGMYyIS6ggXsyCYnVhillzf/bAc1OUarCcWEAnSwnphwYj9z3pnzNOP/uMxV9ttPAxfhUJewxMbb+htyEzot5lrmp0wWXAL6cfAnodWcJLgRUZPhqzkpy6h8BCKy/gH16mdGsXRpbnxdAv7X8/29d5Ny0dTKwWiWcywspkN8L8ObxIKtig/AiORJOp+6PW8/3azZh5n1hdaRu87m+HpYKwm/kFMBI4paaO7QsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHDH7fvV8YM4OYAtVr843oqvWf73Hnq6oz3fCF8gydU=;
 b=lF/dRZKLBa5B5XHGI70H2/+ngIByxsAO1ZOWPvm7/aRDcEhHW/u549Rh35dJ/7hjOPRJ2aw6r2wUnOmJKK2LLWmDmc5Uq1DtUZWAfH41+c6IU+hJ/DSxb4ztXHD07HYxfePZooLeSyeXYKFuEuCyQ1SPMc3pIRy1/QEQ1vyJBhABSpmlgACPgMhKRLN4G/jhNubDT7wbcmKMZb+NOMT7HLrBZKjnqmxD7ZlSBV+IczcvC3h1iN4cdsvPZmKisN61vwAsNEHcAX8oNmPD2j2EDn3nJANN98RxrqTKJJ83QyOgFPa/ZyG2fa5DR66W3xX8KHPMC+gN3pfAUICzzQDvVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL3PR11MB5700.namprd11.prod.outlook.com (2603:10b6:208:33f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Mon, 23 Oct
 2023 22:01:26 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1%4]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 22:01:25 +0000
Message-ID: <7531aae8-c523-45e1-a9e3-bdecb485a00b@intel.com>
Date:   Mon, 23 Oct 2023 15:01:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 2/3] i40e: Add other helpers to check version of
 running firmware and AQ API
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mschmidt@redhat.com>, <dacampbe@redhat.com>, <poros@redhat.com>
References: <20231023162928.245583-1-ivecera@redhat.com>
 <20231023162928.245583-3-ivecera@redhat.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231023162928.245583-3-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0347.namprd04.prod.outlook.com
 (2603:10b6:303:8a::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL3PR11MB5700:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d4dc7c-888f-4766-5d6b-08dbd413992b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IC0pg3JUf7h0XWrPF20KyXogVxrAcjoZ7WVIurLEbvuuPy5+aysWprWJ3MdeesJeOvrYBj02oxlRXpykn1wRZITcK4YFlG87dj+ArHBcbjRQ7ArriOM/hN4S5mAADAD45ifCX6yaQ+3JDYr6sVHwJBzURHvZcbpA8yBcS5lDNhYRpGF/X7NJYHvnjm5Ui2lzouATKvlyVxsWHMc2mcbYnshfuD9viD0o75Etg0Kzch9v/sJuZFyK38g2xcIBSQ05hVJB74rgsS7xLDvGxysNBe46+rmz3amaEzVY208Hb9x84dnMYDqm9EAOZ7O+/kR30HGHoZHadR1wkBP5Hy5vQrrW48WGYZsAIzbriJZXO2MPiAvJNp+WhIpAwitxajdNoNT60IMbJAKQtU2UTKNl+m90WzzqycNSVhSj2Asw1md33KOrLgp1Q87fxUKVw4FGBkN10Vu/+CM23LErSfM3V76eKrV3Y5QhezwrGQ6qR6856VzpsYnTGy4fo62gfQJYSlVgawMLYtI30vSqBVHfRAYdwLof2Om0q3K1swj/6ILfRIuywB8xVg3wbXISwM8DHlbpwlSMwEQrFngryHdqMzbrpuX3PUD383GMgeAiuEfkYcxS5RScGdKvKBckOdiF1IunnXCKp07ihOkbCPUeRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(26005)(31686004)(38100700002)(2906002)(86362001)(31696002)(7416002)(5660300002)(36756003)(4326008)(8676002)(8936002)(6506007)(6666004)(478600001)(54906003)(2616005)(316002)(66476007)(66556008)(82960400001)(66946007)(83380400001)(41300700001)(6486002)(6512007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUdhM2VBUElZMm50SG5nZW9zS2Rwc0V3OERUeUZIK0UrOWlVTHdNSGV2ZWVO?=
 =?utf-8?B?MVd3eVFwOW5nS2IvSkpNS1loL0ZyNHZ5OVYzSU9Ka0pBOUR1TUtPWmJVNDZn?=
 =?utf-8?B?eStROWNZTmF0bEF1bU5UOS9ncHRvam5NSnJqeEJMSXdTY1p0cXp2bG1QRWtz?=
 =?utf-8?B?aklGYzBicU9zcVVxSjZRQW53TGRQMUUvRVVHNFlJM0xIUEVWQjlkMDdSTi81?=
 =?utf-8?B?SEcvUmRvcU9DQ1lwajdtTHFXa3NEUS95djZRRkxFakZJRzQrZFY0WWREa3d2?=
 =?utf-8?B?OVhISkZMSjlaMk9ROW9mdnBXcE5oMGFmNkVTMXJQMHJKYkNxQWhnMVV4UDE2?=
 =?utf-8?B?c3MyWXgwMGZDSUFpdkZEMHR5TTZXUjFoVWM1NWY2OWF4c3VDVEp1QjZUU1c4?=
 =?utf-8?B?T001Ukt0bTcvc3hFT2h0aGdsYzRvVlBsSGhSazhkVHFjYXh5MGY0aGdQQ0do?=
 =?utf-8?B?YTVraW5XN05POGpvVFpRUzJJUG8zNHhEMzBiZVBOQ3hLcHNnTFdzTlZWTjVa?=
 =?utf-8?B?OXlncDR3UDVkUkl4dmo3YjI5RDUrVWE2OFJKWHdBcEVhTGtNK1JqR3lGZlBw?=
 =?utf-8?B?d2ljNkN5ZFFjMFJKZmloeEthRlFUR3NoUE1mVnZGZ2M0cVRXMms0VlFEczVi?=
 =?utf-8?B?eXJZOG13eHhlTmNvNlljYXNEKzhLN0gza0pmL214N2ErNEY0WUlObUNFQzJX?=
 =?utf-8?B?VFRPQUZYS0NwMFpZaDBEQUFBcHhLRzhqRUp6WjdYZW9MZ1NYbjluN0dhMVZQ?=
 =?utf-8?B?VExHaXJ6UndJMXZ5eWYxb29oamhtV3VyVmlIT1JUSmg2cWltQTRReHZmTVRE?=
 =?utf-8?B?VXFNNkhlVUFjQXhyY0ZkNGlYU09kaXRFYlU0eUZLKzVuUjVMUnlBYk0zNXZV?=
 =?utf-8?B?OW5qcUtrQ3VwaHJqWm5JTG9SMzJOOElZTjdvamJ6dEVSbTlGUVl1WCtUY256?=
 =?utf-8?B?ekRReDhjV1lqOTY1eGlDeDB5aXJtUFhESGJSTWQ1dTRPRjVqM3YrT3gxc0VM?=
 =?utf-8?B?OUJmVExMQW9pY09tNlJScWMrTEN2OEVMd284RnhxTWd0eHFNaW1nVDZXeTI1?=
 =?utf-8?B?L0k1WXNML1BXNU5KM0pvS29KOXAyLzlPUjRKeXAvNHBEbDRwYmpSSzVGZURn?=
 =?utf-8?B?VU9KRzVSby9NSGh2bzd1VmdabkRkMnVHK20yR0xMOXlJaWQxamdsRXQ0c2ti?=
 =?utf-8?B?aUJJZlQvZlRZYmRHRjBjcGJRVmgxcUFYaVpNVnZ4M2E3aGtUSXVLd0Vkekp3?=
 =?utf-8?B?K3lQd1JMN1FiL3JjdmxyNlRzaSsvQ2NxWmRBVHBncUROYk9zbjM4ZDM0MmxQ?=
 =?utf-8?B?bWZaOEtWWm9ZQUlIc29UYWRXSTVndjE3QlF1aWszTEhwT1hoMkFFc0N0YkFa?=
 =?utf-8?B?QWl5c1lDLyt6YWdVYkkvRjAzYlVYdXdrWTRtVzRwbnIrZGw0R0hZTmk4TkN3?=
 =?utf-8?B?elBlOFF6UkVQWFE2RWgrQnV2WlFoTSt4SDdVRk1xaGpnSlpzOU1vbnJMNXNo?=
 =?utf-8?B?TUpmc0pRVjdTeStsVEQ3Sm50ZEFKSUlrNlhiR2RSNitxV3BwYTN2L2ZwSWJL?=
 =?utf-8?B?UTg4eGpKdCt4ZnpPbzd5WnkySGRMUnRkejNqTFNOUWNwSDJQaEora3REM0Vw?=
 =?utf-8?B?VzErUjBXeTIyN1NiZlYrNnpyMFBFemtEWVMyVUF6WHplaC9MUjlrS2lVTVZO?=
 =?utf-8?B?cU8xMDRxMlRKWi9tTFZIUFkxcE1zSVlsTUhFYkloSjlyaTRySkVGRFVYKzg3?=
 =?utf-8?B?QXZTT3pSbUl1MFBlVVhUeHBjK01KOTNmYU5RVlJRS3lpQ0tWWnh3a2w0Tno5?=
 =?utf-8?B?ZGkzR1dxNllEbGwySDRkaEl4SWlpblZpdStXRnptRS9ZTmhrdVFERTU5QXRS?=
 =?utf-8?B?OFdqdmsrckpkOEQ3QTdseGFOZ0cyK0c4eUI3bG9Bd1ZFU29IU1Y4V25rdE5X?=
 =?utf-8?B?d0hWRDBFUjdlMDVmU0hWd3lRYTdRZ3JIUmFmUTlBUFBYUUNRbk9vMHMrcTE4?=
 =?utf-8?B?OUFrNFB2ZXByZjJuYTB0NUg3OHVuWGFaRnE5VjZ0cE1QWjNCN2YvUHd2YTc4?=
 =?utf-8?B?a1ZTb2NCNy8zV2t2RXg3dTZ3N2YwTkZieDNERElvMVo5cklUbkpGa3d6WER6?=
 =?utf-8?B?RUtEalZlaSswVXBkNE1uSmhxOXFYRUlzMmNOaXF4dzJSb3ZWeU9GM0lMemk2?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d4dc7c-888f-4766-5d6b-08dbd413992b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 22:01:24.8364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgQGfkEguWvFzuyy3Rbiv6fQuS2edPBVUEUzyP/foRRKGYpFhSjFgo1PCPgiQh1FsIBP+mhoIQ2YhCUtcH4uHpaDkna+h8S/RhwALansCrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5700
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/2023 9:29 AM, Ivan Vecera wrote:
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

This has a bunch of checkpatch.pl warnings if you wouldn't mind fixing them:

> ERROR: inline keyword should sit between storage class and type
> #47: FILE: drivers/net/ethernet/intel/i40e/i40e_type.h:632:
> +static bool inline i40e_is_fw_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
> 
> ERROR: code indent should use tabs where possible
> #49: FILE: drivers/net/ethernet/intel/i40e/i40e_type.h:634:
> +        return (hw->aq.fw_maj_ver > maj ||$
> 
> WARNING: please, no spaces at the start of a line
> #49: FILE: drivers/net/ethernet/intel/i40e/i40e_type.h:634:
> +        return (hw->aq.fw_maj_ver > maj ||$
> 
> ERROR: code indent should use tabs where possible
> #50: FILE: drivers/net/ethernet/intel/i40e/i40e_type.h:635:
> +                (hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver >= min));$
> 
> WARNING: please, no spaces at the start of a line
> #50: FILE: drivers/net/ethernet/intel/i40e/i40e_type.h:635:
> +                (hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver >= min));$
> 
> ERROR: inline keyword should sit between storage class and type
> #61: FILE: drivers/net/ethernet/intel/i40e/i40e_type.h:646:
> +static bool inline i40e_is_fw_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
> 
> ERROR: inline keyword should sit between storage class and type
> #74: FILE: drivers/net/ethernet/intel/i40e/i40e_type.h:659:
> +static bool inline i40e_is_fw_ver_eq(struct i40e_hw *hw, u16 maj, u16 min)
> 
> ERROR: code indent should use tabs where possible
> #76: FILE: drivers/net/ethernet/intel/i40e/i40e_type.h:661:
> +        return (hw->aq.fw_maj_ver > maj ||$
> 
> WARNING: please, no spaces at the start of a line
> #76: FILE: drivers/net/ethernet/intel/i40e/i40e_type.h:661:
> +        return (hw->aq.fw_maj_ver > maj ||$
> 
> ERROR: code indent should use tabs where possible
> #77: FILE: drivers/net/ethernet/intel/i40e/i40e_type.h:662:
> +                (hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver == min));$
> 
> WARNING: please, no spaces at the start of a line
> #77: FILE: drivers/net/ethernet/intel/i40e/i40e_type.h:662:
> +                (hw->aq.fw_maj_ver == maj && hw->aq.fw_min_ver == min));$
> 
> total: 7 errors, 4 warnings, 0 checks, 60 lines checked
> 

Thanks,
Jake
