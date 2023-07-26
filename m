Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1AA7634A0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjGZLQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGZLQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:16:37 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2061.outbound.protection.outlook.com [40.107.241.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E072B97;
        Wed, 26 Jul 2023 04:16:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHcKg5cY+k5a/7LZ9i50Mgt92eSD1R3Rl+HUYRv21JqvQlRfHAWogiYl3Hv4Gkq9GK1mLhRzZSCLcN6VaXL5V5AGVniRTPvvoUSM75f8Yv1hahhZEbWK1yiK7rk6APFc8Nj3sgVFhkYh2SRWZc2mQ13nuCcX2TxWM7KixDNJoLCsqjx/Wbqs7fbirwnB1k4sMSnpZZ/XRUsWmEv7RimEMiwEQ6XOynh/XU9u9lsMvbmD2yAplEuPgq4j0pVG8ejmBKOj/EgvH0I5XTfVuZR+GuFSSrZWoH66j8gs7GJndb8N4TB8uQ1YkeGt8iSgjw3pzeLOYgkMssYcG9SabwiVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEgprJuVjDohKkWBEuNJQl5+WvMhKT8zZI5UXrXsnEs=;
 b=Y7+g6J0Pr2qY2GCKZdVPc7F0pJJmwWNnNkgWBtrSd7oY65nFqioyPkMPYlHOnPscm8Yfvwk6tPxIod6kNR5IRtRGYfMvMkp8RAALnMcSzcWaa3VoKTwvo6/fjGKf9c6O+tdzclQR8dNAjWcpR+FnaGeQselyNjvi5gyk9anAV+YfFNWt++EqPmUmWdZx6aCq7d7y0at6zUE2Y6pfkCndH4JZEobaU8g/r+QVmfUAwn0BiEbJs6xTYcD15JkWK+2MhNEf6MH0yz62+OHq8mB+9V3+z0Hw8SQvSyoVJ6wx8AJLRGl+xJBlsQq7KmPY6HqTJk1gd6plSsE7RfNVxnaDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEgprJuVjDohKkWBEuNJQl5+WvMhKT8zZI5UXrXsnEs=;
 b=lZ0Z6a0PiezIf8CPJaF/EX8osWMZji5JUMnKVqMGxFL78cA0epPFUqUBd3G8p3qX4rbrv4r6Lr/ttvti9vTufQku8vCu4WSC+TPbixNKRdg90JRuhERynoNYsEgFPUwM+5hcuXpbl5KqNZUulU0FZDDkAxpnjwVu21ZcedTIVGFkKT8uxxmE6phy1xvna2y5sno5l24btT1+vl+8HSDwjSW9rFMNbE9DA7S33cgX3L0HG8wU8UHO1sw/p4ndDE9SqevXo98J4aiqJHhr4GJmXscl+XNUVk76pJEbJDYTjzniKYOLitXpwBv6r6E7W2o8RdyICJQQJiqTOZTYyPzgiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by AS5PR04MB9771.eurprd04.prod.outlook.com (2603:10a6:20b:650::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 11:16:30 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3%2]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 11:16:30 +0000
Message-ID: <05f0dc06-5a16-fba7-a256-b1d9dea989de@suse.com>
Date:   Wed, 26 Jul 2023 13:16:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] USB:bugfix a controller halt error
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        liulongfang <liulongfang@huawei.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230721100015.27124-1-liulongfang@huawei.com>
 <2023072153-module-wannabe-5637@gregkh>
 <bc2cd818-c7ad-9061-29ce-f5390d44d8ab@huawei.com>
 <2023072629-unblended-perky-4732@gregkh>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <2023072629-unblended-perky-4732@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::19) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|AS5PR04MB9771:EE_
X-MS-Office365-Filtering-Correlation-Id: 79375aed-77bf-4caa-9561-08db8dc9c329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /G2uArO+Yfro1FNxjRIlizYd8lqimfs22G2SHJ+8lvrTs/Tm6Revyq431niJRxiT/6N1KRY4M5Pah0efa3yLpAoNPmprOqy+dI1E8oPPquYbpAmfQf4d8OgJVo6qqxKg8CzvZUQ6ohXthP9xGN4w2DBsLVQPmSGUIpDK3A3P9INSx3XRukLY1fozALQEmWx4JFzu8M9YhORtKkwjzt3NzNyg0d5koFpKEMkeAoWaHK2ZR8f2OVp3YMyYkIXf22grRBagpRafcEUvXctmD8WFA4f1BrTd3xi1IBxEdlDR1QNIqSF7iCYM1GQSe35JA96Ja3XkZfi0P7plcx4N7bxTwqvXXhpomaD1olk+YEqghl86qwKex147LojqDNy8zCtV1eN7oEIXWNPDsXcZNzPSX5xeng42McTmgSb+HiNA5G/iilyTNvYItiZaV867DNFL51uak8Y2rY1rGQO08DOfWMpX++Qrmockh8kSEPslGCtSZvObPPO3F5puWFfoBzj6/kXtUGmNPnmIaohPQuiDZTN8zIj1PVY/RI6Sz5px6qPNikATffFPvMXQeKKSuoC/RP17I4+VIq8mR8It7etBzUbrlNmrHXisdpZxe3OazpaBWeXvEVoplsm1/xLGtlL5kb05R5TEAM+VJgxOUC3r1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(36756003)(31696002)(86362001)(2906002)(31686004)(83380400001)(186003)(53546011)(6506007)(6512007)(6486002)(38100700002)(478600001)(110136005)(4326008)(316002)(8936002)(8676002)(66946007)(66476007)(66556008)(2616005)(41300700001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXNpR1BqWkdxUmFacG9POXNPUlZTVWtIZWtXK1pjS0xOQVVlWHJoTTlnUGlF?=
 =?utf-8?B?Vy9xWnQzUUFaMnlRNk9TRVM0bDlrRUZreTJ6NjlXMmJRUlhtRDBiT1FXMkNh?=
 =?utf-8?B?RldhU3p1dWNVNGJxK2RlaTBLZ1VMM01QSWxHNXhqUXpNNC92WktGNTc4SWM1?=
 =?utf-8?B?SHVwZUJuTzIwKy8yRm1jekZTZEliZDVMZGRBVHkxWFNiQ1M1L3QyRGpOYzJM?=
 =?utf-8?B?aEN6ZXpKWWtmREhRSnovZGEzTkVoNC9CNzFRZ3dyS2h3NVY4Qno3T1V6Ym1l?=
 =?utf-8?B?WHE4am5aOXV2TDhLa0pmQzN6MWZYcVI1RFFCcjhUOGV5a2djKzgvcHY2NnJn?=
 =?utf-8?B?V1Y3MWNDeFpPRVMrdUdqZ3M2OWNabWlVUUxKMkhuY3g3M1JZNVYxRjVaaXlT?=
 =?utf-8?B?N3IyS0k3TTZVcHFDTXZsM3hCdGl6NmRXcWVrWnk4OGZ2Y2kxcTEzU2NCTWVO?=
 =?utf-8?B?MFd6OFoxZm5oenZuWUZ5WXUyTEt1dURlRStIeUV3QVdsajdUN2xOT1JtTnJJ?=
 =?utf-8?B?VDZIZ3hBVW1sVnJkbDNINDNLM1VLcE1MWlduM29VSGRTMWpVRVhWM3NTb3Az?=
 =?utf-8?B?a3pTTjFqZUJESm15MFJlMHg2SnNCNUlkalZvZjBJK2hZTi9XZGsvaytzTUZZ?=
 =?utf-8?B?eUdLZmQvbGJPMUdHcExoWEFVWmx1T3d1cUplYXZtamlnM2Nmd3gwRzFYZXR2?=
 =?utf-8?B?T3dIWXlFN0xkWFZPY2ROZVVIOXJabzZUR2xtaGlRN1VaSGs0UTRHMmVGRFp0?=
 =?utf-8?B?a2pxSVRUYjRsNmlrb1gzRm1tcDhVQXdWSXRvcUhjT3VjR3RNRGUyOVI4YUt1?=
 =?utf-8?B?MlJUUmxuKzBFZ2N6VGpySWwxTEJwU2lTbXRsUW9SRGZ3NUdGOC9FOHhMdjFV?=
 =?utf-8?B?M1pkZ3VOdUtreHZpWGdodE1uMnF2dkFmcGdpS3AzTTZWS0JiOENtcmRETVE0?=
 =?utf-8?B?ZklpanNHZzZ0K2E2VlNCSmpLYjdwVEc2SU96TUs3ZlZCYUJ0aWFWMDNHM0Z0?=
 =?utf-8?B?bzlVTjBXMFZoa0tTb25ucnQ1U0tvamNKT29STnFsaUFBTm92ZEJWU0FxTk55?=
 =?utf-8?B?dUVVYkRZVjArVHpCbnUxWDZuSUVjTGluKzJqUitLRDRHSmY4L2h0NVoyRVRT?=
 =?utf-8?B?U3VTbVNQQnE1WVlNSW1DcDZtYlhFRzczTlR2V3JmWEVnOHJuUjJrSkZBK1dQ?=
 =?utf-8?B?cllVbGZ2TjdoOVhoTmlyZjFkUEV4a2FvREVtdHlVczhsRGpFUWNZbkcyMjBl?=
 =?utf-8?B?OUhtVUJZdXBEZVBvMDVjcW1KMExjTHVzdG8rYmU2YzNMd25BbEw3Y3ZkNjV3?=
 =?utf-8?B?SmcrMlFpM3U3bGUxcG1WcGFyL0dudHpSU3gzNlBidW9GanlpWnltNENYQnRX?=
 =?utf-8?B?bzVFbTdObG9hUEgzV1JCb1BPZ3RwY2J5MEJnRGhYTUQ0U0lnQTRaN2s4ZTFt?=
 =?utf-8?B?YnFyMVpKVUZLWHF5VFROZ2pNcWZ3WXMvbFFpanZremNpL3E0SlR4cVd6aTJp?=
 =?utf-8?B?bklCLytKN0tFOG1LSVd2THgyQ2EyZThuRTA3OGZuMWFaZnhsM1hHRzlUTnlk?=
 =?utf-8?B?QmNwM0h6eXFFd2J5M3R2ZmR0TUVaSTdVd3VQNjh5WHQzMGpsaWwrakVDT3FU?=
 =?utf-8?B?c09uVmQzYjRPOTNzdnl5NmZqRk80MG1SV29hWjNPeHRSZi9scXZqZEZxNEJ6?=
 =?utf-8?B?aUM3WVdRWlRFTXlJRTZBZjNHbW5mdU1WNzdTRTgyYnJtR1hxSEVEZThyTzZW?=
 =?utf-8?B?ZTNENFI2Vk54MmNFWVJWNHdNRVFLanBUQmd6Tkg3MERDSTE5Tlk1L0QrbXhu?=
 =?utf-8?B?OHBHSEE3VHhaVkdmaDdoWUZrTkplMTRjd3h2S05wTG85M0lDeUg3VEJaZzdU?=
 =?utf-8?B?S29VaWQwSFhuanFaQmw3TmswNC94Q2pJeGFxUW1jYkd0NnRwUEI4TGttK1hS?=
 =?utf-8?B?Mk0vbEl4cThRdDROZFM0dUJ6cEIrYXJZSTJmUmZYVGJBR2FlSjlhdnJMeG5J?=
 =?utf-8?B?Qmx3ZUhINkZyWlVNYmpWSExEem5tRVJzMllSQjBTaWViZ3BZV1lvem02Tk10?=
 =?utf-8?B?ODRaOHZzOGxZUjMrMnlFSVQ4Y3RHTThyeUVla3JBM3ZjOVZtR3hBRGxzSlBo?=
 =?utf-8?B?Ulc5bVJmc0x5dDNTOG5sc093SW52dit0TlcrVktuS0EyQlNMVEF4RzNTT0Nu?=
 =?utf-8?Q?mxAWj7Mxv/zh9HIFiujZ8di4G8khyqAJdHN9BhXKbaEK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79375aed-77bf-4caa-9561-08db8dc9c329
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:16:30.7131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8R4ZOywV0GG1Q1A0kdlEWf2RLj+LNgLwaiodJaA7NDsAtkSsPvUDL3s4Sr4mIzb4JwLGwNZDwmstGLsHLPNdyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9771
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.23 09:18, Greg KH wrote:
> On Wed, Jul 26, 2023 at 02:44:01PM +0800, liulongfang wrote:

>> This is a test conducted under a special test scenario.
>> ECC memory errors are caused by some test tools.

So we are looking at a corner case here.

I think we need to step back, get an overview. And I would
like to apologize for not being entirely helpful.

I see a theoretical possibility here of what is going wrong
and an extremely theoretical bug, but it would be very good
if you could describe your test setup.

So. You are inducing simulated memory errors.
For this scenario to make any sense your failure must be

1. temporary - that is you have detected memory corruption but the RAM cell is not broken
2. unrecoverable - that is we have lost data
3. locateable - that is you know it hit the buffer of this operation and only it

Am I correct so far?

Furthermore your system reports the error to the HC, so that in last
consequence the transfer fails. Right?

> What memory is failing, and why does just this single check matter in
> the whole kernel?

The difference here is that we are deliberately ignoring errors.
  
> If hardware is broken, and failing, it's not the job of the kernel to
> protect against that, is it?  Shouldn't the ECC memory controller have
> properly notified the kernel of the fault

Definitely it should. But this whole discussion makes only sense
if exactly that happens.

> and reset the machine because
> it is now in an undetermined state?

No. It is not in an undetermined state if your detection logic is good enough.

	Regards
		Oliver
