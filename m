Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4226078DF49
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243226AbjH3TZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343817AbjH3RIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:08:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B2ED1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693415286; x=1724951286;
  h=message-id:date:from:cc:subject:to:
   content-transfer-encoding:mime-version;
  bh=6mmcdHgN9+ErsiPmHVMnsn3G05goALkM+dzmI7dZCww=;
  b=IWw+11eX9uBL34iJNKD4vhJ4AlR3nI9GTP9CdEDjwNG3ko2pQ226WL7t
   lC6STlpzNO3fQ4BjO7phPcm5UnV0bTzVRUKDvkJmlykgVT5cpIvfRRouv
   RMG/GUqig6PRvoDmw3mkGZZ+CYlRmP6ypnpdadDlUEe89ChOzSapJB1zW
   L/60fI1/E8QWKIgUYV9jPNJtpN8yFsWYD2fqdXn7rrtBtHTfJCvqm6OEh
   0WlEmEqiRMsWlkvzVQ9hQtACVk3P1RJOpMSu80vNjxwxnNrzJAclxMdbk
   Mst6jCfmhzhYBu/ONCdWrE2lrDPLBppyowKCDOV1JXP4+syvpJhDJuhxs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="356017289"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="356017289"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 10:08:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="1069903536"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="1069903536"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2023 10:08:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 10:08:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 10:08:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 10:08:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 10:08:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BV7DRu4eAaPbU+cMsOMDoa1X0VIcUH0aBhOk3zY/52MwqcaNLfD8736LqF/jKtvTOX9fLcDgBZI9+G9qgs3vJzeKBPjOTneS5/NOcYnrzGNj7MZ6Tyzq0+NPYzqX+sr53OBW1t57LjSgaXlOX6pEtbLKisg3eNTqzqm9Z3FZkCuoj79v6ygiC+DXli+sdjf18dKkJXE/s8rqXM3C+GSM6pbCLsq1RlMOjV1fuh0CaLc59dIz4e0fRMea87QCh6kU4XaRdcG7MOmV64zpc9Qycbh9L/s0u1ihPHcdlkoLAwgEPrlao+tqVReFmhLJW9wkj9lfkuHk5DOqiLdPR+BJDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SVowNJ79wTLx9fNJCz51f4fUvLom/ADlllM6hDY1s4=;
 b=WKyep0kq+jNDMGT/6UZqoNfv26enuh/y0Bap4qXCszpBhIF2MizvuhZp+/xKue5R5haFB5C9Zk/SEUd19HZ2/wCpqKGzqQ7VnCIHrHncAEhS5s17pn5FH4Cbiz4v/pP+VpVJB093XT2lbUA1x+45gVhSEtJ+6oHfC5y49LZ5DsMDPPxmsSBqHotTY8NkEB0anw2XnnVNmmRJdz73cJkQLNlPBeXed7AxSUmysJCLaCymIyWYEi665KwMUTvKpb+N7JMmlIZHX9pLTUSmzZMec8EPbeN00renLC/5QDkNIXO8ukdzZzySggEsX7jcUwWTT6zCUpGMAhxqPx0M5kvhTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA3PR11MB8117.namprd11.prod.outlook.com (2603:10b6:806:2f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Wed, 30 Aug
 2023 17:08:00 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 17:08:00 +0000
Message-ID: <12c76f8e-aae8-2cab-4ab0-571a8c806423@intel.com>
Date:   Wed, 30 Aug 2023 10:07:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
CC:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, <nvdimm@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] NVDIMM and DAX for 6.6
To:     <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:a03:100::30) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA3PR11MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: 432722c2-49a0-41bf-1063-08dba97baa08
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ct8kegPgE6vc8OTxTlRQ6N4pQTle1RQpQDZh0hNYj9p0FzI02ufb+Fix4V5870kPmPAnwi1ZGFhasAiKqtUzMLiSydZcsxioTfxfD8Ba291AGcZTjWNBg9+O6LtbohlxEJ6ZSnH1hEMA+7ABPsHhqNG1TXtQwVAvxrkN+yrIk99kyzxivYR3uJZmxH/inuchdczGCY9wSRsGLCRi0GMd2ByxEozdbbSmtQ7F43ThcNU5HRPLPhjLZtDv8fLHZKd7zwPPaBHnDNv1hqzh1Jz2Z51Jn1zHNe1IFtDLP8CRC6QcElBZy9pnjrCdkUYbTbld+aQjP4brs1RnJY3ANeykGnFrCDYhrDl7E2dpgnw5FtJhZg5/vQ56QqWUGbjaJMkbdH846NfvgGm1qA2IWZYsMT9yDuM2jQnkyvUGy/bdxpFTco2e09SHymzP+Sqf4IUxwXaJct95cUbU4v7J+LhzUkGCLBk+e/hQ0aC1sN9murmrQCkTpfvQoswWEeLnOF8ZmV1wZ+UDRElph3IOBZYfOIHA5avLmFsTKC7pqt+iAULQ0owDC7Umf0fR7MnCERpY5VwbMtZz+vXb9928DUSytiFsKsasCwFddgw6TfsOL6ASVE8R2EahPUHlx/1g64tBzGvOnjn806AXz7Ag8lpVBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199024)(1800799009)(186009)(6486002)(38100700002)(82960400001)(8676002)(4326008)(8936002)(31696002)(54906003)(6506007)(6916009)(41300700001)(66946007)(66476007)(36756003)(66556008)(86362001)(316002)(6512007)(26005)(478600001)(44832011)(83380400001)(2906002)(31686004)(6666004)(2616005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDdIZS9ZSTVBUGxhWEY1cDI0ZU5QdzFBTzRONzdzeE9jOXR4UUJ1TnN5bXhL?=
 =?utf-8?B?Y0NEajFzZ21yNnRJUFZTbUx6YzFMYkc2WG9EL0hwTEpLTWw0ZVVtS09jRHJz?=
 =?utf-8?B?T21JODFMQUx4c0U3Z096NmpsSERDTG5HNWJjSUJ4eUJBVVZuek1GQlQvcGhn?=
 =?utf-8?B?TDdLdFp4eVlFVUFuSFREQ1Fza0h2ZWRFUDZMaDltYVFnZXB3aVVLQ0ptWWYv?=
 =?utf-8?B?SllackVDSXl2V2ZWWTlrRlQ2Wk95NTZNZXFKRUJoSldMY25VMXNHMVQyZVcy?=
 =?utf-8?B?Sjg5VUVjTUFvNFNSOVpqODZwazlWUGlnNTl5MU02ZU5aaTZlbzVaNjVZeS9t?=
 =?utf-8?B?VFlFUkZicWpZaDRteDlka1pkUXlSTHIvdUNqODhvNk9ReERScUdMV0ladjNi?=
 =?utf-8?B?MUpuWldYRUtuaFVmNmVEbyttRkxyZXB2MldlL1Z2UlZ4VWtMWDZTdjVhamww?=
 =?utf-8?B?c1lGM0pJbDFZbncrSVFEblZjdVhleXJNTTRHT0JzYlIvZDZIM3pEczAwZ2dM?=
 =?utf-8?B?dENZQ2pOWDNDenEycHg3RDlrS2FlYlJUSXMwOHh1emhKNGxFZzVnSEw2Y0U0?=
 =?utf-8?B?bzBYbFZyWDRWQ1hXajZIMTJMSHh1WWFRK3NhcU43QTJyeW8rYWwvUUJFYjB1?=
 =?utf-8?B?eU1IQ2lVc1ZVOFo1cWR5c3pNdDVZTEd6ajhjN1dhZ0hOWmkveVZLVlVYUTFw?=
 =?utf-8?B?UXpuU3o5SWlaUzBISVdlUHJtL1RvcXVqSDFQb1BoeUxhWTZiSElBOUl6bnlI?=
 =?utf-8?B?a0d3bW0xcEV2b1ArQ1VkaGJieG5yOVBhTi85UVRUeTM0c3ByN2V5Vm8wcWF1?=
 =?utf-8?B?Sk51UkZodTNwcnRJbmNjZ0JBYkFzeVE1QjJSZVREZkF2ZDVWbTdsbkVuSDJR?=
 =?utf-8?B?dy8wb09PSXN2c0JNcDJDR2xxQUpwWFVMMFFhUUluUW91MzNLbnJ6VzBGbFgy?=
 =?utf-8?B?NmtFaG1XVzdNSElBVDFyaFcwMnN5N25jV3lncmtzYlFrVXFGSmwwUytuWlVP?=
 =?utf-8?B?RkpXRnEyalF3dWR5bWpwcHNiUVpQUFJVSjBzNlIveFI1ZXNsMTlndFJwWVBu?=
 =?utf-8?B?dXZRN1FpK1RqRVJRb0Q2OTdZcGpPVkFHbkExNk5pN09aSzV3bjNDY29tdUJk?=
 =?utf-8?B?WFZWSVRvRjl2azV2Slh1ZDBkZlFjN0d3YjloL1gvc081Wm9KNjhXTnlTTFIr?=
 =?utf-8?B?bTFMZHRpRDE0dzhqZk92RzdXS0Qrb0hFdWtGZHAvS0w5RXJialNLUlhVdWNT?=
 =?utf-8?B?QTVDYldvYW5Mc1FMNUhHL0VqQXdwQ2pUU3pOdXlUbUpYSGxRS3phODFyWFpU?=
 =?utf-8?B?WEdyS0M2NWppblJvaWVZZ0pDQnI5Y1hqQXg3S1l6bUlZUlc1R1EwK2d6eHBN?=
 =?utf-8?B?TW4waUx4T1RKckp2bmVoS2NwZXVBdUM5SnhzOElGYWs0bmlQallNdHIwQlln?=
 =?utf-8?B?eVRaYUl2M0E0aUtxLytDSXR3V3lSc3FSb3kzK1J2SldFWGpTNmsvL2ZvNzhv?=
 =?utf-8?B?QTRMT3JjK0pYZis1YVVLaDZJRWJQSi9KSjhHRlY5ZktoMzIxUDJIS3VyT1dQ?=
 =?utf-8?B?T01KQjZUMlJkay9FYUx3TUo0KzlWRm1vTEtDUWxyTGNsSlhhNWRaMzlaWGFI?=
 =?utf-8?B?MHhwQUhiSlJhc3VGcURkdnpmQnRQMjRzNnFsVzZ2a2FHUnVTa1dYMU13dHBX?=
 =?utf-8?B?SUExOXpNNy9NUlVYWjJSYVdrUk52MnVMY3FkQ1ZPbUJxRHloelhhT1loRjJt?=
 =?utf-8?B?RFpSNlUxRXBpSENlS2M4TnBNSlNxNENkdEVMeDc1elcvaFdPQS83aEp0Y2Fm?=
 =?utf-8?B?cDlkK0pyMDNRSmpieElXdWFyM2drazBudFVvK0dXR1ZhZ2liRUQxeDk4SmlV?=
 =?utf-8?B?QWVkRFVXdUY1dFdicG5iQlQvK3BBNlBZemdIWnhRak1VeUJYUDBkRkRkWDV6?=
 =?utf-8?B?NUhDdnRVT1A4MnN5M0FmTWo4b3M5eXcvdUpVQS9KUVhrcFpmeW04NXRrcDNu?=
 =?utf-8?B?ZVNHUFliMHEvaHh6cjlWVldaS2U3WmprRTFLNVpQbXBTdW15OXdKaXo3eUNi?=
 =?utf-8?B?VFJwUi9XYlcxMEErRXYveEN3bnFLWElETkE2aURueDFUSUU4SEFqbkZPcUR6?=
 =?utf-8?Q?88u7Mxa/tFRNRLxwWz2RGFw+9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 432722c2-49a0-41bf-1063-08dba97baa08
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 17:08:00.4730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRShJ0tbIsDRgjg2bEcxpqUz6g9HCxVTPyLR41MwsWav8Z3DiMxUaF92m5oMIaBFgipFjhT/pCJEI/6V8CAJ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8117
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from
   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git 
tags/libnvdimm-for-6.6

... to receive the libnvdimm and DAX updates for v6.6

This is mostly small cleanups, fixes, and with a change to prevent 
zero-sized namespace exposed to user for nvdimm.

It has appeared in linux-next with no reported issues.

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

   Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git 
tags/libnvdimm-for-6.6

for you to fetch changes up to 08ca6906a4b7e48f8e93b7c1f49a742a415be6d5:

   nvdimm: Fix dereference after free in register_nvdimm_pmu() 
(2023-08-17 09:34:03 -0700)

----------------------------------------------------------------
nvdimm changes for v6.6 merge window

- kstrtobool() conversion for nvdimm
- Add REQ_OP_WRITE for virtio_pmem
- Header files update for of_pmem
- Restrict zero-sized namespace from being exposed to user
- Avoid unnecessary endian conversion
- Fix mem leak in nvdimm pmu
- Fix dereference after free in nvdimm pmu

----------------------------------------------------------------
Aneesh Kumar K.V (2):
       nvdimm/pfn_dev: Prevent the creation of zero-sized namespaces
       nvdimm/pfn_dev: Avoid unnecessary endian conversion

Christophe JAILLET (1):
       nvdimm: Use kstrtobool() instead of strtobool()

Hou Tao (1):
       virtio_pmem: add the missing REQ_OP_WRITE for flush bio

Konstantin Meskhidze (2):
       nvdimm: Fix memleak of pmu attr_groups in unregister_nvdimm_pmu()
       nvdimm: Fix dereference after free in register_nvdimm_pmu()

Rob Herring (1):
       nvdimm: Explicitly include correct DT includes

  drivers/nvdimm/namespace_devs.c |  3 ++-
  drivers/nvdimm/nd_perf.c        |  3 ++-
  drivers/nvdimm/nd_virtio.c      |  3 ++-
  drivers/nvdimm/of_pmem.c        |  4 ++--
  drivers/nvdimm/pfn_devs.c       | 20 +++++++++++++-------
  drivers/nvdimm/pmem.c           |  3 ++-
  drivers/nvdimm/region_devs.c    |  5 +++--
  7 files changed, 26 insertions(+), 15 deletions(-)
