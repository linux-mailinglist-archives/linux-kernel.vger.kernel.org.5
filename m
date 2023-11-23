Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69357F5C72
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344678AbjKWKfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjKWKfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:35:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E50D4F;
        Thu, 23 Nov 2023 02:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700735757; x=1732271757;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=wWXHoVQcals/YCBw84jVw6ynb1Vu6xLviw/6HCtx1Ec=;
  b=SFtnHsS6ITspowkpCdYNaBky7tvTZSkbbMxh7yOPfBSO+0NvuEzShWLq
   uZtT15izWb9/kcSpGpWIYdyJAQH7qsirAs+w1TtzZimsytUCm93vz0pDy
   5tCa0wmwExlaQchjk9NKhfOID9HKSXbntvti8BacN2Ewp1Dr5Mkbwznh6
   qF/wEnv+h6aIFCr3cs/bTQsugUxYroPUOp75z6PdhLdBOoL79tWCaC3sQ
   E6M7eXpfs1P2grGi5icprt/wOkQ3YK5ScnuXdLLVaq5NCdmrga6XnaDad
   uANV4mEQA4fAQEDGnwhb0WmRtaujhnruvNANKzW9wDmb3WgNSwnE56L5e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="371596276"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="371596276"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 02:35:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="770954370"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="770954370"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 02:35:56 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 02:35:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 02:35:56 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 02:35:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWUMGpQWRvaL1Leq2UQlDsbRcXCLeIHRt0gswFMkB03WMh8qNptQOos2klyJXWoj6OKYkaHoWCtbgbYP/qw6UfyoP8zenjbkGY9s2qBLTWotRU7ee+uQ4ZlW6FIeY86D38LEYzINFAL3jHE70mnsksAHuL+qlH7PDk98BKwgQk6/elQFfBKju5JJeG8FXDzrEhS1pRIyPbyg1Ddq1ZoBWUVx59QE0LdN1T9YX2PL56SVUlTCzJ+QnluG5sNkrGtT5tMb1u8PpfUnBGX9YiIG+/SjSgR8BH9Kpc9ZXWkPZJM7IzbCmN6bzOkGfNP2BG9UGVpYDZmeisM6LHgbOlK+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXPNcXRJYpiESzB4UWjAnnWTLv1oYBPVw19KVQUkL5U=;
 b=NWK//KuUhofTMLgeF5akouvDhaLW0X5xtQE474Zdic6ijGBT0csi0R6It26/ZRbPY8R4P2wIIRsBydpCpCtWKvNmEHhSYeo6Gjvc28HJxZtvZOq8kdtzjIdRuxKspG8JWYn0cSgbUhpRvTlXLseCQaYj1iLuPkp6k0A8X77T/3xHDEYP/+bTxKEIeQB/ZifgWcpdSK1Vxr7GSQLNH9BvnTP4ZJnFYlMVqqwWeeLqB7lHpqeqe4yazElQZI3CE7tlVOwvOCDYeUHw72GahQMEwJxU7PR/Gyfo4xHDTMMHHLbl6aUOD0NiA3IEySilps5Wo2Gl5l8GThAJOpUBq07s4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA3PR11MB7436.namprd11.prod.outlook.com (2603:10b6:806:307::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 10:35:48 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 10:35:48 +0000
Message-ID: <613da551-9983-4f98-b8c7-57bc16d68665@intel.com>
Date:   Thu, 23 Nov 2023 11:35:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 2/2] octeontx2-pf: TC flower offload support
 for mirror
Content-Language: en-US
To:     Paolo Abeni <pabeni@redhat.com>, Suman Ghosh <sumang@marvell.com>,
        <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <horms@kernel.org>
References: <20231121094346.3621236-1-sumang@marvell.com>
 <20231121094346.3621236-3-sumang@marvell.com>
 <ee30eaa0-2a1f-4dc6-8e03-c2d993eb159a@intel.com>
 <92d95955f66098ce725729243251beacc2823a81.camel@redhat.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <92d95955f66098ce725729243251beacc2823a81.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::9) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SA3PR11MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cecdb98-ed41-48cc-2813-08dbec0ff536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5KSsXmcRMp+x1e5I6nMxP3ER1E3MubnGWjEfJkjkPYwpq5o+St/6c98vqrzQVZn9ycwYSFuG5yoQzsaK8Mlh7dZ3146hnpAkD8VUMAJSI9HclnrIf7XfsMB6iGUlm1ZVWpUft5Sx3znVzfeYjGVuj3PudRSjXR7CNZpYlAvpWFkxoGt8X+D3kKv3SCKfncYpUxczk8IbVGG6OlslJWbo/s4Nz3/kh51/SVyuhxOGuBOgrTpTmvdQLSR1LaLEkVvE5UT0pk/okse+S/Xs3AKe6gu0m2wXG/acydK8dh6DoB/upBf2fJ7+TXA/YSoLL24rOgetsI5CoO0Zjv3tiqUpFJu/WgMSpYQGIFNEEICiCNZfvD22YWSeQcWnhvymkz3HwtPHK+Rra4FnHosMDWBb6bIeI4khlq122j4IPcVa3uGh4PsBFLuJ5Yb2YuMkvVpToUSme8FO4gBbsiSL0haayBr9v7Tk6qA9TL0pQoO7NzB/Wt3s1LTTqpH0EQ661/olanEA2smXANdVeN0/XXN3Wm+CcVnzNkGzVj5uhRdlSo4hclMibSkghjA/3s3C6UZo5I+YYRr4Kcvqn5hGf+12F6BhXWOAMHBXNZI7DLsJdfuRJ3Afnw6/k3RUg+OqK7LNk6uGqO2aexEASSfdO6o4ekhnpMJagfLBHqQrPPuuR2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(4001150100001)(5660300002)(44832011)(7416002)(4744005)(2906002)(8676002)(41300700001)(8936002)(66556008)(66476007)(316002)(66946007)(110136005)(6666004)(478600001)(6506007)(6486002)(53546011)(31686004)(26005)(2616005)(6512007)(38100700002)(921008)(82960400001)(86362001)(36756003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWwyNWlya2ZTWmIzV1YwSFY5SVpLa25XbzI0Q1J1OVNpeFpKWHM1cnJNUXRM?=
 =?utf-8?B?M1RUWndoWU5NWFJjTmk4anhSaU1MRGZWQzVTQTYyYXBuWkM1MFJQRStNTTRH?=
 =?utf-8?B?TTZySlYzTnVYaTZNTk52WE8xZ3NoV3pJSWFCWmRaUDdQblhkYUFnYSsrbU1J?=
 =?utf-8?B?dkRkcnYwbWZlSTRhWXc1K3pqNWt0c01Cak56UTZpdjMvYWgvMjlPWUxGbzMw?=
 =?utf-8?B?QVRTS3pEcUNxRzJISk1YTHBPOXIydDYrNW5OWXFQRUlydCttU0huc3lVUXB2?=
 =?utf-8?B?QzJpRkc0SENQdW0wTTl6cjJUdVp2YkpheTVvNnhFbnBLcWczYWJqVnFKbEMv?=
 =?utf-8?B?L2I3bWdod2JqaUVrN0Y4OEk4WlZtR3lDR0FMZ0NiSWtUMjU4cUFUeUVOUFRL?=
 =?utf-8?B?YnlEeEdaSjk5TUdlby9uaGUzNXMvMk1ORE5QWWUxYloxZlAwVjZ2c2I2anJk?=
 =?utf-8?B?SlNYenEzUGk0NjVyYVRlMHgwOWZoMlJtMVRCTEpmYmhJVjd0WGV5OVYrcGlp?=
 =?utf-8?B?cVNFQmZ6bVByTkhPY0NzRW5WLzlSdUNJQkVSSytkNFMzM2dIZ1F1eEQ5NFhU?=
 =?utf-8?B?NWZOSEpjajJoSi93bU9nbUFrZFJsQUxzN25DcHpoM1BsZzJ5d1hVQlMwWUJi?=
 =?utf-8?B?cWpLTHdNZ3V4dmFpZzlCN3hJZGp0bEJaazVnQlV2WlRFTEw3M0wvUUViUEZG?=
 =?utf-8?B?U3A5V3dXbFdWQnRtK010Ullld3VUSUZOU0d0RVRGeFk3SThTRG9qUGJUMTVs?=
 =?utf-8?B?RzNqUXQ0SzVBeCtZb3dvKzk0N05kd09kWnIvYzdlWUpnak81VmdDV3lSMUgv?=
 =?utf-8?B?bUhac3NzRy9nQ0YrZGwvUUtOUEp0UUI3eHB3M0w5aUlWSFd6eWlNMGxBcVM1?=
 =?utf-8?B?RXhVblNndVoxVEJYU1B3YU1ZcUVYT3BkNGpGZUZRQmNta2M1SEMrRGNmZFU3?=
 =?utf-8?B?dlRjOVRWWWN3di9tV2hPQ3VuRHh1L2Zkc1NXT0V5K1ZZOGhRM05KZmFJVDFT?=
 =?utf-8?B?M0NaTjNiVXFtQ0g4MEpnTWtXZGhKK1BQNXdkQzIyRDZ6NXBKZkpIc1F5elJo?=
 =?utf-8?B?UURoUE15aUlUZ3ZEbTdJUW1RM1hYV1NkeTVTMmwyZFkreUs5T2JvcXhjMVd6?=
 =?utf-8?B?bS92OUpGbmdJRWdURlBzdUNIdjdZVTkyNmQ4bzZ2YXJJQ0xXVDh6UTRmWWJn?=
 =?utf-8?B?UEtzN3oyczlOand5bUpxaENIRGRFVFVEdUU0Nysrc1dqMUFiSnIzeU9JZGk4?=
 =?utf-8?B?UnpwdXE4bnh4cmF6S2JyM3JyVlZLUEYxYkQ5Um1vUElTQ3cvWnppczdQWVda?=
 =?utf-8?B?dGxPOWlVWWJGSUMrNEVVQXhWVmtyc0wvc1NzcE1KWXNKaktaUzR0cXAyOTRs?=
 =?utf-8?B?Q1VLVlpIbSsvT0s4NGU2cEtMY1krTjYxNFM0dkc1OVNQdkVEaWlTSG9TQVhY?=
 =?utf-8?B?bGhqRWlQRFkvYXVheW5MS3FNRXJyY3RzVDhFT0VnR2dmWnNmbHVyU3ZyWW95?=
 =?utf-8?B?Y2cxcC9pd0FlQmRsdmRVS3NFbzZoVEppQVo3V0xXTnlzV09uZExYa2xVaWRK?=
 =?utf-8?B?SFQySGZ2YTFNL3R1ZFQzMVl5T2d2bXFTZ2NjbFl0RHRZSUJnazhSZkoxT2kr?=
 =?utf-8?B?KzVKa0tMNE5vRWFNU2owWjc5eUt2NTBBbVpOWmdxa2ZFTTNMNXhDWVcrVkI4?=
 =?utf-8?B?WkQ0WDJ5bjV2c0V1QXByZ3lvN1NUQmpCUHhDQjlnazZCVy80SGlHMHRqcGNr?=
 =?utf-8?B?cG11QlhyZVVqbThkUTJHSytMTHExaURXNDF5Ukg3RlRuMkFYekVoQjdwS2Ri?=
 =?utf-8?B?MzVWVzRWUHg4SkNrVXllOHhmZk1SY3lPZUp4S2hUYlc5UE9BcmsyTkhIWkFu?=
 =?utf-8?B?c2t0T1RQYUprc0JjMDhiMjlxWTJEelZhQThsWFNZY2puYVpSQWEzSXc4Kytn?=
 =?utf-8?B?Y1JTREJHbmhtYStUZUt1RkJib1ZPVzVid3dJYXNPVEZBenM1TFM4MWRaMFdR?=
 =?utf-8?B?c2RCbEhmRHFpc0tycCtONWF4Q2ZjMlRPamtDZk1BSEFxNVNCelBva3g2eEVK?=
 =?utf-8?B?bXNCeWZQTzNpYlc0dVB3MUhsaXRnWlRSRitqcXNpVllVVUsycjA0Y2k2ZU5P?=
 =?utf-8?B?aDVRdkpNWWRSc1d3U0ZjYWJDdzl5ZGNqWnRSekRNZEl0TXV6OUpJZFZZMnFj?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cecdb98-ed41-48cc-2813-08dbec0ff536
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 10:35:48.8256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRp84kR2oZGSjndbr3MxTcsYAMQsNIPZ/JOW7ntayrw7tnX8i0QqPklcwA+FN3qiOQrddPNyQJ8kKeJrwI5J5RKk0NQSoXky/k9c57hVtJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7436
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.11.2023 11:21, Paolo Abeni wrote:
> On Tue, 2023-11-21 at 15:48 +0100, Wojciech Drewek wrote:
>>
>> On 21.11.2023 10:43, Suman Ghosh wrote:
>>> This patch extends TC flower offload support for mirroring
>>> ingress/egress traffic to a different PF/VF. Below is an example
>>> command,
>>>
>>> 'tc filter add dev eth1 ingress protocol ip flower src_ip <ip-addr>
>>> skip_sw action mirred ingress mirror dev eth2'
>>>
>>> Signed-off-by: Suman Ghosh <sumang@marvell.com>
>>
>> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> 
> Thank you for your review!
> 
> Please, additionally try to trim away the irrelevant part of the patch
> when replying (in this case almost everything). That helps a lot
> following the discussion, especially on long patches, thanks!

Sure thing.

> 
> @Suman: please retain Wojciech's tag on next revision of this series.
> 
> Cheers,
> 
> Paolo
> 
