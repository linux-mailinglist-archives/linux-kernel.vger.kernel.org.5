Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A1C798128
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 06:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbjIHEP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 00:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjIHEP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 00:15:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D0A1BD5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 21:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694146521; x=1725682521;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=3+ryky8XXp9BdW0HqiBJHJH3sD7W4h1y5v1WLdCN140=;
  b=XOwDHnHARIuRPyw3/+VZn9X3TYgumNLK1M1JXoqUNcNT+w8jcSfqjxtc
   P6tynUoZW38Sfg8cIdKUr10zw8arSqqAmTKlfBxhYm9T5VKeveuAk4iFg
   UZkWP9InSbk79RF8SW+/TcVOgPOcf9IJqJLf6+oJ6h6XGg5pt1oXn2/cT
   E2JkKBtgAdiG7HTI2salB6uUMv+3fSHDFavW+XE0JSmpiwPrNOVnKhR2h
   dAtuzgO7/1WC7v7mbYLcQec6LjDxppEzSQpVCLB1H1a8WpyrWCaitRomU
   7u1i14iRsD5PEPvNwWJ6BFbPSj4nrkzP5V4AMXAqN3JttqDJ3EMUKdVxA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="381364869"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="381364869"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 21:10:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="865924979"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="865924979"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Sep 2023 21:10:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 21:10:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 21:10:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 21:10:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 7 Sep 2023 21:10:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gc13y9My8gpHy028BtXWidfipsVlkMHM2MhA0pMbvA+8U4PguoTnT+nDji6qTgh5CWZ0DBbZdxosueW3hp+BU00tm0ohnLWL/DjQ5n8U3MKgdZ46PuT2m3WLYR+AY+AbVdt/Ml3F7ubuXxBSs2ywxuQxgOxpbZAKZXKIB4uY1Jdscm5WpEDsqfjesly60J0yAzbgr++ymkbpWnxetnmVl7j5Sdj9+DAId/HeHJQ0P4+NxgAauqtInPGG/cWx4GO751/aA25cF2ztB7PsikVsIvYTVYFMwZQpq543CYDaHQ0F4NZDSzCaNJxy+3VTuD95zOPyqnvbsIRkCyUkL4Gacw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOL3NHSgvBVhYVL72qwU95+1BfXXYVowytgONoSzgAw=;
 b=IgxGWCaYV0wUf3AJk+Yq46/bFR8HVW8kcpIJANTmi5ODlmAZySnbFbSG1uqpRBlNwHpN+Y1W237OXwFgIoKpoVFQ3CCLdSPfFYXuT2CFzI/u72hV9TZxgKtwf7kA4MjWVPSMW3cW8vI8tzNzd/YDkEyfBzDRyTHbepT5YU8MWXHM2pp0r85TKIYksgpaNm/nmHb7zgW8waE0jTgHItzxo4o0iNphJgECG55YWEdUKIcT56HqErq1arQ++L1siXaaxg2xqhsAKpy0tHVVT5QrhssLIXtgmGeLu2AMVjAYNzTmIsjNEqCzshuv2phv5V6ILDX2lIOkaO0c6ylFBVd8CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN0PR11MB5694.namprd11.prod.outlook.com (2603:10b6:408:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Fri, 8 Sep
 2023 04:10:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 04:10:07 +0000
Date:   Thu, 7 Sep 2023 21:10:03 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Erdem Aktas <erdemaktas@google.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Tony Luck" <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        <linux-coco@lists.linux.dev>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] virt: tdx-guest: Add Quote generation support using
 TSM_REPORTS
Message-ID: <64fa9e9bcb164_68a129421@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20230907025405.2310931-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAAYXXYzWMaruiTm84d=djM1Jekk-Ua9cEEZWWuZ-mh6knsCvTg@mail.gmail.com>
 <57469499-b150-4132-bd26-9a66991c9ce3@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57469499-b150-4132-bd26-9a66991c9ce3@linux.intel.com>
X-ClientProxiedBy: MW3PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:303:2b::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN0PR11MB5694:EE_
X-MS-Office365-Filtering-Correlation-Id: 822bf6c6-4b76-41e0-0ac4-08dbb0217c53
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Jnqckgp5K6Mlks+2Vd//yNCmYyNs0PMU7BL0H0WooJaTP8eJ0Zyn3ANkOR89+bnWQ1gwpQdNJcQxOztQyi6FNAEfDE618+F4uQIx+rM13McDmMJGHGJb2SsFBhsgUNEaaIGT0lcS1l+dhAOy38RR+LU09argidswHtErGlHAbsgUfVTP1+w5sbEud71klvyCa9wY247PAgm8uLfDzPAmmHkU8oYmXFF/Pm46ygrkIp0GilOFUEHBNdAIv1bt+pLEYpvpFoWl46bXeR9nXHcnODri+X6CocrNUvEWg0ZwX2vls0fu4nZNE7bAyvi75GTPnslIP3qjsaMfkNR5vSqvUGzzLpIQUK/GbwCJIvnODGVGe9L2AwXDFi2cf8DBla9bVnMsIC7DddNPfgRAV9H7qg8Nyu5Z0HLfdWUZhyC6uWRp/ZNPHA54kwvocuXpc/1M1lxvay/NX9Yk4mmq2R36enDwB1TofLpQgGEd15LDB0Or/eBUNuHXY5mYHOgNDUtmwRsCIq/blbnT/WwP9eIntw8oQBzmMpGWkuLQOAqJRbrYZ2K1L/B/eRUnjwCG3kpuhjWAMZkN7iwKJx1G8Z9LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199024)(186009)(1800799009)(6512007)(53546011)(6666004)(6486002)(6506007)(9686003)(26005)(82960400001)(38100700002)(7416002)(4326008)(5660300002)(8676002)(8936002)(86362001)(2906002)(30864003)(41300700001)(316002)(54906003)(66476007)(66556008)(66946007)(110136005)(966005)(478600001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVgzanpmcTF2azNpREVaLzhaK3BRRUs4WDlDZkNPMmk0Zy9LdGZSMGt3ZnNL?=
 =?utf-8?B?ZnZLYk83UGRsTXlUUXVwUW5XQjU5QnpjNlVzR2ExZ3loZ1gvaG5jdGo5b3Qr?=
 =?utf-8?B?Z1ViOTdFRDZuTHVKLzNoMFBDVGVOaERsRnNhYWI4MkJEVU5VNmxibklqM1hL?=
 =?utf-8?B?bHdQM2ZCb2NjeFZwR0Jib0x3UGdWRmJwakNudGZiK3RzRUQ4TWMvWlBhaVhS?=
 =?utf-8?B?T1pyT3JyanRHRkp1Qk4vYmRDaVZoNVhkUVc2dlVrZ3FtNitscHJ5YlFQNUJJ?=
 =?utf-8?B?ak15aFlsL2N5d3hwZWU0NEJjMVhsWjBWMXJZbWxDNWtmSm5GQnpDenhnWmVV?=
 =?utf-8?B?QWRrbVN5QStGV0pPMWFhZ1ZqdDgwemgxa0k0U3RFSFhjNThqSXBtSGNUVkly?=
 =?utf-8?B?dm50ZXpMQ2JCZSt5aGZrOXlvZG1tR2diYlZDRzRXUWUzd1NJSklVQVJDOFVO?=
 =?utf-8?B?T3I2b2E4RC9NVGdvZSt5aG43dTVwTVlxWTU1N1lmL2hPS0ZGRG4vSVhKSUtL?=
 =?utf-8?B?UGRQdHFuN3BSNXNSYjJibmpjRzBUTHlnTFBHVUprUmpQNm5NeTB0Rzk4UUZL?=
 =?utf-8?B?VTZwTHB0WmNHWGdMT0U3ZWRUZDZsTWJFMG94STRHRUg2SjRTU1paWDRNMG9J?=
 =?utf-8?B?L2dxb1BjWWVqd0p0SEhkbEcrZjh2VVVMRzV5czd6REFnQmpMenhzUlVxTDZB?=
 =?utf-8?B?YVQ5N1JQZHR1cjZ0SEdxWVcrVU44aCsrTnNtbTBNSmVmazNsN214QU9heUE2?=
 =?utf-8?B?TXVuOXY5aEZvMXhJdEVsS3MwUll1MlNNMVpaNjMvdXY2T2NKcHN5Zkx2cnF6?=
 =?utf-8?B?SytLT2ZObmJZejlickNBUkdZSkdYKzVObTgzNm12RjBpN3oxZFhESWcxRHRU?=
 =?utf-8?B?ZDJiSlMrZ3VXZGlZZkJRbU5MVm5WSkR0SlA5ZmwxKzVqKzk0cFY3KzNCQWNt?=
 =?utf-8?B?L3BtOVl6OFBmbDMyaldPalVWUng4MHhuRVRCMVRoUStLTTUvdFBmVERqTmc4?=
 =?utf-8?B?OStaaDRrbjFJMzRsbVZScVBzZlMyU3NJODF5S1NWTStXVzUrMnlnelFRMEd6?=
 =?utf-8?B?VUsrOFI1a0xNVW1aZkpDNFJhQnNEZHM4R0RlRUVkOFQ3Nk5oeGJOTFc4U2Z3?=
 =?utf-8?B?MVdTWWd0ODNHSm5WTDJyZ3Exc2FSbTU5OHFEWFlQOEJrMWZ1TEZZUVNNSURr?=
 =?utf-8?B?QXpudGNERWdYS2g0QVFlR2VNMU9VNU5tQWhPaWdOTDlVWTR1MGIxOHNhcFZw?=
 =?utf-8?B?WHJUdGJlMFZoUjEyNnZENEFCcW0yV1NJa3k3NlZTZDNaWjhTcmpCckNhUldJ?=
 =?utf-8?B?VjNGVFhVVHdOK0pVMzRyQkJqWVBQdVlabXlMZ2t4YTRCWllydlV1L3V5SE14?=
 =?utf-8?B?bkp6eVdyMzBDY2NHQkR5T2pQdDdEM0NWQU15YXBPZFR2VEE3NkFBQVZEZWtv?=
 =?utf-8?B?M24rbCszS29NT3kyeFg5SnYvME1CRGJuMFFhODZwcWk2aDE2MVQ4ZXhaOUtm?=
 =?utf-8?B?N1A2Q0ZzWUIrSlVBaGVYMzR1dm1rTlNLTE1qR0NLUVowRlNZY0U2dEJlWkdI?=
 =?utf-8?B?S2k1S0R5UTJIODFyNlRIcHdDN0ZDNXlzckpvTFJTNk03SFVUSVNDRldqdkZM?=
 =?utf-8?B?SXJrb0RQNThNVDdUUWY0S0gwaGR6YjhXYTBGaDFyQ2UyS0diRHlManJIVHdT?=
 =?utf-8?B?cE5rcjQ1a1NmaWFkdGM5M2Q4UXJPTlErTTZycUFlSDVHaWlJUFU1RmdhZzI3?=
 =?utf-8?B?V0F3L0NLL05xeVBWcG5HMzFRdDhzUHdxYk9JWVB2R3ovOVlFN0c2Tk9jcGFJ?=
 =?utf-8?B?aEdCbDdOY1hXdFlyMkRUR2VycnZhZVZnZ3pzcklMcm1rMTB5aEIxbEFRSjRo?=
 =?utf-8?B?cWtSQ0Jlb3Vsdzk4SzNHWWxlMi9ZdFRUS3VZQ3hQcnR2c1N3cGRKaXFXNHVG?=
 =?utf-8?B?SjNsMzVjbGlLZ3lvQ0t6Mk5ITHVwRkdGSGxIK3JUUG5ZeS85UGpuN2ZDei9a?=
 =?utf-8?B?TW91c3NSUXdPUVFQQ1N3OFVTTnlPb0pYMlN1RSs2dC9xdzlvN1VNWW10dFo2?=
 =?utf-8?B?OHUxSzdnYm0relpzYjRvbU5ZL1VsbjhOQzVsOWIxblFIYVVBZjZwQ1F5M1lK?=
 =?utf-8?B?U0xJSzlzMzJqdm1GdzBtVytUR1gvdTE4ajVaQWVjckV1SzFhcGh5b1BBWXJQ?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 822bf6c6-4b76-41e0-0ac4-08dbb0217c53
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 04:10:07.0843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcdNKvzdhtkg93aT1IAoCfYhpPpuvfKlJIe9cwlvisXOm4SdSbp60jNbnGNJMUQz/C9hUt8ETFfAKeBwZZZaATB9ZsR6gGEBszkdhektzmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5694
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

Kuppuswamy Sathyanarayanan wrote:
> Hi Erdem,
> 
> Thanks for the review.
> 
> On 9/7/2023 6:30 PM, Erdem Aktas wrote:
> > On Wed, Sep 6, 2023 at 7:54 PM Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >>
> >> In TDX guest, the attestation process is used to verify the TDX guest
> >> trustworthiness to other entities before provisioning secrets to the
> >> guest. The First step in the attestation process is TDREPORT
> >> generation, which involves getting the guest measurement data in the
> >> format of TDREPORT, which is further used to validate the authenticity
> >> of the TDX guest. TDREPORT by design is integrity-protected and can
> >> only be verified on the local machine.
> >>
> >> To support remote verification of the TDREPORT (in a SGX-based
> >> attestation), the TDREPORT needs to be sent to the SGX Quoting Enclave
> >> (QE) to convert it to a remote verifiable Quote. SGX QE by design can
> > s/remote/remotely ?
> >> only run outside of the TDX guest (i.e. in a host process or in a
> >> normal VM) and guest can use communication channels like vsock or
> >> TCP/IP to send the TDREPORT to the QE. But for security concerns, the
> >> TDX guest may not support these communication channels. To handle such
> >> cases, TDX defines a GetQuote hypercall which can be used by the guest
> >> to request the host VMM to communicate with the SGX QE. More details
> >> about GetQuote hypercall can be found in TDX Guest-Host Communication
> >> Interface (GHCI) for Intel TDX 1.0, section titled
> >> "TDG.VP.VMCALL<GetQuote>".
> >>
> >> Trusted Security Module (TSM) [1] exposes a common ABI for Confidential
> >> Computing Guest platforms to get the measurement data via ConfigFS.
> >> Extend the TSM framework and add support to allow an attestation agent
> >> to get the TDX Quote data (included usage example below).
> >>
> >>   report=/sys/kernel/config/tsm/report/report0
> >>   mkdir $report
> >>   dd if=/dev/urandom bs=64 count=1 > $report/inblob
> >>   hexdump -C $report/outblob
> >>   rmdir $report
> >>
> >> GetQuote TDVMCALL requires TD guest pass a 4K aligned shared buffer
> >> with TDREPORT data as input, which is further used by the VMM to copy
> >> the TD Quote result after successful Quote generation. To create the
> >> shared buffer, allocate a large enough memory and mark it shared using
> >> set_memory_decrypted() in tdx_guest_init(). This buffer will be re-used
> >> for GetQuote requests in the TDX TSM handler.
> >>
> >> Although this method reserves a fixed chunk of memory for GetQuote
> >> requests, such one time allocation can help avoid memory fragmentation
> >> related allocation failures later in the uptime of the guest.
> >>
> >> Since the Quote generation process is not time-critical or frequently
> >> used, the current version uses a polling model for Quote requests and
> >> it also does not support parallel GetQuote requests.
> >>
> >> Link: https://lore.kernel.org/lkml/169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com/ [1]
> >> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >> ---
> >>
> >> Hi All,
> >>
> >> The previous version of this patch series [1] added support for TDX
> >> Guest Quote generation via an IOCTL interface. Since we have multiple
> >> vendors implementing such interface, to avoid ABI proliferation, Dan
> >> proposed using a common ABI for it and submitted the Trusted Secure
> >> module (TSM) report ABI support [2]. This patchset extends the
> >> TSM REPORTS to implement the TDX Quote generation support. Since there
> >> is a change in interface type, I have dropped the previous Acks.
> >>
> >> [1] https://lore.kernel.org/lkml/3c57deb0-a311-2aad-c06b-4938e33491b5@linux.intel.com/
> >> [2] https://lore.kernel.org/lkml/169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com/
> >>
> >> Changes since previous version:
> >> * Used ConfigFS interface instead of IOCTL interface.
> >> * Used polling model for Quote generation and dropped the event notification IRQ support.
> >>
> >>  arch/x86/coco/tdx/tdx.c                 |  21 +++
> >>  arch/x86/include/asm/shared/tdx.h       |   1 +
> >>  arch/x86/include/asm/tdx.h              |   2 +
> >>  drivers/virt/coco/tdx-guest/Kconfig     |   1 +
> >>  drivers/virt/coco/tdx-guest/tdx-guest.c | 205 +++++++++++++++++++++++-
> >>  5 files changed, 229 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> >> index 1d6b863c42b0..20414ed82fc5 100644
> >> --- a/arch/x86/coco/tdx/tdx.c
> >> +++ b/arch/x86/coco/tdx/tdx.c
> >> @@ -104,6 +104,27 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
> >>  }
> >>  EXPORT_SYMBOL_GPL(tdx_mcall_get_report0);
> >>
> >> +/**
> >> + * tdx_hcall_get_quote() - Wrapper to request TD Quote using GetQuote
> >> + *                         hypercall.
> >> + * @buf: Address of the directly mapped shared kernel buffer which
> >> + *      contains TDREPORT data. The same buffer will be used by
> >> + *      VMM to store the generated TD Quote output.
> >> + * @size: size of the tdquote buffer (4KB-aligned).
> >> + *
> >> + * Refer to section titled "TDG.VP.VMCALL<GetQuote>" in the TDX GHCI
> >> + * v1.0 specification for more information on GetQuote hypercall.
> >> + * It is used in the TDX guest driver module to get the TD Quote.
> >> + *
> >> + * Return 0 on success or error code on failure.
> >> + */
> >> +u64 tdx_hcall_get_quote(u8 *buf, size_t size)
> >> +{
> >> +       /* Since buf is a shared memory, set the shared (decrypted) bits */
> >> +       return _tdx_hypercall(TDVMCALL_GET_QUOTE, cc_mkdec(virt_to_phys(buf)), size, 0, 0);
> >> +}
> >> +EXPORT_SYMBOL_GPL(tdx_hcall_get_quote);
> >> +
> >>  static void __noreturn tdx_panic(const char *msg)
> >>  {
> >>         struct tdx_hypercall_args args = {
> >> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> >> index 7513b3bb69b7..9eab19950f39 100644
> >> --- a/arch/x86/include/asm/shared/tdx.h
> >> +++ b/arch/x86/include/asm/shared/tdx.h
> >> @@ -22,6 +22,7 @@
> >>
> >>  /* TDX hypercall Leaf IDs */
> >>  #define TDVMCALL_MAP_GPA               0x10001
> >> +#define TDVMCALL_GET_QUOTE             0x10002
> >>  #define TDVMCALL_REPORT_FATAL_ERROR    0x10003
> >>
> >>  #ifndef __ASSEMBLY__
> >> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> >> index 603e6d1e9d4a..ebd1cda4875f 100644
> >> --- a/arch/x86/include/asm/tdx.h
> >> +++ b/arch/x86/include/asm/tdx.h
> >> @@ -52,6 +52,8 @@ bool tdx_early_handle_ve(struct pt_regs *regs);
> >>
> >>  int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
> >>
> >> +u64 tdx_hcall_get_quote(u8 *buf, size_t size);
> >> +
> >>  #else
> >>
> >>  static inline void tdx_early_init(void) { };
> >> diff --git a/drivers/virt/coco/tdx-guest/Kconfig b/drivers/virt/coco/tdx-guest/Kconfig
> >> index 14246fc2fb02..22dd59e19431 100644
> >> --- a/drivers/virt/coco/tdx-guest/Kconfig
> >> +++ b/drivers/virt/coco/tdx-guest/Kconfig
> >> @@ -1,6 +1,7 @@
> >>  config TDX_GUEST_DRIVER
> >>         tristate "TDX Guest driver"
> >>         depends on INTEL_TDX_GUEST
> >> +       select TSM_REPORTS
> >>         help
> >>           The driver provides userspace interface to communicate with
> >>           the TDX module to request the TDX guest details like attestation
> >> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> >> index 5e44a0fa69bd..135d89a7e418 100644
> >> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> >> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> >> @@ -12,12 +12,59 @@
> >>  #include <linux/mod_devicetable.h>
> >>  #include <linux/string.h>
> >>  #include <linux/uaccess.h>
> >> +#include <linux/set_memory.h>
> >> +#include <linux/io.h>
> >> +#include <linux/delay.h>
> >> +#include <linux/tsm.h>
> >>
> >>  #include <uapi/linux/tdx-guest.h>
> >>
> >>  #include <asm/cpu_device_id.h>
> >>  #include <asm/tdx.h>
> >>
> >> +/*
> >> + * Intel's SGX QE implementation generally uses Quote size less
> >> + * than 8K (2K Quote data + ~5K of ceritificate blob).
> > s/ceritificate/certificate
> >> + */
> >> +#define GET_QUOTE_BUF_SIZE             SZ_8K
> >> +
> >> +#define GET_QUOTE_CMD_VER              1
> >> +
> >> +/* TDX GetQuote status codes */
> >> +#define GET_QUOTE_SUCCESS              0
> >> +#define GET_QUOTE_IN_FLIGHT            0xffffffffffffffff
> >> +
> >> +/* struct tdx_quote_buf: Format of Quote request buffer.
> >> + * @version: Quote format version, filled by TD.
> >> + * @status: Status code of Quote request, filled by VMM.
> >> + * @in_len: Length of TDREPORT, filled by TD.
> >> + * @out_len: Length of Quote data, filled by VMM.
> >> + * @data: Quote data on output or TDREPORT on input.
> >> + *
> >> + * More details of Quote request buffer can be found in TDX
> >> + * Guest-Host Communication Interface (GHCI) for Intel TDX 1.0,
> >> + * section titled "TDG.VP.VMCALL<GetQuote>"
> >> + */
> >> +struct tdx_quote_buf {
> >> +       u64 version;
> >> +       u64 status;
> >> +       u32 in_len;
> >> +       u32 out_len;
> >> +       u8 data[];
> >> +};
> >> +
> >> +/* Quote data buffer */
> >> +static void *quote_data;
> >> +
> >> +/* Lock to streamline quote requests */
> >> +static DEFINE_MUTEX(quote_lock);
> >> +
> >> +/*
> >> + * GetQuote request timeout in seconds. Expect that 30 seconds
> >> + * is enough time for QE to respond to any Quote requests.
> >> + */
> >> +static u32 getquote_timeout = 30;
> >> +
> >>  static long tdx_get_report0(struct tdx_report_req __user *req)
> >>  {
> >>         u8 *reportdata, *tdreport;
> >> @@ -53,6 +100,131 @@ static long tdx_get_report0(struct tdx_report_req __user *req)
> >>         return ret;
> >>  }
> >>
> >> +static void free_quote_buf(void *buf)
> >> +{
> >> +       size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
> >> +       unsigned int count = len >> PAGE_SHIFT;
> >> +
> >> +       set_memory_encrypted((unsigned long)buf, count);
> > Why not check the return error? if conversion fails (even though
> > unlikely), we should at least print an error message.
> 
> Ok. Since it is unlikely to fail, we can use WARN_ON().
> 
> WARN_ON(set_memory_encrypted((unsigned long)buf, count))

No, panic_on_warn turns recoverable errors into fatal errors. Just
pr_err(). I also assume you don't want memory that failed to be set back
to encrypted into the free page pool, so it seems safer to leak the
memory at this point.

> 
> >> +
> >> +       free_pages_exact(buf, len);
> >> +}
> >> +
> >> +static void *alloc_quote_buf(void)
> >> +{
> >> +       size_t len = PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
> >> +       unsigned int count = len >> PAGE_SHIFT;
> >> +       void *addr;
> >> +       int ret;
> >> +
> >> +       addr = alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO);
> >> +       if (!addr)
> >> +               return NULL;
> >> +
> >> +       ret = set_memory_decrypted((unsigned long)addr, count);
> >> +       if (ret) {
> >> +               free_pages_exact(addr, len);
> >> +               return NULL;
> >> +       }
> >> +
> >> +       return addr;
> >> +}
> >> +
> >> +/*
> >> + * wait_for_quote_completion() - Wait for Quote request completion
> >> + * @quote_buf: Address of Quote buffer.
> >> + * @timeout: Timeout in seconds to wait for the Quote generation.
> >> + *
> >> + * As per TDX GHCI v1.0 specification, sec titled "TDG.VP.VMCALL<GetQuote>",
> >> + * the status field in the Quote buffer will be set to GET_QUOTE_IN_FLIGHT
> >> + * while VMM processes the GetQuote request, and will change it to success
> >> + * or error code after processing is complete. So wait till the status
> >> + * changes from GET_QUOTE_IN_FLIGHT or the request timedout.
> > s/timedout/being timed out?
> >> + */
> >> +static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeout)
> >> +{
> >> +       int i = 0;
> >> +
> >> +       /*
> >> +        * Quote requests usually take a few seconds to complete, so waking up
> >> +        * once per second to recheck the status is fine for this use case.
> >> +        */
> >> +       while (quote_buf->status == GET_QUOTE_IN_FLIGHT && i++ < timeout)
> >> +               ssleep(1);
> > Would not this loop cause soft lock (or even panic) if getquote waits
> > for 30s? Should we not yield?
> 
> Since we are sleeping for a second in each cycle (which will relinquish the CPU
> to other threads), it should not create a soft lockup.

No, this would need to release the lock while sleeping or otherwise make
this interruptible to make that happen. In fact it should release the
lock or use mutex_lock_interruptible() and configfs-tsm should switch to
interruptible synchronization.

> 
> >> +
> >> +       return (i == timeout) ? -ETIMEDOUT : 0;
> >> +}
> >> +
> >> +static u8 *tdx_report_new(const struct tsm_desc *desc, void *data, size_t *outblob_len)
> >> +{
> >> +       struct tdx_quote_buf *quote_buf = quote_data;
> >> +       int ret;
> >> +       u8 *buf;
> >> +       u64 err;
> >> +
> >> +       guard(mutex)(&quote_lock);
> > I understand that this does not support parallel getQuote requests but
> > if the user space for some reason makes multiple requests, each
> > request will finish until the previous ones are completed in kernel
> 
> Softlockup will only happen if a thread hogs the CPU for a long time without
> relinquishing it. In our case, user processes waiting for the lock will be in
> sleep state. So it should not create a lockup issue.

Stuck in uninterruptible sleep is another failure mode of the lockup
detector. The other threads waiting to acquire the mutex will fire being
stuck behind this thread.
