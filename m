Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934917CBC10
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjJQHMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbjJQHMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:12:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECEE8E;
        Tue, 17 Oct 2023 00:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697526768; x=1729062768;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bv5p6lhsYAMvIZfnI8/YG5KQSIwk+CxMN0ND0G/NJEk=;
  b=hYYtg6WXflBporMWncRrGhW3CSdSF+vqDigFJqXQPWxHHNqbkP77FQoJ
   9qldiZFfqQTbxDu6e5l5vBbQ3+/7hv+19FJvR0YFpY8BPto349Chr2GkT
   qLC6K+4EhSrJ8OVHVm6T3rjvxRoSO26RhNE6JiKa4HJecKCejVgKnWpNp
   DrMad+Uh/qxE9XlInIb5vEPTysWNlqFCyyJocK1CSXTWgXa/8/xtlbLUe
   vdKP8YaCo2TatUgJ3dzmDFc+Feh4XGRw8t3wMfM3Lm9PDBYV9DDHKKmdH
   CVtSDA6Ljkv0f44ONWW3MgpU2oIQ6G8cWWRpEXWKIYrjtwK74nkCJ3h0X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="388579249"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="388579249"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 00:12:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="749574733"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="749574733"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 00:12:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 00:12:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 00:12:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 00:12:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 00:12:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zmq2ameZn9JmEMJo8bjPABBy2saENenX5dSXkcYaKQqmWE9u+Uw0/AiyuGsXBavfAlctpGZ3K/3QBRixjKXy2UMcXtFRm5/J2u1QSwsmpOFrY5z8s25YHbNwIzTPvwUAIwthHioIkGH1Lvni+9gTpO9e0nAS4zvMffB6T4bCBJoWo+GtJdg03yf4HSwRhW7bFAeDh3xIygFhuKFDQ0EgIJDWkMvPKmEyF1b6grouvSPh6TQNdY2D8cAkmg5qUtO1ZGmVlpH7t2Nsn7R2bRQYlatpxnWRWF/ogczJgzlfnFrP2RXP/ayTV/ZbtQbRqanEYW1dIUFIslQQCgeCL2Yrpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zF0xEWHGeilms5hzU4PnwJUeOn9mzeqPNrmbx2oh8Z0=;
 b=PGbt10XDOm3vfmK1aqsX9Vm9R4+HbO5Tiq/uGN9aAXYIbW1qVV8YDe6vD1ixBbr43XWuVDHU7EpMABMAEGSbqr+5LZs+YYut/cyaEs2PrpLb4KN+7SALNB+U8xQaalpxidD0fdQ3UknMoo1nd9x1yysIAqSyBWFwWz02+C4DLczOdlqV1C11eTuQzb6KL1a2tO3oKEI9cRKpuFP7Qg8J5lxM7pM8XzHGn18RQZjPMr/kLQyJu+KCWyKRb3Y/oTI4w2vL2IFcFYIbvtAJDPL2/ZXrMtiXXkEe+1GFZrOU/X0IGWBKn5dzCJn3hi+dPy5y8pQCoKlz4rmzEpIu7vEZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by MW6PR11MB8439.namprd11.prod.outlook.com (2603:10b6:303:23e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 07:12:31 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17%5]) with mapi id 15.20.6863.046; Tue, 17 Oct 2023
 07:12:30 +0000
Date:   Tue, 17 Oct 2023 15:12:22 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
CC:     Jakub Kicinski <kuba@kernel.org>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Liam Howlett <liam.howlett@oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        <oliver.sang@intel.com>
Subject: Re: [linus:master] [connector/cn_proc]  2aa1f7a1f4:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <ZS4z1mxtTIEpFZI/@xsang-OptiPlex-9020>
References: <202309201456.84c19e27-oliver.sang@intel.com>
 <20231004084011.7aeef442@kernel.org>
 <E79EF019-0E7F-4935-87AB-6A543A134E35@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E79EF019-0E7F-4935-87AB-6A543A134E35@oracle.com>
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|MW6PR11MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: acce535f-074e-4484-bfbf-08dbcee06d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lgPgJKW8tJOi7THwTEoA+aAJ7UGX+No7FnmRsgnPj6jrIcxJSa48dPS4Jm54ijRrTml+SnDcEpLooWZJUvln7XE3RJbti89rJKICDRAfY3B8dvpm4cweOE7aNxJxGfH+iHorq1QccF1PDdFqxub/btJ9WuyI2wWQlKcAAOEwfcK6b9YbVHjvEcPYSTJrGdr8Cjj15mr1PYMJD2B933A33agf42+IzPZCIYHxeM2Jh7z/t1QYFytcp5ltKy86MN8FkfX81MQiffH6iOeHhWpXkoN3Kv3NtxbVNj51O2wjCGMEUnkF7qInAU3W3exmNhynOpE7h+VQlRGdhpzUNcraQBuov/0CyqV6j2bVekg1fJboTqrPl6UcLzG5tq75/rV7EshnIFeXQwaoLnZRBI5em1OpFFEieio+Vfn39/4dy+5Pdo5onbYM/fbwBh8YSn2YAatWIUY+qwHWdxAAGQJx/ypuG5yePBibcZBEzefG9ncqKmRZCiJba+wlPE7Peh1UhNPChA6gDaEliMnpFqs/3m9DY2Pbtce0ErMqAErCbaA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(366004)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(53546011)(6486002)(966005)(82960400001)(38100700002)(83380400001)(6666004)(6512007)(26005)(6506007)(2906002)(54906003)(66476007)(6916009)(316002)(478600001)(66946007)(107886003)(66556008)(44832011)(86362001)(41300700001)(8936002)(9686003)(8676002)(4326008)(5660300002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K01nRUhLQUJsQXBlaWsvWDdmbWVCODJwcUdzbXBmY3dRZHhHZVYvUFNIRHFK?=
 =?utf-8?B?blNTSWYxQTdpZHpJVWZvT1ZaalF3VEs2QWxMN3Z3a0tQVlFTSkRRa1ZEUVJp?=
 =?utf-8?B?c0VuOUdRU1FXNFA1WDFhY2VSODlBbVp2ckphODhNV3hIaUxGMGU4TnVuT3la?=
 =?utf-8?B?MVh4MHVGUGQyOXRhazA1dGRVRzAwK05iTFhHV2FlVUpnaWxNSzlGT2tlczZZ?=
 =?utf-8?B?eFlWWUppQVJxUUg3UUNLd05wcC9pNGhIVGJGSml4WmVES3hMcG5DNmVvK0oz?=
 =?utf-8?B?QldNaU9wbEZTZUVBUjNHVDB4SFNSTEcyM0xPZnR0VHFmTGJPRUhEazgzSDh6?=
 =?utf-8?B?dUlLUndyOTk2QzNhVmxRcURWUHdiZmxaYmF1ZGFWLzBRMlkyakRJdGIra1E3?=
 =?utf-8?B?WEdtS1BXRHliQlEvTVJoak9IYVFBbUdsMDFOSkRBM3ZyNjh4LzZPU3F4eS9K?=
 =?utf-8?B?RnA4bFRpOGxOc1Nodzl5eVdSTEJ4d0JnOHlDK2F1cnRSSmhhU1EyOVdVT2hm?=
 =?utf-8?B?OVBEL0JvVy95YnYwaXZmOGdYejdWTUxWNEJDK0RtMzV6UDZ2cE94WXRLQnpC?=
 =?utf-8?B?a3Y1KzF4VVFSQTZTbFhUemh5U2tYT1BTakdBNjhOeURzcmlnS1JUa0REM0Ez?=
 =?utf-8?B?QkZ1SWhUNlJoUW15aU9TSkg5NjQxQ2J0alFJUXAvVWJRZEEzRkY3d2VRbTl6?=
 =?utf-8?B?TVRsanZseG1CdFZQbjZodGxyZElubUM5WnFyT1pqSjhLYStDZXNNb0FNdnNX?=
 =?utf-8?B?VXB4NlYzZEdQd1BOdVVGT2tkb1c0TXRrSTRibnVGbUszTjByWXRvNmJOV0xO?=
 =?utf-8?B?Wk9uTUFUbFc4K3dmVlBaVGFSZ0dodzBabFdTQnFrL25MYmEyeGJ1VVdhWnBT?=
 =?utf-8?B?NkZhRjBvUDJlRTJVZStnS3RkK3ZDVGZFUzZvQWY4U25BNUJwZm9jZVpjOEh3?=
 =?utf-8?B?QUovdUVSRnFlZ21SS0I2RmU3SktCODRqTUNHVi9uMXVqTGMvMzlLZkl4ZE5m?=
 =?utf-8?B?cHA3WHJzTjdCZ040TjRyaGY3NytvRnduQUpkMG50OEthcTZ2bmR4NVZqYlFQ?=
 =?utf-8?B?Rm84ZE1ZOHIraFIyU25YdGtJU0lGd3ZreWJWOVlFZ1JkSWh5dDZwQ01LNmV0?=
 =?utf-8?B?WmlSaHdDaUFZSzBPcnhjeHI3a3RwZkZXem1PWUJJSmNzOXgxemp5UUVhRkoy?=
 =?utf-8?B?SmwvQXBuNHZqcFlDWi9LVytYK1k2V201L3JYRkkwZDc4VFNRNHY5dXZjZGtQ?=
 =?utf-8?B?U3pmaW5HUWgwbXhrWTJXMURXcDR6UiswbU1XRUpKOWdEQ0pXY3d6TUErK1dp?=
 =?utf-8?B?KzhhdTlxNWRXSitjQU5xYjRRMEFNRnRuUjFhb3dXbXkyUlBTaHJldnBiNEVO?=
 =?utf-8?B?dzhBOHE0YTVyV0xJM2hjWnpGSnQ1MSswNTBsTkZIcCtTVU00NVd3Wk1PaEtx?=
 =?utf-8?B?S3YzaWRJV1Y1MEowWVJZMThlbzBqNnR0S0k0cVNOS2pwYnZOQVJzdk9UYWQr?=
 =?utf-8?B?KzhZLzRjTGRCSjFiZWQzbmswRG5tR0p4SndFV1poV2tPbDA5a1grcjF3K0JT?=
 =?utf-8?B?eDRYbWtxUWMwN3gwL1c5SGRqZWppRmZYUmFSZmpyS2ZRS1lOUE9RdEJFZml6?=
 =?utf-8?B?TlpRMEkxNVR6R2QvRFlUZVBzUkZVRWVxUkxEbFBoclZyOUdnS0ZXdWVZMHNF?=
 =?utf-8?B?R1MyYzNQaVhEdm9yRlROTGVzMVlhc1BxSGtFSHg0OUpMTmRmQ3pwRG1tK1Zx?=
 =?utf-8?B?VDlXaGJtRkdOTXJ3WEY3OVlzc1NKYVZUQ2ZMQzlKYWxMdVgwTG1nMHJDRVBz?=
 =?utf-8?B?czJhekRxMXYrYlArZjRqS3FiTEZldFBiNFBNeE1pK2FRVFNCakV4by9pNmd1?=
 =?utf-8?B?L3JuTytkd3Z5SUcwcDFlajdvU3pmekxMRlpCM1M5ZVUvQ2dxYy8wNmY0U1ht?=
 =?utf-8?B?U0R2bUVsREowOGtrTlRIVGhYK0Z6VnFidmNwd2R2dlF5bUVsRkVqRW1mMGVT?=
 =?utf-8?B?blhXakQ4RkNlVDdWZ3ExQkpPb2JKb3hsRUI1TlBVYXlKZXk4Qmg1a1NVZmVQ?=
 =?utf-8?B?YnhLeXJkTi9kNm1WbkZTMm5WL3c5OCtVOStWS2RRbkUzNjUzZjZwM09jbmxa?=
 =?utf-8?Q?CN/kerLlBtNDGiS8Kq7PS01QR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: acce535f-074e-4484-bfbf-08dbcee06d2c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:12:30.3776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30ZCvrWjp+ofGXbbwgh4DUn13EltKS8xglQBaJpr4d9nXvCeGDpw30x6LBkBXeDd1Fg7eyFTsAUQVbCI12F5ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8439
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Anjali Kulkarni,

On Fri, Oct 13, 2023 at 11:00:31PM +0000, Anjali Kulkarni wrote:
> 
> 
> > On Oct 4, 2023, at 8:40 AM, Jakub Kicinski <kuba@kernel.org> wrote:
> > 
> > On Wed, 20 Sep 2023 14:51:32 +0800 kernel test robot wrote:
> >> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
> >> 
> >> commit: 2aa1f7a1f47ce8dac7593af605aaa859b3cf3bb1 ("connector/cn_proc: Add filtering to fix some bugs")
> >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > Anjali, have you had the chance to look into this?
> 
> Hi,
> I was unable to reproduce the issues with the steps given - many packages are missing, etc. - I am still trying though - however, the stack trace of this issue shows it is a NULL pointer de-reference (it looks like in cn_filter() function) - and I found a potential suspect where a check for NULL pointer was missing. So I’ve sent out the patch fix for this - is it possible for someone to please test with this fix and let me know if the issue is resolved? The fix looks like:

I applied below patch upon v6.6-rc6, the issue reported by original report was
gone.

(and I confirmed the issue still can be reproduced on v6.6-rc6)

Tested-by: kernel test robot <oliver.sang@intel.com>

> 
> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
> index 05d562e9c8b1..a8e55569e4f5 100644
> --- a/drivers/connector/cn_proc.c
> +++ b/drivers/connector/cn_proc.c
> @@ -54,7 +54,7 @@ static int cn_filter(struct sock *dsk, struct sk_buff *skb, void *data)
>         enum proc_cn_mcast_op mc_op;
>         uintptr_t val;
> 
> -       if (!dsk || !data)
> +       if (!dsk || !data || !dsk->sk_user_data)
>                 return 0;
> 
>         ptr = (__u32 *)data;
> --  2.42.0
> 
> 
