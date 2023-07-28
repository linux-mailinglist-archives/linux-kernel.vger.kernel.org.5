Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC06766A98
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbjG1K3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjG1K3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:29:13 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2122.outbound.protection.outlook.com [40.107.101.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D304C4EEF;
        Fri, 28 Jul 2023 03:28:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCi4s0UoiyZ8Hs693ndGErNsaBb9Cd16/q4cy3O9lT8Afg9+mCHTVd/GqLaWz/ySA5TnttX9kmKN6xMx/8F8z/wdXghlLeDN68uGs9NOefHCVJaX1y0/o0fodcTuI6+8scxnqMHzOFOQWKvvw/6E4HCyp3JC+4q9QyP8/5Q7aAAUFGSsCITKDalyzzDOEF5CtEzay6GOTSCd38m1qcaVmuK7cUeevX0DFn0yjDt0MpPUSvVsW3GdobvfiD3KkjkZh0x3AX0KxBGs3yWwIRDuGfb/LRua2BuxcbcCv0Sf6HpY6qvf3lIDTAFiKX42AsHnWrWMbCJfh1GEbWi1ZrBa8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YMvU05XtULFryHDSWWRF/hnvXeK63u4sz9JN9Ug2hs=;
 b=FNYaW7o90MFMWtxyTxP8xl3datNmdzrUinnJRXiBK3g2FlycEkLk6mRbTZzlTjek+kjPF8KArnSY+Ry9O1dEEsGp1czJCKVdO/EOgTEjolraoJ0k8mGzZ973d0aEkVZGPXH5QIQgalO3T54jyrNFLgOF4H5WbUeugHTKy8V+xZf0Ixa1DIu4hGyggPKbs6iyDpuI/eVirpDDpEGuK8U3Y2rN1+1uydSw2eNvScVziq1uC7ZHBNX+EX7e84d1pflPibAn1T5PTKsbjSIw5PRYukg0fag80gQptaALrfLoVOWmQ8YBqaXcl8gFJB0FJlX97JsFjP+N7+lh8Nyn3Mzdyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YMvU05XtULFryHDSWWRF/hnvXeK63u4sz9JN9Ug2hs=;
 b=qKiQtI+znZKmrPkfhP14XqWJ4MdWSDkiBxxWd/IQzB1BnEOzUDWXF0+wSsj6Is6zWsMM8znzHpuBblHDRd/7jVBpuKAj7GsNEaXxGhuzrYWyZKA8w2bAz5CcdJ7f9GfOA24T6ylPBWHP4aqVY8L+MAqaw2IK8IAFJNYiLGAtsMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB6099.namprd13.prod.outlook.com (2603:10b6:806:33f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 10:27:39 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 10:27:39 +0000
Date:   Fri, 28 Jul 2023 12:27:32 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
Message-ID: <ZMOYFLiNrXAZ6MQC@corigine.com>
References: <20230728100035.32092-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728100035.32092-1-yuehaibing@huawei.com>
X-ClientProxiedBy: AM0PR04CA0081.eurprd04.prod.outlook.com
 (2603:10a6:208:be::22) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0de8ef-f156-4bf3-f65a-08db8f55445a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 72WEwC8z33jWOhUJT5XCVwwjnmRE+qkfZsRiTiB3mYeSkFpSg9yrJz495pgxyZXEjUT0TPW6+BqwCGReGfHlorcnKtI/1U7r26Q3oyc0PwBlkhxTKsOn8ZmYtoXITHpZxHPgNdYtOhu94PrS8Eo9VDi6zYhZwepJiNeHHG7W4rTKpWrAygcQvVPtSh7EypvAkSq7n8ACnDccsYYYtgBWOzM23x6XexG/+QGSsM/NbCf2paHtdjCdDJV/T+s2JSxU7tzGyWm33LgZx5JnNrgDiFjGY7ODZazy5TL2KOVhyX47ifEPiWL2bE8zBBqUgiH6FE6NVLGsExoN52NruMNCkxf5u1e3BA88W2s2xtghQIpG5S0DjgKkK1vA/lLCKo3ga8yuDuuAtnluiipI0y3gjEIbwyKnTijWHAdP4PplU1MU0tv9mKyb1MnIweqPvsRug2w7UqITRJHkpcz2LtxM7fC/7Bh2AKLhhCw55JACc7zmMDZiOVCE4ejyFI/TNn8TsvW7FLpkOszD5Ip60nMVCbgFrb3j1yrQ2f+MLpWnIRJoeqzxEMGBhn15HrsCl98XlJmCXiKvkBEH91MVuQasV23s2Yeg28j7OrOykaBtGmuwSJwBpmMvk7ykxUXNqkSEBu2lHrqM1joSluN6s8D03rxZEYn3+pGXD9EfC49iZcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39840400004)(396003)(376002)(346002)(136003)(451199021)(6666004)(6486002)(6916009)(478600001)(6512007)(6506007)(5660300002)(4326008)(66556008)(66946007)(66476007)(2616005)(186003)(38100700002)(8936002)(8676002)(86362001)(41300700001)(2906002)(44832011)(316002)(36756003)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s1Gv4X4/L5NsHe419FoWPh/Fisyc27geyV0qN2lbQyOno6ReqwuFXnFVlnuV?=
 =?us-ascii?Q?oL1lHG5YwjPAw/sniwpCT8Mu8scyM7gmSs3Mwi4e0hvfLFuI5/Ge5hmJ8f6a?=
 =?us-ascii?Q?nneU7ENZmj5v3l+MMs5nRbcRfxItCF1sTqerSr4XH3zSUFcQMXVAXGLCtvUz?=
 =?us-ascii?Q?7pQC6etyAuJWbKmACak0IsVm5BAZH5zv/u+zPZVOcL0HuyVJNNNgQ7LamJfe?=
 =?us-ascii?Q?pf+sCviV3qLWdQfni//XmS7P3YhZbWvg5nU90Er5fD5X9E6QRG1zeCFrsSXV?=
 =?us-ascii?Q?BV5sAJK3WAXirkR0RD3yQpCMpiEeMIKdKrQt0VqqzB7EeLeNJuLR2AL3paYK?=
 =?us-ascii?Q?AaFjVEsUXVq2FNm56ZM+IiZykTsBNAuoxDiELSrTmJgHjpgyZQgl98HzmoNc?=
 =?us-ascii?Q?+tRwOi6ZsV5dXMAzqa+4j1KDAxkwpAW7FqVT9SnABJF271zE4KKsFpOD/Wx7?=
 =?us-ascii?Q?XIFNHpHdpdrYkL1jcQP2fYJ3Fv4m1nr+LuqdE0ITDsTw1YcHfofT+FDVMWsi?=
 =?us-ascii?Q?1Xrrul4dMW9Inx7w4uEv90dO/k6T6sRoSg00bMFxlAZcEYgpTA8CS9i6lQ7f?=
 =?us-ascii?Q?ZIluhG+7QC9sg9OdWyOeLoKK9/B0wW/jCqITDnPMUgg80qe4e/iA9tQl/gCX?=
 =?us-ascii?Q?J/9oGL4yMtuMN9+J8hvXIz8U1Qbo1MweVJZYHeWHYP3vMCKLcXJeJD0M0R9t?=
 =?us-ascii?Q?oL1DxFEJUM579ikfWuEJqk+BXPeHbA+ivRtaj3NT9D2KvBngUJoSutUeY4IC?=
 =?us-ascii?Q?t/OUbUKuE3c4Mtgq61m1rsoZXLsuhnwYdYaUttRZJf3uEQl1IvJ8mbSROwNn?=
 =?us-ascii?Q?wD0LESwtBF5BsNcAzxmNbNj3g8IjMJVBtSRZnE3hF+p4Y/be37JOoKUNTlUu?=
 =?us-ascii?Q?Og+cUrEokxApN5vWIRQWCydgr9/w0yYafkUZE8u5uJsT/+8yR6p/4qMpVnGB?=
 =?us-ascii?Q?hiLnEdRFalP5kz92sVOZxUR99o6ro1PlApdRFlnu5aLXG9DSUjfzmZmcr8nd?=
 =?us-ascii?Q?BZRzxeoXKDTP6JTLeqsUsmikAoCEWcxR0is+u1C7fm6l/IEkeUAiTzjt09mq?=
 =?us-ascii?Q?gtmdFbfEOXysf/vqUl6UEU+nmqUJYgmvKJpAPi5JrPPfqiu+DgnLO2QawOUG?=
 =?us-ascii?Q?6qSJvm4+T7zsRoks8pipMakuNkJ+Ed2mc/hobQYJHCGm+4uMbf/bkrxP+qhO?=
 =?us-ascii?Q?DxVk6xAcoygX67bF3eqDNPlnvRunwMoVxhndZV/VoV/7d72g8sWwq7nxtXgH?=
 =?us-ascii?Q?i7zSTRMg/KiM/ltiS9SJ1nNv70DlO4Fr6/uXV7CM5O13i2SrGm38W4wgNhIZ?=
 =?us-ascii?Q?Sk/Vlm4dEkDvgNlc3x11JQVVefI6zzkI2ghAkG9ooWrC/VMhttCdksjjc+rC?=
 =?us-ascii?Q?z326mEvovGj/cZ+lINvU9xa9rfKOgraKmlLwNdit5JyFWSQYHgD0cK1ldfng?=
 =?us-ascii?Q?E7LCf64lZkuh+o/1U6vE/SrX9oDi0IrykEqoT/MY0y2LbDptTeQYZOPkKrwC?=
 =?us-ascii?Q?hkowX5pzfuaGdpunLrVd1MjQ+vbv7VKZw7jdOAjWn7g/Iv8NHYG3T/GUgG9+?=
 =?us-ascii?Q?oZaL/4YlgBPWuI5QoZdAn785PMwKH5r/rOLMQep6EsGZ/NNH8qbKvtRoplrM?=
 =?us-ascii?Q?WLeXB3uiRSQWo3v9TuaOTeExScN/jG+AgPpbxSusz6tC3V2Nfz6LCu4p0VLW?=
 =?us-ascii?Q?4GXL8A=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0de8ef-f156-4bf3-f65a-08db8f55445a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 10:27:39.3933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/zk41ZGJxPXhstYb81Ji+9nYGdPjAAVBTL8s2IWhIm27RcXRkHkj+yYj/5/5uDnYwEBPumQEnNTs0wMCVwe49Q/Lplrwznm6BLXUfh7KoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB6099
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 06:00:35PM +0800, Yue Haibing wrote:
>  skbuff: skb_under_panic: text:ffffffff88771f69 len:56 put:-4
>  head:ffff88805f86a800 data:ffff887f5f86a850 tail:0x88 end:0x2c0 dev:pim6reg
>  ------------[ cut here ]------------
>  kernel BUG at net/core/skbuff.c:192!
>  invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>  CPU: 2 PID: 22968 Comm: kworker/2:11 Not tainted 6.5.0-rc3-00044-g0a8db05b571a #236
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>  Workqueue: ipv6_addrconf addrconf_dad_work
>  RIP: 0010:skb_panic+0x152/0x1d0
>  Call Trace:
>   <TASK>
>   skb_push+0xc4/0xe0
>   ip6mr_cache_report+0xd69/0x19b0
>   reg_vif_xmit+0x406/0x690
>   dev_hard_start_xmit+0x17e/0x6e0
>   __dev_queue_xmit+0x2d6a/0x3d20
>   vlan_dev_hard_start_xmit+0x3ab/0x5c0
>   dev_hard_start_xmit+0x17e/0x6e0
>   __dev_queue_xmit+0x2d6a/0x3d20
>   neigh_connected_output+0x3ed/0x570
>   ip6_finish_output2+0x5b5/0x1950
>   ip6_finish_output+0x693/0x11c0
>   ip6_output+0x24b/0x880
>   NF_HOOK.constprop.0+0xfd/0x530
>   ndisc_send_skb+0x9db/0x1400
>   ndisc_send_rs+0x12a/0x6c0
>   addrconf_dad_completed+0x3c9/0xea0
>   addrconf_dad_work+0x849/0x1420
>   process_one_work+0xa22/0x16e0
>   worker_thread+0x679/0x10c0
>   ret_from_fork+0x28/0x60
>   ret_from_fork_asm+0x11/0x20
> 
> When setup a vlan device on dev pim6reg, DAD ns packet may sent on reg_vif_xmit().
> reg_vif_xmit()
>     ip6mr_cache_report()
>         skb_push(skb, -skb_network_offset(pkt));//skb_network_offset(pkt) is 4
> And skb_push declar as this:

nit: declar as this -> declared as

> 	void *skb_push(struct sk_buff *skb, unsigned int len);
> 		skb->data -= len;
> 		//0xffff888f5f86a84c - 0xfffffffc = 0xffff887f5f86a850
> skb->data is set to 0xffff887f5f86a850, which is invalid mem addr, lead to skb_push() fails.
> 
> Fixes: 14fb64e1f449 ("[IPV6] MROUTE: Support PIM-SM (SSM).")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

...
