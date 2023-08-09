Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33452775166
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 05:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjHID2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 23:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjHID2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 23:28:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29A41999;
        Tue,  8 Aug 2023 20:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691551680; x=1723087680;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=wUsuQ+BwkFmv6OwLjUGeTpiNm5iiLxUMo0OnIOmSQTc=;
  b=jJKlmq1t4FHsGOgnw8TowvhALrXsdjuYtZcZ44vG7bjF8coXCezc1tL6
   ypPrUt7VQoHVLyAvqm9XVuCxpy9eVXtVi/MWHw6C27Vk3CLDr87Z0ddqa
   510OyS2Pi3+yE94E7AIBw3MYk1S+6QWruQKql3hbyPpV4Fv7rIT50v8fR
   VOP/s+ErBLqPyhTiNe7XKGwm15r1O1m8aBsMKQ8/L4Ko0tAbyPWthICnU
   9+FbFxmfCUWZ7hm6sIqBIM0Uz58dE/35q1Co/U/JJ5FFf7onBCSC3Oak+
   Buk425auvWlp143p39mgjErlcQ/9l9d4d25zoM8IuZi0bWFcIy/v9CZK6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374720341"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="374720341"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 20:27:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="734830098"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="734830098"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 08 Aug 2023 20:27:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 20:27:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 20:27:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 20:27:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQbMXB5PihzCBd31pRtEyOVr6Dr7VmLYfW9hlHXH8WrdDvAjs+mTeizyhJPNSGpNrTDIpcZbFsdT0jn0768T9aJR2Zg/4xdZVd4nQyhAPv7bQzmPzI5d2g2f4XLQWcxvBTTiwZU+/L3cVl7bJjYGqLAy+Szsu59Ivx2yNKIPMvL0dC7v5cMQaJAfIZCNNgmsIRB5CxaVnc6jZBhv/KA9d6nBrqLe6/tPEHWlWSmbtff0GxxGljS4wJvxkZad2fWmxKlLA3V1nUfWnwK7mptioKO5szvf7SAuUA+Vr/xZrDSpAYgoN7B8yhlOS0fXzxuANevjERnoaGuewH6hb8kgRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4zG5Wt/Qt5o3SZUQYsVjD+zDKTwEJKh6rXr41M4XsI=;
 b=MtTDawVt4N2G3LdHfE/V/L2Cnyf+sREGsI6I9SFw/5GlEOijupnmXV70hg2dFWmEzFUwtaVSLbhQ0fquc7ZCmiXaUlV//AUjV+gQdpSAOZcNTUIm3zXaNpTn0idXrSCpfKdYhZbGdaFDGsKTPsst0arp7g6X1LiKKPJcwHZjo9wdQI/0W3DZCRN61h+qS2fDtN+4WjQFnpkJBKymWBbF7IrrtRjWjlbWOtQJClK/8lFCHZovJh4Oy+fl0K44hj6KH13fSOpkvyrTiWrF1GmZzLGEmPIZjvi7VFf8/7fDFBQF5IZDMSpaWQ7kjB6OtQCCOvNJhBFLqCWyDkeMBC9/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB8214.namprd11.prod.outlook.com (2603:10b6:610:18e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Wed, 9 Aug
 2023 03:27:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 03:27:56 +0000
Date:   Tue, 8 Aug 2023 20:27:53 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>
CC:     "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
Message-ID: <64d307b94bd9_2138e29488@dwillia2-xfh.jf.intel.com.notmuch>
References: <1180481830431165d49c5e64b92b81c396ebc9b1.camel@HansenPartnership.com>
 <64d17f5728fbc_5ea6e2943f@dwillia2-xfh.jf.intel.com.notmuch>
 <c7d6e953a4b36014ea0c7406531b24bb29d6127e.camel@HansenPartnership.com>
 <2425e00b-defb-c12b-03e5-c3d23b30be01@linux.intel.com>
 <64d263e44e401_2138e29486@dwillia2-xfh.jf.intel.com.notmuch>
 <CAAH4kHamob7g_+BRd0JW76cM7_vS=jzXzRjrgCPDxZ29VnzdCQ@mail.gmail.com>
 <64d270a2a68ce_5ea6e294f0@dwillia2-xfh.jf.intel.com.notmuch>
 <CAAH4kHYht5s4CkS5Y9+VotPH4WqDrzng0vYy89oq0_U16H_dDA@mail.gmail.com>
 <64d286bda1d8b_5ea6e294eb@dwillia2-xfh.jf.intel.com.notmuch>
 <8d7acdd5d4824999ac6f28def43f9bdb8bd45d44.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d7acdd5d4824999ac6f28def43f9bdb8bd45d44.camel@intel.com>
X-ClientProxiedBy: MW4PR04CA0385.namprd04.prod.outlook.com
 (2603:10b6:303:81::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: e84dd1fa-1034-4e94-0aa2-08db98889f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6+eGymA/yr3NQS/04j/TRvPLmzzDT1bjtVUU+/3gIh9UTboTW+em0qYQvdYfMh2+oEefg9lt/nY6fBFqgoW5Rh2yJDXiy7LpUW/GKc0bB+hKq5OAwwnkMvLQ14B98NIiAnNoVCJ2xrFTLN4yb67PPjwoI5UtRoo9SK4FXtSV+LHvxa/6EyDMedgOGUg1FhiIIPoTEyM7x6qFkqf/aZcs8xraMCjdmi+iflSMQoCl/JNHs4EVjncYiC+ErACkTFD46yD6iHRKOco0rlmLSHfe9DUSdI1hk66BIlToIVKyKTzEdyQbjQBHK2dRn/+YmBLZh9dFjdK8cArwajio82FwTfqe8k3Ohn8ceOSjEV14/z+iNFHlJGDDyIiXATJKAQdPiNQopAUobD12cIlL17QgcVczP5UF9rlZl0FaXGlldxANowm740WRFCVL8GPAS3NV/+mZhm89Lk/xsAw3SiE1YZ5n1ZAOJ3gXIgwms+dl4AJaQT8FnExAwR1E2NzH6TMyfrjBCBua2D8NOExX2S8ZwDtl4Q9NdyaZV8I2hooFU7ktOVr4vmjcfgsLWA3t8L6+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(396003)(346002)(366004)(186006)(1800799006)(451199021)(2906002)(66946007)(66476007)(4326008)(6486002)(6666004)(83380400001)(5660300002)(7416002)(41300700001)(8936002)(316002)(8676002)(66556008)(110136005)(54906003)(38100700002)(82960400001)(478600001)(26005)(9686003)(6506007)(86362001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?VQdgtbqfN++WOSKJvdUo/uBSOmVH+9Xc1fTnwKg+zUoushJdPFMURJmopw?=
 =?iso-8859-1?Q?rsqt4sg/k8G2KyjuR0JyDwvHZkVvzfq6myNNZuIxUxNdbgIlfh2sPmMCD6?=
 =?iso-8859-1?Q?a4Ema3JOPmRKOp/WEFxgUVKDXZ/msT28OYzWHK0jAf71hIY/lMdKen7exo?=
 =?iso-8859-1?Q?nBVeSLpC53I+hnD5wr/S1HdnPLo2R0rSv/7WTfchheYClowSKHyUPLFxa6?=
 =?iso-8859-1?Q?N9HzIs43n0M80JFG6oTzFVbslinjcHXaJKFLsHm30jSR3McuKWpnZlc1uc?=
 =?iso-8859-1?Q?jTSMO98sQy7y/m1J/ilnTt4DwTE1EiaooRodyCVh5RIm4QcDS0KA0N8D5Q?=
 =?iso-8859-1?Q?IxeySO1MVFNQiDuZfWu2l9I4UUtV4lwAEnLL13eFh+LH9S2foOC2uJqAvJ?=
 =?iso-8859-1?Q?h2RcslPwon3Inj6Q+HXDk7HgchXnLI5yEnV0sJka3SO202I1NUG1hiCa/2?=
 =?iso-8859-1?Q?RzGHmfc5XSRDR3bMifhCD/sdZF3urwjmrG6WtA3kPoMaTQckm6vlOUhQxK?=
 =?iso-8859-1?Q?i7HW4ZKJP0eDsx2Mg1FGdKcxH2Cxxx3l3M2+vxzq/dNr3XrFOhSa3+nmgP?=
 =?iso-8859-1?Q?qXN9SSY9w8lkKLMqHNup0TnrClwEzOd8TsjW564ZPSLx1PpuluaFkTPPsq?=
 =?iso-8859-1?Q?/xRRtY4eNiIL7dHidDgVXL2hUnzbsbu67MAUjcu0sYdQDs2iLcXNhJeAhF?=
 =?iso-8859-1?Q?3fEvr5mkGPkH/NlA31FMRxbdPrclaMcE7EaX0xtrt+1rermaSLb/2F8iTV?=
 =?iso-8859-1?Q?0izJLoq9HQvDi04PLFa3k0kEwp7TJQYYXd/0/Dz+q2ebvy+3D1oWhanFZp?=
 =?iso-8859-1?Q?u03ba9DyulOxokC72MHV5J3PA66hE0eKgh3SUeXAvIKGQW94dSs6sWPVft?=
 =?iso-8859-1?Q?MmkuUVk251NHCl3gWcQBCmpWtOyvcGY2j/2RA3PFxntJ6WLaeFCeuhhEVq?=
 =?iso-8859-1?Q?Q8gG8lL/gMhEzjwf9/Bp8AP2hJAu+t7G0r4DI3glYCnPsTLmdSVBYfe3ZM?=
 =?iso-8859-1?Q?m4GAsVTJ46OAQfKXdrltTxPyobVkdQoFgg3aCi5hAgeeGCw1lV8r7k3Vm7?=
 =?iso-8859-1?Q?qHAWYvxYtYA0yAYACiS5a3+nRSr0gCYn7+SnBWBFjGH37IRaAu/FzgVoAz?=
 =?iso-8859-1?Q?1edDBa5FIxgFsq09J9KN8qcnhXTbvbpp4lDggE2NhdtTuul1b/T1o59xN4?=
 =?iso-8859-1?Q?wRsAOEH6Tt/JisPo2+5yHZmaNFaxyEVEAubt1NsIz/ir13qw7dFik2g8td?=
 =?iso-8859-1?Q?4uFCcAmo2ItoZFsbxZTN7nBij8O7AE6sA9abthnVt6xWk2aELcZ3n2VCi5?=
 =?iso-8859-1?Q?L8/0FTN9dGy+/mlr3rwwJyltfzvOllDYdFN25gJVuzFm24cg+cM2OSTq+L?=
 =?iso-8859-1?Q?oRNCxj6To7OFCA80TuxWhn022hjwc+CtSZmQZe4Hf9Pc7wxdjmiLuZp7Yu?=
 =?iso-8859-1?Q?ZIRTIT9+2eXQJJn0WNY3nDsHLRCcQBZF3PaC6DHRMtg+4BF0wRYhEy0anB?=
 =?iso-8859-1?Q?NG6RoAmCnOOXZiJsYjsEgebgbgyVY0ZUtlkYFFAgne8OG+AG1iUJZkYqvn?=
 =?iso-8859-1?Q?5RciDaPPsRA/lCi55tV+XH6YO0LmcFr6jS5JQzANapjZEDCzQrlLmpjMVG?=
 =?iso-8859-1?Q?wwT0XquAwwN078eqxemGFCsSbAvf74iLkhe1Y1MrxIQSiiV1akGGhPjw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e84dd1fa-1034-4e94-0aa2-08db98889f5d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 03:27:56.0954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ff+4AzTOpG/Llp8JVLBQJttquwC+Go833CIwIW3VtgcqVWzUeHBAXWpj6TzF47zu/c60iu3Pc2Bzo1DrwH6CYL2pt7ueuu9bGEr6gCBcFAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8214
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

Huang, Kai wrote:
> On Tue, 2023-08-08 at 11:17 -0700, Dan Williams wrote:
> > Dionna Amalie Glaze wrote:
> > > > 
> > > > I do not see sysfs precluding a use case like that. If the kernel can
> > > > call out to userspace for TLS connection setup [1], then advanced user
> > > > can call out to a daemon for workload provenance setup. Recall that TDX
> > > > will round trip through the quoting enclave for these reports and,
> > > > without measuring, that seems to have the potential to dominate the
> > > > setup time vs the communication to ask a daemon to convey a report.
> > > > 
> > > 
> > > It's rather hard to get new daemons approved for container
> > > distributions since they end up as resource hogs.
> > > I really don't think it's appropriate to delegate to a daemon to
> > > single-thread use of a kernel interface when the interface could
> > > provide functional semantics to begin with.
> > 
> > That's fair, it's also not without precedence for the kernel to await a
> > strong motivation of a use case before taking on a higher maintenance
> > burden. Unifying kernel interfaces is important for maintainability and
> > difficult / needs care. sysfs simplifies maintainability (but exports
> > complexity to userspace), keyring simplifies that (but there is a valid
> > argument that this is not a key), ioctl complicates that (it is not as
> > amenable to transport unification as the above options).
> > 
> 
> I don't quite follow why ioctl() is not amenable to transport unification as the
> /sysfs?  IIUC both are new ABI(s) to the userspace thus userspace needs to adopt
> anyway.  

Recall that the concern here is kernel maintainability, the kernel can
decide to export complexity to userspace. In that light, ioctl() code is
grotty sysfs is not. sysfs attributes (tsm blob options) are easy to
reason about and audit, ioctl() is not. sysfs is easy to extend with
local attributes to augment the core, ioctl() forces all the optionality
to be planned up front.

Basically, if you hand me a choice between maintaining a cross vendor
ioctl() ABI vs a sysfs ABI, I am picking sysfs every time.

> On the other hand, ioctl() seems to be able to handle concurrent requests better
> than /sysfs, if we want to support the case that integrating attestation to the
> handshake protocols.

There is not an exceedingly strong case for high frequency concurrent
requests vs boot time attestation and deriving further secrets from
that.
