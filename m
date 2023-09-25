Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82A07AE09A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 23:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjIYVRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 17:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjIYVRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 17:17:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0562103;
        Mon, 25 Sep 2023 14:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695676627; x=1727212627;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WjE3Gi3VD1tqOVl3vsUkSb8M0gAoPjtTJ91ftFq25VI=;
  b=O82hM1bC92J/U9yY4Sc0nwXWx/mxALEkuCVR8xUCsr1koP5ZnJFQWnMN
   pICXwMleuBvbt4d8Ck67lOejbJ4HafzH5y184qhxn+048+M338YWnnZBv
   KrJOTZfvfXkJGo06CNMAZxwpdP5pSiS7v4P60gnklXUUxbr6Gbtt5kgcI
   WFOv8BRyqyMnGCO9OEM81vRlnc2y7oPw+Mgt0ZSRqzGNKxodTRCnrMsc9
   Xz2LxoEH+gKvoKLqQWnNqDLfbBFO7f7kwaVSFknnHhdeADbICkd4EgAXt
   uHC4gr0imrZp1680RO/DldeN+MuopSt8tQ5n72iKcqGmEnfxeVM08JILw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="447885794"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="447885794"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 14:17:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="725167175"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="725167175"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 14:17:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 14:16:59 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 14:16:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 14:16:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 14:16:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIiSMOeoIU7Awn+NfcHUjO4m8IhNDFzVurdRc/xSbNb43dai3ga3Z6dGmLfsYtGUXgCj8cYc/id3MsZ45DyD9Wa432tbX1t7pgie4b70dgJhm4oAqQQOGrt3L29JNElc8T/3zXxpvUei1aTeZ+AGIdblOMPUyCB5AQAbn35yll81J7p/a/+aZDoDHGZpzktR5DmS7VBWPdB5pL/Lbx5Hg6D+vZ4dplR2N0CopuocVH9ueiPXIyA+xf8mDcIDgxTVOaljc1Cdfs6fAAg9D5LytKF3uNo6Vn5wWRwcjQqhUNQ3Z4c75SWT1jVng4TaGDBkWArLx+9TFJ2podJtQb4ORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJgegSX7YaEUpam7QM5OUEzZQ6XGw3p4pfqBZ3DapkQ=;
 b=eZZlzX1o0YQS5owNFACbWFJfQ8im3EUoFbhhwBXbnqEw4fswGxgqvbXcITQNO5acYhv3nx0RDLmpUIm9faBNflxUCrH6LC+WJFFslIUTirtP3j79/3IUbEIq43NIDv/pr71V/UncxCWanobE6LYpqkXoHVJGkhSo3NZjLmD9iwFTSNK9H+BDGorGR+bU8no7uWnS8vgf0VXw6Njf9yiChx5ub59WFUWkJAkDJgO2r/5DnXa03g2e7F9krTxNq77wrsg8fBi+nDcDRP6cxcmgPhO5CysbeelpAql3cgFWMDgJsTJFjLoRPreD4X8lYsFYbStQqX46TUuRNkHCzBVMsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SJ2PR11MB7426.namprd11.prod.outlook.com (2603:10b6:a03:4c4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 25 Sep
 2023 21:16:54 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::cdca:c91f:da79:a1db]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::cdca:c91f:da79:a1db%3]) with mapi id 15.20.6792.024; Mon, 25 Sep 2023
 21:16:54 +0000
Message-ID: <ecf674dc-165f-4fd6-b8e0-c0694d81eae8@intel.com>
Date:   Mon, 25 Sep 2023 14:16:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v10 03/10] x86/resctrl: Rename rftype flags for
 consistency
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <paulmck@kernel.org>, <akpm@linux-foundation.org>,
        <quic_neeraju@quicinc.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <songmuchun@bytedance.com>,
        <peterz@infradead.org>, <jpoimboe@kernel.org>,
        <pbonzini@redhat.com>, <chang.seok.bae@intel.com>,
        <pawan.kumar.gupta@linux.intel.com>, <jmattson@google.com>,
        <daniel.sneddon@linux.intel.com>, <sandipan.das@amd.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bagasdotme@gmail.com>, <eranian@google.com>,
        <christophe.leroy@csgroup.eu>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
References: <20230915224227.1336967-1-babu.moger@amd.com>
 <20230915224227.1336967-4-babu.moger@amd.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230915224227.1336967-4-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0126.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::11) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SJ2PR11MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fcbdec5-30cb-4f15-4cb9-08dbbe0cbdff
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 71RfmHVUCy5N2UEXwaXsz8utJGz9PQae0vQSPcqbPy0lEjyENNhlz79SVnu9rQz+MAhmIhGwvoiNDs2H//U8QudOP/gbmaqe2nBgDmMKPY8fdNfKABXN8SfwpmQSR1Z7csfNj56cpmheC5SC6TE64SDuZZUHll4Q69RxZmSBo7XIgbb9XPLgRshs10aAV/G2lkPr02fPR8/Av/DAtEEbN92p2uYHmoj+s5BV5wDuH3ry/KiPFT5Mm/MDN+ziaPlkwyh0ke8l7w2GyvCp6yNtVewGWTxdleHQi6MxHmZLteVildzgglpEJHdPJ4XXFHWmyyjGvaEUvnI3BOVq0owA2RYyNh9YPaFwBK/NMcOXpsFDvz362Uy57vBYEL9MvW7JgoeO5LU6LJGjVEJeH2MebI5baCKWIJpUVjNARRnfVZaSIFTRH4sV0l0Zrs0z9BVPKR3hX0P0Em0Ekoi7vN0XClS/G6Kor8Z5vZNrsjv8SuHhw7vKvo3WGTY8B3i0m39UGfspBCGs2MX88waVY14WT+TOmMH69xbyHnQCLo35v5SU8iL5az07KCsTUg2RpDNIOM0wODTcbqALfovHA6OjHa9msPSRWpzXti/p18oHLx+W+g0CBDRSsNZkV313tA+5AA4A/14LHyX2a50Xua65sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799009)(186009)(38100700002)(66556008)(66476007)(6512007)(6506007)(53546011)(2616005)(478600001)(6486002)(86362001)(31696002)(66946007)(36756003)(26005)(8676002)(7416002)(7406005)(8936002)(4326008)(5660300002)(31686004)(41300700001)(2906002)(316002)(4744005)(82960400001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHpPRG5INHVueE0xSGxVdXgxM0RlV3VlYVRiQThhazh0ckVNUXNnRW5KVkhI?=
 =?utf-8?B?RUpYR1FqQlJvZlNqeHRDS29TV3Z0TVFiWEE5RDNwYTQyTFFOUUpNR0FSeUhn?=
 =?utf-8?B?WmhtcGxMT3l6cXhEWnBycEJ4NWtJNnduWGFsMGFsZUMyTFBSVlN6R2JrNjZR?=
 =?utf-8?B?ZE95NDBWNEp2aXd4UDFtZFA0SXRCbkNobEI1eHB4eERvVDJDRitheFJWaE5u?=
 =?utf-8?B?bHdWUXQwWTV0cm5CcjhQSkxyNUVVdEdiNm41azZjNUJUY1N3ZEZRaFBrcHRm?=
 =?utf-8?B?ZmM2R1IzK0pkeVR4eHh5ZFlIVHJ4TVlyRFBVSVNpcUx2RHp2TzBSeFRYN2pY?=
 =?utf-8?B?SFlQMWkrNldqVGl3MVd3aUtaMytQd01PUks1eExFUU1COXpOM1JzcWJOMDlU?=
 =?utf-8?B?R3B6QzJIdzEzQjlKdW85VE9YdUpFcFA0NjNzbTcvMUVaM3ZVMGNPaUxnaWpy?=
 =?utf-8?B?VDh0Y0t3T2tqemtZWjV3akJYT2poK0h6d2xUbnlyTFRoeDEyNG14RVBuZkZS?=
 =?utf-8?B?bVI4TndWcG8rUFlVbnhUQ2JvUHRINE5waEZHWTVTcWkySGJuMHhjMTVZTmds?=
 =?utf-8?B?aDY5T2RLSDg1NjN5ZUhpRDB5S2w2T1hMSDJrcHdvREQyVXp2RVRDamc5dDk4?=
 =?utf-8?B?ZEh2bHdFdGI3dzZ2VVI5Q0JDYVNqZGx0NjN1TE51SVZyVWY0ZUhqOXlHR3pI?=
 =?utf-8?B?ODVPTjloWEk0TmpibWh5S3pNL3VKRkxOVDJOZWJuMnQxQ1FHUW83MEpLY3Rp?=
 =?utf-8?B?eHNRaGVpTFBaTlVxREhHMUhKZU1rUjZzMUxJZDg1NXlzNnp4OVJmTnZlYzd0?=
 =?utf-8?B?ZllvYmp6cGk3OW9nR1hjNHYxZUN5MTBhSnQ5L1hCNzlML05zWnBCUmtnNWpP?=
 =?utf-8?B?UGZkckd1RkxFNUdBblQwNS82bDREQ0lLYVdkZFowb0ZFOFhBWVhQRG1qaHBk?=
 =?utf-8?B?TURlMnZOUDU3bUZ0azNiblBpWW1QQS95VS9HaW1sdGc3NkdEWFc4TWRsd2Rq?=
 =?utf-8?B?ZC9zNFIzam42b2JrWG9Ic0J3Nk96UU9DczRlTVdNV2hPVENUMFFHaThNUTZY?=
 =?utf-8?B?ZU5WcUJqRWJtVkZiNmhwTkRHRlhmRUtHZUc0OTRlQ1JueUVDeS83aW1GYWZx?=
 =?utf-8?B?L28rV1pFc1pzQ20za2hXQ3FZNkd0ZlNBTGlEZFhKSDY4elg4MklpdHRNQUNp?=
 =?utf-8?B?ZkRTQm9tNGNKUXZWTHROMDljMkhvOEtXblNzTkxDM3J2cU1oTUUrUVNQRFZT?=
 =?utf-8?B?OElNYnlWT05wVWZWdTVqdnBWb2R1N0o2c04zbkhmNVJGSFhKRUJLMmVrUzlR?=
 =?utf-8?B?NVBEa242c1VaOHZ5NTVhZnROQWI1TVFFODMyRWdaYmVIbm1Nc3hRcUFZM0Rm?=
 =?utf-8?B?MEp4TUlWaHhBelorVm1PQkxaZ09Cak5tdjZrdUJwM0JTVUpVZWxvY0QrVTU2?=
 =?utf-8?B?WDlMbzJLaHdUMW5TSTR5eWVIbU9ZdlVrWEdMejBiSkxNUk9LK0NIRUxmNGh4?=
 =?utf-8?B?UmtHOE8yekdPcjN3b2xxK05VRC90TVU5eU1IVnFuemZSNmJvWk9ValViYmRO?=
 =?utf-8?B?ME96NXZyd2w3cmJyUnBWakpmKzBFazJHR25aMTVybFlpdXgyRUZ5cDY1cnVt?=
 =?utf-8?B?RjBjTUlVYlM3OFZXaUpRZlhxek1Hc21nTHUwM3lmVmdtdlZYWlZnU1NGUS8x?=
 =?utf-8?B?ZXR1MGJKNWRjVVU0NjBvV0xtdnk5YjlWaFlHNXFvN3FwWEgvL0dOeGQyMGpz?=
 =?utf-8?B?SktPOUcyTmVkK3VseThFejl0SWUxMDFiWkZ1bUt4OXY2bDhJZDFpWjEwYmFr?=
 =?utf-8?B?QVFNYTFGYTBaNnlxMlE1M2g4a3pqVmlvZVB3V0JvYVJNeml5WW9JWjQ1cm1u?=
 =?utf-8?B?Wm9raXpQVFhNNjVjY0pPRzRLd1lIY2NzeFBFaFZub0lBZktBOTBJd2lkSlNS?=
 =?utf-8?B?SXFWeXRyYVZvTmRsOSt4c2RFTEh1ZjdEc2p1RnpGdHphNnlKMGtsdHVZM0pz?=
 =?utf-8?B?bG4yTFJGYWNxWkkwamRybXRwSElvQ25hT1Yvc2FZU0ZzUTg4TW11THBSTkZa?=
 =?utf-8?B?TlA5Vyt2b0hwQ1pnS1Iwdk9xbi96ZDR1VXhiVTNMbTZlNmFaT2hNOHhtUm5p?=
 =?utf-8?Q?Jn3cIeu4gyZs+3mR5LreXV/n3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fcbdec5-30cb-4f15-4cb9-08dbbe0cbdff
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 21:16:54.2762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+khMsNZ8v5JnXhQrV2k0dwJxfdaLwin3/LRajP8CYJ3OMk1CKIRwob+ZkZMln1ZQxuM5p9m3YHcNKBHaYyX1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7426
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/23 15:42, Babu Moger wrote:
> resctrl associates rftype flags with its files so that files can be chosen
> based on the resource, whether it is info or base, and if it is control
> or monitor type file. These flags use the RF_ as well as RFTYPE_ prefixes.
> 
> Change the prefix to RFTYPE_ for all these flags to be consistent.
> 
> Also add the flag RFTYPE_MON_BASE, which contains the files required for
> MON group only.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
