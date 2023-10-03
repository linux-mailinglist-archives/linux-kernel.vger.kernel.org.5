Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65087B7332
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241187AbjJCVTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjJCVTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:19:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1069483
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696367938; x=1727903938;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gCWkECZP/ycl5qyL5GixkIiVoPV/cYVMkq1x8kp0G/8=;
  b=IQ3pgnD/HPg2GlyHTvh8y96s7pP/XLuVaOMsUNFgw/MLT+uHY1cEN6N3
   BCFQLwS3ru13fsFFBFqzwIcOchjCPkpfZOlOFwBn8r0RsxRUQ7lT8ZSrs
   87gUBYdh51AwAgi1KOi12OUqsa9y62vA1ZFDNpZN2mYcRVhGVDzj7StF1
   5IdndzUa4s4NTXHndRhklyRxr0CfMDQpqWgS7f8w7EtS3s3897IkWoLOa
   j/xKib+mtgQmYF0AwqCMlQ7RuQUzulkJrION/Z5JinfAoemQr5Fk9pdNW
   bBDJMGs6ddmhuXGK9dko256iZ4zrhaMDjYVSzTUDRDbyhJ8E9IMfcn9yV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1577171"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="1577171"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:18:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082176003"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="1082176003"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:18:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:18:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:18:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:18:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:18:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=It3ZO8gddKmw1yNkPmP/Wds7rWy+GC+Dc2jp5HTc9NCV1Sxwx3kDsYGg+fd+SCDd3K/MfmV+QJlnndFx1ZJ/IjzUOV86d7ObWI9iwcGsjFv8jJiZoIWYM/xMHRo/PlU2eMnMnLozabNtacdzj6Uvoxa/5FHCvIjoou5mB7tGSW+BUQQEFXGyYwZ5aXOKwCNgQXseIb+ynLq1WwBhfyBXmkDgHsizB+y2EhBTboy+0qXBk0G+A8/v/POKIAuCVlaQWtaXtUd8OjpnVl7zpggvBEB5JV/W/4JO/OCTCrFP3NlIRtup8bC8uegNTL7AscnFO5gcIwIW/0d2Lt7RTOCyHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uDDF79+RBN+bNgbHxWZQA3aHErbmxZD38bAZBcnXMk=;
 b=RkEDH6yzhlea2pUoaYJEDMOHdJfjCh0324ABye4a40s1lk/FgGdvOnc2DHz1TukMBDccoeJ6JymAeJxEIb5R7zVWUFhO6nK6S1I8Owzk2vtxvztDJLptfdYmUn0V+324V8Yo/b1tVZLxyzAdXWRPaJi9P6BMGRazGqw3YuD0HGPitbRZ857RTTFoM5suNeO+kZ89mT/2bGpUh4T4uWt1ROsVUcfa5R2UTtAk1P/6w7tvdFA0NpKgodUsCBn6XInPxOzsDody+S/ovXEJntFOCxFlpx0DV8ypldMjE2MgRsD3gpD0Y0yKGQzyMBwv2KkKmLCTDI/sC+NmlWvqbtDUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7603.namprd11.prod.outlook.com (2603:10b6:806:32b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.32; Tue, 3 Oct
 2023 21:18:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:18:54 +0000
Message-ID: <c4954264-deb6-4205-3f62-ce591ce9cb63@intel.com>
Date:   Tue, 3 Oct 2023 14:18:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 15/24] x86/resctrl: Allow arch to allocate memory
 needed in resctrl_arch_rmid_read()
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-16-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-16-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0224.namprd04.prod.outlook.com
 (2603:10b6:303:87::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b6922b-0433-4b6f-a0ea-08dbc45658d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 39w0qnFMZ+nQfg0TRA3Xnom/LNEHK8RHEca7T+tlq2dfpJEPBsEFVPhFBkDbJHtKHWk7souCxTp5pYwnYJNGiSapvOm12m1pfUozaSp+T+/7p1UNfZ46bDRZNTrtzohmMNS3CNIKbKxDDpcTePRp92gmri2McRT2yDQoVhveQ9wcaz0xAkROAaxRxoUMP3mCzGyXwJ67vBOKA4zNUWnRRk9fyBCFmKza6SyHvJCK3GIYccz6a2ML+Mqi13UumwiVC2AR4pvY1BpdQB72YLpf4XFZODyN+THkSHyPo9yn3u7OWW9fKAccWBQnEiEzKE0ZWAenVsrxy9oCKph/QrsxHxSY9b+VAADkHVtYq8G0KHqT6f2KjxPk/9AFcQ5uNbnGbMWXXzlGgTV0EfaZgIG6YEKagYrmJpwZQ5i2A2pQPT6v6oREtW5kdYNhk0CApulXncxFBrkyNeYPy/cnBY2qvMEkKbMo6pVB8kC4MQyrVQP3JigETkcCW0+D6UZHcym+PgSJ9dVy/7Kwlo0mJ/01nuw0k8aozlebLrUJtXN6R2LYhz9jC9fA84/AtfLI+k1YJdID7iWB9ne/TeLTyeg6BGSz11NA47theSR+WSCe8RBwhOd9d0V3UqofLRMUml6Jhm6K//td5y7OH1CvPIG4/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(31686004)(6486002)(6512007)(6506007)(53546011)(2616005)(38100700002)(36756003)(82960400001)(86362001)(31696002)(2906002)(7416002)(6666004)(26005)(4326008)(5660300002)(66946007)(41300700001)(478600001)(8936002)(66476007)(66556008)(44832011)(54906003)(316002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDVFVTMwb0pwSG0vTk9VZzMxKzkzOG56QjdjVVpSa214MjlTYkJWVGJ0SkIv?=
 =?utf-8?B?bWR5U2hMcFNvVFowM0VQZWVsNTc1TXV1Qmo4RlREeGpJOE9RNThsN3lyd3F3?=
 =?utf-8?B?d09jd0FKcjJ0QnBxRWRhL0J2elFjdVZMUlhGTDJzVTYzY2gwV1VnRGFRUi9H?=
 =?utf-8?B?YVdHZ3FSNEsvYWRZb2lzeUpaakRQWmo0NzRKSG4zUVVaNEdmSUFOZHl4RHFp?=
 =?utf-8?B?RHZscHAzWlpUMVdObm5tOU9MYUpFNDB5TjBTbWIxdW1CVnpVVCtiOWFpcjBs?=
 =?utf-8?B?MnVmNUxBZ1lqNVdnQzM1VVFuTmRZREtZTzEvSFg0TTdUYS9iZThEUVptUVUy?=
 =?utf-8?B?UDdQT3hML2ZLOUcwRFFualVzZ3FOWXVuOGM4VkUwVWVsWTJWNm82TmJzUHdB?=
 =?utf-8?B?aFVpUWhwODlncFZWK2ZLVUNzdVNFcjkrTmdhYWxhNHNjUzlXc0pLWnlNQzF1?=
 =?utf-8?B?cks4clNRSmxuMGl3Y0psZ1hZa0JBVnUzRW9vTVJHL05PQ0FVZGQwbU9NOU9W?=
 =?utf-8?B?eHY3NTM3T08wa3d5Z0pSVHhTaGhtbzdGdjN6eHdvbUlNMVFZYWhUUnVFTGNG?=
 =?utf-8?B?cVhTRHZCcUtVMmtwc2RpZ1M4bjM1dmt0Sm1FVXIrVmRjbXJLSHliRlpLMkJZ?=
 =?utf-8?B?S3Z0eGVLNWtWOG1oVWdWY042OGIwVlg3a0hCNkhDRzdoQkMxTzhZd2xzM1Mx?=
 =?utf-8?B?V2FPcGYvQlhTV0VEbFd5TUEzZWZRSitrZ25EVno4YmVMOWtOL3krYlAyT1dj?=
 =?utf-8?B?NGZVSzJnVlNyQTdGNjVXTFlET3ZNcnJPeSswTzRsTlozNkg3b2hxaFdtV3J3?=
 =?utf-8?B?WVhxaUxxUW90MzBKMTNaRm9kSnNOei9Vc3BydGU3a2ZCMDB6TzRFOXNqSlRs?=
 =?utf-8?B?M3NoSTNNL2lMdW94aExFT2dOWUNybTFhVHFLZC9KSldlNVVjSVVKc1JGdXlF?=
 =?utf-8?B?dTA3NFVwZkJSWFJxdU5TYmhLR29hdnRTakFGT3NhNVU1cXJ6WHhYK0xIT0hV?=
 =?utf-8?B?M2krVmkxZmwvTWNIdmsrNGs1Nm5BKzhTNzJZSHh6emlwZGdSNUNiTzFKNE1v?=
 =?utf-8?B?WjZnQ3JUN3lxN0V0V3FFQWVDTzJCcUpZcmRqUVFrbStENFJvakRXZ2RQY2FL?=
 =?utf-8?B?cG9lVVhnSzZKblduMkRmSnhZTnFWZkJkT1ZWTTlORmd4d2I2V3hDSGNENmZN?=
 =?utf-8?B?dDFFMWU2ajgzeURlbUdmcXVHZFFYWWwzYlQ3UUdoVEY2VEk3UXAvMm9XSGVB?=
 =?utf-8?B?OVF5cEJOMS9NRVQ0ZXlVVTdhTnF4NUM1aVlUNE5VeGVkZGdURUNSSGgzS3ZW?=
 =?utf-8?B?Zy9IREl3TFdMbThwMDR0OGwzTHBoUHNsMFJVRU1Fbk55SXhqaGQ1Zlgzcjgy?=
 =?utf-8?B?ZDQ1OFk5QjBIeXVFSEJZWm9WS0RrOEdJTU5QNjhoeWVlVjRMeEpkMTZYSEZG?=
 =?utf-8?B?cE9BeHFieUJVbGhxVWdMcW5hWHpJTjhEbVZVcmRvQnQ2di9Wc05hSXRwb0Rq?=
 =?utf-8?B?OWlqNXpFVnVrMnMrandGV2I3NmN2K0lXVVkvQzM5UDl5YWF0bEgrRmlVc1Rr?=
 =?utf-8?B?dEdMa3doNXhqR1ZxbkRtWWJKcDdJV1pYaC8yQ2lpSmltbVJrZjJYVXl3Zmgw?=
 =?utf-8?B?aEk3NHhTRGhzdHN2Y3g5TW5oeitDSVJ5QXF3M0FYUzBLRjBqdjN1T2JvbjA3?=
 =?utf-8?B?N3lHdW53S0UrM0tXMXVDa1BiV2ZuK1RWZzFUYW42Njc0cGxkL0ZnbFNaVXpV?=
 =?utf-8?B?bmpmVml2ZDBRT2V5YVdrNW8ySzhxcEpoRU9PR1NwTVcyeUh2YU9xZktFSlRM?=
 =?utf-8?B?bHZXUjUyZmlFdEw5NVcwdWlPMjFnZ1lKNzNVdjNxYzAvVWNHY1ROcTFZQXZO?=
 =?utf-8?B?LzhVVHpINWtCQlV3K3VuRG5NRmZMNk9ZaHFENDRuKzNWZ3pEVkVmVHdtUFZk?=
 =?utf-8?B?WXR0alJkOFVsenoxa1lXeHlHckZuemVKRjZEK1hVMnBYWGhsMlAvdUY0djJH?=
 =?utf-8?B?d2RQUHA1elhROWlwKzduMlduTGh5c2UxVTY3cE9iVlFzc1NtWlF4K3d4eFlQ?=
 =?utf-8?B?VXMyNmFNUXQwT3h1Q1UrVE5Mb1NXdUlyYVFCbFNsQ1JFZm9NcXdXYnZUWENU?=
 =?utf-8?B?dFdkS05reGNCUFErTHIwSFJDV0tnOVVITUd0bE9ScGFKNzQ0VW1LZ1h3QlBE?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b6922b-0433-4b6f-a0ea-08dbc45658d4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:18:54.2053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wprY/sm5XuwZY2buyGrhr8Y6BWkP9fVBvGn4U+l7QYDXCfkVBdzYziVKQrGwviVny+QwGef70/XB5nZKvjw66UEEZRO0tY8UBZ3rAye0mzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7603
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 10:21 AM, James Morse wrote:
> Depending on the number of monitors available, Arm's MPAM may need to
> allocate a monitor prior to reading the counter value. Allocating a
> contended resource may involve sleeping.
> 
> add_rmid_to_limbo() calls resctrl_arch_rmid_read() for multiple domains,
> the allocation should be valid for all domains.
> 
> __check_limbo() and mon_event_count() each make multiple calls to
> resctrl_arch_rmid_read(), to avoid extra work on contended systems,
> the allocation should be valid for multiple invocations of
> resctrl_arch_rmid_read().
> 
> Add arch hooks for this allocation, which need calling before
> resctrl_arch_rmid_read(). The allocated monitor is passed to
> resctrl_arch_rmid_read(), then freed again afterwards. The helper
> can be called on any CPU, and can sleep.
> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
