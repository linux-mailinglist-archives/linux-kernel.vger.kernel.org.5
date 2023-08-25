Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8259789237
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjHYXIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjHYXIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:08:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E462117
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693004915; x=1724540915;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SD/+zXYeZhS1mXJgtDpvVyLszERaAjzV5TLOntL7gTQ=;
  b=BArg5Yr2JT/47rwj3Pz/opXv1vO2oI9eYshlrhPcnm0UqiiRVHecGFNo
   6oReDXOiQXtd2f6yz4yGHF+G+07X2SqphLAzPjV+YJ822BMbpH5bCNp61
   HBW+yY9lQfmmnllPiJ3ZqxR86A/9FYEyTMmvlkh+Ssu6QfHwXqnPaRCtx
   MIqLUi7nRyF4vK1tc8K5WrGG0sAZr6hvZ4Gipgx/Y0aW1/kQ0EJOv3gZS
   QHKND2KiW6lKLTjmrxebcXsCM/WfJL7FYfh5BoPiDDJWcP4OV0kw6pAiS
   rE6RdiVb5BU0buI/mvtqkqWqPkPPEYYBD4AGR0TE4xpG9O6DR/X9MvbrR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="359817254"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="359817254"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 16:08:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="740770170"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="740770170"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 25 Aug 2023 16:08:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 16:08:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 16:08:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 16:08:32 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 16:08:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lE3+VvNbbJ8lhH1o6MJUEn72ICKufbL/BAe5cV7CySEQluZEAjx5Xp/7RRASNV6ZavlkAktCoVHDO2iWdMyjPu4oUEIceWtBj2EQJSIO2B4ma9gDJxLcqjiynlrLF/BOtzeJoS75W4F27asn4JAVWj/NDsahtKe+zUNOe7fT+V3F6oFwWO7dyBgZPOCuxfvl3Fmo2nj5XCnj/LZcamEwR/LEhl0tHdcQqA4PpXlcu0AGWWIV5ffegBnKlsxW6yHU9UfKWw/DuA2HKRANVaO6DZYvqOpLCxSOOC65InUWDuwt3tUZuVPD9WlgksrJfPL+HGWrPgD24N8S8VyZFDjlXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oK281+0gfGag8B/GU2w91MzpIK/FaU0ZxC2fldXWVvQ=;
 b=Kew5M+bqKp4mGtuuaGdCod5ikKNDtEFJCcGdTNbEJKj5dsUVZIT9W0IBnivsjKy1zmHHcNGUJm2cPF3OR3ZLjeLgguX5+0nCyMkYg2GyXXrn2OsIZkqSSV3y1bLIMKzaTpoAdZvVpZ7IsySlRdj3dUk2At+bbNlJyc2DIYEDPibqNjIK1nnPU2B3ldo/PKplHSeJoR/M7d5HSqOcXhiEE6cRwiMWrVEuZH4vkCyTrR2RgcYbRYcEZ+3xV+p9/jOSuZdfFjr9dyz8qcQ6gMztwIVkAHCuH6upRqT+or32T/FayKiadjgej6ZzQeNJHAa/IlIv294Gyv2YRpVRc9o2bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB8144.namprd11.prod.outlook.com (2603:10b6:610:18d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 23:08:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 23:08:25 +0000
Message-ID: <b48fe955-c1b4-4aeb-1ab0-bf26e56e1f0e@intel.com>
Date:   Fri, 25 Aug 2023 16:08:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: resctrl2 - status
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
CC:     Amit Singh Tomar <amitsinght@marvell.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "George Cherian" <gcherian@marvell.com>,
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
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZOkU+d4AsLGSAG+y@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:303:16d::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 703993b5-8ebf-4481-79c6-08dba5c02f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBYYrlTeB4/xJlQT7Pg/qqo2uMHuKpcbQD4Q+hwaAYf+a4XFDldChI0FiIA7GZoC5e2FH9wFf4ATBnDMZV7/kOjU/ET2Z438nRZiumWm61O0U4XjoxjBtKC+fUUsqKc2zpAXHPUVZFwrDdOVQdsOh+9BpCfr4QFbzB5TOfEcpMSzqcrUfChCrw/dwSnOz0f5b0r97G37ODWKCS0sLQI0FfzVfYTWQ7B2tulbsYlVNZX60TX9qRzJpfe6O3Zl2DqNFTLAQSQ5Xl2MHdp5kpAXNDS4FmNGvmQrBoqF3bjAc1llnFT8n/MUnfVM9HdoMYvNa/W4wDXcgTr019eopGFojAvflTCV/tGOtVDoyY0sbs5wTJkz77A3L/pQVPRmmxUEGalhPTZ5OFPHeZGJe6mdg8VD+LuXJ2fRkrwhIoxjz5KyCtM4RkyRtHn9HkAs0LEBOpQnJORlaN7vkZkzm1F1udq2IyMkwFziJ9FO4lJJTNI0tIPcVtfvgBtmspdu7lP7684lcNojUgw8dERKCWVxxON+pPN1IP7qLGOecEF2Lh4xb7Z5zrGt/O+vn4wTxiBoz+9z1EXbOoQ1aGKSdW+e184T9ZY2MCM8yZPyejvEmaC0k6GRfBUJoUru2x+20upSGyYhH0m899vOvjyUXPq7zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(1800799009)(451199024)(186009)(44832011)(83380400001)(6512007)(478600001)(26005)(2616005)(5660300002)(31686004)(2906002)(8676002)(8936002)(6862004)(4326008)(66899024)(82960400001)(38100700002)(66946007)(6636002)(66556008)(37006003)(66476007)(86362001)(41300700001)(31696002)(54906003)(53546011)(6486002)(36756003)(6666004)(316002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFJQdWY2Q3krN0NmNWdCVmVWcUcxdjBKdTY2d2FuUjM0ZzlzcGd2VTJWOXZa?=
 =?utf-8?B?aTVPdlpRSWYvUVNxT1ZiY1Yvd2RIT3FqUEtjWHNzQkI4cXNNaFB4ckZVclZ6?=
 =?utf-8?B?ZWpseWpDRUpKNlF2emxBTGpERnVSaVJadm1QTHBzcDY4b29GMjhEOXkxNkcx?=
 =?utf-8?B?cVIvK0xvN3VvTVVMZnlVWEgyblNHeExkaVdZVTA2d1haL2VqMEhheWdIVWFN?=
 =?utf-8?B?OEs2TWFGQzEybkw5UW5wRHM4aS9KODJ1VHJSVVM1WjVIMVdpeVhKSEtnL3cx?=
 =?utf-8?B?N1JrbytROTBGUEc5TlZuQ1ZvSUJXYmtvQlRCQUJPK2dGbkgyaTM5Q3h1a2Zs?=
 =?utf-8?B?cWovRXBtVVYvaUpuQm1WcGxqUmt6cXBKRk1tVjJVRHZ5b3pBVytwaUR6clMz?=
 =?utf-8?B?cnFtaTFFeEJUT3N3WWFKUENjY0l3S2g1RmZYTUpBQ0d0Y1lQbCttYk9Qd2Jz?=
 =?utf-8?B?eWRsbmZMYW90ZlA1eFBIY0trUlRSQUZhMmhCalBrQmMrMkg1ZnlYa3M2aUJU?=
 =?utf-8?B?bkRaMmlqMEt3UnVXUW80TUMybVh3Nm40MWoxOGNHbktWUkcvQ0RVUGM5a3o3?=
 =?utf-8?B?SUp6NDFab3hkYU1LV2g5TGpPN0djNSthWUYvR1IxYm1qZXhMRVNOVnlhOVF1?=
 =?utf-8?B?S3V2aCtQT2ZtKzFmYjMwSVh3NFVCczB0azgySXgvOGxPNVRVZHlTemxNKzQ5?=
 =?utf-8?B?VGk5Skp1U2IyaXMvRUhtU0tuZ1JvWUw3bFFiWUlxS200UDZXdThjQk5Db2gz?=
 =?utf-8?B?SGpiNTJteUp5SUFIMWo2VnZ2Yk1CRUtoa1FKaGtwa1Q4dEt0S0QxQVE5bEtE?=
 =?utf-8?B?eTdzbG5uVUNTNDNaeDlQcEp5MzlUcklITlh1RzVnTVBDcmF4ZmNxMXd6VTRh?=
 =?utf-8?B?bkt4b21oajRURTdKYmliRHB5TXdJcE5oSVJGcUljN1gxTDZ2MGRPR2tJNm10?=
 =?utf-8?B?Z0l6cnVzaUtPU3plUHVmY0NGWWR6dk92ckVpQTRqOURzeGwzMmJCRzJEanhJ?=
 =?utf-8?B?akgvOEhQaHVTZ0tPVDRMTVRtNU9VZ0xmSXpQellxbldrUVdCWlcxSENnbFA5?=
 =?utf-8?B?b3FNdlNnUm5haSthSGI4ZFlUVE1nZHNIckZwZ1VLQnB0M0xLdzV1ZVl0M2dY?=
 =?utf-8?B?YUxDWHdHZGtOTVc4L21HQ0V4dzFEVUIwbVNBSWhyMjVJclNDQnFwVllkRzBR?=
 =?utf-8?B?YWM4QzNPM3RGRGIvVjBjN0xNamVNSVRpRnp4eHpYb01MU1Z4RkNjMFc1cTZG?=
 =?utf-8?B?Y1lHRWdRVEJ5NVozSElQMnJCMWdySWVDSXUrY0VJWkxxUTErL0hzVUtwVEVX?=
 =?utf-8?B?alpkWkdYRnk5SlcrREs3amF0MFVxSUVQbXNGMWxDNStkdGdXeVlnTjFxQjFw?=
 =?utf-8?B?QVJTOHZDaXRRcGNQYnhSa3hIR1pRcE8zWElkWjFyVmJ2ZDNKMG5wdGgra2dx?=
 =?utf-8?B?R3krUFhYNGducGVMT01QcWhybE42eG9ydDh6S3VRSUw2aTVoQlNBaXBTZjN2?=
 =?utf-8?B?b1RXTFBvdWRkaXJWL2F6ZS92RVoyL0JlRURJZUp2eDMyK2dGRXlJWlBTakFC?=
 =?utf-8?B?OFlKVTNkai80MUtYNXJFQ3hDNW55aDNja29WWm1HbDY4M3FFWHpyVWppZ1A4?=
 =?utf-8?B?eGtkNi8rbTJNNmZJQnVjbHVxWUhNR2F5SWFYRDFCNWd4bTNUMExQb1VFYTdn?=
 =?utf-8?B?cVBIbDFFUUtnbFBhSlIwZmdCNWdPQWVmY3lCMldYaXVTSlNjdm1WbkgxQUJE?=
 =?utf-8?B?R3JQazVOL1BxclV5WmdvZFIzcGdDSUZFamd5MXpLVkdjR3V1RnRUeEdydmph?=
 =?utf-8?B?RG5oS3c5Q1Ixd1FMRE9VdC9KRHIvMUFqYzNMamdHQ3I0WEl3UkFRWXNGUTAz?=
 =?utf-8?B?NHBaZnAxZThVMjNvRWNFM3JhYVpMV256NDNGRjlUTG5pTXg3THdQUmNOTmNJ?=
 =?utf-8?B?dnJxb0MzT3lVL2ZLYmk5eXJNbEJBbnpoWVB2NDEvM1NIU3k0QzU3QWtUUjBR?=
 =?utf-8?B?UGtqMXdrWW85b2V3WmhlU0hvSEJvWTR3UnRnTnBOZWdvMTFPY0JMZE8wOWlG?=
 =?utf-8?B?NGVqdXA4Y3JHSHhSaG80bGxuOEJUVnNPRTh0NXRKNFJwM0xONWYyWXhlVVpP?=
 =?utf-8?B?V01qY0NqNmw2UGNvWldjbSs5VFZUbWdvRkNieldneHh6ZVViWmRjTDM3bllV?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 703993b5-8ebf-4481-79c6-08dba5c02f42
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 23:08:25.0011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsvpA3SJrDZmSIvoZfC9Z4TThsAhDnDDAkNVY3ZEx6YuWk++ahdFDGsIhNS4zE2iz06MDLSA0V9rU4V9ONmBCb/DZei7mFNNgvdr31YWJcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8144
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 8/25/2023 1:54 PM, Tony Luck wrote:
> On Fri, Aug 25, 2023 at 01:20:22PM -0700, Reinette Chatre wrote:
>> On 8/25/2023 12:44 PM, Luck, Tony wrote:
>>>>>> Alternatively, can user space just take a "load all resctrl modules
>>>>>> and see what sticks" (even modules of different architectures since
>>>>>> a user space may want to be generic) approach?
>>>>>
>>>>> This mostly works. Except for the cases where different modules access
>>>>> the same underlying hardware, so can't be loaded together.
>>>>>
>>>>> Examples:
>>>>>
>>>>> rdt_l3_cat vs. rdt_l3_cdp - user needs to decide whether they want CDP or not.
>>>>> But this is already true ... they have to decide whether to pass the "-o cdp" option
>>>>> to mount.
>>>>>
>>>>> rdt_l3_mba vs. rdt_l3_mba_MBps - does the user want to control memory bandwidth
>>>>> with percentages, or with MB/sec values. Again the user already has to make this
>>>>> decision when choosing mount options.
>>>>>
>>>>>
>>>>> Maybe the "What resctrl options does this machine support?" question would be
>>>>> best answered with a small utility?
>>>>
>>>> A user space utility or a kernel provided utility? If it is a user space utility
>>>> I think it would end up needing to duplicate what the kernel is required to do
>>>> to know if a particular feature is supported. It seems appropriate that this
>>>> could be a kernel utility that can share this existing information with user
>>>> space. resctrl already supports the interface for this via /sys/fs/resctrl/info.
>>>
>>> I was imagining a user space utility. Even though /proc/cpuinfo doesn't show
>>> all features, a utility has access to all the CPUID leaves that contain the
>>> details of each feature enumeration.
>>
>> For x86 that may work (in some scenarios, see later) for now but as I understand
>> Arm would need a different solution where I believe the information is obtained
>> via ACPI. I think it is unnecessary to require user space to have parsers for
>> CPUID and ACPI if that same information needs to be parsed by the kernel and
>> there already exists an interface with which the information is communicated
>> from kernel to user space. Also, just because information CPUID shows a feature
>> is supported by the hardware does not mean that the kernel has support for that
>> feature. This could be because of a feature mismatch between user space and
>> kernel, or even some features disabled for use via the, for example "rdt=!l3cat",
>> kernel parameter.
> 
> Agreed this is complex, and my initial resctrl2 proposal lacks
> functionality in this area.

Why is there a need to reinvent these parts?

>>>> fyi ... as with previous attempts to discuss this work I find it difficult
>>>> to discuss this work when you are selective about what you want to discuss/answer
>>>> and just wipe the rest. Through this I understand that I am not your target
>>>> audience.
>>>
>>> Not my intent. I value your input highly. I'm maybe too avid a follower of the
>>> "trim your replies" school of e-mail etiquette. I thought I'd covered the gist
>>> of your message.
>>>
>>> I'll try to be more thorough in responding in the future.
>>
>> Two items from my previous email remain open:
>>
>> First, why does making the code modular require everything to be loadable
>> modules?
>> I think that it is great that the code is modular. Ideally it will help to
>> support the other architectures. As you explain this modular design also
>> has the benefit that "modules" can be loaded and unloaded after resctrl mount.
>> Considering your example of MBA and MBA_MBps support ... if I understand
>> correctly with code being modular it enables changes from one to the other
>> after resctrl mount. User can start with MBA and then switch to MBA_MBps
>> without needing to unmount resctrl. What I do not understand is why does
>> the code being modular require everything to be modules? Why, for example,
>> could a user not interact with a resctrl file that enables the user to make
>> this switch from, for example, MBA to MBA_MBps? With this the existing
>> interfaces can remain to be respected, the existing mount parameters need
>> to remain anyway, while enabling future "more modular" usages.
> 
> Lots of advantages to modules:
> 1) Only load what you need.
> 	- saves memory
> 	- reduces potential attack surface
> 	- may avoid periodic timers (e.g. for MBM overflow and
> 	  for LLC occupancy "limbo" mode).
> 2) If there is a security fix, can be deployed without a reboot.
> 3) Isolation between different features. 
> 	- Makes development and testing simpler
>

From what I understand (1) and (3) are accomplished through things
being modular. To transition smoothly it may be required for all
currently supported features to be loaded by default, with the
option to unload afterwards by user space that understands new
modular interfaces.

(2) does not need a module for each resource and feature supported
by resctrl. A single resctrl module would accomplish this and I
would expect it to be something everybody would like. James also
mentioned it being on his significant to-do list.
 
> Sure some things like switching MBA to MBA_MBps mode by writing to
> a control file are theoretically possible. But they would be far more
> complex implementations with many possible oppurtunities for bugs.
> I think Vikas made a good choice to make this a mount option rather
> than selectable at run time.
> 
>> Second, copied from my previous email, what is the plan to deal with current
>> users that just mount resctrl and expect to learn from it what features are
>> supported?
> 
> Do such users exist? Resctrl is a sophisticated system management tool.
> I'd expect system administrators deploying it are well aware of the
> capabilities of the different types of systems in their data center.
> 
> But if I'm wrong, then I have to go back to figure out a way to
> expose this information in a better way than randomly running "modprobe"
> to see what sticks.

I always start with intel-cmt-cat but I believe that the burden would be
on you to convince all that existing user space would not be impacted
by this change. If I understand correctly this implementation would
result in mounting resctrl to have an empty schemata and no resources
in the info directory. Without knowledge about how to enable resources
the user space could be expected to interpret that as no resources enabled
on the system.

Reinette

