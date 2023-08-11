Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5997784C3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 03:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjHKBHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 21:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjHKBHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:07:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95E2270F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 18:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691716038; x=1723252038;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pDxP1UTQgERgIZbX3GrJOKuLY75qxgMcOLbr/A7tJtk=;
  b=lIzNvpjKtp5XDSQFbwhAYknSYWWsq1q8OFr51UETMkrGtyKFWaIIv3Rc
   iBD/fu9dAJJLA6D+tDvzwl8c4m1YAHaCeHLQR1GFAnnyyVS9BvFLnUHXX
   NSGuIgWENXW2y+/IIUh0IcPmqs4ZQXfUbuPo53Ifp5PBeoyB0nGKI6e1f
   lusuapZkLRtXCPgiIj594rzbtaDm53yX5hbxUXJGUd+SXVo5d81WMHYu5
   hli1c19m2tR7E3NEO2Fx1u9ulKI/W9OGc8rqGGU4MeqYbEdTeOPkioLcf
   616n6sIJNro1ogw3E8AIpSm2VBCiKsOlLA2dyggVvZQzhRtB+KIYefMcW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="361702720"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="361702720"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 18:07:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="822481256"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="822481256"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Aug 2023 18:07:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 18:07:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 18:07:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 18:07:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R05blDJPkf7bdQraaZib/LMXTCVulrx1xgtbl4i4sgCPVMBmMMZijHpHxefSkdVgxy/E3aTTjnRsFwlLdxrMJ4G3XEs0MQViDKn40FkEDggXEqDEW7yKtqBKrk4m3VJUBKEgFdnC8XLy55bX7LRj6SyYwHyexq4u9aJd2GQ9jyjgUbA7Uibgz/67zKa26f4iGOnK8bskSsOIjZPY/PLf+vE4QK9J39yayWxhrvM9gdt/d2Bufr24So/U8vwMPJWyobUy0UFCHpnRxLDOELPzfyPKxFJXG5LovCmowfe0qPdmzmdVJmAsNMBjDacRLlw06h32Igb4qPUISPAmeUMdcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5VvtpbrqFjwL4ixM5MjerVQJ+SRJOpdXEYKXXrwgvs=;
 b=RehMJ1d+aLk85J8TvhXy9nUSJ/SqEwJFZ/U7A24xD+it1J/ozfeifRmkIgkD1DmUN18/glmv4jVOdwS4LSfWMt9ERbJP6SaKk50mG887S9zZzfuVlsNnQFZKoZ6mm1SHxLuwl27AkiVop2ZzEJlDDorHJ2+MNL7k5MTKGgkvo8nZYbNeuIXM0vUA4vPca0ge2Qi0XDHk0FHSUUvGhnlBqWF/ljtCjeDI8+7G+lE8ib8kaecxrrzXyYfqtdhKWrnnjhqRwC9ZtFBc6/J+wtH6rFzEO8dS/5XVppJckqRNADoEabA74TImcO+sEZ5HIjCHhhHmX+BPcJHm0QDPn0s0pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by PH7PR11MB6032.namprd11.prod.outlook.com (2603:10b6:510:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 01:07:10 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 01:07:10 +0000
Message-ID: <8c65b1d1-d3b2-728f-fa27-f69dd04256cf@intel.com>
Date:   Fri, 11 Aug 2023 09:07:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 0/5] Share sva domains with all devices bound to a mm
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <BN9PR11MB527638E7361714F8AA5FD4448C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <bfc2eb22-54af-dab8-72e3-a142470590c3@intel.com>
 <BN9PR11MB52760CE856F69A3FFD7EE2C88C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Tina Zhang <tina.zhang@intel.com>
In-Reply-To: <BN9PR11MB52760CE856F69A3FFD7EE2C88C13A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0167.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::23) To MW5PR11MB5881.namprd11.prod.outlook.com
 (2603:10b6:303:19d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5881:EE_|PH7PR11MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: e8aa3452-7087-463d-0b3d-08db9a074a07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jFvRfFPU5WfqKarTADQuZKJi3s+3k/+JniA8pZZybECwSb+6wf7kQDvKr8sqfmbAt/NApgkWoPNHPlRpAw1mdNDDG334Gx0doBf6xdEzixH0NfYvAhdJVQyx8dQDzb1b1LP7R0QpAT7iBNvKMainTAKN2sSUTyMKltcCl52ep9+cbeTgnLbfEbVuW5z5kr4bYbqRhcVEITtbuvStdW/GFu90e4prWqUL6SFi+sgq652cJ4RPE8aRJ6OEAbgePpmuQWuJhVuVi76HvDfmgv0wca8CwDuBfG2unFafY2FOM0R155jnTCmS7sU/IvCrrWKCq0LMJowxDFj2jOWY53Mwz7593w09N7Q4JZQIa8gwXDLIxH/y3RABa/A81HNYF2CsXHfCSP9e0Nn9sw2lx9Vy4l1qG5awvjW12NdzshLo59UhZ3d7rxpIPALptqL39xvJJ4pXDfFUdUMsMteMMPgbZuwuFOc8AssLKXLYSwDadoroK9SWKvhPQtVOdPsmlT4VHwjLAuTy9orfHStmYBKWHNiT4Axr8SkRAKqjJ5MVnzOmnHhnIpfGRUZZPorr1rSvU7Bj8t4GKRf+TCyNiQsVmHx/CiBPDaZFelGzIFUsOaVkWs9KmanQWnPzXVP46hb/JIFj2orIbPWSBjTURAjU9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(396003)(136003)(186006)(1800799006)(451199021)(31686004)(66946007)(6506007)(26005)(66476007)(478600001)(6666004)(110136005)(54906003)(53546011)(36756003)(66556008)(2616005)(41300700001)(44832011)(82960400001)(316002)(4326008)(6512007)(6486002)(2906002)(86362001)(31696002)(8936002)(8676002)(5660300002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1pybG5hS3hnWVk3QVVkM3ZkaklySkcvT0JqTEhUMHBFTjNJb0RjR0NXeXJK?=
 =?utf-8?B?c3ZzNkZmdXF2KzFPeFY3aFNEa1RnQ0dUejJzbmxuYmhxR2IzcUQ0T3pjTjdO?=
 =?utf-8?B?QmV6dUhmUjNRSHYzSVI1N1VTNWxWcDJFV1Z0VFp4dDlrQlh5TTNua1Y0T1pr?=
 =?utf-8?B?c0l0b0hKcFEwVDE1MVpDVEdaZjlCSWpEY0lhZmptNmppSzlvWDREMGQzR1E4?=
 =?utf-8?B?WmhCZGVRbTBoMzdnalVWRkhoTFZSdzB5bzloclp5WjgvUzkwSXkrcDdaZVlH?=
 =?utf-8?B?dGVKWG5ZaGR0UHllR21hVzE4UmRpUERpK2swZUlIQU1rb1N4NmY2OEtnWU1D?=
 =?utf-8?B?UDZLQUJVbThDRG44SzRDanAwL0UyU3F2aTBST1J6M09wdFlqZllUY2M3VDJL?=
 =?utf-8?B?L2gvbkdDRm9ONzNBeEZHN2lqbnRrRFlGc3dMMTN3NUY4YU1rZnhXZEViOWdw?=
 =?utf-8?B?dkNNd2d6VWdCSkFvVTlJejl1OWlaQzVnL0hnQStjOXdsekttMStveTNxUnpF?=
 =?utf-8?B?TjFZTlNkdUhsL09LeWZVR3lBbHk1VnVRZ05hdnlVZXI3NXN5UUo1YkFWWjRB?=
 =?utf-8?B?b1lZWldMOEM0NjdaQ3ord2lJU1oxMWFPNUxndCtkR1FsdURBazcxMUtqUW05?=
 =?utf-8?B?T3EyY1V0U2x2SkxSRm5EczBwT0hqRmlDTHpqNkZIKzltUEFiM1FTZG04dGp1?=
 =?utf-8?B?ejNpbWZJQ0E4c0JYcWxEK3FDZTg5MTEvZEwrTXYrZksxSWhUK2VwNkVTc1ZB?=
 =?utf-8?B?Z2VacEtVZDR4eHhHWEh5MGswV0JHU3loMUJqRDF2LysrSW9TZXd6SkxobXZH?=
 =?utf-8?B?elFtMmJTc0ZPUUtNRzZPTVAyQ2didHdvV3ZCRi91S0dYM0taYjYzdTRXVnA0?=
 =?utf-8?B?aUp6d3NlYVFaRzBlOGN6YXM0TVF1d25PZk9JUHlvdHJ1TXpIOFkvRDdkSUJI?=
 =?utf-8?B?Y0JzdlM0VVJHRC9MNmxlaFNBSi9mQ25YcVFwYzZ4Kyt0QlN2RVhHNm92dmtN?=
 =?utf-8?B?NlZ0OWlBNklOaDZHQnJQM21FNktuVjhEa1NEanViUENZYU12TFhLdXZ1OU50?=
 =?utf-8?B?a1E4ellyNytKemZWa3Q3OWVTMThoYklrMUtLS2pVbzhEMUtlMzRJdzJxTnlp?=
 =?utf-8?B?VXdEekN2QmJiTEc2SUF1QUhNRGhkYzEwUEJ0eSt5M0tDT1ZkQXYyYi9qYzcv?=
 =?utf-8?B?eHRVY1Z3V2gvS2R3V3dLUEQ1WGNBSW1XUUdBUkZPekZqZ1gzZXVpbElnc3pD?=
 =?utf-8?B?TkxNTWdlMHJQeDBseHNvbjZNNVhtaVl4WmpGaGJVdlhLVzE5eFdJVUp6Z0pH?=
 =?utf-8?B?MjB1K1pQSVpKMlpaV3czZHZ1Y2FEVWx6bnNOUXU2TUdYRE9VRnFHRTZGZFlW?=
 =?utf-8?B?dFF4eWxBUFhvM2Nwa1c2NkVqTXVoTmFlL3BvYXFTZFFCMHVGZHQrblVQWU5y?=
 =?utf-8?B?VGkzOGFDSFJyQ3BTTi9tWm5tOWtqZVVIdU81d1p1VWVTL2szZlV1WlpUcXIx?=
 =?utf-8?B?N0FPOTBzR3crSzZ1WjRUbTEzS05VaHp3NmlRVzhWODBXaGpuV3pEbWNDYkdC?=
 =?utf-8?B?UFV0VXhLeXZXckdYSmdLZjdsWVA2VXdOOTc1a0pJTkhhTldHU2JnTGJFcHNX?=
 =?utf-8?B?aFVSUUFnZ1VlN0R1M1N2RFlnMGg2akpSclR2UjRVaEMvbHpYZC9oVnpCSVha?=
 =?utf-8?B?U09PajhnMVFlaG5hOE9aNGZvV1lFSVRsdE1ldk9ma2ZhK2pNbDV1Q3NhSHQv?=
 =?utf-8?B?Rjh1T1NjdlU5cjh0SzZURUQ4MUdRc3p1YjVoNFdRQ2hhalN6dmxjcDlROFIz?=
 =?utf-8?B?TG5PeDZneXdPNDQ3TDhzMEFnNWRYMUJyMWxlRXVmUEFHTjNpU2RTYWlmTWg0?=
 =?utf-8?B?b3NuZis3THlTWkpaaWtuOFdrWEJCYk1EMHJrbytzWUJpUjlJNDZUaXdlcmdE?=
 =?utf-8?B?M2oxZzI4RzBEWDdqTzVlbHk4ZXlJOHFURktPTTBtbHUrbFdwOHFnVnUxakZS?=
 =?utf-8?B?UGZJTGsrNEJLYy9MdjIwSFRGQ3lSa29DY1hNSDNKYWlXVXZSUzA4WE5JaWRZ?=
 =?utf-8?B?K2swVis5Mjl1cUNXYmMwWTNtNHFQaUNOUElDTk1PTll4SUh3SzVLMTFsVk1J?=
 =?utf-8?B?U21hZzdQQXdDekdndjYrSVJtUS9zdkRuUGN1VFlhZDN6UlIzN0ZRUUJjejQ5?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8aa3452-7087-463d-0b3d-08db9a074a07
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 01:07:10.3279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMPPE+/gvrk84QRiZmaHA0+UWGS3Ud+NF5FIYnUi2FHGL8cWnL7Gls3ucBg/l5ERvU1BI7+mO5YbM0WeFeolGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6032
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/10/23 15:49, Tian, Kevin wrote:
>> From: Zhang, Tina <tina.zhang@intel.com>
>> Sent: Thursday, August 10, 2023 9:32 AM
>>
>> Hi,
>>
>> On 8/9/23 17:41, Tian, Kevin wrote:
>>>> From: Zhang, Tina <tina.zhang@intel.com>
>>>> Sent: Tuesday, August 8, 2023 3:50 PM
>>>>
>>>> A sva domain's lifetime begins with binding a device to a mm and ends
>>>> by releasing all the bound devices from that sva domain. Technically,
>>>> there could be more than one sva domain identified by the mm PASID for
>>>> the use of bound devices issuing DMA transactions.
>>>
>>> Could you elaborate it with some concrete examples which motivate
>>> this change?
>> The motivation is to remove the superfluous IOTLB invalidation in
>> current VT-d driver.
>>
>> Currently, in VT-d driver, due to lacking shared sva domain info, in
>> intel_flush_svm_range(), both iotlb and dev-tlb invalidation operations
>> are performed per-device. However, difference devices could be behind
>> one IOMMU (e.g., four devices are behind one IOMMU) and invoking iotlb
>> per-device gives us more iotlb invalidation than necessary (4 iotlb
>> invalidation instead of 1). This issue may give more performance impact
>> when in a virtual machine guest, as currently we have one virtual VT-d
>> for in front of those virtual devices.
>>
>>
>> This patch fixes this issue by attaching shared sva domain information
>> to mm, so that it can be utilized in the mm_notifier_ops callbacks.
>>
> 
> that is one of the motivations. e.g. another one as Jason suggested
> is to cleanup to decouple the common sva logic from enqcmd. Both
> should be mentioned in next version cover letter.
Right.

Regards,
-Tina
