Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A92377FAFD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353250AbjHQPkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353239AbjHQPkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:40:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4580830C6;
        Thu, 17 Aug 2023 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692286799; x=1723822799;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K2dx8Je+aKTeuveloe2shpC0fs1CUHuotHhXQ8rZlvs=;
  b=d+Y9xERMOzKmmRRhsDSPrHot7GGcRRT2uKGOHZQ9q6oDhbpeK6n+rT2I
   TlCT2CM1AFhP335CSQX+dQq9XSsItpxu9aTZW+oqWP35Wj7jXnC8niZDF
   DQcMpG5AZOPaGxvNuOpHZVGKi7yxYltBRg6hbpfsByOBTidsmE4YA09/m
   zyl3JIMjaTFzopiNXtKegtKyrxwLG05KZ5B58Kq0/OGVUW3o3r8ufaBEA
   /qoU33lq9rdRDk7AjQpnOTNOscJO3XA8SLTsMPwrcdQdmltL5en2MXb0P
   JcM7xNaBZSTc8M+8B2+BK4d8orI0NryoEuTINPZzHusU3sNrIkyU8pQs0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="370311758"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="370311758"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 08:37:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="981227195"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="981227195"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 17 Aug 2023 08:37:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 08:37:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 08:37:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 08:37:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFhiva/fPKRaLK4IqOydBL5cj9qzE6/z9HANEZQhWYMeyOvv9lHsogP/cmp+C0wU8miTWoLQhjAXVlNY5IX9AziUK215zlbr7KkGaJfI+5jpH/2KOKw6DEd2TJLO9bnk40hbHA2JOKXKLkJe/rXJmK6BAHsvWX0Jqa3pgx/9MHaAjuaJbCwstnAeIZbRKCiEeM1eCDk3xpZRZywo8uO8JgkqFme79RiKITaCfQSUL8YvNnseDfoelSW3OQUncComf0MPmco3LM0JblJ/Ew7Vs98cXwXPtuBqNgXrLEhvAiqTUpYICwfzPvacYGgXXOf8YkeNj4jcXFurHmAto4PW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zY07qxNP26kwxY5J4RIepKfWJWrb9cFaMjvxfRDOgtE=;
 b=PQ4yzkUhzC29sVfuoDZwBWiSjt6saHi28g5XFkwtb6UBW4BXIHw0zfoqM7QeBe5iFccdrLK/5liUjiaEvhDyUDsV41hnADxhZwNpWV4KGMIIxbKTbegvv732t4My7l6t/dnpaQOpri1Lzu7CVcqNbIFEieI80jucZ9wVmQHsQPwGbUizTDsKk6z1Z14P1nnZkTplTX9gheh2fnqjWfWSb5IpqbSs52LycgQdEhaL2zNfFdrtAnd2iQ/4+RBv2+gwUlEHi9hzo70Y4PHMR71DW404CAiyEe0JnzqQx2nsZDeMQhwE4HwN+xbS5NlMsv1koOpMfcybCepJKdIhV1GByg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8604.namprd11.prod.outlook.com (2603:10b6:408:1ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 15:37:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 15:37:49 +0000
Message-ID: <6ff03090-bb8b-b4dc-1ab8-1221de8b1358@intel.com>
Date:   Thu, 17 Aug 2023 08:37:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v7 4/8] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
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
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
 <169178458575.1147205.16331131496340363561.stgit@bmoger-ubuntu>
 <37986ad0-4519-0f16-c09b-86fcf2f8a763@intel.com>
 <c341b2cf-7ebc-f52b-76ba-77a106dc20fc@amd.com>
 <25c23223-520b-f6ff-ec8f-678e2524c511@intel.com>
 <702d2d05-d37e-c275-ab05-a88cac49a81b@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <702d2d05-d37e-c275-ab05-a88cac49a81b@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:303:b7::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV3PR11MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: e1992e87-23fb-47b6-39cb-08db9f37e94b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBkhNl9LEAQmmqOKzeHTGRXp7B2PbTL+2oZa0Z+uffFwnPxxt7szKMhx9KMXrbr7bT2K2eRCRutRo1WjK9UwcKF3eOA2rcMB4jPua9rrx1LTriYSIDP1VeaBDViSo9HWM6qgVawqlr4nfrEgur88UBYr6JrljBcTqB/qUKYDAb2tdzQEcsSZAq73rk9HOY+TdWoBqJQetb0vxcRPqhp0Zy0dT+moM/m8bMI5IL93oJHaayjI1yz6ylHZTyGdc4x81ZhdK9OZNjTzhJlAZA2ixzABSW47Bo/GlEIOKObWUGAsVEFKLQQBhn+5qjcad/rEokl+5lR/OdjluI+xdH3RoXRIQl813jobgOWjPRIMqBhlbe2d8di7uW1n1Umrz98CWdbEq0SyKNhrfxkG1Fy378fnTx3wVx8UKLdRSwCV1ks5LNfVjqw5JvnFO/mXvI8/qe4aII6itGPMod80IUzT85KU5CO5S0rPmb8OzVsZM9GSMEGBWYFs2qG9szLPyXpkIqOn4g6/wuncQVfCFnK+/VJrFZj3gv+G013QzobM6RaV0IkZFE6gziTAu0r3++qg9xcsGTKC7EzbaAY5+P1YCUDFBb+l2wHrAAUUw54icOmH10klgUGUgKjONE1NI9dIBArPXJhMz24qV/Kydxycwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(31696002)(2906002)(26005)(7406005)(86362001)(7416002)(478600001)(6506007)(36756003)(6666004)(2616005)(6486002)(6512007)(53546011)(44832011)(5660300002)(41300700001)(316002)(66946007)(66476007)(66556008)(31686004)(4326008)(8676002)(8936002)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3h4ZUJHZEM1QTVZbHFDbDBFbGMrb2ZLODhlWkhPNy9mMzJ0dDZrNDZ5UExJ?=
 =?utf-8?B?RFk4cnJGRTNMRmpaZUN3YUZZYTJlcjNMNUdJTzZINUozUUhnVXdORXkyMW9y?=
 =?utf-8?B?UzZOcmZ0RlFtYWVSd2VhbnhxNUkyUUp5VmRnak1lOGpiKzU2QXdwQ3V1aGZ1?=
 =?utf-8?B?SHIwaFBlSjZSU1BmTGhvdHhqSTRVT2VZQ3dtQzBuM2xXd0Y4L1VBOXJwNytr?=
 =?utf-8?B?TGh4K3lGS1RZWmdjek9FS0Zad2J3SWRJd2dZbnlNYU9Vak1ucGd5eHVXNU80?=
 =?utf-8?B?b3cyS014eGdETXZybEpTYkplUm5GVGZjeWZxbndlZGJaRzRyUTBxTS9iMW40?=
 =?utf-8?B?dkI3Z3hPemJ5cWROTy9sRXg1NkU2VnQ5SStWWm5MNnNpL0tpVVdOU240dXlP?=
 =?utf-8?B?Mm9aTmdYcS9JdFphc1BLdnJ1R1hpYUxaMGZJcTNwUmZTTXZlc2pKSlVUZjNa?=
 =?utf-8?B?YllDYWwzdCtiTGYwSk8rdHFxU3FQQkRMdFZwOWVvSWI2eGc4S0Q2cWhWclcr?=
 =?utf-8?B?eXRGVWtCakFJYlc3WTU3OFQxWHFRd3dRbGFZcDh0RGZSemJRVFIxNklFNytK?=
 =?utf-8?B?UTk5cmJUVXJTbTd3RmpWQTM4RXd6T25pUU80WWNySVRtc2FvdzBuMEtoK1Ex?=
 =?utf-8?B?QkF6UlpGNnNBdnlmYUhYakFLTy9qTThuczNpK1h1dGZqaXl2TjRONFg0YllE?=
 =?utf-8?B?RkJSWndTNEc0b1pxbDZQVHF6cHpoazZFekpqUExtcC95WmNsN29oUy9BVFkw?=
 =?utf-8?B?MFc2bUNNdEdIc2pzdVU1cm80dC93YmNsUHZkQ3Fyc01aSHlieWUxV09xQUpx?=
 =?utf-8?B?ZHlDQXM0REtieFcyT3MyWi8vOUFVN1hZaVhMUlRPVEFQQ1c2L2R5OTJTeWhx?=
 =?utf-8?B?eFhYS2xhbyt1Z1FrNXZ0d013emdhLzczbmIxZldpbGNDSDFXYlZwaEdIOTkz?=
 =?utf-8?B?UjdxNjBaQ0pLYTFtUUEwSjNGaXM2R1o4UkFVZlk5TjFiMHZMSm8vaWExeldj?=
 =?utf-8?B?V3hrK1ZYNlJKREx4ejNaODEzSTVwNHI0Wng5b1RmRGhWRXV2VDhGdU1TQmJL?=
 =?utf-8?B?TXNxRFJmcm9KK0Y5bmFpeWo1QzhWR3ZDOEc2RDdoR1dwUHp0aStQYUZSTHZj?=
 =?utf-8?B?THFjMG1XRXdLSXZ4OXF0UTlmVkhWQkY3cERSSUV4TGdGOE5aVkZSalBhQjAv?=
 =?utf-8?B?YjBLb0RCSU55TlFhcU85aWxnSG9POGVvN1dicklPa0hHSnRFMGtxeHFWRVg3?=
 =?utf-8?B?dnh3YUJRVDFQQVczazE1WjZVUmp6U0tIMmVDS0dXWnQzK0hPUlhUWjFNU2ZR?=
 =?utf-8?B?bVVoTjg1SjN6S1p2ZjhmclJXMWRWbEk5K2JJV21XU3BHbkdBUmNzbC9qalpD?=
 =?utf-8?B?V3NNdFE3Y0lnQVRSWDR1ZTljTGRWQkMyN1QrUGpvbGxRS2VSTVdLdHo1UTY2?=
 =?utf-8?B?SUg1YWpPSVBwWFJMKzZpZFdmTCtwTlUzTEZEUDBKTzliQS9ZQ1FFblNmMHZW?=
 =?utf-8?B?aHBTaGIvckJ6d20vMEJ1RDMyNnZmZmlYTUZNa2xYYVdnU0lMR093dnZpSlN1?=
 =?utf-8?B?SzczVEc3K1JMMVQ5M0JSWEw1bHhQSXFjVUxSZ1RSdnlyZmVhaFNnOEI3K3JJ?=
 =?utf-8?B?WmxwUVNkcVZta0ZrN1Z1UUNwMHBwemhJUU5SWXpjd0xVSVdiWnQwSFlzbnJE?=
 =?utf-8?B?ZVZHRnp6ekNURDE4R1JQeWljUXpuUG9Sa2ZEVGExZkFIZmdsbVY1UlBKMkJN?=
 =?utf-8?B?L1JBRUtPczJFSUZTYW1Mck9hdkl3akw1MDltTEZmTlk4Vlp0NCtJMFJzQmg0?=
 =?utf-8?B?WlI5QmJFYkdDTThocC9pYktyNVp2VlN6eG9nN1hHdTF6azUzWEFtbEIxYllx?=
 =?utf-8?B?eklHVElIUXFYdVRCcTFHSi9nbUxZbHR2UUVsS2VmbVpkdFFCL0pQZ3htZWdW?=
 =?utf-8?B?ek9zNVgwMHNBMVJJd0R5ZnJPVGVuUk9vZisxWnBxUENRMis3bjBSRDhvbHQ4?=
 =?utf-8?B?MXRKMnFScEh1U1VHZjZOcWlCcUlUQ2dtV1hWNkVrMkNrLzZBQXNJMFJON2ZG?=
 =?utf-8?B?OFQ5RzN3cUtHWlVzdVM1K0Nqc0NncDBvbVVteGQ4YTRrOXZxUXU5YUlpUkZO?=
 =?utf-8?B?S25ZRzllZDhIUk1wZlB5QTl3dTB4ckJmS0wyeitWbGVOWHRlN3Q0TzdqcFkr?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1992e87-23fb-47b6-39cb-08db9f37e94b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 15:37:49.1812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q03x3xP4sa850EPcvDp5zOdLGDEePNiUBZBZSyv4LTW1+s9ly3EpYDstfkkMvCMjGzWXNvbA/99swqTEE5RXbFmTgFqpNAlkh1nNpbm49yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8604
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 8/17/2023 7:20 AM, Moger, Babu wrote:

> Yea. We can go with it. How about adding a little note about directories?
> That might be easy to compare directory structure on a systems with these
> flags. Something like this.


Thank you for improving it.

> + *
> + * RESCTRL filesystem has two main components
> + *     a. info
> + *     b. base
> + *
> + * /sys/fs/resctrl/
> + *     |
> + *     --> info (Top level directory named "info". Contains files that
> + *     |         provide details on control and monitoring resources.)
> + *     |
> + *     --> base (Root directory associated with default resource group
> + *               as well as directories created by user for MON and CTRL
> + *               groups. Contains files to interact with MON and CTRL
> + *               groups.)
> + *
> + *     Note: resctrl does not use flags for directories. Directories are
> + *           created based on the resource type. Added directories below
> + *           for better understanding.

This is very helpful. How about a more specific "resctrl uses flags for
files, not for directories. Directories are ..."

> + *
> + *     info directory structure
> + *     ------------------------------------------------------------------
> + *     --> RFTYPE_INFO
> + *         directory: info

directory -> Directory ? (for all directory/directories instances)

> + *             --> RFTYPE_TOP (Files in top level of info directory)
> + *                 Files: last_cmd_status

(nitpick) Considering the directory vs directories, maybe this can be "File:"
until more files are added.

> + *
> + *             --> RFTYPE_MON (Files for all monitoring resources)
> + *                 directory: L3_MON

Should this not be below RFTYPE_RES_CACHE? 

> + *                     Files: mon_features, num_rmids



> + *
> + *                     --> RFTYPE_RES_CACHE (Files for cache monitoring
> resources)
> + *                         Files: max_threshold_occupancy,
> + *                                mbm_total_bytes_config,
> + *                                mbm_local_bytes_config
> + *
> + *             --> RFTYPE_CTRL (Files for all control resources)
> + *                 Files: num_closids

Maybe this should just be "File:" for now?

> + *
> + *                     --> RFTYPE_RES_CACHE (Files for cache control
> resources)
> + *                         directories: L2,L3

Please add a space after the comma.

> + *                               Files: bit_usage, cbm_mask, min_cbm_bits,
> + *                                      shareable_bits

The extra indent is not clear to me. Did you do it to represent
a hierarchy or just to line up the ":"?


> + *
> + *                     --> RFTYPE_RES_MB (Files for memory control resources)
> + *                         directories: MB,SMBA

Space after comma here also.

> + *                               Files: bandwidth_gran, delay_linear,
> + *                                      min_bandwidth, thread_throttle_mode
> + *
> + *     base directory structure
> + *     ------------------------------------------------------------------
> + *     --> RFTYPE_BASE (Files common for both MON and CTRL groups)
> + *         Files: cpus, cpus_list, tasks
> + *
> + *             --> RFTYPE_CTRL (Files only for CTRL group)
> + *                 Files: mode, schemata, size
> 
> 

Thank you very much. 

Reinette
