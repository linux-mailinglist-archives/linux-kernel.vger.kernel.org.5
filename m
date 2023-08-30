Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9470578D0FE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 02:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241307AbjH3ARn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 20:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjH3ARP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 20:17:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6479ED7;
        Tue, 29 Aug 2023 17:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693354633; x=1724890633;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZVvr60VjQCSMZ2ACnGKrWXHbv4Z0dd9UlPQInAm3oUQ=;
  b=jQ7UED3Gi7nXY+6KDNcHwzJVJFXxxJ7jiOWyRdTj+YbTrtD+0sl6gMnc
   ig87QX5HjIISsY9WPS6Eo0oJRyx9dcCW0iBFYL6eKhoRajCzm45uQEa2i
   2//jQVArgZx5Ui4LJq6RwCFq5Ik8bFTVfh0t+IGsxIxT3b1xoyT3A1bkS
   sgg3M+InuqWh7xhxqCFF8AVfmpnwuKmEfZqOVZIejaEIi44TzK1OKirG4
   hF46d8hoHPCib5ukCQ/p0z41Nfqq5nnqJLoB9dDmJEpiVm3vUuwsRnkC7
   cOmKNBOf9dYK7XaCSQ+GjWrcdvfL9yxi0HuqCuvFnzhzQPAS/TjipXEc/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="372923323"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="372923323"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 17:17:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="804314580"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="804314580"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 29 Aug 2023 17:17:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 17:17:12 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 17:17:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 17:17:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 17:17:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLpNBk7FP3IwykgwiVIMxQnyLVp/UWfSSD/KP0APhdQyPz0Vm2zm2E/savAVJtge6Ex7Uro7wnZ8mPdC7VUNE8aWhfKMBV0eyMtC3WEi84XKHjohAvEy+B+cxeGtQUjOHmxog8jxeE5MhviKXFW9Ht3/Igaq/SMVLDn2NM7Ct5xtMB8aj5kuHzvIReEq7y3SXkiUlUdc00JBXUzqR1fimV8/o0mEnH8dMnFOMEWBSnZBe8ht+SXghRW18rZK3XOlA1lGxK8C6aL9t9aG+kbtTc2f3pqVXH5Q4ibVyK01y1CFaBK60szOhZgyh3tzvvPLXjZRCp7zMQLNMZSl8l4XAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o90nXvxfYJHAygPRAGF3f9Ao6JkNPRFwbhtnjH+OeRY=;
 b=UvxiWQ8Q1dmEr5z0OvUhy/i/3sM3yw53n6usJSfzHlHIRlnggihqOFDa+XeKM6HyyFnBdGxiF0fYeULvLKRiZLhEuuqDNn16RP8jPqpndSDMfBQkuVIylYaNxECrDrL8q7GjuhTeTzkNxwAf0bwyYyj+0n08D4J4KBDOk8YgLn77kQSIjNQQcYdA/Ny3Qh46MwNexpOyOphn1ZYRVzM+MbhEB0Zb1mV2IuVVn2iOHcY1GqgOf/CY0vy1Uu20ar5+nA6BLfQYaL7/8bsCx0k6LmFz5l2y9h1x4+iBl0dzxfkczS02vEZyHbTfRKouAn6vqkrWKPxKfNfo+e6kUIVMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY8PR11MB7396.namprd11.prod.outlook.com (2603:10b6:930:87::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 00:17:04 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 00:17:04 +0000
Date:   Tue, 29 Aug 2023 17:16:59 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 09/18] cxl/mem: Read extents on memory device
 discovery
Message-ID: <64ee8a7b2c69a_18d28a294ad@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-9-f740c47e7916@intel.com>
 <20230829162600.00004ac2@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829162600.00004ac2@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY8PR11MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa8b969-7d68-4edc-d517-08dba8ee7020
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LeNRRJRfQ2F8eZa0+1bGng4iBa1DmuTCpEeC7vHdgnuJl2NnlPYudaELHzOlM/4NntC8AkOJLKpfN3wg3ltbk0mDTGWMEu90JRj4JwRwTCdiZ3gG/D5SG71JJzyynONTaMJH4P0miaEij/VvqoM1sYFtpBYkR+SLTbraDDLcse3WDfam3UABDnv+9TDAxgOhsyi8LBemZyrR0ArXB9EpiaqEZ79E2nAa43oqdau7/He1qZPAFSHequU5rwv8RJkpfjMs0waiDaHLQWh98ahHMZM5pME/UPwyJSTtxQ5rBgirvlLCIdbTwLhzfLyih/UlkvUzD5UeRN8WuCOhtyo4xxwXV09X+EH4e0eioiBwIdF5ZjkwJSDhvzQSVRi+IQ3AdQ4TqZcRBqKfMap3I2R96I4LLBZ6JZYOHNEvoG5fxn1CwowotiDsLkEMJE9Pahs5/9fA2IdsXAgihGM2S0z919snQ7mS7i4EButi9zfQXoQHWL3eEy6xfNww0AMKmczddu3q5JsAj48UAsPRLQk4y+tIJ9NXXJGx9p3iopHoRPkk2nwdqzC17Q4uBRsQiUba
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(1800799009)(186009)(451199024)(8936002)(6666004)(110136005)(478600001)(6506007)(66556008)(66946007)(66476007)(54906003)(6486002)(316002)(38100700002)(41300700001)(82960400001)(9686003)(6512007)(26005)(44832011)(8676002)(5660300002)(2906002)(86362001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vpSg/NQiRYZaTLPDrGBRLrjJYuvr4QoZIzm27U9Z/ot20Zn9QHVF/Hm/YxrI?=
 =?us-ascii?Q?jvMb535B+0zlgKya8yZ4wfrMTl0KXP/KbspttW2vta0/VkDZFdjtzmQWdZrX?=
 =?us-ascii?Q?V2vgWm6HX6jMz+8Lt4ZqoA1MrbZm8WlsNzgEkZpPDYSvjBmAYOYu25ivOySa?=
 =?us-ascii?Q?q8kJwi0PEm54m/nD00XtMugVO52DuQgL5Vr67KRLoZV/uCweVzSFDPE1ZNXS?=
 =?us-ascii?Q?t26OYHFX4YzYuBGozCX3it9aWPfS4PkCODEOvF8+m079x2WAKHbT2kIiuaf1?=
 =?us-ascii?Q?K2pSpBbp8FGd5trY4cX+RqaQRqtH+imX/+u1ttFhe7Ghr1EUL3ck/2bfMOWz?=
 =?us-ascii?Q?GV3raHs6rhvCxpIFMDq5btIQBrkNgVeZFpzj9GrUKjmyae+aefpGWE0f6SLL?=
 =?us-ascii?Q?nxF/3Ze6wDgEgVEGvNAG2F0LQTkuwX0esbh1NfG1QGXX3bj5y/u0Gn1FJMFj?=
 =?us-ascii?Q?LZeDuE1EcVNvkHECPP6oESXGN+xYcXhL30eFgLnqBBcwulst3E88e9ESDV4i?=
 =?us-ascii?Q?lTABJzzo1lcimhO41QODN3tDRJxmDL8R7+mMUrOZzufA/qVk0WFKxqOWJOZO?=
 =?us-ascii?Q?4jZYrPNY2hIEI7NDQPLJid1kJu1qmMvsLzeKVSJ/mnLIqi0msDsgB12jTx3H?=
 =?us-ascii?Q?kKChYzq/H81bb2SYjE0JO56CWI5kdnean69vvLUXRGNi73vfaU4t4gmqn59q?=
 =?us-ascii?Q?zYg5q+WKyTEK4tZxymhcV1VacBuAm5bpPxqtORJ9mVoHsLTL4E8esrIKeSIN?=
 =?us-ascii?Q?1hjtiYc3xVqxpnBMrQ65DZIJC6rBRfkob8A00QtGCBcFvsOdfvGhJCsmoSzQ?=
 =?us-ascii?Q?zIzFf+4lvpyJdhlzv+KgNPn5oA8BBWvFKXwi0ZU96trMmSmAkOdJ+s6kjoM7?=
 =?us-ascii?Q?qX/6KygPeBZTKpjahruWIOfqF27JIhe82JqavWjsIO4lNSdi23m7SKTWP80o?=
 =?us-ascii?Q?mIPUQhDE1WvhfppvPivO1CgP5LzMDe6JGp/3s8oLfJy1nFRoompIAA+dZNyw?=
 =?us-ascii?Q?MNzbxwrQTIRjv/aFBEnw8U7egVvoXYqaIsKmUdWVK/oAYcWXXwhYlq95LRmg?=
 =?us-ascii?Q?/ui23v2sVr3pAKpVByEPxwTeKq7HYQIH32tdtxFlEQTZsYNZYmNZ9IJI/vap?=
 =?us-ascii?Q?+2bepj05y8/5rHuOUeEahre7NqwHffKl/riRUeUhxqQ0FYNn31M4qjOwf3AB?=
 =?us-ascii?Q?1BWdXl1Gbgn8vk4jFXp5qqRfFcMxGIyUF8M7T1/n1tfH/jn1OX1QswP3V5BD?=
 =?us-ascii?Q?KMVxzjematYYvICipD14yVNRWS4TaCVnyeEdCBkEseRIvuj+QLMV2feBFkIr?=
 =?us-ascii?Q?ojL9+itqki44qzK91DLzcA+R+esIUQsdl1hRCwoypENs/aBsveIf0iBWjI3g?=
 =?us-ascii?Q?8+8BKURQrvTdGQ/SNrcaKD0xmCEL1zIEM3yuJGW9A80REQgb1abMArJ+W3o1?=
 =?us-ascii?Q?9mSgRr48nDnP36WP3Q8H+uGvWELAeTZOR86cMPGNOxQb4lr+C7aHuPxLV+Qg?=
 =?us-ascii?Q?ByjR3c1oaAv3xSms8bbED5y4+IOpeZWc3Y0P7vylI1DRip81Sgv1wwfojbsi?=
 =?us-ascii?Q?RDKuJ1T8ImP8KKRJV3ThXdefsmoxTash9oTBVu+w?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa8b969-7d68-4edc-d517-08dba8ee7020
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 00:17:04.2805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrZU8lQxHWuL/NA8H9P5cYu/bw3lXntr9HtYWDARhU0AKt/mGOl5zIzIwyNkwLs5DmYTuNL1oQwMQaJNN1fbUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7396
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> On Mon, 28 Aug 2023 22:21:00 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 

[snip]

I'll go through each review but I had to respond to this one...

> 
> > +		.payload_out = &dc_extents,
> > +		.min_out = 1,
> > +	};
> > +
> > +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	count = le32_to_cpu(dc_extents.total_extent_cnt);
> > +	*extent_gen_num = le32_to_cpu(dc_extents.extent_list_num);
> > +
> > +	return count;
> > +}
> > +
> > +static int cxl_dev_get_dc_extents(struct cxl_memdev_state *mds,
> > +				  unsigned int start_gen_num,
> > +				  unsigned int exp_cnt)
> > +{
> > +	struct cxl_mbox_dc_extents *dc_extents;
> > +	unsigned int start_index, total_read;
> > +	struct device *dev = mds->cxlds.dev;
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	int retry = 3;
> 
> Why 3?
> 

Then shall thou count to 3, no more, no less...
4 shall thou not count...
5 is right out...

;-)

Seriously, it seemed like a decent number to try.  I would hope that the
extents are not changing much as the host is booting or the device drivers
are loading.  But since the generation number is there I figured it was
fine to try again.

However, its been a while since I focused on this patch and as I look at
it now I realize that retrying is going to be a problem anyway.  Some of
the old extents from the previous generation may have been stored and the
new list is likely to have the same extents.  Which would result in errors
later.

I think it is best to remove the retry and just throw an error.

Thanks for catching,
Ira
