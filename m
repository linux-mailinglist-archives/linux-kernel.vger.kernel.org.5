Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24DA7705DC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjHDQYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjHDQYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:24:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B431BDD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691166243; x=1722702243;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UMOg9uFnWWUQxMZ3Rj1bkJJYQ3M354D0eDULcjeLyYs=;
  b=d2n+TfHloC/mBNDFEQCDlBeg7QOvNOeY5XU/J1JhYVX9Kdv2X3MtwPg4
   mXvq8WA0jcx0hVaWXkD0N/28/Idv/juXh/hYL/YOK6SESHYucv4goiVAU
   TXUSRYGDWVhO2f8D/XGNdydcYJHDlLAdbIvpgaqGy7AN7d1p0PdxTozzP
   m+KB5sqq8VN+BXpzJj+C2n1i5OWNSxkgzYRRq5MJAG4wdItwdBwbp7Kz5
   Y2MPjl2v4yaceGvMJLIpi43/N8u9Qg/C6UWqrA5cfbMIhDk3BxwzMz5oc
   zukSq+55JJEoYxWhHHq0M9L0KQLNGpyT4uvKAfRFpb6LM/S9sYjDKiInk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="370176621"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="370176621"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 09:24:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="820186234"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="820186234"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2023 09:24:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 09:24:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 09:24:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 09:24:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 09:24:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqQjmTnAUK2wPQGTrOY0JFl80BpV/eoY+oLJsoDHaDP/pxgj8gR9rAA9NAUeAiANMNdhsYXC3hRcy6js9NGDCULp2oiZwyZQZLn83Vd8kq9tgio48O3tNzD3/u2TcmJZBR+zlBHUrgt0IigWRHSkdYvCMv6fNEkzxjeg+0n+2qszGZkaxDYyDBRyNj4PwNPRM0l6XOs59Sy71IwXi3G+3RVUeXqjRSm9JZ1605DTjrHHSoktxCnTXQleMyRbk4E12576iW/2FKqwcSwLHdqMhZMGwi0aiLfevktFvqdhL03ikSfvyPgR+AYNamsi1sIaB6a7iRoybM7RFFXpC0KiIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wT3M81h+6Q4C+ocaD3sp1CfTIXauNb+7D2GX61duwXg=;
 b=EXgeoEb6ZmhCszTOlw7EDzbA4ISKexgJS5xopu/EzNZM+rXJSeX+FGfQMDpo1Ya9mzLduNh5VafMkyuFZUzkxQd3ulNfndnUn+S9nn8iYCsb+Vx3LTuPVUDwceHwUZ2JKirmURloyPtWklYeLmedUc/v00/lwcKaMeVZf3Fnd4XTqG5cwJqygqKKmVoyJQkTMTyDVR+yjdk9AqIBmL+iBKQm9z4Tgp599+I0zV47uW3CMCki2Ei88f99rKD2OC7FkHo6pJLSuT52o9976GMYsrsc8oF0KdGxnFZk2GjFDxtRCLzQZH1K+/P6q/TOHOOLjrBPBaVKi+IrLTEFGU1joQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MW3PR11MB4666.namprd11.prod.outlook.com (2603:10b6:303:56::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 16:24:00 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::70ac:fe46:e033:41be]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::70ac:fe46:e033:41be%4]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 16:24:00 +0000
Message-ID: <0e99e131-fe4a-a672-9bfb-ad00f7dbe66a@intel.com>
Date:   Fri, 4 Aug 2023 09:23:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From:   Sohil Mehta <sohil.mehta@intel.com>
Subject: Re: [PATCH v2] x86/microcode: Remove microcode_mutex.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
References: <20230803083253.VGMnC9Gd@linutronix.de>
 <7f31f938-cd4f-bb1b-d44d-57adabf62c51@intel.com>
 <20230804075504.MxYvbNle@linutronix.de>
 <20230804075853.JF_n6GXC@linutronix.de>
Content-Language: en-US
In-Reply-To: <20230804075853.JF_n6GXC@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:40::15) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MW3PR11MB4666:EE_
X-MS-Office365-Filtering-Correlation-Id: f023d805-5233-43c7-4644-08db95073577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9BFj8HGpE/qE2fjPwxBwD23Xpf5ju5X/4f3oQcpmsyN38Az8/jnrgM+QRlQg8f6mz6e656r4fCsEimefH1NFS6rkeUtJqXvM7DWNm9jDGTIRzBTl+ZY+my3vHuuOC+5X1ejPP51umbDBiDH7FxnfxL2XUwqsmmFtVXmUNyZiEwMZbDv2Gk/npvdPII9sF7oR62SJLLMOe1rfcIoJuIUXdWQI9Uoy84e93uQAhPGBKZksXHV9ouhxYK3HFljtVzjxuWfZK4DtfRERVRFt5zsk73A6+NMJYYBAMRnQ0hF+S/dgNjBW0bO2XqUJQIKbqUWTDTFdwEm1didLqXnTRLplhHnBZahZyGPC16h0oY5zMw95Thrmx6FFB2TO5wrGHoRBCpLRxBJQpRtaqzLVThRjJ0Svc3EgZfla7F3NBalckm8sQZp/vg+cgCuCeHXnhypqOPA4jfQ/TA+/9IUTjpPfxCD+vqjKyXuyQnvLAu4JkkcpoTxEc78ho+2rwyL0Urhmmrrmt4rWYA9J+NSWi536vie9guiK45IZOJ7Cth1m+NYUrwtFPK1dDHwRcOrtlh3P7guMi4vnxc+hm7+hC7Uh0B0kk4oRZVbE1KWQpK2OO3MJUY1igcHDEy7qUhg+HaPlkL1BOF/Xvv0EN+WR0GR+ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(376002)(346002)(1800799003)(186006)(451199021)(8676002)(8936002)(4744005)(26005)(36756003)(478600001)(6512007)(31696002)(86362001)(6486002)(6666004)(31686004)(316002)(41300700001)(5660300002)(4326008)(66476007)(66946007)(66556008)(6916009)(44832011)(83380400001)(54906003)(2906002)(6506007)(2616005)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1BjZzNyVTRqV3dmNDBPUFFxUmp1R2NiOWdUL3lkZkRSVFFQbXZURitHU3l1?=
 =?utf-8?B?cGFNSUJ1Y1M1MDRxRVNXQlp1NzhYOGMxdE5SbSt2dDV4N29FWENRVW5lWWZs?=
 =?utf-8?B?Y21xU28yc3MxNktKcFQzZjBnOExYMnVIOUloelU2WHJMNlV1NU1QWHNiamtL?=
 =?utf-8?B?S1h3ZFJ0VWNTbVFHeXEzeXFXbFdyeE1vOUdhSGxidTZNcEQ0bGJMUVgxR0tw?=
 =?utf-8?B?YWRZbjFPMWR5RWt5NGRzZnFjeXZXMGxaQnFuOTlrTlJHUGUrdXRwdXFDVENi?=
 =?utf-8?B?dkdCNk9HTVJiaW91c3RCckRlOTkzbjJ0T005TDJ4RFBLVDFjR3Z4emdrUHZr?=
 =?utf-8?B?Q2dlN2dBQVFFdlExdlFLbHIxUHZYWDc0Z1dCZk51dC9BN29QOWQwdEd6TUdD?=
 =?utf-8?B?Q1Jrd0xLYjdpaFJzcEZKaG84WElocGRtRWhXbFY2QTV5N25sZ1NMOFBGWXdq?=
 =?utf-8?B?YVd6NjJMU1JwZEtsQTR0TmRSWERrdGJXSkVOa1NHM3U3TnVxc0NKVWwyNzFZ?=
 =?utf-8?B?THVPU0tEaEVCbTQ3ZGFQNTByT1ZNbTh0Qzl6cFJMQklUUlpBTkwvS05HdEJa?=
 =?utf-8?B?K0tYZ0lGYm1Ta3o1dVAxdkVabjd2OXVpaTFKVWZSdmhJcStnSVVBVFhJREdB?=
 =?utf-8?B?UDV1Y2lUZVo0S0orUnQ0MTFuVUZIL0l4YURLVHM3OTVRd1RuUHFLZTJHSXlP?=
 =?utf-8?B?LzBtOHhmWHB4bGFXMkVmTzM2TFJtWEEyeGVWT1NNdjJoZFJUYTFnZGRzUVlH?=
 =?utf-8?B?MlFmOUt5Q1B0ZW5JMC81Mk0weFVNTy9BeFh5MmFpYW54ek1KUWdEU1JPd0xC?=
 =?utf-8?B?NmplUmdhY1pzVnNSK21WemozMmpQZ0pqS3h0c1dEaG9aYng0Y2w5eDVnUElO?=
 =?utf-8?B?VzkwTzRCdG9JM2ZycVhadWNJK01TMzBRQUNLdE54eVZMZEJwUXNQTFAyUE5K?=
 =?utf-8?B?Z2dXZ1EzRWpkc0VHczVxc2xVVjNuQ2UrYnEya3RUMzNOZTR0L0FsMlNqcW1T?=
 =?utf-8?B?R1FQelcxMGZtN1V1eWhsbUxHUlhab0IzRlU3aWFqbXhEVHNVaG41eklVb25W?=
 =?utf-8?B?R3B6TzBDRUd6bzRpdU1ycUh6UFhsSFN5NGtYMVIrcWg1dkVZVSt0eG1wbGEv?=
 =?utf-8?B?YlY3Q0s5aHJ6WHdyd2Y0OHB5RWRvZndVdXFEUWYzWm5mLzJOQzVPTjdNSTVh?=
 =?utf-8?B?M09EaHNmOFVpNnJXcCtON2tRVUVpMDQrZGNwUm9nQmQ1ZHBSSVV3UnhSS1p1?=
 =?utf-8?B?dG8rRjZ0dE5obkZtaFppQWdmQXVWbWNWYWd5U2ZQYTgrbmlYcXBHMld4Smo4?=
 =?utf-8?B?b1NtRWd2SDBuNnc5bzF4UTFQSGkzdzdyUGxFZnowTlBsaTVOMkJHdGZqWGk2?=
 =?utf-8?B?K0k3ckwzTWdjSXRRblZSM3N3cWxEZHk4OVl3Zm1NNGVyeGhiams3eDg1NUdK?=
 =?utf-8?B?SmhZVERJdEhwQVJzZ1JldGNlQ0ZmamdpRHVycGIzNWNqNURsU01RVVkzb08y?=
 =?utf-8?B?ajZuNlY4VnZyRHlPVU1WS2xhcTNEY2xNME5zajBoWWExSGkxYWxsMzAwOHlY?=
 =?utf-8?B?SzVGdjl0U1lqUURIT3pBc1RsQy9LMkFwTWptUDhLOFhiMlZhZ2dEQW0vUXF2?=
 =?utf-8?B?OExiL3JSckY3cXl5VlZBMG1SUFg2U3dsUXpZSFNPdzVWSkREamJuQkNUZDly?=
 =?utf-8?B?NWw5WGhaUTR2c1lrSURaN3RScXE3d3p2Q2JrRU41STNYVFlrcDBVWldwR0o4?=
 =?utf-8?B?eTZnbVYyZm4yUUtoa0tEMUN2QVNyUFZSZVFzZDF5aVFhYkZzRTl1RmQ4SEp3?=
 =?utf-8?B?RVorZUJIWnRjUVZJSmtpVVc4YzI3eXNoRlovVjhOQThicTJjd2xqUlRkV1NS?=
 =?utf-8?B?MmFSNEJ4cHIyQnBJd3g0WTNlbnNKNUhNQXJWcXhCRk5neVZ1VGtpR3duQi9M?=
 =?utf-8?B?bURSWVpDazlZUldSdTVkaERZN1lSVDdSNS80OG1QUVJ5ZEY0MnkrR0taWXZ6?=
 =?utf-8?B?S0VwbTN6ZUQwMFV6cVl1blYxeUs1UC9PQkdYZ0NsM0x6UCtKQTVlalhtdTUr?=
 =?utf-8?B?d0VSdFBCVDZDS1BSMUtrU0NkR3FCNHB2WVhQZmtuSW1aY0Vwa1BHcmM4T2NW?=
 =?utf-8?Q?mowJeHa1yaYZ0eE3k0CYuNyYc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f023d805-5233-43c7-4644-08db95073577
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 16:24:00.5484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELkfVCoAOIUj0lSperFuIf7iYDhkpmSFF8VfKfGRkBeJ4AhsbNnNMnWLYw0j9EYjEv2HM60NxZ+0rFGfD/v5KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4666
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  struct cpu_info_ctx {
> @@ -488,10 +485,7 @@ static ssize_t reload_store(struct device *dev,
>  	if (tmp_ret != UCODE_NEW)
>  		goto put;
>  
> -	mutex_lock(&microcode_mutex);
>  	ret = microcode_reload_late();
> -	mutex_unlock(&microcode_mutex);
> -

Maybe leave the new line in there before the put:? Makes it slightly
easier to read the code.

>  put:
>  	cpus_read_unlock();
>  

Anyway,
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
