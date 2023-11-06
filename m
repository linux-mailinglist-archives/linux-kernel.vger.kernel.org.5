Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2094C7E1D51
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjKFJgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjKFJg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:36:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305B6BE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 01:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699263386; x=1730799386;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=F6ZHCmjNX6sdsO6FHcYrp4g8EncREEVKoo2zonRusW0=;
  b=PFq0hiRWfDo2IjhK3OtFlq5aLU6MK7VUmjslBUfaoOVYYfhTvBfGaVV3
   YWv5ZAT+LuRJdI+qyOUke/OeuWHVuf7cyOaPKM5BNl3ky9jGpsTAnUOAb
   /DqPkXiQEzgcBqZlLK/OHYJbI4Atwtz1Y68edVl5RYO4PdfERAzunHe+T
   1gkqz9EysiFjFgd3qJpOcOH2IUTv9Z8/F1Ga+Akk+DXhSVUieiLi/w6Mj
   YSJp2ubcpJdeilXgwY6Y8uVrvdr2Ty0qSXgMmo3EK3qJaqeJLJtmvtA3p
   dvjKAaVNW3veE6Yl+eNwpk0wqfTY0nLfEVg1b9FUVeuFSzSrFKleGox4Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="2228818"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="2228818"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 01:36:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="905997607"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="905997607"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 01:36:13 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 01:36:13 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 01:36:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 01:36:12 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 01:36:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVD9yeawvA32ZO8oTW7yY633ozG0jvA6P/MPwNVFSgXgU/3ClnClXldHvfD52anFaRQyzLqQ5Dc9kKLK2Ef4fkvSV2gPiI0URubTp3z2726frTjg7YgrTBjvUEHf+tkUcERlcqHmg4PyXNh6EVgHPFPV/zERigkpIqcmgh11cBpDNF86xR0GXQe9A1y/6grzluPDP7P6Jl+SEjl+Kk1w0sDQtQ6hrFCdBG/0gvb0EXjq5o8iq930fYXOfyINmyA6w6y0vgCxc3Cw7/LocyaQJB6hluxK2x1B3cd0QRoijEsuFNLRFwMxm4YvKGCtxvmosCYOkBCuSFtsEih7hly9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwpjUqMAxJU2UxvSKtVJUOvZyKCSBdWRr7ObU0ILYo8=;
 b=X8Oa9vJ+ZZKydMIkEbnm/TuGA14SKGobBcpXGerj3wp8eLIObhobmyYewTu5b1I5HpCZBrXDhOWBGZriuseo2QhlXoHtulULhW0GscsJCeLtEJxGX/JQdIfApTKYp8DJJn+5Hrg/pOsZNcK5/tCPRuyTePTbQpUtVWB+FPamE9AHWvNmzOIxQZYZqmxxFLS9Lv2Afe0ny1ZLhzJxFEDophBkvjl9JYxtiyIdcbkK1mz9M2uAnietaw8vnXI9taThziarLYufHbkYyVW5g+ttuG25JxsiGaGJxKIMDkxMT8jXOUN7n4dpbWkmWgSE70o/6ATbcZTY0BEYd3tmBWH5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DM4PR11MB6068.namprd11.prod.outlook.com (2603:10b6:8:64::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.27; Mon, 6 Nov 2023 09:36:10 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.6933.028; Mon, 6 Nov 2023
 09:36:10 +0000
Date:   Mon, 6 Nov 2023 17:31:26 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: drivers/comedi/drivers/tests/../ni_stc.h:1140:35: warning:
 'range_ni_E_ao_ext' defined but not used
Message-ID: <ZUiybtcMJGI5ZCF5@yujie-X299>
References: <202311060001.aEuf1q9y-lkp@intel.com>
 <2023110641-profusely-factor-b3c5@gregkh>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023110641-profusely-factor-b3c5@gregkh>
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DM4PR11MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f3d438f-abbf-47d7-552b-08dbdeabce7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9CkdkBAkWwKwSJqyFnGO2LMsmTySXmbGwpToT3dmGt8RVzRO8cxlVCIc/eqNjSDiaEbpg47EPhWdtj1wZYi7GeQdjlb0eWcq8Jts7b0w5s8vrsXkRuLxlM4x/4tKBOo/urAWo5loQYKV9vdujgHNpIojxQGCcDVq7KmEHzqaLFO6teiC7qjmyCWYuga8m6V27dRtXzL+PEht8e2n23ImgYbJWOcz1DYWa/AaY9obiYK+Ci126hhU7alkArlwyp/qxxZc2FudhSdD/K1YLMLvho9mPfVCLFnIF9a+xPOsTvbKRhp8mLai0nswazyQCLxP78qb9CnLn+nZ7fEnJNt4MtWPInAiZvLkFZ6X6uYMdzz/vHqw6xyGdk6hDfD7Q44/muyVy6hXZSwII6aIb81AREGwxkgp3k9/+LL3opV76e60uUqR4dK0IOEr4Zrr4V+2vdGcxHoYZ+akktE3f/yC7iuKk09Asr/0z9yvzAAcXBPWmjkVjGntSfXsTuNwckQQc8M2iaQ6vWlSF9UqFaeKMvsvR9pYnu0fMmzdPAhQC4hHxvvFhgpWmRJC3jeth0ld0C7mMMtLLKWAKjJeFKvbPYWuom/52Ax7CyObqhPwUOSbGMr6N2iqJcUJS+cKrqdQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(136003)(366004)(396003)(346002)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(1800799009)(186009)(6506007)(6512007)(9686003)(26005)(41300700001)(6666004)(38100700002)(33716001)(82960400001)(86362001)(2906002)(6486002)(966005)(5660300002)(44832011)(83380400001)(8676002)(4326008)(8936002)(66476007)(66556008)(316002)(66946007)(478600001)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHBZUlR0ci9aVXNBa1Z5VVNzblRldE1nMDRtSlVNbitYQ1ZUcnlmdXN6SE1x?=
 =?utf-8?B?bXE1eTFIaE9yVXRrc3dyeXJLbWtBRGdZbkwwY2pVVEpoTE5jc1VhMGlRakJJ?=
 =?utf-8?B?a1gwZjc1cHBYTGpUUHVFQ2FWSmZyaGszODdvdmVYTzZQSkhkZnU4V0RJaFlM?=
 =?utf-8?B?cnNxR2VCVmRWWlJJNDZsNTRzSnRuaVd2dlV0UStRZU56OE4vcGU3RUJoTEhs?=
 =?utf-8?B?ekdFcVMvbXRkamcxRktqTnR3YVVQS04raTZkRFJZMEJieTJNdk10Y1FNNFhk?=
 =?utf-8?B?ZzQxb0JXZlM1YlhvN21GM3BIM3hmMXFXL3hwNlZXK2tlaWFUb2QxYXdsbERT?=
 =?utf-8?B?emp5STYyMjZWVjl5RUpOck8yUWFCN1N4UHpvbDErY2RNTEpSOVpiZWxtaEdP?=
 =?utf-8?B?U2oyK0ZsRUxxN1pMSlBpQjV2dVdVVjFob05IWWl1NEVlTTVNOVVxTTh1U2tu?=
 =?utf-8?B?d0pHWDM1cmplWlN2TmNOWjk1aVBibDBCVVNhYXVXdkNaU1dURFFIMnJBMUZj?=
 =?utf-8?B?SmlYQ2YyVU45enVramo5QlF0TEk5OEg2bjhhTzBhcVRLK3czcUNMMFpESVFO?=
 =?utf-8?B?elNCSTViN1JaUWVGWmN4MXJzTVVoZVZoN0RkY09BUmhIRGx3WkJ2dzg0Sk1t?=
 =?utf-8?B?MTZHdElnRHF4ZGJmTjlXajQ4UXhYeFBYbldiNXdxRVRkeHl1R09FbDl2ODAr?=
 =?utf-8?B?K01WSWdtVWt6SlJZWW41RGdNL01OTXNMR2NqYXBKaVE0TU02dVNHbUVPcXpU?=
 =?utf-8?B?YzlLNUE0RXNvMzZIOXhadmFiZnZoWWUrTkxKTnFWZG9pNjJWbmhLRWI1Smox?=
 =?utf-8?B?UHpDSWFLMlp3WHFZVklLcEFwZktYOEUyRjVFa1hlRU8rM3AwV0k3RStXS3hL?=
 =?utf-8?B?RHE5SnBKWExuRlByYkl3SzFpUExPNHdtbEovdU81SWt3VUFaaHR5MWJkU3Yx?=
 =?utf-8?B?UisrbmkveTZYaHRsTlZTdzA4T2pWejZXV25ybWxxN1czUXNhQ1V1UDgxMGNr?=
 =?utf-8?B?OG03aCt5aVBjcGNuUHhjMWQ3R3hnSFFCZWpyUHR0U3JCamZROFRIa3Bobkxr?=
 =?utf-8?B?NnlRSjZrOWRsT1NkZDZueXc4OGU3Y2pEamRqRnN4WEFxcHFNZEdDZlFDenRx?=
 =?utf-8?B?R2p5cGtaQmM2OG9wMDh5bGorVUEyTTdwWHd5d29GcFJST2Zzak5HdW5wKzlt?=
 =?utf-8?B?WTIyazJnUFVud2FhUzJLbkRJMFVmREZHTGRrU0Q2WEx6R3lZSHpEejZsOXJX?=
 =?utf-8?B?UWNRZ0dtVm9iN2RwaXBwcnFEUCt3c1JudHB3cFA3cENaNy9QOC9xcnZNNXRQ?=
 =?utf-8?B?SU9XUnVRaVdmb0ttYWJTZVFSNjZPcVo2aCtLWXU1YjlRUFNxaEpBem91RGVX?=
 =?utf-8?B?OGhieWpRWFdUMFJjS0tvOXpMMUNGczRLUkJHNHZPbjNOSzFNSXdUbVUvWk5a?=
 =?utf-8?B?eDNPdTNSNmpLaU5WMmUwTnNkdVFqM3RyQXpDWEJOS09XSDM5ZzJZcStZbTlu?=
 =?utf-8?B?eXpYQmVXbGY2ejd0T3hVa0xzeElZU0F5MU5zV2dNWmEvRm1Zc0gyZzVEemxN?=
 =?utf-8?B?TzFibkVEZktiRjhxUVdIT2lCam1kUk9ncW9oNXN4Q0V1OXZGVElxdWY4bHhB?=
 =?utf-8?B?SUZBMmtGOXRzVWlDcTFzbjJxMHRicEdmNEI2aWUxb3VOcU1jb0FWNmh5V3lh?=
 =?utf-8?B?ZnVieUdTWlZvTzZESTd3VTMyWXIyZGpuOXRISnJIL3FPT1AzT2JvL1R4c0l0?=
 =?utf-8?B?WU5uRTJZd1crME1ZS0FaZ2hUYzhmenpZRGRLU0Z4ZmIzM3JDS2pNcEwrb25P?=
 =?utf-8?B?bFRETDR4WGU3UXNjMTlNZUZvYzFPTUpXZTNiQ0p5a1hGRU51QmlwYnNzdFRy?=
 =?utf-8?B?aldBMEtpb3hCUlVSOFh0UTZ1WCswZ2JnR2x1S3ZicE1pQ3I0RmhKTnlTUjVa?=
 =?utf-8?B?ak50TDYvQ05MaUtwNEZFVitIbnMxUEdGWVE3ZnpJeUhNL25LV0hLMlhEeGI1?=
 =?utf-8?B?czRpeCtVQ3pVWndMTzArVVo2Q1lNZ0VBZFZjdmRvdXNLZFZXcG5rc3pvU2t1?=
 =?utf-8?B?UkpwcFV4YXB1V2JKSTE3WVZvb1BNODNUNDZsWWxrUG9jU0d3QlgxZU9HWnUv?=
 =?utf-8?Q?UVuPcliuJxSNHzscmNwcAlyRO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3d438f-abbf-47d7-552b-08dbdeabce7d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 09:36:08.9090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uH68vokXaV59BF04iaqJX2k+5VmTnQU7DqzABlipwEq6u+ND0Vn1nz9heC0ggI/+u4/Ln4eNikWdnaNeZPR3RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6068
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Nov 06, 2023 at 10:00:14AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Nov 06, 2023 at 04:49:17PM +0800, kernel test robot wrote:
> > Hi Greg,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   1c41041124bd14dd6610da256a3da4e5b74ce6b1
> > commit: 8ffdff6a8cfbdc174a3a390b6f825a277b5bb895 staging: comedi: move out of staging directory
> > date:   2 years, 7 months ago
> 
> Have you tested a newer kernel?  Testing a 2 1/2 year old commit feels
> odd to me, was this intentional?

We did test new kernels with W=1, and the issue was captured by the
bot, then bisected to this 2 years 7 months ago commit that was likely
to introduce this issue initially. We have no intention of directly
testing a very old commit, and we're sorry that the date info may
cause some misunderstanding.

This can be reproduced by allyesconfig build on v6.6 with W=1:

$ git checkout v6.6
HEAD is now at ffc253263a13 Linux 6.6

$ make ARCH=x86_64 allyesconfig

$ make W=1 ARCH=x86_64 drivers/comedi/drivers/tests/ni_routes_test.o
...
  CC      drivers/comedi/drivers/tests/ni_routes_test.o
In file included from drivers/comedi/drivers/tests/ni_routes_test.c:22:
drivers/comedi/drivers/tests/../ni_stc.h:1140:35: error: ‘range_ni_E_ao_ext’ defined but not used [-Werror=unused-const-variable=]
 1140 | static const struct comedi_lrange range_ni_E_ao_ext;
      |                                   ^~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [scripts/Makefile.build:243: drivers/comedi/drivers/tests/ni_routes_test.o] Error 1
make[5]: *** [scripts/Makefile.build:480: drivers/comedi/drivers/tests] Error 2
make[4]: *** [scripts/Makefile.build:480: drivers/comedi/drivers] Error 2
make[3]: *** [scripts/Makefile.build:480: drivers/comedi] Error 2
make[2]: *** [scripts/Makefile.build:480: drivers] Error 2


Best Regards,
Yujie
