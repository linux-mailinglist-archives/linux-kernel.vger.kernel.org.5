Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35653797FDA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 02:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbjIHAvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 20:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjIHAvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 20:51:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622971BCD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 17:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694134269; x=1725670269;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=J69/l6PvcschWfdEDM0SxqH2NkHljQUBYIbENIY5JZM=;
  b=m7EwIZ9Lo62GZw3NLnRaYtFuhFRnseHvkikP+HmbW3fKa29YkL3Tys93
   821iAnHMi988PRU60dVW3S0GRS0kWcZuumOZ+fJr8XtQGVp05hg55NE4l
   fTfeuvU1ow+MkgD2Ak7NeRnpqwgAKSc9VwY5OLaRJPjdr6ut57NFubh9P
   iXWNpWKXxjvbpjmDo7J0+Zd66KEKqbZeRqhTfI/cPIB9qo/QOlO/YNy1g
   dA0xz61LVr+bNU01JNRga6aJTRa1HDn1VDIP0U1Ps+u9fvfPvGaJ+6lV1
   5n2jaP+klqfEAU8v1ePnrJN0ZIT/4obRPScxprq3W+Q4f/k9ITgh7eOre
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="374903531"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="374903531"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 17:51:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="857116583"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="857116583"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Sep 2023 17:51:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 17:51:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 17:51:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 17:51:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 7 Sep 2023 17:51:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwKYG/xowlBzjPyFsdz94KEYoAUPYViol1o9PfVtkDqlsRoNsyQfgzEMLZYYmE1KKz4UMZI5DRoXRyYcj7vjshVOG9rXf3lfUWFq4A0y1DryQcrWwpCQrPoarABL2HZzWk2b1rrohMNUexdu+wYz36YW4xH8ybyGb3XSFzB5/KzRbLWkbufsNnVLLsw7GVo3hw1FX5Lq29gJZxmmlKycvJyXI7sGjvPsoOagxzSAL6eEktLUhs9CZW8w99ZuaN3sMy9GhT6DzTZ4UhEuZPBJfMRerfBDr2SzvmzJG8y/apY+lgRThsuxF3AFO2iU1tM3CQ4QYqXkNkXBQiFo0breKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwfZfLb8OimxwRS81/3MCypvRIOB8FkuYmc3EQ5HgPs=;
 b=T8BP+wRLYMuqCYw2yeI2LhFOrSyOg11it13V5GAKU3TAfC+yoc3mlwIk8bB69Ujcv+0WQ2BLJF4Jv7HIsUa0Lpn3W23LUAonh1wEu+MRo1jZj5S/UIszjI2aqgKDOwlNH/YeoqkAj8iw7YGht8Dv8O7oMQjqRaKuJFhhObTNmzF9tPTvlmptTp/7hx6rLayfwoAt/9LynAB9et8aHekCxXaTlLNz88StoIaYBHmfDQADbHydIejpB6yjYyZbiNQfwt2oTd+2p6AkqhPpZ8F3NwgPEKHDLhj8918VmRVZrQFKYyNbFA3rPSiVHL1oNi/J3HfhN5mbPKVj2WDopVJdwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Fri, 8 Sep
 2023 00:51:05 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6%4]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 00:51:05 +0000
Message-ID: <32c1b340-065c-4f8f-9e73-da823defb640@intel.com>
Date:   Fri, 8 Sep 2023 08:50:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] kernel BUG in filemap_unaccount_folio
To:     syzbot <syzbot+17a207d226b8a5fb0fd9@syzkaller.appspotmail.com>,
        <akpm@linux-foundation.org>, <hughd@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <syzkaller-bugs@googlegroups.com>, <kraxel@redhat.com>,
        <sumit.semwal@linaro.org>, <christian.koenig@amd.com>
References: <000000000000be3c1a0604b53a1c@google.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <000000000000be3c1a0604b53a1c@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MN0PR11MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a18d9e-b598-40d9-536d-08dbb005ae64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cjNqky1F2Xq94ZTlJSo+nIFYymooBneUb+HW0OSKVyrXlHH5HLmHV7w5L+CyAkq2HYDwEuZNk4PqUf0PWBluJX0qKtL21RoUEiUZhq05p0v7ydSBTzxBC2cS5GPeWJeGvFax9ZfaRH2S1EY9k8kX5NGAasdTQ8KxmqkVfXzF4/mPIqTZQNWv7AZE5yOZKAB8hrRt0GwmddGD22ECRpzQg/5SfRV0PQqFBZZgIaYFkjbIrF+x/F+P16HLndwkeIV8SPrCF06t83haJaLXTDYYj/sAT/nTj+kA2nLLVPnVEPD61g1F09+6Eh7dwWY2mbpVlLCGxLcpd8pWQHhQywTwL/HfvYdDsuCqrsIG/tswoq81mkoZWMwFhWNX4prLTZwlVThwbdGAvCRXB8wnCMIw0JFoU1LbcLJW95wM7zQbVs9RM4v3Kp8+gYuvcVyaDpJ1Siqi/O74pnkKf9LqeTtKYWE1lFLh3gkqSOnanGmBe1gLAFBUEMzaQM9MOhHNB0tSXGLq3MYknKmCXTZUph/7ojLCB2EwvEFsGU0cL38fwUbRYhF/AJx9UefUEP2/M3ntwLQoNcapttcgj09M+/SW9KhvwfBjU0X/1SIGczrOerWHBnROetYOHZWupUjKIli2wvlUQUzLR62UZKvrZGOeX14Iqxp4l1Vvyzgd7C8bMzyo/ubXUFsh2AJGxdFK51MgCiG4YQ+KNCfUCoZo+TFaQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(346002)(376002)(186009)(1800799009)(451199024)(38100700002)(82960400001)(83380400001)(36756003)(2906002)(53546011)(316002)(66946007)(66476007)(6666004)(66556008)(6486002)(6506007)(6512007)(41300700001)(45080400002)(86362001)(8936002)(31696002)(31686004)(8676002)(478600001)(2616005)(26005)(966005)(5660300002)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUtUanM5OGd4YXVTREM1YnZQWkJMOGxVSExYNDJTVkF5ZExTd3FKL3ROb2VY?=
 =?utf-8?B?cFFoMVd1eVhuRC9EV0hlcjhUZ0NrNVh1ckx1bFRCMjkrUzJFS2lpU2hkdC92?=
 =?utf-8?B?eWNJdlkyVFRhVHNaNXZTOE15RXEycFhTZTdOZlNESFV0WVRsQU5VYnhIbjhs?=
 =?utf-8?B?WCt0Z0czUHJRdGl4MTBMVStDM0QrMTY0SEhkcU1NVlRLb1NkelpvaHFzbkhC?=
 =?utf-8?B?NFFhcGhyS2ttN1BWSXlzaTd6YUo5MXN1Z2RId1NJWWZxY0NVTHJIOFRHZE9M?=
 =?utf-8?B?L2VTeUc0SmltUzM5WkttRXNFMXdPMGp1eHREM2VjUnRZeUlEZ1hNSEdsNldO?=
 =?utf-8?B?N1pwMURnNEtvQkJudFNnM2EzMEh6NmFSQThKVnJub0lneFZJUTE5SzUzMU90?=
 =?utf-8?B?aDBLWFNDclVUOTdQc21MQjZ2cEwrSFR4b0w5aTVmU0hFOFh5dkpHbkdROVR0?=
 =?utf-8?B?cUE3ellXY0RTRHBjNkpwRGQvYXZ3RCtkOVlIQi9nYW1ETGgvdE9MeVFzMVkx?=
 =?utf-8?B?WFdVZStpWml4TSswcjVycm9aY2R5di9EZ25iTEZ4ZUNJZG8rMjBzenpCcm9z?=
 =?utf-8?B?ZkRuMHZXQkxUV3V0TGNBbDRKNlFNSzhIeEw1MERGN21uQWQ2T0wySEVzUWNV?=
 =?utf-8?B?U3hzMlhnM3NRd3c0Vk1UMG8xRmpRUFVVajlGOXUyOERCVXBQcHFOTGc1d0ZF?=
 =?utf-8?B?RnZPRk8yN0cxdktienJoYW41bWZtVVJMUWIyN1BBTFZCY0lFcmViUlJHVjU5?=
 =?utf-8?B?bnpTejdOdjVEM0I0bUo3ZmdoY3NDRlJYQjVlNjJmQUV3aklBSVZYQW9CQzdU?=
 =?utf-8?B?aFliME1WT0MwQnZRR1BLb1hHTzdjT05HbEVXTlliV1EzMEs5RDNYOXJ5OEd0?=
 =?utf-8?B?Q0FjTnltZ3hBNUV6NEUzdlQzR1orc2JiTk03MnZld1g5dGJ6Y3Nqb2dkNlZQ?=
 =?utf-8?B?eUFhSWFTZXJmRG01SWE3eWhKWDhuN24zaXZYMmhYekFka2d3ZWFBSUtUR3Fq?=
 =?utf-8?B?a0txMUlhZVFMT0Q0NFdNd0Z2aSswVklEdnVBQVVEUnNzVjNPaWcrdmNhZkd6?=
 =?utf-8?B?OTFxM1Q5cXBjU0VoZ2Y4SEMrR2ZNRkNHMXBaU1llZlpSTDBkV0M1c3hHbkhU?=
 =?utf-8?B?a3U3OVBrT3dDWE95MHF6RlNMVU9UQXl6WFpUTlJLSUJ6d3BxSGpsYWtlbkQw?=
 =?utf-8?B?NC9KYWZRL1lmU3hBY1ltbEhiVXA2WVJwTlJVeDErbjJyeUtxYzBnVnZJSUVL?=
 =?utf-8?B?QVFXNDM0dHBSRDJxTWFZU2FpQkNCeWJ0c0hLeHZHZzNlTHgzNUE4MXdwdFE4?=
 =?utf-8?B?cXpUVmhUSU81ZHpzMjdDVVJxSlB1UCtGdy8zTm1pbWNkYzY5bldkYzVaanZG?=
 =?utf-8?B?OEVjdHZHdXlkTEY4Ym9PYVRoNXovZGdtL1dXRkJpbElWZndXTmhTZWtINXhi?=
 =?utf-8?B?WGpoZ1RQTHlITmdOb1YvMVdJaFg4WkVPbnIxWU53Mm1NSFMwdDI3cjljeHB2?=
 =?utf-8?B?VGNlemFVaUZLVkE2K3F4bFFKRFVaT3IzcGpITXJ4eUozSGNnYUFxUkp1aFBj?=
 =?utf-8?B?bVY3Q3pVR3NtZlJGWi9UZlFkTTN1c0ZtZUM2ZlRDMkg5cG5tOTNOclpla0pM?=
 =?utf-8?B?U1JkMllrQUljUy9kMUlaUUVPMlpRS0tsbjRlN2JNYVNIR0dadktnNEdIWWhx?=
 =?utf-8?B?bjRKZjUxQUNrL2Q3R1p2UHVmR09NR3FWUXFvNmpONnU1d0lIcFZiUWlRVEpP?=
 =?utf-8?B?VTA4WE8xOVR6YnRVVlVOblhNTU5NN1d2V1p0MFZQcy9vbis4UkRneEhUQXdq?=
 =?utf-8?B?M2lJZjJmYWhiNUxoWUw5YlFYWGY4VmFUV3hvV0N0U3RLOU1uZkpyRHVUaVgw?=
 =?utf-8?B?SnFLQTg0TXJnT2tLVG56Z3VoY2JJR25Ea3Z0c3ZpYThPdVdBWkNyeFB6TFFo?=
 =?utf-8?B?Z2x6RElQTm5BekMrN21YdEF2SUJkcnljTzY4WjJrRVRockFleXpNNSswRnNG?=
 =?utf-8?B?K0Q4Y2pjRDVvOXpKS3YzVlNhOVE0K0l3S2VRMXJaTnp1akR2a1dPWUR6bCtL?=
 =?utf-8?B?WitDb1BiQ2Z0TVhYZEFlMnozMmYrOVBoTEhrdG9QNUlRVzFBb2puWDJ1ZDN6?=
 =?utf-8?Q?t1uMCEA5UF4a5/Nc/CNjwVo1o?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a18d9e-b598-40d9-536d-08dbb005ae64
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 00:51:05.3249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+zLTpwd1rU/2KOC2J2rDHRSYt/nxC1B7HfF42vgE1lg9CQr80KkvJpPHapOkMeXtiwiKB2TN2ZDUSaH5/UvVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6304
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add udmabuf maintainers.

On 9/7/2023 2:51 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    db906f0ca6bb Merge tag 'phy-for-6.6' of git://git.kernel.o..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=16cbb32fa80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3bd57a1ac08277b0
> dashboard link: https://syzkaller.appspot.com/bug?extid=17a207d226b8a5fb0fd9
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11609f38680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c1fc00680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/46394f3ca3eb/disk-db906f0c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/eeaa594bfd1f/vmlinux-db906f0c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5c8df8de79ec/bzImage-db906f0c.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+17a207d226b8a5fb0fd9@syzkaller.appspotmail.com

Operations from user space before kernel BUG hit:

[pid  5043] memfd_create("\x79\x10\x35\x25\xfa\x2c\x1f\x99\xa2\xc9\x8e\xcd\x5c\xfa\xf6\x12\x95\x5e\xdf\x54\xe2\x3d\x0e\x7e\x46\xcd\x73\xa3\xff\x89\x3e\x84\xa9\x86\x86\xa2\x46\x90\x93\x98\x4e\x05\x65\x92\x4a\x77\xce\x63\xce\x9f\x32\xc8\x02\x66\x03\x07\x6d\x08\xb4\x48\x8f\x9e\xa5\x16\x8f\x61\xff\xb2\x22\x8a\x15\x13\xa2\x17\x25\x21\x54\x8b\xa1\xb9\x2d\x13\xf9\x6f\x67\x95\x9d\x54\xef\xca\x68\x77\xf5\xff\x75\x7f\x75\xb8\x2a\xd3"..., MFD_ALLOW_SEALING) = 3
[pid  5043] ftruncate(3, 65535)         = 0
[pid  5043] fcntl(3, F_ADD_SEALS, F_SEAL_SEAL|F_SEAL_SHRINK|F_SEAL_GROW) = 0
[pid  5043] openat(AT_FDCWD, "/dev/udmabuf", O_RDWR) = 4
[pid  5043] ioctl(4, UDMABUF_CREATE, 0x20000000) = 5
[pid  5043] mmap(0x20667000, 16384, PROT_WRITE|PROT_EXEC|PROT_SEM|PROT_GROWSDOWN, MAP_SHARED|MAP_FIXED|MAP_POPULATE|MAP_STACK, 5, 0) = 0x20667000

The crash happens when test app tried to close the memfd.


It's like test app created udmabuf above memfd. But didn't boost memfd refcount.
And mmap with MAP_POPULATE make the underneath folios mapped.

When memfd is closed without munmap 0x20667000, the memfd refcount hit zero and
trigger evict() and hit
	VM_BUG_ON_FOLIO(folio_mapped(folio), folio);


Related test code:

  res = syscall(__NR_memfd_create, /*name=*/0x20000040ul, /*flags=*/2ul);
  if (res != -1)
    r[0] = res;
  syscall(__NR_ftruncate, /*fd=*/r[0], /*len=*/0xfffful);
  syscall(__NR_fcntl, /*fd=*/r[0], /*cmd=*/0x409ul, /*seals=*/7ul);
  memcpy((void*)0x200001c0, "/dev/udmabuf\000", 13);
  res = syscall(__NR_openat, /*fd=*/0xffffffffffffff9cul, /*file=*/0x200001c0ul,
                /*flags=*/2ul, 0);
  if (res != -1)
    r[1] = res;
  *(uint32_t*)0x20000000 = r[0];
  *(uint32_t*)0x20000004 = 0;
  *(uint64_t*)0x20000008 = 0;
  *(uint64_t*)0x20000010 = 0x8000;
  res = syscall(__NR_ioctl, /*fd=*/r[1], /*cmd=*/0x40187542,
                /*arg=*/0x20000000ul);
  if (res != -1)
    r[2] = res;
  syscall(__NR_mmap, /*addr=*/0x20667000ul, /*len=*/0x4000ul,
          /*prot=*/0x100000eul, /*flags=*/0x28011ul, /*fd=*/r[2],
          /*offset=*/0ul);
  close_fds();


Should memfd refcount increased when create udmabuf above it? Thanks. 

Regards
Yin, Fengwei

> 
>  search_binary_handler fs/exec.c:1739 [inline]
>  exec_binprm fs/exec.c:1781 [inline]
>  bprm_execve fs/exec.c:1856 [inline]
>  bprm_execve+0x80a/0x1a50 fs/exec.c:1812
>  do_execveat_common.isra.0+0x5d3/0x740 fs/exec.c:1964
>  do_execve fs/exec.c:2038 [inline]
>  __do_sys_execve fs/exec.c:2114 [inline]
>  __se_sys_execve fs/exec.c:2109 [inline]
>  __x64_sys_execve+0x8c/0xb0 fs/exec.c:2109
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> ------------[ cut here ]------------
> kernel BUG at mm/filemap.c:158!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 5043 Comm: syz-executor729 Not tainted 6.5.0-syzkaller-11275-gdb906f0ca6bb #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> RIP: 0010:filemap_unaccount_folio+0x62e/0x870 mm/filemap.c:158
> Code: 0f 85 68 01 00 00 8b 6b 5c 31 ff 89 ee e8 6a 3e d2 ff 85 ed 7e 16 e8 f1 42 d2 ff 48 c7 c6 c0 3b 97 8a 48 89 df e8 a2 58 10 00 <0f> 0b e8 db 42 d2 ff 48 8d 6b 58 be 04 00 00 00 48 89 ef e8 0a 0d
> RSP: 0018:ffffc900039ef828 EFLAGS: 00010093
> RAX: 0000000000000000 RBX: ffffea0001cfe400 RCX: 0000000000000000
> RDX: ffff88807e171dc0 RSI: ffffffff81b559ae RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1d9be7a
> R10: ffffffff8ecdf3d7 R11: 0000000000000001 R12: ffff8880258003b8
> R13: ffffea0001cfe400 R14: ffffea0001cfe418 R15: ffffea0001cfe420
> FS:  0000555556b42380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000005fdeb8 CR3: 000000007a443000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __filemap_remove_folio+0x110/0x820 mm/filemap.c:227
>  filemap_remove_folio+0xca/0x210 mm/filemap.c:260
>  truncate_inode_folio+0x49/0x70 mm/truncate.c:195
>  shmem_undo_range+0x365/0x1040 mm/shmem.c:1018
>  shmem_truncate_range mm/shmem.c:1114 [inline]
>  shmem_evict_inode+0x392/0xb50 mm/shmem.c:1243
>  evict+0x2ed/0x6b0 fs/inode.c:664
>  iput_final fs/inode.c:1775 [inline]
>  iput.part.0+0x55e/0x7a0 fs/inode.c:1801
>  iput+0x5c/0x80 fs/inode.c:1791
>  dentry_unlink_inode+0x292/0x430 fs/dcache.c:401
>  __dentry_kill+0x3b8/0x640 fs/dcache.c:607
>  dentry_kill fs/dcache.c:733 [inline]
>  dput+0x8dd/0xfd0 fs/dcache.c:913
>  __fput+0x536/0xa70 fs/file_table.c:392
>  __fput_sync+0x47/0x50 fs/file_table.c:465
>  __do_sys_close fs/open.c:1572 [inline]
>  __se_sys_close fs/open.c:1557 [inline]
>  __x64_sys_close+0x87/0xf0 fs/open.c:1557
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f6700c6aa90
> Code: ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 80 3d f1 85 07 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
> RSP: 002b:00007ffd27935ca8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f6700c6aa90
> RDX: 0000000000000000 RSI: 0000000000004000 RDI: 0000000000000003
> RBP: 00007ffd27935cc0 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000028011 R11: 0000000000000202 R12: 00007f6700cde5f0
> R13: 00007ffd27935ea8 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:filemap_unaccount_folio+0x62e/0x870 mm/filemap.c:158
> Code: 0f 85 68 01 00 00 8b 6b 5c 31 ff 89 ee e8 6a 3e d2 ff 85 ed 7e 16 e8 f1 42 d2 ff 48 c7 c6 c0 3b 97 8a 48 89 df e8 a2 58 10 00 <0f> 0b e8 db 42 d2 ff 48 8d 6b 58 be 04 00 00 00 48 89 ef e8 0a 0d
> RSP: 0018:ffffc900039ef828 EFLAGS: 00010093
> RAX: 0000000000000000 RBX: ffffea0001cfe400 RCX: 0000000000000000
> RDX: ffff88807e171dc0 RSI: ffffffff81b559ae RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1d9be7a
> R10: ffffffff8ecdf3d7 R11: 0000000000000001 R12: ffff8880258003b8
> R13: ffffea0001cfe400 R14: ffffea0001cfe418 R15: ffffea0001cfe420
> FS:  0000555556b42380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000005fdeb8 CR3: 000000007a443000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 
