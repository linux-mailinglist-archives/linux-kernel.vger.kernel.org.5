Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6697D4F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjJXMG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjJXMGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:06:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0D4F9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698149212; x=1729685212;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ek586kiGIOx5M+hZOrR0L4tnIqpbZ2ZU+ZBPAkW+qQw=;
  b=DiElnqyKkxOFzbM6gFbP6rUp9bl+48nnMCU7VTfWV2MqyjHm+R7M+voD
   D4EmmY8kaxik7l440Y/juINbfbblI1wVOMQYBrTuk5pojkCX5K60eHVnk
   +K6FaLBLrb2zVgHn4az4tEaF6wyYR6YW+nuc2Xz7Y72j4+NuzJS/svpmJ
   bYcd/Y8ogMin99oo/9HySK01Qr/lj/sKWuH/yS6q5VWARUlayP1Hhn7nz
   kQvpqK1QwBA5AicnmRra/rzOiJXNnLvmZ8el3xEm5ZsLloGL0f0wx1Gtl
   Q+N3pJUX3AnOpTE9pKwqNiFsCWHDSg9EV53cKSPAgjPAa4PyHUQ5aABod
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="473265010"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="473265010"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 05:06:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="708260177"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="708260177"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 05:06:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 05:06:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 05:06:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 05:06:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P12r94i9r/gaZAKePwx4RWR8U2wOAgjmfJTm7hALP83diScPzL8O2rvgRoYamXAfmo9t2AlbknrHOlgCzgYwnInrU6Ve7dkE/KCMh5G2bnlD/EThwqxWj1IFj09LMq8y/BJD+7OczTQrPJlCi416oalfLiL+7Ik9cfDz/WyJkrbt0t0Z0uvgsZb8c58SOKtzLgDiLsTLBLt4NxUUKskCK8TnvozQYekbNjZHByDBrqf5tKosmERRXggvzmCOtXAPoVCN61Hb3dQ29wF4+h570Eav1/ysTh2LFps3Z+QV2GqZ4at7EMzt7yIinx2KB+OIgunzYnEHuXoZ/GZ2O5pI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRBXrSBv7n96wUCVEAVL7iPC2a/yu5tmCvf6Ei0aU04=;
 b=jKle6TxcodWrG3YH2H5BXoLJemN6y4SlZMpbX8xAFhFZHXpzyJ7sujheEt+qDmD5jJAkwKfUyawjhdH+aN9apYKDQvcuqLY0wqfSMXejMyqnFzxQ50dztvpY46VdSdslotarEw4rHkX8mtFGB6Bcrkqtor4LDjJcbcqmzgR42wnR7NZwY12NE6W0BF9Flx4EI+Zz7ka8gDq2d+LsNexfnGEC/mETdm9lZfW/vRBAIFt2/RnoKuOZCj1lj7nRNYm+bsqTm7WdmTm6HtSofuxUyV1l3KzzIZUjnZiTchwHCbR1LgaixPqjHTEXN+JQ2ozXL++vmIiyTOT58jeInmWXLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by PH0PR11MB5079.namprd11.prod.outlook.com (2603:10b6:510:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 12:06:42 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a%4]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 12:06:42 +0000
Date:   Tue, 24 Oct 2023 14:06:35 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     James Morse <james.morse@arm.com>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
Subject: Re: [PATCH v6 10/24] x86/resctrl: Allocate the cleanest CLOSID by
 searching closid_num_dirty_rmid
Message-ID: <ln2bt6n2yo4r5ip44pz7skhv2gvejm44zuie5kxidlwiavzjhs@mqphd5revvly>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-11-james.morse@arm.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914172138.11977-11-james.morse@arm.com>
X-ClientProxiedBy: WA2P291CA0044.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::20) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|PH0PR11MB5079:EE_
X-MS-Office365-Filtering-Correlation-Id: 015a8958-291e-4730-c869-08dbd489af3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QKLdDHj5ji1I7YQwYGAQ7Umzmuam0bgiQfuWybWnB7PDwYBfh8vEbJ79OdsMu4gigU9pxZIaPkQNvpCpxMsmdlMomkMVNzdiTUsUOGU06e+V6UFmm1gTn213g/mKx/b4icBTBgFydoV0bSqWsHd48ZX9TfyV5jLwlaxVmpcMfVS+pl72ssnquGwzfnU7lnx1JEArMBpa6a80fEP6V+RWZiTAeNsbMsO+7vG94nXYx2ld+mly7hYUvQI47CmBh/VzIS7+zrDFTeAcapYknzBvatzDR+/PQ9PTcb1MXDjUy7557wBuIgjQbmTuQsGebS2gpVqOE7YbM1ZZ76/R5v0HKuRNkmsur/6ehqu4OBudczTrIdw+jQ2ezoF/FcvC5jKYhtgnQKva3W9CH+/u7TKQNy9AGl7UX2Q+8llX3g6fFyhdaEIPkhOV0smHgK0ACt4yKZDAkPDd7luJaD6mCyR5aOpUKYyaAstyGOaqOR+dNuCWAdD8Xfdgmb096IRt/50tUzIyP2e7vxBvoXC2sja59bUQOs8+1ibnENHajVF8S6KFLK0/mByck+Y7vFRyliEkrsi2i24WYwjaYt/vpp5lAIeYoAyyMAegcDKTToo4euk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2906002)(26005)(5660300002)(4326008)(41300700001)(8676002)(8936002)(66946007)(6512007)(53546011)(9686003)(316002)(54906003)(66476007)(66556008)(6916009)(6666004)(7416002)(478600001)(6506007)(6486002)(83380400001)(4744005)(38100700002)(33716001)(82960400001)(86362001)(14143004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?TuRg7aJ8d3Sru9xWNr7WshcAMNcJscTwRQMACK7X5zC5uuauMzfScAV1uj?=
 =?iso-8859-1?Q?6zdBhwpbxRUIbz1gTOlo73NdyT7q8GHH/OTzOJuG1rqPv66iEd0h8Z+Nku?=
 =?iso-8859-1?Q?Wj8HLUXKnGIvzsG+fxpDEIY7VVUbFXwcdz9qlRxE09bJAbZsnIcDEsHEK3?=
 =?iso-8859-1?Q?FViCUeqQdXMf3J4lGfAQwFPkD6oBCYIXpVuwZ1bn6xzy7QQ1j6CP0qVYns?=
 =?iso-8859-1?Q?jG1So1wxI8OPxnnsm4GMLJtsilX8ZOXJdckKwvAAk6cTDdZZ2JS0BUS2ez?=
 =?iso-8859-1?Q?uaPiUS3p6MolIiUtsXVFOg05ZhjQUlol0/C48dLsLnh30n3RKQR6tMuoEE?=
 =?iso-8859-1?Q?PTGgKBBpZAsEq108UQlM23mCtNEXRHsWPhgy40E2JyiJm4J2SRwhbq5So3?=
 =?iso-8859-1?Q?G0MrekC1n9+EOSPvq3Ev+Tl00tdtaD0Vj2JKHfvWvUPfc9HVgylPQ34tN7?=
 =?iso-8859-1?Q?MTB4vDC9qvsergX8NKq6lOpvxSpguPGn5YIzceIUlHNDeIYnO9bMUBlqJh?=
 =?iso-8859-1?Q?1YrX28aNp7hrqcQLAxM3FuC/CSr4axN+9ooqe21DIXoQpztq/D1kdJg4ht?=
 =?iso-8859-1?Q?u0if5kQQhL8UsnyKpCXOHoiDTg2YUdcgk6oBi84swNDlJfybU2cPKzBTzZ?=
 =?iso-8859-1?Q?On/ma5BEorGa9o3eqLeDrDpkwQQ34uuJtXz8USPvaLA2j7ri+/T2TmpYlx?=
 =?iso-8859-1?Q?/TFZ+3xCPVE+FlATXuGtWgK20JdXCRgD/Ug19L6exqFIxz/zoLaPFiXAuZ?=
 =?iso-8859-1?Q?dcxaXGkQcl48pftHYfiB1ycB+EGbi6zqmE0IyWte3E9A1aJW08iSdDUR2I?=
 =?iso-8859-1?Q?5oy6G7eBF7iDgV6NmFoCg7KDjaEDa4/iphFODpNmy/y79pEdm44+7OvZSh?=
 =?iso-8859-1?Q?hn3uIhGFVRpduyQgSJ7ZFnBqPh6QVduashwjKYhEKylS+i+XQNDuGgjaJx?=
 =?iso-8859-1?Q?8NwMTGFixxXGFvMUjjhgJhau8Hk/OOfAgl5/OPtZWbsG8BIQW931rfoMVx?=
 =?iso-8859-1?Q?M6edjeh6GudgBd5dQRssoJFf/15j3zyfYWZ3o4CwElSs0smqXLcbGsmkLs?=
 =?iso-8859-1?Q?jJlRflc0ZqKPxMxA+7BZnyO5X1PkZ18Z7Ot36LsMWYPbb19qLaSk3ywvv8?=
 =?iso-8859-1?Q?GOb4Lr7ZjX2f0WU1+7E3CwzcDlW1Rt6iLNJuUblMk34icH1JI5VV+r1m5v?=
 =?iso-8859-1?Q?LLQYaQ6tF5CqpYtczCf18Opk9epmL47OErmB8vRKxOmPP3Rp/zoVzTVLRn?=
 =?iso-8859-1?Q?C9Jd5XFuKCv50RTNUrOvcbzYVVrfaajd2BzkWjjJ/PUw4YfkAwtOEgJ0jB?=
 =?iso-8859-1?Q?uUQW27Mvk4sSd0KREZ1buC6XtB+isG0VfOJZyQtEXYyL5ppd61etMXoBYL?=
 =?iso-8859-1?Q?75eC79L89RQv2fmu7XTY7/YVSDodrK/3aFLc8Ss2TgPTka+y2eC9c7ZTKp?=
 =?iso-8859-1?Q?3bPbG425/h4jFH+wiBLgVG+NtaRCGYX0iLrKNaFnfzz6ES6qPuhkmLCOeh?=
 =?iso-8859-1?Q?fsDVcSNLTV10ihfGmNJ+WHMc1ZjVIjtuRg1ioqwecwimmxyOJ05PPL7KKu?=
 =?iso-8859-1?Q?zJAXKH8M3aJyOZFq4UFB9dtG6Su9ATWOFMaW5PhhDSklfTbmVUTxMgruLj?=
 =?iso-8859-1?Q?fGuo3VSc44KWEjNi2TMw1dLt5TipC7BucTxTPFlp8Yb2aNJ76xQMHNjBID?=
 =?iso-8859-1?Q?rURf3ix+P1aayFmZZjc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 015a8958-291e-4730-c869-08dbd489af3c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 12:06:42.0171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqHTTDU3/6vl0YGAVhte3Jm3iz5FTVbeOkUutfk1ZnKW7BDLgqgSM2gew2cEe0jAO9y0UKBW5RVoFE+/IUhPHUu0jbv0+n4/dAt2aasmqHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5079
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-14 at 17:21:24 +0000, James Morse wrote:
>MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
>used for different control groups.
>
>This means once a CLOSID is allocated, all its monitoring ids may still be
>dirty, and held in limbo.
>
>Instead of allocating the first free CLOSID, on architectures where
>CONFIG_RESCTRL_RMID_DEPENDS_ON_COSID is enabled, search

"CONFIG_RESCTRL_RMID_DEPENDS_ON_COSID" >
"CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID"?

>closid_num_dirty_rmid[] to find the cleanest CLOSID.
>
>The CLOSID found is returned to closid_alloc() for the free list
>to be updated.

-- 
Kind regards
Maciej Wieczór-Retman
