Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C62A7A70F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjITDVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjITDV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:21:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9B1B9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 20:21:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaAsgnnSphRs3spbQ3OA9vEmJPDjSr3MQYPrDzE8ic626bJBxrkMNM6eq+uQqCV6a/Y2T83+FAH/IFTtXJFDQigVnELiSgtk+DPuWALXVa7fWKcFVqovxKSq060KR2fEXEfvq+F3IyJ5v7AwuhiQkMnzdyr29TsPS+VRHQzFSsezMmbMP7R9gqGqkbxTw+cyPnSlRCcComs0TlCgBM8JdKQZQdQ/cleMk4bnFiJbQJC8LoBOEVJZyqjm3MkVXz4mWVFewHuORXL8slntwwT18EjPcNYHU5S2oy2Zqp3QSgUu4D0Hi0q5LIMqA7JRmiIHrBnlbf+dHr+r9u3+ji+k0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WG6vbVuiikmqzIfs7PI2WYvo7kluacLNg+9PrLL3JAk=;
 b=ZHg8UV7fuCdhF1QeVwxy3WH1f1jpa608w0ispscbKArOgtzuKl2itv6sJGeRqDK1t1AM5UecQUJh1s0Sx1Lkq/LOLJbiuIbGR4MJUHstEtQqAjngNGEwVhQn+DXBE6Sxt0bPGkZkRzDySKRYUFlpTOL9Qrqa/qr2QD/ZEQR+uuFknfqVLvH78MYukpWUo8ypDfJfoRN2t2ZjURfoV0LQY66ojaJlV8OdjHnTvUTe33vfOi3485rA4HZYGh/6H7fSjF3LTadGxeoBo+pdzzIirhmNnw066FX3q5xRtgWCAnlZGUQ3OrLeNwEuORJWg/X78iknvlv3nfynILKF8V0Z0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WG6vbVuiikmqzIfs7PI2WYvo7kluacLNg+9PrLL3JAk=;
 b=49V8zFkxnbQV2QFp41Mk8A5N1fQQBe3yQ9Cy6V4R1Giioyl/1sltDdi/RBJIQdypP9EdTfXMr5RAuJkSzJW5AV4Og61xXPlohFO4WnUtgblWQb9N2tYdagIIzmaMKAGABRLz7AfxrTH5V/WfFQ6LI0+rNJG/iOWUKFqc61A+1rw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by BY5PR12MB4886.namprd12.prod.outlook.com (2603:10b6:a03:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 03:21:18 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 03:21:18 +0000
Message-ID: <03d36c51-d3f5-d77d-c304-d06e86f4f3e2@amd.com>
Date:   Wed, 20 Sep 2023 08:51:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [patch V4 24/41] x86/cpu: Provide cpu_init/parse_topology()
Content-Language: en-US
To:     Arjan van de Ven <arjan@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230814085006.593997112@linutronix.de>
 <20230814085113.471353147@linutronix.de>
 <934072fe-eca2-44df-94e7-9fed1dc8b502@amd.com> <87r0nn8ots.ffs@tglx>
 <4a4d5a89-b024-ea49-8740-1f3aef412c15@amd.com>
 <abb65e60-4e8b-7036-4401-d21b273b6d67@linux.intel.com>
 <6f101718-7ee1-1c3d-3e0a-3aa708928ecd@amd.com>
 <20230915115428.GD6721@noisy.programming.kicks-ass.net>
 <9ffe31b0-a6ff-991d-85ad-97306abfc684@linux.intel.com>
 <106c0cef-2cde-7330-7a18-31db92c5b04a@amd.com>
 <13c2f8b6-f0ca-8c68-603a-a0efdc80164f@linux.intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <13c2f8b6-f0ca-8c68-603a-a0efdc80164f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0190.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::15) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|BY5PR12MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: df53a27a-4222-4a56-b995-08dbb988a69f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XxGeW5uSY1bbGuaIinemmHezON4YW83NTLXkq8Pbyt8UOg4HprvVP927tL/E417y1lJ+yGWmkzwnU1Eb3c8Os3ugRrHsA+01MseWZf5Rn66GggxmUisj3s1emRpis7KqsLTzsWC4vaYAmOPhWin5bH44fK+ieasFxQOy59G79dxYqaParsnchoX2DCeW3Sfxy0jt9W87b38dJm/cCbggrXX96brF2xUYVPauKAnJlltvus5EEUv96Fjm0NpCSYU/gfPKr2JohVlAuJ6kdwwn5NBEplktZhOw/+t0sJahI8pjC/cbI4lKL+2pq0qgWZkW0Se1L9ED/IlFIEjauLlMRp3ZJVfvBQ2GfFfhnBUKyz0AHrBXGZFyI9NouAqS39gVvM0BJh+1xnJrEl5gJG5qV8OAouEmv1Argc7qXa7i3Lthj+ZW7LEvnZSUX0yeEdVdFtGUiqkBuSqX7oe7xJAoRSYy24TiQhPz8u2i5uvfBG8K6Sc+EDLscCx5Gt2fmVLXWmI+iJjPsLT04paGXLFZN9M0qTNjOPGGiYEsn7GOLPu0Ks2Qgt29uXcJTngg8XUg++3m98YfOkyy/+hoJxLZZuqZVQbnG0AothkxPoeSQ/J38+7v+Vd4CheFuMv2R2QlLB7NJQzyFj20oFZ3+wH73Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(1800799009)(186009)(451199024)(26005)(2616005)(5660300002)(4326008)(8676002)(8936002)(2906002)(7416002)(31696002)(86362001)(36756003)(38100700002)(83380400001)(6506007)(6486002)(66946007)(53546011)(54906003)(66476007)(66556008)(31686004)(478600001)(6666004)(6512007)(41300700001)(6916009)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3R0NTNKa2ZTL1ZadzM5RzVNVXJ1Nks0clRwUDJ6NXQxRmdINlJLSHdUblZr?=
 =?utf-8?B?WGZiZzFUc3cxM3FoWEpiTXVVeEJqeFZEQWxMTmRnaFFOeE1Ydnc5cmJ3bS9U?=
 =?utf-8?B?NjFZbEMrMFQrdllPeWZmWnY5TktGZ0YvMEJvSm5RcU5ncjVYSHp0M2I2dGVS?=
 =?utf-8?B?NlgxTlFOZU13NXloNUtoS3hwOXYxZmppZ0cwM3k5RVNodG9EZDBGSU85SWpD?=
 =?utf-8?B?SEVWUGtGSDY5ZDZZTVVyZ1JKR3dLYkZoYzNIU1dFOFIzSmNWdVNBVzRuQXha?=
 =?utf-8?B?MmZERThhckF6UWE3aC93cnRzV2dNbXpEVGYxakVHdDZMVUVrU2k1SGpEU3JX?=
 =?utf-8?B?UW9tdzFXdmFIck5XNG5HZXJ6bldRWldYb09IL0xmUXI2aFRqRTZERGNULytv?=
 =?utf-8?B?US9Ba1ROMlJHb21FdWVOckdNTHVPSndSekszN0hnZVZJQmRjL3dUZTdWYVFK?=
 =?utf-8?B?SkpWdHJhMUg2NDdvR0owOUJmLzJ0SUtCTTNCNDRnNU5JU0N1eGd3ckF2TjZo?=
 =?utf-8?B?TUdubzNVSmc3K3JsM3ozRGxxa1hEL3VJN05GWXNLaHFYVTNaNTlFSTZHL3FZ?=
 =?utf-8?B?R21GZC8xYnZaUEpkaEpIWlR5Y3FuZjZHYWs2UTFJZlFIdWg1dVJXZ0lZQ0po?=
 =?utf-8?B?a1NDV0JJOXdDTEpUTURVMXI3Tm9PSG95YnYvQ05yNW52bEpYNG5WUEtYeU1t?=
 =?utf-8?B?Q0RBOUcwUlpzSTJXa25OYmk2VFZGQ0VmVVp3M0ZHYVhpZzJob2t3V2w3U3NK?=
 =?utf-8?B?R3J2RHVqUUZTU2FveTJaeEx2MU5zYUVydjZudU9vN1hHNm5wWlFTaDdBTzFi?=
 =?utf-8?B?VUxBUGFJVkdYWVpBbTdmUzBZUjdDeEEzM1BYcTl4SVp2eGdCQTIwWTEyYjFB?=
 =?utf-8?B?bGp4KzFSdnd5aElYaEpoNXhESmk5S2gzcnRhcFpoalBITng2SzZkVm81SEhR?=
 =?utf-8?B?MVRqTjd1MGZGSktkL3RQdXZGYVBmak9jZVh2bWY3bjZ3SmZZUDZ4amlranJX?=
 =?utf-8?B?dmRyNW5QRkJFOXUyODNOMVdMeWhhTHpRdjArNzd0d0lxQTEwVFNKK1hZMGRO?=
 =?utf-8?B?MDZROC9YYzdXbUZad1gxWE9qaVVMbmIwZS9wcitPTWpST2tpSTc0ZHY2ZXdt?=
 =?utf-8?B?OEhnT0g2RDl0OHFiVUxJNG1MSlhaV0k4OWVkTGt5VTVuVmw0SFNmbDZiYStw?=
 =?utf-8?B?ajFiV3lqVFp3WW4vZ0RnQXQzbEwvNjNwc0R3eFNsVlhWby9WOEwvbnBWa2Iz?=
 =?utf-8?B?ZHp3SU5TZmtlMzJGYjBiNllCd05Ld0hPTXBIVjVqRFd4QTU5R05oU3ZIYTk0?=
 =?utf-8?B?Ymp1dWcvUTgvUDdKMEJPUFQrSTF5bHFVM29DcldmUlhOc2dPb2I3OWpoZWJV?=
 =?utf-8?B?UE82UW9oL1JkaEt1em51dlVOTklOVldzMHVRekhFUi9uMFExeDJUanUweU5h?=
 =?utf-8?B?aEF1UWNVZUVMdzVPUVBHTStTQWo3ZEdla01UazNzM2lUaGI4K0hYQzZOYXQr?=
 =?utf-8?B?OWVvalZjUTNVUkhaZVF1dGx5TlNEVDB6TlN3d082Nmx4VmdwNXFpT2FRUTJw?=
 =?utf-8?B?QWIvOEVZZnQxUVVreG9PckRzeVF1YU5mTGVpOWFOZnB0Sk9vQ3RVekgzdkxa?=
 =?utf-8?B?cjFEMlQvR3VNNEZqTFhjTStOYjNVNS9YWno2Ym5vNTVGNXZUWjR2MVVrU0R5?=
 =?utf-8?B?aVp1a2NRZ0s2ZVdISzRhNTVXZUZ6VkJibEo4YTZNRThyWHRHOEkzaklRbFRk?=
 =?utf-8?B?SG1vWGhYT3g2WkJuZkJxTW96RUQ2aDYrbzg2QVJxOThSUzJzdTNQT01KUU92?=
 =?utf-8?B?bkFFelJLbFRYOWI5ZXE5bk1mSUJqVmp4RkFuQmJVZTR5RTRUMUhzazU5bWk4?=
 =?utf-8?B?ZmVwcVU3ZDZxUWRzYnhPMk1qL1hraVNzSjRIVllWWkY4RGZybGZuRHFueS83?=
 =?utf-8?B?Z3FnT3gzeEhGcXhEOGtXaDY1a1IvTkdYc2NoOGREcHpJTXZmUmZSWHByRnBV?=
 =?utf-8?B?SlBGcnpHaXY5akxSUENLanhaU1R3OWcyVVkrVnZabmdQL0VWU1A3MW5NR09M?=
 =?utf-8?B?a3JUbHFCc2h6UWd0NWRWOCtpd1ZTVlkwbzFGSWlUMGR1dktVWVFJVEdsYzJs?=
 =?utf-8?Q?92Sv5vU7cSCh3XyS1nbln449N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df53a27a-4222-4a56-b995-08dbb988a69f
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:21:17.5679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcxTq9uO2AgdtFfAKa3Db2BJap7qSsQrpqOOjjYZQivyfTcdLo9svK94Q46/dCEL6jCf6eSrbUNY7kbfqBezPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4886
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arjan,

On 9/19/2023 7:14 PM, Arjan van de Ven wrote:
> 
>>>>> specifically "... combining up to four Intel 7-built tiles on a single
>>>>> package, connected using Intel EMIB ...". Perhaps the one from Qiuxu
>>>>> Zhuo's report does not contain multiple tiles.
>>>>
>>>> I think what Arjan was saying that despite them being build using
>>>> multipe physical tiles, they describe themselves, in the topology leave,
>>>> as being a single tile.
>>>
>>> and more than that -- from a software perspective, they truely act as if they are 1 tile
>>
>> If possible, can you please elaborate on the "software perspective". Say
>> CPUID leaf 0x1f reports multiple tile, would the data access latency or
>> cache to cache latency see a noticeable difference?
> 
> no. (not on SPR unless you turn on SNC, which is a whole different world)
> 
>>
>> I would like to understand what the characteristics of a "Tile" are and
>> whether they are similar to AMD's CCX instances discoverable by AMD's
>> extended CPUID leaf 0x80000026. That way, in future, when the generic
>> topology is used by other subsystems, the data from "TOPO_TILE_DOMAIN"
>> can be used generically for both Intel and AMD.
> 
> SPR for all intents and purposes for software does not have tiles. So please
> lets not design for that ;-)
> 
> The reality is that we really should not hardcode topology things to cache things.
> Sure today tile is an L3 boundary for AMD, and on all no-tile systems by construction
> of the topology tree.
> But maybe some smart person in AMD decides
> that for a next generation, it's faster to split the L3 in half -- or to make that
> extra HBM-like cache span 2 tiles or .. or ..
> 
> CPUID enumerates cache domains pretty much separate and that;s a good thing.
> We absolutely need a "cache view" of the system, but that is a mapping to topology,
> not hardcoded in topology (so one level of indirection + of course cached/computed
> bitmaps etc for cheap access)
> 
> 
Makes sense! I think that is the reason we have Cache Identifiers in the
first place. I'm satisfied with the explanation from Thomas
(https://lore.kernel.org/lkml/87y1h2wpfw.ffs@tglx/) as long as their use
in the future, in generic code, does not assume any characteristics that
is not generic to the whole of x86 :)

--
Thanks and Regards,
Prateek
