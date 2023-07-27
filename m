Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EB27657BC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjG0Pbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjG0Pbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:31:47 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2059.outbound.protection.outlook.com [40.107.15.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CEA1BD5;
        Thu, 27 Jul 2023 08:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHdfk7LwtcpCQtxIPX3NkQBvNeCgNmreKAd1cl/q9TDebtfufSpQmBbob4TR/6kHLFb9fL4g27LJr299pTh3tKcb+qA41ZpE1baFDrkBWBv/YYDgOY+M/aDPTVynYRInEZ5vDYalCwKpTsEJrkwGI4xjoVEe0CTU1mW6yQjSmlSDJcQi4zLLGoyBKDV43WKkZE/vvOj67Qt92723q5V3lhXDPW4SsPK/TRwOQRlJTS1wrrp0wf+WWTEEYQzAWzYTYdc+rUj5AqRZ2hu/cNZfmHoxG45NLjypwgWoVhxME7h8G48XQLnqAXi2LTAZ4Gc2F5L9zG+wBxDoMoT1wMsDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EobOP04o5EcD7tS0rIyaTcsft2NMc1/zbnec6cF/Ci4=;
 b=ST+2kFtjg4wGXRJf62mBy2qvRB/BvLqoZEEQg1hWIpkOQ2hwQjTMYjo48m2ems0XpHC995328Rt0kIqO+WnRP+GagQ5DjhzxRRLzDKBinlZx7pdhPJ6KrS16z3tJMZZLyuNl2gOezu/z8DtKZr3ZWjkKuoNGiXCTFmm7ZAVxaYmoScOe6VpAhnJg93TEb2uprXga9vr+VfEX6ZUQnDrNsjv9cKfUiY4mxLx9j91E9gFRCPZlvz1tIbFg9YpMZUO5koZqfiGpZSaydNzDCVBOwYQIDNQIGHMxwXjjNTAIyAjsl2Opdz/ZNJ05sW3wyXCx5tohfeMohqSxryp/MITxEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EobOP04o5EcD7tS0rIyaTcsft2NMc1/zbnec6cF/Ci4=;
 b=pfxDinrnZJ8VrMg7Hs3uRBxMQjS/WV44CA5zM7+3fylYbWl/IdJ/l0dxDeV6c7+BoejnG6++DFl5e8ZPoZNMipf7p4jtBhNbqKXWk9YMUpBdnf/wRguNO7MfGl1A3ob3vEE3xIqxm+rHlfrDwvuLYRY98PZjXfbmeNGJ0sn89kUAk1YXqKMYwZG/tESGjcUsBbS1JIHL+y7AJtLtbDBdsaxzDQykkldijf69niamKfyS6um7wZKhUZUJ9exhfMKUHwUBoB5jv7npZ+k+ZdhStG6Hwr52PXY1flUpA5JfkyK/61QZ6UR55kQhKX8bZSeS+sFekM0K+JxPmJ6FiBVdZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by AM8PR04MB7777.eurprd04.prod.outlook.com (2603:10a6:20b:236::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 15:31:43 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3%2]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 15:31:43 +0000
Message-ID: <e983fecd-ff59-e97e-0099-b33685d45d00@suse.com>
Date:   Thu, 27 Jul 2023 17:31:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] USB:bugfix a controller halt error
To:     Alan Stern <stern@rowland.harvard.edu>,
        liulongfang <liulongfang@huawei.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230721100015.27124-1-liulongfang@huawei.com>
 <c3ab029f-f6ab-4b09-b2b5-1cc6a5370d0d@rowland.harvard.edu>
 <bfee90c1-a7ca-27e3-88f9-936f48cd2595@huawei.com>
 <bd440f1d-5ea4-485e-9924-433997765adc@rowland.harvard.edu>
 <77a8ecb4-8099-1826-abd8-4f080d80b07d@huawei.com>
 <73b58ff7-2a0a-43f7-bda9-52b9437f5bc0@rowland.harvard.edu>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <73b58ff7-2a0a-43f7-bda9-52b9437f5bc0@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|AM8PR04MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 44818e8d-3eb6-4da2-b9d5-08db8eb694b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U0D2xUGDg3qD8GeECtfAd/OzgBkDwQq42pjjFC6q6fN+GpGCT18CMBqCpimQlD2lJzjwdlXX2FMO+FO3ZV/CphD5OovkV1qqcCd3brZ1uFAuipEaIDZ60GAmcLSNRbwbznVlU8sLZw4484SJQURiiWX/C6dggWCEVmJQHyJUbO4l4aA4IVaIKuOdMbNWHQGdtnw9yP3T8Lphn3VJzqisUzb8Znyx6psxdtIXuPSSUj3SBVcAO8Qj4Fc3U4zwJ9bKvHRq6D7mELqdl8yORqtpmfL61OMq/xhlofvelUahC45v1NAN2odggeytubemOiOmrhKZEmAxDBqZL1AoOo6EvIbCtHmCxjJr9DoDCqtL2fPJMLw064JtulAtXfg9h5ug1oP1uPPnEbujPHCvoVDuYTpWHMvMzRQGrd1NJ71NpcFXQ1GxRJwUsjs14jjeFY9Y61xpCMStIyctJ5eWya4f+BFP8LyBqLukFY9973ZNyU0LgtfNAxO+56eueWtu1txr3dEAh+ZR56VpELXyXvuZUw8CkxbN05mwSYj7cLyqXViGbZjq+oRna/cVOUVCE0oSlAeKSqM/3B6+i3OCYuuxZqLohuxzgZP7r6vZPkeeCDQW4Yp2OutY7bFvCFa7fX7M/8FwgmJIVetT+mKlJ6ASDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199021)(110136005)(6512007)(6486002)(38100700002)(478600001)(41300700001)(5660300002)(316002)(2616005)(4326008)(8676002)(66946007)(66556008)(66476007)(8936002)(83380400001)(186003)(6506007)(53546011)(86362001)(31696002)(2906002)(36756003)(31686004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjA2Wm1MMkh2b0RJOERhOEx5ZzcyaFJWbEhDTlJBWGFqbUVPcWJqalljcFlI?=
 =?utf-8?B?Zk5wdnN4dHkzbWVacWxHMXViRWRxWE1jek5KNjZBNGRYaXVUNElUUzlrUElC?=
 =?utf-8?B?M3ZtcWdoTGZwd3c2bHhleDEwVElFb21ub3VUSnZoMVh5MW9pRFVOR3A3cStj?=
 =?utf-8?B?KzYwWnBKNUF4cVFoWFM3eVNPYmV6dGVFdVNCb2ljS29JaWtGdG50S0lva0Zx?=
 =?utf-8?B?R0pBOG9GeGFGT2Mwc0E1TENhUjBmbW9OeWVSNUx4NmFGZjNvNFBWdC9KYWpa?=
 =?utf-8?B?THB2MGxJQVNSZ2c1cW1NM2VwbGJTL05wNWhIZjl3WHQ5SWdFUzdEY0NVYU1V?=
 =?utf-8?B?dDJHck9zWXB1bkplc1NOZWJhcXpoME4xZDVmVnhtMHBiUmVDVm0zcG1Xa1ZN?=
 =?utf-8?B?clZRYnh6WHkwZCtXL1FlNytLQ1pKcit2SzBmYmsvdEpRSzhzOGpZODhZb3JR?=
 =?utf-8?B?MVAvTVlmZzRsNEhzR3JDempLd3k5V1Y3bGZheUFuUDBuZmNBSWdXcmZ0ais5?=
 =?utf-8?B?WHlZNXBOVzRUVjNEeXVwemw5b2hoRHFLbGc0djlNUGtMbThOKzdGSThHem9G?=
 =?utf-8?B?MXNLREZtbHNxQVJSRGhnSzBTWjZYYjhxNkxEdjU1aHU0aW5TVVlhOVhRL3hl?=
 =?utf-8?B?YzRyMXBvMmtDcWN0V2cwRk1va0NNRkJocjNlM2FnS0swdzV3SFU0NEgvRGhU?=
 =?utf-8?B?aEdPblhNbkplb0UrVnVsd0NjQkMyNnpwU09tNG5DMEFQSEZ6djZnR2gxa2dn?=
 =?utf-8?B?WnBkZnNFYkpQYkl4RzE4b2lBcTgyR0M2eWswSkM0cVJxd2FkZFhCb2VTZFRw?=
 =?utf-8?B?UXYvQXBLSkpSZFJ2R3Q1T1UwTXdoeDJOc2dNcmpsRjBBTjVTOTM2SXg2eUlI?=
 =?utf-8?B?NWpIVG92bXp6K1ZMNjViZ3I1ZTZCKytyaEo1UFlUeHJ5T0xtWlpJTGcwZGt5?=
 =?utf-8?B?bkJXcDdZL3JnZ080QmhjOWgraEFWZHVNZVZMZlJ5N0dITENoQmNZNjJickJH?=
 =?utf-8?B?WHFDOUl4ZW1jZHd6eEFTUXcwcE1zNU9MN1BGT1R2Y2pIaHZmOU1nZUxmSVVp?=
 =?utf-8?B?OGFaY3V2ZExhN2VuMEJFNnNKVndsOEoyQ1dyL2l2aGU1aDV2dE1Rd1Z1MkpR?=
 =?utf-8?B?THZOOXFJR1BxRy9OekZhUzNYbWZ2SlJPYTUwbDVrcWlQVGdIMkdpUXpkMi9I?=
 =?utf-8?B?dm16RkVWV292Ny94b09xdUVETFRGWXliU3pCalU0cDltVVVTa3Q1cWxZTDJ6?=
 =?utf-8?B?NzBZZEJvbzEzTUZrUVUya3FpM1pwaDVuaU5HdG9jQklZRmhNVzZDck85RDV2?=
 =?utf-8?B?emQ3Y1Y3cy9GZWdtbVNURFVHK2dGQVlMNXZHZ0hDVkZhcDgwUlV0ZEhmSEFu?=
 =?utf-8?B?SFlKd014K1ZVSnllcXdhdVhUVWduR0F6MUltcjNBV1dRbmVxcnVSRUhPY05n?=
 =?utf-8?B?VE5pMnNBUzNMTkpUczNLQkhWTkprUDYzRHdhaXBhQjhadHVWRitONTJyNEhC?=
 =?utf-8?B?eDVGVXJFc2NGOGZ1RWxJYWFEMm51NDA1dHFIZjAzL3VhbWR3MDhkTFREdVd5?=
 =?utf-8?B?eUVrSEdHem53UERJRmU2bzlzZ2gzQmtnOFEwMWRGSVBQUmxxVElRc0VoR3Z2?=
 =?utf-8?B?T0lNbVVXR2t2emlnS2tBay9LTGZFU0FHMll2QnU0REJ2dlVWc01iRkFRaEZ4?=
 =?utf-8?B?MmJIRitRd1VJY3BKdVFpbkg4S2k1SW9xZUllWmo1Ui9XaCtpeVZGWGJBL3B0?=
 =?utf-8?B?aTdmNGUxaWtJc2hTM0M2ek0veTU4YktSc1AxMS9WWFVBRHB2bEZGTDcxcDFp?=
 =?utf-8?B?RDdpa1JseWZ6aXBVZ3ovZCtUOENZVVd4TitlaDBTNUNIczNYUThuK01YNlpS?=
 =?utf-8?B?WUZNeFUwYnZ2eEI1K285VDB0Z3ZnRy9BdGxQMWpBYVNlTGpXNTQxZU9rNTRG?=
 =?utf-8?B?TEE3TjV0WWNCaWtSUEhwdmZ3bzZyOGh5V0g4Tk9IM3puLzBuZVpwbVdyMEM2?=
 =?utf-8?B?NGJsTlRiN0kyYjBjQXE5ZDBLVXcxUWJzRnhYSmxUNFlITFZGQWZRamZ5UHB3?=
 =?utf-8?B?L01KQ0o4RFVzUW5yZG9ZMTFlbnVnTS91Z1dENGZrSjFRcnVuSlBrTmVnQlcw?=
 =?utf-8?B?ejhzTUtNYWg5ZkhYOVZDS1pGZ2hkZnlON0ttaXR4TnR6bmNlY0QxNXdvWEVY?=
 =?utf-8?Q?jThpag+D4hNCF1UXCiHYx+s=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44818e8d-3eb6-4da2-b9d5-08db8eb694b2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 15:31:43.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DchgO1zfXDn80MSq9wFBFmCGguU0phmlYD6KEdw4p3fXlZ5BDbpa50R3D9QN84dfMWeO91KIlD8y7EEQ8+75Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7777
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.07.23 16:42, Alan Stern wrote:
> On Thu, Jul 27, 2023 at 03:03:57PM +0800, liulongfang wrote:
>> On 2023/7/26 22:20, Alan Stern wrote:

>>> It seems to me that something along these lines must be necessary in
>>> any case.  Unless the bad memory is cleared somehow, it would never be
>>> usable again.  The kernel might deallocate it, then reallocate for
>>> another purpose, and then crash when the new user tries to access it.
>>>
>>> In fact, this scenario could still happen even with your patch, which
>>> means the patch doesn't really fix the problem.

I suppose in theory you could have something like a bad blocks list
just for RAM, but that would really hurt. You'd have to do something
about every DMA operation in every driver in theory.

Error handling would basically be an intentional memory leak.

>> This patch is only used to prevent data in the buffer from being accessed.
>> As long as the data is not accessed, the kernel does not crash.
> 
> I still don't understand.  You haven't provided nearly enough
> information.  You should start by answering the questions that Oliver
> asked.  Then answer this question:
> 
> The code you are concerned about is this:
> 
> 		r = usb_control_msg(udev, usb_rcvaddr0pipe(),
> 				USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
> 				USB_DT_DEVICE << 8, 0,
> 				buf, GET_DESCRIPTOR_BUFSIZE,
> 				initial_descriptor_timeout);
> 		switch (buf->bMaxPacketSize0) {
> 
> You're worried that if an ECC memory error occurs during the
> usb_control_msg transfer, the kernel will crash when the "switch"
> statement tries to read the value of buf->bMaxPacketSize0.  That's a
> reasonable thing to worry about.

Albeit unlikely. If the hardware and implementation are reasonable
you'd return a specific error code from the HCD and clean up the
RAM in your ecc driver.

The fix for USB would then conceptually be something like

retryio:
	r = usb_control_msg()
	if (r == -EMEMORYCORRUPTION)
		goto retryio;

	Regards
		Oliver
