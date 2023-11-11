Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DA67E8B4F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 16:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjKKOzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 09:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjKKOzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 09:55:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9577E3AA8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 06:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699714535; x=1731250535;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qYnY+/cl8uzgcRA4P5Axcr/azsriIq3R9CU7PRVdRLs=;
  b=b3ULtph29HkuBQRFONl0RK6aid1+cszWBTa4A7NSZZwnrCvneH+DNrHi
   8jdqhw/gR8ZH84QROXdmUD7hv9BqHxAMOC8cvsv7YCdSJuyTRHtFn+nuP
   WMwV1/vaF5eENqvegdxNICfsmmrPwmIuHJ9QH5vpQiSj0osYxU64EafIn
   kiDVBaD+t9knkCOqKuQSRXUHYEXenKCVgwnq3r0erTOuXqLEpbETT4Mkr
   mRKMNFq2gbYjwV23cAo6PoDWgQgi96HK2xYWZyC9Mg84FMaTyTOWy5qr/
   YjYma/Z6k4pdvPLCqbxF1FKALvj7Q9TAyGePUzzeZbZt/RFuDfdLo1qPl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="394183719"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="394183719"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 06:55:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="767537470"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="767537470"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Nov 2023 06:55:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 06:55:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 06:55:33 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sat, 11 Nov 2023 06:55:33 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sat, 11 Nov 2023 06:55:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eyd96ctHILGd3OyDsuRKXpP0B7ozdgxne1uMQ2JlucG2BQNWyjDBv2tvmnDYE5jM/+4mKIgi5w06QU2ahrulXybeNZFoibNEuQKmlVKqk63BhDJ/Fzuy74gSSGlUufZ0OnJuLTgNQM3MXlBLwoi51DuG0CblfU7opRoy2URjECXsLOJzf+w6c9E6IdVr95oa7x6FUfyfBisolWKE0rL5s+5hq1OvN7Ksj1QVwtL9NBOmd66tlmHJc7qfYW3v/PhYIlbzAILx1ncOJE4SrK6orhdLmNVGNoLn9x43+TfZvGIO2xmlUK2idIkiylJPXNB/glWWLcQ+huao6GQoknrCiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1+7nRivC7AWCvVS4I1zSJzBrlkRwuWLn3DK4DNdN4o=;
 b=Yik6UrrOgJcBgoReGPBUA9WK3mY8GNhwSBbMDqxDSavwTmy5IuVzcrhKcbRoR8WXvK6MS8Ah1vSWkcRW+ym+0g2J/bB0vj0Go9WX0e4i19f6hbb3gDwesX7YbXHTdDX12wnD05bgF7Ok3/hNrixfF/WwZJ9xpZaerbPsN8aKrUcMGKk6FBvhoTc1kgkNwPSZ00x48rAT01N3nsL51Vnq0x5HSxUV4m1xj6gyZyyjbLm5TusdkGUmxEqNuliS8y2Gq05qQC37KsqE5vwrS2VCP9Egi22eYAyjKLGQ2A11LxyRTQPt/FXEZrKceC1yofrwFNIVuY+z4Q8obzBZsZsGZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by CY8PR11MB7268.namprd11.prod.outlook.com (2603:10b6:930:9b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.26; Sat, 11 Nov
 2023 14:55:31 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%5]) with mapi id 15.20.6977.026; Sat, 11 Nov 2023
 14:55:24 +0000
Date:   Sat, 11 Nov 2023 22:55:16 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Christoph Hellwig <hch@lst.de>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: kernel/events/core.c:4881:24: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <ZU+V1Ela01RECiwG@rli9-mobl>
References: <202311112205.oMWYlOQe-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202311112205.oMWYlOQe-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0170.apcprd04.prod.outlook.com (2603:1096:4::32)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|CY8PR11MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dd3d07f-e0da-418c-e116-08dbe2c63bae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o39e/qOdH1BeRziqDWw/hGbf7GiQnUwuzGnlCDK57mVGtJRolfKQhbRBXO4ZxRPdvzcmM6DvcDIFq+TYKdMdAuLGo/7e+PUTXGjxj7v1HTk3j25idq3Gu8dtEd+KD3dsbO1IoDK7ziasMUARTOJFZ4hEprAUaL5RjOxkj2eGtrNh9e9WFacmObcxd8Dy5jSu5dpL3ZuL2hqyRfTPryaA5eWYU0VrwVvOodIgvl6YCKYVi3ahv9nnNPR950hiEwErCvcPv6lDG690N2CG3mU/lvLNOH0Q+haQjdGquFPkiy8lrb7kN6v/OetI2DrWvXAG1659MkZHEruOTdoBwXNAiGMA5ykjAIIaWd9NNm8GMzumKgUT8O44MBLyVFhHe5WCUuZQVJTxl2iQ/u4XIzIjdc31a4E6LGOyNdS/pTdF025WxAb2JrS3tm/+S7DGAe1znc2rXjC9eOggJHFURpjgnCyXiHwiWVASLkmfJoSlSC2vVlMs/bRcO3cpxMmm54z7y8pavUJEDq3HSGszmpCAB6+a2aUu0K0udJfWOuAVejvEBFPZekA4BpvkVlgkoYsnYEefrFrkH1Mg79+/wgd6WHSoKyEKcMuVo+QPHrTKOijh0W6ol4YC9O6wbmb74qxxdKlkSGEPjEIEHpsC2ivBwa62IREcQpg+QFH3ZrSSIy+UBDVqT9UsZ5aNtmnXPe9v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(1800799009)(64100799003)(2906002)(30864003)(44832011)(5660300002)(86362001)(41300700001)(33716001)(26005)(4001150100001)(82960400001)(66556008)(66946007)(66476007)(6636002)(9686003)(6512007)(316002)(83380400001)(38100700002)(966005)(6666004)(478600001)(6486002)(6506007)(8676002)(6862004)(4326008)(8936002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+O+n+qLqDEXG+YO6dWKOOBka5nk6yJmIpcTmnU5MtPmqtUBr+BIzdihylDK2?=
 =?us-ascii?Q?yp8hAL7pThVPSl257UjKT370AbyKyhxgyyfM7uolbR0bR0/uhJVba1BAECMe?=
 =?us-ascii?Q?2ufPiynFikM1loo6yOSS2ywT868ATCJ9unBQjYfHPa008cxGpLnkOHbK8C+p?=
 =?us-ascii?Q?He/R2PAGh9b+CGFC7KFl6ohldxGruFf7vAftWb/Bp41vzfDduG/YQWwMENMw?=
 =?us-ascii?Q?pOZLIfQHOC0CyeFH+aAmQd+9SOG9hTAt2WCI1bs9/8H+fQI9zuFDdBTTyUVd?=
 =?us-ascii?Q?FeeyjBNyjRdCshv7rMfLBUgJdS0O4873wYja99vkGBIfJ62CE3OQrSHhJc4Y?=
 =?us-ascii?Q?Dptogt83oTlobMOPl+L/B+nj5Wb8DHwu82saRClgWuk/X1KbzmTOs3tqfYVp?=
 =?us-ascii?Q?rCDDx9NSDowiFQWAo3hd2nAcmON0ZjzTHpN42HyI8+e8bqZnQN4VYmffJAju?=
 =?us-ascii?Q?v0A6QoYHGijhXXvMcu2Hxv5E/sTWRP2cxBWycNmE9pyOEOMms4xt6nZjNGuw?=
 =?us-ascii?Q?4qV9snIq/l5rxtwfdtLfU4IT75kdHhchUAl0LyCBpjwbUgmmZkQehQDV427v?=
 =?us-ascii?Q?RgYz8zG4B/hATNTLaHg9T/ejGL+pB1YJ8FJvPCpGW9CR4DhZ3IB0kCJuYbTs?=
 =?us-ascii?Q?sRG2FA+SOOzyxLzOYyOMq7NBHPAsMzFSSJuEDeFcRT2Jp4aqSbwVzk/J5hyH?=
 =?us-ascii?Q?9uZ1LscQZWHFyR1W+vvQGnqT+79LGs7AbMq+x1oXBBqHt8ak8yoAm4etdiLz?=
 =?us-ascii?Q?aK+/sxOXkjMO8J8FHuY609X1YTxnMmpLpFjxm57CiCV5CXD9wgs04jPIdLKm?=
 =?us-ascii?Q?DfLZAXjx7kR10DBOZKbRKFrorRLoSY85XWr2nlFC6xGeei5WarIScp4a3Ylb?=
 =?us-ascii?Q?2WenPB+ZAJYZebi0JbWV8hlKSGqTmoQG7G6nLSpwXCjcs3PjUI6/YeUYuhiA?=
 =?us-ascii?Q?JQa3E/S/Ehc8yApetZkSTI850NpMITlv1DajWHiym3pJytT6C8nr+db6VJrv?=
 =?us-ascii?Q?YKksku9tmr27JsnH4XIt6nu13SVtuxTIuYIOspag9G2IsI2zWpaK8KjJdDvl?=
 =?us-ascii?Q?qH3Z4lhVMGMHE7kITx5/yMniqFzJSG9mphLDsohp77SX9ONaGgU7AHW5g6QO?=
 =?us-ascii?Q?9M/b0eGj6mkemwLOlHzy8y8GkZeJlpS1eeRzXSlwtwaNpXOYA9XfiujhSUe1?=
 =?us-ascii?Q?sg5y8F0ROEz84Mc7lGvUzIndHl+jCDmxdhagHnFMA4oNNxw9KTiLkXRA5fMx?=
 =?us-ascii?Q?iG1CxEeTyc//QTr1OrsgJM9JjD/IqTtkRw886dREANWmh55jsGRpCKHBtSrJ?=
 =?us-ascii?Q?8S+oOplQYNQnBgs43qZHxvBX1Wf/AMb3ajF4ZlVT+V9EPeYwQTjo3ddzcS6r?=
 =?us-ascii?Q?0RP7MS8Fhbqei5LBPdCxmK1i9WEKViT3T57QrhEW2cqK0bRaQul5BmqKZSuu?=
 =?us-ascii?Q?/xE+un2h38keXMRX0IFSLb3ui62LiDNtv5amgzBHuTzLuiaDFyF+y1lyM2gz?=
 =?us-ascii?Q?oDJv/Abex8V+1Yrrjlz6joGpaxQL/0r/UtrKPU+p8Vr8PRSq6/cPvNM9znlc?=
 =?us-ascii?Q?ITFScxH+48VsMids8fOg+loDVOJmm1GAGjjybFwf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd3d07f-e0da-418c-e116-08dbe2c63bae
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2023 14:55:23.8943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBPajaQHpiSknrHoAIMFv23yWoeUHvNyNC6j79DQmuZUFZclZkhDm6f6P0m9R58pK0N+o2vRu2FXLMAgGutRVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7268
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 10:43:17PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
> commit: ee219b946e4bf7df2d2c68dfaae1bdaa360ec2ea uapi: turn __poll_t sparse checks on by default
> date:   5 years ago
> config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231111/202311112205.oMWYlOQe-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311112205.oMWYlOQe-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311112205.oMWYlOQe-lkp@intel.com/

Kindly ignore this report, the reported commit is not the cause of the
warning. Sorry for the false info.

> 
> sparse warnings: (new ones prefixed by >>)
>    kernel/events/core.c:570:26: sparse: sparse: function 'perf_pmu_name' with external linkage has definition
>    kernel/events/core.c:1034:1: sparse: sparse: symbol 'perf_cgroup_switch' was not declared. Should it be static?
>    kernel/events/core.c:1132:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got int * @@
>    kernel/events/core.c:1132:22: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
>    kernel/events/core.c:1132:22: sparse:     got int *
>    kernel/events/core.c:1139:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got int * @@
>    kernel/events/core.c:1139:22: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
>    kernel/events/core.c:1139:22: sparse:     got int *
>    kernel/events/core.c:1382:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/events/core.c:1382:15: sparse:    struct perf_event_context [noderef] <asn:4> *
>    kernel/events/core.c:1382:15: sparse:    struct perf_event_context *
>    kernel/events/core.c:1395:28: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/events/core.c:1395:28: sparse:    struct perf_event_context [noderef] <asn:4> *
>    kernel/events/core.c:1395:28: sparse:    struct perf_event_context *
>    kernel/events/core.c:3083:18: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/events/core.c:3083:18: sparse:    struct perf_event_context [noderef] <asn:4> *
>    kernel/events/core.c:3083:18: sparse:    struct perf_event_context *
>    kernel/events/core.c:3084:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/events/core.c:3084:23: sparse:    struct perf_event_context [noderef] <asn:4> *
>    kernel/events/core.c:3084:23: sparse:    struct perf_event_context *
>    kernel/events/core.c:3115:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/events/core.c:3115:25: sparse:    struct perf_event_context [noderef] <asn:4> *
>    kernel/events/core.c:3115:25: sparse:    struct perf_event_context *
>    kernel/events/core.c:3116:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/events/core.c:3116:25: sparse:    struct perf_event_context [noderef] <asn:4> *
>    kernel/events/core.c:3116:25: sparse:    struct perf_event_context *
>    kernel/events/core.c:3139:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
>    kernel/events/core.c:3139:43: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
>    kernel/events/core.c:3139:43: sparse:     got struct perf_cpu_context *
>    kernel/events/core.c:3150:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
>    kernel/events/core.c:3150:43: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
>    kernel/events/core.c:3150:43: sparse:     got struct perf_cpu_context *
>    kernel/events/core.c:4119:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
>    kernel/events/core.c:4119:26: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
>    kernel/events/core.c:4119:26: sparse:     got struct perf_cpu_context *
> >> kernel/events/core.c:4881:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __poll_t [usertype] events @@     got int @@
>    kernel/events/core.c:4881:24: sparse:     expected restricted __poll_t [usertype] events
>    kernel/events/core.c:4881:24: sparse:     got int
>    kernel/events/core.c:5068:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/events/core.c:5068:22: sparse:    struct ring_buffer [noderef] <asn:4> *
>    kernel/events/core.c:5068:22: sparse:    struct ring_buffer *
>    kernel/events/core.c:5197:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/events/core.c:5197:14: sparse:    struct ring_buffer [noderef] <asn:4> *
>    kernel/events/core.c:5197:14: sparse:    struct ring_buffer *
>    kernel/events/core.c:5230:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/events/core.c:5230:14: sparse:    struct ring_buffer [noderef] <asn:4> *
>    kernel/events/core.c:5230:14: sparse:    struct ring_buffer *
>    kernel/events/core.c:5287:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/events/core.c:5287:14: sparse:    struct ring_buffer [noderef] <asn:4> *
>    kernel/events/core.c:5287:14: sparse:    struct ring_buffer *
>    kernel/events/core.c:5373:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/events/core.c:5373:14: sparse:    struct ring_buffer [noderef] <asn:4> *
>    kernel/events/core.c:5373:14: sparse:    struct ring_buffer *
>    kernel/events/core.c:5386:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/events/core.c:5386:14: sparse:    struct ring_buffer [noderef] <asn:4> *
>    kernel/events/core.c:5386:14: sparse:    struct ring_buffer *
>    kernel/events/core.c:6646:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/events/core.c:6646:23: sparse:    struct perf_event_context [noderef] <asn:4> *
>    kernel/events/core.c:6646:23: sparse:    struct perf_event_context *
>    kernel/events/core.c:6736:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/events/core.c:6736:13: sparse:    struct ring_buffer [noderef] <asn:4> *
>    kernel/events/core.c:6736:13: sparse:    struct ring_buffer *
>    kernel/events/core.c:6744:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
>    kernel/events/core.c:6744:43: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
>    kernel/events/core.c:6744:43: sparse:     got struct perf_cpu_context *
>    kernel/events/core.c:7399:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/events/core.c:7399:23: sparse:    struct perf_event_context [noderef] <asn:4> *
>    kernel/events/core.c:7399:23: sparse:    struct perf_event_context *
>    kernel/events/core.c:8079:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/events/core.c:8079:9: sparse:    struct swevent_hlist [noderef] <asn:4> *
>    kernel/events/core.c:8079:9: sparse:    struct swevent_hlist *
>    kernel/events/core.c:9408:35: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct perf_cpu_context [noderef] <asn:3> * @@     got struct perf_cpu_context *[noderef] pmu_cpu_context @@
>    kernel/events/core.c:9408:35: sparse:     expected struct perf_cpu_context [noderef] <asn:3> *
>    kernel/events/core.c:9408:35: sparse:     got struct perf_cpu_context *[noderef] pmu_cpu_context
>    kernel/events/core.c:9425:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:3> *__pdata @@     got struct perf_cpu_context *[noderef] pmu_cpu_context @@
>    kernel/events/core.c:9425:24: sparse:     expected void [noderef] <asn:3> *__pdata
>    kernel/events/core.c:9425:24: sparse:     got struct perf_cpu_context *[noderef] pmu_cpu_context
>    kernel/events/core.c:9440:1: sparse: sparse: symbol 'dev_attr_nr_addr_filters' was not declared. Should it be static?
>    kernel/events/core.c:9491:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
>    kernel/events/core.c:9491:26: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
>    kernel/events/core.c:9491:26: sparse:     got struct perf_cpu_context *
>    kernel/events/core.c:9570:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int *[noderef] pmu_disable_count @@     got int [noderef] <asn:3> * @@
>    kernel/events/core.c:9570:32: sparse:     expected int *[noderef] pmu_disable_count
>    kernel/events/core.c:9570:32: sparse:     got int [noderef] <asn:3> *
>    kernel/events/core.c:9610:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct perf_cpu_context *[noderef] pmu_cpu_context @@     got struct perf_cpu_context [noderef] <asn:3> * @@
>    kernel/events/core.c:9610:30: sparse:     expected struct perf_cpu_context *[noderef] pmu_cpu_context
>    kernel/events/core.c:9610:30: sparse:     got struct perf_cpu_context [noderef] <asn:3> *
>    kernel/events/core.c:9615:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct perf_cpu_context *[noderef] pmu_cpu_context @@     got struct perf_cpu_context [noderef] <asn:3> * @@
>    kernel/events/core.c:9615:30: sparse:     expected struct perf_cpu_context *[noderef] pmu_cpu_context
>    kernel/events/core.c:9615:30: sparse:     got struct perf_cpu_context [noderef] <asn:3> *
>    kernel/events/core.c:9622:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
>    kernel/events/core.c:9622:26: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
>    kernel/events/core.c:9622:26: sparse:     got struct perf_cpu_context *
>    kernel/events/core.c:9675:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:3> *__pdata @@     got int *[noderef] pmu_disable_count @@
>    kernel/events/core.c:9675:24: sparse:     expected void [noderef] <asn:3> *__pdata
>    kernel/events/core.c:9675:24: sparse:     got int *[noderef] pmu_disable_count
>    kernel/events/core.c:9696:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:3> *__pdata @@     got int *[noderef] pmu_disable_count @@
>    kernel/events/core.c:9696:24: sparse:     expected void [noderef] <asn:3> *__pdata
>    kernel/events/core.c:9696:24: sparse:     got int *[noderef] pmu_disable_count
>    kernel/events/core.c:10897:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
>    kernel/events/core.c:10897:20: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
>    kernel/events/core.c:10897:20: sparse:     got struct perf_cpu_context *
>    kernel/events/core.c:10898:20: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
>    kernel/events/core.c:10898:20: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
>    kernel/events/core.c:10898:20: sparse:     got struct perf_cpu_context *
>    kernel/events/core.c:11068:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/events/core.c:11068:9: sparse:    struct perf_event_context [noderef] <asn:4> *
>    kernel/events/core.c:11068:9: sparse:    struct perf_event_context *
>    kernel/events/core.c:11178:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/events/core.c:11178:17: sparse:    struct perf_event_context [noderef] <asn:4> *
>    kernel/events/core.c:11178:17: sparse:    struct perf_event_context *
>    kernel/events/core.c:11566:6: sparse: sparse: symbol 'perf_swevent_init_cpu' was not declared. Should it be static?
>    kernel/events/core.c:11631:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
>    kernel/events/core.c:11631:26: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
>    kernel/events/core.c:11631:26: sparse:     got struct perf_cpu_context *
>    kernel/events/core.c:156:9: sparse: sparse: context imbalance in 'perf_ctx_lock' - wrong count at exit
>    kernel/events/core.c:164:17: sparse: sparse: context imbalance in 'perf_ctx_unlock' - unexpected unlock
>    kernel/events/core.c:149:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
>    kernel/events/core.c:149:16: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
>    kernel/events/core.c:149:16: sparse:     got struct perf_cpu_context *
>    kernel/events/core.c:149:16: sparse: sparse: dereference of noderef expression
>    kernel/events/core.c:149:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
>    kernel/events/core.c:149:16: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
>    kernel/events/core.c:149:16: sparse:     got struct perf_cpu_context *
>    kernel/events/core.c:149:16: sparse: sparse: dereference of noderef expression
>    kernel/events/core.c:1132:22: sparse: sparse: dereference of noderef expression
>    kernel/events/core.c:1139:22: sparse: sparse: dereference of noderef expression
>    kernel/events/core.c: note: in included file (through include/linux/rculist.h, include/linux/dcache.h, include/linux/fs.h):
>    include/linux/rcupdate.h:686:9: sparse: sparse: context imbalance in 'perf_lock_task_context' - different lock contexts for basic block
>    kernel/events/core.c:1429:17: sparse: sparse: context imbalance in 'perf_pin_task_context' - unexpected unlock
>    kernel/events/core.c:149:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] <asn:3> *__vpp_verify @@     got struct perf_cpu_context * @@
>    kernel/events/core.c:149:16: sparse:     expected void const [noderef] <asn:3> *__vpp_verify
>    kernel/events/core.c:149:16: sparse:     got struct perf_cpu_context *
>    kernel/events/core.c:149:16: sparse: sparse: dereference of noderef expression
>    kernel/events/core.c:2538:9: sparse: sparse: context imbalance in '__perf_install_in_context' - wrong count at exit
> --
> >> kernel/events/ring_buffer.c:22:39: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int i @@     got restricted __poll_t [usertype] @@
>    kernel/events/ring_buffer.c:22:39: sparse:     expected int i
>    kernel/events/ring_buffer.c:22:39: sparse:     got restricted __poll_t [usertype]
>    kernel/events/ring_buffer.c:137:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/events/ring_buffer.c:137:14: sparse:    struct ring_buffer [noderef] <asn:4> *
>    kernel/events/ring_buffer.c:137:14: sparse:    struct ring_buffer *
>    kernel/events/ring_buffer.c:137:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/events/ring_buffer.c:137:14: sparse:    struct ring_buffer [noderef] <asn:4> *
>    kernel/events/ring_buffer.c:137:14: sparse:    struct ring_buffer *
>    kernel/events/ring_buffer.c:137:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    kernel/events/ring_buffer.c:137:14: sparse:    struct ring_buffer [noderef] <asn:4> *
>    kernel/events/ring_buffer.c:137:14: sparse:    struct ring_buffer *
>    kernel/events/ring_buffer.c:105:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
>      105 | static bool __always_inline
>          | ^~~~~~
>    kernel/events/ring_buffer.c:116:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
>      116 | static int __always_inline
>          | ^~~~~~
>    kernel/events/ring_buffer.c:416:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
>      416 | static bool __always_inline rb_need_aux_wakeup(struct ring_buffer *rb)
>          | ^~~~~~
> 
> vim +4881 kernel/events/core.c
> 
> 0793a61d4df8da kernel/perf_counter.c Thomas Gleixner           2008-12-04  4862  
> 9dd957485d7d89 kernel/events/core.c  Al Viro                   2017-07-03  4863  static __poll_t perf_poll(struct file *file, poll_table *wait)
> 0793a61d4df8da kernel/perf_counter.c Thomas Gleixner           2008-12-04  4864  {
> cdd6c482c9ff9c kernel/perf_event.c   Ingo Molnar               2009-09-21  4865  	struct perf_event *event = file->private_data;
> 76369139ceb955 kernel/events/core.c  Frederic Weisbecker       2011-05-19  4866  	struct ring_buffer *rb;
> a9a08845e9acbd kernel/events/core.c  Linus Torvalds            2018-02-11  4867  	__poll_t events = EPOLLHUP;
> c7138f37f905bb kernel/perf_counter.c Peter Zijlstra            2009-03-24  4868  
> e708d7ad807374 kernel/events/core.c  Sebastian Andrzej Siewior 2014-08-04  4869  	poll_wait(file, &event->waitq, wait);
> 179033b3e064d2 kernel/events/core.c  Jiri Olsa                 2014-08-07  4870  
> dc633982ff3f4f kernel/events/core.c  Jiri Olsa                 2014-09-12  4871  	if (is_event_hup(event))
> 179033b3e064d2 kernel/events/core.c  Jiri Olsa                 2014-08-07  4872  		return events;
> c7138f37f905bb kernel/perf_counter.c Peter Zijlstra            2009-03-24  4873  
> 10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra            2011-11-26  4874  	/*
> 9bb5d40cd93c9d kernel/events/core.c  Peter Zijlstra            2013-06-04  4875  	 * Pin the event->rb by taking event->mmap_mutex; otherwise
> 9bb5d40cd93c9d kernel/events/core.c  Peter Zijlstra            2013-06-04  4876  	 * perf_event_set_output() can swizzle our rb and make us miss wakeups.
> 10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra            2011-11-26  4877  	 */
> 10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra            2011-11-26  4878  	mutex_lock(&event->mmap_mutex);
> 9bb5d40cd93c9d kernel/events/core.c  Peter Zijlstra            2013-06-04  4879  	rb = event->rb;
> 9bb5d40cd93c9d kernel/events/core.c  Peter Zijlstra            2013-06-04  4880  	if (rb)
> 76369139ceb955 kernel/events/core.c  Frederic Weisbecker       2011-05-19 @4881  		events = atomic_xchg(&rb->poll, 0);
> 10c6db110d0eb4 kernel/events/core.c  Peter Zijlstra            2011-11-26  4882  	mutex_unlock(&event->mmap_mutex);
> 0793a61d4df8da kernel/perf_counter.c Thomas Gleixner           2008-12-04  4883  	return events;
> 0793a61d4df8da kernel/perf_counter.c Thomas Gleixner           2008-12-04  4884  }
> 0793a61d4df8da kernel/perf_counter.c Thomas Gleixner           2008-12-04  4885  
> 
> :::::: The code at line 4881 was first introduced by commit
> :::::: 76369139ceb955deefc509e6e12ce9d6ce50ccab perf: Split up buffer handling from core code
> 
> :::::: TO: Frederic Weisbecker <fweisbec@gmail.com>
> :::::: CC: Ingo Molnar <mingo@elte.hu>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
