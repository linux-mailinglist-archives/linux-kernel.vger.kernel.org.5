Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0970C7C7ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 02:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbjJMAHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 20:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjJMAHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 20:07:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623A8CC;
        Thu, 12 Oct 2023 17:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697155660; x=1728691660;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0keT+6mUDCwK8rUaSikAHBtepHC5xa3Bu19UQd6bDuw=;
  b=bFVCWUjkaZlmVHvJhwBsA+IZmqnCwjMG31qO3JshRkPUcwtYTUOuAJsS
   yEd9iYKXS+sQ+v25528Mtb3R788oSxZcoxsSITUC/zErUghFlbithTGed
   P5eTK/bBAdRgk/ghq5CHiHuS8qTYUMJjvKxRzvL6mDuqDf31xSLLpbh+A
   w12fZEwo4JFpKDx9TkCIgG4dVXkCCtg6IScVWRPd8mdj9P03HzZk1J6G0
   P/B8lWn5sdhNFf+DZ70KsBxRgkIUd5+uldApMRVQEvG4CdeHyMakD5cCk
   GZPZZPPM3sSvlFPLOYey+qCahqcfplpZApj4NOIrfcsVVR1bgvCGD/W0z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="3660640"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="3660640"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 17:07:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="878298063"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="878298063"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 17:07:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 17:07:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 17:07:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 17:07:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WK127Ziya2Hk9VrORahPRSilSrO6cLHbRLwYxhiRfmCQuE+NhtTTQPDkPHO5DjqqvtsRx9eT7eKz4FihJlv6eFDvYf7FzHLhy3k9JwlHaMDQz7cUR84Qb+aCElb9sC0PT01ltKLrZJg+o/LfwrsajMb/o/+mgcoyZLgVzYvzdL3uupHnP59PH7uJOfZGVfDw9LiqLzXcjE1HIsNfkMxEY6Y5VHF+qnhpFqS4usqLrpPdMKao+kECgEdzXMfiZGxR4YZ/SfCTIXM27PdYZoFcvaxAuxAOVX5GJ//WHz9SsU9bXueWZj419AvzB68JFWkNakJKPQb+zUPNtPIYrnOpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0keT+6mUDCwK8rUaSikAHBtepHC5xa3Bu19UQd6bDuw=;
 b=ZttcbRJZrZqjndchycw1Mch9jNmBvLfB6ZqEyh3+2bioGBxSflW/55NNUbPdncjhyIMfAt+fr2NUFJNzLDpjx+JU4PMhV2K1waFsx5XraEe1PpTaAkCn0lIDRqjmRhYI+FQvrXgNFRITp9kBR/vvxafcgo/2jBUxQdTrvLQjaRHBmxHsufqjEk8qSBZhifuoc5FtJDy3IifvIOlNyrkLyqKDwgjkyInHfJnAxk//R0PWWvTanhkONJw0wyqcqgfBDetOid2iZfcgAq6ywA4xo/QBqpLDscRlNxx/UrAhpo4bmxFLuFlC9N/nxApKzCj1m/KYAc4mKWmQnQ4R6Z26Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3728.namprd11.prod.outlook.com (2603:10b6:208:f4::21)
 by LV3PR11MB8765.namprd11.prod.outlook.com (2603:10b6:408:21d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 00:07:18 +0000
Received: from MN2PR11MB3728.namprd11.prod.outlook.com
 ([fe80::e4db:e815:f217:9b6]) by MN2PR11MB3728.namprd11.prod.outlook.com
 ([fe80::e4db:e815:f217:9b6%3]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 00:07:17 +0000
Message-ID: <3f743b9e-73f5-49b5-924d-071987e4b95a@intel.com>
Date:   Fri, 13 Oct 2023 08:26:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2] x86/mce: Set PG_hwpoison page flag to avoid the
 capture kernel panic
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
CC:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>,
        <tony.luck@intel.com>, <naoya.horiguchi@nec.com>
References: <20230914030539.1622477-1-zhiquan1.li@intel.com>
 <20231010082836.GDZSULNGto0cPRPU26@fat_crate.local>
 <3f9e9468-ec74-42ad-8d42-c3f6fb8b5f74@intel.com>
 <20231012145708.GIZSgJRIRq8OSF6UaB@fat_crate.local>
From:   Zhiquan Li <zhiquan1.li@intel.com>
In-Reply-To: <20231012145708.GIZSgJRIRq8OSF6UaB@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To MN2PR11MB3728.namprd11.prod.outlook.com (2603:10b6:208:f4::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3728:EE_|LV3PR11MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ea2624-924f-4195-752f-08dbcb805c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KiYmBAY3FfVb3YXYWiPVdXtd83+l0jx0gRI+OnE4HWZG/mx0mHnS0VmZcf+WpGIDEH8oQbwYedkICV/Ljg7ynSRK4wp63omf8cpoT//PluqyslLTyHzdMcUtYJoMK79UiyzAuEmGLAZvOtumS7LzF4WcMNRK35fkJW1o3mj8Pyvc69B/QvyGwfoaNl+Sn1tJzDlJqu+U2rExCg/3Uh56i3Z726Vb7zEPTp/NFz0qR+hD51ZCJQyAYwksWZCIDJQNpc+riO0Pth1s1cAekqV+4zGOANbxwtO64w6aUFrTFM+LsDl7CzUmNyAgdg/exTKalhYeIkCTYMjOQa3bQKNhs8JcBrnW0rvbJb9c1Ia7ktDXnJWrFPpD6WLVyNjoeHGRVlRPkgA2iUFHjj7AiQQ7bNXMTQo9whYnVKFI+tzopMk+8yHcaP4ATiJRst9Q4d9U1Z/qdx8JvKsBWpevYU3LettycFpTo82BLHvWMrVhGysMSehqnHfVLQq51Co9YgCqH+lwHN68WDWJsp1uwVG9+LqidfnOMzYc8tTkLRXsrL7Q/NLSzA8UG1Z6b3iSG0hm33PYITxEiW5LI4aWT2Wst2pOp75KHy+1VAPr1BaA+PjoJhJmZ3dGTA+S8CoOThRHil6rfpOGuuA1gIQH9v0LZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3728.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(31696002)(2906002)(6486002)(478600001)(4744005)(41300700001)(8676002)(4326008)(8936002)(5660300002)(66946007)(66556008)(66476007)(316002)(6916009)(36756003)(26005)(82960400001)(6506007)(31686004)(6512007)(2616005)(53546011)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWZSQ3A1VXVhYjRLUmE2UU90V3RIN0J3TUU4eG9RTGdQZE5JTjFWbzhnWDdP?=
 =?utf-8?B?SHloN1pIR3p0Ny9HbDlJbUZiQ1pPOEw1Q0ZLT1NBTkFXdm9raFdtQ0trQ2RC?=
 =?utf-8?B?UDdIc0pCS3FHTlAvL0s1WTRDTklQQmlwNmV0NXJYaUhRbno0azdTSmg3QU1u?=
 =?utf-8?B?c1E4WXF6OVc0ZXFRWWNGMU5Gc3hnYWZSQ0tNMzJzclJmckdRTlVqcmhtdjUx?=
 =?utf-8?B?UnQxd0tUOXVPU2dQbGdPcWE4d2wwczNWWjdlQU0vOE1RbjhudVB5TGlzQUZn?=
 =?utf-8?B?VzNUYWhEM2lFcm96NzdWSE51VEFTdG5XTXJDK013MWVteU5WZUgxbFNJaXor?=
 =?utf-8?B?WFgxbkpMMnRtM3NDekZuYmwzY2Jrck5qT0FIMWtETkJ1KzdyTGhvYnZaZ3BG?=
 =?utf-8?B?b1RyOFl1a0RXaXFsMUI5NTdKakhMRnRyaGFxaG1td1M4ZjRTcFpNRlFDRGVT?=
 =?utf-8?B?bEpOT2RucmVtMTdsaHZ5R0tSSm9JVVJrZmovQjFPVGpGMUJKbnQrZG55RnlB?=
 =?utf-8?B?TVVqTXU0LzVGYnVCWCtacml1UXZycTlIUmc0OG5TTFNvZ05FYjh3U3V6M0lG?=
 =?utf-8?B?NXNoL3dkeTBQbkNvenFkVVdWdFdZMlFRQ1hrc3F1MjNvOEJCa2FOOE5mWXRG?=
 =?utf-8?B?MWJoZm9rdlZuZHdtTGZDVVZKM1h3TzRhajVPU0oxVkh1cm1HWFNlS3V4UEZt?=
 =?utf-8?B?bjRRRHV2dHU2VFhpOUgvd2ZvK2hnSUJtZGpCQTJ1czh2MHAwTjVVakVZUVZx?=
 =?utf-8?B?WmltcjFuT2RnbURxUy9FcUt6cG92c29sTjlSZ0JhYlNma0wwQ1E1UHo0TGc5?=
 =?utf-8?B?UXVtelVhR2l2ZXJzZUVMZ3lJNE5yczJrYytQanp2cDAyUStvUnVmMEE3TjZD?=
 =?utf-8?B?T0I3bUx3MnArNDFOUXB6RVlLdWpZOERVQ3Z3eUZvVVJsR0JuNStNNlhqbWxq?=
 =?utf-8?B?cWZxV0lwZkpLOURTWm4xWmFjVjFDZlZxL2lRekhodmRDRTJ0cmc2SStnTGNH?=
 =?utf-8?B?SURPeE5aQUdDZ0FETERnNW1FSXAvRzdaTXVRdW43V2RFVGRNeTlRMEZEVW5r?=
 =?utf-8?B?OGlSblRuYk5UT0pVM1hkVjgycU8vYlhHSGkwdEgzVVlsNHgxRnpBRm02RDVa?=
 =?utf-8?B?UkVwZUdRNmY2TUZ2Yy9wUlpRSmNJK3Q2WHd6UDhyN0hQZEhQeUtqMXA0M254?=
 =?utf-8?B?enNKZGxKaVFrcWZ6dWJKVklrZkh0SnUvMHcrWThrWTBaSkRmRTBnTjBHRVVS?=
 =?utf-8?B?REs1dEtMTWt3c0UxTzlPWDhrVzJiUjZDTFFvS1J2RUJUWlc2aU1tZzN5Ump2?=
 =?utf-8?B?U3p2QXNSVCtyT2VicTAxOWJzblBENFF3UC9TVExnbzk3clk2dDY5OHNwZzZF?=
 =?utf-8?B?cFZzMUUrV2JSSWNCcmhUTE5idHpsd3pqMEdmMStLeTBobVRDS0FaWVYzdm1N?=
 =?utf-8?B?SmZZZEpueGErcnFHZUNtNjZNM29JYXlsSVhnNUxpbitOTERnQXdzQlNpNE9N?=
 =?utf-8?B?RnZSQml2WEJSV1ExYXBOUmw0WHRzOXB2NkxKZ3VYbXoxVDByelVYeFpKZnIr?=
 =?utf-8?B?bzBIRnloZ1NzSkQ3ajcvbDZzZTArcnZlUmk4T1pQQXp5QUZ3WkJWMEhUdVVG?=
 =?utf-8?B?eDhGek02TzFTcnpVNnVrblVyMnB4bU5Jd2NJLzRpMC8rTkJUNnlVenExVkxL?=
 =?utf-8?B?VTVtK3prelRRY1JVY2tpV3VSM0xYa2tFRGZkYVZSbWZBM01tb0ozMWpONFN0?=
 =?utf-8?B?WnR6cGRYQ2Z3SERRWDliQ1pJQUFSQmVTZDdnMGhLazQ5ZVVvZjFQODRhVmFi?=
 =?utf-8?B?RlFBZTJoaTZDUURrOUc0TmpmN3ozU1RNQVphaGVVZnQ1c0V2azNUNGNnWURz?=
 =?utf-8?B?SHMzbU9Ocmd3R3REU3BiVlZEOVdGcEREcS9WZFBXNUVSY1pmSEFCbWc3Smpm?=
 =?utf-8?B?cTVZbzVQSnlVUHVWNFpCL0dZOFN2dEdQVEpyZXV1Q2VyV1lIK1Z2bGdGS1Rj?=
 =?utf-8?B?M0xTUGk5YmVRcVVpVXpOaEhMbmF6QUVhWjZGZjF1QTZTQU5nUFZxTVozeURP?=
 =?utf-8?B?dzBtZlE1a0pqVTVuTkR5TjNUYjlCbGN3aWNVaGhwbHVUZUNuNlhyT2VYSS8y?=
 =?utf-8?Q?P3CENsXdlOkXAY9RdNF+cmlhh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ea2624-924f-4195-752f-08dbcb805c12
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3728.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 00:07:16.8117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aP8cPGyV+9lQowgiU8EwPRQNC64IxUHrQQ1yLOaoXt+/VESHqcxI0hAWP+7fSj+Df34rxrG4nR7xOdQmu1wA7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8765
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

On 2023/10/12 22:57, Borislav Petkov wrote:
> Then you should ask Tony whether he wants Co-developed-by:. See
> Documentation/process/submitting-patches.rst for detail. There it is
> also explained what an SOB chain is and how it should look like.

Thanks for your guidance, Boris.

Let me check with him before send V3.

Best Regards,
Zhiquan
