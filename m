Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F2879DA96
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjILVNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjILVNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:13:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C77610CC;
        Tue, 12 Sep 2023 14:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694553208; x=1726089208;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IKW+yxla06Oh/JZA2mlsMu+SpVRjKfFMhWlgbGAktzk=;
  b=ko3+hJlcnXHAYBBaW8G5uf8jFNBQgbj5N5M9s2bGrnRdCxKDOpq09GmX
   42rIfCq7rEFk6vF2BS/hrUxu+KvNILz7KIq5NOTD7ciTJRTl64qu4zCx5
   YS58VJH3K3i1AJU013XkSJ+G6ZoujCE4edvHmuxe65UGvbpRaTKbSWPOI
   tLokMU0qUixD4c70GvPPncj7viBHi3niKlYAH5um+cu4153VVPhntwlh0
   NWB4rpaUUNjMk4gUZNv9s/6z6lFoMZI3A8mUtR3FkA2xx92bbx42pDqv5
   aOB1s0DOiCYwpz4zfUkCH6CL6uZBt7rqHWv/iLSylsvaFB/tZdQPk1caa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="357926077"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="357926077"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 14:13:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="887086884"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="887086884"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 14:12:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 14:13:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 14:13:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 14:13:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFwl7d+aMtNYt5OcYXxwhN6FMt47o5usZ2J1XLj3+dVxvEKfIBA7IKjNhhaB6B/JGiy7ql3Ze69X5ku2rTRE0iAKtyuGvX8XQgYoQNwy/x+thv0fFJ5N1rb0594GsZ0RkNzVveqZUj2Wp0D7UNkfYFPtptpN5GwxACXKgPShgJ/XC73WcHkx4JEdaxJmRBmJO+9wBgpmPvhuOpidMpGIxSkAUBg9rIkBd2ro7vlSq5WEz7V5Hhc4uM2VxGSXLmocYdZBbBbgN11hcnpa6RmrTfDPtSkPhkXrGcD3xh3Kutrw6iv7wRo2SFTJ13vywue3CwovIt/BugeUFnkydCmCGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hMisdHj/HpJamKUuTrWAoxlOMYR8L43lIvheRYtZzk=;
 b=d4pSKm1px/WRXCv18MaNtCsHg5HgobrkUqzoHtNiiUo+Fu5oGHsSDoXZYW+5r3zLR/pydDmZ8930kqzI/r6SC4u///3H4RsLCTExQ+I/C0faIaNuWlHZm+kl0GMMpFlFOwh0yoMKaOOTSTDRegzcycSJ4Lh32cQbZKQOhsJO4nwFEarSZGp93kAA/ps6x2Z4519jXHlvU0SKO2iGK06QATn0nIUhhClLU3W1dYisViQMOmGacSNAenrQQysYc8DD77GCH8pSFNAnwFur/z1Na2P98DrHmcwcVa0J/tK5q1i9LSWzXXg+P10dyE1c8aeFcvuYDIj/9ZH7SfkfLti01g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7042.namprd11.prod.outlook.com (2603:10b6:806:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Tue, 12 Sep
 2023 21:13:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 21:13:24 +0000
Date:   Tue, 12 Sep 2023 14:13:20 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Rapoport <rppt@kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>, <x86@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Derick Marks <derick.w.marks@intel.com>
Subject: RE: [PATCH v4 2/2] ACPI: NUMA: Apply SRAT proximity domain to entire
 CFMWS window
Message-ID: <6500d470d363f_19f612942b@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1689018477.git.alison.schofield@intel.com>
 <eaa0b7cffb0951a126223eef3cbe7b55b8300ad9.1689018477.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <eaa0b7cffb0951a126223eef3cbe7b55b8300ad9.1689018477.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:303:6b::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7042:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff25f85-e23b-4a5c-11b2-08dbb3d51958
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yEgMXtx7LvMQFncgc7g1x+sCgbqPkbXKYT5srF64RBPnmDl27UQUEjf6T0g9tMuwNtdH+dLM395sc4/AYNfwEpGbP6tGnIEsrrjL5Glq5VayUwfKp6VHinRG3yxQ+DxaF2xZe5w8Wfak1JEhxEvE/mtJiLEuo82hWP+RtP65K71In48O+qXnsW2mA9hD1GKT1mectT0YZZjonXlBhSmlEleRIj5NSn9DyNXohm/tv1TxVId+m5eZ3broE6Vl2COKmI/zlnj6wC1HL1HlNpmCwOW8Z6lixH6dSkZYZ499VC0eWBH80UYs7rMUBjpDOo1BDpn/EUVz7b0I7VxQoEz7qJC6if03bDNPtihSt8r3ANEC6hrKHP/2MzKwh1YrHGpe8QpZXDblxF7c7wRMxZ5oBHAJTVkruTGig9WjA6k8Cht0+mb131zSbysIXrDP95LHLZQphC/pIKGtfi5EumYbeUwpWdIINQeDIVxRR34Ly6Z7ppVxNh7uF6xfjIXAvuww4/7YWwvCF86ChDLODlslIzaWUFYDAApCfDpH9GGfyFpIpivRChlIEggNYsp0Qnnj3den9x/TdCL9sK40XlQ/O0De+/1QT/hrI3sEw5w0gfo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(376002)(396003)(1800799009)(451199024)(186009)(8936002)(921005)(6486002)(9686003)(6666004)(6506007)(38100700002)(66556008)(82960400001)(86362001)(5660300002)(26005)(2906002)(110136005)(83380400001)(66476007)(6512007)(7416002)(66946007)(8676002)(478600001)(54906003)(4326008)(316002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xrU+HRLZkLs9drv/NoKmWmawtS5fq2mG19qUQKQUBh4Yi8NRwxGpnbrSPMoM?=
 =?us-ascii?Q?mXKE1IaDWFmuiAJxG0kkG3G+5K7TOH4VyT/L94Vbw+jfPSQh6q/ZNr7RPkqH?=
 =?us-ascii?Q?E33gwyUPD2bTY0HQPEXc8N38YzlwHibRWZv5JaHO7/ZLWTtuZCFKcaf4qwaF?=
 =?us-ascii?Q?i/2ove0kKF3TZ31VMebjGh8Z1ncznVx0E0ZHL1cDdxBskjXVD92aGJn5hAvx?=
 =?us-ascii?Q?89VCYE14rUDDo03kR1PqwzHMwc4/LKXzqNJJOUiUWbB6e2c/GMYdFATo4TsD?=
 =?us-ascii?Q?OnJwVpujSHV0jzNORbxUvlWyb2chZYKRFPlCcKRWu4+b1vvyYc9TFJ/g9PxL?=
 =?us-ascii?Q?Ps+i/IyGgTB1MQ77ZXN1P9edPMv736iv+TRewywpc//cKVABWyuTsESjg1yR?=
 =?us-ascii?Q?MRfR5RPoqhg5hlycs7W3DI7VDAZ1qD0s4dO+KuRiYHULeIo12KPdaZpYiJ30?=
 =?us-ascii?Q?w3DE0nRBVuSsB1QS6isX93Yk/CbykiE4+gVe31bVcvKidQQArNLvRviYLt4u?=
 =?us-ascii?Q?V80U7WePUpl4p6GxNfE022X5T+Ik7FytrT+v9Xi/atPFD4sM7t4EwpRSzZsa?=
 =?us-ascii?Q?/Bkyer122FIJdAKAaMWgZcNcVTwovMJO10pru/4bDSmDmwQsWoBEQgtaj+ST?=
 =?us-ascii?Q?QChaq5APfsicCLBOnuwyyKKvTcz2rVk9VDfWBNGHiUOy9U05f0X3SEGKZNfB?=
 =?us-ascii?Q?IY1Sisk1z3XAev/lWRsxvCRaXVmUYvE5pbtncikZTonOIzEFXDv4EFAQsBfE?=
 =?us-ascii?Q?8u5L4LNh+2bRLU6/6Sm1QPYnmcJG9ig1YuSvReuG70EMS4CK5ijtDtjEniio?=
 =?us-ascii?Q?IANvAq/cZlsrCbXBdTxQae1JfF941GBTxHIZQVUMnfPzpqG1CcR/cx1kvcQW?=
 =?us-ascii?Q?ZJEr74qOn8udzdbl2EHS24lxANflAYHZhTjN3Y69J0cUMccH4pIGAJywdLD4?=
 =?us-ascii?Q?8Xab+iDlipkVvt/rLotM4saaNGsilTuPoC1OmLZI9y5Ug5UbP27nv2+7hbJQ?=
 =?us-ascii?Q?7n1fhssgHf22pnYplx7CxgpCuMepgVLUMmYS0PZ8HuKQ3q5J1xIyZleE5KWL?=
 =?us-ascii?Q?nG2xplVzcHrNtBcq0d38we0SiCSJtZLeGTbchtINbrMS+yiyZOszjgdn4A3G?=
 =?us-ascii?Q?vVquh/yTsTtfH5YActYyxqqrurAWc0HMLwkykits5vYAIj+hyimEEII6tv7j?=
 =?us-ascii?Q?7gDyUYir6aN8sqCFvwocckiR6l6woqUwmN/I/I0WorTQ9nUvpoolTNcjcvY3?=
 =?us-ascii?Q?iC7scWPGpstNGiHtE+lz/5DIuKRteSqglZplEe5+XPw05BfPSzHLZuXmYasf?=
 =?us-ascii?Q?0SGgRQLzaMniWZVFkcEPZXfJqnZr0sPSjNeZDaoMyRdAmEH1iy+Fk36TMs9X?=
 =?us-ascii?Q?X2ku2kXH0s7bvDFmhNy/kh5K0jrE2k5vmQvgI/syLQokqshrdfAzmumCDKjO?=
 =?us-ascii?Q?wre2xi3K9qVjkexpwTFITpqo6tPH3dlNhTcYp3oRoKmRWRzy/ziOqy0r0PBn?=
 =?us-ascii?Q?bOlivUE7xk83GMpEMXqbmzOl20Ci79V0sd4pIrYddPTNRXSlNh3gTb91A8GL?=
 =?us-ascii?Q?k1Dnwq0JFGaKHqBHz2axlT8EvOzQhPNTLETu3XIAAVWr6g5aGH0XlSvLmimu?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff25f85-e23b-4a5c-11b2-08dbb3d51958
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 21:13:23.9672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJhOCTPk9YzB+vQfqW68IXdQJ6Nv8Dm2vqLhNmEU+Dp1YJAuIBfaeUrO8E0isQVnUoTeWO+8j4ucKtkbJ9zr+ueE2g6PjdJD9il77TmwbPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7042
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Commit fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each
> CFMWS not in SRAT") did not account for the case where the BIOS
> only partially describes a CFMWS Window in the SRAT. That means
> the omitted address ranges, of a partially described CFMWS Window,
> do not get assigned to a NUMA node.
> 
> Replace the call to phys_to_target_node() with numa_add_memblks().
> Numa_add_memblks() searches an HPA range for existing memblk(s)
> and extends those memblk(s) to fill the entire CFMWS Window.
> 
> Extending the existing memblks is a simple strategy that reuses
> SRAT defined proximity domains from part of a window to fill out
> the entire window, based on the knowledge* that all of a CFMWS
> window is of a similar performance class.
> 
> *Note that this heuristic will evolve when CFMWS Windows present
> a wider range of characteristics. The extension of the proximity
> domain, implemented here, is likely a step in developing a more
> sophisticated performance profile in the future.
> 
> There is no change in behavior when the SRAT does not describe
> the CFMWS Window at all. In that case, a new NUMA node with a
> single memblk covering the entire CFMWS Window is created.
> 
> Fixes: fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT")
> Reported-by: Derick Marks <derick.w.marks@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Tested-by: Derick Marks <derick.w.marks@intel.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
