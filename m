Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BFB790397
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbjIAWTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345158AbjIAWTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:19:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321152D56
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 15:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693606763; x=1725142763;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uElSkQ7N8wJ0oJHsz8dw73nC0kT6zihb0kzZaVLvV6I=;
  b=IHNccJkxRYsQ9RMdM9fKFN1caA2eFQMnUqRKvH07pi9V7bPg3bwVPM3C
   j7s72+5QIxOpsXYaqERafvvkcZcE/gf2M8Sy8yIO0gQrza4+mbkWfdvlh
   LMxSSN6iwFjld8fJD/M0RnroAp915oz0Wap4drsAYtNxTjYRJn8QZao+N
   eVQ8AEi5VMFAZk/ttaWW+l0mDZrcwJ/xy0o15wh/6P7LfxleaDTP4pcbt
   tUTEDnxQwtj5N9coiy+yxumS/xCfKs8FWnZxx6kJX8WUtI8NPZFyKEOv8
   WtLiTp61RtLbHD2jMu/67ehRut1wEqaeAAR7pgydpTKKSOmc544HLrJEG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="462680333"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="462680333"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 15:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="1070891469"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="1070891469"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 15:19:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 15:19:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 15:19:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 15:19:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWrEFjtaNPHV4b0Zwgb0nLRl+aWCUtrzEQ5e2uh3i4Bje2G1AIPyFADAvaSusfu70VshegiDPj+Gi+WVlSuw1jpYjK+USTvJPjwkqbdbKCHviMAGyLrRkVVRWiSokend5ZGc/UZmBzm/iNmmFTOxu2f61Zeew4mO/DvSuz5819uq+pxqxtnCTueYp0PPYDRDfHUbULJU6fvpunJ42z9iZ/SfJULJQ+OzSpQi/16OKM3MA+5KM/Ojre/yu0CPjNyx2GAtshwrOS+7uxH0fJKRrwa64jR+QSOr4NJkuej62KdojiDT5d7wMTqr9x8URlimDXwGnkeekr2Z2tC4Tz4SHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ie7LBCuQPNF3lPA3oB2oEWAIbt7PClassvQaAfALTg=;
 b=LFwRrwEkmNqnBXBf7N8EmeMxDlzAiAStn/djFEAC3mUnhCI3Sv+RZZqInn+D7g+N/wlV63aKGuWKnclVrzm1z9YgUGS02rGs/L3soyeAWSGPR7ZWj8CpfEmyNK3Ng5c2NcSu5o+oSptWc9NzRLUI/PHzy8sD668JqMMQE0xKUCCCIuy0xzQmAteZ44DSs+W5w0qeThsrnqQH3UgL7hNspdFBvOcUCrJrMgIKzCi0iBPmoI/ffAD+mXdTnQfB8o/eVu+e8eZR+VWq1sjXU0GrfEkJkTOu7/Xthu+IaMXfdkLKqJf31PuF29SdVFrM6X8ziOwQSSyLW3f8lC3DPLCMaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM4PR11MB7182.namprd11.prod.outlook.com (2603:10b6:8:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 22:19:19 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::5e34:ee45:c5e8:59d0]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::5e34:ee45:c5e8:59d0%7]) with mapi id 15.20.6745.020; Fri, 1 Sep 2023
 22:19:19 +0000
Message-ID: <148522e4-a4ec-a35b-df25-e04eeb5f51c4@intel.com>
Date:   Fri, 1 Sep 2023 15:19:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] selftests/x86: Update map_shadow_stack syscall nr
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>
References: <20230901181652.2583861-1-rick.p.edgecombe@intel.com>
 <e2ae1d89-9abf-338e-e56a-dc4be19b9bfc@intel.com>
 <b92afa6dbd074409095e525204d538f451ee4823.camel@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <b92afa6dbd074409095e525204d538f451ee4823.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::34) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM4PR11MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 7abcbfb2-990a-464a-eca1-08dbab397c6d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0urtKpH7aNNnLKTbKRhVBzstF8letltNaaDTerJoSBjeFTUujWOgTymIA0otPlGCBNN3k6vYqbcUBolBm4WFig4k87AgWeFjQnNp9A9vDDlE8D3/qBKz+c24HJGxDQqKA1/oFznod3c28w8PcGz2ZZXH+Vhr/KEGL5bKyy+u5Wb8Mv2UTmxfHYqJiOrIcaZmWrQ1KfREWvawr2NCU3362BdPeCvLtfGAszQojmuSPWOCQiNddUoWVSpasRbiHrl92myLyA+gQobNxwqnkEOZscHPxzWC9lDJZWjSUqhZRfKMSRMFcylnOciHFs5mrugy5qoYvSLL6tYrhdAeukfNtP93EMRrTUPrtD0kX4Gh96JXHQkLUOrsChUAYUTR8+9NxNKM6qKjam0gAcGWkq2Z57/DEjeKIEyE77ZZycX4+AfwYgFiP+7b7EsuH8jYCxGuKQ7VeMB2gdAgWRHzdqwbjoyZxMVbMzKm595PCXUE5cz29xJifMSHQQZAKu2U0dvTslepdoEpyOvJ06/lRvVIX7QwbxMIw3Fs6i5YHHsGIwSMtQ2lgFMyIcB3K2mc/yRDoNqtOpmolInNoQZyrMApaxWPSzUMJUSC2DkeHgALGVsMD93ihrFNRwRCabira+lb+StdcsZAj5QanoBCFL/hbMqlDuVUopKipxa6IsMA1fY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199024)(1800799009)(186009)(31686004)(921005)(82960400001)(6506007)(6512007)(6486002)(86362001)(31696002)(36756003)(38100700002)(2616005)(26005)(15650500001)(2906002)(53546011)(83380400001)(478600001)(110136005)(66946007)(4326008)(8936002)(8676002)(5660300002)(44832011)(7416002)(41300700001)(66556008)(66476007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXdJWEh4b0VaTmxhQmN6TDByaTZCMnJSbkFoQ0FKL1lwM3pzT0k5V1AzdmRn?=
 =?utf-8?B?SjFnakhFMDRianlrOEZqT3hkWWxmcnN2UlBJY2FSblFoUGIrN1RpVFhuTUtQ?=
 =?utf-8?B?c3dCQndxRDlZeFk4U2ZySjVQZWJCcXcxMzhCK0VSYmpWdlhGK2p5UGJSbHV5?=
 =?utf-8?B?SFBRQ2pRSkhLUi9MdXMzYnYyVmV0SUpQZ1I0eVEzRUVtNGN5am9MQ3k0RVh4?=
 =?utf-8?B?Rzg2K21RWFBxenlJNVpXQzVwanR0R1JFOHQ0VnhrZjBFS0dIOUgySTBYMTVQ?=
 =?utf-8?B?eXJWNzc1NmdkUTA3aFgzT21nbHV5Q204eDJpaFFCYXpDZk5kNkQrM2t2WlY0?=
 =?utf-8?B?NHg5RU5XZDdxOFc4cmo5MXdwL21CaWJrOU9jUWxTUTdCbjdTRkdiQnFrOHNh?=
 =?utf-8?B?Z00wYjdpQTZVL1dEaS9JNURKeFkvb0RvK0ttdXZqWTZtTGd5RjZMdTJkVWtG?=
 =?utf-8?B?ejZualB6cmlpejRDRENheTVxM0pNTHp0M2prQzdrcGErYmR6WmlHTEEzc05K?=
 =?utf-8?B?bThyQnR2NHpNNGhHWGFJQlo3a3F2OTBnS3RNQUdSblZPQjhncmoxWHJGUFlI?=
 =?utf-8?B?anpPSTJTcnVHS25iVnVLRk9URFJaTUFid0w3WEtwbzB4Z0E4N2JzWUxmRnhO?=
 =?utf-8?B?Rnh1MTBPYUtxNXBqZDNmU1NRVm5LVE5WdVBjMXRCUXNCYlo0S0huSHVBbmt4?=
 =?utf-8?B?K2FnZkhpSXpMdTBtOWN6K2tDeEpVTUdRcmplczJMSjlGVVAyOGxIVko2YWRT?=
 =?utf-8?B?RVEwVGVFV1JkV2VDZnZpejhFeElubkFrMmN0ald4YmFVSU5ydXlDMFdleUtw?=
 =?utf-8?B?azhoTmJNdFFWbyswN0Eyc0tUd1ZSTXZyU2gxbjNRL1poQVp6eTR3VzFMRHlP?=
 =?utf-8?B?RTJhcUllOUhvUWUwdkxkUUNXSjJ0WWxodFhMU2tDdDgvQUZhSUJNdDUySEM2?=
 =?utf-8?B?UWFWYzNFODhGMU4xWGd5UGFseisyY0lYRXp3dnZCSG9LSVh4SkdhTk9LTFcx?=
 =?utf-8?B?QnpPNmY1Y3Fjb1JQTTNGZnB5K01VUkxaZnZ3YThSdFU2RVdVa0R3clcwemFK?=
 =?utf-8?B?K0ZwK2VOVTBnN1FHTEJvazBtK0pJRFMxMjh1cUtHd2RuOFptc29yN09DbzFQ?=
 =?utf-8?B?TVlLaUwvZVNoSTcwOFNSeVFlc1RJN2hmYno2aE40L0c0Yko5TXUya283emgz?=
 =?utf-8?B?b096THpYelEwdnR2dDUySDhYeUlwNzlOaVhDTmJ0YmcwNnBUeEdNRHBtSGdG?=
 =?utf-8?B?SGFmVmRPQUgyZGdqSUNrU1pSUEtSSVlZN3oyNXA1ODUyT1NpbjFRbUI0ZVFC?=
 =?utf-8?B?eVQ2dWpPNkFocm1BcldSZTNZSXJrRkVKNWxaeVdjREt3aUY4UXpTR2VEeC9j?=
 =?utf-8?B?WjNydjF3UmZCTFd0NUtyazMvck4reVc4YkttMDVvV3FYWHArTE04bkQ0QnJw?=
 =?utf-8?B?VFZpY2xNRk9YQ3VUQWZwNm0yaE15Ym9FbDVyMlFMeGZpYkNtMS9FdHZMWWdQ?=
 =?utf-8?B?TzZQQ2plOVJ5em1VdTBLaEZSVW92cmVNSm52Z0lvSzRabHVxZVZjOTQ1NzM1?=
 =?utf-8?B?UHd4dmxVQm5YcnpRR0lMZjQ3eVVtdUIzL3hqUG1qVHM3VWRzVG54Ym9ZSTBY?=
 =?utf-8?B?ZmowRUJDVHNoQWVpeUpPcHlQdFhYMEZvd1hzc3dINjZXdXJ5NEIxVGY4THpQ?=
 =?utf-8?B?N1p4U1EwVStYRVJlbXNNa0hEZXNwTHAydVNvaFkvTEhBZDZybUdDVmdDMXV6?=
 =?utf-8?B?WEUrNmtGUXJZYTdyVzFtK0w1R2p0alVvVG5uM1FyRXJLVUFuajlUbGJ4UDFy?=
 =?utf-8?B?ZTR5MzQxM3BXN2JXQTdYaERnOVNYM3FGdmVCSUZRdTJEWStmdUM1UHliYW1v?=
 =?utf-8?B?Zy80OEJzQkJwN1ZzRkZDdGJQeEJoYnJIWm9Jd1FhTU5hMllweEpxV0Q0UVdL?=
 =?utf-8?B?YUZRci9xNEI4bTFXZkV1Q09YQ3F3blVmRVBnZDJJR09pZEZENGg2K216WHE2?=
 =?utf-8?B?TnczdkYwQmZ4b0tpcXhFWmZ2SDFaZ0ZCQzlCbnFIYkFMeTNhMUU0eUVYOTlL?=
 =?utf-8?B?M1dBNUg3bmR6MHpPdW16dmxTR1dMLzd1V1JXMi9aaFFaUkF0UERWVzFEbzI5?=
 =?utf-8?Q?avu4uDjESO7UMt9B/ejUfZFg4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abcbfb2-990a-464a-eca1-08dbab397c6d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 22:19:19.3456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwWweHX6yC+mVI+z7sR4JXzM/weum5s059fadDPv0RnYlEn8pyrst0MWfZHfyAzva61QvuCkselxdDrlkMg9yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7182
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/2023 1:35 PM, Edgecombe, Rick P wrote:
> On Fri, 2023-09-01 at 12:33 -0700, Sohil Mehta wrote:

>> I am wondering why a definition for __NR_map_shadow_stack is
>> missing in include/uapi/asm-generic/unistd.h?
>> 
>> Wouldn't this mean that even if someone were to install the
>> headers they still wouldn't get the syscall number definition. Am I
>> missing something?
> 
> There is some autogeneration that happens from the .tbl files.

Hmm.. I wasn't aware of this auto-generation. The last few system calls
additions have all updated the unistd.h file manually to add the
__NR_foo defines. So I assumed that's what gets included in the header
packages and eventually gets used by userspace in some form. But maybe
x86 headers might be built differently. I need to educate myself on this.

> But maybe also this whole duplicate defines thing is questionable.
> 

Yeah, having 2 defines is a bit annoying but as mentioned in the link it
makes it easier for someone to run selftests so it's probably worth the
effort. Also since syscall numbers typically never change it is just a
one time thing and not a big maintenance burden :)

FWIW, I see these syscall nr defines all across the selftests (io_uring,
powerpc/pkeys, seccomp, etc).

> 
>>
>> Apart from this patch, I think we also need something like commit
>> 78252deb023c ("arch: Register fchmodat2, usually as syscall 452") to
>> reserve the 453 syscall number for the rest of the architectures.
>>
>> Should I send one out if you don't have something prepared already?
> 
> Originally there were no other shadow stack features, and so it was
> maybe going to be an x86-only syscall. I followed in the footsteps of 
> the secret mem syscall, but that one seems to have grown some similar
> reservation comments since then. It probably makes more sense for that
> one though, since it's sort of a generic functionality. An analogous
> x86 specific syscall would maybe be modify_ldt, which doesn't really
> have reservations.
> 
> But now we also have arm that plans to use it. So maybe it is worth
> trying to match syscall numbers? I could imagine scenarios where it
> could be useful. And I guess there is also the scenario where a generic
> type syscall is added, but only implemented on non-shadow stack
> architectures. So then when it makes it's way around, it can't match. I
> hadn't thought about it before, so just thinking it through...
> 

My suggestion is originating from the belief that at somepoint the
community decided that all *new* system call numbers would be the
consistent across architectures (except alpha). So that would mean
syscall number 453 has to be reserved on others even if it is an
x86-only syscall.

If we don't do this, and let say a generic sys_foo comes along which
uses the next available syscall number 453 on other archs, it would lead
to an inconsistency because 453 it is already used up on x86.

My memory of this is a bit hazy from my implementation of User
Interrupts more than a couple of years back. Also, I couldn't find any
handy documentation to support my belief. I'll try to dig more.

Sohil

