Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E257DA506
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 05:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjJ1DXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 23:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjJ1DXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 23:23:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97582E7;
        Fri, 27 Oct 2023 20:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698463417; x=1729999417;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p23Lj7Oqzy8BpNxvod7MBjmccWXWmRJeKVPOxGzPQIQ=;
  b=FJLn/fhGX96THVD8bM3sDMop2tMG2e1CkjzrhNUUbPloHkzQQRGpCCVB
   05f7HOM+qZ1Aby6TPrTEkyrv54fRoyvUrKqqkTHVfEwLxqQsdQihN6axP
   ld6bFMxzXqLREJzOWYG39F3D4rgpgm7hnBZ8vTZayK4l+4sgIimh4B0fY
   kF2HxFCqltzL8tp9xa6tcZtaRTuZ32df3VOAKOcDCnnQ8w9oDCH80mpa2
   lN1taoADRSUHMjdrR2ogtYoNBdEbUK4d6umNkDJ16qJSSE50YSgtswi/o
   4HOHMq6TLC9vFn+IXBPtc0jinsvYfvl/8KoGjkLSvSg4mm44LZhbWsPxL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="454345556"
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="454345556"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 20:23:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="825552378"
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="825552378"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 20:23:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 20:23:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 20:23:35 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 20:23:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fn7icDSgxzXA6eO7d0nEAvnGPqucrgpFccbEwD9Zy/zHw6Ba1Ud5qgg2cEpUQrsLKG2tPsVkoGkATD8Kj64IUbpZcAjUEx39eOu/fGKVz4C+nPrY7Gcfw2yqFZcY+iW2isX+jTFbR2M8B5DtCg4u5FiS7qjxQ0uOcD/iVMZzqigzaDQuKae9Wxe6HlqL6VoFYxB2QVLZn4ROCZ3FxO8CYGRvBOq7nF6JD1SknjRmGb6sQfOOZwF8XKnR9d+J90k4jpZJYWQCHkUJ10HqXXUIKDQDLsX4ZcJntnYGm6fVUZkTsr9LXLMQD0xFXgSDw3B+sY7gdWNkcMYLkM/AjTDrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDw+XDt9tiWYXJcHUIbUc/1S92nKf3hajdZyYXk2b1E=;
 b=ZbLyP6pG08oOmyyOoOwBdeUYQ5YgiosaS09E/0b8raAQt4oRsj2fnWeMr1Kx6Y5IPeEDfGE1+AKTvozzNQ2PaWoqKZLZiqn51s2WGOh1roY6kQS4R3wD7xiJUjMT3MpKGS0N/KgWTOeIz4bopUGkzio1eZ2QF/vJ71W3sR57PaLLu1xk4xzMPag3+4rHrGsSAdewNiBdODI1XeFbHa+gyoOoWdnjPk5EFMZGXLfw8xZvlDKH8mgyhQ7GVSEbmnAk0ABhgfuAPLVJNqo36z2ZBddo4KUY6tvqiMjS2JPnlpQYGVt9b18931l9cdK3zu3Vpbyqsc83aC6YklNlOS2wLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4767.namprd11.prod.outlook.com (2603:10b6:806:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Sat, 28 Oct
 2023 03:23:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Sat, 28 Oct 2023
 03:23:33 +0000
Date:   Fri, 27 Oct 2023 20:23:30 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Robert Richter <rrichter@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v12 14/20] cxl/pci: Map RCH downstream AER registers for
 logging protocol errors
Message-ID: <653c7eb29265c_244c8f2944b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231018171713.1883517-1-rrichter@amd.com>
 <20231018171713.1883517-15-rrichter@amd.com>
 <653c36be4b5bf_244c782942e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <653c36be4b5bf_244c782942e@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:303:8f::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4767:EE_
X-MS-Office365-Filtering-Correlation-Id: f3351727-0cec-41fc-5806-08dbd76543bc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GP0u+1hJBiIO4zz3ITJScoHHkj4XhT4lJXyAZSE+qFKO0N/6hRSMgqjXtvy4QMogz5n+dDgl/xV8pA/lQHKm7iX0ByJ/NomCvv//RuyFr4stHc+02ZtAF6T1HQTq+pCVDUrdqLWZ3Evh2aqPpe09jiU4AIU/lKUIyrAAWtZH6j5ynri92CXUOmXMTEUK6znHlfcPHMtrWxBmMzcfGzrUEDoWxR+D5TZRPvJi8hae9DFl07byyJZqxhY92EXfPx7oiu7jqZLW/gozHfLcRW8iQZjU4+3Om6qbVytwk8siyPzSRTwW2/a/qSoOxA2Ab9UG3L7yhNb4aP+nzJtejuiYYnapZI1AmlKFkM/CwMr7yGIIHehVEYWGVt/+IsI3hwMPFwjisSdI7APFBZXFSwWNRX/7IXqk489D9YeQbBOmEf9gCUZ0xQumWOqKac72+3U7ezR9BSz/ryMjeC2upxt9CtzAZKilZQ6GPgGJRzrvB1guqZjzeYXe7ROeEwX35prHsmv8fo2/OmXZZvwI/IJQ0ZidHusobepiAK64aCVbhfxQmrntuKEJkIdNTl2xCpJz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6486002)(83380400001)(26005)(478600001)(66556008)(6506007)(9686003)(6512007)(66946007)(110136005)(54906003)(66476007)(316002)(38100700002)(82960400001)(8936002)(5660300002)(4326008)(8676002)(86362001)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eOB+S2QyJ902WLBN5EojwuIgZtxKvm2nWcvhr9Std2B9LQ16Gqg/RSi6FJre?=
 =?us-ascii?Q?Q/BENyyFhyxJXch8hMlBcQDEnCaj9mDAn+5vOt3WWyCyEs7SGsUDKTnMakkj?=
 =?us-ascii?Q?TatSiik2On9lsWHzTM/uYo8W+a3+6jcngXd8lW/pbdu549poFqWV6N66nTVi?=
 =?us-ascii?Q?8Oj0GjjNVYnUntaGwXP/KhmLX9MI0a5Ov5WV8pfHeaptiXrXUtw5Isn/fMxM?=
 =?us-ascii?Q?jNyXyGb5InJggh800TLG53tlSgLTafYWDPXIplGZMLA/2R1cQSscYgQ/ZQo9?=
 =?us-ascii?Q?NdDPHaBZ+LiTvJBSfhliTImeLOS2A4lqbw/+XklIuoAl2BhvOvuKCaZlQdXC?=
 =?us-ascii?Q?XKUPxsaHQDvTQMkynWBNNRHY3yumk5mdV9P5VeHPTVvGKKaKoCY3ttBJXwcJ?=
 =?us-ascii?Q?Y3cGhwGlNK/BSFvqfo0YnqP/P9JR7cepdG9WlLvT2uWntZKZc9Tq6P5GfBFg?=
 =?us-ascii?Q?U1rbS9iHbMtd0V32qj99lU+5Lll4tkyxKR5rrIJ/8mb0iqD+TVYheW5nexUo?=
 =?us-ascii?Q?emP5CteIE6zHcbf0b3bMShG43inVR12Akoo49SX/8VFxJ6JQkvZOFL8qq9J1?=
 =?us-ascii?Q?qsk3cH9Zb6VQOWHwDfnjGmSAUQnAkyUgRO0gHqdSiuMPU2H35O6vm7uZXmTL?=
 =?us-ascii?Q?Mdop+W2C03bYFpeG4lRu99IpM5cwviKt8jcBYYTXg6NEwh1j8/cvB4seJKzs?=
 =?us-ascii?Q?m5weOioZbAZ4Ni09knA3mFt37t8XRP7BphPdAePFpingSaDuZ44bUYgpeLxT?=
 =?us-ascii?Q?Br7xIRavscfzuV7rOlkfi8ik4cbPp5cAvng6zelUjABNowWpksGqOATsGI/5?=
 =?us-ascii?Q?wevXvL6I0bnWfZz3a8Z2lJqHcbulz/LzaS+9ty6DD5kxol+eNmRGDaoQNHi0?=
 =?us-ascii?Q?GLCPdUNIqBfR3eL+osS1O4uhg7cC+Y1GTQJT2fNQxWB1JAT53JE+E983K0w0?=
 =?us-ascii?Q?vo0Rlbh0yswJesIOKGsldv99GpT4vGsTm6T94xx7RGofWNOQHUXte6wpsCG1?=
 =?us-ascii?Q?XjqN/ZRupsWikte/5N0MHtYjAcgCLCaI0oGJKGChK7ASIUr2dbmTPMMnSCbO?=
 =?us-ascii?Q?FV/9lX3Yb1q0M4P5YCS42Fh5RGOL/QENeF6RM0pIyRvHjY5SCAkgrxVHDQhh?=
 =?us-ascii?Q?HfrZS7n+sUGIJLsy4H4zqcHdSbaoP2BN1u8sMtbztwA/zudf786VRqvJAc0Y?=
 =?us-ascii?Q?7OjlvnyuCpxgTnFqH1ydm1679F5v4sOWmkzbkbq+6By7lZeQP4rdSsFEyj3R?=
 =?us-ascii?Q?eTrfdcvE6klNGHQi2KTUIZD5WExIMdu/oVZnqW+BRQiV4+XOZCV32adUlak5?=
 =?us-ascii?Q?hUF7VBFJgrUo7/5m/5yeco4DwauYrfmnfiYYzDoGL00NdR0VniR2d6RT6iDI?=
 =?us-ascii?Q?JJYgr0BTUbJjDqr4iaNlyUgtTE6Bc2iuqJR/ws83uNXp5tXfDbSToERHvR37?=
 =?us-ascii?Q?FtlbwTqGwQ2PdnkfyBKQk/hdlqUOPT3dT9/J08wzYQOP0Qy7zwqq63fPq9mS?=
 =?us-ascii?Q?j9DFkPZhQBUwSABiX98SEZUYv2a9Q1Y1uJ6t46ElV9S33OSWAxzYRvK3fb7b?=
 =?us-ascii?Q?NzDGSEBv0hGnqLANdz3clhd942N8pGr1UArmf+nWYlkmXU9pYw3LcTHuZsUJ?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3351727-0cec-41fc-5806-08dbd76543bc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2023 03:23:33.3047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jASCk/PidbbW+UMGD8XhdiELMsO6tY8Mv4uCzSJAIal23V+dNfnftQHDbwHLDHrcJDiXFkAS3ZGl5k6aScXkOwTfLg6tsUWVROqFsnPmpe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4767
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

Dan Williams wrote:
> Robert Richter wrote:
> > @@ -730,6 +731,38 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
> >  
> >  #ifdef CONFIG_PCIEAER_CXL
> 
> Here is more code in an ifdef block that has no compile time dependency
> on the config symbol. Please do not use ifdef blocks for runtime
> dependencies.
> 
> Again, this will need to be a post -rc1 cleanup.

Here is that patch:

-- >8 --
Subject: PCI/AER: Increase compile coverage of CONFIG_PCIEAER_CXL implementation

From: Dan Williams <dan.j.williams@intel.com>

Per coding-style, avoid usage of conditional compilation for
CONFIG_PCIEAER_CXL related helpers. Instead use
IS_ENABLED(CONFIG_PCIEAER_CXL) to check when CXL error handling is
compile-time disabled.

Cc: Terry Bowman <terry.bowman@amd.com>
Cc: Robert Richter <rrichter@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/pci.c |    9 +++------
 drivers/cxl/cxl.h      |    6 ------
 drivers/pci/pcie/aer.c |   15 +++++----------
 3 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 3da195caa4ad..2d7ba1899ea2 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -729,8 +729,6 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
 	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
 }
 
-#ifdef CONFIG_PCIEAER_CXL
-
 static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
 {
 	struct cxl_rcrb_info *ri = &dport->rcrb;
@@ -797,6 +795,9 @@ void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
 	struct device *dport_dev = dport->dport_dev;
 	struct pci_host_bridge *host_bridge;
 
+	if (!IS_ENABLED(CONFIG_PCIEAER_CXL))
+		return;
+
 	host_bridge = to_pci_host_bridge(dport_dev);
 	if (host_bridge->native_cxl_error)
 		dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
@@ -897,10 +898,6 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 		cxl_handle_rdport_ras(cxlds, dport);
 }
 
-#else
-static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
-#endif
-
 void cxl_cor_error_detected(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 378fc96ff7ff..0bf0d13346c2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -712,13 +712,7 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 					 struct device *dport_dev, int port_id,
 					 resource_size_t rcrb);
-
-#ifdef CONFIG_PCIEAER_CXL
 void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
-#else
-static inline void cxl_setup_parent_dport(struct device *host,
-					  struct cxl_dport *dport) { }
-#endif
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 41076cb2956e..36541bfab688 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -934,8 +934,6 @@ static bool find_source_device(struct pci_dev *parent,
 	return true;
 }
 
-#ifdef CONFIG_PCIEAER_CXL
-
 /**
  * pci_aer_unmask_internal_errors - unmask internal errors
  * @dev: pointer to the pcie_dev data structure
@@ -1000,7 +998,8 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 	struct aer_err_info *info = (struct aer_err_info *)data;
 	const struct pci_error_handlers *err_handler;
 
-	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
+	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev) ||
+	    !IS_ENABLED(CONFIG_PCIEAER_CXL))
 		return 0;
 
 	/* protect dev->driver */
@@ -1041,7 +1040,9 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
 	bool *handles_cxl = data;
 
 	if (!*handles_cxl)
-		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
+		*handles_cxl = is_cxl_mem_dev(dev) &&
+			       cxl_error_is_native(dev) &&
+			       IS_ENABLED(CONFIG_PCIEAER_CXL);
 
 	/* Non-zero terminates iteration */
 	return *handles_cxl;
@@ -1067,12 +1068,6 @@ static void cxl_rch_enable_rcec(struct pci_dev *rcec)
 	pci_info(rcec, "CXL: Internal errors unmasked");
 }
 
-#else
-static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
-static inline void cxl_rch_handle_error(struct pci_dev *dev,
-					struct aer_err_info *info) { }
-#endif
-
 /**
  * pci_aer_handle_error - handle logging error into an event log
  * @dev: pointer to pci_dev data structure of error source device
