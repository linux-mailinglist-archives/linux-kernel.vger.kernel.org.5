Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B6C7F5A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344976AbjKWImm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjKWImk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:42:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522D7B9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 00:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700728966; x=1732264966;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hEOvjwL4YXuWSu3HPkALJujBornOJYtNFhNVNzRUW3k=;
  b=XQxKYUD7tY/YZoLV/0x+GMA0FPIoDcC6bTbRYz/6MSWxUrvGL9CWJlux
   iHNweqVtWABorMCwyFNwpmKaJtKm+/AT34THx7MnkDOdzn2P7+1WYKSzk
   vjqG39z3wjfnrxpveSuim6t+Bip70OV0iwGQXJqvOgyrQTcdvQg8NdCsp
   37dqCYjq1S1iol0kVqeE29C3GumtaSt/EB3eOQel2NHwSePhYUCK56jQH
   sPHRVEzvHXTQO4xgMUIn1dK4nObVzUNRB4yKGVvlKbHCjb02WzbBtApwE
   NBUzKiZkAESgEXvq4MkuR7itjSfEmIh3w2n/Jp7C4HFunGsdCjozhVtA+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="372383423"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="372383423"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 00:42:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="716987671"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="716987671"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 00:42:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 00:42:45 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 00:42:45 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 00:42:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+QArdQrUEMjguDnHaRHvdC925JhYAjU2a4ffmgA2UHUdDlhXAOjfr06m2P7o2VbTVCV0PptZCDtMyLpMgjj5lKxcM69/TTTMfW5mBow+YHkJbaYfNlje+5CYNl8s4CadqU6xEJn2caa8Ha/etFC9S4EMJmTLzPMIi608Zx0zOshUzmFDA3nBZgYHuqDn0plji8KAA7z4LUI9xLr+Kv5nHg4wBYVU6nHCB6a1pWTmfBykLf9f58t6Q37ST3rWJ2bMQcncWzQW5ZY1NDhCDRy2O0E++t0C/tJ9Epg8rzfwpjKGXsOcGQXRtqn3ciKLpeXMNf8JLUb1ykqO1VDpyeDGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xacaS56OmlWA6B+pl2kFaUd490r5pcJY9nwju3z12w=;
 b=P6HOWNX7Fv5+m/apls5wv81wRagTjQcZX3wwlZiqRRf9UOy6H34ZwXTvNndH3e8qc3ZDS0LFhz4XtWhKIbaO/s8Le0hdsRvvkcMYWsKMh6WVhFn89bgy5vLrOp2ykM/BWxomTSUV8b5kO5hd5qqH4eXAhwABeKLjT/QMHKxui1rltb00CmPaMmc/fP5FftaOy3brOD5yoDvYtoCn06ddDb8Oi7aPVO2+yWDXMEoyyLVWrNXtMe12XraSx7nB06eSZvlBMClo68cRtRzZR66cfJeW0PDMe+5xL9LLtOGEXnGiZuJveRKdsO1XaejhwJZhHoIuJHj573OgzeUE25wmjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by IA1PR11MB7872.namprd11.prod.outlook.com (2603:10b6:208:3fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 08:42:37 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7025.017; Thu, 23 Nov 2023
 08:42:37 +0000
Date:   Thu, 23 Nov 2023 16:38:01 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Sherry Yang <sherryy@android.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: drivers/android/binder_alloc.c:866: warning: No description found
 for parameter 'lru'
Message-ID: <202311222244.3Znlb164-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|IA1PR11MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 59bbdca5-318a-437b-b146-08dbec00253e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qKrJTj0UVhxJ6bA8CHn6qlDbdQOeob9gHHox19xGudNo0Bc9JIP62AB7QqAjspluVMSND6EZ6fxij7loDosupIMbVLNusx3GcxwuZ2dLatSieIZWWGbjnDhWlyv0A03ZuHd3juAIw12eO80Oo8yKm9kL+qoImaEGaLRIE38wWX54RPR17FcI+h4OtG7bEBfWhH3Dk69lmu9avx28sVpSiZA1lCj5gx9lLMWITTtrYn1WcPwdfJGozObiF4bW6o/fjMSxe7koo1Is+Dbp7zVupJmnkdxqLAbUdi6Po83lXdMRoMfzoFeOy0W4J0Gahfd4HMgVevSr9D3BKRX919WtKUuGP80jekpTei6bxRZ9gqmwqu7ad3UHj+pcLww7v14xzD5Fv+lfzHlGaKw+ubYjHB3FGTlOY5rzy006ZdDvKm8uy3p/Nhmy6xyxRGcOrRo9i+hRS9hq1q3sE7AnUVxVOcapl9muQTDKDXBQjj8za0X12mOUz0cC7ZGgTse5Z4qa77Hy+tKHMdqyYNpH6AYMyvKqh4TtnSRldx2csKwlFwZWXTNctFCa3LSIhfQNkuiZtEg+IC8a2xU3z0eO49CdIGSx6VNl6tnrkhmK1qOB2hxXwpNkO6ZclNAZ/CHtbs8EJzK4e+jSI+dO3XlL/vb2lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(230173577357003)(230273577357003)(1800799012)(186009)(451199024)(64100799003)(86362001)(83380400001)(38100700002)(82960400001)(316002)(66946007)(6916009)(66476007)(66556008)(4326008)(8676002)(8936002)(6486002)(2906002)(41300700001)(5660300002)(2616005)(1076003)(6512007)(36756003)(26005)(6666004)(478600001)(966005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VYI4QRxEZUH0yf/qbfpF3ToXbAKT1a6FwIMVy32gvGrL+3+cFzYifIcmJqjd?=
 =?us-ascii?Q?Qu7FFf/gK57TS0a4Qud/vr96rZw9mdX3RMFS/z/nhuymMtu+JQIcX7Tz64nY?=
 =?us-ascii?Q?aRGqpIrZZNkUoh/2fQBtMqB+USsR2cSjBFg3mbFXRSSwFrI17CmhchxW+nh8?=
 =?us-ascii?Q?2cUMcfYvc1llw/8sqOVFBiSegYRYX8P6B1GwWRYK0vRiPaiidQMsbmc8e6qL?=
 =?us-ascii?Q?vPCtxvYm2ONePC5AAqeJwx7vQfOI9NyiB/fMYo2qykfeq1Kzd5vodiChPy76?=
 =?us-ascii?Q?lev8c6xmIq23X8qArzor2qGP27S/M8Vv+4Ep6JGN2xi+LdJ+NAwCTFpeDNbR?=
 =?us-ascii?Q?Gu63KV0aW64PehzPei0YYUgbGbm0WmpDN2vETufhYDpDaO90SQ/p8hWH/iTQ?=
 =?us-ascii?Q?Jd8Ye2sesvNNTqN+w1rb9TprKfaPHKb8fkggMXcWgtdMcTi422sla00EI7o9?=
 =?us-ascii?Q?nc8BG5sEPByZaxQgM6roBkzlkITrhpKb85rQuE8Rmf3LCHg839jEAmxASknV?=
 =?us-ascii?Q?1IUWH0yb0w/gtwbBXP08YoaIT35qM80IBQoJCtAIY6vCk94ohy1jcZW6EOpe?=
 =?us-ascii?Q?4WZsBGVJ3QGkTfxFyj/azeBJ7+LHkpiGluZYZGGhNmqXmUyqx57Qjzmj+hxk?=
 =?us-ascii?Q?cZxeKA0RJw7TG0hckkBdCSnTKs9dlkxxDdwKIRD79jVRs3n5nOCLPfGXkFG7?=
 =?us-ascii?Q?do6hoND1QCwGTRZu62txoTuT4u37L6yx4SZ9vV2nvkTWJSpBVAzFdPEcmme4?=
 =?us-ascii?Q?YZ/rnPlkTnlHlP7BybSbnhcFgE8NtQHI9eyXXnD9wOyawvYcMQWF9ShLz/90?=
 =?us-ascii?Q?9cPOaypawTgpYOSNM7cNvIDFesN/pnNhRbo/Rp/IkwHPdpmNcEbZC5RQV7Mf?=
 =?us-ascii?Q?7y/Ue5Be6a6D82f++I+R5lLP6JTHYJM8jRpH5fc0xKzgptZiSnkgswyIiHpX?=
 =?us-ascii?Q?80baAn1KHJdR7JzDeLOimgQdf7Tsob194jXspJJ5+wxUHWsI4KhD+Z0OjyQa?=
 =?us-ascii?Q?MQ95cHyf+BnkVb2THz5dEYANjSZOhWbLrTfazHzPfYC/6E2Ak6iPuPeYpZo+?=
 =?us-ascii?Q?YLxOWmv6FycZWzdLCVntYjmOVwCkz+rzCd1QYG+1oDr9KoYnCEHXJYj7obTt?=
 =?us-ascii?Q?b9nkuMBJailbyRULd5gkzhnnHWMATjE13rVd1ChF0KuxGgWNyN8aWaP5LBUW?=
 =?us-ascii?Q?wk1ggGhljSagjT4T7B8kW2DGgeHXSYU6XYuUj7qVOrjxm5Y4z2dMOY55YJip?=
 =?us-ascii?Q?fZhsV17ogjaVAXp/piKmTqSEc5Ph3L6H6P7CJpjRjZ6XOVDujUuyg3mXrGs5?=
 =?us-ascii?Q?DH0G1lcuXBmE6Hu+d5YQESbAXUbGRWsblQ/wmhUP6Cl3c+fINkMhLvclPQn3?=
 =?us-ascii?Q?vp4uISL2FhTuRfNKyn0wACyUVPW7QswXeaRaChT9FaekZC+2nEOrNHwco0YB?=
 =?us-ascii?Q?/rtMnTttDd7pBLDaQvSxBc6c1Y2N45E9FzTb+jwdEClyHaxx+zFRpUlOrFBy?=
 =?us-ascii?Q?wcXJwXoCBdyteMclL6xJvCykJJ+gwyCRPFP+6QcjfwrD+QVZU7rWcw5Ko8ts?=
 =?us-ascii?Q?uGn6QUrFiwhwRXVQ9On0MHFdC12PbQMssgAY6X1g?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bbdca5-318a-437b-b146-08dbec00253e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 08:42:37.4670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lvul8eFkJ7772MFIoUJr+drReNP4CpRIGiD/c0mjBWi68rvvAS85sPr/ZwL5XJqzMCDp5QW43rbmWMvGZf+A0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7872
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c2d5304e6c648ebcf653bace7e51e0e6742e46c8
commit: f2517eb76f1f2f7f89761f9db2b202e89931738c android: binder: Add global lru shrinker to binder
config: x86_64-randconfig-003-20231122 (https://download.01.org/0day-ci/archive/20231122/202311222244.3Znlb164-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311222244.3Znlb164-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311222244.3Znlb164-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/android/binder_alloc.c:866: warning: No description found for parameter 'lru'


vim +/lru +866 drivers/android/binder_alloc.c

0c972a05cde66e Todd Kjos   2017-06-29  852  
f2517eb76f1f2f Sherry Yang 2017-08-23  853  /**
f2517eb76f1f2f Sherry Yang 2017-08-23  854   * binder_alloc_free_page() - shrinker callback to free pages
f2517eb76f1f2f Sherry Yang 2017-08-23  855   * @item:   item to free
f2517eb76f1f2f Sherry Yang 2017-08-23  856   * @lock:   lock protecting the item
f2517eb76f1f2f Sherry Yang 2017-08-23  857   * @cb_arg: callback argument
f2517eb76f1f2f Sherry Yang 2017-08-23  858   *
f2517eb76f1f2f Sherry Yang 2017-08-23  859   * Called from list_lru_walk() in binder_shrink_scan() to free
f2517eb76f1f2f Sherry Yang 2017-08-23  860   * up pages when the system is under memory pressure.
f2517eb76f1f2f Sherry Yang 2017-08-23  861   */
f2517eb76f1f2f Sherry Yang 2017-08-23  862  enum lru_status binder_alloc_free_page(struct list_head *item,
f2517eb76f1f2f Sherry Yang 2017-08-23  863  				       struct list_lru_one *lru,
f2517eb76f1f2f Sherry Yang 2017-08-23  864  				       spinlock_t *lock,
f2517eb76f1f2f Sherry Yang 2017-08-23  865  				       void *cb_arg)
f2517eb76f1f2f Sherry Yang 2017-08-23 @866  {
f2517eb76f1f2f Sherry Yang 2017-08-23  867  	struct mm_struct *mm = NULL;
f2517eb76f1f2f Sherry Yang 2017-08-23  868  	struct binder_lru_page *page = container_of(item,
f2517eb76f1f2f Sherry Yang 2017-08-23  869  						    struct binder_lru_page,
f2517eb76f1f2f Sherry Yang 2017-08-23  870  						    lru);
f2517eb76f1f2f Sherry Yang 2017-08-23  871  	struct binder_alloc *alloc;
f2517eb76f1f2f Sherry Yang 2017-08-23  872  	uintptr_t page_addr;
f2517eb76f1f2f Sherry Yang 2017-08-23  873  	size_t index;
f2517eb76f1f2f Sherry Yang 2017-08-23  874  
f2517eb76f1f2f Sherry Yang 2017-08-23  875  	alloc = page->alloc;
f2517eb76f1f2f Sherry Yang 2017-08-23  876  	if (!mutex_trylock(&alloc->mutex))
f2517eb76f1f2f Sherry Yang 2017-08-23  877  		goto err_get_alloc_mutex_failed;
f2517eb76f1f2f Sherry Yang 2017-08-23  878  
f2517eb76f1f2f Sherry Yang 2017-08-23  879  	if (!page->page_ptr)
f2517eb76f1f2f Sherry Yang 2017-08-23  880  		goto err_page_already_freed;
f2517eb76f1f2f Sherry Yang 2017-08-23  881  
f2517eb76f1f2f Sherry Yang 2017-08-23  882  	index = page - alloc->pages;
f2517eb76f1f2f Sherry Yang 2017-08-23  883  	page_addr = (uintptr_t)alloc->buffer + index * PAGE_SIZE;
f2517eb76f1f2f Sherry Yang 2017-08-23  884  	if (alloc->vma) {
f2517eb76f1f2f Sherry Yang 2017-08-23  885  		mm = get_task_mm(alloc->tsk);
f2517eb76f1f2f Sherry Yang 2017-08-23  886  		if (!mm)
f2517eb76f1f2f Sherry Yang 2017-08-23  887  			goto err_get_task_mm_failed;
f2517eb76f1f2f Sherry Yang 2017-08-23  888  		if (!down_write_trylock(&mm->mmap_sem))
f2517eb76f1f2f Sherry Yang 2017-08-23  889  			goto err_down_write_mmap_sem_failed;
f2517eb76f1f2f Sherry Yang 2017-08-23  890  
f2517eb76f1f2f Sherry Yang 2017-08-23  891  		zap_page_range(alloc->vma,
f2517eb76f1f2f Sherry Yang 2017-08-23  892  			       page_addr + alloc->user_buffer_offset,
f2517eb76f1f2f Sherry Yang 2017-08-23  893  			       PAGE_SIZE);
f2517eb76f1f2f Sherry Yang 2017-08-23  894  
f2517eb76f1f2f Sherry Yang 2017-08-23  895  		up_write(&mm->mmap_sem);
f2517eb76f1f2f Sherry Yang 2017-08-23  896  		mmput(mm);
f2517eb76f1f2f Sherry Yang 2017-08-23  897  	}
f2517eb76f1f2f Sherry Yang 2017-08-23  898  
f2517eb76f1f2f Sherry Yang 2017-08-23  899  	unmap_kernel_range(page_addr, PAGE_SIZE);
f2517eb76f1f2f Sherry Yang 2017-08-23  900  	__free_page(page->page_ptr);
f2517eb76f1f2f Sherry Yang 2017-08-23  901  	page->page_ptr = NULL;
f2517eb76f1f2f Sherry Yang 2017-08-23  902  
f2517eb76f1f2f Sherry Yang 2017-08-23  903  	list_lru_isolate(lru, item);
f2517eb76f1f2f Sherry Yang 2017-08-23  904  
f2517eb76f1f2f Sherry Yang 2017-08-23  905  	mutex_unlock(&alloc->mutex);
f2517eb76f1f2f Sherry Yang 2017-08-23  906  	return LRU_REMOVED;
f2517eb76f1f2f Sherry Yang 2017-08-23  907  
f2517eb76f1f2f Sherry Yang 2017-08-23  908  err_down_write_mmap_sem_failed:
f2517eb76f1f2f Sherry Yang 2017-08-23  909  	mmput(mm);
f2517eb76f1f2f Sherry Yang 2017-08-23  910  err_get_task_mm_failed:
f2517eb76f1f2f Sherry Yang 2017-08-23  911  err_page_already_freed:
f2517eb76f1f2f Sherry Yang 2017-08-23  912  	mutex_unlock(&alloc->mutex);
f2517eb76f1f2f Sherry Yang 2017-08-23  913  err_get_alloc_mutex_failed:
f2517eb76f1f2f Sherry Yang 2017-08-23  914  	return LRU_SKIP;
f2517eb76f1f2f Sherry Yang 2017-08-23  915  }
f2517eb76f1f2f Sherry Yang 2017-08-23  916  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

