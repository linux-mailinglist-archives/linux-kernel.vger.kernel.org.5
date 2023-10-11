Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346F07C584B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjJKPmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjJKPmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:42:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944FB93
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697038922; x=1728574922;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vDEtE1N7r6p7oa8U4ZDw3PvVJMXu515IiXJGYSJZrAU=;
  b=We59O9wU11Bbxj749s58yKkqgUfwrwlGO/1DFOYuc78hVowT8diJEcy1
   rf3Ne+4/6GZESUnuW6Twd8Nm1t+QRcvetwicG8Quj3WgQdQHQUeFvKS83
   +0OaoLurfznACHtTtTx8z0T6HtCIEXjG8UV4cF3XvE45+QVt+20PvfGDm
   2oytChTw/UntaR1x0WHMijnduYneQ40J8f4T8oYT1RMW7gSi0MCnMwQZH
   jaT45npTvtMQR82opKOtpkpXeNx98wx7dAlA1k+FRahUMiCykQvYfVtsH
   way2WvZkam2SvVLcMw9MOa5YmkJBSUFKHo6j5Pma3WaLG50GDq8j7Ianu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="415744049"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="415744049"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 08:41:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="703789487"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="703789487"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 08:41:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 08:41:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 08:41:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 08:41:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 08:41:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Be/Xl1iAe/xbqplfOhy50Rd4rnMkK9yWTauJfO94KWC1SR5HOrrHHNW8dbbLGUqtkA3bhAiT2KQdDkCyN61D0mflm/1OFW73LLKlSGyoFJt5bkTdd0yjFuu49i3YgGtmRVqKp8xzRgeM4YXMzVplHAkmwaQQN9cAAKYN8Uy5Hb3svNzpKcdyZPLxvxeMxhLwiGGizsU79o+nq6wh9Owor9aD3gBpG+EyggMruvsNFScUiSgvgC2FkNs2Ms9SNxId+pcY+cGg7mXjpChi+J36ZMC9mOM2U9ixy2irNC11YDMHA5TNYaAMxxBCCHvRlOpbFeqwMn9H6+G9GDpK9FLVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtHryYc9UNmxEJ6U3ELrSQ92pZPMnggl6wO6gkQaorI=;
 b=GsxG8otUDhReWGNdHeUftbkwYxq1zwtcQGzi+XTM/RUVac71M0yVn8t168r/TUT5599WnXiBmcZMiUpzsrZZUbmwJUDYgBWdm+zWtnUYZudd1+LyKtBf78p6BsjRgDx6Q9n8Ed5ycIuHV8RHgmLzNtJsBHnXatuaAEFexeV2EKFwRhGeXbwLMqG4DS8eIuUzWkkTC9O9ClX7LHn05EVZ0SyU9TSUt0GYIEhRwfme043B0C1VWkCmPIwkw0JzwML3cl7OGGb5LhVUxOZwSTl6inI1UUzTF/L2TI4cvSQ00lHJnr0UdXw+fDpHJczx0rACmas6XzwKjaUjjrlQIa/8Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5351.namprd11.prod.outlook.com (2603:10b6:208:318::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Wed, 11 Oct
 2023 15:41:04 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 15:41:04 +0000
Message-ID: <c1eb5dfe-2f0c-43a4-8cf5-3d09d4348a72@intel.com>
Date:   Wed, 11 Oct 2023 08:41:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: arch/x86/kernel/cpu/resctrl/rdtgroup.c:1196: warning: Function
 parameter or member 'type' not described in '__rdtgroup_cbm_overlaps'
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     James Morse <james.morse@arm.com>,
        kernel test robot <lkp@intel.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Borislav Petkov" <bp@suse.de>, Jamie Iles <jamie@nuviainc.com>
References: <202310070434.mD8eRNAz-lkp@intel.com>
 <58306525-bd92-18d9-b25a-9c030518cfa6@arm.com>
 <360270f1-8bd8-40de-af54-5527fb1106c9@intel.com>
Content-Language: en-US
In-Reply-To: <360270f1-8bd8-40de-af54-5527fb1106c9@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:303:8f::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5351:EE_
X-MS-Office365-Filtering-Correlation-Id: 99200f24-ef2c-4c63-496b-08dbca707a31
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VIxwja29tYuVLgFeezpXoTkxgR0Rg1xGr8TZhTlqs9q8asiJvnP6UJ0Bk2fAZgmT+Ozl2u331OAaALUQTRkBLFJEAUzyRNCDis24bf3U+ctsObutXySp3dcRNubgM1t4S/NiaTEk3SPbOQsn2WV3USvhUUFzq6anpPX1QXYk34obfY5lb6pnqywxf3sym6XX8UzM4eq5beg+RJ8A21DRHlqY77ThIf1gPRBo5xGV60OhVfXkBREujbasvEPpgMgYma2NWVPP0QLk7rB5qff9tczdEXVm1jW/NNp16eFkpvrYgWwu+jTE0TkaxN1yCm7HPY/acrpZ5alQBxim9MqZfOkyVcPEizPnJlMGyNR9QaHfoeT0FIyJZO1YGO1Pt5vJCy3AO5l9WUTMDxeIKieXw6uSKCyDtacCGcpueHTkefUozHNcU+J1IhEqBfgFuEPvNSiCa9fuDTkQrNxIf0LebxaEZswyOCGO7CSFHyDrDc0Oq68doSsOdOu6keyL0A2u5+YZX40CyuXaHXw1WtRBW5rPuIoDOLDNsitSrMCWP5gDqb8XPo8sEnhQ/PG+sbIcJQiW3VnyGxVqseYme9HIbqBK53HOUaGZXJ/z7/dfNz0Jpwm6EGc/TrlpGwRbuMFyePZUrCMDKSmylGs0oC+dlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(26005)(478600001)(6486002)(966005)(2616005)(6506007)(53546011)(83380400001)(31696002)(86362001)(6666004)(36756003)(41300700001)(8936002)(8676002)(4326008)(6636002)(316002)(31686004)(54906003)(66946007)(110136005)(66556008)(66476007)(4744005)(2906002)(6512007)(38100700002)(44832011)(5660300002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmZsa1BVVFBYclJCc1dtWkpra2pUSTI2UDFuVEdtTXNBM2tnSW9YZ1ZLZ3FD?=
 =?utf-8?B?eDQ5U3NXaVNNei90bjZzSG1KUDJDZnVsdU95U1N4UXlUVkR5dEZIMzRMZkp2?=
 =?utf-8?B?am5HM0QyZUpNUEJVaHlXVXZrY3hVdzlyQWxJWnpvL2JNS3RsNm12VHo4QVRx?=
 =?utf-8?B?ejNVVGFUbjZIN2s2NDNmdUNIRUZES3BVT01sNGdmbEh3TG55UktBWXVWQmc0?=
 =?utf-8?B?NndqZWdzZE44L21tVi93WWlZMzN5cU1GUFhjS0g2SGJlcU9GUVBVelBVN0Fj?=
 =?utf-8?B?RFc5Z09KVVpWbExDYlVGMUFRTFpBM0hDSERqT2w1a1BLNlR2OGkwOVI0bXNL?=
 =?utf-8?B?aHZ5WHJFdndNMk9xT2pzQThTTjNvUGh5T0hyR3hYUnk5enF2WU1vK1RpMmhx?=
 =?utf-8?B?alplaUREK3FzOFViTW91aWJwQzlwNGdYbm8rTlgvN2xpM1loV1gydlFnQ3FQ?=
 =?utf-8?B?VDYvekxVV3Y3d0U5WlhFZHV2YklhZXVhTWlmVnJZZG9PL0k0THlBTCtaNzF5?=
 =?utf-8?B?aHpoTDhreTNJRk5uVDdlRTV1bFlBOGh6cDBlK0JkYWhadUN4WkYxbUg4TUl5?=
 =?utf-8?B?cXdJZnlMeldVZGVKcTNvQ2R1cW9DaEVQNUl4MFY4cU5FLytteTZIRStQcFlt?=
 =?utf-8?B?TFNRWDR6Mk9KMWhXOHRyK0RjNXRwWkdtM3pmMDcxaHo0c0R0b0lpTEFPUGkz?=
 =?utf-8?B?RmlDMzNMMzVQNTZseFZiK1FFbnU4VUdxQW5jQzVYdDlVL1NLa3ZiSTlxK0pV?=
 =?utf-8?B?MXNPRUs1VEQxLy9nNHczMzQ1TzNMZmx2TDU2SkFFNjh3dlZPNGk3eHBlVkFT?=
 =?utf-8?B?V3JKWHQ4N0dRR0tkZWNZcEIxQVRoSklNUzdIRzJEVzRBM1N0Q0lQZy8zemtG?=
 =?utf-8?B?N3VoSFdNbW5ZWTNsUUJYM2hrQlRXREhKZHFqZjJyQloxVWEwMmxTblgvbVNr?=
 =?utf-8?B?WmQ5ZGRwcWo0a0ZrU2cvQmNmTExKRzhjdDEvOU02QWwvbmF2OVBQQlA5ekpt?=
 =?utf-8?B?eVExdU4rejA3NHRGT052N3Z4Nm5OZ2M2T1Ywd1RPY20wclR3NmlKZy9pMHZF?=
 =?utf-8?B?QnlzeGlCMWpSbWJIQ3IrT3UyeDJjNjMxcjdMQkFRck1uR0pnUzhrNHdOYlYz?=
 =?utf-8?B?aWw1ZkcxVG83UFMrRnUreTR3ZUh2QUpqMWhzL2tLMG5obEk5Wit0cHBIOENk?=
 =?utf-8?B?VUhaQ0JTeDdpRXZkSjdnZCtabXl4MzFmdjhhZXNGdVcvdlk0ajF5Uld1b04r?=
 =?utf-8?B?SWM2U0RlVS9Cb3E5MXhLUWRxVW8rOTJ2SmxMUVpobVc3SGJLSmJOZ2dqbWk4?=
 =?utf-8?B?RmxERWZyM3UzVS9jUkJ0SjAvanZFaFl5RW9ZaGNyZ0RFNHdJeE8wSEpuWlJB?=
 =?utf-8?B?K3Y4KzNtNVpqWUdKQmRTamNROXlIcE5CYkYvRUgrMFc4QWplSS8xVkpLYmlx?=
 =?utf-8?B?eGg0ekFRZDBUd2hpQjJGeGR4eHhZTCtmWE9OOXRnNXlycW93bEN5V1dqMVVQ?=
 =?utf-8?B?c0xSQ3E5M3ZDUk16RHRXS0NXYWNNTjBhTnBVb1duL0RWSlRGMGY4VlF5Tmtr?=
 =?utf-8?B?MGozUVZCTFVMVGprSWFwdDFBOHNrN2ozdTJIemc1c2R5UmhGT2JtZEZVWU5B?=
 =?utf-8?B?dldiSDF3SnYzRVhxaUtDNlNXTExWOVZFRlJ3a3JtMGcvbkNTWmhXWEU1Ymdl?=
 =?utf-8?B?dFRGQ3lhb3I3LzZSNjlnNEtTL2h6dnpPTFhYTUlWSDZHMWFEZmxOejZrQ3Vx?=
 =?utf-8?B?dFlpd25NTHRLTkFZZjhoRExlNFY5d1NWRlQ0S0hGcG5RYVlndGtkb1A4TUR1?=
 =?utf-8?B?K3ViUVZ5SmFzNXlXa25aZmRtS1NYMHEvM2hWMXlqeEJ2VGZ4YjdXNGJXSDJD?=
 =?utf-8?B?L1VqTkIvZklRS0dyQTF0akNTeUNRTDdqQVBZWTEybFI5VFY5bERheXBaWjhk?=
 =?utf-8?B?SURNc3I3N3RmZnNLTDhlYlVXejVQWmNISEs5TGhIVlZDWTIyRGpEaVBDODNr?=
 =?utf-8?B?anFwaHUvVmozYUVQODNtZ1B6RXhxdGxKVWRpYmw5VDVvdjMrb2VJc3VEclhu?=
 =?utf-8?B?ZUh2UzNkTTVCN1E2dzJMZzB4N3FmV3VJeUJZMWZFRW1jSkVXdVpSZWpJOGJR?=
 =?utf-8?B?eWtLNWxFN3BWQ3FpZ2owQ0hSb2xCdjVLVVBCbTl1OEp3L1RvQ25uQk0vOHVt?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99200f24-ef2c-4c63-496b-08dbca707a31
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 15:41:03.9980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/zM2j4vu2ZqULDZhq0l/QgGS6j5NGIJqTU/ozywZgmNmNTdiwkv4kEiZ1P6Kx6EWK6fAFkaJSHpR7lTgE4R8q9HppPtEV+p/CHCMN5Z5qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5351
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/10/2023 9:40 AM, Reinette Chatre wrote:
> On 10/10/2023 8:25 AM, James Morse wrote:
>> On 06/10/2023 22:03, kernel test robot wrote:

...

>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202310070434.mD8eRNAz-lkp@intel.com/
>>
>> I'll float a patch fixing all these - otherwise I get the blame for the whole lot when the
>> code gets moved!
> 
> Cleaning this up is already in progress. A fix from Randy addressing a few of the warnings
> has already been merged into x86/urgent and Maciej has a patch ready addressing the rest that
> he will send upstream shortly.

fyi ... Maciej's fix has just been merged to x86/cache.

Reinette
