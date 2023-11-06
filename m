Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122DE7E2292
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjKFM7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjKFM7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:59:16 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2084.outbound.protection.outlook.com [40.107.8.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944D6A9;
        Mon,  6 Nov 2023 04:59:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOqZXYVMzAbQSIb1CkJhCjPLLOqiyVDEpBuW1AJb+8C0PCnrzeF+xJwG75vDCFYTXn7iezpTR2XLl9htwzaJWUzd700fGcJvuzkI+k7RF/YH4DfMn8K9I+bmaDTB7G1f87NMOv635NDFjXz46S4uAri4wbNJoWR7ZTqUfmRSCX3mN/Rsykl4YOQDKYhWvYTncegIKCvO7zNxLcinB5ygsr8IbWwvlfIob9zBm020eBCBe/LIUsEtJyDQtpFSiK+eT9gDyM2mm8C9kGGTjAP2+Fy7KuUxfMqePwhMfJUD6x7haK5JfXVc6jTeYXZhxPonONUL8qyeSW0Z8dJYl84UZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+h5j8HFh3uNxiySGZ5pBdYly6P9hBm3G+RgevQqKns=;
 b=HryeZp16gwlLUpf0IUBEHZfNAXU/cCW/geIOrRMRk7HWrk7MscKMemAoljZvG1mh+grBGqGkEDaQTWCxTW1QbRWbqTbeKpCWKQrO6B0ggfqqOSVpeqhVfiWTdXL3QTVubFAfihJxQg6hDOYEkyGLeqB8Y0q500FqmbL9e+1deyYgSCBpBtuZ8BoA+JuMAbXyWDaefgciR+IJNMI5z4mOGiKHCtqeigTvTNuWR682hhYEsxOzADoEvptYuqpFA+0QFhnAt/Wf5AQ5FwIiGVtzR3kdcl2Q6dEHS19O10HohZHmDJ7K4A0R2O1H/Lj0DzND9YQ7vTfu+LZyaekKwdBjcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+h5j8HFh3uNxiySGZ5pBdYly6P9hBm3G+RgevQqKns=;
 b=kdh7SkR2bqfLiJOLY+BF9onN2ZrIBQKij0k84PpxkkEgQsk0JBwYUW2woBIC9tZ9JPtLZkdBdtMLS6dlkFlJs++9lyAdsS+Qs/KvxSAJpIlwU8Yv1LaVSl+lA5mr4Na5mazpKP968u8jO+P0/zJ5EdGAuhLOWJnCiopZXAosVZAotHx351cn5ApkjvFjIM4lh4koBxrcA1JuXjb2nEgGQgUVZGlb3DJt6n1hYcgpQ3BdInTncRBHYwMNJP09ZxUd5igb1tUeLtHYPkMqJP/rAm/CM6qZhRUk/nATR/Zm53hTMXO70jzAkHT68btfhGZ8LPoqWtYcLgviGPOss5jyUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com (2603:10a6:208:16c::20)
 by AS8PR04MB9190.eurprd04.prod.outlook.com (2603:10a6:20b:44d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Mon, 6 Nov
 2023 12:59:10 +0000
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6]) by AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6%6]) with mapi id 15.20.6977.013; Mon, 6 Nov 2023
 12:59:10 +0000
Message-ID: <b377a7c1-bf41-4fd2-81b9-ace2b6134c4e@suse.com>
Date:   Mon, 6 Nov 2023 13:59:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usbnet: Fix potential NULL pointer dereference
Content-Language: en-US
To:     Ren Mingshuai <renmingshuai@huawei.com>, kuba@kernel.org,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Cc:     caowangbao@huawei.com, davem@davemloft.net, khlebnikov@openvz.org,
        liaichun@huawei.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, oneukum@suse.com, yanan@huawei.com
References: <20231101213832.77bd657b@kernel.org>
 <20231102090630.938759-1-renmingshuai@huawei.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20231102090630.938759-1-renmingshuai@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0328.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::7) To AM0PR04MB6467.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6467:EE_|AS8PR04MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 0397ad27-0b9c-49a5-9461-08dbdec82b21
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xn6BdmvmFe7sZYDy5N/4DJXdnvhk4CpcftiDnu6yYOjSsHkjS696yI8mx8Cz74M9ueHjReQRzZFUlQH9A6VihalgEfQbj1iXMYNjeAHpBQRVIcVertEP15dwjTcX6MzHiYDFdtcuWK4uFE02aMEG/boFwsJiBBiqnKAv0LAfZOHvRFnT+9ADPudXH+Qz/G2MmWp2WyONfTO/PUVTUJrrOEAhjTq3Bz1+yyPBnqWxnWc4sT4jXPlxyvQX/Ko8y9xGTWzdyNi5fZJym6o6/f/muGkQzktHX1OBYJQXO6sFT2+nho8JwVXvKiTguXDIztIkbLMt8i8CUd20ArzG7lJ2uGgyRWyxoq4JKryaIbgpfUXprHVMTmhIOMCQqbrkbv4G0JC/a4+whZXKQREX1jGtWK1hLXwO7Bs6s6oBaOqvZjdFwFYXEBvI6pzVAAHvqmfQLV0LG8J1sAxybXLoUStORIxBUxn3BqJA9zNiPURGw3csqgmCcXuhnWySm3wmt2p+IT98EXhqxlQVF94ewPooUIWTtO9gngevDEgNg2H04z8K6iapyYy80UNl5VEHWvkdpj2jjvtjgQUmS3Vx9503FDSRRQKCOUo5HIuDa3AEldH1I7/cA8MoAdJauTOkEeSmbiUZNVcK910TnDscy42iKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6467.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(5660300002)(7416002)(66946007)(38100700002)(110136005)(66476007)(66556008)(8676002)(8936002)(41300700001)(4744005)(316002)(53546011)(478600001)(6486002)(2906002)(2616005)(6506007)(4326008)(6512007)(36756003)(86362001)(31686004)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk5zUDJ3c2F6bFZjazRMcUx2RFJacnlOQ29wSFBoSW5kbzJ2bzBqbHE4ZzEy?=
 =?utf-8?B?ZWhjZ3hhL2M3R0ZwM3I4U2tyWkZubDFhRWFVRVIzbDBJRnRJRzNOVDI2ZTJN?=
 =?utf-8?B?YU5zWjNUTVlnQUR5Yk9XRFpaUWVXalBXUVNKNncydG5UMENZUC9RLzgySDRk?=
 =?utf-8?B?M3pqeExwbHloY1hDVGdYTm1ZRzJ1bHhpMWFJbi9NZ05nY095S0hING9UMlJE?=
 =?utf-8?B?blRKQzZOMjY4R2ZqTVpxdUdkSnVNSFJyeWwzRGc5NkhUZk92L2FrUEcrNFJt?=
 =?utf-8?B?NVd0VUtGYitNN0dIMFloanl0cXZjRDBFeVErc2J6WkZMZ3RJcmc1QmFZS2xP?=
 =?utf-8?B?VFJCdWFocm14N3dOaGRWZlJTWGFsVkRGOWl6ZVZTSHpwY25mdUg3cnkxOXdi?=
 =?utf-8?B?RS9oOFdTZHJFM0dUVVhHK2JhRnBwSEhGaUJCeDhUSW42akdFUzdHM2EvQncv?=
 =?utf-8?B?Ritic3FRR0FvV2ZNbVhaNm80bkVHbmNFWk1WWTd3UVR4NTlPYS9WbzZ0dDVB?=
 =?utf-8?B?Unk0MThKZ3FlbWx4UjR1V1NFcW1uQnNoMFY3NWlTV2FsZmx4SERHM0h6ckRv?=
 =?utf-8?B?a2EycDNNR25GT1U5ZGRNNUhoa25XdXVuZ1Z0c2xIOEg2ZC9rcWdiSHVleitS?=
 =?utf-8?B?SHBKeERWM2taYUd2TEszR1pKWDQwWklhM0V1WDRqaml0R0ZmK0ZiaGdNbXor?=
 =?utf-8?B?cTBVMzVUYmNGMlNaUW9xTzd3ZHlVSmJ2YkNrY2QvQWZkVGsyempodjdZWlRo?=
 =?utf-8?B?OC9nQmFQcGh3VmtSU0VFQ1RDRjhMWU9LWUtKQVdSWDZQcXhFdE9DWjgyTVZ4?=
 =?utf-8?B?ajV1UkNFQ2JqV0ZxV2N5M3lHVXV2eThaNkczcjVJb05DVjVuWmw3ektHdkVy?=
 =?utf-8?B?emZueXZ5cjhUZmN5bVcwVjlWaTJ5VUhrMnNMRnAxelF3RGxqZW45NVEwQzhw?=
 =?utf-8?B?Y0EvMmMxRVBCVTBkcDFDY3RBemdVM3pXZHFIaFRYVEFEMndlR1VMbDdZeVlK?=
 =?utf-8?B?MHZLcWhBeDRqbFUyMDNwKzFteFFNS1pabG9pZ01zdFVWaThnbU5FTVdYbU9S?=
 =?utf-8?B?SFU2ZXQxSnFJMWtXb29xOEVNc2xhTVU3Y2VoSzg0L0ZGNFJHSWRvUlVGNE5q?=
 =?utf-8?B?R3hVTkR0S0x6L3FKMGJwY3gzTXVxUVZjNXVtdFdia0ZqTnpWM0NlU2l2TkFa?=
 =?utf-8?B?RkQrNTFITUF3MmJRQkNHdW0wbEtYbkNSSi9ZR2tMTEdsUlYwN1VVK2xCUTJB?=
 =?utf-8?B?YzdGRmUxRXdXUGFGZ281Sk9YbXV1emRieks3QW1sdEFZVkcrQzg1WUNwZk4v?=
 =?utf-8?B?cUV4U2liNUNvOGpwVVlCK1llZ2ZLZDJYYWwrd2k2eHJMNWl3TzRqVis3SjNE?=
 =?utf-8?B?OVpRbkNBQ25HbXg4OXBrdjkwSExMQmsxNmJsVFM0WVFRMWNja243WGdnOFFI?=
 =?utf-8?B?QUZycW5kTkQ5TXBMbTBGTVgrR1JlUVlHTVpjVUNOOTg5aG5CWlZ1MmVDQ1JT?=
 =?utf-8?B?SWI0YzhEVWVsREt2Z2hTT0JjWmtYd3RiN2xXSkNrNXNYalZLb0t5UXNMRW94?=
 =?utf-8?B?UlRXQVkrdVNkcXRkZmNJVkVaQk1HQ00vRXBZRFplRlA5bnZEM0lRdVBPL2RX?=
 =?utf-8?B?RU8wcHY4cFhSbUhUeVNuZG5FcVp4WEIvYWVyZWwwUCtMZDA2eS9GZmRtOGlC?=
 =?utf-8?B?Z2YzTm5keStiOGJhaFV2YTNkZzlDcFdWblJpYVNGZVpLOEJNa1dncGNUa0FX?=
 =?utf-8?B?NENiU20rOE9kdFRXTVAvK24wR3FPaHptS2hJeUNFc2lQWUR3ZHFiVExHOUc2?=
 =?utf-8?B?YWlhRDI0V1BQdDNRK3B3aXBaVlJHNmUvbERsYXB2MEw5LzJ3aVU0TzdHeHFO?=
 =?utf-8?B?aW5aeUxRQUpXVjhua29SVENpYXpjUzlQZkR2K05uT3JOUU5IQnB6cFhUN2Fa?=
 =?utf-8?B?azhFS0lEc1MweDZFbDd1Q1YrTkw4VmZ3YkZJWXA5QmluYS9KdXdNRndESDVu?=
 =?utf-8?B?eEtCbjZJZzhBdGVHcUJtaWo0ZTJqaDkrSDBjaWFlRjlYMU13KzlvU3pOMVBx?=
 =?utf-8?B?VWhLbkt1d0V2QTFpcG15L01JTXYwMUZQQ2NRRVE5M2RrbXdHWmw2SmY3bDNG?=
 =?utf-8?B?WjdrQ2ptdHBCWGhvdmViQWg3U0VtcG5KdmhTcXhiNkM5emdpZVlJa2VLSW1n?=
 =?utf-8?Q?857UEHUHLDw9f+ZoNzfjt6RMt7t4mHcSmG5TaH8vt3CP?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0397ad27-0b9c-49a5-9461-08dbdec82b21
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6467.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 12:59:10.2566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9X42B0zUI8agHMsLB5K14LnYmHKO+S/qY+NTdB1Y6vaaFZR4fTGLTE+4kdmM9c/J8T2TOsI24kddNV/me6aHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9190
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.11.23 10:06, Ren Mingshuai wrote:

>> What do you mean? Grepping the function name shows call sites with NULL getting passed as skb.

You may see that we do check skb != NULL before we timestamp it.
But later in the process we depend skb == NULL implying that tx_fixup != NULL

That is the combination that must not happen. If it happens, though
simply bailing out seems to the wrong answer.
  
> Yes And I just learned that during the cdc_ncm_driver.probe, it is possible to pass a NULL SKB to usbnet_start_xmit().

How can that happen? And if it happens is tx_fixup set?

	Regards
		Oliver

