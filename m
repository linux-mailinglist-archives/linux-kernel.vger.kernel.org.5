Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5967B5D7D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbjJBXBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjJBXBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:01:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DBE9E;
        Mon,  2 Oct 2023 16:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696287673; x=1727823673;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FSvdU1Gml/r3keyfcqrAt6YyS16ScXPuS7VMYUF0PaM=;
  b=hEeY7DNfofX+KoS7nGGmNrAiOi5VUBJiiqDesGV+25Bf0anknX3xoIuK
   5yaoadIRAULhtGk0W/eV6DLH8g8X8Ye9R4Hn1aYHjb11VvkIr7E0x/+70
   kfimSIxTifSj/y/rbAmbaKs9QKmVICWiak/t05pBMZU+vYesyD6TNnLcL
   svZtuHhlCiJQfYRMK1zjudozU821Unjx4sTKA6wiPGgf7GtZ/wbAxVkGf
   ExDnKD3nRm+oKM1BvWpLhK2/G55pcfygORuiVO9bHAdExzQ7inlSOQhM6
   sQv649o4M2+k7Dxnv32pkLG/Hz16VPKj0dH7Z9U+ujNo0qCyrnovUIJ4h
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="382667474"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="382667474"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 16:01:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="780091135"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="780091135"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 16:01:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 16:01:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 16:01:12 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 16:01:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P34qoNiHVCyK6jHfI1sgP/4mDzksiTUeO/XlWZ2+7OK0JmEWvf+V89L7PGywtDY4d+BTfETmd7Tbf0QFl0Btb6DDMhXm+yqwaNrUdlCnB5ceJN41dA2ZGIBEPCozaEpm9N5AVZoUaVnbG2MW5QsJrqHgm6qNGwk3uUiEKVOWXBNV4ebtuRxtkXYfE1slASpBRJyu/Js4pxUjRMX2uU6GKlXYj688B7fMGb8EpWVgRLU8RSlIp6pcPL0JC2k3ymS/AWDkkBAOyMhI2DoyitggSbHgweRWLFdKl7XEdiJBoBNhZnddkCkLWEKrFkx6ocg9DuI4tmJqps34tGDCJ+AKIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppGvQGYBL5ocIBtvtG4wMq6cvNtoiQVb2yVVnxPlr6A=;
 b=N5XPPIPjXAfMmremo8f2LwCgWTIy2gDEvMFX3ufW/SfvVSZHcJ3P+WsSoPCqt2NBFPK7qdCbZNmP9u5KruBExVYZsyFxps0V605uMjKNmW0X8VkzULbCvnjvrKwG8tbNO2mfcGK3dVVVw4qp+mCbQHxpDkFAU3yj5szq7Vqac5nwlrYBO3YG6+x48zNCs8tt/w0OI5o7vzxamqTxWAyExlg+3rm0+bj+BUqHbbZeaaELoAzE3g9tuhhkKFihcXcATl6T5f1qfGseL5QbEBO5J/XV2L/ykT3nsWpadcbpRjsg1c8Q2oL6F0mN2Vf8dCvKvTujLZo/x0HLszMRUsR5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by MW6PR11MB8440.namprd11.prod.outlook.com (2603:10b6:303:242::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 23:01:10 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::c438:45ad:1a1c:e168]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::c438:45ad:1a1c:e168%3]) with mapi id 15.20.6838.024; Mon, 2 Oct 2023
 23:01:10 +0000
Message-ID: <5e354fef-555f-f461-c847-3ee694152d06@intel.com>
Date:   Mon, 2 Oct 2023 16:01:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 9/9] platform/x86/intel/ifs: ARRAY BIST for Sierra
 Forest
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Hans de Goede <hdegoede@redhat.com>, <markgross@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <rostedt@goodmis.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <pengfei.xu@intel.com>
References: <20230922232606.1928026-1-jithu.joseph@intel.com>
 <20230929202436.2850388-1-jithu.joseph@intel.com>
 <20230929202436.2850388-10-jithu.joseph@intel.com>
 <b92b44ed-19a7-aec2-615b-1b1755dafdac@linux.intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <b92b44ed-19a7-aec2-615b-1b1755dafdac@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0285.namprd03.prod.outlook.com
 (2603:10b6:303:b5::20) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|MW6PR11MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1d783f-3254-4543-02d2-08dbc39b77dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L2n3h5UtOIrhVq3ahgdinTsmS30px4fSPB306CUdklEViZAdPdv/XpmODC2CZA1/CfVtfOmyozfpkTBdICFSgmeIw7SlQEeGL7g2leXXsS/scAZYaaJ2vRHzrO6FAodXAhdi1E5lVHKrPo0+Bia/tazTvlNTNywptRoTKAPtuyMDL9nW9114/dBUFUicU4XIsZVDC44za5pV0MrCwMGI+hMFghGWF/1/sxka+SC5mkaejhbe7fVIb3cT7AYnapL4xTjA2c7oLGsVxbXptn1nVTzUkN7MHUcyKz2MYxubvyrwhrdk3QLiKs+AuUrtyOR30rYskICSMwyGU/+XIN9vewHIeQ7qH+ggGWk8k4JV/vYRZnpOqwe1iMC1oyEqsqaA1bm5rO8q6/Su128pqpbM1hJP4n7MGzQNRrLaec/b0gUxVVPDbhWdl5CnCio3FV1pzixumGeEdoEJGaN8HeCYgnwEsn2uFZhZO05g7QDMX3C+K9vLI41QbCwzUG/WYjtsqlbk5yp4cEkycA7TaD3/v9O9JehbO0/7EDkOVlGqi32OyG1cXri8xrJCQVjLP0SeBhmYWyu6/6UjHuSkefyEjLKS1vb8KeddStP1vl0EOV9jwR1aBObCfutqb4K2LbQthSA5d4XQTmxu3EPlqlxPxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31686004)(6666004)(6506007)(478600001)(53546011)(6486002)(6512007)(38100700002)(82960400001)(86362001)(31696002)(2906002)(7416002)(41300700001)(26005)(2616005)(36756003)(4744005)(66946007)(316002)(54906003)(6916009)(66556008)(8676002)(5660300002)(4326008)(66476007)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1pDQVF3WGRwRzE3aTd2bk15WW00L084SUphckIrbHI5dVpBa3hHU3pZYmxW?=
 =?utf-8?B?NWR5eFN2amZJM3oyY2g2Wk0rd0M5Vk5mV0dlTHlJTHhKWElLVkd2SEZGWGp4?=
 =?utf-8?B?UFlWQy8rUUpGSXFGdHJjRG44ZGsveWZINDMyV2hhbDVHVSsyUUhmaC83SHVI?=
 =?utf-8?B?Vm9uNEZpV3VMdThtek1KOWQxTHdCQS9ENEc5R0dEbkNuUzVJMm1pWG00QktE?=
 =?utf-8?B?eE1IU0lwVWt1ZStKcXBseDNJTk9WSkU5RGdQYldtS29peThISXVzZWliMFJX?=
 =?utf-8?B?Q05vcFovY3ZHa1NnemRVUXAxYkk3YkVNcm8ralcyY09rZFdQdmFJMkVFaEtS?=
 =?utf-8?B?aHBDM3dwVHdOL2tXcUh3Q2h5Q3hiUjg1OEdyTnZtcCtwTVBDQ3V1bzZTLzZF?=
 =?utf-8?B?WUFRbk43U2svLzVmdWt3STNXMmRtMnc1ZGlwQkp5U0Fsa016N0ZveVNyU1FM?=
 =?utf-8?B?cEdObStjZTdFUmNaTGZtc093N1RjZURMRGpWL2hUeUFaNTBJdVNLRzRXZ3hF?=
 =?utf-8?B?cCtGcHdiNktDUjZRT3VGTWtKRytGVnhhczM4cXJ1QVYzZGpIR0U1YitUSTRr?=
 =?utf-8?B?cWYwQ1R2a2d0c1hTdlc4WnRHcUY3ZzFmMkR2d1N3QnYxdkQvUzRXQ2NDL1lK?=
 =?utf-8?B?YXdLeDFwZkU3UE1rTWRDQkpuSFQ4cXVZR1JFWTVyUDd0Y3ZKbG4vT1hteXZQ?=
 =?utf-8?B?YXB4MFZKVWRGSnU3N2VaekJyZkxCN25ZNWo2dGpONUxqTTFRS2VodmY1Q0lM?=
 =?utf-8?B?RHBNVVFRZmgwQi9Hd3EyaUxIRExUamU1Nm5iT1pLck1Yd2xwYi9GWi9SNGFZ?=
 =?utf-8?B?K3VRMis4c2plbFU0Uy8rVlVtQTZKTGVoYlF6VjdHblVBcHR1b0JUV2VWZ1JM?=
 =?utf-8?B?YjVLMVB6UkZCWTEyRXcxczcxdElHSFlEcDljVTMwQ1NTWG8zZGd2TkRhUm1l?=
 =?utf-8?B?Wmx1aUhWalFKK2dGdktQWW5pVmthMTNRbGJXdlJDSWRGY0M5clYxSkp2aGtW?=
 =?utf-8?B?Y0cxQUMwWDNNNE5BZXBETWhrYTh1c1ErRmZkK3dHUGFNVFM4N0N3MCtpbDA0?=
 =?utf-8?B?NkZFejhWZEF3Y1FuM0hpWE4yTWp0eTYyTWdSODl5V2VCc1JSRVlkYzFSU01H?=
 =?utf-8?B?S2p2THk1YzB6KzdlY3FXZmpzU1IwamxZeG5oSlVvVWxLTDRvTVA5cFBYRE1m?=
 =?utf-8?B?Vm42ZEZaUkVPMGE3cW9hdE5HQmhYcjRuTVgyaUtIZ0owUUdaVzJZSGRRZDBD?=
 =?utf-8?B?bUQwdkNaaUNaNTJhYlg4THE3eTR4RkoxcmphQlBkY0ExZDdUaXBGOGhlSFNs?=
 =?utf-8?B?a2dad3A5bWRYQ1dka0lnZWNkTW9ZOUhnRHdQUkNtWmptL3ZqZ0dIRUNOQXVW?=
 =?utf-8?B?RWlhbW1VbXg2ZktIUHdVdlgxZEZSWkx2a0dwOXNGeFh0OXpoRWV4cFBmSjJr?=
 =?utf-8?B?cVp5OWNZQkZLNmw0VTJadTAxY1hVSjlFTzl1RFA4U3gyOXlva0RkU1llblA3?=
 =?utf-8?B?RTNaWFpMRGNYdDBnQ2NwV1pJMXVpeFQ1Z2tSYUJ5bHZHVC9Vdm1waW1meS95?=
 =?utf-8?B?d2YvcUNEcHNiaTZMdTdNbjFqQ2k3YTVIeklvdisvTzFycS9maVVTNkJ0dytq?=
 =?utf-8?B?dzNRelF0Ujd5TWZBVWRxVGpiRmxXZ1k5MjUrWEtCcnBHeUZsTHhCM2M4enRx?=
 =?utf-8?B?ZGZtcGlJRzdWcFBiM0pscGN3azVTeFphTEQwMjdObnBiQUQxQlhhUGpxUzRv?=
 =?utf-8?B?M05BWW45Tkk1N2pjRVIrWnRlY0MrMXB6NDN5K0V1cElyNm9qQnV0RmJvN1BX?=
 =?utf-8?B?WDlpcWVkVC9kaEpFMXdHRUgremo5SllSaGRZOHB3cUFNTzZ3QjVLRHBCOVp4?=
 =?utf-8?B?OVhOZnlUcFFGVWl2NXFLR0ZNa2xiNkpZWVBZVEN4aXhZVC9FRFFUL29UTDhN?=
 =?utf-8?B?ZEhRaXdZMGlUd0lmdUlxRnJxY2xzU3BXNkp4enVGVDluOXRqaGdPZWgyVnNv?=
 =?utf-8?B?RndBV1pKZExjQVBiYnZWR1g4VmpxSWs1TUhINnNtVXpUZmk3ODZUK1dhUzRq?=
 =?utf-8?B?eTIzK2MxQUREQ2E1K0crcmVucUlMUWdybFRmNGltSmt6eDRtSGNPM0M0NGJS?=
 =?utf-8?B?YkNCNUVMNWZWTTREcW1JVDdPaGFlamNhWDd2T0t2SFFxQm1vM01hNTlSZ3Ri?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1d783f-3254-4543-02d2-08dbc39b77dc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 23:01:10.3094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikS4Fa1lVxhTdQ8vU26YIy1BXFVuXBBG+hOn5I2gzZcnSMyTF6G03rurd43k8Ij9GqchISGclXv+ahXQ4HtpIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8440
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/2023 4:59 AM, Ilpo Järvinen wrote:

> 
> Just a suggestion that would IMO make these easier to understand, you 
> could name these array generations with defines so that one does not need 
> to look what's defined in X86_MATCH() to understand the purpose of the 
> second parameter. But it's up to you.
> 

I can make this change ... Thanks for the review

Jithu
