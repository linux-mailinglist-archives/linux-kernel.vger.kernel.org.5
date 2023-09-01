Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F6E790454
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351225AbjIAXtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245571AbjIAXtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:49:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3CBE65;
        Fri,  1 Sep 2023 16:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693612119; x=1725148119;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Db3juBuDfy5Ie++FCmKOwmYBw6bK8xDwkwHWRBNJB10=;
  b=D89phe6YqljQASHbHvssOXAqO8gggsmkLDm43NV9za4p5qyLwu1LZVP3
   rYxWCqSCp6SN9JIBYrkAl+btkvYVlHnNWK0GUYXQBQQgJC3ipy/PGfUF+
   /Qp+gAgluzRu1FdnI3G7P3Kh1eQv1j7agOKnG5n5SayDSJz6hg/4r/qSM
   Tg2YloUffkpaaOkNcfLNkanemvrr8yWos5O6Ou/6oXovhi5YuyYClEWma
   TmxrthvxksGEnXFQuOTEGkEsidlxhh3XDVZU52EluJbjheJwGp4ga4CAI
   kgpHBgHXzMNRmpuBz9w8obYYa3/6Osgeqc8yic4cu1pmKMfOVRVON8CZN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="440299679"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="440299679"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 16:48:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="740082678"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="740082678"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 16:48:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 16:48:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 16:48:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 16:48:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 16:48:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqDtoKOUIjgUlUdW+IgQm3PvHD8VU5zQEZnpsRsDB8GLpZ7BnZZej8nGHlVcSHuWc5MrW+jq/Nz74jKpsJD7THjMNdPHOkfwrgJ1bb4xbPi8FW7OUCfEME/am4UAZpGNmL9i/oEF8sNkTibvFGjUUJGCxQlkT335dUCY/NYjsZT87OGn1uSysYFrGgHW/R4EXgCCEH272jtMRv2ov8FkSeNE4VOgqCTmFMqeFAcrKSUiOS8ZlKxoo0v3Oagctn3ZWeAwYoq6YUryVlbMIfc8F9H7GGnktGsVsz4yw0LAX+/nesdUE73yMqSDOS+a6wsDrJaFjL+8xWuOY5Aadx13AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b42Ud7h+puO8YGIivWLMRHOTiEFYx2v/1r/MpFs5T6E=;
 b=NmtNiMxE0wHeqateciPTDkEdmCbYjr6kNC+fncp1RF5V9CY+eDgRLTHstovZhnlrvUSVBl/GkfoyX5CBX7eW4rQehzWqW6iqKqSSuMBROnbVx4ce8jcLsqWTevI1B4qymFzvq0Ws1jk6XMbu1sV7kU111+QG39z9laydPj7K5CZaux/Wb6I0nyds4xuxezAxTFolUWcz0JfqRmOq2Juim/0V7T4OhOMKisVsfFoM8G+ht7HLIjNNeIbosSMGdcR59Ycu1jRvy4c3HzqM/orROLO+s1PaZExMEJGrrbnTajlE+VB8pp9MnjOPaUxrLMvTXUb+NX1mYs0cAzBAjguFqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4793.namprd11.prod.outlook.com (2603:10b6:806:fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Fri, 1 Sep
 2023 23:48:06 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 23:48:06 +0000
Message-ID: <0002409c-5f8d-e783-2e1f-1fac3886c799@intel.com>
Date:   Fri, 1 Sep 2023 16:48:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v8 6/8] x86/resctrl: Move default group file creation to
 mount
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        <corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>
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
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-7-babu.moger@amd.com>
 <d6af932b-4e1b-103f-77f0-d91c2f3fd75a@intel.com>
 <f33d96b1-ef46-f1fd-94e3-52baab2fd29f@intel.com>
 <87cd3ac9-7ade-1d57-bd78-da78ce0d2cdd@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <87cd3ac9-7ade-1d57-bd78-da78ce0d2cdd@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0318.namprd03.prod.outlook.com
 (2603:10b6:303:dd::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4793:EE_
X-MS-Office365-Filtering-Correlation-Id: de0c811b-0e68-4271-9f6d-08dbab45e377
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2dYpPzFOg/pnpkvugHmIN/M6HCeTRQA8wplMVNetU383gxw6M8rTtSLLA1RCR0tmsPndQQBoIh9pv0FxdtWLA0pokd2zgpvew2hikCzW4wvNyWCKIGAZjAqQtRa6/e7JskWgvUWdDiCBjERZRY3ADQo7Sk3+t9zi7qzvGOVCre/uFqwvqc6udj3FgajvQfULDYUDhPrYWVK3mPlvutXs2dz6FyCh1JzR7MjnNPXEsvJJ5tjcb/y3UHX3PmSIQ38ljo3WcvK7QtUFvLHPjQeQTskUBu3K+gmprVIf/U3Zqfa4Uf4E1hqybHPGtawmStnHglCnt18ZM3P6AjSHBzOCow2CHroGMZqFPjG12i6FMj9OVpIokbtXz+I+IDmvfV9IVe9nHDjT0rmHlmd+iLBaiM1U1TwRFQ5jHFbASl55JWuB56mbzNYSUfwF7IZCa0QT22O63btghbk/halXJ8AsmCL189k8a9WK6zRlYeq891dvcWi3lLFCv3kN7aKj12VETknqULeaJVtulk3EHfjRyQoFMwbRMIj93iT8aY+r09OXTOCXZMQHpGIG6nGVtmru5zvo9uw4m8V+1AF7BZdhidyyIs9QQBF/KvGJuQbZWyfRZGCs4paIvZ/uM8/HBfRM3e0Hc/tId8jZ00KXff9d6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199024)(186009)(1800799009)(6512007)(38100700002)(41300700001)(316002)(82960400001)(7406005)(4326008)(7416002)(2616005)(2906002)(86362001)(36756003)(558084003)(26005)(5660300002)(44832011)(31696002)(8676002)(8936002)(6666004)(6486002)(66476007)(66946007)(66556008)(6506007)(110136005)(53546011)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDRyVlU4MllqanVudlcxRGYwUFRLMXlVUEtFY0o2aC9zejB5Nk0zS2h0TnpR?=
 =?utf-8?B?aVFpRVlqRkhpZUhrQmZleTlQdkRRdEhNZDhEUjRwTG5oVG9BZ3pWYnpCTkxu?=
 =?utf-8?B?NDFkMWw0c0VKbDFCb1FpUWYwWXp2SmZpdjh3Rjk3dDhDQzVHOG1ma1hJQnZw?=
 =?utf-8?B?L1UrMGZPSG03K2pPc0xwK1MyVEp6cWhmczRtRlVGWjhaOFpZbnpNTlRZYm5W?=
 =?utf-8?B?TnpvSWpFZjQ3V3hRWTVwVjA0MnZXejBZYzVKN0ZadnJrUXZvM2FQcWY1STNM?=
 =?utf-8?B?bzNicGhoYkJRdDZSK0tua3BIcmpUSXk2anJCYUdnODhoUFpuYXFXZW0rY2d0?=
 =?utf-8?B?clhNdytybC9idWxxSUl3MnhHQkhtcndsYWNIYzdNVjdRR0x3Q1dDSkZZNkE2?=
 =?utf-8?B?UkdUdXFrUXZPaUR5UUZrRkFuUHBJMjhBRFBiYXY4K2h1ZmRiNk55VlFjZ2dY?=
 =?utf-8?B?SEtuS3FNVGMzNlRDY3FHelJLSExBRXRXdFYwdEZPUGdkUEY1bGxYT2gxU1dH?=
 =?utf-8?B?R2NTKzZkM0N0MkduekFVNGh3em82bURSODk3R2VzZlRJZndvL0VFK2NCekZq?=
 =?utf-8?B?Ylp3bDJKVXFhMC9ER01NaXVIRGpBNHR6Q3dsR1d4WnNRamZSdDlhNWJzQ2gx?=
 =?utf-8?B?R0ZDMkFNdlJhaHVFMG5Xd1p2SCtDRFE5TkZseFVsRXhtU1hlS1FxaUNGSXND?=
 =?utf-8?B?VkxjTjh3ZEpVSlArNXArOTBWVXR1TkpWemlOaEJPWEVsZ05XbTkrbG92d2d0?=
 =?utf-8?B?MmNDM0Q3M2l0MXNZbFZiNVV1ZVNjL3NDcmpxdDVvSEExQk1TN2plWlpVeWRT?=
 =?utf-8?B?TE9tb1BJSVI1UVhQVE82V3ZsSmpYQ281d0tBVXR3b0hVaHhvdmNSYTI1ZGkw?=
 =?utf-8?B?MWJTblluRVpxdHVyZ2RPZUt6TFV2OU9lZmsydEhuQm1qUWZyQ0lVc3luRVln?=
 =?utf-8?B?TkNySVVFTVd2eFNRdWt2NG9pdUV4RWdSeW42VERyNlpsb0VVa3IxTDZMbEs5?=
 =?utf-8?B?RkhDeTZhS2JSUndydjB6bWdjSGRoYUo0NFQreHhOTEE5TlN3cU1rbjdEeURx?=
 =?utf-8?B?UC91NnpCSi81L2g2dnJGWCtvUDdQSFQxUllhZ1N1aWliejF1QVZLeUhKVGRi?=
 =?utf-8?B?VnBRWS9OUVdWVjlhTEYwTk81SnB3YlJ0WWxkZk55SGl3TmxDWkdRM0lvSGxz?=
 =?utf-8?B?MEZoSzYvYXMzM2sxbzFoQTF0NSt5OG83MzlYRG82bHhvaEZDenI3NDhkNzZh?=
 =?utf-8?B?V1RqV1BscktLN2FVWEV5VmJtTWxYUVlpRTB4b3c3bVNCL2V2R2pMZ1BSNnVm?=
 =?utf-8?B?anVQRytjTVNyL3RCT0tuUWlvQWRNRVludW0ySkk0SFZ0alhOR2tiSFN2dWF6?=
 =?utf-8?B?ZXlJQ0ZudTl4bE1QKzR1ekkyRzdaRFR6bm96TzBPd2wxTzFKdXJ5eEtJS3pT?=
 =?utf-8?B?VnpFZ21jY01XR21XNkxQd3kzWmlDYmhIK0RaN2tJaDdyYjdlem9sNkZHYWV5?=
 =?utf-8?B?dTkyTWV5QlZiYWx0V1FqbDlQbmZMRGdqRER0aU4zNTVyZzROSGVoVlNSL2ln?=
 =?utf-8?B?UDlyZ2ZzRm53Q3J1bmc1c2ZVSTZBdWlnZzQrSGJjdWxrNnRCYzVkSWEwYmdw?=
 =?utf-8?B?aWI2aUladFRUVWlhUHdGZzJLUGluOW54MEJQNmo2Qi9oQ0NOZ01EaHdtQm9m?=
 =?utf-8?B?My81dGFydzBtdlFWYmpkUW02NVN2RzVEL2VDUUhCNlgvNGJ6RG5ENHNwN0JE?=
 =?utf-8?B?WUdHTGxuN3ovSnMxMXBCNVNkMi9ydnRZNWFGelpHMWRFeHBaR1EzOFVVbTBr?=
 =?utf-8?B?WXJMbE1tWTZvMkpKVTlycmNMYTZ5Um9GNG1mUmhzaGMxY0JBQzZNQmptajVi?=
 =?utf-8?B?dCtPamF6N25DbFdwbjQ3Z0dyRUFrWDBDK3lQbi9tRGZRbGtWallOU3hMbmlV?=
 =?utf-8?B?Zmx5OVluRy9Ba29WZnVvd2hQNWRIeGRlL2N4TkYvQndNOFJjc09Jcmk2RGQr?=
 =?utf-8?B?ZkRIanZQb0hNbzJvWUZXTGZJdXhpQlp1ell4TFRxNnMwVktJOGd5cGExcUlK?=
 =?utf-8?B?N3B2aDdRZnBYVGQzSFdMLzdUQVFxempLWW5TZGdjSjEvRVpBeGNxOHJVa0NH?=
 =?utf-8?B?T0krcWtqL0lSK2VuUUd6YTNRNHp3Y3QvVWc0MjhnVUlLc2xKZUg3b2htbDJT?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de0c811b-0e68-4271-9f6d-08dbab45e377
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 23:48:06.1753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmLNzkVkoVGgA6EcPkgQzt99+plu3NwsM8v40ku95pzZLMu8yVnJRrkWPDMkBtFfhDCr96z9MSEtEq/tZ2YeuGP4v20ouvHVdWoa6Pugpr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4793
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/2023 4:46 PM, Fenghua Yu wrote:
> 
> Yes, putting the static declarations earlier in rdtgroup.c is right AFAICT.
> 

Thank you very much Fenghua.

Reinette
