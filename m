Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476AB7E3F78
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbjKGNDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjKGNDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:03:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A040DC967
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 04:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699361255; x=1730897255;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=nFcWmPK8wnzv2h+ftv/9UXjqxgTjpMvtxEcNbcInNRc=;
  b=Wlh2/U74RpRSMDhMbkj+Ku1wHbOx4kG8JbksIUKdeGPw1E56b8vaxK9N
   qV5tbUTsUKKSzsAUAvKn/Vq5mfXmb2QOxBoCcK5gxaFW32BhMcxTB0ueC
   doTsbmLTBFj5lmNzXAnZUrrQ0b5rEk2GF9H94SIX9TOf/gawEsyebmbfX
   fKc6CnDFVFUQ41FnQ8rk7fdk7qm/OJgh4qCtpLfYTfwmVKTXxqXl6Z7oz
   oIJ7vU/AjbIfov2BopqCeKbjOfNvsBc5Cm+jR+6sY4OQuV3aj5Up9lt8g
   +wH9o12hpT18mTC5E/PPGmlC0rVNh9QV6UdNEydH2QLfOu11Dn2jU+Naw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="368836267"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="368836267"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 04:45:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="762692016"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="762692016"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2023 04:45:35 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 04:45:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 04:45:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 04:45:34 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 04:45:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXNOhX0ZDiTjGPjRJDkHCFZBu5vUAeVkozV51ocdvq98M6gvhu26D68NZ7baK54GE7Lxz4Riz9frhLd0tgbhnbbQOXePWh/c0Ki2Y9g6JtiyWlI+lC/y+DED9IV0SYW/+ocbIudfjwyZpEruvtTSUAGYNFHnTnWfUGBVJhkNrrVDAScvi08Zq59v4SM4sfbUrRNxVqeHOyppkbDr8qsoEbPb+bmAVjcHeWeBX/sKZGGRrYm6TqhEj4FqE14qV9iXd+FbheGZuCHghrJuXtH954Thy7QE2V/8ajM1tjm/+VSjJ92inUfRAXmzQxNz+sG3WdFgoaOfrc5HXYUCKBzifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKbFt0niYgXjOwZNFGx+7sIbg3leu0hT8kqxgmIlJFA=;
 b=B1rb/lXwlCa+ubUToCM1OAu7T+Ij5lup4rv9ihK7jkUJGUS9lf5B7jXZm2rvJIuuAv9dAgZUaWkd9Lov9UNc36rT1etxCAITpkkkQ8MRoyAc5wH15gk09KjjXhSlvmWxNTbzJwHRZpQRJRW3zYS6QRE3VmbElSN283Bl1zpDimeRlRn69h5rPUf5rXAXTbrm0WKy3LikRvXboO5FkJBvrhVJ9rnURNH+5PLj0P12AdSO6wFWJar36T/P6S/pt/bA6SiinKO1g1r6w/w8VD0knMaejo7uiid1t3a7e2cIgdESw/3F3hPkSXRUAg++WG+ANmw1FUSWYmn96h3kOxSscA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by MN2PR11MB4534.namprd11.prod.outlook.com (2603:10b6:208:265::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Tue, 7 Nov
 2023 12:45:32 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%4]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 12:45:31 +0000
Date:   Tue, 7 Nov 2023 20:45:20 +0800
From:   Philip Li <philip.li@intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     kernel test robot <lkp@intel.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Paul Gazzillo <paul@pgazz.com>,
        "Necip Fazil Yildiran" <fazilyildiran@gmail.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: kismet: WARNING: unmet direct dependencies detected for
 SM_GCC_8550 when selected by SM_CAMCC_8550
Message-ID: <ZUoxYETfECoiqooN@rli9-mobl>
References: <202311062309.XugQH7AH-lkp@intel.com>
 <CAMuHMdUPR2tZmE9AKxa0QWrJJd=tju8=2bPBWQgcPs6_d0sOag@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUPR2tZmE9AKxa0QWrJJd=tju8=2bPBWQgcPs6_d0sOag@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|MN2PR11MB4534:EE_
X-MS-Office365-Filtering-Correlation-Id: fb72d92d-fced-45c6-9210-08dbdf8f6c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4wQLYr+mmGDgbgtK06WkktCSvlX0tFIy4OEDFnfB7DgSwMjSSLVwFLAsXD1Ec0ViRRciz6/cv870OhWeOaQ7Rcmc7omlTE1GljGtPN7hw9OmR+yfCXvjJA1R8FUhLFUxdZj758CzJaHgtDDOxOuiwXHIaKoZaZKxB/5nCjJv2kaslunR23cBWBfJdeTBwX8OLEnt3VBcOxIyXhIc6tO11zW9oJQkClxOMLfCB/HHgHYi+Fq03NhYa2gCDkO2A4ubtU8UTXasi8gdZRFWPuebT75PcMFfqA4bc9EUp10vrZ1tJG32+I72OHTB9tEUJwveyq1csMsREYvteZCNd+FDBxYtEKlfL0diO5o/J+OYa7PnSAZXVG7W+rZrjJ6klJzC4BP9WQgZEvs6RKMIkrJ1su7NX7OtdLmAq4EQVOTJSLEs6jbupQV63scQZf7Job6UNyvW5vuMU18ZKC5bM1Pv+UPWoFcizCp3aOWnY4m2iMeT4IiAWqgopy64WBcDd5nRQy7H5YkBnX43mnajDFqWlKLmocrmT7WahGczfKJqi1/1kXbdgndI7u+Lktk320A0VpitT1C4uXPxofxywQA3GMcymwFBhWsO5kGnY0J/DekPCo2vG/oHe2z1EBA2Etyej0otWmGv+ojFZyoCMm5tgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(39860400002)(346002)(376002)(396003)(230273577357003)(230173577357003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(6666004)(2906002)(38100700002)(966005)(6486002)(478600001)(82960400001)(316002)(66476007)(66946007)(66556008)(54906003)(6916009)(33716001)(86362001)(8936002)(8676002)(4326008)(7416002)(6506007)(6512007)(9686003)(53546011)(5660300002)(41300700001)(26005)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVUvU0dUbXFndjVxL0tjckdPMVFCbWxIOVBKTEgwSVZ0UTNmdlFVeE9NZEdz?=
 =?utf-8?B?aXlPaURFZmR1K1BwWHl1K1lCMm9TeUVrNWlFOG53VjUzcjV0OTVOMXRzREFp?=
 =?utf-8?B?aFl3QkYydW5EdWwxLzdsUk5kWjFaTVVrazZpMzkwcjRINkxsUFg0MFYzcnFT?=
 =?utf-8?B?RWQ4cUNoUUtGNmRhUi9sL0Z6WklpdHBGUGtQY1N5dFBhWEdTRTRMSHVKNzlp?=
 =?utf-8?B?a2RYTFRoaXdzU2YweGpnTDk2UVBLRlF5bjF4bWFBeGh3S044dkZsKzZxdkJS?=
 =?utf-8?B?a3J2cFUraGtpMStkWHJ6bDZ2OHZFN1BaUVVHNjlwTkl3aitlSmJHSGd2dnd1?=
 =?utf-8?B?UzVCMWx0WEVDZ2V4ZkZYeFZZSGhnNTNTc2Jkb2E1UXBDdHNTc1BmL1U5UC92?=
 =?utf-8?B?bWRncXVaWUNMQlR5SndLc0tOaU1rMks2bjB0cVZUTnJGYjIvUndmL2NqTStK?=
 =?utf-8?B?VUNLQ2piamJGYUhWN1hsOXFydTJBU0dsTFg1a3pTRWhjQVVsTy9YcUQ4eEw3?=
 =?utf-8?B?MFdKNlMycU5xR1kzUU9OZ0hralQzbzU0bEtxNVpqTXVWbmF6c3F1bHdXVytB?=
 =?utf-8?B?NXI0aWhwbkNMbUhKZXFHSjZFcHBJUXU5VWpZc1JReXdkK1ZCZTFHeUUzaWRD?=
 =?utf-8?B?WnA5eHhYQ2kvYVR4YlhCOGNLaHFvTXphMGZnbWNMSklwR2dJbVlIYjFvZUth?=
 =?utf-8?B?U2xPUklHZXJlODJBZE1vSHc1Q1FBa0ZLV0xjV1lRMXVpQW9xSmt2ZmFvY1lQ?=
 =?utf-8?B?a1U4dStJSUhPc2V2Q243ZkF3TWwyVnUyMTl5UERBRWtKRE5xNHFlSG5HeC9U?=
 =?utf-8?B?emRuc0RFUmowTjMySEJBRjdKY0x4TVNScFNBS2ZiRkdKNE42OWl1Q0ozZ1ZD?=
 =?utf-8?B?RlNRT3k5M3dCV1NzWDgraG9VRGsyempyUFFLK1Y3eFhCKzFjVFhKcnBqZDNw?=
 =?utf-8?B?ZGdvZ0dzQnh0enY2emN5cUFnSzNITFFSSWdJa3dlWXVhWUhOU3FENDUrKy8w?=
 =?utf-8?B?dHUrUHo3Zis2VXJJWFFLVFNsUlRKNjBURGo3WnVaUmhrUzgrd1F3K0tBSTNj?=
 =?utf-8?B?YlFSeGxBOU5iTEdmdlBtQTF4ejh0aW9vRVlXZ0JxWkVNL0J3OGk2dWZxOXp1?=
 =?utf-8?B?THI4WlJ0TEsxQlF1WWg0ODB6NmZMbVpJVENGdGxkZng5Q2NBdHRwOWVYZFEv?=
 =?utf-8?B?MVNyalpEZHBrYmc5M0l1eUl0TmgyRVZSL1M5REg2aVZlSnhWaUlsZ1VuZEU2?=
 =?utf-8?B?Q3VzR203RUFtN2tDOFJ2NDFEL0pHVnFUM0IvcTRlSGlCdUJEa2NydHNFN0Rq?=
 =?utf-8?B?czdzcUh6Z2Iwd3h1eEwyNXU0NWZpOXlaeFZpZjl4b2l6blV3U1JWWWpuN1Ru?=
 =?utf-8?B?b3ROc3VZU2N1cmZRWlo3UmJVZmpSWUJWY0V2OTkzd3JESXg0WnZ5cFI5b2ow?=
 =?utf-8?B?YzhZZmIveUxqTEtpZEdXVWUzVDRGZVdtOWZuZnQ1MExwZHBHZXJSdndSY2Jm?=
 =?utf-8?B?TkpWTGNGMnczeDl0MXd3MTZ2S2c0R3EycHJxNHBSSkhyemdtTHVuRzFXQjRx?=
 =?utf-8?B?TS95R1lGTDZTbVF1QnJDKzBxTm5mTm91M0JaanBxa1hibW9pcXliNFNZaDJK?=
 =?utf-8?B?ZGhkR2t6cmRaK1RoRHBwZnFnakF5L3dCeEFXNFd1MCtYbXpvZlNhZ1UwODls?=
 =?utf-8?B?N3lkVjJLWXFqWWg0Z0N4dWdBakhsUnpwTTdzRFBYcW9MMkZHbmVhVXdkcU5v?=
 =?utf-8?B?ZkpRL1lTQnhVWmRoT1YyZk5uZzhSN1RmTkdGTmxsbXNzNERoOXJNVHJUTjRl?=
 =?utf-8?B?NWs5ejN3eHVMa0UxV2JLNjI0dWdadmErbmVxVkxuRlVIREZJSWwremdTOXg1?=
 =?utf-8?B?anQ1M0dYZ2p2MmJVTHRGSE5PbDAzZFJWT2NjZjlSbzQwb0Q1VFlnbitMR0pK?=
 =?utf-8?B?UUxjL1ZUeUR1Mk5qT21wRXhVY290K3pCRHZvOFR2M0xGcFozV2dMTmpPanJq?=
 =?utf-8?B?L2NJV2tXMklsNENJcWVKM1ZpVE9VakU4WGJGV0l5QnUycnpSQjhtY0V4bjJ6?=
 =?utf-8?B?WmM2YXhGU1hSZ0lWeTh4UFpQOCtCRWFPbnY3TmFCTWhnWkkzS1d2RVdZeHpQ?=
 =?utf-8?Q?ycL1YS9/B0AquzTGmomLiOmVd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb72d92d-fced-45c6-9210-08dbdf8f6c9a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 12:45:30.1666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlhCngLCcKFrzLH7NfJkc9/wYUw6eHrwj0EGyFXhpqCebj+atbM5LROu0GNLT+p99XaF0UlKyq4fvjj81NNPXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4534
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

On Tue, Nov 07, 2023 at 11:11:54AM +0100, Geert Uytterhoeven wrote:
> Hi Robot,
> 
> On Mon, Nov 6, 2023 at 4:06 PM kernel test robot <lkp@intel.com> wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   d2f51b3516dade79269ff45eae2a7668ae711b25
> > commit: ccc4e6a061a21d75b96d82fc4b084a8d96df6eb4 clk: qcom: camcc-sm8550: Add camera clock controller driver for SM8550
> > date:   7 weeks ago
> > config: arm-kismet-CONFIG_SM_GCC_8550-CONFIG_SM_CAMCC_8550-0-0 (https://download.01.org/0day-ci/archive/20231106/202311062309.XugQH7AH-lkp@intel.com/config)
> > reproduce: (https://download.01.org/0day-ci/archive/20231106/202311062309.XugQH7AH-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202311062309.XugQH7AH-lkp@intel.com/
> >
> > kismet warnings: (new ones prefixed by >>)
> > >> kismet: WARNING: unmet direct dependencies detected for SM_GCC_8550 when selected by SM_CAMCC_8550
> >    .config:7280:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
>                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Where is this coming from? I have seen this warning in several build
> reports (earliest 2023-01-31), but cannot reproduce it with the provided
> commit and config.

Hi Geert, this was detected by kismet tool developed by Paul Gazzillo and Necip Fazil Yildiran.
It can be obtained at [1]

And the issue detected by it can be reproduced by make olddefconfig as well,
the detail can refer to the reproduce instruction [2]

I give a try as below inside mainline repo

$ git checkout ccc4e6a061a21d75b96d82fc4b084a8d96df6eb4
$ wget https://download.01.org/0day-ci/archive/20231106/202311062309.XugQH7AH-lkp@intel.com/config -O .config
$ $ make ARCH=arm olddefconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  LEX     scripts/kconfig/lexer.lex.c
  YACC    scripts/kconfig/parser.tab.[ch]
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/menu.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/util.o
  HOSTLD  scripts/kconfig/conf

WARNING: unmet direct dependencies detected for SM_GCC_8550
  Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=y] && (ARM64 || COMPILE_TEST [=n])
  Selected by [y]:
  - SM_CAMCC_8550 [=y] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=y]

[1] https://github.com/paulgazz/kmax#using-kismet
[2] https://download.01.org/0day-ci/archive/20231106/202311062309.XugQH7AH-lkp@intel.com/reproduce

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
