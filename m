Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275047E1D4E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjKFJe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjKFJeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:34:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014A2C6;
        Mon,  6 Nov 2023 01:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699263262; x=1730799262;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pg1crNRwfAlkPVDD/isEy5E3YgKPdYQp1QtgiyUa904=;
  b=RwOrSr9QwjsTZ9uw6+KNPLFXT5wVlsU9Oq9CT1GM3mfnKtUN5M9gEF2B
   MAJF7LePPFYxkdbD0S05R9lTmFcadxAcDeNOrAN30+tDW5VJxMCd9bNne
   IscEQn6ElgHZafAlskCK2k/vN3Q+nKTIPFP5oN0bvsBDSx94Jdl2uFtuI
   qhpniGud3+uXcNfv7kW2TlJuBZdpotKhuWGzej2If06EntaYjRRm3CsX/
   OCF0C4FyWFFl0LTEvjMSMcaYcLy5CemqrIop816di7ODj6U0XS5XdnDMw
   Ii/hvLblnQ2M7ObZhFheobLaMbWDlZQLcuGqDgg6KRmiNjpQd84cGb/pY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="2228419"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="2228419"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 01:34:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="905997458"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="905997458"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 01:34:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 01:34:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 01:34:17 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 01:34:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwqq2I9qjbHfROJx6tU9p2HVtOQ24zEqtBtarXLw0oJQTuB0FNtVEwVmvP4YYA9fIg+0MSa/0ybvMt9ypsiA2pE72QeDQHRO4hUAtuc/d3QuAgxoCEa/ZucrgHP0vcdtBuT7r6oTK79aOfj9o99C19XueDtSuUyAicEeEpQoqB4gLJyaEylq2obYq00CT3KFsZCFV7nioTfOg7DCMFvoys73Eh3f+7Y1774ZqtBIXlueqNflVOSn4Tcc8YljPQu9V+Wf6G7l0PXPe4RLa9Hy+3QgvlqCR8JFKFo/tP436miR1q/G3Ha4zCTxBcDZJe2r3BJVKSd5Yvv5mkIICnbATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7aQ30prH2vMgdNFM1kFld2EnOXU2kYs0JDcVfJ3Hew=;
 b=Kh+z1N9eY0efiVZ8ucMIqQLlLL5ZpLkUQv80YA6qf2LYuV1XwSVVS9HLMFiwpgf5fcmKc1iTcmQhlIb70OnQKqcQtlJSZI6aIfQxOAb/u+VfD6KWAWy4kTW2MeC8ZLG1wVzpxa6UTcV+5hFIP3FzgANZTMjH+KP3DRQh6ay4YAerh/JMR9Qwlde8QU5m/krHzIn6dmnSp258Yom896N50weZrTjAfjIH2numQifiEVTWqsuVk0Ykp4B8H6MWSptvBmi+CDw472ZTiPsPXMOiaXR7TqgeuSNNsnyT+lrPcDKVPfdjZwDuHgKH1tQmLF5byacXyJk4//8yFcQJkGS8zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH7PR11MB5817.namprd11.prod.outlook.com (2603:10b6:510:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 09:34:13 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 09:34:13 +0000
Message-ID: <5b0f8705-71cb-4c4c-a70c-d9d3a15886cb@intel.com>
Date:   Mon, 6 Nov 2023 10:31:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [alobakin:pfcp 5/20] drivers/iio/imu/adis16475.c:363
 adis16475_set_freq() warn: set_bit() takes a bit number
To:     Nuno Sa <nuno.sa@analog.com>
CC:     Dan Carpenter <dan.carpenter@linaro.org>,
        <oe-kbuild@lists.linux.dev>, <lkp@intel.com>,
        <oe-kbuild-all@lists.linux.dev>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <ff4ef031-774e-4e4d-a009-31f242bf6aee@kadam.mountain>
Content-Language: en-US
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ff4ef031-774e-4e4d-a009-31f242bf6aee@kadam.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::21) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH7PR11MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a35cf7-cf71-4dd6-eb0d-08dbdeab894f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z15vW7jMPSvLsM6buaWzRjcYy4ZTRnPJXtXNgFltbOMsfErxoZUDbl/WwMSudSiIm3r/aZbjjQD6ZE0hst1sKVqUgmFnXgZjdfHeWbzEUdscLwgu+Bpo6DjmE+7vv3Vknd9pF+G7nA8/RQHeY5yeGe1SjvtBLeayx4jdR89zGCryGGo1MLjUU9La0FktUIZL7PbjmJoR6tLc00oDDLgGOhdxPahOa5pHYWzihVJRDF9chxgzEHm6/c/wgvFiNIIuXfF/Kkf98hqh+tOXscsl5VBBgMTL3dHRuDXCFAsQ5DE7KN13l7azBe+U6VYGyq8dqENn8bQUKnZYAsnnIy9fJq/7P5RKL02eFbGf52LAxtAJ5pQmUakAAxuBI48bOhBbG3WtW+GGRgJlP50K1/gcH/W00fSgd6gImfzH4xPKHsTSaFvYvV8AWzA6civPpE0DAz0lYG0NklGkPtQBFaCPZFjAZMOB82cZbsFE1MulebqL1bf4RFsME9JNSbQ5cM5h6NYpjo7cRZZ21l/6Y7N66/0utHyOlZ7wbTSOaeOIKa3JlN/9JycYDE1PqStuMO/HFvVfldcEGlcCbHqvZSG+fbucBA+Tuvt6QOA64flSGlLrpH5S8PG+5fGu5c7y7TaDvYopKGImclYwOG1cfwSzhGWTFg5+Uwt9VQX3lBssZyGyv8XeepnRDRmJtw9obXWxdJv8oSl37Wj2gS1WxjOfLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6916009)(4326008)(8676002)(8936002)(41300700001)(36756003)(2906002)(38100700002)(5660300002)(31696002)(6486002)(966005)(66556008)(6512007)(316002)(54906003)(66476007)(31686004)(86362001)(66946007)(83380400001)(26005)(82960400001)(2616005)(6666004)(6506007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG9iWnZoWGZIOVFrZDlZMFRvYzY4YkZCTUZPRkFmSnJqVDQ0Zkdhd2NYZjFj?=
 =?utf-8?B?L2s5NkszbVZuUnlCMU5SZWlDSElac1J3Q3BMdTc1UU92cUFvdVdyZFRJTDFP?=
 =?utf-8?B?d1BNZ0dkN0l2UlNiZEtIYXFMTFpneWg1eEsvV3ArR0NraVloVGx3TjUvaDRD?=
 =?utf-8?B?aENIem5jOEhockdMSWl1bU9wWWhIc1FGRU9WS2luYytRQnlWd1R6L0RhdkpJ?=
 =?utf-8?B?ZEVPV25saDRIYi82OTkzdjljcVpMMVh5ekFGb1B5NEtyb3Q4eDdleHpXRlow?=
 =?utf-8?B?dENMOHpUM1RtUGE4ZzhYUWxPN21kUDVVenlHaGdKTXBsVkU0aHZCd3c5dWpO?=
 =?utf-8?B?VTMvVDBLRzFiT0UwZE41OS9wT3J3VXc0Mmx0ek5PVXZGR1BadkV6QXcwMW95?=
 =?utf-8?B?ck1DVHVNVHk4U0hjQUtsQXFYekE0bXBmakUwRGRoSU5UN3V5K0xFWUoxa0xR?=
 =?utf-8?B?OW5QUW1MSE1MbSt3NTZYbWxoZXFSRWRrS2E1cC9pMmh2WnNMdlR0bFBSQ2Y2?=
 =?utf-8?B?ZkxYK0U5TWRBbUxzTjBvRHFCRmJqYWVxS2owQUJmSU1ieVArRURjWGZrSHNP?=
 =?utf-8?B?enBabEJMeUp4clVJeTZmR2VTRHJGbzB6SXdQd1Vpc1kycXByL3ozeXdxa0xX?=
 =?utf-8?B?N2J5N3l0ZjYzY2thd3JtZWdyRXVZMXptS1VCNGZmRXZUdi9IdlMxcDVuakIr?=
 =?utf-8?B?YlE0TUtUSlNFZUtYaCtRb3ppeXlYeXh3MTFNc3NWc2lyK2ljbHp6cXJBU0JL?=
 =?utf-8?B?bHJqZEkrRysvT3lmcGRhVFMxWGhDZ0xaMHFyUFVLTkZmMTc0K3lUSjlPd3p3?=
 =?utf-8?B?VzdlVDVzUmU0dVNCSzQ3MFJIYzBJQWtRb0VyNGpBSkpySDJPOHpiREhhYzNY?=
 =?utf-8?B?RXdTTHBRd0JyV3lmVG9GZC9LYXJqL2N3cjMwUnRtTFdpRSszaTF2dHFiaitn?=
 =?utf-8?B?Q0pMZ3ZpUG9oczFpK2R5ZnhDNC9pdGFRREhjeFhtQjBxNDR2K1ZyOHpkRFpS?=
 =?utf-8?B?K3psaWUvRjNrVWk0eHJqQ01RajZod1NlcTUwRktDTjdmTVc4aFNyVExsWU9I?=
 =?utf-8?B?RjZNVjJTdXEyMGxqOUttTGwxNjN6TFpaTWV2R3FjazNsSmRrcWZiYW1mNmpy?=
 =?utf-8?B?c25hTkwvNjVVaFFRd1RHL0RweTI2WHN3R21RU2I3VkZUaXFlTE80VnpoRjN6?=
 =?utf-8?B?YWZZMHA5ck5acFEvQWFyMmV0ZzFaZmRoMzlSR253SDVPRmlzd3hxTFFYTUdV?=
 =?utf-8?B?bDdXemtjVHJwc0ZyTnB3aTE2Q3p3T05aQ3FrbjNKSTQxTHlvNHV4Ly9DV1Mv?=
 =?utf-8?B?elpiN2J1cGZ5VHl1YnpCOFVCa08zMU0zdTA1UXAzNDc2WGkyQS9lNndDa3pV?=
 =?utf-8?B?ZUNhRUxnU1pPN2ZNMC85YWNvblNKQ0F2Y0M0dHhsd1VZRENZQmN3OHg3L28v?=
 =?utf-8?B?VjhMZ2Ftb1RiR0lGZ1RQWGVxei9uc2E3M2JxYVEyR3k0QUR4OWYyYWdrVW9U?=
 =?utf-8?B?c1NzR0VyYTZjWm5ocm5lc2U2UmcvVjVIdjN2YUxuUHVTSWJmeW9Mc3RwTlVC?=
 =?utf-8?B?WDRuOXpqY000Q2JueHRUaDIyUXIwZjRrUnRQTTRmai9SWlZEM0p0NG94R2dE?=
 =?utf-8?B?SkZHTm1ad3V1V2RLRnE3UmRlNzZsSmw1MG4zNEFoTDg3NGtvSkt5L2VOY0wz?=
 =?utf-8?B?ODJqWE4rcHdYODJlVjdMelo5WkVSUlBwOGswV3RqWlp1V1hZT0lTdzRCeVdR?=
 =?utf-8?B?STYvY1JGNnNSb3l2VGhnOHJyLytuU216SWdNMERVRitnZDVrdTVIRlpwTGJI?=
 =?utf-8?B?OGZzMCs4SnBmZitCVThmZDZRTDY5Um1qR1BJYUN6Q3BKdmpxOWlVbys3dGpS?=
 =?utf-8?B?bFZwTWFXMVF5eXVMV0YvdGtDNjVQbmRsa2wxVXBqRFR4YXg4S1F5eUErVXlY?=
 =?utf-8?B?bUVSbDJBZVpJT3hPZU9PWEtUbXZFbjdUYkdrMnVvTzB4YVRjQXNKb0ozeHB3?=
 =?utf-8?B?SDRMbkxHUGxzelV0bmVKdXB5eHE3aGxNWElPTjQ5TVNkczBQbDA0bytSZFo3?=
 =?utf-8?B?UDJLOGdOVGdZdEpmNkZNeFo3MURlTlNiandLSEFETVlYUUVDRVgwbXJUY3g0?=
 =?utf-8?B?RWlqVURFUldRWmhVRnhURnpTY3cvdlFkM3FKWGpVTXVOZ0tuNi9sQ2VhYXFL?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a35cf7-cf71-4dd6-eb0d-08dbdeab894f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 09:34:13.4604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0TpdiXmuwOC9uauLYERgtAt/9jhjVbHImg5BsLlD7BxpjFNGzhnZxsODlIVgyS7EPA1tWjpU87GzDbfKnFun6/GKpU3ED5mLJnQJOJvuyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5817
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Mon, 6 Nov 2023 11:50:03 +0300

Hi,

> tree:   https://github.com/alobakin/linux pfcp
> head:   89565e300e3d4033b8bb568774804fdc09d4f3cc
> commit: 945a0d6e86d97bf60f2fae88ee557ed3eae18b94 [5/20] bitops: let the compiler optimize {__,}assign_bit()
> config: i386-randconfig-141-20231105 (https://download.01.org/0day-ci/archive/20231106/202311060647.i9XyO4ej-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231106/202311060647.i9XyO4ej-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202311060647.i9XyO4ej-lkp@intel.com/
> 
> smatch warnings:
> drivers/iio/imu/adis16475.c:363 adis16475_set_freq() warn: set_bit() takes a bit number
> drivers/iio/imu/adis16475.c:363 adis16475_set_freq() warn: clear_bit() takes a bit number
> drivers/iio/imu/adis16475.c:416 adis16475_set_filter() warn: set_bit() takes a bit number
> drivers/iio/imu/adis16475.c:416 adis16475_set_filter() warn: clear_bit() takes a bit number
> 
> vim +363 drivers/iio/imu/adis16475.c
> 
> fff7352bf7a3ce Nuno Sá 2020-04-13  357  
> 9da1b86865ab43 Nuno Sá 2021-09-20  358  	adis_dev_unlock(&st->adis);
> fff7352bf7a3ce Nuno Sá 2020-04-13  359  	/*
> fff7352bf7a3ce Nuno Sá 2020-04-13  360  	 * If decimation is used, then gyro and accel data will have meaningful
> fff7352bf7a3ce Nuno Sá 2020-04-13  361  	 * bits on the LSB registers. This info is used on the trigger handler.
> fff7352bf7a3ce Nuno Sá 2020-04-13  362  	 */
> fff7352bf7a3ce Nuno Sá 2020-04-13 @363  	assign_bit(ADIS16475_LSB_DEC_MASK, &st->lsb_flag, dec);
> 
> assign_bit() takes a bit number like 0.  But this is passing BIT(0) so
> it's like BIT(BIT(0)).  Which is fine until you get to 5.

Is this intended? There are 2 places where you pass
%ADIS16475_LSB_DEC_MASK and %ADIS16475_LSB_FIR_MASK, which is `BIT(0)`
and `BIT(1)` respectively, to assign_bit(), which takes 0, 1 etc.

> 
> 
> fff7352bf7a3ce Nuno Sá 2020-04-13  364  
> fff7352bf7a3ce Nuno Sá 2020-04-13  365  	return 0;
> 39c024b51b5607 Nuno Sa 2021-02-18  366  error:
> 15aacc980dcb32 Nuno Sa 2021-02-18  367  	adis_dev_unlock(&st->adis);
> 39c024b51b5607 Nuno Sa 2021-02-18  368  	return ret;
> 

Thanks,
Olek
