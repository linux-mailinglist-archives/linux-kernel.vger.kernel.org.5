Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0866275280A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjGMQJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjGMQJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:09:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ECC1BEF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689264558; x=1720800558;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=szern0HrEwgAMIXNznYucI65bXzHBpET7kVsFWPk2Jc=;
  b=JVeeha0zU0PWUFmStqmbhqpOhhJ6Pl4Vi98yRdq5e6hC9/CptIaTdnfr
   tICOgmiuGH9Ea1wJmOmcsK7nTBbs96rqzuV8iXYwOBeP2UuyTW7R+bZeH
   uF8LupqFz3XdMamIZ0hn4gCYVZKgp+XP1R8ZCHFZB9aLA9/s0UnZo0m0k
   DXRawBxh4b9SPcAt5jR4iSMfQwO2UZn4Wa2+dlFwn6QYNpqeeOtWcDyN9
   iOQLBeDntNjueEqM53s7KnpX3xBaVd4ASdn/cy6DgQs03cotuC417PQSP
   h3/7Py8fGg0Eyf0GiCKo5JNMF/bcIYFp68BnX72cLFC1jqgGTkmUqd2YZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="451597203"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="451597203"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 09:05:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="896080660"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="896080660"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2023 09:05:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 09:05:11 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 09:05:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 09:05:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 09:05:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sw4ankN5rmMwXBvoZ5WYWmDsHRf6/Lcc/u6yYwMHC/bF9JyNoRvOxzbwHzHNUbkGU6b1Gx0BTVbICQn2Wtr+sgBgE6vqxFh6eBwF1gjaO6J4ZjshnPJaxU51hx9iCXRosfJN5khALXJtgZUJCWyC+/P20Is9vrKzi4/DtmjeXU3tKgjWOeS4uZBD1DORYOro/n/TJJ3YKY+a8erUfziRS2wMLNrnkxsqpo3TBj1ohthKABXijJ3yS5MftrOtB4FFeDm92CSYInloe0pDl0jaldW/bPF4OPJBRMgi1BqbwbItz3/rLFNbjX+QONXL+e4/vEdsu1+iH5LZsHT4UoVwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aui0RX6WpjR4cD9B/QIaBTiBrvu+NLpjXnulZHYbG2g=;
 b=MT+MAweF+8kQvSQJEKF7ijbxMtAlGijz59q8i8H86P179szhL/3fB2rS9ApWoZj7+ATVhlFGK8D2SWWG15HS8BjyCQWB2z2B06o3vM0zviO1z9nIAAU9s8HdNw0actytUiS1581yrMJCY0XDyZ0byodMaIIE/1L48E8OaZOCnCLMdn8d9vHNDBMJ6Xod80TaT2wW0+76Nc2xRFtIDQfTrvv+I6w2dqSx1XZ17jJn+SzuC4Ps7j5E9pfi+up7yRp1NIjB59TUCvx6QspjaydqBg/gXLL4BTE9qwheAKAKqkrVHiW1eukY532fmDelwz5T632JJDB/xhocIZ/tkfR8QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA1PR11MB7388.namprd11.prod.outlook.com (2603:10b6:208:420::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 16:05:08 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6588.025; Thu, 13 Jul 2023
 16:05:08 +0000
Message-ID: <9a1062c3-f5be-ea69-0672-cf1a44be7e03@intel.com>
Date:   Thu, 13 Jul 2023 09:05:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.12.0
Subject: Re: [PATCH v3] ntb: Remove error checking for debugfs_create_dir()
To:     Wang Ming <machel@vivo.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>, <ntb@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
CC:     <opensource.kernel@vivo.com>, <dan.carpenter@linaro.org>
References: <20230713085621.3380-1-machel@vivo.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230713085621.3380-1-machel@vivo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::6) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|IA1PR11MB7388:EE_
X-MS-Office365-Filtering-Correlation-Id: 21aa58dd-ef01-43de-22d8-08db83baedd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: so+3R7aXxrAGs41R3rjMB73zz0oWKQb3D+PEpjKoqndYCsYzKslqfoknXPMcMEYa5+MSCCOFLot7iXP2RDV10JH2+DTvv7k3enFTkyH+kwf7ueKN3zSgHFTmXl85h85IYFpOo33gCLWFbLKSbHmavmZ5kzvNkS47l6TnqrLE0rBdYIIq74z2fqGjMf3kg29pm92R9+hUIwm6FnI6uDstZ4NFWqhAXsx/9ODs2otnXBUqlMSRVE21QdpPPnrvK0cQroW7ql0vAd7362pJ6KcXLm9nNsfRf5HA5SSxeouzgvzlS1Rk67w7addo/Gb1NiE4/2nLFB0gEOauQhk1BAyh7cswq3rqYywMe1ZYiSw0KWlp7Zl7kYxdNYNZasLWZOyOKYwplsgEt2Yg8Q+1W3IagtFgDLeGMnPwZzYkINsRWeOciygzYpjmAwvgUBSg5wIrYZwne8aUhd7jgq7sf/wfjFe3xV1AUGKxvRvUraShDrkjcCGeW3WHeCOyPeOW6vYnrOjj+4gw3jE1YoUxZ7OVI6PMV9cexQZ9yKCTYjWGg9OGvNWAKUTwJfGX5FyP2TXBuwSYxy387jWzVJYD+v110p5oZz7mi6lPqhwNM3gC1UKRMElipr3NzBsxqwbRhusUdECt8vYZ7njplr9cmrQ+EQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199021)(6512007)(4326008)(66476007)(66556008)(66946007)(38100700002)(31696002)(86362001)(186003)(26005)(6506007)(2616005)(53546011)(83380400001)(82960400001)(36756003)(478600001)(110136005)(4744005)(41300700001)(8676002)(8936002)(44832011)(7416002)(6486002)(6666004)(31686004)(2906002)(316002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clU4K09LSTd0ZW5WbFZqTWZseEhPc21RblpDZHF6UDVJVXE0Nkc5d0IwSHNW?=
 =?utf-8?B?OWNJNCtMRmk5aUVyYmw4SUJQV1piSnpyeW13NVhrVGNCYVB3M2JFVXRhMEg1?=
 =?utf-8?B?Ris1angwUnI5dTZYVGhyMm5Vd2djUGc1NHVYVlJDOHN1OE9SNld3ZWxRdnNw?=
 =?utf-8?B?TEc2aEdReGlHQ0QyOUxsTFMySGEwQ2hWajFER3lYZkVhSVp4VmRCV3hQMnJG?=
 =?utf-8?B?S3hXbjkySkJKSUZnU2xjY093THNKSFNwYUtIK21OVHdacks3ejRaOFBjRml2?=
 =?utf-8?B?RnFRYnJDczdURXRibW9qaEdCd1JOUUJCZGlXQWd2aWoxUzJwZzlTdEpMRDIw?=
 =?utf-8?B?OXJWN2pacVpZWWJVTWZHY29mV0s5Vk1mSEorR1VYVFV2dGlsb3pybkp3SUxm?=
 =?utf-8?B?ak1XRExVcUltcEUxL255VnVBRTgvRkZJV0VabzZnemRRaWtETTNNRjVQTnBL?=
 =?utf-8?B?bytyYnRuUkdRd29RUTZwalhRZk4xUDhPTkJqYmwyTXRIL3R6RGdlcGpNR044?=
 =?utf-8?B?ak0zc3kySUtRWVpxeUtLQTEvNHBuYkV1MVVuNTZJOHc1Mnhwam5lL1FoQk5F?=
 =?utf-8?B?Zkt3UHJURTVHc2RwdFhEUGgrbkhLUyt0RHZ5K1ZuZXJRdzd3c2tiZzkxY0Y5?=
 =?utf-8?B?YUtlK3YwRGwyQWFRL1cxemFpR0ozbUNQTkV0ZWdqK2crTkRaY2ZObUd1a0k1?=
 =?utf-8?B?VS9UekN0UWJSMWZBUkl3anB4aTVIZGk5NnQ3SU1PYzVocnJzV1k5QW5qTTJY?=
 =?utf-8?B?UHB5T1JndHUzWERwZzkwQUhkNnc0YmdsWHBiU0RIc3VuNlJudk85U3JuYk85?=
 =?utf-8?B?TG9JR0VqaTEzYnhGVnFtUXI1VHE1V1dhQmFLaExzdlVWUkZjWVBQM042WE5w?=
 =?utf-8?B?ODA1dXJmc1g1NTRoM3RtMXVoM3czL2dvdmlsRWIybHd2bDhIczlORnZCY2h6?=
 =?utf-8?B?Q1NWQndxbVpaUVQwUU42L1FDWDQxaUZWOTl3eHc5eW1BdmdJOFh3eU9KWGsx?=
 =?utf-8?B?dVNpR0xKZ0dmTWRXUEtyT0oyZ3ppcXBObDlkR2hlSXBEQ3RzOFBIRU95M1B3?=
 =?utf-8?B?ZCtqcW92ZXU2VzB5bVhpVDJROVFjbWp5a0RUWjdnMHdvTSt3ZFgzb1dlODJ3?=
 =?utf-8?B?R2tpVXNLUUdSc1YydEhyVWZZTVlON21FNC9mSnRrZEhiQURWSytFdGRBMFlQ?=
 =?utf-8?B?TjBRcitGdXVRNHd1eFJ0K09YQStkbmY5VHh1SVZDRUpFMEpPVUR3aHpreDFy?=
 =?utf-8?B?c0E5djQ4VVpjZVRJUHVJMFZwWEl2VmxlUFlzT2hESHg0RXUxb3VEWmkzZDNM?=
 =?utf-8?B?V2RXZ2pBYjRnU3ZwTmJlanFXajdjZlZ2RjlSVGJuRC8zK3lCemE0UGlZemtH?=
 =?utf-8?B?THE0QjBJNjNrek10aHYwNkdVSUdPZzZVRU41SDloTlVGdit5UkdKMFBjdE5p?=
 =?utf-8?B?R2xzbkRKZU00cmNzK0lsbHZORmtQbU5mbjkxUlVRUmlDZTBKMEh5MmI1VU1V?=
 =?utf-8?B?TmxjSlZtTzduQXA3Wmt1SjRHaUE0QTd6UmF5OC81bEFVT1F0ZmxhSkxrMUZo?=
 =?utf-8?B?TkVoLzVkemVPazRwVVpJSENXQUFoRXRLOVp2YURaejQyajNrNFEzejBuNHZn?=
 =?utf-8?B?ZTlodDlXWEhjRmFtQmtIL3QydmQvSHBHQ2E3QkpxOVFTdmdVNWpTWXZpNE50?=
 =?utf-8?B?MnAwa1dwemtYU1ZldnpCZmxOdllGTCtZVHJHVjlsT2FBOERwSGs2enQwb2d0?=
 =?utf-8?B?b05tMkJEU0ZuL1pyQ2VKMXk5aGlNemVHb21YaHFNbU5kQUI1MWtDMGJoZmtJ?=
 =?utf-8?B?R2dhZSsrMlBBVlAwUnZqMFdYbVQ5ZTd5WkZ5VXU1TElhcnNXYlBNMXpZOUFI?=
 =?utf-8?B?NWFMalE4Wm4yYmFBRUVGdUV5Qmd3MmdhRVB6dml5a0JRdUtiVS9mZFBTYWhT?=
 =?utf-8?B?b2p3YTFtd0tuKzhZNFQ5Qld4Z0p5ZlBtRE5QT29VamdWeHRuY3FXVzdnRHd0?=
 =?utf-8?B?Ykh2bDNLWEphK0loV3RlcjF4OVNjS085QkIvZlFiMDBhbllqM1hlMUNncWd1?=
 =?utf-8?B?bTRURkNHcVBucjQ5djBmMFd0U0srd1FQeHJuYjU4TGNZTkUvVndvYVpuUFha?=
 =?utf-8?Q?Oi3cKyf7//KHfDXzheWOdHey0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21aa58dd-ef01-43de-22d8-08db83baedd8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 16:05:08.3512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NstgdwT1ArZCicDFoKAhoVGFt9+YX0o6rUdOvMHbLrtgweyj2JSZaq35bMGqewIPYDF9xEg6vsHk10++6rbiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7388
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/23 01:56, Wang Ming wrote:
> It is expected that most callers should _ignore_ the errors
> return by debugfs_create_dir() in tool_setup_dbgfs()
> 
> Signed-off-by: Wang Ming <machel@vivo.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/ntb/test/ntb_tool.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index eeeb4b1c97d2..e0acc11d29ba 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -1495,8 +1495,6 @@ static void tool_setup_dbgfs(struct tool_ctx *tc)
>   
>   	tc->dbgfs_dir = debugfs_create_dir(dev_name(&tc->ntb->dev),
>   					   tool_dbgfs_topdir);
> -	if (!tc->dbgfs_dir)
> -		return;
>   
>   	debugfs_create_file("port", 0600, tc->dbgfs_dir,
>   			    tc, &tool_port_fops);
