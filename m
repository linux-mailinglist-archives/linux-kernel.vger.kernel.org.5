Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3878B7B5D76
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 00:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbjJBW6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 18:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjJBW6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 18:58:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9A0B7;
        Mon,  2 Oct 2023 15:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696287508; x=1727823508;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LkfR/eC1Xbt+Qyt4sRYKznRfpEafGPRbfXtClKfP7eQ=;
  b=kxczyzx61jKYk4zfHHdV4xSAtinVC4ny7688Ipt6jpqmZcRBXQV0uxtP
   jGHpN3f2OjBRdi6U8WDu7nCBhGnRPnXFlQwBi+o+/VQapQABJWbWpcdHt
   aDskX0dGzkfC4fwU6nE0El51cxX1zD56UD1tXul+HB/Qpq+tWxbDR9602
   UtNynsZHF1xTrxgvSWov4yOYNsyT35CMcFiB3SS7UGvTHLEH/8H+u/wtk
   Oknjd03jaMGNqmweXrohfnc3Yg7tQHjNyvIfX3V7cWMN8Z7+UF258J3Pu
   Dv2whHhyo4Jbmcl1A50ylG1YiWaDspvbJF3aqxUqLAFzpMDZEZG3T+Qw/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="385577988"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="385577988"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 15:58:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="841140758"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="841140758"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 15:58:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 15:58:26 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 15:58:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 15:58:26 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 15:58:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRx0iZnH2tq506rHl+wIhsw94PCqxW6Q/IDrpN10AMgblmMP6096RSZHIiAlgql9xjIhHOPRq1bw2A6A28ZY/0mAtaMPoYppFqNKOYf8DdKZgI3T1nYoAuZjg4CbZAxLztno1XOhVAzBrDeRUJbfZpkyzRB1mJ1DNErToEC4N6NCiyrSnzHjjqxjAzDIQ+l2J3tVuBh883B3nq58xaxNXJ3Ecuzedwr6pdbQmK2SuHe/IOWcwlCmNjAbFRC5ehLvXIIHU19umcvaAg1UwrzZTeUQim+tYgbTLcujH5GjUPGAm+tWmEOpx+SOmW5cJd2HHvHvdTFb6zj2z4YPeC/1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0axU6bXq+oVMOPFt4AvY9w9CEVVu54HXdv6y387nU9Q=;
 b=PzFF7bUNMe8I7in1WrdKOruCT/xizMpM9jB9odyzsuUJyW0TfTnLeqwZuQWA/TKgiI6ZFoCuijiwwnb93MCTW507V+ZzPpj0nBFsOvG+b+nObyRQLwpwAHfXoAJoES4jrHeHZcS7xHkrRdnfDoYB0oCQ0ZUMhGAJeKALnIdbU7wMTp3qWBl/pTt2Nve8ljQqlvW1uKzNM6dufx4lbKvSTGTgbPlaS2XvtuvS+WZPxwxYC77MFn2XNqg3HkH0SOXe8CLQDmPcGjIDv45xM20I2F+jfzqtq0yuPmm8E2zl72YX9xK38COTNLyrVo/2ARCA/TLdHtapJldlAdVx5yXhIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.31; Mon, 2 Oct 2023 22:58:24 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::c438:45ad:1a1c:e168]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::c438:45ad:1a1c:e168%3]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 22:58:24 +0000
Message-ID: <9074ab58-7528-ddb4-7445-e4b4ccd66dea@intel.com>
Date:   Mon, 2 Oct 2023 15:58:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 6/9] platform/x86/intel/ifs: Metadata validation for
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
References: <20230922232606.1928026-1-jithu.joseph@intel.com>
 <20230929202436.2850388-1-jithu.joseph@intel.com>
 <20230929202436.2850388-7-jithu.joseph@intel.com>
 <e8bcbdcc-8cba-57ec-b0fc-4d66305d5aed@linux.intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <e8bcbdcc-8cba-57ec-b0fc-4d66305d5aed@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0122.namprd04.prod.outlook.com
 (2603:10b6:303:84::7) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|DM8PR11MB5592:EE_
X-MS-Office365-Filtering-Correlation-Id: 82aae871-6a56-4baf-bb5d-08dbc39b14e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYGnXW5YxakoeXNkko6KfK+g2D/pZUwAq7rCQbMjmShcbwFwsX8Z4LHeG5i0hzTqu8hAi/o1Gi/R6vXGvVP5UCP78Usr4nWdi0dzQePZzrjNZzj6lZIfdD753KVgVEPRJx3NlFqa++mbOt0CDvLOVs3VUqrpwDewHm7zaPt8TEMbZmsGyGbWOnToHoGbSnqfKASsZu14qg0ZWCkPu8/EUyhhBsN3o1C3ks1Jv81ZKZGpt+VeqqUdFUcirPQuludvmd8olk24wlZuV5pWhs7MZHVod3Vn7HZxMqNDWs0GQlZzWu9mPvLvh9Km253y8TyBXukOOaB0d3OlRN6Q3FyHCxiBhi+d7NZRuOJBBF+iOLILcj3VYhKP362CqaHovYjGZTvyge0Cvzb/Ph2c0UHp7Yof4VIeIWG/KM7Tss/OOjz8pHqcYvjPHXbZwxwzNgcR+L1G0v0ywqsVxoMSdIMDgdARimsWD4rTvVsm7wfolfo1jBiBCltbOeDRN2A9L5AJeKkwD92zUDM9aL3MBUE2g5wbEqqVBJKqM6dWfrCKWoF0IGL4JMi9RY4n5gtYpxzxbFkm0DnFXMJAFL+DliJ3iQlhy0kjK16U5h0ytLXAumQoKOSt62H4UAfC0jFVDyKMXv18gocjaLXkF2s8jhyFXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(2906002)(83380400001)(7416002)(82960400001)(6512007)(53546011)(6486002)(66556008)(66476007)(478600001)(66946007)(54906003)(6666004)(66574015)(6506007)(4326008)(5660300002)(8936002)(41300700001)(8676002)(2616005)(316002)(6916009)(26005)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkhXbnRGY2V4NCtPNmtlSVRCSUlrdmx1azVMWlpkWWRsb1BqQ1ZQWTltMUQ4?=
 =?utf-8?B?a2VVU1JQazBUeWhyQzVPR3RHV2lJZHI1dDdSdHJ3bE9sQ3Y4cG0vOVo5aU85?=
 =?utf-8?B?WlRIcFhmVzJFN2VFYmwwZDR6UkJjdlFpUlVoRWo3ekJjMDZqc2hqMXBaeFZV?=
 =?utf-8?B?TGR0cXlmN21xVmpHQ1lVUFQrNEp1VEFrWnZaWlcwVWJqNVgrSWdDVVRsT2dI?=
 =?utf-8?B?Y0lHcy9YNEdoOU00Q3NyMW9iakNNbGJlb0kxeFNKS1Qvd2h5WUdVRXZPalZ2?=
 =?utf-8?B?R0c4RTI5dFRSaG5EZHJNcXZLSlUrRzRPdURHQll5QW5jaDdRWGc4M25BQ3k2?=
 =?utf-8?B?QURpVWEyZTZjZkQ0b01EdDBZVktXdUpvR2tTa2RjUTFwRDM5WVJDQ0MxYWFh?=
 =?utf-8?B?K1NmY1FPNEtyYVo5OHdOMEE0aEdFRTVWSGN4ZkNNK1ExVEsyc1RSVGlucHVW?=
 =?utf-8?B?dDdzbUJITEFlczdDTjdQRXZOVk9VWEJKNGg3b2ZDd0wzemRaMEUyQjBoa0p6?=
 =?utf-8?B?NWFJWWczdWxvRXpBMWpJNy9oWTB3bmlLa1dKZlg5V085dnZFMStFT3YrZTZ0?=
 =?utf-8?B?ay9paEpNdHVxSUFyeXBHNnpRUHpVbGRhUGVVSExXckxvak0vR3NpbFQwdG1a?=
 =?utf-8?B?SmM5UUM3M2xsNVZCWE91U1V2eVhDc1RxTEEzNnVJSGdhbXNzcHcvL09FNmI1?=
 =?utf-8?B?Tlk1dDB5T0hZNUkwRDJQb2hMZjBnYm1nSXVKLzY2VHNqWjZDRTlMMm5qRjVH?=
 =?utf-8?B?Ykc5cko1bXRKK2NiQ1BtVEdSMEpTQWJBSERzS1RDbjY0cUYxbVBtYWNkdXVk?=
 =?utf-8?B?cGU1Qm9CSDY4Y0RUWEcwNkh1TTdEV21vVU5kZzlHelQvRUlXeGplUG1oVXAr?=
 =?utf-8?B?dnJtaWZHVHNsQ01DV2x3Y2pBZ0YwRTc3WFhuODNKeDc4Nkt3OGZoOUVrWEZU?=
 =?utf-8?B?Sm5UOXF3ZFRZRDdrb0hzTTQxWk9nVVMwZFN2bFZNR1lSTHU0blJZN0Z0anJk?=
 =?utf-8?B?NFU3WEdaWDFZTGhHY3YvTFkyWVVtTXFCWmx2L1p0QzNKNFNPNnYyQU92c1Jn?=
 =?utf-8?B?RlF1QnhRQUNRVWhjTDdTa0VlVFhBZHRMRjloTlZicHl1cjlFTmlpeWdyNjhE?=
 =?utf-8?B?UHozYmNjbFBSbkMyNklUc0dVbVIyaFRuaHNkS09Rb1Z2eFhTSkE5eWJWMjNo?=
 =?utf-8?B?Z1pwSVB3RStHL1hVakRUREZrK2kra2VYRlNQOUtIYVVISlQycU1MTCtoemM5?=
 =?utf-8?B?N3ZTYUN3RXFJZzRhSlBVUVV5bzNlMVdTWHNOV3pQZ2NUZG9vZ05yWWgvOTlx?=
 =?utf-8?B?V051alNQeDQ5cXhkem1YQW1xMVV4eWE5OGc3bWJTK2VRVjNVdUw0UVhpc2RV?=
 =?utf-8?B?Ky9ORXhsNE1SY0YzZVYzNWtacVBqemE3MTkrOWNIRlhDbDJGcnl0d05VZld1?=
 =?utf-8?B?S0Mzc3duZFRKcjFZMzF2VkJCb2VEYk1uOXRGMmVJeEVyN0wrQXdkVHB1cEN4?=
 =?utf-8?B?OU1NNkY3WFIxMVVlRjdFUnVQVmhKTjdwdXJ1US96NmkxTUpGaHFvSjNIS2Jh?=
 =?utf-8?B?WU1FV0FJU0NVUW9MUHJGQU52emNnbzBvekd3NnlMZFk4L3JVS3VKZHlOY0tY?=
 =?utf-8?B?N3NLZVovaytTMVdtZWtuS24yYkdRRWpaTlBkY0E2MXVTZE9UczBJdTBoaHVa?=
 =?utf-8?B?Y2dVWHZ1VHlCbUczYmV5WjZSMVc3N1NmckZCZmlZcUQzdGJrTTk4RUlObnk5?=
 =?utf-8?B?bms0QXp2eml1SjBkbUdwS2MvU2FhRWc1MW9RWEtTZVBzWUswbHZ6SVBOMFVk?=
 =?utf-8?B?UlA4elhoTHEvUEpIYm42ZmlzTjlsSDlmdnZxNGNESk41YkcxdFo3RjlLZU84?=
 =?utf-8?B?SW1odkFWMGx5Yk8yUmJnYSszdlZmemtEcWNNdUptTURVSlE5aVFkT0FzMnlL?=
 =?utf-8?B?RzdXTC9kS05aSXdHbWlmc0g4ZEE1NEpxY1h3WVpvakZKUVFrQ0lGN0UvcXds?=
 =?utf-8?B?L0EzdHRxZkdYSEI1MkJDaGlrbVJ6bGNvN1h2Q3lTWWdkTWxCcS9UNzZJM2p5?=
 =?utf-8?B?ZkY5bEJaU2RURkNKdTZaa1BHaFl0ZmZCb0NVNXBUWWpuMHFpRU1nZWJyZm9F?=
 =?utf-8?B?TkNRdWFjaEg1SFk2SlBNanRSK1VWYmN2Q0IzSVJSd2RrV3ZwN1ZvWWxlRDlv?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82aae871-6a56-4baf-bb5d-08dbc39b14e2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 22:58:24.2663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I22096YtYFuRiHxKY4wEYuoVlJWlEh3gcmOz6OSL37a1CYMEx8Xo57M0bVpiemtamJrbj1AOlSiJ82lWpM4kqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5592
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/2023 4:47 AM, Ilpo Järvinen wrote:
> On Fri, 29 Sep 2023, Jithu Joseph wrote:
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
>> index da54fd060878..6f8abb4729e9 100644
>> --- a/drivers/platform/x86/intel/ifs/load.c
>> +++ b/drivers/platform/x86/intel/ifs/load.c
>> @@ -291,6 +291,13 @@ static int validate_ifs_metadata(struct device *dev)
>>  		return ret;
>>  	}
>>  
>> +	if (ifs_meta->chunks_per_stride &&
>> +	    (ifs_meta->starting_chunk % ifs_meta->chunks_per_stride != 0)) {
>> +		dev_warn(dev, "Starting chunk num %d not a multiple of chunks_per_stride %d\n",
>> +			 ifs_meta->starting_chunk, ifs_meta->chunks_per_stride);
> 
> Please use %u as both are u32s.
> 

Thanks for the review... I will make this change


Jithu
