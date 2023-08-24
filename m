Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E887864F9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 03:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbjHXB5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 21:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbjHXB5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 21:57:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DD912C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 18:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692842229; x=1724378229;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ct5HmS0KR+NeiHhUzCbpgWSyQmGFm6YrQYEti4Vj1ng=;
  b=Gyx+mQCooRNmkPg5dwFwqtvJ0mK/3ncL4+sKsnsxotO2Vasz+SgmomVZ
   u5W/YqXMUKOGbBHC/1/Jg+Gk0pN2NA6uOoxMMWj1//HZF6QgHM1ZgqkzK
   ITRtZ7dRH0HuMXTknljwGbnqOMNs3r+DFu8NzyWi9neyAeY8E86z4d9Fg
   8IBVCwliCyKrCqaSzYl4A3NJlaxQpZxOEKyvWsyAAfSVXNNyeVrH3FxL/
   vUwCBPBntj8psZCDkvM0NN5CzuPjXC7BzSfDlGLiHbX6IbEv7cb3w8KA2
   YjapcR0AgLtEQxCgNVnfZgTyd2+2PXHlAFt3Sb2FsgIoPskFAcvTKMGi9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="354651653"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="354651653"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 18:57:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="1067650700"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="1067650700"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 23 Aug 2023 18:57:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 18:57:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 18:57:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 18:56:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOufGpJVwzLXCbHxOVmUPBwi4hXwTkXvqlJq77/qXo6fDZu8lwq5LwvfImzJSDmM7njtJXYpjg2ascw6EKB88w073Just8cXSTXtn8IDmsjOPgntF9IJ5Oe12Np/7TdXV6d1XKIcdrw2AYpu7R4MjPbC/e0Da0JMuBxzL8/0D6jbvUoGL34nqpn+RWlywfFOYaTSwHonDwMLl2P2aKBUVLQonym4o9jipAkHAnsVxVcicUYJVKxu0amBYRogm/lVY9bIl8nSP/TsySOjih5wJU4eGjcSn42r9VccfigAQxzYqDyyBb/uOVun5myp5+b4iTIiIRd7QnH5uorrx8NAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6BEvqCaU8acrA22tkjPHlY1keJJAnwqOU9OdAm3yEw=;
 b=nNCDnGBvk7KGi1+O1L3blp9doNXWbt5HUqBkGYlw+qzv3xH/xRLQqjpUsiEKrVMfFJR3yop54+Tx4UMrXDa+QUwCpc7QGoJ4Ek5vSEP0x/FEp1jALP5W43PamJbJkXxWcY/stxB7K7EEmtPYTMuIzs32K5nSPq1EtXomh5OWp6LPb3yXdJYAS3lM7y9/E8HMfuGzAxWmaDtPymc+xA3gWu7FY0UTAVFRJd4cRLQ/j9y3pumsk6P73IZA9GVyhbvG3CbReqSeYFLIWS45Baj7ZOlzbQO7tIX8wLo2nCnerNPGMkdCggMzH+Be9q3xQienyuz2ywtE8TzgSxuC1/HoqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CH3PR11MB8589.namprd11.prod.outlook.com (2603:10b6:610:1ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 01:56:38 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::57e7:80ff:c440:c53a]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::57e7:80ff:c440:c53a%5]) with mapi id 15.20.6699.022; Thu, 24 Aug 2023
 01:56:38 +0000
Date:   Thu, 24 Aug 2023 09:46:58 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/fpu: set X86_FEATURE_OSXSAVE feature after enabling
 OSXSAVE in CR4
Message-ID: <ZOa2ko7QsztEC9lg@feng-clx>
References: <20230823065747.92257-1-feng.tang@intel.com>
 <4cb8d8ab43723e66134626eb0b4fc5fca2371305.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cb8d8ab43723e66134626eb0b4fc5fca2371305.camel@intel.com>
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CH3PR11MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: 8223c489-0a03-4c42-f2f4-08dba4455a6f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZyYME+P2nr4J9Djv95JWK5aJqIE25lKgQmmDaw0OFnbv4pZ/CuFOkcUYbk2pJhrmw+OYm1i3o12Z69+8B/JJEIjpMjZyzUV05LsEZaDJoAnu4f48j7xSE7f8z8f0VQ3ggnl9FSuKjSHNDQLZWG7wPp6aAA7M6EZTxzJepuQAdBhwE/8J1MnUHVV1Mwr081BxbOXqR/J+tkTj3yxasA2DcaD1lnBj74Pf9BlMNI+y1r0KOprOws5jMNJRpQiKFch8CpbXs4nDoD5r8WHImuIbkcAG0216QmdP56h02UsoPb+5Q0YFr3bto52XAq+gUSe1MbIUnIdDUyTyiQsmWqgh3G2cXUWaIbRzA0fUcr4jL3QPqkYFXd06ST5ODL8obapu8i/CSBULqXBTQ1UlVYCX7xXf7Ps4/D/p871cgD6ULWt1aiGTyfUnGy+Oe13+2R4ZT7zqbZhLX8qs2OHtXWysrH2lvxazIqTopvmK6A3lDp7RmKxnRKhnqjqpBz+Mxe1C4VHmkaSPxCV08AlrHB1QP+6FYnW6yZNT+LrKpzpSEuo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199024)(1800799009)(186009)(2906002)(38100700002)(6486002)(83380400001)(44832011)(5660300002)(86362001)(26005)(6636002)(6862004)(8936002)(4326008)(66946007)(66476007)(66556008)(54906003)(9686003)(6506007)(6512007)(82960400001)(316002)(478600001)(8676002)(41300700001)(33716001)(966005)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejY3Z3FiN2xIaWZxaXh1dmIxTnkrNGdpcWFWaGpsVi8rakZmUXkwSVZZVDBr?=
 =?utf-8?B?L0lPTnNvWEx1V2NwbDNlcU83TEcvbEFzdkx4YkZzaXg3OGZOdGlHOU13SnFa?=
 =?utf-8?B?NXpYWHk2Zng2UHlZWVRSTWNWV3R1NzFRSWVTYk1meWFiVWtPUkE0aG5CMFV5?=
 =?utf-8?B?UFV6S2lKaVNhYmhkRmc0TklMeURMd2l4L2s4ZDJDZEZOSm9PSFc5ZllwYlE1?=
 =?utf-8?B?Rk1qREZHNVVYRmJDNmxJKzhGbXozaitKdk5LTmVtWjZIU1N5UWZDeTRvc0ZB?=
 =?utf-8?B?SlozeEp0emdFQXpHYzF2cHVEc1pudkg2TzdTNlRvVFpwcDVvcytZSGJVV0wy?=
 =?utf-8?B?SGtXQW4yY3dlb1Nka25TNXE4VHJHT1RzOGFRZ2Q3UVh4Y2xmTS9nRDU1b25o?=
 =?utf-8?B?b3dEN0lSL1hlcUhBYysxaDFabFBYVGYvOFhCalRGaW1TWml1WG92OTN2NzlZ?=
 =?utf-8?B?T0ZsdjYyTHd2T3ZDYkdhS1kzVUVqL0lIcDlJUE9NT2NYczVrQVBwNnRQMmxj?=
 =?utf-8?B?WjZhRVc0THFuUnh1dTk2dFE4Nk40UEhPcnZQcGFuVGdxSmxlTWdUUGdEY3B5?=
 =?utf-8?B?TzMrSHJ0ak5EYzRDRWlwTnV6UHNRTHNCUDJ1eFo0K2Nkc0pkNU01TThvaHJB?=
 =?utf-8?B?Z1VBdFJ5bk96bDlWWWxEUURCbDgrYnlHanpMc1Ixdnp4SVFGYUlPTHF3UmFU?=
 =?utf-8?B?WnJBNnpvc0lUbUtpNnpsamg4Y1Fxb1JoYTh2ZFFjb1VZOCthTEEycGJWQXp1?=
 =?utf-8?B?Q0dUanRDQ2YvS2xDdlU2QkU0MVV6VTJNbnFCN2Z5T2NOTkp5QlY0VDVVeEg4?=
 =?utf-8?B?eUt1eUpOTmhJQ1hZK0sxK2F1cjBuU05wWmVCMCszbkZiWnFyK3A5YXJVNU9I?=
 =?utf-8?B?Wld1RC9NUXFxRXhnWGZKTEN6MHNidHRheCtiOGh3YW1mT2lxRVBFaklxeEhF?=
 =?utf-8?B?KzhhaGZ1SDczOGIrK2JGTmNFaWJxYWhQSWNxZXJma2wwRkhVZytiOUNETGpl?=
 =?utf-8?B?bTdjM3g5eVMxTHg3SWNPSGVlMlR5dm5vc21yczY5MG4yQkg0M05iK2xwM0hJ?=
 =?utf-8?B?SGMweEx1U1Y0SndzVWZxK1BPbCtiRzg1cTFLTy9rbFJNS3FHOFZrOE9oWkNr?=
 =?utf-8?B?NVlFN2RrbFltTEkyRGZVZWxzMXhpWEdSNHp4SGFTQmxEcWNUZ2RBcUdJOW5j?=
 =?utf-8?B?UXQ4eExyeDdiamUxTWxIcllRbWZzMXJFZ2plRXJmRWF0YzdXVDJXbFhBaG9U?=
 =?utf-8?B?cjE4aGthV3poRksxRitDN1lZTUpIMHE5RDR6eTNJMFR5Ujk5bmk3bmpwdDd3?=
 =?utf-8?B?bkc4RmhNc0kxdU9YQXFxQ1M4NDQ2Nllmckt1WC83LzZkK0dDaExTclBWZzMr?=
 =?utf-8?B?a1Z1eE8xN1R4aGpJVmxiUEpjR2pNdjd1aUlzMStQVFVtT2pNaGFtSWZXQWtF?=
 =?utf-8?B?eEJnT1NjYXFpOEFTMDlQYnNKYldCQU5ueVZvV1JmK0w4ZWJHWXhTd0wzVkpO?=
 =?utf-8?B?dzA2MjNHdmVDK1grQXAxZ29wM0RtSnlIV1Vsem9hTUFOaXpRMTd5bkUybE1t?=
 =?utf-8?B?eGsrRyt4ZEFUSEVadkF1N0p4eHJUTzFXUW96TnZHYyszYk9PdTU2YW0rT2JW?=
 =?utf-8?B?ZTdkRzdXWXlLSGJlOE4ySGgwdGdlQ09EbEVJNjlZeFBmM00wSUhWZ2hSdm1i?=
 =?utf-8?B?Sk5vd3JxQ0RLa0R5SHM0SUFYOU9uWjhTSUR0eVpMMXdOd2J1M205ZlBUWVB2?=
 =?utf-8?B?TjdCejVVc3lGN3Q1V1VZTytEUkEvc2xaSVZlZVI2S3FKYWZIbjNobjVxVjB5?=
 =?utf-8?B?UFZGejk4YWtjc05DSnBMaXo4MExQMVJiNWpYRmZLQVBDMGUwdXVKemdxU3Bl?=
 =?utf-8?B?WTBSOHI5QlBsbW9rODRaWTVXdGxob2ZFYTM5YkhieVBHVEI1Qndva1ltc2RO?=
 =?utf-8?B?VkVqN0FZOXBmR3Q2TXVKR0RVcldBNTNpQ09jaitTVUFtWDBhYzAvRjYwbThV?=
 =?utf-8?B?Q3p0UWQyK1FjUCt0cVdzK1crbjZvRkROV0VXZitwN0tDYVJVaWFjdzdzR1Fq?=
 =?utf-8?B?ZU5UNHRiZzduaXVUckRwYkVGT1pLdWs4emYvMStIdVJiZ25xMlF6V1pyMVo1?=
 =?utf-8?Q?xOC7+FB2hSjIIxesohSh9eI8G?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8223c489-0a03-4c42-f2f4-08dba4455a6f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 01:56:38.2302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3p2FcVEBKHA5UICbNYrWOEn+L9NhV8QPSUmQR3BX3+li1tdAMiXyVOQbzCTlomzTXGJ9vImD2ip82HsWtmghw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8589
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rick,

Thanks for the review!

On Thu, Aug 24, 2023 at 06:16:55AM +0800, Edgecombe, Rick P wrote:
> On Wed, 2023-08-23 at 14:57 +0800, Feng Tang wrote:
> > 0Day found a 34.6% regression in stress-ng's 'af-alg' test case [1],
> > and
> > bisected it to commit b81fac906a8f ("x86/fpu: Move FPU initialization
> > into arch_cpu_finalize_init()"), which optimizes the FPU init order,
> > and moves the CR4_OSXSAVE enabling into a later place:
> > 
> >    arch_cpu_finalize_init
> >        identify_boot_cpu
> >            identify_cpu
> >                generic_identify
> >                    get_cpu_cap --> setup cpu capability
> >        ...
> >        fpu__init_cpu
> >            fpu__init_cpu_xstate
> >                cr4_set_bits(X86_CR4_OSXSAVE);
> > 
> > And it makes 'X86_FEATURE_OSXSAVE' feature bit missed in cpu
> > capability
> > setup. Many security module like 'camellia_aesni_avx_x86_64' depends
> > on
> > this feature, and will fail to be loaded after the commit, causing
> > the
> > regression.
> > 
> > So set X86_FEATURE_OSXSAVE feature right after OSXSAVE enabling to
> > fix it.
> 
> Oh, that's unfortunate.
> 
> It might help to include a bit more about the problem in the log. The
> piece that confused me at first was that X86_FEATURE_OSXSAVE maps to a
> CPUID bit that will change once CR4.OSXSAVE is set. So since the CPUID
> bits are read before CR4.OSXSAVE is set, it stores the original unset
> value of the bit.
 
Good point. It's also my first time to know that this cpuid bit could
change with CR4 runtime setting.

> > 
> > [1].
> > https://lore.kernel.org/lkml/202307192135.203ac24e-oliver.sang@intel.com/
> > 
> > Fixes: b81fac906a8f ("x86/fpu: Move FPU initialization into
> > arch_cpu_finalize_init()")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  arch/x86/kernel/fpu/xstate.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/fpu/xstate.c
> > b/arch/x86/kernel/fpu/xstate.c
> > index 0bab497c9436..8ebea0d522d2 100644
> > --- a/arch/x86/kernel/fpu/xstate.c
> > +++ b/arch/x86/kernel/fpu/xstate.c
> > @@ -173,6 +173,9 @@ void fpu__init_cpu_xstate(void)
> >  
> >         cr4_set_bits(X86_CR4_OSXSAVE);
> >  
> > +       if (!boot_cpu_has(X86_FEATURE_OSXSAVE))
> > +               setup_force_cpu_cap(X86_FEATURE_OSXSAVE);
> > +
> 
> I'd also put a comment here to explain why this is done manually. I'll
> toss something out in case it's useful:
> 	/*
> 	 * CPUID bit for X86_FEATURE_OSXSAVE value will change once 
> 	 * CR4.OSXSAVE is set, so update it manually.
> 	 */

Will add. thanks!

- Feng

