Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5640F751BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbjGMIjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjGMIiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:38:46 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361A83C17;
        Thu, 13 Jul 2023 01:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZYYsM07bz6Lub5TfHsurRCmXHh2i41i9LrnVCwe6nYvSV9mw0LOX0OHPnkNtU9g9nGfxCRN/EI2VehBOVGCP5og82mHHka0+/Nsf9YG1X/3/zMks4/Y72fU7oBCHfOe+gYwvQE+F7hyFUwav89YnxTm1CMJKCR2qJJaCtlKu34yzDk1OIh4/orL7Kp5dqLxBtcKgwlxgQwfSqUOCCWG+bk6rDAY6thPUKPOYT1/2TLWzwD2ocjVH0uRDCwt6hloBX3dFXgnR9kLgdWrzb6GJsc8qxDRTL1zkkyJgE2+N25wWTTPk8merguTpIYSCHv6QUHZftKc4BFLyTLXdso7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+YNl78J7Kh0Al/guMR1GqVM33sQwnsbgtuy4gRpSBM=;
 b=fvFI+BBr+QN/kLcpdPS276NyQompwRiDU/e1UAP4LEjuQUfRQF4wvN9+9tv51K/IDTWe8WUWqgGPh+Ouzk7/K6odSBafZ5qBFHcHu8tC0hRg6SUeLoL53aXimpWhr8Tw7eMeWkAx8W/+uCzJy70hFXjsLxnROx5F5+23r9++ycHJO2yWiXZwj21bxE+4937qvpfqJD4EMTY/8Mcm5uFGa+OKtn51OD2XXOsIxYNvHACAPKKL+ZA3wjamtJUW7k/0Kn/YniADOclZUcmgYyKEIFl2fNuoSaRltnVTFl37jdeXfL2CU1lGCQTSr6FJmDqAFOqS9D+GoGFj+FySCQPA1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+YNl78J7Kh0Al/guMR1GqVM33sQwnsbgtuy4gRpSBM=;
 b=4lzCwm0O0vQv0+rt1LA1OIgODZZDIY4AoXLuZTQOeBeUNUt3N6Q00Utn/scfIATdLfqufTHsPY865fJB/1SGN2YJ9EX9+J5kY+fuHAitZ68V+G4Wiq7tamihGd51hWLneS0YXVHylGGCLUNEO1wtnl9WWsWonnOKZKsS57FRGUjttC7FztNJePbpDzu8hFhdH88Ed9YQm3DSseqZ56xU986VHoCf1JMEtRP1xR++/KSGs/KeFFjzefs61qxmZnSSFojC0bq+T1PhTATQ1OSSRrY47lTLPqTV5eyjduPVwuDJCD7fzPTdN6UU8H/iusUBVT3YFq2peyZ/amIWjpMclw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by AM9PR04MB8241.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 08:33:33 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::a31f:d35c:5ef8:a31b]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::a31f:d35c:5ef8:a31b%7]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 08:33:32 +0000
Message-ID: <de77578f-a783-a241-3ef5-e74f49029bb5@suse.com>
Date:   Thu, 13 Jul 2023 10:33:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] USB: disable all RNDIS protocol drivers
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Enrico Mioso <mrkiko.rs@gmail.com>,
        Jan Engelhardt <jengelh@inai.de>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?=c5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        Joseph Tartaro <joseph.tartaro@ioactive.com>
References: <20221123124620.1387499-1-gregkh@linuxfoundation.org>
 <n9108s34-9rn0-3n8q-r3s5-51r9647331ns@vanv.qr> <ZKM5nbDnKnFZLOlY@rivendell>
 <2023070430-fragment-remember-2fdd@gregkh>
 <e5a92f9c-2d56-00fc-5e01-56e7df8dc1c1@suse.com>
 <6a4a8980912380085ea628049b5e19e38bcd8e1d.camel@sipsolutions.net>
 <2023071222-asleep-vacancy-4cfa@gregkh>
 <2d26c0028590a80e7aa80487cbeffd5ca6e6a5ea.camel@sipsolutions.net>
 <2023071333-wildly-playroom-878b@gregkh>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <2023071333-wildly-playroom-878b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|AM9PR04MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 509f0a94-ec56-4c86-f451-08db837bd703
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FXSsB/fH4ZtLoCCKvs0cjwfYzgZ4EFsiif5duEMPHep+QqzqlYGOr9b8lIMQBAslPrCRy0S77T9yD8fEOmApNQBwURdWWikXoThBWE5kyvg9m7jnBiNfvP3yfUGfrYmbY2Oae4zY0JBZYSV22lXB++X+S7zvsYYi+NZHOTRs0Uz2CRRKsx/ojtAfX8m2qnSzYv9GUqAMirydIqRojMDJE+R/VzrkitIZxoNMkyG3BrP3+PSB/mhwdOLFnS17xfl8oiYk/RpSDM98ux/dEDl5XGWY5ZuDdWpjs6eRvxISDUuRb91JDEfEmgHkdRFk8fYZUaVji2sLBbItkUT92Tw4J3zN/zvYHRwfANR6vC7x5JEVu9Zjp1LWp4f0enn2l+qk054qnnMPIpIoYACdaJYhSzbyxhSYzJcUF75Aqj3f+aZCELwM7SKdF9dyUS+9pF6YZKkC/vQmOnDjd0GXUCIUSGOVFaA3/YT7C39wAIsUEcZrHCzrngnLGEUm90HKpr5gI806g95N7Q5AiMqczg6hWtgaAPPx8Udn8yrTVz3f4eOi1CS1aiR2AOAHXZBufYx5ckF2V6DlyVhEEkmd8X4QLNYJk7ij4yMvvd2uiINOp3rRZI6hvHuVKNkp91jxv4zGlZ1A4co1gnZCs1gmATBYRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(6512007)(4326008)(53546011)(6506007)(54906003)(110136005)(36756003)(7416002)(38100700002)(8676002)(5660300002)(8936002)(86362001)(41300700001)(316002)(66476007)(2906002)(66556008)(66946007)(31696002)(6486002)(6666004)(478600001)(83380400001)(2616005)(31686004)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU56VGhONmNCMXA0NXc4UXQ4WXZxdUh4T2RKM296cG5mZmJFOXJ6aEZ0ak9z?=
 =?utf-8?B?YU5MQ0xBT2FmanZ5bDBRbG93aVFDQkI5YzlZdW5FOFkybFJXYjN5S3pTbkN3?=
 =?utf-8?B?dEZ1bm5WL2pvbGlNMmFUVUxuQldCQXVCN0s3TTd6dy9FSzVVRG94MDRPSzMz?=
 =?utf-8?B?MDk4WjkvU1k2NEJRdWdXY2daTWJMVzVmdFovSFlqUTNsVDFOekc0ckhzenFq?=
 =?utf-8?B?RENwN1JJMmtSVnMzQU1RTlQ4R3JLR2sweDBZaU4rb0JFeUdqSWEwc1NWOGFs?=
 =?utf-8?B?STZKeVFIKzFFMUkwQXlmMUpjY1UyWHpIMGdlTm1xdE1pcW5TR09HajRMZUtJ?=
 =?utf-8?B?VWgyVmgwUjJKcHpnN1J5S1BQYW9OaHZKTlBnRWV1aHdMUU5ycEpUZmVpcnB6?=
 =?utf-8?B?Wlk0ZGRnTlRUalZ4aTVlRnRLVStrT2xOY2VHeGJ1NGpyRmxNSjNCZWVyMmRv?=
 =?utf-8?B?dXhpRVh3RkdxVmZiU2Joam9INE1EWklxazBleFFrVHdkNEZ5TXFvcEdMSGRC?=
 =?utf-8?B?eVhLVGVYSjhmRFo3RnJiUm4rUnlDaFR6MnMyeTd1ZkFjNmVLdGp1emVQcFNk?=
 =?utf-8?B?dzZFbEhWV1FtZXBJSWZUVTh6SUZSekk0UXQ1aUpKM0tCMHhSQTdUYlhkdTV3?=
 =?utf-8?B?L0FZbUpqL1ZsL2lrN1l3c2ppbEt6M1RmU1F1amhxR2ZTV1lGUllYQzN3TnRJ?=
 =?utf-8?B?VGx1SittdWRJQ3Q5WHRjYnlBdmcyczhtTXJPWHlTRm5PNUp0SDMwYWtVdWxM?=
 =?utf-8?B?ZGRyQVB2UzJHU0dsVVNMaFh6RnNMVWFML1hzeHpobU44VlZLK0EvZTRrRVBE?=
 =?utf-8?B?V3Fmd2lRUlV4R3FId2x4UG5NU0N0R3VoMEc0OWFCWEJrRkxjNTBTVUhDV0gr?=
 =?utf-8?B?Sk5YcnVzSCt0R3FnWlB3ai9oZlM0cGRRY2xkTnNUV3pLSWxmRFFvczFHYVNM?=
 =?utf-8?B?VnJyeTVFWk55WkpkVG5VUGdMbFdTeE8yWDNOZTdubFp5UjBWbWs1S2lZdVAy?=
 =?utf-8?B?aU9SQk1aVWpBRHdpL2hsTmFGRWppeWtQZEhacnRaenV6elVGLzk1OTNLU21l?=
 =?utf-8?B?ZlZGR0NBdmZLSEZaV01hYVNWaiswbldsNTZJOVZwbnkrSFRaRmNrUktzNURk?=
 =?utf-8?B?QisrbzhpWkoxbUMzZzRldjk4cStaZ2hXN3QyU1IzYXBkcVVNeldYQnVCcHVj?=
 =?utf-8?B?TnhPRytpbFBJNEN6aU40RU5iS29WbGFVQWorTnQxTEN2TGJQb05yd2dqd1My?=
 =?utf-8?B?TEtpQTFvcEhqcUtJcE9STTBxL2NYOXdFU05oTjZ1VUs1KzgzeUliV0ZWbFpt?=
 =?utf-8?B?aW9OM01SaXNNQ0FXSkMxZWxITWJyeVVndzEyOVRqeGwzMUhJdjdXN0hVSUlk?=
 =?utf-8?B?TjdialVxcTFhaHg0bkltZlJkdkpXaGltWWxpQytIQVo2UWZjb2tyRmQ0Y3Z2?=
 =?utf-8?B?SThvZ05Rc2QzOW91dnlxRE1pdEpoNFJKV09iL0ZaaThadzFFWlVKYSttZEFQ?=
 =?utf-8?B?SWZTNlVXWkRIeC9QVUUzNlpXTmg3Z0xBalo1R2RmMW1NZGQxaXAwTnAvTFNs?=
 =?utf-8?B?N2YvTzFhQ1dtMDRVdGpFQWZ5V1NhWHhQQUZ6cEdyRk41M0VMVGlMd3F6dlZF?=
 =?utf-8?B?TEk0S2t3QU9yYlpmZ2pRSllsNmlGb2lWRTk4QjJiNm5tSUFzeXVldTdSWUZr?=
 =?utf-8?B?eEwyNjB6VUdTbGMrMFQvYlZsakNORi9pWDJQeStqOE1saXVNdVEreE9LSU9L?=
 =?utf-8?B?OEFobmdnR3B2aVhIZjdYNC9EZGQyTmtPc0dwZ0NnUmtEZ3pEejFMVW9QNDJn?=
 =?utf-8?B?OWtPU3ZINE5zT29nb1AwTGdRcnBrMWIrRVB2azFqZSswVnJCSXJDSzBPZ3RM?=
 =?utf-8?B?NzlOdnNmNUxyL0NqRTh2enZpM29Ud3J6dXB5UDFCNmZ2U2xPY2d1eTJvK3NZ?=
 =?utf-8?B?ZjBOd1gzTnVTbWNyNFRpWURVSVZyZ3ZNYUZuNXpVRUdNVS9mNGtOdmt1NDVN?=
 =?utf-8?B?N05IU2dmSHg5bS9qMFNmNDVOQ1dhR1BnUDVySWxNZ1FGWTN6SG1IaDNEVHJW?=
 =?utf-8?B?ZHB0OUlGekFOSGJOWWdxREEwUmhlUDlFbDJUbU5TcFNTOXp1UTE2SGpPU0tQ?=
 =?utf-8?B?SGVEeEJadGwyRnR0bFFjV3NGd1E0QVBHN0d5c0VlZFlzK1U1M0VObVNTOGds?=
 =?utf-8?Q?iZFrlW9L6eGOSw+aQNSllYo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509f0a94-ec56-4c86-f451-08db837bd703
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:33:31.9613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyNtASnWSTvVGWabfywZs8ZOMJhLlhY0qzj5v39Y7w5/e3V0FxGDG47m1sWj0h8eSRsyDDUZecPHLPJhrj78cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8241
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.07.23 07:34, Greg Kroah-Hartman wrote:
> On Thu, Jul 13, 2023 at 02:28:26AM +0200, Johannes Berg wrote:
>> On Wed, 2023-07-12 at 18:39 +0200, Greg Kroah-Hartman wrote:

Hi,
  
>> All we said is that your statement of "RNDIS is fundamentally unfixable"
>> doesn't make a lot of sense. If this were the case, all USB drivers
>> would have to "trust the other side" as well, right?
> 
> No, well, yes.  See the zillion patches we have had to apply to the
> kernel over the years when someone decided that "usb devices are not to
> be trusted" that syzbot has helped find :)

Well, there are protocols that are in a sense unfixable. Like,
hypothetical example, you allow the execution of postscript code.
Hence it is kind of important to keep that distinction.

Yes, our attitude here is inconsistent. With the advent of Thunderbolt
we should have gone through all PCI drivers and audited them for things
malicious devices can do.
However, we can wait for Pandora for the purpose of this discussion.

> It's not a DMA issue here, it's a "the protocol allows for buffer
> overflows and does not seem to be able to be verified to prevent this"
> from what I remember (it's been a year since I looked at this last,
> details are hazy.)  At the time, I didn't see a way that it could be
> fixed, hence this patch.

That makes sort of sense, but still leaves us with the option of verifying
each memcopy for being within allowed buffers.

Now, by no means let me stop you from getting into your supervillain outfit
and write exploits. But just telling us the rest of the issues would do, though
not as well.

	Regards
		Oliver
