Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B197F123F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjKTLjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjKTLjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:39:39 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B746A83;
        Mon, 20 Nov 2023 03:39:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGAuWT2Uw40ABSfoww6CiJeqWZtiu72rZwDa1YdcXBEiUZur0MwraQYWEX5HmY3k1dfsGX5444ekX4d12ahWuxrizWoNJdvE0Lx6p8VqCh8zNRjU+gHeVHYALIVGsPaKi4G+GwaSM9fyYoChtjBnQcGDTSFmeZefLUvH5QxlukwxH+IFhnNFzssJ7B4YB8Zp5YzvlEA5bAvRRxQmrZ/bYV8Mm3I/p7Y+9G6PS/22pZifyWIf3112hbrbdBPCR+7MpzRh/dVNfcnoqB8l34nvlqOAQ+fB0+wg6/kAAWEXdwQUAMGR3N3sdQphu89tEiF8Yxjt6BRuLrDHEMoHYS5D0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWkwbJe+vYA1KAV/944AjibrjuuiFaYRn64iuPKQPDU=;
 b=MYRlJUDUelGtC/OZSM9OGjUUK0Kn4AP6Lg6kjkYUHmi5INpes3228NVl/CH3qAEFXP2/GRm+egPPCxDmNf6gSx+7ep27dCKrexMwpbOJIBriX3BuHetFHpF1dorrpsj17eG0THWrYJ3JwDrhUZqINcMa5lUjthnR0AoB4fkZSj7yHtOGGoKVmXiPh12tFunmAp2T3ubDA98/PUpCqW47d5Gq2yPt1GytN3obR4QEH7YedgjidDZWuDmnssX9GKL7bh0QJzG1q/fk9eYkDMZPJwhrcv/JE7D2Bxr2BQpR7+nocSyFBJcClUaY0JqXd6whiiaGEysJ4gP3z3Y/Za44/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWkwbJe+vYA1KAV/944AjibrjuuiFaYRn64iuPKQPDU=;
 b=1D5aZyUWpxVrH7xPeuwlHzTE2p3zZm6Buu10FuH3+PgQKdlZweSOTAcn4ae9t9NKl3EmgH4RJUip3qmw0GTfxeyjGQIFnqP6vyGzi7mu9YaIRcwM4rML4rctmyncbP5OoYf1s339xkZcJKG6nO4I4UJACeCRxkTOqmnYb2xOjBicimOX4BFDg/kYgfsJzUYYnPU6u/pX2Gx59voJopWm/vdFXjDdMAWBSrAcryiiuMV90FjPQATFaFrfJ+csXPD8kBCAY6uLdEFri0nv2YR5HkHedSmcNlW7C1/O/hiMu3fXI6uvjpG/UoTo52bCA07briWzQJSd93NIKWa0slk7HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com (2603:10a6:208:16c::20)
 by DB9PR04MB8477.eurprd04.prod.outlook.com (2603:10a6:10:2c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 11:39:32 +0000
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6]) by AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6%7]) with mapi id 15.20.7025.015; Mon, 20 Nov 2023
 11:39:32 +0000
Message-ID: <618e3f85-10a5-4e65-a91f-20e0cd5f4c0f@suse.com>
Date:   Mon, 20 Nov 2023 12:39:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/34] usb: cdc-acm: optimize acm_softint()
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-22-yury.norov@gmail.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20231118155105.25678-22-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::8) To AM0PR04MB6467.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6467:EE_|DB9PR04MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: f4bff1d2-895e-4362-30fe-08dbe9bd5cd4
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6w+7ynpv4EV4A96Sb5RyeQf2rk51HuBqmT++jLZSP64MmfWJyHh0pJ8YtsZBb16/qJAma0CD6oBc//VDjK8Bd5BERulaum0sy+kfWW7qXa0CILC2W3BeAcJ9vc5J+7HPLbpQCbkMlMw8H3ecfI2WSUBZrAHKDhXiWWEYAXNQeja01XMGMvJe17e2EPh0Tjqedf1hZyZAMXH3/jxZ39DKTKi1Z/Cc45YCiQyVX1UXnu+5IVgVYvOJMqNKIZ2Pn/jE9zEMSHZ8XLDI9/xnV2HvSftP0wkpZWPCp4r5Dqpxe0jzHNiYGtp/FkKiyFX6zEWgS1/G71nVpcWeLvZG/+KyC/fxdOH7hdZKufecpi9naTgwRVjP/3FP/oATRdoswDYCIPdqnjBHCiTCFc1RB5EfyypPdnRq0TJOE6LiMIAKxNoSDvBhGaJe8x9rZySQLaoO12qjaO7+0PtlRdX1YaRlNeC3GMIlsZlKdMqGb03SXVGt+wiVQY1q1xxxubaQzqdwOBzGRwjAUcsWj775dPlb2fkRC4Nnv79fZJMtK2onH4JJF33A1rGPnaXWv8kzC5EXH8SHIHRyUQAXwcncUlqJvDnQWxaxyH6u6D26GSh3kQ0RcVjWjVAc2bXMpx/Pc2rfLMDp699zcU/srsA2U1kJ4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6467.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(36756003)(31696002)(4744005)(5660300002)(7416002)(86362001)(2906002)(31686004)(53546011)(6506007)(6512007)(2616005)(478600001)(6486002)(6666004)(38100700002)(110136005)(66556008)(66946007)(4326008)(8936002)(66476007)(8676002)(316002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzFnbE1FaTh0b2hJZ1F4OWpLQjJSWURqMmNLa2ZyNDczVkJpcUdtQzQwbUQ2?=
 =?utf-8?B?RGNRQ2NiYTUyLzVyM1BVUnZMa21rT0hWTy91Z3pJb0Q3ZjZkekVPTkJqNVhX?=
 =?utf-8?B?Vm5ZTXM0ZThLRXg4VkNSc0RkMEJqeitjclphYkh1NVVLL0JKcnBzNnZGTzRr?=
 =?utf-8?B?c3hodE9IcW12elh1dTFzbXZkRy9vZG5FTVlBczBMTkw5RTIreTJDMG5LRXdp?=
 =?utf-8?B?T0NldTFteFVVOU9TTTloOFlTWlBBUDB6UkdQVnIxZ0plVit4U3FjWDNOL2Vx?=
 =?utf-8?B?S3NFSk44MzBEU05YUmo3NGR3NGhSa3dXZUlwajllTGx5NHdGcGkyMzMvRlRz?=
 =?utf-8?B?TzNHNWN3R05qOHJVUUFZTE5pYkN2QjBNVHR0S2psNXlaNnJZMWloVlVhb1dC?=
 =?utf-8?B?WEtrRGpPN0tQandHWnZBVTJHYTFaYkM3UkRiS05taXhjemtuZ0wwRUY5aXoz?=
 =?utf-8?B?OFNWeUJUdEdCMXYvb1hsdVU5NFNqb1lvM3AvdXdkZmc2ejdTbUN4aDNubS9T?=
 =?utf-8?B?cDJVTFpXSmVyUkRtRk5GcjhjRjNobEJjVFY0S05obmFiYjVlQmhMN2p1Q1Ro?=
 =?utf-8?B?T0poR2FzT2RIMVVsWSs1eHNZUWxsK2hNclJGKy9McFM0NnEwbGZyWTBVWVBo?=
 =?utf-8?B?QlR6Uk9qNEptL2tEdVlNOHhmSkdwamNIbUEwNjRGTlpXcmZvS3MrSUFocWdY?=
 =?utf-8?B?Q1JNOUVyY0ptMW03ZDhBOUQ3Njdublc5Q0tqY3dqWDhKVStUajJ1THNNSVFP?=
 =?utf-8?B?aTR4YzFlT3FLNjVYSjBGRTlFQ245NnM0MkhOcHd4YVJMa2dERkRibmJsMmFh?=
 =?utf-8?B?akl2ZkNQZnJIS0tvZGxBVXpyby9sQWoxNHhJMTJyMDFxY2FBVFhIa3ExRFFr?=
 =?utf-8?B?QmxidDZ6QlZrb0o4SHJEb0tnMHpLNEhoZUJNM0NVL3BqLzhSeWF2MkVVb1NQ?=
 =?utf-8?B?QkVNU2F2OEl2S3Q1am9LWmlYVWlzcFpURTc2U29CN24wSHpER0sxTkJiOE5M?=
 =?utf-8?B?b1hBbGFrcFVkUVZIS2J4aWc3NE5GcUMzUEtQVEp3bGZ3TmpOT3IwREZIWWR4?=
 =?utf-8?B?ek1DbWlrVjloUHBiQk5qWlRKaEI4N1llM1p1ZUpiQ2M4UmRTZ3BJV1lZa3Vy?=
 =?utf-8?B?dlMrbjJLTlZUcExzVXpzZDF0Q0pJRW9tWDZlSjR2eXhQOUI3VEcyV3dTNkxF?=
 =?utf-8?B?RFh0TjNLK2JEOHBySkU4UFE3ZnNnc1R5OUVtRGFzVnpRZ1FWcWlUNXZqaFVV?=
 =?utf-8?B?aW9aSzMzT1RrN05EeW1vVXRpL0FTenNtS1ZuK0J2UExVb2ZkMmpQWC8zdzgz?=
 =?utf-8?B?R3Z1SFhDa3B0KzNyVHk0OUJEaHBnbnZiaHVFOFlSVVA0QWIrVGYreUx2S1py?=
 =?utf-8?B?VGRYNlZXem15Qjl0SjRGaHoySDRtcnZoOE9uWlZHQzUweldhWFZCL1NLQUpv?=
 =?utf-8?B?OGtDWldSeTR1eisyRVFWN3lsUCs3bmpVZGNmNXEvSXZBUUFMZFFQMHB5Q2s2?=
 =?utf-8?B?SHg3T3MwcXlmeGRxK1VnWFo1dko5Y1dHTXpaa296bEd3V3NsOHNpMTBhRzNH?=
 =?utf-8?B?M0JHdmppVUp2cmVpcEp4eDMvQ3M2dmJNc3dwSjNyUmNHSFFIcGFvRXlpNW9T?=
 =?utf-8?B?dEYyVWpaQU5Fa2VXM1ozTlJ2L1U1Z2c0bW5oMC9VbkJBUStjeUJMMEdOSjZH?=
 =?utf-8?B?bEdXazN5QzRzeUVYb1h0RHF0RGVKU0pjSEtrZGhtaENZSjZkcU53TldFMysy?=
 =?utf-8?B?YUROWUJ2OEs3SVZVZ2tmVXlYTUVRSXpsbGh4MUhJNW5EVHlxbEFxTUdON21Y?=
 =?utf-8?B?TE9GaWVBQURER1NYaWc0Y1hZVThra3UzVmszaHJLWFc1TjZNc012NHpxL0I4?=
 =?utf-8?B?enJJdGRTV1JqWjdMNDRtVDcyc0tDN3BQWWpONjZ6bmFpUS85bmg1TDU5b3ZV?=
 =?utf-8?B?eVQwNmNYcmp1VXNzM1JFNklSKzNPRDBkcmJXWkl3bmxYcS9VdzBKQVI3eU5C?=
 =?utf-8?B?YzdBTFN0RG9jdWYyT0o5c1U0YUhPMmx2RWJrSkRiR0JWVEVDQnEwTkxVSnNO?=
 =?utf-8?B?STIxd3JHeHoyWU93WU1kTEFLbFZGMEFaYlZPNVBnVjliU1hyQUVpUVZlYXha?=
 =?utf-8?B?SUE2anhBcnI0dWlmVCtLbTNoUHNQOGhmMmdjOHQ1WVFLOEgxaGxrNnNTdVI2?=
 =?utf-8?Q?gcyaEBNqIuYzPc/EerWqFrp+92LYSY/Uu5u75Ow7HKbB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bff1d2-895e-4362-30fe-08dbe9bd5cd4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6467.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 11:39:32.1362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +70KCHE5Pa9kxFbT2GhDQDbik/O6K8kq84iYchYuqxeZm98uQszOhhetek9YPofYDxaXqTvGSGQavCrguTTgxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8477
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.11.23 16:50, Yury Norov wrote:
> acm_softint(), uses for-loop to traverse urbs_in_error_delay bitmap
> bit by bit to find and clear set bits.
> 
> We can do it better by using for_each_test_and_clear_bit(), because it
> doesn't test already clear bits.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
