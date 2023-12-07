Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D48808609
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378838AbjLGJzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378789AbjLGJzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:55:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC76E132;
        Thu,  7 Dec 2023 01:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701942915; x=1733478915;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a7GoWalO2SLW/FLR93D4m4KSCFNlum/YAR6vGDk8wc0=;
  b=b3+hffV4mE0/g2eF5Mw3D2DgnqGcmyRqSWQnuzHl7MGkvxXsEcJR8eiz
   hnEFJIRrdMYnsjNn/owk5+xmc6bEneX7JfXfVRiPVzyqIR3DgswVULMr7
   JJenWrwrx/FZccbP5wmWPhXy9aNN5ixX3qR1fCtKbJKleAPfZHCFb49Rt
   +CuRyeqEDZuAA2ERHHFReDoT5ZHiUd7GYOu8I9DHLCTde+SdAz8JQ8AhC
   z3iigCmQFXiSnPcBreggFS77L1J+xE+6xy4jgIY+lwyRmiIQ3/FCRyurc
   cbtN3ta1XCwA1eKCrfJ/FTLjRUhFxzgHlXfpP/9zndkfpolYk86gWPw2e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1074051"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1074051"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 01:55:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="805959974"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="805959974"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 01:55:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 01:55:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 01:55:13 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 01:55:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iD1onUu8cemR1BKGBNuPvakNBv33BKBDr01gIftowDLH8dzIMxe3YPYV9ajohuMY2nXqAZnAkYqpoLjd1ho2jsJP9myvVg2Rm2gmTUMKEPP+ZKwkZQ1LEbUYRxlSCdrSqMS14GBeLgEOFVXPrN1s81rSq56zFNOfRc1RUAbAfLQEK297t/UHh7Ok7xNuNURFz/NU3jBrlYDRbSZOAF1Ga6KqnNsTluKFCrvCOlWKO64esZv+JaTAx8pYxG5hNKRa3Z12jNB6Zjk4z51eA7OjRX2BttQTYoqbJpuRfuVIZLISroC6kwEQmpZcHU8ZB1jMwIYqDYkn3fPtXLuximK4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4GS/oMjLwFOPfoYdyhKFfsYeqvMKeM9xhiAMPszixY=;
 b=kvXnnf73y+ebT0Aq6IbglQYykgGU34FDI667yYM62SE7cVGIXFCbl1ch6UOoPbh1XLbOCZtyvqb+qSBY0fUY9FL7Ji5M080LTFCz3hA0DHS4UebleESEv4Hq4ojxBemff8JlpxnPYGauL/koK6GidfC17lgHpU05cMeNshyPhomAzODoW9UOGlK0jaqIpLfX7+tSABUGbF7ndF435s41toQfLtiND9JChXBIPySME5bpmXU+Fl4m5quNP/UEMNtXJYB/muUQNEWV2WV+VPTGsP4TVllr0BF4F3bn3naIgdqn+XUip+3IqbpqP2H9CDjxDMoB/Uoni1W9CxOEMV3TkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by CH0PR11MB5522.namprd11.prod.outlook.com (2603:10b6:610:d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 09:55:12 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 09:55:12 +0000
Message-ID: <48a51a78-da87-58f3-92b2-01db85e14cfb@intel.com>
Date:   Thu, 7 Dec 2023 10:55:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] [v2] qed: Fix a potential use-after-free in
 qed_cxt_tables_alloc
Content-Language: en-US
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
CC:     Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Yuval Mintz" <Yuval.Mintz@qlogic.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231207093606.17868-1-dinghao.liu@zju.edu.cn>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231207093606.17868-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0329.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::12) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|CH0PR11MB5522:EE_
X-MS-Office365-Filtering-Correlation-Id: a769edb1-5c98-4e4b-3383-08dbf70a9a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIa/kUWY/c2ctEx8/tNkgCeQBWae5JWR+E/9QKKmNaVgptwqfJYJy7/bs9QH/H4EjgbuQptdi2G7+vub6dA/LTacCQnxvm9KsJCiM4Fk4poVk0oZOJe9/3LfiFaz2OILW452unCGjtIjSAQwu41lh9Lc8bo+jN5Us1Ms7Rp3Eewy9AsQ5iaSq/afTO1t4aPmZCEnroHPF8KyplIe+/RtRNQtBtQ3zFaNuOGf7VRoFf/JEbWmRIvLN6niLeCfpB+Dk5Du4TE9hLUaANshs0IFe+KHicP9oJLJVj5Kc/IcwSWXQk8vBImsZg3Yw0xPCQ2ltVVIH6l0oGOjWnLeh8X445P+BhlQ11Qj5R/Zez0Lez+E9jByjfL8xECBC5tvtHlHkgYcwv3Niw1if+IDFdc3ncqyEmaBSMx/g2sC7NyqRUMnXEs2MSexTqd/iY+fef/iCwXoiv37V+bP0hUtZyq0lETxK2AgP6/sU7kbto1vHAGH/RTpKQonYjTRxt4/XXUO1OanIIZuQUPcEfr/G7g41z0PxbshVuBwDHxumBcHUkLpvmaux/Z2bICkrNW1PX3Xh+lJaaQgOKIDYz7UOAeBxZ0zUc2XO2alGTjbjAvnR0T0fwNzunppfjVSLXUPH4C6vLwNuHvitj1CtX8KzhRqvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(36756003)(41300700001)(7416002)(2906002)(5660300002)(82960400001)(31686004)(6506007)(53546011)(6512007)(6666004)(26005)(2616005)(6486002)(83380400001)(478600001)(31696002)(38100700002)(8936002)(8676002)(4326008)(86362001)(316002)(6916009)(66946007)(66556008)(66476007)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDkwcHJ5QkJmMHBid3J0WGV0Yk1mQ3lTMmdTR3BHY2VBbldHcW5UR0V4Y0JF?=
 =?utf-8?B?UWJTV2JPblFjVGpRSWdWcDNWbFZqVDJhYnQ5SWU0MEdBTEx1YkJoYmlTQTND?=
 =?utf-8?B?a2lNb2RKWDdZdnMvSHh3S0ZPaDlBSUpWcDlIeWIxbkRTb0FlSnFyNldmdVMw?=
 =?utf-8?B?WU1zNXdmTWt4TCt3QWx2eWhWUkVOSFdoUkY5ZGlMUmU4OVlpODhiYy91aENC?=
 =?utf-8?B?SUFDcHZIWmxPZXk5WUxQazJmRWtSdVVmeEVjd1grWlFlNHh1ZlhWdWpJRUk5?=
 =?utf-8?B?bmEvTldtSmg5Wks1VzZKTWUzb2dnTUJSdy8wSW8wLzJuSzdCUC9SNW9kV3N2?=
 =?utf-8?B?U1NNVWZyVHJvUVBRREtVU0kyVHlMSFp5MUNjK0FndkVFSC9nT1phdmNIdjdN?=
 =?utf-8?B?SVRXSkdYbzJTbUZUUzk3VUZRT2dCUkdoTjc0NER1SGM2UFdNWVk3enBWdnV6?=
 =?utf-8?B?SmdHNDkyeFhkTWNRdHN6cktJNDZ3SWJGanl4ejlXM3hRZUVwa3JEeW52cnl2?=
 =?utf-8?B?Q0pBR2xHajg2YVRPQ3hTYk9xWkpxS29RaVQxVkZ2UGZMTnMwdVV0OFRHNFI1?=
 =?utf-8?B?dU0vT1h1Z0doTW1VR1JGWWx2aGlhVW9vbnFXNnNwQXdLUW9hbVZCQXh2RHNQ?=
 =?utf-8?B?amRaVXBhMExOeWJpUUx5OTI3VUZkbms1V0Z4NDU2NEtHOGZpalBLRUxTWnRk?=
 =?utf-8?B?Lyt0OHltNTl0bjI1cUt2YTNHRUM3M3FpYU54U2Z2MXRLeXBvbFR5TEZDak1p?=
 =?utf-8?B?OHZpN3FHL2YrV3NLVUI0b0UvTmFMNVJDVElNbE10Q2JaVXBjMVhMWG42ck0z?=
 =?utf-8?B?QUdsWUJFbXlSajJ5aTNONzVLTzUwUDgwVHJLcGFnUFRRMk8yMnJOTFJUemdX?=
 =?utf-8?B?MFRYUDFZUzdQWHZoZzdaNkpQVnpjdVZVWWJTbnluOW52SjAwOVRURUFud3J5?=
 =?utf-8?B?UnBnZTZ5dm5SUEdIbGNOU041Yk82UWZtMXpQNkFWQzQ0TWNTTGJXYWxFcVJU?=
 =?utf-8?B?MXRkVHVxZVZMVWVWUk9QdWNydThpS2VtUExCdVVEK2pwR1M3WFhQZGJXNmd0?=
 =?utf-8?B?TUVkaEZZTVJUK2VRazYvRHdYWWtvMXYzOVlpdFd5MDByQVNoMkhyNHN3cklF?=
 =?utf-8?B?Z3FVVnRtUmdpQ3QrZVorMjlQdDU1eCtKWGIrZmtkd29NdVFlRUtyU1N5dnVQ?=
 =?utf-8?B?VEMydlZiWE1GSHQ4OHVrakNodGlhREtWclRZbGtiTWk3WjM3TmFaNm9XMlBq?=
 =?utf-8?B?QWd4QXcxcnBuZXFZYkVIVDgzQUZySWJ6Y0EzazRKVVE2U3VzaE5jK1kvWVoy?=
 =?utf-8?B?WDBlV1Jidm1TN0FiU3NOcklqRWFRK3lhVVV2OCt4WHdRMllQWThZRk1RS0gy?=
 =?utf-8?B?eDJqWll1M0Y3RGxGTFRxeDhLdVU4em5CdkMyZjJnNCtNQUZTL2J3VndLenNk?=
 =?utf-8?B?Mzl5NWRTZlBYWGptN0RyemUwa1lHUHFYaGZud1ladVZ6Q0hDUEp0Y090ajE4?=
 =?utf-8?B?NnJwY3hIQkg2WEpQbGwzSm1RMThjN2dVaE1ONGxQWnNjVzd5M1JlRVBiOENp?=
 =?utf-8?B?V2Fma3BZeDJ6dGp4T3NpaEk4SVh2WEtCQ0JJam5kbS9wWHBtSGFhZjhjTUMz?=
 =?utf-8?B?ejMzbGw1ZzZCakx2QmNBNFIxeGhrOGxGYXV1WS90NnBsVlNjdU5PUzUyNWdS?=
 =?utf-8?B?NjNzd3M1RkJ1RmdEZCsvbUFGMDV2bHlFZ2loYUlhb0hEK1h3NElKd1JEZGV6?=
 =?utf-8?B?dXV1LzBEditnOWlHbnlDVW1YcWlSYllKRW1MNE9lSkFHbWUxNC81RXRqYThk?=
 =?utf-8?B?ajdYUFZLaXczSFVYeDFtd3ZDZ3ZHUjIydTVrRjBDVzVrSlRWMU5FRmxuZDVZ?=
 =?utf-8?B?ay9YVzVSOEp0T01iczBzMVRKMUVxS1BOTjBLYkNYdU5Bc2ZtdU5OMDRxa0Ri?=
 =?utf-8?B?ZjhvUUkwaVdXOHJ6UTlZN2p2aWh3TXJiaEhUbDFtdENjQ3BaL3RaZnVWWVRO?=
 =?utf-8?B?aXhnbmpRSHNrNHRUanZBcWVUUHdrbEorTGVFTmNjRDA1YXg1aUR0Wm9KbkZ2?=
 =?utf-8?B?dEFFVlBNdDdGaHpmRGh3aUNFVGNBMzl2Z1VjTkZTMzFwRDVqYlYzR3BmL0FN?=
 =?utf-8?B?c0w4dEtqd3lFcmdzNHdES3lMT3pJUTNMSllCcU1uL2ZBUG5kaERVaytVYjlR?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a769edb1-5c98-4e4b-3383-08dbf70a9a5b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 09:55:11.6817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vj8jK0AomGtC9J99wnA5JU1kNPjYROsgK5cQktDw2W92I7D7qO/BTINg5ffSPLCbzdSBm0niAj44EC70U+Z3P1v226zB4jLQqNnYhU9wCbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5522
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/23 10:36, Dinghao Liu wrote:
> qed_ilt_shadow_alloc() will call qed_ilt_shadow_free() to
> free p_hwfn->p_cxt_mngr->ilt_shadow on error. However,
> qed_cxt_tables_alloc() accesses the freed pointer on failure
> of qed_ilt_shadow_alloc() through calling qed_cxt_mngr_free(),
> which may lead to use-after-free. Fix this issue by setting
> p_hwfn->p_cxt_mngr->ilt_shadow to NULL in qed_ilt_shadow_free().
> 
> Fixes: fe56b9e6a8d9 ("qed: Add module with basic common support")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> 
> Changelog:

For future submissions please also provide links to previous versions
(would be to v1 in this case). No need to add this now for this one.

> 
> v2: -Change the bug type from double-free to use-after-free.
>      -Move the null check against p_mngr->ilt_shadow to the beginning
>       of the function qed_ilt_shadow_free().
>      -When kcalloc() fails in qed_ilt_shadow_alloc(), just return
>       because there is nothing to free.
> ---
>   drivers/net/ethernet/qlogic/qed/qed_cxt.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 


Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>


