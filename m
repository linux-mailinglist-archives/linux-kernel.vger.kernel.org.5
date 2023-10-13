Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FC17C8C33
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjJMRSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjJMRSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:18:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEC395;
        Fri, 13 Oct 2023 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697217529; x=1728753529;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wyn7Cl1Il41JMBkH1mXO24o2nFxG+XwMzcvR0Zl7oL4=;
  b=nV+BU++MmV3JyF0lfDBXkJxPrgGksQ3VFF2mOjJ/81QtvwVw7QYVSXKN
   QRUiMpwWQLiaMVaQaw4kf93q0DmaiTcCBtCG9S/TlvpGfuuXULjnsu/e0
   bNFk5k5rGquKKwyu+Hmu6ILO3SDYMuUE9rScAJP7v6f3obId4ZjIJDrGs
   P0Z2Kn6vzBbSmAxWGNovlwWMBplEVd+YmfYTnGoRjTYe1ksfUtzg1UZfx
   S5bmPvM1jH6expkPYeg5BCtdPzedooLIvEMM181ITgt0GhT3SX9dqz5CX
   2ui8Y5DTD9xlwWWh0zWy3fAeQ4WnimEtbs3Att03RYnxyC4exjMzzmDv9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="3830190"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="3830190"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 10:18:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="731427619"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="731427619"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 10:18:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 10:18:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 10:18:48 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 10:18:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAOGelKiGYdcui/eO94XemFaotiOWmqJcBEr5v6L3vkjP0M6Q++u90y4FkuAgtlkLKr/km+gq/TnbCBUWtvP/dXYbkmtRZO8zhayMEFPXz9g5COf8nUFmGQf1apPHb9gmBT8da4PcqQ2DpdSPfI7vJ/bhu4/asyYM5Hm1bwBtR1rNoJk9tt4+gce6WXJUHJPiA609q0xTqLDbHl3jrITJiJzLNPDb/XDCg7AhDc+QMQ2cOoe6YWTaZiBVTqm+Rq/cxw5HJCwgfDyo3gamFGVsI9EaKL1pn69opiXoWB4jphFg8CTzxois9NQpimDEY3u92Ort3ddgcfEdlgudvQ17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FOgXgvMEytwU0ekinPfff6zRsed8KOXafNejVR7qSc=;
 b=RRYZjSnPLJeIwq1ym8FgfmMYSrfvfWOK3HNtTOrisAP4ufNgK3fuWRD25wf65dsCRGxM2ZlY/eHvfTIquyLYV+/DyyLeRHfRTq7zYWXRXZjjoWgOUCKov3A43D8PYswFWox4Nu/w2sZk++tuOokokGbCVehH2J8frB82C3HJ2H3hmoOK47O7e9tpHeGfQ9tYinP0s+NgEH8vglQEvfv25okBmk9OPM/NfP2QQWTRPdmnrkl6L4ritqmbpGBdpiKQ7f0mpzaq9DfUb6yRkpeZ0otfTFERyYuBD/f6llGZ+8VzEJdOq0UdhdYwvJ5UAMxODpWCvzmfMpgV0dmRkdhghA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by LV2PR11MB6048.namprd11.prod.outlook.com (2603:10b6:408:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 17:18:45 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 17:18:45 +0000
Message-ID: <1c2117f1-2d22-4d08-bd9f-8c821d4a1757@intel.com>
Date:   Fri, 13 Oct 2023 19:18:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: NFIT: Fix local use of devm_*()
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-acpi@vger.kernel.org>
CC:     <rafael@kernel.org>, <vishal.l.verma@intel.com>, <lenb@kernel.org>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20231013085722.3031537-1-michal.wilczynski@intel.com>
 <6529727e18964_f879294ea@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <f7441bb4-c2c9-4eee-9fed-ad8b28de4788@intel.com>
 <652978deafdf8_f8792944c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <652978deafdf8_f8792944c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::11) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|LV2PR11MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: 0133118b-5c4b-4de4-93a4-08dbcc10747d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PixzBPikd0jsVOR6kQ93TNOsR7edtJ03OfnJZnNF4O1xIRM0xblBq/uJetpy0D2DblFCioaV8ga+G/BO+Q59hlM3DM4k8tKnEhXzsnhcAMjyb6gLXVIo6BgwudVSntu044kfM+6C6MGlPCZo0cFyCdQ2qQjQCzboP5TYr2MVbOfQcbj/FOPBir4Em7C8xkCn5DAfafbjKGBkpzTbUDLJKhBo3Tybnd1CkVRmK7DsBBtoSqGfMg1nj2GflsUlEkaLi1Uz94P6m5UfyZcbMA1tu99wgBQYWEuKB1/EHo2nD23+O5ph9C0k9rWmr9i9arCFPZu7l/Nf8wI3c0RxxcXFfFDvSZ8DQ4yliQaUSg+Rn2d8GqFmE2T/RXkgGPy/pqNbMLJALl3RFnaET0+Ntjuxe1Pg6WJxxwNoOxL6kbMYDlc+FHHGq+bTbrm/MZSzeXW8MUMzuKgJcXaInLHOdoTNnruC2tpOgxpKdeMWZInfvd7ot35wZRK+2he6s4vtatoSeEv+lMFSNNW/EQxwlZWOF2Usq+0w5cizAJtk3oXuOEQ98rvOq5bvyW6pNvrEiBIgQjZFGOrbAyAqF/1eDFqiSlHdR7kRS3l5o9lINillWyLLvaL7pOoY4bIycVV47EWrNTpB5/qpnNGMAnd0Y0lJ+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(478600001)(31686004)(6666004)(6486002)(53546011)(6506007)(5660300002)(2906002)(4326008)(83380400001)(2616005)(82960400001)(41300700001)(6512007)(31696002)(86362001)(316002)(66946007)(66556008)(26005)(66476007)(8676002)(38100700002)(36756003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0hwd2JTZFRMM0UyZUNpbUhOMDhsaEVZNFQ1MmdqWEJGaUg1Wi80YUJ4bEdi?=
 =?utf-8?B?dFppVDk4V0tKUSt0UHVpeG9OZCsxMXJjYkF1dGt3ZlB6d09PSDZNZVBlK1BS?=
 =?utf-8?B?NGRVV0ViQThSazIxMmI1d0xIT054a01va0VuODZNSDgzY3JRVmJDRU04eXlq?=
 =?utf-8?B?L0grU2NPSDNEaktOMXJHRnRKN0phOEpQQ255M3BMRDlSNUEwSHlDV1N3Skdn?=
 =?utf-8?B?YkkwZUlNSExWMGQyWnoxWElDaStaZTBpRGs0NTJGemY2ek1iU2VGVHppT2d0?=
 =?utf-8?B?UTBxLzBhWk0rSnU3SUZtNVZLVEtXWGkrTGwwMEVmVERhcFJsOVd5bGZTVElD?=
 =?utf-8?B?R09PVTJpdmJ6MUMzQzFmeVpKRGo3aFh0T0xVaXkrTFJHN2pJUDExeUkzVm93?=
 =?utf-8?B?ZmtUSmtBWCtFM01ONmpzOWl5SkJuaFJUTTlFemZuWkthc09HVTNRSk00Z1lV?=
 =?utf-8?B?WU8rRVRPR256dFNpb0xwNTVDQ0Mrc2JzRHBzbUFwS2VwYWJHaERkc0ZwZ0Rz?=
 =?utf-8?B?WVRqZmMxR09leXlyYlc3QXFhMlJoMzVVVDg1U0ZMbEY2cDd6Ni9TaUMwdFBS?=
 =?utf-8?B?R0I4bFNSOW0zZmlKU0ZLWUdOYUtkVDFXbHpMMXZNR3JtVXVVcnNHQnZFRmVF?=
 =?utf-8?B?V05hcm1VMnZGeFpneXoram0rYVlFS1pmWnZWVXpsVjNhd3JRQ0VsanROOEN0?=
 =?utf-8?B?R0IxL1JLY2lKdlNvdnZrcGl4Zmhmb2RNZnBmeWMyamYwcG82Yzc3cFZZMUF3?=
 =?utf-8?B?bFc4d2dVL2tuY1VXUVRTQWJaNHdIQUxhS292MTUzTW5CMmtKQVIrSi9kMTdz?=
 =?utf-8?B?ZDZ4ajZjRHdjRjNSUDNyVHkrWFo4R1pvRTRiSDhPK1ZRVWtCRDl5R0hPZm9Y?=
 =?utf-8?B?RC9zZCt6WG9SZDhodlZkMGZiaHQzc2NudHdOc1VXMERwbnVXM1RuR1VxVW5V?=
 =?utf-8?B?am5SaC9uVXBERUp5YzN6OWhVTkcxeXlzK0FlZjBOamRNSlhNeVdpVnZvUGt0?=
 =?utf-8?B?djNRYUR5aUUxbmVCTlFlSkZtRUhndWRqOG00TnNqbGYwYVdGbWxoNUJwTWNW?=
 =?utf-8?B?Q3F3WGcvMXBBNGxUWld6RnJpMHQvMlM5YXdvTXdlVk5wMzZUd0xXZWM4L3Bu?=
 =?utf-8?B?VnJpSnlZSWZCeWZZcXZnREpHeW5PQXBCbjF6YnMrL2x1U3lITE1iTER6RCt3?=
 =?utf-8?B?VzNwcUQvVzRkVVJINmFsb3ZXOTZHVmZPWnhHUUFtRHBPRVZlZHBrblZpcExG?=
 =?utf-8?B?anZwV2N6ajlCNEdBb1ZjRDNDZDAyL2ZNbE1iTWluV1EwemU2UTQvdmlxTGR0?=
 =?utf-8?B?UC9Oc3Z3L2R0emtXR2VPdS9Cb0lSODdoS3BkSHgwdDZYMU9HS2lHK2NYRW9L?=
 =?utf-8?B?VlZRWnVIeFY0NnlZbWoyZEs3SitYRDFQYnR2YnJVREVBR3ZiTENCb0pwMVJ3?=
 =?utf-8?B?c0dkOURraHFPZGNMaFFJQ0h5RzgzK2JXLytpNGowYisybGdWU2FjUm5MdkZK?=
 =?utf-8?B?Rncxckl2NWx4NTgrM3Q3ZFk2T3gvSjl5WC9jV2lTTEQ0c0JzNVJNMHhXWGF6?=
 =?utf-8?B?SWZWQzV5b2pJTFptaDhMaC9yT1gzN3dFZysrWFBlanlJOWlQaDBONzl5RFVn?=
 =?utf-8?B?dVgxZ0M3UGR4dWJQcEx4NFQ2LytScTJQVEFHY2pZTDVtY2lrMEgvTDh4Qms3?=
 =?utf-8?B?ZHEyZ2dJVHZLa1NMWUR1ZDgzdlQ4ZEVDK29ONDFzL2ZzbGZUMytSaXowMURQ?=
 =?utf-8?B?WnM2YjlZaTdib2Q5ZXl2eko1SGY2MDhzUEg1bDRWbUNhYVVQT1lQSXYrclBu?=
 =?utf-8?B?N2lTK2ZKbG9GcFVUWkZQcjZEYmJQeWRxbWVudEtLQnQzM1BRT3BFdWpyRGdM?=
 =?utf-8?B?bFZGby9HRkYwSGgxb1hycERDNmYwaVk2MjBnNzJqWUZDZkYyRWw2ZE9ERDRa?=
 =?utf-8?B?ekRuOERjOU5kVHlMUU5MSWNtOWVtbkF4azc4U2Q1elkrc1hPM0l0T28ydCtD?=
 =?utf-8?B?MXZBd2hOUEJ4eHFEbEpxYStGVXZTeVRaNWFEdGEraWdZZVRGWmJiUWxULzFC?=
 =?utf-8?B?ejQwNUZsMnFyeE9PUnRUSmxaVGp6SmYwRENBN29aNGh3Tjlocm5LbG5Uak1N?=
 =?utf-8?B?K1NTdndqNHFBYng2Sktoc1pkR2pLSXBGZWVKVjNpV1d1Z25ZY1ZOVnMrV083?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0133118b-5c4b-4de4-93a4-08dbcc10747d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 17:18:45.1755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmUfTJOZSD2quAi2WlukLqS8DAiZuqxwfgUX+ih/Z9yc3uq2IZKJcPHAEe5H6FT9gQP75HKy1OOtX2oFFMwSmGxYNKOp+bfSH/RZyHOvcyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6048
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



On 10/13/2023 7:05 PM, Dan Williams wrote:
> Wilczynski, Michal wrote:
>> On 10/13/2023 6:38 PM, Dan Williams wrote:
>>> Michal Wilczynski wrote:
>>>> devm_*() family of functions purpose is managing memory attached to a
>>>> device. So in general it should only be used for allocations that should
>>>> last for the whole lifecycle of the device. 
>>> No, this assertion is not accurate, if it were strictly true then
>>> devm_kfree() should be deleted. This patch is only a cleanup to switch
>>> the automatic cleanup pattern from devm to the new cleanup.h helpers.
>> The memory in question is only used locally in a function, so there is no reason
>> to use devm_*() family of functions. I think devm_kfree() is more for special
>> cases where the memory is meant to be used for the whole lifecycle of device,
>> but some special case occurs and it's not and it needs to be freed.
>>
>> This is an incorrect API usage. Would you propose to change all memory
>> allocations currently being done to devm_*() family simply because devm_kfree()
>> exists ?
> Michal, please work with someone else to get these cleanups upstream, I
> am done with this thread.

I'm really sorry if I offended you, I didn't mean to.

Michał


