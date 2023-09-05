Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6C5791FC9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 02:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbjIEAOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 20:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjIEAOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 20:14:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38903E6;
        Mon,  4 Sep 2023 17:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693872873; x=1725408873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jXTml8ROylRcpxrDeh4M3sSBh0Z2uZU+fib1foNMrZI=;
  b=JiKnljQaa1iOZNIj2ltzZ48Bjvx7ILRH0jlCyXmRAWVLdJ3dO8Ts+Dak
   4wF+UjOT3fzHCSodCfUp7CyD21UdZpVv0MCori9EG0+tjlvIWzHN+6zQd
   I3dKoiX2eWqydhdClPeQYLSA4YVnnqU730EDFOMYCnrDk1QlxFwv+qjGF
   2Z3Rim7ukjYLR9rgGiTFrR/ccug63mPNyAhvHMfn+71IDrSD9ze1aiOBy
   4irrSNxeUq7GamU4Flii/D7tHNGjhWnNROY1DDnzQb7JfQzb9z/AdjX4v
   MhZVEuiegXzTtn1+bx9t+wV1NmNmlBD779kefsLNwKjcEanb9d7Z4F0r7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="440643559"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="440643559"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 17:14:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="806391108"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="806391108"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 17:14:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 17:14:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 17:14:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 17:14:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sh0uHGa+5UcMfWHlonWc1ADcRBDH0WKwDYmwSoNrN23Nrjrs4krkf1c2PtwdZGjG5wTdl5VVelI4sA601CnKlXMphxpjK6rb8Bfpo87s9YvRWUV5iC/778xweny8TFq+63rpd6y+2yZ99xmYANoRLnrz//zare3FTfszavkSEgFPZKdohDR9SIucxT2a8kzDvWjZolgqHLg7m5gwtoVYjVj2jepy4hfNPp47izBK2NriaZu03CwDDDGyTh26DWhAP2syXAsYgVwKaRq2n5+F3s53mY/JObwExWeMs44k34bOaF47lw0nf+5mvGQftIRk4Ei5csRyxjlKeWhUw3Ex7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdqquMmJBgBEhEF2NWtWvZ1hE0FdPMdfjJj3E1oijVU=;
 b=QeRnd+7EMDVgeMMmu3Jz4D/6PqJpyauqLq75ta+ElBi4Q0iMHoTK97sC9SbfDi1PtQmSi5MuNvZy4UwNaxs18vSoOo/wmCRkQYILKcaRMGwOhOMLpzUdgqFAgGr2C/iCgMLA0HSEo56rzLT7Mu8HkeVLeyGY3kfDYQUK+Oe9K4h4p+ajGx3rFyvhlqkn4nbmWuEwuVKSHQjT4N6Oa4TzWfkDVHJH+rLutKXT1xjgniRM9cLwcM2iTezBVpcOyX5CUe9ScIBHStAUXLaPydeJv4Up+X0iSGmaEENm3jrzJwbh+HJXBluOYrECGxendWHjqku5T0/yZ3PWC1H+b1njig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ1PR11MB6250.namprd11.prod.outlook.com (2603:10b6:a03:459::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 00:14:29 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 00:14:29 +0000
Date:   Mon, 4 Sep 2023 17:14:25 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 03/18] cxl/mem: Read Dynamic capacity
 configuration from the device
Message-ID: <64f672e1d4da7_1e8e78294c7@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-3-f740c47e7916@intel.com>
 <db3bd5d0-640a-b121-f3e7-cfb73dc6c9ff@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <db3bd5d0-640a-b121-f3e7-cfb73dc6c9ff@intel.com>
X-ClientProxiedBy: BYAPR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:a03:114::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ1PR11MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b79f2df-398e-40fd-9625-08dbada5123c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: momsah3LATqOzkejOc7qv/vqZvilw9EgXpnTiqmidipAkRc5jcMI2Gs+7GTnltOefTle/EJU3i/dxYOTCDpWYrLsiwxBepg0+QoIj6jlV4q4jf2CIDiF0ESleKnfHAVusIY1qXq6QhUEx4Q1G4Af26SOfXXKpe5q7ibKuOvykGeydbP9h2nL9MtbZYI5osfyRwCC4UxP4AxFtg9oIrt8lhQlq7YpXuXtSawLjJsn48MowM8rhgrJ6NXLai3BQAGkS16xollI/vaDlN9KyBhDQQ2tDTB/J6tVF6+8YKucdrEnYcKhaVxjRtSEGhemroqi7s5GVg0Fv0nDLG58B13dVLeG5GfjBFLTHJvCwkX2S+qNIZjj4voZ2KHNY4ZeOF76z87w9Txeaa9af7hMs+MtBzJl0muyLLpOrQF+3tLJHYjvyLC/vm1F5gJUlpcc5MbZ/GL/RU7Wb2CZoZHAIBiJwcywnNSYhnkEssNJShnYBtzV7iBE6Y2qEF767f47UZhLpGfPLTpnW/6gHFDqCPdF4v7tUD5Sc7tgCQag5mCKKcf5DjNIwuTF4kxFngJS06X5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(396003)(376002)(1800799009)(451199024)(186009)(2906002)(83380400001)(4744005)(53546011)(6506007)(6486002)(54906003)(6636002)(316002)(66556008)(110136005)(66476007)(66946007)(478600001)(6666004)(5660300002)(26005)(44832011)(41300700001)(6512007)(9686003)(8676002)(4326008)(8936002)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PrVVHHYDNzYmgpRrz7T+13B1A5uA1o+dG7AZ8mxQk+Imm9WmL2E9zOWlc9bc?=
 =?us-ascii?Q?cw/v5BBYBinxux3VCIpfYqAb+HWIyyv7laLNsCV18glcqaLcynP5RA6IO5YO?=
 =?us-ascii?Q?mId0iJ+CwSLS10qwSF5HTENT8Zz53OOFNaP3IwmePjt2Ic54hsBKspsMsure?=
 =?us-ascii?Q?XxlRQUSi/aePGRrmEQoxD/Ma7lQTPKB49H1W4nWTs7cpITMvJ4eLVIdveLzd?=
 =?us-ascii?Q?OCNRY6l98p97vDwEb8Q3OmsCW4w4cWWlZ0fd9IC1ml3zmRMGf18d4DELZ8ej?=
 =?us-ascii?Q?EYi5rhYiApgMkSj6JPRgtvsvtBaPm7gmEKwZuO6E1yynQaMaMJth6xP/5+Qf?=
 =?us-ascii?Q?9oJBm6Y/0zfcycs2tual9R1Q39vas3YTOynG9XWfo23RWIe+ao6hDp/B/mIw?=
 =?us-ascii?Q?1J78hdwm1ciFzODpGrLMs8Dywy4fk2DYwSPDLjxlWwxdTYEp+L2tAKTCE+9U?=
 =?us-ascii?Q?AOY1zW65B72dK1PuxMCrR9TAXumnkJWIW4aEsDdhKihjFJFBGkP8apb3avUr?=
 =?us-ascii?Q?0+M1tAZIiukKo32PIWZEiER0Z4KBWakfayVpXbf74Hb/rBGBs9OUo9Y11gyE?=
 =?us-ascii?Q?fDyQ6O69KmcY0sS/VOB2C1r7uC41BRVmQudXQCp12xyLNPQRj4oo0YCBJxgp?=
 =?us-ascii?Q?swxyCfjW/hsMykzlj31hMHRWyhdeYM3oCN4ilN2m6E6LY50mpA44vPTh7Fgz?=
 =?us-ascii?Q?KYZpLvinrT0MrSPA1JqU0ou+tq1i+dXNfiOAKmhCKGgQ0R5RerJ9uyyu0CeK?=
 =?us-ascii?Q?TcQZ5aNAJe79LcsCrqzLNiBZYyIF42HYaYjxVXNFKP9FegRxJ20EmGwN+/zE?=
 =?us-ascii?Q?wNg+abeLl2wmlAcfY5MP1k/sz71LlyEudgxM/Xo4m96BFzNv4D/CseBLWhwk?=
 =?us-ascii?Q?sn4rFoRfj6ZLsfLdk+iPVhVoGHkOP+xMwItFy1EPfv5adNxuYWZSYy0k5Vxu?=
 =?us-ascii?Q?/rqoAplDj0iHogICWwVVyB2e+xiNd3yJeAFHa/DPHfGLLlpfggYSs2PhrQDG?=
 =?us-ascii?Q?AA6K0VaIvZ/WF/MCMYdxRkwP0ksA9wmNeopEHpi2F+6NeHUJrX23Q2Nsqrz/?=
 =?us-ascii?Q?isTXsNxXLepReaNL/jDAT8DcUPrpO3oqGc9Ei+l+NDRtyEDk4QXnYL82CW76?=
 =?us-ascii?Q?KMDZQ+DbeABKA5D7c5tg9Xqi+MBpwkc59Seatoe8RKVkExUGrCczqAvahXeh?=
 =?us-ascii?Q?wSHOIIe0YXlbq3aYBlP/ra3CmdyRMRSglHP9lBSExmTOH7udMoIZt2k6gjtt?=
 =?us-ascii?Q?8wdSnh5+izZhytDoFPhYTLj6EVv2Umxon1ADIhjwmO+F9kasboEVyoZ4pt+8?=
 =?us-ascii?Q?yVgnWWqtlFzdu3Yy+Wq13geebA/7J2VNu8VMjqnqo1FNXIRcA8sTxQyXAe5b?=
 =?us-ascii?Q?RC53rluUnz2WDc9abXzHFluPa8TOIE5VNuIIAeK+wCBKkUuswe+68F/Fghkx?=
 =?us-ascii?Q?BtzrpukVk3oWe5q7xqx/pI9DccsF9CENZ0faZfJ7c4n/v42ciVM8yuFNTjk6?=
 =?us-ascii?Q?pdVvYN3dFyxIcNniO+fgSneS/i6GKKW087SwS12QBT3OPukkFdjkeu/cTnjW?=
 =?us-ascii?Q?o7lvFiMZ7vhtm2Sm/6Z3gC0YKyBc7sePbUSGtMhY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b79f2df-398e-40fd-9625-08dbada5123c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 00:14:29.2372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGvSdOpnRll0AwkSiO9QUq+HWOJzrn4aGcmhFqaBhG45Lj1MyTqi9H9hLEMKFOzf3zB4zlOJzKLFYei+zrkzVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6250
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

Dave Jiang wrote:
> 
> 
> On 8/28/23 22:20, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > Devices can optionally support Dynamic Capacity (DC).  These devices are
> > known as Dynamic Capacity Devices (DCD).
> > 
> > Implement the DC (opcode 48XXh) mailbox commands as specified in CXL 3.0
> > section 8.2.9.8.9.  Read the DC configuration and store the DC region
> > information in the device state.
> > 
> > Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Uncapitalize Dynamic in subject

Fair enough.

> 
> Also, maybe split out the REGION vs DECODER as a prep patch.

Done per Jonathan.

Thanks for the review.
Ira
