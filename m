Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E3F7AA563
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjIUW6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjIUW61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:58:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9363BCD0;
        Thu, 21 Sep 2023 15:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695337076; x=1726873076;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9ad5h9dx6efSTvZyXVYGKevppYDd+EzLyM46eQ3js2c=;
  b=IFF+yAgZ8uJAUOusjJ8LibHsdz3IO+wWx/tgQWoJeZ1p9a9GMFPWylLY
   dmcaE1dwtmcklCGRjE7AFTnyDpAKGkqOPcnAyXCLNPEnIFpNPDLbSclH3
   WC9nksE0xR1Akoso+k0aHKeU4Z4oK2JYect+K15e7acbrbGEcPlZEJqaN
   vuhGFr38OU6tMhQwPiEdQqUEoldCM4V8O13Zow+yUU3JIraxAEd1KjDXA
   UBk9jwoD4D5d+ss0hm4WWeIMkdess1fbLPmCoKt5swWdCtVt+WjKBtHoT
   5zRo2nstGRwaDXQVIOmDnRmtfYtThBGuhTHO4SPhx5vEk0rQ8hD/WJmnw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="384526942"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="384526942"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 15:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="890575668"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="890575668"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 15:56:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 15:57:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 15:57:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 15:57:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTXIXhCUpong+J44shkTwYT41fDb+IQqBhxJgUcVwsB12V4wNZZKDgPo6oth1OKP+ArMJgckFLfuCPM/ImP70f0gNLGGz/tTa/8XPU9niCvm0I2cCkUUMqgIG2QE4samZYPG2tyrwuH2VFCgHecHg2xFMPZcnLa5jpkhguB6fDf8uSEmoTjt5ESHxjl0RlNbVcaaVRiCMe1I5M55YX7xYnCoR8HgfIuqeMtvbP3P1U7v/COLy6s1lq+/R6hRMrqgnoqJBq5/84TukR5WtP1UyUcOppGg39m6aWnHwGLyecVdFD11B6dr0AiOLcgDRaG8RWKzTsPCQfQAgXcP7q+vBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZcNg7vsQ1Mmy0PLJcARl1ZURKRvMQ/smqVMdFaEC2Q=;
 b=BGIKzjn38AFjwlRiwAyc40AeR4W0P/BO/9yBuo5m7WWInFOHoFQfKrJv420wggQAd4Abpukp6r2PwmtR36JYolqGOKnlwIgOdTII2+NtLqm8lqGM9nDjcI85aVQaIqa+8g/rx/2Apf8/+xGtr8JB11+hHfiLdmfpai1arh0ZPtBIa7o3jo7n4kJNdHt6dip9EpIATKTXHSIFjAGjJjYLPNb4fZ8bJ+4OOKcZ9bMlwk1Bi+MZzsbuZWXEODWbhIcQhvWcpG6O+9BACsWRz6x/AeFwK0qQ7X/Ctuu/UbTR/NcuZykKIudLCCu2m+3hV+lnrFJVBd+kOrm4/IYhOo7diw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CY8PR11MB6988.namprd11.prod.outlook.com (2603:10b6:930:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Thu, 21 Sep
 2023 22:57:30 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 22:57:30 +0000
Message-ID: <e14ac1d0-ef8e-74ab-0616-f3203580b371@intel.com>
Date:   Thu, 21 Sep 2023 15:57:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH 6/7] cxl/memdev: Fix whitespace error/warnings
To:     Jeongtae Park <jtp.park@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        "Wonjae Lee" <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        "Jeongtae Park" <jeongtae.park@gmail.com>
References: <20230921025110.3717583-1-jtp.park@samsung.com>
 <CGME20230921024832epcas2p24325cdfdb6fbbcf489ea3d442258e86b@epcas2p2.samsung.com>
 <20230921025110.3717583-7-jtp.park@samsung.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230921025110.3717583-7-jtp.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0052.namprd17.prod.outlook.com
 (2603:10b6:a03:167::29) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CY8PR11MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: b5bb47a0-5346-4e8d-1b62-08dbbaf621f3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1cvXLfFUK1m6N0rooUMVVMpYAZ4SNTJYfIf93EzwuPICZuUE6ueKNIZxX1rIrSIbTrEVGMkhp+hq8TZGKafxkvukblC2Cb7BU/l3aADwnvD1X367ZryH9zVysaWHPB4BCxTlRlcICHToNBSjlLVQ00MLEVUuqZE1Wj2uUhlACRHfnpBjsWomzyLd2zu5mr2QmpvTV10ziJhp5SQAoi0jNsq5f7Fw5ViaHwKb8WdAgRZpdsfFUQB8Owc9LYshWr+KoZ4shyKodBoG0nSRdVZLro3P5HuB+MeqDNOPCbC8sa2uI+/uKkeykbbufNmpThGi5QgDzgzPNTFZ3M16ajMAEjT7foHMLG/pMdOUf+jcsrNipUQBhW/OsT5cacDANDbbAhSGTyiK5R5tjgZLxqU3j3JweIFHCKggUd6n2S1qU7rCF+GsA++Xohr6+PXSw0FTcqb4oRwaha0tDOhAU1TL20geUYNJWA7lmZsEqe3PDnJRpSit80Tw591RGQUE4tGGBMBHgG6KSwbf22yI9xVgR5ZIK7Xv0rBdgctLFszj5T7zACYDMAc/JU5NkNWx5Dp3s5lUqHra9ZtemWy5LgNj44eoXJL8dVoAvakT6zTn4rHqdh3+qgooMadlSRlVyeVYLmniNuHkICYWSTLd0R/Hpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(39860400002)(136003)(1800799009)(186009)(451199024)(26005)(8936002)(2616005)(82960400001)(8676002)(4326008)(7416002)(83380400001)(2906002)(31696002)(36756003)(44832011)(86362001)(53546011)(6506007)(6486002)(6666004)(478600001)(5660300002)(316002)(54906003)(6512007)(41300700001)(66946007)(31686004)(110136005)(38100700002)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czkzNlV2Qy9rRnROdFNWRzhoblpqcE55cERyWkxqRy9NYldmTUhJQnBka0tO?=
 =?utf-8?B?ZE1RaGJQR0RVWEs0SXRWRlErMzVxUy9SckhzdGk4SklaTU1WTi8wQStHK3NN?=
 =?utf-8?B?N2praktDWjU3TjhjaGVZdWNnZEtzeW8wZ0c2ZEpBY2l5K2pGeEdSd21WQU1z?=
 =?utf-8?B?bXlicnRLeVZiVzlIQkJ2dG4reWNFSTh4SnQvUm03cUMyVTE5M2ZwcytzWHA0?=
 =?utf-8?B?QnZyUG9oWWgramxRSWc5MnpMR0oyZFlRMjBTRS9weGlzTXJBVm9TRjdRcHow?=
 =?utf-8?B?ZUEwOUJFbHhhMExPeG9XWGFzYjhUMXpCaU5DRFpGNHlyRnRYYkdxcW9ZMmR2?=
 =?utf-8?B?d21jT1ZEdDBKdmNmUWF3VENIU041S05QVVRmbm1NVXRKU2VsK1FGQUhPdjBS?=
 =?utf-8?B?cHBNVEgwU3laMlBnVkcxUFNUdmtsRm1qeEdxVHRFRTF6V2w4MTJQdnlLUld1?=
 =?utf-8?B?NGZ0anFtbjFwcXBQeDVsaUxVNEovYU15Q1d4bmdQbDk4WElwQml0TmpKRXZ3?=
 =?utf-8?B?MTlNRHRRa2VHMXRrdlI1L1ZCeExLaFlQS1ZhL3VXMkpyUUFyZVNheVY1Mldw?=
 =?utf-8?B?ODh0bjhsZ3BZNjJlZ2hSaGxVWHBEUWtXdDIrUFVjNHhKYks4M2tVZ0FNbTE3?=
 =?utf-8?B?d1g0VEVUSlRaZDJMU1lsNDZTZzFia2tDZjFKZXkydGlhZGlwcXN0WStqemRq?=
 =?utf-8?B?cnE2RnhVUStkVGN1M09jbjRQdm1PamUzZTFVejVwTVJyMjNxVkNWS3FwanEy?=
 =?utf-8?B?S1MwMUg5S0d5TGc3bWJmbUovMHZGT1pMRWNVNFAvajdwVUhUZCtMcVJ2cnRW?=
 =?utf-8?B?YmhXSDFyMlhvQU03RksrL3d3aUcyS2orVlR3Z3ZHVENCc0xDNEdiQ2Q1UzNj?=
 =?utf-8?B?aFhYSnAxdVh4UENCMmZld1JjSlpHbGgvMDhKZlpEcU1HckVKR3ZWc0prYmlr?=
 =?utf-8?B?SG9yQ1hFN3A1TDJzQVNwZDlpNngvNUd6V1lFSHlFOEoxOEFDOU5HZFFoNGl6?=
 =?utf-8?B?Yk1oRDdXdkc0SkxzYjBEb05QdURiUTN0bkNRQ3UydXAzbFc1aW0rY1o2SmZn?=
 =?utf-8?B?TWc3Q2NqODdzdTQvbU9aZXFPZDdmaW9uVUsvQkJuOU1WMkxEbXhqY1hTMDdN?=
 =?utf-8?B?S3BKeFAyU3o5NURUd0dWZmxIWW4wQ2VIdDhEZ2Q3Uis4LzM2NTNwVWU2Vm5x?=
 =?utf-8?B?UXpHZWF2TDFQaUw4V2U1YXY4TTlvTExkbmIxcjNkZ3ZBUUV5eGMzNndrVWNY?=
 =?utf-8?B?KzNlbzlPRDBuYlFqdk5GcU1oMFpIQWRkRjZRYmhyZ3BRUUU1UkI4bkt4Zk1w?=
 =?utf-8?B?L2M1U053bUV2WDJnaXZGS1ErU2U3V2lCSnVrRHBQY1NkRm5HOTBQbkptM0NX?=
 =?utf-8?B?cnd2d0VUNTJON3dBazlYdVFpbmkxc1pFaU5xOEZLK1I2akdoZnBKMWNzWWpj?=
 =?utf-8?B?TElLQU9ITHgrc292UmhFanFFeUIzOVV4WGJDMU11RTFla0g1TkNCNzg3aFhZ?=
 =?utf-8?B?c3hmdFY3MjZjWnNYUCtLS1FySDJHVml6NmhndmpSMFZGRzNsL0FUY3dIMi9P?=
 =?utf-8?B?MTZVbmpvaHRsNWtDTlh3RnQ1OUZCbmpvRFNIL1lVU3FUQklaazVpOFljVnRO?=
 =?utf-8?B?cUZ4N0EyclhBVno2eWtqeEp4MGpvRkhnbUo0YWhOd1NHcnRlTEdTdjRzY0h6?=
 =?utf-8?B?QzB5UDJqSERJcm1HVkZ3UEhrZkJTMUN2cHI5dGJIWU5MMFFkUlhVSzJpRk1X?=
 =?utf-8?B?bTdVYmtMa25wZi9WenJOQUU1emhOVzR5R2pmMEh2dFBVLzNJWW5kajZJU0M4?=
 =?utf-8?B?bmJvc2c0RTB1Y1c5djducUV4ZmI0bkdoTWM2dlVRQ2xZT1lVd1U5dDI5S1B1?=
 =?utf-8?B?S29jTVgrSlRWbUk1VkNXRENxQVBMUWpOVCt1bEZQODhKbHZmSkFSeU41S1pL?=
 =?utf-8?B?MFFOZjduY080RWIwOTFtOE5ncGIvc2p6d2UvaUFyOVlaS0E1Sktza1pWVzI3?=
 =?utf-8?B?ajlyWk1tbFViZ1d5NWN6N1dlUGprMkU4cStST25PZ0U5MlhUUlUrWXF5MUpl?=
 =?utf-8?B?N2tMcHJVYWw5a05LakdXTGtLbEY2ZTc0NkZxUjBNQkZ3UnRQWThNY2NBNlJn?=
 =?utf-8?Q?ft2ue6+X0BmFija5ijoqH9SxL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5bb47a0-5346-4e8d-1b62-08dbbaf621f3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 22:57:29.9616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTnQCsCjzpQoLDYPxKKzZYQyvKhD6ZPK42wX8/OhEpuxUQ/CU6GhUSYD+qQrNebOY1VCk1n7D5Y30gjywOH+Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6988
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/23 19:51, Jeongtae Park wrote:
> ERROR: code indent should use tabs where possible
> WARNING: please, no spaces at the start of a line
> 
> Signed-off-by: Jeongtae Park <jtp.park@samsung.com>

two different issues?

> ---
>  drivers/cxl/core/memdev.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f99e7ec3cc40..ce67df163452 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -935,11 +935,11 @@ static void cxl_fw_cancel(struct fw_upload *fwl)
>  }
>  
>  static const struct fw_upload_ops cxl_memdev_fw_ops = {
> -        .prepare = cxl_fw_prepare,
> -        .write = cxl_fw_write,
> -        .poll_complete = cxl_fw_poll_complete,
> -        .cancel = cxl_fw_cancel,
> -        .cleanup = cxl_fw_cleanup,
> +	.prepare = cxl_fw_prepare,
> +	.write = cxl_fw_write,
> +	.poll_complete = cxl_fw_poll_complete,
> +	.cancel = cxl_fw_cancel,
> +	.cleanup = cxl_fw_cleanup,
>  };
>  
>  static void devm_cxl_remove_fw_upload(void *fwl)
> @@ -1010,7 +1010,7 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
>  	}
>  
>  	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
> - }
> +}
>  
>  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  {
