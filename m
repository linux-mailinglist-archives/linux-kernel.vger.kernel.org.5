Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF8C7DFD68
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 01:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjKCAET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 20:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjKCAES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 20:04:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55611136
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 17:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698969852; x=1730505852;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8oz519b71WL2j80+J1pAHK6BPOwsbWu5LprxMYa+0IU=;
  b=cibxEeDhB49ktBavCv0jIQMEjAuDbNxIOVl7Z+j+EXtXn0TZTbq68Pt4
   SDDIemuKBbSgggkWNOCUakzPpWRUDfp02YFVUCPWzrSLkIkTi3uxXpyQv
   PnMgwmOqhiUQed2W0iKu8hM3MetSNj2tKspFcZMhViuPoi9DX4YjdlkW9
   Tv9ykFjPXRQN2u671zS3s9wBczJf94xxCElmzHP05yuGE/yjZn1zVaLgH
   7Ss2gx4YipkQlQzd3eAIxgW7GfH0glyNYoZizXbzDgewQlhKFo6GwPDZp
   7K2Mepj8DKWyktWEQIVVCS7diYxGVIx+/Q5YSuaiYSblkby3c59onyUL6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="392728083"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="392728083"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 17:04:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="9186022"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 17:04:11 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 17:04:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 17:04:11 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 17:04:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltfLJyONSQ/SiREXVXBOa97HEtIN+3hev2PeyQ7qRwq7O0hXGZrkFBCkbmVsDqhYqm8/fAUlwTfzaF8N41JEVbCztHFJCXrGU9LI0DPR20CPml/K09ytzT1R3OdYwA4zl4a8SfMVhLRt2ySoK6YT1GyEX2WRIIOvHePOsQtdDTIwnBOM4kIHEfL1Q122oGUM3hy2+KDDjfiHtALE+HnCcF7sE3Bza92teY5S0g3+kgrddppqaxMrJlHTSodvtBeSy+6CEjd0swTgqvTbS5R0cSgQ+k5GjkuOA16ChVzZ5tLAxf24WcxY6q4pRpvi2jB//GMLIR+jBR2MGsz9Ycw+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGXD6BIZI5JGNRgkmRCXkqHZu5ZMrbIm5BsQ5Uo3jME=;
 b=aRCRzCT8+Fhhs/DQRrq97Ez4s1WksOVx3gxmYEKgdVhSCeVAMzppZgDTJjnD3sp/HWguSvK8BB1tPZhVMs3AyujS/Q8llxxG58fdgJiQvbx2JMG9C8xLi5RY3VrpHO+c5FSQS9ct0w9LIhwj6S4ekgmdsoYzLxCgR/SA0eDe+fS1EoIHBUScygwh8t9M/oVSGm07U8nJN8d6PwM3A5tEcYG3rDB284reD2CQrkQ7ujd1+kPHiPBgu1I5wN33yXXxKKxKE7+kCINL2mHMShzNOcNlUVhpku3qoLZ4S308KcIae+VJUloyHudzy8aEty6UB5FTs3+gZoCXmvi8nYIeSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7502.namprd11.prod.outlook.com (2603:10b6:a03:4d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 00:04:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 00:04:08 +0000
Date:   Thu, 2 Nov 2023 17:04:04 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <torvalds@linux-foundation.org>
CC:     <linux-coco@lists.linux.dev>, Erdem Aktas <erdemaktas@google.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        Peter Gonda <pgonda@google.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        "Jeremi Piotrowski" <jpiotrowski@linux.microsoft.com>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Alexey Kardashevskiy <aik@amd.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] configs-tsm: Unified attestation report ABI for v6.7
Message-ID: <654438f4ca604_3f6029413@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW4PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:303:dc::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: d241dc2c-95e0-4043-cdbd-08dbdc00661e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mt57TedJzphk+rLKrIHhEQ8ok4eGsPoADF+ed6vxwSOSHVDlBeHJJLhz/LmbIM2PXMpESzWnSuOCbCKna4mzMmdZhXtVkFSAFCn8GhXHAksCvApFWDXcB9F8lyjfMpdXD0zAJ+SLvuEbd3OpXV0iD0hkdh8Y++ojLMCqKDfs9v7GkWrLvFVt1eOOoA/fpHjzxyb7IHYRonsTtlV45oQkHi0uuNMeirlFFLO2Nh7gePxcyO///NZD4B4LcMehALp6C/J+BJRVBAGSLIQRQnoHWaYWv/Bn8/eS1+oC3dEMKqlNBm2ql3PIAB2NqfKENPWzA9DRamzWnudyVlNnq51z73ZsgJbcNCiDWPEfA8AAigRmGJyAWr1jHKdsG4KLKEQpz/HGu1D3PqkKlnzDyb3IURVCc5ySVglnC8KwNWoKCxz//+R5OCcN7/qdeC1Hqp2Z/c8MQKlih6PUYF1sWUtkipRx9FRh35W9EGbs2q1wTEniFE4WrGdLmxhtf5Pj9NeLM1GDHpjtE8vwS0B4yOjWqsJyAjNENb6072l0I4cY3RlgJgA4grN1n7JNynTKcVcN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(7416002)(5660300002)(4326008)(41300700001)(66476007)(54906003)(6916009)(66946007)(66556008)(316002)(8936002)(66899024)(6486002)(2906002)(478600001)(4001150100001)(8676002)(6666004)(9686003)(6512007)(83380400001)(6506007)(26005)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HrhboMePE1JN606yaSnOKQQ0xmjRmljtvtqkWjNL8WZnbzLWcuII12EX5VAv?=
 =?us-ascii?Q?58hZIcnmPh1L0CtSjfyNLUkSV70W6Wq3phpDzF78ch40ex+GYrIIX8fwSvCh?=
 =?us-ascii?Q?2FqiHjHF39g39DCIFVkuD8OtpThaq3VqHtU2H2lPUt4iojcxP1NmDTn+R2yU?=
 =?us-ascii?Q?oXfwu7krz/4mK6Ada1Bg2947NUo2hYeIdcrW9hYvlyxdLO4o+GAvbES6YasM?=
 =?us-ascii?Q?WAUqJ9h9gFlRYKSPkWln0FogCshCiAZBIRtIWfbxpo4VmAQuRFhmubywUtCT?=
 =?us-ascii?Q?L/LqUNMFXYSnuuSbHnUqpjHBiOhnAutM8Vom32sE1uybMcmoXT5u+4jq0LOn?=
 =?us-ascii?Q?nNe478EeNpKPfzhpA28cl5nso9oj+AC5mtoZD6e+vd307cD0tF9Wv6rRJk55?=
 =?us-ascii?Q?bPDtN3ApYutMSeBVI1hYMVVK5miSImjxXIu0ZvfGzsBdUYaGmdodH+DMu8c3?=
 =?us-ascii?Q?nXS5MFBACKXL+jeaAagQMR3juX4xy4AUevPLxru/jJeYNy74jEzMpXlD2V/d?=
 =?us-ascii?Q?srgdNxyf7ni4vSHh50dVNnX1Gj1JoWH0N7NeHurLcigLrKRl+knYswX6s9z6?=
 =?us-ascii?Q?+WkrEKa32EtxIVVgY6f94YCxkktpMGpCTUoht2ECzqKWs6daWiMinHz3e8Kz?=
 =?us-ascii?Q?ova51AX7MTGeqkNvBj3OLsWBPZHTXysriK+OvzvFF+I/8BDknpUx/l+n8Wty?=
 =?us-ascii?Q?n3y6+eu7NbYWmHKm3Hpciga0bPTQSeHZp7e64yJFr3QvZUJAo/fDEWVlMF4a?=
 =?us-ascii?Q?o0ThSk3ztOy7rMplh57a+rOPtH99Fj6W39FW6UWZA3Ko7sX8Gkhb73wcS42L?=
 =?us-ascii?Q?xbH1DN1vzxJgrfD3XZbFydoNKALPcQ20wauHpN4/uWqRx2cuSvuLYRdC13+v?=
 =?us-ascii?Q?+oFe2zfHEFP5E7rwyuBIUgFN8IN+v4RlklwrzhBa+V+JMzyYSS4SszLxXXK2?=
 =?us-ascii?Q?3QJK7dMPCOo33neMBEwr9rmxcs/CTyHTjyoFF+4Zb1JhDmL1q9FZiMmjYZYY?=
 =?us-ascii?Q?XJ82KFVJWg0aL/Im4OpCH2/y5DNNbtuboNinfuxWxe8ZSuAXOwmcFabGWIan?=
 =?us-ascii?Q?L0DU5qtl0ZEkm5hAi/8+zW6YogpSEdw7Th1JflfU/EUOV8WLkn9qT0zn1Rf8?=
 =?us-ascii?Q?ERGHHvUYzRXDZ8X4OJqfP/oLcAz1UxRX72HZX2B1Qb7rIAsPCxgeEBiRj93n?=
 =?us-ascii?Q?NQPi4JfZllouVsntNfOHV5kVrZxcn13QZ2aDSJvQBh8zUbQK8Q9SMLehBogI?=
 =?us-ascii?Q?61+4CR5bBy45iyBJ45hAzas/2UF6hSz7bgWeNJh1n3pMKAs+vOGC1efOWEzw?=
 =?us-ascii?Q?5piY9cHKWtw+5kbGFpuDvtknjs/b8NTgYU2Mipqrk6z6cvuweU86cV/1QjYs?=
 =?us-ascii?Q?xEXI4T/cT7mFdIauFfTudX0dFzZrBQiWke+xAkoQrFQp9M2KVq/7yalJWf+n?=
 =?us-ascii?Q?y0XgDHbbmgOkNDO5TRB9u3dz5ZwU3vtXRYfDPY6KjKS/l81VroGWHZzAIrZs?=
 =?us-ascii?Q?iqwH5T9zc7mF9gb7rcjshoGyaO2YFmXCjroaGWPzDwnjb17K5yUxacLecqSd?=
 =?us-ascii?Q?jqrMWb2bBGALk8SMqnev0NwpnO0YNg1H1J8Th/kDlu0oWbiJxwxcv5N5E+oZ?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d241dc2c-95e0-4043-cdbd-08dbdc00661e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 00:04:07.6621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XExMbg1KqkpAZIRtpMkC4Q2OlOceyMoGqQu/IHNKOlyyKq70flhJXKQ1dhdOZYbV1LC+TdipyGFqc0tmqHQSiP8nkMIBX/F+Um+0CufvLHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7502
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/djbw/linux tags/tsm-for-6.7

...to receive a cross-vendor mechanism for retrieving
confidential-computing attestation reports. This is coming from me
because I originated the proposal and there is no clear pre-existing
upstream path for cross-vendor confidential-computing device driver
infrastructure. I.e. it is not cleanly tip.git material, but it does
have acks from x86 maintainers, AMD devs, Intel devs, and Google devs
(who hold a near term interest in consuming it). It has appeared in
-next with no reported issues.

As for what this is...

In an ideal world there would be a cross-vendor standard attestation
report format for confidential guests along with a common device
definition to act as the transport.

In the real world the situation ended up with multiple platform vendors
inventing their own attestation report formats with the SEV-SNP
implementation being a first mover to define a custom sev-guest
character device and corresponding ioctl(). Later, this configfs-tsm
proposal intercepted an attempt to add a tdx-guest character device and
a corresponding new ioctl(). It also anticipated ARM and RISC-V showing
up with more chardevs and more ioctls().

The proposal takes for granted that Linux tolerates the vendor report
format differentiation until a standard arrives. From talking with folks
involved, it sounds like that standardization work is unlikely to
resolve anytime soon. It also takes the position that kernfs ABIs are
easier to maintain than ioctl(). The result is a shared configfs
mechanism to return per-vendor report-blobs with the option to later
support a standard when that arrives.

Part of the goal here also is to get the community into the
"uncomfortable, but beneficial to the long term maintainability of the
kernel" state of talking to each other about their differentiation and
opportunities to collaborate. Think of this like the device-driver
equivalent of the common memory-management infrastructure for
confidential-computing being built up in KVM.

As for establishing an "upstream path for cross-vendor
confidential-computing device driver infrastructure" this is something I
want to discuss at Plumbers. At present, the multiple vendor proposals
for assigning devices to confidential computing VMs likely needs a new
dedicated repository and maintainer team, but that is a discussion for
v6.8.

For now, Greg and Thomas have acked this approach and this is passing is
AMD, Intel, and Google tests.

---

The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djbw/linux tags/tsm-for-6.7

for you to fetch changes up to f4738f56d1dc62aaba69b33702a5ab098f1b8c63:

  virt: tdx-guest: Add Quote generation support using TSM_REPORTS (2023-10-19 18:12:00 -0700)

----------------------------------------------------------------
configfs-tsm for v6.7

- Introduce configfs-tsm as a shared ABI for confidential computing
  attestation reports

- Convert sev-guest to additionally support configfs-tsm alongside its
  vendor specific ioctl()

- Added signed attestation report retrieval to the tdx-guest driver
  forgoing a new vendor specific ioctl()

- Misc. cleanups and a new __free() annotation for kvfree()

----------------------------------------------------------------
Dan Williams (6):
      virt: sevguest: Fix passing a stack buffer as a scatterlist target
      virt: coco: Add a coco/Makefile and coco/Kconfig
      configfs-tsm: Introduce a shared ABI for attestation reports
      virt: sevguest: Prep for kernel internal get_ext_report()
      mm/slab: Add __free() support for kvfree
      virt: sevguest: Add TSM_REPORTS support for SNP_GET_EXT_REPORT

Kuppuswamy Sathyanarayanan (1):
      virt: tdx-guest: Add Quote generation support using TSM_REPORTS

 Documentation/ABI/testing/configfs-tsm  |  82 ++++++
 MAINTAINERS                             |   8 +
 arch/x86/coco/tdx/tdx.c                 |  21 ++
 arch/x86/include/asm/shared/tdx.h       |   1 +
 arch/x86/include/asm/tdx.h              |   2 +
 drivers/virt/Kconfig                    |   6 +-
 drivers/virt/Makefile                   |   4 +-
 drivers/virt/coco/Kconfig               |  14 ++
 drivers/virt/coco/Makefile              |   8 +
 drivers/virt/coco/sev-guest/Kconfig     |   1 +
 drivers/virt/coco/sev-guest/sev-guest.c | 214 ++++++++++++++--
 drivers/virt/coco/tdx-guest/Kconfig     |   1 +
 drivers/virt/coco/tdx-guest/tdx-guest.c | 229 ++++++++++++++++-
 drivers/virt/coco/tsm.c                 | 425 ++++++++++++++++++++++++++++++++
 include/linux/slab.h                    |   2 +
 include/linux/tsm.h                     |  69 ++++++
 include/uapi/linux/psp-sev.h            |   1 +
 include/uapi/linux/sev-guest.h          |   4 +-
 18 files changed, 1055 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/ABI/testing/configfs-tsm
 create mode 100644 drivers/virt/coco/Kconfig
 create mode 100644 drivers/virt/coco/Makefile
 create mode 100644 drivers/virt/coco/tsm.c
 create mode 100644 include/linux/tsm.h
