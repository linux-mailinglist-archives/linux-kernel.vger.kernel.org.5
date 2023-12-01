Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1948016EC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjLAW6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAW6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:58:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70DA90;
        Fri,  1 Dec 2023 14:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701471507; x=1733007507;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=neuoGL2rDyNLHbk3dO/IhvB7XXA+E91HNoiQAmqhVNU=;
  b=Rp5lM3p+g+bZa31D/E9507ZMMs1Er2hrwKOlR1CwzxMgK0R0DfPNj+br
   TJFpLU7+dSyL2JExPMtZbj+6Zejn3SQ+Jl3Vf9RUG+3x69F/op680YZSu
   PANuEfMFtWrcBGvw2S8uoCYHPvpW6FL8S2TFCGXWxPs37xFRkswyUsIIY
   lOiYnRFoff6JNbD4nEQGjMQvs6vNy0OwwGV0J4eQXh49LyGC9+TzGfnVx
   7Er6r8CRAdbRiUXzq24DPclTK0BTt3XeBSW064nc9B6ORkjjUdAwfYCpn
   j38S67s2bETZ5ifgvm8FjZCSK2MBruhIffn+cHtQYy7JMVZPhU9p1DEia
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="457883255"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="457883255"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 14:58:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="887811846"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="887811846"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Dec 2023 14:58:26 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 14:58:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 14:58:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 1 Dec 2023 14:58:25 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 1 Dec 2023 14:58:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKd0QzzFaYDAS/kcyeS5GTeO2v5ar0pvk/yKyr6yaW84GEcstvE0Io4x1CgWNGuUCvbcHSGfUyZwLQSkLd6hYEIGYwvfFoixJHjIJSdXVchtqzMWyNLHC4q4dvKB4Jj4CD2yMA42UijrmeQhuxwY9Ny/n+OWVT0s1XPzYcIqg/wU4g8gVSkB9MexBOG0yUCcuo+BJJwA3u6ZdT3TQBXZNQj6xNrazGEQa0wHjVE2aeZoinkPdGvX2XnwEAilI0OuW7tS/wTI2VUAgXCWus0BMBQWr9WtYKeaDdM7rA8gyTmEOyMUnwNG6KrvoydNMOD5oTFEnP1F6ShmaUlEEHN7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HloHzmvZvY0iGtd1ivi2/tJQFAkaVjq31kVr+YzT2L8=;
 b=M41qGiKhiewmle+9CLOFoTuJexaPthgq+r7a5JpLDdcIW24BKqUecMCBH/J250HdB++t3qHKuTUCFBhPd/M0bC7oicUILgwzvyGlXI5gFDW9uqtasYF5Ul9KCmDCPiQwQ9WiBA4qKvVD0Za04eC7eH7aD/rri99+OThhR7DDm4avbBx86dgaxkbOVTo6h7aeNxqeR7TAB/jzb1ysRh8TwinIP/4e1E7cOTEhInGHqJukVuCq0NuAXo0QpYIfAdOREo8FBViSfcRnH8K+yAHoNBmHqDNRwdQ7ongUi1P5QSzah/fVQ/x9mlRN1wN9KKMCUF4PpAi3ewVWtNDaYgah2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by CY8PR11MB7337.namprd11.prod.outlook.com (2603:10b6:930:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Fri, 1 Dec
 2023 22:58:23 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e%5]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 22:58:23 +0000
Date:   Fri, 1 Dec 2023 14:58:18 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>
CC:     "ashok_raj@linux.intel.com" <ashok_raj@linux.intel.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 3/3] hwmon: (coretemp) Fix core count limitation
Message-ID: <ZWplCq1hg9gydfEy@a4bf019067fa.jf.intel.com>
References: <20231127131651.476795-1-rui.zhang@intel.com>
 <20231127131651.476795-4-rui.zhang@intel.com>
 <ZWlAKS2iK9Oy+7tQ@araj-dh-work.jf.intel.com>
 <9f97885ace55b6f928160a178bc0ec505ac6eeb3.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f97885ace55b6f928160a178bc0ec505ac6eeb3.camel@intel.com>
X-ClientProxiedBy: MW4P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::35) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|CY8PR11MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: b14a14dc-f85b-42ff-e35d-08dbf2c10573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x8ign0BAWPpu0aNC8BLm/8cNqU7mzVFW3WaOXocq60CdwI35JfnsYhEWz49jmRIy78biIJRgBaLfG9iZ8zBIRepr3VA326NcllQS31Kb5LYLrkDOEV5gg/2RZaLT0tB4b47VoMIP/8Xmy1zhPGzeCc/aLQ28QDQO6rsLqnMWbOTFj/QMptsOjO7fXB+sn7cWmJWqAIjAN+4KocqfIJdtS9V+f9cx6mvP65IWWMaDOZj1y4p8hQ5OuIqr1IM5ZEeN7cmyZkmH4uUCWuMy0xsyoN/4rkrTiGGu62q5+JeHoOT/rKEfb6c4bFNYVjOOnoDKkY+95e6EdhInx9DAL2I+DWzNeLcEtBYzVUw75rI9s2JdxrqzG4+XchZJ7MI5dU0s+R1J723BdK+Ob9CW/5QlM4qmBSLJOdAvm+oY6hIFzKR42gNs0wZDl2tIsm2zXBbSOF2nleQydu4x7AEvPSb7RoH/BuWdVu+hcOQd/clKGXbd/hzdNPTc+Qfz43+h8sX7d9vpTNVuVpj8Ut3aqrYF52epDyQzzGEe4o3nCvQxJwWqmpizTOm/rpourzV+Wcpg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(38100700002)(4001150100001)(86362001)(83380400001)(82960400001)(5660300002)(44832011)(2906002)(26005)(8936002)(6506007)(6666004)(6862004)(4326008)(8676002)(6512007)(6486002)(478600001)(54906003)(6636002)(66556008)(66946007)(66476007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?7Y9yrQX1YL4UA8lNNmdohrVWcDWFTt7TW/7XEIWcHFYmPBsSmy3mdaLkbe?=
 =?iso-8859-1?Q?ayPILe2r/gMut7+wCuU6sKn4fwJqoQmni1P7StgIHFyr1j51d43h6ecrpf?=
 =?iso-8859-1?Q?r3nC58R9YCrub3kTWiBq3+si092aToIOaL9i/UeHy+OxHHwvGcwNOjeQ7t?=
 =?iso-8859-1?Q?ToTXcV8ODE9ehlMK1x+Du4qagFy56plMHi/SAUsZfZdareI0ikmncimdDY?=
 =?iso-8859-1?Q?ou2dGdEt3RdNaVQALF1dA6S44zTkAfX3YX2GPHKCkYaReiLbjDv94VuYFe?=
 =?iso-8859-1?Q?mEu5So/Mb7QcaJRHk8aa4ksQi/E126Np9qazCdD7ridO9BYZHLJBJVMjUJ?=
 =?iso-8859-1?Q?tQ0fsw4wEb5wjFdPRs1+n8MSxGOYnnJ3/oOnEf2Xnz2fcoYcp/IopOe5G/?=
 =?iso-8859-1?Q?ARbxdK/kg1k0yfxpzrCfUdfb4HWh/2AvuFg4Ih12YrBKHr2tu6mI8K7+Yu?=
 =?iso-8859-1?Q?s20k+eRZvcxkQh2kJocZ9F2avnEgvSiDP1VhuoTjSeBgN1oJZTX8fdF85z?=
 =?iso-8859-1?Q?eo+1rlq6vbjJs7npryLr9W9epcI0QyVSpAjdxjdt6uEiFW3lsRR0MkmX/G?=
 =?iso-8859-1?Q?Y4dRJgXWE2yrIsMMNfvv29+fubqC+maKOmNByPtgS0BzRnAdouSyhdF6mn?=
 =?iso-8859-1?Q?3NHHyeuXNmt1GPVx6uwOfrkiOmzcx7Bau8pipZ8ubNB2ZcSRPn9t7YWEqA?=
 =?iso-8859-1?Q?5SIvqxJwv1x3uG5Mk2Md/n6AGizWpQ6jwEf4ENxTB2/hfA3UgK0MF/oiId?=
 =?iso-8859-1?Q?mAqjQEqAp8L66uTwL0vShfvrbufC0gjXlZkZg6C+KF87TyJ012Ru82biSP?=
 =?iso-8859-1?Q?X9e3VKJ1F3GJf5bE/oKRg79yaOW8ZLxdAa4pMfoz69u4FPzLCdeknRxo/L?=
 =?iso-8859-1?Q?7rTw1Esas2+hWqnzi7urKCt9o1nncdddOwsrpi/V1etxKMCMlGc7lUyDcz?=
 =?iso-8859-1?Q?jDW0Mfgt5bEsHfdGpQH6EiDR152WML3hhhdZV3RY/2K5vS+hiOXl2iLEzW?=
 =?iso-8859-1?Q?O6t+C518O3wUk2vGBd9ZDeBv+H0dksr+OS4CeVRlFXgiYgKCzdzD4nFU+b?=
 =?iso-8859-1?Q?zya1lrX5cZEMe/pj4I10OdCLFfpTcqIrdzyXoNCys1F+xT6JPdUlPWVlaJ?=
 =?iso-8859-1?Q?0GUrF6Mp68VKFCCk/Iju5ln6Ovjh9Yz/9/gXiehNnpRhAI2A8oewrL18BG?=
 =?iso-8859-1?Q?NzVwEes3dPLUQJe+YDY65ucUQan4O7tXBt0TskrQWfUrvTpW+Ujs7l4EnA?=
 =?iso-8859-1?Q?rvxEEci4ZKv+D0zmcCgOWCgjCzFCq/3ODXlv0v92r5CwMOoEaU91Jwb72E?=
 =?iso-8859-1?Q?0aHQjE8BWtj3Jfgj5hCJ60B93CvR3iJJ+VzZDJJzWwvcrWu1cS14DfVEdW?=
 =?iso-8859-1?Q?qg2546rvbzTez5k3gR9NaPiUeuCXsOME0/3YMChOwY8ws3d/MDNTqVlGa8?=
 =?iso-8859-1?Q?+St0USqLkvplTiAJ/6Poc0hXDH2GFueHuOcGXdwnD+WSA+LQ1AXPsvBZX0?=
 =?iso-8859-1?Q?V+6yhRzW4fA01nL3RmMD7ehzlj1el8GG56tzvEBEfAKWkHdNl9hL0yoFkY?=
 =?iso-8859-1?Q?+6QUAAUeKBm0u+y1l/ry3Zr0ftSwZNSG5X+hGsz/2ZmCVB5RU4Fd3DQ4yH?=
 =?iso-8859-1?Q?pKHNFN2meMh4fA/HDR7XDs68bu5BDrnIFj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b14a14dc-f85b-42ff-e35d-08dbf2c10573
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 22:58:23.8337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9e8VN3e6KkImpcnjHr+TCGzfpBaGsBHzwWuM11da3IPxOq4CgDixVTIarwPuO2H5MxF2aI8r4lnnOmzld85n8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7337
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 09:47:30AM -0800, Zhang, Rui wrote:
> On Thu, 2023-11-30 at 18:08 -0800, Ashok Raj wrote:
> > On Mon, Nov 27, 2023 at 09:16:51PM +0800, Zhang Rui wrote:
> > >  
> > > +static struct temp_data *get_tdata(struct platform_data *pdata,
> > > int cpu)
> > > +{
> > > +       struct temp_data *tdata;
> > > +
> > > +       mutex_lock(&pdata->core_data_lock);
> > > +       list_for_each_entry(tdata, &pdata->core_data_list, node) {
> > > +               if (cpu >= 0 && !tdata->is_pkg_data && tdata-
> > > >cpu_core_id == topology_core_id(cpu))
> > > +                       goto found;
> > > +               if (cpu < 0 && tdata->is_pkg_data)
> > > +                       goto found;
> > > +       }
> > > +       tdata = NULL;
> > 
> > What used to be an array, is now a list? Is it possible to get the
> > number
> > of cores_per_package during initialization and allocate the per-core?
> > You
> > can still get them indexing from core_id and you can possibly lose
> > the
> > mutex and search?
> > 
> > I don't know this code well enough... Just a thought.
> 
> yeah, sadly cores_per_package is not available for now as I mentioned
> in the other email.

Couldn't we reuse the logic from Thomas's topology work that gives this
upfront based on 0x1f?

> 
> > 
> > > +found:
> > > +       mutex_unlock(&pdata->core_data_lock);
> > > +       return tdata;
> > > +}
> > > +
> > >  static int create_core_data(struct platform_device *pdev, unsigned
> > > int cpu,
> > >                             int pkg_flag)
> > >  {
> > > @@ -498,37 +511,29 @@ static int create_core_data(struct
> > > platform_device *pdev, unsigned int cpu,
> > >         struct platform_data *pdata = platform_get_drvdata(pdev);
> > >         struct cpuinfo_x86 *c = &cpu_data(cpu);
> > >         u32 eax, edx;
> > > -       int err, index, attr_no;
> > > +       int err, attr_no;
> > >  
> > >         if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
> > >                 return 0;
> > >  
> > > +       tdata = get_tdata(pdata, pkg_flag ? -1 : cpu);
> > > +       if (tdata)
> > > +               return -EEXIST;
> > > +
> > > +       tdata = init_temp_data(cpu, pkg_flag);
> > 
> > Is temp_data per_cpu or per_core?
> 
> it is per_core.
> 
> >  Wasn't sure if temp_data needs a CPU
> > number there along with cpu_core_id
> 
> CPU number is needed to access the core temperature MSRs.

What if that cpu is currently offline? maybe you can simply search
for_each_online_cpu() and match core_id from cpuinfo_x86?

