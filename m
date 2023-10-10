Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08ED7C424C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343902AbjJJVVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjJJVVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:21:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270DD91;
        Tue, 10 Oct 2023 14:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696972898; x=1728508898;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TyVVUtCSN4kekF8ZoiR5vih+N2Pe6wiFjPimW4rXNKU=;
  b=JJMcAmrgZKp3eeVSfaoHI8xX49MdZkkiQb1AG3vPH5qImNdhH7JT342u
   8tSdcP0UftBeJ53KJJLfITT5Nt5eyRRHeiURQTFhgC1u6088Iy/m4lrkK
   tW7/qxIBvlEDzMtr2FT6xh3zWSUqxnOaNxas+4V3zsKgDC+rTicCVIYPq
   yBjypeNKLy3ejqt+q3+NK7YjXDmQvQ14netMV4P8+3hxl2D/7QC3sDPSZ
   KxLUG5pooC6deun4HK768vYfUpiI3fPJNMiIVXsvJLSSIawJvieywmces
   ihX+UNGW55eEBzEZrz1kTca+nE80vwUPRR35//sNHC7eEq/nX82dkvbx3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="374851876"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="374851876"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 14:21:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="753551832"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="753551832"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 14:21:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 14:21:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 14:21:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 14:21:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqpdf9Vg4TO3rMPxcjR+E5eJYjQvBAF+VSpqkNYXelKmyIvjrbvFt1HeHHdYSzH7kVj05Q5NPNqWgDh4rAJ8iOHCGx5RVtc5nI7SWjtkKcNwJKjVZystrs92nYOUXuSWOsaThl5AbC5NTCgYTfq3yNYw7dZCDM3BNMGSfXPqnsBFnonI4xZIde4H12+ZNdMzYniqf7kzZZVJ6sZc19FjBSe4XBHSYtaglfdf6efFcK5pb15lYi1MkmmNCZ8yIbrz/BJQEUorI6rJ1mgQsbdO6twRocqCvAPGA0c2F9wohKwwl1ttywiH1OCxwGm7bQ0MOY9eGoBr/X4KuOzP04Ldiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weLU2CeJdJM7PUPrXN7ft0IQP3wYomfeOI5Wseol9kQ=;
 b=ceFkLIaOVj5fGYsfBEAgOAysvWfXA/6O54F2Koc1ZG8OTeh+I+SlO8ck77E38fxOzhafFlgsfEXBQo6CqIWar6qfA4C7Fw163ze5V+qfik7xwy6/ysenyxq5u/SKxdg2X8p6qExMQHCUj5cIq+2+YKLL4e3c4kLdsWTpcE9sICDiy6Mk8se3UzGmAQuwVC0YQxDJFJRBElx1BzfnSsUj38muvf853QdEsM3/D1LprgipHvVnx1XwO1JMK0BdehG/cmK4LvMjO5N9h5OtKt0NyAoCecnsAJpi8u8J6Iez1PkNiDg2E/OlnY7V7HxXIDPWxGg2FHaPjSd/KoClk2nY0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 21:21:35 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::b598:4b13:38aa:893e]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::b598:4b13:38aa:893e%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 21:21:35 +0000
Message-ID: <19f84dd5-e769-aca9-a8ea-89008bfd9226@intel.com>
Date:   Tue, 10 Oct 2023 14:21:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH] i40e: use scnprintf over strncpy+strncat
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20231010-strncpy-drivers-net-ethernet-intel-i40e-i40e_ddp-c-v1-1-f01a23394eab@google.com>
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <20231010-strncpy-drivers-net-ethernet-intel-i40e-i40e_ddp-c-v1-1-f01a23394eab@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0171.namprd04.prod.outlook.com
 (2603:10b6:303:85::26) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|DS0PR11MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d6f01e-709b-435a-b0c2-08dbc9d6e1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4s6bdiIPWaxtuHCK248jQVu+iSNPw4xuvvVj/evh4RJw2rsq8yKkP2YcnSThanl7hTz+thD0UFeQ1aOk52fDTsRaHEQP3ADzVYJZM0meoJlxJN2OG3k/1y68oiFjgIeZfBXXwxYPWnnx/g95EjHmgeIDLtecczADmAy/GocTmKn1sGbUkqvBCLCfnIHlz5Ly+Oht+cPGtlLdg71Ruq8o3wFqoZejBSzVE3/llkjQktiyo6Xy2uiIn9vW8oWFdDAFLw93JlykJm0MP6ST0ezTNorZSvp5DEpeR3jRBSggRmbaGEHlAHkpBLWjK9VUvupHWOY+7695u3eLJBjbAW+5RV3zjJdq4ufvXC8oRr5spKS8JBHGZbmez2MNJbgu3UM7+9IL5J/zlKt2uEXDLuql/4WiJBHmE5GBGUvBteY6NqDy6czOsHcwM8o8WNkKZOQDr++PlkmdChizP6KaaP/UCmS1nW4YMCx93ylPZ5BNMEj+qyTzL7/fDfQdYTyfHC3MSNFw//mOFEPzr7aiVvGXLjZpS0bNtHDa08rxYyqBysjH9PhcaZaiBkH1OCbnJL+5lx42xkbIqMoFzUx/K2WE3AccKOygDzSS5ck9js9SUuZ6O6LVpzlNfJ75JV08lx7fGE8dXGuvJUIvarioSOocuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(53546011)(6506007)(478600001)(26005)(2616005)(66556008)(6486002)(44832011)(31696002)(4744005)(2906002)(5660300002)(110136005)(66476007)(66946007)(8676002)(8936002)(4326008)(41300700001)(316002)(82960400001)(36756003)(38100700002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGdzK2M5ajZWR0hyNU5zQWNPRlhQS05pUHgzZ2EvWXNmME5JZlJsOC9XRFZ3?=
 =?utf-8?B?b1c4N1pOb0pCd2hONWZJbDBZZ01iZ2Z6akltL0lHTUlMQURDazJxMHMrK3V0?=
 =?utf-8?B?SFZqNFYvQVc3UzNPUEo3M3RtWFRSaDdWNnVKQUlOdVZyeTZLOW1oamt2NWtX?=
 =?utf-8?B?c2xPNUVoSmdlTE16UnB1VG9YcmdRMlluQzNtT3pxV0JsaDhWZGxnSmhsWnN5?=
 =?utf-8?B?bTRtaXp5V0xiU0hDL3Z0eGdvOGZtcit4ZC9HODJ0aDV0V1NZbEFVYXArUGN4?=
 =?utf-8?B?UzZsQ0dQakc2Ym5OT3RmYnEzTFpYWjFMa2FJMjd0bi9DUm41TjZHbWw4bGxm?=
 =?utf-8?B?SU9xR2tiYS9VNG9pRGQvemp1eWhBTVhkMnlzNFJLdW5nVWNnMGZvTmtlU0FN?=
 =?utf-8?B?N09hWDRRTlFkdTQ1ZnVWM3ZJKzNlQzd5bTk4NnVQaS8rT2NGb0xpVFVtMWR6?=
 =?utf-8?B?K1RLYWdoUWM5VmpFLzZ3dW1HNithM1lKeVZMWVpFa0JXN0g1QUhoYjNZM0xR?=
 =?utf-8?B?cjZHcDB1QXFlaHYwN3ljQkNFZXRBdS9iWWhITW5VQ1ZwVXVzY0JDbzlQNGE1?=
 =?utf-8?B?eTdxM3lQM1lBanVmc3EyeCs3VFlWUThVRzVYY20xcllZT2ZmdGE5QzdFSmF6?=
 =?utf-8?B?bVdYZVVKTWMzS3l3OWFNS0NWNU12SjFId0JhSVlvYjhtVkwrd3BCbnRBdDlh?=
 =?utf-8?B?MnBzTU1WY2sxRmhZdmZETHFXYUllamprSzVIcndKMXUxSzZ1d3pMaDl6U00r?=
 =?utf-8?B?T1RXalpBMmp2VU4xMk1wWFpiaDhYZ3BKaUhCcWpQd00vWnFkZDFhTmowUTl4?=
 =?utf-8?B?Wk13RmVWekNYZ3d5Tm9tTHBRZDA4NjQzQzNjeFd1TWxJSVdzYW5LSzZWd2pX?=
 =?utf-8?B?dE4zcVU1Mkt0NEswWjl6MVh5L3hhTDlaR2JGdHRqUjNJM0hUaGNRVk9MN2k4?=
 =?utf-8?B?WlR0QVJpQVh5ZTFLMVJvM3JFeThDVEtKMExlb094blVOZkNtSmhXc2I5UXpD?=
 =?utf-8?B?b1pjVEMzQnpRaTQ2NkVwakpKa2lBakdrZTltTmNkU0xVcDF4QmhiTUIxRlJl?=
 =?utf-8?B?WUE4OGIvYUJhbTZmZUdQOC9Rb1JxcU1EcGhMdXNUQkdkTnFpT0YxbjVkczdj?=
 =?utf-8?B?T2lXRFMyQkIvV3J5Qmc3MDNUM1NxNm84czJsczAvdWRqanRXOUFWcEREa1c5?=
 =?utf-8?B?QUFuSW1wU1YzMy9sSHVOUmpPaFNUQkZWSGlIRjYyRWZKdWJyQkVUbHBtSzZh?=
 =?utf-8?B?R0JhZHAwWDQvdVZtdGRvSzNxOXFiTHZoSyswd29JQVJ1YmNYZEVwUUpMSkg0?=
 =?utf-8?B?L0RxY3E5cEg1TjBuNkNiVklFTS9tRDkva1JnbXdtdzNUMUdTV2o5eHZKQ3A2?=
 =?utf-8?B?VXpCQ1dKUlgvQU16UkdaT0QveW51SnF2T3RVcmZ2MUg4RTZrT3g3VXlVMkNl?=
 =?utf-8?B?ZmJFV2MvbkdEVW9kamRvOG53VXRmQXBpVW41RDdCRHUzRTV4eXo0Rjc5dVhU?=
 =?utf-8?B?VFJ6U2lad0NVNlZHWURpOGE2Y0FSRmhUQUNHanRxRTNrUVFmYUV6aFJhMVUw?=
 =?utf-8?B?N0ZIcHNWNnNCUHgzdVlES0t0SFFYWkVmdUNwL09YZlZDYks5aXhpQ2xFaFR6?=
 =?utf-8?B?WnRPZzFuWTF6Y1lIdVFvODZlS0o3TzZlTTZRZ1FBai9qd2dlTzBpdktoMHpO?=
 =?utf-8?B?dncwUjJVYmgwTFJCbzNQd25kOWpDazFHVXFvS29ueFFrKzZ1OEttZERZWVRC?=
 =?utf-8?B?NnVQcU1iK1RuUWhsb2p4b3ZSMTJuVXNVV24yNHJFcE9HWGhpUGNEb0dMcjIy?=
 =?utf-8?B?dUJmbXlQcndGc09WcGc4aGlaaHhOZ0V2UWVCdVpuL2hGWmpoMWx6ZlpKYlk3?=
 =?utf-8?B?TUYrajF2NlNVK0J0MGRzQnFuNUcrbzUvYnJJcXlsVFNHM1Zwa2ZmdXFVYm1w?=
 =?utf-8?B?UXQxdkx0UHQ5STA0OStsMjdxdnRsTUVoMFoyTHRnbWNVVDFJeTYrNTNRQ1FI?=
 =?utf-8?B?OHBxQVRUWWJ0RUNJM3lIQ1RialZVZ3FhSVZ2QkNPMlY1ZEhMMlBGcDQ1a0c0?=
 =?utf-8?B?SzlxTU51WU9mWThBNmk4K2l1OWcyZUsyUmhTSW5JNWtSS25ONm9rMHd4VFJl?=
 =?utf-8?B?SVczVWdKK2RFbmFtVGVucjF2N1pvN2wxMW1GUG1LcU90NkYvdU43TWk4WXlw?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d6f01e-709b-435a-b0c2-08dbc9d6e1c2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 21:21:35.1923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hayYCvdPaUni5c3DkCB7Cjqvuwm08JK8qj4LmtO/AGK0Spp+arlljqJY1VlrS7/RCd+1AuNP8tk8PRlND2GLgewD7Y7Gypp2SSqMpk+Bisw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7286
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2023 1:53 PM, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Moreover, `strncat` shouldn't really be used either as per
> fortify-string.h:
>  * Do not use this function. While FORTIFY_SOURCE tries to avoid
>  * read and write overflows, this is only possible when the sizes
>  * of @p and @q are known to the compiler. Prefer building the
>  * string with formatting, via scnprintf() or similar.
> 
> Instead, use `scnprintf` with "%s%s" format string. This code is now
> more readable and robust.


Please see my comments on the igbvf patch.


