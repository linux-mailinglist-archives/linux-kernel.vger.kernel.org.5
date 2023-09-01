Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2CD7900F8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348398AbjIAQwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjIAQv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:51:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5906D10F0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 09:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693587115; x=1725123115;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oOWSg25wdST3qI7x62cpoH9qTQ9MlwdkStEzXxtdatc=;
  b=IEZPW2TzP/jezwmLQaF8sptIuIJKKPDw3UpL+L6OMZ+hpQPTTGFU82r0
   WgnsSZ9Xs7R3mfUsuhRJTgoUEY2gP9i+gulhVI+oYbgBf49bFqwl+SEAn
   ZTvp/8eVTxXw/pBdcKL5JDg/MxxEC30Po0TFpioFz3rV3YFidwcQGPuRn
   bbkHbVEAnSMA8buCpQlX+PnVfit3AoBXS0/Id1pm0VDYEwD2vJ0ui7aNp
   fp2GAUOifEjLTdVSsai/U726ahggueqyJPzlkK6qXWC3MyEYKQu6DEVTF
   Eft1oHem7EuUu8WpGqObxczs67FcnLSviIYlPwA5oxOibna0T0PoA9m+W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="407256311"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="407256311"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 09:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="775066698"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="775066698"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 09:51:49 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 09:51:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 09:51:48 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 09:51:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9BMGgWbdpXvo/4/TvB3eDpG4daNO7Ozr0HaA7k1841hBvij8RwfjJPVwlzcmPYBO/ViDxFAR0/Z6csE+EpXmcX6rjR4jzK5gEmxCRmkM1LalhuoMfWlvVo2lvnAZ6f3cHWe55Rm1eMoYjxKXiiT+ItP5Z26nML5Iq0YYfBcE8KbjDyOtpmtrZbjuX5MggMMGfLEEw+/2OupWceptqWVorNzvpWrlgmeEzbMSYcKBTpH6Kt2FqOR5inPAVDQh4dNtYfXEnjwpDkpDP2YSY70Rry6gV8Y02HSnMKju2kO65MgHjNsCCd9Rz1Frts4d9sxIswOpclHSx4zir3Z3IT4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfVClHOIzckDPo5jVB6Ts7P8sKzw8v/HD0TFqiMrUm4=;
 b=kgHHhcR3GASjSYPs6dqXmwJeazmTrEh+OLHIOpjBb+Pk1xx58ywvTPAT/tZ6dmd4ANpAPs7lUv1RG0dT66si+8BNyUzQGnzMj9BaygfITiLF+aUrYXRiX7YceavdGOu9nvTVkQSEQg/oVJslSaZ3qwJXfPGUG8bulhe1t2lCJiSdvhhdLQ5HzCPsqXTL1qFM5WjUGTGY9yTNEI4AXkLgZPY0T5MUc1JF31Y8iSSPUJm4kmnFX27U5cEP4SPlwQV9BlEKWU820ziX/mq5jD/MeolfaiEap7kUhBk6RCE9zh7CbWgF2cJ+8FZcmcalNfEV46MiElkQ7lIN/4ZPrLbaSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5320.namprd11.prod.outlook.com (2603:10b6:208:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.26; Fri, 1 Sep
 2023 16:51:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6745.020; Fri, 1 Sep 2023
 16:51:46 +0000
Date:   Fri, 1 Sep 2023 09:51:42 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-coco@lists.linux.dev>
CC:     Brijesh Singh <brijesh.singh@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Samuel Ortiz <sameo@rivosinc.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <lukas@wunner.de>
Subject: Re: [PATCH v3 0/5] configfs-tsm: Attestation Report ABI
Message-ID: <64f2169e5c381_4c1f329451@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
 <080d834d-9ca0-437f-8f18-b7a311af0060@linux.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <080d834d-9ca0-437f-8f18-b7a311af0060@linux.microsoft.com>
X-ClientProxiedBy: MW3PR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:303:2a::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5320:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb999af-00d4-448c-ca75-08dbab0bba3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rkwgf8qgrI3QrOs+7M46egMalBoDqfrNEZBmoLFoSLmmoVj9CsotTGmtmO96BGRVa/gLUy2yKb75VJCKcc9SBMa0X3nmXifFS3t2A6DMDpS8/bARqsdFOtHspNbkSYvjylHRGMyX096z1DKsMzbJE71FuogeZRWk7tqQOM82KTTdYXlMCCAhP9562ZNGjRIUiqTcrh2dllq1PtMOeDx9FoF5rcs0pgz+75a1ziBdbftlcopxrDaFpZHIM0mF2x9AWnp4XWRd0U53qrXbefq2611v94bCdi6tWCKe13ax3eNNJ/h1hQ2fehLEvFbKGz6sBM/wvoNc7Dn53LqVmwK4kuBF2eAXSP1dP88+oZUh4+2aHMi3FTGYKl0KB1UJkRusWdaXOBlX61s67We22yhnc8kPfEsFfjb0hn1VCJQv9CvqLlzNzjHQKiF7F+IB2ghs891rJnItmKiORev6AAHYCWLv1YQ/9ppArBG+ts3ZEEWjN5lBL9JM/0BWRS4OuANRHAXzMC8mzeRx1iRigHTRsRzdIqMw5jfVoaVFjrePaPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(366004)(136003)(1800799009)(451199024)(186009)(6486002)(6506007)(9686003)(6666004)(6512007)(966005)(478600001)(83380400001)(26005)(2906002)(7416002)(66556008)(66476007)(54906003)(316002)(41300700001)(66946007)(5660300002)(110136005)(8676002)(8936002)(4326008)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ca97/sxk6njNDfga7x9F8r6gYNpxMSmS4ANHR+Mxh3JPmQuBVnW7cRMrQ7cR?=
 =?us-ascii?Q?30cKNWb/zwdB3q/rlyYPAQHis1UA+Hs1pkU1HW1lJLSL2Vo9BM9GAyZ51nFw?=
 =?us-ascii?Q?rZBd1Ze5SQuePZ7zOnzhtHDf2YDi4IImG67fyYNdlKvlYNN5ce95nY9GNuMt?=
 =?us-ascii?Q?Nrq2T0HNp1QmTYsCUYPt2pZScdrIIKipBb6WqmHjLoDDECoQ6+VH/HRxb8Bs?=
 =?us-ascii?Q?CFLIpEOXzSGMT5slz++fMFyxeorsXtxE/MXI16GhJeEtThBmME0ScmFa5s/c?=
 =?us-ascii?Q?pRdJdZobVmR+aybwnvN//kBTtpJrMEw1dYhPg1ttGHtJWT2MoDGcRHxwqlSm?=
 =?us-ascii?Q?vxBZvabap+qbgAeicIe9eMVxO8m1NcDLA5ytvpnAZXi/dm2lPK9s6Vs8PaOh?=
 =?us-ascii?Q?0xyynQjY6gor4jlcgtHwZj0W9ppq3OyirA6KayGWwIL1/n+9CiVYyIQFt/D8?=
 =?us-ascii?Q?qleUyOAU2Kic9b3IdGi46mkZfvB0c5J9D8BjlAYIQUHYe2rd1JiuQjOTXTY2?=
 =?us-ascii?Q?LR/ZG5DIrqBIUjGZJN13lxMvAxMV0G+OjXAdRKtyUt0eM5CI0rJat2seUhbB?=
 =?us-ascii?Q?sOMl1ZER2U9Dl1D+Y/evw0RwnhTqgyP6Dyz0i9zsWND3CD9vE76omHrQvG6t?=
 =?us-ascii?Q?zAybzdHhPlYNCqkD4RjoZSJs7SJcxTUcwHG3L+Bnl/4De9cwe5V7vk+NJXHy?=
 =?us-ascii?Q?qeSx2eM2awX/QM05USEKDGG38EWt/fsTJXoX16ubplC3O3px4xuKg+pLjf3v?=
 =?us-ascii?Q?HgBre801taXtwsCVojR/e+fpcjwky8e9SdgBV9Zqyzh3yG4k+1oPw/9BHTbC?=
 =?us-ascii?Q?DxIfoe+eaIGglDcGPmnMzi4GXv7kML1f8l/ah+o9/xJ3ndcH15gPyZVPSXfW?=
 =?us-ascii?Q?2OS/WqoiAdJcOBAxC4Dh1EJin14OSTXv5VStqEuN5SojiC0cRuemrLSesCpK?=
 =?us-ascii?Q?9clAOWfEQogjOIyJS5nLNYx+vuS7FdaCoM0SEkZ4+9JTazg5SUUphLktPya0?=
 =?us-ascii?Q?mGCh8TaieHxDBG5pBkq6B3xrjZKpohJGnQeYHJgWgBUx6UAVfhIwCePQJw2a?=
 =?us-ascii?Q?sY+jskiTInPE5dZh8v2vUZ5WkX0G1aUjl5FDV2jdoH1g513x/mg+i9xGUBVn?=
 =?us-ascii?Q?nKWCuJmK3Vy4eDx4PieBimQdW/BQwG+fLPzwMGiWLzKAYNH9X/YnvEC8Imh+?=
 =?us-ascii?Q?jK7Jdrxj2Nw0W6feR7hui985Pz/uvVH4NTvmHGQcnEkMDLUh+xdYzYtxvJIo?=
 =?us-ascii?Q?9KMwQDn3YWfb+eqbzk3SpuE6u1s4QD1WlcPJ03OgZY/xfcmfXcSL9bTKyJ5v?=
 =?us-ascii?Q?dkzY9ymMsYniBI+iLjcUQPoXef1Ng+Xtqg9MC+cEvvBD9ZjjYdGwh1caD8UM?=
 =?us-ascii?Q?b2IIz/f5Fd1LDduso3CUPb+MW1XCVr4RsBs9vhHlGYEYx73PazB52WCYvVnn?=
 =?us-ascii?Q?ZS9mrM7iYU3RdUZxNhaHmVm5Q45IkmromJld/9P/WVvwgArgOtGdvWVo0YUF?=
 =?us-ascii?Q?PkT6ZGGCGpz8EjhyH0Uc4ZQsoBIdvIhZ9VmGwoDWU4c+KXxIxeWX7C3Etdy7?=
 =?us-ascii?Q?/H/xy3vgalL5QOVBa0ZxWEY76+ex/RgeNI7bHGEbZk/Vdqwhv9gXoPJ53X/T?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb999af-00d4-448c-ca75-08dbab0bba3c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 16:51:46.2208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0i1k//yndDiXCITSV+tYTaYWNiEBRpe2S0ASSr8LkYcBNR1SnwIu2PKX90+m8Rl+7FFjXM0h5yTet4LJmlF9Lh+IrcSdIHSdXoajNShaDZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5320
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Add Lukas since 'SPDM' was mentioned ]

Jeremi Piotrowski wrote:
[..]
> > An attestation report is signed evidence of how a Trusted Virtual
> > Machine (TVM) was launched and its current state. A verifying party uses
> > the report to make judgements of the confidentiality and integrity of
> > that execution environment. Upon successful attestation the verifying
> > party may, for example, proceed to deploy secrets to the TVM to carry
> > out a workload. Multiple confidential computing platforms share this
> > similar flow.
> 
> Besides the platform (cpu) attestation report, there are also attestation
> reports from individual secure PCIe devices that we'd want to fetch. This
> uses the SPDM protocol[1]. There is a CHALLENGE command which (too me)
> roughly maps to an attestation request, but also separate interfaces to
> fetch individual measurements and certificates (like the SNP extended
> report interface allows).

Yes, but I am not yet convinced this configfs-tsm interface would get
involved there.

> 
> If this is to become the one attestation interface then we'll need to
> consider that. That will probably require adding a second level
> directory: /sys/kernel/config/tsm/<device path>.

The SPDM situation is different in my mind in that the kernel has an
interest in being able to attest a device itself. Think of cases like
power management where userspace is frozen, but the kernel needs to
validate the device in the resume flow.

For TVMs the kernel would validate devices and the verifying party would
validate the kernel as part of the guest measurement.

The main difficulty again here is evidence format differentiation. My
hope is that there is some standardization or otherwise a way to update
the kernel's verification logic for per-device evidence-formats.  Maybe
eBPF has a role to play in that story, but that's a converstation for a
different patch set.

> 
> [1]: https://www.dmtf.org/sites/default/files/standards/documents/DSP2058_1.0.0_1.pdf


