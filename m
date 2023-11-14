Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326A97EA82D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 02:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjKNBYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 20:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKNBYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 20:24:18 -0500
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A341A8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 17:24:14 -0800 (PST)
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
        by cmsmtp with ESMTPS
        id 2ef5rGjLG6nOZ2iA1r01Up; Tue, 14 Nov 2023 01:24:13 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 2iA0raoXYqkaT2iA1rLz00; Tue, 14 Nov 2023 01:24:13 +0000
X-Authority-Analysis: v=2.4 cv=bY547cDB c=1 sm=1 tr=0 ts=6552cc3d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=n9Sqmae0AAAA:8 a=9VXzpLBs2m9k5JNODz8A:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=UmAUUZEt6-oIqEbegvw9:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=doC+LBatWPId0UyWA3LyXgIK5aM8JnD/Z9O3xHc/vRc=; b=K/VG0wXm1192jg2fa7ctTi3Yim
        HiR7beYT6gKdFz6CC0KWevnLLnCVcR0woSbwD0MoI/dSkgmgx7d67AHTDp8iWmow5RFNDtrOyvZ/5
        BTWy3hRnVKvtdDtSnAKWXx56EMj0cLF3nmwUykfCGDqNuAf47bXBwdpV+zSmib6l/aF+w10b8KRix
        GkaShNn8Hvhei72Y3X3ni+Oix95Fhd6B6iy+fU0ZI5XKC6W3sWKavoEhBjLfedco+YcBhRw6r+poL
        lpszecQS38OP9ZWpfcOyYaPUaw9DxFMe2efNOkYXUOi3KQ0UrQ6oRyLEPojef9aN2ZpU3VlKc+78V
        JJchBMUg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:48806 helo=[192.168.15.10])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r2iA0-0026pL-0p;
        Mon, 13 Nov 2023 19:24:12 -0600
Message-ID: <192fbb0d-f4f6-4384-98d8-b7422349dafb@embeddedor.com>
Date:   Mon, 13 Nov 2023 19:23:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: rtw89: coex: Fix -Wstringop-overflow warnings
 in _append_tdma()
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kalle Valo <kvalo@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
References: <ZVJ6lRCRaywGktxJ@work>
 <fd0d79048efa47868173c5fd8950b956@realtek.com>
Content-Language: en-US
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <fd0d79048efa47868173c5fd8950b956@realtek.com>
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
X-Exim-ID: 1r2iA0-0026pL-0p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:48806
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLc/rhTvd+Mub8bpMdFrh1RfBEuV8EY0w/fThYTfC0FuxlpKQkQ0EThkmKGOZOb3A8AuSehpBxAUdL3dLW0mgrssC0Frn0f9lWu3rgEPpHrW6XqyrGqu
 SjjGA7S/H6FzOyydVDCbG/vluLBSKZ3900IvKPgvpQ/TDSDHWxsLBhToQ45DUob6yw5+5DFXGOPp8ag9nxgzrv+T+jeObhWTElab1vJU+iMgKaED1wRw0asH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/23 18:37, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Gustavo A. R. Silva <gustavoars@kernel.org>
>> Sent: Tuesday, November 14, 2023 3:36 AM
>> To: Ping-Ke Shih <pkshih@realtek.com>; Kalle Valo <kvalo@kernel.org>
>> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org; Gustavo A. R. Silva
>> <gustavoars@kernel.org>; linux-hardening@vger.kernel.org
>> Subject: [PATCH][next] wifi: rtw89: coex: Fix -Wstringop-overflow warnings in _append_tdma()
>>
>> Copy a couple of structures directly, instead of using `memcpy()`.
>>
> 
> wireless-next has taken my patch [1] that is identical to yours.

Great!

I had mine ready on Oct 31, but I was waiting for the merge window to close
before sending it.

Glad to see that the issue is fixed already. :)

Thanks
--
Gustavo

> 
> [1] https://lore.kernel.org/all/20231102003716.25815-1-pkshih@realtek.com/
> 
> 
