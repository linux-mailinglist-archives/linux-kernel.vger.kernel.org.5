Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5005D7D3A18
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjJWOym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjJWOyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:54:41 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF6D9C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:54:38 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 7B2DE120005;
        Mon, 23 Oct 2023 17:54:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7B2DE120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1698072874;
        bh=xOCUtAXX6+TUytIqANgyBYP5UyxgzoCas0tmcIMHWrU=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=KdtIlp3kcbU6tFd1fXLXPH4TD7crI4X98cmKMRMBTvTJZj6anIpI0+gjWKe10UmqE
         /llSw9ox6ddLGfRLA2V1JWhgoZziCJlk7MGa1mtTxHEIFrIsYWcR/mzen5hx7X9VvS
         PCdSEpfrF0m8TXmleHBFxPfaydbek6mDdpiqU4xsgVgbEaoehBXpSMSPdgEWU1V67T
         YCzNtiug2JUam9xkpsBR9kDtxXlvNDpLAFzciMp2ixJIg+7ejTheXzi4hOY4E4iBHY
         hqc8EDSM2L14FmJzmjuD1BpfwOhtCEYDY+rRSko8I4tbomhGou87yuOlImexFiCMjJ
         //6cxudualiEg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon, 23 Oct 2023 17:54:34 +0300 (MSK)
Received: from [192.168.1.146] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 23 Oct 2023 17:54:33 +0300
Message-ID: <3951ac21-a0a4-47b5-be94-edb0140c69a5@salutedevices.com>
Date:   Mon, 23 Oct 2023 17:54:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] jffs2: make cleanmarker support option
To:     Richard Weinberger <richard@nod.at>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Yu Zhe <yuzhe@nfschina.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        <kernel@sberdevices.ru>
References: <20231019073838.17586-1-mmkurbanov@salutedevices.com>
 <20231019073838.17586-3-mmkurbanov@salutedevices.com>
 <1258129392.18842.1697703134703.JavaMail.zimbra@nod.at>
Content-Language: en-US
From:   Martin Kurbanov <mmkurbanov@salutedevices.com>
In-Reply-To: <1258129392.18842.1697703134703.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180810 [Oct 23 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 542 542 3d23828e213bab96daa5e52f9cef518f74e40214, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/23 12:16:00 #22264656
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Richard,

On 19.10.2023 11:12, Richard Weinberger wrote:
>> This patch support for disable cleanmarker option. This is useful on
>> some NAND devices which entire OOB area is protected by ECC. Problem
>> fires when JFFS2 driver writes cleanmarker to some page and later it
>> tries to write to this page - write will be done successfully, but after
>> that such page becomes unreadable due to invalid ECC codes. This occurs
>> because the second write necessitates an update to ECC, but it is
>> impossible to do it correctly without block erase.
> Hmm, I miss an explanation why this change is correct and safe.
> You explain why the OOB area can't be used, okay. But you need to
> add more details on why you change is safe in terms of filesystem
> consistency.
 
If you disable the cleanmarker, the found clean block (filled with 0xff)
will be erased again (see fs/jffs2/scan.c#L162).
In my opinion, it is better to perform the block erasure again than to
not work with such a nand flash at all.


> Beside of that, I don't think this should be kernel config option.
> Why not a mount option?

Agreed

-- 
Best Regards,
Martin Kurbanov
