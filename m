Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CFB78B322
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjH1O2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjH1O2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:28:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B905ECC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:28:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X33MowaO9G4s+4stRG8WOVDQ9/utJfk2mi+K77pVIEWs4NUXkS6gNeB1CmdjdI1WBTWuBSIf4P6XriQdZvZwVZ5GcDKpmjHzojKe0oL9lboHVEtO5YZj1Z6xjRO8MLUNgn8sTwMBxnqIs5eSrzp4XJwtudINOB2N3B8f8OCEaFHS6nXjE8yN0cW8o05TCcyo0b5NiQz4ctqTZCupXUzba2TF5l94naplPonjnzkRSGIhGwBw98zoxdViM5OmX+kRfKAjmFYsjIC4NG9AZ8UYRLfL7TEo59NUN/Vwh+i328UByZSTSbQl5xTXCHjsJSTr2Nagbfr77F36xWbqffL50g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRkhyNYqom5YqpNZ3v5aRWqS+K6PpFb0A1Ak3xuQdRI=;
 b=MyWBLKDtORWsfRP9qa+kVljLEnJuJtOxE2wqM6V41e74HinenQxD7xbjTQs0mnp9k7Dx//M3UKbSVQd+9+hAtBW4/dZUriy/zBOGvKMp3XVHZN57zGAGNnrNSdw8Z7Ld2ST6DZwgZl0L9TGmOjLWdCdPiJAD05vTk4aoUgHivQo1Xb2nZYoxDZSbt+CatSn42yog5Egcz8DvE4i9Btq05EF3bVrCJ/NJzX3RqvHLBN3i/ZXWjY6EKKUN74EQuJfP61F+TFGj79DTXT3WzcUpI5/+JeR+ZhAV5Emqw+ngjH86mVmVBO/tbazMN1Fn/RH4k1hn076lmYeLGpLlUsv1BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRkhyNYqom5YqpNZ3v5aRWqS+K6PpFb0A1Ak3xuQdRI=;
 b=Smim9Z8z72CEZeRuhhvb9kFpIVEA1IjMqZERSXPOIoGn5yn3GHo+VgbaRpMZbwFIiqCN/b1QYMBOQxLb0S+qK3vh4MK+i7VYJX3S5Nv5enrLXtiy9I905RIms1sP4vKHZj970k1zy3nZC2NSFAe5yVs4Vek7dPLYybHrNYvGs9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by PH8PR12MB8608.namprd12.prod.outlook.com (2603:10b6:510:1bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 14:28:23 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 14:28:23 +0000
Message-ID: <4a4d5a89-b024-ea49-8740-1f3aef412c15@amd.com>
Date:   Mon, 28 Aug 2023 19:58:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [patch V4 24/41] x86/cpu: Provide cpu_init/parse_topology()
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>
References: <20230814085006.593997112@linutronix.de>
 <20230814085113.471353147@linutronix.de>
 <934072fe-eca2-44df-94e7-9fed1dc8b502@amd.com> <87r0nn8ots.ffs@tglx>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <87r0nn8ots.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|PH8PR12MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 267d7054-2036-4e7b-e4be-08dba7d308dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOboTf5A5OCFsLSnSx4hC126v38SYZWKgaUBwznFu0fka2D0J8gTNqo7rrpg67akvXj2f8VTcOGwpwyYXw+heG9gKo5DDfnPFgi3i+owEoQRZK5HlnrGDRd9iY9lXLSjzwX5Tq1Ubj9l2dXhCgUr2llUXRCdxCYCOe34vbf8LQtUsnFZedj7SV5aeRp3EcaN9KLrhBz5VAinMD7J9IF6DXfuxt6pjl1WgZjW5cMAL0hvddOo9/XMALH8v/NISyFZpChRcmgXfz20gwq8CJ0vk7FsyL2NBFCujYp8xnwTUOqqrtuElQRY9IYCaPBO5s98HdhugiouM2WhPTygDrqAz/hcxKn3BNGP0A9/Ud2nmLRjQx25aCNpTrnzLSCD4mcsb+5VbadVIUJ5K5rxSyPH8pLTOB5zf88NWSPSNkh9OF7SWh4kgee0J9yY2tV+TEnWorf+EiytFhT+zMTwZPswA7HSreA/iA6ooXoG7bv2xIsE96sSbk7VcIfqlN23jidnvdFxly6TqOHgGWpZJlYxNG1sqMnHJ4ptub8TPFFLc2Pkbi+STdIxnYeLjv+gSO994+bW90J3rTGG28h5Bl42VoaWLCJh7PQrGH17V43hXSNc/QZ2hP/gbyDorfxFY/4d7jcOdo3347XamPOsSBryXrnNJ3Crwy0rQ036/UsuOQkHdywkdXX+JbNU6nKJlAsg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(186009)(1800799009)(451199024)(41300700001)(7416002)(38100700002)(6666004)(86362001)(31696002)(478600001)(966005)(2616005)(26005)(6512007)(53546011)(6486002)(6506007)(66946007)(36756003)(66476007)(54906003)(110136005)(2906002)(66556008)(316002)(5660300002)(8676002)(8936002)(4326008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WStRRG9JdGdjQ3ZSQ0ZVSHVkdWpHYW1ydmx4QnEwQ0EyNFRDSWc0WktnYmow?=
 =?utf-8?B?dzRhK29BNUw0cmh6YWdFaEkrY2JOVm1DZ1pHeitTRHhkb09sK21GdjBLbjRZ?=
 =?utf-8?B?a3ZhR0FQTE03Rm1mMDFRR0NRUGF3VmRVMWt1SUJZdEtLendhK1pBcktPYks2?=
 =?utf-8?B?dmh4UkxYOG1sQy9lYUJXNy9CdFNUV1VvTlU4YnAzd29DUkcyTEg2ZzZZK09G?=
 =?utf-8?B?a3BzamtDaklIaHkrcjdvK2dneWFWeWVMRGRvblZUc3JndlRRa3VkdFdOcVZm?=
 =?utf-8?B?V0I0dGVSOWdWa2JBb2pIMVJKMUszallxQjI4MiszWkNsZmVzVEovbFlXREYz?=
 =?utf-8?B?NEYvdDJqQTVEa0F0MnZXUnFjQUN2TnBGdHdKc3JxWHByNDJFOUhWeXQreU1s?=
 =?utf-8?B?OUdOTUJGVzNzdW1rRW5GV01kdUZqbzFOSmhwcW5WSWxLZUZsUDl3em9PaDVy?=
 =?utf-8?B?VkVvRnFUSGtndVZEcDk1T2l4bEtPNlNNaGcrWkZRL3FKMHVuVVM4U2RBWGpY?=
 =?utf-8?B?RE5QclFSZng4VlIzMmJpbG4xUDJ4cm5ReDRjMVpVUGVkUCt5cXcxZzJXbGpY?=
 =?utf-8?B?TG5qQXZZZC8zanM4MHkyWSsycnQ4UWRHM05lUnVRV2MzaUZ4bUFvTzNUK09V?=
 =?utf-8?B?WnIvZU9DRGhLWDcxLzlXbmw3dWdQaC9ETUR3WFk3bWltcjFYajBIYlo4dTNt?=
 =?utf-8?B?RDFZVDczUlpDMHFJdXBiUkp4dVpKMTBxSWRpWkRaNVRUUHZRdXYwUnhHMjJn?=
 =?utf-8?B?NEVRMlEybVlZZmMwNWVvc2xTMU1BWXVYRGRuU0Y1ZFlhZkNrTFRBMTJYVVZX?=
 =?utf-8?B?RmpLWkgvNFRlMEswbjI5Y0tZb25JTFJqclFFWG1RczlyVHVOWWRPcmhMdkIy?=
 =?utf-8?B?WE9ZdmFkd2cyKzhSQXNlQmtqVEJKQklnMjBrQ3JGNEtEbUpxN05Yc1k2MDRp?=
 =?utf-8?B?MWZYMlRFRmtlSXpVbUROWElKQmxmRjlPaGlpQkFjd3lCL0N6ZE1yRHhodGky?=
 =?utf-8?B?VlRlMnJJWVdCbnJJNVBqS2x2M0ZDNmZGbXJoQWhvdHRtcEwzaVdkUk9aeFpi?=
 =?utf-8?B?T0xLYUcvU0VFRUltVURtYlpleldPZERZWkZJcG9jLzlTZE9sTkxhRmFvNXN3?=
 =?utf-8?B?S29Nb3JhQUNlbS9BWmlxbTBIYVNVdUgrWFhCbjduWVM1bzE4enF2V1UrRXYr?=
 =?utf-8?B?dzg1cmluWWxOUUVkVFFtLzNiejdWOXZXT25Ub0YraUd0NzBBRThzMExxZHha?=
 =?utf-8?B?YXBNUUMxRkFGc2V2c0xpMlZYVGRjZlZTUjRoQ3lsNFBMekczMEtRSjZ1M3lG?=
 =?utf-8?B?cFh2QjJQcmhVU1d3RmtpblRraFdwRnQ1cVBtYm9IcDFUKzgyTlJ4dkpJWTln?=
 =?utf-8?B?UWs5WUtNUGVNUE45WUgveUVWekhLRFVFRGI3QjlLK0dGQlkvZXNBZUJEYkxx?=
 =?utf-8?B?NXpCSFlITmkyYTUrbmRROFIxWHRmR2NmVEQrKzkxd1hoSjBIUkFXM1pxdmJL?=
 =?utf-8?B?T3dhQUlnWGE2WXhUMUhZeEpMOXRocy9Uc2w5VWczQXBHZkRoVHFTbWRPWEF5?=
 =?utf-8?B?aitqUGVhZGdzVTM3a1BvWVZSS28xQXAxeWxOWCs0azdIYWcvbTFRcitNR3I1?=
 =?utf-8?B?SjRJSk5EYVJ3WE1sRTFZNXZBMFNSaCtoRHg2T1MrSG1sRkI0MHo4c0dhaVVD?=
 =?utf-8?B?dmhvRVJsZHd4bkNRZEVjaFVyUE8xMzZzSDFBbXBPazVRekUzc0E3bmRUM040?=
 =?utf-8?B?UjZQVTJkTG90TjlpUGVTd0Q4YWE2ZWJuaXBjWC83YXdNV3BpZWZKVFJpR2RQ?=
 =?utf-8?B?dmZKVGQvd0JMNStUSnZkcHhPNHl1b2xpMzQxeVY0KysrNU5Wd2tmZmxibzdG?=
 =?utf-8?B?VHdHeHdldythaUovd3NheXphSnNhYWFhNW9OODZmUlBNRXdUcjVORTIzTmhq?=
 =?utf-8?B?akR3cjU2THpSUlZDeEVpRDM0ZC95WENMYVlyb01kZG1LZ0syREdjQkZIVzFi?=
 =?utf-8?B?VmRCY1VQL0p5L2pvREdtQ1N4NHJHUkJmM1RLRmczRXA1TmJoUkRjT1hVVVRN?=
 =?utf-8?B?QmJINjl5aEdOOXkxS1ljb3d3TnZqTVdlL1kwZk0zWUh1UFVJNXF3Y294eXB6?=
 =?utf-8?Q?zAUU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 267d7054-2036-4e7b-e4be-08dba7d308dc
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 14:28:23.6233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZTQgftmcNph5zzXoP/SgpUHh4buPrRca/rWgEL7NqY36GD8NIN8gps8xa6v6cqyQ6IrQZtGrtBbBbZPc2klzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8608
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 8/28/2023 3:35 PM, Thomas Gleixner wrote:
> Prateek!
> 
> On Mon, Aug 28 2023 at 11:37, K. Prateek Nayak wrote:
>> On 8/14/2023 2:24 PM, Thomas Gleixner wrote:
>>
>> Since these enums come from the description of level type of CPUID leaf
>> 0x1f, can we have a short description clarifying what each signify. This
>> will also help clarify the mappings for AMD's extended CPUID leaf
>> 0x80000026 (specifically for CCX and CCD level types). I had following
>> in my mind:
> 
> Makes sense.
> 
>>  	TOPO_MODULE_DOMAIN,
>> +	/*
>> +	 * If exists, represents a group of tiles within
>> +	 * an instance of the next domain
>> +	 *
>> +	 * On Intel: This level contains a group of Tile
>> +	 * type as described by CPUID leaf 0x1f
>> +	 *
>> +	 * On AMD: This is the group of "Complex" type
>> +	 * instances as described by CPUID leaf
>> +	 * 0x8000_0026
>> +	 */
>>  	TOPO_TILE_DOMAIN,
>> +	/*
>> +	 * If exists, represents a group of dies within an
>> +	 * instance of the next domain
>> +	 *
>> +	 * On Intel: This level contains group of Die
>> +	 * type as described by CPUID leaf 0x1f
>> +	 *
>> +	 * On AMD: This is the group of "CCD (Die)"
>> +	 * type instances as described by CPUID leaf
>> +	 * 0x8000_0026
>> +	 */
>>  	TOPO_DIE_DOMAIN,
>> +	/*
>> +	 * If exists, represents a group of packages
>> +	 * within the root domain
>> +	 */
>>  	TOPO_PKG_DOMAIN,
>> +	/* Topmost domain with a singular instance */
>>  	TOPO_ROOT_DOMAIN,
>>  	TOPO_MAX_DOMAIN,
>>  };
> 
> Now this begs the obvious question what the actual meaning of these
> domains is and what's their relevance for the kernel.
> 
> It's probably undisputed what SMT/CORE mean and what their relevance is.
> The PKG/DIE domains are pretty clear too.

Yup! Those seem to be clear.

> 
> Now we have:
> 
>     MODULE      (Intel only)
> 
>     TILE        Intel, AMD names it "Complex"

So here is my interpretation of 0x1f since I could not find much in the
SDM for these level types. The interpretations are based on some of the
past discussions in the community (I'll give the relevant links below).

Intel Jacobsville has a group of cores sharing the L2 cache which the
scheduler currently models as a cluster. Some information about the
same has been shared by Tim Chen in:

  https://lore.kernel.org/lkml/737932c9-846a-0a6b-08b8-e2d2d95b67ce@linux.intel.com/

Logically, this is what a module should map to IMO but Intel folks can
clarify.

In AMD processors, Complex (CCX) refers to chiplet where all the CPUs
share the same Last Level Cache (L3). Tiles are slightly different on
Intel since they do not necessarily mark the LLC boundary.

As suggested by Arjan on the thread, perhaps "chiplet" could be used as
a neutral term that describes Tiles on Intel and CCX on AMD.

With this information:

> 
> So here are the questions:
> 
>    - is TILE to "Complex" the proper mapping?

	Since "Module", based on my description above, translates to a
	group of cores sharing the L2 cache, and since CCD is
	interpreted as a "Die", that leaves us with "Complex" mapping
	to a "Tile". Chiplet could be a neutral term as suggested by
	Arjan.

> 
>    - which information is conveyed by MODULE and TILE?

	Module: Groups of cores sharing L2 cache (Purely my
		interpretation)

	Tile: Chiplet. On AMD it also marks the L3 boundary.
> 
>    - Are these really different between AMD and Intel or is this some
>      naming convention issue which needs to be resolved?

	They do have different characteristics since, on Sapphire
	Rapids, the LLC is at a socket boundary despite having multiple
	tiles. (Please correct me if I'm wrong, I'm going off of
	llc_id shared in this report by Qiuxu Zhuo -
	https://lore.kernel.org/all/20230809161219.83084-1-qiuxu.zhuo@intel.com/)

> 
> Thanks,
> 
>         tglx
> 

Most of this is based on my interpretation. Please correct me if I've
misinterpreted anything, especially the Intel bits :)

--
Thanks and Regards,
Prateek
