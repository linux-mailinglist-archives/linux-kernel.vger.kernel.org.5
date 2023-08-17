Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0838977F4E9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350204AbjHQLTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350198AbjHQLTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:19:00 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C720430C0;
        Thu, 17 Aug 2023 04:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xp3O+fAtbWBNiOWdyJW540Cfm7h+vaVtDipbQn89bi/wlDMsmv4/ihxfpGy7JiBAWnnitXINq6ZE7cPJG1e+pupBZ2RssN9oKC/A7QyHA3K/u1tMi4o5bz8DLol4JtjJmWqVwJepZmTCBY6XmS6wGMpwI+tsDDBqG8shgzTuPlq5XPcFq+hzGJ6wgne1IsutgEW36CNWkSo56lWk5/whDVL+CUpE0tsEscNNUzLjW/UULrgAx5Z0Qug18b2xSqaSYnxMbNVLoh7ZeyOqGfAJEyEWNb0FruJ6O30ahLkyOxajNr34cZXvp3B86b2BDaWT0UrbCiReFB9cgaTKp1aFzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6LqakqxjcwP8g0Sdhtxw0YnKeB2dAGehZxbez63heM=;
 b=ZMSF9ejvmocW2o7+QM4R0Sw3v4EN/CRFTaz8YNAZXW+p0pjaslLEd5Ls14z3XB3zNGoFHnizxUefhfQWLoHQk4zMGwr9DtifmnW0/vOGCYYfxCNinDMiLDD1YbuKbHjNPX5r8FD4RmIQEfivTY0RvTqHMOgcYMV0CG74+Gt3myb3rhmwTkR+Ky1gO1M2kUhiRs0Zdf1zb345QAAcBz5W9O6sikkduzhQP+Kmu6TCIH201vx4uKcV3nRrwxBz26ODAFhc78L3r+ujR+0nSBQeOmmln5NC9kq9F4qdWwyD7owrTaPboFnhWYp636g6SCp1cFfIB/K1MssA+bTK4am/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6LqakqxjcwP8g0Sdhtxw0YnKeB2dAGehZxbez63heM=;
 b=00qSeUuOm4rtiQTRZu1Dm7x+3XgG9BlFEdytOgtCm1zy62JbAOyNHG97R015etlKDePV7uow/sRmDK0NT1eCTLMkzz2GdteakxbDSZa2B3ZRhdBi5dpJ4DBaYKzYbXTfKU6GhHRnEdaoPejZaICHK5wRd5Fbq9JeK8gq7w3s/gmH2VyzVHTuTkY2Hm0+y2vhEP86rncIrZ9MagZTDir/QUTvFnEXK2wJ8eww8VXJ5MgKy3Wzkm9i6t7qWD5slVJVxHrzOltaHn4Xz8Npunu1U7qjEnvFrqHZZRawwk2jmR+63rXs5iJL6MXYeZsD19ecNvkjbnXvUH5T/vWGzSYGSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by DBAPR04MB7237.eurprd04.prod.outlook.com (2603:10a6:10:1a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 11:18:55 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::51fc:914:29f5:a420]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::51fc:914:29f5:a420%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 11:18:55 +0000
Message-ID: <cc271e17-6204-b610-b40e-5c882ad6be36@suse.com>
Date:   Thu, 17 Aug 2023 13:18:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] xhci: Disable connect, disconnect and over-current wakeup
 on system suspend
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        mathias.nyman@intel.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230817093305.212821-1-kai.heng.feng@canonical.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20230817093305.212821-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::16) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|DBAPR04MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 317c9ba7-f0c0-40e2-7d3f-08db9f13be98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hjyckV+IcQGItIkebiYJhsdHu5gUAVVBOGa+2GpWlv3bBA2OD2qKnJ4K0KUDKB72hKqLFQRwNK3nCSIIQ0/eLyI0urU1WlngSYxbPt+ClE8QlZYxMc1Wau2qK5CJnEhXS9I/RsNqPjU+Zn4OCRhysTX4MZcHH2wOhorkcjwpB1+IqW02VjoFyrv8eTAi2XMhI6j7Uk0efIKUomWC7fKPNix21wgAX1asBL5SAOYF4ttYrTAilheyMKI7PYL247xG6byVoTF9uTz7RFcu90SHGfIng6b8lwALdiNIF0nhvohfZWx/e8AlkZNsnD3lDzqWyEQl4umd++HndG49nR3eglvqW0IkpA5uJwupp4UMSy786+lCjblucMaOiqP7DAmo+v69eMpmirVl4ImSihn2SPQzcjamGw+heGcu7jwRzvE3bz/WkQhUs/1PO5F6vLg4XHacx5RdFGPQY5UQy1yBIjsJ40vsCFgukHdYrUzWkyHD3IyEjeRFRCg3cl413rGsLX7dhQgzn2/WNL6WGhL1faJ0xNLz/FN1LMi9yVHoPsZ7M0g8dTv6S5jGgsLD2k+LULx8LOunDGpKw1142MEU0UTbXqwsqeqMmEEmhK1arRfMhWneBshwWlp1dvSzQiTGFe28M+q5kmIkHX5yXCVlWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(396003)(346002)(136003)(376002)(1800799009)(451199024)(186009)(316002)(66946007)(66476007)(66556008)(31686004)(5660300002)(41300700001)(38100700002)(4326008)(8936002)(8676002)(2906002)(15650500001)(31696002)(4744005)(83380400001)(478600001)(86362001)(53546011)(6512007)(6486002)(6506007)(36756003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEw3bEgwL2gzWG5DNTFLNU1QT2VJRTNHTHluSzRKY1k3Zk5hVmFqMDIrSDlS?=
 =?utf-8?B?USt2MUNZdyt4dVNla29pV2pQNjJHSUtTOFB0YSs1R3hraW9zU3BoMXo1b2w1?=
 =?utf-8?B?b3dtYTI1a1hiS051d1lUZUMxT2NycE5XVGNheHhLTk5obGVlNGl2YTlwRi9L?=
 =?utf-8?B?NDJiWWtDQjFuZnMvZmlYN09CeE1ra1JYMFB0aHY2cUxwbHdEbW9OTzhiTEt1?=
 =?utf-8?B?WmVRaCtpbUlVZEZ0bG5OQ2FGcDVsd1FnckhLbVJhVHM4blZyMWovdnVwdDZy?=
 =?utf-8?B?SW5HR1BtamlEQzJxZ3VRazc2KzV4aDBWQ1B2Y01tUEhKMmc5NlFoMUtzbytG?=
 =?utf-8?B?N3pxNXZ3K0dpc3JPdE9haGxFRVczM3NhNTUrQnlpblIxeG5hY1FvNjlOZ2Q2?=
 =?utf-8?B?YjNiNDFtemFXOWFla2o3bzN6K3daY29zWnRUQXo0SmVhNzBvOUZnN0x3b2lP?=
 =?utf-8?B?RDZUbzZpdGRNUGJCT2t3WVArUmtEeXNUdVRnZzFpS3VuUHd5QUlIT0hrTyti?=
 =?utf-8?B?YjNyOHlwSFNSczZqQksxRmJmSUI5NnRYanRwbVlkVWhBVjBzeWVaWDJadzNW?=
 =?utf-8?B?blc5S1B6V2xEVURYYUsxalh6ejl4aDFkQldyNndvcjR6TFBPV3NVTnYwS01r?=
 =?utf-8?B?aUk0Rjg1RStLNXU4dFhDY0MzVDhySWVFRVhpUTYzNjBmN004dU9WWHpKYk1k?=
 =?utf-8?B?SkRZcXdmVGNNZVpVczg2QjMwdUpVUWkrSkwrRkVPVHNpcVJBRnN0bURzQjJo?=
 =?utf-8?B?bjllRVRJdGVUa2NlZ2pZdFV4Z0IvdnBIK21UbWhlYW1JZWpnZ0R3Z0hrQ0V1?=
 =?utf-8?B?M0htSDVVTnRsZnIwV0Q3RVpxOTFLdzhCNHVPN00yekxydEFHbGkyeE1zZzg3?=
 =?utf-8?B?SjAweHNzKzVZZmN4Ri9mWDlSV2VXbFBhc2dlRkdvN0VXSm9TTkxtcUN3MDlw?=
 =?utf-8?B?MzBaMmhKQXg2NGt2ZjVHcXBoYkJzQ2hpSERwSXpvbjE1cFFMMjVpVzNJYVlu?=
 =?utf-8?B?TVc5NHlxYXBFbTB2QkJzWDF5MjJYNVVpNUwrTWxldE1zNXdOSXFjVDV6bnFr?=
 =?utf-8?B?b2J5enRZdXVzNDhTaXBpaE5aRXFWbWkwYVVTaFpILzM1VVVSQzVQUkxYc2ZG?=
 =?utf-8?B?clJ6dFVZQlpOUkJzUTdHeVNDdEFkLzZuSjFjWkFsOGR6ODVKNDNzSGlTeTEw?=
 =?utf-8?B?S2JrMGNIR09sWWhjNTB3SlFha0tBTnFLSnppWWpPbm9MOTlyWmxsbEVpQTlL?=
 =?utf-8?B?RFJ0Vmp2Mm83cU83Zk5ZV1YzSVBtZlNxeVVCK1VGU0VFbklOOWFMeEJXU05m?=
 =?utf-8?B?bUVyV1o5cGxiUlpCaU02Z0x2aXp0SnNDUFI4MUR3Y2xCZUd2Q2xTS2ovRHR1?=
 =?utf-8?B?cS9SVUMxK1JoZ2JkRnlIY2dvNkc1eFlqbmlPNWdNWjAyUGtxM1hicjdvdGpq?=
 =?utf-8?B?UHJjYlpqQ3JvZlQ4OEVCZk9JVkQvbXNhMGFINW1WcUc3Z0FhWTNWZVNEU1FL?=
 =?utf-8?B?MStxQ2NCZGt2elpFSDd4YXAzWmpIREVZblc0Y0trT05sSTJBelRicEkrdkxt?=
 =?utf-8?B?ODJJOUlKZ2hJKzVydEVmRnU5YlJPY0NFbWdiWnRoL0ZrV0wvUmtqUlFrSU5C?=
 =?utf-8?B?SFA4d1hPV2ZNMFhrdDFQUE16WEN5QTJZOUtYeEYrN1I1OG14UGo1NnA3eElz?=
 =?utf-8?B?U0RvL3dEdk8rMW5ZRHdHcW9XRUtMejY2OUgxZXc2M0lWZGFMaDl0eE9YR0tZ?=
 =?utf-8?B?bllzRThDb01LMVBZdWwxalRuMzR0YjJDZ0pEU3dONHZxcmIxbjdjMldJZUR1?=
 =?utf-8?B?alUxOHhuZW5YMFBUVHRyUnREZHNEN0RhQ25IaWNTYWFTNnFobzZLaCtvL0RL?=
 =?utf-8?B?V0hxQ1JUQ3dPZXdWRXJoMlBpQzY0QW5OYVF5WXVuWEhKcmhOa1VNNTJSLzZl?=
 =?utf-8?B?OVlDcDd3c3lWN1NUamdSRk9uUy9UbnNkQ3J2ai9jSnZsOU5xZE9mYXVGRDRL?=
 =?utf-8?B?VUZyd0o3WE1oQVQvT0RSLzRvWTk1eHZiVUd6OWNkeWZIV0lydGZod2UzSEZl?=
 =?utf-8?B?TUlUbXNXK3pDeElrUGVwMWFKamIyaUU4UGgrd1VBUWdDYWVYNmJ5NTEwKzVP?=
 =?utf-8?B?Q1hwTEdwRnVqWGw4eUNZYUh0aWJsN2hvOEUxNHBYNlZNcnJvdTl1RnZOdGl0?=
 =?utf-8?Q?IhuaWls3cY03iSeeiMIMXGwVgBipggsT2UGjKuA1TTgF?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317c9ba7-f0c0-40e2-7d3f-08db9f13be98
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 11:18:55.6178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxWkwfSP9SjrW6q8v7QbiB3sooiINRZmvDRpELtt0KBf7FzQmAr9tPzCsSuWTYTOBC4FdlizVZDqunSYX0sd6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7237
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.08.23 11:33, Kai-Heng Feng wrote:

Hi,
  
> So for system-wide suspend, also disable connect, disconnect and
> over-current wakeup to prevent spurious wakeup.

isn't this breaking the ability to effectively use your root hub
as a source of system wakeups? That is, even if you want the
system to wake up if somebody attaches a new device, it no longer works?

	Regards
		Oliver

