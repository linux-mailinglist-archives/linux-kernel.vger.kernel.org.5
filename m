Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87809774675
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjHHS5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjHHS4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:56:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057E01D076;
        Tue,  8 Aug 2023 10:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691514946; x=1723050946;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2vauG+Tm5WOPqr7zJ++yCpHzBMQARl7yEq4Gfbv/45M=;
  b=YzX62U2Ubl7OqLwG8cuvkY6KGiVyoSWasnj4AMchKY+fQXzRggb/j2+e
   th3RLKj0BauXcVo1BK0QGyNJIm5koKlbjbzMpPvBI13DMCw4bvErFXQCH
   UsiHwNsOMiweqgBza/wYikhMLG6+0WLag/Jy/U5vg+uWCwxVC9HFTRLS2
   64sOEsXGdMbCuID0rLoUtnki7xqj1wsM5GQKJyN6xCsM0nx2BrJ7VF1UA
   qNm6PAHKuLlpmJHST/LQrBZvyBRAucKg0PW6eDHcoH7b8Qg+gczujT1V4
   L8L2eYpihh45/00F8jS1L1yqr9vxuMsZM5Z3E+HfNSIsiKeAvzcCTbiz5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374575837"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="374575837"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 09:43:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="855146884"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="855146884"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 08 Aug 2023 09:43:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 09:43:20 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 09:43:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 09:43:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 09:43:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPHiidA2WjOn4JAlepTKfhg6ipjicyvPKvZdUd/ewUrRsaTtj+oEuEKgg/4JjOPDIoJaTJQsxLou1jZKmL7QUDxVI6qinLzaGkPyCFyO6P68cvUppn/dxnywrpHKgNDXiErzCir1lwQSjWlf7lYjwhDbevEkxLZIKECXw/r0FW3XPhfKh7ktrqVVdPoIx9WFjwQCR6SbhklpQ0y2ihMfn1cvZGmnO9Hu6SHTM+SNU5CRvSHvPj0t7pql+cVofowOKIdOoSxleVLoGU9szQw67dh0r4wXgVRgTHDcmS/yaxjMNETOoYdA8PNlx9g41i5bPoBjJYgWVKZ6PXaiHPl8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfvBpiF0nqzYe5HmmS0jDr5oNtfLCaFgQdDZFPhpDjM=;
 b=fwQJy7QuUZDBsDJBwjbUJNqQsiCLG5LC3C0Tsf9SZICUxAR5u65AfNNqS4McbjN+PFb2KrXbrmgA/fz9Rs4q3YGivQZUOQuoRqP2h106hqp5ClOi9sVoMDFP3+g7PMLTnnxbWi3JTV0RQ+SN8cu5CaQYDpoI+wHfxo7IOxot9InOkaEGG2IAvx8dW28AIJp0c4vX0LiiB0sGdDLU+IeY7XLSxfx/amvIqUu50cgUa6jKwnm55XzTFOqyAI3zKsdp18SZhRWxU7oLbPbK1+zuVXZS38ytrYymGXEdw/6FPYeM6mqRbX3UM+UAWovAQMTs0l63URfKdaulKM8JNgL+4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8486.namprd11.prod.outlook.com (2603:10b6:408:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 16:43:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 16:43:18 +0000
Date:   Tue, 8 Aug 2023 09:43:14 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        <dhowells@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
Message-ID: <64d270a2a68ce_5ea6e294f0@dwillia2-xfh.jf.intel.com.notmuch>
References: <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
 <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
 <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
 <64cdb5f25c56_2138e294f1@dwillia2-xfh.jf.intel.com.notmuch>
 <1180481830431165d49c5e64b92b81c396ebc9b1.camel@HansenPartnership.com>
 <64d17f5728fbc_5ea6e2943f@dwillia2-xfh.jf.intel.com.notmuch>
 <c7d6e953a4b36014ea0c7406531b24bb29d6127e.camel@HansenPartnership.com>
 <2425e00b-defb-c12b-03e5-c3d23b30be01@linux.intel.com>
 <64d263e44e401_2138e29486@dwillia2-xfh.jf.intel.com.notmuch>
 <CAAH4kHamob7g_+BRd0JW76cM7_vS=jzXzRjrgCPDxZ29VnzdCQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAAH4kHamob7g_+BRd0JW76cM7_vS=jzXzRjrgCPDxZ29VnzdCQ@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:303:dc::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e90e0d-db4c-4d40-9999-08db982e917f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YCzmZN9XbeCt+pJFt+iDXg0vkLkD7Kpmho/GNK7c1RbuMub5C8dN0FGK+QkmV70gveB2gBvu+RqCBjTWreLhfgok+3yeMZqeALkErTiYz0Sm3CMC0YGuHXpg4AlE5rUg19X/dpKTQD3SPVgC2rhymDFmIN3rAdZkOUdS/8ZTp08m0j4Yzt0IeUoANyoHo7dcLwnj+BVxk6jVgWS07Asgbw8mJ8cxfAgzJRa1PZ54xq6+2HSSFxw9u+QTR42vdsRxIIPHtJWElpDNehXWxHEVIl7c/b0gDAO3DER0tpavDyOhyO3RbeImHc3P651DwJpAhQ804Nl+JjzRcQ2F0f87zDvNp1vK6D/sRyvTKrhqHj1sxedWFaoWnzOUTqLjmF+JQw0tkVQZINw3ynxgG7iH99kPtl1mCUPSctfNA+UxgJssshLLFOH9yVr6EEJXKza3pYoih41OygOGdgB/cfTqxNeVkW3hrEWtk6f7k2fLWw3NSatCBzLS4ER9wrCCFOtx/PF0uiVmL+lvB2Z+MPG6HGlEydOLdYUMBuXwgFhpY7L2LsZT5U8ax5CmMXD9/6EMr2EWd5zkqLNcqc85lIaoXWcfcQbbZ7GTOn/w5kjfoSE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(39860400002)(396003)(366004)(186006)(1800799003)(451199021)(26005)(6506007)(9686003)(6486002)(966005)(6512007)(6666004)(478600001)(82960400001)(38100700002)(110136005)(54906003)(66476007)(66556008)(66946007)(4326008)(316002)(41300700001)(8936002)(8676002)(5660300002)(7416002)(2906002)(83380400001)(86362001)(47845007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AHU4fP3tccBKYyRxf51B/Jf0N01xiQgiQH+7k9mEXkUiq5i6mYD5Gx/PwFPF?=
 =?us-ascii?Q?OOvHH/YS/GFXB9hSBGPGi1XRudYKzwYO//TeQ0JG7/PpPKzEDJ43giWpbXbl?=
 =?us-ascii?Q?aPvJ4/gXjCsf+LOdsg8C9XTIWkoaRdzTvcZ0g2/6rMa785RXT4Lh7pkB7qkX?=
 =?us-ascii?Q?QQ335Hvlw1xumvqLrwmvV0irAVaCrCeT0MM+erc3r/FkDEHWyV4TsUMDqraz?=
 =?us-ascii?Q?pjgke+tRvAyrvMJA+1nYqwrAuW7MCIssX4BeFB96A571nhAEIiwGQx2m4xCU?=
 =?us-ascii?Q?9UOzU55T+q1FslaECBp7hvjpbqurtGrLBNoS+nDhgHFEhK2OfD58vacHsDuZ?=
 =?us-ascii?Q?HJC0JdfJ9QHXZjfZ2hJxL5a4tLV51UE9PfC8xCPsg92VxoYqRBG3+zRRZ2QE?=
 =?us-ascii?Q?2ULo4AoLNPTolf8xm4b3pPJSzm0QoowxFtpsYxU1SoCU7YQ7wRanZBKa6sp0?=
 =?us-ascii?Q?DKwvlmOwPN4dkbC6lLGdN9vtuFatRNBnWhMxvBHHwTBwHY0tyzDmhU8wIb0/?=
 =?us-ascii?Q?9+SjXdrePvA0GDsP86t0JBamEK7P8KZoePH6OrRHvNqeDReaCEJRKuQBrsmL?=
 =?us-ascii?Q?RM+3QRD5mcbs4WQEgpPjxdWws9Ij2SZNSsqZ0RdMlwGe6EloC71jD0CXceVZ?=
 =?us-ascii?Q?h7tw7iUBlNC85B45La/RBehzdxfRZsdN70UgAxFTTApBPZnM5xXASjzSd3F8?=
 =?us-ascii?Q?oKMvKap4uhOih53DLEYKE5AgDzDBux698ZRoeY0Nq4PzVpmjzW6hFeausnie?=
 =?us-ascii?Q?+7o39jwa4SJmWpDn5shnBJCeMgoDDP5W7ynwgMJIwcpUR7nj4bgmndYz9cUI?=
 =?us-ascii?Q?pVvEy/6S4LGHnD/+6XvAJ2ujC3yqAABqBg0FDKAX5EwNxttZK0LOvBpZgwIl?=
 =?us-ascii?Q?KXoJ7Pb6+x7sNv8SNvmNQuRW04ZOh/oGqCaZca0tfQkzCHOD3mbAx0cVHdCB?=
 =?us-ascii?Q?Wpp3iKbkR6i5aFyHenjL8v9Aq4dvS5DO1rSml66STFdQ8iSwWwI/BFF3F1To?=
 =?us-ascii?Q?Y1zMEQ2uPHFhW/Y2YVfaNVkGpXfnxEAUu5q3UBcbJy2s77NhffDPAymoksK9?=
 =?us-ascii?Q?Nwk5oj6nVz56h+I+OoahC9GXH9P8gCjBtuHQ+xGs6dSDPu+ud+YHh+tK8jJh?=
 =?us-ascii?Q?TbXiDug3uF/pF/LPrgTWOtUsrMF/p7f48qX+iJeHJjQQuTljfaQUiIDsUqyV?=
 =?us-ascii?Q?RddBjjsYHodZ+pVfKz74uXe4PRWXRj6Tb1AIsr/K+bkxoIcJh34CM3fByoTE?=
 =?us-ascii?Q?fwOj48SIgTXxmumYO90E5j+d7iJKMm1M665LXbhdhImiYVRPgoKhtPZW2Dug?=
 =?us-ascii?Q?UYLFvfIjzfMC7sH08rjQtRjF+CJErzec7fYfCWM41Ob+gKSP4gvgrfX6olxC?=
 =?us-ascii?Q?szpjCZdPrrxBCXRztmh1jqyepI+tRezLE4g4ghQnoA4HKSHSzKjcImrbGtva?=
 =?us-ascii?Q?iNopNRI5gEu6RaR7WfW1IcF5D8S8z4ixjF35Y8iMDXVARLTUQ7C+PammfwJ4?=
 =?us-ascii?Q?Ro+URVUfISotaxNCkKNXkLEiTNmBzQq5XqXN3FuNosZk62FOj2Bzd74zn7ml?=
 =?us-ascii?Q?MaLmbvwdxpPjgYvX3kUiwRgG3WyyKecfuJK6YU7hNUILRaHI/5jzK40AIz5y?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e90e0d-db4c-4d40-9999-08db982e917f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 16:43:18.1502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/zdkV552gc6U/z0yzVT7csodXZZ6Yoli4Pe9RQhWbO971vO0HtWFt5MpFm8+Iv1gtp2T8k98DFZeZLwqeClwqoNNr39CBXE6CZQ3ONqRWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8486
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

Dionna Amalie Glaze wrote:
> >
> > At least that was not the level of concurrency I was worried about. The
> > sysfs approach makes it so that concurrency problem of option-writing vs
> > report-reading is pushed to userspace.
> >
> 
> The reason I would advocate against making attestation report
> collection single-threaded in user space at a machine level is that
> there are new schemes of attested connections that may become the
> basis of server handshakes. I think folks are mainly looking at this
> from the use case of
> 
> 1. workload will do large amounts of work on behalf of the VM owner,
> provided it gets a sealing key released by the VM owner once on boot
> after proving its code identity
> 
> however I'm thinking of the case of a more user-centric use case that
> enables service users to challenge for proof of workload identity
> 
> 2. workload is a server that accepts incoming connections that include
> a hardware attestation challenge. It generates an attestation report
> that includes the challenge as part of the connection handshake
> 
> This posits the existence of such an advanced user, but high security
> applications also have users with high expectations. I want the option
> to be open to empower more users to have access to provable workload
> provenance, not just the VM owners that are unlocking resources.

I do not see sysfs precluding a use case like that. If the kernel can
call out to userspace for TLS connection setup [1], then advanced user
can call out to a daemon for workload provenance setup. Recall that TDX
will round trip through the quoting enclave for these reports and,
without measuring, that seems to have the potential to dominate the
setup time vs the communication to ask a daemon to convey a report.

[1]: https://lore.kernel.org/all/168174169259.9520.1911007910797225963.stgit@91.116.238.104.host.secureserver.net/
