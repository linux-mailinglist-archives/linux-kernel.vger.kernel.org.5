Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF987F3A0C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbjKUXHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUXHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:07:43 -0500
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A516710C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:07:39 -0800 (PST)
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
        by cmsmtp with ESMTPS
        id 5W03rCqvkKOkL5ZqFrcdro; Tue, 21 Nov 2023 23:07:39 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 5ZqDrhQrw8KNv5ZqErGM1G; Tue, 21 Nov 2023 23:07:38 +0000
X-Authority-Analysis: v=2.4 cv=dp3Itns4 c=1 sm=1 tr=0 ts=655d383a
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=UQCjKeE4RevxmmGYuvgA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vD820syP1zvvXtGPBJjE2xHxK/aVSwdjeSIwA5RFRMo=; b=IKAGCiVocO0BiI6Tbe4DU564+U
        fPgbCtk+MdyxCl9LecY3jgkaZzJO7Y1dqjCv8Vsov+s/4+7Edk8CXr7uRHqSCFbtd6nG0GVMX2Uze
        tVz1qtrh8/AZOfLOMMINykkiJgiO7lzX66P4vElMoN29oznsIvtHfzwquPX+a12UrCocHFJWprn3i
        0cH451CVdJS95ssDs6QWFTKAjbSDPAGBJ6nRj5BDTNqog9bU25XeuDXEPtdy3pLaIfbh2z0DBrwVe
        B1EZexxyFw7Nqhv+w6dQsoKqW0XUNf3D5XJADpXACEJLUtasgZ6hrLEpVqd4KPfU24D0waAB2TYoq
        Cn6GUDOA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:50056 helo=[192.168.15.10])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r5ZqC-004ILL-2a;
        Tue, 21 Nov 2023 17:07:37 -0600
Message-ID: <9d3b74ec-4a92-4304-b8ee-5f70711666bc@embeddedor.com>
Date:   Tue, 21 Nov 2023 17:07:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warning after merge of the kspp-gustavo tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231122094739.38465ed3@canb.auug.org.au>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231122094739.38465ed3@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1r5ZqC-004ILL-2a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:50056
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEjAE3m+fIOPlSrgnyN7P13Uw2ggtS6OheBlDbqju5NqQuP19v0bnAtCtRbksG0WfhyL+pEqBCPdyc3M4O2/yeOym2Bz46l+1BQxZiVRoLLJ+HxOuTif
 2w037qS5TpZDmdAVWWMlGUN+EKBtW+4nzU+vnzmmdCW3WYNMuH8mL3WX1I+a3AAqTEwc0gbgX7jM7Z8qJAhMeRKsd+FTvcfCKEUrLmKwl98k9p8YDpzQ+bWk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/23 16:47, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kspp-gustavo tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> In file included from include/linux/string.h:295,
>                   from include/linux/bitmap.h:12,
>                   from include/linux/cpumask.h:12,
>                   from arch/x86/include/asm/paravirt.h:17,
>                   from arch/x86/include/asm/cpuid.h:62,
>                   from arch/x86/include/asm/processor.h:19,
>                   from arch/x86/include/asm/cpufeature.h:5,
>                   from arch/x86/include/asm/thread_info.h:53,
>                   from include/linux/thread_info.h:60,
>                   from arch/x86/include/asm/preempt.h:9,
>                   from include/linux/preempt.h:79,
>                   from include/linux/spinlock.h:56,
>                   from include/linux/mmzone.h:8,
>                   from include/linux/gfp.h:7,
>                   from include/linux/firmware.h:7,
>                   from drivers/net/wireless/realtek/rtw89/core.h:10,
>                   from drivers/net/wireless/realtek/rtw89/coex.h:8,
>                   from drivers/net/wireless/realtek/rtw89/coex.c:5:
> drivers/net/wireless/realtek/rtw89/coex.c: In function '_append_tdma':
> include/linux/fortify-string.h:57:33: warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
>     57 | #define __underlying_memcpy     __builtin_memcpy
>        |                                 ^
> include/linux/fortify-string.h:644:9: note: in expansion of macro '__underlying_memcpy'
>    644 |         __underlying_##op(p, q, __fortify_size);                        \
>        |         ^~~~~~~~~~~~~
> include/linux/fortify-string.h:689:26: note: in expansion of macro '__fortify_memcpy_chk'
>    689 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>        |                          ^~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/realtek/rtw89/coex.c:1585:17: note: in expansion of macro 'memcpy'
>   1585 |                 memcpy(&v3->tdma, &dm->tdma, sizeof(v3->tdma));
>        |                 ^~~~~~
> drivers/net/wireless/realtek/rtw89/core.h:2703:37: note: at offset [5714, 71249] into destination object 'ver' of size 8
>   2703 |         const struct rtw89_btc_ver *ver;
>        |                                     ^~~
> include/linux/fortify-string.h:57:33: warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
>     57 | #define __underlying_memcpy     __builtin_memcpy
>        |                                 ^
> include/linux/fortify-string.h:644:9: note: in expansion of macro '__underlying_memcpy'
>    644 |         __underlying_##op(p, q, __fortify_size);                        \
>        |         ^~~~~~~~~~~~~
> include/linux/fortify-string.h:689:26: note: in expansion of macro '__fortify_memcpy_chk'
>    689 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>        |                          ^~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/realtek/rtw89/coex.c:1579:17: note: in expansion of macro 'memcpy'
>   1579 |                 memcpy(v, &dm->tdma, sizeof(*v));
>        |                 ^~~~~~
> drivers/net/wireless/realtek/rtw89/core.h:2703:37: note: at offset [5710, 71245] into destination object 'ver' of size 8
>   2703 |         const struct rtw89_btc_ver *ver;
>        |                                     ^~~
> 
> Exposed by commit
> 
>    1b56c90018f0 ("Makefile: Enable -Wstringop-overflow globally")
> 
> This is with your tree on top of Linus' tree (and some fix patches but
> nothing that obviously touches anything relevent) and CONFIG_WERROR
> not set.

Stephen,

The fix for that shows up in linux-next already:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ca76817f4c4bbf8f98268772f4eeea8382a34bcd

Thanks for your help on this. :)
--
Gustavo






> 
