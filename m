Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7A57D183A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345046AbjJTVfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjJTVfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:35:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE00D6C;
        Fri, 20 Oct 2023 14:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697837699; x=1729373699;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pEKT5fMZKPhQfU2CDGzqquwZyq54xtM6iw46y6S9Fps=;
  b=DBtA/HUcaIxtKan17Oh0TVA8aDPM3D7dVOl3OF3nNzLBwArObBkNYE6S
   T6m630rfpWkdI+qNkk7HbhDhu5O+VdUuqLdGA0pBL6Zd5PyQMn6fUYgOT
   S28G0Kz0qBjGhJPp2IhWoG3zyc8VcafHRJC40U6N5j1+GZGIXV7ZnLspA
   UfZ/0cXBCJMNwTfsFAMZz2NQTMpvWaoTej7TSBmLrG9hx5iKeXcZJ2/hE
   vUWMF6O20eubjstdWZlEiAfKiBWPN3i7/W7bfx2jO1BHq+AUdS+0925Tp
   PxaHYApFw0zfWAhheDR/ip3UWR30eoZ6kS5FxjFCJ0WUqEC1hnOhJEcvi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="450807347"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="450807347"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 14:34:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="751053950"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="751053950"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 14:34:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 14:34:58 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 14:34:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 14:34:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 14:34:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zt5KR498QRa/Yr48LwwIHUFlGtA68cLNUDBSBraeogTqxJaUpmltWfjbpln/VoK1CMPTGEmyuTy190wTlZ7ODjyVri0WlBAaRl5h/fvY2cnsfm0Q/zC++VVtlYeOK3+ecDvbsCjkVGehYaiz+T3LVxuMMACjds0B1tP+WrqRIMQz/6B5M+1SrCfeinPke6f8fj+rq1P10EFVhyPFfqSu4Er+ODupKUbBvUuWrmmBByUFYb7TU+eYYdZzc3eL4wdHKJf/eM0YhD5zgbEo7daErm3EULXrDJuTvUNRRnN5LYYqXJ2nxyh4gzRVQLCgYU/Vp7EaVnoMFor7FpacuHhvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhX9WdH/SAhkeLd93IU6JI3BWhCC2pMNPwDzg7cG8iY=;
 b=cqdGkCyu7XKZiGX5RB7s5R68xd5v0D3n+pumxRr6uWvVbsS83nt5TkbXN4AJTMZ50yk9YmuqnWw7wZwYNXaHQsIWMJCqjn7i8rGz1C7D+NK7YRAEURjjLRFSZ2TKFzhpTeJBdQHo5TXfIh8FSpji9iPnIfuZ2Rcee9t4+wOJbyj1E2YfSitBwZrdVLUWhOrCn/6HB8AGS4GwR3OmzNEmpHkxMhcxSlAxrXUWyQJayLkTOLVNRrmaK/CAAKep2Y5O+WtA86FUr5CgrH1taXwCn2Zl1AtENpk0czEEV2yLrqZ8MjxlbNRi9vV2Dl33xY4TyMDOizwFqdqN3lCSNEJGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4543.namprd11.prod.outlook.com (2603:10b6:806:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 21:34:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4%4]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 21:34:53 +0000
Message-ID: <6ecee6b6-1735-4fa5-b2b4-3ba93dfc6e4a@intel.com>
Date:   Fri, 20 Oct 2023 14:34:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 5/6] i40e: Consolidate hardware capabilities
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
 <20231020193746.2274379-5-ivecera@redhat.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231020193746.2274379-5-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0227.namprd03.prod.outlook.com
 (2603:10b6:303:b9::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: 4101b218-927e-49ba-5355-08dbd1b465d8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wpqLe0SOFFhenjs+caW0uFOlQK/2mMGhM7j3lfLqRJuGSrr2ND8Lo0+3Iu7FDRtly824yPW+/FhxQVKmgy1tNsbWOqU1iFs10EPQ41SG6X19R8jDbtqBPYolGwajOmpDMwZNNRF5RJfb+BPL47FC7iLgSzXxUD773nXNcDThiAfCHL07c7R0XmdW89yL7lEK/3NXbLfrthQE+J7sVoo/upP8TqPti07/N9wrwuunkYXG/Hk2QbT7I5ovMmBw+jCuHBvLbL6H6PHezXceDVuDPM3PB7kB5svvhR3D7xY4Y5ePZNpHJzwmyyZrUQ9WV9DfiXCEeaGYBd35j5jjMlGd5nx3yEnbnho6z9EM9ynNNkvQy5WmrSThjxdpTOZBpXb9l3wesEjdsEdGFHarQQs/16+UB0F7RNdUjyMNg9xtPqauv2PJobg0hWk0wRZim1oPATzbsd7SE7Xxd3IPUo74rII4a/Fn48pYSqm1cG9z/B9ME34y0RHIS4Mp7C0AtlNAXQjCIdjL0bBaaEsHgsdew3paA3Xbx1E4l1ZCuMxu8OvTuEKxsjNcdr3KV8C47xX38JXvQaJ5xXRMpBGRjEeaZEamoEAXFXCjJ0xDePY8NKtiXuA2+w+RCYpwfq/5M3eVLYh7kMQSfbSXo4Ye1PReLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(66476007)(66556008)(31696002)(4744005)(2906002)(316002)(53546011)(26005)(6506007)(2616005)(82960400001)(86362001)(478600001)(38100700002)(54906003)(6486002)(66946007)(7416002)(8936002)(41300700001)(5660300002)(6512007)(4326008)(8676002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWFJNFd4Mk8wMStjYlphSDN6UXZqcnhuc0VWT2ZLWTc0Z3IzNkVXMUY1U2Q4?=
 =?utf-8?B?WDZ0eFhVcGEyNjVXQjJkMG55bDRDYnJkbStJWDR1YXMra0RRdnhhOWlDeGky?=
 =?utf-8?B?MFZTWWNuU3A3aXh1eDFSVTh1OVljRU51VzY4VG9zUEprdCttL2hEQnZiNmJK?=
 =?utf-8?B?dklMM3JjUHJuRHBkdlI1SE5Qa2RLWm9MOVdpVFdzK2t1MllFMk5HNWFQN0Ux?=
 =?utf-8?B?RXhMWExkMFV2NUFSc2VpUC9QOUxYL2x5cGNXTHMrVGVLdit6Nzh5YXgvY3Ru?=
 =?utf-8?B?K2RBOGhpV3E0WWhLRm9jOW5EYzNneno1d2NFYjVXeFE3Sms2cHJwUkhGcWRh?=
 =?utf-8?B?TnhyNXdPVkUyTFRWbzQ2Y0lzdzk2TE40T2t1RTdFZkZTZUJHZG9CYVpYM0d5?=
 =?utf-8?B?VGR2blZqaXI2UmRqMFpLWlpPSUJ2RGMyTEhTWXoxQzNhM21aNlpmS0VTM3hU?=
 =?utf-8?B?aGdGN0xuVjdGdUdKWVpSUDlCNTlqTEdCOUk4MmZ6Y3hjcWJZenpCaHJNSlN0?=
 =?utf-8?B?NUlRbXYvVmkxMmJLblJ3Y1hwVUdZN3J5K1Z6TnNyNHdpQlY3aHNtV3hacG9V?=
 =?utf-8?B?dU5HVTJBTmdaRFZXOG9ZK0k1OHNHZDRlMktBdnhuSHY5Q2swRWxoaFU3Z0pN?=
 =?utf-8?B?MUNIZnBKRzd4WlB2MVcxajdqQVlqL2IrbTZHY1h1cGJoWGJqRlBFbmltYkdX?=
 =?utf-8?B?OUVlWDY2V2xTeXBwOWIvTGRQWkRUZ2dMWDVtNVA2UlZVUHAvVUw2aHNzZDl3?=
 =?utf-8?B?RnV4L1d2ZlNFSWdEak52NmVZdlRiTitYcklwWHZEeXdDcjZUOCtqVXgwcnFx?=
 =?utf-8?B?Y1Vld1paMFJoYzc3NGlGaGRWSHM4cHlwdHlUOEs0ZjRkNHhId1lwN3VPQ3Q1?=
 =?utf-8?B?UmhXZjcvckJpOUI2ckw2VzhpdGNyaUhMU2dZaGV4R091SjBCM3pTRi84MEVt?=
 =?utf-8?B?MXFqR1FISDZaMCtQUGdJQkJIQVErWlJDR0MwUzNCeDNBMGV4anZxanBlT3dI?=
 =?utf-8?B?anpKczJtdVpkUTRjdjNwMVNVd3FONUJNSTZXblVzdUF5ZFhkcHlxTkRna3lK?=
 =?utf-8?B?THI5NHFDK0RTdS9veXNNMlFXK2cwWVQwdVJVZEhFbzZjNTltb1dUMFVKTnZW?=
 =?utf-8?B?ZjFMc1kyS0ZlNnJRbTdVVHJOUTFxaWd0b1hCdVFaUGQxanRwOTBWN3djYnhT?=
 =?utf-8?B?ZEtQZjZSZ1BzVHl4UFBVSWJWSnFGSWt6aE14ZEsrV2RkWVNORE5DdTVlaHJl?=
 =?utf-8?B?L2FZcGNEcUU4V21hRENiRHZOb1BSK1lFcW4xUFdIeHpwQkp4U3JaMEQ2SUpZ?=
 =?utf-8?B?eGZKVEJsVG9XMk9yQ0p6bXBNWVI1RlV0eVJGTTBDWjVxU0pNL1puNTdpQ0x2?=
 =?utf-8?B?dUZRMjE3blI0OEsvdHVYYTc5bGJSTDNjQ2xWc0Mydk5FLzA0ODR0bE5Tc1g0?=
 =?utf-8?B?MmJ1TXZxMFVyQUg4KzMyY2ZMTVg0U3NnK0lQVWlFNVFaNmVEamVDaFpkQml2?=
 =?utf-8?B?ZU84VkY0OU9wd0hoaXdKV1M4czJ2aHUzQ0FWd2YxdWZ3V1Jvdk1RN1Bjb2Vq?=
 =?utf-8?B?OHN2U0wvZ01CcE5qNVRFeE1MemZJa25OM3lPSDVhbHFEQjJrayt3TkN6UEIy?=
 =?utf-8?B?VldxNityTnhnR1JVVnhBSzFNbEVIZlh3MVRhL0E3ZUlDMGl1L29oTVVXcXBP?=
 =?utf-8?B?ZllKTUhySGZSbExZbkp6T1R4aWN6STA4QWp2ZWpINy9IYk9iUDhrUG9YRFBM?=
 =?utf-8?B?T3c4V2kxOURnQjF3UVNTVFVlMTFQbjAybVNEVkZZV1hOeHMxUERhZ2ZlMDNQ?=
 =?utf-8?B?dllTR0xydTY1RTVDbS9NSXNMZG5vMUR2SXo5M3NjdG0rOTJ1ZlFhN2RjR3BJ?=
 =?utf-8?B?dkYzNERDVFZ6RlZEQ1E5UVM3NVBUSUhib1B2aXU1SG9oQzFaeVdzbk5NbHJD?=
 =?utf-8?B?WnJkL2FkU25ZZzlyQlFkNlJwZVNpYVhvRmk0T2txbzRxeHRZWWUwL09YZVRM?=
 =?utf-8?B?ZzlPTVFPR3hRM0JjMmc5MkRvS0ZIMXNMSmJlMjM0SjNTWkhpR0t1MHhPTFBI?=
 =?utf-8?B?dFAvRklaK1J4dVFVbzFPNVJUVGZRNjcrRkZTelAwY3pKRmFwSjExK092VmpL?=
 =?utf-8?B?L3Zoc0RBMFZaYUcvc2Q0N01oc0p4RUZXb3FSWUtuazdtZHpTQ2ZacDNrM2xR?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4101b218-927e-49ba-5355-08dbd1b465d8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 21:34:53.6895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VoAATO9mJZLZkUkVnSYwCb1vh5xkDZ+3EmDxJkCObnYlb9Bfx+s9bcJw6goB4vRMLj8iXq5lNdbVtwEzt91Qf0ELih5FKGfFVrlO3eyKrtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4543
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
> Fields .caps in i40e_hw and .hw_features in i40e_pf both indicate
> capabilities provided by hardware. Move and merge i40e_pf.hw_features
> into i40e_hw.caps as this is more appropriate place for them and
> adjust their names to I40E_HW_CAP_... convention.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

The hw features values were originally introduced by commit b74f571f59a8
("i40e/i40evf: organize and re-number feature flags") (v4.15), and were
previously part of the normal flags back then.

The hw flags field was used since 07f89be81fa5 ("i40e: Fix basic support
for X722 devices") (v4.5), and appears to have been extended a few times
since its original.

Its good to clean these up and keep them together conceptionally. Thanks!
