Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C427B0AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjI0Qxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0Qxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:53:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA5791
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695833629; x=1727369629;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/AteX624u9Bmn1pK2VFefoVwFL+NAEFVrKrtHZLYNb0=;
  b=Ob9A5psH2bsRhNCu8EiIGbsosdxyyNX/rvB1drgPdoM/7cfOQCTQXx8Z
   IvE7Fqc5WQiWtGWZbCKQ/k1NadAqhRTbUhjWo4ehz/0nezx9Y3QrCdLhf
   Jih8oURYSu0sqDIX4lX4A3WR5V1WYeL0XtIdx/s7g53IP7zWZtLEC5mjt
   B9wN35GZCYImG7XtoTC9qOo02J14/pBuu84RLOifbdI3tdMYmFz8q+vni
   R6KN60l40DTdHcY+TyYqN/dS4SLIIwLYjIjjRFYNyBEWoVRM9seo91Yvl
   oQspilKLyak6Rm2Dj3bpGP60x9vuegwT2FP6N9xQli8xhuG0nkZukFXYV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="380758514"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="380758514"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 09:53:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="814927906"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="814927906"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 09:53:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 09:53:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 09:53:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 09:53:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APTqhS96YiE0biif+7fQzEgPUQVgLkmJuaMa98EL1CpJbLeCBnFuMQNrElTCfyXQgB1/AjIFAsApuzag9p6UUVAEx7fdKgT3n7psIs1jRgdmow+3CbHd5uRqEvv1RS7YAtZkkzMD6glmbVyJMKkjDBqZZVEEsvrORloTkBb9Ce+TF4Ms4dz+PLbA43dfZVIOiEXPsCCeHvWAo8cyd8n5VZ422NikwnF3Z00LC7aPewS1e2Wul+wujJfiyj1drtKEg1YKctyspbIkg/yf2N8KUvguQ2fOc6pW43BgN0v8UcV4xhll2pA8/p//SCpLBL6Lrzxkp2GUYUSJ/a0Q7kyo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcMAn6yMgGxV/WDv0qqpXwDI4VK1mPy/BPk6Dd8RsdY=;
 b=cKGsumiM/Bki8iCID4QaUZ+ya1iIFEd9K/8RtDi1/KHm6jZdR9Bwgaf0Cu+3NG4RdxASkKAMGD50OO0o81phPJFgY/RNPip1xI4vswHC+lLvGUYJlWww2zQvcIO6GYYY7jXEI4WxAGOTW/EEd5qAbJmEb+E3gUustvajuWfAtuSPJR3Nu7EmytPodGKDmt5QeJlNg3alE8zMfZmbZY2yRKrppOKwGkZ+YV1OouYkOrXg5P+9CQiBrMIo1KUorvad7OybkiYaS59rR0trKbCGk30Sg1TSeuwJBWbwzAfEpFkdU/BlVtKJqQBByFTeqMG63mdtq9XJMCT36Ywkyc4cqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5108.namprd11.prod.outlook.com (2603:10b6:303:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 27 Sep
 2023 16:53:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6792.026; Wed, 27 Sep 2023
 16:53:46 +0000
Date:   Wed, 27 Sep 2023 09:53:43 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Peter Gonda <pgonda@google.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-coco@lists.linux.dev>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Erdem Aktas <erdemaktas@google.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 6/6] virt: tdx-guest: Add Quote generation support
 using TSM_REPORTS
Message-ID: <65145e17ad3f0_1236929413@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <169570181657.596431.6178773442587231200.stgit@dwillia2-xfh.jf.intel.com>
 <169570185411.596431.3153227201984845022.stgit@dwillia2-xfh.jf.intel.com>
 <CAMkAt6r2VPPMZ__SQfJse8qWsUyYW3AgYbOUVM0S_Vtk=KvkxQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMkAt6r2VPPMZ__SQfJse8qWsUyYW3AgYbOUVM0S_Vtk=KvkxQ@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0379.namprd04.prod.outlook.com
 (2603:10b6:303:81::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: a00193d4-df59-4dbe-9ed5-08dbbf7a50b7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TAT++i4unwRDiYDMahX+KQEv3M1kHLoZStFa/0g7n2IuAygT9cTI575xNP7v6H0cVcnLmXuEb9O/kVc8Nqr03YYSawHvpRYZjnhrz3IJ5AJtz6zNMvDC7ypmRasivEaE7cKBvRkWEm0QRZoJXPFXo0D2lKyri7UGEfkg0Qq1iBD2JIV2bCJtA3t5hvz9q4APzvA4xYfnT6NwyzP5PcjlyCqREhHdazQqENRJNPa1TNLz1owr+59v7BaUJoWOx5DqUqlSrZEcc3vrb65M7iWCSlQMjl1m4bA04D6GqPJypUhoxx1PwsjKmZMEpvvPEX8nC74Kqp9OfwfkmnLfFxNAtZhOxS3YqOeSzem697pYcVd5fjH+X6pKcaqk+72ku1Ur0vpRPx7Le5cCu/BWWPGSMdhV8EAmgVCdV5sS2GYJ6qRII2TtWeUxXVrwtIev8MC2vKvxLzMSKRsgdSDpjXty9scfJ13kMN1KIYvNzecnbbMJnBT14fvhnOWmpPkb593u+T6t91ZhOX4aDM3/HgnyCUva6ZofiLZYBEiixZvhThU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(186009)(1800799009)(8676002)(38100700002)(86362001)(5660300002)(110136005)(66946007)(66476007)(2906002)(54906003)(4326008)(66556008)(8936002)(966005)(316002)(41300700001)(83380400001)(478600001)(9686003)(6512007)(6486002)(82960400001)(26005)(53546011)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3hBaU1WT0JzQ1BzRWlGcnJVMWxHaVF5QkhHUTNBMzYrdVpPWXJQZ216d1Av?=
 =?utf-8?B?OEpDYnFWcCsxSWFyZjZ3dUhqZzZLQmxvaW5TOHpkRmxYNEM5M1ZodVo0YzZm?=
 =?utf-8?B?QWhxakIweWhXbjhYaGtsaHJzUjEvTjhidFBzOFlHclYwb0JQNGk4dnYzcUVo?=
 =?utf-8?B?Wm51eFFaakVnOGtkR0xyVHl6OU1meWlud1ZhL0lQTDVFRkxXTjVTemdDeU5Q?=
 =?utf-8?B?REJoUCtVQXlEbDVYUFlXLytNK3poRnBqYUg4Zy9aZW5EcStkZzdjaU5LcHkx?=
 =?utf-8?B?SXRJVDI3cUgvc2c0RjEzU3o2amt3S0NZbnQ0dUd2Z2wvYnorQTVCbTZONGF0?=
 =?utf-8?B?UjJTajFCK29mNk82UHV1aFFhRkNya2cvWWUwaFJ2cUJtcEJ5RkM3T2E4UGhp?=
 =?utf-8?B?enRaWDk5dmdURDNyanlsK0szd0VnR2R5c1h6aVM4ZTE2U09SV0pLOEhWM0xi?=
 =?utf-8?B?Y1lTd3VqWXhzOEtWT20zM3I4RENxRkc3TTE0ZG5VRER4TEFtbWpnVVVwMG5N?=
 =?utf-8?B?ZkV6d0E1WUZkVjlmRys3STR5YjhzSkFKSUVRSlV6WFdPaHkvR0pCc2ZLMWJi?=
 =?utf-8?B?Z3BMR1lNdy9wNXFlby95QVAxSlp3QzZBemJHMXVTRmVNV2tKcXgwRGVpVHlx?=
 =?utf-8?B?azFzYUJaWC9OTzdCTWVSQ2QwZklFTjFJTkVLRDZsZUZpd0F3MkgwYmFwbXB5?=
 =?utf-8?B?T0dHR1A3N2Z1aE9pNHU4MTk4RlZManFqYXRjWHJwODcrSHVmam96aTV6dERW?=
 =?utf-8?B?M3NydVZCQ1JUbmdjWWFwQUNDZmhSVFFOaUtqMXljSDkwOXBBQkJTVzRJcnNa?=
 =?utf-8?B?Yi90OVB0T29RRW5QYi9ZN3dGOVhuQ1h6bndBRkg5cUNjWkp0NlZaZkdZWmV5?=
 =?utf-8?B?c3dJbEJ0RTVHMjdmcVRQalhZa3JsUkY5M0pGb2JUWElTOGxxTEVQSGVjMmZL?=
 =?utf-8?B?MUNScnNDaUdyT0s1ek0rL0owWTJTUUhsOFJVN08wV0FML3BZdTk3NDQ5MVpq?=
 =?utf-8?B?K1ZwbTFoYkkxMlczZndTcndkL2lQTFZZK0lXS1FaQXd5ekdNakZCbzR1aTNm?=
 =?utf-8?B?OXhBZWI0UnF0QnNTak53SkNVRnhaeDNqak10WnFGM0M0NUViSG9TU2IvaHpm?=
 =?utf-8?B?NnBQTEs4YXdLQUx4dU5uckF1cGozdUIzL01nSk5zOHg2d1Y5MnBvb2FqVGRt?=
 =?utf-8?B?cldsbHpPNVU3dGZ3Qzg5L3ZiRkcrcnp0ZDBtcXBJYUsxRnpBek5JT1FiTms2?=
 =?utf-8?B?YU9WVytxVytJUHROcEV3aVNUSmdIQnR1STE4SkN5VDJLRDBMcGxXYytsb2VJ?=
 =?utf-8?B?T3Q4K0daRmV3WUxWbWpTZ0xhSnJFeDQ1WWVkSWx5UmZobjBySWorcjhJc05F?=
 =?utf-8?B?Ym5MNnhxSHlpMGcrZktIcGRhbVZteGttLzMyYkEyajcrZjV2N2huK3BYVENw?=
 =?utf-8?B?MVBWY3Blbkdqd1hhRVhuV3ZvNTlpRWxkbTlLWExieFNwWUhKV3I1MkhIRGpO?=
 =?utf-8?B?Um5vRXgrN01RdSs1d0UyOFlMbVNzUUUwUW13UytTRGxVU1loMDF2T0MvVUNQ?=
 =?utf-8?B?M2lsVFBhaDA4QXBtT2NrT1pCS0tFT0VlMnB5Sk4wVktUa2RrNkdPVkQ0emVN?=
 =?utf-8?B?SkhTT3Q0Zk9lRU9VNWlwRWhRekpaR3RQTnlQNGd2VE9PL3p1eXdPRWdjUmNG?=
 =?utf-8?B?VU1ybzUzODdpaGR5SDZFTlBHdnZSSFRMbm9RNDI4R0NxNFJYeEYzM1pHbWdW?=
 =?utf-8?B?My8zeWtPWHk5TGU3d0ZJQXkwejhhUWx6UDMzQndDVkVXMWppT0I2dkxoRXlW?=
 =?utf-8?B?bysyWUFjSzJTbVBvaUgyZmRhS0hCQlRIWlBFYUtkZFpmeDZnU1hITmZWZmtN?=
 =?utf-8?B?bFRLZlZJdFA5TTlWVDNhMHI2d2RscGVweVVKc2lhQnBMMEwrL2hTNHQ3WnBm?=
 =?utf-8?B?clNGTnhTR1EzRWNVVE9TN0xFTXBYd0dxMlc2UFd6YStFRDNMRW9qTzFEUmdi?=
 =?utf-8?B?aldnTDNKZ2dqeC80YzZGNDJXeVZyS0psUDk2T3dxU1l6SEFnK3J1RTZYc0VR?=
 =?utf-8?B?OEJTUm9nRU91YmgveXlnYWthUDhyVzVRQTlOUlFFTE9Lc24rdmxUWUJqdmh2?=
 =?utf-8?B?R0tvaS9VSWlVNWxVdDRsaldtWG0wWEx5VEVvRHVWYURhRm1qdlFtZGQ4Mld4?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a00193d4-df59-4dbe-9ed5-08dbbf7a50b7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 16:53:46.5901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGbAzbqqqODNwfvjEjt+1xRVI6yQUPssvM3Pl1UGtQUGzfSFdoabg5qR9fqNaUU+0sAsxAErJSo3XOaDMlhGBOYolEVDZymGa+hIPpNllGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5108
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Gonda wrote:
> On Mon, Sep 25, 2023 at 10:17 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >
> > In TDX guest, the attestation process is used to verify the TDX guest
> > trustworthiness to other entities before provisioning secrets to the
> > guest. The first step in the attestation process is TDREPORT
> > generation, which involves getting the guest measurement data in the
> > format of TDREPORT, which is further used to validate the authenticity
> > of the TDX guest. TDREPORT by design is integrity-protected and can
> > only be verified on the local machine.
> >
> > To support remote verification of the TDREPORT in a SGX-based
> > attestation, the TDREPORT needs to be sent to the SGX Quoting Enclave
> > (QE) to convert it to a remotely verifiable Quote. SGX QE by design can
> > only run outside of the TDX guest (i.e. in a host process or in a
> > normal VM) and guest can use communication channels like vsock or
> > TCP/IP to send the TDREPORT to the QE. But for security concerns, the
> > TDX guest may not support these communication channels. To handle such
> > cases, TDX defines a GetQuote hypercall which can be used by the guest
> > to request the host VMM to communicate with the SGX QE. More details
> > about GetQuote hypercall can be found in TDX Guest-Host Communication
> > Interface (GHCI) for Intel TDX 1.0, section titled
> > "TDG.VP.VMCALL<GetQuote>".
> >
> > Trusted Security Module (TSM) [1] exposes a common ABI for Confidential
> > Computing Guest platforms to get the measurement data via ConfigFS.
> > Extend the TSM framework and add support to allow an attestation agent
> > to get the TDX Quote data (included usage example below).
> >
> >   report=/sys/kernel/config/tsm/report/report0
> >   mkdir $report
> >   dd if=/dev/urandom bs=64 count=1 > $report/inblob
> >   hexdump -C $report/outblob
> >   rmdir $report
> >
> > GetQuote TDVMCALL requires TD guest pass a 4K aligned shared buffer
> > with TDREPORT data as input, which is further used by the VMM to copy
> > the TD Quote result after successful Quote generation. To create the
> > shared buffer, allocate a large enough memory and mark it shared using
> > set_memory_decrypted() in tdx_guest_init(). This buffer will be re-used
> > for GetQuote requests in the TDX TSM handler.
> >
> > Although this method reserves a fixed chunk of memory for GetQuote
> > requests, such one time allocation can help avoid memory fragmentation
> > related allocation failures later in the uptime of the guest.
> >
> > Since the Quote generation process is not time-critical or frequently
> > used, the current version uses a polling model for Quote requests and
> > it also does not support parallel GetQuote requests.
> >
> > Link: https://lore.kernel.org/lkml/169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com/ [1]
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Reviewed-by: Erdem Aktas <erdemaktas@google.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Hey Dan,
> 
> I tried running your test commands on an SNP enabled guest. To build
> the kernel I just checked out linus/master and applied your series. I
> haven't done any debugging yet, so I will update with what I find.

Ok, not surprised just because I made major changes to the sev-guest interface
and did not have a way to test.

> root@Ubuntu2004:~#   hexdump -C $report/outblob
> [  219.871875] ------------[ cut here ]------------
> [  219.876642] kernel BUG at include/linux/scatterlist.h:187!
> [  219.882280] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [  219.887628] CPU: 0 PID: 1317 Comm: hexdump Not tainted 6.6.0-rc3-xfstests-000
> 44-gf636850ddfc7 #1
> [  219.896530] Hardware name: Google Google Compute Engine/Google Compute Engine

Might you be able to send me info offlist about how I can spin this up so I can
test without waiting for the community to try it out?

In any event, thanks for testing! Appreciate it.
