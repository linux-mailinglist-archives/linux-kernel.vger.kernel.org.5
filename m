Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42097EE29F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345306AbjKPOUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbjKPOUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:20:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7991E19E;
        Thu, 16 Nov 2023 06:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700144431; x=1731680431;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YYF/NXoCIUhEWAqLIBohpiwdeU5eKoP6V9xD7Bpgzow=;
  b=JHbIz5/H3HrfqNcKA5C7OON3+6An5RNhHHx/m+FJIoWaPZ2A+nR+CdM3
   mspshwQSfKQfUZHoDQEEPE0cGybEGFGhoetoh4QIXW6T/shS40mkeukhq
   X6TAmTuUqWXMWGpDMuPZIR3tCQnViiKeBKam4BYrFHuq2UdARfLL12u3s
   WfxLhMfjY/fXSJ5ASi18I77EWxbclg6Dwokf3ncyUL7qzJGXCk2gUtOYn
   j9i6I6RXe7DTx4qTNY/Bawf+8osUNGiU3mMkGzkmvw4qfYkO1zpLvLKdh
   Pc5VrOZj5ZjllJI0VbTTk+1IIyoG0pD2V288kj5v4iHvkDVnYnPBSmJZu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="4177645"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="4177645"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 06:20:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="888929142"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="888929142"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 06:20:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 06:20:30 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 06:20:29 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 06:20:23 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 06:20:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cs9bi9CyarWzfbWZC+PExcSrHOCwI0raF2ftzK3RYEjpzQ0Grk8EnZdrZjtqRJjggjMp3CcLRtlVMez+5pR4v2djIaNjphaH5wAM2NJ559e/qQaAjaD7rL8ieEil0QmtFUElq/raRG1advAi4/ulr1YaAS8x5XRwron6nzVhzH+IML5h/fRWdOJxwboIxRctWYVdQDVZuV8Cru6iKSw7YobkexRFifF8RBDaKkXd2H/+A01VWFYffWDNaVN41UHZgm4lM+YOcjop81zKt7EKQ/h06VmN8SnAiu7F6wmX0CrU7435RGyMRWxEpv3sxf3NKZHU2Am4DaBrHYdLGvyHFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teNS9vKUjGSoSymy+cmuaFdHdTSbeU9CRDK4MJxe5oU=;
 b=E0FVem+msPRgmeNsT+t8Tqcfmj0/ljsDvYSm5x27EY9GibWlf3DSE9wBfgjsgyV6fXk2Xk6d1Qi0R6zg2OnL/SpscoQXaL79JKUgdohSUGYfQAxcw3TMd/M7JlA0ekttllmM2cE3VR6CLHSqFQwltJtozc1blk6e9gC0TNOsmxz/AlYUWMA9f7eJWA044ZuY31mOjMPlJ/p3lqnz6SEUSIw9A2dYfm/scCEHdQgUmzrc+vRNALMAua12irC/bzhZr6/B41h/q605/5Fif6BVfqFn/I1N0bKw3kQiFWDmMeUZC92K2GGqUmgaZbE1f0/Wf1FFfOe3R/g7a3ETkadwKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DS0PR11MB7457.namprd11.prod.outlook.com (2603:10b6:8:140::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Thu, 16 Nov
 2023 14:20:19 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 14:20:19 +0000
Message-ID: <c7e48800-3cea-44f8-af7d-9172f0dd58e5@intel.com>
Date:   Thu, 16 Nov 2023 15:20:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 5/5] i40e: Remove VEB recursion
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>, <mschmidt@redhat.com>
References: <20231113125856.346047-1-ivecera@redhat.com>
 <20231113125856.346047-6-ivecera@redhat.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231113125856.346047-6-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::19) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DS0PR11MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: 083dff62-2dc8-4057-a5df-08dbe6af2953
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0kIZjIaqehfC+hnJK73h3st1qlFyrRf4qUu9KkH0pBfm7Iwh89sOhffeERS3M4o5T7b6a0Mv9Jy3JBRmQwgqVBnzhbjXt5YUqbIdZc0uTwJtHslhIHeuvz1issr0H4wZ2jg5bPqqIXehcFvExFP//YUYAI8SHpmZz4d8yU5quZ38NbWvayoGjWkk+wcZpa8ntV0ygLRWeHdbfL3N2SM276V3uwQTlfhebHv30++XrlMHLlBBGnMicW7+qXhXSNzH6KtByeWmy+l6cQLwbUXFu9cKtRJaM0VLh8y/2IfozlfPWJPkRJ/jPQTfj6BxU5MDecZXJFIop1obDIHFHcCV398ox9FdxuMP8lrqwX6tWSCDFlZJp8+TTBp3yHl8mgjZ44TueUPFqKtyBxQPTSYzy+xCsdwFBK0C5ErSNvyU5KEpBFWbMBk4GyVhFPtTxvYsN7uzLdyF08CQQywB5oswmCd+oSDEFLrbUkXHEREVoe7ZRV0M0OROUt9womAq93kxLO409YyQAwTRG/ZiacC4SpmbW43YuP3TBAJkJ9l0jdUuKVz1DwT1tewk8mJFsdthBIC3+CnOHgjwCvWvTivvRIOsEfGqdtWgp2OTEHN2nwkB99pqmUAy9It2O3wclI6+TIeQ8TAh57TotPfW7R7nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(41300700001)(8676002)(4326008)(316002)(8936002)(83380400001)(26005)(82960400001)(38100700002)(31686004)(36756003)(2616005)(6512007)(53546011)(6506007)(6666004)(7416002)(2906002)(6486002)(478600001)(31696002)(5660300002)(30864003)(66556008)(44832011)(66476007)(86362001)(66946007)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXNaNTZOMkl0TStSVGRxWlBPYkFKL0hrNDg0SGxpQzN4aldIRG5LbkxHc1ZW?=
 =?utf-8?B?RGM3VWF2SE9DclRmalc1UlJCZ3FKL1RmbEIrRGFZLzY3Qk41RHNOUC9ibTJt?=
 =?utf-8?B?YURvTFBNeVpYUkZ0Q0lQdzhaaU9uSUswL0FTQ3ZLK2dLdGJUVFBPeDdtajFx?=
 =?utf-8?B?Q3JTQnVmdUttNHFDV1IxZXRwTXlBbjI2dTFkMVFDNG9RUk41NHZ4Q1BybTZi?=
 =?utf-8?B?SWVCeHRCTnVHL3ZmY1JOc0hxMjQwQ29VK3diUGV6WGhBTjRIYTVzR0RRWGxi?=
 =?utf-8?B?VnRQZm85eE5KTzV6RExpaXhPY2NWYVk0M29jbHQ4MVpHMVFLWXYyYnQ3cjdI?=
 =?utf-8?B?WVZWSkFxWkRUS1pGczVab1NVOHF4dFFXS1lTR2dPUnorUDBaSldUVm1KUThj?=
 =?utf-8?B?WFlUa0dpRVllODVYV0ZxS3o4TG5pWWdlV2dSbGcydGxZWXlYUXJzQ095QXNO?=
 =?utf-8?B?NlladE93WjJtOWNkMzdiaXhXUUtXTXU4MTJ1TE5PTU96TC9SY2M2UTBSSzkx?=
 =?utf-8?B?anBFRnhlaHhhZkhFNzhjRWpuU0lyL3NESnhqeTA2WDBtSFJKR1dIemdNZ3p2?=
 =?utf-8?B?bFRqTStGNXo0WWJ5Y3FCejhwV3BoY2tzOC9kWU5jcFd4bTJPRGVLY3NQVExZ?=
 =?utf-8?B?NVRvbDBDVjNuSFp1NGRvZmJCRTJCRGlML2JVeTJnZEEyOXdCSlZiZHNGVlB6?=
 =?utf-8?B?c3VBOExhUU9LTFVaSE1EYkFyVXdTQ3JNR3FJRDQwYWw2UG94N1FURGpLTlcr?=
 =?utf-8?B?SzZQMTZJTGhNT3djRm9oVlM0WHl6cDVyejB1Qjd4ckdWSS9wclkxU3dZcWtw?=
 =?utf-8?B?YXNmRFNuZ3FnbWJvZjBqampqQThpRS9XdXVyVHlURkZFbnZVczBac2lDTXZH?=
 =?utf-8?B?RnV1THNYdHF6bnk2eWtMbE9vOFBib3k2Z2VQWk11V1RHWEVyMW5rK0U4TjRK?=
 =?utf-8?B?TWxIM3NDa1BiNTBQa1p0ZDVaWjF6eXEvekh5ZW1CODhSV2E3Y0dtSVRHZzU0?=
 =?utf-8?B?aVc1cE1pSTBDVzhkQ3JQbHZXMXQ2eXJsUkJmL0JaM2hBNGtRT1ZEazFJZEdF?=
 =?utf-8?B?QTB1SVAvRWtUUXFOOTFNUDZBaHpLVVZWcXppZUw2VEVoZzNUMDFxTDlhMTBu?=
 =?utf-8?B?VjJaUzJiSEFSQmJCT0hPZXJaS1JJOFlJV2hIenJKSE9QQTRWMHdob2w2Y2g3?=
 =?utf-8?B?b3J3ZDZNVGFZQ0tXcm82NUVkR0xDbmRyMFBGRHovcjhPWStpTml1MmpwMHhC?=
 =?utf-8?B?Tis2NWhvbjRYeHhVeHZ6TG9qemw4aGJTTlR5QVMyMjlYNFFYaVExMjN5KzNO?=
 =?utf-8?B?a3pnaFNWd29KekorK3FzZWQvOEVheFJONFVlRm5OKytIcnYzRG9WeWhLRVli?=
 =?utf-8?B?dkN3RjI5SVA4aXZZcTFzSm9CNzNUWmsvelRSa1lweGFVMm1WVTBXOTM1K1VG?=
 =?utf-8?B?MitBT0hsVmZkdU56NU8wTkZkckNrMVBycVdDa202Tm9hYjQxL1VIRStTT1Rq?=
 =?utf-8?B?cGZWcmxtY2FjcGZ1dk1RV0k4K3lpa3FpaFlJOG9TWVVReEFabkYzdm5TMytm?=
 =?utf-8?B?cWcrcnV5UmNHS2hRMW1sRHE3Nk1sWnJEMitrcTF5eFd5dnNsNkVkQXUvWEVz?=
 =?utf-8?B?d2IxMjJiajNWYllNSzB1Q0crSXRCR3Q5Nmc1RGtjd01selVYR2lza0ZxOWRl?=
 =?utf-8?B?M0NmQUFRU1V3cGphSHAzWEVpbmg5Yy9vRmkrVEZoUStGRGpGSmo1L3lOSEIw?=
 =?utf-8?B?MUEzVmlSRCtVU2dhS2hBcUM5Z0FzTS9mTWR5NDk5cksweE5xMGg1emZJc1VG?=
 =?utf-8?B?L3VOeXNVbWZOWGVBRHIvSWVQSlRPbXBXbVYzdlZrNHJRYnpKbGZZbzNNdFVR?=
 =?utf-8?B?UG1jOU54WVNSUDBFNXZvYXR0K1ZCeU95dDBMUVN1aGVkeEsvaXdsZVIrM3Iw?=
 =?utf-8?B?K1VGT1FReGdWbElVa3JoQkoxTW1OTXJieVBpY1paKzJBN0pPT2kyRjZrdkFE?=
 =?utf-8?B?VWZ6UEl2eEdBWHQ4ZmRLUHFvbFB4NDhNQmlwN25nY2lTUS9wM0kwb1psd1Iv?=
 =?utf-8?B?WXZNMkJWNTBWYzNGK3U3SUtjby9aeUFuWmFaTzdaSXQyaTRkUXZ6UnZMTGVP?=
 =?utf-8?B?aHVwUXQycHVDM040NUp4M3JYdVY2OURiekdrS3V5TzcrYXdNcTd4YXVLTVpy?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 083dff62-2dc8-4057-a5df-08dbe6af2953
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 14:20:19.2692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30DOkpcWBkxb3x14NeFrGROFXamWM1lBo1M/96Jmt82JRXcdBRmzviLiLb7sZppwlD39uylwXqonlpM7kolamV1LobCQMt2RYoF5l6ToNDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7457
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.11.2023 13:58, Ivan Vecera wrote:
> The VEB (virtual embedded switch) as a switch element can be
> connected according datasheet though its uplink to:
> - Physical port
> - Port Virtualizer (not used directly by i40e driver but can
>   be present in MFP mode where the physical port is shared
>   between PFs)
> - No uplink (aka floating VEB)
> 
> But VEB uplink cannot be connected to another VEB and any attempt
> to do so results in:
> 
> "i40e 0000:02:00.0: couldn't add VEB, err -EIO aq_err I40E_AQ_RC_ENOENT"
> 
> that indicates "the uplink SEID does not point to valid element".
> 
> Remove this logic from the driver code this way:
> 
> 1) For debugfs only allow to build floating VEB (uplink_seid == 0)
>    or main VEB (uplink_seid == mac_seid)
> 2) Do not recurse in i40e_veb_link_event() as no VEB cannot have
>    sub-VEBs
> 3) Ditto for i40e_veb_rebuild() + simplify the function as we know
>    that the VEB for rebuild can be only the main LAN VEB or some
>    of the floating VEBs
> 4) In i40e_rebuild() there is no need to check veb->uplink_seid
>    as the possible ones are 0 and MAC SEID
> 5) In i40e_vsi_release() do not take into account VEBs whose
>    uplink is another VEB as this is not possible
> 6) Remove veb_idx field from i40e_veb as a VEB cannot have
>    sub-VEBs
> 
> Tested using i40e debugfs interface:
> 1) Initial state
> [root@cnb-03 net-next]# CMD="/sys/kernel/debug/i40e/0000:02:00.0/command"
> [root@cnb-03 net-next]# echo dump switch > $CMD
> [root@cnb-03 net-next]# dmesg -c
> [   98.440641] i40e 0000:02:00.0: header: 3 reported 3 total
> [   98.446053] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
> [   98.452593] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
> [   98.458856] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
> 
> 2) Add floating VEB
> [root@cnb-03 net-next]# echo add relay > $CMD
> [root@cnb-03 net-next]# dmesg -c
> [  122.745630] i40e 0000:02:00.0: added relay 162
> [root@cnb-03 net-next]# echo dump switch > $CMD
> [root@cnb-03 net-next]# dmesg -c
> [  136.650049] i40e 0000:02:00.0: header: 4 reported 4 total
> [  136.655466] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
> [  136.661994] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
> [  136.668264] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
> [  136.674787] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0
> 
> 3) Add VMDQ2 VSI to this new VEB
> [root@cnb-03 net-next]# dmesg -c
> [  168.351763] i40e 0000:02:00.0: added VSI 394 to relay 162
> [  168.374652] enp2s0f0np0v0: NIC Link is Up, 40 Gbps Full Duplex, Flow Control: None
> [root@cnb-03 net-next]# echo dump switch > $CMD
> [root@cnb-03 net-next]# dmesg -c
> [  195.683204] i40e 0000:02:00.0: header: 5 reported 5 total
> [  195.688611] i40e 0000:02:00.0: type=19 seid=394 uplink=162 downlink=16
> [  195.695143] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0
> [  195.701410] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
> [  195.707935] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
> [  195.714201] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
> 
> 4) Try to delete the VEB
> [root@cnb-03 net-next]# echo del relay 162 > $CMD
> [root@cnb-03 net-next]# dmesg -c
> [  239.260901] i40e 0000:02:00.0: deleting relay 162
> [  239.265621] i40e 0000:02:00.0: can't remove VEB 162 with 1 VSIs left
> 
> 5) Do PF reset and check switch status after rebuild
> [root@cnb-03 net-next]# echo pfr > $CMD
> [root@cnb-03 net-next]# echo dump switch > $CMD
> [root@cnb-03 net-next]# dmesg -c
> ...
> [  272.333655] i40e 0000:02:00.0: header: 5 reported 5 total
> [  272.339066] i40e 0000:02:00.0: type=19 seid=394 uplink=162 downlink=16
> [  272.345599] i40e 0000:02:00.0: type=17 seid=162 uplink=0 downlink=0
> [  272.351862] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
> [  272.358387] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
> [  272.364654] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
> 
> 6) Delete VSI and delete VEB
> [  297.199116] i40e 0000:02:00.0: deleting VSI 394
> [  299.807580] i40e 0000:02:00.0: deleting relay 162
> [  309.767905] i40e 0000:02:00.0: header: 3 reported 3 total
> [  309.773318] i40e 0000:02:00.0: type=19 seid=392 uplink=160 downlink=16
> [  309.779845] i40e 0000:02:00.0: type=17 seid=160 uplink=2 downlink=0
> [  309.786111] i40e 0000:02:00.0: type=19 seid=390 uplink=160 downlink=16
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/intel/i40e/i40e.h        |   1 -
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    |   8 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 176 ++++++++----------
>  3 files changed, 76 insertions(+), 109 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index 220b5ce31519..ae955d4f7bca 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -783,7 +783,6 @@ struct i40e_new_mac_filter {
>  struct i40e_veb {
>  	struct i40e_pf *pf;
>  	u16 idx;
> -	u16 veb_idx;		/* index of VEB parent */
>  	u16 seid;
>  	u16 uplink_seid;
>  	u16 stats_idx;		/* index of VEB parent */
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> index b2e3bde8ae1d..9dc52b2f0715 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> @@ -683,9 +683,8 @@ static void i40e_dbg_dump_veb_seid(struct i40e_pf *pf, int seid)
>  		return;
>  	}
>  	dev_info(&pf->pdev->dev,
> -		 "veb idx=%d,%d stats_ic=%d  seid=%d uplink=%d mode=%s\n",
> -		 veb->idx, veb->veb_idx, veb->stats_idx, veb->seid,
> -		 veb->uplink_seid,
> +		 "veb idx=%d stats_ic=%d  seid=%d uplink=%d mode=%s\n",
> +		 veb->idx, veb->stats_idx, veb->seid, veb->uplink_seid,
>  		 veb->bridge_mode == BRIDGE_MODE_VEPA ? "VEPA" : "VEB");
>  	i40e_dbg_dump_eth_stats(pf, &veb->stats);
>  }
> @@ -848,8 +847,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
>  			goto command_write_done;
>  		}
>  
> -		veb = i40e_veb_get_by_seid(pf, uplink_seid);
> -		if (!veb && uplink_seid != 0 && uplink_seid != pf->mac_seid) {
> +		if (uplink_seid != 0 && uplink_seid != pf->mac_seid) {
>  			dev_info(&pf->pdev->dev,
>  				 "add relay: relay uplink %d not found\n",
>  				 uplink_seid);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 6ae1206e1c1c..8bcca758e589 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -9871,7 +9871,6 @@ static void i40e_vsi_link_event(struct i40e_vsi *vsi, bool link_up)
>   **/
>  static void i40e_veb_link_event(struct i40e_veb *veb, bool link_up)
>  {
> -	struct i40e_veb *veb_it;
>  	struct i40e_vsi *vsi;
>  	struct i40e_pf *pf;
>  	int i;
> @@ -9880,12 +9879,7 @@ static void i40e_veb_link_event(struct i40e_veb *veb, bool link_up)
>  		return;
>  	pf = veb->pf;
>  
> -	/* depth first... */
> -	i40e_pf_for_each_veb(pf, i, veb_it)
> -		if (veb_it->uplink_seid == veb->seid)
> -			i40e_veb_link_event(veb_it, link_up);
> -
> -	/* ... now the local VSIs */
> +	/* Send link event to contained VSIs */
>  	i40e_pf_for_each_vsi(pf, i, vsi)
>  		if (vsi->uplink_seid == veb->seid)
>  			i40e_vsi_link_event(vsi, link_up);
> @@ -10363,56 +10357,57 @@ static void i40e_config_bridge_mode(struct i40e_veb *veb)
>  }
>  
>  /**
> - * i40e_reconstitute_veb - rebuild the VEB and anything connected to it
> + * i40e_reconstitute_veb - rebuild the VEB and VSIs connected to it
>   * @veb: pointer to the VEB instance
>   *
> - * This is a recursive function that first builds the attached VSIs then
> - * recurses in to build the next layer of VEB.  We track the connections
> - * through our own index numbers because the seid's from the HW could
> - * change across the reset.
> + * This is a function that builds the attached VSIs. We track the connections
> + * through our own index numbers because the seid's from the HW could change
> + * across the reset.
>   **/
>  static int i40e_reconstitute_veb(struct i40e_veb *veb)
>  {
>  	struct i40e_vsi *ctl_vsi = NULL;
>  	struct i40e_pf *pf = veb->pf;
> -	struct i40e_veb *veb_it;
>  	struct i40e_vsi *vsi;
>  	int v, ret;
>  
> -	if (veb->uplink_seid) {
> -		/* Look for VSI that owns this VEB, temporarily attached to base VEB */
> -		i40e_pf_for_each_vsi(pf, v, vsi)
> -			if (vsi->veb_idx == veb->idx &&
> -			    vsi->flags & I40E_VSI_FLAG_VEB_OWNER) {
> -				ctl_vsi = vsi;
> -				break;
> -			}
> +	/* As we do not maintain PV (port virtualizer) switch element then
> +	 * there can be only one non-floating VEB that have uplink to MAC SEID
> +	 * and its control VSI is the main one.
> +	 */
> +	if (WARN_ON(veb->uplink_seid && veb->uplink_seid != pf->mac_seid)) {
> +		dev_err(&pf->pdev->dev,
> +			"Invalid uplink SEID for VEB %d\n", veb->idx);
> +		return -ENOENT;
> +	}
>  
> -		if (!ctl_vsi) {
> -			dev_info(&pf->pdev->dev,
> -				 "missing owner VSI for veb_idx %d\n",
> -				 veb->idx);
> -			ret = -ENOENT;
> -			goto end_reconstitute;
> +	if (veb->uplink_seid == pf->mac_seid) {
> +		/* Check that the LAN VSI has VEB owning flag set */
> +		ctl_vsi = pf->vsi[pf->lan_vsi];
> +
> +		if (WARN_ON(ctl_vsi->veb_idx != veb->idx ||
> +			    !(ctl_vsi->flags & I40E_VSI_FLAG_VEB_OWNER))) {
> +			dev_err(&pf->pdev->dev,
> +				"Invalid control VSI for VEB %d\n", veb->idx);
> +			return -ENOENT;
>  		}
> -		if (ctl_vsi != pf->vsi[pf->lan_vsi])
> -			ctl_vsi->uplink_seid =
> -				pf->vsi[pf->lan_vsi]->uplink_seid;
>  
> +		/* Add the control VSI to switch */
>  		ret = i40e_add_vsi(ctl_vsi);
>  		if (ret) {
> -			dev_info(&pf->pdev->dev,
> -				 "rebuild of veb_idx %d owner VSI failed: %d\n",
> -				 veb->idx, ret);
> -			goto end_reconstitute;
> +			dev_err(&pf->pdev->dev,
> +				"Rebuild of owner VSI for VEB %d failed: %d\n",
> +				veb->idx, ret);
> +			return ret;
>  		}
> +
>  		i40e_vsi_reset_stats(ctl_vsi);
>  	}
>  
>  	/* create the VEB in the switch and move the VSI onto the VEB */
>  	ret = i40e_add_veb(veb, ctl_vsi);
>  	if (ret)
> -		goto end_reconstitute;
> +		return ret;
>  
>  	if (veb->uplink_seid) {
>  		if (test_bit(I40E_FLAG_VEB_MODE_ENA, pf->flags))
> @@ -10434,23 +10429,12 @@ static int i40e_reconstitute_veb(struct i40e_veb *veb)
>  				dev_info(&pf->pdev->dev,
>  					 "rebuild of vsi_idx %d failed: %d\n",
>  					 v, ret);
> -				goto end_reconstitute;
> +				return ret;
>  			}
>  			i40e_vsi_reset_stats(vsi);
>  		}
>  	}
>  
> -	/* create any VEBs attached to this VEB - RECURSION */
> -	i40e_pf_for_each_veb(pf, v, veb_it) {
> -		if (veb_it->veb_idx == veb->idx) {
> -			veb_it->uplink_seid = veb->seid;
> -			ret = i40e_reconstitute_veb(veb_it);
> -			if (ret)
> -				break;
> -		}
> -	}
> -
> -end_reconstitute:
>  	return ret;
>  }
>  
> @@ -10990,31 +10974,29 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
>  	 */
>  	if (vsi->uplink_seid != pf->mac_seid) {
>  		dev_dbg(&pf->pdev->dev, "attempting to rebuild switch\n");
> -		/* find the one VEB connected to the MAC, and find orphans */
> +
> +		/* Rebuild VEBs */
>  		i40e_pf_for_each_veb(pf, v, veb) {
> -			if (veb->uplink_seid == pf->mac_seid ||
> -			    veb->uplink_seid == 0) {
> -				ret = i40e_reconstitute_veb(veb);
> -				if (!ret)
> -					continue;
> -
> -				/* If Main VEB failed, we're in deep doodoo,
> -				 * so give up rebuilding the switch and set up
> -				 * for minimal rebuild of PF VSI.
> -				 * If orphan failed, we'll report the error
> -				 * but try to keep going.
> -				 */
> -				if (veb->uplink_seid == pf->mac_seid) {
> -					dev_info(&pf->pdev->dev,
> -						 "rebuild of switch failed: %d, will try to set up simple PF connection\n",
> -						 ret);
> -					vsi->uplink_seid = pf->mac_seid;
> -					break;
> -				} else if (veb->uplink_seid == 0) {
> -					dev_info(&pf->pdev->dev,
> -						 "rebuild of orphan VEB failed: %d\n",
> -						 ret);
> -				}
> +			ret = i40e_reconstitute_veb(veb);
> +			if (!ret)
> +				continue;
> +
> +			/* If Main VEB failed, we're in deep doodoo,
> +			 * so give up rebuilding the switch and set up
> +			 * for minimal rebuild of PF VSI.
> +			 * If orphan failed, we'll report the error
> +			 * but try to keep going.
> +			 */
> +			if (veb->uplink_seid == pf->mac_seid) {
> +				dev_info(&pf->pdev->dev,
> +					 "rebuild of switch failed: %d, will try to set up simple PF connection\n",
> +					 ret);
> +				vsi->uplink_seid = pf->mac_seid;
> +				break;
> +			} else if (veb->uplink_seid == 0) {
> +				dev_info(&pf->pdev->dev,
> +					 "rebuild of orphan VEB failed: %d\n",
> +					 ret);
>  			}
>  		}
>  	}
> @@ -14138,9 +14120,9 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
>   **/
>  int i40e_vsi_release(struct i40e_vsi *vsi)
>  {
> -	struct i40e_veb *veb, *veb_it;
>  	struct i40e_mac_filter *f;
>  	struct hlist_node *h;
> +	struct i40e_veb *veb;
>  	struct i40e_pf *pf;
>  	u16 uplink_seid;
>  	int i, n, bkt;
> @@ -14204,27 +14186,28 @@ int i40e_vsi_release(struct i40e_vsi *vsi)
>  
>  	/* If this was the last thing on the VEB, except for the
>  	 * controlling VSI, remove the VEB, which puts the controlling
> -	 * VSI onto the next level down in the switch.
> +	 * VSI onto the uplink port.
>  	 *
>  	 * Well, okay, there's one more exception here: don't remove
> -	 * the orphan VEBs yet.  We'll wait for an explicit remove request
> +	 * the floating VEBs yet.  We'll wait for an explicit remove request
>  	 * from up the network stack.
>  	 */
> -	n = 0;
> -	i40e_pf_for_each_vsi(pf, i, vsi)
> -		if (vsi->uplink_seid == uplink_seid &&
> -		    (vsi->flags & I40E_VSI_FLAG_VEB_OWNER) == 0)
> -			n++;      /* count the VSIs */
> +	veb = i40e_veb_get_by_seid(pf, uplink_seid);
> +	if (veb && veb->uplink_seid) {
> +		n = 0;
> +
> +		/* Count non-controlling VSIs present on  the VEB */
> +		i40e_pf_for_each_vsi(pf, i, vsi)
> +			if (vsi->uplink_seid == uplink_seid &&
> +			    (vsi->flags & I40E_VSI_FLAG_VEB_OWNER) == 0)
> +				n++;
>  
> -	veb = NULL;
> -	i40e_pf_for_each_veb(pf, i, veb_it) {
> -		if (veb_it->uplink_seid == uplink_seid)
> -			n++;     /* count the VEBs */
> -		if (veb_it->seid == uplink_seid)
> -			veb = veb_it;
> +		/* If there is no VSI except the control one then release
> +		 * the VEB and put the control VSI onto VEB uplink.
> +		 */
> +		if (!n)
> +			i40e_veb_release(veb);
>  	}
> -	if (n == 0 && veb && veb->uplink_seid != 0)
> -		i40e_veb_release(veb);
>  
>  	return 0;
>  }
> @@ -14738,14 +14721,11 @@ void i40e_veb_release(struct i40e_veb *veb)
>  		return;
>  	}
>  
> -	/* For regular VEB move the owner VSI to uplink VEB */
> +	/* For regular VEB move the owner VSI to uplink port */
>  	if (veb->uplink_seid) {
>  		vsi->flags &= ~I40E_VSI_FLAG_VEB_OWNER;
>  		vsi->uplink_seid = veb->uplink_seid;
> -		if (veb->uplink_seid == pf->mac_seid)
> -			vsi->veb_idx = I40E_NO_VEB;
> -		else
> -			vsi->veb_idx = veb->veb_idx;
> +		vsi->veb_idx = I40E_NO_VEB;
>  	}
>  
>  	i40e_aq_delete_element(&pf->hw, veb->seid, NULL);
> @@ -14825,8 +14805,8 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
>  				u16 uplink_seid, u16 vsi_seid,
>  				u8 enabled_tc)
>  {
> -	struct i40e_veb *veb, *uplink_veb = NULL;
>  	struct i40e_vsi *vsi = NULL;
> +	struct i40e_veb *veb;
>  	int veb_idx;
>  	int ret;
>  
> @@ -14848,14 +14828,6 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
>  			return NULL;
>  		}
>  	}
> -	if (uplink_seid && uplink_seid != pf->mac_seid) {
> -		uplink_veb = i40e_veb_get_by_seid(pf, uplink_seid);
> -		if (!uplink_veb) {
> -			dev_info(&pf->pdev->dev,
> -				 "uplink seid %d not found\n", uplink_seid);
> -			return NULL;
> -		}
> -	}
>  
>  	/* get veb sw struct */
>  	veb_idx = i40e_veb_mem_alloc(pf);
> @@ -14864,7 +14836,6 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
>  	veb = pf->veb[veb_idx];
>  	veb->flags = flags;
>  	veb->uplink_seid = uplink_seid;
> -	veb->veb_idx = (uplink_veb ? uplink_veb->idx : I40E_NO_VEB);
>  	veb->enabled_tc = (enabled_tc ? enabled_tc : 0x1);
>  
>  	/* create the VEB in the switch */
> @@ -14935,7 +14906,6 @@ static void i40e_setup_pf_switch_element(struct i40e_pf *pf,
>  		pf->veb[pf->lan_veb]->seid = seid;
>  		pf->veb[pf->lan_veb]->uplink_seid = pf->mac_seid;
>  		pf->veb[pf->lan_veb]->pf = pf;
> -		pf->veb[pf->lan_veb]->veb_idx = I40E_NO_VEB;
>  		break;
>  	case I40E_SWITCH_ELEMENT_TYPE_VSI:
>  		if (num_reported != 1)
