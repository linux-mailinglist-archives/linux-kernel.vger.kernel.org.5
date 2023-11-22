Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424E07F3BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 03:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbjKVCM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 21:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjKVCMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 21:12:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2FA18E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 18:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700619171; x=1732155171;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=u9AEygHi1VmL5Z/rdp8xPPTCjETKXq9YSsH5eecs3zg=;
  b=KwGVA9WfMCI9sBel14zDzn8mHbLRzyYyNVb1iTo8bf0cHgThBFnsoyOy
   gPU0QBGlCJJQXRHZF+UCNAo52f4Wcb5w0Vqf1qfc813ZR1oR/bistnSTw
   EbJo8EqqAccXPzpP5JUFzbpCwdmTn6ZE6ztjqHvJ3qu4qgGUgVSZ0NWjb
   JC3NVf6Za26JOy2Jr4GnI5Zic37Q6TtBreR6Ehod4NJ7QcsBIuaTgqhaI
   sHcfBfe5cucFyt1QWGTUZrhWUWiVT8z8QFLQX3lCyIIFgDFDazzGaZK1L
   2A2LMx7Gc5wDM0xC/77gVPJjUeI9zpdiE/c4J7UFvXz5Y/MLOWJ6BptVy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="478174648"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="478174648"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 18:12:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="884387220"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="884387220"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 18:12:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 18:12:50 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 18:12:50 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 18:12:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDfoVnDPz2TSdM9HApPecGywr1t5HEKfB3UWulyaAZhj4R4wgsfu+kqNY0D24AtU/6nmvPTZU+4y/nsoUA6WjLbUxahz8NX+KxsUnG0/jw6egjh6BIjfdOQCBhsT4NL4hi9IjAtNWtmlGk8oYkApMJdWjsCArTQiB+wVXrHdJTBg5zsVWt9bUb7XdPUmjM4BctT7OA64FJh9yZHOdOvM8l9OEFkO+x0Yciyv40P7cI6Z2UptM2q0Kx7IiaQ3tq/XLAPwIVrRvTcQbDQBPQQvW3cjMhPZ8eNYYEYCODmnga0cb5Hfb7TyJ+uAZ/4szQGEz96auCQYwmMowNQ+8Y2qpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n83F03R8AO/kccl00dwNd0KdJ/5+q1UyhbtEqwkXV2I=;
 b=IqScBn34d+VPlDcio8FOxO08IyzQLNozMDl3n4hxtpqiAxBMRSjEorz2znK80GrO8W+7CcxqRbJQp0kEYstU6SIWVah5U5jL+/a8LPOuyM2rnFEHrJWws4bM7kI8EeYxT33sMtMGhqI9qfx//dMQ6p7GtNseznDnNGVY8zp+MnjPrX3SVcNNAgzZEyxKeZE+BDXa2kmlT5k4N0S09pzIavRDsYF3LHUnx137N2TWgj8GQWbeqpxnz0URIntTHBnuIeJZVjIYpq6O8+yZD1BdETY2KLFiCMd4S/8nGnjRwMZ4ubRzdMUsw4KRDuE36dfZf2jV4sw07p2gcSY8+xrvIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CH3PR11MB7938.namprd11.prod.outlook.com (2603:10b6:610:12f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 02:12:48 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 02:12:47 +0000
Date:   Wed, 22 Nov 2023 10:08:10 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Waiman Long <longman@redhat.com>,
        kernel test robot <lkp@intel.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: kernel/cgroup/debug.c:1: warning: no structured comments found
Message-ID: <ZV1iimYpmpk9LZWS@yujie-X299>
References: <202311211005.Qwt1FHrO-lkp@intel.com>
 <569119a8-f6f2-4e00-bfcc-5b804447320f@redhat.com>
 <2a4813ff-54a7-49b0-8d18-4cb54621e637@infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a4813ff-54a7-49b0-8d18-4cb54621e637@infradead.org>
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CH3PR11MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e49883-e548-4aed-7996-08dbeb008573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: egDEv7CYPn8Ta6Pd1IuC/qWwFbpotIvxb2Rii5yt5aMf8SExFLtq704aqG6vXXCySyIINGIuw1S7sAFu25nS8eIDhAv2qqa9qcbnfQCgRXg0BYeVvajgbeuV0l54KiOnWsIY9zeRmQr4hh0v3APWgG4omQOQk9klRUgUP8ofopNxEHra+RgTta3HTquNeGmdRUiPBwGjdXsMhz/xWYSHC7G4TG2XeJ5h3/xjJiWyk2Fh4414tP0j0Q9tu4CTTMUs3zcgqIEUorXX12fLrmQxVSdPaNTGo+Z02P+/Sdu9FAsnOUK7AV7Po56jbeux+fc6JNWMaV0/ndz5YwEPSc2DAdYLMXRyO5usyTQlwCOs8cREuKUcw9uYFGJScfsAp2ja5PIImdPpC9GMALMbuLkVBmVhnDI08rHR6jx6+UmWIUYbkoroy9nMVyOU+JvUX/9RVN5/gJEn+WagjWJLHoZVQCKIxvUnnTs/DdC16rmHw/X42rUkxFn72dZe+k3t4YXr5KTlp67tgpB8mPzMQVe4Xm68auPzE8U3xZ4QRdWNxZ65jiBWg+lIrNRy88gL3i0lCMPot098xQzswWbCazZv2nsR9awzof4QQjiaepVTmveh3NWxZNHVF8MKUlLTVFh1lRZ18I/cA85z+RHMJSFVhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(376002)(366004)(136003)(346002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(5660300002)(26005)(44832011)(2906002)(4326008)(8936002)(66556008)(54906003)(66946007)(6916009)(316002)(8676002)(41300700001)(66476007)(6666004)(6506007)(966005)(478600001)(6486002)(53546011)(9686003)(6512007)(83380400001)(38100700002)(33716001)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tzvqHp3rQwg5J6nKckxw/T/i7VtKBN1lzPU5Ua8W1+drbLD6cMJGZnSnZL?=
 =?iso-8859-1?Q?n560P0r7pDTATg1PcbWMZ+ecSuePpHoyqrNv5Egq2Le+ud/8a0R1PZxxfg?=
 =?iso-8859-1?Q?dYKE+htp1Sd8RKeP5DYX9NS4AzkP2hTGDsKx7havxZIaD1SdbJHPLxHSYW?=
 =?iso-8859-1?Q?RZuQPqtLqLJ6/cUxepRC16AzCu0ZxFR5R/ReXmQBxz7/8oYbv4QpY0zD+1?=
 =?iso-8859-1?Q?9stc9PYD5pTJfL9znuUhyDo1PhrW+ZhYpxO3tiKCIghXdbPfL7CwgpDZiB?=
 =?iso-8859-1?Q?GtYqu81jbVRTaQpUaJWyVQNolh2IuPHF8k8RMfvJz2bj40fHcM20QnTao0?=
 =?iso-8859-1?Q?KTISyoFXKq/XkySYYMvioUttkOJj9w18vNSpRrnSuFl7S+7r3wDNdai/5a?=
 =?iso-8859-1?Q?P/P4c48X72JRRqIA4WNUgrPeHyaSd94qBXMjBlnHabFnvFetyOLP/U1TW9?=
 =?iso-8859-1?Q?1dwv8It4q9AyX0sD4HXUgiFyKMYDjQ4X9VyPS3hnABW6MplmW7zbRhyHqb?=
 =?iso-8859-1?Q?qyfagF4NQIE48wQDUK8c0WHw7y4ZSVp0QEknbi0BzGQP3oF7pE1qf0vj1p?=
 =?iso-8859-1?Q?lYudbF52eVql4/++V5jOJBW5uWf+BKXrqiWNOyS1R3ZOgDtKcjsvNp9xyr?=
 =?iso-8859-1?Q?/pcRloR7wduAqOrWSuEw5fYaMYOY7AxlwcktWB87LVY9DU/sooB4nW/JHB?=
 =?iso-8859-1?Q?qYSXjULheHXh+FY18b1Rbw/IGtT2DziGHADXso6h5mv87CrRTaPKXcVvlu?=
 =?iso-8859-1?Q?1Djn9YbnWesTJteV779gkdXzuLjUcU+5KEFaOAPXhRqywxV+qnFXV/5DSk?=
 =?iso-8859-1?Q?bCFx6jVU6uZPRhYU3TQtUWLuOOneEKtEm4LjbVg8yaTQEAoJesJY2SgGlY?=
 =?iso-8859-1?Q?GwFrmEMTsNyPC39fFtxuSZysiX+LxUXL4JPeadlOQkkpHD1Dxo0bGFzSMW?=
 =?iso-8859-1?Q?UHh3krdyGT0G9SKgR5nu8hhbrsXPSm3GWJS+yblsnNoPQOrQnnEVLgjw6T?=
 =?iso-8859-1?Q?RnzFI9JmVXF6v/+pPW91FfQCbUSvEjaf6pqVddK/1VVgsyVqImVbc3T8eQ?=
 =?iso-8859-1?Q?D2st/XlPM5xDlo24JERChWnNCieuGTN0wkhJtQcxQXIMqMJSqyyLeKiMzQ?=
 =?iso-8859-1?Q?id/Gobhxn70xEG6sSGW4PFzyr9zykMwMsmgvkOfhs++i8DLIL8hvp2nJpf?=
 =?iso-8859-1?Q?409DbljKCVFP3vWbXCCJB5DlWKCpYeGuKKzusZDA0J8EAfwOBt+BgaNcjf?=
 =?iso-8859-1?Q?4qCD6YKArenjYtiKLQWD9huAhdWRx+gttH+OyKPy3mdT7k13MofCcOUXbo?=
 =?iso-8859-1?Q?4lwxE8TFXl1Rs9WPx+x3eqyviQpujzFTTsy4OuHO4t5HbmGI+KcYZqtBdS?=
 =?iso-8859-1?Q?nMF+bMEIHyrhwlvCF/OqG6eYwUJDo5XVjEZrqtcuHedrnB+vBbHTYmYkYL?=
 =?iso-8859-1?Q?VuIt7yBc+z/YOTArWgd+Kg7hHguLdTEb2mUsumArfZYnZKh8UjIt6cM6gx?=
 =?iso-8859-1?Q?iJbit2Y8W2qlzT6bueMjgU/N+fAs++Cazov4U4mrwgTJjVRrfgkY7ECY07?=
 =?iso-8859-1?Q?c7jM0PaS+GM8fqJDSreA3REYLNpnoqjWuDCnvWnUxU0bMJwHvXqfaPm1ZB?=
 =?iso-8859-1?Q?02TWKblAmajnof1M8WcJsYaHPvhI1WWDU8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e49883-e548-4aed-7996-08dbeb008573
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 02:12:47.7629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ct2ABtlQvCfgqQUnOg01PJxkRl+6wBYjbbksdpuiI/acdkDrkvrIff4PRWSgs32GlCnaWql3ag74VczHwxD7cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7938
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

On Mon, Nov 20, 2023 at 08:11:07PM -0800, Randy Dunlap wrote:
> Hi,
> 
> On 11/20/23 19:04, Waiman Long wrote:
> > 
> > On 11/20/23 21:32, kernel test robot wrote:
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >> head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
> >> commit: a28f8f5e995fe5964ae304444913536058f26e37 cgroup: Move debug cgroup to its own file
> >> date:   6 years ago
> >> config: i386-buildonly-randconfig-005-20231120 (https://download.01.org/0day-ci/archive/20231121/202311211005.Qwt1FHrO-lkp@intel.com/config)
> >> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> >> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211005.Qwt1FHrO-lkp@intel.com/reproduce)
> >>
> >> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> >> the same patch/commit), kindly add following tags
> >> | Reported-by: kernel test robot <lkp@intel.com>
> >> | Closes: https://lore.kernel.org/oe-kbuild-all/202311211005.Qwt1FHrO-lkp@intel.com/
> >>
> >> All warnings (new ones prefixed by >>):
> >>
> >>>> kernel/cgroup/debug.c:1: warning: no structured comments found
> >>
> >> vim +1 kernel/cgroup/debug.c
> >>
> >>     > 1    #include <linux/ctype.h>
> >>       2    #include <linux/mm.h>
> >>       3    #include <linux/slab.h>
> >>       4   
> > 
> > Yes, there is no function in this file with structure comments. This debug controller is used for debugging only and is not supposed to be used on production systems anyway. Its interface is unstable and so I don't see a need to properly document its interface.
> > 
> > I will leave this file as it is for now.
> 
> Yes :)
> 
> 
> This warning usually happens when some file is referenced in the
> Documentation/ tree while building 'make htmldocs', e.g.
> 
> But this source file is not used in Documentation/ at all,
> so this report seems to have some kind of a problem.
> Also, I could not reproduce the warning.

Thanks for the information. We've configured the bot to ignore this
warning. Sorry for the noise.

Best Regards,
Yujie
