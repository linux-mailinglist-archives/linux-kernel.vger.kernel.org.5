Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F304E7CC897
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbjJQQSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjJQQSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:18:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D7C95;
        Tue, 17 Oct 2023 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697559512; x=1729095512;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=cuIb7ecARszV1UuyoQSGA/FBSgbb8gu6PNdGZ+SmnRA=;
  b=d2TkKlzC9UJ1+ug6faocyCyABAx0lyNDH4hFinCD6mhE8NDQQ2wKZbMi
   foFd5J3PdDxBZvRvGOiM2xAeYhG2K/VPvek4aqeExEJM7Y4yMzKgk4fwx
   RTuWqF86sJM2/LRf735OHe+SzArD2/tCtSeGvRXe7K1eUFjvGweD32+nD
   HMqndvAS8/I5Sv+/1RjRIl4GpSlyLZvu6zcFjVRNCZzusyuoZfPFdJ7V/
   AojK1sP15SZCgBbKEzoUh2duAPK61BVXMYdy8rvnJNbpcJyBdfTT4GNU9
   gtSLo/9NpqvBzLTvvjz7nY/DMMwfA4X2aI/mJtRyBIF6oKaC304NtSf82
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="452292981"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="452292981"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 09:18:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="1087553831"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="1087553831"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 09:18:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 09:18:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 09:18:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 09:18:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 09:18:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEPHsAFFgtRz8VD+BNFI+N1aVQDPCIiIyXAbhb74PTAxTC5ux0RdTfYcQTdaX/qnqiWd2Ic4/3REwqL2m8wuFpSqpK0lMpWq77qHz1N4GGwKAIctJyQ8ElNmKb7k231imP8qltEhp5HMR7YLPSltCX0lR+KiuL4UYfxDmmhc+JKWFLjAoLPtcIgeoR8R2NBHnP6rqTlsBlNk+BX7IlthlTkj4XFbux1jx7uqZtpu9NULZCjrWal6XG4jT5KyKAARrZQC1pn1KIlOiiRgDJPc6fI1c7oGr+bogtNFgyL/d/FEBLq6cvO+2fSMCES6V5v5bIvF1aTdY8PpBL/N/CYSFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMdgV16xvhNlnZUNnLVynAEZD6UOvLrE5kGxdJFWwJw=;
 b=XgTXIxkYbvPbPNkzjR8IsypNP1+DMdTZWbC7G6wVvUWppZE4WKWi5ty1hyQdckWqp+4p0WEHYvlL5QcFdngp22Hu/39GXSo6CCcFT6aS4D4CyLa8f7XT6/MXHzNWlb2gMYYFlL1UD978/5wsayIntkSjlrifnoLgF6cNLsPoAE0Cv6Bu/jVF3kdSqyodz5g8KMV7W93v5XRqxdgIZFtZwgPZi5vCWAHztZBgwUmAXDvKAK01RS5bu6kpuVQ3Q5KRO//TKbBclqLeTHAI3Ei/F6iYSZobLqQXEWTCGKEtqXWdthiu9SzEWd5iiOgs8fx45SD0FCPkLDOtbPIP0X6w3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CH0PR11MB5707.namprd11.prod.outlook.com (2603:10b6:610:110::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 16:18:22 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::c228:5055:b7da:d0bf]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::c228:5055:b7da:d0bf%6]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 16:18:22 +0000
Date:   Tue, 17 Oct 2023 11:18:23 -0500
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
CC:     <linux-modules@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
        "Lucas De Marchi" <lucas.de.marchi@gmail.com>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH kmod v5 0/5] kmod /usr support
Message-ID: <iplnlgb5mxrltogppm2buz63unviqrziwf7liob6mht6yl776l@3j2dzm7nbs3i>
References: <cover.1689589902.git.msuchanek@suse.de>
 <cover.1689681454.git.msuchanek@suse.de>
 <20231017154539.GK6241@kitsune.suse.cz>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017154539.GK6241@kitsune.suse.cz>
X-ClientProxiedBy: SJ0PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:a03:331::9) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CH0PR11MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b6009a-f79f-41cc-9ae7-08dbcf2cae7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SiEBvpyUv6p/ZPbCa+uEXxSQ1P5qNbaRhMGjIKrmEq84yNoDhQPrD1u3sD/VAYEBtXz3vR5rHnlGzB97Po836QrIKQidynOPkLMq1xysPYSHvBREs7ntYstmDEMpRyBbwLi1Xirlt6Ovx0aCaJO2uNtBJGr4tmf51gb7llrKCcGvKmf33gl7UWLBbpQjbL/j8mc1r2zYUgxxkXZpZuEnMv8ErsXtY+1FQ8dzHnXUrri1StT1GYT7l44qL97zkWddxv04vwu6im2URgPH5oV2++VTAzSuRCHoFE8tRfHhLh31lgy1OBDfnRHBsxbcbQ/SYVonUIdcwRJxOVWzm3J5xzEIUjSwj0YdZFiH28ylWDnU0cNGqFlsxQwXQB6erKFy2cV2ssT8tEaoT6lc4tjnl3QR7j5qqnjMs49i1FicT88GeKdDqhqAuDAbnOl7KYxvaUMEcOvnUcD4n7H6dWpcG4kkn2UkoayRjqZjGdiyEUoAZqmIpHzudOCJ87B+WelkzZ+NjgXQ1patNzeuya0ou6u3x67NRxzHLIwqyAx/xk9eDn1LAVAaOvgeySv6jnkq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(6506007)(8936002)(7416002)(4326008)(41300700001)(5660300002)(2906002)(4744005)(33716001)(8676002)(6486002)(478600001)(316002)(66946007)(66556008)(66476007)(6916009)(54906003)(82960400001)(38100700002)(86362001)(9686003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zFx4Nn9Ro0/J3iNIBofIh5VK0/ANegZ9jlj+t1IBZ/GTMvEuodyTSi/U8G?=
 =?iso-8859-1?Q?L3Nhkr5empUTxzarGxu7TtZfInB38bMyoZkBLKIXk0XxHnaQvY0pt9X+Kz?=
 =?iso-8859-1?Q?iYR/ibN8KkjBdKoda/zBp05w/7WL1YBqRLDe7MzJ5eHbXKwhfucWGMcxrf?=
 =?iso-8859-1?Q?iE9EnoQ3Krpsm9cuFELd9VwMXKut4xtTlXXsH09rOqZ7b4Io8NPuN+4NrQ?=
 =?iso-8859-1?Q?JBOqAu3I0GdiRRmPf9tOItGH3+gvZ4fa2uux6wPjHvy7tpEduznkIur9Jc?=
 =?iso-8859-1?Q?HixlWt2DphuoyuDiThnNr36pGlgOFHnQi9Av91/D+570B+I1tgnph8P0oT?=
 =?iso-8859-1?Q?6BBeXFs4crsWhMjoSv3l0hWFbi48LsTR3uqkh998LfK2MOFrgOe99991Gw?=
 =?iso-8859-1?Q?1asXx39AuTIzXYknGdIphqKEl++MQtNGRHVKyVEgOeaNdRoRnA5u/t1RmE?=
 =?iso-8859-1?Q?sxe0P71jdVScUpKYvmiP6kov94NooZo5vE72cs0XL9wP3VknCNfwTW52Dz?=
 =?iso-8859-1?Q?RXyv1NaLY98T7SS4EyL/kVyVzmx0/BPm3NOlbpbW4Zr+vEIfnwduBNIzwz?=
 =?iso-8859-1?Q?PDfv/CtOHPAoUw0vBx62Boao8BJpxKdqvECCrytAxvkKCZM6f+EAgfQOhq?=
 =?iso-8859-1?Q?MX52whrxXb1vFZBNI7PPNT39PfhhFRWoFInT4ZI16JT6bVSlQ5fR3dAtMq?=
 =?iso-8859-1?Q?7hmxQy+e8XpYkj/bYE48ovCwLyPxDRo2Y5RrBfEdXjea2wHETshIClYdIR?=
 =?iso-8859-1?Q?Z0eAnwE0QVJPepb5L2KrLhDjvGaTVroIZALgkKa6YVL9IDvc/d1O6PTNrc?=
 =?iso-8859-1?Q?o8zoNcFBAOJKqX6koVKTH01DOvaguWfY/2wRCFi7DpzCFXndj8hQQwyT+p?=
 =?iso-8859-1?Q?ca+J5LPBlhaa2GAMSBD8goDkij7zaSae2tc0sRPrMV5Uyhts/vOg8SoZsT?=
 =?iso-8859-1?Q?epJhxGvtdCv2SJxgUXpr8AqmUfrF/PxDul++2JFKbwkHiVSXORco9bBWjN?=
 =?iso-8859-1?Q?H5X1ToejHtcOrbrEd/kGfTxT4KoLMhj3IwKbLvMp3naolxr9iRN1hSTaVV?=
 =?iso-8859-1?Q?0Txun0wuuLGL0dqwrbo5plU1V74Jn6U5lnoonJORbEY7xfsI6CYZHYoBTK?=
 =?iso-8859-1?Q?sKmjzorAA/kySw3EhDZ7FlH4Gj6b4NuLKf223Lv0P1gxZNDOeYsY1Z9rGg?=
 =?iso-8859-1?Q?ln34mroHIxp7BnW8QdxaWs285q+hUp1YqYnAfhC1fBAd13faoXj0gmFct3?=
 =?iso-8859-1?Q?7RJ1XKv5rpIx/33Jm5Vs3crzQ+QZ0NsFB+0RwLLhGBZE8JwvGJVFpqpiQh?=
 =?iso-8859-1?Q?QMB0UMzPsrVqO//jySlq59NsXKBrXKDhe9tkyVdjWCz2JoAiQLVUZyxHxC?=
 =?iso-8859-1?Q?ihxM9RiVo/pIyxcEtBDxS02t6E9rVdz9lJyDwugpYR/CA7R8+42yXb1F0V?=
 =?iso-8859-1?Q?edJ7tD0uywF82mFis3aZp3htryXpKCcsaBMq7LyBeSP0pfRqu1wb16oVvh?=
 =?iso-8859-1?Q?oPGm1ov/kJrqFVwasMuve6y3SBoQ+slYs4XdC7Df31vR6yGPtHbBtnInIA?=
 =?iso-8859-1?Q?KUU6qCO4Otzmhzdf8swF/1SMJFq3FJn1rEvRItUKUCSjhL0JlpKejTicUI?=
 =?iso-8859-1?Q?wItm1dkDrPg/eVBvdZeIPhAn+zS1SStyPiG7zFzIy4OPxIntT5oHR8VQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b6009a-f79f-41cc-9ae7-08dbcf2cae7b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 16:18:22.0098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBjJl/gVp8BqOGjdGld0Ibo+UUGS31R8zgMj/MUM1oFmzBGORtRKn5fPpgAqvp9vfuTLZ2m+89GvM7ZXE9EqyZM9ByWUiwJTTH7A/9se2YU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5707
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 05:45:39PM +0200, Michal Suchánek wrote:
>Hello,
>
>it has been a few months since these kmod patches have been posted, and
>a new kmod versio has been released since.
>
>Is there any interest in adding this to kmod?

yes, but I think the main drag is deciding with the kernel build system
maintainers what they are willing to accept as an interface. There isn't
much point in exporting a json config if from the kernel side they would
rather use something else. Or to use pkg-config.

I confess I lost track of that discussion. Did that settle with
pkg-config being the preferred solution?

Lucas De Marchi
