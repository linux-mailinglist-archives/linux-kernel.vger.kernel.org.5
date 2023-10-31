Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E625A7DD500
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376319AbjJaRqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376342AbjJaRqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:46:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAD4B4;
        Tue, 31 Oct 2023 10:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698774371; x=1730310371;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w0OByK5Bium3VnHjwIcbATSneqBzQyWbdBLOrrMB6rg=;
  b=mZ6rx5xpd2iPwt3pfO/OkeyWjPbxuFDM2fEZpme9WkLHjJUnxxXL35q9
   qjyncoxUmG5w0GHG/aGfw8uJboXeHdNqmp0YBKtarN9Av5g0dCp+/2dvL
   pMUD5ljmPWqTsn5x265oznswD099Vx0ac9LKzyCnXnvHLb3CwfCnvLgqZ
   Ir0uvOwwj1dbCexnDPyzwtdXCfq9/O1IDeBSfQSw3T6wfam08ulknHmaJ
   CqczE2dEY87yOBmLef8itMjog2qnGz109sdliIkLVsj16xq3Ms8PZw0ti
   kt5z1reDvwLZFcFH4WLpP8j0oKj20cUJX4/Rj9h3Pf6SFJfgFO7astc//
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="373390560"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="373390560"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 10:46:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="884285316"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="884285316"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 10:46:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 10:46:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 10:46:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 10:46:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmMEwzSisNaZxygbORgSOLn5qcdOJ0kXhQKgx02iLAhufRGS7klLb9htVQ6qHngclJM1ODSRHo7gu/z8+w4Xpygr8V+oO/xHi+oClgE1fzTzcsIYlu9c5REVQ+et2t4wfRXwI/VwyCE8o1W5XTRFwOjyTwtuo/RaxXGlmBN35z33Tae8LrX7knIMKFai8+Ja7/1q5SKNlFmYsNgnIwuxCoo7pNTrKMuZke9cTwvHlpXtH3XEV2niPmip47df7Vc6hQGdcc8e5k21J50hgLDmpZqbky29Ih4KoeTTOrIZ+0E9/3yh5IXq8SSncInDurEjOUCfrmsP9AsDReJjfSBW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMXGRPXgfOBTW1fmPfde63v5+kakgcmMeN5jdfKtMdw=;
 b=kvTwWsexXXc1gxEE6eLMTvUVHFQw2LUaKdGkPnVG+NsMm0Zl1X13NVDasc1+qZS1XV6IaVwO5IXC/Y25XoLF92+Jf//M8Fb50N1UnDxIeRySDN/rYGlhhnKzA55cmtx8TthYbQ9pVWk2CDoF7l9rVeYqwqaux4maapPBR6h649OP6vlV2IpLgF4yI3YMipRSSe36YwVP28g/EjiyhCYU1OpcswGden+i55mo5m+Tjrcd/jlBjjxS7BJcbGCRxWR3gbR3T7VpEnYgcRE/oBgs7mA7eSMAcv2/SisA+f39xSVtyyaH8v/HeEpHg071ylVfnWnFAtzBcIYXPE1BHekiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8162.namprd11.prod.outlook.com (2603:10b6:8:166::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 17:46:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6933.026; Tue, 31 Oct 2023
 17:46:05 +0000
Date:   Tue, 31 Oct 2023 10:46:02 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: linux-next: Tree for Oct 30 [drivers/cxl/core/cxl_core.ko]
Message-ID: <65413d5ae720c_244c782942a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231030163344.5a39a625@canb.auug.org.au>
 <dc312544-6070-4299-b9ee-903b34d7cf21@infradead.org>
 <e3e9bcc3-e026-43d3-964c-5f5b51916782@leemhuis.info>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e3e9bcc3-e026-43d3-964c-5f5b51916782@leemhuis.info>
X-ClientProxiedBy: MW4P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: ae870514-3dcd-4872-11b4-08dbda3941b9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1PNfRkr04G2fuuXl5PnMZfv2vP+534rEIxhXevsiaYf74QvOEgNWb8rn/hK7nX09vbBkfZgrcPRt+Gv220vjyNsBKzVjzTH7iKDg+OM+1dpJJWUv+pJlQmh3/0bCPoStG53N226fG1bxg44GLD3sqKup7hm8VFNqPXdi0UcWxIDOKukA2kx4ZzTItMAM1I/IDKkRCeZZ+ecj/evA0Sd82z2keQv8N/5YUfbJFMBOJS0QJtDokdU1/RS0QnXBol2PxiJiqTtgvPSVw2AVPSfkjhbAs7AkiJ/sJuYDwVOrKhbvYfPdfdbnMBrIDA7b6QSLpAfT3WorHa+Qv8yeXBV8kvq/VaxsQsQJP74ELsBO7fPAJKYHLlPOaardNLpSN4ppUg/1l9EPmfyG5VU9Uq6cbTGJ9+rUZLiRc4hHdwpKaATQbtmfqtUINFajR5BJ/ur30Xqi8t6huD/muMUZY3hdgqbXjHOjwd6Pt7N4VW6OGf9tp8K6EueeKdnLTKuXzTssAy0bZCF3l92B+V5mi6vP8kGCwecmEKDigXFDxS8K1mzrKpOiIOG31A4wLTkooAy+fa+mOZ8MeCdx2iVdDsZidw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(41300700001)(6506007)(53546011)(6666004)(6512007)(9686003)(966005)(6486002)(478600001)(26005)(2906002)(66476007)(66946007)(110136005)(4326008)(8676002)(8936002)(316002)(5660300002)(86362001)(38100700002)(82960400001)(66556008)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?31gXISXVnFu9cOHbNCiXk3k8GYQkKdvhRPC2USZVcY6LyDfkV5EQvT1tFZxK?=
 =?us-ascii?Q?0IelxKy2YsmAZJd1QwjoL3/oNhbHSmn2Gb+6MmEFLIPli6L4PVhTrPoO7wQE?=
 =?us-ascii?Q?0EZctwNOjnaCYbbrrCIKqRILLtO0zChS7lKMrupXahGjI5hE7un9+hfECz5S?=
 =?us-ascii?Q?u4GFSD3jgBFp/hydctctZo8yb8wZBUIWhpqPr2A1LVlnB6pZPNZtFX7gOoAW?=
 =?us-ascii?Q?2lC3KV7pcidoCgl4cbuQpJO/oEfBhdpgFddmk5TobSfHEq1RQ1CT3vwSLlLN?=
 =?us-ascii?Q?gwfwADBylx3ZWnlGH8GvO8sO3sEr7q5uTdjlt3arbpMwH5aCL3wjuRF1eQ7e?=
 =?us-ascii?Q?CeWihK8/IDCMm2GQ4pIdJJzMFJY3iymgWeckxUv323ApNrDcr5Qk24b6CUfn?=
 =?us-ascii?Q?X9QvAPG4XcrVCSLmNhlhtQFX5XXKcF5OGvo7bYhW/v6K+nnWTdsGx08BOZmg?=
 =?us-ascii?Q?iBJq6iNePTEEeURy4dqZZWLoBr8V6xc9mInfb7RivDNPQGR2PSuVWZeV7GbP?=
 =?us-ascii?Q?tdGikrDqLpIO+UM/uZ9Lwhug23RZuerCYytIuaMDZSth9AXc3OEqKO46KSrx?=
 =?us-ascii?Q?p3dRKHvuoNb84Wc4xAiupt5CVp2RBmzhJJmWKSoqb79AsJCMqtug9M1kUeJq?=
 =?us-ascii?Q?CrYX68C0fixo/vF69pnWiWdOPPgXoLHd0Dsne15vh1URZz8fRjIfSF3HZZC4?=
 =?us-ascii?Q?5iWvh+DcFKfnJ1Zlw467y2VKzOjjUqGTGL9MZ1xfr2AXS7YiubIi7o0Q+FuK?=
 =?us-ascii?Q?tHSb1liprnAWNo1CWpFvPoBJCA8KYIUgjlNou9FMbHVO1CbxkL1rne4Y1leS?=
 =?us-ascii?Q?l3tBA7uzlMrC4J2GyU3BkC9HPhXJQD1epu/ZWuVmX6YEtsI9iKnKnCfVagHB?=
 =?us-ascii?Q?aIhV/GgSQ8VF+820n2Ccqx+pDQuXwuwxdTzRfh0Jt4NhGh/x5+7Az3w89wwo?=
 =?us-ascii?Q?7Y2Hb5vzoGqt27fdqs3/nBdGoTXjs9r5dqhNVYozp1P3Yi7nGU4esHXAZzYV?=
 =?us-ascii?Q?zZ7hs7LXbIJK3+gnfcj4kATvxmGD0LnvD3jAstEW5PTjyGeV2A5cvvDJaT3D?=
 =?us-ascii?Q?lODf92ecqPJxsXeEWoMA2cA+LNFjXheqqv8APo/uFdJELmF9LneRbRtnHfjC?=
 =?us-ascii?Q?q14v4DITOO4jaA6T4VZsEPOFKCPTRgv+d1Q2FgjG8PnlmTwxmUm9BkB2p91R?=
 =?us-ascii?Q?X9768gbgFE9mSF9Eflf2dw3n4Mo9olvyrpvOOvvNy9QaR88z9Rl9KiVJSyMl?=
 =?us-ascii?Q?iNmZToh6GoPDAoatxpjmKflClwp8ydYUhYBEMtAcdMmwBYsAIyHAUCY4eb61?=
 =?us-ascii?Q?M0NWM05wBzUol651Z6UF2LRAq4R1HeXxbX6xzsvzIIRsi2LOZF4CfSFaORsH?=
 =?us-ascii?Q?bsd4TKaHYXxIz2Mbl767R89yl2npbQvwIE5IIfIL15Wj37tKc41vm2twIDJo?=
 =?us-ascii?Q?M14SUeVWxnNNDC0Zjrra4JkwItHD7XfznenFMqiRp9VVwDiflitqBrhl73vF?=
 =?us-ascii?Q?0MU0tAdoO7m9AcVgUkmb7I+6jo3ANKgHIq+ACWln+PdsqIdzrzMJq18WY3Ke?=
 =?us-ascii?Q?9XdYng4wr/Mruir+dAYizmOeD3bYu3CsVdVoIItxYOrjbCCOWTIRwMZca1iN?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae870514-3dcd-4872-11b4-08dbda3941b9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 17:46:05.5310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13v5AMnM6cB6DF/sT/Gc+D72sCgtNy5vWHgNvGREDBr/TF5+zxueBtnjALlQymXbJWgObmp+/dJkxm+dUWLnu9efBbmaUpjRIjI1gkF3OHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8162
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis wrote:
> [CCing the CXL maintainers]
> 
> On 31.10.23 06:04, Randy Dunlap wrote:
> > On 10/29/23 22:33, Stephen Rothwell wrote:
> >>
> >> Please do not add any material not destined to be merged before v6.7-rc1
> >> into your linux-next included branches until after v6.7-rc1 has been
> >> released.
> >>
> >> Changes since 20231027:
> > 
> > when CONFIG_ACPI is not set (on various ARCH):
> > 
> > ERROR: modpost: "pci_print_aer" [drivers/cxl/core/cxl_core.ko] undefined!
> > 
> > Already fixed?
> 
> Doesn't seem so, I saw that yesterday and today in my ppc64le builds for
> Fedora (based on the Fedora rawhide config). Build log, in case anyone
> cares:
> https://copr-be.cloud.fedoraproject.org/results/@kernel-vanilla/next/fedora-38-ppc64le/06583955-next-next-all/builder-live.log.gz
> 
> Seems 0day ran into this, too:
> 
> https://lore.kernel.org/all/202310281921.W9lzomPk-lkp@intel.com/
> https://lore.kernel.org/all/202310290131.Z10R00pk-lkp@intel.com/
> https://lore.kernel.org/all/202310302206.Pkr5eBDi-lkp@intel.com/
> https://lore.kernel.org/all/202310310457.5LusQqF6-lkp@intel.com/

Yes, apologies for the thrash. This fixes it for me. I will append this
to the cxl/next branch:

diff --git a/include/linux/aer.h b/include/linux/aer.h
index f6ea2f57d808..3db310c19ab7 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -43,16 +43,20 @@ struct aer_capability_regs {
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
+void pci_print_aer(struct pci_dev *dev, int aer_severity,
+                   struct aer_capability_regs *aer);
 #else
 static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
        return -EINVAL;
 }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
+static inline void pci_print_aer(struct pci_dev *dev, int aer_severity,
+                                struct aer_capability_regs *aer)
+{
+}
 #endif
 
-void pci_print_aer(struct pci_dev *dev, int aer_severity,
-                   struct aer_capability_regs *aer);
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
                       int severity, struct aer_capability_regs *aer_regs);
