Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A9176327A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjGZJjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjGZJi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:38:58 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7A12712;
        Wed, 26 Jul 2023 02:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQ8zZjBGC8T2bBQ9TTknYJlzx1qRux4wmkhk2xfeGdf8CYaPdQqxN9q8V1FfqjGsWAI0mP2LKsscgDDIzK5LFmeKvH4bn7MOPzSPzDEy0Kcu5xtrCZl0MR9EkxFIHR82aHyZfui2DZwQ5UzuboAwJpRPv6mpGqJhWDjeM2yVWWjpxVMVbp+IYPojj1c93EBr2C+InzS+nJxtMjVH1W7wFBmW73ch8bIc3Y9Efeo8jJ2f34zYKF8kI1VJNyhPkd3O1JoHNe3keNMfb1I/UXxNgTVYwQcglBAzlj8+uWauhiYWF44Sg3J7x2Km6eYmNi0Q/tdRuCFVlzFcjkOj+FgnWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tUO77Dj0zMGKJ5smaW+OvPmNLu/Rq00cYR5B85RjtY=;
 b=XSVcUv2bCzXkCn+iCzjVFBlptlDu74Lg6YurugVt2rqMtAY1X/0t23G+3bAyIF9ChLvGIqzQk7BVSYkKoD2aluPXg0WdRL7CyT6786IPzVUJRtJ2n1GZgf6SUY5tyV7JbySp/RW17wETtgUGw4qm8EmH3qmSYEZqh0aghm2jNpeBqlLsqRYiVG13rDVCATNJE3nYjv5IoA47YWHdKkvwYbDxWzuTNOOTiSuuF+zpZuq7ik1X/ddp40LWFLKELZl7aGFzy5j51SdVNLL+5u5Kcqs2EA5CcFSRIawmrlNsM4p8ix/EjgpeYDdASzpfBO0MLpnJRakC3hSVbheDR5Af/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tUO77Dj0zMGKJ5smaW+OvPmNLu/Rq00cYR5B85RjtY=;
 b=q2E3xuWKoe8PQFR/xI7GQ9VFCtuNmk3LeYx86jfJB6ChbQUJhlzHddnNNj7ifXhNI4iKbrGKTz48NXR/EfFrH3GxWrbokNiIDPPpwA5MCG14N9fMVvKh3Bew1JRbOzveB4POM+QMK1ANluKRk8IGR3ETleBpyh1ManN3Uky2siYmCZrUneb2jZJQ5uWCLQ/aZnlT0K9nijD6f2q+nqgTi1DHmWkv4qbzLQ8mS7dPLEl643hrT5tqcv9fYMO/1yIvjzrfCzIm2Owif2X46Fs3hjYf5R91mWju69vaSnVMx5mZlnU2OCRfzBGmvCJJbqDxc0EvpIVaetUCc7qVjw4N2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by DU0PR04MB9418.eurprd04.prod.outlook.com (2603:10a6:10:359::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 09:38:37 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3%2]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 09:38:36 +0000
Message-ID: <da536c80-7398-dae0-a22c-16e521be697a@suse.com>
Date:   Wed, 26 Jul 2023 11:38:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] USB: add usbfs ioctl to get specific superspeedplus rates
Content-Language: en-US
To:     Xiaofan Chen <xiaofanc@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>, Dingyan Li <18500469033@163.com>,
        stern@rowland.harvard.edu, sebastian.reichel@collabora.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230721084039.9728-1-18500469033@163.com>
 <2023072105-lethargic-saddling-ad97@gregkh>
 <130b453c.5c8f.1897872ce54.Coremail.18500469033@163.com>
 <2023072159-carol-underfeed-43eb@gregkh>
 <781b3f95-96e7-af83-e089-887ec7f2d255@suse.com>
 <2023072546-denture-half-5ceb@gregkh>
 <CAGjSPUCQ892adFdYm7zCuMpWujwzwoQtYimvp3xXrnnCCyN47w@mail.gmail.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <CAGjSPUCQ892adFdYm7zCuMpWujwzwoQtYimvp3xXrnnCCyN47w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|DU0PR04MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 45260028-8b4f-430d-8bf1-08db8dbc15eb
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S2ynPJdL7Vpy/y8KF2z+YogwP79mOXKTV2Q/X+3Q6k51u92kFo/acqwKltLNrM61rgfA01wS5hGTWtBNHCd89WSw6WN4xHgV7+TahUcGhfX1GpwWZqncENMBhrLAskctOWfRJdOuwSdunDoa5MtbAfpcBG/AxD6+1mY/D3H7aTAhMnNlGaF7omzkmdRnPaQKOhpyCa477hObvCOSqJVJc/6dEG0BI8wRT+NFir/wDpUqAJpjhMKCPmQuWfe0ZDeq7hgJkeo7Rfg0ckrA/D+ssG1UdcD3IFNGJT7pyzxXOEwGKwIRCufYsiQh2/nY6hythsDufVh/9rxAkmqLxHE28pE4lEC2e4VCHgQjls9woMcDHPBJFU4apnlJTVy5t4qQ/3Hqqb5hkdg3CepECEsa0Z97Y8U+kW7zlT/Yyozj6xfSvGFAPlnCRLkeGxTq87hivnk0YF7zmVh1aRT0vroRS626839R/kwwZLtUT/SOCHYrk0pMfHHjNkTO3xuKs+kne4v0uANActrQBW2HqzQkd25AVKcqQY8LeIdDl43dZ3qkMDiD+/9pXXhNpFeuGsnh6GUl5XVCFR06NHWbED3f3QmXd3fVkTPlAk3ZO1HtJUsL/81KqmQd6w9oS+bl06h6bcFRBOcYhui3L0CKQzTP7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199021)(31686004)(8936002)(8676002)(5660300002)(41300700001)(316002)(4326008)(2906002)(54906003)(66946007)(66556008)(66476007)(6486002)(186003)(53546011)(478600001)(6512007)(110136005)(6506007)(31696002)(86362001)(36756003)(2616005)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVpFMVMrQUI3N0o0SlJQRWZmRjNONlVDK1ZSU0M5V0RMMW1iU3ArV3k0TjNh?=
 =?utf-8?B?Y3d5T3lJdUt4bk9zL3g2ZXgrTzNpZWpvTmwyVEQ2QnhzbDY0K2ZCQTFwOGcw?=
 =?utf-8?B?T0laTkh2UWhXUkRaNmhhL0tCd1htLzEvMTVVS2ozSGNWRzdEckIwejMycTlm?=
 =?utf-8?B?ZXdWQWFTamxlaUd1djc0a25KRkkvYmtJeVdXN3d2YUg0NHNhbHdpOWFwSVlT?=
 =?utf-8?B?SmFKOUNQZ3lwY2QvOUJKbjFEY2o5VEdvNGZPQnR6aXVIZlZaM2VHR3V5eUdH?=
 =?utf-8?B?aG53YUFFdVphRmN0WVVOZWNSVW55U01SK2NRbXJZamJldkZ5YVRLeHFzRkI3?=
 =?utf-8?B?N0haTUlnSzFVTTgzWC9FYk5uZ1J6TVdmeUZFNFdKNFNLR2FMellGRXBGei93?=
 =?utf-8?B?bmpuZVZFajY5UG44ZEduZkhvdmVkSVJPRERhZExkTlkyalRtN295L1lxZ1FG?=
 =?utf-8?B?Z3VadFhKQnRoRjJvejFTNEJ3ZFdVUXp3N2lWaVVpTE1XY0szNTRkdGFGdkFl?=
 =?utf-8?B?a2hjb1lwR2xReEsyV3NPNjU0VnREOWxEa1NZYmwzNjFXSnhrTGNocVo3Z1gw?=
 =?utf-8?B?MzRPUUttYlVQWDI4bGdEbzlRZG04dzNyNnptM1hYZ0JtUW9MNHBMbkQ3RXVi?=
 =?utf-8?B?ajY1SGtjQ2E3VlB1LzNXNS9DdFBNU2xYZXd1eks1ZEdHdndkaEJXcWtISWJu?=
 =?utf-8?B?VHdsT3d2VHpkcnZ2dUtZLzBNYVpGQXVWdWxHT2FUb1JYSElPUkc2aURkRTRX?=
 =?utf-8?B?M2pEc3FQZ0pKQjNXZy9hYnd1MzVQUk1NazZQaVlUblo5UlRua3VXMU5RcDZM?=
 =?utf-8?B?akJoRkFKdVVHK3lub3ZtNXRod2tSQjQ0ZFVHMy9MRi9GeVFFRWdEQ0I1K2JC?=
 =?utf-8?B?QTY3MjRNTU81SityeHdLK29UR1g5aGIyUy94NkF0Q1dMWFQvSHhCNnZmMVFY?=
 =?utf-8?B?VlkrRUZHZ2JZekszckJRcGVETEE2SUdKcS9DckNHYlpzdjFFNVVWR1NJczNZ?=
 =?utf-8?B?ZG16THlSQVZYVTI1bFBueDAwYXllZ0VhYVIydUlmS205QnpCTXRla05Qd3ZP?=
 =?utf-8?B?VS95dVVFVnVtcnFuRWFNdkdTT29ZRGlDOWFRZkYxNlJwdTh2Y1JTVTRqM0hB?=
 =?utf-8?B?a3ZhOVNNNFBkaCtQd0JQUGxtMUdhWFJCTEh1aGIxbWJEWnp0SE5SZzlvNE5Z?=
 =?utf-8?B?eWhNdG9wRjJpNmsyRGNYemtLQ2dyemxGK0t2UTBGQngzckp4aUsrbDJHbVIy?=
 =?utf-8?B?RnhFT3ZsejR3MlkrbWJQZHpSQlR3UEc3RkZ4dEhFWi9BV05YcW1kUUgxK0lM?=
 =?utf-8?B?RnVyL05od0pYY1RvdG9KV3hFbjdvd2lMOGllc3luOVIwc0xNTTlkVjRyKzZp?=
 =?utf-8?B?STQ2ZHcvMForZGIxR3JoMXhYOXBSY2M3Z2RJc0FqWTNiemRwcXViUHh3anJt?=
 =?utf-8?B?QVFnUkg0Skx6aHo3MWJZZXNKeUdoQ1dzL3ZZSVgwMVFkSEFNM2VuVkJJTmdV?=
 =?utf-8?B?d1pSRzRKSXNMTUFwS2t1WWtMM0Q5SDBRSUR5N0RTMXFpbzRPYUwxVzFRYTN5?=
 =?utf-8?B?V0hQRExWcDBOLzFxVElFL2xwZTlXeGVDL1lwZUpNSkFjck9KazAzdTAwQ0ha?=
 =?utf-8?B?MnN2OEFTL2l3eGtmUXZzQzBKYWM3NHd6QnF6SFlvRysyZU5nMFVjQ0JoTCtp?=
 =?utf-8?B?UG42cUYwV0pTTjYrOHN0MHNqT0k5cjhVUENiK0NEVmE2TzdvMkpwUjNYT0d4?=
 =?utf-8?B?ZUhqd3Y0VDNqdGVCN1I1UVJFMkxERXNWTUFIVnFFNS9KSWt5ZWxPbDBTa3I4?=
 =?utf-8?B?NWFiZTUxZ1prR21RYndhK1daYkFheCtlQTdLWUFxWGhGRm05Y3hPaUplUzZ3?=
 =?utf-8?B?cDJYOHhGYnpMWkZySXJuKzhLenBpK001UzUyeXArWTRDZTlUMStyangrd1VK?=
 =?utf-8?B?R2R1QktPMmRVYm1BVmt3bFlrZ0FUM2Q0RVlKTjVtQ2V4TkRQU3lkMHNTRnhk?=
 =?utf-8?B?dHlzVldVUnVrbm81N1A2YW1BTWlKV0ZESm1DU1k3WjBMbXNjbE0vcEpTWm44?=
 =?utf-8?B?REZBNThnc1lML2NzVmNnR3d5cGd1eE54a2xNMlRGdWVhVFlJMHcxcXNiUjVE?=
 =?utf-8?B?TDgwSzRYc3BPVkQ2TU45WjZKZEovWGpFOFhtUWY4ZUE0Q3gyZHZoTVRlbllw?=
 =?utf-8?Q?vfpqsg0AIIrEYmzgdsnY16R9HapC8eqvmJUw09JHOwl7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45260028-8b4f-430d-8bf1-08db8dbc15eb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 09:38:36.7575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrOl+gzw0PKFwdaaahoh+1tXUCrF0GEo0zcypUvrol1qKIowOpX8aKlZ5xV7aNSiU1KtG4NTtbml6YtOxrpw8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9418
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.23 03:37, Xiaofan Chen wrote:
> On Tue, Jul 25, 2023 at 10:23 PM Greg KH <gregkh@linuxfoundation.org> wrote:

Hi,

>> So unless there is some actual need from userspace tools like libusb (or
>> anything else?) that requires this new ioctl, let's not add it otherwise
>> we are signing ourselves up to support it for forever.
> 
> Interestingly there is PR in libusb now, which uses sysfs for 20Gbps.

True. Now would you write a patch for libusb?
This looks to be turning into a chicken and egg problem.

> Maybe this new usbfs IOCTL is indeed good to have if we can not extend

Looking at the code of libusb you can see that libusb has two modes
of operation. Either it finds sysfs, then it uses it, if not it
goes for the ioctl.

Now, how well shall it work without sysfs? That is a design decision
and we should not be having this discussion again and again.

BTW, that is not aimed at anybody personally, we are just trying to
avoid a basic decision and it will come back.

> the existing IOCTL USBDEVFS_GET_SPEED (but why not?).

It does not include the lane count.
And sort of fudging this into speed is a bad idea in the long
run because we are likely to have collisions in the future.

	Regards
		Oliver


