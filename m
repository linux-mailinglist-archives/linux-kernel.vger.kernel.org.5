Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D23D7AA55E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjIUW4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjIUW4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:56:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39147CFE;
        Thu, 21 Sep 2023 15:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695336964; x=1726872964;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d2+wAnWRQUb0UjpEANP3EH49RKhvoQfArphRJcEXx9s=;
  b=R3hu/2ixVm2Rsv3rI5635Bpjt6IkTDYFexhzALN83QaZIiJVufDqiLUU
   oZXgV3e/sFRyyGPOX3fyXbz9/soKa5rCHkbvDrgJ3bA2aUCbCxEPVy3Fh
   lPZmHYZjcXSJwquUOpic/w3zKyXUHfSJ4KbZDzxFR23/kSdQpORgQmc+m
   CxIRJN14QA4bNgqnRf/3DraKLIM3P8UMXIdiI2dTdQaV04LOjSIRMsJSq
   M4FMPv8gsLiObxNBzRujFtzjKSCiib3YC8k8mDGOrnAvLQoqPK53oLWlZ
   ChLfn/Zqr8IaCgUohg0t2+Bn3CXHXD8NHOyphoOq7yNd/mhtTnH4aFwxE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="466990814"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="466990814"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 15:56:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="994290914"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="994290914"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 15:56:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 15:56:03 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 15:56:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 15:56:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 15:56:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bd1V1ihAbXqFQg4+h8ciMex7WldxdoRQFtyn9rQIbcJPmVRb5HEpqQfutf5FJtxZnENuT4w5i3r9YPVPiDXHArRi003E1W2ih0A1Povf0lnnuVcoR+XcSnm4pKiDK3f48hDzPiazcBaJduIItDGXG5pgquRR9TWIotBcA5+bplvPn834/bfCh/Cbvu0cxLsfTd6Cx+Pf4qZe6G81Xq0E69g/8aycEGfTUDeEHEcvYsn2al20swPNv68E7LDo1OXv4Y00WSvQNaaDuE5SVtbM1H96sThOln5SvTUGn3JTVDyjAv/MqVvAgMo7z2i1BnzshWHe/eptL8aqDm4V+ncsjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/BbcJN/Wzvyv5yslqsbf+L/MNFiCWgMK0L+own99RM=;
 b=SabW+pR9lXMfvrr8+cD03/Ge/zqlcCM+CCJu8wEZD9C1485f7FI4d0FZTMyJtQfowGKdDe5G5kuhw5+kROU2uXj8GU97RABbBi9a0mZRnkLnmxY0f6XP4HSH6ldclYWHoFafrlaea9S3zrFr1x8w0engPBqZzLUHmyx/TRrLYqj1wefb7YRF8OSGuQnPUoulsGH5RD+jHiu/5aAyACljyEC07j4l4wRyylUBN11QOOtdbIKV/T1fznAZ+e1hKy4TqnvZ5Dic5qCS4MD3yMKaiuH9J9OiLCSuvlaz/tKKG/SXBoogbuYijyi+36zBnetF3D/29c16tzmqAE4dk6LOWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA1PR11MB8325.namprd11.prod.outlook.com (2603:10b6:806:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Thu, 21 Sep
 2023 22:56:00 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 22:56:00 +0000
Message-ID: <bdd00e6f-c373-a287-3a12-e57334616237@intel.com>
Date:   Thu, 21 Sep 2023 15:55:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH 3/7] cxl/mem: Fix a checkpatch error
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
 <CGME20230921024832epcas2p450ca98aebdcdd0124be9ad5c2ff22b13@epcas2p4.samsung.com>
 <20230921025110.3717583-4-jtp.park@samsung.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230921025110.3717583-4-jtp.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::33) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA1PR11MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 86cba66a-734a-4623-5fdf-08dbbaf5ec79
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qVI1aDkcEkd49803U1mGBYqjik5HdlqGwXn0cIL3uNSUpgaSMwQVcJuQBMRXvm+3MxemtSrQMy3LUwYeyVIepvys4ki36dguETfIEeifa/xb0LChHDJzpq0Fmn9HBDmW9CdaSqVVDCLeO3VObCzFJd4nb+RvfhfoMCtgG/CXysntEfc9DbzCcSoWz6K24TAILIqSop+blGWkbWNMHNKYBQMz66mWQIiknRgCAU1725jqayM1AHs21PbeajS7+9lgI9U7o58JY914Q3O3lwuwTuzFTeMtL3wBqVJ3S3RhyDDGyWp+XdJEwfSiFls0HcVMNHZatmwpoGOq+RDLwKfmlgD1pDApawYOYJbFbXgcHLHLX3ToOhxn7DYxZ7vUz0lvFI32tss9ljjpapf66q+1ODU6CLKZvfVmdqhXmwlvyMK0aW87/KgkVMG+a3wEohd/yoGhsYphzkkq4YIjD/IHnSG3EG3k0o8KQJ2osn6cBx2XNhNRoR4rFOSEbr4D5ujTd3V4WD67b5CRGJj1JylWBORBZnSfqxyrYMY7haagBXrTt7cMi4MEc/S74Kqf8Y01bcF/OVl6+GTJyuX0mp39vmQ5OHn0sRBIz14mJnBbSLs1nUzaLD8X24RHkxCHowZa8o8clq2O9pqyMsBniTUDOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(1800799009)(451199024)(186009)(31686004)(6506007)(6486002)(6666004)(53546011)(5660300002)(31696002)(36756003)(38100700002)(86362001)(2906002)(41300700001)(8936002)(316002)(83380400001)(478600001)(6512007)(8676002)(66476007)(4326008)(110136005)(2616005)(7416002)(82960400001)(26005)(44832011)(66556008)(54906003)(4744005)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a08vQWNqNjA1SWdVeGF2c3ZFZW5JTGNoMmQ4SmN3RDg2VE4xOEY4WnFaWFha?=
 =?utf-8?B?dzZzV1ZWVm5oaXJJMFljMUpXMUYxeVhqVVFqZnFzdXFoQ29qdlJNVUllbERw?=
 =?utf-8?B?ZFdqc0QvcEF4TzNOcWVuMjVPamo2bm9UTWxCL3J1RnpacHB1TnRZVkQ1OERG?=
 =?utf-8?B?cERFLzlwbTk1MVptRHdoZHBZaGdGTEdxUUs0RWNOR1E2NldQd3NmbFpTdlZH?=
 =?utf-8?B?TDNJSk8rQWxjb3B0NTlBQlJzdU1DMWlJSTMzL3ZjdUdMT0pyb3lFeC93eWRw?=
 =?utf-8?B?VGJzZStrWUl1NUt3eGlDcGtFTkJKVVZlNTJmbXZ4alVPblFrZEorajg3UFRm?=
 =?utf-8?B?YjZOeUREN0l3aUNQeGJVcUcrUWVvckE5WTh4WnlNcERMUUJsZzVxNFlLM2Nx?=
 =?utf-8?B?cDZMRHVGYWFwOEExdDNCMHFZNjdCUWNNQktBMEVJbmZSUkZrZmNDdFBqbm5H?=
 =?utf-8?B?dGJJUDBDckZiWUlYYUVRMk5Ta1A0MDBXWlF3c2VJOFBkSjYrUFlKT1BXaTRB?=
 =?utf-8?B?U0ZaMmpORzNCWW83SjhFYVhYUHpuOUtCZjNvaUVVanN2ejRFUVpuOTBvNE1T?=
 =?utf-8?B?d096dlpidjcwMXVwY2JybThjalV4SjZzSG1tTHJGUnJSS1M2RXI3aUJLYVVn?=
 =?utf-8?B?VkhlVzBqczh6MCtyTnVSZUpnWFR5N1hnaGdZNUZmdklRamFHR2NVaU5LZVdl?=
 =?utf-8?B?ZDV4QTN5VmpNMU5Kb3p2Z3l0UktMWU53WDA0MTV2YzVyT3REb2hLL3hYR1J6?=
 =?utf-8?B?bzVBc3hBL3ZLbWxxSUtzZElOWFV6d0VmaHRUc0tvanlXNFRLSHlCNGhtQ2RJ?=
 =?utf-8?B?VU9BNCttUXI3WmhPalZ1NjNwV1JPRjBsaHJyd3UxNjBRZkdkMi9WdUxCNnlo?=
 =?utf-8?B?N0xURzZpazF0YUI1NzZweDRHY2ZTMkxVbWRHQjk0bW9QS25aMms1d1VtN1Q0?=
 =?utf-8?B?eEdOSXp2SG1OVUE1V0RQYUcyOUR2T1owK0VUOUZHcCtYUE1WVC8zUmtSczFV?=
 =?utf-8?B?eGRWMmthK3NKZ09pekRhVDVHUnpNY1pGSUc5aDl4UTc1ZWl6ajNzbXRCSUJ4?=
 =?utf-8?B?Nzg4TTU2azZOWXgyRDlYMHpMa1I0cDJBdmtjZU5JOHdoejUyejVLTnNmcHJj?=
 =?utf-8?B?WjZqamFGZDFsMVV6aHlVVXpPQkp4WmhNZXZ4MEx1OEJyNDdWdWV0aWdXU0J2?=
 =?utf-8?B?Z25JdVpLVHRVTTA4TzRWakhkVys1MjJCZmNCSGlia3RSbFd2dWJuUldwQlNS?=
 =?utf-8?B?UHVLYk9DeVVrRVorbjJjU1NyT00zR0dnVFQ3cFNIcUJ0U0cvZjM0bXpJcTlI?=
 =?utf-8?B?czJscXF4bGo0alZad09hc0FxUmsvS1NCb2JXY2RnTUljajVCM2pwUFFmZ0Zv?=
 =?utf-8?B?NHZ0aW1WSDk4MGlDWms0NzB1ZlZKcldRanhsRWxGeTZuRkY5MmdtVEZzakg3?=
 =?utf-8?B?eVRYeDBYc3ZWTXJBdWZJaVNMbk1mM29mZVk4YVgxZEtTbTEwZkN5aU5EMCtK?=
 =?utf-8?B?SytuK3ZwMW1CMWJZVTVadFI3Y2UvR21qNnIrSUNVNzRUWVRoRmpZUzB1dVE5?=
 =?utf-8?B?U3ZuV25kSU02bUtOdjNtbWM5bnppdWV2aHYxRVpHNW05KzRSRTVESXFOZkV0?=
 =?utf-8?B?a2NRaU9Ya1VTQWtuWE9LNTBGa0N5bEF6cmNScFplK212ZmhDOXB1MkFJOWJF?=
 =?utf-8?B?NmpjMGxQR1ZlcFBNd3hydlpLcUIrRWpXbHVsTUhDTUxmWVVjK1pQbHRoaGZp?=
 =?utf-8?B?ZUMzUWIra3FWeEtIOE9YcXhiSGZKckFyaXdHYXpjbkhvVkpWU0Y0R2NURVd5?=
 =?utf-8?B?R01RSjQvNTBNbm02M3hhYU9IZmhpeUlTUnFJd3NVR2F3VWZIWEt4VXlyRHhv?=
 =?utf-8?B?RjgraFlFTHEyZ2JKZW9xbEhZd0F4L0N3VzJUNzNoMm85QTU5R2U5UDFZcngr?=
 =?utf-8?B?Q1VMRnVKSjBlVFM1dVNDLzJ6Q2dPS3Q0ZFpFZXBzdkRSUmV5cW9vRjVndjJz?=
 =?utf-8?B?UFdEcnRtd0tKd01qWmpmUDYwMEtLZDZEb0t6UkpyYjMrQ04xV3I3ckhkbjhy?=
 =?utf-8?B?cHFaclRrRVkrYUROVkkrWUMwR0RjbjFpRFU2RHhRWmRXelI0QlFRbGM5U2l3?=
 =?utf-8?Q?IGNH7CXb549bhuyb7Gn2/DvCy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cba66a-734a-4623-5fdf-08dbbaf5ec79
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 22:56:00.2188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQGPXB7Slc8K/pcR32HijZgBQhzLVjNgtqkVqxy+Za50FMZ2oymekrLix/tBP7udmb3+Gzc1P4TXBadBlH/csg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8325
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
> ERROR: spaces required around that '=' (ctx:WxV)
> 
> Signed-off-by: Jeongtae Park <jtp.park@samsung.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/cxlmem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 79e99c873ca2..1ac3eb2be84f 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -183,7 +183,7 @@ struct cxl_mbox_cmd_rc {
>  };
>  
>  static const
> -struct cxl_mbox_cmd_rc cxl_mbox_cmd_rctable[] ={ CMD_CMD_RC_TABLE };
> +struct cxl_mbox_cmd_rc cxl_mbox_cmd_rctable[] = { CMD_CMD_RC_TABLE };
>  #undef C
>  
>  static inline const char *cxl_mbox_cmd_rc2str(struct cxl_mbox_cmd *mbox_cmd)
