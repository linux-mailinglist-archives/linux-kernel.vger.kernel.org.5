Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA1F7EB0BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjKNNVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjKNNVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:21:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C8A1B5;
        Tue, 14 Nov 2023 05:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699968072; x=1731504072;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o2+UeNqgoe5KakjeyefSxuuzxvRMTcuQ/tCHaPOB97w=;
  b=Jx5ETm9ELpZL9b1qgAwOLTfTWCfqMz2K6zgOxmXAqqlRPeE0qwxFB5xF
   c321DtqYIMc8kGU+dJy+GoN9jXC/1jc+icc5yiTEOAQzTaDyriCxJJETY
   yEwRkPhWfrsIU6Os35hJwes+5OavvjZSFatl720rF61YRj5J0iaN/T90a
   WhcI+IalXNdhMnEmOHKvp0Yy4Op70ieLa+B01854Fcl4ukfoJZgvZENjs
   whYeHminLmw4enGU9PEuggiFLiC5Mu82bPse0oljLbruP3x0r29nSkRr1
   Al2TQC62PNA9hSRfX8noldNMaTeyZ9TtvZLqLYkm9w7PKbl5Q3QT63GGk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="387814176"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="387814176"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 05:21:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="835026921"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="835026921"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 05:21:11 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 05:21:11 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 05:21:11 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 05:21:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmmBZ1dO1cycdgEx2v+Tk4VuwauQzKTY1vi9dTqMbEa+HwSxHFyCvQkLGRngFUTRcZal8xezQDvox9tbzdzo3GSIy3OU4MWFwJJKJuD8VDoCdWf/WUWSFu95QcAQ8g26hj4ALqh6sELVkVAiRDrY8CTBRFBR9HdY9Hz95O1UbeAShn9wwC65Wf3Kh+RMs2zmNH3NJFy3jLUGxlIJO2+VPlQlOIH3wC2CnlDoWx56dnBGhSfarKEcl71mA/nAJODHNYdSc1Kfg3b/MVbmhqwtkpDqoR8mUnJIQpcfJmDAyzA0TJlQ+4NU6o1E4rlRsq+4jxHQvXajEQ0nOR3qUNucUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0rxQiTdyQY6R4sctb//YF/L4C1SGMGY7sbzNRtaNrQ=;
 b=E0IrjaWL9CFGIy4RLsZ4dVYrqsi5hkXa9vzgPMz8h4imCLVI553SxjjhsrC2WrxHxm6xiKWAyosADdqI35uFrK/v9C+x6bKYj+LachiWwubjpiZnFNbD+hrFiP1cs1/ns8iujsXTGNYfWfWk0wmfDsXbrdSgDKWh7ZtrgwUMKSFD4TlMwmjkLvWffBD/92wXg8nWxAJItEd6y5r0as9pm1ePUxocQ3xOG7XKGi1WOpokoKVDiomq1FDPs0emRXlAsvGxAKvir7mz3eX7PEyGKgC1azLIYCPsLCBFfQEb8zf3plOBB3RxA55J4QLeNRc8U7qvgpf4xVuwJtLDj8mfig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DM3PR11MB8683.namprd11.prod.outlook.com (2603:10b6:8:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 13:21:09 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 13:21:09 +0000
Message-ID: <9d79f1e4-10d7-4261-bbdf-0670db202f36@intel.com>
Date:   Tue, 14 Nov 2023 14:21:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 4/5] i40e: Fix broken support for floating VEBs
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>, <mschmidt@redhat.com>
References: <20231113125856.346047-1-ivecera@redhat.com>
 <20231113125856.346047-5-ivecera@redhat.com>
Content-Language: en-US
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231113125856.346047-5-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0239.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::10) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DM3PR11MB8683:EE_
X-MS-Office365-Filtering-Correlation-Id: 42faeac7-e43e-4ff0-4a63-08dbe5149056
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfdZHvIV/OuCGR1wMoKB/Xn/Zj5MHr3NCl726LX4F5AsBOfmxq4n93K9JKqRmd308JUZflSEKNBjaiQ4hjk5TQtCKL7v3xFgICBwDjl45IU222HgQ72nj+P374UriL8KRvo2inVkndN+rG0FWikkY43BLtpXgJ8snkTj0/nisvz8B8J5pbcAzlytblEzFsvp4RirHMa6pfWd4cwb08yQTYnp4U46fyuD//iZPuP6WxgBrrWfN/9rekpwI6CtSQ4KNX2FuIhdu/+CAWwdu2NYE7Fe+k3hQ7fr4r9vZDkHeuJBsgkgWn7jXdTBRzKNDup8oyH1JX6LIvPhUYsJlh+QMytwZ5lKi+BpjkURSqabqIoJdT2AaL8KElJrgxu5tZE+OEspDDBom4Hg4AJmmIs9OsA6BDIQrJKD4Hlcm1pJVaGanurJ3C9eSe2NWuaW5d1DbpSa2o7nJ9McRnIFd6DSZiNyk4eYHg/3mUUKnul4kgnPp9zVkE8XeKHREbLac5HuZBEnZalUH6mvf6xfYmnfitb2B7KJb983+4m2z2s16V0i8TrTHUF1EOL9jw4S8Y9+r7WiQyMmgpEB45U6327NthB5R8RzUnjpMZ/mfc9cc5XnS0cGKatBN6z6GDfnS1WROyuNmhFHY4U55TbbtUiuGj//DOoVFfA5IxwSHYdhl5Qa1s+90ZKqNLX1ReYj/cs1UjoBvgWd0IEn8wsa1FRdWJfkK/rf+OuexN2W0hLqxEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(230922051799003)(230273577357003)(230173577357003)(1800799009)(186009)(64100799003)(451199024)(38100700002)(41300700001)(6486002)(31696002)(86362001)(36756003)(66946007)(316002)(54906003)(66476007)(66556008)(82960400001)(478600001)(2616005)(5660300002)(7416002)(2906002)(30864003)(26005)(6512007)(44832011)(6506007)(53546011)(6666004)(8936002)(4326008)(8676002)(83380400001)(31686004)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akxPVnIxUkdVd2E2bXdFRXBDdjNPZnRvdTBjTGFvWEFDN0IzRE1zTktiWkFq?=
 =?utf-8?B?ZWVwOWJDa1hBYjkyT1NtUkFsbDNrcVhuUVhwME42bUswK3pTRGhVUDF6Mity?=
 =?utf-8?B?ZWJIMnJ3R0R5WlVUcDZydDBHOEZmeVZMdVo0aXcwMmJOekNpMFlHNm5neHJS?=
 =?utf-8?B?MGR0ZndWZnNqSDFxSVkrbGp4VDUwNmFzY20yQm5MSW40QlNITEdONGNYY0xI?=
 =?utf-8?B?cm9PZ3NLeVJKRTFpcVRTM3JjTmVPNlkxOHpBSWJ2c1VweFlxbzVxeWNhZmtv?=
 =?utf-8?B?TTdNUTBkV0FkckVXakpyNjE0R3VHRk1hVXBjQmkxMFZpQkt2TXc4dFBsM3RK?=
 =?utf-8?B?bWtRUy9YNjdpT0dtZXVLa0dkK1NOUE1vVG5UQkJoYURHbUY1TnpZUTZ3TjZr?=
 =?utf-8?B?aFk3dzZLZTJqcTE1TEkzS1U3VE5nT0NEMk0wK1phcUFtYWEzRE1RWWdVa1Rs?=
 =?utf-8?B?b3k1RkUwZ3c0MXZ0YlJzTVNoaHA2dWltZ0w2b1B6akpja3RQK0x4V2l1UVNW?=
 =?utf-8?B?NFVFb0xYTWxLY0RGUEZ2cEQwL08zRzY2c1lqaFo0MGNtbkYvWVA3bUxOd1Fo?=
 =?utf-8?B?bzV4bkRHRVMyWUNPVVcvNzlXbjJ3WjA4ZFJIdjlqR0FpUXdzakZwUDhhMXBl?=
 =?utf-8?B?MjVnVG1jWjJLZ2E1Z2szSVJTNndsSTNzWVZPazFtVjVuRUtWMGVoVDZTSExP?=
 =?utf-8?B?eTY3ci83VUNob3hDYnl1aXdDZTRDSVlFY2JQV0VuckZaVkZBekFEV1o3S09Q?=
 =?utf-8?B?bHJWaVU5dHdwTHM0N0VDeEZUTWlJM1ovTVNLa0RRZjBYbUd4OFBGK1lqQmZE?=
 =?utf-8?B?cktadFIyODNldFBQYXBKOXp5UG95N1luOTNtMkU3cHM1SnE4eCt5MzYzNkZr?=
 =?utf-8?B?WHdlWTdSWGd4UUc2NVplSXFEeEJPZmNOZXJOSndoeTBhclBnV0E5YUFBd0xx?=
 =?utf-8?B?Zmh6RTU1MFUyR01EbkRoRHlCejlmVmE3VXd1WEc3Ky9zb3JITGVGS0thc0pm?=
 =?utf-8?B?QnNCMENzeEFyYTYvWWllSGdsdEJGa3JCSldTVUJYMVFXZmF4Y3RpZlNKaTZm?=
 =?utf-8?B?MkR1R1ZDaGUxSnc4bmp0alEvQjJZYXc1R05vWkVYQ1ljcHhDc2dFS2ZiWGg1?=
 =?utf-8?B?dWN2cU5jbStkbmlnREZiNjZoTDFQZS91R0tNM09QLzBOc3JNTzl3RkZReVRB?=
 =?utf-8?B?QUMvUWdFODBqZ1V1K1JHbVhGVnZCQ2duWmpSb1cwaVFSWVpCMFVhbGZKR29z?=
 =?utf-8?B?RnMxK2Z5eGxCT3hENzJRSXZJSGhGRWRFQXJIc3g3Rko4MkM1dWFzOTJMcm0v?=
 =?utf-8?B?MXVXaVBCenI2MXB4TmhCcTdlVkhjSmlHcWJjRk9LWjlGNERPTVNWR0k5RklK?=
 =?utf-8?B?NjVXWFBOWFJVQUtlM3MxMnljaW9xTUpiZjd1bkx5blI2MU15T251OHZSSjBk?=
 =?utf-8?B?RlA1R1ZUUEo5akJLYkNSc1Nmd2U3czV2Nm1FVkU3T292NXVNN3FiYTZLeVox?=
 =?utf-8?B?ZFdFRHhVSzUyckZsSjczV041NWRxbjZzQThMdTFWYTdtbHVnMVViczA3R1J5?=
 =?utf-8?B?Z24xOUs4cU4zM2dVNTZTazJyUDFEd2ZkOVIrbjhkckhZUlZVOHE4cU1lbHZr?=
 =?utf-8?B?eWRBMDJwNmtJOTBBUjhPbGZORWFjdzNreVlpQ1RUTUNhVGpPbkc1Z1NhcWFx?=
 =?utf-8?B?Z051S0VPNG42d29BdGdxUEdPWUpXdCtlVndRYklUV3ZTZVZxYUJEMmNGd3dL?=
 =?utf-8?B?Mi85UENyWHZsbTZNcEx5ZnV5OUNkQXNReDVJQnF6Q01Ob0kxNUFiM2kyT2JE?=
 =?utf-8?B?b0tBLzZMNU1LYXo2OGJnMjBWcVZKNjMwZU04OXpONi9lUHhFYVhqUjArdGdz?=
 =?utf-8?B?WFpPWWM4VWR2RjRyYXZFNHlSTGFwbi94TUlEd0ZYV1lHQXovSGQ5TURpWkt6?=
 =?utf-8?B?c3dXWm8yZ004bEZSV0U0Z3I5U2tiNHB0NVVLRUdTK1FRZ0ZRVTlBQXhPek5x?=
 =?utf-8?B?cVZKNEpydGhudUxZNXlVd3E0RWN1QUt4aWJMdUpLRlU2UVJPRFRFVnh2VUtj?=
 =?utf-8?B?OXJZKzZhQkpDeFN3SkdyWUpYMVhZMVNIdU1SbVBnWk8xWDlscDU5dkJrV0I1?=
 =?utf-8?B?RWpuMDlObXdiVFZtVWVYMzM3UGhVMU9Qcm10VHl3UHV4M2lrOS9GNkkrOVZW?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42faeac7-e43e-4ff0-4a63-08dbe5149056
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 13:21:08.9295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ba2mZa7JSUXZJ3yFg9et4IppAoPNCanFD9WOFqV80U+eiCVbNnV+/QEh40poyVUatJoSoqnmQhoQ2aNo7mCPhTZuycVHsarLb8DE92Ao0xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8683
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.11.2023 13:58, Ivan Vecera wrote:
> Although the i40e supports so-called floating VEB (VEB without
> an uplink connection to external network), this support is
> broken. This functionality is currently unused (except debugfs)
> but it will be used by subsequent series for switchdev mode
> slow-path. Fix this by following:
> 
> 1) Handle correctly floating VEB (VEB with uplink_seid == 0)
>    in i40e_reconstitute_veb() and look for owner VSI and
>    create it only for non-floating VEBs and also set bridge
>    mode also only for such VEBs as the floating ones are using

nit: Too many "also"

>    always VEB mode.
> 2) Handle correctly floating VEB in i40e_veb_release() and
>    disallow its release when there are some VSIs. This is
>    different from regular VEB that have owner VSI that is
>    connected to VEB's uplink after VEB deletion by FW.
> 3) Fix i40e_add_veb() to handle 'vsi' that is NULL for floating
>    VEBs. For floating VEB use 0 for downlink SEID and 'true'
>    for 'default_port' parameters as per datasheet.
> 4) Fix 'add relay' command in i40e_dbg_command_write() to allow
>    to create floating VEB by 'add relay 0 0' or 'add relay'
> 
> Tested using debugfs:
> 1) Initial state
> [root@host net-next]# echo dump switch > $CMD
> [root@host net-next]# dmesg -c
> [  173.701286] i40e 0000:02:00.0: header: 3 reported 3 total
> [  173.706701] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
> [  173.713241] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
> [  173.719507] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
> 
> 2) Add floating VEB
> [root@host net-next]# CMD="/sys/kernel/debug/i40e/0000:02:00.0/command"
> [root@host net-next]# echo add relay > $CMD
> [root@host net-next]# dmesg -c
> [  245.551720] i40e 0000:02:00.0: added relay 162
> [root@host net-next]# echo dump switch > $CMD
> [root@host net-next]# dmesg -c
> [  276.984371] i40e 0000:02:00.0: header: 4 reported 4 total
> [  276.989779] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
> [  276.996302] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
> [  277.002569] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
> [  277.009091] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0
> 
> 3) Add VMDQ2 VSI to this new VEB
> [root@host net-next]# echo add vsi 162 > $CMD
> [root@host net-next]# dmesg -c
> [  332.314030] i40e 0000:02:00.0: added VSI 394 to relay 162
> [  332.337486] enp2s0f0np0v0: NIC Link is Up, 40 Gbps Full Duplex, Flow Control: None
> [root@host net-next]# echo dump switch > $CMD
> [root@host net-next]# dmesg -c
> [  387.284490] i40e 0000:02:00.0: header: 5 reported 5 total
> [  387.289904] i40e 0000:02:00.0: type=19 seid=394 uplink=162 downlink=16
> [  387.296446] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0
> [  387.302708] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
> [  387.309234] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
> [  387.315500] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
> 
> 4) Try to delete the VEB
> [root@host net-next]# echo del relay 162 > $CMD
> [root@host net-next]# dmesg -c
> [  428.749297] i40e 0000:02:00.0: deleting relay 162
> [  428.754011] i40e 0000:02:00.0: can't remove VEB 162 with 1 VSIs left
> 
> 5) Do PF reset and check switch status after rebuild
> [root@host net-next]# echo pfr > $CMD
> [root@host net-next]# echo dump switch > $CMD
> [root@host net-next]# dmesg -c
> [  738.056172] i40e 0000:02:00.0: header: 5 reported 5 total
> [  738.061577] i40e 0000:02:00.0: type=19 seid=394 uplink=162 downlink=16
> [  738.068104] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0
> [  738.074367] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
> [  738.080892] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
> [  738.087160] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
> 
> 6) Delete VSI and delete VEB
> [root@host net-next]# echo del vsi 394 > $CMD
> [root@host net-next]# echo del relay 162 > $CMD
> [root@host net-next]# echo dump switch > $CMD
> [root@host net-next]# dmesg -c
> [ 1233.081126] i40e 0000:02:00.0: deleting VSI 394
> [ 1239.345139] i40e 0000:02:00.0: deleting relay 162
> [ 1244.886920] i40e 0000:02:00.0: header: 3 reported 3 total
> [ 1244.892328] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
> [ 1244.898853] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
> [ 1244.905119] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> ---
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    | 29 +++---
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 89 ++++++++++---------
>  2 files changed, 68 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> index d26348db125f..b2e3bde8ae1d 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> @@ -829,10 +829,14 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
>  
>  	} else if (strncmp(cmd_buf, "add relay", 9) == 0) {
>  		struct i40e_veb *veb;
> +		u8 enabled_tc = 0x1;
>  		int uplink_seid;
>  
>  		cnt = sscanf(&cmd_buf[9], "%i %i", &uplink_seid, &vsi_seid);
> -		if (cnt != 2) {
> +		if (cnt == 0) {
> +			uplink_seid = 0;
> +			vsi_seid = 0;
> +		} else if (cnt != 2) {
>  			dev_info(&pf->pdev->dev,
>  				 "add relay: bad command string, cnt=%d\n",
>  				 cnt);
> @@ -844,23 +848,28 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
>  			goto command_write_done;
>  		}
>  
> -		vsi = i40e_dbg_find_vsi(pf, vsi_seid);
> -		if (!vsi) {
> -			dev_info(&pf->pdev->dev,
> -				 "add relay: VSI %d not found\n", vsi_seid);
> -			goto command_write_done;
> -		}
> -
>  		veb = i40e_veb_get_by_seid(pf, uplink_seid);
>  		if (!veb && uplink_seid != 0 && uplink_seid != pf->mac_seid) {
>  			dev_info(&pf->pdev->dev,
>  				 "add relay: relay uplink %d not found\n",
>  				 uplink_seid);
>  			goto command_write_done;
> +		} else if (uplink_seid) {
> +			vsi = i40e_vsi_get_by_seid(pf, vsi_seid);
> +			if (!vsi) {
> +				dev_info(&pf->pdev->dev,
> +					 "add relay: VSI %d not found\n",
> +					 vsi_seid);
> +				goto command_write_done;
> +			}
> +			enabled_tc = vsi->tc_config.enabled_tc;
> +		} else if (vsi_seid) {
> +			dev_info(&pf->pdev->dev,
> +				 "add relay: VSI must be 0 for floating relay\n");
> +			goto command_write_done;
>  		}
>  
> -		veb = i40e_veb_setup(pf, 0, uplink_seid, vsi_seid,
> -				     vsi->tc_config.enabled_tc);
> +		veb = i40e_veb_setup(pf, 0, uplink_seid, vsi_seid, enabled_tc);
>  		if (veb)
>  			dev_info(&pf->pdev->dev, "added relay %d\n", veb->seid);
>  		else
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index e7be145f298a..6ae1206e1c1c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -10379,41 +10379,48 @@ static int i40e_reconstitute_veb(struct i40e_veb *veb)
>  	struct i40e_vsi *vsi;
>  	int v, ret;
>  
> -	/* build VSI that owns this VEB, temporarily attached to base VEB */
> -	i40e_pf_for_each_vsi(pf, v, vsi)
> -		if (vsi->veb_idx == veb->idx &&
> -		    vsi->flags & I40E_VSI_FLAG_VEB_OWNER) {
> -			ctl_vsi = vsi;
> -			break;
> +	if (veb->uplink_seid) {
> +		/* Look for VSI that owns this VEB, temporarily attached to base VEB */
> +		i40e_pf_for_each_vsi(pf, v, vsi)
> +			if (vsi->veb_idx == veb->idx &&
> +			    vsi->flags & I40E_VSI_FLAG_VEB_OWNER) {
> +				ctl_vsi = vsi;
> +				break;
> +			}
> +
> +		if (!ctl_vsi) {
> +			dev_info(&pf->pdev->dev,
> +				 "missing owner VSI for veb_idx %d\n",
> +				 veb->idx);
> +			ret = -ENOENT;
> +			goto end_reconstitute;
>  		}
> +		if (ctl_vsi != pf->vsi[pf->lan_vsi])
> +			ctl_vsi->uplink_seid =
> +				pf->vsi[pf->lan_vsi]->uplink_seid;
>  
> -	if (!ctl_vsi) {
> -		dev_info(&pf->pdev->dev,
> -			 "missing owner VSI for veb_idx %d\n", veb->idx);
> -		ret = -ENOENT;
> -		goto end_reconstitute;
> -	}
> -	if (ctl_vsi != pf->vsi[pf->lan_vsi])
> -		ctl_vsi->uplink_seid = pf->vsi[pf->lan_vsi]->uplink_seid;
> -	ret = i40e_add_vsi(ctl_vsi);
> -	if (ret) {
> -		dev_info(&pf->pdev->dev,
> -			 "rebuild of veb_idx %d owner VSI failed: %d\n",
> -			 veb->idx, ret);
> -		goto end_reconstitute;
> +		ret = i40e_add_vsi(ctl_vsi);
> +		if (ret) {
> +			dev_info(&pf->pdev->dev,
> +				 "rebuild of veb_idx %d owner VSI failed: %d\n",
> +				 veb->idx, ret);
> +			goto end_reconstitute;
> +		}
> +		i40e_vsi_reset_stats(ctl_vsi);
>  	}
> -	i40e_vsi_reset_stats(ctl_vsi);
>  
>  	/* create the VEB in the switch and move the VSI onto the VEB */
>  	ret = i40e_add_veb(veb, ctl_vsi);
>  	if (ret)
>  		goto end_reconstitute;
>  
> -	if (test_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags))
> -		veb->bridge_mode = BRIDGE_MODE_VEB;
> -	else
> -		veb->bridge_mode = BRIDGE_MODE_VEPA;
> -	i40e_config_bridge_mode(veb);
> +	if (veb->uplink_seid) {
> +		if (test_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags))
> +			veb->bridge_mode = BRIDGE_MODE_VEB;
> +		else
> +			veb->bridge_mode = BRIDGE_MODE_VEPA;
> +		i40e_config_bridge_mode(veb);
> +	}
>  
>  	/* create the remaining VSIs attached to this VEB */
>  	i40e_pf_for_each_vsi(pf, v, vsi) {
> @@ -14716,29 +14723,29 @@ void i40e_veb_release(struct i40e_veb *veb)
>  	/* find the remaining VSI and check for extras */
>  	i40e_pf_for_each_vsi(pf, i, vsi_it)
>  		if (vsi_it->uplink_seid == veb->seid) {
> -			vsi = vsi_it;
> +			if (vsi_it->flags & I40E_VSI_FLAG_VEB_OWNER)
> +				vsi = vsi_it;
>  			n++;
>  		}
>  
> -	if (n != 1) {
> +	/* Floating VEB has to be empty and regular one must have
> +	 * single owner VSI.
> +	 */
> +	if ((veb->uplink_seid && n != 1) || (!veb->uplink_seid && n != 0)) {
>  		dev_info(&pf->pdev->dev,
>  			 "can't remove VEB %d with %d VSIs left\n",
>  			 veb->seid, n);
>  		return;
>  	}
>  
> -	/* move the remaining VSI to uplink veb */
> -	vsi->flags &= ~I40E_VSI_FLAG_VEB_OWNER;
> +	/* For regular VEB move the owner VSI to uplink VEB */
>  	if (veb->uplink_seid) {
> +		vsi->flags &= ~I40E_VSI_FLAG_VEB_OWNER;
>  		vsi->uplink_seid = veb->uplink_seid;
>  		if (veb->uplink_seid == pf->mac_seid)
>  			vsi->veb_idx = I40E_NO_VEB;
>  		else
>  			vsi->veb_idx = veb->veb_idx;
> -	} else {
> -		/* floating VEB */
> -		vsi->uplink_seid = pf->vsi[pf->lan_vsi]->uplink_seid;
> -		vsi->veb_idx = pf->vsi[pf->lan_vsi]->veb_idx;
>  	}
>  
>  	i40e_aq_delete_element(&pf->hw, veb->seid, NULL);
> @@ -14756,8 +14763,8 @@ static int i40e_add_veb(struct i40e_veb *veb, struct i40e_vsi *vsi)
>  	bool enable_stats = !!test_bit(I40E_FLAG_VEB_STATS_ENA, pf->flags);
>  	int ret;
>  
> -	ret = i40e_aq_add_veb(&pf->hw, veb->uplink_seid, vsi->seid,
> -			      veb->enabled_tc, false,
> +	ret = i40e_aq_add_veb(&pf->hw, veb->uplink_seid, vsi ? vsi->seid : 0,
> +			      veb->enabled_tc, vsi ? false : true,
>  			      &veb->seid, enable_stats, NULL);
>  
>  	/* get a VEB from the hardware */
> @@ -14789,9 +14796,11 @@ static int i40e_add_veb(struct i40e_veb *veb, struct i40e_vsi *vsi)
>  		return -ENOENT;
>  	}
>  
> -	vsi->uplink_seid = veb->seid;
> -	vsi->veb_idx = veb->idx;
> -	vsi->flags |= I40E_VSI_FLAG_VEB_OWNER;
> +	if (vsi) {
> +		vsi->uplink_seid = veb->seid;
> +		vsi->veb_idx = veb->idx;
> +		vsi->flags |= I40E_VSI_FLAG_VEB_OWNER;
> +	}
>  
>  	return 0;
>  }
> @@ -14817,7 +14826,7 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
>  				u8 enabled_tc)
>  {
>  	struct i40e_veb *veb, *uplink_veb = NULL;
> -	struct i40e_vsi *vsi;
> +	struct i40e_vsi *vsi = NULL;
>  	int veb_idx;
>  	int ret;
>  
