Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02367C57E3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjJKPQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjJKPQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:16:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E51CA4;
        Wed, 11 Oct 2023 08:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697037410; x=1728573410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gV4F1BuXbFi21nC1RnNLHQXO6eTmsyt4ty2MJwH+8/4=;
  b=nyonGmAFKh4A/JRiYvXMDIKKP0mExqDFZk0BK7TqXscH1zmoFDb6ZMoC
   TvrqCkfd/F3VzrEcMPyKfogGyOAdsjtYujQ3Ghs0f9diGM1VpJyODg3nP
   i2T/Dnxazw9rem47/c3y+RcrSShXNjQnnedZP/eZvKIXGmbDEqHjpmbNm
   kNLDPoIiGt4SUs6I4ITWm68AbsUT4gY4md49nPA8JiJLcxDRVTQVor7ye
   RaMGXEIXo0sOm9p96N5BuwiFsCE4Qtzwxhj3qTSNLyg+gIaZ8/uCD0gYx
   uVFrX3cVgy0DxcB9Mj/1h2jJ7MPfG8Z+6QeUWTtcRMehrWIUSNG9C3Rmf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="451183149"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="451183149"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 08:16:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="730537609"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="730537609"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 08:16:49 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 08:16:49 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 08:16:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 08:16:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 08:16:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeLBiAo6e1VZZZ7G+HaBYPqQHOI5E5QS2C97C9p309X8skIjoZ7juA8zOaD3wn5lhDno8cbQ2Cw7gSxw83JASEBAP+7WBkFlKOGDJgFvuXt3vedJDdbro4t8rFPpwhyqrVEInBy7RcVQ8N/wHI6q9AO6I8LdA6OeYifH0YAju0O6fLRyP0B6U4SZXo53R1fRLoioeUYPZBvK1WyOBY+0lXOgEi8RzG8JoRt2YF0hAe+cIx5TLyUnJTvoy2BdHZt5F63rjGWCfQvkRsaR3dIY2pOFtn4yEeF72l6eY2qo36lnRNa4I6/ZVO4G/AoeY/RlWHXKavlst/NPo3A/WQDHZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8D4n4zU9RMv1ITknYqtuR8D7ctKViV/VUxXQ2BTYr8=;
 b=NMOv4TL9Kn2B9pDiH8MmBXxWf+nYryBa8mRdZVWP9+zBnr0etzsp9TQ9sWPdYf+ecUhDQNK4vo1vrkvn6vLevm1Guur792Tly4KnBcVl6caOx0pIvuwCkArgwaisI3Kwml5aIg06VQf3NFi1XRKaoAm8PziohGDHmJfyb8THfblyPJCuah58Tqb4Q0lHRocwz3oVJrAmV84tiD4032q3YVi8L2gj+9wult1UFhGEWzVzOcA4AY1FN3P/RJWML4Agx+2CXkcAmAZZncRTy9PxQ22//BHDzseVjF9sv8pA2zsC2Z+Ndy1V1QAtNeN55ZQ/J/4WJVFafkUb27Xy6JIgEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB4860.namprd11.prod.outlook.com (2603:10b6:806:11b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Wed, 11 Oct
 2023 15:16:47 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7316:13b0:88bc:b3c8]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7316:13b0:88bc:b3c8%4]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 15:16:46 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Sang, Oliver" <oliver.sang@intel.com>
CC:     "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
Thread-Topic: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
Thread-Index: AQHZ9vG7TU6w8G+TdkO4n2sYy/mmYrBEV9iAgABlLAA=
Date:   Wed, 11 Oct 2023 15:16:46 +0000
Message-ID: <SJ1PR11MB6083D191286779302821A7EAFCCCA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231004183623.17067-3-tony.luck@intel.com>
 <202310111637.dee70328-oliver.sang@intel.com>
In-Reply-To: <202310111637.dee70328-oliver.sang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA2PR11MB4860:EE_
x-ms-office365-filtering-correlation-id: eb84bbf1-881e-4b08-cfcb-08dbca6d15c8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: od0eLQKsQk9f8py3a9Rtp9f1CVzKPn01zXRAel5VPIa7//h2DJ7DPKy7qX7bVd5MasPoSai3tlpQYx3+BNpz3q4icxvCVLIkPQutW3IO5LT8w9fb9ROeGnJajB6QfYB3XSTB8j7vZOuLjQ5xxDMZC1iHRQCGZZtE0+q9vTFx5mhRFd0AnNnjZheG/8rTkzS/p3byL+jdVlG/CGHQ1rOSyqX5kgDwybT0neQ4bmIIrL/VaUg7RimBtlR8UuYXqdIU2wc+/iNrz6S53+BZI3nEB1o4zaB3pkE1DrTHh304VC/WSc594/k+TQQOK5RPGaQxHgcAf/H7I/nU5DqJd5JsiJAB7fD3Yc/nIkWoddtj3F7Xw81uiUQDL8Pq1QpklbsggUOeGiir514DNHlkjzhi3lKQkREGOVry7LMXjFfVM27k7KsgBqiEw021rPsKOLMfAD0tUJFL6O/R57FWtv1/sCEwejDwLApOWm0wL1faNVlpMq33Aam+UORvPQTG3lQwE3jtFFrTyz4GWSdwUmuKL7Lt45dQYhBpkg3Y6Ac88r7Wsku2A2iiDQfARhQXTlQSGhYHYf9//9hAb5Yl1UIprwJfG6Ia1NHXzqJzroJ7bU2iyU6/y3JptQzHdbacYI9tr4ZnsPb5oUaq+LtcwZhRMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(9686003)(26005)(7696005)(6506007)(83380400001)(71200400001)(55016003)(966005)(478600001)(8936002)(8676002)(6862004)(5660300002)(4326008)(41300700001)(38100700002)(82960400001)(38070700005)(122000001)(2906002)(52536014)(33656002)(86362001)(15650500001)(66556008)(66476007)(66446008)(64756008)(54906003)(66946007)(76116006)(6636002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gSY+7jofN+nCplZBozQRBcd/pGSR/ZV5J74jccVfN+jKSVFfzftyXhf0Csst?=
 =?us-ascii?Q?TT8qBKcxEpsz+in7/w7yMZBslGAo18lBRik0mw8jP2SOoGv+zhQzgAncKIJU?=
 =?us-ascii?Q?uz0lFSrSFpWY62AXeBEZskkUx/csstfEOIivsyHkhctFckfNmm7vSMQTo1Sn?=
 =?us-ascii?Q?Ur5iXeUnroOY4J/8zec7RMpiR83dyjASr8krXa2rQ2BdSH8Kkn7eVKa//OLt?=
 =?us-ascii?Q?0uoeCervwZSGOXHUHbcWywoe7hE1Ho2EUWulyyVaqlTxqxYbA1f8TcPY3r18?=
 =?us-ascii?Q?q8BOOxLPxrlUGamwNBqnKm97Xl9+JCj4QDNVn5cTv9msFWE04arAoWBnjjdQ?=
 =?us-ascii?Q?JOozA+Zbm8uKvpH9J4Kivl6KgoqGI/lz+yzNtGUhzLLlAxph7ukkEseUaaQF?=
 =?us-ascii?Q?0eAQrpaKeB+/vNQAfcNZVNC9H9md0MDL41ELwfAXIcDmPjujfwb0D6al3+j2?=
 =?us-ascii?Q?QmkBhpTIsvq8Bhc40bi+oywJXOgJlHKVSuqESR6DQeDDvnyRQDtyCckk8rWJ?=
 =?us-ascii?Q?GiohdfWIR1dDLeRIcWXlNY5irtDda7jVUMstez+FSosgnlCOrUH98ykL7TVr?=
 =?us-ascii?Q?Gu2z8FSrktkisVenNUxacTXr5VRX3ncMHmw34BecGIdxc/NQ397wxku7cNFT?=
 =?us-ascii?Q?IoeyvWtMrEdbh1kyX+bL0QG6mqBRaabUEvk2KVl2LW7IZ9iZ6ato31SUkDY4?=
 =?us-ascii?Q?cYaJeTwjyGjxeAUXqXU47wbeWqAjEsmAqTW4eClWSiyIOlnyod7em5/TJzB8?=
 =?us-ascii?Q?6TBWenW+iMJDLhiPXqij0rxSA74FbYR3fahDgB+vhGuheHD9bvAy392djX5O?=
 =?us-ascii?Q?PZiFzOR2STbqbUshW5iuprBlRotzXJKQlD4cG/HpRwGKt08wU8dm3QNJfKVh?=
 =?us-ascii?Q?5sIMuqSXE0yCNqE7XZmgpHsKh32ORvdFGUCHrGa7+QEPaNv1aQby9kbepZKB?=
 =?us-ascii?Q?D1Rwf6dDCyb19RW3NFGcEZqB/GT6PMz/pY9r8r3VbYCUIKFW60Dr/hYn4bEi?=
 =?us-ascii?Q?UK9sjVFou3Nr+sLwvV2pYeOuWlNCTE5zYOt5d0FTC5zxkQfXoqang4QTxFh6?=
 =?us-ascii?Q?ZAnvTMsjGsuFy8lVC+GRvmdfIevmxQ7DWzjQNUSAKEgDS+kvd1xtzYpMIWrV?=
 =?us-ascii?Q?iDAZd4XiV4xi9cgsAwVunnlar+WO5cmtTBYir2sdGw3s8XE1WHZG4XZyl7z5?=
 =?us-ascii?Q?Y/xt7KIfLYjAANxH4XyfHw7w8+smx5GCcWyqCgobHmp1Lh83+DS/mbmG8mvC?=
 =?us-ascii?Q?j0McIXQ9fjvZPXFX+2lwIyg675nPYxhW5XnuuHKsFySl4RM2AJf0AkzNU8+X?=
 =?us-ascii?Q?QShaQoqkYDLvZKwKwjS0CbkqhkQPR+QFCxHrRxblI+P6U3kxihWPicR2nIdb?=
 =?us-ascii?Q?hGKSLJgjv1Pu+jYzrHb3v864GWjZioMPKpS8aP5NF6hYWzDdDg0uG1paKoeb?=
 =?us-ascii?Q?2hqFSS+cBDkXEEfb0eb5yxAjykOWE2UWyOpy6zoZEG+BV90AEwaNDWeNBmFN?=
 =?us-ascii?Q?E5Hlm1FoRVK0SntggQy/9aX2Gl5E0Qb3YWHYSDWbl8Pl6fNlsHmPYNUxQGWt?=
 =?us-ascii?Q?kmSJvj/OBRfBs1NtHCvy3HivDGFTfEw/8Zwbni2D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb84bbf1-881e-4b08-cfcb-08dbca6d15c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 15:16:46.8492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ClaIeMZAXZordNALkxNyoRyXowHeYt5e/OF6hKphzjTCAi0ZT6FY8tN94kl6zpKUfKEiO+vjq+YejraFK4nmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4860
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> kernel test robot noticed a -8.8% regression of stress-ng.clock.ops_per_s=
ec on:
>
>
> commit: 26bff7b04b829cccc6a97726d6398391a62e34ef ("[PATCH v9 2/3] x86/mce=
: Add per-bank CMCI storm mitigation")
> url: https://github.com/intel-lab-lkp/linux/commits/Tony-Luck/x86-mce-Rem=
ove-old-CMCI-storm-mitigation-code/20231005-024047
> patch link: https://lore.kernel.org/all/20231004183623.17067-3-tony.luck@=
intel.com/
> patch subject: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
>
> testcase: stress-ng
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10G=
Hz (Ice Lake) with 256G memory
> parameters:
>
>       nr_threads: 10%
>       disk: 1HDD
>       testtime: 60s
>       fs: ext4
>       class: os
>       test: clock
>       cpufreq_governor: performance
>
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202310111637.dee70328-oliver.san=
g@intel.com

Is the test injecting massive numbers of corrected memory errors? The code =
in this patch
is only executed when handling CMCI interrupts, or polling machine check ba=
nks (at most
once per second).

I'm guessing this report is just because alignment of some hot path code ch=
anged.

-Tony
