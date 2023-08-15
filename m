Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB8F77D4FA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbjHOVOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbjHOVNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:13:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8E4AB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692134027; x=1723670027;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bcufPEIP3Xdl4Zkom59QUHmtMduFRXkgaNYv2AqWyB4=;
  b=Ff6s38+1qb7w6JRxBv05tMcsI9R1Qut/Mp/qb4yAUo0E9J4P+OXVYLZH
   IjgHV16sh+pah3Udq5hoGIGUQbgg8OK6HrVe8PbGAoEhZYHF0OWWa6CJ4
   ihUieVCokK2jJ2ELOvF6XzlplxFp0YPgXF0xLahd1RHRzRsyLfvjXLmZH
   JiJsJr9M11gDG98dxt7bBxvQkvL5itvdW9aDr8ebE20kUoJD50/w8Yf1Z
   euwvtZGejO1j/jl/6vGeB7gbM1BOEraVG95J11ahiNqnmkow9bLgK9+7Y
   nPSjoDuDao9msV1f861lfwa2q3bnBpnXTIy2tCeOopCuil3aROQaR8WQp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="376111520"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="376111520"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 14:13:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="803958022"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="803958022"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 15 Aug 2023 14:13:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 14:13:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 14:13:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 14:13:46 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 14:13:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQjjnk6eqQRqq7IoHw7F6bt2ZybMrGIAwMnnVzpi9Cfd5BrScueE/qfJFXVg8CNJaJgB0i5lzHS0Buq9iwvsRDpzxntgIxYxgseIQbFCIqzPNkS+utEEvPvsQq0d2mY4BmTWpR+g+gmbS7neTw12t6HZSBlhmEyppV4fCioW9ApQ6DXITTQF0BzYhqcnM88xo+WFMj5FWS0G8QC72G4iLG8TjXP4/xwvAJhKqa6WR0qeTSk0I4c5mLg43CEF9zjwxV85APOQN4L6QizBoFZY5t2jTXrol/UFOAggsB9/R+Zls6Yd+Uut14DRL40qJrTaUBNsIdS12Cj+cXuq7iueig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lvMXSgqZX1TelsGpK02yafWwx9BLynw0tEFqcMAzx4=;
 b=Fd2OTs6XFTwGpByT9QRdm24+pXhT9InkWk6Lfu1TTuhMCztHKJ+gCB1MucnG0jm08T8jQe9kmm/krexzK4QlEQwEq3sY686qv8SK+W/LTSmuTroNVpNuUse++6TtLGRzieexYs2udTESF4DUBiItfwCyqob3kZmXZ048kgl345cyyF6wVtkJU4rq6nqPVOrqMxiaAhrm+TpRZ8UcjeLgLDg/6SCDtu94/WG5v+n/0KT2f+hj8DaNqpX1lW5/VjEPNeHrNqXTiizw5MN7ivZSImLGk4QPPrzFkfEAsqv5zRB9W2eBN6feUHt6QsaT5SCxC5syFzr4F2rTBjn814HMNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8559.namprd11.prod.outlook.com (2603:10b6:408:1e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 21:13:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 21:13:38 +0000
Date:   Tue, 15 Aug 2023 14:13:34 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Peter Gonda <pgonda@google.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        <linux-coco@lists.linux.dev>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] tsm: Attestation Report ABI
Message-ID: <64dbea7e18d6c_47b5729429@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <57f3a05e-8fcd-4656-beea-56bb8365ae64@linux.microsoft.com>
 <64da606b171cc_2138e29484@dwillia2-xfh.jf.intel.com.notmuch>
 <CAMkAt6q1ZedWBQ+ZLmD5QRKc0jcz2nrdwEAw6g8R2fZ5e2ed_A@mail.gmail.com>
 <CAAH4kHYCofTtdjpxKMLO8CMX6kZjQUG69mbbwerwuW0Pk6up9A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAAH4kHYCofTtdjpxKMLO8CMX6kZjQUG69mbbwerwuW0Pk6up9A@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:303:b7::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 401371f7-fddd-4942-617c-08db9dd47e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HpZaAEEhtStf5n9ou2QB7kY91Ooxh/GxwFzaLg0n7QJzqHOht5hG3v9KOpMe4FvrZtSjq46sHdbvXq12zfFWg57b4hhbDhkol/rQNfBrAv8nTlGqEHlWjMyvQ7rqP4syHH0BBMS76fypBywZz53p1kibc/0xpHIYnWfldM3P5esL8cAfyLu2/lktVI1k84x0pdyMd5FhxGLAH7b7e10Scs8YjCJ2fiV4E8vbfX/F9ghV7q9j0f3jg042XTd3f1iyxzXkm1rssLlu/WPRS3WBJwzpnf5TCfiM5WjxJ7TKouKkVl0lYTSvdzieTjlBfYftv4Y0BUUcG4CtHNAJN62iItiNup40fmpr7ydH4PoDQTkLQnTAqyl8JG/aXrzTEjESIkhDYecazcTbuFP+25QrtMTN95KEtriiFJowZx/PYnAIuXpouYp39TZzx5AeYg4TRlAcGSbfZ1KSZmrrwqPJdVSNSqoWOc1i+G1aVx31lSgexbkYqD6aw/dM1bxb4pXWEWHStGobZdPoIQ5ZqWsiL/dZpycCntT9NhPVoCJk2NhfxJlNulzcKkZUbqmB2W5T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(6512007)(110136005)(66556008)(66476007)(2906002)(86362001)(82960400001)(83380400001)(478600001)(6486002)(9686003)(38100700002)(6506007)(41300700001)(5660300002)(8936002)(54906003)(6666004)(316002)(26005)(8676002)(4326008)(66946007)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aZKXpHAJa7G9Uab9yPlgPrBXjfPr0p7aXQvnXXxJ2YupuYTt+MmBj94Rp/8V?=
 =?us-ascii?Q?ilQrqW0Ya/mfHGEfdCgaPfvzbIVhtZ1b11PL0QNO1OgwhllLSFESeaMCUvPr?=
 =?us-ascii?Q?eUickrCn1sMB1HNfqoa8RoL8rp1b73E8q21CA8P9U93SvU//kbYvGaZNIWO1?=
 =?us-ascii?Q?94OS4fgeblnXoTHk+o7saM7I1X6NUd4wRQs+1rd8GO4DihIQrw89K66jTObR?=
 =?us-ascii?Q?0SwZxKC2n5AsceR8KmqCfza0yKdXy11NXNEqMCdQI5RFfUY9h7OcErdHWhdj?=
 =?us-ascii?Q?6hxOAZ9DVAvxceqwqTghvjUdfTKK90ktLB426VhnMhn8P5UFzaOib7vBggUO?=
 =?us-ascii?Q?IYVtNNM/VbMqiTqXgZkQYEtRc0yEotzjbw5edfgFrUdxda0+rzF2aCjYpqui?=
 =?us-ascii?Q?utbAAx4+bxq9Cn+S3Ir8sq61b8IWT/XdTmgVtUeZipRKYcILNFtv2VPC1gsh?=
 =?us-ascii?Q?Oz5E/0m+Bz5dxVodzzonkEqNSgOfMYpHs0YJCJDTK/8chCl6sfROyuTZwpV4?=
 =?us-ascii?Q?FTef/0aYWlrh31VR8PXIvRJ8KN966YMeCj3ECwbYGCUJH3wGKzwgZcgn5rWg?=
 =?us-ascii?Q?SU838zFsYLSFNBTIwmRLu3AlGHMBQIMXw7yP4G3a3m2q4Ihekj4tc333a9wt?=
 =?us-ascii?Q?fNt4oFb0rIGwq0vBNXeImz/GcdiA+J9d2sFkj7DtSgPKvRJPDh5fkGF+oXW1?=
 =?us-ascii?Q?WykrZw8so53VmDb6icI2tNj92U+kr3zoaB1xpdnhbS2FiXU0fJNWXc3uywNZ?=
 =?us-ascii?Q?FtLogOnUJ50vkQmCBy53X25Mc1+m0/zdK7Kz8AuN2DRxd1IeJRpciBv23VbJ?=
 =?us-ascii?Q?aqEP1zdPXig/V9XUej5AcHbSGljgaPC6TmIN2UcIlUE3zo4yvhs0tXzAQVwu?=
 =?us-ascii?Q?B0cA6cs24XqdKyu/v/p02MzlTgRIFdtJZwR9QmjEsZRQQcZUHWL/8FZje9Bh?=
 =?us-ascii?Q?g22ko7u01MUqP7naNFQbop6dqAjvO5ZLWQ8KPyhJT34zvxu/2DPj4ySdmPe4?=
 =?us-ascii?Q?rGR6QabPwI4ysVrPnmrtvgsUl4Ug9zPIG2ovU7tFiIiY6KzMXCY2Rucg1w0V?=
 =?us-ascii?Q?hZW739wv/PGmSXZOWqQFfK1eHbiNb5lYlfxyTBChculQXQiS2mH63Y7AlYqK?=
 =?us-ascii?Q?Pl8ftAbZwUGg+pMR972RtU7NlWjbhSgUWz//kRgR+0OvdVWplpEvbyJ8fDyR?=
 =?us-ascii?Q?HuIRBvVejeq8daWuuc28Nvhx+ylDU9gqb0Cbb3Uu3ZlhV4bCDgXmAcTumidH?=
 =?us-ascii?Q?iGhzXuk0fme5ZG+6HYJOffRSaEQyDDVcav1EJWOJ4QgDnl9yclVKs5M/s1FH?=
 =?us-ascii?Q?dwtZPaDtRGUbgYOX0W6feQqRCCszxdhtHw19xVpsaSJoGUCt0+9lQI9GiTbv?=
 =?us-ascii?Q?pl0stmOqxS2YiIC42rEXZxROdw9BPmERaBj1QWpCf+hqSXDB+Xp7wiQwCwmi?=
 =?us-ascii?Q?x51qtzNEKODvj5FSVnjIKHvkaEfYZxb7svItQKP5B+QsUxK90bIWjg1CYNMS?=
 =?us-ascii?Q?1OQxgE1VssjubcKWZGAve4jTMV4CBIlp+87ycw5p1CKe6fyb/yIlFQlDfnTE?=
 =?us-ascii?Q?yeLXjat72NAu8HHwafh1GfYFSkq/lkgYYgl6A23AFSMfG9FftVQwpLsQUPut?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 401371f7-fddd-4942-617c-08db9dd47e9a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 21:13:38.7001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxyKGjDrD8YUpHy16uNPJM0tCE3wFjzBpK784ZCo/KdLmei3Ze2SMrNe8lR10kLXdqhg5v/kflQidF8W7y1dZP06whQ9/paGA4eAtH2rKYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8559
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dionna Amalie Glaze wrote:
> >
> > Why do we need to be so prescriptive about "boot time" vs "runtime"
> > attestations? A user may wish to attest to several requests as Jeremi
> > notes. And why should users be forced into using a vTPM interface if
> > their usecase doesn't require all the features and complexity of a
> > vTPM? Some users may prefer less overall code within their Trusted
> > Computer Base (TCB) and a TPM emulate is a significant code base.
> >
> 
> I agree, and I was a bit too hasty to acquiesce to sysfs due to the
> TPM argument that really only applies for SEV-SNP without a whole lot
> of extra work for other backends (not to say SVSM isn't itself a whole
> lot of extra work).
> 
> > It seems like you are just reading the SNP spec, if you read the TDX
> > spec you'll see there are RTMRs which can be extended with new data.
> > This leads to a different data in the attestation. Similar there are
> > REMs in the ARM CCA spec.
> >
> 
> I'll add a note here that measurement registers are extensible at any
> point by ring0, and there should be an API for doing so, the way that
> there is for /dev/tpmX.
> 
> It could be /dev/teemr or something to unify TDX, COVE, ARM CCA, and
> potentially a measurement register protocol extension to SEV-SNP's
> SVSM.
> I'm not sure how Intel is going to propose abstracting TCG Canonical
> Event Log measurements to reuse measurement-to-PCR<X> code points in
> the kernel as measurement-to-MR<f(X)>, or whatnot, but each technology
> should have that implementation option to extend their own measurement
> registers (and event log, potentially).
> 
> I (and probably James) object with just saying the PCRs are going to
> xyz-measurement-register for simulating that integrity part of a TPM
> to get just the quote aspect and not the rest of TPM 2.0 to hide
> everything behind the TPM abstraction. It doesn't follow the Tcg spec.
> 
> But I repeat myself. If we use any ioctl, we'll end up multiplexing
> the input per-technology, and at that point we essentially have
> manufacturer-specific devices much to Dan's dismay.

I think the ioctl() question is separate from the question of how to
scale an attestation ABI.

While I am not yet convinced that RTMR deserves an ABI separate from
vTPM (or at least a trusted-keys abstraction to reuse the kernel's
existing PCR ABI for TPM-like facilities) the selection of sysfs
precludes the "RTMR and repeated measurements by multiple containers"
use case. One way to buy time for that future conversation while moving
ahead on this base reporting ABI is to switch from sysfs to configfs.
That would allow for per container submission ABI.

It could be approximated with sysfs by having an instance creation
attribute, but it is more natural to just use mkdir to create more
interfaces that can be bind mounted by per-container if need be.

> Sysfs will certainly not be okay for measurement register-only
> technology, since there's no way to not use a hardware attestation to
> securely track measurement changes past "the static boot" (PCRs 0-7).
> I don't want to have to rely on enclave-like peer VMs that perform the
> TPM behavior.

Understood.
