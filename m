Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1B37AA6C9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjIVBws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIVBwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:52:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CD1E8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 18:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695347560; x=1726883560;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yn0FMvKubb4VmqkNbjfO4NA05YixUYE0JaaP82xBlas=;
  b=XEt3qdqQcchQb7Qfi5fI83JOAjc0/iLydeEOYdroHFSDz9EnL4qO8Ls0
   BDzVy2Cf/6iCKagRP2baJfZ2H9je0NomZrVevCpr1EDAN0IapunUE0dhL
   7eKkSaYJ/sQWYtoaDj829klnNL8fPgZUkWAeTXManxuDWN48+VYskWbq5
   7poSor2M/UKG5+CFWKzoEV1WljXOZqQRrKaPlvOUHXrYdONGTGUq5ax/+
   9K31dgJ3oZ/oceUrudKL04mk3ltsylvYyf7F2Nr1QZPkgmp15L27mawOM
   lxvvZujFhmW6X8vJUv89d7tlSHdlRbUln0EOUHk4bi73DDcHr4rQu/Klu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="467021682"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="467021682"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 18:51:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="817608033"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="817608033"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 18:51:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 18:51:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 18:51:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 18:51:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 18:51:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktl/kIfURaLi0oSqpb4szzHYv4MYogZ4BT891BZUJ+PQ9Kq4BBMCSqxkSbora4rqrlSQtG0zyVp0UxpABc9Ociy7fd1C635DPBwCPZ9P0i6A1tVjbSvgo47YnB6SZDCXfILCdJ9yzcwjmoJtLbTZiDLGSFAR3lL5dtULZ7/O1vsVwGl5gm6OseZHgqfHB2rCba+TbFUMiM+ESr2mEF6Ka+9OWBDGuujekVici0sN5utjNEA16SWVq/KLAPnkjjfcgK++7h0enAjOmtxqlWId/J0rifiTwqBdigUEZvUDC8mSg3kFqJ7SnSUGiEGyY7sl+tc8w0HiHPUKLvhDp8vPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1JpSHpOgyEQrfougPG7fu7colYiO8biEVWnDIApTdI=;
 b=ARZZXfqsyV+oE+NIKa1/NeADCRoBLeke5ZExBJIF81qtdSUU2k11ndZ8YCsb3cJ/vNMkAs+NgVz7A8WG2IndWpOl9Ij94TINL6EkfQ4uqXLlvCE01BQqiqJmYXgYrRQ6qvtRJhg4e7xwFT89q0ImZI9zKU1F79qJSm5dnCuX8Gx8q7Ygnw7iRDWtONR4wC5SxtHbji09NSc469UY1czaBJ2vpAGNznRJS2I0s/UQHnWBmNza/gy1VCALT3hjP5NWSxXsYH3lGJMTaem7WweIzsCeZSm8m4zqxbVSPo8Fw78gsd8Cm+696f8VZEkx3ZIrfIhg+wBGNuECAweI6OeMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by CO1PR11MB4833.namprd11.prod.outlook.com (2603:10b6:303:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Fri, 22 Sep
 2023 01:51:55 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c%4]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 01:51:55 +0000
Message-ID: <cc71e279-8f43-0e84-f4b3-7040c31adac3@intel.com>
Date:   Fri, 22 Sep 2023 09:51:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v4 4/6] mm: Add structure to keep sva information
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20230912125936.722348-1-tina.zhang@intel.com>
 <20230912125936.722348-5-tina.zhang@intel.com>
 <20230921190427.GA13795@ziepe.ca>
From:   Tina Zhang <tina.zhang@intel.com>
In-Reply-To: <20230921190427.GA13795@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14)
 To MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5881:EE_|CO1PR11MB4833:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ebc8535-5e00-4881-dba6-08dbbb0e7f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o88+JP6UXzybeMpQVnP5tHKZJDBCDS93Itiv6zP7CdYpw9yMuM3ywbRsyEujc286kcw2FcOShnJofw4smD+aw7EKo9vBqb5Ziwj6cKZA7cYnCwIOyVtjYoyIi2sHGVBKjbqxB/YsLqcafmp1lhTwZV72APAt6n8myNRBidcJq5mkWk+urR/UyEJ59ou2XwiH4daIlgYt9ICZxPDN1n3X2oDu5x2Qm5gnsX6Hc8Nld7moYwwoqFl2zAT9WH3H8R99ajJOgvLpFmJERzX/v9JSgI2IQM/fe6gB/xcEF4oVH6xOsxruE3eG0b0TOqF54KdzqjNmFiLvEs3xQdwZbmBws9hzPl9XmC9gmrS2soQD1Q924C3NVwiEyxwE3YCXslixL6Mb1vrIRJteZ8ZaXg3t2YVi+mjCAx7ySCCuOXeUo+X6h1jtKden49JyH3PjsmKVvY/LxakXhbifG9/nOuqBAEXCJldFVqKvlO/ZpcAECtUgK3QsageW/8zshO06X7aQ6K0dY/9z/b4WyjA/jVQFA7VJqGxjAD2m1rkLQ0nnN5MyDS6szrwGHz0IlaCI78ewC1ddhzZ8W1pC/YxNQ3BjaR/IZkitv8532FS2PJbSN0YBnt6Z9fe/AOLhjisg5NLmxX+GxI69zx7ztK75qmVQcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(1800799009)(186009)(451199024)(6512007)(6666004)(6486002)(6506007)(53546011)(478600001)(2616005)(44832011)(66476007)(26005)(66946007)(316002)(54906003)(66556008)(41300700001)(5660300002)(8676002)(8936002)(4326008)(6916009)(82960400001)(36756003)(86362001)(38100700002)(31696002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blBxVHVPQ2VZN0gyU3l0RXgySnJOd1dTNERzU3k2M0UvNGlueEZMM3RWQmwv?=
 =?utf-8?B?WHYrSXJxMll6elNoTC80dWdkQThrMUM3ZkdaTjRxbEVUNC9ja3FFMzJiM3FK?=
 =?utf-8?B?ZUtOYlo3b0tZVkcyaHlOeGQ5RnZaZ3JONFlFTGxJQTNNak5TaC8raUFra21p?=
 =?utf-8?B?WHcxakpYVm1sc3hCanNJMFVYeC93dkZUQVpiYmZKbmNpL25WNmlRaXpNbS91?=
 =?utf-8?B?Q2grUUo1UCtiNFltS0F4MzU2TGdwUmtJSjllNEdPaHI0VldORlZuOS8yVDRE?=
 =?utf-8?B?allZSkVPUUIxVU15dmpGQjhGQkI1MmNLdTg5NlBDSFRSQ3h6dWtkd3BtU1Zq?=
 =?utf-8?B?cGpDZUhZM2VWdVhiSVlnVnd0cVZUTDhNbjVwaXFBK2NtNVdmNFlienJJZ2pm?=
 =?utf-8?B?cWRxRGpnU0syRk5VUGhoamlSUm5halA1bnZZL2RRMElUVldDVkFnMUc1bnNk?=
 =?utf-8?B?bVRhVnFnei9TNVNLRElGMWdlaUl6b0xIUkd5U2psdFBlUzRGaTlTbXMybkNS?=
 =?utf-8?B?aE9uMi9KTmNGSnVrNkdjWWRuTUpKa3ZrSnhXVHF6Sno0dmlZV0xvT09INENE?=
 =?utf-8?B?NG5jUEZDY0FCOGxSZEFwL2crNld0eWxZT3JxRmlQei9WZ0RIRHZ5aWt0QzJx?=
 =?utf-8?B?Mm1Cb1BFSzd3bG1LcVhKQ0pmYjF5QVMvcHhqbDFOWlpWZHpWSHRDeEc1aSsr?=
 =?utf-8?B?Y0M0TGprd25hVVpQSVdIWTZqQ00xVGpvZGo4Umt5QWIwRitsVlhoYUNuTCtL?=
 =?utf-8?B?QXJaaDk5ZUNRRDhRc2RPUWdLRjRMdHNDcHZpN0RlZXpPbk5tMWs4SlA0a2l2?=
 =?utf-8?B?QnJ4K25lNHo0Q2h4NFdmZ1ovTmFuZUhkV002MUk2SmdmbERhMzBqMFVITXVt?=
 =?utf-8?B?RkxrQ1JsRXlZV01GdlBiUW1pNHJ0NnRsYnNpT3FtdjBiaytpcHJGNzFmMXRp?=
 =?utf-8?B?bkZMWTN6aVpVSU1kcGhlU3NidW0vTEEweVZKaFArVjVtTWh6ME5BNjJSUXNj?=
 =?utf-8?B?b3JqYkZuM2EwS3UraU9HaU5aU2FhMjE4eFZ6SDNmdmVISzZCQjN3c1UyUS9D?=
 =?utf-8?B?cVRoK08yVXkxQ3dsZURURGhMVlVnV0F6eENseFQ2VFpwKzR1UmlqSG1jcVdp?=
 =?utf-8?B?YlZpWlBHT1JpWGJlWjVhL3FOeHppVXV1dDZJQU9XRkorZHhtWEUyRlk0cjhS?=
 =?utf-8?B?NkJ6bDFqREIzS2hBVGk1c2s3R2hQSzJTZTJkV3h1cnBRY0x2MVMvSk8xbVN2?=
 =?utf-8?B?anBiV25XZTVlWnN2RUNkdGE4VTZDNGNxcWNma1d4YXBUVzZ3cUs0cTlHZS9O?=
 =?utf-8?B?Vmdwa2p6VndXWnpTbElvdzBqeFVvL2V0cnQ3MldiM1V6dStncXUxTmxzZFE4?=
 =?utf-8?B?cUlnSHFEc0xpSllvTVJFMnllSHVRSnFYY2R3ODk1UmlWdk1ab25qdGIrMEln?=
 =?utf-8?B?aDNTb2pSWVhtZitOaHZhQ25qNm1HMDBrRDBOVnI5bEFBaTY5WFNteGswcFY0?=
 =?utf-8?B?cGVCM1BqV0ozVUVtbXVMUkp2ZmNsSXM4Z2QxcGw3TytIcWhBZENkSXpkS29v?=
 =?utf-8?B?b0RtQ2N0ekZuQWk5WnpqNVF1bllabkZpVitQR3dqQVY0SmZaS2J4cW5ieC9L?=
 =?utf-8?B?U3h6MVFFUUN1RWVjOG5pbHZRTnhOMzdaQ3JnK3BNSGx1RlpQMm5jRW83eXBF?=
 =?utf-8?B?aHU1bFJXdWNNWHBFQzFFL2pUNkZMdlV2cTVhSjlzNzZVUE80VXNhcmlCNUV0?=
 =?utf-8?B?KzR0T2VtbkE5VlRiTjIrRUozWmp2SERWbVBIdld5RjIwMUVPTlhEUGRmdEpY?=
 =?utf-8?B?YUFxN0FndHYyRm9GdCs1VWNEVkNpN2ZPeVpBNkxCUHFyRTJHb3Rqa0E3UTly?=
 =?utf-8?B?clA0Z3FDVW5oQ3FmWER4blF5d1dlNVhhMC81OU5qUDNwRzkxaDNveWtMRGJJ?=
 =?utf-8?B?Ry9YNXRXeWNDaWVSL0dEbHY1RXhLZDRxSjRvUkxOSjNzN0RiNWpWYVdGUXdj?=
 =?utf-8?B?dDdvSUg4U0M2Q3FYNmdVbk1XNURCS1JPdHRKbDJ0N2Q1U0YzQkVIaDA1U0lw?=
 =?utf-8?B?TEFOY0d6blIrSU9MRUtwYWhmYUJZTUVtemhlWm8rRzlLOUd5ZjhUaGQ3YVFF?=
 =?utf-8?Q?+5bhSDxupEza6yMmnTtzdD6qO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebc8535-5e00-4881-dba6-08dbbb0e7f97
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 01:51:55.0461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3C5Dg3oM1ka5WXvW64fIotbaMxKWWyAH0fTZLnlMdDsNE4QyaXgfOGPAPkjOBw1Zg5/qUbRMndu3pHvm9AL4lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4833
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 03:04, Jason Gunthorpe wrote:
> On Tue, Sep 12, 2023 at 08:59:34PM +0800, Tina Zhang wrote:
>> Introduce iommu_mm_data structure to keep sva information (pasid and the
>> related sva domains). Add iommu_mm pointer, pointing to an instance of
>> iommu_mm_data structure, to mm.
>>
>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
>> ---
>>   include/linux/iommu.h    | 5 +++++
>>   include/linux/mm_types.h | 2 ++
>>   2 files changed, 7 insertions(+)
> 
> This is not a great way to structure the patches
> 
> This patch should move the pasid into the struct and do all the
> infrastructure to allocate/free the struct.
> 
> The next patch should just add the list head to the now existing struct:
Agree. It would be great if we can put a new filed adding and its 
related handing logic into one patch. It will be convenient not only for 
the author but also for the reviewers, as it can convey the intention of 
the code change more easily.

In this case, the reason we put new members' introduction into one patch 
and their handling logic into another patch, is that it seems an easy 
way to replace the old pasid field w/o involving extra temporary logic 
to keep everything work between patches. Fortunately, we only have two 
new fields, which might make this option not so ugly :)

Regards,
-Tina

> 
>> +struct iommu_mm_data {
>> +	u32			pasid;
>> +	struct list_head	sva_domains;
>> +};
> 
> The code looks fine though
> 
> Jason
