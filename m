Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610D87CB722
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjJPXnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjJPXnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:43:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9E092;
        Mon, 16 Oct 2023 16:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697499816; x=1729035816;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xswmVmlfZ40loRTQpCy1mEF/L/JTeQG3bG8TjhAKiT0=;
  b=e0w+r3QpbsBE/cbIETLsERzeDAsA03jVn50njGGESQIu0klA8MvxoL5Q
   8GIoS9t0Lj2PCWQsCBFMCBfJHiBU5eQU7yoswsVWTCsvizSFtemYfKgJv
   pa9T+GiDdZq+CkSTGQfNOOSaLl8+0cGJNyyOmbqRn5t2M4fGKhfWaZlHJ
   EtxoRO0KLRA3BLRxV4KETQ+dW4WeajD4I3R1guYeJo0qcuMUnWwBEzMpZ
   3nXSeCDUnsw7KFgNtOAsxFpimCOEiS5xA/uJ9npmJ1ZECEev0AefnCh6h
   jjTpUWm5zmBe8Am9S67vL+X6VnUBl67Jmx1A8rfpuL4K58LXOkvHFPBuf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="452142148"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="452142148"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 16:43:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="705783202"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="705783202"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 16:43:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 16:43:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 16:43:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 16:43:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 16:43:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJP5p+F2fNTCOGKKxLF/GH3ObM+Uib4T4PVMSmYCla7p6AtgIn0+ewgBUKj45HyE0xFR/zdbArHDUSaotqsEytx84HGdH1J1tX45r273XV9fbMixYIbk8mos2VoTJRCUl0ruf2JkQ1rejpHF5/eOb55pTIG0GpN9DRIukUkRLjW9gaNw2vLog5SUUDP8AVuDTzavFc8o5/vgvmCt2Y5nwVrzXYH1/16YJspKH7/w2u1NH8jl4CmYSH3LvJ0tiQLUJURI2bg+RzOX0BnAyr3BsvjEuQt1K6j0BcaaCxokt2YOGOH6y/LLLV3jTGeNsYF6NWs08RiyXSDo9VOrwVHSYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgmS1nJsWM3Fq7Zvur5S3bIOGKUxFBX/qbFcGk+Ogg0=;
 b=Qj8JMT/eNgv8KWzqUqW2pU9Pstm1KFjBBQeOHLqY+FpCSaav2Sx3lcigC7Ru4QGAFnmZ1DOxzxyNiuK05PHUfxmN2+4+ScWvo71r42MezaoZxMPsDf6pB3BK/fZ9tC0QCq24j2dmOAqEYntkV6qLlRcdmJIC1ZA0OfA7r7WO31BH5LNa5iDFVZl5nqt+gVllWetE6moRGXU3iHLPQYKdie1bIL8mpyZP7S9kgkasmAJ5LRKUnHuxv3iwLF49QmwB/KypbrTU5MbQJecpFbkqU1Hl0WABHg0lga7p5KksBQuRFAdPeb7DoVZmPu8235cmT1XTDCoXQbeRNASAlk2bZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SN7PR11MB7637.namprd11.prod.outlook.com (2603:10b6:806:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 16 Oct
 2023 23:43:31 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6863.047; Mon, 16 Oct 2023
 23:43:31 +0000
Message-ID: <b62ded44-4432-4aee-a086-1171b89fd2ae@intel.com>
Date:   Mon, 16 Oct 2023 16:43:27 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] cxl/pmu: Ensure put_device on pmu devices
To:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231016-pmu-unregister-fix-v1-1-1e2eb2fa3c69@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231016-pmu-unregister-fix-v1-1-1e2eb2fa3c69@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0129.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::14) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SN7PR11MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 506115f0-5c9c-4280-a372-08dbcea1b402
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gdw33hH6wrt/mILPLLFDTIZhoks/4RWn1tVM3kJw9Kob3Txsrvf6ozfAFr/y99D0fa/nyNH3L5Tv+uH4TxrAZqsGKerKxryoohMDrp9H176NwPlb4NbikHfHLRqk9uPy+z8eVHKra/D4pvikh/yroUQq72fInwlQuQ0bclVdeVDE7JO8NFz0PGrIxfT1fYUtDDNvHVWZIwoyaRdL+ZFOGnNG3H2r84UceAMy/hWJ9xmARd6biOx2Tso1oSAoHdhCQnyODowTq/+PJTX4qaQuNKYGk1geCoo40maCTNy8NdEIvsICswefCyrS68uOKNWVUakOgzsJUIWwqb5M5FcBene5mQk8vYblTrYsEenneBQICh/qBCBNFW59Dr9EME2iQJC2UF10LIPvy6d1N1WxhuCAbTJHUNDVIYCm0kdTYsIBIPssMTcdR/ZqPjSqrTWFeASnaOoU/wbDBJXVuxLiz2amle4q+Q3b7oQ6GPmsrUMV18JlZ4Mg5DjvwZJQqXKPU+iRWpB8Xqf+6Ua9BbKieBhAIJu9kpw76fTiqcZRTJsBVoqEf8Ab2iXoOJUsAmthxEziwtEB8e0XQzkHQx3pHUqNeLkTNAn8LSSJscKAYrfC59sbD2ZZHvMHZVM6/fAe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31696002)(86362001)(36756003)(4326008)(8936002)(44832011)(8676002)(2906002)(2616005)(5660300002)(26005)(83380400001)(6486002)(316002)(6636002)(41300700001)(478600001)(110136005)(66476007)(66556008)(82960400001)(66946007)(31686004)(6506007)(6512007)(6666004)(53546011)(38100700002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFNocmRqOUNYanE5SFRiNlJ3Yzl0dGJ5bGQ3enkwSm9XQi9Rd3VRcU4yVkVQ?=
 =?utf-8?B?S0Nyb0ZBZWFCWkdqMUZRaG9Qc2JON1ZMNWlOUlRpSkVCNWhSamt6Njc0OE5Q?=
 =?utf-8?B?bHZoeFV2RzhYVWc2Yk5taDFCOUl5Wi9uUWZiaGlNaytzcUZQWVRpSk1mSFJl?=
 =?utf-8?B?Q1NDblN5TUUzZjI2cWszODZyajJLdm55VTJIRXdXa1AzemZBVmFZeUVONU8x?=
 =?utf-8?B?QzNFU0JHeFRXSTJzeFpJcEtVMHZoWkhjclpLN2ZPZWx6Y1drV1Yva0h5dUlh?=
 =?utf-8?B?NGJzWUlvSEVSSXYyTk9aeTlHblpwYjRaZkNub1dUNXF3ZjVTK2J5eVkvcTVD?=
 =?utf-8?B?L1RNTW12OVZnenhSbGFETlpqOUR5MFQ0QXFTUkNCVDVhbWk5M2FwTGxuMk1W?=
 =?utf-8?B?aThieWUvU29TNDA4RXQ0c1JMM3dFMkYveTF0RWlnMWZ3bHZocitzMCtzNzZx?=
 =?utf-8?B?Umt2T29ITTgvcUVTc0FFMHNHcWo4NzIxZnpKR0hCeWpTY0d3U01aQXNJOXB0?=
 =?utf-8?B?YmtiSDhoZ3R4L05WaGRHOWdMeXdEMUN2bElWN0EwZ1lFWDg2ZFB2SWJSNUZJ?=
 =?utf-8?B?akxtR3pHUG1UV1FDOW5LVzY4a2VieXcwM1BMUXQ0OE4xRHZZQTBmbldIcXdp?=
 =?utf-8?B?TDU2LzBsTGJYclFtZmVkSnVVN3ZFbjlhU2wwRDExcXRtTFkxemJYemxUOXI2?=
 =?utf-8?B?Ri9YZjdsa1k2ZVVIaE9HU0xFbEVySzhXbC93ZGtWWW15cUlPOVlTRnFndVRn?=
 =?utf-8?B?Mk9zaHdKS21XNnhVRzFsSTVEMHNOeDVlOGdOb3prUEhEUkFnTTA1L29icDNO?=
 =?utf-8?B?RFVZaFlJMzQ3UTFLUFlDTzZGQXZwajN1VHlOU0NsL1ZDdFVFeHdHU29wcDds?=
 =?utf-8?B?Y25kT3JKcEt1eXVJODZ0NzZTYUE4ejNXVzBCSjdsVlZ0cUVrSlJOWVRNd2dJ?=
 =?utf-8?B?UCtkaSszN1A2MDBjbjN4KytVb2lwYWpDVmJLTCtGSFhZMTRYS1FneElLc21N?=
 =?utf-8?B?eS9sOXFjU2JGWnFLRzVTVXh5Y0ZvY3VCZUlkQzFENFdqaVV5eHR1bmZrSWxl?=
 =?utf-8?B?UTlxNGlUTUZ1Tm11ZHR4V3ZmYmEyQ2VyZXZ2Y2lRcnFQcE9ZSlNYbElRMDFy?=
 =?utf-8?B?ckxDUERxQW5NMjAvUmdqWHY4VWQ0dm9meVk3bnRoZEgrcmp2Y1hrRFJ0eFhC?=
 =?utf-8?B?czk4cEI1eHFZVDRlZ1d3RG04cHN3djIzYnRoVlcwOENRSXp6MCtyWHJlM3pa?=
 =?utf-8?B?VlBzbTNSV2pHOFk4Sy9oRXA4UGJtbzhVZS84aGlHMnNwdzJYejlUZ0FDcmoz?=
 =?utf-8?B?emxsS1VSMWhkbGlueTNudWxKREVBUHZKQVJhbTF6d09PWGRmUjJsVy9sdVRB?=
 =?utf-8?B?Q2xYZWloVzdMaG1JZGlBZWFXRUw5R0h3UG1ESG9ualZFY2FEVHdtSmU3WEpt?=
 =?utf-8?B?Zm9ESkpCS3IwVEliclBFMktJYnQ5cWI0K2s3M09LS2xwVlZ2MW1KWXdXc1Z1?=
 =?utf-8?B?U2FhdktjMzNqKzlzeHJCK3FtZ0lyRkFHSXgwZDRrYmk3WGlGSFBTRzNtNm5M?=
 =?utf-8?B?QUkwbkFCR3BtUkxIbFRzT2Y5NUZlenJ4bmhHUWhVMU5VQUVMR1NzMjhESk92?=
 =?utf-8?B?dm5OU1ZzSWVmVytST1BEVzdVc2xHK0ZXTEJPb3VDYkJOYVBzVEVLK2VibDVm?=
 =?utf-8?B?bWVXbkxaZytOOHU1andhc1BnYUpNQStWRW5PVE0zQ1hlNGZzRkIrL0EwV2hR?=
 =?utf-8?B?cDZWcDRMaU5paG9qclRWaXpLYXRDRE9GVGJlcGZEblUxZkRpZk1Wd3UvbndY?=
 =?utf-8?B?cTczdVZHempLT05mKzVHS0NPMTlpTFoxWURkZ0N2Uml3MnJlOUFodEdoMzFt?=
 =?utf-8?B?b09mS2JYOVE1MXlWSGVIdUJiSnQzRGJ5ODIrdEJxdGRhcXE1RUlyY3NtOUQ0?=
 =?utf-8?B?Y2R3ZGhLSkpSSnpmeHFYeG92ZjJiUXlLakY0ZXV0d0ppMXhYRVNndG5yekJa?=
 =?utf-8?B?TnRkR2tmS0RQaEQ3RWdpYWdweG9RS1Z0YTB6UGQ2b2c5Y0ZseWFzVFFzZldU?=
 =?utf-8?B?OWNKMDczckZQb2hmTnREeDVDRDhKclMvL3hWN1RhSTQyV2ZkeE5XSUEza3hk?=
 =?utf-8?Q?Ee+5ijGPXbUy/YIIPwgJtQH6W?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 506115f0-5c9c-4280-a372-08dbcea1b402
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 23:43:31.0623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOWDqUjjFJgyoZoxNKNvU5nkXEecEtcUou9VJb9HaYNWTRntbTwXsbpNO1E9OYXN6oTo7oRyVRtpZu9QZbF0og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7637
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/23 16:25, Ira Weiny wrote:
> The following kmemleaks were detected when removing the cxl module
> stack:
> 
> unreferenced object 0xffff88822616b800 (size 1024):
> ...
>   backtrace:
>     [<00000000bedc6f83>] kmalloc_trace+0x26/0x90
>     [<00000000448d1afc>] devm_cxl_pmu_add+0x3a/0x110 [cxl_core]
>     [<00000000ca3bfe16>] 0xffffffffa105213b
>     [<00000000ba7f78dc>] local_pci_probe+0x41/0x90
>     [<000000005bb027ac>] pci_device_probe+0xb0/0x1c0
> ...
> unreferenced object 0xffff8882260abcc0 (size 16):
> ...
>   hex dump (first 16 bytes):
>     70 6d 75 5f 6d 65 6d 30 2e 30 00 26 82 88 ff ff  pmu_mem0.0.&....
>   backtrace:
> ...
>     [<00000000152b5e98>] dev_set_name+0x43/0x50
>     [<00000000c228798b>] devm_cxl_pmu_add+0x102/0x110 [cxl_core]
>     [<00000000ca3bfe16>] 0xffffffffa105213b
>     [<00000000ba7f78dc>] local_pci_probe+0x41/0x90
>     [<000000005bb027ac>] pci_device_probe+0xb0/0x1c0
> ...
> unreferenced object 0xffff8882272af200 (size 256):
> ...
>   backtrace:
>     [<00000000bedc6f83>] kmalloc_trace+0x26/0x90
>     [<00000000a14d1813>] device_add+0x4ea/0x890
>     [<00000000a3f07b47>] devm_cxl_pmu_add+0xbe/0x110 [cxl_core]
>     [<00000000ca3bfe16>] 0xffffffffa105213b
>     [<00000000ba7f78dc>] local_pci_probe+0x41/0x90
>     [<000000005bb027ac>] pci_device_probe+0xb0/0x1c0
> ...
> 
> devm_cxl_pmu_add() correctly registers a device remove function but it
> only calls device_del() which is only part of device unregistration.
> 
> Properly call device_unregister() to free up the memory associated with
> the device.
> 
> Fixes: 1ad3f701c399 ("cxl/pci: Find and register CXL PMU devices")
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Although I wonder if we can just give device_unregister() to devm_add_action_or_reset() directly. 

> ---
>  drivers/cxl/core/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/pmu.c b/drivers/cxl/core/pmu.c
> index 7684c843e5a5..5d8e06b0ba6e 100644
> --- a/drivers/cxl/core/pmu.c
> +++ b/drivers/cxl/core/pmu.c
> @@ -23,7 +23,7 @@ const struct device_type cxl_pmu_type = {
>  
>  static void remove_dev(void *dev)
>  {
> -	device_del(dev);
> +	device_unregister(dev);
>  }
>  
>  int devm_cxl_pmu_add(struct device *parent, struct cxl_pmu_regs *regs,
> 
> ---
> base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
> change-id: 20231016-pmu-unregister-fix-345480926a58
> 
> Best regards,
