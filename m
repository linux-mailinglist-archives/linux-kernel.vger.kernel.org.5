Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8336C7A2EEC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 11:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbjIPJDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 05:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238670AbjIPJDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 05:03:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6282170E
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 02:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694854995; x=1726390995;
  h=message-id:date:to:cc:references:from:subject:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yDwfsvx4sGgxut2Mwpp+zt2UmfVUe9/6WO/i40jkh24=;
  b=mBIoZCXCHO48G/RJLrBlkdhH5K1xOEpCV0TafK0UETLKbgACZ30P5a8z
   slCdq1PermCptME9lKI1nGOV2lSZi0yEN5Ddl6Hyow6+bjRhflo6Z3win
   0rGLXHzQmDL4uncH2Dn4xTUfM9F41AtbdvkZpM+BJU+fDYOif6BlUOt8d
   KVd4hrxinoCOkVzqu9STmd2ccE/H25zKhLVgR+8/O8Qsz3R6ScLscljL0
   IoZryGlB/sE3tRF3bY4zGmhGzl+WTlLBQ9Pfm3amrwpjJ8WKMGn9V3Svy
   aF5JK2cLHkehfRiQxJJt4k7hHyIZz3J96wlyCGCO8lvU1rOcbrlx8LRw/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="378308451"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="378308451"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2023 02:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="738593871"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="738593871"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Sep 2023 02:03:15 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 16 Sep 2023 02:03:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sat, 16 Sep 2023 02:03:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sat, 16 Sep 2023 02:03:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTitvSVCQ8ZZp8YpmmqhhnsXCRiC0EWW8/pPCymLcOSCYURkkQcCO5mYL1hHwn0A1EbI9um7kM8ty0hjY6/tDJWH9rBqLY1clNT5gdKYUSrmyjOdWF0CBfO1BmEA6fo6qsbaFLK4g5xhVLnNjtKwOfkFQjuDPLj05sqHN1qIeqnxuznPbXrRgRinJvnQ1C2tB4wpfMWmzrhusk65MkO2ExjHghWk0+PYnqnmD8aJMgE78pqJn/UmV3lGMHmt4dhg+DB5eW6++Q6bz3yjWBfVHdtMyK74m+nICQRJF733MyWTcYAW2jm9DBQs3P1W8U+3QjygExxitPZZlwVikiKIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amL8IxWyBBYqPK1DLHPWJ1iiONPSvU0BvlwUKXFa1lw=;
 b=j2NTYRtBcCEfTPwVNqXv+7p2FrhDfW0Kx/YcG6YeAWy7slaFCKCQtAmzc34SUxAJHcnuH2eRW9SND6ddSaYwEZFS2WmaqIfYw/fQL8BqD85DSEChuGnKvfaagI2r7f+f5DPcryXbSVlIrQQLM9XjSEeV6el8ML742td8qN+X15hj2FvMJA898W6c+f1Njo1rLWa8WV+S/sZeH/s7Md6vySSSTTY0Gbe9ljcRVpDphZCITHDWWyG4kxHipF37PLSlSf6aLzhCa/KgoZ4CzzymAFu/xkqYoQCPQNss45y9dsKS2zFTjXjyJLzAHrNDpOYd5ewSW57UVO7IuWU0/EbnEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by CY8PR11MB6890.namprd11.prod.outlook.com (2603:10b6:930:5d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Sat, 16 Sep
 2023 09:03:07 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::388:a305:5017:8453]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::388:a305:5017:8453%4]) with mapi id 15.20.6792.021; Sat, 16 Sep 2023
 09:03:06 +0000
Message-ID: <1e2ecded-c1f6-462c-f66e-756a9d76c41d@intel.com>
Date:   Sat, 16 Sep 2023 02:03:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        Fenghua Yu <fenghua.yu@intel.com>, Peter Anvin <hpa@zytor.com>
References: <20230912065249.695681286@linutronix.de>
 <20230912065500.823314239@linutronix.de>
Content-Language: en-US
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [patch V3 01/30] x86/microcode/32: Move early loading after
 paging enable
In-Reply-To: <20230912065500.823314239@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0167.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::22) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|CY8PR11MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: d99c8b84-a064-4ae9-2073-08dbb693bd67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ssNFxdNdw/MB3dzz7XIgOGVs6DYabIXtmDo3TpDy9iFgODbDGvH3qVNi/prNg2aFHIO24rrsf92g7d9PZ2/0i5bf7olJwgh+5+QJUuv9nV4HZwWxBOFG8eVBxb/WOafZ2wYSntmt5COuO3Ywhe9JyUHT5MTZcUvQ8npJ2IRGBHr6uLP4L9RNl09Fl5aqDbt2PoE4Gy9SOzjnBP3yw17v/nOumfHmrUyK+WinI0QetMplCnTbb2evhkLdnkDpolkUvXN3jzPd+p3FhCJyltzTiWYI/9XnStliK/9xpYaRaap8f3i8cUVfiE1SNkg8btNoPTuhAjp1WzYmKhNE+GNQUHKsCPTG4H67TOt3NEXM/xlTsEZjqhovrd2p2lh4RLzNtIrNflwwxePxPHaI4sTnmAwyHLKfveSiTcfo8OXe0XBlBZMJZgj18P/uH/sKZ+rO0o5ErPelJ+clpI8tinSnlpClX7wOzTlD3zSKcu+KcsgY9auN9V+pTixG5pm7ocEy5cI+1rYry2Utx0rNyPuPiRvZtM28tSd1ConfNs27c7f8y3tww/lBBDBkOaPHyDBCUPujMrs8oENERKwZys+J+hhsFObqPD83osP+Gx1okvz3fIj49fRwQKJUAMmq3RS/CWjnZTJ591z1eR4rFF6Hqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(136003)(396003)(186009)(451199024)(1800799009)(53546011)(6486002)(6506007)(6666004)(6512007)(478600001)(26005)(2616005)(4744005)(2906002)(4326008)(66556008)(316002)(66476007)(66946007)(54906003)(110136005)(5660300002)(8676002)(41300700001)(8936002)(36756003)(31696002)(86362001)(82960400001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjR3Q3VpbGI0WHRaVjVWSFk3VG9qUjJBTTFPZUY1NnZuN1VPNU4xTFdzY0sx?=
 =?utf-8?B?QU9JZlZYeEFxZHJEUUptM1FoZU53TUVCaC9RcGFWbm1DcDBpVUx4b3RrdXBW?=
 =?utf-8?B?MzJsV1RGR0tqbzhOTlpYSTM0Y3RaenU2SzdUUVdXSXk0OTlYMFdvUldPenlQ?=
 =?utf-8?B?blhKMWE4allRcCthaWhSWXJuVms5UmpPUjNFVlM4U0R4WTltREhzbGEvNm9k?=
 =?utf-8?B?MjBRcDdUNVhGSVJiQlg5RkxtQ0RJVUNubEU5NzdiQ2ZCOU1IY0t1c1hXeHMr?=
 =?utf-8?B?UEJtVGtqQkhQM09NcGkrQUwzbjRwYXpweVhyMERPQTZVMTBlYUFrWlBsRWll?=
 =?utf-8?B?RktJUGE0ekZheGtUTlhKL0JwZk44c1VtZkFuaUF2WWwwZlh4Nnl1ejE2MWty?=
 =?utf-8?B?OUdzaXlOWHNKeEhLUXRNNEN5Ny9oRVJBT0M2MTZyMmdwSk50NjlpMVFId3hN?=
 =?utf-8?B?M3l2L2x3cTNNR3lUek9MaEx0VmdBYWV4TjNJNUgwWFlqTldJZXBCZXhZeFp2?=
 =?utf-8?B?WmY5M2ZTV1gzdzQyQUUyRHZ0cUNTYk9MR1UxQ2xYcXZwZGR4clcva29vbFFp?=
 =?utf-8?B?WjFEQmdsMmhTV2M0dTViQjRQSVpNT0x6TmZGcTU5VXhGVWFuSUxvam9PSE85?=
 =?utf-8?B?ZGxjK1ROQlNLYUxFV1EvVEZFZVlmL3ZGVnJlejlET0xkVXdLS3IrL0pJTlZS?=
 =?utf-8?B?L0tEa3JuNmV6VXpKRnN4OFJvQXEzODlVUHVzVW1JUUYzRzlMM3l4UW1DdW9h?=
 =?utf-8?B?bkpDZGNiOURnMHdtYkJzTmRNM1NmTCs2YWN5MWxZTk4rTzd5N1lRNGQ3WE13?=
 =?utf-8?B?NzZablBJM0x5a2g5NE1RcTJBdEhBVXRsZExwYUhBVzdFaTc1ZWdtTFJDYmt0?=
 =?utf-8?B?czE0Uy94NEJ5dmJFOEdyTiszVjUwb0tQNFJQbFh3KzZGTEdCVnFXKzUwQXVt?=
 =?utf-8?B?NkxFV0Y3OWlsQm95NFh6alhxbng4REx2bEJodlFrQTdraVBQbW52YUdqa1pX?=
 =?utf-8?B?bm55dEl1NldWU1FXaUc0T0lKVGlRQU11MCttb0ZJSldtQWdCVW9IcDAxV3Jq?=
 =?utf-8?B?c0lpWkJtSWRsdklYbHZ1eGVtOHlSTkJGWnUzQlBiaTYwN3ZDNkd3VStNVzhn?=
 =?utf-8?B?Q1VlelAwWjRFYmxXS0owUlVBS0ZpN1MwTVgyMFM5SnhycWcvQkxKNjRaL2c2?=
 =?utf-8?B?b3gzajVaekEzSW1ZNGxYL0YwRnQ2Yk83cTRrMlp4bzVsaXpURWFWcWwwR2NQ?=
 =?utf-8?B?WDlmQlF2bTJ2NW84L1dzYWhGSjJvLytudHJLVisyeFlQWVV6cXRjRVp6VnBH?=
 =?utf-8?B?Z2xnMUEzYWYvNlJ5YzkzeDFXOEhuNUorN1hYRUtsWkhXODFzcXdXSXFwUHUv?=
 =?utf-8?B?dXRJb3BOa2RtN0FZOHZ0M01IdTBVTm5oVXExUHhXSEcyL3ZaejJ2VHBrOTRo?=
 =?utf-8?B?TGdiR0c0SXdUTXhRTFVKZWVSWmUya3h2Q2dmMmZNZm9veExnUTFQSGg5Z1FR?=
 =?utf-8?B?NG5HT1g3a0JDZ3A5WTM1QTl4clZTck9Sd3gyRkQ1OU0xbWxOdVpucy9STDBs?=
 =?utf-8?B?WDFrcVVMUGdWdjBDa0tXRHNxVTVmdzNQMFBaVjVpUUJUZU1TTVdKbk5jbnBK?=
 =?utf-8?B?QXc1dzQ2bFA1b3BNRDhsTUVoK0ZhVjFwNmFxWHowSTRFMzRpNzBxZVJxMGRy?=
 =?utf-8?B?d09LbVd1TWtNL0ZDKzFqeXcrdkRWOWFtM1VVQ2kxVllMLzQ5MlBGeDNwVk9K?=
 =?utf-8?B?OWpqYnhtcnVVS3FhSnp1UFlhZkl3UHNJeEd0YlhaQyt5OFprelRmY1FPQ0Qw?=
 =?utf-8?B?MTZpSk9mUHJIYWZ0SSs5U1dvOVh2NzlXOUZVT1RjSU4wdkJTeW11NFVjMFhr?=
 =?utf-8?B?amR6dWRpZ0ZqOW9HOGpwVW5zcS9jNGxZOGhTd0ZtWHpXMWZIMWxPREgwWmdq?=
 =?utf-8?B?NVVwRmJiQ3ZXb1BjWGNtMTlLSC9hZnQxd2JndVdVcWFRY3lYYTlpYzFFVXp6?=
 =?utf-8?B?TUoxOEJJckxJRFZoNzRGeFp6Qk5BMGdMOHcvWlZFaGZCNG52TWQ4a0RjTHI5?=
 =?utf-8?B?WmVSQzNWcjJXeVZFQmZsa2h5QVFQN3lXaS9uQkNPcVpMQXdkb0pTWitqeVoz?=
 =?utf-8?B?bDFVMWoxdHljYWl0OTFGY3M4Y3JOWnJoRS9MMXgrTTRVWFFlMGJOdEp2QmNa?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d99c8b84-a064-4ae9-2073-08dbb693bd67
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 09:03:06.0014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzhZbGFG7jlrr+kRwxBJKiZ+ieoXJPM1kg+UpOWjCEq7rT6OwpLIg3ldLl2OPmJAm7LrVyudsSXYBzspcFbdjunOc0b5Aoj4ewpzfN6XMq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6890
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2023 12:57 AM, Thomas Gleixner wrote:
> 
>   static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
>   {
...
> -	if (early)
> -		print_ucode(old_rev, uci->cpu_sig.rev, mc->hdr.date);
> -	else
> -		print_ucode_info(old_rev, uci->cpu_sig.rev, mc->hdr.date);
> -

Nitpick:

with this change, there is no need for the second argument -- 'bool early'.

Thanks,
Chang
