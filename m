Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3E37CC8A7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343615AbjJQQWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbjJQQWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:22:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F76F1;
        Tue, 17 Oct 2023 09:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697559732; x=1729095732;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=86J/bNSIxdThh6M3gYcwvHVQpANfDDe+zZJXtqCE78k=;
  b=HHcwHjgEzqbuVMsviW2nt1b9u1oFDGHlEh0+gGNHx4CkYi5g+Nh4lat+
   5X9JYAVKyuAbQZMhse+fUqjL9NWf2pZUFFDN0sMN4KFJ9QNHMd7BzeJsR
   1BVX0/5ti1ML0dLYmZXqte5Nt7U5QgXB5C19vJqnAO7w3TLX1QbcR4Ojg
   DTKQtNaONrtw2QSOemaozCzWEWaB2ozq/5s5B0Bvs6MXLYK4FcYWb0ovR
   3d8zd0FA5SxoWqk+HRP5VUC/4ImPDkjKExXL1BMx9gjJDW4ntG9qyNuTt
   TtOobxs4mk23gGgLGI5pSglfPLZX2d9+WNf286A74j7B7NGvVcOieS5ur
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="416904504"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="416904504"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 09:21:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="846882959"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="846882959"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 09:21:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 09:21:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 09:21:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 09:21:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 09:21:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwdX8VvFIW/blKbqlGYHOM2R/Uzvymdy2x171qbQwVjaL9x3nkreITyOrUMAyaE39/apP0UuxUmf7xyH05i7JFeJOl2ghB8YNXwWGQEDt1s+N5etjdt+/oDuq42veZDiRbJeVN+b1ExaJ62+Gnk7ME8dFl1M/JN+gZpVqDCoo+LohwXLJnZ/LFG9OXyrEB6tmE/r2GdFRGhLwBtiIwqKhst09z7dkalVGkb5G14qb80TBFUXdhIycrrErvn1QqL8nrBqZ0dZNllTL1nZa5hFLDQzRXL5dIZ9svZMviJOTIkfzZWXJ7Ueo7BY8/xQG7gVTXK514Y4j1aVzby6ux50lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pi5QM/aTUYXJgobYAN9c2sCVewRDzT1kzSGeJ7FnbTg=;
 b=NULjLgSFSEXZ1mZbie/3bWV+dNQblyQOwp1QTfRH1KfFGvuPuLLloz9D+PtpnImnGjdNnM9w1hN2tnbURwa20vCsMv5jxOwU2ngOFxoGWaVGCRMheHc6o48d1+NvC+topO+9ER2j1pyJt83Ss0uIe4sCIx0TXz/wzdIONJP7eXH+oOurxNkDiGhYsPLtKCSkyZG8C7P9PS6rTBzO1MdgDT89wune3x/8XbBg/rxBfQOpshr6fCVoNsXqVDfZUntbeL6f3T/c1DQY/7hevVtA/7Llr3qb/pd8vxfw5kYRGpPjOd6v1klQz5mKG/o5kYsIQU3dyaVssazUj/PO71OSvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB5517.namprd11.prod.outlook.com (2603:10b6:5:388::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 16:21:33 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 16:21:33 +0000
Message-ID: <ae0860d6-198c-4d82-a7a6-8d0656c9070c@intel.com>
Date:   Tue, 17 Oct 2023 09:21:32 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] cxl/pmu: Ensure put_device on pmu devices
To:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231016-pmu-unregister-fix-v1-1-1e2eb2fa3c69@intel.com>
 <b62ded44-4432-4aee-a086-1171b89fd2ae@intel.com>
 <652ea9afdf5b_2b0d2929417@iweiny-mobl.notmuch>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <652ea9afdf5b_2b0d2929417@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::26) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB5517:EE_
X-MS-Office365-Filtering-Correlation-Id: 92310ba7-2139-4a36-952e-08dbcf2d20f9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2lKnKTcnoM9pVPSUfyY2xflepZCuDqSx8y1tGFbHHvFieDI9B/EvMa/Up4XL8zcJ4bc13qTxtlGdO9R/jyAe1b3CyfDPpDdtGHaNMrAa8+vVFhBC9fdDgrettKbtTwE1QPlsgi36HHHUzRFatcjQ+pq5RhrOpQxMFE9sDJrXjdhRIPupeNw1Hphxf4dMT9/YTVLln1ih2aNeHThJvpNc7IRul2lF+nMzraLZi793jfpamZdJbM97i8uNWabpXZss/+K93+0eEzNxJAidK1krFZfVedUZ8M256o1UD7d6FWKddrWFeFkcpnSEo2SZxH2qSkP+773gOWqvTVyKuv5twsQX4bV3LL8jqsWD5J/wCA4ATWOIzenieZL/CWEtbyTbA/tfAkEpuLAhNAUl9cbMJZxKVmCqEY3XjNOiKK05SK2+hUvYRXNzv411heiV6sbvl4GKX3Xp9xEgvwz4ti4m59pbdt4fGZ6rHl9tWYLEEy6mLpJQoeRqbU2sgtUi9NWBpL/w/EwUd7Jf/Gsjm969ZuaMq0vx67Ek9Asc54OfwelDNMDuNcamP38ppD0REjWBsuuMwpoTlvGuWWFL4GW0/oVR4XIiiIEYYXgTHaWbkDVsUMCtVb1MZ3oxYLhQfpi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(53546011)(6506007)(2906002)(5660300002)(44832011)(26005)(36756003)(2616005)(4744005)(82960400001)(38100700002)(86362001)(6512007)(31696002)(6486002)(31686004)(41300700001)(66946007)(110136005)(66556008)(66476007)(6636002)(316002)(4326008)(8936002)(8676002)(478600001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTZJeTU3VVlKQ1RjSXVMQ3NoaWJxTlF2STBHWVNObWFiWC93dGgyZ1hFVytB?=
 =?utf-8?B?SFlIWkhnRmxRMFlxYjBwQjgxZnJPa21DbVNWYlZlbVpxcXJGTVhCT0hmblBG?=
 =?utf-8?B?L0EwOW5yZHZXeFlWVnlhL0ZwTGJCdWp5dU5vUGpiZkJQOFFVTENKWWRzd3Bi?=
 =?utf-8?B?Y2Y1V3RzSkFWc1JZMEVFVUR2KzBQYTZMcy9ZWTV0OW03QnV5aGh4Wm5nRVVx?=
 =?utf-8?B?NTNFc3k5VEpoUjZuN1kvTDZJZE0vWUZnL0pqdE96SFFIZzJJaW94NW1KR0Nh?=
 =?utf-8?B?cVdGUy8rZG04VzVrRHZkWjUyZzVvNTEreXA3bUtvamIyVVZrY2hJd1k1SHQv?=
 =?utf-8?B?SVBrRWJvR1creEZWZERIUEttaGRxRThPTERZQ3ZpQlNydENQSjNnSUpUVXpa?=
 =?utf-8?B?dVNlUG9lWVFqS0pyODhDR2tYZ0krTlIrVWJQQi84Y0djL3dxZHNraUR0eWdQ?=
 =?utf-8?B?bHdra2lOUGRrRHoxVVI0NklmeHNGa2U4TXB1eWxic2Y5SUV6MmhwUG4wSUVl?=
 =?utf-8?B?bEZDbXJVbFRGeTlUREQ2VnB4UEE3bkw3STZhUzRkeDZyN1FKaDlnVE82bmxK?=
 =?utf-8?B?eWNrMW81QmQ0S3QybHhKbnkzS3M2UEtNbVRLcWY0eFBvbWJhcHBxQ1p1UWVs?=
 =?utf-8?B?b1RGRENYZEdOYUNGWlNxd05TUVNBdmU2Vk1NZFBkQnd3WDVtRi9kazUrWk0v?=
 =?utf-8?B?QXh4UlR0YkVVQlBqVmRhblZDaVA5MEdDVFhCOTdyU243dUZvUmM0ODc4dnlv?=
 =?utf-8?B?YlJvYlllSjMzb3JXb2s2Y3NSSy9xTy9FbTgvUlJ1S29ldE1uRzRLZlZqVDdh?=
 =?utf-8?B?eG50MGdyUTNjS0l1em94SkdreVd6U0ZDbjBPM055eTNKVXRXY2t1em85QkNK?=
 =?utf-8?B?UDZWbXpqTGNqUGgxUFZ5OEtKYXVRVE56dkMwd3F6ZG5MTExsUVF1SGs1U1dG?=
 =?utf-8?B?eldpbVIwdTVMZXdwMThSWkZqdzRxRFRLaDlJOUdETDc5THpZdVJKeU94ZHVY?=
 =?utf-8?B?Q2tsbE8rTStIdXFuVnpIYnlQL1ZLeTROWUNUYTVWWFBUejkzM0tXSnFiQVFQ?=
 =?utf-8?B?VVJLZklZZVlBWjBSSTJmdGZZY09pNklXeGJYdWZCV2d6ckhWTTVaQVZocTFC?=
 =?utf-8?B?T3BJVVhYSjFlUmNzWHdZVFF0WjVIMUp5bWV2cnhDRHBuTWpFYWY4Wmh4Vll5?=
 =?utf-8?B?YUdOSm9RY2F3L1k3N1NKYjZCaFovbEhCWWpxaUFUenZRQkhqUU0vN0IrY3ds?=
 =?utf-8?B?VFloWCtwUGplZFhScktQcm9GbUZWYVVtb0lxWmdDYTJndi8zSUh1ZjY5ZVhK?=
 =?utf-8?B?VnpQbWxXUk1LUEczQ2d3NEExWmEvTzhxQk9jaG5ZT0VCWkdRVmgzTGhIUEFC?=
 =?utf-8?B?U2FjZFdlQVZTcG5DKzd1VnFXZnlXdkJOb0Qvb2l4blJkaEdKZTZTTndBUHFY?=
 =?utf-8?B?U3AvMVd6VGxuZmxVNlpGeXE5SkFqdjlKQ2Y4c1E0Q3ZEbXJ2YmlaQ2traXM0?=
 =?utf-8?B?YUZNM0dhUGRQVndUdGx5SkNIQm45THJqV0JONFoxMGN4SHpRYnhrQVRYZnA2?=
 =?utf-8?B?UlB1Qnh0bHpaZ1lxTVJmZElqTTNuQ1NYQ1B2TmNjVUV0a0hqRlgwMGQvZFA0?=
 =?utf-8?B?YlR1Y2dtYXFtckdraFI0bHIwWVVlRi94OWYzQUJINzRSY2ZNNm5CZlU5SnVp?=
 =?utf-8?B?dGxtRWwvNVJwaWZwZTU5clN6Qnk5RGxLVjB6RmZ2VnNGci9qSjNhc0M2Wmh3?=
 =?utf-8?B?Z2ZQSmg3azNqV2tnVHJLSzZUT29SelJNN1hGSWN1MjFJZzdLMUZOTHFqblJ6?=
 =?utf-8?B?OS9qa0xsTkVxUmdEZVU2YklNeWM2VklNVVNvcXlmdFg3SFZPSHV6Y0cvNlFY?=
 =?utf-8?B?RXQzSUs1Y2VyRDErVDBONkg3cTB5bEpGZE1HTVdmb3d4aUVLTDE0MXRLQkZs?=
 =?utf-8?B?aUNxVnNnN0E0aGV1VXlMR3hnamFIUllkdEtpR0R1U2FVd1hPWWlYUlZ2bGlm?=
 =?utf-8?B?Q3pCU2xseUpsZ3ZEOVNoOUs3cUxoV1hGRnJqWk1DbXZNVENxZ2FYK1FNdUhn?=
 =?utf-8?B?aXZrd2tJQkc4ZEVxU0x5c3Y5QnoyTERwaGFyWGxsdU1GYUNJS3NDNE9ObWpM?=
 =?utf-8?Q?+LSyjW4xtPX4DB45kIuqL2SUj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92310ba7-2139-4a36-952e-08dbcf2d20f9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 16:21:33.8363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJVjgFDqsPjOUOWRLJzj6zgumXqMjWMmCaqRMalhdL7gEZMK4AoCUMiA9VS6kW/uW3cxVAxoqxIqtVP1FX3rkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5517
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/23 08:35, Ira Weiny wrote:
> Dave Jiang wrote:
>>
>>
> 
> [snip]
> 
>>>
>>> Properly call device_unregister() to free up the memory associated with
>>> the device.
>>>
>>> Fixes: 1ad3f701c399 ("cxl/pci: Find and register CXL PMU devices")
>>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>
>> Although I wonder if we can just give device_unregister() to devm_add_action_or_reset() directly. 
>>
> 
> No because the action callback takes void * and device_unregister() takes
> a struct device *.

Ah right! I knew there was a reason for the wrapper....
> 
> Ira
> 
> [snip]
