Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7F1799192
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 23:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344124AbjIHVoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 17:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343977AbjIHVog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 17:44:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385961FEC;
        Fri,  8 Sep 2023 14:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694209467; x=1725745467;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AUGUL763/i16gGPDwvCnvQyFF7TB2VOpKrgJs6Wtfl4=;
  b=Vz7PaeDk3fZ5b+X6hWrLyjgZsNc94KR+XjaJUATlSUoSqXbO+TKVYaO7
   D1sgcMVFUIzDJI9Q6P+SehVINPrKTSfcBsjFaI4t+T72OCaJo2qMz6CP2
   Pyy7AHdoIxoOOp292co8cn8IF6PHEYF7SX6ee+Svtj5VTxJsLsITtpVda
   KdUS8yZZH0b+1Ln+Q4zYJfkv/eAVJwB67rwE8hmwBh2kHPcivz5MBari7
   kqcuEkzqBNKs9uyFXL5beAVHj3j74pQIiSyLMg+TE3EZTrUEjK7lQgmA5
   ArUWCX53ncTbhPzcKdem3zsMaSZOzn7wErbHmF3CaEtJ7psbQUbxlSZ8d
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="464123578"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="464123578"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 14:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="812706847"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="812706847"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 14:44:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 14:44:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 14:44:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 14:44:15 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 8 Sep 2023 14:44:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIatspoZE26eha87kwT9I0IMpvzHoRk4nQUnwFrSED9x5Gey++ZheWNpFDX83sQOUxCE1yJk6lBvzVNdD/CfiU9ShLhJQjTUAMaJyblLPn4A1+KFNtB+3ubjMsQR6oUI0jYRK3pdd2psG5y0ZcuN1G+RRE3dlKizNZ9njKXSMOZpuMtgOi3JdjZV+knGpFzVhnuMMbF3Pp9tjewVPyJb60fGMER8uxCAH2yIYTXUuFZJcVHbfgdlqYTTcO7YFh5TtcNxNApu1gUhjh5TXl3woIk3j7z6aHHPTD0iCs3k6zfDnfrWOhgjkCON7+f1mL7OhTKKN1SFR0SfiA99Hhaehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbHQSgugrxg/cn4ZxYDkl8Vpdoc4nL9UWYmd7mOcbOc=;
 b=mHAXNAPgr5ILx59wqwnDG0McMBW6Yr1PkZzHhdJuGl8/trCx0rXu8wehvWmWihUTCHU8zZT5m8BjmIHFcFFmZU/NJTpFiGbPGnfSB0QShH6ia0LCkxHmA0hmAsUby3YuINBXkk49LGFMv37jzbtkj7+Q+iQQLOTUhj56dIi9KKKh2WEJo3NOEN8llBTcIjwiZ3O3qzid7iz39z2MPfxk2io8ggGurF6sgmKTmm6kYVylCACaYxsADo5wiImmFY99IHG1FIZ3mruYL+H9q0fdELeqUozfDhaF9uOMgruK6lJ0qurZZqNzbQhHWIPBfkaYMtnLvl4zxAuBBYLyBi9cAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB8020.namprd11.prod.outlook.com (2603:10b6:8:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 21:44:13 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 21:44:13 +0000
Message-ID: <39301291-eeb9-71c8-2fda-672c6b33d141@intel.com>
Date:   Fri, 8 Sep 2023 14:44:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH AUTOSEL 5.10 01/14] devlink: remove reload failed checks
 in params get/set callbacks
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
CC:     Jiri Pirko <jiri@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jiri@resnulli.us>,
        <michal.wilczynski@intel.com>, <shayd@nvidia.com>,
        <netdev@vger.kernel.org>
References: <20230908182003.3460721-1-sashal@kernel.org>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230908182003.3460721-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:303:b5::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6c5726-d712-4b77-a03b-08dbb0b4bded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jyynVIupZQHiaPfKqEpSGGnXxHuq8tRlMxJ8fcBkgePuPc2MiYHqudHtFMl6Zr6bpHVIQ22KnQys/eyK6oYHPuX0nvPck51TFHlftfNyBpkU5T7G/evHm6Xd5lvrP3WXPH3yjV0rEyRQvQVxBsnql2XkkMRO/xdaO+HGYV2t4Qae9LGtFL48uSDzl4VoFfIk+VNEzOS8E8fZyWSM/wR+SlwrQRG3UG8S5AMpOGtcKUsTV13kSC4VfgGKatDznvtObCqrct2JuIBvMfmHWu6Dyy/vss1qpZwaKH4kuq17x6HCtYQJAiM9DjpMxMJ+iNertCxUFC/xIXYI3A0ILrUjq9IV2W6hdQ1fvE19wswVKQBs059cv3ufpkb/lINJMkF2yX6EVnHLEpKN/Sw1TjMWu/ZvhJyjRfXPKsSAu0EGg7vjMYwlXhDmK5a6KnoCProcLORzUahc7UOz4iW+9Bj+3WF/8lOz5GZpYfxEGsAtN9f604mAynGVEL8hRstvgGTpIR0g+b6zpY46j3UPqLDinQkyFMfubXyvZzofOH0UZgiWe+Y28c6Stvuwb8yl4KwEY2eeHuFz0YsnCDFpybLAvHzk03FpFK+4/K1wkkdQ+uVNSBzq44jE9jsvt53PpMIPtOoZRzmIvPc7Am9pdDldBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(186009)(1800799009)(451199024)(26005)(5660300002)(8936002)(2616005)(4326008)(8676002)(2906002)(83380400001)(7416002)(31696002)(86362001)(38100700002)(82960400001)(36756003)(53546011)(6506007)(66556008)(6486002)(66946007)(54906003)(66476007)(31686004)(41300700001)(478600001)(6512007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVk2Q2hmSUtaaDRNZlNCaEU4QUtSMnVqT2ZyT3JxMGM2QUZaN1dNbGUxK3VP?=
 =?utf-8?B?TU1WdmFlSEVzM2d0OVhOL253bnI1UjBSakk3cjc5cGhRaU9SeXFYckNoa0VO?=
 =?utf-8?B?SXhkeHFZWEZXUElLNXpBU3BRcEZoY2N3OHFSQlF3TkVxOWFPdllNNUY2SFZl?=
 =?utf-8?B?Mnd1dmhLQWNZZDRyUDY1b2I4TDM3YVE4dm9Cd09UM2xVajlhclI1TWFnNkty?=
 =?utf-8?B?aDdpcE1zQ1E5UFBwNi9vc1E1SVYrOHlWRDlXRzVMSVJQcVdzSmd5S1pKK3RD?=
 =?utf-8?B?a0NncHcvVkVZMVNVY1d0TWFRNUVoRUFIWVUzUlg3WUh2Y3RNS2R3UXFMZVA4?=
 =?utf-8?B?cmw5bFdUNHFCSFpQRm11dFhFcHBrQldqNnUxSmdJdDJEWXZGWDJGRUNhaHBD?=
 =?utf-8?B?a2tJencrbWlMbUJmeEFWWW9keVR5VGl5bStWYllmMVFXNVNLUENaVlRiUzlP?=
 =?utf-8?B?cmN4NnRsSnJyZnN1R2F2SzVydDBNWGhHWEkrTzBMZzhBTlhDb1FQbk1CaEVB?=
 =?utf-8?B?dmxyVlFiM0Ezd2l2UDRaZzZUNUVLMHBLVnI5aCtzUjN0TmRNbFdRVE1lbEZu?=
 =?utf-8?B?UExvU2pweVJqdzZEdHJNcFp2cmVaam1VeUNlZ2p4UkpLMWRRMGVaaEI5UFo1?=
 =?utf-8?B?Vjh4amlsRmV0Q2tSWEJBUEJndk9laHh3UXoxbTN4cm4vWG1SNStaWXVTZjZG?=
 =?utf-8?B?NXJpQVBiMVB4cU5ZL3pSRWhDMWtiRFpxUVN1S2tMdWxLNEtRMEEySlZPL0p6?=
 =?utf-8?B?RmJNNkhmSndlSk9RTU5xZkpkSmczR3QrdGw5ZUdpbWFCaGhrMnRVTnBzUnFX?=
 =?utf-8?B?a2Y2ZndSMXFIdVNUYXN5d2xTbnhaQ2t0cDFob3QzNlVaaUlTaHBaU29BMnNx?=
 =?utf-8?B?eG9PYW1yaXVhaHdqNkREMi9RRVlDQis5VzhsL3JMNVhhNU5FeW14cEVaRWNG?=
 =?utf-8?B?WW4yUjN3T2x3aS9TNXQxQnY4bXJrVUFiZU1zNlhzaVoxZk9aTHpEZXZaZ2RE?=
 =?utf-8?B?cUpMTTl2RFp1K2MvOW5WMGZ6ZXd1TVg4QlN3aHpBaWQydWZTdmRsZmk4Z2M2?=
 =?utf-8?B?dG1SajdmQmdsOFRwR1p6VWJsbVV5S1NMNVovSjlvNmVIVU03ZjhITFpSUmQx?=
 =?utf-8?B?Ulo5UW9RT0ozaEFqcFJHL3ZjUnRkQTcydlcvVWNzdEhJVmRDK3o4NXJlbm1N?=
 =?utf-8?B?RThmOFArOERRYTJ4ZjFVUGFVWXpJYkxsTnpUcy82dENTTGdud3ZSdk1lWE1V?=
 =?utf-8?B?dEJKWUVVWlBZZWRiTkhyOUQyMlZYZG9TZ1Zsclc5cm9PYmFSRGVHdk1WanRG?=
 =?utf-8?B?Rll0aEZxWWZuMXVTZFQxcHRnTHVXc2RQd3ovck10bmUxNGRUWGdya1ZrOXY0?=
 =?utf-8?B?NVNWSHZhaXYvNjR5Zi84SmNlS0plVGFNSEFGWTdZN1Z3dVFJRlVNNnFoSS9J?=
 =?utf-8?B?MEg5MUN6VmRJQzRpM3UwZ0FXcjZYbFZiWE9LOWZ6YUZQNXdVR2pOS1Q1VTJB?=
 =?utf-8?B?SHlFV1FpNDBwTUVTekhIbkQ0TXArMlE2Z2RHM3I0L0Z0bEpicVFLOEoxdEdi?=
 =?utf-8?B?UUkxL3lSb0o3cHlPMkt2aVJNYUpFMmlOejV0Q2t4WmFVQmlBSGh1RHp1MkRG?=
 =?utf-8?B?dFgxTTAzLzY3TE1PL0xXeWd2eU9xdENoT0FjOXNBUSszN0toK1ZqcWFtMzNX?=
 =?utf-8?B?dUw2WURTdGxZSWRVTlB3MzQvRURYY3ltalFaUDhabHZ3bWhZRmF6aW1XWmhz?=
 =?utf-8?B?YVo3ZUdWbEZVVzRuYnNNMFdqa3NxckNBODZXRUJDZXZ2Y2MwdGlhcXF6SHhq?=
 =?utf-8?B?aThSZU8vTjlqZHpwbm00YTdzc2VsREVYMVFtS3BDOGtoVTlxK0swQ1hlcjh2?=
 =?utf-8?B?QTBPTDJFMGdGdUpPdkZJQlhqZ1ZXWU15Qm9WWHZwRStKY3Q4VTFIS01qOHJM?=
 =?utf-8?B?SzhzVXhramE2cjhNR2JzejVQNEVMYXpkeDc0Lzd0OEZ1UnN1QVk1QkRwb3pW?=
 =?utf-8?B?VGpNNmVlOTdYUkhzZ1o5V3VzRUp3Nyt6NGlGOXZNNHlsMk4va293UWIxcngy?=
 =?utf-8?B?YkxQUU9IOXd6SldTWEJiVFM5RDZkbWlONFVVS2ZnK2VCNERsYkp5djkvWVVQ?=
 =?utf-8?B?UXdJUkx2MElsWjcvVDVUZGIwWnVVYU9jMmhCSmt4MTYwSjNIdVNkNllweXkz?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6c5726-d712-4b77-a03b-08dbb0b4bded
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 21:44:13.1311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azj5I8uE2DD7Bhsi8p+obGC1HHjvyHaepeLVyRVkeV0KSRA1Hu+PAQd2OknHhFQjJwD9fB/nHhGmrU/NUmtqdRWFRx/TJNdHIwHkDIkdziE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8020
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2023 11:19 AM, Sasha Levin wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> [ Upstream commit 633d76ad01ad0321a1ace3e5cc4fed06753d7ac4 ]
> 
> The checks in question were introduced by:
> commit 6b4db2e528f6 ("devlink: Fix use-after-free after a failed reload").
> That fixed an issue of reload with mlxsw driver.
> 
> Back then, that was a valid fix, because there was a limitation
> in place that prevented drivers from registering/unregistering params
> when devlink instance was registered.
> 
> It was possible to do the fix differently by changing drivers to
> register/unregister params in appropriate places making sure the ops
> operate only on memory which is allocated and initialized. But that,
> as a dependency, would require to remove the limitation mentioned above.
> 
> Eventually, this limitation was lifted by:
> commit 1d18bb1a4ddd ("devlink: allow registering parameters after the instance")
> 
> Also, the alternative fix (which also fixed another issue) was done by:
> commit 74cbc3c03c82 ("mlxsw: spectrum_acl_tcam: Move devlink param to TCAM code").
> 
> Therefore, the checks are no longer relevant. Each driver should make
> sure to have the params registered only when the memory the ops
> are working with is allocated and initialized.
> 
> So remove the checks.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

I believe my comments on the v5.4 backport apply here as well.

Thanks,
Jake
