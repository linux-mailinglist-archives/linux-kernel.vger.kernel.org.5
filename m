Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107C67887D1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244900AbjHYMx1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Aug 2023 08:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244899AbjHYMxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:53:08 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DB24D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:53:03 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37PCofC63009238, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37PCofC63009238
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Aug 2023 20:50:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 25 Aug 2023 20:51:05 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 25 Aug 2023 20:51:04 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b]) by
 RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b%5]) with mapi id
 15.01.2375.007; Fri, 25 Aug 2023 20:51:04 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     Genes Lists <lists@sapience.com>, Keith Busch <kbusch@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: Possible nvme regression in 6.4.11
Thread-Topic: Possible nvme regression in 6.4.11
Thread-Index: AQHZ0Otwxcnf+XYUokSPBeX1qZBAw6/3qhuAgAAtxICAAOyCoP//8+YAgAAJf4CAAj4x4w==
Date:   Fri, 25 Aug 2023 12:51:04 +0000
Message-ID: <fa82d9dcbe83403abc644c20922b47f9@realtek.com>
References: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
 <ZN050TFnKZ54LJ5v@kbusch-mbp.dhcp.thefacebook.com>
 <30b69186-5a6e-4f53-b24c-2221926fc3b4@sapience.com>
 <570d465a-7500-4b58-98f0-fd781c8740cc@sapience.com>
 <ZOZEwafA8+tknJNT@kbusch-mbp.dhcp.thefacebook.com>
 <7cf188d0-77b4-4e80-8da6-2045a7f29866@sapience.com>
 <180a2bbd2c314ede8f6c4c16cc4603bf@realtek.com>
 <903830f8-9f9a-4071-9ced-761a55018c5a@sapience.com>,<97cee217-e438-4fff-836a-186f59d6d256@sapience.com>
In-Reply-To: <97cee217-e438-4fff-836a-186f59d6d256@sapience.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [180.177.3.181]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org





>On 8/24/23 05:48, Genes Lists wrote:
>> On 8/23/23 22:44, Ricky WU wrote:
>>> Hi Gene,
>>>
>>> I can't reproduce this issue on my side...
>>>
>>> So if you only revert this patch
>>> (69304c8d285b77c9a56d68f5ddb2558f27abf406) can work fine?
>>> This patch only do is pull our clock request to HIGH if HOST need also
>>> can pull to LOW, and this only do on our device
>>> I don’t think this will affect other ports...
>>>
>>> BR,
>>> Ricky
>>
>> Thanks Ricky - I will test revering just that commit and report back.  I
>> wont be able to get to it till later today (sometime after 2pm EDT) but
>> I will do it today.
>>
>> FYI, i see one mpre report of someone experiencing same problem [1]
>>
>> gene
>>
>  > [1] https://bugs.archlinux.org/task/79439
>>
>>
>
>That commit was what was reverted in the last step of the git bisect -
>and indeed reverting that commit makes the problem go away and machine
>then boots fine.
>
>thanks
>
>gene

I think maybe it is a system power saving issue....
In the past if the BIOS(config space) not set L1-substate, our driver will keep drive low CLKREQ# when HOST want to enter power saving state that make whole system not enter the power saving state.
But this patch we release the CLKREQ# to HOST, make whole system can enter power saving state success when the HOST want to enter the power saving state, but I don't  know why your system can not wake out success from power saving stat on the platform

Ricky
    
