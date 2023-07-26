Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85408764288
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 01:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjGZX2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 19:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGZX2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 19:28:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1B219BA;
        Wed, 26 Jul 2023 16:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690414084; x=1721950084;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ewi26uRljnF2po7aYXdfLfi2NAOPfdx7Uj2NXLHCIpA=;
  b=aEOysniDoVln45Dj4yDr2bXrA1YEs7wn7oI64wVyWuIdcYXcJjS3gZXw
   wNvMLnlLr3SYkONJt+MdV4dNi+221LhjSWDO7MoaO1ihX3/urTBpLBvnA
   uMT278lW0T3F6ICaEMTrmamTfYlp2rJRmFYJL58aSK2xq/IzGbH7KzvHI
   Wbeue4jKGaDFKu5Hx16adLv9W68A+ne+AYUhkgY54W3i3bxlCQlUv7kvT
   O9Pll54JFrtNFS4aSgOhe6wAMe2w3X8DttlKwXHMCIRGmCjuL1LlMEI0c
   X+tW/G5XkO623g95CwSmjw21QGl+668vL1jhNj6El7P2uVO3Y+oNd6Gus
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="353057350"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="353057350"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 16:28:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="720674072"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="720674072"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 26 Jul 2023 16:28:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 16:28:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 16:28:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 16:28:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8TkSZES/kE5SzwI/6B1dhs0vBEZuPZt1mGMiLixMgnCkVHEJGKlot0zVME8JebUtH/B3yNxjKYOcxvkJdaQMvhiXvTmdUfU9CPRiRKT3WPKV0cyC4qe+yXs8vlPKdLhFf8ushhEN62uKq8Wy3ow58/UahahigHH/uN8SLOaxT3N1jh1s1O479zKtSN7dYLXiZmprxPfMMnBzDqAHa3HjXA8ef3YhZYWp8vqqOtgFdeaoguc/n3yCD0cfdPMyPKKgYu7jNFaOXkR/j8HbNxrnf2UgjEEO5l+yEYZ5BANyOCG/gvdkiIORWawuAv+rEX8bOhnOrAmzEDGQHeW4Ayx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1t1jxLq0tSvv9GTHa4zXUXFUlYsibFua3lU/cnt7wLM=;
 b=lmH2iW7RSoD1vhGTWTH3SfcwhS6AsHtDI3gdBAw0hI14Kh/PEoLAoMBqu9iJ8X7c3qBcvqhQ9nwG4tYFBYF6o1xBFSkLOzLbjn7/e/uuytnlJyB6AMJmPSfUlLGj3eIEfMm9sgfwA9vbRLLshUtmZ8dt3Eyr1rp5UwuTiaYRUKsa1a4cfOzR+nkSiP8jL8zlpButtT71d1+oZMbulT+Y+Tc8bgDeD5OUJnEjwvStcwA7NfcRtt11jzCpnsZNTyqwmSyo5eLCB7qSu2mqfk5Uiko5EsSbDUn0BOeGpQsVb+4j7LGUXhmYofyrcKBHoQ2xTfigQT8k5KRmztn7woPN9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH0PR11MB5062.namprd11.prod.outlook.com (2603:10b6:510:3e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 23:27:49 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2%2]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 23:27:49 +0000
Message-ID: <08f1bbda-7d41-9b1b-c345-54f4c62ff976@intel.com>
Date:   Wed, 26 Jul 2023 16:27:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch 00/29] x86/cpu: Rework the topology evaluation
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
References: <20230724155329.474037902@linutronix.de>
 <545cff6e-09ad-afc3-5d5f-bf5a435885b9@intel.com> <87mszis3hd.ffs@tglx>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <87mszis3hd.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:a03:333::13) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH0PR11MB5062:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb9667f-4a72-47c3-969b-08db8e2fed01
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g6EGEUwqgou0CMfbmxB9CjWOKBcWAEaB/2qT1XwLPHC4JDgA81Qk8nz1j9ONZkd5qLaD9YG9cirugWPAlCfCuw20Q3ae2ROcofR1QfpWzVZZmeKao2MY35EOPPQXsAJTSGDVxItOpIZwF0FEnLMpcvYmtk03lw0z+jxJT/nLHUEPCgda66sOlfnxAEmQNYhcrVwLY6ctS3WEj4Tjgiod8noHR9ogEiUQWeC75SH6+Cv93sh73g9aL/LrZpNOoQma8+EVm8BfsWJLmOOKWesCjnbrNvDV3/AwrJ4hYnLos2/e1GIlbHXBSuoRih3uA/O68gjiDhpzIpU1RQnbbJ5MGL0xZrZ6YotbWNEefQY9zLjZXlVf7kbmgn2Visv1K1xAeAFOSUUG8LQjvbm2C5YkNBlBRRu4teHwBjGWHFkM/czIIHNMeXlExyYPUoqQnDmeUY30/8Dm2JMpL8mVI1Cs+R3cvJJrF3Tb/BrecTdUV42LD+fwZkCyU1AvJPMaZsME4+425LRiCXfNge91uFDdKo8/PfRekSePBH5AhuBRYQ3s9bH6rziKmXsw9/F6LiWqg4x+vXFVpllAcBjl51cf9XJ1rulnZCTtUjNbdCB3GOgCpqjucjcoJeODXzB+zHu0uhF96ddbcUt4xH+S+xH6PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199021)(2906002)(4744005)(6506007)(186003)(26005)(4326008)(38100700002)(2616005)(316002)(53546011)(41300700001)(83380400001)(66556008)(5660300002)(44832011)(66946007)(66476007)(86362001)(8676002)(8936002)(36756003)(7416002)(31696002)(82960400001)(110136005)(54906003)(478600001)(6512007)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTRYU0xaWnh1ZytVYkMzeDh6OG9xV2pnRnJ1K0d5SGcxdERrcG41b2Y4a1Mv?=
 =?utf-8?B?WWRTMC9Gc3ZzOUNsVy94VTZTeDVQOW82OUcrTFA2eEdiWEI3RUNMdnYzS0NX?=
 =?utf-8?B?NW0xR2t6QjRiQTh5RGpzWVFUU3ZHOFZPOHVvT3FBR1UxRmViZVVxRnB2WndB?=
 =?utf-8?B?UVhPUFNaRFd3WE5XS2swcnNabXMwNTA5bnNVSmh5YjJGc2QvS1UrNGlrU2VU?=
 =?utf-8?B?eGtDN0QrRk9qZE1yVzNMOG02VTZnaTVVMmhSekNHQzhIanE4Ri9PMjRRWjZz?=
 =?utf-8?B?VjVNOEtZa0NaaXJWWlZaMWd3YzlaMCtxbVlrZVZFM1dOejdaY0J4NlFKRlh2?=
 =?utf-8?B?N3EwWUZWWVI4WkZRb05rNGRVcmdhVjd0K1ZiV1ExVzFlOUEvYnY5ZlB6eDZj?=
 =?utf-8?B?K3MxeDh4UDh0ZGpDKzAwU0pTaWF4Ukx2V2Nra3RVMjM1bU1LcFVXVFd2b3lN?=
 =?utf-8?B?TjNqaldTdkFLdEduQ0k3Z2VUNWs3b3BBcUF4d0RUaS9ZTThZanJVZVVzWk92?=
 =?utf-8?B?VXNTY3VwVE1RMEVndXBydWNEQ2xuVVl2UmJJZG53YkZHbFhBZjJDalhQVk50?=
 =?utf-8?B?QUtqazdpVHFjSEp5aWRhdGQxUzZpZjBpK1V2c0YrdnhHdFRPblVtV3VsZ1Iz?=
 =?utf-8?B?dFN3Mzc5ZDhpdEtJUGNLZCtHNVlEeE05SGxDcEpHN3lTVVJnTitrdTJMOXRt?=
 =?utf-8?B?TFJXTzI5R2pIY1RiK1F5S2k3MUpMVGZpMEVRV3hob1JyUGxkK1lFSEJjU3pD?=
 =?utf-8?B?UGx6NGRWOEZpcDhtSEpZZWhjSVJZdWVzd01QcHRVTXo4UnFOMHFqWGV0T1Y4?=
 =?utf-8?B?VXFyd2FxdGJvL25vK1I2OVlTY3hIbzBCZlB1R2tVT2hnZk1ML2xwYnQ2Q0pQ?=
 =?utf-8?B?RFEzWTk5b1BpeDFPZ1E2WXFmREtFb0N5U2JNaUl6MGQ5alZ2WGdkQVVSd0lv?=
 =?utf-8?B?dG9zemhYMFlpV0FnZldobWpocldQT1FOQW5iVG11YVZWOFZ1aVNsMzE3TXdX?=
 =?utf-8?B?Y2s0Q0F1OUxRNzJlVTRVeWpSODN4c2dac285bys4VVBvR242emdLWVVXcEJj?=
 =?utf-8?B?bWJMNHczMzVpK2Q5bVlNR3haTmhLb2lkNTZuNVl2bzhEL3JwRzZyR29OTEp6?=
 =?utf-8?B?b2o1Zk1mVURZSlJqSHpneTRYOXp2dENKYVd1VmRkYlZmTGJPa0FjRmtBZlhl?=
 =?utf-8?B?cDhXbCtRSkdiNzNORFVQR0VpQTQwNWVyTmFTdUFPejRweEd2aDBTWHZzKzNS?=
 =?utf-8?B?ZnQydkNkL3laSFB4NDJQb3JqSllhRmlpeHB2bjVhTUQwUkE5akFoSW5JcTN5?=
 =?utf-8?B?OStjRGNYNHRPYS9OeEVRRW5MdVJTa3R5ME1qQ3hJbGp2OWVQd2NnTnFqYS83?=
 =?utf-8?B?QXgyM2FYSU5MU0JScW8yN3diU1dyMTFsSW1kL3RvL0lBQ0d4Z2d5NERleUF1?=
 =?utf-8?B?ZnU2ZHZOSTNGaHpLU2s2MmF2STNGeW4rRnppNHpiZ2dwK1VXQkJUSmRxUXVo?=
 =?utf-8?B?MnVHQnhCSnlSZGprOGtSeVBRelZFME8zY05NQUxyWGNGcmRwL3cwSWw2bkpH?=
 =?utf-8?B?WERCUFZJZ2pkVThBMnAwelJBOGFNckVSWmFaazBZQXNmM1IzMVRRUGxUL3Rn?=
 =?utf-8?B?ekF3eDNsUnFOTW8rVkxuVnFYK21uaStTbnRPRzRnM1JJWjlWVGtxQmFVL01Y?=
 =?utf-8?B?cTdpc3lLUjI3cmtFQkkxYm9GcHVWY2wxcGd6dWpacm5ReUY5SWJiN1cyRzBs?=
 =?utf-8?B?WDlUVHQrelU1Z2ZOTFVFYk5RNFZBcnhtcUIrMUlDSC9UQTE1ZDRia1RYQzJG?=
 =?utf-8?B?VGp4NkpVT0dkYXc0eURHT0hxZE5LdlVvbkhQRWQwNWtEck4xR29XZWFQUFBT?=
 =?utf-8?B?alBFTHM0K0hVVVIycFZ3cWVWQWpqcEd4M3B4dVpPLzVQalcydms1TVBSVWtJ?=
 =?utf-8?B?YVppald3ZklLVE1jenhSVG1HYjFzL1JKdFJQclNZZjZWMTV6RWdFSGVML1Zh?=
 =?utf-8?B?NmUyeVVVUHZuUnRCd2dMYks2MUxFUGJqc0ZMY3BpOTE4VVNmZVNLTDJOeE5N?=
 =?utf-8?B?TjlOVm5ycmxhbXJncHRkaTNqN2p1SHhBTGlJNDlRVFNZYWdZRkUwcC9vekU4?=
 =?utf-8?Q?Zzs8QKZL2BPoMtm6fSlxcG+f2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb9667f-4a72-47c3-969b-08db8e2fed01
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 23:27:49.5243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0pADvGoX3kvTpuTKgCjL8T3khPTYctE5PM8CTnVWbAueXTaiuHrJYVVUINFwfqiQPKUXZysvZxGx2MMiq5BDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5062
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/2023 3:38 PM, Thomas Gleixner wrote:
> There is a real and unrelated snafu vs. that logical package and logical
> die management which I discovered today. I missed the fact that this
> cruft abuses cpuinfo as permanent storage, which breaks CPU
> offline/online as the online operation reinitializes the topology
> information.
> 
> I pushed out a fixed version to
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/topology
> 
> earlier. It doesn't have a tag yet.
> 

Thanks, I'll try this out and experiment with CPU hotplug as well.

-Sohil

