Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C997F200F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjKTWSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjKTWS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:18:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAFBC3;
        Mon, 20 Nov 2023 14:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700518706; x=1732054706;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xwp2pymkadQpE2IAV9nZ+5NMqZ1S9VhaMxdOi+lURb0=;
  b=nEi0DjxeeU3L+K2rjyYRyq9scFt9xm2DkDgvfAGZ8B6UVvMs5aK9tkNa
   Efmer30Vgq47lnQSyU48T233QC+rFBDYSBGg65ruu0MMAJdgo1vNqMIDg
   R/24IwHN3fFm4qVM8WyajXRP5UIW1Rl2RWtmrgdd5lutQZXmUjROsHYjO
   R6tMHf6iPZxLEzC9I8DcMSuHG5QZ5ELTrZ2B63iUrJe98M5KxjaVADwXr
   ysONIyKsBbdWsWz4KmcAHmCDx3Ue+nIzA4VxRvSvMCGZdWruIWT1dU+mh
   DtvUFfip9Gimc59oF07lLN84lSmAmwyZK4n46FTDgOxBlxCkcoFF2Di01
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="391498567"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="391498567"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 14:18:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="832419565"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="832419565"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 14:18:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 14:18:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 14:18:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 14:18:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrzLbhhh6tkM8NUO+WpVDY8xiOjglm3MxpDX256deT838DB7dw26hv0MtCOFE2xFSK6geG2sgha7Uc/ZrXW0vkEjDHxlinHeWuAgZwD6JXnJDyWlKV1INScuaGJMxKHpSzAFOM2xZ9a9tw2vVS7YifJ9Oyp0yABE6kfoPAYmYULP/NtlsKK1roq5oMg9oelLNorRouGwhZJkivyCLuq5FYM6D2FaIXymvPDxYQFy6AnwBKVJCksVgY/DQwQm/qDCMklZj1XJd37BP0BgGhw2lkxhfMDGr/hktE29mj/crRCRdTnxgxElwvh5CkLgX4Tgd077IZ5e1tpAhnpFMMw29A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8oUHXdhRAcMWxOJT9L5+wrMqgUEQdW5FP4ry75tSZQ=;
 b=EV8iIQHNDYBiTQ23r9jVji2IDP6OKVKVeAEATIuaeauRN/w9/gcLhl5+O6X0m4HllDJrahGSChwjyXURCy+QrnunTDvtcN2DzzB2vNZ+iVXkNWr10TBQRUQ6T0H25bNWbTFLLojsumZv3U/vOuTbPtENy4yj2dvAJc7RI4+HpMmSqctKYM09MEs40lKoAujNLhQI/ExpY8Dyw77wkLmdizOLrOsSqNZ0VdCqsJzquLevtOZcVgpOIGiWTshrlNWX1bDvGiqyodBE8Gq0H13HWHHuvrIBiiiKX1VRaZX0g1UE4aRHQHGSohENbvzyBaYtoND6Bx5LUFzsQqc8lW35wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN2PR11MB4678.namprd11.prod.outlook.com (2603:10b6:208:264::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 22:18:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7002.019; Mon, 20 Nov 2023
 22:18:22 +0000
Message-ID: <3afbbc76-3dd7-42e8-9034-514176582d08@intel.com>
Date:   Mon, 20 Nov 2023 14:18:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/8] x86/resctrl: Prepare to split rdt_domain
 structure
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20231031211708.37390-1-tony.luck@intel.com>
 <20231109230915.73600-1-tony.luck@intel.com>
 <20231109230915.73600-3-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231109230915.73600-3-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:907:1::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN2PR11MB4678:EE_
X-MS-Office365-Filtering-Correlation-Id: e5661267-f77f-465c-d650-08dbea169bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FDnA7o8E/6kbpWfIXXIdqo0LYSppFwV/iWksX1Y90YGEXmJtttZZnyCJffNbVkmC+m2eRQA7CW/FOqR9qqgn2+BsF33rsgKjQcipKreCzka4R5Dj0VRexeCI/cR7bR9kPcGhcbxQv6BpaOWnajVT3xAHcEAfoscvf/qCt6VgqL16Qm77KesOkNZuXG++pTyog2KtmjYHG/g5U8dtuUOZW+YQ3W3lNMXVl1duWFw5SJrZwLJjjCZlZ2vI0VLJnzsbiiR+wiXj2WpW95AAxHHGDjXrGYTk/iNobVxLvuiJPXIZO0z2HVZLhlWfximprKsJXactc4w6wwBQTYmsymoK3iptJkeYaTvYeJOS7D6AWV/6FJNGAPOuBgSFucbemwChRbaG5+jmvdgtNZwHQypOJz7uY43fgC9g9UrlFpt98KFtqA8+UdGC6874yzazmyL4Sn5IHKQ6INynpNfgonnVtdYrq8bgyzVk2sLpIIUsVBcOHZVotV1lGco4uRInTznft70jleLfgMMviW/uTLoz+yEhY+vMXZ1uokJO78LR9Ca5LPNpS1B6xxQdo5dLPhtAIKJ1byVli3kK0KLi6kR/MQRpsJsSy2z3Q6sAhM2WWbvgYLNSM7DuBIGiR0TUB+/Z7F+OiJ/7O8r2G8JBYQGubw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(44832011)(5660300002)(31686004)(2906002)(4326008)(8676002)(8936002)(41300700001)(7416002)(4744005)(66476007)(316002)(54906003)(110136005)(66556008)(66946007)(86362001)(6486002)(478600001)(6512007)(36756003)(53546011)(6506007)(2616005)(82960400001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm14SkhQU2pnYURaYTB2QkxrWUJyT3pQa2pFTUZmY2pYalZSU0NLOGdVdHAy?=
 =?utf-8?B?NzBsWDZtaWJmSUdHdjRZSGtmaVNtY2FXY3dabWtzWUJZRGxVeXBzOWF6S1VK?=
 =?utf-8?B?TmNuVnptUGVNNnFtN3RiNjN6SXJKcjgyR1RsZXU5Qk0xTk9RK1ArR3QvMDJo?=
 =?utf-8?B?VDZqZ3NIRE55MFUxSWM2Rk56bGplQ2lVeldyZkg0Z0FLTnpSMUx2b3FJWmlM?=
 =?utf-8?B?Y2grZ01QQnJiZkhZd3dOOVhNZ0c4bFVSMWJ0VndRVjRFUVBSTmZHY0wyVDk5?=
 =?utf-8?B?Z05pNHVNaU5CTHprQlNybjE2N1ZrZmZDaVQ3UmFVaFcvdXNVNHBKS2d4YjNx?=
 =?utf-8?B?bWdoWmRPdkxuWk1YMEVZQ3llNXVRbkxHdjExem9IV1VFY1F3cytRVDhJTjBz?=
 =?utf-8?B?Yks0bnQvRXdvV0ZvMkU2TnZ3U212R3hZMHBCMHFkRnFtV2puc01uc0FwVm9o?=
 =?utf-8?B?MExVS1phTTJmbUhMcm8zNjJGV05uVlZvNFcxMFV5RVl5VG96L3JuSGVvUnlG?=
 =?utf-8?B?SWRybGJoOFNZWHNDcnVpN0V2MitWb3Brd1k2TzFUSmpGQmxOdjhuMW5tYXBi?=
 =?utf-8?B?MVJodkR1dTVvV0ZINzdXdHJoTTZBMHBiWTd3TURCSUtBajQ2azNFMlFtd1pZ?=
 =?utf-8?B?aEVYZ3VnVkxiZXNLOS9Wd1dFYzNXU2d3RHhseWNaaTRBa1Jkdlk5Ti9qUFVx?=
 =?utf-8?B?UWZkQjhwdE16Q0Q4elhMa0tqYzBNRzFvNHMyYk1pdVB1TjkreW43aFY1NDJn?=
 =?utf-8?B?VmZYU09jcW9SeEVGU2FxQjZDdXdGY25LWm9aZThzcHlJRCtRZGxxM0gxRTY3?=
 =?utf-8?B?Sk9DTmFPVURLT2hYOU1jSUE2Zzdjdm1xLzVkbjV6TEJWWlJGSjZDZkkzVk5N?=
 =?utf-8?B?dVN4RjVNWFpqYlJSazlSTWFtekVweEtIajh3WUlVWGR4blRYNWlCVmVRMnE3?=
 =?utf-8?B?Ky85RnlKdW9tK1gzV3VRQ3ZSdysrVkNTTkVxS2hwK0JxT2I2Nk9EM21Fa1Fh?=
 =?utf-8?B?N2g1Sk5SbXBXNEpsZUFuRFU2cGlUcW1qMFJ6V3NCM1pEcll4UzRCeWxvNjVF?=
 =?utf-8?B?anI5OFRGMEFNeDRoYmNZZTZ3NVJpbGQyTDVkM2xPcWN5c2p0eno5azZyOUJR?=
 =?utf-8?B?ZXppamJtaTdjV1BzaEIwSzVzZnA1Y3VnVzlqS0FlOEk4RXJSa1pZdXFneGVp?=
 =?utf-8?B?cTU4bjIxZHNSaU5YOGhkM25pRkRTVnpKUkFDYXRWZ1dhSXk1N1ZvVm1EaXUv?=
 =?utf-8?B?Szljd21ianJGczNyTzJjOWZabDZ4NklTMUM5N2NpcHN0S1YwUml3VFl2UVds?=
 =?utf-8?B?ZnB5SXhPb1B4cjJLTE9RamFCS00wa1VTWlVFbytZcjFsUElBZzBuREF5OEgr?=
 =?utf-8?B?ZTVoTXoxRGxnOGxvNUhzVWFwRGZwYko5S0tmU2FjaXBXWlh5OTIvdzdkcVZ5?=
 =?utf-8?B?STNURENQSVcvTFdQQTE1NU5zc1hRT0F6aitJNlFTTWw3aGZhQWF5WU9jaS9x?=
 =?utf-8?B?N29SU0Q0cU0rWnZmWEV0WmVFY3J0aVdXYlM5YnZ1b1VXU3pLcE9RTDVhOTJz?=
 =?utf-8?B?elJscFJ4bmp5aktjU0EyMnpXdTV4Y0p4YnFEMkRHdjUyV0lJS1ZvbVFvYnpr?=
 =?utf-8?B?S01na1JTbk9ST25tbU5PeHI3NzhueFNPOERlQUxXTDl0V2RESTEzMXExblNn?=
 =?utf-8?B?YjFFaTFzdTNubnNmQ0JGWkl1UXZ5YTJxYUJaaGxuNVdqcmNKWmZvMGVWUEFG?=
 =?utf-8?B?QnNiSEczeUk1SWN5eEswSkg5cFp1Z0ZuLytzTCtlNmxqNkxTY2Zsa3hNTGEr?=
 =?utf-8?B?eHlKemxVbldBUThGcnBhOHpFd0xoSmFjRW5ySHc1Wml1WUp2dWNMUFk0aC92?=
 =?utf-8?B?dUFtN1YybHl6R1BzSGVKdlhsR2hrYnFWQ281cDlXVU1XMG9tL0x2SVljdU1s?=
 =?utf-8?B?elpEeWwyRXRUbWZLQ2habnZ6MVR5Vmw1YkJGRklSRC9JNmRpenB1eHRCRmkx?=
 =?utf-8?B?QzJKL1h3TFZCdTFYdlFkZWZpc21NZng2WDhScmlQMDJMci9RM3BqSXNkbFp2?=
 =?utf-8?B?eWR5V2tQNUorNmhKdkNTRVBGNXU1bmdHemU1bkN4cDZLc0x2QzE0UXQzOWpv?=
 =?utf-8?B?V2J2VU1HUjl3ZE1qb2svbEo5QTUxS2c5eXBXd1lCRjhXK3h4RU5CaXpqdFdt?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5661267-f77f-465c-d650-08dbea169bca
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 22:18:22.8224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtQrtkfXMRHgQtRXbbzHjK5wVPUKJebzfa+PrZjUHk5GGWr4CCwT31cuonoSN+cPkULY4nMCh/23Bl3bjpaRQInxBoO4EnbTRW2VPJkNFuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4678
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

Hi Tony,

On 11/9/2023 3:09 PM, Tony Luck wrote:
> The rdt_domain structure is used for both control and monitor features.
> It is about to be split into separate structures for these two usages
> because the scope for control and monitoring features for a resource
> will be different for future resources.
> 
> To allow for common code that scans a list of domains looking for a
> specific domain id, move all the common fields ("list", "id", "cpu_mask")
> into their own structure within the rdt_domain structure.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
