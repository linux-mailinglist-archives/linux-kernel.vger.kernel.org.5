Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569077632C1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjGZJtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjGZJte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:49:34 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139A1A2;
        Wed, 26 Jul 2023 02:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZL6lQaC+f72d1ecaadFFqgUnU+SjmDTwsN9tGfj0GeeuqXxJoxqSQn6hQQA9/YD53MVLRy0da8k2XWA2YF32CdHtG4dqe5I84q5Au5GdMs46nT0ys75/haxfDyHdHhNkj+OZKH7B/bQTeTSakCLo4jidgxgT/GWAQ6qxGRrDVqgUG46vLeWD+NZvRpIeLVE5xdffC21mVsnCdo+uy0yQNXNVGj/pzvYCCo41A4ZrA7zMmb5DJ1ZMr3HGjvI0zNGVSyDT7Sb/pvpCQiJzmG6B8oRV+2wUEz344uTNGmRFw3MR3iYRfqFFZl4Te7DkLZnGw+D/Usd3Uum7Pf8C08eXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvcQKt5ll69mjMbcQuIKp0s3xTLGekXdSJX9LHMuCYQ=;
 b=PadsAgnUvwQlxzAswA433xpxnfg0bxDWmT0i1beZl0fFswu9oPkCRnedKYtbU2Bf6cJ0wHneXrBDI1gPJEbViSGNttx/ToQz6a0A+qGxQrYUCkSE9yE175mW+t6+NLQ42hupc+AwJKxnE3ryDnWkPvimT/QC854FH4u5zdoItTDHTwCs92JsyOwYmIrQm7JMNV/zpcrKf6FIzC9sg/JULTrk6gr9L75JDRuisHrwa1F5zVDwzfHAHJOeD37yS10dOoQ6ZOHWF5JdJuaFto+pd4dIREGA2kUsvOBQ8Y2m23J+LPGZ6OTgJgx0h+57YLWxpH3bADFeZrwde1iSQfAwNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvcQKt5ll69mjMbcQuIKp0s3xTLGekXdSJX9LHMuCYQ=;
 b=ngfWq6YrzMb5nyedNcKy7mimMyi1bzFlxX+d7lrlwHQ9XmHME7uGdI0xkg6rzDAGwNQ7i5E1yGVjI032f3MPzOomUBzIFYcrJhROOTpEK57Z3A0gQCqAuCmodx29wnLBBDXfurrQhrR53dI1KjQyqM+hbiHpT44iWQjfbDHkWhdpbJfD0VjoKrfqCnrEXr+5ioyZlEcL99iZGgOvvlvIsOunB7JzMkHKOTzWZvRXGipDZy4AvPHBLrWvTsExciTbk2kw2Z0+s9FuJ0C2WUZS+zESWIHW4/P1FXfqRG2UM2gUzrzxIkqqIhCj6J0XrqRErDydxgQW6qIpqJ13pcjmqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by PA4PR04MB7983.eurprd04.prod.outlook.com (2603:10a6:102:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 09:49:28 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3%2]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 09:49:28 +0000
Message-ID: <7d6a6443-b463-b26e-4bb3-3100e6874683@suse.com>
Date:   Wed, 26 Jul 2023 11:49:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] USB: add usbfs ioctl to get specific superspeedplus rates
Content-Language: en-US
To:     Dingyan Li <18500469033@163.com>, Oliver Neukum <oneukum@suse.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, stern@rowland.harvard.edu,
        sebastian.reichel@collabora.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230721084039.9728-1-18500469033@163.com>
 <2023072105-lethargic-saddling-ad97@gregkh>
 <130b453c.5c8f.1897872ce54.Coremail.18500469033@163.com>
 <2023072159-carol-underfeed-43eb@gregkh>
 <781b3f95-96e7-af83-e089-887ec7f2d255@suse.com>
 <2023072546-denture-half-5ceb@gregkh>
 <4edabcb3.7e65.1898d54679e.Coremail.18500469033@163.com>
 <ca4ad735-5605-3fd4-c903-fe5b039cf6a8@suse.com>
 <3018cd33.7ee4.1898d7e4798.Coremail.18500469033@163.com>
 <2023072526-reissue-uplifting-5674@gregkh>
 <6be59e4e.8166.1898dd22d84.Coremail.18500469033@163.com>
 <37ae1c44-fe7e-3f0f-0eea-0c684fe04d50@suse.com>
 <3a822c60.6ae8.189918ebd0a.Coremail.18500469033@163.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <3a822c60.6ae8.189918ebd0a.Coremail.18500469033@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23)
 To VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|PA4PR04MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 5369bc57-79cf-439c-ef03-08db8dbd9a94
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HwicFmc0BjQIwZZW9Ki9j6W4qA5W1Gret9apRl1ZQPx2crs5Lkar3ADCRuby2P3zljElf2VywgEBS7afx/nI9CkGX0FH91E/FLPucoRsAyLYqkLwTY9VLBmZpOTaT+SPf+ehqS2WvBW4Sv3nx1haOJhtKc2+yrqAaKkle6o918gLUPVmW5rfCX4X+N/zhLUwIuDjs4F9kXkecHHxf2Kp8beY/VySgFptK1PwnipUNS9QtgGR3w9cGXIcDmsZPTOoyJUdOwNccPWXY0Eof+4KpcPViA1SyK+YlVrPgar08TuI0kYCAVKeT81THFptEtTtkIysvvtcfozRxZv3NeptlgiIHGk2J77cP4mciYjUspRkPi5FZLxIef/Fz/wsXRi6dpF5ommUYzPlF8+CPLHKFNZmE7AC5RiID+oGrld0iQpuDtirVjXw4SIEfw2sHJ0qvou4B7stK3Z0M1BCh+IbrnjDfgMbwgADxDSEYE1Gg3H/6qfNdZtthi/ButpFhuvdRMr9zF/RehCUumMyKNWWbfFbbYbtyaysyYMEdkwowV4+cYxTKeJTpMNWKyumMeMyW/A8pBNwZyZ85J7D3aDRmXlIvKgTDUHY+xNyvKMpmijeJbwHGRCf8f1vvw9l38KC20/xwWSjUxjS03V8bj0Aag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199021)(2616005)(66946007)(66476007)(83380400001)(316002)(66556008)(4326008)(6486002)(110136005)(966005)(478600001)(186003)(6506007)(53546011)(2906002)(6512007)(36756003)(86362001)(31696002)(41300700001)(38100700002)(8936002)(5660300002)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0xSdnNwanU5U0E2REYwcjE1TDBVc2xJTHdJM1dlU3JibjM3UXJGRHh6akpu?=
 =?utf-8?B?Rkp0MzZDczUyUXNaaDRNb0dNMmxmU093L0YvbWc1MWNJMGZvUlppMWVkcEhF?=
 =?utf-8?B?MVVxYzBuTFlYd3l0czZPWXlva2FlU0psZFNiQzdSV2NjS1AvYno0V3NCanVl?=
 =?utf-8?B?K3hMamdjNzNhZkwzUjY4L0lNUGh6c0NZelpIa1J3OVQyek1ZS2N5ZVI1dDZY?=
 =?utf-8?B?N1N3ZVhwMnR1SWhmYjRDdmZsTm5Kc0tTZzdZTndVT3AzZjN3WXQ1aTFwMTJK?=
 =?utf-8?B?d2l1VWtZVEV5TzVuV3doSWU4VVF3aGVuWUNpNTloQmtJdkFHa0tvV0pyTzRN?=
 =?utf-8?B?OHI0blNnSnVYZDFnWjRtU3VKdFZRdHFXT3g4Tk5GRE9QQnphdkdQVXVxcFpU?=
 =?utf-8?B?Ty9QY21jLzcxTW4wc1pOVVJ6OENHNVR5ZnFvSTRXMlJqSHNoWkhtREdHVXhE?=
 =?utf-8?B?cS8wd1l4VlF1TEpUMkp4bWU4ZUwxSnREYXRNMEs2VEFkOTlVdnMwRkRaRSsz?=
 =?utf-8?B?dlRYa05xc3JuRjF5bVMwVXdoTDlzd0dQZkRZZncxVFlYbTlUWXUzQndCZ0Z1?=
 =?utf-8?B?aVZlTTBJc0ZDT25RaFNHMjdGZVdLbnlGSFRob0pxRGZXbVNCaDFpTXRERDhh?=
 =?utf-8?B?cmNZdUZsbE43SUVTOHljMEdIdFl5S0ttZW80VUJ6akNpSmJyQmJnUVR2ZWFJ?=
 =?utf-8?B?U0FwSEJnMlBoVVpQd25KcXVvNzhlLzI5Ti9USzVXZy83YjI2azl1aWo1a0Ry?=
 =?utf-8?B?SFBySEUrU0JSZlo5TGRNY2xPQlNoUzAyQzhucnBSb3J6bjB3T0cvbU1mY011?=
 =?utf-8?B?bC9GQlRzTXJoYmE4VjlkeGM5T2I4blMrQVl3RDFjdVU5SWk0U2FCbThrcE5a?=
 =?utf-8?B?SHR3NUFHVUhHdFB6dG5lZk1MWURCNUxPNmpLeEF6ODhqdWlwODBKRkZGdFhJ?=
 =?utf-8?B?UWFIZlJSUldLR0FzUzRNc1g1RUVmT21qQnVUTGZiYzRTbEo3cFFxUk1VMGpk?=
 =?utf-8?B?TVcrYkZlUTVZU3hNLzIzd2RHeFBOa1pxcGF2cGVDQ3JlS2dVTHloWVdpS0tB?=
 =?utf-8?B?NGlBVjdBcExMVUtnQ2kvR3YrQzRPUC84ZU9OMEVNSHAyREJsajVFR2VGUWxm?=
 =?utf-8?B?WnU4QUs1L2dXU2llTFRkNkxwM0FWeXRWVHhtQUR6MFFlRG5EVm5iUUd3cFdB?=
 =?utf-8?B?TjhNRERob3VqdEFpaVkycnhuZ2JLN2JSeUdBNUN0NEpCaVM3TmN4T0VIU1p6?=
 =?utf-8?B?elNQSEFvUVJWcnYwNVlQVy9Kc2RBN0NJUCtuMTZKL1QzTUFRMC8rRElXK0t1?=
 =?utf-8?B?WWNRRUVKNWtvTWRzOVNNQlN2Q2pRRVNhcEdxWExveXdTY2xodUc2dk54Nks5?=
 =?utf-8?B?bWhiZldSU2tSM0pXK3FCQ3VwV0tEUTkwSVZTSldnL0FnQ1VpTkxUY3F4S0xN?=
 =?utf-8?B?emUwMlR6Z3UvNW5PM1Q0Vk5UM3hYR2VqV2NaOVl6TE1TODBlMlRBVmF2c3k1?=
 =?utf-8?B?Rll6THprV0lGUjhXbG0wUldSVkF3Zld0d1ppYW43TkM1eXMwekcvd3RIL2tw?=
 =?utf-8?B?TDRRRjhqSFVtbmphb21lOGFzaFlYalNEeVRmN2l4VWo2aUlnWHhZWlY3TlFC?=
 =?utf-8?B?R1N1b25BaFl3L1Y2WmdncGNJOGg0WG1EU0JZSkdtaHpaZFp2V2hacWdRSkVL?=
 =?utf-8?B?cHVla2RLN0NsRHhHa0x1eFI1c080ZVp5YlRXdVQvTnBCcmIwdk1aWmV2TG1u?=
 =?utf-8?B?ME1iVTd3VUk2UEo1Y3pxdGpXbmhWang2eXRVZkRyK0Jic0dTQTliSVdKaFJC?=
 =?utf-8?B?cldEaVRsdytQNkg3aW94VzBnV0VIbzhlUWdPcEFyZHNpU3g2TUk0NC9scitr?=
 =?utf-8?B?Ly9ESTFiZjRxbGE2RGlKM3ZTdTdRTjVTbUJVZ0puVGc1SUlIV2pPREVUU3pK?=
 =?utf-8?B?VVg1OXgvNkc3VzBZMS8xcU0yV0FmUXF0dFhvdWhMaHpnZ3JHeUFkMzl1Qk8w?=
 =?utf-8?B?VFpKSnpDcVZ6UHgxNUNHTzVlR0RpckxhMmFTSDUvQmhYN0xRQVlzeDYyMndR?=
 =?utf-8?B?WHZaSnRLV3pSckdSTEVhY2FNY2hiUWd5VnIwNXExSDNzY2tLWDZ2VFFZT3cw?=
 =?utf-8?B?bjhxci9EWVVqMlBWN29SMDFTaWpGSkQ2Q2VFVmQ1c1ZWL0tzeVI5NmhFZ292?=
 =?utf-8?Q?ohKsZD9daNWR8J7F3JzSrevjsovGJuZkXnBmA8cmpgNr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5369bc57-79cf-439c-ef03-08db8dbd9a94
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 09:49:28.6215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yA2LKxsOeNzHQvwy8CjHaTOuSgGw7VZM+aIxfQ2auFPs9NXvaRMOAfq4Mce0aY25oHqrcm/GQqj00CC54JkcnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7983
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.07.23 11:36, Dingyan Li wrote:
> At 2023-07-26 16:33:22, "Oliver Neukum" <oneukum@suse.com> wrote:
>> On 25.07.23 18:11, Dingyan Li wrote:
>>   
>>> In proc_conninfo_ex(), the number of returned bytes is determined by
>>> the smaller number between sizeof(struct usbdevfs_conninfo_ex) and a
>>> user specified size. So if we only append new members to the end of
>>> struct usbdevfs_conninfo_ex, it won't impact the bytes in the beginning.
>>
>> You have just caused memory corruption in user space by overwriting what
>> was right behind the buffer of the agreed upon size. Or, not much better,
>> caused a segmentation fault.
>>
>> 	Regards
>> 		Oliver
> 
> How come?

Sorry, I misread the check at the start.

> The actual returned bytes must be smaller than or equal to user specified size.
> You can check https://elixir.bootlin.com/linux/v6.5-rc3/source/drivers/usb/core/devio.c#L1493

Yes, we can add. But where is the point?
User space has to be changed to use new sizes.

The problem is not your patch. Add documentation to it and it is fine.
We have a basic issue here. Do we require libusb to use sysfs or not?

	Regards
		Oliver

