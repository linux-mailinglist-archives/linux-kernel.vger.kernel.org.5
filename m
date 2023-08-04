Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF90770789
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjHDSIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjHDSIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:08:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734F14C1E;
        Fri,  4 Aug 2023 11:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691172466; x=1722708466;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=snGaJw3+Do0qBeXUWDn88zOHanC41An9nOjBnTVkTTI=;
  b=hYlkSVaoAO8zgHWzqSke4sUzS2XHNxU26vYz5SossBWGETUFH8rMG6JS
   o5Sgmf2BqiqxfByfynnyHJW4tZVhRnlwFOvPGpVMqexhVMruT+rzIEIeo
   k1xiLpoDuFBFAB7kQ/oQaOdWUGe1239rpLUSMAmpNPjYVEZj4lT02k3iH
   a7IEnvszi5XHNemu5OqN9u8zUNRIu5Fpm82m6PM24iMuBC+8FSo30MbMg
   sNs1R08kOqFu1keGGYnACVOzeDwUsU+kiL586BOrfNr0C+JC6vzlhdJxk
   yIUwetxOLRBEy6vpa9VJOemjaMeq3u+TUJnUq3PgB6XQagOnLg+E7d7iG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="369110407"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="369110407"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 11:07:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="844169056"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="844169056"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2023 11:07:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 11:07:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 11:07:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 11:07:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUGEDbcYUHw0316xM8pmjJJ7yE4XpAioiz3uAkWuyxNBWJquGk0szNY59NPz7O170NXl7miYT4OAyrttCvvPxlPdOGWlLybX20adYma9Avi5493l6NwAJMrbaJz1wbCOa/my3Ayf/Jk56fV9xyemJCgiaBLDqWIgT5x/VCpfSPeOJ5O9iozXYqqyU444pRPRTiASonNBSkcPNa7pSLI+h5Z/5PN6gVTzw7Osr9nLFxFmwtsJp2FNrekBO9F6HdeOdYJg0aD0fk2I61jUz3AKeogiDmr4qQIOT1PxoCk7CHjckzh6jkjC9tqBSBurZEhzj18zrr4xftGDj8O10MX/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuncOGB97EpfuNE3EoSO7ZSj2LKK4zlnJagdL6TGvdg=;
 b=cpFvptUPDBe40sYxqehSLLMClycKAdJT80l8IOsIhz0RYenqa5U05tsvUqJyUYU0kpb3N9tePEpLhzNzCJ4/ok8SOm1+lPM8auYKDgqeu1mDT330ryF90RTqYb94VAlisn+zqHeerI9xgUS+WH2Yk+6P2ywnTDAge6sS9XhQTwnJg+dlnayK3hf488YrLP5RbG9lkHsBxL5YTXMhbmQFubjCqfkIgTzqjf2nqyhgIBEqA8w5b+ZxmljLuRGcgW2RpGxv0zAuGHqtmS9bgXrCoTMwaPhTfoAGQDbAWM0pZKjA90/BA/Lfln+uLeUXpg1uHKdDM6eKI0iDgJTn61rfsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3229.namprd11.prod.outlook.com (2603:10b6:805:ba::28)
 by IA1PR11MB7678.namprd11.prod.outlook.com (2603:10b6:208:3f4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 18:07:18 +0000
Received: from SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::5c09:3f09:aae8:6468]) by SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::5c09:3f09:aae8:6468%6]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 18:07:18 +0000
Message-ID: <2e163fb1-492e-8a1f-9df1-270c652e9799@intel.com>
Date:   Fri, 4 Aug 2023 11:07:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next 0/3] virtchnl: fix fake 1-elem arrays
Content-Language: en-US
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>, <netdev@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20230728155207.10042-1-aleksander.lobakin@intel.com>
 <88dce445-180c-72d9-c7a5-f0a18a18c747@intel.com>
From:   Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <88dce445-180c-72d9-c7a5-f0a18a18c747@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:303:dc::23) To SN6PR11MB3229.namprd11.prod.outlook.com
 (2603:10b6:805:ba::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3229:EE_|IA1PR11MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bf6e07b-fbb2-47e1-648d-08db9515a423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFTVjtxhwwcVJpfjfUO0hTpu5vTf/sjFX2Hi4gnkLYgoylnfug34n2iHlJ4pseI/4qT/kZNCcHC7aG70U42HcmqJpW54cbFeBYw2+LlQ2vMdDx0913nxHlORaLlkLxsImNjdNKTDAZSVZU5M3nNNhtwYIuBpho8TVD1Ry2rhdyinmR/oF6syT4fBrCJHQHzR6HTVyv4OxdI0sBV+oYc9i/w8WY6rvWNqW8cX8SKxxzzG34fTs4Nt+gRSBzLueqwo97mvi2KUy0oleKFZVorrkiLpSpvUB9qP7I3oPG63YvwGz9/H2WAqUyim/nOuV7gOA4sa2b3c3U5Wo3P+ZwlFK2mgbcybwpxnufywyjeZcSwUzY3SLA75JsfR1Gm5GmSjVYgzxcwa7rZhp44Ggg/F+g4jsL4H0RPN+gm/SNY5BTwI9WhTSuuVppMwXogoSOecqh8yLc7CzRORob9XpWC1pzeacNKLE0w0r/AVFPjeMrlCSDH4yQKUbfcyGuYRXbgYkHG3HQV0CF7etG7ggItfmUy6L6SMWJ5erihxW7m4p0gUVubRWxFwc6oQo19qV/WCaQcVcWFxIvLcU1UcSaccryIkPMp1saKhjvlR86X8E4Eff8Rwbqpj7RMnORhweDWrDFVOlxIsGNL8wZtQV6Q8mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3229.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(346002)(136003)(39860400002)(186006)(1800799003)(451199021)(36756003)(86362001)(31696002)(31686004)(478600001)(54906003)(37006003)(82960400001)(38100700002)(8676002)(2616005)(83380400001)(6506007)(26005)(53546011)(6512007)(6666004)(6862004)(41300700001)(8936002)(6486002)(7416002)(6636002)(66556008)(2906002)(316002)(66476007)(4326008)(66946007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2t0RUlvM0lBRDhZZUFlV1hPenJpelhUTURLWFZjZ0ZpMWVTSy9ZTjRZRkcv?=
 =?utf-8?B?dDlFQ3JFTmo4enJWNGpLd0I1b0hVaENKZGQ0d2htVzE4NjhSb3BHU3FQbits?=
 =?utf-8?B?cE50SmVvd3JScnB6a1JTUUgxQkFWUXFZeUt0UTBqZWxyd0dYZ0lTZUlrNGFM?=
 =?utf-8?B?TEZkaERSZkRxeWtqVERTd2FEN3B5UkFTaDh5V0xqbC9xRG12UXdrSUxYZU9q?=
 =?utf-8?B?aEEweis3ZFZnay95ME9TOVBGVEF3Z3V0M2crRk5NUS9YcGtVZXYrV3FacVhk?=
 =?utf-8?B?bTQ1eWJvdDhIVkhwdXByTHU5Y2c5TWIwVU5KWG55K0NWK1ZxQnRpZzUyYmV4?=
 =?utf-8?B?ZElONE9uS1hRMmxVUGdudmkwcFZiS05nV3JRTGJkbDVYby8xbllJcW1XVjNC?=
 =?utf-8?B?T3NpeTRMVzdLVHhCR2dsbktLUDA1bTEzcy9abkU3Tkt3RGNWRFlUam9ZbjNB?=
 =?utf-8?B?RndKbEs3TUhYVThkd2QydVFrTC9nSzIvZkZWTEtmcnVuYWF0ZDdSRWltamgx?=
 =?utf-8?B?MlpZZW5rNXJLNG1mN240R0VocTFRUkt0ZVVta3A4QXhrS1BBNnpiMUdJUXVU?=
 =?utf-8?B?VjdHRDRSK2dwQVEvWmpKZTJRRDF0TFd6cTBHdXhyelJZd21DVHNwMFNvNDU0?=
 =?utf-8?B?ajFIYmtpM3pQa0V6akluVndvUUNCUG4wWmNlbFlERkc5TmZMTVgyWEo0RmE2?=
 =?utf-8?B?ZFI4Mm1ST3RxdlNYQzU2L3A5VVBFemdoVHo5TjBJU2xHOWRmU0FsNy9ieDFv?=
 =?utf-8?B?YTJlcXdmcXoyZHE0OUx1SUI2d3RmL3BieG5IVDJBSFpCdW9QSGhyMlI1QnAy?=
 =?utf-8?B?SUJSNkV3dFZxcjlBNkJlVUtnTUs1bFVHUU8vVWVVVkdPQ0hLckNqSFFrNGJ5?=
 =?utf-8?B?MG9xT0ptWnJBcEdVM3JHb25SbG1zVWR4aEUrdU4zYTc2RHpWeDZ1OVhSTFFr?=
 =?utf-8?B?UjRYcURKTUNuaDVoK0lXanZ2VTYxY3dCYlR2WVVwSW1OSkhLQXZiT05WQTRE?=
 =?utf-8?B?eFErWkhtNXY3cVN0cTVVbUZpdTRKdURPaTZUQkxwcFdDQnIvVkFyTTZHU21G?=
 =?utf-8?B?T2UxZmo3YTZ2OXkxUTM3TmVYVlhLQmdWZTlFRlU4bjZzMTEra3BIVTZKakpH?=
 =?utf-8?B?bUF3QklKSTBRR1VDdU5CSnNDUlV1eUhEQkpjREtHYy9MN2V4ODh0V2RudUxi?=
 =?utf-8?B?VGNxVEh3TjJkRm8rV3Y0bFY5Mmt6elEvNUYvNE1wSzN6ckdiU3p1c2pDa0Nm?=
 =?utf-8?B?ejNkMkU2aEU0OE9xTWJnUGtWLzJoMGdDTVJKMWlpM1J1NWI2YXAxbmRQa0JB?=
 =?utf-8?B?c2gydldhbS8rOVUzUkUyZXlIS01oK1cwUzljQ0VvWk9rS2hXeTJxeVVTQUN4?=
 =?utf-8?B?bzR1NzgwZW1DNTNHdHk3aXNqT2VBTVp2ODJqQ2phTEdiaURnd2hvOVJsR3Vh?=
 =?utf-8?B?c2ZtMkgyUERLSmRLMWJhWDk2MXAyTTF5Z2VjQnVJTkVleVNiZ2kvQ2Ywc3Zm?=
 =?utf-8?B?WWFZL25pRHVGZFU2TWErMUZCSnQwcURGU2FFR2VFdXpiSjZUekRLMXJTNWV5?=
 =?utf-8?B?QnZDVktiNk5tSTNJVmdsNTJMMFExMEFMS0RGUmdyOEZVSGFkQ3NMOFY1THZ4?=
 =?utf-8?B?b0pUZjhnVVZNL0UwT0d3OCtXbDFKbEdvK3JEUE5NODVBbGRIMWZsVEpobU8z?=
 =?utf-8?B?SUViQUdrckhlenZNWmN1OWtDNnUrcTcvLzRraFJGR3B0Q1BpRnJhOEhxK2Jq?=
 =?utf-8?B?REtKZ09YRmhjYUhyd1RTaVg5YjA0bk0vdDhEMkJZMGdCVGNJdW50VXpSeDhK?=
 =?utf-8?B?eGFHVmxvMVRlcC94bG40T2k3SmhpSTZ4M2FHRGV4VnREQmlrK2k0dWVyU1kr?=
 =?utf-8?B?NldUREdpYS9NNk5QVHluOURHS2dKT1kzL2JMdkZxblI4QytRZ3hQdzdzd1B6?=
 =?utf-8?B?UmxjMXZEQjNvTUloU2Y2SVVjaGRkbERDalQ4U05JZ056dGMySTd2ejJTcnpM?=
 =?utf-8?B?aEVKc05jeUpqWnhxVlRLQW40SWw0Q09ieFN1cGRvZzBVUWVGYkdQcmlheHFE?=
 =?utf-8?B?QzZDVUQ0R2Q5Ny82eW9EdlpFT1NhMjEvV3ZYb1ZZT091cE90S2FocUY4dXBN?=
 =?utf-8?B?dEFoVkNOQ3BleHpVa2dObmJQMnIvbm9DNG1lM1hhL3YyUUgyY2xod2drK3lh?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf6e07b-fbb2-47e1-648d-08db9515a423
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3229.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 18:07:18.5349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJqM0mt9L9h1Kzga9bFa/Yae1ZoM6+1EVTmoRNbrcnwGBtU+az1etIKWqnjyqj84pk0JQP/cAJSEVDw5Ri7oQb+etgd9dlxfB6UFvkts4Hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7678
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/2023 9:38 AM, Alexander Lobakin wrote:
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> Date: Fri, 28 Jul 2023 17:52:04 +0200
> 
>> 6.5-rc1 started spitting warning splats when composing virtchnl
>> messages, precisely on virtchnl_rss_key and virtchnl_lut:
>>
>> [   84.167709] memcpy: detected field-spanning write (size 52) of single
>> field "vrk->key" at drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1095
>> (size 1)
>> [   84.169915] WARNING: CPU: 3 PID: 11 at drivers/net/ethernet/intel/
>> iavf/iavf_virtchnl.c:1095 iavf_set_rss_key+0x123/0x140 [iavf]
> 
> [...]
> 
>>   .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |   9 +-
>>   drivers/net/ethernet/intel/iavf/iavf.h        |   6 +-
>>   drivers/net/ethernet/intel/iavf/iavf_client.c |   4 +-
>>   drivers/net/ethernet/intel/iavf/iavf_client.h |   2 +-
>>   .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  75 +++++------
>>   drivers/net/ethernet/intel/ice/ice_virtchnl.c |   2 +-
>>   include/linux/avf/virtchnl.h                  | 127 +++++++++++-------
>>   7 files changed, 124 insertions(+), 101 deletions(-)
>>
> 
> Tony, could you please take it via your next tree? I'd like the
> validation to make sure more different host <-> guest pairs work.
> 
> (with Kees' tags, assuming he reviewed and approved the whole series, I
>   asked about #2 already)
> 
> Thanks,
> Olek

Ok, will apply it today. For the future if you want it through IWL, can 
you tag it with the iwl-* target (and have IWL in the To)? Since this 
had 'net-next' and was 'To' netdev maintainers, I took it that you 
wanted it taken through netdev.

Thanks,
Tony
