Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB577641FB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 00:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGZWPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 18:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjGZWPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:15:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7284270D;
        Wed, 26 Jul 2023 15:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690409716; x=1721945716;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M6n71VtOsOA6ewIDV2LArdb0YD/gC8Sm/I2jSBl4aOM=;
  b=LBk7DebV9M9/BmuaqauO0RkvrYUSFSANbBYJ7iXXbLK/1vUQwIYG2uKv
   ONluG9Rd6D6fQu76jvVWTt/LDsNT5eLVydA+cCiW9OmKeSjgRDbsID6B4
   g7F8tfn8Z1JvRvuyjUv/fHSTAPzHQQJ2mS0P09mMohBGIx4sytIvWDH1Y
   qSbKbPdBkJGzuKp3FSpO2djW5GdXVnkLDidwgfuMz0MvOoQzS3Ve7411V
   7Hqj39a0eFiQnAhTp1qrMX5lG31RtB+iF46ymAmVoEFmUhkO6j3ClgeDm
   GlvtuJX/0ctOeeEyp+H4EzPF7RPrT5xNAyHZljBw3K7Tsn+Cmc7Yi1eWY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="358141623"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="358141623"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 15:15:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="850618033"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="850618033"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2023 15:15:15 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 15:15:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 15:15:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 15:15:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8eghq/ozJ7Ruf4lx9vNYowNLKokrpp5iwD+jq9TSnKFH/3e7+9niFGHhSZ/i4FSITZnixa+kk94znxCdBTTKtvhBo2jwlvBNGSEmNOPa6roOAHHAK2Hi0DWHawh+dkASiCDSmMaTnpCu3EfiTeaQGAGlF7BshdDtMo7xk8Ona7W7YQGfNomB0JUxtG0IDuUm3BKnzl2d06IZfqUWYsPCr6i2MFS9ho5+z/YQwOhVx1n8vVLavcqZpeVlK2Yd5x4YO1hNjU3OpmdpD1KQU5ZJt68hOk7KDokccrxLWQTlbtxIJg9/h4re3yUm7Mdwr8zJb/iGrkJxtHhMTMOlA0SGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/mYUzoBUF96FE1elI51YqEEbWknK6TC5TKbW1zLGXU=;
 b=WU8ueDHvPdD3m7eWmGhcHMpKgXwK3iXjPJEWdcMtKwJWfNtdUAnR5UsIobbYWjqnUVXMZvOvo0Q78MWMAZjDoPS4li7VXWgtneYBbVF+ifSfEHXFbM6x4c6dZyTWoNSqNoLisj5RZDV9J65UXoxi6w/1IkJWPO24tCJjcXPhwj8mWM4cgh5v4C2Zu/xGL0nOf765u/lqyHw5AhRw7lm6Ghlwj8YX+2dvw9T1bkxoRfPEjieDgwBpLQIm9BGeeoG8UBkNhLcClCg0fSI0vfWxT7PbHjKPnHx02zlicWjOChgoYl/nHb3L2OhUIY7lESQDgHcv0UsTWOLec7htTi+JbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MW3PR11MB4665.namprd11.prod.outlook.com (2603:10b6:303:5d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 22:15:13 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2%2]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 22:15:12 +0000
Message-ID: <545cff6e-09ad-afc3-5d5f-bf5a435885b9@intel.com>
Date:   Wed, 26 Jul 2023 15:15:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch 00/29] x86/cpu: Rework the topology evaluation
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
        <linux-scsi@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
References: <20230724155329.474037902@linutronix.de>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230724155329.474037902@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0136.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::21) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MW3PR11MB4665:EE_
X-MS-Office365-Filtering-Correlation-Id: 879cbdbc-1951-4727-2614-08db8e25c83e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y6rOKL0WFanDzwDTyCxvenpBZR0OAJX+j8CML82SXLhQ0zmXDOmtAWY7iV3MKYLWjG5m8FYzLxM0Rs2QKkSc+zsP0Kk4zbcHxTXGisSnLbqNUGR/BFcMEToTo7Oey+gDjD2eYEu76oQX/caerGH9RF44podONbAOSaW1B3piYA4vQBNun+qvdqFPl0KUFtskPRtxkrX9czOfRhtlSiRgWTnxDZR7F9PioVxoUCKKzFf395g1ht/WngEiKbdYvoO55M640yKDd46uermeP+Wfa9t8EcBu+qlR8bd559wdhR5Qg5yzZVJYDxVOIlZJb+WNEeWdWg13++jdeXlvFScDr+rbJ1ooKsPcff/PtU/pkc7SQxz5DCUqHNZpy7DIHg6NJ+V/4p9ghN2BpJlVoDvXY/V0NOHCO2UViiRsodsWzTm9i0G+h/dawn6AnvjkgBM3sJbO3vT1H3Ajs2BX5IjiABGPAcmvwAjMDwmT2IyAVfi+vUF1zsKRRDYMNJ8PZRWzZydgpuL9RRaK9l/PqO8eaiecPz3Dguu29N0Gb864ii8FLoZHzbGPUn4/ZZ3SdjZXg1/lHyIL5o6+kkNjMltY5907wfjjgKMmphoV8GQDzTNHLSbRjkU08fOERH4Pf62SWuo3Ea6kLWogIZ1ZI9P5UQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199021)(316002)(53546011)(6506007)(26005)(8936002)(41300700001)(8676002)(54906003)(110136005)(82960400001)(478600001)(966005)(6512007)(66556008)(66946007)(66476007)(4326008)(6486002)(38100700002)(36756003)(2616005)(2906002)(83380400001)(86362001)(31696002)(31686004)(44832011)(7416002)(186003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cktXdENhSUVzbDdJWm9BZEdvejRFZUNLQ2tBYXBvbUdTY0NCMUE0NkRwYjFq?=
 =?utf-8?B?RHZjRUMwL0JNcmZXVEVQMHpBM0syTE4xL3VsZHowaU5PTzVFMW5qcUVBQi9B?=
 =?utf-8?B?NDFBUU1Mc1VOWWU3RnluNWlYMEgzRXd6NW13ZWcwU21jUFBvTWtIZHNGbWVP?=
 =?utf-8?B?dW9FbGY2RUhLUmIySWxha013VUF5MEpHSGtoOUN1L3QyeVFSZ1orcHU1Nkt4?=
 =?utf-8?B?NnlUOEttd2NwakhBdGRqWlVHOTNYTENlVTlJYmRKRTQ2NlZNNzloa3ZzRUlI?=
 =?utf-8?B?MUVScVoveEVPeWF6Tzc2dXlPZG1VUm41OWxyMjNsUmJSMDQ1enZ0elEwWXRy?=
 =?utf-8?B?UTk1Qm05eXJCY0NSbzhMdEtuT0htNlNxWG8yYnNKWVRWWW11UStGWDVXRHNE?=
 =?utf-8?B?TWpiWGdRM242ZytxSUlNRHErRnF1dTRWU2xFRExSQXpDNnB6RFRzbUhVNmVu?=
 =?utf-8?B?d3BQMGNSVzdwU205RFVQZk96NHdwbjFCZitXLy82aFhTM0tvRmRoZGFmc0U3?=
 =?utf-8?B?cUlsZGZ6b0JCd0d6bk5VaGxSMVZ3Mzg2c3ZMYjk0c0FONFlFS2xXVE9OR3R1?=
 =?utf-8?B?cUtvZFl4WWZ2VTV0STNnbmhvQVJBUXVIOFRHQjdDYWpBSFduWEx1b2FtSS9C?=
 =?utf-8?B?R05HOXQ1dk9QVWlkek4zRDFkSHRFN3Y3Nm1TaFltb3ZsZXA5MXFnM1kwODNT?=
 =?utf-8?B?ZHEyOXlzMmdvRWpZSWwreG83WmVxTjE5K25ucXlRK2ZvWHZ6dFdlazM5MUd1?=
 =?utf-8?B?b3FVM1hKczljYW5KVE92UXh0TjZNNXY1SDd4YVBpUXRxYVVHUUlWRGpPdmtv?=
 =?utf-8?B?MnR1N0pwTkE2NnZKSlRCRHBXaVFWbTZnaVR0NVVTQzhqTEhHaFE4N2pyazlk?=
 =?utf-8?B?MkI0dTd4czBicTNWK0IwalI2WE1WejFuV0ZnenJVclJtN3hnUVNqSDlWb203?=
 =?utf-8?B?OHJ6WW5PY1NnNUl2U3o1RCttSEhSdTM5K2ZDczQ1TVhLM3lYNXFabFliM3d3?=
 =?utf-8?B?NXFJMVVhVGs3SWlXU085cHNQU3oyV2p5MVgrQmFXTkVOb2k3NCtQamlXM01x?=
 =?utf-8?B?UXo2RDZsb01mOXNsYnNQVVFlK1NhbXVGeFppbHhpTENFUW1oSmE0N0xtM3hI?=
 =?utf-8?B?NWhTbi9PZkdqaVQ2N0NyV3FETXdmc1dqVU5yTG1vRnN5NVlSUSt0M0VTMUdJ?=
 =?utf-8?B?M2dYNllYOFBTR2V6WXBMMWxvRjJLRkwrZ3JQUVpJbHdjVzY2dVh4RkJnbThq?=
 =?utf-8?B?ZW5jdSt1S1ZQNFN5VlBnNFU5anZ0Z2RxK3l0VlVoL0dnU1NueXVyc2hCOHdS?=
 =?utf-8?B?YjNmWERweThhclVTMjdKT0MzRWliaXUvb3pxNTFYOXZMcDRlVmZFVmF1K0NP?=
 =?utf-8?B?Z1ZwTHZIQzZ5eXFSd2ZLNW04Q0Iyck16SXc2Y254Mk5SSEY0SzhXYzd2bUVN?=
 =?utf-8?B?eFVkU21yQk1qTzdXa05JMHF3ZVNobC85bGZVVnNYVjA4MDh3V2NHV1lMR0RM?=
 =?utf-8?B?WURyQVd1Nm9CNlZLUW95QktPVDRVQ3c0bnM4a3RVVDA0K2o3U1BuSXpWWlNo?=
 =?utf-8?B?dUd5cDcxTi84RDFFRFl0aVY4ZDVxaXdjUTdqcTl6UzhiRTNkWUkwYjFXTXVs?=
 =?utf-8?B?UlZLZDcwdTZKMzErMzhoMkFlVWpzU3k3WHlPL0VCQXdSeERlbTduMWNObW5O?=
 =?utf-8?B?T01lRVhkQXhzdlYwYUE0Lzh4ZjhmS0NQd3dieEZQdW1EZTRrTmdtMlphdHd3?=
 =?utf-8?B?d2EvU2xXRHBKQ3RYbGh3eFRERkw2Y1pNNzhObS9GSGFFeWx5TGV0UXo1azdi?=
 =?utf-8?B?dVcwZUR6WXJxUW9vd3pISGVrVHVING52aHhhc0l3bHA4aTY2eXl1ZkZxR1Ri?=
 =?utf-8?B?SzV5YS8xL003Ymg0dmtUNjFYZGRtUTNzbkI3bVFZdjVMTzdXNmpBUTM5MTdQ?=
 =?utf-8?B?dnJGMTROVGo4RGt5RTdJM2ExZ0l4L1dYTFVFK1JXS0EwQmoxWFdSYmU1dlFm?=
 =?utf-8?B?T0VwVnpMTHJnYittdElQRC8xZ2lXbmVmd05DVWdFZVdSTE5QQ1F2L05lUU5q?=
 =?utf-8?B?MWNod1p5MDVHcmk0ZTl6WE9jNDk0clZZM01UVmF0aExDY0dMT1BQZEttSWp6?=
 =?utf-8?Q?LT90mv1SUn1OMoCaKr4pWozZj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 879cbdbc-1951-4727-2614-08db8e25c83e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 22:15:12.9050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTG500hWAyReW7AvySsOl5RvsRD6nb6yeN2WG+CGW/uy3LsMXsstQrCSm9QXca40aGqGNlRdL1hKopHaZwDcpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4665
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

On 7/24/2023 10:43 AM, Thomas Gleixner wrote:
> The series is based on the APIC cleanup series:
> 
>   https://lore.kernel.org/lkml/20230724131206.500814398@linutronix.de
> 
> and also available on top of that from git:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpuid-v1
> 

The series boots fine on an old Sandy Bridge 2S system. There is a print
from topology_update_die_map() which is missing from dmesg but it seems
mostly harmless.

> [    0.085686] smpboot: x86: Booting SMP configuration:> [    0.085690] .... node  #0, CPUs:          #1   #2   #3   #4   #5
#6   #7   #8   #9
> [    0.089253] .... node  #1, CPUs:    #10  #11  #12  #13  #14  #15  #16  #17  #18  #19
> [    0.000000] smpboot: CPU 10 Converting physical 0 to logical die 1

 ^^ The "Converting physical..." line doesn't show up with the patches
applied.

> [    0.134035] .... node  #0, CPUs:    #20  #21  #22  #23  #24  #25  #26  #27  #28  #29
> [    0.140239] .... node  #1, CPUs:    #30  #31  #32  #33  #34  #35  #36  #37  #38  #39

Please let me know if you need more information.

Tested-by: Sohil Mehta <sohil.mehta@intel.com>
