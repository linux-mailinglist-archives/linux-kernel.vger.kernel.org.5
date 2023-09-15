Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D20A7A26AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbjIOS4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbjIOS4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:56:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76194270A;
        Fri, 15 Sep 2023 11:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694804121; x=1726340121;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nB1HjlJd+ob8Fe09PESwjYp/WdPqRD8dXwkGatn900c=;
  b=XTHmb+mB3y03T8fafyKjDbIgFLRGNqityyvfdKvJAfgD8EvRLxdI/NU3
   ZswbZh1jBFjwwsuGXP6yPqzDCQErmDOx+XyVUhlTe5SJcbYjkIU24ThhT
   HJr2+OuiIPD5BjgUgUPQ1Vl7EEgBMQ1FDEL64P45G/b8hY1OOfC+Ca+Nm
   EddQl+Z+JDRR6UhGgnk9+OewEJPbmCUwU/OyevVSBT4DOiDkPG/CpOgvh
   06BFhFnjys/EsE+2UiYQ7CqsgNYZR6rD4zJvV58g9IYh0hf2iY18TEbk0
   aBg3sPPF8nddC27qHaVdojstYkOJYwGh505zSl8LNP100/f/rMtme42nF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="383154782"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="383154782"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 11:43:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="810621362"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="810621362"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 11:43:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 11:43:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 11:43:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 11:43:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlzRx/bvd+KimlKLatH944rjAlTcRSX6lJ3wZq02Gr1vZwAQ/EGraRpBn3T9a7OviZGu/L/nOSLl5Zz+GUuanAXKcOaeRV5SgOvUGYDMEcgo9IGfWYPwW7u6jGykVSvNfnJfS5LEI4ofuHUKm62vekwLLBePtbnnKcb4KBBnokPjZnB6l/h5JyhIipzAgnrckRO0lr8V/HWoHMKU9vA8crkdUgeCvCpGsMCe7mu4pY9BUBC0pB/MrWf4E0MPzsxwJnxtRHtAVxxCGbhG7km+hYFKzB39C6jtv2K5zyASOA26ELmfGh1VUnVUylBA/VpUp7tVg7EOtGXVO5KmPtTcUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttU/AhpLL/BJGxy9zR8hX3SnlEoJsvHdTcFOUDXjI/8=;
 b=iV/t1OzRSGTnGlBLoSqYWqV4aGdWbj2aiGXxpU8LijHKDhfBFmcjpIu0/DYknfpcA1jzuvvQXwVunQ5sQ9xy30LFsbpG2DaE7usJtqjt9zamj/SBk5A3YXSDIOADNAPwbBCmelnHZp7AgJBgs+wVwT5/jAPSGFoR/EYWvoaVF3OuboVsZCKTYB++dRi+ktcNQIyHfyheY3ueCmHCp81qj9wba4izwHGF8fMdvqx9SZYR2iLqkE8k7PsMHR8TjbEK1mDqrZVsblaqDgJn3XEWxnIQuzKoP363dXPT59kA5gcE4tBQIM6KAgzt5mXIOOJTZoRmUomftA9hpYRs6gIgeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7757.namprd11.prod.outlook.com (2603:10b6:8:103::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 15 Sep
 2023 18:43:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 18:43:49 +0000
Date:   Fri, 15 Sep 2023 11:43:46 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v10 12/15] cxl/pci: Disable root port interrupts in RCH
 mode
Message-ID: <6504a5e23cee9_d7cc8294b7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230831170248.185078-1-terry.bowman@amd.com>
 <20230831170248.185078-5-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230831170248.185078-5-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:303:6a::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: e1047e5c-e1c7-4104-2f40-08dbb61bb357
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RGJzbOzkQHmBswZYHGBWHT3k5ROUeSi0zcrmrY2pNDYuQ/wON5CnKEEZir0ZXkH0s2C0KegaDAR5B1sOV0+GGVXWy9w2eVRJ0SQVPoG/wmqVsaRtFB4WtbRNhZoyl4TqpqtAPm9ep/WG5HLy2VLPIoRzs/C4EvMKRv5ASJqV6Wuo5oAZ0DFENU9yCws8pl7f+k502aU0Z06IgD+Hnihem+YO7JeNhKZnwFcJnIwQLdVHkQoit+wVP+uWhaHsu4dzoRBQ+7GZXVEt+CL/iU0enZIronkHBLNH3zwZ3dDcEJVPrKreGiMznxWnR8pb4R60hOYjUa1zXL/rE3pfan8EQlb1kNsAMoBf4RHg/UWGuIucK+Mll4nXQbj95fdq0VoVrAz0/uf3aWqkR4Z3hE+EUxzuZ+JbCfNwqtOOS9E/pU845CLEHgOnhzEMDsHyA2baBbYvvNY4jREg2AIFpYGakuKq+W1+XmYn9IRaPC6G8KrnnS1bFm+LylPWN7iMwuwnuZsxtbu9iQhHAkRobGOb4L2IuaI13tb0SQjb31m/FTPSJ9dRnCp+pGQsqbLXI4/M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199024)(186009)(1800799009)(6512007)(6506007)(2906002)(38100700002)(5660300002)(82960400001)(86362001)(4326008)(8936002)(83380400001)(26005)(316002)(6666004)(6486002)(66556008)(8676002)(41300700001)(9686003)(66476007)(66946007)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4GDjtmvL48jLEg5AZuTG05zs6b0JIew+xxY7EbVHY4GDe6k2UTO70UKGdKY9?=
 =?us-ascii?Q?GM9zQCwcH3HkNpHWQhvmxI+yCto9HiUg1KQiVo6PKtMjXnN4WBAQcEg52rBs?=
 =?us-ascii?Q?/1gIg8rtUV5WV8NE/E4U4l8HRFhqtaLaCQd9BUrDx2SwQl6nJOAb1MQQWS8T?=
 =?us-ascii?Q?MTbMloaVRfl6EoeR4GOUw6Adqo9O2QoFooDd3w8MrJ0BHwhJ4iXfaVwi5tj3?=
 =?us-ascii?Q?hNBYvTMEWo2SnsP7PV9qXoxba8pBSnOsDi4Db5r9XNe5f0JIwUws7gfGrANK?=
 =?us-ascii?Q?jlVyOe/u+WfbT3h0DI+rJVzihOSiZDSjuiMKn5uNfV6mRIeoM/+frHyaYmwy?=
 =?us-ascii?Q?iSlyEMSlN+PRp18MdJQjccYtOKQt5LDPkh3sA65wAPy/JUATedDAuLwzCYZH?=
 =?us-ascii?Q?f1+8xvLHZTyuXNZhPsqxvUcHEPSXHJ+Pwwqk0k7T5mCEDUckHTK/2OpWYZgm?=
 =?us-ascii?Q?om/2gFTThCeKkss9FDYeCCDArJWjTteUwzaAcQQtlkwFAsp5U9B8Tx//tiRy?=
 =?us-ascii?Q?ZpCiKgxP1uXCXJC5Zo1Af8f7tKDB8+oJpvXTiyJcLgYzvZLsB+7Wy+/A2B0L?=
 =?us-ascii?Q?BnJ7salHdwrUVGBURsfQ2/r3F/VAAz0suc6Hg/z+IcML3mjy3uYD5vVdlkPZ?=
 =?us-ascii?Q?XXo2Il9ttGVhBE3M741GKsP15tEq0QydvG8Ejo2sUfjptxYY/a8vl/EcpnNf?=
 =?us-ascii?Q?WLFOLecXetIamLXBJHYVPvdyuOorrLLuZLFTmIBAqSAQdcxtMeVvwLn9gZOw?=
 =?us-ascii?Q?oo43/0ZkYWvUnl4m4i40fYQJIg7Zz3B83KMI9jr8N9ra1Az2xK9h3+RVmcYE?=
 =?us-ascii?Q?Wz3qGx9dTRTAQkxAhT6cvS36YpXeUZ+6JLk2wRncKgFRRaUdcUPo9f/drF/e?=
 =?us-ascii?Q?HwyxDVUIcdOxZKrWjqicpLHhceCDWYJakNud7Vh4R5aXxskFlT1l3HWMFQkU?=
 =?us-ascii?Q?NcuC7V98sv6+bS83H5FJgIs6mWYcvJuQhAkeJWOS2uKE2TD2yJFOchS0tZVt?=
 =?us-ascii?Q?bbyxHb9ir0knwDzeLhM0XeX7VzNbssF3pN9MvTahU07BEUy1m1GkuXE96ZbZ?=
 =?us-ascii?Q?qLDN4AIqM4R+D3SRiNnf1EIJn772BIObESAlc/OMFDrg5IW+3tAb5b3lx3CB?=
 =?us-ascii?Q?KTp8UXKjrH70gcYUEYhwWIHFIWpo5c7d7WRV9lZWmPHRKGX0IsHk38ect7rb?=
 =?us-ascii?Q?d5cOW1NXGWTY/bBhHTx5mlm9MbUsoQuAmsPG2K2Px+ASyWJ7vY/lgbhKWyxZ?=
 =?us-ascii?Q?ey2x8EeMvwAJSs2JGE8yeGf0GX+62Pg3jLzC4PG559Y9MmOPLsI0qLBKqjKR?=
 =?us-ascii?Q?HxgkpNUNPaD+Q7vF9+x9tbZrpVsXuZiM2At0LHtoux1P6TeRvF7nO65urVzt?=
 =?us-ascii?Q?+uxwz+OZXijwr2BNdtBYVB0V6g38fOSzevhNJoq5Nk4zvFZtV4baYuPHgse5?=
 =?us-ascii?Q?FMINbBaVaH7JHTxDkYBfmysDH+sLtW+zIQCqHbjdM6VnMFG8ZYluNMW7uGmQ?=
 =?us-ascii?Q?2TWzd5CalJ1EPQ22sxushohKhMsgi879qWjj+zKOIXtK0xrKRX+XNXyiox9f?=
 =?us-ascii?Q?4laQbUZZTbOUfSh8IqEyBiElyp1G7sVotD2BXVUtc7Na88Mv6zyibeYNNfNq?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1047e5c-e1c7-4104-2f40-08dbb61bb357
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 18:43:49.4236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZkRwhMYWuSTsgty/2p/l49sb8tftDvRpTZTQLQ87rtwErZJmlkUev3Au1yOxMm3CXC9kB2QyTjS6e0aX/mqc64pexSfA9ECqGiSnMw5vrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7757
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> The RCH root port contains root command AER registers that should not be
> enabled.[1] Disable these to prevent root port interrupts.
> 
> [1] CXL 3.0 - 12.2.1.1 RCH Downstream Port-detected Errors
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
[..]
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 2a22a7ed4704..d195af72ed65 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1042,6 +1042,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  
>  	cxl_dport_map_regs(dport);
>  
> +	if (dport->rch)
> +		cxl_disable_rch_root_ints(dport);
> +

Similar to the comment about cxl_dport_map_regs() not being appropriate
in an enumeration routine, this also needs to move out of _add_dport. It
occurs to me that it should also be undone on driver detach just like
other device "enables".
