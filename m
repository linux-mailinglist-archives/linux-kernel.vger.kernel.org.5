Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA9E804498
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbjLECVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjLECVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:21:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5BB109;
        Mon,  4 Dec 2023 18:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701742900; x=1733278900;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=ZSjnQfq7K6rhBCD2wEEDhgvqZf7R+1ag5Zc9XahzaSM=;
  b=D5yLVg3xK84f+6z6oOrIdc3gNPk6ZFh0JkBiGprm29q6tMKEkmL/S03W
   zc9NbeaHZSz1KCcHUmuImoyopqtgw0bAyCilJSoJsjXBMxTIodkx8s948
   MJkn+wG7+ilg7pVjarJ9n1PvUpHKbILm+6iAVB0i5EHLyjEEn5C9jHiP5
   mNJYbGuiAPE6Bfy1mzN2lztgapZB/VQpAsrOllHJ6BthNW5geAyrFC+Ur
   e/2ZlnqiuYVemNMGNBvprniLu0YPDBg1LJYokElndde2L1iXl7FNOMitK
   AhuGbx4kQBe3IByEQXJv9Y9/eyaGklzFYnmdbqAMgjOCz2uZtKvGd/pQG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="705072"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="705072"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 18:21:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="799803110"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="799803110"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 18:21:39 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 18:21:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Dec 2023 18:21:38 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 18:21:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHrM6gYJ7KtnWAdm1H4ecwrBSLppZg9L593zKSEk0d/K8yiKXT+8rmUTxPmquCmwA09L1NJJvAyWHTsLVXVcv4MdeTWk0eoJ/28N/Wcr7an76/MDb0NYAR70FPeKb2XGr3uuSmCsv/200fBkm1XGVvybvQ8xwgAhLQCUUBwdHFR1vLmexMdKSZuGw3mkOg0qsbYBk9m2AjaZLDnc7EYYR9eD1cN0+WTsigF/7HU/UFvIPL+fgO7Anni1WlcdxaHTMwobpbOKiMQwHqdotIYPW4JJMs79vVTfd0AAEugJ6jKvrhO6BQEjbr3YZwvFQcV31fP2H2k7NJui5A3S7W1/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bofKVJCZ0kRhKymFozOw2hdGFSm+tfSYAiqBlRVEaOw=;
 b=NmLZKHRb/Ruc5S2kq5npBTvWdmfntLrfAcJNseEh9jyCmixv2FJVkuQi5ij/ht8m7ERCWIWtLEWMpG2jHEbXelirvN6jKXz8I4ipSWy4GIHicrSdm/vXUr0dGAeLy/FiJ/Inf9zpIG/cPf0xDfV7KZ1pth6qqkx7y0u/MkpYn3JncvMj6KZPxiVqrwErkXjgwUYd/VXBSA1yi/Vam/2Zl8CAmSeX06BM3eU+wcxq24ZNeDFWLROR05lOk5uggTpjn2zGBrD6tNTqh/l71Hp/VHCREsuonfklUv33BS3S/N16C4Oh7Zc6Kn6bGfvij765xYgKTTqKbKtK4RsS4fIkUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 DS0PR11MB7213.namprd11.prod.outlook.com (2603:10b6:8:132::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.33; Tue, 5 Dec 2023 02:21:36 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::32a9:54b8:4253:31d4]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::32a9:54b8:4253:31d4%4]) with mapi id 15.20.7046.027; Tue, 5 Dec 2023
 02:21:36 +0000
Date:   Tue, 5 Dec 2023 09:52:33 +0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex.williamson@redhat.com>,
        <pbonzini@redhat.com>, <seanjc@google.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
        <yi.l.liu@intel.com>
Subject: Re: [RFC PATCH 00/42] Sharing KVM TDP to IOMMU
Message-ID: <ZW6CYYKU7F7wBNj+@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20231202091211.13376-1-yan.y.zhao@intel.com>
 <20231204150800.GD1493156@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231204150800.GD1493156@nvidia.com>
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|DS0PR11MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 031711a7-1cdf-44f8-bb5b-08dbf538e7a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yP4yBsOC0CLny4AMHPdntIIm+r41VpQFviMqR+IR44xkeZY1QaXB6RIMb5iQmmfl6I2gL1OqG4RUf0nvdulJ3BEv/uGavpQanFwEQ72PxjnTK7JHveDFILWaMX+znms3Xm7CPZ8MppTS+vPVVgPwRwaGi0e5PiUJ+lQfot1KtC16j4GviMQ2etVW/Wk29QeGLBH4SRKmZIpR4QvnKWnQ7ORv/S6G6ThPEbOixVjd3PmF69z1G8bNNmxkCbe+yOYMJXanNQ5cgUWelaesx76RlNjWbYGxg1y0p7EzpfVAxqM9V2uJ6lZCbPrS+zcRnpn+jtjqblTiDimmyHEkTPqX9X4u3L3uQjBnhXZbWkOusf4k3Zz7wl7TEf7pQuC3Yh2jpqKCvXzvJemvxTq31EI/Apmu211gEfYxsOPxOdaqAg8RIpSrFd8xoiG9UDHqeyO2R7QqRNeiSvSfC4gadt1BBzdUT3uVlQ8Cn4M6TtIw3JndPbkWuu7vUiReUQaT2ObCHR1zF67osE3Moar4x4UwmDyCP/2UcOVPJlhV5scq2gtTGwH8olQkutppbeFrCDc5Qdw1sbb7SoyXEbeUQOS9LuhcdEdXy6wQ2fc74XHbQQElOIBG3vJ2XNr/jje9mc+8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799012)(451199024)(64100799003)(66556008)(54906003)(66946007)(66476007)(316002)(6916009)(478600001)(6486002)(6666004)(38100700002)(7416002)(3450700001)(5660300002)(41300700001)(2906002)(86362001)(4326008)(8936002)(8676002)(83380400001)(26005)(82960400001)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AQWTuKgLFbzo8o1FqI50Yv+K2HSrnJjaX9W52IZJXM6ITdCnviVbVHC3ucPP?=
 =?us-ascii?Q?zNaNt5VgfwVnESpTcUS27Nh0015pfJqGDqJyWE+ay3xHKazOPP18o50OdhDB?=
 =?us-ascii?Q?aOrKGmGYmQXhzO6uZVEYjL4lm0xz731SeEcl62Ua+pEkp6x23F9r6TM1zdTa?=
 =?us-ascii?Q?gpVf7fRiYN2iwy5bA7u7axdvtqFhmh7cHBrZXcKt4+v8bfHLl9pRRlbYNiJp?=
 =?us-ascii?Q?tvXO259zAkCZXRTy7H2l4NGN7gVoKLpJueTlzegWRoyce+BvIh8jllCCX3HO?=
 =?us-ascii?Q?uwDWeDQJ/4o7gKjYFulMdDarHudJ4wF2uI/e0WWROqxS+URyBW4UUJ8n+4Mx?=
 =?us-ascii?Q?NrFeDsJxyt7gqvvyl5Gd2cS9Zr8NrpcC84o3EGQJbCxmAweAURu91md3BIZA?=
 =?us-ascii?Q?UQ1MonTY1Ev8TxrPWaX+vYVN4N8qoY2gmiE8sRA99xaZWQseE0nxsr6TEgyN?=
 =?us-ascii?Q?O6fGCRuhyZPF3gEzf7T+lfeK2kUoNriMg223/VG3rWptqDoS93VOo04KDQKm?=
 =?us-ascii?Q?ovgK6P6huJkX3HrgeRLgZgk3HbBtQL8aocEZSCVDA7J8NASbgRpkv93UoqFm?=
 =?us-ascii?Q?j8NItB/RsLLvz+k4rgSXboDk6L8CNwlDheJOhMudKk6tsYCbHv4cENnDFVD8?=
 =?us-ascii?Q?OA4ua3ldfdYiK76fRa6El0VyFrXO0rmrWI5134fWtJ+w9nrAfnTMoFVXlGjv?=
 =?us-ascii?Q?p+OT4+Lyf4/LOyXpo99f4MXr8RqmcX43keKaKyEMIDQPvBDHyMb8G3ihjQgY?=
 =?us-ascii?Q?1WNOrueRGDHfdgPJa/q7o0bYA0fdOjgf0iYmGCW659CVCK05rm+fqwOy9e5x?=
 =?us-ascii?Q?M8xXdqQZ1sGDCf3tp5EcnzHHK8QmkDWhCxJLxGyWHjy5RiBFekwT0+KHODs+?=
 =?us-ascii?Q?7FTCgAyWMOHr/TlLeaACfqyMl+vAdLHlYOZ7U6Ib5hDIWuUvJEzQz0ZwzFF1?=
 =?us-ascii?Q?h91Apb3GyxTgInzesIyKvsIT8MIZZlb2A+8sQqErTwOckrPzqhAT40niEr5p?=
 =?us-ascii?Q?FJrt/zZIiiX/F3WSiXZM91N51MqRJvm6cEhucakydI829AdmEIHCersmwKOO?=
 =?us-ascii?Q?KKEUGj674cQEVHt2QQMXMUV78CNA8jVqNLMnudJULYu2xq/60Z4hI9FxtEwq?=
 =?us-ascii?Q?mG+WskwoDNc3n6dsFmBvexx06x6LXcBs5sWYWuC834JWLXfJ5RdLV3txhJeN?=
 =?us-ascii?Q?W8nyS6M/3rZz1mzLevD/nk6HLUGfmGdVidWH+TSyJ7Oly69U8ASwYS+OK1lX?=
 =?us-ascii?Q?6UTzUewmhuhirF9oJGmRdMSgAqjEHdmxRYWGwchYhE2aMEJiMq16yGaf0yk6?=
 =?us-ascii?Q?5HL6vUrNdF/xIsKcqGFowfv1hAo3RV+yVtL8/fAWpn1Lfa+xq1yZkbTcoWtK?=
 =?us-ascii?Q?J+GLmME8oZq1F3k7CxPSwmA87l4gDS65W8Imre2Xj2R8lOwQib68j4b0oCpy?=
 =?us-ascii?Q?fMan8nIREijr2WV32/NMDdwp4CrEOKCQuIfqW6/E7bk90wNnDN/QtHoD/ENW?=
 =?us-ascii?Q?3y7oo1UzXL7SycOjKbe7pWmP2BBR26YYbJbBySSa0fFZHQWtHBOdWCHxBFOl?=
 =?us-ascii?Q?GwHM35fvmh6UYDXKj1WMXwyWag2fpHaLYVsyNhKt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 031711a7-1cdf-44f8-bb5b-08dbf538e7a3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 02:21:35.7856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QB10IGPXDp22D0URuhPyJg/CK03jub47blrHJ8WCkax/X15J/P8Anam5hs96+UyEvIz8OmVZgCVPoKxfk71PSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7213
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

On Mon, Dec 04, 2023 at 11:08:00AM -0400, Jason Gunthorpe wrote:
> On Sat, Dec 02, 2023 at 05:12:11PM +0800, Yan Zhao wrote:
> > In this series, term "exported" is used in place of "shared" to avoid
> > confusion with terminology "shared EPT" in TDX.
> > 
> > The framework contains 3 main objects:
> > 
> > "KVM TDP FD" object - The interface of KVM to export TDP page tables.
> >                       With this object, KVM allows external components to
> >                       access a TDP page table exported by KVM.
> 
> I don't know much about the internals of kvm, but why have this extra
> user visible piece? Isn't there only one "TDP" per kvm fd? Why not
> just use the KVM FD as a handle for the TDP?
As explained in a parallel mail, the reason to introduce KVM TDP FD is to let
KVM know which TDP the user wants to export(share).
And another reason is wrap the exported TDP with its exported ops in a
single structure. So, components outside of KVM can query meta data and
request page fault, register invalidate callback through the exported ops. 

struct kvm_tdp_fd {
        /* Public */
        struct file *file;
        const struct kvm_exported_tdp_ops *ops;

        /* private to KVM */
        struct kvm_exported_tdp *priv;
};
For KVM, it only needs to expose this struct kvm_tdp_fd and two symbols
kvm_tdp_fd_get() and kvm_tdp_fd_put().


> 
> > "IOMMUFD KVM HWPT" object - A proxy connecting KVM TDP FD to IOMMU driver.
> >                             This HWPT has no IOAS associated.
> > 
> > "KVM domain" in IOMMU driver - Stage 2 domain in IOMMU driver whose paging
> >                                structures are managed by KVM.
> >                                Its hardware TLB invalidation requests are
> >                                notified from KVM via IOMMUFD KVM HWPT
> >                                object.
> 
> This seems broadly the right direction
> 
> > - About device which partially supports IOPF
> > 
> >   Many devices claiming PCIe PRS capability actually only tolerate IOPF in
> >   certain paths (e.g. DMA paths for SVM applications, but not for non-SVM
> >   applications or driver data such as ring descriptors). But the PRS
> >   capability doesn't include a bit to tell whether a device 100% tolerates
> >   IOPF in all DMA paths.
> 
> The lack of tolerance for truely DMA pinned guest memory is a
> significant problem for any real deployment, IMHO. I am aware of no
> device that can handle PRI on every single DMA path. :(
DSA actaully can handle PRI on all DMA paths. But it requires driver to turn on
this capability :(

> >   A simple way is to track an allowed list of devices which are known 100%
> >   IOPF-friendly in VFIO. Another option is to extend PCIe spec to allow
> >   device reporting whether it fully or partially supports IOPF in the PRS
> >   capability.
> 
> I think we need something like this.
> 
> > - How to map MSI page on arm platform demands discussions.
> 
> Yes, the recurring problem :(
> 
> Probably the same approach as nesting would work for a hack - map the
> ITS page into the fixed reserved slot and tell the guest not to touch
> it and to identity map it.
Ok. 
