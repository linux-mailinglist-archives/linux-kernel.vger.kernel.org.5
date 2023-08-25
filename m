Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E49A78835B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjHYJRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbjHYJRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:17:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23E81FCA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 02:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692955027; x=1724491027;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Nc30K0N7vUYuegpagsw+9K/90AONC3JD2ruh+0IGoVU=;
  b=StYVd6IgGKYFpjfoVaDZiKSlwiKmlaEmncT4piu6Fb8zZeJrnQ+J0DiH
   FRDCKKBvCy+uuV4nbJF2EhuQ2EybHqN1oSSvoYvEsuz3+g4hmX/9BGeKw
   iKz3wG24EULMS6P8XG2YhqwtENtRlGD1iHotezSURf8M0l8Xg320DJN+U
   x3HSNZqzH6QR0/UQpTWqojGlwHZmEIz/3oxh8x9tj02xQzUSAXZAnx+zB
   j6jqBhuLo4GHxB9G+mGFywH4H5cY2At3SkNIXj/pKYZnVjQdmRw73m/Eg
   GShP9JQTJlgcV1Krxyf/jptRnrVctEE28W/1HwAre789ArNXwMkks4fzK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="372069545"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="372069545"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 02:17:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="861010213"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="861010213"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 25 Aug 2023 02:16:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 02:16:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 02:16:49 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 02:16:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTRt94nftwdFH7SY44vk93thk6MayX/perf5nRRdA9EHEF9C7HGCbAp/f7Tn1O6hiVnv8GGcAAnezkgAtL4CwNifT3Pwz/3SE8hAtjypR2sGolUcnpxxoNnf226uMzaFH/KwjOOrPZHCL0ozJb+RSe70DAsfZKfiy5FfdvgaEWR193EG4/tedSNtE0cu8iAcht5ekQ1X6fvBrYkuc5a4tmLMKejsSReI1qlU5FEj9hDK+5+GAlrnzeM+k6fw4Kbw0J135QQtQ8v3AQig8aPQWOt5YvPotb//y494rEl/ywp2/Zi96sdZ2gLFBY1D7WFGpLyv3FFh5Sw5CoCsbALJiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ktf1V/juZMwX13Zgyfl8JZ+BKGao7JR4iBEbB5XhDM=;
 b=Pp0GlpwJt3I+LjZzp/CETJpesjBNQ6X3K6ZhacsXeyiZDh/A1xMAexL3bkqb6cax1EAuFCgyb1xsEx/D7JDX924SIXIaHHLDaAazdBSizKMcXryL1fYPYhRNAUMd0LS1lievPGGDJgbvwWgSR19xTsESIRM+mEwbeF07UboDa6N3G5jo2mttj0uz7Auc5v01UVpUo6R0BVKu4oY+pxUE6UNHS9WxUC6oPqF1q0FVPp0lRnMgD2SsKyAJlY8w1vIl0uBfWw9PM4k3AgdQmRI4bIuV4ESmOWOR/iRiRD3K2zPdI/D2Ckp7T8QdmsXyZBRWDsHTPlciygow5A0s16rUQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by BN9PR11MB5546.namprd11.prod.outlook.com (2603:10b6:408:103::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 09:16:48 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 09:16:48 +0000
Date:   Fri, 25 Aug 2023 11:16:38 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        <fenghua.yu@intel.com>
Subject: Re: [PATCH 3/3] selftests: Add printf attribute to ksefltest prints
Message-ID: <qcf7avhdvzcboaidxtkv732ualhz4oo5zs3ng6wdwmlabhx2ln@viybc2lpjvwn>
References: <cover.1692880423.git.maciej.wieczor-retman@intel.com>
 <9adfc58deb5c7df43f6a8701d4e15821f4c42dc7.1692880423.git.maciej.wieczor-retman@intel.com>
 <a93a4f17-73c7-cf6a-e44f-78ece1e25e93@linux.intel.com>
 <elcfjzpnxfeyum2t6w6nwu2mtfbgvnabypqmzw5p6f7g5rpr7p@74rg7ziipg7j>
 <0f5533a-92db-b462-f7bf-14a8d595baa1@linux.intel.com>
 <nvkf4tyi4kmsnlzcpfcercvjsmsibol6wbfzrginmzioyflwux@ttbzh3hqqatx>
 <a2e6fddd-86f9-a413-47ff-5a9973a8e1ef@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2e6fddd-86f9-a413-47ff-5a9973a8e1ef@linux.intel.com>
X-ClientProxiedBy: BE1P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::7) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|BN9PR11MB5546:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2f98ee-c047-47d6-1142-08dba54c0243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HBe1oxouRiiXSPWiEqpKNoIOno/Rdim+HpSJtyRkRigOwRgytMAXBbbusqoiQWjBbxHTH6yJizgdn1lEUd5maDqf6KowJyw4j1ufrrrUGPas86pUM43myntxXqQVmYfyXqApM3sSuxDB+vCwsxDv6suQjdtG/YLIb7BarvZGVKADMpIqlMxdMaZ9bmrg6oYyPazkkPr8F1exwE+JHZIoNHpiXE3RKvSdJkPj2AhLD7eY7mNaYoI2ki2nrzB17jq7QmrIdm9G+c5lUTZXV8umWoUWuwk6nySWY5zazyms7CWmgrfToE4XJvbjRgR1tog5rFe7utADZ0S2a9yujOxUiK3JjHEDT0LYPtn32QqqGTu9i36u8FnclHY+4mRORO17Hayxyf04tL7hKeo6mYKXpdadZDvWuGhvgpfR3o6ylAC2xwJ0Y4Uh3fshJDCT+P/+uiLvgQB/EA23aHuLT+r+07AmNZilUqOPbCUrlhfNJ7EQRg2vnf+/+tcH3Gmnh4CsBVLS87atYL2VPYR08sDk9P26r6LjnAfP7lov6LH3tm4uqy00nG1bI8Xtc7zaT3IE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199024)(1800799009)(186009)(82960400001)(38100700002)(8676002)(4326008)(8936002)(54906003)(33716001)(41300700001)(6486002)(6506007)(53546011)(6666004)(316002)(66476007)(66556008)(66946007)(6916009)(86362001)(6512007)(9686003)(66574015)(26005)(478600001)(83380400001)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?OJ/++JIcpUEn03Oy5nOedr4G4eXQioK+E6jca74eKVNRDSNYFmKCZY+Rta?=
 =?iso-8859-1?Q?dpB4eP1ubYgdUJcgAIbx33TCeMsM8oduyL8e536fcQ42JB3viKYLzLAtZE?=
 =?iso-8859-1?Q?xkB6ZLIVtub2Q58eRPUGYgsnuhlTRTB3uf/BePvy2WAFXZ+HCJDjlycwDb?=
 =?iso-8859-1?Q?BAABUJN3O34cqLsGMY1/1J3wuj5Sty+A4kMwyyZmyJxHk+6wfIS0r2zmjV?=
 =?iso-8859-1?Q?Rs6cXwd0Q8mT1iiz95+56LUpSSJ2MU2MaRgzoJVBgNJ76Vka996yXAyK+z?=
 =?iso-8859-1?Q?5il/g6cNUSTRc8MqgSsO3uaDj6KHRW0h2W5c6MuySQUg0ZT/ids/Hrf+s9?=
 =?iso-8859-1?Q?KAjTT5GEG4a6N+4wz0zGCiElu2sySTFrigaxuQT5TrD4S/Ugx+1QhQBRcv?=
 =?iso-8859-1?Q?MoI/2wmclBrzjpY6qf3BWe2kIc40yzs2d17R5BTBrNIDTBTmhTHgRdI25k?=
 =?iso-8859-1?Q?MtCJvvwPHulW71dAIgG+J6RrHODTJ437tuOABlQLEfPFLiTyKGmg168+aT?=
 =?iso-8859-1?Q?b0p8Yf9BUAmeC4Iiivz0yvBXQcJhaIHtdnT2SRwXB40m0WmcgAA3uNKqmC?=
 =?iso-8859-1?Q?qrEWnpcbio+q06SKnwsvm3VPgN6okkwGm4G/nFE6ivD6xo/SDU9O/brWBf?=
 =?iso-8859-1?Q?nEwTd42glsVredV93RGId7kqBET2QZPkMK24N+ka8L5+Zm4ocgGTSLVdkD?=
 =?iso-8859-1?Q?4czQKZOHPl1DbDHalQyOyO42nUrICpfL7jtz2m2KMcX0jliN1s2v4W/BmZ?=
 =?iso-8859-1?Q?ZMIiRpUoa+sx+cSalXqpZeP/oseWh7HfuD40ncghgvpU3sTiCRj9gZQo61?=
 =?iso-8859-1?Q?7gmXaSeB6G90g2u+MJ1b/E6kOHuZDYAClvuLWxfolMUXepwzrHMruafpOJ?=
 =?iso-8859-1?Q?zGiPwVsUgHvKB2BKgVpl+KxENhaH7qk2KuGgRLUZN3DppG7FCBAeicjVie?=
 =?iso-8859-1?Q?4xqbL/hBFf+V1JHxDEVJWF0Lir5hdAAgc2vP9XbYJvtlyIQLXhL8RMf7gk?=
 =?iso-8859-1?Q?gwMfn070iQgxM0L7JTzV/Q3eqYWilofRFhXlWlUFiBbXJYVBJm+D44isKB?=
 =?iso-8859-1?Q?F2l+s3AN/LqEOt2uBN/hh8/lIs+az+dQAfprL1EjEqczUj769WUgDwIIKH?=
 =?iso-8859-1?Q?UFndfkas0XPFS/9+wCh+kbEwzKvpypFkW2s3dPgd8O7wpc4BV0EHIekRny?=
 =?iso-8859-1?Q?QjO7sD9fioUB+N1spkAKkY1iRSuKb+abYD3sbvetzs6vn0XUu2EdnUJHqH?=
 =?iso-8859-1?Q?4KpEB6IjQnV/y6x623e/oS07Vrxvwfl3JqTAfilm9Zt+15I7Y4/PmO67Cl?=
 =?iso-8859-1?Q?KFL39xzeWWYvQIGvhJ1IrdvLEbngBENF47UqVGaNkMfEkcdGYEBdEqvcsv?=
 =?iso-8859-1?Q?AOLvZ84c24xSvNGP0I/lCic3X6NBRIN0AjcjlGdRET4zQs2F8OG5ONYQdl?=
 =?iso-8859-1?Q?MIUeM+97rFlZgMTU/jxuaxBo6cQyCbAQxSq8pMa4+qAUywKIUDDfHM85u8?=
 =?iso-8859-1?Q?70sBAUxe7BmRutsvkkCl/2fLChdD4+1NwYgY1tYu6n34svMwKjaKN6LAAL?=
 =?iso-8859-1?Q?eywoEPvH6pYhYvZrZ7pHZZzYAfrNlhfGVeWhQyILlF0Jzz0VHmdjCNGKr9?=
 =?iso-8859-1?Q?MtEJ6P8tEQQTdAE8ifsxZ1n2kaEK2qncWDk/12IhtG79efeqh/bXd6zX/F?=
 =?iso-8859-1?Q?vFvShU9dzaC/XqE6Hg4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2f98ee-c047-47d6-1142-08dba54c0243
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 09:16:47.9249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWi57deZx3afVeuJfi2s3f+KBU7Osf9t3UlFXuFjvFPU8meeGYyGvCisEj4sGctTB2ps82/j4cIaQkugrpXlrasADKfun0ylAj3Fp6vkK2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5546
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-25 at 12:14:12 +0300, Ilpo Järvinen wrote:
>On Fri, 25 Aug 2023, Maciej Wieczór-Retman wrote:
>
>> On 2023-08-25 at 11:28:17 +0300, Ilpo Järvinen wrote:
>> >On Fri, 25 Aug 2023, Maciej Wieczór-Retman wrote:
>> >> On 2023-08-24 at 16:10:12 +0300, Ilpo Järvinen wrote:
>> >> >On Thu, 24 Aug 2023, Wieczor-Retman, Maciej wrote:
>> >> >
>> >> >> Kselftest header defines multiple variadic function that use printf
>> >> >> along with other logic
>> >> >> 
>> >> >> There is no format checking for the variadic functions that use
>> >> >> printing inside kselftest.h. Because of this the compiler won't
>> >> >> be able to catch instances of mismatched print formats and debugging
>> >> >> tests might be more difficult
>> >> >> 
>> >> >> Add the common __printf attribute macro to kselftest.h
>> >> >> 
>> >> >> Add __printf attribute to every function using formatted printing with
>> >> >> variadic arguments
>> >> >
>> >> >Please add . to terminate the sentences.
>> >> 
>> >> Thanks, I'll fix it in the next version
>> >> 
>> >> >The patch looks fine:
>> >> >Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> >> >
>> >> >...However, there are formatting errors it found yet to fix.
>> >> 
>> >> I believe you mean cache.c#L297.
>> >> 
>> >> I think I saw you're preparing some patches that remove the line that
>> >> reports the formatting error so I chose to not correct here.
>> >> 
>> >> Please let me know if I still should change it or would that be
>> >> redundant.
>> >
>> >There are other selftests besides resctrl which had a few warnings.
>> >
>> >Making the selftests to rebuild though might be a bit tricky (you won't 
>> >see the warnings otherwise), I don't know the command needed to clean 
>> >selftests but I guess one can always force their timestamps to force 
>> >recompile with:
>> >  git ls-files tools/testing/selftests | xargs touch
>> 
>> Okay, I think I counted 13 more caused by the __printf().
>> I just ran:
>> 	$ make -C tools/testing/selftests
>> and to rerun it later:
>> 	$ make -C tools/testing/selftests clean
>> 
>> But do you think all these fixes fit into this series?
>> Is so, should I put them in a separate patch or just append to this one?
>
>Please fix them in separate patches.
>
>IMO, the most logical approach is to make own series out of these printf 
>attribute fixes and change, and another series for anything that is purely 
>resctrl related.

Okay, in that case I'll put this patch along with other fixes into a
separate series. Thanks for the help

-- 
Kind regards
Maciej Wieczór-Retman
