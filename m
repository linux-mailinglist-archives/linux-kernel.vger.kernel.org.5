Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C207C42A2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344090AbjJJVd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343936AbjJJVd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:33:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9AF91;
        Tue, 10 Oct 2023 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696973636; x=1728509636;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YCr4TDe/uUtAJXHuGsxAZYyWhTW8F1DHvsTnvjUvxeo=;
  b=DW3w/moEcYGP6hSlaPkerPUAFONgpYJA/h7vEe1/Rv4HuA9dhjzUbjau
   q82xtr8931oEYP3nLcnK4yAWpsLrk3sNsic3yDcwJ0vnm6rd6nGexlr31
   Z8yrY+gOKtCup18/XLhOHfEKpyW3Z6lcLVcK9OOZr1WZns5n7tGhSbCj2
   vrtrqYu6IvjoaH0iReNCy5NQd4o3KbiN0tCJkCF0d96+G27wAJli2DPdr
   u8w2a5peJr76HVPXpysZNzaYv3bJCQev9aKzkhImcyQEPRlW1S619i8UI
   k3RNJsbPZCQyrzrxmCF1QXKUl2jGzRXu1e2q82bIw5E2EErgRHibkz2aF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="448708813"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="448708813"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 14:33:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1000843054"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="1000843054"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 14:33:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 14:33:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 14:33:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 14:33:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 14:33:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVSrtPxNT4p2fNKdug79C70AZaZjypTTlc8I11p1MzYmcAH8rmTVBAKY8V5svwFa8DESpluASefuX9qJr91Epaaxzx8GFWowg8E0dfI78mh8/EqTdqpllXUI9vffbFQ7LqO676ifQ/6aOFADWsQML8oA37L72bdYhKGUAnRmoHNUBpK5QA/M+c8XO9JZ+c8NQNsz+1jkpmfmUG+yRCupqSG8Wl0wmzXLyqyMK+VKnCv4AB7uAWGI90gKku7PEJ2VUrOK8NT4LL0Tw81o2aFpOCNKi9Eub/OQuy/MaDu51tFIUGWmmZqlmZfijq7i7NWTjEBtVZrargga9DgnmJ6Ygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMsSslUy80XarIkTh8wP6DBN0bJebS2can4775t+RwY=;
 b=MY0cOGMnkOvKbHgKkl9xIrYiRimT/uKVpHM34tofENESgNF2e5CwV8AWvGrRTuT/momGDYfKWORYVY+3Ya7yFhIbeOFfBRI7p6aiIpImjCl7CLvwqkBq0o4arMm10kV+1oTLMBEBWrrFbV2Kb4814JFBkhkagCLhBJxRl/E0dhABSkOw+TKXkuHv0nV6I+cuk/opr9hUjqHdtCiIUyTi9YiMEsgv8U7AvM4Tf3kLnEM9I9EG9MDhn9O42mu+S+SlrotEdXfIIHuQ/N2O+7q3boNb4xjxkVkHyXrUWPgndMAJJWrQHpQtcIP24oXsxT+xrDdwKIezf4e+t4zXg/jFyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by PH0PR11MB7709.namprd11.prod.outlook.com (2603:10b6:510:296::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 21:33:51 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::b598:4b13:38aa:893e]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::b598:4b13:38aa:893e%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 21:33:51 +0000
Message-ID: <7c48dc5b-40b9-0556-e4d2-6aca78886ded@intel.com>
Date:   Tue, 10 Oct 2023 14:33:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH] igbvf: replace deprecated strncpy with strscpy
Content-Language: en-US
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
To:     Justin Stitt <justinstitt@google.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20231010-strncpy-drivers-net-ethernet-intel-igbvf-netdev-c-v1-1-69ccfb2c2aa5@google.com>
 <5dc78e2f-62c1-083a-387f-9afabac02007@intel.com>
In-Reply-To: <5dc78e2f-62c1-083a-387f-9afabac02007@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::7) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|PH0PR11MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: 697abb8b-027c-4cec-569e-08dbc9d89871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SBmNtvNrgZNraDTmL/iTycsPVOmf+HbA3ekQ1IMCPJOu8pbSthZq03+quAu4LCCwUz2QHTHdHzf1PgjF3ioYA2eoaABM7A8BIFcJyNCLvI9E4NZXkOD6e0QfEuMKsjMqjXzoqNPtAMWZ1iIqyuoZFNiVjoZRQb44yQH+H8ImLedWHwE/X4nUg23C08WnpJtZO23QN2xFWdS/9/LEmf+G2aDh1vs8k8wph5rMiIrK1GikqRvkZbaYPMF87hCY16oIsMXKEEFGKkKwx1/iVNb/uMtzzYZLpXNgscgwvYRqjZ3bX3iPPWi1yCyQkzvHzc139q4lFs0tnm9GMcvUk+ExCwHy2KXnsrh5D/dwi8P0AFcYDSaHd6+kIuIF8XLrrv0ILUsrfKzHD0YbIGzsrsUb1AC5ozXgq7WvjrV9cmJH8/xQML5vSzUmoXWl5/BMv9titt5haWLS3OO7I0GBri5t830WKeE83jNoYdEX+RIuReOaFqYJS+R6ZGplR2l2YEcSYPiefz8mIpSSHiG6q06qMJ3w38uaFhS74wjj4VklS/Kc7UDbKI1loMjiBKmz9P2VSRV8GbqtgyKKNX2xC1KOCc3PtYly8/nC2kOmL4K4R1vCTeAEus/Mf6kXZtB3bafY9XE/RFKZ1Tb9LlWun4dFt169E5KZ4dZ3AeJQffSkZsXccKvWjL2YEl+j0zWFq8EoUZeB/+/P71uNk7DgTzo0fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(136003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(31686004)(2616005)(6506007)(53546011)(6512007)(66476007)(36756003)(31696002)(82960400001)(86362001)(38100700002)(83380400001)(2906002)(966005)(44832011)(6486002)(41300700001)(316002)(478600001)(8676002)(66946007)(4326008)(8936002)(26005)(5660300002)(110136005)(66556008)(156123004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVcya3V6cTZmTGN3VmdMVnlhanlhMi95WWpWTGxqbW5aSTVFSExaYVRtOE9C?=
 =?utf-8?B?NUJXL2tlS0RzdHF5clZSTGtXV2hTUkRUUXFMRjJ3TTU3MDJMa1NaRDJxUXds?=
 =?utf-8?B?Uk5jOUR5YlJnQzRFOEhGblVhck5NMWw1ZXlRR2t0Uk1GcTNYaHRITmVlVEpW?=
 =?utf-8?B?Rkd0TWhta3ozbDgvM0s3ajdQbUFvdjJYK2k1eHhnY0tocUljTmZMTFR1c1Na?=
 =?utf-8?B?SkNFWElCUC8zeDBITTRvOEtraWVVMjhXeVh2OS9sTFRlQVl6Q3hwN2Zid1Zt?=
 =?utf-8?B?MTlSak9STmZIR05NbVQ5aWhreWlUYUx1TFdpS092ZU83RnhkS3czdm04dVpF?=
 =?utf-8?B?ZWQzUnNrYldBeEpxQk51bGZ0MXFNV29ENm16VlRJM1lGMXRqMmVFVE1GRldW?=
 =?utf-8?B?QjJRaXZiRTVxTG8vQ0JDNTBHVmZMeU5OTmxFT2E3ZFlCTDZFNnNHUWtIZHVa?=
 =?utf-8?B?UTVzSzZuKzFnRThWVHVtbE5kTUZESndjNHNvd3BPOWpBVmpkc01Sdkw0Zmor?=
 =?utf-8?B?eTdZYTcrczRBMFhYdVJOR0kydkI0U24rYTRaMmQ3cDJ1bmZaM1hTWDJXV3Jt?=
 =?utf-8?B?bm1WTWJGOVhYVUo3SnlKYm9VSXR2NG1namFPcWNEeE1XeTVmL0E2cjUzdm44?=
 =?utf-8?B?clJRTmVzN2d5ZlcvVURkWlN2YjhFYU5iekdhWVVoSldqa1JRdHpYT25ESFk3?=
 =?utf-8?B?SlQzS0lDekNrOG14ZXpNK2RBTGF2S1VqeFdMSm5VdjhqNGZYb0IrdkN6MjhO?=
 =?utf-8?B?bXdqK2xPZ2EzNDJmNkFZMklLbVpRV3ZJbXE2ZWkrWkFIdlI3UjNWTzNoNWpt?=
 =?utf-8?B?YzhVbEpVTTBmaFo3UjIveHVnRDVoWFZEMjRpODc3WnkyVVBKUFN2RFhBRHB0?=
 =?utf-8?B?THpkL3EwcGlxd0lwVG5GVGhQTWQvV09XSHUrb2EyWWV1YVpWUTNnRzRCaEZ6?=
 =?utf-8?B?bCtZWU9kNk01MFBwanp5bmt3SER2UEE5WEdMRjQ5c1k1OHFma3pSbEtBVjZl?=
 =?utf-8?B?NkdrUjFiRlVXemxBNE01ZnI5ejh3T3hUQWlqUEY0cDY2SkZxa3lXQlRXZUlV?=
 =?utf-8?B?SnVnSVc1NjRHNnZGYXdtL2VUYTBmUnBrb0IvcGYycFhKWGJIS2NTQWpwT3Vw?=
 =?utf-8?B?RU9GZFAzVUNsQnpjTlNtSUZ3bU1GeXc1cUxzazQvSm4vTEpSaC9rZVZIMFVN?=
 =?utf-8?B?bXVYTHdlS21aRS9pRGEvMVIyRzEyeDJHa1ZVTVRsNG0xd2tOdXVQdkNvT3lL?=
 =?utf-8?B?YUJJSkgyWVN1S2hlNVVKQjA3V1hKZk9SS3ZtWjlERlFXU3JDUG04NXlpRU9y?=
 =?utf-8?B?bWZYMjVlMDltMVo2dGMrWXowTEpCMFN4dUVqdFNseTdvdTZLU2VDcWY2L3Z3?=
 =?utf-8?B?Z1g4V1c4WDNNOTF0dGdYbzA0UFNNUVJxSlp2ZXJjN0Z2N0RseGxKR0tsZ1Bj?=
 =?utf-8?B?U2lGbEJhWVZRcHQzaUY4Yjl3ekt3TCtqM3VuUWJKamVlMlpZRFpQTEpJTnUx?=
 =?utf-8?B?cTE5dHk4TC9WdE9aSWs3KzdTL2l0QlpNVVFRakJmMU5XMFV2ay8vVmwxSDhl?=
 =?utf-8?B?VFMxMGdxM2UvNWhnbDVtbUNmUnBEL3k1aWVMcjJnMFZ3S09SRC9SdzMrUVRx?=
 =?utf-8?B?YTJsRjhjZVFQdjVINWVNZzBOazVyd3Q4M3V0djVxTE53QTdvMHE5SURqZkdX?=
 =?utf-8?B?UDU5UGxvclphTldjb1BzczVLd1kwMTZoRHJ1QmVHWDRtQnpyTE9uZmRDNjRG?=
 =?utf-8?B?cGlWT2JMbG5tNXllbXVSOFFUMEVNTjl0T0g5c0FpQWR1eUoxM0ltb1JLcGlH?=
 =?utf-8?B?YXRpalBpc1B5ZDNBYUJpL2VZWVpra0JSTTU3QyszQVpibVBhdTBVKzIwQVhC?=
 =?utf-8?B?M09MazYwbm9yWWJPNktncDhhYVo1WWF1QTBOYnpEYXFIcFFDZHBiazRjVEJh?=
 =?utf-8?B?ZXAzalIyUVBUb2JLL3JlOThuQ3BISGoyMlVsbW1QUkJKcW05dEdjSVprcUEv?=
 =?utf-8?B?ZERiOExWSXJQM3FFNG1hc01zOGlZc09HYVhzbTV4elhSNmRJTURLcW9kMjRX?=
 =?utf-8?B?N3VML3lhd1kvVDAxVDZBdXZqQnhqNkJ5eEx3M0ZrUWJzcW1KdUFRMU81NW5Q?=
 =?utf-8?B?UmhNSlpWTXVwd3JTNGFXUFR0SDJmREJPc2ZXblpweVBDbDBjNm4wK3BuUlB6?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 697abb8b-027c-4cec-569e-08dbc9d89871
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 21:33:51.1675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxXFWfppmq8q/cCtwG8lIW4reCbsl23JlREhjyQ0s1NdQk9C+kts1zJUy0Si0MuPBRxt62Wu5+hHrCsp+Qf3VKwrDYzq1d/oXgvd5tin3uI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7709
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2023 2:20 PM, Jesse Brandeburg wrote:
> On 10/10/2023 2:12 PM, Justin Stitt wrote:
>> `strncpy` is deprecated for use on NUL-terminated destination strings
>> [1] and as such we should prefer more robust and less ambiguous string
>> interfaces.
>>
>> We expect netdev->name to be NUL-terminated based on its usage with
>> `strlen` and format strings:
>> |       if (strlen(netdev->name) < (IFNAMSIZ - 5)) {
>> |               sprintf(adapter->tx_ring->name, "%s-tx-0", netdev->name);
>>
>> Moreover, we do not need NUL-padding as netdev is already
>> zero-allocated:
>> |       netdev = alloc_etherdev(sizeof(struct igbvf_adapter));
>> ...
>> alloc_etherdev() -> alloc_etherdev_mq() -> alloc_etherdev_mqs() ->
>> alloc_netdev_mqs() ...
>> |       p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
>>
>> Considering the above, a suitable replacement is `strscpy` [2] due to
>> the fact that it guarantees NUL-termination on the destination buffer
>> without unnecessarily NUL-padding.
>>
>> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
>> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Signed-off-by: Justin Stitt <justinstitt@google.com>
>> ---
> 
> Thanks Justin for these patches, please make sure you mark the subject
> line as per the netdev rules:
> [PATCH net-next v1] etc etc
> 
> I'd also prefer they came in as part of one series with a good cover
> letter, at the very least for the Intel drivers, and you probably could
> combine any others (netdev) together up to the 15 patch limit.
> 
> Please mention how you found these issues, via automated tool or via
> coccinelle script, manual grepping, etc?
> 
> Thanks,
> Jesse

netdev rules: https://docs.kernel.org/process/maintainer-netdev.html

Also, please see my related series, that will probably conflict with
your changes but the two are making different changes.

https://lore.kernel.org/netdev/20231003183603.3887546-1-jesse.brandeburg@intel.com/


