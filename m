Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F61E7C7BA8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 04:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjJMCjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 22:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJMCjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 22:39:15 -0400
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA698E0;
        Thu, 12 Oct 2023 19:39:10 -0700 (PDT)
Received: from Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:35e0:6a17:e457:4363:5917])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id EB2DB800056;
        Fri, 13 Oct 2023 10:38:51 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     pkshih@realtek.com
Cc:     kvalo@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, Chukun Pan <amadeus@jmu.edu.cn>
Subject: RE: [PATCH 1/1] wifi: rtw88: 8822b: disable call trace when write RF mode table fail
Date:   Fri, 13 Oct 2023 10:38:48 +0800
Message-Id: <20231013023848.10444-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6991a517301a46159085a0b06d43f319@realtek.com>
References: <6991a517301a46159085a0b06d43f319@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHk5DVh9CGklKTUIaGE0fSlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSBlIQUkYS0pBSE4eS0FNGkpMQR5PTkxBT0hNSEFOQkpMWVdZFhoPEhUdFF
        lBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8b26e6a6c9b03akuuueb2db800056
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PzY6Mgw*AzwwTQoUTFEzFksp
        AxAaChZVSlVKTUJMSk1PTEhJTE9MVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
        Sx5BSBlIQUkYS0pBSE4eS0FNGkpMQR5PTkxBT0hNSEFOQkpMWVdZCAFZQUlIQkw3Bg++
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ping-Ke

> Why do you think this trace is useless? As I see, there is more than one callers.
> Did you meet a real case it throws this trace? If yes, how about the frequency?

[  217.651858] ------------[ cut here ]------------
[  217.654813] write RF mode table fail
[  217.657434] WARNING: CPU: 2 PID: 3705 at 0xffffffffa03df3cb [rtw88_8822b@00000000bf0fde9e+0x35000]
[  217.662078] Modules linked in: rtw88_8822ce rtw88_8822c rtw88_8822be rtw88_8822b rtw88_8723de ...
[  217.704412] RIP: 0010:0xffffffffa03df3cb [rtw88_8822b@00000000bf0fde9e+0x35000]
...
[  217.737232] Call Trace:
[  217.738683]  0xffffffffa03df943 [rtw88_8822b@00000000bf0fde9e+0x35000]
[  217.740865]  0xffffffffa0385ab9 [rtw88_core@00000000a8d26f0d+0x1a000]
[  217.742993]  0xffffffffa0279111 [mac80211@000000003cb4b3bd+0x7b000]
[  217.745028]  0xffffffffa0239092 [cfg80211@00000000a951c4b5+0x46000]
[  217.751368]  ? 0xffffffffa0238de0 [cfg80211@00000000a951c4b5+0x46000]
[  217.773278] RIP: 0033:0x7ff0cdf8836c
...
[  217.789457] ---[ end trace 177712424e9eab4a ]---

As you can see this trace above, I don't think it's useful. This
trace throws up a lot of register values but doesn't point out why.
As long as I plug in the rtl8812bu or rtl8822be wifi modules, this
trace will be thrown every time when the rtw88 driver is loaded.

Thanks,
Chukun

-- 
2.25.1

