Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5C77BD384
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345283AbjJIGfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345249AbjJIGfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:35:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F9BA4;
        Sun,  8 Oct 2023 23:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696833341; x=1728369341;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=vw2ZSf5p08EK/ymXMPPxJugZ1y25064kUBK2hD5m1FU=;
  b=CL/GdU6UhUodFE5BQbEJCw+jv1RozB+LhiMH4kDDljt4a0RKXoRx4LoJ
   gFQ/q2aFndGxlYe8YABj3DVn/98Ie42RdkVHacX5utxq35pWARK/bRxQB
   VFrIX1Tro9GEijEpSOlr6Nb60qGBss+SVat73q5gUS52OePuc7NzR2Atl
   AIGV9CDP/caAo1HvIudOdVBqP3XGfRHjh5k9aw1EF/z6Skn846aHng1nB
   37xggqs9E2Bfw4cENEn3+S1DLIRwvykGaqSvBywIb8JO32G015T8rrJ/f
   h3T2uJAzjvbfujT7BgAMjoIztSpog9RDurmKjCKuQFeG8P9DEl9fIcLoy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="448273940"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="448273940"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 23:35:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="896654865"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="896654865"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2023 23:34:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 23:35:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 23:35:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 23:35:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cknrB+1vkwoxp00U93kxeAsCwcQmnr1j8ZbWaaicZGlAYfZw2KM4812kUaJK12g9iV1F3YKRXlGx+KCfPkDW/cL1TOmpJEQVt5U3v3K0DBTcl3HSUqPluBqEe0c9lb8GAPgE8wm2OEWh4ekBj+qP55qW9xye7Bf5DzgHp+Ok6D6vpBQaY1lWK+iwBZenfM6H7SC9x9yaDQrEeV/Rt1BAHTzjtZRus1benT6LiUVCYKFH5B1wKVpOo7oZSz8AL7sqDNZtLAqHKJ6jvEY0ou9mmSgyEzhS5ONbuA22hsvNWXte/M0FiVu+u00k6dkkSxyG+Am8x/D4SDYH+FSKtUTtoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XS4bPUCKVttLYpTTepxmRgxboKfHr78Y2JEvLuomLE=;
 b=PgN6quFGrJXrBF88UVZVw/30hX0CcRu1oczfWaT7l06NxAhVpvbhAbYIWd1fuOGq1bDzbMG6qdaGwpIwwggueTNEZjccaN4SWDFnK0pVdNsMu/ah4RRbDVz3Pboi8HWZJcyuftya9SW8XGebt7ElE5s+HCO9WFZWyMDwsjPFJJ9W6IUS+zwzlIdSSUs3keggjeqoh9/hoFNg6dgUyVF/Qm43qK/QRHqpNj0qbXXbSGgyYrCIU3Sx/U1MCpYGBCz+y816T3wuOrF3wyAfzugjJDVoxzS8uk5naMQQlsKtP5dNZknT6A8Qi2lj8CGRuYvf8VecM92I0uLQKrx23rSpZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DS7PR11MB6293.namprd11.prod.outlook.com (2603:10b6:8:97::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 06:35:32 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 06:35:31 +0000
Date:   Mon, 9 Oct 2023 08:35:22 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     <babu.moger@amd.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Peter Newman <peternewman@google.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] Documentation/x86: Document resctrl's new
 sparse_masks
Message-ID: <6swdqsa6anvhtdwfvj2xw55kfyih42w2buef4fc7wti54pvw2r@to4h2i76zqc6>
References: <cover.1696493034.git.maciej.wieczor-retman@intel.com>
 <7bbdf55ac6f909a6701915d99d79c8f9977bd0b4.1696493034.git.maciej.wieczor-retman@intel.com>
 <fd2309d5-ea56-abed-5c3e-a8a038b07d9e@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd2309d5-ea56-abed-5c3e-a8a038b07d9e@amd.com>
X-ClientProxiedBy: FR0P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::10) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DS7PR11MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 071ed85b-24c5-4990-6679-08dbc891eee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IdfrRF140U3HRpHUt5J8GeYVhuwEeIaa2iG3q1gWerTqs4+FIqC6n/DgP6W/N6FjT2MZwzu6cIyliu4vW7sVqkT1aZ5kxRHPwosC7z6NCpId0y8KThwx50L1WHg6EBcxCoI6dwDGytTccHlfKMDuY4mxkcB2wzRX0XD4T3SikM9jw+ZKVtgS+mOr92QD0mvJuzYsPU3BoABXvtMYZjK8S341M3ADY2vgtepeNqC6qIcKLAbmM1rhGwogFMa9qvxw8W3i1WbX8tCqBp2m/SRsQs3a4pAP7xY8A8WqIYGTxb0BMbnuwrUwFzioC6PrFt4qksvtol3/NBFYufqnCNOHUFdDiL66ZE6AXKfEgsrl/7WYmmLOyH9vaa1XvTMsjfW+BPnXDx8pWEcaym1dUI5nrWxC6Lc0CH6HJwkkABrEGiqLBr+DQ48rTAk1nrzVcpwG1xG3uAKY5djGddQRQr3dB1QmMTJagVI7OrA+E5dqW8M5xw2R4IKRIXP88wjDRY5g5YVq1P+bfv9pCyVc1aSj1IkakMk7ThQ8iOf2ym9NVO6O2eyjh037AqdDXZZOmKqQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6512007)(9686003)(53546011)(6506007)(6486002)(478600001)(2906002)(26005)(83380400001)(7416002)(66574015)(5660300002)(33716001)(54906003)(66556008)(66946007)(8936002)(4326008)(8676002)(41300700001)(66476007)(316002)(6916009)(38100700002)(82960400001)(86362001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?xT4CCzx+D8UfBT+42we6U8V3USXILEnFM79OMqFOjNN1O8YFC+GQVZQ59G?=
 =?iso-8859-1?Q?mLS5ZBfyhfLtFqHsM0rCv9Hsn+tDSe55peJoqpW5skYOkJ8aBxEKNoAEDe?=
 =?iso-8859-1?Q?VW5DcRQLmSSQFOd+O3+PECzvvkmePoEfWy22Nu95BgtYcvf9+CZcGRvUwk?=
 =?iso-8859-1?Q?Ppzc3MDlrthzugNiIGCgBwLqtYlAshW3PXX3Gnkp1pTBRtv50Fm2do7UZg?=
 =?iso-8859-1?Q?j5wooNZ87SBlWPoz/ZDaKIs1apnw8QWCrnnbEnzmfRdl4wO33T92cHh7kZ?=
 =?iso-8859-1?Q?qjflTydJ45ZYVne9pCbDBBYTvt4pcpQg+JghkoXrPo8sItEpwlC98HuF6z?=
 =?iso-8859-1?Q?jXzbIGkPA52I6EKKfbtdcKHVNLx61wsLrYbtKOLtDUaWrTjalTh84Opk9d?=
 =?iso-8859-1?Q?9zJbpz8ls/Bf/+n6xYBdv1q7EFgG+OrU21kFD7x0JTWS6XGPTkPiD/aZz0?=
 =?iso-8859-1?Q?+U8C01rHhvDRdHq9wvXnydn9Fp2x+cj9KLPx9L/hpO1n1CfqL4cyC2EycG?=
 =?iso-8859-1?Q?Y5hv0vmurEdv7TI2xg+qwQZuGCrBcgGQ5sZZoMlSxsfew0+ykwU8ZmbOKp?=
 =?iso-8859-1?Q?prcO4ZT2DjUuoX4HOZEQr2+kr49DPnveEaa7q6lbVktyDu8JNDWuSOhr9n?=
 =?iso-8859-1?Q?AA6VI9IwEnGl6Glu/DA5qWE5NQ7t2yy0EJWMBvYGyyyiZLlYyzASmnUu2M?=
 =?iso-8859-1?Q?V4dv6XMXoizFSOA/Lj9l+MYJfC6vRpfSKsh3ici9LJZZF+dqUhmFqdsSdM?=
 =?iso-8859-1?Q?UeJSj8NEJ5nuvGiq2cHlyKrajQUprRW8lapQTNun92UlHjU2kC8PjsqXSs?=
 =?iso-8859-1?Q?L5JWKwZZ+v4+RdKoSp+rJmnP5TXH+jMBGxlLnefYMGS4ySUC69mEq4YAHp?=
 =?iso-8859-1?Q?dY5QtnDYFIg1TE8yZvZPRghxRcgV1n3P7Z1sHLiPt52gTwidp+1Yx2zxyq?=
 =?iso-8859-1?Q?KBcmFR405+BTe7sXmypxUYrBtIzgnlhKu1F8h/2gxjREAHzf5Jt+TBKERF?=
 =?iso-8859-1?Q?52npUHTW1+UAhpcegbh7zE4G4mzVrrfyCbLH8S66ftaJBi9drnCSmT8uKI?=
 =?iso-8859-1?Q?N1iSscUqB4SNvzpSLSwwReng6KcaGkqiA6vEKfW/6nxmnCH0BbwmdbC51+?=
 =?iso-8859-1?Q?M6vNaWTt4teAJCMf/4HRFvP5uwzXIFtqnd58TpGcTmj770LSEarTd2Wni3?=
 =?iso-8859-1?Q?XO+TqQxRHwAtAex3hZiOt8udLuGqHDh1vMjwcgyWMIBgm3oY10oxnPlCah?=
 =?iso-8859-1?Q?IadfxFosbLoHSU6STjOh+mPl53ZEwLg/wIc4tdfRWzN3ytQZrZz0Uil8ps?=
 =?iso-8859-1?Q?D3u4k/qA/4X8S/JHFUM/ghqsKRyt00/e4BwzNGcxNpDXiboUEEQlehp49b?=
 =?iso-8859-1?Q?ZAGZtWlRHRGzEnnTmI+TvQs35g6eb4HTL3Xq5WRzfGj4AZZcjxPOYG+k4B?=
 =?iso-8859-1?Q?EWEuBWGiPSUxawDXerv2/QuIHsNlCyRfmqevqOF2hlqTZsl5k7e8WuhXiR?=
 =?iso-8859-1?Q?6Otc24Mgw0vuDqaUM7jSEqjO6f2qdwKNq/SfL5pk5lTl0nfKDreRaf9Q5W?=
 =?iso-8859-1?Q?U0ZbOwKa2MJHFpBAgVMTOMX3I6o1Di9Sq4ti/s58cJrW9DHPZZOaFDZDdR?=
 =?iso-8859-1?Q?wHq0MVHiI8+i0hMMeTQT95dzx6FVhtYwRD7XlvVrEVtih7gXUePd0Yg1H5?=
 =?iso-8859-1?Q?N+OMZ6ssAI9pydNCR98=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 071ed85b-24c5-4990-6679-08dbc891eee4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 06:35:30.8821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ral7QUJ5l2h4gvLPjX4U+5imqf9b7xz1ExkzTuSw2m9mrNWFvfi/e+H3R86BHpFHMqb/tz1JsT0uXWZN+V0v7NlHxndzWQp+v6tryOoCQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6293
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

Hi, thanks for reviewing the series!

On 2023-10-06 at 15:42:15 -0500, Moger, Babu wrote:
>Hi Maciej,
>
>My last comment didn't make it to lkml.  Could be my mail server problem.
>Commenting again.
>
>On 10/5/2023 3:15 AM, Maciej Wieczor-Retman wrote:
>> From: Fenghua Yu <fenghua.yu@intel.com>
>> 
>> The documentation mentions that non-contiguous bit masks are not
>> supported in Intel Cache Allocation Technology (CAT).
>> 
>> Update the documentation on how to determine if sparse bit masks are
>> allowed in L2 and L3 CAT.
>> 
>> Mention the file with feature support information is located in
>> the /sys/fs/resctrl/info/{resource}/ directories and enumerate what
>> are the possible outputs on file read operation.
>
>This last paragraph is not clear.  All the information is already in the
>documentation.

Right, I guess that paragraph does mirror patch contents a bit too much.
I'll remove it and repost it.

>You can drop this paragraph. First two paragraphs are fine.
>
>> 
>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> Tested-by: Peter Newman <peternewman@google.com>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Reviewed-by: Peter Newman <peternewman@google.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>
>Otherwise patch looks fine.
>
>Reviewed-by: Babu Moger <babu.moger@amd.com>
>
>Thanks
>
>Babu
>

-- 
Kind regards
Maciej Wieczór-Retman
