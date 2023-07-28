Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0025B7675F7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjG1TBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjG1TBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:01:51 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8098C30F5;
        Fri, 28 Jul 2023 12:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690570910; x=1722106910;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VJI3XYgP3PmRkui5PmPGXV9CU7kFWf4up8YT/yQmiVw=;
  b=ZVNwLs3TRRUCkxHAYVJil8XbzrdJ61repKwu76kiaEkOe1KbfUg/LiFJ
   jV237eJ2ckzVdSvqlKJ7jCgv9b+oVmWKbdcDRnuk7t/D+wVn8RZuMq3/o
   28CwBdJnheTnzsD2+MB/YBif1lKCyq/QKMdf1vk+fPXyjviJxiR1QGFzk
   SQzPUySLMhFg8Wwe7Duxcw7Pe6WTOZgxrKb1lWlBsj0/7gGFsBzXa49/L
   qhVbrklG0HKCD4Rlg1IhxoLbMdtuRm58fDXQIfdusP6Sx5XWxazjkbTv2
   roP7y1KmE7ZTuLmdNdzhdCo2AVHzZw0YCXMo6X7i0q4ssTOYrogwe5k9g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="358689314"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="358689314"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 12:01:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="974193955"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="974193955"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jul 2023 12:01:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 12:01:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 12:01:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 12:01:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLyhiLgk4/idmnpwR6De4uY/p1zFPmtJTLmjdvOefGMSozFINLJTWnP847DjVUM+518NGvaaKRYYrIj/izmha5YoYjkV4gQvS73ZC/60uvjnSeB+odZvAtwnwF7HQjbumnXvEiMEp7OItS6/6lbn64s3vho/yYiA+uDuSi/D1SCsCHaPlILrn0kfbjS/oIG4+k9wRSB5tIbJ9k5eiYfyKTSeAmnAqFWQhdgl3nBCWtLOEYRHDpkhXqnsH6oD1Pz90aipqA9gADEbcLafhk3wndrFHoMZ8n1gT5X6LLv113a/KQ2p9uGZ3GG8MiDfMZs+AinbCA3HKZpn8yLD8JZLYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJtD/TCjNA/yZLGebweRCQDTI5jOghDgo7VsrFbCXzE=;
 b=P7WvMVXiV/DgHz0uvWGf/Ioq7nv3LpfQsld+Y1aajaaZugHZ8RaJjzNlwglTAS4DvtI99kgfC1YgL7UdyuuZR9mRZuSujXx6vsLQVQqaw6Qnj+c9eScVTeHdb1XM2bYDfcPHp0VdHx3PpTMv/66gnOMN4v5pXOkFZP3JLxBaxy+nuTUD4e4fix6WksITtbKvZ3cL1gBTrKU8q6nblPPBTzVjEhUcFPidSKzuAyq7BCL0o0kMEsdvPZDHluLTlvBmys/7wsgZH3ZJkxt4rCBul48v0EWNm7Z96zT9t1wIzIBBV0XQCtB/qJ55cMhKcS9UXqAMa7YoxpI5Ly3m9A6/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ2PR11MB8423.namprd11.prod.outlook.com (2603:10b6:a03:53b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 19:01:03 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2%2]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 19:01:03 +0000
Message-ID: <ed25d677-5f9d-d78c-4838-393248f08937@intel.com>
Date:   Fri, 28 Jul 2023 12:01:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch v2 00/38] x86/cpu: Rework the topology evaluation
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, "Jean Delvare" <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "Russ Anderson" <russ.anderson@hpe.com>
References: <20230728105650.565799744@linutronix.de>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230728105650.565799744@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:180::43) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ2PR11MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 043af466-4c31-4b95-4767-08db8f9cfd26
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RUW/LM2n3RXAIe9AXbljqelB0tLEaZiOjwCBflBH9Fo7B0+5yznDfh2xfCgIO9e2EYbYphGDiRwGh//j2Vmk5udtTzASa60AKgtVTj6rGZM2KraFjZvLcIlhPt302hba5xMkBrLjQCs2hUBfCZU6DvipsdjeK7r2x1MJroXEd7cUkcY92WMTRNB7OAT2jg6cMpS3HBJK+qu9v9BlHUt/VieWqfKvX4+6sjZciYrRMDBZUQLvdtSLPuzjoHrYDUFJ3Fu/G63WOogV4fQ4uVAlgowcgp9dE7QE3Cv746hi9c1CTLAvQQImxKQ8OEsZXvAkemmbydSG/bp0QbM+iDG49ztiE5nTGM1Y7GZpf8d/JLJp1II1XGJNTU+SuVvRokpFkntZPoHhpZqYXqVlUD6N8ObyPFP+3Bybhj0qNXJZT8JoMjBF1cyrTpOrZfxChU7f7N8flU6wy7cv7n6o2aWKIHXE5YbDexP9kncm+9LPreHV5bRAP1PBINAIMhmSUO/v3XUe4Ak/fZRrMmN3lgiinQhOqH/JL9k9s7+kCTM8DttjhI5Hg0fSHTI+4MBtwYKLVwvBI5tzeR2Fhc8kGo/UB06TItvcl943R+ZfJR3rrOC7uqWfiP6Exmuz3whWodWZoYNZ4UhtGuGscuc2I0P3BQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(4326008)(66556008)(66476007)(66946007)(31686004)(5660300002)(478600001)(6486002)(82960400001)(966005)(6512007)(316002)(110136005)(54906003)(38100700002)(31696002)(86362001)(41300700001)(8936002)(8676002)(26005)(53546011)(6506007)(186003)(7416002)(44832011)(2616005)(4744005)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFBQdkpzeVQxRGxrVlkwY2Y0M1FmMlhJUmtUcEJEKzFLdUEvUUd6SCtZT1ha?=
 =?utf-8?B?Ry8wYVdMS25EWThMU1dZVGtSenNibFJ5RnVwWjRsdFdCdHRXSGQyRTc5UmND?=
 =?utf-8?B?Y3RlODY5Z1R0Qy9OTEdjVnNsTGVxRGdpNVlGSmU0UkI1cG55NllVQ3J5VUky?=
 =?utf-8?B?WjVjbnM3VDh6dFc5eHJvN0FvTWI3d2dITGE2TEhqckFrbTlBSFgvS2FDcDZZ?=
 =?utf-8?B?M1I5TGk4b0dmQ3FZQjA4SnVkT2lnM2RnTXcyYksxMjczR2VRK1QveWxJTzdw?=
 =?utf-8?B?TmI2cWh6dXAvOXMvek1xcCtZSkt3OHFyUnk5VG9ucUo3ZUxhSGc5OFlleEU2?=
 =?utf-8?B?MjR0MEpVak10aTlkT3FRUkVzbmFUNlJpai91SXp6Yi9rdWpYbm8zTGFmOHpi?=
 =?utf-8?B?d09lbU1VK2lGdDFkV2pzUDVONlVhd1lhNzA1cTdzNjROa3Qzdkl1TzE0SzJv?=
 =?utf-8?B?ZUtYMEtySE56THg0QktneWc5TnVIMXNHRTExa3h6cVdYV25sdzVNZmRLVTBw?=
 =?utf-8?B?QXNEYjdRdXhqV3B0ZmlIeXZpUTVDRHBnckVyMElpZUJ0QndZUSsvR2VXd21l?=
 =?utf-8?B?ZUR6WHJQWUxTY2xUWG1NRFFUV1Q3VUw5Z09JNk9UK0d3NVVrdnpLL2tvUzlB?=
 =?utf-8?B?UWFHTThKeWxTNk8xOXduNlJCR3Z5UVhXZlRBMVNSYk82aGZYc1dTYmlyV2Vh?=
 =?utf-8?B?Y3BOcmt4cHlkR252cFpSakR5UTNwajJPTzB4bzN4MDFoenNDLzV3YmJ3aWNC?=
 =?utf-8?B?dlpDdjRYcmljMlI3djcrNmkyNzhGNnBYcmRxNlBEeWRCTmEwc2JReERWYmJI?=
 =?utf-8?B?aTU3MzdOd2Radm1lTjlWRzVIWXlxcnVYYzVkVklTZVJXRVJMOFpFU2pCSmFa?=
 =?utf-8?B?Zm9GTnF6cnl4U1BmSXRBdklScEdTSE1FWTVEQ1dCeWZ6eG5rU1VPcDduMGh3?=
 =?utf-8?B?V0t3ekorajJvOWQrdFVWRmZ1Q2p6U2pzZ29DSDdIQ2VSaVp3bDlHVHpjV1dq?=
 =?utf-8?B?NTY2K2d2WGNsODcwcmtDUVQxVzVoeTBDaEpMK01WdTNnMDdLWmFYVk1VcU9L?=
 =?utf-8?B?a3ZYdjRCVW5qQTlaTE5PSFFFVWluSTJkQVp5cE1rN0VKV1RsR25uaWtkcFVl?=
 =?utf-8?B?TmdyWDBXcmZiMU5qT096a2ppdW52enUySmt0eElmeCtzdVVtUVE2Ykh5bGJH?=
 =?utf-8?B?d0tkOS93djQycUViaU1ycXQ5NzBac3lkdzRaeEtLSHNzc2lGbnAxRFFwZFNT?=
 =?utf-8?B?U0tMSWx2VytvZkw1b1AwSGkxaU1EbG93ZFlSb0h0WStKQk9HSCtnWjV3VFZw?=
 =?utf-8?B?Y1M1bkFSeGFDTDRmY0pzb0lBUmRMdldmcXhtcEgvTE02L1FYeE1UaFdxbjRi?=
 =?utf-8?B?a2ZYbGQ2QXIvSUswSFlHQm4vVk5BSDk5K3hybWM5N2RtNjFEenNDVlpVblRG?=
 =?utf-8?B?K1BFZUFBQm9CWmF0UFZrcmltODQraUFwVXVCYzZzK2UwcG9OQW9aQ3NzcUww?=
 =?utf-8?B?MVNVZUtkUXFOUjhRQ0ZNK1BDVk1RTWtqRVUrZk45Q2tsN3pQQ05IU2xaU1F6?=
 =?utf-8?B?d1Y4dnFOVmVOSjhBK3I1MjJNZlo4ektWeXFJSUxuY2pLQXhYc2FUZ0JtaG13?=
 =?utf-8?B?VEFyZ2o3RVJOMEtkZ1BSVTluY1hFbHA3OXFocTBnV2NaeEhWa3A2TkpUNmt6?=
 =?utf-8?B?VTN0d24wTHV0dW1HWFFvc1p4SFl6UU0xUFJEWHV3NlcrWTFydk93Sjh3SFBF?=
 =?utf-8?B?dnhRRENFNzZ3VzlKNkFZSy96YitSeXJlQ1cwZ01wdVpudmdMRUNXUWhsekh0?=
 =?utf-8?B?K3pEQndZSnJnSXR3eGg0SlZmczRnUm5xRFQzTmdkU2RvVGV4ZUxmRDJXdFFU?=
 =?utf-8?B?bHVtMVJqZkNTVGkyUTJraFNBcVR4cEpldlNYOTd5Z3pOOG9oUkRycTVkcGRa?=
 =?utf-8?B?T0kxbUpZSWxxcTlmTHhTdllWaFRoczFjZ2xrQ3dIbmtMaTVMWncxWWdZZ0dt?=
 =?utf-8?B?K2tVUlhPNXJvZ1FQL1Qyb2hLVGx0V2o2VHkxcmlOakY1ckEvM2U5aklKZ3Y5?=
 =?utf-8?B?Rmhiam9Uc0E1RVBhWVNTeUVHMVpBRjJod2kvTFBOVEU1bi9vWHQ1OVlUckRJ?=
 =?utf-8?Q?8+Ldv5oXVKYk5cWuxqmJ4IujZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 043af466-4c31-4b95-4767-08db8f9cfd26
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 19:01:03.2083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYtmYfSNnENx/sH0yoX1FUMNsMPfFLBaQzIH1S5UOjUWOpY52UD7U77ixmtQkhKf3E/04gZT7ScD6qg7qaCcOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8423
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/2023 5:12 AM, Thomas Gleixner wrote:
> I did not pick up any of the tested by tags yet. I hope people can run it
> once more. Neither did I add the Ack from Peter.
> 
> The series is based on the APIC cleanup series:
> 
>   https://lore.kernel.org/lkml/20230724131206.500814398@linutronix.de
> 
> and also available on top of that from git:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpuid-v2
> 

The series boots fine on a 2S Sandy bridge system. I didn't see any
issues with cpu-hotplug either.

Tested-by: Sohil Mehta <sohil.mehta@intel.com>

