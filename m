Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BC878CB4D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbjH2Rcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237911AbjH2RcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:32:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783ADCDA;
        Tue, 29 Aug 2023 10:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693330314; x=1724866314;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+NH7FEg8n8ze5DOUyfwiXVdSMIWcXubV5YJ/rDmxKcA=;
  b=PSsMj2Z96WqFgc/qDws54eFfoVS3m6w+NTSQ2GveXyEkeKh1aa3j1Uds
   HUoTiOK19qYFY5Wq1fkfZClVE4zESyuW8bY6XndePw0h0BaiNFF95xxGo
   jFcVEK9CaAxHL9ryOvRn6+x4XL1ogiFx3iaE9S6hcQTBEE0/n3GaKjx65
   LC/VRqsqIgWjfkm+aqDNQYDhE4SEETgqzka3qaKdyQP4g09J2DydTZOGL
   SDTuVbSXK+x87M3+260aId0fUnxYByC6ZJq2oqDcQLVojY28B+Xb0iFL8
   k/yMkJ8LkaPEf3cBDZPRVHWrBQ7A6MfJYbFQ5k4ATFEp7os5E4oUaLha7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="378152166"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="378152166"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 10:31:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="768146898"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="768146898"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 29 Aug 2023 10:31:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 10:31:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 10:31:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 10:31:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 10:31:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neaGuY1uCc2UIBbsNI9zBNWEZHEgmyUBKsWrWEUPFvaj1pJ0iQlRPPZGVLoS8kn6OAF0KS2ZLevL5Lm4vjz73vhuLKF+C6STVQawA3r5lQ2wlaFg5kuEtp7kqgNtUxnStuKzfLvan5AgZtmOClNHe18Q/L9WxLWjifijN0Exo/F5NH2huo1b1mTEv4TJhM4/3QJ7ZO/2ZuZrpsX6My95lblZPE2Qd8oAzkvPICqsyAu+kRswSoSONV2Dj+DO4palybgfpdRA0JMHXH4nlIVRe/RRevz0cc81aOPFlPcvtLor0GzdDax+O2WSPGoBJhUU1rWlWaWUNfjTRpmDQRpV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtQj7kcrhM9IiaojvtUZF+ksluQOznooIvZdYuWEvNA=;
 b=PVx4YSgnXZLEwpGkXvxRvWa0Bf+n4uc1xRA2O7w2lbFCKyEi9d1MgoPpWhux0zdM54hb29FRglBCwOFZ5FhV2U6KnflmnXwubR89lE7jvle0WmFnhF/jLn13zIMisK1BsgBltdrqzjR4ZJFaTuV5z6ZkntMfSJ2h/IXb0woXHHsjmo0C/4jGzWEH6nm9nDJe6uTZLbvgStznZkbibJnwrJmoPabzGA4GZpWP190gAQMGxPgh7PyQYsG1HbaZvJnNRXRAFIALDtalvKTYq4Zo3Dbiy61+V6S5AoO31vDVRnHB8hIYq7qwZpHN3o4o7cmU2Robc325ZeZ5pATDH1x9sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CO1PR11MB5171.namprd11.prod.outlook.com (2603:10b6:303:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 17:30:59 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::cc12:ab15:1d0:af79]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::cc12:ab15:1d0:af79%5]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 17:30:59 +0000
Date:   Tue, 29 Aug 2023 10:30:55 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Andrea Righi <andrea.righi@canonical.com>,
        Nick Terrell <terrelln@fb.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] module/decompress: use vmalloc() for zstd decompression
 workspace
Message-ID: <4ut44zckyknjwdzvxzefiysfjorl3nzqvs2j3scsrlgmgngjgs@hjrkcqoavq5h>
X-Patchwork-Hint: comment
References: <20230829120508.317611-1-andrea.righi@canonical.com>
 <ZO4fvAKJfKs8USZO@bombadil.infradead.org>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <ZO4fvAKJfKs8USZO@bombadil.infradead.org>
X-ClientProxiedBy: MW4P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::13) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CO1PR11MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: 655db974-4af3-4a3d-c76f-08dba8b5b522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qv3TygFc7rxSmkhop9v1w0DQdQZWZQq/btmGSgrv/84EHNiBRe4WV0++4aoUkMz4sCEXMeM2Eh6ELduOhMEx5z63G2rc9G5av+Rjl715TGbaHW7z1BjkPqVZPob1RFqBVLgXEvqyvAcTyAHUi163GJ5K/BiDElbj5dAAN/+GcmqJEcse0e3N1ZsfMRsKvNtTm0FeJ2imhDAvrygVHTOmNfZC2iieATGFqf1vmZE1lfQZeQvgqWu+baUqQXkfBV2ScL+J1P8QF7vAGsHuI4AMGzbKnDKlCYu4DM5pHb490pyIf9YL/S6PtGpvoc/r6PqpSepR9PRGDxF6B8Dod0I/8cdqoR7Ee99d3Tx0Ll7/TG7GRawLloAZ164JRHGHs8dCs429IhN8gPoKKwxcMAUraIG6CSElT4fWeGoiQbcvvLmGiEeMpgKUn3pGs1Wss8GICig8rC9F+dry1PwsdmT0pkx5Pw7mrL0yxoXYy+wyAFyHRuFVIWTNOHqo6ZU4urKRn0h1egDmhvzLAS4rLH8c8cQ/phClhOPZa3MZYda1ho6UKG2GMJMahszDgIUh2TIz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(366004)(376002)(346002)(39860400002)(186009)(1800799009)(451199024)(6486002)(6512007)(6666004)(9686003)(6506007)(86362001)(38100700002)(82960400001)(2906002)(83380400001)(26005)(478600001)(41300700001)(66556008)(66476007)(8936002)(66946007)(4326008)(8676002)(5660300002)(54906003)(33716001)(316002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eH7Ungrq3pp1vGqerBcY1+1l1dgNXpCEJjE8z1AbUwsbYTK0P6DpIEGOOTTW?=
 =?us-ascii?Q?s3ou6z2YGwCTXwPPeGCUyHkB+mtRcqg4sGpW9MDilz3VMwPO1S5JM0uuQoq+?=
 =?us-ascii?Q?2M5rVbG04TedSEKbfy90GbmPEyLqPFv0pHxBmLyiOCa98KEUdqWJ2bJYw2lk?=
 =?us-ascii?Q?N8B89i88XluMK1CNpib4Tr6Kn2eRspTNP1850BhivUJQjOX16/tS5+hvBUn+?=
 =?us-ascii?Q?/MpnVVNVspdXW7d6Ngc1Rf/Frs1dwXi1+enrsKvY1Pbryi2uYl1M2JVrZsTq?=
 =?us-ascii?Q?mvYitgz12lRKRVHIFMY/xRQlSPM/I60kBYG2r7vLjt1HabqnOHS4g9zj23gX?=
 =?us-ascii?Q?i5fxTh6nUuYah7CDdVefqZOmViGU/6EKnhJpyXyObg8silZU/QPtcg9JBjs5?=
 =?us-ascii?Q?zM/hL2azCDm8nq0Mn2JATk2OBmkAx6Qq3bc3EaWaUnWa2vjNmqvh933UJST8?=
 =?us-ascii?Q?tlCe9Km9MYr7kd4o30DNcixd1YiSSEhpj4+xfYJ6+grpDywwJXFk+DzWSY3w?=
 =?us-ascii?Q?z8hOfUuLG/szOgMTkv5Uaa7Z29FMb4RESMCpfoQ20O7Us3zBypj+Vmx+8aFc?=
 =?us-ascii?Q?Tj6hBy1gLBgLPVJIhPOgZsC7oafKg7mDivzW+rV6byP9IEHwUm3lh65B8M26?=
 =?us-ascii?Q?zwnpAOdaRs/LklsTe53c7ns290YjVPzhV3vFABNGrSugrl667MNMNgQU96gO?=
 =?us-ascii?Q?J+7T/sFUZuMu8YrH6nHNeDzrMXtfd1IRkxCPNVHFwQksgWz+rmwRRmxzJk95?=
 =?us-ascii?Q?FyeZoeU5Vr67q0iIMSJRUU7IQMYB/2A3IU5gy3YHVD/gKRPhjbrGKQp9xL2A?=
 =?us-ascii?Q?fGt7f2jhRYUFFdXd6zv7s0lkSIcm8MplYTVwQQnqpou1ka5C2FARojUW4B6v?=
 =?us-ascii?Q?lvv+V3YDGp7lTZxu78QhmKVFvdkB1aRPpV/BanBdSXvDYmX4SMZvVhxLe666?=
 =?us-ascii?Q?m4qDBXa36mG2SBGi5kJtKSh0xbywkF1Zfe2KYIX2coKdYw+JkfDcLoNkFtdn?=
 =?us-ascii?Q?WMraZYHdoTcPQ5HDeYWrodp3yHUcl7avEu4+a1WX9JVsA+fuy+RKyg4iI6bG?=
 =?us-ascii?Q?SlpEmPVoXlHMssClRCVYwZmQik0VO9o7MtB8X3pXq1nFQyU775e+CDsneS8A?=
 =?us-ascii?Q?yQ3JhjReDprXUOmIZEYggiGfPdD1jqC8qKcUlNWsapVN6eXphzsbDkfGbM/0?=
 =?us-ascii?Q?Nh+36a62+ppAd5+qVm/AR4tmjYPzaWl90K5+vaq6xDJA5bNgBDZKk5OtxZMi?=
 =?us-ascii?Q?N8tX/fIEC9kwQCvXzlHSP420C7YpvVKGB3ftivVO7nRnj8SDMsyqcVOKmojV?=
 =?us-ascii?Q?I+1zS8c2i+B2uvGQoGOY042IBs2Mv8eVJIptFRZG1GDv0KoWJCP39HhFk99y?=
 =?us-ascii?Q?bmmCTd8HSfER3C0BUtddmwi2sYcZ+s6nRcyEFgTkDkeSZ/SPhNXWstWnaOp2?=
 =?us-ascii?Q?aaynQwoAzcIbicmUO9Frj35DuLV3oG0KOdAY0DXMz8NIWilRNCeLsJsq+6HB?=
 =?us-ascii?Q?bDmG3Y5eEy3AOpu9AZhPu59sg9ydId0Oq1WtTTwU/USimi5+cRmMi1/k/z2I?=
 =?us-ascii?Q?tCiwwzdgNVTXWXu+ooWEoAIM9h1nKi+ZU6x4vBvhkzBpgXrMqK9LKexzR9XI?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 655db974-4af3-4a3d-c76f-08dba8b5b522
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 17:30:59.2907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1176nd5gmEUxfQtFWa5xftI7FJ1LzFqkyEccjPCShoVWj10Fo6bQiQHeJkKeQjBNXonmjX+B1Vudw/gO7jmI7mOHYGkyCer1WHCSiSauKuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5171
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 09:41:32AM -0700, Luis Chamberlain wrote:
>On Tue, Aug 29, 2023 at 02:05:08PM +0200, Andrea Righi wrote:
>> Using kmalloc() to allocate the decompression workspace for zstd may
>> trigger the following warning when large modules are loaded (i.e., xfs):
>>
>> [    2.961884] WARNING: CPU: 1 PID: 254 at mm/page_alloc.c:4453 __alloc_pages+0x2c3/0x350
>> ...
>> [    2.989033] Call Trace:
>> [    2.989841]  <TASK>
>> [    2.990614]  ? show_regs+0x6d/0x80
>> [    2.991573]  ? __warn+0x89/0x160
>> [    2.992485]  ? __alloc_pages+0x2c3/0x350
>> [    2.993520]  ? report_bug+0x17e/0x1b0
>> [    2.994506]  ? handle_bug+0x51/0xa0
>> [    2.995474]  ? exc_invalid_op+0x18/0x80
>> [    2.996469]  ? asm_exc_invalid_op+0x1b/0x20
>> [    2.997530]  ? module_zstd_decompress+0xdc/0x2a0
>> [    2.998665]  ? __alloc_pages+0x2c3/0x350
>> [    2.999695]  ? module_zstd_decompress+0xdc/0x2a0
>> [    3.000821]  __kmalloc_large_node+0x7a/0x150
>> [    3.001920]  __kmalloc+0xdb/0x170
>> [    3.002824]  module_zstd_decompress+0xdc/0x2a0
>> [    3.003857]  module_decompress+0x37/0xc0
>> [    3.004688]  init_module_from_file+0xd0/0x100
>> [    3.005668]  idempotent_init_module+0x11c/0x2b0
>> [    3.006632]  __x64_sys_finit_module+0x64/0xd0
>> [    3.007568]  do_syscall_64+0x59/0x90
>> [    3.008373]  ? ksys_read+0x73/0x100
>> [    3.009395]  ? exit_to_user_mode_prepare+0x30/0xb0
>> [    3.010531]  ? syscall_exit_to_user_mode+0x37/0x60
>> [    3.011662]  ? do_syscall_64+0x68/0x90
>> [    3.012511]  ? do_syscall_64+0x68/0x90
>> [    3.013364]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>>
>> However, continuous physical memory does not seem to be required in
>> module_zstd_decompress(), so use vmalloc() instead, to prevent the
>> warning and avoid potential failures at loading compressed modules.
>>
>> Fixes: 169a58ad824d ("module/decompress: Support zstd in-kernel decompression")
>> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
>> ---
>>  kernel/module/decompress.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
>> index 8a5d6d63b06c..87440f714c0c 100644
>> --- a/kernel/module/decompress.c
>> +++ b/kernel/module/decompress.c
>> @@ -241,7 +241,7 @@ static ssize_t module_zstd_decompress(struct load_info *info,
>>  	}
>>
>>  	wksp_size = zstd_dstream_workspace_bound(header.windowSize);
>> -	wksp = kmalloc(wksp_size, GFP_KERNEL);
>> +	wksp = vmalloc(wksp_size);
>>  	if (!wksp) {
>>  		retval = -ENOMEM;
>>  		goto out;
>> @@ -284,7 +284,7 @@ static ssize_t module_zstd_decompress(struct load_info *info,
>>  	retval = new_size;
>>
>>   out:
>> -	kfree(wksp);
>> +	vfree(wksp);
>>  	return retval;
>
>Thanks! Applied and queued up.

I can see at least the gz decompress would need the same kind of change.
Shouldn't we tackle them all at once?

Lucas De Marchi

>
>  Luis
