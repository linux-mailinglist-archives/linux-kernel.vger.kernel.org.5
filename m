Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EFC7B730E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241128AbjJCVJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjJCVJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:09:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7929EAB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696367344; x=1727903344;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p5l+u/AwLXDd8o9cn/H/ju6mNCzK2Y0Nr+ooN00Smm4=;
  b=bwT75T2PRnB4Rx2FApSBU1PcNFABQNzfqJGH/NxllAe2XsmqxwTn2RU0
   IYRyTf9mq6M61h3NiP3E29QOsA6sentiWsXYx6UsISBV4o+0M0HrRZMwl
   zhVtWoHQB9Xeknaak3Q/hpRs+TYyWdNFUo1B4T9MKohxvS+IRV8tQSwQ9
   h7/VW45dLb+rTByY3DMkxVifAs0x/GUBi6ZaAHYOEARNodWwZ6tZ2e4RW
   iTUJwC9zWbTRNSDAjXcdPiqhKNPtLfpMHfFIbsrANahFvN4q1Zsu/GlED
   aI2a/OHlbLiS6azi25tQ9YfI7G6O6cBvHr95OCFvQgqj6rQdQJ5bceheS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="449472142"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="449472142"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="700858154"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="700858154"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:07:50 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:07:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:07:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:07:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/npY2XQ4yA5zpb8Kcnjx5CwTdCwPbzS436GL+sl0my32r9IT4eAEa6CNteAGgEZ+6HCRz9KVhQ32jx3/ycKbouyzW0ulSF0y2+q4bEElVJ7oNZtooMzpcY4ObwitOrZbYJu+qPZVsH8JEO9qkztA8rOkVYB744sOF6B+lPMGRuUesEBb0+7+/HD2Xv/TqBA0BMqLGPY0dkPqPzUsRCWIMpNS1R+6i1FV6GVWlDtCEmTnpPOxun9/5QOSpQcr6TlCJyjhTaum6MhsMV2jqQZTVMTliS1tWZuXIc1F0useXILQKmZ3xK3RJ0jbHd+VBtJEV3MVETr4s+10xsY/QMPAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/uj25GSNhLfAsSOOAOuzJX9N14q2tPY3LC/5Fo+zWo=;
 b=QRjsqboP8D3KWwYJbNSIUDxGJs972LIssgPt2XOiWLbmrEPUmQ4bRuTzZuagY2V+z02NIc8BghuEtjO7n+zqFODKFihPxB8xW60qqAyXQkbCk/7xizcrVHhAM5cTXTFnd+L72DN4ZAgAbcIBmieT9JVcdWue/9wsL46YWG8RXa6A09syHirb5F2D1p2MFRQcuOpvSN1pk1ZhDYP0lhtoVmJH0+laq8l17orCW4jcO/HovZDrKxKAfSDgyNL+O4VUePU1gO2/VgMGLZRCyG9xQRtSDgTM1vqEcECHr/LoyH4c7XWoyXOG8ZLQz7Z3NyeB7RH/3ai1+hZw9eyNkvVMUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6908.namprd11.prod.outlook.com (2603:10b6:510:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Tue, 3 Oct
 2023 21:07:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:07:47 +0000
Message-ID: <c3d6086e-a564-66a9-6e0b-0e109f30f6c0@intel.com>
Date:   Tue, 3 Oct 2023 14:07:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 04/24] x86/resctrl: Move rmid allocation out of
 mkdir_rdt_prepare()
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-5-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-5-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:303:b8::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: 8171fd0a-e809-43dd-c8d8-08dbc454cbb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/GfkDsyi24u7PjgdAJYctqr2QC3ar5J3zXzsyouF6TYwVOLAvff9pb6sYmDb7eS+B2CscI7lRRk8D2NQ8RX1i/C6rI6O9Pc9+/RNbnBhSDIYniEA/YN9nyHUf8aZJ7Y9RJ1QznEIKXiLF6S2s3+pdP2qeBn6sSPrKHUfFqJuVTxM9/Z8FIyOzrXvr5uIjGpNj3LTBz6jemqG12X/Gm0aIqLesBo4TJOCh4U1XSouIpYV2EnEQ/uEpQ/iHDHK2uEWsscTvrRctdFABzqwW6DRSnKd93YR7ArIjP9eFuHEfQs0ShEo5nCw4mKxdJqi2ZJsySnYr3zDq3LsSYaNu2FGQJZ/c6dMAP5FMAuelTftbcggB4Qizz3Y+OEH39JszORMA5cDUnXgtOs8AdhfGqNOtjezIh5nExOo2biO/eR0qI8TYiM9Q1SZAQrSqpqip48bRA4GxFZ6szZUEuwfBnpddiNW08yuQbyrLMlBagaEAtP3+wBDGWhqm8Znt3UADSZw19oxtuxWorjb/q0z+I0oktCYJIYZT5uwyNxI7XShMKov4MAIGwD4zzEc75lWoZ2Iy/ot2/BLySC2cYO6B5441eqS2mquDVx9w9HPO4kIWmndrLMZGiFazXDjzUKNhg+lbzRpEpoKCoeonvKy4c2FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(44832011)(5660300002)(66556008)(54906003)(66476007)(31686004)(41300700001)(4326008)(8676002)(66946007)(8936002)(316002)(82960400001)(38100700002)(2906002)(36756003)(478600001)(86362001)(53546011)(7416002)(6666004)(31696002)(2616005)(6512007)(26005)(6506007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enpvWGlpRUhRY2ZabWNYeEhRS1l2MjBJakVFanNVZ2tCTEhsVWw4Ni9EbEoy?=
 =?utf-8?B?b2E1WWFTTTlMdjdVZHJ5QlBUYy9WN1hyOXRxeEVUTnNsTmdQdHd5Uk9NcjVi?=
 =?utf-8?B?MDJoSU8wR2Y2ZjdkRVcxZVUyNE1JUmVFa1p2S0FqcC9BN2JLZEpJWlh1azZt?=
 =?utf-8?B?QWN6T3lUZjczNy9RR1RkenI1bEFKYWNvRXd3YWJpTkV2dnVTaDYzaWsxbnNR?=
 =?utf-8?B?M3VDc2laQ0Z6ZXBtZlNHSkJjbjJqaUtTZURvZ3NjaXZxVVIwWGlvOHVoZkgw?=
 =?utf-8?B?WlBMY0xjMkRUcXpMa1lIUU5zMmtVUTNvMC9aOUthSXRtbG1aZTR3UjY2L0Vp?=
 =?utf-8?B?ZGpxR0pCc1o0dE5YSzRNWnNwWHN3bkVkZXhBK2FDU1NDWHpTcktLQ3E2ZGd6?=
 =?utf-8?B?Qjg0WkRRTnNOaDRqVk5peXRWbVc5R09lejRNS3ZTd095RlZ6RDhpTXZuSWpn?=
 =?utf-8?B?blVCcFozWmI2Z3h0a2pOUGs2UlA4VzEzaWQ2TlJINkNUQ0x5TEtFRUFnUEtO?=
 =?utf-8?B?bG1jQXlkWGNoU01YdCtiRFBrV1NEeDJZVWF1aEFTeEMwenpSRFVvYVFLZk51?=
 =?utf-8?B?QmZGeCtlR0hHbE5Kb1FXQTVDcUtQd2RQYW9UcEtWODhKVDltWWZhdWlhZzdo?=
 =?utf-8?B?aTduUjR2b011SEdXdVd0R1RVSUIrNUQyalJpMi9LVmprSFNFcVZrUTBTWlNK?=
 =?utf-8?B?Mlp4S2Y1SGxoSlR3NDRvc1VHaVpVNkZDZzRHQk1ha3MxalJxSGZuZUV5cXpv?=
 =?utf-8?B?eFppVEdnbHA4YU1nMysyaGplSTR2a0FKWW93QTBFYXdqZVhDTXMrTDV4V3h5?=
 =?utf-8?B?aUNNWW0rWVlKZTJDeUZNWDRuenNiSm04WXJjTDZxVVFVQTRiaS9OQzBvWWxl?=
 =?utf-8?B?WDBJTDE4WGNDNTZGRHVpbjlpbHdUVVlTWG9CT1RPczZicXZ5NzdOaENGQkl2?=
 =?utf-8?B?WU1jdjNzL29VVzVVZ3huS1czUk5vYVZnUHFJZDVYWnNvd1hXTTFuVHZMa3da?=
 =?utf-8?B?VWQvUEc3eVJxUWN2T3FvNmhZY0RVVTdtNXRFaXoxdlRkZ2k1ZXJheVVzYkVY?=
 =?utf-8?B?Q25QS1FTUVBiY0pacWhPTmE5YVhsN1lSTTdmaFZyOFphaHQ3ZzJqSFJNMUNZ?=
 =?utf-8?B?MmJQSlRuY2hrYWxRNllBOHFqMkF0YzdSeEhGWWJyNEZCWDlDeWhyS2xaSjFD?=
 =?utf-8?B?WGthUTVPNVZmY2RpcXJJYXcrNmE3MEZiMkx2WFJlWTJqRmlGaElUYktOelBk?=
 =?utf-8?B?M2N5d1ZQWXlsZ0xKdE1zaDZMVTRZMkxkWU1tc2lRYURPcEU4aS9vc0NQMCtZ?=
 =?utf-8?B?Q3FGaHByVjFIZ2dXRm9GelVlZzcrNFBzcnhPS3pUMms3UUxIV1FJSG15ZFQx?=
 =?utf-8?B?Zm93cEozQ3grQTN2QWFiaFFaUHZVNW1YbGZiQUp4SThlMmxRMlJtaklzdmJ1?=
 =?utf-8?B?aUtZZ3FoNU1wV0FNS3FmNlJOZUFRcEcxRU5QbUJTckx4NHd4dFJGb1BReDlr?=
 =?utf-8?B?L1JmS1UvcU9xSlpEOU5TVFV1aHBLSzdpT1J0Q1lJY09xL1VjcWI1Uk1NNWZR?=
 =?utf-8?B?TjZwTlAxNWtSRXRPYTBWeEgvMUFmY21kQ3hLM2U0T2N0eXdCS3pkc0o1dXJv?=
 =?utf-8?B?d0hXcC9qWjUxTEIyaWF4TjVBeEJTb2U3dkxrOTJLSXorQzFMcXBCNnAvNHd1?=
 =?utf-8?B?VGRhckxnZWMwOFpCR3VZYmI5VDVSWXgvdFpPRjl5N0V3cDI4Q2J3NTdBRUdB?=
 =?utf-8?B?Q3pXeFVFb3U1TXY3TnArNXRNWGhJN2RZL2dqT2hWcGtRYnN0K1cwZ3dKTzFI?=
 =?utf-8?B?TXBHTnBZeC90QXpieW1sM0RGSFFzMC83eCtLWnBVQitHWWYwbm11SE9uVUI2?=
 =?utf-8?B?bmFMbEZiSy9oSkwyb0R2M0tsbCswMU5vTFcxZFJwTmVxaFEyaTRacktTYVF2?=
 =?utf-8?B?ZlRFL1doZ2RJRHVqeHprWWw4cWFCNDFWTXFQclV3R29qZW13eE8yZ2liY0Zt?=
 =?utf-8?B?K2c4ZlgzWjJESVkxT25MY0QxNVFWQS9sbm0rU3hyOUk2aXRuRU1VT1VXajNh?=
 =?utf-8?B?UWFBWmcyNlk2Y09seTMxNUN0OHlidFc5WFVOb3BIL2hqK2xURlJteWl5YXJp?=
 =?utf-8?B?Um5GcHp0ZzZySjB4aHdJa1d5U2llNEQyVEM4VTAxalo5L0ZWMmdkY1A2ZTVr?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8171fd0a-e809-43dd-c8d8-08dbc454cbb6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:07:47.8405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: En6bSNKkFYVbnktp+Vl3okvjbLLvbOqRtC0sO5A8YwrUYeBuGYkAEO+SksUq7EL+9KA3dC+GNYEB7MBa5cHxz8VW774Y+M4ZwiN4eo7xeEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6908
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 10:21 AM, James Morse wrote:
> RMID are allocated for each monitor or control group directory, because
> each of these needs its own RMID. For control groups,
> rdtgroup_mkdir_ctrl_mon() later goes on to allocate the CLOSID.
> 
> MPAM's equivalent of RMID is not an independent number, so can't be
> allocated until the CLOSID is known. An RMID allocation for one CLOSID
> may fail, whereas another may succeed depending on how many monitor
> groups a control group has.
> 
> The RMID allocation needs to move to be after the CLOSID has been
> allocated.
> 
> Move the RMID allocation out of mkdir_rdt_prepare() to occur in its caller,
> after the mkdir_rdt_prepare() call. This allows the RMID allocator to
> know the CLOSID.
> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
