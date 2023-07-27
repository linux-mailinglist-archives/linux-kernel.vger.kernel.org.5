Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F68764E96
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjG0JHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjG0JG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:06:59 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2048.outbound.protection.outlook.com [40.107.105.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61899A82;
        Thu, 27 Jul 2023 01:47:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tn1Tpo7d6MaANth16BW1Pvw5o1QJmCrjr8yzxfI5nbqnr1H6HBcc+DMXJhASD5/Wf02FmbWkN1ZFcbDwf/LyzPYxD6PszdRRjUh42ytzl+sdKBVi6qxMpmFVZN0nNyuYlfPlfBj6j7htIFT8X+U5vBC82snzZvaYQrSq7meeKICs+djZcgQU+2dZ60So9D0hXlW2ySmMncwFlob2knpHWRM122qkGlumeSCkFlz2qHSSFvkFNBrb2+4WWWIKOXvQMfwjJU12WhQUACmHpnBSjj2MS+zl5w43yK2Dz2rqGXnW7ul0Mj7VqtZl9DtS+09YNXeCGHK/MSTG+jTXQO5EfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDecAK7FWl3kenF+g9Q3ert5A90Ei5lF/mWlQ2hYhiM=;
 b=epXjlJYc8woTfQfTdvS1nMJZJ7NEHsYPZjzFHu894KPi4g+vVxJyyGwF0JolGLNGH+d4ulCyCb1bSmEjW9Pv6cn//5Pqb4UphUQVA0uaob8USzVTyLnJts3gw7kpF8oZV0l5Vag93kzWKlSoOUF+ouUHGiREpH//dckGtkPrCg3w3EvgOLA48BiWOvLTFVTE6fiOAVfQog5cH59aZFiYzr1yJULhuyA4ay36jQ2mN2qDZBxj4R58U4hK0Lkj0j0nORt82YerqHgArnCvsP2OvfYP/x8MBTCGYlkQVqdLpOqACET/KrBHJwYpsmOUOAnFGcM3TRXd99fUjC6EjSg1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDecAK7FWl3kenF+g9Q3ert5A90Ei5lF/mWlQ2hYhiM=;
 b=deFzzj1IFARAbAoaWLruPvY+4GH+W+hgfhvOAfTWKK29iRKrbLulOrel1ShXbwN3NV3DqO1ZnAmD/kppSKKf6kc6kmLJ39MBU5gBGh9/IG2idbRn93wUnauRznn2AzaifAmXnRz/NS7kPZ/Vffwv3urijRDAVw2Hdlumj8jiCuMclVGZhATqyAysSIz6CyyHsHxd0zYj1/YOb7/t+aA5vTZpX/bwTsaE5KrOtxn/f+0RM3Dk4apqpzkz6JiRMA3KxdCyN3nWl0NKH01i0E2RLYTT6QvH9XSDZXmMHU1AnJczF8X5krTQcN8aaSRYfU3r314rkqSp8yrZLjTMynlDmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by AM7PR04MB6839.eurprd04.prod.outlook.com (2603:10a6:20b:103::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 08:47:41 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3%2]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 08:47:41 +0000
Message-ID: <52f03455-4e85-39d4-d048-5f236c879d0f@suse.com>
Date:   Thu, 27 Jul 2023 10:47:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] USB:bugfix a controller halt error
Content-Language: en-US
To:     liulongfang <liulongfang@huawei.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230721100015.27124-1-liulongfang@huawei.com>
 <c3ab029f-f6ab-4b09-b2b5-1cc6a5370d0d@rowland.harvard.edu>
 <bfee90c1-a7ca-27e3-88f9-936f48cd2595@huawei.com>
 <bd440f1d-5ea4-485e-9924-433997765adc@rowland.harvard.edu>
 <77a8ecb4-8099-1826-abd8-4f080d80b07d@huawei.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <77a8ecb4-8099-1826-abd8-4f080d80b07d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::16) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|AM7PR04MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: b9743de3-3a6e-49f3-e492-08db8e7e236c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQe7iVuHlIDxXXLTh7rwLDUqIE0UfheJDk5a6IzNt5/KbXieGbrSwwdOu4V+qp0f4aXnsmcp3E+qbGckRv/CVdOJwMzgSvZ4PzCYPSfTXTwrEZO2l9fLXawGhnyv0Qe5LjdxQDrQPtfNHGaat53gCoefd3WWq/OVQ8oKkU2xxmuW9qSlH9bB/qNKDLr+o4KTMewkNl1M7ko5IKmvemJGbS8Nd5SS78+RPsGQ9tYM4ChTCuGavytDFfJTecMCC7ai3zGB54PGXJYTjY9gjIC/FY0zTOrptd9+12+PjhoIO1lxHpByR5mcTiYZ/9sZo/pBTg+Z4VxQkfWM6Wq3AdQ6PZ3mSBpX3cDejNFb9k2tzHwGjXlBYRWC4//R8FMJETxAd2yW9817lO69S8U7H6dqZq3ALrDFW/Ljg6uS45xy9Do1dI2hGqW2ugV/+VEmfxUwaEz1wqBI1aKVwH35r3cr6reVtSQ4ujaeOQ1bgq+9H9MuPOXXVz3BA2e87qHHIXE4q6YBSa56IC0Wm90eHvbSiISmO0utUZyU86SwaKmU7MgqR1FzBQn7oaYITGhiOs2OIfGYIBVOdFrTtskUFfu5kbPcb/UDQB8zNQgqMMatdeuqcv3PdzYppAXUDr3VQQizGRJxDVm9oL9TSUzMZO/SWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199021)(2906002)(86362001)(558084003)(186003)(31696002)(53546011)(6506007)(83380400001)(2616005)(38100700002)(478600001)(6666004)(6512007)(6486002)(36756003)(110136005)(66476007)(66556008)(66946007)(41300700001)(316002)(8676002)(5660300002)(8936002)(31686004)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnE0dTJQMkFjUlhOTnN5Q0dXOUN1dmdKOEdOSmdrc05DQnAvNFMzc1VnVFBj?=
 =?utf-8?B?aXRFZjBISkVkNWpvVm56eklSek5QN0pJdzFIOXRaTU8vZTg3VUlJR0krQzk2?=
 =?utf-8?B?TnNPOE1BcnU1ck8wVmVzRURMR0ZyZ0x6aW1qOE5vUmRxN2JRVWZpcXJmTzVM?=
 =?utf-8?B?Ynd1UWZoWGlmczF2QVc1d2NBd0xNdlZqQisrTmFvSUtZd2VpbUE0bTlhNDFl?=
 =?utf-8?B?UnhhL2paOFBkSURyWERURnYzWk5rMVRyWTVNdDk4RlcwQVRRMGVqYzkydWE3?=
 =?utf-8?B?a3hqekc1ZnZqWWZFdXdaUVNRWjdWWXBWOTJnajFhbnBHUFBEMkZvY3hkMWcy?=
 =?utf-8?B?YlZWYUVXalA0M2V3Y1NGKzdTelRtdFRVOEMyWHVZSFVrQWE2K3B4MGQ4Rzhv?=
 =?utf-8?B?aXorZjZib0lvQ0xwZ3lIOWlqTTRVdWJFbVJ1bTlJckJ2eVVlSU04R0tFS0k5?=
 =?utf-8?B?bDFKQ2kyOXlWQkdISXBuUDNJVGlIU1Y4WERWVko3MnF1OXB3WVhkdEcxUWpJ?=
 =?utf-8?B?ZWE3TkxBMGx4ZUkrT3FmRHhqbXlqaGZQMzg5L290ZDR0UUlWWndTQXpPZi8r?=
 =?utf-8?B?ampHMlpFNm04YkFIVmhHS3d5WnZuMklOVkdrK3BiWU9yYzQzYTBiMjFFTDNX?=
 =?utf-8?B?eElia3Z5ZFNzWW1IQVlNL01Sd2ViUDQyRm5BVlNvOW5DbkpyaUo1TXNjME93?=
 =?utf-8?B?WWNyQk4wcjVVdGR3T3NSb2JFckZEcWlxZnRTZnFPRUNubmh2eEZUT01ZeE4w?=
 =?utf-8?B?Y3ZvcFh5YmZJVForSVp4SzBneUhDNW5RcDdUaXVtWVNwY2QxRzViaUZOcVFF?=
 =?utf-8?B?S3QzSlhJblczaEJHckY0aHExOWxZbzkrQ1h1ejMzdmoyblovVHNZYk8vUlZI?=
 =?utf-8?B?VGd2KzR1WWNXWTNsV1BzaVJGVS92bFVyV25EOWRIdXEyazFsbzY5WmRxdGUz?=
 =?utf-8?B?eW03c1RnV3VyNHd1cHJlc2RvSzROU0FWTEcvaThjbDJZbGo5NWowV3AyNUgr?=
 =?utf-8?B?eTFOUFBXd1JUYVdqYkpYWU0zNlp4bHRkUFFRekh5dmZ0bE9uSXBEaUc4NGFK?=
 =?utf-8?B?aFFqQnNpazlubGlrWURTMzN4MWF6TkxBT0FuR2FLZ1JGbWNWYUNSdW00TXVn?=
 =?utf-8?B?NGpSb2NoWmxYZTRYR0FiNEFrSUtzWEo0Ym5Jelh0M1pIMHIwZy90WWh4dTBW?=
 =?utf-8?B?OXFGSXRMZlJaVk1SVjZTYVkxaEpabU1INnlIOEQ2enBmVGxoTnpKTi9QelZk?=
 =?utf-8?B?RUlRN3l6YkNRcnRwWEZtT3ZveVFORlhOTWgvaVhvMkxhRVZyUldNeEpBYllG?=
 =?utf-8?B?ZTlVNFRsVUo4dTNjbGVoMU1yNnVvUXhtRlgzWDhKSnlhRGRFWURPTXRySVlS?=
 =?utf-8?B?YmIwdHBpeWc1V2JUL2JLZjN4eHhBcG9QamdaVEdDM2hoRGt1dU5sclVLZUhU?=
 =?utf-8?B?emdnb0N4dXZIQW9TV21Pb0w0VTZJbk9tcHl5bEExK3drU0xtZVlNdCttakZX?=
 =?utf-8?B?TmdiTkMzY1dPbkhQWmJFRjR6WU96bk1QRHNOU21PaGtEOHRUYk1WYW5ONFRR?=
 =?utf-8?B?bjdrQ2g2YUltZlhVU1I5YThzSTRVUTk4WkZ6V2RlVjUxMHpuMFVIY3BtU1F6?=
 =?utf-8?B?K09IQXkwUG84S2Q4d2laK0pYVVZlVElEa25TMTREeHNJdVZrVGFTS1M0VDBT?=
 =?utf-8?B?d1VGamY3YUxycE1heS96TkRrS2RWNEhaYk9HQ3RWcW9hUFd4MVNybHJrMXNB?=
 =?utf-8?B?ejJQV1dCZFJlb3JtRnJuUHl3Wm9sMXdEUDRYLy9xVjhIKytJV2J0ZkVYemN5?=
 =?utf-8?B?TUl1SWVocllBSllvNmtabEVVOEhUWXo4MzNkRWRsUzZDM3E2SWQyWThMZG9q?=
 =?utf-8?B?bG5PY212VVJJaVpZVDBmOU9TY2k2TWp1dDZjdFJQT0c2M3JFUTFTUS9tT0Zn?=
 =?utf-8?B?Y3R4VWRucUk0VUkraS9QWnNmczQ0MWl3UWhYb3p3UnhnSzMyb3RXbU85SFVu?=
 =?utf-8?B?VzZGTnhtZ1M3bTBKZlhkZXc2NHhNbWNiNXc1T3c2bU42QWEzUnp1cXdkRFdM?=
 =?utf-8?B?ZUhPTk1ZOGVCMDFHQ3FYNWtJU1NNbTZDeVlNZWp2UGJxS3FucGQ2VWxNSzBS?=
 =?utf-8?B?WGxmbXQ1V0c4Y3ZQUTFjdGZmemdYRUJYYnplSUhNR2g3TUxBdk03RlZBS1Mr?=
 =?utf-8?Q?3wFMjucrkWcfBVSsAyJ0hNZX9yKadgBzPN468/qT3xJ5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9743de3-3a6e-49f3-e492-08db8e7e236c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 08:47:41.6098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FO/pH8qVgefoTuZLyP/FcTciTOwlAJbKtSM4tBrQEbH5kiNS7sWDp4hChb+ehCN6jZ0ssD7X53bW/DWYIfHBQ==
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

On 27.07.23 09:03, liulongfang wrote:

> This patch is only used to prevent data in the buffer from being accessed.
> As long as the data is not accessed, the kernel does not crash.

For how long? That information is cruical.

	Regards
		Oliver

