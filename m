Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECB87E329E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 02:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjKGBcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 20:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGBcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 20:32:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1923103
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 17:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699320726; x=1730856726;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=L6+qo29snDL3+L4QwouZpwtx+vK0jh3BWfgQhRjhoJQ=;
  b=YUByWIjcHaxqGi3YAQRsIF13QEkFXDKI7yek2jwkztkr7U4KxMYgQz2R
   GQ4XX2QIe9rVkItJvScNYfO80jmb4hPFP1p/kD/C9DJD4AbJ1y2kKUTy3
   WNSwaI/1jiq+M60MxqnzfcpLwTGn6t1pMDg/jZN9CxuzOx3n+jcp4fZH5
   RX02/yZMJW3MIC3yNJLZfdJ8ErB5npDaPkAXhvjta6TwSA1wewYVljPml
   7Jyez7EyaTj+DEn9xudemVpfMjXibi3qqkWIPXV0xk98fy+JO8meV0cSa
   +BxjKzsSEyWSSDBXagY2IvbiGuySIPjFoIHXIX0TKBRdDeudX1kKEHFuo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="2404395"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="2404395"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 17:32:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="762502570"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="762502570"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 17:32:03 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 17:32:03 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 17:32:02 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 17:32:02 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 17:32:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBe/QV6rQ0U4/8/JwxhhCI6uPB7wkyBU+/FBjA7vCg1iHvF3G2/EVr1sOFIEdVCCMQUNQSitdYmNGNSA775IbXahZ4SKKhFJSzRS9GgWLRSi4ftUvMtJFcye4BavgtOcuy7cVU4wS8M0UwC/ZgmGrJwHvzOPyO5p818vuh+w3kiBeYqGKMB6c/pPCBAI38Mp++iIjUYzdiaLkej0GW9L5iEbo7MBCtdZ5l/QjVZGkosh0xMSYwmuS576d6VmwrPzzOb4qk6b8+L9Oq2hGCWunyXoZERP6nP0GbhxJWuCFYECQ4QbNGGtyQfUtqqYLboLAAPL40c6voajKNnI+uGWEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZL68vgeywVzjzXdYoPNoPot0b7rttpZ/hhkY1ORG4WQ=;
 b=BEau4ZktlqyNtGKwX+KXcaxDebJ+/5uMOjHX9CnLV8MmOEnqJtb+4ulcM+ECK9+K+ywYnD5+NICt2LQfJNuETSW1mqgOHhlvuBAWHLt7WiN3dHCGrGmVFDMs8FN+cEgPsDrL7vWB41FEBlGzDXyjiEPunycJ/nEwsPGYZ8Gd3xLxe80dWBRa3Ojwd8NMj+VyatFftbl41TpE8YWJIpb0ao9lEAs1imz8LfyPvvyLSM7E3BbEhr45DvcPz+K5Mt/OHzu+qC6aYvngdqh0QLYmCQ64Mv7gQu3qJ9YYOQbHJBXyDEkJ5FOIuJn2VUPoI86o2KaADhse/J8gAfzSnn3qmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CH3PR11MB7764.namprd11.prod.outlook.com (2603:10b6:610:145::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 01:32:01 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.6933.028; Tue, 7 Nov 2023
 01:32:00 +0000
Date:   Tue, 7 Nov 2023 09:27:18 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: drivers/comedi/drivers/tests/../ni_stc.h:1140:35: warning:
 'range_ni_E_ao_ext' defined but not used
Message-ID: <ZUmSdrIFnGloqGz0@yujie-X299>
References: <202311060001.aEuf1q9y-lkp@intel.com>
 <2023110641-profusely-factor-b3c5@gregkh>
 <ZUiybtcMJGI5ZCF5@yujie-X299>
 <2023110639-overbuilt-caliber-28ef@gregkh>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023110639-overbuilt-caliber-28ef@gregkh>
X-ClientProxiedBy: SG2PR06CA0213.apcprd06.prod.outlook.com
 (2603:1096:4:68::21) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CH3PR11MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: b22a6afb-8195-40c3-9592-08dbdf3156dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6rUbzlfzjHiVAFjOXIMoiEHFiqKuWXHFFKRC3xSgN3s89EjQRu2mKVvn4hYoni7Img9ocLPoSUxbBmew9V3U4L4QmkiQE33w+RBXAqmqh+nF/rNiamZ1oUUQc9x9IcvUY5qCqHM9bImTSPNdgaR1REC0gHF5pU0pIL5RxFUU3ticwcm8LfQ/TjJSEI1zHhqgn3ureKwDOx2QoBeWWLR71vfgJOpMD/fNnTdC1xKRSD18xOC4Aj11co3PBwpFwKxSXoVDP0P/WE7cvqwm5o1cYxZhZWOJqpeV0Ul0RGeVaVSxY9AG9AiEph9/0uaVudH3xxiIxg+H45b/sTeGREqpoZjMnhuacXJHVFkGq6ykALXs2TIVRPvGqhkWLDDKWiMuYm9lv26c+e7KxP9ICSQeQOq5QY4ClVuGk0Hwyq1YoHfPEhH2L5ACETTWAK5SNS37zUg+kBx4WbnnDjTgrTscexSzF8Am8kXjdqL7HHt/aTKselUSHh2LO3JvKJw/oUHZH8YWn0rSWRrg5lS7Xak6QvU+OCg32DQf+XvI5hb9ncaSgN5eqmuslG8ZSEdmfgoV3B+o2NJqBmNL5/JcetEVEYepls5nWNtv9r6H5ZHxno=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799009)(451199024)(64100799003)(2906002)(6666004)(6506007)(9686003)(6512007)(6486002)(478600001)(966005)(38100700002)(86362001)(82960400001)(41300700001)(5660300002)(66476007)(33716001)(83380400001)(66556008)(26005)(66946007)(316002)(8676002)(44832011)(6916009)(8936002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGJhdzhvWDNHdzEzU3g4cGhTTlFSQm1tcktHZU92emNhSUJBcXhmb09OMzlU?=
 =?utf-8?B?Y2RCMXF2bEtRQ3RTUDNqaDZEWDFRKzVLWnVmUy83ZXRId2s5RGpzV042cHZS?=
 =?utf-8?B?V2c2RC8xQnJnWjRhcVJqQUVhQWI1UFJqYks2NlNhN3ZpbU0xalRvTjRwNHps?=
 =?utf-8?B?enRtdlFtMnY4dTJ3QUV4NW9lMlJPbXVwMnJnaXM1cm9vakJ1T2tmcmM2MlZS?=
 =?utf-8?B?eHpPeXNhWC80ZDFGS1NvKzAxb2lDVmlqd1dIaUpzQnJyeVNyRzRyaEdieisy?=
 =?utf-8?B?ZVU0RnZEYnJqUk13UkFRcFpMblNmWHFDQW95T3R5SFNkMHhUanViQlJTeG1F?=
 =?utf-8?B?Qjg2eXhabHJ2Vy9LZ2twemZXcXRXUXJBdXdFMGtoY2doemlaOG8yenpXclhm?=
 =?utf-8?B?MnNWaXJzQmZZNnMvZDR3aGpmSmlKSldXTlRCMWk1WXQ2T21lbjRSMkVBQUcw?=
 =?utf-8?B?ZHkzLy9zKy9oUXJJUXc2Yjk0dDVpa01XVWpSbDlOYWk4R0RlWGdsdGdzV0xv?=
 =?utf-8?B?Q2tlNGpXN3hRcEZQMjdpRVlCLzdaV0VVbFVOaFJjamE4bG9TWW9NVk10ekpG?=
 =?utf-8?B?L3E3dWJndnk3ZHRZL285RDNQR2Q5and6UnVOL1FCMVAwdXN2cWZQRFhncXJB?=
 =?utf-8?B?aXQvY3JFbzhIMWtMOWtVWXlrT0oyWmxiNFR5UnpYYWMzbXIyZzFrYzY3RS9I?=
 =?utf-8?B?S3dHbUxhMSt0alhKZVpXcDFIMTNJUGxFaFVrWUkxRlVlZ0tPYVgyT3FDV3JZ?=
 =?utf-8?B?VjBieWk4ZGlMdG4xNE1wZ0pTTGliVDZ3clhqdmllZitzZVVmSVYvMEM2emhE?=
 =?utf-8?B?cm5HTnlOaTB4aEZidHZocUtBd2xybEwxaktUYjFQRWpNSUx0b2E0UEpHUUc0?=
 =?utf-8?B?czcwS013dXlXSlphY3ErTWRqREcweWRkOEUzYmFuTWsrcGs4SjlGRkxNWkVT?=
 =?utf-8?B?SnpyZk02eDA4U0JETTNDYkNraVBxVTI3TlE5S0U4Ym1QaHhNOUtHSlUvalZh?=
 =?utf-8?B?bFdTaU9GeUI4WDRqRWJTMnVLTEI4R0MzNXAyUU92TE45TlpLNGdremo5c3M0?=
 =?utf-8?B?R1ZHbnhXZDQ5Y1hLSkNNQmthNGZrVGhLeHc4dHpGMnYzWU5pODE2dVRHQU9M?=
 =?utf-8?B?SEZrRjBmWmo2UlU0TlBVUWhDZDRvZGhUcjl5bVRFZXRya1ZaWWJwUXpzZWtH?=
 =?utf-8?B?K0E2K0ZOb1l0dXVxZk95SXdjLzYzVDJVcDBhTWFBS1dvbkc0T1FqQ3YyL0Vh?=
 =?utf-8?B?VVJIVi9mU0o4djJBV0VXVmwzNzFwN0h2akxpNVZxa2M2YnpMNlJSWThtNFN0?=
 =?utf-8?B?KzZESjE1S2dBUUtuYTlmOGJHeUVlbG9scmxMcHdwek16RXg0My9zSk51T0RO?=
 =?utf-8?B?UTZ3Rm0xejVTZ05RZUZBUnhEdG1YNzMzcnp6dkJnbHdYVkpJYmthd0JtcHBS?=
 =?utf-8?B?dkdYOThxTC9Kam1ianQzVWgrbkxXajBVQ1EyMGVtd2hlTnMyNjN1RU0yV0xV?=
 =?utf-8?B?c0FPVkdsRFBicU9aNFl6RVY5RVNHVG83dWdYNnlibGQ1c1k3eitYUFRVR0lL?=
 =?utf-8?B?Z0JMMGowYUZSZnExQ0lSeS9aY3d0SzN5Z1IweTZUTHZnbi9jN3NXdjRJb1Rt?=
 =?utf-8?B?Z0tjY0JSR291bWpTbUN1bjYwZVNmNHJsd05HeWsyQ3Q0QUNsSm9wQklWaUN0?=
 =?utf-8?B?dFo5Y1NkMkRZcmMyUThtV1NYMFU0a2dkQ0N3M0daY2RWUHMveDNnSzBPdy9o?=
 =?utf-8?B?OEF0dDIrdUhaWVFiUkRDWlUzWFp0MFl3UzJYVUtSS0FGY0laK1ZnRW50Wkpp?=
 =?utf-8?B?cEZLVjNnS0x1QXB4bE5SMy9EV3RDMFA5bGdFMy9wYnNwZ0QyQlcrcEZlbTlN?=
 =?utf-8?B?R1VCZjQwYnJnVlo2SVNPR1h4RjYva3duNTBaYkVHK2thV0h6Vk9QSmo4bDRN?=
 =?utf-8?B?cmQrc3B6dWR0K0xqN01GUEFuelRlYnNMaEZpb3ltN1FrTGplRXFkYklmUWRS?=
 =?utf-8?B?cGtGVzR6d0VhYlhMaDh3RmJRNkkwM0IzVGpnWVlKbUdaL1g5NjRRaG9aZmFq?=
 =?utf-8?B?eVVKQ0RUR1RHdUpqbHpZczRSZ0VHU0RGMFRrT2FHOWxRVlVUOVZFeFEzZklG?=
 =?utf-8?Q?gxh75MaQ6f/Fjtmd2bKhlT990?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b22a6afb-8195-40c3-9592-08dbdf3156dd
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 01:32:00.8838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMzn3nCjxxgs/RXihyQLy1bIHeaBnOyoWYf2mrkPUn/5XSuWn/aRqagIxjvkd6nhn1kJvnLk9hRR013QmBYUFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7764
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

On Mon, Nov 06, 2023 at 10:48:57AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Nov 06, 2023 at 05:31:26PM +0800, Yujie Liu wrote:
> > Hi Greg,
> > 
> > On Mon, Nov 06, 2023 at 10:00:14AM +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Nov 06, 2023 at 04:49:17PM +0800, kernel test robot wrote:
> > > > Hi Greg,
> > > > 
> > > > kernel test robot noticed the following build warnings:
> > > > 
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > head:   1c41041124bd14dd6610da256a3da4e5b74ce6b1
> > > > commit: 8ffdff6a8cfbdc174a3a390b6f825a277b5bb895 staging: comedi: move out of staging directory
> > > > date:   2 years, 7 months ago
> > > 
> > > Have you tested a newer kernel?  Testing a 2 1/2 year old commit feels
> > > odd to me, was this intentional?
> > 
> > We did test new kernels with W=1, and the issue was captured by the
> > bot, then bisected to this 2 years 7 months ago commit that was likely
> > to introduce this issue initially.
> 
> This commit is a "move files around" commit, so it obviously was not the
> original problem commit here :)
> 
> > We have no intention of directly
> > testing a very old commit, and we're sorry that the date info may
> > cause some misunderstanding.
> > 
> > This can be reproduced by allyesconfig build on v6.6 with W=1:
> > 
> > $ git checkout v6.6
> > HEAD is now at ffc253263a13 Linux 6.6
> > 
> > $ make ARCH=x86_64 allyesconfig
> > 
> > $ make W=1 ARCH=x86_64 drivers/comedi/drivers/tests/ni_routes_test.o
> > ...
> >   CC      drivers/comedi/drivers/tests/ni_routes_test.o
> > In file included from drivers/comedi/drivers/tests/ni_routes_test.c:22:
> > drivers/comedi/drivers/tests/../ni_stc.h:1140:35: error: ‘range_ni_E_ao_ext’ defined but not used [-Werror=unused-const-variable=]
> >  1140 | static const struct comedi_lrange range_ni_E_ao_ext;
> >       |                                   ^~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> 
> This is odd in that a static constant is being defined in a .h file, so
> anything that happens to include it, like this test, will then need to
> use it in order to silence this warning.  I don't think that's going to
> happen any time soon, so it's good that we don't really care aobut W=1
> just yet :)

Thanks a lot for the information. We will learn from this case and be
more careful when handling similar reports on "old commits", thus to
reduce false positives.

Best Regards,
Yujie
