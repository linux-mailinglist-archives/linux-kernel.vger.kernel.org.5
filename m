Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE92E7E93D9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 02:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjKMBAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 20:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjKMBAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 20:00:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E720E19B4;
        Sun, 12 Nov 2023 17:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699837234; x=1731373234;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=pZQrNGVMQSFe7JEaVi+nvFQQXtuD4VF1WZAcymOmwUs=;
  b=SkX5gikw3NmUDREOcy+0VTdu0mLP2W/cX8Aw3nSkIBZVnInIKnG/v8uA
   k2MSDo1eJRYiwBaGz2YJPJuKD1W1YmhgKaOqxbczucCYpW2ij2cNb5giH
   9EKKL13dEXBxA77BgI3jealFr3RHf5vfbx9oN45hC8wO/pgZgQOe3iYdw
   DdQYIOAtj1a6Bh52Ggt91unb9Gp1RkaIEjoNK0v8S6wP6JkvKNvhyemmU
   oYV3BTzPCP5FWqW5R1mSeyJhE0gh3nHjFIyKJbedGF2/ax91+/SkXKHOm
   dIzaWj7zhAwfb09WEDDe/t90cR+uZ/6wQ4PG3vaWuRiN3mSsd0KM9MxlQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="369691447"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="369691447"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 17:00:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="834596490"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="834596490"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2023 17:00:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 12 Nov 2023 17:00:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 12 Nov 2023 17:00:34 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 12 Nov 2023 17:00:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnuhEsz3rC+V68swB+hepskkV1KakUmoF9zLKiL/HKENhVDusiB69YCvkPQNkI7yj8Nb/D2NsX3yvcyTaYLcAYPQBdfPdCyVSWIyVJXHyvd7yjcyUdgRoLeZZ6e+t215KNA/oDJqTg99jNblnoTKfZYGx8Giy9xhawd1Vc/0U9pb+lqbgP115q44w/2ow7UaLzU2OeMocDVHMMaUFHiDXjMbiwvs2U03IUM5kV8OPrb6DWJLnsix65Nickvl7D05y0TE3l2eoowYH1c9DRl9oeGDP2RHFe5nd/gGf27X08B1KHFQpYTVhP070srMFYAQDrsB3yM8X7Lk9xEW7kmWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uy5gayhkWBzRT6605Q/BD/ka6au+1CQ8ly6LfatJPbM=;
 b=QgSkVHKAJODrsSNCTrd1Mhk0E16jojGhsvuYlG1l22AVEIJWk7/0Lwvz6otY/W48fpMkSmR4RyeVMxMXOorXZ+S8e9y3gqBR2IQgHz065GJsueJp0qqUXpCkbF4uueK3K3q6fDXFQ1NCiN+FT2I00H8GXklvocBBpoJz3FlY9yvvRqHdk46npH3YiEzqeugx80r4pEHietWlNWJmIbsn7BUf0108TkZSOVYkfO74gdj3hUC4DsSnJkfnzPFRFs8AixfkrYoZy08Eyc/4ty+YXT5JPiOH0eytm+PPSF6UCR6hw7+rQLHn0l4WI0UT6HjeGRfQJ+fTAIw/gsm0h1AStg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SA3PR11MB7415.namprd11.prod.outlook.com (2603:10b6:806:318::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.26; Mon, 13 Nov
 2023 01:00:31 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.6933.028; Mon, 13 Nov 2023
 01:00:31 +0000
Date:   Mon, 13 Nov 2023 08:55:48 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     <oe-kbuild-all@lists.linux.dev>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, Karel Balej <balejk@matfyz.cz>,
        Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] input: touchscreen: imagis: Add touch key support
Message-ID: <202311130533.EStBdAmT-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231112194124.24916-1-duje.mihanovic@skole.hr>
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SA3PR11MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df8021d-f636-4e9e-2277-08dbe3e3eecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f3LqTtDxBIFWmNMjnpRZ03UwNJH79Q4u+DG8pKDGizQ3hKQ2kohw0bbUmIj/UPxj6TLjGkAilcSl2WiYRgoY8Zt84v6MsYT2JcjLGjsKXZrnrzA5Q/BMUoq7rdoDIzEaddus1jn+G22jwvK8qsBT9xV7KjcvQA5GstMLiCoB6ej0KTCMKj5as4Ou07zMmmgNtkk/ruAo3ThYlqogtIvOocM7t50g6akxArjzjmIrLe+RDQf5Eb1J54avxbY6MZbMhWLzdJh+X249tiqzL9VgjNfYeigGdniRxIrZmfT95vzU7r1rmz7U4kf982L0At9mGqi9ZpMXMOQ44U4ZYW2TrpsCqK/fa1ypYCGxZHFPRsJl+bBCHyrRA5fKufVXWjzt9MEO52xKxjAB4Sxdl6BaZwtqNc2pdJTkMG8zRCwlnKloHe1WLihZBC5fpaWZfeGWO5LzYXNlalnmbMzcEedspDzcC8Tyn+xgkE9ML3j/fRUF/Yv5igwX5kDJz5O35ISiCc5EM0hjQamOdIE/ZHlk3aIAgzOc1gmKK5zXbNjSRhPJU9Po+pp8a7Pd8JZjIK4jx7vi/N+hiY4jEzCpOGsO/f20ihG82AZsfGjqFbfoktrr0gjJ20SnD/Mcm+z9c3xtS0jJ6ZT40RcfCkO1/HLFoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(230173577357003)(230922051799003)(230273577357003)(451199024)(64100799003)(186009)(1800799009)(4326008)(8676002)(8936002)(1076003)(26005)(2906002)(4001150100001)(5660300002)(2616005)(86362001)(82960400001)(6506007)(966005)(6486002)(6666004)(36756003)(478600001)(41300700001)(38100700002)(83380400001)(316002)(6512007)(66946007)(66556008)(54906003)(66476007)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDRZbmRQUDdBZ25IbUE2OXBzU0xXZGh3NXorS3FIR0laZ1dDdEF5ZE1iOERZ?=
 =?utf-8?B?R0VBMnpKOWx1a1lrazZ5WmF5c2ZFSGFadmtWRXpnYUhIbDFsbXpEdXBENjJZ?=
 =?utf-8?B?MGVlVmxJRmJPWkQ1dzM5T1NjaUdTbXRNWmNWYm1hNGtCQUxoMmRHK0Q2OGlY?=
 =?utf-8?B?a0FBbkV1SURzck1oZ3lITUp3Sk9tT2FYOXpoTUJ4TWFUTnVjMzk5UGg1Znpj?=
 =?utf-8?B?bVFXVUp0bVhwOTVGeUNWYlRRSDlrWm10MkpNekJ6RlFuZGcvcGZiYlpJV2VD?=
 =?utf-8?B?ZXJxVnBHc2J3ejIveXI0em93NktJQ0RoWXozSVorNEJDQ3Z6NDM4SzBDbjlV?=
 =?utf-8?B?aUt5N3RDS1JSYThkaTY2emNJVlhNVnVzdVhSV1hSdU1ML3VFNG5XTnVOTmRP?=
 =?utf-8?B?Tk40cHRkQzUwR1N1NWY4RlErd3ZjSCtMdFdhckdsSXRPaS81WmRwalMzcWdi?=
 =?utf-8?B?OWRsaHg0VWJTb2xsSGcxQ216TjZQbHJyVGFKcGIwMzR6S3lRWUh6WkpOdUtv?=
 =?utf-8?B?UXZDN29wdlV5YXJwelEzQVNjZW5qYWpCOW15aXVRNzJVblhEMTh6WTVpSyt6?=
 =?utf-8?B?R1V1WGRWNE9wVzlWdEtmYTUyUjZzT2FKcjFVUkc5QTBKZGx5dUtYdDJNTDFu?=
 =?utf-8?B?aU4yYVhCeFlneEtaS0hTSmtGVWdQMXo4QkFGWFFUUVlJSzhHc09BTFVaYVZj?=
 =?utf-8?B?dDJuM252ekdIa0tWdE1wZHJuM0d4b1VveFBWZitNa0ZhSFMyTFN6NzlIbXNr?=
 =?utf-8?B?NUd4aHZzOFF4TlF1UWFrWEtuYjUxajhBOWUxY3NTYy9UM1lSSWtWWkxnNTJ3?=
 =?utf-8?B?YVBWVVgrK1JlL0FsU3VMUlRuWG1yUFNRR1AyNFpjS2JNTzgrQXkwS0F4Z3No?=
 =?utf-8?B?TTdjT21EUWJ4bUx5akRpVCtWWnBNV2pOMGptUlA2ZUI3dklIQnpoRXMwWlVM?=
 =?utf-8?B?cGZ2NTkvWG9lNWVzZFNTRjRSdHVYQS8rbU14T2lheEc1Vi95VndqaGRVc1pK?=
 =?utf-8?B?dUtKWlluVVpGL3IxWmpZUlVaREVVbjhBRUpxQXV3T2Qwc0x2ZUF2V0Z3YUw1?=
 =?utf-8?B?QWdZMm9FQXoxSnlib3Y1Z3h2MXdVdWVmRGpxZitmUTNTVXltK3Y4RDQ3Z05E?=
 =?utf-8?B?ZkFyeFJwRXdYSmw0dEpnaHh6MWFISEpNRFZweUxEL2htNEI4K1l2c3hpUys5?=
 =?utf-8?B?VlhDRk40Z3VMYjNKR0tva0dhNGN4WmlZaklKVm1QSEJSM0VBbU5wM0xVQ2FX?=
 =?utf-8?B?Y1lTYnNvczZ3WDdWN2lRSFdFMWNhMHVIY21vVkQ0R3B6S29ud0xPRyt0UFkw?=
 =?utf-8?B?b2ZqQ0JnNENqYzZPRWVMNGJETWtoNUpZQ1R3bE93WXJUc3QzSFFKV3hmVDlM?=
 =?utf-8?B?UXBxSUFLb21RYWlpU3luWnpVVDBmVyt1bGZFSmVVSllOMTFEL0RUYkpuMlNH?=
 =?utf-8?B?MnNKbzJ4MjlkWlNjM2FmSDc5UlFoREVlVVo1UXFBNmZjYzlFZmx5MnR1Y1pK?=
 =?utf-8?B?MGtaODdES29HdWgwdHgzSXNoam1rS0o3amxCMW02SDgvZGRsRks1WmFJclkw?=
 =?utf-8?B?NWxleTlldWo0MWJGbEZKZjU4eXJXdXl2YjVnMTRlWXdWQkhPQ3YzVDVqdzVB?=
 =?utf-8?B?Q3lZdmFvNnprblF3Z29FdnAwUEt4TkF5WW8yYXhwRXBmWVFOVUZsT1A2WWlM?=
 =?utf-8?B?T1pVN0VSUkdMZjF5anEwWkc1NEFCRFVZSmEzc3pjVXdHSTFtNDNhc1A1SmZI?=
 =?utf-8?B?MnVBOWtld3FaWmFycEw1bW9xTWttSjYya0FzNDR1aHhYQWRFcFAxSlVVZnJ1?=
 =?utf-8?B?M2RlVk9nTFh3UnU2OVg4bGFueVlNT2JJWUQ5VEFPUldzL3pVREtNa2NaL3dr?=
 =?utf-8?B?YzFwSTdtSXd1cUcwRkJGbysvRS9ZWWZSL0lqMVhMS1pKZXVJNUVzYzlpSDN5?=
 =?utf-8?B?dXd4TFVIUTE3K1Nyb1BoS0swVXUwbUJtWldTWmdJaTN3U2FaZEU4Z3NyTElR?=
 =?utf-8?B?VFd1VXFIU0VCdnVMZ2FFSWhQeHlwYTVTb2VvR0JYVVBMcnBNWXlaM292M3p2?=
 =?utf-8?B?bmMzQ2oxVnViRUFJWTA3V295Nms3Tityd09zcDBwVVV5TkoxM0tjdHBLeVk1?=
 =?utf-8?Q?NGoiEOLKrIgjUt1EmTcIMvuRD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df8021d-f636-4e9e-2277-08dbe3e3eecf
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 01:00:30.9751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0DiHrYCVWEkitWOOt6yteUXOVgAo8CPsb1CQILAzK2xnf5on0HKZsKNqgLn3UOHkOgxld54LJxrLHhsWK7kuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7415
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Duje,

kernel test robot noticed the following build errors:

[auto build test ERROR on dtor-input/next]
[also build test ERROR on dtor-input/for-linus linus/master v6.6 next-20231110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Duje-Mihanovi/input-touchscreen-imagis-Add-touch-key-support/20231113-034453
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20231112194124.24916-1-duje.mihanovic%40skole.hr
patch subject: [PATCH] input: touchscreen: imagis: Add touch key support
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20231113/202311130533.EStBdAmT-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231113/202311130533.EStBdAmT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311130533.EStBdAmT-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/input/touchscreen/imagis.c: In function 'imagis_interrupt':
>> drivers/input/touchscreen/imagis.c:149:23: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
     149 |         key_pressed = FIELD_GET(IST3032C_KEY_STATUS_MASK, intr_message);
         |                       ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_GET +149 drivers/input/touchscreen/imagis.c

a23ba3c043db9a Markuss Broks  2022-03-14   95  
a23ba3c043db9a Markuss Broks  2022-03-14   96  static irqreturn_t imagis_interrupt(int irq, void *dev_id)
a23ba3c043db9a Markuss Broks  2022-03-14   97  {
a23ba3c043db9a Markuss Broks  2022-03-14   98  	struct imagis_ts *ts = dev_id;
a23ba3c043db9a Markuss Broks  2022-03-14   99  	u32 intr_message, finger_status;
7371770ece2db7 Duje Mihanović 2023-11-12  100  	unsigned int finger_count, finger_pressed, key_pressed;
a23ba3c043db9a Markuss Broks  2022-03-14  101  	int i;
a23ba3c043db9a Markuss Broks  2022-03-14  102  	int error;
a23ba3c043db9a Markuss Broks  2022-03-14  103  
8eb834ae8a9b34 Markuss Broks  2023-10-03  104  	error = imagis_i2c_read_reg(ts, ts->tdata->interrupt_msg_cmd, &intr_message);
a23ba3c043db9a Markuss Broks  2022-03-14  105  	if (error) {
a23ba3c043db9a Markuss Broks  2022-03-14  106  		dev_err(&ts->client->dev,
a23ba3c043db9a Markuss Broks  2022-03-14  107  			"failed to read the interrupt message: %d\n", error);
a23ba3c043db9a Markuss Broks  2022-03-14  108  		goto out;
a23ba3c043db9a Markuss Broks  2022-03-14  109  	}
a23ba3c043db9a Markuss Broks  2022-03-14  110  
a23ba3c043db9a Markuss Broks  2022-03-14  111  	finger_count = (intr_message & IST3038C_FINGER_COUNT_MASK) >>
a23ba3c043db9a Markuss Broks  2022-03-14  112  				IST3038C_FINGER_COUNT_SHIFT;
a23ba3c043db9a Markuss Broks  2022-03-14  113  	if (finger_count > IST3038C_MAX_FINGER_NUM) {
a23ba3c043db9a Markuss Broks  2022-03-14  114  		dev_err(&ts->client->dev,
a23ba3c043db9a Markuss Broks  2022-03-14  115  			"finger count %d is more than maximum supported\n",
a23ba3c043db9a Markuss Broks  2022-03-14  116  			finger_count);
a23ba3c043db9a Markuss Broks  2022-03-14  117  		goto out;
a23ba3c043db9a Markuss Broks  2022-03-14  118  	}
a23ba3c043db9a Markuss Broks  2022-03-14  119  
a23ba3c043db9a Markuss Broks  2022-03-14  120  	finger_pressed = intr_message & IST3038C_FINGER_STATUS_MASK;
a23ba3c043db9a Markuss Broks  2022-03-14  121  
a23ba3c043db9a Markuss Broks  2022-03-14  122  	for (i = 0; i < finger_count; i++) {
8eb834ae8a9b34 Markuss Broks  2023-10-03  123  		if (ts->tdata->protocol_b)
a23ba3c043db9a Markuss Broks  2022-03-14  124  			error = imagis_i2c_read_reg(ts,
8eb834ae8a9b34 Markuss Broks  2023-10-03  125  						    ts->tdata->touch_coord_cmd, &finger_status);
8eb834ae8a9b34 Markuss Broks  2023-10-03  126  		else
8eb834ae8a9b34 Markuss Broks  2023-10-03  127  			error = imagis_i2c_read_reg(ts,
8eb834ae8a9b34 Markuss Broks  2023-10-03  128  						    ts->tdata->touch_coord_cmd + (i * 4),
a23ba3c043db9a Markuss Broks  2022-03-14  129  						    &finger_status);
a23ba3c043db9a Markuss Broks  2022-03-14  130  		if (error) {
a23ba3c043db9a Markuss Broks  2022-03-14  131  			dev_err(&ts->client->dev,
a23ba3c043db9a Markuss Broks  2022-03-14  132  				"failed to read coordinates for finger %d: %d\n",
a23ba3c043db9a Markuss Broks  2022-03-14  133  				i, error);
a23ba3c043db9a Markuss Broks  2022-03-14  134  			goto out;
a23ba3c043db9a Markuss Broks  2022-03-14  135  		}
a23ba3c043db9a Markuss Broks  2022-03-14  136  
a23ba3c043db9a Markuss Broks  2022-03-14  137  		input_mt_slot(ts->input_dev, i);
a23ba3c043db9a Markuss Broks  2022-03-14  138  		input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER,
a23ba3c043db9a Markuss Broks  2022-03-14  139  					   finger_pressed & BIT(i));
a23ba3c043db9a Markuss Broks  2022-03-14  140  		touchscreen_report_pos(ts->input_dev, &ts->prop,
a23ba3c043db9a Markuss Broks  2022-03-14  141  				       (finger_status & IST3038C_X_MASK) >>
a23ba3c043db9a Markuss Broks  2022-03-14  142  						IST3038C_X_SHIFT,
a23ba3c043db9a Markuss Broks  2022-03-14  143  				       finger_status & IST3038C_Y_MASK, 1);
a23ba3c043db9a Markuss Broks  2022-03-14  144  		input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR,
a23ba3c043db9a Markuss Broks  2022-03-14  145  				 (finger_status & IST3038C_AREA_MASK) >>
a23ba3c043db9a Markuss Broks  2022-03-14  146  					IST3038C_AREA_SHIFT);
a23ba3c043db9a Markuss Broks  2022-03-14  147  	}
a23ba3c043db9a Markuss Broks  2022-03-14  148  
7371770ece2db7 Duje Mihanović 2023-11-12 @149  	key_pressed = FIELD_GET(IST3032C_KEY_STATUS_MASK, intr_message);
7371770ece2db7 Duje Mihanović 2023-11-12  150  
7371770ece2db7 Duje Mihanović 2023-11-12  151  	input_report_key(ts->input_dev, KEY_APPSELECT, (key_pressed & BIT(0)));
7371770ece2db7 Duje Mihanović 2023-11-12  152  	input_report_key(ts->input_dev, KEY_BACK, (key_pressed & BIT(1)));
7371770ece2db7 Duje Mihanović 2023-11-12  153  
a23ba3c043db9a Markuss Broks  2022-03-14  154  	input_mt_sync_frame(ts->input_dev);
a23ba3c043db9a Markuss Broks  2022-03-14  155  	input_sync(ts->input_dev);
a23ba3c043db9a Markuss Broks  2022-03-14  156  
a23ba3c043db9a Markuss Broks  2022-03-14  157  out:
a23ba3c043db9a Markuss Broks  2022-03-14  158  	return IRQ_HANDLED;
a23ba3c043db9a Markuss Broks  2022-03-14  159  }
a23ba3c043db9a Markuss Broks  2022-03-14  160  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

