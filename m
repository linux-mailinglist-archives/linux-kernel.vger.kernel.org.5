Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DA7776D85
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 03:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjHJBcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 21:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHJBcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 21:32:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DC710DE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 18:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691631121; x=1723167121;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G7JcvNdjyO260pgdNMff+LP+TpKu8eZoIClz5uvzYNk=;
  b=a1/9XC8pI7A2bTsqINssCPiuzJqJEkc7U5t99TeZ9fyYh7/cEo5oPdDr
   3uO9KeeVp1H1qnJl8XzlhW6WvBGn+7VLqnPL4xbu43dKFLse/ngsbzbbv
   V8S9d/IsUNqAdeYq0RjQTCTAxj/uDuOnLi8/RoVSh3ZfU6+FEYsEpUam3
   HDSIy8rkImDQD4CK6onTA9w0ksIAEkJvMpEA/KOjXWRens6v2QRElFX+J
   FIsAi4TZ2QTaE5tVnhvf9GF9pOPwEjlslmF8xuKdcMffmQ0SaosrJud6B
   AjOZDEWM9dwI0mCRG7cjg8xv4oooonrhTGiCTERAaWDIfvZcoulOvX53R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="402230962"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="402230962"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 18:32:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="822038354"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="822038354"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Aug 2023 18:32:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 18:31:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 18:31:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 18:31:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 18:31:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgcbEmT6fFbed5OO+8NjuuyOqrBqCUSnvRU5/b1oExekG9wevPAF0qO0F/rr/BoE46mYekN7CIiPW3PVJsqcpEx+uBfNdFevOJvnFzAgvawlpTLxe1Ybn14qTICtyIm4aeNWPSeFRHhqVeoLwfUyE7BDMGwa0EIwrxQ1OoBHdd5FXX7Zqzbt5E0lcpl7hcnKeFuWT/PlE2VD5Pw7lmacz8HrrZP0PaDBjv6EEz5DoXdlICui5xYc/+9VdZmiX3HZ7/zWkU12HV5dGKAptmRJcOIk0XsAWXz1aslECPybvKJ9SlVSKYmM5bqcs7t5t7SCIA47zbfH+QlMeRCJxhD+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JebmuRLNuSXVHR4xft+VHAuygeDdsWX3GW4LDdc0Lik=;
 b=OOOz8Hm0nlLcIewZUR08cWx7DJi/7QdGJBvdLVnGxVDmUQ73m36ffMjcGPwBtziezrxXkXeoidumN0PxUw+hPiVx+pOSVwxW3gTKdswQZ8eDPCC7bVA+kKeDaykZuaB3xyBiS1IUq20xECIudAeeOm7q3IZMPUScHdKhMoEerkSQAps3rSrNdEhch1Pd2Xz20faf5gV2K+vvySidrHiyitTTCvmWhMr1Y4KTosWEKDbTU6vnS5svSX998/mRL43U5ZBsQbY0MaxGNqHINnHyLy8dadfXeMCpq6dHHDzB+pr9HWKoNubh7n7B94fc2Zhk1YT7OiJQhqTfhZzfVLYilQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Thu, 10 Aug
 2023 01:31:52 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 01:31:52 +0000
Message-ID: <bfc2eb22-54af-dab8-72e3-a142470590c3@intel.com>
Date:   Thu, 10 Aug 2023 09:31:41 +0800
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
From:   Tina Zhang <tina.zhang@intel.com>
In-Reply-To: <BN9PR11MB527638E7361714F8AA5FD4448C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0119.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::23) To MW5PR11MB5881.namprd11.prod.outlook.com
 (2603:10b6:303:19d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5881:EE_|CO1PR11MB4769:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ba532a-58b0-48cf-f817-08db99419302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vJ9MNUk6UnBbYw+esD0BO/5W7IyHOsLqr3hN7mapKSgbuYfyRebdlB+oeNrkPAM74gftxJ9Is5UZ7IGN90FJoz6YabrOBKsuWcmmbgVpEmUMJ537/ib4Z/zzDsX13qd7d62T9Nt9sInTWaY3rweBVR0Tv9e1mAlKRIr0+0Mkxrl0uZ8y1A5GIcM2L4UZ0kzToKk06BUXwqKRxxoYmgciNERE6CmEvXnfcZPW49eHdm8uyOk0AEj40x0zjMrIRxrlolb3FFWVT7Vldsgn81QdSiExy59jxvQILZsYLKqETwi37Y+ImKR5D/SFe1T8zS2K50lw0W8GQm5/Em03FA+qGhqzm42WzMbQqczoU/3Es8FiADKEmVaFBHpxTGN+HqgMHS5xhBSzvloheAzNtLbhMUmgi5jYJEMFHxoH9GXs8h6a678ATwjypVz2EpjImJKND2NPHHIv677W9oX1CfvS+14k7+u9ixRikthcqmk0lXlDkPeM5XM2V7DG1huUn0YEBEwI0/mMsOccky9g9cImhgBccffnpBX9nDt694iW/X1gjg9PSyEJteSqZXFSwgiy1LyfF5/ZmkPaQc+1Cld8EGka4TpnKr0Ftva+9EwLUIjJ2PfDsAaU8vCeP63aSUUuFPOLAjuAFMAn0PEmqARWGVwRei6uN74rPBlBuEGnlZCfpf8w6PIvuVehqPPdkJKz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(1800799006)(186006)(451199021)(5660300002)(44832011)(31686004)(53546011)(2616005)(966005)(83380400001)(8936002)(8676002)(26005)(6506007)(41300700001)(6486002)(6512007)(316002)(82960400001)(36756003)(38100700002)(6666004)(66556008)(66946007)(2906002)(86362001)(31696002)(66476007)(110136005)(54906003)(478600001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ni8zbG5icUZ1YjZJR3RWck40VUFtbmpwZzgyOTdVMkxyQzJOUFNIWDdpRFI3?=
 =?utf-8?B?Mndkbm50Z3VSZkR6amZFZFJqUkJzYUVMdlhKUEl0bHB3RHlxMnI4bEF5R0tu?=
 =?utf-8?B?Mm1HdFpNZDludWptUVNJa0p1a3NaNmxWdXZWUm1BTHI0a1U3M0xoaEs2MHRi?=
 =?utf-8?B?M0Vvc01HNFlvbHI2d1BKSnVnbjgzTnM4TEJIWTlBbEdjcUxpQUZIMUp6QWFv?=
 =?utf-8?B?em5kdnZCLzlXSUdnb3VLVGdNQWRHbG9XSFpDVkxwN3JtWUlIblpqbVVaRm5M?=
 =?utf-8?B?OFhTelNiNUl5aEZOTkIyUW1meW1xSXJrWThzb1BkRGNaM2hEODVKbkZOZHN5?=
 =?utf-8?B?eVREUHozMXdmc3c1RjY5VXY3R0p5MGxDSVVBeWlGc1NTcWlCQXNVM28yanNF?=
 =?utf-8?B?dVE5Q1BacGZIa2VETy9iYUptSU5DSENkbUZaY2tESjZKRGJJNitncW4vclRY?=
 =?utf-8?B?OHF6VU1waUd6dGt0Y0ZsUzUycnN0VkFBTFRIVndGVTZURjNObXdBTCtXOVRE?=
 =?utf-8?B?TDEvQjl6TlhVR3RoVUt0WXR6VFFMTVBPUnlYamNFbis2dnl1d3RtRW4rYXEv?=
 =?utf-8?B?b1Qxb1ZPWUxUZlBJQmFkbTdSSUVCV1NhcDU5TFRBL2plallDelJqRE0wS1dy?=
 =?utf-8?B?V0FtajlYTCtyTTErUExObjhKdittUUN3OEtXT2lPUnBFTmRGY1B3alZHMWY0?=
 =?utf-8?B?RTM1cTJpNWtlaVpvSHBRZCttQWVncEZhekNlWXh5T0R5YjRsZkZFVFNvSURM?=
 =?utf-8?B?YmhqZm9ZTDhhVVRZUi9mR3Y4K2NjcmdGSWZpMEFVZnVZQ3MrcmZJWDRrWXY2?=
 =?utf-8?B?K3dHWXZCUForVlY4NFQ0amlKUjNEVEE2TzMzeElKRmdRaWJuanQ4SnRzQzk0?=
 =?utf-8?B?anAvRjA4SHJhQkYrb2hoQUVNUXZjWm4zMlo4MTlaRHJJZHZaT2o0akxqUDE1?=
 =?utf-8?B?NzNUM09NczRLNGVncVluTkVrMzZ6YTNzTkZ3UGU1Y1dtaDBQeGZ3QlA5Wlpx?=
 =?utf-8?B?QUc2WU1JSVgzZkFvbDRyMmI4Rm1qS2I1SDc5a05wdmpHcnpCdDA2Sm9pcFdx?=
 =?utf-8?B?Y05VcVJtN0U3MG5hMWZidGtIZC9HQ2tLbVAxL0loOGdRVkRRUGh1L2pNb2Zh?=
 =?utf-8?B?S0dlNmhFb2Zkb0gwLzZ1VzU5NnZXb3o1eEdXajZxUFlkZlhCZ1pMYUdrR2cr?=
 =?utf-8?B?QytVWUVNaEhvcnhBaXJWWlJ1ZmlTaC9IVnRucTRTOWdIcVprUmsxMUF3a21P?=
 =?utf-8?B?QUxDcEJzVlVpeTZJczdhTHJYN2RVZ0lRS1RiM2hFcWhQV0IxekxJd2tmR3p4?=
 =?utf-8?B?THBrNE83T09MMnNGT1V3TzhBK0ZSR1dXd1NuQlM4ZU43YnB6V3VHazlIT0tW?=
 =?utf-8?B?bVVBZkc3aUxRSGExdml0UDg4Uk45MENSL3llVkhibU5tQSt1WWprS2YvSENm?=
 =?utf-8?B?WVRqaUVXdmNPc0tlS0doTmtHbjgzeTVLUEtFdko2OUZrd2JlcmVJZjF1NDdL?=
 =?utf-8?B?MmhtWkZ0ajhlcGJYb2lFQjJOeGN5OExtQ3hSemExbENBbnl6QWplQkNyQkJH?=
 =?utf-8?B?OCtLYXJUNlZjT3RLOFdKR2Q4V1E4MHc2eTE3SUtZUGcvcUtIanZTeVlsRmdv?=
 =?utf-8?B?N29Sa2RvbmlyL2RCcWQxV25DVWYzcGttVnpiUG53TFpodEYwNHFUZU9VUWpQ?=
 =?utf-8?B?SWpOQ3VVeHhMNEhlWjQ2YjJjRjdoVUdic2E4NGY1cWk2U3AvZkJvUC9zRHhQ?=
 =?utf-8?B?bEU0RXNzcjNBZHVnZTBpQUtEQW1iQ2ExM0NaVk16RUZkN3BRTTlIZUt3R3pm?=
 =?utf-8?B?UHZ5MjFyWkZqbitrVmh4QnVWVDIxVzhwTitYQWt4dS9TRldwUTRzRXJ5ZzIr?=
 =?utf-8?B?emZ4K1VDUDhFTHdiTmQ3cWRKWmlvZG43WERKRWdjeWJpM2xuZFVEV01KdDlM?=
 =?utf-8?B?TTF3ZHdVdUlYTFhiR0h4WWRud3BCOHViWkdPemRBbWFmNnIzaHFzbmVDSnlS?=
 =?utf-8?B?dTJPQkJESWRtSXFjUFBtOVZJRExCU2UrODAwTTVJZ28yanJCTGErYk0zOTN3?=
 =?utf-8?B?aW9SQTlMdytqR1k3QmhvV0JHWGVmVFZwMUJ0WWhLV2t2OW5uUSt2S1R0eTcr?=
 =?utf-8?Q?r1G92uLXPAgX0Zha+jpuRE4Lc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ba532a-58b0-48cf-f817-08db99419302
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 01:31:52.4445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAqpPkY2Ft/2RnhliLKMUPZ1iNSvLgeWz6Sp6qug4zOL1CV84IlPOkKhRMIJNtbI/B3vgstbJrEgqvz9SdGv3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4769
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/9/23 17:41, Tian, Kevin wrote:
>> From: Zhang, Tina <tina.zhang@intel.com>
>> Sent: Tuesday, August 8, 2023 3:50 PM
>>
>> A sva domain's lifetime begins with binding a device to a mm and ends
>> by releasing all the bound devices from that sva domain. Technically,
>> there could be more than one sva domain identified by the mm PASID for
>> the use of bound devices issuing DMA transactions.
> 
> Could you elaborate it with some concrete examples which motivate
> this change?
The motivation is to remove the superfluous IOTLB invalidation in 
current VT-d driver.

Currently, in VT-d driver, due to lacking shared sva domain info, in 
intel_flush_svm_range(), both iotlb and dev-tlb invalidation operations 
are performed per-device. However, difference devices could be behind 
one IOMMU (e.g., four devices are behind one IOMMU) and invoking iotlb 
per-device gives us more iotlb invalidation than necessary (4 iotlb 
invalidation instead of 1). This issue may give more performance impact 
when in a virtual machine guest, as currently we have one virtual VT-d 
for in front of those virtual devices.


This patch fixes this issue by attaching shared sva domain information 
to mm, so that it can be utilized in the mm_notifier_ops callbacks.

Regards,
-Tina

> 
>>
>> To support mm PASID 1:n with sva domains, each mm needs to keep both a
>> reference list of allocated sva domains and the corresponding PASID.
>> However, currently, mm struct only has one pasid field for sva usage,
>> which is used to keep the info of an assigned PASID. That pasid field
>> cannot provide sufficient info to build up the 1:n mapping between PASID
>> and sva domains.
>>
>> This patch-set fills the gap by adding an mm_iommu field[1], whose type is
>> mm_iommu_data struct, to replace the old pasid field. The introduced
>> mm_iommu_data struct keeps info of both a reference list of sva domains
>> and an assigned PASID.
>>
>>
>> [1]: https://lore.kernel.org/linux-iommu/ZIBxPd1%2FJCAle6yP@nvidia.com/
>>
>>
>> The RFC version of this patch-set is here:
>> https://lore.kernel.org/linux-iommu/20230707013441.365583-1-
>> tina.zhang@intel.com/
>>
>> Tina Zhang (5):
>>    iommu: Add mm_get_pasid() helper function
>>    iommu: Call helper function to get assigned pasid value
>>    mm: Add structure to keep sva information
>>    iommu: Support mm PASID 1:n with sva domains
>>    mm: Deprecate pasid field
>>
>>   arch/x86/kernel/traps.c                       |  2 +-
>>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 12 ++---
>>   drivers/iommu/intel/svm.c                     |  8 +--
>>   drivers/iommu/iommu-sva.c                     | 50 ++++++++++++-------
>>   include/linux/iommu.h                         | 19 +++++--
>>   include/linux/mm_types.h                      |  3 +-
>>   kernel/fork.c                                 |  1 -
>>   mm/init-mm.c                                  |  3 --
>>   8 files changed, 58 insertions(+), 40 deletions(-)
>>
>> --
>> 2.17.1
> 
