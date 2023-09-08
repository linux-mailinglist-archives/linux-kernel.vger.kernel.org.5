Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C5A798C47
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbjIHSLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjIHSLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:11:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C439268B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 11:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0+ltA+LPKzx+Z3OYXA37bETp/28Dm1a+OgGtUDxAW2FlddAcPRvquQsb614Z1LdG2epQZGGhmgF+qqmOZDwpL+S12tJII0D1qRjwJC2yXvRnfjM5XOPZsQRvnXlXzC8s5HNq3MiHVoQuJA0M4mQdWBS7Z7c2Ss2ImrLFa04L7X1tqVlMTFCyB/ve4l10+lXwyIOkUT+IVHMpXe+be++WFnmxLnp5m981QpIFGFeF1Nei/vsZqCeCLTBIHVsRqvXA98LECi0aJC/zmu/w+FafKYREvble1xONO+dqvrqwsOhqq9QfWqS0q9ZftswSnkOxxb3gz6rrlfqhKHGutkMcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zZmwfDhZJX0rxVrkUgbUD9l4HSZAzo4JUeWt8WMXvA=;
 b=jt26AkhkovLqqL8DPkmdSupOYZIfpR23uaK4bTvRjIh/W7gHp3BlEoXBE52H6Lrv0L/f3k2LMxGPL49z5iPjv22z3F/9CbV9bo+GBuxaMlja0i7JHrJX6ti5PzQ6YCCekjKiE2CYIrEeEyNgGNyMyvbBTyVT/b9f64RtYUexn1Wo05x45UATbMR4NSgL3z1MGyVHnBfF2ORDZ1eOQlh+uAvqqP9OFKTcAQypWbzohw4DHPpSUv/QKoIpM/FCofwQ7ns45rNBk0/qJNRbmdYjB80RmM2Yg3/gSKQkQWNSY4mXw79FBQB627h0IxPlRjWxfTaRt0u66iVHrZgyzm5WdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zZmwfDhZJX0rxVrkUgbUD9l4HSZAzo4JUeWt8WMXvA=;
 b=irRJE/RatQGRhhnBalSzMqQnDhclevrjpqcDgGB/KHMseMV7ZR71JaAp+6nPRGp/gycCVtkfUpecFcUoMxy66IJLSsDJG1zcUt812nvJkKqRJ65Vpcj7/ITHkiul1nvyTMwuizQj0+HhfGy5FHqvdsg40krKWzG3ecXhu2EWdcI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Fri, 8 Sep
 2023 18:08:58 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 18:08:58 +0000
Message-ID: <18f3a209-8dbf-4837-6bcb-a71a1ee1abb3@amd.com>
Date:   Fri, 8 Sep 2023 13:08:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   "Moger, Babu" <bmoger@amd.com>
Subject: Re: resctrl2 - status
Reply-To: babu.moger@amd.com
To:     Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>
Cc:     Amit Singh Tomar <amitsinght@marvell.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "peternewman@google.com" <peternewman@google.com>,
        Drew Fustini <dfustini@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <DS7PR11MB6077FE180B11A9138D8E7ED7FC1DA@DS7PR11MB6077.namprd11.prod.outlook.com>
 <35f05064-a412-ad29-5352-277fb147bbc4@intel.com>
 <SJ1PR11MB6083BC6B330FA7B7DFD3E76AFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <dc4cd365-2a02-32a3-da78-7ba745877e97@intel.com>
 <SJ1PR11MB6083C0ED50E9B644F4AF8E4BFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <fb9499b9-c445-01e8-8427-6b05256abdb5@intel.com>
 <ZOkU+d4AsLGSAG+y@agluck-desk3>
 <b48fe955-c1b4-4aeb-1ab0-bf26e56e1f0e@intel.com>
 <ZOlRNTq3lE7VNHjU@agluck-desk3>
 <9742f177-a0ce-c5d3-5d92-90dda32f5d07@intel.com>
 <ZPjDHN0nvHz9kWFn@agluck-desk3>
Content-Language: en-US
In-Reply-To: <ZPjDHN0nvHz9kWFn@agluck-desk3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0069.namprd05.prod.outlook.com
 (2603:10b6:803:41::46) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: e087d118-5efa-4ab2-09c2-08dbb096ac23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8QzVmoVG5Wd+v7wRfYcHuDmW38g+lys+xMzNb8029GjJNTKvzeDSxUqkDRD5S+G/2U6hoAVVjeTuukRbmqiP66rZFPUogTJBJIqsPnx8BBcvjlfo/lxMkb1NdsALruwhBMeJVbRFniUPV8sr2/Hp3SkFqRPTEgKEZc6KWfVSRZcUnVaVb3lQ2zFHur3QI/yfnXZWiMi8g7R2RqQOjmmn5G/tBkF3NTylN3yuMJJnlRv1/a8NpgAAH3G+L8DlfvCLnsXWUggNynAFiD3Qcrq29/rcSE40hmZGbydNz/w1aUocHeZsDVg24nTR6d/9CuBi16+a/EVEDZRZfZmggpFhoiSqY8gpDZZFNWHrBdTUP7k694b9BJAiiiAClS5r7/fwY7FQc1RLRZi0lCi3h8+XlmvRiLHcbdCs05HgtTz9IQ5YHv6KUPPoLDui4/LjgCb3OXWgMR+g+OF3xVmYTjrAGZex7mq075VLiBGuEIAPtjynha5uyXJLxD2Dz+RkE7tNVf38zMha6TeJMhQWMp3IYXGedyAVqd1oeA9+6yBKU5YkWbfT+Y4qrW5nobXhsJPlCj/d7FZj28MXY31cnoaEWLadxE4qAgma4uplG6mMQGfVYAFsykbCav2fE+JbzygGCZAqav7rgl34hLwrO1AoLWf1RqG2pDWdXt4EXqGVGfeeAcEtFTpzVLEhDcaQU4abDQK4ntATrTbXwIhAYhJlQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(396003)(376002)(1800799009)(186009)(451199024)(31686004)(6666004)(26005)(478600001)(54906003)(66946007)(66556008)(110136005)(66476007)(6486002)(53546011)(83380400001)(2616005)(38100700002)(6506007)(6512007)(316002)(8936002)(7416002)(6636002)(41300700001)(8676002)(2906002)(31696002)(4326008)(5660300002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnRlaFRoMzVmTUdJWFB5dHZ0NFJJdTRuZFE4QUkxSUJEdHBhaVYveTNOMlVV?=
 =?utf-8?B?TGVNVlJqNVkrTjNuK0IxN28rR200SWpucXVJSmh0TzlJaFZFTXpCd1NOWlB0?=
 =?utf-8?B?UDMxUFRHNTNpOCswYzdzS1lkMEJpZTRaU3RyVExVMnZ0MzU1VXRRV0hUemVQ?=
 =?utf-8?B?NEIvd0I1dmxmd0lxOVZtQStZU1I0SXo3Zm1WUnRZY1U1em9NTDBVeFlvVVFz?=
 =?utf-8?B?aC8xVVg5eWRlcTFEY0ZibVE3Si9KcXlHT0hXYXBTOUI2TElXMUlHSWUzcEhi?=
 =?utf-8?B?Tzl1YXBveU9raVpUc1VnR1RQQlhPbkI0RC85U2o4ZlphdXp1a0FUUTBMTVBw?=
 =?utf-8?B?OVR3NFhjV3lxbnljZzdWNFE4R3ByVmJhM2F3ME5QelQ0MHRUWnkwT1NqcHh1?=
 =?utf-8?B?VjhML3hxb3F3SFdvY2Rab0F1OHgvNHZkMlFZdHpHQUlHU0d0M0t5QTFlM3g3?=
 =?utf-8?B?ampvRHRpS012NGtqVzlNZWJFaHFLRDNHVWcxcTlCUmFWWVZJMm1qOWdjTy9U?=
 =?utf-8?B?RmtoYmFNUU14eTJCaEd6Y3E3Y3BEUWFuWFFvOVQ2VW83UHlZeHBrVzlMZzd0?=
 =?utf-8?B?SmJSQ0gxQkgvNTJtd0pidXZScFplZFBUQnp6SUVFVDVIZXh2VHJuOWRMR3dq?=
 =?utf-8?B?LytBckFjU3pseWZDUXBBanNmWUxTRFFqQ2RoakpLQ0p0clJXbVBVeDFLYkwz?=
 =?utf-8?B?Q1VYMWpELy9DRm5URlUrMmo0RitPOVJsU0NEc0cyU1Fmd3RnWGlEREl6cjBn?=
 =?utf-8?B?TFRoUVZUai9mWXIySmVjQWJIb1pabmZtZDhLaHY1THFaQTkvZkpzMHZ1MTJ1?=
 =?utf-8?B?NXgvWDhkQzcwM3RTU1lqRkVRVlNIbWNkaFNkNFZTd2tVL3hWTlpZU3BHRkVT?=
 =?utf-8?B?cEpOZFNIZzBveU1nQkZQY3JqT1RpSmJRZStRN2ZjekRKckdJekJXSWR2Q2ZX?=
 =?utf-8?B?NVNwM29mNnlKejlQWGZqalNYbXpmcmsxd2hQOEtkUTVnMmlyM2JiWjZUNkxk?=
 =?utf-8?B?ViszRGphY1hocGdGeXZDWWhJNHZ2NUNoWStpQlREeEs4OTRXbklFaUxtY3Np?=
 =?utf-8?B?S29yeFlLV2JPNkozbUJDL0NVT2RseEZOb2VKOC9aRTZhMjRoa1I4eDFuU0lE?=
 =?utf-8?B?QXp0SmRVMXdhQm1TeXpkSkpVeTZSS25iUm5wL2tFWUR4UXlZMlZmUEViYTdM?=
 =?utf-8?B?M0hLai9BbTRGLy8yZko2aDhUR1VEUmRUNDlTSHdjRGIydGtXVDEwOVFIVVQw?=
 =?utf-8?B?blNWSjBVSTMxQ3NNN2hGREE0R3ZtK1ZUem16clg3VWVRT2NaYThpOWxoRWNY?=
 =?utf-8?B?QkYzUzNTU1VLM0EyWWRqSUMzL2ZlNEx5My81OHZzcHRxaUlONGUwZEdYdUdX?=
 =?utf-8?B?VlZWYXIyTmpId2tWR1p3cnB5a1dicmxZTHVRU0lsQndPNm55ODRMZWl4QlRa?=
 =?utf-8?B?Yit4Rit5WUFvRlZLOCt0dVlXam1SS2FEaUFzZ1ZhaFdxcUFkbm5CbGxrZ05a?=
 =?utf-8?B?dzZ1VEZkNlQ1UlJUMDJTcUZZaU1wclNVT2xZSmpNeEdSY0NrWkJPcFFTbCtj?=
 =?utf-8?B?VmVZbjZ6bFAvR25rcjF4Y1Ztb3d1MW1hbi9za0hJNEZobzFjUFZZcmJsUGdK?=
 =?utf-8?B?eGttakU5bWhoOEl1WStaWGtKdVV5VXdIU0pKMkJwWStPT1VENmxza2tnV0lV?=
 =?utf-8?B?cllZYWNudmFCNFdCWmhzaWI0ZytCdHhvSFRDeWQ2MDF2M0ZJd0duL1M3dFZq?=
 =?utf-8?B?ZU43MFNVL1dGaEhvZ1hONEQrdmZ5RVdNRmJuV0dpY1hUeFRUdDFzS2Uvb1Fa?=
 =?utf-8?B?bDVMVGFzcFJneTZEVS9EZCtLTVVRM3lKRExOcGxxTW83YXNpUTJGVHJNUWhD?=
 =?utf-8?B?ZVVZanBXZlN2M1NJK3puU1E1U3l1N21qQVVmSXRMdW0rNllLd3h0SDZXazNK?=
 =?utf-8?B?bHBFd2M5N1hGY2F2YXAvai9FV3pyZis4WlNMdW42TnAzaHY1THUxOHF4bmVy?=
 =?utf-8?B?M1lSei9sT2xBTUJhdklyUTFnZkh2QitVTDdQOWkxenRJSVExMFBDbVhIVmdr?=
 =?utf-8?B?bTRiV0VrM3VqL3B1cTgybkJZVEhJZVJVK0tBVVY3a1RFdEpYREI4czltcHh0?=
 =?utf-8?Q?yRyQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e087d118-5efa-4ab2-09c2-08dbb096ac23
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 18:08:58.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLOQFncxPrf8ljp8Bzn7DhZccV/x74i4MFX7qzrvHTbsb5vZOQjSrTzJyWi2Trkb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 9/6/2023 1:21 PM, Tony Luck wrote:
> On Mon, Aug 28, 2023 at 07:50:12AM -0700, Reinette Chatre wrote:
>> heh ... sounds familiar to "To transition smoothly it may be required
>> for all currently supported features to be loaded by default". It is not
>> obvious to me how this also closes the other opens.
> Reinette,
>
> It seems unlikley that I'll be able to close every open. But I'll
> keep trying as you point them out.
>
> I've just pushed an updated set of patches to:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git resctrl_v65
>
> Rebased to v6.5. Includes the module auto-load code discussed in
> previous e-mail.
>
> James:
>
> I'm now hoping for some feedback from ARM folks on whether this is a
> useful direction. Is it possible to implement MPAM features on top of
> this base architecture independent layer. If not, am I just missing
> some simple extensions that you will need. Or is there some fundamental
> problem that looks hard/impossible to resolve?
>
> Babu:
>
> Can you try this out on an AMD system. I think I covered most of the
> existing AMD resctrl features, but I have no machine to test the code
> on, so very likely there are bugs in these code paths.
>
> I'd like to make any needed changes now, before I start breaking this
> into reviewable bite-sized patches to avoid too much churn.

I tried your latest code briefly on my system.  Unfortunately, I could 
not get it to work on my AMD system.

# git branch -a
   next
* resctrl2_v65
# ]# uname -r
6.5.0+
#lsmod |grep rdt
rdt_show_ids           12288  0
rdt_mbm_local_bytes    12288  0
rdt_mbm_total_bytes    12288  0
rdt_llc_occupancy      12288  0
rdt_l3_cat             16384  0

# lsmod |grep mbe
amd_mbec               16384  0

I could not get  rdt_l3_mba

# modprobe rdt_l3_mba
modprobe: ERROR: could not insert 'rdt_l3_mba': No such device

I don't see any data for the default group either.

mount  -t resctrl resctrl /sys/fs/resctrl/

cd /sys/fs/resctrl/mon_data/mon_L3_00

cat mbm_summary
      n/a      n/a /

Thanks

Babu

