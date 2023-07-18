Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05258757DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjGRNmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGRNmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:42:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2871F97
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689687748; x=1721223748;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2xEGNXmaQRSpuwEeS0uApCbvnGWEIrdnetWBMkh5BXU=;
  b=efc6YoPUjPLRu5WPtrV4deUmq4ncqW77/mAGq8bqpWWRz3F0odif5FjK
   eiFSLUwPXgrCoO2/QhTPWaEMvDk5BE1FtK8+4CpWqLT1UykWFigXKaBm4
   kStaY3AL50Z+Vn5MYvWQSodQjyS73VPrK9rlgXxcO4mY/S/U3w3gc0GOn
   PH5tmhouKRODhcW6PMD31VJdvHRfppSy8Y1G0aVkSZ/EDm1jpWpcWTbtc
   9SoO09sIec/M1lWqQijuHROeX7gC7GKAYZp81/3K7WCxYGmv1fgW5+wdZ
   4P6/DhI8mKvW1AAmwFBRub0Ae0FRoYdgO4KiwLyCLmINWAPQS3ACgt9DN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="345800885"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="345800885"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 06:42:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="897588065"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="897588065"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 18 Jul 2023 06:42:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 06:42:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 06:42:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 06:42:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OddO7pRIaFUbkqb3Mu6Yuik4kB/NjQ7K8jpAnzzpVuAwBgZiAFsjUQB8mRtKETnzfPuyGFl4WIgwM0mQwpisWIy2DwTDPqsUqmVxrp+PV4iqZGenM7egG0NYsY2wtwU2p7SsG214H4LUGmchFTcloQVVtohz/b2VRBWtLFe1c13QpQTdFuX9k6jnSy2tJ9aBD/haLnPMTy6euoyRjBCls4VaITaoy/N7PjJyMaV4yAv8cZs1D558mc0S01gY5geI8VeQp2GkNjA9Dq7ZADkHDIFlimOJ/4xZWq2sKlI0uIbAoEy1RyvEdXCDX/SURmaGeB2O9flwi2p8Kx2fsVzWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTA3QHMMEgEm5HObgiLLNXZHrJOgddDKsvJOGRUUTxc=;
 b=YrldWSA+u2KLZfVEbcZeraHDvyLmqj6onFv94a9noLdTkaIW/FqLCBzcJkDmPa3ULQHRJ2aKCmkS9WYfn9cbjgEnTfAi0v88c41ealF57n337jrF7ppBbt/YffStb+QE+smGGaxTDZcCwkCr5+kfkKP3edtehurcSXUhSIweOrUrbvqc8CGq7hoM2Fa6Ao5awZOM4fBDiqn+4AjiOzCgm8lFVH3btpN81CTgoY5WkXNBPPB0RcK3mW2hYGsV+yo1wgKgE9RC1Fte+YJm6BQ2ZsXIcL8qpN9Q0eRdwf6jUXheCme3kIRMR7TXKuXFtxxUK2hIcT4kwbgFC4egUsSniQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CO1PR11MB5105.namprd11.prod.outlook.com (2603:10b6:303:9f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 13:42:22 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 13:42:21 +0000
Message-ID: <e05d8e00-d8cb-8c3c-fefd-3b50acb9ef31@intel.com>
Date:   Tue, 18 Jul 2023 15:40:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: lib/test_bitmap.c:920:2: error: call to __compiletime_assert_348
 declared with 'error' attribute: BUILD_BUG_ON failed:
 !__builtin_constant_p(res)
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Yury Norov <yury.norov@gmail.com>,
        kernel test robot <lkp@intel.com>
References: <202307171254.yFcH97ej-lkp@intel.com>
 <ZLUSG8bNnSqT0LO+@smile.fi.intel.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZLUSG8bNnSqT0LO+@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: RO2PR80CA0034.lamprd80.prod.outlook.com
 (2603:10d6:10:2b::9) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CO1PR11MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d653e8b-fa53-4fe1-8734-08db8794cf89
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uTit5P3lk3XxMor6YEkyfQjgvmTKp8I8qsDG26Rt1NBiqFmewfwP9bhg90EDEeJBLCvg/zRU1+qW+F2pqKjwq4SedrvGMKO0NQoQEOtsiRa4n12ybx6E52IOtDZxSrCQNGqGd40bzNgH2ecYW96ydpe79+jVyMIj8UVPD1dTH0z8GX0ps/NOgAHLUptfa+f/faa4+sS+XdsvtMlwIEW27Gp3Ao9zaz0okcv7SYwksyrV60HyMIOtAUX/gAmiPEf25QIuB8FaidxfEKdrR3hkHc+U8YbfEEyFN2Qm57Y3nebMyqAy8BwEMvlbb+z2goky+uL6NMpwIG1eAJIgk9P7w6lEG/RYaLhC17HJuYVhsoRiuRanqtQFTBDxW12nxhHJudjc1hvHTn/YwL9H7vtH0n4B0Qn6yKeRXsGsIsU42XGNGsyJ+xdpPZFhSeaaPyzALb8M6nyXzXUlsPlNoAUBYJUwEYcT/78MmZAUAup0+oAr58El4Xpjrgl3P0ieiCSRYMaIjPKJgLNkzySiBr3cKLC8ZVch0nM7pq4928W0ultH73eM7fYgo0LizcFP3aQ3YfJJfmx8QE+9ub4uHDynw4Qk4w81q4LFhEtCtryS8o8CxPXIHnun5ImgqxyG7CQW6eGvZLtBim3RTVCVJ79wTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199021)(41300700001)(8676002)(66476007)(66946007)(6916009)(2906002)(8936002)(4744005)(66556008)(6486002)(6666004)(54906003)(86362001)(31686004)(4326008)(316002)(36756003)(5660300002)(2616005)(6512007)(38100700002)(83380400001)(186003)(26005)(82960400001)(6506007)(31696002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE5RcUxNR1ArSnFycitubmFwQW84aUcyOU5RN1hxb0MrVEVmQzUxSE9IR0VS?=
 =?utf-8?B?N01HbmNGRU1tc2J4bFA4aU1NSVRuOGdRMjNPeFFneWtJVlJwZWVUZHg1OTZl?=
 =?utf-8?B?Y296OHAxUlF6NVRrcWluYWpKSUQ0VEMvVEE1NnRScGxyWTU2bDFXdEJscHJT?=
 =?utf-8?B?aloycEUvSXZDbjUwdWJUQU83cHFRb094dThJcExTYTgrNGN2WDg2cTFaMnRC?=
 =?utf-8?B?MzRVQmlRNEJhMUM1WDhTQm8raGM2Y2ZYd0dzcmlWYUlObEN2dGxxWG1jNEhL?=
 =?utf-8?B?VjFCeHZTNFQ0QmJKWjIzL3RvczBFTm50YnZwMjhLSG9rNkJteUxMaE9DMXk0?=
 =?utf-8?B?Q0Z1UEUyOGR0TExvQSt6aXJlQVc5Q0drcStNQTFWRFpZYXlPanNzdS85RmFw?=
 =?utf-8?B?OE9GSUR6cUlrZnpmOVlveG9xOVYvQXNIRlhueDlMWHF1QVIxdmRuWGViY3JH?=
 =?utf-8?B?aWpmUnkwVDQrSTF3c0ZBbzNVQTJqdVRoeWFYWXQySk96U2xjOGczUHZ4alUw?=
 =?utf-8?B?MnE5TExiNWx5TkwvUEZPRW9DUzl2MDB0NHdXNUpXMWx1UjJWQmRLcC9rR0hQ?=
 =?utf-8?B?Z1JOVnFNcTVWdWttcEhmVUlIZTdSNEdhY3c1Wk11N1lzS0l6bkFvbkw2UHZM?=
 =?utf-8?B?ZGhZNTRaTXNpWEdSL2dqQzZlZDc5VFRSLzNFVE5rR0FPQlRDb1VKYVJwVUJh?=
 =?utf-8?B?RmNFNjVLYzRmdXVZTUhjbGpHditWL2JLRFNJZEpwNDczVkpwOGloSGF5a2tZ?=
 =?utf-8?B?VmFrSWpSQnlOMGJQMVRSd3RvRWxSTHdEWSthUHg0M1RzSitkNXFUYWJNL29S?=
 =?utf-8?B?Z2RJWXRFbnRuRUpCSEV2Q1ZWbGFMZTdyZnlYMFlZRlcxM2htRGk1czFxeUJt?=
 =?utf-8?B?UXhtOUxrRXExRnlDeXlkU3V5MHJ5T2wxZmZKaHVRRVVVU2xUOVE1VnNleFpK?=
 =?utf-8?B?RDRObVQ2VFNJUm1TUW9NZUIveWhsZHBSY2d1L2JJcC9HUEYwRjZZR3NWL1hr?=
 =?utf-8?B?M3ZiRWpYTU0vd050VEF1MG0yYWlpS3hTeXJEVG5GSFhNOHA5STNhb3BaWEQ3?=
 =?utf-8?B?NFFqUVF5cFZickkrNElsTURYYWU4U3Q5UUhObGpObVkxeE5naGlDc3djMDVY?=
 =?utf-8?B?dnZsaS9yVUIvWlpOdkFZeksrU3dEL0hCOTlpNnVRaDFQOXRkalJuVGJVMmhW?=
 =?utf-8?B?QU0xdDlBUkJaMHRpUjVzWDNFTk1UM1BqdHlWODlFUWpMSFZUQVZ3V2tvY3Nn?=
 =?utf-8?B?S1ZUVU9zRlVGV0FJczZBVlkwdWlDL1JVUWdPZUE4T3VoUjZaNkxmS2Q4cVpl?=
 =?utf-8?B?dnN4Q1BVL2tWUlJsenYzQWl2azR4NE1KV2lkakRkOHlRdVFXN1lZWWg3SkU4?=
 =?utf-8?B?dDJSSXVuM2tmWFdkQVhGTEJMdldodHpxU1pCenBKeVhFL29Pd056dmNZaUs2?=
 =?utf-8?B?SHJzcGZISzlwZGgyRzB2OTIvQVVCVUhuNUlqYmVRdTFRT05rWGhzVGFRSG56?=
 =?utf-8?B?SGJKbXhoNFVodHhJK01yeWVYb25vdWxadUxHTnkzWm85ZXBHSEhwRUltSlRT?=
 =?utf-8?B?L3EweUpnMFowV05YeGJYOTladWkrR3d6ZFFRRnFSTDRMVlBpMW9OVXQrN1NL?=
 =?utf-8?B?N2hvMGJRNkpZZW9wVldOdjRSdmt1R0s2ZXRoZ3VqSHM5Z3J1YWZiVHdBOUhG?=
 =?utf-8?B?QktHaENRVGJwaDZxUVBoZC83b1JaNjZaY3ZuTFJQZkdwRG5yc1pOTFhUa3Jh?=
 =?utf-8?B?WFhMNWh4MkZsRUxGR0NaZXpHQkVLb2drbjlrb05oME1JRkM0NUJja201a2Jq?=
 =?utf-8?B?NStHYktJdkVKbzg3VmxWL0tscmFVVWFKYkt1TWMvSEtBek9HT2VhNWV6VWRp?=
 =?utf-8?B?R2I1U3dyeS9VbGVBQURGRkFjc2YrQk4weG1OM1NuV05kbVRqZjAxN1NrNDFE?=
 =?utf-8?B?NXVmNFFjazQ4ZUgwQlpPRU9lSnpNT2pwdTMyY2lyNWlVR1FZYytqS20zaHYr?=
 =?utf-8?B?RTF3WkRXY2QrOFBydTI5TTBQTllYTzNoUTBXUk9Ed1BIWjlVK1ZDQXdvc09P?=
 =?utf-8?B?aDNDWnZoN0ZOWjdFblR4SWlOWHB6ZHRaczFMbmttWHZsYXlGclRHMWtTN3dG?=
 =?utf-8?B?bTFnY2hsOTFXUFhVTytSdU9kdGRRYlpyVWIrdktma3VuRGlDdzJYWk10SU03?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d653e8b-fa53-4fe1-8734-08db8794cf89
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 13:42:21.2547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJH+i01SXeDClBHeLXuZ7DuW7i3wDXx/CqKqBjG1lSGbayNQ9Nj65lIbmRQcMRMXiKcWRCEKLLM7CiASAIgsm9iQrosCE3EofBUJDZ8Nhgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5105
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 17 Jul 2023 13:04:11 +0300

> On Mon, Jul 17, 2023 at 12:42:57PM +0800, kernel test robot wrote:
>> Hi Alexander,

Hi,

>>
>> FYI, the error/warning still remains.
> 
> Alexander, either you can escalate this or just propose something to discuss.
> 

Sorry, I had some days off.
I've been waiting for more info from the Clang devs to understand
whether and how I should fix this.
I see that Yury submitted fix (two actually) already, so I'll go review
it now.

Thanks,
Olek
