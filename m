Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E8E7E4F5D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 04:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbjKHDN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 22:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjKHDN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 22:13:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3236C10EF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 19:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699413204; x=1730949204;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=7Etvc0Rlxxspq/qmb/JXNZaSSti/JOCIITnWGUGVq90=;
  b=Qx4Sy0ace7M2VJ4Ueb+boZeXJqT0x1SobZA71WVuREzrowMvt3tHFQqH
   wMkeE/uzfr++iUrcpkKtwY490f7fxVoNHg2d7nHdzJWBXDjwEyQNq3TMt
   tGuCGPLcx/x61BEksnfrKMLoPXLZJbt6yky5SNYo03KLDUU4BqDE3500g
   E5krcn0EoIdk6SqiWyMUDNgbLumiBDcetkDQB7mnCLoatoPsO2sn2J5AL
   VqpN5dVV8/w+4h08wRPatAm814w4aqT1QL61nHqFpmRRvZcT/iOVLJT2R
   rhz8VpY/x7BTrDDWCqf+S2p83m7GFXQe2wqpsgDecbmn7DBTO+EBGPAaX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="456174152"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="456174152"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 19:13:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="762917546"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="762917546"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2023 19:13:23 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 19:13:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 19:13:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 19:13:22 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 19:13:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2tKceDH2jvC0Tjh6D+rbXQBqodFUejDAFMHwFj+S+r6xwZ3FFmM2OJkWvbymq26mi47H2sNFNWUrdRGeFCV8+Ak46NwigATKlCV5Rlf8bbu7njVk4+VD+pecYz2vF+MNF5EEuml+Tv6XAgR243jRIjc3JBPP0o2wTTiWUNU9RZXm6llRLa49jHYizWieHtzJGOJJgndS2+5MgtTWbHwZvr3anSeF+WOY2k1GUqz0Da+HRDlqEceCkNbg53DETtnRxqCvF9g9jwuu9QA3W/lZtW/FCsrinT5jfsulGdsc38Wh01jNrq5uyCTiyDo1XRCKKHTeAwU/qk9bO9T09Yr2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/yL3aAUl16tkuc1KYxRn5Q5cNcmApW9n5wEn07EEeU=;
 b=BOov/ffLaRJqyw0iHon9WLFcM9Je13DIoUidk3IcdbdjzSPi6fJbevGQRn6JXPkMBLk+5sDs1xb4wQJXb9HJlEUCjSx4Hw0i6sqf6uKuW69Yt46IiAWeMipVLPuEA8pTVHV+UxeOC/jHWkUl+/g0Nct9fWy7kB9lR1Qa378UGvejNZX0ErsK3nuETSKZBy+GCX8gER99DHccPEFsWGITPM9IaW2ZA8eMAE+Ze5EgWxhhLTkWiPmgn0b2srUevv3yFlrQrP/DS82E8IeF+cWD+D5XRIf5uNLvDY3LqZ9qlXUTYz6jkXoQheJloTLY0DogyZpBtxaWxJ/p4C+BwDigqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CY8PR11MB7395.namprd11.prod.outlook.com (2603:10b6:930:86::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 03:13:14 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.6933.028; Wed, 8 Nov 2023
 03:13:14 +0000
Date:   Wed, 8 Nov 2023 11:08:30 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Gazzillo <paul@pgazz.com>
CC:     Philip Li <philip.li@intel.com>, kernel test robot <lkp@intel.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: kismet: WARNING: unmet direct dependencies detected for
 SM_GCC_8550 when selected by SM_CAMCC_8550
Message-ID: <ZUr7rrlrowHC3+9b@yujie-X299>
References: <202311062309.XugQH7AH-lkp@intel.com>
 <CAMuHMdUPR2tZmE9AKxa0QWrJJd=tju8=2bPBWQgcPs6_d0sOag@mail.gmail.com>
 <ZUoxYETfECoiqooN@rli9-mobl>
 <756c9659-5c7d-4e29-b5d1-76b26dd3e0c8@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <756c9659-5c7d-4e29-b5d1-76b26dd3e0c8@infradead.org>
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CY8PR11MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b312e5-99c8-4230-28bd-08dbe008a570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Ou2ulCb2ELmKAcpOdfR+1Iv63qvQqBXkHeUIC/MFw8ST4qdlGhJYHWB2Hsa/ZG4wn/1KX5iX56rvIP/5xaYr679CqB02gLYSoJiff8b46CAiK0UpKKfay/9XtOWA6scC9x0u5Tlj4MQVyEU6ehIXyPCeOe+itJo/qNb8VaXff5BzufIWU3SlskbwmbrVTQD9S1U1apR/LJGdlaB+4V3ie4HHlKeQjDJz4Brqn3U2WuDt8p7DrXHCF3ojgeleDXRQw1e/cRfdLFu+7ee6Ko8NdsecGXevWqIbyF3pXMszPB3CFm8800VviLq2zYMtAjowoi+URz5aCuSVtrYr4TX99WDi2QbEConwylmuo+eIqJL0FEDwtAWHE8vA3bhJw3jdY1EezVoW/PJIQiRmFL6mrLQf0jMuiQ5A3XEgoWrKmmiw3r1OhqsI+nFdVIHkuEQzdFqA4TwozLwhd9H2X6oHcbqgLmikgpAAZZTTQuvrTGeF4UEvu7DBtvETb027gw9NmlloX6CuYxF+xYsQpNOA7GZxhs91YO30+6+nyECb2ZhnI1if3v2JM2CbiJHeNSB42ol7sEtvIvPzVWjjWn9n24oJBalKYXkwJF8W0L5TDcuc2m+z+IylvyGM5FLWdfjgc85CC7Fe5e7NaUQf+OqlDDWDUNDBC3IYBk58C2a0qU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(136003)(376002)(346002)(396003)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6506007)(33716001)(83380400001)(53546011)(82960400001)(6666004)(478600001)(6486002)(966005)(110136005)(54906003)(66946007)(26005)(66556008)(9686003)(6512007)(7416002)(38100700002)(5660300002)(66476007)(8676002)(86362001)(4326008)(41300700001)(8936002)(44832011)(2906002)(316002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjRvN0R4N1ZHOVJ1VkNPNktqU1ZDVVlOdEVQUEVTZWlkeEQ1QURlYkN2V2Z1?=
 =?utf-8?B?M3dRc21sblI3OG4zWmptTVZ4Mkp6YWNsc1dDMCtncm5YNDg1YkhMa0pOQ3hO?=
 =?utf-8?B?bHdGaE0rV1dPTGNkUWU2eFJ6eFo4QXdZMEk1cko4TzhGcElZOERvVEE5MG10?=
 =?utf-8?B?Vmp3Tnorb2laWEI3VjA2ZUpPSzRrMTJzT2RGUjd2K0d6OFp5ZEZmWXROS1JK?=
 =?utf-8?B?R0FidVNvdEFuc21YMUVUYTFVMitOTTEvdE1WWkhubU9xUzBXcmVDYWNiZGs0?=
 =?utf-8?B?M0RFc2g1Sm05Q0p6d0Y3NG52U25VNHhPeGZrVi9jQnVaVkRSNWthUWIxazZ4?=
 =?utf-8?B?Yzg3d09WV2dxY3k3MCtIaW1TdCtyYkhydC8vNmp2WjlPOUtncXFJYXlLSkRY?=
 =?utf-8?B?Nldwa09MaFppeEFTUzNRMHpCaXhVVjR3NWIreFB6V3NOWmNaMHVaSEtXRW5n?=
 =?utf-8?B?dFhhUVdmVmp0Qlc3RG11dXpXSnVVL1hLMVRXT0I4cVE1R0tTUmdyUDFlcEYv?=
 =?utf-8?B?OWNIUzNJdVNJRGlGQVBlanBQcDNNNXBpaStnTEtQd0lockQxTkRLanVXV2E1?=
 =?utf-8?B?K3JWZjhZSWJSdmc0cXpuaHlBSHdpME0vdWd5ays5LzlvaW5SalVBNTJkNVRX?=
 =?utf-8?B?b0FZeWJCems5UnVYTW10aHpKRTNNeE5oSEVnZFVjWUVXLzVIZHNMZkN5Rkky?=
 =?utf-8?B?TjdIRmVWdm12a3hEUzZYcVRYQ3J1WndqaThEUWFkeHl0ZC95a05ZN2s0MHZN?=
 =?utf-8?B?Y3A5d1BXZ3NoUUp1bGZTaXBuQXpmK3RoNXc4bUlveGducFp5RENOeTdlQlhQ?=
 =?utf-8?B?SW1lRVp3enRyWW15UFFLMFpVaXhWTXBQNXB2c255czV3ZHdnTlc1KzA1aUJI?=
 =?utf-8?B?V205SnNHNkMvZ1VjQ3VGNDV6Q0MwU2V5WXJBdExTMFRldGtDN3JTdjhKUVdZ?=
 =?utf-8?B?VWdmVWlmVGs4empZUmlOY09mT1Q3ZVNhZ2tlUGg4b2dqYzFmWklZcEhGVmhr?=
 =?utf-8?B?ZTgxay9TWHRYbVAvbSs2WWg2RzE0cXAwQmdSWjRzNnp1bHdLSGtjRWdnYWlE?=
 =?utf-8?B?ZHoxTzlMcGpoNGVRTS9qelgrQjZUaGkwMlN5bFFDdWU5U1REVW5lcTZXcWlW?=
 =?utf-8?B?VkhOUWlQRjdJVm9wZVNCelpXQUdzSGhBMkVWOHZXdDMwdjJRTExmN3hSNjNI?=
 =?utf-8?B?eHIvbnpoUTJYYW9Vd3hpTDJGN04zWHRCN0JYRzhkUCtmak4xQlY3OENRMlRy?=
 =?utf-8?B?TFRoUEw2akNyc3dBWmU1OUJLMit0Y09LQklTTm5WUmk1aHpza21vdkRueXZa?=
 =?utf-8?B?bTlQdkRrRkNTNjd6elRZZXE2akVLQU5EMU9PSGthTEdMbkNob3VzeVFuSnBO?=
 =?utf-8?B?NXBpNXhQTzljNlBCQkdXTXRXUlZYdUk4TjE1eE5MMjlYN3NiT2cyMkNhMTZS?=
 =?utf-8?B?TmJkSU1sWWlSWEY2TE83aW4rV1hMSWRtU1diQkdQZjNQK0EvblY0bVpLZzM0?=
 =?utf-8?B?cFNPQjJ5UUswTEJUQmJNOTN5bklzekFLRzlmRkdVdmg0dVp2aEV0bFViRE52?=
 =?utf-8?B?VTAvc1J5eEEyVmlreDNRNk1KQUlFTWc1ckFtMXRONVdlNnIxRFpzbXBaa0tG?=
 =?utf-8?B?Z2pKWkpwcWtFNktGL25JU2tQeG1nU0Iyci94T001WERyUWVSQWpEcFYxQ3RU?=
 =?utf-8?B?RW5uZC9zU0ZJeGc4RzFrbFV6elNib1VoNmJSd09KL0JyWjhHZHd2WGpVdW54?=
 =?utf-8?B?SHdvaGkrV2l5TFdyTnMySFZCTUVFc2o4SU9zc3MwUVNKZ2pjaUtFZ1J5N25D?=
 =?utf-8?B?M2dNb3VOSElJVisyYnAxcnpHSFhJMWRySnFwY3ozdFBwWS9yMjYyYnJwbG56?=
 =?utf-8?B?ZElWWmp0Vk56L1B6YUkweXpickhoMHBKYUlRWFBjUUxMdXMvYUxUMmVEWXhX?=
 =?utf-8?B?eFFWL0JXQjVWN3huYytrcjBIMWlRMVduVHdKdUNCKzVkY1IvY3ZXWUxMRjha?=
 =?utf-8?B?QnhuMG5xSERMb2FrdUQ2THphK0NsRUx3WUlub3ZvejNrbGdKOGVOcVBtc2NB?=
 =?utf-8?B?TmkyOFNjSnZLU3p0WkNPTnFTNkdmTjlFMlV1ZzBwaU5kL1RYOTF0eWRoK3Fm?=
 =?utf-8?Q?xwwwbPoYbWOr9BErUtgyuGec9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b312e5-99c8-4230-28bd-08dbe008a570
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 03:13:14.6671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhnavnEa23sXXljcc+8No6xE6y/OPJqgMVoR2x4O8WA+oeq0IZThRGDI9XGi+FngScrzet+NB+BvLzPRFRhNDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7395
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 08:00:33AM -0800, Randy Dunlap wrote:
> Hi Philip,
> 
> On 11/7/23 04:45, Philip Li wrote:
> > On Tue, Nov 07, 2023 at 11:11:54AM +0100, Geert Uytterhoeven wrote:
> >> Hi Robot,
> >>
> >> On Mon, Nov 6, 2023 at 4:06 PM kernel test robot <lkp@intel.com> wrote:
> >>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >>> head:   d2f51b3516dade79269ff45eae2a7668ae711b25
> >>> commit: ccc4e6a061a21d75b96d82fc4b084a8d96df6eb4 clk: qcom: camcc-sm8550: Add camera clock controller driver for SM8550
> >>> date:   7 weeks ago
> >>> config: arm-kismet-CONFIG_SM_GCC_8550-CONFIG_SM_CAMCC_8550-0-0 (https://download.01.org/0day-ci/archive/20231106/202311062309.XugQH7AH-lkp@intel.com/config)
> >>> reproduce: (https://download.01.org/0day-ci/archive/20231106/202311062309.XugQH7AH-lkp@intel.com/reproduce)
> >>>
> >>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> >>> the same patch/commit), kindly add following tags
> >>> | Reported-by: kernel test robot <lkp@intel.com>
> >>> | Closes: https://lore.kernel.org/oe-kbuild-all/202311062309.XugQH7AH-lkp@intel.com/
> >>>
> >>> kismet warnings: (new ones prefixed by >>)
> >>>>> kismet: WARNING: unmet direct dependencies detected for SM_GCC_8550 when selected by SM_CAMCC_8550
> >>>    .config:7280:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
> >>                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> Where is this coming from? I have seen this warning in several build
> >> reports (earliest 2023-01-31), but cannot reproduce it with the provided
> >> commit and config.
> > 
> 
> I'm pretty sure that what Geert is asking about here is the warning (".config:7280:...") with
> the truncated kconfig symbol 'ONFIG_ARCH_MMAP_RND_BITS_MI'.  I have also seen several of these.
> Is this a bug in kismet or a bug in the robot or something else?

Hi Randy, Hi Geert,

We looked into this case and found that it is likely to be a kismet bug.
We have created an issue ticket at [1].

[1] https://github.com/paulgazz/kmax/issues/239

Hi Paul, could you please help take a look?

Thanks,
Yujie
