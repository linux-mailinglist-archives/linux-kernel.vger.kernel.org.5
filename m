Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCEA754479
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 23:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjGNVya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 17:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjGNVy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 17:54:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFD71980;
        Fri, 14 Jul 2023 14:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689371667; x=1720907667;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ziTdatYd5Rt109I+vEsgQsZ1YQv3KpzgRisZQzZeEHw=;
  b=MEp7kssjqiCJ6/IRQjFi2F+EMTdoZxSkra2ihGiblZ+69ZWLHfcjiQjX
   rYB70/FwSSHbRnR52UWI7hYt7f1GarXTOGNP160JpDW2eYa57i4YCqZ0D
   LnZPABdY+o7DBhxfmmhI+obFHa3pX/HJ0QpwhovQL0XPuj3+GI/JKM+RK
   pcaMJlJ7l4g0avBzZPnTPLfTaJenW1BooDNekccxoTSj7gRWjuhoNGxB9
   MLVnJc9N8YVRADGf5KSReqCeTpT5Lej3u/rRLj69hlPd9iAfu9vh+8c68
   yTmh5i/3fomMl211t2b2tW1XStHCAWLZZYmpCK/iNSxlUoQ4+2aV3ZG6J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="364456371"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="364456371"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 14:54:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="752191659"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="752191659"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 14 Jul 2023 14:54:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 14:54:24 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 14:54:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 14 Jul 2023 14:54:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 14 Jul 2023 14:54:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAvqOuVwKzOkxrnYx8YP0yW/+vn4qNMeKnedkxM6vh6RRaiFDri4rTwNxbz3UD6Vj4igt+3oWjpj9YQZ6b5ZdBf4DRsts11qOlCluCRw/uY6j+L9zXTnChy2xqKkIn6j7/u7Ne96nPygfii9vuhiiWRPDyfMwrhf9cYNPASDE9pKnDHKnfL/LrglyY8SWTIHOQm8Ka+0flfG1gWHGRttHwkZg2J4EYhqCzAMAJvwsOdj5RZLdT5l6LzrFkb+sTb6PeteB65WO51w1AXan0NNmJ6rNx1ddXvGdn6OSYqpLJqHA8G/7yqJLQKEenN4CqmKPOdHo3IVJempm/vjpRTYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKxDE2THzNClyO2DeAUaDAhAI5z8nqb7lSExWRrVLdg=;
 b=Nu1zHmPpn9MGDRbcBpDvyqLect1iL9jyM5DLkyrcxMbcs/XDSg8pviONCnmP8Y/QoDt4N/mJcH+3Ik41bS7jSVCptwhVJEQZ1ZenVVxqIvrmAj12w1hi+Ey38dM1ncMMBloHVCxQi+sC7VpM09623tIO3MOFly993afHEoN+THyBLVbFOv/m/DnO2axNiXqkVTrIRUuS/ATLd3bAzQcy/FhCNQH82w0pESuf2ulgJjTFupRJ/6b0e9KY8JC31yxCYOAcPqLlfDhCqJ1gfVos7bnDVwxY85rp+R/0UowU9Nho9r1GH8jQNBQl+rWMACqaXCXovpVv1x8AC3k0Z9gqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB8404.namprd11.prod.outlook.com (2603:10b6:a03:53f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Fri, 14 Jul
 2023 21:54:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 21:54:21 +0000
Message-ID: <8f68ace7-e05b-ad6d-fa74-5ff8e179aec9@intel.com>
Date:   Fri, 14 Jul 2023 14:54:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v5 7/8] x86/resctrl: Move default control group creation
 during mount
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
References: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
 <168564612103.527584.4866621411469438225.stgit@bmoger-ubuntu>
 <9cb1a07b-0e17-d930-263e-5433952cf241@intel.com>
 <c10643f9-ac6b-7912-1fe1-c9446c79b931@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c10643f9-ac6b-7912-1fe1-c9446c79b931@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0051.namprd16.prod.outlook.com
 (2603:10b6:907:1::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b1017d-e5f0-43f0-d7f0-08db84b4e142
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5hnxv60tTzEtzQJxT1Np6um6sUI7Y2quhFU3eTEeX5BRMyCDeMrvQpi7nzbpOKciSA3XS8rv3MrROFZ56+kgRJ/Os2fy08FBSveC76bPAMrDbGEcB7mj43TnXTaqPScffHD180QMHcxp+/7aDv07p5wsCP5YlMH/BdAJjK1omEnIYVi0V9pagAsgUOuX9puDOG1RZtuPWrFQFDrL0J71yA3QZjZC4k1iBme0DKS1MUXy/xw33IvIQSVgR8S05rijFD3BfV4WboLthvlU+dnzIdyUtHSvqbukTGmUBawI9tMhiw/HbOannwM55OATNwW24fgRbJZuoEMBMPtmTWS95XVvJuNzh2IAKCrz6fQMmQfOawDyJeHXO50oxaBYwxkXLgGUB2MNef+a9AtWxzTThKLHDBGVfkd4D/B+JawF3H0zqjQW9Su6HP2mHPSY0PdFRgTggsAE13ulCDMe47yVstgHlKuLw+PX1xLMPGYGmDP8lhI78eiUMIfnqxls3/AgasXd5gb7r6HrATVFmOeAOI430+byPt9xSUfsgJrofpoQ8bnQnva003Vx0XOBNItRAbpDXHwJtQ6DLfVoDLFZZWUTM4hXvvqix3RpLepgSEQT3lvxKX3sGhV9ODCu/VXTqJN/V8Qbj9Xewqq7zLmfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199021)(2906002)(83380400001)(31696002)(86362001)(36756003)(82960400001)(38100700002)(2616005)(5660300002)(26005)(6506007)(41300700001)(186003)(6512007)(6486002)(6666004)(53546011)(66476007)(66946007)(4326008)(316002)(66556008)(478600001)(8936002)(7406005)(7416002)(8676002)(44832011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkRwcysvNDVrdkp3MG5kWWU0N1RvN05RYXJyTDkyZ1RPTlAxSXJ1TStGSjBo?=
 =?utf-8?B?QXBFRXBIdW80RjNUdFRqZkk2bGtWUllPeTRMVmd4UysvN3c5MWIwblBqTS9G?=
 =?utf-8?B?dXZ0Z1d4THgvMkt6anNibW1YZlYva0k1SVhrUjEzN3FMeDZlUFlpL3pNNzc3?=
 =?utf-8?B?Q0pEWE5QVTl5UktuZ1FwVmtVMGxrTDl5Z2dmK25QWDJ1dU9WbzZYSHdLOUZt?=
 =?utf-8?B?bkRnUDV4RnJYRkJJaU4yQTcrdjBnOFRZYnNHSG5xNFlUVDk5VUpiT3ZxdnJk?=
 =?utf-8?B?bll6aVZ5eThIRENPV2VvM2hNUWJKZnl6dXlyL3k1d1Z3d1c2U0xvbDIrMWE2?=
 =?utf-8?B?cEYvL0MzQ01hdGgwbm9QVnU4OVdyQzFyREVsMkhFaDE1OENHMkpma3ZCUldz?=
 =?utf-8?B?Z0VZUjIvRlUvalB3aVZzZlJHNHNTQ25wckNxdEpwTXBuekUrOVZ0anFURzlJ?=
 =?utf-8?B?TnU0UlpUR0U5L3Q5SHFheklhb1VIeUVRY3c2cnBLZTJvcjNST2hXV1N3QUdk?=
 =?utf-8?B?U25QSnJ3ZmZXVUdSQUUrcTlPamNTdlNYK1NQbVZUQnEzSzM4bmFPSElzZFlG?=
 =?utf-8?B?WVZncnVHSWFCd09SYkowNzdQQjU4UUhvQ3l0VzBQR3RHRUFsVE4vaUducVZ0?=
 =?utf-8?B?bDVuVkg2TjFSaEcvR2tucmFOYWtYM0lFOFRaNmYrbEMrdExaT1dpbUN0Z0VQ?=
 =?utf-8?B?YndCVkJvci9GMWFMcFN0RkhwS3ZkNHFOb1R6QVdQc2hFb2J4c3lqeVpEOEhy?=
 =?utf-8?B?Qlo5OTBYRGI5MDNPVldlaForRlRnZW0xWTMwU0JBUkVlR2ZCb1NxbXVXQmZU?=
 =?utf-8?B?Y0U1c3g3cUp4b2VTK2thbmxsc2FwcnlRbGI3aHNLNUZHZUR5NmgzT0UvaUtu?=
 =?utf-8?B?WXlRQlB5MG9ZbitaMTByRWM1dXZxdTYyNGlSZ1EwN1ZkcWRHTUQwUWR5ZlBF?=
 =?utf-8?B?ZWlZV09UOWFBYzQxa2hZMS9VZ2dPMDlqcW9NK2drZ3dzajRyd0ZHQldKTCtu?=
 =?utf-8?B?V1BLMSsxQzFyT2l0T0JENHhLY0VWVFdYS09MYS9KYTRodVJlc1hwVFB0SnpW?=
 =?utf-8?B?SDc2bXpnQzVERkp0VTBkekdabFFveC9JRDB0QzVKcUhwdHQzcWtxNUtlRWhH?=
 =?utf-8?B?T1Bjd2ZMYk1rYlplRkJmRVQ5cGdzd2hvakZ3SEhNYXk1SG96ZzVmeU1aWWxH?=
 =?utf-8?B?aHcrajBORnp1M21KVCtBZ1ZqZjJnMlduSlE5RnRremJXQzBYbHhXdmNwbVRR?=
 =?utf-8?B?bks2aWN0bUlrQ05YUU1BV0JrL2N5ejJrVFN6anNIVjNHbGhBeU5FSnVUU0Y3?=
 =?utf-8?B?RElwcHlEbFpYUlVXZndJWFVJd1JEaS9VYzN0UmJEOVFCZTFLTlZNSUhLbWgx?=
 =?utf-8?B?TTJCSzhLdkdGQTN1dzd3N3FnL3BVR0FyZWRuMlBJdERUbUxmQWRxZDVWS01J?=
 =?utf-8?B?SG8vdlY5Y3ZtWWxYanZkT29mOFNyMWJvRythWk1lNGFkcFliaTJMR2x3bjA2?=
 =?utf-8?B?Zk1vTEdzam1CaXYwanFkajMwa1BWU2owcHJNWTlxQmhGNksvQ0UxcTNDM3ZN?=
 =?utf-8?B?M0pkaXQyQVpaTFAwUGNrTFllNXhZUi9DSExRbTdqVnloV3IzRUFMZ3NMUkdC?=
 =?utf-8?B?R3FDZU14aUIrMU84ODRsMk0zS1pIeDFNd1NQek1rajFXVWNlMHVBT0hCTHVM?=
 =?utf-8?B?SGtyaEZxSitPUnhyYjd0R1N3VTQvTnVkMStNMlJKRS80eXk3OVVwRG1XTUxp?=
 =?utf-8?B?aXhPYnZxNVoyRXVnNExtMXpwWXhWTkdiMUh5Szh4eUdORm1FOGhZMERLcnFx?=
 =?utf-8?B?cmREamRNTk5rbTByMDVlWHFIOE1DZHZJeUJrOUE3R0tjUGMzOXVUYXUrNWJP?=
 =?utf-8?B?bUxUVUUvaGlqV1RXeG5BemVVVzVlM1BieVFQLzltRWV6YmZ2b3NTMFJxbHcw?=
 =?utf-8?B?bVNtTENYWWZDcXMzRC85NGJLQ2JDQklhWGtENzVJOTdzQVFUcTlxeWFzRmJl?=
 =?utf-8?B?WXViZUV5T0drd1k3dmYzeCt2STVPSmtLZGQ0RktvTTlWMXFtbENZdXRCUEZm?=
 =?utf-8?B?dXduMThzcit4NjhsQkFRSUE2QktHdVhUeGRwbHRxdmVIUVpNNElRcllOeFN4?=
 =?utf-8?B?UFB3STVkZVVUNCtsZ3NITHhHWXR4aUpad1hmeG9KQjlaTUtlckFYNTd3SUo0?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b1017d-e5f0-43f0-d7f0-08db84b4e142
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 21:54:21.2842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4M6KS4Rj+Nh68HQGGgE0WSTAf5ou9LtNPY///hO9nDtD1dB49lteHuFUKkMXkDEGfInbcjAMJBhHx0bbnL6tudBZ4HrO/ObIwROcVbs/vK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8404
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 7/14/2023 9:26 AM, Moger, Babu wrote:
> Hi Reinette,
> Sorry.. Took a while to respond. I had to recreate the issue to refresh my
> memory.

No problem!

> On 7/7/23 16:46, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 6/1/2023 12:02 PM, Babu Moger wrote:


>>>  	ctx = kzalloc(sizeof(struct rdt_fs_context), GFP_KERNEL);
>>> -	if (!ctx)
>>> +	if (!ctx) {
>>> +		kernfs_destroy_root(rdt_root);
>>>  		return -ENOMEM;
>>> +	}
>>>  
>>>  	ctx->kfc.root = rdt_root;
>>>  	ctx->kfc.magic = RDTGROUP_SUPER_MAGIC;
>>> @@ -2845,6 +2860,9 @@ static void rdt_kill_sb(struct super_block *sb)
>>>  	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
>>>  	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
>>>  	static_branch_disable_cpuslocked(&rdt_enable_key);
>>> +	/* Remove the default group and cleanup the root */
>>> +	list_del(&rdtgroup_default.rdtgroup_list);
>>> +	kernfs_destroy_root(rdt_root);
>>
>> Why not just add kernfs_remove(rdtgroup_default.kn) to rmdir_all_sub()?
> 
> List rdtgroup_default.rdtgroup_list is added during the mount and had to
> be removed during umount and rdt_root is destroyed here.

I do not think it is required for default resource group management to
be tied with the resctrl files associated with default resource group.

I think rdtgroup_setup_root can be split in two, one for all the
resctrl files that should be done at mount/unmount and one for the
default group init done at __init.

>>>  	kernfs_kill_sb(sb);
>>>  	mutex_unlock(&rdtgroup_mutex);
>>>  	cpus_read_unlock();
>>> @@ -3598,10 +3616,8 @@ static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
>>>  	.show_options	= rdtgroup_show_options,
>>>  };
>>>  
>>> -static int __init rdtgroup_setup_root(void)
>>> +static int rdtgroup_setup_root(void)
>>>  {
>>> -	int ret;
>>> -
>>>  	rdt_root = kernfs_create_root(&rdtgroup_kf_syscall_ops,
>>>  				      KERNFS_ROOT_CREATE_DEACTIVATED |
>>>  				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
>>> @@ -3618,19 +3634,11 @@ static int __init rdtgroup_setup_root(void)
>>>  
>>>  	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
>>>  
>>> -	ret = rdtgroup_add_files(kernfs_root_to_node(rdt_root), RFTYPE_CTRL_BASE);
>>> -	if (ret) {
>>> -		kernfs_destroy_root(rdt_root);
>>> -		goto out;
>>> -	}
>>> -
>>>  	rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
>>> -	kernfs_activate(rdtgroup_default.kn);
>>>  
>>> -out:
>>>  	mutex_unlock(&rdtgroup_mutex);
>>>  
>>> -	return ret;
>>> +	return 0;
>>>  }
>>>  
>>>  static void domain_destroy_mon_state(struct rdt_domain *d)
>>> @@ -3752,13 +3760,9 @@ int __init rdtgroup_init(void)
>>>  	seq_buf_init(&last_cmd_status, last_cmd_status_buf,
>>>  		     sizeof(last_cmd_status_buf));
>>>  
>>> -	ret = rdtgroup_setup_root();
>>> -	if (ret)
>>> -		return ret;
>>> -
>>>  	ret = sysfs_create_mount_point(fs_kobj, "resctrl");
>>>  	if (ret)
>>> -		goto cleanup_root;
>>> +		return ret;
>>>  
>>
>> It is not clear to me why this change is required, could you
>> please elaborate? It seems that all that is needed is for 
>> rdtgroup_add_files() to move to rdt_get_tree() (which you have done)
>> and then an additional call to kernfs_remove() in rmdir_all_sub().
>> I must be missing something, could you please help me understand?
>>
> 
> Yes. I started with that approach. But there are issues with that approach.
> 
> Currently, rdt_root(which is rdtgroup_default.kn) is created during
> rdtgroup_init. At the same time the root files are created. Also, default
> group is added to rdt_all_groups. Basically, the root files and
> rdtgroup_default group is always there even though filesystem is never
> mounted. Also mbm_over and cqm_limbo workqueues are always running even
> though filesystem is not mounted.
> 
> I changed rdtgroup_add_files() to move to rdt_get_tree() and added
> kernfs_remove() in rmdir_all_sub(). This caused problems. The
> kernfs_remove(rdtgroup_default.kn) removes all the reference counts and
> releases the root. When we mount again, we hit this this problem below.
> 
> [  404.558461] ------------[ cut here ]------------
> [  404.563631] WARNING: CPU: 35 PID: 7728 at fs/kernfs/dir.c:522
> kernfs_new_node+0x63/0x70
> 
> 404.778793]  ? __warn+0x81/0x140
> [  404.782535]  ? kernfs_new_node+0x63/0x70
> [  404.787036]  ? report_bug+0x102/0x200
> [  404.791247]  ? handle_bug+0x3f/0x70
> [  404.795269]  ? exc_invalid_op+0x13/0x60
> [  404.799671]  ? asm_exc_invalid_op+0x16/0x20
> [  404.804461]  ? kernfs_new_node+0x63/0x70
> [  404.808954]  ? snprintf+0x49/0x70
> [  404.812762]  __kernfs_create_file+0x30/0xc0
> [  404.817534]  rdtgroup_add_files+0x6c/0x100
> 
> Basically kernel says your rdt_root is not initialized. That is the reason
> I had to move everything to mount time. The rdt_root is created and
> initialized during the mount and also destroyed during the umount.
> And I had to move rdt_enable_key check during rdt_root creation.
> 

ok, thank you for the additional details. I see now how this patch evolved.
I understand how rdt_root needs to be created/destroyed
during mount/unmount. If I understand correctly the changes to
rdt_init_fs_context() was motivated by this line:

	ctx->kfc.root = rdt_root;

... that prompted you to move rdt_root creation there in order to have
it present for this assignment and that prompted the
rdt_enable_key check to follow. Is this correct?

I am concerned about the changes to rdt_init_fs_context() since it further
separates the resctrl file management, it breaks the symmetry of the
key checked and set, and finally these new actions seem unrelated to a function
named "init_fs_context". I looked at other examples and from what I can tell
it is not required that ctx->kfc.root be initialized within
rdt_init_fs_context(). Looks like the value is required by kernfs_get_tree()
that is called from rdt_get_tree(). For comparison I found cgroup_do_get_tree().
Note how cgroup_do_get_tree(), within the .get_tree callback,
initializes kernfs_fs_context.root and then call kernfs_get_tree()? 

It thus looks to me as though things can be simplified significantly
if the kernfs_fs_context.root assignment is moved from rdt_init_fs_context()
to rdt_get_tree(). rdt_get_tree() can then create rdt_root (and add all needed
files), assign it to kernfs_fs_context.root and call kernfs_get_tree().

What do you think?

Reinette


