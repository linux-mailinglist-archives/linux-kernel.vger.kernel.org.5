Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724CE7D8DA0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 05:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345255AbjJ0Dqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 23:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0Dqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 23:46:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1745F198;
        Thu, 26 Oct 2023 20:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698378408; x=1729914408;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iECCKS2aC+c9FMpYGkPF6RBeL87gqs5aFp4PuySiusk=;
  b=B3JIUUljZeSatEHboJXkTLGGkSw0gTEqfgDhAQF500tqKmTcsduDY58X
   YGCNW62Kl6zBbBDjSe9dWoTyEmFH11Hjut/LXmI/lbAnAR+WQtxsFMXsy
   imTEB0340sgCj2mzLYGpDoMLGByPBewspfSK/mcIT/eNcgBXJjzGNdx9o
   Uo4mk9ihl8cjoGKWhgcML6DV0IFut6hHtaJtyp2A+LzJXDcLp/DliuUHv
   UQLUtin7q+gW1FMK9OMQsfwJsStPJmTNR+ZQyZspPRDlieVPZ+WxY1dEm
   gGFgbUCJKkAa4wXyF0ApVYfsseLJ5yODCmEEH5ywsbD+JuhCXPx9v55iE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="473945340"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="473945340"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 20:46:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="829837070"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="829837070"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 20:46:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 20:46:44 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 20:46:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 20:46:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 26 Oct 2023 20:46:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ir2F8gfQomTWUICyC98WEJBLu3lzZliEu9IRxfVntWzA2GfVIdjj0D9pirNPhhJ4HUJupADr1WhL7BzwRJeOxRFG2n6kRYfEzfmcewBTGXE3A40B85vak2hM/qIY32gbFYcnUrWDWUGlFJZRWmWb5KXdNqdYJFgKOiAXrxiBsXI0BedaO/tKz8WyXaScin0s8hFlOY/Smhoh3mMLLDXR089DRxp1bj0UN2iAb5/ayg4DAaS2GhcpiCqoNLfV6W4U0spAKaxy2EGucHUNUVD9dMa0iPKj4vsyMKch9XXZPn8WHwTxLvrTMoqOO7Vbc/7m6avyE3r9k1zyPjgsul5tww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLrHfTHHUiB8icv6XPB0e6bRC1cXhqfpI+H4W6ipOa8=;
 b=D+A4xA5nZC9vlPopdbAiM/bv5mo8vRqetl1Xz+EqhrbZL2ZiXQTaifZ1SqUTspkxOcATu0winN0MYaakYae0Uak/bS20Q6AN24hp8941yVhFm006MkOSTr4OQLepOrNhTxNwDX7YKcx2257f79kWx5I53n/YTjnP+kYGRdGC7Jl5SX3fgJ0AZhZdZS/hm38DBZlhzI5QMMr5nninUI+9i+CPPXDWAzG1UFZASCGAhHeLLmbt8qNQGIZDdw70olltbg+yooSuMjCydoek0dSle9g8IrLJliyWKU4PV1/k9lJrGWr2SJOWf7bjV741EgvsWk/t17HE30X5dMTL7nHiyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5970.namprd11.prod.outlook.com (2603:10b6:8:5d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Fri, 27 Oct 2023 03:46:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 03:46:36 +0000
Date:   Thu, 26 Oct 2023 20:46:33 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v12 01/20] cxl/port: Fix release of RCD endpoints
Message-ID: <653b3299c1a33_244c8f29449@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231018171713.1883517-1-rrichter@amd.com>
 <20231018171713.1883517-2-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231018171713.1883517-2-rrichter@amd.com>
X-ClientProxiedBy: MW4P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 28aa363e-c03d-46f8-d037-08dbd69f518b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iimlRk6J7R4qDmxxB8j5pQZYpUWQMIh3AQWFWqcv/4XByHjff4CRLe3f08udkAWdvSMEGImBlWUsCciM0K7vrN4T0vNISfFYFP2XmVaMt/TK/IfWCD0nF1k+wwgihH/wcIlmRufsVvUhaY9WswXK884UYbvder5oJNWCsgG33HF4AkGoW2Cda2+vvUaknorSgtIEP1afTX4/K7/SxpHQ/9aJDZgf6NEh2HBL3ukGwOWxQLlfPfnBO4yvD4Bav0JZXKCrP4u0R1Q3V71EDw5PzXvBN3ge4mYk97mzWeyqUHbowkEkhkeUJm6XZ8kbqSy9p/g8yeQLeOh146pKIvrjrH6xqQ6EcPK2LPSGHUoRsl3hYNwvi4rfrqiCMNrlD78/6rsWFrHQ7hSkBUxaAgudESQFPF/71an5N4gV/pN6yXUqcENfXY7P0hcJzEh9/fkUjDuuoy8IZg+H0vu7HhxMDuxLcqA8kKqzJha9xYZKwBJFX4kN2909WIxsj6hS2jTIjxBKFcqJ6LmsA3c4/ZOnfxng6t+ifUdeUQ+uFV005LI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(26005)(38100700002)(41300700001)(86362001)(2906002)(5660300002)(8676002)(66946007)(8936002)(4326008)(478600001)(6666004)(66476007)(110136005)(54906003)(6506007)(82960400001)(66556008)(316002)(83380400001)(6486002)(9686003)(966005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/X0dX3TezvQs5Nb8ZCNTCw8DDJz84LcWiD+nZ+WIVME1HTgBcmSckDE94trD?=
 =?us-ascii?Q?DVXasQTf/EszPBKm9E32vcIROZXhDEjCBlsaV8OyQMGmaO+GnmBVqof/hsgQ?=
 =?us-ascii?Q?l3Bu4UkiG6B51UVp8F3OIAs4u6Zly5JyPkOV20JkVC95BrDCfeXIL38H5QEp?=
 =?us-ascii?Q?7K13UTsjebShFmurQprsPdypaXKhfIL+UfIMHpmfiimR5NSGpfo6QTIw6HyE?=
 =?us-ascii?Q?tK0AR5r1BEdDTwqx0RoFM3824LJJn62TSunaB/6kXGZFjOMLz7789ymet0ye?=
 =?us-ascii?Q?BNUHpeBlKrEBIyJH2MYWJhJxESw0i44htlaJ4V48pgsnP4iv84XMeV3muONJ?=
 =?us-ascii?Q?dibivIe1WmkDtSOF8jke9kORERstT2To1ehAoxxbi04I9rS5yFpGUQfh+WqC?=
 =?us-ascii?Q?quEg5NO3stOhqiNF/DA6i6amsOGtefrshM0LfquXhbP02i86TEILmKTU2pZj?=
 =?us-ascii?Q?W1CQOeoAOPulVrDhgROOOy9y5BTPR+4QdmlDKQ6YAtpkDpY1ZOrNZLzjadic?=
 =?us-ascii?Q?0x1sZr03yqGJkWmRnOZ8XNZL3J+Zt6vqJaqXKlaNPE6wZG5/VLUgFDv6S62h?=
 =?us-ascii?Q?pMwqwFinPOUqhuOWz9Om/VY5j1WBo5bjXDY2P2L4P7IMnVjaNPJgcpDRjrcS?=
 =?us-ascii?Q?s1GRyPskb+ooviQoS232mRkcJqkjz+BdTkT/VDktf7TV5EpyRAlt0850zPYq?=
 =?us-ascii?Q?HVkuUrp7ps3SQkWZrskANaMfmCt6ybPpEJ7oOjz5faEHhOIOcbgdT8O47bNA?=
 =?us-ascii?Q?pfL9KhfTcaT/+vGLhgJHMp6Xg6HqI0rrU1N36O4UTFU7d20unsjaHfUNuusB?=
 =?us-ascii?Q?nYovL9mDDy33DUCHP5AA9P3pWUyIQPzMRXK/hlMNAy0sl1ZBWElNE0lAtH98?=
 =?us-ascii?Q?fB3IreWerKA5FTsWt7mex3C4xTPGXtcXU5zlV2O9zFbfvuAX+Fe2WzN3leO+?=
 =?us-ascii?Q?YnJOuvJdy6qaDy+4kiM6YCh7QZL30aKykYa6IGSh61sb4igWeJFifaZOLvGm?=
 =?us-ascii?Q?gTKwOLZhu6lVCzhyzNFFEtVtNO5LEdn5YlkeTfNXT7c6m1re9vZJ8iRQ3UH/?=
 =?us-ascii?Q?HoC57PT3zcFwy5MZllZA0XOoDs9fknSQIQ4f1yh+CvgXTj6rofShaNr2Di0t?=
 =?us-ascii?Q?Hrj3qs7xUk0ZnDJ5akQBKF20h7xCcnul51XR/YFv2zEGvVzdknwFHPyq5Jy5?=
 =?us-ascii?Q?SsipMD7+Cp+cLrKsn2DM7KkDucO+yz9pK4wORCpOrTCIwkquP2mBKDhxybUC?=
 =?us-ascii?Q?ZbRA1bDBlXUAXNTT9qnE7CFoDBgGFVIDVH5WBQdzFid5Oukn0gFBI8qw0A+P?=
 =?us-ascii?Q?Y2D8nRoUdxwGTUcjWtWoiMvQEKAR0/6vOqj9KTenYWdyDOszXy1bcF+aEgVt?=
 =?us-ascii?Q?xh58tQxVZkyI1klVFF3wOaPfv/VyOrWHu2eDEA28lsXsKptj18Yenk7dAkiY?=
 =?us-ascii?Q?7p66CgTeLGZoIivYz82X3L4X1XdmVgI1siPUT4/bUv0aUtqO1IuIQD9avZgh?=
 =?us-ascii?Q?RVfYcqTycXTONM/Rf8SbXZK//YflZkn5EVJ296hnOdRVjtN4fq1sKBAFhzJU?=
 =?us-ascii?Q?NBP/xuCoRKtyD5d119OyBmbb3GqBc1yRKi97DypyqysWjqttYuj6JxBLWaK4?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28aa363e-c03d-46f8-d037-08dbd69f518b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 03:46:36.1802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKGbi9rXntUiogHwFOg8tCEhKDNBwXnkRlomICoOrnRbmffUtfYS8ezFs5iDXO87W/rNi6wZey4Ux/G06DbPQSS1HE0j1roQthu0X1hroGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5970
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
> Binding and unbindind RCD endpoints (e.g. mem0 device) caused the
> corresponding endpoint not being released. Reason for that is the
> wrong port discovered for RCD endpoints. See cxl_mem_probe() for
> proper endpoint parent detection. Fix delete_endpoint() respectively.
> 
> Fixes: 0a19bfc8de93 ("cxl/port: Add RCD endpoint port enumeration")
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This patch causes cxl-topology.sh to crash with use-after-free
signatures. I notice that this path should just be using
endpoint->dev.parent and is missing reference counting on the parent.

I will replace this path with the following:

-- >8 --
Subject: cxl/port: Fix delete_endpoint() vs parent unregistration race

From: Dan Williams <dan.j.williams@intel.com>

The CXL subsystem, at cxl_mem ->probe() time, establishes a lineage of
ports (struct cxl_port objects) between an endpoint and the root of a
CXL topology. Each port including the endpoint port is attached to the
cxl_port driver.

Given that setup it follows that when either any port in that lineage
goes through a cxl_port ->remove() event, or the memdev goes through a
cxl_mem ->remove() event. The hierarchy below the removed port, or the
entire hierarchy if the memdev is removed needs to come down.

The delete_endpoint() callback is careful to check whether it is being
called to tear down the hierarchy, or if it is only being called to
teardown the memdev because an ancestor port is going through
->remove().

That care needs to take the device_lock() of the endpoint's parent.
Which requires 2 bugs to be fixed:

1/ A reference on the parent is needed to prevent use-after-free
   scenarios like this signature:

    BUG: spinlock bad magic on CPU#0, kworker/u56:0/11
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230524-3.fc38 05/24/2023
    Workqueue: cxl_port detach_memdev [cxl_core]
    RIP: 0010:spin_bug+0x65/0xa0
    Call Trace:
      do_raw_spin_lock+0x69/0xa0
     __mutex_lock+0x695/0xb80
     delete_endpoint+0xad/0x150 [cxl_core]
     devres_release_all+0xb8/0x110
     device_unbind_cleanup+0xe/0x70
     device_release_driver_internal+0x1d2/0x210
     detach_memdev+0x15/0x20 [cxl_core]
     process_one_work+0x1e3/0x4c0
     worker_thread+0x1dd/0x3d0

2/ In the case of RCH topologies, the parent device that needs to be
   locked is not always @port->dev as returned by cxl_mem_find_port(), use
   endpoint->dev.parent instead.

Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
Cc: <stable@vger.kernel.org>
Reported-by: Robert Richter <rrichter@amd.com>
Closes: http://lore.kernel.org/r/20231018171713.1883517-2-rrichter@amd.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 5ba606c6e03f..6bbaca5ac60d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1227,13 +1227,7 @@ static void delete_endpoint(void *data)
 {
 	struct cxl_memdev *cxlmd = data;
 	struct cxl_port *endpoint = cxlmd->endpoint;
-	struct cxl_port *parent_port;
-	struct device *parent;
-
-	parent_port = cxl_mem_find_port(cxlmd, NULL);
-	if (!parent_port)
-		goto out;
-	parent = &parent_port->dev;
+	struct device *parent = endpoint->dev.parent;
 
 	device_lock(parent);
 	if (parent->driver && !endpoint->dead) {
@@ -1243,15 +1237,16 @@ static void delete_endpoint(void *data)
 	}
 	cxlmd->endpoint = NULL;
 	device_unlock(parent);
-	put_device(parent);
-out:
 	put_device(&endpoint->dev);
+	put_device(parent);
 }
 
 int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
 {
+	struct device *parent = endpoint->dev.parent;
 	struct device *dev = &cxlmd->dev;
 
+	get_device(parent);
 	get_device(&endpoint->dev);
 	cxlmd->endpoint = endpoint;
 	cxlmd->depth = endpoint->depth;
