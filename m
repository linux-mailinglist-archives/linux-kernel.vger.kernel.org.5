Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B365E7B2C46
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 08:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjI2GXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 02:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjI2GW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 02:22:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0D81A2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 23:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695968576; x=1727504576;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=UI3lYedTBgk7Bp5VXcRJJDloudHZFH59W8Ieovo51tw=;
  b=h1i7BLSWSe0dHbA9GBauhT9O5mss4nHapqmOnHS/0g3MarmIb6NqGIb3
   Gesca8eFYszxbQRzGZ7pknFWbjbjw2HkNjURZhhX3YHAbqtZmKf1xvFJa
   c+Oo5UpGS/ingcgL42XJ+s1BHuRih4/itnP99GXFYtN6ntjOzsKfm+dNh
   WnpKWlewX7C7tvqrGvd+WhtoKs4RXGZKwrNzUu9P+GIgZPfgIGKB3fEMo
   rao+tIeOYaB39jwq9pTfdkma+4nOBXZmfFjX2IclvARFgNTQrGl4+osGz
   FZEBfzAnW5aW8KDIum7FR4gvyLDHFvEJ1YJcpRXcfNTIeDB9Geuy9nM6z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="386105659"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="386105659"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 23:22:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="893322296"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="893322296"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 23:21:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 23:22:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 23:22:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 23:22:56 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 23:22:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFIvS+5xJ4ImA/OzLx980doy3OSkR00ewuzadmSdcvuPQScbhINpLbh5wmX19nZtj/0NCMlBPe4fUQM+bzwLlicNN82dMggrU4mWthYDpg8gtLpWgj3HcMCjXQ4jNV1UY/0cVNV5voEdKEf00dd343xldzdN402w8ZWuiwgeY+CXEAhABwBhxbxTy3Z6g5hTCPaLdOoeIXxK5Q3hQGzF8foOY7q2JxbDrOJYmIHFf+KksSNrJWlKQLE6hAHm3Fg8F0EwkdssLO5elHO1/Mg54WY0O6aqhebq66ncB5p/sVKK3QxOKikax0Zae7E4FinzGjLluFhJdFjygzckS7Htjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pS90VLxScPKpFZSu1xD+Mp/QkxSAQz0UVJdVC1Gia3s=;
 b=KGVFyNoFAefisuh0DGH/eY/Pn4BbjZCMx/sHAE+b0fNm20OhY+ovL3PdOqQAoVa3IrO+TsWRa0W24/oAplnFL7wKvPqOhDIRHDyAOqPoCJxYZ1ii4737FR9aODjPCbevsGqrxw8BKNJm1h2MnBsSwdBj1s5DdCofwmKUSQAvS+dLAgGD15+XN5ca29fZmTN0oLB5Z8zNUqcABCgKJ+qGXehIkxh80tTpEAuEzSXoLWw+zoTyswiNAdTCqEne9M7N4zpHTdHKxEhz4iYMsbv26syIPnHqc94fMaF4uDkK5eZM69FEvRu2wFbY9S/4DedNpQHr8u8TcJv6JgbVOTPpxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by BN9PR11MB5529.namprd11.prod.outlook.com (2603:10b6:408:102::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Fri, 29 Sep
 2023 06:22:49 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 06:22:49 +0000
Date:   Fri, 29 Sep 2023 08:22:41 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] x86/resctrl: Add sparse_masks file in info
Message-ID: <uzaij5sjnxv2oz5frdsh55xm5injcxuqcxqcuooz4e6cyr356w@5dy4kmfe7w22>
References: <cover.1695371055.git.maciej.wieczor-retman@intel.com>
 <3b7f8c61f0f443e303bc9c5075566b89ffdebe7f.1695371055.git.maciej.wieczor-retman@intel.com>
 <e72b4ba4-762c-e3da-60f1-eee4f99c87cf@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e72b4ba4-762c-e3da-60f1-eee4f99c87cf@intel.com>
X-ClientProxiedBy: BE1P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::8) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|BN9PR11MB5529:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e85682a-8b14-4db2-a978-08dbc0b480eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lR/JGf6mB580a4kQCe8lh7Ni8Q5tUCqPSEMeaXr4eVIAszguUmaBVFmTVpZbCHRJo55yRsJDttWOyCVB4xZndnL3vvRwRlNQpR+ReHc2k3Kgo1Nag0Lm/W4Zrgwo4nM5Kx8jFS5zkbdJoDt77FyPOihnPTkixsM0tq+gfQL+wb8yIwpnPQdRagecNEyq+byLqdZtaROI8erSoDW07m/Ce+/4zQNPDwL9zG2YxAX82LG36BgeNJzcwVWVacueh+SdxUM76zbWQlgwDoAURd+wbin/hWLStDbTPux3+Kzbhi9AKgSREkC1jcdLnssCqQ5kzS/PoKRPvTPuUUqbhp3NqOmq4CRhowaaMXNzQiAtSH4tYXjKyRwXOQAFJnhP9+VOQL7JgfNMzQoDtsbRCbpZAAYtWR6qRD2MscXu5wUt+yb4e+/DmtTRciiRtcwXp7enT3B5M/MM/H2nUoVet7SiTOrkYo8fzEiumFcz0oaQIZ5prBmkeZ5sos5+SZmPuuFxM5WxrK/F3K5pELWaWXNDgskRkjbKHetYsryR0tytuq15GVp382t1ICwqna2Ev2tI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2906002)(8676002)(8936002)(5660300002)(41300700001)(6862004)(4326008)(66556008)(54906003)(316002)(66946007)(6636002)(478600001)(4744005)(6486002)(33716001)(6512007)(6666004)(9686003)(26005)(53546011)(38100700002)(82960400001)(66476007)(6506007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?54af5q+LYvPBt/3nZeU775agYZ3b/q13KaU/aXkM4wU6tkoiSYbiqV8W28?=
 =?iso-8859-1?Q?LhYPJI5nzCbBr2OBIMvkkv5zdMl8apmxLmYTvAiE1D7UuIoq1eLjeG+Thc?=
 =?iso-8859-1?Q?WaDN0o815K+25HbPhUfuUKSfswm+EhrYdg//qXG1EPjxGOgPMTMsjvHQtw?=
 =?iso-8859-1?Q?FdZZpuNJH4cNYvcsIxjGFlN+uwy3s9kGszVdOaH5l9yGl7bmqCrpML21YW?=
 =?iso-8859-1?Q?o+Rino0L3wStVC5QWN1s/v1sdST+Al9iLmdjoC78JAV6zhykwY4RZBzZbI?=
 =?iso-8859-1?Q?b2wz2XWP9QUZoGN+FiN7nqI/ATGfKdA5xZ0xVaAvVjQ95xRVTQME8KVjUH?=
 =?iso-8859-1?Q?Wy3GtzTQ7NjglTrMiFlXcNpZp8KGIy4TN6HtO4QWMKsiKhYiz3/iBtRJ35?=
 =?iso-8859-1?Q?kqBVlHSUaWi+DFmFpohzCXoz/53LjWuSiaXGtJPPOvcWDQ6FNQZJx9O1AH?=
 =?iso-8859-1?Q?gfrfpsTig4b1xw+/9wtWKoK1PKXBcA5Adso8rgFJFOn/EnrZMsGbbfRzxN?=
 =?iso-8859-1?Q?ui1zs4I74uwGHqJ7nW+857O5cZLFAJNOpFNkAUkRRjqHK4zuFmgxZYnQqI?=
 =?iso-8859-1?Q?cDiMLOHDhZ+1c7/ZuBAQIunVRWgCDtvPNmtLxpUHIN9Le5/JgBWtzY1q5F?=
 =?iso-8859-1?Q?El37JfJpidsfZdEoBGpTYgB7X7qLv0RjX6HikUU9Wv5K5QBJvrlA5R4+NO?=
 =?iso-8859-1?Q?ecYWUVm4Jurpc8S6QudrKPvfBl89+yRb2RAdbXrKNNGoWElu4ZSuYZOkYc?=
 =?iso-8859-1?Q?W+KUKFkPt/uy5uXbS1uBuZXROKil3bRsdtFRnujdhNvTukZMbr89jvLZLu?=
 =?iso-8859-1?Q?hXC67fd6hnK+44i9ZarvtfkqXLIF8wlbHtWb4TFdOinhEqNCZNZ/F0ycpk?=
 =?iso-8859-1?Q?7oG6HsLPU/5mn0EVCeMmxO5DvFdEa6rnrZzLTPfXP1fuBJxtmzuYyAUTTX?=
 =?iso-8859-1?Q?kBQO1UHsCdNqd0bqAw9UZw324g5+lligJZLe3zjIkTWGLCpENSJDrodnRS?=
 =?iso-8859-1?Q?h1SMs5Q9Kr77HgHkNhCkPqL2KNseyKqNrj5nx6XwlDIkYrWx3Fna3gRPUi?=
 =?iso-8859-1?Q?EAdOT966svsSG5BUSiAv1squsPot4Cv8hX1gPEpw5OOV1yfWu1kPmYWrjY?=
 =?iso-8859-1?Q?netm6cPZzNlHBXRrNBUsmI/CWcHGFEh5rzFBs4yb6OmFRXzy3QPgE38uPX?=
 =?iso-8859-1?Q?b6AO2lbMGGOUJ8vL4VioB7sCw/5N12NJVltEGk2PuRorkBjUuXypIvXP7Q?=
 =?iso-8859-1?Q?vLe6uPAVls3mK8+AiSH3EoHW5vPwcdfztaCYCtca+ZVkqxwryKm/xz2yft?=
 =?iso-8859-1?Q?m46iBJH94ms/XW93CtWBbwlDGDRLzGUZRb+oNnFHYe/NwG0kJvfR0mkvC+?=
 =?iso-8859-1?Q?AywcLTGzjrU9d12zhpS7gUJfW5xxl6mIj+Jh1vHjq7g5yWIe6bI6XA4g2W?=
 =?iso-8859-1?Q?m/SMr7b3rx4sMCwlL7k/SJY8G7BQUdN/nozDe1oeg63NVvQHEYnZAYVcIe?=
 =?iso-8859-1?Q?WifeMRXIUK6WUDYpiVdzEYIBlBueTd5JVgChyG/wQMfilp7ZV79SSLLH92?=
 =?iso-8859-1?Q?Nb7SkbZHqQLE6D0nz5NdELaKRoUaQuy7UfMgGB/LH0NxAdDPw20KPXeGEg?=
 =?iso-8859-1?Q?/aauqFbx656ooqdBwAt5q3qLf6hMh3FDhtJMoTxg0o5laOwQmdoraAeGJz?=
 =?iso-8859-1?Q?3EAk2OdBlQsU7gbzhfM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e85682a-8b14-4db2-a978-08dbc0b480eb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 06:22:49.4196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkkEPyefhzcqRPGRysOj2NBQfWQW+VR+5QHQgD+uX/AGdLDZU39ErW9ztVaEKlxiIV/czJwmmz8h6x++D2EOdXWqO6J73Tdgsl5dhNsO8ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5529
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

On 2023-09-28 at 13:47:30 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 9/22/2023 1:48 AM, Maciej Wieczor-Retman wrote:
>> From: Fenghua Yu <fenghua.yu@intel.com>
>> 
>> Add the interface in resctrl FS to show if sparse cache allocations
>
>Should this maybe be "cache allocation"?

That does sound a bit better. I'll change it, thanks.

>> bit masks are supported on the platform. Reading the file returns
>> either a "1" if non-contiguous 1s are supported and "0" otherwise.
>> The file path is /sys/fs/resctrl/info/{resource}/sparse_masks, where
>> {resource} can be either "L2" or "L3".
>> 
>
>Reinette

-- 
Kind regards
Maciej Wieczór-Retman
