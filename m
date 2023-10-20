Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673277D1803
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjJTVZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjJTVZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:25:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0952A3;
        Fri, 20 Oct 2023 14:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697837115; x=1729373115;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lt4EEq3dCngt4VjJ2Rev5llYwlGDc1dn4gqvqp+j+aw=;
  b=HGKBTxAI8lIHrGrmIvLgqnTztQY/QlgeR1OE92dv9kYa/d2WS4gcje2h
   6ojx1FAHuvNqPEoK8coL0jrqO+xq4sb/VLR7/3uK41FZZ9K5SdqQvXHHd
   uuYNUz04hzJC8MvLKr/fMyALHju6Z5i80RfPHRXLthL9QbRvNPPbvieOI
   ST4tDGHz8mv7V7es4gtkoKr3g6FMRUoRUfgMyLMaMhOgc7xDbJi3lUZh4
   DI8gELs/Z/Wz/zhYjoGCc87NwbtRU0hVibapdc3fKQnP0HYp6etemVeoB
   TYyHarRbYlFIo2KMhEaGQ54AwVPChQAyLHqbuVY641ohnKKi/pDOnorXp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="366805919"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="366805919"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 14:25:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="1088858176"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="1088858176"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 14:25:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 14:25:03 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 14:25:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 14:25:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 14:25:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMSTPfnDd9mOP6oAQh5cR7+HryKQZ27aZO+hQDgpmrAmppVgrHl6Y6zXqoVHVOPKUR/4fDJ4eoRg35SsrzYRqrhgBMx/Vmu6m1SbGn8BMlUX1H5yfSsw7qA7eLJXM7DsJay3ZCZ6P2DsnJSRf8sSyBVoeJZJGskbkWNMEZDOTmvLvXh8nCGz/TyHko2Wigtk0BOu4+U78JukFzGjHlkVVoOJlVG0kiXI6UmkAbn4i6FXKP8ytBDEk2BIARnghMEVK5f31Fnp6TJoZ7upBDh/iUBYwXRP2nY38WHNoLtCG2aPxbAgYl5lK6Fsl7T6+/BZEIpRP8VcSmSJAQ3lwr+DNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVkM8ZPfa4UK+w/sp5gkYYF6lNw9QLreHxwMdsONKWA=;
 b=kxehvMFJLEaNQHcx7NX2rjz/4RjBfIYWRYMgTLzNQO1EBSHWmHdMDqvzlMqYitghfnaNLgZAXV/JBYUnQEXD/ckFphbN1ssglRA+8t5ni4rBEVPE79wPgbF3gBjdY7bQ+OtDzK9vUsNPHT1O0Rw9lXb2CWN9WcI1idKGpGuO0ifjdM7S0OwzEQu4QIL5qpqdJ56p7lYOt/UAP42v/MrJ58EivC5gPacVCp6rMCM4PN5/o5lUNL8jzwpoxq96OUHltQdJ2wFVCqdhtrJOat4mvTRvCa/ijMTKCc/pMRzcjfJJeoj+C9gq6TwJt2njmZ/dYjw4OsDD7sL5GtnJXv1vtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 21:25:00 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4%4]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 21:25:00 +0000
Message-ID: <2eadecc9-80d3-4a26-857c-e8c4a455a5ea@intel.com>
Date:   Fri, 20 Oct 2023 14:24:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 2/6] i40e: Remove _t suffix from enum type names
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     <mschmidt@redhat.com>, <dacampbe@redhat.com>, <poros@redhat.com>,
        "Jesse Brandeburg" <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231020193746.2274379-1-ivecera@redhat.com>
 <20231020193746.2274379-2-ivecera@redhat.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231020193746.2274379-2-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:303:85::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW3PR11MB4539:EE_
X-MS-Office365-Filtering-Correlation-Id: 813cc222-5f60-4c44-9a28-08dbd1b30451
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hZNWJUmCgOAXKCHQ8ExFbpi+nq9HJxPNHL1sAaSLrs/oVExHuLa+ix351SGuBLEVLyj94fZufjpJKSFTzA4Vir3ficA5j1rFO1f5N3ETDHoD5mpfUiJQZnokRHE5ZjXgT2U6yPcmkL+GPCm+ULLSBiTEaF9AQx9js++643OBxDXVIgNXBOiADpUHQ4VMs6c5vwLrOearlW0clhgEByr1xR2oi/OhFRkGL0Tqj0by+fbCYHybZIUkEfbeSsLVSYE/zvpZRr8yMrl3bil/I6SCDfYgORJ0hVohEBlv/NPUGTbhHzE6qgJuKK7pWIncUHI7aUVHtD6WAv5Yee/k1QiQ3Lz1eoSvDcVLvekXI1rP/Q6aLLem3Z+idz8/deHLuu8jvZ3mc/KcmbRpB6zUr0E/PTEnBohbi1lul/nPbyGLeHzalrAUz8/ZdUH0Df5gsZo+bQ12aOKK2WNqT1T2DYB6XDvyFeZiU9E+fRxBajQ1YKhJIs0iwXbtbdWkahbDtTB6SE9mcurFvwMbMXVSi4SouDlVfHEv+cuRwaH/LtDzdhWcDCS+Qpr7Vb29egjqnGHZdEvSzZqnpPJbaIeflHqDm44XAbChZMwj14xCYWEyjV9wqOx9NUn6vvFk4Asy//s40a0uThdRKiuqS3PCzKNzlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(66946007)(31696002)(86362001)(41300700001)(66476007)(54906003)(66556008)(316002)(478600001)(5660300002)(82960400001)(6486002)(4326008)(2906002)(36756003)(8676002)(2616005)(38100700002)(53546011)(8936002)(7416002)(6512007)(6506007)(26005)(4744005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXFpck9BV29XU1o1K29reXFGdW1qTkptU0JLWWNmbHZxQlhGeTBUSlNVZFda?=
 =?utf-8?B?ZkpqNXdJaG9GQlN1bEpTazBYek1rbFRRNVpyNGdqS0oxZnR5alBzTEgzZUJP?=
 =?utf-8?B?dlpZN3VIZytydU1jYmxEV0xYS1pEaWY3VEJzaGZsdnlRN05BYk5LdFhaZmtn?=
 =?utf-8?B?d1ptMEp2Kzhza1I2NGRjWDVxTGV1eGN3SVYrK0lhOEJyeVRHeXhkWG5FV0dC?=
 =?utf-8?B?ai96QW9iYWZVVUNJeUxPeWJLdEFtTVVjaW55WjI5RmZkTVBmTUlnSW9NaW5N?=
 =?utf-8?B?WVMvU0lucDdNcjJUR0ZvZStUcTZhbkdFN0xRd2NHb1RDd3MvRXo0VnRvNEYr?=
 =?utf-8?B?VmlwdFZNd0ZYeldjcW04ZHVXdGRhdGo3RGQ5WFhjYXlIN21LVGFYVEU4U1V2?=
 =?utf-8?B?MmljL2FYSmNqRWpBRHByV2I0TkpTRWN4TndGQTVCbE43UVBxaUtLZlRnaVZO?=
 =?utf-8?B?WjZtY2NCUHp1K0hYaXp3QzgwS1V2OFRzSGlRTUNSVi9oMlhXVWtpUGRvUy9G?=
 =?utf-8?B?NnIxMFdqdVRwTkZreXYydkVqbDlpTFEzU1BTLzU5NlJDaHBqajZHS3BiWXdq?=
 =?utf-8?B?WnN3ZEF6bkFZUmoycXZyMXY1Yzk3SG14Skc1YllSL3ptd25WNXJhSVJVeThV?=
 =?utf-8?B?bXJqcW9jYWhOd0ZxTWgzS0lmNkN0R2RGRkVKSjRhaUZLcllmd3MrZ2U2VStR?=
 =?utf-8?B?YTNabVkzaWNaRmd6eUFwYk9wRUhlY29CSDRjK2hlS2tIdmt6SWx3amtScFNN?=
 =?utf-8?B?Z3U3WDMrQllSNmlqS2M4MFZQYTNFaDZ2Zyt3anlrUkFQV0hYOXYzdjJ2eHZE?=
 =?utf-8?B?Q011dXc2UGZDbFBFU3hXNHJpaGlsYU5XOEVBTzR0UXdDN094eW0zb2RJajJs?=
 =?utf-8?B?ckFPb1NoQnp3QlpucE5OUVlkYTBvVldjTXIzeSsvT0RTY3VYSUVJdHBvWnVP?=
 =?utf-8?B?cTlieE5BQ0ZaVHBWOW13Qkh6akNXamJWVlZxdTlPODk1cXlvcmJ1bm43U0w1?=
 =?utf-8?B?K2VGZTdpblhKbjZsVWtnd3pmU0pYSTc2Y2Frd2UyRERMbSswWU5ROTU5aDUy?=
 =?utf-8?B?TUlnandLUUtEc0tQSlg0U2krN1VYNTZSMU40cWZsNU1adzJVdm9FU1djcmpu?=
 =?utf-8?B?azBCRTlwZ3BJY3ZoRkQ0aDJsalozYjQzODY1QVZBcEVzck1GVGw5VmZ3RGZ6?=
 =?utf-8?B?UXlTblFsSkN3SlNkS3RiSENEQnFSU1crS2JvUVk4TDJiekh2UzBNaTk4L3Mv?=
 =?utf-8?B?Z3pVYjZSWHJkUlBmMS8rQnQweEl0dWxpYThwdjNNV0Q1V0ZCSHM4eXJoc01T?=
 =?utf-8?B?aE9qNWh4Znc3T242WTNzRGFaRlJSRzZ1NlQwVnkwZ3lBcXpSd0lJcElZT2Vl?=
 =?utf-8?B?RUFtTW1yQ3kzZlZQdzlCUCtkTU82TktDejc5dE54Vk4rY1VPNld4T1BNUS9C?=
 =?utf-8?B?L2lBQTgyZzFPT3BreWFaOEtqQ2RNQ2hrVW1KTVh5ZTg3bmg5N0VRL01ISC93?=
 =?utf-8?B?ZzIzQWdCWUVaemxONFd6azVIQTBHM1piMFkzOVhsb3B0dkpISEY2a2U3bnU0?=
 =?utf-8?B?R1U5dWlpZUFiVFl1VDkvN2RFNVhqdGhhbldueXVSVlhRMnAzN0xQL251Z3B1?=
 =?utf-8?B?aGkxS0o3ZlNucXF6dnQrRzVIM08xNDZkdUNvYjAxc2t1UEtZYnd3bUpHVmda?=
 =?utf-8?B?L040alZaL3p4ZkJpLzhpaDlVaTF2THI1NEhqdTRXUDlXYWhCTlJQVmRKVDNI?=
 =?utf-8?B?MnppbnBrSVRSOXNEQUh0TWxCYldiOWN3YitobjhuZUY2aTdOdFUvWGozMlZS?=
 =?utf-8?B?WTJLcDRjRzRBa01IRmRTWWkwUkdjdXdwbXNmQ2U0b0x6OXAvaXlIQ0dFdDR1?=
 =?utf-8?B?RkNKUFBXVE12OXdFVkdqNUVaempPb1FQS3lKTk55RlY1N1RMOTlIdjljc0Ev?=
 =?utf-8?B?TSsxb2VWcTZ2aFZnaE9MMUcrU0NXWWM2ZnYwQmYrVFcxcWxJSHYyZ05IUUs3?=
 =?utf-8?B?ZnVDakU1ckpCSjc3QmsxYU9TNThNSVZhVEh2T2hOd3lLbngxbXZ2T2YvNk1w?=
 =?utf-8?B?L3RZOGt4OVdDOTBVdXJhMXNKT1ZiYlhVZnJzeTMxOHBNaEdZR21XOFNhSHRw?=
 =?utf-8?B?Y2llaktNcGJmY1ZsNWlrMytmamxYWVpKazJqRWJuZUhlcGZJdkRRWTRoOWdw?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 813cc222-5f60-4c44-9a28-08dbd1b30451
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 21:25:00.5947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDPDLwZ8s72XVGXFo4gES23GfwDpweA7hK/v/niA6oaBfrp0cnvNvEbXPAz5fLXBJgB6mE79+ohbHel9x83TqKMS+zvVGOzRMAgjUvyreV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4539
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2023 12:37 PM, Ivan Vecera wrote:
> Enum type names should not be suffixed by '_t'. Either to use
> 'typedef enum name name_t' to so plain 'name_t var' instead of
> 'enum name_t var'.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Thanks for fixing this style violation.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
