Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0360F7F264E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjKUH0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjKUH0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:26:38 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2110.outbound.protection.outlook.com [40.107.7.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B201CB9;
        Mon, 20 Nov 2023 23:26:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfW0swxyWvoNWrgSw/AXGjKo4mXMusu+LOsWkBFuPAwMH2Pt7XV3jleeeY+phyKuhxFvUgZ3hsIlj1jSG/MlS2r54RC83Z1XhHCPWZbYU4MY8a1lmv7UF9ct3W4me7k6D/YBXPk+iudrVhli37Q1A46RicoIiVRk77p+w1tlPLf0bnHZH6lrsyXFbI1qXdwqclzAQH8EyDISBlQdhAkl3citcUSl+ZujZLaaPOxDGtiO7/ADiyAN100kSixytsKfy9E+KkNJHqYZyKg3d+EPDWNCmcIudI8mq/TRWzoxSRqdbpVfxqJGPE0F3yO719B3m7MuZuztBC1y33OMOQgu7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEWkpQtuZugkvVRSLq9SXqd5vstsL4KKuQmrxYMgpGA=;
 b=Fyew4isYmXecGJBsJVMaoi29PykaeY73IToVJpKhq+dgaR0CYyAAjVQ9AUvQWquc2EKHmGSMSgXo4EBT90KtA/eWhb2W/6e88OvAPtiMoEh3dCgYpp2YcqA/X5MUlRAiC9IPnpXdX14jbisLxagY6TSGT7aPa04fcQ4zTZzuV43jP3DQ5q8I51JX+UqVzj8F5XWuX1HHSCs6dTV0lIi0MghymS7oulSuW7n/sokmuPQbDZC+LCJBV7ZNjobl9i4MVYQ/3IS1Ip7oGnnJpMNfATypqXYXBgeZB9fhKoH7YVt+UU9WiwT5a1/m2R227nFZq02GvLTr7Eqs7pm5sRN3qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEWkpQtuZugkvVRSLq9SXqd5vstsL4KKuQmrxYMgpGA=;
 b=WpWQErYdhIpbkay0U4CTGX6cRjbRyA0Zf/jUaXpn308PQ8PrrSv6sHEZ8CCdI1TcpjJr942IQiCDFI1ZG9Yh3KwtYFkPLsc2805FzkY+sjc60xnaFV+udEeh2oDpbWK2mjpXUzUg3AZnWVg4hYzV0cTXvfmV7ZnkENFvUgHnr2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI1PR10MB7753.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 07:26:27 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15%5]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 07:26:27 +0000
Message-ID: <4468f900-ce41-4227-b691-d9146b837066@prevas.dk>
Date:   Tue, 21 Nov 2023 08:26:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: imx: also enable Transmit Complete interrupt in
 rs232 mode
Content-Language: en-US, da
To:     Sherry Sun <sherry.sun@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20231120132256.136625-1-rasmus.villemoes@prevas.dk>
 <AS8PR04MB8404D066C247F5B2979CBD1F92BBA@AS8PR04MB8404.eurprd04.prod.outlook.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <AS8PR04MB8404D066C247F5B2979CBD1F92BBA@AS8PR04MB8404.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0082.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::11) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI1PR10MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 956582ab-5aa3-461b-16be-08dbea632ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UauU4oj6yP1nf0WO823IwXcMgsY+K7GMREzGC/vNzEDXx7ejBf62T7qfR5qEs05U02WqV6rjkX+WS1pUY3074vWEwzpXyXk2CERMa40AAm4qT3bGjXGQ7BC1RvwLtbTHVsVIO4vaTC16x7wzbKYVNXchtJWsemQrO/v6UnZ0xGs45zacsRIiFhuBbOw4LFEEq+RLLnmve8sWDoPkEM6leSf2Vxxmt0qq4/+YobCJ7zqeGzdYzEQv5PmEtNMLxaupdn8LnHUzBz5invslloak9eePRP7GPIh0WCwW0xd4kee9jJ9qKokx5OOgffA94suisbZ1ZoSxN26ifbjUjr4GKsyQo1w4h2ISc355E+pl81+7oK9q/n+rvwY0em+S+9WK6JEXBquSVUufp1uPI4SpyY4G3xZpsGs/0shN3gctq/V/x5rAH6AYFaiss14U/uDvkzOi/IZSxda7UI58UjB7IRCAvAu158vJtO4bOuyKGMkWC+/jgY/3ao3pHuxq7GqfcaUZ12PcoYWWbW0XA+nn7qbyVDEBoxJbK9oky+cjlU79bfisf2ALMEH5K1yTIWohc3HBdPBOKUpPdlL74YnrQBFOFsOxzfKauadTr/0WN1TzgaC2KUpJ7wcSWXSWwpLCKaX577+3OQKqqI0cSoiImw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39840400004)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(38100700002)(86362001)(36756003)(31696002)(110136005)(66946007)(66556008)(66476007)(54906003)(316002)(8676002)(8976002)(8936002)(4326008)(41300700001)(7416002)(5660300002)(2906002)(44832011)(31686004)(53546011)(6512007)(26005)(2616005)(6666004)(478600001)(6486002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzZhZm1RZ1piaHNneFJUdFhoSVNhQmhBbnkzTzM0Rzl3WmtDRDRUK1M4c09T?=
 =?utf-8?B?NEwrQlFxK1UzWkRqR3Bwa3AzZ0RmbGhrV2xJaWxpYWplS1JHSkVtQm5aWWNP?=
 =?utf-8?B?dTkwRzh0WXQ5ODlvYktGSGdhd2syTE9iY1JESmdqNUZ4SzRSaVJVc1d3SXp0?=
 =?utf-8?B?dkIrSVVtVE4rWjdkUG9HRkZCd0ZpenUvMXVNbjJqbm9Gd2JuVW1yUzIzTmxp?=
 =?utf-8?B?RHVqZ3paTEFDQmRQRmJNZXh2NU9WWlFtZkJqeUV0a0c1L08vRjRaV1Bvd1R3?=
 =?utf-8?B?TEdoNk9zcVNjWHMvTW04ZHVmWUdENzZCbFJtOGI0b1hrakxWd3FXZnFOdkJ2?=
 =?utf-8?B?bmIxYjJQcThpdStSRWNub04zemRpb0x3QWEwZ3FNQ1F6ODhwbVZtSThIMjda?=
 =?utf-8?B?UXJQbGxCY2Q4bW1LeTZMT3MyZ2Z2emtnWDVPd2ZQMGg5ZDlwOTJKMVFYN2RG?=
 =?utf-8?B?cFdpOXQ1a24vUkQvRk5ndmU0LzZBcXNJZGdQN21DRkdVTFRwQW5pY2wvbWNi?=
 =?utf-8?B?cThFS2Q3NytsMTMwU0E1bGpOL2tna2wvOXI2QWxQSmZ4eGthV1ZqMXVSeGM5?=
 =?utf-8?B?d245aEtNSmJBNnRqUjlkSUJPd3R1QW85bS96dGh4dHhjUSs3TFBxZ2ZrcGsv?=
 =?utf-8?B?Vnd3OTJCeHBkQVFEWlhpd0JicU1jbG9EaUN4VXFOTzlMWEZnMG5paDZydmJy?=
 =?utf-8?B?V1JUSWtoUUNBNmNiVms4L3pwcVU1WS9raDRXTjJBZURySVlneHNxVENkMWV6?=
 =?utf-8?B?bENOM09KWVl2T3JNWVBENDdWdzUzckltYUR3aS9NM2N2UnREUWNaTk5sTFdl?=
 =?utf-8?B?UW1kenIzcHNMaVBqWGhoZklZWUJleFhJaU81SWVxdmtSSWQ1blE0VnFxRW9C?=
 =?utf-8?B?Z1ZwTStwd0Y3Qm5EZEVGLzZPNlJYYW1mZG1SeDFweE12b0FWR1RKcWdNcWNU?=
 =?utf-8?B?VVhDc1RvL0NPS01mTy9PYWc5NzNMNHVMQWpmNmhIbDRkaExsR2lMOXZJWGRY?=
 =?utf-8?B?R3FzZmFuSWhOTWZ0UU1wMW1SNlU3MUlFU3Zndy83NXNuMGRQbHhYUVZGRmZ1?=
 =?utf-8?B?MEd2TTNHSHZWbHU3MFZmUit6NDZZZG1YazJGTDRDd292NGVPWlZ1K0lQNEVH?=
 =?utf-8?B?WTNDZ1hwTVFpSzVnMlpqZ1N1VGtld09WTVBId2IwcThISlZRV3E5aExxaVdF?=
 =?utf-8?B?UTUwU2hOY0RNTnVZY2djeTRuOTFTMmRSekUwdENURG8xdXA0N2s5ek9Idzdl?=
 =?utf-8?B?d0VZcW9lZngyTjhBdHNRZncya2JjaU9Lb3l5N1E1TFpsa0YvTk9OdS8wblY0?=
 =?utf-8?B?NndkR0RmSmtrbVJ5M0xNT2pvY0R1WUFMRjQ2ME1UN2NYV0ZDQ0hhdi9UdXNn?=
 =?utf-8?B?QmdJZUc3OVYwYVhDZ243QVZJYWZRWENLdm13V1JuZmtXS21DTG9HZ3pRd3NE?=
 =?utf-8?B?eDVyZDdjQzVYMVdCVitkYkQwQ255UUNncThZQVlQVjlYckN5ZUV1UFVQR0tU?=
 =?utf-8?B?SUNsdUlKdFd6OTM4MEYvVEVtWk9MbHZHSHZPRk1uNm9tbGZVdWlvS0lMakMv?=
 =?utf-8?B?RUtETFIyNE1oaHkySEN4cmZwTlRqZjI4cGp5bFVKSUNraFk2MEI1eWMvQjRH?=
 =?utf-8?B?OVA3T2dvcUUvbko3VU9PK2ZTLzdmVnFYUVlYRU41MmhtQ2ZwTUFYL0RTZXJ3?=
 =?utf-8?B?MEVPdHZsbGx4cW4rZWpXb0M1NTQ4aXRNaVh1MHZOYThWYVVLT0pYS2REblp5?=
 =?utf-8?B?bm5hTlhZcHFsZHRDQ1pOL0YyVVlDTUdvcnJqN21XWS9aYW9wdDlFMWwxSEpC?=
 =?utf-8?B?MzZ5ZDI2NmNXZVJPUm9Wa2paMVY3YVFFbFQxd1o5UUc4RGpmM1d1UURYWE55?=
 =?utf-8?B?amFMRjFvd2U4Z2FYWDJjOGhzK1FON0x6UWt2alRRbjFTcjRaUm1iZ1VpQ2hu?=
 =?utf-8?B?ZzRmYm1iWlZQYU9YeVdqemJXMEE0N3VXTVJ3WHVXL2dES2k1d2VmYkxZSjg3?=
 =?utf-8?B?cVBhRWVIS1NWZ0dleXhqWHZLL0hpV3dVZmNSMlM0S1JiVnB2dWt2RFRCTENy?=
 =?utf-8?B?Q1VRbk42MkhVSUlvWHN5WWpDZUIzT1FSdnNpMTk2ZWFpZm9RbkF2SDZxVExI?=
 =?utf-8?B?YVNIMjhVOW1RSW1PU0JLekUraGV3WXd0QzRBek5nb25WYjVXZEt0N0Uvcy9s?=
 =?utf-8?B?UGc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 956582ab-5aa3-461b-16be-08dbea632ca2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 07:26:27.5764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nl0qts5vOQSenMBe40gnIQdcMv84GIgEM8oRW/lOXHCQVS5fN1qHrr+zpTq8RWJJBim5OlLHbQP+gLWLHJwI9hmdxV7XUJkROrjQZnZAmmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7753
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2023 07.37, Sherry Sun wrote:
> 
> 
>> -----Original Message-----
>> From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>> Sent: 2023年11月20日 21:23
>> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jiri Slaby
>> <jirislaby@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
>> <s.hauer@pengutronix.de>; Pengutronix Kernel Team
>> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; dl-linux-
>> imx <linux-imx@nxp.com>
>> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>; linux-
>> kernel@vger.kernel.org; linux-serial@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org
>> Subject: [PATCH] serial: imx: also enable Transmit Complete interrupt in
>> rs232 mode
>>
>> Currently, if one switches to rs232 mode, writes something to the device, and
>> then switches to rs485 mode, the imx_port's ->tx_state is left as SEND. This
>> then prevents a subsequent write in rs485 mode from properly asserting the
>> rts pin (i.e. enabling the transceiver), because imx_uart_start_rx() does not
>> enter the "if (sport->tx_state == OFF)" branch. Hence nothing is actually
>> transmitted.
>>
>> The problem is that in rs232 mode, ->tx_state never gets set to OFF, due to
>>
>> 	usr2 = imx_uart_readl(sport, USR2);
>> 	if (!(usr2 & USR2_TXDC)) {
>> 		/* The shifter is still busy, so retry once TC triggers */
>> 		return;
>> 	}
>>
>> in imx_uart_stop_tx(), and TC never triggers because the Transmit Complete
>> interrupt is not enabled for rs232.
> 
> Hi Rasmus,
> I am afraid this is not right, USR2_TXDC is just a flag, it is not affected by whether UCR4_TCEN is set or not, UCR4_TCEN only determines if USR2_TXDC flag can generate a interrupt or not.

Exactly. And when TCEN is not set, we don't get that interrupt the
comment refers to, so we never retry once TXDC gets set.

> I tried on imx8mp-evk board, for rs232, sport->tx_state can get set to OFF even we don’t set UCR4_TCEN.

I am working on an imx8mp board, so I can definitely tell you that the
code currently has a problem, and this patch fixes it (though, as said,
I do not know if it's the best fix or if it might introduce other problems).

Yes, of course, due to random timing issues, you _might_ see that in
rs232 mode, by the time imx_uart_stop_tx() gets called (most likely from
imx_uart_transmit_buffer()), the transmitter might be done, so we pass
that if (!(usr2 & USR2_TXDC)) test, and get right to the bottom of
imx_uart_stop_tx() where ->tx_state is set to OFF.

But in many cases (it reproduces completely reliably for me), that
imx_uart_stop_tx() hits the early return, and if the Transmit Complete
enable interrupt is not enabled, well, then (referring to the existing
comment) of course TC never triggers, so we never retry, and hence
nothing ever sets ->tx_state back to OFF. And that's not really a
problem as long as you stay in rs232, because that mode doesn't really
use the ->tx_state state machine logic. But switching to rs485 mode, and
the driver is left in a confused state breaking output (input still works).

Rasmus

