Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4683878F2BB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347071AbjHaSiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbjHaSiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:38:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD47E5D;
        Thu, 31 Aug 2023 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693507095; x=1725043095;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rmXkq5qn7f3cLBcHFkKj/mxolkEXMfmB0JyHMvhk9Tg=;
  b=XD2ltz8k6KO5KqwY9KKbOR79kfzUVV8R2We+ZyDOOtfTX74rdQPN4Hsi
   Gm14u5NbLc384ypERLasumTTL6vAh6UJSOUIf599hwF0Gv94Y8pltHajj
   OTst/9/mjCOa14Trw+H0QUeYfdlnrELjN3QhM3RKn2oHrsxgQn+HIB0vx
   5jTG6s2oMVWMahP61rC6zdhUbyNO7A5MlcGbVeqteO87ZCUZ+NE8j9+f8
   VyL6Qfh9g9e/wpbVeEh8i2SiA4Fii31W/q7h97pD9oTWBRvagLdHOkyxd
   I9mu3bkkxkA8KhyhfcrLOz+T4IIfhIq6DqVuWmH4py//AdEc7HVFhz4PU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="374940539"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="374940539"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 11:38:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="716457272"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="716457272"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 11:38:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 11:38:13 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 11:38:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 11:38:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 11:38:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKhPhUhdGICFVZgTv3LH48Y3c6oEO15N33qn8YMLbcrTiuw/ly0cZzM1ZnxO2dTDF5cexkKUruFQ/uabeawIK1cii9HjTOHp/7i65wvAmjrqo9u5g6VZMGA8qIgVINtvyqwKaF0G5RfR00BRoenT3yH2es75zubP5N1T6ZjAaty2bNhqE03Gwt37RdK4EaioVToeOknY+hMWLajnrss6UQD/RNrsUAt8Mu4LZEfXMY5UKYrzZenuuxPwv4M1VyfVBYwqRkZ9khdrNLVWiulAHxSZPCmMjTqFi0Ir9RlRGgGJ/OI9yPxq2MmP6cy8vCIoVLOtSuXDv8SmjDdFpgvc3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwAs5prtdYfj19Yy6IGzQr2JhzIJ5+hA/HBM8C+UyfU=;
 b=ZqBQNJXfAfU/nVlB7uRjSJIuBTytYLIm4G0fnBEkOaHMlVkECL9s8anJ+rkR88H9E98hOU6cjn5GkGM7Adk09/J78WQ+gS1myNJocQ1Jlp09WbV800BUDTs0EDN/oElk/HOHL/adyBOob11oVPEBKID/cgI+RBHr4SgTn78ZxxUZuiydwFivRz3NJ6dvTKzS/kifkP9hcVgxvS/toJ2ap5WjoAWTZ88j62IsYQVhH+uHpyPRsJ7hZW7QPw5+sP1grLFG1mHnLSn9F0pHG2+lVgwh7e9LEAEg2hIrKioS7dXcbENeg9GjxiYC5VpkFTJ5BtjpqGL4mVRSL+vRkTBe+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH8PR11MB6658.namprd11.prod.outlook.com (2603:10b6:510:1c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 18:38:10 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 18:38:10 +0000
Message-ID: <f834c62d-bcbc-899b-db72-117c6e7b13af@intel.com>
Date:   Thu, 31 Aug 2023 11:38:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH RFC v2 11/18] cxl/region: Expose DC extents on region
 driver load
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-11-f740c47e7916@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-11-f740c47e7916@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::28) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH8PR11MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c558bd-4998-4a76-5c01-08dbaa516cf4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qHvwYDGMOFlytarVYoW+KWOPcdtiMOv4yVd/2Ne2n5qMuL4OYwvX8mtneXXd0CirzaNhwGiOetW86C/EJUMTIYoe8VnfacNLu4pFd6Hcm17jBVvwfDkBcDlOsV430PeNJG2e30gsqRzsfNWwWd+xJH/0u9Ij6ibFgJ6MpYyRMrVcLSQvvYOccTY0YYyacGishxsc4HbTbk2RZsK33FTty9wRa9tXHiqcPgrx0HPugJvOdSjBRHRVrfINpM+Jv09mPK15+1+KfVu+0syQR9g+mL34GIdXXeDymZAxRWzR0CARxNvam7Ph879LRkH55r2saR7axga8BNpmKuUoUkO97S2G3fs07s5lWtNuiS8wCVoyQEzk2LSM83GHhnuaShUyt+PhuVa0jA2+w0/ajj8Gm98bYvN0inqC8HPht+es0WUIuWAyypVeMO8WEdIn86ak8xK4i3i0F64D+HKhIUyAnMdM47t4Ouip79mqHWLC9bbyKQq6aEpoEii9hSD6eHiLvO4N3f2uw4nj8Rak8gnL6h2hZzD3fWd9X+Khxob4TKCkNNjuhtxBk1AiJP3B4bY5V0tJG5ZSzfV6T3oaEonHa76xEseOU0PyPkwHBsPAGlD0W7vODXHs6thpMyz24qUqhkhVEBUA/2jOPdj9KTrCJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199024)(186009)(1800799009)(36756003)(31686004)(83380400001)(4326008)(53546011)(44832011)(41300700001)(86362001)(8936002)(5660300002)(31696002)(8676002)(26005)(6506007)(6666004)(6486002)(2616005)(6512007)(2906002)(30864003)(110136005)(38100700002)(478600001)(54906003)(6636002)(82960400001)(66946007)(66556008)(66476007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWE1QUhkNXNmQnYxekRXS2RxQTMzTkVCMm5nVy9SVm1TNmZLWTFsS01OTUN0?=
 =?utf-8?B?OTc1ZDF1QTd0NFZOVTk5VHJJeWFpdXo4TnZVRGRnYys4MjQxaVhDSlRkQXFL?=
 =?utf-8?B?OFdMbUJENEJENHg5T0wrUHFsQ2M1MnF2bW5WWUdTU3p4M09McFl4aWp5QWE2?=
 =?utf-8?B?QmtBSUQrelIrdXFDaW1HYStQWk0wUUJ0Z2JHNjZ0U2VLOHdqNlpVcUpLSWVy?=
 =?utf-8?B?STg4WGdlMW1lMmdOQWZOK09YeVU3Uk5OMUdBRzFMNXBIUDN3TmpQV2xXSms5?=
 =?utf-8?B?VjNWUEhuWDlpTHJUQVJqekpLMXVhR3ZhOHJMclVUa2JVbE82WFVKcmp5eEZT?=
 =?utf-8?B?V2VuczF1cXhWcGZxaThYdmhxdlJzL0twV0pyZnNiRGFIM3RDUm9FS0YzTEV4?=
 =?utf-8?B?NUxRb3ByOUg2Tng3NmFRd0R0QkIxd2piSytwOERuTC9ZRWt3N0sxcExoNmlj?=
 =?utf-8?B?UlpUUURYQmpWd0cwdjQrWEpSVFlUcTE1NFFwZWNBdUFhR1l4OCtkMWJrQUUy?=
 =?utf-8?B?RFBvclV2NThiU3FzZGFrRlUrZG5oRVN6RkQ1M2tXWkpGazJNdlJkNWZLT0tD?=
 =?utf-8?B?RWlycmwraEprb2FONVVZTi9oQzdTZnFSd0d2YXZxUTVCTzJUWmZQa3ZHWGxO?=
 =?utf-8?B?UE1DOFE2SndhamVHSE1Mc1VubGpCcEFIemZrM3Mrc2lyYjdhRGRjaWticU5q?=
 =?utf-8?B?ZTg1RXJFMzh2WnJzTzlQa05WRU5zckQ4aXlRVEs0cWxqa3Bya2RadVhTaFQx?=
 =?utf-8?B?M2VJVlVocGtvUi9BYkxGOUFOaFAyalRjVDBpSGZDSmJkWlV1V3N4OHVOR3RM?=
 =?utf-8?B?NHo4M09vZzIwMzNCckhzRk1neHo4UG55dGdNLzAwdzhCMGR5SjVvaXZTSnkw?=
 =?utf-8?B?VG9lQVp2UDNmVi9tY1NkdWN6MGZ3L254NjEvOHREL045WVlaWldDZWlCL1dn?=
 =?utf-8?B?ekVyMU1uMmtxM1RFQkFja3I2c3pPREFNRG0rc2pwdTk5R21hMjFHNkk1bjEz?=
 =?utf-8?B?c1YvRVJCMW15Mm5aK1ZvSVN6QUJrQ2M5VE9zalNTOWl6ZlFmMmNCTGNqNVd1?=
 =?utf-8?B?RmxRbUU0Rnc2UFZnbkE4U05XVHZOaDhIY3djb0hweWN0VVhKYUpma1JIZkZi?=
 =?utf-8?B?NGQzcFlKVm90TFpySzc5ckV0dE5VZUdEQXlMYUJzbzFqeThuMVJxMnlIM2Ro?=
 =?utf-8?B?b2x0Nk1jS3JqaktXNndzUzhwR3FTeGFOMlovTDBDQWRSRGJyQnloL1ZWZVVo?=
 =?utf-8?B?a0hRczRHWXdna0dSdlpqQzdTa2Rrajh0VnRnTDRyUjN1a3RSbWRlWnQ2NUV0?=
 =?utf-8?B?Zms0ZlkvcE1QVWIzQzdEcHhLZFNGRVNTUm41VU4zTTJOYmZ1bGlqOVlLRFND?=
 =?utf-8?B?Qmtod01QZUJVMDVhdGtEeGJsWjRxbjViMXRFVnFleWY1cjl0QmtabkdLM0tk?=
 =?utf-8?B?RnE4bi92TmxjRWJQZExRWVNCMkpmYmF2SnBCK2t0VE5xN0Q3SGg1T3A2WkhI?=
 =?utf-8?B?RnR1UkQxWjBWL2ZkaFVOZVVyY1FqblZBSjNka2kzV3dRUDM5SUFGajB3TDlv?=
 =?utf-8?B?eTlTcWdKekZ4QkdUbXVpWWQ1ZlRaTHkxcGN0RVV3Zkd3Q2NlY3V5TjVZUHpm?=
 =?utf-8?B?VEJSTGViOVMrOC9WdXhNZW5QbnBLTDZLSnZoc0w1eFY5UkhmczZNYVJKemJ6?=
 =?utf-8?B?aFRENTdzT0I5NmY1RnV0cWxwU29SMXhvRGtBenl6UDh6T20xU1U2dTZLS2tQ?=
 =?utf-8?B?YjlWZGtwWjNETmV2UlVMUHNJdFdQYjVXMXVUUi9GMFZDcm02d0JnY3g4NTcx?=
 =?utf-8?B?TEpUSC96NWVrQ3Z0bWh4bk5wblc4Z2NmWEF5RW0xODdvUlM4UjZpb1doZE5T?=
 =?utf-8?B?cHNRaWRjNHJXZTRxV0R0Tk9kMkVrQkIycGpzaCtkZG5QV0VsMklyYTlqdk1I?=
 =?utf-8?B?U1hDcjJUcHViM2hjQWp3NjN5N2NTZm9tWEpta05mTktuWkt2b2FIT2NxdWZW?=
 =?utf-8?B?WjBPRTRZWFladnNaQ1ZGendEb3lLYWlieDNpeXBjYmZ0WlY5LzZSSys1YjJ4?=
 =?utf-8?B?cVdiMlEwVTVoWG1rOE1vRkZzVWo3OUZLOVhpMm51Qm5xTlZ4b0tadlBjQS85?=
 =?utf-8?Q?f3D7UMVWhGnE2Pu/f5zO2DSQI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c558bd-4998-4a76-5c01-08dbaa516cf4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 18:38:10.1892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xyrkVsuYM71HN9Ti/Mn83YRkUuCaL7yBlrSA3ncKE11KJUh2Et7/57HWAElazwc63leu7l+SNdyFNQKpkwjdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6658
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/23 22:21, Ira Weiny wrote:
> Ultimately user space must associate Dynamic Capacity (DC) extents with
> DAX devices.  Remember also that DCD extents may have been accepted
> previous to regions being created and must have references held until
> all higher level regions and DAX devices are done with the memory.
> 
> On CXL region driver load scan existing device extents and create CXL
> DAX region extents as needed.
> 
> Create abstractions for the extents to be used in DAX region.  This
> includes a generic interface to take proper references on the lower
> level CXL region extents.
> 
> Also maintain separate objects for the DAX region extent device vs the
> DAX region extent.  The DAX region extent device has a shorter life span
> which corresponds to the removal of an extent while a DAX device is
> still using it.  In this case an extent continues to exist whilst the
> ability to create new DAX devices on that extent is prevented.
> 
> NOTE: Without interleaving; the device, CXL region, and DAX region
> extents have a 1:1:1 relationship.  Future support for interleaving will
> maintain a 1:N relationship between CXL region extents and the hardware
> extents.
> 
> While the ability to create DAX devices on an extent exists; expose the
> necessary details of DAX region extents by creating a device with the
> following sysfs entries.
> 
> /sys/bus/cxl/devices/dax_regionX/extentY
> /sys/bus/cxl/devices/dax_regionX/extentY/length
> /sys/bus/cxl/devices/dax_regionX/extentY/label
> 
> Label is a rough analogy to the DC extent tag.  As such the DC extent
> tag is used to initially populate the label.  However, the label is made
> writeable so that it can be adjusted in the future when forming a DAX
> device.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from v1
> [iweiny: move dax_region_extents to dax layer]
> [iweiny: adjust for kreference of extents]
> [iweiny: adjust naming to cxl_dr_extent]
> [iweiny: Remove region_extent xarray; use child devices instead]
> [iweiny: ensure dax region devices are destroyed on region destruction]
> [iweiny: use xa_insert]
> [iweiny: hpa_offset is a dr_extent parameter not an extent parameter]
> [iweiny: Add dc_region_extents when the region driver is loaded]
> ---
>   drivers/cxl/core/mbox.c   |  12 ++++
>   drivers/cxl/core/region.c | 179 ++++++++++++++++++++++++++++++++++++++++++++--
>   drivers/cxl/cxl.h         |  16 +++++
>   drivers/cxl/cxlmem.h      |   2 +
>   drivers/dax/Makefile      |   1 +
>   drivers/dax/cxl.c         | 101 ++++++++++++++++++++++++--
>   drivers/dax/dax-private.h |  53 ++++++++++++++
>   drivers/dax/extent.c      | 119 ++++++++++++++++++++++++++++++
>   8 files changed, 473 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 8474a28b16ca..5472ab1d0370 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1055,6 +1055,18 @@ static void dc_extent_release(struct kref *kref)
>   	kfree(extent);
>   }
>   
> +int __must_check cxl_dc_extent_get_not_zero(struct cxl_dc_extent_data *extent)
> +{
> +	return kref_get_unless_zero(&extent->region_ref);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dc_extent_get_not_zero, CXL);
> +
> +void cxl_dc_extent_get(struct cxl_dc_extent_data *extent)
> +{
> +	kref_get(&extent->region_ref);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dc_extent_get, CXL);
> +
>   void cxl_dc_extent_put(struct cxl_dc_extent_data *extent)
>   {
>   	kref_put(&extent->region_ref, dc_extent_release);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index fc8dee469244..0aeea50550f6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1547,6 +1547,122 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
>   	return 0;
>   }
>   
> +static bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,
> +				struct cxl_dc_extent_data *extent)
> +{
> +	struct range dpa_range = (struct range){
> +		.start = extent->dpa_start,
> +		.end = extent->dpa_start + extent->length - 1,
> +	};
> +	struct device *dev = &cxled->cxld.dev;
> +
> +	dev_dbg(dev, "Checking extent DPA:%llx LEN:%llx\n",
> +		extent->dpa_start, extent->length);
> +
> +	if (!cxled->cxld.region || !cxled->dpa_res)
> +		return false;
> +
> +	dev_dbg(dev, "Cxled start:%llx end:%llx\n",
> +		cxled->dpa_res->start, cxled->dpa_res->end);

Just use %pr?

> +	return (cxled->dpa_res->start <= dpa_range.start &&
> +		dpa_range.end <= cxled->dpa_res->end);

I may be easier to read for some if you have (dpa_range.start > 
cxled->dpa_res->start && ...) instead.

> +}
> +
> +static int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
> +				 struct cxl_dc_extent_data *extent)
> +{
> +	struct cxl_dr_extent *cxl_dr_ext;
> +	struct cxl_dax_region *cxlr_dax;
> +	resource_size_t dpa_offset, hpa;
> +	struct range *ed_hpa_range;
> +	struct device *dev;
> +	int rc;
> +
> +	cxlr_dax = cxled->cxld.region->cxlr_dax;
> +	dev = &cxlr_dax->dev;
> +	dev_dbg(dev, "Adding DC extent DPA:%llx LEN:%llx\n",
> +		extent->dpa_start, extent->length);
> +
> +	/*
> +	 * Interleave ways == 1 means this coresponds to a 1:1 mapping between
> +	 * device extents and DAX region extents.  Future implementations
> +	 * should hold DC region extents here until the full dax region extent
> +	 * can be realized.
> +	 */
> +	if (cxlr_dax->cxlr->params.interleave_ways != 1) {
> +		dev_err(dev, "Interleaving DC not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	cxl_dr_ext = kzalloc(sizeof(*cxl_dr_ext), GFP_KERNEL);
> +	if (!cxl_dr_ext)
> +		return -ENOMEM;
> +
> +	cxl_dr_ext->extent = extent;
> +	kref_init(&cxl_dr_ext->region_ref);
> +
> +	/*
> +	 * Without interleave...
> +	 * HPA offset == DPA offset
> +	 * ... but do the math anyway
> +	 */
> +	dpa_offset = extent->dpa_start - cxled->dpa_res->start;
> +	ed_hpa_range = &cxled->cxld.hpa_range;
> +	hpa = ed_hpa_range->start + dpa_offset;
> +	cxl_dr_ext->hpa_offset = hpa - cxlr_dax->hpa_range.start;
> +
> +	/* Without interleave carry length and label through */
> +	cxl_dr_ext->hpa_length = extent->length;
> +	snprintf(cxl_dr_ext->label, CXL_EXTENT_LABEL_LEN, "%s",
> +		 extent->tag);
> +
> +	dev_dbg(dev, "Inserting at HPA:%llx\n", cxl_dr_ext->hpa_offset);
> +	rc = xa_insert(&cxlr_dax->extents, cxl_dr_ext->hpa_offset, cxl_dr_ext,
> +		       GFP_KERNEL);
> +	if (rc) {
> +		dev_err(dev, "Failed to insert extent %d\n", rc);
> +		kfree(cxl_dr_ext);
> +		return rc;
> +	}
> +	/* Put in cxl_dr_release() */
> +	cxl_dc_extent_get(cxl_dr_ext->extent);
> +	return 0;
> +}
> +
> +static int cxl_ed_add_extents(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = container_of(cxlds,
> +						    struct cxl_memdev_state,
> +						    cxlds);
> +	struct device *dev = &cxled->cxld.dev;
> +	struct cxl_dc_extent_data *extent;
> +	unsigned long index;
> +
> +	dev_dbg(dev, "Searching for DC extents\n");
> +	xa_for_each(&mds->dc_extent_list, index, extent) {
> +		/*
> +		 * get not zero is important because this is racing with the
> +		 * memory device which could be removing the extent at the same
> +		 * time.
> +		 */
> +		if (cxl_dc_extent_get_not_zero(extent)) {
> +			int rc = 0;
> +
> +			if (cxl_dc_extent_in_ed(cxled, extent)) {
> +				dev_dbg(dev, "Found extent DPA:%llx LEN:%llx\n",
> +					extent->dpa_start, extent->length);
> +				rc = cxl_ed_add_one_extent(cxled, extent);
> +			}
> +			cxl_dc_extent_put(extent);
> +			if (rc)
> +				return rc;
> +		}
> +	}
> +	return 0;
> +}
> +
>   static int cxl_region_attach_position(struct cxl_region *cxlr,
>   				      struct cxl_root_decoder *cxlrd,
>   				      struct cxl_endpoint_decoder *cxled,
> @@ -2702,10 +2818,44 @@ static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
>   	return cxlr_pmem;
>   }
>   
> +int __must_check cxl_dr_extent_get_not_zero(struct cxl_dr_extent *cxl_dr_ext)
> +{
> +	return kref_get_unless_zero(&cxl_dr_ext->region_ref);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dr_extent_get_not_zero, CXL);
> +
> +void cxl_dr_extent_get(struct cxl_dr_extent *cxl_dr_ext)
> +{
> +	return kref_get(&cxl_dr_ext->region_ref);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dr_extent_get, CXL);
> +
> +static void cxl_dr_release(struct kref *kref)
> +{
> +	struct cxl_dr_extent *cxl_dr_ext = container_of(kref,
> +						struct cxl_dr_extent,
> +						region_ref);
> +
> +	cxl_dc_extent_put(cxl_dr_ext->extent);
> +	kfree(cxl_dr_ext);
> +}
> +
> +void cxl_dr_extent_put(struct cxl_dr_extent *cxl_dr_ext)
> +{
> +	kref_put(&cxl_dr_ext->region_ref, cxl_dr_release);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dr_extent_put, CXL);
> +
>   static void cxl_dax_region_release(struct device *dev)
>   {
>   	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
> +	struct cxl_dr_extent *cxl_dr_ext;
> +	unsigned long index;
>   
> +	xa_for_each(&cxlr_dax->extents, index, cxl_dr_ext) {
> +		xa_erase(&cxlr_dax->extents, index);
> +		cxl_dr_extent_put(cxl_dr_ext);
> +	}
>   	kfree(cxlr_dax);
>   }
>   
> @@ -2756,6 +2906,7 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
>   
>   	cxlr_dax->hpa_range.start = p->res->start;
>   	cxlr_dax->hpa_range.end = p->res->end;
> +	xa_init(&cxlr_dax->extents);
>   
>   	dev = &cxlr_dax->dev;
>   	cxlr_dax->cxlr = cxlr;
> @@ -2862,7 +3013,17 @@ static void cxlr_dax_unregister(void *_cxlr_dax)
>   	device_unregister(&cxlr_dax->dev);
>   }
>   
> -static int __devm_cxl_add_dax_region(struct cxl_region *cxlr)
> +static int cxl_region_add_dc_extents(struct cxl_region *cxlr)
> +{
> +	for (int i = 0; i < cxlr->params.nr_targets; i++) {
> +		int rc = cxl_ed_add_extents(cxlr->params.targets[i]);
> +		if (rc)
> +			return rc;
> +	}
> +	return 0;
> +}
> +
> +static int __devm_cxl_add_dax_region(struct cxl_region *cxlr, bool is_dc)
>   {
>   	struct cxl_dax_region *cxlr_dax;
>   	struct device *dev;
> @@ -2877,6 +3038,17 @@ static int __devm_cxl_add_dax_region(struct cxl_region *cxlr)
>   	if (rc)
>   		goto err;
>   
> +	cxlr->cxlr_dax = cxlr_dax;
> +	if (is_dc) {
> +		/*
> +		 * Process device extents prior to surfacing the device to
> +		 * ensure the cxl_dax_region driver has access to prior extents
> +		 */
> +		rc = cxl_region_add_dc_extents(cxlr);
> +		if (rc)
> +			goto err;
> +	}
> +
>   	rc = device_add(dev);
>   	if (rc)
>   		goto err;
> @@ -2893,7 +3065,7 @@ static int __devm_cxl_add_dax_region(struct cxl_region *cxlr)
>   
>   static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>   {
> -	return __devm_cxl_add_dax_region(cxlr);
> +	return __devm_cxl_add_dax_region(cxlr, false);
>   }
>   
>   static int devm_cxl_add_dc_dax_region(struct cxl_region *cxlr)
> @@ -2902,8 +3074,7 @@ static int devm_cxl_add_dc_dax_region(struct cxl_region *cxlr)
>   		dev_err(&cxlr->dev, "Interleaving DC not supported\n");
>   		return -EINVAL;
>   	}
> -
> -	return __devm_cxl_add_dax_region(cxlr);
> +	return __devm_cxl_add_dax_region(cxlr, true);
>   }
>   
>   static int match_decoder_by_range(struct device *dev, void *data)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 81ca76ae1d02..177b892ac53f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -555,6 +555,7 @@ struct cxl_region_params {
>    * @type: Endpoint decoder target type
>    * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
>    * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
> + * @cxlr_dax: (for DC regions) cached copy of CXL DAX bridge
>    * @flags: Region state flags
>    * @params: active + config params for the region
>    */
> @@ -565,6 +566,7 @@ struct cxl_region {
>   	enum cxl_decoder_type type;
>   	struct cxl_nvdimm_bridge *cxl_nvb;
>   	struct cxl_pmem_region *cxlr_pmem;
> +	struct cxl_dax_region *cxlr_dax;
>   	unsigned long flags;
>   	struct cxl_region_params params;
>   };
> @@ -614,8 +616,22 @@ struct cxl_dax_region {
>   	struct device dev;
>   	struct cxl_region *cxlr;
>   	struct range hpa_range;
> +	struct xarray extents;
>   };
>   
> +/* Interleave will manage multiple cxl_dc_extent_data objects */
> +#define CXL_EXTENT_LABEL_LEN 64
> +struct cxl_dr_extent {
> +	struct kref region_ref;
> +	u64 hpa_offset;
> +	u64 hpa_length;
> +	char label[CXL_EXTENT_LABEL_LEN];
> +	struct cxl_dc_extent_data *extent;
> +};
> +int cxl_dr_extent_get_not_zero(struct cxl_dr_extent *cxl_dr_ext);
> +void cxl_dr_extent_get(struct cxl_dr_extent *cxl_dr_ext);
> +void cxl_dr_extent_put(struct cxl_dr_extent *cxl_dr_ext);
> +
>   /**
>    * struct cxl_port - logical collection of upstream port devices and
>    *		     downstream port devices to construct a CXL memory
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 118392229174..8ca81fd067c2 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -1002,6 +1002,8 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>   int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>   int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>   
> +int cxl_dc_extent_get_not_zero(struct cxl_dc_extent_data *extent);
> +void cxl_dc_extent_get(struct cxl_dc_extent_data *extent);
>   void cxl_dc_extent_put(struct cxl_dc_extent_data *extent);
>   
>   #ifdef CONFIG_CXL_SUSPEND
> diff --git a/drivers/dax/Makefile b/drivers/dax/Makefile
> index 5ed5c39857c8..38cd3c4c0898 100644
> --- a/drivers/dax/Makefile
> +++ b/drivers/dax/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_DEV_DAX_CXL) += dax_cxl.o
>   
>   dax-y := super.o
>   dax-y += bus.o
> +dax-y += extent.o
>   device_dax-y := device.o
>   dax_pmem-y := pmem.o
>   dax_cxl-y := cxl.o
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index 147c8c69782b..057b00b1d914 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -5,6 +5,87 @@
>   
>   #include "../cxl/cxl.h"
>   #include "bus.h"
> +#include "dax-private.h"
> +
> +static void dax_reg_ext_get(struct dax_region_extent *dr_extent)
> +{
> +	kref_get(&dr_extent->ref);
> +}
> +
> +static void dr_release(struct kref *kref)
> +{
> +	struct dax_region_extent *dr_extent;
> +	struct cxl_dr_extent *cxl_dr_ext;
> +
> +	dr_extent = container_of(kref, struct dax_region_extent, ref);
> +	cxl_dr_ext = dr_extent->private_data;
> +	cxl_dr_extent_put(cxl_dr_ext);
> +	kfree(dr_extent);
> +}
> +
> +static void dax_reg_ext_put(struct dax_region_extent *dr_extent)
> +{
> +	kref_put(&dr_extent->ref, dr_release);
> +}
> +
> +static int cxl_dax_region_create_extent(struct dax_region *dax_region,
> +					struct cxl_dr_extent *cxl_dr_ext)
> +{
> +	struct dax_region_extent *dr_extent;
> +	int rc;
> +
> +	dr_extent = kzalloc(sizeof(*dr_extent), GFP_KERNEL);
> +	if (!dr_extent)
> +		return -ENOMEM;
> +
> +	dr_extent->private_data = cxl_dr_ext;
> +	dr_extent->get = dax_reg_ext_get;
> +	dr_extent->put = dax_reg_ext_put;
> +
> +	/* device manages the dr_extent on success */
> +	kref_init(&dr_extent->ref);
> +
> +	rc = dax_region_ext_create_dev(dax_region, dr_extent,
> +				       cxl_dr_ext->hpa_offset,
> +				       cxl_dr_ext->hpa_length,
> +				       cxl_dr_ext->label);
> +	if (rc) {
> +		kfree(dr_extent);
> +		return rc;
> +	}
> +
> +	/* extent accepted */
> +	cxl_dr_extent_get(cxl_dr_ext);
> +	return 0;
> +}
> +
> +static int cxl_dax_region_create_extents(struct cxl_dax_region *cxlr_dax)
> +{
> +	struct cxl_dr_extent *cxl_dr_ext;
> +	unsigned long index;
> +
> +	dev_dbg(&cxlr_dax->dev, "Adding extents\n");
> +	xa_for_each(&cxlr_dax->extents, index, cxl_dr_ext) {
> +		/*
> +		 * get not zero is important because this is racing with the
> +		 * region driver which is racing with the memory device which
> +		 * could be removing the extent at the same time.
> +		 */
> +		if (cxl_dr_extent_get_not_zero(cxl_dr_ext)) {
> +			struct dax_region *dax_region;
> +			int rc;
> +
> +			dax_region = dev_get_drvdata(&cxlr_dax->dev);
> +			dev_dbg(&cxlr_dax->dev, "Found OFF:%llx LEN:%llx\n",
> +				cxl_dr_ext->hpa_offset, cxl_dr_ext->hpa_length);
> +			rc = cxl_dax_region_create_extent(dax_region, cxl_dr_ext);
> +			cxl_dr_extent_put(cxl_dr_ext);
> +			if (rc)
> +				return rc;
> +		}
> +	}
> +	return 0;
> +}
>   
>   static int cxl_dax_region_probe(struct device *dev)
>   {
> @@ -19,20 +100,28 @@ static int cxl_dax_region_probe(struct device *dev)
>   	if (nid == NUMA_NO_NODE)
>   		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
>   
> -	dev_size = range_len(&cxlr_dax->hpa_range);
> -
>   	flags = IORESOURCE_DAX_KMEM;
> -	if (cxlr->mode == CXL_REGION_DC) {
> -		/* Add empty seed dax device */
> -		dev_size = 0;
> +	if (cxlr->mode == CXL_REGION_DC)
>   		flags |= IORESOURCE_DAX_DYNAMIC_CAP;
> -	}
>   
>   	dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
>   				      PMD_SIZE, flags);
>   	if (!dax_region)
>   		return -ENOMEM;
>   
> +	dev_size = range_len(&cxlr_dax->hpa_range);
> +	if (cxlr->mode == CXL_REGION_DC) {
> +		int rc;
> +
> +		/* NOTE: Depends on dax_region being set in driver data */
> +		rc = cxl_dax_region_create_extents(cxlr_dax);
> +		if (rc)
> +			return rc;
> +
> +		/* Add empty seed dax device */
> +		dev_size = 0;
> +	}
> +
>   	data = (struct dev_dax_data) {
>   		.dax_region = dax_region,
>   		.id = -1,
> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index 27cf2daaaa79..4dab52496c3f 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@ -5,6 +5,7 @@
>   #ifndef __DAX_PRIVATE_H__
>   #define __DAX_PRIVATE_H__
>   
> +#include <linux/pgtable.h>
>   #include <linux/device.h>
>   #include <linux/cdev.h>
>   #include <linux/idr.h>
> @@ -40,6 +41,58 @@ struct dax_region {
>   	struct device *youngest;
>   };
>   
> +/*
> + * struct dax_region_extent - extent data defined by the low level region
> + * driver.
> + * @private_data: lower level region driver data
> + * @ref: track number of dax devices which are using this extent
> + * @get: get reference to low level data
> + * @put: put reference to low level data
> + */
> +struct dax_region_extent {
> +	void *private_data;
> +	struct kref ref;
> +	void (*get)(struct dax_region_extent *dr_extent);
> +	void (*put)(struct dax_region_extent *dr_extent);
> +};
> +
> +static inline void dr_extent_get(struct dax_region_extent *dr_extent)
> +{
> +	if (dr_extent->get)
> +		dr_extent->get(dr_extent);
> +}
> +
> +static inline void dr_extent_put(struct dax_region_extent *dr_extent)
> +{
> +	if (dr_extent->put)
> +		dr_extent->put(dr_extent);
> +}
> +
> +#define DAX_EXTENT_LABEL_LEN 64
> +/**
> + * struct dax_reg_ext_dev - Device object to expose extent information
> + * @dev: device representing this extent
> + * @dr_extent: reference back to private extent data
> + * @offset: offset of this extent
> + * @length: size of this extent
> + * @label: identifier to group extents
> + */
> +struct dax_reg_ext_dev {
> +	struct device dev;
> +	struct dax_region_extent *dr_extent;
> +	resource_size_t offset;
> +	resource_size_t length;
> +	char label[DAX_EXTENT_LABEL_LEN];
> +};
> +
> +int dax_region_ext_create_dev(struct dax_region *dax_region,
> +			      struct dax_region_extent *dr_extent,
> +			      resource_size_t offset,
> +			      resource_size_t length,
> +			      const char *label);
> +#define to_dr_ext_dev(dev)	\
> +	container_of(dev, struct dax_reg_ext_dev, dev)
> +
>   struct dax_mapping {
>   	struct device dev;
>   	int range_id;


This is a rather large patch. Can the code below be broken out to a 
separate patch?

> diff --git a/drivers/dax/extent.c b/drivers/dax/extent.c
> new file mode 100644
> index 000000000000..2075ccfb21cb
> --- /dev/null
> +++ b/drivers/dax/extent.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2023 Intel Corporation. All rights reserved. */
> +
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include "dax-private.h"
> +
> +static ssize_t length_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct dax_reg_ext_dev *dr_reg_ext_dev = to_dr_ext_dev(dev);
> +
> +	return sysfs_emit(buf, "%#llx\n", dr_reg_ext_dev->length);
> +}
> +static DEVICE_ATTR_RO(length);
> +
> +static ssize_t label_show(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	struct dax_reg_ext_dev *dr_reg_ext_dev = to_dr_ext_dev(dev);
> +
> +	return sysfs_emit(buf, "%s\n", dr_reg_ext_dev->label);
> +}
> +
> +static ssize_t label_store(struct device *dev, struct device_attribute *attr,
> +			   const char *buf, size_t len)
> +{
> +	struct dax_reg_ext_dev *dr_reg_ext_dev = to_dr_ext_dev(dev);
> +
> +	snprintf(dr_reg_ext_dev->label, DAX_EXTENT_LABEL_LEN, "%s", buf);
> +	return len;
> +}
> +static DEVICE_ATTR_RW(label);
> +
> +static struct attribute *dr_extent_attrs[] = {
> +	&dev_attr_length.attr,
> +	&dev_attr_label.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group dr_extent_attribute_group = {
> +	.attrs = dr_extent_attrs,
> +};
> +
> +static void dr_extent_release(struct device *dev)
> +{
> +	struct dax_reg_ext_dev *dr_reg_ext_dev = to_dr_ext_dev(dev);
> +
> +	kfree(dr_reg_ext_dev);
> +}
> +
> +static const struct attribute_group *dr_extent_attribute_groups[] = {
> +	&dr_extent_attribute_group,
> +	NULL,
> +};
> +
> +const struct device_type dr_extent_type = {
> +	.name = "extent",
> +	.release = dr_extent_release,
> +	.groups = dr_extent_attribute_groups,
> +};
> +
> +static void unregister_dr_extent(void *ext)
> +{
> +	struct dax_reg_ext_dev *dr_reg_ext_dev = ext;
> +	struct dax_region_extent *dr_extent;
> +
> +	dr_extent = dr_reg_ext_dev->dr_extent;
> +	dev_dbg(&dr_reg_ext_dev->dev, "Unregister DAX region ext OFF:%llx L:%s\n",
> +		dr_reg_ext_dev->offset, dr_reg_ext_dev->label);
> +	dr_extent_put(dr_extent);
> +	device_unregister(&dr_reg_ext_dev->dev);
> +}
> +
> +int dax_region_ext_create_dev(struct dax_region *dax_region,
> +			      struct dax_region_extent *dr_extent,
> +			      resource_size_t offset,
> +			      resource_size_t length,
> +			      const char *label)
> +{
> +	struct dax_reg_ext_dev *dr_reg_ext_dev;
> +	struct device *dev;
> +	int rc;
> +
> +	dr_reg_ext_dev = kzalloc(sizeof(*dr_reg_ext_dev), GFP_KERNEL);
> +	if (!dr_reg_ext_dev)
> +		return -ENOMEM;
> +
> +	dr_reg_ext_dev->dr_extent = dr_extent;
> +	dr_reg_ext_dev->offset = offset;
> +	dr_reg_ext_dev->length = length;
> +	snprintf(dr_reg_ext_dev->label, DAX_EXTENT_LABEL_LEN, "%s", label);
> +
> +	dev = &dr_reg_ext_dev->dev;
> +	device_initialize(dev);
> +	dev->id = offset / PMD_SIZE ;
> +	device_set_pm_not_required(dev);
> +	dev->parent = dax_region->dev;
> +	dev->type = &dr_extent_type;
> +	rc = dev_set_name(dev, "extent%d", dev->id);
> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	dev_dbg(dev, "DAX region extent OFF:%llx LEN:%llx\n",
> +		dr_reg_ext_dev->offset, dr_reg_ext_dev->length);
> +	return devm_add_action_or_reset(dax_region->dev, unregister_dr_extent,
> +					dr_reg_ext_dev);
> +
> +err:
> +	dev_err(dev, "Failed to initialize DAX extent dev OFF:%llx LEN:%llx\n",
> +		dr_reg_ext_dev->offset, dr_reg_ext_dev->length);
> +	put_device(dev);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(dax_region_ext_create_dev);
> 
