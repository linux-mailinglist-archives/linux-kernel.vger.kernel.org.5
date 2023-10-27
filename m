Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F817D8E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 07:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjJ0FYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 01:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJ0FYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 01:24:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EC31A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 22:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698384250; x=1729920250;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jKyluwpaeLJQ/fZA4yKP4k33dS0rZF3B7GHPtK3JgGs=;
  b=NV8g96d4qPQQsbxeMuOyzPkJjrGfq3h5Q9rD9HVapODQTOQSEDKu/G5D
   mQwDGOPs5PTyEPhxKKRFkxfpEgKLqCigNHdEOOFtv3tYZ4Pq04v2gfk6p
   kI/Sg3/RKHpEtt7Xt+ULnfOJ1NANtbnUOy1e1xdUvMMaeztihynVfZz9C
   7QlATmouguSzoGfGI082e8v1hOrIq4A/1RUmcuDs6SXO/9Y2Qpo1kxY89
   QAo3P554p6mQPjLxvykQXumTtbPGdPP4h9D7onYZsURD6VMi0sS0+9pLc
   HckmGEC9KCYAWVmN0T+F4hvTMOVjUeJz8T00ZCvcwO6Jt/ASb3pSp95Ea
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="418819735"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="418819735"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 22:24:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="876215234"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="876215234"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 22:24:10 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 22:24:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 22:24:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 26 Oct 2023 22:24:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyvsiFHi9TfRGjbve9WN2A2/LUDfr6qrtjgE7PM06saK185IPM8PFkvYUvAqx9pCjPmaJ9LtzZDj570RY7BG4C+B3EKOehEq7sCbyMFWY3/nEfXbTqc35c4LVLQxyX+UVg/BRgXwaI2TW/z9aYzI1dyzLaAcM3NPxPLJYN0Ai/GolV29tcP2n6rc1VPy0yk7msotrtYzngv1t6L118Jf09jMsF9h6oPnAIGnzmZnbsWiAeD1IBrYyzn/qaHUd+vjyUAUhTaBLvlA8o73KBOAVoQdY+5GB5RDJQkMUbTwj/XFXbN9J6RffYYnKwU6kXTzMt1MoMLMz0x3iJr2DvcZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YToIQxrxktk6sjKp2wcOsnLu9J+KeP8i1R/Sl8WTtJU=;
 b=kfywEFrJVFaFph8WWMpujbePwRPMYbV9CJJl4O5GCcuuGfxXWjQc5o0QJGwri24xT/Bwy+Zw1E/890y8VsAFb9gLg2OAcj5UKSqXjDa4IpQgHoSu5lJCQfFsXm6iw19pz5iG6c0NOMTEvhlH7CSQ25UoErAd0PymdOb/Gg4Ddb5b4vlerWdgwqxWzoKRGOBEB8UPrXDlI1FkD2TCJzxmRSKGrY/GO7Xjhx6/9sOpYRKQ7Ek+4VngqDb0nFGAEmzgfx+JqRhsFiRVYDOzZ16JEPRIQASdLB1GGp0MQx6hiCJRZE0/wpVA+XYuPrEB0Y2LQfRFOHew0SP6TiMF4PGMvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SA1PR11MB5801.namprd11.prod.outlook.com (2603:10b6:806:23d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 05:24:08 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 05:24:08 +0000
Date:   Fri, 27 Oct 2023 13:19:21 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     kernel test robot <lkp@intel.com>,
        Tom Zanussi <zanussi@kernel.org>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: kernel/trace/trace_kprobe.c:952: warning: Excess function
 parameter 'args' description in '__kprobe_event_gen_cmd_start'
Message-ID: <ZTtIWZ/Ol3SuirV8@yujie-X299>
References: <202310190437.paI6LYJF-lkp@intel.com>
 <20231019092207.7d2fa545@gandalf.local.home>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231019092207.7d2fa545@gandalf.local.home>
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SA1PR11MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ddefe3-e460-4a0c-22a2-08dbd6acf18e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RSBYOVdMrEOORO6NYtHvRIttjnrMfYwGDTmUXAn6aiAiKYaGpNELfwT+1VH/YHCgTj1Mt+fRnsGQPz1B2dTlNVquf0T7XKczDTyqPnKlR7SlllZqWME5DY2qXxCSsNDyCC2lUWGh/7fRKXw/Yk6SRrblYsJAOG7qmTKJmmK2OxwWwxZx4pc8NCDyqKAYhrllu5ePWqAfKkcqSXgr2/QZ1O0OspiMEuCy8T2P/y0dFN7tlD4Za00QPvxgr9rmb+gtbIw9fFx1LuHLSUIogW0c4MfwnrVGarFfRxIVnqYSd4XMFJlkDL0BkWMHurjGuSKsQ51oKpEe96iCnmCDMTx4Zr36EO0bTjZEjl1htX1AojYMRIr/rhubFwLVk/hsl4ULj78xtj9kGgrTgPWmdAhgb3F1oX6/U9bod6Ub7FSA6WYZ/Y5lJ3U5fgqJWMwRgtXaKEOvgSxVlFkZIzxeEzZrjNZNWzdsW2u6M5X2GI733fEyhZruEVkbQw4rLW8MkXh5XDRBzqr00HgXKKhVkggpN4lj4UXmjvkqSXQNIkbQ10Cxmn5WarrT9v13WhLc3jFIrFXIfcrl6Bx09Ke7E3m7uMlhO2fSeijnrrooXmB5qy4S+Xc/uQRir1RuTSftaiRa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(366004)(346002)(136003)(39860400002)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(38100700002)(83380400001)(6506007)(6512007)(6666004)(9686003)(33716001)(66946007)(54906003)(966005)(6486002)(82960400001)(478600001)(26005)(6916009)(316002)(66556008)(66476007)(8936002)(8676002)(4326008)(5660300002)(41300700001)(44832011)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l9fdtmAOpCV24w4kZRamvN10FJlEwb2ho2fd4q3y4KjJ/45szl0T2wkp1KKc?=
 =?us-ascii?Q?f025we4Ui5sdD3eJA2JBG3jV9tbK8NzUvZZCoJxOVzg/WoGyRLnDefA8ILAX?=
 =?us-ascii?Q?BrqGnTmzCojh+5WxvFM2YND2qWFk6cgcCdcTICQhCvNUWVMF6zAOWvb8i6wF?=
 =?us-ascii?Q?S3fLbpj+UM+wH71gwppax89mzqrnzueoYofNpY4QSL4387j7n1dseiDF1VfC?=
 =?us-ascii?Q?b8J8hrQXoWWExF1BKgHLJDbgohQFDL+leqtuGRD2WxQZXuxi9RSim6NfwH9l?=
 =?us-ascii?Q?hCf1bPTR9Ths9GhUmPKyEJVEmWBm/O1c6/6bAGsSO1r89QNmVJqw7ZR+1z41?=
 =?us-ascii?Q?jUYQ35rbw4ee81UfsqgFB/b5YOsR/aOA1yFhSAaHEBUYSWQqAhfPVmv8U0kN?=
 =?us-ascii?Q?xtCOyvsRyMcHAGgglYKhIr+DBX438CsLjwzLub3wTnwbjMdM14kkIOBsLaEN?=
 =?us-ascii?Q?HAayqphw183/XwxLGLygTVfj8ZmPwPXuatno2nFJCCqpeZnBt0HvQJQtIKLW?=
 =?us-ascii?Q?6bI+hyI8KpndseXJmNB6RvCG3nLoPo7CDGcEbkqWR3t66wdZVs1RtIlEiTtS?=
 =?us-ascii?Q?+gudwvbdeHxUSJY6OJUs6gCZXlEQgZN3J10D7jfIAT9ZhCp7uO1kNaiotjRT?=
 =?us-ascii?Q?dvLvvlb/aGeB6S6bboPycGSMBdtqZW0RBTQZx3J5nOg/MJNb2rXwUm7kIQcf?=
 =?us-ascii?Q?OmLJ/s/AfZ6sqs/wijtd8X3XOPu2feeBkhu+/KwiP7OKzOrilcvGQ/3tfD64?=
 =?us-ascii?Q?SDoaO4yq2Q0w4v2DypLj6sRKDNwI6j15Xb9sd+IJg/3wCS+nDOoW+t1yq3Ow?=
 =?us-ascii?Q?HKpTdoidcKv8W2AnixwvzyQSOh+C+Q3S3TtQSvss2bSO8rAa9PRQAzxhBN9x?=
 =?us-ascii?Q?8OgFdxf81zkVIqPdsN8bmxvezaKMa3aXsnEBH1w1fXya9U/7z2IvTQxsdHiU?=
 =?us-ascii?Q?hPLglHsd4idoQIe/Eh0lPds3OkflUbGY2uLhSIDWqRSirlJzfe3j2By8xonY?=
 =?us-ascii?Q?qLby+8VrA8ZH7i0cx6F1fsDhJFk8cgc5tIoE93G5flyGdphpcELIPmmL6qPI?=
 =?us-ascii?Q?lbnNlZyJWwOEqR9cUx4yspXrYQHUB2mvRTIvH90CPw/vXf5fVz/ji4DIVL1H?=
 =?us-ascii?Q?g/RiiEVyDvXLpNDYHQd4CnAxsGIPeA/a5SbVuj65hlhm1sT+DMBq5+HvN8Sj?=
 =?us-ascii?Q?oIEHW+yXvjBzI8+/5g/pyOFOOLD5teenXMdtAaEwqVsqQB2WZUeqrv9CoN+G?=
 =?us-ascii?Q?kjr4c+EoNUTMQij6AuO7dVyckTRfg0XbpstKS8HIB/EmiFnpQ/V/ZbHAO2Pr?=
 =?us-ascii?Q?fzbHPz1iIe8eMNgCAl/QYBD7SgkF6oE+8MgDJOJQGOYUTscd7ZEsugN7kcRq?=
 =?us-ascii?Q?bnCG371ujGk0cS0fWr6lr79n7u1NtR29lTyD+QjqSZbXPVQ7fOQ5+N5ZQpTc?=
 =?us-ascii?Q?Jf4Sw1j/OzB62NQPSduV1RkeKj4LITLunrs+SOl5Cs6BrmBFCEBlh7IX9IIQ?=
 =?us-ascii?Q?QsukkbyTkMNzZ7y9gYUKTI5WzEVzz6oOuTbpu/noEZHAth6PTlBffHQxQpcX?=
 =?us-ascii?Q?pL/H9wf4wqUbOuvbg/xlrCSSYODa/2DBenoERyEh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ddefe3-e460-4a0c-22a2-08dbd6acf18e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 05:24:07.9586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLJlGhXDVjGcmCxFrv5hsp1eywvV9YPJPN19SvTUqMR3qW9kHNNpQcRTyLy5rG430jtRZJ3Qn9n9uPHFVDWdmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5801
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 09:22:07AM -0400, Steven Rostedt wrote:
> On Thu, 19 Oct 2023 04:33:41 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
> > All warnings (new ones prefixed by >>):
> > 
> > >> kernel/trace/trace_kprobe.c:952: warning: Excess function parameter 'args' description in '__kprobe_event_gen_cmd_start'
> > >> kernel/trace/trace_kprobe.c:1017: warning: Excess function parameter 'args' description in '__kprobe_event_add_fields'  
> > 
> > 
> > vim +952 kernel/trace/trace_kprobe.c
> > 
> >    929	
> >    930	/**
> >    931	 * __kprobe_event_gen_cmd_start - Generate a kprobe event command from arg list
> >    932	 * @cmd: A pointer to the dynevent_cmd struct representing the new event
> >    933	 * @name: The name of the kprobe event
> >    934	 * @loc: The location of the kprobe event
> >    935	 * @kretprobe: Is this a return probe?
> >    936	 * @args: Variable number of arg (pairs), one pair for each field
> >    937	 *
> >    938	 * NOTE: Users normally won't want to call this function directly, but
> >    939	 * rather use the kprobe_event_gen_cmd_start() wrapper, which automatically
> >    940	 * adds a NULL to the end of the arg list.  If this function is used
> >    941	 * directly, make sure the last arg in the variable arg list is NULL.
> >    942	 *
> >    943	 * Generate a kprobe event command to be executed by
> >    944	 * kprobe_event_gen_cmd_end().  This function can be used to generate the
> >    945	 * complete command or only the first part of it; in the latter case,
> >    946	 * kprobe_event_add_fields() can be used to add more fields following this.
> >    947	 *
> >    948	 * Return: 0 if successful, error otherwise.
> >    949	 */
> >    950	int __kprobe_event_gen_cmd_start(struct dynevent_cmd *cmd, bool kretprobe,
> >    951					 const char *name, const char *loc, ...)
> >  > 952	{  
> 
> So what is the proper kerneldoc way to express variable length arguments?

Hi Steven, the fix patch is sent at [1] to fix this kernel-doc warning.

[1] https://lore.kernel.org/all/20231027041315.2613166-1-yujie.liu@intel.com/

Best Regards,
Yujie
