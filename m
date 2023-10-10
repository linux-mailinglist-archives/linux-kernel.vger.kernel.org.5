Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AC37C04C2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbjJJThL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjJJThA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:37:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BA5109
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696966613; x=1728502613;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=UtpvcbGFvy5XV9tK92an61Q35SKgRBbotX3DBbS7wgE=;
  b=NuxFVLJFTDR5iphpVcNunVIpYwhwwyy1UuxGIm2WWoQ7YsP5J3AWIPYY
   uUd6/1xqgkwiWroyTzk2ByoDcebP+ok6XtsxwQVRa4BIra7QXW9n1tALU
   OkvJkD2BMwoQuNBi1nM1+7seoRqRZdtYlJMNNNo+hYPX1Kn3BD0sP5WX/
   nlPAN6ge8CtyDHWRpV63JC5UVSi4Ud0f3eWDylMiZlBPZdNkiMWLDMFrO
   Duj2rX1tPits4PCl0rNGfO5an/zp1RlBP8Q9KoW55XSJ/ZnnALVyhDjMv
   E+4mY3B2xHed+BDkWGcWONE1VTv6IRN7qBocplyKDAYgbnvtH9wWFpH9N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="6054056"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="6054056"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 12:36:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="877360478"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="877360478"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 12:36:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 12:36:51 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 12:36:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 12:36:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 12:36:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYCa0Tdo4ffZdTz8kogaP/EUiXLYUCsXYimP0rNhR/UIxrZ6KAjsZmUsaO8wL7yG7q4y17TsSZPXfuNGg17mFr+iFlWnVlZmBpQmwYIMhu/DR1F4YrwWLm4juzWdMtF3HzV8y3MZ/T+oVJ4nYoK4l7vyV4DUEwmdtB8VigrGNAuQyeNVnOz8hb8l0/c3TXp1gFsHBTkA9G0bEyzFeeF8h8NWQc4am1T27MQpdjGziOnG/vpAtTXE6WdBnvnNOnVnjbl8kEQrrqdk2S3ixixYGqVyeIN375RT5WrJ0NNn1bkEWl4Xra7dOP+A061Rq5cbfVxwbmbdq20/s4Kk/IZioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzS78niyiRB9wPXk4RCJRdK2BnFAYBThF0ab7t/8Lwk=;
 b=GC9EX0ergEFTm5Kqg3y2N9H+CLtSwN5NS6MxY3gqUyGbxkYkshBrS0fCL3MfhYlk3bZnjaeBbRxRU5B7l+WPy72E+dI6hs0bsAMK91ODJmaDmE+RJhIM/uz6hnWFks8w3nqJfYFYg8BMaivnxQ3z6QOK9vNKj06QUwNwQtaz5vVH/eqQAknitHJiYM7zuTihkqu78vkndOAIQhPker79tc5+/j7m1ykFBphQTlcBltASQapdLFKvD8afu7RZ10yHpKU/zmRhSTkmhdf/EBJVG0b+StfstjBb3I1D8rIl63Q0Y0R8CmdcHr9cQl5BV9oFtKz307mwmeP9rLE8jrbGhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 19:36:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.040; Tue, 10 Oct 2023
 19:36:42 +0000
Date:   Tue, 10 Oct 2023 12:36:39 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Peter Gonda <pgonda@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <linux-coco@lists.linux.dev>, Erdem Aktas <erdemaktas@google.com>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 6/6] virt: tdx-guest: Add Quote generation support
 using TSM_REPORTS
Message-ID: <6525a7c75a3da_725832947a@dwillia2-xfh.jf.intel.com.notmuch>
References: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
 <169570185411.596431.3153227201984845022.stgit@dwillia2-xfh.jf.intel.com>
 <CAMkAt6r2VPPMZ__SQfJse8qWsUyYW3AgYbOUVM0S_Vtk=KvkxQ@mail.gmail.com>
 <651602dc4c6e3_91c1e2947f@dwillia2-xfh.jf.intel.com.notmuch>
 <CAMkAt6rrzS85ZT9T7r6iwQHoVyEPwaxQ3Xayp_6XMbU+RJzS4w@mail.gmail.com>
 <CAMkAt6rwSwES_hEac=_7Gg8wcGosHMPXA3J2g_BGC_c+NbVp1w@mail.gmail.com>
 <9eee8abb-a1ba-46af-8317-0bc1c78179b3@linux.intel.com>
 <CAMkAt6odZAoQxNQ=HogTRB6dkmnK3t1Nr3+4SWpmAP-mqfqOiw@mail.gmail.com>
 <651cb7aa2ea48_ae7e7294a7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <651cb7aa2ea48_ae7e7294a7@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR04CA0246.namprd04.prod.outlook.com
 (2603:10b6:303:88::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV3PR11MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: 01feaa0e-2e57-4695-ad4f-08dbc9c83ad5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sb42ACg5BYzNqpmjZlTAVejWzsqa1RF7/PFxU26d1EZTs9t5Z2OSX/qNWyxIXn9qmo0/JV4BKRzne1vKqmMOaVJOSsEoVHJd3C92gORafBucCrU02ZC5P4bAO4ZcugNxurQVm1W6LEtbVmMqjoAniygGdTppH5MxkTvjvssZgz8ORxdekhzFIf80fdAMEgOMEal7oa1qEI8Tv3Y/GJwyTTATkixeCnja/HBbFwVnx0375CmJsDDD9vrs5qq4e7hc58y5aZ+vsPc9PyG7BKQhOx/KBNb+ArwYBNeCrY5utw5LOHnUNIaFKSPnkkluKT7tGxgJjlS/lj8I/x25Mws561VF1z8VkYw7kZuLyenVxYI4Bn5ax0oDCBax/4x++kKMVMV2IYhOAUqd0y9Mofq4AjK9nOjNQwTIMkUdzvM93bfPW7FywcnKHDPP493mlrPMW4KL0EoQPQdz1moZHYBfWpMbLpPG7IVI5QrfLrpFHxEaxgcui8+fx1bagMG8GW/6HJhZPCUHbsXM6lRJGCrGs3amtKb08Lv7gN3vopC2prEu7wqZom05vsnrhDuEKulq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(9686003)(6512007)(53546011)(6506007)(478600001)(6486002)(6666004)(26005)(83380400001)(2906002)(5660300002)(54906003)(66476007)(66946007)(110136005)(66556008)(8676002)(4326008)(8936002)(316002)(41300700001)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmZMbFowTEh5Tk1iSHBqZDZaMXorbTF1SWJySzJhSU9FcVdHUCtKTVlIVnIy?=
 =?utf-8?B?d0EwaXlyeWxOOGlOY01peEdDcVRBRFVQK3V3MHUvc3V3blRFVEI0QnUyNEZR?=
 =?utf-8?B?Tm5JYVBadU02ZGVMR3FrSzE0NE0rSXlFY21wblRMdjd5S0JGVkRwcnpUaFpq?=
 =?utf-8?B?cU00L0VqRjFUTVJncjRESEVZOHNaMlVTNXZlTWpHekVIaU1GaXJuZUxKU2li?=
 =?utf-8?B?RFBHbkFYcnpkZHRZdy9RcU43YTRYejRhb0RMTVUyeDgzbmFmSG5Ec202b3Z1?=
 =?utf-8?B?dWJmU2IrTStUeFZEVTMxOE5ueHdkYm4zcjB4alRsQVRVYTAyVW1DRDhRdzF2?=
 =?utf-8?B?U3BTZStCaW5ZYUQrS09PNEdOczNBcGt5b1Q1ZHgwZnlVR29ubENzbXJsd2Fi?=
 =?utf-8?B?by9qZ2RsYlYzV3VoS2REOHU0MnJNNzBjMTFxMGwwM014ZDk0WkRkMVI4U0pz?=
 =?utf-8?B?ZjhxbzdnUW5udXoxcitoNTlMaFdBL01OTmNiYW82ajczZ0p6NHRJM0lkdXI2?=
 =?utf-8?B?WVNoSVZTek9ISVk5eDJqS1Z3bHRKVHBjRjFZc1BxNm0xVHJvVU1LekJYWkxm?=
 =?utf-8?B?MTYvUnBWaEo2VW83QVlLY0NacWk4OVppZGJLR1h2bGZONnN3ZGNCT3B2UmNG?=
 =?utf-8?B?OGFnZ3ZKQ1JiSjE4ano3am95NUVjTUQwemFUbUhTdXBJWW9wTlpsenlCZmN2?=
 =?utf-8?B?dmIzaVhxUE5qanBNWGhWUFZoTUlSeDNjWitmK2hPWXhsT042a2VVd3RHNEVM?=
 =?utf-8?B?M25qSkIxWmVyOWRJQW9rNW15eFU1a2lrUENkWE9sY1lDaFRnVFE0U3F4Uk5x?=
 =?utf-8?B?R1RNT25pZGh0U1ZiSklBMVJHR0RiVU9YVGVVLzZaS3poNFFOczVMM2hrNTkw?=
 =?utf-8?B?Y1kvenpmcS9RcTdiT1dkZGhFOGxZNUQrclA2ajhVeU5WakY1TmVJWm9DWlY0?=
 =?utf-8?B?c0hCeUVhanJPNDA5UnpUVmV0WDlJUmhMNkxTWWhYc1N1YVhMVzdha0xjblRX?=
 =?utf-8?B?dG9sS1YxQTZQWVM4QkE5MGtpa2dvRUdETDgzeGh4Q3hTVHVSVGNtdVR3WmZY?=
 =?utf-8?B?cVpOUTU3UTErS05PYkhPUEwyNjZUMmdYUGNWWFNtRzZWbis0ZW44TlMxYzZt?=
 =?utf-8?B?bnhBRVFOY2VtSlltRG1DN2ZqcDQ0RWZXQlljMnFkeDh4dDN4Snc4akphaGp5?=
 =?utf-8?B?YjVHS3BBSnJvRnFXL3k2WnJXSzAxcnBnTkpCRGpOWWFCanhNUENXa2dPR1FN?=
 =?utf-8?B?Yk03NGNlNHR3WnBucktOS1dhQVptbjdxZDdjT2ZUWkpWRytXc2R3YVFLYnFs?=
 =?utf-8?B?Y05OcnNQdm1qbTludUh0cngyL3VRWHZwcXFQRXh4REtsV05rdGVVVzhLTUpu?=
 =?utf-8?B?Lzl0L205TUR2bkszclhta2liSkFDb2VCd25UdXJOd25Hc1c0WFJiWjVQTlVM?=
 =?utf-8?B?K2NvYVcvaDlyTlNzQ2ZYVTF6N0dBQkRFaFYwSzA3L2IrNW5Lc3Y4cW93SlRB?=
 =?utf-8?B?RWRLbnhMekNjdFdTdXlZbDg0ZlNlU0dSb0pRaUZXeXQ1T3JxbmRKZWtWekJ0?=
 =?utf-8?B?QXUvcko2VkRwazhHUlB0RDJEWmtvR3RiYWJncG10SUM4OE80UXdJNTh2Wm1F?=
 =?utf-8?B?ek5rQU5adDFHNGUyVVpveVVYR08vVFJOTFlDbXBNMElvQ1M4cnNCbDlYZHJJ?=
 =?utf-8?B?T0xrQXBPU1N4UE9sYzZwenh0aHhxeWNxaVUxclkyK3JjZWJnZm1UeHlNU3la?=
 =?utf-8?B?Zkt1dkNpRWVuNE41NXU2ZnhHV1V2Qk5wYU1pTEx6UDkvOHlXNE12QVFmQTE0?=
 =?utf-8?B?c3BydEIybm03ekZkU0wyT0JRWGtJa0NXclRQQWx1N3lKWGJLVXUyVW5XeThp?=
 =?utf-8?B?WUpQcG5FNzJIYUJkbktJTXc5dXg5ZmllWTc2dC9kMnFMVE1ieXFscDVoYlhW?=
 =?utf-8?B?anhkT0ZzU3RPWFVpcWZZL2paWXpBQkRZcjlHSm03b3RNdnJrN3hqU2lJeWhQ?=
 =?utf-8?B?MDhaZHpXc1VWenA3djgvdmNIWi8yTVUrSDBORXZaeG9rSUVXZ1NkS0RjWjBI?=
 =?utf-8?B?OTE4RDNEUi9nZDZTUUhOR2tsRGhHdzFTcjN4bEt2US9oSFE4MlpYUWcvdjI1?=
 =?utf-8?B?Mkc3ZnNCUHN2cHVrUHNBWXlXNm9FOEx0bW92SkJTN2xZNzRYbS9jUXZzT1JN?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01feaa0e-2e57-4695-ad4f-08dbc9c83ad5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 19:36:42.2419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOQ6PytvEZ33sLMwvYfUGdOhcjS2LL+vkdb6J8Uh6Yt4/OHPHmb2UU3Ti6RaZyLsKceKQQk1anFh6yvzhJyj1Xyaul0R5AS8TwCezY1tPe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8603
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> Peter Gonda wrote:
> > On Tue, Oct 3, 2023 at 1:29 PM Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
[..]
> > > Dan, do you think it is related to not allocating direct mapped memory (using
> > > kvalloc)?
> > 
> > But I think the issue is the stack allocated variable 'ext_req' here:
> > 
> > sev_report_new()
> > +       void *buf __free(kvfree) = kvzalloc(size, GFP_KERNEL);
> > +       if (!buf)
> > +               return -ENOMEM;
> > +
> > +       guard(mutex)(&snp_cmd_mutex);
> > +       certs_address = buf + report_size;
> > +       struct snp_ext_report_req ext_req = {
> > +               .data = { .vmpl = desc->privlevel },
> > +               .certs_address = (__u64)certs_address,
> > +               .certs_len = ext_size,
> > +       };
> > +       memcpy(&ext_req.data.user_data, desc->inblob, desc->inblob_len);
> 
> If the failure is coming from:
> 
> 	sg_set_buf(&src[1], src_buf, hdr->msg_sz);
> 
> ...then that is always coming from the stack as get_ext_report()
> internally copies either from the user ioctl() address or the kernel
> stack into the local stack copy in both cases:
> 
> get_ext_report(...)
> 	...
> 	struct snp_ext_report_req req;
> 	...
>         if (copy_from_sockptr(&req, io->req_data, sizeof(req)))
>                 return -EFAULT;
> 	...
>         ret = handle_guest_request(..., &req.data, ...);
> 
> ...where that "&req.data" always becomes the @src_buf argument to
> enc_dec_message(). So while I do understand why sg_set_buf() is
> complaining, I don't understand why it is not *always* complaining,
> regardless of configfs-tsm or ioctl() with CONFIG_DEBUG_SG=y builds.
> 
> I will be able to dig deeper once I can test on hardware, but I am
> thinking that the entire scheme to pass the source buffer on the kernel
> stack is broken and is only happening to work because there are no
> crypto-accelerators attached that require that the virtual addresses be
> virt_addr_valid() for a later dma_map_sg() event.
> 
> ...or my eyes are overlooking how the ioctl() path is succeeding.

Confirmed, I can make DEBUG_SG equally unhappy via the ioctl() path.
Note I changed the BUG_ON() to WARN_ON() in this kernel to keep the
system alive over reproductions:

 WARNING: CPU: 0 PID: 1175 at include/linux/scatterlist.h:187 enc_dec_message+0x518/0x5b0 [sev_guest]
[..]
 Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
 RIP: 0010:enc_dec_message+0x518/0x5b0 [sev_guest]
 Call Trace:
  <TASK>
[..]
  handle_guest_request+0x135/0x520 [sev_guest]
  get_ext_report+0x1ec/0x3e0 [sev_guest]
  snp_guest_ioctl+0x157/0x200 [sev_guest]

So the required fix here will address both cases.

I will note that on this instance no certificate data is being returned,
so I can't test that path, but at least the report retrieval will be
tested for the next posting of this series.
