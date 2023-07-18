Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F447584D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjGRSaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjGRSaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:30:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8465BF9;
        Tue, 18 Jul 2023 11:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689704995; x=1721240995;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6M8pvxXSIBJcwdMTji3D1F0RplxaQgVL5aJ/E2oH860=;
  b=fT5zXBzAXPV8Ut8hzbgmJA5Vggm8eyViBdj5VLegXRw6KUr/EZWZCGoR
   s7W8ouHegCRa13F+TuNkdqqnlHoc1pVQTbybHq/2U4FvjcMe/g0Y2E4Zf
   eo7fmDUBRPiMaEHaoZNFFnRiKp8gNcVRr0g++Wxp6wAiQhsVoW4n6I7KR
   ZEaicjE7JR8y7iE2uMOJjXDHquoJrcNtiPJVdR2dtwNC/+34JkqbobeHS
   I1/Lq6voBVggcBJWQVdgmA4+SxJ29zsOrDRTe7jfooehaP+267bmQUzX7
   jCarteJBRo2L2QzC4krkXz3WUF09P4RydVpFsnqS+BtB2Q+MMOPQcd+Z2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="351151008"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="351151008"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 11:29:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="701006208"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="701006208"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 18 Jul 2023 11:29:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 11:29:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 11:29:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 11:29:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U489tFc8EyxQosTchnr47LV5EYHvSh7rRiVLrG5hcQF0fLi+E6ay0nbALTZr0LlPozPJNHmEBZAd7OQ9hxdzGs4u5723+JF08sg2VjaLnmjBOIpzgw92xxpweOEJBGxIWf21hPGdav1uhpFU9Zith0q/0b9p6yAG5plwhipzVPM47I++TxqSZGMDdBztuE1CVLICj8ZenYChf7WDedNUnNb/c+mPNecv+s3rpjxWLdIgkvalbL5eJG/a/hHqbo4njMrp27MHc6yETpfrq+ACYHVY6cjBiMrqHF1ffUltPLM7C5vpNJ37mz67s8x7zRsgj5832940qLL9f7PD63Lkfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3u5nk8/I2irqXslZcbvKNR0zuDUc26cxiFdBqY4/nmc=;
 b=VVlnL0S6u9S93adZ04wzKf7j4Sn4MSX/zXFIdQ3xNAreViqUETXdJHCTkydi3X5uDlS9chgW/Efa2TO3FRV9Sep36c0hNb0J8BYTy8oUZL4z+k6RNqBCffCPhBR/BGXCxxzpnZR6hUV00j9MCIMQjXdz0nGBeJZVzE9IU4ykhrIhudlcZCdw/oa6N6P2fwuzGJuHA5RPGvId4NMwjndP204e1Rf0MCYOWLyri9lpperjhXJZiY37BiQNM9k027yRSyejqlnQPhotcq/mjoPOBOGquXwRXD5aMQVTHwtPOGhVEATyWATme0gdkdqZzVqzZNTFLLqliOG2HWaFYZ19aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DS0PR11MB7733.namprd11.prod.outlook.com (2603:10b6:8:dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 18:29:46 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 18:29:46 +0000
Message-ID: <9dc9674c-9aea-6e57-a7ec-2de954e12a90@intel.com>
Date:   Tue, 18 Jul 2023 20:28:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>
CC:     Jakub Kicinski <kuba@kernel.org>,
        Yunsheng Lin <yunshenglin0825@gmail.com>,
        <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
 <20230629120226.14854-2-linyunsheng@huawei.com>
 <20230707170157.12727e44@kernel.org>
 <3d973088-4881-0863-0207-36d61b4505ec@gmail.com>
 <20230710113841.482cbeac@kernel.org>
 <8639b838-8284-05a2-dbc3-7e4cb45f163a@intel.com>
 <20230711093705.45454e41@kernel.org>
 <1bec23ff-d38b-3fdf-1bb3-89658c1d465a@intel.com>
 <46ad09d9-6596-cf07-5cab-d6ceb1e36f3c@huawei.com>
 <20230712102603.5038980e@kernel.org>
 <9a5b4c50-2401-b3e7-79aa-33d3ccee41c5@huawei.com>
 <20230714105214.39ad4e4d@kernel.org>
 <6c94f7b8-f553-1fce-f3f1-66cdead9e056@huawei.com>
 <20230718111621.35a64a0b@kernel.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230718111621.35a64a0b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:88::7) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DS0PR11MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 1324b9a2-3f22-44ec-82ae-08db87bcf694
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5EkUy/tpupdNM37iG1S09iXb1HJI21O1gC9hIai1n6vAnAKJNR7nydKYEs0lF/AQGTSaUg33nKVYcB03Z0nXTDV37RJGUIxr5liVuml7bRzUJVqypeQtvuGXj6faXRx0GiEBohaz+qo2bfjClOuwrK9p8MktqlpT5rKkCIl/2XCvJEMzxWpYlizhoawUCLlwut+wBJGC5fgM9vuuJjLef3PFeH1p5IT+hDmu1t5fiau1rBt5oyv5BtMTjALOJk8vWCKVkESNp3tsZyJ4sNuMtCGGtzIIMO10e6B7EOPYWp4TS32DuByo9KZtuOLJSIMYg/tS6QFAUi0WxzPSlDwc/2JjkaEN62crrqTV1JF4RMN76XdvWDEFCkGCPlCdcDJY/vqSKzbdz1LdvTc+wfC8wyEVsyYYiRfd7BRSCvWsfE8xa571iu/w+0OxM/MGhnxFju1CyM9xPSxP0oHfdOkLPkLT2kafJ1cXgzpm/45wYfOzoiXN9srJN7nkNXj2XJVUNdbxYSxNOtYMdt7Z+6xHqiONATCF+CJiECnhUkls/w2bibO5S52XiJoM7J6ErurqPTdFyKFLNcLaA5qWcImDA/S/G3Itgwh5eFFmhQCgGWncTY8ydXlOxj4Kvof7mwsZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199021)(66556008)(54906003)(478600001)(6486002)(6666004)(966005)(6506007)(36756003)(186003)(2616005)(316002)(6512007)(2906002)(4326008)(66476007)(66946007)(41300700001)(5660300002)(7416002)(8936002)(8676002)(82960400001)(6916009)(38100700002)(26005)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXUwYjZTR25US1RPaXF4ZlpQaCtnQ3JrZmdOeFR1ZFdEWkVNd3hldXl0WVEr?=
 =?utf-8?B?bkFsNmNGYTVESW5jWFlaeEozaStFL2FtRjRCTmFIc2paYkZJUzQxb2JKR2cx?=
 =?utf-8?B?dFRuQzVvQW1CclJCZXFBR0VLRDZkSGlOSW5CYStUZENqY05MWGYwSVRhUm53?=
 =?utf-8?B?ZStHNGVsRU55SVJScFpQTHY2MVRxT2NNaXlXTXZOYUszVHRZMzJOYkpTM2tj?=
 =?utf-8?B?REw2My9MMGIrZ1lRMGZDSFhIdWxiVmR0RWJWY0NwWFJFYTlhRTkxSThMZEkv?=
 =?utf-8?B?UWZwY1BOWFpybzNVWUlTUG1iN0FLcjZReE1hZ1JqTnBzZEgxNkh6WmQzV3N6?=
 =?utf-8?B?ZTh1b3dkdVVvMXAyZ3ZoM1ZXYkEzaTkzK0ZyYzNaSkp3Y3lzSDFNNmIzSm82?=
 =?utf-8?B?TVg3UWswc0V2NEEyTHBzTW9sd0dQVXdMZHRRSWlldlJvWlF3TDV3YUJiY2RP?=
 =?utf-8?B?THhGOXNDRTEzQVZndjdKQVF4c2UxZWlDa1ZBN0o4U290OUNPbngyMEdLa1px?=
 =?utf-8?B?WlNwWlFBMDltTWx6cEd3SUgrNnB6TWpJOU1BQ2NrekhyaFFheDBxd0tDalJu?=
 =?utf-8?B?VU9YaloyMUlOT1c5d3RJQ0hPZUdtKy95eDN1WVhKb0k3RVFPZjV2dkRKN2ZK?=
 =?utf-8?B?U1FwWndsT1JGWWMwWjBnTEZQaS9TalIraHdDV2pBOVZ5RThKMVVVVm9QQkx1?=
 =?utf-8?B?MGl3Rk1ncytFMTFVcE1hSGlLQ2FmaUo0ajlPQzk1YXZlNkV1VHQvdm5tQ0dN?=
 =?utf-8?B?TTBORXlOVFhQdklxY2FKS2xqdUZRM1gxeExvRGdweUJyZHpuUzdGbWU2eWtN?=
 =?utf-8?B?ZUtob0VmNnB6RDVxc1VPNjVrQkVlNys5YVFDNVJPZ3cveStUUTc5YTJHdWs3?=
 =?utf-8?B?RXEyNEtseXdIR05ONHBtYk52Uzc4ZTdFWFFJYVRWb3paUGcyNXBySnE0blJO?=
 =?utf-8?B?bitidm9aa1VvMCtHdU42OGphQXBZaGp5eGREZ1cwUHphQXNFbGFqVm1lMTYw?=
 =?utf-8?B?N0NwVkt2SXh1NEVYblZoeTlBY3oxY0dvcHBnanVjTDFsbnFtWWFxNDVNMHZw?=
 =?utf-8?B?dVU2L0pXdCsxZzdNT0JPdkU0NUd2R3ZpZXRQcEo5ZWMxaTlka2lFWjR6R0pF?=
 =?utf-8?B?eGtyVWlDaVhwcFAvMC9vUC9vVGJ0RlBFOUJNMmVJNnd6dCtpZ0pkeU82clpV?=
 =?utf-8?B?TjZiN1RXSUNycitVZ04rZGpYaWxYd2RBQlhwYTY5ZXFyQ0RhUVV2RmtiWnI4?=
 =?utf-8?B?Z0tTSkRBN3E4amVUSTB4RnJ0Ty9rc2RSdG5ZNW9vVTBLcWFEb2c5cUlubHJU?=
 =?utf-8?B?QnE4OEdwUjdBRFZoQXlrWnZxRU56R1NDOHVTL0ZWWUhSQ0hrd0xSSzJ1SU1O?=
 =?utf-8?B?Q3QydjY2blJFNFpGM1BtZmowMmJXdjNremhRVmx3bFJGNmNYZDlGMkpkajVD?=
 =?utf-8?B?S2ZURTJ4M2RTTHc4cHRTNjVDa0F4NURkN0crekNrVnplcEZYS0h1amc0eVVa?=
 =?utf-8?B?bEplOFdjaVI2MDB4ODg2K1BYaUkvMndUWXg2TE1WQ3EyelJXV2IxM0dPb3Ar?=
 =?utf-8?B?eGJRWkN3WXBvZnNQNmFZeXlFaUE1YmlPNW1nK3ovTUFEZGFFeFU4NDlIZFd2?=
 =?utf-8?B?ZE56cHd0N0VJTkthRk0zZkJRUEZ2dzUrclZ2S2JKamJveW5CenJ6Sm9OSHZB?=
 =?utf-8?B?ZDUrY1JHMTc4TU53N2dXa3dTQVJ1aGw2dS9mR3VMdkpVRllNbjNtZC9IbHA4?=
 =?utf-8?B?TU1LNVJlalZwbDhsSzZKQ3I3bnJ1dW93NHpuVHJRS3N4SlRoeVR0OGVlZHlo?=
 =?utf-8?B?RDJFTjFRclpDOGtWMzd2TVB3U3IwNHlxeDJ5a1JFTVludHAxZlVGS0lJdm1Z?=
 =?utf-8?B?eXJIaWdDd2JUSVFVUnRHaFJIOWtmMmtPWEI0cEJPOUE4eWY2eFRxM0hTSUFw?=
 =?utf-8?B?T255UXNmTUFvK3k0Rm1CcnJnTnNpYStBK1ZneE8zSmh5OWpaVXNwVk1SYmh0?=
 =?utf-8?B?ZkV1OW1BUkJDR3RJeHVsTjRhSG4yZnpLNU53bXVUSFN4RHVDOTJvaU4vUWNi?=
 =?utf-8?B?cGpyQjVZYW8vK0dlSTh3K1d0MmVNSGpRaVEzT2JSeFBINGdiU1ZZbFowT0tU?=
 =?utf-8?B?eWpvR291OHplZzNTWFJEbnlWSXdmdS9JMWxqbFNmYjMzZE1nOHIwOE5Nb1BZ?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1324b9a2-3f22-44ec-82ae-08db87bcf694
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 18:29:46.6063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+b/zIthomf3DsEREialqdotkgYmDG/YWStYXLtwx3128d9JATuoBpfLVuwtuqg/ihqZVJATqaYPuXS+0jlFb5NHHVpcS57uJQKELJKC7io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7733
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 18 Jul 2023 11:16:21 -0700

> On Mon, 17 Jul 2023 20:33:05 +0800 Yunsheng Lin wrote:
>>> Only those used in function prototypes. Pointers in structures 
>>> are somewhat special and don't require fwd declaration.  
>>
>> I gave it a try to split it, and something as below come out:
>>
>> https://github.com/gestionlin/linux/commit/11ac8c1959f7eda06a7b987903f37212b490b292
>>
>> As the 'helpers.h' is not really useful when splitting, so only
>> 'page_pool_types.h' is added, and include 'page_pool_types.h' in
>> 'page_pool.h', does it make sense?
>>
>> As Alexander is sending a new RFC for the similar problem, I think
>> we need to align on which is the better way to solve the problem.
> 
> LGTM, thanks!

Looks nice to me as well.
Re "which way is better" -- they can coexist actually. skbuff.h won't
lose anything if doesn't include any PP headers at all after my commit,
while yours also adds some future-proofing, as you never know when the
same story happens to some other header file.

(BTW it would be nice to inspect page_pool.h users whether each of them
 needs the full-blown header)

Thanks,
Olek
