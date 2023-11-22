Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C3B7F4748
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343910AbjKVNBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343921AbjKVNBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:01:34 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2136.outbound.protection.outlook.com [40.107.247.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5229A112;
        Wed, 22 Nov 2023 05:01:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/9EaEOkEuZpqVeHayvf/4O+kEa2AcHP5MsonGEtQnWwI3G09C2TtGcu8NAj2NESq7SoUmdMKok1b/ch1g/06cdAyMOZeojm4oyEfC0bQ2SeUEQdRJ3uYPPt1X60vToVN54lTwPvuZ0KK1gWRm8DKL14q6OVdO12bxENo6SiTolhGzGzizdnrEOaf7H2BrxXRkCT1w9KUJwQxNJTs7NMW6EfzKul1FccJyqf92q2XlP2ZBjnJvVr6yPaxBe95erowIUaefZCVMBymRuV3N09yXswe9EnsJqdD0q+2ssxVEVtjvlo/9b9EPUQ3KzrXVfCNTm0go4aXi30S/KTp8MgFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAodpGU12B3fro9b6KFQvhS3rtXF0uGCqs8XVxZH/Ko=;
 b=n1CqSg7MU6P/bUgK4SyBkZ3WzU5+MSD6YjJqw8vLaoYqXzAP5ujwn79lxqiJ+ZqJ8/A9WzgU6Nu2iPvCy5t4cI8kne5EDdYGJXvszz3J2X/aRjmy3tzVNjdKbqDS0fk9CrOE/KgzuD/PmaI74d20bvKj9008UKvQu8fBWG3VCXSEwC86CSvft7Pq0/KIPL8rPp2fj6Q0Ku1EyxNeyTnb1kDuOB6Mg3Zi1GFEGgBdK0KHQDJnKE4VByyyKTn76ZVaR/sg/9HvHKVesYozBkTsElN/7qM7ecCtKSRUwtNjC4/XXmEY6Qt5b0agN8c308VWiksrfZgvvG9MMS4dHONTaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAodpGU12B3fro9b6KFQvhS3rtXF0uGCqs8XVxZH/Ko=;
 b=MUgnYvTyNW8MQuDvG0s5lJJJeN3MMvKXaWuV1fjTJXzyD62u9XI37nVuCs/1GQCln3K5S1YYvRczo4Vqov7kSBTzjJSW0HeU/sAFIIGeEOGqAQIGpD/UZG7QN1PlTKszMNXsXgi870NjbHzo8oLtUF19/uLrYnOg03KCoelNDGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PAWPR10MB7747.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:366::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 13:01:25 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d%5]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 13:01:24 +0000
Message-ID: <fc843c33-03e4-4603-9cc9-0b30b2c21c66@kontron.de>
Date:   Wed, 22 Nov 2023 14:01:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: imx: also enable Transmit Complete interrupt in
 rs232 mode
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Eberhard Stoll <eberhard.stoll@gmx.de>, sherry.sun@nxp.com
Cc:     festevam@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        eberhard.stoll@kontron.de
References: <AS8PR04MB8404D066C247F5B2979CBD1F92BBA@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <dbe5959d-2b68-4f16-89ee-32538aab4f34@gmx.de>
 <5ad44085-c90b-4a88-bb7b-8ddc2b612793@prevas.dk>
Content-Language: en-US, de-DE
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <5ad44085-c90b-4a88-bb7b-8ddc2b612793@prevas.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0311.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:85::12) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PAWPR10MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: b09cfec2-5899-41fb-ad1d-08dbeb5b2193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8nsr9io37FhBLXZcbr1NVBWP0gTMoYtcjIOd81pjzwb9/jCEAieDWVVAV80B+F+QpG5CgFOv6vBLpgwTpi5Dl+d8GPLrL4xP+t/Lap6czd8h/slMf93bz4NvdQc06o592XOfX0LJs+sS4DE54fZoGhzt7LeEG0n/SKhtUB7OFcK4Tk9m1eovJVnXrx67JI0t4g7QDHCqDIAbtfHUO3TGNJMAL3xjEiiDW6X3qlKw9PTtzt3uK49ZwDbdyZu6PK/2MXvqFlVSno2R1OK4xINhI7JZBJAK1EOB8S1sXJ/cZWn1XEGvq1hoS0HQBUVt6mTsBe9kVRtYVj18/f4mKGPNSz0rra7TNFWNhNpJFT0m93xpMBTjLNjDKYpVKCRw/wdVHucNSHuq2rZ92cUHBMLg+/3rwgofiO2lPHRP6RCz9xWtjMfS1Er2ANB1WzMjvo7c5cVAg7dxTGyH/c9P2f0coXFChROSZnDWPPf5PuwIqeQK1iQZpBLbeMx2KJPdNlk2Ee3gLhgurVxqj5Ml9mqYfGVUsnwoyxizn9hvwsl62FIhJoIIA+N25pAAobpiEXUF7U8NCMF7UCQamjd8O1p9cjW+5PLXrc6xLdXMuW6KWXC3F/Y8l+X2w5FgbkhwKaXITbq85qGk9n2/MfVT13W7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(26005)(2616005)(6486002)(6666004)(83380400001)(6506007)(53546011)(6512007)(107886003)(8936002)(4326008)(8676002)(44832011)(41300700001)(478600001)(7416002)(2906002)(5660300002)(316002)(66476007)(66946007)(66556008)(86362001)(31696002)(110136005)(36756003)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eS9lMHdGRFRHMC9TRm53RlBndm84cjZ6eTB3TU9rLzk2cjVhUDlWendXSEtM?=
 =?utf-8?B?L2hDckFqKzEySnBKbjdLTG1FS3dMYnl2Q3p1c0FFc0t4WEQzSDErNHJPdUgx?=
 =?utf-8?B?T0ZLMFYzV0xDOHpBSmpPb0JSRFVWeGdrcURDd3puaTZET0RGZDd5QkpCcDVU?=
 =?utf-8?B?Y1ZFblFjMU9BNUR6T0xUeWlHRlZLMDA3T1hyTDZWZWM1b2hnWTAvSkNtYVlK?=
 =?utf-8?B?UlFuQ2dtMGVjWno5NFAzR2d2bkhaaXJOcW5jZ0dMNTlLODVwSjR5ajAvM0s1?=
 =?utf-8?B?RHkyUEwxdytSblV1eWREWWx5TWtyc2RQdTArZHNlTHAxeHdUVHhYeks1ZW9M?=
 =?utf-8?B?bFlrTXZWZmR0QVYyQ2pHdS9FK0hicGtnV1R6ekJiOGlRaHBmc3BHVjgvQmVa?=
 =?utf-8?B?UllZWHRCZ3daeWY4RlpZZVhpWFkyaVJWV3hEaFdFd245V2c3VUdtcWJqaG9n?=
 =?utf-8?B?dkNxQmcycEhUYytBaE1OQ01seUxnc1V1UEJZaGc4V3JTR0FhbHg0alJUNjVk?=
 =?utf-8?B?VWJ5VHJaSjluUnV4SnNCY3FHZlNjVTNwMk45cUxmLzhVMldoUFhvaXJnMElz?=
 =?utf-8?B?NmczaGhUU1Z6WTdLUmtNU0F6R04wZEFwY2xmR1VPYXlnaTZyN2o0M3VsZ3Jz?=
 =?utf-8?B?a3M3SjFUeGpUQnEwWnlNQkVCSlBoMUZhY1V6ZWROT1pvQkRoamgyYnNnNVdC?=
 =?utf-8?B?dWwycFdwbjZOUmlUQTJ6bldhWW1HeUcyRGRtdFJwL0IveEQ4K25WQzg0NSt2?=
 =?utf-8?B?Y1Z6bWw1MFJ6Q0tteEJVZFZJQWl4UFRSN2d4M3laOGFWRlhSVXRjM2JHU28v?=
 =?utf-8?B?M3VXSkh5c0NZZnBwamJRc3F6bThpQ2E1RW9IWjR3MnIyZk9NS3UrZUY4TExw?=
 =?utf-8?B?TDhlTmd1aGVZUDlSTHhudFZqSnJxNW1pV2g3N09DMUV4VmcwVWx4cUNDMUJM?=
 =?utf-8?B?cjdWVE5EaC9QWjIzQ29zSVdvS01VVXhyL3FNeHM1SjRJaGYzODJXNmRZdEc2?=
 =?utf-8?B?Qm9YNGtGMkQ1K2E0L3VOU3pXZU5Bb2kwWGwrQjBuMDd4T0xmQ2JxNzM3WGg4?=
 =?utf-8?B?ZjJqaExuWCtNSTM2UlJUUDRkU3IvMUJPTHhCK0l2bm96UU40c2FtMUhZTUlL?=
 =?utf-8?B?REQ1cTVPMlEwRnBTVEp5MlB2eDQvc3krOEIzd2MxT1RsZ2JLdWo4R04xOFBT?=
 =?utf-8?B?RVJEa2FzUUszb1FVY2I2RW5LSFQwNUJWbG1BOWhtTmwwZnhGRENMM2JxWFJY?=
 =?utf-8?B?YXV4T28zVDBFZE1IdVBnSGFiZjVpQjBTMndld3Nyb2R3c1hwNDhqbVBZRkZY?=
 =?utf-8?B?eS9LR3dHcjB4dlA0WDFGMFZMc2RFRUQrbFJLbjEwTDluSUZuYzFOTE1CbzFO?=
 =?utf-8?B?ekczaTFrb3owaHQvOEFPdnhGVVdUekRYUWM2OHNkdkw0eUZ6UUk5UExCZ09i?=
 =?utf-8?B?dDFUeHFGQmo0aXlhTElkMmdZQmsrTEdrUU5BS3JnWjdRT2pJNE1BMUc5N1dB?=
 =?utf-8?B?a2x3SVFMdm5PY25vdjJEcEIwTGdnc1Z1ZHRROEExZE00UWppMFZnMGNlTGZI?=
 =?utf-8?B?RTJlOVJnYjlzSWpwcmdObFdwS2ZVckJGWVVDTkQ4VTYvSkthN1FsZU5XeXJD?=
 =?utf-8?B?MTI3TXZSSCtYbVJtdEJFWFJsNStwbERqaXAzYm4vQzJMYWIyLzlNS1FBczBW?=
 =?utf-8?B?VzBZU29DRUZmVHcvam5oMjhpcnFrQU9JeVQ2bDh4M2grZG43T3lUaUdxRkMw?=
 =?utf-8?B?WHM0ckxZVU9rTEg0dkhmL0RHd0RPY2VHcktNb1V5MzN0ekNwTmFqcGRvRHBw?=
 =?utf-8?B?Vk1rYjJkVWtha0RJT1lGL2ZCTDIzeEc5M2FhdUxzblE1WTVUclYyaVBvdFQv?=
 =?utf-8?B?Smp5U2hxZGtOZFJ1UFQ4bVpGNCtQb2hxblN3ZVgraEdlTVd4c2JYQmhwYVND?=
 =?utf-8?B?WUNqQW9DdHBSVE8vYlRHV1h5R2dEVUd0MFJxSWg1YWZ2M3ZweHdSVE1ZY0Zz?=
 =?utf-8?B?cFh5aFM2MzlnRnhMODBWaXBVbXR1Z3EvazIybmJCc203UmM2SGFTMEJmZ3Nj?=
 =?utf-8?B?M284UGVSM1FyVnRqTTlYeDVVOEpWaDg4Q0RobS92Skpib3R1QStlaUhBeTlt?=
 =?utf-8?B?VWttQVlMMGJPajBzelZkMkRQdFBvMDFkY0YvcUtxMTVEMUZEVU03SXExT0wy?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b09cfec2-5899-41fb-ad1d-08dbeb5b2193
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 13:01:24.2376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtrjYW6pzF5PFsW58UXGdyj07G5tnQou9qhSNG0B5vAlaFZI6InBAw+rai2rQBSxZnpML3Gyp86iKbeI9sGA2lr9D2jD+nCwLZrOk7RGWfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7747
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.23 09:03, Rasmus Villemoes wrote:
> On 21/11/2023 21.49, Eberhard Stoll wrote:
>>> Currently, if one switches to rs232 mode, writes something to the
>>> device, and then switches to rs485 mode, the imx_port's ->tx_state is
>>> left as SEND. This then prevents a subsequent write in rs485 mode from
>>> properly asserting the rts pin (i.e. enabling the transceiver),
>>> because imx_uart_start_rx() does not enter the "if (sport->tx_state ==
>>> OFF)" branch. Hence nothing is actually transmitted.
>>>
>>> The problem is that in rs232 mode, ->tx_state never gets set to OFF,
>>> due to
>>>
>>>     usr2 = imx_uart_readl(sport, USR2);
>>>     if (!(usr2 & USR2_TXDC)) {
>>>         /* The shifter is still busy, so retry once TC triggers */
>>>         return;
>>>     }
>>>
>>> in imx_uart_stop_tx(), and TC never triggers because the Transmit
>>> Complete interrupt is not enabled for rs232.
>>>
>>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>>> ---
>>> I'm not sure this is the best fix.
>>>
>>> At first I considered doing something much more targeted, but
>>> definitely also more hacky: In imx_uart_rs485_config(), if switching
>>> on rs485 mode, simply add "sport->tx_state = OFF;".
>>>
>>> If someone has a better suggestion, I'm all ears.
>>
>>
>> Hello Rasmus,
>>
>> i can observe a very similar situation, but with a litte different
>> configuration. This is how i can trigger the situation very quickly:
>>
>>   1) open the port
>>   2) send 1 byte out
>>   3) close the port
> 
> Hi Eberhard
> 
> Thanks for chiming in. I assume this is all in rs485 mode, no switching
> to rs232 and back involved?
> 
> 
>> Do it in a loop. As faster, the lockup may occur earlier (but not
>> mandatory, 100ms is sufficient in my setup at 115200 Baud on an
>> i.mx8mm board).
>> With this configuration i get the lockup in around 1 minute.
>>
>> For my setup it's clear what happens:
>>
>>   - when the tty is closed imx_uart_shutdown() is called. This calls
>>     imx_uart_stop_tx()
>>   - for a lockup, the shifter is still busy and imx_uart_stop_tx()
>>     returns early (as you explained) without modifying ->tx_state.
>>   - imx_uart_shutdown() proceeds and finally closes the port. Due to
>>     imx_uart_stop_tx() is not executed completely tx_state is left in
>>     state ->tx_state == SEND.
> 
> Yes, and imx_uart_shutdown() disables the TCEN which would otherwise
> cause _stop_tx to get called when the transmitter is no longer busy.
> 
>>   - When the port is opened again, tx_state is SEND and nothing can
>>     be transmitted any more. The tx path has locked up!
>>
>> Setting ->tx_state = SEND in imx_uart_shutdown() helps for my issue
>> (and should be ok IMHO).
> 
> [I assume you mean tx_state = OFF]. Yes, I suppose doing that would be
> ok, but I'm not sure it's a complete fix. In my simple test cast, I have
> separate programs invoked to do the I/O and do the mode switch, but in a
> real scenario, I'd expect the application itself to just open the device
> once, and then do I/O and mode switching as appropriate for the
> application logic, and I don't think uart_shutdown would then ever get
> called.
> 
>> But IMHO there is one next issue with this situation: When the port
>> operates with WAIT_AFTER_RTS and WAIT_AFTER_SEND then some timers
>> for callback functions might be active. I did not discover where they
>> are stopped for the case when the serial port is closed. Maybe stopping
>> is not required ...
> 
> Indeed, that's an extra complication. Adding two hrtimer_try_to_cancel()
> in shutdown would probably not hurt, along with setting tx_state OFF.
> 
> I wonder if at least mode switching should simply be disallowed (-EBUSY)
> if tx_state is anything but OFF.

Is there a valid use-case for switching the mode while the device is
transmitting? Is this something we need to support for whatever reason?
It sounds rather an obscure thing to do.

If not I would strongly vote for disallowing it in favor of a more
stable and less complex driver.
