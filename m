Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2889B7BFA65
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjJJLxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjJJLxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:53:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA4194
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696938820; x=1728474820;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TfuMHjhvMOhruyGyrdVXRy07fo81Ix995fWSF7on4d8=;
  b=eHXXGyBACEmIsRN9nXweXm7HALdwWFnPVQJT7+6W7LTO/nSZGkBl9z3H
   jKoXY3ug+6cg3Nw0er6CCB1ovEEqzrqDKGsEH2s9Ay5WzLG2z4JAJkq6T
   dMkLpkepjQO8WaTQGF0Nmj1yZd5GAhDVX4z3mFezkqipjRuoEZMYsO32S
   7X0rO3Ljl+KLD56jiN4IojNGVjGNTIHV56URbd5OU8IAmOV2iCjLBXZYe
   VFP0mUDAIVgp6Y20DTiCdSr4Z81D8D03HXaRyPGBQM28c1+154Hn6ib3j
   WYPniFqkuT508kBIUH28T4NEyP0K+zN7ImOpl0yPFFRQ4fDZrJJrRm5T7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="450870006"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="450870006"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 04:53:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="753378251"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="753378251"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 04:53:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 04:53:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 04:53:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 04:53:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 04:53:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTGsCtz0c1m7oyQzHxw4XMJrHCmt7Wp+UhBJEGiErYdZtPEXDh/+/SxrfR4V2xFP/GGqOJpfnOvyI4OnWTxBNr15sKU4RvfmI7gl0Ne1X+Hgebkoa2e4M1cfCT+HjhV91lOd8Aqtr1c/IQmrw8NsmYR+8A7AvhfjnZbgks+o51lOaVGKMPpkSdHJ2lEYdpj5gPgTMsdk2Koh84sz4MPYCe2NQpjSU8nARkvuZPrbBBHfwEYcdHTYCbYUw/lS0mGcOpRYwBOR57muxNUHEGCGPyKaLRL3KPLH1zCkNju+r9zYeXhcw8sNqwEv+sLyDY48R0/MpooNu8BMRVxkXAWGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Wbf53k+mN57gvI8z43HeBxGIZpLdw48GYA4TNra+2M=;
 b=Ez5aRkaEojXnlHb0i6E+Q6Q1M09O4w+k4muK8w6ivw1NaDuvvVP3gM8bAHVyg8RaG++9CTJYmWJazl7X/D5MLSr/AFQJA+vAGRHDw00dMf+B1t0D6lU8p8eQwJwI0SysYpESOk/vc1MX0Tk0FBJgdGWjEfhwOTG6UHVlh/qW4t5fw2Hr26mCy4XPQf1FIPOe1xfFnMmye24jL4mEBDJMIqpjJwqMVb7hOkWcneB4+xnjlT3CmIx6RTeoMrfNsGW/TCS8KNJCe0VbrkM8XSem6A/yhImq0vackWV1qj7UwBliqj8QOmIrHOki0uD+hNF/+EPkYl0qYrwrHiXO6AMdJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 11:53:36 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::ecc0:2a4e:16c3:2019]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::ecc0:2a4e:16c3:2019%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 11:53:36 +0000
Message-ID: <f30ee046-82b2-ad7e-f173-1ac9e8b29370@intel.com>
Date:   Tue, 10 Oct 2023 13:53:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 08/12] ASoC: Intel: avs: Move snd_hdac_i915_init to
 before probe_work.
Content-Language: en-US
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        <alsa-devel@alsa-project.org>
CC:     Maarten Lankhorst <dev@lankhorst.se>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "Daniel Baluta" <daniel.baluta@nxp.com>,
        <linux-kernel@vger.kernel.org>,
        <sound-open-firmware@alsa-project.org>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
References: <20231004145540.32321-1-maarten.lankhorst@linux.intel.com>
 <20231004145540.32321-9-maarten.lankhorst@linux.intel.com>
 <4374f40f-b1ab-a009-8d7f-1f4b6f6355ee@intel.com>
In-Reply-To: <4374f40f-b1ab-a009-8d7f-1f4b6f6355ee@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::20) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|CO6PR11MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af0044f-9705-423f-a741-08dbc9878926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rSo3Fesst9fi48q6Q8JBqMsaq+3lVmLTrrokffuQdM2SRww0wW2OERQk1x+v8waXBwAEfQkyOii5d8oau7zbnv8ICvu1E4spcepZO8aGBuPHSTEiOtWTdW/NeFHWPaUHA/GGHKoRW05Tf7fzKztRCRWA6Bbpx87sfq+7GfR0HY6p8cUBoYDgDStKmM/JkjN7Z3qYqlk37KYGZoh3blXLYASJKelLmEMWJYu+lVn6icvNMsghMeZKbqvlPnX5wYm3zi6bjaLGxJTtaaCucyXnHbYgBnckkwSMadsm1SoZS1A1qchVMC7tk9vkrXWn7byg5QXD8HuKTXNssd3C7ZD6LRIzC6qajlEF8Yzs+SKdSOqzAnF/55f5QR0moiX58/K9hO9VsPR+cn1yTLYp7TJsOtfbqW1QtpVJkiQTrPuo50sbkjLwKNO8OTUP3SbvdSVRmfeRQLGuVLPsx2vFlHvf1tlqxrTDS3qhxIg05DxtvH5R1cnFQTfu9bsfKqFWI0/QSOUC8bQ25mOZlsE/i2ykZq/XvT5QYipjJGvCoOjJ+VW4NU2r4M+/SZ5X5iBHG8tMu6FaEmTvBm/Y2v8yAaWXuaQ0uN10jiv12Xm93S61HCJM4nE4YElxE1UIlkQ0M/mvPDtoxw/Ttv1bUJitg5Q9Bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(366004)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(4001150100001)(7416002)(86362001)(4744005)(2906002)(31696002)(82960400001)(38100700002)(6512007)(66556008)(66946007)(66476007)(54906003)(316002)(6506007)(53546011)(26005)(2616005)(478600001)(6486002)(36756003)(6666004)(31686004)(41300700001)(44832011)(83380400001)(5660300002)(8936002)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHpFNHg0cjVVNGczd0MvNzNwRzFhQ0R2ZmpNQ3NuQ1lXb0oyNnNkaDI1RlpH?=
 =?utf-8?B?SmlMSnRFMjNmK3l5ME9mbXp1c2d3Wm5UWFVJMUhxZmlNbUpEcldPN1gxZDVk?=
 =?utf-8?B?aFlTRlNoeVJOK0tKdDhxM2puUGVJMUV4K1pxbFVvZkxDekNmdVF2SlFZRXJJ?=
 =?utf-8?B?NWdPQWZ1MUN4WHpaaW9aR0djT2dMWlhoblBWRGdnMTdHSExzZmtVelV4blVn?=
 =?utf-8?B?MnIvVVlBTVdndkpxUC90WkJ0aGtOMnBYc3lJaTc3Yk5xVjVxWmVJMFFiUlBP?=
 =?utf-8?B?VXQvTU1PU0NKWkFQYjlkRENRNXAzdUlqS202ZkRJcVRNUVlyeTd6SWcxVWo0?=
 =?utf-8?B?Zml0MGNSa09RRFRjcXdDU0pOaGdDdm4rcVd5bkhNWHdJRjFqWHdVWHdVMHhJ?=
 =?utf-8?B?TEJCK0U4Y2VYdmNWMVpRTmdadjNwSGNQUWRoV0VzSUYrbkVtZXVzSzFYR0Rs?=
 =?utf-8?B?VFBDOVdqOGFQazYvc1JtYy81cEpiQ3NuWHEwdEN1bXJpZTduWnRPMlVZSmhv?=
 =?utf-8?B?Yy91VXc0WVFPTHg4bHl6QjRPelVYZ0ZwSlZLSklVRnFOYmpkcXhqSUZTd0tU?=
 =?utf-8?B?VktSL2w3ZnNEUDQyVGJ2YUVlcWE2NTBnUHEyUUlxUHFEWnBZR0xvNFN1Rjho?=
 =?utf-8?B?bXA1R1lRMHRsMHRpSkhMNEx5U3paYm5XOERMNS9rcWJxYytnWEZ4SjdNWWFt?=
 =?utf-8?B?TEJBUEVKazllRGxVdG14dzlpNlNieXFCMEVkNWQwN1dLRUVEZlJpMlBTejBl?=
 =?utf-8?B?dDZvS1RsN1lwTG9wcjQxaFJXdXVxU0V4MjU1V0NwbmF2U2xQNnFJYldtS2Za?=
 =?utf-8?B?NGREUTB5RU1XTHZoRDhDbUp5NlhhZWdTd3hYazRZNjRtZGZyYkx6cERpSTBj?=
 =?utf-8?B?RmVGenRIY0M1OVUrdFduaTEyTVhtOWNMTlhCWFQxcDkydkxjS2ZNU2g0N1RW?=
 =?utf-8?B?NUYrcWEwZWdzeXB2bFk2aTU0d0Roa044U1JETUg3VmJ3UGMwZ21lWVVpQi82?=
 =?utf-8?B?dzVJK3ZhL1JWRmt6SUdZS0lqaGhOdWxkV3dwUWE0aXpkeENCNHNraTdWWHBj?=
 =?utf-8?B?cVlLRy9HK0hiT2w3a2ZaM1gvOFl2bFV2azFFWUFJUGVjTkoySy9sQWFCdmtO?=
 =?utf-8?B?Y3JpVVNOamlzMUdGQWIzZmU1cUlJcXlQNlVwOW1wOWxwSFJrQUtoYU9CNldX?=
 =?utf-8?B?cGYySDhuazVrM1FWT01MOHdtUkFsYTNMZTZ6SW1raEpWaWhwM3dTR0tWMGlw?=
 =?utf-8?B?M1czeXhDdVZYRFN0blRCMTVSUEZteVdWK2xHejdkVHgzRjUzV2s3eVZWRXVD?=
 =?utf-8?B?bHU0NFJVQTlMSTNPOGxwei9YOUpCTVJjS0dTcFBaVXowRGEvL1BPdUQ4STZa?=
 =?utf-8?B?bkJ3bjhzNStaTFJYWTVJNGhTZi9QR0JwM3NUNjl1Tk43K0hGOGVFYzU4Z2pB?=
 =?utf-8?B?VUFwODMreG91clhxbFJiUjlPd1B4QXcvWlVFdUNGSjAyejdpOUdpbDlETDRN?=
 =?utf-8?B?aUlJNnVML0RRcWlVSDlXMUtoVFMwN3FEdHpWblRJRUxydkxENzBPOVNjTXZB?=
 =?utf-8?B?RDFVN1owUlF6MEQ5NkxsOWh4clVZbjNTRG52YWRwdU5QdU9tc3NlVDM0dVhB?=
 =?utf-8?B?RG01MzBnSFNHN0tWa3Y2MDMwclVwb0toRzRPdFFhRVFrMUs1QXhDLzU2cUZy?=
 =?utf-8?B?cUNVTHl4RkZTaFpmbm1Pb2d4enRYaGF3ZG5SVkJnUWRDUVBJNGpMNWdyNWZE?=
 =?utf-8?B?VzdoMjJ5RXBsc3dpSkc2UDJ5cjg0amlRZWJoMmgyMmRRaWFqWDBJU2NnQkRm?=
 =?utf-8?B?ajYzNTlDQytLMzJ5d0hQcHR1YndmNHNYQWhjSSs2N0l6V0gwaVRocFFld0JK?=
 =?utf-8?B?RFMxYUwxVG9Pb2lvRUVsOHVmaXZITFgxUVdOdXhpV0h2cE1tdGtRandGV0wy?=
 =?utf-8?B?cXJoZkFlRGlXZkZ0aTYzK0FPSkM0NDQ2NGFLT3pTckp6d2Y1aEVJSkRmUTFO?=
 =?utf-8?B?ekVzTW1YVjFIbm8wd1BhZzgwUjVFQ0ZYRzNpVDg4SG9qcDJhS0hseEpLTk5F?=
 =?utf-8?B?blRPaTZsVXdlUzJHVStNL3NFcERWSFRSdUtBYkZVOVkyNkhrSkFkR3V0TDd1?=
 =?utf-8?B?MnFhUDhCVUg2azlQYlZFTjVHMXVTR0FVUmxJZENLS2U0U1lxUlJWa3pwYnhZ?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af0044f-9705-423f-a741-08dbc9878926
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 11:53:36.8312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fT7MAvCU80s5zK0DgNH35CZ1Byo+viMJwDEzBJtltZDQrCi/e//L6DSQROgT+aUFhZVIDn4REP+SHXciGZGdyqxO/VIvsgw+C21YbZOndTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5618
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-10 1:43 PM, Cezary Rojewski wrote:
> On 2023-10-04 4:55 PM, Maarten Lankhorst wrote:

...

>> @@ -465,10 +461,19 @@ static int avs_pci_probe(struct pci_dev *pci, 
>> const struct pci_device_id *id)
>>       pci_set_drvdata(pci, bus);
>>       device_disable_async_suspend(dev);
>> +    ret = snd_hdac_i915_init(bus, false);
>> +    if (ret == -EPROBE_DEFER)
>> +        goto err_i915_init;
>> +    else if (ret < 0)
> 
> The 'else' part seems redundant. s/else if/else/.

Spelling error on my part. What I meant is s/else if/if/.

>> +        dev_info(bus->dev, "i915 init unsuccessful: %d\n", ret);
>> +

