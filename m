Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E491E8062D4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346565AbjLEXRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEXRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:17:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03106AC;
        Tue,  5 Dec 2023 15:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701818265; x=1733354265;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tEUmPo8yQ00bVTibO9KZ23UCxDQ0A+t0c7GQJchjv3E=;
  b=XYKpLDSQXYgbX2Fm6lH0UWBkc03WZwdCl5Ud623OjfmUjn7UfDSKVJ7R
   E2kQDdExuLDIj637z7TlTCeofXLPxbjdXK3bOJXSQhmE/QXitE26341Xk
   uuYJu/BkVwPG7c//m6Rjs/N2KnbRUlcau11FoE1JNiahSPSZdzT2ZDbeE
   Mbo1Sg1mqMxZxug1o1uV4K9XLdEk0fYl7UnKcjVO/OHQUyyOAZCNYYVvf
   J9IY2WhVLXGszVIAESS66RzGc+M1c4lrwRwvvCwM6dV7dYQT97iA4goD2
   hIBPPweDqxRV8P6Bxy3+YkIenh/mF/omwv2B5ICR3IF9oH9DFKMN/33cm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="7271178"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="7271178"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 15:17:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="800138029"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="800138029"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 15:17:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 15:17:43 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 15:17:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 15:17:42 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Dec 2023 15:17:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mr40gaH/t7KL5m4SlBuBGKpOAnnEjTL4PBu9gODMuFlbWseHxL28s8jiQWewunAQ9QM45m2JjXViEcVarXlJ/CNlMl+EezI4LJe7DZ2tu5ngsuG7Ic0d5xKnwy7bXzIUjUYemtSAyGRwXlMo2/nN5wKwrveJysvvcbSH0b0mJroWmU3qrIUGuv0VNVkupoD6pN2zgv3urs1PqiMVnk+bUnUVJWPHTvWAy1C+zs1LsB4p1A6bDOVTP/dVb17vD8MJXGuNnz7y9onjYIJin3fGaV8DgWlCp6ceGa3i9tgHmopugdWeXsixd+qg5y1CM2Vyo6frzuuyKQ1z3+7QlmIiiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mibRQmAN2QgF14e4nveEAXx31F1lJkXMTeo8jkl/3Iw=;
 b=S2+luC4YcEwGSP3wGxRExizqO/JJgMUGQdKYryGTNxmv46aEJKD6rKn6UswD4vMaVH9nr6Cag73amI0PfGIeaiqqL5HOsA46nRxAnmp9GFT0JDFH0BvjZ/b/L9OTvV6yEsh+GkaqfFWoj6lLcKoq/XzBTMJpHPKLkC1suE17lnm1obcNUxrayLPdE5VO2IwkP2t47PT5QUlML1KaUNRgH83rL8wzPwkanKT9vTP7CkLwrjVvseF7XKxFAHWzEDXk70eLMXODF/X5wzqjVE5d+rdFJRmZqRZpieVvH5gaHZuwqYfN+Dd/EqrxEcEH1TvM7kxmFlDTmuh8Vo9Qbm3ojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7262.namprd11.prod.outlook.com (2603:10b6:8:13c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 23:17:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 23:17:33 +0000
Message-ID: <d97cbeba-af6d-4b64-b5c8-32dc437a67b6@intel.com>
Date:   Tue, 5 Dec 2023 15:17:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] x86/resctrl : Support AMD QoS RMID Pinning feature
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        James Morse <james.morse@arm.com>
CC:     <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
        <seanjc@google.com>, <kim.phillips@amd.com>, <jmattson@google.com>,
        <ilpo.jarvinen@linux.intel.com>, <jithu.joseph@intel.com>,
        <kan.liang@linux.intel.com>, <nikunj@amd.com>,
        <daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
        <rick.p.edgecombe@intel.com>, <rppt@kernel.org>,
        <maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>, <dhagiani@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231201005720.235639-1-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:303:b6::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: b95f8972-fe2a-4b92-d13a-08dbf5e85c40
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mEDhGIUFoUYXCtnXVxl0X8UXQpYOcHbW9JkCNLTLLNRgglI2GeIXOpcuMXOEieV/M+qAvx25g1gC1eDI2HDLLw6lcGt36E9TkK51sCSAWRQye5LPjnAa/EB9ZSfuMn2KMnGBe3pXrMnWGIsI82QLWL99JkUvwd1NLMPbDz4gVxN3cN6rf1h4rmBPQ1Akgmc2u3YXW+tK+OF8/crnra4sx5/tUkO9hIlKF2FU/9R+R9f2KJedOQCq4OAaFbEZuctvPX7/MSRNAEKByIbczU4d+N3bY9xdy3o5+OJHzoGskkJoxXi6QSIvKIY3Yc/SiGS4/WxIzZKGzZq0Uk0iOHARJpw9po2FjrnUDdjhuRgMf9TBpWVAx7jvGBZhi3+soRserhLGy+GM13u2oIljAABJiKnY/nHTXjN8vPGD4bcgieL/dcHQioUEFEGHId8hRX7LBDK5uXIOYzdf6uhXW4lOmsJh/yKGdDFp1hHf6m7fvZXdPfWJ6JJvYJNy2M89EBdHGIr7Q65fzUYvDFNiM2cPIHxti6SX5KzYi2ZVParwAjSExqxTMoq/FEoSiCMIJjojPWIcBCdLbtqZM6OtSyxLH+v9nX8Qccp1Z2Mf597IeJJ7JP3suVZvd0NII6R1w4HfUwNkWsAGCZYII4v/LyjBEnWV3P9BDPpTExyt6il4FKRUeu074VfCVCb/dsYqb0/J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(396003)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(41300700001)(8936002)(8676002)(66899024)(4326008)(82960400001)(38100700002)(86362001)(36756003)(31696002)(2906002)(44832011)(5660300002)(7416002)(6506007)(6666004)(53546011)(26005)(478600001)(6486002)(31686004)(2616005)(6512007)(966005)(66946007)(66476007)(66556008)(110136005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V085QmN0VDBxZjd6QnFaTThUaHBpa0tXMTFFR0pYbFN6dFRjYjQ5RkU4NUxa?=
 =?utf-8?B?TmgxWW1FTzdhSitUVDl0UmtTNmhFVlcvd3JyVUtWRC93bTdQSCtKRGJ5T2Rj?=
 =?utf-8?B?Y01lTTZyMVYxcWZhUzEzaXp3ejZiRFMvWEtDVTk5RW81bDkxR0g5YlJnajJt?=
 =?utf-8?B?MFZGT0lLb1VBdERLVzloYW03QnV4N3pKR01TT2J4MGNJbTFNM3czYUxpNCti?=
 =?utf-8?B?aUdUUGhQVUY2cGFhRFZKeG4yZHYveGtSMG9jNlY3eFJ2bzRSelBEQ2xkKzQ2?=
 =?utf-8?B?M0ZKTFUrQ0NraTVyZy90d3E2RHg5UzJBeTdyOTI5S09nQXNZbERUdkFGQmdG?=
 =?utf-8?B?SG5lTjQrNmVIVzNHZ1A4d2ZpR0FHWDVjN0tGenVZRFRpY1lYbXpKL2FycW1F?=
 =?utf-8?B?Q1RTQm9udjI2UHJWUDU4eHFBcTNmbXJ6dUxKNkpWRFdYS29jNEZvNzBzaCtQ?=
 =?utf-8?B?ZnlDSG9WczM4Z1RMbGd4Ym9tR0N6dHN5SUtYczFrZFlONHhJblRJNCt6dlBP?=
 =?utf-8?B?WXJ2ZGlaNkhtcVg2ZExoY2FHK2wrUThvYTNmS2xVUGFCTTRMazZVU1NGb1lD?=
 =?utf-8?B?SHRHb0xaOVdQRzI5SUxheEp3Sjc5MDdDOFBVS0QxOWtIQjRKYU5VNEppWEQy?=
 =?utf-8?B?QXNJckVnNTQ5Y1luanZpV1JaNUhxb1Q0UWllcjdiU0JvSVBra2hIc3FubjB1?=
 =?utf-8?B?NFp6aldLc2FkeUFSM2FjWGd2RStWOENHZ3JaZjB5YXdTemhPM1RwekY3bUFH?=
 =?utf-8?B?RCtUazc2c2lIdmt1RnRsakNSYk1VU0pWQUgyakM0K3ZwUER0cHAxZXV6ckpF?=
 =?utf-8?B?NHpRUmtIang1RStWdW5wWXNIQVpHcjRNSThKdFZDY0MrVkFzamdCcWpqcUJn?=
 =?utf-8?B?YUIrWDdzZ2pBME5wKzhmZmhwdjVPaU56RWJ4R0ZvZXMvMDIwOGJmMGJYRzBl?=
 =?utf-8?B?WW1RZ28zZHhDQ0Y2d3Y1VzJHdFE1eVJSZFFmS2Z5azFGRU51VzBQODNLUy9V?=
 =?utf-8?B?b1BNb2NBbFptY2s3elliU0RhMkQ2cFNFY1lTZGw2MDRHSlRVNW9tNUxTZGFJ?=
 =?utf-8?B?U2RzUE90c080a3hMZUhrczltUnhtNGxjSEZqQXpoY0l0RjA5ek1hVWhGVXNF?=
 =?utf-8?B?NmtyUU1mZnI3VmZJbHMzVXVsN3ltUUE3bjhKZjRGWlZUTDZUcThqcVBycG5X?=
 =?utf-8?B?My9yNnovai8xNm1RZ2RDdXl0UFNqSVJFaDFIMkZ1RGVZSzNlUGFrZXRNcnor?=
 =?utf-8?B?cWpSK1RVTlhxRTMyTHZpTFFFdDJ3WkVTeDViM0V4TlJTN2lpdjJiOTdPRGo1?=
 =?utf-8?B?bndPb0VPcGYwWllPc1RvTDExNXZIblpBSEppVllLaDZ2bHlibllJZjMxbkZu?=
 =?utf-8?B?b1FsaGtaQ21tSURPYWg4QnZDT3MrcFg4N0piSzdrbUh5bEFQZGx4K05mSk92?=
 =?utf-8?B?aHVEZGxVbjJHbDRUTXpMT3FYT3B5L3F6YTk5M1U4dlZrT09OeXJSYUthOHly?=
 =?utf-8?B?eklmbmNCT2g1eVBDYWpIRHZTNjRQN3MvbUV5d3JXMVplMWFaOFlBL3dIS2NE?=
 =?utf-8?B?SkVRUk90cmRyd254WUp4NEpid3hKOW85S2Fqd2RuK210VlhCM0NKN3ZXMHhy?=
 =?utf-8?B?b2JZQlp5NmlPeEEvMExqZndjNFVEbkVUeVNOY1czUHFYd0NZVkh6MnMxNmFn?=
 =?utf-8?B?VDAwNDBaMWFMV1lFczZYVzUvMDBkcWdqUDFuUUFlZFQwU2ZuMktIRlNxTUZj?=
 =?utf-8?B?Q2NOejAybzNYTFJmcjIwb1RnY210b3RjMTBrODJkZ011ZGVNVmF2WlBBejVQ?=
 =?utf-8?B?cktkUjB3R09McTk5RDFSS3hSMVVCMVR4UlVvcUJwUmJSNXVmNFNZdFdrbGtK?=
 =?utf-8?B?eTdFQ3c4SGN6Y1JNUU1uVGhJNXI0U2pHdWJudWlEZ1pSNjZsUWtEQmt4eXpU?=
 =?utf-8?B?bm5uV291dlNqRDEySVpaWW9zeWxUcUQ5N0dNL0lVSVpKYUEwY05VbWQ2VjZk?=
 =?utf-8?B?VjNpQWZxR2x0QmhiNkN0UjAxSnZOS2lyaDBobkpTb2JWZm82aXBsd2JFUTVU?=
 =?utf-8?B?ZFpPQ2JqWVZubVVlUjRYYzBqR3FaeFZJNmdRTzNTc1c5UkwxQjhWYm9MQnY3?=
 =?utf-8?B?bnA0aE9wOHE0bGNpOW5OcWxpV3VoODNLeURMazdQck95MmlkUk16MkVvZWJW?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b95f8972-fe2a-4b92-d13a-08dbf5e85c40
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 23:17:33.5083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mp8dqfGaVbzyDsvV6PYaearj1hC5feZxKAcanyg2/s1OPrX0xjh8u8gqrtmAA36QTYqf1T28q6w+AmvMLCv9rdGGhb7NB0MW9vysyDDHUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7262
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

(+James)

Hi Babu,

On 11/30/2023 4:57 PM, Babu Moger wrote:
> These series adds the support for AMD QoS RMID Pinning feature. It is also

"These series" - is this series part of a bigger work?

> called ABMC (Assignable Bandwidth Monitoring Counters) feature.
> 
> The feature details are available in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC). The documentation is available at
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> 
> The patches are based on top of commit 
> 346887b65d89ae987698bc1efd8e5536bd180b3f (tip/master)
> 
> # Introduction
> 
> AMD hardware can support 256 or more RMIDs. However, bandwidth monitoring
> feature only guarantees that RMIDs currently assigned to a processor will
> be tracked by hardware. The counters of any other RMIDs which are no
> longer being tracked will be reset to zero. The MBM event counters return
> "Unavailable" for the RMIDs that are not active.
> 
> Users can create 256 or more monitor groups. But there can be only limited
> number of groups that can be give guaranteed monitoring numbers. With ever
> changing system configuration, there is no way to definitely know which of
> these groups will be active for certain point of time. Users do not have
> the option to monitor a group or set of groups for certain period of time
> without worrying about RMID being reset in between.
> 
> The ABMC feature provides an option to pin (or assign) the RMID to the
> hardware counter and monitor the bandwidth for a longer duration. The
> pinned RMID will be active until the user unpins (or unassigns) it.  There
> is no need to worry about counters being reset during this period.
> Additionally, the user can specify a bitmask identifying the specific
> bandwidth types from the given source to track with the counter.
> 
> # Linux Implementation
> 
> Hardware provides total of 32 counters available for assignment.
> Each Linux resctrl group can be assigned a maximum of 2 counters. One for
> mbm_total_bytes and one for mbm_local_bytes. Users also have the option to
> assign only one counter to the group. If the system runs out of assignable
> counters, the kernel will display the error when the user attempts a new
> counter assignment. Users need to unassign already used counters for new
> assignments.
> 
> # Examples
> 
> a. Check if ABMC support is available
> 	#mount -t resctrl resctrl /sys/fs/resctrl/
> 	#cat /sys/fs/resctrl/info/L3_MON/mon_features 
> 	llc_occupancy
> 	mbm_total_bytes
> 	mbm_total_bytes_config
> 	mbm_local_bytes
> 	mbm_local_bytes_config
> 	abmc_capable ←  Linux kernel detected ABMC feature.

(Please start thinking about a new name that is not the AMD feature
name. This is added to resctrl filesystem that is the generic interface
used to work with different architectures. This thus needs to be generalized
to what user requires and how it can be accommodated by the hardware ...
this is already expected to be needed by MPAM and having a AMD feature
name could cause confusion.)

> 
> b. Mount with ABMC support
> 	#umount /sys/fs/resctrl/
> 	#mount  -o abmc -t resctrl resctrl /sys/fs/resctrl/
> 	

hmmm ... so this requires the user to mount resctrl, determine if the
feature is supported, unmount resctrl, remount resctrl with feature enabled.
Could you please elaborate what prevents this feature from being enabled
without needing to remount resctrl?

> c. Read the monitor states. There will be new file "monitor_state"
>    for each monitor group when ABMC feature is enabled. By default,
>    both total and local MBM events are in "unassign" state.
> 	
> 	#cat /sys/fs/resctrl/monitor_state 
> 	total=unassign;local=unassign
> 	
> d. Read the event mbm_total_bytes and mbm_local_bytes. Note that MBA
>    events are not available until the user assigns the events explicitly.
>    Users need to assign the counters to monitor the events in this mode.
> 	
> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> 	Unavailable

How is the llc_occupancy event impacted when ABMC is enabled? Can all RMIDs
still be used to track cache occupancy?

> 	
> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
> 	Unavailable

I believe that "Unavailable" already has an accepted meaning within current
interface and is associated with temporary failure. Even the AMD spec states "This
is generally a temporary condition and subsequent reads may succeed". In the
scenario above there is no chance that this counter would produce a value later.
I do not think it is ideal to overload existing interface with different meanings
associated with a new hardware specific feature ... something like "Disabled" seems
more appropriate.

Considering this we may even consider using these files themselves as a
way to enable the counters if they are disabled. For example, just
"echo 1 > /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes" can be used
to enable this counter. No need for a new "monitor_state". Please note that this
is not an official proposal since there are two other use cases that still need to
be considered as we await James's feedback on how this may work for MPAM and
also how this may be useful on AMD hardware that does not support ABMC but
users may want to get similar benefits ([1])

> 	
> e. Assign a h/w counter to the total event and read the monitor_state.
> 	
> 	#echo total=assign > /sys/fs/resctrl/monitor_state
> 	#cat /sys/fs/resctrl/monitor_state 
> 	total=assign;local=unassign
> 	
> f. Now that the total event is assigned. Read the total event.
> 	
> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> 	6136000
> 	
> g. Assign a h/w counter to both total and local events and read the monitor_state.
> 	
> 	#echo "total=assign;local=assign" > /sys/fs/resctrl/monitor_state
> 	#cat /sys/fs/resctrl/monitor_state
> 	total=assign;local=assign
> 	
> h. Now that both total and local events are  assigned, read the events.
> 	
> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> 	6136000
> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> 	58694

It looks like if not all RMIDs asssociated with parent and child groups
have counters then the accumulated counters would just treat the "unassigned"
as zero?

> 	
> i. Check the bandwidth configuration for the group. Note that bandwidth
>    configuration has a domain scope. Total event defaults to 0x7F (to
>    count all the events) and local event defaults to 0x15
>    (to count all the local numa events). The event bitmap decoding is
>    available in https://www.kernel.org/doc/Documentation/x86/resctrl.rst
>    in section "mbm_total_bytes_config", "mbm_local_bytes_config":
> 	
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
> 	0=0x7f;1=0x7f
> 	
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config 
> 	0=0x15;1=0xi15


These would not be available if system does not support BMEC. From
patch #3 it does not seem as though ABMC is dependent on BMEC.

Is ABMC dependent on BMEC or are they just using the same
config bits?

> 	
> j. Change the bandwidth source for domain 0 for the total event to count only reads.
>    Note that this change effects events on the domain 0.
> 	
> 	#echo total=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 

typo?

> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
> 	0=0x33;1=0x7F
> 	
> k. Now read the total event again. The mbm_total_bytes should display
>    only the read events.
> 	
> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> 	6136000

hmmm ... seems like there is a need to make the MBM events configurable even
if BMEC is not supported.

Reinette


[1] https://lore.kernel.org/lkml/CALPaoCjg-W3w8OKLHP_g6Evoo03fbgaOQZrGTLX6vdSLp70=SA@mail.gmail.com/
