Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113828077A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378879AbjLFShC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378839AbjLFSg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:36:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC01518D;
        Wed,  6 Dec 2023 10:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701887823; x=1733423823;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7I5hn+IGpqiyMvTZA3o67J1Yhs0MG6GqM9guYrPdjtc=;
  b=L16xZngrn3FXXa5V3i3vmryG+tD19yFJT8eDv1BC5zCuE6PVuJw/MWJp
   eV3SHhm5jRdTG3OU5tWoz3RHhcJ4FY05MrOsIu1HaP5HeyWkyt7uvPX9l
   40MI1py8w6EsEfquGLeZAt/51MUFx6cEL7E1HeLprLxLn40gEcbFiw1X7
   fKMW1yerTTG8b/4oiMAU2cpOqQ1ZrhmcdECp9iKs3mOW01blXcPtqBJhE
   apdH4jd2/L/qahEyUgoKk43gVLVduHrG54mw/FkioSrdd5sPJzGTEhxN/
   qi7E+aZ0BxERc1LnMBaeL4hP08g0bbR0IZQS3x4Yo4St2LE4MhUVP/cOi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="391276014"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="391276014"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 10:36:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="19409206"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 10:36:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 10:36:57 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 10:36:57 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 10:36:57 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 10:36:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCHyTboj4IiyrlwbQEeLEuHys6sw4wV+znaz5vEdQgscZX1aJujm2Fn9DUB5eK/Skrn/IXCaK+3MFGvS0hX0oKxcp6S1VWWk2RxR+V1SHNV6T/ESKdqaOSs/4VjOsBXTtWGrfiD/e1gGY8ndyCalWUd45vfmTGRvH0Nss1y0LL6qCoO2bgrD25jD9a2HxWPhHCtW4WB2ccbn3MHklV7dD/bC6HYfS+8Py1rTwZ9obuCa/BA4Q2QoxcAKg3rhHn6QX3M7SbBoiVZ8f5K6A4qw41kN/zzgK3T6GsR1DjAYvC7AElBoXrRMFomIWgLXa64OGydrs+wBM7vk3Bk4YiEiJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7I5hn+IGpqiyMvTZA3o67J1Yhs0MG6GqM9guYrPdjtc=;
 b=S7DNUw6HY8FxXDs4YIesJSJOrt6qxbMz7dcypEJ0JO3nIU+bO8SPcIQDxqsbd/MeNiid+qkK3qkh3flpEfWI5xz6RIFPTK0TD5kl+vbPlPeGjo/s+odGd0yVVZ+jQ0ULfUa4v9cmymNA4Kv0b51vBTzru3kdY/iUl6sd5CQNOUhFAQzZtVwzdG49d6TyYNyr3ca92p6gUaVNGMB6pwsBBKdXvyTUtD8cogpgCjho8hVxbCpDRfBSl6LlwOJE+whXZxgOMv4yPAHiWB+9+l2xDrYfikKocmJJitQVZuF51itgLNEFhdR7VEcbShNYu6Nyw3j5WiYbfAQvWiwL3lISfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SJ1PR11MB6108.namprd11.prod.outlook.com (2603:10b6:a03:489::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 18:36:54 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::b870:a8ae:c4f1:c39b]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::b870:a8ae:c4f1:c39b%4]) with mapi id 15.20.7046.033; Wed, 6 Dec 2023
 18:36:54 +0000
Date:   Wed, 6 Dec 2023 12:36:52 -0600
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Michal Suchanek <msuchanek@suse.de>
CC:     <linux-modules@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
        "Lucas De Marchi" <lucas.de.marchi@gmail.com>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] kmod /usr support
Message-ID: <xbgto5tttcah4mrtyjih72ubod3qb375ww6e2fd4pi342rg4eg@wipwd57q43cc>
References: <e3yow7ih6af2hxzkmjay2oan3jypmo4hda64vxvpfco66ajcew@i3zewn4nbklf>
 <cover.1699618135.git.msuchanek@suse.de>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1699618135.git.msuchanek@suse.de>
X-ClientProxiedBy: BY3PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:254::16) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SJ1PR11MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d1eaf0-c416-4500-6534-08dbf68a520e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cWmb3tepe/2H9oGYuKkSnBJMonDrbvyYVdl5BSUNToTFYEafEcMle2AD9xwt0myD8Yvrbnlw6c7WHPkSGsG9kzJmTyP+Vss5dUFJ5KNWf/+EYjE0cq4tzg6AwlYhSXGQnOO7rJ99qWqF/KDukqf3JCQpdc3eMdSdKDLQX7c0nFEJSP4GA0LzVgaKUU+X4Ri44O9X7jXW1Q8jEAn+D076FShwNCUZtBzsdZ/O5tvuduZbr6XuXdbz+zhUfmsuB4ZZ7TJsotXPXLQx7Uh8sXPGCl65XM2mmNz8bdKpwD1CV7EabP9caVxphIlmPtD5IVrczKuiA4Vd0nvoDM+h6LuYPa2AMMTuvaPtQFA3Yto/s8GvW10f3GBirP5I3CpEpEZ2wEq/E3ftHyNTcgIeQ/w5XSWwcSuAGt/44DozbBdYMidcDuBDzVKyztvfSk72GMEg/5QZfsiZWDdNpZ8sUtUSSepgfSDbltZF+WoC4T32Bgjyi10HvzUwGernkx72A2f8VzmpuKhJe5k9Eefgz2YFFAJC8KRm8hD/hnQdKlKuIc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(39860400002)(366004)(136003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(6512007)(9686003)(86362001)(26005)(6486002)(54906003)(316002)(66946007)(66556008)(6916009)(66476007)(33716001)(8676002)(4326008)(8936002)(6506007)(38100700002)(478600001)(82960400001)(7416002)(4744005)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n0ex911SSJ3ysws3yunUeusLO0OuTtGJjOsbkvoS59XMDJ5OMNwvroK7LWK2?=
 =?us-ascii?Q?IftineKi+u/rrYMzTcRB5bLyi0nTVG3JMWfgHWW7tjFH6LU7jp64aRi0nqF+?=
 =?us-ascii?Q?Lc/10mOyGGUSOoNioGN7wYwpjuLRAg9OnsYZJLsgwR7oJ4myCuT8mqxCO4/E?=
 =?us-ascii?Q?JorTArbdAkpSfjCumykZCqwlrWGN1/MM6q2855G8HND0mPgJjiQU1HWTcUYc?=
 =?us-ascii?Q?Fp4vMSJB0zpmPv0ztflJKB83Cspn2Ka+PGMuBF7xDvAcAWYaCtrLVbDzj2As?=
 =?us-ascii?Q?G4CMQQsWk3yuoqifYdZ6hzBmZgtVYlXhH87aSzSGKVWx15xgf1vTNkkHkY7J?=
 =?us-ascii?Q?rO2bJmp7+rB1AyiAij4TBIRnV+ZFL0zA/EbnmhLzXfVkJ0NQJxceWXS8PAs6?=
 =?us-ascii?Q?62Wf8yOmR/RjVWhVkbRERxsGawuMUfJgkDrdzMgjmXJ2iX9XSOjNEBcSK5Y8?=
 =?us-ascii?Q?7YJsFlsDrXj/4qf9jbeeLOvcSZ3QKL4v6joDjhcIV5RKN5QK6Fn8kLm+8PpY?=
 =?us-ascii?Q?ut/3Yxc22KYEbVtLs36XaGHzJdbsTOiF+a+XlQ/n6IhVI9iErvIaEQay0lh1?=
 =?us-ascii?Q?qnGIfq0hvPy8EMeEnAFl0GO30zesRQ7GtHlYg9VyHjeMmyb4b//m8O8W12fO?=
 =?us-ascii?Q?db3wgYYq/3TEwjg8c2MQDlMSrbu75Z0Ublxs3VxtL1xYNto5nPTolLmunQYG?=
 =?us-ascii?Q?9HbSRnY7+BFFdcm0+5+Fig6u3+sr1suSprcGJVwkLP6aoQqggardT/5lJer0?=
 =?us-ascii?Q?DorIyPst+paKVgjlXBBnXTgnqNLFrnuJ/vkCGdmnEOwPaASs7C2ZIuAv52fV?=
 =?us-ascii?Q?Kkmu+RjasTcxjdR1fchePmjxdQITEOH7sfrhUJJMyuZbIJHUjVszDGpVFjo1?=
 =?us-ascii?Q?9uZ21vqG7U5vwKkmBLG3n86+8dTRcFoSw0kV8cJR/Qlqg+vcsDIB2NxukkmM?=
 =?us-ascii?Q?sEKOAyxT5ttxq16wWAHeArgcoXXh/kGBl4TNovcaPVMAllI/cOmKeGDihQxI?=
 =?us-ascii?Q?lAMAqBgzePvV4+iPh8gj81kJfPC2kMlykZ8xUO/eSRLnmiWSqI7B9xadhTVD?=
 =?us-ascii?Q?I42q07vOBI9FXiG1gOoKD4bYbrg6q2s7JEH/anFaoWBPeh0r3f7sPvqhmkp+?=
 =?us-ascii?Q?taSHc00/zliOIRWIUj8XyPMH1VNhaWwONpyciABGrwaw6uc1pVppkJrEBCXe?=
 =?us-ascii?Q?P9zuMmb7R+WydLAy2Bt9YMWnYMUnNDB99G0fo1n86CeiszElSkqTmOZzMVSf?=
 =?us-ascii?Q?zsgXiYvu9WgRL0s5wLYa+5B5JKkgjSaqOeXbFkUsk06XGpcYNPPSIycuXROc?=
 =?us-ascii?Q?/1YSyn6hDrILiNH8enQqY4KwIVPJJiB57wk90tFa3Scu4NJFnpg14+yKUff2?=
 =?us-ascii?Q?YLa7SamCBQ8uP65oR0MRo8LpV6hW7EWm0Q+E32RzlcL0+2+YxR7mbDUz+dWg?=
 =?us-ascii?Q?zEjIFaTmCZfYL46xMAPM38yYyu8rD/GVVNfYZ0WCv2skLT5oOBGDF4eaovid?=
 =?us-ascii?Q?dzLTBYwX4DN59oulc5gEmB4r6YNGBngPrMGOo3wZVrtWxA7Oz1uQbETYPJ5v?=
 =?us-ascii?Q?5U1rKo8sOTYdOM4kb+ih/VFt7wlk13ctL/vGLlnVUpblcL/nuwZp6ScbNKAQ?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d1eaf0-c416-4500-6534-08dbf68a520e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 18:36:54.7560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igwZDBjCi9gGewtCV9SaD8qMdM5Xhukfb3uZwdy87pls0r9RXdDA/NCvVwZbE+p11IpSS+8JN29hY5lMDEoGf6oTL1YYD3bNYkfBK27kzVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6108
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

On Fri, Nov 10, 2023 at 01:13:53PM +0100, Michal Suchanek wrote:
>Hello,
>
>This is resend of the last patch in the series that adds prefix support
>to kernel module location together with additional patch for validating
>the user supplied input to options that are interpreted as directories.
>
>Thanks

applied, thanks

Lucas De Marchi
