Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E216B7F3F73
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjKVIDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbjKVIDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:03:31 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2102.outbound.protection.outlook.com [40.107.20.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DE9109;
        Wed, 22 Nov 2023 00:03:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUyK01ORtVIHkbG1lVGEvuMW5M5tWnGtRHyXFg3o5HGXQg6jnRnzJpN4hXywzOtfkdvzWy9aIuNZ2rH1YwZbnQ0e7QfhRmEP0hRcbLAEQ3tUHj82GnE5MIfb9C8Gu+PuGzS3KDn5DW4Mpwp45I3FsRu+QAiZQq6znuInAo/9Flv1Ys6wNJLmKDU97gidAE9uySPRB95vgPAIkgFEStOeMcMYL/GYfxf+303LPCZpNyts6qHFAqRANYqIvt2ym+c/Yi8lSFidBXCbKlBJDK+RwnZ/E1Fx/BlHFUhYEfWOOFik1lHzMgCCRAI6nOSfBH4vBBUSQxT3nm0JCTS7sTGR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAgK3fuzxlQTgoNVYbV3+0EctDIf1jD4cwQtow3r+MY=;
 b=GXqAF/j1cpcI2MFHZxPdRNBmgMqehkIxivK77A1kdfogaPG02yoyQtiH8PihoZXU7SE4/zCrWeXeN92TOq4glskPTdeEac3VF3B6u3Z1urBagPWDcWKCBKyjB414c4mbp3esX+s9lmlWuBVxQ0xO9XVzXAmxE5hZed6uDLS/WPW59gpOL6k3VG+PVOHCBaGdZAGu6aou0iMExf8pdgkf4QPGDQvwwcC/uS2BCIxMKvD/wvq4iZfh303ImnN0Xfj3uy8xVmUrnpTnJi2AMJwKFfDc0S02rj2Zn6ZBSXduCijIc1cfVT4nL/y54fajfBKWEj3RBXXdrchc1LeyE01ZMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAgK3fuzxlQTgoNVYbV3+0EctDIf1jD4cwQtow3r+MY=;
 b=kMde7o1RzHP9K9yloLPnfwRLvniFCQ5nE3C1yiicTGlEveYaq9J+6OgWGXsJlRkmMQjTU7174MHbRW7yJbV6+vmL8H7kcIwLINaA6L1T156LA1ZCmke96aRcHlv+r6LT5+fYnvhG0+DGRFlhQ4GtyMXERdVq5RbP9KlcWu3dIpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU0PR10MB7566.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:402::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 08:03:21 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15%5]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 08:03:21 +0000
Message-ID: <5ad44085-c90b-4a88-bb7b-8ddc2b612793@prevas.dk>
Date:   Wed, 22 Nov 2023 09:03:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: imx: also enable Transmit Complete interrupt in
 rs232 mode
Content-Language: en-US, da
To:     Eberhard Stoll <eberhard.stoll@gmx.de>, sherry.sun@nxp.com
Cc:     festevam@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        eberhard.stoll@kontron.de
References: <AS8PR04MB8404D066C247F5B2979CBD1F92BBA@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <dbe5959d-2b68-4f16-89ee-32538aab4f34@gmx.de>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <dbe5959d-2b68-4f16-89ee-32538aab4f34@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0058.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::25) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU0PR10MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1054c1-e901-4f8c-573b-08dbeb317e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ysA3yU00VgON482BtLi233szovwNYIL0e7eeZJVhR2KtLe7S7uPTQwxllRcfqxA7G1G6YF06JZLCe1a0V4iOh/3Isn3J56y7N3dxXnTYhRmvapG97F21ND01o+12PbByqhDfyO0Nn47JdLT0YRfzUm/bbCLUSbQ4Tr+dZ1GTs0sfhpS0PHcsAma+emR9spJwIy7pD9ingBVEBvJ600o/06rhyQCJSfE99wL5Lm2MpRmnHOhGw8aRhOG4sQhYOVY4WV3jcCBBEvpSgtzmOQGi5awEAwbmyBXRN3nb4rw2WfwO1Z2fIM9v0y0u1OLiEN6dLk8RKgZFO4VjWuvQJlpOxdRZZcBHhage4jj3nEQzl/9p+UoUbFoIvbdBY3rIeX9MZzGB3o63J5rrFzzSDkdmwBwqO2SlhsiKUdISBNfnE3wWK5mbDa6AxGHSkgPw22rvC772zPYBMxuqp3ne5O9Gv4wDFHe/K3LPAKRSAe6mqOWOPSau6dHN5kwoU6Jr/n0qLKiWbkV5NX9UaqNQoXPzWDBJwbLi3lDjpcxeqCPzGBsadkP6a0SOCNrwgquxfFqGJtko5SBDC+pNBW1VOHd9O7lWg7yqpDjcRZy8VdGQGGeUJii/OzDb5QP+eb9TcDlSrOcfpnXOx9uEY3p+cj7FtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39850400004)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(4326008)(316002)(66556008)(66476007)(6506007)(36756003)(2616005)(6486002)(26005)(6666004)(6512007)(478600001)(38100700002)(31696002)(66946007)(83380400001)(86362001)(44832011)(5660300002)(7416002)(2906002)(31686004)(8976002)(8936002)(41300700001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3F1RTB6NHgyanBIT2w5MlQ2NUpOYzRjQlpVQ05EUjE3dkQ0QnVsNm94ajdn?=
 =?utf-8?B?bFVaZ2IzTitqMUt0ZGZ6azg1WjRscGdQT08rZWtPV3p2L3Y2bFVKMmhlWHVs?=
 =?utf-8?B?cDg4NHV6M1hZa3ZNKytnTW9TU2JnNnVvd1Z2MURkVHd3UTlaMUQxWTFVVkM1?=
 =?utf-8?B?aXVpQXNpUGNwQ2tyUWhyMVV1U3Npb2hNT2l2aEU2Q1BYdjlXeFA0dFAzeld5?=
 =?utf-8?B?OTZ4ZDJuRHYvbHFTL1RZMDdaN1N5NW1RRGdENG1vM0ZTMUc3UTdLdThrTWlv?=
 =?utf-8?B?dlRVeHl0S1RjOGJRN2NaRVRGTytFMUhCNkVNNkRqQzdBUkFpNHZUOXZrYjZ0?=
 =?utf-8?B?a1NRVFlLc2o0d3NpZlZwKzJDNDRsVHJONldKSnpzRTc3emdhQTRNZFNhQnlH?=
 =?utf-8?B?SjlSeFFlYVFhQVhFeUFJekxrTnZQcUl3QWNFaWQrcXp6eTJ0SzI5TGQxRktz?=
 =?utf-8?B?eXN3WEZlNFVTYXlac2VKVkN0MENUTjBnU3VSR09ZTVBhRUYwNkZGSndZRTEw?=
 =?utf-8?B?WGprS2ptSktGYXVSVHRLVm9rb01FQmNlcC9yMGZ4ODdRS3QwaEszbVlxbjVO?=
 =?utf-8?B?c1VMNjN3K2JRZm8xR0Y5dUtYblA0RUYvN1N4cFV5ZXZreldCVUg5OExpNXBF?=
 =?utf-8?B?L0RCSjAyejJMbXljNjRmUE9qTWxtQnpWZ0d6WEhwNDJlS2crMy8rR3Vxand5?=
 =?utf-8?B?aVh6bzJ0KzRIcnhQdk9nNDZRK3NMVm9OTm15WW1hL203VVdDZWxEdDBNelhQ?=
 =?utf-8?B?NW90c3JOWmJBTDI2dVc5aEplOExsTlJ0RkMwdFpOTEJSQURvTVY5RjArMlFy?=
 =?utf-8?B?L2VuUndOL3BnK1BiUi80Nk1QNzQ1ZjF5dDBrK1Ercm1LUGtWbHFZRnJCdDVw?=
 =?utf-8?B?bkRMY1ZqQTFnTjh1Qmg1ZjZwYXB3V1BHRkx5dmVVTndkK2RxczVTT2J0UTZQ?=
 =?utf-8?B?N1l0elM1NUN5QzJvTVU5bXNPMzBIMHVlN0pvRUVnTWxJMWxaUmFYdXNBQzdH?=
 =?utf-8?B?K0ZvZzZmQVRWUmxrR09ERlRrWWVNeTRPdmdIS1M5VmRTd0l0WWFPdjZSbEJV?=
 =?utf-8?B?alBMM04xMS9JNThPNjkzbVFDT3g5S0JvOWd0TWJOaU83b2cyRkNDbFpGNmxF?=
 =?utf-8?B?SldBR3dCNWUySE9WbHkzd3dDQU91bFlQVzJWWDcrRWlVekNBUTdUM2w4bXo3?=
 =?utf-8?B?RlpyWkQweDlOUVVGWVppdUtSUHRDUURPSHdnRzVTUWt5YWJqbjVIUUZqajYy?=
 =?utf-8?B?dG1EL2R6aVJRZ1ZzVjFhQThVMHhrYWlGQ2dDOVJhKzY1RXEvOTBhNGNJaGJx?=
 =?utf-8?B?Z1YxbXpiQkdDM3o1RWU3SG83aEVWRWdGTVNMNE1aekdCR0pDdnhjaE1XRDlH?=
 =?utf-8?B?OVJESFM4SmhWV0wzL1ZBSW0vcW53T2RQbkUzRG1QUnZYeDV5dy9zUTN2MW9n?=
 =?utf-8?B?WFhhMmU0VWRBbTRnWDFLcVRnV0YvbDA4VkpxRVloM1lBM2ZvYkxSakNZR0JP?=
 =?utf-8?B?anlKWHlBa3pobWIyV2dENkxqcCtXN0tnY3hVSFA5OStKdktMYndaaXdRQ1lj?=
 =?utf-8?B?Qnc2eWpEVDVMenBodEhBdHZ3NlNJb3E4eFFrL01uN05waTVraG14WThOZDll?=
 =?utf-8?B?bUFJbkJ3VWJPOUJNZGVrb3d2cmo5SWxOWVNjZERRdURlSHJtUGdPSTAvc3BM?=
 =?utf-8?B?ZnBpM1I1ZVlhcjV5SzBMUDhuMVhTWVRlR0d3SGYxdFo1ZEpraUZiSENURHUy?=
 =?utf-8?B?bnUyeTFjMGs3cnNNSWxlQW9aOHlrbnR1Unh5TGFrS2xUTE1jRllvdW9oWG9x?=
 =?utf-8?B?WmlkdlRUUTU3TnU3UUJLSDZGVDQ4eVZMa1JLdkx4SWtIVlNrcTdHUC91YjJO?=
 =?utf-8?B?Z29zVytIdGt2RzV1WUF5UlRLU3pMN1VtV0NMZEFDYUdJUFozbFpzeVJIWWJN?=
 =?utf-8?B?dzVDanJmL1Jyb2ZqREZOT1pZd2pxd3RQWkM4aE1WOVVpYlFXckFObzI3cFRn?=
 =?utf-8?B?ajdqN0htb01XeUUxRnhJNlF3Yy9rME5UcHdsd0JiOFBCZjlpSW1Md214dTEr?=
 =?utf-8?B?UmJPZXJ3MzJtcG44bDR2VXg2SFhpY1pWVFRxUTdjWUZoTEFDOUxyZkdXakww?=
 =?utf-8?B?dkw0NU14cUN2Znp2ejMvL29DNG0xL2h0SkxSRVBtSHBlcVZ1K0dNeWV3WUls?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1054c1-e901-4f8c-573b-08dbeb317e5e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 08:03:21.1353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1hGu2SCjagYUbMWPQs62NcNdrs0WfT8hxppsvWsBkElbwNLXr7AUkkt7Ur90rvzOQP2X++C6/xuj/79nvRqC0xqosQk5imWqH7FNH29tQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7566
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2023 21.49, Eberhard Stoll wrote:
>> Currently, if one switches to rs232 mode, writes something to the
>> device, and then switches to rs485 mode, the imx_port's ->tx_state is
>> left as SEND. This then prevents a subsequent write in rs485 mode from
>> properly asserting the rts pin (i.e. enabling the transceiver),
>> because imx_uart_start_rx() does not enter the "if (sport->tx_state ==
>> OFF)" branch. Hence nothing is actually transmitted.
>>
>> The problem is that in rs232 mode, ->tx_state never gets set to OFF,
>> due to
>>
>>     usr2 = imx_uart_readl(sport, USR2);
>>     if (!(usr2 & USR2_TXDC)) {
>>         /* The shifter is still busy, so retry once TC triggers */
>>         return;
>>     }
>>
>> in imx_uart_stop_tx(), and TC never triggers because the Transmit
>> Complete interrupt is not enabled for rs232.
>>
>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>> ---
>> I'm not sure this is the best fix.
>>
>> At first I considered doing something much more targeted, but
>> definitely also more hacky: In imx_uart_rs485_config(), if switching
>> on rs485 mode, simply add "sport->tx_state = OFF;".
>>
>> If someone has a better suggestion, I'm all ears.
> 
> 
> Hello Rasmus,
> 
> i can observe a very similar situation, but with a litte different
> configuration. This is how i can trigger the situation very quickly:
> 
>   1) open the port
>   2) send 1 byte out
>   3) close the port

Hi Eberhard

Thanks for chiming in. I assume this is all in rs485 mode, no switching
to rs232 and back involved?


> Do it in a loop. As faster, the lockup may occur earlier (but not
> mandatory, 100ms is sufficient in my setup at 115200 Baud on an
> i.mx8mm board).
> With this configuration i get the lockup in around 1 minute.
> 
> For my setup it's clear what happens:
> 
>   - when the tty is closed imx_uart_shutdown() is called. This calls
>     imx_uart_stop_tx()
>   - for a lockup, the shifter is still busy and imx_uart_stop_tx()
>     returns early (as you explained) without modifying ->tx_state.
>   - imx_uart_shutdown() proceeds and finally closes the port. Due to
>     imx_uart_stop_tx() is not executed completely tx_state is left in
>     state ->tx_state == SEND.

Yes, and imx_uart_shutdown() disables the TCEN which would otherwise
cause _stop_tx to get called when the transmitter is no longer busy.

>   - When the port is opened again, tx_state is SEND and nothing can
>     be transmitted any more. The tx path has locked up!
> 
> Setting ->tx_state = SEND in imx_uart_shutdown() helps for my issue
> (and should be ok IMHO).

[I assume you mean tx_state = OFF]. Yes, I suppose doing that would be
ok, but I'm not sure it's a complete fix. In my simple test cast, I have
separate programs invoked to do the I/O and do the mode switch, but in a
real scenario, I'd expect the application itself to just open the device
once, and then do I/O and mode switching as appropriate for the
application logic, and I don't think uart_shutdown would then ever get
called.

> But IMHO there is one next issue with this situation: When the port
> operates with WAIT_AFTER_RTS and WAIT_AFTER_SEND then some timers
> for callback functions might be active. I did not discover where they
> are stopped for the case when the serial port is closed. Maybe stopping
> is not required ...

Indeed, that's an extra complication. Adding two hrtimer_try_to_cancel()
in shutdown would probably not hurt, along with setting tx_state OFF.

I wonder if at least mode switching should simply be disallowed (-EBUSY)
if tx_state is anything but OFF.

Rasmus

