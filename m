Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C54A7D17D3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjJTVJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjJTVJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:09:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097E910D0;
        Fri, 20 Oct 2023 14:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697836157; x=1729372157;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rt8O7XlpB4afsDAYwHKIstdoBb4nGvURt45fkCkg4FI=;
  b=kRj67JXRwZHixZIdxrwQdZQrMy7BnHRO5s2gtB9b9zHGE7beHOpPrRz8
   qaMeNhHyFYY/Yo8qyK20mfYBy4fHh+m6Mj7i5uZihuACYYe6tM30ki30S
   C9zYaB8g/HzY5pQE91cDNSga2IZ1W5Z3it9mh9LhzBCiQiRSgYogxm8v4
   xlhUBKSmgW7vqEJdU6Y3cd4voGL7L2r4uZwdm7o980hmSjRuXB+zq27tc
   qosWJyFDILKPphHFL1F1AexE67KTs22sOw1DWlFE114EvEKODmoyeDAEX
   hCqC3D7sZKoLNenc4n7zEwxO3IU3xnaSj1MjRQvLjqSA3NSWWdFAgz/W2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="472797630"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="472797630"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 14:09:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="823379076"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="823379076"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 14:09:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 14:09:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 14:09:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 14:09:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BF9O7v9Ft2h1g25imwHI3aviCxcPPvsiKwKAhw0UK0DJZexWbfGxGS5rK9Nu+lYTptkKbjJkjwfNeDN+i6lDC3H+Z/2+IXIAyyNYYAmz32jOmrOx11A3OajpbvRm6a6rw91d9T0xJZV1oqr9m3Xt4jjtSALg6hz3OruNlzMMgvXbRzE3eS41VRpax32TZzvxcBjue4Xi4e121zL83LMxjciBBejxs2cfhG+v8uJtM+lrLBQP+IO/ky1fsGCmBXRAA+3pk4WPEI5EyX9T/DoI16ZDMc840MypYNWirk9ExsvrdyB1cTMFk2ZE+ofIA5k2hvbFFDDymIqE82BOKn2yHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VSs39qRDQvc1OM6e+2rgRvo4j94tgTtNYPhd1F5fdo=;
 b=eRmG19QSEjq94Ri+ZgpopYChqwjdGWxkcJLkGedsfLT+tipao5O5PKfUg7y59z/4yl2vC9EJrwg5kaEorjte5aoNcaEQd4ZrWktxkpjlE9gDXPI08kSPFjooW/a2KTmp8bXV6KbPlFWLZarrCkxbq9eWXyQF/ouN5w27zfB32x/qFDohopLhWmeIGH0VE5qzZCpzGDRTITGw/oJfrh9SknMA4OzxqyGAlUj4s/bAWIXPaWHHvwPlXQ3yiBdgioF+THHK4qTuU4an9A5PqQueuqT1CKzTPyHhDQxlI+dLCUIrjYmMIzCDC5tctjaoiEXisnzpf5lycYK5PEOCJ23ChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM8PR11MB5704.namprd11.prod.outlook.com (2603:10b6:8:23::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Fri, 20 Oct 2023 21:09:11 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4%4]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 21:09:11 +0000
Message-ID: <58d18354-dbd6-47d3-93a8-ba0446dcc8f6@intel.com>
Date:   Fri, 20 Oct 2023 14:09:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i40e: add an error code check in i40e_vsi_setup
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Su Hui <suhui@nfschina.com>
CC:     <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20231020024308.46630-1-suhui@nfschina.com>
 <be0b618a-4732-467f-bb99-f623fe4da962@kadam.mountain>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <be0b618a-4732-467f-bb99-f623fe4da962@kadam.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:303:8c::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM8PR11MB5704:EE_
X-MS-Office365-Filtering-Correlation-Id: 011f073d-2ca7-4272-1f27-08dbd1b0ce5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3CxSn8QZZAX/Aodi0I8kSnJgbFWhW/DRF/pyLwySxLWJP9bu69ONeDFCyR/HJCAt5Nt1dUhQ35irVauV9NJJvQO+iH02shZqbEJi3rZLJHa5olfQV2bak+pvfQqdaGsAiiuQtjP0GYYUnW21GHnJj3Eeh57nXNHzj7bm8747zin8pjiJqVph4EppfX84Qb+Va1zMBA4pUk6xI2VuMFC5zr5Gb/va4D5QWCa8aJ2P9R/DEM1w3F58z2GDFfIUlL/nPoL+bjwmD5cD3Rv3EEgtTGiT2bBBde0e0KXn9cyLoR4DHtkznE6bsnSh61ciyu3+MipyrDYtFRkCRMV3ELGJ6eyIgdzLLWtW5E21eqNaEVPGuHHy/sxc4st8dEFF1Unlrx/niUNO+tGhSHuiexfOMud4lP3HYC2kZIYsFKwEqCnIjNoc4wAmeKxxHN+DFaxkSbn9mB9F7e9wqL/DAjSrTnrNM/BODqf9kFbmq6bx9IbIn3Dh8/jJjUMoDVTYpR0id3SWFqEcLIv38kd98oNKSgX9I2paWiF3IlTKFnVvrUZtvo4fKbNzaMYLYZaRCMEI0p8b46x8YOFZEhQW2onjSi3oqHyV/6isPNnExYdjWDd8o3g9MVNOkhg7wxfhGGDLl0uzOKaHvldoNZ0fI+Jekg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(346002)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(31686004)(7416002)(4326008)(4744005)(8676002)(5660300002)(8936002)(41300700001)(53546011)(26005)(6512007)(6506007)(2906002)(38100700002)(2616005)(110136005)(6666004)(31696002)(86362001)(36756003)(66556008)(66946007)(66476007)(316002)(82960400001)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlJ4VVFNZXYzRGRRMVFrSW1xNUd2ZTh3QmRuSXk0U0hDcDFXTXR4MlNBdVow?=
 =?utf-8?B?MlZqOFQ0T0cyRDFFN2ZRM0VraU5BWjZ0cEk0dnJVUlExdGtiZnVUYTNZN2Rm?=
 =?utf-8?B?UHh3aUlhcXF3NEFRSWdTSWpPOGpkQ0tKUGU0L3FEMXB3YnVUMENOOXl2cHJI?=
 =?utf-8?B?eW9ZZzd4RWwyT01ObVc0ZzlvTk9JUkdHZ3AyUnEyeXI4bWg0c2pUUHMybDkw?=
 =?utf-8?B?VU5WNnc1R3ViUDM1a21TNG95UGVodXh6MndLaTdwcUFtdVdvU3Y3OE1idG44?=
 =?utf-8?B?MWRUazJybXBYTllkZnI1eWxqNStKNEhLNXJ3dVZIZHo0eEZVTGpCd0dQZWZr?=
 =?utf-8?B?eGVPcFlHYXFVQWNSOHI5MDdGSlhzbWQveit1WGRQV0pGSmJtL3Nudm5RcEpP?=
 =?utf-8?B?cnIxdWNuUGl4YlhTNTVRVHVGTGtMN2QrZ2RHWFNwb24yNC9OQ2JLOG8zdVEv?=
 =?utf-8?B?anEwQ0NtYWJzNmRyRFpOZW4ydHZUSU1JTVEwb3VVSThvWlhKT2J5cS9Nek5H?=
 =?utf-8?B?NVdEVGxnYkoxcFNYQnJtV0lScU1nOCtSZWZ2ZzhYVEtGandJamhwVzJENnRX?=
 =?utf-8?B?M2tuT1VIZnQrMFJNWmJFeWZJT05Ca0JHOFEyaEJVN21Mb2JyNUROWVBSTk1s?=
 =?utf-8?B?YXdpZEhXRXo5YzZncFFHZ29IV2ZEYzlRWW4zTUFmT25pczJyVG1aVDd2Q2pW?=
 =?utf-8?B?c0tBT0ZtR1J4UXQ3eHpGQ1JqVUhxamVtWDQza09lU2Y4V1Q1SjQ3R1puN0Zi?=
 =?utf-8?B?SlI0T2swMlpBSDFWUEpFcndYaGlkZGMzWTNvamc2T1NGbDhnOUZ0S3ZtUEhK?=
 =?utf-8?B?TWhDQm5LR2RzMEtETHJVcWV2YlphcVJaZjRsM2s1U0R1eU1MT3RMY2NSajJJ?=
 =?utf-8?B?UFVNK2JaRFRPc29VT1FNYytWMDhubEJ6U2NmYmhOU1cvS1gyMS9iVWxYV1Nv?=
 =?utf-8?B?QTFBWDN4eWdFVVNvdGs3OTFWblU2emxZYkNySVNhdkxFaFRoY0VSWXRCbU81?=
 =?utf-8?B?cGhaakZnbHBzd25nYnh4dGJNTHVZeE1yNTlVNGZGQ1ZBclNPSjk5N1RYcTNr?=
 =?utf-8?B?WlRaSlZvMVM3VzBkTzBUSUExMmt5Y1lPSDZJeXVmeCthQ3pwa1JidkhkZGxj?=
 =?utf-8?B?ekh3NmpRL1ViZzk1Q0ViWVZmcC9oc0NHMDN0SkYwa0dpWEFGTXZLRzZQSUlG?=
 =?utf-8?B?T2NndWx2Tm13Sjh2eWExek9XYUxVNkFNcmZibFBqaUQrVlJmYzRGNi9tRWYy?=
 =?utf-8?B?bzRub0U0dU9mN0QrUDFxRC9vamtMOU9vdXZWZUNYUE1haERqazVYbHoxZ05t?=
 =?utf-8?B?dnFpOTdTRXVnOWp3aFJEWWdmbGVIRmttd0lQalJxUEQ3MEpqOFNSemNYajNa?=
 =?utf-8?B?bEJaeWVWZjg1aHFSbGoyc2RrdWdvc2lwcW5XTWc1OVkxL1lQbVRTbG9iSkNj?=
 =?utf-8?B?UXNrS3dGM2hxVDJkZFdxK2R0TjlIaklXSzZRb2l3dFBaZk1qWlIySnpTMWZE?=
 =?utf-8?B?ZGpFNzZibjNSdHNWQkZyQkE1TTJ3NUxxQWlLbTBXdXE3ZFN1dlJFK3BwT2kr?=
 =?utf-8?B?azQzOFZ3dExNLzUyMC9wenNmT05yVUlNbVN4NSt5OFk4eEFKY2FPcjBQR0Fv?=
 =?utf-8?B?VVBQTVgwalAySFhBRG5oNm14MjV4R2s2eG5rT2NXdWFCZzI3L042aENsNXl2?=
 =?utf-8?B?bUJtOWtrSjR0REZOQmhqd05kMFVlZ0dROWtrUGtYWXBsc09Ca29tR2N2T0I5?=
 =?utf-8?B?OG1VMGdReFJacG9qZXdGdVBRRWZkQnB0RklTVUE4anRvSnVaWlF3dzN5RjZF?=
 =?utf-8?B?enhPRitoRHozeGNTajVUTkJyd3k2WjFLbk1jK0tBbEM3WEYxdTNya2kycUpK?=
 =?utf-8?B?K0FoY1NYeEIycXdBODg5ak9RSEhvVGxiWlpEQytnUVVUZTk3OUh6VUt1ZGsw?=
 =?utf-8?B?dTl4Q3ZnMEE4THJXNUJpVVFha00vZ1hCb2IxbVJUakU2WE5FQlViSjZoKzU1?=
 =?utf-8?B?UHpsMEFVRTZrSXpSSDhwMnEyUWVwOHRiNkFDWXR6V1Y1RWd0MjZkVlE0cCti?=
 =?utf-8?B?d2E5WFZpWEoycW5XT0d5SVhFTHZid3FNOG5oQytycjNJUVk2WlBqTTdhS1ZP?=
 =?utf-8?B?c3QrTHJiS3hMdk1jZEt0eWQ4eDBUdGdUQXBqeDJ1RDJabTF1cDBhRnZGVjB2?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 011f073d-2ca7-4272-1f27-08dbd1b0ce5e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 21:09:11.1810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZbsc7IrYwME3OEOo1+4rsG5ImfjwT1RY0MjQerPlvUAFMeF8gMWTWhNZeikynRUzP8F1+CRqLGHpN32QSW8JdWXKuKs7LU8qqqNVTmIBBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5704
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2023 11:56 PM, Dan Carpenter wrote:
> On Fri, Oct 20, 2023 at 10:43:09AM +0800, Su Hui wrote:
>> check the value of 'ret' after calling 'i40e_vsi_config_rss'.
>>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>> v2: 
>> - call i40e_vsi_clear_rings() to free rings(thank dan carpenter for
>>   pointing out this).
> 
> Looks okay now.
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> regards,
> dan carpenter
> 
> 

For some reason this patch doesn't appear to have hit the
intel-wired-lan list and is thus not being recorded in patchwork for IWL.

Su Hui, would you mind please re-sending this so that it gets picked up
by patchwork? Otherwise I'm afraid that it might get lost inbetween when
Tony returns from vacation.

Thanks,
Jake
