Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D004F7DA4AE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 03:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjJ1Bjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 21:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjJ1Bjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 21:39:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A32B4;
        Fri, 27 Oct 2023 18:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698457175; x=1729993175;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bz8zrsVVA0R8sNMQ9VLotGtSbjv0zAbM+WlXg7DBTOQ=;
  b=DN4U2AhQj5b0sHtxxTgfxQQdGWgfklprJV3tM2eCIQ7y9xLXhwQLpwEJ
   n+QEIznvrKYV2d6OX9gzov5ti4+oZyM2NK24nq54EbuW2qo+yzZe55gCF
   jOoc+8bYeY9srbeoZdeFf/7ZALooFEpIcV9LDL/Ovshtmmj3moLGqs/aB
   7xKVbMXFNsvqmjQyPDUwETVxsS/OLUDjLpzPlNgZm1zD+vzWHg3h8wUrW
   n2uFp2OGFmwx0MUE2W/tBj2I7MXQHpdeLu5OBgty01+2JDy2976M+fTlE
   Lc8aq8BKNZx5U7+lr/DVlQn9+GiIY+3ZVigV8cYj8c+xcnKEHQydONtLX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="387684654"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="387684654"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 18:39:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="966718"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 18:38:59 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 18:39:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 18:39:34 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 18:39:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMe8LJ338vTaDpA0HOKRwWQVQMVvPExZJ8Wet9Vj5mgRSsy0pdlQOMvj+iBoHWEDbtVWpQ6+pCcEFxlbwcS69gk8BY4QrfKMHAITieGY+51nhhGXsb/Y3hdlHfbj4HUM/FjP+eUG3CXI6hCW860MqaIGGKVnTXkhUBLK15Xb2dPc2O+fm0xc45e3NxR/KuxRqU104Sb4cJLjU4Y/is8R/8K3ZJYnj17KsPp2qvqIZ8eHxWbfKekhwFXks4/12UGvDGqRtCnr6OFa0vNziTO4leG0JFDvz4DWYi8IGx0l1Y0+ih0PHKFU4S1vl4X0SP7UZ1850LVbFJ9090DBtkPA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svRmoenptExFL6fGaFYyjRa+lX4kN/T3MyA64wDfIEs=;
 b=Lxcbjqjr9HGo64b8Q2czX9kJSR2jnYZjopDKjsNTXCCeGcsLLjPGBUTtFAYc0y3ivEsSUL4PMgvJmt+1ayUMs4xlYM8ksIK+pDatI+pOoFK1Fuvh2SdkL2xUfLPKcdalY5TGkEhpeG3qdiJQSXzLhEt4g4ndpB2QpVpSdlFlJ8t8l6xvW7arx0TMCZniYOALVkdZBAxcKJSzp4entPacelcaV9L4BMaipVrSz9i2lK8/3PPO2XDqmnmLd7xRzO7sP23bmB2LZxyFCb49FIlhhI+z3L6H4GxnHIF9xl52lhWCw1Njjj1ar/oU8UzCeYkCu0zh47QImrTAvMh7eSCPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6782.namprd11.prod.outlook.com (2603:10b6:806:25e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Sat, 28 Oct
 2023 01:39:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Sat, 28 Oct 2023
 01:39:31 +0000
Date:   Fri, 27 Oct 2023 18:39:28 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Robert Richter <rrichter@amd.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Terry Bowman" <terry.bowman@amd.com>
Subject: Re: [PATCH v12 01/20] cxl/port: Fix release of RCD endpoints
Message-ID: <653c66507bf8d_244c8f294ea@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231018171713.1883517-1-rrichter@amd.com>
 <20231018171713.1883517-2-rrichter@amd.com>
 <653b3299c1a33_244c8f29449@dwillia2-xfh.jf.intel.com.notmuch>
 <ZTw_xd2_uaApAzoL@rric.localdomain>
 <653c5691a2372_780ef2949b@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <653c5691a2372_780ef2949b@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR04CA0116.namprd04.prod.outlook.com
 (2603:10b6:303:83::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: a152baa3-2679-4b7c-b1d6-08dbd756bb28
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNi+JLIt1Jl5UjBFHFYtki79WOJ1LhReJ1bjSPMcnQMmlZ5L3kLCfefMMtlthIR8KLGgbLAYqlWD1YlgEridZVyOCvAmEvYO0tYBBWYKVoABftxawfFvlNCx9TFZLvwGFKJiejrfI2fX+tSC1eUjgdJ8Lr6RLeSpKCQM3wHGN9uR95d7GSI3ggt2ebYdfbK0QTGCwtdLV6nx6aY2Au4ttvlmVHYI7xSCzXu20lfablheWiq93/GmaarA6dwuEjoB6a+lkqLdk4vUkU6I2UT2xElYtVKmsYozUoMk8726nxjC0QxqGdkroZfxBSIzh1iTPu5Lc1bsA1uwbYqrQ5Kb80nx3b0sCQR15mDuo0hv+Cvnn2ba1XqP0MnCgkEnhdoQnZTKkuLPvTMUJqSUm/d7xyFMzG0BqOKtOVsQvGggB3xyikFAlbguHdbPe0bcgiSDB12rZEVL5Pqj2jmKe9/cwVMqMaa847FGozpko8hNG1Z/mRIxkavsdIo8CgPgr0+9hWP7lmGZ0qyVAkRhlEhzxs7OapWv7oItAgb5xmud+CwllU0b4LeOo8fA195jt3fc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(6506007)(6666004)(82960400001)(38100700002)(86362001)(83380400001)(9686003)(6512007)(66556008)(41300700001)(54906003)(66476007)(316002)(66946007)(5660300002)(110136005)(6486002)(2906002)(478600001)(8676002)(4326008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Poq4eXIPL6bpTAZyaR/nIo+NvdssBWnUdx083W5Kh5+q62erZTfeLluTvM+f?=
 =?us-ascii?Q?31ke0U9wIS9mtdwz8iocTVMj/7s2HIpR2MhOpEC7P/TAcnfjL/xtGXZslS8v?=
 =?us-ascii?Q?iWt/8DkChTzKfxz5v6lQXcu5sDvH1Z87RL+pcvgVGq8sauBDDHexunqMetPU?=
 =?us-ascii?Q?xvOZvFGyFYbwmjmI8yuOv4ajRjUug2Z4sWpkhkuFeTCHq79l034fWhgG/ifQ?=
 =?us-ascii?Q?tfeyMSHf5Uxs0kP/mZklsM8OJr+L+y2OML0z/m8qe5scai6Ud8qM2eCBKTm0?=
 =?us-ascii?Q?64GIe1dSakK62jeK4FgRNELH4DUzYBmEB5QnExiVkT/bFGdJzievEjujwoS8?=
 =?us-ascii?Q?O0CV5ns9nTzC6io1dwfgheFsDLGIvJyfQhIUTdRpxkmSF+aIsu6YIAstuwgu?=
 =?us-ascii?Q?bGvW00L3uwLnvE//3Ip732hq+1MQRfp77iNcgRseSetVpml8Zq47v67v6JZS?=
 =?us-ascii?Q?v6M/3cCrKe98hgEmj6lrdWF9qMPxICDBAtou1UDM8AbYwLxaojM/JWUBbD+w?=
 =?us-ascii?Q?f9bIfGHcPhyDzA/+wo3dUdl240YVnVIj7LN4Ow83MSXNmKwQJQYh+MAhgVn7?=
 =?us-ascii?Q?t9kYf9oPx3VIAIl3LbhItb4AoehPKHIfW+W37gB5Dnubz72acvoBt4oJN6Jr?=
 =?us-ascii?Q?QNEKzAPzZzW//CmeIaCWHQluMieHFU9h4t1FeSQyGKOxI+0gS/IpZQyWgwqo?=
 =?us-ascii?Q?/AMqDgQ+lUZVZyKjrcQH0SDRclSMZKtE2vvK7gIEqktpK8goWwlNIxJvQuYi?=
 =?us-ascii?Q?dQu01d9ZIEggsaAPxzCI1TrrkvHf0S8tO7cA3Gj5l+p0C0YlFWTXyqH4QudY?=
 =?us-ascii?Q?3bK3AtRjSfIziBrxQBvGnH3cuiQyP01tjITsVM7mdVBTsKPaifijl3LmMg22?=
 =?us-ascii?Q?eoAhR/Fjx0fPHr0xkggwBOPrNDQvK2yA7ppX5iIsNlUHx++3c9ocJgSobR0M?=
 =?us-ascii?Q?9VoBQVTKxNy1rlnoyDHjY8EsrPk7nBfoomcjw6bj3UwCiFTziqAhONCNOyXp?=
 =?us-ascii?Q?9cjfSPBCYARBfaGBs79mJ6OpUFWRWFFIBBlTXsQhJ0U2BYnY5vUie5wyIRHd?=
 =?us-ascii?Q?WHTeyFuOvsHirtWVT8tebQIGLF51qJVoll47oK8Jm5tCdSwWrZgQT9SV7NyT?=
 =?us-ascii?Q?476iTDv1DuLyhGdRNm0dPzC4t2TxqMF4V6pnFqOIBaFuoo7FSkZfhM8I45aN?=
 =?us-ascii?Q?7kOlhcGzGEQslRvSQgZ8FjWre08+lpDTZwpg32ETQOm1snR7vsOFbfwtHKMd?=
 =?us-ascii?Q?73DJddCj4qtRh93U+RNylxjVr7sxW3y++Q5unYlRLVMZdN2bmKgl9tw+Ly/9?=
 =?us-ascii?Q?JslApm3GcCETozuGec/BzhSXu9QxUAdYQr4X+mbCv6n4LMepknlHYHhlZO4O?=
 =?us-ascii?Q?AWbGTPK45t4ynsgx8lW4M2hMq0x5xuR/7CAnkGooT1P7qIjyVPRE0AhAsQkx?=
 =?us-ascii?Q?FtDzZJJsc1R8nHUc4ue+mXU70g4w8U8HsE71s0C49sPhoPv1aCvGk7JGJPGF?=
 =?us-ascii?Q?Hlf+nMbQQPiFg9LCRSi0Pb9CIENhn1a4LbVT/Eb4XIQBQdRn4iRgCPQfUel6?=
 =?us-ascii?Q?Z95zf9hNHRw3j+ox8sCo9imbVsneIjNHfWGGBxeiAT1OLGfp8CPpYRl+dCZI?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a152baa3-2679-4b7c-b1d6-08dbd756bb28
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2023 01:39:31.2114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0p6LcGnMkzj9Y6aXw8NEF7+44o/dW7yX1pcXtaClHc3WAmC07RahTpWfEcgtsFZm6lxnTJIT/AWkBAoZFpWBbawWg2jdVxSXLhrjNN/1Nks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6782
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
> > Dan,
> [..]
> > 
> > delete_endpoint() is called here, but the uport etc. is not unbound.
> > Which means this is not true:
> > 
> > 	if (parent->driver && !endpoint->dead) {
> > 		...
> > 
> > I don't remember this with my patch. The parent is there different, so
> > that could be the reason.
> > 
> > I could not yet look into more detail but wanted to let you know. Will
> > continue.
> 
> Apologies, I didn't have that regression going, I think I see the issue.
> Thanks for the heads up.

Here is the incremental fix on top of the lifetime fix:

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6230ddfc0be8..0fe915ec2cc2 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1217,30 +1217,39 @@ static struct device *grandparent(struct device *dev)
 	return NULL;
 }
 
+static struct device *endpoint_host(struct cxl_port *endpoint)
+{
+	struct cxl_port *port = to_cxl_port(endpoint->dev.parent);
+
+	if (is_cxl_root(port))
+		return port->uport_dev;
+	return &port->dev;
+}
+
 static void delete_endpoint(void *data)
 {
 	struct cxl_memdev *cxlmd = data;
 	struct cxl_port *endpoint = cxlmd->endpoint;
-	struct device *parent = endpoint->dev.parent;
+	struct device *host = endpoint_host(endpoint);
 
-	device_lock(parent);
-	if (parent->driver && !endpoint->dead) {
-		devm_release_action(parent, cxl_unlink_parent_dport, endpoint);
-		devm_release_action(parent, cxl_unlink_uport, endpoint);
-		devm_release_action(parent, unregister_port, endpoint);
+	device_lock(host);
+	if (host->driver && !endpoint->dead) {
+		devm_release_action(host, cxl_unlink_parent_dport, endpoint);
+		devm_release_action(host, cxl_unlink_uport, endpoint);
+		devm_release_action(host, unregister_port, endpoint);
 	}
 	cxlmd->endpoint = NULL;
-	device_unlock(parent);
+	device_unlock(host);
 	put_device(&endpoint->dev);
-	put_device(parent);
+	put_device(host);
 }
 
 int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
 {
-	struct device *parent = endpoint->dev.parent;
+	struct device *host = endpoint_host(endpoint);
 	struct device *dev = &cxlmd->dev;
 
-	get_device(parent);
+	get_device(host);
 	get_device(&endpoint->dev);
 	cxlmd->endpoint = endpoint;
 	cxlmd->depth = endpoint->depth;


---

...and here is the new regression test so I don't mess up and miss this
again:

diff --git a/cxl/memdev.c b/cxl/memdev.c
index d76a4d86a40a..81dfd4c25b25 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -752,6 +752,8 @@ static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
                        if (end[0] == 0)
                                continue;
                } else {
+                       unsigned long domain, bus, dev, func;
+
                        if (strcmp(argv[i], "all") == 0) {
                                argc = 1;
                                break;
@@ -760,6 +762,12 @@ static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
                                continue;
                        if (sscanf(argv[i], "%lu", &id) == 1)
                                continue;
+                       if (sscanf(argv[i], "%lx:%lx:%lx.%lx", &domain, &bus, &dev, &func))
+                               continue;
+                       if (sscanf(argv[i], "cxl_mem.%lu", &id))
+                               continue;
+                       if (sscanf(argv[i], "cxl_rcd.%lu", &id))
+                               continue;
                }
 
                log_err(&ml, "'%s' is not a valid memdev %s\n", argv[i],
diff --git a/test/cxl-topology.sh b/test/cxl-topology.sh
index 89d01a89ccb1..0320887a953b 100644
--- a/test/cxl-topology.sh
+++ b/test/cxl-topology.sh
@@ -120,6 +120,13 @@ count=$(jq "map(select(.pmem_size == $pmem_size)) | length" <<< $json)
 ((bridges == 2 && count == 8 || bridges == 3 && count == 10 ||
   bridges == 4 && count == 11)) || err "$LINENO"
 
+# check rcd endpoints disappear when disabling the memdev
+m=$($CXL list -M -b cxl_test | jq -r ".[].host" | grep rcd)
+ep=$($CXL list -E -m $m | jq -r ".[].endpoint")
+$CXL disable-memdev $m --force
+check=$($CXL list -E -e $ep | jq -r ".[].endpoint")
+[ -z "$check" ] || err "$LINENO"
+$CXL enable-memdev $m
