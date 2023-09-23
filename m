Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449437AC5A7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 00:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjIWWD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 18:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIWWD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 18:03:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AA2180;
        Sat, 23 Sep 2023 15:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695506600; x=1727042600;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dH+9viyyFC5pO7pEK7Ih5LIl5Ai+P8tIRo6CyDAcB+0=;
  b=cCq/DtHFW/llUVe0dRTmfOQGe3eL0Klo6R49gwT1F7OiuYWX5tBmkM+g
   RJjatmp42GdIjEEJxbkx+BPs28AOHVZT1gtZ8x+EmbC3Dm4h/3T14RTP8
   ujzOoPej32J6jZKuepZUsJCSvhZHK0ll45j8NpVlyXnquaUAGXmve5A2Q
   +R1EclGubpBXse9PxjOmPXxMOyFGD93YyV4qygE39EKYuXSjO/gi6dhWA
   i/lF9H16E9DSejtuVMlc2XTIc3zYSYB2i5r8/kK7Kxntn+MHIZSRJcdxf
   aoJ1Rp5Qg7lp0tZAOKD2uc4GI5783URkYUGFcOG4i6zmXR02K9555ijda
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="447540609"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="447540609"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 15:03:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="741489460"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="741489460"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Sep 2023 15:03:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 23 Sep 2023 15:03:19 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 23 Sep 2023 15:03:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sat, 23 Sep 2023 15:03:19 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sat, 23 Sep 2023 15:03:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJitaWMeuMCwFYZltHwisyD98y9EhioD4d8/xUwfM+HqlpBG/bPCp8cM4qgkFZKE4gj/EeXlYs8D9Gb4696eUceGJ9uwZAVTWP+npPxN8oABFyccMcQAgqtJdmPw87452hifCLx9NJm1vmwCmksPS/ALfUR4DumijdEu23wb08IzPsLfXmBUKzdv8vS0c4bWNYCQxgo99XmLRv3D1HcYrY2qqrjPX+bUlZQbJI+0+UXYxJgOFGEN12YGSZabbwh2K6RuO2fPmlcvxlIRtxIwo/Vt5LfNLKnidqTkbWDg/hhP75Sn6OS3B7wroIh9C8jmjyI+ygc8jnzXgk8CsYVfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oW3F1thIYpvVFHmry19WXd/OURtZofso9suE07+qFXE=;
 b=dPslwwdbeC4oqLA5XVc1/WM/Y516bLFj1jeT6uYM3PUemhFrJT/RlqZvEpwtb3qOa+toZ3ctogohcjLlRCh9SX/BJ0yoPgJl71TT7m3Go7W4vOfEKwaEtSP2/qdpsxD19jGS6rTIwV/2ecBfafyY2cZPhC70kA+lmhTRz/CSRgnE9rRBwv08EaEpNNb8ubi2q+mbppLoDgRGbYqmfFJzoBORmbOiXWXI65SWJxs8zOr5W7rqLA85kID+B9keclkGLfh+yXXAkYZm8LPJ5RLDT71raNcL7fLI3JNIWRQSYURAAmJZQr4D4aOLyznpobqmU97LRfvCCpb3+PoWTGZAxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8771.namprd11.prod.outlook.com (2603:10b6:408:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Sat, 23 Sep
 2023 22:03:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6792.026; Sat, 23 Sep 2023
 22:03:17 +0000
Date:   Sat, 23 Sep 2023 15:03:14 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <torvalds@linux-foundation.org>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 6.6-rc3
Message-ID: <650f60a224347_124e92943@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW4PR03CA0228.namprd03.prod.outlook.com
 (2603:10b6:303:b9::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a9e37e-9c77-4d59-a9e5-08dbbc80e3ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h7MjfTZ0bXALfe6xgn0jhUvy4ivNyysyOnhRaK9ZxGAuws3gxwqsZhmWpqm8oevgQwIj7EdJtnQouELb9/TGl+TagQFmXhl3QDN+KsgbBdnV2vQcVme7Tbe6lneEdRLr6pSyTYHA3atXfjxEhnj6Prljk7bsn2xLfkMRBkpFw8boZgOVbReBUt4bS+zVcd1dzH2zohA19GSWHQq5wK3x0ng2qHcW6LRu34VAgf1xUwgyDLupy2kS23p7Qge33XAjv8CbxNC4DdGSB1fiyjGNKUAutbUhjtMDnzE/012/NLFXobxPK/BA1QNHn9KD3ibDl9pY8+WuLLsOkp5Dv45hSsOXvaA5goW/a3fSFEElaDJXsx0nCqgDm/ui9+ggyZKIgAqIRjLflWaNULMxYXes9KZuo1brwRmf2z9cJ0bNICVmOarRC16/WF8nuKH78mR9/OiW3cs/1AI7tZiYdFiZNrLOxen5p1Gz1QEqV8nyCgQgfRANtOSBHTgzFoEs3tRIjd17+0K0mgnJ9+XxXL9BBMIfa1gaqGshFMfDyt26YSG1bFHhn3rhWNaGcOEnWXDl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(366004)(396003)(230922051799003)(451199024)(186009)(1800799009)(6506007)(6486002)(82960400001)(38100700002)(86362001)(66556008)(26005)(2906002)(6666004)(478600001)(6512007)(8676002)(4326008)(83380400001)(5660300002)(9686003)(41300700001)(66946007)(66476007)(316002)(6916009)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wdCWmokgL7TfWl7Ej54LwqtkemoqF/UMl7gwocXbiCLa/c2ts2wHz+cXLGoA?=
 =?us-ascii?Q?zVUOeY/Ci3Sb8gpIzcGJdmzZyN+kyG54lca57XIe/qwsVkiXCzH1Rvexyn2x?=
 =?us-ascii?Q?shF80FaocwDrsXMYxpo8R8Fnkn36RgiWSURhlN76+Hp1qGso9HhX1knTWBoN?=
 =?us-ascii?Q?Gu1rFguNIiyFpyVJraGjsHiVkOBZ8zETACGu92Z53H34lKg9amE97zHfWYZd?=
 =?us-ascii?Q?V8G6sxN4nWKyM/F2JnUCzGCWQ0+C9MGM7onZrvOhtMYGh4oOlc7m0J0xV4vQ?=
 =?us-ascii?Q?9iHNfBPNld7spuiDyv/2KbkhRis9liujpSUUsV6GEIf+sMCBMjTdqtZf1Rlw?=
 =?us-ascii?Q?X3GD4He3gHsRbpDqfPKQTCk9bvIyTp5SspH8uuVgQH0MrcR30cOXWHf4wYkf?=
 =?us-ascii?Q?msDsXAgMQicEOeL8EEpPpprtR8XX/5uAvyVgNInaYZPcvtzMsk3lPT9cNMxq?=
 =?us-ascii?Q?nNQU23xC0uYapjasBm6VLc5ZxGbFtehbw8tdgddSKmSJw70dARGWrE/J0wOU?=
 =?us-ascii?Q?iH7Nj9sM24gZ2gfEtb1tGxc0ptj6597x7+LXbdBTcl8Yqs2tIqhZkoiwBxdk?=
 =?us-ascii?Q?wMUMYdorlK2Av9SEImAdTdF/5h2JFVsgOgTJxKmp+52MKrjhfwSPt9eunbtC?=
 =?us-ascii?Q?MOUfRvFCo7fB92LX+/vRs53TS3Dx88DE9aG3JHmrcjXkrKsDrcEUVKXL6rtN?=
 =?us-ascii?Q?/8ZDat5oGoS1TbDJNrE0fVJZOj2h/4XyZwaNtuQHpUIfRmQvM6zpuufdE0Sz?=
 =?us-ascii?Q?ulC7myiJHLAsb9qmPtba+PcHvTVviu6Gkf5eeGnsC7bRKe9w4AVoqlhhi/V1?=
 =?us-ascii?Q?lrCWGlm0kNDTcv9HyIXwK3GUjpbfzlzdaH3XJwExzeFDS9QSLNzKS6HBn8qM?=
 =?us-ascii?Q?Zm7vyXb8w+eUeQnb3i6maFojJVYcTofXlIcU6EJlAPDXXfmxQaL2D5nxxBxz?=
 =?us-ascii?Q?84rSMf2B/V8bg4aOZAGFNdLY19XfXwNg57Dg6GV5Az48hb9yI4ble0u2Q6dh?=
 =?us-ascii?Q?TK2kqBAA66WPcxHxDvr9e93aWUnUsHPX6OUWf+q7yQctX2ie30P3dsfZltgi?=
 =?us-ascii?Q?pXdbYBlbvHcPVN9D40VsW3ToLqAH742faBz9pKvf+P+YLjJf9Eq2YH+FOCcq?=
 =?us-ascii?Q?zZIvwzEyeou3qVOdGTC1SQbXIBOrKw2zD0NFLNqcisWIceC4ymxl3Zg2Ppet?=
 =?us-ascii?Q?K6MYLiXDXFIwxqj3TEKiXJc+0bHrCr4BB3xQKurbPeHXgTTJ6UrlWidCwVvD?=
 =?us-ascii?Q?zfgNtbUkui3xA3TU5ZXyoufQiJ9QcDlIZ2R22mFmSw0yBSaVEqBDn5jPA4/P?=
 =?us-ascii?Q?RibD9vO7ahT4vsI1nrkVrtV1jkaLvAXM8Mle1guxOvEKyd6hm8kRSEK4yBw2?=
 =?us-ascii?Q?D4A9zHqeKlnVypf3yJ1thAC9rhzTzzOipkcjQS9F/utC0QTkeLd+7AmQOSRN?=
 =?us-ascii?Q?JWkDozBoXw0tZcOa4yyyPFu2SYF1dT22qpecDI7LQNArBQ0LciDxl97PTWSU?=
 =?us-ascii?Q?4wH5tFld1+xOYLSRIaO07SdqFqEnGmpDgH6UgDQyhaexqffQM2cE55gzCvOq?=
 =?us-ascii?Q?UiYyPO8kqBtuAwmuJF9bpqhMsaABF21qBMdtC6UlgdSM+ysGwVt+lhV3DDks?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a9e37e-9c77-4d59-a9e5-08dbbc80e3ef
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 22:03:17.0060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xa+9kVqB3wpmGRBJFq6hXdPS8Eb8saXvD3aCBW9ofjFK/BtNARqJeSG0YBjMACzqdZ+PVzZHhCRzWV1XULdzspSOxUzJShPflTy3vorj3rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8771
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.6-rc3

...to receive a collection of regression fixes, bug fixes, and some
small cleanups.

The regressions arrived in the v6.5 dev cycle and missed the v6.6 merge
window due to my personal absences this cycle. The most important fixes
are for scenarios where the CXL subsystem fails to parse valid region
configurations established by platform firmware. This is important
because agreement between OS and BIOS on the CXL configuration is
fundamental to implementing "OS native" error handling, i.e. address
translation and component failure identification.

Other important fixes are a driver load error when the BIOS lets the
Linux PCI core handle AER events, but not CXL memory errors.

The other fixes in this pull might have end user impact, but for now are
only known to trigger in our test/emulation environment.

Bjorn, has acked the PCI core touches. This has all appeared in -next,
and now I see that 5 days ago Stephen noticed that a Fixes tag has the
wrong format:

  Fixes: ("27b3f8d13830 cxl/region: Program target lists")

  vs:

  Fixes: 27b3f8d13830 ("cxl/region: Program target lists")

...I decided against a late rebase for that. Please pull, or otherwise
let me know if you want the rebase.

---

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.6-rc3

for you to fetch changes up to c66650d29764e228eba40b7a59fdb70fa6567daa:

  cxl/acpi: Annotate struct cxl_cxims_data with __counted_by (2023-09-22 14:31:04 -0700)

----------------------------------------------------------------
cxl fixes for v6.6-rc3

- Fix multiple scenarios where platform firmware defined regions fail to
  be assembled by the CXL core.

- Fix a spurious driver-load failure on platforms that enable OS native
  AER, but not OS native CXL error handling.

- Fix a regression detecting "poison" commands when "security" commands
  are also defined.

- Fix a cxl_test regression with the move to centralize CXL port
  register enumeration in the CXL core.

- Miscellaneous small fixes and cleanups

----------------------------------------------------------------
Alison Schofield (2):
      cxl/region: Match auto-discovered region decoders by HPA range
      cxl/region: Refactor granularity select in cxl_port_setup_targets()

Dan Williams (1):
      cxl/port: Fix cxl_test register enumeration regression

Ira Weiny (1):
      cxl/mbox: Fix CEL logic for poison and security commands

Kees Cook (1):
      cxl/acpi: Annotate struct cxl_cxims_data with __counted_by

Smita Koralahalli (3):
      cxl/pci: Fix appropriate checking for _OSC while handling CXL RAS registers
      PCI/AER: Export pcie_aer_is_native()
      cxl/pci: Replace host_bridge->native_aer with pcie_aer_is_native()

 drivers/cxl/acpi.c         |  4 ++--
 drivers/cxl/core/mbox.c    | 23 ++++++++++++-----------
 drivers/cxl/core/port.c    | 13 +++++++++----
 drivers/cxl/core/region.c  | 41 +++++++++++++++++++++++++++++++----------
 drivers/cxl/pci.c          |  7 +++----
 drivers/pci/pcie/aer.c     |  1 +
 drivers/pci/pcie/portdrv.h |  2 --
 include/linux/aer.h        |  2 ++
 8 files changed, 60 insertions(+), 33 deletions(-)
