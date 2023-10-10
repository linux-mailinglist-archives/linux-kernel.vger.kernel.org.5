Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A565C7BFF80
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjJJOne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjJJOnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:43:31 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2066.outbound.protection.outlook.com [40.92.48.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63E2A9;
        Tue, 10 Oct 2023 07:43:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYd4sNjoN3X560NJQyroEBb/jz3rlUlTeokGuhvHztU8reGf7nTR0GE5YRHLUHZks2SA7T9FBfa4Vtp65qK4faidMvcMmPwqXuemlf4ghI3eWV5AN5tKAICUqq+rox4zTZ9V7N+1m7KYubDMXpvel/diXbfD1DyKGCmUmJCdkHlHfShz+bpccwvEpiROq5IUjVwQmvn2lpH5pZarx11QQzKiMXWduP2juhmP+6yYTsjTty9QT73yMHEAr15MJPTSkihNB9/RdNM3umClQnf4KSj/SJUVFByO6fe7yfSRpHqSfMTLogPEeSwHtI5MsE852ZFJk7wNWR5GOiIFxuua/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CiRzet86M3waOTG6euMILtBzH4M15ba1z4wl7TsSfs=;
 b=YW9iLt/YC81Uaw7xYsSnMje2CizXQNBJghtJ3f4h1KCwHsqlLyAbx7/UYOZCo5LUOzXi8RsdUjJki6X2PeIEZMQaIfK1P5lccDSvmYge8izx56Lwsx+GARFoVpGP1mi2jyZTkLaaM++BytXctEuav6AJDHnb492SgvAVcOG32EgSF5L2wSOwudgshipRR8NK9yRGk4rQLVbScjl0ylrE+mBekxtV/J8XtgBEsXn2w4tO5E1SfmdlKfw7079ZhlxlVvEbdca07zLnCvs7u7tKef7Kq1gavRMcM1Lm9FpDj7bd3AZTlHh6KoPQ7uz1MndKQSeWmbqxaj9XzPlby/flIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CiRzet86M3waOTG6euMILtBzH4M15ba1z4wl7TsSfs=;
 b=bdffpeyKAqRBxnaEdngsAEAeZl6Kt16gGufFnq7/+FaDNhq9bKmppVTEwCMn+jk8PpoCPyN4+T2Wr9+Ey5vrIDOdZgZ+ZuasDOA2hiHplGSH2oSos0z7nUbw3qboWANl52d2Dtihg4jHNFDejowe/PO7l31+gqFjr06JiYG1B9Ucgo98mzvjykMWlP/a/b6Uqi50O+FiYJIFiCVdo+37CxX65TL7iuVzSbHcUUvTcd89lm5KqGEEB9aNqeeWTe2PEq9onSF1zTftxyd+AWMndbcoIK5qC1v7tIyP0inBp2b5Qh9NDWD5dm0lGvI7mn5wWy3W68tvwFc34mH9DVLX6w==
Received: from AM9P192MB1267.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a7::7)
 by PR3P192MB0809.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:42::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 14:43:27 +0000
Received: from AM9P192MB1267.EURP192.PROD.OUTLOOK.COM
 ([fe80::628d:d050:3672:a203]) by AM9P192MB1267.EURP192.PROD.OUTLOOK.COM
 ([fe80::628d:d050:3672:a203%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 14:43:27 +0000
Message-ID: <AM9P192MB1267F74A5B04DBD6115D2CCBE8CDA@AM9P192MB1267.EURP192.PROD.OUTLOOK.COM>
Date:   Tue, 10 Oct 2023 20:13:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] Bluetooth: hci_conn_failed: Fixes memory leak
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com" 
        <syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
References: <AM9P192MB12672AA34A0480B522D23741E8C8A@AM9P192MB1267.EURP192.PROD.OUTLOOK.COM>
 <2023100727-passive-untidy-8df4@gregkh>
 <AM9P192MB1267C58F299DF86A5EEFE39EE8C8A@AM9P192MB1267.EURP192.PROD.OUTLOOK.COM>
 <CABBYNZLA2aTwRFqeDNLaT6Q4cytLB1e-q5oON=KVK1ts-0dz1w@mail.gmail.com>
From:   Yuran Pereira <yuran.pereira@hotmail.com>
In-Reply-To: <CABBYNZLA2aTwRFqeDNLaT6Q4cytLB1e-q5oON=KVK1ts-0dz1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [4VQ8P45z9/Gal4JTOUIu1jyhzQDyf4Su]
X-ClientProxiedBy: JN3P275CA0029.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:71::9)
 To AM9P192MB1267.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a7::7)
X-Microsoft-Original-Message-ID: <6200d327-6084-00d9-7679-759312449e8f@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB1267:EE_|PR3P192MB0809:EE_
X-MS-Office365-Filtering-Correlation-Id: 22406ee8-57b4-4c32-6aaf-08dbc99f42d8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: utpErWo+f9UCahh+xYEFNhirY/5stFEReUJeY1q3ParM2HBhRzZz2Q/89CE7EJZ37B/HZCN5dflKh3EpovruUd5DW6kIpjbDM4PlT8feJ7qsbrTDBpQ4DNzOtcYZONGwsvtbUhXrv+fp42GeqaaOGzNJIAy5WTAbX092BzvfcIekrjh4s/Uo0gLvqYX0E5jQ4R2ohQX8duE3JagQfaOSHrdm6ErwkKZ9JHFr7VqjhBAp7WrO217lNsHspUfKFNS7dOK38zscKW0/v0radyW+93T9jRc+xNEw6ICH+mYW/8DBc+lCUkbE5pkThBFOoxjGLYBwtMkdTcpI/aRuyBmPbfDsoX4NNIm1VKVmP+b0qsXe1VJZjd68cFZA7j+kuZAQEfTHQfrci9a+tVVEHut+0h+8fIonHVAq/S/v8GpsF7PnZA7aX4agZMGeE5cdIicU3/zTT3W2WqcLj/k0X+YhtYxgPgtTH6WzKH53xS+z0sOxeC0BWVYtFi+hKU1yyQ6ylnUcw1MJ1Qfw0geUsmE6WO4QYy2kiOv7dBAufSRN0ktk7Al/zlppSVqWdCmXOMR1
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmppM3hKcTRBV3pxNWl2dDhNdURubU5KOHFDNWh4M2JzUThMOGxveU02dG1F?=
 =?utf-8?B?TGFyWTh0T1ZubkhCSnUxL09Ca093czlBZEN4RFRhMUZhUUtlNkY5ZXdmN2xP?=
 =?utf-8?B?TDhSUU9ZUHNZVkI2aWlXNGxseERncEtTN0pFSmFsUXpQZ2JzZFlYSjk2RW5P?=
 =?utf-8?B?am00SUlrTVgwUXdjeE9FblZyL0ExaE0zRjIyY2NJakF2R3preDMrclZ0WnhC?=
 =?utf-8?B?b0FtbDEzeHZmUmhsUEd1cXN2Q0xFbzMyL2FlMnkzeUo4U3VIOTBRd2ZKSWVZ?=
 =?utf-8?B?SGMrdmtnVTRzNVJWZUtra0RrRUVIejVEd25ucEpIcHB6KzJDZkttV3Q5dmpj?=
 =?utf-8?B?eUIwRFBYeWw2Ym13RThObCtEeDJaSWNzOUszcUFpRjI4MXpZZ1NWTDNWVVdo?=
 =?utf-8?B?eTJCM083L09nYUpRZ0luRGJtR3VWOGFiY3RZZER0N2pxMkw5Y2hPK0dIWWp5?=
 =?utf-8?B?SXJSOEY0QUFYam56MjlORkNTRkd5N0w4enZyK0YxeEw3dm00aXdrM1hFWnQ5?=
 =?utf-8?B?Z3pMMHJ3SHA2dHNQOFgyVzRXeFRWbnV1S0FuUEREeUI1cHM0Vk9JR0E2aHFu?=
 =?utf-8?B?L1I4R3JHaG05TGF3WStXN08vWUtuVVlESzRYbVpkWld5VTB0eTJOWVMxd3ZK?=
 =?utf-8?B?ak1sdVhBN1dRUkRnM2Z4eDZPaGNWazhTWmh3R3J0cHlSeFZ2bXdRT3VvYVlG?=
 =?utf-8?B?Q09EUWdmN2gvanNoYkxLUGdySWlyM3d2NEd4M2dHcUY5OHZNa2tIOGFWWFR3?=
 =?utf-8?B?TjltNDNsMERWaXViTU8wSTNvckFUME04ek5wZ2ltNklrd0VaMFdCWVRUTlR4?=
 =?utf-8?B?TmhFUnl1WWwwTWJlWit5aDhueG1wL2VUamJrMGtKWDVxdGZ2MXdPY3JTYnpt?=
 =?utf-8?B?b1JKc3oyaEVmZGVXUHpnRWdoamRzYlZDaWtzL1FRZXIzK0VmTmFMbThiVlU4?=
 =?utf-8?B?THJpWEFkdlV2N3dRR3RLTzFtWEFlSFNUWFhkUW9rZUpJbkRMMjNLM2NUU2J5?=
 =?utf-8?B?Q2VsU2RkdkxXRXAvRW82ckY1MHZ5SWY3UDh6NTdhZi9wK2tjOUQya1hKWEhm?=
 =?utf-8?B?SEFleElNWFV5aC9LbUt2cmtaUnpHTGdrT3JPKy9pUlpaOVI2ajFIcHQ1Z2pO?=
 =?utf-8?B?bXM4b1RLWGwvcThUKzViMlgvSjlVM0NlWWtPSXUwTHIyQXBQbGh2OTlUdDBK?=
 =?utf-8?B?V0hUdk1MYkJsWjhsalNSajZvcitMN3JSUGtkK2VDYUtrRy92dTB4bjlmeW1R?=
 =?utf-8?B?eUxSV3RSRldGN3VhN2cySUNYb2FnampsRlhVMlVjV2k3WEpnTGpkY0tuTWhM?=
 =?utf-8?B?V2pwRHZTZWN3VVIwV05tOXJsb1Zrckhnb3BRTjJQQlpnaUpwcXBLV1lEK0VF?=
 =?utf-8?B?ZGZZRm16Qnh1V1lma2M4TnNvdmtkK09Kbi8xRWxPM0sxNUxnZWp1STVRZHE2?=
 =?utf-8?B?UzA5MEdKNWlraGhHa1luQzJDQmQ1bnRMTlhCZWdVUzFwVmdZUWMvUnRaTnB6?=
 =?utf-8?B?K3dsNXZlS0NRUDA2UHpsN0Q3UEttcHIremc4QnNHTWFKaXVac0pHaDg4dTFT?=
 =?utf-8?B?YXB2RUVqZ1lqYzZtN0JwRzk0WUhnU3NsYytTMXZtWEFWc0N5bkxZV3AwZjBU?=
 =?utf-8?Q?evL2oiaE31R4OtiH2GcqETRVLlOvuXwXjqOeW5r8HIqU=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-fb43a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 22406ee8-57b4-4c32-6aaf-08dbc99f42d8
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1267.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:43:27.4555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P192MB0809
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Luiz,

Thanks for the reply.

I just took another look at hci_abort_conn_sync which is where 
hci_conn_failed is being called, and as you suggested, hci_conn_failed, 
is in fact being called with a status 0. So my previous patch might in 
fact be inaccurate.

By the time hci_conn_failed is called, the value of "err" within 
hci_conn_abort_sync can also be 0, so using bt_status(err) as status is 
not going to solve the issue.
I am considering using one of the HCI_ERROR_ values but not exactly sure 
which is the most appropriate in this specific situation.

Perhaps HCI_ERROR_UNSPECIFIED ???

Something like:
- hci_conn_failed(conn, reason);
+ hci_conn_failed(conn, HCI_ERROR_UNSPECIFIED);

So, would you suggest going with this solution, or do you think the 
issue might be originating earlier in the call sequence and I should pay 
more attention to conn->reason?

Thanks,

Yuran Pereira

On 10/10/23 01:20, Luiz Augusto von Dentz wrote:
> Hi Yuran,
>
> On Sat, Oct 7, 2023 at 10:39 AM Yuran Pereira <yuran.pereira@hotmail.com> wrote:
>> Hello Greg,
>> My apologies, I just noticed that my patch is based on the mainline tree. I'll re-submit one based on the Bluetooth tree and I'll ensure to include the commit id that it's fixing.
>>
>> Thanks,
>> Yuran Pereira
>> ________________________________
>> De: Greg KH <gregkh@linuxfoundation.org>
>> Enviado: 7 de outubro de 2023 11:41
>> Para: Yuran Pereira <yuran.pereira@hotmail.com>
>> Cc: marcel@holtmann.org <marcel@holtmann.org>; johan.hedberg@gmail.com <johan.hedberg@gmail.com>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-bluetooth@vger.kernel.org <linux-bluetooth@vger.kernel.org>; luiz.dentz@gmail.com <luiz.dentz@gmail.com>; syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com <syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com>; linux-kernel-mentees@lists.linuxfoundation.org <linux-kernel-mentees@lists.linuxfoundation.org>
>> Assunto: Re: [PATCH] Bluetooth: hci_conn_failed: Fixes memory leak
>>
>> On Sat, Oct 07, 2023 at 05:09:01PM +0530, Yuran Pereira wrote:
>>> The hci_conn_failed() function currently calls hci_connect_cfm(), which
>>> indirectly leads to the allocation of an l2cap_conn struct in l2cap_conn_add().
>>> This operation results in a memory leak, as the l2cap_conn structure
>>> becomes unreferenced.
>>>
>>> To address this issue and prevent the memory leak, this patch modifies
>>> hci_conn_failed() to replace the call to hci_connect_cfm() with a
>>> call to hci_disconn_cfm().
> I suspect this is not quite right, hci_disconn_cfm is called when a
> disconnection has been requested, hci_connect_cfm is correct here
> since it is meant to notify the result of connection request procedure
> so I can only assume that the culprit here is that hci_conn_failed is
> called with status 0 which is invalid and needs fixing.
>
>>> Reported-by: syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com
>>> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
>>> ---
>>>   net/bluetooth/hci_conn.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> What commit id does this fix?
>>
>> thanks,
>>
>> greg k-h
>
>
