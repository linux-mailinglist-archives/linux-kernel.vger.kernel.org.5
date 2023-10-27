Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146AA7DA30D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346615AbjJ0WCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0WCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:02:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D691B5;
        Fri, 27 Oct 2023 15:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698444134; x=1729980134;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5JpFVQHFuHgjHcvn1QTgfXIDJLyWP1ivlfBNpI8RDBE=;
  b=CdEzVI4yLQlwpTDzJiualrtgmndla+zPzexroxoT4hAk9ctPQxngDz4M
   W9gLJo/WPBDNYBBgmqWfxCX9vrO7pTjpriw0ZpU5gcOon8zRXGDERY0bX
   tHZkrvj4ua40ZOPk0H0RgVuWUBedZtI5UIce7MnNxxiT6d1wxnklTTe7Y
   y2fs7m3z7vC9Qx34DOA3Bs7Ny/juI+eSO/8tpnx19B5IVaePDZg3QItws
   MvJzOVJVWgu4hqA1UpQdvtRMGGbbVpFgeDngstOXCe0OXf+iGOQLvWKuH
   /TqXlp4KtuT6PnJC4z3ynsj80BfRr//1GIrH2xVUarXPLOzXlhssNLem9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="652488"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="652488"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 15:02:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="969859"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 15:02:02 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 15:02:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 15:02:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 15:02:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrIWUAUTt3WNrZZIi3f16uMC5jWRIMB0ODparLqHxJwjokq1hvW0ni43TSoaU2Ft1gk9ZdjotLbu4nPG7hDIpHSnpo2wCR2FerHXj+m9AqWu5lJOFsou3egSIZ6OxH9T+tehVOhQN/qI68wCW9Vq2xlFf4NLOI5DeWn2dBaqbMC3odZSCYrC3WV02OrIpoDgi9dMODYhpzllNEWULQbsKh6UnUVKf4KANlxHVx6D4OL6IDO43twIQ8KWtiJHgaSOMCDKWc6M4ioeJXGd8aMf4v/8/bQrX88+F049c28XYQc/SxCPFwqlgtkhEPAWqrDkyQGUxpmJetp5TDRJQCU/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFnjmPmZy1zbQbDIlQbf9VAi+bnju5r3YfU+wECAeCk=;
 b=H5a7GhenPYxAFFu7e5Tj7guwRWdkJ9xbr3JRv7HgqqKC0LYycGtcQzZek6EW01FKNd1G09YY2mewwfPEiEzvfIhWXbLkoBJFAY9vUeAadmp5absdFQlTjhGJacq7OcxVwWtvSM2NJypO9xvVA2OyUViDxisT5CsjCpoRea3am47GIyGQ1s0wOBjkjmZ1NIDHyVxYt+hKipOKELH+bWKu+WLpxvMZSrz3uEaBQwTq7TVRdphVBJXNKtkZTAObTc0AKHOmRNxKNl7XcKnrYFI3gwZWofF4yzqODxW6yi9QlHFZQguR5Lznns7qlunpZQKd4yvXYratwN8MQiwBzLprzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7075.namprd11.prod.outlook.com (2603:10b6:510:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 22:02:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 22:02:09 +0000
Date:   Fri, 27 Oct 2023 15:02:06 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH v12 10/20] cxl/pci: Introduce config option PCIEAER_CXL
Message-ID: <653c335e22edc_244c8f29415@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231018171713.1883517-1-rrichter@amd.com>
 <20231018171713.1883517-11-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231018171713.1883517-11-rrichter@amd.com>
X-ClientProxiedBy: MW4PR04CA0350.namprd04.prod.outlook.com
 (2603:10b6:303:8a::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e756326-7592-45fc-1f88-08dbd7385d53
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wR2w6zVUwEdAVn3fy8LxPKnDtJSyAG72451uvxMMc86PZUVRolo/PcrD0e4Y/9uqUWBt/cxJnXsMyZnY8Y7EXTOpS4B+In2i1cJnb8SbZB2vZvSROgxacrsDYq2FizLjrYfi4YlIH+YAm52dVHYYCBe6P4beWwpo2SASj2/OLLYLU3XV8cJmvJn/UQ8xRHvn4BtXfa0+GF1ERKDx/W3c9qAOn+XK5euUT5i/D1+wWKxLIgc7/qWM/iIb6ucVhe7aVGwQaQF5vzir1QxqEZoIBBZoSuRrZiGw/x0dxIv2knTK259mPiEsDlz6GUXuWPOKekOn+MS5wTYKIlt/zXjElrbOLjSTeN8gubhKMopKyfWoQKUEaX1FCmhUpLwMQ8ymTD4Dvfe9xK3lMKWm6hj3NKBtlH06nQiRfAJ2IndIAtznETHNFInvV38u1Tsw27dh1dipBf8xO0icHQVz38NV/CKoVxrSf2sZn5NuyW8pVItD5ghESNnPr0K7WXM/UiIs8jVPzQUZypBqMCFXBs9agi8d3m4XB7+VCJ1E2YA3uU9Qk4LXj0uhdMR6RvtpK5u7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(8676002)(8936002)(4326008)(26005)(82960400001)(38100700002)(4744005)(2906002)(86362001)(5660300002)(41300700001)(6486002)(6506007)(478600001)(66476007)(6666004)(66946007)(9686003)(6512007)(66556008)(54906003)(316002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+aoNget61l5KQ5XEGSSTnNM4duFvY/R28M3QtdOwZbFgBMMVUVhLVIImHnKT?=
 =?us-ascii?Q?BgPOIqR6mpfaLAv48AwOHX7LAWuko8VueJ4qe5FjS8mRekEU5/yPJPfN3WNi?=
 =?us-ascii?Q?9mhtiRdzT4xNwZX/5BE27sf2wMIeun2PgZaZjCRYZSFhH//ftgH/fkEgiNeu?=
 =?us-ascii?Q?jwni4LhSFC9V68qiQCDFJ8WNTFvYL4oi2jGzOAnU7loTM6hkodtoLkthlYs+?=
 =?us-ascii?Q?3HKXtBpMs7I/dr2sSc0Up29HLmOyWRWUijAEwulbQr/LV8UyJutyr2zjp7+q?=
 =?us-ascii?Q?3nGZRaLLkwjlg/F7Ssy3rdzimIhcIAguX+j631lVQ/TLpovtTCkHI1Ycq1Tb?=
 =?us-ascii?Q?WxDmyprkNTU4s5O1PGb0jwtFE3R9yVrdMJuf7y30uWaUW0QZc2G2msu8vVS1?=
 =?us-ascii?Q?oowEtnS3WmwTvSl7hdsPL6NmDgrQ37UbjrK0Ob4QkaJOCeDYlmKUtJMcxB/m?=
 =?us-ascii?Q?Bi9+C9x51YOuizCrRSWODmwT36yeX7ya/FAoSTWfSNQQuOkIJ6qxO0WU9zEc?=
 =?us-ascii?Q?Itym+rP/MIPs96rnHJL5WdOa/yfqsFulpztTBvxwQBow60NPtRrz6W6dcC2N?=
 =?us-ascii?Q?MI+rbP8HVi18UnVMcmkl3Q7d23aDB8CBt6GNQ7ni0Ab15O2IjzkiQl3RQZED?=
 =?us-ascii?Q?Xdd/xjwQiPSY0/UXj5pE2FeHaFK4WFB3aDHSQxfRTHo0geqNf+wOUSqwwUU0?=
 =?us-ascii?Q?x3lhHmYlaWXQo7mf7S0QURje4/UQRMktspTCbHLu3UUev9qN7qDa833daySa?=
 =?us-ascii?Q?lAvMO61WUIdpLTGAeL0KJBguAlo1Y0Rddcrv47YcnkQADGBr6VzV18qdY5MD?=
 =?us-ascii?Q?N2RWpermENS+L5ikoEyeZDVaCbUUZuZp7CZ8s+3j82QKFiC6qomersQJ9uMD?=
 =?us-ascii?Q?R/EjvdlVimm/av450nELJeLgyWt9f0MhR5YDoo/FoQlkGxqRWa4xNv3mvkRS?=
 =?us-ascii?Q?Tl9AdWhE4U6hTT9JT8JrkQ91IvIhWbJGaYmCo1FksMbsx5BwMvQCUCx658Hg?=
 =?us-ascii?Q?W6cMR3epviKwpp1v2o2qgK6pd62DWqP4sRCqkF+FZOFpqkbBJATLibuZ02ov?=
 =?us-ascii?Q?rpoV78fuoMVS3KijpixtOHnASqhiKk552k87HETb+DF5q8N2F8T6wxvr5JF5?=
 =?us-ascii?Q?JTG3SNkptl0/2mF9ApAd3ezX+2cauLCc9I808JphB6fr8PdWNl541mh5uOtz?=
 =?us-ascii?Q?05xFh8rQodqcB6uYHWbfMYQm8RHee4svCuvLr7Ibpkl3hmt0GUJx05XABjlb?=
 =?us-ascii?Q?wWA3pUxdvF1AOi3RgvY4hm70g9B9Zq2MgUBkSgGLjQehxuPDEgzCqvJEXKml?=
 =?us-ascii?Q?Bn4oFpb1OpMYDgMKz1gQyxFg4T7SmHEViEMNuJ25c7mY0a+n3uesCeJ5fleA?=
 =?us-ascii?Q?Zk5mE7lHV3o62vnOZ4rgjzeO96Qel55rvHivar2kpe2kFXjljQzzqoh1wftR?=
 =?us-ascii?Q?WP0LRj9XQiBYJ1hEsBSwLqzcEtUvG/85AkONskt5LUtA7nds5aTXFTtRRE5M?=
 =?us-ascii?Q?ecRtQyYp191/C5URsPQRSVu7rCIRDCUxTxNHIdWm/26jei5Bp7MABU5Fr4Uh?=
 =?us-ascii?Q?f5YobcW2r8ZQp23sop05PdDSgzDQylf561d1QpXPciBs0MDagtV4kRJTiUHC?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e756326-7592-45fc-1f88-08dbd7385d53
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 22:02:08.9043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jG+2urfGx8SX18qe/2pdgtkZIRqdfinkxTEMF9J7Mv2bNRTSuSTnG2pmSqIwI1d+dwEU1iraCmIsPKzrRmUArsskxOx/qhP53QaDkkvhVNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7075
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> CXL error handling depends on AER.
> 
> Introduce config option PCIEAER_CXL in preparation of the AER dport
> error handling. Also, introduce the stub function
> devm_cxl_setup_parent_dport() to setup dports.
> 
> This is in preparation of follow on patches.
> 
> Note the Kconfg part of the option is added in a later patch to enable
> it once coding of the feature is complete.

This patch has no reason to exist as a standalone patch.

...will find a place to fold this in.
