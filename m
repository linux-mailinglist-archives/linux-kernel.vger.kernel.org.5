Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA22D7ADE9A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjIYS0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIYS03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:26:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F9D95;
        Mon, 25 Sep 2023 11:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695666383; x=1727202383;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GDO9NBdQbb2vHvaxEPsWi3O0MELW2Mq02eQ81ork968=;
  b=ZOk++WD+SpNB3gplCo2nZH9S5qh/nVpPIzQVcSSoJbJCUyq2cNFW/k6U
   qWwhnKepN80UXmVrLjVB48lbwOUl2OrQu5uTY4ltcd33VHmeMXkcOqYbV
   uumdorXYD/Z3/cbnwNNzaFHsfG/JmzGnNUt2395lSZhCwij+xP1UgXEqN
   NFIajcdbCNyldMoo+S8sE5kw4XELt5lEXLjPNo8HGm7MU/GlZMvxzJovc
   Hv1xLsEsGd8/+NFFnya8Zr3hw8RtJ3pm0uqCJe2hOe/i56obU0TyxGp7I
   i6yNiAGiFlXEC8c3sRnaGkaSKtDZ7NyzqwK54DvXvOlsNt+63bLJQBhoI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="366392196"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="366392196"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 11:25:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="814085340"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="814085340"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 11:25:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 11:25:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 11:25:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 11:25:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhAoP+bzOl+T+KTIRFl17WnA0gmf1ZoDyRxll2vwkCJIwI2L8p0fYiVr1rnHocWS6z/TNvHXy1uCMXREYnVDkJDxfm8DdvQ4uDj/30dyPFvterhCHvpf/xopW3mJsmjAedRZN3f+GaGAWPo/h/2pfh8ESX6x21WVPCKeR/nYTy12MaqTcbsvrfEewqfrIqbaMlr1Gr5KCmM3H6LULpedp19DkzDCiURVKFoumDC3sWDLVkS35+PflQMPGKNbDrPTFpKORjHi0yH3/uZnSn0IVpyoAUkZcwIGLj5IGiXNZ49Qhknu0vsDpjweZFxv9KSkmlKaoRS32VRNchAFB9p2Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3omtEYilo4HP6jhdJBax4gXSuST5xFAuo5PGFVdc3I=;
 b=lnswQd9MTdKl407fftaDeJVfhWcadFcEIPejs8i9jCBXui6HBq6sSdACIQ9Tb7j62IS1171tprSTiIi2+qnTCC4FTVePzgjvbXxq/hhxIayBFDrbLKPFjfSmwO2ObrZg2hsAduouNTysHZmKZliGPXUdoAASlNkQdhAVt06BwI9PJYmUz6UNde4f1eUUlvSgn/zICXsPsNidQZErA1z0kgSPhAk1cxqRNWN6iP+HlZfJ+Xf5btwhQd7gvPCjHbru7Ri8T25Av+K8sJ5HDiHAd36YBY6Pg+TbvLSpfqzOGUOf0jLBC2Wi43/66NpEf+wf/+rQ4OHz8WcEWQh89t2B7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by DM6PR11MB4529.namprd11.prod.outlook.com (2603:10b6:5:2ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 18:25:56 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 18:25:56 +0000
Message-ID: <8db70d9a-28e0-1b3a-afb2-e569037471cc@intel.com>
Date:   Mon, 25 Sep 2023 11:25:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 6/9] platform/x86/intel/ifs: Metadata validation for
 start_chunk
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Hans de Goede <hdegoede@redhat.com>, <markgross@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <rostedt@goodmis.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <pengfei.xu@intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com>
 <20230922232606.1928026-1-jithu.joseph@intel.com>
 <20230922232606.1928026-7-jithu.joseph@intel.com>
 <e628f81c-5023-2e59-f45f-e76885e41446@linux.intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <e628f81c-5023-2e59-f45f-e76885e41446@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0058.namprd16.prod.outlook.com
 (2603:10b6:907:1::35) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|DM6PR11MB4529:EE_
X-MS-Office365-Filtering-Correlation-Id: a086c32b-9779-4275-6c3b-08dbbdf4dbb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhJi0U+31lmA3m71xHtpHtu8nCn/vUGvbdq6nupGzeIlK3xx+wdmMsc3KmAdGYlvCVkIqOwhZfamWlS1ZdrYyc1wnvCinOzXTv8h6c5KjwOoEEDc9DkrrdMxsIl7cAUiQze6EMLu7VoCb5o+vVWRcMuBuYiP8ImpUmsIeCFeJq4JCoL6Z46jrlBX3TXS3xrBtnbunYomtwuXG5DkFUCQbZh2g1sBwemcigbfdWEkMAYQpSzF1ZeQgx6CGlMjFxWIK7T7fj6eCQ31vRkdfaCBonMKzHfkiNIOg/2pDKbQzZl1VNkSMn4/01IVHFo5KuIOcyyXNeAf7XlwwKl2e4UOJq5O7HJSBK8yb/aXnlrUJrQqmI0Ly3xCEjtAd+OOG2QIi1sktNR67sAFsZZJ27v64P5wzRwVJ39WDMj7p1ZNtAA61baUatDZ1uNqhfdtzawLRJuc0ACOlPiJMzEbU2vSr0E2XibQFZXrRIM4KwOTc5PmfEOfzwXG/Fbf0GCQldg3Po8gkVDiiMf6AJgGCKm2GhvqOPN2HqdW7o0r0E76aIbStS1ggXId5p+LpH03xvn68+8/kDzc5bdQC4m+67dpRAg0OxJ0nRomBssjz6vX5BO2uB8mao7gMgvVllrP74LJw6hfLac8DnYOrplqWo7lhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(451199024)(1800799009)(186009)(31686004)(54906003)(83380400001)(2906002)(5660300002)(316002)(6916009)(41300700001)(7416002)(8676002)(8936002)(36756003)(4326008)(66476007)(86362001)(66946007)(66556008)(31696002)(6486002)(26005)(6512007)(6666004)(6506007)(53546011)(66574015)(82960400001)(2616005)(38100700002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXl5cGNhRFljQUY5VWJWUEZPOTE1amUvMHJXSlNMY1FtL0w2NE9wdUZ6dFpp?=
 =?utf-8?B?bHJTRHFMbFE3cnFKWGs3aWhxZnRqb2J0bFdRT1dXN2NiVVFtVlVXdWRxODVk?=
 =?utf-8?B?MVdENkRiNG9rMlZNOWNoVVVvZ3VlUVZKYTRPeDVId3huWVZCMENCUzBGOHFm?=
 =?utf-8?B?N0NHYjJrV09jUnIrWVBwaGEzRk5Ba2E4YVQ5RFE3ZUV6U0VWWFkzNWhhWGsr?=
 =?utf-8?B?Z0pxdk5Sa1VjYnFQcERCVGE2NVNiYzlQbWVyaDZFYUg4S3hNcFJIQTJlL3BN?=
 =?utf-8?B?b1c4YXZyRWhiVTFCTm8wVlpxQ3BtY0VqVCtyUXYvZEI0cWxwQXF6bWJRL1NZ?=
 =?utf-8?B?MUdKa0FzbGw4VjFndTlxRVA3bGpWUk1WUHVGSnhZb2xvS0wrWHZVcnhNMGZV?=
 =?utf-8?B?cnhjMVgzblJRZnl5YlYwME1KUnFRWkdod1E3MU9CZkhZWFRHbldJNm5UTTg3?=
 =?utf-8?B?RFUzcnd1bnBaSnVSb0F2SHc4ZG5DT01DYXEvcHRHTkVieFpFR3MyL1lBb3Zm?=
 =?utf-8?B?T1lnQzdUdm1ZOXlqdTJCQndlanZNR0h5c3R3VVc2K0dzNUsrdWN4dkV1aWlQ?=
 =?utf-8?B?VCtVd3ZiQ3V5eVBjem1QK2QzOXljS3hrWitaK1ZTUkpRa3JoNlduNDh5T0Jm?=
 =?utf-8?B?U2srNjBTU0NJcTNrQkZKVGdRYlJ6OUhLMU5xRzVZYmZ5cklLMDlXNWgxcDhQ?=
 =?utf-8?B?dXlxcDJjSmF2S2hxU2xOTE9UQ0g1ZmdTOXhmVkhrYyt4Y3Btcitib1l1eGM5?=
 =?utf-8?B?ZXNRL3lqNlVRSU0rcWdGS3ZIbVk3VG1yYTRhNnVVRXBVbll4YkFLeWlsUlpU?=
 =?utf-8?B?UElaTE1ZU1J4b3JtcmJDY2VjOS92Ykw2THBiNHRVelJsb2NGQ2cxOUdUcFpI?=
 =?utf-8?B?b2t0ZnBtYm05OExBcUdvd0JYWVNDS2dUeHFxWUYrZ1FqUmNiaHI1VUFraW1m?=
 =?utf-8?B?TG93VGVwNzdxcUFmejJicXQwN0QxWWtobFVja2dKSkNUaWFSckxEbWcrZDJm?=
 =?utf-8?B?aXhpNWFpcWpvb2NsMitja0E5S2JBS2FmeFZ6NWtzZU1ib1ZRaWxrcGJvZmR3?=
 =?utf-8?B?bWdVRXY0N1MwOW42dnhsY0RoVXBUN1NIczhyVXpzM2ErMTY5R29YUlpjc3hY?=
 =?utf-8?B?aUt0RDRMZDhMaFZ0K24vOXV5MWJJRWkwY1UrL1ZTdHU4bWxtTHRYN0NBNkRE?=
 =?utf-8?B?SE5uQW5xK25RdHBlTFdieWxIL2xpck5UZ2R6WERWTjk4U1VhcnpLQU9wUTB0?=
 =?utf-8?B?RHR3TFFTV25wRURROEpRRDAzUzNJRDVvOSswSTlMUkZ4bDNXSXV1WG5SSmQ5?=
 =?utf-8?B?UW51dVAwbi9YTndhOWphbmhjd3NrVkdUc2E5Y0tqRkVHYUU3NEptNW5jc2xN?=
 =?utf-8?B?bWg3SnV2SFpLZUQvY3hhN3pacGRHditDQlRzclRUZFByQVdZOG9vZnVBV1hx?=
 =?utf-8?B?ZFJFVC9RcFJLdW51Rk12YVlmM1RaSmdVOXVOTzQwV1h1ODJnY1FQZTU3SWdi?=
 =?utf-8?B?Zk95T2xMdlNSS2UzWTFFcGpTckc4ZE1qMDVMMFRuZ1hLK1lrSkRiWktoSFI5?=
 =?utf-8?B?a2x0Qm8yNmZZWVNJKyt3bGZweVhxcFBoSFhpR0hpZnhGaDgxVkluSWorRWJL?=
 =?utf-8?B?UzRsOEVXMDZVNU4rTkRRVjhncjc3aG05TnhhRlJKSVJQbDUyblZEUHEzL2xm?=
 =?utf-8?B?aWhXUTVPSFpuQit2bTdKOUNjNHZ1NzVpUW1aVFQ2ejdPNUN1eE5STUowTStn?=
 =?utf-8?B?Yk5RL1g2Zmh0Mm11d2JYZHk1RnpEQlpSSThoand6N25HUlF3czNZNFdwN1FZ?=
 =?utf-8?B?eHRPM0FFT0hYSnFtdFdKZ3Z2TjgvU0lERVU1M1U2TXdvb2dwUEl0RnNIQklP?=
 =?utf-8?B?MEhYWXRGV2ZGTWpuODRKeGc0VzZIOFk1SkJDNkJSZFk5czNzYklVelNNNUJP?=
 =?utf-8?B?ZDN6cEZ2NUpRY3F0dTN5MndzeXM0b2tGcmhEdjlsVXVhMkdOQ3ZxQm40T2FJ?=
 =?utf-8?B?UmM4TTI0L3ZScld6bmNORExuQ3U4TnBna0RQS09tRTlpRFFjTG8vRk41NFJs?=
 =?utf-8?B?bE5MWmRkdTIrTkwxNGQyeDdxeWNZbGpjWXhMUDZ2elBab0FzdXc0U0xyV3Q0?=
 =?utf-8?B?M210UnduMmdCUGE3dDBQY1l5T2dYTTJGc3JMa0kyWFZtVTRYQ1NSS3F4YTly?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a086c32b-9779-4275-6c3b-08dbbdf4dbb5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 18:25:56.0682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2p7rpe8j+VlROLMsl+eYC9VyLy+3fdO1Uqijffcb3zB1TTpoMe/ZZJgaqL0zwf7Wr6E/FlhEMnO2Wu0HKk+o/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4529
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/2023 8:45 AM, Ilpo Järvinen wrote:
> On Fri, 22 Sep 2023, Jithu Joseph wrote:
> 
>> Add an additional check to validate IFS image metadata field prior to
>> loading the test image.
>>
>> If start_chunk is not a multiple of chunks_per_stride error out.
>>
>> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
>> ---
>>  drivers/platform/x86/intel/ifs/load.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
>> index b09106034fac..c92d313b921f 100644
>> --- a/drivers/platform/x86/intel/ifs/load.c
>> +++ b/drivers/platform/x86/intel/ifs/load.c
>> @@ -291,6 +291,13 @@ static int validate_ifs_metadata(struct device *dev)
>>  		return ret;
>>  	}
>>  
>> +	if (ifs_meta->chunks_per_stride != 0 &&
>> +	    (ifs_meta->starting_chunk % ifs_meta->chunks_per_stride)) {
> 
> I meant that != 0 should be on the second line.
>

Ah I see ... Will change

Jithu
