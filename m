Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A60277FD28
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354056AbjHQRml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354017AbjHQRmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:42:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E2E2D68;
        Thu, 17 Aug 2023 10:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692294133; x=1723830133;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VXqmdzOxCdYrosVsOliNnnVeQYQ2cdFlMhN6H6UYfLo=;
  b=I0/5k56Z3yGhjmZh0pW7yLkU+6oHkWtEdSbwqqP+mzmRS+pOIQnhZjU6
   rsRZHfPuRrp/bP+OGCKpDIUN6jQd6mhON6cSkJlwELp/uJWObLDTkdyvj
   tjsK/+Nfmg/2ILGGRxxWN5dgjZyLQnJmRXJ6SyxLTXRxo/+UclY+sTm4p
   chimZ1+zrJZp+4px7tOUm+gKOufJ35eEpK/oKFA+/aUAYDYbA8yOw4q72
   ttZ2r+bscO0ybhiYiSGnb7mYjr/ZY6VgfMtYNVIR6d/iwrhhI1X7UrPIB
   T6THCK/iCOMPmSRi7DVascCh5rRWgrsfQTB2iE3QCms+x5KjU8V16k+X9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="372873399"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="372873399"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 10:42:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="804778838"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="804778838"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2023 10:42:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 10:42:12 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 10:42:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 10:42:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 10:42:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avRRizNWVMfb6F+Vp8jZju/76UbfpHp9CQjjz8GTtsIy4y9an+kD0HCEqfthxUUQJYs7AZBmOQYmUrUoI5OzV5UrZibr4JasNWQiSgJ5vjl4UKUMvLrup7LEJcYEiA92LDx6QmF719sAu/BKQnEqE+yLAStONhOqVEmykvHEe5+c86xnRw16SzYqVBUKrgL29CQ4I/IfyM8cMv7R/77fpX4ZGAgV1L4jpFahi+UxwhoEjjrsMFI8CtpgOdY9ldaDCR6vxk0t6ACjYHhyK/WB0Zdl3PGXW31l0iDb63PUp/5iZiijF9HkLmtO6mE5JWvoPiY6qHbGwMwOFrkrLspNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuJrF0Ip8lhX1zU0VkoYWJ0lfJ/Nthjg9QF97XHNjyM=;
 b=W1AF6qrrSlPVPFQuln8YU9iL2F/u6xOULbsg/EphHAnF6mIBUPfS52g4Pqr/79lv+0JvvX3RKJuLWqOkB9OuwEA+VrJhp36iMZ9awlku5i3Sv1w1IU6ZGaDXwmpyWuAuyf+Mt2KhdTcZ9eojJkOtUB7zXE766RpAmvyxbL5XIm8kTjwHNVetX23F1cWvgtNDiTgCcKgFEfA5Y+Y3VEjNtlvQrsmF+94HxQtlu3gegkMMKak5eaa1UUcty6IREKFvjk6PUqzJM5V1pG8ghocX+ZIDoV5XTyrDfIyzBFFC3HqiOyclZDrWDNggD5i3K/7eubh+bwHISB9C9iem5lkOaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6317.namprd11.prod.outlook.com (2603:10b6:930:3f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 17:42:09 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 17:42:09 +0000
Message-ID: <4279763d-7e73-761d-21e2-513cd60ce2c6@intel.com>
Date:   Thu, 17 Aug 2023 10:42:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v7 4/8] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
 <169178458575.1147205.16331131496340363561.stgit@bmoger-ubuntu>
 <37986ad0-4519-0f16-c09b-86fcf2f8a763@intel.com>
 <c341b2cf-7ebc-f52b-76ba-77a106dc20fc@amd.com>
 <25c23223-520b-f6ff-ec8f-678e2524c511@intel.com>
 <702d2d05-d37e-c275-ab05-a88cac49a81b@amd.com>
 <6ff03090-bb8b-b4dc-1ab8-1221de8b1358@intel.com>
 <21dbac92-7f9c-12c0-771f-7ef716eb4eaf@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <21dbac92-7f9c-12c0-771f-7ef716eb4eaf@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 801e7f57-e60c-44c2-3330-08db9f4947b5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5pPC3jphL8w3rNLiY6SScsLK2SDBmdiGxkgDrKl8Hqz5qfwMqGg1CEvSwcyxoe5r6jlxprEmZ/RDDDUK0rE4iW/GbFxmYOXmnqucy9/ksgYQLMc682Bwb5/rKFu4nFGLfd8H7jVltgj5hqB3FSJIlKVJ+iZqUW19TgD2q+g8OdbZnOdHnrt6byymfFVSwgnxre+kxw+/S17HoIuheCwL19i7TX+PPw4evQnrAv/MSjCugnpDplYVfKF6NPzxNOZJk9qY8FNdFZBTRDL7bmlXJcu5wbQ+VCTNoLXnQh9OgVQSj08d+EyvHZYwWOU7qUiw/yvOUSLOwpgOPQJhC9cHM8XwMpMswf80pFvlNsSCWzSNYgZxgp8m/+DqmLLS3eJZ7UqQciBq/0P35WnNOY91etvBetwRiI3/bnu2Yp4GR4Q+Hmq+CgU0QO8VhECkbtywPA486I9pQkTjhdAaO1/9+vRWIRFW9e4iPAxHyYXVPtbAxsVADiRJ28Z6z+zBooZbTUMfV/Rxzn9RiuvmzkS16xaTcwV5IcTqTh7odF6tI8miLnRNd0p03+nAaNsZnYAuB7f9TvJecFw4KcfZd+UgLnw/2VZwvZThlXc67MST2gC4Nc5s1KRleaymuZCQ6ldbAaWE6EJgIGTkYbSbhp3ciw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39860400002)(186009)(1800799009)(451199024)(8936002)(66556008)(38100700002)(82960400001)(66476007)(316002)(478600001)(66946007)(7406005)(2906002)(41300700001)(4326008)(26005)(5660300002)(8676002)(83380400001)(6512007)(53546011)(6506007)(6486002)(6666004)(2616005)(44832011)(7416002)(86362001)(31696002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDFqWFprNjBPUEtpVGlnNnZmT0NyVGVrQzJrRm95YzFuYkhwRGVLc3VZT3R6?=
 =?utf-8?B?QWdjRUFuZHN0bnJtK1RWdGFvamxlR3l1MjQzM2VVekdEM1JHblE1ZkFabTJI?=
 =?utf-8?B?TDRhblJXNGZIeHk0Z1NwSHhSb0FLWlJVSFQ5Zy9TTGZxaHZJUFp5QUtrYTVl?=
 =?utf-8?B?RzY4SDgwOEtBNjhUVncvSDkvejd2RXB0cmU3elJmd3ljMmh4V0ZDNXhRYUFI?=
 =?utf-8?B?SGFybDU2ZW1GQlJXV1cvSUpGZm5lRkdnZUNLNFU0RFRTaUFXU3dNTFdudUxN?=
 =?utf-8?B?OGN1WmhDMVB6aWZGMnFVeHFtdVNhUEtwMm5qYlZBU0V2RG1mQ3A5UHFKNmZG?=
 =?utf-8?B?L2kyU0s2amFrd0VKelRKUG1CMXRqNDJmNzZ1Z0cxQVFUSGlpWUFiUWx3bTlu?=
 =?utf-8?B?bkZtdUdIL29nRllLY0JJcms5b2t2MzgxdFNhUGhEZVFabS9lZVlWMVdJclFG?=
 =?utf-8?B?Tm1uYm03L1ZGVE1WM2I1dnFGNGlVbG84MHl1bEdHclVENXhhTVhzOENzZWxq?=
 =?utf-8?B?NE1ycy9ueUpTQXE1KzBJVVd0ZHlIYXJPNEhsUllSYjdqMytHSCtNZytiYko0?=
 =?utf-8?B?aUhQUFlHeVlqdkpLa0ZsbkhwQitVWC9qZVFpY3lNMzlzT1lyb2Rwa3pYMVVG?=
 =?utf-8?B?ZjJVZ0UwWXV0SEV2NUZQTVBJT00xSCtIV0RLWXZpUWxFZHVBTDBzekV6RDlm?=
 =?utf-8?B?OWFvYWtnaDVkMy9KT01xU3FOc1FkcHpiSUlWdkZVYStpa1EveHJPMnBkR0tP?=
 =?utf-8?B?TjQxWCt5d1FwWlhHU2kwMlBWU1crSEw2SGNFcXVKZ0JNVUJoMDVTMDVBWlpW?=
 =?utf-8?B?a251VmpTdnFzQnFoMVJjamJuT2J6YklJV0V3TVh6d2IxdHVSeUNpcURlMFZN?=
 =?utf-8?B?T3FJQmw2T3lpckVERmh5bUNQamttekxOMU1ObDFnSFpBRUZHQ0UxSlZITzlE?=
 =?utf-8?B?aG5maVkxbXJlYTkweTYvSEFJbHJoc09mWjk2NS9oejNBV0xNODlkUk4xVUE4?=
 =?utf-8?B?YU9jY3lEQzZLTXA3dVJBcCtMRzNyTm1SbTlSQjhpSTYxb1VDS2JDZU5heFN6?=
 =?utf-8?B?R0M3MWttSElmU1d4bVR2NkNTWGVGc1ZvYjBZQTVXVkZvNWlvckJNSW5zejg4?=
 =?utf-8?B?QkJkRHJ1dnN6RFZmRzk3M1ZoaXYza2MxM09xN1A0TmFHUGpjUzJNK3F5bEpt?=
 =?utf-8?B?dDBJZGdFUlUrcGN4TndSL0JxdzVRN1ZBMXZtWXhFMm9FVjBHOUF2VkI4d3lr?=
 =?utf-8?B?VXVOQkdTOEdTSk9rQ3RYbjVJRVJLbFM3VmpWcXdOQU11alZRaEVqUTFMc1Rp?=
 =?utf-8?B?bXZOWjE3a3crcWxObHJMZWdmVDA1MzZhcFlPeG1KUmx0bXFXNTdyYU1SVWhZ?=
 =?utf-8?B?eG04Y004WHU5K3FSSUxMaURqdkV3REoyWGMvN0lIanRXUUJMbVZLcm93cGU4?=
 =?utf-8?B?S3F5ekNQeitvcXduMGRmcktvRlQ1TlhLcmpZa3BvaFFqNWcyNEs2QXg5STBz?=
 =?utf-8?B?akpxWGFiWDZRWURSdStWMFdkcnFTaXlQUzFsanhMY2Mxdm5UaUJmRHZuRGVk?=
 =?utf-8?B?ZXNLa053S1hDbDFLZ2x3a05zQ0dURkdVRnNCRmJrMFNEdUJBeWd1MTJiNk0y?=
 =?utf-8?B?K0Nac3JzMGRzMmcrckdHeWJHNHJhU1ZlcC92QnBjazg5NEZVSjZ4TWRZZ0p1?=
 =?utf-8?B?b2RwWHVUcFQ4dXVQaWdxeUtJejhtc3ZUOHhIZkkvY2NjTlZFTjdMWmdyMXlC?=
 =?utf-8?B?Wm1pbmhkdk5EaTZuNTFXN3BpZVA5NFZaWFVuQ3liOEpTdnhVSndKVXhiU2l0?=
 =?utf-8?B?c3MwMVRUU00wU2gyNU8vdDR0L3lpUkNLSDFkNkQ2Zk5zLzRmWGFDSWJEZ1RZ?=
 =?utf-8?B?M2JpNlYvTEt1Mm1HQ0ZwRlZvS2ZXZU52MnlIVWxBV3U1LytOR3VoQ29QT2xx?=
 =?utf-8?B?UmhVWTdKbURjb0EvWll0dTU0Y21tUkUxeUNtZzMwckE5bjlLMkM0OUpBUDhr?=
 =?utf-8?B?dHBXaFNzczRqVWQ0Yi9sNjF0QU05UFdoaEhzOS93MC9SejlmcURVWVhxc0t1?=
 =?utf-8?B?YVRVS3JtYzB0R3YrZGN4cGdSdVNSTU9lRFg0T2VuejFOVkdoekt2MTNXc2l4?=
 =?utf-8?B?WjVDV2UwN1VqU2FuVzI0NmlKL2o4ZEJKaXIzZjhpYjUvSEFDbm5mMmM2c1BV?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 801e7f57-e60c-44c2-3330-08db9f4947b5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 17:42:08.9824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGXVYIdZyeWHlxbgyd/OaINgvPJsZ7JAnYiEGwxip/UhWHHyU9OwmA+DLt6NmHSWE+vMPReCA55/BVfsUT8NEl1RGI3mTCO3ykaNwSS+j3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6317
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/17/2023 10:07 AM, Moger, Babu wrote:
> On 8/17/23 10:37, Reinette Chatre wrote:
>> On 8/17/2023 7:20 AM, Moger, Babu wrote:

>>> + *
>>> + *             --> RFTYPE_MON (Files for all monitoring resources)
>>> + *                 directory: L3_MON
>>
>> Should this not be below RFTYPE_RES_CACHE? 
> 
> This is kind of odd. I know why you are saying it. Wouldn't it confuse the
> user? Then, it feels like mon_features and num_rmids don't belong L3_MON.
> 

This is exactly the confusion that I attempted to highlight in my
first response to this patch. The same issue is present for
"num_closids" (which is currently treated differently ... at least
these need to be consistent). How can it be made obvious that
these files are present in all resource sub-directories while
also capturing the hierarchy of the RFTYPE flags? I could not
find a clear way and that is why I ended up removing the directories
in my earlier proposal and just stick to documenting the file flags
that only applies to files anyway. 

What do you think of something like below? It has duplication
but may be less confusing while still capturing the flags
accurately?

	--> RFTYPE_MON (Files for all monitoring resources)
	    Directory: L3_MON
	    Files: mon_features, num_rmids

	    --> RFTYPE_RES_CACHE (Files for cache monitoring resources)
		Directory: L3_MON
		Files: max_threshold_occupancy, mbm_total_bytes_config,
		       mbm_local_bytes_config

	--> RFTYPE_CTRL (Files for all control resources)
	    Directories: L2, L3, MB, SMBA
	    File: num_closids

	    --> RFTYPE_CTRL (Files for all control resources)
		Directories: L2, L3
		Files: bit_usage, cbm_mask, min_cbm_bits,
		       shareable_bits
	
	    --> RFTYPE_RES_MB (Files for memory control resources)
		Directories: MB, SMBA
		Files: bandwidth_gran, delay_linear,
		       min_bandwidth, thread_throttle_mode

	
>>> + *                               Files: bit_usage, cbm_mask, min_cbm_bits,
>>> + *                                      shareable_bits
>>
>> The extra indent is not clear to me. Did you do it to represent
>> a hierarchy or just to line up the ":"?
> 
> This is to line up with :. I can fix it.
> 
> Just wondering how do you notice these tabs? My linux diff does not show
> any difference. Are you using any utilities to see these tabs?

My editor is configured to visualize tabs and trailing spaces. In
this case it was just how my email client displayed it though.

Reinette
