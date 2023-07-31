Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07485769739
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjGaNLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGaNLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:11:04 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2064.outbound.protection.outlook.com [40.107.241.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858B8A0;
        Mon, 31 Jul 2023 06:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6yugGbMV1wTgCaoa+lCsq7cLeEO067iZoZS4GMwQTaXqxRZQzt9GXtDEFa8jWrBYGSLxbP6payhYKSs4n59d4xagHKXh+e+AYV+O2vPSChifQMQ40+VM/2B+Jr1dWRsz7eUVI/4NnM91GNPJf1gw8miV2Zar7zWY+z/l0HA3Pnfq66z+zbWY/ZzWpv6hOu6j/5yGSy2vMZI2Pg+pmv5VYXAO/nSu79+gVQ9FZXveUhNve7hzQ2P3UjymSoqNwNUgtR1Ja5Q9XkqjbralEboXJAHQqEzX7xRw/47uA7A6MtZq3MLdcR87q7yxIYQOvoBWoHE1VQvi6oTpD7Tw8sSaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZMd/qzsfKTGvyFtdzfw9ucjnk9cGapc+mm/dohgDk0=;
 b=kf+aOuJTlDKj0zXSfl78ZN+/B+c44+DZC3Y6TqELl34ZoQy7HuwuolEwFLzKFuHk6tWQwbSR5nelmgM5+u2urBzQJ6Dls5g724+itFoxSnnVFszpSkZcXggW4a1K3xaGUSXxBs3EM5Re4qTMyncitXqM16E3U/Th+2C12zocjaI7LTSTpQfr15IiKwGWwQDhbSIXtalZ921dCH4quddz5sDg9DrdxLPjseZavsZU5pF/7JCApINLTB2F5bh66Zk/ruViH55f8iULWR+0M/mYdKQmrgCu+pBa38Hx5Jn3YsW+bc+XrLVG2FxO2C/ut94RDaK3l/4awm+zAfMfHkePcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZMd/qzsfKTGvyFtdzfw9ucjnk9cGapc+mm/dohgDk0=;
 b=Spp09gAg6/R4/uUmFRh75i3YElEvemVnJmIXkHtsC3jGbHCjayaZRR8qYa+V9BkQAxYdzXfiJrhs2q8/55OIMJcj0SiKNkay/4YXBaQTneTYAraiKbEqrXpl3oBsU4cg4vFOeo8E2eVzFk4ga1kt6LmRqklZiu2YM4sJSt8Wb7xRO/KyyD74xXsG9jzdsSiUrIZ4R3YIlLvdupbFgCNZU+q4j1tzEZSDxW/t5ukvaK48Oyol1acKRbl5qLyV+6XVTkNuDcJsZQyHkKRq83kt/xYUckxTl7WtfCglCzSnyM8Zdep4WDpFI5fl7wCvxpeqEN+eOKBAA8in32Gh8XumMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by AS8PR04MB8215.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 13:10:59 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3%2]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 13:10:59 +0000
Message-ID: <347f9810-a9b7-8ef0-0442-6d22261d3ff5@suse.com>
Date:   Mon, 31 Jul 2023 15:10:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] USB: Fix race condition during UVC webcam disconnect
Content-Language: en-US
To:     aman.deep@samsung.com, Greg KH <gregkh@linuxfoundation.org>
Cc:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anuj Gupta <anuj01.gupta@samsung.com>
References: <CGME20230720113203epcas5p1eb52bec9c076d1a2f3dac5e317d0361b@epcms5p8>
 <20230728045935epcms5p8f40b56f2c9100c7ea280c6f26b40d4fb@epcms5p8>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20230728045935epcms5p8f40b56f2c9100c7ea280c6f26b40d4fb@epcms5p8>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::17) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|AS8PR04MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: aa28e22f-db5b-42ca-71c3-08db91c794fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sjz8pIu1XH8oQZJZTk/0XECwEwVQVGA0E3zzl4O29dudnDmUcEIxwrxpwgmO6HByK/nu6JrN/3Re5id9RWZvb6PnynifOoq0W8RGITOLFP61R+7OOOkdyLdqF0COJZU11gKXNQCyHjKRjAzXX5vtYBDznCb5IF7tkghw6x4jY9NtE9k5EF0ry4Od2uGCwWBWiSNYQDh3TOT8awbp2Ka/w1xTz5GWdcWRaW50pB9kuCUD1uofJVSUf6stIBQ/i+fJTLwndb06LIEJH1cTANcEi1RhqVCrePg0eWGEHxp8YWoJpImtSGuaeMcLCSA2fdHaC6npy6zxJliJM/WkfVMnd1IP48tFnW/DzfKaVzDh0f6tFYJ+TQFkNiJfOEffe1fe5Jk8ZiDM9n+J6/lxey4zgkn+5Mf8f0uZEL7FOUKNe6lJUyQl5SVSpKFaMniYcLDiQAwUp9zo597jLJAjYc2mHWje5qCqvc1TCdu1XWsTdopWHX3DJt6yDEXw1uUeQQ15gocIjRQ/NfYOMe/L1m9py6mmnDt5ZQxaL4sRTmW624tUX9Odo++xe9rQfLUteKX59sBtZf1tKzWWpk29x1Wb71+EHytjsCmADzR+8HqXYze2CM7gvJ14KpvM8dmNRn8QuT2qHHjV23erzaxDRb2x7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199021)(6512007)(6486002)(36756003)(53546011)(2616005)(6506007)(83380400001)(186003)(66946007)(66556008)(41300700001)(54906003)(31696002)(86362001)(66476007)(316002)(4326008)(5660300002)(6916009)(8676002)(8936002)(31686004)(38100700002)(2906002)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEYzV3NpQVZ3TmVNMDRtM21EeitxU01qbDN0UnZ1N2F2dVBGZ0VSUzdoMTA5?=
 =?utf-8?B?QTdDZ0lQT2F1M0JtdUJoT2s4UTF4MHdmUWVyUjdJN1ZrRmg0cjhkVVR0Wkow?=
 =?utf-8?B?VDBuNzY4Wi9sYkJvWG5IelZNQWRQU1hLRUZGMlRHS3owVDZOWkVpWXFqeXA3?=
 =?utf-8?B?eW9EYjJDNGZ0d1FaNEZZOUsxSjlwK25LVWsvNkJCQ0VMV1lSNnRYclkvYkZB?=
 =?utf-8?B?djhiMitMYW5ORVpiMGtKb1p3WmgvUTZFMkcvMCtucEd6c0F0dy93L2EvMHRx?=
 =?utf-8?B?SFdMNmFWRkNERlQ3NW9idVdGTmo5UlpVc21nejNzckZ5OHFWNnY3clNuZmdm?=
 =?utf-8?B?alNBZ2l0QS9PK1hoTzFWb3BXNFF2MlVKSmJnb2RVbGVXQ1Vmb3M5b09BLzNN?=
 =?utf-8?B?SkE0OXF2bmxSWXl2eHk0cGlTSHQxUlk1WlVYVGJHbVBYNkxqcTlTVWYxbkVX?=
 =?utf-8?B?dEplOUhFQ1hJdWI0QjVYSUIvODBnMXBjMXpRbVZFOFVrQzE2TmcrbURXQ1N4?=
 =?utf-8?B?T1lFc2gxOXlDdmozQnVIaHNzeWFYYVgyYXJPRWw4ZjAwUm41bVN5QnhUTmhn?=
 =?utf-8?B?VUd0clQ2K3loNUdvSnp1V0dFbytBQ3NjK0lTTVlhYjRub3lkS2xadnF3L1NW?=
 =?utf-8?B?cjA5dDQ2SlVPUHo1bGpJWnhTdDExNmsrUE16alkrTzJ2SFM1RXBYODh5RUti?=
 =?utf-8?B?WmY3b0wyZzlmd3ZrQ2JXdG94eWVva1pRcGZoOGxqak8vRUNSZWpLc0hSc0Vk?=
 =?utf-8?B?K3pYKzBDSEJzYlZndk13ZTE3M2xpY0hzTXhrSXI2d3J1OXNSelVma2RRbkRS?=
 =?utf-8?B?VWxOTlZKUWxVeXRmVG5nQlAwNk9veDl2a0x1a0loSWNVSDVib01VWi9jeVNt?=
 =?utf-8?B?UERkdWR3eUxrOHUvYUFmUWVFeEExTFk1UldCSWs0NU5RcGlKRDllRWtXVG1W?=
 =?utf-8?B?Y0VyNTFzYm5qZmlKeUFwM1Z4OWNFa0h4VEpIR3pkUmRManYybWc3M0NoK211?=
 =?utf-8?B?YWRpREVleGNSenNnR0U5MEI0QUx2Z0tBbU5ORDV0SGZ1cU1tQTR5RWwvR240?=
 =?utf-8?B?bFU0SjV0TFFzL1RncDJveUZKa0dGYVdKSWRJNDNKbHFKY24rTkRNSTFjbnFj?=
 =?utf-8?B?OWxpaTJjYk13NExST3dpRHhQOGpRcnlVR1owQk54WFpRYW03T2VQbWxWM1ZF?=
 =?utf-8?B?NmJtQnR6SkUyRjZPSld4b2o5NFBiQjZuU2hGZzNGbHJjNnVxd2FQSGZuTmpN?=
 =?utf-8?B?UkRxTTQzbWl5V2xqa2JKazZaZDZScmVxWW01UU11aHowaVh5K3R2Q2pSTkxr?=
 =?utf-8?B?RlJNTHR5UmcvWCtJNTlMS0w5bC9xL0luOGRuUUErN293MzdQYVFETUNRM015?=
 =?utf-8?B?OFhzbm9wSzJxd0tRaWtYb0tIU0RsTjBJSkJzZ2VFQTBQSlAzb2gwTWh0ak5Z?=
 =?utf-8?B?UjhyT01WM09Xa0N4SThCRUR2bkNua3YwUi9PNlkzdWVtWGlqZmlnZDhmYkx0?=
 =?utf-8?B?TFNPQmJ3QkRHNDJlbzZOTEYvemNFY0pxZ25WNlRGYUtHbnpZOEtTUEQ0OVZS?=
 =?utf-8?B?R2k1TjlBYkNlTW1SV3ppeHhqditVbUsyOVl6WGI3YTlxU3NSTUtSUVJnczRR?=
 =?utf-8?B?ckdLY0h0TDRFTlNEWDJhTWdJNlpJWktpRHdjUkFyVWJQV2kwbm05bXl2V1cz?=
 =?utf-8?B?YTBsZWtUNWlmdjdWeVFjdXRERm9VM2hBdTF0aGxVU0xZTkJ4Z1lSdDUrT0FP?=
 =?utf-8?B?ZDY2TzdNcTJCaDB6Q1NaV1pmWm9kbHF3dU9lWTEwOEhFUlovdCtFbDVUeG45?=
 =?utf-8?B?dldrWXpPODd0b0F4L0U2bnNYamR1bHJ0Z2p3MDdSaHFzUFg5NzdyTzhDckZz?=
 =?utf-8?B?RGR0d0VHQTNBT21lemdOWitOZk00NW5uQTFVdHJCMlNiSm1RTnNSM3RVSzlG?=
 =?utf-8?B?dDk2Wm1ENTZCbllkdWZGb1BLQ3p4eEE0RjUwMStSaDVzY0owdlYwdlk1Z1lV?=
 =?utf-8?B?elp5Y2xpdXhxTzdVcHNDWUZpVzMyODV6WE9ZZE1MSGdISHphb0dyc0NFa29J?=
 =?utf-8?B?SWd3Sy9FQ2lWWmMyMUFPVnJpTzNNbUZwNXZXQ0NaVDEvMnFtWlQ5SUlPb1pi?=
 =?utf-8?B?N2czOXhNbkRqVFVqNFVHYnllZzNWZ3Arbkd0NmpoSGpSRVlmNVVVQm5qcE03?=
 =?utf-8?Q?TzDVTPBr/H8YlKx3KuysN1k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa28e22f-db5b-42ca-71c3-08db91c794fc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 13:10:58.8964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vb0BfzbeXF0cP5MrHQMN7N+yKSdYdT0Mr0507MfD7PqK0AOdSuWmoe2+sJt+9kEd4hndpgh13n25zG5Tee4Edg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8215
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.07.23 06:59, AMAN DEEP wrote:

Hi,

> [1-221.1822] [    msg: 4788] PC is at usb_ifnum_to_if+0x30/0x74 [usbcore]

This has to fail if the device is gone, but the question is why the driver
is doing this. Hence we need to look at the backtrace.

> [1-221.1822] [    msg: 4788] LR is at 0x5
> [1-221.1822] [    msg: 4788] pc : [<bede1300>]    lr : [<00000005>]    psr: 20000113
> [1-221.1822] [    msg: 4788] sp : ca443c18  ip : ca443c28  fp : ca443c24
> [1-221.1822] [    msg: 4788] r10: e668b6c8  r9 : 00000000  r8 : e668b7e0
> [1-221.1822] [    msg: 4788] r7 : e7b78880  r6 : bf1d9db0  r5 : e668b6c8  r4 : e690c000
> [1-221.1822] [    msg: 4788] r3 : 00002000  r2 : e696ac40  r1 : 00000001  r0 : 00000000
> [1-221.1822] [    msg: 4788] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> [1-221.1822] [    msg: 4788] Control: 30c5383d  Table: 261f8a80  DAC: e45d65d5
> [1-221.1822] [    msg: 4788] Process msg (pid: 4788, stack limit = 0xa0153238)
> [1-221.1822] [    msg: 4788] Stack: (0xca443c18 to 0xca444000)
> [1-221.1822] [    msg: 4788] 3c00:                                                       ca443c64 ca443c28
> [1-221.1822] [    msg: 4788] 3c20: bedee6e4 bede12dc 00000000 bee0ae78 ca443c54 ca443c40 c083c894 e7b78880
> [1-221.1822] [    msg: 4788] 3c40: e6b88340 00000000 bee0ae78 00000001 e690c000 e668b6c8 ca443cb4 ca443c68
> [1-221.1822] [    msg: 4788] 3c60: bedf22ac bedee64c e5cf1508 e5cf1508 e5cf0000 e5cf0330 00000001 e5cf0330
> [1-221.1822] [    msg: 4788] 3c80: ca443ca4 ca443c90 c083c894 e5cf0000 e5cf0330 00000001 e5cf0330 00000000
> [1-221.1822] [    msg: 4788] 3ca0: 00000001 c08d1b3c ca443ccc ca443cb8 bfb3f958 bedf1ff4 e5cf0330 e5cf0330
> [1-221.1822] [    msg: 4788] 3cc0: ca443ce4 ca443cd0 bfb3a024 bfb3f8a8 e5cf0330 e5cf0330 ca443d14 ca443ce8
> [1-221.1823] [    msg: 4788] 3ce0: be3661e0 bfb3a004 00000001 e5cf0330 e5cf0330 00000001 c05d6260 00000000
> [1-221.1823] [    msg: 4788] 3d00: 00000001 c08d1b3c ca443d2c ca443d18 be367994 be3661b4 e5cf0484 e5cf0330
> [1-221.1823] [    msg: 4788] 3d20: ca443d3c ca443d30 be37e3e4 be367978 ca443d5c ca443d40 bfb3a518 be37e3cc
> [1-221.1823] [    msg: 4788] 3d40: e5cf030c e5cf0000 00000001 c05d6260 ca443d7c ca443d60 bfb3b628 bfb3a4f0
> [1-221.1823] [    msg: 4788] 3d60: bfb3b5e8 40045613 00000000 c05d6260 ca443d94 ca443d80 c05d6288 bfb3b5f4
> [1-221.1823] [    msg: 4788] 3d80: e5cf0010 40045613 ca443dfc ca443d98 c05d9b84 c05d626c 00000068 ca443deb
> [1-221.1823] [    msg: 4788] 3da0: c08d1b3c 00000001 ca443e24 bfb44680 00000000 e2fa3780 c01a926c 031e1090
> [1-221.1823] [    msg: 4788] 3dc0: ca443df4 ffffffff c01e0048 0000072c 000012b4 00000000 40045613 00000000
> [1-221.1823] [    msg: 4788] 3de0: 00000000 00000001 00000004 ca443e24 ca443ed4 ca443e00 c05db320 c05d9a04
> [1-221.1823] [    msg: 4788] 3e00: 00000000 00000000 c05d99f8 e77a6700 ab8fd26c 00000000 00000000 00000000
> [1-221.1823] [    msg: 4788] 3e20: ca443f60 00000001 ca443ee0 00000000 ca443e9c ca443e40 c02390a8 be211e84
> [1-221.1823] [    msg: 4788] 3e40: 00000000 00000001 e2861600 00000000 00000000 00000000 00000000 00000000
> [1-221.1823] [    msg: 4788] 3e60: 00000000 00000000 00000000 c03681bc 00000008 00000000 ca443ee0 c0bbd748
> [1-221.1823] [    msg: 4788] 3e80: 00000000 c0be9a14 ca443ef4 00000002 ca443ed4 ca443ea0 c03681bc c036790c
> [1-221.1823] [    msg: 4788] 3ea0: ca443ef4 c0bbd748 e2861600 c05db7dc e6695448 40045613 ab8fd26c e77a6700
> [1-221.1823] [    msg: 4788] 3ec0: 00000021 00000036 ca443ee4 ca443ed8 c05db7fc c05db0f8 ca443efc ca443ee8
> [1-221.1823] [    msg: 4788] 3ee0: c05d4728 c05db7e8 ab8fd26c e6695448 ca443f6c ca443f00 c02506a0 c05d46e8
> [1-221.1823] [    msg: 4788] 3f00: ca443f04 c08a7a00 00000000 00000000 00000000 00000000 00000000 00000000
> [1-221.1823] [    msg: 4788] 3f20: 00000000 00000000 00000000 00000000 ab8fd26c c0abb6ec ab8fd26c e77a6700
> [1-221.1823] [    msg: 4788] 3f40: ca443f6c e77a6701 00000000 40045613 ab8fd26c e77a6700 00000021 00000036
> [1-221.1824] [    msg: 4788] 3f60: ca443f94 ca443f70 c0250b3c c02502fc 00000000 000006f7 00000000 00000036
> [1-221.1824] [    msg: 4788] 3f80: c000924c ca442000 ca443fa4 ca443f98 c0250b78 c0250adc 00000000 ca443fa8
> [1-221.1824] [    msg: 4788] 3fa0: c0009230 c0250b6c 00000000 000006f7 00000021 40045613 ab8fd26c 00000021
> [1-221.1824] [    msg: 4788] 3fc0: 00000000 000006f7 00000000 00000036 abb79e30 00000000 00000001 abb79e28
> [1-221.1824] [    msg: 4788] 3fe0: aeca607c ab8fd24c aec8e749 b5f1ed1c 20000010 00000021 00000000 00000000
> [1-221.1824] [    msg: 4788] Backtrace:
> [1-221.1824] [    msg: 4788] [<bede12d0>] (usb_ifnum_to_if [usbcore]) from [<bedee6e4>] (usb_hcd_alloc_bandwidth+0xa4/0x564 [usbcore])
> [1-221.1824] [    msg: 4788] [<bedee640>] (usb_hcd_alloc_bandwidth [usbcore]) from [<bedf22ac>] (usb_set_interface+0x2c4/0x61c [usbcore])

This is the proximate cause.

> [1-221.1824] [    msg: 4788]  r10:e668b6c8 r9:e690c000 r8:00000001 r7:bee0ae78 r6:00000000 r5:e6b88340
> [1-221.1824] [    msg: 4788]  r4:e7b78880
> [1-221.1825] [    msg: 4788] [<bedf1fe8>] (usb_set_interface [usbcore]) from [<bfb3f958>] (uvc_video_stop_streaming+0xbc/0xc4 [uvcvideo])
> [1-221.1825] [    msg: 4788]  r10:c08d1b3c r9:00000001 r8:00000000 r7:e5cf0330 r6:00000001 r5:e5cf0330
> [1-221.1825] [    msg: 4788]  r4:e5cf0000
> [1-221.1825] [    msg: 4788] [<bfb3f89c>] (uvc_video_stop_streaming [uvcvideo]) from [<bfb3a024>] (uvc_stop_streaming+0x2c/0x50 [uvcvideo])

triggered from here
> [1-221.1826] [    msg: 4788] [<bfb3b5e8>] (uvc_ioctl_streamoff [uvcvideo]) from [<c05d6288>] (v4l_streamoff+0x28/0x2c)
> [1-221.1826] [    msg: 4788]  r7:c05d6260 r6:00000000 r5:40045613 r4:bfb3b5e8

User space is trying to execute an ioctl() on a device whose
disconnect() method has run. A driver has to either prevent or fail such calls.
  
> I thought this issue can occur with other devices in simillar race conditions so i thought it will be fixed for all drivers.

No, this will not work. You are failing to take into consideration
that the life time of the device is different from its association
with a particular device driver.

> Please suggest if we need to add locking mechanism to cover such cases.
> i will try accordingly.

For the reason I stated above this is not fixable with locking
at this level. The test for the device state is the wrong test.
Consequently no amount of locking can correct that. The conditions
only happen to conincide because your testing replicates the most
common code path. It is not the only one.
  
You need to fix uvc_disconnect()

	HTH
		Oliver

