Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A9A7D2E23
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjJWJZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjJWJZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:25:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EF097
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698053103; x=1729589103;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uzoEgn95FlWpjESdC683CrX29uh8Bf+4d6y4IyuBXCY=;
  b=XJLmrwWLe2jF6JcZSyywpNt1mGoR3FgAG8e8GXl9A6Qo9G5jZ1wcKPT+
   H51TBVjdHoMuVaBeVTdIjMAIDUhiE96QYmgZaE3MVP+c1cy8C7Z8Lrdj7
   4s0VnaAOIVQrQyqClz/ockiTRH0cNeeQPxl/SD9xF50mT1TER65wKt1kU
   an6vRPGjIVU4Elt9q2BFHXM1cpnhsKo5fV0AoB2lf6UWjy9g+JfZpOjy+
   5mgJmwaZqiz1on9dmHn+lYJRrRIe0+ZiTLJICbokxXSn6LniSFyElph6G
   XE111eMMbRk4EyTk6qFNaR0/1lxsAQfE15laLLX6REWcv3INQZQMi7lqw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="453270954"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="453270954"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 02:25:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="931635084"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="931635084"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 02:25:01 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 02:25:01 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 02:25:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 02:25:00 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 02:25:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gcn/R4LK/7wzFNybkDuu6C+VYtSONbuDsGO4rnkZyrPuoEh9592RIz6S34GduiG9yEbnnNEqFNAJPMKpJIndnYyGfkcf4sNJKRuYR3vDCGxF75/zfsaI3o0QDTdhZR7gVFQQ6C7AoJUSerii6kRsTlmk0gZRW7ZNlhgNJ85jl/gXjF2GBX9dDDhlHfxe8ByCQY+bqVBK+cmCYkZsPTxJH8R0UJwBcNDHmh/wtweElzDt89B7yIEAQIP1el9BeX65Y6dT6RbQ1KFfoMGk8Yzrupbh+ADpFQqhBAJSXhJowN2EhmLpYK/tBZ3T9s1pYtd8AuX3T8IXlfkAGxOcKcD6Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ey0+H8VIViyjgUcahG5AZ1CuzqozqSPiLmUoMSEgH3o=;
 b=gBXWKA3yX6QAiRQnF9MC3FS4lSPMylnzDuDWG6G0tNW9CVUgVFqFHHTayKwwHfM1uZ2PbsUpsitvVdaPw2cQik8GEI3r0omJGZsgcckauZx+FsX4sHqnaCzqUvhB5Q7iBxxoBhSofAEgDJOxX0tF1cqIZqqEeT1SgylI2aKiM5LEWtgikqa+5Zy+x42gt5ingi3odtuwdi9j0oh8brpVJilUIjQB76QTNMOEu3snbsJozBy5xF2LaGc+vWI1fP7Nb5qQ79uR4NI72eHCv0Pe/k8vOR0n80KNLljH5fF8W/S6hPOYlOCHujl18ygNM9g9LrUV6EGILq8C8GeyExdXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by PH7PR11MB7719.namprd11.prod.outlook.com (2603:10b6:510:2b4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Mon, 23 Oct
 2023 09:24:57 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6907.021; Mon, 23 Oct 2023
 09:24:56 +0000
Message-ID: <5258664f-1f1f-6f3d-33ca-c3b2d60601b6@intel.com>
Date:   Mon, 23 Oct 2023 11:24:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] checkpatch: allow tags between co-developed-by and their
 sign-off
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Jacob Keller <jacob.e.keller@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20231020132156.37882-1-przemyslaw.kitszel@intel.com>
 <fbd86466d325055846e5d63f62ca1dc8613ba80d.camel@perches.com>
Content-Language: en-US
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <fbd86466d325055846e5d63f62ca1dc8613ba80d.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::15) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|PH7PR11MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bca013f-c012-4dc3-7c0f-08dbd3a9ebd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: daHwYK9pXBgZn9Fu4JYv90OvbSr1d8Oudr/pqB6YGiLZyqqYYmt175YQdbMjt+Agyd0kQXmFLVhjqcAN3qaCBggDDlQJdUqZt83EuJlkUJywHLAo7ai0wZIZEeoPnQHDgWU3odN/SWDUvvAyNMAW5IFSjdKT5dnuwH4y2oHyN/yNwocQofyktNwXeAo5/I8zEBSmWuO9RXV9R8st6cf8An4fQPfr3xruGS9S57P0F2kk+gXHlZq7v4K8PQuFSUnBmiRobZgEPOykaq47YnXf3x2fENAjFmD2Z6qwfCdgIQxpx8sZbGqNBBuqR1q3umtx8PzmvgnOynXYWIZlfpnglXboFWGnXMhRUHjnIPrSk2fr4wBWSNCN/P6flszLpyVDr9Ci7kysiI8sTutdUUpQWFUZroycpOeFsxRTTtGKeaaeBmdSmIIrgnIdkAbjyoWOil0wzEximAI+0Gy7CCsqS4j9xO7maknsnFctx4zb7Z+EWl5xjpRFqdnDt0WWDtvdBJ3u+5bq6LHWUZxNlb0LKQIFhI3P1OWmfEA13BzeWhN7Fa57DS2Q5v+ppi1cT/2W64xH9XfzXB4wyACdJDsEOaNz8SEOBnguDqZ9ipP+jmhqiC6QjIZv6digQ0l0d51+TGFikcJ+XciFQUO72EA1pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2616005)(6666004)(6506007)(53546011)(4001150100001)(26005)(66556008)(83380400001)(2906002)(8936002)(41300700001)(8676002)(478600001)(6486002)(66476007)(4326008)(5660300002)(110136005)(38100700002)(6512007)(66946007)(316002)(82960400001)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlduTHVrcy9tNEJua3pENzhWaWt5a21FdVpodjR3OXVRNUtZTXR3d0tIK0Zi?=
 =?utf-8?B?MldXK2tmRFFiSERnKyt4b09ib3dFY3dvUHhKTGxvdlBaWDNPelJlSGQ0aHhp?=
 =?utf-8?B?TUVnL2RwK096VDVGU0ZvMWozT096bnlta1ZKUVp0eE14ZElTWHZmeG5NNEd0?=
 =?utf-8?B?VWlBdUh1SmhXRC9DNzd2Q1pVd294R0drMzdJL0VlZjVGVkxPaW1Yb05CWEtF?=
 =?utf-8?B?YW9SbVVwZjJ4Ymg3VW0vUEVnRjdnL3pZOTdoUUN6Nm95SGdlN1FBMDkzT24w?=
 =?utf-8?B?M2RUODJNbEsyckRBOTJSTUdreEZ4UHF3eEhvVC9BL0tBZjIrRG4rZm9QRW90?=
 =?utf-8?B?Ykw0QnM4KyszY2JLZWpia1U2MFZaNHV5TWVjQVB1K0s2SzczQktJYklIVFcx?=
 =?utf-8?B?VEt6WkJDakMxdVpTUUZFUmJuQThaWE12UXcxSUdmdVAzWS8rSXVjK2NZaVRK?=
 =?utf-8?B?WDlZUEF1cXp6UVpKOVg5Rm5ZdDVmaWNVUkFQMGUwY2pOdzNEYTdpNEFXRTR6?=
 =?utf-8?B?UHVpVnNyVUVqMkZKb2ppQkNqeXZYWUViZEtmZTlXM3FDVVpYRkVCeWp4OVd0?=
 =?utf-8?B?T2ZMNE9OTjQ2ZzdJZmZvWTE5TVN4bGNBZzQvTnd6a2F5QlRuOGRLWU1WSU1z?=
 =?utf-8?B?UDBkbjJaZW54U3RJZzJUUzQxZ0FYY2dubUZaV051VlF4bUhGRTh0djZrM3pU?=
 =?utf-8?B?eTZvYUcyU3dleUpWMVhlT0ptQzlkb29CRTZoZkxvZ3AwcktCZ1ZnN0ZDaVZk?=
 =?utf-8?B?bzl4MWoxd3VhaHBJWGhjQzlTZzJXd1hiZGhYZWJ4enRodmhQTVJDMjFMdFhQ?=
 =?utf-8?B?aUt6K0I1WW15SysrMTU2REdCcVFCektRSEU1am9BSnROaVRlbnZXVzB5a1cz?=
 =?utf-8?B?TlE3bCsyUnFVN0kwL0hkdlVJNzQwNkRycTJXanpzK0pVcE5FVHJIaE9QamJH?=
 =?utf-8?B?Q2xnUUlGRGU0cjRkcGFYaDAzMjR2eHp0R3dnbHhkT2RTMXRvVGFkeXpBSVdi?=
 =?utf-8?B?YTdEa0hURFRFdU56K3dCMUVZTkk4S1NUL2N4eXIwaWtXSDNNaG5DNXVWN1Uw?=
 =?utf-8?B?enFMU3JPcGNKeWRMVW1MdTYzZjE3SjNkUTl3QkZHZmVEYVhZc2pDd2g1N01s?=
 =?utf-8?B?YVBlZjRmQWxQeGdlR29jYW5uMnNQNE9adm1ZTkpua0l3VHh1a0UvWDZ0Qkdq?=
 =?utf-8?B?cVFxemc4OWRkVTNxNmhPY0JrOW84UTQ0K1NxZUZndXlLRW95MWJObXdvQWhB?=
 =?utf-8?B?VS9VSnBPMmZaNVJLNzVNQ216amhnZmNpVndWK2VwTjBTVGVZOFBoeXNMa003?=
 =?utf-8?B?ajJlWS9pc3p2SHJ4a2s1d1ZWTWppcmpyOFBXRW0rb3pUVVJndE0xcHVndjNG?=
 =?utf-8?B?MnM1YjltTU1Gb01SSi9QYXdkdFFlUndzMzN4V0I1MTFZQnJScWFPV3NsVjd0?=
 =?utf-8?B?ZVBnKzBzZklmSlNlYlkyaU5pMFl1YXBnM1QzeElYVE9wSjF5R2xIbjZtbkVI?=
 =?utf-8?B?Q0c2cmNKbXVDT1BHdDEyMWtxcmVNOXRINlFQdnZiOHhVWk1UNVRmYTlBc1p5?=
 =?utf-8?B?UkhGbnhDSVN5elRSWlNyOVNRYXJBSGlOdVYrNjRVbVp5MGoya2xTVUpKL0Ry?=
 =?utf-8?B?elJSeFZFYm1TNmYyVTRtNFpaZXBhYmRFTHByL0RNMVdseTlCRlplUC9TcUYw?=
 =?utf-8?B?aHQ0ZlYvWmR2b0EvRm9ZTW04dnphVGt0RHBzdmdhWmlOTGR4ZVpEZVRIdmRj?=
 =?utf-8?B?VTF4d3htek9KKzlwSFNTTEROZHBmTkkzUW1saEpKM2FwV0piRnhJeFFjcUIr?=
 =?utf-8?B?UFZiUTdwaVJLb3A1azRJM1liSFZJQUFXa0VLdVFmaW40ZUR0anNmQ1k0TTQz?=
 =?utf-8?B?ZmtSSEp0SDh5N0dKK0tCNkllN21yckk4NXV5bmhkL0dOTTRZZ0R5OVFLaHVx?=
 =?utf-8?B?Tk8xRUt5Wndwd3hCQUlYUEFrYk5OVGNJYmZaVUxyVngrT3JnTkIxbUd1VVBY?=
 =?utf-8?B?UEVIM0NESDFXbGM3SDJOaGlJZ2RZNk8zenoyTXVKNTRIY3cvM3g5Z0V3Q29J?=
 =?utf-8?B?eGFkaHIrMllCemtocjZLemd4UGlHTE83bjdsMEhxTkZEcG9TSURJM3FZaDFm?=
 =?utf-8?B?d05lcDBaNEV4T0ZXZW92Y2pteTAyUGhldHFaRkNNZng0R0dsNnp3cUVMUU5t?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bca013f-c012-4dc3-7c0f-08dbd3a9ebd9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 09:24:56.5406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zbU1e4tHk3LFm+6LXGCgb+ixq9XrTkaqTLbENswdi7LT8j6XVj3etB+LRk0W5E2lAmyzF539HXZ3cnigWgbN0HSk8Nh98/JJlyeD4TPNcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7719
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/23 00:34, Joe Perches wrote:
> On Fri, 2023-10-20 at 15:21 +0200, Przemek Kitszel wrote:
>> Allow additional tags between Co-developed-by: and Signed-off-by:.
>> Bump severity of missing SoB to ERROR.
>>
>> Additional tags between Co-developed-by and corresponding Signed-off-by
>> could include Reviewed-by tags collected by Submitter, which is also
>> a Co-developer, but should sign-off at the very end of tags provided by
>> themself.
>>
>> Missing SoB is promoted to error while that piece of code is touched.
>>
>> Two sets of perl %hashes introduced to keep both (int) line numbers and
>> (string) messages handy for warning reporting, while keeping it correct
>> across 100+ line long commit messages.
>>
>> Mateusz Polchlopek <mateusz.polchlopek@intel.com> has reported this to me.
>>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Unless this is accepted by various process folk,
> and the documentation for it updated, I think this
> should not be applied.

I will post v2 with docs updated. Would make it clear in commit message
that immediateness of SoB after CdB was important for humans checking
presence of both manually, and checkpatch has adopted such requirement
for it's own comfort.

