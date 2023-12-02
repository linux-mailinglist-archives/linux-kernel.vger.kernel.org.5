Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09C9801FC4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 00:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjLBXfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 18:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBXff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 18:35:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D92DF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 15:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701560140; x=1733096140;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F6d1TCmvzeBubR3ZqRNtdq7K8dTMpT9WGkDP3SZQ3z8=;
  b=esvqcxSmeprWBAM5rcrAtbv/WinjMZpu1qheNSuWcDaR49k9nESk9cGo
   fkEuCdtu+mi0pGi+NvN5mTReQvunfZiXpzdVuCHB/9Q+H6DwMebxWheGH
   iZrH+D7rklRUYKC236cvlqflxioo3w++0q5mWOl5MHplXHxr+544dsu+W
   sBAen0vTi5EWIPSxlSPhi+RDdCDp4tfROoTnY0Wyi5c8k4uySAcjRQZ8Y
   uMIFTy5nY7qryXYmnArExKwibLaJ+PyAWnIIX6ewEs+BLJ37vm8JwaTy6
   LMnkkEInLksBTgLSg/s+7UHUZNE+FBCxxlgRKrLL41Boj895Q0eInLJJn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="6928541"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="6928541"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 15:35:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="804468843"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="804468843"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2023 15:35:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 2 Dec 2023 15:35:39 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sat, 2 Dec 2023 15:35:39 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sat, 2 Dec 2023 15:35:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ea7fM/SYTX2XrVR83jBqGJ41Xzj1sQ+oRlLhSlsGcs4K8clHtu9h5T06xa+mFcqpNBBKpHKGg9rCLCU/l+/9JVlA7u+GjJ9+8Ks36pUU7KojnMyELuTLs4zw1BJ12obo4US/puIRS1usumTo62K+OLlfZs08Ox84PgtGjuYo5/id2FsDLYRCpMMw3n6f/Xt0cgJnjFMfoC61Oc01bAhpMHdDluMqG3cbdcgfL+Qfeen/nFD6vh/++Yl6d5kPjzvkpiezgSlYJARlXde+B7oIq96SeAX+V/oCb1WT5uA/G3KkdK6MFuXTLpc+U6tS0SapFb6MXbN/9VtzfDCeJ6uivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Cj8TWzWrT1dIXS2Smcwx64Ttx2UsOCbGx2G/L7wuxY=;
 b=Aty6RKX4IeXq6QEAIgmBwS7Gp0WvjGuOzkvuiKxycMpIl/xDyzMJ00UAA3VVFTYawwx/qBKQasaAPd4TqHKr/bKRhlEu9He86WIBsTDbb77oDLNxHqk+fjsfmGgDRKSLBtc1Imd+Q6bAZ1REtu1/NdhPb0qiqZ4qlwQ4oLH1h2eB2W3Od+FFyh6VI34YIRM3wzeOWJ12uiPLdgPMn5SAQSrIUXA/B+SYI5ULwL67t05YTp3dpYV89DkcKruz/CvK2WI+cwX62ioPm9nu4GisdQS4hmNM1sLrxwHya2RjycmHffQ9aB6hFojaQWpCqeszR6nGxhFBpiSYpQ81V4YMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SJ2PR11MB8348.namprd11.prod.outlook.com (2603:10b6:a03:53a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.29; Sat, 2 Dec
 2023 23:35:37 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6299:dc9f:239:202e%5]) with mapi id 15.20.7046.028; Sat, 2 Dec 2023
 23:35:37 +0000
Date:   Sat, 2 Dec 2023 15:35:23 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 2/2] x86/microcode: Rework early revisions reporting
Message-ID: <ZWu/O9XeMBfbs3H7@a4bf019067fa.jf.intel.com>
References: <20231115210212.9981-1-bp@alien8.de>
 <20231115210212.9981-3-bp@alien8.de>
 <ZWjVt5dNRjbcvlzR@a4bf019067fa.jf.intel.com>
 <20231201163928.GCZWoMQNAAQSA9U12D@fat_crate.local>
 <ZWpDHgNjhQKLodF6@a4bf019067fa.jf.intel.com>
 <20231201204146.GGZWpFCqodLUPS27tJ@fat_crate.local>
 <ZWpQ9Wbb7u4ss0mt@a4bf019067fa.jf.intel.com>
 <20231202163850.GCZWtdmrMoJqyAiycZ@fat_crate.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231202163850.GCZWtdmrMoJqyAiycZ@fat_crate.local>
X-ClientProxiedBy: SJ0PR13CA0116.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::31) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SJ2PR11MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b38a7d-9f99-4caa-fcc9-08dbf38f62ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: klqexslUcqL6s3Y+L5nQUbGkhff8q8fL2XWed5fSbLG7vDqPsGPNQdPNHkp3otWS02WEGba+FZvKssODmPXOea5hcFS6gUwOmAvtWU+foMFDJ/004/5VYdhtbK3sl8nxpGd7s7npnT/QnvYDLxDSXLYqoPGnBPSGLGo1ddd5YRyLXT/GgcIIkWPR1U+po0FtedRwGj21/Aj+JrXDjXmeTkP9G4LnkJ8fNlhNB6t0QGffyKZysQIq0ZE1iC4ytx9J8wExs3MA71LWB3bnW+vNdnLRAu7D/CDrFFvjZj3j6UQ1pEAD/EvOsCIVVylTl4RFnv0aOHG7UWJG0e8ad+Sle0GYSzpVJVfWjvK6WIiw+9mN3VFQMFF2c3vJQ1JuPAYdo/i9F5mp8+dmc9DLqPAi2jToJKyDhkl0F/TTgYVu1KjbGvlChEdqo83hjDXhdM6DQUNzvgufYjqFPjdzPS9l6nsGWhzqjme3XHLEgI+EsLF564TJmdWV1Hle6FDrIsvCIIdWn+dF+121z2FxlQM9HdaNGR1hg1zU9MJIZ8GId2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6666004)(6506007)(6512007)(107886003)(53546011)(316002)(66556008)(66946007)(66476007)(6916009)(54906003)(83380400001)(26005)(8676002)(4326008)(38100700002)(6486002)(478600001)(82960400001)(966005)(8936002)(4744005)(2906002)(41300700001)(5660300002)(44832011)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?elbwp0uS89L/Fi3otk9M9u+j0EimcTDPWMdwarLTEVhT9rREDZzgvFcN6JYT?=
 =?us-ascii?Q?+XNL0Fx5prLP+v3eRgQ50pDnex6s5mdwsN7nUXKa4oHS6qys6D1zzGTBQSgf?=
 =?us-ascii?Q?lura0AmY716AxM5WSXx02UBZ3fmfCjKW8WGwT4p3UKrXgrgY+vO2TqCq9HLU?=
 =?us-ascii?Q?CNC0MJWIPKYzoy1runa/KPqjoeXcMeKJ0S/ud/XYHSl/23yG5Awvl4kH+wKP?=
 =?us-ascii?Q?HPFjWQ3iKvjd0xF9Nf/XdE9zfgT0+0aj3lCPHIkdwIUbZSVuhu8goPs078hn?=
 =?us-ascii?Q?krYE9WzdIEX/xdXGV4lk4NzH4jFrrccB8XOQwMan1eQHQEp0xe04V0d2MV4i?=
 =?us-ascii?Q?voeLCsccpPRJjt1z95Aj6BzW1MHKYmZHXcLQf6TIAEvKYSdMm32UcuV1CASv?=
 =?us-ascii?Q?Hq2RodxI2NjtOJ6mkfULDP7CF8YsRMMch5xAkJYBvhfN/z9Zk8JRGnhHGg3d?=
 =?us-ascii?Q?UhULr6S9HN/58tlHIYOtKU7P40KrVeEt3npTwjad+1MyJefiPpdMSKrw6dGX?=
 =?us-ascii?Q?QsOu06qP8cACTz+FFTPt6KkBW9LCfQJ/O7ThjAotp3dF9wEuEhpcjqNEoaqh?=
 =?us-ascii?Q?TFgnjrFExkaLB49aTvtmTfxm41Y5ukixwJ9cUK6kPBtOwCtGpIutxDNw6AlD?=
 =?us-ascii?Q?1cNFfkyrxeKM866qn8lfeDrbzbrRoEdQ1B6JfdnqO137dguSUCXEckevTa7t?=
 =?us-ascii?Q?ugOEo+wiFzkVrlcWzuzZev1JTb5qVZh5X8ROi2A1bGfzEoHwUY1ttT7nL5vx?=
 =?us-ascii?Q?1Cf+jlQV+D8qsbNPqWNXJxzWLgEb3lPvTV2407fWTEKqJKPRh1/8Gm1Xw1E2?=
 =?us-ascii?Q?E56VWaHbxvWNOBNioHMbu1MomlmTpGxDZwk3ZSryumD9nIwyx+53sMU5L7d/?=
 =?us-ascii?Q?yl5dh4iVBm4gt1URW8sObECAiMo+GkyCeoiXt5u3rlMeqfgjGt9VKEBDEDeR?=
 =?us-ascii?Q?Rjk2TAqT5tYabi4ol+qqzBzi+Br8kWJIEl97QkAkoQ19yI4x9SiiFVepyDnd?=
 =?us-ascii?Q?MdfCzb2lc3AQkc8laPomWM50/b58eDc91mnQ7vxRuWzj4vdtFJj41EMsnxgS?=
 =?us-ascii?Q?3r4hjnxFOf1A8QSSAa7gQLre9a6VHZAEdx48UJym/q4k7v4ZxU33pd+XHHWL?=
 =?us-ascii?Q?v1s0Snv0mZeT6FYNoxQxyVKAxs+Fo/ItzKvgyXnSQqUh5CcJs5xafdgwgWcF?=
 =?us-ascii?Q?sSUX9rVpn/zdRp7vyfMIgorZx0cZtAxiZ+DbAKlySuTyxIbDFl1AYFl91g1W?=
 =?us-ascii?Q?kfjMMhKiMlUE9e8RbhLLzrBohPWuHbzgqLjV2//Ln25Nq061okg78YNQujJn?=
 =?us-ascii?Q?HC3Y8dFsiLzprv1DA2yxgTaQpoCKrdSQEIc8udfIktzrcpK5PPNiFGdILLO9?=
 =?us-ascii?Q?G2I3PcBrt+ca32kEglvj9C9OzMokhs0z2MJqk3dp5zWUvTKsj1D/gr+cDotH?=
 =?us-ascii?Q?3cI7SuIFoo9KJbpba/SiGPnGC8gNjoXlB1zIa8RNw0aaNWxVwHqOOyElbWf9?=
 =?us-ascii?Q?tFS3VYzzQO+MQnNgBmkzhf4pQIySGNA/cfvaX/iUhxy2Z0IJibIr/zL1zxn5?=
 =?us-ascii?Q?Or1hZucFf7gHXw4JdK4qjmysPiBKEWlEUVhXjozw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b38a7d-9f99-4caa-fcc9-08dbf38f62ed
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2023 23:35:37.1911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1I4Mm3hQH3064WRzRW4boeFIL5kdcZYN8pjEynXnwYIuaEalMehLnxETwW+u4N+p25KX5/R21Lh+g7Zv+eZZvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8348
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

On Sat, Dec 02, 2023 at 05:38:50PM +0100, Borislav Petkov wrote:
> On Fri, Dec 01, 2023 at 01:32:37PM -0800, Ashok Raj wrote:
> > dmesg for the microcode part here below:
> > 
> > https://paste.debian.net/hidden/e911dffc/
> 
> Thanks, it is all clear now.
> 
> This should fix it:

Yes, this works as expected.

> 
> ---
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Fri, 1 Dec 2023 14:35:06 +0100
> Subject: [PATCH] x86/microcode/intel: Set new revision only after a successful update
> 
> This was meant to be done only when early microcode got updated
> successfully. Move it into the if-branch.
> 
> Also, make sure the current revision is read unconditionally and only
> once.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

Tested-by: Ashok Raj <ashok.raj@intel.com>
