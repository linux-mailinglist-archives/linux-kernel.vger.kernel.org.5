Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AA778E11B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbjH3VEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbjH3VEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:04:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EF8CE0;
        Wed, 30 Aug 2023 14:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693429409; x=1724965409;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7gYciZ+Y0R3qCoFLLW1Lh4CIFCKOrZtZMtaCmKI6wt8=;
  b=nrFfTGcqAeqXEi1xRqxBEupJ9uy6UTRvH7ku51oGf15WKqpvY+xwZYOc
   kOVwqGLFhCBedElO+b3+r8ogi68l0izxerwzdIbFqXTcTCnxsDy+NT+lS
   ujPO/rUz44CY1XfgE26+ME8CnIVOgHbAVKEXh6pLKaHS5yVn19W75BbP+
   IJmQcAwy+D+9cgDaNtZCqUnIx2sXJFLG72SIaqRYXEfYjt4kWl86R2NSB
   x3veEAheDWrqZDOduuPZIQFyS42BKbGUUIjPcP6aANI5+OTNZ4zSM6zTf
   l+2qkPgIbq8BFPB+6CsWIsZUEhxOg8EzLIzh2dNNfYbONS/7cLACKkl8s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="439698948"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="439698948"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 14:02:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="1069964240"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="1069964240"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2023 14:01:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 14:01:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 14:01:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 14:01:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=La18u/kTPFzc7ptlCN7ppjtQceumUogTttl7YlEYpzOCqId9usFqjJ+nBfOEEl+wdfCcMw3NZajiaZFCzm0t/7eKHcIyfWKKoG4W+DrpIJZBgpLWzUvWxZd3jxgn1tI07lsTvo5cdatLHjM4pKjSJK8TSg6FU03Hqdewkyxbj262zOsZkVjmeSmM99qQzdknpa1RfvKUKxI9pzhsL4ZCPbFmkxMPWhWkECJxT+BIH6ar9cpbdlBd5T2qbxIgw/KcuF4tJQNBznGNHSa8kHSimzJAdmUSYxFphCO3s5DDvPg3wCrX9oVd8Au6FDH1+ez4ig9t4rvKpXGVPNfMa8EMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbL2FIQU4DDFRabiYrEf+T5frd+F9XRoeRaZuNGVeZs=;
 b=Gc/UdgFnPFno+uKmtgaIraBuhNgENF0U8lI6tzf3AEX5OCUcKRyj+Vzl4Dn/0ieZ8l64ASOPn7bgkDWGUVHGfmFUWAtNUKFVT8Sz5F7GSnGmVF0zgbRTh386810BuMgV6zqoVpvvIYI2cQ8jGHxQEOF5QtdJ6lX11i4yHhCQRtXnDHo3X6GENh7ttmQdc1MCPePF5z1tZUjOYTI79aRbBroYFykU49KiHYuQvh7BYTeQcoquSL7EH/+9wLw6aWPQ3bGPTj7FoNNe/fH9DPmyZJs+DKMH+vSu/Ft4jl5r+uG9NF0qiUvaIQY/UAONTD4QSbnzwg+YWMeEQpgbXWCj3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by MW4PR11MB5799.namprd11.prod.outlook.com (2603:10b6:303:181::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 21:01:51 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 21:01:51 +0000
Message-ID: <db3bd5d0-640a-b121-f3e7-cfb73dc6c9ff@intel.com>
Date:   Wed, 30 Aug 2023 14:01:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH RFC v2 03/18] cxl/mem: Read Dynamic capacity configuration
 from the device
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-3-f740c47e7916@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-3-f740c47e7916@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::27) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|MW4PR11MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: b3bfece0-6c42-4493-bf08-08dba99c5546
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 43s1gX6X3AC/2a0GQKoCI1NJP+VNIKDvjQjQLO+XhW74SHYP/4nsoQ45wJ0JNtyQSYCumuwtlAo/Iw0fpD4BzBIHqe9HxM4TlJfWwxUZ0bIl1x2z0EBL9J5h06AZXfU18nY78aUpbDAk9W5MbQnDQO+AiL2QaU0GJ8MA/I2p+SXXI35Oy3sdG4jknSQd0Q8CZysxgIMg7dlOKJpsBgCHT/szWX1Hk7FVuiIkNA4mA4xLrwpPu9svHoVFSUZzoARYK0Zdhhgs9ym9CNg5xl507WXpmoFVROW+mpPfOZmFCCEDojB7aL2xVuWgqQyysmIy7xxPpqt7mKUGqT3d0Tbp/RUggHLJTmQes8Gdv0oyvpmnaYOShAlvqSRLz9vsczn6dji58V5r72XtdKB7bSlYp5VdnnFVaiQZIk7XH/UzpOOHKc8lvvrRwx90bXkLvEKlpvvv9d0fgMIGNPYySauvc6QH1QO6pe9Hv0Ol/yu4FY0BfkVl/f29Weg4hdLRh7tp5z9Z+QmYgjDgppeFPXXpwpiE8KCsDBFYqOVBmtfAL8pRNXfPcFcMdGWX/32rsx3LN4heABahTqoucOumhZSfGxNCpfCoVa84nK83Kgwau6FUOLKqz3kg1Q9AflWI0nkTuTxjhb5PtHTqEgaSHOQlspDHt/xZmahjPSgomnTkBm5VWao1Nq1+aLLROuRJoNfg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(1800799009)(451199024)(186009)(31686004)(6512007)(6666004)(6486002)(6506007)(86362001)(36756003)(38100700002)(31696002)(82960400001)(2616005)(478600001)(30864003)(83380400001)(53546011)(26005)(4326008)(8936002)(54906003)(5660300002)(66476007)(66946007)(44832011)(2906002)(6862004)(6636002)(41300700001)(37006003)(66556008)(8676002)(316002)(461764006)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU8wQ2prZzllTXozL1REaVd1S0N1WjBUSVlxV252REk5SXRTVmpCMGtXTUJ6?=
 =?utf-8?B?azZXMWtYSGozVzVKVmZVbVpzbmxXVnlOdk1aSkRqUTkzZHdmYlNwL1dBbWN4?=
 =?utf-8?B?YXFSMG8wNlY5SjJZSjBoZm9jL0Y0TWNaQm16ZEtTcGc4SkRlcVc2Y0dEejRp?=
 =?utf-8?B?SEZMVGhNeTBIZWZtSVpBcE9hZ29MSlgxT0JCaWpkWHZLMUhvRXg0RXR3b1Bx?=
 =?utf-8?B?Snk0NmFDL2w4VGgvSmJXazQyN2tnM3NGQXlVT1Zuek9nMGc3OUVDTDZtd1pM?=
 =?utf-8?B?RFlYSTZoZWlJeGRmWWxZQzhidm9JemN1aVE1OFoxVjBiQnpSRHN2V3BTWmJp?=
 =?utf-8?B?d1FJYmVHaisrMW1pWk90S21FUG9MTnNlRUtjellxcGN3WWhaQitvWHZrNC9t?=
 =?utf-8?B?aXpRbmpqSmJFbkFLMGc0SjdudWNka203NUNoRURyS2lKRXRsZEcxSHZTMGoz?=
 =?utf-8?B?Y3VSZHVxbXFlWG1DdmJhbjBkYkVta3dTSUZJTFdxbmhYcmoyOGdkZE9RRytE?=
 =?utf-8?B?ajZuc3E5YVQ1Sm1obkdsdWxackM4SkNkYjRSWmRreHlMaVFNZHA3Z2FyeUp5?=
 =?utf-8?B?L1FYR0VKblMzbzlwanIrWURUMFF0Nmg5eXRTYnA5NzF5RjA0WGp0UUFWaTU3?=
 =?utf-8?B?cmZwMHBmSTVmTU9SUUh1aDQxVWdlNnlBU3BuYVVQNlFxYmF4Q2dmVEJUZXhL?=
 =?utf-8?B?NDVmZXNEWmExY05PUmFEVnA0dFM4SWgyM1o0YUtsZkhGNmFmeFd5SFBPdHIv?=
 =?utf-8?B?Q29GZi93ZHVuYTNpL2N6d0JHck9JS2RFbyszc3d5cU9oM3RIR0RsNUduSThX?=
 =?utf-8?B?ejBmOURyWmtWd0o1SEZqWTdUM0lFSkQ1YUtGN3FtVVN2ejNMZGgzcVlBUFp4?=
 =?utf-8?B?VjhZTG9TQkY1M3BxdEhjVWUwUkUrN3pFNGxjV092TkJGRS9jV3hNWnRldTRo?=
 =?utf-8?B?a2FyK0hIUWQwMkZmdDJrUzcwY1c0MjNsVmpvTTZxRG5ONVFIWDB4eHA1VjIw?=
 =?utf-8?B?cGdyWTY5QWxacXNnOHk0dkZsaXNxSlZRNDY5ZTlTTkpjdTlnOGhOUENaNysv?=
 =?utf-8?B?QXd5cGFmUmp1eFJnNExIK0FJckZEejdodm5hQy8zbGNLYVlHcm9ySnJIemxn?=
 =?utf-8?B?clZlNUZQY3pVOVdXU0ZhL3FSOUZUMEo0Tm95U0MwV0ZjT1NHbTJlMllvQ1NE?=
 =?utf-8?B?ZVpRSXVQZ3RPVlY4M1NwTDRpbmk2Z1Z1WlVVMm5RRG56VHN4UG9Ocmw5OHY4?=
 =?utf-8?B?VW9LdC81OFE1TUtMNzVEdHVvVTZua28rNUVuVThBQzAzaGI1eHhGM3Z4MkFq?=
 =?utf-8?B?WlQ2SlVURUZuMWM3R1FKTzRBeVQvSGNYMm9PM0dFOWFvUnZsN2t3NmoxeDlH?=
 =?utf-8?B?MFRnSHB0bEpLQnprMUYxY1RCdUFReVVPZlFEczNNY3VScFg2YkpPS0VBVXBT?=
 =?utf-8?B?RlV6OGxKemY2T0lENlRCL2VMNnhHNVpmYko1d1hPTjJOb3p4M3dScWUySExE?=
 =?utf-8?B?Vm5KVFJvMzJzcDYrSVZPa3UweWFoZ25mSWJiZE8rVC96a0R1VHlrc3c4djVa?=
 =?utf-8?B?WnZQWGNKeWlLQ1JzL0VBQmpuSnBWU01wbFU4RmpkdzN2MFdhcGNuWWlpR2x3?=
 =?utf-8?B?UlE5dFZrM2NwNStDMXhkN1F1M2ZCMWJJK3FPaG5ySnFzYk5nMEp6U0hGVFd3?=
 =?utf-8?B?YzRKajRHYlcybmhNYXVHcysraDRkWERCaVkwVWFjNFZrOXpnRUxGRUJtUjgw?=
 =?utf-8?B?MXdHcjFzdXBCZjZ6bGZsLzhZeDhFbnBCWVpqZjl4cm93a3V1Y2NUMGpGMFVu?=
 =?utf-8?B?YWxIVkYySnorZEtmMjRuVmxFSDFEREJLR1R2VzFoRUR2TE8rbS9taVhBd2hV?=
 =?utf-8?B?SkNLNW1xVHYveXVHb1pOWG5XaEtIRUttc3l0bnAzQkl0NEJSSU93TEM2aGha?=
 =?utf-8?B?eTFhdjRGUGR2VkxSb3VudUNndGZ4a0NxQnBjUEtMSW5vUkRMVCt2c0F6VEJw?=
 =?utf-8?B?K21xTVNQenF5OGlvdnVDaWJ6aVNDTEZ3R3JMZS9ZTFBZbFo3YUE1cFpKbjRT?=
 =?utf-8?B?VHlNRi94dVN2VThaOHM5ZDE2NysxcnljKzVuN2x5Mkt5UnBLQ2RBVlZUMjhS?=
 =?utf-8?B?alA5bnVlTXcyUzgrMVdRQTBQclQzUUZESEtwU1oySXNjQ2NZdjExZm1ocWFy?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bfece0-6c42-4493-bf08-08dba99c5546
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 21:01:51.5437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFneUot/6Mr6uDFv3YEIkg7ZH8ZDDpekL+sl3KlJaIm29S0uJSLg4DPnnlXP79E9l0ECJ7EwalEaOAmpaqU14A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5799
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/23 22:20, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Devices can optionally support Dynamic Capacity (DC).  These devices are
> known as Dynamic Capacity Devices (DCD).
> 
> Implement the DC (opcode 48XXh) mailbox commands as specified in CXL 3.0
> section 8.2.9.8.9.  Read the DC configuration and store the DC region
> information in the device state.
> 
> Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Uncapitalize Dynamic in subject

Also, maybe split out the REGION vs DECODER as a prep patch.

DJ

> 
> ---
> Changes for v2
> [iweiny: Rebased to latest master type2 work]
> [jonathan: s/dc/dc_resp/]
> [iweiny: Clean up commit message]
> [iweiny: Clean kernel docs]
> [djiang: Fix up cxl_is_dcd_command]
> [djiang: extra blank line]
> [alison: s/total_capacity/cap/ etc...]
> [alison: keep partition flag with partition structures]
> [alison: reformat untenanted_mem declaration]
> [alison: move 'cmd' definition back]
> [alison: fix comment line length]
> [alison: reverse x-tree]
> [jonathan: fix and adjust CXL_DC_REGION_STRLEN]
> [Jonathan/iweiny: Factor out storing each DC region read from the device]
> [Jonathan: place all dcr initializers together]
> [Jonathan/iweiny: flip around the region DPA order check]
> [jonathan: Account for short read of mailbox command]
> [iweiny: use snprintf for region name]
> [iweiny: use '<nil>' for missing region names]
> [iweiny: factor out struct cxl_dc_region_info]
> [iweiny: Split out reading CEL]
> ---
>   drivers/cxl/core/mbox.c   | 179 +++++++++++++++++++++++++++++++++++++++++++++-
>   drivers/cxl/core/region.c |  75 +++++++++++++------
>   drivers/cxl/cxl.h         |  27 ++++++-
>   drivers/cxl/cxlmem.h      |  55 +++++++++++++-
>   drivers/cxl/pci.c         |   4 ++
>   5 files changed, 314 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 554ec97a7c39..d769814f80e2 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1096,7 +1096,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
>   	if (rc < 0)
>   		return rc;
>   
> -	mds->total_bytes =
> +	mds->static_cap =
>   		le64_to_cpu(id.total_capacity) * CXL_CAPACITY_MULTIPLIER;
>   	mds->volatile_only_bytes =
>   		le64_to_cpu(id.volatile_capacity) * CXL_CAPACITY_MULTIPLIER;
> @@ -1114,6 +1114,8 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
>   		mds->poison.max_errors = min_t(u32, val, CXL_POISON_LIST_MAX);
>   	}
>   
> +	mds->dc_event_log_size = le16_to_cpu(id.dc_event_log_size);
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
> @@ -1178,6 +1180,165 @@ int cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd)
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_mem_sanitize, CXL);
>   
> +static int cxl_dc_save_region_info(struct cxl_memdev_state *mds, int index,
> +				   struct cxl_dc_region_config *region_config)
> +{
> +	struct cxl_dc_region_info *dcr = &mds->dc_region[index];
> +	struct device *dev = mds->cxlds.dev;
> +
> +	dcr->base = le64_to_cpu(region_config->region_base);
> +	dcr->decode_len = le64_to_cpu(region_config->region_decode_length);
> +	dcr->decode_len *= CXL_CAPACITY_MULTIPLIER;
> +	dcr->len = le64_to_cpu(region_config->region_length);
> +	dcr->blk_size = le64_to_cpu(region_config->region_block_size);
> +	dcr->dsmad_handle = le32_to_cpu(region_config->region_dsmad_handle);
> +	dcr->flags = region_config->flags;
> +	snprintf(dcr->name, CXL_DC_REGION_STRLEN, "dc%d", index);
> +
> +	/* Check regions are in increasing DPA order */
> +	if (index > 0) {
> +		struct cxl_dc_region_info *prev_dcr = &mds->dc_region[index - 1];
> +
> +		if ((prev_dcr->base + prev_dcr->decode_len) > dcr->base) {
> +			dev_err(dev,
> +				"DPA ordering violation for DC region %d and %d\n",
> +				index - 1, index);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/* Check the region is 256 MB aligned */
> +	if (!IS_ALIGNED(dcr->base, SZ_256M)) {
> +		dev_err(dev, "DC region %d not aligned to 256MB: %#llx\n",
> +			index, dcr->base);
> +		return -EINVAL;
> +	}
> +
> +	/* Check Region base and length are aligned to block size */
> +	if (!IS_ALIGNED(dcr->base, dcr->blk_size) ||
> +	    !IS_ALIGNED(dcr->len, dcr->blk_size)) {
> +		dev_err(dev, "DC region %d not aligned to %#llx\n", index,
> +			dcr->blk_size);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev,
> +		"DC region %s DPA: %#llx LEN: %#llx BLKSZ: %#llx\n",
> +		dcr->name, dcr->base, dcr->decode_len, dcr->blk_size);
> +
> +	return 0;
> +}
> +
> +/* Returns the number of regions in dc_resp or -ERRNO */
> +static int cxl_get_dc_id(struct cxl_memdev_state *mds, u8 start_region,
> +			 struct cxl_mbox_dynamic_capacity *dc_resp,
> +			 size_t dc_resp_size)
> +{
> +	struct cxl_mbox_get_dc_config get_dc = (struct cxl_mbox_get_dc_config) {
> +		.region_count = CXL_MAX_DC_REGION,
> +		.start_region_index = start_region,
> +	};
> +	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_DC_CONFIG,
> +		.payload_in = &get_dc,
> +		.size_in = sizeof(get_dc),
> +		.size_out = dc_resp_size,
> +		.payload_out = dc_resp,
> +		.min_out = 1,
> +	};
> +	struct device *dev = mds->cxlds.dev;
> +	int rc;
> +
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = dc_resp->avail_region_count - start_region;
> +
> +	/*
> +	 * The number of regions in the payload may have been truncated due to
> +	 * payload_size limits; if so adjust the count in this query.
> +	 */
> +	if (mbox_cmd.size_out < sizeof(*dc_resp))
> +		rc = CXL_REGIONS_RETURNED(mbox_cmd.size_out);
> +
> +	dev_dbg(dev, "Read %d/%d DC regions\n", rc, dc_resp->avail_region_count);
> +
> +	return rc;
> +}
> +
> +/**
> + * cxl_dev_dynamic_capacity_identify() - Reads the dynamic capacity
> + *					 information from the device.
> + * @mds: The memory device state
> + *
> + * This will dispatch the get_dynamic_capacity command to the device
> + * and on success populate structures to be exported to sysfs.
> + *
> + * Return: 0 if identify was executed successfully, -ERRNO on error.
> + */
> +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
> +{
> +	struct cxl_mbox_dynamic_capacity *dc_resp;
> +	struct device *dev = mds->cxlds.dev;
> +	size_t dc_resp_size = mds->payload_size;
> +	u8 start_region;
> +	int i, rc = 0;
> +
> +	for (i = 0; i < CXL_MAX_DC_REGION; i++)
> +		snprintf(mds->dc_region[i].name, CXL_DC_REGION_STRLEN, "<nil>");
> +
> +	/* Check GET_DC_CONFIG is supported by device */
> +	if (!test_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds)) {
> +		dev_dbg(dev, "unsupported cmd: get_dynamic_capacity_config\n");
> +		return 0;
> +	}
> +
> +	dc_resp = kvmalloc(dc_resp_size, GFP_KERNEL);
> +	if (!dc_resp)
> +		return -ENOMEM;
> +
> +	start_region = 0;
> +	do {
> +		int j;
> +
> +		rc = cxl_get_dc_id(mds, start_region, dc_resp, dc_resp_size);
> +		if (rc < 0)
> +			goto free_resp;
> +
> +		mds->nr_dc_region += rc;
> +
> +		if (mds->nr_dc_region < 1 || mds->nr_dc_region > CXL_MAX_DC_REGION) {
> +			dev_err(dev, "Invalid num of dynamic capacity regions %d\n",
> +				mds->nr_dc_region);
> +			rc = -EINVAL;
> +			goto free_resp;
> +		}
> +
> +		for (i = start_region, j = 0; i < mds->nr_dc_region; i++, j++) {
> +			rc = cxl_dc_save_region_info(mds, i, &dc_resp->region[j]);
> +			if (rc)
> +				goto free_resp;
> +		}
> +
> +		start_region = mds->nr_dc_region;
> +
> +	} while (mds->nr_dc_region < dc_resp->avail_region_count);
> +
> +	mds->dynamic_cap =
> +		mds->dc_region[mds->nr_dc_region - 1].base +
> +		mds->dc_region[mds->nr_dc_region - 1].decode_len -
> +		mds->dc_region[0].base;
> +	dev_dbg(dev, "Total dynamic capacity: %#llx\n", mds->dynamic_cap);
> +
> +free_resp:
> +	kfree(dc_resp);
> +	if (rc)
> +		dev_err(dev, "Failed to get DC info: %d\n", rc);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
> +
>   static int add_dpa_res(struct device *dev, struct resource *parent,
>   		       struct resource *res, resource_size_t start,
>   		       resource_size_t size, const char *type)
> @@ -1208,8 +1369,12 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>   {
>   	struct cxl_dev_state *cxlds = &mds->cxlds;
>   	struct device *dev = cxlds->dev;
> +	size_t untenanted_mem;
>   	int rc;
>   
> +	untenanted_mem = mds->dc_region[0].base - mds->static_cap;
> +	mds->total_bytes = mds->static_cap + untenanted_mem + mds->dynamic_cap;
> +
>   	if (!cxlds->media_ready) {
>   		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
>   		cxlds->ram_res = DEFINE_RES_MEM(0, 0);
> @@ -1217,8 +1382,16 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>   		return 0;
>   	}
>   
> -	cxlds->dpa_res =
> -		(struct resource)DEFINE_RES_MEM(0, mds->total_bytes);
> +	cxlds->dpa_res = (struct resource)DEFINE_RES_MEM(0, mds->total_bytes);
> +
> +	for (int i = 0; i < mds->nr_dc_region; i++) {
> +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> +
> +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->dc_res[i],
> +				 dcr->base, dcr->decode_len, dcr->name);
> +		if (rc)
> +			return rc;
> +	}
>   
>   	if (mds->partition_align_bytes == 0) {
>   		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 252bc8e1f103..75041903b72c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -46,7 +46,7 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
>   	rc = down_read_interruptible(&cxl_region_rwsem);
>   	if (rc)
>   		return rc;
> -	if (cxlr->mode != CXL_DECODER_PMEM)
> +	if (cxlr->mode != CXL_REGION_PMEM)
>   		rc = sysfs_emit(buf, "\n");
>   	else
>   		rc = sysfs_emit(buf, "%pUb\n", &p->uuid);
> @@ -359,7 +359,7 @@ static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
>   	 * Support tooling that expects to find a 'uuid' attribute for all
>   	 * regions regardless of mode.
>   	 */
> -	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_DECODER_PMEM)
> +	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_REGION_PMEM)
>   		return 0444;
>   	return a->mode;
>   }
> @@ -537,7 +537,7 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
>   {
>   	struct cxl_region *cxlr = to_cxl_region(dev);
>   
> -	return sysfs_emit(buf, "%s\n", cxl_decoder_mode_name(cxlr->mode));
> +	return sysfs_emit(buf, "%s\n", cxl_region_mode_name(cxlr->mode));
>   }
>   static DEVICE_ATTR_RO(mode);
>   
> @@ -563,7 +563,7 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>   
>   	/* ways, granularity and uuid (if PMEM) need to be set before HPA */
>   	if (!p->interleave_ways || !p->interleave_granularity ||
> -	    (cxlr->mode == CXL_DECODER_PMEM && uuid_is_null(&p->uuid)))
> +	    (cxlr->mode == CXL_REGION_PMEM && uuid_is_null(&p->uuid)))
>   		return -ENXIO;
>   
>   	div_u64_rem(size, SZ_256M * p->interleave_ways, &remainder);
> @@ -1765,6 +1765,17 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>   	return rc;
>   }
>   
> +static bool cxl_modes_compatible(enum cxl_region_mode rmode,
> +				 enum cxl_decoder_mode dmode)
> +{
> +	if (rmode == CXL_REGION_RAM && dmode == CXL_DECODER_RAM)
> +		return true;
> +	if (rmode == CXL_REGION_PMEM && dmode == CXL_DECODER_PMEM)
> +		return true;
> +
> +	return false;
> +}
> +
>   static int cxl_region_attach(struct cxl_region *cxlr,
>   			     struct cxl_endpoint_decoder *cxled, int pos)
>   {
> @@ -1778,9 +1789,11 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>   	lockdep_assert_held_write(&cxl_region_rwsem);
>   	lockdep_assert_held_read(&cxl_dpa_rwsem);
>   
> -	if (cxled->mode != cxlr->mode) {
> -		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
> -			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
> +	if (!cxl_modes_compatible(cxlr->mode, cxled->mode)) {
> +		dev_dbg(&cxlr->dev, "%s region mode: %s mismatch decoder: %s\n",
> +			dev_name(&cxled->cxld.dev),
> +			cxl_region_mode_name(cxlr->mode),
> +			cxl_decoder_mode_name(cxled->mode));
>   		return -EINVAL;
>   	}
>   
> @@ -2234,7 +2247,7 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
>    * devm_cxl_add_region - Adds a region to a decoder
>    * @cxlrd: root decoder
>    * @id: memregion id to create, or memregion_free() on failure
> - * @mode: mode for the endpoint decoders of this region
> + * @mode: mode of this region
>    * @type: select whether this is an expander or accelerator (type-2 or type-3)
>    *
>    * This is the second step of region initialization. Regions exist within an
> @@ -2245,7 +2258,7 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
>    */
>   static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>   					      int id,
> -					      enum cxl_decoder_mode mode,
> +					      enum cxl_region_mode mode,
>   					      enum cxl_decoder_type type)
>   {
>   	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
> @@ -2254,11 +2267,12 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>   	int rc;
>   
>   	switch (mode) {
> -	case CXL_DECODER_RAM:
> -	case CXL_DECODER_PMEM:
> +	case CXL_REGION_RAM:
> +	case CXL_REGION_PMEM:
>   		break;
>   	default:
> -		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
> +		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %s\n",
> +			cxl_region_mode_name(mode));
>   		return ERR_PTR(-EINVAL);
>   	}
>   
> @@ -2308,7 +2322,7 @@ static ssize_t create_ram_region_show(struct device *dev,
>   }
>   
>   static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
> -					  int id, enum cxl_decoder_mode mode,
> +					  int id, enum cxl_region_mode mode,
>   					  enum cxl_decoder_type type)
>   {
>   	int rc;
> @@ -2337,7 +2351,7 @@ static ssize_t create_pmem_region_store(struct device *dev,
>   	if (rc != 1)
>   		return -EINVAL;
>   
> -	cxlr = __create_region(cxlrd, id, CXL_DECODER_PMEM,
> +	cxlr = __create_region(cxlrd, id, CXL_REGION_PMEM,
>   			       CXL_DECODER_HOSTONLYMEM);
>   	if (IS_ERR(cxlr))
>   		return PTR_ERR(cxlr);
> @@ -2358,7 +2372,7 @@ static ssize_t create_ram_region_store(struct device *dev,
>   	if (rc != 1)
>   		return -EINVAL;
>   
> -	cxlr = __create_region(cxlrd, id, CXL_DECODER_RAM,
> +	cxlr = __create_region(cxlrd, id, CXL_REGION_RAM,
>   			       CXL_DECODER_HOSTONLYMEM);
>   	if (IS_ERR(cxlr))
>   		return PTR_ERR(cxlr);
> @@ -2886,10 +2900,31 @@ static void construct_region_end(void)
>   	up_write(&cxl_region_rwsem);
>   }
>   
> +static enum cxl_region_mode
> +cxl_decoder_to_region_mode(enum cxl_decoder_mode mode)
> +{
> +	switch (mode) {
> +	case CXL_DECODER_NONE:
> +		return CXL_REGION_NONE;
> +	case CXL_DECODER_RAM:
> +		return CXL_REGION_RAM;
> +	case CXL_DECODER_PMEM:
> +		return CXL_REGION_PMEM;
> +	case CXL_DECODER_DEAD:
> +		return CXL_REGION_DEAD;
> +	case CXL_DECODER_MIXED:
> +	default:
> +		return CXL_REGION_MIXED;
> +	}
> +
> +	return CXL_REGION_MIXED;
> +}
> +
>   static struct cxl_region *
>   construct_region_begin(struct cxl_root_decoder *cxlrd,
>   		       struct cxl_endpoint_decoder *cxled)
>   {
> +	enum cxl_region_mode mode = cxl_decoder_to_region_mode(cxled->mode);
>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>   	struct cxl_region_params *p;
>   	struct cxl_region *cxlr;
> @@ -2897,7 +2932,7 @@ construct_region_begin(struct cxl_root_decoder *cxlrd,
>   
>   	do {
>   		cxlr = __create_region(cxlrd, atomic_read(&cxlrd->region_id),
> -				       cxled->mode, cxled->cxld.target_type);
> +				       mode, cxled->cxld.target_type);
>   	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>   
>   	if (IS_ERR(cxlr)) {
> @@ -3200,9 +3235,9 @@ static int cxl_region_probe(struct device *dev)
>   		return rc;
>   
>   	switch (cxlr->mode) {
> -	case CXL_DECODER_PMEM:
> +	case CXL_REGION_PMEM:
>   		return devm_cxl_add_pmem_region(cxlr);
> -	case CXL_DECODER_RAM:
> +	case CXL_REGION_RAM:
>   		/*
>   		 * The region can not be manged by CXL if any portion of
>   		 * it is already online as 'System RAM'
> @@ -3223,8 +3258,8 @@ static int cxl_region_probe(struct device *dev)
>   		/* HDM-H routes to device-dax */
>   		return devm_cxl_add_dax_region(cxlr);
>   	default:
> -		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
> -			cxlr->mode);
> +		dev_dbg(&cxlr->dev, "unsupported region mode: %s\n",
> +			cxl_region_mode_name(cxlr->mode));
>   		return -ENXIO;
>   	}
>   }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index cd4a9ffdacc7..ed282dcd5cf5 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -374,6 +374,28 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
>   	return "mixed";
>   }
>   
> +enum cxl_region_mode {
> +	CXL_REGION_NONE,
> +	CXL_REGION_RAM,
> +	CXL_REGION_PMEM,
> +	CXL_REGION_MIXED,
> +	CXL_REGION_DEAD,
> +};
> +
> +static inline const char *cxl_region_mode_name(enum cxl_region_mode mode)
> +{
> +	static const char * const names[] = {
> +		[CXL_REGION_NONE] = "none",
> +		[CXL_REGION_RAM] = "ram",
> +		[CXL_REGION_PMEM] = "pmem",
> +		[CXL_REGION_MIXED] = "mixed",
> +	};
> +
> +	if (mode >= CXL_REGION_NONE && mode <= CXL_REGION_MIXED)
> +		return names[mode];
> +	return "mixed";
> +}
> +
>   /*
>    * Track whether this decoder is reserved for region autodiscovery, or
>    * free for userspace provisioning.
> @@ -502,7 +524,8 @@ struct cxl_region_params {
>    * struct cxl_region - CXL region
>    * @dev: This region's device
>    * @id: This region's id. Id is globally unique across all regions
> - * @mode: Endpoint decoder allocation / access mode
> + * @mode: Region mode which defines which endpoint decoder mode the region is
> + *        compatible with
>    * @type: Endpoint decoder target type
>    * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
>    * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
> @@ -512,7 +535,7 @@ struct cxl_region_params {
>   struct cxl_region {
>   	struct device dev;
>   	int id;
> -	enum cxl_decoder_mode mode;
> +	enum cxl_region_mode mode;
>   	enum cxl_decoder_type type;
>   	struct cxl_nvdimm_bridge *cxl_nvb;
>   	struct cxl_pmem_region *cxlr_pmem;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 5f2e65204bf9..8c8f47b397ab 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -396,6 +396,7 @@ enum cxl_devtype {
>   	CXL_DEVTYPE_CLASSMEM,
>   };
>   
> +#define CXL_MAX_DC_REGION 8
>   /**
>    * struct cxl_dev_state - The driver device state
>    *
> @@ -412,6 +413,8 @@ enum cxl_devtype {
>    * @dpa_res: Overall DPA resource tree for the device
>    * @pmem_res: Active Persistent memory capacity configuration
>    * @ram_res: Active Volatile memory capacity configuration
> + * @dc_res: Active Dynamic Capacity memory configuration for each possible
> + *          region
>    * @component_reg_phys: register base of component registers
>    * @serial: PCIe Device Serial Number
>    * @type: Generic Memory Class device or Vendor Specific Memory device
> @@ -426,11 +429,23 @@ struct cxl_dev_state {
>   	struct resource dpa_res;
>   	struct resource pmem_res;
>   	struct resource ram_res;
> +	struct resource dc_res[CXL_MAX_DC_REGION];
>   	resource_size_t component_reg_phys;
>   	u64 serial;
>   	enum cxl_devtype type;
>   };
>   
> +#define CXL_DC_REGION_STRLEN 7
> +struct cxl_dc_region_info {
> +	u64 base;
> +	u64 decode_len;
> +	u64 len;
> +	u64 blk_size;
> +	u32 dsmad_handle;
> +	u8 flags;
> +	u8 name[CXL_DC_REGION_STRLEN];
> +};
> +
>   /**
>    * struct cxl_memdev_state - Generic Type-3 Memory Device Class driver data
>    *
> @@ -449,6 +464,8 @@ struct cxl_dev_state {
>    * @enabled_cmds: Hardware commands found enabled in CEL.
>    * @exclusive_cmds: Commands that are kernel-internal only
>    * @total_bytes: sum of all possible capacities
> + * @static_cap: Sum of RAM and PMEM capacities
> + * @dynamic_cap: Complete DPA range occupied by DC regions
>    * @volatile_only_bytes: hard volatile capacity
>    * @persistent_only_bytes: hard persistent capacity
>    * @partition_align_bytes: alignment size for partition-able capacity
> @@ -456,6 +473,10 @@ struct cxl_dev_state {
>    * @active_persistent_bytes: sum of hard + soft persistent
>    * @next_volatile_bytes: volatile capacity change pending device reset
>    * @next_persistent_bytes: persistent capacity change pending device reset
> + * @nr_dc_region: number of DC regions implemented in the memory device
> + * @dc_region: array containing info about the DC regions
> + * @dc_event_log_size: The number of events the device can store in the
> + * Dynamic Capacity Event Log before it overflows
>    * @event: event log driver state
>    * @poison: poison driver state info
>    * @fw: firmware upload / activation state
> @@ -473,7 +494,10 @@ struct cxl_memdev_state {
>   	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
>   	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>   	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> +
>   	u64 total_bytes;
> +	u64 static_cap;
> +	u64 dynamic_cap;
>   	u64 volatile_only_bytes;
>   	u64 persistent_only_bytes;
>   	u64 partition_align_bytes;
> @@ -481,6 +505,11 @@ struct cxl_memdev_state {
>   	u64 active_persistent_bytes;
>   	u64 next_volatile_bytes;
>   	u64 next_persistent_bytes;
> +
> +	u8 nr_dc_region;
> +	struct cxl_dc_region_info dc_region[CXL_MAX_DC_REGION];
> +	size_t dc_event_log_size;
> +
>   	struct cxl_event_state event;
>   	struct cxl_poison_state poison;
>   	struct cxl_security_state security;
> @@ -587,6 +616,7 @@ struct cxl_mbox_identify {
>   	__le16 inject_poison_limit;
>   	u8 poison_caps;
>   	u8 qos_telemetry_caps;
> +	__le16 dc_event_log_size;
>   } __packed;
>   
>   /*
> @@ -741,9 +771,31 @@ struct cxl_mbox_set_partition_info {
>   	__le64 volatile_capacity;
>   	u8 flags;
>   } __packed;
> -
>   #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
>   
> +struct cxl_mbox_get_dc_config {
> +	u8 region_count;
> +	u8 start_region_index;
> +} __packed;
> +
> +/* See CXL 3.0 Table 125 get dynamic capacity config Output Payload */
> +struct cxl_mbox_dynamic_capacity {
> +	u8 avail_region_count;
> +	u8 rsvd[7];
> +	struct cxl_dc_region_config {
> +		__le64 region_base;
> +		__le64 region_decode_length;
> +		__le64 region_length;
> +		__le64 region_block_size;
> +		__le32 region_dsmad_handle;
> +		u8 flags;
> +		u8 rsvd[3];
> +	} __packed region[];
> +} __packed;
> +#define CXL_DYNAMIC_CAPACITY_SANITIZE_ON_RELEASE_FLAG BIT(0)
> +#define CXL_REGIONS_RETURNED(size_out) \
> +	((size_out - 8) / sizeof(struct cxl_dc_region_config))
> +
>   /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
>   struct cxl_mbox_set_timestamp_in {
>   	__le64 timestamp;
> @@ -867,6 +919,7 @@ enum {
>   int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
>   			  struct cxl_mbox_cmd *cmd);
>   int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds);
>   int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>   int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>   int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 5242dbf0044d..a9b110ff1176 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -879,6 +879,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (rc)
>   		return rc;
>   
> +	rc = cxl_dev_dynamic_capacity_identify(mds);
> +	if (rc)
> +		return rc;
> +
>   	rc = cxl_mem_create_range_info(mds);
>   	if (rc)
>   		return rc;
> 
