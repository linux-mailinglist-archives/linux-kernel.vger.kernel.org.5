Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AB17D87C6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbjJZRqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjJZRql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:46:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA68A1B4;
        Thu, 26 Oct 2023 10:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698342395; x=1729878395;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9E0UUJuL0gzqhJNrEshKSgWafzB9LA8Jg3lm1fl/H+k=;
  b=XOR9sm/4SvToSSL0Thewxgm++qJIZESqFwxrWu2qy1EUcopx+xYOYdVC
   xrmTlewJwDJEph1oN3tY5lVYJ90z2PQt6F7Fq4P1IHh92MaqEmiJXmfrc
   ctChmdPIaLqgfBuJJV6Xq5Bb1T1/059ESyfh2XTCQL3Ei7zJxcxfW0KbE
   pWPAfK/x3XY2ex/BwAeBC0rzc1DMh8jkAuu1g+TQnBCR8LxP/3lFb3o7p
   4SIBx+ltFqLrDzTqqG46GLEGiPzN8HIW9HLUIt1lN3YnTnVJWpNtO66So
   dnercXdpxSskpDPH4DmIuQtPo0cwjOAQ3HonyVyptYIggeBZM+96aR+3K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="377971373"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="377971373"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 10:46:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="788585254"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="788585254"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 10:46:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 10:46:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 10:46:34 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 10:46:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHiOEePKEs7WglT0KbVo1aQQYmob8DxmgK1Ogc83SbAEoe/l4qWSBNU3IDilfXHF0/rOoRYR6HydUJ56v+NcX+YM9IqLNyjZDKWd+5W38tWwXMjIhU4fMFvGHtfRvlkh+PoEYfVBaAl97IOOpZp+n2pMwy2cmp08AL+qLKW00IJWSs78lHHy5FNFH7/UwFGTyRegK3RWAUezzU3HaTDVb9AHOBO3X+HXIhXKjQlUC8sdt5KxyjPQXlGSr2+RVgOUd87rCLvrZBOKayIX47xTDg//EsMZ9aYAjeJywa1xKh3qVuNnP6fMb6WLrlVkNB7GEfRZsgDa9OMoXmNlonJQDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBVtqHV3PLwgGwHxQikJ9BkWxmy7aWQ/F3hplaMhrcE=;
 b=UCs8jY4oPAjr79Va5CTgGuXAcPDtnEvWK4ATMxaYECgjX5NPr7DXUm3KU45f4zb/+Ac3DRzRm+WGKmMhOltqJb9XXNkqc5GCkN8krf7yE3ul5lVD9i3o4pKmxDcipPKXiWVWvDXBK7ZDnWiab94x2eK5iHUQLVi7c98/FbLxxmtSN/r4T0Hs3DMM3PxQSAkSnk7A7DpSlemeNtucIAjb0WMnuHCUv6yF+jovGqQP0Bll8KNFohUQmUp/kk0TKxgNaOv6U2znkzVcNRBklKi0/H2hNkFS0stfhlSNH38XRZuMLaEmK6+ZoPI2zbLO2rz0gMYjnWwQ0+H/LoOtZL2PpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB7086.namprd11.prod.outlook.com (2603:10b6:806:2b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 17:46:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 17:46:29 +0000
Date:   Thu, 26 Oct 2023 10:46:26 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: RE: [PATCH] MAINTAINERS: Add tools/testing/cxl files to CXL
Message-ID: <653aa5f2e1399_244c8f2945d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231026-vv-mainteners-fix-v1-1-0a0f25634073@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231026-vv-mainteners-fix-v1-1-0a0f25634073@intel.com>
X-ClientProxiedBy: MW4PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:303:8f::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d2541d6-2009-41ee-819c-08dbd64b7bcf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3HR64onlQWTLrru3FNEK2lWTzYZzQlUUARoX8FR0uW19iK+6cCuVT5lBJ0l12E9JdVjoe64fGDuOrOFSGrNV5i/pZtS5dqqV141KVu3sYK/tReOj3chPmTwAPHlB3xgA1JIOUquot2c0nFdhV9W9pHdZN+ydxerlqyHuuxeBLRJaBNfDLWKi07g6I3PckZ6pGZZoandXnmF3bSNJcNKH1B+wmwv1iyamDiSv4eWup9vBbUgsw8xwSj3b1Vv5q/BmCAnDNEQZXYx1DWprCkthtETLX6gFZbelkGH4clKhTJJTY22kthZJfBpX5pQCt6BYXDqIDM653OlkA5nzsDBP6kOjyMvFiJcOJCFqcdp4hi+ZkmHRIL9zUXsrbMT18M79yLkQ1z7c+Goc+da9Kp31yijnjH4kgyfYtMrhJf33zC/f9T9k5rHoDLf43ZOdmymox+EDGCOhMoKVdvSkMgDnjNtY29El/CT8zGXcF8iF6b/s6bdMYFy2VBVlglq44R6o4pU61OaAoDmejOErQeaiM+SpH+ekPtk7tD0PZkbWPiHbaweFXNjbMfnwju/uK+8h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(66946007)(4326008)(8676002)(6486002)(41300700001)(86362001)(8936002)(316002)(54906003)(66476007)(4744005)(5660300002)(478600001)(38100700002)(2906002)(82960400001)(107886003)(9686003)(6506007)(6512007)(6666004)(26005)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Ue3Hy+hQeS5u/KtL3ywK4xh23rCBNqLNe5MhDCeexNnfeQYZuzfuK1r2W4D?=
 =?us-ascii?Q?q4Qsz7kUY9u+u5ZSMTXka9qomRLtvEBOJIV0l3tuPcQE0ksQEplYNwYQZ5Ok?=
 =?us-ascii?Q?O/KsDQz9Lh9Wqhs4TDWSRLrFR+mdXezPuq1DaSOa33QU6xj5MQYdG7Ba9Qbg?=
 =?us-ascii?Q?//DzdziqUNi/VcDaxLOXf3/kS6rtnXMol8mWHMNc2X8lds6MxvZ5wRaDJnBF?=
 =?us-ascii?Q?csqtalnpOZTFcSVS0DteQbR3sjVpMWS8tOML3p3Xm6/Xq5MnLpD9PxdxH4IC?=
 =?us-ascii?Q?HZA6bu0ELCBM5AVB3OkeM818G38saxlvpijydd5dVk+4dzxvHCZ2n+nGbaKv?=
 =?us-ascii?Q?Eq/QJSIoV3mJcMJA5Fq4P26AyQV9atzL6Oy1Oi+D4sFCNhFC+ywmaRORZjDw?=
 =?us-ascii?Q?mB19919rt1unWrkZm1rzjY3u77xY2I/bqwi7Aa10+8BxyVpF1Jg3z8CSU49Y?=
 =?us-ascii?Q?y0pgEVnNQMkcjA2Ibf4ZcWbcpZR/QnxHCHUW1RnsIQF+WpyjTEV/eI9ywStx?=
 =?us-ascii?Q?N26DRb/satJi2UFUYDZENCMXZg6sO/ceioGB4qzDucn+vlqKn6VAsGI6eMdR?=
 =?us-ascii?Q?6mTWtzHmFymwQgnVR27pbaaJHXMuUL5FvdCVNCkf6eXZQopioN2ozc1YrO+R?=
 =?us-ascii?Q?OMsHuwR7gM0vBOvcP6dSbhl1QTsgqGR6qZ9pe4q2+K9X3ZTrYAI5u5QPsLYd?=
 =?us-ascii?Q?BqDwZY8AaGY54eBN43oZ8A9f3AJAin4cFOA59vWv8adyImppv2BueEdCH8z9?=
 =?us-ascii?Q?YlderIXK8TZHqFbdqwXabO4D0+D896VWUcyUiQlOwR0SLEX4I5rqgtbAJpjx?=
 =?us-ascii?Q?bo/qdjT7pWS75Zp/T8T0WfzPO/nSlxlgrMSEPL4yr2K4H7HocQs10F9MN2iM?=
 =?us-ascii?Q?qG/1rywDJXZJvyCHat4p0FUwnA7cSt4nHpWyv4NyDjMiWj5CXrWouFhP01AJ?=
 =?us-ascii?Q?hFxMk9T2QrZIUax8RKaVKlH7nIbNgvQIKEQPgZDa7Cb/vH/J0j2VRIboV4gq?=
 =?us-ascii?Q?Wpv1G6Rd6rpymBgyskH9P7M23JktUmGt6BsAQbWFm9FYJUX1qDPwnfYutffp?=
 =?us-ascii?Q?Skho4gTxUtwyT46/Po1xdr8STunGCAkOh514+IolfTKic37A8hBQMPh4GjYn?=
 =?us-ascii?Q?7x2odAq9ivRT8mdoVYukfzr0McGzXuQaZeTncxYhMhcda7atPY+KhdQ5t8qF?=
 =?us-ascii?Q?drDWB3VS0S5T/WE63SgY3TWlWjI0CHqQd1BTlpYfDRLPdFcnbAOyQnzOncVn?=
 =?us-ascii?Q?Tfv/zjAfvUgC1m/iu8t1FxcnTWO/pPZnZXp+8GA5BnUdmZek0Nv0AFqiS9UG?=
 =?us-ascii?Q?zjQM9eXoKuSg5ZE6l0jQ+1pP1K488rYC/9WIwzp/KvutliOqsiZ2tWNmwabj?=
 =?us-ascii?Q?bnjbfuyYWpiRrtvFluOAmJxKYcgG8t0Wl7L4bqnkAA6EbhdvmNc8VKR3f38H?=
 =?us-ascii?Q?H0l+U2oFlEfW1LyJ3lxH3TiHp8dQJKiiIZRMBC6cS2btrLIU1iLqcPiO96cD?=
 =?us-ascii?Q?SoYI14/6IQkpbQgbqumoGaaUB/JNmP2TOwnNx875r/HLcPyyVGK+q1PQ7hip?=
 =?us-ascii?Q?sjv0d8KrfQNYscGa+GUxiF7MbIbPIAIRfGW2DAoX97XxSp+hNsZrveLvsmxL?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2541d6-2009-41ee-819c-08dbd64b7bcf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 17:46:29.2438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gYUr51jhvFksMrqfEMdnPyD6aOTprQQhrfldD3VRGoJZSR9+hvWDgLGL2xE2sZ6r9cWgPnnY9RSMp4nD9A6yD059m6JUOm0PWm/0sM37Bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7086
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vishal Verma wrote:
> tools/testing/cxl contains the unit test infrastructure for mocking CXL
> hierarchies. These are under the purview of the CXL subsystem maintainers.
> Add the 'F:' entry for this to MAINTAINERS so that get_maintainer.pl
> works as expected for patches to this area.
> 
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 35977b269d5e..b5efa53dc3d0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5181,6 +5181,7 @@ L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>  F:	drivers/cxl/
>  F:	include/uapi/linux/cxl_mem.h
> +F:	tools/testing/cxl/

Makes sense, applied.
