Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE917A5134
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjIRRqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjIRRqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:46:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D79106;
        Mon, 18 Sep 2023 10:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695059185; x=1726595185;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NDyj8oQ3/eflFygP7Y4S/8nAqC7b7rGjrAix/X4vfl0=;
  b=Njs4+93I7JE5wf/PUFUZkP0UdX9sxC5+0uXXoCzOMEBtn/tY8UBO9y+m
   NuGNT2IYGd88PIi80CFLt5MgdNszAMHTAJExsDMFevdu7n/s7XQHyiGtK
   /GFYOQytpsFQwDgFG5SyB0vJziODeFKZwZYS8mnHP8H6LVy7+ZHnRSvrO
   790rvhO3zOelMHdHyr6gGczRTb2spEhuDyXMq7vmEn2qWqqXgSMrbzmQC
   MHuMsngP1s8h/iXMz/mjfsZzPA4TqAp+0/xHR82DKLmxfr9eQsHxFpF4t
   cOaXsCYy4pRT5HXs1ZmCDhNs5IaCkq3e2WPOJZGKgoKz78Ra467XeNe7e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="378637073"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="378637073"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 10:45:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="1076672368"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="1076672368"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 10:45:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 10:45:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 10:45:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 10:45:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 10:45:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htvGq8FQ+xrvj+bJ5EX1l1VzOfLDK63g8QMNo/g8vk33OLrjW0iTx21VzkXhfwclEiV/0E9AiYBfNC9siDpt3hGmUii1+eE8BqnklEhjslfnI2Ic6e0XYZ9WgrTJyc3EFdQf1o/fEBZqSiMZC4pT/+tAC3rAcMFToLMttpB+xWn+lz08qV8PkLMV/rnymvfSGwAds8zcESirpO6xWItuOvPT93Kl8XP/xM4cxc3YnqKDqoJwIsWjV6QX8CrCHHGIzpz8G86D108h+v6GUXhhc4KATUofPnVKdWQ0lwlezcZyPDvRjCAKP37vxS2aSRnNg1XQDS6N4m6y7EBlR29/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krX//OI1A0mIwYZzZu87ZlJH+sV3hhY81v6CrJUBalw=;
 b=bG6sefLN2Grnceo8+SIH7V13ATujcZ3pud9caWI1aOWoknhuHWBwOubZh9h+Am9XhZBWunTJYn18slRakGw91vHHBPO1EX7iueOciKAxX/WExuQL/66rKSdWLgmwJZYBZRtJs2sUtjsI45IZXmqQr3S+ArcnQ51HkFQJIbaT1SLQBF+X2y1tTokZC/4wv4hKSJImdDyloBMTAKKNLcLWo7xZmrNKUvh71cDgmrU+8SjPuU2vNNsWbLTcKgqj8GbDoFGyrawAm6kQjihRB9sNkpN6wJ3/PQaiCo5pWviLWV80j5JzL/ItB5NeqHiBSPgEZ32pCFgqHB5S4bznGi4gow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by SA2PR11MB5067.namprd11.prod.outlook.com (2603:10b6:806:111::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 17:45:36 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54%7]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 17:45:36 +0000
Message-ID: <048e48bb-24da-f23d-50e0-477430d58bac@intel.com>
Date:   Mon, 18 Sep 2023 10:45:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 03/10] platform/x86/intel/ifs: Image loading for new
 generations
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com>
 <20230913183348.1349409-4-jithu.joseph@intel.com>
 <ba753b39-1819-35ff-1248-6ce2c2824ae9@linux.intel.com>
 <e084652a-91a0-0c16-7acb-d51a3d2f7ed5@intel.com>
 <10fe57c-c926-9de4-be84-21a0f8abab6d@linux.intel.com>
 <SJ1PR11MB6083A4237D928F180B6DB1E1FCFBA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <56b486ce-2a6e-c4c7-8bc5-ceeb7119ba1@linux.intel.com>
 <SJ1PR11MB608304A84A2B662C78FDB677FCFBA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <a02d2957-3ec4-f89c-ebe-474c3987b237@linux.intel.com>
 <826a2b32-bd6a-900a-19fa-e169fcf0d29d@intel.com>
 <789bc8e6-882a-3dfb-7381-fd9b5aca3c77@intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <789bc8e6-882a-3dfb-7381-fd9b5aca3c77@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:303:8e::13) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|SA2PR11MB5067:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d48eb9-b348-498e-0242-08dbb86f104e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVRP2Z5ROXVpOgImjCd3ivrG2Bj/j2yLbFcr+mhiV/SjcMoy/53DzzrC4JjtgjsF2UTGg5M182eEp8/lCcqNdgINHzPWdev63Y02JyOIOFshmgmImNkfBfeaSA4fgvPbYHj1rDjI62/gDWktABBHDUnFcZvI8WiQG6nqtZXw3BPFwDtbGyG8yE++RbDhDM15OAx58fp8vpPjCL48B6gHBq1HulZO8ROwaOxbXCdGx8SJ6ScZPZjacDsBLl8VYYmuX5gxCE6HFMIcnKJ6YCXJmtZGslhBO8hf7k5HB06/xHVKwL6fqLEkx3w9F5QWhkvgled+HsG/ZgvK1Nw/FhmeoxoU8uUKjrHuwl9jOqHFxv9lkUqdKsvvmfNAp904XsCZ9HLpU9IXFkypkOF1fqe3dlpccPiN3d34AtdY8raB3jiRlBIiWh6ADxDaMlyKMlwy+jf6KcaNf3JcXB3gB/UN8dG7sRat8uM9GArnttqOT0Z3G9tUnhXMAJ3+Q3zENb5MqDvNklNf+PT3QOAXR9GgHbsHt9n1EH1rLEM34BHa8wgVmjxl5msuslR8uR+wi8cIKtC9KNsXMZxP0Nd2VRzOXuIWEWO7908wQWaTx7tycHDEUHzP8/7EnZV6jL3XZHdc+20Swl55RY8NKJzMDWwe9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(366004)(39860400002)(1800799009)(451199024)(186009)(66946007)(66476007)(66556008)(54906003)(41300700001)(66574015)(6636002)(316002)(8936002)(4326008)(8676002)(53546011)(6486002)(6512007)(6506007)(478600001)(6666004)(83380400001)(110136005)(26005)(2616005)(7416002)(31696002)(86362001)(2906002)(82960400001)(5660300002)(38100700002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm1NU1dPbDIxSEtVcEtSQlVyMWJJb3FXWkZpWnlaNlphd2JxNjFNbFowUDZS?=
 =?utf-8?B?NVRvYW03R2lBVXJEdUV5Tk95aFRMcGNlUXF4TlVJaHVOTDA1bHI4aFEvRWJk?=
 =?utf-8?B?ZmFsaHh1eWUxWjZvdlpHWHdyS1dtU0tNS0E2eWhhMTU1K0YxVEtvcWxBV0N4?=
 =?utf-8?B?eXIvS293RG5PUVpuSmZYRlNNMlFmQnovTW5tRmFJVmM0TWRnbk5pU2dKanFj?=
 =?utf-8?B?dmNCbExJSjdvdXAwWGJpTzdib3ZINmpHUGFta241N1V2bGxSSENWTkVVZWo2?=
 =?utf-8?B?dFJ2K2FSUFA3NmxVN2I3VWltUzNmd0FQS1pxRTlxRnFCcWYxR0l5THYwWExC?=
 =?utf-8?B?R2t4UktobUxIVHZET2Y4ckw0bFFFV3Z6a3RLRlJPb1c5OVlKR0NVOU9xVUdi?=
 =?utf-8?B?aUNFdlVGSzRpclQ1cGRZVUtteHRHWFhtMEFudjQzT0o2MDU3S0VlRTFxUDJr?=
 =?utf-8?B?V2FHNkVSd3p3MjR2aTV5QXQ4YS9rdzcvQTh4R0JRME9LYWlpUEYzbCtIZk1V?=
 =?utf-8?B?bGhCRWRvTFpWWHBydjExSWlsdVlNYTNNZW0zY2l0aVlvOXNWSlF1Y3dvNlVx?=
 =?utf-8?B?cGJVdnJGbVlsVWxyU1dsVkx2cUlRaFVuVEQ0ekFqcHhoa0VNVXdTYnpRcWdj?=
 =?utf-8?B?di9uNm5oaGdIUjhSZmQ2MHROQ3FOTWhjbnBBOXVTeWV2aTh4Z2c1WGRHQys3?=
 =?utf-8?B?OUk4TUpybjRlb0kvb3ZGNk5ReHlLY1k1Kzh4NGtzL0htOUkwUmM2cEtEY202?=
 =?utf-8?B?ODBVQ3hqd0hYaFRUT1diU1Z0MldybGRyK3c1NmcvbG5PZFJxbVJ4ek05MHlE?=
 =?utf-8?B?bjBKMW03NDgyTTJOb0FoRjMwSG1pUHJXZTFyNEZsVy9IanVqMWJ1VXhqbG9S?=
 =?utf-8?B?aURQS0JMZGxtT2FYRWpUcnpNdWtmMFNJMFp3d2h5ZElOaWdPVzBXMjNTZkhG?=
 =?utf-8?B?anFKZXZ1YU5aN3RQSmRFdWw5NG5JUHV2ZVhPTXh3TnlSWEpyRlpKUjNLVnMz?=
 =?utf-8?B?Slo1K3l6aXQrZWhlYnpQR2ZleFZhOVhneUNpQjhCZjBGUEJwSnljbTFXWmJt?=
 =?utf-8?B?YXBURVEvSXNnU1NHZ0Y5U3ZwUy8rWC9mVDd0cHQwcFBGTXBtcVBmNm5TenN5?=
 =?utf-8?B?Wlh4SU9hK095K2J4K1Zpem9aQ0t5bUQ3TEp4b01DYnUzR3dpRTlLTDhVZ0wr?=
 =?utf-8?B?V0thVXcrcmpXOUdrYlR1bDVkM25YaWhCdy9ucm5lV3VNL0hwMkZHd0FmeCs3?=
 =?utf-8?B?ZktQd2gzb0dBUlZwbmZHU2ZIMXVhNHZkQ2RJVkJ5K09SYll6bU03SHp6L0V3?=
 =?utf-8?B?djc0ZFdBaklUT0tJQzlhQ3FCYmwrQjZ3eER2Rk1qQmk2bVhsazQ1dWdzOXZv?=
 =?utf-8?B?TVVkanVVaCtWUkRMQUV1MDRpOXYzdFh2QVY5MGU5RUhFRUErRksxekVoTFlp?=
 =?utf-8?B?ZFY1YmYzcUR5eGV6UlFkNldaazZzKzZOOTV6dGxBVVNTTHA2S014U0ltQVNa?=
 =?utf-8?B?cXl1RGY4ZFQxeVh2SkJKZkJMZU9EL1FDWG9ZK2pEdVdwQ0xLMHJvdnZYenJm?=
 =?utf-8?B?TEpNTm0xdFFjM2lyZ2RYdnhRcWhDOHE5cXB1eUpoL0Y2N2Z4MUM0ZHJtT1hI?=
 =?utf-8?B?RTFXUHk1STJyUmc4OVIwOFhqK3N4NUtUSkJKTGplV25iazBkTFd2ZG52Q2d3?=
 =?utf-8?B?NTI0TFBJdzR0K0hGeG5uaWhycUVkVGwzVTZ5a2lQRTB6Q3hvcU82L3BBWWpK?=
 =?utf-8?B?VnVrZFZzVUZrU3BScGJMTnpkRGZiUlVZbWFqSGxVdnhBNUEwT0pOaGZQU3NB?=
 =?utf-8?B?QlVoMUl6dnA4R3gyWllIaklVaGQwSElnMGw4NkxETytiU1QxQ3czYmhrSXhw?=
 =?utf-8?B?K2kvOUJkWVEzaFhDQW9nMk9Sa1lkRXhnOTArT2VCb1kxVjJ4aXhHTkorSWZM?=
 =?utf-8?B?cVhtQkN5UFVqUzdtVzNPdXJkYkVwUTdkRkMxTTEzb0lvMU1oaEY3WTFSYU9F?=
 =?utf-8?B?bHZnNXd5ZC91Mjc5Y254dmV1NDUzNEVmWVR6U2s3NnVYc0dWTW1LNC8wTE9Q?=
 =?utf-8?B?cml2ODlBS2pKeWdMR0Noa3E1N3A1MThISzc1Y29zTGRxZ1VrWXIrWFRROGhW?=
 =?utf-8?B?M1VNWnpkblVUSXc2RE5vS2VhMzRlN2Y5dE9EaXpDY3B0N0t6dW1OVFJkdkRR?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d48eb9-b348-498e-0242-08dbb86f104e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 17:45:35.9413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfMe07Yvu4He0WmjxFGWfNSgwUiMA8h3MAEYHJS9J2j3eV1gvQL8WzNvwfqyhwX4vH+6Lse65k4brKIdtAzz/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5067
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



On 9/18/2023 9:58 AM, Dave Hansen wrote:
> On 9/18/23 09:51, Joseph, Jithu wrote:
>>
>> On 9/18/2023 9:29 AM, Ilpo Järvinen wrote:
>>
>>> In this case it is not just about the bitfield itself nor the bit 
>>> allocation order but sharing the storage unit with another member, and to 
>>> further complicate things, members have different alignment requirement 
>>> too (32-bit aligned u8 followed by u32 bitfield).
>>>
>> I too verified that the size of the whole structure matches that of MSR  64 bits (8 bytes). 
>>
>> Initially when IFS scan was added the  all MSR structure members were  bit-fields, later there was a suggestion to
>> use basic C types if applicable during subsequent Array BIST patch series. I followed this approach with the  current patch series . 
>>
>> I will change the current series to use all bit-field MSR structures in v2, given mixing basic types and bitfields is a a source of confusion
> 
> That's the wrong direction. :)
> 
> What is more obviously correct.  This:
> 
> 	struct {
> 		u16	valid_chunks;
> 		u16	total_chunks;
> 		u8	error_code;
> 		u8	rsvd1;
> 		u8	rsvd2;
> 		u8	rsvd3;
> 	};
> 
> or this:
> 
> 	struct {
> 		u16	valid_chunks;
> 		u16	total_chunks;
> 		u32	error_code	:8;
> 		u32	rsvd		:24;
> 	};

I will go with the second pattern above, given that pattern can be followed for other MSR structures too, where fields doesn't split as evenly

Jithu
