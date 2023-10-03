Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0657B734F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjJCV3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjJCV3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:29:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4580E83
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696368570; x=1727904570;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XKXRemZWRIGbHyFjUpOUyoQZt7f2JegXTA0FZb+NWMM=;
  b=GkjyJPFD0Sq0GyIy/uY4JMZLIlDwr5fVbTPBbYajzR+vEGFtJRLfsbzA
   QrhcaL0AAcGIZA/2h+OFQMV5qqBAy9sIFUckxASofZUuFeNCpLoMREJd3
   LSceO58ME+V8mxm5j9KmNA9Gl58anXSY+DcTsp0a46n5NnakECG4K7XPa
   esVsXc+H4Bu3yquA1hWn7vUZkLpCLzOalmW5urIdgHbWOOLGHhrd+v0rJ
   pNz7Ww8BRb7AYxEfp1eFpU8CTqsR2Jek3yBEOtf2d3C61Qm5/kuHJJDkE
   Grh0STLNsyq/FMM7nIePGySX3SITS1pu5P/6FgVwpecjx7TJynOMk2GEz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="381856297"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="381856297"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:28:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="751042905"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="751042905"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:28:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:28:56 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:28:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:28:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:28:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tlw9/NnKd2TS1jEK2KPKKY96k++wQCIkJtPtV7pYUpT2qJwfe4JmeLLz+Let82/MhXcG+4k1+vSPW/WRA7cXNJ4u5uipYnc6vuvwIKFEFObU1cHeQQi9kvB3ze38xxeLoBi0u2FWVka0KaoFcN2lVon7OmexVESsnEqiETayN+BYNY+kVe+zBSFn2HSXqpo9p3ITi5NqBpzbZbzLWK/BbwzBJb+QmZ/nc6kqCAXH/H1j7pQNkM1tVTgiCZ2MoJc6+5NUDQLalPoU1BiDgvXDFVS1WK2omhyX4OK63g2ITa0Vda3kZfjXuv0kHIAQryiggXpWSExzgn6g+G4rag/JfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuNYcB9e6Kt+MPLmT/qFxHEoXvGe9MbAXdmnpXHb8xQ=;
 b=aoEEMr6/nvzhlzYUA+bjDEP+PtoZOIiEL5cS+rXOULoHNshEOrb2mFBsoZm+19XVhAPk/SfeTd/go/1X/CQGfbZr5eirnCM7J9oeJEKFkiP+oiIQJ6deWvZn3AoYSWAX0UqZDJEOVWrX5T5CgcanJuB/wTzIIefdwMUMyHW6BasNvBI2RgqiuXKISe7BqIMSX2sJ6htPEQ/d+I+4ALKJcHcOfAg8OLEgTM+m3QBX8rEP7WBgUvWhY8o4NxU2tzCC0Lu9E3WgziqDMGEodq6rTEGWfMB9AuPVFAwIL+ujXUFGVilssrp7gwy8wslMsmSUwwYovFeER3TK6esi2ZD3PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB8265.namprd11.prod.outlook.com (2603:10b6:303:1e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Tue, 3 Oct
 2023 21:28:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:28:54 +0000
Message-ID: <9d4282af-7237-0c26-7c48-e2b9e2fb7795@intel.com>
Date:   Tue, 3 Oct 2023 14:28:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 24/24] x86/resctrl: Separate arch and fs resctrl locks
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-25-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-25-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:907:1::40) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: d42f1ae3-0038-4c3c-2dcc-08dbc457be64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dNgEewYVbJOUDsGSsYpabTua4HmFTqaRKLlu8DCOvlu9UpjWuIs4+p7isRiTz8MTcWs93ZMPh7XtUP0YZLHr81PqYVdb+7Uin2pldFZQhYuHYzVQvwA/xa7aqfbLeG+8d5mZQ3nuJEwsLKhrK0oGv/k8II3YdNNVuUKGIgsilPT3PM9o/scD3r/TJRqrwlaCfdpzhxAG/A19UVNoOXhHw7/e87+rvnckSMetRoYDeABS5utxMtNm+N16YirujsInrmdiFYCZ5+d1JoW2oxiS6CLeu4umTbpco3boj16cqjv2tVkJERheAoi34aLRmXq/Ixkb+Hr/nLDRJMV2CCEmwUsv8xnfxV289oTp6yAw7EH7b93wx2O8xUnynxtEFbzHM8JJMlOp4k6LhxYf6Yquis44w8W6lA6nyyKUP+RMcuRlRkPao8E/YyUq+Mw3eCwGH4htBObhGwNGpHeAzNMqaePCiv8z5TA+GXBY764IPx1oJkA/5vf6JyH67G2/pVRHyanxuhJ+ZOLBALWoUN0+2IlsP1g7SkMkxaS2B2WW0NQ4AvSUDb1A4mYsPE763AgX2WSYMGS8ozuJdW59diINIOqHvX/t/b4WxN5nM0ATWDDbcA9JKHgxJy4IVLB0FrhuzxVnO+0nIJi2gKrkRNByiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(136003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(66899024)(31686004)(8936002)(2906002)(8676002)(7416002)(4326008)(316002)(44832011)(5660300002)(82960400001)(36756003)(6506007)(6512007)(86362001)(66556008)(53546011)(6666004)(38100700002)(2616005)(41300700001)(31696002)(83380400001)(66946007)(478600001)(66476007)(6486002)(54906003)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cERyaUNucXRFaytGNFNPY2hsUXdkNnpsNHh1YXNwYWMzWGJ2SnNoOXZNRnUx?=
 =?utf-8?B?akh1Ukx4QTM4akpkNDdwWSs4Yzc5ZWpMQlZzdWk1ZitlK3dPckVyZituUkg2?=
 =?utf-8?B?V1NZMmlERktSaHVYUEdQUC96WnJwMXdYeTh0RVpyQzROekJySTRtR0QvNXRq?=
 =?utf-8?B?c3cwakk4S3Yvb1RGVDFjZVBmb21zdng5eTA3bzBxd2FOcTUvalFQZjYrN3Er?=
 =?utf-8?B?MEtqNzZwcUNLMmR2MjQvYk45dUVyekR0MzJUbUVvWW5ZaW94cStvZmxIYmdz?=
 =?utf-8?B?eW1PaWNXZTdlSXEyZlhMYkNTZWNTN2NOeUxJRTgydjB0NjEvdy8yY2RGYkZY?=
 =?utf-8?B?NHZRdnByV2tQZWNNTTdsVzVaSE00Zllpd3R3MDZKM3ZheGxzRDY3UE1ybWdX?=
 =?utf-8?B?OWpLMHp6ZXNvUTM5dmxwaTNjNk1NRUpwaVVsTFpCc0pnUTZJSWowa09lVWZJ?=
 =?utf-8?B?dm1oQ3cxZVB3TldhZ2JsQnBrM08wQWpWMm94OFB3ekE1L2UwUGNZSVV3VzVM?=
 =?utf-8?B?MUFQbjJ4ODlvRHh6WklNNGJSbXdZbEJsaDBNTkY1dUFjd00yUEVWN3k5NG5p?=
 =?utf-8?B?MTFsUHlobHVMZHVNYVM2bGttZTRJTGJ3aGh6WTBCcnhTNUJWUTBMT3Yva1Yz?=
 =?utf-8?B?WDgrQzkvaGxMQkZNWTB0WkhkMCtNSjhSQzRhMGtBaHVra0hoWEVoYmE5anFO?=
 =?utf-8?B?dHJyVnNROXFYK1hKR2FWZUlWRXR2TWxVcmswdFpabkxocFczSGREcURvTWtq?=
 =?utf-8?B?dVJXSVo4ZWtmOHlrTXVXdEFvcnlHSE9HKytBV1F2Snhta0xCOGh6RTdOSWo5?=
 =?utf-8?B?amhVbW5JR0lpWGtja1ZNY1JPUDdvRjEvbVFiREhDVTJjT1FzOU9SZ3lldEMv?=
 =?utf-8?B?Nm5qT1BNMjRDS0F6WlE4RjYxTHRSa2dSekZmTVEvR0N3M2lWYWMvR25vZUJL?=
 =?utf-8?B?UEtnRDc5MExPUWpzWk9Uc0VWdGhQTEFkajBEaGV5WWd3ZmJwOEcyMDZsYUJJ?=
 =?utf-8?B?VlVwWUd0OE50RHhQbmVJY1ZhY3VEbVBPV2xlOVFmN1FtS2hIRnJBQ1lKd2t5?=
 =?utf-8?B?YjhRRzBMb2VLNjZaTUtJa1hLOHYwaW9PWklaRTZEcXpMNWV2ZUttWkd5RUlt?=
 =?utf-8?B?N09Kc1pTUlJ5RVFub0h3Z2JXL2g3dXB4eE53ZFVHWjl2Y3FjVmE4d2VzLy9r?=
 =?utf-8?B?SDNjeERHR3E4cTlYWXdpcUNBZE1zMms1Y0lkR1Zhc3ZnU3V6WW4zOWpPcmIy?=
 =?utf-8?B?OVIyMTdwZG04SEl0QktuZktRYUV3L28xeVEvR1BDQnJoeHVzdkpGV0F2ZGor?=
 =?utf-8?B?MWdBQXJaM2lpcFZnS0ZxZnl5Zno3MUNoY3MyUjJocG5ZRTVWMzNGWllveWNp?=
 =?utf-8?B?V3NkN1h6dWFOYSswTEZsd2dWR3BVUWN3MU11MldRREoxd3M1dkVyRVRXaWc4?=
 =?utf-8?B?QXpLQ2IzZVg5TUkzNVcza1RxWjdkdytTc0g0WmFFU0ZVaGRRYk5jVXNqT3Q4?=
 =?utf-8?B?ZUpRVFJUQ1g5SzdOWEhjb2tsMThvT0pOSXpMV1ZxRUZvY2dJeU5HdllvdXBq?=
 =?utf-8?B?YU5QQStxbENrYUlsZStINFVhekJCcUlXUDFiUEgxMTRETHhRWVZSY1poV25H?=
 =?utf-8?B?WDlucWtNMFJLZnlWV3JJSTBhRWxuaGhtSC9ZNzllZVBtWVdDTTB4alZBY1Zl?=
 =?utf-8?B?dWMxai9IZnpPVndldXNTRFJ2eEU1ektqendNZHBxNmkyYnN2dlZNd0drOTFG?=
 =?utf-8?B?REhCRmcyczJ2L2p2ZDhxOG1BeC94UTNrMDBvbndGNStxUFJOZFNIZWlzZXE0?=
 =?utf-8?B?cm1kZStNNi9XdEM2K1Y4R2RIUklmK3FEZksrWjFua2VwWFYyanA3RmZHMU9I?=
 =?utf-8?B?dEVGNXBiVVdsR2lKUXBlM0NpTmxwRUJ4QlFocHVDeEF5YkJIQnQ3QmhuQUhZ?=
 =?utf-8?B?d1ZCSG9RTTR3b0tWUWpYdjNVQWttUm85US9rVjgwTlFscFZvUE9RRXIvY3R2?=
 =?utf-8?B?YnlkaERUK0VPNEdUN0RiV2lHOUcvS0p1Rm1ncXYrRk1TOGpsTml1ZkhubEt1?=
 =?utf-8?B?SGJmVGxiMWcrOEF3YmRSVUJDMjVmVkI2Q1o1RXY2Q2lZTDlzalh2QWlFa1pK?=
 =?utf-8?B?elZTK1doVDlNNTkzNXFGb2d3eitMZGc2RkhKUmwvQVBqOFFNUnRmVllNbkFy?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d42f1ae3-0038-4c3c-2dcc-08dbc457be64
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:28:53.9850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUYyapWnedJQFgdncqoVt9VIu1rRugz1xW1TkA2mIoSG4HTRWOUr+SbR4ng6rGbWEzbp0DiVWXhUqqCHqHHEX60nTRJoYkODJfB8hGR8QOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8265
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 10:21 AM, James Morse wrote:
> resctrl has one mutex that is taken by the architecture specific code,
> and the filesystem parts. The two interact via cpuhp, where the
> architecture code updates the domain list. Filesystem handlers that
> walk the domains list should not run concurrently with the cpuhp
> callback modifying the list.
> 
> Exposing a lock from the filesystem code means the interface is not
> cleanly defined, and creates the possibility of cross-architecture
> lock ordering headaches. The interaction only exists so that certain
> filesystem paths are serialised against CPU hotplug. The CPU hotplug
> code already has a mechanism to do this using cpus_read_lock().
> 
> MPAM's monitors have an overflow interrupt, so it needs to be possible
> to walk the domains list in irq context. RCU is ideal for this,
> but some paths need to be able to sleep to allocate memory.
> 
> Because resctrl_{on,off}line_cpu() take the rdtgroup_mutex as part
> of a cpuhp callback, cpus_read_lock() must always be taken first.
> rdtgroup_schemata_write() already does this.
> 
> Most of the filesystem code's domain list walkers are currently
> protected by the rdtgroup_mutex taken in rdtgroup_kn_lock_live().
> The exceptions are rdt_bit_usage_show() and the mon_config helpers
> which take the lock directly.
> 
> Make the domain list protected by RCU. An architecture-specific
> lock prevents concurrent writers. rdt_bit_usage_show() could
> walk the domain list using RCU, but to keep all the filesystem
> operations the same, this is changed to call cpus_read_lock().
> The mon_config helpers send multiple IPIs, take the cpus_read_lock()
> in these cases.
> 
> The other filesystem list walkers need to be able to sleep.
> Add cpus_read_lock() to rdtgroup_kn_lock_live() so that the
> cpuhp callbacks can't be invoked when file system operations are
> occurring.
> 
> Add lockdep_assert_cpus_held() in the cases where the
> rdtgroup_kn_lock_live() call isn't obvious.

One place that does not seem to have this annotation that
I think is needed is within get_domain_from_cpu(). Starting
with this series it is called from resctrl_offline_cpu()
called via CPU hotplug code. From now on extra care needs to be
taken when trying to call it from anywhere else.

> 
> Resctrl's domain online/offline calls now need to take the
> rdtgroup_mutex themselves.
> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

...

> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 1a10f567bbe5..8fd0510d767b 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -25,8 +25,15 @@
>  #include <asm/resctrl.h>
>  #include "internal.h"
>  
> -/* Mutex to protect rdtgroup access. */
> -DEFINE_MUTEX(rdtgroup_mutex);
> +/*
> + * rdt_domain structures are kfree()d when their last CPU goes offline,
> + * and allocated when the first CPU in a new domain comes online.
> + * The rdt_resource's domain list is updated when this happens. Readers of
> + * the domain list must either take cpus_read_lock(), or rely on an RCU
> + * read-side critical section, to avoid observing concurrent modification.
> + * All writers take this mutex:
> + */
> +static DEFINE_MUTEX(domain_list_lock);
>  

I assume that you have not followed the SNC work. Please note that in 
that work the domain list is split between a monitoring domain list and
control domain list. I expect this lock would cover both and both would
be rcu lists?


...

> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index b4ed4e1b4938..0620dfc72036 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -209,6 +209,9 @@ static int parse_line(char *line, struct resctrl_schema *s,
>  	struct rdt_domain *d;
>  	unsigned long dom_id;
>  
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>  	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
>  	    (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)) {
>  		rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");
> @@ -313,6 +316,9 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>  	struct rdt_domain *d;
>  	u32 idx;
>  
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>  	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
>  		return -ENOMEM;
>  
> @@ -378,11 +384,9 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>  		return -EINVAL;
>  	buf[nbytes - 1] = '\0';
>  
> -	cpus_read_lock();
>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>  	if (!rdtgrp) {
>  		rdtgroup_kn_unlock(of->kn);
> -		cpus_read_unlock();
>  		return -ENOENT;
>  	}
>  	rdt_last_cmd_clear();
> @@ -444,7 +448,6 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>  out:
>  	rdt_staged_configs_clear();
>  	rdtgroup_kn_unlock(of->kn);
> -	cpus_read_unlock();
>  	return ret ?: nbytes;
>  }
>  
> @@ -464,6 +467,9 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
>  	bool sep = false;
>  	u32 ctrl_val;
>  
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>  	seq_printf(s, "%*s:", max_name_width, schema->name);
>  	list_for_each_entry(dom, &r->domains, list) {
>  		if (sep)
> @@ -535,7 +541,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  	int cpu;
>  
>  	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
> -	lockdep_assert_held(&rdtgroup_mutex);
> +	lockdep_assert_cpus_held();
>  

Only now is that comment accurate. Could it be moved to this patch?

...

> @@ -2948,6 +2975,9 @@ static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
>  	struct rdt_domain *dom;
>  	int ret;
>  
> +	/* Walking r->domains, ensure it can't race with cpuhp */
> +	lockdep_assert_cpus_held();
> +
>  	list_for_each_entry(dom, &r->domains, list) {
>  		ret = mkdir_mondata_subdir(parent_kn, dom, r, prgrp);
>  		if (ret)
> @@ -3766,7 +3796,8 @@ static void domain_destroy_mon_state(struct rdt_domain *d)
>  	kfree(d->mbm_local);
>  }
>  
> -void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
> +static void _resctrl_offline_domain(struct rdt_resource *r,
> +				    struct rdt_domain *d)
>  {
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
> @@ -3801,6 +3832,13 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>  	domain_destroy_mon_state(d);
>  }
>  
> +void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	mutex_lock(&rdtgroup_mutex);
> +	_resctrl_offline_domain(r, d);
> +	mutex_unlock(&rdtgroup_mutex);
> +}
> +

This seems unnecessary. Why not keep resctrl_offline_domain() as-is and just
take the lock within it?

>  static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
>  {
>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
> @@ -3832,7 +3870,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
>  	return 0;
>  }
>  
> -int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
> +static int _resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>  {
>  	int err;
>  
> @@ -3870,12 +3908,23 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>  	return 0;
>  }
>  
> +int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	int err;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +	err = _resctrl_online_domain(r, d);
> +	mutex_unlock(&rdtgroup_mutex);
> +
> +	return err;
> +}
> +

Same here.

>  void resctrl_online_cpu(unsigned int cpu)
>  {
> -	lockdep_assert_held(&rdtgroup_mutex);
> -
> +	mutex_lock(&rdtgroup_mutex);
>  	/* The CPU is set in default rdtgroup after online. */
>  	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
> +	mutex_unlock(&rdtgroup_mutex);
>  }
>  
>  static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)

...

Reinette
