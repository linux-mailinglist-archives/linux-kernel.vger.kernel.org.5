Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E6D7C0055
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjJJPYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjJJPY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:24:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A7197
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696951467; x=1728487467;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Co/RSUJvcWqMjjb1K/xZOSF6PS3074D3dH3jqGt6h5U=;
  b=g3Ev2pfX1qAF2nheXn6qao045wjXR9zFJKfVvRPt95iecmYuXN2PQAPm
   8lqGyLqGdFmfKypcvcofhamK9neEyAPRXaNPpGnqJM87qbrLTcI5hLxUa
   Z1E1HIFhLdwcyrvXGlTCueGXsAhpZZvsf5W5/SlrAeeFKjkAYPELCRZJm
   VfGeai9A8NZDZUs4XuG3JRCA5oEii64FsDCfs99m2uf2gSy5VrNjgU6Gh
   KZEfnQ4f47Qkkaa2USaHMtbGoB4LW0pAgCt7k0Sk4w2DhYfsH9u5ERkLV
   i5F1LhPiJgExpnxsZU4NcI3zO0RsEu3s2GC3QDeaCVGFkg62bkiPLg499
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="383297915"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="383297915"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 08:24:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="788619509"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="788619509"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 08:24:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 08:24:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 08:24:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 08:24:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCouk/6SPP4K4K+lNbin39IYaINg1H9CNmuHU3SBMLbRr6XBFawBzc3q1OEHXVoc9jbFJys1ddFQ/7RcmWwSaZYLgVKDzTC9D4Zs5gVubtvBVM9nfMhXMOkcXzRu7K0qQAk0UM0QaSVae3gno4zpBZFWMyJni4phExNRiYJUosoDJmtXJIE8ZWLX+NxuVgQeUu963PASpS+mYtUp4Sq02UIW+Vv8125MpfRVkK7OZi+u5Bfza2yEWoNonCHtoRQc/ahutZaNCEkPMVPBkiZeZqy/chMV49M5QBjO/BS4+/QP3Rlb3UQxXZyU6yH/XKRH/7kKsDMyvwjasOhAAIAhdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EF934kEjAFXjfn1WZesP7mzOFJu5zQU8toV/z6nG6wI=;
 b=RBMVeVtJGg2PoEuyjTDNDxpsPYdTOEnhQMdSmpRAD0xrab8yRwBVjGOtcGiel/gSh7GxsPPIijLrp0qGmF5m4CCtMYAN8cR/5hQaSk5j8QtCdE4RRw8Dc4217CeQeRD0T4bYK6h4uw+pQm1DhXt88dJ+QLG2kaFmUOyamABxql6l9z6H2dsruAeDMABwvHjvgzJGU+RD72wNNRL86jBZiXPzemDeGoJNl79YHLjXXlTpp7A7n1cSZfSii71J5TdmagKRWT0Ne6OjZzbfMu7UrFlq5AVILcuTvRpQXsNtKdO7DxOz6SugqvWZm9vDe2O3/4/ir4hLtle1/lnzVnPEpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5463.namprd11.prod.outlook.com (2603:10b6:208:315::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 15:24:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 15:24:21 +0000
Message-ID: <2d329efd-f0ef-47a0-9437-e668c38d3137@intel.com>
Date:   Tue, 10 Oct 2023 08:24:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/intel_rdt/cqm: fix kernel-doc warnings
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     kernel test robot <lkp@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>
References: <20231006235132.16227-1-rdunlap@infradead.org>
 <5589e93d-9a9c-4199-a187-ab60fb127236@intel.com>
 <c43b1da4-b377-4dcb-93cb-ca14137a93ae@infradead.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c43b1da4-b377-4dcb-93cb-ca14137a93ae@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0280.namprd04.prod.outlook.com
 (2603:10b6:303:89::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: 661016f6-56f0-4682-05d9-08dbc9a4f9f9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QS/ac6mmLD7ckpQ/DF29E5wr3emXgOXNs8Etjv161fEajHyGjQk5OH3pYa/FcHSKm3xjLzy9MhHaEJRU6kRVevgW2pM46nfhhOi5sV6YuGNhWABxH3FukIk4ULotmFgqDSqrPjDP8PufzizkcscIVjVWqXVAbqhr+3WZVUjITXS1kc0g/m+BVAnWwkS7kbQBbRXWT3jA8XHP5ZQzB54xOxmsWbi8KHpJgG8WIWPsgtzfHg6FaK1nn5L0twBoeW3kNpy8z4CyH3SENnQCoyoYazpECJ9irflaFBwbUVhYlDgDdwm91+wxWAg5RAPw1Jjto+lzdf8H2moaYAZwdhyjPv1O3VNCfBxFVUXtnW5odoE5dURocuSckPa9fFdL8j6Xu8eTvqyNLLzLodtOJ6rkTj/XixMmyGwSASpbOLrCxcs3kPLsTheduWu+y3Rn+Jff9WjU17mUf/JE/vBBZJttQQaqjEFQkqA0wLXpWOeAef1KWnZEduCeFUcIpGv929aabUUpHFUHCyR8+AvR+QlEMvDQMyL9uVBCUwPy7Z5+ML1RXtF6qZMT4ac2huaOwFZDXAEROeLVacz80q7e21bE77hIBKYIkXoFVXLLnbcYjmD5xa0C8OJUn4b2pGz1/QMzITTyMlKpXJhv1PLNG+bVFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(5660300002)(2616005)(83380400001)(26005)(54906003)(66476007)(316002)(66556008)(66946007)(4326008)(53546011)(6666004)(966005)(2906002)(6512007)(44832011)(6486002)(478600001)(41300700001)(8676002)(8936002)(36756003)(82960400001)(86362001)(31696002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVVNSEVETkJZVSswTHZ0ckZPU01WYmVmckNPanBIOVB0eWpvSzlvbzdrSEU2?=
 =?utf-8?B?QWtTcGtrTDFrZXE0ZnNoWGdONGMyYTd3L0puZS8wU240cmo2R0R0TFdrZHJZ?=
 =?utf-8?B?Lys4QmREOVJxb2w4Qys4RklUbHhITU5kQkdHNFZUUEVGRUJWYUtVOFEraTdu?=
 =?utf-8?B?TnVld3JaNjBoZ3crTDlvbllkVWJ5WWJMZzBYTFF6RktsZG90OHY5QkJnWk1s?=
 =?utf-8?B?UXR1cng1ayt1QTVWUU5aTGtyWm9nbzdaaGhSL2RBSGdSSjhtZ2ZYdGUvY0Jy?=
 =?utf-8?B?OFlyaEppV1B3djRXMzIzem9xMGtmNGFVS3dHcWFqVlQ5bUxJU1Y4c2doaHFN?=
 =?utf-8?B?ZTZWMG5valEyM2xWYWhOYjh1Nk1VUy9JTU5lcXNYL3VyVW9LRGlFeEpQQjJ5?=
 =?utf-8?B?cWs3NGdIZ3kxNEJZdVY0eDdXeGsyazBGS0dncklWb1hDL2pGU21IOC9UZlh2?=
 =?utf-8?B?QUkzZThxK2V5NjdMd0FDd1NrRkdHN0pZamY4dElXekVUTC93cDdvaXVUTlYx?=
 =?utf-8?B?bmFXWE9EZlFRL1FMN3VKSWs2VlhmVHNCdlZJV002SW52M2ovWFc3S2FITDRj?=
 =?utf-8?B?Y0dCV1grSVU5amFMTEp4bWRLVElyMU1ROTNTMHFuS2g3MkVkM2cxNlFGdmJq?=
 =?utf-8?B?RHRBZHlqUWlKMWJqOEJEM2xwMDJsYmE4ZEhaWFVCeklETEpuNmlCWE1qenFa?=
 =?utf-8?B?RGFNRVMxa0ZOalV2RWt0R280eWk1cWZJYVQzQXN6c1dGbUlKZk1aNUU5UG82?=
 =?utf-8?B?c0toL2VFcEw0R0ltZTMzRkFrL0p6cVZZRWpzL0diUEE5cWJ6TDE3RHV4NktU?=
 =?utf-8?B?cmRxaFYxdmdJTU8zSWx3YWZJZjlPK0FJL0xJUVJORlBFb1hoOU16S2FjeWJw?=
 =?utf-8?B?QXNCZ3p2Z2NtenJ0Tk82N1VxMU0zQXhXV25vSlJSUFBnTStQeFRXTTYwYjZu?=
 =?utf-8?B?ak9sazJkODk0YnNEN3l2RlUxeDdwVGxhYXp4T2hTeEhKaFVKaWlOYkZzOHpP?=
 =?utf-8?B?SDNTOFhFbFgrRzVTb3AwQ3JGUlBQbnFRbFlLSHlCMzNoRlFOOS9ibUVHNnZi?=
 =?utf-8?B?dU1IaGJxK21HcnByVEJpbk9GaGhwaTNPL2RhcktEWklRUkFSTndiR0toOFYy?=
 =?utf-8?B?eE5wWHEwbENHREFpWlZ2c2VqWXBNdmcrQmZPeUM0Sk53YkFSV2xxMEdlWkp6?=
 =?utf-8?B?NVgwbTE5N3U5ZWp0RU1tbXM5YnRMYk9WMFZYd1Rac21GUTZmbndjVG5pOUYw?=
 =?utf-8?B?QkppN3QrcW45WFN2SElqS2s3TWlJTDhxTVVZRnBZL0EwRVAvRGVRUnM1cG5u?=
 =?utf-8?B?TGcya2E5REl4WnY2enZpbzFMMmZGWWNwc3VNMi95NlF1cUI3Y1RGZ1d3YUpQ?=
 =?utf-8?B?N2RMNmFKMTZVR3dhR2pMN3FJWkU2NlViK3pNeE1kSkpBSVNITGlPa3VldkJl?=
 =?utf-8?B?cEkrQXJXai9ueE9EUHVDbXEweFBnSyt0T0hvczdwMElScDJUeVIzdTA1SkFz?=
 =?utf-8?B?bWxINE9yaHJIMlJOTXBSV1ZSd21PWHRQZkpjUlZkRHFUa3hRTFFQL09GbWdR?=
 =?utf-8?B?WDZMaU1SdVdTNXJsek1FbFkzbHFPTHpQK3FyS2RvWDhOWTlNYlVpOVJ1OUls?=
 =?utf-8?B?MVpkSzE4ZGFpKy9zd2tGVkQ5TmljYWNqcE1NOUJ6dkUrM2VDelNsQzVTV3B1?=
 =?utf-8?B?NkVEZXFjTUltSitWYkF2TDRGMjhFOUJZMTllcThnVU9IdkRCb1BOUlhwazFR?=
 =?utf-8?B?Z1Q2VGIxRTg4S25BWWFXNllIL0hoRFJoUExNcHM2a2ovREhhcUEyTWhFZU5S?=
 =?utf-8?B?akd1eFI2UkpwQ3B0Z2p6OUpQRjNCcnczZVhmVG5zVWJoTDRGd3M0bjJ4dFVP?=
 =?utf-8?B?V1RndHNIaXErTGJ0RWtvNWhZUzFxU01iRWtRc1pHdDlKTlBCakdYcko3VUNT?=
 =?utf-8?B?UnpJTkFteTNUN2c5WTRhSUlPeEhVUndMMXVkVXlFQXRZZXpiM050ZnRlMjZy?=
 =?utf-8?B?K0VKbitkcktvMUluVWRTQVNhS2dBOXk5K1ZEb3g2VlcySUlRV1FiTURrVGtu?=
 =?utf-8?B?b29YRnV1TmJ5dmo5NWd2WHhFTVAzcnQvcUwvcGFxN1JUTE83eWJiZFcwbjI4?=
 =?utf-8?B?UmtMTTZjY083QTNTS3dBaWpsT1Z2c3I5bWJKKzBLYXo3NTRZU01hblVIdDJn?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 661016f6-56f0-4682-05d9-08dbc9a4f9f9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 15:24:21.0300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4vudtL5n35+cO8cRN6Kkbhd6IYE55+92GlWpe4yeocnhdwiBwivRnKD2ovlH4CLvWT8M93oCSSk254f4Pd3SHFJJpU0W8NjToQrFQhqeLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5463
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy and Ingo,

On 10/10/2023 8:17 AM, Randy Dunlap wrote:
> 
> 
> On 10/9/23 10:07, Reinette Chatre wrote:
>> Hi Randy,
>>
>> Thank you very much for noticing the bug report and taking the time
>> to fix it.
>>
>> To match the custom of this area, could you please modify
>> the subject to be:
>> 	x86/resctrl: Fix kernel-doc warnings
>>
>> On 10/6/2023 4:51 PM, Randy Dunlap wrote:
>>> The kernel test robot reported kernel-doc warnings here:
>>>
>>> monitor.c:34: warning: Cannot understand  * @rmid_free_lru    A least recently used list of free RMIDs
>>>  on line 34 - I thought it was a doc line
>>> monitor.c:41: warning: Cannot understand  * @rmid_limbo_count     count of currently unused but (potentially)
>>>  on line 41 - I thought it was a doc line
>>> monitor.c:50: warning: Cannot understand  * @rmid_entry - The entry in the limbo and free lists.
>>>  on line 50 - I thought it was a doc line
>>>
>>> We don't have a syntax for documenting individual data items via
>>> kernel-doc, so remove the "/**" kernel-doc markers and add a hyphen
>>> for consistency.
>>>
>>> Fixes: 6a445edce657 ("x86/intel_rdt/cqm: Add RDT monitoring initialization")
>>> Fixes: 24247aeeabe9 ("x86/intel_rdt/cqm: Improve limbo list processing")
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> Could you please swap the above two tags to follow the tag ordering
>> custom followed by the tip maintainers? For reference you can find the
>> details in section "Ordering of commit tags" of 
>> Documentation/process/maintainer-tip.rst
>>
>> Also, below the "Link:" follows the "Cc:".
>>
>>> Link: https://lore.kernel.org/all/202310062356.lX3xpLP9-lkp@intel.com/
>>> Cc: Vikas Shivappa <vikas.shivappa@linux.intel.com>
>>> Cc: Tony Luck <tony.luck@intel.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Fenghua Yu <fenghua.yu@intel.com>
>>> Cc: Reinette Chatre <reinette.chatre@intel.com>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Borislav Petkov <bp@alien8.de>
>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>> Cc: x86@kernel.org
>>> ---
>>> Not using Closes: since this patch only addresses some of the issues
>>>   reported.
> 
> Hi Ingo,
> 
> Since you have already committed this patch, how would you like to handle
> these requested changes?
> 

All my comments were related to my understanding of x86 customs with the goal
to make it acceptable to x86 maintainers. The change itself is good. If this
patch has already been merged by x86 maintainers then I surely will not object.

Reinette
