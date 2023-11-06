Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A501C7E225A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjKFMxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjKFMx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:53:28 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2045.outbound.protection.outlook.com [40.107.249.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F6D10B;
        Mon,  6 Nov 2023 04:53:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCmsjDlxs82Ky9Jwt7/4irdp//yiK4rIT9tjiyYcpNXM2sJPvTANl/31iIFtJRGgr4VmBVmJ+VyMi7I+F42rj5kkqiBN/8pFY2Ld3nmDu3XWTmTHI1RCMBPRDD+SAKE/CJdvYYAqVwFprUPveLw5yyMv7SOE89eVHU9X70kmHk8mElnZYkmS3mrwvl1bFwU691zQxKxZj4XFRKAkKh3dz3mUmNKVc+P8odE7tzOnWB0oTCaaXo7a0GrJsroMyJ0dRZZ2JnbCjGR24VKl/IFi4Nob9SBwF+tZbc5wKXQNH8iy1orLgDZaS1yxsN+isFByx2nZ/vdOM0Gw8713ffWaFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMnCcG/3sTCmX0yDbFp7Njhqqf0wIZt8rOj4eVcSlXo=;
 b=NQmrVeElvWua8RPk+X818uH7rIage2omWomnn78q3pMkNRvgQBhR/EIaMnlE7rbFiPRo71Qa1KRcopiaN6P+9kYP2izSX0WtcQGhbXp++AY1s8MPtIhmssG8fWXUUmAtKoxHjgzxahzeyH0AmLLM3s7Akl4DKZYQ41elkDWetBzvSfMLQQODsuYgW1TZite4ZOcyHyAjAPvqtDs6E5IGVBlpvdAauZbgccdpRlSAqZqT1npuM/UT2u6KhXfs08Td//wJu13qynFU/PvsW9mQnIEkHEI88cCkQyv2cXuBgCwwTd2Dsr5kmldU15omvqOAbLhJnRRvHxAYVbE/E9xm4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMnCcG/3sTCmX0yDbFp7Njhqqf0wIZt8rOj4eVcSlXo=;
 b=eSK8RTzoCa3Q7MNYMkJp0DqdYbIQ2SAxix4ezAU7bOjEbffgNeBEx6X0UbhBCLHY1V5KjOaYnkNJgEQ44azrSPoqhSc0bQtxlgML3+Th64UnJXj7x/amQae00yYuK3zAT8d5TFYzuauHpgLuFAuUVN8u92VfZwR5LuaiBwqmMXfH6RZ/TA58UfFQCFmnI9ZSajJ5gGn0X5oj3a65G+6qip/tMf8bNB4kfziUHKtLOjWD46efGLxPwyq1SysFS5Dp6x91FKBCoLItA5aJNKpZ1VXLwe3q/5jp2wyRqAghA1bWJjp91lVl77kydfDe7DaAzbOr/Wcr4kHzz04W5d28Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com (2603:10a6:208:16c::20)
 by DU2PR04MB8823.eurprd04.prod.outlook.com (2603:10a6:10:2e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Mon, 6 Nov
 2023 12:53:21 +0000
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6]) by AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6%6]) with mapi id 15.20.6977.013; Mon, 6 Nov 2023
 12:53:19 +0000
Message-ID: <0ed0f964-f8c8-4776-a2ae-ca25071bd0cd@suse.com>
Date:   Mon, 6 Nov 2023 13:53:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usbnet: Fix potential NULL pointer dereference
Content-Language: en-US
To:     =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Oliver Neukum <oneukum@suse.com>
Cc:     Ren Mingshuai <renmingshuai@huawei.com>, kuba@kernel.org,
        caowangbao@huawei.com, davem@davemloft.net, khlebnikov@openvz.org,
        liaichun@huawei.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, yanan@huawei.com
References: <20231101213832.77bd657b@kernel.org>
 <20231102090630.938759-1-renmingshuai@huawei.com>
 <80af8b7a-c543-4386-bb0c-a356189581a0@suse.com>
 <871qd3up56.fsf@miraculix.mork.no>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <871qd3up56.fsf@miraculix.mork.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0226.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::19) To AM0PR04MB6467.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6467:EE_|DU2PR04MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: e02559ed-b4d4-4f8c-51ff-08dbdec7574a
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g9T0JHYKYn2jRAvcqns8JSMtGxjgUHevxhrFh8/WYbYuJEe4RWd8m1T+lJJvFtBW6Xo2dLCfeQzk3nFuFZLvNopvvMrhjvzVa692iQ/SB+EhCExttzATNccjEyQ47b3t7t7S5Z0BKApyOFDEd5m67o0Re5nwXAzI1UT2BR1u3WZeKhhAomyDqkkNCpMG2AWBSpDGLqwvvNMYsfgQdIpHF5ui5rQWPDYbde43LWYz0sipxlkbgR3BRg6+rYYY5Nr3wvrlQmzlk2FELrikhrtmYPVo3ryvX1fh2vFtp0hAyIiQrtd+P7f1M/zM2naIx85sQX0yenUnTNbuhoieF+tV75XonK3xXLzxg8kG1h5NH3H/Q6dxbA2KTqOEvJLeJIpSA9vw9Dqru1WTlgtDQcqeWOOZYkpx2cWAR6xVVDDdHHnSD9pMSZ9W22yVJYhd9M5k/myShwT/aSrkSScI1wbNkO/AUownCEKjqIDrpgm5HUcR+Rbrr8E56KBLl5JU798Rm1n1sq6NYpqCZGKx2xnDdHGtulJ3UF7aFnffM/nUNLe7ppJL8ClM3lwlv7beh4Tr0E3tnfADQ4H5IZ/mUzCACTIBTe1FnR6dAAZ5wgXpXsczUBO4OS0L4Rif4a46hkcsOwaZ7aT2bm+6JIBbRGdC0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6467.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39850400004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8936002)(4744005)(5660300002)(8676002)(4326008)(6486002)(478600001)(2906002)(31686004)(41300700001)(7416002)(110136005)(66476007)(66556008)(66946007)(86362001)(316002)(6506007)(6512007)(6666004)(36756003)(2616005)(53546011)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmYrc1U0QVd1alIrWnBEc2E5YUg0ZVlLZ3JWd29yUFJQM3NNOEN5ODdDWmNX?=
 =?utf-8?B?VXg4b2QxQjI5MDUydWR3SjVNYjd0SFpOQ0tjK0RXYjdDaWd6WU4zRzVKcFlS?=
 =?utf-8?B?TlVUWjE1S3dXcEdST0hLdGNGcTdKd3h0aWVxMm1oNGdBVFFkbHFUSUMxWjl3?=
 =?utf-8?B?TzNKV2VJZlNrRC9WcnN4Z2kwSTNMNExPSzdROEZrSFl3d3RieisrM2tBWEtQ?=
 =?utf-8?B?N3ZDeW1pQjl3UU1sUE56ZWthQmJjZktUMkx5Q0l6djFiKzhVdDhpN0cwVjhj?=
 =?utf-8?B?TktldnRGN0wrODhaSzVwWEtKV3JnTW8vY3ZqdHI2N3RSRUdUeHRmMjh2dVVr?=
 =?utf-8?B?a0VlQzZ0d0VZSFFuZStWckdOZk1pTkk0T3h2Zkw3ZDM3eE5VZG55SFVqQUds?=
 =?utf-8?B?eTBKdzFyRGhaWUlJdGJTNGtSMjl4MjMyVjVFOUxCZC9HbnlWVjU5UytHNGh1?=
 =?utf-8?B?NGRoSU5HQW9MbUphZ25CZHFjUC8rNTlRZld2amxTS0VTYUdSTEhCU0Nja3JN?=
 =?utf-8?B?OW9sMjVBbk96bHc0TmVYZ1dxaGQyZVNvSVBORjArR08rRmRsaUoxQmF6eDVV?=
 =?utf-8?B?ZzB0aUJHekIwZnhjMW8xM0RJanUyWGdYNmRYNXNlNUdOdVBHR0JLRWxiYng5?=
 =?utf-8?B?Y3JTcm1WTXBTM3dDcDZWV2dHNWdZOWlXa093S2FSYjdwR2U1c3dTbkFXUUVE?=
 =?utf-8?B?NnlIT21QQ1ZDTGFQVm9uQzg0M3JjUHZwL0FGcEt0Q1RHamhiSXNENldzczBo?=
 =?utf-8?B?ZEJCN1FVV29yTlVybVBySzBWeWpzaDJ1SGtBeGVOdDlQSzVUa013SDA0OUFh?=
 =?utf-8?B?T1FRWVNiUFhHcy83Yjc1QmpMdXFXZ002N2FweFlkdlJTS2I4bXp3eUx1R1BN?=
 =?utf-8?B?VnVrVUtyYndyeU45akVaVVFVSHV5VHp5V2ZLMGVoYXdoMnZXR2VMb1FmRk5r?=
 =?utf-8?B?UzZOTEU5eWZES2FnZDd0UDBta1kvNU5PaEFUSitkZlRRbDZzdVhSQ2tDcTRD?=
 =?utf-8?B?MG02bmFWWHFGZUZpM1BINXoveTMrZTQxeUZUR3ZGUmcxMWsvVXBiZjROZkh0?=
 =?utf-8?B?U2ZBOHZtY3JEeXI1eFI0SVlHcmplaG0xM2FvajMzSzk5TTNLU0JJN1oyNXFs?=
 =?utf-8?B?N2lkMHhIQzVLN1l3Y2ZBUHRFbUZGaWpRZHRwQTN5a1p5YW5ZSFo2R2lFYmFQ?=
 =?utf-8?B?WXRDbFE1YVI1WmxHYzBVbEtqL2lUNEs3YW1CVUdNb1BDSFYwMlBpU1ZCdkMv?=
 =?utf-8?B?Ni9iVFZvNGxaTU1hUlNDaFNYTm1GRGQ4OUhEVHgrMWtjQmtKenNRSDVmVGcz?=
 =?utf-8?B?Unp4RW9RbFgwdGt3V1pYYytabzRFbTVWblJaOGdxbnNuS3E4UFJrT0hhd29H?=
 =?utf-8?B?VlBPRDdLbzBLUDVGdm9SR3l5RHJseFErTHFsRFlOVjFnM25iYzB1OUJ2cmNz?=
 =?utf-8?B?ckFJMjJVdEhzc2pFM1U3YlJaYlVIVkphY1Z1Z1RFYTJuRWVJbnV5ak5VUDQ3?=
 =?utf-8?B?WHF2SnRNNmhpSXZWRC9SWTZWZi9qWDk2TjZZUzRLbFNFNHQ5VWdnVXRadmtX?=
 =?utf-8?B?cElPTFRlSmswb05pWFZ2RWhaMEtEOWRXUzJNWjdaNmtnMmI4bWFES295YzJi?=
 =?utf-8?B?cGNOL1VDMDFWcUxyb0FEMTJiTGNodmFiSEF4L2VuTVNnb3RJYzdEQUhycm5n?=
 =?utf-8?B?bUtOUVFCb1d0ZTB4WW0vNFdQbkY3Q3JGRnNLdHFrV1RtMWg0U21UZVlSOCs1?=
 =?utf-8?B?MkZHMkxxOTBONHJzYXdyOFJJRTd0d1NWalJ6cXQxUElPYVBOd0N1eE1LbG9h?=
 =?utf-8?B?UGJUS1NGb2ppYStUOTl0b3Z5WHZiQ1o5cXJVbk9vN2p5UlQvQ2J4NFppWVgx?=
 =?utf-8?B?c0RkajROU3drTjM2SFNEczJCeEUzT3pEaHJuYlZ6UER6VnBYeEZHOGF6NXJo?=
 =?utf-8?B?VmhYZ1FIUXF5bjdoNjZtOHdXV2dmaS91eW05c0J3SU1RckQyemJFbkl3Ynlj?=
 =?utf-8?B?WmhQOGxhWS9pOEpqQ0hqcHdlV3VjSDFJQlNzOFBUbW1yemNXZmJZeWJGMWFY?=
 =?utf-8?B?aTRQNXJJYUl0MHVncW1XRm51VXJIeWFQWC92NTM4QUpCY0ZTSEFNUUNsUll2?=
 =?utf-8?B?YlZzclNzcS9VZEhQSkdhaXJSL2FpZDJ5QWZNaTdBQVZuL0ROVS9UU2U3Q2c5?=
 =?utf-8?Q?XyQxDNuP7FscdXDrBBo+9Q1nv1nyAj9En3Pzm5yTyqqg?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02559ed-b4d4-4f8c-51ff-08dbdec7574a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6467.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 12:53:19.5789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCnCYdVsW53Us9LvFyIkaYgw5T182uNso7p4BpWVOjopIMpk41HahGhJ6rYG2hY34O7tdk3Xq9SjDxtmG2nmAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8823
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.11.23 11:55, Bjørn Mork wrote:

> I believe that code is based on the (safe?) assumption that the struct
> usbnet driver_info->tx_fixup points to cdc_ncm_tx_fixup().  And

That seems to be a correct assumption, but one that is far from obvious.
Could you add a big, fat comment?

> cdc_ncm_tx_fixup does lots of weird stuff, including special handling of
> NULL skb. It might return a valid skb for further processing by
> usbnet_start_xmit().  If it doesn't, then we jump straight to
> "not_drop", like we do when cdc_ncm_tx_fixup decides to eat the passed
> skb.
> 
> But "funky" is i precise description of all this...  If someone feels
> like it, then all that open coded skb queing inside cdc_ncm should be
> completely rewritten.

I understand what you mean, but I need a generic answer. Can you call
ndo_start_xmit() with skb == NULL?

	Regards
		Oliver

