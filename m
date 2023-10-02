Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A4C7B5927
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjJBRZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjJBRZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:25:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21A5B8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696267554; x=1727803554;
  h=message-id:date:to:cc:from:subject:
   content-transfer-encoding:mime-version;
  bh=FBpdpFFhK6jrlQdIEfGcDi4IVM2QPFI8lM2yzfWq/fc=;
  b=lxEUpUy0v7dc8ldhSTy5p4zwGk50TBscTleWlxy/HoRfTswkLTEQ86ev
   kJ31xjSDjc5XZpTsPx2XnzpG8IzWUnWgX2MHr9PpmLEuKMl1QKaXX43WG
   21g0mxUNy+yCQ34YwFNoaqQQ7uZTzVy8yJ6zbEd/fiWhcKkvdAXGEQKFr
   SDZPnYYseUbQTueG5UR+yQoK5lmjNhph4MoPuyXyflA0C050a+PGtOiba
   9bhUlhpCbeuI9ml/S9nZhXZrFDQnbdNAdzcTfr6ABVKx7KHc7A/cuQvb4
   hMv9A0EtiTbjh6BWRTUozET3oGR7LOrzIbSSfOtm8BZJ1ZI2zsktZji4r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="386568771"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="386568771"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 10:25:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="997697713"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="997697713"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 10:25:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 10:25:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 10:25:53 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 10:25:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7hZHWYVEpCoWzU/hnt0cPt10dF1ftf+Ld6RLUieHHp4x6VIJcSYPOpmW/osaVX0s5bGUvLCEGft8ek9GnA3fH3HydGYePy3m/7DiguxeTYNCxT3JBpaBstlVoGpOW0RPdOe/I3DrxUBpl256oL/4jqPs/mPF+fdJusxD8dF6QMuYmpIfMXqx1kjR+A6B01IgREjca2gBV/LkmizZiiX4rPZusxPzaqxQekhhM9K5DM7YZk8JZITSM59TRprBqQH4Cx6ZR2C36d3NRgoOLCCtOWOZpHSxAEC0LKkljfPfBWyraXWVDivXrgcXLUUhIT8S0pdZk+xeoRjIHwdGaaajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sodoqKqk03MfQ++Y4kw3QP3G6qKEOXMKkySJ3v08rg=;
 b=VbJjYS1FciEqFWeRzHuOQlblHqpCzs+zDyUqKxuhu2eFMMjr2lf6E9+vouhQtPPfMcs9cKoJkxyomz33s7oH0ClFweHHIgWcaMUSifhGrz4gXCgwSqeNOFxfwYTHZu3gZEI1eRCPWc6d7KXixoBOsNnXsm4+7OlTHdm08AKyEMoLKdADCLgBc6l2Fvaj8mrO8QJkb7FPxVOokLwYEIVURZ6AGe+oQSovAr5Pt3Z0QmNoujoIGS3vvNx/vWJtzw8F1dPcZzTadT3WTt7KqD/NPSLI8l9FqICOhCIh9FOG/gztMmqhBYvVZcPdMetz/x72CPyk4XHDHJWDbColNbqgHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Mon, 2 Oct
 2023 17:25:45 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.029; Mon, 2 Oct 2023
 17:25:45 +0000
Message-ID: <ae3d980a-21e1-4d66-a7a3-7d5f6dc32b9c@intel.com>
Date:   Mon, 2 Oct 2023 10:25:42 -0700
User-Agent: Betterbird (Linux)
Content-Language: en-US
To:     <torvalds@linux-foundation.org>
CC:     "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] NVDIMM Fixes for 6.6-rc5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0115.namprd05.prod.outlook.com
 (2603:10b6:a03:334::30) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS0PR11MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 755f0e39-03a8-4296-3b16-08dbc36c9c83
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qo2kYoZkkKceJkcDR+JfBudsHAkBRq94reFG50WHb6bAWSpF9KqevbN1c4tFAdU8ifCpWVdKX9h1MnTESRTd7hX03GYuZHmm0oys6c7vdQzh+rcCqXKy92EOVdUnoSu8xIl1/Mex0CDfC7TOUFfa5+0PRJHuO9b0EqeDL2m7olLuuWTg1U8rGDOFYa/pnmlGvgYQSGHQKrM/k1tvVNdkaDoT9T4vg0zhJ21B2p+bUvzTYm8aOJfTLi3sfBUh0gG8i8fPpXjN/VsGt6rS3XtqsqI50HSVtbcFhbbO+PwOKdTytTi5m6xt0ZFhWMhnOEiJx0l/IQAxD+2X8ftxgqwdtCOOb/SvoSUeuwh+VX7QdsFtgInSSJxslKh8TNE71WuZHzSn4NQmBOGDdMXriK65fwc/Mj1bNVpGV+5x+RsQMVtSKmR4oMngYzDWIUKdYqrfmGPWuBfc1Ovv0MkxiDb1Mb7PSw26ZreFSUOqiE3QwZ23pd4fDThXSoFRqfGqO6PRueT1kIsUgbJDjUMfiTaY0MYhCHvlMigyUYG2Kpkkco+DSCCF7Wy49DPei3DaBPouZQWLWlidCX/DjRkleXGqMnI//VdN9yjXWGQJ0epCsFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(396003)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(66946007)(2906002)(4326008)(8676002)(44832011)(5660300002)(6916009)(316002)(54906003)(66476007)(8936002)(66556008)(41300700001)(6486002)(478600001)(6666004)(6506007)(31686004)(6512007)(2616005)(83380400001)(38100700002)(82960400001)(36756003)(31696002)(86362001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkFKK2RqbElFU0xWS3BHUlZ0dGdIVmNTK0xmdE4zenFJcXdXM29CdEpuNWhV?=
 =?utf-8?B?RkQ0Qi81SDlCYTZmSk9MeExvdkJNdDNWekJNbEFqS1IzMERiT0JRSldQeW9z?=
 =?utf-8?B?QmRjNUZENXJNK2NYcGRPcE9MNWdBbk81dEZQREd5eFhLQlpyWUFBR28wazBW?=
 =?utf-8?B?YjlJUksvaGZlRjBhWVhHNGpQaWZZWlFrd0l0bmYyOENoK0JYZVFKS0hlL0tV?=
 =?utf-8?B?TUl0QjN0VEo4UkxCR1BlY2N5VWh4RkhuMUsvRGxEcHRPSjV1L1d0TWZZMTY5?=
 =?utf-8?B?Rk9HaEJmbFVEcXBEZ2NMMFczcGRObldlY1pIQ2VhZzZFdmRvMmFwU0lZOFor?=
 =?utf-8?B?OURGRkZMc1YyeE00OWhtNjhpeVpiTmNCemNnd0hsZlVWd3Zzdm9leVJ2NDNK?=
 =?utf-8?B?M080RHpJZE1POVFieXlQbkthMmQzbDdnSEpKUXdFakZkbUNGNmZSRHlScWw1?=
 =?utf-8?B?elBIMEc5RGtzUnlYMTFNRE9TMm9UcGc4cmoxY2IwVnh6bEMrdGdNYWh3aUhx?=
 =?utf-8?B?SGdCZkZMRFdKSi9GQW5RODl0cGpQSmJNeXhpeFl2bzJmMUU3c2FyQUNXTXdZ?=
 =?utf-8?B?b1o1b1R4ejlybEU2Q252SEZCUFl6QWpDbVJEdzN6UGZtaTNQVW84KzlRb3dN?=
 =?utf-8?B?T1BrR1NNVy9iTDl4OURQK2RZbjFWbkVtaG1hMWhSRWdtTHR5bjl5Y3NLdkNs?=
 =?utf-8?B?UDI5ZWMrQVdlbzBJNGNOYVR4dDJmcGxFTUhpVjFJeGk3NUtDT3JCOVVsc3R5?=
 =?utf-8?B?TVdZZE13bTBWWFY0OTlxQ2dTaVBsQ3pZWGJIaElpd010VUNRcTZ2TGttYVdW?=
 =?utf-8?B?KzJPMnNYSU1zenFSR0tkUExBZzhNSDBuUG04VUNxek90VWVjOFl1dmZtSVVm?=
 =?utf-8?B?eXYrWFhOZmtwVG13a0VEUFlSNGN1RWlLazZ0NTVxOTE1eHZIWEdiY3VMeFpQ?=
 =?utf-8?B?QnVCaWhwcG1kSFlOR2hoczhUMXlWU0I0Rmo3c3V3c1VaRnE5LzJrRjFIYVNh?=
 =?utf-8?B?VjRnSE5WeXFodUdIL0lKL3VHbm5WZXlPMjY1MERBZ1h1MzNwSXBDeGVWVGlC?=
 =?utf-8?B?YzVYbEJXcVEzaGpMVVNhaExNVGdaYjRjaUE3U1IzamF3QSt3TlZmdlRnNldP?=
 =?utf-8?B?a0s0ZTlpYVJicWpiSEhQczlqaEdzS3ZYemZqa2oycHVNRUxJQlhyRGdzWk9Y?=
 =?utf-8?B?Zmhrc2lJOG1uSmx3RG84Uk1pTUIyNHhvc0xqY0xMUzBQSUpRRjdmdEpNNWQ0?=
 =?utf-8?B?RHFqL0g0Sjd1Ym9uUGs1WGwySHkrTUlIV1U5dUtiYk5DWjJzZnFRY1FxcWl5?=
 =?utf-8?B?NDVmeVBmTTA0d2xOWHBlbllhMk1GRDd2Q1Y1T3NZenRpTGxIVjdqa0JxS0gw?=
 =?utf-8?B?bDIwWjZ3aVpsWmN5VExXWFdubUxicllNSWYwcE1ZSFpIVXVBSWIySy9BcXRm?=
 =?utf-8?B?LzhmUHdOUy9uOEp0a1NCSHZOZ0F1UlhVUUxxc2tuRlhrdTZBUFplQmh1MjMz?=
 =?utf-8?B?cjFuY1dtWTgvaUZPaU0wbWxUT2syaWYrbkFhUytFblN4b2wycXpDS253Wko2?=
 =?utf-8?B?NEFYZDZaUjJCZW42RDVlQ29uemxEVUpkOWEzR2lGSU5nVjhRbHNtd3p1RUtG?=
 =?utf-8?B?RGloUHZpYzhUalVqUHE2ZU5BZEJmQW5oSUlYaXJ2blFaeUtlZ3dZL1BjaGxE?=
 =?utf-8?B?Ujg4SGlFQXZ0ZHJ5cmFDaXhRVnljeHVzU28wVTVIbnpRdXN6dDZGREc2Umha?=
 =?utf-8?B?cFBxQjMrRzU1MThnZ0ZGY3FQZ0pTTEJHL2ZYODZONng2YmhpWEpmbzMrUk9J?=
 =?utf-8?B?RE5IVjRBVE94RHYxMWtraVZoR0l1eG1JemJqTTZKZGpFNE14UlZlN0JQalg1?=
 =?utf-8?B?dEFsSmoxajRjeTZwM1R6Z1pQaWxNNEdUNnhMUEV1Qm9LUFhUNTFvUDZVN2RD?=
 =?utf-8?B?N2F0ZmgvcWxlYkw1U0dXOVRObXp0K3RRaVUzRWZTSkhzQm15ZW02dzhJeEIz?=
 =?utf-8?B?TmJoYXhOdEZPV3BMMjF5Z2hROE9sYXVYWlhOM0FxeG5CM1lRbnU1TkZHYzI3?=
 =?utf-8?B?N0t1bGtESEx6TVcrU3NPWEgvcXcvL2Z5S2tOaE9uNnl1NXhrTytFR1ErcUN0?=
 =?utf-8?Q?KegpJoh4L9Pp1drwVsvAqM26m?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 755f0e39-03a8-4296-3b16-08dbc36c9c83
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 17:25:45.4385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBe3gv9ycqeaUkb0Yqciz+cF42Ey0K/UpCsH1rrjhq8qyo/zq+AH7/K4xUShcA1wsouzw32V4cc2a+NPepB9zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6325
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

Hi Linus, please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-fixes-6.6-rc5

...to receive a small fix for libnvdimm correcting the calculation of idt size in the NFIT code.

It has appeared in -next for a few days with no reported issues.

---

The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-fixes-6.6-rc5

for you to fetch changes up to 33908660e814203e996f6e775d033c5c32fcf9a7:

  ACPI: NFIT: Fix incorrect calculation of idt size (2023-09-25 12:25:30 -0700)

----------------------------------------------------------------
libnvdimm fixes for v6.6-rc5

- Fix incorrect calculation of idt size in NFIT

----------------------------------------------------------------
Yu Liao (1):
      ACPI: NFIT: Fix incorrect calculation of idt size

 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
