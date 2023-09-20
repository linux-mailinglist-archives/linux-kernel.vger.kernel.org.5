Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD737A70FA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjITDYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjITDYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:24:00 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B45B0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 20:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UO6xpBUpmF/aUI2rskowAn5U5RHj/iHvBSKL6rAWfUr/4+jbXr7KYWWWD/ZcSIngC+EkpomvGaBeem/BKajvjPEe0Xn0Km8qJz+p216YZLxfFqblZjaQlpAc6SSS3LBQh+9/+BpLl1C0gzJ5hIGqrW7F7TsOnWgrOqwvFY8PAHoPK+WT3uCJNcDdjysLCJ0r5G7SuD8AXTjSMOHUY7bdJ/SYSVBomdlvmVk8+xjEuSKD81MPEyo5L9Ag/i841x3O6JV/07+l4vSXVK51iNX0AYwu0kW2qg08XQUvpnltRPtbYH/VGKtbB62qci6GP6pU/4Kkx+j0lFbhp7rPPs+F+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXFKNEmux3lB+dktkJ+Brz4YBrzfkSPDOUjm2tekbxU=;
 b=JjyfizBTfXnA6ZAJTUZEM36/67FJBUCZba3PxkLqmpTOh9Qh4fboDUUcFw9xdi+tuILMbeet1/YAd26Tv+RtOE+/GRDUfNsG8Q5U06zwIVvGdZoKYpYfHDAHvREfohD7+yhuZt2I3PnfubbIGZuAxMI7NGF+bnTzxtVna9pS7jaja1ygX0iBfQ7t6N9uVV9j5b+JStFogmtw3yEXIN4zdEmNRdur998jxissjm+zN4ETOG0+NP7N7kaoz6rMf9pIiUFNPJT8dL2LS8blR2mniu+paJpNiQfYoNdvWnToiuZMYRvyjlZHawyU4/l5J/PL1t+lf166OvhsZOOYx7+LEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXFKNEmux3lB+dktkJ+Brz4YBrzfkSPDOUjm2tekbxU=;
 b=xPQMF5HWqt3f5UKfRw9slRbbGu4sV3ZMyaEAAe61gL/vGNZxDVWmjxlTp3Mcfj2ycrVVADjObVNJJzjkPWrBFTb1COfUuGiwfU3Nb0ZKt+YtvkYoEsFBJcSu6AX6v1gaLN1KafvjsR43QmPEUxRuKvVRD9sj09lXcWq9vemg8KE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by BY5PR12MB4886.namprd12.prod.outlook.com (2603:10b6:a03:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 03:23:49 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 03:23:49 +0000
Message-ID: <0eb56cda-511a-452d-7191-c19477276327@amd.com>
Date:   Wed, 20 Sep 2023 08:53:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [patch V4 24/41] x86/cpu: Provide cpu_init/parse_topology()
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
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
 <4a4d5a89-b024-ea49-8740-1f3aef412c15@amd.com>
 <abb65e60-4e8b-7036-4401-d21b273b6d67@linux.intel.com>
 <6f101718-7ee1-1c3d-3e0a-3aa708928ecd@amd.com>
 <20230915115428.GD6721@noisy.programming.kicks-ass.net>
 <9ffe31b0-a6ff-991d-85ad-97306abfc684@linux.intel.com>
 <106c0cef-2cde-7330-7a18-31db92c5b04a@amd.com> <87y1h2wpfw.ffs@tglx>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <87y1h2wpfw.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::15) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|BY5PR12MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: 84348540-f22f-45d1-c67e-08dbb98901cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +V/v8CCSNJQboxgXyg6LpX5mxbpW/qIJY3FaH6PQZuqt+eYAJ64T/0wrurcPtfx+fhP5Bnjub6nsu/CtqCU5Dh9pq+s20toG/VdkXtJbTExJqCFcuXyU7se74mMRF9pvAQLlFGX/WaHz77UNJNWqV8WHnxuhUDxP+AyuPfHOqX7QdqvL7THD8iFTCnd80w/DBIwq0vua4v0uLWI3xUgWueN1isTOQ+YpnvqbcuV0OoSNXmkNXhFNKsgrkbC1s/WepuThUMuqNPZ6xzRFmKQp2KqKdsG7Di1oVpr8EXLjarWcsefUibH0g102HfyRBTV2Y34TG0yrfHKOZT59ZSbp+3QE27FxuPGSkgULRMVH6YGiY/na98rYSnXr8EktiC9mX3cbIVpp7MkQ+/oDBWWtemBQ9QZiWuMNp7TBhJw1KdeZ/Ch0mZrSEluMabo1uEaN6X3AP52qOi6sW16x0EzTyTpg5RGD+mj78YFaH0z1cQHMu6WaISwfRgKdhrupHKLlKNuAraShTASu5eUfSIq/vxcDDyy0tRLEXdmLEsS+O43fFYgOwrCBNz1fsDWTU+X3qktP55YgdDgUr8hFiMcnjnOqtZskwVa/arXve+sApC84z9vzJ6Hwv2S6rc//9olHriFOYBNQTXpfswaPRwci7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(1800799009)(186009)(451199024)(26005)(2616005)(5660300002)(4326008)(8676002)(8936002)(2906002)(7416002)(31696002)(86362001)(36756003)(38100700002)(83380400001)(6506007)(6486002)(66946007)(53546011)(54906003)(110136005)(66476007)(66556008)(31686004)(478600001)(6666004)(6512007)(41300700001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFhSa3h2Qi9WaURhcmNteW9aREtNWWp6djk2Sk5nK0RuaDhxUnRibnY3enl2?=
 =?utf-8?B?TTRwSzQvSFlvUnl6NitCN0VvbGhDbjdLdkkxWVNYaG1xclhwdVE0RzFxaXV1?=
 =?utf-8?B?cngyNWRiaWtQNTN3eFIwT2p6alpmalErT2NrakNhYWJVM2FXcEx6M2tKcXhm?=
 =?utf-8?B?a3Z6Z0hxeERiL3lCK3RXREVRZVZUSjNWL1IrVVkzdXc3MXgrN2NxdTlUWnZv?=
 =?utf-8?B?blBqb09CYmFPZXZjKzQ4RFlaREVyWkdSZXBVNWVsenFtdDZ3ck44TTYvMWJI?=
 =?utf-8?B?MnZKVVpmaXdHMWpMWjJLL1RoWUFMb2VEM0JjWWp6aHNDUnRKZzhjUDlpNFBm?=
 =?utf-8?B?dzFkTk90cHk5ZFVZZjRRQldnZVlGdzYrZm90N0VUZHdGRWQrUnM1ZTY3aEo2?=
 =?utf-8?B?TkxlMWdOWFg4S0dvT2NXUGxSUzFJNTllbXRDS3RNOVl1bElBSmFWWWo3NlhU?=
 =?utf-8?B?ZEgraUJRMzJEZnJmSnZldmU1M21ZNjJtT3pRNUhGRXpsbkdTTS9XWE04V2Nl?=
 =?utf-8?B?TjZOYU54QkJJMlJzTERGaU9tc3hSdExKaVJvNFJ4MVFmdzZLS2hVa0JISzNL?=
 =?utf-8?B?NjczWVJCQ0pkRm1GSUlIQ1ZLOGo0aWhqQXlOK051T2lRZ21zcUg0bWczNVNQ?=
 =?utf-8?B?T1JaN0dycEticDRxb1lvODV6WmN2NFk1MzlNUXN2aTZWT1NnMHlpNDhZVUpN?=
 =?utf-8?B?RnRxK2V3WlFxa1k1OWZhVXVpUi9NenZTODI5bDNFM2dZWXc1TWlsUGdFcUZS?=
 =?utf-8?B?ak5CcWw4TFVqQnZMSjdWekhvS0txWHk3MGw5UElncnliVzhkb05PUHovcDY0?=
 =?utf-8?B?YkpTYm9BbG4rNUNyaldINTJhOVV2anAwQlZHSldVak1kRm9MVU9uQjlLNHNv?=
 =?utf-8?B?TENjSTFva2VDZDVibEMxYm4vYUdXVWFsMFJIZDdqWWorRlVxR1lHdk5DKzZ2?=
 =?utf-8?B?NlJBaUt3N1gvbk9xclRaV3liUmpMZS9aaGV2OGxId0tPR1BxdE9CbEZVWXhF?=
 =?utf-8?B?bjhoSlk0RzltaklQckdqbmhXdndUYWtkeGF1SVBFNEVvOEg4eEVjcmdDYWht?=
 =?utf-8?B?LzhINU5WU3N2dnFFSlU0TXRJYWVxY3BBb3dpR0YweDBybW5sMWVGZVh0aU9L?=
 =?utf-8?B?emFMRTJzSkgza1ZoMXIrYmNlVER6RDJSaGtlMU1WTEpwMkFsNWc1UGxId29v?=
 =?utf-8?B?NDdYSUlDRjNrazYvbGt6d1NkV3ArajF2M3lJZ2U2YmdpY292WWlsUVRHaTBC?=
 =?utf-8?B?Y3UycENEQmRVUTVkMTZFOTM0Zk53Tkl0RTZScUVKdW9SYXM4Y211RXMrZ0Zy?=
 =?utf-8?B?VGdkL2dKV2NFZEJaekFGOFIzeFlXQkhCa0loUFJWNnVzNUFLclFOVGNYVTA3?=
 =?utf-8?B?UUVlZTFqdEo5QkhlOWFNaWNGS01HUG14am5XTDdXQmR2U2NmN3gzYXJmZ0xn?=
 =?utf-8?B?ZmRqd3dOcWNpQlQ4QlhxWWlSMTdQOFo3RitXcERLU1ZHM2NHMVpndzBta3VP?=
 =?utf-8?B?MkFsQjJLeDhlb29sNitva29LNHo0Y1pGazBpTjBPak9Fazc5UDJ2cjRXdm5a?=
 =?utf-8?B?Z0Vrc0pGU3owMkw4eFgwUVk2TXBDSDJwQWNrZ0hmbkc1a3BLZEYxQTA4WFN6?=
 =?utf-8?B?WG5RZG91ZmlOUDVyNFd1TnRrNzlLVVBKVFRMVTZ0dW5JY1VCM0pRMkZMRkFu?=
 =?utf-8?B?dUMwOVN6aVNFTVlRMEhLcXFmSXRsT3dRcnBiLzRoZlZ6cFlZZGxwd3I2RjNE?=
 =?utf-8?B?Z29Qdnp0THJpMUYyUERtcmJNNnA2dGo3akVTRFJPRHdtbmFnWkxjdERuMlFI?=
 =?utf-8?B?eE5NTldMS2dhdWFGdWk2YjQvMzVOU2V5Q28wM0N2aEdtdTVoRFYyblVIVlR3?=
 =?utf-8?B?VE1MNktGaWFDWUY4MnJVK0poWmMxSkhBUm5vcW1meWRneTdRQ3lhMXNKb1hB?=
 =?utf-8?B?YXJWejAwMFRUSHhJQklCUkpsREFnWlRPWDJ0akRmQjJnL25sUHNVeUNjRGxQ?=
 =?utf-8?B?bTlXd0hiSGVCQnJ1YkFSQXQ1d2s1eExNczkwOXZwMlBvZldpNEo3Q2lKYm9y?=
 =?utf-8?B?cHRpWVJnczQzRVRJaDRxZ21hUGNLbnVSUDFzSm5VTXQrSHpPMnJqaGlNRGdh?=
 =?utf-8?Q?qLbyISrIwly7Dat4ziU1Ql66U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84348540-f22f-45d1-c67e-08dbb98901cd
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:23:49.7865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pd1vMjVjFVcb5MeRyPRNaONyaNIgAib/gNuPx15C7Od2z4UAXtLj0SWdEICWGDu2jNu7b5xNxoeP1Yidifow/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4886
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 9/19/2023 1:43 PM, Thomas Gleixner wrote:
> On Tue, Sep 19 2023 at 09:24, K Prateek Nayak wrote:
>> If possible, can you please elaborate on the "software perspective". Say
>> CPUID leaf 0x1f reports multiple tile, would the data access latency or
>> cache to cache latency see a noticeable difference?
>>
>> I would like to understand what the characteristics of a "Tile" are and
>> whether they are similar to AMD's CCX instances discoverable by AMD's
>> extended CPUID leaf 0x80000026. That way, in future, when the generic
>> topology is used by other subsystems, the data from "TOPO_TILE_DOMAIN"
>> can be used generically for both Intel and AMD.
> 
> I'm not convinced that this is possible. The meaning of these elements
> is unfortunately not cast in stone, so the association of e.g. cache
> boundaries is not necessarily static accross a larger range of CPU
> generations..
> 
> We really need to differentiate performance characteristic, hardware
> feature scope, power management scope etc. and create abstractions which
> are actually useful for kernel facilities and user space.
> 
> From a performance perspective it's irrelevant whether the scope is TILE
> or whatever. The information needed is the hierarchy, the performance
> characteristics of a segment in the hierarchy and the costs for cross
> segment access and cross segment migration.

That makes sense. Thank you for the detailed explanation.

> 
> For hardware features like perf the information needed is what the scope
> of a particular resource is. Again it's not necessarily useful to know
> what particular domain type it is.
> 
> Powermanagement does not care about the particual type either. It needs
> to know which scopes affect c-states, clock speeds ... to give the
> scheduler informtion of how to steer workloads in the most efficient way.
> 
> Thanks,
> 
>         tglx

--
Thanks and Regards,
Prateek
