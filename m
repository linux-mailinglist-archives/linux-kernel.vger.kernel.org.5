Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EA97806A4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 09:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358295AbjHRHwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 03:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358335AbjHRHu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 03:50:56 -0400
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2080.outbound.protection.outlook.com [40.107.24.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C0E3A91;
        Fri, 18 Aug 2023 00:50:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVxconXEQ+CX7XVrpOcMcQa/GY8R27lh0wFG0lM1QhN6geyfzbvtuM4kM2JURKN6X7ftXFLjQsDqO6aDDfDuY8e504xWKXQaaEhN+zWI+Htap55SWBxggHHGKQtALCglyYBpqrGiU0cx+Yxwaui2ym18Ao/kOV5h/JJa7K+o5XjnEVxE0Hz2p0VNKWxi6haUj0g4SELQiiANV2a4nkZqBLRLnWyzTow/8ddUnge1aY+5yXcblDwuCybJhRZA2aAibFXkhqMGvp/2f51iqUTtAlN8o4Oezv+hG16rmxrxTUv0lQx+nvlAsgBhMjHBXcTJ1YM1FZT2DY7BleKI3J8H4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHzsSrOHg6tGi0pDMYwD+JitKlo/D/pMCy+pBVi4FdI=;
 b=nRpjafZsirHPs/tDpCnDFvsfShvzb0k7VwN1CJeAw8blAMwf75fHk4qwnEwK4NsK1wGhjc05NS4RgBwI+otcl8qMx7P9/ZNoBp3Xw2K9e7jB9Ys+5ZEvhAUYr4/gl04lISKFfReA/KMQZIdKpyn4ee3XaG0wrk6gBTGIVVFh85z2eumKNaXmPxg3z2ri0k5ZRgTOGCiE2jXnkj6OP1w/KJwWRm8FsdTaSN1FsfuI4MjUWjVt433EI++c11wnC7KLN6Nv+y1dlgr+GVkXby4osq5veGc9gd+N2zyJhnody7icyxc2lYSg2ib3ARRA/ycUHGugBq1ONELXeP435K/EzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=usi.ch; dmarc=pass action=none header.from=usi.ch; dkim=pass
 header.d=usi.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usi365.onmicrosoft.com; s=selector2-usi365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHzsSrOHg6tGi0pDMYwD+JitKlo/D/pMCy+pBVi4FdI=;
 b=ETuGR0mWeO0Vg4UJGzLDztyb+i56ZoGGQxtPJVd68P/zy/uGvt0SD6LJo5Pumxcy4gdyh0HulQQWx/ZdK5kmMRPjm6zrUI4yd7CH5mMB4rPZkYpQ/EhVwVYleZ2mmft5TmQy/cxnxb5wctp4sWh5XW3t3iwgjPY4b/mA60lYDi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=usi.ch;
Received: from GV0P278MB0163.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2f::10)
 by ZR2P278MB1130.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 07:50:47 +0000
Received: from GV0P278MB0163.CHEP278.PROD.OUTLOOK.COM
 ([fe80::9057:82cc:fc98:1f5]) by GV0P278MB0163.CHEP278.PROD.OUTLOOK.COM
 ([fe80::9057:82cc:fc98:1f5%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 07:50:47 +0000
Message-ID: <c9c63da7-bc8a-7307-63f1-1f393b017da2@usi.ch>
Date:   Fri, 18 Aug 2023 09:50:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 0/7] Rust Socket abstractions
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Michele Dalle Rive <dallerivemichele@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Davide Rovelli <davide.rovelli@usi.ch>,
        rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230814092302.1903203-1-dallerivemichele@gmail.com>
 <2023081411-apache-tubeless-7bb3@gregkh>
 <0e91e3be-abbb-4bf7-be05-ba75c7522736@lunn.ch>
 <CACETy0=V9B8UOCi+BKfyrX06ca=WvC0Gvo_ouR=DjX=_-jhAwg@mail.gmail.com>
 <e3b4164a-5392-4209-99e5-560bf96df1df@lunn.ch>
 <CACETy0n0217=JOnHUWvxM_npDrdg4U=nzGYKqYbGFsvspjP6gg@mail.gmail.com>
 <CANiq72=3z+FcyYGV0upsezGAkh2J4EmzbJ=5s374gf=10AYnUQ@mail.gmail.com>
 <bddea099-4468-4f96-2e06-2b207b608485@usi.ch>
 <0ba551eb-480e-4327-b62f-fc105d280821@lunn.ch>
Content-Language: en-US
From:   Davide Rovelli <roveld@usi.ch>
In-Reply-To: <0ba551eb-480e-4327-b62f-fc105d280821@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0065.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::6) To GV0P278MB0163.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV0P278MB0163:EE_|ZR2P278MB1130:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0aa2f1-0e32-4be9-f2fa-08db9fbfd58c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E900Go6dsA3zzNSq1UO42M6CN0Rf3S3zRiDCr+itCC3m4N2+XtSSMKcs3DrlIJks2PXjmT2BU9gvLFgyEAck63UTSuW5jQ9n7b44T+qzIsuLEltda2yw+ii1v8h0BxjAyEWc7n0SX/rqgidW0+adXFqxTmL+dO5wJijwYcP5icOUqP9BCUp1dDfn6ey7sDT1sqCdk/X3vVypaF6DasdhZ5R0I+IOoXXNpQxzZhoDSGYwAiillVBMAZI3iaiNS6Gl+vRilBqf46poLZxlvjjPJ3VttQjo7esD5bLdA2L6JJdMaEQDIe/+dTTrq/7In/OTS7FAyG66KByn1qHIDbJzuriGlIMhwzuCju8dZUHVAzGmqTuc638xsWUY85J2YzZhPyv7FYQhsLEAcUyfjJe1nB0nbYZPE0sLjH5cgXKmckIAyvF9HiwnBjs+ejRCuTdoCJ4lqkKiD8jyQYE4FHzv8l0QfoBbUE/IqtEHZFdnYRHAqR/4Mwr7dQGl8szWEHV+OnGGnLW5wiJS7JLwumfs4c5vWd/hcBSukfS+HFtVXcFWJJB8gBH5K/GfeICv4b8rG37RNRqzhzpLjjMCV9jfgkM6xYl7uJtSeVzQLkgesdJMgfoB9cYdjj9Jo+d8bpO+2ZlU5il5h9WOQuHvA6TShg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0163.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39850400004)(366004)(346002)(376002)(451199024)(1800799009)(186009)(8676002)(6486002)(41300700001)(66899024)(6506007)(53546011)(8936002)(478600001)(2906002)(66946007)(66476007)(66556008)(6916009)(54906003)(31696002)(316002)(786003)(36756003)(38100700002)(2616005)(5660300002)(7416002)(31686004)(83380400001)(4326008)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm01QW1WVjBKNi9mWXJOWXdDTVkxZGRERS9EOHR0bmpVNStQN0hCT0QwVmZh?=
 =?utf-8?B?SHowTVdaQmZkeFpSemFXejRya1V0RWJOSGdEa0wrbEloQmk0WUM3Y1N0N2NX?=
 =?utf-8?B?VGJBcmIySWw0U2lEbFc2bmZRUk8yMXdONitjZDF6OEllUDNQOE5jVGhEY3pZ?=
 =?utf-8?B?SnBGN2NycUNiRVZLZEhPVDRxVVJqYTZERWQ0YVFUNEtQeU5VUElsVkdVVkl1?=
 =?utf-8?B?SlFmUi9Fa2MydTJlY3hSRlZFMkd5bUtLaVM3cktMeUNmNm1JZE9oMm9XSFNT?=
 =?utf-8?B?LzUrYmhlQ3hXc0h1eDJkLzZpbndBbzc0VlpvSzdWSUJUYldJZnRDZDczSVBv?=
 =?utf-8?B?eHZMcGlUUkR2a2NGbFVpQ0tOSUpmRmFCOTBZVmlVeG1DSENudzN5STlDMFU1?=
 =?utf-8?B?bTRPMXJkeVN5M2xqaFVNTWVnb1ZKdlMvK1l1cENIQkJQRnAxOWNETmxOaVIv?=
 =?utf-8?B?cG9aTFdsa0xMMC8zQVdzL2x0YXFvb1hla282ek1zZktrbkFsaUVUbXdlK2hr?=
 =?utf-8?B?RWFYQk8wVXBGN0ZIWUlyY3lzQkNZbWZ0ZG94MGRXeHJsd1crQ1YwdG4xbkJY?=
 =?utf-8?B?ZXRvL2xNVUlQSUdSVUw3cVJtRWR2NUFtV09oLzltaXB6bURubU5CbFBpY2dG?=
 =?utf-8?B?N2FmRE02S09xZzU3UFoyK1VGYSs2UWFFMHR2YW1aQjI4VlZjcEJwczhQb3dM?=
 =?utf-8?B?M0oxUGFLTXFiZ2dNQ3pYbGZ4eWI3ZHZiblM4ZWVHYzBMWXplUnVKMjk0VnlQ?=
 =?utf-8?B?bTR2NnVrVFhicjZKVDRwRDVCTFplcmIvZ2lndkdDalFvVnhicWozVW90V0s2?=
 =?utf-8?B?NFBUTFAwK0F1clNPb3l4Q3lrNDA2YmFpa24yQlFQQUhZa0NKR3ZYRHRadTVt?=
 =?utf-8?B?cEI5anVBUnYzaWxvZnpKYVc3RENsN0syWWdleDBUa25ISVNiYVdWS3ZmSVpi?=
 =?utf-8?B?bVZHVXVNWEEzYUVwR2t0aVdzbjhBWVhQNi9jdTRCWFBuOXFFSEo2VFk2RmMx?=
 =?utf-8?B?QWR4UWs0bEV2SzVVb1M3ajI0amN2NGtWK241dVluL3RiKytqODRoN3o0M1ln?=
 =?utf-8?B?UUs4bUhmelM4TEVndzFRSSttdUpqcnlRMml1NFlEejIwdXg0RU9pU3UzMEFM?=
 =?utf-8?B?dVFOWlFqODU2TVpPaFJIamE1Rm9QdDFzYzZFU1drdmxTbVRtUWU5SEZ6QkVN?=
 =?utf-8?B?N2lVUjc3em90V2Fiekl2R3Q4M1ZoRkZEUG42dVl5VGVFSEl0Um91azRpcGJo?=
 =?utf-8?B?Z2MxdWpPdSszaTRwbXljeWJXM3RDQjlXZ0RuOVZXVW5JbGUweDJ2K283YUoz?=
 =?utf-8?B?VytIeHBsa0NXNHdYdzZvQVN0OFhOK3ljOHFxN21EWWFvbCsvRWkxMittK3JN?=
 =?utf-8?B?ZC9TMEU5UkNGMGR2SGlKL25oZEZJd3I4Q2FtUTBOaWVTZEFKUlM1R1dkNnZD?=
 =?utf-8?B?Q3l1VWJydURBTkR3MDlWOVM3bnZBUW92eXRLb2Q5UDhRbERhVkFCYnRmclpS?=
 =?utf-8?B?WGN2UEExTUgvd0RVOEJnZVhKK2kzN01BVnNlYXVsSmlJaFQyWjNYZE1MSlVi?=
 =?utf-8?B?NGtFbGc1T2hwZ2oxY3JENTJGcXJna0RqVXpQQ1JycmR0N3FvMjVWSDhaUFVm?=
 =?utf-8?B?NFNjeEhOVFcvMXV3SkwyYkNJaXQ5Rkd5MEt4K1RCazZwc2ZlUFJoK2dqNU45?=
 =?utf-8?B?Y2loUjhaUDk4V0pkeWVkaGJQN2ovb3RzVkhtNkNBTStmM1l1a2JQVEphVmJW?=
 =?utf-8?B?MVlXTVA4R25LalphYzFrVE1hV00rckxvRWlwdE9IMW0wL0tkci9uLzJRYTBG?=
 =?utf-8?B?RlpMSXNpNGcrTTlTY1JxNE5lVzJvSmF3UjVvdkhiVG9wU0FSYmNTT04yVFFB?=
 =?utf-8?B?OHRVN3BOdjRFdGEvWE9vV1VjTzF1K2o4UnN0OHAwOXBOZEloRkMvbnFwdmhu?=
 =?utf-8?B?cFU3aDdYZUdRN0ZublZ4aGF1R04zaGtJR29lZlVmc3BpUGRPSXV6YlUydVhm?=
 =?utf-8?B?eXFKOWZ4YkJISzdEM0pvK1BOYjlMSGt0VGd3NkRPV0NvbXNHMTh4NEg3ZVgy?=
 =?utf-8?B?bm96aDhyb2Z4VDRGQzhpNDBmSlJNZWRla1plaXNqWncrVmM3dmRwc1pmTy90?=
 =?utf-8?B?WjhHQjBZMW9iMk1FRTgxV1plcmhtZXdESkZ4YjRaU0hxYmxiNmRQRTFYclBx?=
 =?utf-8?Q?4ynYIbz/lGOS2m9GOsjiXlquMGcD3aELiwyoIOSB/slD?=
X-OriginatorOrg: usi.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0aa2f1-0e32-4be9-f2fa-08db9fbfd58c
X-MS-Exchange-CrossTenant-AuthSource: GV0P278MB0163.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 07:50:47.4903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 95bdc5ac-afb5-4881-801b-3874f365cd6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRM7QUSneEOx/4S9JFGpu7MtROvVZEZtWTNKMY2niWvOIIU90nCCR5Kbt2ct+zUT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1130
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/23 03:30, Andrew Lunn wrote:

> So you have an application in user space wanting to use this
> protocol. I assume it is using BSD sockets to communicate with the
> kernel and the protocol. 

No, at the moment it uses procfs or a shared mmap'd chardev buffer.

> So you need an API below sockets to get this
> traffic, i assume a whole new protocol family? But you have an API on
> top of sockets for TCP/UDP. So i guess your protocol somehow
> encapsulate the traffic and then uses the API your are proposing to
> send over TCP or UDP?

Yes, we take a message/value from a user space app and send it to
other nodes via UDP according to the chosen protocol. Mind that
the term "protocol" might be misleading here as it can be confused
with classic network protocols. Our API offers distributed services
such as failure detectors, consensus etc.

> Which makes me think:
> 
> Why go through sockets twice for a low jitter networking protocol?

The idea behind the system is to be split: user space apps are
normal apps that can present arbitrary jitter, kernel space services
are isolated to provide low jitter. The same applies in the network
via a SDN based protocol which prioritises our traffic. By having
end-to-end timely communication and processing, we can achieve
new efficient distributed services.


