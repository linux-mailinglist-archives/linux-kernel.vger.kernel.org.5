Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E907705FE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjHDQ3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjHDQ3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:29:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507D649E0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691166586; x=1722702586;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kvCnlWxm1FBZwXhwDp+zZWtS7XysSopL2APnq1URnPo=;
  b=B7/WfA+MlGTFpbdFp2OICgCsKMYfTYYxRXRg+E6PFqpclAJLzFmxrc2R
   E3bpYXuT/hXpWd89R6N5NMbGVeg/i99ug7B5Mt8leyqaBPfkOpy0H07Po
   K8GGX9/47Ilm0ycDn89l+fURKSr4VBZmduuRX9w0K9N/+23qAiceEzpct
   L5fFmwQcPJD/X3X/7suNmHYonb3S/8+EMKg9b4ce+gB2VwcIWEC5S+xSy
   05GlW+Spz05tSjNMBHwtgUpsqQiksAHaMsh/epUv+iG+A1YrQyyS3l15j
   0IZtjf4Zoai/4GFG5VoFF+B0jeEclipPHbSZwhiijLXLfenA9b96aBYsW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="370177798"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="370177798"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 09:29:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="820189972"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="820189972"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2023 09:29:45 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 09:29:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 09:29:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 09:29:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhfYsJSvA/g9irqVhl0I443BYaLwDvwtHvWRphr3oU2HROdN4MesiLIMbSlIpqRmpVu1iT1iWFP5UJ+NEMJAVPCAFuw4OersGWCwLfjVToERyoPgDRd8/sTosRCScbeL8HNjzUn50sv60cSbknlJx892p1BNKbsLgZCl1YzLTcq2sM2O/6Nkili8+t0A10txLO1lAIibG44vlmbzj09oVqOZHlkE0ZCa/pMPhRKoaXx3wGscvYEyzeVvf18K0zGLFxwKVzneR1FIQgmNaZniuY2HV5yjyK6Bneva3aypBmUGWlEYwTXno50ZKNRvRFcUvt1GXoSuEceuE4j1WqTPyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0s4ZZZXzg2HY9Z0ForSDdfoFJXiiZmzM88zLZ/6f6M=;
 b=ITr6I2aWGkO7yh08UKu39eYhagHakn04/WUSKpgkUa5RZokTkErvY5Hy2nBpnz6phW+65mvwqYL8ujJe6axuOEKL1LhZZPJS8Z2JayT3a3RemPKd/pj9JZSM708HcafMAaau85DldDsWTdOCeygBLBMuuvxSlud4m6SQ38xLTIWo6LcZYxKGXQgwDJ9VdROkFChQYKCnVO/vlxbVNq2kFLNAyS8oeDtDdsxCCvCHI+GmtJzjBMJFE/mc4q1nTTfkf6OnvZlUY/t57crnukyS+GnJ87pbNmkXhV4dzlK3zt+O4YzIPm0bn9MIfk7GKE4LOg8TBv+JAIG1H6Wv/Glhfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB6794.namprd11.prod.outlook.com (2603:10b6:510:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 16:29:42 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 16:29:42 +0000
Date:   Sat, 5 Aug 2023 00:29:20 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <yangyicong@hisilicon.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <tim.c.chen@linux.intel.com>, <gautham.shenoy@amd.com>,
        <mgorman@suse.de>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <jonathan.cameron@huawei.com>,
        <ego@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>,
        <kprateek.nayak@amd.com>, <wuyun.abel@bytedance.com>
Subject: Re: [PATCH v9 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
Message-ID: <ZM0nYEB4m883KfIy@chenyu5-mobl2>
References: <20230719092838.2302-1-yangyicong@huawei.com>
 <20230719092838.2302-3-yangyicong@huawei.com>
 <ZLpVZmI8FrQtsfRH@chenyu5-mobl2>
 <ac8d1fef-ebe2-021f-b621-208c619cc2ea@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ac8d1fef-ebe2-021f-b621-208c619cc2ea@huawei.com>
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 90cccaf5-e9d5-4e3a-cc8f-08db95080163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GH+7mzPbBOp4N3EgQl391CIOEVv/n18TPSuSaopCuJsQygKqkkjX+Cbqzu8TZHUK4/Cqaza61AxV32FyslHUqP6T96B2q3iDb6rQG19pyJ67JZO5ZdMnBPpoBtkIzw8ErR2bpI9PQ399aCRktz14rVT5D1I2AIjVethPfxVvm6tPdqfVfn/cUbFLA7jA6aQYfIMrId0/C9O2GmRSPVTa6zbGxiwI3NCEiKJtsoB1BUSYHYSPGpJMGpSyJWp+W4ilGrjHOhZQWUs98NVXhugVHc4N8L6mLjF0tg4k8zgnYCMYZNSEPMmpybS7Bq6yArn27tll7CB76b2mVq22H1mAfGkXx9if4C/7TxO2o6LaL7veLQs1Xsm4M857i0O3rrTHkDPta8ULpMGaOD36UCOcImjvhLZwtplMCsg1XMPKlFRpzIpuzbA2IZmvbR0pAYIJhDcbxWO2Sdb/v7hBpl6E1wH1H+2YQnxFeSP8wP1YcS1M4NW8QbVGFHdWG/WEBX1FaAsT5iKVVmi+XmF+9Cx2D947yfM0axvsBGIlPdCLtiE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199021)(1800799003)(186006)(6506007)(26005)(53546011)(83380400001)(8936002)(41300700001)(30864003)(6916009)(2906002)(5660300002)(66946007)(66556008)(66476007)(4326008)(316002)(8676002)(6486002)(6512007)(6666004)(7416002)(9686003)(478600001)(38100700002)(82960400001)(33716001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gx1vhcACGfqkryOgDSWRwbifGn2t+hAoRaCUpfohynJ1yQjW8fSnIJQrZR8Z?=
 =?us-ascii?Q?tr1WFarN4ouKTxJul93jxYu4eMnqohiKPdpe4xNFUbWqTLxpaACx159ZERcm?=
 =?us-ascii?Q?z9kBWUoPmgwPJAwIuAql0sQCpTg1VY07DLWLb+eBoOq6j6vLwReuiXCfmQ5N?=
 =?us-ascii?Q?4mjJvjMqar2tyxh6020aw41snCPKy1K0ZNiaxQ/mUTmq3EVVLU35O/3KhMDb?=
 =?us-ascii?Q?D8hglnGHwvYSUxVA9p1+6J2XjvML8klXB2q8a744bj+MI/VMUUuCMqK4uqJL?=
 =?us-ascii?Q?s3mlrCumYUwtEZc5s1EdfWvG+mvly49bD9i+/1A2uecDrnsweqaTK4GhHYRx?=
 =?us-ascii?Q?NeA/FBEvn0N1p0kCYgLPrwDmKG9ICcVAUF2wjQwlk8AqH8TKQMhFlbGRXD9S?=
 =?us-ascii?Q?hjhhN8CcCif7AsrEcloOaYWOxatdRHli/2UZLDTWPw20LG6bY629UwAqv+ZC?=
 =?us-ascii?Q?6SK0W1HjMxuBjoBuS6RGX8y3iBIaPdoZgxy9yS54v7zO9qqQVantPddV+DZ+?=
 =?us-ascii?Q?MXjKUgfRVYFAD+cKFKjBMg8pNtIuwWTTHjSD6gzkCeqAYqE7UuFzFOGdH03Q?=
 =?us-ascii?Q?1CX1n9ss/48qXZqjPCVm9IjSHRQGJ7IO/XQzyNUAVdcBXY6D3FkNXTaqWrbI?=
 =?us-ascii?Q?zPYvGtcnLF5VyVUhn0iB8QmOy43JKp+ZVOeg4AmyD9jxenbZJ8b/Kf/9dgkq?=
 =?us-ascii?Q?imlxTUKawsZVxdOurawBRTxZfPYcXVxqd42iHInUsyQt8G2WrtCwZhPQHt8U?=
 =?us-ascii?Q?qWRmVspd8orbtAUaRS01YLadAWhmoMKqpiVGNoZzRjaoUNeA4yWzDLlfqtGL?=
 =?us-ascii?Q?SOJ8k4yGKiCIpjFvMiC/Nr4tglvn44Bw3fwPQw1xof/P6/zFO0HFvOAzx6l6?=
 =?us-ascii?Q?j8A9loVnX3ED31wwhxlZfk9XohPrCxe7DX1T/dkaCoXh78rNKGMMdA+VrXvS?=
 =?us-ascii?Q?iRy+oZlMdAgoU0WKTVr1EadUVWWx0l+WTKlxB3d2nnp+NhJa6Cg+9ipvZRim?=
 =?us-ascii?Q?Bn5UCgLI3mPI/QSyrASmhVTI1MmsfYg7jPhuc0RXfqacWkPPJm//kdxQAHD2?=
 =?us-ascii?Q?942H2MmH0T8G9IUEQ7sJX7avYZzfV8W/E5JYZ8dRAenLf1z6VMCdZzkxaLad?=
 =?us-ascii?Q?BSYS2W34Fsf9L3WE33UKbA2vURBlR1+peDouLqW3fFiSTZ4LnWSMXbmw/AWJ?=
 =?us-ascii?Q?nGUWPkTZzt6JQoCBy4Al/7AUw6rmvVsSO2qCAfzstRKhq6LnV0cbRrWL4uer?=
 =?us-ascii?Q?qkWkOvgm5Kw6Aeqd86NzbK4hfjnFWt5YZHAG/1fnyVV48XQRDKKYepIzU/oJ?=
 =?us-ascii?Q?ZFasT7u87+RAfFn8AYtrZzcj+fmU5SmTXPrLZ58nI5kO3l0W3pY++lWK4JEU?=
 =?us-ascii?Q?776obPvdXVtYKjHJqPmxnz0I2M7B2JC7f5H3E/sUZTqHuhGW3s6atG5c+hMM?=
 =?us-ascii?Q?DZy9hlk/hd+pL8K8GyLpLSg/Rx9EAPcqejPb5PneqOZVRPRLrOz4/iXlmktq?=
 =?us-ascii?Q?wqMUZtFDNDlw6BV78JsLxHdLw/WOjyA1gC/57n04TeIFF4YvH4Hca1wz7ZDK?=
 =?us-ascii?Q?l1RRygZAvRu+MWJVlQ2Idz7DuiJz+qMNVvVn77+P?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cccaf5-e9d5-4e3a-cc8f-08db95080163
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 16:29:42.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+KmScAjdXOExl8vmS7zf29WPamabJvGQOxymHSVB18xM8AZ0J3ysM+7wvQcuXY+uYHJIMTU+oumybKKZJzJKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6794
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yicong,

On 2023-08-01 at 20:06:56 +0800, Yicong Yang wrote:
> Hi Chenyu,
> 
> Sorry for the late reply. Something's wrong and cause this didn't appear
> in my mail box. I check it out on the LKML.
>
 
No worries : )

> On 2023/7/21 17:52, Chen Yu wrote:
> > Hi Yicong,
> > 
> > Thanks for sending this version!
> > 
> > On 2023-07-19 at 17:28:38 +0800, Yicong Yang wrote:
> >> From: Barry Song <song.bao.hua@hisilicon.com>
> >>
> >> For platforms having clusters like Kunpeng920, CPUs within the same cluster
> >> have lower latency when synchronizing and accessing shared resources like
> >> cache. Thus, this patch tries to find an idle cpu within the cluster of the
> >> target CPU before scanning the whole LLC to gain lower latency. This
> >> will be implemented in 3 steps in select_idle_sibling():
> >> 1. When the prev_cpu/recent_used_cpu are good wakeup candidates, use them
> >>    if they're sharing cluster with the target CPU. Otherwise record them
> >>    and do the scanning first.
> >> 2. Scanning the cluster prior to the LLC of the target CPU for an
> >>    idle CPU to wakeup.
> >> 3. If no idle CPU found after scanning and the prev_cpu/recent_used_cpu
> >>    can be used, use them.
> >>
> >> Testing has been done on Kunpeng920 by pinning tasks to one numa and two
> >> numa. On Kunpeng920, Each numa has 8 clusters and each cluster has 4 CPUs.
> >>
> >> With this patch, We noticed enhancement on tbench and netperf within one
> >> numa or cross two numa on 6.5-rc1:
> >> tbench results (node 0):
> >>              baseline                    patched
> >>   1:        325.9673        378.9117 (   16.24%)
> >>   4:       1311.9667       1501.5033 (   14.45%)
> >>   8:       2629.4667       2961.9100 (   12.64%)
> >>  16:       5259.1633       5928.0833 (   12.72%)
> >>  32:      10368.6333      10566.8667 (    1.91%)
> >>  64:       7868.7700       8182.0100 (    3.98%)
> >> 128:       6528.5733       6801.8000 (    4.19%)
> >> tbench results (node 0-1):
> >>               vanilla                    patched
> >>   1:        329.2757        380.8907 (   15.68%)
> >>   4:       1327.7900       1494.5300 (   12.56%)
> >>   8:       2627.2133       2917.1233 (   11.03%)
> >>  16:       5201.3367       5835.9233 (   12.20%)
> >>  32:       8811.8500      11154.2000 (   26.58%)
> >>  64:      15832.4000      19643.7667 (   24.07%)
> >> 128:      12605.5667      14639.5667 (   16.14%)
> >> netperf results TCP_RR (node 0):
> >>              baseline                    patched
> >>   1:      77302.8667      92172.2100 (   19.24%)
> >>   4:      78724.9200      91581.3100 (   16.33%)
> >>   8:      79168.1296      91091.7942 (   15.06%)
> >>  16:      81079.4200      90546.5225 (   11.68%)
> >>  32:      82201.5799      78910.4982 (   -4.00%)
> >>  64:      29539.3509      29131.4698 (   -1.38%)
> >> 128:      12082.7522      11956.7705 (   -1.04%)
> >> netperf results TCP_RR (node 0-1):
> >>              baseline                    patched
> >>   1:      78340.5233      92101.8733 (   17.57%)
> >>   4:      79644.2483      91326.7517 (   14.67%)
> >>   8:      79557.4313      90737.8096 (   14.05%)
> >>  16:      79215.5304      90568.4542 (   14.33%)
> >>  32:      78999.3983      85460.6044 (    8.18%)
> >>  64:      74198.9494      74325.4361 (    0.17%)
> >> 128:      27397.4810      27757.5471 (    1.31%)
> >> netperf results UDP_RR (node 0):
> >>              baseline                    patched
> >>   1:      95721.9367     111546.1367 (   16.53%)
> >>   4:      96384.2250     110036.1408 (   14.16%)
> >>   8:      97460.6546     109968.0883 (   12.83%)
> >>  16:      98876.1687     109387.8065 (   10.63%)
> >>  32:     104364.6417     105241.6767 (    0.84%)
> >>  64:      37502.6246      37451.1204 (   -0.14%)
> >> 128:      14496.1780      14610.5538 (    0.79%)
> >> netperf results UDP_RR (node 0-1):
> >>              baseline                    patched
> >>   1:      96176.1633     111397.5333 (   15.83%)
> >>   4:      94758.5575     105681.7833 (   11.53%)
> >>   8:      94340.2200     104138.3613 (   10.39%)
> >>  16:      95208.5285     106714.0396 (   12.08%)
> >>  32:      74745.9028     100713.8764 (   34.74%)
> >>  64:      59351.4977      73536.1434 (   23.90%)
> >> 128:      23755.4971      26648.7413 (   12.18%)
> >>
> >> Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so the SMT branch
> >> in the code has not been tested but it supposed to work.
> >>
> >> Chen Yu also noticed this will improve the performance of tbench and
> >> netperf on a 24 CPUs Jacobsville machine, there are 4 CPUs in one
> >> cluster sharing L2 Cache.
> >>
> >> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> >> [https://lore.kernel.org/lkml/Ytfjs+m1kUs0ScSn@worktop.programming.kicks-ass.net]
> >> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
> >> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> >> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> >> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> >> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> >> ---
> >>  kernel/sched/fair.c     | 59 +++++++++++++++++++++++++++++++++++++----
> >>  kernel/sched/sched.h    |  1 +
> >>  kernel/sched/topology.c | 12 +++++++++
> >>  3 files changed, 67 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index b3e25be58e2b..d91bf64f81f5 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -7012,6 +7012,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >>  		}
> >>  	}
> >>  
> >> +	if (static_branch_unlikely(&sched_cluster_active)) {
> >> +		struct sched_group *sg = sd->groups;
> >> +
> >> +		if (sg->flags & SD_CLUSTER) {
> >> +			for_each_cpu_wrap(cpu, sched_group_span(sg), target + 1) {
> >> +				if (!cpumask_test_cpu(cpu, cpus))
> >> +					continue;
> >> +
> >> +				if (has_idle_core) {
> >> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >> +					if ((unsigned int)i < nr_cpumask_bits)
> >> +						return i;
> >> +				} else {
> >> +					if (--nr <= 0)
> >> +						return -1;
> >> +					idle_cpu = __select_idle_cpu(cpu, p);
> >> +					if ((unsigned int)idle_cpu < nr_cpumask_bits)
> >> +						return idle_cpu;
> >> +				}
> >> +			}
> >> +			cpumask_andnot(cpus, cpus, sched_group_span(sg));
> >> +		}
> >> +	}
> >> +
> >>  	for_each_cpu_wrap(cpu, cpus, target + 1) {
> >>  		if (has_idle_core) {
> >>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >> @@ -7019,7 +7043,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >>  				return i;
> >>  
> >>  		} else {
> >> -			if (!--nr)
> >> +			if (--nr <= 0)
> >>  				return -1;
> >>  			idle_cpu = __select_idle_cpu(cpu, p);
> >>  			if ((unsigned int)idle_cpu < nr_cpumask_bits)
> >> @@ -7121,7 +7145,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >>  	bool has_idle_core = false;
> >>  	struct sched_domain *sd;
> >>  	unsigned long task_util, util_min, util_max;
> >> -	int i, recent_used_cpu;
> >> +	int i, recent_used_cpu, prev_aff = -1;
> >>  
> >>  	/*
> >>  	 * On asymmetric system, update task utilization because we will check
> >> @@ -7148,8 +7172,14 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >>  	 */
> >>  	if (prev != target && cpus_share_cache(prev, target) &&
> >>  	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> >> -	    asym_fits_cpu(task_util, util_min, util_max, prev))
> >> -		return prev;
> >> +	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
> >> +		if (!static_branch_unlikely(&sched_cluster_active))
> >> +			return prev;
> >> +
> >> +		if (cpus_share_resources(prev, target))
> >> +			return prev;
> > 
> > I have one minor question, previously Peter mentioned that he wants to get rid of the
> > percpu sd_share_id, not sure if he means that not using it in select_idle_cpu()
> > or remove that variable completely to not introduce extra space? 
> > Hi Peter, could you please give us more hints on this? thanks.
> > 
> > If we wants to get rid of this variable, would this work?
> > 
> > 	if ((sd->groups->flags & SD_CLUSTER) &&
> > 	    cpumask_test_cpu(prev, sched_group_span(sd->groups))
> > 		return prev
> > 
> 
> In the current implementation, nop, we haven't deferenced the @sd yet and we don't
> need to if scanning is not needed.
> 
> Since we're on the quick path without scanning here, I wonder it'll be a bit more
> efficient to use a per-cpu id rather than deference the rcu and do the bitmap
> computation.
>

Dereference is a memory barrier and the bitmap is of one operation/instruction which
should not have too much overhead. But anyway I've tested this patch on Jacobsville
and the data looks OK to me:


netperf
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	6-threads	 1.00 (  0.84)	 -0.32 (  0.71)
TCP_RR          	12-threads	 1.00 (  0.35)	 +1.52 (  0.42)
TCP_RR          	18-threads	 1.00 (  0.31)	 +3.89 (  0.38)
TCP_RR          	24-threads	 1.00 (  0.87)	 -0.34 (  0.75)
TCP_RR          	30-threads	 1.00 (  5.84)	 +0.71 (  4.85)
TCP_RR          	36-threads	 1.00 (  4.84)	 +0.24 (  3.30)
TCP_RR          	42-threads	 1.00 (  3.75)	 +0.26 (  3.56)
TCP_RR          	48-threads	 1.00 (  1.51)	 +0.45 (  1.28)
UDP_RR          	6-threads	 1.00 (  0.65)	+10.12 (  0.63)
UDP_RR          	12-threads	 1.00 (  0.20)	 +9.91 (  0.25)
UDP_RR          	18-threads	 1.00 ( 11.13)	+16.77 (  0.49)
UDP_RR          	24-threads	 1.00 ( 12.38)	 +2.52 (  0.98)
UDP_RR          	30-threads	 1.00 (  5.63)	 -0.34 (  4.38)
UDP_RR          	36-threads	 1.00 ( 19.12)	 -0.89 (  3.30)
UDP_RR          	42-threads	 1.00 (  2.96)	 -1.41 (  3.17)
UDP_RR          	48-threads	 1.00 ( 14.08)	 -0.77 ( 10.77)

Good improvement in several cases. No regression is detected.

tbench
======
case            	load    	baseline(std%)	compare%( std%)
loopback        	6-threads	 1.00 (  0.41)	 +1.63 (  0.17)
loopback        	12-threads	 1.00 (  0.18)	 +4.39 (  0.12)
loopback        	18-threads	 1.00 (  0.43)	+10.42 (  0.18)
loopback        	24-threads	 1.00 (  0.38)	 +1.24 (  0.38)
loopback        	30-threads	 1.00 (  0.24)	 +0.60 (  0.14)
loopback        	36-threads	 1.00 (  0.17)	 +0.63 (  0.17)
loopback        	42-threads	 1.00 (  0.26)	 +0.76 (  0.08)
loopback        	48-threads	 1.00 (  0.23)	 +0.91 (  0.10)

Good improvement in 18-threads case. No regression is detected.

hackbench
=========
case            	load    	baseline(std%)	compare%( std%)
process-pipe    	1-groups	 1.00 (  0.52)	 +9.26 (  0.57)
process-pipe    	2-groups	 1.00 (  1.55)	 +6.92 (  0.56)
process-pipe    	4-groups	 1.00 (  1.36)	 +4.80 (  3.78)
process-sockets 	1-groups	 1.00 (  2.16)	 -6.35 (  1.10)
process-sockets 	2-groups	 1.00 (  2.34)	 -6.35 (  5.52)
process-sockets 	4-groups	 1.00 (  0.35)	 -5.64 (  1.19)
threads-pipe    	1-groups	 1.00 (  0.82)	 +8.00 (  0.00)
threads-pipe    	2-groups	 1.00 (  0.47)	 +6.91 (  0.50)
threads-pipe    	4-groups	 1.00 (  0.45)	 +8.92 (  2.27)
threads-sockets 	1-groups	 1.00 (  1.02)	 -4.13 (  2.30)
threads-sockets 	2-groups	 1.00 (  0.34)	 -1.86 (  2.39)
threads-sockets 	4-groups	 1.00 (  1.51)	 -3.99 (  1.59)

Pros and cons for hackbench. There is improvement for pipe mode, but
slight regression on sockets mode. I think this is within acceptable range.

schbench
========
case            	load    	baseline(std%)	compare%( std%)
normal          	1-mthreads	 1.00 (  0.00)	 +0.00 (  0.00)
normal          	2-mthreads	 1.00 (  0.00)	 +0.00 (  0.00)
normal          	4-mthreads	 1.00 (  3.82)	 +0.00 (  3.82)

There is impact to schbench at all, and the results are quite stable.

For the whole series:

Tested-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu 
