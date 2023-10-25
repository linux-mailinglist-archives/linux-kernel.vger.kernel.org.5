Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA92A7D6FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344370AbjJYOxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344353AbjJYOxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:53:44 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A99B0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:53:39 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 0253F100048;
        Wed, 25 Oct 2023 17:53:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0253F100048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1698245617;
        bh=AKaXrVnp5wObDD8weP6QzDDT60hIJPj/Pzxc3A40cz8=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=Qm8uRIch39gETLUoMno1qEfgwedy3+8mk3kU5F4msvXFeOpYwHtMFY9Ot4JIO0h5O
         RN5val+8Az8zAGmAXgIuLlV8sb5reovLSeRDHDpwxOxvqOGgkGzpIIqqYFBeHzkqn3
         DHP+m6cNuirFUF87ymPQeHBLers7sZxE3opDCSS3dpfjp17R5cfTdq3hJ4XyTO2SHb
         GsE/WLgoILy9LlLNaUKhZ8YJ+iXI1ZOIhyBvDUozULMOv6DLmYY/jXqSkVGJolVUqY
         1ZGKnfTL3QGJJJGkBtb/DVW4dgPl+eEv21YyosRCMliKvEyDOtOutzEMEs8NMk5/EO
         Z37rWMTm5jYAg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 25 Oct 2023 17:53:36 +0300 (MSK)
Received: from [192.168.1.146] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 25 Oct 2023 17:53:36 +0300
Message-ID: <06a5aebc-b90d-4c0b-b496-921e14452f9d@salutedevices.com>
Date:   Wed, 25 Oct 2023 17:53:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] jffs2: make cleanmarker support option
To:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>
CC:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Yu Zhe <yuzhe@nfschina.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        <kernel@sberdevices.ru>
References: <20231019073838.17586-1-mmkurbanov@salutedevices.com>
 <20231019073838.17586-3-mmkurbanov@salutedevices.com>
 <1258129392.18842.1697703134703.JavaMail.zimbra@nod.at>
 <3951ac21-a0a4-47b5-be94-edb0140c69a5@salutedevices.com>
 <cb1456a3fa874772a531c4885f0d204041ecf5bf.camel@infradead.org>
Content-Language: en-US
From:   Martin Kurbanov <mmkurbanov@salutedevices.com>
In-Reply-To: <cb1456a3fa874772a531c4885f0d204041ecf5bf.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180891 [Oct 25 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/10/25 13:08:00 #22292805
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, Thank you for reply.

On 23.10.2023 20:55, David Woodhouse wrote:
> On Mon, 2023-10-23 at 17:54 +0300, Martin Kurbanov wrote:
>> Hello Richard,
>>
>> On 19.10.2023 11:12, Richard Weinberger wrote:
>>>> This patch support for disable cleanmarker option. This is useful on
>>>> some NAND devices which entire OOB area is protected by ECC. Problem
>>>> fires when JFFS2 driver writes cleanmarker to some page and later it
>>>> tries to write to this page - write will be done successfully, but after
>>>> that such page becomes unreadable due to invalid ECC codes. This occurs
>>>> because the second write necessitates an update to ECC, but it is
>>>> impossible to do it correctly without block erase.
>>> Hmm, I miss an explanation why this change is correct and safe.
>>> You explain why the OOB area can't be used, okay. But you need to
>>> add more details on why you change is safe in terms of filesystem
>>> consistency.
>>  
>> If you disable the cleanmarker, the found clean block (filled with 0xff)
>> will be erased again (see fs/jffs2/scan.c#L162).
>> In my opinion, it is better to perform the block erasure again than to
>> not work with such a nand flash at all.
> 
> Erasing all unused blocks over and over again on every reboot/remount
> is going to destroy your flash quite quickly, surely?
> 
> I think you need to come up with a way to log the clean blocks (or
> erase requests) in the JFFS2 log itself.
> 
> Perhaps a 'block erase log' node type, which just contains a version#
> and a list of blocks which are currently being erased. You write it out
> before doing any erase operation. And then at *some* point after the
> erase completes (it doesn't need to be immediate) you write out a new
> one (which may be empty, or may list new blocks which are about to be
> erased).
> 
> On mount, we just need to re-erase any blocks which are indicated as
> being erased in the latest erase log node.

What if we don't erase the free blocks during mounting, but instead
erase them when a clean block is needed (before writing)?

-- 
Best Regards,
Martin Kurbanov
