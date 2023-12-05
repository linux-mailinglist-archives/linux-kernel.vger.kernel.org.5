Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C0B804A16
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344506AbjLEGak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344338AbjLEGae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:30:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5C8FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 22:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701757840; x=1733293840;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hf8omBLKfi9vi+g/lsDJ2th4aSsK/KT+nq5luyE7V+Y=;
  b=KgehuYJqQ+sHyGHUVZsHiMPQPNtiywWra031itshs8k/AVnHLXa67GP9
   7uMrVZXoAU528QEAWG3QFBlanLwHmbfajdItKXwNvMPs9PXtsSJ5mPoeO
   d4En1jTU5/R83TWTHUPurpBe/tyrN3/TrIPv2rLeQN7VyxVmJrvwsCDdY
   nbFEWJJsqZegqZNWL55C1264Qg1nUvKqVMCMRNTKdGJ8WkkPDerx6kTic
   y4XoL9AWtBnzxYPE+ek3obo/4oObA95NJCwcs3/fvQy37ooFz0eO83mKj
   p91AxjW2zOMfNGJbsv5ALYDVlXecZxmK9mzTiGQhaFEMiqU7qXiQYPUQL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="458170375"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="458170375"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 22:30:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="747112192"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="747112192"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 22:30:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 22:30:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Dec 2023 22:30:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 22:30:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cE35Eyhk+5+25sWLpnmreJy/FbXC2NxmQeLJ18TyStvmoPong/KEKPaYCQ6NN3BLHwYLWoP2URqd2au5O+GtDcU9045clMiRm+U4NvZdZK5aMC58gXI/xsq/GJ89klDLQbd36aqgnN0Yu2GmNzySJNINAcayF4/5HcHmTGUKcljmuJAmlNxvjNEiPEj4mpth2P01ZWMWrACQYPfCBKuwdR4Q/x5nMzybI/V6P0t1ptERcM9YhT1XSyz7bgwqHS2EuchionfqYQH3qkaZae/R4HH4kqgd9FD+Ie64AkQQqXnBpiOmLCDVvlq958bNJhUbF1/uPusqHm7t2N4TSnhlQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuiCUnZ/3oszhbX6n8yA/ySEkfY2KoAZAl9YDJXHvbE=;
 b=VCv6hlBS+VKeaWysipG5XFc+Ol5cbN+r01QhELPHxNCAkADTxwtZVfvm3eIJIKCK9KLC6ZXFeq6lJ1p4O+rkEvkyA3NY2rRrUM20TeyCoIXLIOysc+dIVwpSjnyXEI+cAKLvCMCN+X04En4cPl/fjFnrBY9/LpIzR64sC9rHYHcoQl/ONdflyKCYQBsKBGohqeGe42dsEZgVUcLU5LDltlnxoxlQHcyhYqbBlMt9bTBmipeOFr8P29VnWfRc9Euf6bFdNe88XuUkPvaiTKQ83Hckz+KAV+YhRPHI5j044+kl1OyD0tsEOz6HsBeIgt/aLpqecxxPMdy9dh5SvsWVaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 06:30:36 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7025.022; Tue, 5 Dec 2023
 06:30:36 +0000
Date:   Tue, 5 Dec 2023 14:26:02 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     kernel test robot <lkp@intel.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: drivers/usb/gadget/function/f_uac1_legacy.c:1: warning: no
 structured comments found
Message-ID: <ZW7CepyuiJn5d34K@yujie-X299>
References: <202311211052.RsFuk4Gr-lkp@intel.com>
 <61f2de49-131f-4619-b62e-dfe2f5b6bf3c@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <61f2de49-131f-4619-b62e-dfe2f5b6bf3c@infradead.org>
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SJ0PR11MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d13c1ed-0318-4433-9c40-08dbf55bb083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A+7cll/mt9VMTbh0FeqUI6sUPUGk2P3Jl4mN8P+0dh6wbqB+6lbpIAUDh6QbOwt5kzUdHHptioVtYD1QBQw3Eo8WRKsKjKGIYm5CcXt7MryyDljO6PTq/L0eRh+xzTGdRWCFJ7uBw/X1Dfk43vjNQrE8lhwTBGUnEiYjAWHIIyOwd0WmAAIajL0Uu8//lalHy6jt1xdfMKJWF/RUY86CEN+vVgiY2BLdJi6LK4kvfvRlkxBn5mer8AeyMal3qGKdrjzRbhCuj4fLJ0wt2Vn+XC6xCxygTJdeEt3/IHaOwFq4zaY5W76xOlaM/gvVdEsinBYmFk7oJZKqIPj1ldBJqEemZ/rW6RLEWjnJqQ/uD9vhpBfr9PnigEQzdszJsEoyxqCGbCQgU6JZmWuL28OcFqjd4vtNipXp51iJMGb4NSqaOVJ3v3uhtg0XcO/3XxTB932a9calKKM80JBt9Ee30x5EpQWeXEQAcAT8+6oerOkOzt0VQA8YH3ObT6GEch8r04sQXdH3gPkdqFI9ZNcorPzeo4ul2w5MLbmqiEJkDYJRiTy+u7dPfNHhiml+wF+aC+n6qHdGqOd7Rlz/PQQ3ENE4Fot1n1qeIshrkxWY0du4cs2UGuAWk6ZUyhFDVc9qtSJvLlEyPkt8pE9qrmviJuAVsp1c18ZLWnnHlYKPgww=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(346002)(396003)(136003)(366004)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(44832011)(2906002)(316002)(66476007)(66556008)(6916009)(54906003)(86362001)(66946007)(41300700001)(8676002)(8936002)(4326008)(33716001)(5660300002)(38100700002)(82960400001)(966005)(6486002)(83380400001)(478600001)(26005)(6666004)(6512007)(9686003)(53546011)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U6rddi1w6QfSy2b+B02tTWkC6VlVpDOvcsRAGtcm1gwNvfRWRtUZ0Z6k/VwY?=
 =?us-ascii?Q?VHcIIrRtxAIngwlk+QxsloQ6Dsq6aPnIXTh+KHVCCl4zjFBZTmmekesM4Gar?=
 =?us-ascii?Q?2vA1OWt4x6gqEAWX8gEt08JjDehoYWxWPkbNrn+olJsaZ+0hujz8+khd9Pm5?=
 =?us-ascii?Q?Zdh2HIbAfoTqsCUAUNYwAsmGATk6TM4uExcrdeyPuHr6KmsUzZGRt5NSeB5x?=
 =?us-ascii?Q?vSMJOoGjGtqG2TTvzfmMgQz2apDdBZb9qVQIufo8ZBsOieXXQ3a4iQW57K/8?=
 =?us-ascii?Q?jAJ4M7hCSCRJfCCNdTUwsKr8OvUm+AGX4WLKSaQv49JxYUe5YwyY0ID9059h?=
 =?us-ascii?Q?+EyHWtP/NS2EbfDboSUT9+lvk3Mkex6+Vm3sMA0H6A8LTK70iR3KqzbPAerf?=
 =?us-ascii?Q?vi9cJahlG3HL2z5OkG82kDDYAj3ox/are8CrqCRZWlpDwcn8o/8s5W4qOVy9?=
 =?us-ascii?Q?ZvgEMy7mJGl4JghFGgs6yENFEsiCUk8kB7e+tTAmOrUVZYdVQjixQcMFJCS6?=
 =?us-ascii?Q?DHGJK9EgZt9GgjYz8WpeOJKQnTgRTJzITaI9bmYssjC26SPfBLOBuH5swr3d?=
 =?us-ascii?Q?UG+nFGVfYvS6yEKB6kwSJuy639n2E+ydIc33bN9+CSuhj5hCx00DsYC80bu1?=
 =?us-ascii?Q?zd8iUPndJo7VIPRGTTb3Hl7VQbu6SgudlnbgqqGQEjiQfuseeKzB5FwUwKuw?=
 =?us-ascii?Q?u5ImEUJ+mLKWr6yhi3HbtZfUSBs0auK6MxWNDZnOE1bqGYikqhYSIAvnaOre?=
 =?us-ascii?Q?mIvCEYFRe30IIUmeP2SLHx2u5JkkNYZyURDFJYGrHC8Eh2iZJbfXSMqrF9zk?=
 =?us-ascii?Q?nWt8+Goqq5KsaPIpf5TjEk11SFZwMTWm2c+/BjO/wzxKdCUzZ5FoOesZEv2W?=
 =?us-ascii?Q?8yJ0KMeR/4FSBdGVudnW5m9zGKnng0v70JG14Ry2rTDI8h6JFwAdNahdEotr?=
 =?us-ascii?Q?PGmjSP+b8ReI0XC7l4ZqoZbdYFimEIXq4z4xnIlAZR4wJPlWtsEyt9ig5SGk?=
 =?us-ascii?Q?kSCufxJYU7dq0SfxHnplaQv52PTnyLY+a73F39oXdXgGFxv+JD5hsG3HZ4lD?=
 =?us-ascii?Q?RHolG2UhtM8jkufdmtVVirgnwqhyYj0nTcjarl882tp29X3Zd1AQbDH1wGJp?=
 =?us-ascii?Q?25ZU9T35YO/T3adEzeuSAxVH9T3C7MdCnqwNRp8izJHo3/bDQGFcOpSV7wGc?=
 =?us-ascii?Q?B5hnPvEp90UlPJEAsNo02RCblIgAlGBDsaYkiqP13YneIugSKotOmkCxZom3?=
 =?us-ascii?Q?kd1igFrmE/+WQYFc1rkHgUhNAqPvCMXQITPp7e6Y+iotlUeRJvNPe2uaEimj?=
 =?us-ascii?Q?Zdwcdj51N/42C6fd10GaAuSLfyo7wY0Ftq8gDYzxEJC9b/KhCGlP/GlgzJkJ?=
 =?us-ascii?Q?3eL7ZX/wZLDRztQWim4gL7DaWaR9wBLOQxaGy9HL09rFXzw3SsMeZ7bGXyJE?=
 =?us-ascii?Q?AxvTeBhFKrU258mgAvf6axvbuFNe5Nl7UVPg+4aw+6f03r+vgJzA/wNekh2B?=
 =?us-ascii?Q?QwTK/kEc/MhV/nGdcDa7VcVSxko7PYoUU6JMY6L1Ngy+LtbIwzqtpsg1Y61T?=
 =?us-ascii?Q?wgO/E2VMRBhhw3mrtoO9bh1Is8OQVvTBB7hKS5nh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d13c1ed-0318-4433-9c40-08dbf55bb083
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 06:30:35.8235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBQ5KYSUY6WVlGcU52VCffD4wA4FPw5Q/4PrgDiDM2q5w1d/30HuHP5G7xlrxii2ioqGCEKf6tXSPKJOdxY12A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5598
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Mon, Dec 04, 2023 at 02:46:41PM -0800, Randy Dunlap wrote:
> Hi ktr,
> 
> On 11/20/23 18:31, kernel test robot wrote:
> > Hi Ruslan,
> > 
> > FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
> > commit: d355339eecd986648420e05f8c958fbc78dbb382 usb: gadget: function: make current f_uac1 implementation legacy
> > date:   6 years ago
> > config: i386-randconfig-002-20231120 (https://download.01.org/0day-ci/archive/20231121/202311211052.RsFuk4Gr-lkp@intel.com/config)
> > compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211052.RsFuk4Gr-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202311211052.RsFuk4Gr-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> 
> I can't reproduce any of these warnings.
> 
> I think that you should reevaluate something here.

These warnings are produced by kernel-doc tool:

$ git checkout d355339eecd986648420e05f8c958fbc78dbb382
HEAD is now at d355339eecd9 usb: gadget: function: make current f_uac1 implementation legacy

$ scripts/kernel-doc drivers/usb/gadget/function/u_uac1_legacy.c 1>/dev/null
drivers/usb/gadget/function/u_uac1_legacy.c:33: warning: No description found for parameter 'i'
drivers/usb/gadget/function/u_uac1_legacy.c:33: warning: No description found for parameter 'val'
drivers/usb/gadget/function/u_uac1_legacy.c:96: warning: No description found for parameter 'snd'
drivers/usb/gadget/function/u_uac1_legacy.c:156: warning: No description found for parameter 'card'
drivers/usb/gadget/function/u_uac1_legacy.c:156: warning: No description found for parameter 'buf'
drivers/usb/gadget/function/u_uac1_legacy.c:156: warning: No description found for parameter 'count'
drivers/usb/gadget/function/u_uac1_legacy.c:205: warning: No description found for parameter 'card'
drivers/usb/gadget/function/u_uac1_legacy.c:265: warning: No description found for parameter 'gau'
drivers/usb/gadget/function/u_uac1_legacy.c:294: warning: No description found for parameter 'card'
drivers/usb/gadget/function/u_uac1_legacy.c:311: warning: No description found for parameter 'the_card'

Since this is a "move files around" commit that renames u_uac1.c to
u_uac1_legacy.c, and the warnings already exist before this commit, so
this is a false report. Sorry for this.

We introduced a new feature into the bot recently to bisect old
document warnings, but it is not working very smoothly and produces some
false reports. The "steps to reproduce" was not updated in time,
either. We are investigating these issues and will fix them soon.
Apologies again for any noise reports.

Best Regards,
Yujie

> 
> 
> >>> drivers/usb/gadget/function/f_uac1_legacy.c:1: warning: no structured comments found
> > --
> >>> drivers/usb/gadget/function/u_uac1_legacy.c:33: warning: No description found for parameter 'i'
> >>> drivers/usb/gadget/function/u_uac1_legacy.c:33: warning: No description found for parameter 'val'
> >>> drivers/usb/gadget/function/u_uac1_legacy.c:96: warning: No description found for parameter 'snd'
> >>> drivers/usb/gadget/function/u_uac1_legacy.c:156: warning: No description found for parameter 'card'
> >>> drivers/usb/gadget/function/u_uac1_legacy.c:156: warning: No description found for parameter 'buf'
> >>> drivers/usb/gadget/function/u_uac1_legacy.c:156: warning: No description found for parameter 'count'
> >    drivers/usb/gadget/function/u_uac1_legacy.c:205: warning: No description found for parameter 'card'
> >>> drivers/usb/gadget/function/u_uac1_legacy.c:265: warning: No description found for parameter 'gau'
> >    drivers/usb/gadget/function/u_uac1_legacy.c:294: warning: No description found for parameter 'card'
> >>> drivers/usb/gadget/function/u_uac1_legacy.c:311: warning: No description found for parameter 'the_card'
> > 
> > 
> > vim +1 drivers/usb/gadget/function/f_uac1_legacy.c
> > 
> > c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03  @1  /*
> > c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   2   * f_audio.c -- USB Audio class function driver
> > c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   3    *
> > c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   4   * Copyright (C) 2008 Bryan Wu <cooloney@kernel.org>
> > c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   5   * Copyright (C) 2008 Analog Devices, Inc
> > c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   6   *
> > c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   7   * Enter bugs at http://blackfin.uclinux.org/
> > c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   8   *
> > c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   9   * Licensed under the GPL-2 or later.
> > c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03  10   */
> > c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03  11  
> > 
> > :::::: The code at line 1 was first introduced by commit
> > :::::: c6994e6f067cf0fc4c6cca3d164018b1150916f8 USB: gadget: add USB Audio Gadget driver
> > 
> > :::::: TO: Bryan Wu <cooloney@kernel.org>
> > :::::: CC: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> 
> -- 
> ~Randy
> 
