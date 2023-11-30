Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462FD7FFAA5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346788AbjK3TBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjK3TBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:01:06 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92083194;
        Thu, 30 Nov 2023 11:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1701370851; x=1701975651; i=deller@gmx.de;
        bh=ooHn1Zil5tkkFFQbJhhHFi1FB1rr4PIqPkGwIIU10LA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=NyM/qDdLoCO74PomviXpvI0USb5KdWPDXJ6Vqu612Wq1ZNmiwi20IzkXGrHTmEcA
         2mEkiIXNZNkeU+E4554F7kSE1xDLeYAla8f9UDgjOJgJhzEEKqNR5IFPPYTxVgIFU
         aek4PwKVeImHsc5xXoqaA/h5z+3LCjP/Jusi5qvOy9L5TvzopMFkQBiKjow/4WAb+
         0CL2aUdryUDg18M+Zp89iq78ekiOC6q2w8IbtQKelmxmR7zw4/Z87wmv9/fcIM4xF
         xCQ2px2m83jHDuVBSifgjPnEi+aOGJhWJn9jCLWXtunplbNPJCfMjJu/ehIvGFy0v
         56d1SBrBryJCcqTM4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.154.31]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9uK-1qrepl2DPG-00IChc; Thu, 30
 Nov 2023 20:00:51 +0100
Message-ID: <61579b26-88b5-428a-b818-5021e528471d@gmx.de>
Date:   Thu, 30 Nov 2023 20:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] parisc: Reduce size of __bug_table[] on 64-bit kernel
 by half
To:     Guenter Roeck <linux@roeck-us.net>, deller@kernel.org
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231124144158.158993-1-deller@kernel.org>
 <20231124144158.158993-16-deller@kernel.org>
 <ef74368d-1fd6-4fd0-81dc-bcf04892cc13@roeck-us.net>
Content-Language: en-US
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ef74368d-1fd6-4fd0-81dc-bcf04892cc13@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UwWBXqDUUqtUN7oWJKr1Y6S0zBbnbzKbhwwt/mTbEAGcS7AQ6zV
 SfpPfaIh66IG5dguQZE7TYXlYxNnRTeOqSuDS7ZdvtmcY/EWWjMqKnzJVHnXU6GLpHqq9PF
 6rwJHN/H33wOoW4XJRw8nRXO0qXT9bz5pb0JlQJ7InxBArZsN+Dzjkr/BYsU5ojzQME973X
 ZRwQ7+c574qfRFQOggqtg==
UI-OutboundReport: notjunk:1;M01:P0:xUm4U2HacQQ=;PNpsCPjYNrK6T8+9cVtXOfKQDT4
 zDS+ETQ0BEyuSE47q44OcwdHUxKGDKXovPJAb4iRvgNzntUHBd4Md+kJK/6Ikl5JfQNMkV+Wh
 ayLIMLS4x7Pst2ADKVfPhgEllShAzouVV52SX/Q/bAJW9QTEeCmODmoy649hjNIlwir3C8ARY
 Dv0zL3ar+2EsFpZ0Eg5L9vo6m96IoMj7+yIPQdub9YyWUUEZiXatxMM+V1mi810+iCaFv9ZwR
 N14NWCTNvTZyHT50s70zBZSU+iXRWm7077C0en6ftfydhjUnyYl3OiPkA2+1YgcK/tHW39Hud
 UdJPZMrTorTcBAz/oLMCQLrT2xHamT+cVkOxGFp1an6yb6H8oAJSkKpBIo7dkL9n9PJJ5pHmI
 TwZ0yHt/IGBZNixy4pJ9LiRQbQoHQULOdUxmTvhFLGVpzrBlM+b9bPUmq3oXF569x0SABMbO/
 5t6RilikgyUCKlCBWv96tBvqvwgCndUXKoWPzLvbIZNrgnCLucfgNT2H1nWXQcoIIpztp50ee
 Q/WipL5NE6QsCm5G4fiWRLmCrvXATXttMrxIub8iBAPbgiaT/QZK48Lwv1soiSRiWEIk6rELe
 UwP82rm4m8QIr/IV8FkY6Msz0eMROBrslTfrA7yMW4ckGZLSHlkGFAVwGZQCKcMbGiwyABz6M
 EEAepg/yMMJPiDXVrpdiLCR0Ve/uEpYvcSPNnyY+FnS0Cz86ZawXSjpHsyags/4gaqwyD4lMn
 NkMRvGK1s8nRMH1p4R+ALoa403HYFkdcs+n5SimDJfkZI3cgLX6ROzBcMkdPBgadhW3VlqVha
 U5Y9OrTWYC7zp7Uqbwst0A3fTwsiHkgsIn+5dYgBXqEHyTl3/uGEriQQTfwekNW9VQPl3N2XA
 rKUgrhz8TVuOYT5ncCXINes8c14iI6Lx57RkvDDyP07WqI53hDVsAVO6MuvcZEnWdQYR4p1Lu
 yM1CcQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/23 18:30, Guenter Roeck wrote:
> On Fri, Nov 24, 2023 at 03:41:13PM +0100, deller@kernel.org wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> Enable GENERIC_BUG_RELATIVE_POINTERS which will store 32-bit relative
>> offsets to the bug address and the source file name instead of 64-bit
>> absolute addresses. This effectively reduces the size of the
>> __bug_table[] array by half on 64-bit kernels.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>
> With this patch in mainline, parisc:tinyconfig fails to build.
>
> ecurity/commoncap.c: In function 'cap_capset':
> arch/parisc/include/asm/bug.h:71:17: error: invalid 'asm': operand numbe=
r out of range
>     71 |                 asm volatile("\n"                              =
         \
>        |                 ^~~
>
> and many similar errors. Bisect log attached.

Yes, problem was reported already and fix is in my for-next git tree:

https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/co=
mmit/?h=3Dfor-next&id=3D487635756198cad563feb47539c6a37ea57f1dae

Thanks!
Helge
