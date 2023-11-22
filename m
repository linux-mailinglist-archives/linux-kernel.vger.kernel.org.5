Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C397F3C11
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 03:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343535AbjKVCtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 21:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjKVCtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 21:49:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9C61AC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 18:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700621351; x=1732157351;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1IPWdrxMjUx+zdbEbcwRXBtsKqM1jihITQbO/mQcJDw=;
  b=AxqsW3GN5KCbVpHfOh42H8dVtl9WEoByUNqQFKEOXZt3O5hqzVf7FaQ1
   3vYBYVFMNdJv5pcozIPXlWKijPnhHrPYSoQhFMLKBh0OpcJoFm4ppsytH
   DeieqNVcuxrqJSNAiIhsaJlL+dmx21DIBiEJBlLuB1lorybbadSROGrk1
   hDRTho5xqiTu0uM7V/kxY9jHWyjCCcUJXMhZPhVPShItJSjWRbFN8WKPz
   4W2z/nDVq4HUnIAXMGdYvgdc5NnPSn7ErX07MMtnlm2io6/6bHcQOhOmU
   3UswV0jyCN9CGbdUQzTdb4Dru15IJJZdZIObxfC3YcSHwAWb5LjnbntlQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="5166206"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="5166206"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 18:49:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="795952441"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="795952441"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 18:49:10 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 18:49:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 18:49:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 18:49:09 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 18:49:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9w+T9nkz5bKZhSgo2mEMsldEVmjMIR2pKU6Cf+k6ASeWcYJoj4QXXnhMCxepzak3nJ43c/ZejwDnL3QEu/pbr18t8uUHJpqFhxl8UdVhkdGgQVLaFdoyNznxcez6ARRISu28vNVWETXAwCswX3Cjauy/hK2Dj8fLHz1NPJfK7FI5UScSCD6lAe7eaPR3jViSgAF9vUxtX0x0RV5ul66xsGiKDj9ttj6vMG190GCRlZwbGRp9aKQmQAGGmt0PIHZTkRFX+/r3HsKanaA3pJik33G8ySDzCAdcrCzISV+0CaDWLfF4WKmagFkiuvbzgVp7MTQp+na9CcxzdaEPCSEXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBnCXE4YLD+t/qXftOku+5fPKUCukvn1edVbCryEavk=;
 b=AR/dTS0yJfCwtdDhwzng26BprT4euSsQhOXtcWDfp5YWf51sOTPK8D/GEHm5zhK9t5OxzKFsabiOFTk1zviPIcmJHwIg/U9g1lcv7ITsXYjpCQoAD1mcR3nsR3K2qaOkC38+YL8vqfH71JnrPuyPKG2yarocUtkequE0g7lySofbEhq8tz3QYc3Gl8ZffWm957iJOP83dNBnu77OY1uhzVm0LlTAILF4nRMgtBdlqeuWk5DJ2hgUxhJnOywb16MFobaz9UvaO5bqrMe7nsQU9MbK4X914Jguuuh7EEwMQc6Oewj/KOr3C6y2h+XAlJQUD4i+5iZZ5NcGv79jwjbVWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MW4PR11MB6740.namprd11.prod.outlook.com (2603:10b6:303:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Wed, 22 Nov
 2023 02:49:05 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 02:49:05 +0000
Date:   Wed, 22 Nov 2023 10:44:28 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: drivers/hwtracing/intel_th/core.c:812: warning: Function parameter
 or member 'ndevres' not described in 'intel_th_alloc'
Message-ID: <202311220224.smGIP2Re-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MW4PR11MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e9936f-a997-47ca-31a3-08dbeb059751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhROxOrpSTXccRCXeXt9Nv8trZ5/LGnNeKi32dX+a8G1yjIbuT2aVb7NNw/nIrmATzAWn1efO5hIRG6koHqR+TcLSP7u3wvjWUn2y1mZ42rMLFixMi7E+GQ0uynoOJiCjA4d48vd6Szub4qtjR318Ehzzk/FfFyOWXyS6panrdsgJbBW3w2oJWexfcA6QFv4iLF9qFnwsFervt7GsC3IZt2DcMeAc+TUSaG4nq6bdSrf6jmJu8cIQYQRdWT03RH5MC7MrIabn8nmU0cNavbsdLri6VoJR5VqD9e5ObMgCKFpYm8NBtSWnoM2ZHgb2g9UA5RbcF56eeFA/K7qUAFKzXrq8MxUCM6LPc+4TXoXh9jodKrJ582Tati+VnRB5tbLgAnP9sNRqAZKM77OaQsEtJXtGGyjyZYi7B/XjBlQg4dNtm3yzswRX74eEgsE3UIbxDOZtTIl4uBceWjvuDivenTkHiwXDlAMx1SWbpmjWVcgXlCTGr1i64hrrDn2VR4D+2vwo2yalUhz6dJCYwnyWs0i5FsD+FZtFO3p4wCAkHExMAgOwRGoSD0ewZhQ5lk/sCYXR7BW0KqxwNBZhpYLE0GeLbF3v+57RHKwPKqhRsCwYHhACLeD4/znERImvz/Y/4U/G5cbKYAt/Sq/BPRMFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(346002)(396003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(6506007)(478600001)(2616005)(6666004)(6486002)(966005)(82960400001)(26005)(6512007)(316002)(6916009)(66556008)(66476007)(66946007)(38100700002)(1076003)(8676002)(8936002)(4326008)(5660300002)(2906002)(86362001)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jfng50bLs+jDQBxYiN9eFwv+DkMA74myVITjHLvj9eo4pR3DsfRWM6o+/2Hm?=
 =?us-ascii?Q?7lxkL75CpXDeLgU2eHP5wXLws/95n1ItebnQ4ROPNcl3PrMqK7Hv+7GWfJD6?=
 =?us-ascii?Q?kvql1nsftdj3QCuut35N5Ffsg7dJUXwDwY2ItTZLPR2ZzeRdPz++Tj001TcO?=
 =?us-ascii?Q?wvkM36t/qBVqnEBL3dVgeinfUWoPygL386WTN/80kmJoIXaquQNjPBM0OtAW?=
 =?us-ascii?Q?5prCGQ6i8G/nWskVbDKIIt0k0r6mNj6o8WhiAL5TyX0P68ehmbgUU954aoMn?=
 =?us-ascii?Q?iC8/w2mvbm5fUn/4NW7sDwIIrwXX9DKS0o5a2qED9/tCZi7ZFwI+cJ2bjJDR?=
 =?us-ascii?Q?A+u+iT77HURIpA0GMMwWNZIvptoss7H3HBX9lHBuWeq4EMNUxHz5hjR8iDvV?=
 =?us-ascii?Q?DkokD7rAdGytop05pLi9/XzKxRzJG4gMjLbYR6bgGLmrjDd9xUWbMTdELFZa?=
 =?us-ascii?Q?Q6niHA8zsdvK+zYyYQTUFpFfrKzcHBBYqmZxDOTdApAZtGMRjukpSXh/BD6T?=
 =?us-ascii?Q?wUnKxYtYTy8YkcJUOZuIJRU2j0n1w3RRVAZIt5EPkjscOe7p7dovj/lLWYkS?=
 =?us-ascii?Q?DkBAgyjKBNORhMDWk7R6+nXB1VbfiZ8P2nZfyl8qf8MPqSqs8F/Jt/J7Bv1+?=
 =?us-ascii?Q?E157xn3gzzQrFoiR8+Mxo3evmJ61JP+agb+rQk153paMg8a+HxyX7SEJMRlV?=
 =?us-ascii?Q?hyeXwrgSkkfMD2lM5q/riSwaaLY28Xz1vrr1JZpIwd/epQwwowpWNQc/00gN?=
 =?us-ascii?Q?9o7Q8GwOMgTi0V/ZynrQaRDAGPOCGD/gE1Mu0WXJwGxhCgPpo8Zh8oCE6z20?=
 =?us-ascii?Q?XoPsV9hkDrPiFrXTi32d8irBoM/w9vw8ifgHBBxrpuw6j299rSZ2/MrdUkoL?=
 =?us-ascii?Q?9vjBIff9l/Qm8sM0zVeVtBQ0WLYL0MP/zDgjVin4Vc35CfkmNWJfd9NT5rJM?=
 =?us-ascii?Q?Xt3im6OG+xsD1zC5ON2I3RSjx44mYPjgAS06A9jv9MstnqiMQUgLetEUlbHX?=
 =?us-ascii?Q?VursVSHlvavHlSWWoQS6XymQpiRvc0tJn0i8k5UyPMJnf4MMziakNnB38H0j?=
 =?us-ascii?Q?CFnh8/CjwPLBysLQqKyW7wapPAN0jomTm9n2s4a8rzsQhfN4/Sh8nq7IkqIR?=
 =?us-ascii?Q?ORvANW2l83X8AzIUA5rWWczlNRBD5JXz7MvAD2HOhhf22LgGRvCMPiT+RYkb?=
 =?us-ascii?Q?H+dJkJKrc8gkzyHkZHkOEhgwUR8o6M24u2ZqK45NJWxYpjvcZkDvnH9nQT+p?=
 =?us-ascii?Q?mv2/SpBxTN/j0qcgoY4gz2O2Eadg584mWTO7BFLOge+aZ4ByPAfyr37RL8Cq?=
 =?us-ascii?Q?lzB2K5TIa0whBgZOrPefAXqHqTYmdoJAAsl0wVq+mI17ZwgvmbWq95UpPMCS?=
 =?us-ascii?Q?4wPguxOEh1MmLGlqBG5OwvGwzbXqjsiQsLInjx3ZWJI2ctw3ZQwnIWPWrN17?=
 =?us-ascii?Q?gvcyuzsdYdOMXSNrkP07YJi4c+jFAh5FWcU5Z/QyVxQ+860ZTNZuhAHnMNsV?=
 =?us-ascii?Q?k2S5y21U1nKFzjNnsb/4HtIBuaVJB8xvqYvkq+5smHy8tF6F0msqqwiWG1vd?=
 =?us-ascii?Q?zAw8oWt4/g5SD8bzycovJg8zmR2wLe/oqXQikID9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e9936f-a997-47ca-31a3-08dbeb059751
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 02:49:05.1966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOi1UZMo+Pry8dh9SbhGf4PWtPbIdYoylZaUxslheXfKMnREZawcNHjKvW0t8ck/ySEECmP8mkQY3XfLkapHeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6740
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

kernel test robot noticed the following build warnings:

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
commit: db73a059de00eed721f13051c0d6ff3e7de90fe8 intel_th: Rework resource passing between glue layers and core
config: x86_64-buildonly-randconfig-001-20231012 (https://download.01.org/0day-ci/archive/20231122/202311220224.smGIP2Re-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311220224.smGIP2Re-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311220224.smGIP2Re-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hwtracing/intel_th/core.c:812: warning: Function parameter or member 'drvdata' not described in 'intel_th_alloc'
>> drivers/hwtracing/intel_th/core.c:812: warning: Function parameter or member 'ndevres' not described in 'intel_th_alloc'


vim +812 drivers/hwtracing/intel_th/core.c

39f4034693b7c7b Alexander Shishkin 2015-09-22  802  
39f4034693b7c7b Alexander Shishkin 2015-09-22  803  /**
39f4034693b7c7b Alexander Shishkin 2015-09-22  804   * intel_th_alloc() - allocate a new Intel TH device and its subdevices
39f4034693b7c7b Alexander Shishkin 2015-09-22  805   * @dev:	parent device
db73a059de00eed Alexander Shishkin 2019-05-03  806   * @devres:	resources indexed by th_mmio_idx
39f4034693b7c7b Alexander Shishkin 2015-09-22  807   * @irq:	irq number
39f4034693b7c7b Alexander Shishkin 2015-09-22  808   */
39f4034693b7c7b Alexander Shishkin 2015-09-22  809  struct intel_th *
3321371b5d64847 Alexander Shishkin 2017-08-18  810  intel_th_alloc(struct device *dev, struct intel_th_drvdata *drvdata,
3321371b5d64847 Alexander Shishkin 2017-08-18  811  	       struct resource *devres, unsigned int ndevres, int irq)
39f4034693b7c7b Alexander Shishkin 2015-09-22 @812  {
39f4034693b7c7b Alexander Shishkin 2015-09-22  813  	struct intel_th *th;
661b0df8489a35d Alexander Shishkin 2017-08-23  814  	int err, r;
661b0df8489a35d Alexander Shishkin 2017-08-23  815  
db73a059de00eed Alexander Shishkin 2019-05-03  816  	if (ndevres < TH_MMIO_END)
db73a059de00eed Alexander Shishkin 2019-05-03  817  		return ERR_PTR(-EINVAL);
39f4034693b7c7b Alexander Shishkin 2015-09-22  818  
39f4034693b7c7b Alexander Shishkin 2015-09-22  819  	th = kzalloc(sizeof(*th), GFP_KERNEL);
39f4034693b7c7b Alexander Shishkin 2015-09-22  820  	if (!th)
39f4034693b7c7b Alexander Shishkin 2015-09-22  821  		return ERR_PTR(-ENOMEM);
39f4034693b7c7b Alexander Shishkin 2015-09-22  822  
39f4034693b7c7b Alexander Shishkin 2015-09-22  823  	th->id = ida_simple_get(&intel_th_ida, 0, 0, GFP_KERNEL);
39f4034693b7c7b Alexander Shishkin 2015-09-22  824  	if (th->id < 0) {
39f4034693b7c7b Alexander Shishkin 2015-09-22  825  		err = th->id;
39f4034693b7c7b Alexander Shishkin 2015-09-22  826  		goto err_alloc;
39f4034693b7c7b Alexander Shishkin 2015-09-22  827  	}
39f4034693b7c7b Alexander Shishkin 2015-09-22  828  
39f4034693b7c7b Alexander Shishkin 2015-09-22  829  	th->major = __register_chrdev(0, 0, TH_POSSIBLE_OUTPUTS,
39f4034693b7c7b Alexander Shishkin 2015-09-22  830  				      "intel_th/output", &intel_th_output_fops);
39f4034693b7c7b Alexander Shishkin 2015-09-22  831  	if (th->major < 0) {
39f4034693b7c7b Alexander Shishkin 2015-09-22  832  		err = th->major;
39f4034693b7c7b Alexander Shishkin 2015-09-22  833  		goto err_ida;
39f4034693b7c7b Alexander Shishkin 2015-09-22  834  	}
39f4034693b7c7b Alexander Shishkin 2015-09-22  835  	th->dev = dev;
3321371b5d64847 Alexander Shishkin 2017-08-18  836  	th->drvdata = drvdata;
39f4034693b7c7b Alexander Shishkin 2015-09-22  837  
db73a059de00eed Alexander Shishkin 2019-05-03  838  	for (r = 0; r < ndevres; r++)
db73a059de00eed Alexander Shishkin 2019-05-03  839  		th->resource[r] = devres[r];
a753bfcfdb1f31d Alexander Shishkin 2017-08-10  840  	th->num_resources = ndevres;
a753bfcfdb1f31d Alexander Shishkin 2017-08-10  841  	th->irq = irq;
a753bfcfdb1f31d Alexander Shishkin 2017-08-10  842  
d7b1787161b78a5 Alexander Shishkin 2016-02-15  843  	dev_set_drvdata(dev, th);
d7b1787161b78a5 Alexander Shishkin 2016-02-15  844  
142dfeb20209607 Alexander Shishkin 2016-06-22  845  	pm_runtime_no_callbacks(dev);
142dfeb20209607 Alexander Shishkin 2016-06-22  846  	pm_runtime_put(dev);
142dfeb20209607 Alexander Shishkin 2016-06-22  847  	pm_runtime_allow(dev);
142dfeb20209607 Alexander Shishkin 2016-06-22  848  
a753bfcfdb1f31d Alexander Shishkin 2017-08-10  849  	err = intel_th_populate(th);
a753bfcfdb1f31d Alexander Shishkin 2017-08-10  850  	if (err) {
a753bfcfdb1f31d Alexander Shishkin 2017-08-10  851  		/* free the subdevices and undo everything */
a753bfcfdb1f31d Alexander Shishkin 2017-08-10  852  		intel_th_free(th);
a753bfcfdb1f31d Alexander Shishkin 2017-08-10  853  		return ERR_PTR(err);
a753bfcfdb1f31d Alexander Shishkin 2017-08-10  854  	}
39f4034693b7c7b Alexander Shishkin 2015-09-22  855  
39f4034693b7c7b Alexander Shishkin 2015-09-22  856  	return th;
39f4034693b7c7b Alexander Shishkin 2015-09-22  857  
39f4034693b7c7b Alexander Shishkin 2015-09-22  858  err_ida:
39f4034693b7c7b Alexander Shishkin 2015-09-22  859  	ida_simple_remove(&intel_th_ida, th->id);
39f4034693b7c7b Alexander Shishkin 2015-09-22  860  
39f4034693b7c7b Alexander Shishkin 2015-09-22  861  err_alloc:
39f4034693b7c7b Alexander Shishkin 2015-09-22  862  	kfree(th);
39f4034693b7c7b Alexander Shishkin 2015-09-22  863  
39f4034693b7c7b Alexander Shishkin 2015-09-22  864  	return ERR_PTR(err);
39f4034693b7c7b Alexander Shishkin 2015-09-22  865  }
39f4034693b7c7b Alexander Shishkin 2015-09-22  866  EXPORT_SYMBOL_GPL(intel_th_alloc);
39f4034693b7c7b Alexander Shishkin 2015-09-22  867  

:::::: The code at line 812 was first introduced by commit
:::::: 39f4034693b7c7bd1fe4cb58c93259d600f55561 intel_th: Add driver infrastructure for Intel(R) Trace Hub devices

:::::: TO: Alexander Shishkin <alexander.shishkin@linux.intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

