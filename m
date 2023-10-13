Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC7C7C8EF9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjJMVZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjJMVZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:25:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFFC95;
        Fri, 13 Oct 2023 14:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697232305; x=1728768305;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+YLFW+Zhk/P+0Jy+Y2/3k+dYUMkzxFjXVScdF+JOsBc=;
  b=cYOr2BaAY3T7uF2cK8sjseEKx+mjHoE2UA8uWQM6A7ZKuLmsB7sGsnYT
   g0HN7DRhoCLccWIAbMj0S8csq84ciiGz8AzF8mXprpMR/sirkj+YB5Kbp
   l9om3gHx7CHSAVxQYVunaVTRbdwNVylF2UOVztpt+RJaqLU5VH9QMNW+B
   2Ih04S1F+4eUnoqIGuLWWtoVysHZibsZI/Maiw09ihx4rKFefMKCIXnKr
   PauN6WzrqKOM08xIIvkyBysLtufeM6bX7RI4KjW3v9qxyeMJYmH/5wt6F
   RLR26yPC+KY0dbhtjlz/veZw7klfydcjzrZls1aYgnt1Z90XdnLKEOUH6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="370338460"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="370338460"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 14:24:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="820795612"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="820795612"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 14:24:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 14:24:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 14:24:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 14:24:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 14:24:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnqp+8IPwb8cgjwI4hpzXFCCkymKuBqGh5npYI+o/YLJmxl1xQmANFI9OK9WgeGO4ELlPgUCOXuqRy405ldS/JCysMw9zv1s62ayROmXFcjHgEUAF149zi4H7Ev9g0oYgp8V8K95GOomrAm9T+jZNDfOMeO9OTsHdkDTz4kBCI7MzwQSFIsYy8MrenNAmt1P9KdvsDRgxzjBU/hRPqSOSwWSF6yBKyQZ79h6Qc1DNccHpdgW3hvgYl4nB8v0N7iN9EjG9++G7BjQMTsBKxHOhOsawd7P26RZmEZfXU0L/58SGf64ru3oUGeBbLgQsc7XfZB49WK4/5kCb3I1RBELyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plB+ih2uqbljMloTXZ4oSiPnttNpxMDx7bXmRvVe6E0=;
 b=IsUi5OyYsiNmhI3wPTUw8a2vXGzIRiBDF8wQNkY1q0Jdqe113sydWZWzjhVRjWkkuNqHyyiIWSxMS1CawxBuut2SGqJHcJqvA+ykE1gDwPhVqk6yBIfcrezSV0HvUMFau6W1jQLjbBCpp6c67RBHadx/r+5TdtfSqoVM+Dr2A15FKatavTIRrCqcToYrI6XUOV3/qET2PvEXTV4BGRMJvUKXEH+ccrAuJO4+KJmDTXLOrKVz+CrtXI0fhhAvQoNrScdVbKbHVvKb1y0wTolp6zYza6WdKhKd5UU6t5mOWorLYvzTScuRmWMwOXxQ2bAtmWPoliIscWJt4d4wNMZ+3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CYXPR11MB8755.namprd11.prod.outlook.com (2603:10b6:930:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 21:24:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 21:24:53 +0000
Message-ID: <272769bf-6fcc-4e25-8223-88b1775dc487@intel.com>
Date:   Fri, 13 Oct 2023 14:24:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 10/10] x86/resctrl: Display RMID of resource group
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <20231013202602.2492645-1-babu.moger@amd.com>
 <20231013202602.2492645-11-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231013202602.2492645-11-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:303:2a::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CYXPR11MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd4930e-fc0d-4ba7-229b-08dbcc32d73e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74eylh+pEqf/LmhRlKzsuQI6y3m55Hjf92GZRXU58AsmlXO3Vi9pyfrwXsJpiBycXlxBdbVi7LM+6Z9yEDwyoDl9JOPchSjj45Lu94hzqzMncWPrmlLynWCTQUxwlwnweKDZmeusxsl9oUgN5WMixEHyrpcakI1Bt5i6bn6QhqGF1NY6Po1WOHhSYuIlvjXnJvsfissfVylXCWBAdkXW9OQBZVF2XlgWMDLjunaxo9RB937w8nHkPRaLE8a6pVd7cJWl8P+3gh6AncNE7sbOQw0J28lOORCcD7zs2Z2WWILRLMhUWkRww8AzOeN4o/HRETtU6coh//tEDJ43d7DFST6XYPmwUbsEzgKyVOceSrx7lKaV3wHLbIEYACnSFYcNtlwDNkiRGlcnAN/uDPjJ+Yp3WF/hn4MHR8cVjAB6xxX6qrZjUhiEn9b4+AEUAj/8k2eEqhLfNhO7nHDo7LbwHNuFcV16Qya59cbCiVo4XCWAm+LCoFjF8AnLt0hIw9AkL934AvH0i0An6GHWQFJIiPGnweQw/dSpH8Cvk4wHyG2r/n1GOgtoLDvKrq1ttyvACeksc8q5FnnCZozquo49vU32U55KpwQVwtxNj1qZuYP8VgzsB88xVDVDXsaceoWh75QL9dPQj/w4dobbR2ISxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(31696002)(2906002)(7406005)(38100700002)(5660300002)(8936002)(4744005)(4326008)(7416002)(8676002)(41300700001)(44832011)(36756003)(82960400001)(86362001)(83380400001)(6512007)(478600001)(53546011)(6486002)(6506007)(2616005)(31686004)(66476007)(66946007)(66556008)(316002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUhNOGdXZDI5YjBRS29EalQ1bUZ4ckRpZDdiamkwYS8rd1pxM00xbGFZMWF0?=
 =?utf-8?B?Qy8xLzFZb09mem1TMVpPdXdGVmVsQ3pWNTFMTms5V2JzNHNEVkJpVkgyK2NT?=
 =?utf-8?B?eWVqVGhHcFEzdG1DOFZJWm00Zm16eHQ3bzdPNmxqdGNWWlY0cFRqZFN2ZVl3?=
 =?utf-8?B?QzhtZkQrZTVJYWY1QWdzaWEyaUhJaEdoL216aFVRa1FCWUJuSHJ0RmE3SE5w?=
 =?utf-8?B?djFGcjFlMktUQjhESXdNOVJYdWVWbnhYclh6RSsyVnl6T2lvYmJUOGlVZit5?=
 =?utf-8?B?STBqcVl0VzgrRWhXODlkaDJzNGNZY1lVaGJsTmF1bXVqZHBCUStLVGw4d3lC?=
 =?utf-8?B?WE1EZHpERE5ZeWVEWkVJU0hML1VWMllxUXd3L2VVZVFpYTdGNmJSU0dDZExT?=
 =?utf-8?B?SDFyVnlRM2FMY1Fvb2d4VGE5b0czUWlQS0xUei9LWFRCazdMR1BXc0ZKVkxr?=
 =?utf-8?B?S3RZRjcvT0IwUllwN05uWEdra0ZhU1JYMFNLdVdFbDBVN3pVR0NnT3F1QUxQ?=
 =?utf-8?B?aCs4MFBoeE1sb2RMdmhwOWJra2FSbHFxK2l4Mk5nd0w5QkxWVUdSd2pSUDdp?=
 =?utf-8?B?QTA3TjVhOXZGTkNOSXVvQ2R1OE1nSHdaMXR6b0hCU1poK3BHaitjbVl2bllF?=
 =?utf-8?B?dUNWSnhveEJQa0pxY0Jmc0tiYnJxVmZFdnkzZEJQVWlZRzV2Ui9FRVFWcUl2?=
 =?utf-8?B?ZjlLYXlEU2M3allCVmp3aTBHZDdVdndzL0JUOWFZbUx4dXBEWHlXN2h3TkZK?=
 =?utf-8?B?SWZ2TlU4eDEyZ2FMVlN4SldJOGI2QlJJZEpMTGZGcmdaaXlRK0ZuT3RCM1E1?=
 =?utf-8?B?QUhkZURJek8ya0JsUHRSSWJieFFhN1N5b0tqcldWU2dXQmMwKzdtUFF5Z2RO?=
 =?utf-8?B?ZnhjTzl0Y1J6ZVBZMVJRMWtNRDRGTlV4L1B1aDhtODB6dWxLU1dVNXdDb0Rr?=
 =?utf-8?B?eW5oTzg0K0VKcE5oMUVUMTNESzhpZTZ0NTdEN0Q2YVpDeWRJeEpNUmFHeWZ3?=
 =?utf-8?B?MW9KZksxSWo2TlMyd1ArTG0vTGlkUzE1djhDRVA2YWFoaG4wY0JhZDhpajNR?=
 =?utf-8?B?UlVCZFRkVE11T1JQM3B6WEw4VnNsaDNLbnJQU01ORzVieDVOVEVMWVRHTS90?=
 =?utf-8?B?elRlVjVldG5pUTFOMm9qdHRNTzFqYlVKTG5JNkhSMzBtNVB0SVY5YnU5Q3k4?=
 =?utf-8?B?UFdsTXEwTFAxTUo4cXFyeGxxbjh0OXZGR1dvaVgzY1FGZjIvaDczcGZUNjdY?=
 =?utf-8?B?SENDSGticVlxeEFXYUlZblU4QmNoZjRTM09IYTluRFZzUFcxZ1luRkxOL0t1?=
 =?utf-8?B?VzBHUndyQ2kyQ1RRTkFuaFJsZUFoQU9qb2R6TDVyUUZ5WnN2ZlcvMWQrN2Rn?=
 =?utf-8?B?MzZLakltSlZwSStRczluam5RZEo4TVdqV3Vnb3V2aFozTGhwZXRnNVlJQWd3?=
 =?utf-8?B?Q0NoNjVkbi8yL3Fka0phcS8xRXlJNnVIWWJaTTRTYkptYlhUR3M5YTdXYS8v?=
 =?utf-8?B?cjVvLzFFdkE0dnV2ZnVUclBTN3l2dldCb0pEczE2cW9FSUJKSFp6STFtZGFT?=
 =?utf-8?B?V285M2k5M3lVYjNhbDhIYUU0Vm5jczJWWCt3VkIvbDFHL3p2NkF1TXYyOEFa?=
 =?utf-8?B?UyswVHJmeU1LamtMdk03akl5bXpFZDRzYS9QRUJsZi83d1dnMjhQTWg3YWY1?=
 =?utf-8?B?cFlLemx3azVRdXhzSUsrWm9uSUE4ZkU2M1BJVmU3VmQ5ZDBzcGVPOW0yaVRN?=
 =?utf-8?B?NGI3YnhZMklzK3NZWnk4V2QxZDBscG1Na3FBQWtwT3NwTXBoRVUvWE15TGNP?=
 =?utf-8?B?cUdqQW0zWUVQREJlcFpQZFN5VDNPbkkvSlJmbWI0YmZ6L1ZGMzgvanRRZklC?=
 =?utf-8?B?ME5lSEd4dWRCN0x2K1ZhL3loZHBucmlaalZHNFVVTE9ZNkE3ZzZhbktwR3NY?=
 =?utf-8?B?S21CZEw0SlhzYWtuYzJjTzVnWU9iRWovNldQT0FjU0hHWkpjS0doRXd3ZDB3?=
 =?utf-8?B?NEdtekVqbC8vV2RsYTRoZ1JnYzZGUUI2bkF4SjBzVlFHbjFUM01mVGpYaVBN?=
 =?utf-8?B?eGppdDk3V0hsV2JLOE9BMUdPVHFGdXRrVlhrc1VhUXMvQ2JrS0pjUXZmMnJR?=
 =?utf-8?B?NjIvaFRBWHBFaTdLQWdVVzVYbStjalp2bWZReGx5V3YyYSt4eDhRY3dYaUt4?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd4930e-fc0d-4ba7-229b-08dbcc32d73e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 21:24:53.5904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuNZcLLHd7hMsBBt5BYl7ratCVghCYRmbnh5BPJZxgxZiCXbR1Tx2ZPbLK0EWEQ09SB9Bbsi7/Wqp0VipcIgmWqYs+bflUB+3abW1xJFrmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8755
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/13/2023 1:26 PM, Babu Moger wrote:

> @@ -440,6 +444,14 @@ RESCTRL filesystem has two main components
>  		-> RFTYPE_CTRL (Files for CTRL group)
>  		   Files: mode, schemata, size
>  
> +		-> RFTYPE_MON (Files for MON group)
> +
> +			-> RFTYPE_DEBUG (Files to help resctrl debugging)
> +			    File: mon_hw_id
> +
> +		-> RFTYPE_CTRL (Files for CTRL group)
> +		    Files: mode, schemata, size
> +
>  			-> RFTYPE_DEBUG (Files to help resctrl debugging)
>  			   File: ctrl_hw_id
>  

Something went wrong during creation of this patch. Notice that the
"RFTYPE_CTRL" at the top is duplicated in the new changes and that
the "RFTYPE_MON" changes were inserted in the wrong place.

Reinette
