Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA017764E81
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjG0JFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjG0JFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:05:16 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2041.outbound.protection.outlook.com [40.107.105.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76CE7EE9;
        Thu, 27 Jul 2023 01:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOiHhxeNSqTfH/JOcER/lrp7jWi5E8IGgg8b8CvNPoL+gguV+MREiJeGSMKf6xDmfemFrDMnNtmnnoS+cyb29bRY63eHNFzGYt70jx3opWMuHJha9KA3Fm7CjFKawBiBDKeV50DVl0KC6FQsf3dcRpGMZDsoek7YXdVbiW34pkfsNKGrtZ7OvavBSjrZzkqG08koelDuuFgQXcj8/uzOMlgV7l15GUkhZX1RSBfqX1hmK8apCuUss3qMrAOHwuYcW5dD5qL6ri34BgfuRKTPfpEtIFYQVDM7trffYnY14WmnsVjR/9QJKD8YnQKzDrngETBVg86+jpg5UCqyGLn00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tei5d4t5T9tpj2Lyv/DW6XY0dMwYOekxy2YamoggeFo=;
 b=WYgyAsFspl90oy4h/Kzg/O7VFh7QwfYlaNBD0ynvvqsLo9Vmz8GAPu2p3+09qKMxZP27+dOLns+FrydwmCG/jGWcaAUJ5DJhJSw1MX8v6ubzjoVjAcaWIkq09K9yLBP+Rj7LUx06WoUSxV0m7ohebqViwwwz/Wg0LYevYALmp7OXmmynIckPtef3Dz8WT4W/Ofjb1hRqCHp/0/j3AZ08DkjQ6zMQldl7b7rP6NbSsj+qdE25oF965FaaxAIaPjkRZ9tecG6+dJFIHeQRQxhcjtRKr8+fTi7b/zriSuzowwT/ORXHpSDCdzr5UgzXKCwNU6Jvm8nSecGwxOs+OAtpuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tei5d4t5T9tpj2Lyv/DW6XY0dMwYOekxy2YamoggeFo=;
 b=xVRJVDgQFyn4mv8IloooHXheDzqcTSAnE8vg2iiZzTc89XPLMso1rojxY+/JR+coIZjVOKO4vF7Y6/HFowQZkpjOzvCbJnXLV5xFu2WlK3b9A8vISaW0/Zj57piPUo8oFFHLqY+rY+43vvovxmZfrbr0Hta+Ioll15G8kt9H6ZyIni0jKUCRXvr9rs8unllyqv6Rnuv7AzDDzcC2wqwzCQheBLkiiIgBKLRUef/J6TO/UghRbKn60f2B1LwDhStCBMR1xlwhafZ9DAj2lax1F4gxsAWZSvdDq3Xx59UK6B2Dx/LxQgGXgTe02GNAagzxaF4Y2EIzSESq5GyoBbI1OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by AM7PR04MB6839.eurprd04.prod.outlook.com (2603:10a6:20b:103::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 08:46:08 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3%2]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 08:46:08 +0000
Message-ID: <2fbd21f3-2da0-5a10-23c4-fcfecfe48311@suse.com>
Date:   Thu, 27 Jul 2023 10:46:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] USB:bugfix a controller halt error
Content-Language: en-US
To:     liulongfang <liulongfang@huawei.com>,
        Oliver Neukum <oneukum@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230721100015.27124-1-liulongfang@huawei.com>
 <2023072153-module-wannabe-5637@gregkh>
 <bc2cd818-c7ad-9061-29ce-f5390d44d8ab@huawei.com>
 <2023072629-unblended-perky-4732@gregkh>
 <05f0dc06-5a16-fba7-a256-b1d9dea989de@suse.com>
 <f03958f4-de73-ec43-fa13-02727b6018c3@huawei.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <f03958f4-de73-ec43-fa13-02727b6018c3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::20) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|AM7PR04MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: 6559e528-d592-4b76-a0a1-08db8e7deb63
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rDVVRhD/rgtbMU6AxLUUY/laXmzGhcDQx2IKVUVIH+rzTlQ3gDUkIioTH9T0dVdhUyaxsGi7TeeEuKFmtzzusr10mag7Fv/O3ML6s+P1UPwsEVp2zhjeLHHLd3NHtcxfFLyYf4CDDtuQdK/pIrkRitgHOroorCmpe5noQ2B+KK6FHCe3sglsdQ3oyDQ7IWEKFYF+1Ra2UYP2IV2GsSGgyxkZkMhVcmO/nlio0yDF4C3x1REISgMmnwtOwMiN8EiUCRyj4oZZBCzmIzWafL0uM6UgqKbXIzSj7HdRnDW6s5584yL33XLN1mnKZMqsn1oeAsmW0m8V+vqfTCFzpmjMLHMQA2S2QFhb9Pc40fOgFZpZ/Z27qffIw68jy//yRRc03mHk1BE6dcbF28P4q8am9xTKLJ9qExTgNln3Hssxm0MSTHT+mXmvXQYPbc4YRwDIfJgKxFH7mMWi4Kljxk1RmUkvs0rpkWA7wxAu+WNhihAGONJCLdJgk/qeCVD0nX7f1zXp0hVL1m8xg1tJ8A54v2qOwLHQyYZfDhEpz+3b7W7pXyv6dr3QhDM5Z6kuioywHudv3VaURwC8+BSZGN3M2Bd+x44VG5qYt4efH6ODNQZCOyQJV99gBohhbp3PUgS2y1Ugrhrbrbd/uKas5eXyHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199021)(2906002)(86362001)(186003)(31696002)(53546011)(6506007)(83380400001)(2616005)(38100700002)(478600001)(6666004)(6512007)(6486002)(36756003)(110136005)(66476007)(66556008)(66946007)(41300700001)(316002)(8676002)(5660300002)(8936002)(31686004)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3RFSEIvQ1h2Tzk5eW1LNitrWEZSeXJoYm1KcjROSXhpYytjVzdSa3pHNTc3?=
 =?utf-8?B?MmJlVVdOVWNEZHpQWlMzRnM0VFdQeUFBWlpFZTRXbUVJRTdoaHBaUlIzVU9D?=
 =?utf-8?B?aFR0TFh6Uk9hR1RYbjRwNlhBNXJmaG1SMS9LQ25ZaUd0Vjc1ditGSm0rblc5?=
 =?utf-8?B?VG9HYnZqWlM1WDd4NlVoRmYwZWI2VE14ZGZXcGUvd3NmVEVaNTdVeVkyN1Fw?=
 =?utf-8?B?T1F1RnNVZHJsUlUveVRBVWJockFYdm9iUmUyM1Vsd0prbWVCa2hJeThHeTly?=
 =?utf-8?B?VXJSSk1IOUdrZXRMM3FLaDJNRUVSaTM2bTFEVWM1RUdMSHo3eHcwSDJUQ1Nx?=
 =?utf-8?B?S2VFNFVLYXVFVVNQYjROREd6SGF0aEgyUm52OUE1dDBjWmFvL3czcjFuOS9s?=
 =?utf-8?B?WDRLZnJBN21zKys4eExSRUg0WXhvWVdER0wvQXdGcTFaYWRQeFgvUmU0d1Bj?=
 =?utf-8?B?WmtvRTlsSjMwb3gvb0JYNWMzKy9zcWFyYU9scllSZXQxWTVuL3JLL3NNK0Mx?=
 =?utf-8?B?YTZ5MDNDWDk2N2MzbDNoR1c5MU9zWHREN01VZzNWZDlKZko4Q2dCazRrcXZE?=
 =?utf-8?B?cVFSUDFjWi95dnNLRVlkdWwxSEFhUFpaNDZMdXVTMW9tODV0SG1lRi9qV1k5?=
 =?utf-8?B?bmdZOGZWd2pLUEFpNjBYa3RRUWltS1gxVnpaRUhxQVV0ZWFXRWRzd2JlUUFV?=
 =?utf-8?B?azV0bGJlSnZ4UFJ2Y1QvZW1lQVFpOWZTRjNxWXQyVXRUQ3RVbWIrVXNMbHFz?=
 =?utf-8?B?Q0lIdVpjWW5hSkw5SVNlRXRyNVBuTmdBcmhSYldYVFl6QitJb1pXVG5BaWZ5?=
 =?utf-8?B?ZTJLMEF5WEh4SlplOVlISUEyM1NyUEhEeUFzZ0hTZkp0cmpFV0I4Q2I2MnlB?=
 =?utf-8?B?SGlGRDU2aENRak84cWN6MFhaTzJOT2RjRElreGY3algycmlHQU5lNDYrYzJC?=
 =?utf-8?B?c2VFVXk2ajMwcUFZTWpWUXRxK2lrQWtBdExLbFpBZDhhZ0VudTNyc3pCdDhl?=
 =?utf-8?B?SU1ueU81dWsvTnkvME9yMG9idTQ2K1oxbVN0eUF4UFFwNks4MDRYUUk5cm1O?=
 =?utf-8?B?S2F0MmdrcE53azVCZmVoME5GV01jaVFPMWh3Y1Q2dk91citnNzRDQ1o4dG1q?=
 =?utf-8?B?YVh2emFnMHdSeUlCOWhvbXR4N0dNUE1Ua2FlZnc5WjJ4RDBYRkVxMTBPVUh1?=
 =?utf-8?B?T1ZjdVB4TTVHTWNzbWZyMWNHQWpseWQ0WnAyNWh5UTIzUlBXYlcyQWl1SGh3?=
 =?utf-8?B?N3JjdjVRSUZDd0ZyUDNmaHljWGZxenpUdGN2djRzVDRBVXZydHhlb0lEZ0Zz?=
 =?utf-8?B?NWhScTNNNHhhY2dRUU1qM0ZaZStteUJSYi9oTk95L0xqMTRXOFJaTDRzU0lv?=
 =?utf-8?B?UHltak1yZGxURGd0dkVsZHlEMmRibFBhbUc3UzJESXFMMFhVN1RYcktneE5U?=
 =?utf-8?B?ektmZmJWNW5iUG11OVN1YXNTNTFYZ3JIQ21YWEJvcC9qZFdmcVlKQ2hYQno1?=
 =?utf-8?B?STRlcW4xT2IyV2szZ2xUc2srQmMyci9hc205d0VkQUgrWlBhMmF3WjBJUnVG?=
 =?utf-8?B?cktnOUVxOTJQUlZaMlY0cFdSUnJXY0dseG1WMXNvLzQ3eHlHZHJnUFJKNDdC?=
 =?utf-8?B?ZFozWG9FaVRFSGRwUXExMUN1WDRNcjZNQzVadmhmZ29kYnhCNERkditKY3Yz?=
 =?utf-8?B?ZUU0WG4vSVJxNjlNL0VTNWczNzd0dHhkSk9JSFFNVHNxRGRmM3pMdEtTZmlk?=
 =?utf-8?B?dmhBYjM3OFc0bHVTQnMvZEhoZUpmK1BKRHlNUytoc0VTMU44Skg0VW1tT2lr?=
 =?utf-8?B?SHlROFdibjl4S3J6WXB6WnFjbnNZOFE1b3Q1bFp2TGdiRkRBY0RXWUM3Q3oy?=
 =?utf-8?B?eGdBZmVhWU5sdyswZDdqenUzd1J3Z2piTEtmZUs5cVdEakRuZFhrdXN5d1FW?=
 =?utf-8?B?aDliU1ZaWUtIbm5kK3VwN2FCY2ducXNCampEWFJvTGJUR3BxVXZOVXBpVTBL?=
 =?utf-8?B?d3loU0hONmU1aXpUWng4aUEzM2NacVA2S2R3WnFjUFlTbTRFTll3MDNzUnRu?=
 =?utf-8?B?a1BaK0VyVW42WGxESXU0WDJVTnJZMXozUzdoZjlyOHMzdmJySzlYU0FuS1FL?=
 =?utf-8?B?aTRUb1kzb0gyMnNFS1NKK0RLQlVJNXYraVk2dktRNitEdFVxZHRhbzFRZG9J?=
 =?utf-8?Q?QQRGqITgljOIREJ+uj0aS6Y=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6559e528-d592-4b76-a0a1-08db8e7deb63
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 08:46:07.8980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDuQd6R4MUb0D1NKpc6BFUPiDu+z1VgISQxWiXG0GNNdLhhNu28edMJki5p8rDTa5myVJ4oFo1xJAHMdKxnj9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6839
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.07.23 09:00, liulongfang wrote:
> On 2023/7/26 19:16, Oliver Neukum wrote:

>> 1. temporary - that is you have detected memory corruption but the RAM cell is not broken
>> 2. unrecoverable - that is we have lost data
>> 3. locateable - that is you know it hit the buffer of this operation and only it
>>
>> Am I correct so far?
>>
> You are right about the testing process.
> But this problem can exist in the real environment, just the probability of
> occurrence is very low.

Understood. Bit flips are random.

But this leaves two open questions.

1. How is the error reported

2. How are we supposed to handle it

Firstly, if we already know that there is an ECC failure
on the host we can use a specific error code and can check
for that.

Secondly, does this mean that the affected memory location
must not be touched until the machine is power cycled
or does it simply mean that the buffer is invalid?

> Our test tool only simulates that external interference destroys this part
> of the data in the buffer on the ECC memory. Even without this testing tool.
> This problem may also occur on real business hardware devices.

Understood. But what is the correct remedy if teh problem strikes
for real?

	Regards
		Oliver
