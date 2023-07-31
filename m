Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A9C76A1C0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjGaUKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjGaUKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:10:37 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C852C19BD;
        Mon, 31 Jul 2023 13:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690834229; x=1722370229;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oV6kArG4es/TQxLjQRVVDVGBP3kiBq3pENH/njXYt2o=;
  b=WP0ARsjCkdXDYA4oY7Yi8O57NWDyqJUDaabdx63hi9QK2uxPbz9lthbP
   iEeap/peQwuiyRPsSBCYcv48CaYYsGMtdrIaMC9xk6pPcoRb3ABTVcYBA
   wXtgliJdIkgioF1MQtpCdvPFnA4AtcRQqX2NFQNKFDrAcHMiYAN7a3LQI
   IN4JOXYu/PPup4leqbMTdjvZ7PfQwJpLksAtzBGucdiDMAMpGPsO0nOFh
   KnE/jHiqFxh7B3PPG6dj5C3HuvPYQu/y5xQnAg4QgViUpMOLbmkZ+ugXT
   GntPWaClfo9yORg1Izx3XCiK+6FFnEQh8XFFbevMMijKh17GtkvZu6oB5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="368021640"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="368021640"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 13:10:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="728416985"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="728416985"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 31 Jul 2023 13:10:28 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 13:10:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 13:10:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 13:10:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYorURMUJVXarhpL7rPQlE5JV4Atv3S0zRMbBljj/dEqGIGhzeChJou3mNJIYakonh7mgXDCbk+odGyMWG7ZIWg9mCInTEfGxbUL4pq2X8QfIT1fDvhsVyZFrAteh9UMepg+KUvfxVYDP8sId3ZL/bfWtXYkKhVPIIEPSgtTtg6h1lUj7Mjp/HiQPIpyLji2FRWkRm5ZVNjqokf/R4hMty/LJVYQj0sIMB3bpPWYVDERbON8eKI6JKl0EbuKAfyo3LB6UuRjq0EpTYSLn7li86eT47+k4TCa/yff7qCYEIVgaqrYXrgjEcB8DaAFKDL/YrS6XZBfvWLK7EFAeiNWpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+q3TjGW4wai18/Ozkb45JFwqQfnOt9y4hHAs6D+5bCc=;
 b=l8d9jgFYx4v9yjGhOiD0zuPwXdDeykkov0TgtRFdkNVz1K3j/kNDCxk1G1qdbbQ9NhKuh2fjfDoeiksjcuouO+fGoJwqLs6rDcGY7TP7tkvJc6ml0cnpfguC77dNPckTf89BbOyIfXn0jhl6bVuXmhSh2fPgXoJBfVEFsw3R7IN1FV0Tl/GcqwB1LSJKWzMJLTgBWYozWy5ABgXpKq4ZPFTWbDQnro3Tg6cnG5OZ+6f6qNYrSbiBQvO5H9eifEzEjcbCpgu3Ax3nk6GNQjAXumXc85lwsGNyAyCj6RIQwaRiSmUsieKmX+iSZ23p0uYuOyXc2fTZhDgYLUelqboA3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6381.namprd11.prod.outlook.com (2603:10b6:8:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 20:10:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 20:10:23 +0000
Date:   Mon, 31 Jul 2023 13:10:19 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Peter Gonda <pgonda@google.com>, <dhowells@redhat.com>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Samuel Ortiz" <sameo@rivosinc.com>, <peterz@infradead.org>,
        <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] keys: Introduce tsm keys
Message-ID: <64c8152bd2570_5248329455@dwillia2-xfh.jf.intel.com.notmuch>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <169057265801.180586.10867293237672839356.stgit@dwillia2-xfh.jf.intel.com>
 <CAMkAt6ot9zyUL9Ub-qYq+d9v-6rTft4ea2mUxp3o1s3GVFq7nw@mail.gmail.com>
 <64c7f3df475d5_51ad02943f@dwillia2-xfh.jf.intel.com.notmuch>
 <CAMkAt6p9yEM7A5B9TyZsVTH=X=UQ3Z9wfYDg9etuc806mNdOiQ@mail.gmail.com>
 <64c80077d7144_51ad02941@dwillia2-xfh.jf.intel.com.notmuch>
 <CAAH4kHbsFbzL=0gn71qq1-1kL398jiS2rd3as1qUFnLTCB5mHQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAAH4kHbsFbzL=0gn71qq1-1kL398jiS2rd3as1qUFnLTCB5mHQ@mail.gmail.com>
X-ClientProxiedBy: MW3PR06CA0013.namprd06.prod.outlook.com
 (2603:10b6:303:2a::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: a03ca14e-d165-43c4-063b-08db92022bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4elYsZfJ/VodSmf4X0BAg6z+KgJylLPdBE/1C0ho1eLyDVNzdFYvlXcpeJjVy4YjzF+JtP5a4Wq21cwMCwYX5aN52SYgbPreTcYRomLLc9/ZyXDPy2J86tPsD7YTu1TGjLLqCAHj8vK8GqACVH7+/CZHmKYH9tSZge40kmScM6A5iHAV4a6ZSHBhDZ/YAbZ6AzmREQJdr1n57ODUznTYwbqYqYUI7bMSblv+7oiiosOIz77ZU9X7y3GUV2lSm7Lp6gA/HvSLMPIfR8P6mmmCvhvPJwZuwT8paeyd7wkohHz08aJqlSIJvcvs91Mv0RGJtt+bBsvFRzfVC79wP2pfLNzRWmPtimLVHCiJGzDAW374dpGVfzdAwpPIPkPEytwIPZcK7zt5pNAuwhByl3amtQx0YTNOfwzUd0Eaqcng9efWLZ5dq003WEbbFk8QzXLavdf4vgJ59WvBUHKvECw7xb1cgFL4v02ak89KqYJkUOCN9iRotPUCkZZklIL9+gspIr1hiD4DkODPjKZEOClt2Jnj2Gz+zArbACW8bE6m4zAIRYhVecIg78iT+PjP4oAz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(478600001)(38100700002)(82960400001)(86362001)(6512007)(9686003)(6486002)(6666004)(186003)(26005)(8936002)(6506007)(8676002)(7416002)(5660300002)(4326008)(66556008)(66476007)(2906002)(66946007)(54906003)(41300700001)(110136005)(316002)(66899021)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uSe2NZMTo8Ux3pJMTCQGjsjMxk64P8DvechT2Wvr1k8J3SGbiPyKwwOj4a8X?=
 =?us-ascii?Q?OGCcdNHg72U2B7Qkxz4PdANfc3SkOFpZoxoNIq2gMz1IIxPLAmhQy36yeosS?=
 =?us-ascii?Q?/iqjGqu/VyYyG2wKF2iEPgtN7iZ+Zf5EIyIf1JF5QhqEMOw5aehLBa9BM/50?=
 =?us-ascii?Q?uo7ISh+CJzHu9S2jzIvltQjJHN6bnWVgVLYIta2Jg0oe1cIvASPczjmqiwIM?=
 =?us-ascii?Q?QxzqWlzQPhvWagtb9ybgmdbR0aLo/SeRcCwcNZFnh/6hJGhMnVHwt0tlsCTU?=
 =?us-ascii?Q?SXVNty5Dso9Du0ToJKYCgw6Ud7c5uO9HsLWdNqFebHqgDjLl1gTQcCH0+Yuw?=
 =?us-ascii?Q?/6R3Qwq3QxwY0ccskh5yht+zGHELi/ZfeIxw+PNvwH39WEqk83GD6R2XTLg9?=
 =?us-ascii?Q?DbhXTJw58eXGei1QYprHVdWci41pgFjgzo/yoEMLE958/+nBMbIpZyJj0Nzw?=
 =?us-ascii?Q?Q1FIxd4Hm1ZF+m4nxldnodgJOBfy4BS8rBMdHPVFYHsVVDbo5H7DtPdHUp0r?=
 =?us-ascii?Q?UfBqWcCeK4uiGuSHaCL9leGBrSwAL1SErU8Y+7ZGFPFB1EEL4iPwcXzdgeLE?=
 =?us-ascii?Q?OvbCWzVzVfZM4z8u7Gz56ucD5HZirnxXS+44fB6X51jIRCnVTwOFDnKxYyZ7?=
 =?us-ascii?Q?AjN3KG9YjgRHa9sGf43meOX88T6gTaLJd7/PqdfJMw+VBAjj+IppwHeZ2V4w?=
 =?us-ascii?Q?3kfk3cWwtvMb0DOlI+TEj2Dof71qBs5dtcBlratqwVTJ3KjzpNWTL7sX8z3u?=
 =?us-ascii?Q?xNfKMTjW5NCVpp+5ao08rGmb0X3c7JdoX+PL9eFogRUwCl2cdptXliZLSXzR?=
 =?us-ascii?Q?MiCz6p+bxY/CYCgT5wEC+Pu7bo96Sl96vzLhUT2lifu9KAFpD/Bqgw4RlTpe?=
 =?us-ascii?Q?p0coL9HD+ZKRjmxvLz5vHA4AE7XadR8z34Qq6wd3OmlKR4uwsTowKMDknC7t?=
 =?us-ascii?Q?boeGsfpwbiyspGzhGbgDh2/99VeK2bw8IiCHc5N40TC4k8reuOUowcA9OSC1?=
 =?us-ascii?Q?kx32QkD0qhJXf1QE4b6XjBc4By+WC/rFbSjFN/uz0H11Ti8rMn2bopGEaKsH?=
 =?us-ascii?Q?KEOK1YVi9RXEQ/qaBHROBp8csg0ethPeNoEgAtIv6mNvxjURyw4mrkVgEyue?=
 =?us-ascii?Q?SD5Oo3dp4l88fqlNFW1j5pNaPYWER4DGxzqar0Vow0iTgfsZN4jEEm7CYnWH?=
 =?us-ascii?Q?wvzBNuopgKyg5l9WoD/JLpXBDKob3dKo1+iIZH5GLnN8w8Hc1/VypoAKVdUS?=
 =?us-ascii?Q?xRT6AtLD0vaGEbNpG/r8UR23p8phLKMfwL7Z2RUbDBVcJl47mLam0LoqQL50?=
 =?us-ascii?Q?fbg8qgTGCErB0Bwr2Mw6vQUsZWcCDNyJX5HWU68Ymwu/mhSnMxZd8chMR3FW?=
 =?us-ascii?Q?TGHwOPVd90hkmbEzsXgOYx57q4r/GsJQT4GlcY3ApwlaY8io05ArUACqBP3k?=
 =?us-ascii?Q?32jM36dRKsrkjZ/lpdzu53G3l8obdULAA2FdKE3ni8zvbH0hTaW1kbMQpJNY?=
 =?us-ascii?Q?Iu+1pbgSHlN6Iyq9xxLz55HC422wmnS6fwzLEY8Vavu/w8m04gSqSsYUD3Br?=
 =?us-ascii?Q?Kzt6mO9INrGN1C3YP4uRDFc7VlVUZNloqbJqCMLYKmQZwchNc9zdHWafS/Hk?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a03ca14e-d165-43c4-063b-08db92022bf1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 20:10:22.9680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OijCf6dTZ3b3NXlUPPI5kX5i4NmE3oSNfJeH06Z+4OUPM2md1iOf3lkC+m92z1HRa4nmDc4a8suR7FnpRhXJ7FaF0ONDEoFKZYrQlrn0/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6381
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

Dionna Amalie Glaze wrote:
> >
> > > You could imagine some userspace application that receives RPCs and
> > > does some attestation for each one, would adding then deleting a huge
> > > number of keys present any issues?
> >
> > I can imagine a lot of scenarios, but reading the SEV-SNP whitepaper it
> > seems to imply that this is a launch-time one-off report that
> > establishes a channel to convey other secrets. So my expectation is that
> > this interface is used to bootstrap a guest and never again. Are you
> > aware of a high frequency use case for these reports?```
> >
> 
> Attestations may be requested by RPCs themselves when a service
> decides to allow a user to present their own challenge nonces that
> should be included in the hardware attestation. The "once at boot"
> workflow only works for a specific type of application.
> 
> > > > >
> > > > > How is freshness incorporated into the key exchange protocol? Wouldn't
> > > > > we need to do a challenge response between each remote party that we
> > > > > need to attest the provenance of @pubkey too?
> > > >
> > > > That's left to userspace.
> > >
> > > But you haven't allowed userspace to add any data into the quote other
> > > than just the raw public key.
> >
> > That is not allowed by the SNP firmware interface. The only input is the
> > 64-byte user-buffer that the SNP whitepaper calls a public-key.
> >
> 
> The whitepaper presents a hypothetical usage of the attestation
> facility. It is not prescriptive. With only 64 bytes, you're most
> likely to be providing a nonce or a hash, and not a full public key.
> Indeed, you may be presenting sha512(nonce || pubkey).
> 
> > > The current sevguest ioctl allows users to pass arbitrary userdata.
> > > This would allow for some nonce to be included.
> >
> > It's not arbitrary user-data, it is only meant to a pubkey per the "VM
> > Launch and Attestation" section of the SNP whitepaper.
> >
> 
> It really is arbitrary. We've also been discussing including hashed
> vTPM quotes to tie them to the hardware attestation. That's not
> necessarily how it'll be used going forward, but the interface needs
> to allow for this flexibility.

Yeah, my "it's not arbitrary" was too strong. What I meant is that Peter
seemed to be alluding to losing some ability to attach user-data to the
report in this new interface, and I was just pointing out that the same
ability to attach data is present in the proposal.

> > > At a highlevel I'm not sure why this is better than each vendor having
> > > their own driver. It doesn't seem that difficult for userspace to deal
> > > with these systems given userspace will need to be written carefully
> > > for these PKI protocols anyways.
> >
> > The common facilities can still be made common. Namely, the interface to
> > take in a pubkey / user-data and the location to pull the report need
> > not have any vendor specificity.
> 
> I can understand the desire to abstract now that there are 2
> datapoints instead of 1, but given that you've said folks aren't keen

s/folks/James/

Jarkko's concern I believe was more associated with my hand-waving about
trusted-keys.

> on this usage of the key system and developers of these drivers are
> also not keen, maybe we should let there be some vendor specifics
> until we have a better idea how this will work with more technologies?
> RISC-V and ARM have attestation facilities coming, and it might be
> hard to shoehorn all their capabilities into this as well.

No, the time to resolve that is now. SEV and TDX are the only ones I
have had the bandwidth to consider right now, but s390 has a thing and
the RISC-V thing seems to be at the point where they are willing to help
out here. This discomfort is the point. Linux has limited chances to
attack technical debt when it comes to ABI, and upstream acceptance is
that forcing function to collaborate.

I think the sysfs proposal is easy to stand up. At the same time I think
it will have challenges similar to the concern that James raised about
Keys becoming a blob transport layer. I.e. I am concerned Greg would
also have concerns with sysfs becoming a blob transport layer especially
if this not a "configure-once / configure-rarely" interface that would
be more amenable to sysfs. That's typical Linux, lets see the patches
and compare the approaches. I might still go the route of, as James
suggests, broaching the subject of Linux Keyring becoming a general
"blob-ring" facility.

Your response about how this might be used for high frequency RPC use
cases tends to bolster what I think Linux Keyring is better suited for
than sysfs. A common ioctl() ABI is a pain to deploy here without it
just unifying a bunch of vendor ioctls behind maybe one chardev which is
not much of a win / recipe for collaboration.

To me the discussion about how this is used and what is the role of Keys
is a useful community discussion. It is still too late to return to
per-vendor corners.
