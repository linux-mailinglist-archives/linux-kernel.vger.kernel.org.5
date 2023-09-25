Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261667AE09F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 23:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjIYVTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 17:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYVTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 17:19:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AC8103;
        Mon, 25 Sep 2023 14:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695676786; x=1727212786;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NxdBZRTXGwZ3Aj90vU3kviTpuzD823fzyhY0SwtaZIg=;
  b=bNd8lRjvBvDdFmsS3is8TpbNVsljWQhbIk5oq+Oe7xur58DIgRSsr1oK
   AzjrVntMjhPyq4/HLgeuVuks1bZfHAHVo7HjpAzjA8pJ3iKmZ0b2JbiEu
   YOIZAE92KQwyCB+SEhUFsJmpsEer+CMHrPDpY/osnSxzIF5Bw7txDKhHL
   y5xzGM8IN21WflUYtfH7sxyUYSYTYfYuov5cXUafq5dfrMJ5GjZJw4OQb
   lyH0hpt4yU/NJ68LVCJMn4AfCStc/Aj4Hfr55yj0Qe0/3gPsN0XUA59Tj
   1jEOfAJZw21mxCnSJuPBO48km4ok2X/vn8RCHgi2PVEhpfJOOn7u0tU7t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360776340"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="360776340"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 14:19:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="891914026"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="891914026"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 14:18:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 14:19:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 14:19:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 14:19:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8tWM9dRFxQykTvQEeYA3UWK8gdoi0twEBt9fKepS/EeIkLz01iH7yrfP3gMIFNYxHplksPHHpxHNt351qnG+vEvk7g4tZuTslarAXUEpuAbS2yN10aOourbTjilWM0iKIr16pq0Wym/jKBCbIa+qmggP8EgjDeVQLlYeq7VPkUVao68eQHyUgMmPxexQmzY5kT7bG8l6302ADVSdhC6AX4nDzQJim3aHqXEwjmg+bTFjtL/Vz/RAmWIk6V5uvNuo8zMwn7SAwDxffbcW06S/jQME6CdPIWmFDpp3sf1aIjNd9HU7yiZK8FXhreUpQdzWAr77rIM6AQEDXn6+TyxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OH4feiQzJ+a2Dt6Bx3I7Hx59RHAQ2u2gKTpaX/Qj8A=;
 b=Ekx5AopT5R/JOF2xRqKlx8ehfVPDGCf2ZzZqmz8O9e4AcW2sSB4mMYaqV2uG3VAHJ1SZCDN+vysn0M0IUjEKiDvrFSARtUukr7ry2kNkaXiebeO0I+iLXIIqw0BxnLn4HPuF3Abg/wZ6J3NAc7xEwAmMmB63MpCRX7r4fCljdwJw5zO4jSh78WcTZJZNtffaldrs2v+z4b0STOJlXS9eD+YZzpiAcsOE5Qz+QXKVQieMqHZo4Rs7tpXT4w51yBZRrm/KsphQ7P4T1ihW7aGa4Yv6uSDBWV+zAU/Mb5eEjxK867ifiA65Y0bnv/ZP7FOotyj3/gsBnDqpFf0mG9VHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM6PR11MB4707.namprd11.prod.outlook.com (2603:10b6:5:2a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 21:19:07 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::cdca:c91f:da79:a1db]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::cdca:c91f:da79:a1db%3]) with mapi id 15.20.6792.024; Mon, 25 Sep 2023
 21:19:07 +0000
Message-ID: <f8582d20-c8b4-4f8d-58a9-aacf2052c7e9@intel.com>
Date:   Mon, 25 Sep 2023 14:19:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v10 08/10] x86/resctrl: Display CLOSID for resource group
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <paulmck@kernel.org>, <akpm@linux-foundation.org>,
        <quic_neeraju@quicinc.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <songmuchun@bytedance.com>,
        <peterz@infradead.org>, <jpoimboe@kernel.org>,
        <pbonzini@redhat.com>, <chang.seok.bae@intel.com>,
        <pawan.kumar.gupta@linux.intel.com>, <jmattson@google.com>,
        <daniel.sneddon@linux.intel.com>, <sandipan.das@amd.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bagasdotme@gmail.com>, <eranian@google.com>,
        <christophe.leroy@csgroup.eu>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
References: <20230915224227.1336967-1-babu.moger@amd.com>
 <20230915224227.1336967-9-babu.moger@amd.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230915224227.1336967-9-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:a03:180::31) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM6PR11MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: d65cdb0c-72b8-4240-335d-08dbbe0d0d31
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8cUjT6zONkE66pSFvQOFk5YWuo8NS1LKvd+NsopfXJf6LGutq8FNF6zmXDCAGixKpWM5EuA2SvmQdHtq3qLjKO2pXtSaAk8bl2NqkQpXz12K9sJwVbhiy5OKXymmsDNoHJPdNLUhO8Ykh9QiLQg2eExXjhcnixhYUxtRV9PCFxWDEVqaqkOJ1dJPyPQyzZToYkPMpxzle71aFYwp1CK/2iw0VdAEhBZG3sndBE4a1XuRI8WR3RkSy48XgYzRH+A9g1io3lwWaNjuGF/wHfzQaVosoaMAL5lw+QaGzZuVS044sYfX12iC3Ic+NMoUWnn8BUCOaMtlKHCJ625qeORyQl2+1q98cjfuhqlSCeaYP7t9WLBqjXDOHxhm+pxralOaDMgEnMBnPasOnH5POTR9cdLo8xUbuXvxfSNjXhfm6ryq+Tjrz50AOHgj7Gk8vDNuZwlyxR73hS9KBFb706QGagGfx7euPgxW3uKMn3ku3qufrbNAizLXP5dyUwLFYeKhghF97UzKG8a6YfLzZKcep1mW6BHFLb2Fzka0vz7CXEzV8JUFWbxomSdliQh8fjUNt6shBJsCK1NQDNXqkSeGgjPAyomSvwXWyxSDubBJFUIkmra899cGAEItimSiZwE2z6SYg/d/ACxG+vApTg329w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(186009)(1800799009)(451199024)(4744005)(31686004)(2906002)(7416002)(7406005)(5660300002)(66476007)(44832011)(66946007)(66556008)(478600001)(6512007)(53546011)(2616005)(6486002)(26005)(6506007)(8676002)(8936002)(4326008)(316002)(41300700001)(82960400001)(31696002)(36756003)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXZyT1pwU1JsSmlHUTJmemt0d0gwOWhnajVWaUFtYWZVdUlFUlZEcU95UjNo?=
 =?utf-8?B?c1FkZDZaOWRQQ25PRy9HR2Q0eExMUkhEaE84QTJzNlg3d1pPeklXRlRVUGs0?=
 =?utf-8?B?RFI3WnJaaHAvcGF0WXh6MmhEdk0yb2RuVUtGTmhCa1RZN3Y3QnVIK3dMRzht?=
 =?utf-8?B?SnNXM012Uy9BNldlVlUzUzlLVnhrYW5OUkpvL0dCWjRGRzlPQVFjdWF4RUR1?=
 =?utf-8?B?RG5oa3Fya1BXR2prSzRTVkJUSkdJN0pjSHZHS2tSYzYwN0hxdjJtVUpacG9F?=
 =?utf-8?B?YVEwZnNtSDFFVE03a2liYk10Vi9VemNNZ3ZzNCtOVTJKckcwZzYwSUNieEo4?=
 =?utf-8?B?MlhoYUVXeWR6azVmRW4zandKODZJNXlCSjdwbmFBV2tkN0FFbzYvb2JTdnZP?=
 =?utf-8?B?cmlVeVNHYkVBbTZSSS9ROGY3WnNEUzJHcHBqVHRRSzVMNFp2d3l6SVdJcEVm?=
 =?utf-8?B?ZlcvZXgycWpxSUVlTGJITGV1ZWVFbldTak1MZnRiZUxxZnFkMEgyTUx4Wjho?=
 =?utf-8?B?bko4U21UZlFaYTdFMzZhZFlkTXpaL3ljekIvaVJFRUptQitIWTZSN0RXa1c2?=
 =?utf-8?B?RWd4Q1lFUHVLa0hWRHgzQ0RhbXdVOG9kZmlHckR4VG0yVmVRSFArNmtJVjdv?=
 =?utf-8?B?MzZlZjF5OU9wSG9RdzlwZDRXYXZRWTBOZDR0cU91OENkL0xWWW12bWgwWjg0?=
 =?utf-8?B?MDBadEl1Zko5N0l3SXZLWXpZdHJTRXdJM2pCQ3UxVTZXd2tMYTUzUzF6Q3Q0?=
 =?utf-8?B?d0Z6eUJ6U3lBdE5qVUFvamN2WXQyamJRdXJFY2FtbEkwelVvUnBabnMvV0tq?=
 =?utf-8?B?dUZzRlJSem5oYW9XTlRqNmZYT29WL0VrbS9MZXF2dGpQYVJpS05aUStjbmE1?=
 =?utf-8?B?U3pGMGVHSXdJVlNUNzMwUnNhdExOdXUrcXpXRUM2cFZ2cjVNMlFaczUvWG96?=
 =?utf-8?B?U3hjL1JQMXdxUHVZM3ZDR2RrZ1pQQURHOTFPVDdUbWl1M2RDb0VUazRURUgy?=
 =?utf-8?B?Zk1IM0k2MFd3cUNFbXpPRDNpUzZaTFphTE9yczJyZWg0ZFoyRUNHTmxJa1Y3?=
 =?utf-8?B?RnpXVmpwUXliS0JPbDYxOVZJTnoySXlsQmV4dnpxdkpiL2J1ZDFmSWQzeGU0?=
 =?utf-8?B?VGMwQXloeVVYdFFPTHYxQk44dEZVd2JkMk44VHovNUl4OE5sei9HSmlDTjVP?=
 =?utf-8?B?cmR2QmlYK3hjV2UvZGR1VFBFUEkzbnZOV2F2OFlmWkJ4STRtMXlRL1BlYjRv?=
 =?utf-8?B?UnBXa3ZJemw5ZFZRSTNHbDFuYUIvNk5tWksyNGxzb0FtME1KSk5LVy80NnE4?=
 =?utf-8?B?S25MVEh2QVR3YkY0Vk14eGUzK0g3ZEUyVzdjUkNCYzhlYWxmNENFcy9ySHY4?=
 =?utf-8?B?aE5lT1FNZUp3TDNOc1d6OTNETFlBRHJqZmpycXJINlRuU3BubklHMStWdFJG?=
 =?utf-8?B?dEpaZFhmcitvWElhSjRCWGttWEo0bmtlS1M5TTB0eVpFTEZkQUtYOWcwcmh2?=
 =?utf-8?B?YVptL0dTTUVQeTVDc3p4Y3hxd29IcTVraDNWTC9rTitVZ1Q5clJoZHJSVnk1?=
 =?utf-8?B?dXRVaGI3WnNmVG5ZK085d29sSHdtSmhYN1Fkb2YzZEltTlhXa3NnQTl4bS91?=
 =?utf-8?B?QW5ubXIxQ1QrbWF3NkVBc3ZTMG5iZFlVSk4wNFFDQ2NmM2oxUmF6Zzg4U2pX?=
 =?utf-8?B?Y0NGdDVtTGN1ODlSaSttZUdmVmZGUlExck1pYkVWL1ZVZzV2dWpPenB1cDRK?=
 =?utf-8?B?aTBlRmtoeFhNbEoyQis5UVNkNm90SHRUTnNqaFJuZVRIbDdTa2hJQ0VDdlJS?=
 =?utf-8?B?Tk5EMHhKYmNlUmx1VW5DdWtxQTBKRk1GcGQ2U2lnTlIrb2NQSHNrNjQ0amNC?=
 =?utf-8?B?Nm9iRFltc3N0bVQ4WkpzOXZwU01LWDdUa1NpSis0aTVZdllZNGlHVW5LbzJ5?=
 =?utf-8?B?VnhZR0E1d3lkSk93WVd5UzBXdCtZUUVHNDZjazU1Q3creG8zOEwvZ21LN3Js?=
 =?utf-8?B?eEUrc1V4ZkR0Z0JYSmlqVTIvZHNyUmx5ZldzbEdzQTNYYmZOZFFBWXNVZUd6?=
 =?utf-8?B?QVpMd3k3VDROTjV6TWpRTXF6QnZ4TkxFSFliWndzUENaYlY1b2dhWHhpUVdl?=
 =?utf-8?Q?b4lavKCAVrFFiNr2PllucAk/t?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d65cdb0c-72b8-4240-335d-08dbbe0d0d31
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 21:19:07.0238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIDeE2lrPsLWHA3uZGCoHgVSe6732Kg1PWIajRbQRPEDY5MQjrlxkBR3zsbfvKYZrsE3l3AynT/59s4/HUYYkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4707
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/23 15:42, Babu Moger wrote:
> In x86, hardware uses CLOSID to identify a control group. When a user
> creates a control group this information is not visible to the user.
> It can help resctrl debugging.
> 
> Add CLOSID(ctrl_hw_id) to the control groups display in resctrl
> interface. Users can see this detail when resctrl is mounted with
> "-o debug" option.
> 
> Other architectures do not use "CLOSID". Use the names ctrl_hw_id
> to refer to "CLOSID" in an effort to keep the naming generic.
> 
> For example:
>   $cat /sys/fs/resctrl/ctrl_grp1/ctrl_hw_id
>   1
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
