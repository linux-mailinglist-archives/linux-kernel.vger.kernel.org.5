Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7E47B7C2D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241926AbjJDJdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241890AbjJDJdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:33:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E1CAB;
        Wed,  4 Oct 2023 02:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696411980; x=1727947980;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S4bZkqmQujtMWazbrmjdg/fKcZ9hiATfSS13SYSmlE4=;
  b=oFKkxcVFWJFmtaocSPb7uLhrSwBkdOiTheXvuYPesImQeqwXg4QpGR7A
   J5+bsQglQtwaF7g+52hNa98rMTH059c7LgkSw5kWpN1Rv92HZIKpyrvBd
   4857ig1lwImhcc6H4CUlqyq65whEynNbJDHpEX5sFq4gm6nO9zd2it/XP
   LPiKBCY6onTe3y/fwXVr0V1cbIw7XdUsKkno9Egga/0ofeVAWBDxfFnqT
   +x1tjbu1jNVHlvMVzmSgzKDdb06qnLaGVLZSdAu4XpxYZ1hIb4e27yXj4
   7PXfkYfUBBHXnUI0ZonIXMtoGOTAEZgLxNuAAKnG6lNqAY5F6e/aiCWuX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="380391937"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="380391937"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:32:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="727935006"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="727935006"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 02:32:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 02:32:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 02:32:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 02:32:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 02:32:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jY6VIOvwDLCib4zAf/aetsvbNbK7s6RB+JnZ3cMJ0ur9B/6W23NCEyst4kPlllRBRjolZexZxY0VCoQxrOS0tUW3FP5BIugacG2SK+tx3SGc/ZNWvG/U9Ka2gYPq04No0DYyihyg7j9f5Q8xv3FAuvcpuZwh7WT3ryyfbIMDqxY5ziU3vVbMhhosKP3fjaSCUc30o43p6RUizzV7MvigaNpM1iBlII4tnKxJZsXUYPJxz3QE5/JG6BZ8aYq0NTAkgB9n3giSd7scS01t0+ZB7n+9r4oe85NcJIuItJ5VwZGQJ0N14GBKlnfk9O5bmLgGHZk0R1AFK5m8mdffAKrmTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MeVTpt0RTMbknYudnCuQKMxaWXH4BXmYMzMf9mEdlM=;
 b=HxAU2UyLPw/iqNQHvRl3SGFZBrpZxYSCEwXRl9spAp9GegdC1O8CA9+VDSJ+NTIzXsxamMlICmpTjS+qw5Pw3lKwY+K89doTpy2r9d+rF8UE2YlT6+dWrh0JBwLJF7Wna7/2Op+xyP4R9s9l2iWQkEwVxayqYP4hiPvORLNjBYjJuZVwmHqFXTM/1t3lkrV4Onr0P+mCWC6JEV4tzm5Z0FIDWa11HZQ4q13MP6JjWcqnNmBUKSiNdUM6RdGCwrKf0ndr54jF6UP/N95kCpyzT8FeyQg8VlGkJenp9BLSIAKmMoxXSbZkneSRWX6JwQSV4r7J1Jw2dL4zt3+fLKDeng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Wed, 4 Oct
 2023 09:32:43 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Wed, 4 Oct 2023
 09:32:42 +0000
Message-ID: <c2ef79ea-468e-ce25-a597-cc1684389143@intel.com>
Date:   Wed, 4 Oct 2023 11:31:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v10 1/6] page_pool: fragment API support for
 32-bit arch with 64-bit DMA
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Alexander Duyck <alexander.duyck@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "Liang Chen" <liangchen.linux@gmail.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>
References: <20230922091138.18014-1-linyunsheng@huawei.com>
 <20230922091138.18014-2-linyunsheng@huawei.com>
 <b70b44bec789b60a99c18e43f6270f9c48e3d704.camel@redhat.com>
 <20231003151216.1a3d6901@kernel.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20231003151216.1a3d6901@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::18) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|LV8PR11MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4c6ead-eff6-488a-f9f5-08dbc4bcdb68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i8MYLGZhQ0lx+F1S/rsdILIPwXUKYtol11JoRdzxWrCuljwmYjXo+8S14rXxv4hl38r/tuYNpR/9z3XAyCVW/xr27O1yEq3/yB0tNYfxZ2xPLQB9kQiTuxeQMFOTJM2wYRYpTh/+V/54ki+Aop4iRaV4xbmD0R9dqNQ6fPcT/KZkUN+Sx1MNfGgxLITX77Y8vWJLHKKU9olGC8e1SeMfK9NyGIwqdzN+h6gONwsf6NSk4JmCOXRLukZg3z3WvNKhkRe0ED3gmOboUaS/oTGRRNvvzmg9mWbOKNJPnEzbB/4p/r1CwDq0+pZCNzhUCYOGbUJ+UPde1NRi/KFX1vyaYi8kVV/BySW2v9owiLf9DJhsi9Bay662hPrcTU0XNfqGoSJdggG5pjB5GlODsxS8VspcpvKeIGYviGtB04EpXq70+NvIzSUy0cEogiNB5ft6Ercc5JJo7GklSGooPASU2v5q1Dy1IYjhsJ7gSdWla/Teyx0upZUnvGf91oEfpKJuxkLkHfkNs0EfrdGPFBsKDDusGkp9UAUknhZNFf7O/ntHTR/8dnX5IRP2pMIAbve3AiFwzRTLbnBK1Qvh4Zu1OBbsw851SJO4j8yV20HLV/k25EJMiD+PgS6RZ0Pn1IQc+hXjctelK3CG7arb3jgjiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(7416002)(2906002)(4744005)(5660300002)(4326008)(8936002)(31686004)(8676002)(41300700001)(26005)(54906003)(66946007)(66476007)(6512007)(66556008)(6916009)(2616005)(316002)(6486002)(6506007)(478600001)(6666004)(86362001)(36756003)(82960400001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnJiY01LdEIrQzRrb25pTzdQdWN3TU9FQzZlZGZUR3BPUnlJdzZPdjczaG1Z?=
 =?utf-8?B?dEpRY0ZnWGJoSlNZZkhvOE5sUkpBcG41dzRmLzFiU2hjNjR2K3dIb0tRcHdM?=
 =?utf-8?B?V0ZRZnFTa1o0MmRZOVJxS3dKZkN2U2lkV1lMaXFFUEVxZnpjTWd0WkNIc1pN?=
 =?utf-8?B?ZkdSbUxKVkowcHExNDRPUUg4dk5uV1d5eXZPelhNaERTbFdUall4NHErd21s?=
 =?utf-8?B?NHloeEYrMFlDNFpybUVSbE81WVFqUmxjNGlwQmpRalN6a0NoVFRWOWJPZGVu?=
 =?utf-8?B?aVhoY2hhcHllRHBQYjZYSjU2TlY1ZWQ0UjVOaVNJV3Z5NTNLelkzWmdLMjlG?=
 =?utf-8?B?N3BPdldsMkE4RHJiSDQ3WXkrWVA1NkpldGdNOFhlZldEcFJ2cm0wM1dxN0hD?=
 =?utf-8?B?WE1jN0NzdldQT3BwR0VKS0ZhZ1htbzV1Nk5teEFmVDdnK3lQcS9va3Vob2Ji?=
 =?utf-8?B?WUxwYzJtZzBhLzExMWpzcmpHTVFGd2NOVXJqVXdMT2E5YUIvbGdWbzExdkM0?=
 =?utf-8?B?aWpOSVEzakxuMy92KzZKbWVHZy93dlEzMlpYRWllb1hUU1dRTHprRWFJaHdJ?=
 =?utf-8?B?dmYyalZRakx5RVB0WnIzTzRlT2o3NXk0c2VZNFMzbVlwdVRjaHJxMXlTeW41?=
 =?utf-8?B?Z0M0UGJIL3dsOFhNaURDU3FMNlRIZVV6RU9lUERsMnpZUVZvMHFabnVSOXpQ?=
 =?utf-8?B?ODRnYlc3QVUvN2l0K282Q1FDejJ3ZVJSeHpZblBNeXFSYXJVc0FDS3ZtT2pJ?=
 =?utf-8?B?TlJqajZ1UmNwNXExK2J0MVRmSjRuakRBd0ZnNVlKUWtHQ2U0QUNqaFR0M1pV?=
 =?utf-8?B?Y2dnNjlxRkZxbzlsYnZneXh6WTJwbWFPOTFpN1h6OGd1QWtTOHFpTS9QZk5D?=
 =?utf-8?B?VWh2Y2MvM2FGVFhxcHJreTBPRTRyK0pGM091WHRFMm5MdUpQQ1pYbG01ZSs1?=
 =?utf-8?B?ckhDSHJscGtITlhuVFZqR282N25kQlVOTjA0bmZFVDgvb2FKUnpnQ0g4Yy9S?=
 =?utf-8?B?akt2SCtaOXhITm93VkF4YU91RllYTzVoSTZxTVhXRXQ5VExjZE5WQmZML21D?=
 =?utf-8?B?RS92dk5reDdFRUJ5UUJTUUFqdzcrU1FjWnpIeDRQYUNVT1VzZmo1T2RNQkdk?=
 =?utf-8?B?dFhFMUhBdkFHTmgwOWE3U3NnNGxpdGdDTWZmRFB2UUlRU1VldVk5elFTaytS?=
 =?utf-8?B?NnB3UmtqK0FESUlrYVdtZENMQUhIVWNteVBOYkVLOXYxUFd3M0UrZktHa01l?=
 =?utf-8?B?KzlsZFk5bW9XS3IwbnFGaitBMmRXbzNESTJEZ0FsQW83NEdnTXZhSG1kTFNl?=
 =?utf-8?B?OXVPR0czVUo4dUhSWURIVmtYZGg1YktITG40Y3ViN3RnV3h5aFJTOTFQa3M2?=
 =?utf-8?B?eEtFSlQwU3ZLcEFCMW5FdXRUT2JaUVJUdkRlN09WT0FDb3JubDI3eEFBbmFF?=
 =?utf-8?B?cmN5eXMyd3ZiQlRSc3BPdkgrNWszNHNxck9WR0ZRUlY1ekN4RlpFUHF3ZVY0?=
 =?utf-8?B?WXBsRitWMjVBV0ZmSjg4b0pzajNlTDJHTzBOa3M1QitEemlCRHZub1JyTS9K?=
 =?utf-8?B?VVZqZTNRU0dCakFZNlA5c2JCWWVsdW1mdGZSb21kYVRYN0VnZkhrQlM2M0hS?=
 =?utf-8?B?UEx5VHI5Tk5DTFdUOFFhcEtvUFZpdkI0ZDltWkhCWDRrbFFGaEphWWNOWGlw?=
 =?utf-8?B?RkIzSFpQZmp0SnFIK2NSSjltcWJVVmF0T25MLzBQT3Jmam03L0FCSUR6K0px?=
 =?utf-8?B?eFhSVWMwVk42NXhSVi9NMmJ3OXUya0x5dEgyNVZiL0JtdjF3V002TWdpQW1n?=
 =?utf-8?B?VFM2bTJYUnhUV2VXeS9wb3VsWjF0eDVhZjFQekExbWxZaENWNnMrNXNjYyty?=
 =?utf-8?B?V3hDaUI2QUtRMmJ0MncwSWJvREFpUit4VFJkV0RRTjdjMmdrOWtaVDg0UkJC?=
 =?utf-8?B?VGJ3dGFOYzdOUnFSbUR4RDg0alBURHdDRFNsZmpoY1E3ZEUyYlNleExkWmtZ?=
 =?utf-8?B?bVlDeFh3SWlxMUlDcHo2U0tkZEF6bkt1d0lNamxMclA5N095QmkraGJSMkdx?=
 =?utf-8?B?Q0hlZmp2c3NZWWJhR1RiSldsLy9JcldabEZTdWhqc2JwbWswVzcyL1g3SXVO?=
 =?utf-8?B?NU01dGRTVDNFLzVPUVRtVEhIVjVIWWRIdW9XWnZjdVVsai9GRXdUMXFwVXJj?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4c6ead-eff6-488a-f9f5-08dbc4bcdb68
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:32:41.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUib3iZCgQkwbE9eQSpqXqYLyO8BazMrOcXMRb3J9b8TYG6nd7cCc43Jw8CyzQMmQ65X6XQa1VWIzAAKiJzOVhs6f3f2gmA2o7tFr6hvAQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8722
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 3 Oct 2023 15:12:16 -0700

> On Tue, 03 Oct 2023 09:45:56 +0200 Paolo Abeni wrote:
>> I think it would be nice also an explicit ack from Jesper and/or Ilias.
> 
> Also a review tag from one or both of the Alexanders would be great!

I got back to libie/iavf this week, hoping I'll rebase without major
issues and will be able to give a Tested-by as well, will see :>

Thanks,
Olek
