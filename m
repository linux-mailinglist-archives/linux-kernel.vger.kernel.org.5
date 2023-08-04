Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5CD770741
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjHDRf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjHDRfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:35:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D5C4EDA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691170523; x=1722706523;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/uZ89Tm2pcJTvf82DkqKJVHi0tE0E6MJFP5FJFfukpc=;
  b=g8LTmPnLWaX3jys7qPktrxbWpCzPc41vi5AUIoqn1tyi9BIaAEIlbmSn
   2hht2pB+DJX7jKMEw5c9YGL90OOjnHuRzMNeWXZ2uq0I56FdXVSg6OVji
   HU+lVoQ31/PAjtw0t7vz+P17+Q/6R/XDnTiFLIwjsVT6Zkr6qeLv0vYg2
   /BfTMgz3lNff6E9KbE2W4/VJdfW8rXRUKnLpknSJRjTlwq+tkwYdgnknj
   1y1CF3ZDx6vX9Wx1sdxssjJ7P3l5V/YIHfF0WdfWmS2WsXhoHvzVo1Nhm
   tyIAo4Cetw5wMBPbUmPf44ODIRxc3njJWFgFGQmQ3OTJNLZ4VZBgPc2W/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="372950496"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="372950496"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 10:35:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="800140755"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="800140755"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 04 Aug 2023 10:35:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 10:35:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 10:35:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 10:35:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMcz8Um5w3krvSYNtfw/RXzY59g7nTdCVvQxy0+0Zsys0Y7kjmgQs746LsZFpDM9kz56YeC79neKxUQkTbYNck2WFipGZhLaOKgieaR2FEFIho6fhPA3TZBUWI3shtzAMUW2XqKfqCEuW3PEDe7en4LB9mYyKkawi7HSwkM2l3sscB4dN3IuW2yt71UGw3ZR119UUjJm1iEoLXi3PVozqgGltP8NUn7WT70W/QwZTvPL+b7qImomrkfBH8AOseee2DdQDESE7kNxZam7fJH7j96mMB6ibEgSGqqdW7KVHEiv8Mezl5WA3B3Q0E3I+41RjMMIgy5Zckrddrzy25UJow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ubv7enYxLzTXmgjsMDcuRLrQdCBhlZzE3KL1OOJZcw4=;
 b=G6e0aL1DtQHWOvwCJIeyi24pDTCd/GTFDlsjYvKtlTlzIl4bZPR2fVht/umQtvwWAVcBv2DeYJvreuQcRMK9OKXhinnxJzLzffLPzdoJz9SDyrqzOJjBIy4Rk5s/+ui419DXDNmMiuwlmYJV3nPOlNk19wWhv0/d2rDYy/PIn3/C+yzekTWgJVcSf8JxwZJv/3TOld4AgizgGUAM31XhPSF5WnWL8k6bf7nYuetKm1zAQaVRG2cbI/8+vBlycZjKUNFHTT9xcmqqpmN2HXXkERZLcQY+eyVT9+P/vho0PR6ZCFMxREBQ5plmGw/0n2q2T3WH53lXghLzhgUAeUZdYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by SA1PR11MB6943.namprd11.prod.outlook.com (2603:10b6:806:2bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 17:35:11 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::50e4:2cb8:4529:af04]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::50e4:2cb8:4529:af04%7]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 17:35:11 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Gross, Jurgen" <jgross@suse.com>,
        "Ostrovsky, Boris" <boris.ostrovsky@oracle.com>
Subject: RE: [RFC PATCH 1/1] x86/traps: Get rid of exception handlers' second
 argument error code
Thread-Topic: [RFC PATCH 1/1] x86/traps: Get rid of exception handlers' second
 argument error code
Thread-Index: AQHZxq1luoPee3LE20qWOZPEmJublq/Z6zyAgAB3ZVA=
Date:   Fri, 4 Aug 2023 17:35:11 +0000
Message-ID: <SA1PR11MB67349385C20E8D3B0C960432A809A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230804075734.8372-1-xin3.li@intel.com>
 <20230804101321.GH214207@hirez.programming.kicks-ass.net>
In-Reply-To: <20230804101321.GH214207@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|SA1PR11MB6943:EE_
x-ms-office365-filtering-correlation-id: 96d1cd66-62fc-4813-6e5f-08db9511277a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wNvIdG/iB7rV7TsItBndME52X3qHqS7HXIsSX5JEaOQrgBTJF4cRNguoXrguNm4PnRwapGVsDBANf04K5wSj5Tw0MgV9bRwoJ6gbkaGYxGHbeg6Uxw2OAmz5bHJ6aSCFaTDKqZPy90QC/CzRjP7kEDu/g5QBeX16qUuH1zhL6HG2VSuk4P/sbE9WPcLJLiNpXJshiGrDIrmZRMrxfKt4867gRmNtv8JWSnToMG74cs8vPO+eDLtoKR0NVRLrIhc/17MX6ZDd9PLqz0F8OCf47nlSC8EuujG/TneEdfSoPE6OfvuTE2FixNeaYzPt06oU6JrjiUff6HdUKkk4p0klr1XGhaeJhUoyFajuJf6tJjh27GXY44faEMaO4Ctfaq1hytjBSHUVnK7zKlcnZ0HPI3e7YLb2KJQoMHB1PNDNtojbiMquJ8Fi/431rE2qoxXuMER0D8/u2HbJlJJk7O0fv6XoLsH2TrbtgdT3QCgvIidJszcQvKW70ETQ+4I+9KQFkOv+Op5xKzB9Uvil4t5+PJX/iBw8UWR+3SyasX9GqfFxTNcRgnwgiknWE/fftWCDEP2Q20GMn6XGLssXIibDbwvJGpgAmhHYqOSqjAMgQLIQioLeXdudQdpSDuPud9XzUnHIde2saWmFaAnwnzuv5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199021)(1800799003)(186006)(6506007)(26005)(8936002)(41300700001)(6916009)(2906002)(76116006)(5660300002)(66946007)(66446008)(66556008)(66476007)(4326008)(316002)(52536014)(64756008)(8676002)(7696005)(71200400001)(7416002)(9686003)(478600001)(54906003)(122000001)(38100700002)(55016003)(82960400001)(33656002)(86362001)(38070700005)(26583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KwPsvvqJE/yjGL6oYxYxvYK70dJM3vfF8TS5+yo5alHwMpsJvX3iAbYXzFwU?=
 =?us-ascii?Q?KdMJoNOydubX3XPBVStaT6vZ20EVa6efvDQoId9fzc6NQEzeHfoKS2YtbiWc?=
 =?us-ascii?Q?YgZRmxwmE1+uZDfRbpPt5x4rPA9Feg/3EdmYxQgklulCP7AtUQDwz904Hwe1?=
 =?us-ascii?Q?kMiuRr1uA/lY4BJIZ700UnhKcSjzwh85NV2VOok3+kPsuF1514pystHUXa3Y?=
 =?us-ascii?Q?+t3ZT4Q80pogDSxQRcZx3CuvpRGxgTltmVCWYuVHEbdgqYnta+vrMLfSZLXF?=
 =?us-ascii?Q?pKUtCpQS+r3YjCuFlB2fV0eeD4rgB9dGJyLvkhK+D69bDInqSSStjNKBv+cz?=
 =?us-ascii?Q?b12Lgu7b0JhtTGzeceN0DBdpjabtLlSEkGQ/RiuE+Ofi56n6IXoXAr57vsuv?=
 =?us-ascii?Q?ax0BbyQINygOvPgmBPJ3L7jBStMg13Ej1g+K7YaX1/+xhCmiOAVRSPjZFnW0?=
 =?us-ascii?Q?DHzFOge3mXfhFUt3dYuBrqLAlqJqP/rKj1UZyFY1P7ED+SLL4wfo8oa1tqV2?=
 =?us-ascii?Q?sqBUyb6+w5o1RdCVDs6XLwoSFT932lY+WEa5AjaXLu7akUtK7xVRFuVMyu3F?=
 =?us-ascii?Q?KTRbIM0tFgKrd+ru2kXchCdgN/g5LOv8teTX2eCv6iRerKIZ0qYraqipAKBd?=
 =?us-ascii?Q?nSrb6igptDquMnG7ZgIsJWxbmc8kkBjVP9ruLzl9QcHgJlm37iwN5ANB6eeo?=
 =?us-ascii?Q?5mbjnvbxDd9U610gy0VO2Iq/944NbEyBemYUcCc785yVXFMh0G8knMvA5XZa?=
 =?us-ascii?Q?aG1bcfNEfnDUhcZiIsBaOMnX+kWMGx+0Eq0GoOqySj4WKERlNOa3ODMRueyS?=
 =?us-ascii?Q?lUbwcAAqNGDyw1ixi8p4Zv14myjmaU8XjQbw8snmYRvbo6WVkMsU+zxTawsP?=
 =?us-ascii?Q?cY/z2l5v+XilTNqtoP7mIlaF/xiYEdCZ+4THmIAtLBUJ6f89h+w41/WbLEyF?=
 =?us-ascii?Q?KE/1GXRGKQkBvIysQnd+RcAjr1MxKFd17T5VJn9G8tjo4N704fhXzE+hOGiu?=
 =?us-ascii?Q?h0ZTEpRVyXFOq78NtNPh1cm+y/N3QqS0SYL1R5aNTf2Wz/krGo6WjF11wQxH?=
 =?us-ascii?Q?TBreVpN/+rIGYx8q+szEcQyvnwqebHh6v6qL2EjAc4bDZkmZvI8Kfa64MTVM?=
 =?us-ascii?Q?d6WUheRxjojHbawJH65JI5jxssOwze+CUtJCzuCsO9A5bmvMHVSzI1oSRmcs?=
 =?us-ascii?Q?g/UjtDlSelRpAik5oNxBEDlriWkEqs2LwjDMjAfWyo5+UOQdxA/rX7eun0mh?=
 =?us-ascii?Q?1+0TLRRviPpTFI/dBW9Fzd5yuHza3MIDmQ/jZyvffkiW5fLUJhdxm8ny11lZ?=
 =?us-ascii?Q?1mrvhCXYfZmzg0bTFS9PVozEdNouhZtsKRIM2ovmTaz3GMa0UPjwWXnkw8M+?=
 =?us-ascii?Q?+HcGj6xmewbzU2mAu9c10rh+HMk1qqmMQjkgjgjqC/+kp//KljijDwVkJcoG?=
 =?us-ascii?Q?yruB3BD0L1qkW3czcvQDYCAVieaEnM8IMPuF40ZebchvUa8Czf5AZpKOqqI7?=
 =?us-ascii?Q?OWQxGP7ON55TL8lqqj+HFX3KjclH/8TPpzmD6HfvohZlNGNPHp5ljDS5yCiQ?=
 =?us-ascii?Q?2zOnEUQ8mUGctXD97cI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d1cd66-62fc-4813-6e5f-08db9511277a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 17:35:11.1752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EMTATcikUJ4zLGXp5lfiDx8Lqihoa+4aJ7DHvW+i/k+1tnu+vLhDiUaksF813HXxXNEHGXLFUH6eZgAcKtQv+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6943
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > The IDT event delivery of X86_TRAP_DF, X86_TRAP_TS, X86_TRAP_NP,
> > X86_TRAP_SS, X86_TRAP_GP, X86_TRAP_AC and X86_TRAP_CP pushes an error
> > code into the orig_ax member of the pt_regs structure, and the error
> > code is passed as the second argument of their C-handlers, although
> > the pt_regs structure is already passed as the first argument.
> >
> > The asm entry code of such faults does the following
> >
> >   movq ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
> >   movq $-1, ORIG_RAX(%rsp)	/* no syscall to restart */
> >
> > to set the orig_ax member to -1 just before calling the C-handler.
> >
> > In addition, the IRQ entry code uses the second error code argument as
> > its IRQ vector, as the IRQ asm entry code pushes its IRQ vector into
> > the orig_ax member.
> >
> > The commit d99015b1abbad ("x86: move entry_64.S register saving out of
> > the macros") introduced the changes to set orig_ax to -1, but I can't
> > see why it's required. Our tests on x86_64 and x86_32 seem fine if
> > orig_ax is left unchanged instead of set to -1.
>=20
> That means that SYSCALL_NUM(regs) get to be garbage; or something like th=
at.

I find SYSCALL_NUM(regs) in tools/testing/selftests/seccomp/seccomp_bpf.c,
but nothing obvious to me.

I think it's clear that once exceptions and IRQs are handled, the original
context will be fully recovered in a normal case.

Is it related to preemption after such a event?

I must have missed something; can you please elaborate it?
