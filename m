Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E99A7990F3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243733AbjIHUX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjIHUXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:23:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51FDA3;
        Fri,  8 Sep 2023 13:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694204600; x=1725740600;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xsJuH3tuIhmH30Ga3GpJdVw+109BQKy/11io1KJAExA=;
  b=Qz9mtDmXpvcvDCO3YIuHYr9ymuCP+mz1KoO5CkCVthNJtBZUKMPM87kE
   urxmWmBwtfNaiVG1opxauzD9MyYFu3oZE0//GENHhugf8T4W4C0iu1CIH
   DSqTDCxVfFEqjra0zvQkIrsPCA7Zqdyw9u64DqcvBkzYM3Clkp8EXpra5
   0D4cL/YpiyeDhzj+NQk4DiYQEUZVLzzscAmRY0G1WDv5TLkkMtqhNBI55
   8/vtwt0ls6uLZBSof8QHMseX1E43lfxIHuMHu52Y5DEPIevJfMfDSAwzt
   OSLphESIRxrBJI7LLu+3wPhAFbpmNyTx9yzjL1AFYYnxEqUE+EyWNmZ6q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="381561246"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="381561246"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 13:23:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="771876241"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="771876241"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 13:23:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 13:23:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 13:23:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 13:23:19 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 8 Sep 2023 13:23:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ED/vWaDbBWCREBODp+163Tbmjsh0ZCfGaTYRNqPCk/uyi6fSLCAbxdMIyanLvnWJSle1y0rEgoDkiJisfRhMa3NTz3xsolIz1HdhDVIHRMcawIBNxys7weHqji3AKGM/QvwKnsMu+oLw34fJk/ExNzwmVylTphysRJPZOiGCuFAd5GNcamDXTnyWGzcRKMFGakTo0FlVl3KG+im1mKeHQrqp/qG518PHg5LhMxre8p8JzOkvZX27xK98MViKzTv2gCUMp3OpoI0X2GHWd5JLkivCKPIkmMqBryuojas3lgDzjkhny5n1YujRZDfN2q4W4EwVK8y8TluN2OJw6RvqHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBjUHJGwqgs7pgqJhEEzs67tPFJrhF62Y2OSVhBREc4=;
 b=ZfkXNLdHJEpUxWXzO7GmFy4DTkO6i/LWAFL9lcF9+EH7couv1CYTe+9kjl71z7n7et8zQi8Xj6w6DlPzUuuFhTPk+ney7cj2Z5sj3bPg51OgkAdS2UUXA/xZj4QmOGhk/Dwkmemn+5EdBiUh12zeaTn7HfKtlrwx2eM5nzZaQDmEUhflrlizJSkWdSUvXYBTuso3/orwUCVTQ3OPQzgC0Yah3FI1W38J9gdA0H3azZpyHslmrIKJnqgoH+92V6H/pffoV9mCAYda1XBrc9dqpSoHNHR6W6XaM3nA9LFlaUBsUtSwuJ4DhtyTgydDZNd4wYRORDfBb3/ps70nyOXZhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB6750.namprd11.prod.outlook.com (2603:10b6:806:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Fri, 8 Sep
 2023 20:23:16 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 20:23:16 +0000
Date:   Fri, 8 Sep 2023 13:23:10 -0700
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
Message-ID: <64fb82aee859f_1e8e78294f9@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-3-f740c47e7916@intel.com>
 <db3bd5d0-640a-b121-f3e7-cfb73dc6c9ff@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <db3bd5d0-640a-b121-f3e7-cfb73dc6c9ff@intel.com>
X-ClientProxiedBy: SJ0PR05CA0139.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: f58758bc-6ec3-41be-e7ff-08dbb0a96f45
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hCsPf3/TFzf94w9uxW3rkSgDUm/BY5lnwjI9lxAmLB3A4jr7UoN/3HGM7q4iqgkGKQXUVl5fHN+cHy+2kkk14R2cIKlhaXkhVt5mWjQ1YjTLDN/P2JRWDv1llQSYfO51HqtRudUHqAXA0qjzyJp/ayR1xZsqzsubpBS2AzZMgPhBRN+Ft1DIoLWXJjqwLMpb2s8cvAAGtkC8Oe8rQIgafQfjQxJwivxzO20CGLT+Qyxw7ckD8oXV+VGD1mZ4Ghio28l5mJObhZ8al2QJsHy4Zc2b8sWNL8HGXRPjx33FWWmnxJ3Xc5w/TcV4TUVXJOS7cDQEEIffEDjMMz7Kp5/G7/HFOJ3hXyZqH/G43zx2BnkACKIxHt/0up9XYbx8Kou2CbQwZIVz4kmZnQMGGi5HWXZWDKigciivmlZN4xS0aYCsx8zi+GdidhPjzsr6IN567HpgePY8TyQ9ziGsvRYuJKSSa/fomJ5YXhvbwz6VLfFYZZJYo2OhQopvspRx/gVtX/c88zwxEQi/S5/M98z9AHTkE5xzes8zK8/BA4saBrVYamQmAjPR0gjW4IoxyVet
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199024)(1800799009)(186009)(26005)(38100700002)(5660300002)(6636002)(54906003)(9686003)(66476007)(66556008)(316002)(86362001)(66946007)(110136005)(478600001)(82960400001)(6512007)(4744005)(41300700001)(8676002)(8936002)(4326008)(83380400001)(6486002)(53546011)(6506007)(6666004)(2906002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ef4GnbLCLo18oCqqot+ksBiNgGZBbJx2ObAusgVbYX/vF1kqlDGzoW75mM3U?=
 =?us-ascii?Q?tXTi5wfO0X9/RQ1D+GPqnYA1dJ0kus3ZPEdQY6Ddln7ZlN0fW68wV7t6YqA9?=
 =?us-ascii?Q?LVb8TUSzq/zU7eoUHlhGHpO493qEi7rnuBOtCNPTDxOAkY0tRkKadybwOk76?=
 =?us-ascii?Q?BxfDTtkNBIn4ZeIsca+yYzlx77eRJe1CNuXUu+zkQlcWzg9njphqcEAYjadR?=
 =?us-ascii?Q?1zGcMR77ggzdKthFG+20Rlo2MN5YCth1bDck4ler5W6HThB2NT3tXn+Fe7Xw?=
 =?us-ascii?Q?BEpjE9jEpYYlpzv7Ac8Yw/MUu1op8zUF+Bl9XNN7jsZR9XhznYzfFSdboUt9?=
 =?us-ascii?Q?7VlYydhO+ehgT54MSfB7WyUELm7FSb0EXynjBbPUTK7w2PNkyBLw8sEqns0X?=
 =?us-ascii?Q?AlFs+KfZglseQ6MHBB+0ZwdanwH1DCJiLf2IP6iN1Rpg1dkRtL0myfZBAK82?=
 =?us-ascii?Q?zt88XjQGgv617QAX3K/kb0XXPwFIpKLF+CmlqK1StKKKHlWNI9KXXOBUhcFX?=
 =?us-ascii?Q?z90PP1IpVqeSFtFYWjWHmOuHJINvp1FKvq4idLa6ky1B/KeEuAT5MTMMVaGM?=
 =?us-ascii?Q?mBDKTypdt37KjQZwWk/duS+I51hOXXteopuHb4Cv10H3BKJzV5m9O+Ceki/E?=
 =?us-ascii?Q?k5Y9E/7ZZaizYc1y+KsQKFCKDIHDX8o+VKFL7LJwic6GcpIwjG70kJdavx+p?=
 =?us-ascii?Q?7T+JFF3a+AdWc14DMQ5/onSvQpgyvOEX2wV/KWzF7wgTm6LgahXXod8HVD7g?=
 =?us-ascii?Q?LT+qe0d97D4t4qODgJQQkZfkaiZ+juhvysx/NhXiKK2GUHhXMjGJZYqUx2bP?=
 =?us-ascii?Q?jjmFlcocA1yyCYduc+B9RQehPO9GoZlMPs9WGKFbBvg7oHa/zbd+S3se9kIZ?=
 =?us-ascii?Q?6m/tR/oMifoWwY47Q1K6qt9Aqv4JKIPC5BxmRlfBFvmgXoQbNci5SFjfK2rO?=
 =?us-ascii?Q?3lHWUeGgOOjfxyJOWpt+N8bj6a5e37QGrshdON+vKX0l/5iT8IZ5pfM1QMSH?=
 =?us-ascii?Q?vDxA0tvirxYB/8IkWJ0dxUKwIkQZgaB9SW0pAnP7SiXXWmfRGHrPh+klS9pz?=
 =?us-ascii?Q?Nhd/G90iwulyJHBz8Q6ZtPgcyiAMfftQ+cH/mcOeDIVHqTLqG22/CY1eEhMv?=
 =?us-ascii?Q?qdzDx4w1F0GMQKo6Jo35NseAiVUK+9ToxPuKIRa27uYsICb968azofBp8WXO?=
 =?us-ascii?Q?Ujpj7ZbryYzU2got3mwhKklQV7QYef/CekVMuv+3PrCwybYDUHkNEPyqE0Py?=
 =?us-ascii?Q?shfLh5nWbiYJ+GUAPj9qT2rl6kGeB02d0ew5IlSm/x61A0zyosJgvn70XrLr?=
 =?us-ascii?Q?iQoYdDQsBXZoOMV1ThuojzspaYm7pUP6zAuQLZ3tddc7ma5OTlg4u6xdvxab?=
 =?us-ascii?Q?oGyYrfHSxtG4z7dJiwb6ZLhgi6LE+enGAJ8JO4tfcUMVnIQDkgtEi1FLE0dD?=
 =?us-ascii?Q?XkMBTUJqD1ojNsb6G1NnvRd9mpNF5isM0ey7YLXRw/KhZgeEEnkLtXhG8hCZ?=
 =?us-ascii?Q?U6UdK+Oe9v6ej6oJNN18uouQNO8yommBuAKn2/ZohmMSZRxufhFZD5Ex0W/H?=
 =?us-ascii?Q?EJfw5Z+t5rwDiF9fQFhzY0sZj4z5w7HS/a1RB5gh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f58758bc-6ec3-41be-e7ff-08dbb0a96f45
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 20:23:16.8014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jXDO1scxQ0Vys4ZNRfDIzeFPecNfqRoL02VSgTIq0Ds0xX5yIKLF/RAZ/VJLPJz0oslUcHUIYnJcTIZbxykkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6750
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
> 
> Also, maybe split out the REGION vs DECODER as a prep patch.

Both done.

Thanks!
Ira
