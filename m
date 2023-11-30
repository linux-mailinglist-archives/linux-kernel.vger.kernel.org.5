Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72387FFDFC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377013AbjK3VwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjK3VwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:52:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A73A8;
        Thu, 30 Nov 2023 13:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701381137; x=1732917137;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AjWTFXa1zI+JZY0NIOfCaOWiJ/14hFcMVqhTAuPzNZU=;
  b=WL/XXRn+8vPDtWP4XMmb9kSe+6HtygPacmKDU2PdQIWFBuA7XDRB/E31
   /0ItGPGj6YukF2TQVbiwv+T1srMv2JUqurRqL66/nuw/Yej98AhQg7c+a
   X4UF3z7UeAs0Kcg4ymmIxMSPNIndeIoR/SAA2W78gKsjtR3XUqD30JDOs
   Y0j6qN4rlx8EEb+MNTlClDV3PZkkfyC/+TZMZNMO33T/CdUNhSLWVD1d/
   GLa5h0CIX2lnSjAUyd0c4WMmTnO27Cvf3J4RXvfEt84fuJzsVJ4U6KhpP
   ivq5mSgWkmmm/oWrgwiLSrvP4jgDBLm7y6eT8PWnW6Tft4jSIhqjgv+zm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="397286396"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="397286396"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 13:52:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="942859909"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="942859909"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 13:52:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 13:52:14 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 13:52:14 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 13:51:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dii441K23q+ha+wd/o/OzL3YcWJ4xaBGKkQc479Ol3iMI3KbUQlLkA3d0quQp60e0cVxDa3UTQ1LYu5XcQgBgrPlffvyDhh7RFVIqLvZSWy0AKDEzWfMS9I+FNL1KAtsJJQioLeFrDurfu0wQLPAenJUNkL0fMrLCt1yG7zPMcaW1tuo+Lmu6ktgCkSoidosXcvaJ+NO3K2L0QztRKwb/ZFlE4J1mKLhZfL2jaS6Y+Oq6yyOGVHngX5xG8QDKDtgA/o2ZwtTsW9vNUKsggSEqKgBG9ndhrTRu786MuXDjrO7W8GWI7UaY/4azpQhop2wGKRh5H/odktCzfOrGMaf2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b26tOHVatqkxocg6CthT51/Kg6DEi0xcKbUBFb4vEa0=;
 b=YZwyx4RAGTrxGJhu0erbQWo8KXpfNduxXeAua/8TCdTVsxjtivOY89ZngzN3V1DvMIDGyB+ajBtxngm4GzF5Qrc+OHG5ntJdM95W/Es489Kous+wJ0mOpzFR1blGFpRF4Jr6rNaIv7iLEp2VaTQKhGjtI1a7iECcvlYkFGDlmUhwAPrB/i8G/ahHfOEkolNfothN5kD0DZwnx485ZKhsp39zLdL486oodex98Uezq5E0zh+7tzx5FrU19/ReaZzsi/QC4lt5z8rAqjf0K9nd/kgX8Cm9it8qT83v3OqcmXNPMwfgM/tQhw3k3WMDt+kGKcxhvvQuy9mALq/wH9Ipvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5315.namprd11.prod.outlook.com (2603:10b6:610:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 21:51:56 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 21:51:56 +0000
Message-ID: <cb925ffc-7c36-4a81-a61d-adc4d7e793e5@intel.com>
Date:   Thu, 30 Nov 2023 13:51:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/8] x86/resctrl: Prepare for different scope for
 control/monitor operations
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
        <patches@lists.linux.dev>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20231109230915.73600-1-tony.luck@intel.com>
 <20231130003418.89964-1-tony.luck@intel.com>
 <20231130003418.89964-4-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231130003418.89964-4-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0389.namprd04.prod.outlook.com
 (2603:10b6:303:81::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5315:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e8b28b-7075-4a84-ab9c-08dbf1ee9259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWJ941bLIx2kMAdSpKA9qC9Y5RurbY+AYN12dJzHiYMXEPKYeLOfYKygJ121oZiy3SX2M4aVDFbH41KsxKD62Z40yxU78Try8eWhPtPHIts+EpUJe/tNRCbplsLYqPJVcZFUwLgTf6w5w76qp6zudu+YESVrBJkkq7ifDnE+QPQWTI3eirNCodqLN7urUKwTYtPW4qrnzHZVmyKpd/uPCEmO7SE+w+sn/xDh9sQock1Uv3qUyy7k6dXo0Rrp5fCi9AerTFvZ56uLXJfZar3Jgb95v8LOrs5XHQwSF2FJ0HnY3eNL0BrnDLc4c5Pn95VQ7zAuU+mdwWqdj7d1+TN1w8C5/nCY/gBf4cAKUEGj49kKHUFANFR7VHUyuuKdTtdpkanqc1IJ62L3CKS7zs26fadirfQ5FSBR78MYkiaiRQL22HMnNjFS7Q+iFXbNC9bo1FOGkiLBnM8Hp531tH9f4r3Jcde2uMAqscYSw5PYH0M89gnvD9WTXTNvObkg5fMEJrmPIMEZRp0jKWZkfr5280cVdqlQJ92G1iZS1jNo6SlkhWOX0ZHq6N42oS6271U9osKu7yyvtj3RjFBDuU67M84ew/ILqL3wP1FRmsLTtZCwW6YABQz6iGnB1nv8cLkOu7GUlhJedIhqkgjsOXnu2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6506007)(26005)(53546011)(6666004)(6512007)(2616005)(44832011)(41300700001)(8676002)(4326008)(8936002)(5660300002)(7416002)(478600001)(2906002)(6486002)(316002)(110136005)(54906003)(66556008)(66476007)(66946007)(86362001)(31696002)(36756003)(38100700002)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTNCQzR0L2svS2g5ZHBrREUvaW1adGZtdGROano0YTlHNVNhRTlJd256eWkr?=
 =?utf-8?B?UGVETzJEQWVjNGk0bVkrNmZtS29WQXd3OFFlamVoRnJoNG8vTVJNQkZPd2Rs?=
 =?utf-8?B?dGlrYm5GdWRyRjZmNVkxdnlTMFhQNCtXaGsvL3lrYWVZbnFzei8yOFFmRE5n?=
 =?utf-8?B?eERZTEp6UGtVWE52YnVFaTFJZkE4UVEzc2UzUndtZEdLK3BMRyt6SkZKam8v?=
 =?utf-8?B?K2xWOXo0NzBRTFBYbzQycGpISS9WSGNvYXFyRGJTK09POGdCQjNkMjhGeC94?=
 =?utf-8?B?SzFqdHZSNjlXWk9tNDU3SVhxYllXZ2xwcDB2aTY1amdRcmhwUmNsRmdtOXpx?=
 =?utf-8?B?YlF1dEkwd1ZBMDVlU010RE5vWnQrclBWTituanNibFZ2OUxhR3FQSWJNVDJ6?=
 =?utf-8?B?TGRTMUw5YUNaa0pLbk9uVnhOci82UXZsNUJtaXlCQXdSWEVjWGFGS1NsK0xV?=
 =?utf-8?B?RWxzUFZhY0x5OE9YQVh0VmtpZFBHcDhjK1dHVndsdWRKNlRiN1U5ejM5L1hM?=
 =?utf-8?B?VVg4aml6ZFdNTS9yK3NGaWpVbFhVZ3V6UVJIeGh6NU5XYTR1eHlSVExpaG5i?=
 =?utf-8?B?UVliV1VsdGc1dG1JeEFabDJEamlDQ1FHbjhkd3Y5L0dsbE4ybDJMeVd6dmlz?=
 =?utf-8?B?YnRIT0Q3QXd4NXN0TU1GLzFzQ0U2SjBuVTVhc1VyRXloU0p3UzJ3bCtLNzgz?=
 =?utf-8?B?NHAwaGFudFNoUEtuemVpcnJETm1OT010S1RYRGVoZmI3QkNlcVYzYUZSSEJI?=
 =?utf-8?B?ak5MaTM3dGdJWlNJV1h4OEJiTGJWS1NPUVNNWGRxb0NicS8zN2ZsQUh6WHIv?=
 =?utf-8?B?bFdnM2dPdDkvNFU4NDN4T0h2czM5UnpKSVl5VmloOU9iTU9BcE1aakRTQ2FS?=
 =?utf-8?B?YlpBbE1Lc1RjWmwrbEdiYWdPTU1LMURvellEMlE2cFlzdlB3OW1neXpJYkpz?=
 =?utf-8?B?Ty96WjNCSFppK05VMjBtTkk5TVVycDRaWWZ4cnFRTHZYODZ3SHFyRFFLQWM2?=
 =?utf-8?B?RlZCb24vb1l0RkZiaGFOSDdLaVlUdXI2d3VOV0NWQkhWRis3RnpVUlptVXRk?=
 =?utf-8?B?blhRTVRVd0tyQ2lUdWR2QU9jNnNDWVZJcERENmJzc3JrQjYrUkFlZGdzVk9Z?=
 =?utf-8?B?d2tTTzFwQVN4NmZyYzNSK2U4Y1VtVVJSYVhBTUVYbHA2YzBkeTNXVUhHMTJK?=
 =?utf-8?B?RGw3d1Nud0ZsMWJwZnF3dGQ1QklKd1hSUFBQM0ZpeWUyUVduYlZzR2hTOW9p?=
 =?utf-8?B?NitxaXNjZW5MUVIxUlZrR2NFclpNVXBsR2ZYN1dGU1FER083VEdXMmViTHBk?=
 =?utf-8?B?Y1VZb0k3Q2xhem91MHBRM3RVYTBlaE54MElKaTZoWm4xODg0UDlFUjJCbmw5?=
 =?utf-8?B?cTBTZC9iMVE3WWFJNFV5Y0R5UC8yOEZqQzJsbUM0ei9kRjBmVUxGYjl3ZzFk?=
 =?utf-8?B?N3dqSThjcXAzdG5EdjFlSFVqQVN5WTQ5WnNaazlsc0c2VE1aMjJoYXltRTFq?=
 =?utf-8?B?QXZhK3hlSzZnNklySWo0RFBsbUdEalZEVnNsQk1zN09RejBvUEFyeXhZakpF?=
 =?utf-8?B?cGxZZ0czRzJqekxZamF2eWhIUVVzUmUrbnRWbU9sNkVScG5VTVgyUkFhaHJ2?=
 =?utf-8?B?S1dGdkdrMVRxcVF5c3pHa3VXWEU4K2xpcG82NTFnVXZYYkJKUExYSDFMNWYy?=
 =?utf-8?B?b1F6dGZNVEU2bm5YMG9rQ2tiSVZsRVB2TEZrYjUzL0JXbTdyZndjbXRWQmh2?=
 =?utf-8?B?V3dvVHlXbDVIU29pM1JVWUJlOWpVdmdXdFp5b0JUSzVZNUdBWS9PWDVMRXhN?=
 =?utf-8?B?ZzdNUXZmK1UxUTI3WnlKSU4xZFl6Z0VOQ2pyaUpvS01PUEVEOHdHVVM0b2xS?=
 =?utf-8?B?azltTTdhQ1lWTmVXMGxtR1FPYlpzZGFZSXVSb1NLWUtQUTIveVUrOTRWUHZ0?=
 =?utf-8?B?SzlOQ0JSZWRoTkI0N0xFYkhZSGRnaTY4dHlpOHVjQ0dOanRrczFycm9pU0wv?=
 =?utf-8?B?R1Y3OThjc2xhWS8yQzFSbTRWVmt3ekhaNWpPRFplRmJQZWNPYVh1QlRQUFFz?=
 =?utf-8?B?ZGlLbnVtK2x6VHlZZUpHUzUxelRSMnR5VzFhUDdqa29LWThQOC83dUhFQkNa?=
 =?utf-8?B?QWh1UG1mZksyN2RzM2crRERXTXc3OUNRVVMxQ0lSakpQYXMzYk1qQjd0S09t?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e8b28b-7075-4a84-ab9c-08dbf1ee9259
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 21:51:56.4703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kPOm7G5XKF9JBtF3boHuDpvPeC8gQjrFngQwFKKiLtQeKEUmfmWOK92ryt7vcCqqbE8zaBYwoQkXzgZB5SguGzD8gemAwxT1/JfT80XtLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5315
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

On 11/29/2023 4:34 PM, Tony Luck wrote:
> Resctrl assumes that control and monitor operations on a resource are
> performed at the same scope.
> 
> Prepare for systems that use different scope (specifically Intel needs
> to split the RDT_RESOURCE_L3 resource to use L3 scope for cache control
> and NODE scope for cache occupancy and memory bandwidth monitoring).
> 
> Create separate domain lists for control and monitor operations.
> 
> Note that errors during initialization of either control or monitor
> functions on a domain would previously result in that domain being
> excluded from both control and monitor operations. Now the domains are
> allocated independently it is no longer required to disable both control
> and monitor operations if either fail.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---

According to Documentation/process/maintainer-tip.rst the
"Tested-by" tag should go before the "Reviewed-by" tag. Please
check the whole series.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


